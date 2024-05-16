ResourceData =
{
	-- Meta
	MetaCurrency =
	{
		IconPath = "Items\\Resources\\Common\\MetaCurrency_Text",
		TooltipId = "MetaCurrencyIcon",
		CostTextId = "MetaCurrency_Short",
		-- OnAddVoiceLines: using OnConsumedVoiceLines instead

		ExtraDescriptions =
		{
			{
				TextId = "MetaCurrency_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
			{
				TextId = "MetaCurrency_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
					},
				},
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = "<=",
					Value = 10,
				},
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_3550", Text = "Always need Bones, just... not precisely now." },
		},

	},

	MetaCardPointsCommon =
	{
		IconPath = "Items\\Resources\\Common\\MetaCardPointsCommon",
		IconScale = 0.4,
		TextIconPath = "Items\\Resources\\Common\\MetaCardPointsCommon_Text",
		TooltipId = "MetaCardPointsCommonIcon",
		CostTextId = "MetaCardPointsCommon_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MetaCardPointsCommon_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_1903", Text = "I'll need these soon enough." },
		},
		OnAddVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Melinoe_1903", Text = "I'll need these soon enough." },
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "ErisResourceGranted", Time = 8 }
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech", "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_1661", Text = "Ash of the Dead.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1662", Text = "Ashes." },
				{ Cue = "/VO/Melinoe_1663", Text = "More Ashes." },
				{ Cue = "/VO/Melinoe_1664", Text = "Ash for my Arcana." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MemPointsCommon =
	{
		IconPath = "Items\\Resources\\Common\\MemPointsCommon",
		IconScale = 0.4,
		TextIconPath = "Items\\Resources\\Common\\MemPointsCommon_Text",
		TooltipId = "MemPointsCommonIcon",
		CostTextId = "MemPointsCommon_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MemPointsCommon_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
					},
				},
			},
			{
				TextId = "MemPointsCommon_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
		},
		InventoryVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" }
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},
			{ Cue = "/VO/Melinoe_1659", Text = "Can use this at my Altar back home." },
		},

		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Melinoe_1659", Text = "Can use this at my Altar back home." },
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "ErisResourceGranted", Time = 8 }
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "HeraclesCombatN" },
					},
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech", "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_1657", Text = "Psyche.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1658", Text = "More Psyche." },
				{ Cue = "/VO/Melinoe_1904", Text = "I'll just stash this away.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1660", Text = "The Spirits of the Dead..." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MetaFabric =
	{
		IconPath = "Items\\Resources\\Common\\MetaFabric_Text",
		TooltipId = "MetaFabricIcon",
		CostTextId = "MetaFabric_Short",

		ExtraDescriptions =
		{
			{
				TextId = "MetaFabric_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"HighArmorCostume",
						},
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1064", Text = "Fate Fabric.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1065", Text = "Some Fate Fabric." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	CardUpgradePoints =
	{
		IconPath = "Items\\Resources\\Other\\CardUpgradePoints_Text",
		TooltipId = "CardUpgradePointsIcon",
		CostTextId = "CardUpgradePoints_Short",

		ExtraDescriptions =
		{
			{
				TextId = "CardUpgradePoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_1066", Text = "Moon Dust.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1067", Text = "Some Moon Dust." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	-- Gifts
	GiftPoints =
	{
		IconPath = "GUI\\Icons\\Gift",
		TooltipId = "GiftPointsIcon",
		CostTextId = "GiftPoints_Short",

		OnAddedFunctionName = "OnGiftPointsAdded",

		SpendSound = "/SFX/GiftAmbrosiaBottlePickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentGiftPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedGiftPointsVoiceLines,
		},


		ExtraDescriptions =
		{
			{
				TextId = "GiftPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
			},
			{
				TextId = "GiftPoints_ExtraDetails2",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNectar01" },
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.15,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "TestAllThings" },
					},
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisGiftDecline01", "NemesisGiftDecline01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent", "Story_Hades_01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0793", Text = "Nectar.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Melinoe_0793", "/VO/Melinoe_0794" },
						},
					}
				},
				{ Cue = "/VO/Melinoe_0794", Text = "Some Nectar.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Melinoe_0793", "/VO/Melinoe_0794" },
						},
					}
				},
				{ Cue = "/VO/Melinoe_1989", Text = "Could make a lovely gift.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1990", Text = "Who shall I give this to?", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	GiftPointsRare =
	{
		IconPath = "Items\\Resources\\Other\\GiftPointsRare_Text",
		TooltipId = "GiftPointsRareIcon",
		CostTextId = "GiftPointsRare_Short",
		AddTimerTicks = 12, -- used for text

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "HubTextLinesRecord" },
						HasNone = { "HecateBathHouseDecline01", "OdysseusBathHouseDecline01", "NemesisBathHouseDecline01", "ErisBathHouseDecline01", "MorosBathHouseDecline01", "SkellyBathHouseDecline01", "DoraBathHouseDecline01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0796", Text = "Salt." },
				{ Cue = "/VO/Melinoe_0797", Text = "Some Salt.", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	GiftPointsEpic =
	{
		IconPath = "Items\\Resources\\Other\\GiftPointsEpic_Text",
		TooltipId = "GiftPointsEpicIcon",
		CostTextId = "GiftPointsEpic_Short",
		AddTimerTicks = 16, -- used for text

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "CurrentRun", "HubTextLinesRecord" },
						HasNone = { "ErisFishingDecline01", "HecateFishingDecline01", "NemesisFishingDecline01", "ErisFishingDecline01", "MorosFishingDecline01", "SkellyFishingDecline01", "DoraFishingDecline01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "NemesisRandomEvent" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0798", Text = "Lures." },
				{ Cue = "/VO/Melinoe_0799", Text = "A set of Lures.", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	-- Misc
	WeaponPointsRare =
	{
		IconPath = "Items\\Resources\\Other\\WeaponPointsRare_Text",
		TooltipId = "WeaponPointsRareIcon",
		CostTextId = "WeaponPointsRare_Short",

		SpendSound = "/SFX/TitanBloodPickupSFX",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperLockKeysVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperLockKeysVoiceLines,
		},

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "WeaponPointsRare_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" }
					},
				},
			},
			{
				TextId = "WeaponPointsRare_ExtraDetails2",
				Requirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2952", Text = "Nightmare." },
				{ Cue = "/VO/Melinoe_2953", Text = "Some Nightmare." },
				{ Cue = "/VO/Melinoe_2954", Text = "From the Oath." },
				{ Cue = "/VO/Melinoe_2955", Text = "A gift from Night.", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	Mixer5Common =
	{
		IconPath = "Items\\Resources\\Other\\Mixer5Common_Text",
		TooltipId = "Mixer5CommonIcon",
		CostTextId = "Mixer5Common_Short",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer5Common_ExtraDetails1",
				Requirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"NarcissusG",
						},
					},
				},
			}
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2381", Text = "Star Dust." },
				{ Cue = "/VO/Melinoe_2382", Text = "Some Star Dust." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	Mixer6Common =
	{
		IconPath = "GUI\\Icons\\Darkness",
		TooltipId = "Mixer6CommonIcon",
		CostTextId = "Mixer6Common_Short",

		ExtraDescriptions =
		{
			{
				TextId = "Mixer6Common_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsDarkness01" },
					},
				},
			}
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_0699", Text = "Darkness." },
				{ Cue = "/VO/Melinoe_0700", Text = "Some Darkness." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerShadow =
	{
		IconPath = "Items\\Resources\\Alchemy\\Shadow_Text",
		TooltipId = "MixerShadowIcon",
		CostTextId = "MixerShadow_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeAltRunDoor" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "MixerShadow_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeMixerShadow" },
					},
				},
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
					Comparison = "<",
					Value = 1,
				},
			},
			{ Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2535", Text = "Shadow." },
				{ Cue = "/VO/Melinoe_2536", Text = "Some Shadow." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	MixerMythic =
	{
		IconPath = "Items\\Resources\\Other\\MixerMythic_Text",
		TooltipId = "MixerMythicIcon",
		CostTextId = "MixerMythic_Short",

		RevealGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeTimeStop" },
			},
		},

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MixerMythic" },
					Comparison = "<",
					Value = 1,
				},
			},
			-- { Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
		},

		OnAddVoiceLines =
		{
		},
	},

	FamiliarPoints =
	{
		IconPath = "Items\\Resources\\Alchemy\\FamiliarPoints_Text",
		TooltipId = "FamiliarPointsIcon",
		CostTextId = "FamiliarPoints_Short",

		RevealGameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAny = { "/VO/Melinoe_0990" },
			},
			{
				Path = { "GameState", "WorldUpgradesRevealed" },
				HasAll = { "WorldUpgradeAltRunDoor" },
			},
		},

		ExtraDescriptions =
		{
			{
				TextId = "FamiliarPoints_ExtraDetails1",
				Requirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" }
					},
					{
						Path = { "GameState", "FamiliarStatus" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1068", Text = "Witch's Delight.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1069", Text = "Some Witch's Delight." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},		
	},

	MysteryResource =
	{
		IconPath = "GUI\\Icons\\Status\\Startled",
		TooltipId = "MysteryResourceIcon",
	},

	SuperGiftPoints =
	{
		IconPath = "GUI\\Icons\\SuperGift",
		TooltipId = "SuperGiftPointsIcon",
		CostTextId = "SuperGiftPoints_Short",
		AddTimerTicks = 20, -- used for text

		SpendSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperGiftPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperGiftPointsVoiceLines,
		},

		OnAddVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelinoePurchasedConsumableSpeech" },

				{ Cue = "/VO/Melinoe_0800", Text = "Ambrosia." },
			},
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
		},
	},

	CharonPoints =
	{
		IconPath = "Items\\Resources\\Other\\CharonPoints_Text",
		TooltipId = "MysteryResourceIcon",
		CostTextId = "CharonPoints_Short",

		InventoryVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "CharonGrantsMailbox01" }
				}
			},
			{ Cue = "/VO/Melinoe_2623", Text = "Exclusive access to Charon's premium wares..." },
		},
	},

	TrashPoints =
	{
		IconPath = "Items\\Resources\\Other\\TrashPoints_Text",
		TooltipId = "TrashPointsIcon",
		CostTextId = "TrashPoints_Short",
		OnAddVoiceLines =
		{
			ObjectType = "NPC_Eris_01",
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},

				{ Cue = "/VO/Melinoe_2440", Text = "Disgusting...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_2441", Text = "{#Emph}Eugh..." },
				{ Cue = "/VO/Melinoe_2442", Text = "Such a mess..." },
				{ Cue = "/VO/Melinoe_2443", Text = "More of this filth..." },
				{ Cue = "/VO/Melinoe_1721", Text = "Such a mess." },
				{ Cue = "/VO/Melinoe_1724", Text = "I'll just clean this up...",
					GameStateRequirements =
					{
						AreIdsAlive = { 585573 },
					},
				},
				{ Cue = "/VO/Melinoe_2444", Text = "Eris...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2445", Text = "Looks like Eris is back...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
						},
						AreIdsAlive = { 585573 },
					},
				},
				{ Cue = "/VO/Melinoe_2446", Text = "I'll just clean this up..." },
			},
			{
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.05,
				GameStateRequirements =
				{
					RequiredFalseQueuedTextLines =
					{
						"ErisAboutWeaponGun01",
					},
					MaxDistanceFromHero = 400,
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 6 },
				},
				{ Cue = "/VO/Eris_0079", Text = "Don't bother!" },
			},
		},

	},

	Money =
	{
		IconPath = "GUI\\Icons\\Currency",
		TooltipId = "Currency",
		CostTextId = "Money_Short",
		RunResource = true,
		SkipFlyToInventory = true,
		SkipInventoryObjective = true,
		SkipResourceSpendPresentation = true,
		OnAddedFunctionName = "UpdateMoneyUI",
		OnSpentFunctionName = "UpdateMoneyUI",
		IgnoreAsLastResourceGained = true,
	},

	-- Minos
	LockKeys =
	{
		IconPath = "GUI\\Icons\\LockKey",

		OnAddedFunctionName = "OnLockKeysAdded",

		SpendSound = "/SFX/KeyPickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentLockKeysVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedLockKeysVoiceLines,
		},
	},

	MetaPoints =
	{
		IconPath = "GUI\\Icons\\Darkness",

		OnAddedFunctionName = "OnMetaPointsAdded",

		SpendSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentMetaPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedMetaPointsVoiceLines,
		},
	},

	Gems =
	{
		IconPath = "GUI\\Icons\\Gems",
		
		SpendSound = "/SFX/GemPickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentGemsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedGemsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientGemsVoiceLines,
		},
	},

	SuperLockKeys =
	{
		IconPath = "GUI\\Icons\\Blood",

		SpendSound = "/SFX/TitanBloodPickupSFX",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperLockKeysVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperLockKeysVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientSuperLockKeysVoiceLines,
		},

	},

	SuperGems =
	{
		IconPath = "GUI\\Icons\\SuperGems",

		SpendSound = "/SFX/SuperGemPickup",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperGemsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperGemsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientSuperGemsVoiceLines,
		},
	},
}

