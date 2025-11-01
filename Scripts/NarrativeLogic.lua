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
		if textLines.PartnerVariant ~= nil then
			partnerData = NPCVariantData[textLines.PartnerVariant]
		end
		textLines = partnerData.InteractTextLineSets[textLines.Name]
	end
	return textLines
end

function CheckPartnerConversations( unit, textLines )

	if unit.NextInteractLines == nil then
		return nil
	end

	for partnerId, partnerUnit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if partnerUnit.Name == unit.NextInteractLines.Partner then
			local allTextLineSets = partnerUnit.InteractTextLineSets
			for partnerTextLinesName, partnerConversation in pairs( allTextLineSets ) do
				-- Partner conversation overrides any other conversation chosen
				if partnerTextLinesName == unit.NextInteractLines.Name then
					SetNextInteractLines( partnerUnit, partnerConversation )
					OnPartnerConversationSet( unit, partnerUnit )
					return partnerUnit
				end
			end
		end
	end

	return nil
end

function OnPartnerConversationSet( unit, partnerUnit )
	if unit.NextInteractLines.UseText ~= nil then
		partnerUnit.UseText = unit.NextInteractLines.UseText
	end
	if unit.NextInteractLines.BlockDistanceTriggers ~= nil then
		partnerUnit.NextInteractLines.BlockDistanceTriggers = unit.NextInteractLines.BlockDistanceTriggers
	end
	partnerUnit.CanReceiveGift = false
	if not unit.AllowSpecialInteractInPartnerConversation then
		unit.CanReceiveGift = false
	end
	partnerUnit.InPartnerConversation = true
	unit.InPartnerConversation = true
end

