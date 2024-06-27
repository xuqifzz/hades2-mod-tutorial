OverwriteTableKeys( TraitData, {
	-- Echo
	BaseEcho = 
	{
		IsEchoBoon = true,
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
		},
		ExtractValues =
		{
			{
				ExtractAs = "LastRewardName",
				Format = "LastRewardTaken",
			},
		}
	},

	EchoLastRunBoon = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_05",
		GameStateRequirements =
		{
				{
					Path = { "CurrentRun", "Hero", "EligiblePrevRunTraits" },
					UseLength = true,
					Comparison = ">",
					Value = 0,
				},
		},
		Hidden = true,
		AcquireFunctionName = "EchoLastRunBoon",
	},

	EchoDeathDefianceRefill = 
	{
		InheritFrom = { "BaseEcho" },
		Icon = "Boon_Echo_03",
		GameStateRequirements =
		{
			NotMaxLastStands = true,
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
		AcquireFunctionName = "EchoIncreaseStats",
		AcquireFunctionArgs = 
		{
			StartFraction = 0.50,
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
})