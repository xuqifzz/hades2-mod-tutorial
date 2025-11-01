MusicTrackData =
{
	F =
	{
		{ Name = "/Music/IrisMusicExploration2_MC" },
		{ Name = "/Music/IrisMusicExploration1_MC" },
		{ Name = "/Music/IrisMusicErebus2_MC" },
	},
	G =
	{
		{
			Name = "/Music/IrisMusicScylla1_MC",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "Scylla2UnlockedAndUnplayed", "ScyllaEMActiveAndNotCleared", "ScyllaBalladForced" },
			},
			TrackStartEvents =
			{
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "BiomeMusicPlayCounts", "G" },
							Modulo = 4,
							Comparison = "==",
							Value = 2,
						},
					},
					FunctionName = "MusicSetTrackOffset",
					Args =
					{
						TrackOffset = 34.194,
					},
					FailedFunctionName = "SetPathValue",
					FailedFunctionArgs =
					{
						TablePath = { "SessionMapState", },
						Key = "Humming",
						Value = true
					},
				},
			},
		},
		{
			Name = "/Music/IrisMusicScylla2_MC",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "G_PostBoss01" },
				},
				NamedRequirementsFalse = { "ScyllaEMActiveAndNotCleared", "ScyllaBalladForced" },
			},
			TrackStartEvents =
			{
				{
					GameStateRequirements =
					{
						{
							Path = { "GameState", "BiomeMusicPlayCounts", "G" },
							Modulo = 4,
							Comparison = "==",
							Value = 3,
						},
					},
					FunctionName = "MusicSetTrackOffset",
					Args =
					{
						TrackOffset = 28.168,
					},
					FailedFunctionName = "SetPathValue",
					FailedFunctionArgs =
					{
						TablePath = { "SessionMapState", },
						Key = "Humming",
						Value = true
					},
				},
			},
		},
		{
			Name = "/Music/IrisMusicScylla3_MC",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "ScyllaBalladForced" },
				OrRequirements =
				{
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 2,
						},
					},
					{
						{
							Path = { "GameState", "EncountersCompletedCache" },
							HasAll = { "BossScylla02" },
						},
					},
				},
			},
		},
		{
			Name = "/Music/IrisMusicScylla4_MC",
			GameStateRequirements =
			{
				NamedRequirements = { "ScyllaBalladUnlocked" },
				NamedRequirementsFalse = { "ScyllaEMActiveAndNotCleared" },
			},
		},
	},
	H =
	{
		{ Name = "/Music/IrisMusicMourningFields1_MC" },
		{ Name = "/Music/IrisMusicMourningFields2_MC" },
	},
	I =
	{
		{ Name = "/Music/IrisMusicClockworkTartarus_MC" },
	},
	N =
	{
		{ Name = "/Music/IrisMusicFilthyArp_MC" },
		{ Name = "/Music/IrisMusicEphyra2_MC" },
		{ Name = "/Music/IrisMusicEphyra3_MC" },
	},
	O =
	{
		{ Name = "/Music/IrisMusicShips1_MC" },
		{ Name = "/Music/IrisMusicShips2_MC" },
	},
	P =
	{
		{
			Name = "/Music/IrisMusicOlympus1_MC",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "OlympusMusic1PlayedLast" },
				{
					PathFalse = { "CurrentRun", "MusicRecord", "/Music/IrisMusicOlympus1_MC" },
				}
			},
		},
		{
			Name = "/Music/IrisMusicOlympus2_MC",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "OlympusMusic2PlayedLast" },
				{
					PathFalse = { "CurrentRun", "MusicRecord", "/Music/IrisMusicOlympus2_MC" },
				}
			},
		},
	},
	Q =
	{
		{
			Name = "/Music/IrisMusicTyphon1_MC",
		},
	},
}