function NeedsUseableOff( source, textLineSets )

	-- Already had a UseableOff conversation

	if source.GiftTextLineSets ~= nil then
		for k, textLineSet in pairs( source.GiftTextLineSets ) do
			if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.UseableOffSource then
				--DebugPrint({ Text = "NeedsUseableOff from: "..textLineSet.Name })
				return true
			end
		end
	end

	textLineSets = textLineSets or source.InteractTextLineSets
	if textLineSets ~= nil then
		for k, textLineSet in pairs( textLineSets ) do
			if textLineSet.UseableOffSource or ( textLineSet.UseableOffSourceRequirements ~= nil and IsGameStateEligible( source, textLineSet.UseableOffSourceRequirements ) ) then
				if source.SplitHubUseableOffSource and CurrentHubRoom ~= nil then
					if CurrentRun.HubTextLinesRecord[textLineSet.Name] then
						--DebugPrint({ Text = "NeedsUseableOff from: "..textLineSet.Name })
						return true
					end
				else
					if CurrentRun.TextLinesRecord[textLineSet.Name] then
						--DebugPrint({ Text = "NeedsUseableOff from: "..textLineSet.Name })
						return true
					end
				end
			end
			if textLineSet.RoomUseableOffSource and CurrentRun.CurrentRoom.TextLinesRecord[textLineSet.Name] then
				--DebugPrint({ Text = "NeedsUseableOff from: "..textLineSet.Name })
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
	local nativelyInvulnerable = GetLifeDataValue({ Property = "Invulnerable", Id = source.ObjectId })
	if not nativelyInvulnerable then
		SetUnitInvulnerable( source, "PlayTextLines", { Silent = true } )
	end
	if SetThreadWait( "InfoBanner", 0.01 ) then
		wait( 0.3 )
	end

	GameState.NPCInteractions[source.Name] = (GameState.NPCInteractions[source.Name] or 0) + 1
	CurrentRun.NPCInteractions[source.Name] = (CurrentRun.NPCInteractions[source.Name] or 0) + 1
	source.ConversationThisRun = true
	RecordMapState( (CurrentHubRoom or CurrentRun.CurrentRoom).Name, source.ObjectId, "ConversationThisRun", source.ConversationThisRun )

	if textLines.PreEventFunctionName ~= nil then
		CallFunctionName( textLines.PreEventFunctionName, source, textLines.PreEventFunctionArgs, textLines )
	end
	if source.PreEventFunctionName ~= nil and not textLines.SkipPreEventFunction then
		CallFunctionName( source.PreEventFunctionName, source, source.PreEventFunctionArgs, textLines )
	end
	if not textLines.SkipPresentation then
		StartedTextLinesPresentation( source, textLines )
	end

	PlayingTextLines = true
	local screen = DeepCopyTable( ScreenData.Dialog )
	screen.ClipboardText = textLines.Name
	screen.Source = source
	screen.StartTime = _worldTime
	screen.LastLineStartTime = _worldTime
	OverwriteTableKeys( screen, args.ScreenArgs )
	ModifySubtitles({ SuppressLyrics = true })
	OnScreenOpened( screen )
	
	if PlayTextLine( screen, textLines, nil, nil, source, args ) then
		playedSomething = true
	end
	CallFunctionName( textLines.PrePortraitExitFunctionName, source, textLines.PrePortraitExitFunctionArgs, screen )

	local artExiting = false
	if screen.CurrentContextArt ~= nil and not args.PreserveContextArt then
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
	if args.PreserveContextArt then
		args.ContextArtId = screen.ContextArtId
	else
		Destroy({ Id = screen.ContextArtId })
	end
	Destroy({ Id = screen.PortraitId })
	Destroy({ Ids = screen.LeakedIds })
	
	OnScreenCloseStarted( screen )
	OnScreenCloseFinished( screen )
	ModifySubtitles({ SuppressLyrics = false })
	FinishedTextLinesPresentation( source, textLines )
	if not source.TextLinesIgnoreQuests then
		if not screen.SkipQuestStatusCheck then
			thread( CheckQuestStatus )
		end
		thread( CheckProgressAchievements )
	end
	AltAspectRatioFramesHide()
	RemoveInputBlock({ Name = "PlayTextLines" })
	UnfreezePlayerUnit( "PlayTextLines" )
	SetPlayerVulnerable( "PlayTextLines" )
	if not nativelyInvulnerable then
		SetUnitVulnerable( source, "PlayTextLines" )
	end
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
	args.TotalElapsedTime = _worldTime - screen.StartTime
	DebugPrint({ Text = "args.ElapsedTime = "..args.ElapsedTime })

	args.PlayOnceLine = textLines.PlayOnce
	--DebugPrint({ Text = "args.PlayOnceLine = "..tostring(args.PlayOnceLine) })

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
		thread( PlayEndVoiceLines, textLines.EndVoiceLines, source, args )
	end
	if textLines.EndGlobalVoiceLines ~= nil then
		thread( PlayEndVoiceLines, GlobalVoiceLines[textLines.EndGlobalVoiceLines], source, args )
	end
	CallFunctionName( textLines.EndFunctionName, source, textLines.EndFunctionArgs )
	if textLines.EndEvents ~= nil then
		RunEventsGeneric( textLines.EndEvents, source, args )
	end
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

function PlayEndVoiceLines( voiceLines, source, args )
	source.PlayingEndVoiceLines = true
	PlayVoiceLines( voiceLines, nil, source, args )
	source.PlayingEndVoiceLines = nil
end

