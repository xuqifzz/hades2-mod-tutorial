local DepthDamageMultiplier = 0.0
local DuplicateWeakMultiplier = -0.80
local DuplicateMultiplier = -0.60
local DuplicateStrongMultiplier = -0.40
local DuplicateVeryStrongMultiplier = -0.20

PropertyOrderingValues = 
{
	"ChargeTime",
	"AddOnFire",
	"FullyAutomatic",
	"ForceReleaseOnSwap",
	"SpawnOnDeath",
	"Damage",
	"MaxAdjustRate",
	"AdjustRateAcceleration",
	"ImpactVelocity",
	"AllowRepeatedJumpHit",
	"ResetCollisionOutsideImpact",
}

ProjectileThingPropertyNames = 
{
	Graphic = true,
}

PersistentTraitKeys = 
{ 
	"TraitListTextString",
	"HarvestBoons",
	"SacrificedTraitName", 
	"Uses" 
}

TraitMultiplierData =
{
	DefaultDiminishingReturnsMultiplier = 0.5,
	DefaultMinMultiplier = 0.1,
}

TraitMainWeaponSlots = 
{ 
	Melee = true, 
	Secondary = true,
}

LinkedTraitData =
{
	AphroditeCoreTraits = { "AphroditeWeaponBoon", "AphroditeSpecialBoon", "AphroditeCastBoon", "AphroditeSprintBoon", "AphroditeManaBoon", },
	AphroditeWeakTraits = { "AphroditeCastBoon", "AphroditeSprintBoon", "AphroditeManaBoon", },

	ApolloCoreTraits = { "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloCastBoon", "ApolloSprintBoon", "ApolloManaBoon" },
	ApolloBlindTraits = { "ApolloSprintBoon", "ApolloRetaliateBoon", "BlindChanceBoon", },

	DemeterCoreTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
	DemeterRootTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", },
	DemeterChillTraits = { "DemeterCastBoon", "CastNovaBoon", },

	HephaestusCoreTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusCastBoon", "HephaestusSprintBoon", "HephaestusManaBoon" },
	HephaestusMassiveTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon", }, -- MassiveCastBoon

	HeraCoreTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
	HeraLinkTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraSprintBoon", "DamageShareRetaliateBoon", },

	HestiaCoreTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaSprintBoon", "HestiaManaBoon" },
	HestiaBurnTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "OmegaZeroBurnBoon", }, -- EchoBurnBoon, BurnOmegaBoon

	PoseidonCoreTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonManaBoon" },
	PoseidonSplashTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", }, -- PoseidonSplashSprintBoon
	PoseidonKnockbackTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", },

	ZeusCoreTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoon", },
	ZeusEchoTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", },
	ZeusBoltTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoltBoon", "BoltRetaliateBoon", "CastAnywhereBoon", },
}

