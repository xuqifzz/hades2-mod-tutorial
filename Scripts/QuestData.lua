QuestData = QuestData or {}
QuestOrderData =
{
	-- key
	"QuestRescueFates",
	"QuestFirstUnderworldClear",

	-- major / priority
	"QuestUnlockMoros",
	"QuestBeatHecate",
	"QuestBeatHecateWithoutArcana",
	"QuestBeatChronosWithArcana",
	"QuestMeetOlympians",
	"QuestUnlockBountyBoard",
	"QuestHelpNarcissusAndEcho",

	-- boons & character traits
	"QuestHadesUpgrades",
	"QuestZeusUpgrades",
	"QuestHeraUpgrades",
	"QuestPoseidonUpgrades",
	"QuestApolloUpgrades",
	"QuestDemeterUpgrades",
	"QuestAphroditeUpgrades",
	"QuestHephaestusUpgrades",
	"QuestHestiaUpgrades",
	"QuestDarkSorceries",
	"QuestArtemisUpgrades",
	"QuestHermesUpgrades",
	"QuestAthenaUpgrades",
	"QuestDionysusUpgrades",
	"QuestChaosCurses",
	"QuestChaosBlessings",
	"QuestSynergyUpgrades",

	"QuestArachneUpgrades",
	"QuestNarcissusUpgrades",
	"QuestEchoUpgrades",
	"QuestMedeaCurses",
	"QuestCirceUpgrades",
	"QuestIcarusUpgrades",

	-- weapons & combat
	"QuestClearBountiesSmall",
	"QuestUnlockDagger",
	"QuestStaffHammerUpgrades",
	"QuestDaggerHammerUpgrades",
	"QuestTorchHammerUpgrades",
	"QuestAxeHammerUpgrades",
	"QuestLobHammerUpgrades",
	"QuestSuitHammerUpgrades",
	"QuestMiniBossKills",
	"QuestMaxWeaponUpgrade",
	"QuestEliteAttributeKills",

	-- self-improvement & stockpiling
	"QuestShadeMercRecruits",
	"QuestCauldronSpellsSmall",
	"QuestGiftNectar",
	"QuestMemLevel10",
	"QuestMaxCardUpgrade",
	"QuestPurchasePinnedItems",
	"QuestSpendCharonPoints",
	"QuestWellShopItems",
	"QuestRecruitFamiliars",
	"QuestCodexSmall",
	"QuestToolsUnlocks",
	"QuestToolsUpgrades",
	"QuestCosmeticsSmall",
}

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
			Queue = "Interrupt",
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
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HecateBossFirstAppearance", "HecateBossFirstAppearanceAlt" },
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
		RewardResourceAmount = 500,
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
					"ElementalDamageFloorBoon", -- Elemental
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
		RewardResourceAmount = 500,
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
					"PoseidonExCastBoon",
					"OmegaPoseidonProjectileBoon",
					"EncounterStartOffenseBuffBoon",
					"RoomRewardBonusBoon",
					"FocusDamageShaveBoon",
					"DoubleRewardBoon",
					"PoseidonStatusBoon",
					"ElementalHealthBoon", -- Elemental
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
		RewardResourceAmount = 500,
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
					"ApolloExCastBoon",
					"ApolloRetaliateBoon",
					"PerfectDamageBonusBoon",
					"BlindChanceBoon",
					"ApolloBlindBoon",
					"ApolloCastAreaBoon",
					"DoubleStrikeChanceBoon",
					"ElementalRallyBoon", -- Elemental
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
		RewardResourceAmount = 500,
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
					"ElementalDamageCapBoon", -- Elemental
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
		RewardResourceAmount = 500,
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
					"BurnArmorBoon",
					"BurnStackBoon",
					"ElementalBaseDamageBoon", -- Elemental
					"BurnSprintBoon", -- Legendary
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
		RewardResourceAmount = 500,
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
					"ElementalDodgeBoon", -- Elemental
					"RandomStatusBoon", -- Legendary
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
		RewardResourceAmount = 500,
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
					"MassiveDamageBoon",
					"AntiArmorBoon",
					"HeavyArmorBoon",
					"ArmorBoon",
					"EncounterStartDefenseBuffBoon",
					"ManaToHealthBoon",
					"MassiveKnockupBoon",
					"ElementalDamageBoon", -- Elemental
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
		RewardResourceAmount = 120,
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
					"FirstHitHealTrait",
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
					"LimitedSwapTraitDrop",
					"LimitedManaRegenDrop",
				},
			},
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"TemporaryDoorHealTrait",
					"TemporaryHealExpirationTrait",
					"FirstHitHealTrait",
					"TemporaryImprovedSecondaryTrait",
					"TemporaryImprovedCastTrait",
					"TemporaryMoveSpeedTrait",
					"TemporaryBoonRarityTrait",
					"TemporaryImprovedExTrait",
					"TemporaryImprovedDefenseTrait",
					"TemporaryDiscountTrait",
					"TemporaryForcedSecretDoorTrait",
					"TemporaryEmptySlotDamageTrait",
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
				Value = 50,
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

	QuestCosmeticsSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 350,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
				Comparison = ">=",
				Value = 200,
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "DoraGrantsCosmeticsShop01" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
				Comparison = ">=",
				Value = 10000,
			},
		},

		-- @ needs CashedOutVoiceLines
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

	QuestFirstUnderworldClear =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
			-- Force = true,
			{
				-- PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"ChronosBossOutro01",
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

				{ Cue = "/VO/Moros_0221", Text = "Your foes were doomed to fall." },
			},
		},
	},
	QuestHelpNarcissusAndEcho =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "GiftPoints",
		CardUpgradePoints = 5,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"NarcissusAboutWaters05",
				},
			},
		},

		--[[
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
		]]--
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

				{ Cue = "/VO/Moros_0278", Text = "Two Souls once intertwined, finally untangled." },
			},
		},
	},
	QuestUnlockBountyBoard =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 80,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsBountyBoard01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
			},
		},
		CustomIncompleteString = "QuestUnlockBountyBoard_Condition",
		CustomCompleteString = "QuestUnlockBountyBoard_Cleared",

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

				{ Cue = "/VO/Moros_0269", Text = "Chaos must have a greater plan for you." },
			},
		},
	},
	QuestRescueFates =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			NamedRequirements = { "FatesQuestUnlocked" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					-- do you truly think this is even possible?
					"RescueFatesComplete",
				},
			},
		},

		OnViewedVoiceLines =
		{
			Queue = "Interrupt",
			PlayOnce = true,
			SkipAnim = true,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				NamedRequirements = { "FatesQuestUnlocked" },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0744", Text = "The Fates... they need my help...?" },
		},
	},
	QuestBeatChronosWithArcana =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "MetaUpgradeMaxLevelCountCache" },
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedWithMetaUpgrades", "I" },
				HasAll = 
				{
					"ChanneledCast",
					"HealthRegen",
					"LowManaDamageBonus",
					"MagicCrit",
					"BonusDodge",
					"CastBuff",
					"BonusHealth",
					"ManaOverTime",
					"SorceryRegenUpgrade",
					"ChanneledBlock",
					"SprintShield",
					"LastStand",
					"MaxHealthPerRoom",
					"CastCount",
					"LowHealthBonus",
					"DoorReroll",
					"StartingGold",
					"StatusVulnerability",
					"RarityBoost",
					"BonusRarity",
					"TradeOff",
					"ScreenReroll",
					"MetaToRunUpgrade",
					"EpicRarityBoost",
					"CardDraw",
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

				{ Cue = "/VO/Moros_0281", Text = "You are emboldened by your knowledge of the past." },
			},
		},
	},
	QuestBeatHecateWithoutArcana =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 6,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutArcana01" },
			},
			{
				Path = { "GameState", "QuestStatus", "QuestBeatHecate" },
				IsAny = { "CashedOut" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"HecateBossOutroNoArcana01",
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

				{ Cue = "/VO/Moros_0280", Text = "Your innate strength is greater than you know." },
			},
		},
	},
	QuestMeetOlympians =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "OreFSilver",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonFirstPickUp" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"ArtemisFirstMeeting",
					"HermesFirstPickUp",
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

				{ Cue = "/VO/Moros_0219", Text = "You have trusted allies on Olympus." },
			},
		},
	},
	QuestSpendCharonPoints =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "PlantMoney",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "MailboxScreen" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CharonPoints" },
				Comparison = ">=",
				Value = 5,
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
				{ Cue = "/VO/Moros_0243", Text = "I know my brother trusts you more than most." },
			},
		},
	},
	QuestMiniBossKills =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaFabric",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll =
				{
					"MiniBossTreant",
					"MiniBossFogEmitter",
				},
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "I_Intro" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll =
				{
					"MiniBossTreant",
					"MiniBossFogEmitter",

					"MiniBossWaterUnit",
					"MiniBossCrawler",

					"MiniBossVampire",
					"MiniBossLamia",

					"MiniBossGoldElemental",
					"MiniBossRatCatcher",
				},
			},
		},
		IncompleteName = "Quest_UnknownCondition",

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

				{ Cue = "/VO/Moros_0282", Text = "The Underworld is your home, and you, its protector." },
			},
		},
	},
	QuestHeraUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HeraWeaponBoon",
					"HeraSpecialBoon",
					"HeraCastBoon",
					"HeraSprintBoon",
					"HeraManaBoon",
					"DamageShareRetaliateBoon",
					"LinkedDeathDamageBoon",
					"BoonDecayBoon",
					"DamageSharePotencyBoon",
					"SpawnCastDamageBoon",
					"CommonGlobalDamageBoon",
					"OmegaHeraProjectileBoon",
					"ElementalRarityUpgradeBoon", -- Elemental
					"AllElementalBoon", -- Legendary
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

				{ Cue = "/VO/Moros_0229", Text = "The Queen of Olympus favors you." },
			},
		},
	},
	QuestHermesUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HermesGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HermesWeaponBoon",
					"HermesSpecialBoon",
					"DodgeChanceBoon",
					"SorcerySpeedBoon",
					"HermesCastDiscountBoon",
					"SlowProjectileBoon",
					"HexCooldownBuffBoon",
					"MoneyMultiplierBoon",
					"TimedKillBuffBoon",
					"SprintShieldBoon",
					"ElementalUnifiedBoon", -- Elemental
					"TimeStopLastStandBoon", -- Legendary
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

				{ Cue = "/VO/Moros_0234", Text = "The messenger shall keep you well informed." },
			},
		},
	},

	QuestArtemisUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HighHealthCritBoon", 
					"SupportingFireBoon", 
					"CritBonusBoon", 
					"DashOmegaBuffBoon", 
					"InsideCastCritBoon",
					"OmegaCastVolleyBoon",
					"TimedCritVulnerabilityBoon",
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},
	QuestAthenaUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AthenaGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"InvulnerabilityDashBoon", 
					"AthenaProjectileBoon",
					"InvulnerabilityCastBoon",
					"RetaliateInvulnerabilityBoon", 
					"FocusLastStandBoon", 
					"DeathDefianceRefillBoon", 
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},
	QuestDionysusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DionysusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"FirstHangoverBoon",
					"CastLobBoon",
					"HiddenMaxHealthBoon",
					"CombatEncounterHealBoon",
					-- "RandomDuoBoon",
					"PowerDrinkBoon",
					"FogDamageBonusBoon",
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},

	QuestChaosCurses =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 700,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"ChaosPrimaryAttackCurse",
					"ChaosSecondaryAttackCurse",
					"ChaosCastCurse",
					"ChaosDashCurse",
					"ChaosExAttackCurse",
					"ChaosNoMoneyCurse",
					"ChaosHealthCurse",
					"ChaosHiddenRoomRewardCurse",
					"ChaosDamageCurse",
					"ChaosDeathWeaponCurse",
					"ChaosSpeedCurse",
					"ChaosCommonCurse",
					"ChaosManaFocusCurse",
					"ChaosRestrictBoonCurse",
					"ChaosStunCurse",
					"ChaosTimeCurse",
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

				{ Cue = "/VO/Moros_0271", Text = "Chaos is the source of life, and all its hardships." },
			},
		},
	},
	QuestChaosBlessings =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 700,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift03" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"ChaosWeaponBlessing",
					"ChaosSpecialBlessing",
					"ChaosCastBlessing",
					"ChaosSpeedBlessing",
					"ChaosHealthBlessing",
					"ChaosRarityBlessing",
					"ChaosMoneyBlessing",
					"ChaosManaBlessing",
					"ChaosManaOverTimeBlessing",
					"ChaosExSpeedBlessing",
					"ChaosElementalBlessing",
					"ChaosManaCostBlessing",
					"ChaosDoorHealBlessing",
					"ChaosHarvestBlessing",
					"ChaosOmegaDamageBlessing",
					"ChaosLastStandBlessing",
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

				{ Cue = "/VO/Moros_0272", Text = "The oldest blessings in existence shall be yours." },
			},
		},
	},

	QuestSynergyUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 3000,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf = GameData.AllDuoBoons,
				Comparison = ">=",
				Value = 4,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll = GameData.AllDuoBoons,
			},
		},

		-- @ needs CashedOutVoiceLines
	},

	QuestStaffHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
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
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
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

				{ Cue = "/VO/Moros_0285", Text = "Your understanding of Descura knows no bounds." },
			},
		},
	},

	QuestDaggerHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
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
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
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

				{ Cue = "/VO/Moros_0286", Text = "Your skill with Lim and Oros only grows." },
			},
		},
	},
	QuestTorchHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponTorch" },
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
					"TorchAttackSpeedTrait",
					"TorchSplitAttackTrait",
					"TorchSpinAttackTrait",
					"TorchEnhancedAttackTrait",
					"TorchDiscountExAttackTrait",
					"TorchSpecialSpeedTrait",
					"TorchSpecialLineTrait",
					"TorchSpecialImpactTrait",
					"TorchOrbitPointTrait",
					"TorchMoveSpeedTrait",
					"TorchLongevityTrait",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"TorchAttackSpeedTrait",
					"TorchSplitAttackTrait",
					"TorchSpinAttackTrait",
					"TorchEnhancedAttackTrait",
					"TorchDiscountExAttackTrait",
					"TorchSpecialSpeedTrait",
					"TorchSpecialLineTrait",
					"TorchSpecialImpactTrait",
					"TorchExSpecialCountTrait",
					"TorchOrbitPointTrait",
					"TorchMoveSpeedTrait",
					"TorchLongevityTrait",
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

				{ Cue = "/VO/Moros_0287", Text = "The flames of Ygnium intensify for you." },
			},
		},
	},
	QuestAxeHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponAxe" },
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
					"AxeSpinSpeedTrait",
					"AxeChargedSpecialTrait",
					"AxeAttackRecoveryTrait",
					"AxeMassiveThirdStrikeTrait",
					"AxeThirdStrikeTrait",
					"AxeRangedWhirlwindTrait",
					"AxeFreeSpinTrait",
					"AxeArmorTrait",
					--"AxeConsecutiveStrikeTrait",
					"AxeBlockEmpowerTrait",
					"AxeSecondStageTrait",
					"AxeDashAttackTrait",
					"AxeSturdyTrait",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"AxeSpinSpeedTrait",
					"AxeChargedSpecialTrait",
					"AxeAttackRecoveryTrait",
					"AxeMassiveThirdStrikeTrait",
					"AxeThirdStrikeTrait",
					"AxeRangedWhirlwindTrait",
					"AxeFreeSpinTrait",
					"AxeArmorTrait",
					--"AxeConsecutiveStrikeTrait",
					"AxeBlockEmpowerTrait",
					"AxeSecondStageTrait",
					"AxeDashAttackTrait",
					"AxeSturdyTrait",
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

				{ Cue = "/VO/Moros_0288", Text = "You shall learn to brandish Zorephet with ease." },
			},
		},
	},
	QuestLobHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponLob" },
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
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
					"LobGrowthTrait",
					"LobPulseAmmoCollectTrait",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
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
					"LobGrowthTrait",
					"LobPulseAmmoCollectTrait",
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

				{ Cue = "/VO/Moros_0289", Text = "In your care, Revaal grows stronger still." },
			},
		},
	},

	QuestSuitHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponSuit" },
			},
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf =
				{
					"SuitArmorTrait",
					"SuitAttackSpeedTrait",
					"SuitAttackSizeTrait",
					"SuitSpecialAutoTrait",
					"SuitAttackRangeTrait",
					"SuitFullChargeTrait",
					"SuitSpecialBlockTrait",
					"SuitSpecialStartUpTrait",
					"SuitSpecialConsecutiveHitTrait",
					"SuitSpecialJumpTrait",
					"SuitSpecialDiscountTrait",
					"SuitDashAttackTrait",
				},
				Comparison = ">=",
				Value = 3,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"SuitArmorTrait",
					"SuitAttackSpeedTrait",
					"SuitAttackSizeTrait",
					"SuitSpecialAutoTrait",
					"SuitAttackRangeTrait",
					"SuitFullChargeTrait",
					"SuitSpecialBlockTrait",
					"SuitSpecialStartUpTrait",
					"SuitSpecialConsecutiveHitTrait",
					"SuitSpecialJumpTrait",
					"SuitSpecialDiscountTrait",
					"SuitDashAttackTrait",
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},

	QuestArachneUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaFabric",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"VitalityCostume",
					"ManaCostume",
					"AgilityCostume",
					"IncomeCostume",
					"CastDamageCostume",
					"HighArmorCostume",
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},

	QuestNarcissusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"NarcissusA",
					"NarcissusB",
					"NarcissusC",
					"NarcissusD",
					"NarcissusE",
					"NarcissusF",
					-- "NarcissusG",
					"NarcissusH",
					"NarcissusI",
				},
			},
		},

		-- @ needs CashedOutVoiceLines
	},

	QuestEchoUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "EchoGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"EchoLastReward",
					"EchoLastRunBoon",
					"EchoDeathDefianceRefill",
					"EchoDoubleLevelBoon",
					-- "EchoRepeatKeepsakeBoon",
					"DiminishingDodgeBoon",
					"DiminishingHealthAndManaBoon",
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

				{ Cue = "/VO/Moros_0277", Text = "You'll know a Nymph whose voice reflects your own." },
			},
		},
	},

	QuestHadesUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HadesGiftDecline01" },
			},

		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HadesLifestealBoon",
					"HadesCastProjectileBoon",
					"HadesPreDamageBoon",
					"HadesChronosDebuffBoon",
					"HadesInvisibilityRetaliateBoon",
					"HadesDeathDefianceDamageBoon",
					"HadesManaUrnBoon",
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

				{ Cue = "/VO/Moros_0275", Text = "Your father rules the Underworld by right." },
			},
		},
	},

	QuestMedeaCurses =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HealingOnDeathCurse",
					"MoneyOnDeathCurse",
					"ManaOverTimeCurse",
					"SpawnDamageCurse",
					"ArmorPenaltyCurse",
					"SlowProjectileCurse",
					"DeathDefianceRetaliateCurse",
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

				{ Cue = "/VO/Moros_0273", Text = "It's fortunate the Witch of Shadows stands with you." },
			},
		},
	},

	QuestCirceUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"RandomArcanaTrait",
					"ArcanaRarityTrait",
					"CirceShrinkTrait",
					"CirceEnlargeTrait",
					"HealAmplifyTrait",
					"DoubleFamiliarTrait",
					"RemoveShrineTrait",
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

				{ Cue = "/VO/Moros_0274", Text = "The Witch of Changing longed to aid you in her way." },
			},
		},
	},

	QuestIcarusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"FocusAttackDamageTrait",
					"FocusSpecialDamageTrait",
					"BreakInvincibleArmorBoon",
					"BreakExplosiveArmorBoon",
					"OmegaExplodeBoon",
					"SupplyDropBoon",
					"CastHazardBoon",
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

				{ Cue = "/VO/Moros_0276", Text = "The son of Daedalus soars the skies in search of you." },
			},
		},
	},
	QuestShadeMercRecruits =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MemPointsCommon",
		RewardResourceAmount = 40,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "ProjectileRecord", "ShadeMercSpiritball" },
				Comparison = ">=",
				Value = 100,
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
				{ Cue = "/VO/Moros_0222", Text = "The Shades shall rise up at your side." },
			},
		},
	},

	QuestCauldronSpellsSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MemPointsCommon",
		RewardResourceAmount = 25,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "GhostAdmin" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades", },
				CountOf = ScreenData.GhostAdmin.ItemCategories[1],
				Comparison = ">=",
				Value = 10,
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
				{ Cue = "/VO/Moros_0224", Text = "Your craft cannot truly be mastered." },
			},
		},
	},
	
	QuestMemLevel10 =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "PlantFNightshadeSeed",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 30,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 14,
			}
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
				{ Cue = "/VO/Moros_0241", Text = "Your grasp of the Arcana shall only grow." },
			},
		},
	},

	QuestMaxCardUpgrade =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCardPointsCommon",
		RewardResourceAmount = 100,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "MetaUpgradeMaxLevelCountCache" },
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
				{ Cue = "/VO/Moros_0242", Text = "The depth of your understanding has no end." },
			},
		},
	},

	QuestMaxWeaponUpgrade =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Mixer5Common",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAny =
				{
					-- @ update with additional Aspects
					"BaseStaffAspect2",
					"StaffClearCastAspect2",
					"StaffSelfHitAspect2",

					"DaggerBackstabAspect2",
					"DaggerBlockAspect2",
					"DaggerHomingThrowAspect2",

					"TorchSpecialDurationAspect2",
					"TorchDetonateAspect2",
					"TorchSprintRecallAspect2",

					"AxeRecoveryAspect2",
					"AxeArmCastAspect2",
					"AxePerfectCriticalAspect2",

					"LobAmmoBoostAspect2",
					"LobCloseAttackAspect2",
					"LobImpulseAspect2",

					"BaseSuitAspect2",
					"SuitMarkCritAspect2",
					"SuitHexAspect2",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAny =
				{
					-- @ update with additional Aspects
					"BaseStaffAspect5",
					"StaffClearCastAspect5",
					"StaffSelfHitAspect5",

					"DaggerBackstabAspect5",
					"DaggerBlockAspect5",
					"DaggerHomingThrowAspect5",

					"TorchSpecialDurationAspect5",
					"TorchDetonateAspect5",
					"TorchSprintRecallAspect5",

					"AxeRecoveryAspect5",
					"AxeArmCastAspect5",
					"AxePerfectCriticalAspect5",

					"LobAmmoBoostAspect5",
					"LobCloseAttackAspect5",
					"LobImpulseAspect5",

					"BaseSuitAspect5",
					"SuitMarkCritAspect5",
					"SuitHexAspect5",
				},
			},
		},
		CustomIncompleteString = "MaxWeaponUpgradeIncomplete",
		CustomCompleteString = "MaxWeaponUpgradeComplete",

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

				{ Cue = "/VO/Moros_0223", Text = "The Arms of Night were forged with you in mind." },
			},
		},
	},

	QuestClearBountiesSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "PackagedBountyClears" },
				UseLength = true,
				Comparison = ">=",
				Value = 5,
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

				{ Cue = "/VO/Moros_0270", Text = "Each Trial deepens your connection to Chaos." },
			},
		},
	},

	QuestRecruitFamiliars =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "PlantMoney",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{

			{
				Path = { "GameState", "FamiliarsUnlocked" },
				HasAny = { "RavenFamiliar", "CatFamiliar" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				CountOf =
				{
					"FrogFamiliar",
					"RavenFamiliar",
					"CatFamiliar",
					"HoundFamiliar",
					-- anyone else...?
				},
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

				{ Cue = "/VO/Moros_0266", Text = "Beasts can make for great companions, true?" },
			},
		},
	},

	QuestToolsUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MixerShadow",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolUpgradeSystem" },
			},
			{
				PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeToolUpgradeSystem" },
			},
			{
				Path = { "GameState", "QuestStatus", "QuestToolsUnlocks" },
				IsAny = { "CashedOut" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked", },
				HasAll =
				{
					"ToolPickaxe2",
					"ToolShovel2",
					"ToolExorcismBook2",
					"ToolFishingRod2",
				},
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeHarvestUpgrade" },
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

				{ Cue = "/VO/Moros_0268", Text = "All that you take from the earth shall be returned." },
			},
		},
	},

	QuestEliteAttributeKills =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
				Comparison = ">=",
				Value = 1,
			},
			NamedRequirements = { "ShrineUnlocked" },
		},
		CompletionRequirementTextSymbolScale = 0.55,
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyEliteAttributeKills", },
				HasAll =
				{
					"Massive",
					"ExtraDamage",
					"Molten",
					"Rooting",
					"Metallic",
					"Miasma",
					"ManaDrain",
					"Hex",
					"Rifts",
					"Homing",
					"SpreadHitShields",
					"Blink",
					"Radial",
					"Fog",
					"Orbit",
					"StasisDeath",
					"Vacuuming",
					"Frenzy",
					"HeavyArmor",
					"Unflinching",
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

				{ Cue = "/VO/Moros_0225", Text = "Serve the Night, and the Night shall give back." },
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
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 1,
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

	CompleteRequirementsOffsetX = 36,
	CompleteRequirementsOffsetY = 
	{
		{ Code = "en", Value = 0 },
		{ Code = "ja", Value = 5 },
		{ Code = "ko", Value = 5 },
		{ Code = "zh-CN", Value = 5 },
		{ Code = "zh-TW", Value = 5 },
	},
	RequirementEntriesPerColumn = 9,
	RequirementEntriesMaxColumns = 2,
	RequirementRowSpacing = 40,
	RequirementColumnSpacing = 500,

	BulletPointFormat =
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

	CompletionRequirementFormat =
	{
		Text = "QuestLog_QuestProgressRequirement",
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
				Width = 1000,
				LangWidth = {
					{ Code = "el", Value = 1100 },
					{ Code = "fr", Value = 1100 },
					{ Code = "ja", Value = 1100 },
					{ Code = "pl", Value = 1100 },
					{ Code = "ru", Value = 1100 },
					{ Code = "uk", Value = 1100 },
				},
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
				TextSymbolScale = 0.7,
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