ObjectiveData =
{
	-- PreRun Weapons
	WeaponDaggerThrowCharged = { Description = "Objective_WeaponDaggerThrowCharged" },
	WeaponLobPickup = { Description = "Objective_WeaponLobPickup" },
	WeaponLobSpecialCharged = { Description = "Objective_WeaponLobSpecialCharged" },
	WeaponTorchCharged = { Description = "Objective_WeaponTorchCharged" },
	WeaponTorchSpecialCharged = { Description = "Objective_WeaponTorchSpecialCharged" },
	WeaponAxeSpecialSwing = { Description = "Objective_WeaponAxeSpecialSwing" },
	WeaponLobCharged = { Description = "Objective_WeaponLobCharged" },
	
	WeaponSuitRangedCharged = { Description = "Objective_WeaponSuitRangedCharged" },
	
	-- Spells
	SpellPolymorphPrompt = { Description = "Objective_UseSpellPolymorph" },
	SpellSummonPrompt = { Description = "Objective_UseSpellSummon" },
	SpellLaserPrompt = { Description = "Objective_UseSpellLaser" },
	SpellPotionPrompt = { Description = "Objective_UseSpellPotion" },
	SpellTimeSlowPrompt = { Description = "Objective_UseSpellTimeSlow" },
	SpellLeapPrompt = { Description = "Objective_UseSpellLeap" },
	SpellMeteorPrompt = { Description = "Objective_UseSpellMeteor" },
	SpellTransformPrompt = { Description = "Objective_UseSpellTransform" },

	-- Main Hub & PreRun
	GiftPrompt = { Description = "Objective_GiveGift", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },
	UseShrinePrompt = { Description = "Objective_UseShrine" },
	UseSurfaceDoor = { Description = "Objective_UseSurfaceDoor" },
	DoraDecorationIntroPrompt = { Description = "Objective_SaluteDora" },


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
	Flashback02Prompt = { Description = "Objective_AnomalyStart" },

	ExorcismPrompt = { Description = "Objective_Exorcism", StartingScaleTarget = 0.7, PostDisplayWait = 1.5 },

	SurvivalChallenge = { Description = "Objective_SurvivalTimer", LuaKey = "RemainingSeconds", StartingLuaValue = "-" },

	BountyAdvancedTooltip = { Description = "Objective_BountyAdvancedTooltip" },
	CheckFamiliarInfoPrompt = { Description = "Objective_CheckFamiliarInfoPrompt" },
	ActivateCatFamiliar = { Description = "Objective_ActivateCatFamiliar" },
	CheckFamiliarUpgradeInfoPrompt = { Description = "Objective_CheckFamiliarUpgradeInfoPrompt" },
	FamiliarUpgradePrompt = { Description = "Objective_FamiliarUpgradePrompt" },

	ThanatosKills = { Description = "Objective_ThanatosKills", LuaKey = "ThanatosKills", StartingLuaValue = "0" },
	NemesisBet = { Description = "Objective_NemesisBet", GoalValue = 100 },
	NemesisKills = { Description = "Objective_NemesisKills", LuaKey = "NemesisKills", StartingLuaValue = "0" },
	PlayerKills = { Description = "Objective_PlayerKills", LuaKey = "PlayerKills", StartingLuaValue = "0" },


	HeraclesMoney = { Description = "Objective_HeraclesMoney", LuaKey = "HeraclesMoney", StartingLuaValue = "0" },
	PlayerMoney = { Description = "Objective_PlayerMoney", LuaKey = "PlayerMoney", StartingLuaValue = "0" },

	BiomeNPylons = { Description = "Objective_BiomeNPylons", LuaKey = "Pylons", StartingLuaValue = "0", GoalValue = 6 },
	TimeChallenge = { Description = "Objective_TimeChallenge" },
	TimeChallengeValue = { Description = "ChallengeSwitch_Value", LuaKey = "RemainingSeconds", StartingLuaValue = "-" },
	ChallengeReward = { Description = "Objective_ChallengeReward" },

	AnomalyStart = { Description = "Objective_AnomalyStart" },

	CapturePointProgress = { Description = "Objective_CapturePointProgress", LuaKey = "CaptureProgress", StartingLuaValue = "15" },

	PerfectClear = { Description = "Objective_PerfectClear" },
	PerfectClearCleanup = { Description = "Objective_PerfectClearCleanup" },

	EliteChallenge = { Description = "Objective_EliteChallenge" },

	NemesisDamageContest = { Description = "Objective_NemesisDamageContest", LuaKey = "TempTextData", StartingLuaValue = { DamageContestAmount = 0, DamageGoal = PresetEventArgs.NemesisDamageContestArgs.DamageGoal }  },

	SkyEntranceInput = { Description = "Objective_SkyEntranceInput" },
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
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
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
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
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

	SuitTutorial =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
		Objectives =
		{
			{
				"WeaponSuit",
				"WeaponSuitRanged",
				"WeaponCast",
				"WeaponBlink",
				"WeaponSuitDash",
				"WeaponSuitCharged",
				"WeaponSuitRangedCharged",
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

	Flashback02Prompt =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "Flashback02Prompt" }
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
			{
				FunctionName = "RequiredTraitCount",
				FunctionArgs = { Count = 5 },
			},
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
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Polymorph", },
			},
		},
		Objectives =
		{
			{ "SpellPolymorphPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellSummonPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Summon", },
			},
		},
		Objectives =
		{
			{ "SpellSummonPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellLaserPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Laser", },
			},
		},
		Objectives =
		{
			{ "SpellLaserPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellPotionPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Potion", },
			},
		},
		Objectives =
		{
			{ "SpellPotionPrompt" }
		},
		StartDelay = 0.66,
	},	
	SpellTimeSlowPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "TimeSlow", },
			},
		},
		Objectives =
		{
			{ "SpellTimeSlowPrompt" }
		},
		StartDelay = 0.66,
	},
	SpellLeapPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Leap", },
			},
		},
		Objectives =
		{
			{ "SpellLeapPrompt" }
		},
		StartDelay = 0.66,
	},
	BiomeNBossUnlock =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "BiomeNPylons" },
		},
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "ObjectiveSets" },
			},
			{
				PathFalse = { "ActiveScreens", "Dialog" },
			},
		}
	},
	
	NemesisChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "NemesisBet", "NemesisKills", "PlayerKills" },
		},
	},

	NemesisDamageContest =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "NemesisDamageContest", },
		},
	},

	AnomalyStart =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "AnomalyStart" },
		},
		StartDelay = 5,
	},

	TimeChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "TimeChallenge" },
			{ "ChallengeReward" },
		},
	},

	CapturePoint =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "CapturePointProgress" },
		},
	},

	PerfectClear =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		HoldUntilEncounterOver = true,
		Objectives =
		{
			{ "PerfectClear" },
			{ "ChallengeReward" },
		},
	},

	EliteChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "EliteChallenge" },
			{ "ChallengeReward" },
		},
	},

	HeraclesChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "HeraclesMoney", "PlayerMoney" },
		},
	},
	
	TorchTutorial =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
		Objectives =
		{
			{
				"WeaponTorch",
				"WeaponTorchSpecial",
				"WeaponCast",
				"WeaponBlink",
				"WeaponTorchCharged",
				"WeaponTorchSpecialCharged",
				"WeaponCastArm",
			}
		},
	},
	AxeTutorial =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
		Objectives =
		{
			{
				"WeaponAxe",
				"WeaponAxeSpecial",
				"WeaponCast",
				"WeaponBlink",
				"WeaponAxeDash",
				"WeaponAxeSpin",
				"WeaponAxeSpecialSwing",
				"WeaponCastArm",
			}
		},
	},
	LobTutorial =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob", },
			},
		},
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RevealCompletedObjectives = true,
		Objectives =
		{
			{
				"WeaponLob",
				"WeaponLobSpecial",
				"WeaponCast",
				"WeaponBlink",
				"WeaponLobPickup",
				"WeaponLobCharged",
				"WeaponLobSpecialCharged",
				"WeaponCastArm",
			}
		},
	},

	FamiliarPrompt =
	{
		Objectives =
		{
			{ "FamiliarPrompt" }
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "Resources", "FamiliarPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_Main"
			},
			{
				PathFalse = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
			},
		},
		StartDelay = 1.25,
	},

	BountyPrompt =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "BountyPrompt" }
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard", },
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			},
			{
				PathFalse = { "GameState", "ScreensViewed", "BountyBoard" },
			},
		},
		StartDelay = 1.25,
	},

	SurfaceDoorPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
			},
		},
		Objectives =
		{
			{ "UseSurfaceDoor" }
		},
		StartDelay = 1.00,
	},

	ShrineUnlockedPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			},
			NamedRequirements = { "ShrineUnlocked" }, 
		},
		Objectives =
		{
			{ "UseShrinePrompt" }
		},
		StartDelay = 1.00,
	},

	CheckFamiliarInfoPrompt =
	{
		ManualActivationOnly =  true,
		Objectives =
		{
			{ "CheckFamiliarInfoPrompt" }
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedObjectiveSets" },
				HasNone = { "CheckFamiliarUpgradeInfoPrompt" }
			},
		},
	},

	ActivateCatFamiliar =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "ActivateCatFamiliar" }
		},
		StartDelay = 0.5,
	},

	CheckFamiliarUpgradeInfoPrompt =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "CheckFamiliarUpgradeInfoPrompt" }
		},
		StartDelay = 0.5,
	},

	FamiliarUpgradePrompt =
	{
		Objectives =
		{
			{ "FamiliarUpgradePrompt" }
		},
		StartDelay = 1.0,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				Comparison = "==",
				Value = "Hub_PreRun"
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" },
			},
			{
				Path = { "GameState", "Resources", "FamiliarPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				FunctionName = "AnyFamiliarUpgradesAvailable",
			},
		},
	},

	BountyAdvancedTooltip =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "BountyAdvancedTooltip" }
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBounty" },
				IsNone = { "PackageBountyChaosIntro" }
			},
		},		
	},

	SpellMeteorPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Meteor", },
			},
		},
		Objectives =
		{
			{ "SpellMeteorPrompt" }
		},
		StartDelay = 0.66,
	},

	SpellTransformPrompt =
	{
		AllowRepeat = false,
		GameStateRequirements =
		{
			{
				FunctionName = "RequireSpellCharged",
				FunctionArgs = { SpellName = "Transform", },
			},
		},
		Objectives =
		{
			{ "SpellTransformPrompt" }
		},
		StartDelay = 0.66,
	},

	DoraDecorationIntroPrompt =
	{
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "DoraDecorationIntroPrompt" }
		},
	},

	SkyEntranceInput =
	{
		ManualActivationOnly = true,
		AllowRepeat = true,
		Objectives =
		{
			{ "SkyEntranceInput" }
		},
	},
}