TraitRequirements = 
{
	-- Aphrodite
	WeakPotencyBoon = { OneOf = LinkedTraitData.AphroditeWeakTraits, },
	WeakVulnerabilityBoon = { OneOf = LinkedTraitData.AphroditeWeakTraits, },
	--ManaBurstBoon = { OneOf = LinkedTraitData.AphroditeCoreTraits, },
	--FocusRawDamageBoon = { OneOf = LinkedTraitData.AphroditeCoreTraits, },
	CharmCrowdBoon =
	{
		OneFromEachSet =
		{
			{ "WeakPotencyBoon", "WeakVulnerabilityBoon", },
			LinkedTraitData.AphroditeWeakTraits,
			{ "AphroditeWeaponBoon", "AphroditeSpecialBoon", },
		},
	},

	-- Apollo
	--ApolloCastAreaBoon = { OneOf = LinkedTraitData.ApolloCoreTraits, },
	--DoubleStrikeChanceBoon = { OneOf = LinkedTraitData.ApolloCoreTraits, },
	ApolloBlindBoon = { OneOf = LinkedTraitData.ApolloBlindTraits, },
	ApolloMissStrikeBoon = { OneOf = LinkedTraitData.ApolloBlindTraits, },
	BlindChanceBoon = { PriorityChance = 0.25, OneOf = { "ApolloWeaponBoon" }, },
	DoubleExManaBoon =
	{
		OneFromEachSet =
		{
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", },
			{ "ApolloCastBoon", "ApolloManaBoon" },
			{ "DoubleStrikeChanceBoon", "ApolloCastAreaBoon", },
		},
	},

	-- Demeter
	--ReserveManaHitShieldBoon = { OneOf = LinkedTraitData.DemeterCoreTraits, },
	--SlowExAttackBoon = { OneOf = LinkedTraitData.DemeterCoreTraits, },
	--CastAttachBoon = { OneOf = LinkedTraitData.DemeterCoreTraits, },
	RootDurationBoon = { OneOf = LinkedTraitData.DemeterRootTraits, },
	InstantRootKill =
	{
		OneFromEachSet = 
		{
			LinkedTraitData.DemeterRootTraits,
			{ "PlantHealthBoon", "ReserveManaHitShieldBoon", },
			{ "SlowExAttackBoon", "RootDurationBoon", },
		},
	},

	-- Hephaestus
	-- ManaToHealthBoon = { OneOf = { "HeavyArmorBoon", "ArmorBoon", "EncounterStartDefenseBuffBoon", }, },
	MassiveKnockupBoon = { PriorityChance = 0.25, OneOf = LinkedTraitData.HephaestusMassiveTraits },
	WeaponUpgradeBoon = 
	{
		OneFromEachSet =
		{
			{ "HephaestusWeaponBoon", "HephaestusSpecialBoon", },
			{ "HeavyArmorBoon", "ArmorBoon", "EncounterStartDefenseBuffBoon", },
			{ "ChargeCounterBoon", "AntiArmorBoon", "MassiveKnockupBoon", },
		},
	},

	-- Hera
	DamageSharePotencyBoon = { OneOf = LinkedTraitData.HeraLinkTraits, },
	LinkedDeathDamageBoon = { OneOf = LinkedTraitData.HeraLinkTraits, },
	--FullManaExBoostBoon = { OneOf = LinkedTraitData.HeraCoreTraits, },
	HeraManaShieldBoon = 
	{
		OneFromEachSet = 
		{
			{ "HeraWeaponBoon", "HeraSpecialBoon", },
			{ "HeraManaBoon", "FullManaExBoostBoon", },
			{ "DamageSharePotencyBoon", "LinkedDeathDamageBoon", },
		},
	},

	-- Hestia
	BurnExplodeBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	BurnConsumeBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	BurnArmorBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	OmegaZeroBurnBoon = { OneOf = { "HestiaSpecialBoon" } },
	BurnStackBoon = 
	{

		OneFromEachSet =
		{
			LinkedTraitData.HestiaBurnTraits,
			{ "BurnExplodeBoon", "BurnArmorBoon" },
			{ "CastProjectileBoon", "FireballManaSpecialBoon", },
		},
	},

	-- Poseidon
	-- DoubleRewardBoon = { OneOf = { "MinorLootBoon", "RoomRewardBonusBoon", }, },
	PoseidonStatusBoon = { PriorityChance = 0.25, OneOf = LinkedTraitData.PoseidonSplashTraits, },
	SlamExplosionBoon = { OneOf = LinkedTraitData.PoseidonKnockbackTraits, },
	AmplifyConeBoon =
	{
		OneFromEachSet =
		{
			LinkedTraitData.PoseidonSplashTraits,
			{ "PoseidonStatusBoon", },
			{ "SlamExplosionBoon", },
		},
	},

	-- Zeus
	--FocusLightningBoon = { OneOf = LinkedTraitData.ZeusCoreTraits, },
	DoubleBoltBoon = { OneOf = LinkedTraitData.ZeusBoltTraits, },
	EchoExpirationBoon = { OneOf = LinkedTraitData.ZeusEchoTraits, },
	LightningDebuffGeneratorBoon = { OneOf = LinkedTraitData.ZeusEchoTraits, },
	SpawnKillBoon =
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusCoreTraits,
			{ "DoubleBoltBoon", "EchoExpirationBoon", },
			{ "FocusLightningBoon", "LightningDebuffGeneratorBoon", },
		},
	},


	-- Hermes
	TimeStopLastStandBoon = 
	{
		OneOf =
		{
			"HermesWeaponBoon",
			"HermesSpecialBoon",
			"SlowProjectileBoon",
			"HermesCastDiscountBoon",
			"SorcerySpeedBoon",
			"DodgeChanceBoon",
			"HexCooldownBuffBoon",
			"TimedKillBuffBoon",
			"SprintShieldBoon",
		},
	},

	-- Duos
	
	EmptySlotDamageBoon = 
	{
		OneFromEachSet =
		{
			{ "HeraManaShieldBoon", "DamageShareRetaliateBoon", "FullManaExBoostBoon", "HeraManaBoon" },
			{ "ArmorBoon", "EncounterStartDefenseBuffBoon", "HeavyArmorBoon", "ChargeCounterBoon" , "ManaToHealthBoon", "HephaestusManaBoon" },
		},
	},
	RaiseDeadBoon =
	{
		OneFromEachSet =
		{
			{ "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
			{ "ApolloCastBoon", "ApolloSprintBoon", "ApolloManaBoon" },
		}
	},
	
	MoneyDamageBoon = 
	{
		OneFromEachSet =
		{
			{ "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
			{ "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonManaBoon" },
			{ "RoomRewardBonusBoon", "DoubleRewardBoon" },
		}
	},

	EchoAllBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusEchoTraits,
			{ "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", "DemeterSprintBoon", },
		}
	},

	KeepsakeLevelBoon = 
	{
		OneFromEachSet =
		{
			{ "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
			{ "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
		}
	},

	GoodStuffBoon = 
	{
		OneFromEachSet =
		{
			{ "PoseidonManaBoon", "PoseidonSprintBoon", "RoomRewardBonusBoon", "MinorLootBoon", "DoubleRewardBoon" },
			{ "DemeterManaBoon", "DemeterSprintBoon", "ReserveManaHitShieldBoon", "RootDurationBoon", "BoonGrowthBoon" },
		}
	},

	ApolloSecondStageCastBoon = 
	{
		OneFromEachSet =
		{			
			{ "ApolloCastBoon" },
			{ "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusSprintBoon", },
		}
	},

	PoseidonSplashSprintBoon = 
	{
		OneFromEachSet =
		{
			{ "ApolloSprintBoon", "ApolloManaBoon", },
			{ "PoseidonSprintBoon", "PoseidonManaBoon", },
		}
	},

	CastRampBoon = 
	{
		OneFromEachSet =
		{			
			{ "ApolloCastBoon", "ApolloSprintBoon", "ApolloManaBoon" },
			{ "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
		}
	},

	SprintEchoBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.ZeusEchoTraits,
			{ "AphroditeSprintBoon", "AphroditeWeaponBoon", "AphroditeSpecialBoon", "AphroditeCastBoon" },
		}
	},

	MaximumShareBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HeraLinkTraits,
			LinkedTraitData.AphroditeWeakTraits,
		}
	},

	MaxHealthDamageBoon = 
	{
		OneFromEachSet =
		{
			{ "PlantHealthBoon", "ReserveManaHitShieldBoon" },
			{ "HighHealthOffenseBoon", "HealthRewardBonusBoon", "DoorHealToFullBoon", },
		}
	},

	ManaBurstCountBoon = 
	{
		OneFromEachSet =
		{
			{ "ManaBurstBoon", },
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloCastBoon", "ApolloManaBoon" },
		}
	},

	EchoBurnBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusEchoTraits,
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", },
		}
	},

	BurnOmegaBoon = 
	{
		OneFromEachSet =
		{			
			{ "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraManaBoon" },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaManaBoon" },
		}
	},

	SteamBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonStatusBoon", },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "OmegaZeroBurnBoon", "ShadeMercFireballBoon", "FireballManaSpecialBoon", "CastProjectileBoon", },
		}
	},

	DoubleBurnBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.DemeterRootTraits,
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", },
		}
	},

	CoverRegenerationBoon = 
	{
		OneFromEachSet =
		{			
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloManaBoon" },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon" },
			{ "SacrificeBoon", "BurnArmorBoon", "HestiaManaBoon" },
		}
	},

	ShadeMercFireballBoon = 
	{
		OneFromEachSet =
		{			
			{ "AphroditeCastBoon", "AphroditeSprintBoon", "AphroditeManaBoon", },
			{ "HestiaCastBoon", "HestiaSprintBoon", "HestiaManaBoon" },
		}
	},

	ReboundingSparkBoon = 
	{
		OneFromEachSet =
		{			
			{ "FocusLightningBoon", },
			{ "HephaestusManaBoon", "ArmorBoon", "HeavyArmorBoon", "EncounterStartDefenseBuffBoon", "ChargeCounterBoon" },
		}
	},

	MassiveCastBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonCastBoon", },
			{ "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon" },
		}
	},

	ClearRootBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HephaestusMassiveTraits,
			LinkedTraitData.DemeterRootTraits,
		}
	},

	MassiveAoEIncrease = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HephaestusMassiveTraits,
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloCastAreaBoon", },
		}
	},

	FirstHitHealBoon = 
	{
		OneFromEachSet =
		{
			{ "AphroditeCastBoon", "AphroditeSprintBoon", "AphroditeManaBoon", },
			{ "HephaestusCastBoon", "HephaestusSprintBoon", "HephaestusManaBoon" },
		}
	},

	DoubleMassiveAttackBoon = 
	{
		OneFromEachSet =
		{			
			{ "HephaestusWeaponBoon", "HephaestusSpecialBoon", },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", },
		}
	},

	SuperSacrificeBoonZeus = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HeraCoreTraits,
			LinkedTraitData.ZeusCoreTraits,
		}
	},

	SuperSacrificeBoonHera = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HeraCoreTraits,
			LinkedTraitData.ZeusCoreTraits,
		}
	},

	LightningVulnerabilityBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonStatusBoon", },
			{ "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "BoltRetaliateBoon", "CastAnywhereBoon", },
		}
	},

	AllCloseBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", },
			{ "AphroditeWeaponBoon", "AphroditeSpecialBoon" },
		}
	},
}