function PlayTextLine( screen, textLines, prevLine, parentLine, source, args )

	args = args or {}
	DebugAssert({ Condition = textLines.Name ~= nil, Text = "TextLines being played without a name!" })
	if textLines.Name ~= nil and not args.SkipRecords then
		GameState.TextLinesRecord[textLines.Name] = true
		CurrentRun.TextLinesRecord[textLines.Name] = true
		if CurrentHubRoom ~= nil then
			CurrentRun.HubTextLinesRecord[textLines.Name] = true
		elseif CurrentRun.CurrentRoom ~= nil then
			CurrentRun.CurrentRoom.TextLinesRecord[textLines.Name] = true
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
			if line.EndSecretMusic ~= nil then
				SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
				StopSound({ Id = AudioState.SecretMusicId, Duration = 5 })
				AudioState.SecretMusicId = nil
				AudioState.SecretMusicName = nil
				ResumeMusic()
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
				-- intentionally delayed a bit vs. AngleHeroTowardTargetId
				if playLine.PreLineAngleHeroTowardTargetId ~= nil then
					AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = playLine.PreLineAngleHeroTowardTargetId })
				end

				waitUnmodified( playLine.PreLineWait )

				local played = DisplayTextLine( screen, source, playLine, textLines, textLines[lineIndex + 1], args )
				if played then
					playedSomething = true

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

	if args.RequireNoTeleportToId and line.TeleportToId ~= nil then
		return false
	end

	if args.PlayOnceFlag and line.PlayOnce and not line[args.PlayOnceFlag] then
		return false
	end

	if line.Force then
		return true
	end

	if line.Partner ~= nil then
		if args.IgnorePartnerExists then
			-- Still need to check if partner will be able to talk after they spawn
			local partnerData = EnemyData[line.Partner]
			if partnerData ~= nil and NeedsUseableOff( partnerData ) then
				args.FirstFailedRequirement = "Partner is UseableOff already"
				return false
			end
		else
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
				if NeedsUseableOff( partner ) then
					args.FirstFailedRequirement = "Partner is UseableOff already"
					return false
				end
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

	--if line.GameStateRequirements ~= nil and not IsGameStateEligible( line, line.GameStateRequirements, args ) then -- Decide on preferred source
	if line.GameStateRequirements ~= nil and not IsGameStateEligible( source, line.GameStateRequirements, args ) then
		return false
	end

	return true

end

