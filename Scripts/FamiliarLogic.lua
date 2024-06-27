function ActivateFamiliar( eventSource, args )
	local unitData = FamiliarData[args.Name]
	local newUnit = DeepCopyTable( unitData )
	newUnit.ObjectId = args.Id
	if args.OverwriteSelf ~= nil then
		OverwriteSelf( newUnit, args.OverwriteSelf )
	end
	Activate({ Id = newUnit.ObjectId })
	thread( SetupUnit, newUnit, CurrentRun, args )
end


function AssignFamiliarKits( eventSource, args )

	MapState.FamiliarKitIds = GetIdsByType({ Name = "FamiliarKit" })
	table.sort( MapState.FamiliarKitIds )
	MapState.FamiliarKits = {}

	LoadPackages({ Names = FamiliarOrderData })

	for index, familiarName in ipairs( FamiliarOrderData ) do

		local familiarData = FamiliarData[familiarName]
		local familiarKit = DeepCopyTable( ObstacleData.FamiliarKit )
		local kitId = MapState.FamiliarKitIds[index]
		if IsGameStateEligible( CurrentRun, familiarData.GameStateRequirements ) then
			-- Unlocked
			AttachLua({ Id = kitId, Table = familiarKit })
			familiarKit.Name = familiarName
			familiarKit.ObjectId = kitId
			MapState.FamiliarKits[kitId] = familiarKit

			GameState.FamiliarStatus[familiarName] = GameState.FamiliarStatus[familiarName] or {}
			GameState.FamiliarStatus[familiarName].RestTicks = GameState.FamiliarStatus[familiarName].RestTicks or 0

			LoadPackages({ Name = familiarName })

			local familiar = DeepCopyTable( familiarData )
			if args.OverwriteSelf ~= nil then
				OverwriteSelf( familiar, args.OverwriteSelf )
			end	
			familiar.BlocksLootInteraction = false
			local destinationId 
			if GameState.EquippedFamiliar == familiarName then
				local spawnNearId = CurrentRun.NextHeroEndPoint or eventSource.HeroEndPoint
				if CurrentRun.StoredHeroLocation ~= nil then
					spawnNearId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
					Teleport({ Id = spawnNearId, OffsetX = CurrentRun.StoredHeroLocation.X, OffsetY = CurrentRun.StoredHeroLocation.Y })
				end
				destinationId = GetClosest({ Id = spawnNearId, DestinationName = "SpawnPoints" })
				familiar.LastSpawnPointId = destinationId
				MapState.FamiliarUnit = familiar
			else
				destinationId = kitId
				familiar.DisableAIWhenReady = true
			end
			familiar.ObjectId = SpawnUnit({
					Name = familiar.Name,
					Group = "Standing",
					DestinationId = destinationId })
			thread( SetupUnit, familiar, CurrentRun )
	
			familiar.KitId = kitId
			familiarKit.Unit = familiar
			if familiar.KitAngle ~= nil then
				SetGoalAngle({ Id = familiar.ObjectId, Angle = familiar.KitAngle, CompleteAngle = true })
			end
			if GameState.EquippedFamiliar == nil then
				PlayStatusAnimation( familiar, { Animation = "StatusIconWantsToTalkImportant" } )
			end
		else
			-- Locked
			--UseableOff({ Id = kitId })
			SetAlpha({ Id = kitId, Fraction = 0.0 })
			SetThingProperty({ Id = kitId })
			SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = kitId })
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = kitId })
		end

	end

	UpdateFamiliarKits( { DoEquip = true } )
end

