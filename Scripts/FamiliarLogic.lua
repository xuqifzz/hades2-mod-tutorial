-- Familiar Kits / Equipping

function AssignFamiliarKits( eventSource, args )

	MapState.FamiliarKitIds = GetIdsByType({ Name = "FamiliarKit" })
	table.sort( MapState.FamiliarKitIds )
	MapState.FamiliarKits = {}

	LoadPackages({ Names = FamiliarOrderData })

	for index, familiarName in ipairs( FamiliarOrderData ) do

		local familiarData = FamiliarData[familiarName]
		if IsGameStateEligible( familiarData, familiarData.GameStateRequirements ) then
			-- Unlocked
			local familiarKit = DeepCopyTable( ObstacleData.FamiliarKit )
			local kitId = MapState.FamiliarKitIds[index]
			AttachLua({ Id = kitId, Table = familiarKit })
			familiarKit.Name = familiarName
			familiarKit.ObjectId = kitId
			MapState.FamiliarKits[kitId] = familiarKit

			local familiar = DeepCopyTable( familiarData )
			if args.OverwriteSelf ~= nil then
				OverwriteSelf( familiar, args.OverwriteSelf )
			end	
			familiar.BlocksLootInteraction = false
			local destinationId = nil
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
			if familiar.IgnoreGravity then
				IgnoreGravity({ Id = familiar.ObjectId })
			end

			SetAlpha({ Id = kitId, Fraction = 0.0 })
			if GameState.WorldUpgradesAdded.WorldUpgradeFamiliarRest then
				familiarKit.TicksUntilRested = math.max( FamiliarData[familiarKit.Name].TickForRested - (GameState.FamiliarRestTicks[familiarKit.Name] or 0), 0 )
				CreateTextBox({
					Id = kitId,
					Text = "FamiliarRestTicks",
					OffsetY = 40,
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
					OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
					Font = "P22UndergroundSCMedium",
					FontSize = 24,
					Justification = "Center",
					LuaKey = "TempTextData",
					LuaValue = familiarKit,
					DataProperties =
					{
						OpacityWithOwner = true,
					},
				})
			end
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
			familiarKit.OnUsedFunctionName = "UseFamiliarUnequip"
			familiarKit.Unit.OnUsedFunctionName = nil
			SetAlpha({ Id = familiarKit.ObjectId, Fraction = 0.0, Duration = 0.2 })
			if CanReceiveGift( familiarKit.Unit ) then
				RemoveInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			else
				AddInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			end
		else
			-- Unequipped
			AddInteractBlock( familiarKit, "UpdateFamiliarKits" )
			if familiarKit.Unit ~= nil then
				RemoveInteractBlock( familiarKit.Unit, "UpdateFamiliarKits" )
			end
			if GameState.WorldUpgradesAdded.WorldUpgradeFamiliarRest then
				FamiliarRestingPresentation( familiarKit )
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
	CheckObjectiveSet( familiar.EquipObjective or "CheckFamiliarInfoPrompt" )
	UpdateFamiliarKits()
	SelectCodexEntry( familiar.Name )
	EquipFamiliarPresentation( familiar )
	wait( 1.0 )
	RemoveInteractBlock( kit, "UseFamiliar" )
	RemoveInteractBlock( familiar, "UseFamiliar" )
end

function UseFamiliarUnequip( kit, args, user )
	AddInteractBlock( kit, "UseFamiliarUnequip" )
	AddInteractBlock( kit.Unit, "UseFamiliarUnequip" )
	UnequipFamiliarPresentation( args )
	UnequipFamiliar( user, args )
	UpdateFamiliarKits()
	wait( 1.0 )
	RemoveInteractBlock( kit, "UseFamiliarUnequip" )
	RemoveInteractBlock( kit.Unit, "UseFamiliarUnequip" )
end

function EquipFamiliar( familiar, args )

	if args.FamiliarName == nil then
		return
	end

	GameState.EquippedFamiliar = args.FamiliarName
	GameState.FamiliarResourceSpawnChance = FamiliarData[GameState.EquippedFamiliar].BaseResourceSpawnChance + GetFamiliarBonusResourceSpawnChance( GameState.EquippedFamiliar )
	MapState.FamiliarUnit = familiar

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
		RecreateLifePips()
	end

	if args.EnableAI and familiar ~= nil then
		familiar.OnUsedFunctionName = nil
		ReenableFamiliar( familiar, { Equipping = true } )
	end

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

		if GameState.ActiveObjectiveSet == "CheckFamiliarInfoPrompt" or GameState.ActiveObjectiveSet == "CheckFamiliarUpgradeInfoPrompt" then
			ClearObjectives()
		end
		local equipObjective = FamiliarData[GameState.EquippedFamiliar].EquipObjective
		if equipObjective ~= nil and GameState.ActiveObjectiveSet == equipObjective then
			ClearObjectives()
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
	AddInteractBlock( familiar, "ReturningToKit" )
	CallFunctionName( familiar.MoveFunctionName, familiar, { Id = unequippedKit.ObjectId, MinLeapDistance = 100, MaxLeapDistance = 9999, SuccessDistance = 48 } )
	RemoveInteractBlock( familiar, "ReturningToKit" )
