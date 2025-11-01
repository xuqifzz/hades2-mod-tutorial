QuestData = QuestData or {}
QuestOrderData =
{
	-- key / mission-critical
	"QuestRescueFatesTrue",
	"QuestFirstSurfaceClear",
	"QuestFirstUnderworldClear",

	-- major / priority
	"QuestUnlockMoros",
	"QuestBeatHecate",
	"QuestBeatHecateWithoutArcana",
	"QuestBeatTyphonWithWeapons",
	"QuestBeatChronosWithArcana",
	"QuestMeetShrineAltBosses",
	"QuestClearedWithAllAspects",
	"QuestClearedWithAllFamiliars",
	"QuestMeetOlympians",
	"QuestUnlockBountyBoard",
	"QuestHelpOdysseus",
	"QuestHelpDora",
	"QuestHelpArachne",
	"QuestHelpNarcissusAndEcho",
	"QuestHelpMedea",
	"QuestHelpCirce",
	"QuestDeliverAnubisAspect",
	"QuestDeliverMorriganAspect",
	"QuestDeliverSupayAspect",
	"QuestDeliverNergalAspect",
	"QuestDeliverHelAspect",
	"QuestDeliverShivaAspect",
	"QuestMeetCyclopsWithOdysseusKeepsake",
	"QuestChaosKeepsakeFullRun",
	"QuestRandomBountyClearStreak",
	"QuestWakeHypnos",

	-- self-improvement & stockpiling
	"QuestGiftNectar",
	"QuestMemLevel10",
	"QuestUnlockDagger",
	"QuestUnlockAllWeapons",
	"QuestUnlockAllWeaponAspects",
	"QuestMaxWeaponUpgrade",
	"QuestMaxCardUpgrade",
	"QuestPetFrog",
	"QuestPurchasePinnedItems",
	"QuestCauldronSpellsSmall",
	"QuestClearBountiesSmall",
	"QuestUnlockAllCards",
	"QuestSpendCharonPoints",
	"QuestWellShopItems",
	"QuestRecruitFamiliars",
	"QuestUpgradeFamiliars",
	"QuestCatchFish",
	"QuestCodexSmall",
	"QuestToolsUnlocks",
	"QuestToolsUpgrades",
	"QuestCosmeticsSmall",
	"QuestShadeMercRecruits",
	"QuestMiniBossKills",
	"QuestMiniBossKillsSurface",

	-- boons & character traits
	"QuestDarkSorceries",
	"QuestSeleneDuos",
	"QuestHadesUpgrades",
	"QuestZeusUpgrades",
	"QuestHeraUpgrades",
	"QuestPoseidonUpgrades",
	"QuestDemeterUpgrades",
	"QuestApolloUpgrades",
	"QuestAphroditeUpgrades",
	"QuestHephaestusUpgrades",
	"QuestHestiaUpgrades",
	"QuestAresUpgrades",
	"QuestArtemisUpgrades",
	"QuestHermesUpgrades",
	"QuestAthenaUpgrades",
	"QuestDionysusUpgrades",
	"QuestChaosCurses",
	"QuestChaosBlessings",
	"QuestLegendaryUpgrades",
	"QuestSynergyUpgrades",

	"QuestArachneUpgrades",
	"QuestNarcissusUpgrades",
	"QuestEchoUpgrades",
	"QuestMedeaCurses",
	"QuestCirceUpgrades",
	"QuestIcarusUpgrades",

	-- weapons & combat
	"QuestEliteAttributeKills",
	"QuestStaffHammerUpgrades",
	"QuestDaggerHammerUpgrades",
	"QuestTorchHammerUpgrades",
	"QuestAxeHammerUpgrades",
	"QuestLobHammerUpgrades",
	"QuestSuitHammerUpgrades",
}

