RoomSetData.Chaos =
{
	BaseChaos =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_Chaos",
		
		HarvestPointBase = "DrownedChambersHarvestPointBase01",

		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = false,
		AllowOnlyOneToolHarvestableResource = true,
		ResourcePointsIgnoredByBiomeRequirements = true,
		IgnoreHarvestBiomeSpawnLimit = true,

		HarvestPointChances =
		{
			0.5,
		},
		PickaxePointChance = 0.6,
		ShovelPointChance = 0.6,
		FishingPointChance = 0.6,

		HarvestPointRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "ChaosGrantsDarkness01", "ChaosGrantsDarkness01_B" },
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer6Common" },
						Comparison = "<",
						Value = 6,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.7,
				},
			},
		},
		ShovelPointRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantChaosThalamusSeed" },
						Comparison = "<",
						Value = 6,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.7,
				},
			},
		},
		PickaxePointRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutSurface01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantChaosThalamusSeed" },
				Comparison = ">=",
				Value = 2, -- Chaos gifts you one as part of ChaosAboutSurface01
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreChaosProtoplasm" },
						Comparison = "<",
						Value = 12,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.7,
				},
			},
		},
		FishingPointRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreChaosProtoplasm" },
				Comparison = ">=",
				Value = 1,
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", },
						NotHasAll = { "FishChaosCommon", "FishChaosRare", "FishChaosLegendary" },
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.7,
				},
			},
		},

		AnomalyDoorChance = 0.0,
		AnomalyDoorChanceFirstInstance = 0.0,

		SpawnRewardOnId = 561960,

		RushMaxRangeOverride = 475,

		LeavePrevRoomWipeAnimation = "RoomTransitionIn_Down",
		EnterWipeAnimation = "RoomTransitionOut_Down",

		IgnoreExitDirection = true,
		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		EntranceAnimation = "MelinoeSpellFire",
		EntranceVfx = "SecretDoorDiveFx",
		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
		ExitDoorOpenAnimation = "ExitDoorLinesSpecial",
		ExitDoorCloseAnimation = "ExitDoorLinesSpecial",
		SkipLastKillPresentation = true,
		UsePromptOffsetY = 120,

		LocationText = "Location_Secret",
		LocationAnimName = "LocationBackingIrisChaosIn_Biome",
		LocationAnimOutName = "LocationBackingIrisChaosOut_Biome",
		SaveProfileLocationText = "Location_Secret",
		LocationTextColor = { 20, 0, 255, 255 },

		ResultText = "RunHistoryScreenResult_Secret",
		BiomeName = "Secrets",
		PauseBiomeState = true,

		Ambience = "/Leftovers/Ambience/MountainAmbience",
		SecretMusic = "/Music/ChaosTheme_MC",
		SkipLeavePrevRoomSFX = true,
		UsePreviousRoomSet = true,
		BlockHeroLight = true,
		ForcedRewardStore = "Secrets",
		LegalEncounters = { "Empty_Chaos" },

		ZoomFraction = 0.75,
		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		SoftClamp = 0.75,

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.34,
				SuccessiveChanceToPlay = 0.2,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "ChaosSpokeRecently", Time = 15 },
				},

				{ Cue = "/VO/Chaos_0067", Text = "You have returned." },
				{ Cue = "/VO/Chaos_0068", Text = "You are here." },
				{ Cue = "/VO/Chaos_0069", Text = "You have arrived.", PlayFirst = true },
				{ Cue = "/VO/Chaos_0070", Text = "I anticipated your return." },
				{ Cue = "/VO/Chaos_0071", Text = "I see you once again." },
				{ Cue = "/VO/Chaos_0072", Text = "It is you." },
				{ Cue = "/VO/Chaos_0073", Text = "Greetings to you." },
				{ Cue = "/VO/Chaos_0074", Text = "Welcome..." },
				{ Cue = "/VO/Chaos_0075", Text = "Come forth." },
				{ Cue = "/VO/Chaos_0076", Text = "We meet again." },
				{ Cue = "/VO/Chaos_0077", Text = "You found your way." },
				{ Cue = "/VO/Chaos_0078", Text = "A guest in my domain." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.4,
				ChanceToPlay = 0.75,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "EnteredSecretRoomSpeech", Time = 20 },
				},

				{ Cue = "/VO/MelinoeField_0776", Text = "Where in the...?", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/MelinoeField_0798", Text = "So quiet..." },
				{ Cue = "/VO/MelinoeField_0799", Text = "Beautiful..." },
				{ Cue = "/VO/MelinoeField_0800", Text = "{#Emph}Augh..." },
				{ Cue = "/VO/MelinoeField_0801", Text = "Made it through..." },
				{ Cue = "/VO/MelinoeField_0802", Text = "It's warm..." },
				{ Cue = "/VO/MelinoeField_0803", Text = "Chaos..." },
				{ Cue = "/VO/MelinoeField_0805", Text = "Good to be back..." },
				{ Cue = "/VO/MelinoeField_0806", Text = "So serene..." },
				{ Cue = "/VO/MelinoeField_0807", Text = "Still intact..." },
				{ Cue = "/VO/MelinoeField_0808", Text = "Almighty Chaos...?" },
				{ Cue = "/VO/MelinoeField_0809", Text = "Hail, Chaos!" },
				{ Cue = "/VO/MelinoeField_0810", Text = "Just me...!" },
				{ Cue = "/VO/MelinoeField_0811", Text = "You called...?" },
				{ Cue = "/VO/MelinoeField_0804", Text = "This old place...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "UseRecord", "TrialUpgrade" },
							Comparison = ">=",
							Value = 10,
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.93,
				SuccessiveChanceToPlay = 0.2,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				PlayOnceFromTableThisRun = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
					},
				},
				{ Cue = "/VO/Chaos_0073", Text = "Greetings to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0809" },
						},
					},
				},
				{ Cue = "/VO/Chaos_0074", Text = "Welcome...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0808", "/VO/MelinoeField_0809" },
						},
					},
				},
			},

		},

	},

	Chaos_01 =
	{
		InheritFrom = { "BaseChaos" },
		HoundFamiliarMovementRequiresLineOfSight = true,
		PolecatFamiliarShouldNotFollow = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

		InspectPoints =
		{
			[621957] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_01_01 =
					{
						{ Cue = "/VO/Storyteller_0177",
							Text = "{#Emph}From nothingness sprang all creation, light, and darkness, and the world itself; yet all that nothingness remains, carefully tucked away where none can find it, save for those invited in." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0823", Text = "Best keep our voices down...!" },
						},
					},
				},
			},
		},

		Using = { Animation = { "Portrait_Chaos_Default_01", }, },
	},
	Chaos_02 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

		InspectPoints =
		{
			[622001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_02_01 =
					{
						{ Cue = "/VO/Storyteller_0178",
							Text = "{#Emph}Within the silence of the infinite abyss lies infinite possibility; the limitless and unseen building-blocks of all that has ever been conceived, and all that shall ever be." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0824", Text = "It's really quite a lot..." },
						},
					},
				},
			},
		},

	},
	Chaos_03 =
	{
		InheritFrom = { "BaseChaos" },
		HoundFamiliarMovementRequiresLineOfSight = true,
		PolecatFamiliarShouldNotFollow = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
		},

		InspectPoints =
		{
			[622002] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "TrialUpgrade" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Chaos_03_01 =
					{
						{ Cue = "/VO/Storyteller_0179",
							Text = "{#Emph}The ancient and obscure originator of creation yet remains, observing from within such black impenetrable depths the endless toil of the living and the dead." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_0825", Text = "Chaos is witness to all..." },
						},
					},
				},
			},
		},

	},
	Chaos_04 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

	},
	Chaos_05 =
	{
		InheritFrom = { "BaseChaos" },
		HoundFamiliarMovementRequiresLineOfSight = true,
		PolecatFamiliarShouldNotFollow = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},

	},
	Chaos_06 =
	{
		InheritFrom = { "BaseChaos" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "Chaos_01" },
			},
		},

		FishingPointRadii =
		{
			[622181] = 330,
			[622252] = 250,
		},
	},	
}
AddTableKeysCheckDupes( RoomData, RoomSetData.Chaos )