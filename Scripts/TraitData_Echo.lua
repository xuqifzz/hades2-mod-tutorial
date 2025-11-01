OverwriteTableKeys( TraitData, {
	-- Echo
	BaseEcho = 
	{
		IsEchoBoon = true,
		DebugOnly = true,
	},
	
	EchoLastReward =
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_04",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "LastReward", }
			},
		},
		Hidden = true,
		AcquireFunctionName = "EchoLastReward",
		AcquireFunctionArgs = { LootSourceId = 686219, },
		CodexName = "EchoLastRewardCodex",
		CustomDescriptionFunctionName = "GetEchoLastRewardDescription",
		CustomDescriptionFunctionArgs =
		{
			DefaultId = "EchoLastReward",
			DefaultBoonId = "EchoLastRewardBoon",
		}
	},

	EchoLastRunBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_05",
		NumOfferings = 3, -- used only for text
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "EligiblePrevRunTraits" },
				UseLength = true,
				Comparison = ">",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			},
		},
		Hidden = true,
		AcquireFunctionName = "EchoLastRunBoon",
	},

	EchoDoubleLevelBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_06",
		Hidden = true,
		MultiplierValue = 2, -- used only for text
		AcquireFunctionName = "EchoDoubleLevelBoon",
	},

	EchoDeathDefianceRefill = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_03",
		GameStateRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
		},
		Hidden = true,
		AcquireFunctionName = "EchoRefillLastStands",
		AcquireFunctionArgs = 
		{
			StartFraction = 0.5,
			Decay = 0.1,
			ReportValues = 
			{ 
				ReportedDecay = "Decay",
				ReportedInitialHeal = "StartFraction"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedInitialHeal",
				ExtractAs = "TooltipInitialHeal",
				Format = "Percent"
			},
			{
				Key = "ReportedDecay",
				ExtractAs = "TooltipDecay",
				Format = "NegativePercentDelta"
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
		}
	},
	DiminishingDodgeBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_01",
		SetupFunction = 
		{
			Name = "DiminishingDodgeSetup",
		},
		OnDodgeFunction = 
		{
			FunctionName = "DiminishingDodge",
			RunOnce = true,
			FunctionArgs =
			{
				Cooldown = 0.2,
			},
		},
		InitialDodgeChance = 0.5,
		CurrentDodgeChance = 0.5,
		Decay = 0.02,
		
		TrayStatLines = 
		{
			"CurrentDecayingDodgeStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "CurrentDodgeChance",
				ExtractAs = "TooltipCurrentDodge",
				Format = "Percent",
			},
			{
				Key = "InitialDodgeChance",
				ExtractAs = "TooltipDodge",
				Format = "Percent",
				SkipAutoExtract = true
			},
			{
				Key = "Decay",
				ExtractAs = "TooltipDecay",
				HideSigns = true,
				Format = "Percent",
				SkipAutoExtract = true
			},
		}
	},

	DiminishingHealthAndManaBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_02",
		StatMultiplier = 0,
		AcquireFunctionName = "EchoIncreaseStats",
		AcquireFunctionArgs = 
		{
			StartFraction = 0.60,
			Decay = 0.05,
			ReportValues = 
			{ 
				ReportedDecay = "Decay",
				ReportedMultiplier = "StartFraction"
			},
		},
		PropertyChanges = 
		{
			{
				LuaProperty = "MaxMana",
				ChangeValue = 0,
				ChangeType = "Add",	
				AsInt = true,
			},
			{
				LuaProperty = "MaxHealth",
				ChangeValue = 0,
				ChangeType = "Add",
				AsInt = true,
			}
		},
		TrayStatLines = 
		{
			"CurrentDiminishingStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "BonusMultiplier",
				Format = "Percent"
			},
			{
				Key = "ReportedDecay",
				ExtractAs = "TooltipDecay",
				HideSigns = true,
				Format = "Percent"
			},
			{
				Key = "StatMultiplier",
				ExtractAs = "TooltipCurrentStatBonus",
				HideSigns = true,
				Format = "Percent"
			},
		}
	},

	EchoDoubleShop = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_08",
		RemainingUses = 1,
		DuplicateWorldShopItem = true,
	},
	-- Legendary
	EchoRepeatKeepsakeBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_07",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "AthenaEncounterKeepsake", "HadesAndPersephoneKeepsake", "EscalatingKeepsake", "FountainRarityKeepsake" },
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" },
			},
		},
		CustomTrayText = "EchoRepeatKeepsakeBoon_Tray",
		ActivatedTrayText = "EchoRepeatKeepsakeBoon_Inactive",
		RepeatedKeepsake = "",
		AcquireFunctionName = "EchoRepeatKeepsake",
		ExtractValues =
		{
			{
				Format = "SlottedBoon",
				Slot = "Keepsake",
				ExtractAs = "CurrentKeepsake",
			},
		},
		FlavorText = "EchoRepeatKeepsakeBoon_FlavorText",
	},
})