OverwriteTableKeys( QuestData, {
	DefaultQuestItem =
	{
		DebugOnly = true,
		RewardResourceName = "Gems",
		RewardResourceAmount = 10,
	},
	DefaultOlympianQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Olympian",
	},
	DefaultFatesQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Fates",
	},
	DefaultKillQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Kill",
	},
	DefaultChaosQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Chaos",
	},
	DefaultNatureQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Nature",
	},
	DefaultUnseenQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Unseen",
	},
	DefaultBondQuest =
	{
		DebugOnly = true,
		Decal = "QuestLogScreenDecal_Bond",
	},
	DefaultNoDecalQuest =
	{
		DebugOnly = true,
		Decal = "Blank",
	},

	-- our emissary shall be keeping watch while we are away for a spell
	QuestUnlockMoros =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
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
	QuestWakeHypnos =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosAboutPoppies01" },
					},
				},
				-- back-compat
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWakeHypnos" },
					},
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"HypnosFinalDreamMeeting01",
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
				{ Cue = "/VO/Melinoe_4725", Text = "Well, thank the Fates..." },
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

				{ Cue = "/VO/Moros_0590", Text = "My brother Sleep was bound to wake eventually..." },
			},
		},
	},
	QuestHelpOdysseus =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "OdysseusLooseEndsQuest02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"ScyllaAboutOdysseusQuest01",
					"PolyphemusAboutOdysseusQuest01",
					"CirceAboutOdysseusQuest01",
					"OdysseusLooseEndsQuestComplete01",
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

				{ Cue = "/VO/Moros_0587", Text = "The Great Tactician laid the hauntings of his past to rest." },
			},
		},
	},
	QuestMeetCyclopsWithOdysseusKeepsake =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 60,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "PolyphemusAboutNobody02", "OdysseusGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"PolyphemusAboutNobodyKeepsake01",
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

				{ Cue = "/VO/Moros_0217", Text = "That Cyclops has known defeat before." },
			},
		},
	},
	QuestHelpArachne =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneCurseQuest01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"ArachneCurseQuestComplete01",
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

				{ Cue = "/VO/Moros_0588", Text = "The weaver called Arachne chose her Fate herself." },
			},
		},
	},
	QuestHelpDora =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus04" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"DoraAboutMemories01",
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

				{ Cue = "/VO/Moros_0586", Text = "The Shade we know as Dora is undaunted by her past." },
			},
		},
	},

	QuestDarkSorceries =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
	QuestSeleneDuos =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 9,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGrantsOlympianDuos01" },
			},
			{
				PathTrue = { "GameState", "UseRecord", "AresUpgrade" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"PolymorphZeusTalent",
					"SummonHeraTalent",
					"PotionPoseidonTalent",
					"TimeSlowDemeterTalent",
					"LaserApolloTalent",
					"TransformAphroditeTalent",
					"LeapHephaestusTalent",
					"MeteorHestiaTalent",
					"MoonBeamAresTalent",
				},
			},
		},
	},

	QuestPurchasePinnedItems =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
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

	QuestPetFrog =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "GiftPoints",
		RewardResourceAmount = 1,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "FrogFamiliar" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek03" }
			},
			-- not right after getting the Fated List
			{
				SumPrevRuns = 4,
				Path = { "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
				CountPathTrue = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "FrogPetRunCount" },
				Comparison = ">=",
				Value = 6,
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

				{ Cue = "/VO/Moros_0591", Text = "Whatever ails you, your amphibious companion shall listen." },
			},
		},
	},

	QuestBeatHecate =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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

	QuestUnlockAllWeapons =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				CountOf =
				{
					"WeaponStaffSwing",
					"WeaponDagger",
					"WeaponAxe",
					"WeaponTorch",
					"WeaponLob",
					-- purposely omitted
					-- "WeaponSuit",
				},
				Comparison = ">=",
				Value = 4,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				CountOf =
				{
					"WeaponStaffSwing",
					"WeaponDagger",
					"WeaponAxe",
					"WeaponTorch",
					"WeaponLob",
					"WeaponSuit",
				},
				Comparison = "==",
				Value = 6,
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

				{ Cue = "/VO/Moros_0594", Text = "Long were you bound to bear each of the Nocturnal Arms." },
			},
		},
	},

	QuestUnlockAllWeaponAspects =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				CountOf = GameData.AllHiddenAspects,
				Comparison = ">=",
				Value = 1,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = GameData.AllWeaponAspects,
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

				{ Cue = "/VO/Moros_0620", Text = "You shall wield many different forms of the Nocturnal Arms." },
			},
		},
	},

	QuestGiftNectar =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "MetaCardPointsCommon",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 2,
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
				Path = { "GameState", "GiftResourceRecord", "GiftPoints" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "SpawnKillBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "AmplifyConeBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "DoubleExManaBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "InstantRootKill", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					"AloneDamageBoon",
					"OmegaZeroBurnBoon",
					"CastProjectileBoon",
					"FireballManaSpecialBoon",
					"BurnExplodeBoon",
					"BurnArmorBoon",
					"BurnStackBoon",
					"ElementalBaseDamageBoon", -- Elemental
					-- "BurnSprintBoon", -- Legendary
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

	QuestAresUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AresGift02" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"AresWeaponBoon", 
					"AresSpecialBoon", 
					"AresCastBoon", 
					"AresSprintBoon", 
					"AresManaBoon",
					"AresExCastBoon",
					"RendBloodDropBoon",
					"AresStatusDoubleDamageBoon",
					"BloodDropRevengeBoon",
					"MissingHealthCritBoon",
					"LowHealthLifestealBoon",
					"OmegaDelayedDamageBoon",
					"ElementalOlympianDamageBoon", -- Elemental
					-- "DoubleBloodDropBoon", -- Legendary
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

				{ Cue = "/VO/Moros_0237", Text = "The god of war gives you a thirst for blood." },
			},
		},
	},

	QuestAphroditeUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
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
					-- "RandomStatusBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "WeaponUpgradeBoon", -- Legendary
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

	QuestHeraUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					-- "AllElementalBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					"MoneyMultiplierBoon",
					"TimedKillBuffBoon",
					"SprintShieldBoon",
					"LuckyBoon",
					"RestockBoon",
					"ElementalUnifiedBoon", -- Elemental
					-- "TimeStopLastStandBoon", -- Legendary
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
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
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
					"FocusCritBoon",
					"TimedCritVulnerabilityBoon",
					-- "SorceryCritBoon",
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

				{ Cue = "/VO/Moros_0235", Text = "You and the goddess of the hunt are much alike." },
			},
		},
	},

	QuestAthenaUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					"ManaSpearBoon",
					"RetaliateInvulnerabilityBoon", 
					"FocusLastStandBoon", 
					"DeathDefianceRefillBoon", 
					-- "OlympianSpellCountBoon",
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

				{ Cue = "/VO/Moros_0238", Text = "The gray-eyed goddess shall watch over you." },
			},
		},
	},

	QuestDionysusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
					"PowerDrinkBoon",
					"FogDamageBonusBoon",
					"BankBoon",
					-- "RandomBaseDamageBoon",
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

				{ Cue = "/VO/Moros_0236", Text = "The god of wine shall help to calm your mind." },
			},
		},
	},

	QuestChaosCurses =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
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
					-- "ChaosMetaUpgradeCurse",
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
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
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
					-- "ChaosLastStandBlessing",
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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

				{ Cue = "/VO/Moros_0607", Text = "The gods may not always be united, but they are for now." },
			},
		},
	},

	QuestLegendaryUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 3000,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				CountOf = GameData.AllLegendaryBoons,
				Comparison = ">=",
				Value = 1,
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll = GameData.AllLegendaryBoons,
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

				{ Cue = "/VO/Moros_0608", Text = "The great blessings of the gods shall all be yours." },
			},
		},
	},

	QuestWellShopItems =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "MemPointsCommon",
		RewardResourceAmount = 80,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				CountOf =
				{
					"LastStandShopItem",
					"HealDropRange",
					"EmptyMaxHealthShopItem",
					"ArmorBoostStore",
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
				Value = 2,
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
					"MetaCurrencyRange",
					"MetaCardPointsCommonRange",
					"MemPointsCommonRange",
					"SeedMysteryRange",
					"RandomStoreItem",
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "GiftPoints",
		RewardResourceAmount = 10,
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

				{ Cue = "/VO/Moros_0592", Text = "These Crossroads shall yet flourish as never before." },
			},
		},
	},

	QuestToolsUnlocks =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
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

				{ Cue = "/VO/Moros_0268", Text = "All that you take from the earth shall be returned." },
			},
		},
	},

	-- The Titan may attempt to undermine us all he likes.
	QuestFirstUnderworldClear =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
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

				{ Cue = "/VO/Moros_0595", Text = "How could the Three Fates have expected this if they..." },
				-- { Cue = "/VO/Moros_0221", Text = "Your foes were doomed to fall." },
			},
		},
	},
	QuestFirstSurfaceClear =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "BossTyphonHead01" },
			},
		},
		CustomIncompleteString = "QuestFirstSurfaceClear_Condition",
		CustomCompleteString = "QuestFirstSurfaceClear_Cleared",

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

				{ Cue = "/VO/Moros_0596", Text = "Could the Fates have already expected your ascent...?" },
			},
		},
	},
	QuestBeatTyphonWithWeapons =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll =
					{
						"WeaponStaffSwing",
						"WeaponDagger",
						"WeaponTorch",
						"WeaponAxe",
						"WeaponLob",
						"WeaponSuit",
					},
			},
			{
				Path = { "GameState", "QuestStatus", "QuestFirstUnderworldClear" },
				IsAny = { "CashedOut" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedWithWeapons", "Q" },
				HasAll = 
				{
					"WeaponStaffSwing",
					"WeaponDagger",
					"WeaponTorch",
					"WeaponAxe",
					"WeaponLob",
					"WeaponSuit",
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

				-- { Cue = "/VO/Moros_0215", Text = "Mother Night has plans for you, it seems." },
				{ Cue = "/VO/Moros_0597", Text = "Each of the Nocturnal Arms shall make war in the heavens." },
			},
		},
	},

	QuestDeliverAnubisAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "StaffRaiseDeadAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3553" },
			},
		},
		CustomIncompleteString = "QuestDeliverAnubisAspect_Condition",
		CustomCompleteString = "QuestDeliverAnubisAspect_Cleared",

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

				{ Cue = "/VO/Moros_0598", Text = "A distant god of the dead, bearing Descura... but when?" },
			},
		},
	},
	QuestDeliverMorriganAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "DaggerTripleAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3554" },
			},
		},
		CustomIncompleteString = "QuestDeliverMorriganAspect_Condition",
		CustomCompleteString = "QuestDeliverMorriganAspect_Cleared",

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

				{ Cue = "/VO/Moros_0599", Text = "A phantom goddess, bearing Lim and Oros... how...?" },
			},
		},
	},
	QuestDeliverSupayAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "TorchAutofireAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3555" },
			},
		},
		CustomIncompleteString = "QuestDeliverSupayAspect_Condition",
		CustomCompleteString = "QuestDeliverSupayAspect_Cleared",

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

				{ Cue = "/VO/Moros_0600", Text = "A daemon spirit, bearing Ygnium... but where?" },
			},
		},
	},
	QuestDeliverNergalAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "AxeRallyAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3556" },
			},
		},
		CustomIncompleteString = "QuestDeliverNergalAspect_Condition",
		CustomCompleteString = "QuestDeliverNergalAspect_Cleared",

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

				{ Cue = "/VO/Moros_0601", Text = "A god who longs for dealing death with Zorephet... why...?" },
			},
		},
	},
	QuestDeliverHelAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "LobGunAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3557" },
			},
		},
		CustomIncompleteString = "QuestDeliverHelAspect_Condition",
		CustomCompleteString = "QuestDeliverHelAspect_Cleared",

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

				{ Cue = "/VO/Moros_0602", Text = "A dread frozen queen, bearing Revaal... who is she?" },
			},
		},
	},
	QuestDeliverShivaAspect =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "SuitComboAspect" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3558" },
			},
		},
		CustomIncompleteString = "QuestDeliverShivaAspect_Condition",
		CustomCompleteString = "QuestDeliverShivaAspect_Cleared",

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

				{ Cue = "/VO/Moros_0603", Text = "An avatar of destruction, bearing Xinth... but to what end?" },
			},
		},
	},

	QuestHelpNarcissusAndEcho =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 4,
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

	QuestHelpMedea =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "MixerShadow",
		RewardResourceAmount = 1,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaAboutConcoctionQuest01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"MedeaGiftTears01",
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

				{ Cue = "/VO/Moros_0629", Text = "I think we both knew this would come to pass." },
			},
		},
	},

	QuestHelpCirce =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "MixerShadow",
		RewardResourceAmount = 1,
		NeededShrinePoints = 10, -- used for text & prereqs
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceAboutScyllaQuest01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord", },
				HasAll = 
				{
					"CirceAboutScyllaQuestComplete01",
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

				{ Cue = "/VO/Moros_0610", Text = "You shall be tested by a songstress of the deep." },
			},
		},
	},

	QuestUnlockBountyBoard =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
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
	QuestRescueFatesTrue =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			NamedRequirements = { "FatesQuestUnlocked" },
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
			},
		},

		SetupEvents =
		{
			-- start
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "OverwriteSelf",
				Args =
				{
					Name = "QuestRescueFates",
					CompleteGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "RescueFatesComplete" },
						},
					},
				},
			},
			-- post true ending
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "TrueFatesQuestUnlocked" },
				},
				FunctionName = "OverwriteSelf",
				Args =
				{
					Name = "QuestRescueFatesPostTrueEnding",
					CompleteGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "MorosPostTrueEnding02" },
						},
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasNone = { "MorosPostTrueEnding02" }
						},
					},
				},
			},
			-- progress
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
					},
					NamedRequirements = { "TrueFatesQuestUnlocked" },
					NamedRequirementsFalse = { "TrueFatesQuestCanBeCompleted" },
				},
				FunctionName = "OverwriteSelf",
				Args =
				{
					Name = "QuestRescueFatesProgress",
					DisplayedCompleteGameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = 
							{
								"MorosTaverna02",
								"ChaosAboutChronosNightmare01",
								"NeoChronosAboutFates01",
								"HecateFishing02",
								"PrometheusAboutFates02",
								"HeraclesFieldAboutFates01",
								"MorosAboutEpilogueProgress01",
							},
							AllowSubstitutions =
							{
								ChaosAboutChronosNightmare01 = "ChaosAboutChronosNightmare01_B",
							},
						},
					},
					CompleteGameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAll = 
							{
								"MorosTaverna02",
								"NeoChronosAboutFates01",
								"HecateFishing02",
								"PrometheusAboutFates02",
								"HeraclesFieldAboutFates01",
								"MorosAboutEpilogueProgress01",
							},
						},
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" },
						},
					},
				},
			},
		},

		OnViewedVoiceLines =
		{
			Queue = "Interrupt",
			SkipAnim = true,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			-- start
			{
				PlayOnce = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "TrueFatesQuestUnlocked" },
				},

				{ Cue = "/VO/Melinoe_0744", Text = "The Fates... they need my help...?" },
			},
			-- post true ending
			{
				PlayOnce = true,
				PreLineWait = 0.85,
				PlayOnceContext = "FatedListPostEndingVO",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "TrueFatesQuestUnlocked" },
				},

				{ Cue = "/VO/Melinoe_5691", Text = "The Fates... they're out there still..." },
			},
			-- progress
			{
				PlayOnce = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "FatesEpilogue01" },
					},
					NamedRequirements = { "TrueFatesQuestUnlocked" },
					NamedRequirementsFalse = { "TrueFatesQuestCanBeCompleted" },
				},

				{ Cue = "/VO/Melinoe_5693", Text = "The Fates again..." },
				-- { Cue = "/VO/Melinoe_4795", Text = "What's this, is this... from {#Emph}them...?" },
			},
			-- final
			{
				PlayOnce = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					NamedRequirements = { "TrueFatesQuestCanBeCompleted" },
				},

				{ Cue = "/VO/Melinoe_5156", Text = "The Fates... they're close..." },
			},
		},

		CashedOutVoiceLines =
		{
			{
				PreLineWait = 0.4,
				Cooldowns =
				{
					{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
				},
				SkipAnim = true,
				RequiredSourceValueFalse = "InPartnerConversation",
				ObjectType = "NPC_Moros_01",

				{ Cue = "/VO/Moros_0613", Text = "You somehow found my sisters at long last..." },
			},
		},
	},
	QuestBeatChronosWithArcana =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
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
			{
				Path = { "GameState", "QuestStatus", "QuestFirstUnderworldClear" },
				IsAny = { "CashedOut" }
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
					"CastCount",
					"SorceryRegenUpgrade",
					"CastBuff",
					"BonusHealth",
					"BonusDodge",
					"ManaOverTime",
					"MagicCrit",
					"SprintShield",
					"LastStand",
					"MaxHealthPerRoom",
					"StatusVulnerability",
					"ChanneledBlock",
					"DoorReroll",
					"StartingGold",
					"MetaToRunUpgrade",
					"RarityBoost",
					"BonusRarity",
					"TradeOff",
					"ScreenReroll",
					"LowHealthBonus",
					"EpicRarityBoost",
					"CardDraw",
				},
			},
		},
		MetaUpgradeNotUnlockedName = "Quest_UnknownCondition",

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
	QuestMeetShrineAltBosses =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 8,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "SeleneAboutAltFightQuest01", "SeleneAboutAltFightQuest02", "SeleneAboutAltFightQuest03", "SeleneAboutAltFightQuest04", "SeleneAboutAltFightQuest05", "SeleneAboutAltFightQuest06", "SeleneAboutAltFightQuestL01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll =
				{
					"BossHecate02",
					"BossPolyphemus02",

					"BossScylla02",
					"BossEris02",

					"BossInfestedCerberus02",
					"BossPrometheus02",
				},
			},
			{
				Path = { "GameState", "EncountersOccurredCache" },
				HasAll =
				{
					"BossChronos02",
					"BossTyphonHead02",
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

				{ Cue = "/VO/Moros_0621", Text = "Your strongest foes each have a dark side you now know." },
			},
		},
	},
	QuestBeatHecateWithoutArcana =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 18,
			},
			{
				Path = { "GameState", "EnemyKills", "Hecate" },
				Comparison = ">=",
				Value = 8,
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
		InheritFrom = { "DefaultQuestItem", "DefaultOlympianQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 150,
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
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
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
					--"MiniBossAssassin",

					"MiniBossWaterUnit",
					"MiniBossJellyfish",
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
	QuestMiniBossKillsSurface =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 8,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll =
				{
					"MiniBossSatyrCrossbow",
					"MiniBossCharybdis",
				},
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "Q_Intro" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll =
				{
					"MiniBossSatyrCrossbow",
					"MiniBossBoar",

					"MiniBossCharybdis",
					"MiniBossCaptain",

					"MiniBossTalos",
					"MiniBossDragon",

					"MiniBossBrute",
					"MiniBossStalker",
					"BossTyphonTail01",
					"BossTyphonEye01",
				},
			},
		},
		IncompleteName = "Quest_UnknownCondition",
	},

	QuestCatchFish =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 500,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutFishingQuest01" }
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "FishCaught" },
				UseLength = true,
				Comparison = ">=",
				Value = 20,
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

				{ Cue = "/VO/Moros_0617", Text = "You shall procure a wide variety of denizens of the deep." },
			},
		},
	},

	QuestStaffHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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

				{ Cue = "/VO/Moros_0287", Text = "The Flames of Ygnium intensify for you." },
			},
		},
	},
	QuestAxeHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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

				{ Cue = "/VO/Moros_0604", Text = "You shall reveal the mysteries of Xinth." },
			},
		},
	},

	QuestArachneUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
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
					"SpellCostume",
					-- "EscalatingCostume",
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

				{ Cue = "/VO/Moros_0606", Text = "My sisters have keen interest in skilled weavers of all sorts." },
			},
		},
	},

	QuestNarcissusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
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
					-- "NarcissusH",
					"NarcissusI",
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

				{ Cue = "/VO/Moros_0605", Text = "Despite the vanity of this Narcissus, he shall be generous." },
			},
		},
	},

	QuestEchoUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
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
					"DiminishingDodgeBoon",
					"EchoDoubleShop",
					"DiminishingHealthAndManaBoon",
					-- "EchoRepeatKeepsakeBoon",
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
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 300,
		UnlockGameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesGiftDecline01" },
					},
				},
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift01" },
					},
				},		
			}
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "TraitsTaken" },
				HasAll =
				{
					"HadesLifestealBoon",
					"HadesDashSweepBoon",
					"HadesCastProjectileBoon",
					"HadesPreDamageBoon",
					"HadesChronosDebuffBoon",
					"HadesDeathDefianceDamageBoon",
					"HadesManaUrnBoon",
					-- "HadesInvisibilityRetaliateBoon",
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

				-- { Cue = "/VO/Moros_0275", Text = "Your father rules the Underworld by right." },
				{ Cue = "/VO/Moros_0239", Text = "You have inherited your father's strength." },
			},
		},
	},

	QuestMedeaCurses =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
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
					-- "NewStatusDamage",
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
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
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
					"CirceSorceryDamageBoon",
					"RemoveShrineTrait",
					-- "ExPolymorphBoon",
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
					-- "UpgradeHammerBoon",
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
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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

	QuestUnlockAllCards =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
		RewardResourceName = "CardUpgradePoints",
		RewardResourceAmount = 7,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
				Comparison = ">=",
				Value = 14,
			},
		},
		DisplaySemiFinalRequirementKey = true,
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "TradeOff", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked" },
			},
			{
				PathTrue = { "GameState", "MetaUpgradeState", "CardDraw", "Unlocked" },
			},
		},
		IncompleteName = "Quest_UnknownCondition",

	},

	QuestMaxCardUpgrade =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultUnseenQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultFatesQuest" },
		RewardResourceName = "Mixer5Common",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAny =
				{
					"BaseStaffAspect2",
					"StaffClearCastAspect2",
					"StaffSelfHitAspect2",
					"StaffRaiseDeadAspect2",

					"DaggerBackstabAspect2",
					"DaggerBlockAspect2",
					"DaggerHomingThrowAspect2",
					"DaggerTripleAspect2",

					"TorchSpecialDurationAspect2",
					"TorchDetonateAspect2",
					"TorchSprintRecallAspect2",
					"TorchAutofireAspect2",

					"AxeRecoveryAspect2",
					"AxeArmCastAspect2",
					"AxePerfectCriticalAspect2",
					"AxeRallyAspect2",

					"LobAmmoBoostAspect2",
					"LobCloseAttackAspect2",
					"LobImpulseAspect2",
					"LobGunAspect2",

					"BaseSuitAspect2",
					"SuitMarkCritAspect2",
					"SuitHexAspect2",
					"SuitComboAspect2",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAny =
				{
					"BaseStaffAspect5",
					"StaffClearCastAspect5",
					"StaffSelfHitAspect5",
					"StaffRaiseDeadAspect5",

					"DaggerBackstabAspect5",
					"DaggerBlockAspect5",
					"DaggerHomingThrowAspect5",
					"DaggerTripleAspect5",

					"TorchSpecialDurationAspect5",
					"TorchDetonateAspect5",
					"TorchSprintRecallAspect5",
					"TorchAutofireAspect5",

					"AxeRecoveryAspect5",
					"AxeArmCastAspect5",
					"AxePerfectCriticalAspect5",
					"AxeRallyAspect5",

					"LobAmmoBoostAspect5",
					"LobCloseAttackAspect5",
					"LobImpulseAspect5",
					"LobGunAspect5",

					"BaseSuitAspect5",
					"SuitMarkCritAspect5",
					"SuitHexAspect5",
					"SuitComboAspect5",
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
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
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
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 150,
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
					"PolecatFamiliar",
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
	QuestUpgradeFamiliars =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultBondQuest" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "QuestStatus", "QuestRecruitFamiliars" },
				IsAny = { "CashedOut" }
			},
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						CountOf = GameData.AllFrogFamiliarUpgrades,
						Comparison = ">=",
						Value = 3,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						CountOf = GameData.AllRavenFamiliarUpgrades,
						Comparison = ">=",
						Value = 3,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						CountOf = GameData.AllCatFamiliarUpgrades,
						Comparison = ">=",
						Value = 3,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						CountOf = GameData.AllHoundFamiliarUpgrades,
						Comparison = ">=",
						Value = 3,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						CountOf = GameData.AllPolecatFamiliarUpgrades,
						Comparison = ">=",
						Value = 3,
					},
				},
			},
		},
		CompleteGameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						HasAll = GameData.AllFrogFamiliarUpgrades,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						HasAll = GameData.AllRavenFamiliarUpgrades,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						HasAll = GameData.AllCatFamiliarUpgrades,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						HasAll = GameData.AllHoundFamiliarUpgrades,
					},
				},
				{
					{
						Path = { "GameState", "FamiliarUpgrades" },
						HasAll = GameData.AllPolecatFamiliarUpgrades,
					},
				},
			},
		},
		CustomIncompleteString = "QuestUpgradeFamiliars_Condition",
		CustomCompleteString = "QuestUpgradeFamiliars_Cleared",

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

				{ Cue = "/VO/Moros_0614", Text = "Your Familiars shall reach their true potential in your care." },
			},
		},
	},

	QuestToolsUpgrades =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
		RewardResourceName = "MixerShadow",
		RewardResourceAmount = 3,
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

				{ Cue = "/VO/Moros_0609", Text = "The Tools of the Unseen were bound to grow strong." },
			},
		},
	},

	QuestEliteAttributeKills =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
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

	QuestRandomBountyClearStreak =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
		RewardResourceName = "WeaponPointsRare",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift06" },
			},
			NamedRequirements = { "PackageBountyRandom" },
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "RandomBountyHighestClearStreak" },
				Comparison = ">=",
				Value = 2,
			},
		},
		CustomIncompleteString = "QuestRandomBountyClearStreak_Condition",
		CustomCompleteString = "QuestRandomBountyClearStreak_Cleared",

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

				{ Cue = "/VO/Moros_0628", Text = "Even the Fates themselves perhaps did not expect this." },
			},
		},

	},

	QuestChaosKeepsakeFullRun =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultChaosQuest" },
		RewardResourceName = "Mixer5Common",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ChaosAboutKeepsakeQuest01", "ChaosAboutKeepsakeQuest01_B" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ClearedFullRunWithKeepsakes", "RandomBlessingKeepsake" },
			},
		},
		CustomIncompleteString = "QuestChaosKeepsakeFullRun_Condition",
		CustomCompleteString = "QuestChaosKeepsakeFullRun_Cleared",

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

				{ Cue = "/VO/Moros_0619", Text = "Whatever pact you formed with Chaos shall be sealed." },
			},
		},
	},

	QuestClearedWithAllAspects =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultKillQuest" },
		RewardResourceName = "Mixer5Common",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "QuestsCompleted" },
				HasAll = { "QuestUnlockAllWeaponAspects" },
			},
			{
				Path = { "GameState", "ClearedWithWeapons" },
				HasAll =
				{
					"WeaponStaffSwing",
					"WeaponDagger",
					"WeaponTorch",
					"WeaponAxe",
					"WeaponLob",
					"WeaponSuit",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedWithAspects" },
				HasAll =
				{
					"BaseStaffAspect",
					"StaffClearCastAspect",
					"StaffSelfHitAspect",
					"StaffRaiseDeadAspect",
					"DaggerBackstabAspect",
					"DaggerBlockAspect",
					"DaggerHomingThrowAspect",
					"DaggerTripleAspect",
					"TorchSpecialDurationAspect",
					"TorchDetonateAspect",
					"TorchSprintRecallAspect",
					"TorchAutofireAspect",
					"AxeRecoveryAspect",
					"AxeArmCastAspect",
					"AxePerfectCriticalAspect",
					"AxeRallyAspect",
					"LobAmmoBoostAspect",
					"LobCloseAttackAspect",
					"LobImpulseAspect",
					"LobGunAspect",
					"BaseSuitAspect",
					"SuitHexAspect",
					"SuitMarkCritAspect",
					"SuitComboAspect",
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

				{ Cue = "/VO/Moros_0623", Text = "The Arms of Night shall feast in all their forms." },
			},
		},
	},

	QuestClearedWithAllFamiliars =
	{
		InheritFrom = { "DefaultQuestItem", "DefaultNatureQuest" },
		RewardResourceName = "Mixer5Common",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedRunsCache" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				HasAll =
				{
					"FrogFamiliar",
					"CatFamiliar",
					"RavenFamiliar",
					"HoundFamiliar",
					"PolecatFamiliar",
				},
			},
		},
		CompleteGameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedWithFamiliars" },
				HasAll =
				{
					"FrogFamiliar",
					"CatFamiliar",
					"RavenFamiliar",
					"HoundFamiliar",
					"PolecatFamiliar",
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

				{ Cue = "/VO/Moros_0624", Text = "Your Animal Familiars shall follow you to the very end." },
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
	FreeFormSelectOffsetX = -220,
	ScrollbarSliderTopY = 280,
	ScrollbarSliderBottomY = 806,

	NewIconOffsetX = 200,
	RewardAvailableColor = Color.White,
	RewardCashedOutColor = Color.Gray,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	FadeOutTime = 0.10,
	CloseDestroyWait = 0.35,

	Components = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ReadyToCashOutFormat =
	{
		Color = { 255, 168, 42, 255 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,	
		OutlineThickness = 0,
		OutlineColor = {255, 205, 52, 255},
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 0.7,
			ShadowOffsetX = 0,
			ShadowOffsetY = 2,
		},
		Justification = "Center",
	},

	JustCashedOutFormat =
	{
		Color = { 46, 34, 43, 225 },
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 0,
			ShadowOffsetX = 0,
			ShadowOffsetY = 0,
		},
	},

	ReadyToCashOutFlash =
	{
		Speed = 1,
		MinFraction = 0.0,
		MaxFraction = 0.7,
		Color = { 255, 97, 61, 255 },
	},

	IncompleteFormat =
	{
		Color = { 46, 34, 43, 225 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		OutlineThickness = 1,
		OutlineColor = { 46, 34, 43, 225 },
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 0,
			ShadowOffsetX = 0,
			ShadowOffsetY = 2,
		},
		Justification = "Center",
	},

	CashedOutFormat =
	{
		Color = { 46, 34, 43, 225 },
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 0,
			ShadowOffsetX = 0,
			ShadowOffsetY = 0,
		},
		Justification = "Center",
	},

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	RequirementCompleteColor = { 255, 232, 122,255 },
	RequirementIncompleteColor = { 45, 32, 14, 255 },

	CompleteRequirementsOffsetX = 40,
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
		VerticalJustification = "Top",
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
		VerticalJustification = "Top",
		Width = 825,
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
			"MorosBackground1",
			"MorosBackground2",
			"MorosBackground3",
			"ShopBackground",
			"ShopBackgroundDecal",
			"Scrollbar",
			"ScrollbarSlider",
			"ScrollUp",
			"ScrollDown",
			"ActionBarBackground",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		MorosBackground1 = 
		{
			AnimationName = "DialogueBackground_Moros_01_In",
			X = 1300,
			Y = ScreenCenterY,
		},

		MorosBackground2 = 
		{
			AnimationName = "DialogueBackground_Moros_02_In",
			X = 1300,
			Y = ScreenCenterY,
		},

		MorosBackground3 = 
		{
			AnimationName = "DialogueBackground_Moros_03_NoShine_In",
			X = 1300,
			Y = ScreenCenterY,
		},
		

		ShopBackground = 
		{
			AnimationName = "QuestLogScreenIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		ShopBackgroundDecal =
		{
			X = ScreenCenterX + 230,
			Y = ScreenCenterY - 10,
			AnimationName = "Blank",
		},

		Scrollbar =
		{
			AnimationName = "PageScrollbar_QuestLog",
			GroupName = "Combat_Menu_Overlay",
			X = 120,
			Y = 545,
			Alpha = 0.0,
		},

		ScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			GroupName = "Combat_Menu_Overlay",
			X = 120,
			Y = 280,
			Alpha = 0.0,
		},

		ScrollUp =
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Up",
			GroupName = "Combat_Menu_Overlay",
			X = 120,
			Y = 280,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "QuestLogScrollUp",
				ControlHotkey = "MenuUp",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ScrollDown = 
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Down",
			GroupName = "Combat_Menu_Overlay",
			X = 120,
			Y = 806,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "QuestLogScrollDown",
				ControlHotkey = "MenuDown",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		InfoBoxTitle =
		{
			X = 645,
			Y = 200,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 45,
				Color = {178,136,54,255},
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left",
			},
		},

		InfoBoxDescription =
		{
			X = 650,
			Y = 260,
			Alpha = 0.0,
			TextArgs =
			{
				UseDescription = true,
				FontSize = 20,
				Color = {255,255,255,255},
				Width = 850,
				Height = 1200,
				Font = "QuestLogLatoItalic",
				LangFont = {
					{ Code = "ko", Value = "LatoMedium" }
				},
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = 9,
			},
		},

		DescriptionBox = 
		{
			X = 650,
			Y = 375,
		},

		SelectionMarker =
		{
			AnimationName = "QuestBackingEntry",
			Alpha = 0.0,
			ButtonOffsetX = 0,
		},

		RewardText =
		{
			Text = "QuestLogReward",
			X = 1425,
			Y = 840,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 42,
				TextSymbolScale = 0.7,
				LuaKey = "TempTextData",
				LuaValue = { Icon = "Dev\blank_invisible", Amount = 0 },
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
			},
		},

		RewardClaimedIcon =
		{
			X = 1435,
			Y = 810,
			Alpha = 0.0,
			AnimationName = "Screens\\QuestLogScreen\\questComplete",
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY + 50,
			UseScreenScaleX = true,
			ScaleY = 0.4,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
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