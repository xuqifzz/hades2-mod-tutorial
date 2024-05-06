function DisplayInfoBanner( source, args )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	args = ShallowCopyTable( args )

	if args.UseBiomeStateSubtitle then
		for k, trait in pairs( CurrentRun.Hero.Traits ) do
			if trait.AddToLocationText then
				args.SubtitleText = trait.Name
				args.SubtitleOffsetY = -17
				args.SubtitleDelay = 0.75
				break
			end
		end
	end
	if args.ActiveBountyOverrides ~= nil and CurrentRun.ActiveBounty ~= nil then
		args.Text = CurrentRun.ActiveBounty
		for key, value in pairs( args.ActiveBountyOverrides ) do
			args[key] = value
		end
	end

	local backColor = args.Color or Color.LocationTextGold
	local textColor = args.TextColor or Color.White
	local fontScale = args.FontScale or 1.0
	local iconMoveSpeed = args.IconMoveSpeed or 1
	local additionalAnimation = args.AdditionalAnimation
	local highlightIcon = args.HighlightIcon
	local iconBacking = args.IconBacking or "BountyEarnedIconBacking"
	local iconScale = args.IconScale or 1.0
	local animationName = args.AnimationName or "LocationBackingIrisDeathIn"
	local animationOutName = args.AnimationOutName or "LocationBackingIrisDeathOut"

	if args.SubtitleData == nil then
		args.SubtitleData = {}
	end
	if args.SupertitleData == nil then
		args.SupertitleData = {}
	end

	local layer = args.Layer or "Combat_Menu_TraitTray_Overlay"

	wait( args.Delay or 0.25, args.ThreadName or RoomThreadName )

	local textYOffset = ( 20 * fontScale ) + (args.TextOffsetY or 20)
	local supertitleYOffset = 60 * fontScale
	local subtitleYOffset = args.SubtitleOffsetY or (70 * fontScale)
	if args.SupertitleText ~= nil then
		textYOffset = -35 * fontScale
		subtitleYOffset = 45 * fontScale
	end

	local backingGradientId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = args.BackgroundY or 140, Group = layer, Animation = "LocationBackingGradient", ScaleX = ScreenScaleX })

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
	titleText.Width = titleText.Width
	titleText.FontSize = titleText.FontSize * fontScale
	titleText.Color = args.SuperTitleTextColor or textColor
	titleText.OffsetY = textYOffset
	titleText.GroupName = layer
	CreateTextBox( titleText )

	local iconBackingId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 225, Group = layer })
	local iconId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 225, Group = layer })
	if args.Icon then
		--SetAnimation({ Name = iconBacking, DestinationId = iconBackingId, OffsetY = 10 })
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

	wait( args.SubtitleDelay or 0, args.ThreadName or RoomThreadName )
	if args.SubtitleTextRevealSound ~= nil then
		PlaySound({ Name = args.SubtitleTextRevealSound })
	end

	local subtitleText = ShallowCopyTable( UIData.DisplayInfoBanner.SubtitleTextArgs )
	subtitleText.Id = iconId
	subtitleText.Text = args.SubtitleText
	subtitleText.OffsetY = -20 + textYOffset + subtitleYOffset
	subtitleText.Font = args.SubtitleFont or subtitleText.Font
	subtitleText.FontSize = subtitleText.FontSize * fontScale
	subtitleText.Color = args.SubTextColor or subtitleText.Color
	subtitleText.LuaKey = args.SubtitleData.LuaKey
	subtitleText.LuaValue = args.SubtitleData.LuaValue
	subtitleText.GroupName = layer
	CreateTextBox( subtitleText )

	ModifyTextBox({ Id = locationTextBG, ScaleTarget = 1.2, ScaleDuration = 60 })

	if args.SubtitleData.UpdateDelay ~= nil then
		wait( args.SubtitleData.UpdateDelay, args.ThreadName or RoomThreadName )
		ModifyTextBox({ Id = iconId, LuaKey = args.SubtitleData.LuaKey, LuaValue = args.SubtitleData.LuaValueUpdate, })
		PulseText({ Id = iconId, ScaleTarget = 1.02, ScaleDuration = 0.60, HoldDuration = 0, PulseBias = 0.25 })
	end

	local supertitleTextId = nil
	if args.SupertitleText ~= nil then
		wait( args.SupertitleTextDelay, args.ThreadName or RoomThreadName )
		supertitleTextId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 140 + textYOffset + supertitleYOffset, Group = layer, })

		local supertitleText = ShallowCopyTable( UIData.DisplayInfoBanner.SupertitleTextArgs )
		supertitleText.Id = supertitleTextId
		supertitleText.Text = args.SupertitleText 
		supertitleText.Font = args.SupertitleFont or supertitleText.Font 
		supertitleText.FontSize = supertitleText.FontSize * fontScale 
		supertitleText.Color = args.SupertitleTextColor or textColor
		supertitleText.LuaKey = args.SupertitleData.LuaKey 
		supertitleText.LuaValue = args.SupertitleData.LuaValue
		supertitleText.GroupName = layer
		CreateTextBox( supertitleText )
	end

	PlaySound({ Name = args.AppearSound or "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = promptId })
	-- to make Duration work properly, the UnlockTextBG anim needs to be split up
	wait( (args.Duration or 3.0) - (args.SupertitleTextDelay or 0) - (args.SubtitleData.UpdateDelay or 0), args.ThreadName or RoomThreadName )
	SetAnimation({ Name = animationOutName, DestinationId = locationTextBG })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	SetAlpha({ Id = backingGradientId, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Id = iconId, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Id = iconBackingId, Fraction = 0.0, Duration = 0.5 })
	--ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = backColor, ColorDuration = 0.5 })
	ModifyTextBox({ Id = iconId, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = backColor, ColorDuration = 0.5 })
	ModifyTextBox({ Id = locationTextBG, FadeTarget = 0.0, FadeDuration = 0.5 })
	ModifyTextBox({ Id = supertitleTextId, FadeTarget = 0.0, FadeDuration = 0.5 })
	wait( 0.5, args.ThreadName or RoomThreadName )
	--Destroy({ Id = iconBackingId })
	wait( 0.5, args.ThreadName or RoomThreadName )

	DestroyTextBox({ Id = promptId })
	Destroy({ Ids = { backingGradientId, promptId, locationTextBG, iconId }})

