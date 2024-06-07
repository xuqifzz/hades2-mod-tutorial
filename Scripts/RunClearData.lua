GameData.RunClearMessageData =
{
	DefaultMessage =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
	},

	ClearUnderworldNumOne =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 1,
			},
		},
	},
	ClearUnderworldNumTen =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 10,
			},
		},
	},
	ClearUnderworldNumFifty =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 50,
			},
		},
	},
	ClearUnderworldNumOneHundred =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 100,
			},
		},
	},
	ClearUnderworldNumTwoFifty =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 250,
			},
		},
	},
	ClearUnderworldNumFiveHundred =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = "==",
				Value = 500,
			},
		},
	},

	ClearSurfaceNumOne =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 1,
			},
		},
	},
	ClearSurfaceNumTen =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 10,
			},
		},
	},
	ClearSurfaceNumFifty =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 50,
			},
		},
	},
	ClearSurfaceNumOneHundred =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 100,
			},
		},
	},
	ClearSurfaceNumTwoFifty =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 250,
			},
		},
	},
	ClearSurfaceNumFiveHundred =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = "==",
				Value = 500,
			},
		},
	},

	ClearNearDeath =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMaxHealthFraction = 0.05,
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
			RequiredMinHealthFraction = 1.0,
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
				Value = 400,
			},
		},
	},

	ClearTimeFast =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = "<=",
				Value = 900,
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
				Value = 720,
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

	--[[
	ClearNoOlympianBoons =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},
	]]

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
				HasAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisRandomEvent" },
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
				HasAll = { "Story_Medea_01", "Story_Circe_01", },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "ArtemisCombatN", "ArtemisCombatN2" },
			},
			{
				Path = { "CurrentRun", "EncountersCompletedCache", },
				HasAny = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2" },
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
	ClearAllUnderworldShopRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomCountCache", },
				HasAll = { "F_Shop01", "G_Shop01", "H_Bridge01", "I_Shop01", },
			},
			{
				PathTrue = { "CurrentRun", "EncountersCompletedCache", "BridgeShop" }
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
					"MinorLootBoon",
					"RoomRewardBonusBoon",
					"FocusDamageShaveBoon",
					"SlamExplosionBoon",
					"DoubleRewardBoon",
					"PoseidonStatusBoon",
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
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CharmCrowdBoon" },
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
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "HeraManaShieldBoon" },
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
					"SwapBonusBoon",
					"BoonDecayBoon",
					"DamageSharePotencyBoon",
					"LinkedDeathDamageBoon",
					"FullManaExBoostBoon",
					"CommonGlobalDamageBoon",
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
					"ApolloSprintBoon",
					"ApolloManaBoon",
					"ApolloRetaliateBoon",
					"PerfectDamageBonusBoon",
					"BlindChanceBoon",
					"ApolloBlindBoon",
					"ApolloMissStrikeBoon",
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
					"ChargeCounterBoon",
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
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "BurnStackBoon" },
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
					"BurnConsumeBoon",
					"BurnArmorBoon",
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
			--[[
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				CountOf =
				{
					"HermesWeaponBoon",
					"HermesSpecialBoon",
					"DodgeChanceBoon",
					"SorcerySpeedBoon",
					"HermesCastDiscountBoon",
					"ElementalUnifiedBoon",
					"SlowProjectileBoon",
					"HexCooldownBuffBoon",
					"MoneyMultiplierBoon",
					"TimedKillBuffBoon",
					"SprintShieldBoon",
				},
				Comparison = ">=",
				Value = 1,
			},
			]]
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
				-- CountOf = GameData.AllDuoBoons, -- simpler check
				CountOf =
				{
					"EmptySlotDamageBoon",
					"RaiseDeadBoon",
					"MoneyDamageBoon",
					"EchoAllBoon",
					"KeepsakeLevelBoon",
					"GoodStuffBoon",
					"ApolloSecondStageCastBoon",
					"PoseidonSplashSprintBoon",
					"CastRampBoon",
					"SprintEchoBoon",
					"MaximumShareBoon",
					"MaxHealthDamageBoon",
					"ManaBurstCountBoon",
					"EchoBurnBoon",
					"BurnOmegaBoon",
					"SteamBoon",
					"DoubleBurnBoon",
					"CoverRegenerationBoon",
					"ShadeMercFireballBoon",
					"ReboundingSparkBoon",
					"MassiveCastBoon",
					"ClearRootBoon",
					"MassiveAoEIncrease",
					"FirstHitHealBoon",
					"DoubleMassiveAttackBoon",
					"SuperSacrificeBoonZeus",
					"SuperSacrificeBoonHera",
					"LightningVulnerabilityBoon",
					"AllCloseBoon",
				},
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
				CountOf =
				{
					"CharmCrowdBoon",
					"DoubleExManaBoon",
					"InstantRootKill",
					"WeaponUpgradeBoon",
					"HeraManaShieldBoon",
					"BurnStackBoon",
					"AmplifyConeBoon",
					"SpawnKillBoon",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	--[[
	ClearChallengeSwitches =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearDevotionEncounters =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearShrineChallengeEncounters =
	{
		InheritFrom = { "DefaultMessage" },
	},

	ClearMiniBossEncounters =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearWeaponsFiredWrath =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearWeaponsFiredRanged =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearFishCaught =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearConsecutiveHigh =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearHealItems =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearStackUpgrades =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearGiftDrops =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearConsolationPrizes =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearManyLastStands =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearShutDownThanatos =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},

	ClearManyTraitsSold =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			-- Reimplement
		},
	},
	]]
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

		"ClearTimeVeryFast",
		"ClearTimeFast",
		"ClearTimeSlow",

		{
			"ClearNearDeath",
			"ClearFullHealth",
			"ClearHighMaxHealth",

			"ClearMoneyNone",
			"ClearMoneyHigh",

			"ClearAllUnderworldStoryRooms",
			"ClearAllSurfaceStoryRooms",
			"ClearAllUnderworldReprieveRooms",
			"ClearAllUnderworldShopRooms",

			"ClearRequiredTraitsZeus",
			"ClearRequiredTraitsPoseidon",
			"ClearRequiredTraitsAphrodite",
			"ClearRequiredTraitsDemeter",
			"ClearRequiredTraitsHera",
			"ClearRequiredTraitsApollo",
			"ClearRequiredTraitsHephaestus",
			"ClearRequiredTraitsHestia",
			"ClearRequiredTraitsHermes",
			"ClearRequiredTraitsChaos",
			"ClearSynergyTraits",
			"ClearLegendaryTraits",
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
		Font = "NumericP22UndergroundSCMedium",
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
		ProjectileCast = "WeaponCast",

		WeaponStaffSwing2 = "WeaponStaffSwing",	
		WeaponStaffSwing3 = "WeaponStaffSwing",	
		ProjectileStaffBall = "WeaponStaffBall",

		WeaponDagger2 = "WeaponDagger",
		WeaponDaggerMultiStab = "WeaponDagger",
		WeaponDaggerDouble = "WeaponDagger",

		WeaponAxe2 = "WeaponAxe",
		WeaponAxe3 = "WeaponAxe",
		ProjectileAxeBlockSpin = "WeaponAxeBlock2",
		ProjectileAxeBlock2 = "WeaponAxeSpecialSwing",

		ProjectileTorchBall = "WeaponTorch",
		ProjectileTorchSpiral = "WeaponTorchSpecial",
		ProjectileTorchExplosion = "WeaponTorch",

		ProjectileLob = "WeaponLob",
		ProjectileThrowCharged = "WeaponLobSpecial",
		WeaponLobPulse = "WeaponLob",
		WeaponLobChargedPulse = "WeaponLob",
		ProjectileSkullImpulseWave = "WeaponLobSpecial",
		WeaponSkullImpulse = "WeaponLobSpecial", -- LobImpulseAspect

		WeaponTransformAttack = "WeaponSpellTransform",
		WeaponTransformSpecial = "WeaponSpellTransform",
		WeaponTransformCast = "WeaponSpellTransform",

		SpellSummonMelee = "WeaponSpellSummon",
		SpellSummonRanged = "WeaponSpellSummon",
		
		-- Boons / Traits
		ZeusCastStrike = "WeaponCast",
		ProjectileCastFireball = "WeaponCast",
		PoseidonCast = "WeaponCast",
		WeaponAnywhereCast = "WeaponCast",
		ApolloCast = "WeaponCast",

		AphroditeRushProjectile = "WeaponBlink",
		HestiaSprintPuddle = "Sprint",
		HephSprintBlast = "Sprint",
		ZeusSprintStrike = "Sprint",
		PoseidonSprintBlast = "Sprint",
		DemeterSprintStorm = "Sprint",

		BurnEffect = "Burn",
		MassiveSlamBlast = "MassiveSlam_Name",
		PoseidonSplashSplinter = "PoseidonSplash_Name",

		ProjectileFireball = "FireballManaSpecialBoon",
		ProjectileZeusSpark = "FocusLightningBoon",
		ArtemisSupportingFire = "SupportingFireBoon",
		ZeusZeroManaStrike = "ZeusManaBoltBoon",
		HeraDamageShareProjectile = "DamageShareRetaliateBoon",
		DelayedKnockbackEffect = "MassiveKnockupBoon",
		DamageShareDeath = "LinkedDeathDamageBoon",
		WeaponCastProjectileHades = "HadesCastProjectileBoon",
		AphroditeBurst = "ManaBurstBoon",
		BurnNova = "BurnExplodeBoon",

		-- Traps
		ShadeMercSpiritball = "WorldUpgradeShadeMercs",
		DestructibleTreeSplinter = "Traps",
		SteamWallBlast = "Traps",
		SteamWallTrap = "Traps",
		SteamTrap = "Traps",
		SteamTrapFast = "Traps",
		SteamCubeExplosion = "Traps",
		SteamCubeFused = "Traps",
		FireBarrelExplosion = "Traps",
		BlastCubeExplosion = "Traps",
		SpikeTrapClockwork = "Traps",
		BeamTrap = "Traps",
		RubbleFall = "Traps",
		FieldsDestructiblePillarDestruction = "Traps",

		-- Allies
		ArtemisSniperBolt = "NPC_Artemis_Field_01",
		NemesisSpecial = "NPC_Nemesis_01",
		NemesisAttack1 = "NPC_Nemesis_01",
		NemesisAttack2 = "NPC_Nemesis_01",
		NemesisAttack3 = "NPC_Nemesis_01",
		HeraclesArcRight = "NPC_Heracles_01",
		HeraclesLeap = "NPC_Heracles_01",

		-- Familiars
		CatFamiliarPounce = "CatFamiliar",

		-- Devotions
		ZeusUpgradeRoomWeapon = "NPC_Zeus_01",
		PoseidonUpgradeRoomWeapon = "NPC_Poseidon_01",
		HestiaUpgradeRoomWeapon = "NPC_Hestia_01",
		ApolloUpgradeRoomWeapon = "NPC_Apollo_01",
		HeraUpgradeRoomWeapon = "NPC_Hera_01",
		DemeterUpgradeRoomWeapon = "NPC_Demeter_01",
		AphroditeUpgradeRoomWeapon = "NPC_Aphrodite_01",
		HephaestusUpgradeRoomWeapon = "NPC_Hephaestus_01",

		-- Bosses
		HecateCopy = "NPC_Hecate_01",
	},

	DamageSourceTextOverrides =
	{
		WeaponCast = "CastSet",
		WeaponBlink = "Dash",

		WeaponStaffSwing = "Attack",
		WeaponStaffSwing5 = "AttackEX",
		WeaponStaffDash = "DashStrike",
		WeaponStaffBall = "Special",
		ProjectileStaffBallCharged = "SpecialEX",

		WeaponDagger = "Attack",
		WeaponDaggerDash = "DashStrike",
		WeaponDagger5 = "AttackEX",
		WeaponDaggerThrow = "SpecialSet",

		WeaponAxe = "Attack",
		WeaponAxeDash = "DashStrike",
		WeaponAxeSpin = "AttackEX",
		WeaponAxeBlock2 = "Special",
		WeaponAxeSpecialSwing = "SpecialEX",

		WeaponTorch = "Attack",
		ProjectileTorchBallLarge = "AttackEX",
		WeaponTorchSpecial = "Special",
		ProjectileTorchOrbit = "SpecialEX",

		WeaponLob =  "Attack",
		ProjectileLobCharged = "AttackEX",
		WeaponLobSpecial = "SpecialSet",

		WeaponSpellTransform = "SpellTransformTrait",
		WeaponSpellMeteor = "SpellMeteorTrait",
		WeaponSpellLaser = "SpellLaserTrait",
		WeaponSpellSummon = "SpellSummonTrait",
		WeaponSpellLeap = "SpellLeapTrait",
	},
	
	ComponentData =
	{
		DefaultGroup = "HUD_Main",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"ShopBackground",
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

		TitleText =
		{
			Text = "RunClearScreen_Title",
			X = ScreenCenterX,
			Y = 70,
			Graphic = "VictoryTextBacking",
			GroupName = "Combat_Menu_TraitTray_Overlay",
			TextArgs =
			{
				FontSize = 40,
				OffsetY = 6,
				Font = "SpectralSCLightTitling",
				Color = Color.White,
				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			},
		},

		RunClearMessageText =
		{
			GroupName = "Combat_Menu_TraitTray_Overlay",
			X = ScreenCenterX,
			Y = 120,
			TextArgs =
			{
				Color = { 141, 253, 240, 255 },
				FontSize = 23,
				Font = "P22UndergroundSCLight",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Center",
			},
		},

		StatsBacking = 
		{
			Animation = "GUI\\Screens\\VictoryScreenStatsBacking",
			GroupName = "Combat_Menu_TraitTray_Overlay",
			Scale = 0.5,
			RightOffset = 225,
			Y = ScreenCenterY,
		},


		RunStatsLabel =
		{
			RightOffset = 225,
			Y = 170,
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
			Y = 235,
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
			Y = 228,
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
			Y = 233,
			Alpha = 0.0,
			AlphaTarget = 1.0,
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
			Y = 275,
			Text = "RunClearScreen_ShrinePoints",
			Alpha = 0.0,
			AlphaTarget = 0.0,
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
		ShrinePointsValue =
		{
			RightOffset = 30,
			Y = 275,
			Alpha = 0.0,
			AlphaTarget = 0.0,
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
			Y = 276,
			Alpha = 0.0,
			AlphaTarget = 1.0,
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
			Y = 355,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Text = "RunClearScreen_DamageDealt",
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
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
			Y = 670,
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
			Text = "RunClearScreen_DamageTaken",
			GroupName = "Combat_Menu_TraitTray_Overlay_Text",
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