function UpdateFamiliarKits( args )
	if MapState.FamiliarKits == nil then
		return
	end

	args = args or {}

	for kitId, familiarKit in pairs( MapState.FamiliarKits ) do
		if GameState.EquippedFamiliar == familiarKit.Name then
			-- Equipped
			local familiar = familiarKit.Unit
			if args.DoEquip then
				UnequipFamiliar( nil, { IgnoreAI = true } )
				EquipFamiliar( familiar, { FamiliarName = familiar.Name, EnableAI = false, } )
			end
			RemoveInteractBlock( familiarKit , "UpdateFamiliarKits" )
			DebugPrint({ Text = " familiarKit.Unit.ObjectId = "..familiarKit.Unit.ObjectId })
			familiarKit.OnUsedFunctionName = "UseFamiliarUnequip"
			familiarKit.Unit.OnUsedFunctionName = nil
			if CanReceiveGift( familiarKit.Unit ) then
				RemoveInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			else
				AddInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			end
		end
	end

	for kitId, familiarKit in pairs( MapState.FamiliarKits ) do
		if GameState.EquippedFamiliar ~= familiarKit.Name then
			-- Unequipped
			AddInteractBlock( familiarKit, "UpdateFamiliarKits" )
			if familiarKit.Unit ~= nil then
				RemoveInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			end
			--familiarKit.Unit.OnUsedFunctionName = "UseFamiliar",
			local familiarStatus = GameState.FamiliarStatus[familiarKit.Name]
			if familiarStatus ~= nil then
				if familiarStatus.RestTicks > (familiarKit.TickForRested or 0) then
					FamiliarRestedPresentation( familiarKit )
				elseif familiarStatus.RestTicks > 0 then
					FamiliarRestingPresentation( familiarKit )
				end
			end
		end
	end

end


function UseFamiliar( familiar, args, user )
	if familiar.Name == GameState.EquippedFamiliar then
		-- Already equipped
		return
	end
	local kit = MapState.FamiliarKits[familiar.KitId]
	AddInteractBlock( kit, "UseFamiliar" )
	AddInteractBlock( familiar, "UseFamiliar" )
	StopStatusAnimation( familiar )	
	UnequipFamiliar( user, args )
	EquipFamiliar( familiar, { FamiliarName = familiar.Name, EnableAI = true, } )
	UpdateFamiliarKits()
	SelectCodexEntry( familiar.Name )
	EquipFamiliarPresentation( familiar )
	wait( 1.0 )
	RemoveInteractBlock( kit, "UseFamiliar" )
	RemoveInteractBlock( familiar, "UseFamiliar" )
end

function UseFamiliarUnequip( button, args, user )
	AddInteractBlock( button, "UseFamiliarUnequip" )
	AddInteractBlock( button.Unit, "UseFamiliarUnequip" )
	UnequipFamiliarPresentation( args )
	UnequipFamiliar( user, args )
	UpdateFamiliarKits()
	wait( 1.0 )
	RemoveInteractBlock( button, "UseFamiliarUnequip" )
	RemoveInteractBlock( button.Unit, "UseFamiliarUnequip" )
end

function UnequipFamiliar( user, args )
	if GameState.EquippedFamiliar == nil then
		return
	end
	args = args or {}
	local unit = user or CurrentRun.Hero
	if FamiliarData[GameState.EquippedFamiliar].TraitName then
		local traitName = FamiliarData[GameState.EquippedFamiliar].TraitName 
		RemoveTrait( unit, traitName )
		for i, unlockName in ipairs( ScreenData.FamiliarShop.ItemOrder ) do
			if GameState.FamiliarUpgrades[unlockName] then
				local shopItemData = FamiliarShopItemData[unlockName]
				if shopItemData ~= nil and shopItemData.FamiliarName == GameState.EquippedFamiliar then
					if shopItemData.TraitName ~= nil then
						RemoveTrait( unit, shopItemData.TraitName )
					end
				end
			end
		end
		if traitName == "LastStandFamiliar" then
			RemoveLastStand( unit, "LastStandFamiliar" )
			unit.MaxLastStands = unit.MaxLastStands - 1
			UpdateLifePips( unit )
		end
		local unequippedKit = nil
		local kitId = nil
		for kitId, familiarKit in pairs( MapState.FamiliarKits ) do
			if familiarKit.Name == GameState.EquippedFamiliar then
				unequippedKit = familiarKit
			end
		end
		if unequippedKit ~= nil and not args.IgnoreAI then
			local familiar = unequippedKit.Unit
			familiar.AIDisabled = true
			familiar.DisableAIWhenReady = true
			familiar.OnUsedFunctionName = "UseFamiliar"
			thread( ReturnFamiliarToKit, familiar, unequippedKit, args )
		end
	end
	GameState.EquippedFamiliar = nil
end

function ReturnFamiliarToKit( familiar, unequippedKit, args )
	AddInteractBlock( familiar, "AIDisabled" )
	familiar.AINotifyName = "OnStopped"..familiar.ObjectId
	NotifyOnStopped({ Id = familiar.ObjectId, Notify = familiar.AINotifyName, Timeout = 3.0 })
	waitUntil( familiar.AINotifyName, familiar.AIThreadName )
	MoveFamiliarToLocation( familiar, { Id = unequippedKit.ObjectId, MinLeapDistance = 100, MaxLeapDistance = 9999, SuccessDistance = 48 } )
	RemoveInteractBlock( familiar, "AIDisabled" )
