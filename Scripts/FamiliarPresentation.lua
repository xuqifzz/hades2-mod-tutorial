-- Familiar Kits / Equipping

function EquipFamiliarPresentation( familiar )
	wait( 0.02 )

	thread( PlayVoiceLines, familiar.EquipVoiceLines, false )
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )

	Shake({ Id = familiar.ObjectId, Distance = 2, Speed = 100, Duration = 0.3, FalloffSpeed = 3000 })

	waitUnmodified( 0.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = familiar.EquipSound or "/EmptyCue", Id = familiar.ObjectId })

	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = familiar.ObjectId, OffsetZ = -60 })
end

function UnequipFamiliarPresentation( args )
	local equippedFamiliarKit = nil
	for kitId, familiarKit in pairs( MapState.FamiliarKits ) do
		if familiarKit.Name == GameState.EquippedFamiliar then
			equippedFamiliarKit = familiarKit
			break
		end
	end
	thread( PlayVoiceLines, equippedFamiliarKit.UnequipVoiceLines or HeroVoiceLines.FamiliarUnequipVoiceLines, false )

	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })

	waitUnmodified( 0.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = equippedFamiliarKit.ConfirmSound or "/EmptyCue", Id = equippedFamiliarKit.ObjectId })
end

-- Generic

function FamiliarRecruitBannerPresentation( source, args )

	wait( 0.1 )

	DisplayInfoBanner( nil, {
		TitleText = "FamiliarRecruited",
		SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3",
		TextOffsetY = 0,
		Color = {0, 255, 168, 255},
		TextColor = Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = args.Icon,
		IconOffsetY = 6,
		IconScale = 0.635,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "LocationBackingIrisSmallIn",
		AnimationOutName = "LocationBackingIrisSmallOut",
		IconBackingAnimationName = "LocationBackingIrisSmallSubtitleIn",
		IconBackingAnimationOutName = "LocationBackingIrisSmallSubtitleOut",
		IconBackingColor = Color.Lavender,
		IconBackingHSV = { 0.3, -0.1, 0.1},
	} )

	CheckCodexUnlock( "Familiars", source.Name )

end

function FamiliarRecruitPresentation( usee, args )
	
	args = args or {}
	local familiar = usee
	local familiarId = usee.ObjectId
	local recruitSequenceDuration = args.UnlockSequenceDuration or 6

	UseableOff({ Id = familiarId })
	HideUseButton( familiarId )
	AddInputBlock({ Name = "MelUsedCrossroadsPet" })

	thread( MarkObjectiveComplete, "FamiliarPrompt" )
	thread( PlayVoiceLines, usee.RecruitVoiceLines )

	if not args.SkipCameraZoom then
		PanCamera({ Id = familiarId, Duration = recruitSequenceDuration })
		FocusCamera({ Fraction = 1.05, Duration = recruitSequenceDuration, ZoomType = "Ease" })
	end

	SetAnimation({ Name = args.HeroAnimation or "Melinoe_Kneel", DestinationId = CurrentRun.Hero.ObjectId })

	wait( recruitSequenceDuration * 0.15 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = usee.ObjectId })
	SetAnimation({ Name = args.UnlockStartAnimation or familiar.HappyAnimation, DestinationId = usee.ObjectId })

	PlaySound({ Name = familiar.ConfirmSound or "/EmptyCue", Id = usee.ObjectId, Delay = 2 })

	wait( recruitSequenceDuration * 0.85 )

	SetAnimation({ Name = args.HeroExitAnimation or "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	thread( FamiliarRecruitBannerPresentation, usee, args )

	if args.UnlockEndAnimation then
		SetAnimation({ Name = args.UnlockEndAnimation, DestinationId = usee.ObjectId })
	end

	wait( 1.65 )
	
	GameState.FamiliarsUnlocked[usee.Name] = true
	CurrentRun.FamiliarsUnlocked[usee.Name] = true

	if args.AdjustZLocationOnExit ~= nil then
		AdjustZLocation({ Id = usee.ObjectId, Distance = args.AdjustZLocationOnExit, Duration = 0.4 })
	end
	if args.UnlockExitAnimation then
		SetAnimation({ Name = args.UnlockExitAnimation, DestinationId = usee.ObjectId })
		wait( 0.2 )
	end

	if not usee.SkipFleeTeleportVfx then
		FamiliarTeleportPresentation( usee )
	end
	SetAlpha({ Id = familiarId, Fraction = 0.0, Duration = 0.2 })

	wait( 1.35 )

	RemoveInputBlock({ Name = "MelUsedCrossroadsPet" })

	if not args.SkipCameraZoom then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.7, ZoomType = "Ease" })
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.7 })
	end

	wait( 0.1 )

	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarRecruitedVoiceLines )

	thread( CheckQuestStatus )

	CheckAchievement( familiar, { Name = "AchAllFamiliars" } )

	usee.OnUsedFunctionName = nil
	usee.AlwaysShowDefaultUseText = false
	