RoomStartMusicEvents =
{
	-- Underworld Run
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = "==",
				Value = 2,
			},
			{
				-- Actually started in Erebus, not faked from a Bounty
				Path = { "CurrentRun", "RoomsEntered" },
				HasAny = { "F_Opening01", "F_Opening02", "F_Opening03", },
			},
		},
		MusicSection = 2,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = "==",
				Value = 3,
			},
			{
				-- Actually started in Erebus, not faked from a Bounty
				Path = { "CurrentRun", "RoomsEntered" },
				HasAny = { "F_Opening01", "F_Opening02", "F_Opening03", },
			},
		},
		MusicSection = 3,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "RunDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "Styx", "G", },
			},
			{
				Path = { "AudioState", "MusicSection", },
				Comparison = "==",
				Value = 0,
			},
			{
				FunctionName = "RequiredMusicSectionRoomDuration",
				FunctionArgs = { Value = 2 },
			},
		},
		MusicSection = 1,
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				PathFalse = { "AudioState", "MusicId" },
			},
			{
				PathFalse = { "AudioState", "SecretMusicId" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Intro", "H_Intro", "I_Intro", "G_Reprieve01", "H_Reprieve01", "I_Reprieve01", "I_PreBoss01", "I_PreBoss02", "I_Boss01", },
			},
		},
		PlayBiomeMusic = true,
		MusicSection = 0,
		UseRoomMusicSection = true,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "BossHecateMissing" },
			},
		},
		EndMusic = true,
		EndMusicArgs =
		{
			Duration = 0.2,
			IgnoreSection = true,
		},
	},
	-- Oceanus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01", },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		MusicActiveStems = { "Vocals" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
			},
		},
		MusicSection = 0,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "AudioState", "MusicSection", },
				Comparison = "==",
				Value = 0,
			},
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "BiomeMusicPlayCounts", "G" },
						Modulo = 4,
						Comparison = "<=",
						Value = 1,
					},
				},
				{
					-- force Scylla4 lyrics until you have the ballad conversation
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla4_MC" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutBallad01" },
					},
				},
			},
		},
		MusicSection = 1,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "G" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "GameState", "BiomeMusicPlayCounts", "G" },
				Modulo = 4,
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "AudioState", "MusicSection", },
				Comparison = "==",
				Value = 0,
			},
			-- { FunctionName = "RequiredMusicSectionRoomDuration", FunctionArgs = { Value = 2 }, },
		},
		MusicSection = 3,
	},
	-- Fields
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "H" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "==",
				Value = 2,
			},
			{
				Path = { "AudioState", "MusicSection" },
				Comparison = "==",
				Value = 0,
			},
		},
		MusicSection = 1,
	},
	-- Tartarus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", "I_MiniBoss02" },
			},
		},
		FunctionName = "GenericPresentation",
		FunctionArgs =
		{
			SetSoundCueValues =
			{
				{
					Name = "Miniboss",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.75,
				}
			},
		},
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "I", },
			},
			{
				Path = { "CurrentRun", "RemainingClockworkGoals", },
				Comparison = "<=",
				Value = 1,
			},
		},
		MusicActiveStems = { "Guitar", "Drums", "Bass", },
	},

	-- Surface Run
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				PathFalse = { "AudioState", "MusicId" },
			},
			{
				PathFalse = { "AudioState", "SecretMusicId" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Intro", },
			},
		},
		PlayBiomeMusic = true,
		MusicSection = 0,
		UseRoomMusicSection = true,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Hub" },
			},
			{
				Path = { "AudioState", "MusicSection", },
				Comparison = "==",
				Value = 0,
			},
		},
		MusicSection = 1,
		UseRoomMusicSection = true,
	},
	-- Typhon
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Q" },
			},
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},
		MusicActiveStems = { "Guitar" },
		MusicMutedStems = { "Bass" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Q" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss04", "Q_MiniBoss05" },
			},
		},
		MusicActiveStems = { "Bass" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Intro" },
			},
		},
		MusicMutedStems = { "Guitar", "Bass" },
		MusicMutedStemsDuration = 0,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_MiniBoss03", "Q_Boss01", "Q_Boss02" },
			},
		},
		MusicMutedStems = { "Guitar", "Bass" },
	},
}

CombatOverMusicEvents =
{
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RunDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "AudioState", "MusicName", },
				IsAny = { "/Music/MusicRunstart_MC", },
			},
		},
		EndMusic = true,
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "AudioState", "MusicName", },
				IsAny = { "/Music/IrisMusicBiomeStartOlympus_MC", },
			},
		},
		EndMusic = true,
		EndMusicArgs =
		{
			Duration = 5.0,
			IgnoreSection = true,
		},
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "AudioState", "MusicName", },
				IsNone = { "/Music/IrisMusicTyphon1_MC", },
			},
		},
		MusicMutedStems = { "Drums", },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", "I_MiniBoss02" },
			},
		},
		FunctionName = "GenericPresentation",
		FunctionArgs =
		{
			SetSoundCueValues =
			{
				{
					Name = "Miniboss",
					Value = 0.0,
					AudioStateId = "MusicId",
					Duration = 0.75,
				}
			},
		},
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "AudioState", "MusicName", },
				IsAny = { "/Music/IrisMusicTyphon1_MC", },
			},
		},
		MusicMutedStems = { "Guitar", "Bass" },
	},
}

