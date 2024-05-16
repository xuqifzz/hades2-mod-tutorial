OverwriteTableKeys( CodexData, 
{
	Familiars =
	{
		TitleText = "Codex_FamiliarsChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Familiars",
		Entries =
		{
			FrogFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
							},
						},
						Text = "CodexData_Frinos_01",
					},
				},
				Image = "Codex_Portrait_FrogFamiliar",
			},
			CatFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
							},
						},
						Text = "CodexData_Toula_01",
					},
				},
				Image = "Codex_Portrait_CatFamiliar",
			},
			RavenFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarStatus", "RavenFamiliar", "Unlocked", },
							},
						},
						Text = "CodexData_Raki_01",
					},
				},
				Image = "Codex_Portrait_RavenFamiliar",
			},

		},
	},

	EnemiesSF =
	{
		TitleText = "Codex_EnemiesSFChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-EnemiesSF",
		ShowKillCount = true,
		Entries =
		{
			Carrion =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Carrion", "Carrion_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Carrion_01",
					},
				},
				Image = "Codex_Portrait_Carrion",
			},
			Zombie =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Zombie", "Zombie_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Zombie_01",
					},
				},
				Image = "Codex_Portrait_Zombie",
			},
			ZombieCrewman =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieCrewman", "ZombieCrewman_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_ZombieCrewman_01",
					},
				},
				Image = "Codex_Portrait_ZombieCrewman",
			},
			ZombieAssassin =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieAssassin", "ZombieAssassin_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieAssassin_01",
					},
				},
				Image = "Codex_Portrait_ZombieAssassin",
			},
			ZombieHeavyRanged =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieHeavyRanged", "ZombieHeavyRanged_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieHeavyRanged_01",
					},
				},
				Image = "Codex_Portrait_ZombieHeavyRanged",
			},
			ZombieSpawner =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieSpawner", "ZombieSpawner_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieSpawner_01",
					},
				},
				Image = "Codex_Portrait_ZombieSpawner",
			},
			Mudman =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mudman", "Mudman_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_Mudman_01",
					},
				},
				Image = "Codex_Portrait_Mudman",
			},
			SatyrCrossbow =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrCrossbow" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_SatyrCrossbow_01",
					},
				},
				Image = "Codex_Portrait_SatyrCrossbow",
			},
			WaterElemental =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "WaterElemental", "WaterElemental_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_WaterElemental_01",
					},
				},
				Image = "Codex_Portrait_WaterElemental",
			},
			Scimiterror =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Scimiterror", "Scimiterror_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Scimiterror_01",
					},
				},
				Image = "Codex_Portrait_Scimiterror",
			},
			Mage2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mage2", "Mage2_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Mage2_01",
					},
				},
				Image = "Codex_Portrait_Mage2",
			},
			Stickler =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Stickler", "Stickler_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Stickler_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaStickler",
			},
			Drunk =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Drunk", "Drunk_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Drunk_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaDrunk",
			},
			Swab =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Swab", "Swab_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Swab_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaSwab",
			},
			HarpyCutter =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "HarpyCutter", "HarpyCutter_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_HarpyCutter_01",
					},
				},
				Image = "Codex_Portrait_HarpyTalonCutter",
			},
			Charybdis =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Charybdis" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Charybdis_01",
					},
				},
				Image = "Codex_Portrait_Charybdis",
			},


		},
	},
})

OverwriteTableKeys( CodexData.ChthonicGods.Entries,
{
	NPC_Medea_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Medea_01",
			},
		},
		Image = "Codex_Portrait_Medea",
		BoonInfoEnemyName = "NPC_Medea_01",
	},

	NPC_Circe_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Circe_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Circe_01",
			},
		},
		Image = "Codex_Portrait_Circe",
		BoonInfoEnemyName = "NPC_Circe_01",
	},
})

