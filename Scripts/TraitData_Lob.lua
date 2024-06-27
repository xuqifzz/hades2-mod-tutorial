OverwriteTableKeys( TraitData, {
	-- Lob
	LobAmmoTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_02",
		RequiredWeapon = "WeaponLob",
		WeaponAmmoModification = 
		{
			Name = "WeaponLob",
			AddMaxAmmo = { BaseValue = 2 },
			ReportValues = { ReportedAmmoBonus = "AddMaxAmmo"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmmoBonus",
				ExtractAs = "AmmoIncrease",
			},
		}
	},
	LobAmmoMagnetismTrait =
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_01",
		RequiredWeapon = "WeaponLob",
		RequiredFalseTraits = { "LobPulseAmmoTrait" },
		PropertyChanges =
		{
			{
				UnitProperty = "Magnetism",
				BaseValue = 100.0,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
				ExtractValue =
				{
					ExtractAs = "TooltipMagnetism",
					Format = "PercentDelta"
				}
			},
			{
				UnitProperty = "MagnetismFx",
				ChangeValue = "HermesWings_Ammo",
			}
		},
		WeaponAmmoModification = 
		{
			Name = "WeaponLob",
			ReduceMaxAmmo = 1,
			ReportValues = { ReportedAmmoPenalty = "ReduceMaxAmmo"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmmoPenalty",
				ExtractAs = "AmmoPenalty",
			},
		}
	},
	LobRushArmorTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_08",
		RequiredWeapon = "WeaponLob",
		AddOutgoingDamageModifiers =
		{
			NonExHealthBufferRemoval = 0.50,
			ValidWeapons = { "WeaponLobSpecial" },
			ReportValues = { ReportedWeaponMultiplier = "NonExHealthBufferRemoval"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "ArmorDamageIncrease",
				Format = "Percent",
			},
		}
	},
	LobSpreadShotTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_10",
		RequiredWeapon = "WeaponLob",
		WeaponDataOverride =
		{
			WeaponLob =
			{
				OnChargeFunctionNames = { "DoWeaponCharge", "UpdateLobWeaponProjectileNum"},
			}
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			AddWeaponProperties = 
			{
				ProjectileAngleOffset = math.rad(25),
			}
		}
	},
	LobOneSideTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_05",
		RequiredWeapon = "WeaponLob",
		
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,

			ExMultiplier =
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "ExMultiplier"},
		},
		
		PropertyChanges = 
		{
			--[[
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Fuse",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			{
				--TraitName = "LobInOutSpecialExTrait",
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Speed",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Fuse",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulseWave",
				ProjectileProperty = "Speed",
				ChangeValue = 2.5,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "SpawnCount",
				ChangeValue = 1,
				ChangeType = "Absolute",
			}
			]]

			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeRangeMultiplier",
				ChangeValue = 1.1,
				ChangeType = "Multiply",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		},	
	},
	LobSturdySpecialTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_12",
		RequiredWeapon = "WeaponLob",
		
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponLobSpecial" },
			FunctionName = "StartLobSturdy",
			FunctionArgs =
			{
				DamageTakenModifier = 0.7,
				ReportValues = 
				{ 
					ReportedSturdyModifier = "DamageTakenModifier" 
				},
			},
		},
		--[[
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			NonExBaseDamageAddition = 
			{ 
				BaseValue = 45,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "NonExBaseDamageAddition" 
			},
		},
		]]
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponLobSpecial" },
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 30,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSturdyModifier",
				ExtractAs = "SturdyModifier",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageIncrease",
			},
		},		
	},
	LobSpecialSpeedTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_09",
		RequiredWeapon = "WeaponLob",
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.65,
				ChangeType = "Multiply",
			},
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponLobSpecial" },
			Value = 
			{
				BaseValue = 0.65,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeed = "Value" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true
			},
		}
	},
	LobInOutSpecialExTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_04",
		RequiredWeapon = "WeaponLob",
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "ReverseAfterDuration",
				ChangeValue = 0.3,
			},
		}
	},
	LobPulseAmmoCollectTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_06",
		RequiredWeapon = "WeaponLob",
		PreEquipWeapons = { "WeaponLobChargedPulse" },
		OnCollectAmmoFunctionName = 
		{
			WeaponName = "WeaponLob",
			FunctionName = "FireAmmoCollectionPulse",
			FunctionArgs = 
			{
				PulseWeaponName = "WeaponLobChargedPulse",
				ManaCost = 10,
				ReportValues = { ReportedCost = "ManaCost" }
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedCost",
				ExtractAs = "Cost",
			}
		}

	},
	LobPulseAmmoTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_07",
		RequiredWeapon = "WeaponLob",
		PreEquipWeapons = { "WeaponLobPulse" },
		RequiredFalseTraits = { "LobAmmoMagnetismTrait" },
		PulseArgs = 
		{
			Interval = 2.5,
			
			ReportValues = 
			{ 
				ReportedInterval = "Interval" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 2,
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponLobPulse",
				BaseProperty = "BaseDamageBonusMultiplier",
				ExtractAs = "TooltipDamage",
				Format = "Percent",
			},
		},	
	},
	LobGrowthTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_03",
		RequiredWeapon = "WeaponLob",
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponLob",
				ProjectileProperties = 
				{
					MaxSize = 3,				-- Size of projectile
					SizeDuration = 2,
					MaxBlastModifier = 1.5,		-- Size of explosion
					BlastModifierDuration = 2,
				},
				ExcludeLinked = true,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponLob" },
			LifetimeNonExMultiplier = 0.50,
			ReportValues = 
			{ 
				LifetimeMultiplier = "LifetimeNonExMultiplier" 
			},
			ExcludeLinked = true,
		},
		ExtractValues =
		{
			{
				Key = "LifetimeMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "Percent",
				IncludeSigns = true,
			},
		},
	},
	LobStraightShotTrait = 
	{
		InheritFrom = { "WeaponTrait" },
		Icon = "Hammer_Lob_11",
		RequiredWeapon = "WeaponLob",
		ChargeStageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			AddWeaponProperties = 
			{
				AimLineAnimation = "AuraAimLine",
				ManualAiming = "null",
				TargetReticleAnimation = "null",
			},
		},
		PropertyChanges =
		{	
			{
				WeaponName = "WeaponLob",
				ProjectileName = "ProjectileLobCharged",
				ProjectileProperties = 
				{
					CheckUnitImpact = true,
					ObstacleCollisionCheck = "PolygonContainsPoint",
					Type = "STRAIGHT",
					SpinRate = 0,
					Speed = 2300,
				}
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ExBaseDamageAddition = 
			{ 
				BaseValue = 20,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ExBaseDamageAddition" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSturdyModifier",
				ExtractAs = "SturdyModifier",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageIncrease",
			},
		},	
	},
})