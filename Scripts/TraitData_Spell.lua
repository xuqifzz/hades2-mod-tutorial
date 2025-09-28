OverwriteTableKeys( TraitData, {
	-- SorceryTraits
	
	SpellTrait =
	{
		Slot = "Spell",	
		ShowInHUD = true,
		DebugOnly = true,
		CheckChargeFunctionName = "SpellCheckCharges",
	},

	SpellTransformTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_34",
		PreEquipWeapons = { "WeaponSpellTransform", "WeaponTransformAttack", "WeaponTransformSpecial"  },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellTransform",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellTransform",
			},
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellTransform",
				ExtractAs = "ManaCost",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellTransform",
				BaseProperty = "Duration",
				ExtractAs = "Duration",
			},
			{
				External = true,
				BaseType = "Weapon",
				BaseName = "WeaponSpellTransform",
				BaseProperty = "ClipRegenInterval",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0206", Text = "{#Emph}Dark Side." },
				{ Cue = "/VO/Selene_0207", Text = "{#Emph}Dark Side.", PlayFirst = true },
				{ Cue = "/VO/Selene_0208", Text = "Your terrifying form.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},

	},

	SpellPolymorphTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_28",
		PreEquipWeapons = { "WeaponSpellPolymorph", },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckPolymorphCharge",
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				EffectName = "PolymorphTag",
				EffectProperty = "Duration",
				ChangeValue = 4.0,
				ReportValues = { ReportedDuration = "ChangeValue" },
				DeriveSource = "DeriveSource",
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				EffectName = "PolymorphDamageTaken",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource"
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellPolymorph",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellPolymorph",
			},
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellPolymorph",
				ExtractAs = "ManaCost",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileSpellPolymorph",
				BaseProperty = "NumJumps",
				Format = "TotalTargets",
				ExtractAs = "Bounces",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0184", Text = "{#Emph}Twilight Curse." },
				{ Cue = "/VO/Selene_0185", Text = "{#Emph}Twilight Curse.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0186", Text = "The Twilight Curse is yours to use.", BreakIfPlayed = true },
				{ Cue = "/VO/Selene_0187", Text = "Then let us turn our foes.", BreakIfPlayed = true },
				-- { Cue = "/VO/Selene_0127", Text = "{#Emph}Night Curse.", PlayFirst = true },
				-- { Cue = "/VO/Selene_0050", Text = "On this phase I see that the hex of Shadow Servant shall be yours.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},

	SpellLaserTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_29",
		PreEquipWeapons = {"WeaponSpellLaser",},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "Damage",
				ChangeValue = 40,
				ReportValues = { ReportedDamage = "ChangeValue" },
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellLaser",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellLaser",
			}
		},
		OnProjectileDeathFunction = 
		{
			Name = "ReenableLaserCharge",
		},
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellLaser",
				ExtractAs = "ManaCost",
			},
			{
				Key = "ReportedDamage",
				Format = "DamageOverTotalDuration",
				BaseName = "ProjectileSpellLaser",
				BaseProperty = "Fuse",
				DurationSource = "WeaponSpellLaser",
				DurationSourceKey = "MaxDuration",
				ExtractAs = "Damage",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellLaser",
				BaseProperty = "MaxDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "Weapon",
				BaseName = "WeaponSpellLaser",
				BaseProperty = "ClipRegenInterval",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			}
		},

		UpgradePickedVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0128", Text = "{#Emph}Lunar Ray.", PlayFirst = true },
				{ Cue = "/VO/Selene_0188", Text = "{#Emph}Lunar Ray." },
				{ Cue = "/VO/Selene_0189", Text = "{#Emph}Lunar Ray.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0048", Text = "On this phase I can see you may direct the Lunar Ray.", BreakIfPlayed = true },
				{ Cue = "/VO/Selene_0049", Text = "On this phase you may once again direct the Lunar Ray.", BreakIfPlayed = true },
				{ Cue = "/VO/Selene_0190", Text = "Then wield my light with grace.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},

	SpellMeteorTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_33",
		PreEquipWeapons = {"WeaponSpellMeteor",},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellMeteor",
				ProjectileProperty = "Damage",
				ChangeValue = 1000,
				ReportValues = { ReportedDamage = "ChangeValue" },
			},
			{
				WeaponName = "WeaponSpellMeteor",
				ProjectileProperty = "Fuse",
				ChangeValue = 4,
				ReportValues = { ReportedFuse = "ChangeValue" },
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellMeteor",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellMeteor",
			}
		},
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		OnProjectileDeathFunction = 
		{
			Name = "CheckMeteorCharge",
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellMeteor",
				ExtractAs = "ManaCost",
			},
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedFuse",
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "Weapon",
				BaseName = "WeaponSpellMeteor",
				BaseProperty = "ClipRegenInterval",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0203", Text = "{#Emph}Total Eclipse." },
				{ Cue = "/VO/Selene_0204", Text = "{#Emph}Total Eclipse.", PlayFirst = true },
				{ Cue = "/VO/Selene_0205", Text = "My greatest strength is yours.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},

	SpellSummonTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_32",
		PreEquipWeapons = { "WeaponSpellSummon", },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		CheckChargeFunctionName = "SpellSummonCheckCharges",
		OnEnemyDeathFunction = 
		{
			Name = "RecordSpellSummonEnemyDeath",
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellSummon",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellSummon",
			},
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellSummon",
				ExtractAs = "ManaCost",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellSummon",
				BaseProperty = "Duration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellSummon",
				BaseProperty = "MaxSummons",
				ExtractAs = "MaxSummons",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0191", Text = "{#Emph}Night Bloom." },
				{ Cue = "/VO/Selene_0192", Text = "{#Emph}Night Bloom.", PlayFirst = true },
				{ Cue = "/VO/Selene_0193", Text = "The dead shall rise.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},
	
	SpellTimeSlowTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_27",
		PreEquipWeapons = { "WeaponSpellTimeSlow" },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellTimeSlow",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellTimeSlow",
			},
		},
		ExtractValues = 
		{
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellTimeSlow",
				BaseProperty = "BaseDuration",
				ExtractAs = "Duration",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellTimeSlow",
				BaseProperty = "FiredFunctionArgs",
				FiredFunctionArg = "Modifier",
				Format = "NegativePercentDelta",
				ExtractAs = "SlowAmount",
			},
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellTimeSlow",
				ExtractAs = "ManaCost",
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0194", Text = "{#Emph}Phase Shift." },
				{ Cue = "/VO/Selene_0195", Text = "{#Emph}Phase Shift.", PlayFirst = true },
				{ Cue = "/VO/Selene_0196", Text = "Time can be controlled...", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},

	SpellPotionTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_31",
		PreEquipWeapons = { "WeaponSpellPotion" },
		FountainRefreshUses = true,
		RemainingUses = 3,
		MaxUses = 3,
		CheckChargeFunctionName = "SpellPotionCheckCharges",
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"ManaSpendCostStatDisplay1",
				"HealingReductionNotice",
			},
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellPotion",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellPotion",
			},
		},
		ExtractValues = 
		{
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellPotion",
				BaseProperty = "HealingAmount",
				ExtractAs = "HealingAmount",
				Format = "FlatHeal",
				SkipAutoExtract = true,
			},
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellPotion",
				ExtractAs = "ManaCost",
			},
			{
				Key = "MaxUses",
				ExtractAs = "Uses",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0197", Text = "{#Emph}Moon Water.", PlayFirst = true },
				{ Cue = "/VO/Selene_0198", Text = "{#Emph}Moon Water." },
				{ Cue = "/VO/Selene_0198_ALT", Text = "{#Emph}Moon Water." },
				{ Cue = "/VO/Selene_0199", Text = "Drink deep and persevere.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},

	SpellLeapTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_30",
		PreEquipWeapons = { "WeaponSpellLeap" },
		
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellLeap",
				ProjectileProperty = "Damage",
				ChangeValue = 200,
				ReportValues = { ReportedDamage = "ChangeValue" },
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellLeap",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellLeap",
			}
		},
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellLeap",
				ExtractAs = "ManaCost",
			},
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				SkipAutoExtract = true,
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", "SeleneAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0200", Text = "{#Emph}Wolf Howl.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0201", Text = "{#Emph}Wolf Howl." },
				{ Cue = "/VO/Selene_0202", Text = "Your foes shall shudder.", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "PickedMoonSpellVoiceLines" },
		},
	},
	
	SpellMoonBeamTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_110",
		PreEquipWeapons = { "WeaponSpellMoonBeam" },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
		},
		CodexGameStateRequirements =
		{
			NamedRequirements = { "SuitAspectsRevealed" },
		},
		PropertyChanges = 
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge3",
				ChangeValue = "WeaponSpellMoonBeam",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd3",
				ChangeValue = "WeaponSpellMoonBeam",
			},
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellMoonBeam",
				ExtractAs = "ManaCost",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseProperty = "FiredFunctionArgs",
				BaseName = "WeaponSpellMoonBeam",
				FiredFunctionArg = "Count",
				ExtractAs = "MoonBeamCount",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileMoonBeam",
				BaseProperty = "Damage",
				ExtractAs = "MoonBeamDamage",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Modifier",
				Format = "PercentDelta",
				ExtractAs = "MoonBeamVulnerability",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Duration",
				ExtractAs = "MoonBeamDuration",
				SkipAutoExtract = true,
			},
		},
	},

})