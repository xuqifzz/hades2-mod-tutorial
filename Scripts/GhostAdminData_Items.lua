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
		"WorldUpgradeTimeStop",
		"WorldUpgradeAltRunDoor",
		"WorldUpgradeSurfacePenaltyCure",
		"WorldUpgradeQuestLog",
		"WorldUpgradeMorosUnlock",
		"WorldUpgradeNarcissusWaters",

		-- key systems
		"WorldUpgradeWeaponUpgradeSystem",
		"WorldUpgradeCardUpgradeSystem",
		"WorldUpgradeBountyBoard",
		"WorldUpgradeFamiliarSystem",
		"WorldUpgradeFamiliarRest",
		"WorldUpgradeToolUpgradeSystem",

		-- key upgrades
		"WorldUpgradeElementalBoons",
		"WorldUpgradePinning",
		"WorldUpgradeResourceFinder",
		"WorldUpgradeBoonList",
		"WorldUpgradeMarket",
		"WorldUpgradeSellShop",

		-- run upgrades
		"WorldUpgradeWellShops",
		"WorldUpgradePostBossWellShops",
		"WorldUpgradeSurfaceShops",
		"WorldUpgradePostBossSurfaceShops",
		"WorldUpgradeErebusReprieve",
		"WorldUpgradeOceanusReprieve",
		"WorldUpgradeTartarusReprieve",
		"WorldUpgradeThessalyReprieve",
		"WorldUpgradeFountainUpgrade1",
		"WorldUpgradeFountainUpgrade2",
		"WorldUpgradeBreakableValue1",
		"WorldUpgradeEphyraZoomOut",
		"WorldUpgradeFieldsRewardFinder",
		"WorldUpgradePauseChronosFight",
		"WorldUpgradeUnusedWeaponBonus",
		"WorldUpgradePostBossGiftRack",
		"WorldUpgradeErebusSafeZones",
		"WorldUpgradeShadeMercs",
		"WorldUpgradeChallengeSwitches1",

		-- hub expansions
		"WorldUpgradeTaverna",
		"WorldUpgradeBathHouse",
		"WorldUpgradeFishingPoint",

		-- supporting systems
		"WorldUpgradeToolsShop",
		"WorldUpgradeHarvestUpgrade",
		"WorldUpgradeGarden",
		"WorldUpgradeGardenT2",
		"WorldUpgradeGardenT3",
		"WorldUpgradeGardenTent",
		"WorldUpgradeGardenTaverna",
		"WorldUpgradeRunHistory",
		"WorldUpgradeGameStats",
		"WorldUpgradeGiftsShop",
		"WorldUpgradeRelationshipBar",

		-- misc.
		"WorldUpgradeHypnosUnlock",
	},		
	{
		Name = "WorldUpgradeScreen_Repeatable",
		Icon = "GUI\\Screens\\CriticalItemShop\\Icon-Alchemy",
		Animations = { Default = "GUI\\Screens\\CriticalItemShop\\CategoryTab02", Highlight = "GUI\\Screens\\CriticalItemShop\\CategoryTabMouseOver02", Active = "GUI\\Screens\\CriticalItemShop\\CategoryTabSelected02", Reveal = "CriticalItemShopCategoryTabReveal", },
		GameStateRequirements =
		{
			NamedRequirements = { "AlchemyUnlocked" },
		},
		"WorldUpgradeMixerShadow",
		"WorldUpgradeFamiliarPoints",
		"WorldUpgradeCardUpgradePoints",
		"WorldUpgradeCardUpgradePoints2",
		"WorldUpgradeNectar",
		"WorldUpgradeCosmeticsPointsCommon",
		"WorldUpgradeCosmeticsPointsRare",
		"WorldUpgradeCosmeticsPointsEpic",			
	},
}
