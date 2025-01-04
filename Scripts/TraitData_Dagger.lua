OverwriteTableKeys( TraitData, {
	-- Dagger
	DaggerHammerTrait = 
	{
		CodexWeapon = "WeaponDagger"
	},

	DaggerBlinkAoETrait = 
	{
		InheritFrom = { "WeaponTrait", "DaggerHammerTrait" },
		Icon = "Hammer_Daggers_29",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "DaggerRapidAttackTrait", },
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "Weapons", },
				HasAll = { "WeaponDagger", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "DaggerBlockAspect", "DaggerBlinkAoETrait", "DaggerFinalHitTrait", "SlowExAttackBoon" },
			},
		},
		PropertyChanges =
		{	
			{
				WeaponNames = { "WeaponDagger", "WeaponDagger2", "WeaponDaggerDash", "WeaponDaggerMultiStab", "WeaponDaggerDouble", "WeaponDaggerBlink" },
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.65,
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
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "DaggerSpecialFanTrait", },
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
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "DaggerSpecialLineTrait", },
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
		WeaponDataOverride =
		{
			WeaponDaggerThrow = 
			{
				ChargeWeaponStages = 
				{
						{ ManaCost = 6, WeaponProperties = { Projectile = "ProjectileDaggerThrowCharged", FireGraphic = "Melinoe_Dagger_SpecialEx_Fire", NumProjectiles = 4}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.32, ChannelSlowEventOnEnter = true },
						{ ManaCost = 8, WeaponProperties = { NumProjectiles = 6 }, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 10, WeaponProperties = { NumProjectiles = 8}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 12, WeaponProperties = { NumProjectiles  = 10}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 14, WeaponProperties = { NumProjectiles  = 12}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 16, WeaponProperties = { NumProjectiles  = 13}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 18, WeaponProperties = { NumProjectiles  = 15}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.1, },
						{ ManaCost = 20, WeaponProperties = { NumProjectiles  = 16, ReportValues = { ReportedAmount = "NumProjectiles" } }, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.06, },
				},
			}
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties = 
				{ 
					ProjectileAngleOffset = math.rad(22.5),
					ProjectileInterval = 0.015,
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
			NonExHealthBufferRemoval = 0.50,
			ValidWeapons = { "WeaponDaggerThrow" },
			ReportValues = { ReportedWeaponMultiplier = "NonExHealthBufferRemoval" },
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
				Format = "Percent",
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
		WeaponDataOverride =
		{	
			--[[
			WeaponDaggerThrow =
			{
				ChargeWeaponStages = {},
			},
			]]
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
				WeaponProperties = 
				{ 
					--FireOnRelease = false,
					--ChargeTime = 0.23,
					--MinChargeToFire = 1.0,
					--SwapOnFire = "null"
				},
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
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/StabSplatterSmall",
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
			Value = 0.6,
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
        --[[
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponDagger5"},
			ValidMapKeyBaseDamageAddition = "DaggerLastHit",
		},
		SetupFunction = 
		{
			Name = "DaggerLastHitSetup",
		},
		OnEnemyDeathFunction = 
		{
			Name = "DaggerFinalHitIncrease",
			FunctionArgs = {
				RequiredWeapon = "WeaponDagger5",
				CombatText = "DaggerFinalHit",
				DamageIncrease = 15,
				ReportValues = 
				{ 
					ReportedDamageBonus = "DamageIncrease",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
			},
			{
				Key = "AccumulatedDaggerDamageBonus",
				ExtractAs = "TooltipAccumulatedBonus",
			},
		},
		]]

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
	
		AddOutgoingDamageModifiers = 
		{	
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = 15,
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
			HitVulnerabilityMultiplier = 2.5,
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

	DaggerSpecialRangeTrait = 
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
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponDaggerThrow" },
			ExcludeLinked = true,
			DistanceThreshold = 650,
			DistanceMultiplier =
			{
				BaseValue = 2,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "DistanceMultiplier"},
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponDaggerThrow", },
			RevertProjectileProperties = 
			{
				Range = true,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrow",
				ProjectileProperties = 
				{
					Range = 1400,
				},
			},
		},
	},
	DaggerRepeatStrikeTrait = 
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
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerMultiStab",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					FullyAutomatic = true,
					ControlWindow = 0.6,
					SwapOnFire = "WeaponDaggerMultiStab",
					AddOnFire = "null",
					LoseControlIfNotCharging = true,
					ForceReleaseOnSwap = false,
				}
			},
		},
	},
})