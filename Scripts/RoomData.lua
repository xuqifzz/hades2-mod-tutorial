RoomEventData =
{
	BountyInfoBannerArgs =
	{
		ActiveBountyOverrides =
		{
			Delay = 0.45,
			Duration = 1.85,
			AnimationName = "LocationBackingIrisChaosIn",
			AnimationOutName = "LocationBackingIrisChaosOut",
			AppearSound = "/SFX/ChaosBoonChoice",
		},
	},

	EntranceFunctionNamePriorities =
	{
		"RoomEntranceCrawlerMiniBoss",
		"EntranceFromAnomalyPresentation",
		"RoomEntrancePortal",
		"ShipsRoomEntrancePresentation",
	},

	ExitFunctionNamePriorities =
	{
		"LeaveRoomSecretDoorPresentation",
		"LeaveRoomHPostBossPresentation",
	},

	GlobalRoomStartEvents =
	{
		{
			FunctionName = "HandleBreakableSwap",
			Args = {},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBreakableValue1" },
				},
			},
		},
	},

	GlobalRoomInputUnblockedEvents =
	{
		{
			Threaded = true,
			FunctionName = "FamiliarSetup",
			Args =
			{
				WaitForInput = true,
				Wait = 0.5,
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EquippedFamiliar", },
				},
			},
		},
	},

	GlobalRoomPostCombatReloadInputUnblockedEvents =
	{
		{
			FunctionName = "FamiliarSetup",
			Args =
			{
				Silent = true,
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EquippedFamiliar", },
				},
			},
		},
	},
}

RoomSetData.Base =
{
	BaseRoom =
	{
		DebugOnly = true,
		SecretSpawnChance = 0.2,
		SecretDoorRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_PreBoss01", "F_Boss01", "F_Boss02", "F_Boss03", "G_PreBoss01", "G_Boss01", "H_PreBoss01", "H_Boss01", "I_PreBoss01", "I_Boss01", "N_PreBoss01", "N_Boss01", "P_PreBoss01", "P_Boss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "I", "O", "Q" },
			},
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},
		ShrinePointDoorSpawnChance = 0.3,
		ShrinePointDoorRequirements =
		{
			RequiredCosmetics = { "ShrinePointGates", },
		},
		TimeChallengeSwitchSpawnChance = 0.25,
		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitches1" },
			},
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		TimeChallengeEncounterOptions = { "TimeChallengeF" },

		CapturePointSwitchSpawnChance = 0.0,
		CapturePointSwitchRequirements =
		{
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		CapturePointEncounterOptions = { "CapturePointF" },

		PerfectClearSwitchSpawnChance = 0.0,
		PerfectClearSwitchRequirements =
		{
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		PerfectClearEncounterOptions = { "PerfectClearF" },
		WellShopSpawnChance = 0.15,
		WellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWellShops" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
 				Path = { "CurrentRun", "BiomesReached" },
				HasNone = { "N" },
			},
			RequiredMinRoomsSinceWellShop = 4,
		},
		SurfaceShopSpawnChance = 0.0,
		SurfaceShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSurfaceShops" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				SumPrevRooms = 3,
				Path = { "SurfaceShop" },
				CountPathTrue = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		AnomalyDoorChance = 0.06, -- Set in each biomes XBase_Combat room data
		AnomalyDoorChanceFirstInstance = 0.33,
		AnomalyDoorRequirements =
		{
			{
				PathFalse = { "CurrentRun", "BiomesReached", "Anomaly" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Shop01", "G_Story01", "G_PreBoss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatG", "NemesisRandomEvent" },
			},
			{
				PathTrue = { "GameState", "BiomeVisits", "G" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "G" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ChronosFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" }
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosFirstMeeting" },
			},
		},

		MinDepthBeforeIntros = 3,
		LockedUseSound = "/Leftovers/World Sounds/Caravan Interior/ChestClose",
		UnlockedUseSound = "/Leftovers/SFX/DoorClose",
		UsePromptOffsetX = 10,
		UsePromptOffsetY = -50,
		StopSecretMusic = true,
		IntroSequenceDuration = 0.1,
		HarvestBlockedText = "ExorcismBlockedByFieldsLoot",
	},

	BiomeStartRoom = 
	{
		DebugOnly = true,
		BiomeStartRoom = true,
	},

	------------- IRIS ----------------
	_FTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_GTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_HTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
		SoftClamp = 0.75,
	},
	_ITemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_NTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_OTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_OTemplateRoomSmall =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_OTemplateRoomMedium =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_OTemplateRoomLarge =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_PTemplateRoomExterior =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_PTemplateRoomInterior =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},

}

AddTableKeysCheckDupes( RoomData, RoomSetData.Base )
