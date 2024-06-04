OverwriteTableKeys( QuestData, {

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
			-- Force = true,
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
		RewardResourceAmount = 400,
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
					"SwapBonusBoon",
					"BoonDecayBoon",
					"DamageSharePotencyBoon",
					"LinkedDeathDamageBoon",
					"FullManaExBoostBoon",
					"HeraManaShieldBoon", -- Legendary
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
		RewardResourceAmount = 400,
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
					"ElementalUnifiedBoon",
					"SlowProjectileBoon",
					"HexCooldownBuffBoon",
					"MoneyMultiplierBoon",
					"TimedKillBuffBoon",
					"SprintShieldBoon",
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
	QuestChaosCurses =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 400,
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
		RewardResourceAmount = 400,
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

		--[[
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

				-- { Cue = "/VO/Moros_0271", Text = "Chaos is the source of life, and all its hardships." },
			},
		},
		]]--
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
					--"TorchSpinAttackTrait",
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
					--"TorchSpinAttackTrait",
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

		--[[
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

				-- { Cue = "/VO/Moros_0273", Text = "It's fortunate the Witch of Shadows stands with you." },
			},
		},
		]]--
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

		--[[
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

				-- { Cue = "/VO/Moros_0273", Text = "It's fortunate the Witch of Shadows stands with you." },
			},
		},
		]]--
	},

	QuestEchoUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
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

				{ Cue = "/VO/Moros_0277", Text = "You'll know a nymph whose voice reflects your own." },
			},
		},
	},

	QuestHadesUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaCurrency",
		RewardResourceAmount = 250,
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
					"HadesDeathDefianceDamageBoon",
					"HadesCastProjectileBoon",
					"HadesPreDamageBoon",
					"HadesChronosDebuffBoon",
					"HadesInvisibilityRetaliateBoon",
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
		RewardResourceAmount = 250,
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
		RewardResourceAmount = 250,
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
		RewardResourceAmount = 250,
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
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ToulaChat01", "RakiChat01" },
			},
		},
		CompleteGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked", },
			},
			{
				PathTrue = { "GameState", "FamiliarStatus", "RavenFamiliar", "Unlocked", },
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
		RewardResourceName = "MetaCardPointsCommon",
		RewardResourceAmount = 100,
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
})