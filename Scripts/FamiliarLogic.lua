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
				local spawnNearId = CurrentRun.NextHeroEndPoint or eventSource.HeroEndPoint or CurrentRun.FamiliarSpawnNearId
				if CurrentRun.StoredHeroLocation ~= nil then
					spawnNearId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
					Teleport({ Id = spawnNearId, OffsetX = CurrentRun.StoredHeroLocation.X, OffsetY = CurrentRun.StoredHeroLocation.Y })
				end
				destinationId = GetClosest({ Id = spawnNearId, DestinationName = "SpawnPoints" })
				familiar.LastSpawnPointId = destinationId
				familiar.StartingAsEquippedFamiliar = true
				MapState.FamiliarUnit = familiar
			else
				destinationId = kitId
				familiar.DisableAIWhenReady = true
			end
			if GameState.FamiliarCostumes[familiarName] == nil then
				GameState.FamiliarCostumes[familiarName] = familiar.DefaultCostume
			end
			familiar.ObjectId = SpawnUnit({ Name = familiar.Name, Group = "Standing", DestinationId = destinationId })
			familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
			thread( SetupUnit, familiar, CurrentRun )
	
			familiar.KitId = kitId
			familiarKit.Unit = familiar
			if familiar.KitAngle ~= nil then
				SetGoalAngle({ Id = familiar.ObjectId, Angle = familiar.KitAngle, CompleteAngle = true })
			end
			if not GameState.TraitsTaken[familiar.TraitNames[1]] then
				PlayStatusAnimation( familiar, { Animation = "StatusIconWantsToTalkImportant" } )
			end
			if familiar.IgnoreGravity then
				IgnoreGravity({ Id = familiar.ObjectId })
			end

			SetAlpha({ Id = kitId, Fraction = 0.0 })
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
				UnequipFamiliar( nil, { IgnoreAI = true, SkipPresentation = true } )
				EquipFamiliar( familiar, { FamiliarName = familiar.Name, EnableAI = false, SkipPresentation = true } )
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
		end
	end
end

function UseFamiliar( familiar, args, user )
	if familiar.Name == GameState.EquippedFamiliar then
		-- Already equipped
		return
	end
	
	local startingHealth = CurrentRun.Hero.MaxHealth
	local startingMana = CurrentRun.Hero.MaxMana

	local kit = MapState.FamiliarKits[familiar.KitId]
	AddInteractBlock( kit, "UseFamiliar" )
	AddInteractBlock( familiar, "UseFamiliar" )
	StopStatusAnimation( familiar )	
	UnequipFamiliar( user, args )
	EquipFamiliar( familiar, { FamiliarName = familiar.Name, EnableAI = true, } )
	CheckObjectiveSet( familiar.EquipObjective or "CheckFamiliarInfoPrompt" )
	UpdateFamiliarKits()

	if startingHealth ~= CurrentRun.Hero.MaxHealth then
		thread( MaxHealthChangedPresentation, CurrentRun.Hero.MaxHealth > startingHealth )
	end
	if startingMana ~= CurrentRun.Hero.MaxMana then
		thread( MaxManaChangedPresentation, CurrentRun.Hero.MaxMana > startingMana )
	end

	SelectCodexEntry( familiar.Name )
	EquipFamiliarPresentation( familiar )
	wait( 1.0 )
	RemoveInteractBlock( kit, "UseFamiliar" )
	RemoveInteractBlock( familiar, "UseFamiliar" )
end

function UseFamiliarUnequip( kit, args, user )
	local startingHealth = CurrentRun.Hero.MaxHealth
	local startingMana = CurrentRun.Hero.MaxMana

	AddInteractBlock( kit, "UseFamiliarUnequip" )
	AddInteractBlock( kit.Unit, "UseFamiliarUnequip" )
	UnequipFamiliarPresentation( args )
	UnequipFamiliar( user, args )
	UpdateFamiliarKits()

	if startingHealth ~= CurrentRun.Hero.MaxHealth then
		thread( MaxHealthChangedPresentation, CurrentRun.Hero.MaxHealth > startingHealth )
	end
	if startingMana ~= CurrentRun.Hero.MaxMana then
		thread( MaxManaChangedPresentation, CurrentRun.Hero.MaxMana > startingMana )
	end

	wait( 1.0 )
	RemoveInteractBlock( kit, "UseFamiliarUnequip" )
	RemoveInteractBlock( kit.Unit, "UseFamiliarUnequip" )
end

