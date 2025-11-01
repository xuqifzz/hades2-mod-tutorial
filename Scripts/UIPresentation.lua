function DisplayInfoBanner( source, args )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if SessionMapState.BlockInfoBanners then
		return
	end

	if SessionMapState.ShowingInfoBanner then
		return
	end
	SessionMapState.ShowingInfoBanner = true

	args = ShallowCopyTable( args )
	args = ApplyLocalizedProperties( args )
	args.ThreadName = args.ThreadName or "InfoBanner"

	if args.ActiveBountyOverrides ~= nil and CurrentRun.ActiveBounty ~= nil then
		args.Text = CurrentRun.ActiveBounty
		for key, value in pairs( args.ActiveBountyOverrides ) do
			args[key] = value
		end
	end

	local backColor = args.Color or Color.LocationTextGold
	local textColor = args.TextColor or Color.White
	local textFadeColor = args.TextFadeColor or textColor
	local fontScale = args.FontScale or 1.0
	local iconMoveSpeed = args.IconMoveSpeed or 1
	local additionalAnimation = args.AdditionalAnimation
	local highlightIcon = args.HighlightIcon
	local iconScale = args.IconScale or 1.0
	local iconBackingAnimationName = args.IconBackingAnimationName or "Blank"
	local iconBackingAnimationOutName = args.IconBackingAnimationOutName or "Blank"
	local iconBackingOffsetY = args.IconBackingOffsetY or 0
	local animationName = args.AnimationName or "LocationBackingIrisDeathIn"
	local animationOutName = args.AnimationOutName or "LocationBackingIrisDeathOut"
	local backingGradientAnimationName = args.BackingGradientAnimationName or "LocationBackingGradient"

	if args.SubtitleData == nil then
		args.SubtitleData = {}
	end

	local layer = args.Layer or "Combat_Menu_TraitTray_Overlay"

	wait( args.Delay or 0.25, args.ThreadName )
	if SessionMapState.BlockInfoBanners then
		SessionMapState.ShowingInfoBanner = false
		return
	end

	local textYOffset = ( 20 * fontScale ) + (args.TextOffsetY or 20)
	local subtitleYOffset = args.SubtitleOffsetY or (70 * fontScale)

	local backingGradientId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = args.BackgroundY or 140, Group = layer, Animation = backingGradientAnimationName, ScaleX = ScreenScaleX })

	local locationTextBG = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = args.BackgroundY or 140, Group = layer, })
	SetAnimation({ Name = animationName, DestinationId = locationTextBG })

	if args.AdditionalAnimation ~= nil then
		CreateAnimation({ Name = additionalAnimation, DestinationId = locationTextBG })
	end

	if args.TextRevealSound ~= nil then
		PlaySound({ Name = args.TextRevealSound })
	end

	local titleText = ShallowCopyTable( UIData.DisplayInfoBanner.TitleTextArgs )
	titleText.Id = locationTextBG
	titleText.Text = args.TitleText or args.Text
	titleText.Font = args.TitleFont or titleText.Font
	titleText.Width = GetLocalizedValue( args.TitleTextWidth or titleText.Width, args.LangWidth or UIData.DisplayInfoBanner.TitleTextArgs.LangWidth )
	titleText.FontSize = titleText.FontSize * fontScale
	titleText.Color = args.TitleTextColor or textColor
	titleText.OffsetX = args.TitleTextOffsetX
	titleText.OffsetY = textYOffset
	titleText.GroupName = layer
	CreateTextBox( titleText )

	local iconBackingId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 240 + iconBackingOffsetY,
		Group = layer,
		Animation = iconBackingAnimationName,
		Color = args.IconBackingColor,
	})
	if args.IconBackingHSV ~= nil then
		SetHSV({ Id = iconBackingId, HSV = args.IconBackingHSV, ValueChangeType = "Add" })
	end
	local iconId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 240, Group = layer })
	local subtitleShadowId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 240, Group = "Combat_Menu_TraitTray" })

	if args.Icon then	
		CreateAnimation({ Name = "LocationBackingIconShadowIn", DestinationId = iconId, Group = "Combat_Menu_TraitTray" })
		SetScale({ Id = iconId, Fraction = iconScale })
		SetAnimation({ Name = args.Icon, DestinationId = iconId, OffsetY = args.IconOffsetY, OffsetX = args.IconOffsetX })
		if highlightIcon then
			SetThingProperty({ Property = "AddColor", Value = true, DestinationId = iconId })
			SetColor({ Id = iconId, Color = { 255,200,196,0 } })
			SetColor({ Id = iconId, Color = { 0,0,0,255 }, Duration = 1.5 })
			SetAlpha({ Id = iconId, Fraction = 0 })
			SetAlpha({ Id = iconId, Fraction = 1, Duration = 0.125 })
			SetScale({ Id = iconId, Fraction = 0.5 * iconScale })
			SetScale({ Id = iconId, Fraction = 0.6 * iconScale, Duration = 3.5, EaseIn = 0, EaseOut = 1.0})
		end
		Move({ Id = iconId, Speed = iconMoveSpeed * 2, Angle = 0, Duration = 6, EaseOut = 1 })
	end

	if not args.SkipTextScaling then
		ModifyTextBox({ Id = locationTextBG, ScaleTarget = 1.2, ScaleDuration = 60 })
	end
	
	wait( args.SubtitleDelay or 0, args.ThreadName or RoomThreadName )
	if args.SubtitleTextRevealSound ~= nil then
		PlaySound({ Name = args.SubtitleTextRevealSound })
	end

	local subtitleText = ShallowCopyTable( UIData.DisplayInfoBanner.SubtitleTextArgs )
	subtitleText.Id = iconId
	subtitleText.Text = args.SubtitleText
	subtitleText.OffsetY = -15 + textYOffset + subtitleYOffset
	subtitleText.Font = args.SubtitleFont or subtitleText.Font
	subtitleText.FontSize = subtitleText.FontSize * fontScale
	subtitleText.Color = args.SubTextColor or subtitleText.Color
	subtitleText.LuaKey = args.SubtitleData.LuaKey
	subtitleText.LuaValue = args.SubtitleData.LuaValue
	subtitleText.GroupName = layer

	if subtitleText.Text ~= nil then
		SetAnimation({ Name = "LocationBackingSubtitleTextShadowIn", DestinationId = subtitleShadowId, OffsetY = subtitleText.OffsetY })
		SetScaleX({ Id = subtitleShadowId, Fraction = string.len(subtitleText.Text) / 10 })
		
	end

	CreateTextBox( subtitleText )

	if args.SubtitleData.UpdateDelay ~= nil then
		wait( args.SubtitleData.UpdateDelay, args.ThreadName or RoomThreadName )
		ModifyTextBox({ Id = iconId, LuaKey = args.SubtitleData.LuaKey, LuaValue = args.SubtitleData.LuaValueUpdate, })
		PulseText({ Id = iconId, ScaleTarget = 1.02, ScaleDuration = 0.60, HoldDuration = 0, PulseBias = 0.25 })
	end

	PlaySound({ Name = args.AppearSound or "/SFX/Menu Sounds/HadesLocationTextDisappear" })

	wait( (args.Duration or 3.0) - (args.SubtitleData.UpdateDelay or 0), args.ThreadName or RoomThreadName )

	SessionMapState.ShowingInfoBanner = false -- Ready for another one

	SetAnimation({ Name = animationOutName, DestinationId = locationTextBG })
	SetAnimation({ Name = iconBackingAnimationOutName, DestinationId = iconBackingId })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	SetAlpha({ Id = backingGradientId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = iconId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	StopAnimation({ Name = "LocationBackingIconShadowIn", DestinationId = iconId })
	SetAlpha({ Id = iconBackingId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = subtitleShadowId, Fraction = 0.0, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Id = iconId, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = backColor, ColorDuration = 0.5, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Id = locationTextBG, FadeTarget = 0.0, ColorTarget = textFadeColor, FadeDuration = 0.5, EaseIn = 0, EaseOut = 1 })
	wait( 0.5, args.ThreadName or RoomThreadName )
	Destroy({ Id = iconBackingId })
	Destroy({ Id = subtitleShadowId })
	wait( 0.5, args.ThreadName or RoomThreadName )

	Destroy({ Ids = { backingGradientId, locationTextBG, iconId } })

end

function RunInterstitialPresentation( data, args )

	if data == nil then
		return
	end

	args = args or {}

	if data.Header ~= nil then
		GameState.RunInterstitialRecord[data.Header] = true	
	end

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleCombatControl({"AdvancedTooltip"}, false, "Interstitial" )

	HideCombatUI("ShowingInterstitial")
	AltAspectRatioFramesShow()
	if data.PauseMusic then
		PauseMusic()
	end

	local text = data.Header
	local color = Color.White

	local groupName = args.GroupName or "Combat_Menu_Overlay"

	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = groupName, Scale = 10.0, Color = Color.Black })

	wait(0.25)

	local source = {} -- Dummy source for disembodied voice
	source.LineHistoryName = "Speaker_Anonymous"
	if GameState.TextLinesRecord.InspectHomerReveal01 then
		source.LineHistoryName = "Speaker_Homer"
	end
	source.SubtitleColor = data.SubtitleColor or Color.NarratorVoice
	thread( PlayVoiceLines, data.VoiceLines, false, source, { Queue = "Interrupt" } )
	if not args.SkipFadeIn then
		FadeIn({ Duration = 0 })
	end

	if args.StartSound ~= nil then
		PlaySound({ Name = args.StartSound })
	end
	local loopSoundId = nil
	if args.LoopSound ~= nil then
		loopSoundId = PlaySound({ Name = args.LoopSound })
	end

	if data.UseFadeIn ~= nil then
		FadeOut({ Color = Color.Black, Duration = 0.0 })
		FadeIn({ Duration = 0.5 })
	end

	local anims = args.Animations or data.Animations or
		{
			{
				AnimationName = "RemBGIntroStart",
			},
		}
	if anims ~= nil then
		ScreenAnchors.Epilogue = {}
		for index, animationData in ipairs( anims ) do
			animationData.Id = CreateScreenObstacle({ Name = "BlankObstacle",
				X = animationData.X or ScreenCenterX,
				Y = animationData.Y or ScreenCenterY,
				Group = animationData.Group or groupName,
				Animation = animationData.AnimationName,
				Scale = animationData.Scale,
				Alpha = animationData.Alpha,
				AlphaTarget = animationData.AlphaTarget,
				AlphaTargetDuration = animationData.AlphaTargetDuration,
			})
			if animationData.ScaleTarget ~= nil then
				SetScale({ Id = animationData.Id, Fraction = animationData.ScaleTarget, Duration = animationData.ScaleTargetDuration, EaseIn = animationData.ScaleEaseIn, EaseOut = animationData.ScaleEaseOut })
			end
			table.insert( ScreenAnchors.Epilogue, animationData.Id )
		end
	end

	wait( data.TextDelay or 2.2 )
	if ambienceId ~= nil then
		StopSound({ Id = ambienceId, Duration = 15.8 })
	end
	local lang = GetLanguage({})
	local fontSize = 86
	if lang == "pl" then
		local charLen = utf8strlen(GetDisplayName({ Text = text }))
		if charLen >= 14 then
			fontSize = 58
		elseif charLen >= 10 then
			fontSize = 65
		else
			fontSize = 86
		end
	end
	local promptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX , Y = ScreenCenterY + 260, Group = groupName })
	CreateTextBox({	Id = promptId, Text = text, Justification = "CENTER",
			ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			Font = "SpectralSCLightTitling", FontSize = fontSize, Color = data.TextColor1 or {0.729,0.702,0.631,255},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			})
	ModifyTextBox({ Id = promptId, ScaleTarget = 1.2, ScaleDuration = 70 })

	if not args.SkipSound then
		PlaySound({ Name = "/Leftovers/World Sounds/MapText", Id = promptId })
	end

	wait(data.FadeOutWait or 5)

	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 1.0, ColorTarget = { 0.302 , 0.255 , 0.137 , 1 }, ColorDuration = 0.5 })

	if not data.SkipFadeSound and not args.SkipSound then
		local fadeSoundId = PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade", Id = promptId })
		SetVolume({ Id = fadeSoundId, Value = 0.3 })
	end
	if loopSoundId ~= nil then
		StopSound({ Id = loopSoundId, Duration = 0.2 })
	end
	wait(1.0)
	wait(1.0)
	FadeOut({ Color = Color.Black, Duration = 1.0 })
	wait(2.2)
	DestroyTextBox({ Id = promptId })
	Destroy({ Id = promptId })
	Destroy({ Id = blackScreenId })
	Destroy({ Ids = ScreenAnchors.Epilogue })

	ResumeMusic()
	
	ToggleCombatControl({"AdvancedTooltip"}, true, "Interstitial" )
	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")
	AltAspectRatioFramesHide()