end

function RunInterstitialPresentation( data, args )

	if data == nil then
		return
	end

	args = args or {}

	if data.Header ~= nil then
		GameState.RunInterstitialRecord[data.Header] = true	
	end

	LoadVoiceBanks( data.SpeakerName or "Hecate" )
	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleCombatControl({"AdvancedTooltip"}, false, "Interstitial" )

	HideCombatUI("ShowingInterstitial")
	if data.PauseMusic then
		PauseMusic()
	end

	-- special case for N_Boss01
	local dozingCyclopsId = GetIdsByType({ Name = "PolyphemusCorpse" })
	SetAnimation({ Name = "Enemy_Polyphemus_DeathIdle_Silent", DestinationId = dozingCyclopsId })

	local text = data.Header
	local text2 = data.Header2
	local color = Color.White

	local blackScreenId = nil
	if not data.SkipBackgrounds then
		blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
		SetScale({ Id = blackScreenId, Fraction = 10 })
		SetColor({ Id = blackScreenId, Color = Color.Black })
		SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	end

	wait(0.25)

	local source = {} -- Dummy source for disembodied voice
	source.LineHistoryName = "Speaker_Anonymous"
	if GameState.TextLinesRecord.InspectHomerReveal01 then
		source.LineHistoryName = "Speaker_Homer"
	end
	source.SubtitleColor = data.SubtitleColor or Color.NarratorVoice
	thread( PlayVoiceLines, data.VoiceLines, false, source )
	FadeIn({ Duration = 0 })

	local remBG = nil
	if not data.SkipBackgrounds then
		remBG = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
		SetScale({ Id = remBG, Fraction = 1 })
		SetColor({ Id = remBG, Color = Color.Black, Duration = 0 })
		SetAlpha({ Id = remBG, Fraction = 1.0, Duration = 0 })
		SetAnimation({ Name = data.BackgroundAnimation or "RemBGIntro", DestinationId = remBG })
		PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = promptId })

	end

	local hadesOverlay = nil
	if data.RemembranceAnimation ~= nil then
		hadesOverlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Overlay" })
		SetScale({ Id = hadesOverlay, Fraction = 1 })
		SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
		Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })
		SetAnimation({ Name = data.RemembranceAnimation, DestinationId = hadesOverlay })
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end

	if data.UseFadeIn ~= nil then
		FadeOut({ Color = Color.Black, Duration = 0.0 })
		FadeIn({ Duration = 0.5 })
	end

	if data.Animations ~= nil then
		ScreenAnchors.Epilogue = {}
		CreateGroup({ Name = "Events_Additive", BlendMode = "Additive" })
		InsertGroupInFront({ Name = "Events_Additive", DestinationName = "Events" })
		for index, animationData in ipairs(data.Animations) do
			animationData.Id = CreateScreenObstacle({ Name = "BlankObstacle", X = animationData.X or ScreenCenterX , Y = animationData.Y or ScreenCenterY, Group = animationData.Group or "Events" })
			table.insert(ScreenAnchors.Epilogue, animationData.Id)
			thread( DelayedScreenObstacle, animationData )
		end
	end

	wait( data.TextDelay or 2.2)
	if ambienceId ~= nil then
		StopSound({ Id = ambienceId, Duration = 15.8 })
	end

	local promptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX , Y = ScreenCenterY + 260, Group = "Overlay" })
	local promptId2 = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX , Y = ScreenCenterY + 260, Group = "Overlay" })
	CreateTextBox({	Id = promptId, Text = text, Justification = "CENTER",
			ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			Font = "SpectralSCLightTitling", FontSize = "86", Color = data.TextColor1 or {0.729,0.702,0.631,255},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			})
	ModifyTextBox({ Id = promptId, ScaleTarget = 1.2, ScaleDuration = 70 })

	if not args.SkipSound then
		PlaySound({ Name = "/Leftovers/World Sounds/MapText", Id = promptId })
	end

	if text2 ~= nil then
		wait(data.FadeOutWait2 or 5)
		ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.8, ColorTarget = {1,0,0,1}, ColorDuration=0.5 })
		local fadeSoundId = PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade", Id = promptId })
		SetVolume({ Id = fadeSoundId, Value = 0.3 })

		wait(0.9)
		DestroyTextBox({ Id = promptId })
		Destroy({ Id = promptId })

		wait(data.FadeInWait or 1.5)
		PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep", Id = promptId })

		CreateTextBox({	Id = promptId2, Text = text2, Justification = "CENTER",
			ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			Font = "SpectralSCLightTitling", FontSize = "86", Color = data.TextColor2 or {0.85,0.80,0.45,255},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			})
		ModifyTextBox({ Id = promptId2, ScaleTarget = 1.2, ScaleDuration = 70 })
	end

	wait(data.FadeOutWait or 5)

	ModifyTextBox({ Ids = { promptId, promptId2 }, FadeTarget = 0.0, FadeDuration = 1.0, ColorTarget = {1,0,0,1}, ColorDuration=0.5 })

	if not data.SkipFadeSound and not args.SkipSound then
		local fadeSoundId = PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade", Id = promptId })
		SetVolume({ Id = fadeSoundId, Value = 0.3 })
	end
	wait(1.0)
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 1 })
	wait(1.0)
	FadeOut({ Color = Color.Black, Duration = 1.0 })
	wait(2.2)
	DestroyTextBox({ Ids = { promptId, promptId2 } })
	Destroy({ Ids = { promptId, promptId2 } })
	Destroy({ Id = remBG })
	Destroy({ Id = hadesOverlay })
	Destroy({ Id = blackScreenId })
	Destroy({ Ids = ScreenAnchors.Epilogue })

	ResumeMusic()
	
	ToggleCombatControl({"AdvancedTooltip"}, true, "Interstitial" )
	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")
