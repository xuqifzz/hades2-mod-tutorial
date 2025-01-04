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

function FamiliarRestingPresentation( familiarKit )
	SetAlpha({ Id = familiarKit.ObjectId, Fraction = 1.0, Duration = 0.2 })
end

-- Frinos / FrogFamiliar

function FrogFamiliarRecruit( usee, args )
	
	args = args or {}
	local familiar = usee
	local familiarId = usee.ObjectId
	local recruitSequenceDuration = args.UnlockSequenceDuration or 6

	UseableOff({ Id = familiarId })
	HideUseButton( familiarId )
	AddInputBlock({ Name = "MelUsedCrossroadsPet" })

	thread( MarkObjectiveComplete, "FamiliarPrompt" )
	thread( PlayVoiceLines, usee.RecruitVoiceLines )

	--PanCamera({ Id = familiarId, Duration = recruitSequenceDuration })
	--FocusCamera({ Fraction = 1.05, Duration = recruitSequenceDuration, ZoomType = "Ease" })

	SetAnimation({ Name = "MelTalkExplaining01", DestinationId = CurrentRun.Hero.ObjectId })

	wait( recruitSequenceDuration * 0.15 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = usee.ObjectId })
	SetAnimation({ Name = args.UnlockStartAnimation or familiar.HappyAnimation, DestinationId = usee.ObjectId })

	PlaySound({ Name = familiar.ConfirmSound or "/EmptyCue", Id = usee.ObjectId, Delay = 2 })

	wait( recruitSequenceDuration * 0.85 )

	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	thread( MaxedRelationshipPresentation, usee, args )

	if args.UnlockEndAnimation then
		SetAnimation({ Name = args.UnlockEndAnimation, DestinationId = usee.ObjectId })
	end

	wait( 1.65 )
	
	GameState.FamiliarsUnlocked[usee.Name] = true
	CurrentRun.FamiliarsUnlocked[usee.Name] = true

	if args.UnlockExitAnimation then
		SetAnimation({ Name = args.UnlockExitAnimation, DestinationId = usee.ObjectId })
		wait( 0.2 )
	end

	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiarId })
	SetAlpha({ Id = familiarId, Fraction = 0.0, Duration = 0.2 })

	wait( 1.35 )

	RemoveInputBlock({ Name = "MelUsedCrossroadsPet" })
	--FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.7, ZoomType = "Ease" })
	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.7 })

	wait( 0.1 )

	if args.PlayRecruitVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.FamiliarRecruitedVoiceLines )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.FamiliarFledVoiceLines )
	end

	usee.OnUsedFunctionName = nil
	usee.AlwaysShowDefaultUseText = false
	
end

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
	wait( 2.05, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end

function FrogFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom == nil and not args.PostCombat then
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait(0.4)
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId, OffsetY = -130 })
		wait(0.1)
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Frog_DropIn", DestinationId = familiar.ObjectId })
	end
end

-- Toula / CatFamiliar

function CatFamiliarRecruit( usee, args )
	
	args = args or {}
	local familiar = usee
	local familiarId = usee.ObjectId
	local recruitSequenceDuration = args.UnlockSequenceDuration or 6

	UseableOff({ Id = familiarId })
	HideUseButton( familiarId )
	AddInputBlock({ Name = "MelUsedCrossroadsPet" })

	thread( MarkObjectiveComplete, "FamiliarPrompt" )
	thread( PlayVoiceLines, usee.RecruitVoiceLines )

	PanCamera({ Id = familiarId, Duration = recruitSequenceDuration })
	FocusCamera({ Fraction = 1.05, Duration = recruitSequenceDuration, ZoomType = "Ease" })

	SetAnimation({ Name = "Melinoe_Kneel", DestinationId = CurrentRun.Hero.ObjectId })

	wait( recruitSequenceDuration * 0.15 )

	PlaySound({ Name = familiar.HappySound or "/EmptyCue", Id = usee.ObjectId })
	SetAnimation({ Name = args.UnlockStartAnimation or familiar.HappyAnimation, DestinationId = usee.ObjectId })

	--SetAnimation({ Name = "Familiar_Frog_Pet", DestinationId = usee.ObjectId })

	PlaySound({ Name = familiar.ConfirmSound or "/EmptyCue", Id = usee.ObjectId, Delay = 2 })

	wait( recruitSequenceDuration * 0.85 )

	SetAnimation({ Name = "MelinoeIdleWeaponless", DestinationId = CurrentRun.Hero.ObjectId })

	thread( MaxedRelationshipPresentation, usee, args )

	if args.UnlockEndAnimation then
		SetAnimation({ Name = args.UnlockEndAnimation, DestinationId = usee.ObjectId })
	end

	wait( 1.65 )
	
	GameState.FamiliarsUnlocked[usee.Name] = true
	CurrentRun.FamiliarsUnlocked[usee.Name] = true

	if args.UnlockExitAnimation then
		SetAnimation({ Name = args.UnlockExitAnimation, DestinationId = usee.ObjectId })
		wait( 0.2 )
	end

	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiarId })
	SetAlpha({ Id = familiarId, Fraction = 0.0, Duration = 0.2 })

	wait( 1.35 )

	RemoveInputBlock({ Name = "MelUsedCrossroadsPet" })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.7, ZoomType = "Ease" })
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.7 })

	wait( 0.1 )

	if args.PlayRecruitVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.FamiliarRecruitedVoiceLines )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.FamiliarFledVoiceLines )
	end

	usee.OnUsedFunctionName = nil
	usee.AlwaysShowDefaultUseText = false
	