function EquipFamiliar( familiar, args )

	if args.FamiliarName == nil then
		return
	end
	
	local hadLastStand = HasLastStand( CurrentRun.Hero) 
	GameState.EquippedFamiliar = args.FamiliarName
	MapState.FamiliarUnit = familiar

	local familiarData = FamiliarData[GameState.EquippedFamiliar]
	local traitNames = ShallowCopyTable( familiarData.TraitNames )
	for _, traitName in ipairs( traitNames ) do
		AddTraitToHero({ TraitName = traitName, StackNum = GetFamiliarTraitStacks( traitName ) })
		if not CurrentRun.Hero.IsDead then
			CurrentRun.TraitCache[traitName] = CurrentRun.TraitCache[traitName] or 1
		end
	end

	MapState.PriorityTraitInfoHighlight = traitNames[1]

	if traitNames[1] == "LastStandFamiliar" then
		AddLastStand({
			Name = "LastStandFamiliar",
			Icon = "ExtraLifeCatFamiliar",
			InsertAtEnd = true,
			IncreaseMax = true,
			HealAmount = GetTotalHeroTraitValue( "FamiliarLastStandHealAmount" ),
			Silent = true
		})
		RecreateLifePips()
		GainLastStandPresentation(1)
	end
	if args.FamiliarName == "CatFamiliar" and not args.SkipPresentation and hadLastStand ~= HasLastStand( CurrentRun.Hero ) then
		thread( LowHealthBonusBuffStatePresentation, 0.5 )
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

	local hadLastStand = HasLastStand( CurrentRun.Hero) 
	local familiarData = FamiliarData[GameState.EquippedFamiliar]
	local traitNames = ShallowCopyTable(familiarData.TraitNames )
	for _, traitName in ipairs( traitNames ) do
		RemoveTrait( CurrentRun.Hero, traitName )
	end

	if traitNames[1] == "LastStandFamiliar" then
		RemoveLastStand( CurrentRun.Hero, "LastStandFamiliar" )
		CurrentRun.Hero.MaxLastStands = CurrentRun.Hero.MaxLastStands - 1
		UpdateLifePips( CurrentRun.Hero )
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
	
	if GameState.EquippedFamiliar == "CatFamiliar" and not args.SkipPresentation and hadLastStand ~= HasLastStand( CurrentRun.Hero ) then
		thread( LowHealthBonusBuffStatePresentation, 0.5 )
	end
	GameState.EquippedFamiliar = nil
	MapState.FamiliarUnit = nil

end

function ReturnFamiliarToKit( familiar, unequippedKit, args )
	AddInteractBlock( familiar, "ReturningToKit" )
	CallFunctionName( familiar.MoveFunctionName, familiar, { Id = unequippedKit.ObjectId, MinLeapDistance = 100, MaxLeapDistance = 9999, SuccessDistance = 48, IgnoreUnitCollision = true, ForceToLocation = true } )
	RemoveInteractBlock( familiar, "ReturningToKit" )
end

-- Familiar Setup

function ActivateFamiliar( eventSource, args )
	local unitData = FamiliarData[args.Name]
	local newUnit = DeepCopyTable( unitData )
	newUnit.ObjectId = args.Id
	Activate({ Id = newUnit.ObjectId })
	if args.OverwriteSelf ~= nil then
		OverwriteSelf( newUnit, args.OverwriteSelf )
	end
	thread( SetupUnit, newUnit, CurrentRun, args )
end

function FamiliarSetup( source, args )

	if GameState.EquippedFamiliar == nil then
		return
	end

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom
	if roomData ~= nil and roomData.BlockFamiliars then
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
	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), Distance = 600, RequiredLocationUnblocked = true })
	if spawnPointId <= 0 then
		spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", Distance = 600, RequiredLocationUnblocked = true })
	end
	local spawnOffset = {}
	if spawnPointId <= 0 then
		local angleBetween = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId })
		spawnOffset = CalcOffset( math.rad( angleBetween ), 150 )
		spawnPointId = CurrentRun.Hero.ObjectId
	else
		familiar.LastSpawnPointId = spawnPointId
	end
	familiar.ObjectId = SpawnUnit({ Name = familiar.Name, Group = "Standing", DestinationId = spawnPointId, OffsetX = spawnOffset.X, OffsetY = spawnOffset.Y })
	familiar.AINotifyName = "WithinDistance_"..familiar.Name.."_"..familiar.ObjectId
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
	end

	RunEventsGeneric( roomData.OnFamiliarSpawnEvents, familiar )

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

function WaitForFamiliarLinkEnd( familiar, args )
	wait( args.Duration, "WaitForFamiliarLinkEnd" )
	familiar.Linked = false
	if familiar.LinkEndFunctionName ~= nil then
		CallFunctionName( familiar.LinkEndFunctionName, familiar )
	end
end

-- Frinos / FrogFamiliar

