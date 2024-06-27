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
	ApolloBlindTraits = { "ApolloCastBoon", "ApolloSprintBoon", "ApolloRetaliateBoon", "BlindChanceBoon", },

	DemeterCoreTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
	DemeterRootTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", },

	HephaestusCoreTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusCastBoon", "HephaestusSprintBoon", "HephaestusManaBoon" },
	HephaestusMassiveTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon", }, -- MassiveCastBoon

	HeraCoreTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
	HeraLinkTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", "DamageShareRetaliateBoon", },

	HestiaCoreTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaSprintBoon", "HestiaManaBoon" },
	HestiaBurnTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", }, -- "HestiaSprintBoon", EchoBurnBoon, BurnOmegaBoon

	PoseidonCoreTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonManaBoon" },
	PoseidonSplashTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon" }, -- PoseidonSplashSprintBoon
	PoseidonKnockbackTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonExCastBoon", },

	ZeusCoreTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoon", },
	ZeusEchoTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", },
	ZeusBoltTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoltBoon", "BoltRetaliateBoon", "CastAnywhereBoon", },

	WeaponTraits = { "AphroditeWeaponBoon", "ApolloWeaponBoon", "DemeterWeaponBoon", "HephaestusWeaponBoon", "HeraWeaponBoon", "HestiaWeaponBoon", "PoseidonWeaponBoon", "ZeusWeaponBoon", },
	SpecialTraits = { "AphroditeSpecialBoon", "ApolloSpecialBoon", "DemeterSpecialBoon", "HephaestusSpecialBoon", "HeraSpecialBoon", "HestiaSpecialBoon", "PoseidonSpecialBoon", "ZeusSpecialBoon", },
	CastTraits = { "AphroditeCastBoon", "ApolloCastBoon", "DemeterCastBoon", "HephaestusCastBoon", "HeraCastBoon", "HestiaCastBoon", "PoseidonCastBoon", "ZeusCastBoon", },
}

