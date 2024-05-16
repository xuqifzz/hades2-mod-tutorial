function HarvestBlockedPresentation( source, args, user )
	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	local combatText = roomData.HarvestBlockedText or RoomData.BaseRoom.HarvestBlockedText
	if not IsEmpty( RequiredKillEnemies ) or not IsEmpty( MapState.AggroedUnits ) then
		combatText = "UseBlockedByEnemies"
	end
	thread( InCombatText, user.ObjectId, combatText, 1.0, { ShadowScale = 0.6 } )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })
end

function HarvestNoToolPresentation( source, args, user, toolName )
	if CheckCooldown( "UseNoToolPlayedRecently", 1.2 ) then
		thread( InCombatText, user.ObjectId, "UseNoTool", 1.0, { ShadowScale = 0.6 } )
	end
	if HUDScreen.Components.ToolIcon ~= nil then
		Flash({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 4.0, MinFraction = 0, MaxFraction = 1.0, Color = Color.Red, ExpireAfterCycle = true })
		Shake({ Id = HUDScreen.Components.ToolIcon.Id, Speed = 100, Distance = 2, Duration = 0.3 })
	end
	thread( PlayVoiceLines, HeroVoiceLines.ToolTutorialVoiceLines, true )
	thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	if not HasAccessToTool( "ToolExorcismBook" ) and CheckCooldown( "GhostEmotedRecently", 7.0 ) then
		thread( PlayEmote, { Target = source, EmoteName = "Fear", PlaySound = true, DelayMax = 0.1 } )
	end
end

function HarvestStartPresentation( source, args, user )

	AddOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "HarvestPointUseCanceled"
	user.PreHarvestThreadName = "HarvestStartPresentation"

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	waitUnmodified( 0.1, user.PreHarvestThreadName )

	-- thread( PlayVoiceLines, args.VoiceLines or HeroVoiceLines.HarvestVoiceLines, true )

	PlaySound({ Name =  source.PickUpSound or "/SFX/ResourceGatherSFX", Id = user.ObjectId })

	waitUnmodified( 0.1, user.PreHarvestThreadName )

	RemoveOnDamagedFunction( user, "HarvestPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil

	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract", Id = user.ObjectId })

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })
	waitUnmodified(0.1)

	SetAnimation({ Name = source.EmptyAnimation or "HarvestPointUsed", DestinationId = source.ObjectId })
	SetScale({ Id = source.ObjectId, Fraction = 0.0, EaseIn = 0, EaseOut = 1, Duration = 0.15 })
	CreateAnimation({ Name = source.ConsumeFx or "ItemConsumeFxSmall", DestinationId = source.ObjectId, Group = "Standing" })


	local harvestPointUsedAnimation = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Terrain", DestinationId = source.ObjectId })
	CreateAnimation({ Name = source.EmptyAnimation or "HarvestPointUsed", DestinationId = harvestPointUsedAnimation })
	SetScaleY({ Id = harvestPointUsedAnimation, Fraction = 0 })
	SetAlpha({ Id = harvestPointUsedAnimation, Fraction = 0 })
	SetScaleY({ Id = harvestPointUsedAnimation, Fraction = 1, Duration = 0.25, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = harvestPointUsedAnimation, Fraction = 1, Duration = 0.25, EaseIn = 0, EaseOut = 1 })

	waitUnmodified(0.15)
	SetAnimation({ Name = "Blank", DestinationId = source.ObjectId})
	

	if source.HarvestedDrawGroup ~= nil then
		ChangeDrawGroup( source.ObjectId, source.HarvestedDrawGroup )
	end
	waitUnmodified(0.4)
	
end

function HarvestEndPresentation( source, args, user )	
	waitUnmodified( 0.2 )
end

function HarvestBonusResourcePresentation( source, args, user )
	--thread( InCombatText, user.ObjectId, "HarvestBonusProc", 1.0, { ShadowScale = 0.6 } )
	wait( 0.5 )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Id = user.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.HarvestBonusResourceVoiceLines, true )

end