end

function EquipFamiliar( familiar, args )

	if args.FamiliarName == nil then
		return
	end

	GameState.EquippedFamiliar = args.FamiliarName
	GameState.FamiliarResourceSpawnChance = FamiliarData[GameState.EquippedFamiliar].BaseResourceSpawnChance + GetFamiliarBonusResourceSpawnChance( GameState.EquippedFamiliar )
	MapState.FamiliarUnit = familiar

	if familiar ~= nil then
		CheckObjectiveSet( familiar.EquipObjective or "CheckFamiliarInfoPrompt" )
	end
	local traitName = FamiliarData[GameState.EquippedFamiliar].TraitName 
	MapState.PriorityTraitInfoHighlight = traitName
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	AddTraitToHero({ TraitData = traitData, SkipNewTraitHighlight = args.SkipNewTraitHighlight })
	if not CurrentRun.Hero.IsDead then
		CurrentRun.TraitCache[traitName] = CurrentRun.TraitCache[traitName] or 1
	end

	for i, unlockName in ipairs( ScreenData.FamiliarShop.ItemOrder ) do
		if GameState.FamiliarUpgrades[unlockName] then
			local shopItemData = FamiliarShopItemData[unlockName]
			if shopItemData ~= nil and shopItemData.FamiliarName == GameState.EquippedFamiliar then
				if shopItemData.TraitName ~= nil then
					local upgradeTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = shopItemData.TraitName })
					AddTraitToHero({ TraitData = upgradeTraitData, SkipNewTraitHighlight = args.SkipNewTraitHighlight })
				end
				if shopItemData.IncreaseTraitLevel ~= nil then
					local upgradeTraitData = CurrentRun.Hero.TraitDictionary[shopItemData.IncreaseTraitLevel][1]
					if upgradeTraitData ~= nil then
						IncreaseTraitLevel( upgradeTraitData, 1 )
					end
				end
				if shopItemData.OverwriteSelf ~= nil then
					OverwriteSelf( familiar, shopItemData.OverwriteSelf )
				end
			end
		end
	end

	if traitName == "LastStandFamiliar" then
		AddLastStand({
			Name = "LastStandFamiliar",
			Icon = "ExtraLifeCatFamiliar",
			InsertAtEnd = true,
			IncreaseMax = true,
			HealAmount = GetTotalHeroTraitValue( "FamiliarLastStandHealAmount" )
		})
	end

	if args.EnableAI and familiar ~= nil then
		familiar.OnUsedFunctionName = nil
		ReenableFamiliar( familiar, { Equipping = true } )
	end
end

