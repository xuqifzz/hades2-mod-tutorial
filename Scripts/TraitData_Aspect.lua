TraitSetData.Aspects =
{
	BaseStaffAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_12",
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
		Icon = "Hammer_Staff_13",
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
				Multiplier = 1.17,
			},
			Epic =
			{
				Multiplier = 1.34,
			},
			Heroic =
			{
				Multiplier = 1.51,
			},
			Legendary =
			{
				Multiplier = 1.67,
			},
			Perfect =
			{
				Multiplier = 1.84,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupClearCastUI",
		},
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckClearCastCount",
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FirstHitOnly = true,
			Args = 
			{
				IsNotEx = true,
				RequiredCount = 21,
				EffectName = "ClearCast",
				DataProperties = 
				{
					Duration = { BaseValue = 6 },
					ReportValues = { ReportedDuration = "Duration"},
				},
				ReportValues = { ReportedCount = "RequiredCount"}
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
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "ExChargeMultiplier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				Format = "NegativePercentDelta",
				BaseName = "ClearCast",
				BaseProperty = "ExChargeMultiplier",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "StaffClearCastAspect_FlavorText",
	},
	StaffSelfHitAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Staff_14",
		RequiredWeapon = "WeaponStaffSwing",
		-- 'I have a good idea for a prank for this Asclepius character' ~Momus
		WeaponKitGrannyModel = "WeaponStaff_Asclepius_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Asclepius_Mesh"
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
		
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = 
			{ 
				BaseValue = 10,
			},
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidBaseDamageAddition" 
			},
		},
		StatLines =
		{
			"RawDamageStatDisplay1",
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckStaffSelfHit",
			ValidProjectiles = {"ProjectileStaffBallCharged"},
			Args = 
			{
				ProjectileName = "ProjectileStaffBallCharged",
				Threshold = 0.5,
				HealAmount = 5,
				ReportValues = 
				{ 
					ReportedThreshold = "Threshold" ,
					ReportedHeal = "HealAmount" 
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
				IncludeSigns = true,
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "HealthThreshold",
				Format = "Percent",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedHeal",
				ExtractAs = "HealAmount",
				SkipAutoExtract = true
			},
		},
		FlavorText = "StaffSelfHitAspect_FlavorText",
	},
	
	DaggerBackstabAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Daggers_12",
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
		Icon = "Hammer_Daggers_13",
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
					Type = "HOMING",
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
		Icon = "Hammer_Daggers_14",
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
		Icon = "Hammer_Torch_01",
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
		Icon = "Hammer_Torch_11",
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
		Icon = "Hammer_Torch_01",
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
			ValidWeapons = {"WeaponSkullImpulse"},
			FunctionName = "SkullImpulseTransform",
			FunctionArgs = 
			{
				Interval = 0.2,
			}
		},
		StatLines = 
		{
			"ExDamageStatDisplay1",
		},
		OnEnemyDamagedAction = 
		{
			AllEffectsTrigger = true,
			FunctionName = "ChargeSkullImpulse",
			Args = 
			{
				BlockedProjectile = "ProjectileThrowCharged",
				BlockedWeapon = "WeaponLobSpecial",
				-- One "charge" is equal to full one second of skull car
				-- 0.001 means 100 damage = 0.1 seconds of skull car charge
				ChargePerDamage = 0.0002,
				MaxCharge = 5,
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
		Icon = "Hammer_Torch_01",
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
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
			Legendary =
			{
				Multiplier = 2.00,
			},
			Perfect =
			{
				Multiplier = 2.25,
			},
		},
		Icon = "Hammer_Torch_08",
		RequiredWeapon = "WeaponTorch",
		WeaponKitGrannyModel = "WeaponTorchMultiple_Eos_Mesh",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Eos_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Eos_Mesh"
			},
		OnWeaponFiredFunctions = 
		{
			
			ValidWeapons = WeaponSets.HeroRushWeapons,
			FunctionName = "TorchSprintRecall",
		},
		StatLines = 
		{
			"MaximumDamageStatDisplay1",
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponTorch", },
				ProjectileProperties = 
				{
					ResetCollisionOutsideImpact = true,
					TotalFuse = 4,
					ReturnToOwnerSpeed = 1200,
					--Speed = 1000,
					--Acceleration = -450,
					MaxSize = 1.75,
					SizeDuration = 2.5,
					InheritOwnerVelocityMultiplier = 0,
					CheckObstacleImpact = false
				},
				ExcludeLinked = true,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponTorch" },
			LifetimeMultiplier = { BaseValue = 0.40 },
			ReportValues = 
			{ 
				LifetimeMultiplier = "LifetimeMultiplier" 
			},
			ExcludeLinked = true,
		},
		ExtractValues =
		{
			{
				Key = "LifetimeMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "Percent",
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
		Icon = "Hammer_Torch_08",
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
					Speed = 400,
					Acceleration = 0,
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
		Icon = "Hammer_Torch_08",
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
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 3,
			},
		},
		Icon = "Hammer_Axe_01",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Mesh1",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Mesh1"
		},
		PropertyChanges = 
		{
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
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinAttackDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinAttackDisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinMoveStop",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "AxeSpinSelfFireSlow",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinAttackDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinAttackDisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinMoveStop",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpin",
				EffectName = "IndependentAxeSpinSelfFireSlow",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				EffectName = "BigDisable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				EffectName = "BigDisableCancellable",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource",
				ExcludeLinked = true,
			},
		},
		StatLines =
		{
			"AxeRecoveryStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "Speed",
				Format = "NegativePercentDelta"
			},
		},
		FlavorText = "AxeRecoveryAspect_FlavorText",
	},
	AxeArmCastAspect = 
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		Icon = "Hammer_Axe_08",
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
				Multiplier = 2.0,
			},
			Epic =
			{
				Multiplier = 3.0,
			},
			Heroic =
			{
				Multiplier = 4.0,
			},
			Legendary =
			{
				Multiplier = 5.0,
			},
			Perfect =
			{
				Multiplier = 6.0,
			},
		},
		Icon = "Hammer_Axe_08",
		RequiredWeapon = "WeaponAxe",
		WeaponKitGrannyModel = "Melinoe_Axe_Thanatos_Mesh",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Thanatos_Mesh"
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
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
				MaxCrit = {BaseValue = 0.04},
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
		StatLines = 
		{
			"MaximumCritStatDisplay1",
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
			},
		},
		FlavorText = "AxePerfectCriticalAspect_FlavorText",
	}
}

OverwriteTableKeys( TraitData, TraitSetData.Aspects )