function HarvestBlockedPresentation( source, args )
	thread( InCombatText, CurrentRun.Hero.ObjectId, args.Text, 1.0, { ShadowScale = 0.6 } )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })
end

function HarvestNoToolPresentation( source, args, user, toolName )
	if CheckCooldown( "UseNoToolPlayedRecently", 1.2 ) then
		thread( InCombatText, user.ObjectId, "UseNoTool", 1.0, { ShadowScale = 0.6 } )
	end
	thread( PlayVoiceLines, HeroVoiceLines.ToolTutorialVoiceLines, true )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	if not HasAccessToTool( "ToolExorcismBook" ) and CheckCooldown( "GhostEmotedRecently", 7.0 ) then
		thread( PlayEmote, { Target = source, EmoteName = "Fear", PlaySound = true, DelayMax = 0.1 } )
	end
end

function HarvestStartPresentation( source, args, user )
	args = args or {}

	AddOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "HarvestPointUseCanceled"
	user.PreHarvestThreadName = "HarvestStartPresentation"

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	waitUnmodified( 0.1, user.PreHarvestThreadName )

	-- thread( PlayVoiceLines, args.VoiceLines or HeroVoiceLines.HarvestVoiceLines, true )

	waitUnmodified( 0.1, user.PreHarvestThreadName )

	RemoveOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil

	PlaySound({ Name = source.PickUpSound or "/SFX/ResourceGatherSFX", Id = user.ObjectId })

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })
	waitUnmodified(0.1)

	if args.PresentationFunctionName ~= nil then
		CallFunctionName( args.PresentationFunctionName, source, args, user )
	else
		UsedHarvestPointPresentation( source, args, user )
	end
	
end

function UsedHarvestPointPresentation( source, args, user )
	args = args or {}
	SetAnimation({ Name = source.EmptyAnimation or "HarvestPointUsed", DestinationId = source.ObjectId })
	SetScale({ Id = source.ObjectId, Fraction = 0.0, EaseIn = 0, EaseOut = 1, Duration = 0.15 })
	CreateAnimation({ Name = source.ConsumeFx or "ItemConsumeFxSmall", DestinationId = source.ObjectId, Group = "Standing" })

	local harvestPointUsedAnimation = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Terrain", DestinationId = source.ObjectId })
	CreateAnimation({ Name = source.EmptyAnimation or "HarvestPointUsed", DestinationId = harvestPointUsedAnimation })
	SetScaleY({ Id = harvestPointUsedAnimation, Fraction = 0 })
	SetAlpha({ Id = harvestPointUsedAnimation, Fraction = 0 })
	SetScaleY({ Id = harvestPointUsedAnimation, Fraction = 1, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = harvestPointUsedAnimation, Fraction = 1, Duration = 0.25, EaseIn = 0, EaseOut = 1 })

	if not args.SkipVoiceLines then
		thread( PlayVoiceLines, HeroVoiceLines.HarvestVoiceLines, true, nil, { HarvestPoint = source } )
	end

	waitUnmodified(0.15)
	SetAnimation({ Name = "Blank", DestinationId = source.ObjectId})
	
	if source.HarvestedDrawGroup ~= nil then
		ChangeDrawGroup( source.ObjectId, source.HarvestedDrawGroup )
	end
	waitUnmodified(0.4)
end

function UsedTrashPointPresentation( source, args, user )
	if GameState.WorldUpgrades.WorldUpgradeErisTrashPickup then
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = CurrentRun.Hero.ObjectId })
	end
	for _, id in ipairs( args.TrashPointIds ) do
		SetAnimation({ Name = source.EmptyAnimation, DestinationId = id })
		CreateAnimation({ Name = source.ConsumeFx, DestinationId = id, Group = "Standing" })
		waitUnmodified( 0.02 )
	end
	-- thread( PlayVoiceLines, HeroVoiceLines.HarvestVoiceLines, true, nil, { HarvestPoint = source } )
	waitUnmodified( 0.55 )
end

function HarvestEndPresentation( source, args, user )	
	waitUnmodified( 0.2 )
end