function FrogFamiliarStopAI( familiar )
	local notifyName = "FrogFamiliarStopped"
	NotifyOnStopped({ Id = familiar.ObjectId, Notify = notifyName, Timeout = 2.0 })
	waitUntil( notifyName )

	Destroy({ Id = familiar.LockedTargetId })
	familiar.LockedTargetId = nil

	RemoveInteractBlock( familiar, "Jumping" )
	
	familiar.LastSpawnPointId = nil
	familiar.IsJumping = false
	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killTaggedThreads( familiar.RecoveryThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	wait( 0.02 )
end

function FrogFamiliarMoveToLocation( familiar, args )
	args = args or {}
	FrogFamiliarStopAI( familiar )
	FrogLeap( familiar, { Id = args.Id or CurrentRun.Hero.ObjectId, MinLeapDistance = args.MinLeapDistance, MaxLeapDistance = args.MaxLeapDistance, LeapPrepareTime = 0.5, LeapRecoveryTime = 0.3, IgnoreUnitCollision = args.IgnoreUnitCollision } )
end

function FrogFamiliarAI( familiar, args )
	args = args or {}
	local followDistance = familiar.LeapRestDistance
	if not IsCombatEncounterActive( CurrentRun ) then
		followDistance = familiar.LeapRestDistanceNonCombat
	end

	if args.Equipping then
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Frog_Greet" })
	end

	wait( 0.5, familiar.AIThreadName )

	while IsAIActive( familiar ) do
		if IsInputAllowed({ }) then
			if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = followDistance, ScaleY = familiar.LeapRestDistanceScaleY }) then
				local moveOffset = CalcOffset( math.rad( RandomFloat( 0, 360 ) ), RandomFloat( familiar.LeapRandomOffsetMin, familiar.LeapRandomOffsetMax ) )
				FrogLeap( familiar, { OffsetX = moveOffset.X, OffsetY = moveOffset.Y })
			end
		end
		wait( 0.3, familiar.AIThreadName )
	end
	familiar.AIBehavior = nil
end

function FrogFamiliarGetRecoveryTime( familiar )
	local leapRecoveryTime = familiar.LeapRecoveryTime
	if not IsCombatEncounterActive( CurrentRun ) then
		leapRecoveryTime = familiar.LeapRecoveryTimeNonCombat
	elseif not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.LeapFastRecoveryDistance, ScaleY = familiar.LeapFastRecoveryDistanceScaleY }) then
		leapRecoveryTime = familiar.LeapRecoveryTimeFast
	elseif familiar.Linked then
		leapRecoveryTime = familiar.LeapRecoveryTimeLinked
	end
	return leapRecoveryTime
end

function FrogLeap( familiar, args )
	args = args or {}
	local targetId = args.Id or CurrentRun.Hero.ObjectId
	if args.MinLeapDistance ~= nil and IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = args.MinLeapDistance }) then
		if familiar.PreparingForLeap then
			SetAnimation({ DestinationId = familiar.ObjectId, Name = familiar.LeapLandingAnimation })
			familiar.PreparingForLeap = nil
		end
		return
	end

	familiar.BlockVictoryPresentation = true

	local room = CurrentHubRoom or RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local maxLeapDistance = args.MaxLeapDistance or room.FrogFamiliarMaxLeapDistance or familiar.LeapDistanceMax
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = maxLeapDistance, ScaleY = familiar.LeapDistanceMaxScaleY }) then
		local angle = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = targetId })
		local offset = CalcOffset( math.rad( angle ), maxLeapDistance )
		familiar.LockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = familiar.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	else
		familiar.LockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId, OffsetX = args.OffsetX, OffsetY = args.OffsetY })
	end

	if (args.Id == nil and room.FamiliarsPreferSpawnPointMovement) or IsLocationBlocked({ Id = familiar.LockedTargetId, CheckUnits = not args.IgnoreUnitCollision, PathfindersPreferAvoid = false }) then
		local spawnPointId = nil
		local familiarPoints = GetIdsByType({ Name = "FamiliarPoint" })
		spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = familiarPoints, Distance = maxLeapDistance, ScaleY = familiar.LeapDistanceMaxScaleY, MaxDistanceFromId = familiar.ObjectId, RequiredLocationUnblocked = true })
		if spawnPointId <= 0 or spawnPointId == familiar.LastSpawnPointId then
			-- No distance restriction for backup jump
			spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = familiarPoints, RequiredLocationUnblocked = true })
		end
		if spawnPointId == familiar.LastSpawnPointId then
			-- Already on the closest available point, do nothing
			wait( args.LeapRecoveryTime or FrogFamiliarGetRecoveryTime( familiar ), familiar.LeapRecoveryThreadName )
			Destroy({ Id = familiar.LockedTargetId })
			familiar.LockedTargetId = nil
			familiar.BlockVictoryPresentation = false
			return
		end
		if spawnPointId <= 0 then
			spawnPointId = nil
		end
		familiar.LastSpawnPointId = spawnPointId
		Teleport({ Id = familiar.LockedTargetId, DestinationId = spawnPointId or CurrentRun.Hero.ObjectId })
	else
		familiar.LastSpawnPointId = nil
	end

	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = familiar.LockedTargetId })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = familiar.LeapChargeAnimation })
	PlaySound({ Name = familiar.LeapChargeSound, Id = familiar.ObjectId })
	familiar.PreparingForLeap = true
	wait( args.LeapPrepareTime or familiar.LeapPrepareTime, familiar.AIThreadName )
	familiar.PreparingForLeap = nil

	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetThingProperty({ DestinationId = familiar.ObjectId, Property = "Grip", Value = 0 })
	AddInteractBlock( familiar, "Jumping" )
	familiar.IsJumping = true
	Stop({ Id = familiar.ObjectId })
	Halt({ Id = familiar.ObjectId })
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = familiar.LockedTargetId })
	ApplyForce({ Id = familiar.ObjectId, Angle = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = familiar.LockedTargetId }), Speed = familiar.LeapSpeed, SelfApplied = true })
	local distanceToTarget = GetDistance({ Id = familiar.ObjectId, DestinationId = familiar.LockedTargetId })
	local neededHangTime = distanceToTarget / familiar.LeapSpeed
	ApplyUpwardForce({ Id = familiar.ObjectId, HangTime = neededHangTime })
	PlaySound({ Name = familiar.LeapSound, Id = familiar.ObjectId })
	wait( neededHangTime, familiar.AIThreadName )
	familiar.IsJumping = false
	RemoveInteractBlock( familiar, "Jumping" )
	SetThingProperty({ DestinationId = familiar.ObjectId, Property = "Grip", Value = "Default" })
	SetUnitProperty({ DestinationId = familiar.ObjectId, Property = "CollideWithObstacles", Value = true })

	if args.ForceToLocation then
		Teleport({ Id = familiar.ObjectId, DestinationId = familiar.LockedTargetId })
	end

	SetAnimation({ DestinationId = familiar.ObjectId, Name = familiar.LeapLandingAnimation })
	CreateProjectileFromUnit({ Name = "FrogFamiliarLand", Id = familiar.ObjectId, Destination = familiar.ObjectId })
	Destroy({ Id = familiar.LockedTargetId })
	familiar.LockedTargetId = nil

	familiar.BlockVictoryPresentation = false

	wait( args.LeapRecoveryTime or FrogFamiliarGetRecoveryTime( familiar ), familiar.LeapRecoveryThreadName )
