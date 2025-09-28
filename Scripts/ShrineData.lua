-- Shrine 
GlobalVoiceLines.ShrineUpgradeMaxedVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "ShrineVOQuippedRecently", Time = 3 },
	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
			},
		},

		{ Cue = "/VO/Melinoe_2869", Text = "This goes no farther." },
		{ Cue = "/VO/Melinoe_2870", Text = "It's at the limit." },
		{ Cue = "/VO/Melinoe_2871", Text = "Can't vow any harder..." },
		{ Cue = "/VO/Melinoe_2872", Text = "This Vow is at its peak.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2873", Text = "Don't think I can." },
		{ Cue = "/VO/Melinoe_2874", Text = "Could take a different Vow..." },
	}
}
GlobalVoiceLines.ShrineUpgradePickedVoiceLines =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 0.7,
	SkipAnim = true,
	ChanceToPlay = 0.35,
	Cooldowns =
	{
		{ Name = "MelinoeShrineUpgradeSpeech", Time = 30 },
		{ Name = "ShrineVOQuippedRecently", Time = 4 },
	},

	{ Cue = "/VO/Melinoe_3511", Text = "...This I vow...", PlayFirst = true },
	{ Cue = "/VO/Melinoe_3512", Text = "...That Fear may spread..." },
	{ Cue = "/VO/Melinoe_3513", Text = "...By my birthright..." },
	{ Cue = "/VO/Melinoe_3514", Text = "...For the realm..." },
	{ Cue = "/VO/Melinoe_3515", Text = "...I swear it, Nyx..." },
	{ Cue = "/VO/Melinoe_3516", Text = "...By will of Night..." },
}

ShrineUpgradeOrder =
{
	"EnemyDamageShrineUpgrade",
	"EnemyHealthShrineUpgrade",
	"EnemyShieldShrineUpgrade",
	"EnemySpeedShrineUpgrade",

	"EnemyCountShrineUpgrade",
	"NextBiomeEnemyShrineUpgrade",
	"EnemyRespawnShrineUpgrade",
	"EnemyEliteShrineUpgrade",

	"HealingReductionShrineUpgrade",
	"ShopPricesShrineUpgrade",
	"MinibossCountShrineUpgrade",
	"BoonSkipShrineUpgrade",

	"BiomeSpeedShrineUpgrade",
	"LimitGraspShrineUpgrade",
	"BoonManaReserveShrineUpgrade",
	"BanUnpickedBoonsShrineUpgrade",

	"BossDifficultyShrineUpgrade",	
}

BossDifficultyShrineEncounterMap =
{
	Hecate =
	{
		Encounter = "BossHecate01",
		AltEncounter = "BossHecate02",
	},

	Scylla =
	{
		Encounter = "BossScylla01",
		AltEncounter = "BossScylla02",
	},

	InfestedCerberus =
	{
		Encounter = "BossInfestedCerberus01",
		AltEncounter = "BossInfestedCerberus02",
	},

	Chronos =
	{
		Encounter = "BossChronos01",
		AltEncounter = "BossChronos02",
	},

	Polyphemus =
	{
		Encounter = "BossPolyphemus01",
		AltEncounter = "BossPolyphemus02",
	},

	Eris =
	{
		Encounter = "BossEris01",
		AltEncounter = "BossEris02",
	},

	Prometheus =
	{
		Encounter = "BossPrometheus01",
		AltEncounter = "BossPrometheus02",
	},

	TyphonHead =
	{
		Encounter = "BossTyphonHead01",
		AltEncounter = "BossTyphonHead02",
	},
}

BiomeTimeLimits =
{
	Penalty =
	{
		Damage = 5,
		Interval = 1,
	},
}

--Conquer the
UIData.ShrineBountyAvailableTextArgs =
{
	FadeTarget = 0.0,
	FadeOpacity = 0.0,
	FontSize = 20,
	OffsetX = -683,
	OffsetY = -290,
	Width = 840,
	Color = {201, 164, 103, 255},
	Font = "LatoMedium",
	DataProperties =
	{
		ShadowBlur = 0,
		ShadowRed = 0,
		ShadowGreen = 0,
		ShadowBlue = 0,
		ShadowAlpha = 255,
		ShadowOffsetX = 0,
		ShadowOffsetY = 1,
	},
	Justification = "Left",
	TextSymbolScale = 0.8,
}

