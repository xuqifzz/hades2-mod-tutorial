-- CWTartarus
OverwriteTableKeys( ObstacleData, {
	CWTartarusExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 140,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "CWTartarusExitDoorUnlocked",
		ExitDoorOpenAnimation = "CWTartarusExitDoorOpen",
		ExitDoorCloseAnimation = "CWTartarusExitDoorClose",
	},
	
	ChronosBossDoor =
	{
		InheritFrom = { "ExitDoor" },
		HideRewardPreview = true,
		ExitThroughCenter = true,

		AllowReroll = false,

		InteractDistance = 115,
		InteractOffsetX = 180,
		InteractOffsetY = -110,

		UnlockedUseText = "UseUnderworldBossDoor",
		UnlockedUseTextCannotReroll = "UseUnderworldBossDoor",
		HideUseIfLocked = true,
		CannotUsePresentation = "GenericPresentation",

		ExitFunctionName = "LeaveRoomIPreBossPresentation",
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

		UnlockedAnimation = "ChronosPrebossDoorHighlight",
	},

	ChronosBossExitDoor =
	{
		InheritFrom = { "ExitDoor" },
		HideRewardPreview = true,
		ExitThroughCenter = true,
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",

		AllowReroll = false,

		UnlockedAnimation = "DoorExitLightSoftNE_N_Opening",
	},

	BattleStandard =
	{
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "I_Boss01" },
				},
			},
			WithinDistance = 550,
			VoiceLines =
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.1,

				{ Cue = "/VO/MelinoeField_0434", Text = "A Time Sign..." },
				{ Cue = "/VO/MelinoeField_0436", Text = "A Sign of Chronos...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0437", Text = "One of those blasted Signs..." },
				{ Cue = "/VO/MelinoeField_0438", Text = "The Time Sign's back." },
				{ Cue = "/VO/MelinoeField_0439", Text = "Time Sign there..." },
				{ Cue = "/VO/MelinoeField_0440", Text = "Another Time Sign..." },
			}
		},
	},

	BattleStandardChronos = {
		InheritFrom = { "BattleStandard", },
	},

	-- RoomOpening / I_PreBoss01 Door
	CWDoor01 =
	{
		UseText = "UseHouseFrontDoor",
		OnUsedFunctionName = "HouseFrontDoorUsedPresentation",
		OnUsedGameStateRequirements =
		{
			{
				Path = { "GameState", "RoomCountCache", "I_PreBoss01" },
				Comparison = "<",
				Value = 1,
			}
		},
		BlockExitUntilUsedIfElligible = true,

		DistanceTrigger =
		{
			WithinDistance = 600,
			VoiceLines =
			{
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					PlayOnce = true,
					PlayOnceContext = "HouseDoorIntroVO",
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/Melinoe_1950", Text = "{#Emph}<Sigh>" },
				}
			},
		},

	},

	ChronosRemains =
	{
		Material = "OrganicObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15, },

		UseText = "UseExamineMisc",
		OnUsedFunctionName = "ChronosRemainsPresentation",
		OnUsedFunctionArgs = { VoiceLines = "UsedChronosRemainsVoiceLines" },

		OnHitFunctionName = "ChronosRepulseFromObject",
		OnHitFunctionArgs = { OffsetZ = -120 },

		OnHitVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.33,
			UsePlayerSource = true,
			Cooldowns =
			{
				{ Name = "StruckChronosRemainsRecentlyVO", Time = 60 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_1605", Text = "Impossible..." },
			{ Cue = "/VO/MelinoeField_1606", Text = "Not going to work." },
			{ Cue = "/VO/MelinoeField_1607", Text = "Got you, you wretch.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1608", Text = "Stay dead!" },
			{ Cue = "/VO/MelinoeField_1609", Text = "You're back where you belong." },
		},

		DistanceTriggers =
		{
			{
				FunctionName = "ChronosRemainsEnterTriggerPresentation",
				OnRepeatFunctionName = "ChronosRemainsLeaveTriggerPresentation",
				WithinDistance = 400,
				RepeatBufferDistance = 300,
				Repeat = true,
			},
		},
	},

	Breakable_I =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "CWVase01Shatter",

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "Breakable_I01" },
							OverwriteData =
							{
								DeathFx = "CWVase01Shatter",
							},
						},
						{
							Animation = { "Breakable_I02" },
							OverwriteData =
							{
								DeathFx = "CWVase02Shatter",
							},
						},
					},
				},
			},
		},

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	ClockworkToggleCover =
	{
		ToggledOn = true,
		ToggleCollision = true,

		ToggleOnAnimation = "ClockworkToggleCoverOn",
		ToggleOffAnimation = "ClockworkToggleCoverOff",

		ClockworkReaction =
		{
			FunctionName = "ToggleCover",
		},	
	},

	CWTerrainToggle01 =
	{
		InheritFrom = { "ClockworkToggleCover" },
		ToggleCollision = false,

		ToggleOnAnimation = "CWTerrainToggle01Open",
		ToggleOffAnimation = "CWTerrainToggle01Close",
	},

	CWTerrainToggle02 =
	{
		InheritFrom = { "ClockworkToggleCover" },
		ToggleCollision = false,

		ToggleOnAnimation = "CWTerrainToggle02Open",
		ToggleOffAnimation = "CWTerrainToggle02Close",
	},

	CWTerrainToggle03 =
	{
		InheritFrom = { "ClockworkToggleCover" },
		ToggleCollision = false,

		ToggleOnAnimation = "CWTerrainToggle03Open",
		ToggleOffAnimation = "CWTerrainToggle03Close",
	},

	ClockworkMovingCover =
	{
		ToggledOn = true,

		ClockworkReaction =
		{
			FunctionName = "MoveCover",
		},	
	},

	ShadeClockworkIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeClockworkSwaySW01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},


	CWTartarusRubble01 =
	{
		MaxHealth = 25,
		InheritFrom = { "BaseDestructible" },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		DeathFx = "RubbleFall",
		OnTouchdown =
		{
			ProjectileName = "RubbleFall",
			--CrushTypes = { "TartarusCandles01", "TartarusCandles01b", },
		},
	},

	CWTartarusRubble02 =
	{
		InheritFrom = { "CWTartarusRubble01" },
	},

	CWTartarusDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "CWDestructiblePillarB",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "CWTartarusRubble01", "CWTartarusRubble02" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnTimeMin = 0.1,
			SpawnTimeMax = 0.4,
			SpawnOffsetXMin = 75,
			SpawnOffsetXMax = 180,
			SpawnOffsetYMin = 75,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.15,
			SpawnScaleMax = 0.25,
			SwapData = "CWTartarusDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	CWTartarusDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "CWDestructiblePillarC",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "CWTartarusRubble01", "CWTartarusRubble02" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnTimeMin = 0.1,
			SpawnTimeMax = 0.4,
			SpawnOffsetXMin = 75,
			SpawnOffsetXMax = 180,
			SpawnOffsetYMin = 75,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.15,
			SpawnScaleMax = 0.25,
			SwapData = "CWTartarusDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	CWTartarusDestructiblePillarC =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "CWDestructiblePillarD",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "CWTartarusRubble01", "CWTartarusRubble02" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnTimeMin = 0.1,
			SpawnTimeMax = 0.4,
			SpawnOffsetXMin = 75,
			SpawnOffsetXMax = 180,
			SpawnOffsetYMin = 75,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.15,
			SpawnScaleMax = 0.25,
			SwapData = "CWTartarusDestructiblePillarD",
			CausesOcclusion = false,
		},
	},

	CWTartarusDestructiblePillarD =
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

	CW3DGear01 =
	{
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					PlaySpeedMin = 0.5,
					PlaySpeedMax = 4.0,
				},
			}
		},
	},

	CW3DGear02 =
	{
		InheritFrom = { "CW3DGear01" },
	},

	CW3DGear03 =
	{
		InheritFrom = { "CW3DGear01" },
	},

	CW3DGear04 =
	{
		InheritFrom = { "CW3DGear01" },
	},

})