RoomSetData.Test = 
{
	------------- ---- ----------------
	TestDevansh =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	TestingRoom = 
	{
		TestRoom = true,
		DebugOnly = true,
		SpeakerName = "TestingRoom",
	},

	TestEnemies =
	{
		InheritFrom = { "TestingRoom" },
		-- LinkedRooms = { "A_Reprieve01" },
		-- NextRoomSet = { "Tartarus", },

		LegalEncounters = { "TestFight" },
		ChallengeEncounterName = "TimeChallengeTartarus",
		ChallengeSpawnChance = 1.0,
		WellShopSpawnChance = 1.0,
		WellShopRequirements =
		{
			-- None
		},
		ForceChallengeSwitch = true,
		ForceSecretDoor = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		StartUnthreadedEvents =
		{
			{
				FunctionName = "LiveFillInShopOptions",
				Args =
				{
				},
			},
		},
	},

	TestNPCs =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "TestNPCs" },
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		Ambience = "/Leftovers/Ambience/BurningAmbience",
		Music = "/Music/MusicRunstart_MC",
		MusicActiveStems = { "Bass", "Guitar" },
		MusicMutedStems = { "Drums" },
		InspectPoints =
		{
			[370000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
				},
			},
		},

		PostUnthreadedEvents =
		{
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},
	},

	TestJoshRoomEnemyTest =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "CombatTestJosh" },
	},

	TestAlice =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
	},

	TestJen =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
		ZoomFraction = 0.67,
	},

	TestJoanne =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
	},

	TestTuning =
	{
		InheritFrom = { "TestingRoom" },
		-- LinkedRooms = { "A_Reprieve01" },
		-- NextRoomSet = { "Tartarus", },
		SecretSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,

		LegalEncounters = { "TuningFight" },
	},

	TestEduardo =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		--[[UnthreadedEvents =
		{
			{ FunctionName = "BeginTestRoomInro"},
		},]]--
	},

	TestAnimations =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		ThreadedEvents =
		{
			{ FunctionName = "AnimateOnDistance", Args = {AnimationName = "MelinoeRun", Name = "NPC_Hades_01", Distance = 500} },
		},
	},

	TestCharacters =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		NoReward = true,
		ZoomFraction = 1.0,
		KeepsakeFreeSwap = true,
		AlwaysAllowLootInteraction = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		PreActivatedSkipAISetup = true,
	},

	TestAllThings =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		NoReward = true,
		ZoomFraction = 0.75,
		KeepsakeFreeSwap = true,
		AlwaysAllowLootInteraction = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		AllowInventoryInCombat = true,
		SecretSpawnChance = 1.0,
		ChallengeSpawnChance = 1.0,
		WellShopSpawnChance = 1.0,
		WellShopRequirements =
		{
			-- None
		},
		ForceSecretDoor = true,
		ForceChallengeSwitch = true,
		StartUnthreadedEvents =
		{
			{
				FunctionName = "AddResources",
				Args =
				{
					GiftPoints = 9,
				},
			},
			{
				FunctionName = "AddRerolls",
				Args =
				{
					Amount = 999,
				},
			},
			{
				FunctionName = "DebugUnlockMetaUpgrades",
				Args =
				{
					UpgradeNames =
					{
						"ScreenReroll",
					},
				},
			},
			{
				FunctionName = "UnlockAllWeapons",
			},
			{
				FunctionName = "AssignWeaponKits",
				Args =
				{
					IgnoreRequirements = true,
				},
			},
			{
				FunctionName = "SpawnAllLoot",
				Args =
				{
					StripInteractTextRequirements = true,
					RespawnAfterUse = true,
					WipeRecordsAfterUse = true,
					StopAnimations = { "BoonOrbSpawn", "BoonOrbSpawn2", "PickupFlare", "PickupFlareA", "PickupFlareA2", "PickupFlareB01", "PickupFlareB02" },
				},
			},
			{
				FunctionName = "DebugSpawnConsumables",
				Args =
				{
					Names =
					{
						-- Money
						"RoomMoneyDrop",
						"RoomMoneyBigDrop",
						"RoomMoneyTripleDrop",
						"RoomMoneySmallDrop",
						"RoomMoneyTinyDrop",

						-- Healths
						"MaxHealthDrop",
						"MaxHealthDropSmall",
						"MaxHealthDropBig",
						"EmptyMaxHealthDrop",
						"EmptyMaxHealthSmallDrop",

						-- Mana
						"MaxManaDrop",
						"MaxManaDropSmall",
						"MaxManaDropBig",

						-- Talents
						"TalentDrop",
						"MinorTalentDrop",
						"TalentBigDrop",

						-- Healing
						"RoomRewardHealDrop",
						"HealBigDrop",
						"HealDropMajor",
						"RoomRewardConsolationPrize",

						-- Partial rewards
						"StoreRewardRandomStack",
						"RerollDrop",
						"LastStandDrop",
						"ArmorBoost",
						"ArmorBigBoost",
						"FireBoost",
						"AirBoost",
						"EarthBoost",
						"WaterBoost",
						"ElementalBoost",

						-- Meta, basic
						"MetaCardPointsCommonDrop",
						"MetaCardPointsCommonBigDrop",
						"MemPointsCommonDrop",
						"MemPointsCommonBigDrop",
						"MetaCurrencyDrop",
						"MetaCurrencyBigDrop",
						"GiftDrop",

						-- Meta, harvest/misc
						"OreFSilverDrop",
						"PlantFMolyDrop",
						"PlantFNightshadeDrop",
						"PlantGLotusDrop",
						"MetaFabricDrop",
						"TrashPointsDrop",

						-- Meta, boss
						"MixerFBossDrop",
						"MixerGBossDrop",
						"MixerHBossDrop",
						"MixerIBossDrop",
						"MixerNBossDrop",
						"MixerOBossDrop",
						"MixerPBossDrop",
						"MixerQBossDrop",
						"Mixer5CommonDrop",
						"Mixer6CommonDrop",

						-- Meta, advanced
						"WeaponPointsRareDrop",
						"CardUpgradePointsDrop",
						"FamiliarPointsDrop",
						"CharonPointsDrop",
						"GemPointsDrop",
						"GemPointsBigDrop",

						-- Healing, no interact
						"HealDrop",
						"HealDropMinor",
						"HealDropSuperMinor",

						-- From Traits
						--"MedeaMoneyTinyDrop",
						--"PowerDrinkDrop",
						--"BloodDrop",
						--"ManaDropMinorPoseidon",
						--"ManaDropMinor",
						--"ManaDropZeus",
						--"ManaDropMinorHound",
					},
					HideWorldTextOverride = false,
				},
			},
			{
				FunctionName = "CreateNPCSpawnButtons",
				Args =
				{
					SpawnButtonIds =
					{
						568880, 568898, 568864, 568862, 568871, 568890, 568874, 568875, 568873, 568863, 568892, 568877, 568891, 568867, 568861, 568895, 568893, 568885, 568882, 568879,
						568889, 568872, 568869, 568878, 568886, 568868, 568859, 568896, 568860, 568870, 568876, 568884, 568883, 568887, 568866, 568888, 568897, 568894, 568865, 568881,
						568903, 568902, 568901, 568900, 568899,
					},
					ExcludeNames = { "NPC_Neutral", "NPC_Giftable", "NPC_Familiar" },
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
			{
				FunctionName = "StripInteractTextRequirements",
				Args =
				{
				},
			},
			{
				FunctionName = "ShowCombatUI",
				Args =
				{
				},
			},
			{
				FunctionName = "LiveFillInShopOptions",
				Args =
				{
				},
			},
			{
				FunctionName = "UnlockEntireCodex",
				Args =
				{
				},
			},
			{
				FunctionName = "UnlockElementalIcons",
				Args =
				{
				},
			},
		},
		ObstacleData =
		{
			[421602] =
			{
				InteractDistance = 200,
				SetupEvents =
				{
					{
						FunctionName = "AddOverheadText",
						Args =
						{
							OverheadText = "Stop",
							OverheadTextFontSize = 26,
							
						},
					},
				},
				OnUsedFunctionName = "AllAIStop",
			},

			[421601] =
			{
				InteractDistance = 200,
				SetupEvents =
				{
					{
						FunctionName = "AddOverheadText",
						Args =
						{
							OverheadText = "Follow",
							OverheadTextFontSize = 26,
							
						},
					},
				},
				OnUsedFunctionName = "AllAIFollow",
			},

			[421632] =
			{
				InteractDistance = 200,
				SetupEvents =
				{
					{
						FunctionName = "AddOverheadText",
						Args =
						{
							OverheadText = "AttackOnce",
							OverheadTextFontSize = 26,
							
						},
					},
				},
				OnUsedFunctionName = "AllAIAttack",
			},

			[421627] =
			{
				InteractDistance = 200,
				OverheadText = "PickEnemySpawn",
				SetupEvents =
				{
					{
						FunctionName = "AddOverheadText",
						Args =
						{
							OverheadText = "PickEnemySpawn",
							OverheadTextFontSize = 26,							
						},
					},
				},
				OnUsedFunctionName = "OpenDebugEnemySpawnScreen",
			},

			[421631] =
			{
				InteractDistance = 200,
				SetupEvents =
				{
					{
						FunctionName = "AddOverheadText",
						Args =
						{
							OverheadText = "SpawnTestCharacter",
							OverheadTextFontSize = 26,							
						},
					},
				},
				OnUsedFunctionName = "DebugSpawnEnemy",
				OnUsedFunctionArgs =
				{
					Name = "TestCharacter",
					Active = true,
				},
			},

			[421635] =
			{
				InteractDistance = 200,
				OverheadText = "EquipTestWeapon",
				OverheadTextFontSize = 22,
				OnUsedFunctionName = "EquipTestWeapon",
				SetupFunctionName = "SetupTestWeaponKit",
				SetupFunctionArgs =
				{
					WeaponName = "WeaponTest",
				}
			},

			[421628] =
			{
				InteractDistance = 200,
				OverheadText = "AnimTest1",
				OverheadTextFontSize = 22,
				OnUsedFunctionName = "AnimTest1",
			},

			[421629] =
			{
				InteractDistance = 200,
				OverheadText = "AnimTest2",
				OverheadTextFontSize = 22,
				OnUsedFunctionName = "AnimTest2",
			},

			[421630] =
			{
				InteractDistance = 200,
				OverheadText = "AnimTest3",
				OverheadTextFontSize = 22,
				OnUsedFunctionName = "AnimTest3",
			},

			-- Card Table / MetaUpgradeWorldObject
			[589766] =
			{
				InteractDistance = 250,
				UseText = "UseMetaUpgradeWorldObject",
				UseSound = "/Leftovers/Menu Sounds/TitanToggleLong",
				OnUsedFunctionName = "OpenMetaUpgradeCardScreen",
				AnimOffsetZ = 120
			},
			-- Weapon Shop
			[558210] =
			{
				Name = "WeaponShop",
				InteractDistance = 250,
				InteractOffsetX = 50,
				AnimOffsetZ = 150,
				UseText = "UseWeaponShop",
				OnUsedFunctionName = "UseWeaponShop",
			},

			-- BountyBoard / Bounty Board / Pitch-Black Stone
			[561146] =
			{
				Name = "BountyBoard",
				InteractDistance = 200,
				AnimOffsetZ = 200,
				UseText = "UseBountyBoard",
				UseSound = "/SFX/Menu Sounds/GodBoonSlotHighlightShimmerSFX",
				OnUsedFunctionName = "UseBountyBoard",
			},
		}
	},

	TestAndrew =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		NoReward = true,
	},

	TestKristen =
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		NoReward = true,
	},

	TestSort = 
	{
		InheritFrom = { "BaseRoom", "TestingRoom" },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		NoReward = true,
	}
}

AddTableKeysCheckDupes( RoomData, RoomSetData.Test )