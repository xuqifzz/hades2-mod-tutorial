NamedRequirementsData =
{
	AllWeaponsUnlocked =
	{
		{
			Path = { "GameState", "WeaponsUnlocked", },
			HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
		},
	},

	NotOpeningRoom =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name", },
			IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01", "G_Intro", "H_Intro", "I_Intro", "O_Intro", "P_Intro", "Q_Intro" },
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
			IsNone = { "F_PreBoss01", "F_Reprieve01", "G_PreBoss01", "G_Reprieve01", "I_Reprieve01", "O_PreBoss01", "O_Reprieve01", "P_PreBoss01", "P_Reprieve01" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName", },
			IsNone = { "H" },
		},
		{
			FunctionName = "RequiredAlive",
			FunctionArgs = { Units = { "NPC_Artemis_Field_01", "NPC_Nemesis_01", "NPC_Heracles_01", "NPC_Icarus_01", "NPC_Athena_01" }, Alive = false },
		},
		{
			FunctionName = "RequiredHealthFraction",
			FunctionArgs = { Comparison = ">=", Value = 0.2, },
		},
		NamedRequirementsFalse = { "FirstSurfaceVisit" },
	},
	FirstSurfaceVisit =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "N_Opening01" },
		},
		{
			Path = { "GameState", "RoomsEntered", "N_Opening01" },
			Comparison = "==",
			Value = 1,
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
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
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
	AresUnlocked =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "AresFirstPickUp" },
		},
		{
			Path = { "GameState", "RoomsEntered", "Q_Boss01" },
			Comparison = ">=",
			Value = 1,
		},
	},
	ErisUnlocked =
	{
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
	IcarusUnlockedInHub =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutCrossroads01" },
		},
	},
	IcarusLeavesHubAfterBecomingCloser =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "IcarusBecomingCloser01" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasNone = { "IcarusAboutBecomingCloser01", "IcarusAboutBecomingCloser01_B" },
		},
	},
	IcarusLeavesHubAfterTrueEnding =
	{
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "IcarusHomeFirstMeeting", "TrueEndingFinale01" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasNone = { "IcarusPostTrueEnding01", "IcarusPostTrueEnding01_B" },
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

	ScyllaEMActiveAndNotCleared =
	{
		{
			Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
			Comparison = ">=",
			Value = 2,
		},
		{
			Path = { "GameState", "EncountersCompletedCache" },
			HasNone = { "BossScylla02" },
		},
	},

	Scylla2UnlockedAndUnplayed =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAmbitions01" }
		},
		{
			PathTrue = { "GameState", "RoomsEntered", "G_PostBoss01" },
		},
		{
			PathFalse = { "GameState", "MusicRecord", "/Music/IrisMusicScylla2_MC"}
		},
	},

	ScyllaBalladUnlocked =
	{
		{
			Path = { "GameState", "EnemyKills", "Scylla" },
			Comparison = ">=",
			Value = 14,
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll =
			{
				"ScyllaAboutSongs02",
				"ScyllaAboutSongs03",
				"ScyllaAboutSongs04",
				-- "ScyllaAboutSongs05",
			},
		}
	},

	ScyllaBalladForced =
	{
		NamedRequirements = { "ScyllaBalladUnlocked" },
		NamedRequirementsFalse = { "ScyllaEMActiveAndNotCleared" },
		{
			PathFalse = { "GameState", "ScyllaDefeatMusicRecord", "/Music/IrisMusicScylla4_MC" }
		},
	},

	-- @ needs to be on all his key events
	OdysseusWandering =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "OdysseusLooseEndsQuestComplete01" },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines = { "OdysseusLooseEndsQuestComplete01" }, Max = 4 },
		},
	},
	SawOdysseusOnBigStageRecently =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasAny = { "ScyllaAboutOdysseusQuest01", "ScyllaAboutOdysseusQuest02" }
		},
		{
			Path = { "CurrentRun", "RoomsEntered" },
			HasAny = { "G_Boss02" },
		},
	},

	ArachneBrooding =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutGods01" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "ArachneAboutGods05" },
		},
	},

	NarcissusDirtyWater =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus04" },
		},
		--[[
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "NarcissusGift03", "EchoGift03" },
		},
		]]--
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "NarcissusAboutEcho01", "NarcissusAboutEcho01B", "NarcissusAboutEcho02" },
		},
		{
			PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNarcissusWaters" },
		},
	},

	PastTartarusIntroFight =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName", },
			IsAny = { "I" },
		},
		{
			Path = { "CurrentRun", "BiomeDepthCache" },
			Comparison = ">",
			Value = 2,
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
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "N", "N_SubRooms" },
		},
	},

	MedeaPointsGiftable =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "N_Story01" },
		},
		{
			Path = { "GameState", "Resources", "MedeaPoints" },
			Comparison = ">=",
			Value = 1,
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
			CountOf = {
				"ZeusAboutSurface01",
				"ZeusAboutSurface02",
				"HeraAboutSurface01",
				"PoseidonAboutSurface01",
				"PoseidonAboutSurface03",
				"ApolloAboutSurface01",
				"DemeterAboutSurface01",
				"DemeterAboutSurface02",
				"HestiaAboutSurface01",
				"HephaestusAboutSurfaceIntro01",
				"HermesAboutSurface02",
				"HermesAboutSurface02B",
				"AphroditeAboutSurface02",
				"AphroditeAboutSurface03",
			},
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
			IsNone =
			{ 
				"F_PreBoss01", "F_Boss01", "F_Boss02", "F_PostBoss01", 
				"G_PreBoss01", "G_Boss01", "G_Boss02", "G_PostBoss01", 
				"H_PreBoss01", "H_Boss01", "H_Boss02", "H_PostBoss01", 
				"I_PreBoss01", "I_PreBoss02", "I_Boss01", "I_PostBoss01", "I_Intro",
				"N_PreBoss01", "N_Boss01", "N_Boss02", "N_PostBoss01", 
				"O_PreBoss01", "O_Boss01", "O_Boss02", "O_PostBoss01",
				"P_PreBoss01", "P_Boss01", "P_PostBoss01",
			},
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
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
		},
		--[[
		{
			Path = { "GameState", "WorldUpgradesViewed" },
			HasAll = { "WorldUpgradeAltRunDoor" },
		},
		{
			Path = { "CurrentRun", "WorldUpgradesRevealed" },
			HasNone = { "WorldUpgradeAltRunDoor" },
		},
		]]--
	},

	MorosUnlockedInHub =
	{
		{
			Path = { "GameState", "WorldUpgradesAdded" },
			HasAll = { "WorldUpgradeQuestLog", "WorldUpgradeMorosUnlock" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "MorosGrantsQuestLog", "MorosSecondAppearance" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "MorosGrantsSurfacePenaltyCure01" },
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
	TrueFatesQuestUnlocked =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "MorosPostTrueEnding02" },
		},
	},
	TrueFatesQuestCanBeCompleted =
	{
		-- Force = true,
		-- whosoever dares touch this, see also our emissary's counterpart, MorosAboutEpilogueProgress01
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll =
			{
					"PrometheusAboutMortals01",
					"HecateFishing02",
					"MorosTaverna02",
					"MorosAboutEpilogueProgress01",
					-- see also MorosAboutEpilogueProgress01
					-- "PrometheusAboutFates02",
					-- "HeraclesFieldAboutFates01",
					-- "MorosPostTrueEnding02",
			},
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" }
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
		},
	},
	AllQuestsCompleted =
	{
		{
			Path = { "GameState", "QuestsCompleted" },
			HasAll = QuestOrderData,
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
			PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters02" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "NarcissusAboutWaters03" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "NarcissusWithEcho03" },
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
			Path = { "GameState", "EncountersCompletedCache", "BossHecate01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeG =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossScylla01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeH =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossInfestedCerberus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeI =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossChronos01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeN =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossPolyphemus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeO =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossEris01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeP =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossPrometheus01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyBiomeQ =
	{
		{
			Path = { "GameState", "EncountersCompletedCache", "BossTyphonHead01" },
			Comparison = ">=",
			Value = 1
		},
	},
	PackageBountyRandom =
	{
		NamedRequirements = { "HasAllMetaCardsUnlocked" },
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "MetaUpgradeLimitLevel", },
			Comparison = ">=",
			Value = 15,
		},
		{
			Path = { "GameState", "ClearedSurfaceRunsCache" },
			Comparison = ">=",
			Value = 10,
		},
		{
			Path = { "GameState", "ClearedUnderworldRunsCache" },
			Comparison = ">=",
			Value = 10,
		},
		{
			Path = { "GameState", "WeaponsUnlocked", },
			HasAll =
			{
				"WeaponStaffSwing",
				"StaffClearCastAspect",
				"StaffSelfHitAspect",
				"StaffRaiseDeadAspect",
				"WeaponDagger",
				"DaggerBlockAspect",
				"DaggerHomingThrowAspect",
				"DaggerTripleAspect",
				"WeaponTorch",
				"TorchDetonateAspect",
				"TorchSprintRecallAspect",
				"TorchAutofireAspect",
				"WeaponAxe",
				"AxeArmCastAspect",
				"AxePerfectCriticalAspect",
				"AxeRallyAspect",
				"WeaponLob",
				"LobCloseAttackAspect",
				"LobImpulseAspect",
				"LobGunAspect",
				"WeaponSuit",
				"SuitHexAspect",
				"SuitMarkCritAspect",
				"SuitComboAspect",
			},
		},
		{
			Path = { "GameState", "GiftPresentation" },
			HasAll =
			{
				"ManaOverTimeRefundKeepsake",
				"BossPreDamageKeepsake",
				"ReincarnationKeepsake",
				"DoorHealReserveKeepsake",
				"DeathVengeanceKeepsake",
				"BlockDeathKeepsake",
				"EscalatingKeepsake",
				"BonusMoneyKeepsake",
				"TimedBuffKeepsake",
				"LowHealthCritKeepsake",
				"SpellTalentKeepsake",
				"ForceZeusBoonKeepsake",
				"ForceHeraBoonKeepsake",
				"ForcePoseidonBoonKeepsake",
				"ForceDemeterBoonKeepsake",
				"ForceApolloBoonKeepsake",
				"ForceAphroditeBoonKeepsake",
				"ForceHephaestusBoonKeepsake",
				"ForceHestiaBoonKeepsake",
				"ForceAresBoonKeepsake",
				"AthenaEncounterKeepsake",
				"SkipEncounterKeepsake",
				"ArmorGainKeepsake",
				"FountainRarityKeepsake",
				"UnpickedBoonKeepsake",
				"DecayingBoostKeepsake",
				"DamagedDamageBoostKeepsake",
				"BossMetaUpgradeKeepsake",
				"TempHammerKeepsake",
				"RandomBlessingKeepsake",
				"RarifyKeepsake",
				"HadesAndPersephoneKeepsake",
				"GoldifyKeepsake",
			},
		},
		{
			Path = { "GameState", "FamiliarsUnlocked", },
			HasAll =
			{
				"FrogFamiliar",
				"CatFamiliar",
				"RavenFamiliar",
				"HoundFamiliar",
				"PolecatFamiliar",
			},
		},
	},

	ShouldShowBountyInfoBanner =
	{
		{
			PathTrue = { "CurrentRun", "ActiveBounty" },
		},
		OrRequirements =
		{
			{
				{
					Path = { "SessionState", "MapLoads" },
					Comparison = "<=",
					Value = 1,
				},
			},
			{
				{
					Path = { "CurrentRun", "RunDepthCache" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},
	},

	StandardPackageBountyActive =
	{
		{
			PathTrue = { "CurrentRun", "ActiveBounty" },
		},
		{
			Path = { "CurrentRun", "ActiveBounty" },
			IsNone =
			{
				"PackageBountyRandomUnderworld_Difficulty1",
				"PackageBountyRandomUnderworld_Difficulty2",
				"PackageBountyRandomSurface_Difficulty1",
				"PackageBountyRandomSurface_Difficulty2",
			},
		},
	},

	ShrineUnlocked =
	{
		{
			PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
		},
		{
			Path = { "GameState", "ClearedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		OrRequirements =
		{
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 1,
				},
			},
			{
				-- unlocked from the start for resets
				{
					Path = { "GameState", "StoryResetCount" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
	},
	AllShrineBountiesCompleted =
	{
		{
			Path = { "GameState", "ShrineBountiesCompleted" },
			HasAll = ScreenData.Shrine.BountyOrder,
		}
	},
	TrophyQuestUnlocked =
	{
		{
			PathTrue = { "GameState", "ScreensViewed", "Shrine" },
		},
		{
			Path = { "GameState", "ClearedUnderworldRunsCache" },
			Comparison = ">=",
			Value = 4,
		},
		{
			Path = { "GameState", "ClearedSurfaceRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		NamedRequirements = { "ShrineUnlocked" },
		OrRequirements =
		{
			{
				NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
			},
			-- already revealed
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Skelly_0300" },
				},
			},
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
				},
			},
		},
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
			Value = 6,
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
			Value = 6,
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
			Value = 6,
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
			Value = 12,
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
			Value = 12,
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
			Value = 12,
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
			Value = 24,
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
			Value = 24,
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
			Value = 24,
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
			HasAny = { "DoraAboutChronos01", "DoraAboutChronosBossW01", "TrueEndingFinale01" }
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
	DoraMemoryQuestActive =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus04" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "DoraAboutMemories01" },
		},
	},
	DoraMemoryQuestResolutionInProgress =
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeDoraMemory" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "DoraAboutMemories05" },
		},
	},

	GiftDropLootRequirements = 
	{
		{
			Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
			Comparison = ">=",
			Value = 50,
		},
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
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
				"HephaestusFirstPickUp",
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
				"HephaestusFirstPickUp",
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
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "HermesFirstPickUp" },
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
		-- Selene is MIA during this
		NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
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
			FunctionName = "RequiredMissingLastStands",
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
			SumPrevRooms = 99,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "NemesisRandomEvent", "BridgeNemesisRandomEvent", },
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
			SumPrevRuns = 3,
			Path = { "TextLinesRecord" },
			TableValuesToCount = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
			Comparison = "<=",
			Value = 0,
		},
		{
			SumPrevRooms = 20,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", },
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
	NoRecentArachneEncounter =
	{
		{
			SumPrevRooms = 5,
			Path = { "EncountersOccurredCache", },
			TableValuesToCount = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN", },
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
				"NemesisCombatI",
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
			SumPrevRooms = 6,
			Path = { "UseRecord", "InspectPoint" },
			Comparison = "<=",
			Value = 0,
		},
	},

	NoRecentBecomingCloserEvent =
	{
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines =
				{
					"MorosBecomingCloser01",
					"NemesisPostCombatBecomingCloser01",
					"IcarusBecomingCloser01",
					"ErisBecomingCloser01",
				},
			Min = 3 },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines =
				{
					"ErisBecomingCloserChat01",
					"ErisBecomingCloserChat02",
					"ErisBecomingCloserChat03",
					"ErisBecomingCloserChat04",
					"ErisBecomingCloserChat05",
					"ErisBecomingCloserChat06",
				},
			Min = 9 },
		},
	},

	NemesisBecomingCloserAvailable =
	{
		{
			PathFalse = { "GameState", "TextLinesRecord", "NemesisPostCombatBecomingCloser01" },
		},
		{
			PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisPostCombatAboutRelationship02" }
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "NemesisPostCombatAboutRelationship02" },
		},
		NamedRequirements = { "NoRecentBecomingCloserEvent" },
	},

	ArtemisSingingBlockedByEvents =
	{
		OrRequirements =
		{
			-- recently serenaded by Scylla
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Boss01", "G_Boss02" }
				},
			},
			-- had a flashback
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = { "HecateHideAndSeek01", "ChronosNightmare01" },
				},
			},
			-- reached Chronos for the first time
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
				},
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = "==",
					Value = 1,
				},
			},
			-- reached Typhon for the first time
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Boss01" },
				},
				{
					Path = { "GameState", "RoomsEntered", "Q_Boss01" },
					Comparison = "==",
					Value = 1,
				},
			},
			-- true ending events & epilogue
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = { "ZagreusPastFirstMeeting", "ZeusPalaceFirstMeeting", "TrueEndingFinale01", "FatesEpilogue01" },
				},
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 3 },
				},
			},
			-- post-true ending before meeting her again in combat
			{
				NamedRequirements = { "ArtemisLeavesHubAfterTrueEnding" },
			},
		},
	},
	ArtemisLeavesHubAfterTrueEnding =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "TrueEndingFinale01" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasNone = { "ArtemisPostTrueEnding01" },
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

	PolecatFamiliarReadyToRecruit =
	{
		{
			Path = { "GameState", "Resources", "FamiliarPoints" },
			Comparison = ">=",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "SpecialInteractRecord", "PolecatFamiliar" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" },
		},
		{
			PathFalse = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar" },
		},
	},

	HecateFamiliarsCanBeRecruited =
	{
		{
			Path = { "GameState", "FamiliarsUnlocked" },
			CountOf =
			{
				"FrogFamiliar",
				"RavenFamiliar",
				"CatFamiliar",
			},
			Comparison = ">=",
			Value = 2,
		},
		{
			Path = { "GameState", "ExorcismSuccessesFamiliar" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "GameState", "SpecialInteractRecord" },
			HasAny = { "HoundFamiliar", "PolecatFamiliar" }
		},
		--[[
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" }
		},
		]]
		{
			Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
			Comparison = ">=",
			Value = 2,
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

	T1Cosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 2,
		}
	},

	T2Cosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 6,
		}
	},
	T3Cosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 15,
		}
	},
	T4Cosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 28,
		}
	},
	T5Cosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 45,
		}
	},

	T1TavernaCosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Taverna" },
			Comparison = ">=",
			Value = 1,
		},
	},

	T2TavernaCosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 6,
		},
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Taverna" },
			Comparison = ">=",
			Value = 2,
		},
	},

	T1HubMainCosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "HubMain" },
			Comparison = ">=",
			Value = 1,
		},
	},

	T2HubMainCosmetic =
	{
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
			Comparison = ">=",
			Value = 6,
		},
		{
			Path = { "GameState", "CosmeticsPurchasedCountCache", "HubMain" },
			Comparison = ">=",
			Value = 2,
		},
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

	SuitAspectsRevealed =
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
		},
		{
			PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit" },
		},
	},

	DieHardFanShadeRecruitable =
	{
		{
			PathTrue = { "GameState", "WeaponsUnlocked", "ToolExorcismBook" },
		},
		{
			PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3048" },
		},
		{
			PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3048" },
		},
	},

	StaffHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "CirceGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "StaffRaiseDeadAspect" } 
		},
	},
	DaggerHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ArtemisGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "DaggerTripleAspect" } 
		},
	},
	TorchHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "TorchAutofireAspect" } 
		},
	},
	AxeHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "CharonGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "AxeRallyAspect" } 
		},
	},
	LobHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "LobGunAspect" } 
		},
	},
	SuitHiddenAspectRevealInProgress =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsHiddenAspect01" }
		},
		{
			PathFalse = { "GameState", "WorldUpgradesRevealed", "SuitComboAspect" } 
		},
	},
	SeleneDuosUnlocked =
	{
		{
			PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
		},
		{
			PathTrue = { "GameState", "UseRecord", "AresUpgrade" },
		},
		{
			Path = { "GameState", "TraitsTaken" },
			HasAll =
			{
				"SpellTimeSlowTrait",
				"SpellSummonTrait",
				"SpellPotionTrait",
				"SpellLaserTrait",
				"SpellPolymorphTrait",
				"SpellLeapTrait",
				"SpellMeteorTrait",
				"SpellTransformTrait",
			},
		},
	},
	HasAllHiddenAspectsRevealed =
	{
		{
			Path = { "GameState", "WorldUpgradesRevealed" },
			HasAll = { "StaffRaiseDeadAspect", "DaggerTripleAspect", "TorchAutofireAspect", "AxeRallyAspect", "LobGunAspect", "SuitComboAspect" },
		},
	},

	HasAllMetaCardsUnlocked =
	{
		{
			PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "TradeOff", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked" },
		},
		{
			PathTrue = { "GameState", "MetaUpgradeState", "CardDraw", "Unlocked" },
		},
	},

	HasAllMetaCardsMaxed =
	{
		{
			Path = { "GameState", "MetaUpgradeState", "ChanneledCast", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "HealthRegen", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "CastCount", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "CastBuff", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "BonusHealth", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "BonusDodge", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "ManaOverTime", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "MagicCrit", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "SprintShield", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "LastStand", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "DoorReroll", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "StartingGold", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "RarityBoost", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "BonusRarity", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "TradeOff", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "ScreenReroll", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Level" },
			Comparison = ">=",
			Value = 3,
		},
		{
			Path = { "GameState", "MetaUpgradeState", "CardDraw", "Level" },
			Comparison = ">=",
			Value = 3,
		},
	},
	HasAllFrogUpgrades =
	{
		{
			Path = { "GameState", "FamiliarUpgrades" },
			HasAll =
			{
				"FrogHealthBonus",
				"FrogHealthBonus2",
				"FrogHealthBonus3",
				"FrogUses",
				"FrogUses2",
				"FrogUses3",
				"FrogDamage",
				"FrogDamage2",
				"FrogDamage3",
			},
		},
	},
	HasAllCatUpgrades =
	{
		{
			Path = { "GameState", "FamiliarUpgrades" },
			HasAll =
			{
				"CatLastStandHeal",
				"CatLastStandHeal2",
				"CatLastStandHeal3",
				"CatUses",
				"CatUses2",
				"CatUses3",
				"CatAttack",
				"CatAttack2",
				"CatAttack3",
			},
		},
	},
	HasAllRavenUpgrades =
	{
		{
			Path = { "GameState", "FamiliarUpgrades" },
			HasAll =
			{
				"RavenCritChanceBonus",
				"RavenCritChanceBonus2",
				"RavenCritChanceBonus3",
				"RavenUses",
				"RavenUses2",
				"RavenUses3",
				"RavenAttack",
				"RavenAttack2",
				"RavenAttack3",
			},
		},
	},
	HasAllHoundUpgrades =
	{
		{
			Path = { "GameState", "FamiliarUpgrades" },
			HasAll =
			{
				"HoundManaBonus",
				"HoundManaBonus2",
				"HoundManaBonus3",
				"HoundUses",
				"HoundUses2",
				"HoundUses3",
				"HoundAttack",
				"HoundAttack2",
				"HoundAttack3",
			},
		},
	},
	HasAllPolecatUpgrades =
	{
		{
			Path = { "GameState", "FamiliarUpgrades" },
			HasAll =
			{
				"PolecatDodgeBonus",
				"PolecatDodgeBonus2",
				"PolecatDodgeBonus3",
				"PolecatUses",
				"PolecatUses2",
				"PolecatUses3",
				"PolecatDamage",
				"PolecatDamage2",
				"PolecatDamage3",
			},
		},
	},

	RoomOnlyHasShovelPoint =
	{
		{
			PathTrue = { "CurrentRun", "CurrentRoom", "ShovelPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom" },
			HasNone = { "FishingPointSuccess", "PickaxePointSuccess", "ExorcismPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "HarvestPointsAllowed" },
			Comparison = "<=",
			Value = 0,
		},
	},
	RoomOnlyHasPickaxePoint =
	{
		{
			PathTrue = { "CurrentRun", "CurrentRoom", "PickaxePointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom" },
			HasNone = { "FishingPointSuccess", "ShovelPointSuccess", "ExorcismPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "HarvestPointsAllowed" },
			Comparison = "<=",
			Value = 0,
		},
	},
	RoomOnlyHasFishingPoint =
	{
		{
			PathTrue = { "CurrentRun", "CurrentRoom", "FishingPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom" },
			HasNone = { "PickaxePointSuccess", "ShovelPointSuccess", "ExorcismPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "HarvestPointsAllowed" },
			Comparison = "<=",
			Value = 0,
		},
	},
	RoomOnlyHasExorcismPoint =
	{
		{
			PathTrue = { "CurrentRun", "CurrentRoom", "ExorcismPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom" },
			HasNone = { "PickaxePointSuccess", "ShovelPointSuccess", "FishingPointSuccess" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "HarvestPointsAllowed" },
			Comparison = "<=",
			Value = 0,
		},
	},
	RoomOnlyHasHarvestPoint =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "HarvestPointsAllowed" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "CurrentRun", "CurrentRoom" },
			HasNone = { "PickaxePointSuccess", "ShovelPointSuccess", "FishingPointSuccess", "ExorcismPointSuccess" },
		},
	},
	NoFamiliarShovelPointFoundThisBiome =
	{
		{
			Path = { "GameState", "EquippedFamiliar" },
			IsAny = { "HoundFamiliar" },
		},
		{
			PathFalse = { "CurrentRun", "BiomeHarvestPointsSeen", "ShovelPoint" }
		},
	},
	NoFamiliarPickaxePointFoundThisBiome =
	{
		{
			Path = { "GameState", "EquippedFamiliar" },
			IsAny = { "RavenFamiliar" },
		},
		{
			PathFalse = { "CurrentRun", "BiomeHarvestPointsSeen", "PickaxePoint" }
		},
	},

	FullSuperVoiceLinesEligible =
	{
		OrRequirements =
		{
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H" },
				},
			},
		},
	},

	-- @ ending below this line
	-- used only for Moros DoomAppearance events
	TrueEndingCriticalPathEventOccurred =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasAny =
			{
				"ZagreusPastFirstMeeting",
				-- "ZagreusPastMeeting02",
				-- "ZagreusPastMeeting03",
				-- "ZagreusPastMeeting04",
				-- "ZagreusPastMeeting05",
				"ZagreusPastMeeting06",
				"ZagreusPastMeeting06_B",
				"ZeusPalaceFirstMeeting",
				-- "ZeusPalaceMeeting02",
				-- "ZeusPalaceMeeting03",
				-- "ZeusPalaceMeeting03_B",
				-- "ZeusPalaceMeeting04",
				-- "ZeusPalaceMeeting04_B",
				"ZeusPalaceAboutTyphonDeath01",
				"ZeusPalacePostTrueEnding01",
				"FatesEpilogue01",
			}
		}
	},
	
	InfiniteChronosDeathDefiance =
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" }
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},
	ClearBeforeTrueEnding =
	{
		{
			PathTrue = { "CurrentRun", "Cleared" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},

	NearTrueEnding =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
		},
		{
			PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeTimeStop" },
		},
		{
			PathFalse = { "CurrentRun", "ActiveBounty" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},
	JustBeforeOrAfterTrueEnding =
	{
		OrRequirements =
		{
			-- before
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
				},
			},
			-- after
			{
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Max = 2 },
				},
			},
		},
	},

	HasEverReachedTrueEnding =
	{
		OrRequirements =
		{
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
			},
			{
				{
					Path = { "GameState", "StoryResetCount" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
	},

	OlympusBiomeAfterTrueEnding =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "P" },
		},
	},

	HecateMissing =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "HecateBossKidnapped01" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},
	-- Nemesis goes off in search of Hecate after learning she's gone
	NemesisKnowsHecateMissing =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutHecateKidnapped01" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},

	AfterTrueEndingBeforeFinalBoss =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasNone =
			{
				"NeoChronosAboutTartarus01",
				"NeoChronosAboutOlympus01",
			},
		},
	},

	NeoChronosCanSpawnInErebus =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "F_PostBoss01" }
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny = { "NeoChronosAboutOlympus01", "NeoChronosAboutOlympus01_B" },
		},
	},

	SpawnNemesisWithNeoChronos =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAll = { "NemesisPostTrueEnding02", "NemesisPostCombatAboutTartarus03", "NemesisPostCombatPostTrueEnding01" },
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "NeoChronosWithNemesis01" },
		},
		-- NamedRequirements = { "NoRecentNemesisEncounter" },
	},

	NyxUnlockedInChaos =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "NyxWithNemesis01" },
		},
		NamedRequirementsFalse = { "StandardPackageBountyActive" },
	},

	InfernalContractUnlocked =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			Path = { "GameState", "TextLinesRecord" },
			HasAny =
			{
				"NeoChronosAboutTartarus01",
				"NeoChronosAboutOlympus01",
			},
		},
	},

	FatesDiscovered =
	{
		NamedRequirements = { "TrueFatesQuestCanBeCompleted" },
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "G" },
		},
		{
			SumPrevRooms = 3,
			CountPathTrue = true,
			Path = { "UsedBlockDeath" },
			Comparison = "==",
			Value = 3,
		},
	},
	FatesDiscoveredTooSoon =
	{
		NamedRequirementsFalse = { "TrueFatesQuestCanBeCompleted" },
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "G" },
		},
		{
			SumPrevRooms = 3,
			CountPathTrue = true,
			Path = { "UsedBlockDeath" },
			Comparison = "==",
			Value = 3,
		},
	},

	StalledProgressWithZagreus =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasAny = {
				"ZagreusPastMeeting07",
				"ZagreusPastMeetingRepeatable01",
				"ZagreusPastMeetingRepeatable02",
				"ZagreusPastMeetingRepeatable03",
				"ZagreusPastMeetingRepeatable04",
				"ZagreusPastMeetingRepeatable05",
			},
		},
	},

	SurfaceRouteLockedByTyphonKill =
	{
		{
			PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},

	SurfaceBountyLockedByTyphonKill =
	{
		{
			PathTrue = { "CurrentRun", "Hero", "IsDead" },
		},
		{
			PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
		},
		{
			PathFalse = { "GameState", "ReachedTrueEnding" },
		},
	},

	ReachedEpilogue =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
		},
	},
	ReachedEpilogueRecently =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
		},
		{
			FunctionName = "RequireRunsSinceTextLines",
			FunctionArgs = { TextLines = { "FatesEpilogue01" }, Max = 4 },
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
	"IgnoreCurrentRun",
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
	"OrRequirements",
	"DeepInheritance",
	"Append",
})