LootSetData.Loot =
{
	BaseSoundPackage =
	{
		SelectionSound = "/SFX/Menu Sounds/GeneralWhooshMENU",
		ConfirmSound = "/SFX/Menu Sounds/GodBoonChoiceConfirm",
		DebugOnly = true,
	},

	BaseLoot =
	{
		UsePromptOffsetX = 75,
		UsePromptOffsetY = 44,
		DebugOnly = true,
		GodLoot = true,

		GoldConversionEligible = true,
		ReplaceSpecialForGoldify = true,
		GoldifyValue = 400,
		
		AnimOffsetZ = 80,
		TextLinesIgnoreQuests = true,
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs =
		{
			PreserveContextArt = true,
		},
		UseText = "UseLoot",
		UseTextTalkAndGift = "UseLootAndGift",
		UseTextTalkAndSpecial = "UseLootAndSpecial",
		UseTextTalkGiftAndSpecial = "UseLootGiftAndSpecial",
		ManualRecordUse = true,
		DestroyOnPickup = true,
		LastRewardEligible = true,
		BanUnpickedBoonsEligible = true,
		RequireUseToGift = true,

		BackgroundAnimation = "DialogueBackground_Olympus_BoonScreen",
		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NarrativeContextArt = "DialogueBackground_Olympus",
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},
		NarrativeContextArtFlippable = false,
		BlockedLootInteractionText = "UseLootLocked",


		DuoPickupTextLinesRequirements =
		{
			{
				PathFalse = { "CurrentRun", "HadDuoConversation" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP", },
			},
		},

		BoughtTextLinesRequirements =
		{
			{
				PathFalse = { "CurrentRun", "HadBoughtLootConversation" },
			},
			NamedRequirementsFalse = { "StandardPackageBountyActive", "JustBeforeOrAfterTrueEnding" },
		},
	},

	-- Pom of Power
	StackUpgrade =
	{
		InheritFrom = { "BaseSoundPackage", "BaseLoot" },
		-- GameStateRequirements handled in RunProgress table
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = false,
		PurchaseText = "Shop_UseStackUpgrade",
		UseText = "UseStackUpgrade",
		UseTextTalkAndSpecial = "UseStackUpgradeAndConsume",
		BlockedLootInteractionText = "UseStackUpgradeLocked",
		DebugOnly = true,
		GodLoot = false,
		Weight = 10,
		Icon = "BoonSymbolPom",
		DoorIcon = "StackUpgradePreview",
		TradeIcon = "StackUpgradeTrade",
		Color = { 255, 255, 255, 255 },
		LightingColor = {255, 255, 255, 255},
		LootColor = {255, 255, 255, 255},
		BoonGetColor = {255, 0, 20, 255},
		StackOnly = true,
		MenuTitle = "StackUpgradeChoiceMenu_Title",
		EchoLastRewardId = "EchoLastRewardBoon_StackUpgrade",
		SpawnSound = "/SFX/PomegranatePowerUpDrop",
		PortraitEnterSound = "/SFX/PomegranatePowerUpDrop",
		UpgradeSelectedSound = "/SFX/PomUpgradeChoice",
		PickupFunctionName = "StackUpgradePickupPresentation",
		CanDuplicate = true,
		BanUnpickedBoonsEligible = false,
		UseNarrativeContextArt = true,

		GoldConversionEligible = true,
		ReplaceSpecialForGoldify = true,
		GoldifyValue = 300,

		FlavorTextIds =
		{
			"StackUpgrade_FlavorText01",
			"StackUpgrade_FlavorText02",
			"StackUpgrade_FlavorText03",
		},

		FirstSpawnVoiceLines =
		{
			PreLineWait = 0.7,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			{ Cue = "/VO/Melinoe_1286", Text = "A Pom of Power...!", PlayFirst = true },
		},

		OnSpawnVoiceLines =
		{
			-- surface appearances
			{
				PlayOnce = true,
				PreLineWait = 0.7,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", "O", "P" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
					{
						Path = { "GameState", "UseRecord", "StackUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = GameData.CombatNPCEncounters,
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/MelinoeField_1369", Text = "These Poms are even here..." },
			},
		},

		PickupVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.55,
			SuccessiveChanceToPlayAll = 0.66,
			CooldownTime = 6,

			-- TKTK
		},

		SlottedVoiceLines =
		{

		},
	},

	StackUpgradeBig =
	{
		InheritFrom = { "StackUpgrade", },
		DoorIcon = "StackUpgradeBigPreview",
		StackNum = 2,
		GoldifyValue = 400,
	},
	StackUpgradeTriple =
	{
		InheritFrom = { "StackUpgrade", },
		DoorIcon = "StackUpgradeTriplePreview",
		StackNum = 3,
		GoldifyValue = 500,
	},	

	-- Daedalus Hammer
	WeaponUpgrade =
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		-- GameStateRequirements handled in RunProgress table
		BackgroundAnimation = "HammerScreen_In",
		GodLoot = false,
		CanReceiveGift = false,
		ForceCommon = true,
		UseText = "UseWeaponUpgrade",
		UseTextTalkAndSpecial = "UseWeaponUpgradeAndConsume",
		BlockedLootInteractionText = "UseWeaponUpgradeLocked",
		PurchaseText = "Shop_UseWeaponUpgrade",
		DebugOnly = true,
		Weight = 10,
		Icon = "BoonSymbolHammer",
		TradeIcon = "WeaponUpgradeTrade",
		DoorIcon = "WeaponUpgradePreview",
		BackgroundColor = { 255, 78, 0, 65 },
		Color = { 266, 125, 223, 255 },
		LightingColor = { 29, 84, 175, 255 },
		LootColor = {255, 255, 255, 255},
		BoonGetColor = {255, 100, 0, 255},
		MenuTitle = "WeaponUpgradeChoiceMenu_Title",
		EchoLastRewardId = "EchoLastRewardBoon_WeaponUpgrade",
		SurfaceShopText = "WeaponUpgradeDrop_Store",
		SurfaceShopIcon = "WeaponUpgradeShop",
		SpawnSound = "/SFX/WeaponUpgradeHammerDrop2",
		ConfirmSound = "/SFX/WeaponUpgradeHammerPickup",
		PortraitEnterSound = "/SFX/WeaponUpgradeHammerDrop",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",
		BoonInfoTitleText = "Codex_BoonInfo_Title_Hammer",
		BanUnpickedBoonsEligible = false,
		--PickupSound = "/SFX/WeaponUpgradeHammerDrop",
		GoldConversionEligible = true,
		GoldifyValue = 500,

		FlavorTextIds =
		{
			"WeaponUpgrade_FlavorText01",
			"WeaponUpgrade_FlavorText02",
			"WeaponUpgrade_FlavorText03",
		},

		PriorityUpgrades = {},
		WeaponUpgrades = {},
		Traits =
		{
			"StaffDoubleAttackTrait",
			"StaffLongAttackTrait",
			"StaffDashAttackTrait",
			"StaffTripleShotTrait",
			"StaffJumpSpecialTrait",
			"StaffExAoETrait",
			"StaffAttackRecoveryTrait",
			"StaffFastSpecialTrait",
			"StaffExHealTrait",
			"StaffSecondStageTrait",
			"StaffPowershotTrait",
			"StaffOneWayAttackTrait",
			-- Aspect Hammers
			"StaffRaiseDeadBigTrait",
			"StaffRaiseDeadDoubleTrait",
			"StaffLoneShadeRespawnTrait",
			"StaffLoneShadeRallyTrait",

			"DaggerBlinkAoETrait",
			"DaggerSpecialJumpTrait",
			"DaggerSpecialLineTrait",
			"DaggerRapidAttackTrait",
			"DaggerSpecialConsecutiveTrait",
			"DaggerBackstabTrait",
			"DaggerSpecialReturnTrait",
			"DaggerSpecialFanTrait",
			"DaggerAttackFinisherTrait",
			"DaggerFinalHitTrait",
			"DaggerChargeStageSkipTrait",
			"DaggerDashAttackTripleTrait",
			-- Aspect Hammers
			"DaggerTripleBuffTrait",
			"DaggerTripleRepeatWomboTrait",
			"DaggerTripleHomingSpecialTrait",

			"AxeSpinSpeedTrait",
			"AxeChargedSpecialTrait",
			"AxeAttackRecoveryTrait",
			"AxeMassiveThirdStrikeTrait",
			"AxeThirdStrikeTrait",
			"AxeRangedWhirlwindTrait",
			"AxeFreeSpinTrait",
			"AxeArmorTrait",
			"AxeBlockEmpowerTrait",
			"AxeSecondStageTrait",
			"AxeDashAttackTrait",
			"AxeSturdyTrait",
			-- Aspect Hammers
			"AxeRallyFrenzyTrait",
			"AxeRallyFirstStrikeTrait",

			"TorchExSpecialCountTrait",
			"TorchSpecialSpeedTrait",
			"TorchAttackSpeedTrait",
			"TorchSpecialLineTrait",
			"TorchSpecialImpactTrait",
			"TorchMoveSpeedTrait",
			"TorchSplitAttackTrait",
			"TorchEnhancedAttackTrait",
			"TorchDiscountExAttackTrait",
			"TorchLongevityTrait",
			"TorchOrbitPointTrait",
			"TorchSpinAttackTrait",
			-- Aspect Hammers
			"TorchAutofireSprintTrait",

			"LobAmmoTrait",
			"LobAmmoMagnetismTrait",
			"LobRushArmorTrait",
			"LobSpreadShotTrait",
			"LobSpecialSpeedTrait",
			"LobSturdySpecialTrait",
			"LobOneSideTrait",
			"LobInOutSpecialExTrait",
			"LobStraightShotTrait",
			"LobPulseAmmoTrait",
			"LobPulseAmmoCollectTrait",
			"LobGrowthTrait",
			-- Aspect Hammers
			"LobGunOverheatTrait",
			"LobGunBounceTrait",
			"LobGunSpecialBounceTrait",
			"LobGunAttackRangeTrait",
			"LobGunAttackDoublerTrait",

			"SuitArmorTrait",
			"SuitAttackSpeedTrait",
			"SuitAttackSizeTrait",
			"SuitAttackRangeTrait",
			"SuitFullChargeTrait",
			"SuitDashAttackTrait",
			"SuitSpecialJumpTrait",
			"SuitSpecialStartUpTrait",
			"SuitSpecialAutoTrait",
			"SuitSpecialBlockTrait",
			"SuitSpecialDiscountTrait",
			"SuitSpecialConsecutiveHitTrait",
			-- Aspect Hammers
			"SuitComboForwardRocketTrait",
			"SuitComboBlockBuffTrait",
			"SuitComboDoubleSpecialTrait",
			"SuitComboDashAttackTrait",
			"SuitPowershotTrait",
		},
		Consumables = {},

		FirstSpawnVoiceLines =
		{
			PreLineWait = 0.7,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			{ Cue = "/VO/Melinoe_0193", Text = "A Daedalus Hammer..." },
		},

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					--
				}
			},

			{ Cue = "/VO/MelinoeField_2578", Text = "An Icarus Hammer...?",
				PlayOnce = true,
				PlayOnceContext = "IcarusHammerFirstSpawnVO",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02"}
					}
				}
			},

		},


		PickupVoiceLines =
		{
			--
		},

		UpgradePickedVoiceLines =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				}
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.05,
				SuccessiveChanceToPlayAll = 0.33,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1978", Text = "My silver shines." },
				{ Cue = "/VO/Melinoe_1979", Text = "Further refined." },
				{ Cue = "/VO/Melinoe_1980", Text = "Imbued with greater strength." },
				{ Cue = "/VO/MelinoeField_0646", Text = "The master-craftsman's gift..." },
				{ Cue = "/VO/MelinoeField_0647", Text = "Feels even sturdier." },
				{ Cue = "/VO/MelinoeField_0648", Text = "I'm grateful, Daedalus.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0649", Text = "Superior might." },
				{ Cue = "/VO/MelinoeField_0650", Text = "Enchanted for the night." },
				{ Cue = "/VO/MelinoeField_0651", Text = "Fine work as always." },

				{ Cue = "/VO/MelinoeField_2579", Text = "I'm grateful, Icarus.",
					PlayOnceThisRun = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02"}
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
						},
					}
				},
				{ Cue = "/VO/MelinoeField_2580", Text = "You out there, Icarus?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02"}
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "N" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
						},
					}
				},
				{ Cue = "/VO/MelinoeField_2581", Text = "Cheers, Icarus...",
					PlayOnceThisRun = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02"}
						},
					}
				},
				{ Cue = "/VO/MelinoeField_2582", Text = "The work of Icarus apparently...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus02"}
						},
					}
				},
				{ Cue = "/VO/Melinoe_1981", Text = "Descura grows in strength.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1982", Text = "My staff...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0652", Text = "A sturdy staff indeed.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0653", Text = "Such secrets in this staff...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
						},
					},
				},

				{ Cue = "/VO/Melinoe_1983", Text = "For Lim and Oros.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1984", Text = "My blades grow sharper still.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0654", Text = "My blades shine like the Moon.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0655", Text = "The keenest blades of all.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
						},
					},
				},

				{ Cue = "/VO/MelinoeField_0656", Text = "Burn brighter, Ygnium.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0657", Text = "My flames ignite.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0658", Text = "The Umbral Flames...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0659", Text = "To better light my way.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
						},
					},
				},

				{ Cue = "/VO/MelinoeField_0660", Text = "You feel that, Zorephet?",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0661", Text = "The mighty Moonstone Axe.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0662", Text = "It's rather heavy still.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0663", Text = "We'll hew through anything.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0664", Text = "How's that for you, Revaal?",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0665", Text = "Behold the Argent Skull.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0666", Text = "Did this Skull just smile...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0667", Text = "The Skull gleams anew.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2583", Text = "The Black Coat shines.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2584", Text = "The power of Xinth.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2585", Text = "Xinth protect me.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2586", Text = "The Black Coat grows strong.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
						},
					},
				},

			},
		},

		SlottedVoiceLines =
		{

		},
	},
}