OverwriteTableKeys( CodexData.OtherDenizens.Entries,
{
	NPC_Eris_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Eris_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Eris_01",
			},
		},
		Image = "Codex_Portrait_Eris",
	},
		
	NPC_Icarus_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Icarus_01",
			},
		},
		Image = "Codex_Portrait_Icarus",
		BoonInfoEnemyName = "NPC_Icarus_01",
	},
	NPC_Narcissus_01 =
	{
		NoRequirements = true,
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Narcissus_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Narcissus_01",
			},
		},
		Image = "Codex_Portrait_Narcissus",
		BoonInfoEnemyName = "NPC_Narcissus_01",
	},
	NPC_Echo_01 =
	{
		NoRequirements = true,
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Echo_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Echo_01",
			},
		},
		Image = "Codex_Portrait_Echo",
		BoonInfoEnemyName = "NPC_Echo_01",
	},
	NPC_Heracles_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Heracles_01",
			},
		},
		Image = "Codex_Portrait_Heracles",
	},
	Scylla =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 1,
					},
				},
				Text = "CodexData_Scylla_01",
			},
		},
		Image = "Codex_Portrait_Scylla",
	},
	Polyphemus =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 1,
					},
				},
				Text = "CodexData_Polyphemus_01",
			},
		},
		Image = "Codex_Portrait_Polyphemus",
	},
	NPC_Cerberus_01 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "InfestedCerberus" },
						Comparison = ">=",
						Value = 1,
					},
				},
				Text = "CodexData_Cerberus_01",
			},
		},
		Image = "Codex_Portrait_Cerberus",
	},
})

OverwriteTableKeys( CodexData.OlympianGods.Entries,
{
	HeraUpgrade =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "HeraUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Hera_01",
			},
		},
		Image = "Codex_Portrait_Hera",
	},
	HermesUpgrade =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "HermesUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Hermes_01",
			},
		},
		Image = "Codex_Portrait_Hermes",
	},
})

OverwriteTableKeys( CodexData.Weapons.Entries,
{
	WeaponTorch =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponKills" },
						SumOf = { "WeaponTorch", "WeaponTorchSpecial" },
						Comparison = ">=",
						Value = 100,
					},
				},
				Text = "CodexData_WeaponTorch_01",
			},
		},
		Image = "Codex_Portrait_WeaponTorch",
		BoonInfoLootName = "WeaponUpgrade",
		BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Torch",
	},
	WeaponAxe =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponKills" },
						SumOf = { "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxeSpin", "WeaponAxeBlock2" },
						Comparison = ">=",
						Value = 100,
					},
				},
				Text = "CodexData_WeaponAxe_01",
			},
		},
		Image = "Codex_Portrait_WeaponAxe",
		BoonInfoLootName = "WeaponUpgrade",
		BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Axe",
	},
	WeaponLob =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponKills" },
						SumOf = { "WeaponLob", "WeaponLobSpecial" },
						Comparison = ">=",
						Value = 100,
					},
					{
						PathTrue = { "GameState", "CodexEntriesViewed", "PlayerUnit" },
					},
				},
				Text = "CodexData_WeaponLob_01",
			},
		},
		Image = "Codex_Portrait_WeaponLob",
		BoonInfoLootName = "WeaponUpgrade",
		BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Lob",
	},
})