ResourceDisplayOrderData = 
{
	"MetaCurrency", 
	"OreFSilver",
	"OreGLime",
	"OreHGlassrock",
	"OreIMarble",
	"OreNBronze",
	"OreOIron",
	"OreChaosProtoplasm",
	"MetaCardPointsCommon",
	"MemPointsCommon",
	"MixerFBoss",
	"MetaFabric",
	"MixerGBoss",
	"MixerHBoss",
	"MixerIBoss",
	"MixerNBoss",
	"CardUpgradePoints",
	"Mixer5Common",
	"MixerShadow",
	"Mixer6Common",
	"MixerMythic",
	"WeaponPointsRare",
	"CosmeticsPointsCommon",
	"CosmeticsPointsRare",
	"CosmeticsPointsEpic",

	"GiftPoints",
	"GiftPointsRare",
	"GiftPointsEpic",
	"SuperGiftPoints",
	"FamiliarPoints",

	"PlantFMoly",
	"PlantMoney",
	"PlantGLotus",
	"PlantHMyrtle",
	"PlantIShaderot",
	"PlantNMoss",
	"PlantODriftwood",
	"PlantFNightshadeSeed",
	"PlantFNightshade",
	"PlantGCattailSeed",
	"PlantGCattail",
	"PlantHWheatSeed",
	"PlantHWheat",
	"PlantIPoppySeed",
	"PlantIPoppy",
	"PlantNGarlicSeed",
	"PlantNGarlic",
	"PlantOMandrakeSeed",
	"PlantOMandrake",
	"PlantChaosThalamusSeed",
	"PlantChaosThalamus",
	"SeedMystery",
	"PlantGrowthAccelerant",
	"MixerOBoss",

	"FishFCommon",
	"FishFRare",
	"FishFLegendary",
	"FishGCommon",
	"FishGRare",
	"FishGLegendary",
	"FishHCommon",
	"FishHRare",
	"FishHLegendary",
	"FishICommon",
	"FishIRare",
	"FishILegendary",
	"FishNCommon",
	"FishNRare",
	"FishNLegendary",
	"FishOCommon",
	"FishORare",
	"FishOLegendary",
	"FishPCommon",
	"FishPRare",
	"FishPLegendary",
	"FishBCommon",
	"FishBRare",
	"FishBLegendary",
	"FishChaosCommon",
	"FishChaosRare",
	"FishChaosLegendary",

	"MysteryResource",
	"CharonPoints",
	"TrashPoints",

	"MetaPoints", 
	"Gems", 
	"LockKeys", 
	"SuperLockKeys", 
	"SuperGems",
}

