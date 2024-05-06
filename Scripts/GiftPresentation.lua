function GetGiftIcon( entryName, index, args )
	args = args or {}
	local forceLocked = args.ForceLocked or false
	local giftIconData = GiftIconData.GiftPoints
	if GiftData[entryName][index] and GiftData[entryName][index].RequiredResource and GiftIconData[GiftData[entryName][index].RequiredResource] then
		giftIconData = GiftIconData[GiftData[entryName][index].RequiredResource]
	end

	local name = giftIconData.FilledWithGift
	if forceLocked then
		return giftIconData.Locked
	end
	local completelyUnlocked = IsGiftBarCompletelyUnlocked( entryName )

	if GameState.Gift[entryName].Value >= index then
		if GiftData[entryName][index] ~= nil and GiftData[entryName][index].Gift  ~= nil then
			name = giftIconData.FilledWithGift
		else
			name = giftIconData.Filled
		end
	else
		if completelyUnlocked or GameState.Gift[entryName].Value == index - 1 then
			if index < GetLockedLevel( entryName ) then
				if GiftData[entryName][index] ~= nil and GiftData[entryName][index].Gift ~= nil then
					name = giftIconData.EmptyWithGift
				else
					name = giftIconData.Empty
				end
			else
				if GiftData[entryName].UnlockGameStateRequirements then
					name = giftIconData.Locked
				else
					name = giftIconData.Unavailable
				end
			end
		else
			if GameState.Gift[entryName].Value == index - 2 then
				name = giftIconData.Mystery
			else
				name = "Blank"
			end
		end
	end
	return name
end

function GiftTrackUnlockedPresentation( entryName )

	local giftData = GiftData[entryName]
	if not giftData then
		return
	end

	local screen = ScreenData.Codex

	if giftData.TrackUnlockedBlockInput then
		AddInputBlock({ Name = "GiftTrackUnlockedPresentation" })
	end

	wait(0.5)
	SetAnimation({ Name = "AffinityGaugeBacking", DestinationId = backingId })

	local giftLength = giftData.Maximum
	local startY = -400
	local startX = giftLength * screen.SpacerX * -0.5
	for key, value in pairs( giftData ) do
		if type(value) == "table" and value.HeartDividerAfter then
			startX = startX - ( 50 + screen.SpacerX ) + screen.SpacerX * 0.5
			break
		end
	end
	local xPosition = startX
	local backingStartYOffset = -325

	local backingId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX , Y = ScreenCenterY + backingStartYOffset })
	SetAnimation({ Name = "AffinityGaugeBacking", DestinationId = backingId, Scale = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	local createdIds = CreateGiftTrack({ Name = entryName, LocationX = startX, LocationY = startY, IncludeDividers = true, GroupName = "Combat_Menu" })

	for i, id in pairs( createdIds ) do
		SetAlpha({ Id = id, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = id, Fraction = 1, Duration = 0.1 })
		xPosition = xPosition + screen.SpacerX
		if i >= giftData.Locked then
			SetAnimation({ Name = GetGiftIcon( entryName, i, { ForceLocked = true }), DestinationId = createdIds[i], Scale = 0.5, OffsetY = startY, OffsetX = xPosition })
		end
		if GiftData[entryName][i] and GiftData[entryName][i].HeartDividerAfter then
			xPosition = xPosition + 40 + screen.SpacerX
		end
	end

	xPosition = startX + ( giftData.Locked - 1 ) * screen.SpacerX
	for i = giftData.Locked, giftLength do
		wait(0.35)
		xPosition = xPosition + screen.SpacerX
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = createdIds[i], GroupName = "Overlay", OffsetX = xPosition, OffsetY = startY })
		SetAnimation({ Name = GetGiftIcon( entryName, i ), DestinationId = createdIds[i], Scale = 0.5, OffsetY = startY, OffsetX = xPosition})
		PlaySound({ Name = "/SFX/Menu Sounds/HeartSlotUnlock", Id = createdIds[i] })
		if GiftData[entryName][i] and GiftData[entryName][i].HeartDividerAfter then
			xPosition = xPosition + 40 + screen.SpacerX
		end
	end

	waitUnmodified(1)
	for i, id in pairs( createdIds ) do
		SetAlpha({ Ids = id, Fraction = 0, Duration = 0.33 })
	end
	SetAnimation({ Name = "AffinityGaugeBackingFade", DestinationId = backingId })
	waitUnmodified(0.33)
	Destroy({ Ids = createdIds })
	Destroy({ Id = backingId })
	if giftData.TrackUnlockedBlockInput then
		RemoveInputBlock({ Name = "GiftTrackUnlockedPresentation" })
	end
end

function ReceivedGiftPresentation( npc, giftAnimation )
	PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled" })
	if GetGiftLevel(npc.Name) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.GiftGivenVoiceLines, true )
	end
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = npc.ObjectId })
	SetAnimation({ Name = "MelTalkGifting01", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.30)
	thread( ReceivedGiftPresentationHearts, npc, giftAnimation )
	wait(0.20)
	SetAnimation({ Name = "MelTalkGifting01ReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId }) 
	wait(0.65)
end

function ReceivedGiftPresentationPost( npc )
	SetAnimation({ Name = "MelinoeSalute", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PopOverheadText, { TargetId = npc.ObjectId, Amount = 1, Text = "HeartAmount", Color = Color.White, OffsetY = -20, HoldDuration = 1.25 } )
	PlaySound({ Name = "/SFX/Menu Sounds/HeartGained", Id = npc.ObjectId })
end

function ReceivedGiftPresentationHearts( npc, giftAnimation )
	local giftOffsetZ = 100
	if npc.AnimOffsetZ ~= nil then
		giftOffsetZ = npc.AnimOffsetZ + 80
	end
	CreateAnimation({ DestinationId = npc.ObjectId, Name = giftAnimation, OffsetY = -giftOffsetZ })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection", Id = npc.ObjectId })
end

function PlayerReceivedGiftPresentation( npc, giftName )
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })

	thread( PlayVoiceLines, npc.GiftGivenVoiceLines, true )
	thread( PlayVoiceLines, CurrentRun.Hero.GiftReceivedVoiceLines, true )
	local npcName = npc.Name
	DisplayInfoBanner( nil, {
		TextOffsetY = -20,
		Icon = TraitData[giftName].Icon,
		IconScale = 1.0,
		IconMoveSpeed = 0.0001,
		IconOffsetY = 0,
		HighlightIcon = true,
		TitleText = "NewTraitUnlocked_Title",
		AnimationName = "LocationTextBGRelationship",
		AnimationOutName = "LocationTextBGRelationshipOut",
		SubtitleText = "NewTraitUnlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = npcName, Gift = giftName }},
	})

	thread( function()
		wait( 1.0 )
		AdjustColorGrading({ Name = "Off", Duration = 1.0, })
	end )

	if CheckObjectiveSet( "KeepsakePrompt" ) then
		UpdateAffordabilityStatus()
	end
end