end

function DelayedScreenObstacle( animationData )
	wait(animationData.Delay)
	SetAnimation({ DestinationId = animationData.Id, Name = animationData.AnimationName })
	SetScale({ Id = animationData.Id, Fraction = animationData.Scale or 1.1 })

	if animationData.AlphaDuration ~= nil or animationData.StartAlpha ~= nil then
		SetAlpha({ Id = animationData.Id, Fraction = animationData.StartAlpha or 0.0, Duration = 0 })
		SetAlpha({ Id = animationData.Id, Fraction = animationData.EndAlpha or 1.0, Duration = animationData.AlphaDuration or 1.0 })
	end

	if animationData.StartColor ~= nil then
		SetColor({ Id = newObstacleId, Color = animationData.StartColor, Duration = 0 })
		SetColor({ Id = newObstacleId, Color = animationData.EndColor or Color.White, Duration = animationData.ColorDuration or 1, EaseIn = 0, EaseOut = 1 })
	end
end

function UpdateLockedKeyPresentation( obstacle )

	local cost = obstacle.UnlockCost or obstacle.KeyCost
	local resourceName = obstacle.ResourceName or "LockKeys"

	if cost == nil or cost <= 0 then
		return
	end

	if obstacle.TextAnchorId == nil then
		obstacle.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = obstacle.LockGroupName or "Standing", DestinationId = obstacle.ObjectId, OffsetZ = obstacle.LockOffsetZ })
	end

	local costColor = Color.CostAffordable
	if HasResource( resourceName, cost ) then
		obstacle.UseText = obstacle.UnlockUseText or obstacle.UseText
		SetAnimation({ Name = "LockedIconHasKey", DestinationId = obstacle.TextAnchorId })
	else
		obstacle.UseText = obstacle.LockedUseText or obstacle.UseText
		SetAnimation({ Name = "LockedIconNoKey", DestinationId = obstacle.TextAnchorId })
		costColor = Color.CostUnaffordable
	end

	local unlockCostText = "WeaponLockKeyRequirement"
	if ResourceData[resourceName] then
		unlockCostText = ResourceData[resourceName].RequirementText
	end
	CreateTextBox({ Id = obstacle.TextAnchorId, Text = unlockCostText,
		TextSymbolScale = 0.6,
		OffsetX = obstacle.LockKeyTextOffsetX, OffsetY = obstacle.LockKeyTextOffsetY or -75,
		LuaKey = "TempTextData", LuaValue = { Amount = cost },
		FontSize = 24,
		Color = costColor,
		Justification = "CENTER",
		Font="P22UndergroundSCMedium",
		FontSize=36,
		ShadowColor = {0,0,0,1},
		ShadowOffsetY=2,
		ShadowOffsetX=0,
		ShadowAlpha=1,
		ShadowBlur=0,
		OutlineColor={0,0,0,1},
		OutlineThickness=2,
	})
