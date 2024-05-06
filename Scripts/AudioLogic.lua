AudioState = AudioState or {}

function AudioStateInit( triggerArgs )

	DeferredPlayVoiceLines = {}
	AudioState.ActiveSpeechIds = AudioState.ActiveSpeechIds or {}

	if AudioState.MusicName ~= nil and AudioState.MusicId == nil then
		-- Out of sync (presumably from a load)
		local restoreTrackName = AudioState.MusicName
		local restoreMusicSection = AudioState.MusicSection
		AudioState.MusicName = nil
		AudioState.MusicSection = nil
		MusicPlayer( restoreTrackName )
		SetMusicSection( restoreMusicSection )
		if AudioState.MusicId ~= nil then
			if AudioState.MusicActiveStems ~= nil then
				SetSoundCueValue({ Names = AudioState.MusicActiveStems, Id = AudioState.MusicId, Value = 1 })
			end
			if AudioState.MusicMutedStems ~= nil then
				SetSoundCueValue({ Names = AudioState.MusicMutedStems, Id = AudioState.MusicId, Value = 0 })
			end
		else
			AudioState.MusicActiveStems = nil
			AudioState.MusicMutedStems = nil
		end
		if AudioState.MusicPlayerTrackPaused and MusicPlayerTrackData[MusicName] ~= nil then
			PauseMusic()
		end
	end

	if AudioState.AmbientTrackName ~= nil and AudioState.AmbientMusicSource ~= nil and AmbientMusicId == nil then
		-- Out of sync (presumably from a load)
		local restoreTrackName = AudioState.AmbientTrackName
		AudioState.AmbientTrackName = nil
		wait(0.02) -- Need to wait for potential stored targets to spawn
		local source = ActiveEnemies[AmbientMusicSource.ObjectId]
		if source ~= nil then
			MusicianMusic( source, { TrackName = restoreTrackName } )
			if CurrentHubRoom ~= nil then
				if CurrentHubRoom.AmbientMusicParams ~= nil then
					for param, value in pairs( CurrentHubRoom.AmbientMusicParams ) do
						SetSoundCueValue({ Id = AmbientMusicId, Name = param, Value = value, Duration = 0.5 })
					end
				end
				SetVolume({ Id = AmbientMusicId, Value = CurrentHubRoom.AmbientMusicVolume, Duration = 0.5 })
			end
		end
	end
end


function DeferredAudioScripts()
	for index, params in ipairs( DeferredPlayVoiceLines ) do
		thread( PlayVoiceLinesReal, params[1], params[2], params[3], params[4] )
	end
	DeferredPlayVoiceLines = {}
end

-- **Music**

function MusicPlayerEvent( source, args )
	MusicPlayer( args.TrackName, args.MusicInfo, args.DestinationId )
end

function MusicPlayer( trackName, musicInfo, destinationId )

	if trackName == nil then
		return false
	end

	if AudioState.MusicName ~= nil and AudioState.MusicName == trackName then
		-- Don't play an identical track that's already playing
		-- But do still update the source if it is being changed
		SetSoundSource({ Id = AudioState.MusicId, DestinationId = destinationId })
		return false
	end

	if AudioState.MusicId ~= nil then
		-- Quick cut any music still playing
		StopSound({ Id = AudioState.MusicId, Duration = 0.25 })
		AudioState.MusicId = nil
	end
	if AudioState.StoppingMusicId ~= nil then
		-- Quick cut any music still fading out
		StopSound({ Id = AudioState.StoppingMusicId, Duration = 0.25 })
		AudioState.StoppingMusicId = nil
	end

	AudioState.MusicName = trackName
	AudioState.MusicId = PlaySound({ Name = AudioState.MusicName, AddCallbacks = true, Id = destinationId })
	SetDefaultMusicParams( AudioState.MusicName, AudioState.MusicId )
	AudioState.MusicPaused = nil

	if musicInfo ~= nil then
		musicInfo.Id = AudioState.MusicId
		musicInfo.Name = AudioState.MusicName
		if musicInfo.TrackStartEvents ~= nil then
			RunEventsGeneric( musicInfo.TrackStartEvents, musicInfo )
		end
	end

	if AudioState.SecretMusicId ~= nil then
		-- Secret music has priority and is mutually exclusive so this must wait
		SetVolume({ Id = AudioState.MusicId, Value = 0.0, Duration = 0.0 })
		PauseSound({ Id = AudioState.MusicId, Duration = 0.0 })
	end

	return true

end

function SecretMusicPlayer( trackName, args )

	if trackName == nil then
		return false
	end

	if AudioState.SecretMusicName == trackName then
		-- Don't play an identical track that's already playing
		return
	end

	if AudioState.MusicId ~= nil then
		-- Quick cut any music still playing
		PauseMusic()
	end
	if AudioState.SecretMusicId ~= nil then
		-- Quick cut any music still playing
		StopSound({ Id = AudioState.SecretMusicId, Duration = 0.25 })
	end

	AudioState.SecretMusicName = trackName
	AudioState.SecretMusicId = PlaySound({ Name = AudioState.SecretMusicName, AddCallbacks = true })
	SetDefaultMusicParams( AudioState.SecretMusicName, AudioState.SecretMusicId, args )

	return true

end