OverwriteTableKeys( CodexData.EnemiesUW.Entries, 
{
	Treant =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Treant" },
						Comparison = ">=",
						Value = 5,
					},
				},
				Text = "CodexData_Treant_01",
			},
		},
		Image = "Codex_Portrait_Treant",
	},
	Treant2 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Treant2" },
						Comparison = ">=",
						Value = 5,
					},
				},
				Text = "CodexData_Treant2_01",
			},
		},
		Image = "Codex_Portrait_Treant2",
	},
	FogEmitter =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "FogEmitter", "FogEmitter_Elite" },
						Comparison = ">=",
						Value = 5,
					},
				},
				Text = "CodexData_FogEmitter_01",
			},
		},
		Image = "Codex_Portrait_FogEmitter",
	},
	FogEmitter2 =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "FogEmitter2" },
						Comparison = ">=",
						Value = 5,
					},
				},
				Text = "CodexData_FogEmitter2_01",
			},
		},
		Image = "Codex_Portrait_FogEmitter2",
	},

	FishSwarmer =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "FishSwarmer", "FishSwarmer_Elite" },
						Comparison = ">=",
						Value = 100,
					},
				},
				Text = "CodexData_FishSwarmer_01",
			},
		},
		Image = "Codex_Portrait_FishmanSwarmer",
	},
	FishmanMelee =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "FishmanMelee", "FishmanMelee_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_FishmanMelee_01",
			},
		},
		Image = "Codex_Portrait_FishmanMelee",
	},
	FishmanRanged =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "FishmanRanged", "FishmanRanged_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_FishmanRanged_01",
			},
		},
		Image = "Codex_Portrait_FishmanRanged",
	},
	Turtle =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Turtle", "Turtle_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_Turtle_01",
			},
		},
		Image = "Codex_Portrait_Turtle",
	},
	WaterUnit =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "WaterUnit", "WaterUnit_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_WaterUnit_01",
			},
		},
		Image = "Codex_Portrait_WaterUnit",
	},
	WaterUnitMiniboss =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "WaterUnitMiniboss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_WaterUnitMiniboss_01",
			},
		},
		Image = "Codex_Portrait_WaterUnitMiniBoss",
	},
	ThiefMineLayer =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "ThiefMineLayer", "ThiefMineLayer_Elite" },
						Comparison = ">=",
						Value = 8,
					},
				},
				Text = "CodexData_ThiefMineLayer_01",
			},
		},
		Image = "Codex_Portrait_ThiefMineLayer",
	},
	CrawlerMinibossCodex =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "CrawlerMiniboss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_CrawlerMiniboss_01",
			},
		},
		Image = "Codex_Portrait_CrawlerMiniBoss",
	},

	CorruptedShadeSmall =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "CorruptedShadeSmall", "CorruptedShadeSmall_Elite" },
						Comparison = ">=",
						Value = 25,
					},
				},
				Text = "CodexData_CorruptedShadeSmall_01",
			},
		},
		Image = "Codex_Portrait_CorruptedShadeS",
	},
	CorruptedShadeMedium =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "CorruptedShadeMedium", "CorruptedShadeMedium_Elite" },
						Comparison = ">=",
						Value = 20,
					},
				},
				Text = "CodexData_CorruptedShadeMedium_01",
			},
		},
		Image = "Codex_Portrait_CorruptedShadeM",
	},
	CorruptedShadeLarge =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "CorruptedShadeLarge", "CorruptedShadeLarge_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_CorruptedShadeLarge_01",
			},
		},
		Image = "Codex_Portrait_CorruptedShadeL",
	},
	DespairElemental =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "DespairElemental",  "DespairElemental_Elite", "DespairElementalLarge", "DespairElementalLarge_Elite",  },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_DespairElemental_01",
			},
		},
		Image = "Codex_Portrait_DespairElemental",
	},

	BrokenHearted =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "BrokenHearted", "BrokenHearted_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_BrokenHearted_01",
			},
		},
		Image = "Codex_Portrait_BrokenHearted",
	},
	Lovesick =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Lovesick", "Lovesick_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_Lovesick_01",
			},
		},
		Image = "Codex_Portrait_Lovesick",
	},
	Mourner =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Mourner", "Mourner_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_Mourner_01",
			},
		},
		Image = "Codex_Portrait_Mourner",
	},
	LycanSwarmer =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "LycanSwarmer", "LycanSwarmer_Elite" },
						Comparison = ">=",
						Value = 20,
					},
				},
				Text = "CodexData_LycanSwarmer_01",
			},
		},
		Image = "Codex_Portrait_LycanSwarmer",
	},
	Lycanthrope =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Lycanthrope", "Lycanthrope_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_Lycanthrope_01",
			},
		},
		Image = "Codex_Portrait_Lycanthrope",
	},
	Vampire =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Vampire", "Vampire_Elite" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_Vampire_01",
			},
		},
		Image = "Codex_Portrait_Vampire",
	},
	Lamia =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Lamia", "Lamia_Elite" },
						Comparison = ">=",
						Value = 10,
					},
				},
				Text = "CodexData_Lamia_01",
			},
		},
		Image = "Codex_Portrait_Lamia",
	},
	Lamia_Miniboss =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Lamia_Miniboss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_LamiaMiniboss_01",
			},
		},
		Image = "Codex_Portrait_LamiaMiniBoss",
	},

	Swarmer =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Swarmer", "Swarmer_Elite", "SwarmerClockwork", "SwarmerClockwork_Elite" },
						Comparison = ">=",
						Value = 100,
					},
				},
				Text = "CodexData_Swarmer_01",
			},
		},
		Image = "Codex_Portrait_Swarmer",
	},
	ClockworkHeavyMelee =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "ClockworkHeavyMelee", "ClockworkHeavyMelee_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_ClockworkHeavyMelee_01",
			},
		},
		Image = "Codex_Portrait_WretchThug",
	},
	Crawler =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "Crawler", "Crawler_Elite" },
						Comparison = ">=",
						Value = 50,
					},
				},
				Text = "CodexData_Crawler_01",
			},
		},
		Image = "Codex_Portrait_Crawler",
	},
	SatyrRatCatcher =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrRatCatcher", "SatyrRatCatcher_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_SatyrRatCatcher_01",
			},
		},
		Image = "Codex_Portrait_SatyrRatCatcher",
	},
	SatyrLancer =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrLancer", "SatyrLancer_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_SatyrLancer_01",
			},
		},
		Image = "Codex_Portrait_SatyrLancer",
	},
	SatyrCultist =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrCultist", "SatyrCultist_Elite" },
						Comparison = ">=",
						Value = 25,
					},
				},
				Text = "CodexData_SatyrCultist_01",
			},
		},
		Image = "Codex_Portrait_QuestionMark",
	},
	TimeElemental =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "TimeElemental", "TimeElemental_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_TimeElemental_01",
			},
		},
		Image = "Codex_Portrait_TimeElemental",
	},
	GoldElemental =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "GoldElemental", "GoldElemental_Elite" },
						Comparison = ">=",
						Value = 30,
					},
				},
				Text = "CodexData_GoldElemental_01",
			},
		},
		Image = "Codex_Portrait_GoldElemental",
	},
	GoldElemental_MiniBoss =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "GoldElemental_MiniBoss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_GoldElementalMiniboss_01",
			},
		},
		Image = "Codex_Portrait_GoldElementalMiniBoss",
	},
	SatyrRatCatcher_Miniboss =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills" },
						SumOf = { "SatyrRatCatcher_Miniboss" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_SatyrRatCatcherMiniboss_01",
			},
		},
		Image = "Codex_Portrait_SatyrRatCatcherMiniBoss",
	},
})