OverwriteTableKeys( LootData, LootSetData.Loot )

GlobalVoiceLines = GlobalVoiceLines or {}

GlobalVoiceLines.GenericLootGrantedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceThisRun = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlay = 0.25,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
			IsNone = { "MiniBossTreant", "Shop", "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "HeraclesCombatN", "HealthRestore" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "Secrets", "H" },
		},
		{
			Path = { "CurrentRun", "Hero", "TraitDictionary" },
			HasNone = { "SurfacePenalty" },
		},
		{
			FunctionName = "RequiredRewardTypeInRoom",
			FunctionArgs = { IsNone = { "StackUpgrade", "WeaponUpgrade", "TrialUpgrade", "TalentDrop", "RoomRewardConsolationPrize", }, },
		},
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1465", Text = "Message for me..." },
	{ Cue = "/VO/Melinoe_1467", Text = "A Boon..." },
	{ Cue = "/VO/Melinoe_0181", Text = "Olympus calls...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_1466", Text = "They got through..." },
	{ Cue = "/VO/Melinoe_0182", Text = "Olympus..." },
	{ Cue = "/VO/Melinoe_0230", Text = "Olympus..." },
	{ Cue = "/VO/Melinoe_0183", Text = "The gods..." },
	{ Cue = "/VO/Melinoe_0191", Text = "A Boon..." },
	{ Cue = "/VO/Melinoe_0228", Text = "That light..." },
}