function FamiliarSetup( source, args )

	if GameState.EquippedFamiliar == nil then
		return
	end

	if args.WaitForInput then
		local notifyName = "FamiliarWaitForInput"
		NotifyOnInputAllowed({ Notify = notifyName })
		waitUntil( notifyName )	
	end

	wait( args.Wait )
	
	LoadPackages({ Name = GameState.EquippedFamiliar })

	local familiar = DeepCopyTable( FamiliarData[GameState.EquippedFamiliar] )
	
	familiar.BlocksLootInteraction = false
	familiar.BlockVictoryPresentation = false
	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "SpawnPoints" }, DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }) })
	local spawnOffset = {}
	if spawnPointId <= 0 or GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId }) > 600 then
		local angleBetween = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId })
		spawnOffset = CalcOffset( math.rad( angleBetween ), 150 )
		spawnPointId = CurrentRun.Hero.ObjectId
	else
		familiar.LastSpawnPointId = spawnPointId
	end
	familiar.ObjectId = SpawnUnit({ Name = familiar.Name, Group = "Standing", DestinationId = spawnPointId, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })
	thread( SetupUnit, familiar, CurrentRun, args )
	familiar.OnUsedFunctionName = nil
	AddInteractBlock( familiar, "InRun" )

	MapState.FamiliarUnit = familiar
	--[[
	if CurrentRun.CurrentRoom.Encounter ~= nil then
		local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name] or CurrentRun.CurrentRoom.Encounter
		if not encounterData.NeverDelayStartFamiliar and encounterData.DelayedStart and not CurrentRun.CurrentRoom.Encounter.Completed then
			familiar.DisableAIWhenReady = true
		end
	end
	]]

	local familiarModifiers = GetHeroTraitValues( "FamiliarDataModifiers" )
	for i, modifierData in pairs( familiarModifiers ) do
		if modifierData.AddOutgoingDamageModifiers then
			for s, damageModifierData in pairs( modifierData.AddOutgoingDamageModifiers ) do
				AddOutgoingDamageModifier( familiar, damageModifierData )
			end
		end
		if modifierData.AddOutgoingCritModifiers then
			for s, damageModifierData in pairs( modifierData.AddOutgoingCritModifiers ) do
				AddOutgoingCritModifier( familiar, damageModifierData )
			end
		end
		if modifierData.SpawnEffects ~= nil then
			for k, effectData in pairs( modifierData.SpawnEffects ) do
				effectData.Id = familiar.ObjectId
				effectData.DestinationId = familiar.ObjectId
				ApplyEffect( effectData )
			end
		end
	end

	for i, upgradeName in ipairs( ScreenData.FamiliarShop.ItemOrder ) do
		if GameState.FamiliarUpgrades[upgradeName] then
			local upgradeData = FamiliarShopItemData[upgradeName]
			if upgradeData ~= nil and upgradeData.FamiliarName == GameState.EquippedFamiliar then
				if upgradeData.OverwriteSelf ~= nil then
					OverwriteSelf( familiar, upgradeData.OverwriteSelf )
				end
			end
		end
	end

	-- Reset reset on being used in a run
	local familiarStatus = GameState.FamiliarStatus[familiar.Name]
	if familiarStatus ~= nil then
		familiarStatus.RestTicks = 0
	end
end

function BackPlayerUp(user, source, args )
	args = args or {}
	local offset = CalcOffset( math.rad(GetAngleBetween({ Id = source.ObjectId, DestinationId = user.ObjectId })), args.Distance or 120 )
	local searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })

	if not IsLocationBlocked({ Id = searchOffsetId }) then
		local notifyName = "PlayerBackUp"
		Move({ Id = user.ObjectId, DestinationId = searchOffsetId, SuccessDistance = 150 })
		NotifyOnStopped({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName })
		waitUntil( notifyName )
	end

	Destroy({ Id = searchOffsetId })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })
end

function MoveFamiliarToLocation( familiar, args )
	args = args or {}
	if familiar == nil then
		return
	end
	
	if familiar.MoveFunctionName ~= nil then
		CallFunctionName( familiar.MoveFunctionName, familiar, args )
		return
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	local notifyName = "FamiliarNotify"		
	familiar.AIDisabled = true
	familiar.DisableAIWhenReady = true
	local collideCache = GetUnitDataValue({ Id = familiar.ObjectId, Property = "CollideWithObstacles" })
	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = false })
	Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance })
	NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = 120, Notify = notifyName, Timeout = 2 })
	waitUntil( notifyName )	
	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = collideCache })
end

function FrogFamiliarMoveToLocation( familiar, args )
	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	FrogLeap( familiar, 
			MergeTables( GetWeaponAIData( familiar ),
				{ 
					LeapPrepareTime = 0.5,
					LeapRecoveryTime = 0.3,
				}), 
				{
					Id = targetLocation,
					MinLeapDistance = args.MinLeapDistance,
					MaxLeapDistance = args.MaxLeapDistance,
				}
			)
end

function CatFamiliarMoveToLocation( familiar, args )
	killTaggedThreads( familiar.AIThreadName )
	familiar.AIBehavior = nil
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = familiar.DefaultAIData.RecruitAnimation, DestinationId = familiar.ObjectId })
	familiar.RecruitAnimationId = nil
	familiar.ReadyToAttack = false
	wait( 1.0 )
	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	local notifyName = "FamiliarNotify"
	familiar.AIDisabled = true
	familiar.DisableAIWhenReady = true
	local collideCache = GetUnitDataValue({ Id = familiar.ObjectId, Property = "CollideWithObstacles" })
	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = false })
	Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance })
	NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = 120, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )	
	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = collideCache })
	wait( 1.0 )
	SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
	wait( 3.0 )
end