function FamiliarHarvestStartPresentation( source, args, user )
	local familiar = MapState.FamiliarUnit
	familiar.BlockVictoryPresentation = true

	local originalCanGuard = familiar.CanGuard
	familiar.CanGuard = false

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = familiar.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })

	PolecatFamiliarStopAI( familiar )

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.25 )
	PlaySound({ Name = familiar.EquipSound or "/EmptyCue", Id = familiar.ObjectId })
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, })
	if not familiar.Burrowing then
		CreateAnimation({ Name = "ItemGet_Tool", DestinationId = familiar.ObjectId, OffsetZ = -60 })
	end

	waitUnmodified( 0.15 )

	thread( BackPlayerUpForHarvest, user, source )

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = source.ObjectId, Distance = familiar.MinDistanceToTeleportForHarvestPoints })
		or ( roomData.PolecatFamiliarMovementRequiresLineOfSight and not HasLineOfSight({ Id = familiar.ObjectId, DestinationId = source.ObjectId, StopsUnits = true }) )
		or familiar.Burrowing then

		if not familiar.Burrowing then
			SetAnimation({ Name = "Familiar_Polecat_DropIn_Exit", DestinationId = familiar.ObjectId })
			wait(0.2)

			-- teleport to the closest spawn point first
			FamiliarTeleportPresentation( familiar )
			SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
			wait( 0.21 )
		end

		local spawnPointId = GetClosest({ Id = source.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
		FamiliarTeleportPresentation( familiar )
		SetAnimation({ Name = "Familiar_Polecat_DropIn_Enter", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.18 )

		PolecatFamiliarMoveToLocation( familiar, { Id = source.ObjectId, SuccessDistance = 130 } )
	else
		-- speed up for non-teleport version
		local initialSpeed = GetUnitDataValue({ Id = familiar.ObjectId, Property = "Speed" })
		SetUnitProperty({ Property = "Speed", Value = 900, DestinationId = familiar.ObjectId })
		PolecatFamiliarMoveToLocation( familiar, { Id = source.ObjectId, SuccessDistance = 130 } )
		SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = familiar.ObjectId })
	end

	waitUnmodified(0.05)
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
	waitUnmodified(0.05)
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Polecat_Harvest" })
	waitUnmodified(0.3)

	PlaySound({ Name = source.PickUpSound or "/SFX/ResourceGatherSFX", Id = user.ObjectId })
	thread( UsedHarvestPointPresentation, source, args, user )
	familiar.BlockVictoryPresentation = false
	familiar.CanGuard = originalCanGuard
end

function ShovelStartPresentation( source, args, user )

	AddOnDamagedFunction( user, "ShovelPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "ShovelPointUseCanceled"
	user.PreHarvestThreadName = "ShovelStartPresentation"

	waitUnmodified( 0.02, user.PreHarvestThreadName )

	SetAnimation({ Name = "Melinoe_Shovel_Start", DestinationId = user.ObjectId })	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })
	waitUnmodified(0.5, user.PreHarvestThreadName)
	CreateAnimation({ Name = "ShovelDirtIn", DestinationId = user.ObjectId })
	waitUnmodified(0.17, user.PreHarvestThreadName)

	SetAnimation({ Name = "Melinoe_Shovel_FireLoop", DestinationId = user.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.7, Duration = 0.2 }, } )	
	ShakeScreen({ Speed = 300, Distance = 6, Duration = 0.1, FalloffSpeed = 10000, Angle = 90 })
	waitUnmodified( RandomFloat(0.3, 0.3), user.PreHarvestThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.ShovelVoiceLines, true )

	Shake({ Id = user.ObjectId, Speed = 100, Distance = 1, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.5, Duration = 0.5 }, } )
	waitUnmodified( 0.3, user.PreHarvestThreadName )

	Shake({ Id = user.ObjectId, Speed = 200, Distance = 2, Duration = 0.2 })
	waitUnmodified( 0.2, user.PreHarvestThreadName )

	SetAnimation({ Name = "Melinoe_Shovel_End", DestinationId = user.ObjectId })
	waitUnmodified( 0.1, user.PreHarvestThreadName )

	ShakeScreen({ Speed = 300, Distance = 6, Duration = 0.1, FalloffSpeed = 10000, Angle = 90 })	
	RemoveOnDamagedFunction( user, "ShovelPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil
	CreateAnimation({ Name = "ShovelDirtOutSpray", DestinationId = source.ObjectId })
	waitUnmodified( 0.12 )

end

function UsedShovelPointOnExitPresentation( source )
	CreateAnimation({ Name = "ShovelDirtOutSpray", DestinationId = source.ObjectId })
	waitUnmodified( 0.12 )
	SetAnimation({ Name = "ShovelPointUsed", DestinationId = source.ObjectId })
end

function ShovelEndPresentation( source, args, user )
	SetAnimation({ Name = "ShovelPointUsed", DestinationId = source.ObjectId })
	waitUnmodified( 0.1 )
	thread( PlayVoiceLines, GlobalVoiceLines.PositiveReactionVoiceLines, true )
end

function ShovelPointBombPresentation( source, args, user )
	thread( PlayVoiceLines, HeroVoiceLines.ShovelFoundBombVoiceLines, true )
	SetAnimation({ Name = "ShovelPointUsed", DestinationId = source.ObjectId })
	waitUnmodified( 0.1 )
end

function FamiliarShovelStartPresentation( source, args, user )

	local familiar = MapState.FamiliarUnit

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = familiar.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })

	HoundFamiliarStopAI( familiar )

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.25 )
	PlaySound({ Name = familiar.EquipSound or "/EmptyCue", Id = familiar.ObjectId })
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = familiar.ObjectId, OffsetZ = -60 })

	waitUnmodified( 0.15 )

	if familiar.HarvestSound ~= nil then
		PlaySound({ Name = familiar.HarvestSound, Id = familiar.ObjectId })
	end

	thread( BackPlayerUpForHarvest, user, source )

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = source.ObjectId, Distance = familiar.MinDistanceToTeleportForShovelPoints })
		or ( roomData.HoundFamiliarMovementRequiresLineOfSight and not HasLineOfSight({ Id = familiar.ObjectId, DestinationId = source.ObjectId, StopsUnits = true }) ) then

		SetAnimation({ Name = "Familiar_Hound_DropIn_Exit", DestinationId = familiar.ObjectId })
		wait(0.2)

		-- teleport to the closest spawn point first
		FamiliarTeleportPresentation( familiar )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
		wait( 0.21 )

		local spawnPointId = GetClosest({ Id = source.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
		FamiliarTeleportPresentation( familiar )
		SetAnimation({ Name = "Familiar_Hound_DropIn_Enter", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.18 )
	end

	AdjustFamiliarPathfinding( familiar, { NodeDistance = 16, NodeSuccessDistance = 8 } )
	HoundFamiliarMoveToLocation( familiar, { Id = source.ObjectId, KeepStandingOnFinish = true, SuccessDistance = 100 } )
	AdjustFamiliarPathfinding( familiar, { ResetNodeDistances = true })

	waitUnmodified(0.05)
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
	waitUnmodified(0.05)
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Hound_Dig_ShovelPoint" })
	waitUnmodified(0.18)
	CreateAnimation({ Name = "ShovelDirtInSprayHound", DestinationId = familiar.ObjectId })
	waitUnmodified(0.35)
	CreateAnimation({ Name = "ShovelDirtOutSprayHound", DestinationId = source.ObjectId })
	waitUnmodified(0.4)
end

function FamiliarPickaxeStartPresentation( source, args, user )

	local familiar = MapState.FamiliarUnit
	familiar.BlockVictoryPresentation = true

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = familiar.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })

	RavenFamiliarStopAI( familiar )

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.25 )
	PlaySound({ Name = familiar.EquipSound or "/EmptyCue", Id = familiar.ObjectId })
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, })
	if familiar.TargetHeight ~= familiar.SkyHeight then
		CreateAnimation({ Name = "ItemGet_Tool", DestinationId = familiar.ObjectId, OffsetZ = -60 })
	end

	waitUnmodified( 0.15 )

	if familiar.HarvestSound ~= nil then
		PlaySound({ Name = familiar.HarvestSound, Id = familiar.ObjectId })
	end

	thread( BackPlayerUpForHarvest, user, source )

	if GetDistance({ Id = familiar.ObjectId, DestinationId = source.ObjectId }) >= familiar.MinDistanceToTeleportWhenMining or familiar.TargetHeight == familiar.SkyHeight then
		if familiar.TargetHeight ~= familiar.SkyHeight then
			-- teleport to the closest spawn point first
			FamiliarTeleportPresentation( familiar )
			SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
			wait( 0.21 )
		end

		local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
		local roomData = RoomData[currentRoom.Name] or currentRoom

		local spawnPointId = GetClosest({ Id = source.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
		FamiliarTeleportPresentation( familiar )
		SetAnimation({ Name = "Familiar_Raven_Idle", DestinationId = familiar.ObjectId })
		familiar.TargetHeight = familiar.FlightHeight
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0 })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.18 )
	end

	RavenFamiliarMoveToLocation( familiar, { Id = source.ObjectId, KeepFlyingOnFinish = true, SuccessDistance = 120, NotifyDistance = 150 } )
	waitUnmodified(0.05)
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = source.ObjectId })
	waitUnmodified(0.26)
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Mine" })
	waitUnmodified(0.41)
	CreateAnimation({ Name = "OreHarvestSpark", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "OreHarvestSpike", DestinationId = source.ObjectId, Group = "FX_Standing_Add" })
	familiar.BlockVictoryPresentation = false

