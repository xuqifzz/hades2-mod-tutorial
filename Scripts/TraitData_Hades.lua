OverwriteTableKeys( TraitData, {
	-- Hades
	HadesLifestealBoon = 
	{
		Icon = "Boon_Hades_05",
		HUDTextOverride = "LimitedLifesteal",
		InheritFrom = { "InPersonOlympianTrait" },
		RemainingUses = 1,
		BlockInRunRarify = true,
		AddOutgoingLifestealModifiers =
		{
			LimitedUse = 100,
			ValidMultiplier = 0.01,
			MinLifesteal = 1,
			ReportValues = 
			{ 
				ReportedLifeStealAmount = "ValidMultiplier",
				ReportedLimit = "LimitedUse"
			},
		},
		StatLines =
		{
			"LimitedLifeStealStatDisplay1",
		},
		TrayStatLines =
		{
			"CurrentLimitedLifeStealStatDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"LimitedLifeStealStatDisplay1",
				"HealingReductionNotice",
			},
			TrayStatLines =
			{
				"CurrentLimitedLifeStealStatDisplay1",
				"HealingReductionNotice",
			},
		},
		SetupFunction =
		{
			Name = "CacheCurrentLifestealUses",
		},
		ExtractValues =
		{
			{
				Key = "ReportedLifeStealAmount",
				ExtractAs = "Lifesteal",
				Format = "PercentHeal"
			},
			{
				Key = "ReportedLimit",
				ExtractAs = "StartingLimit",
			},
		},
	},
	
	HadesCastProjectileBoon =
	{
		Icon = "Boon_Hades_01",
		InheritFrom = { "InPersonOlympianTrait" },
		BlockInRunRarify = true,
		PreEquipWeapons = { "WeaponCastProjectileHades" },
		RequiredFalseTraits = { "CastProjectileBoon", "CastAnywhereBoon", "CastAttachBoon" },
		OverrideWeaponFireNames =
		{
			RangedWeapon = "nil",
			WeaponCastProjectileHades = "WeaponCast",
		},
		WeaponDataOverride = 
		{
			WeaponCast = 
			{
				UnarmedCastCompleteGraphic = "nil",
				Sounds = 
				{
					FireSounds = 
					{
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					}
				}
			}
		},
		SetupFunction =
		{
			Name = "SetupHadesCast",
			RunOnce = true,
		},

		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperties = 
				{
					IgnoreOwnerAttackDisabled = true,
					Cooldown = 0,
					ChargeTime = 0,
					SelfVelocity = 0,
					FireGraphic = "null",
					AllowMultiFireRequest = true,
					RootOwnerWhileFiring = false,
					ChargeStartAnimation = "null",
					SetCompleteAngleOnFire = true,
					IgnoreForceCooldown = true,
					AllowExternalForceRelease = false,
					AddOnFire = "null",
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperties = 
				{
					SpawnsInheritAttach = true,
				}
			},
			{
				WeaponName = "WeaponCastProjectileHades",
				ProjectileProperty = "Damage",
				BaseValue = 200,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamage = "ChangeValue" },
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow2",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastProjectileHades",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd",
				ChangeValue = "WeaponCastProjectileHades",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastProjectileHades",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnFire",
				ChangeValue = "WeaponCastProjectileHades",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnChargeCancel",
				ChangeValue = "WeaponCastProjectileHades",
			}
		},
		StatLines =
		{
			"HadesCastStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},
	HadesPreDamageBoon =
	{
		InheritFrom = { "InPersonOlympianTrait" },
		Icon = "Boon_Hades_06",
		BlockInRunRarify = true,
		EncounterPreDamage =
		{
			Delay = 3.0,
			VoiceLines = GlobalVoiceLines.HadesCurseVoiceLines,
			PresentationFunctionName = "HadesPreDamagePresentation",
			Text = "PreDamageHit_Hades",
			PreDamage = { BaseValue = 0.20 },
			EnemyType = "Boss",
			ReportValues = { ReportedDamage = "PreDamage" }
		},
		Uses = 1,
		StatLines =
		{
			"ChronosDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "Percent",
				HideSigns = true,
			},
		},
	},
	HadesChronosDebuffBoon = 
	{
		InheritFrom = { "InPersonOlympianTrait" },
		Icon = "Boon_Hades_02",
		BlockInRunRarify = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.1,
			},
			Epic =
			{
				Multiplier = 1.2,
			},
			Heroic =
			{
				Multiplier = 1.3,
			},
		},
		DebuffValue = {BaseValue = 0.5, SourceIsMultiplier = true },
		StatLines =
		{
			"ChronosDebuffStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "DebuffValue",
				ExtractAs = "ReportedDebuff",
				Format = "PercentDelta",
				HideSigns = true
			},
		},
	},
	HadesInvisibilityRetaliateBoon = 
	{
		InheritFrom = { "InPersonOlympianTrait" },
		Icon = "Boon_Hades_04",
		BlockInRunRarify = true,
		AddOutgoingDamageModifiers =
		{
			InvisibleVolleyMultiplier =
			{
				BaseValue = 2,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "InvisibleVolleyMultiplier"},
		},
		OnSelfDamagedFunction = 
		{
			Name = "HadesRetaliate",
			FunctionArgs = 
			{
				Cooldown = 40,
				EffectName = "HadesInvisible",
				Duration = 10,
				ReportValues = 
				{ 
					ReportedCooldown = "Cooldown",
					ReportedDuration = "Duration",
				},
			}
		},
		SetupFunction =
		{
			Name = "HadesInvisibilitySetup",
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveWeaponInvisibleFire",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = CombineAllValues({ WeaponSets.HeroNonPhysicalWeapons, WeaponSets.HeroAllWeapons }),	
			FunctionName = "CheckWeaponInvisibleFire",
		},
		StatLines =
		{
			"InvisibleDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "WeaponDamage",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
		},
	},
	HadesDeathDefianceDamageBoon = 
	{
		Icon = "Boon_Hades_03",
		InheritFrom = { "InPersonOlympianTrait" },
		BlockInRunRarify = true,
		AddOutgoingDamageModifiers =
		{
			MissingLastStandMultiplier =
			{
				BaseValue = 0.10,
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
			ReportValues = { ReportedWeaponMultiplier = "MissingLastStandMultiplier"},
		},
		StatLines =
		{
			"LastStandDamageStatDisplay",
		},
		TrayStatLines = 
		{
			"CurrentLastStandDamageStatDisplay"
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "DamageIncrease",
				Format = "Percent"
			},
			{
				Key = "ReportedWeaponMultiplier",
				MultiplyByMissingLastStands = true,
				ExtractAs = "CurrentDamageIncrease",
				Format = "Percent"
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Heal",
				Format = "Percent",
				ExtractAs = "LastStandHeal",
				SkipAutoExtract = true,
			},
		},
	},
})