end

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
	AngleTowardTarget({ Id = usee.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetCat", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.0 )
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
	SetAnimation({ Name = "Familiar_Cat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetCat", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 3.25 )

	RemoveInputBlock({ Name = "PetFamiliarCat" })
	thread( FamiliarFledPresentation, usee, args )

end

function CatFamiliarGoToSleepPresentation( familiar )
	SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
	wait( 3.0, familiar.AIThreadName )
	familiar.Awake = false
end

function CatFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom ~= nil or args.PostCombat or familiar.PreRecruit then
		SetAnimation({ Name = "Familiar_Cat_Sleep_Loop_NoBlend", DestinationId = familiar.ObjectId })
	else
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait( 0.4 )
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId, OffsetY = -130 })
		wait( 0.1 )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Cat_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 1.0 )
		CatFamiliarGoToSleepPresentation( familiar )
	end
end

function CatFamiliarAlertedPresentation( familiar, args )
	thread( InCombatText, familiar.ObjectId, "Alerted", 0.25, { SkipShadow = true, OffsetY = 5 }  )
	PlaySound({ Name = familiar.AlertedSound or "/Leftovers/SFX/HarpDash", Id = familiar.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = familiar.DefaultAIData.RecruitAnimation, DestinationId = familiar.ObjectId })
	familiar.RecruitAnimationId = nil
	familiar.Awake = true
end

function CatFamiliarPreAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_PreFire", DestinationId = familiar.ObjectId })

	thread( PlayVoiceLines, familiar.PreAttackVoiceLines, true, familiar )
end

function CatFamiliarAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_Fire", DestinationId = familiar.ObjectId })
end

function CatFamiliarFieldsTeleportPresentation( familiar )

	if GetDistance({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) >= FamiliarData.CatFamiliar.MinDistanceToTeleportInFields then

		CatFamiliarStopAI( familiar )

		local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", RequiredLocationUnblocked = true, })
		if spawnPointId == 0 then
			-- fall back to the hero's position if no spawn points exist
			spawnPointId = CurrentRun.Hero.ObjectId
		end

		SetAnimation({ Name = "Familiar_Cat_DropIn_Exit", DestinationId = familiar.ObjectId })
		wait(0.2)

		-- teleport to the closest spawn point
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId })
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.2 })
		wait( 0.65 )
		AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = spawnPointId })
		PlaySound({ Name = "/SFX/Familiars/CatGrumpy", Id = familiar.ObjectId })
		Teleport({ Id =  familiar.ObjectId, DestinationId = spawnPointId })
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId })
		SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Cat_Sleep_Loop" })
		familiar.Awake = false
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
		wait( 0.5 )

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
	SetAnimation({ Name = "Familiar_Raven_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetRaven", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 3.25 )

	PlaySound({ Name ="/SFX/Familiars/RavenSquawkAngry", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarRaven" })
	--wait( 2.05, RoomThreadName )

	--UseableOn({ Id = usee.ObjectId })
	thread( FamiliarFledPresentation, usee, args )

end

function RavenFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarRaven" })

	usee.ReadyToAttack = false

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
	SetAnimation({ Name = "Familiar_Raven_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetRaven", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.0 )
	-- SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = usee.ObjectId })

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarRaven" })
	wait( 2.05, RoomThreadName )
	usee.ReadyToAttack = true
	UseableOn({ Id = usee.ObjectId })

end

function FamiliarRavenStartNewRunPresentation( familiar, args )
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_DropIn_Exit" })
	AdjustZLocation({ Id = familiar.ObjectId, Distance = 200, Duration = 0.5 })
end

function RavenFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom ~= nil or args.PostCombat or familiar.PreRecruit then
		familiar.CurrentHeight = familiar.GroundHeight
	else
		familiar.CurrentHeight = familiar.FlightHeight
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait( 0.4 )
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight + 100, Duration = 0.0 })
		CreateAnimation({ Name = "TeleportDisappearSmall_Raven", DestinationId = familiar.ObjectId })
		wait( 0.1 )
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		AdjustZLocation({ Id = familiar.ObjectId, Distance = -100, Duration = 0.2 })
		SetAnimation({ Name = "Familiar_Raven_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 1.0 )
		if FamiliarShouldUseCombatLogic() then
			RavenFamiliarDropExitPresentation( familiar, args )
		else
			local notifyName = "RavenFamiliarOutsideRange"
			NotifyOutsideDistance({ Id = familiar.ObjectId, Notify = notifyName, DestinationId = CurrentRun.Hero.ObjectId, Distance = familiar.InitialWaitRange })
			waitUntil( notifyName )
		end
	end
end

function RavenFamiliarDropEnterPresentation( familiar, args )
	local closestSpawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "SpawnPoints" })
	Teleport({ Id = familiar.ObjectId, DestinationId = closestSpawnPointId })
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.SkyHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.0 })
	SetAnimation({ Name = "Familiar_Raven_DropIn_Enter", DestinationId = familiar.ObjectId })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0 })
	wait( 0.01, familiar.AIThreadName )

	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.FlightHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.67, EaseIn = 0.9, EaseOut = 0.99 })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.2 })
	wait( 0.66, familiar.AIThreadName )
	familiar.CurrentHeight = familiar.FlightHeight