end

function PickaxeStartPresentation( source, args, user )	
	thread( PlayVoiceLines, HeroVoiceLines.PickaxeUseInProgressVoiceLines, true )

	SetAnimation({ Name = "MelinoePickAxeMineStart", DestinationId = user.ObjectId })

	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteEvading", Id = user.ObjectId })

	waitUnmodified( 0.06, user.PreHarvestThreadName )
	PlaySound({ Name = "/SFX/Player Sounds/WeaponSwing", Id = user.ObjectId })

	SetAnimation({ Name = "MelinoePickAxeMineSwing", DestinationId = user.ObjectId })
	waitUnmodified( 0.1, user.PreHarvestThreadName )
	CreateAnimation({ Name = "HarvestPickaxeSwing", DestinationId = user.ObjectId })
	waitUnmodified( 0.1, user.PreHarvestThreadName )

	CreateAnimation({ Name = "OreHarvestSpark", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "OreHarvestSpike", DestinationId = source.ObjectId, Group = "FX_Standing_Add" })

	Shake({ Id = source.ObjectId, Distance = 2, Speed = 300, Duration = 0.32 })
	PlaySound({ Name = "/SFX/PickaxeHitSFX", Id = source.ObjectId })

	waitUnmodified( 0.3, user.PreHarvestThreadName )
end

function PickaxeDepositDamagedPresentation( source, args, user )
	waitUnmodified( 0.1 )
	
end

function PickaxeDepositDestroyedPresentation( source, args )
	args = args or {}
	if not args.SkipSound then
		PlaySound({ Name = "/SFX/PickaxeOreDestroyed", Id = source.ObjectId })
	end
	CreateAnimation({ Name = "OreDepletedFx", DestinationId = source.ObjectId })

	SetAnimation({ Name = source.EmptyAnimation, DestinationId = source.ObjectId })

	if not args.SkipVoiceLines then
		thread( PlayVoiceLines, HeroVoiceLines.PickaxeDepositDestroyedVoiceLines, true )
	end

	if args.UsedFamiliar then
		PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
	end

	waitUnmodified( 0.1 )
	PlaySound({ Name = "/SFX/DustTouchdownPuff", Id = source.ObjectId })

end

function ExorcismPointChosenPresentation( source )
	LoadVoiceBanks({ Name = "Selene" })
	Flash({ Id = source.ObjectId, Speed = 4.0, MinFraction = 0.3, MaxFraction = 0.7, Color = Color.White, Duration = 0.8 })
	if source.LeftHintId == nil then
		source.LeftHintId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = source.ObjectId, OffsetX = -100, OffsetZ = 100, Group = "Combat_UI" })
		SetAnimation({ Name = "GUI\\Icons\\MelArmLeftBacking", DestinationId = source.LeftHintId })
		CreateTextBox({ Id =  source.LeftHintId,
			Text = "ExorcismLeftHint",
			FontSize = 22,
			OffsetX = 12, OffsetY = 102,
			Font = "P22UndergroundSCHeavy",
			Justification = "Center" })
	end
	if source.RightHintId == nil then
		source.RightHintId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = source.ObjectId, OffsetX = 100, OffsetZ = 100, Group = "Combat_UI" })
		SetAnimation({ Name = "GUI\\Icons\\MelArmRightBacking", DestinationId = source.RightHintId })
		CreateTextBox({ Id =  source.RightHintId,
			Text = "ExorcismRightHint",
			FontSize = 22,
			OffsetX = -12, OffsetY = 102,
			Font = "P22UndergroundSCHeavy",
			Justification = "Center" })
	end
	local hintIds = { source.LeftHintId, source.RightHintId }

	local pipSpacing = 55
	local pipOffsetX = ((#source.MoveSequence - 1) / 2) * -pipSpacing
	for index, move in ipairs( source.MoveSequence ) do
		local key = "MovePipId"..index
		source[key] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = source.ObjectId, OffsetX = pipOffsetX, OffsetZ = -80, Group = "Combat_UI" })
		SetAnimation({ Name = "ExorcismPip", DestinationId = source[key] })
		if index == 1 then
			CreateAnimation({ Name = "ExorcismPipBackingLeft", DestinationId = source[key] })
		elseif index == (#source.MoveSequence) then
			CreateAnimation({ Name = "ExorcismPipBackingRight", DestinationId = source[key] })
		else
			CreateAnimation({ Name = "ExorcismPipBackingMid", DestinationId = source[key] })
		end
		pipOffsetX = pipOffsetX + pipSpacing
		table.insert( hintIds, source[key] )
	end

	SetAlpha({ Ids = hintIds, Fraction = 0, Duration = 0.0 })

end

function FamiliarExorcismStartPresentation( source, args, user )

	-- PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/ExaltedPreAttackFlashSoundBow" })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = MapState.FamiliarUnit.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.25 )
	PlaySound({ Name = MapState.FamiliarUnit.EquipSound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = MapState.FamiliarUnit.ObjectId, OffsetZ = -60 })

	waitUnmodified( 0.15 )

	if MapState.FamiliarUnit.HarvestSound ~= nil then
		PlaySound({ Name = MapState.FamiliarUnit.HarvestSound, Id = MapState.FamiliarUnit.ObjectId })
	end

	PlaySound({ Name = "/SFX/ThanatosAttackBell" })
	thread( BackPlayerUpForHarvest, user, source )
	FrogFamiliarMoveToLocation( MapState.FamiliarUnit )
	waitUnmodified( 0.35 )

	if MapState.FamiliarUnit.EffortSound ~= nil then
		PlaySound({ Name = MapState.FamiliarUnit.EffortSound, Id = MapState.FamiliarUnit.ObjectId })
	end
	SetAnimation({ DestinationId = MapState.FamiliarUnit.ObjectId, Name = "Familiar_Frog_Exorcise" })

	AdjustColorGrading({ Name = "Team09", Duration = 0.3 })
	ShakeScreen({ Speed = 400, Distance = 3, Duration = 1.0, FalloffSpeed = 2000 })
	AdjustRadialBlurStrength({ Fraction = 0.5, Duration = 0.3 })
	AdjustRadialBlurDistance({ Fraction = 1.15, Duration = 1.1 })
	AngleTowardTarget({ Id = MapState.FamiliarUnit.ObjectId, DestinationId = source.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })
	waitUnmodified( 1.1 )

	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.3 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.3  })
