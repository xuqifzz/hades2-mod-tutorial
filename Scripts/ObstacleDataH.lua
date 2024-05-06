-- Fields
OverwriteTableKeys( ObstacleData, {
	FieldsExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 145,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		LockedUseSound = "/Leftovers/World Sounds/CaravanBumpHard",
		CannotUseText = "ExitBlockedByFieldsLoot",
		BlockedByMultipleRequiredObjectsText = "ExitBlockedByFieldsLoot",

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollFieldsDoor",

		UnlockedAnimation = "FieldsExitDoorUnlocked",
		ExitDoorOpenAnimation = "FieldsExitDoorUsed",
		ExitDoorCloseAnimation = "Blank",

		CannotBeBlockedByEnemies = true,

		DistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				{
					PlayOnce = true,
					PlayOnceFromTableThisRun = true,
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
						{
							Path = { "GameState", "RoomCountCache", "H_Intro", },
							Comparison = "<=",
							Value = 3,
						},
						{
							PathFromArgs = true,
							Path = { "TriggerSource", "Room", "CageRewards" },
							UseLength = true,
							Comparison = ">=",
							Value = 2,
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeFieldsStartSpeech", Time = 8 },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

					{ Cue = "/VO/MelinoeField_2114", Text = "That's more than usual...", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2115", Text = "More to discover...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BiomeDepthCache" },
								Comparison = "<=",
								Value = 3,
							},
						},
					},
				}
			}
		},

		ExitBlockedVoiceLines =
		{
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.5,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
						{
							PathEmpty = { "MapState", "AggroedUnits" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsNone = { "H_Intro", "H_Bridge01", "H_MiniBoss01", "H_MiniBoss02", "H_PreBoss01" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeFieldsRewardHintSpeech", Time = 10 },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

					{ Cue = "/VO/MelinoeField_1076", Text = "Still prizes to be claimed.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_1077", Text = "There's more to find here still." },
					{ Cue = "/VO/MelinoeField_1078", Text = "I've prizes left to claim.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_1079", Text = "I've more rewards to find." },
					{ Cue = "/VO/MelinoeField_1080", Text = "Still Boons and such to find.", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_1081", Text = "Not leaving here just yet." },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.5,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_0856", Text = "Not letting me past." },
					{ Cue = "/VO/MelinoeField_0857", Text = "Have to find some way to draw them out." },
					{ Cue = "/VO/MelinoeField_0858", Text = "They're blocking my path..." },
					{ Cue = "/VO/MelinoeField_0859", Text = "Can't get out yet...!" },
				},
			},
		},

	},

	FieldsStatueHead02 =
	{
		DistanceTrigger =
		{
			PreTriggerWait = 1.0,
			GameStateRequirements =
			{
				-- None
			},
			WithinDistance = 750,
			VoiceLines =
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.2,

				{ Cue = "/VO/MelinoeField_1246", Text = "It's watching me...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1247", Text = "Can you see me in there?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1246" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1251", Text = "I see you, too, Statue.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1247" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1248", Text = "Nice seeing you again!" },
				{ Cue = "/VO/MelinoeField_1249", Text = "Hello, Gigantic Severed Head." },
				{ Cue = "/VO/MelinoeField_1250", Text = "See anything good lately?" },
			}
		},
	},

	FieldsBossExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 145,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "FieldsBossDoorOpen",
		--ExitDoorOpenAnimation = "FieldsExitDoorUsed",
		--ExitDoorCloseAnimation = "Blank",
	},

	FieldsTerrainGoldenLeaves01a =
	{
		DistanceTrigger =
		{
			WithinDistance = 300,
			VoiceLines =
			{
				{
					PreLineWait = 0.65,
					PlayOnceFromTableThisRun = true,
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
						{
							PathEmpty = { "MapState", "AggroedUnits" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsNone =
								{
									"H_Intro",
									"H_Combat02",
									"H_Combat09",
									"H_Combat13",
									"H_Combat14",
									"H_Combat15",
									"H_Combat16",
									"H_Bridge01",
									"H_MiniBoss01",
									"H_MiniBoss02",
									"H_PreBoss01"
								},
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "UseRecord", "FieldsRewardFinder" },
						},
						{
							Path = { "MapState", "RoomRequiredObjects" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "GameState", "FieldsRewardFindersActivated" },
							Comparison = "<=",
							Value = 12,
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelFieldsMusingVoiceLines", Time = 180 },
					},

					{ Cue = "/VO/MelinoeField_1057", Text = "{#Emph}Look for the golden petals on the ground..." },
					{ Cue = "/VO/MelinoeField_1058", Text = "{#Emph}A path of golden petals shall guide you..." },
					{ Cue = "/VO/MelinoeField_1059", Text = "{#Emph}Follow the golden petal path..." },
					{ Cue = "/VO/MelinoeField_1060", Text = "Petals from a golden bough..." },
				},
			},
		},
	},

	H_PostBossDoor =
	{
		InheritFrom = { "ExitDoor" },
		HideRewardPreview = true,
		HideUseIfLocked = true,
		ExitThroughCenter = true,

		AllowReroll = false,

		UnlockedUseText = "UseTartarusHallDoor",
		UnlockedUseTextCannotReroll = "UseTartarusHallDoor",
		
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",
		UnlockedAnimation = "CWEntranceDoorGlow",

		ExitFunctionName = "LeaveRoomHPostBossPresentation",
		ExitFunctionArgs =
		{
			FirstVisitRequirements =
			{
				{
					PathFalse = { "GameState", "RoomCountCache", "H_PostBoss01" },
				},
			},
			MoveTargetId = 430007,
		},
	},

	FieldsRewardCage =
	{
		OnUsedFunctionName = "StartFieldsEncounter",
		LegalEncounters = EncounterSets.HEncountersDefault,
		UseText = "UseEncounterCost",
		OnUsedAnimation = "CorruptionCageAgitated",
		UnlockedAnimation = "CorruptionCageDepleted",

		DistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					PlayOnce = true,
					PlayOnceContext = "RewardCageIntro",

					{ Cue = "/VO/MelinoeField_0886", Text = "What {#Emph}is {#Prev}that...?" },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "FieldsRewardLocatedVO",
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.2,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "RoomsEntered", "F_Opening03" },
							Comparison = "<=",
							Value = 4,
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelinoeFieldsRewardFoundSpeech", Time = 240 },
					},

					{ Cue = "/VO/MelinoeField_0887", Text = "Shall I take it...?", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_0888", Text = "There's one..." },
					{ Cue = "/VO/MelinoeField_0889", Text = "Something for me..." },
				},
			},
		},
	},

	FieldsRewardFinder =
	{
		OnUsedGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFieldsRewardFinder" },
			},
		},
		UseText = "UseFinderObject",
		UseIneligibleText = "CannotUseObject",
		OnUsedFunctionName = "UseFieldsRewardFinder",
		OnUsedFunctionArgs = { Interval = 0.4 },
		OnUsedPresentationFunctionName = "UseFieldsRewardFinderPresentation",
		UseAnimation = "FieldsRewardFinderTransition",
		-- UseSound = "/SFX/BatFullScreenSFX",
		OnUsedFailedPresentation = "CannotUseFieldsRewardFinderPresentation",

		DistanceTrigger =
		{
			WithinDistance = 650,
			VoiceLines =
			{
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.2,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
						{
							PathEmpty = { "MapState", "AggroedUnits" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeFieldsRewardFinderSpeech", Time = 300 },
						{ Name = "MelinoeBoughSpeech", Time = 6 },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech",  },

					{ Cue = "/VO/MelinoeField_0826", Text = "A withered bough...", PlayOnceThisRun = true, },
					{ Cue = "/VO/MelinoeField_0827", Text = "Should be able to revive that bough...", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFieldsRewardFinder" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1065", Text = "A golden bough...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FieldsRewardFindersActivated" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1066", Text = "There's the bough...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FieldsRewardFindersActivated" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1067", Text = "The bough...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FieldsRewardFindersActivated" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1068", Text = "Found the bough...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FieldsRewardFindersActivated" },
							},
						},
					},

				},
			},
		},
	},

	FieldsDestructiblePillar01 =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "FieldsDestructiblePillar01B",
			RequiredHitsForImpactReaction = 3,
			SwapData = "FieldsDestructiblePillar01A",
		},
	},

	FieldsDestructiblePillar01A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "FieldsDestructiblePillar01Destroyed",
			RequiredHitsForImpactReaction = 4,
			SwapData = "FieldsDestructiblePillar01B",
			-- GlobalVoiceLines = "BreakingStuffVoiceLines",

			FireProjectileData =
			{
				ProjectileName = "FieldsDestructiblePillarDestruction",
				FireAsPlayerProjectile = true,
				FireProjectileAtSelf = true,
				FireFromTarget = true,
			},
		},
	},

	FieldsDestructiblePillar01B =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	MiasmaGeyser =
	{
		DistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				{
					PlayOnceFromTableThisRun = true,
					UsePlayerSource = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.05,
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
					{ Cue = "/VO/MelinoeField_0866", Text = "Miasma...", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_0867", Text = "More Miasma..." },
				},
			},
		},
	},

	H_TallGrass =
	{
		InheritFrom = { "BaseDestructible" },
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15, },

		MaxHealth = 3,

		SpawnObstaclesOnDeath =
		{
			{ Name = "H_TallGrassBase", GroupName = "Terrain01" },
		},
		CanCatchFire = true,
		CanSpreadFire = true,
		OnDeathFunctionName = "SpreadBrushFire",
	},

	WheatClusterC =
	{
		InheritFrom = { "BaseDestructible" },
		ExclusiveOnHitFunctionName = "WheatHit",
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15, },
		DeathFx = "WheatClusterDestruction",
		--CanCatchFire = true,
		--CanSpreadFire = true,
		--OnDeathFunctionName = "SpreadBrushFire",

		SpawnObstaclesOnDeath =
		{
			{ Name = "H_TallGrassBase", GroupName = "Terrain_CutWheat" },
		},
	},

	WheatClusterC_Light =
	{
		InheritFrom = { "WheatClusterC" },
	},

	WheatClusterC_LightB =
	{
		InheritFrom = { "WheatClusterC" },
	},

	WheatClusterC_Lines =
	{
		InheritFrom = { "WheatClusterC" },
	},

	H_GhostWall =
	{	
		DistanceTriggers =
		{
			{
				PreTriggerWait = 2.0,
				--PreTriggerAnimation = "GhostWallFadeOut",
				PreTriggerAlpha = 0.0,
				PreTriggerAlphaDuration = 0.0,
				OnRepeatAlpha = 0.0,
				OnRepeatAlphaDuration = 0.5,
				WithinDistance = 650,
				LeaveDistanceBuffer = 100,
				Repeat = true,
				--PostTriggerAnimation = "GhostWallFadeIn",
				PostTriggerAlpha = 1.0,
				PostTriggerAlphaDuration = 0.5,
			},
		},
		CollisionReactions =
		{
			{
				FunctionName = "SlingshotRepulse",
				ApplyEffects = { EffectData.GhostWallHalt },
			}
		}
	},

	H_GhostWall_Sparse =
	{	
		DistanceTriggers =
		{
			{
				PreTriggerWait = 2.0,
				PreTriggerAlpha = 0.0,
				PreTriggerAlphaDuration = 0.0,
				OnRepeatAlpha = 0.0,
				OnRepeatAlphaDuration = 0.5,
				WithinDistance = 650,
				LeaveDistanceBuffer = 100,
				Repeat = true,
				PostTriggerAlpha = 1.0,
				PostTriggerAlphaDuration = 0.5,
			},
		},
		CollisionReactions =
		{
			{
				FunctionName = "SlingshotRepulse",
				ApplyEffects = { EffectData.GhostWallHalt },
			}
		}
	},

	ShadeFieldsGreyIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeFieldsRedIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	FieldsStatueHead01Eyeball =
	{
		SetupEvents =
		{
			{
				Threaded = true,
				FunctionName = "TrackPlayer",
				Args =
				{
					RandomIntervalMin = 0.05,
					RandomIntervalMax = 0.75,
					Duration = 0.1,
					EaseIn = 0.5,
					EaseOut = 0.5,
					SetBase = true,
					FollowFlips = true
				},
			}
		},
	},

	FieldsStatueHead02Eyeball =
	{
		InheritFrom = { "FieldsStatueHead01Eyeball" },
	},
})