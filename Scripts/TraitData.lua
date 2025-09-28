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
	AttachedAnim = true,
	AmbientSound = true,
}

PersistentTraitKeys = 
{ 
	"Activated",
	"TraitListTextString",
	"SacrificedTraitName", 
	"UpgradedTraitName", 
	"Uses",
	"RemainingUses",
	"ShrineManaReserve",
	"CurrentArmor",
	"RemainingBlocks",
	"StoredGold",
}

PatchIgnoreTraitKeys = ToLookup(
{
	"RemainingUses",
	"Slot",
	"ActiveSlotOffsetIndex",
	"ShowInHUD",
	"HideInRunHistory",
})

ProcessTraitDataBlacklist = ToLookup(
{
	"InheritFrom",
	"ExtractValues",
	"ReportValues",
	"WeaponDataOverride",
	"ConsumedVoiceLines",
	"OnSpawnVoiceLines",
	"UseFunctionNames",
	"UseFunctionArgs",
	"PurchaseRequirements",
	"GameStateRequirements",
	"ValidWeapons",
})

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

	AresCoreTraits = { "AresWeaponBoon", "AresSpecialBoon", "AresCastBoon", "AresSprintBoon", "AresManaBoon" },
	AresRendTraits = { "AresWeaponBoon", "AresSpecialBoon" },
	AresBloodDropTraits = { "AresManaBoon", "BloodDropRevengeBoon", "RendBloodDropBoon" },
	AresSwordTraits = { "AresCastBoon", "AresSprintBoon", "OmegaDelayedDamageBoon" },

	DemeterCoreTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", "DemeterSprintBoon", "DemeterManaBoon" },
	DemeterRootTraits = { "DemeterWeaponBoon", "DemeterSpecialBoon", "DemeterCastBoon", },

	HephaestusCoreTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusCastBoon", "HephaestusSprintBoon", "HephaestusManaBoon" },
	HephaestusMassiveTraits = { "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon", }, -- MassiveCastBoon

	HeraCoreTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", "HeraManaBoon" },
	HeraLinkTraits = { "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon", },

	HestiaCoreTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", "HestiaSprintBoon", "HestiaManaBoon" },
	HestiaBurnTraits = { "HestiaWeaponBoon", "HestiaSpecialBoon", "HestiaCastBoon", }, -- "HestiaSprintBoon", EchoBurnBoon, BurnOmegaBoon

	PoseidonCoreTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonManaBoon" },
	PoseidonSplashTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon" }, -- PoseidonSplashSprintBoon
	PoseidonKnockbackTraits = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonExCastBoon", },
	PoseidonKnockbackAmplifyTraits = { "PoseidonCastBoon", "PoseidonStatusBoon" },

	ZeusCoreTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoon", },
	ZeusEchoTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", },
	ZeusBoltTraits = { "ZeusWeaponBoon", "ZeusSpecialBoon", "ZeusCastBoon", "ZeusSprintBoon", "ZeusManaBoltBoon", "BoltRetaliateBoon", "CastAnywhereBoon", },

	WeaponTraits = { "AphroditeWeaponBoon", "ApolloWeaponBoon", "DemeterWeaponBoon", "HephaestusWeaponBoon", "HeraWeaponBoon", "HestiaWeaponBoon", "PoseidonWeaponBoon", "ZeusWeaponBoon", "AresWeaponBoon" },
	SpecialTraits = { "AphroditeSpecialBoon", "ApolloSpecialBoon", "DemeterSpecialBoon", "HephaestusSpecialBoon", "HeraSpecialBoon", "HestiaSpecialBoon", "PoseidonSpecialBoon", "ZeusSpecialBoon", "AresSpecialBoon" },
	CastTraits = { "AphroditeCastBoon", "ApolloCastBoon", "DemeterCastBoon", "HephaestusCastBoon", "HeraCastBoon", "HestiaCastBoon", "PoseidonCastBoon", "ZeusCastBoon", "AresCastBoon" },
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

	-- Chaos
	ChaosLastStandBlessing = { OneOf = LootData.TrialUpgrade.PermanentTraits, },
	ChaosMetaUpgradeCurse = { OneOf = LootData.TrialUpgrade.PermanentTraits, },

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
	SpawnCastDamageBoon = { OneOf = LinkedTraitData.CastTraits, },
	LinkedDeathDamageBoon = { OneOf = LinkedTraitData.HeraLinkTraits, },
	--FullManaExBoostBoon = { OneOf = LinkedTraitData.HeraCoreTraits, },
	AllElementalBoon = 
	{
		OneFromEachSet = 
		{
			{ "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "HeraSprintBoon" },
			{ "BoonDecayBoon", "CommonGlobalDamageBoon", "OmegaHeraProjectileBoon", },
			{ "DamageSharePotencyBoon", "SpawnCastDamageBoon"},
		},
	},

	-- Hestia
	BurnArmorBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	BurnStackBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	OmegaZeroBurnBoon = { OneOf = LinkedTraitData.HestiaBurnTraits, },
	--CastProjectileBoon = { OneOf = LinkedTraitData.CastTraits, },
	--FireballManaSpecialBoon = { OneOf = LinkedTraitData.SpecialTraits, },
	BurnSprintBoon = 
	{

		OneFromEachSet =
		{
			{ "HestiaCastBoon" },
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
	LightningDebuffGeneratorBoon = { OneOf = {"FocusLightningBoon"}, },
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

	-- Ares
	
	RendBloodDropBoon = { OneOf = LinkedTraitData.AresRendTraits, },
	AresStatusDoubleDamageBoon = { OneOf = LinkedTraitData.AresRendTraits, },
	AresExCastBoon = { OneOf = LinkedTraitData.CastTraits, },
	DoubleBloodDropBoon =
	{
		OneFromEachSet =
		{
			{ "AresWeaponBoon", "AresSpecialBoon", "AresCastBoon", "AresSprintBoon", },
			LinkedTraitData.AresBloodDropTraits,
			{ "AresExCastBoon",  "AresStatusDoubleDamageBoon", "MissingHealthCritBoon", "LowHealthLifestealBoon", "OmegaDelayedDamageBoon", },
		},
	},

	-- Hermes
	LuckyBoon = 
	{
		OneOf =
		{
			"DoubleRewardBoon",
			"PoseidonCastBoon",
			"PoseidonStatusBoon",

			"BoltRetaliateBoon",
			"DoubleBoltBoon",
			"SpawnKillBoon",

			"BlindChanceBoon",
			"DoubleStrikeChanceBoon",

			"CritBonusBoon",
			"HighHealthCritBoon",
			"InsideCastCritBoon",
			"TimedCritVulnerabilityBoon",
			"FocusCritBoon",
			"DashOmegaBuffBoon",
			"SorceryCritBoon",

			"AresManaBoon",
			"BloodDropRevengeBoon",
			"MissingHealthCritBoon",
			"AresStatusDoubleDamageBoon",
			"RendBloodDropBoon",
			-- Duos
			"DoubleSplashBoon",
			"BloodManaBurstBoon",
			"MoneyDamageBoon",
		},
	},
	TimeStopLastStandBoon = 
	{
		OneOf =
		{
			"HermesWeaponBoon",
			"HermesSpecialBoon",
			"HermesCastDiscountBoon",
			"SprintShieldBoon",
			"SorcerySpeedBoon",
			"DodgeChanceBoon",
			"SlowProjectileBoon",
			"MoneyMultiplierBoon",
			"TimedKillBuffBoon",
			"RestockBoon",
			"LuckyBoon",
		},
	},

	-- Duos
	
	ManaShieldBoon = 
	{
		OneFromEachSet =
		{
			{ "DamageShareRetaliateBoon", "LinkedDeathDamageBoon", "DamageSharePotencyBoon", "SpawnCastDamageBoon", "OmegaHeraProjectileBoon", },
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
			{ "HeraWeaponBoon", "HeraSpecialBoon", "HeraCastBoon", "OmegaHeraProjectileBoon", },
			{ "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "OmegaPoseidonProjectileBoon" },
			{ "OmegaHeraProjectileBoon", "OmegaPoseidonProjectileBoon" },
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
			LinkedTraitData.PoseidonCoreTraits,
			LinkedTraitData.DemeterCoreTraits,
			{ "RoomRewardBonusBoon", "DoubleRewardBoon", "BoonGrowthBoon", "PlantHealthBoon", },
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
			LinkedTraitData.ApolloCoreTraits,
			LinkedTraitData.PoseidonCoreTraits,
			{ "ApolloSprintBoon", "PoseidonSprintBoon", },
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

	ManaRestoreDamageBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.HeraLinkTraits,
			LinkedTraitData.HestiaCoreTraits,
		},
	},

	SteamBoon = 
	{
		OneFromEachSet =
		{			
			LinkedTraitData.PoseidonKnockbackAmplifyTraits,
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
			LinkedTraitData.ApolloBlindTraits,
			LinkedTraitData.HestiaCoreTraits,
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
			{ "FocusLightningBoon" },
			LinkedTraitData.HephaestusCoreTraits,
		},
	},

	MassiveCastBoon = 
	{
		OneFromEachSet =
		{
			LinkedTraitData.PoseidonCoreTraits,
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
			{ "HephaestusWeaponBoon", "HephaestusSpecialBoon", "HephaestusSprintBoon" },
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
			LinkedTraitData.PoseidonKnockbackAmplifyTraits,
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

	SelfCastBoon = 
	{
		OneFromEachSet = 
		{
			{ "AresCastBoon", "AresExCastBoon", },
			LinkedTraitData.DemeterCoreTraits,
		}
	},

	AutoRevengeBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresRendTraits,
			LinkedTraitData.ZeusCoreTraits,
			{ "BloodDropRevengeBoon", "ApolloRetaliateBoon", "BoltRetaliateBoon" }
		}
	},

	BloodRetentionBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresBloodDropTraits,
			LinkedTraitData.HeraCoreTraits,
		}
	},

	RapidSwordBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresSwordTraits,
			LinkedTraitData.HephaestusCoreTraits,
		}
	},

	DoubleSwordBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresSwordTraits,
			LinkedTraitData.ApolloCoreTraits,
		}
	},

	DoubleSplashBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresCoreTraits,
			LinkedTraitData.PoseidonSplashTraits,
		}
	},

	FireballRendBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresCoreTraits,
			{ "FireballManaSpecialBoon", "CastProjectileBoon", },
		}
	},

	BloodManaBurstBoon = 
	{
		OneFromEachSet = 
		{
			LinkedTraitData.AresBloodDropTraits,
			LinkedTraitData.AphroditeCoreTraits,
		}
	},
	-- Special suit hex
	
	SpellMoonBeamTrait = { OneOf = {"SuitHexAspect" }}
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
	HammerRarityText = 
	{
		"TraitLevel_AspectLvl1",
		"TraitLevel_AspectLvl1",
		"TraitLevel_AspectLvl1",
		"TraitLevel_AspectLvl1",
		"TraitLevel_AspectLvl2",
		"TraitLevel_AspectLvl3",
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
			-- intentionally removed now that PoseidonLegacyBoonIntro01 is only for narrative flavor
			-- PathTrue = { "GameState", "TextLinesRecord", "PoseidonLegacyBoonIntro01" },
		},
	},
	ElementalGameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeElementalBoons" },
		},
		{
			PathFalse = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "HermesFirstPickUp" },
		},
	},
}