function ReenableFamiliar( familiar, args )
	args = args or {}
	if not familiar.AIDisabled then
		-- Only enable if previously disabled
		return
	end
	familiar.DisableAIWhenReady = false
	familiar.AIDisabled = false
	SetupAI( familiar, args )
end

function GetFamiliarBonusResourceSpawnChance( familiarName )
	local bonusChance = 0
	for unlockName, value in pairs( GameState.FamiliarUpgrades ) do
		local shopItemData = FamiliarShopItemData[unlockName]
		if shopItemData ~= nil and shopItemData.FamiliarName == familiarName and shopItemData.BonusResourceSpawnChance then
			bonusChance = bonusChance + shopItemData.BonusResourceSpawnChance
		end
	end
	local familiarData = FamiliarData[familiarName]
	local familiarStatus = GameState.FamiliarStatus[familiarName]
	if familiarStatus ~= nil then
		if familiarStatus.RestTicks > familiarData.TickForRested then
			bonusChance = bonusChance + familiarData.RestBonusResourceSpawnChance
		end
	end
	return bonusChance
end

function FrogFollowAI( familiar, followId )
	local aiData = GetWeaponAIData( familiar )
	local followId = aiData.FollowId or CurrentRun.Hero.ObjectId
	local followDistance = aiData.HopRestDistance
	if not IsCombatEncounterActive( CurrentRun ) then
		followDistance = aiData.HopNonCombatRestDistance
	end

	wait( 0.5, familiar.AIThreadName )

	while IsAIActive( familiar ) do
		if IsInputAllowed({ }) then
			if RandomChance( aiData.ForceHopChance ) or not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = followId, Distance = followDistance, ScaleY = aiData.HopRestDistanceScaleY }) then
				local moveOffset = CalcOffset(math.rad(RandomFloat(0, 360)), RandomFloat(aiData.PlayerMinOffset , aiData.PlayerOffset or 150 ))
				FrogLeap( familiar, aiData, { OffsetX = moveOffset.X, OffsetY = moveOffset.Y })
			end
		end
		wait( CalcEnemyWait( familiar, aiData.FollowRefreshDuration or 0.3 ), familiar.AIThreadName )
	end

	familiar.AIBehavior = nil
	RemoveInteractBlock( familiar, "AIDisabled" )
end

