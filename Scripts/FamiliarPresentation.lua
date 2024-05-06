
function EquipFamiliarPresentation( familiarKit )
	wait( 0.02 )

	thread( PlayVoiceLines, familiarKit.EquipVoiceLines, false )
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = CurrentRun.Hero.ObjectId })

	-- SetAnimation({ Name = "MelinoeSpellFire", DestinationId = CurrentRun.Hero.ObjectId })
	-- PlaySound({ Name = "/Leftovers/World Sounds/QuickSnap", Id = CurrentRun.Hero.ObjectId, Delay = 0.2 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )

	Shake({ Id = familiarKit.ObjectId, Distance = 2, Speed = 100, Duration = 0.3, FalloffSpeed = 3000 })

	waitUnmodified( 0.2 )
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = familiarKit.EquipSound or "/EmptyCue", Id = familiarKit.ObjectId })

	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = familiarKit.ObjectId, OffsetZ = -60 })

	SetAnimation({ Name = familiarKit.Icon, DestinationId = HUDScreen.Components.FamiliarIcon.Id })
	SetScale({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 1.4, Duration = 0.02 })
	Flash({ Id = HUDScreen.Components.FamiliarIcon.Id, Speed = 1.5, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Green, ExpireAfterCycle = true })

	SetAlpha({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = ConfigOptionCache.HUDOpacity, Duration = HUDScreen.FadeInDuration })

	waitUnmodified( 0.02 )

	SetScale({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 1.0, Duration = 0.35, SmoothStep = true })

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

	-- CreateAnimation({ Name = "ItemGet_Tool", DestinationId = equippedFamiliarKit.ObjectId, OffsetZ = -60 })

	wait( 0.02 )
	SetScale({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 0.0, Duration = 0.35, SmoothStep = true })
	SetAlpha({ Id = HUDScreen.Components.FamiliarIcon.Id, Fraction = 0.0, Duration = 0.35, })
end

function FamiliarRestedPresentation( familiarKit )
	SetColor({ Id = familiarKit.ObjectId, Color = Color.Blue })
end

function FamiliarRestingPresentation( familiarKit )
	if not familiarKit.HasTextBox then
		local familiarStatus = GameState.FamiliarStatus[familiarKit.Name]
		familiarKit.TicksUntilRested = math.max( familiarKit.TickForRested - familiarStatus.RestTicks, 0 )
		familiarKit.HasTextBox = true
		CreateTextBox({
			Id = familiarKit.ObjectId,
			Text = "FamiliarRestTicks",
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

GlobalVoiceLines.UsedFamiliarsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.4,

	{ Cue = "/VO/Melinoe_0246", Text = "I got you something.", },
	{ Cue = "/VO/Melinoe_0247", Text = "I got you this.", },
	{ Cue = "/VO/Melinoe_0248", Text = "Got something for you.", },
	{ Cue = "/VO/Melinoe_0249", Text = "Here you go!", },
}
GlobalVoiceLines.FamiliarFledVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.75,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Reprieve01", "O_Intro" },
			},
			{
				PathFalse = { "GameState", "TextLinesRecord", "ToulaGift01" },
			},
		},

		{ Cue = "/VO/Melinoe_0987", Text = "Ran off...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0989", Text = "Again?" },
		{ Cue = "/VO/Melinoe_0990", Text = "Must want something to eat..." },
	},
	--[[
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
			{
				PathFalse = { "GameState", "TextLinesRecord", "RakiGift01" },
			},
		},

		{ Cue = "/VO/Melinoe_0988", Text = "Flew off...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0989", Text = "Again?" },
		{ Cue = "/VO/Melinoe_0990", Text = "Must want something to eat..." },
	},
	]]--
}
GlobalVoiceLines.FamiliarRecruitedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			}
		},

		{ Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
		-- { Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Reprieve01" },
			}
		},

		-- { Cue = "/VO/Melinoe_0768", Text = "You're welcome." },
		-- { Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
		{ Cue = "/VO/MelinoeField_1919", Text = "See you at the Crossroads!" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Intro" },
			}
		},

		-- { Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_2768", Text = "Meet me in the training grounds!" },
	},
}

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
	
	GameState.FamiliarStatus[usee.Name] = GameState.FamiliarStatus[usee.Name] or {}
	GameState.FamiliarStatus[usee.Name].Unlocked = true

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
	
	GameState.FamiliarStatus[usee.Name] = GameState.FamiliarStatus[usee.Name] or {}
	GameState.FamiliarStatus[usee.Name].Unlocked = true

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
	if CurrentHubRoom == nil then
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