TraitRarityData = 
{
	RarityValues = 
	{
		Common = 1,
		Rare = 2,
		Epic = 3,
		Heroic = 4,
		Legendary = 5,
		Duo = 5,
		Perfect = 6,
	},

	AspectRarityText = 
	{
		"TraitLevel_AspectLvl1",
		"TraitLevel_AspectLvl2",
		"TraitLevel_AspectLvl3",
		"TraitLevel_AspectLvl4",
		"TraitLevel_AspectLvl5",
		"TraitLevel_AspectLvl6",
	},
	
	TalentRarity = 
	{
		"TraitLevel_TalentLvl1",
		"TraitLevel_TalentLvl2",
		"TraitLevel_TalentLvl3",
		"TraitLevel_TalentLvl4",
		"TraitLevel_TalentLvl5",
	},

	ShrineRarityText =
	{
		[0] = "ShrineLevel0",
		"ShrineLevel1",
		"ShrineLevel2",
		"ShrineLevel3",
		"ShrineLevel4",
		"ShrineLevel5",
	},

	WeaponRarityUpgradeOrder = {"Common", "Rare", "Epic", "Heroic", "Legendary", "Perfect" },
	TalentRarityUpgradeOrder = {"Common", "Rare", "Epic", "Heroic", "Legendary"},
	BoonRarityRollOrder = {"Common", "Rare", "Epic", "Duo", "Legendary"},
	BoonRarityReverseRollOrder = {"Legendary", "Duo", "Epic", "Rare", "Common"}, -- TODO (@alice) generate this in RunData instead of specifying it here
	RarityUpgradeOrder = { "Common", "Rare", "Epic", "Heroic", },
	LegacyGameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "PoseidonLegacyBoonIntro01" },
		},
	},
	ElementalGameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeElementalBoons" },
		},
	},
}