function FrogLeap( familiar, aiData, args )
	args = args or {}
	local targetId = args.Id or CurrentRun.Hero.ObjectId
	if args.MinLeapDistance ~= nil and IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = args.MinLeapDistance }) then
		return
	end

	familiar.BlockVictoryPresentation = true

	local room = CurrentHubRoom or RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local lockedTargetId = nil
	local maxLeapDistance = args.MaxLeapDistance or room.FrogFamiliarMaxLeapDistance or aiData.MaxLeapDistance
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = maxLeapDistance, ScaleY = aiData.MaxLeapDistanceScaleY }) then
		local angle = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = targetId })
		local offset =  CalcOffset( math.rad(angle), maxLeapDistance )
		lockedTargetId = SpawnObstacle({Name = "InvisibleTarget", DestinationId = familiar.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })	
	else
		lockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId, OffsetX = args.OffsetX, OffsetY = offsetY })
	end

	local leapRecoveryTime = aiData.LeapRecoveryTime
	if not IsCombatEncounterActive( CurrentRun ) then
		leapRecoveryTime = aiData.LeapNonCombatRecoveryTime
	end

	if (args.Id == nil and room.FamiliarsPreferSpawnPointMovement) or IsLocationBlocked({ Id = lockedTargetId, CheckUnits = true, PathfindersPreferAvoid = false }) then
		local spawnPointId = nil
		local familiarPoints = GetIdsByType({ Name = "FamiliarPoint" })
		spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", DestinationIds = familiarPoints, Distance = maxLeapDistance, ScaleY = aiData.MaxLeapDistanceScaleY, MaxDistanceFromId = familiar.ObjectId })
		if spawnPointId <= 0 or spawnPointId == familiar.LastSpawnPointId then
			-- No distance restriction for backup jump
			spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints",  DestinationIds = familiarPoints })
			DebugPrint({ Text = "Used backup jump" })
		end
		if --[[room.FamiliarsPreferSpawnPointMovement and ]]spawnPointId == familiar.LastSpawnPointId then
			-- Already on the closest available point, do nothing
			DebugPrint({ Text = "Already on the closest available point" })
			wait( CalcEnemyWait( familiar, leapRecoveryTime ), familiar.AIThreadName )
			Destroy({ Id = lockedTargetId })
			familiar.BlockVictoryPresentation = false
			return
		end
		if spawnPointId <= 0 then
			spawnPointId = nil
		end
		familiar.LastSpawnPointId = spawnPointId
		Teleport({ Id = lockedTargetId, DestinationId = spawnPointId or CurrentRun.Hero.ObjectId })
	else
		familiar.LastSpawnPointId = nil
	end

	if aiData.LeapWarningAnimation ~= nil then
		CreateAnimation({ Name = aiData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end

	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = lockedTargetId })
	if aiData.LeapChargeAnimation then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = aiData.LeapChargeAnimation })
	end
	if aiData.LeapChargeSound ~= nil then
		PlaySound({ Name = aiData.LeapChargeSound, Id = familiar.ObjectId })
	end
	wait( CalcEnemyWait( familiar, aiData.LeapPrepareTime ), familiar.AIThreadName )

	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = false })
	Stop({ Id = familiar.ObjectId })
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = lockedTargetId })
	ApplyForce({ Id = familiar.ObjectId, Angle = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = lockedTargetId }), Speed = aiData.LeapSpeed, SelfApplied = true })
	local distanceToTarget = GetDistance({ Id = familiar.ObjectId, DestinationId = lockedTargetId })
	local neededHangTime = (distanceToTarget / aiData.LeapSpeed) + 0.05
	ApplyUpwardForce({ Id = familiar.ObjectId, HangTime = neededHangTime })
	PlaySound({ Name = aiData.LeapSound or "/Leftovers/SFX/HarpDash", Id = familiar.ObjectId })
	wait( CalcEnemyWait( familiar, neededHangTime ), familiar.AIThreadName )

	if aiData.LeapLandingAnimation then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = aiData.LeapLandingAnimation })
	end
	if aiData.LeapLandingSound then
		PlaySound({ Name = aiData.LeapLandingSound, Id = familiar.ObjectId, ManagerCap = 28 })
	end
	if aiData.LeapWarningAnimation ~= nil then
		StopAnimation({ Name = aiData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end
	if aiData.LeapLandingProjectile then
		CreateProjectileFromUnit({ Name = aiData.LeapLandingProjectile, Id = familiar.ObjectId, Destination = familiar.ObjectId })
	end

	Destroy({ Id = lockedTargetId })

	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = true })

	familiar.BlockVictoryPresentation = false

	if aiData.LeapFastRecoveryDistance ~= nil and not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = aiData.LeapFastRecoveryDistance, ScaleY = aiData.LeapFastRecoveryDistanceScaleY }) then
		leapRecoveryTime = aiData.LeapFastRecoveryTime
	end
	wait( CalcEnemyWait( familiar, leapRecoveryTime ), familiar.AIThreadName )
end

function FrogHitResponse( unit, triggerArgs )
	local angle = triggerArgs.ImpactAngle
	local knockbackForce = unit.OnHitForce or 1200
	local knockupHangTime = unit.OnHitHangTime or 0
	local angle = GetAngleBetween({ DestinationId = unit.ObjectId, Id = triggerArgs.AttackerId }) 
	
	ApplyForce({ Id = unit.ObjectId, Speed = knockbackForce, Angle = angle, SelfApplied = true})
	ApplyUpwardForce({ Id = unit.ObjectId, HangTime = knockupHangTime })

	SetAnimation({ Name = "Familiar_Frog_Block", DestinationId = unit.ObjectId })
end

function CatFamiliarShouldAlert( familiar, args )
	 if not familiar.ReadyToAttack then
		return false
	end
	if not IsEmpty( familiar.AttackBlocks ) then
		return false
	end
	if CurrentRun.Hero.SprintActive or HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableMove" }) then
		return true
	else
		return false
	end
end