end

function RavenFamiliarDropExitPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Raven_DropIn_Exit", DestinationId = familiar.ObjectId })
	wait( 0.1, familiar.AIThreadName )
	AdjustZLocation({ Id = familiar.ObjectId, Distance = familiar.SkyHeight - GetZLocation({ Id = familiar.ObjectId }), Duration = 0.7, EaseIn = 0.01, EaseOut = 0.99 })
	wait( 0.4, familiar.AIThreadName )
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.3 })
	wait( 0.3, familiar.AIThreadName )
	familiar.CurrentHeight = familiar.SkyHeight
end

function RavenFamiliarRoomExitPresentation( familiar, args )
	RavenFamiliarStopAI( familiar )
	SetAnimation({ Name = args.RoomExitAnimation, DestinationId = familiar.ObjectId })
	wait( 0.1, familiar.AIThreadName )
	AdjustZLocation({ Id = familiar.ObjectId, Distance = 700, Duration = 0.7, EaseIn = 0.01, EaseOut = 0.99 })
	wait( args.VfxDelay or 0.4 )
	if args.StopAnimations then
		StopAnimation({ Names = args.StopAnimations, DestinationId = familiar.ObjectId })
	end
	CreateAnimation({ Name = "TeleportDisappearSmall_Raven", DestinationId = familiar.ObjectId, OffsetY = args.VfxOffsetY or -180, Scale = args.VfxScale or 1.2 })
	SetAlpha({ Id = familiar.ObjectId, Fraction = 0.0, Duration = 0.1 })
end

function RavenFamiliarPreAttackPresentation( familiar, args )
	thread( PlayVoiceLines, familiar.PreAttackVoiceLines, true, familiar )
end

function RavenFamiliarAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Raven_Harass", DestinationId = familiar.ObjectId })
end

function RavenFamiliarVictoryPresentation( familiar, args )
	RavenFamiliarStopAI( familiar )
	if familiar.CurrentHeight == familiar.SkyHeight then
		RavenFamiliarDropEnterPresentation( familiar )
	end
	AngleTowardTarget({ Id = familiar.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ DestinationId = familiar.ObjectId, Name = "Familiar_Raven_Victory" })
	wait(2.3)
	ReenableFamiliar( familiar )
end

-- Hecuba / HoundFamiliar
-- used for initial Hub_Main interactions
function UseCrossroadsPet01( usee, args )

	local houndId = 558710

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarHound" })

	usee.ReadyToAttack = false

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
	PlaySound({ Name = "/VO/CerberusPant_2", Id = houndId })
	wait( 4.5 )
	SetAnimation({ Name = "Familiar_Hound_HubHangout_1_Greet", DestinationId = houndId })

	PlaySound({ Name = "/VO/CerberusBarks", Id = houndId })
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
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId, OffsetY = -130 })
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

	usee.ReadyToAttack = false

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
	SetAnimation({ Name = "Familiar_Hound_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetHound", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )

	wait( 3.25 )

	thread( FamiliarFledPresentation, usee, args )
	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarHound" })
	--wait( 2.05, RoomThreadName )

end

function HoundFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarHound" })

	usee.ReadyToAttack = false

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
	SetAnimation({ Name = "Familiar_Hound_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetHound", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 4.5 )
	SetAnimation({ Name = "Familiar_Hound_HubHangout_1_Greet", DestinationId = usee.ObjectId })

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarHound" })
	wait( 2.05, RoomThreadName )
	usee.ReadyToAttack = true
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
	SetAnimation({ Name = args.RoomExitAnimation, DestinationId = usee.ObjectId })
	wait( args.VfxDelay or 0.4 )
	if args.StopAnimations then
		StopAnimation({ Names = args.StopAnimations, DestinationId = usee.ObjectId })
	end
	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = usee.ObjectId, OffsetY = args.VfxOffsetY or -180, Scale = args.VfxScale or 1.2 })
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.1 })
end

function FamiliarFledPresentation( usee, args )

	UseableOff({ Id = usee.ObjectId })

	wait( 3.3 )

	SetAnimation({ Name = usee.FleeAnimation, DestinationId = usee.ObjectId })

	wait( 0.2 )

	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = usee.ObjectId })
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.2 })

	wait( 0.2 )

	PlaySound({ Name = usee.UseSound or "/EmptyCue", Id = usee.ObjectId })

	wait( 0.35 )
	Destroy({ Id = usee.ObjectId })

	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarFledVoiceLines )

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
			}
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
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Intro" },
			}
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
				IsAny = { "H_Bridge01" },
			}
		},

		{ Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
	},

}
