ObjectiveData =
{
	-- PreRun Weapons
	WeaponDaggerThrowCharged = { Description = "Objective_WeaponDaggerThrowCharged" },
	
	-- Spells
	SpellPolymorphPrompt = { Description = "Objective_UseSpellPolymorph" },
	SpellSummonPrompt = { Description = "Objective_UseSpellSummon" },
	SpellLaserPrompt = { Description = "Objective_UseSpellLaser" },
	SpellPotionPrompt = { Description = "Objective_UseSpellPotion" },
	SpellTimeSlowPrompt = { Description = "Objective_UseSpellTimeSlow" },
	SpellLeapPrompt = { Description = "Objective_UseSpellLeap" },

	-- Main Hub & PreRun
	GiftPrompt = { Description = "Objective_GiveGift", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	UseShrinePrompt = { Description = "Objective_UseShrine" },

	-- Misc
	CardPrompt = { Description = "Objective_CardPrompt", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	KeepsakePrompt = { Description = "Objective_UseKeepsakeRack", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	BountyPrompt = { Description = "Objective_BountyPrompt", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	FamiliarPrompt = { Description = "Objective_FamiliarPrompt", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	ToolPrompt = { Description = "Objective_ToolPrompt", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	HitSkelly = { Description = "Objective_HitSkelly", LuaKey = "SkellyHits", StartingLuaValue = "0", GoalValue = 20 },
	OpenInventorySkelly = { Description = "Objective_OpenInventorySkelly" },
	OpenInventory = { Description = "Objective_OpenInventory", },
	AdvancedTooltipPrompt = { Description = "Objective_AdvancedTooltip" },

	ExorcismPrompt = { Description = "Objective_Exorcism", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },

	SurvivalChallenge = { Description = "Objective_SurvivalTimer", LuaKey = "RemainingSeconds", StartingLuaValue = "-" },
}

ObjectiveSetData =
{
	FCastTutorial =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{
				"WeaponCast",
			}
		},
	},

	FCastTutorialInCombat =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{
				"WeaponCast",
			}
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "<=",
				Value = 7,
			},
		},
		StartDelay = 1.7,
	},

	StaffTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "WeaponStaffSwing",
		Objectives =
		{
			{
				"WeaponStaffSwing",
				"WeaponStaffBall",
				"WeaponCast",
				"WeaponBlink",
				"WeaponStaffDash",
				"WeaponStaffSwing5",
				"WeaponStaffBall2",
				"WeaponCastArm",
			}
		},
	},

	DaggerTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "WeaponDagger",
		Objectives =
		{
			{
				"WeaponDagger",
				"WeaponDaggerThrow",
				"WeaponCast",
				"WeaponBlink",
				"WeaponDaggerDash",
				"WeaponDagger5",
				"WeaponDaggerThrowCharged",
				"WeaponCastArm",
			}
		},
	},

	ToolPrompt =
	{
		Objectives =
		{
			{ "ToolPrompt" }
		},
		GameStateRequirements =
		{
			-- @ temporarily disabled, tools autoequip currently...
			{
				Path = { "MapState", "ToolKits" },
				UseLength = true,
				Comparison = ">=",
				Value = 9999,
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			},
		},
		StartDelay = 1.25,
	},

	CardPrompt =
	{
		Objectives =
		{
			{ "CardPrompt" }
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			}
		},
		StartDelay = 1.25,
	},

	KeepsakePrompt =
	{
		Objectives =
		{
			{ "KeepsakePrompt" }
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			}
		},
		StartDelay = 1.25,
	},

	GiftPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_Main"
			},
			{
				Path = { "GameState", "Resources", "GiftPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
				Comparison = "<",
				Value = 1,
			},
		},
		Objectives =
		{
			{ "GiftPrompt" }
		},
		StartDelay = 5.75,
	},

	SkellyHitQuest =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "HitSkelly", "WeaponStaffSwing", "WeaponStaffBall", "WeaponCast", "WeaponBlink", "WeaponStaffSwing5", "WeaponStaffBall2", "WeaponCastArm" }
		},
	},
	SkellyCastQuest =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "WeaponCast", "WeaponCastArm" }
		},
	},
	SkellySprintQuest =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "WeaponBlink" }
		},
	},
	SkellyShadeMercQuest =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "ShadeMercSpiritball" },
		},
	},
	SkellyInventoryQuest =
	{
		ManualActivationOnly = true,

		OverrideExistingObjective = true,
		Objectives =
		{
			{ "OpenInventorySkelly" }
		},
		StartDelay = 1.0,
	},

	OpenInventory =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "OpenInventory" },
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" }
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "~=",
				Value = "Hub_PreRun"
			},
		}
	},

	ExorcismPrompt =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "ExorcismPrompt" }
		},
	},

	AdvancedTooltipPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "AdvancedTooltipPrompt" }
		},
		GameStateRequirements =
		{
			RequiredTraitCount = 5,
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Story01" },
			},
		},
		StartDelay = 0.66,
	},
	SpellPolymorphPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Polymorph",
		Objectives =
		{
			{ "SpellPolymorphPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellSummonPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Summon",
		Objectives =
		{
			{ "SpellSummonPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellLaserPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Laser",
		Objectives =
		{
			{ "SpellLaserPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellPotionPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Potion",
		Objectives =
		{
			{ "SpellPotionPrompt" }
		},
		StartDelay = 0.66,
	},	
	SpellTimeSlowPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "TimeSlow",
		Objectives =
		{
			{ "SpellTimeSlowPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellLeapPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Leap",
		Objectives =
		{
			{ "SpellLeapPrompt" }
		},
		StartDelay = 0.66,
	},
}