end

-- Familiar Setup

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

	local familiar = DeepCopyTable( FamiliarData[GameState.EquippedFamiliar] )
	
	familiar.BlocksLootInteraction = false
	familiar.BlockVictoryPresentation = false
	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "SpawnPoints" }, DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true })
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
	if familiar.IgnoreGravity then
		IgnoreGravity({ Id = familiar.ObjectId })
	end

	MapState.FamiliarUnit = familiar

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

	-- Reset rest on being used in a run
	GameState.FamiliarRestTicks[familiar.Name] = 0
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

-- Frinos / FrogFamiliar

function FrogFamiliarStopAI( familiar )
	local notifyName = "FrogFamiliarStopped"
	NotifyOnStopped({ Id = familiar.ObjectId, Notify = notifyName, Timeout = 2.0 })
	waitUntil( notifyName )

	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	wait( 0.02 )
end

function FrogFamiliarMoveToLocation( familiar, args )
	args = args or {}
	FrogFamiliarStopAI( familiar )
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

function FrogFollowAI( familiar, args )
	args = args or {}
	local aiData = GetWeaponAIData( familiar )
	local followId = aiData.FollowId or CurrentRun.Hero.ObjectId
	local followDistance = aiData.HopRestDistance
	if not IsCombatEncounterActive( CurrentRun ) then
		followDistance = aiData.HopNonCombatRestDistance
	end

	if args.Equipping then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Frog_Greet" })
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
		end
		if --[[room.FamiliarsPreferSpawnPointMovement and ]]spawnPointId == familiar.LastSpawnPointId then
			-- Already on the closest available point, do nothing
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

-- Toula / CatFamiliar

function CatFamiliarStopAI( familiar )
	Stop({ Id = familiar.ObjectId })

	StopAnimation({ Name = familiar.DefaultAIData.RecruitAnimation, DestinationId = familiar.ObjectId })
	familiar.RecruitAnimationId = nil
	RemoveInteractBlock( familiar, "Equipping" )
	RemoveInteractBlock( familiar, "Alerted" )
	familiar.ReadyToAttack = false

	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	wait( 0.02 )
end

function CatFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		CatFamiliarStopAI( familiar )
	end

	if not familiar.Awake then
		familiar.Awake = true
		SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
		wait( 1.0, familiar.AIThreadName )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	local notifyName = "CatFamiliarWithinDistance"
	Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance, OnFailGoToNearestToGoal = args.OnFailGoToNearestToGoal })
	NotifyOnStopped({ Id = familiar.ObjectId, DestinationId = targetLocation, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )
	Stop({ Id = familiar.ObjectId })

	if not args.StayAwake then
		wait( 1.0, familiar.AIThreadName )
		CatFamiliarGoToSleepPresentation( familiar )
	end
end

function CatFamiliarShouldAlert( familiar, args )
	 if not familiar.ReadyToAttack then
		return false
	end
	if SessionMapState.SprintActive or HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableMove" }) then
		return true
	else
		return false
	end
end

function CatFamiliarAI( familiar, args )

	args = args or {}

	if args.InitialDelay ~= nil then
		wait( args.InitialDelay, familiar.AIThreadName )
	end

	if args.Equipping then
		AddInteractBlock( familiar, "Equipping" )
	end
	if args.Equipping or args.MoveToRandomLocation then
		CatFamiliarMoveToRandomLocation( familiar )
	end
	if args.Equipping then
		RemoveInteractBlock( familiar, "Equipping" )
	end

	local aiData = familiar.DefaultAIData

	familiar.ReadyToAttack = true
	while IsAIActive( familiar ) do
		-- Wait for hero to sprint by
		if familiar.ReadyToAttack and familiar.RecruitAnimationId == nil then
			familiar.RecruitAnimationId = CreateAnimation({ Name = aiData.RecruitAnimation, DestinationId = familiar.ObjectId, Scale = aiData.RecruitAnimationScale })
		end
		familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
		NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
									Distance = aiData.RecruitDistance, ScaleY = aiData.AttackDistanceScaleY or 0.55,
									Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		if CatFamiliarShouldAlert( familiar, args ) then
			AddInteractBlock( familiar, "Alerted" )
			familiar.BlockVictoryPresentation = true

			thread( MarkObjectiveComplete, "ActivateCatFamiliar" )
			CatFamiliarAlertedPresentation( familiar, args )
			wait( 1.0, familiar.AIThreadName )

			local numAttacks = familiar.NumAttacks
			while numAttacks >= 1 do
				local eligibleIds = {}
				for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
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
			
			CatFamiliarMoveToRandomLocation( familiar )

			RemoveInteractBlock( familiar, "Alerted" )
			familiar.BlockVictoryPresentation = false
		else
			wait( 0.2, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil

end

function CatFamiliarMoveToRandomLocation( familiar, args )
	args = args or {}
	local aiData = familiar.DefaultAIData
	local spawnPointIds = GetClosestIds({ Id = familiar.ObjectId, DestinationName = "SpawnPoints", Distance = aiData.WanderDistance, ScaleY = aiData.WanderDistanceScaleY, RequiredLocationUnblocked = true })
	RemoveValue( spawnPointIds, familiar.LastSpawnPointId )
	local randomSpawnPointId = GetRandomValue( spawnPointIds )
	familiar.LastSpawnPointId = randomSpawnPointId
	CatFamiliarMoveToLocation( familiar, { Id = randomSpawnPointId, KeepAIAlive = true } )
end

-- Raki / RavenFamiliar

function RavenFamiliarStopAI( familiar, args )
	Stop({ Id = familiar.ObjectId })
	RemoveInteractBlock( familiar, "Equipping" )
	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	wait( 0.02 )
end

function RavenFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		RavenFamiliarStopAI( familiar )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId

	if familiar.CurrentHeight == familiar.GroundHeight then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Perch_End" })
		wait( 0.2, familiar.AIThreadName )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetLocation, Duration = 0.3 })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.5 })
		wait( 0.55, familiar.AIThreadName )
		familiar.CurrentHeight = familiar.FlightHeight
	end

	familiar.AIDisabled = true
	familiar.DisableAIWhenReady = true

	local notifyName = "RavenFamiliarWithinDistance"
	Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance })
	NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = 120, Notify = notifyName, Timeout = 9.0 })
	waitUntil( notifyName )

	if not args.KeepFlyingOnFinish then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Perch_Start" })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.GroundHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.3 })
		wait( 0.8, familiar.AIThreadName )
		familiar.CurrentHeight = familiar.GroundHeight
	end
end

function RavenFamiliarAI( familiar, args )
	args = args or {}

	local aiData = familiar.DefaultAIData
	familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId

	if args.InitialDelay ~= nil then
		wait( args.InitialDelay, familiar.AIThreadName )
	end

	if args.Equipping then
		AddInteractBlock( familiar, "Equipping" )
		RavenFamiliarMoveToLocation( familiar, { Id = 589725, KeepAIAlive = true } )
		RemoveInteractBlock( familiar, "Equipping" )
	end

	while IsAIActive( familiar ) do
		while FamiliarShouldUseCombatLogic() do

			if familiar.CurrentHeight ~= familiar.SkyHeight then
				RavenFamiliarDropExitPresentation( familiar )
			end

			wait( RandomFloat( familiar.MinTimeBetweenAttacks, familiar.MaxTimeBetweenAttacks ), familiar.AIThreadName )
			Stop({ Id = familiar.ObjectId })
			RavenFamiliarDropEnterPresentation( familiar )
			
			local numAttacks = familiar.NumAttacks
			while numAttacks >= 1 do
				local eligibleIds = {}
				for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
					if not enemy.IsDead and ( enemy.RequiredKill or enemy.FamiliarTarget ) then
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
					local angleToTarget = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = targetId })
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
					wait( 0.02, familiar.AIThreadName )

					RavenFamiliarAttackPresentation( familiar, args )
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
					wait( 0.115, familiar.AIThreadName )
					CreateProjectileFromUnit({ Name = "RavenFamiliarMelee", Id = familiar.ObjectId })
					wait( 0.115, familiar.AIThreadName  )
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
					wait( 0.115, familiar.AIThreadName  )
					CreateProjectileFromUnit({ Name = "RavenFamiliarMelee", Id = familiar.ObjectId })
					wait( 0.115, familiar.AIThreadName )
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
					wait( 0.115, familiar.AIThreadName )
					CreateProjectileFromUnit({ Name = "RavenFamiliarMelee_Crit", Id = familiar.ObjectId })

					Stop({ Id = familiar.ObjectId })
					numAttacks = numAttacks - 1
					wait( 0.35, familiar.AIThreadName )
				else
					break
				end
			end

			wait( 1.0, familiar.AIThreadName )
		end
		if familiar.CurrentHeight ~= familiar.GroundHeight then
			local closestSpawnPoint = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", RequiredLocationUnblocked = true })
			RavenFamiliarMoveToLocation( familiar, { Id = closestSpawnPoint } )
		else
			-- hang out and wait for a new combat encounter to start
			wait(1.0, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil
end

function ClearRavenMark( victim, args )
	ClearEffect({ Id = victim.ObjectId, Name = "RavenFamiliarMark" })
end
-- Hecuba / HoundFamiliar

function HoundFamiliarStopAI( familiar )
	Stop({ Id = familiar.ObjectId })
	RemoveInteractBlock( familiar, "Equipping" )
	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	wait( 0.02 )
end

function HoundFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		HoundFamiliarStopAI( familiar )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = args.SuccessDistance }) then
		local notifyName = "HoundFamiliarWithinDistance"
		Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance, OnFailGoToNearestToGoal = args.OnFailGoToNearestToGoal })
		NotifyOnStopped({ Id = familiar.ObjectId, DestinationId = targetLocation, Notify = notifyName, Timeout = 9.0 })
		waitUntil( notifyName )
	end

	if not args.KeepStandingOnFinish then
		SetAnimation({ Name = "Familiar_Hound_StandToSit", DestinationId = familiar.ObjectId })
		wait(1.0)
	end