end

-- Frinos / FrogFamiliar

function PetFamiliarFrog( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarFrog" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local moveTargetId = 576174
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = moveTargetId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = moveTargetId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
	end
	wait( 0.3 )

	-- Do pet
	--AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = 150 })
	SetAnimation({ Name = "Familiar_Frog_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoePetFrinos", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 2.25 )

	PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarFrog" })

	if CurrentRun.SpecialInteractRecord.FrogFamiliar <= 1 then
		GameState.FrogPetRunCount = (GameState.FrogPetRunCount or 0) + 1
		thread( CheckQuestStatus )
	end

	wait( 4.0, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end

function FrogFamiliarSpecialInteractUnlockedInHub( usee, args )

	AddInteractBlock( usee, "PetFamiliarFrog" )
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarFrog" })

	FrogFamiliarStopAI( usee )

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local waitTime = 0.6
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	AngleNPCToHero( usee )
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
		waitTime = waitTime - 0.3
	end
	wait( waitTime )
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })	
	wait(0.6)
	SetAnimation({ Name = "Familiar_Frog_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelinoePetFrinos", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 2.25 )
	PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	wait( 2.0 )
	RemoveInputBlock({ Name = "PetFamiliarFrog" })
	if GameState.EquippedFamiliar == usee.Name then
		ReenableFamiliar( usee )
	end
	RemoveInteractBlock( usee, "PetFamiliarFrog" )

end

function FrogFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom == nil and not args.PostCombat then
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait(0.4)
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		FamiliarTeleportPresentation( familiar )
		wait(0.1)
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Frog_DropIn", DestinationId = familiar.ObjectId })
	end
end

-- Toula / CatFamiliar

function CatFamiliarSpecialInteractUnlockedInHub( usee, args )

	AddInteractBlock( usee, "PetFamiliarCat" )
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarCat" })

	CatFamiliarStopAI( usee )

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = usee.ObjectId })
	wait(0.6)
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetCat", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.8 )
	RemoveInputBlock({ Name = "PetFamiliarCat" })
	CatFamiliarGoToSleepPresentation( usee )
	if GameState.EquippedFamiliar == "CatFamiliar" then
		ReenableFamiliar( usee )
	end
	RemoveInteractBlock( usee, "PetFamiliarCat" )

end