function CatFamiliarAI( familiar, args )

	args = args or {}
	if args.Equipping then
		SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
		wait( 1.0, familiar.AIThreadName )
		CatFamiliarMoveToRandomLocation( familiar, familiar.DefaultAIData )
		wait( 0.5, familiar.AIThreadName )
		SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
		wait( 3.0, familiar.AIThreadName )
	end

	local aiData = familiar.DefaultAIData

	familiar.ReadyToAttack = true
	while IsAIActive( familiar ) do
		-- Wait for hero to sprint by
		if familiar.ReadyToAttack and IsEmpty( familiar.AttackBlocks ) and familiar.RecruitAnimationId == nil then
			familiar.RecruitAnimationId = CreateAnimation({ Name = aiData.RecruitAnimation, DestinationId = familiar.ObjectId, Scale = aiData.RecruitAnimationScale })
		end
		familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
		NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
									Distance = aiData.RecruitDistance, ScaleY = aiData.AttackDistanceScaleY or 0.55,
									Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		if CatFamiliarShouldAlert( familiar, args ) then
			familiar.BlockVictoryPresentation = true

			thread( MarkObjectiveComplete, "ActivateCatFamiliar" )
			CatFamiliarAlertedPresentation( familiar, args )
			wait( 1.0, familiar.AIThreadName )

			local numAttacks = familiar.NumAttacks
			while numAttacks >= 1 do
				local eligibleIds = {}
				for id, enemy in pairs( ActiveEnemies ) do
					if enemy.RequiredKill or enemy.FamiliarTarget then
						eligibleIds[id] = true
					end
				end
				local targetId = GetClosest({ Id = familiar.ObjectId, DestinationIds = GetAllKeys( eligibleIds ), Distance = familiar.TargetSearchDistance or aiData.TargetSearchDistance, IgnoreHomingIneligible = true, IgnoreSelf = true })
				if targetId > 0 then
					local distanceToTarget = GetDistance({ Id = familiar.ObjectId, DestinationId = targetId })
					if distanceToTarget > aiData.AttackDistance then
						Move({ Id = familiar.ObjectId, DestinationId = targetId })
						NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = aiData.AttackDistance, Notify = familiar.AINotifyName, Timeout = 9.0 })
						waitUntil( familiar.AINotifyName )
					end
					Stop({ Id = familiar.ObjectId })
					CatFamiliarPreAttackPresentation( familiar, args )
					local angleToTarget = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = targetId })
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
					wait( 0.5, familiar.AIThreadName )
					CatFamiliarAttackPresentation( familiar, args )
					ApplyForce({ Id = familiar.ObjectId, Speed = aiData.AttackVelocity, Angle = angleToTarget })
					CreateProjectileFromUnit({ Name = "CatFamiliarPounce", Id = familiar.ObjectId })
					wait( 2.0, familiar.AIThreadName )
					numAttacks = numAttacks - 1
				else
					break
				end
			end
			
			CatFamiliarMoveToRandomLocation( familiar, familiar.DefaultAIData )
			wait( 0.5, familiar.AIThreadName )

			familiar.BlockVictoryPresentation = false

			SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
			wait( 3.0, familiar.AIThreadName )
		else
			wait( 0.2, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil

end

function CatFamiliarMoveToRandomLocation( familiar, aiData, args )
	args = args or {}
	local spawnPointIds = GetClosestIds({ Id = familiar.ObjectId, DestinationName = "SpawnPoints", Distance = aiData.WanderDistance, ScaleY = aiData.WanderDistanceScaleY, RequiredLocationUnblocked = true })
	RemoveValue( spawnPointIds, familiar.LastSpawnPointId )
	local randomSpawnPointId = GetRandomValue( spawnPointIds )
	familiar.LastSpawnPointId = randomSpawnPointId
	Move({ Id = familiar.ObjectId, DestinationId = randomSpawnPointId, SuccessDistance = 50 })
	familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
	NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = randomSpawnPointId, Distance = 100, Notify = familiar.AINotifyName, Timeout = 9.0 })
	waitUntil( familiar.AINotifyName )
	wait( 0.5, familiar.AIThreadName )
	Stop({ Id = familiar.ObjectId })
end

function FamiliarTimeTick( args )
	args = args or {}
	AddInputBlock({ Name = "FamiliarTimeTick" })
	for tick = 1, (args.Ticks or 1) do
		for familiarName, familiarStatus in pairs( GameState.FamiliarStatus ) do
			if familiarName ~= GameState.EquippedFamiliar and GameState.WorldUpgradesAdded.WorldUpgradeFamiliarRest then
				familiarStatus.RestTicks = (familiarStatus.RestTicks or 0) + 1
			end
		end
		wait( args.TickInterval )
	end
	RemoveInputBlock({ Name = "FamiliarTimeTick" })
end