OverwriteTableKeys( CodexData.Biomes.Entries,
{
	BiomeG =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "G" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeG_01",
			},
		},
		Image = "Codex_Portrait_BiomeOceanus",
	},
	BiomeH =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "H" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeH_01",
			},
		},
		Image = "Codex_Portrait_BiomeFields",
	},
	BiomeI =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "I" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeI_01",
			},
		},
		Image = "Codex_Portrait_BiomeTartarus",
	},

	BiomeN =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "N" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeN_01",
			},
		},
		Image = "Codex_Portrait_BiomeEphyra",
	},
	BiomeO =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "O" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeO_01",
			},
		},
		Image = "Codex_Portrait_BiomeThessaly",
	},
	BiomeB =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "Anomaly" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_BiomeB_01",
			},
		},
		Image = "Codex_Portrait_AsphodelBiome",
	},
	BiomeHouse =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				Text = "CodexData_BiomeHouse_01",
			},
		},
		Image = "Codex_Portrait_BiomeHouseOfHades",
	},
	BiomeChaos =
	{
		Entries =
		{
			{
				UnlockGameStateRequirements =
				{
					{
						Path = { "GameState", "BiomeVisits", "Chaos" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Text = "CodexData_BiomeChaos_01",
			},
		},
		Image = "Codex_Portrait_ChaosBiome",
	},
})