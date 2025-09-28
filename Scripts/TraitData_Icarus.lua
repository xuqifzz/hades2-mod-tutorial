OverwriteTableKeys( TraitData, {
	-- Icarus
	BaseIcarus = 
	{
		PackageName = "NPC_Icarus_01",
		DebugOnly = true,
	},
	
	FocusAttackDamageTrait = 
	{
		InheritFrom = {"BaseIcarus"},
		Icon = "Boon_Icarus_04",
		AcquireFunctionName = "IcarusUpgradeBoon",
		AcquireFunctionArgs = 
		{
			Count = 3,
			Slot = "Melee",
			ReportValues = { ReportedCount = "Count"}
		},
		SelectedTrait = "None_In_Slot",
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusAttackDamage",
				ManaReservationCost = { BaseValue = 35 },
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
				Key = "ReportedCount",
				ExtractAs = "TooltipBonus",
			},
			{
				Format = "SlottedBoon",
				Slot = "Melee",
				ExtractAs = "SlotBoon",
			},
		}
	},
	FocusSpecialDamageTrait = 
	{
		InheritFrom = {"BaseIcarus"},
		Icon = "Boon_Icarus_05",
		AcquireFunctionName = "IcarusUpgradeBoon",
		AcquireFunctionArgs = 
		{
			Count = 3,
			Slot = "Secondary",
			ReportValues = { ReportedCount = "Count"}
		},
		SelectedTrait = "None_In_Slot",
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusSpecialDamage",
				ManaReservationCost = { BaseValue = 35 },
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
				Key = "ReportedCount",
				ExtractAs = "TooltipBonus",
			},
			{
				Format = "SlottedBoon",
				Slot = "Secondary",
				ExtractAs = "SlotBoon",
			},
		}
	},
	
	OmegaExplodeBoon = 
	{
		Icon = "Boon_Icarus_06",
		InheritFrom = {"BaseIcarus"},

		ManaCostModifiers = 
		{
			WeaponNames = ConcatTableValues( ShallowCopyTable( WeaponSets.HeroAllWeaponsAndSprint), { "WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" }),
			ExWeapons = true,
			ManaCostAdd = 10,
			ReportValues = 
			{ 
				ReportedCost = "ManaCostAdd" 
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
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
					Source = "Icarus",
					Delay = 0.75,
					BaseAmount = { BaseValue = 50 },
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
				DamageMultiplier = 1,
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
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "IcarusArmorExplosion",
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
					Source = "Icarus",
					Delay = 0.75,
					BaseAmount = { BaseValue = 100 },
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
			Amount = { BaseValue = 7 },
			DropResources = 
			{
				Delay = 0.5,
				NotRequiredPickup = true,
				ForceToValidLocation = true,
				UseSurfaceSpawnPoints = true,
				KeepCollision = true,
				LootOptions =
				{
					{
						Name = "HealDropMinor",
						Amount = 1,
					},
					{
						Name = "StoreRewardRandomStack",
						Amount = 2,
					},
				}
			},
			ReportValues = 
			{ 
				ReportedRoomsPerDrop = "Amount" 
			},
		},
		StatLines = {},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "HealDropMinor",
				Format = "FlatHeal",
				BaseProperty = "HealFixed",
				ExtractAs = "HealDropAmount"
			},
			{
				Key = "ReportedRoomsPerDrop",
				ExtractAs = "TooltipAmount",
			},
		}
	},

	UpgradeHammerBoon = 
	{
		InheritFrom = { "BaseIcarus"},
		Icon = "Boon_Icarus_08",
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGrantsReward01" },
			},
		},
		AcquireFunctionName = "UpgradeHammers",
		AcquireFunctionArgs =
		{ 
		},
		FlavorText = "UpgradeHammerBoon_FlavorText",
	},
})