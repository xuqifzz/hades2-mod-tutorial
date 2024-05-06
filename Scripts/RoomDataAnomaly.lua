RoomSetData.Anomaly =
{
	BaseAnomaly =
	{
		DebugOnly = true,
		ResultText = "RunHistoryScreenResult_Anomaly",

		ValidateSecretData = false,
		LegalEncounters = EncounterSets.AnomalyEncountersB,
  
		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		-- for GameStateRequirements, search AnomalyDoorRequirements =
		SecretSpawnChance = 0.0,
		ShrinePointDoorSpawnChance = 0.0,
		TimeChallengeSwitchSpawnChance = 0.0,
		CapturePointSwitchSpawnChance = 0.0,
		PerfectClearSwitchSpawnChance = 0.0,
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

		UsePreviousRoomSet = true,

		IneligibleRewards = { "Devotion" },

		StartThreadedEvents =
		{
			{ FunctionName = "AnomalyStartPresentation", },
		},
	},

	B_Combat01 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat05 =
	{
		InheritFrom = { "BaseAnomaly" },
		DebugOnly = true,
	},

	B_Combat06 =
	{
		InheritFrom = { "BaseAnomaly" },
	},

	B_Combat07 =
	{
		InheritFrom = { "BaseAnomaly" },
		DebugOnly = true,
	},

	B_Combat08 =
	{
		InheritFrom = { "BaseAnomaly" },
		DebugOnly = true,
	},

	B_Combat10 =
	{
		InheritFrom = { "BaseAnomaly" },
		DebugOnly = true,
	},

	B_Combat21 =
	{
		InheritFrom = { "BaseAnomaly" },
		DebugOnly = true,
	},
}
AddTableKeysCheckDupes( RoomData, RoomSetData.Anomaly )