end

function HoundFamiliarAI( familiar, args )
	args = args or {}

	if args.InitialDelay ~= nil then
		wait( args.InitialDelay, familiar.AIThreadName )
	end

	if args.Equipping then
		SetAnimation({ Name = "Familiar_Hound_SitToStand", DestinationId = familiar.ObjectId })
		wait( 1.0, familiar.AIThreadName )
	end

	local aiData = familiar.DefaultAIData
	local followDistance = aiData.FollowRestDistance
	if not IsCombatEncounterActive( CurrentRun ) then
		followDistance = aiData.FollowNonCombatRestDistance
	end

	HoundFamiliarStartEncounter( familiar )

	wait( 0.5, familiar.AIThreadName )

	while IsAIActive( familiar ) do
		local moved = false
		if IsInputAllowed({ }) and not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = followDistance, ScaleY = aiData.FollowRestDistanceScaleY }) then
			local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "SpawnPoints" }, DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true })
			if spawnPointId ~= familiar.LastSpawnPointId then

				familiar.BlockVictoryPresentation = true

				-- Move
				familiar.LastSpawnPointId = spawnPointId
				Move({ Id = familiar.ObjectId, DestinationId = spawnPointId, SuccessDistance = 100 })
				familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
				NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = spawnPointId, Distance = 120, Notify = familiar.AINotifyName, Timeout = 3.0 })
				waitUntil( familiar.AINotifyName )
				moved = true

				familiar.BlockVictoryPresentation = false

			end
		end
		if not moved then
			wait( 0.3, familiar.AIThreadName )
		end

		-- Combat
		if FamiliarShouldUseCombatLogic() then
			local barked = false
			if CheckCooldownNoTrigger( "FamiliarHoundBark", familiar.BarkCooldown ) then
				local closestEnemyIds = GetClosestIds({ Id = familiar.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = familiar.BarkRange })
				local barkAtEnemyId = nil
				for i, enemyId in ipairs( closestEnemyIds ) do
					local enemy = ActiveEnemies[enemyId]
					if enemy ~= nil and ( enemy.HealthBuffer == nil or enemy.HealthBuffer == 0 ) then
						barkAtEnemyId = enemyId
					end
				end
				if barkAtEnemyId ~= nil then
					Stop({ Id = familiar.ObjectId })
					AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = barkAtEnemyId })
					wait( 0.05, familiar.AIThreadName )
					SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Hound_Attack" })
					wait( 0.12, familiar.AIThreadName )
					CreateProjectileFromUnit({ Name = "HoundFamiliarBark", Id = familiar.ObjectId })
					TriggerCooldown( "FamiliarHoundBark" )
					familiar.BarkCooldown = RandomFloat( familiar.MinTimeBetweenBarks, familiar.MaxTimeBetweenBarks )
					barked = true
					wait( 1.0, familiar.AIThreadName )
				end
			end

			if not barked and CheckCooldownNoTrigger( "FamiliarHoundDig", familiar.DigCooldown ) then
				local canDigMana = familiar.ManaDigCount < familiar.MaxManaDigsPerEncounter and ( CurrentRun.Hero.Mana / CurrentRun.Hero.MaxMana ) < familiar.HeroManaPercentForDig
				if canDigMana then
					Stop({ Id = familiar.ObjectId })
					PlaySound({ Name = familiar.SensedLootSound or "/EmptyCue", Id = familiar.ObjectId })
					wait( 0.3, familiar.AIThreadName )
					SetAnimation({ Name = "Familiar_Hound_Dig", DestinationId = familiar.ObjectId })
					waitUnmodified( 0.7, familiar.AIThreadName )
					CreateAnimation({ Name = "ShovelDirtInSprayHound", DestinationId = familiar.ObjectId })
					waitUnmodified( 0.82, familiar.AIThreadName )
					CreateAnimation({ Name = "ShovelDirtInSprayHound", DestinationId = familiar.ObjectId })
					wait( 0.98, familiar.AIThreadName )
					CreateAnimation({ Name = "ShovelDirtOutSprayHound", DestinationId = familiar.ObjectId })
					wait( 0.15, familiar.AIThreadName )
					PlaySound({ Name = familiar.FoundLootSound or "/EmptyCue", Id = familiar.ObjectId })

					DropMinorConsumable( familiar.ManaDigReward, familiar.ObjectId )
					familiar.ManaDigCount = familiar.ManaDigCount + 1
					thread( InCombatText, familiar.ObjectId, "HoundFamiliar_ManaItemDug", 1.65, { PreDelay = 0.35, OffsetY = -100 }  )

					TriggerCooldown( "FamiliarHoundDig" )
					familiar.DigCooldown = RandomFloat( familiar.MinTimeBetweenDigs, familiar.MaxTimeBetweenDigs )
					wait( 0.5, familiar.AIThreadName )
				end
			end
		end
	end
	familiar.AIBehavior = nil
