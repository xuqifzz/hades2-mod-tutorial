function NarrativeInit()

	PlayingTextLines = false
	QueuedTextLines = QueuedTextLines or {}

end

function GetNarrativeDataValue( source, key )
	local narrativeData = NarrativeData[source.Name]
	if narrativeData == nil then
		return nil
	end
	return narrativeData[key]
end

function HasPlayedAnyTextLines( run, textLineSets )

	if textLineSets == nil then
		return
	end

	for textLinesName, textLines in pairs( textLineSets ) do
		if run.TextLinesRecord[textLinesName] then
			return true
		end
	end

	return false

end

function GetRandomEligibleTextLines( source, textLineSets, priorities, args )

	if textLineSets == nil then
		return nil
	end

	local eligibleConversations = {}
	local eligibleUnplayedConversations = {}
	local eligibleOneTimeConversations = {}
	local eligiblePlayFirstConversations = {}
	
	args = args or {}

	for conversationName, conversationData in pairs( textLineSets ) do

		args.PartnerName = conversationData.Partner	
		local eligibilityConversationData = CheckPartnerConversationData( conversationData )

		if IsTextLineEligible( CurrentRun, source, eligibilityConversationData, nil, nil, args ) then
			eligibleConversations[conversationData.Name] = true
			if not GameState.PlayedRandomTextLines[conversationData.Name] then
				table.insert( eligibleUnplayedConversations, conversationData )
				if conversationData.PlayFirst and not GameState.TextLinesRecord[conversationData.Name] then
					table.insert( eligiblePlayFirstConversations, conversationData )
				end
			end
			if conversationData.PlayOnce then
				table.insert( eligibleOneTimeConversations, conversationData )
			end
		end

	end

	if priorities ~= nil then
		for k, priority in ipairs( priorities ) do
			if type(priority) == "table" then
				local eligiblePriorityConversations = {}
				for j, conversationName in ipairs( priority ) do
					if eligibleConversations[conversationName] then
						table.insert( eligiblePriorityConversations, conversationName )
					end
				end
				if not IsEmpty( eligiblePriorityConversations ) then
					local randomPriorityConversation = GetRandomValue( eligiblePriorityConversations )
					DebugPrint({ Text = "Random Priority Conversation: "..randomPriorityConversation })
					return textLineSets[randomPriorityConversation]
				end
			elseif eligibleConversations[priority] then
				DebugPrint({ Text = "Priority Conversation: "..priority })
				return textLineSets[priority]
			end
		end
	else
		DebugPrint({ Text = "Missing TextLinePriorities for "..source.Name })
	end

	if not IsEmpty( eligibleOneTimeConversations ) then
		return GetRandomValue( eligibleOneTimeConversations )
	end

	if source.RepeatableTextLinesPlayChance ~= nil and not RandomChance( source.RepeatableTextLinesPlayChance ) then
		return nil
	end

	local randomConversation = nil
	if IsEmpty( eligibleUnplayedConversations ) then
		-- All lines played, start the record over
		for conversationName, conversationData in pairs( textLineSets ) do
			GameState.PlayedRandomTextLines[conversationName] = nil
		end
		local randomConversationName = GetRandomKey( eligibleConversations )
		randomConversation = textLineSets[randomConversationName]
	else
		if not IsEmpty( eligiblePlayFirstConversations ) then
			randomConversation = GetRandomValue( eligiblePlayFirstConversations )
		else
			randomConversation = GetRandomValue( eligibleUnplayedConversations )
		end
	end
	if randomConversation ~= nil then
		GameState.PlayedRandomTextLines[randomConversation.Name] = true
	end
	return randomConversation

end

function CheckPartnerConversationData( textLines )
	if textLines.Partner ~= nil and textLines[1] == nil then
		-- Actual data is on Partner
		local partnerData = EnemyData[textLines.Partner]
		textLines = partnerData.InteractTextLineSets[textLines.Name]
	end
	return textLines
end

function CheckPartnerConversations( unit, textLines )

	if unit.NextInteractLines == nil then
		return false
	end

	for partnerId, partnerUnit in pairs( ActiveEnemies ) do
		if partnerUnit.Name == unit.NextInteractLines.Partner then
			local allTextLineSets = partnerUnit.InteractTextLineSets
			for partnerTextLinesName, partnerTextLines in pairs( allTextLineSets  ) do
				-- Partner conversation overrides any other conversation chosen
				if partnerTextLinesName == unit.NextInteractLines.Name then
					SetNextInteractLines( partnerUnit, partnerTextLines )
					OnPartnerConversationSet( unit, partnerUnit )
					return true
				end
			end
		end
	end

	return false
end

function OnPartnerConversationSet( unit, partnerUnit )
	if unit.NextInteractLines.UseText ~= nil then
		partnerUnit.UseText = unit.NextInteractLines.UseText
	end
	if unit.NextInteractLines.BlockDistanceTriggers ~= nil then
		partnerUnit.NextInteractLines.BlockDistanceTriggers = unit.NextInteractLines.BlockDistanceTriggers
	end
	partnerUnit.CanReceiveGift = false
	unit.CanReceiveGift = false
	partnerUnit.InPartnerConversation = true
	unit.InPartnerConversation = true
end