end

function DisplayInfoToast( source, args )

	AddInputBlock({ Name = "DisplayInfoToast" })

	local threadName = RoomThreadName
	wait( args.WaitTime or 0.5, threadName )

	local backgroundDimId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray", Scale = 4.0, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetColor({ Id = backgroundDimId, Color = Color.Black, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.8, Duration = 0.3 })

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX-10, Y = 680, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ Name = args.Animation or "NewUnlock", DestinationId = toastAnchor })

	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = args.Title,
		Justification = "Center",
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 1},
		OutlineThickness = 2,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		Color = {95, 114, 211, 255},
		Font="SpectralSCMedium",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 10,
		OffsetY = 86
	})
	if args.Text ~= nil then
		CreateTextBox({
			Id = toastAnchor,
			Text = args.Text,
			Justification = "Center",
			ShadowColor = {0,0,0,1},
			ShadowOffset = {0, 1},
			OutlineThickness = 2,
			OutlineColor = {0.113, 0.113, 0.113, 1},
			Color = {150, 180, 230, 255},
			Font = "LatoSemiboldItalic",
			TextSymbolScale = 1,
			FontSize = 17,
			CharFadeTime = 0.02,
			CharFadeInterval = .002,
			CharFadeColor = Color.Orange,
			CharFadeColorLag = 0.25,
			Width = 400,
			OffsetX = 10,
			OffsetY = 123
		})
	end

	if args.VoiceLines ~= nil then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end

	wait( args.Duration or 1.0, threadName )

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })
	wait( 0.5, threadName )

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.0, Duration = 1.0 })
	wait( 1.0, threadName )

	Destroy({ Ids = { toastAnchor, backgroundDimId } })

	RemoveInputBlock({ Name = "DisplayInfoToast" })

	if args.GiftResource ~= nil then
		ResourceGiftedInEventPresentation( source, args )
	end

