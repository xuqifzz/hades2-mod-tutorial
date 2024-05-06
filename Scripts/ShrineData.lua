ShrineUpgradeOrder =
{
	"EnemyDamageShrineUpgrade",
	"EnemyHealthShrineUpgrade",
	"EnemyShieldShrineUpgrade",
	"EnemySpeedShrineUpgrade",

	"FirstDamageShrineUpgrade",
	"EnemyCountShrineUpgrade",
	--"MinibossCountShrineUpgrade",
	--"EnemyEliteShrineUpgrade",

	"EnemyRespawnShrineUpgrade",
	"NextBiomeEnemyShrineUpgrade",
	"HealingReductionShrineUpgrade",
	"ShopPricesShrineUpgrade",

	"RoomStartManaShrineUpgrade",
	"BanUnpickedBoonsShrineUpgrade",
	"BoonSkipShrineUpgrade",
	"BoonManaReserveShrineUpgrade",

	"BiomeSpeedShrineUpgrade",
	"NoMetaUpgradesShrineUpgrade",

	--"BossDifficultyShrineUpgrade",	
}

BiomeTimeLimits =
{
	Penalty =
	{
		Damage = 5,
		Interval = 1,
	},
}

UIData.ShrineBountyAvailableTextArgs =
{
	FadeTarget = 0.0,
	FadeOpacity = 0.0,
	FontSize = 20,
	OffsetX = -683,
	OffsetY = -290,
	Width = 840,
	Color = Color.White,
	Font = "LatoMedium",
	ShadowBlur = 0,
	ShadowColor = {0,0,0,255},
	ShadowOffset = {0, 1},
	Justification = "Left",
	TextSymbolScale = 1.0,
}

