ScreenData.GhostAdmin.ItemCategories =
{
	{
		Name = "WorldUpgradeScreen_Critical",
		Icon = "GUI\\Screens\\CriticalItemShop\\Icon-Incantations",
		Animations = { Default = "GUI\\Screens\\CriticalItemShop\\CategoryTab01", Highlight = "GUI\\Screens\\CriticalItemShop\\CategoryTabMouseOver01", Active = "GUI\\Screens\\CriticalItemShop\\CategoryTabSelected01" },
		OneRevealPerRun = true,
		GameStateRequirements =
		{
			-- None
		},
		-- story & major progression
		"WorldUpgradeQuestLog",
		"WorldUpgradeMorosUnlock",

		-- key upgrades
		"WorldUpgradePinning",
		"WorldUpgradeResourceFinder",
		"WorldUpgradeMarket",
		"WorldUpgradeSellShop",

		-- run upgrades
		"WorldUpgradeWellShops",
		"WorldUpgradeErebusReprieve",
		"WorldUpgradeFountainUpgrade1",

		-- supporting systems
		"WorldUpgradeToolsShop",
		"WorldUpgradeGarden",
	},		
	{
		Name = "WorldUpgradeScreen_Repeatable",
		Icon = "GUI\\Screens\\CriticalItemShop\\Icon-Alchemy",
		Animations = { Default = "GUI\\Screens\\CriticalItemShop\\CategoryTab02", Highlight = "GUI\\Screens\\CriticalItemShop\\CategoryTabMouseOver02", Active = "GUI\\Screens\\CriticalItemShop\\CategoryTabSelected02" },
		GameStateRequirements =
		{
			NamedRequirements = { "AlchemyUnlocked" },
		},		
	},
}