function DisplayTextLine( screen, source, line, parentLine, nextLine, args )

	args = args or {}
	local rawText = line.Text
	local text = nil

	-- Look up the text line without the '/VO/' prefix
	if line.Cue ~= nil then
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
	elseif line.IgnoreRawText then
		rawText = nil
		text = line.Text
	end

	screen.LastLineStartTime = _worldTime

	local cue = line.Cue

	if line.Source ~= nil then
		source = EnemyData[line.Source] or LootData[line.Source] or ConsumableData[line.Source]
	elseif line.UsePlayerSource then
		source = CurrentRun.Hero
	end

	local speakerName = line.SpeakerNameplateId or line.Speaker or source.Speaker or source.Name	
	
	-- Always prioritize line data over source data
	local lineHistoryName = line.LineHistoryName or line.SpeakerNameplateId or line.Speaker or source.LineHistoryName or source.Speaker or source.Name
	local speakerSource = EnemyData[speakerName] or LootData[speakerName]
	local speakerSourceSubtitleColor = nil
	if speakerSource ~= nil then
		speakerSourceSubtitleColor = speakerSource.NarrativeFadeInColor or speakerSource.SubtitleColor
	end
	local lineHistorySubtitleColor = line.SubtitleColor or speakerSourceSubtitleColor or source.NarrativeFadeInColor or source.SubtitleColor
	table.insert( CurrentRun.LineHistory, { SpeakerName = lineHistoryName, SourceName = source.Name, Text = text, RawText = rawText,
		SubtitleColor = lineHistorySubtitleColor } )

	local portrait = line.Portrait or source.Portrait
	if source.PortraitSwapMap ~= nil then
		portrait = source.PortraitSwapMap[portrait] or portrait
	end

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

	if portrait ~= nil and not line.SkipPortrait then
		-- Dialogue with portrait
		local portraitAnchorX = ScreenCenterX - 490
		local portraitAnchorY = ScreenCenterY + 105
		if screen.ContextArtId == nil then
			screen.ContextArtId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = args.Group or "Combat_Menu" })
		end
		if screen.PortraitId == nil then
			screen.PortraitId = CreateScreenObstacle({ Name = "BlankObstacle", X = portraitAnchorX, Y = portraitAnchorY, Group = args.Group or "Combat_Menu" })
		end
		AltAspectRatioFramesShow()
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= portrait and not line.SkipPrevPortraitExit then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			waitUnmodified( line.PortraitExitWait or 0.3 )
		end
		if screen.CurrentContextArt == nil and not line.SkipContextArt and not parentLine.SkipContextArt and not source.SkipContextArt then
			local currentRoom = (CurrentHubRoom or CurrentRun.CurrentRoom)
			local roomData = RoomData[currentRoom.Name] or HubRoomData[currentRoom.Name]
			local contextArt = line.NarrativeContextArt or source.NarrativeContextArt or roomData.NarrativeContextArt
			if line.UseRoomContextArt then
				contextArt = roomData.NarrativeContextArt
			end
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

		if source.PortraitOverrides ~= nil or screen.LastPortraitHadOverrides then
			local overrides = source.PortraitOverrides or { OffsetX = 0, OffsetY = 0, Scale = 1.0 }
			Teleport({ Id = screen.PortraitId, OffsetX = portraitAnchorX + overrides.OffsetX, OffsetY = portraitAnchorY + overrides.OffsetY })
			SetScale({ Id = screen.PortraitId, Fraction = overrides.Scale })
		end
		screen.LastPortraitHadOverrides = (source.PortraitOverrides ~= nil)

		SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
		if source.OnPortraitSetFunctionName ~= nil then
			CallFunctionName( source.OnPortraitSetFunctionName, source, source.OnPortraitSetFunctionArgs, screen, line )
		end
		narrationBoxOffsetX = 198
		if screen.DialogueGlowBackgroundId == nil then
			screen.DialogueGlowBackgroundId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 200, Y = ScreenCenterY + 300, Group = args.Group or screen.DefaultGroup })
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
			screen.BackgroundId = CreateScreenObstacle({ Name = boxAnimation, X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX), Y = ScreenCenterY + (line.BoxOffsetY or 264), Group = args.Group or screen.DefaultGroup })
		end
		exitAnimation = line.BoxExitAnimation or source.BoxExitAnimation or "DialogueSpeechBubbleOut"
		textColor = line.TextColor or source.NarrativeTextColor or Color.DialogueText

		if line.Append then
			Destroy({ Ids = { screen.NameplateId, screen.NameplateDescriptionId } })
			screen.NameplateId = nil
			screen.NameplateDescriptionId = nil
		end

		if screen.NameplateId == nil then
			screen.NameplateId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 12, Y = ScreenCenterY + 103, Group = args.Group or screen.DefaultGroup })
		end
		if screen.NameplateDescriptionId == nil then
			screen.NameplateDescriptionId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 8, Y = ScreenCenterY + 146, Group = args.Group or screen.DefaultGroup })
		end

		CreateTextBox({
			Id = screen.NameplateId,
			Text = speakerName,
			FontSize = 32,
			OffsetY = speakerLabelOffsetY + GetLocalizedValue( 0, screen.ComponentData.SpeakerDisplayName.LangOffsetY ),
			Font = "CaesarDressing",
			Color = source.NameplateSpeakerNameColor or Color.DialogueSpeakerName,
			ShadowBlur = 1, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "CENTER",
		})

		CreateTextBox({
			Id = screen.NameplateDescriptionId,
			Text = speakerName,
			FontSize = 22,
			OffsetY = 3 + GetLocalizedValue( 0, screen.ComponentData.SpeakerDescription.angOffsetY ),
			Font = "P22UndergroundSCMedium",
			Color = source.NameplateDescriptionColor or {120, 220, 180, 192},
			UseDescription = true,
		})

	else
		-- Narration
		if screen.DialogueGlowBackgroundId == nil then
			screen.DialogueGlowBackgroundId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 200, Y = ScreenCenterY + 300, Group = args.Group or screen.DefaultGroup })
			SetAnimation({ DestinationId = screen.DialogueGlowBackgroundId, Name = "NarrationBackgroundGlow" })
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 0 })
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 1, Duration = 0.25  })
		end
		if screen.BackgroundId == nil then
			screen.BackgroundId = CreateScreenObstacle({ Name = "NarrationBubble",
				X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX),
				Y = ScreenCenterY + (line.BoxOffsetY or 264),
				Animation = line.BoxAnimation,
				Group = args.Group or screen.DefaultGroup })
		end
		if line.BoxAnimation ~= nil then
			SetAnimation({ Name = line.BoxAnimation, DestinationId = screen.BackgroundId })
		end
		exitAnimation = line.BoxExitAnimation or "NarrationBubbleOut"
		textColor = Color.NarrationText
		textShadowColor = {0,0,0, 1.0}
		narrationTextOffsetX = 0
		narrationTextOffsetY = -10
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
		if line.DisableCharacterFadeColorLag or fadeInSource.DisableCharacterFadeColorLag then
			fadeInProperties = 
			{
				CharacterFadeTime = 0.0125,
				CharacterFadeInterval = 0.001,
			}
		end
		local data = ShallowCopyTable( ScreenData.Dialog.ComponentData.DialogueText.TextArgs )
		data.LineSpacingBottom = GetLocalizedValue( data.LineSpacingBottom, data.LangLineSpacingBottom )
		data.Id = screen.BackgroundId
		data.Text = text
		data.RawText = rawText
		data.Width = line.TextWidth or 833
		data.OffsetX = line.TextOffsetX or (-397 + narrationTextOffsetX)
		data.OffsetY = GetLocalizedValue( line.TextOffsetY or (45 + narrationTextOffsetY), line.LangTextOffsetY )
		data.FontSize = line.FontSize or 24
		data.VerticalJustification = line.VerticalJustification or "CENTER"
		data.Color = line.TextColor or textColor
		data.ShadowColor = textShadowColor
		data.DataProperties = fadeInProperties
		CreateTextBox( data )
	end

	local anchorIds = { screen.BackgroundId, screen.NameplateId, screen.NameplateDescriptionId }
	Destroy({ Id = screen.PromptId })
	screen.PromptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 390 + narrationBoxOffsetX, Y = ScreenCenterY + promptOffsetY, Group = args.Group or screen.DefaultGroup })
	table.insert( anchorIds, screen.PromptId )

	local listenStartTime = _worldTime

	local speechId = PlaySpeechCue( cue, nil, nil, "Interrupt", false )
	if speechId > 0 then
		CurrentRun.CurrentRoom.SpeechRecord[cue] = (CurrentRun.CurrentRoom.SpeechRecord[cue] or 0) + 1
		-- Extra back-compat due to GameState.PatchedSpeechRecords2 somehow missing some cases
		if GameState.SpeechRecord[cue] ~= nil and type(GameState.SpeechRecord[cue]) == "boolean" then
			GameState.SpeechRecord[cue] = 1
		end
		if CurrentRun.SpeechRecord[cue] ~= nil and type(CurrentRun.SpeechRecord[cue]) == "boolean" then
			CurrentRun.SpeechRecord[cue] = 1
		end
		GameState.SpeechRecord[cue] = (GameState.SpeechRecord[cue] or 0) + 1
		CurrentRun.SpeechRecord[cue] = (CurrentRun.SpeechRecord[cue] or 0) + 1
	end
	if not line.AutoAdvance and not line.IgnoreContinueArrow and not GetConfigOptionValue({ Name = "AutoAdvanceNarration" }) then
		thread( ShowContinueArrow, screen, source, cue )
	end

	local selectedChoice = nil
	local choiceMap = {}
	local choiceHotkeyControls = {}

	if line.Choices ~= nil then
		local firstChoice = false
		for k, choice in ipairs( line.Choices ) do
			local choiceButtonData = ShallowCopyTable( screen.ComponentData.ChoiceButtons[k] )
			choiceButtonData.TextArgs.Text = choice.ChoiceText
			choiceButtonData.GroupName = args.Group or screen.DefaultGroup or choiceButtonData.GroupName
			local component = CreateComponentFromData( screen.ComponentData, choiceButtonData )
			component.Screen = screen
			choiceMap[component.Id] = choice
			for i, hotkeyName in ipairs( component.ControlHotkeys ) do
				choiceMap[hotkeyName] = choice
			end
			table.insert( screen.ChoiceIds, component.Id )
			ConcatTableValues( choiceHotkeyControls, component.ControlHotkeys )
		end

	end

	waitUnmodified(0.04)
	-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
	PauseSound({ Id = speechId, Duration = 0 })
	ResumeSound({ Id = speechId, Duration = 0 })
	waitUnmodified( line.InputDelay or 0.17 ) -- Minimum input advance delay

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
		NotifyOnInteract({ Ids = screen.ChoiceIds, Notify = notifyName })
		NotifyOnControlPressed({ Names = choiceHotkeyControls, Notify = notifyName })
		--screen.AllowAdvancedTooltip = true
		screen.BlockPause = true
		waitUntil( notifyName )
		--screen.AllowAdvancedTooltip = false
		screen.BlockPause = false
		local selectedId = NotifyResultsTable[notifyName]
		selectedChoice = choiceMap[selectedId]
		CurrentRun.TextLinesChoiceRecord[parentLine.Name] = selectedChoice.ChoiceText
		GameState.TextLinesChoiceRecord[parentLine.Name] = selectedChoice.ChoiceText
		Destroy({ Ids = screen.ChoiceIds })
		screen.ChoiceIds = {}
		AddInputBlock({ Name = "PlayTextLines" })
		DisableGamepadCursor( screen.Name )
	end

	killTaggedThreads( NarrativeThreadName )
	killWaitUntilThreads( cue )

	GameState.TextLinePanelCount[parentLine.Name] = (GameState.TextLinePanelCount[parentLine.Name] or 0) + 1
	local listenEndTime = _worldTime
	local listenElapsedTime = listenEndTime - listenStartTime
	if listenElapsedTime < NarrativeConstantData.ListenSkipThreshold then
		GameState.TextLinePanelSkipCount[parentLine.Name] = (GameState.TextLinePanelSkipCount[parentLine.Name] or 0) + 1
	end

	if nextLine ~= nil and nextLine.Append then
		-- Do nothing
	else
		DestroyTextBox({ Ids = anchorIds })
		SetAnimation({ DestinationId = screen.BackgroundId, Name = exitAnimation })
		StopAnimation({ DestinationId = screen.BackgroundId, Name = "DialogueSpeechBubbleFx" })
		StopAnimation({ DestinationId = screen.BackgroundId, Name = "DialogueSpeechBubbleFxLight" })
		if line.ExitPortraitImmediately ~= nil and screen.CurrentPortrait ~= nil then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			screen.CurrentPortrait = nil
		end
		if line.PortraitExitAnimation ~= nil then
			local exitAnimation = line.PortraitExitAnimation
			if source.PortraitSwapMap ~= nil then
				exitAnimation = source.PortraitSwapMap[exitAnimation] or exitAnimation
			end
			SetAnimation({ DestinationId = screen.PortraitId, Name = exitAnimation })
			screen.CurrentPortrait = nil
		end
		if line.PortraitExitSound ~= nil then
			PlaySound({ Name = line.PortraitExitSound, Id = screen.PortraitId })
		end
		if screen.CurrentContextArt ~= nil and ( line.PostLineRemoveContextArt or (nextLine ~= nil and nextLine.IsNarration and not nextLine.KeepContextArt) ) then
			SetAnimation({ DestinationId = screen.ContextArtId, Name = screen.CurrentContextArt.."_Out" })
			screen.CurrentContextArt = nil
		end
		if screen.DialogueGlowBackgroundId ~= nil then
			SetAlpha({ Id = screen.DialogueGlowBackgroundId, Fraction = 0, Duration = 0.12 })
			table.insert( screen.LeakedIds, screen.DialogueGlowBackgroundId )
			screen.DialogueGlowBackgroundId = nil
		end
	end

	waitUnmodified(0.15)
	if nextLine ~= nil and nextLine.Append then
		-- Do nothing
	else
		Destroy({ Ids = anchorIds })
		screen.BackgroundId = nil
		screen.NameplateId = nil
		screen.NameplateDescriptionId = nil
	end

	StopSound({ Id = speechId, Duration = 0.15 })

	if selectedChoice ~= nil then
		PlaySound({ Name = "/SFX/Menu Sounds/IrisMenuBack" })
		selectedChoice.Name = parentLine.Name..selectedChoice.ChoiceText
		PlayTextLine( screen, selectedChoice, line, line, source, { SkipRecords = true } )
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

function ShowContinueArrow( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	SetAnimation({ DestinationId = screen.PromptId, Name = "DialogueContinueArrowIn" })
end

function AutoAdvanceNarration( screen, source, cue )
	if cue ~= nil then
		if cue == "/EmptyCue" then
			wait( 3.0, NarrativeThreadName )
		else
			waitUntil( cue )
		end
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
		if run.TextLinesRecord ~= nil and run.TextLinesRecord[textLinesName] then
			return runNum
		end
	end
	return -1
end