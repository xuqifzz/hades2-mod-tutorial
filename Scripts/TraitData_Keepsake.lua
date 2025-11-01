PersistentKeepsakeKeys = 
{
	"RemainingUses",
	"Uses",
	"CurrentRoom",
	"CurrentKeepsakeDamageBonus",
	"CurrentArmor",
	"CurrentTime",
	"EscalatingKeepsakeValue",
	"CustomTrayText",
	"CustomName",
	"CapMaxHealth",
	"TotalManaRecovered",
	"DoorHealReserve",
}

TraitSetData.Keepsakes =
{
	GiftTrait =
	{
		FrameRarities =
		{
			Common = "Frame_Keepsake_Rank1",
			Rare = "Frame_Keepsake_Rank2",
			Epic = "Frame_Keepsake_Rank3",
			Heroic = "Frame_Keepsake_Rank4",
		},
		Slot = "Keepsake",
		PreCreateActiveOverlay = true,
		ShowInHUD = true,
		HUDScale = 0.435,
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
		DebugOnly = true,

		PinAnimationIn = "TraitPinIn_Keepsake",
		PinAnimationOut = "TraitPinOut_Keepsake",
		TrayHighlightAnimScale = 1.2,

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
				Multiplier = 3.0,
			},
		},

		TrayTextBackingAnimation = "TraitTray_LevelBacking_Alt",
		TrayTextBackingOffsetY = 9,
		TrayTextOffsetY = -10,
		NewTraitHighlightAnimation = "NewTraitHighlightKeepsake",
	},

	BaseBoonUpgradeKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		DoesNotAutomaticallyExpire = true,
		DebugOnly = true,
		RarityLevels =
		{
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
		Icon = "Keepsake_32",
		EquipSound = "/SFX/Menu Sounds/KeepsakeMorosPin",
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
				Multiplier = 3.0,
			}
		},
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

		SpeakerNames = { "Moros" },

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
				Source = { LineHistoryName = "NPC_Moros_01", SubtitleColor = Color.MorosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/MorosKeepsake_0083", Text = "{#Emph}Princess." },
				{ Cue = "/VO/MorosKeepsake_0084", Text = "{#Emph}Princess...!" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna02" },
					},
				},
				Text = "SignoffMoros_Max"
			},
			{
				Text = "SignoffMoros",
			},
		},
	},
	
	ReincarnationKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_29",
		InRackTitle = "ReincarnationKeepsake_Rack",
		ZeroBonusTrayText = "ReincarnationKeepsake_Expired",
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
				Multiplier = 151/51,
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
				Source = { LineHistoryName = "NPC_Skelly_01", SubtitleColor = Color.SkellyVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/SkellyKeepsake_0109", Text = "{#Emph}Young one." },
				{ Cue = "/VO/SkellyKeepsake_0110", Text = "{#Emph}Kiddo." },
				{ Cue = "/VO/SkellyKeepsake_0111", Text = "{#Emph}Disciple.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyGift09" },
					},
				},
				Text = "SignoffSkelly_Max"
			},
			{
				Text = "SignoffSkelly",
			},
		},

	},

	DoorHealReserveKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "DoorHealReserveKeepsake_Rack",
		ZeroBonusTrayText = "DoorHealReserveKeepsake_Expired",
		Icon = "Keepsake_30",
		EquipSound = "/SFX/Menu Sounds/KeepsakeDoraOnion",
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
				Multiplier = 3.0,
			}
		},
		CustomInfoCardYOffset = 20,
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Dora_01", SubtitleColor = Color.DoraVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},

				{ Cue = "/VO/DoraKeepsake_0610", Text = "{#Emph}Mel!" },
				{ Cue = "/VO/DoraKeepsake_0611", Text = "{#Emph}Witch!" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
					},
				},
				Text = "SignoffDora_Max"
			},
			{
				Text = "SignoffDora",
			},
		},
	},
	DeathVengeanceKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "DeathVengeanceKeepsake_Rack",
		Icon = "Keepsake_31",
		EquipSound = "/SFX/Menu Sounds/KeepsakeNemesisEye",
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
				Multiplier = 2.0,
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
				Source = { LineHistoryName = "NPC_Nemesis_01", SubtitleColor = Color.NemesisVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/NemesisKeepsake_0291", Text = "{#Emph}Princess." },
				{ Cue = "/VO/NemesisKeepsake_0273", Text = "{#Emph}You..." },
				{ Cue = "/VO/NemesisKeepsake_0354", Text = "{#Emph}Princess." },
				{ Cue = "/VO/NemesisKeepsake_0355", Text = "{#Emph}Melinoë.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift05" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisBathHouse03" },
					},
				},
				Text = "SignoffNemesis_Max"
			},
			{
				Text = "SignoffNemesis",
			},
		},
	},
	LowHealthCritKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "LowHealthCritKeepsake_Rack",
		Icon = "Keepsake_44",
		EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisAntler",
		ZeroBonusTrayText = "LowHealthCritKeepsake_Expired",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 0.25/0.20,
			},
			Epic =
			{
				Multiplier = 0.30/0.20,
			},
			Heroic =
			{
				Multiplier = 0.50/0.20,
			}
		},
		PriorityDisplay = true,
		CapMaxHealth = 30,
		AddOutgoingCritModifiers =
		{
			TraitName = "LowHealthCritKeepsake",
			ActiveTraitChance = { BaseValue = 0.20 },
			ReportValues = { ReportedCritBonus = "ActiveTraitChance"}
		},
		Uses = 1,
		ExtractValues =
		{
			{
				Key = "CapMaxHealth",
				ExtractAs = "Health",
				HideSigns = true,
			},
			{
				Key = "ReportedCritBonus",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
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
				Source = { LineHistoryName = "NPC_Artemis_Field_01", SubtitleColor = Color.ArtemisVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ArtemisKeepsake_0214", Text = "{#Emph}Hey Sister." },
				{ Cue = "/VO/ArtemisKeepsake_0215", Text = "{#Emph}Melinoë.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift10" },
					},
				},
				Text = "SignoffArtemis_Max"
			},
			{
				Text = "SignoffArtemis",
			},
		},
	},
	SpellTalentKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "SpellTalentKeepsake_Rack",
		Icon = "Keepsake_45",
		EquipSound = "/SFX/Menu Sounds/KeepsakeSeleneMoonbeam",
		ZeroBonusTrayText = "SpellTalentKeepsake_Expired",
		PartialActiveTrayText = "SpellTalentKeepsake_Inactive",
		BlockedByEnding = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic =
			{
				Multiplier = 7/3,
			}
		},
		TalentPointCount = { BaseValue = 3 },
		AcquireFunctionName = "KeepsakeAcquireSpellDrop",
		AcquireFunctionArgs =
		{ 
			Name = "SpellDrop",
			AlternatePriorityRewardName = "TalentDrop",
			Count = { BaseValue = 3 },
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
			},
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/SeleneKeepsake_0402", Text = "{#Emph}Little star.", PlayFirst = true },
				{ Cue = "/VO/SeleneKeepsake_0403", Text = "{#Emph}Sister." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneGift09" },
					},
				},
				Text = "SignoffSelene_Max"
			},
			{
				Text = "SignoffSelene",
			},
		},
	},
	BonusMoneyKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "BonusMoneyKeepsake_Rack",
		Icon = "Keepsake_34",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHypnosCoinPurse",
		ZeroBonusTrayText = "BonusMoneyKeepsake_Expired",
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
				Multiplier = 2.00,
			}
		},
		BonusMoney = { BaseValue = 100 },
		ExtractValues =
		{
			{
				Key = "BonusMoney",
				ExtractAs = "TooltipMoney",
				Format = "MultipliedMoney",
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Charon_01", SubtitleColor = Color.CharonVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/CharonKeepsake_0030", Text = "{#Emph}Mehhh..." },
				{ Cue = "/VO/CharonKeepsake_0034", Text = "{#Emph}Hrrm..." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift08" },
					},
				},
				Text = "SignoffCharon_Max"
			},
			{
				Text = "SignoffCharon",
			},
		},
	},
	BossPreDamageKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_28",
		EquipSound = "/SFX/Menu Sounds/KeepsakeOdysseusKnucklebones",
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
				Multiplier = 5.00,
			}
		},
		SpeakerNames = { "Odysseus" },
		EncounterPreDamage =
		{
			PreDamage = { BaseValue = 0.05 },
			EnemyType = "Boss",
			DamageSourceName = "BossPreDamageKeepsake",
			ReportValues = { ReportedDamage = "PreDamage" }
		},
		AddIncomingDamageModifiers =
		{
			HealthOnly = true,
			BossDamageMultiplier = 0.90,
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
				Source = { LineHistoryName = "NPC_Odysseus_01", SubtitleColor = Color.OdysseusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "OdysseusGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/OdysseusKeepsake_0110", Text = "{#Emph}Goddess." },
				{ Cue = "/VO/OdysseusKeepsake_0111", Text = "{#Emph}Goddess.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusFishing02" },
					},
				},
				Text = "SignoffOdysseus_Max"
			},
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
		Icon = "Keepsake_27",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHecateWheel",
		RarityLevels =
		{

			Common =
			{
				Multiplier = 1.0
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 3
			},
		},
		AcquireFunctionName = "KeepsakeAddMaxMana",
		AcquireFunctionArgs = 
		{
			Amount = { BaseValue = 50 },
			Source = "ManaOverTimeRefundKeepsake",
			ReportValues = { ReportedCount = "Amount" }
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "ManaCount",
			},
		},

		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.33,
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
				Source = { LineHistoryName = "NPC_Hecate_01", SubtitleColor = Color.HecateVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift04" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HecateKeepsake_0069", Text = "{#Emph}Melinoë." },
				-- { Cue = "/VO/HecateKeepsake_0692", Text = "Melinoë." },
				{ Cue = "/VO/HecateKeepsake_0693", Text = "{#Emph}Melinoë?" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" },
					},
				},
				Text = "SignoffHecate_Max"
			},
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
		Icon = "Keepsake_37",
		EquipSound = "/SFX/Menu Sounds/KeepsakeCircePig",
		PostBossCardRarity = { BaseValue = 1 },
		ZeroBonusTrayText = "BossMetaUpgradeKeepsake_Expired",
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Circe_01", SubtitleColor = Color.CirceVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/CirceKeepsake_0263", Text = "{#Emph}Poppet." },
				{ Cue = "/VO/CirceKeepsake_0264", Text = "{#Emph}Little miss!" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift08" },
					},
				},
				Text = "SignoffCirce_Max"
			},
			{
				Text = "SignoffCirce",
			},
		},
	},
	FountainRarityKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "FountainRarityKeepsake_Rack",
		Icon = "Keepsake_39",
		EquipSound = "/SFX/Menu Sounds/KeepsakeNarcissusVial",
		-- DescriptionTextSymbolScale = 0.65,
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
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines =
			{
				"HealingReductionNotice",
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
				Source = { LineHistoryName = "NPC_Narcissus_01", SubtitleColor = Color.NarcissusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NarcissusAboutReflection01", "NarcissusGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/NarcissusKeepsake_0119", Text = "{#Emph}Hey Laurel.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NarcissusAboutFriendship06" },
						},
					},
				},
				{ Cue = "/VO/NarcissusKeepsake_0120", Text = "{#Emph}Laurel!",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NarcissusAboutFriendship06" },
						},
					},
				},
				{ Cue = "/VO/NarcissusKeepsake_0305", Text = "{#Emph}Hey, Melinoë.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutFriendship06" },
						},
					},
				},
				{ Cue = "/VO/NarcissusKeepsake_0306", Text = "{#Emph}Melinoë!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutFriendship06" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},

		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift07" },
					},
				},
				Text = "SignoffNarcissus_Max"
			},
			{
				Text = "SignoffNarcissus",
			},
		},

	},
	ArmorGainKeepsake = 
	{
		InheritFrom = { "GiftTrait", "CostumeTrait" },
		Frame = "nil",
		InRackTitle = "ArmorGainKeepsake_Rack",
		Icon = "Keepsake_38",
		EquipSound = "/SFX/Menu Sounds/KeepsakeArachneSash",
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
				Multiplier = 3.0,
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
				BaseAmount = 30,
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Arachne_01", SubtitleColor = Color.ArachneVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ArachneKeepsake_0462", Text = "{#Emph}My friend!" },
				{ Cue = "/VO/ArachneKeepsake_0463", Text = "{#Emph}You silly..." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift09" },
					},
				},
				Text = "SignoffArachne_Max"
			},
			{
				Text = "SignoffArachne",
			},
		},
	},
	TempHammerKeepsake = 
	{
		InheritFrom = {"GiftTrait"},
		InRackTitle = "TempHammerKeepsake_Rack",
		Icon = "Keepsake_41",
		EquipSound = "/SFX/Menu Sounds/KeepsakeIcarusHammer",		
		ZeroBonusTrayText = "TempHammerKeepsake_Inactive",
		SwapInvalidateCheckpoint = true,
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift04", "IcarusHomeFirstMeeting" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/IcarusKeepsake_0487", Text = "{#Emph}Meli.", PlayFirst = true },
				{ Cue = "/VO/IcarusKeepsake_0488", Text = "{#Emph}Your Grace." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift10" },
					},
				},
				Text = "SignoffIcarus_Max"
			},
			{
				Text = "SignoffIcarus",
			},
		},
	},
	DecayingBoostKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_35",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHeraclesFang",
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
				Multiplier = 0.7,
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Heracles_01", SubtitleColor = Color.HeraclesVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HeraclesKeepsake_0361", Text = "{#Emph}Sister." },
				{ Cue = "/VO/HeraclesKeepsake_0362", Text = "{#Emph}Witch.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" },
					},
				},
				Text = "SignoffHeracles_Max"
			},
			{
				Text = "SignoffHeracles",
			},
		},
	},
	DamagedDamageBoostKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_36",
		EquipSound = "/SFX/Menu Sounds/KeepsakeMedeaFleece",
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
				Multiplier = 3.0,
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Medea_01", SubtitleColor = Color.MedeaVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/MedeaKeepsake_0282", Text = "{#Emph}Sorceress!" },
				{ Cue = "/VO/MedeaKeepsake_0283", Text = "{#Emph}Sorceress...?", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift08" },
					},
				},
				Text = "SignoffMedea_Max"
			},
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
				Multiplier = 3.0,
			}
		},
		Icon = "Keepsake_33",
		EquipSound = "/SFX/Menu Sounds/KeepsakeErisBell",
		InRackTitle = "EscalatingKeepsake_Rack",
		CustomTrayNameWhileDead = "EscalatingKeepsake",
		CustomTrayText = "EscalatingKeepsake_Tray",
		Permanent = true,
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ErisKeepsake_0454", Text = "{#Emph}Hey Trouble!" },
				{ Cue = "/VO/ErisKeepsake_0455", Text = "{#Emph}Hi babe!", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" },
					},
				},
				Text = "SignoffEris_Max"
			},
			{
				Text = "SignoffEris",
			},
		},
	},
	TimedBuffKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		Icon = "Keepsake_43",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHermesDroplet",
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
				Multiplier = 2.0,
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
				Source = { LineHistoryName = "NPC_Hermes_01", SubtitleColor = Color.HermesVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HermesKeepsake_0156", Text = "{#Emph}Hey M!", PlayFirst = true },
				{ Cue = "/VO/HermesKeepsake_0157", Text = "{#Emph}Let's go, M." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" },
					},
				},
				Text = "SignoffHermes_Max"
			},
			{
				Text = "SignoffHermes",
			},
		},
	},

	UnpickedBoonKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "UnpickedBoonKeepsake_Rack",
		Icon = "Keepsake_40",
		EquipSound = "/SFX/Menu Sounds/KeepsakeEchoStone",
		SpeakerNames = { "Echo" },
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
				Format = "LuckModifiedPercent",
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
			{
				PreLineWait = 0.3,
				-- BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift04" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/Melinoe_3189", Text = "The Stone." },
				{ Cue = "/VO/EchoKeepsake_0157", Text = "{#Emph}The Stone... {#Prev}{#Echo1Italic}the Stone... {#Prev}{#Echo2Italic}the Stone...", Source = { LineHistoryName = "NPC_Echo_01", SubtitleColor = Color.EchoVoice }, PreLineWait = 0.05, BreakIfPlayed = true, },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Echo_01", SubtitleColor = Color.EchoVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/EchoKeepsake_0156", Text = "{#Emph}Echo... {#Prev}{#Echo1Italic}Echo... {#Prev}{#Echo2Italic}Echo..." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift08" },
					},
				},
				Text = "SignoffEcho_Max"
			},
			{
				Text = "SignoffEcho",
			},
		},
	},

	RandomBlessingKeepsake =
	{
		InheritFrom = { "GiftTrait" },
		InRackTitle = "RandomBlessingKeepsake_Rack",
		Icon = "Keepsake_42",
		EquipSound = "/SFX/Menu Sounds/KeepsakeChaosEgg",
		SpeakerNames = { "Chaos" },
		SwapInvalidateCheckpoint = true,
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
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ChaosKeepsake_0280", Text = "{#Emph}Spawn of Hades." },
				{ Cue = "/VO/ChaosKeepsake_0281", Text = "{#Emph}Spawn of Hades?" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift07" },
					},
				},
				Text = "SignoffChaos_Max"
			},
			{
				Text = "SignoffChaos",
			},
		},
	},
	SkipEncounterKeepsake =
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
		Icon = "Keepsake_55",
		ZeroBonusTrayText = "SkipEncounterKeepsake_Inactive",
		EquipSound = "/SFX/Menu Sounds/KeepsakeDionysusLeaf",
		Using = { ObstacleName = { "3DDiscoBall", "OlympusCeilingChain01", }, },

		AcquireFunctionName = "DionysusSkipTrait",
		AcquireFunctionArgs = 
		{		
			SkipEncounterChance = 0.37,
			RemainingUses = { BaseValue = 1 },
			ReportValues = 
			{
				ReportedUses = "RemainingUses",
				ReportedSkipEncounterChance = "SkipEncounterChance",
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedSkipEncounterChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
				SkipAutoExtract = true,
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
				{ Cue = "/VO/Melinoe_3762", Text = "The Leaf." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Dionysus_01", SubtitleColor = Color.DionysusVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DionysusGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/DionysusKeepsake_0276", Text = "{#Emph}Mel baby!" },
				{ Cue = "/VO/DionysusKeepsake_0277", Text = "{#Emph}Whoa...", PlayFirst = true },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusGift07" },
					},
				},
				Text = "SignoffDionysus_Max"
			},
			{
				Text = "SignoffDionysus",
			},
		},
	},

	PersistentDionysusSkipKeepsake = 
	{
		Icon = "Keepsake_55",
		RarityLevels =
		{
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
			Heroic =
			{
				Multiplier = 4,
			}
		},
		Using = { ObstacleName = { "3DDiscoBall", "OlympusCeilingChain01", }, },
		SpeakerNames = { "Dionysus" },
		SkipEncounterValidationFunctionName = "CanDionysusSkip",
		OnEncounterSkipFunction = "ProcessDionysusSkip",
		ActivatedThisBiome = false,
		SkipEncounterChance = 0,	--Filled by SkipEncounterKeepsake
		RemainingUses = 1,			--Filled by SkipEncounterKeepsake
		ExtractValues = 
		{
			{
				Key = "SkipEncounterChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent"
			},
			{
				Key = "RemainingUses",
				ExtractAs = "BiomesLeft",
				Format = "RemainingBiomes",
			}
		},
	},

	AthenaEncounterKeepsake = 
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
		ShowLastStandWarning = true,
		Icon = "Keepsake_54",
		ZeroBonusTrayText = "AthenaEncounterKeepsake_Inactive",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAthenaGorgon",
		RemainingUses = 1,
		SpeakerNames = { "Athena" },
		PackageNames = { "NPC_Athena_01" },
		BlockedByEnding = true,
		Using =
		{
			SpawnUnit = "NPC_Athena_01",
			Animations =
			{
				"Athena_Salute",
				"Athena_Blessing",
				"Athena_Brooding",
				"Athena_Proud_Start",
				"Athena_Proud_End",
				"AthenaUnequipSparkle",
			},
		},
		UniqueEncounterArgs = 
		{
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "Hero", "LastStands" },
					UseLength = true,
					Comparison = "<=",
					Value = 0,
				},
				{
					Path = { "CurrentRun", "BiomeDepthCache" },
					Comparison = ">=",
					Value = 2,
				},
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "BlockAthenaEncounterKeepsake" }
				},
				NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
			},
			EncounterThreadedFunctions = 
			{
				FunctionName = "HandleAthenaSpawn",
				Args = 
				{
					RarityLevelBonus = { BaseValue = 1 },
					FromTrait = "AthenaEncounterKeepsake",
					ReportValues = { BlessingRarityBonus = "RarityLevelBonus" },
					LoadPackages = { "Athena" },
				},
			}
		},
		ExtractValues = 
		{
			{
				Key = "BlessingRarityBonus",
				ExtractAs = "RarityValue",
				Format = "Rarity",
				SkipAutoExtract = true,
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

				{ Cue = "/VO/Melinoe_3761", Text = "The Amulet." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Athena_01", SubtitleColor = Color.AthenaVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/AthenaKeepsake_0303", Text = "{#Emph}Cousin." },
				{ Cue = "/VO/AthenaKeepsake_0304", Text = "{#Emph}Melinoë." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaGift07" },
					},
				},
				Text = "SignoffAthena_Max"
			},
			{
				Text = "SignoffAthena",
			},
		},
	},
	RarifyKeepsake = 
	{
		InheritFrom = { "GiftTrait" },
		EquipSound = "/SFX/Menu Sounds/KeepsakeZagreusCard",
		RarityLevels =
		{
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
			Heroic =
			{
				Multiplier = 4,
			}
		},
		SpeakerNames = { "Zagreus" },
		Icon = "Keepsake_57",
		ZeroBonusTrayText = "RarifyKeepsake_Expired",
		Permanent = true,
		RarityUpgradeData = 
		{
			RequireFated = true,
			RequireNotExcludeFromLastRunBoon = true,
			MultiUse = true,
			Uses = { BaseValue = 2 },
			MaxRarity = 3,
			ReportValues = 
			{ 
				ReportedUpgrades = "Uses",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedUpgrades",
				ExtractAs = "Uses",
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

				{ Cue = "/VO/Melinoe_5056", Text = "The Card." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsBondForged01" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ZagreusKeepsake_0098", Text = "{#Emph}Melinoë...!" },
				{ Cue = "/VO/ZagreusKeepsake_0158", Text = "{#Emph}Sister!" },
			},
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsBondForged01" },
					},
				},
				Text = "SignoffZagreus_Max"
			},
			{
				Text = "SignoffZagreus",
			},
		},
	},
	HadesAndPersephoneKeepsake = 
	{
		InheritFrom = {"GiftTrait"},
		EquipSound = "/SFX/Menu Sounds/KeepsakeHadesPersephone",
		RarityLevels =
		{
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
			Heroic =
			{
				Multiplier = 4,
			}
		},
		Icon = "Keepsake_58",
		FatedBoonLevelBonus = { BaseValue = 1,},
		SwapInvalidateCheckpoint = true,
		AcquireFunctionName = "GiveRandomHadesBoonAndBoostBoons",
		Permanent = true,
		DelayedRunStartPresentation = 
		{
			FunctionName = "RunStartHadesKeepsakeAcquiredPresentation",
		},
		ExtractValues = 
		{
			{
				Key = "FatedBoonLevelBonus",
				ExtractAs = "Levels",
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

				{ Cue = "/VO/Melinoe_5057", Text = "The Pom." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Persephone_01", SubtitleColor = Color.PersephoneVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift03" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/PersephoneKeepsake_0030", Text = "{#Emph}Daughter!" },
				{ Cue = "/VO/PersephoneKeepsake_0032", Text = "{#Emph}Melinoë." },
				{ Cue = "/VO/HadesKeepsake_0374", Text = "{#Emph}Daughter.", Source = { LineHistoryName = "NPC_Hades_02", SubtitleColor = Color.HadesVoice }, },
				{ Cue = "/VO/HadesKeepsake_0375", Text = "{#Emph}My daughter.", Source = { LineHistoryName = "NPC_Hades_02", SubtitleColor = Color.HadesVoice }, },
			},
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift06" },
					},
				},
				Text = "SignoffHadesAndPersephone_Max"
			},
			{
				Text = "SignoffHadesAndPersephone",
			},
		},
	},
	GoldifyKeepsake = 
	{
		InheritFrom = {"GiftTrait"},
		EquipSound = "/SFX/Menu Sounds/KeepsakeChronosRing",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 3/2,
			},
			Epic =
			{
				Multiplier = 4/2,
			},
			Heroic =
			{
				Multiplier = 5/2,
			}
		},
		SpeakerNames = { "Chronos" },
		Icon = "Keepsake_59",
		BoonConversionUses = { BaseValue = 2 },
		BoostedBoonValueAddition = 100,
		Permanent = true,
		ZeroBonusTrayText = "GoldifyKeepsake_Expired",
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

				{ Cue = "/VO/Melinoe_5058", Text = "The Piece." },
			},
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Chronos_02", SubtitleColor = Color.ChronosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift03" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ChronosKeepsake_1353", Text = "{#Emph}Granddaughter.", PlayFirst = true },
				{ Cue = "/VO/ChronosKeepsake_1354", Text = "{#Emph}Melinoë." },
			},
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" },
					},
				},
				Text = "SignoffChronos_Max"
			},
			{
				Text = "SignoffChronos",
			},
		},
	},
	ForceHephaestusBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_52",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHephaestusShard",
		InRackTitle = "ForceHephaestusBoonKeepsake_Rack",
		ForceBoonName = "HephaestusUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Hephaestus_01", SubtitleColor = Color.HephaestusVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HephaestusKeepsake_0235", Text = "{#Emph}Witchie!" },
				{ Cue = "/VO/HephaestusKeepsake_0236", Text = "{#Emph}Oi, witchie." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift07" },
					},
				},
				Text = "SignoffHephaestus_Max"
			},
			{
				Text = "SignoffHephaestus",
			},
		},
	},
	ForceZeusBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_46",
		EquipSound = "/SFX/Menu Sounds/KeepsakeZeusRing",
		InRackTitle = "ForceZeusBoonKeepsake_Rack",
		ForceBoonName = "ZeusUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
				Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ZeusKeepsake_0184", Text = "{#Emph}Young lady." },
				{ Cue = "/VO/ZeusKeepsake_0185", Text = "{#Emph}Melinoë." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusGift07" },
					},
				},
				Text = "SignoffZeus_Max"
			},
			{
				Text = "SignoffZeus",
			},
		},
	},

	ForceDemeterBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_49",
		EquipSound = "/SFX/Menu Sounds/KeepsakeDemeterSheaf",
		InRackTitle = "ForceDemeterBoonKeepsake_Rack",
		ForceBoonName = "DemeterUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
				Source = { LineHistoryName = "NPC_Demeter_01", SubtitleColor = Color.DemeterVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/DemeterKeepsake_0153", Text = "{#Emph}Granddaughter." },
				{ Cue = "/VO/DemeterKeepsake_0154", Text = "{#Emph}Melinoë." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift08" },
					},
				},
				Text = "SignoffDemeter_Max"
			},
			{
				Text = "SignoffDemeter",
			},
		},
	},
	ForceAphroditeBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_51",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAphroditeMirror",
		InRackTitle = "ForceAphroditeBoonKeepsake_Rack",
		ForceBoonName = "AphroditeUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/AphroditeKeepsake_0248", Text = "{#Emph}Gorgeous!" },
				{ Cue = "/VO/AphroditeKeepsake_0249", Text = "{#Emph}Hi love." },
				{ Cue = "/VO/AphroditeKeepsake_0250", Text = "{#Emph}Sweetness!" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift07" },
					},
				},
				Text = "SignoffAphrodite_Max"
			},
			{
				Text = "SignoffAphrodite",
			},
		},
	},
	ForcePoseidonBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_48",
		EquipSound = "/SFX/Menu Sounds/KeepsakePoseidonSea",
		InRackTitle = "ForcePoseidonBoonKeepsake_Rack",
		ForceBoonName = "PoseidonUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
			{
				PreLineWait = 0.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/PoseidonKeepsake_0306", Text = "{#Emph}My niece!" },
				{ Cue = "/VO/PoseidonKeepsake_0307", Text = "{#Emph}Ahoy!" },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift07" },
					},
				},
				Text = "SignoffPoseidon_Max"
			},
			{
				Text = "SignoffPoseidon",
			},
		},
	},
	ForceApolloBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_50",
		EquipSound = "/SFX/Menu Sounds/KeepsakeApolloHarp",
		InRackTitle = "ForceApolloBoonKeepsake_Rack",
		ForceBoonName = "ApolloUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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

				{ Cue = "/VO/Melinoe_4511", Text = "The Photon." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/ApolloKeepsake_0248", Text = "{#Emph}Cousin." },
				{ Cue = "/VO/ApolloKeepsake_0249", Text = "{#Emph}Sunshine." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift07" },
					},
				},
				Text = "SignoffApollo_Max"
			},
			{
				Text = "SignoffApollo",
			},
		},
	},
	ForceHestiaBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_53",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHestiaEmber",
		InRackTitle = "ForceHestiaBoonKeepsake_Rack",
		ForceBoonName = "HestiaUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Hestia_01", SubtitleColor = Color.HestiaVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HestiaKeepsake_0274", Text = "{#Emph}Dearie." },
				{ Cue = "/VO/HestiaKeepsake_0275", Text = "{#Emph}Hot stuff." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift07" },
					},
				},
				Text = "SignoffHestia_Max"
			},
			{
				Text = "SignoffHestia",
			},
		},
	},
	ForceAresBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_56",
		EquipSound = "/SFX/Menu Sounds/KeepsakeAresBloodVial",
		InRackTitle = "ForceAresBoonKeepsake_Rack",
		ForceBoonName = "AresUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
		RarityUpgradeData = 
		{
			LootName = "AresUpgrade",
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

				{ Cue = "/VO/Melinoe_3959", Text = "The Hilt." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Ares_01", SubtitleColor = Color.AresVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/AresKeepsake_0134", Text = "{#Emph}My kin?" },
				{ Cue = "/VO/AresKeepsake_0135", Text = "{#Emph}Yes, my kin." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AresGift07" },
					},
				},
				Text = "SignoffAres_Max"
			},
			{
				Text = "SignoffAres",
			},
		},
	},
	ForceHeraBoonKeepsake =
	{
		InheritFrom = { "BaseBoonUpgradeKeepsake" },
		Icon = "Keepsake_47",
		EquipSound = "/SFX/Menu Sounds/KeepsakeHeraFan",
		InRackTitle = "ForceHeraBoonKeepsake_Rack",
		ForceBoonName = "HeraUpgrade",
		AcquireFunctionName = "RewardStoreAddPriority",
		AcquireFunctionArgs =
		{ 
			Name = "Boon",
		},
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
				Source = { LineHistoryName = "NPC_Hera_01", SubtitleColor = Color.HeraVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift04" },
					},
					ChanceToPlay = 0.33,
				},
				Cooldowns =
				{
					{ Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
				},
				{ Cue = "/VO/HeraKeepsake_0160", Text = "{#Emph}Yes, my dear?" },
				{ Cue = "/VO/HeraKeepsake_0161", Text = "{#Emph}Regards." },
				{ Cue = "/VO/HeraKeepsake_0269", Text = "{#Emph}My dear." },
				{ Cue = "/VO/HeraKeepsake_0270", Text = "{#Emph}I am here." },
			},
			{ GlobalVoiceLines = "AwardSelectedVoiceLines" },
		},
		SignOffData =
		{
			{
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" },
					},
				},
				Text = "SignoffHera_Max"
			},
			{
				Text = "SignoffHera",
			},
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Keepsakes )