end

function ExorcismStartPresentation( source, args, user )
	args = args or {}
	wait( 0.02, user.PreExorcismThreadName )

	source.LoopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronChoirLoop" })
	thread( PlayInteractAnimation, source.ObjectId)
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = user.ObjectId, SetBase = true })
	
	if GameState.ExorcismSuccesses == nil then
		thread( InCombatTextArgs, { Text = "Exorcism_Hint", TargetId = source.ObjectId, OffsetY = -250, SkipRise = true, SkipFlash = true, Duration = 3.0, PreDelay = 0.5, ShadowScaleX = 1.5 } )
		wait( 3.1, user.PreExorcismThreadName )
	else
		thread( InCombatTextArgs, { Text = "Exorcism_Hint", TargetId = source.ObjectId, OffsetY = -250, SkipRise = true, SkipFlash = true, Duration = 2.5, PreDelay = 0.5, ShadowScaleX = 1.5 } )
		wait( 1.0, user.PreExorcismThreadName )
	end

	thread( PlayVoiceLines, HeroVoiceLines.ExorcismStartVoiceLines, true, source )

	if source.AttemptsRemaining < 1 then
		thread( InCombatText, source.ObjectId, "Hint_LastChance", 1.0, { OffsetY = -310, ShadowScale = 0.6, PreDelay = 1.25, SkipRise = true } )
	end

	if CheckCooldown( "GhostEmotedRecently", 7.0 ) then
		thread( PlayEmote, { Target = source, EmoteName = "Fear", PlaySound = true, DelayMax = 0.1 } )
	end

	waitUnmodified( 0.8, user.PreExorcismThreadName )
		
	--local hintIds = { source.LeftHintId, source.RightHintId }
	--SetAlpha({ Ids = hintIds, Fraction = 1, Duration = 0.2 })

	for index, move in ipairs( source.MoveSequence ) do
		local key = "MovePipId"..index
		SetAlpha({ Id = source[key], Fraction = 1.0, Duration = 0.1 })
		SetAnimation({ Name = "ExorcismPip", DestinationId = source[key] })
		wait( 0.02 )
	end

	wait( 0.5 )

	if args.ShowSpecialEmote then
		thread( PlayEmoteSimple, source, { AnimationName = "StatusIconEmbarrassedRed", OffsetZ = source.EmoteOffsetZ } )
	end

	SetPlayerInvulnerable( "ExorcismStartPresentation" )
	PanCamera({ Id = source.ObjectId, Duration = 0.75 })
	FocusCamera({ Fraction = 1.15, Duration = 0.75, ZoomType = "Ease" })
	PlaySound({ Name = "/Leftovers/SFX/AuraOnLoud", Id = source.ObjectId })
	AdjustColorGrading({ Name = "Thanatos", Duration = 0.7 })
	--thread( InCombatTextArgs, { Text = "ExorcismInstructions", TargetId = source.ObjectId, Duration = 2.75, FontScale = 24, SkipRise = true, OffsetY = -250, SkipShadow = true, SkipFlash = true } )

	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })

	SetAnimation({ Name = "Melinoe_Tablet_Intro", DestinationId = CurrentRun.Hero.ObjectId })
	waitUnmodified( 0.1 )
	AdjustColorGrading({ Name = "Off", Duration = 0.2 })
	waitUnmodified( 0.4 )
	SetPlayerVulnerable( "ExorcismStartPresentation" )

end

function ExorcismNextMovePresentation( source, args, user, move )

	if not source.PlayedStartSound then
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusFistComboProc" })
		source.PlayedStartSound = true
	else
		PlaySound({ Name = "/SFX/ThanatosAttackBell" })
	end

	if move.Left then
		SetAlpha({ Id = source.LeftHintId, Fraction = 1, Duration = 0.1 })
		thread( DoRumble, { { LeftTriggerStrengthFraction = 0.0, }, } )
		thread( PulseExorcismIcon, source.LeftHintId, true )
	else
		SetAlpha({ Id = source.LeftHintId, Fraction = 0.0, Duration = 0.1 })
		thread( DoRumble, { { LeftTriggerStrengthFraction = 0.9, IgnoreTriggersIfControlNotDefault = "ExorcismLeft", }, } )		
	end
	if move.Right then
		SetAlpha({ Id = source.RightHintId, Fraction = 1, Duration = 0.1 })
		thread( DoRumble, { { RightTriggerStrengthFraction = 0.0, }, } )
		thread( PulseExorcismIcon, source.RightHintId, false )
	else
		SetAlpha({ Id = source.RightHintId, Fraction = 0.0, Duration = 0.1 })
		thread( DoRumble, { { RightTriggerStrengthFraction = 0.9, IgnoreTriggersIfControlNotDefault = "ExorcismRight", }, } )
	end

	if not move.Left and not move.Right then
		thread( ExorcismGhostEmotePresentation, source )
	end