function GetTextLinesUseableStatus( source, textLineSets )
	if textLineSets == nil then
		return false
	end

	local useable = true
	local conversationAvailable = false
	for k, textLineSet in pairs( textLineSets ) do
		if CurrentRun.TextLinesRecord[textLineSet.Name] then
			-- Conversation completed
			if textLineSet.UseableOffSource then
				useable = false
			end
		elseif IsTextLineEligible( CurrentRun, source, textLineSet ) then
			-- Conversation available
			conversationAvailable = true
		end
	end
	return conversationAvailable and useable
end

function NeedsUseableOff( source )

	-- Already had a UseableOff conversation

	if source.GiftTextLineSets ~= nil then
		for k, textLineSet in pairs( source.GiftTextLineSets ) do
			if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.UseableOffSource then
				return true
			end
		end
	end

	if source.InteractTextLineSets ~= nil then
		for k, textLineSet in pairs( source.InteractTextLineSets ) do
			if textLineSet.UseableOffSource then
				if source.SplitHubUseableOffSource and CurrentHubRoom ~= nil then
					if CurrentRun.HubTextLinesRecord[textLineSet.Name] then
						return true
					end
				else
					if CurrentRun.TextLinesRecord[textLineSet.Name] then
						return true
					end
				end
			end
			if textLineSet.RoomUseableOffSource and CurrentRun.CurrentRoom.TextLinesRecord[textLineSet.Name] then
				return true
			end
		end
	end

	return false

end

function PlayTextLines( source, textLines, args )

	if textLines == nil then
		return
	end

	args = args or {}
	if not args.IgnoreRequirements and not IsTextLineEligible( CurrentRun, source, textLines, nil, nil, args ) then
		-- First check requirements of the whole set
		return
	end

	if PlayingTextLines then
		table.insert( QueuedTextLines, textLines )
		return
	end

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		waitUntil( "EditingModeOff" )
	end

	local playedSomething = false
	local parentLine = textLines

	HideCombatUI( "PlayTextLines" )
	AddInputBlock({ Name = "PlayTextLines" })
	FreezePlayerUnit( "PlayTextLines", { DisableTray = false, StopRotation = false } )
	CurrentRun.Hero.UntargetableFlags.PlayTextLines = true
	SetPlayerInvulnerable( "PlayTextLines" )

	GameState.NPCInteractions[source.Name] = (GameState.NPCInteractions[source.Name] or 0) + 1
	CurrentRun.NPCInteractions[source.Name] = (CurrentRun.NPCInteractions[source.Name] or 0) + 1
	source.ConversationThisRun = true
	RecordMapState( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, source.ObjectId, "ConversationThisRun", source.ConversationThisRun )

	waitUnmodified( textLines.PreEventWait )
	if textLines.PreEventFunctionName ~= nil then
		CallFunctionName( textLines.PreEventFunctionName, source, textLines.PreEventFunctionArgs, textLines )
	end
	if source.PreEventFunctionName ~= nil then
		CallFunctionName( source.PreEventFunctionName, source, source.PreEventFunctionArgs, textLines )
	end
	if not textLines.SkipPresention then
		StartedTextLinesPresentation( source, textLines )
	end

	PlayingTextLines = true
	local screen = DeepCopyTable( ScreenData.Dialog )
	screen.Source = source
	screen.LastLineStartTime = _worldTime
	OverwriteTableKeys( screen, args.ScreenArgs )
	OnScreenOpened( screen )
	
	if PlayTextLine( screen, textLines, nil, nil, source ) then
		playedSomething = true
	end
	CallFunctionName( textLines.PrePortraitExitFunctionName, source, textLines.PrePortraitExitFunctionArgs, screen )

	local artExiting = false
	if screen.CurrentContextArt ~= nil then
		SetAnimation({ DestinationId = screen.ContextArtId, Name = screen.CurrentContextArt.."_Out" })
		artExiting = true
	end
	if screen.CurrentPortrait ~= nil then
		SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
		artExiting = true
	end
	if artExiting then
		waitUnmodified(0.1)
	end
	if artExiting then
		waitUnmodified(0.2)
	end
	Destroy({ Id = screen.ContextArtId })
	Destroy({ Id = screen.PortraitId })
	
	OnScreenCloseStarted( screen )
	OnScreenCloseFinished( screen )
	FinishedTextLinesPresentation( source, textLines )
	if not source.TextLinesIgnoreQuests then
		thread( CheckQuestStatus )
	end
	AltAspectRatioFramesHide()
	RemoveInputBlock({ Name = "PlayTextLines" })
	UnfreezePlayerUnit( "PlayTextLines" )
	SetPlayerVulnerable( "PlayTextLines" )
	CurrentRun.Hero.UntargetableFlags.PlayTextLines = nil
	PlayingTextLines = false

	if textLines.UseableOffSource or textLines.RoomUseableOffSource then
		source.NextInteractLines = nil
		AddInteractBlock( source, "SetAvailableUseText" ) -- Will get unblocked by SetAvailableUseText() if needed
		StopStatusAnimation( source, StatusAnimations.WantsToTalk )
	end

	if textLines.RoomRequiredInteractionFalse then
		MapState.RoomRequiredObjects[source.ObjectId] = nil
	end

	if textLines.CompleteObjective then
		thread(MarkObjectiveComplete, textLines.CompleteObjective)
	end

	ShowCombatUI( "PlayTextLines" )

	waitUnmodified( textLines.EndWait )

	args.ElapsedTime = _worldTime - screen.LastLineStartTime
	DebugPrint({ Text = "args.ElapsedTime = "..args.ElapsedTime })

	if textLines.EndCue ~= nil and (textLines.EndCueCooldownName == nil or CheckCooldown( textLines.EndCueCooldownName, textLines.EndCueCooldownTime ) ) then
		-- These EndCue lines should not repeat per run
		if not CurrentRun.SpeechRecord[textLines.EndCue] then
			-- EndCue always plays from the player
			local source = CurrentRun.Hero
			if textLines.EndCueSourceName ~= nil then
				local typeIds = GetIdsByType({ Name = textLines.EndCueSourceName })
				local objectId = typeIds[1]
				source = ActiveEnemies[objectId]
				if source == nil then
					source = {}
					source.ObjectId = objectId
				end
			end
			thread( PlayVoiceLines, { Cue = textLines.EndCue }, nil, source, args )
		end
	end
	if textLines.EndVoiceLines ~= nil then
		thread( PlayVoiceLines, textLines.EndVoiceLines, nil, source, args )
	end
	if textLines.EndGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[textLines.EndGlobalVoiceLines], nil, source, args )
	end
	CallFunctionName( textLines.EndFunctionName, source, textLines.EndFunctionArgs )
	if source.TextLinesEndEvents ~= nil then
		RunEventsGeneric( source.TextLinesEndEvents, source, args )
	end

	if not IsEmpty( QueuedTextLines ) then
		local nextTextLines = RemoveFirstValue( QueuedTextLines )
		if PlayTextLines( source, nextTextLines ) then
			playedSomething = true
		end
	end

	return playedSomething