end

function HoundFamiliarStartEncounter( familiar )
	familiar.ManaDigCount = 0
	familiar.DigCooldown = RandomFloat( familiar.MinTimeBetweenDigs, familiar.MaxTimeBetweenDigs )
	TriggerCooldown( "FamiliarHoundDig" )

	familiar.BarkCooldown = 0
	TriggerCooldown( "FamiliarHoundBark" )
end

-- Helper Functions

function GetFamiliarBonusResourceSpawnChance( familiarName )
	local bonusChance = 0
	for unlockName, value in pairs( GameState.FamiliarUpgrades ) do
		local shopItemData = FamiliarShopItemData[unlockName]
		if shopItemData ~= nil and shopItemData.FamiliarName == familiarName and shopItemData.BonusResourceSpawnChance then
			bonusChance = bonusChance + shopItemData.BonusResourceSpawnChance
		end
	end
	local familiarData = FamiliarData[familiarName]
	if (GameState.FamiliarRestTicks[familiarName] or 0) > familiarData.TickForRested then
		bonusChance = bonusChance + familiarData.RestBonusResourceSpawnChance
	end
	return bonusChance
end

function FamiliarTimeTick( args )
	args = args or {}
	AddInputBlock({ Name = "FamiliarTimeTick" })
	for tick = 1, (args.Ticks or 1) do
		for familiarName in pairs( GameState.FamiliarsUnlocked ) do
			if familiarName ~= GameState.EquippedFamiliar and GameState.WorldUpgradesAdded.WorldUpgradeFamiliarRest then
				GameState.FamiliarRestTicks[familiarName] = (GameState.FamiliarRestTicks[familiarName] or 0) + 1
			end
		end
		wait( args.TickInterval )
	end
	RemoveInputBlock({ Name = "FamiliarTimeTick" })
end

function FamiliarShouldUseCombatLogic()
	if CurrentHubRoom ~= nil or CurrentRun.CurrentRoom == nil then
		return false
	end

	if not IsEmpty( RequiredKillEnemies ) then
		return true
	end

	if IsCombatEncounterActive( CurrentRun, { IgnoreMainEncounter = CurrentRun.CurrentRoom.IgnoreMainEncounterForFamiliar }) then
		return true
	end

	return false
end

function GetFamiliarUpgradeCount( familiarName )
	local count = 0
	for i, unlockName in ipairs( ScreenData.FamiliarShop.ItemOrder ) do
		if GameState.FamiliarUpgrades[unlockName] then
			local shopItemData = FamiliarShopItemData[unlockName]
			if shopItemData ~= nil and shopItemData.FamiliarName == familiarName then
				count = count + 1
			end
		end
	end
	return count
end