MusicMarkerData =
{
	HummingStart =
	{
		FunctionName = "SetPathValue",
		FunctionArgs =
		{
			TablePath = { "SessionMapState", },
			Key = "Humming",
			Value = true
		},
	},

	HummingStop =
	{
		FunctionName = "SetPathValue",
		FunctionArgs =
		{
			TablePath = { "SessionMapState", },
			Key = "Humming",
			Value = false,
		},
	},

	Lights =
	{
		FunctionName = "FlashRoomLights",
		IsLyric = false,
	},

	Fire =
	{
		FunctionName = "FlashRoomFire",
		FunctionArgs =
		{
			Sound = "/SFX/ScyllaVenuePyroLoop",
		},
		IsLyric = false,
	},

	Charybdis_Scylla3_01 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_01" },
		IsLyric = false,
	},

	Charybdis_Scylla3_02 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_02" },
		IsLyric = false,
	},

	Charybdis_Scylla3_03 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_03" },
		IsLyric = false,
	},

	Charybdis_Scylla3_04 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_04" },
		IsLyric = false,
	},

	Charybdis_Scylla3_05 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_05" },
		IsLyric = false,
	},

	Charybdis_Scylla3_06 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_06" },
		IsLyric = false,
	},

	Charybdis_Scylla3_07 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_07" },
		IsLyric = false,
	},

	Charybdis_Scylla3_08 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_08" },
		IsLyric = false,
	},

	Charybdis_Scylla3_09 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_09" },
		IsLyric = false,
	},

	Charybdis_Scylla3_10 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_10" },
		IsLyric = false,
	},

	Charybdis_Scylla3_11 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_11" },
		IsLyric = false,
	},

	Charybdis_Scylla3_12 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_12" },
		IsLyric = false,
	},

	Charybdis_Scylla3_13 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_13" },
		IsLyric = false,
	},

	Charybdis_Scylla3_14 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_14" },
		IsLyric = false,
	},

	Charybdis_Scylla3_15 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_15" },
		IsLyric = false,
	},

	Charybdis_Scylla3_16 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla3_16" },
		IsLyric = false,
	},
	Charybdis_Scylla1_01 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_01" },
		IsLyric = false,
	},

	Charybdis_Scylla1_02 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_02" },
		IsLyric = false,
	},

	Charybdis_Scylla1_03 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_03" },
		IsLyric = false,
	},

	Charybdis_Scylla1_04 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_04" },
		IsLyric = false,
	},

	Charybdis_Scylla1_05 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_05" },
		IsLyric = false,
	},

	Charybdis_Scylla1_06 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_06" },
		IsLyric = false,
	},

	Charybdis_Scylla1_07 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_07" },
		IsLyric = false,
	},

	Charybdis_Scylla1_08 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_08" },
		IsLyric = false,
	},

	Charybdis_Scylla1_09 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_09" },
		IsLyric = false,
	},

	Charybdis_Scylla1_10 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_10" },
		IsLyric = false,
	},

	Charybdis_Scylla1_11 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_11" },
		IsLyric = false,
	},

	Charybdis_Scylla1_12 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_12" },
		IsLyric = false,
	},

	Charybdis_Scylla1_13 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_13" },
		IsLyric = false,
	},

	Charybdis_Scylla1_14 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_14" },
		IsLyric = false,
	},

	Charybdis_Scylla1_15 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_15" },
		IsLyric = false,
	},

	Charybdis_Scylla1_16 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_16" },
		IsLyric = false,
	},
	
	Charybdis_Scylla1_17 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_17" },
		IsLyric = false,
	},
	
	Charybdis_Scylla1_18 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_18" },
		IsLyric = false,
	},

	Charybdis_Scylla1_19 =
	{
		FunctionName = "CharybdisGrowl",
		FunctionArgs = { Sound = "/SFX/Enemy Sounds/Charybdis/Charybdis_Scylla1_19" },
		IsLyric = false,
	},

	-- Artemis and Apollo solos for IrisEndTheme

	IrisEndTheme_001 =
	{
		SubtitlesBColor = Color.ApolloVoice,
	},
	IrisEndTheme_002 =
	{
		SubtitlesBColor = Color.ApolloVoice,
	},
	IrisEndTheme_003 =
	{
		SubtitlesBColor = Color.ApolloVoice,
	},
	IrisEndTheme_004 =
	{
		SubtitlesBColor = Color.ApolloVoice,
	},

	IrisEndTheme_015 =
	{
		SubtitlesBColor = Color.ArtemisVoice,
	},
	IrisEndTheme_016 =
	{
		SubtitlesBColor = Color.ArtemisVoice,
	},
	IrisEndTheme_017 =
	{
		SubtitlesBColor = Color.ArtemisVoice,
	},
	IrisEndTheme_018 =
	{
		SubtitlesBColor = Color.ArtemisVoice,
	},
}