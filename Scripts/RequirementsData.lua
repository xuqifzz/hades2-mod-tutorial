NamedRequirementsData =
{
	AllWeaponsUnlocked =
	{
		{
			Path = { "GameState", "WeaponsUnlocked", },
			HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
		},
	},

	NotOpeningRoom =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name", },
			IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01", "G_Intro", "H_Intro", "I_Intro", "O_Intro", "P_Intro", "Q_Intro" },
		},
	},
	WeaponsNotAllowed =
	{
		{
			Path = { "CurrentHubRoom", "Name" },
			IsAny = { "Hub_Main", "Flashback_Hub_Main", "Flashback_DeathAreaBedroomHades", "Flashback_DeathArea", }
		},
	},
	OlympianOnSpawnVoiceLinesAllowed =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP", "Shop" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name", },
			IsNone = { "F_PreBoss01", "F_Reprieve01", "G_PreBoss01", "G_Reprieve01", "I_Reprieve01", "O_PreBoss01", "O_Reprieve01", "P_PreBoss01" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName", },
			IsNone = { "H" },
		},
	},
	IsDevotionEncounter =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsAny = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP", "DevotionTestQ", },
		},
	},
	NightmarePresentationRequirements =
	{
		{
			PathFalse = { "CurrentRun", "Cleared" }
		},
		{
			PathFalse = { "CurrentRun", "ActiveBounty" },
		},
		{
			PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny =
			{
				"ChronosReveal01B",
				"ChronosRevealFollowUp",
				"ChronosBossFirstMeeting",
				"ChronosBossFirstMeeting_B",
				"ChronosBossFirstMeeting_C",
			},
		},
		{
			Path = { "CurrentRun", "WorldUpgradesAdded" },
			HasNone = { "WorldUpgradeQuestLog", "WorldUpgradeMorosUnlock" },
		},
		{
			Path = { "CurrentRun", "SpeechRecord" },
			HasNone = { "/VO/Melinoe_0564" },
		},
		{
			Path = { "PrevRun", "WorldUpgradesAdded" },
			HasNone = { "WorldUpgradeQuestLog", "WorldUpgradeMorosUnlock" },
		},
		NamedRequirementsFalse = { "MorosFirstSurfaceAppearance" },
	},
	QuestLogUnlocked =
	{
		{
			PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeQuestLog" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
		},
	},
	RainStateUnlocked =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = "==",
			Value = 4,
		},
	},
	HeraUnlocked =
	{
		{
			PathFalse = { "GameState", "UseRecord", "HeraUpgrade" },
		},
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
		},
		{
			PathFalse = { "PrevRun", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
		},
	},
	HephaestusUnlocked =
	{
		{
			PathFalse = { "GameState", "UseRecord", "HephaestusUpgrade" },
		},
		{
			Path = { "GameState", "UseRecord" },
			HasAll = { "ZeusUpgrade" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "ZeusFirstPickUp" },
		},
		{
			Path = { "PrevRun", "TextLinesRecord" },
			HasNone = { "ZeusFirstPickUp" },
		}
	},
	ErisUnlocked =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = {
				"MorosGrantsQuestLog",
				"MorosSecondAppearance",
				"MorosGrantsSurfacePenaltyCure01",
				"NarcissusFirstMeeting",
				"EchoFirstMeeting",
				"ChronosNightmare01",
				"ChronosRevealFollowUp",
				"ChronosBossFirstMeeting",
				"ChronosBossFirstMeeting_B",
				"ChronosBossFirstMeeting_C",
				-- "HeraclesFirstMeeting",
				"MedeaFirstMeeting",
				-- "PolyphemusFirstMeeting",
			},
		},
		{
			Path = { "GameState", "RoomsEntered", "N_Opening01" },
			Comparison = ">=",
			Value = 2,
		},
	},
	ErisCurseHealthThreshold =
	{
		{
			Path = { "CurrentRun", "Hero", "LastStands" },
			UseLength = true,
			Comparison = "<=",
			Value = 0,
		},
		{
			FunctionName = "RequiredHealthFraction",
			FunctionArgs = { Comparison = "<=", Value = 0.5, },
		},
	},
	HecateFamiliarsInHub =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = "<=",
			Value = 12,
		}
	},

	NoGreetingToScylla =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutChlams01" },
		},
		{
			PathFalse = { "GameState", "WorldUpgradesAdded", "ScyllaAboutChlams02" },
		},
	},

	ArachneBrooding =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutGods01" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", " ArachneAboutGods05" },
		},
	},

	NarcissusDirtyWater =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus04" },
		},
		{
			PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNarcissusWaters" },
		},
	},

	PylonObjectiveRevealed =
	{
		{
			Path = { "GameState", "EnemyKills", "SoulPylon" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
		},
		{
			Path = { "GameState", "SpeechRecord" },
			HasAny = { "/VO/MelinoeField_0619", "/VO/MelinoeField_0414" }
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "Name", },
			IsNone = { "N_PreHub01" },
		},
	},

	DevotionTestUnlocked =
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
		},
		-- RequiredMinAnyTextLines counterpart example
		{
			Path = { "GameState", "TextLinesRecord" },
			CountOf = { "ZeusAboutSurface01", "ZeusAboutSurface02", "HermesAboutSurface02", "AphroditeAboutSurface02", "AphroditeAboutSurface03", "PoseidonAboutSurface03" },
			Comparison = ">=",
			Value = 2,
		},
		{
			Path = { "GameState", "RoomCountCache", "N_Hub" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "RoomCountCache", "N_Boss01" },
			Comparison = ">=",
			Value = 1,
		},
	},

	ForceSecretDoorRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = {  "F_PreBoss01", "F_Boss01", "F_PostBoss01",
					 	"G_PreBoss01", "G_Boss01", "G_PostBoss01",
						"H_PreBoss01", "H_Boss01", "H_PostBoss01",
						"I_PreBoss01", "I_Boss01", "I_PostBoss01", "I_Intro",
						"N_PreBoss01", "N_Boss01", "N_PostBoss01",
						"O_PreBoss01", "O_Boss01", "O_PostBoss01",
						"P_PreBoss01", "P_Boss01", "P_PostBoss01", },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "Anomaly" },
		},
	},

	-- Flashback01 / Hecate Flashback
	Flashback01Unlocked =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "HecateHideAndSeekIntro01" },
		},
		{
			PathTrue = { "CurrentRun", "RoomCountCache", "F_Boss01" },
		},
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 2,
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "MorosGrantsQuestLog", "MorosSecondAppearance" },
		},
		-- will not occur if you reach the final boss for the first time
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "ChronosBossFirstMeeting" },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines = { "ChronosNightmare01" }, Min = 3 },
		},
	},
	-- Flashback02 / Hades Flashback
	Flashback02Unlocked =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
		},
		{
			PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
		},
		{
			PathTrue = { "CurrentRun", "BiomesReached", "I" },
		},
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "MorosGrantsQuestLog", "MorosSecondAppearance", "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C", "ChronosBossOutro01", "HadesFirstMeeting", "HadesFirstMeeting_B", "HadesFirstMeeting_C" },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines = { "HecateHideAndSeekIntro01" }, Min = 3 },
		},
	},

	MailboxUnlocked =
	{
		--[[
		{
			PathTrue = { "CurrentRun", "Hero", "IsDead" },
		},
		]]--
		{
			Path = { "GameState", "MoneySpentTowardCharonPoints" },
			Comparison = ">=",
			Value = 1000,
		},
	},

	AlchemyUnlocked =
	{
		{
			Path = { "GameState", "WorldUpgradesViewed" },
			HasAll = { "WorldUpgradeAltRunDoor" },
		},
		{
			Path = { "CurrentRun", "WorldUpgradesRevealed" },
			HasNone = { "WorldUpgradeAltRunDoor" },
		},
	},

	MorosUnlocked =
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
		},
		{
			PathFalse = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
		},
		{
			PathTrue = { "GameState", "ScreensViewed", "QuestLog" },
		},
	},
	MorosFirstSurfaceAppearance =
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasAny = { "SurfacePenalty" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
		},
		{
			PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
		},
	},

	FatesQuestUnlocked =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
		},
		{
			PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines = { "MorosFirstMeeting" }, Min = 2 },
		},
	},

	UsedTimeSlowAgainstChronos =
	{
		{
			PathTrue = { "GameState", "Flags", "UsedSlowAgainstChronos" },
		},
	},

	NarcissusInFields =
	{
		{
			PathFalse = { "CurrentRun", "RoomsEntered", "G_Story01" }
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters03" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "NarcissusAboutWaters03" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "NarcissusWithEcho02" },
		},
	},

	BountyBoardUnlockAvailable =
	{
		{
			Path = { "GameState", "UseRecord", "TrialUpgrade" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			HasAll = { "WorldUpgradeSurfacePenaltyCure" },
		},
		{
			Path = { "PrevRun", "WorldUpgradesAdded" },
			HasNone = { "WorldUpgradeSurfacePenaltyCure" },
		},
	},
	PackageBountyBiomeF =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossHecate01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeG =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossScylla01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeH =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossInfestedCerberus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeI =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossChronos01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeN =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossPolyphemus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeO =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossEris01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeP =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "BossPrometheus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	--[[
	PackageBountyBiomeQ =
	{
		{
			Path = { "GameState", "EncountersOccurredCache", "Boss" },
			Comparison = ">=",
			Value = 1
		},
	},
	]]

	ShrineUnlocked =
	{
		{
			PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
		},
		{
			Path = { "GameState", "EnemyKills", "Chronos" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "GameState", "ClearedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		--[[ @ these can be used as well
		{
			Path = { "GameState", "ClearedUnderworldRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "GameState", "ClearedSurfaceRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		]]--
	},
	TrophyQuestUnlocked =
	{
		{
			PathTrue = { "GameState", "ScreensViewed", "Shrine" },
		},
		{
			Path = { "GameState", "ClearedUnderworldRunsCache" },
			Comparison = ">=",
			Value = 5,
		},
		{
			Path = { "GameState", "ClearedSurfaceRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		NamedRequirements =  { "ShrineUnlocked" },
	},
	TrophyQuestStage1Complete =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 8,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 8,
		},
	},
	TrophyQuestStage1CheckA =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 8,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = "<",
			Value = 8,
		},
	},
	TrophyQuestStage1CheckB =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = "<",
			Value = 8,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 8,
		},
	},


	TrophyQuestStage2Complete =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 16,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 16,
		},
	},
	TrophyQuestStage2CheckA =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 16,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = "<",
			Value = 16,
		},
	},
	TrophyQuestStage2CheckB =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = "<",
			Value = 16,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 16,
		},
	},

	TrophyQuestStage3Complete =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 32,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 32,
		},
	},
	TrophyQuestStage3CheckA =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = ">=",
			Value = 32,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = "<",
			Value = 32,
		},
	},
	TrophyQuestStage3CheckB =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
		},
		{
			Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
			Comparison = "<",
			Value = 32,
		},
		{
			Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
			Comparison = ">=",
			Value = 32,
		},
	},

	CosmeticsShopAvailable =
	{
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "DoraListless03", "DoraGift01" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "DoraAboutChronos01", "DoraAboutChronosBossW01" }
		},
		{
			Path = { "PrevRun", "WorldUpgradesAdded" },
			HasNone = { "WorldUpgradeAltRunDoor", "WorldUpgradeSurfacePenaltyCure" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "MorosGrantsSurfacePenaltyCure01", "ChronosNightmare01" },
		},
		{
			Path = { "GameState", "WorldUpgrades", },
			CountOf = ScreenData.GhostAdmin.ItemCategories[1],
			Comparison = ">=",
			Value = 40,
		},
	},
	CosmeticsShopUnlocked =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
		},
	},
	CosmeticsShopNotUnlocked =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
		},
	},
	CosmeticsShopHasNewItems =
	{
		{
			FunctionName = "HasNewCosmeticsAvailable",
		}
	},
	CosmeticsShopHasUnpurchasedItems =
	{
		{
			FunctionName = "HasUnpurchasedCosmetics",
		},
	},

	GiftDropLootRequirements = 
	{
		{
			Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
			Comparison = ">=",
			Value = 150,
		}
	},
	BlindBoxLootRequirements =
	{
		{
			Path = { "GameState", "UseRecord" },
			HasAll = {
				"ZeusUpgrade",
				"PoseidonUpgrade",
				"ApolloUpgrade",
				"DemeterUpgrade",
				"AphroditeUpgrade",
				"HephaestusUpgrade",
				"HestiaUpgrade",
			},
		},
	},
	HammerLootRequirements = 
	{
		-- unlock requirements
		{
			Path = { "GameState", "TextLinesRecord" },
			CountOf =
			{
				"PoseidonFirstPickUp",
				"DemeterFirstPickUp",
				"HestiaFirstPickUp", 
				"AphroditeFirstPickUp",
				"ZeusFirstPickUp",
			},
			Comparison = ">=",
			Value = 4,
		},

		-- run requirements
		{
			FunctionName = "RequiredNotInStore",
			FunctionArgs = { Name = "WeaponUpgradeDrop", },
		},
		{
			PathFalse = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
		},
	},
	
	LateHammerLootRequirements = 
	{
		-- unlock requirements
		{
			Path = { "GameState", "TextLinesRecord" },
			CountOf =
			{
				"PoseidonFirstPickUp",
				"DemeterFirstPickUp",
				"HestiaFirstPickUp", 
				"AphroditeFirstPickUp",
				"ZeusFirstPickUp",
			},
			Comparison = ">=",
			Value = 4,
		},

		-- run requirements
		{
			FunctionName = "RequiredNotInStore",
			FunctionArgs = { Name = "WeaponUpgradeDrop", },
		},
		{
			Path = { "CurrentRun", "ClearedBiomes" },
			Comparison = ">",
			Value = 2,
		},
		{
			Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
			Comparison = "==",
			Value = 1,
		},
	},
	StackUpgradeLegal =
	{
		{
			Path = { "CurrentRun", "Hero", "UpgradableTraitCount" },
			Comparison = ">=",
			Value = 1,
		},
	},

	HermesUpgradeRequirements =
	{
		-- unlock requirements
		{
			PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
		},

		-- run requirements
		{
			FunctionName = "RequiredNotInStore",
			FunctionArgs = { Name = "ShopHermesUpgrade", },
		},
		{
			Path = { "CurrentRun", "BiomeUseRecord", },
			HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
		},
		{
			Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
			Comparison = "<=",
			Value = 1,
		},
	},

	SpellDropRequirements =
	{
		-- unlock requirements
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
		},

		-- run requirements
		{
			FunctionName = "RequiredNotInStore",
			FunctionArgs = { Name = "SpellDrop", },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "ChosenRewardType", },
			IsNone = { "SpellDrop", },
		},
		{
			PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
		},
		{
			PathFalse = { "CurrentRun", "PendingSpellDrop" },
		},
	},

	TalentLegal =
	{
		-- unlock requirements
		{
			Path = { "GameState", "UseRecord", "SpellDrop" },
			Comparison = ">=",
			Value = 4,
		},

		-- run requirements
		{
			FunctionName = "RequiredNotInStore",
			FunctionArgs = { Name = "TalentDrop", },
		},
		{
			PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
		},
		{
			PathFalse = { "CurrentRun", "AllSpellInvestedCache", },
		},
	},

	LastStandAvailable =
	{
		{
			Path = { "CurrentRun", "Hero", "LastStands" },
			UseLength = true,
			Comparison = ">",
			Value = 0,
		},
	},
	MissingLastStand =
	{
		{
			Path = { "CurrentRun", "Hero", "LastStands", },
			UseLength = true,
			Comparison = "<",
			ValuePath = { "CurrentRun", "Hero", "MaxLastStands" },
		},
	},

	NoHitShieldAvailable = 
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary", },
			HasNone = { "ReserveManaHitShieldBoon" },
		},
	},

	RerollAvailable =
	{
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary", },
			HasAny = { "PanelRerollMetaUpgrade", "RerollTradeOffMetaUpgrade", "DoorRerollMetaUpgrade", },
		},
	},

	ChaosUnlocked =
	{
		{
			PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
		},
		{
			PathFalse = { "CurrentRun", "TextLinesRecord", "HermesFirstPickUp" },
		},
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasNone = { "SurfacePenalty" },
		},
	},

	ChaosLegacyTraitsAvailable =
	{
		{
			Path = { "GameState", "UseRecord", "TrialUpgrade" },
			Comparison = ">=",
			Value = 3,
		},
	},

	NoRecentChaosEncounter =
	{
		{
			SumPrevRooms = 10,
			Path = { "ForceSecretDoor" },
			ValuesToCount = { true },
			Comparison = "<=",
			Value = 0,
		},
	},

	NoRecentNemesisEncounter =
	{
		{
			SumPrevRooms = 24,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisRandomEvent", "BridgeNemesisRandomEvent", },
			Comparison = "<=",
			Value = 0,
		},
		{
			SumPrevRooms = 12,
			Path = { "Encounter", "NemesisShopping" },
			ValuesToCount = { true },
			Comparison = "<=",
			Value = 0,
		},
		{
			PathFalse = { "CurrentRun", "EncountersOccurredBiomeCache", "NemesisCombatH" },
		},
		{
			PathFalse = { "CurrentRun", "EncountersOccurredBiomeCache", "NemesisRandomEvent" },
		},
		{
			PathFalse = { "CurrentRun", "EncountersOccurredBiomeCache", "BridgeNemesisRandomEvent" },
		},
	},
	NoRecentHeraclesEncounter =
	{
		{
			SumPrevRooms = 20,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatO", },
			Comparison = "<=",
			Value = 0,
		},
		{
			SumPrevRooms = 10,
			Path = { "Encounter", "HeraclesShopping" },
			ValuesToCount = { true },
			Comparison = "<=",
			Value = 0,
		},
	},

	NoRecentFieldNPCEncounter =
	{
		{
			SumPrevRooms = 6,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount =
			{
				"ArtemisCombatIntro",
				"ArtemisCombatF",
				"ArtemisCombatF2",
				"ArtemisCombatG",
				"ArtemisCombatG2",
				"ArtemisCombatN",
				"ArtemisCombatN2",

				"NemesisCombatIntro",
				"NemesisCombatF",
				"NemesisCombatG",
				"NemesisCombatH",
				"NemesisRandomEvent",
				"BridgeNemesisRandomEvent",

				"HeraclesCombatIntro",
				"HeraclesCombatN",
				"HeraclesCombatN2",
				"HeraclesCombatO",
				"HeraclesCombatO2",
				"HeraclesCombatP",
				"HeraclesCombatP2",
				
				"IcarusCombatIntro",
				"IcarusCombatO",
				"IcarusCombatO2",
				"IcarusCombatP",
				"IcarusCombatP2",

				"AthenaCombatIntro",
				"AthenaCombatP",
			},
			Comparison = "<=",
			Value = 0,
		},
	},

	NoRecentInspectPointUsed =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">",
			Value = 0,
		},
		{
			SumPrevRooms = 5,
			Path = { "UseRecord", "InspectPoint" },
			Comparison = "<=",
			Value = 0,
		},
	},

	NotSpokenToOdysseusRecently =
	{
		{
			Path = { "GameState", "LastPlayOnceTextLinesGamePhaseTicksRecord", "NPC_Odysseus_01" },
			SubtractFromPath = { "GameState", "GamePhaseLifetimeTicks", },
			Value = 25,
			Comparison = ">=",
		},
	},

	AnyGhostAdminItemAffordable =
	{
		{
			FunctionName = "RequireAffordableItemInScreen",
			FunctionArgs = { Screen = "GhostAdmin", DataStore = "WorldUpgradeData", },
		},
	},

	CatFamiliarReadyToRecruit =
	{
		{
			Path = { "GameState", "Resources", "FamiliarPoints" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "SpecialInteractRecord", "CatFamiliar" },
		},
		{
			PathFalse = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
		},
	},

	RavenFamiliarReadyToRecruit =
	{
		{
			Path = { "GameState", "Resources", "FamiliarPoints" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "SpecialInteractRecord", "RavenFamiliar" },
		},
		{
			PathFalse = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
		},
	},

	HoundFamiliarReadyToRecruit =
	{
		{
			Path = { "GameState", "Resources", "FamiliarPoints" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "SpecialInteractRecord", "HoundFamiliar" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" },
		},
		{
			PathFalse = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
		},
	},

	OlympusMusic1PlayedLast =
	{
		{
			Path = { "GameState", "BiomeMusicLastFirstPlayed", "P", },
			IsAny = { "/Music/IrisMusicOlympus1_MC" },
		},
		{
			Path = { "CurrentRun", "BiomeMusicPlayCounts", "P" },
			Comparison = "<=",
			Value = 0,
		},
	},

	T2Cosmetic =
	{
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			CountOf = GameData.AllPurchaseableCosmetics,
			Comparison = ">=",
			Value = 5,
		}
	},
	T3Cosmetic =
	{
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			CountOf = GameData.AllPurchaseableCosmetics,
			Comparison = ">=",
			Value = 12,
		}
	},
	T4Cosmetic =
	{
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			CountOf = GameData.AllPurchaseableCosmetics,
			Comparison = ">=",
			Value = 25,
		}
	},
	T5Cosmetic =
	{
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			CountOf = GameData.AllPurchaseableCosmetics,
			Comparison = ">=",
			Value = 40,
		}
	},

	OlympusMusic2PlayedLast =
	{
		{
			Path = { "GameState", "BiomeMusicLastFirstPlayed", "P", },
			IsAny = { "/Music/IrisMusicOlympus2_MC" },
		},
		{
			Path = { "CurrentRun", "BiomeMusicPlayCounts", "P" },
			Comparison = "<=",
			Value = 0,
		},
	},

	MinibossCountShrineUpgradeActive =
	{
		{
			Path = { "GameState", "ShrineUpgrades", "MinibossCountShrineUpgrade" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathFalse = { "CurrentRun", "ShrineUpgradesDisabled", "MinibossCountShrineUpgrade" },
		},
	},
}

DebugData = DebugData or {}
DebugData.LegalGenericRequirementKeys = ToLookup(
{
	"PathTrue",
	"PathFalse",
	"PathEmpty",
	"PathNotEmpty",
	"Path",
	"PathFromArgs",
	"SumOf",
	"CountOf",
	"MaxOf",
	"ValuesToCount",
	"TableValuesToCount",
	"Comparison",
	"Value",
	"ValuePath",
	"ValuePathAddition",
	"UseLength",
	"Modulo",
	"SumPrevRooms",
	"CountPathTrue",
	"SumPrevRuns",
	"PathFromSource",
	"HasNone",
	"HasAny",
	"HasAll",
	"NotHasAll",
	"IsNone",
	"IsAny",
	"FunctionName",
	"FunctionArgs",
	"HintId",
})

DebugData.LegalNonGenericRequirementKeys = ToLookup(
{
	"Skip",
	"Force",
	"ChanceToPlay",
	"NamedRequirements",
	"NamedRequirementsFalse",
	"DeepInheritance",
	"Append",
})