QuestData = QuestData or {}
OverwriteTableKeys( QuestData, {
	DefaultQuestItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		RewardResourceName = "Gems",
		RewardResourceAmount = 10,
	},

	-- our emissary shall be keeping watch while we are away for a spell
	QuestUnlockMoros =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "GiftPoints",
		RewardResourceAmount = 1,
		UnlockGameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"MorosFirstMeeting",
				},
			},
		},

		OnViewedVoiceLines =
		{
			PlayOnce = true,
			SkipAnim = true,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
				},
				NamedRequirements = { "MorosUnlocked" },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_2317", Text = "A prophecy concerning Doom?" },
			{ Cue = "/VO/Melinoe_2318", Text = "I have to find Lord Moros once again, and call him here...", PreLineWait = 1.2, BreakIfPlayed = true },
		},
		OnViewedFunctionName = "DisplayInfoToast",
		OnViewedFunctionArgs = { WaitTime = 1.5, Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeMorosUnlock" },
		CashedOutVoiceLines =
		{
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "MelinoeProphecyFulfilledSpeech", Time = 3 },
			},
			{ Cue = "/VO/Melinoe_1728", Text = "Lord Moros has arrived... now what...?" },
		},
	},

	QuestDarkSorceries =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"SpellTimeSlowTrait",
					"SpellSummonTrait",
					"SpellPotionTrait",
					"SpellLaserTrait",
					"SpellPolymorphTrait",
					"SpellLeapTrait",
					"SpellMeteorTrait",
					"SpellTransformTrait",
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0240", Text = "Ever shall you walk in the light of the Moon." },
			},
		},
	},

	QuestPurchasePinnedItems =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MemPointsCommon",
		RewardResourceAmount = 25,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePinning" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "StoreItemPinsPurchased" },
				UseLength = true,
				Comparison = ">=",
				Value = 3,
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0279", Text = "The Fates know all about maintaining lists." },
			},
		},
	},

	QuestBeatHecate =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaFabric",
		RewardResourceAmount = 1,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossFirstAppearance" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"HecateBossOutro01",
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				Cooldowns =
				{
					{ Name = "MelinoeProphecyFulfilledSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_1730", Text = "The Fates expected I would get this far..." },
			},
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0216", Text = "A necessary step along your path." },
			},
		},
	},

	QuestUnlockDagger =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "PlantFMoly",
		RewardResourceAmount = 1,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "WeaponShop" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll =
				{
					"WeaponDagger",
				},
			},
		},
	},

	QuestGiftNectar =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCardPointsCommon",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 1,
			},
			--[[
			{
				Path = { "GameState", "Resources", "GiftPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "UseRecord", "NPC_Moros_01" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosSecondAppearance" },
			},
			]]--
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
				Comparison = ">=",
				Value = 5,
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				Cooldowns =
				{
					{ Name = "MelinoeProphecyFulfilledSpeech", Time = 3 },
				},
				{ Cue = "/VO/Melinoe_1901", Text = "Well this worked out, I guess." },
			},
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",
				{ Cue = "/VO/Moros_0220", Text = "Your generosity shall not be forgotten." },
			},
		},
	},

	QuestZeusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"ZeusWeaponBoon",
					"ZeusSpecialBoon",
					"ZeusCastBoon",
					"ZeusSprintBoon",
					"ZeusManaBoon",
					"ZeusManaBoltBoon",
					"BoltRetaliateBoon",
					"CastAnywhereBoon",
					"FocusLightningBoon",
					"LightningDebuffGeneratorBoon",
					"DoubleBoltBoon",
					"EchoExpirationBoon",
					"SpawnKillBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0227", Text = "The heavens themselves abide you." },
			},
		},
	},

	QuestPoseidonUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"PoseidonWeaponBoon",
					"PoseidonSpecialBoon",
					"PoseidonCastBoon",
					"PoseidonSprintBoon",
					"PoseidonManaBoon",
					"EncounterStartOffenseBuffBoon",
					"MinorLootBoon",
					"RoomRewardBonusBoon",
					"FocusDamageShaveBoon",
					"SlamExplosionBoon",
					"DoubleRewardBoon",
					"PoseidonStatusBoon",
					"AmplifyConeBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0228", Text = "The seas are at your call." },
			},
		},
	},

	QuestApolloUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ApolloGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"ApolloWeaponBoon",
					"ApolloSpecialBoon",
					"ApolloCastBoon",
					"ApolloSprintBoon",
					"ApolloManaBoon",
					"ApolloRetaliateBoon",
					"PerfectDamageBonusBoon",
					"BlindChanceBoon",
					"ApolloBlindBoon",
					"ApolloMissStrikeBoon",
					"ApolloCastAreaBoon",
					"DoubleStrikeChanceBoon",
					"DoubleExManaBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0226", Text = "The light of the sun shines for you." },
			},
		},
	},

	QuestDemeterUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DemeterGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"DemeterWeaponBoon",
					"DemeterSpecialBoon",
					"DemeterCastBoon",
					"DemeterSprintBoon",
					"DemeterManaBoon",
					"CastNovaBoon",
					"PlantHealthBoon",
					"BoonGrowthBoon",
					"ReserveManaHitShieldBoon",
					"SlowExAttackBoon",
					"CastAttachBoon",
					"RootDurationBoon",
					"InstantRootKill", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0230", Text = "Your grandmother is a powerful ally." },
			},
		},
	},

	QuestHestiaUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HestiaGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HestiaWeaponBoon",
					"HestiaSpecialBoon",
					"HestiaCastBoon",
					"HestiaSprintBoon",
					"HestiaManaBoon",
					"SacrificeBoon",
					"OmegaZeroBurnBoon",
					"CastProjectileBoon",
					"FireballManaSpecialBoon",
					"BurnExplodeBoon",
					"BurnConsumeBoon",
					"BurnArmorBoon",
					"BurnStackBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0232", Text = "Fiercely loyal is the goddess of the hearth." },
			},
		},
	},

	QuestAphroditeUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"AphroditeWeaponBoon",
					"AphroditeSpecialBoon",
					"AphroditeCastBoon",
					"AphroditeSprintBoon",
					"AphroditeManaBoon",
					"HighHealthOffenseBoon",
					"HealthRewardBonusBoon",
					"DoorHealToFullBoon",
					"WeakPotencyBoon",
					"WeakVulnerabilityBoon",
					"ManaBurstBoon",
					"FocusRawDamageBoon",
					"CharmCrowdBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0231", Text = "The goddess of love has further plans for you." },
			},
		},
	},

	QuestHephaestusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HephaestusWeaponBoon",
					"HephaestusSpecialBoon",
					"HephaestusCastBoon",
					"HephaestusSprintBoon",
					"HephaestusManaBoon",
					"ChargeCounterBoon",
					"AntiArmorBoon",
					"HeavyArmorBoon",
					"ArmorBoon",
					"EncounterStartDefenseBuffBoon",
					"ManaToHealthBoon",
					"MassiveKnockupBoon",
					"WeaponUpgradeBoon", -- Legendary
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0233", Text = "The god of the forge shall support you." },
			},
		},
	},

	QuestWellShopItems =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MemPointsCommon",
		RewardResourceAmount = 60,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				CountOf =
				{
					"LastStandShopItem",
					"HealDropRange",
					"EmptyMaxHealthShopItem",
					"MetaCurrencyRange",
					"MetaCardPointsCommonRange",
					"MemPointsCommonRange",
					"SeedMysteryRange",
					"RandomStoreItem",
					"DamageSelfDrop",
				},
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
					"TemporaryDoorHealTrait",
					"TemporaryHealExpirationTrait",
					"TemporaryImprovedSecondaryTrait",
					"TemporaryImprovedCastTrait",
					"TemporaryMoveSpeedTrait",
					"TemporaryBoonRarityTrait",
					"TemporaryImprovedExTrait",
					"TemporaryImprovedDefenseTrait",
					"TemporaryDiscountTrait",
					"TemporaryForcedSecretDoorTrait",
					"ExtendedShopTrait",
				},
				Comparison = ">=",
				Value = 1,
			},

		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				HasAll =
				{
					"LastStandShopItem",
					"HealDropRange",
					"EmptyMaxHealthShopItem",
					"MetaCurrencyRange",
					"MetaCardPointsCommonRange",
					"MemPointsCommonRange",
					"SeedMysteryRange",
					"RandomStoreItem",
					"DamageSelfDrop",
				},
			},
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"TemporaryDoorHealTrait",
					"TemporaryHealExpirationTrait",
					"TemporaryImprovedSecondaryTrait",
					"TemporaryImprovedCastTrait",
					"TemporaryMoveSpeedTrait",
					"TemporaryBoonRarityTrait",
					"TemporaryImprovedExTrait",
					"TemporaryImprovedDefenseTrait",
					"TemporaryDiscountTrait",
					"TemporaryForcedSecretDoorTrait",
					"ExtendedShopTrait",
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0284", Text = "My brother Charon is committed to this realm." },
			},
		},
	},

	QuestCodexSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 120,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossGrantsCodex01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "CodexEntriesUnlockedCache", },
				Comparison = ">=",
				Value = 30,
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0267", Text = "You've much to learn yet from that book..." },
			},
		},
	},

	QuestToolsUnlocks =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCardPointsCommon",
		RewardResourceAmount = 40,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolsShop" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll =
				{
					"ToolPickaxe",
					"ToolShovel",
					"ToolExorcismBook",
					"ToolFishingRod",
				},
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0267", Text = "You've much to learn yet from that book..." },
			},
		},
	},


})