end

function DisplayInfoToast( source, args )

	AddInputBlock({ Name = "DisplayInfoToast" })

	local threadName = RoomThreadName
	wait( args.WaitTime or 0.5, threadName )

	local backgroundDimId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray", Scale = 4.0, ScaleX = ScreenScaleX, ScaleY = ScreenScaleY })
	SetColor({ Id = backgroundDimId, Color = Color.Black, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = backgroundDimId, Fraction = 0.8, Duration = 0.3 })

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 550, Y = 700, Group = "Combat_Menu_TraitTray" })
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
		Color = Color.White,
		Font="P22UndergroundSCHeavy",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 0,
		OffsetY = 120,
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
			Color = Color.LegendaryFormat,
			Font = "LatoSemiboldItalic",
			TextSymbolScale = 1,
			FontSize = 24,
			CharFadeTime = 0.02,
			CharFadeInterval = .002,
			CharFadeColor = Color.Orange,
			CharFadeColorLag = 0.25,
			Width = 400,
			OffsetX = 0,
			OffsetY = 170,
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

function FinalMetaUpgradePresentation( button, metaupgradeName )
	CurrentMetaUpgradeName = metaupgradeName

	if IsScreenOpen( "ShrineUpgrade" ) then
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle", Id = button.NextCostId })
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Id = button.NextCostId })
	end

	ModifyTextBox({ Id = button.NextCostId, Color = Color.Orange, ColorTarget = Color.Orange, ColorDuration = 0.3 })
	thread(PulseText, {Id = button.NextCostId, Color = Color.Orange, OriginalColor = Color.Gray, ScaleTarget = 1.5, ScaleDuration = 0.1, HoldDuration = 0.1 })

	if IsScreenOpen( "ShrineUpgrade" ) then
	else
		AdjustColorGrading({ Name = "Team03", Duration = 0.3 })
		AdjustFullscreenBloom({ Name = "Default", Duration = 0.3 })
		wait( 0.12 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.30 })
		AdjustColorGrading({ Name = "Off", Duration = 0.30 })
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