function CatFamiliarSpecialInteractUnlockedInHub( usee, args )

	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "PetFamiliarCat" })

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
	SetAnimation({ Name = "Familiar_Cat_Pet", DestinationId = usee.ObjectId })
	SetAnimation({ Name = "Melinoe_PetCat", DestinationId = CurrentRun.Hero.ObjectId })	
	thread( PlayVoiceLines, usee.InteractVoiceLines )
	wait( 5.0 )
	SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = usee.ObjectId })

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarCat" })
	wait( 2.05, RoomThreadName )
	usee.ReadyToAttack = true

	UseableOn({ Id = usee.ObjectId })

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

	--PlaySound({ Name = "/SFX/Familiars/FrogRibbit", Id = usee.ObjectId })
	RemoveInputBlock({ Name = "PetFamiliarCat" })
	--wait( 2.05, RoomThreadName )

	--UseableOn({ Id = usee.ObjectId })
	thread( CatFledPresentation, usee, args )

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

function CatFledPresentation( usee, args )

	UseableOff({ Id = usee.ObjectId })

	wait( 3.3 )

	SetAnimation({ Name = "Familiar_Cat_DropIn_Exit", DestinationId = usee.ObjectId })

	wait( 0.2 )

	CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = usee.ObjectId })
	SetAlpha({ Id = usee.ObjectId, Fraction = 0.0, Duration = 0.2 })

	wait( 0.2 )

	PlaySound({ Name = usee.UseSound or "/EmptyCue", Id = usee.ObjectId })

	wait( 0.35 )

	thread( PlayVoiceLines, GlobalVoiceLines.FamiliarFledVoiceLines )

end

function CatFamiliarSpawnPresentation( familiar, args )
	if CurrentHubRoom ~= nil then
		SetAnimation({ Name = "Familiar_Cat_Sleep_Loop", DestinationId = familiar.ObjectId })
	else
		SetAlpha({ Id = familiar.ObjectId, Fraction = 0 })
		wait(0.4)
		local playerAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		SetGoalAngle({ Id = familiar.ObjectId, Angle = playerAngle, CompleteAngle = true })
		CreateAnimation({ Name = "TeleportDisappearSmall", DestinationId = familiar.ObjectId, OffsetY = -130 })
		wait(0.1)
		SetAlpha({ Id = familiar.ObjectId, Fraction = 1.0, Duration = 0.08 })
		SetAnimation({ Name = "Familiar_Cat_DropIn_Enter", DestinationId = familiar.ObjectId })
		wait( 1.0 )
		SetAnimation({ Name = "Familiar_Cat_Sleep_Start", DestinationId = familiar.ObjectId })
		wait( 3.0 )
	end
end

function CatFamiliarAlertedPresentation( familiar, args )
	thread( InCombatText, familiar.ObjectId, "Alerted", 0.25, { SkipShadow = true, OffsetY = 5 }  )
	PlaySound({ Name = familiar.AlertedSound or "/Leftovers/SFX/HarpDash", Id = familiar.ObjectId })
	SetAnimation({ Name = "Familiar_Cat_Sleep_Awaken", DestinationId = familiar.ObjectId })
	StopAnimation({ Name = familiar.DefaultAIData.RecruitAnimation, DestinationId = familiar.ObjectId })
	familiar.RecruitAnimationId = nil
end

function CatFamiliarPreAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_PreFire", DestinationId = familiar.ObjectId })

	thread( PlayVoiceLines, familiar.PreAttackVoiceLines, true, familiar )
end

function CatFamiliarAttackPresentation( familiar, args )
	SetAnimation({ Name = "Familiar_Cat_Attack_Fire", DestinationId = familiar.ObjectId })
end