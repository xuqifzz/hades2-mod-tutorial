OverwriteTableKeys( EncounterData,
{
	-- Artemis Encounter
	ArtemisCombatG =
	{
		InheritFrom = { "BaseArtemisCombat", "GeneratedG" },
		DifficultyModifier = 145,
		MaxEliteTypes = 3,	
	},

	ArtemisCombatG2 =
	{
		InheritFrom = { "ArtemisCombatG" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	ArtemisCombatN =
	{
		InheritFrom = { "BaseArtemisCombat", "GeneratedN" },
		ActiveEnemyCapBase = 5.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 1,

		BaseDifficulty = 200,
		DepthDifficultyRamp = 20,
	},

	ArtemisCombatN2 =
	{
		InheritFrom = { "ArtemisCombatN" },

		GameStateRequirements =
		{
			DeepInheritance = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},
})