end

function PulseExorcismIcon( sourceId, leftMove )
	local offsetX = 0
	if leftMove then
		offsetX = 20
	end
	CreateAnimation({ Name = "ExorcismCorrectFlash", DestinationId = sourceId, OffsetX = offsetX })
	-- SetScale({ Id = sourceId, Fraction = 1.4, Duration = 0.02 })
	-- waitUnmodified( 0.02 )
	-- SetScale({ Id = sourceId, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

end

function ExorcismInputCheckPresentation( source, args, user, move, isLeftCorrect, isRightCorrect, isLeftDown, isRightDown, consecutiveCheckFails, exorcismData )
	
	if move.Left then
		if isLeftCorrect then
			SetAnimation({ Name = "MelArmLeftGlow", DestinationId = source.LeftHintId })
		else
			SetAnimation({ Name = "GUI\\Icons\\MelArmLeftBacking", DestinationId = source.LeftHintId })
		end
	end
	if move.Right then
		if isRightCorrect then
			SetAnimation({ Name = "MelArmRightGlow", DestinationId = source.RightHintId })
		else
			SetAnimation({ Name = "GUI\\Icons\\MelArmRightBacking", DestinationId = source.RightHintId })
		end
	end

	-- this plays when you are doing anything successfully, including laying off both triggers
	if isLeftCorrect and isRightCorrect then
		-- Succeeding
		--DebugPrint({ Text = "Exorcism: Correct Input" })
		--PlaySound({ Name = "/SFX/Player Sounds/ZagreusFistComboProc", Id = CurrentRun.Hero.ObjectId })
		
		--AudioState.ExorcismSoundId = PlaySound({ Name = "/SFX/Enemy Sounds/Theseus/EmotePoweringUp", Id = user.ObjectId })
		--PlaySound({ Name = "/SFX/Menu Sounds/HeartsAddedCodex" })
		SetRGB({ Id = source.ObjectId, Color = Color.White, Duration = 0.1 })

		if exorcismData.CriticalItem then
			ShakeScreen({ Speed = 50, Distance = 1, Duration = 0.1, FalloffSpeed = 100, Angle = 90 })
			AdjustFullscreenBloom({ Name = "Subtler", Duration = 0.1 })
			--FocusCamera({ Fraction = 0.97, Duration = 3.0, ZoomType = "None" })
			--AdjustZoom({ Fraction = 0.97, LerpTime = 1.7 })
		end

		-- only rumble if a trigger is held, and don't rumble for 'layoff' moments
		if isLeftDown or isRightDown then
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.2, Duration = 0.22 }, } )	
			if not exorcismData.CriticalItem then
				PlaySound({ Name = "/SFX/ExorcismTick" })
				Shake({ Id = source.ObjectId, Distance = 1, Speed = 300, Duration = 0.12 })
			end
		end
	else
		-- Failing
		--StopSound({ Id = AudioState.ExorcismSoundId, Duration = 0.25 })
		if exorcismData.CriticalItem then
			AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
			--FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 0.85, Duration = 3.0, ZoomType = "Ease" })
			--AdjustZoom({ Fraction = 0.8, LerpTime = 3.0 })
		else
			SetRGB({ Id = source.ObjectId, Color = Color.Red, Duration = 0.25 })
		end

		-- conditional feedback after a grace period
		local sfxGracePeriod = 3
		local hintGracePeriod = 5
		if exorcismData.CriticalItem then
			--sfxGracePeriod = 9999
			--hintGracePeriod = 9999
		end
		if isLeftDown and not isLeftCorrect and isRightDown and not isRightCorrect then

			if consecutiveCheckFails >= sfxGracePeriod then
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })
			end
			if consecutiveCheckFails >= hintGracePeriod then
				PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
				thread( InCombatTextArgs, { Text = "ExorcismReleaseBoth", TargetId = source.ObjectId, Duration = 0.35, PreDelay = 0.02, FontScale = 20, SkipRise = true, OffsetY = -250, SkipShadow = true, SkipFlash = true } )
			end
		elseif isLeftDown and not isLeftCorrect then
			if consecutiveCheckFails >= sfxGracePeriod then
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })
			end
			if consecutiveCheckFails >= hintGracePeriod and isRightCorrect then
				thread( InCombatTextArgs, { Text = "ExorcismReleaseLeft", TargetId = source.ObjectId, Duration = 0.35, PreDelay = 0.02, FontScale = 20, SkipRise = true, OffsetY = -250, SkipShadow = true, SkipFlash = true } )
			end
		elseif isRightDown and not isRightCorrect then
			if consecutiveCheckFails >= sfxGracePeriod then
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })			
			end
			if consecutiveCheckFails >= hintGracePeriod and isLeftCorrect then
				thread( InCombatTextArgs, { Text = "ExorcismReleaseRight", TargetId = source.ObjectId, Duration = 0.35, PreDelay = 0.02, FontScale = 20, SkipRise = true, OffsetY = -250, SkipShadow = true, SkipFlash = true } )
			end
		elseif consecutiveCheckFails == 5 then
			--PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
		end
		--DebugPrint({ Text = "Exorcism: Wrong Input" })
	end

end