end

function FrogHitResponse( unit, triggerArgs )
	if unit.IsJumping then
		return
	end
	local angle = GetAngleBetween({ DestinationId = unit.ObjectId, Id = triggerArgs.AttackerId })
	ApplyForce({ Id = unit.ObjectId, Speed = unit.OnHitForce, Angle = angle, SelfApplied = true })
	SetAnimation({ Name = unit.BlockAnimation, DestinationId = unit.ObjectId })
end

function FrogFamiliarLinkBegin( familiar )
	SetThreadWait( familiar.LeapRecoveryThreadName, 0 )
end

-- Toula / CatFamiliar

function CatFamiliarStopAI( familiar )
	Stop({ Id = familiar.ObjectId })

	StopAnimation({ Name = familiar.ActivateVFX, DestinationId = familiar.ObjectId })
	familiar.ActivateVfxId = nil
	RemoveInteractBlock( familiar, "Equipping" )
	RemoveInteractBlock( familiar, "Alerted" )
	RemoveInteractBlock( familiar, "PetFamiliarCat" )
	familiar.ReadyToAttack = false

	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	CancelNotify({ Name = familiar.AINotifyName })
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
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = args.SuccessDistance }) then
		Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance, OnFailGoToNearestToGoal = args.OnFailGoToNearestToGoal })
		NotifyOnStopped({ Id = familiar.ObjectId, DestinationId = targetLocation, Notify = familiar.AINotifyName, Timeout = 9.0 })
		waitUntil( familiar.AINotifyName )
	end
	Stop({ Id = familiar.ObjectId })

	if args.ForceToLocation then
		Teleport({ Id = familiar.ObjectId, DestinationId = targetLocation })
	end

	if not args.StayAwake then
		wait( 0.2, familiar.AIThreadName )
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

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	familiar.ReadyToAttack = true
	while IsAIActive( familiar ) do
		-- Wait for hero to sprint by
		if familiar.ReadyToAttack and familiar.ActivateVfxId == nil then
			familiar.ActivateVfxId = CreateAnimation({ Name = familiar.ActivateVFX, DestinationId = familiar.ObjectId })
		end
		NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
									Distance = familiar.ActivateDistance, ScaleY = familiar.ActivateDistanceScaleY,
									Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		if CatFamiliarShouldAlert( familiar, args ) then
			AddInteractBlock( familiar, "Alerted" )
			familiar.BlockVictoryPresentation = true

			thread( MarkObjectiveComplete, "ActivateCatFamiliar" )
			CatFamiliarAlertedPresentation( familiar, args )
			wait( 1.0, familiar.AIThreadName )

			local numAttacks = GetTotalHeroTraitValue( "FamiliarCatAttackCount" )
			local scanAttempts = 0
			while numAttacks >= 1 do
				local eligibleIds = {}
				for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
					if not enemy.IsDead and ( enemy.RequiredKill or enemy.FamiliarTarget ) and IsEmpty( enemy.InvulnerableFlags ) then
						table.insert( eligibleIds, id )
					end
				end
				local targetId = GetClosest({ Id = familiar.ObjectId, DestinationIds = eligibleIds, Distance = familiar.TargetSearchDistance, IgnoreHomingIneligible = true, IgnoreSelf = true })
				if targetId > 0 then
					local distanceToTarget = GetDistance({ Id = familiar.ObjectId, DestinationId = targetId })
					if distanceToTarget > familiar.AttackDistance then
						local enemy = ActiveEnemies[targetId]
						Move({ Id = familiar.ObjectId, DestinationId = targetId })
						NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = enemy.CatFamiliarAttackDistance or familiar.AttackDistance, Notify = familiar.AINotifyName, Timeout = 9.0 })
						waitUntil( familiar.AINotifyName )
					end
					Stop({ Id = familiar.ObjectId })
					if ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
						CatFamiliarPreAttackPresentation( familiar, args )
						local angleToTarget = GetAngleBetween({ Id = familiar.ObjectId, DestinationId = targetId })
						AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetId })
						wait( 0.25, familiar.AIThreadName )
						CatFamiliarAttackPresentation( familiar, args )
						ApplyForce({ Id = familiar.ObjectId, Speed = familiar.AttackVelocity, Angle = angleToTarget })
						CreateProjectileFromUnit({ Name = "CatFamiliarPounce", Id = familiar.ObjectId })
						wait( 1.5, familiar.AIThreadName )
						numAttacks = numAttacks - 1
					else
						-- don't waste an attack on an enemy that's already dead
						wait( 0.1, familiar.AIThreadName )
					end
					scanAttempts = 0
				else
					if scanAttempts < familiar.ScanMaxAttempts and FamiliarShouldUseCombatLogic() then
						scanAttempts = scanAttempts + 1
						wait( familiar.ScanWaitDuration, familiar.AIThreadName )
					else
						break
					end
				end
			end
			
			CatFamiliarMoveToRandomLocation( familiar, { OnlyUseFamiliarPoints = roomData.CatFamiliarOnlyRestOnFamiliarPoints } )

			RemoveInteractBlock( familiar, "Alerted" )
			familiar.BlockVictoryPresentation = false
		else
			wait( 0.05, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil

end

function CatFamiliarMoveToRandomLocation( familiar, args )
	args = args or {}
	local spawnPointIds = nil
	if args.OnlyUseFamiliarPoints then
		spawnPointIds = GetIdsByType({ Name = "FamiliarPoint" })
	else
		spawnPointIds = GetClosestIds({ Id = familiar.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), Distance = familiar.WanderDistance, ScaleY = familiar.WanderDistanceScaleY, RequiredLocationUnblocked = true })
	end
	
	RemoveValue( spawnPointIds, familiar.LastSpawnPointId )
	local randomSpawnPointId = GetRandomValue( spawnPointIds )
	familiar.LastSpawnPointId = randomSpawnPointId
	CatFamiliarMoveToLocation( familiar, { Id = randomSpawnPointId, SuccessDistance = 100, KeepAIAlive = true } )
