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
			LimitedUse = 150,
			ValidMultiplier = 0.01,
			MinLifesteal = 1,
			Unmultiplied = true,
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
		SetupFunction =
		{
			Name = "CacheCurrentLifestealUses",
		},
		ExtractValues =
		{
			{
				Key = "ReportedLifeStealAmount",
				ExtractAs = "Lifesteal",
				Format = "Percent"
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
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "CastProjectileBoon", "CastAnywhereBoon", "CastLobBoon", "SelfCastBoon" },
			},
		},
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
			VoiceLines = { GlobalVoiceLines = "HadesCurseVoiceLines" },
			PresentationFunctionName = "HadesPreDamagePresentation",
			Text = "PreDamageHit_Hades",
			PreDamage = { BaseValue = 0.20 },
			ValidRooms = { "I_Boss01", "Q_Boss01", "Q_Boss02"},
			DamageSourceName = "HadesPreDamageBoon",
			ReportValues = { ReportedDamage = "PreDamage" }
		},
		SpeakerNames = { "Hades" },
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
			{
				Format = "FinalBoss",
				ExtractAs = "FinalBoss",
			}
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
				HideSigns = true,
			},
			{
				Format = "FinalBoss",
				ExtractAs = "FinalBoss",
			}
		},
	},
	HadesDashSweepBoon = 
	{
		InheritFrom = { "InPersonOlympianTrait" },
		Icon = "Boon_Hades_09",
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
		AddOutgoingDamageModifiers =
		{	
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			ValidActiveEffects = {"HadesSweepEffect"},
			NonExMultiplier = 1.30,
			ReportValues = {ReportedDamageMultiplier = "NonExMultiplier"},
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponBlink" },
			ExcludeLinked = true,
			FunctionName = "FireHadesSprintProjectile",
			FunctionArgs = 
			{
				ProjectileName = "SpearWeaponSpin",
				DamageMultiplier = 
				{ 
					BaseValue = 1,
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier" 
				},
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"SpearWeaponSpin"},
			EffectName = "HadesSweepEffect",
		},
		StatLines =
		{
			"SweepDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "SpearWeaponSpin",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "ReportedHadesMultiplier",
				Format = "PercentDelta",
				HideSigns = true,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ReportedHadesDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "HadesSweepEffect",
				BaseProperty = "Duration",
			},
		},
	},
	HadesInvisibilityRetaliateBoon = 
	{
		InheritFrom = { "InPersonOlympianTrait" },

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
		},
		Icon = "Boon_Hades_04",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HadesMeeting02", "HadesWithPersephone01" },
			},
		},
		CodexGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HadesMeeting02", "HadesWithPersephone01" },
			},
		},
		FirstTimeEntranceAnimation = "BoonEntranceLegendary",
		PriorityRequirements =
		{
			{
				PathFalse = { "GameState", "TraitsSeen", "HadesInvisibilityRetaliateBoon" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "HadesInvisibilityRetaliateBoon" },
			},
		},
		BlockInRunRarify = true,
		ShowInHUD = true,
		AddOutgoingDamageModifiers =
		{			
			RequiredSelfEffectsMultiplier =
			{
				BaseValue = 1.7,
				SourceIsMultiplier = true,
			},
			RequiredEffects = { "HadesInvisible" },
			ReportValues = { ReportedWeaponMultiplier = "RequiredSelfEffectsMultiplier"},
		},
		OnSelfDamagedFunction = 
		{
			Name = "HadesRetaliate",
			FunctionArgs = 
			{
				Cooldown = 40,
				EffectName = "HadesInvisible",
				Duration = 5,
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
		FlavorText = "HadesInvisibilityRetaliateBoon_FlavorText",
	},
	HadesDeathDefianceDamageBoon = 
	{
		Icon = "Boon_Hades_03",
		InheritFrom = { "InPersonOlympianTrait" },
		BlockInRunRarify = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "DeathDefianceDamageBoonEligible"}
			},
		},
		AddOutgoingDamageModifiers =
		{
			SpentLastStandMultiplier =
			{
				BaseValue = 0.10,
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
			ReportValues = { ReportedWeaponMultiplier = "SpentLastStandMultiplier"},
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
				MultiplyBySpentLastStands = true,
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
	HadesManaUrnBoon = 
	{	
		Icon = "Boon_Hades_07",
		BlockInRunRarify = true,
		InheritFrom = { "InPersonOlympianTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
		OnManaSpendAction = 
		{
			FunctionName = "CheckManaUrn",
			FunctionArgs = 
			{
				ManaCost = 60,
				EnemyName = "HadesTombstone",
				Count = 3,
				ReportValues = 
				{ 
					ReportedMana = "ManaCost",
				}
			}
		},
		TombstoneMultiplier = 
		{
			BaseValue = 1,
		},
		StatLines =
		{
			"UrnDamageStatDisplay",
		},
		ExtractValues =
		{
		
			{
				Key = "TombstoneMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "HadesUrnDeath",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedMana",
				ExtractAs = "Mana",
				SkipAutoExtract = true,
			},
		},
	},
})