function ExorcismFailPresentation( source, args, user, move )
	PanCamera({ Id = user.ObjectId, Duration = 0.3 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.3, ZoomType = "Ease" })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })

	PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveActivateShk2", Id = source.ObjectId })
	StopSound({ Id = source.LoopingSoundId, Duration = 0.7 })
	local hintIds = { source.LeftHintId, source.RightHintId }
	SetAlpha({ Ids = hintIds, Fraction = 0, Duration = 0.0 })
	for index, move in ipairs( source.MoveSequence ) do
		local key = "MovePipId"..index
		SetAlpha({ Id = source[key], Fraction = 0, Duration = 0.0 })
	end
	SetRGB({ Id = source.ObjectId, Color = Color.White, Duration = 0.35 })

	DebugPrint({ Text = "Exorcism: Fail" })
	SetAnimation({ Name = "Melinoe_Tablet_ReturnToIdle", DestinationId = user.ObjectId })
	thread( InCombatTextArgs, { Text = "ExorcismFailed", TargetId = source.ObjectId, Duration = 1.0, PreDelay = 0.36, FontScale = 20, SkipRise = false, OffsetY = -150, SkipShadow = true } )

	if source.AttemptsRemaining > 0 then
		thread( PlayVoiceLines, HeroVoiceLines.ExorcismResistedVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.ExorcismFailedVoiceLines, true )
	end

	waitUnmodified(0.35)

	RepulseFromObject( user, {} )

	thread( PlayEmote, { Target = source, EmoteName = "Disgruntled", PlaySound = true } )

	Shake({ Id = source.ObjectId, Speed = 100, Distance = 3, Duration = 0.5 })
	Flash({ Id = source.ObjectId, Speed = 1.8, MinFraction = 0, MaxFraction = 0.8, Color = Color.Red, ExpireAfterCycle = true })

	source.PlayedStartSound = false

	waitUnmodified(0.3)

	if source.AttemptsRemaining <= 0 then
		StopAnimation({ DestinationId = source.ObjectId, Name = "ExorcismPointAvailable" })
		SetAnimation({ Name = "ExorcismGhostDissipate", DestinationId = source.ObjectId })
		PlaySound({ Name = "/SFX/GhostEvaporate", Id = source.ObjectId })
	end
end

function ExorcismSuccessPresentation( source, args, user )
	args = args or {}
	PlaySound({ Name = "/SFX/GhostEvaporate", Id = source.ObjectId })
	Shake({ Id = source.ObjectId, Speed = 100, Distance = 3 })
	Flash({ Id = source.ObjectId, Speed = 1.0, MinFraction = 0, MaxFraction = 1.0, Color = Color.White })
	StopSound({ Id = source.LoopingSoundId, Duration = 0.7 })

	PanCamera({ Id = user.ObjectId, Duration = 0.3 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.3, ZoomType = "Ease" })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })

	local lineSets = {}
	if args.UsedFamiliar then
		table.insert( lineSets, HeroVoiceLines.FamiliarThankingVoiceLines )
	end
	table.insert( lineSets, HeroVoiceLines.ExorcismSucceededVoiceLines )
	thread( PlayRandomEligibleVoiceLines, lineSets, true )

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	local hintIds = { source.LeftHintId, source.RightHintId }
	SetAlpha({ Ids = hintIds, Fraction = 0, Duration = 0.0 })
	for index, move in ipairs( source.MoveSequence ) do
		local key = "MovePipId"..index
		SetAlpha({ Id = source[key], Fraction = 0, Duration = 0.0 })
	end
	DebugPrint({ Text = "Exorcism: Success" })
	SetAnimation({ Name = "Melinoe_Tablet_ReturnToIdle", DestinationId = user.ObjectId })
	thread( InCombatTextArgs, { Text = "ExorcismSuccess", TargetId = source.ObjectId, Duration = 1.0, PreDelay = 0.17, FontScale = 20, SkipRise = false, OffsetY = -100, SkipShadow = true } )

	waitUnmodified(0.8)

	if args.UsedFamiliar then
		PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId, Delay = 0.5 })
		SetAnimation({ DestinationId = MapState.FamiliarUnit.ObjectId, Name = "Familiar_Frog_Greet" })
	end

	if args.ShowSpecialEmote then
		thread( PlayEmoteSimple, source, { AnimationName = "StatusIconOhBoyRed", OffsetZ = source.EmoteOffsetZ, Delay = 0.5 } )
	end

	thread( ExorcismGhostDissipate, source )

end

function ExorcismGhostDissipate( source )
	StopAnimation({ DestinationId = source.ObjectId, Name = "ExorcismPointAvailable" })
	SetAnimation({ Name = "ExorcismGhostDissipate", DestinationId = source.ObjectId })
end

function ExorcismGhostEmotePresentation( source )

	if CheckCooldown( "GhostEmotedRecently", 7.0 ) then
		if RandomChance(0.5) then
			thread( PlayEmote, { Target = source, EmoteName = "Grief", PlaySound = true } )
		end
	end

end

function ExorcismPointGetUseText( useTarget )
	if not IsComplexHarvestAllowed() then
		return "UseExorcismPointLocked"
	end
	if useTarget.FamiliarUseText ~= nil and useTarget.LinkedToolName and HasFamiliarTool( useTarget.LinkedToolName ) then
		return useTarget.FamiliarUseText
	end
	return useTarget.UseText
end

function BackPlayerUpForHarvest(user, source, args )
	args = args or {}
	local offset = CalcOffset( math.rad( GetAngleBetween({ Id = source.ObjectId, DestinationId = user.ObjectId }) ), args.Distance or 250 )
	local searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = source.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })

	if not IsLocationBlocked({ Id = searchOffsetId }) and not IsWithinDistance({ Id = user.ObjectId, DestinationId = searchOffsetId, Distance = 150 }) then
		local notifyName = "BackPlayerUpForHarvest"
		Move({ Id = user.ObjectId, DestinationId = searchOffsetId, SuccessDistance = 130 })
		NotifyOnStopped({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName })
		waitUntil( notifyName )
	end

	Destroy({ Id = searchOffsetId })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })
end


function GiftActivityFishingStartPresentation( source, args )

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.5 })

	thread( PlayVoiceLines, GlobalVoiceLines.AboutToFishVoiceLines, true )

	Activate({ Ids = { 585640 } })
	SetAlpha({ Ids = { 585640 }, Fraction = 0 })
	SetAlpha({ Ids = { 585640 }, Fraction = 1, Duration = 0.3 })

end

function GiftActivityFishingEndPresentation( source, args )

	if CurrentRun.Hero.FishingState == "Success" then
		wait( 3.5 )
	else
		wait( 1.5 )
	end
	-- SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })

end

