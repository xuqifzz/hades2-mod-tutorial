OverwriteTableKeys( TraitData, {
	-- Icarus
	BaseIcarus = 
	{
		PackageName = "NPC_Icarus_01",
	},
	FocusAttackDamageTrait = 
	{
		InheritFrom = {"BaseIcarus"},
		Icon = "Boon_Icarus_04",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ValidBaseDamageAddition = { BaseValue = 10 },
			ReportValues = { ReportedBonus = "ValidBaseDamageAddition" }
		},
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusAttackDamage",
				ManaReservationCost = { BaseValue = 20 },
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost"
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
			},
			{
				Key = "ReportedBonus",
				ExtractAs = "TooltipBonus",
			},
		}
	},
	FocusSpecialDamageTrait = 
	{
		InheritFrom = {"BaseIcarus"},
		Icon = "Boon_Icarus_05",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = { BaseValue = 20 },
			ReportValues = { ReportedBonus = "ValidBaseDamageAddition" }
		},
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusSpecialDamage",
				ManaReservationCost = { BaseValue = 40 },
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost"
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
			},
			{
				Key = "ReportedBonus",
				ExtractAs = "TooltipBonus",
			},
		}
	},
	
	OmegaExplodeBoon = 
	{
		Icon = "Boon_Icarus_06",
		InheritFrom = {"BaseIcarus"},

		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroAllWeapons,
			ExWeapons = true,
			ManaCostAdd = 10,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckIcarusExplosion",
			Args = 
			{
				DamageMultiplier = 1,
				ProjectileName = "IcarusExplosion",
				ExcludeLinked = true,
				MultihitWeaponWhitelist = 
				{
					"WeaponStaffSwing5",

					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxeSpin",

					"WeaponAxeSpecialSwing",

					"WeaponTorch",
					"WeaponTorchSpecial",

					"WeaponLob",
					"WeaponLobSpecial",
					"WeaponLobChargedPulse",

				},
				MultihitWeaponConditions = 
				{
					WeaponStaffSwing5 = { Cooldown = 0.02 },
					
					WeaponAxe = { Cooldown = 0.04 },
					WeaponAxe2 = { Cooldown = 0.04 },
					WeaponAxe3 = { Cooldown = 0.02 },
					WeaponAxeSpin = { Cooldown = 0.05 },
					WeaponAxeSpecialSwing = { Cooldown = 0.02 },

					WeaponTorch = { Cooldown = 0.3 },
					WeaponTorchSpecial = { Cooldown = 0.3 },

					WeaponLob = { Cooldown = 0.05 },
					WeaponLobSpecial = { Cooldown = 0.1 },
					WeaponLobChargedPulse = { Cooldown = 0.05 },
				},
				ReportValues = { ReportedMultiplier = "DamageMultiplier" },
			},		
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "IcarusExplosion",
				BaseProperty = "Damage",
			},
		}
	},
	CastHazardBoon = 
	{
		Icon = "Boon_Icarus_03",
		InheritFrom = {"BaseIcarus"},

		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			ExcludeLinked = true,
			FunctionName = "IcarusHazardCast",
			FunctionArgs =
			{
				ProjectileName = "IcarusHazardExplosion",
				DamageMultiplier = { BaseValue = 1, },
				ReportValues = { ReportedMultiplier = "DamageMultiplier"}
			},
		},
		
		OnSelfDamagedFunction = 
		{
			Name = "IcarusSelfDamage",
			FunctionArgs = 
			{
				Damage = 20,
				ReportValues = 
				{ 
					ReportedDamage = "Damage",
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipSelfDamage",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "IcarusHazardExplosion",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "IcarusHazardExplosion",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
		}
	},

	BreakExplosiveArmorBoon = 
	{
		InheritFrom = { "BaseIcarus", "CostumeTrait" },
		Icon = "Boon_Icarus_01",
		Frame = "nil",
		Uses = 1,
		Invincible = true,
		SetupFunctions =
		{
			{
				Name = "CostumeArmor",
				Args =
				{
					Source = "Tradeoff",
					Delay = 0.75,
					BaseAmount = { BaseValue = 40 },
					ReportValues = 
					{ 
						ReportedArmor = "BaseAmount",
					}
				},
			},
		},
		OnArmorBreakFunction = 
		{
			Name = "IcarusArmorExplosion",
			Args = 
			{
				ProjectileName = "IcarusArmorExplosion",
				DamageMultiplier = 8,
				ReportValues = 
				{
					ReportedMultiplier = "DamageMultiplier",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "IcarusHazardExplosion",
				BaseProperty = "Damage",
			},
		}
	},
	BreakInvincibleArmorBoon = 
	{
		InheritFrom = { "BaseIcarus", "CostumeTrait" },
		Icon = "Boon_Icarus_02",
		Frame = "nil",
		Uses = 1,
		Invincible = true,
		SetupFunctions =
		{
			{
				Name = "CostumeArmor",
				Args =
				{
					Source = "Tradeoff",
					Delay = 0.75,
					BaseAmount = { BaseValue = 80 },
					ReportValues = 
					{ 
						ReportedArmor = "BaseAmount",
					}
				},
			},
		},
		OnArmorBreakFunction = 
		{
			Name = "IcarusArmorInvulnerability",
			Args = 
			{
				EffectName = "IcarusInvulnerable",
				Duration = 8,
				ReportValues = 
				{
					ReportedDuration = "Duration",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
			},
		}
	},
	
	SupplyDropBoon =
	{
		Icon = "Boon_Icarus_07",
		InheritFrom = {"BaseIcarus"},
		CurrentRoom = 0,
		RoomsPerUpgrade = 
		{ 
			Amount = { BaseValue = 5 },
			DropResources = 
			{
				Delay = 0.5,
				NotRequiredPickup = true,
				ForceToValidLocation = true,
				LootOptions =
				{
					{
						Name = "HealDropMinor",
						Amount = 1,
					},
					{
						Name = "StoreRewardRandomStack",
						Amount = 3,
					},
				}
			},
			ReportValues = 
			{ 
				ReportedRoomsPerDrop = "Amount" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedRoomsPerDrop",
				ExtractAs = "TooltipAmount",
			},
		}
	},
})