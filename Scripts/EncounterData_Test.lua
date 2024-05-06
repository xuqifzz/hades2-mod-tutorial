OverwriteTableKeys( EncounterData,
{
	-- Test Encountersa
	TestFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.1,
		SpawnIntervalMax = 0.25,
		ActiveEnemyCapBase = 1,

		Spawns =
		{
			{
				Name = "Mage",
				TotalCount = 9999,
			},
		},
	},

	CombatTestJosh =
	{
		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 2.0,
		ActiveEnemyCapBase = 10,
		EnemyCountDepthRamp = 0.2,

		Spawns =
		{
			{
				Name = "BaseSpawner",
				CountMin = 0,
				CountMax = 0,
			},
		},
	},

	TuningFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.05,
		ActiveEnemyCapBase = 6,
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Carrion",
						TotalCount = 2,
					},
				},
				StartDelay = 1.0,
			},
		},
	},

	TestNPCs =
	{
		InheritFrom = { "NonCombat" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Hades_01", "NPC_Cerberus_01", "NPC_Achilles_01", "NPC_Nyx_01", "NPC_Dusa_01", "NPC_Skelly_01", "NPC_Charon_01", "NPC_Orpheus_01", "NPC_Hypnos_01", "NPC_Thanatos_01", "NPC_Thanatos_Field_01", "NPC_FurySister_01" }, } },
		},

		DistanceTriggers =
		{
			{
				TriggerGroup = "Art_NPCs", WithinDistance = 400, LockToCharacter = true,
				VoiceLines =
				{
					-- He remembered only meeting her.
					-- { Cue = "", Text = "I cannot turn back Time; but you? What would you say if you possessed that power?", PreLineWait = 0.35 },
				},
			},
		},
	},
})