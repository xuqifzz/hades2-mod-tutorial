OverwriteTableKeys( TraitData, {
	-- SorceryTraits
	
	SpellTrait =
	{
		Slot = "Spell",	
		ShowInHUD = true,
		
		CheckChargeFunctionName = "SpellCheckCharges",
	},

	SpellTransformTrait = 
	{
		InheritFrom = { "SpellTrait" },
		Icon = "Boon_Selene_34",
		PreEquipWeapons = { "WeaponSpellTransform", "WeaponTransformAttack", "WeaponTransformSpecial", "WeaponTransformBlink"  },
		StatLines =
		{
			"ManaSpendCostStatDisplay1",
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0206", Text = "{#Emph}Dark Side." },
				{ Cue = "/VO/Selene_0207", Text = "{#Emph}Dark Side.", PlayFirst = true },
				{ Cue = "/VO/Selene_0208", Text = "Your terrifying form.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
			}
		},
		ExtractValues = 
		{
			{
				Format = "ManaSpendCost",
				WeaponName = "WeaponSpellPolymorph",
				ExtractAs = "ManaCost",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
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
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0184", Text = "{#Emph}Twilight Curse." },
				{ Cue = "/VO/Selene_0185", Text = "{#Emph}Twilight Curse.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0186", Text = "The Twilight Curse is yours to use." },
				{ Cue = "/VO/Selene_0187", Text = "Then let us turn our foes." },
				-- { Cue = "/VO/Selene_0127", Text = "{#Emph}Night Curse.", PlayFirst = true },
				-- { Cue = "/VO/Selene_0050", Text = "On this phase I see that the hex of Shadow Servant shall be yours.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
				ChangeValue = 30,
				ReportValues = { ReportedDamage = "ChangeValue" },
			},
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
			},
		},

		UpgradePickedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.66,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0128", Text = "{#Emph}Lunar Ray.", PlayFirst = true },
				{ Cue = "/VO/Selene_0188", Text = "{#Emph}Lunar Ray." },
				{ Cue = "/VO/Selene_0189", Text = "{#Emph}Lunar Ray.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0048", Text = "On this phase I can see you may direct the Lunar Ray.", BreakIfPlayed = true },
				{ Cue = "/VO/Selene_0049", Text = "On this phase you may once again direct the Lunar Ray.", BreakIfPlayed = true },
				{ Cue = "/VO/Selene_0190", Text = "Then wield my light with grace." },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0203", Text = "{#Emph}Total Eclipse." },
				{ Cue = "/VO/Selene_0204", Text = "{#Emph}Total Eclipse.", PlayFirst = true },
				{ Cue = "/VO/Selene_0205", Text = "My greatest strength is yours.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0191", Text = "{#Emph}Night Bloom." },
				{ Cue = "/VO/Selene_0192", Text = "{#Emph}Night Bloom.", PlayFirst = true },
				{ Cue = "/VO/Selene_0193", Text = "The dead shall rise.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0194", Text = "{#Emph}Phase Shift." },
				{ Cue = "/VO/Selene_0195", Text = "{#Emph}Phase Shift.", PlayFirst = true },
				{ Cue = "/VO/Selene_0196", Text = "Time can be controlled...", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
		ExtractValues = 
		{
			{
				External = true,
				BaseType = "WeaponData",
				BaseName = "WeaponSpellPotion",
				BaseProperty = "HealingAmount",
				ExtractAs = "HealingAmount",
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0197", Text = "{#Emph}Moon Water.", PlayFirst = true },
				{ Cue = "/VO/Selene_0198", Text = "{#Emph}Moon Water." },
				{ Cue = "/VO/Selene_0199", Text = "Drink deep and persevere.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Selene_0200", Text = "{#Emph}Wolf Howl.", PlayFirst = true, },
				{ Cue = "/VO/Selene_0201", Text = "{#Emph}Wolf Howl." },
				{ Cue = "/VO/Selene_0202", Text = "Your foes shall shudder.", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.PickedMoonSpellVoiceLines
		},
	},

})