ScreenData.QuestLog =
{
	BlockPause = true,
	ItemStartX = 373,
	ItemStartY = 280,
	ItemSpacingY = 48,
	ItemsPerPage = 12,
	ScrollOffset = 0,
	ProgressPageOffset = 0,
	NumRequirementsColumns = 0,

	NewIconOffsetX = 200,
	RewardAvailableColor = Color.White,
	RewardCashedOutColor = Color.Gray,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	Components = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	ReadyToCashOutFormat =
	{
		Color = { 255, 168, 42, 255 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,	
		OutlineThickness = 0,
		OutlineColor = {255, 205, 52, 255},
		ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
		Justification = "Center",
	},

	JustCashedOutFormat =
	{
		Color = Color.Black,
		ShadowBlur = 0, ShadowColor = {0,0,0,0.0}, ShadowOffset={0, 0},
	},

	ReadyToCashOutFlash =
	{
		Speed = 0.8,
		MinFraction = 0.0,
		MaxFraction = 0.7,
		Color = { 162, 40, 8, 255 },
	},

	IncompleteFormat =
	{
		Color = { 235, 235, 235, 255 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		OutlineThickness = 0,
		OutlineColor = {0,0,0,0.5},
		ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
		Justification = "Center",
	},

	CashedOutFormat =
	{
		Color = { 46, 34, 43, 225 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
		Justification = "Center",
	},

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	RequirementCompleteColor = { 223, 223, 223,255 },
	RequirementIncompleteColor = { 94, 94, 94, 255 },

	CompleteRequirementsOffsetX = 0,
	CompleteRequirementsOffsetY = 0,
	RequirementEntriesPerColumn = 9,
	RequirementEntriesMaxColumns = 2,
	RequirementRowSpacing = 40,
	RequirementColumnSpacing = 500,

	CompletionRequirementFormat =
	{
		FontSize = 22,
		Font = "P22UndergroundSCMedium",
		TextSymbolScale = 1.0,
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset = {0, 2},
		Justification = "Left",
		Width = 1200,
		DataProperties =
		{
			IgnoreFormatters = true,
		},
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"ShopBackgroundDim",
			"ShopBackgroundSplatter",
			"ActionBarBackground",
			"ShopBackground",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		ShopBackgroundSplatter = 
		{
			Graphic = "LevelUpBackground",
			GroupName = "Combat_Menu_Backing",
		},

		ShopBackground = 
		{
			AnimationName = "QuestLogStatic",
			GroupName = "Combat_Menu",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				--[[
				TitleText = 
				{
					Text = "QuestLogScreen_Title",
					TextArgs =
					{
						FontSize = 36,
						OffsetX = 0, OffsetY = -445,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},

				FlavorText = 
				{
					Text = "QuestLogScreen_Flavor",
					TextArgs =
					{
						FontSize = 22,
						OffsetX = 0, OffsetY = -410,
						Width = 840,
						Color = {120, 120, 120, 0},
						Font = "LatoSemiboldItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},
				]]--

				ScrollUp =
				{
					Graphic = "ButtonCodexUp",
					GroupName = "Combat_Menu",
					OffsetX = -592,
					OffsetY = -320,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "QuestLogScrollUp",
						ControlHotkeys = { "MenuUp", },
					}
				},

				ScrollDown = 
				{
					Graphic = "ButtonCodexDown",
					GroupName = "Combat_Menu",
					OffsetX = -592,
					OffsetY = 325,
					Alpha = 0,
					InteractProperties =
					{
						FreeFormSelectable = true,
					},
					Data =
					{
						OnPressedFunctionName = "QuestLogScrollDown",
						ControlHotkeys = { "MenuDown", },
					}
				},
			},
		},

		InfoBoxTitle =
		{
			X = 650,
			Y = 300,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 34,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left",
			},
		},

		InfoBoxDescription =
		{
			X = 650,
			Y = 340,
			Alpha = 0.0,
			TextArgs =
			{
				UseDescription = true,
				FontSize = 20,
				Color = {161,161,161,255},
				Width = 900,
				Height = 1200,
				Font = "LatoMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = 9,
			},
		},

		DescriptionBox = 
		{
			X = 650,
			Y = 450,
		},

		SelectionMarker =
		{
			AnimationName = "QuestLogEntryArrow",
			Alpha = 0.0,
			ButtonOffsetX = 240,
		},

		RewardText =
		{
			Text = "QuestLogReward",
			X = 660,
			Y = 920,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 26,
				TextSymbolScale = 0.8,
				LuaKey = "TempTextData",
				LuaValue = { Icon = "Dev\blank_invisible", Amount = 0 },
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left",
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
			BottomOffset = UIData.ContextualButtonBottomOffset,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"SelectButton",
				"ScrollRight",
				"ScrollLeft",
			},

			Children =
			{
				ScrollLeft =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "QuestLogPrevProgressPage",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_FewerContents",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "QuestLogNextProgressPage",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_MoreContents",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_QuestLog",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseQuestLogScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}