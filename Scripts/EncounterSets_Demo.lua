EncounterSets =
{
	
	----- IRIS -----

	FEncountersDefault =
	{
		"GeneratedF", 
		"GeneratedF", 
		"GeneratedF", 
		"GeneratedF",
		"GeneratedF", 
		"GeneratedF",
		"GeneratedF", 
		"GeneratedF", 
		"GeneratedF", 
		"GeneratedF",
		"GeneratedF", 
		"GeneratedF",

		"ArtemisCombatF",

		"ArtemisCombatF2", -- fallback if it's been a while
		"ArtemisCombatF2",
		"ArtemisCombatF2",
		"ArtemisCombatF2",

		"ArachneCombatF", 
		"ArachneCombatF",

		-- intro encounters weighted higher
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
		"ArtemisCombatIntro",
	},

	----------------

	EncounterEventsArachneCombat =
	{
		{ FunctionName = "BeginArachneEncounter" },
		{ FunctionName = "WaitForArachneRewardFound" },
	},

	EncounterEventsArtemisCombat =
	{
		{ FunctionName = "BeginArtemisEncounter" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},


	EncounterEventsWrapping =
	{
		{ FunctionName = "WrappingEncounterStartPresentation" },
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "BeginWrappingEncounter" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "DisableRoomTraps" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "WrappingEncounterEndPresentation" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsTraversal =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "UnlockRoomExits" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "PostCombatAudio" },
	},

	ThanatosEncounters = 
	{
		"Empty"
	},

	ShopRoomEvents =
	{
		{
			FunctionName = "SetupWorldShop",
			Args =
			{
				ActivateUnitsByType = { "NPC_Charon_01", },
				ActivateIdsByType = { "Shop", "Boat" },
			},
		},
	},

	EncounterEventsDefault =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsBossSpawnedEncounter =
	{
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForEncounterEnemiesDead", },
	},

	EncounterEventsNonCombat =
	{
		{ FunctionName = "CheckConversations" },
	},
}