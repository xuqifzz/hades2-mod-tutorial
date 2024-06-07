TraitSetData.Aspects =
{
	BaseStaffAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_39",
		RequiredWeapon = "WeaponStaffSwing",
		WeaponKitGrannyModel = "WeaponStaff_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Mesh"
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroAllWeapons,
			Value = 
			{
				BaseValue = 0.85,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponCastArm", "WeaponStaffSwing5", },
				BaseValue = 0.85,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		StatLines =
		{
			"EXSpeedStatDisplay",
		},
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0,
				MaxMultiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.34,
			},
			Heroic =
			{
				Multiplier = 1.67,
			},
			Legendary =
			{
				Multiplier = 2.00,
			},
			Perfect = 
			{
				Multiplier = 2.34,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "SpeedBonus",
				Format = "NegativePercentDelta"
			},
		},
		FlavorText = "BaseStaffAspect_FlavorText",
	},
	StaffClearCastAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_40",
		RequiredWeapon = "WeaponStaffSwing",
		WeaponKitGrannyModel = "WeaponStaff_Circe_Mesh",	
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Circe_Mesh"
		},

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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 3.5,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupClearCastUI",
		},
		ClearCastDamageMultiplierOverride = {BaseValue = 1.4, SourceIsMultiplier = true },
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckClearCastStart",
			FunctionArgs = 
			{
				RequiredCount = 12,
				EffectName = "ClearCast",
				DataProperties = 
				{
					Duration = 5,
					ReportValues = { ReportedDuration = "Duration"},
				},
				ReportValues = { ReportedCount = "RequiredCount"}
			},
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckClearCastCount",
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FirstHitOnly = true,
			Args = 
			{
				IsNotEx = true,
			},
		},
		OnManaSpendAction = 
		{
			FunctionName = "CheckClearCastManaRefund",
			FunctionArgs = 
			{
				AnimationName = "ManaRegenFlashFx",
				Duration = 1,
			}
		},
		StatLines =
		{
			"ClearCastDurationDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ClearCast",
				BaseProperty = "Duration",
			},
			{
				Key = "ClearCastDamageMultiplierOverride",
				ExtractAs = "BonusDamage",
				Format = "PercentDelta",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "ExDamageMultiplier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				Format = "PercentDelta",
				BaseName = "ClearCast",
				BaseProperty = "Amount",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "StaffClearCastAspect_FlavorText",
	},
	
	StaffSelfHitAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 3/3.5,
			},
			Epic =
			{
				Multiplier = 2.5/3.5,
			},
			Heroic =
			{
				Multiplier = 2/3.5,
			},
			Legendary =
			{
				Multiplier = 1.5/3.5,
			},
			Perfect = 
			{
				Multiplier = 1/3.5,
			},
		},
		Icon = "Hammer_Staff_41",
		RequiredWeapon = "WeaponStaffSwing",
		-- 'I have a good idea for a prank for this Asclepius character' ~Momus
		WeaponKitGrannyModel = "WeaponStaff_Asclepius_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Asclepius_Mesh"
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "DropOriginMarker",
			FunctionArgs = 
			{
				AnimationName = "WitchGrenadeRecallSphere",
				ExpiringAnimationName = "WitchGrenadeRecallSphereOut",
				DestroyDelay = 0.5,
				Repeats = 3,
				Interval = { BaseValue = 3.5 },
				ReportValues = { ReportedStrikeCount = "Repeats"},
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "ClearOriginMarker",
			Args = 
			{
				ExpiringAnimationName = "WitchGrenadeRecallSphereOut",
				DestroyDelay = 0.5,
				CastRepeats = 3,
				Interval = { BaseValue = 3.5 },
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing5"},
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectileWaves = 3,
				},
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileWaveInterval",
				BaseValue = 3.5,
				ReportValues = { ReportedPulseInterval = "ChangeValue"},
			}
		},
		StatLines =
		{
			"PulseIntervalStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedPulseInterval",
				ExtractAs = "PulseInterval",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedStrikeCount",
				ExtractAs = "StrikeCount",
				SkipAutoExtract = true
			}
		},
		FlavorText = "StaffSelfHitAspect_FlavorText",
	},
	DaggerBackstabAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_38",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDagger_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			HitVulnerabilityMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedMultiplier = "HitVulnerabilityMultiplier"},

		},
		StatLines =
		{
			"BackstabStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "DaggerBackstabAspect_FlavorText",
	},
	DaggerHomingThrowAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_40",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDaggerMultiple_Pan_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Pan_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Pan_Mesh"
		},
		ChargeStageModifiers = 
		{
			ValidWeapons = {"WeaponDaggerThrow"},
			AddProjectedChargeStages = 
			{
				NumStages = { BaseValue = 1 },
				ProjectedChanges =
				{
					NumProjectiles = 1,
					ManaCost = 3,
				},
				ReportValues = { ReportedProjectiles = "NumStages" }
			},
			HideStageReachedFxExceptForFinal = true ,
		},
		StatLines = 
		{
			"ExThrowStatDisplay1",
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponDaggerThrow" },
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					AdjustRateAcceleration = math.rad(10000),
					MaxAdjustRate = math.rad(2160),
					RequireTargetsHaveEffect = "ImpactSlow",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
				IncludeSigns = true,
			},
		},
		FlavorText = "DaggerHomingThrowAspect_FlavorText",
	},
	DaggerBlockAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_39",
		RequiredWeapon = "WeaponDagger",
		WeaponKitGrannyModel = "WeaponDaggerMultiple_Artemis_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Artemis_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Artemis_Mesh"
			},
		PriorityDisplay = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2.0
			},
			Heroic =
			{
				Multiplier = 2.5
			},
			Legendary =
			{
				Multiplier = 3.0
			},
			Perfect =
			{
				Multiplier = 3.5,
			},
		},
		PriorityDisplay = true,
		AddOutgoingCritModifiers =
		{
			ValidVolleyChance = 0.5,
			ReportValues = { ReportedChance = "ValidVolleyChance"},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "DaggerBlockSetup",
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveCritVolley",
		},
		OnWeaponChargeFunctions = 
		{
			ValidWeapons = {"WeaponDagger5"},
			FunctionName = "CheckDaggerBlock",
			FunctionArgs = 
			{
				Cooldown = 15,
				CritCount = 9,
				InvulnerableEffectName = "DaggerBlockInvincibubble",
				InvulnerableDuration = 1,
				Vfx = "EurydiceDefenseFront",
				ActivatedVfx = "DaggerBlockActiveFx",
				ReportValues = 
				{ 
					ReportedCooldown = "Cooldown",
					ReportedHits = "CritCount",
					ReportedDuration = "InvulnerableDuration",
					ReportedSpeedIncrease = "ExAttackSpeed",
				},
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FunctionName = "CheckDaggerCritCharges",
		},
		WeaponSpeedMultiplier = 
		{
		
			WeaponNames = {"WeaponDagger5"},
			Value = 
			{
				BaseValue = 0.80,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = {"WeaponDagger5"},
				BaseValue = 0.80,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		StatLines = 
		{
			"EXAttackSpeedStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta"
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHits",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "InvulnerableDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChance",
				ExtractAs = "CritChance",
				SkipAutoExtract = true,
				Format = "Percent",
			},
		},
		FlavorText = "DaggerBlockAspect_FlavorText",
	},
	LobAmmoBoostAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 5,
			},
		},
		Icon = "Hammer_Lob_13",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Mesh"
		},
	
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = {"WeaponLob"},
			ExcludeLinked = true,
			MissingAmmoBaseDamageAddition = { BaseValue = 5 },
			ReportValues = { ReportedWeaponMultiplier = "MissingAmmoBaseDamageAddition"},
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveWeaponAmmoFire",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			FunctionName = "CheckWeaponAmmoFire",
		},
		StatLines =
		{
			"AmmoDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				IncludeSigns = true
			},
		},
		FlavorText = "LobAmmoBoostAspect_FlavorText",
	},
	LobCloseAttackAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Lob_14",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Medea_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Medea_Mesh"
		},
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3,
			},
			Perfect =
			{
				Multiplier = 3.5,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponLobSpecial"},
			FunctionName = "CheckLobDetonate",
			FirstHitOnly = true,
			Args = 
			{
			}
		},
		AddOutgoingDamageModifiers =
		{
			NonExMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ReportValues = { ReportedWeaponMultiplier = "NonExMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponLob",
				WeaponProperties = 
				{
					ShowFreeAimLine = false,
					BarrelLength = 50,
					SelfVelocity = 0,
					ProjectileToArm = "ProjectileLob",
				},
				ProjectileName = "ProjectileLob",
				ProjectileProperties = 
				{
					Fuse = 3.0,
					LaunchAngle = 0,
					Range = 0,
					DamageRadius = 550,
					Gravity = 1500,
					SpinRate = 0,
					Type = "STRAIGHT",
					AttachToOwner = false,
					CheckObstacleImpact = false,
					AttachToMarker = "Melinoe_Rig:hand_00_R_JNT",
					IgnoreCancelAttachedProjectiles = true,
					RotateWithOwner = true,
					CheckUnitImpact = false,
					CheckObstacleImpact = false,
					DetonateWhenArmed = true,
					ReportValues = { ReportedFuse = "Fuse"},

				},
			},
		},
		StatLines =
		{
			"NonExDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		},
		FlavorText = "LobCloseAttackAspect_FlavorText",
	},
	LobSpecialAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		PreEquipWeapons = {"WeaponSkullImpulse"},
		Icon = "Hammer_Torch_01",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Persephone_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Persephone_Mesh"
		},
	},
	LobImpulseAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		PreEquipWeapons = {"WeaponSkullImpulse"},
		Icon = "Hammer_Lob_15",
		RequiredWeapon = "WeaponLob",
		WeaponKitGrannyModel = "WeaponLob_Persephone_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Persephone_Mesh"
		},
		Charge = 0,

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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3
			},
			Perfect =
			{
				Multiplier = 4,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ExMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ExMultiplier"},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSkullImpulseUI",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponLobSpecial", "WeaponSkullImpulse"},
			FunctionName = "SkullImpulseTransform",
			FunctionArgs = 
			{
				BaseDuration = 0.5,			-- Duration of ex attack w/ no charge
				Interval = 0.2,			-- Pulse rate of EX. 0.1 is default
			}
		},
		StatLines = 
		{
			"ExDamageStatDisplay1",
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = { "WeaponCast" },
			FunctionName = "ChargeSkullImpulse",
			Args = 
			{
				-- One "charge" is equal to full one second of skull car
				-- 0.001 means 100 damage = 0.1 seconds of skull car charge
				ChargePerDamage = 0.00125,
				MaxCharge = 2,
				MinChargeToFire = 0.5,
				ReportValues = 
				{
					ReportedMinChargeToFire = "MinChargeToFire",
					ReportedMaxCharge = "MaxCharge",
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
				Key = "ReportedMaxCharge",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "MinChargeToFire",
				ExtractAs = "MinCharge",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "LobImpulseAspect_FlavorText",
	},
	TorchSpecialDurationAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1.0,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2.0,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 3.0,
			},
		},
		Icon = "Hammer_Torch_39",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponHecateMultiple_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Mesh"
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "ArcEnd",
				BaseValue = math.rad(-220),
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = { ReportedIncrease = "ChangeValue"}
			},
		},
		StatLines =
		{
			"SpecialDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrease",
				Format = "ArcDuration",
				BaseName = "ProjectileTorchOrbit",
				ExtractAs = "DurationBonus",
				IncludeSigns = true,
				DecimalPlaces = 2,
			},
		},
		FlavorText = "TorchSpecialDurationAspect_FlavorText",
	},
	TorchSprintRecallAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 2,
			},
			Epic =
			{
				Multiplier = 3,
			},
			Heroic =
			{
				Multiplier = 4,
			},
			Legendary =
			{
				Multiplier = 5,
			},
			Perfect =
			{
				Multiplier = 6,
			},
		},
		Icon = "Hammer_Torch_41",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Eos_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Eos_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Eos_Mesh"
		},
		WeaponDataOverride =
		{
			WeaponTorch = 
			{	
				HideChargeDuration = 1.5,
				BlockChargeStageModifiers = 
				{
					NumProjectileWaves = true,
				},
				ChargeWeaponStages = 
				{
					{ 
						Wait = 2.5, 
						ManaCost = 10, 
						WeaponProperties = 
						{ 
							Projectile = "ProjectileTorchBallLarge",
						}, 
						ForceRelease = true,
					},
				},
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FunctionName = "HandleAttachRecord",
			FunctionArgs = 
			{
				Repeats = 5,
				StartInterval = 0.5,
				Interval = 2,
				ReportValues = 
				{ 
					ReportedFuse = "Interval" 
				},
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveAttachedExProjectiles",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "ProjectileTorchRepeatStrike" },
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 25,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperties = 
				{
					MultiDetonate = true,
					TotalFuse = 1000,
					Speed = 200,
					Acceleration = -10,
					DamageRadius = 200,
					BlastSpeed = 500,
					SpinFromOwnerVelocityMultiplier = 0,
					MaxAdjustRate = math.rad(50),
					MultipleObstacleCollisions = false,
				}
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchProjectileLargeIn_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadow_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchProjectileShadowLarge_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBall",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorch",
				ProjectileName = "ProjectileTorchBallLarge",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchProjectileDissipate_Aphrodite",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
		},
		StatLines =
		{
			"PulsePowerStatDisplay1",
		},
		ReportedMaxPulses = 1,
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "Damage",
				Format = "AddToBase",
				BaseType = "Projectile",
				BaseName = "ProjectileTorchRepeatStrike",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		},
		FlavorText = "TorchSprintRecallAspect_FlavorText",
	},
	TorchSingleStrikeAspect = 
	{
	
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 0.5,
			},
			Epic =
			{
				Multiplier = 1,
			},
			Heroic =
			{
				Multiplier = 1.5,
			},
			Legendary =
			{
				Multiplier = 2,
			},
			Perfect =
			{
				Multiplier = 2.5,
			},
		},
		Icon = "Hammer_Torch_40",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Supay_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Supay_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Supay_Mesh"
			},
		ChargeStageModifiers = 
		{
			ValidWeapons = {"WeaponTorch"},
			AddWeaponProperties = 
			{
				RefreshProjectileOnFire = false,
			},
		},
		WeaponDataOverride =
		{
			WeaponTorchSpecial = 
			{
				ChargeWeaponStages = 
				{
					{ ManaCost = 6, WeaponProperties = { NumProjectiles = 2}, Wait = 0.32, HideStageReachedFx = true, ChannelSlowEventOnEnter = true, ForceRelease = false },
					{ ManaCost = 9, WeaponProperties = { NumProjectiles = 3, ProjectileAngleOffset = math.rad(120)}, Wait = 0.2, HideStageReachedFx = true, },
					{ ManaCost = 12, WeaponProperties = { NumProjectiles = 4, ProjectileAngleOffset = math.rad(90)}, Wait = 0.2, HideStageReachedFx = true, },
					{ ManaCost = 15, WeaponProperties = { NumProjectiles = 5, ProjectileAngleOffset = math.rad(72)}, Wait = 0.2, },
				},
			}
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				WeaponProperties = 
				{
					RefreshProjectileOnFire = true,
					BarrelLength = 80,
				},
				ProjectileProperties = 
				{
					SpawnOnDetonate = "null",
					--Speed = 400,
					--Acceleration = 0,
					MaxAdjustRate = math.rad(560),
					AdjustRateAcceleration = math.rad(-60),
					ImpactVelocity = 0,
					AllowRepeatedJumpHit = true,
					--AllowRepeatedJumpHit = false,
					ResetCollisionOutsideImpact = true,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperties = 
				{
					Projectile = "ProjectileTorchOrbit",
					NumProjectiles = 1,
					FireGraphic = "Melinoe_Torch_Special1Ex_Fire",
				},
				ProjectileProperties = 
				{
					UnlimitedUnitPenetration = false,
				}
			}
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckTorchRepeatStrike",
			Args = 
			{
				ProjectileTorchBall = "ProjectileTorchRepeatStrike",
				ProjectileTorchBallLarge = "ProjectileTorchRepeatStrikeLarge"
			}
		},
	},
	TorchDetonateAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.15,
			},
			Epic =
			{
				Multiplier = 1.30,
			},
			Heroic =
			{
				Multiplier = 1.45,
			},
			Legendary =
			{
				Multiplier = 1.60,
			},
			Perfect =
			{
				Multiplier = 1.75,
			},
		},
		Icon = "Hammer_Torch_40",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Moros_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Moros_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Moros_Mesh"
		},
		StatLines = 
		{
			"DetonateDamageStatDisplay1",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = 
			{
				"ProjectileTorchExplosion",
				"ProjectileTorchExplosionLarge",
			},
			ValidWeaponMultiplier = {BaseValue = 1 },
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				ProjectileProperties = 
				{
					TotalFuse = 6,
					CheckProjectileImpact = true,
				},
				ExcludeLinked = true,
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckTorchDetonation",
			Args = 
			{
				ProjectileTorchBall = "ProjectileTorchExplosion",
				ProjectileTorchBallLarge = "ProjectileTorchExplosionLarge"
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipExplosionDamage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "TorchDetonateAspect_FlavorText",
	},
	AxeRecoveryAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.25,
			},
			Heroic =
			{
				Multiplier = 1.5,
			},
			Legendary =
			{
				Multiplier = 1.75,
			},
			Perfect =
			{
				Multiplier = 2,
			},
		},
		Icon = "Hammer_Axe_40",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Mesh1",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Mesh1"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			NonExBaseDamageAddition = { BaseValue = 20 },
			ReportValues = 
			{ 
				ReportedDamage = "NonExBaseDamageAddition"
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 20,
				ChangeType = "Add",
			},
		},
		StatLines =
		{
			"AxeDamageHealthStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				IncludeSigns = true,
			},
		},
		FlavorText = "AxeRecoveryAspect_FlavorText",
	},
	AxeArmCastAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Axe_41",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Charon_Mesh",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Charon_Mesh"
		},
		CastFlatFuseModifier = true,
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3,
			},
			Perfect = 
			{
				Multiplier = 3.5
			}
		},
		WeaponDataOverride =
		{
			WeaponCast =
			{
				OnFiredFunctionArgs = 
				{
					ProjectileDataPropertiesMap = { TotalFuse = "FuseStart" },
				},
			}
		},
		AddOutgoingDamageModifiers =
		{
			ValidProjectileIdMultiplier =
			{
				BaseValue = 1.1,
				SourceIsMultiplier = true,
			},
			
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidProjectileIdMultiplier" 
			},
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "ProjectileAxeBlock2" },
			Name = "CheckAxeCastArm",
			Args = 
			{
				ProjectileName = "ProjectileAxeBlock2",
				BlastMultiplier = {BaseValue = 1.15, SourceIsMultiplier = true },
			}
		},
		PropertyChanges =
		{
			{
				TraitName = "DemeterCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "FuseStart",
				ChangeValue = 0,
				ChangeType = "Absolute",
			},
			{
				TraitName = "DemeterCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "MaxDetonations",
				ChangeValue = 6,
				ChangeType = "Add",
			},
			{
				TraitName = "HephaestusCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "FuseStart",
				ChangeValue = 0,
				ChangeType = "Absolute",
			},
			{
				TraitName = "HephaestusCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "Fuse",
				ChangeValue = 1,
				ChangeType = "Add",
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "FuseStart",
				ChangeValue = 3,
				ChangeType = "Add",
				ReportValues = { DurationIncrease = "ChangeValue"},
			},
			{
				TraitName = "DemeterCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "Graphic",
				ChangeValue = "CastCircleInDemeterLong",
			},
			{
				TraitName = "HestiaCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "Graphic",
				ChangeValue = "CastCircleInHestiaLong",
			},
			{
				TraitName = "AphroditeCastBoon",
				WeaponName = "WeaponCast",
				ProjectileProperty = "Graphic",
				ChangeValue = "CastCircleInAphroditeLong",
			},
		},
		StatLines = 
		{
			"AxeArmStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
			{
				Key = "DurationIncrease",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "AxeArmCastAspect_FlavorText",
	},
	AxePerfectCriticalAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
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
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 3.5,
			},
		},
		Icon = "Hammer_Axe_42",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Thanatos_Mesh",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Thanatos_Mesh"
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			IsEx = true,
			HeroTraitValue = "PerfectCritChance",
		},
		PerfectCritChance = 0,
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupPerfectCritUI",
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckPerfectAxeCrit",
			FirstHitOnly = true,
			Args = 
			{
				Increment = 0.01,
				MaxCrit = 0.13,
				ReportValues = 
				{
					ReportedIncrement = "Increment",
					ReportedMaxCrit = "MaxCrit",
				}
			}
		},
		OnSelfDamagedFunction = 
		{
			Name = "ResetPerfectAxeCrit",
		},
		PropertyChanges = 
		{
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1SelfSlowFire",
				EffectProperty = "Duration",
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ExcludeLinked = true,
				DeriveSource = "DeriveSource",
				ReportValues = 
				{
					ReportedSpeed = "ChangeValue"
				},
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe",
				EffectName = "Swing1MoveDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeDash",
				EffectName = "SwingDashDisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe2",
				EffectName = "Swing2DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				EffectName = "Swing3Disable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxe3",
				EffectName = "Swing3DisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
		},
		StatLines = 
		{
			"AttackSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrement",
				ExtractAs = "TooltipIncrement",
				Format = "Percent",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
			{
				Key = "ReportedMaxCrit",
				ExtractAs = "TooltipMax",
				Format = "Percent",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedSpeed",
				ExtractAs = "TooltipSpeedIncrease",
				Format = "NegativePercentDelta",
			},
		},
		FlavorText = "AxePerfectCriticalAspect_FlavorText",
	}
}

OverwriteTableKeys( TraitData, TraitSetData.Aspects )