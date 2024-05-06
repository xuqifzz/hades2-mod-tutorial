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
		AnimOffsetZ = 80,
		TextLinesIgnoreQuests = true,
		OnUsedFunctionName = "UseLoot",
		UseText = "UseLoot",
		UseTextTalkAndGift = "UseLootAndGift",
		UseTextTalkAndSpecial = "UseLootAndSpecial",
		UseTextTalkGiftAndSpecial = "UseLootGiftAndSpecial",
		ManualRecordUse = true,
		DestroyOnPickup = true,
		LastRewardEligible = true,
		BanUnpickedBoonsEligible = true,

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NarrativeContextArt = "DialogueBackground_Olympus",
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},
		NarrativeContextArtFlippable = false,
		BlockedLootInteractionText = "UseLootLocked",
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
		BlockedLootInteractionText = "UseStackUpgradeLocked",
		DebugOnly = true,
		GodLoot = false,
		Weight = 10,
		Icon = "StackUpgradeSymbol",
		Color = { 255, 255, 255, 255 },
		LightingColor = {255, 255, 255, 255},
		LootColor = {255, 255, 255, 255},
		BoonGetColor = {255, 0, 20, 255},
		StackOnly = true,
		MenuTitle = "StackUpgradeChoiceMenu_Title",
		EchoLastRewardId = "EchoLastRewardBoon_StackUpgrade",
		SpawnSound = "/SFX/PomegranatePowerUpDrop",
		UpgradeSelectedSound = "/SFX/PomUpgradeChoice",
		CanDuplicate = true,
		BanUnpickedBoonsEligible = false,

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
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/MelinoeField_1369", Text = "These Poms are even here..." },
			},
		},

		PickupSound = "/SFX/PomegranatePowerUpPickup",

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
	},
	StackUpgradeTriple =
	{
		InheritFrom = { "StackUpgrade", },
		DoorIcon = "StackUpgradeTriplePreview",
		StackNum = 3,
	},	

	-- Daedalus Hammer
	WeaponUpgrade =
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		-- GameStateRequirements handled in RunProgress table
		GodLoot = false,
		CanReceiveGift = false,
		ForceCommon = true,
		UseText = "UseWeaponUpgrade",
		BlockedLootInteractionText = "UseWeaponUpgradeLocked",
		PurchaseText = "Shop_UseWeaponUpgrade",
		DebugOnly = true,
		Weight = 10,
		Icon = "WeaponUpgradeSymbol",
		Color = { 255, 255, 255, 255 },
		LightingColor = {255, 255, 255, 255},
		LootColor = {255, 255, 255, 255},
		BoonGetColor = {255, 100, 0, 255},
		MenuTitle = "WeaponUpgradeChoiceMenu_Title",
		EchoLastRewardId = "EchoLastRewardBoon_WeaponUpgrade",
		SpawnSound = "/SFX/WeaponUpgradeHammerDrop2",
		ConfirmSound = "/SFX/WeaponUpgradeHammerPickup",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",
		BoonInfoTitleText = "Codex_BoonInfo_Title_Hammer",
		BanUnpickedBoonsEligible = false,

		FlavorTextIds =
		{
			"WeaponUpgrade_FlavorText01",
			"WeaponUpgrade_FlavorText02",
			"WeaponUpgrade_FlavorText03",
		},

		PriorityUpgrades = {},
		WeaponUpgrades = {},
		Traits = {
			"StaffDoubleAttackTrait", "StaffLongAttackTrait", "StaffDashAttackTrait", "StaffTripleShotTrait", "StaffJumpSpecialTrait", "StaffExAoETrait", "StaffAttackRecoveryTrait", "StaffFastSpecialTrait", "StaffExHealTrait", "StaffSecondStageTrait", "StaffPowershotTrait", "StaffOneWayAttackTrait",
			"DaggerBlinkAoETrait", "DaggerSpecialJumpTrait", "DaggerSpecialLineTrait", "DaggerRapidAttackTrait", "DaggerSpecialConsecutiveTrait", "DaggerBackstabTrait", "DaggerSpecialReturnTrait", "DaggerSpecialFanTrait", "DaggerAttackFinisherTrait", "DaggerFinalHitTrait", "DaggerChargeStageSkipTrait",
			"AxeSpinSpeedTrait", "AxeChargedSpecialTrait", "AxeAttackRecoveryTrait", "AxeMassiveThirdStrikeTrait", "AxeThirdStrikeTrait", "AxeRangedWhirlwindTrait", "AxeFreeSpinTrait", "AxeArmorTrait", "AxeConsecutiveStrikeTrait", "AxeBlockEmpowerTrait", "AxeSecondStageTrait", "AxeDashAttackTrait", "AxeSturdyTrait",
			"TorchExSpecialCountTrait", "TorchSpecialSpeedTrait", "TorchAttackSpeedTrait", "TorchSpecialLineTrait", "TorchSpecialImpactTrait", "TorchMoveSpeedTrait", "TorchSplitAttackTrait", "TorchEnhancedAttackTrait", "TorchDiscountExAttackTrait", "TorchLongevityTrait", "TorchOrbitPointTrait", --[["TorchSpinAttackTrait", ]]
			"LobAmmoTrait", "LobAmmoMagnetismTrait", "LobRushArmorTrait", "LobSpreadShotTrait", "LobSpecialSpeedTrait", "LobSturdySpecialTrait", "LobOneSideTrait", "LobInOutSpecialExTrait", "LobStraightShotTrait", "LobPulseAmmoTrait", "LobPulseAmmoCollectTrait", "LobGrowthTrait",
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
		},

		PickupSound = "/SFX/WeaponUpgradeHammerDrop",

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
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1978", Text = "My silver shines." },
				{ Cue = "/VO/Melinoe_1979", Text = "Further refined." },
				{ Cue = "/VO/Melinoe_1980", Text = "Imbued with greater strength." },
				{ Cue = "/VO/MelinoeField_0646", Text = "The master-craftsman's gift..." },
				{ Cue = "/VO/MelinoeField_0647", Text = "Feels even sturdier." },
				{ Cue = "/VO/MelinoeField_0648", Text = "I'm grateful, Daedalus." },
				{ Cue = "/VO/MelinoeField_0649", Text = "Superior might." },
				{ Cue = "/VO/MelinoeField_0650", Text = "Enchanted for the night." },
				{ Cue = "/VO/MelinoeField_0651", Text = "Fine work as always." },

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
				
			},
		},

		SlottedVoiceLines =
		{

		},
	},

	ManaUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		-- GameStateRequirements handled in RunProgress table
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = false,
		PurchaseText = "Shop_UseManaUpgrade",
		UseText = "UseManaUpgrade",
		BlockedLootInteractionText = "UseManaUpgradeLocked",
		DebugOnly = true,
		GodLoot = false,
		Weight = 10,
		Icon = "ManaUpgradePreview",
		Color = { 255, 255, 255, 255 },
		LightingColor = {255, 255, 255, 255},
		LootColor = {255, 255, 255, 255},
		BoonGetColor = {255, 0, 20, 255},
		MenuTitle = "ManaUpgradeChoiceMenu_Title",
		SpawnSound = "/Leftovers/SFX/FieldReviveSFX",
		UpgradeSelectedSound = "/Leftovers/SFX/WyrmCastAttack",
		BanUnpickedBoonsEligible = false,

		FlavorTextIds =
		{
			"ManaUpgrade_FlavorText01",
			"ManaUpgrade_FlavorText02",
			"ManaUpgrade_FlavorText03",
		},

		OnSpawnVoiceLines =
		{
		},

		PickupSound = "/SFX/PomegranatePowerUpPickup",
		PickupFunctionName = "ManaUpgradeInteractPresentation",
		PickupGlobalVoiceLines = "ManaDropUsedVoiceLines",

		Traits = { 
					"ManaOnCastTrait", 
					"ManaOverTimeTrait", 
					--"IdleManaOverTimeTrait", 
					"ManaOnPrimaryTrait", 
					"ManaOnSecondaryTrait", 
					--"ManaDropOnKillTrait", 
					"ManaBonusTrait", 
					--"RevengeManaTrait" 
				},
	},

	HephaestusWeaponUpgrade = 
	{
		InheritFrom = { "WeaponUpgrade" },
		DebugOnly = true,
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
			IsNone = { "MiniBossTreant", "Shop", "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "HeraclesCombatN" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "Secrets", "H" },
		},
		RequiredFalseRewardTypesInRoom = { "StackUpgrade", "WeaponUpgrade", "TrialUpgrade", "TalentDrop" },
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1465", Text = "Message for me..." },
	{ Cue = "/VO/Melinoe_1467", Text = "A Boon..." },
	{ Cue = "/VO/Melinoe_0181", Text = "Olympus calls..." },
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
				IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01", "F_Reprieve01", "G_Reprieve01", "I_Reprieve01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName", },
				IsNone = { "H" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "Shop", },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
	
		{ Cue = "/VO/Melinoe_0184", Text = "{#Emph}Ah." },
		{ Cue = "/VO/Melinoe_0185", Text = "There." },
		{ Cue = "/VO/Melinoe_0186", Text = "For me..." },
		{ Cue = "/VO/Melinoe_0187", Text = "A gift..." },
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
				-- rule 0: only unlock at this point
				{
					PathTrue = { "GameState", "RoomCountCache", "G_Boss01" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
				},
				-- rule 1: have x or fewer of this specific upgrade in a Biome
				{
					Path = { "CurrentRun", "LootBiomeRecord" },
					SumOf = { "HermesUpgrade" },
					Comparison = "<=",
					Value = 0,
				},
				-- rule 2: have y or fewer of the non-Boon power set
				{
					Path = { "CurrentRun", "LootBiomeRecord" },
					SumOf = { "WeaponUpgrade", "HermesUpgrade" },
					Comparison = "<=",
					Value = 1,
				},
				-- rule 3: only drop up to z per run
				{
					Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
					Comparison = "<=",
					Value = 2,
				},

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
				RequiredInteractedGodsThisRun = 2,
				--RequiredMinRoomsSinceDevotion = 15,
				--RequiredMinExits = 2,
			}
		},
		]]
		{
			Name = "SpellDrop",
			GameStateRequirements =
			{
				RequiredNotInStore = "SpellDrop",
				RequiredFalseRewardType = "SpellDrop",
				{
					PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
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
		},
		{
			Name = "EarthBoost",
		},
		{
			Name = "FireBoost",
		},
		{
			Name = "WaterBoost",
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
		{
			Name = "MemPointsCommonDrop",
		},
		{
			Name = "MemPointsCommonDrop",
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
		{
			Name = "GiftDrop",
			GameStateRequirements =
			{
				NamedRequirements = { "GiftDropLootRequirements" },
			},
		},
				
		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
					Comparison = ">=",
					Value = 10,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 15,
				},
			},
		},
		{
			Name = "MetaCurrencyDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
					Comparison = ">=",
					Value = 10,
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 15,
				},
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "MetaCardPointsCommonDrop",
			GameStateRequirements =
			{
				-- None
			},
		},
		{
			Name = "MemPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{
			Name = "MemPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{
			Name = "MemPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{
			Name = "MemPointsCommonDrop",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
					Comparison = ">=",
					Value = 5,
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
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
				},
			},
		},
		{
			Name = "MaxHealthDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
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
					Value = 1,
				},
			},
		},
		{
			Name = "MaxManaDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
				},
			},
		},
		{
			Name = "MaxManaDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
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
					Value = 1,
				},
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
				},
			},
		},
		{
			Name = "RoomMoneyDrop",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "GoodStuffBoon" },
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
				-- unlock requirements
				{
					PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
				},

				-- run requirements				
				RequiredNotInStore = "ShopHermesUpgrade",
				{
					Path = { "CurrentRun", "BiomeUseRecord", },
					HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
				},
				{
					Path = { "CurrentRun", "EncounterDepth" },
					Comparison = ">=",
					Value = 8,
				},
				{
					Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
					Comparison = "<=",
					Value = 1,
				},

			}
		},
		{
			Name = "Devotion",
			GameStateRequirements =
			{
				-- unlock requirements
				NamedRequirements = { "DevotionTestUnlocked", },

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
				RequiredMinRoomsSinceDevotion = 15,
				RequiredMinExits = 2,
			}
		},
		{
			Name = "SpellDrop",
			GameStateRequirements =
			{
				-- unlock requirements
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
				},

				-- run requirements
				RequiredNotInStore = "SpellDrop",
				RequiredFalseRewardType = "SpellDrop",
				{
					PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
				},
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
		--[[
		{
			Name = "HitShieldDrop",
		},
		]]

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
			Name = "MemPointsCommonDrop",
		},
		{
			Name = "MemPointsCommonDrop",
		},
		{
			Name = "MemPointsCommonDrop",
		},
		{
			Name = "MemPointsCommonDrop",
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
				-- None
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
				NamedRequirements = { "DevotionTestUnlocked", },

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
				RequiredMinRoomsSinceDevotion = 15,
				RequiredMinExits = 2,
			}
		},
		{
			Name = "SpellDrop",
			GameStateRequirements =
			{
				-- unlock requirements
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
				},

				-- run requirements
				RequiredNotInStore = "SpellDrop",
				RequiredFalseRewardType = "SpellDrop",
				{
					PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
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
	},

}