ScreenData.Shrine =
{
	BlockPause = true,
	ItemStartX = 831,
	ItemStartY = 145,
	ItemSpacingX = 133,
	ItemSpacingY = 136,
	ItemsPerRow = 5,
	ScrollOffset = 0,
	
	BountyOrder =
	{
		-- Heat 1 Bounties
		"BountyStaffHeat1FBoss",
		"BountyDaggerHeat1GBoss",
		"BountyTorchHeat1OBoss",
		"BountyAxeHeat1NBoss",
		"BountyLobHeat1HBoss",

		-- Heat 2 Bounties
		"BountyStaffHeat2GBoss",
		"BountyDaggerHeat2NBoss",
		"BountyTorchHeat2HBoss",
		"BountyAxeHeat2OBoss",
		--"BountyLobHeat2PBoss",

		-- Heat 4 Bounties
		"BountyStaffHeat4NBoss",
		"BountyDaggerHeat4OBoss",
		--"BountyTorchHeat4PBoss",
		"BountyAxeHeat4HBoss",
		"BountyLobHeat4FBoss",

		-- Heat 8 Bounties
		"BountyStaffHeat8OBoss",
		"BountyDaggerHeat8HBoss",
		"BountyTorchHeat8FBoss",
		--"BountyAxeHeat8PBoss",
		"BountyLobHeat8GBoss",

		-- Heat 12 Bounties
		"BountyStaffHeat12HBoss",
		--"BountyDaggerHeat12PBoss",
		"BountyTorchHeat12GBoss",
		"BountyAxeHeat12FBoss",
		"BountyLobHeat12NBoss",

		-- Heat 16 Bounties
		--"BountyStaffHeat16PBoss",
		"BountyDaggerHeat16FBoss",
		"BountyTorchHeat16NBoss",
		"BountyAxeHeat16GBoss",
		"BountyLobHeat16OBoss",

		-- Heat 20 Bounties
		"BountyStaffHeat20IBoss",
		--"BountyDaggerHeat20QBoss",
		--"BountyTorchHeat20QBoss",
		"BountyAxeHeat20IBoss",
		"BountyLobHeat20IBoss",

		-- Heat 24 Bounties
		--"BountyStaffHeat24QBoss",
		"BountyDaggerHeat24IBoss",
		"BountyTorchHeat24IBoss",
		--"BountyAxeHeat24QBoss",
		--"BountyLobHeat24QBoss",
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
	},

	OpenSound = "/SFX/Menu Sounds/PactMenuOpenSFX",
	CloseSound = "/SFX/Menu Sounds/PactMenuCloseSFX",
	MouseOverSound = "/SFX/Menu Sounds/DialoguePanelOut",
    ToggleOnSound = "/SFX/Menu Sounds/MirrorMenuStatIncrease",
    ToggleOffSound = "/SFX/Menu Sounds/MirrorMenuStatLower",

	InfoMessageId = "ShrineIntro",

	InvestedColor = Color.MetaUpgradePointsInvalidPulseColor,
	UnlockVoiceLines = HeroVoiceLines.ShrineUpgradeUnlockedVoiceLines,
	RefundPresentationName = "ShrinePointRefundPresentation",
	SpendPresentationName = "ShrinePointSpendPresentation",
	HighlightX = 0,
	BackingOffsetX = 40,

	TooltipX = 1670,
	TooltipY = 450,

	IconActiveColor = Color.White,
	IconInactiveColor = { 169, 169, 169, 128 },

	BountyActiveColor = Color.White, --[[{189, 234, 44, 255}]]
	BountyInactiveColor = {255, 255, 255, 40}, --[[{53, 58, 69, 235}]]
	
	ActiveVariableColor = Color.PenaltyRed,
	InactiveVariableColor = { 230, 230, 230, 255 },

	IconBackingScale = 1.15,
	IconScale = 0.4,
	IconMouseOverScale = 0.5,

	NextRankMaxColor = { 169, 169, 169, 255 },
	NextRankFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 21,
		OffsetX = 64,
		OffsetY = -52,
		ShadowBlur = 0,				
		ShadowColor = {0,0,0,1},
		ShadowOffset = {3, 3},
		Justification = "Right",
		TextSymbolScale = 0.7,
		DataProperties =
		{
			OpacityWithOwner = false,
		}
	},

	BackingTooltipOffsetX = 35 - 68,
	BackingTooltipOffsetY = 1,

	IconX = 970 - 68,

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

	ShrinePointThresholds =
	{
		8,
		16,
		32,
	},

	MaxBountiesAvailable = 6,

	BountyRowStartX = 250,
	BountyRowStartY = 196,
	BountyItemsPerRow = 3,
	BountyRowSpacingX = 150,
	BountyRowSpacingY = 160,
	BountyShrinePointsOffsetX = 5,
	BountyShrinePointsOffsetY = -52,
	BountyWeaponOffsetX = 0,
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
	},

	BountyTargetIcons =
	{
		BossHecate01 = "GUI\\Screens\\Shrine\\BossWitch",
		BossScylla01 = "GUI\\Screens\\Shrine\\BossMonstress",
		BossInfestedCerberus01 = "GUI\\Screens\\Shrine\\BossBeast",
		BossChronos01 = "GUI\\Screens\\Shrine\\BossTime",
		BossPolyphemus01 = "GUI\\Screens\\Shrine\\BossCyclops",
		BossEris01 = "GUI\\Screens\\Shrine\\BossStrife",
	},

	BountyShrinePointsFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 21,
		Justification = "Center",
		TextSymbolScale = 0.85,
		DataProperties =
		{
			OpacityWithOwner = false,
		}
	},

	SelectionHighlight =
	{
		AnimationName = "GUI\\Screens\\Shrine\\PactHover",
		Scale = 1.15,
	},

	NextRankBackingOffsetX = 38,
	NextRankBackingOffsetY = -50,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"BackgroundSplatter",
			"Background",
			"ActionBarBackground",

			"SkellyQuestSurface",
			"SkellyQuestSurfaceStrikethrough",
			"SkellyQuestUnderworld",
			"SkellyQuestUnderworldStrikethrough",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 4,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		BackgroundSplatter = 
		{
			Graphic = "LevelUpBackground",
		},

		Background = 
		{
			AnimationName = "GUI\\Screens\\Shrine\\Background",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		BountyHeader =
		{
			X = 400,
			Y = 93,
			Text = "ShrineScreen_BountyHeader",
			TextArgs =
			{
				FontSize = 26,
				Width = 840,
				Color = Color.White,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0,
				ShadowColor = {0, 0, 0, 255},
				ShadowOffset = {0, 1},
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
		},

		--[[BountyColumnShrinePoints =
		{
			X = 150,
			Y = 135,
			Text = "ShrineScreen_BountyColumnShrinePoints",
			TextArgs =
			{
				FontSize = 21,
				Width = 840,
				Color = Color.Black,
				Font = "P22UndergroundSCHeavy",
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
		},]]--

		--[[BountyColumnWeapon =
		{
			X = 380,
			Y = 135,
			Text = "ShrineScreen_BountyColumnWeapon",
			TextArgs =
			{
				FontSize = 21,
				Width = 840,
				Color = Color.Black,
				Font = "P22UndergroundSCHeavy",
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
		},]]--

		--[[BountyColumnTarget =
		{
			X = 600,
			Y = 135,
			Text = "ShrineScreen_BountyColumnTarget",
			TextArgs =
			{
				FontSize = 21,
				Width = 840,
				Color = Color.Black,
				Font = "P22UndergroundSCHeavy",
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
		},]]--

		SkellyHeader =
		{
			X = 405,
			Y = 472,
			Text = "ShrineScreen_SkellyHeader",
			TextArgs =
			{
				FontSize = 24,
				Width = 840,
				Color = Color.White,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0,
				ShadowColor = {0, 0, 0, 255},
				ShadowOffset = {0, 1},
				Justification = "Center",
				TextSymbolScale = 1.0,
			},
			Requirements = 
			{
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},

		SkellyQuestSurface =
		{
			X = 410,
			Y = 536,
			Animation = "GUI\\Screens\\Shrine\\SkellyIncomplete",
			TextArgs = MergeTables( UIData.ShrineBountyAvailableTextArgs, { OffsetX = -225, OffsetY = 0 } ),
			Requirements = 
			{
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestSurfaceStrikethrough =
		{
			X = 410,
			Y = 536,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Animation = "GUI\\Screens\\Shrine\\Strikethrough",
			GroupName = "Combat_Menu_Overlay",
			Requirements = 
			{
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestUnderworld =
		{
			X = 410,
			Y = 599,
			Animation = "GUI\\Screens\\Shrine\\SkellyIncomplete",
			TextArgs = MergeTables( UIData.ShrineBountyAvailableTextArgs, { OffsetX = -225, OffsetY = 0 } ),
			Requirements = 
			{
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},
		SkellyQuestUnderworldStrikethrough =
		{
			X = 410,
			Y = 599,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Animation = "GUI\\Screens\\Shrine\\Strikethrough",
			GroupName = "Combat_Menu_Overlay",
			Requirements = 
			{
				NamedRequirements = { "TrophyQuestUnlocked" },
			},
		},

		ThermometerForeground =
		{
			Graphic = "ShrineMeterBarFill",
			X = 755,
			Y = 690,
		},

		ThermometerText = 
		{
			Text = "BelowShrineRewardThreshold",
			X = 750,
			Y = 737,
			TextArgs =
			{
				FontSize = 17,
				Color = {0.300, 1.00, 0.976, 1.0},
				Font = "LatoItalic",
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset={0, 1},
				Justification = "Center",
			},
		},

		ActiveShrinePoints = 
		{
			X = 1295,
			Y = 687,
			TextArgs =
			{
				Text = "ShrineScreen_ActivePoints",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
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

			{ Cue = "/VO/Melinoe_2862", Text = "{#Emph}In shadow, I serve; to shadow, I return.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2565", Text = "Do I dare...?" },
			{ Cue = "/VO/Melinoe_2566", Text = "Nothing of worth without struggle..." },
			{ Cue = "/VO/Melinoe_0975", Text = "The will of Night." },
			{ Cue = "/VO/Melinoe_0976", Text = "What would Night have me do?" },
			{ Cue = "/VO/Melinoe_0977", Text = "What is the will of Night?" },
			{ Cue = "/VO/Melinoe_2856", Text = "May need to take new Vows..." },
			-- { Cue = "/VO/Melinoe_2857", Text = "Should check the Oath..." },
			{ Cue = "/VO/Melinoe_2858", Text = "The Oath calls to me..." },
			{ Cue = "/VO/Melinoe_2859", Text = "The Oath beckons..." },
			{ Cue = "/VO/Melinoe_2860", Text = "Another Testament awaits." },
			{ Cue = "/VO/Melinoe_2861", Text = "There's Fear in the air..." },
			{ Cue = "/VO/Melinoe_2864", Text = "The Oath..." },
			{ Cue = "/VO/Melinoe_2865", Text = "A healthy fear of darkness..." },
			{ Cue = "/VO/Melinoe_2866", Text = "Dare I take the vows?" },
			{ Cue = "/VO/Melinoe_2867", Text = "The Testament of Night." },
			{ Cue = "/VO/Melinoe_2868", Text = "Do not avert your gaze..." },
			{ Cue = "/VO/Melinoe_1342", Text = "If I'm to serve the Night, I would know her will..." },
			{ Cue = "/VO/Melinoe_1344", Text = "I can deepen my connection with the Night..." },
			{ Cue = "/VO/Melinoe_2863", Text = "The Oath of the Unseen...",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_2863" }
					},
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_2863" }
					},
				},
			},
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			SuccessiveChanceToPlay = 0.15,
			ObjectType = "NPC_Skelly_01",
			Cooldowns =
			{
				{ Name = "SkellyQuipAnySpeech", Time = 35 },
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
						{ Name = "SkellyQuipAnySpeech", Time = 35 },
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
						{ Name = "SkellyQuipAnySpeech", Time = 35 },
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
						{ Name = "SkellyQuipAnySpeech", Time = 35 },
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