function MouseOverMetaIconTray( button )
	SetColor({ Id = button.Id, Color = Color.DimGray })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
	Flash({ Id = button.Id, Speed = 1.5, MinFraction = 0.7, MaxFraction = 0, Color = Color.White, ExpireAfterCycle = true })
end

function MouseOffMetaIconTray( button )
	SetColor({ Id = button.Id, Color = Color.Black })
end


function RunClearMessagePresentation( screen, messageData, args )

	if messageData == nil then
		return
	end

	args = args or {}
	local components = screen.Components

	wait( args.Delay or 1.0 )

	if args.Silent then
		ModifyTextBox({ Id = components.RunClearMessageText.Id, Text = messageData.Name, ScaleTarget = 1, ScaleDuration = 0.0 })
	else
		ModifyTextBox({ Id = components.RunClearMessageText.Id, Text = messageData.Name, ScaleTarget = 1, ScaleDuration = 0.25, EaseIn = 0, EaseOut = 1 })
		SetAlpha({ Id = components.RunClearMessageText.Id, Fraction = 0.0 })
		SetAlpha({ Id = components.RunClearMessageText.Id, Fraction = 1.0, Duration = 1.0, EaseIn = 0, EaseOut = 1 })
		PlaySound({ Name = messageData.DisplaySound or "/SFX/Menu Sounds/BiomeMapRewardIcon" })
	end
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

	local resourceNum = 1
	for i, resourceName in ipairs( ResourceDisplayOrderData ) do
		if resourceCostData[resourceName] then
			if not HasResource( resourceName, resourceCostData[resourceName] ) then
				local costDisplayNum = 1
				local backingKey = "ResourceIconBacking"..costDisplayNum..resourceNum
				local resourceIconBacking = screen.Components[backingKey]
				if resourceIconBacking ~= nil then
					Flash({ Id = resourceIconBacking.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
				end
			end
			resourceNum = resourceNum + 1
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
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
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
	if lootData.HasExchange and GetNumMetaUpgrades( "ReducedLootChoicesShrineUpgrade" ) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.UpgradeMenuOpenVoiceLines, true )
	else
		thread( PlayVoiceLines, lootData.UpgradeMenuOpenVoiceLines )
	end
end

function HUDTraitAddedPresentation( newTrait, args )
	if newTrait.Hidden or newTrait.HideInHUD then
		return
	end

	if ScreenState.TraitAddedPresentation then		
		table.insert( ScreenState.TraitAddedPresentationQueue, { NewTrait = newTrait, Args = args } )
		return
	end
	ScreenState.TraitAddedPresentation = true

	local tempDisplay = false
	if newTrait.AnchorId ~= nil then
		CreateAnimation({ Name = "NewTraitHighlight", DestinationId = newTrait.AnchorId })
	elseif HUDScreen ~= nil then
		tempDisplay = true
		wait( 0.5 )
		TraitUIAdd( newTrait, { Show = true, LocationX = ScreenData.HUD.ComponentData.TraitCount.X, LocationY = ScreenData.HUD.ComponentData.TraitCount.Y + 80, } )
		wait( 0.5 )
		CreateAnimation({ Name = "NewTraitHighlight", DestinationId = newTrait.AnchorId })
	end
	if HUDScreen ~= nil then
		wait( 0.6 )
		UpdateTraitSummary( { TextUpdateDelay = 0.5 } )
		wait( 1.0 )
		if tempDisplay then
			HUDHideTrait( newTrait )
		end
	end

	ScreenState.TraitAddedPresentation = false

	if not IsEmpty( ScreenState.TraitAddedPresentationQueue ) then
		local nextPresentation = RemoveFirstIndexValue( ScreenState.TraitAddedPresentationQueue )
		HUDTraitAddedPresentation( nextPresentation.NewTrait, nextPresentation.Args )
	end

end