function CatFamiliarSpecialInteractLockedInRun( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarCat" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = -45 -- use a fixed angle to prevent Mel from sometimes running off the dock
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	wait( 0.45 )
	SetAnimation({ Name = "Familiar_Cat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetCat", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 4.25 )
	thread( FamiliarFledPresentation, usee, args )
	wait( 1.75 )
	RemoveInputBlock({ Name = "PetFamiliarCat" })

end

function CatFamiliarGoToSleepPresentation( familiar )
	SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
	wait( 2.0, familiar.AIThreadName )
	familiar.Awake = false
end

function CatFamiliarGoToSleepQuickPresentation( familiar )
	SetAnimation({ Name = "Familiar_Cat_Sleep_Start_Quick", DestinationId = familiar.ObjectId })
	wait( 0.66, familiar.AIThreadName )
	familiar.Awake = false
end

function CatFamiliarGiftedPresentation( familiar )
	familiar.ReadyToAttack = false
	AddInteractBlock( familiar, "Gifted" )
	wait( 1.0 )
	PlaySound({ DestinationId = familiar.ObjectId, Name = "/SFX/Familiars/CatMeow1" })
	wait( 2.0 )
	CatFamiliarGoToSleepPresentation( familiar )
	familiar.ReadyToAttack = true
	RemoveInteractBlock( familiar, "Gifted" )
end

function CatFamiliarCostumedPresentation( familiar )
	familiar.ReadyToAttack = false
	AddInteractBlock( familiar, "Costumed" )
	wait( 1.5 )
	CatFamiliarGoToSleepPresentation( familiar )
	familiar.ReadyToAttack = true
	RemoveInteractBlock( familiar, "Costumed" )
end

function CatFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom ~= nil or args.PostCombat or familiar.PreRecruit then
		if familiar.PreRecruit then
			SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyModel", Value = "CatFamiliar_Wild_Mesh" })
		end
		SetAnimation({ Name = "Familiar_Cat_Sleep_Loop_NoBlend", DestinationId = familiar.ObjectId })
	else
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait( 0.4 )
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		FamiliarTeleportPresentation( familiar )
		wait( 0.1 )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Cat_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 0.55 )
		CatFamiliarGoToSleepQuickPresentation( familiar )
	end
end

function CatFamiliarAlertedPresentation( familiar, args )
	thread( InCombatText, familiar.ObjectId, "Alerted", 0.25, { SkipShadow = true, OffsetY = 5 }  )
	PlaySound({ Name = familiar.AlertedSound or "/Leftovers/SFX/HarpDash", Id = familiar.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = familiar.ActivateVFX, DestinationId = familiar.ObjectId })
	familiar.ActivateVfxId = nil
	familiar.Awake = true
end

function CatFamiliarPreAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_PreFire", DestinationId = familiar.ObjectId })

	thread( PlayVoiceLines, familiar.PreAttackVoiceLines, true, familiar )
end

function CatFamiliarAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_Fire", DestinationId = familiar.ObjectId })
end

function CatFamiliarTeleportToHeroPresentation( familiar )

	if not IsWithinDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.MinDistanceToTeleportToHero }) then

		CatFamiliarStopAI( familiar )

		local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints", DestinationIds = GetIdsByType({ Name = "FamiliarPoint" }), Distance = familiar.MinDistanceToTeleportToHero, RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end

		SetAnimation({ Name = "Familiar_Cat_DropIn_Exit", DestinationId = familiar.ObjectId })
		wait( 0.2 )

		-- teleport to the closest spawn point
		FamiliarTeleportPresentation( familiar )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
		wait( 0.25 )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = spawnPointId })
		PlaySound({ Name = "/SFX/Familiars/CatGrumpy", Id = familiar.ObjectId })
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		FamiliarTeleportPresentation( familiar )
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Cat_Sleep_Loop" })
		familiar.Awake = false
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.3 })
		wait( 0.3 )

		ReenableFamiliar( familiar )

	end

end

-- Raki / RavenFamiliar

function RavenFamiliarSpecialInteractLockedInRun( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarRaven" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	wait( 0.45 )
	SetAnimation({ Name = "Familiar_Raven_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetRaven", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 3.25 )

	PlaySound({ Name ="/SFX/Familiars/RavenSquawkAngry", Id = usee.ObjectId })

	wait( 1.0 )

	thread( FamiliarFledPresentation, usee, args )

	wait( 1.75 )

	RemoveInputBlock({ Name = "PetFamiliarRaven" })

end

function RavenFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarRaven" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })	
	wait(0.6)
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Raven_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetRaven", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.8 )
	-- SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = usee.ObjectId })

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarRaven" })
	wait( 2.05, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })

end

function FamiliarRavenStartNewRunPresentation( familiar, args )
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_DropIn_Exit" })
	AdjustZLocation({ Id = familiar.ObjectId, Distance = 200, Duration = 0.5 })
end

function RavenFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom ~= nil or args.PostCombat or familiar.PreRecruit then
		if familiar.PreRecruit then
			SetThingProperty({ DestinationId = familiar.ObjectId, Property = "GrannyModel", Value = "RavenFamiliar_Wild_Mesh" })
			SetAnimation({ DestinationId = familiar.ObjectId, Name = familiar.IdleAnimation })
		end
		familiar.TargetHeight = familiar.GroundHeight
	else
		familiar.TargetHeight = familiar.FlightHeight
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait( 0.4 )
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight + 600, Duration = 0.0 })
		wait( 0.1 )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = -600, Duration = 0.3 })
		SetAnimation({ Name = "Familiar_Raven_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 1.0 )
		if not familiar.Linked then
			if FamiliarShouldUseCombatLogic() then
				RavenFamiliarDropExitPresentation( familiar, args )
			else
				local notifyName = "RavenFamiliarOutsideRange"
				NotifyOutsideDistance({ Id = familiar.ObjectId, Notify = notifyName, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.InitialWaitRange })
				waitUntil( notifyName )
			end
		end
	end
end

function RavenFamiliarDropEnterPresentation( familiar, args )
	local spawnPointIds = GetIds({ Name = "SpawnPoints" })
	for id, reward in pairs( MapState.RewardPointsUsed ) do
		RemoveValueAndCollapse( spawnPointIds, id )
	end
	local closestSpawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnPointIds })
	if closestSpawnPointId <= 0 then
		closestSpawnPointId = CurrentRun.Hero.ObjectId
	end
	familiar.SpawnPointOccupiedId = closestSpawnPointId
	Teleport({ Id = familiar.ObjectId, DestinationId = closestSpawnPointId })
	if not IsEmpty(SessionMapState.Crystals) then
		SetAlpha({ Ids = SessionMapState.Crystals, Fraction = 1, Duration = 0.3 })
	end

	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	familiar.TargetHeight = familiar.SkyHeight
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.SkyHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.0 })
	SetAnimation({ Name = "Familiar_Raven_DropIn_Enter", DestinationId = familiar.ObjectId })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0 })
	wait( 0.01, familiar.AIThreadName )

	familiar.TargetHeight = familiar.FlightHeight
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.67, EaseIn = 0.9, EaseOut = 0.99 })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
	wait( 0.66, familiar.AIThreadName )
end

function RavenFamiliarDropExitPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Raven_DropIn_Exit", DestinationId = familiar.ObjectId })
	familiar.TargetHeight = familiar.SkyHeight
	wait( 0.1, familiar.AIThreadName )
	if not IsEmpty(SessionMapState.Crystals) then
		SetAlpha({ Ids = SessionMapState.Crystals, Fraction = 0, Duration = 0.3 })
	end
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.SkyHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.7, EaseIn = 0.01, EaseOut = 0.99 })
	wait( 0.4, familiar.AIThreadName )
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.3 })
	wait( 0.3, familiar.AIThreadName )
	familiar.SpawnPointOccupiedId = nil
end

function RavenFamiliarRoomExitPresentation( familiar, args )
	RavenFamiliarStopAI( familiar )
	SetAnimation({ Name = args.RoomExitAnimation, DestinationId = familiar.ObjectId })
	wait( 0.1, familiar.AIThreadName )
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.SkyHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.7, EaseIn = 0.01, EaseOut = 0.99 })
	wait( args.VfxDelay or 0.4 )
	if args.StopAnimations then
		StopAnimation({ Names = args.StopAnimations, DestinationId = familiar.ObjectId })
	end
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.3 })
end

function RavenFamiliarAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Raven_Harass", DestinationId = familiar.ObjectId })
end

function RavenFamiliarVictoryPresentation( familiar, args )
	if familiar.BlockVictoryPresentation or familiar.TargetHeight == familiar.GroundHeight then
		return
	end
	RavenFamiliarStopAI( familiar )
	if familiar.TargetHeight == familiar.SkyHeight then
		RavenFamiliarDropEnterPresentation( familiar )
	end
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Victory" })
	wait( 2.3, familiar.AIThreadName )
	ReenableFamiliar( familiar )
end