ScreenData.Shrine =
{
	BlockPause = true,

	-- Vow Backings
	ItemStartX = 805,
	ItemStartY = 95,
	ItemSpacingX = 188,
	ItemSpacingY = 116,
	ItemsPerRow = 4,
	ScrollOffset = 0,
	WideItemOffsetX = 283,
	WideIconGroupShiftX = 35,

	PactInactiveAnimation = "ShrinePactInactiveBacking",
	PactActiveAnimation = "ShrinePactActiveBacking",
	PactInactiveWideAnimation = "ShrinePactInactiveBackingWide",
	PactActiveWideAnimation = "ShrinePactActiveBackingWide",
	PactInactiveBadgeAnimation = "GUI\\Screens\\Shrine\\PactBadgeInactive",
	PactActiveBadgeAnimation = "GUI\\Screens\\Shrine\\PactBadgeActive",
	SelectionHighlightAnimation = "ShrinePactHover",
	SelectionHighlightWideAnimation = "ShrinePactHoverWide",	
	SelectionHighlightGlintAnimation = "ShrinePactHighlight",
	SelectionHighlightWideGlintAnimation = "ShrinePactHighlightLarge",
	CloseAnimation = "ShrineOut",

	BountyOrder =
	{
		-- Heat 1
		"BountyShrineStaffFBoss",
		"BountyShrineDaggerGBoss",
		"BountyShrineTorchOBoss",
		"BountyShrineAxeNBoss",
		"BountyShrineLobHBoss",
		"BountyShrineSuitPBoss",

		-- Heat 2
		"BountyShrineStaffGBoss",
		"BountyShrineDaggerNBoss",
		"BountyShrineTorchHBoss",
		"BountyShrineAxeOBoss",
		"BountyShrineLobPBoss",
		"BountyShrineSuitFBoss",

		-- Heat 4
		"BountyShrineStaffNBoss",
		"BountyShrineDaggerOBoss",
		"BountyShrineTorchPBoss",
		"BountyShrineAxeHBoss",
		"BountyShrineLobFBoss",
		"BountyShrineSuitGBoss",

		-- Heat 8
		"BountyShrineStaffOBoss",
		"BountyShrineDaggerHBoss",
		"BountyShrineTorchFBoss",
		"BountyShrineAxePBoss",
		"BountyShrineLobGBoss",
		"BountyShrineSuitNBoss",

		-- Heat 10
		"BountyShrineStaffHBoss",
		"BountyShrineDaggerPBoss",
		"BountyShrineTorchGBoss",
		"BountyShrineAxeFBoss",
		"BountyShrineLobNBoss",
		"BountyShrineSuitOBoss",

		-- Heat 12
		"BountyShrineStaffPBoss",
		"BountyShrineDaggerFBoss",
		"BountyShrineTorchNBoss",
		"BountyShrineAxeGBoss",
		"BountyShrineLobOBoss",
		"BountyShrineSuitHBoss",

		-- Heat 16
		"BountyShrineStaffIBoss",
		"BountyShrineDaggerQBoss",
		"BountyShrineTorchQBoss",
		"BountyShrineAxeIBoss",
		"BountyShrineLobIBoss",
		"BountyShrineSuitQBoss",

		-- Heat 20
		"BountyShrineStaffQBoss",
		"BountyShrineDaggerIBoss",
		"BountyShrineTorchIBoss",
		"BountyShrineAxeQBoss",
		"BountyShrineLobQBoss",
		"BountyShrineSuitIBoss",
	},

	ShrineRunDoorArrowId = 589699,
	BountyEncounterDoorFlipMap =
	{
		BossHecate01 = false,
		BossScylla01 = false,
		BossInfestedCerberus01 = false,
		BossChronos01 = false,
		BossPolyphemus01 = true,
		BossEris01 = true,
		BossPrometheus01 = true,
		BossTyphonHead01 = true,
	},

	OpenSound = "/SFX/Menu Sounds/PactMenuOpenSFX",
	CloseSound = "/SFX/Menu Sounds/PactMenuCloseSFX",
	MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOutMenu",
    ToggleOnSound = "/SFX/Menu Sounds/IrisMenuConfirm",
    ToggleOffSound = "/SFX/Menu Sounds/IrisMenuBack",

	InfoMessageId = "ShrineIntro",

	InvestedColor = Color.MetaUpgradePointsInvalidPulseColor,
	UnlockVoiceLines = HeroVoiceLines.ShrineUpgradeUnlockedVoiceLines,
	RefundPresentationName = "ShrinePointRefundPresentation",
	SpendPresentationName = "ShrinePointSpendPresentation",
	HighlightX = 0,
	BackingOffsetX = 40,

	TooltipX = 1670,
	TooltipY = 850,

	-- Testament fonts
	IconActiveColor = Color.White,
	IconInactiveColor = { 89, 89, 89, 255 },

	BountyActiveColor = Color.White, --[[{189, 234, 44, 255}]]
	BountyInactiveColor = {255, 255, 255, 40}, --[[{53, 58, 69, 235}]]
	
	ActiveVariableColor = Color.PenaltyRed,
	InactiveVariableColor = { 230, 230, 230, 255 },

	-- Vow icon properties
	IconBackingScale = 1,
	IconScale = 0.4,
	IconMouseOverScale = 0.5,
	IconOffsetX = -68,
	IconOffsetY = -5,

	-- Vow Next Rank Cost
	NextRankMaxColor = { 169, 169, 169, 255 },
	NextRankFormat = 
	{
		Font = "NumericP22UndergroundSCHeavy",
		Text = "ShrineScreen_NextRankPoints",
		FontSize = 23,
		OffsetX = 24,
		OffsetY = 0,
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 1,
			ShadowOffsetX = 3,
			ShadowOffsetY = 3,
		},
		Justification = "Right",
		TextSymbolScale = 0.75,
	},

	-- Vow Next Rank Backing
	NextRankBackingOffsetX = 62,
	NextRankBackingOffsetY = -41,
	NextRankBackingWideOffsetX = 103,
	NextRankBackingWideOffsetY = -36,

	-- Vow Name
	ShortNameFormat = 
	{
		Font = "LatoItalic",
		FontSize = 17,
		OffsetX = 37,
		OffsetY = -6,
		Color = { 55, 55, 55, 255 },
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 1,
			ShadowOffsetX = 2,
			ShadowOffsetY = 2,
		},
		Justification = "Left",
	},

	ShortNameActiveFormat = 
	{
		Font = "LatoItalic",
		FontSize = 17,
		OffsetX = 37,
		OffsetY = -6,
		Color = {189,160,255,255},
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 1,
			ShadowOffsetX = 2,
			ShadowOffsetY = 2,
		},
		Justification = "Left",
	},

	ShortNameSelectedFormat =
	{
		Font = "LatoItalic",
		FontSize = 17,
		OffsetX = 35,
		OffsetY = 0,
		Color = {189,160,255,255},
		DataProperties =
		{
			ShadowBlur = 0,
			ShadowRed = 0,
			ShadowGreen = 0,
			ShadowBlue = 0,
			ShadowAlpha = 1,
			ShadowOffsetX = 2,
			ShadowOffsetY = 2,
		},
		Justification = "Center",
	},

	-- Vow Rank Pips
	RankPipStartOffsetX = -22,
	RankPipStartOffsetY = 14,
	RankPipSpacingX = 26,
	RankPipSpacingY = 0,
	RankPipScale = 0.48,
	RankPipEmpty = "GUI\\Screens\\Shrine\\PipUnfilled",
	FilledRankPips =
	{
		"GUI\\Screens\\Shrine\\PipFilled01",
		"GUI\\Screens\\Shrine\\PipFilled02",
		"GUI\\Screens\\Shrine\\PipFilled03",
		"GUI\\Screens\\Shrine\\PipFilled04",
	},
	RankPipFullFx = "ShrinePipFilledFx",
	
	PointsAddedThisTime = 0,

	Components = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 16,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	NoBountyAvailableText = "ShrineScreen_NoBountyAvailable",
	NoBountyAvailableForWeaponText = "ShrineScreen_NoBountyAvailable_CurrentWeapon",
	ZeroShrinePointsText = "ShrineScreen_BountyAvailable_ZeroPoints",
	BelowShrinePointsText = "ShrineScreen_BountyAvailable_BelowPoints",
	ExactShrinePointsText = "ShrineScreen_BountyAvailable_ExactPoints",	
	ExcessShrinePointsText =
	{
		[1] = "ShrineScreen_BountyAvailable_ExcessPoints1",
		[5] = "ShrineScreen_BountyAvailable_ExcessPoints2",
		[10] = "ShrineScreen_BountyAvailable_ExcessPoints3",
	},
	MaxShrinePointsText = "ShrineScreen_BountyAvailable_MaxPoints",

	UnderworldShrinePointThresholds = { 8, 16, 32 },
	SurfaceShrinePointThresholds = { 6, 12, 24 },

	MaxBountiesAvailable = 6,

	BountyRowStartX = 216,
	BountyRowStartY = 196,
	BountyItemsPerRow = 3,
	BountyRowSpacingX = 150,
	BountyRowSpacingY = 160,
	BountyShrinePointsOffsetX = 16,
	BountyShrinePointsOffsetY = -54,
	BountyWeaponOffsetX = -3,
	BountyWeaponOffsetY = 49,
	BountyTargetOffsetX = 0,
	BountyTargetOffsetY = 0,

	BountyWeaponIconScale = 0.55,
	BountyBossIconScale = 1.0,

	BountyWeaponIcons =
	{
		WeaponStaffSwing = "GUI\\Screens\\Shrine\\WeaponStaff",
		WeaponDagger = "GUI\\Screens\\Shrine\\WeaponDagger",
		WeaponAxe = "GUI\\Screens\\Shrine\\WeaponAxe",
		WeaponLob = "GUI\\Screens\\Shrine\\WeaponSkull",
		WeaponTorch = "GUI\\Screens\\Shrine\\WeaponTorch",
		WeaponSuit = "GUI\\Screens\\Shrine\\WeaponSuit",
	},

	BountyTargetIcons =
	{
		BossHecate01 = "GUI\\Screens\\Shrine\\BossWitch",
		BossScylla01 = "GUI\\Screens\\Shrine\\BossMonstress",
		BossInfestedCerberus01 = "GUI\\Screens\\Shrine\\BossBeast",
		BossChronos01 = "GUI\\Screens\\Shrine\\BossTime",
		BossPolyphemus01 = "GUI\\Screens\\Shrine\\BossCyclops",
		BossEris01 = "GUI\\Screens\\Shrine\\BossStrife",
		BossPrometheus01 = "GUI\\Screens\\Shrine\\BossFlame",
		BossTyphonHead01 = "GUI\\Screens\\Shrine\\BossSnake",
	},

	BountyShrinePointsFormat =
	{

		Font = "P22UndergroundSCMedium",
		FontSize = 24,
		Justification = "Center",

		TextSymbolScale = 0.85,
		DataProperties =
		{
			OpacityWithOwner = false,
		}
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"Background",
			"CreateShrineScreenDelay",
			"ActionBarBackground",

			"SkellyQuestSurface",
			"SkellyQuestSurfaceStrikethrough",
			"SkellyQuestUnderworld",
			"SkellyQuestUnderworldStrikethrough",

			"SkellyQuestCompleteIcon",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 4,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "ShrineIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		CreateShrineScreenDelay = 
		{
			FunctionName = "CreateShrineScreenDelay",
		},

		--Testament Header
		BountyHeader =
		{
			X = 365,
			Y = 93,
			Text = "ShrineScreen_BountyHeader",
			TextArgs =
			{
				FontSize = 26,
				Width = 840,
				Color = {10, 22, 17, 255},
				Font = "P22UndergroundSCHeavy",
				Justification = "Center",
				TextSymbolScale = 1.0,
				DataProperties =
					{
						TextSymbolUseLineColor = true,
					},
			},
		},

		SkellyHeader =
		{
			X = 365,
			Y = 475,
			Text = "ShrineScreen_SkellyHeader",
			TextArgs =
			{
				FontSize = 23,
				Width = 840,
				Color = {150, 99, 205, 255},
				Font = "LatoBoldItalic",
				ShadowBlur = 0,
				ShadowColor = {0, 0, 0, 255},
				--ShadowOffset = {0, 1},
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
			Requirements = 
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyHeader_Complete =
		{
			X = 365,
			Y = 472,
			Text = "ShrineScreen_SkellyHeader_Complete",
			TextArgs =
			{
				FontSize = 22,
				Width = 840,
				Color = {150, 99, 205, 255},
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0,
				ShadowColor = {0, 0, 0, 255},
				ShadowOffset = {0, 1},
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
			Requirements = 
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
			},
		},

		SkellyQuestSurface =
		{
			X = 380,
			Y = 536,
			Animation = "GUI\\Screens\\Shrine\\SkellyIncomplete",
			TextArgs = MergeTables( UIData.ShrineBountyAvailableTextArgs, { FontSize = 18, OffsetX = -225, OffsetY = 0 } ),
			Requirements = 
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestSurfaceStrikethrough =
		{
			X = 380,
			Y = 536,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Animation = "GUI\\Screens\\Shrine\\Strikethrough",
			GroupName = "Combat_Menu_Overlay",
			Requirements = 
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestUnderworld =
		{
			X = 380,
			Y = 599,
			Animation = "GUI\\Screens\\Shrine\\SkellyIncomplete",
			TextArgs = MergeTables( UIData.ShrineBountyAvailableTextArgs, { FontSize = 18, OffsetX = -225, OffsetY = 0 } ),
			Requirements = 
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestUnderworldStrikethrough =
		{
			X = 380,
			Y = 599,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Animation = "GUI\\Screens\\Shrine\\Strikethrough",
			GroupName = "Combat_Menu_Overlay",
			Requirements = 
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},

		SkellyQuestCompleteIcon =
		{
			X = 350,
			Y = 575,
			ScaleX = 0.67,
			ScaleY = 0.67,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Animation = "GUI\\Screens\\Shrine\\ReclinedSkellyCarving",
			GroupName = "Combat_Menu_Overlay",
			Requirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
			},
		},

		ThermometerForeground =
		{
			Animation = "ShrineMeterBarFill", -- nopkg
			X = 755,
			Y = 690,
		},

		ThermometerFx =
		{
			Animation = "ShrinePactThermometerFx", -- nopkg
			X = 755,
			Y = 690,
			GroupName = "Combat_Menu_Additive",
		},

		ThermometerFlame =
		{
			Animation = "ShrinePactThermometerFlame", -- nopkg
			X = 755,
			Y = 690,
			GroupName = "Combat_Menu_Additive",
		},

		ThermometerFullFx = 
		{
			Animation = "ShrinePactThermometerFxGlow",
			X = 1210,
			Y = 690,
			GroupName = "Combat_Menu_Additive",
		},

		ThermometerText = 
		{
			Text = "BelowShrineRewardThreshold",
			X = 750,
			Y = 737,
			TextArgs =
			{
				FontSize = 17,
				Color = {176, 136, 255, 255},
				Font = "LatoItalic",
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset={0, 1},
				Justification = "Center",
			},
		},

		ActiveShrinePoints = 
		{
			X = 1275,
			Y = 687,
			TextArgs =
			{
				Text = "ShrineScreen_ActivePoints",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 44,
				Justification = "Left",
				Color = {10, 255, 0, 255},
				OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
				TextSymbolScale = 0.8,
				TextSymbolOffsetX = -100,
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		InfoBoxBacking =
		{
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			GroupName = "Combat_Menu",
			X = 755,
			Y = 870,
			Alpha = 0.0,
			UseableOff = true,
			InteractProperties =
			{
				FreeFormSelectable = false,
			},

			ChildrenOrder =
			{
				"InfoBoxIcon",
				"InfoBoxFrame",
			},

			Children =
			{
				InfoBoxIcon = 
				{
					Graphic = "BlankObstacle",
					Scale = ScreenData.UpgradeChoice.Icon.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				InfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = ScreenData.UpgradeChoice.Frame.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				InfoBoxName =
				{
					TextArgs = ScreenData.UpgradeChoice.TitleText,
				},
				InfoBoxRarity =
				{
					TextArgs = ScreenData.UpgradeChoice.RarityText,
				},

				InfoBoxDescription =
				{ 
					TextArgs = ScreenData.UpgradeChoice.DescriptionText,
				},
				InfoBoxStatLineLeft =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
				},
				InfoBoxStatLineRight =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineRight,
				},
				InfoBoxFlavor =
				{
					TextArgs = ScreenData.UpgradeChoice.FlavorText,
				},
			}
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			UseScreenScaleX = true,
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
			},

			Children =
			{
			},
		},

		ActionBarRight =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"InfoButton",
				"ResetAllButton",
				"RankUp",
				"RankDown",
			},

			Children =
			{
				InfoButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "GenericInfoPresentation",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_Info",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ResetAllButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "ShrineLogicResetAll",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "ShrineScreen_ResetAll",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				RankDown =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing - UIData.ContextualButtonSpacing - 200,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "ShrineScreenRankDown",
						ControlHotkeys = { "RankDown", },
					},
					Text = "ShrineScreen_RankDown",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				RankUp =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "ShrineScreenRankUp",
						--ControlHotkeys = { "Select", },
					},
					Text = "ShrineScreen_RankUp",
					AltText = "ShrineScreen_Activate",
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
						OnPressedFunctionName = "CloseShrineUpgradeScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},

	OpenVoiceLines = 
	{
		{
			PlayOnce = true,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "HecateBossGrantsShrineUpgrade01", "HecateGrantsShrineUpgrade01" }
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = "<",
					Value = 1,
				},
			},
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_4404", Text = "The Vow of Rivals..." },
		},
		{
			PlayOnce = true,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT2" },
				},
				{
					Path = { "GameState", "RoomsEntered" },
					HasNone = { "G_Boss02", "O_Boss02" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = "<",
					Value = 2,
				},
			},
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_4405", Text = "I can intensify the Vow of Rivals now..." },
		},
		{
			PlayOnce = true,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT3" },
				},
				{
					Path = { "GameState", "RoomsEntered" },
					HasNone = { "H_Boss02" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = "<",
					Value = 3,
				},
			},
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_4406", Text = "More to the Vow of Rivals now..." },
		},
		{
			PlayOnce = true,
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBossDifficultyT4" },
				},
				{
					Path = { "GameState", "RoomsEntered" },
					HasNone = { "Q_Boss02" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = { "ChronosBossAboutAltFight01" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = "<",
					Value = 4,
				},
			},
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_4407", Text = "The Vow of Rivals is at full potential now..." },
		},
		-- in the darkness listen carefully to hear her
		{
			PlayOnce = true,
			PlayOnceContext = "NyxShrineIntroVO",
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				-- completed a Shrine Bounty this run
				{
					PathNotEmpty = { "CurrentRun", "ShrineBountiesCompleted" },
				},
			},
			{ Cue = "/VO/Nyx_0006", Text = "{#Emph}...My will be done...", Source = { LineHistoryName = "NPC_NyxVoice_01", SubtitleColor = Color.NyxVoice }, },
			{ Cue = "/VO/Melinoe_1937", Text = "What was that...", PreLineWait = 1.5, BreakIfPlayed = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.85,
			Source = { LineHistoryName = "NPC_NyxVoice_01", SubtitleColor = Color.NyxVoice },
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				-- completed a Shrine Bounty this run
				{
					PathNotEmpty = { "CurrentRun", "ShrineBountiesCompleted" },
				},
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Nyx_0006" }
				},
			},

			{ Cue = "/VO/Nyx_0002", Text = "{#Emph}...Darkness guide you..." },
			{ Cue = "/VO/Nyx_0003", Text = "{#Emph}...Go unseen..." },
			{ Cue = "/VO/Nyx_0004", Text = "{#Emph}...Serve in shadow..." },
			{ Cue = "/VO/Nyx_0005", Text = "{#Emph}...For the realm..." },
			{ Cue = "/VO/Nyx_0006", Text = "{#Emph}...My will be done..." },
			{ Cue = "/VO/Nyx_0007", Text = "{#Emph}...Fear spreads..." },
			{ Cue = "/VO/Nyx_0008", Text = "{#Emph}...By Night and Darkness..." },
			{ Cue = "/VO/Nyx_0009", Text = "{#Emph}...Shadows conceal you..." },
			{ Cue = "/VO/Nyx_0010", Text = "{#Emph}...Remain unseen..." },
			{ Cue = "/VO/Nyx_0011", Text = "{#Emph}...Bring Fear..." },
			{ Cue = "/VO/Nyx_0013", Text = "{#Emph}...Continue on..." },
			{ Cue = "/VO/Nyx_0014", Text = "{#Emph}...Spread Fear..." },
			{ Cue = "/VO/Nyx_0015", Text = "{#Emph}...Move in shadow..." },
			{ Cue = "/VO/Nyx_0016", Text = "{#Emph}...We shall be feared..." },
			{ Cue = "/VO/Nyx_0017", Text = "{#Emph}...Let them fear us..." },
			{ Cue = "/VO/Nyx_0012", Text = "{#Emph}...You have done well...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineBountiesCompleted" },
						UseLength = true,
						Comparison = ">=",
						Value = 15,
					},
				},
			},
		},
		{
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.85,
			PlayOnce = true,
			PlayOnceContext = "ShrineFirstTimeOpenedVO",
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_2862", Text = "{#Emph}In shadow, I serve; to shadow, I return." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.75,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
				},
			},
			Cooldowns =
			{
				{ Name = "ShrineOpenVOPlayedRecently", Time = 60 },
				{ Name = "ShrineVOQuippedRecently", Time = 4 },
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_2565", Text = "Do I dare...?" },
			{ Cue = "/VO/Melinoe_2566", Text = "Nothing of worth without struggle..." },
			{ Cue = "/VO/Melinoe_0975", Text = "The will of Night." },
			{ Cue = "/VO/Melinoe_0976", Text = "What would Night have me do?" },
			{ Cue = "/VO/Melinoe_0977", Text = "What is the will of Night?" },
			{ Cue = "/VO/Melinoe_2856", Text = "May need to take new Vows..." },
			-- { Cue = "/VO/Melinoe_2857", Text = "Should check the Oath..." },
			{ Cue = "/VO/Melinoe_2858", Text = "The Oath calls to me..." },
			{ Cue = "/VO/Melinoe_2859", Text = "The Oath beckons..." },
			{ Cue = "/VO/Melinoe_2860", Text = "Another Testament awaits.",
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "AllShrineBountiesCompleted" },
				},
			},
			{ Cue = "/VO/Melinoe_2861", Text = "There's Fear in the air..." },
			{ Cue = "/VO/Melinoe_2864", Text = "The Oath..." },
			{ Cue = "/VO/Melinoe_2865", Text = "A healthy fear of darkness..." },
			{ Cue = "/VO/Melinoe_2866", Text = "Dare I take the vows?" },
			{ Cue = "/VO/Melinoe_2867", Text = "The Testament of Night." },
			{ Cue = "/VO/Melinoe_2868", Text = "Do not avert your gaze..." },
			{ Cue = "/VO/Melinoe_1342", Text = "If I'm to serve the Night, I would know her will..." },
			{ Cue = "/VO/Melinoe_1344", Text = "I can deepen my connection with the Night..." },
			{ Cue = "/VO/Melinoe_2862", Text = "{#Emph}In shadow, I serve; to shadow, I return.",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 6,
						Path = { "SpeechRecord", "/VO/Melinoe_2862" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
				}
			},
			{ Cue = "/VO/Melinoe_2863", Text = "The Oath of the Unseen...",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "SpeechRecord", "/VO/Melinoe_2863" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
				}
			},
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			SuccessiveChanceToPlay = 0.15,
			ObjectType = "NPC_Skelly_01",
			Cooldowns =
			{
				{ Name = "SkellyAnyQuipSpeech", Time = 35 },
			},

			{ Cue = "/VO/Skelly_0250", Text = "The Oath of the Unseen!", PlayFirst = true },
			{ Cue = "/VO/Skelly_0251", Text = "Heed well the Oath!" },
			{ Cue = "/VO/Skelly_0253", Text = "Do you swear?" },
		},
	},
	ChangeMadeCloseVoiceLines = 
	{
		Cooldowns =
		{
			{ Name = "ShrineClosedVOPlayedRecently", Time = 60 },
		},
		TriggerCooldowns = { "ShrineOpenVOPlayedRecently" },
		{
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{
					UsePlayerSource = true,
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.75,

					{ Cue = "/VO/Melinoe_2889", Text = "Best be a little cautious here." },
					{ Cue = "/VO/Melinoe_2890", Text = "Night's Testament can wait..." },
					{ Cue = "/VO/Melinoe_2891", Text = "No need for recklessness..." },
					{ Cue = "/VO/Melinoe_2892", Text = "Perhaps some other eve..." },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.35,
					ObjectType = "NPC_Skelly_01",
					Cooldowns =
					{
						{ Name = "SkellyAnyQuipSpeech", Time = 35 },
					},

					{ Cue = "/VO/Skelly_0268", Text = "Probably smart." },
					{ Cue = "/VO/Skelly_0269", Text = "Don't blame you in the least." },
					{ Cue = "/VO/Skelly_0270", Text = "Vows, {#Emph}shmows!" },
					{ Cue = "/VO/Skelly_0271", Text = "The Oath can wait!" },
				}
			},
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = "<=",
						Value = 36,
					},
				},
				{
					UsePlayerSource = true,
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.75,

					{ Cue = "/VO/Melinoe_2875", Text = "Night and Darkness, guide me..." },
					{ Cue = "/VO/Melinoe_2876", Text = "The veil of Darkness spreads..." },
					{ Cue = "/VO/Melinoe_2877", Text = "Night protect me..." },
					{ Cue = "/VO/Melinoe_2878", Text = "For the will of Night." },
					{ Cue = "/VO/Melinoe_2879", Text = "The growing Fear..." },
					{ Cue = "/VO/Melinoe_2880", Text = "For the Unseen." },
					{ Cue = "/VO/Melinoe_2881", Text = "My Vows are made." },
					{ Cue = "/VO/Melinoe_2882", Text = "Should be a lively evening." },
					{ Cue = "/VO/Melinoe_2883", Text = "All should be properly afraid..." },
					{ Cue = "/VO/Melinoe_2884", Text = "Fear is for the living and the dead... " },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.35,
					ObjectType = "NPC_Skelly_01",
					Cooldowns =
					{
						{ Name = "SkellyAnyQuipSpeech", Time = 35 },
					},

					{ Cue = "/VO/Skelly_0254", Text = "Fear spreads!" },
					{ Cue = "/VO/Skelly_0255", Text = "I'm so scared...!" },
					{ Cue = "/VO/Skelly_0256", Text = "{#Emph}Ooh{#Prev}, scary..." },
					{ Cue = "/VO/Skelly_0257", Text = "Positively frightening..." },
					{ Cue = "/VO/Skelly_0258", Text = "As I am your witness!" },
					{ Cue = "/VO/Skelly_0259", Text = "Don't say I didn't warn ya!" },
					{ Cue = "/VO/Skelly_0260", Text = "You got guts, kiddo." },
					{ Cue = "/VO/Skelly_0261", Text = "Such courage in the face of Fear!" },
					{ Cue = "/VO/Skelly_0262", Text = "I'm shaking over here!" },
					{ Cue = "/VO/Skelly_0263", Text = "{#Emph}Eugh, {#Prev}the {#Emph}Fear!" },
					{ Cue = "/VO/Skelly_0252", Text = "Thus have you sworn." },
					{ Cue = "/VO/Skelly_0149", Text = "You done with that thing?" },
					{ Cue = "/VO/Skelly_0150", Text = "{#Emph}Beware{#Prev}, young one." },
				},
			},
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 36,
					},
				},
				{
					UsePlayerSource = true,
					PreLineWait = 0.35,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,

					{ Cue = "/VO/Melinoe_2885", Text = "I don't know about this..." },
					{ Cue = "/VO/Melinoe_2886", Text = "Who am I trying to impress...?" },
					{ Cue = "/VO/Melinoe_2887", Text = "Well, I'm terrified..." },
					{ Cue = "/VO/Melinoe_2888", Text = "What could go wrong...?" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.35,
					ObjectType = "NPC_Skelly_01",
					Cooldowns =
					{
						{ Name = "SkellyAnyQuipSpeech", Time = 35 },
					},

					{ Cue = "/VO/Skelly_0264", Text = "Have you gone {#Emph}daft?!" },
					{ Cue = "/VO/Skelly_0265", Text = "You sure about this?" },
					{ Cue = "/VO/Skelly_0266", Text = "Askin' for trouble, kiddo..." },
					{ Cue = "/VO/Skelly_0267", Text = "Let's think about this here!" },
				},
			},

		},
	},
}