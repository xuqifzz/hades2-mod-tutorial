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
		-- "WorldUpgradeTimeStop", (listed below for the time being...)
		"WorldUpgradeAltRunDoor",
		"WorldUpgradeSurfacePenaltyCure",
		"WorldUpgradeQuestLog",
		"WorldUpgradeMorosUnlock",
		"WorldUpgradeNarcissusWaters",
		"WorldUpgradeWakeHypnos",
		-- deferred story further down

		-- key systems
		"WorldUpgradeWeaponUpgradeSystem",
		"WorldUpgradeCardUpgradeSystem",
		"WorldUpgradeBountyBoard",
		"WorldUpgradeBountyBoardRepeat",
		"WorldUpgradeFamiliarSystem",
		"WorldUpgradeFamiliarRest",
		"WorldUpgradeFamiliarUpgradeSystem",
		"WorldUpgradeToolUpgradeSystem",

		-- key upgrades
		"WorldUpgradeElementalBoons",
		"WorldUpgradePinning",
		"WorldUpgradeMetaUpgradeSaveLayout",
		"WorldUpgradeKeepsakeSaveFirst",
		"WorldUpgradeResourceFinder",
		"WorldUpgradeBoonList",
		"WorldUpgradeMarket",
		"WorldUpgradeSellShop",
		"WorldUpgradeGiftsShop",
		"WorldUpgradeExchangeShop",

		-- run upgrades
		"WorldUpgradeWellShops",
		"WorldUpgradePostBossWellShops",
		"WorldUpgradeSurfaceShops",
		"WorldUpgradePostBossSurfaceShops",
		"WorldUpgradePostBossSellTraitShops",
		"WorldUpgradeErebusReprieve",
		"WorldUpgradeOceanusReprieve",
		"WorldUpgradeTartarusReprieve",
		"WorldUpgradeThessalyReprieve",
		"WorldUpgradeOlympusReprieve",
		"WorldUpgradeFountainUpgrade1",
		"WorldUpgradeFountainUpgrade2",
		"WorldUpgradeBreakableValue1",
		"WorldUpgradeEphyraZoomOut",
		"WorldUpgradeFieldsRewardFinder",
		"WorldUpgradeTimeSlowChronosFight",
		--"WorldUpgradePauseChronosFight",
		"WorldUpgradeUnusedWeaponBonus",
		"WorldUpgradePostBossGiftRack",
		"WorldUpgradeErebusSafeZones",
		"WorldUpgradeSafeZoneSpellCharge",
		"WorldUpgradeShadeMercs",
		"WorldUpgradeChallengeSwitches1",
		"WorldUpgradeChallengeSwitchesExtra1",
		"WorldUpgradeChallengeSwitchesSurface1",
		"WorldUpgradeMetaCardPointsCommonRunProgress",
		"WorldUpgradeMemPointsCommonRunProgress",
		"WorldUpgradeMetaCurrencyRunProgress",
		"WorldUpgradeGiftDropRunProgress",

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
		"WorldUpgradeMusicPlayer",
		"WorldUpgradeRunHistory",
		"WorldUpgradeGameStats",
		"WorldUpgradeRelationshipBar",

		-- misc. & deferred story
		"WorldUpgradeTimeStop",
		"WorldUpgradeDoraMemory",
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
	},
}