end

-- Raki / RavenFamiliar

function RavenFamiliarStopAI( familiar, args )
	args = args or {}
	Stop({ Id = familiar.ObjectId })
	if not args.RemainBlockedForEquip then
		RemoveInteractBlock( familiar, "Equipping" )
	end
	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	killWaitUntilThreads( familiar.TeleportWhenStoppedThreadName )
	CancelNotify({ Name = familiar.AINotifyName })
	wait( 0.02 )
end

function RavenFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		RavenFamiliarStopAI( familiar, args )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId

	if familiar.TargetHeight == familiar.GroundHeight then
		familiar.TargetHeight = familiar.FlightHeight
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Perch_End" })
		wait( 0.2, familiar.AIThreadName )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = targetLocation, Duration = 0.3 })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.5 })
		wait( 0.55, familiar.AIThreadName )
	end

	familiar.SpawnPointOccupiedId = nil
	Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance })
	NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = args.NotifyDistance or 120, Notify = familiar.AINotifyName, Timeout = 9.0 })
	waitUntil( familiar.AINotifyName )

	if not args.KeepFlyingOnFinish then
		familiar.TargetHeight = familiar.GroundHeight
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Perch_Start" })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.GroundHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.3 })
		if args.ForceToLocation then
			thread( RavenFamiliarTeleportWhenStopped, familiar, targetLocation )
		end
		wait( 0.8, familiar.AIThreadName )
	end
end

function RavenFamiliarTeleportWhenStopped( familiar, targetId )
	NotifyOnStopped({ Id = familiar.ObjectId, Notify = familiar.TeleportWhenStoppedThreadName })
	waitUntil( familiar.TeleportWhenStoppedThreadName )
	Teleport({ Id = familiar.ObjectId, DestinationId = targetId })
end