TraitElementData = 
{
	Fire = 
	{ 
		Icon = "FireTraitSmall",
		Keyword = "FireBoonKeyword",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Traits = 
		{
			--"FireBaseDamageBoon",
		}
	},
	Water = 
	{ 
		Icon = "WaterTraitSmall" ,
		Keyword = "WaterBoonKeyword",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Traits = 
		{
			--"WaterHealthBoon",
		},
	},
	Earth = 
	{ 
		Icon = "EarthTraitSmall" ,
		Keyword = "EarthBoonKeyword",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Traits = 
		{
			--"EarthManaBoon",
		},
	},
	Air = 
	{ 
		Icon = "AirTraitSmall" ,
		Keyword = "AirBoonKeyword",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Traits = 
		{
			--"AirDodgeBoon",
		},
	},
	Aether = 
	{ 
		Icon = "AetherTraitSmall" ,
		Keyword = "AetherBoonKeyword",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Aether" },
				Comparison = ">=",
				Value = 1,
			},
		},
		Traits = 
		{
			--"AetherSpeedBoon",
		},
	},
}

TraitSetData.Base =
{
	-- Base Data

	BaseTrait =
	{
		Cost = 30,
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.3,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 1.8,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				MinMultiplier = 2.3,
				MaxMultiplier = 2.5,
			},
		},
	},

	AirBoon = 
	{
		Elements = { "Air" },
	},
	FireBoon = 
	{
		Elements = {"Fire"},
	},
	EarthBoon = 
	{
		Elements = {"Earth"},
	},
	WaterBoon = 
	{
		Elements = {"Water"},
	},
	AetherBoon = 
	{
		Elements = {"Aether"},
	},

	LegendaryTrait =
	{
		Cost = 120,
		BlockStacking = true,
		RarityLevels =
		{
			Legendary =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
	},

	InPersonOlympianTrait =
	{
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
	},

	SynergyTrait =
	{
		InheritFrom = { "AetherBoon", },
		IsDuoBoon = true,
		Frame = "Duo",
		BlockStacking = true,
		RequiredFalseRewardType = "Devotion",
		RarityLevels =
		{
			Duo =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		}
	},

	LegacyTrait = 
	{
		IsLegacyTrait = true,
	},

	UnityTrait = 
	{
		IsElementalTrait = true,
		BlockStacking = true,
		BlockInRunRarify = true,
		ExcludeFromRarityCount = true,
		CustomRarityName = "Boon_Infusion",
		CustomRarityColor = Color.BoonPatchUnity,
		InfoBackingAnimation = "BoonSlotUnity",
		UpgradeChoiceBackingAnimation = "BoonSlotUnity",
		Frame = "Unity",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		}
	},

	WeaponTrait =
	{
		Frame = "Hammer",
		IsHammerTrait = true,
	},

	CostumeTrait = 
	{
		Frame = "Hammer",
		CostumeTrait = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
	},

	SpellTalentTrait =
	{
		TraitTrayOpenSpellScreen = true,
		IsTalent = true,
		Icon = "Athena_Ares_01",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.25,
				MaxMultiplier = 1.25,
			},
			Epic =	
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Heroic =
			{
				MinMultiplier = 1.75,
				MaxMultiplier = 1.75,
			},
			Legendary =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
		},
	},

	StorePendingDeliveryItem = 
	{
		Frame = "Shop",
		PriorityDisplay = true,
		Icon = "Shop_Vial",
		RemainingUses = 3,
		UsesAsEncounters = true,
		StatLines =
		{
			"DeliveryTimeRemainingDisplay1",
		},
	},

	ChaosCurseTrait =
	{
		Icon = "Shop_Vial",
	},

	ChaosCurseRemainingEncounters =
	{
		RemainingUses =
		{
			BaseMin = 3,
			BaseMax = 4,
			AsInt = true,
		},
		UsesAsEncounters = true,
	},

	ChaosBlessingTrait =
	{
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.00,
				MaxMultiplier = 1.00,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
		}
	},

	WeaponEnchantmentTrait =
	{
		IsWeaponEnchantment = true,
		InfoBackingAnimation = "WeaponSlotBase",
		Slot = "Aspect",
		HideInHUD = true,
		HideInRunHistory = true,
		
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Epic =
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
			Heroic =
			{
				MinMultiplier = 4.0,
				MaxMultiplier = 4.0,
			},
			Legendary =
			{
				MinMultiplier = 5.0,
				MaxMultiplier = 5.0,
			},
			Perfect = 
			{
				Multiplier = 6
			}
		},
	},

	GodModeTrait =
	{
		Icon = "GodMode",
		StatLines =
		{
			"GodModeDamageResistanceDisplay1",
		},
		ExtractValues =
		{
			{
				ExtractAs = "TooltipEasyModeDefense",
				Format = "EasyModeMultiplier",
				SkipAutoExtract = true
			}
		}
	},

	LimitedTimeTrait =
	{
		LimitedTime = true,
	},

	-- Misc Traits
	FallbackGold = 
	{
		Icon = "Boon_Athena_09",
		InheritFrom = { "BaseTrait" }, 
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 0.2,
			NotRequiredPickup = true,
			LootOptions =
			{
				{
					Name = "Currency",
					MinAmount = 90,
					MaxAmount = 90,
					ReportValues = { ReportedResource = "MinAmount"},
				},
			}
		},
		Hidden = true,
		ExtractValues =
		{
			{
				Key = "ReportedResource",
				ExtractAs = "GoldAmount",
			},
		}
	},

	SurfacePenalty = 
	{
		Frame = "Common",
		Icon = "BiomeState_Rain",
		SetupFunction =
		{
			Name = "StartSurfaceHealthPenalty",
			Args =
			{
				Damage = 1, 
				Interval = 5.0,
				DamageIncrementPerTick = 1,
				
				ReportValues = 
				{ 
					ReportedInterval = "Interval",
				}
			},
		},
		StatLines =
		{
			"SurfacePenaltyStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
			},
		}
	},
	ErisCurseTrait = 
	{
		Frame = "Common",
		Icon = "ErisCurseTrait",
		EnemySetupFunctionName = "ErisCurseEnemySetup",
		EnemySetupFunctionArgs =
		{			
		},
		EncounterEndFunctionName = "ErisCurseUpdate",
		EncounterEndFunctionArgs =
		{
			BaseHealthMultiplierAddition = 0.0,
			PerEncounterHealthMultiplierAddition = 0.0,

			BaseDamageMultiplierAddition = 0.20,
			PerEncounterDamageMultiplierAddition = 0.05,
			
			MaxEncounterAdditions = 16,
		},
		FlavorText = "ErisCurse_FlavorText",
	},

	OnionCurse = 
	{
		Frame = "MetaUpgrade",
		Icon = "Weapon_Sword_12",
		RemainingUses = 1,
	},

	UnusedWeaponBonusTrait =
	{
		--Frame = "MetaUpgrade",
		Icon = "Boon_Chaos_01",
		AddResources =
		{
			MetaCurrency = 2,
		},
	},

	RoomRewardMaxManaTrait =
	{
		InheritFrom = { "BaseTrait" },
		Hidden = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 30,
				ChangeType = "Add",
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
	},

	RoomRewardMaxHealthTrait =
	{
		InheritFrom = { "BaseTrait" },
		Hidden = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 25,
				ChangeType = "Add",
				ExtractValue =
				{
					ExtractAs = "TooltipHealth",
				}
			},
		},
	},

	RoomRewardEmptyMaxHealthTrait =
	{
		InheritFrom = { "BaseTrait" },
		Hidden = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 25,
				ChangeType = "Add",
				BlockHealing = true,
				ExtractValue =
				{
					ExtractAs = "TooltipHealth",
				}
			},
		},
	},
}

