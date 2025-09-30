AchievementData =
{
	DefaultAchievement =
	{
		DebugOnly = true,
	},
	
	AchClearErebus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "F_PostBoss01" },
			},
		},
	},

	AchClearOceanus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "G_PostBoss01" },
			},
		},
	},

	AchClearFields =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "H_PostBoss01" },
			},
		},
	},

	AchClearTartarus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "I_PostBoss01" },
			},
		},
	},

	AchClearEphyra =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "N_PostBoss01" },
			},
		},
	},

	AchClearThessaly =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "O_PostBoss01" },
			},
		},
	},

	AchClearOlympus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "P_PostBoss01" },
			},
		},
	},

	AchClearSummit =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "Q_PostBoss01" },
			},
		},
	},

	AchCauldronSpells1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				CountOf = ScreenData.GhostAdmin.ItemCategories[1],
				Comparison = ">=",
				Value = 50,
			},
		},
	},

	AchBathHouse =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "DoraBathHouse01", "HecateBathHouse01", "OdysseusBathHouse01", "MorosBathHouse01", "NemesisBathHouse01", "ErisBathHouse01", "IcarusBathHouse01" }
			},
		},
	},

	AchFishingPier =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "DoraFishing01", "ErisFishing01", "HecateFishing01", "IcarusFishing01", "MorosFishing01", "NemesisFishing01", "OdysseusFishing01" }
			},
		},
	},

	AchTaverna =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAny = { "DoraTaverna01", "ErisTaverna01", "HecateTaverna01", "IcarusTaverna01", "MorosTaverna01", "NemesisTaverna01", "OdysseusTaverna01" }
			},
		},
	},
	
	AchForgeBonds =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				CountOf = GameData.AllBondForgedEvents,
				Comparison = ">=",
				Value = 10,
			},
		},
	},

	AchProphecies1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "QuestsCompleted" },
				UseLength = true,
				Comparison = ">=",
				Value = 60,
			},
		},
	},

	AchMaxMem =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 30,
			},
		},
	},

	AchAllArcana =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestUnlockAllCards" },
			},
		},
	},

	AchAllArcanaMax =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				FunctionName = "RequireAllMetaUpgradesAtMaxLevel",
			},
		},
	},

	AchAllWeapons =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestUnlockAllWeapons" },
			},
		},
	},

	AchAllAspects =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestUnlockAllWeaponAspects" },
			},
		},
	},
	
	AchConfideFrinos =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestPetFrog" },
			},
		},
	},

	AchAllFamiliars =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				HasAll = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
			},
		},
	},

	AchAllFamiliarsMax =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarUpgrades" },
				HasAll =
				{
					"FrogHealthBonus3",
					"FrogUses3",
					"FrogDamage3",
					"CatLastStandHeal3",
					"CatUses3",
					"CatAttack3",
					"RavenCritChanceBonus3",
					"RavenUses3",
					"RavenAttack3",					
					"HoundManaBonus3",					
					"HoundUses3",					
					"HoundAttack3",					
					"PolecatDodgeBonus3",					
					"PolecatUses3",					
					"PolecatDamage3",					
				},
			},
		},
	},

	AchEarnPrestige1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "CosmeticsPoints" },
				Comparison = ">=",
				Value = 10000,
			},
		},
	},
	
	AchAllKeepsakes =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 33,
			},
		},
	},

	AchBounties1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "PackagedBountyClears" },
				UseLength = true,
				Comparison = ">=",
				Value = 20,
			},
		},
	},

	AchAllRandomStreak =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestRandomBountyClearStreak" },
			},
		},
	},

	AchAllRandomUnderworld =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "PackagedBountyClears", "PackageBountyRandomUnderworld_Difficulty2" },
			},
		},
	},

	AchBeatHecateNoArcana =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestBeatHecateWithoutArcana" },
			},
		},
	},

	AchHelpOdysseus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestHelpOdysseus" },
			},
		},
	},

	AchHelpDora =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestHelpDora" },
			},
		},
	},

	AchHelpHypnos =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestWakeHypnos" },
			},
		},
	},

	AchHelpArachne =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestHelpArachne" },
			},
		},
	},

	AchHelpNarcissusAndEcho =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestHelpNarcissusAndEcho" },
			},
		},
	},

	AchCatchFish =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestCatchFish" },
			},
		},
	},

	AchBeatRivalsVow1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestMeetShrineAltBosses" },
			},
		},
	},

	AchBeatTyphonWithWeapons =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestBeatTyphonWithWeapons" },
			},
		},
	},

	AchBeatChronosWithArcana =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestBeatChronosWithArcana" },
			},
		},
	},

	AchClearWithAllAspects =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestClearedWithAllAspects" },
			},
		},
	},

	AchClearChaosQuest =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsCompleted", "QuestChaosKeepsakeFullRun" },
			},
		},
	},

	AchNemesisCombat =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "NemesisBetWinnings" },
				Comparison = ">=",
				Value = 1000,
			},
		},
	},

	AchFamiliarCostumes =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny =
				{
					"FamiliarCostume_FrogChthonic",
					"FamiliarCostume_FrogCute",
					"FamiliarCostume_FrogMoon",
					"FamiliarCostume_FrogNightmare",
				},
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny =
				{
					"FamiliarCostume_CatChthonic",
					"FamiliarCostume_CatHell",
					"FamiliarCostume_CatMoon",
					"FamiliarCostume_CatNightmare",
				},
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny =
				{
					"FamiliarCostume_RavenChthonic",
					"FamiliarCostume_RavenCute",
					"FamiliarCostume_RavenMoon",
					"FamiliarCostume_RavenNightmare",
				},
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny =
				{
					"FamiliarCostume_HoundChaos",
					"FamiliarCostume_HoundHell",
					"FamiliarCostume_HoundMoon",
					"FamiliarCostume_HoundNightmare",
				},
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny =
				{
					"FamiliarCostume_PolecatChthonic",
					"FamiliarCostume_PolecatCute",
					"FamiliarCostume_PolecatHell",
					"FamiliarCostume_PolecatNightmare",
				},
			},
		},
	},

	AchKillWitchAsSheep =
	{
		InheritFrom = { "DefaultAchievement" },
		IgnoreProgressCheck = true,
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "MapState", "HostilePolymorph" },
			},
		},
	},
	
	AchSummonSiren =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "SpellSummons", },
				HasAny = { "SirenKeytarist", "SirenDrummer" },
			},
		},
	},

	AchTartarusInDress =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered", },
				HasAny = { "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = GameData.AllArachneCostumes,
			},
		},
	},

	AchEarnStatue1 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
			},
		},
	},

	AchEarnStatue2 =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
			},
		},
	},


	AchWinSecretContest =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EnemyKills", "Zagreus" },
			},
		},
	},

	AchTrueEnding =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "TrueEndingFinale01" },
			},
		},
	},
	
	AchEpilogue =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
			},
		},
	},

	AchAllOtherAch =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "AchievementsUnlocked" },
				UseLength = true,
				Comparison = ">=",
				Value = 49,
			},
		},
	},


}