function FishingStartPresentation( source, args )

	for massiveTraitName, v in pairs(SessionMapState.ReadiedMassiveAttacks) do
		local traitData = TraitData[massiveTraitName]
		StopAnimation({ Name = traitData.BlastReadyVfx, DestinationId = CurrentRun.Hero.ObjectId })
		StopAnimation({ Name = traitData.BlastReadyDarkVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end

	local fishingPointId = args.FishingPointId
	local fishingAnimationPointId = args.FishingAnimationPointId

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fishingPointId })
	local unequipAnim = GetEquippedWeaponValue( "UnequipAnimation" )
	if unequipAnim ~= nil then
		SetAnimation({ Name = unequipAnim, DestinationId = CurrentRun.Hero.ObjectId,  })
	end
	wait(1.0)

	thread( PlayVoiceLines, HeroVoiceLines.FishingInitiatedVoiceLines, true )

	SetAnimation({ Name = "Melinoe_Fishing_Start", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.65)

	Destroy({ Id = fishingPointId })
	--SetAlpha({ Id = fishingPointId, Fraction = 0 })
	SetAlpha({ Id = args.FishingPointId, Fraction = 0.0 })
	BlockVfx({ DestinationId = args.FishingPointId })

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	SetAnimation({ Name = "FishingBobberIdle", DestinationId = fishingAnimationPointId })
	CreateAnimation({ Name = "FishingSplashA", DestinationId = fishingAnimationPointId })
	PlaySound({ Name = roomData.FishingStartSound or "/Leftovers/SFX/FishingPlunk", Id = fishingAnimationPointId })
	thread( DoRumble, { { ScreenPreWait = 0.06, RightFraction = 0.18, Duration = 0.2 }, } )

	local showedObjective = CheckObjectiveSet("Fishing")
	HideCombatUI("Fishing")
	if GameState.FishingSuccesses ~= nil and GameState.FishingSuccesses >= 1 then
		thread( InCombatTextArgs, { Text = "Fishing_Hint", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -205, SkipRise = true, SkipFlash = true, Duration = 2.5, PreDelay = 1.0, ShadowScaleX = 0.66 } )
	else
		thread( InCombatTextArgs, { Text = "Fishing_Hint_NewPlayer", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -205, SkipRise = true, SkipFlash = true, Duration = 2.5, PreDelay = 1.0, ShadowScaleX = 0.66 } )
	end

	if roomData.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = roomData.ZoomFraction + 0.03, LerpTime = 2.5 })
	else
		AdjustZoom({ Fraction = 1.03, LerpTime = 2.5 })
	end

	thread( FishingInProgressPresentation )
end

function FishingInProgressPresentation()

	local fidgetInterval = RandomFloat( FishingData.FidgetInterval.Min, FishingData.FidgetInterval.Max )	

	wait ( fidgetInterval )

	if CurrentRun.Hero.FishingInput then
		return
	end
	SetAnimation({ Name = "Melinoe_Fishing_Fidget", DestinationId = CurrentRun.Hero.ObjectId })

	wait ( 10.5 - fidgetInterval )

	if CurrentRun.Hero.FishingInput then
		return
	end
	thread( PlayVoiceLines, HeroVoiceLines.FishingInProgressVoiceLines, true )

end

function FishingReadyForInputPresentation( fishingAnimationPointId )
	-- thread( DoRumble, { { RightTriggerStart = 0, RightTriggerFrequencyFraction = 0.7 , RightTriggerStrengthFraction = 0.5 }, } )
end

function FishingCaughtPresentation( source, args )
	-- thread( DoRumble, { { RightTriggerStrengthFraction = 0.0}, } )
	CreateAnimation({ Name = "FishingSplashB", DestinationId = args.FishingAnimationPointId })
end

