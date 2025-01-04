OverwriteTableKeys( TraitData, {
	-- Lob
	LobHammerTrait = 
	{
		CodexWeapon = "WeaponLob"
	},

	LobAmmoTrait = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_02",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "LobPulseAmmoTrait" },
			},
		},
		AmmoMagnetismMultiplier = 100,
		PropertyChanges =
		{
			{
				UnitProperty = "MagnetismFx",
				ChangeValue = "LobAmmoMagnetismFx",
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_08",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_10",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		ForceWeaponRefreshOnRemove = "WeaponLob",
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_05",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_12",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_09",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_04",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_06",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_07",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "LobAmmoMagnetismTrait" },
			},
		},
		PreEquipWeapons = { "WeaponLobPulse" },
		OnTouchdownFunction =
		{
			Name = "CheckLobPulse",
		},
		ExtractValues =
		{
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_03",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Lob_11",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
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
				BaseValue = 60,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ExBaseDamageAddition" 
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageIncrease",
			},
		},

		WeaponDataOverride =
		{
			WeaponLob =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelinoeSkullsChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},			
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteAttackingBombLob" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
						{ Name = "/SFX/Player Sounds/MelSkullsOmegaAttackExplode" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/ArrowMetalBoneSmash",
						Brick = "/SFX/ArrowMetalStoneClang",
						Stone = "/SFX/ArrowMetalStoneClang",
						Organic = "/SFX/GunBulletOrganicImpact",
						StoneObstacle = "/SFX/ArrowWallHitClankSmall",
						BrickObstacle = "/SFX/ArrowWallHitClankSmall",
						MetalObstacle = "/SFX/ArrowWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
		},

	},
	
	LobSpecialAspect = 
	{
		InheritFrom = { "WeaponTrait", "LobHammerTrait" },
		Icon = "Hammer_Torch_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponLob", },
			},
		},
		LobExSpecialRecall = true,
	},
})