function RavenFamiliarAI( familiar, args )
	args = args or {}

	local minTimeBetweenAttacks = GetTotalHeroTraitValue( "FamiliarRavenAttackMinDuration" )
	local maxTimeBetweenAttacks = GetTotalHeroTraitValue( "FamiliarRavenAttackMaxDuration" )

	if args.InitialDelay ~= nil then
		wait( args.InitialDelay, familiar.AIThreadName )
	end

	local doEquip = args.Equipping
	if familiar.StartingAsEquippedFamiliar then
		familiar.StartingAsEquippedFamiliar = nil
		NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		NotifyOutsideDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		doEquip = true
	end

	if doEquip then
		AddInteractBlock( familiar, "Equipping" )
		RavenFamiliarMoveToLocation( familiar, { Id = 589725, RemainBlockedForEquip = true } )
		RemoveInteractBlock( familiar, "Equipping" )
	end

	while IsAIActive( familiar ) do
		while FamiliarShouldUseCombatLogic() do

			if familiar.Linked then
				-- Raki will have either just flown down from the heavens, or he just flew to a spawn point near the player.
				wait( 1.0, familiar.AIThreadName )
			else
				if familiar.TargetHeight ~= familiar.SkyHeight then
					RavenFamiliarDropExitPresentation( familiar )
				end
				wait( RandomFloat( minTimeBetweenAttacks, maxTimeBetweenAttacks ), familiar.AIThreadName )

				-- Remain idle in the air during boss kill presentations.
				-- The victory presentation will reenable Raki's AI.
				if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
					RavenFamiliarStopAI( familiar )
					return
				end

				Stop({ Id = familiar.ObjectId })
				RavenFamiliarDropEnterPresentation( familiar )
			end
			
			-- Attack!
			local eligibleIds = {}
			for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if not enemy.IsDead and ( enemy.RequiredKill or enemy.FamiliarTarget ) and IsEmpty( enemy.InvulnerableFlags ) then
					table.insert( eligibleIds, id )
				end
			end
			local targetId = GetClosest({ Id = familiar.ObjectId, DestinationIds = eligibleIds, Distance = familiar.TargetSearchDistance, IgnoreHomingIneligible = true, IgnoreSelf = true })
			if targetId > 0 then
				if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetId, Distance = familiar.AttackDistance }) then
					RavenFamiliarMoveToLocation( familiar, { Id = targetId, NotifyDistance = familiar.AttackDistance, KeepAIAlive = true, KeepFlyingOnFinish = true })
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
				wait( 0.35, familiar.AIThreadName )
			end

			wait( 1.0, familiar.AIThreadName )

			if familiar.Linked then
				local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true })
				RavenFamiliarMoveToLocation( familiar, { Id = spawnPointId, KeepAIAlive = true, KeepFlyingOnFinish = true })
			end
		end
		if familiar.TargetHeight ~= familiar.GroundHeight then
			local closestSpawnPoint = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true })
			RavenFamiliarMoveToLocation( familiar, { Id = closestSpawnPoint, KeepAIAlive = true } )
		else
			-- hang out and wait for a new combat encounter to start
			wait( 0.2, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil
end

function ClearRavenMark( victim, args )
	ClearEffect({ Id = victim.ObjectId, Name = "RavenFamiliarMark" })
end

function RavenFamiliarLinkBegin( familiar )
	if CurrentHubRoom ~= nil then
		return
	end
	if familiar.TargetHeight == familiar.SkyHeight then
		-- Technically redundant since DropEnterPresentation teleports Raki too, but we need him at his new position now to spawn the cast!
		local closestSpawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints" })
		Teleport({ Id = familiar.ObjectId, DestinationId = closestSpawnPointId })

		RavenFamiliarStopAI( familiar )
		RavenFamiliarDropEnterPresentation( familiar )
		ReenableFamiliar( familiar )
	end
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
	CancelNotify({ Name = familiar.AINotifyName })
	wait( 0.02 )
end

function HoundFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		HoundFamiliarStopAI( familiar )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = args.SuccessDistance }) then
		Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance, OnFailGoToNearestToGoal = args.OnFailGoToNearestToGoal, AvoidUnits = not args.IgnoreUnitCollision })
		NotifyOnStopped({ Id = familiar.ObjectId, DestinationId = targetLocation, Notify = familiar.AINotifyName, Timeout = 9.0 })
		waitUntil( familiar.AINotifyName )
	end

	if args.ForceToLocation then
		Teleport({ Id = familiar.ObjectId, DestinationId = targetLocation })
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

	local followDistance = familiar.FollowRestDistance
	if not IsCombatEncounterActive( CurrentRun ) then
		followDistance = familiar.FollowRestDistanceNonCombat
	end

	local minTimeBetweenBarks = GetTotalHeroTraitValue( "FamiliarHoundBarkMinDuration" )
	local maxTimeBetweenBarks = GetTotalHeroTraitValue( "FamiliarHoundBarkMaxDuration" )

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	HoundFamiliarStartEncounter( familiar )

	wait( 0.5, familiar.AIThreadName )

	while IsAIActive( familiar ) do
		local moved = false
		if IsInputAllowed({ }) and not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = followDistance, ScaleY = familiar.FollowRestDistanceScaleY }) then
			local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true })
			if spawnPointId ~= familiar.LastSpawnPointId and ( not roomData.HoundFamiliarMovementRequiresLineOfSight or HasLineOfSight({ Id = familiar.ObjectId, DestinationId = spawnPointId, StopsUnits = true }) ) then

				familiar.BlockVictoryPresentation = true

				-- Move
				familiar.LastSpawnPointId = spawnPointId
				Move({ Id = familiar.ObjectId, DestinationId = spawnPointId, SuccessDistance = 100, AvoidUnits = not roomData.HoundFamiliarIgnoreUnitsForPathfinding })
				NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = spawnPointId, Distance = 120, Notify = familiar.AINotifyName, Timeout = 3.0 })
				waitUntil( familiar.AINotifyName )
				moved = true

				familiar.BlockVictoryPresentation = false

			end
		end
		if not moved then
			local restTime = familiar.MoveRestTime
			if familiar.Linked then
				restTime = familiar.MoveRestTimeLinked
			end
			wait( restTime, familiar.AIThreadName )
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
					familiar.BarkCooldown = RandomFloat( minTimeBetweenBarks, maxTimeBetweenBarks )
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
					familiar.DigCooldown = RandomFloat( familiar.TimeBetweenDigsMin, familiar.TimeBetweenDigsMax )
					wait( 0.5, familiar.AIThreadName )
				end
			end
		end
	end
	familiar.AIBehavior = nil
