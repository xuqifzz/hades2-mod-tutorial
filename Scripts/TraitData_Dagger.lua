OverwriteTableKeys( TraitData, {
	-- Dagger
	DaggerHammerTrait = 
	{
		CodexWeapon = "WeaponDagger",
		DebugOnly = true,
	},

	DaggerBlinkAoETrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_29",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		ManaCostModifiers = 
		{
			ExcludeLinked = true,
			WeaponNames = {"WeaponDagger5"},
			ManaCostAdd = 20,
			ReportValues = { ReportedManaCost = "ManaCostAdd" }
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 5.0,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponDagger5" },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDagger5",
				ProjectileName = "ProjectileDaggerBackstab",
				ProjectileProperties = 
				{
					DamageRadius = 360,
					DamageRadiusScaleY = 0.6,
					BlastSpeed = 2000,
					DetonateFx = "DaggerBlinkAoEDetonate"
				},
			},
		},	
		ExtractValues =
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "Mana",
			},
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		},
	},

	DaggerDashAttackTripleTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_41",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponDagger", },
				IsNone = {"DaggerTripleAspect", }
			},
		},
		
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponDaggerDash"},
			FunctionName = "FireDaggerSpecial",
			ExcludeLinked = true,
			FunctionArgs =
			{
				Projectiles = 3,
				Spread = 60,
				ReportValues = 
				{
					ReportedProjectiles = "Projectiles"
				},
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerDash",
				WeaponProperty = "FireSound",
				ChangeValue = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP",
				ChangeType = "Absolute",
			},
		},

		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Count",
			},
		}
	},

	DaggerRapidAttackTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_32",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.55/0.65,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponNames = { "WeaponDagger", "WeaponDagger2", "WeaponDaggerDash", "WeaponDaggerMultiStab", "WeaponDaggerDouble", "WeaponDaggerBlink" },
				WeaponProperty = "ChargeTime",
				BaseValue = 0.65,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				ReportValues = { ReportedWeaponMultiplier = "ChangeValue" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta",
			},
		},	
	},

	DaggerSpecialLineTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_36",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 5/3,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties = 
				{ 
					ProjectileAngleOffset = 0
				},
				ExcludeLinked = true
			},
			{
				TraitName = "DaggerTripleAspect",
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties = 
				{ 
					ProjectileAngleOffset = 0,
					ProjectileInterval = 0.2,
					ProjectileIntervalStart = 0.2,
				},
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileProperty = "Range",
				BaseValue = 1.3,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedRangeBonus = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "AutoLockRange",
				ChangeValue = 1.3,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperty = "ReturnToOwnerAfterInactiveSeconds",
				ChangeValue = 1.3,
				ChangeType = "Multiply",
			},
		},	
		ExtractValues =
		{
			{
				Key = "ReportedRangeBonus",
				ExtractAs = "RangeIncrease",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			},
		}
	},

	DaggerSpecialFanTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_34",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 2,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponDaggerThrow" },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
			ExcludeLinked = true,
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponDaggerThrow" },
			IncreaseNumProjectiles =
			{
				NumProjectiles = 3,
				ReportValues = { ReportedAmount = "NumProjectiles" }
			},
			AddWeaponProperties = 
			{
				ProjectileInterval = 0.04,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties = 
				{ 
					ProjectileInterval = 0.04,
				},
				ProjectileProperties = 
				{
					DrawDuringPause = false,
				},
				ExcludeLinked = true
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmount",
				ExtractAs = "Amount",
			},
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		}
	},

	DaggerSpecialConsecutiveTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_33",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		AddOutgoingDamageModifiers = 
		{	
			--[[
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			NonExBaseDamageAddition = { BaseValue = 25 },
			ReportValues = 
			{ 
				ReportedDamage = "NonExBaseDamageAddition"
			},
			]]
			NonExFlatDamageToArmor = 500,
			ValidWeapons = { "WeaponDaggerThrow" },
			ReportValues = { ReportedWeaponMultiplier = "NonExFlatDamageToArmor" },
		},
		PropertyChanges =
		{	
			--[[
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileProperty = "DamagePerConsecutiveHit",
				BaseValue = 4,
				SourceIsMultiplier = true,
				ChangeType = "Add",
				ReportValues = { ReportedConsecutiveHit = "ChangeValue"},
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileProperty = "ConsecutiveHitWindow",
				ChangeValue = 0.20,
			},
			]]
		},	
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "ArmorDamageIncrease",
			},
		}
	},

	DaggerSpecialJumpTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 2,
			},
		},
		WeaponDataOverride =
		{	
			
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.15,
				SourceIsMultiplier = true,
			},
			ValidWeapons = { "WeaponDaggerThrow" },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
			ExcludeLinked = true,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileProperties = 
				{
					NumJumps = 2,
	  				JumpType = "UNIT_PREFERENCE",
      				JumpRange = 620,
      				JumpSpeedMultiplier = 1.1,
					NoJumpTargetRandomSpread = 90,
					ReportValues = { Jumps = "NumJumps"},
				},
				ExcludeLinked = true
			},
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperties = 
				{
					FinalJumpToOwner = true,
					NumJumps = 3,
				}

			}
		},	
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "Jumps",
				ExtractAs = "NumJumps",
				--Format = "PercentDelta",
			},
		}
	},

	DaggerAttackFinisherTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_27",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 4/3,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponDaggerDouble" },
			ExcludeLinked = true,
			ValidWeaponMultiplier = { BaseValue = 4, SourceIsMultiplier = true },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier" },
		},
		
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerDouble",
				ProjectileProperty = "DamageRadius",
				ChangeValue = 1.6,
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

		WeaponDataOverride =
		{
			WeaponDaggerDouble =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCharging" },
						{ Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" } },
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
						{ Name = "/SFX/Player Sounds/MelDaggerMagicAttack" },
						{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" }
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmashShort",
						Brick = "/SFX/MetalStoneClangShort",
						Stone = "/SFX/MetalStoneClangShort",
						Organic = "/SFX/MetalOrganicHitSHIELDshort",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				}
			},
		},
	},

	DaggerChargeStageSkipTrait = 
	{
		InheritFrom = {"WeaponTrait", "DaggerHammerTrait"},
		Icon = "Hammer_Daggers_30",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.25,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		--[[
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponDaggerThrow", },
			SkipToFinal = true,
		},
		ManaCostModifiers = 
		{
			WeaponNames = { "WeaponDaggerThrow" },
			ManaCostMultiplier = 0.34 ,
			ReportValues = { ReportedManaCost = "ManaCostMultiplier" }
		},
		]]
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			Value = { BaseValue = 0.6, SourceIsMultiplier = true },
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},	
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "TooltipChargeSpeed",
				Format = "NegativePercentDelta",
			},
			--[[
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaDelta",
				Format = "PercentDelta",
			},
			]]
		}
	},

	DaggerFinalHitTrait = 
	{
		InheritFrom = {"WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_31",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDagger",
				ProjectileProperty = "Damage",
				BaseValue = 20,
				ChangeType = "Add",
				ReportValues = { ReportedDamageChange = "ChangeValue" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
			},
		}
	},

	DaggerSpecialReturnTrait = 
	{
	
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_37",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
	
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 25/15
			},
		},
		AddOutgoingDamageModifiers = 
		{	
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = { BaseValue = 15 },
			ReportValues = 
			{ 
				ReportedDamage = "ValidBaseDamageAddition"
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 2,
				ChangeType = "Multiply",
			},
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperty = "AimLineWidthOverride",
				ChangeValue = 100,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "DamageIncrease",
			},
		}
	},

	DaggerBackstabTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_28",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 2.0/1.5,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			HitVulnerabilityMultiplier = { BaseValue = 2.5, SourceIsMultiplier = true },
			ReportValues = { ReportedWeaponMultiplier = "HitVulnerabilityMultiplier" },
		},	
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
		}
	},

	-- Morrigan
	DaggerTripleBuffTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_43",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 1.5,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponDagger", },
				IsAny = {"DaggerTripleAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" }
			},
		},
		WomboDamageBonusMultiplier = { BaseValue = 2 },
		ExtractValues = 
		{
			{
				Key = "WomboDamageBonusMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "WomboStrike",
				BaseProperty = "Damage",
			},
		}
	},
	DaggerTripleRepeatWomboTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_44",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.44/0.33,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponDagger", },
				IsAny = {"DaggerTripleAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" }
			},
		},
		RepeatTripleStrikeChance = {BaseValue = 0.33},
		ExtractValues =
		{
			{
				Key = "RepeatTripleStrikeChance",
				ExtractAs = "RepeatChance",
				Format = "LuckModifiedPercent"
			},
		}
	},
	DaggerTripleHomingSpecialTrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_45",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Legendary = 
			{
				Multiplier = 0.6/0.5,
			},
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "GameState", "LastWeaponUpgradeName", "WeaponDagger", },
				IsAny = {"DaggerTripleAspect", }
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" }
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileProperty = "ImmunityDuration",
				BaseValue = 0.5,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedIntervalChange = "ChangeValue" },
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedIntervalChange",
				ExtractAs = "SpeedChange",
				Format = "PercentReciprocalDelta"
			},
		}
	},
})