ScreenData.InventoryScreen =
{
	Components = {},
	BlockPause = true,

	CategoryStartX = 162,
	CategoryStartY = 149,
	CategorySpacingX = 94,

	CategoryIconScale = 0.45,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	GridStartX = 149,
	GridStartY = 252,
	GridSpacingX = 133.6,
	GridSpacingY = 143,
	GridWidth = 8,

	PinStartX = 637,
	PinStartY = 270,
	PinSpacingY = 143,
	PinResourcesOffsetX = 600,
	PinResourcesOffsetY = 0,
	PinIconOffsetX = -442,
	PinIconOffsetY = 0,
	PinIconScale = 0.7,
	PinsPerPage = 5,
	ScrollOffset = 0,
	NumItems = 0,
	PinButtons = {},

	LineHistorySpacingY = 250,
	LineHistoryScrollbarSliderTopY = 280,
	LineHistoryScrollbarSliderBottomY = 844,

	IconMouseOverScale = 1.33,
	
	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 16,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval= 0.1,
	},

	LineHistoryScrollSpeed = 400,
	UpdateFunctionName = "InventoryScreenUpdate",

	ItemCategories =
	{
		{
			Name = "InventoryScreen_ResourcesTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
			GameStateRequirements =
			{
				-- None
			},
			"MetaCurrency",
			"MetaCardPointsCommon",
			"MemPointsCommon",
			"MetaFabric",

			"OreFSilver",
			"OreGLime",
			"OreHGlassrock",
			"OreIMarble",
			"OreNBronze",
			"OreOIron",
			"OreChaosProtoplasm",

			"MixerFBoss",
			"MixerGBoss",
			"MixerHBoss",
			"MixerIBoss",
			"MixerNBoss",

			"Mixer6Common",
			"MixerShadow",
			"MixerMythic",

			"CardUpgradePoints",
			"Mixer5Common",
			"WeaponPointsRare",

			"CosmeticsPointsCommon",
			"CosmeticsPointsRare",
			"CosmeticsPointsEpic",

			"TrashPoints",
		},
		{
			Name = "InventoryScreen_GardenTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Reagents",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny =
					{
						"PlantMoney",
						"PlantFNightshadeSeed",
						"PlantGCattailSeed",
						"PlantHWheatSeed",
						"PlantIPoppySeed",
						"PlantNGarlicSeed",
						"PlantOMandrakeSeed",
						"PlantChaosThalamusSeed",
						"PlantGrowthAccelerant",
						"PlantFMoly",
						"SeedMystery",
						"PlantGLotus",
						"PlantNMoss",
						"PlantODriftwood",
						"PlantHMyrtle",
						"PlantIShaderot",
						"PlantFNightshade",
						"PlantGCattail",
						"PlantHWheat",
						"PlantIPoppy",
						"PlantNGarlic",
						"PlantOMandrake",
						"PlantChaosThalamus",
					},
				}
			},
			"PlantFMoly",
			"PlantFNightshade",
			"PlantFNightshadeSeed",
			"PlantMoney",
			"SeedMystery",
			"PlantGLotus",
			"PlantGCattail",
			"PlantGCattailSeed",
			"PlantHMyrtle",
			"PlantHWheat",
			"PlantHWheatSeed",
			"PlantIShaderot",
			"PlantIPoppy",
			"PlantIPoppySeed",
			"PlantNMoss",
			"PlantNGarlic",
			"PlantNGarlicSeed",
			"PlantODriftwood",
			"PlantOMandrake",
			"PlantOMandrakeSeed",
			"PlantChaosThalamus",
			"PlantChaosThalamusSeed",
			"PlantGrowthAccelerant",
			"MixerOBoss",
		},
		{
			Name = "InventoryScreen_GiftsTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Gifts",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny = { "GiftPoints", "GiftPointsRare", "GiftPointsEpic", "FamiliarPoints", "SuperGiftPoints", "CharonPoints" },
				}
			},
			"GiftPoints",
			"GiftPointsRare",
			"GiftPointsEpic",
			"SuperGiftPoints",
			"FamiliarPoints",
			"CharonPoints",
		},
		{
			Name = "InventoryScreen_FishTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Fish",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained" },
					HasAny = { "FishFCommon", "FishFRare", "FishFLegendary", "FishGCommon", "FishGRare", "FishGLegendary", "FishHCommon", "FishHRare", "FishHLegendary", "FishICommon", "FishIRare", "FishILegendary", "FishNCommon", "FishNRare", "FishNLegendary", "FishOCommon", "FishORare", "FishOLegendary", "FishPCommon", "FishPRare", "FishPLegendary", "FishBCommon", "FishBRare", "FishBLegendary", "FishChaosCommon", "FishChaosRare", "FishChaosLegendary", },		}
			},
			"FishFCommon",
			"FishFRare",
			"FishFLegendary",
			"FishGCommon",
			"FishGRare",
			"FishGLegendary",
			"FishHCommon",
			"FishHRare",
			"FishHLegendary",
			"FishICommon",
			"FishIRare",
			"FishILegendary",
			"FishNCommon",
			"FishNRare",
			"FishNLegendary",
			"FishOCommon",
			"FishORare",
			"FishOLegendary",
			"FishPCommon",
			"FishPRare",
			"FishPLegendary",
			"FishBCommon",
			"FishBRare",
			"FishBLegendary",
			"FishChaosCommon",
			"FishChaosRare",
			"FishChaosLegendary",
		},
		{
			Name = "InventoryScreen_PinTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-ForgetMeNots",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
			Background = "GUI\\Screens\\Inventory\\Backing_ForgetMeNots",
			OpenFunctionName = "InventoryScreenDisplayPins",
			CloseFunctionName = "InventoryScreenHidePins",
			GamepadNavigation =
			{
				ExclusiveInteractGroup = "Combat_Menu_Overlay",
				FreeFormSelectWrapY = false,
				FreeFormSelectGridLock = true,
				FreeFormSelectStepDistance = 16,
				FreeFormSelectSuccessDistanceStep = 8,
				FreeFormSelectRepeatDelay = 0.6,
				FreeFormSelectRepeatInterval= 0.1,
			},
		},
		{
			Name = "InventoryScreen_LineHistoryTab",
			Icon = "GUI\\Screens\\Inventory\\Icon-Log",
			GameStateRequirements =
			{
				{
					--PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning", },
				},
			},
			Background = "GUI\\Screens\\Inventory\\Backing_Log",
			OpenFunctionName = "InventoryScreenDisplayLineHistory",
			CloseFunctionName = "InventoryScreenHideLineHistory",
			AlwaysShowScrollArrows = true,
			GamepadNavigation =
			{
				ExclusiveInteractGroup = "Combat_Menu_Overlay",
				FreeFormSelectWrapY = false,
				FreeFormSelectGridLock = true,
				FreeFormSelectStepDistance = 16,
				FreeFormSelectSuccessDistanceStep = 8,
				FreeFormSelectRepeatDelay = 0.6,
				FreeFormSelectRepeatInterval= 0.1,
			},
		},
	},

	ResourceCountFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		Color = Color.White,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = 0, OffsetY = 58,
		Justification = "Center",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinNameAffordableFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 28,
		Color = Color.CostAffordableShop,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -350, OffsetY = 0,
		Justification = "Left",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinNameUnaffordableFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 28,
		Color = Color.CostUnaffordable,
		ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		OffsetX = -350, OffsetY = 0,
		Justification = "Left",
		FadeTarget = 1.0, FadeOpacity = 1.0,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	CostDisplay =
	{
		StartX = 1557,
		StartY = 540,
		SpacerX = 160,
		SpacerY = 250,
		ItemsPerRow = 2,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},

	FreeFormSelectOffsetX = -530,
	FreeFormSelectOffsetY = 0,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",

		Order =
		{
			"BackgroundTint",
			"ActionBarBackground",
			"Background",
			"MoonPhaseButton",
			"MoonPhaseButtonHighlight",
			"LineHistory",
			"LineHistoryGradient",
			"LineHistoryScrollbar",
			"LineHistoryScrollbarSlider",
		},

		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.75,
			AlphaTargetDuration = 0.25,
		},

		Background = 
		{
			AnimationName = "GUI\\Screens\\Inventory\\Backing",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				CategoryTitleText = 
				{
					TextArgs =
					{
						FontSize = 26,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						OffsetX = -830, OffsetY = -444,
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					},
				},

				InfoBoxName =
				{
					OffsetX = 360,
					OffsetY = -390,
					TextArgs =
					{
						FontSize = 32,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
				InfoBoxDescription =
				{
					OffsetX = 360,
					OffsetY = -310,
					TextArgs =
					{
						FontSize = 24,
						Color = Color.White,
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						LineSpacingBottom = 2,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						VariableAutoFormat = "BoldFormatGraft",
					}
				},
				InfoBoxDetails =
				{
					OffsetX = 360,
					OffsetY = -170,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.HecateVoice,
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 2,
						VariableAutoFormat = "BoldFormatGraft",
						TextSymbolScale = 0.80,
					}
				},
				InfoBoxFlavor =
				{
					OffsetX = 360,
					OffsetY = 225,
					TextArgs =
					{
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 475,
						FontSize = 20,
						Color = Color.FlavorTextPurple,
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2},
						Justification = "Left",
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
				
				MoonPhaseButton =
				{
					Graphic = "ButtonMoonPhase",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.5,
					OffsetX = 100,
					OffsetY = -435,
					Data =
					{
						OnMouseOverFunctionName = "InventoryScreenMoonPhaseButtonMouseOver",
						OnMouseOffFunctionName = "InventoryScreenMoonPhaseButtonMouseOff",
					},
					Text = "Inventory_MoonPhase",
					TextArgs =
					{
						Hide = true,
					},
					InteractProperties =
					{
						TooltipOffsetX = -300,
						TooltipOffsetY = 50,
					},
				},

				MoonPhaseButtonHighlight =
				{
					OffsetX = 100,
					OffsetY = -435,
					Alpha = 0.0,
					AnimationName = "GUI\\Screens\\MoonPhases\\MoonPhase_Highlight",
				},
			},
		},

		EmptyCategoryHint =
		{
			X = 620,
			Y = 480,
			Text = "InventoryScreen_NoPinsHint",
			TextArgs =
			{
				FontSize = 30,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center",
				VerticalJustification = "Top",
				Width = 900,
				FadeOpacity = 0.0,
				FadeTarget = 0.0,
			}
		},

		LineHistory =
		{
			X = 160,
			Y = 250,
			TextArgs =
			{
				Color = Color.White,
				FontSize = 20,
				Width = 940,
				Height = 600,
				Font = "LatoMediumEventLog",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
				DataProperties =
				{
					UseLineFading = true,
					OpacityWithOwner = true,
				},
			}
		},

		LineHistoryGradient =
		{
			AnimationName = "GUI\\Screens\\Inventory\\Text_Gradient",
			GroupName = "HUD_Backing",
			X = 621,
			Y = 406,
			Scale = 0.97,
			Alpha = 0.0,
		},

		LineHistoryScrollbar =
		{
			AnimationName = "PageScrollbar",
			--GroupName = "Combat_Menu_Overlay",
			X = 96,
			Y = 556,
			ScaleY = 1.2,
			Alpha = 0.0,
		},

		LineHistoryScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			--GroupName = "Combat_Menu_Overlay",
			X = 96,
			Y = 560,
			Alpha = 0.0,
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 95,
			Y = 238,
			Alpha = 0.0,
			Scale = 1.0,
			Data =
			{
				OnPressedFunctionName = "InventoryScreenScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			X = 95,
			Y = 875,
			Alpha = 0.0,
			Scale = 1.0,
			Data =
			{
				OnPressedFunctionName = "InventoryScreenScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ScrollRight",
				"ScrollLeft",
				"SelectButton",
				"PinButton",
			},

			Children = 
			{
				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "InventoryScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "InventoryScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						-- Dummy button
					},
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "InvenotryScreenRemovePin",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "InventoryScreen_RemovePin",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseInventoryScreen",
						ControlHotkeys = { "Cancel", },
						MouseControlHotkeys  = { "Cancel", "Inventory", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}