end

function HoundFamiliarStartEncounter( familiar )
	familiar.ManaDigCount = 0
	familiar.DigCooldown = RandomFloat( familiar.TimeBetweenDigsMin, familiar.TimeBetweenDigsMax )
	TriggerCooldown( "FamiliarHoundDig" )

	familiar.BarkCooldown = 0
	TriggerCooldown( "FamiliarHoundBark" )
end

-- Polecat (Gale)

function PolecatFamiliarStopAI( familiar, args )
	args = args or {}
	Stop({ Id = familiar.ObjectId })
	if not args.RemainBlockedForEquip then
		RemoveInteractBlock( familiar, "Equipping" )
	end
	familiar.DisableAIWhenReady = true
	familiar.AIDisabled = true
	familiar.AIBehavior = nil
	killTaggedThreads( familiar.AIThreadName )
	killTaggedThreads( familiar.BurrowCooldownThreadName )
	killWaitUntilThreads( familiar.AINotifyName )
	CancelNotify({ Name = familiar.AINotifyName })
	wait( 0.02 )
end

function PolecatFamiliarMoveToLocation( familiar, args )
	args = args or {}
	if not args.KeepAIAlive then
		PolecatFamiliarStopAI( familiar, args )
	end

	local targetLocation = args.Id or CurrentRun.Hero.ObjectId
	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = targetLocation, Distance = args.SuccessDistance }) then
		Move({ Id = familiar.ObjectId, DestinationId = targetLocation, SuccessDistance = args.SuccessDistance, OnFailGoToNearestToGoal = true, AvoidUnits = not args.IgnoreUnitCollision })
		NotifyOnStopped({ Id = familiar.ObjectId, DestinationId = targetLocation, Notify = familiar.AINotifyName, Timeout = 9.0 })
		waitUntil( familiar.AINotifyName )
	end

	if args.ForceToLocation then
		Teleport({ Id = familiar.ObjectId, DestinationId = targetLocation })
	end
end

function PolecatFamiliarAI( familiar, args )
	args = args or {}

	local doEquip = args.Equipping
	local skipWiggle = false
	if familiar.StartingAsEquippedFamiliar then
		familiar.StartingAsEquippedFamiliar = nil
		NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		NotifyOutsideDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = 400, Notify = familiar.AINotifyName })
		waitUntil( familiar.AINotifyName )
		doEquip = true
		skipWiggle = true
	end

	if doEquip then
		AddInteractBlock( familiar, "Equipping" )
		if not skipWiggle then
			SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Polecat_Greet" })
			wait( 1.1, familiar.AIThreadName )
		end
		PolecatFamiliarMoveToLocation( familiar, { Id = 589725, RemainBlockedForEquip = true } )
		RemoveInteractBlock( familiar, "Equipping" )
	end

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom
	if roomData.PolecatFamiliarShouldNotFollow then
		PolecatFamiliarStopAI( familiar )
		return
	end

	familiar.CanGuard = not familiar.Burrowing

	local traitData = GetHeroTrait( familiar.TraitNames[1] )
	if traitData.RemainingBlocks <= 0 and IsCombatEncounterActive( CurrentRun ) then
		familiar.CanGuard = false
		PolecatFamiliarBurrowPresentation( familiar )
	end

	while IsAIActive( familiar ) do
		if IsInputAllowed({ }) and not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.FollowRestDistance, ScaleY = familiar.FollowRestDistanceScaleY }) then
			Move({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, SuccessDistance = familiar.FollowRadius })
			NotifyWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.FollowRadius + 10, Notify = familiar.AINotifyName, Timeout = 9.0 })
			waitUntil( familiar.AINotifyName )
			Stop({ Id = familiar.ObjectId })
		else
			wait( 0.02, familiar.AIThreadName )
		end
	end
	familiar.AIBehavior = nil
end

