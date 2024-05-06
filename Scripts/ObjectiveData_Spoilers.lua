OverwriteTableKeys( ObjectiveData,
{
	-- PreRun Weapons
	WeaponLobPickup = { Description = "Objective_WeaponLobPickup" },
	WeaponLobSpecialCharged = { Description = "Objective_WeaponLobSpecialCharged" },
	WeaponTorchCharged = { Description = "Objective_WeaponTorchCharged" },
	WeaponTorchSpecialCharged = { Description = "Objective_WeaponTorchSpecialCharged" },
	WeaponAxeSpecialSwing = { Description = "Objective_WeaponAxeSpecialSwing" },
	WeaponLobCharged = { Description = "Objective_WeaponLobCharged" },

	-- Spells
	SpellMeteorPrompt = { Description = "Objective_UseSpellMeteor" },
	SpellTransformPrompt = { Description = "Objective_UseSpellTransform" },

	-- Main Hub & PreRun
	UseSurfaceDoor = { Description = "Objective_UseSurfaceDoor" },
	DoraDecorationIntroPrompt = { Description = "Objective_SaluteDora" },

	-- Misc
	BountyAdvancedTooltip = { Description = "Objective_BountyAdvancedTooltip" },
	CheckFamiliarInfoPrompt = { Description = "Objective_CheckFamiliarInfoPrompt" },
	ActivateCatFamiliar = { Description = "Objective_ActivateCatFamiliar" },

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

	NemesisDamageContest = { Description = "Objective_NemesisDamageContest", },
})

OverwriteTableKeys( ObjectiveSetData, 
{
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
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "WeaponTorch",
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
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "WeaponAxe",
		Objectives =
		{
			{
				"WeaponAxe",
				"WeaponAxeBlock2",
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
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "WeaponLob",
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
				PathFalse = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked" },
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
	},

	ActivateCatFamiliar =
	{
		ManualActivationOnly = true,
		Objectives =
		{
			{ "ActivateCatFamiliar" }
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
		RequireSpellCharged = "Meteor",
		Objectives =
		{
			{ "SpellMeteorPrompt" }
		},
		StartDelay = 0.66,
	},

	SpellTransformPrompt =
	{
		AllowRepeat = false,
		RequireSpellCharged = "Transform",
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
})