function StopSecretMusic( smoothStop )

	if AudioState.SecretMusicId == nil then
		return
	end

	if smoothStop then
		EndMusic( AudioState.SecretMusicId, AudioState.SecretMusicName )
	else
		StopSound({ Id = AudioState.SecretMusicId, Duration = 0.25 })
	end
	AudioState.SecretMusicId = nil
	AudioState.SecretMusicName = nil

end

function StopSecretMusicTheme( source )

	if AudioState.SecretMusicName == source.ThemeMusic then
		-- Stop theme if that's what's actually playing
		SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 10 })
		AudioState.SecretMusicId = nil
		AudioState.SecretMusicName = nil
	end

end

function MusicianMusic( source, args )

	if CurrentRun.BlockAmbientMusic then
		return
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "SingingPresentation", Args = args }
	SingingPresentation( source, args )

	if args.TrackName == AudioState.AmbientTrackName then
		-- Don't play an identical track that's already playing
		-- But do still update the source if it is being changed
		SetSoundSource({ Id = AudioState.AmbientMusicId, DestinationId = source.ObjectId })
		AudioState.AmbientMusicSource = source
		return
	end

	if AudioState.AmbientMusicId ~= nil then
		-- Quick cut the previously playing id
		StopSound({ Id = AudioState.AmbientMusicId, Duration = 0.25 })
		AudioState.AmbientMusicId = nil
	end

	--Shake({ Id = source.ObjectId, Distance = 1, Speed = 3, Duration = 9999, Angle = 0 })

	AudioState.AmbientMusicSource = source
	AudioState.AmbientMusicId = PlaySound({ Name = args.TrackName, Id = source.ObjectId })
	SetSoundCueValue({ Names = { "Vocals", }, Id = AudioState.AmbientMusicId, Value = 1 })
	AudioState.AmbientTrackName = args.TrackName
	SetVolume({ Id = AudioState.AmbientMusicId, Value = 1 })
	if args.TrackOffset ~= nil or args.TrackOffsetMin ~= nil then
		SetSoundPosition({ Id = AudioState.AmbientMusicId, Position = args.TrackOffset or RandomFloat( args.TrackOffsetMin, args.TrackOffsetMax ) })
	end
	-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
	thread( PauseUnpauseSoundWorkaround, AudioState.AmbientMusicId )

end

-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
function PauseUnpauseSoundWorkaround( soundId )
	wait( 0.03 )
	PauseSound({ Id = soundId, Duration = 0 })
	ResumeSound({ Id = soundId, Duration = 0 })
end

function StopMusicianMusic( source, args )
	StopSound({ Id = AudioState.AmbientMusicId, Duration = args.Duration or 0.2 })
	AudioState.AmbientMusicId = nil
	AudioState.AmbientTrackName = nil
	if source ~= nil and source.ObjectId ~= nil then
		CurrentRun.EventState[source.ObjectId] = nil
	end
end

function SetDefaultMusicParams( trackName, musicId, args )

	args = args or {}	
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]

	SetSoundCueValue({ Names = args.ParamNames or roomData.DefaultMusicParams or { "Guitar", "Drums", "Bass", "Keys", }, Id = musicId, Value = 1 })

	SetMusicSection( args.Section or 1, musicId )

end