AchievementOrderData =
{
	"AchClearErebus",
	"AchClearOceanus",
	"AchClearFields",
	"AchClearTartarus",
	"AchClearEphyra",
	"AchClearThessaly",
	"AchClearOlympus",
	"AchClearSummit",
	"AchCauldronSpells1",
	"AchBathHouse",
	"AchFishingPier",
	"AchTaverna",
	"AchForgeBonds",
	"AchProphecies1",
	"AchMaxMem",
	"AchAllArcana",
	"AchAllArcanaMax",
	"AchAllWeapons",
	"AchAllAspects",
	"AchConfideFrinos",
	"AchAllFamiliars",
	"AchAllFamiliarsMax",
	"AchEarnPrestige1",
	"AchAllKeepsakes",
	"AchBounties1",
	"AchAllRandomStreak",
	"AchAllRandomUnderworld",
	"AchBeatHecateNoArcana",
	"AchHelpOdysseus",
	"AchHelpDora",
	"AchHelpHypnos",
	"AchHelpArachne",
	"AchHelpNarcissusAndEcho",
	"AchCatchFish",
	"AchBeatRivalsVow1",
	"AchBeatTyphonWithWeapons",
	"AchBeatChronosWithArcana",
	"AchClearWithAllAspects",
	"AchClearChaosQuest",
	"AchNemesisCombat",
	"AchFamiliarCostumes",
	"AchKillWitchAsSheep",
	"AchSummonSiren",
	"AchTartarusInDress",
	"AchEarnStatue1",
	"AchEarnStatue2",
	"AchWinSecretContest",
	"AchTrueEnding",
	"AchEpilogue",
	"AchAllOtherAch",
}