GlobalVoiceLines.MiscRewardGrantedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		PreLineWait = 0.85,
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name", },
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01", "F_Reprieve01", "G_Reprieve01", "I_Reprieve01", "I_Boss01", "O_Reprieve01", "P_Reprieve01", "Q_Boss01", "Q_Boss02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName", },
				IsNone = { "H" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "Shop", },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Athena_01", "NPC_Artemis_Field_01", "NPC_Icarus_01", "NPC_Heracles_01" }, Alive = false },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
	
		{ Cue = "/VO/Melinoe_0184", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_4348", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0185", Text = "There." },
		{ Cue = "/VO/Melinoe_4349", Text = "There." },
		{ Cue = "/VO/Melinoe_0186", Text = "For me..." },
		{ Cue = "/VO/Melinoe_4350", Text = "For me?" },
		{ Cue = "/VO/Melinoe_0187", Text = "A gift..." },
		{ Cue = "/VO/Melinoe_4345", Text = "My claim." },
		{ Cue = "/VO/Melinoe_4346", Text = "There it is." },
		{ Cue = "/VO/Melinoe_4347", Text = "{#Emph}Mm." },
	},
}

RewardStoreData =
{
	InvalidOverrides =
	{
		"Secrets",
	},

	Secrets =
	{
		{
			Name = "TrialUpgrade",
		},
	},

	PreHubRewards =
	{


	},

	HubRewards =
	{
		{
			Name = "MaxHealthDropBig",
		},
		{
			Name = "MaxManaDropBig",
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HammerLootRequirements" },
			}
		},
		{
			Name = "HermesUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HermesUpgradeRequirements", },
			}
		},
		--[[ unclear why this was here -- Devotion should not be so common
		{
			Name = "Devotion",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" },
				},
				{
					Path = { "CurrentRun", "BiomeDepthCache" },
					Comparison = ">=",
					Value = 1,
				},
				--{ FunctionName = "RequiredMinRoomsSinceEvent", FunctionArgs = { Event = "Devotion", Count = 3 }, },
				--{ FunctionName = "RequiredMinExits", FunctionArgs = { Count = 2 }, },
			}
		},
		]]
		{
			Name = "SpellDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "SpellDropRequirements", },
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
	},

	SubRoomRewards =
	{
		-- mini & meta rewards for small/empty subroom encounters
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "EmptyMaxHealthSmallDrop",
		},
		{
			Name = "RoomMoneyTinyDrop",
		},
		{
			Name = "AirBoost",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "WorldUpgrades" },
					HasAll = { "WorldUpgradeElementalBoons" }
				},
			}
		},
		{
			Name = "EarthBoost",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "WorldUpgrades" },
					HasAll = { "WorldUpgradeElementalBoons" }
				},
			}
		},
		{
			Name = "FireBoost",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "WorldUpgrades" },
					HasAll = { "WorldUpgradeElementalBoons" }
				},
			}
		},
		{
			Name = "WaterBoost",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "WorldUpgrades" },
					HasAll = { "WorldUpgradeElementalBoons" }
				},
			}
		},
		{
			Name = "GiftDrop",
		},
		{
			Name = "MetaCurrencyDrop",
		},
		{
			Name = "MetaCurrencyDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},

		-- normal size rewards for bigger subroom encounters
		{
			Name = "MaxHealthDrop",
		},
		{
			Name = "MaxHealthDrop",
		},
		{
			Name = "MaxManaDrop",
		},
		{
			Name = "MaxManaDrop",
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			}
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			}
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
	},

	SubRoomRewardsHard =
	{
		-- normal size rewards for bigger subroom encounters
		{
			Name = "MaxHealthDrop",
		},
		{
			Name = "MaxHealthDrop",
		},
		{
			Name = "MaxManaDrop",
		},
		{
			Name = "MaxManaDrop",
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			}
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			}
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
	},
	MetaProgress =
	{
		-- Nectar
		{
			Name = "GiftDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "GiftDropLootRequirements" },
			},
		},

		-- Bones
		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		}, 
		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},

		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCurrencyBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCurrencyBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
			},
		},

		-- Ash
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = "<=",
					Value = 1,
				},
			},
		},

		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				OrRequirements =
				{
					{

						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
							Comparison = "<",
							Value = 500,
						},
					},
					{
						{
							Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
							Comparison = "<",
							Value = 100,
						},
					},
				},
			},
		},
		{
			Name = "MetaCardPointsCommonBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonBigDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
					Comparison = ">=",
					Value = 500,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 100,
				},
			},
		},
	},

	-- RunProgress Table / Run Progress Table
	RunProgress =
	{
		-- General
		{
			Name = "MaxHealthDrop",
		},
		{
			Name = "MaxHealthDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
						"AresUpgrade",
					},
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{
			Name = "MaxManaDrop",
			GameStateRequirements =
			{
			},
		},
		{
			Name = "MaxManaDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
						"AresUpgrade",
					},
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
						"AresUpgrade",
					},
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			}
		},
		{
			Name = "StackUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
						"AresUpgrade",
					},
					Comparison = ">=",
					Value = 1,
				},
			}
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HammerLootRequirements" },
			}
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "LateHammerLootRequirements" },
			}
		},
		{
			Name = "HermesUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HermesUpgradeRequirements", },
			},
		},
		{
			Name = "Devotion",
			GameStateRequirements =
			{
				-- unlock requirements
				{
					PathTrue = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" },
				},

				-- run requirements
				{
					Path = { "CurrentRun", "EncounterDepth" },
					Comparison = ">=",
					Value = 7,
				},
				{
					Path = { "CurrentRun", "BiomeEncounterDepth" },
					Comparison = ">=",
					Value = 2,
				},
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
					},
					Comparison = ">=",
					Value = 2,
				},
				{
					FunctionName = "RequiredMinRoomsSinceEvent",
					FunctionArgs = { Event = "Devotion", Count = 15 },
				},
				{
					FunctionName = "RequiredMinExits",
					FunctionArgs = { Count = 2 },
				},
			}
		},
		{
			Name = "SpellDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "SpellDropRequirements", },
			},
		},
		{
			Name = "TalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
				{
					Path = { "CurrentRun", "ClearedBiomes" },
					Comparison = ">",
					Value = 1,
				},
				{
					PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
				},
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
	},

	MinorRunProgress =
	{
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "EmptyMaxHealthSmallDrop",
		},
		{
			Name = "EmptyMaxHealthSmallDrop",
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "StoreRewardRandomStack",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			},
		},
		{
			Name = "ElementalBoost",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeElementalBoons", },
				},
			},
		},
		{
			Name = "ArmorBoost",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomCountCache", "F_Story01" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
	},

	FieldsCombatRewards =
	{

	},

	FieldsOptionalRewards =
	{
		-- mini run progress
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxManaDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "MaxHealthDropSmall",
		},
		{
			Name = "RoomMoneyTinyDrop",
		},
		{
			Name = "RoomMoneyTinyDrop",
		},
		{
			Name = "RoomMoneyTinyDrop",
		},

		-- healing / rarer
		{
			Name = "RoomRewardHealDrop",
		},
		{
			Name = "ArmorBoost",
		},

		-- metaprogress / more common
		{
			Name = "GiftDrop",
		},
		--[[
		{
			Name = "MetaCurrencyDrop",
		},
		]]
		{
			Name = "MetaCurrencyDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},
		{
			Name = "MetaCardPointsCommonDrop",
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "MinorTalentDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		
	},

	TartarusRewards =
	{

		{
			Name = "RoomMoneyTripleDrop",
			GameStateRequirements =
			{
			},
		},
		{
			Name = "StackUpgradeTriple",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			},
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HammerLootRequirements" },
			}
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "LateHammerLootRequirements" },
			}
		},
		{
			Name = "Devotion",
			GameStateRequirements =
			{
				-- unlock requirements
				{
					PathTrue = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" },
				},

				-- run requirements
				{
					Path = { "CurrentRun", "LootTypeHistory" },
					CountOf =
					{
						"AphroditeUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade", 
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ZeusUpgrade",
					},
					Comparison = ">=",
					Value = 2,
				},
				{
					FunctionName = "RequiredMinRoomsSinceEvent",
					FunctionArgs = { Event = "Devotion", Count = 15 },
				},
				{
					FunctionName = "RequiredMinExits",
					FunctionArgs = { Count = 2 },
				},
			}
		},
		{
			Name = "TalentBigDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
	},

	TyphonBossRewards =
	{
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "Boon",
			AllowDuplicates = true,
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "TalentBigDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "TalentLegal", },
			},
		},
		{
			Name = "StackUpgradeTriple",
			GameStateRequirements =
			{
				NamedRequirements = { "StackUpgradeLegal", },
			},
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "HammerLootRequirements" },
			}
		},
		{
			Name = "WeaponUpgrade",
			GameStateRequirements =
			{
				NamedRequirements = { "LateHammerLootRequirements" },
			}
		},
	},

}

MetaRewardStandData =
{
	WeightedOptions =
	{
		{
			Name = "CardUpgradePoints",
			Animation = "CardUpgradePointsDrop",
			Amount = 1,
			Weight = 1,
		},
		{
			Name = "WeaponPointsRare",
			Animation = "WeaponPointsRareDrop",
			Amount = 1,
			Weight = 1,
		},
		{
			Name = "Mixer5Common",
			Animation = "Mixer5CommonDrop",
			Amount = 1,
			Weight = 1,
		},
		{
			Name = "FamiliarPoints",
			Animation = "FamiliarPointsDrop",
			Amount = 1,
			Weight = 1,
		},
	},
}
