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

-- @ refactor with proper data setup
function SingingPresentationScylla()
	for enemyId, enemy in pairs( ActiveEnemies ) do
		CreateAnimation({ Name = "StatusSinging", DestinationId = enemyId, OffsetX = 30, OffsetZ = 200, Group = "Combat_UI_World" })
	end
end

function SingingPresentation( source, args )
	if source.SingingFx ~= nil then
		CreateAnimation({ Name = source.SingingFx, DestinationId = source.ObjectId, OffsetX = source.SingingAnimOffsetX or source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end
	if source.SingingAnimation ~= nil then
		SetAnimation({ Name = source.SingingAnimation, DestinationId = source.ObjectId })
	end
	if source.PartnerSingingAnimation ~= nil and source.PartnerObjectId ~= nil then
		SetAnimation({ Name = source.PartnerSingingAnimation, DestinationId = source.PartnerObjectId })
	end
end

function RandomStemMixer( currentRoom, musicId )
	if musicId == nil then
		return
	end
	local roomData = RoomData[currentRoom.Name]
	if roomData.IgnoreStemMixer or currentRoom.TimesVisited >= 2 then
		return
	end
	local musicSetup = RandomInt( 1, roomData.RandomStemMixerOptions or 3 )
	if musicSetup == 1 then
		-- guitar, bass, drums
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	elseif musicSetup == 2 then
		-- drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	elseif musicSetup == 3 then
		-- bass and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	else
		-- guitar and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = roomData.RandomStemMixerBass or 0, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	end
end

function AmbientChatting( source, args )
	if args.StartDistance ~= nil then
		local notifyName = "StartDistance"..source.Name
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.StartDistance, Notify = notifyName })
		waitUntil( notifyName )
	end
	thread( CheckDistanceTrigger, args.DistanceTrigger, source )
	PlayVoiceLines( args.VoiceLines, nil, source )
	wait( 1.5 )
end