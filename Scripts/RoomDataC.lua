RoomSetData.C =
{
	C_Boss01 =
	{
		ValidateSecretData = false,
		RichPresence = "#RichPresence_Boss",

		BackupCauseOfDeath = "Zagreus",
		LegalEncounters =
		{
			"BossZagreus01",
		},

		ForcedReward = "GemPointsBigDrop",
  
		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		SecretSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.0,

		ZoomFraction = 0.9,
		IntroSequenceDuration = 0.65,

		FlipHorizontalChance = 0.0,
		EntranceDirection = "LeftRight",

		SecretMusic = "/Music/BlankMusicCue",
		NextRoomResumeMusic = true,

		LocationText = "Location_BiomeC",
		SaveProfileLocationText = "Location_BiomeC",
		ResultText = "RunHistoryScreenResult_Elysium",
		PauseBiomeState = true,

		EntranceFunctionName = "RoomEntranceCBossPresentation",
		EntranceFunctionArgs = { InputBlockReleaseDelay = 4.0 },
		BlockCameraReattach = true,
		ExitFunctionName = "AnomalyExitPresentation",
		NextRoomEntranceFunctionName = "EntranceFromAnomalyPresentation",
		NextRoomEntranceFunctionArgs = { ReturningFromElysium = true },
		EntranceAnimation = "MelinoeSpellFire",
		EntranceVfx = "SecretDoorDiveFx",
		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
		LocationAnimName = "InfoBannerElysiumIn",
		LocationAnimOutName = "InfoBannerElysiumOut",
		UsePreviousRoomSet = true,
		SkipTimedDropResources = true,
		IneligibleRewards = { "Devotion", "SpellDrop" },

		StartUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Zagreus" },
				},
			},
		},

		Ambience = "/Ambience/TheseusCrowdAmbientLoop",
		ReverbValue = 2.0,
		GlobalEcho = 0.35,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 543855 },
					SetupBossIds = { 543855 },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
				},
			},
		},

		ObstacleData =
		{
			-- Supportive Shade / -- DieHardFan
			[543023] =
			{
				Name = "DieHardFanShade",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SorryButNoNotAtThisTime" },
					},
				},
				DestroyIfNotSetup = true,
				InteractDistance = 200,
				DistanceTriggers =
				{
					{
						WithinDistance = 850,
						ChanceToPlay = 0.25,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "EnemyKills", "Zagreus" },
							},
						},
						Args =
						{
							TargetId = 543023,
							AnimationName = "StatusIconSmileRed",
							OffsetZ = 58,
						},
					},
				},
			},

			Using = { Sound = "/SFX/TheseusCrowdBoo", },
		},

		InspectPoints =
		{
			[801524] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_C_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0503",
							Text = "{#Emph}The stunned and elated onlookers of Elysium gaze upon this seldom seen Princess having heard only the terrifying rumors of her fury; and paid witness to it all, firsthand." },
						EndVoiceLines =
						{
							PreLineWait = 0.38,
							UsePlayerSource = true,
							{ Cue = "/VO/MelinoeField_4473", Text = "{#Emph}Raaaahh!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconFear", "StatusIconGrief", "StatusIconEmbarrassed" }, ReactionChance = 0.25 },
							},
						},
					},
				},
			},
			[801525] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_C_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0504",
							Text = "{#Emph}The long-absent Underworld Prince, no stranger to many an ignoble defeat, has suffered yet another utterly humiliating loss, and at the hands of his own sister no less." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/MelinoeField_4474", Text = "Hey, give him a break!" },
						},
					},
				},
			},

		},

	},
}
AddTableKeysCheckDupes( RoomData, RoomSetData.C )