function MusicMixer( mixArgs )
	if mixArgs == nil then
		return
	end

	if mixArgs.MusicMixerRequirements ~= nil and not IsGameStateEligible( CurrentRun, mixArgs, mixArgs.MusicMixerRequirements ) then
		return
	end

	wait( mixArgs.MusicStartDelay )

	if mixArgs.PlayBiomeMusic then
		local biomeName = CurrentRun.CurrentRoom.RoomSetName
		local biomeMusicTracks = MusicTrackData[biomeName]
		if biomeMusicTracks ~= nil then
			local eligibleBiomeMusicTracks = {}
			for index, trackData in ipairs( biomeMusicTracks ) do
				if trackData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, trackData, trackData.GameStateRequirements ) then
					table.insert( eligibleBiomeMusicTracks, trackData )
				else
					--DebugPrint({ Text = "ineligible track = "..trackData.Name })
				end
			end
			if not IsEmpty( eligibleBiomeMusicTracks ) then
				local trackIndex = ((GameState.BiomeMusicPlayCounts[biomeName] or 0) % #eligibleBiomeMusicTracks) + 1
				local trackData = biomeMusicTracks[trackIndex]
				MusicPlayer( trackData.Name, trackData )
				GameState.BiomeMusicPlayCounts[biomeName] = (GameState.BiomeMusicPlayCounts[biomeName] or 0) + 1
			end
		end
	end

	if AudioState.MusicId == nil then
		return
	end
	if mixArgs.MusicActiveStems ~= nil then
		AudioState.MusicActiveStems = mixArgs.MusicActiveStems
		SetSoundCueValue({ Names = mixArgs.MusicActiveStems, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })
	end
	if mixArgs.MusicMutedStems ~= nil then
		AudioState.MusicMutedStems = mixArgs.MusicMutedStems
		SetSoundCueValue({ Names = mixArgs.MusicMutedStems, Id = AudioState.MusicId, Value = 0, Duration = mixArgs.MusicMutedStemsDuration or 0.75 })
	end
	if mixArgs.MusicSection ~= nil then
		SetMusicSection( mixArgs.MusicSection )
	end
	if mixArgs.FunctionName ~= nil then
		CallFunctionName( mixArgs.FunctionName, mixArgs, mixArgs.FunctionArgs )
	end

	if mixArgs.UseRoomMusicSection ~= nil and CurrentRun.CurrentRoom.MusicSection ~= nil then
		SetMusicSection( CurrentRun.CurrentRoom.MusicSection )
	end

end

function CheckMusicEvents( currentRun, musicEvents )

	if musicEvents == nil then
		return
	end

	for k, musicEvent in ipairs( musicEvents ) do

		if IsGameStateEligible( currentRun, musicEvent, musicEvent.GameStateRequirements ) then

			if musicEvent.EndMusic then
				EndMusic()
			end

			thread( MusicMixer, musicEvent )

		end

	end

end

function EndMusic( musicId, musicName, hardStopTime )
	if musicId == nil then
		musicId = AudioState.MusicId
	end
	if musicId == nil then
		return
	end

	if musicId == AudioState.MusicId and AudioState.MusicPaused then
		-- Stop instantly if already paused
		ResumeSound({ Id = musicId })
		StopSound({ Id = musicId })
	else
		SetMusicSection( 10, musicId )
	end

	if hardStopTime ~= nil then
		StopSound({ Id = musicId, Value = 0.0, Duration = hardStopTime })
		AudioState.StoppingMusicId = musicId
	end

	if musicId == AudioState.MusicId then
		AudioState.MusicId = nil
		AudioState.MusicName = nil
		AudioState.MusicSection = nil
		AudioState.MusicPaused = nil
	end

end

function PauseMusic( args )
	args = args or {}
	PauseSound({ Id = AudioState.MusicId, Duration = args.Duration or 0.2 })
	AudioState.MusicPaused = true
end

function ResumeMusic( args )
	args = args or {}
	if AudioState.MusicId == nil then
		return
	end
	wait( args.Delay )
	ResumeSound({ Id = AudioState.MusicId, Duration = args.Duration or 0.2 })
	AudioState.MusicPaused = false
end

function PauseAmbientMusic()
	PauseSound({ Id = AudioState.AmbientMusicId, Duration = 0.2 })
	PauseSound({ Id = AudioState.SecretMusicId, Duration = 0.2 })
end

function ResumeAmbientMusic()
	ResumeSound({ Id = AudioState.AmbientMusicId, Duration = 0.2 })
	SetVolume({ Id = AudioState.AmbientMusicId, Value = 1.0 })
	ResumeSound({ Id = AudioState.SecretMusicId, Duration = 0.2 })
end

function SetMusicSection( section, musicId )
	if section == nil then
		return
	end
	if musicId == nil then
		musicId = AudioState.MusicId
	end
	SetSoundCueValue({ Names = { "Section", }, Id = musicId, Value = section })
	if musicId == AudioState.MusicId then
		AudioState.MusicSection = section
		AudioState.MusicSectionStartDepth = CurrentRun.RunDepthCache
	end
end

function SetAdvancedTooltipMixing( value )
	SetSoundCueValue({ Id = GetMixingId({}), Names = { "Wagon" }, Value = value or 0 })
end

-- **AMBIENCE**
function StartRoomAmbience( currentRun, currentRoom, args )

	args = args or {}

	local roomData = RoomData[currentRoom.Name] or currentRoom

	local newTrackName = nil
	if currentRoom.Encounter then
		newTrackName = currentRoom.Encounter.Ambience
	end

	newTrackName = newTrackName or roomData.Ambience

	if newTrackName == "None" then
		-- Silence requested
		StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
		AudioState.AmbienceId = nil
		AudioState.AmbienceName = nil
	elseif newTrackName ~= nil then
		-- Specific track requested
		if newTrackName ~= AudioState.AmbienceName then
			StopSound({ Id = AudioState.AmbienceId, Duration = 0.5 })
			AudioState.AmbienceId = PlaySound({ Name = newTrackName, Duration = 0.5 })
			AudioState.AmbienceName = newTrackName
		end
	end

	if currentRoom.ReverbValue ~= nil and not args.SkipReverb then
		SetAudioEffectState({ Name = "Reverb", Value = currentRoom.ReverbValue })
	end
	if currentRoom.GlobalEcho ~= nil then
		SetAudioEffectState({ Name = "GlobalEcho", Value = currentRoom.GlobalEcho })
	end

end

function EndAmbience( duration )
	StopSound({ Id = AudioState.AmbienceId, Duration = duration or 0.2 })
	AudioState.AmbienceId = nil
	StopSound({ Id = AudioState.AmbientMusicId, Duration = duration or 0.2 })
	AudioState.AmbientMusicId = nil
	AudioState.AmbientTrackName = nil
end

-- **VO**

function PlayRandomEligibleVoiceLines( voiceLineSets, neverQueue )

	while not IsEmpty( voiceLineSets ) do
		local voiceLines = RemoveRandomValue( voiceLineSets )
		local playedSomething = PlayVoiceLines( voiceLines, neverQueue )
		neverQueue = true -- Only queue 1 regardless
		if playedSomething then
			return
		end
	end

end

function PlayFirstEligibleVoiceLines( voiceLineSets )

	local highestIndex = GetHighestIndex( voiceLineSets )
	for index = 1, highestIndex do
		local voiceLines = voiceLineSets[index]
		if voiceLines ~= nil then
			local playedSomething = PlayVoiceLines( voiceLines, true )
			if playedSomething then
				return
			end
		end
	end

end

function PlayVoiceLines( voiceLines, neverQueue, source, args )
	if voiceLines == nil then
		return
	end
	if args ~= nil and args.Defer then
		for k, v in pairs( DeferredPlayVoiceLines ) do
			if v[1] == voiceLines then
				DebugPrint({ Text = "VoiceLines play request de-duped:"..tostring(GetFirstCueName(voiceLines)) })
				return
			end
		end
		table.insert( DeferredPlayVoiceLines, { voiceLines, neverQueue, source, args } )
		return
	end

	return PlayVoiceLinesReal( voiceLines, neverQueue, source, args )
end

function PlayVoiceLinesReal( voiceLines, neverQueue, source, args )

	if voiceLines == nil then
		return
	end

	args = args or {}

	args.OriginalSource = source
	source = GetLineSource( voiceLines, source, args )
	args.CurrentSource = source
	if source == nil then
		-- Never play a line if the source doesn't exist
		return
	end

	if not IsVoiceLineEligible( voiceLines, nil, nil, source, args ) then
		-- First check requirements of the whole set
		if voiceLines.PlayedNothingFunctionName ~= nil then
			CallFunctionName( voiceLines.PlayedNothingFunctionName, source, voiceLines.PlayedNothingFunctionArgs )
		end
		return
	end

	if source.PlayingVoiceLine ~= nil then
		if voiceLines.Queue == "Interrupt" then
			-- Play as normal
		else
			if neverQueue or voiceLines.Queue == "Never" then
				DebugPrint({ Text = "Skipped voiceLines on "..GetTableString( source ).." (Playing: "..source.PlayingVoiceLine..")" })
				return
			end
			--if source.QueuedVoiceLines == nil then
				--source.QueuedVoiceLines = {}
			--end
			--table.insert( source.QueuedVoiceLines, { Lines = voiceLines, Args = args } )
			table.insert( SessionMapState.QueuedVoiceLines, { Lines = voiceLines, Source = source, Args = args } )
			if verboseLogging then
				DebugPrint({ Text = "Queued voiceLines "..tostring(voiceLines.Name).." on "..GetTableString( source ).." (Playing: "..source.PlayingVoiceLine..")" })
			end
			return
		end
	end

	local playedSomething = nil
	local parentLine = voiceLines

	--source.PlayingVoiceLine = true
	CallFunctionName( source.StartedVoiceLinesFunctionName, source, source.StartedVoiceLinesFunctionArgs )
	local playedCue = PlayVoiceLine( voiceLines, nil, nil, source, args, args )
	if playedCue ~= nil then
		playedSomething = playedCue
	else
		if voiceLines.PlayedNothingFunctionName ~= nil then
			CallFunctionName( voiceLines.PlayedNothingFunctionName, source, voiceLines.PlayedNothingFunctionArgs )
		end
	end
	--source.PlayingVoiceLine = false
	CallFunctionName( source.FinishedVoiceLinesFunctionName, source, source.FinishedVoiceLinesFunctionArgs )
	if voiceLines.FinishedFunctionName ~= nil then
		CallFunctionName( voiceLines.FinishedFunctionName, source, voiceLines.FinishedFunctionArgs )
	end
	if args.FinishedFunctionName ~= nil then
		CallFunctionName( args.FinishedFunctionName, source, args.FinishedFunctionArgs, args )
	end

	while not IsEmpty( SessionMapState.QueuedVoiceLines ) and GetFirstValue( SessionMapState.QueuedVoiceLines ).Source.PlayingVoiceLine == nil do
		-- A line is queued and its source is not still playing a line
		local queuedLines = RemoveFirstValue( SessionMapState.QueuedVoiceLines )
		if PlayVoiceLines( queuedLines.Lines, false, queuedLines.Source, queuedLines.Args ) then
			playedSomething = true
		end
	end

	return playedSomething

end

function GetLineSource( line, source, args )

	if line.ObjectType ~= nil then
		local typeIds = GetIdsByType({ Name = line.ObjectType, Names = line.ObjectTypes })
		if IsEmpty( typeIds ) then
			return nil
		end
		local objectId = typeIds[1]
		source = ActiveEnemies[objectId]
		if source == nil then
			return nil
		else
			if line.RequiredSourceValue ~= nil and not source[line.RequiredSourceValue] then
				return nil
			end
			if line.RequiredSourceValueFalse ~= nil and source[line.RequiredSourceValueFalse] then
				return nil
			end
			return source
		end
	end

	if line.UsePlayerSource then
		return CurrentRun.Hero
	end

	if line.Source ~= nil then
		return line.Source
	end

	if source ~= nil then
		return source
	end

	return CurrentRun.Hero

end

function PlayVoiceLine( line, prevLine, parentLine, source, args, originalArgs )

	local playedSomething = nil

	if parentLine == nil then
		parentLine = line
	end

	args = args or {}
	-- Args which recursively apply to all nested children
	args.ThreadName = line.ThreadName or args.ThreadName
	args.Queue = line.Queue or args.Queue
	args.BreakIfPlayed = line.BreakIfPlayed or args.BreakIfPlayed
	args.PlayOnceContext = line.PlayOnceContext or args.PlayOnceContext
	args.PlayOnceFromTableThisRun = line.PlayOnceFromTableThisRun or args.PlayOnceFromTableThisRun
	args.SubtitleMinDistance = line.SubtitleMinDistance or args.SubtitleMinDistance
	args.Actor = line.Actor or args.Actor
	args.AllowTalkOverTextLines = line.AllowTalkOverTextLines or args.AllowTalkOverTextLines
	args.SkipAnim = line.SkipAnim or args.SkipAnim
	args.StatusAnimation = line.StatusAnimation or args.StatusAnimation
	args.StatusAnimSourceIsHero = line.StatusAnimSourceIsHero or args.StatusAnimSourceIsHero
	args.RequiresSourceAlive = line.RequiresSourceAlive or args.RequiresSourceAlive
	args.RecheckRequirementsPostWait = line.RecheckRequirementsPostWait or args.RecheckRequirementsPostWait
	args.TriggerCooldowns = line.TriggerCooldowns or args.TriggerCooldowns
	args.Cooldowns = line.Cooldowns or args.Cooldowns
	args.CooldownTime = line.CooldownTime or args.CooldownTime
	-- By default, the player object is the ListenerId, though could be something else
	args.ListenerId = line.ListenerId or args.ListenerId or CurrentRun.Hero.ObjectId

	local prevSource = source
	source = GetLineSource( line, source, args )
	args.CurrentSource = source
	if source == nil then
		-- Never play a line if the source doesn't exist
		return playedSomething
	end

	-- Need to recheck queuing if the source was switched for a sub-line
	if prevSource ~= source and source.PlayingVoiceLine ~= nil then
		if args.Queue == "Never" then
			DebugPrint({ Text = "Skipped voiceLines on "..GetTableString( source ).." (Playing: "..source.PlayingVoiceLine..")" })
			return playedSomething
		end
	end

	if line.PreLineThreadedFunctionName ~= nil then
		thread( CallFunctionName, line.PreLineThreadedFunctionName, source, line.PreLineThreadedFunctionArgs )
	end
	if line.PreLineFunctionName ~= nil then
		CallFunctionName( line.PreLineFunctionName, source, line.PreLineFunctionArgs )
	end
	if args.PreLineFunctionName ~= nil then
		CallFunctionName( args.PreLineFunctionName, source, args.PreLineFunctionArgs, args )
	end

	-- Play this line
	if line.Cue ~= nil then

		if not args.ReturnOnly then
			source.PlayingVoiceLine = line.Cue
		end

		wait( line.PreLineWait or parentLine.PreLineWait, args.ThreadName )

		if args.RecheckRequirementsPostWait and not IsVoiceLineEligible( line, prevLine, parentLine, source, args ) then
			source.PlayingVoiceLine = nil
			return nil
		end

		if args.ReturnOnly then
			return line.Cue
		end

		local preLineAnim = line.PreLineAnim or parentLine.PreLineAnim
		if preLineAnim ~= nil then
			SetAnimation({ Name = preLineAnim, DestinationId = source.ObjectId })
		end

		local playedSpeechId = 0
		local useSubtitles = false
		if not source.Mute or args.IgnoreMute then
			if args.SubtitleMinDistance then
				local dist = GetDistance({ Id = args.ListenerId, DestinationId = source.ObjectId })
				if dist > args.SubtitleMinDistance then
					useSubtitles = false
				else
					useSubtitles = true
				end
			else
				useSubtitles = true
			end
			if line.NoTarget or parentLine.NoTarget then
				playedSpeechId = PlaySpeech({ Name = line.Cue, Queue = args.Queue, SubtitleColor = source.SubtitleColor, UseSubtitles = useSubtitles, Actor = args.Actor })
			else
				playedSpeechId = PlaySpeechCueFromSource( line.Cue, source, args.Queue, useSubtitles, source.SubtitleColor, args )
			end
		end
		if line.UseOcclusion then
			SetSoundCueValue({ Id = playedSpeechId, Names = { "VoiceOcclusion" }, Value = 1.0, Duration = 0.01 })
		end
		if playedSpeechId > 0 then
			local textId = string.sub( line.Cue, 5 )
			table.insert( CurrentRun.LineHistory, { SpeakerName = source.LineHistoryName, SourceName = source.Name, Text = textId, SubtitleColor = source.NarrativeFadeInColor or source.SubtitleColor } )
			prevLine = line
			LastLinePlayed = line.Cue
			playedSomething = line.Cue
			args.PlayedSomething = true
			CurrentRun.CurrentRoom.SpeechRecord[line.Cue] = true
			GameState.SpeechRecord[line.Cue] = true
			CurrentRun.SpeechRecord[line.Cue] = true
			if args.PlayOnceContext ~= nil then
				GameState.SpeechRecordContexts[args.PlayOnceContext] = GameState.SpeechRecordContexts[args.PlayOnceContext] or {}
				GameState.SpeechRecordContexts[args.PlayOnceContext][line.Cue] = true
				CurrentRun.SpeechRecordContexts[args.PlayOnceContext] = CurrentRun.SpeechRecordContexts[args.PlayOnceContext] or {}
				CurrentRun.SpeechRecordContexts[args.PlayOnceContext][line.Cue] = true
			end
			-- Intentionally leaving this on raw data for now to be wiped out on load
			line.LastPlayTime = _worldTime
			parentLine.LastPlayTime = _worldTime
			OnLinePlayedSomething( line, source, args, originalArgs )
			if line.PlayedThreadedFunctionName ~= nil then
				thread( CallFunctionName, line.PlayedThreadedFunctionName, source, line.PlayedThreadedFunctionArgs )
			end
			SessionMapState.PlayingCues[line.Cue] = true
			waitUntil( line.Cue )
			SessionMapState.PlayingCues[line.Cue] = nil
			wait( line.PostLineWait or parentLine.PostLineWait, args.ThreadName )
			if line.PostLineFunctionName ~= nil then
				CallFunctionName( line.PostLineFunctionName, source, line.PostLineFunctionArgs, args )
			end
			source.PlayingVoiceLine = nil
			if args.BreakIfPlayed then
				return playedSomething
			end
		else
			source.PlayingVoiceLine = nil
			--DebugAssert({ Condition = playedSpeechId > 0, Text = "Speech failed to play: "..line.Cue })
		end
	end

	-- Play sublines
	if line.RandomRemaining then
		local eligibleUnplayedLines = {}
		local allEligibleLines = {}
		local playFirstLine = nil
		for k, subLine in ipairs( line ) do
			
			if GameState.LastPlayedRandomLines[subLine.Cue] then
				GameState.LastPlayedRandomLines[subLine.Cue] = nil -- Block last played line once
			elseif IsVoiceLineEligible( subLine, prevLine, line, source, args ) then
				table.insert( allEligibleLines, subLine )
				if subLine.PlayFirst and not GameState.SpeechRecord[subLine.Cue] then
					playFirstLine = subLine
					DebugPrint({ Text = "PlayFirst: "..playFirstLine.Cue })
					break
				end
				if not GameState.PlayedRandomLines[subLine.Cue] then
					table.insert( eligibleUnplayedLines, subLine )
				end
			end
		end
		if not IsEmpty( allEligibleLines ) then
			local randomLine = nil
			if playFirstLine ~= nil then
				randomLine = playFirstLine
			elseif IsEmpty( eligibleUnplayedLines ) then
				-- All lines played, start the record over
				for k, subLine in ipairs( line ) do
					GameState.PlayedRandomLines[subLine.Cue] = nil
				end
				randomLine = GetRandomValue( allEligibleLines )
			else
				randomLine = GetRandomValue( eligibleUnplayedLines )
			end
			if randomLine.Cue ~= nil then
				GameState.PlayedRandomLines[randomLine.Cue] = true
				GameState.LastPlayedRandomLines[randomLine.Cue] = true
			end
			-- Effectively pass down by value rather than reference
			local subLineArgs = ShallowCopyTable( args )
			local cuePlayed = PlayVoiceLine( randomLine, prevLine, line, source, subLineArgs, originalArgs )
			if cuePlayed ~= nil then
				prevLine = randomLine
				playedSomething = cuePlayed
				args.PlayedSomething = true
				if line.PostLineFunctionName ~= nil then
					CallFunctionName( line.PostLineFunctionName, source, line.PostLineFunctionArgs, args )
				end
				if args.BreakIfPlayed or randomLine.BreakIfPlayed or subLineArgs.BreakIfPlayed then
					args.BreakIfPlayed = true
					return playedSomething
				end
			end
		end
	else
		for k, subLine in ipairs( line ) do
			if IsVoiceLineEligible( subLine, prevLine, line, source, args ) then
				-- Effectively pass down by value rather than reference
				local subLineArgs = ShallowCopyTable( args )
				local cuePlayed = PlayVoiceLine( subLine, prevLine, line, source, subLineArgs, originalArgs )
				if cuePlayed then
					prevLine = subLine
					playedSomething = cuePlayed
					args.PlayedSomething = true
					if args.BreakIfPlayed or subLine.BreakIfPlayed or subLineArgs.BreakIfPlayed then
						if line.PostLineFunctionName ~= nil then
							CallFunctionName( line.PostLineFunctionName, source, line.PostLineFunctionArgs, args )
						end
						args.BreakIfPlayed = true
						return playedSomething
					end
				end
			end
		end
		if line.PostLineFunctionName ~= nil and line.Cue == nil then
			CallFunctionName( line.PostLineFunctionName, source, line.PostLineFunctionArgs, args )
		end
	end

	return playedSomething

end

function OnLinePlayedSomething( line, source, args, originalArgs )

	if args.OnPlayedSomethingFunctionName ~= nil then
		originalArgs.PlayedSomethingFunctionNames = originalArgs.PlayedSomethingFunctionNames or {}
		if not originalArgs.PlayedSomethingFunctionNames[args.OnPlayedSomethingFunctionName] then
			originalArgs.PlayedSomethingFunctionNames[args.OnPlayedSomethingFunctionName] = true
			thread( CallFunctionName, args.OnPlayedSomethingFunctionName, source, args.OnPlayedSomethingFunctionArgs )
		end
	end

	if args.TriggerCooldowns ~= nil then
		for k, cooldownName in pairs( args.TriggerCooldowns ) do
			TriggerCooldown( cooldownName )
		end
	end
	if args.CooldownTime ~= nil then
		TriggerCooldown( line.CooldownName or line.Cue )
	end
	if args.Cooldowns ~= nil then
		for k, cooldown in pairs( args.Cooldowns ) do
			TriggerCooldown( cooldown.Name )
		end
	end
end

function GetSpeakerName( name )
	if LootData[name] ~= nil and LootData[name].SpeakerName ~= nil then
		return LootData[name].SpeakerName
	end
	if ConsumableData[name] ~= nil and ConsumableData[name].SpeakerName ~= nil then
		return ConsumableData[name].SpeakerName
	end
	if EnemyData[name] ~= nil and EnemyData[name].SpeakerName ~= nil then
		return EnemyData[name].SpeakerName
	end
	if RoomData[name] ~= nil and RoomData[name].SpeakerName ~= nil then
		return RoomData[name].SpeakerName
	end
	if HubRoomData[name] ~= nil and HubRoomData[name].SpeakerName ~= nil then
		return HubRoomData[name].SpeakerName
	end
	if EncounterData[name] ~= nil and EncounterData[name].SpeakerName ~= nil then
		return EncounterData[name].SpeakerName
	end

	return nil
end

function CleanUpCurrentSpeechId( cue, speechId, source, animation )
	if speechId == nil then
		return
	end
	waitUntil( cue )
	if animation ~= nil then
		if StopStatusAnimation( source, animation ) and not source.BlockStatusAnimations and ConfigOptionCache.ShowUIAnimations and ConfigOptionCache.ShowSpeechBubble then
			local endAnimation = animation.."_End"
			CreateAnimation({ Name = endAnimation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ })
		end
	end
	AudioState.ActiveSpeechIds[speechId] = nil
end

function PlaySpeechCue( cue, source, animation, queue, useSubtitles, subtitleColor, args )

	if cue == nil or cue == "" then
		return 0
	end

	args = args or {}

	local sourceId = nil
	if source ~= nil then
		sourceId = source.ObjectId
	end

	local speechId = PlaySpeech({ Name = cue, Id = sourceId, Queue = queue, UseSubtitles = useSubtitles, SubtitleColor = subtitleColor, Actor = args.Actor })
	if speechId > 0 then
		
		AudioState.ActiveSpeechIds[speechId] = true
		GameState.SpeechRecord[cue] = true
		CurrentRun.SpeechRecord[cue] = true

		local statusAnimSource = source
		if args.StatusAnimSourceIsHero then
			statusAnimSource = CurrentRun.Hero
		end

		if source ~= nil and source.SpeechParams ~= nil then
			for paramName, paramValue in pairs( source.SpeechParams ) do
				SetSoundCueValue({ Names = { paramName }, Id = speechId, Value = paramValue })
			end
		end

		if statusAnimSource ~= nil and animation ~= nil and ConfigOptionCache.ShowUIAnimations and ConfigOptionCache.ShowSpeechBubble then
			PlayStatusAnimation( statusAnimSource, { Animation = animation, AnimOffsetZ = source.AnimOffsetZ } )
			if statusAnimSource.SplitIds ~= nil then
				for id, v in pairs( statusAnimSource.SplitIds ) do
					local splitSource = ActiveEnemies[id]
					if splitSource ~= nil then
						PlayStatusAnimation( splitSource, { Animation = animation, AnimOffsetZ = splitSource.AnimOffsetZ } )
						SetSoundCueValue({ Names = { "Delay" }, Id = speechId, Value = 1 })
					end
				end
			end
		end
		thread( CleanUpCurrentSpeechId, cue, speechId, statusAnimSource, animation )
		if statusAnimSource ~= nil and statusAnimSource.SplitIds ~= nil then
			for id, v in pairs( statusAnimSource.SplitIds ) do
				local splitSource = ActiveEnemies[id]
				if splitSource ~= nil then
					thread( CleanUpCurrentSpeechId, cue, speechId, splitSource, animation )
				end
			end
		end

	end
	return speechId

end

function PlaySpeechCueFromSource( cue, source, queue, useSubtitles, subtitleColor, args )
	if PlayingTextLines and not args.AllowTalkOverTextLines then
		return 0
	end
	if source == nil then
		source = CurrentRun.Hero
	end
	if useDefaultAnim == nil then
        useDefaultAnim = true
    end
	local anim = args.StatusAnimation
    if anim == nil and not args.SkipAnim then
        anim = StatusAnimations.Speaking
    end
    return PlaySpeechCue( cue, source, anim, queue, useSubtitles, subtitleColor, args )
end

function GetFirstCueName( voiceLines )
	if voiceLines.Cue ~= nil then
		return voiceLines.Cue
	end
	if voiceLines[1] ~= nil then
		return "Child_"..tostring( GetFirstCueName( voiceLines[1] ) )
	end
	return nil
end

function IsVoiceLineEligible( line, prevLine, parentLine, source, args )

	if line == nil then
		return false
	end

	if verboseLogging then
		-- Hint for asserts
		line.Name = line.Name or GetFirstCueName( line )
	end

	args = args or {}

	if source ~= nil then
		if line.RequiredSourceValue ~= nil and not source[line.RequiredSourceValue] then
			return false
		end
		if line.RequiredSourceValueFalse ~= nil and source[line.RequiredSourceValueFalse] then
			return false
		end
	end

	if args ~= nil and args.ElapsedTime ~= nil then
		if line.RequiredMinElapsedTime ~= nil and args.ElapsedTime < line.RequiredMinElapsedTime then
			return false
		end
		if line.RequiredMaxElapsedTime ~= nil and args.ElapsedTime > line.RequiredMaxElapsedTime then
			return false
		end
	end

	if parentLine ~= nil and parentLine.RecheckRequirementsForSubLines then
		if parentLine.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, line, parentLine.GameStateRequirements, args ) then
			return false
		end
	end

	if line.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, line, line.GameStateRequirements, args ) then
		return false
	end

	local playOnceContext = line.PlayOnceContext or args.PlayOnceContext
	if line.PlayOnceFromTableThisRun or args.PlayOnceFromTableThisRun then
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil then
				if playOnceContext ~= nil then
					DebugPrint({ Text = "checking context = "..tostring(playOnceContext) })
					CurrentRun.SpeechRecordContexts[playOnceContext] = CurrentRun.SpeechRecordContexts[playOnceContext] or {}
					if CurrentRun.SpeechRecordContexts[playOnceContext][subLine.Cue] then
						return false
					end
				else
					if CurrentRun.SpeechRecord[subLine.Cue] then
						return false
					end
				end
			end
		end
	end

	if line.SuccessiveChanceToPlay ~= nil then
		local anyLinePlayed = false
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil and GameState.SpeechRecord[subLine.Cue] then
				anyLinePlayed = true
				break
			end
		end
		if anyLinePlayed and not RandomChance( line.SuccessiveChanceToPlay ) then
			return false
		end
	end

	if line.SuccessiveChanceToPlayAll ~= nil then
		local allLinesPlayed = true
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil and not GameState.SpeechRecord[subLine.Cue] then
				allLinesPlayed = false
				break
			end
		end
		if allLinesPlayed and not RandomChance( line.SuccessiveChanceToPlayAll ) then
			return false
		end
	end

	if line.Cue ~= nil then

		if line.PlayOnce or ( parentLine ~= nil and parentLine.PlayOnce ) then
			if playOnceContext ~= nil then
				DebugPrint({ Text = "checking context = "..tostring(playOnceContext) })
				GameState.SpeechRecordContexts[playOnceContext] = GameState.SpeechRecordContexts[playOnceContext] or {}
				if GameState.SpeechRecordContexts[playOnceContext][line.Cue] then
					return false
				end
			elseif GameState.SpeechRecord[line.Cue] then
				return false
			end
		end

		if line.PlayOnceThisRun or ( parentLine ~= nil and parentLine.PlayOnceThisRun ) then
			if CurrentRun.SpeechRecord[line.Cue] then
				return false
			end
		end

		local chanceToPlayAgain = line.ChanceToPlayAgain or ( parentLine ~= nil and parentLine.ChanceToPlayAgain )
		if chanceToPlayAgain and GameState.SpeechRecord[line.Cue] and not RandomChance( chanceToPlayAgain ) then
			return false
		end

	end

	if line.CooldownTime ~= nil then
		local cooldownName = line.CooldownName
		if cooldownName == nil and line[1] ~= nil then
			cooldownName = line[1].CooldownName or line[1].Cue
		end
		if cooldownName ~= nil and not CheckCooldownNoTrigger( cooldownName, line.CooldownTime ) then
			DebugPrint({ Text = "VO "..tostring(GetFirstCueName(line)).." blocked from cooldown: "..tostring(cooldownName) })
			return false
		end
	end
	if line.Cooldowns ~= nil then
		for k, cooldown in pairs( line.Cooldowns ) do
			local cooldownTime = cooldown.Time or line.CooldownTime
			if cooldownTime == nil and source ~= nil then
				cooldownTime = source.SpeechCooldownTime or CurrentRun.Hero.SpeechCooldownTime
			end
			if not CheckCooldownNoTrigger( cooldown.Name, cooldownTime ) then
				DebugPrint({ Text = "VO "..tostring(GetFirstCueName(line)).." blocked from cooldown: "..tostring(cooldown.Name) })
				return false
			end
		end
	end

	if args.RequiresSourceAlive then
		if source == nil or source.IsDead then
			return false
		end
	end

	return true

end

function MusicSetTrackOffset( trackData, args )
	SetSoundPosition({ Id = AudioState.MusicId, Position = args.TrackOffset or RandomFloat( args.TrackOffsetMin, args.TrackOffsetMax ) })
end


function WaitForSpeechFinished()
	while not IsEmpty( SessionMapState.PlayingCues ) do
		local firstCue = GetFirstKey( SessionMapState.PlayingCues )
		waitUntil( firstCue )
		wait( 0.02 )
	end
end

OnMusicMarker{
	function( triggerArgs )
		local markerName = triggerArgs.name
		local markerData = MusicMarkerData[markerName]
		if markerData ~= nil and markerData.FunctionName ~= nil then
			CallFunctionName( markerData.FunctionName, markerData, markerData.FunctionArgs )
		end
	end
}

