-- key upgrades
OverwriteTableKeys( WorldUpgradeData,
{
	WorldUpgradeElementalBoons =
	{
		InheritFrom = { "DefaultHubItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_element",
		Cost =
		{
			MemPointsCommon = 5,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusFirstPickUp" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "G_Boss01" },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3505", Text = "{#Emph}Within the Boons of Mount Olympus I would see \n {#Emph}Their elemental essences, my victory." },
			},
		},
	},
	WorldUpgradeBoonList =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "RunUpgrade_CodexBoonList",
		Cost =
		{
			SuperGiftPoints = 2,
			MixerOBoss = 1,
			PlantIPoppy = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "Codex" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll =
				{
					"ZeusGift01",
					"HeraGift01",
					"PoseidonGift01",
					"ApolloGift01",
					"DemeterGift01",
					"AphroditeGift01",
					"HephaestusGift01",
					"HestiaGift01",
					"HermesGift01",
					"ChaosGift01",
					"ArtemisGift01",
				},
			},
		},
	},

})