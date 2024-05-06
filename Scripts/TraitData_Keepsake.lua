
TraitSetData.Keepsakes =
{
	GiftTrait =
	{
		NoFrame = true,
		Slot = "Keepsake",
		ShowInHUD = true,
		HideInRunHistory = true,
		ActiveSlotOffsetIndex = 0,
		CustomRarityLevels =
		{
			"TraitLevel_Keepsake1",
			"TraitLevel_Keepsake2",
			"TraitLevel_Keepsake3",
			"TraitLevel_Keepsake4",
		},
		RecordCacheOnEquip = true,
		ChamberThresholds =  { 25, 50 },
		InfoBackingAnimation = "KeepsakeSlotBase",

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
		},
	},

	AssistTrait =
	{
		Frame = "Gift",
		Slot = "Assist",
		Icon = "Keepsake_Unknown",
		HideInRunHistory = true,
		ChamberThresholds =  { 25, 50 },

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
		},
	},

	BaseBoonUpgradeKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		DoesNotAutomaticallyExpire = true,
		RarityLevels = {
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 2,
			},
			Epic =
			{
				Multiplier = 3,
			},
		}
	},

	BlockDeathKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_06",
		InRackTitle = "BlockDeathKeepsake_Rack",
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
			}
		},
		EquipSound = "/SFX/Menu Sounds/KeepsakeSkellyTooth",
		BlockDeathTimer = 10,
		BlockDeathHealth = { BaseValue = 30, AsInt = true },
		ExtractValues =
		{
			{
				Key = "BlockDeathTimer",
				ExtractAs = "TooltipLastStandTimer",
				SkipAutoExtract = true,
			},
			{
				Key = "BlockDeathHealth",
				ExtractAs = "TooltipHealth",
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2650", Text = "The Pin." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Moros_01", SubtitleColor = Color.MorosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/MorosKeepsake_0083", Text = "Princess." },
				{ Cue = "/VO/MorosKeepsake_0084", Text = "Princess...!" },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffMoros",
		  },
		  --[[
		  {
			RequiredTextLines = { "HypnosGift08" },
			Text = "HypnosSignoff_Max"
		  }
		  ]]--
		},

	},
	
	ReincarnationKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_03",
		InRackTitle = "ReincarnationKeepsake_Rack",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 76/51,
			},
			Epic =
			{
				Multiplier = 101/51,
			},
			Heroic =
			{
				Multiplier = 126/51,
			}
		},
		EquipSound = "/SFX/Menu Sounds/KeepsakeSkellyTooth",
		KeepsakeLastStandHealAmount = { BaseValue = 51, AsInt = true },
		ExtractValues =
		{
			{
				Key = "KeepsakeLastStandHealAmount",
				ExtractAs = "TooltipLastStandHealth",
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3183", Text = "The Tooth." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Skelly_01", SubtitleColor = Color.SkellyVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/SkellyKeepsake_0109", Text = "Young one." },
				{ Cue = "/VO/SkellyKeepsake_0110", Text = "Kiddo." },
				{ Cue = "/VO/SkellyKeepsake_0111", Text = "Disciple.", PlayFirst = true },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffSkelly",
		  },
		  --[[
		  {
			RequiredTextLines = { "HypnosGift08" },
			Text = "HypnosSignoff_Max"
		  }
		  ]]--
		},

	},

	DoorHealReserveKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "DoorHealReserveKeepsake_Rack",
		ZeroBonusTrayText = "DoorHealReserveKeepsake_Expired",
		Icon = "Keepsake_04",
		-- OnExpireSound = "/Leftovers/SFX/AuraOff",
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
			}
		},
		DoorHealReserve = { BaseValue = 50 },
		ExtractValues =
		{
			{
				Key = "DoorHealReserve",
				ExtractAs = "TooltipDoorHeal",
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3182", Text = "The Onion." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffDora",
		  },
		},

	},
	DeathVengeanceKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "DeathVengeanceKeepsake_Rack",
		Icon = "Keepsake_05",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
			}
		},
		AddOutgoingDamageModifiers =
		{
			VengeanceMultiplier =
			{
				BaseValue = 1.20,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "VengeanceMultiplier"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2652", Text = "The Eye." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Nemesis_01", SubtitleColor = Color.NemesisVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/NemesisKeepsake_0291", Text = "Princess." },
				{ Cue = "/VO/NemesisKeepsake_0273", Text = "You..." },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffNemesis",
		  },
		},

	},
	LowHealthCritKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "LowHealthCritKeepsake_Rack",
		Icon = "Keepsake_10",
		EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
		PriorityDisplay = true,
		LowHealthThresholdText =
		{
			-- Display variable only, to change the data value change the value below under "LowHealthThreshold"
			Threshold = 30,
			Text = "Hint_LowHealthDamageTrait",
		},
		AddOutgoingCritModifiers =
		{
			LowHealthThreshold = 30,
			LowHealthChance = { BaseValue = 0.2 },
			ReportValues = { ReportedHealthThreshold = "LowHealthThreshold", ReportedCritBonus = "LowHealthChance"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedHealthThreshold",
				ExtractAs = "Health",
			},
			{
				Key = "ReportedCritBonus",
				ExtractAs = "Chance",
				Format = "Percent",
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2651", Text = "The Antler." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Artemis_Field_01", SubtitleColor = Color.ArtemisVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift02" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ArtemisKeepsake_0214", Text = "Hey Sister." },
				{ Cue = "/VO/ArtemisKeepsake_0215", Text = "Melinoë.", PlayFirst = true },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffArtemis",
		  },
		},
	},
	SpellTalentKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "SpellTalentKeepsake_Rack",
		Icon = "Keepsake_11",
		ZeroBonusTrayText = "SpellTalentKeepsake_Expired",

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		TalentPointCount = { BaseValue = 1 },
		AcquireFunctionName = "AddTalentPoints",
		AcquireFunctionArgs =
		{ 
			Count = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedCount = "Count",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			}
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3185", Text = "The Beam." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffSelene",
		  },
		},
	},
	BonusMoneyKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "BonusMoneyKeepsake_Rack",
		Icon = "Keepsake_08",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHypnosCoinPurse",

		UnequippedKeepsakeTitle = "BonusMoneyKeepsake_Rack",
		CustomTrayNameWhileDead = "BonusMoneyKeepsake",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		BonusMoney = { BaseValue = 100 },
		ExtractValues =
		{
			{
				Key = "BonusMoney",
				ExtractAs = "TooltipMoney",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3184", Text = "The Purse." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffCharon",
		  },
		  --[[
		  {
			RequiredTextLines = { "HypnosGift08" },
			Text = "CharonSignoff_Max"
		  }
		  ]]--
		},
	},
	BossPreDamageKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_02",
		InRackTitle = "BossPreDamageKeepsake_Rack",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 2.00,
			},
			Epic =
			{
				Multiplier = 3.00,
			},
			Heroic =
			{
				Multiplier = 4.00,
			}
		},
		EncounterPreDamage =
		{
			PreDamage = { BaseValue = 0.05 },
			EnemyType = "Boss",
			ReportValues = { ReportedDamage = "PreDamage" }
		},
		AddIncomingDamageModifiers =
		{
			BossDamageMultiplier = 0.85,
			ReportValues = { ReportedResistance = "BossDamageMultiplier" }
		},
		Uses = 1,
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "FlatPercent",
			},
			{
				Key = "ReportedResistance",
				ExtractAs = "Defense",
				Format = "FlatPercentDelta",
			},
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3181", Text = "The Bones." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Odysseus_01", SubtitleColor = Color.OdysseusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift02" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/OdysseusKeepsake_0110", Text = "Goddess." },
				{ Cue = "/VO/OdysseusKeepsake_0111", Text = "Goddess.", PlayFirst = true },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffOdysseus",
		  },
		},
	},
	ManaOverTimeRefundKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "ManaOverTimeRefundKeepsake_Rack",
		ZeroBonusTrayText = "ManaOverTimeRefundKeepsake_Expired",
		Icon = "Keepsake_01",
		-- OnExpireSound = "/Leftovers/SFX/AuraOff",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.50,
			},
			Epic =
			{
				Multiplier = 2.00,
			},
			Heroic =
			{
				Multiplier = 3,
			}
		},
		TotalManaRecovered = { BaseValue = 1000 },
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ManaOverTimeRefundKeepsake",
			},
			RunOnce = true
		},
		OnManaSpendAction = 
		{
			FunctionName = "CheckOverTimeManaRefund",
			FunctionArgs = 
			{
				Duration = 3,
				Interval = 0.5,
				ReportValues = 
				{ 
					ReportedDuration = "Duration",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "TotalManaRecovered",
				ExtractAs = "TooltipManaRecovery",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				DecimalPlaces = 1,
			},
		},

		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2649", Text = "The Silver Wheel.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3180", Text = "The Wheel." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Hecate_01", SubtitleColor = Color.HecateVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift02" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HecateKeepsake_0069", Text = "Melinoë." },
				-- { Cue = "/VO/HecateKeepsake_0692", Text = "Melinoë." },
				{ Cue = "/VO/HecateKeepsake_0693", Text = "Melinoë?" },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffHecate",
		  },
		},

	},

	BossMetaUpgradeKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
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
			}
		},
		InRackTitle = "BossMetaUpgradeKeepsake_Rack",
		Icon = "Keepsake_21",
		PostBossCardRarity = { BaseValue = 1 },
		RemainingUses = 1,
		ExtractValues =
		{
			{
				Key = "PostBossCardRarity",
				ExtractAs = "RarityLevel",
				Format = "CardRarity",
			},
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3202", Text = "The Figurine." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffCirce",
		  },
		},
	},
	FountainRarityKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "FountainRarityKeepsake_Rack",
		Icon = "Keepsake_23",
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
		},
		DoesNotAutomaticallyExpire = true,
		Uses = 1,
		FountainHealFractionBonus = 0.2,
		FountainRarity = 
		{
			NumTraits = 1,
			MaxRarity = 1,
			TargetRarity = {BaseValue = 2},
			ReportValues = 
			{ 
				ReportedCount = "NumTraits" ,
				ReportedRarity = "TargetRarity",
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCount",
				ExtractAs = "BoonCount"
			},
			{
				Key = "ReportedRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			},
			{
				Key = "FountainHealFractionBonus",
				Format = "PercentHeal",
				ExtractAs = "Heal"
			}
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3187", Text = "The Phial." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Narcissus_01", SubtitleColor = Color.NarcissusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NarcissusAboutReflection01", "NarcissusGift02" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/NarcissusKeepsake_0119", Text = "Hey Laurel.", PlayFirst = true },
				{ Cue = "/VO/NarcissusKeepsake_0120", Text = "Laurel!" },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
			{
				Text = "SignoffNarcissus",
			},
		},

	},
	ArmorGainKeepsake = 
	{
		InheritFrom = { "GiftTrait", "CostumeTrait" },
		InRackTitle = "ArmorGainKeepsake_Rack",
		Icon = "Keepsake_22",
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
			}
		},
		Invincible = true,
		DoorArmor = { BaseValue = 2 },
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Keepsake",
				Delay = 0.75,
				BaseAmount = 20,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},

		ExtractValues = 
		{
			{
				Key = "DoorArmor",
				ExtractAs = "PlayerArmor"
			},
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "ReportedArmor",
				ExtractAs = "BaseArmor"
			}
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3186", Text = "The Sash." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},

		SignOffData =
		{
		  {
			Text = "SignoffArachne",
		  },
		},
	},
	TempHammerKeepsake = 
	{
		InheritFrom = {"GiftTrait"},
		InRackTitle = "TempHammerKeepsake_Rack",
		Icon = "Keepsake_25",
		
		AcquireFunctionName = "GiveDurationHammer",
		AcquireFunctionArgs =
		{ 
			Duration = { BaseValue = 10 },
			ReportValues = 
			{ 
				ReportedDuration = "Duration",
			}
		},
		DelayedRunStartPresentation = 
		{
			FunctionName = "RunStartHammerKeepsakeAcquiredPresentation",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
			},
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3203", Text = "The Hammer." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffIcarus",
		  },
		},
	},
	-- no longer in use
	ArmorConversionKeepsake = 
	{
		InheritFrom = { "GiftTrait", "CostumeTrait" },
		InRackTitle = "ArmorConversionKeepsake_Rack",
		Icon = "Keepsake_21",
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
			}
		},
		Invincible = true,
		BossConvertArmor = true,
		Uses = 1,
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Keepsake",
				BaseAmount = 40,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},

		ExtractValues = 
		{
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "GrantedHealth",
				ExtractAs = "HealthBonus",
			},
			{
				Key = "ReportedArmor",
				ExtractAs = "BaseArmor"
			}
		},
		SignOffData =
		{
		  {
			Text = "SignoffHephaestus",
		  },
		},
	},
	DecayingBoostKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_19",
		InRackTitle = "DecayingBoostKeepsake_Rack",
		CustomTrayNameWhileDead = "DecayingBoostKeepsake",
		CustomTrayText = "DecayingBoostKeepsake_Tray",
		ZeroBonusTrayText = "DecayingBoostKeepsake_Expired",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0.3,
			},
			Rare =
			{
				Multiplier = 0.4,
			},
			Epic =
			{
				Multiplier = 0.5,
			},
			Heroic =
			{
				Multiplier = 0.6,
			}
		},
		AddOutgoingDamageModifiers =
		{
			UseTraitValue = "CurrentKeepsakeDamageBonus",
		},
		InitialKeepsakeDamageBonus = { BaseValue = 2, SourceIsMultiplier = true },
		CurrentKeepsakeDamageBonus = 1,
		DecayRate = 0.05,

		ExtractValues = 
		{
			{
				Key = "InitialKeepsakeDamageBonus",
				ExtractAs = "StartingBonus",
				Format = "PercentDelta",
			},
			{
				Key = "CurrentKeepsakeDamageBonus",
				ExtractAs = "CurrentBonus",
				Format = "PercentDelta",
			},
			{
				Key = "DecayRate",
				ExtractAs = "DecayRate",
				Format = "Percent",
			}
		},

		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3199", Text = "The Fang." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
			{
				Text = "SignoffHeracles",
			},
		},
	},
	DamagedDamageBoostKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_20",
		-- EquipSound = "",
		InRackTitle = "DamagedDamageBoostKeepsake_Rack",
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
			}
		},

		AddOutgoingDamageModifiers =
		{
			ExRunDamagedThreshold = 250,
			ExRunDamagedMultiplier = { BaseValue = 1.20, SourceIsMultiplier = true },
			
			ReportValues = 
			{
				ReportedMultiplier = "ExRunDamagedMultiplier",
				ReportedThreshold = "ExRunDamagedThreshold"
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "Threshold",
			},
			{
				Format = "TotalDamageTaken",
				ExtractAs = "CurrentHeroDamage",
			},
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3198", Text = "The Fleece." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
			{
				Text = "SignoffMedea",
			},
		},
	},
	EscalatingKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
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
			}
		},
		Icon = "Keepsake_07",
		-- EquipSound = "",
		InRackTitle = "EscalatingKeepsake_Rack",
		CustomTrayNameWhileDead = "EscalatingKeepsake",
		CustomTrayText = "EscalatingKeepsake_Tray",

		AddOutgoingDamageModifiers =
		{
			UseTraitValue = "EscalatingKeepsakeValue",
			IsMultiplier = true,
		},
		AddIncomingDamageModifiers = 
		{
		
			UseTraitValue = "EscalatingKeepsakeValue",
			IsMultiplier = true,
		},
		EscalatingKeepsakeGrowthPerRoom = { BaseValue = 0.005, DecimalPlaces = 3 },
		EscalatingKeepsakeValue = 1.0,

		ExtractValues = 
		{
			{
				Key = "EscalatingKeepsakeGrowthPerRoom",
				ExtractAs = "IncreasePerRoom",
				Format = "Percent",
				DecimalPlaces = 1,
			},
			{
				SkipAutoExtract = true,
				Key = "EscalatingKeepsakeValue",
				ExtractAs = "CurrentBonus",
				Format = "PercentDelta",
				DecimalPlaces = 1,
			},
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3200", Text = "The Bell." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
			{
				Text = "SignoffEris",
			},
		},
	},
	TimedBuffKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_09",
		InRackTitle = "TimedBuffKeepsake_Rack",
		ZeroBonusTrayText = "TimedBuffKeepsake_Expired",
		FromLootOnUpdate = true,

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
			}
		},

		StartingTime = { BaseValue = 200 },
		AcquireFunctionName = "StartHermesKeepsakeTimer",

		SetupFunction =
		{
			Name = "TimedBuffSetup",
			Args =
			{
				Multiplier = 0.8,
				ReportValues = { ReportedWeaponMultiplier = "Multiplier" }
			},
			RunOnce = true
		},
		ExtractValues =
		{
			{
				Key = "StartingTime",
				ExtractAs = "Duration",
			},
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Speed",
				Format = "NegativePercentDelta"
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_3201", Text = "The Droplet." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Hermes_01", SubtitleColor = Color.HermesVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HermesKeepsake_0156", Text = "Hey M!", PlayFirst = true },
				{ Cue = "/VO/HermesKeepsake_0157", Text = "Let's go, M." },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffHermes",
		  },
		},
	},
	-- no longer in use
	SpeedRunBossKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_13",
		-- EquipSound = "/SFX/Menu Sounds/KeepsakeZeusRing",
		InRackTitle = "SpeedRunBossKeepsake_Rack",
		Timers =
		{
			F = 300,
			G = 300,
			H = 300,
			I = 300,

			N = 300,
			O = 300,
			P = 300,
			Q = 300,
		},
		BossSpeedTriggerEffect = 
		{
			EffectName = "FastClearBuff",
			DataProperties = 
			{
				DodgeChance = { BaseValue = 0.1 },
				ReportValues = 
				{ 
					ReportedDodgeChance = "DodgeChance",
				}
			},
			AttackSpeedMultiplier = { BaseValue = 0.9, SourceIsMultiplier = true },
			ReportValues = 
			{ 
				ReportedSpeed = "AttackSpeedMultiplier",
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "Speed",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "Dodge",
				Format = "Percent",
			}
		},
	},

	UnpickedBoonKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "UnpickedBoonKeepsake_Rack",
		Icon = "Keepsake_24",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHypnosCoinPurse",
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
			}
		},
		DoubleBoonChance = {
			BaseValue = 0.25,
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "DoubleBoonChance",
				ExtractAs = "Chance",
				Format = "Percent",
			},
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3189", Text = "The Stone." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffEcho",
		  },
		},
	},

	RandomBlessingKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "RandomBlessingKeepsake_Rack",
		Icon = "Keepsake_26",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHypnosCoinPurse",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
			}
		},
		AcquireFunctionName = "ChaosBlessingBonus",
		AcquireFunctionArgs = 
		{
			BlessingRarity = { BaseValue = 1 },
			ReportValues = { BlessingRarityBonus = "BlessingRarity" }
		},
		DelayedRunStartPresentation = 
		{
			FunctionName = "RunStartChaosBlessingPresentation",
		},
		RoomsPerUpgrade = 
		{ 
			Amount = 8,
			TransformBlessing = true,
			ReportValues = 
			{ 
				ReportedRoomsPerUpgrade = "Amount" 
			},
		},
		CurrentRoom = 0,
		ExtractValues =
		{
			{
				Key = "BlessingRarityBonus",
				ExtractAs = "RarityValue",
				Format = "Rarity",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedRoomsPerUpgrade",
				ExtractAs = "TooltipRoomInterval",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3188", Text = "The Embryo." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ChaosKeepsake_0280", Text = "Spawn of Hades." },
				{ Cue = "/VO/ChaosKeepsake_0281", Text = "Spawn of Hades?" },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffChaos",
		  },
		},
	},
	ForceHephaestusBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_17",
		EquipSound = "/SFX/Menu Sounds/KeepsakeZeusRing",
		InRackTitle = "ForceHephaestusBoonKeepsake_Rack",
		ForceBoonName = "HephaestusUpgrade",
		RarityUpgradeData = 
		{
			LootName = "HephaestusUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3196", Text = "The Shard." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffHephaestus",
		  },
		},
	},
	ForceZeusBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_12",
		EquipSound = "/SFX/Menu Sounds/KeepsakeZeusRing",
		InRackTitle = "ForceZeusBoonKeepsake_Rack",
		ForceBoonName = "ZeusUpgrade",
		RarityUpgradeData = 
		{
			LootName = "ZeusUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3190", Text = "The Bangle." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ZeusKeepsake_0184", Text = "Young lady." },
				{ Cue = "/VO/ZeusKeepsake_0185", Text = "Melinoë." },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffZeus",
		  },
		},
	},

	ForceDemeterBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_14",
		EquipSound = "/SFX/Menu Sounds/KeepsakeDemeterHorn",
		InRackTitle = "ForceDemeterBoonKeepsake_Rack",
		ForceBoonName = "DemeterUpgrade",
		RarityUpgradeData = 
		{
			LootName = "DemeterUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3194", Text = "The Sheaf." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/DemeterKeepsake_0153", Text = "Granddaughter." },
				{ Cue = "/VO/DemeterKeepsake_0155", Text = "Melinoë." },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
			{
				Text = "SignoffDemeter",
			},
		},
	},
	ForceAphroditeBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_16",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAphroditeRose",
		InRackTitle = "ForceAphroditeBoonKeepsake_Rack",
		ForceBoonName = "AphroditeUpgrade",
		RarityUpgradeData = 
		{
			LootName = "AphroditeUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3195", Text = "The Mirror." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffAphrodite",
		  },
		},
	},
	ForcePoseidonBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_14",
		EquipSound = "/SFX/Menu Sounds/KeepsakePoseidonShell",
		InRackTitle = "ForcePoseidonBoonKeepsake_Rack",
		ForceBoonName = "PoseidonUpgrade",
		RarityUpgradeData = 
		{
			LootName = "PoseidonUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3192", Text = "The Sea." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffPoseidon",
		  },
		},
	},

	ForceApolloBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_15",
		EquipSound = "/SFX/Menu Sounds/KeepsakeDionysusCup",
		InRackTitle = "ForceApolloBoonKeepsake_Rack",
		ForceBoonName = "ApolloUpgrade",
		RarityUpgradeData = 
		{
			LootName = "ApolloUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3193", Text = "The Hope." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffApollo",
		  },
		},
	},

	ForceHestiaBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_18",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAthenaOwl",
		InRackTitle = "ForceHestiaBoonKeepsake_Rack",
		ForceBoonName = "HestiaUpgrade",
		RarityUpgradeData = 
		{
			LootName = "HestiaUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3197", Text = "The Ember." },
			},
			[2] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffHestia",
		  },
		},
	},
	ForceHeraBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_13",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAthenaOwl",
		InRackTitle = "ForceHeraBoonKeepsake_Rack",
		ForceBoonName = "HeraUpgrade",
		RarityUpgradeData = 
		{
			LootName = "HeraUpgrade",
			Uses = 1,
			MaxRarity = { BaseValue = 1 },
			ReportValues = 
			{ 
				ReportedMaxRarity = "MaxRarity",
				ReportedUpgrades = "Uses",
			},
		},
		Uses = 1,
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
			},
			{
				Key = "ReportedMaxRarity",
				ExtractAs = "RarityLevel",
				Format = "Rarity",
			}
		},
		EquipVoiceLines =
		{
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_3191", Text = "The Fan." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				ChanceToPlay = 0.25,
				Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift03" },
					},
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HeraKeepsake_0160", Text = "Yes, my dear?" },
				{ Cue = "/VO/HeraKeepsake_0161", Text = "Regards." },
			},
			[3] = GlobalVoiceLines.AwardSelectedVoiceLines,
		},
		SignOffData =
		{
		  {
			Text = "SignoffHera",
		  },
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Keepsakes )