end

function PlayTextLine( screen, textLines, prevLine, parentLine, source, args )

	DebugAssert({ Condition = textLines.Name ~= nil, Text = "TextLines being played without a name!" })
	if textLines.Name ~= nil then
		GameState.TextLinesRecord[textLines.Name] = true
		CurrentRun.TextLinesRecord[textLines.Name] = true
		if CurrentHubRoom ~= nil then
			CurrentRun.HubTextLinesRecord[textLines.Name] = true
		elseif CurrentRun.CurrentRoom ~= nil then
			CurrentRun.CurrentRoom.TextLinesRecord[textLines.Name] = true
		end
		if textLines.PlayOnce then
			GameState.LastPlayOnceTextLinesGamePhaseTicksRecord[source.Name] = GameState.GamePhaseLifetimeTicks
		end
	end

	local playedSomething = false

	--[[
	HotLoadInfo.CurrentTextLines = textLines
	local lineIndex = 0
	while HotLoadInfo ~= nil and HotLoadInfo.CurrentTextLines ~= nil do
	]]
	for lineIndex, line in ipairs( textLines ) do

		--[[
		lineIndex = lineIndex + 1
		local line = HotLoadInfo.CurrentTextLines[lineIndex]
		if line == nil then
			break
		end
		--]]

		local prevLine = nil
		if lineIndex >= 2 then
			prevLine = textLines[lineIndex - 1]
		end
		if IsTextLineEligible( CurrentRun, source, line, prevLine, parentLine ) then
			local playLine = line
			if line.SecretMusic ~= nil then
				SecretMusicPlayer( line.SecretMusic )
			end
			if line.SecretMusicSection ~= nil then
				SetSoundCueValue({ Names = { "Section", }, Id = AudioState.SecretMusicId, Value = line.SecretMusicSection })
			end
			if line.SecretMusicActiveStems ~= nil then
				SetSoundCueValue({ Names = line.SecretMusicActiveStems, Id = AudioState.SecretMusicId, Value = 1, Duration = line.SecretMusicActiveStemsDuration or 1 })
			end
			if line.SecretMusicMutedStems ~= nil then
				SetSoundCueValue({ Names = line.SecretMusicMutedStems, Id = AudioState.SecretMusicId, Value = 0, Duration = line.SecretMusicMutedStemsDuration or 1 })
			end
			if line.MusicSection ~= nil then
				SetSoundCueValue({ Names = { "Section", }, Id = AudioState.MusicId, Value = line.MusicSection })
			end
			if line.MusicActiveStems ~= nil then
				SetSoundCueValue({ Names = line.MusicActiveStems, Id = AudioState.MusicId, Value = 1, Duration = line.MusicActiveStemsDuration or 1 })
			end
			if line.MusicMutedStems ~= nil then
				SetSoundCueValue({ Names = line.MusicMutedStems, Id = AudioState.MusicId, Value = 0, Duration = line.MusicMutedStemsDuration or 1 })
			end
			if line.StartSound ~= nil then
				PlaySound({ Name = line.StartSound })
			end
			if CurrentRun.Hero ~= nil then
				if line.TeleportHeroToId ~= nil then
					Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = line.TeleportHeroToId, OffsetX = line.TeleportHeroOffsetX, OffsetY = line.TeleportHeroOffsetY, })
				end
				if line.AngleHeroTowardTargetId ~= nil then
					AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = line.AngleHeroTowardTargetId })
				end
			end
			if source ~= nil then
				if line.TeleportToId ~= nil then
					Teleport({ Id = line.TeleportId or source.ObjectId, DestinationId = line.TeleportToId, OffsetX = line.TeleportOffsetX, OffsetY = line.TeleportOffsetY, })
					source.ActiveNarrativeTeleportId = line.TeleportToId
				end
				if line.TeleportWithId ~= nil then
					Teleport({ Id = line.TeleportWithId, DestinationId = line.TeleportToId })
					Teleport({ Id = source.ObjectId, DestinationId = line.TeleportToId, OffsetX = line.TeleportOffsetX, OffsetY = line.TeleportOffsetY, })
				end
				if line.AngleTowardTargetId ~= nil then
					AngleTowardTarget({ Id = line.AngleId or source.ObjectId, DestinationId = line.AngleTowardTargetId })
				end
				if line.AngleTowardHero ~= nil then
					AngleTowardTarget({ Id = line.AngleId or source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end
			if line.RandomRemaining then
				parentLine = line
				local eligibleUnplayedLines = {}
				local allEligibleLines = {}
				for k, subLine in ipairs( line ) do
					if IsTextLineEligible( CurrentRun, source, subLine, prevLine, line ) then
						table.insert( allEligibleLines, subLine )
						if not GameState.PlayedRandomTextLines[subLine.Text] then
							table.insert( eligibleUnplayedLines, subLine )
						end
					end
				end
				if not IsEmpty( allEligibleLines ) then
					if IsEmpty( eligibleUnplayedLines ) then
						-- All lines played, start the record over
						for k, subLine in ipairs( line ) do
							GameState.PlayedRandomTextLines[subLine.Text] = nil
						end
						playLine = GetRandomValue( allEligibleLines )
					else
						playLine = GetRandomValue( eligibleUnplayedLines )
					end
					GameState.PlayedRandomTextLines[playLine.Text] = true
				end
			end

			waitUnmodified( line.InterSceneWaitTime )

			if playLine.Text ~= nil then

				waitUnmodified( 0.1 )
				StopStatusAnimation( source, source.StatusAnimation or textLines.StatusAnimation or StatusAnimations.WantsToTalk )

				if playLine.PreLineThreadedFunctionName ~= nil then
					thread( CallFunctionName, playLine.PreLineThreadedFunctionName, source, playLine.PreLineThreadedFunctionArgs, screen, line )
				end
				if playLine.PreLineFunctionName ~= nil then
					CallFunctionName( playLine.PreLineFunctionName, source, playLine.PreLineFunctionArgs, playLine )
				end
				if playLine.PreLineAnim ~= nil then
					local targetId = playLine.PreLineAnimTarget or source.ObjectId
					if playLine.PreLineAnimTarget == "Hero" then
						targetId = CurrentRun.Hero.ObjectId
					end
					SetAnimation({ Name = playLine.PreLineAnim, DestinationId = targetId })
				end

				waitUnmodified( playLine.PreLineWait )

				local played = DisplayTextLine( screen, source, playLine, textLines, textLines[lineIndex + 1] )
				if played then
					playedSomething = true
					-- Intentionally leaving this on raw data for now to be wiped out on load
					playLine.LastPlayTime = _worldTime

					waitUnmodified( playLine.PostLineWait or 0.1 )

					if playLine.BreakIfPlayed or (parentLine ~= nil and parentLine.BreakIfPlayed) then
						break
					end
					if playLine.PostLineAnim ~= nil then
						local targetId = playLine.PostLineAnimTarget or source.ObjectId
						if playLine.PostLineAnimTarget == "Hero" then
							targetId = CurrentRun.Hero.ObjectId
						end
						SetAnimation({ Name = playLine.PostLineAnim, DestinationId = targetId })
					end
				end
				if playLine.TriggerCooldowns ~= nil then
					for k, cooldownName in pairs( playLine.TriggerCooldowns ) do
						TriggerCooldown( cooldownName )
					end
				end
				if playLine.EndSound ~= nil then
					PlaySound({ Name = playLine.EndSound })
				end
			end

			if playLine.PostLineFunctionName ~= nil then
				CallFunctionName( playLine.PostLineFunctionName, source, playLine.PostLineFunctionArgs, textLines, screen )
			end
			if playLine.PostLineThreadedFunctionName ~= nil then
				thread( CallFunctionName, playLine.PostLineThreadedFunctionName, source, playLine.PostLineThreadedFunctionArgs or playLine.PostLineFunctionArgs, textLines, screen )
			end
			if playLine.PostLineGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[playLine.PostLineGlobalVoiceLines], nil, source, args )
			end

		end
	end

	return playedSomething

end

function IsTextLineEligible( currentRun, source, line, prevLine, parentLine, args )

	if line == nil then
		return false
	end

	args = args or {}

	if args.RequirePartner and line.Partner == nil then
		return false
	end
	if args.RequireNoPartner and line.Partner ~= nil then
		return false
	end

	if line.Force then
		return true
	end

	if line.Partner ~= nil and not args.IgnorePartnerExists then
		local typeIds = GetIdsByType({ Name = args.PartnerName or line.Partner })
		if IsEmpty( typeIds ) then
			args.FirstFailedRequirement = "Partner doesn't exist"
			return false
		end
		for k, typeId in pairs( typeIds ) do
			local partner = ActiveEnemies[typeId]
			if partner == nil then
				args.FirstFailedRequirement = "Partner doesn't exist"
				return false
			end
			if partner.NextInteractLines ~= nil and partner.NextInteractLines.PlayOnce and partner.NextInteractLines.Name ~= line.Name then
				args.FirstFailedRequirement = "Partner is already busy with a non-repeatable conversation"
				return false
			end
		end
	end

	if line.Name ~= nil then
		if line.PlayOnce or ( parentLine ~= nil and parentLine.PlayOnce ) then
			if GameState.TextLinesRecord[line.Name] then
				args.FirstFailedRequirement = "PlayOnce"
				return false
			end
		end
		if line.PlayOnceThisRun or ( parentLine ~= nil and parentLine.PlayOnceThisRun ) then
			if currentRun.TextLinesRecord[line.Name] then
				args.FirstFailedRequirement = "PlayOnceThisRun"
				return false
			end
		end
	end

	if args.Spending ~= nil then
		for spendingName, spendingAmount in pairs( args.Spending ) do
			if line.Cost == nil or ( (line.Cost[spendingName] or 0) < spendingAmount ) then
				-- Cannot be bought with this spending
				args.FirstFailedRequirement = "Not using resource: "..spendingAmount.." "..spendingName.." (Spending: "..spendingAmount..")"
				--DebugPrint({ Text = args.FirstFailedRequirement })
				return false
			end
		end
	elseif line.Cost ~= nil and not args.IgnoreCost then
		for resourceName, resourceAmount in pairs( line.Cost ) do
			if not HasResource( resourceName, resourceAmount ) then
				args.FirstFailedRequirement = "Missing resource: "..resourceAmount.." "..resourceName.." (Current: "..tostring(GameState.Resources[resourceName])..")"
				return false
			end
		end
	end

	--if line.GameStateRequirements ~= nil and not IsGameStateEligible( currentRun, line, line.GameStateRequirements, args ) then -- Decide on preferred source
	if line.GameStateRequirements ~= nil and not IsGameStateEligible( currentRun, source, line.GameStateRequirements, args ) then
		return false
	end

	return true

end

function DisplayTextLine( screen, source, line, parentLine, nextLine )

	local rawText = line.Text
	local text = nil

	-- Look up the text line without the '/VO/' prefix
	if line.Cue then
		local helpTextId = line.Cue
		if line.Cue ~= "/EmptyCue" then
			helpTextId = string.sub( line.Cue, 5 )
		end
		rawText = nil
		text = helpTextId
		if not HasDisplayName({ Text = helpTextId }) then
			rawText = line.Text
			text = nil
		end
	end

	screen.LastLineStartTime = _worldTime

	local cue = line.Cue

	if line.Source ~= nil then
		source = EnemyData[line.Source] or LootData[line.Source] or ConsumableData[line.Source]
	elseif line.UsePlayerSource then
		source = CurrentRun.Hero
	end

	local speakerName = line.SpeakerNameplateId or line.Speaker or source.Speaker or source.Name
	table.insert( CurrentRun.LineHistory, { SpeakerName = source.LineHistoryName or speakerName, SourceName = source.Name, Text = text, RawText = rawText, SubtitleColor = source.NarrativeFadeInColor or source.SubtitleColor } )

	local portrait = line.Portrait or source.Portrait	
	local speakerLabelOffsetY = line.SpeakerLabelOffsetY or source.SpeakerLabelOffsetY or 5

	for id, v in pairs( AudioState.ActiveSpeechIds ) do
		StopSound({ Id = id, Duration = 0.15 })
	end

	StopStatusAnimation( source, StatusAnimations.WantsToTalk )

	local anchorId = nil
	local textColor = nil
	local narrationTextOffsetX = 0
	local narrationTextOffsetY = 0
	local narrationBoxOffsetX = 0
	local exitAnimation = nil
	local textShadowColor = {0.890, 0.871, 0.851, 1.0}

	local speechSource = source

	if portrait ~= nil and not line.SkipPortrait then
		-- Dialogue with portrait
		if screen.ContextArtId == nil then
			screen.ContextArtId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
		end
		if screen.PortraitId == nil then
			screen.PortraitId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 490, Y = ScreenCenterY + 105, Group = "Combat_Menu" })
		end
		AltAspectRatioFramesShow()
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= portrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			waitUnmodified( line.PortraitExitWait or 0.3 )
		end
		if screen.CurrentContextArt == nil and not line.SkipContextArt and not parentLine.SkipContextArt and not source.SkipContextArt then
			local currentRoom = (CurrentHubRoom or CurrentRun.CurrentRoom)
			local roomData = RoomData[currentRoom.Name] or HubRoomData[currentRoom.Name]
			local contextArt = line.NarrativeContextArt or source.NarrativeContextArt or roomData.NarrativeContextArt
			local contextArtFlippable = roomData.NarrativeContextArtFlippable or source.NarrativeContextArtFlippable
			if contextArt ~= nil then
				screen.CurrentContextArt = contextArt
				SetAnimation({ DestinationId = screen.ContextArtId, Name = screen.CurrentContextArt.."_In" })
				if( RandomChance(0.5) and contextArtFlippable and not parentLine.DoNotFlipContextArt ) then
					FlipHorizontal({ Id = screen.ContextArtId })
				end
			end
		end
		if screen.ContextArtId ~= nil and line.NarrativeContextArt ~= nil then
			screen.CurrentContextArt = line.NarrativeContextArt
			SetAnimation({ DestinationId = screen.ContextArtId, Name = screen.CurrentContextArt.."_In" })
		end
		local prevPortrait = screen.CurrentPortrait
		screen.CurrentPortrait = portrait
		SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
		if source.OnPortraitSetFunctionName ~= nil then
			CallFunctionName( source.OnPortraitSetFunctionName, source, source.OnPortraitSetFunctionArgs, screen, line )
		end
		speechSource = { Name = source.Name, ObjectId = screen.PortraitId }
		narrationBoxOffsetX = 198
		if screen.DialogueGlowBackgroundId == nil then
			screen.DialogueGlowBackgroundId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 200, Y = ScreenCenterY + 300, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = screen.DialogueGlowBackgroundId, Name = "DialogueSpeechBubbleBackgroundGlow" })
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 0 })
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 1, Duration = 0.25  })
		end
		if source.PortraitEnterSound ~= nil then
			if not screen.PlayedPortraitEnterSounds[source.PortraitEnterSound] then
				PlaySound({ Name = source.PortraitEnterSound })
				screen.PlayedPortraitEnterSounds[source.PortraitEnterSound] = true
			end
		end

	end

	if line.PreContentSound ~= nil then
		PlaySound({ Name = line.PreContentSound })
	end
	if line.Emote ~= nil and screen.PortraitId ~= nil then
		CreateAnimation({ Name = line.Emote, DestinationId = screen.PortraitId, OffsetX = source.EmoteOffsetX, OffsetY = source.EmoteOffsetY })
	end

	local speakerNameId = nil
	local promptOffsetY = 425

	if portrait ~= nil and not (line.IsNarration or parentLine.IsNarration) then
		-- Speech bubble
		if screen.BackgroundId == nil then
			local boxAnimation = line.BoxAnimation or source.BoxAnimation or "DialogueSpeechBubble"
			screen.BackgroundId = CreateScreenObstacle({ Name = boxAnimation, X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX), Y = ScreenCenterY + (line.BoxOffsetY or 264), Group = "Combat_Menu" })
		end
		exitAnimation = line.BoxExitAnimation or source.BoxExitAnimation or "DialogueSpeechBubbleOut"
		textColor = line.TextColor or source.NarrativeTextColor or Color.DialogueText

		if line.Append then
			Destroy({ Ids = { screen.NameplateId, screen.NameplateDescriptionId } })
			screen.NameplateId = nil
			screen.NameplateDescriptionId = nil
		end

		if screen.NameplateId == nil then
			screen.NameplateId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 12, Y = ScreenCenterY + 103, Group = "Combat_Menu" })
		end
		if screen.NameplateDescriptionId == nil then
			screen.NameplateDescriptionId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 8, Y = ScreenCenterY + 146, Group = "Combat_Menu" })
		end

		CreateTextBox(MergeTables({
			Id = screen.NameplateId,
			Text = speakerName,
			FontSize = 32,
			OffsetY = speakerLabelOffsetY + GetLocalizedValue( 0, LocalizationData.Narrative.SpeakerDisplayName.LangOffsetY ),
			Font = "CaesarDressing",
			Color = source.NameplateSpeakerNameColor or Color.DialogueSpeakerName,
			ShadowBlur = 1, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "CENTER",
		}, LocalizationData.Narrative.SpeakerDisplayName ))

		CreateTextBox(MergeTables({
			Id = screen.NameplateDescriptionId,
			Text = speakerName,
			FontSize = 22,
			OffsetY = 3 + GetLocalizedValue( 0, LocalizationData.Narrative.SpeakerDescription.LangOffsetY ),
			Font = "P22UndergroundSCMedium",
			Color = source.NameplateDescriptionColor or {120, 220, 180, 192},
			UseDescription = true,
		}, LocalizationData.Narrative.SpeakerDescription ))

	else
		-- Narration
		if screen.BackgroundId == nil then
			screen.BackgroundId = CreateScreenObstacle({ Name = "NarrationBubble", X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX), Y = ScreenCenterY + (line.BoxOffsetY or 304), Group = "Combat_Menu" })
		end
		if line.BoxAnimation ~= nil then
			SetAnimation({ Name = line.BoxAnimation, DestinationId = screen.BackgroundId })
		end
		exitAnimation = line.BoxExitAnimation or "NarrationBubbleOut"
		textColor = Color.NarrationText
		textShadowColor = {0,0,0, 1.0}
		narrationTextOffsetX = 0
		narrationTextOffsetY = 15
		promptOffsetY = 440
	end

	if line.Append then
		ModifyTextBox({
			Id = screen.BackgroundId,
			Text = text,
			RawText = rawText,
			Append = true,
		})
	else
		local fadeInSource = source
		local fadeInColor = source.NarrativeFadeInColor or source.SubtitleColor
		if line.Speaker ~= nil then
			fadeInSource = EnemyData[line.Speaker] or HeroData
		end
		if not fadeInColor then
			fadeInSource = fadeInSource.NarrativeFadeInColor or fadeInSource.SubtitleColor or { -255, -255, -255, -255 }
		end
		if fadeInColor == nil then
			fadeInColor = { -255, -255, -255, -255 }
		end
		local fadeInProperties =
		{
			CharacterFadeTime = 0.0125,
			CharacterFadeInterval = 0.001,
			CharacterFadeColorLag = 0.055,
			CharacterFadeRed = fadeInColor[1] / 255,
			CharacterFadeGreen = fadeInColor[2] / 255,
			CharacterFadeBlue = fadeInColor[3] / 255,
		}
		if fadeInSource.DisableCharacterFadeColorLag then
			fadeInProperties = 
			{
				CharacterFadeTime = 0.0125,
				CharacterFadeInterval = 0.001,
			}
		end
		CreateTextBox(MergeTables({
			Id = screen.BackgroundId,
			Text = text,
			RawText = rawText,
			Width = line.TextWidth or 833,
			OffsetX = line.TextOffsetX or (-397 + narrationTextOffsetX),
			OffsetY = line.TextOffsetY or (45 + narrationTextOffsetY),
			Font = "LatoSemibold",
			FontSize = line.FontSize or 24,
			Justification = "LEFT",
			VerticalJustification = line.VerticalJustification or "CENTER",
			Color = line.TextColor or textColor,
			LineSpacingBottom = 4,
			ShadowColor = textShadowColor,
			ShadowBlur = 0,
			ShadowOffsetX = 0,
			ShadowOffsetY = 4,
			DataProperties = fadeInProperties,
		}, LocalizationData.Narrative.DialogueText ))
	end

	local anchorIds = { screen.BackgroundId, screen.NameplateId, screen.NameplateDescriptionId }
	Destroy({ Id = screen.PromptId })
	screen.PromptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 390 + narrationBoxOffsetX, Y = ScreenCenterY + promptOffsetY, Group = "Combat_Menu" })
	table.insert( anchorIds, screen.PromptId )

	ModifySubtitles({ SuppressLyrics = true })

	local speechId = PlaySpeechCue( cue, nil, nil, "Interrupt", false )
	if source.SpeakingAnimation ~= nil and line.Portrait == nil and speechId ~= nil and speechId > 0 then
		SetAnimation({ DestinationId = screen.PortraitId, Name = source.SpeakingAnimation, SoundId = speechId })
		thread( CancelSpeakingAnimation, screen, source, cue )
	end
	if not line.AutoAdvance and not GetConfigOptionValue({ Name = "AutoAdvanceNarration" }) then
		thread( ShowContinueArrow, screen, source, cue )
	end

	waitUnmodified(0.01)

	local selectedChoice = nil
	local choiceMap = {}
	local choiceBackground = nil

	if line.Choices ~= nil then

		DestroyTextBox({ Ids = { screen.BackgroundId, screen.NameplateId, screen.NameplateDescriptionId } })

		choiceBackground = CreateScreenObstacle({ Name = "DialogueChoiceBubble", X = ScreenCenterX + narrationBoxOffsetX + 8, Y = ScreenCenterY + 280, Group = "Combat_Menu" })

		CreateTextBox(MergeTables({
			Id = choiceBackground,
			Text = rawText,
			Width = localizedWidthOverride,
			OffsetX = -425,
			OffsetY = -120,
			Font = "LatoBold",
			FontSize = 22,
			Justification = "LEFT",
			VerticalJustification = "CENTER",
			Color = Color.White,
		}, LocalizationData.Narrative.ChoiceBackground ))

		SetAlpha({ Id = screen.BackgroundId, Fraction = 0 })
		local choiceLocationX = ScreenCenterX - 200
		local choiceLocationY = 820
		local firstChoice = false

		local choices = nil
		if line.Choices.RandomSelections ~= nil then
			choices = {}
			local availableChoices = {}
			for k, choice in ipairs( line.Choices ) do
				--DebugPrint({ Text = "Choice: "..k })
				if choice.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, choice.GameStateRequirements ) then
					table.insert( availableChoices, choice )
				else
					--DebugPrint({ Text = "Failed choice: "..k })
				end
			end
			RandomSynchronize( 17 )
			for i = 1, line.Choices.RandomSelections do
				local randomChoice = RemoveRandomValue( availableChoices )
				table.insert( choices, randomChoice )
			end
		else
			choices = line.Choices
		end

		for k, choice in ipairs( choices ) do
			if IsTextLineEligible( CurrentRun, source, choice, line, line ) then
				local choiceButtonId = CreateScreenObstacle({ Name = "ButtonDialogueChoice", X = choiceLocationX, Y = choiceLocationY, Group = "Combat_Menu" })
				local data = {}
				for i, value in ipairs( choice ) do
					if value.PostLineFunctionArgs and value.PostLineFunctionArgs.TraitName then
						data = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = value.PostLineFunctionArgs.TraitName })
						ExtractValues( CurrentRun.Hero, data, data )
					else
						data = value
					end
				end
				local color = Color.Green
				if choice.Disabled then
					UseableOff({ Id = choiceButtonId })
					color = Color.Red
				end
				--DebugPrintTable( data, true )
				choiceMap[choiceButtonId] = choice
				table.insert( anchorIds, choiceButtonId )
				CreateTextBox( MergeTables({
					Id = choiceButtonId,
					Text = choice.ChoiceText,
					Color = color,
					Width = 1920,
					OffsetX = -10,
					OffsetY = -4,
					Font = "P22UndergroundSCHeavy",
					FontSize = 26,
					VariableAutoFormat = "ItalicFormatDark",
					TextSymbolScale = choice.TextSymbolScale,
					Justification = "LEFT",
					VerticalJustification = "CENTER",
					LuaKey = "TooltipData",
					LuaValue = data,
				}, LocalizationData.Narrative.ChoiceText ))
				--[[
				CreateTextBox({
					Id = choiceButtonId,
					Text = choice.ChoiceDescription,
					Color = Color.Black,
					Width = 755,
					OffsetX = -140,
					OffsetY = -4,
					Font = "P22UndergroundSCHeavy",
					FontSize = 28,
					Justification = "LEFT",
					VerticalJustification = "CENTER",
				})
				]]
				SetInteractProperty({ DestinationId = choiceButtonId, Property = "TooltipOffsetX", Value = 800})
				if not firstChoice then
					TeleportCursor({ OffsetX = choiceLocationX, OffsetY = choiceLocationY })
					firstChoice = true
				end
				choiceLocationY = choiceLocationY + 60
			end
		end

	end

	waitUnmodified(0.03)
	-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
	PauseSound({ Id = speechId, Duration = 0 })
	ResumeSound({ Id = speechId, Duration = 0 })
	waitUnmodified( line.InputDelay or 0.17) -- Minimum input advance delay

	local advanceControls = { "Confirm", "Select", "ContinueText", }
	
	ToggleCombatControl( advanceControls, true )

	if line.AutoAdvance or GetConfigOptionValue({ Name = "AutoAdvanceNarration" }) then
		thread( AutoAdvanceNarration, screen, source, cue )
	end

	local notifyName = nil
	if IsEmpty( choiceMap ) then
		notifyName = "NarrativeLineNextInput"
		NotifyOnControlPressed({ Names = advanceControls, Notify = notifyName })
		waitUntil( notifyName )
	else
		RemoveInputBlock({ Name = "PlayTextLines" })
		EnableGamepadCursor( screen.Name )
		notifyName = "NarrativeLineChoiceInput"
		NotifyOnInteract({ Ids = GetAllKeys( choiceMap ), Notify = notifyName })
		screen.AllowAdvancedTooltip = true
		--NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName })
		waitUntil( notifyName )
		screen.AllowAdvancedTooltip = false
		local selectedId = NotifyResultsTable[notifyName]
		selectedChoice = choiceMap[selectedId]
		AddInputBlock({ Name = "PlayTextLines" })
		DisableGamepadCursor( screen.Name )
	end
	ModifySubtitles({ SuppressLyrics = false })

	killTaggedThreads( NarrativeThreadName )
	killWaitUntilThreads( cue )

	if nextLine ~= nil and nextLine.Append then
		-- Do nothing
	else
		DestroyTextBox({ Ids = anchorIds })
		SetAnimation({ DestinationId = screen.BackgroundId, Name = exitAnimation })
		if line.PortraitExitAnimation ~= nil then
			SetAnimation({ DestinationId = screen.PortraitId, Name = line.PortraitExitAnimation })
			screen.CurrentPortrait = nil
		end
		if screen.CurrentContextArt ~= nil and ( line.PostLineRemoveContextArt or (nextLine ~= nil and nextLine.IsNarration) ) then
			SetAnimation({ DestinationId = screen.ContextArtId, Name = screen.CurrentContextArt.."_Out" })
			screen.CurrentContextArt = nil
		end
		if screen.DialogueGlowBackgroundId ~= nil then
			-- SetAnimation({ DestinationId = screen.DialogueGlowBackgroundId, Name = "DialogueSpeechBubbleBackgroundGlowFade" })
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 0, Duration = 0.12 })
			screen.DialogueGlowBackgroundId = nil
		end
	end

	waitUnmodified(0.12)
	if nextLine ~= nil and nextLine.Append then
		-- Do nothing
	else
		Destroy({ Ids = anchorIds })
		screen.BackgroundId = nil
		screen.NameplateId = nil
		screen.NameplateDescriptionId = nil
		if choiceBackground ~= nil then
			Destroy({ Id = choiceBackground })
		end
	end

	StopSound({ Id = speechId, Duration = 0.15 })

	if selectedChoice ~= nil then
		PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuClose" })
		selectedChoice.Name = parentLine.Name..selectedChoice.ChoiceText
		PlayTextLine( screen, selectedChoice, line, line, source )
	end

	return true