end

function TraitTrayHoverOnPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
end

function TraitTrayPinOnPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonPin", Id = button.Id })
end

function TraitTrayPinOffPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonUnpin", Id = button.Id })
end

function RunClearMessagePresentation( screen, message )

	if message == nil then
		return
	end

	local components = screen.Components

	wait( 1.0 )

	ModifyTextBox({ Id = components.RunClearMessageText.Id, Text = message, ScaleTarget = 1, ScaleDuration = 0.25, EaseIn = 0, EaseOut = 1 })
	SetAlpha({ Id = components.RunClearMessageText.Id, Fraction = 0.0 })
	SetAlpha({ Id = components.RunClearMessageText.Id, Fraction = 1.0, Duration = 1.0, EaseIn = 0, EaseOut = 1 })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon" })

	wait( 1.0 )

end

function ScreenCantAffordPresentation( screen, button, costData )
	Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	
	if button.Data and button.Data.CannotAffordVoiceLines then
		thread( PlayVoiceLines, button.Data.CannotAffordVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughCurrencyVoiceLines, true )
	end

	local resourceCostData = costData or button.Data.Cost or button.Data.ResourceCost

	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then
			if not HasResource( resourceName, resourceCostData[resourceName] ) then
				local backingKey = "ResourceIconBacking"..resourceName
				local resourceIconBacking = screen.Components[backingKey]
				if resourceIconBacking ~= nil then
					Flash({ Id = resourceIconBacking.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
				end
			end
		end
	end

end

function GenericScreenOpenStartPresentation( screen )
	if screen.OpenSound ~= nil then
		PlaySound({ Name = screen.OpenSound })
	end

	if screen.OpenVoiceLines ~= nil then
		if PlayVoiceLines( screen.OpenVoiceLines, true ) then
			return
		end
	end

	if screen.AngleHeroTowardTarget ~= nil then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = screen.OpenedFrom.ObjectId })
	end

	if screen.OpenPlayerAnimation ~= nil then
		SetAnimation({ Name = screen.OpenPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

end

function GenericScreenOpenEndPresentation( screen )
	if screen.OfferedVoiceLines ~= nil then
		if PlayVoiceLines( screen.OfferedVoiceLines ) then
			return
		end
	end
	if screen.OpenEndVoiceLines ~= nil then
		if PlayVoiceLines( screen.OpenEndVoiceLines, true ) then
			return
		end
	end
end

function GenericScreenClosePresentation( screen )
	if screen.CloseSound ~= nil then
		PlaySound({ Name = screen.CloseSound })
	end
	if screen.CloseVoiceLines ~= nil then
		if PlayVoiceLines( screen.CloseVoiceLines, true ) then
			return
		end
	end
end

function GenericScreenCloseFinishedPresentation( screen )
	if screen.CloseFinishedVoiceLines ~= nil then
		if PlayVoiceLines( screen.CloseFinishedVoiceLines, true ) then
			return
		end
	end
end

function GenericMouseOverPresentation( button )
	local screen = button.Screen
	local components = screen.Components
	if button.MouseOverSound ~= nil then
		PlaySound({ Name = button.MouseOverSound, Id = button.Id })
	elseif screen.MouseOverSound ~= nil then
		PlaySound({ Name = screen.MouseOverSound, Id = button.Id })
	end
end

function GenericScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
end

function GenericInfoPresentation( screen, button )
	OpenMenu({ Name = "AnnouncementScreen", MessageId = screen.InfoMessageId or "DeathMessage" })
	waitUntil( "AnnouncementScreen" )
	wait( 0.3 )
end

function UpgradeChoiceScreenOpenStartPresentation( screen, lootData )
	PlaySound({ Name = lootData.UpgradeScreenOpenSound or "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	if lootData.PortraitEnterSound ~= nil then
		PlaySound({ Name = lootData.PortraitEnterSound })
	end
	if lootData.UpgradeScreenOpenFunctionName ~= nil then
		CallFunctionName( lootData.UpgradeScreenOpenFunctionName, screen )
	end
	if lootData.HasExchange then
		thread( PlayVoiceLines, HeroVoiceLines.UpgradeMenuOpenVoiceLines, true )
	else
		thread( PlayVoiceLines, lootData.UpgradeMenuOpenVoiceLines )
	end
end

function HUDTraitAddedPresentation( trait, args )
	if trait.Hidden or trait.HideInHUD then
		return
	end
	local newTrait = trait
	if not trait.Slot then
		newTrait = 
		{
			NewTraitHighlightAnimation = trait.NewTraitHighlightAnimation,
			ActiveSlotOffsetIndex = trait.ActiveSlotOffsetIndex,
			Name = trait.Name,
			Icon = trait.Icon,
			StackNum = trait.StackNum,
			Rarity = trait.Rarity,
			TrayHighlightAnimScale = trait.TrayHighlightAnimScale,
		}
	end

	if ScreenState.TraitAddedPresentation then		
		table.insert( ScreenState.TraitAddedPresentationQueue, { NewTrait = newTrait, Args = args } )
		return
	end
	ScreenState.TraitAddedPresentation = true

	local tempDisplay = false
	if newTrait.AnchorId ~= nil then
		wait( args.TraitAddedPresentationDelay )
		CreateAnimation({ Name = newTrait.NewTraitHighlightAnimation or "NewTraitHighlight", DestinationId = newTrait.AnchorId })
	elseif HUDScreen ~= nil then
		tempDisplay = true
		wait( args.TraitAddedPresentationDelay or 0.5 )
		TraitUIAdd( newTrait, { Show = true, LocationX = ScreenData.HUD.ComponentData.TraitCount.X + 24, LocationY = ScreenData.HUD.ComponentData.TraitCount.Y + 80, } )
		wait( 0.5 )
		CreateAnimation({ Name = newTrait.NewTraitHighlightAnimation or "NewTraitHighlight", DestinationId = newTrait.AnchorId })
	end
	if HUDScreen ~= nil then
		wait( 0.6 )
		UpdateTraitSummary( { TextUpdateDelay = 0.5 } )
		thread( PulseText, { Id = HUDScreen.Components.TraitCount.Id, ScaleTarget = 1.3, ScaleDuration = 0.5, Color = Color.Gold, OriginalColor = Color.White, HoldDuration = 0, PulseBias = 0.2 })
		wait( 1.0 )
		if tempDisplay then
			thread( HUDHideTrait, newTrait, { RemoveAfterHidden = true } )
		end
	end

	ScreenState.TraitAddedPresentation = false

	if not IsEmpty( ScreenState.TraitAddedPresentationQueue ) then
		local nextPresentation = RemoveFirstIndexValue( ScreenState.TraitAddedPresentationQueue )
		HUDTraitAddedPresentation( nextPresentation.NewTrait, nextPresentation.Args )
	end

end

function PulseContextActionPresentation( button, args )
	args = args or {}
	local threadName = args.ThreadName or "PulseContextAction"
	local offsetX = args.OffsetX or -150
	waitUnmodified( args.InitialWait or 1.0, threadName )
	while true do
		if button.Visible then
			CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = button.Id, GroupName = "ScreenOverlay", OffsetX = offsetX })
			PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = button.Id })
			PulseText( { Id = button.Id, Color = args.Color or Color.BoonPatchRare, ThreadName = threadName, OriginalColor = Color.ContextActionLabel, ScaleTarget = 1.25, ScaleDuration = 0.2, HoldDuration = 0.1, StartColorDuration = 0.1, EndColorDuration = 2, ResetDuration = 4.0 } )
		
			if args.PulseOnce then
				break
			end
		end
		waitUnmodified( args.TimeBetweenPulses or 5.0, threadName )
	end
end

function ChronosHealthBarTextTransition(boss)

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0.0, FadeDuration = 0.66 })

	wait(0.66)

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, Text = boss.Phase3HealthBarTextId, FadeTarget = 1.0, FadeDuration = 0.33 })
end