TraitSetData.DummyWeapons =
{
	BaseDummyWeapon = 
	{
		Icon = "Shop_BedroomDecor",
		Slot = "Aspect",
		HideInHUD = true,
		HideInRunHistory = true,
		InfoBackingAnimation = "WeaponSlotBase",
	},

	DummyWeaponStaff = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponStaffSwing",
		CustomName = "WeaponStaffSwing",
		FlavorText = "WeaponStaffSwing_FlavorText",
		Icon = "Hammer_Staff_12",
	},

	DummyWeaponDagger = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponDagger",
		CustomName = "WeaponDagger",
		FlavorText = "WeaponDagger_FlavorText",
		Icon = "Hammer_Daggers_01",
	},

	DummyWeaponAxe = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponAxe",
		CustomName = "WeaponAxe",
		FlavorText = "WeaponAxe_FlavorText",
		Icon = "Hammer_Axe_12",
	},

	DummyWeaponTorch = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponTorch",
		CustomName = "WeaponTorch",
		FlavorText = "WeaponTorch_FlavorText",
		Icon = "Hammer_Torch_12",
	},

	DummyWeaponLob = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponLob",
		CustomName = "WeaponLob",
		FlavorText = "WeaponLob_FlavorText",
		Icon = "Shop_BedroomDecor",
	},
}

TraitSetData.Aspects = {}

OverwriteTableKeys( TraitData, TraitSetData.Base )
OverwriteTableKeys( TraitData, TraitSetData.DummyWeapons )
