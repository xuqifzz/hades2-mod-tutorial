function StartBossRoomMusic()
	local roomData = RoomData[CurrentRun.CurrentRoom.Name]
	SetMusicSection( 2 )
	SetSoundCueValue({ Names = roomData.DefaultMusicParams or { "Guitar", "Bass", "Drums" }, Id = AudioState.MusicId, Value = 1, Duration = 0.75 })
end

function StartHeraclesEncounterMusic()

	-- SetSoundCueValue({ Names = { "Section" }, Id = AudioState.SecretMusicId, Value = 2 })

end

function ChaosBassStart()
	SetSoundCueValue({ Names = { "ChaosBass" }, Id = AudioState.SecretMusicId, Value = 1, Duration = 0.5 })
end
function ChaosBassStop()
	SetSoundCueValue({ Names = { "ChaosBass" }, Id = AudioState.SecretMusicId, Value = 0, Duration = 3 })
end

function RandomStemMixer( currentRoom, musicId )
	if musicId == nil then
		return
	end
	local roomData = RoomData[currentRoom.Name] or currentRoom
	if roomData.IgnoreStemMixer or currentRoom.TimesVisited >= (roomData.RandomStemMixerTimesVisitedLimit or 2) then
		return
	end
	if roomData.RandomStemMixerValues ~= nil then
		local randomValue = GetRandomValue( roomData.RandomStemMixerValues )
		for i, paramData in ipairs( randomValue.SetSoundCueValues ) do
			SetSoundCueValue({ Names = { paramData.Name, }, Id = musicId, Value = paramData.Value, Duration = paramData.Duration })
		end
		return
	end
	local musicSetup = RandomInt( 1, roomData.RandomStemMixerOptions or 3 )
	if musicSetup == 1 then
		-- guitar, bass, drums
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 1, Duration = 2.5 })
	elseif musicSetup == 2 then
		-- drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 0, Duration = 10 })
	elseif musicSetup == 3 then
		-- bass and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 1, Duration = 2.5 })
	else
		-- guitar and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 0, Duration = 2.5 })
	end
	SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
end

function AmbientChatting( source, args )
	args = args or {}
	if args.StartDistance ~= nil then
		local notifyName = "StartDistance"..source.Name
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.StartDistance, Notify = notifyName })
		waitUntil( notifyName )
	end
	thread( CheckDistanceTrigger, args.DistanceTrigger, source )
	PlayVoiceLines( args.VoiceLines, nil, source )
	wait( 1.5 )
end

function ArtemisStartSingingPresentation( source )
	if CurrentRun.SuppressAmbientMusic == "Artemis" then
		return
	end
	CreateAnimation({ Name = "StatusSinging", DestinationId = source.ObjectId, OffsetX = -55, OffsetY = -150, OffsetZ = 128 })
	SetAnimation({ Name = "Artemis_Singing_Start", DestinationId = source.ObjectId })
	SetSoundCueValue({ Name = "Vocals", Id = AudioState.AmbientMusicId, Value = CurrentHubRoom.AmbientMusicParams.Vocals, Duration = 0.5 })
end

function ArtemisStopSingingPresentation( source )
	StopAnimation({ DestinationId = source.ObjectId, Name = "StatusSinging" })
	SetAnimation({ Name = "Artemis_Singing_End", DestinationId = source.ObjectId })
	SetSoundCueValue({ Name = "Vocals", Id = AudioState.AmbientMusicId, Value = 0.0, Duration = 0.0 })
end
