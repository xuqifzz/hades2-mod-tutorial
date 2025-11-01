GameData.RunClearMessageData =
{
	DefaultMessage =
	{
		DebugOnly = true,
	},

	ClearUnderworldNumOne =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	ClearUnderworldNumTen =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	ClearUnderworldNumFifty =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 50,
			},
		},
	},
	ClearUnderworldNumOneHundred =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 100,
			},
		},
	},
	ClearUnderworldNumTwoFifty =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 250,
			},
		},
	},
	ClearUnderworldNumFiveHundred =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 500,
			},
		},
	},

	ClearSurfaceNumOne =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	ClearSurfaceNumTen =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	ClearSurfaceNumFifty =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 50,
			},
		},
	},
	ClearSurfaceNumOneHundred =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 100,
			},
		},
	},
	ClearSurfaceNumTwoFifty =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 250,
			},
		},
	},
	ClearSurfaceNumFiveHundred =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 500,
			},
		},
	},

	ClearNearDeath =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = "<=", Value = 0.05, },
			},
			{
				Path = { "CurrentRun", "Hero", "LastStands" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	ClearFullHealth =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 1.0, },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "LastStandsUsed", }
			},
		},
	},

	ClearHighMaxHealth =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "MaxHealth" },
				Comparison = ">=",
				Value = 550,
			},
		},
	},

	ClearHighMaxMana =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "MaxMana" },
				Comparison = ">=",
				Value = 550,
			},
		},
	},

	ClearHighArmor =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "HealthBuffer" },
				Comparison = ">=",
				Value = 100,
			},
		},
	},

	ClearTimeFast =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Fast...
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = "<=",
				Value = 720,
			},
			-- ...but not Very Fast
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = ">",
				Value = 600,
			},
		},
	},

	ClearTimeVeryFast =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = "<=",
				Value = 600,
			},
		},
	},

	ClearTimeSlow =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = ">=",
				Value = 3600,
			},
		},
	},
	
	ClearLowMetaUpgradeTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf = GameData.AllMetaUpgradeTraits,
				Comparison = "<=",
				Value = 3,
			},
		},
	},
	ClearHighMetaUpgradeTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf = GameData.AllMetaUpgradeTraits,
				Comparison = ">=",
				Value = 25,
			},
		},
	},
	ClearMoneyNone =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "Resources", "Money" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	ClearMoneyHigh =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "Resources", "Money" },
				Comparison = ">=",
				Value = 1000,
			},
		},
	},

	ClearAllUnderworldStoryRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAll = { "Story_Arachne_01", "Story_Narcissus_01", "Story_Echo_01", "Story_Hades_01" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "NemesisRandomEvent" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2" },
			},
		},
	},
	ClearAllSurfaceStoryRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAll = { "Story_Medea_01", "Story_Circe_01", "Story_Dionysus_01" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", "ArtemisCombatN", "ArtemisCombatN2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "AthenaCombatIntro", "AthenaCombatP", "AthenaCombatP02", },
			},
		},
	},
	ClearAllUnderworldReprieveRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomCountCache", },
				HasAll = { "F_Reprieve01", "G_Reprieve01", "I_Reprieve01", },
			},
		},
	},

	ClearRequiredIntactArachneDress =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny =
				{
					"AgilityCostume",
					"ManaCostume",
					"VitalityCostume",
					"HighArmorCostume",
					"CastDamageCostume",
					"IncomeCostume",
					"SpellCostume",
					"EscalatingCostume",
				},
			},
		},
	},

	ClearRequiredIntactIcarusArmor =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny =
				{
					"BreakExplosiveArmorBoon",
					"BreakInvincibleArmorBoon",
				},
			},
		},
	},

	ClearRequiredTraitsZeus =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SpawnKillBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"ZeusWeaponBoon",
					"ZeusSpecialBoon",
					"ZeusCastBoon",
					"ZeusSprintBoon",
					"ZeusManaBoon",
					"ZeusManaBoltBoon",
					"BoltRetaliateBoon",
					"CastAnywhereBoon",
					"FocusLightningBoon",
					"DoubleBoltBoon",
					"EchoExpirationBoon",
					"LightningDebuffGeneratorBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsPoseidon =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AmplifyConeBoon" }, 
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"PoseidonWeaponBoon",
					"PoseidonSpecialBoon",
					"PoseidonCastBoon",
					"PoseidonSprintBoon",
					"PoseidonManaBoon",
					"EncounterStartOffenseBuffBoon",
					"RoomRewardBonusBoon",
					"FocusDamageShaveBoon",
					"DoubleRewardBoon",
					"PoseidonStatusBoon",
					"PoseidonExCastBoon",
					"OmegaPoseidonProjectileBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsAphrodite =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "RandomStatusBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"AphroditeWeaponBoon",
					"AphroditeSpecialBoon",
					"AphroditeCastBoon",
					"AphroditeSprintBoon",
					"AphroditeManaBoon",
					"HighHealthOffenseBoon",
					"HealthRewardBonusBoon",
					"DoorHealToFullBoon",
					"WeakPotencyBoon",
					"WeakVulnerabilityBoon",
					"ManaBurstBoon",
					"FocusRawDamageBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsDemeter =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "InstantRootKill" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"DemeterWeaponBoon",
					"DemeterSpecialBoon",
					"DemeterCastBoon",
					"DemeterSprintBoon",
					"DemeterManaBoon",
					"CastNovaBoon",
					"PlantHealthBoon",
					"BoonGrowthBoon",
					"ReserveManaHitShieldBoon",
					"SlowExAttackBoon",
					"CastAttachBoon",
					"RootDurationBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsHera =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AllElementalBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"HeraWeaponBoon",
					"HeraSpecialBoon",
					"HeraCastBoon",
					"HeraSprintBoon",
					"HeraManaBoon",
					"DamageShareRetaliateBoon",
					"LinkedDeathDamageBoon",
					"BoonDecayBoon",
					"DamageSharePotencyBoon",
					"SpawnCastDamageBoon",
					"CommonGlobalDamageBoon",
					"OmegaHeraProjectileBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsApollo =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleExManaBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"ApolloWeaponBoon",
					"ApolloSpecialBoon",
					"ApolloCastBoon",
					"ApolloExCastBoon",
					"ApolloSprintBoon",
					"ApolloManaBoon",
					"ApolloRetaliateBoon",
					"PerfectDamageBonusBoon",
					"BlindChanceBoon",
					"ApolloBlindBoon",
					"ApolloCastAreaBoon",
					"DoubleStrikeChanceBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsHephaestus =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "WeaponUpgradeBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"HephaestusWeaponBoon",
					"HephaestusSpecialBoon",
					"HephaestusCastBoon",
					"HephaestusSprintBoon",
					"HephaestusManaBoon",
					"MassiveDamageBoon",
					"AntiArmorBoon",
					"HeavyArmorBoon",
					"ArmorBoon",
					"EncounterStartDefenseBuffBoon",
					"ManaToHealthBoon",
					"MassiveKnockupBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsHestia =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "BurnSprintBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"HestiaWeaponBoon",
					"HestiaSpecialBoon",
					"HestiaCastBoon",
					"HestiaSprintBoon",
					"HestiaManaBoon",
					"SacrificeBoon",
					"OmegaZeroBurnBoon",
					"CastProjectileBoon",
					"FireballManaSpecialBoon",
					"BurnExplodeBoon",
					"BurnArmorBoon",
					"BurnStackBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsAres =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoubleBloodDropBoon" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"AresWeaponBoon", 
					"AresSpecialBoon", 
					"AresCastBoon", 
					"AresSprintBoon", 
					"AresManaBoon",
					"AresExCastBoon",
					"RendBloodDropBoon",
					"AresStatusDoubleDamageBoon",
					"BloodDropRevengeBoon",
					"MissingHealthCritBoon",
					"AloneDamageBoon",
					"LowHealthLifestealBoon",
					"OmegaDelayedDamageBoon",
				},
				Comparison = ">=",
				Value = 6,
			},
		},
	},
	ClearRequiredTraitsHermes =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TimeStopLastStandBoon" },
			},
		},
	},
	ClearRequiredTraitsChaos =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ChaosLastStandBlessing" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"ChaosWeaponBlessing",
					"ChaosSpecialBlessing",
					"ChaosCastBlessing",
					"ChaosHealthBlessing",
					"ChaosRarityBlessing",
					"ChaosMoneyBlessing",
					"ChaosLastStandBlessing",
					"ChaosManaBlessing",
					"ChaosManaOverTimeBlessing",
					"ChaosExSpeedBlessing",
					"ChaosElementalBlessing",
					"ChaosManaCostBlessing",
					"ChaosSpeedBlessing",
					"ChaosDoorHealBlessing",
					"ChaosHarvestBlessing",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	ClearSynergyTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf = GameData.AllDuoBoons,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	ClearLegendaryTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf = GameData.AllLegendaryBoons,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	ClearElementalTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf = GameData.AllElementalBoons,
				Comparison = ">=",
				Value = 7,
			},
		},
	},

	ClearNoDamageTakenFromBosses =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				FunctionName = "ClearedBossEncountersWithNoDamage",
				FunctionArgs =
				{
					Encounters =
					{
						"BossHecate01",
						"BossHecate02",
						"BossPolyphemus01",
						"BossPolyphemus02",
						"BossScylla01",
						"BossScylla02",
						"BossEris01",
						"BossEris02",
						"BossInfestedCerberus01",
						"BossInfestedCerberus02",
						"BossPrometheus01",
						"BossPrometheus02",
						"BossChronos01",
						"BossChronos02",
						"BossTyphonHead01",
						"BossTyphonHead02",
					},
				},
			},
		},
	},

	ClearNoOlympianBoons =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "OlympianBoonCount" },
				Comparison = "==",
				Value = 0,
			},
		},
	},

	ClearHighOlympianBoons =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "UniqueGodCount" },
				Comparison = ">=",
				Value = 9,
			},
		},
	},

	ClearHighSacrificeBoons =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SacrificeTraitCount" },
				Comparison = ">=",
				Value = 6,
			},
		},
	},

	ClearHighSpentLastStands =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "LastStandsUsed" },
				Comparison = ">=",
				Value = 9,
			},
		},
	},

	ClearHighHammerCount =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "HammerCount" },
				Comparison = ">=",
				Value = 5,
			},
		},
	},

	ClearNoNPCs =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "Story_Arachne_01", "Story_Narcissus_01", "Story_Echo_01", "Story_Hades_01" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "NemesisRandomEvent" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "Story_Medea_01", "Story_Circe_01", "Story_Dionysus_01" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", "ArtemisCombatN", "ArtemisCombatN2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasNone = { "AthenaCombatIntro", "AthenaCombatP", "AthenaCombatP02", },
			},
			{
				PathFalse = { "CurrentRun", "ExpiredKeepsakes", "AthenaEncounterKeepsake" },
			},
		},
	},

	ClearHighFear =
	{
		InheritFrom = { "DefaultMessage" },
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpentShrinePointsCache" },
				Comparison = ">=",
				Value = 40,
			},
		},
	},
}

