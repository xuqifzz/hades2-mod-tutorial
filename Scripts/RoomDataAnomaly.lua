RoomSetData.Anomaly =
{
	BaseAnomaly =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_Dream",
		ResultText = "RunHistoryScreenResult_Anomaly",

		ValidateSecretData = false,
		LegalEncounters = EncounterSets.AnomalyEncountersB,
  
		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		-- for GameStateRequirements, search AnomalyDoorRequirements =
		SecretSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.0,
		BlockGiftBoons = true,	--Don't serve boons that drop objects

		ZoomFraction = 0.9,
		CardinalEntranceDirection = true,
		FlipHorizontalChance = 0,

		IntroSequenceDuration = 0.65,

		SecretMusic = "/Music/ChaosTheme_MC",
		Ambience = "/Leftovers/Object Ambiences/LavaAmbience_MatchSiteB",
		NextRoomResumeMusic = true,

		LocationText = "Location_BiomeAnomaly",
		SaveProfileLocationText = "Location_BiomeAnomaly",

		EntranceFunctionName = "AnomalyEntrancePresentation",
		ExitFunctionName = "AnomalyExitPresentation",
		NextRoomEntranceFunctionName = "EntranceFromAnomalyPresentation",
		EntranceAnimation = "MelinoeSpellFire",
		EntranceVfx = "SecretDoorDiveFx",
		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
		LocationAnimName = "InfoBannerAsphodelIn",
		LocationAnimOutName = "InfoBannerAsphodelOut",

		UsePreviousRoomSet = true,

		IneligibleRewards = { "Devotion", "SpellDrop" },

		StartThreadedEvents =
		{
			{ FunctionName = "AnomalyStartPresentation", },
		},

		Using =
		{
			"ChronosTimeStopFx",
			"ChronosTimeStopMelFx",
			"AsphodelSkullDeathFx",
		},
	},

	B_Combat01 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat05 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat06 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat07 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat08 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat10 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat21 =
	{
		InheritFrom = { "BaseAnomaly" },
	},
}
AddTableKeysCheckDupes( RoomData, RoomSetData.Anomaly )