function PolecatFamiliarGuard( familiar, args )

	local familiarId = familiar.ObjectId

	-- Block!
	familiar.CanGuard = false
	PolecatFamiliarStopAI( familiar )

	local impactAngle = args.ImpactAngle or GetAngleBetween({ Id = familiarId, DestinationId = CurrentRun.Hero.ObjectId })
	Stop({ Id = familiarId })
	Teleport({ Id = familiarId, DestinationId = CurrentRun.Hero.ObjectId })
	SetPlayerInvulnerable( "PolecatFamiliarGuard" )

	PolecatFamiliarGuardPresentation( familiar, { Timeout = 1.0 } )
	waitUnmodified( 0.1, familiar.AIThreadName )

	-- Attack!
	local targetId = args.AttackerId or GetClosest({ Id = familiarId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true })
	if targetId ~= nil and not IsLocationBlocked({ Id = targetId, CheckUnits = false }) then
		PlaySound({ Name = familiar.RushSound or "/EmptyCue", Id = familiar.ObjectId, Delay = 0.2 })
		Move({ Id = familiarId, DestinationId = targetId, SuccessDistance = familiar.AttackDistance })
		NotifyWithinDistance({ Id = familiarId, DestinationId = targetId, Distance = familiar.AttackDistance + 10, Notify = familiar.AINotifyName, Timeout = 9.0 })
		waitUntil( familiar.AINotifyName )
		Stop({ Id = familiarId })
		waitUnmodified( 0.1, familiar.AIThreadName )
		AngleTowardTarget({ Id = familiarId, DestinationId = targetId })
		SetAnimation({ DestinationId = familiarId, Name = "Familiar_Polecat_Attack" })
		waitUnmodified( 0.2, familiar.AIThreadName )
		CreateProjectileFromUnit({ Name = "PolecatFamiliarMelee", Id = familiarId })
		waitUnmodified( 0.35, familiar.AIThreadName )
	end
	PolecatFamiliarGuardEndPresentation( familiar )
	wait( 0.2, familiar.AIThreadName )
	SetPlayerVulnerable( "PolecatFamiliarGuard" )

	-- Burrow!
	PolecatFamiliarBurrowPresentation( familiar, args )
	if args.RemainingBlocks > 0 then
		thread( PolecatFamiliarBurrowCooldown, familiar )
	end
	ReenableFamiliar( familiar )

end

function PolecatFamiliarBurrowCooldown( familiar )
	wait( familiar.BurrowCooldown, familiar.BurrowCooldownThreadName )
	PolecatFamiliarStopAI( familiar )
	PolecatFamiliarUnburrowPresentation( familiar )
	ReenableFamiliar( familiar )
end

function PolecatFamiliarStartEncounter( familiar, args )
	local traitData = GetHeroTrait( familiar.TraitNames[1] )
	if traitData.RemainingBlocks <= 0 then
		PolecatFamiliarStopAI( familiar )
		PolecatFamiliarBurrowPresentation( familiar )
		ReenableFamiliar( familiar )
	end
end

-- Helper Functions

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

function GetFamiliarUpgradeCount( traitData )
	local traitFamiliarName = nil
	for familiarName, familiarData in pairs( FamiliarData ) do
		if familiarData.TraitNames ~= nil and familiarData.TraitNames[1] == traitData.Name then
			traitFamiliarName = familiarName
			break
		end
	end
	local count = 0
	for i, unlockName in ipairs( ScreenData.FamiliarShop.ItemOrder ) do
		if GameState.FamiliarUpgrades[unlockName] then
			local shopItemData = FamiliarShopItemData[unlockName]
			if shopItemData ~= nil and shopItemData.FamiliarName == traitFamiliarName then
				count = count + 1
			end
		end
	end
	return count
end

function AdjustFamiliarPathfinding( familiar, args )

	if args.ResetNodeDistances then
		if SessionMapState.FamiliarOriginalNodeDistance ~= nil then
			SetMoveAIProperty({ DestinationId = familiar.ObjectId, Property = "NodeDistance", Value = SessionMapState.FamiliarOriginalNodeDistance })
			SessionMapState.FamiliarOriginalNodeDistance = nil
		end
		if SessionMapState.FamiliarOriginalNodeSuccessDistance ~= nil then
			SetMoveAIProperty({ DestinationId = familiar.ObjectId, Property = "NodeSuccessDistance", Value = SessionMapState.FamiliarOriginalNodeSuccessDistance })
			SessionMapState.FamiliarOriginalNodeSuccessDistance = nil
		end
		return
	end

	if args.NodeDistance ~= nil then
		SessionMapState.FamiliarOriginalNodeDistance = GetMoveAIProperty({ Id = familiar.ObjectId, Property = "NodeDistance" })
		SetMoveAIProperty({ DestinationId = familiar.ObjectId, Property = "NodeDistance", Value = args.NodeDistance })
	end
	if args.NodeSuccessDistance ~= nil then
		SessionMapState.FamiliarOriginalNodeSuccessDistance = GetMoveAIProperty({ Id = familiar.ObjectId, Property = "NodeSuccessDistance" })
		SetMoveAIProperty({ DestinationId = familiar.ObjectId, Property = "NodeSuccessDistance", Value = args.NodeSuccessDistance })
	end
	if args.Points ~= nil then
		SetGeometry({ Id = familiar.ObjectId, Points = args.Points })
	end

end