ScreenData.RunClear =
{
	MessagePriorities =
	{
		"ClearUnderworldNumOne",
		"ClearUnderworldNumTen",
		"ClearUnderworldNumFifty",
		"ClearUnderworldNumOneHundred",
		"ClearUnderworldNumTwoFifty",
		"ClearUnderworldNumFiveHundred",
		"ClearSurfaceNumOne",
		"ClearSurfaceNumTen",
		"ClearSurfaceNumFifty",
		"ClearSurfaceNumOneHundred",
		"ClearSurfaceNumTwoFifty",
		"ClearSurfaceNumFiveHundred",

		"ClearNoDamageTakenFromBosses",

		"ClearTimeVeryFast",
		"ClearTimeFast",
		"ClearTimeSlow",

		"ClearLowMetaUpgradeTraits",
		"ClearHighMetaUpgradeTraits",
		{
			"ClearNearDeath",
			"ClearFullHealth",
			"ClearHighMaxHealth",
			"ClearHighMaxMana",
			"ClearHighArmor",

			"ClearMoneyNone",
			"ClearMoneyHigh",

			"ClearAllUnderworldStoryRooms",
			"ClearAllSurfaceStoryRooms",
			"ClearAllUnderworldReprieveRooms",
			"ClearNoNPCs",

			"ClearRequiredTraitsZeus",
			"ClearRequiredTraitsPoseidon",
			"ClearRequiredTraitsAphrodite",
			"ClearRequiredTraitsDemeter",
			"ClearRequiredTraitsHera",
			"ClearRequiredTraitsApollo",
			"ClearRequiredTraitsHephaestus",
			"ClearRequiredTraitsHestia",
			"ClearRequiredTraitsAres",
			"ClearRequiredTraitsHermes",
			"ClearRequiredTraitsChaos",
			"ClearSynergyTraits",
			"ClearLegendaryTraits",
			"ClearElementalTraits",
			"ClearRequiredIntactArachneDress",
			"ClearRequiredIntactIcarusArmor",
		
			"ClearNoOlympianBoons",
			"ClearHighOlympianBoons",
			"ClearHighHammerCount",
			"ClearHighSacrificeBoons",
			"ClearHighSpentLastStands",
			"ClearHighFear",
		},		
	},

	BlockPause = true,
	
	Components = {},
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton

	OnCloseFinishedFunctionName = "GenericPresentation",
	OnCloseFinishedFunctionArgs =
	{
		PreWait = 0.5,
		InputBlock = "RunClearScreenClose",
	},

	MaxDamageDealtItems = 5,
	MaxDamageTakenItems = 5,

	DamageDealtRightOffset = 420,
	DamageDealtStartY = 420,
	DamageDealtSpacingY = 40,
	DamageDealtAmountOffsetX = 390,

	DamageTakenStartY = 735,

	DamageSourceFormat =
	{
		Font = "LatoMedium",
		FontSize = 20,
		LangFontSize = {
			{ Code = "ja", Value = 17.5 },
		},
		OffsetX = 0,
		LangOffsetX = {
			{ Code = "ja", Value = -10 },
		},
		Color = {241,241,241,255},
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 0 },
		ShadowOffset = {0, 0},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		}
	},

	DamageAmountFormat =
	{
		Font = "MonospaceNumericP22UndergroundSCMedium",
		FontSize = 21,
		Color = {255,237,153,255},
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 0 },
		ShadowOffset = {0, 0},
		Justification = "Right",
		DataProperties =
		{
			OpacityWithOwner = true,
		}
	},

	DamageSourceMap =
	{
		-- Cast
		ProjectileCast = "WeaponCast",
		DemeterCastBlast = "WeaponCast",
		ZeusCastStrike = "WeaponCast",
		WeaponAnywhereCast = "WeaponCast",
		ProjectileCastFireball = "WeaponCast",
		PoseidonCast = "WeaponCast",
		ApolloSingleCastStrike = "WeaponCast",
		ApolloCast = "WeaponCast",
		ApolloCastRapid = "WeaponCast",
		IcarusHazardExplosion = "WeaponCast",
		HeraCastSummonProjectile = "WeaponCast",
		HeraCastDamageProjectile = "WeaponCast",
		HephCastBlast = "WeaponCast",
		AphroditeCastProjectile = "WeaponCast",
		ProjectileAresSwordCast = "WeaponCast",
		AresProjectile = "WeaponCast",
		ArtemisCastVolley = "WeaponCast",
		WeaponCastProjectileHades = "WeaponCast",
		ProjectileCastLob = "WeaponCast",
		AthenaCastProjectile = "WeaponCast",
		MassiveSlamBlastCast = "WeaponCast",

		-- Blink / Sprint
		AphroditeRushProjectile = "WeaponBlink",
		HestiaSprintPuddle = "WeaponBlink",
		HephSprintBlast = "WeaponBlink",
		ZeusSprintStrike = "WeaponBlink",
		PoseidonSprintBlast = "WeaponBlink",
		PoseidonSprintSecondaryBlast = "WeaponBlink",
		HeraSprintProjectile = "WeaponBlink",
		ProjectileAresSwordWake = "WeaponBlink",
		AthenaRushProjectile = "WeaponBlink",

		-- Staff
		WeaponStaffSwing2 = "WeaponStaffSwing",
		WeaponStaffSwing3 = "WeaponStaffSwing",
		ProjectileSwing5 = "WeaponStaffSwing5",
		ProjectileStaffBall = "WeaponStaffBall",
		ShadeMercAspectSpiritball = "ShadeMerc",
		FamiliarLinkLaser = "FamiliarBuff",

		-- Dagger
		WeaponDagger2 = "WeaponDagger",
		WeaponDaggerMultiStab = "WeaponDagger",
		WeaponDaggerDouble = "WeaponDagger",
		WomboStrike = "TripleAspectStrike",

		-- Axe
		WeaponAxe2 = "WeaponAxe",
		ProjectileAxeOverhead = "WeaponAxe",
		ProjectileAxeSpecial = "WeaponAxeSpecial",
		ProjectileAxeBlock2 = "WeaponAxeSpecialSwing",
		HammerAxeNova = "WeaponAxe",
		ProjectileAxeNergalSlow = "WeaponAxe",
		ProjectileAxeNergalFast = "WeaponAxe",

		-- Torch
		ProjectileTorchBall = "WeaponTorch",
		ProjectileTorchOrbit = "WeaponTorchSpecial",
		ProjectileTorchGhost = "WeaponTorch",
		ProjectileTorchGhostExplosion = "WeaponTorch",
		ProjectileTorchGhostLarge = "ProjectileTorchWave",
		ProjectileTorchGhostLargeExplosion = "ProjectileTorchWave",
		ProjectileTorchBallEos = "ProjectileTorchWave",
		ProjectileTorchRepeatStrike = "ProjectileTorchWave",
		ProjectileTorchSupayBallEx = "ProjectileTorchWave",

		-- Lob
		ProjectileLob = "WeaponLob",
		WeaponLobPulse = "WeaponLob",
		WeaponLobChargedPulse = "ProjectileLobCharged",
		ProjectileLobOverheat = "ProjectileLobCharged",
		ProjectileGunThrowCharged = "ProjectileThrowCharged",

		-- Suit
		ProjectileSuit = "WeaponSuit",
		ProjectileSuit2 = "WeaponSuit",
		ProjectileSuitCharged = "WeaponSuitCharged",
		ProjectileSuitDash = "WeaponSuitDash",
		ProjectileSuitRangedGuided = "WeaponSuitRanged",
		WeaponSuitDouble = "WeaponSuit",
		ProjectileSuitGrenade = "WeaponSuitRanged",
		ProjectileSuitBomb = "ProjectileSuitRangedCharged",
		NyxSprintBlast = "NyxSprint",
		ProjectileSuitGrenadeStraight = "WeaponSuitRanged",
		ProjectileSuitBombStraight = "ProjectileSuitRangedCharged",

		-- Spells
		WeaponTransformAttack = "WeaponSpellTransform",
		WeaponTransformSpecial = "WeaponSpellTransform",
		SpellSummonMelee = "WeaponSpellSummon",
		SummonDeathWeapon = "WeaponSpellSummon",
		SpellLaserStartAoE = "WeaponSpellLaser",
		ProjectileSpellMiniMeteor = "WeaponSpellMeteor",
		PolymorphNova = "WeaponSpellPolymorph",
		MorphDamageProjectile = "WeaponSpellPolymorph",
		ZeusPolymorphStrike = "WeaponSpellPolymorph",
		DemeterTickEffect = "WeaponSpellTimeSlow",
		HephLeapBlast = "WeaponSpellLeap",

		WeaponMorphedAttack_Rat = "WeaponMorphedAttack",
		WeaponMorphedAttack_Pig = "WeaponMorphedAttack",
		-- HeroSkyTouchdown = "", Mel Olympus jump pad attack
		
		--Aphrodite
		AphroditeBurst = "HeartBurstPlural",

		--Apollo
		ApolloRetaliateStrike = "ApolloRetaliateBoon",

		--Ares
		ProjectileAresSwordEx = "OmegaDelayedDamageBoon",

		--Demeter
		DemeterSprintStorm = "SlowField",
		DemeterCastStorm = "SlowField",
		DemeterMiniStorm = "StormSpawnBoon",
		DemeterChillKill = "InstantRootKill",

		--Hephaestus
		MassiveSlamBlast = "MassiveSlam_Name",
		DelayedKnockbackEffect = "MassiveKnockupBoon",

		--Hera
		HeraDamageShareProjectile = "DamageShareRetaliateBoon",
		DamageShareDeath = "LinkedDeathDamageBoon",
		ProjectileHeraOmega = "OmegaHeraProjectileBoon",

		--Hestia
		BurnEffect = "Burn",
		ProjectileFireball = "FireballManaSpecialBoon",
		BurnNova = "BurnExplodeBoon",

		--Poseidon
		PoseidonSplashSplinter = "PoseidonSplash_Name",
		PoseidonCastSplashSplinter = "PoseidonSplash_Name",
		PoseidonOmegaWave = "OmegaPoseidonProjectileBoon",
		PoseidonEffectFont = "KnockbackAmplify",

		--Zeus
		ProjectileZeusSpark = "ChainLightning_Name",
		ZeusZeroManaStrike = "ZeusManaBoltBoon",
		ZeusRetaliateStrike = "BoltRetaliateBoon",

		-- Duos
		ZeusRootStrike = "RootStrikeBoon",
		HestiaBurnConsumeStrike = "BurnConsumeBoon",
		ManaRestoreBlast = "ManaRestoreDamageBoon",
		SteamBlast = "SteamBoon",
		ProjectileSprintBall = "PoseidonSplashSprintBoon",

		-- NPCs
		ArtemisSupportingFire = "SupportingFireBoon",
		HadesUrnDeath = "HadesManaUrnBoon",
		SpearWeaponSpin = "HadesDashSweepBoon",
		AthenaDeflectingProjectile = "AthenaProjectileBoon",
		ProjectileAthenaManaSpear = "ManaSpearBoon",
		IcarusArmorExplosion = "BreakExplosiveArmorBoon",
		IcarusExplosion = "OmegaExplodeBoon",
		MedeaStatusStrike = "NewStatusDamage",

		-- Traps
		ShadeMercSpiritball = "ShadeMerc",
		ShovelPointTrap = "Traps",
		ShovelPointBomb = "Traps",
		DestructibleTreeSplinter = "Traps",
		SteamWallBlast = "Traps",
		SteamWallTrap = "Traps",
		SteamTrap = "Traps",
		SteamTrapFast = "Traps",
		SteamCubeExplosion = "Traps",
		SteamCubeFused = "Traps",
		FireBarrelExplosion = "Traps",
		FireBarrel = "Traps",
		FireBarrelShips = "Traps",
		FireBarrelExplosionShips = "Traps",
		FireBarrelFireLob = "Traps",
		BlastCubeExplosion = "Traps",
		SpikeTrapClockwork = "Traps",
		SpikeTrapWeapon = "Traps",
		BeamTrap = "Traps",
		RubbleFall = "Traps",
		FieldsDestructiblePillarDestruction = "Traps",
		OilPuddle = "Traps",
		OilPuddle02 = "Traps",
		OilPuddle03 = "Traps",
		OilPuddle04 = "Traps",
		OilPuddleFire = "Traps",
		OilPuddleFire02 = "Traps",
		OilPuddleFire03 = "Traps",
		OilPuddleFire04 = "Traps",
		DestructibleMastSplinter = "Traps",
		GunBombImmolation = "Traps",
		LavaTile = "Traps",
		LavaTileTriangle01 = "Traps",
		LavaTileTriangle02 = "Traps",
		LavaTileWeapon = "Traps",
		LavaTileTriangle01Weapon = "Traps",
		LavaTileTriangle02Weapon = "Traps",
		RubbleFallOlympus = "Traps",
		PolyphemusBoulders = "Traps",
		PolyphemusBoulderSky = "Traps",
		ThornTreeThorn = "Traps",
		BrambleTrap = "Traps",
		BrambleTrapBush = "Traps",
		BloodMinePreFused = "Traps",
		IcicleSplinter = "Traps",
		TyphonSpike = "Traps",
		TyphonSpikeSplinter = "Traps",
		TyphonEggExplosion = "Traps",
		TyphonEgg = "Traps",
		TyphonEggLarge = "Traps",
		TyphonMine = "Traps",
		HestiaStatueFireball = "Traps",
		HestiaStatueFireRing = "Traps",
		DemeterStatueFrostStorm = "Traps",
		PoseidonStatueWave = "Traps",
		ZeusStatueChasingStorm = "Traps",

		-- Familiars
		CatFamiliarPounce = "CatFamiliar",
		FrogFamiliarLand = "FrogFamiliar",
		RavenFamiliarMelee = "RavenFamiliar",
		RavenFamiliarMelee_Crit = "RavenFamiliar",
		PolecatFamiliarMelee = "PolecatFamiliar",

		-- Devotions
		ZeusUpgradeRoomWeapon = "NPC_Zeus_01",
		PoseidonUpgradeRoomWeapon = "NPC_Poseidon_01",
		HestiaUpgradeRoomWeapon = "NPC_Hestia_01",
		ApolloUpgradeRoomWeapon = "NPC_Apollo_01",
		HeraUpgradeRoomWeapon = "NPC_Hera_01",
		DemeterUpgradeRoomWeapon = "NPC_Demeter_01",
		AphroditeUpgradeRoomWeapon = "NPC_Aphrodite_01",
		HephaestusUpgradeRoomWeapon = "NPC_Hephaestus_01",
		AresUpgradeRoomWeapon = "NPC_Ares_01",

		-- Misc
		SurfaceHealthPenalty = "SurfacePenalty",
		BiomeTimer = "BiomeSpeedShrineUpgrade",
	},

	DamageSourceTextOverrides =
	{
		WeaponCast = "CastSet",
		WeaponBlink = "DashSet",

		WeaponStaffSwing = "Attack",
		WeaponStaffSwing5 = "AttackEX",
		WeaponStaffDash = "DashStrike",
		WeaponStaffBall = "Special",
		ProjectileStaffBallCharged = "SpecialEX",

		WeaponDagger = "Attack",
		WeaponDaggerDash = "DashStrike",
		WeaponDagger5 = "AttackEX",
		WeaponDaggerThrow = "Special",
		ProjectileDaggerThrowCharged = "SpecialEX",

		WeaponAxe = "Attack",
		WeaponAxeDash = "DashStrike",
		WeaponAxeSpin = "AttackEX",
		WeaponAxeSpecial = "Special",
		WeaponAxeSpecialSwing = "SpecialEX",

		WeaponTorch = "Attack",
		ProjectileTorchWave = "AttackEX",
		WeaponTorchSpecial = "Special",
		ProjectileTorchOrbitEx = "SpecialEX",

		WeaponLob =  "Attack",
		ProjectileLobCharged = "AttackEX",
		WeaponLobSpecial = "Special",
		ProjectileThrowCharged = "SpecialEX",

		WeaponSuit = "Attack",
		WeaponSuitDash = "DashStrike",
		WeaponSuitCharged = "AttackEX",
		WeaponSuitRanged = "Special",
		ProjectileSuitRangedCharged = "SpecialEX",

		WeaponSpellTransform = "SpellTransformTrait",
		WeaponSpellMeteor = "SpellMeteorTrait",
		WeaponSpellLaser = "SpellLaserTrait",
		WeaponSpellSummon = "SpellSummonTrait",
		WeaponSpellLeap = "SpellLeapTrait",
		WeaponSpellPolymorph = "SpellPolymorphTrait",
		WeaponSpellTimeSlow = "SpellTimeSlowTrait",
		WeaponSpellMoonBeam = "SpellMoonBeamTrait",
	},
	
	ComponentData =
	{
		DefaultGroup = "HUD_Main",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"VictoryBackground",
			"ActionBarBackground",
			
			"StatsBacking",
			"BadgeRankIcon",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		VictoryBackground =
		{
			Animation = "VictoryScreenIllustration_Underworld",
			GroupName = "Combat_Menu",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.3,
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			GroupName = "HUD_Backing",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		UnderworldTitleText =
		{
			Text = "RunClearScreen_Title",
			X = ScreenCenterX,
			Y = 70,
			GroupName = "Combat_Menu_TraitTray_Overlay",
			TextArgs =
			{
				FontSize = 50,
				OffsetY = -21,
				Color = {245,255,225,255},
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,50,30,255}, ShadowOffset={0, 3},
				OutlineThickness = 0,
				Justification = "Center",
			},
		},

		UnderworldRunClearMessageText =
		{
			GroupName = "Combat_Menu_TraitTray_Overlay",
			X = ScreenCenterX,
			Y = 120,
			TextArgs =
			{
				Color = { 141, 253, 240, 255 },
				FontSize = 23,
				OffsetY = -10,
				Font = "P22UndergroundSCLight",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Center",
			},
		},

		SurfaceTitleText =
		{
			Text = "RunClearScreen_Title_Surface",
			X = ScreenCenterX,
			Y = 70,
			GroupName = "Combat_Menu_TraitTray_Overlay",
			TextArgs =
			{
				FontSize = 50,
				OffsetY = -21,
				Color = {255,255,215,255},
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {80,40,0,255}, ShadowOffset={0, 3},
				OutlineThickness = 0,
				Justification = "Center",
			},
		},

		SurfaceRunClearMessageText =
		{
			GroupName = "Combat_Menu_TraitTray_Overlay",
			X = ScreenCenterX,
			Y = 120,
			TextArgs =
			{
				Color = { 253, 240, 141, 255 },
				FontSize = 23,
				OffsetY = -10,
				Font = "P22UndergroundSCLight",
				ShadowBlur = 0, ShadowColor = {80,40,0,255}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {80,40,0,255},
				Justification = "Center",
			},
		},

		BadgeRankIcon =
		{
			GroupName = "Combat_Menu_TraitTray_Overlay",
			RightOffset = 223,
			BottomOffset = 122,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.6,
			Scale = 0.50
		},

		StatsBacking = 
		{
			Animation = "GUI\\Screens\\VictoryScreenStatsBacking",
			GroupName = "Combat_Menu_TraitTray_Overlay",
			Scale = 0.5,
			RightOffset = 225,
			BottomOffset = 540,
		},

		RunStatsLabel =
		{
			RightOffset = 225,
			BottomOffset = 910,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Text = "RunClearScreen_RunStats",
			TextArgs =
			{
				Color = {234,234,234,255},
				FontSize = 22,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Center",
			},
		},

		ClearTimeLabel =
		{
			RightOffset = 415,
			BottomOffset = 845,
			Text = "RunClearScreen_ClearTime",
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 20,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
			},
		},
		ClearTimeValue =
		{
			RightOffset = 30,
			BottomOffset = 852,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 22,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},
		ClearTimeRecord =
		{
			RightOffset = 428,
			BottomOffset = 847,
			Alpha = 0.0,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Graphic = "VictoryScreenNewRecordMedal",
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 22,
				Font = "LatoSemiboldItalic",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		ShrinePointsLabel =
		{
			RightOffset = 415,
			BottomOffset = 805,
			Text = "RunClearScreen_ShrinePoints",
			Alpha = 0.0,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 20,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
				TextSymbolScale = 0.8,
			},
		},
		ShrinePointsValue =
		{
			RightOffset = 30,
			BottomOffset = 810,
			Alpha = 0.0,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 22,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},
		ShrinePointsRecord =
		{
			RightOffset = 428,
			BottomOffset = 804,
			Alpha = 0.0,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Graphic = "VictoryScreenNewRecordMedal",
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 22,
				Font = "LatoSemiboldItalic",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		DamageDealtLabel =
		{
			RightOffset = 225,
			BottomOffset = 725,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Text = "RunClearScreen_DamageDealt",
			TextArgs =
			{
				Color = {79,255,154,255},
				FontSize = 22,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		DamageTakenLabel =
		{
			RightOffset = 225,
			BottomOffset = 410,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Text = "RunClearScreen_DamageTaken",
			TextArgs =
			{
				Color = {199,74,49,255},
				FontSize = 22,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		CloseButton = 
		{
			Graphic = "ContextualActionButton",
			X = UIData.ContextualButtonXRight,
			BottomOffset = UIData.ContextualButtonBottomOffset,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "CloseRunClearScreen",
				ControlHotkeys = { "Cancel", },
			},
			Text = "Menu_Continue",
			TextArgs = UIData.ContextualButtonFormatRight,
		},
	},
}