-- Hecuba / HoundFamiliar
-- used for initial Hub_Main interactions
function UseCrossroadsPet01( usee, args )

	local houndId = 558710
	local polecatId = 558691

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarHound" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Hound_Pet", DestinationId = houndId })
	SetAnimation({ Name = "Melinoe_PetHound", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.UsedCrossroadsPet01VoiceLines )
	wait( 0.2 )
	SetAnimation({ Name = "Familiar_Polecat_Greet", DestinationId = polecatId })
	AngleTowardTarget({ Id = polecatId, DestinationId = CurrentRun.Hero.ObjectId })
	wait( 4.3 )
	SetAnimation({ Name = "Familiar_Hound_HubHangout_1_Greet", DestinationId = houndId })

	RemoveInputBlock({ Name = "PetFamiliarHound" })
	wait( 30.75, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end

function HoundFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom == nil and not args.PostCombat and not familiar.PreRecruit then
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait(0.4)
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		FamiliarTeleportPresentation( familiar )
		wait(0.1)
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Hound_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 1.0 )
	end
end

function HoundFamiliarSpecialInteractLockedInRun( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarHound" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	wait( 0.45 )
	SetAnimation({ Name = "Familiar_Hound_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetHound", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, usee.InteractVoiceLines )

	wait( 2.75 )

	thread( FamiliarFledPresentation, usee, args )

	wait( 1.75 )

	RemoveInputBlock({ Name = "PetFamiliarHound" })
end

function HoundFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarHound" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 110 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })	
	wait(0.6)
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Hound_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetHound", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 4.5 )
	SetAnimation({ Name = "Familiar_Hound_HubHangout_1_Greet", DestinationId = usee.ObjectId })

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarHound" })
	wait( 2.05, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })

end

function HoundFamiliarReaction( usee, args )

	local familiarId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "HoundFamiliar" })
	PlaySound({ Name = "/SFX/Familiars/DogBarkDiscovery", Id = familiarId })

end

-- Gale / PolecatFamiliar

function PolecatFamiliarSpawnPresentation( familiar, args )
	if args.PostCombat or familiar.PreRecruit then
		wait( 0.02 ) -- allow any PostCombatReloadEvents to run before starting AI
	elseif CurrentHubRoom == nil then
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait( 0.4 )
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		FamiliarTeleportPresentation( familiar )
		wait( 0.1 )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Polecat_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 0.5 )
	end
end

function PolecatFamiliarVictoryPresentation( familiar, args )
	if familiar.BlockVictoryPresentation then
		return
	end
	PolecatFamiliarStopAI( familiar )
	if familiar.Burrowing then
		PolecatFamiliarUnburrowPresentation( familiar )
	end
	if familiar.Guarding then
		PolecatFamiliarGuardEndPresentation( familiar )
	end
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Polecat_Victory" })
	wait( 2.0, familiar.AIThreadName )
	ReenableFamiliar( familiar )
end

function PolecatFamiliarGuardPresentation( familiar, args )

	if args.Timeout ~= nil then
		thread( PolecatFamiliarGuardTimeoutThread, familiar, args )
	end

	familiar.Guarding = true

	RemoveFromGroup({ Id = familiar.ObjectId, Names = { "Standing" } })
	AddToGroup({ Id = familiar.ObjectId, Name = "Combat_Menu", DrawGroup = true })

	-- camera
	if IsEmpty( SessionMapState.LockCameraMotion ) then
		FocusCamera({ Fraction = (CurrentRun.CurrentRoom.ZoomFraction or 1.0) * 1.05, Duration = 0.15, ZoomType = "Ease" })
	end

	SetScale({ Id = familiar.ObjectId, Fraction = 2, Duration = 0.1 })
	SetGoalAngle({ Id = familiar.ObjectId, Angle = 270, CompleteAngle = true })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Polecat_Guard" })

	thread( PlayVoiceLines, familiar.PreAttackVoiceLines, true )

	waitUnmodified( 0.06, familiar.AIThreadName )

	PlaySound({ Name = "/Leftovers/SFX/MidAirCollision", Id = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "QuickFlashInvincible", DestinationId = familiar.ObjectId, OffsetY = -200 })
	thread( InCombatText, familiar.ObjectId, "BlockHit", 0.4, { SkipShadow = true } )

	-- handle edge case where GuardEnd is called during the waitUnmodified above
	if not familiar.Guarding then
		return
	end

	GameplaySetElapsedTimeMultiplier( { ElapsedTimeMultiplier = 0.01, Name = "PolecatTimeSlow", ApplyToPlayerUnits = true, SkipPresentation = true, Ignore = familiar } )

	waitUnmodified( 0.3, familiar.AIThreadName )
	PlaySound({ DestinationId = familiar.ObjectId, Name = "/SFX/Familiars/PolecatAngry" })

	waitUnmodified( 0.3, familiar.AIThreadName )
	SetScale({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.1 })