function ShovelStartPresentation( source, args, user )

	AddOnDamagedFunction( user, "ShovelPointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "ShovelPointUseCanceled"
	user.PreHarvestThreadName = "ShovelStartPresentation"

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

function FamiliarPickaxeStartPresentation( source, args, user )

	PlaySound({ Name = "/SFX/Enemy Sounds/Exalted/ExaltedPreAttackFlashSoundBow" })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = MapState.FamiliarUnit.ObjectId })
	SetAnimation({ Name = "MelinoeBountyTurnInStart", DestinationId = CurrentRun.Hero.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified(0.7)
	PlaySound({ Name = MapState.FamiliarUnit.HarvestSound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
	thread ( PlayEmoteSimple, MapState.FamiliarUnit, { AnimationName = MapState.FamiliarUnit.ConfirmEmoteAnim or "StatusIconSmile" } )

	thread( BackPlayerUp, user, source, { Distance = 250 } )
	MoveFamiliarToLocation( MapState.FamiliarUnit, { Id = source.ObjectId } )
	waitUnmodified(0.05)
	AngleTowardTarget({ Id = GameState.EquippedFamiliar.ObjectId, DestinationId = source.ObjectId })
	waitUnmodified(0.05)
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusGunReloadCompleteFlashLucifer" })
	waitUnmodified(0.1)

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
	--PickaxeStartPresentation( source, args, user )
end

function PickaxeStartPresentation( source, args, user )

	AddOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = "PickaxePointUseCanceled"
	user.PreHarvestThreadName = "PickaxeStartPresentation"
	
	thread( PlayVoiceLines, HeroVoiceLines.PickaxeUseInProgressVoiceLines, true )

	SetAnimation({ Name = "MelinoePickAxeMineStart", DestinationId = user.ObjectId })

	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteCharging", Id = user.ObjectId })

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
	RemoveOnDamagedFunction( user, "PickaxePointUseCanceled" )
	user.OnHostilePolymorphFunctionName = nil

	waitUnmodified( 0.3, user.PreHarvestThreadName )
end

function PickaxeDepositDamagedPresentation( source, args, user )
	waitUnmodified( 0.1 )
	
end

function PickaxeDepositDestroyedPresentation( source, args, user )
	
	PlaySound({ Name = "/SFX/PickaxeOreDestroyed", Id = source.ObjectId })
	CreateAnimation({ Name = "DustPuffRotate", DestinationId = source.ObjectId })

	SetAnimation({ Name = source.EmptyAnimation, DestinationId = source.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.PickaxeDepositDestroyedVoiceLines, true )

	if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.Name == "RavenFamiliar" then
		PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })
		--thread ( PlayEmoteSimple, MapState.FamiliarUnit, { AnimationName = MapState.FamiliarUnit.VictoryEmoteAnim or "StatusIconSmile" } )
	end

	waitUnmodified( 0.1 )
	PlaySound({ Name = "/SFX/DustTouchdownPuff", Id = source.ObjectId })

end

function ExorcismPointChosenPresentation( source )
	Flash({ Id = source.ObjectId, Speed = 4.0, MinFraction = 0.3, MaxFraction = 0.7, Color = Color.White, Duration = 0.8 })
	if source.LeftHintId == nil then
		source.LeftHintId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = source.ObjectId, OffsetX = -100, OffsetZ = 100, Group = "Combat_UI" })
		SetAnimation({ Name = "GUI\\Icons\\MelArmLeftBacking", DestinationId = source.LeftHintId })
		CreateTextBox({ Id =  source.LeftHintId,
			Text = "ExorcismLeft",
			FontSize = 22,
			OffsetX = 12, OffsetY = 102,
			Font = "P22UndergroundSCHeavy",
			Justification = "Center" })
	end
	if source.RightHintId == nil then
		source.RightHintId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = source.ObjectId, OffsetX = 100, OffsetZ = 100, Group = "Combat_UI" })
		SetAnimation({ Name = "GUI\\Icons\\MelArmRightBacking", DestinationId = source.RightHintId })
		CreateTextBox({ Id =  source.RightHintId,
			Text = "ExorcismRight",
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
	PlaySound({ Name = MapState.FamiliarUnit.EquipSound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId })

	thread( PlayVoiceLines, HeroVoiceLines.FamiliarHarvestVoiceLines, true )

	waitUnmodified( 0.4 )
	SetAnimation({ Name = "MelinoeCrossCast", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, })
	CreateAnimation({ Name = "ItemGet_Tool", DestinationId = MapState.FamiliarUnit.ObjectId, OffsetZ = -60 })

	waitUnmodified( 0.3 )

	if MapState.FamiliarUnit.HarvestSound ~= nil then
		PlaySound({ Name = MapState.FamiliarUnit.HarvestSound, Id = MapState.FamiliarUnit.ObjectId })
	end

	PlaySound({ Name = "/SFX/ThanatosAttackBell" })
	thread( BackPlayerUp, user, source, { Distance = 250 } )
	MoveFamiliarToLocation( MapState.FamiliarUnit )
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

function FamiliarExorcismSuccessPresentation( source, args, user )
	ExorcismSuccessPresentation( source, args, user )
end

function ExorcismStartPresentation( source, args, user )

	source.LoopingSoundId = PlaySound({ Name = "/SFX/Menu Sounds/CauldronChoirLoop" })
	thread( PlayInteractAnimation, source.ObjectId)
	AngleTowardTarget({ Id = source.ObjectId, DestinationId = user.ObjectId, SetBase = true })
	
	if GameState.ExorcismSuccesses == nil then
		thread( InCombatTextArgs, { Text = "Exorcism_Hint", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -305, SkipRise = true, SkipFlash = true, Duration = 3.0, PreDelay = 0.5, ShadowScaleX = 1.5 } )
		wait( 3.1, user.PreExorcismThreadName )
	else
		thread( InCombatTextArgs, { Text = "Exorcism_Hint", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -305, SkipRise = true, SkipFlash = true, Duration = 2.5, PreDelay = 0.5, ShadowScaleX = 1.5 } )
		wait( 1.0, user.PreExorcismThreadName )
	end

	thread( PlayVoiceLines, HeroVoiceLines.ExorcismStartVoiceLines, true )

	if source.AttemptsRemaining < 1 then
		thread( InCombatText, user.ObjectId, "Hint_LastChance", 1.0, { ShadowScale = 0.6, PreDelay = 1.25 } )
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
		thread( PulseExorcismIcon, source.LeftHintId, true )
	else
		SetAlpha({ Id = source.LeftHintId, Fraction = 0.0, Duration = 0.1 })
	end
	if move.Right then
		SetAlpha({ Id = source.RightHintId, Fraction = 1, Duration = 0.1 })
		thread( PulseExorcismIcon, source.RightHintId, false )
	else
		SetAlpha({ Id = source.RightHintId, Fraction = 0.0, Duration = 0.1 })
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
		SetAlpha({ Ids = source.ObjectId, Fraction = 0, Duration = 0.7 })	
		waitUnmodified(0.7)
		SetAnimation({ Name = "ExorcismGhostDissipate", DestinationId = source.ObjectId })
		PlaySound({ Name = "/SFX/GhostEvaporate", Id = source.ObjectId })
	end
end

function ExorcismSuccessPresentation( source, args, user )

	PlaySound({ Name = "/SFX/GhostEvaporate", Id = source.ObjectId })
	Shake({ Id = source.ObjectId, Speed = 100, Distance = 3 })
	Flash({ Id = source.ObjectId, Speed = 1.0, MinFraction = 0, MaxFraction = 1.0, Color = Color.White })
	StopSound({ Id = source.LoopingSoundId, Duration = 0.7 })

	PanCamera({ Id = user.ObjectId, Duration = 0.3 })
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 0.3, ZoomType = "Ease" })
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })

	thread( PlayVoiceLines, HeroVoiceLines.ExorcismSucceededVoiceLines, true )

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof" })
	local hintIds = { source.LeftHintId, source.RightHintId }
	SetAlpha({ Ids = hintIds, Fraction = 0, Duration = 0.0 })
	for index, move in ipairs( source.MoveSequence ) do
		local key = "MovePipId"..index
		SetAlpha({ Id = source[key], Fraction = 0, Duration = 0.0 })
	end
	DebugPrint({ Text = "Exorcism: Success" })
	SetAnimation({ Name = "Melinoe_Tablet_ReturnToIdle", DestinationId = user.ObjectId })
	thread( InCombatTextArgs, { Text = "ExorcismSuccess", TargetId = user.ObjectId, Duration = 1.0, PreDelay = 0.17, FontScale = 20, SkipRise = false, OffsetY = -100, SkipShadow = true } )

	if MapState.FamiliarUnit and MapState.FamiliarUnit.Name == "FrogFamiliar" then
		waitUnmodified( 0.85 )
		thread( PlayVoiceLines, HeroVoiceLines.FamiliarThankingVoiceLines, true )
		PlaySound({ Name = MapState.FamiliarUnit.VictorySound or "/EmptyCue", Id = MapState.FamiliarUnit.ObjectId, Delay = 2 })
		SetAnimation({ DestinationId = MapState.FamiliarUnit.ObjectId, Name = "Familiar_Frog_Greet" })
		--thread( PlayEmoteSimple, MapState.FamiliarUnit, { AnimationName = MapState.FamiliarUnit.VictoryEmoteAnim or "StatusIconSmile", Delay = 2 } )
	end

	waitUnmodified(0.5)

	thread( PlayEmote, { Target = source, EmoteName = "Smile", PlaySound = true } )

	SetAlpha({ Id = source.ObjectId, Fraction = 0, Duration = 0.7 })
	
	waitUnmodified(0.7)

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
	if not IsEmpty( RequiredKillEnemies ) or IsAggoredUnitBlockingHarvest() then
		return "UseExorcismPointLocked"
	end
	local roomData = RoomData[CurrentRun.CurrentRoom.Name] or CurrentRun.CurrentRoom
	if not CurrentRun.CurrentRoom.ExitsUnlocked and not roomData.AllowExorcismPreExitsUnlock then
		return "UseExorcismPointLocked"
	end
	if useTarget.FamiliarUseText ~= nil and useTarget.LinkedToolName and HasFamiliarTool( useTarget.LinkedToolName ) then
		return useTarget.FamiliarUseText
	end
	return useTarget.UseText
end