function FishingEndPresentation( fishData, fishingAnimationPointId, args )

	SetAlpha({ Id = fishingAnimationPointId, Fraction = 0, Duration = 0 })

	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	local roomData = RoomData[currentRoom.Name] or currentRoom

	if fishData ~= nil and args.Success then

		GameState.FishingSuccesses = (GameState.FishingSuccesses or 0) + 1
		CurrentRun.FishingSuccesses = (CurrentRun.FishingSuccesses or 0) + 1
		GameState.FishCaught[fishData.Name] = (GameState.FishCaught[fishData.Name] or 0) + 1
		CurrentRun.FishCaught[fishData.Name] = (CurrentRun.FishCaught[fishData.Name] or 0) + 1
		if args.UsedFamiliar then
			GameState.FishingSuccessesFamiliar = (GameState.FishingSuccessesFamiliar or 0) + 1
			CurrentRun.FishingSuccessesFamiliar = (CurrentRun.FishingSuccessesFamiliar or 0) + 1
		else
			GameState.FishingSuccessesManual = (GameState.FishingSuccessesManual or 0) + 1
			CurrentRun.FishingSuccessesManual = (CurrentRun.FishingSuccessesManual or 0) + 1
		end

		thread( MarkObjectiveComplete, "Fishing" )
		thread( PlayVoiceLines, fishData.FishCaughtVoiceLines, nil, nil, args )

		CreateAnimation({ Name = "FishingSplashA", DestinationId = fishingAnimationPointId })
		CreateAnimation({ Name = "FishingSplashB", DestinationId = fishingAnimationPointId })
		
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/CriticalHit" })
		if args.UsedFamiliar then
			PlaySound({ Name = "/SFX/Familiars/CatMeowExclaim2", Id = MapState.FamiliarUnit.ObjectId })
		else
			PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" })
		end
		thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.28, Duration = 0.4 }, } )
		wait(0.1)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusWhooshDropIn" })

		wait(0.2)
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegDeathSplash", Id = fishingAnimationPointId })
		PlaySound({ Name = "/VO/MelinoeEmotes/EmoteCharging" })
		if not args.UsedFamiliar then
			SetAnimation({ Name = "Melinoe_Fishing_Success", DestinationId = CurrentRun.Hero.ObjectId })
		end
		thread( DoRumble, { { ScreenPreWait = 0.7, LeftFraction = 0.35, Duration = 0.4 }, } )
		
		local resourceTimes = 1
		if RandomChance( GetTotalHeroTraitValue("DoubleToolRewardChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
			resourceTimes = resourceTimes + 1
		end
		
		if resourceTimes > 1 then
			thread( ChaosRewardIncreasedPresentation, fishingAnimationPointId )
			waitUnmodified( 0.25, RoomThreadName )
		end
		AddResource( fishData.Name, 1 * resourceTimes, "Fishing" )

		thread( GrantElementFromTool, "ToolFishingRod2" )

		PlaySound({ Name = "/Leftovers/SFX/VictoryScreenUpdateSFX", Delay = 1 })

		local fishingText = "Fishing_SuccessGoodTitle"

		thread( PlayVoiceLines, fishData.FishIdentifiedVoiceLines, nil, nil, args )

		thread( DisplayInfoBanner, nil, {
			Icon = fishData.Name,
			TitleText = fishingText,
			SubtitleText = "Fishing_SuccessSubtitle",
			SubtitleData = { LuaKey = "TempTextData", LuaValue = fishData },
			IconOffsetY = 6,
			SubtitleOffsetY = 60,
			HighlightIcon = true,
			IconMoveSpeed = 0.1,
			IconScale = 1.0,
			AdditionalAnimation = "FishCatchPresentationSparkles",
			IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
			IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
			AnimationName = "InfoBannerFishingIn",
			AnimationOutName = "InfoBannerFishingOut",
		})

		CheckCodexUnlock( "Fish", fishData.Name )

		wait ( 0.22 )
		ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = 640, Angle = GetAngleBetween({ DestinationId = CurrentRun.Hero.ObjectId, Id = fishingAnimationPointId}) })

		wait( 0.88 )

		if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.Name == "CatFamiliar" then
			PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
		end

	else
		GameState.FishingFails = (GameState.FishingFails or 0) + 1
		CurrentRun.FishingFails = (CurrentRun.FishingFails or 0) + 1

		thread( MarkObjectiveFailed, "Fishing" )
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		SetAnimation({ Name = "Melinoe_Fishing_Failure", DestinationId = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = roomData.FishingFailSound or "/Leftovers/SFX/BigSplashRing", Delay = 0.3 })
		PlaySound({ Name = "/SFX/CrappyRewardDrop", Delay = 0.5 })

		PlaySound({ Name = "/Leftovers/SFX/ImpCrowdLaugh" })
		thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 }, } )

		if CurrentRun.Hero.FishingState == "TooLate" then
			thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtTooLateVoiceLines, true )
		elseif CurrentRun.Hero.FishingState == "WayLate" then
			thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtWayTooLateVoiceLines, true )
		else
			thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )
		end
		thread( InCombatTextArgs, { TargetId = fishingAnimationPointId, Text = "Fishing_Missed", Duration = 2.0, PreDelay = 0.6 } )
		wait( 1.1 )
	end
	CurrentRun.Hero.FishingStarted = false
	RemoveTimerBlock( CurrentRun, "Fishing" )
	UnfreezePlayerUnit("Fishing")
	UnblockCombatUI("Fishing")
	
	for massiveTraitName, v in pairs(SessionMapState.ReadiedMassiveAttacks) do
		local traitData = TraitData[massiveTraitName]
		CreateAnimation({ Name = traitData.BlastReadyVfx, DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = traitData.BlastReadyDarkVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end

	if roomData.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = roomData.ZoomFraction, LerpTime = 1.5 })
	else
		AdjustZoom({ Fraction = 1.0, LerpTime = 1.5 })
	end
	if not MapState.InOverlook then
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.5 })
	end
	if not roomData.IgnoreFishingCameraClamps then
		local cameraClamps = roomData.CameraClamps or GetDefaultClampIds()
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = roomData.SoftClamp })
	end
end

function UsedFishingPointOnExitPresentation( source )
	CreateAnimation({ Name = "FishingSplashA", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "FishingSplashB", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.25 })
	BlockVfx({ DestinationId = source.ObjectId })
end

function FamiliarFishingPresentation( fishingPoint )

	AddInputBlock({ Name = "MelFamiliarFishing" })
	AddTimerBlock( CurrentRun, "Fishing" )

	local familiar = MapState.FamiliarUnit

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = familiar.ObjectId })
	SetAnimation({ Name = "Melinoe_CrossCast_Start_Fast", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = familiar.EquipSound or "/EmptyCue", Id = familiar.ObjectId })

	CatFamiliarStopAI( familiar )

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.25 )
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fishingPoint.ObjectId, })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = MapState.FamiliarUnit.ObjectId, OffsetZ = -60 })

	waitUnmodified( 0.15 )
	
	if GetDistance({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId }) >= FamiliarData.CatFamiliar.MinDistanceToTeleportForFishing then
		SetAnimation({ Name = "Familiar_Cat_DropIn_Exit", DestinationId = familiar.ObjectId })
		familiar.Awake = true
		wait(0.2)
		-- teleport to the closest spawn point first
		FamiliarTeleportPresentation( familiar )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
		wait( 0.2 )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId })
		PlaySound({ Name = "/SFX/Familiars/CatGrumpy", Id = familiar.ObjectId })

		local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
		local roomData = RoomData[currentRoom.Name] or currentRoom

		local spawnPointId = GetClosest({ Id = fishingPoint.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		FamiliarTeleportPresentation( familiar )
		SetAnimation({ Name = "Familiar_Cat_DropIn_Enter", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.18 )
	end

	CatFamiliarMoveToLocation( familiar, { Id = fishingPoint.ObjectId, StayAwake = true, SuccessDistance = 150, OnFailGoToNearestToGoal = true } )
	wait( 0.02 )
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = fishingPoint.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Fish_Start", DestinationId = familiar.ObjectId })
	wait( RandomFloat( 1.0, 1.5 ) )

	SetAnimation({ Name = "Familiar_Cat_Fish_Swipe", DestinationId = familiar.ObjectId })
	
	wait( 0.2 )

	RemoveInputBlock({ Name = "MelFamiliarFishing" })
	RemoveTimerBlock( CurrentRun, "Fishing" )

	SetAnimation({ Name = "FishingPointUsed", DestinationId = fishingPoint.ObjectId })

	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunReloadCompleteFlashLucifer" })

	ReenableFamiliar( familiar, { InitialDelay = 1.0, MoveToRandomLocation = true } )

end

function FishingPointGetUseText( useTarget )
	if not IsComplexHarvestAllowed() then
		return "UseFishingPointLocked"
	end
	if ScreenAnchors.LavaVignetteId ~= nil then
		return "UseFishingPointLocked"
	end
	if useTarget.FamiliarUseText ~= nil and useTarget.LinkedToolName and HasFamiliarTool( useTarget.LinkedToolName ) then
		return useTarget.FamiliarUseText
	end
	return useTarget.UseText
end