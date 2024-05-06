--[[ **LOCALIZATION SCRIPTS** ]]

LocalizationData = 
{
	-- Codex
	CodexScripts =
	{
		EntryNameText =
		{
			LangRuScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		EntryText =
		{
			LangRuScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		EntryCompleteSkipNewLines =
		{
			"de",
			"ru",
			"ko",
			"ja",
		},
		ChapterName =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
	},
	-- House Contractor Screen
	GhostAdminScreen =
	{
		FlavorText =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		CosmeticCost =
		{
		},
		CosmeticTitle =
		{
		},
		CosmeticDescription =
		{
			LangFrScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
		},
	},
	-- Character narrative / dialog events
	Narrative =
	{
		SpeakerDisplayName =
		{
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = -2 },
			},
		},
		SpeakerDescription =
		{
			LangRuScaleModifier = 1.0,
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = 2 },
			},
		},
		-- ex: "Sisyphus furtively offers a choice of benefits."
		ChoiceBackground =
		{
			LangRuScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		ChoiceText =
		{
			LangJaScaleModifier = 1.0,
		},
		DialogueText =
		{
			LangDeScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
		},
	},
	-- Global UI presentation
	UIPresentation =
	{
		LocationTextSizeAwareScale =
		{
			"de", "es", "fr",
		},
		-- Full-screen banner at start of biome, ex: "Tartarus"
		LocationText =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
		},
		-- Full-screen banner text when unlocking something
		UnlockText =
		{
			LangFrScaleModifier = 1.0
		}
	},
	-- Mid-run boon info screen
	TraitTrayScripts =
	{
		DetailsBacking =
		{
			LangRuScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
		},
		DetailsBackingXOffset = 
		{
			["es"] = -290,
		},
		DetailsBackingYOffset =
		{
			-- ["ko"] = -10,
			["zh-CN"] = -10,
			["ja"] = -12,
		},
		DetailsBackingWidth = 
		{
			["es"] = 720,
		},
		TitleBoxXOffset = 
		{		
			["es"] = 140,
		},
		TitleBoxYOffset =
		{
			-- ["ko"] = -5,
			["zh-CN"] = -5,
			["ja"] = -7,
		},
		TitleBox =
		{
			LangKoScaleModifier = 1.0,
		},
		RarityBox =
		{
			LangKoScaleModifier = 1.0,
		},
	},
	BoonInfoScreenScripts =
	{
		RequirementsTitle =
		{
			LangRuScaleModifier = 1.0,
		}
	},
	-- Boon choice / UpgradeChoice screen
	UpgradeChoice =
	{
		FlavorText =
		{
			LangFrScaleModifier = 1.0,
		},
		BoonLootButton =
		{
			LangRuScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
		},
		ExchangeText =
		{
			LangRuScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangOffsetX =
			{
				["ja"] = 75,
			},
			LangOffsetY = 
			{
				["de"] = 0,
				["en"] = 0,
				["es"] = 0,
				["fr"] = 0,
				["it"] = 0,
				["ja"] = 5,
				["ko"] = 0,
				["pl"] = 3,
				["pt-BR"] = 0,
				["ru"] = 0,
				["zh-CN"] = 0,
			},
		},
	},
	MusicPlayerScreen =
	{
		LabelText =
		{
			LangEsScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
		}
	},
	-- VictoryScreen / RunClearScreen
	RunClearScreen =
	{
		TitleText =
		{
			LangFrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
		},
		ColumnHeader =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		WeaponText =
		{
			LangDeScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
		},
		NewRecordText =
		{
			LangEsScaleModifier = 1.0,
		},
	},
	-- Well of Charon / StoreLogic.lua
	-- Pool of Purging / SellTraitLogic.lua
	SellTraitScripts =
	{
		TitleText =
		{
			LangDeScaleModifier = 1.0,
		},
		FlavorText =
		{
 			LangDeScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangFrScaleModifier = 1.0, 
			LangJaScaleModifier = 1.0,
		},
		UpgradeTitle =
		{
			TraitNameOffsetX = 
			{
				["de"] = 125,
				["en"] = 85,
				["es"] = 95,
				["fr"] = 95,
				["it"] = 95,
				--["ko"] = 75,
				["pl"] = 125,
				--["pt-BR"] = 0,
				["ru"] = 125,
				--["zh-CN"] = 75,
			},
		},
		ShopButton =
		{
			LangRuScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
		},
	},
	-- Fated List of Minor Prophecies / QuestLogScreen
	QuestLogScreen =
	{
		TitleText = 
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
		},
		-- Left-hand side menu items
		QuestName = 
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		QuestDescription =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		},
		QuestLogRewardText =
		{
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		}
	},
	-- Wretched Broker
	MarketScreen =
	{
		FlavorText =
		{
			LangDeScaleModifier = 1.0,
		},
	},
	-- WeaponUpgradeScripts / Aspect / Weapon Select
	WeaponUpgradeScripts =
	{
		WeaponDisplayName =
		{
			--LangJaScaleModifier = 1.0,
		},
		WeaponDescription =
		{
			LangCnScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangFrScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangKoScaleModifier = 1.0,
			LangJaScaleModifier = 1.0,
		}
	},
}