end

NarrativeThreadName = "NarrativeThreadName"

function PlayFirstEligibleTextLines( source, textLineSets )

	if textLineSets == nil then
		return
	end

	for textLinesName, textLines in pairs( textLineSets ) do
		local playedSomething = PlayTextLines( source, textLines )
		if playedSomething then
			return
		end
	end

end

function PlayRandomRemainingTextLines( source, textLineSets )

	if textLineSets == nil then
		return false
	end

	local eligibleUnplayedLines = {}
	local allEligibleLines = {}
	for textLinesName, textLines in pairs( textLineSets ) do
		if IsTextLineEligible( CurrentRun, source, textLines ) then
			table.insert( allEligibleLines, textLines )
			if not GameState.PlayedRandomTextLines[textLinesName] then
				table.insert( eligibleUnplayedLines, textLines )
			end
		end
	end

	if IsEmpty( allEligibleLines ) then
		return false
	end

	local randomLines = nil
	if IsEmpty( eligibleUnplayedLines ) then
		-- All lines played, start the record over
		for textLinesName, textLines in pairs( textLineSets ) do
			GameState.PlayedRandomTextLines[textLinesName] = nil
		end
		randomLines = GetRandomValue( allEligibleLines )
	else
		randomLines = GetRandomValue( eligibleUnplayedLines )
	end
	GameState.PlayedRandomTextLines[randomLines.Name] = true
	PlayTextLines( source, randomLines )
	return true

end

function CancelSpeakingAnimation( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	SetAnimation({ DestinationId = screen.PortraitId, Name = source.Portrait })
end

function ShowContinueArrow( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	SetAnimation({ DestinationId = screen.PromptId, Name = "DialogueContinueArrowIn" })
end

function AutoAdvanceNarration( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	notifyExistingWaiters( "NarrativeLineNextInput" )
	waitUnmodified( 0.2 )
end

function GetLastRunTextLinesOccured( textLinesName )
	if CurrentRun.TextLinesRecord[textLinesName] then
		return TableLength( GameState.RunHistory ) + 1
	end
	for runNum = TableLength( GameState.RunHistory ), 1, -1 do
		local run = GameState.RunHistory[runNum]
		if run.TextLinesRecord[textLinesName] then
			return runNum
		end
	end
	return -1
end