end

function PolecatFamiliarGuardEndPresentation( familiar, args )

	if not familiar.Guarding then
		return
	end

	GameplaySetElapsedTimeMultiplier( { ElapsedTimeMultiplier = 0.01, Reverse = true, Name = "PolecatTimeSlow", ApplyToPlayerUnits = true, Ignore = familiar } )
	RemoveFromGroup({ Id = familiar.ObjectId, Names = { "Combat_Menu" } })
	SetScale({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.1 })

	AddToGroup({ Id = familiar.ObjectId, Name = "Standing", DrawGroup = true })

	if IsEmpty( SessionMapState.LockCameraMotion ) then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.5, ZoomType = "Ease" })
	end

	familiar.Guarding = false

end

function PolecatFamiliarGuardTimeoutThread( familiar, args )
	waitUnmodified( args.Timeout )
	PolecatFamiliarGuardEndPresentation( familiar )
	wait( 0.2 )
	SetPlayerVulnerable( "PolecatFamiliarGuard" )
end

function PolecatFamiliarBurrowPresentation( familiar, args )
	args = args or {}
	familiar.Burrowing = true
	local burrowAnimation = "Familiar_Polecat_Burrow"
	if args.RemainingBlocks ~= nil then
		local popupString = nil
		if args.RemainingBlocks >= 1 then
			popupString = "Hint_PolecatBlocksRemaining"
		else
			popupString = "Hint_PolecatOutOfBlocks"
			burrowAnimation = "Familiar_Polecat_Burrow_NoBlocks"
		end
		thread( InCombatText, familiar.ObjectId, popupString, 0.9, { ShadowScale = 0.66, OffsetY = -75, LuaKey = "TempTextData", LuaValue = args } )
	end
	if CurrentRun.Hero.TraitDictionary.StaffClearCastAspect ~= nil then
		burrowAnimation = burrowAnimation.."_Trail"
	end
	SetAnimation({ DestinationId = familiar.ObjectId, Name = burrowAnimation })
	CreateAnimation({ Name = "EnemyBurrowEntranceSmall", DestinationId = familiar.ObjectId, })
	wait( 0.5, familiar.AIThreadName )
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.4 })
	wait( 0.5, familiar.AIThreadName )
end

function PolecatFamiliarUnburrowPresentation( familiar, args )
	CreateAnimation({ Name = "EnemyBurrowExitSmall", DestinationId = familiar.ObjectId, })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Polecat_Unburrow" })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.5 })
	wait( 0.5, familiar.AIThreadName )
	familiar.Burrowing = false
end

function PolecatFamiliarSpecialInteractLockedInRun( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarPolecat" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 60 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	AngleNPCToHero( usee )
	local animation = GetEquippedWeaponValue( "UnequipAnimation" )
	if animation ~= nil then
		SetAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	wait( 0.45 )
	SetAnimation({ Name = "Familiar_Polecat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetPolecat", DestinationId = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 4.25 )

	thread( FamiliarFledPresentation, usee, args )
	wait( 1.75 )

	RemoveInputBlock({ Name = "PetFamiliarPolecat" })
end

function PolecatFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarPolecat" })

	-- Move to petting position
	Stop({ Id = CurrentRun.Hero.ObjectId })
	Halt({ Id = CurrentRun.Hero.ObjectId })
	CancelWeaponFireRequests({ Id = CurrentRun.Hero.ObjectId })
	local angle = GetAngleBetween({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), 60 )
	offset.Y = offset.Y * 0.5
	local offsetPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = usee.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	local notifyDistance = 10
	AngleNPCToHero( usee )
	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = offsetPointId }) > notifyDistance then
		MoveHeroToRoomPosition( { DestinationId = offsetPointId, DisableCollision = true, SuccessDistance = 32, NotifyDistance = notifyDistance, ContinueToGoal = true } )
		wait( 0.3 )
	end
	Destroy({ Id = offsetPointId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = GetEquippedWeaponValue( "UnequipAnimation" ), DestinationId = CurrentRun.Hero.ObjectId })	
	wait(0.6)
	SetAnimation({ Name = "Familiar_Polecat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetPolecat", DestinationId = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.8 )

	RemoveInputBlock({ Name = "PetFamiliarPolecat" })
	wait( 2.05, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })

end

-- Generic

function FamiliarVictoryPresentation( familiar, args )
	args = args or {}
	wait( args.PreWait )

	if familiar.BlockVictoryPresentation then
		return
	end

	local argsNoPreWait = ShallowCopyTable( args )
	argsNoPreWait.PreWait = nil
	GenericPresentation( familiar, argsNoPreWait )
end

function FamiliarRoomExitPresentation( usee, args )
	if args.StopMovement then
		Stop({ Id = usee.ObjectId })
	end
	SetAnimation({ Name = args.RoomExitAnimation, DestinationId = usee.ObjectId })
	wait( args.VfxDelay or 0.4 )
	if args.StopAnimations then
		StopAnimation({ Names = args.StopAnimations, DestinationId = usee.ObjectId })
	end
	FamiliarTeleportPresentation( usee )
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.1 })
end

function FamiliarFledPresentation( usee, args )
	args = args or {}

	UseableOff({ Id = usee.ObjectId })

	wait( 3.3 )

	SetAnimation({ Name = usee.FleeAnimation, DestinationId = usee.ObjectId })

	wait( 0.2 )

	if not usee.SkipFleeTeleportVfx then
		FamiliarTeleportPresentation( usee )
	end

	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.2 })

	wait( 0.2 )

	PlaySound({ Name = usee.UseSound or "/EmptyCue", Id = usee.ObjectId })

	wait( 0.35 )
	Destroy({ Id = usee.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarFledVoiceLines )

end

function FamiliarTeleportPresentation( familiar )
	CreateAnimation({ Name = "TeleportDisappearFamiliar", DestinationId = familiar.ObjectId, OffsetY = familiar.TeleportVfxOffsetY, Scale = familiar.TeleportVfxScale })
end

-- VoiceLines
GlobalVoiceLines.FamiliarFledVoiceLines =
{
	-- Toula
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.75,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Intro" },
			},
		},

		{ Cue = "/VO/Melinoe_0987", Text = "Ran off...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0989", Text = "Again?" },
		{ Cue = "/VO/Melinoe_0990", Text = "Must want something to eat..." },
	},
	-- Raki
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Reprieve01" },
			},
		},

		{ Cue = "/VO/Melinoe_0988", Text = "Flew off...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3868", Text = "Safe travels." },
		{ Cue = "/VO/Melinoe_3869", Text = "Be safe out there." },
		{ Cue = "/VO/Melinoe_0989", Text = "Again?" },
	},
	-- Hecuba
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Bridge01" },
			},
		},

		{ Cue = "/VO/MelinoeField_2820", Text = "Off she goes.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2821", Text = "Get home safe!" },
		{ Cue = "/VO/MelinoeField_2822", Text = "Bounded off." },
		{ Cue = "/VO/MelinoeField_2823", Text = "See you around." },
	},
	-- Gale
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_PreBoss01" },
			},
		},

		{ Cue = "/VO/MelinoeField_3052", Text = "Good luck with your mission!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2821", Text = "Get home safe!" },
		{ Cue = "/VO/MelinoeField_2822", Text = "Bounded off." },
		{ Cue = "/VO/MelinoeField_2823", Text = "See you around." },
	},
}
GlobalVoiceLines.FamiliarRecruitedVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Reprieve01" },
			}
		},

		{ Cue = "/VO/MelinoeField_1919", Text = "See you at the Crossroads!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Intro", "H_Bridge01", "P_PreBoss01" },
			}
		},

		{ Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
		{ Cue = "/VO/Melinoe_1628", Text = "See you in the Crossroads..." },
		{ Cue = "/VO/Melinoe_1630", Text = "See you in the Crossroads...?" },
	},
}