TraitElementData = 
{
	Fire = 
	{ 
		Icon = "FireTraitSmall",
		Keyword = "FireBoonKeyword",
		BaseElement = true,
	},
	Water = 
	{ 
		Icon = "WaterTraitSmall" ,
		Keyword = "WaterBoonKeyword",
		BaseElement = true,
	},
	Earth = 
	{ 
		Icon = "EarthTraitSmall" ,
		Keyword = "EarthBoonKeyword",
		BaseElement = true,
	},
	Air = 
	{ 
		Icon = "AirTraitSmall" ,
		Keyword = "AirBoonKeyword",
		BaseElement = true,
	},
	Aether = 
	{ 
		Icon = "AetherTraitSmall" ,
		Keyword = "AetherBoonKeyword",
		BaseElement = false,
	},
}

TraitSetData.Base =
{
	-- Base Data

	BaseTrait =
	{
		Cost = 30,
		DebugOnly = true,
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
		DebugOnly = true,
	},
	FireBoon = 
	{
		Elements = {"Fire"},
		DebugOnly = true,
	},
	EarthBoon = 
	{
		Elements = {"Earth"},
		DebugOnly = true,
	},
	WaterBoon = 
	{
		Elements = {"Water"},
		DebugOnly = true,
	},
	AetherBoon = 
	{
		Elements = {"Aether"},
		DebugOnly = true,
	},

	LegendaryTrait =
	{
		Cost = 120,
		BlockStacking = true,
		DebugOnly = true,
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
		DebugOnly = true,
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "ChosenRewardType", },
				IsNone = { "Devotion", },
			},
		},
		IsDuoBoon = true,
		Frame = "Duo",
		BlockStacking = true,
		DebugOnly = true,
		RarityLevels =
		{
			Duo =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
	},

	LegacyTrait = 
	{
		IsLegacyTrait = true,
		DebugOnly = true,
	},

	UnityTrait = 
	{
		IsElementalTrait = true,
		BlockStacking = true,
		BlockInRunRarify = true,
		BlockMenuRarify = true,
		ExcludeFromRarityCount = true,
		CustomRarityName = "Boon_Infusion",
		CustomRarityColor = Color.BoonPatchElemental,
		InfoBackingAnimation = "BoonSlotUnity",
		UpgradeChoiceBackingAnimation = "BoonSlotUnity",
		Frame = "Unity",
		DebugOnly = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1,
			},
		}
	},

	WeaponTrait =
	{
		Frame = "Hammer",
		IsHammerTrait = true,
		CustomRarityColor = Color.White,
		InfoBackingAnimation = "BoonSlotBase",
		DebugOnly = true,
		TrayTextBackingOffsetY = 3,
	},

	CostumeTrait = 
	{
		Frame = "Hammer",
		CostumeTrait = true,
		DebugOnly = true,
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
		DebugOnly = true,
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
		HideInRunHistory = true,
		StatLines =
		{
			"DeliveryTimeRemainingDisplay1",
		},
		SpeakerNames = { "Hermes" },
		SetupFunction =
		{
			Name = "LoadResourcesForPendingDeliveryItem",
			Args = {},
		},
	},

	ChaosCurseTrait =
	{
		Icon = "Shop_Vial",
		DebugOnly = true,
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
		DebugOnly = true,
	},

	ChaosBlessingTrait =
	{
		DebugOnly = true,
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
		DebugOnly = true,
		
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
		HideInRunHistory = true,
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

	ManaOverTimeSource = 
	{
		ManaOverTimeSource = true,
		DebugOnly = true,
	},

	-- Misc Traits
	FallbackGold = 
	{
		Icon = "Boon_No_Choice_Money",
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
			MultiplyMoney = true,
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

	InfernalContractBoon = 
	{
		Frame = "Common",
		Icon = "Trait_InfernalContract",
		FlavorText = "InfernalContractBoon_FlavorText",		
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

	UnusedWeaponBonusTrait =
	{
		--Frame = "MetaUpgrade",
		Icon = "Trait_UnusedWeaponBonus",
		HideInRunHistory = true,
		AddResources =
		{
			MetaCurrency = 3,
		},
		PreExitsUnlockedFunctionName = "UnusedWeaponBonusReward",
	},
	UnusedWeaponBonusTrait2 =
	{
		InheritFrom = { "UnusedWeaponBonusTrait" },
		Icon = "Trait_UnusedWeaponBonus2",
		OnRoomRewardSpawnedFunctionName = "UnusedWeaponBonusDropGems",
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
			},
		},
	},
}

TraitSetData.DummyWeapons =
{
	BaseDummyWeapon = 
	{
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

	DummyWeaponSuit = 
	{
		InheritFrom = { "BaseDummyWeapon" },
		CustomTitle = "WeaponSuit",
		CustomName = "WeaponSuit",
		FlavorText = "WeaponSuit_FlavorText",
		Icon = "Hammer_Suit_01",
	},

}

TraitSetData.Aspects = {}

OverwriteTableKeys( TraitData, TraitSetData.Base )
OverwriteTableKeys( TraitData, TraitSetData.DummyWeapons )