TraitRequirements = 
{
	-- Aphrodite
	WeakPotencyBoon = { OneOf = LinkedTraitData.AphroditeWeakTraits, },
	WeakVulnerabilityBoon = { OneOf = LinkedTraitData.AphroditeWeakTraits, },
	DoorHealToFullBoon = { OneOf = { "HighHealthOffenseBoon" }, },
	--ManaBurstBoon = { OneOf = LinkedTraitData.AphroditeCoreTraits, },
	--FocusRawDamageBoon = { OneOf = LinkedTraitData.AphroditeCoreTraits, },
	RandomStatusBoon =
	{
		OneFromEachSet =
		{
			LinkedTraitData.AphroditeWeakTraits,
			{ "AphroditeWeaponBoon", "AphroditeSpecialBoon", },
			{ "WeakPotencyBoon", "WeakVulnerabilityBoon", "HighHealthOffenseBoon", "FocusRawDamageBoon", },
		},
	},

	-- Apollo
	--ApolloCastAreaBoon = { OneOf = LinkedTraitData.ApolloCoreTraits, },
	DoubleStrikeChanceBoon = { OneOf = LinkedTraitData.WeaponTraits, },
	ApolloBlindBoon = { OneOf = LinkedTraitData.ApolloBlindTraits, },
	BlindChanceBoon = { PriorityChance = 0.25, OneOf = { "ApolloWeaponBoon" }, },
	ApolloExCastBoon = { OneOf = LinkedTraitData.CastTraits },
	DoubleExManaBoon =
	{
		OneFromEachSet =
		{
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", },
			{ "ApolloCastBoon", "ApolloSprintBoon", "ApolloManaBoon" },
			{ "DoubleStrikeChanceBoon", "ApolloCastAreaBoon", "ApolloBlindBoon", "ApolloExCastBoon", },
		},
	},

	-- Demeter
	--ReserveManaHitShieldBoon = { OneOf = LinkedTraitData.DemeterCoreTraits, },
	SlowExAttackBoon = { OneOf = LinkedTraitData.WeaponTraits, },
	--CastAttachBoon = { OneOf = LinkedTraitData.DemeterCoreTraits, },
	RootDurationBoon = { OneOf = LinkedTraitData.DemeterRootTraits, },
	CastAttachBoon = { OneOf = LinkedTraitData.CastTraits, },
	InstantRootKill =
	{
		OneFromEachSet = 
		{
			LinkedTraitData.DemeterRootTraits,
			{ "PlantHealthBoon", "ReserveManaHitShieldBoon", "BoonGrowthBoon", },
			{ "SlowExAttackBoon", "RootDurationBoon", "CastAttachBoon", },
		},
	},

	-- Hephaestus
	-- ManaToHealthBoon = { OneOf = { "HeavyArmorBoon", "ArmorBoon", "EncounterStartDefenseBuffBoon", }, },
	MassiveDamageBoon = { OneOf = LinkedTraitData.HephaestusMassiveTraits, },
	MassiveKnockupBoon = { PriorityChance = 0.25, OneOf = LinkedTraitData.HephaestusMassiveTraits },
	WeaponUpgradeBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.HephaestusMassiveTraits,
			{ "HeavyArmorBoon", "ArmorBoon", "EncounterStartDefenseBuffBoon", },
			{ "MassiveDamageBoon", "AntiArmorBoon", "MassiveKnockupBoon", },
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
			{ "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon" },
			{ "BoonDecayBoon", "SwapBonusBoon", "CommonGlobalDamageBoon", "OmegaHeraProjectileBoon", },
			{ "DamageSharePotencyBoon", "LinkedDeathDamageBoon", },
		},
	},

	-- Hestia
	BurnExplodeBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	BurnArmorBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	BurnStackBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	OmegaZeroBurnBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	--CastProjectileBoon = { OneOf = LinkedTraitData.CastTraits, },
	--FireballManaSpecialBoon = { OneOf = LinkedTraitData.SpecialTraits, },
	BurnSprintBoon = 
	{

		OneFromEachSet =
		{
			LinkedTraitData.HestiaBurnTraits,
			{ "BurnExplodeBoon", "BurnArmorBoon", "BurnStackBoon", "OmegaZeroBurnBoon", },
			{ "CastProjectileBoon", "FireballManaSpecialBoon", },
		},
	},

	-- Poseidon
	-- DoubleRewardBoon = { OneOf = { "MinorLootBoon", "RoomRewardBonusBoon", }, },
	PoseidonStatusBoon = { PriorityChance = 0.25, OneOf = LinkedTraitData.PoseidonSplashTraits, },
	PoseidonExCastBoon = { OneOf = LinkedTraitData.CastTraits, },
	AmplifyConeBoon =
	{
		OneFromEachSet =
		{
			LinkedTraitData.PoseidonSplashTraits,
			{ "PoseidonSprintBoon", "PoseidonManaBoon", "PoseidonExCastBoon", },
			{ "EncounterStartOffenseBuffBoon", "OmegaPoseidonProjectileBoon", "PoseidonStatusBoon", "FocusDamageShaveBoon", },
		},
	},

	-- Zeus
	--FocusLightningBoon = { OneOf = LinkedTraitData.ZeusCoreTraits, },
	DoubleBoltBoon = { OneOf = LinkedTraitData.ZeusBoltTraits, },
	EchoExpirationBoon = { OneOf = LinkedTraitData.ZeusEchoTraits, },
	LightningDebuffGeneratorBoon = { OneOf = LinkedTraitData.ZeusEchoTraits, },
	CastAnywhereBoon = { OneOf = LinkedTraitData.CastTraits, },
	SpawnKillBoon =
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusCoreTraits,
			{ "FocusLightningBoon",  "ZeusManaBoltBoon", "CastAnywhereBoon", "BoltRetaliateBoon", },
			{ "EchoExpirationBoon", "DoubleBoltBoon", "LightningDebuffGeneratorBoon", },
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
			{ "DamageShareRetaliateBoon", "SwapBonusBoon", "DamageSharePotencyBoon", "LinkedDeathDamageBoon", "OmegaHeraProjectileBoon", },
			{ "MassiveDamageBoon", "AntiArmorBoon", "HeavyArmorBoon", "ArmorBoon", "EncounterStartDefenseBuffBoon", "ManaToHealthBoon", "MassiveKnockupBoon", },
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
			LinkedTraitData.HeraCoreTraits,
			{ "RoomRewardBonusBoon", "DoubleRewardBoon" },
		},
	},

	RootStrikeBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusCoreTraits,
			LinkedTraitData.DemeterRootTraits,
		},
	},

	KeepsakeLevelBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.DemeterCoreTraits,
			LinkedTraitData.HeraCoreTraits,
		},
	},

	GoodStuffBoon = 
	{
		OneFromEachSet =
		{
			{ "PoseidonCastBoon", "PoseidonManaBoon", "PoseidonSprintBoon", "RoomRewardBonusBoon", "DoubleRewardBoon" },
			{ "DemeterCastBoon", "DemeterManaBoon", "DemeterSprintBoon", "ReserveManaHitShieldBoon", "RootDurationBoon", "BoonGrowthBoon" },
		}
	},

	ApolloSecondStageCastBoon = 
	{
		OneFromEachSet =
		{
			{ "ApolloExCastBoon" },
			{ "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", },
		}
	},

	PoseidonSplashSprintBoon = 
	{
		OneFromEachSet =
		{
			{ "ApolloSprintBoon", "PoseidonSprintBoon", },
			LinkedTraitData.ApolloCoreTraits,
			LinkedTraitData.PoseidonCoreTraits,
		},
	},

	StormSpawnBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.ApolloCoreTraits,
			{ "DemeterSprintBoon", "CastNovaBoon" },
		}
	},

	SprintEchoBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.ZeusEchoTraits,
			LinkedTraitData.AphroditeCoreTraits,
		}
	},

	CharmCrowdBoon = 
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
			{ "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterManaBoon", "DemeterSprintBoon", "PlantHealthBoon" },
			{ "AphroditeWeaponBoon", "AphroditeSpecialBoon", "AphroditeManaBoon", "AphroditeSprintBoon",  "DoorHealToFullBoon", },
		}
	},

	ManaBurstCountBoon = 
	{
		OneFromEachSet =
		{
			{ "ManaBurstBoon", },
			LinkedTraitData.ApolloCoreTraits,
		}
	},

	EchoBurnBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.ZeusEchoTraits,
			LinkedTraitData.HestiaBurnTraits,
		}
	},

	AllElementalBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.HeraCoreTraits,
			LinkedTraitData.HestiaCoreTraits,
		},
	},

	SteamBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonStatusBoon", },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "OmegaZeroBurnBoon", "FireballManaSpecialBoon", "CastProjectileBoon", },
		},
	},

	BurnConsumeBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.DemeterRootTraits,
			LinkedTraitData.HestiaBurnTraits,
		},
	},

	CoverRegenerationBoon = 
	{
		OneFromEachSet =
		{			
			{ "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloCastBoon", "ApolloManaBoon", "ApolloSprintBoon", },
			{ "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaManaBoon", "HestiaSprintBoon", },
			{ "SacrificeBoon" },
		}
	},

	BurnRefreshBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.HestiaBurnTraits,
			LinkedTraitData.AphroditeWeakTraits,
		},
	},

	ReboundingSparkBoon = 
	{
		OneFromEachSet =
		{
			{ "FocusLightningBoon", "LightningDebuffGeneratorBoon" },
			LinkedTraitData.HephaestusCoreTraits,
		},
	},

	MassiveCastBoon = 
	{
		OneFromEachSet =
		{			
			{ "PoseidonCastBoon", "PoseidonExCastBoon" },
			LinkedTraitData.HephaestusMassiveTraits,
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

	BlindClearBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.HephaestusMassiveTraits,
			LinkedTraitData.ApolloBlindTraits,
		}
	},

	SlamManaBurstBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.AphroditeCoreTraits,
			LinkedTraitData.HephaestusMassiveTraits,
		}
	},

	DoubleMassiveAttackBoon = 
	{
		OneFromEachSet =
		{			
			{ "HephaestusWeaponBoon", "HephaestusSpecialBoon", },
			LinkedTraitData.HestiaCoreTraits,
		}
	},

	SuperSacrificeBoonZeus = 
	{
		OneFromEachSet =
		{			
			{ "HeraCastBoon", "HeraManaBoon", "HeraSprintBoon" },
			LinkedTraitData.ZeusCoreTraits,
		}
	},

	SuperSacrificeBoonHera = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.HeraCoreTraits,
			{ "ZeusCastBoon", "ZeusManaBoon", "ZeusSprintBoon" },
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
			LinkedTraitData.PoseidonCoreTraits,
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
		Icon = "Trait_StorePendingDeliveryItem",
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
				Multiplier = 8
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
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},

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
		Icon = "Trait_SurfacePenalty",
		ShowInHUD = true,
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
		Icon = "Trait_UnusedWeaponBonus",
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
		Icon = "Hammer_Staff_39",
	},

	DummyWeaponDagger = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponDagger",
		CustomName = "WeaponDagger",
		FlavorText = "WeaponDagger_FlavorText",
		Icon = "Hammer_Daggers_38",
	},

	DummyWeaponAxe = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponAxe",
		CustomName = "WeaponAxe",
		FlavorText = "WeaponAxe_FlavorText",
		Icon = "Hammer_Axe_40",
	},

	DummyWeaponTorch = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponTorch",
		CustomName = "WeaponTorch",
		FlavorText = "WeaponTorch_FlavorText",
		Icon = "Hammer_Torch_39",
	},

	DummyWeaponLob = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponLob",
		CustomName = "WeaponLob",
		FlavorText = "WeaponLob_FlavorText",
		Icon = "Hammer_Lob_13",
	},
}

TraitSetData.Aspects = {}

OverwriteTableKeys( TraitData, TraitSetData.Base )
OverwriteTableKeys( TraitData, TraitSetData.DummyWeapons )
