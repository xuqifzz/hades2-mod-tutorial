-- Mailbox
GlobalVoiceLines.OpenedMailboxVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelUsedMailboxSpeech", Time = 30 },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		SkipAnim = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				FunctionName = "IsMailboxItemInStock",
				FunctionArgs = { Name = "WeaponPointsRare" },
			},
		},

		{ Cue = "/VO/Melinoe_5377", Text = "Nightmare now available for order." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		SkipAnim = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				FunctionName = "IsMailboxItemInStock",
				FunctionArgs = { Name = "CardUpgradePoints" },
			},
		},

		{ Cue = "/VO/Melinoe_5378", Text = "I can procure more Moon Dust..." },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlay = 0.05,
		PlayOnceFromTableThisRun = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_2601", Text = "Special-order privileges from Lord Charon himself...", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Melinoe_2277", Text = "Lord Charon's Gold Rewards..." },
	},
}

GlobalVoiceLines.TradedMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		},

		{ Cue = "/VO/Melinoe_2288", Text = "Now we wait..." },
		{ Cue = "/VO/Melinoe_2289", Text = "Could use this." },
		{ Cue = "/VO/Melinoe_2290", Text = "Order approved.", PlayFirst = true, },
		{ Cue = "/VO/Melinoe_2291", Text = "Ordering this." },
		{ Cue = "/VO/Melinoe_2292", Text = "Shouldn't be too long." },
		{ Cue = "/VO/Melinoe_2293", Text = "Should be here soon enough." },
	},
}
GlobalVoiceLines.CannotAffordMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2294", Text = "Not eligible." },
		{ Cue = "/VO/Melinoe_2295", Text = "Not authorized." },
		{ Cue = "/VO/Melinoe_2296", Text = "I'll have to turn in more Gold.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2297", Text = "Can't redeem that yet." },
	},
}
GlobalVoiceLines.WaitingForMailboxItemVoiceLines =
{
	{
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
		},
		
		{ Cue = "/VO/Melinoe_2329", Text = "This'll take a little while..." },
		{ Cue = "/VO/Melinoe_2330", Text = "It'll be worth the wait." },
	},
}

ScreenData.MailboxScreen =
{
	Components = {},
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/CharonMailboxOpen",
	CloseSound = "/SFX/Menu Sounds/CharonMailboxClose",

	MaxNonPriorityOffers = 1,

	MoneySpentPerCharonPoint = 1000,
	CharonPointsRequirements =
	{
		{
			PathTrue = { "GameState", "UseRecord", "CharonPointsDrop" },
		},
		NamedRequirements = { "MailboxUnlocked" },
	},

	NumItems = 0,

	CategoryStartX = 735,
	CategoryStartY = 165,
	CategorySpacingX = 226,

	ItemStartX = 734,
	ItemStartY = 335,
	ItemSpacingY = 118,
	ItemTextBoxOffsetX = 480,
	IconOffsetX = -354,
	IconOffsetY = 0,
	ItemsPerPage = 5,
	ScrollOffset = 0,

	PinOffsetX = 392,

	ItemAnimation = "MailboxScreenButton",
	ItemMouseOverAnimation = "MailboxScreenButtonIn",
	ItemMouseOffAnimation = "MailboxScreenButtonOut",

	FadeOutTime = 0.20,
	CloseDestroyWait = 0.35,

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = true,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	ItemCategories =
	{
		{
			Name = "MailboxScreen_Default",
			GameStateRequirements =
			{
				-- None
			},
			{ 
				BuyName = "MetaCardPointsCommon", BuyAmount = 20,
				DeliveryTimeMin = 20,
				DeliveryTimeMax = 20,
				Cost =
				{
					CharonPoints = 1,
				},
				Priority = true, 
				PurchaseSound = "/SFX/AshRewardPickup",
			},

			{ 
				BuyName = "MemPointsCommon", BuyAmount = 80,
				DeliveryTimeMin = 30,
				DeliveryTimeMax = 30,
				Cost =
				{
					CharonPoints = 2,
				},
				Priority = true, 
				PurchaseSound = "/SFX/Player Sounds/PsycheRewardPickup",
			},
			{ 
				BuyName = "MetaFabric", BuyAmount = 10,
				DeliveryTimeMin = 40,
				DeliveryTimeMax = 40,
				Cost =
				{
					CharonPoints = 3,
				},
				Priority = true, 
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
			},
			{ 
				BuyName = "CardUpgradePoints", BuyAmount = 8,
				DeliveryTimeMin = 60,
				DeliveryTimeMax = 60,
				Cost =
				{
					CharonPoints = 4,
				},
				Priority = true, 
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY",

				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
			{ 
				BuyName = "WeaponPointsRare", BuyAmount = 2,
				DeliveryTimeMin = 100,
				DeliveryTimeMax = 100,
				Cost =
				{
					CharonPoints = 5,
				},
				Priority = true, 
				PurchaseSound = "/SFX/TitanBloodPickupSFX",

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutCharonPoints01" },
					},
				},
			},
		},
	},

	CostTextArgs =
	{
		OffsetX = 320,
		OffsetY = 0,
		TextSymbolScale = 0.8,
		FontSize = 22,
		Justification = "Center",
		VerticalJustification = "Center",
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
	},

	ItemNameFormat =
	{
		FontSize = 24,
		OffsetX = -256, OffsetY = -13,
		Width = 720,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		LineSpacingBottom = 20,
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemBuyAmountFormat =
	{
		FontSize = 16,
		OffsetX = -294, OffsetY = 33,
		Width = 720,
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Center",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		LineSpacingBottom = 20,
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemDeliveryTimeFormat =
	{
		FontSize = 18,
		OffsetX = -256, OffsetY = 18,
		Width = 720,
		Font = "LatoItalic",
		Color = {200, 200, 200, 125},
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		TextSymbolScale = 0.8,
		VariableAutoFormat = "WhiteFormat",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAmountFormat =
	{
		OffsetX = 76, OffsetY = 0,
		Width = 650,
		Justification = "Left",
		LuaKey = "TempTextData",
		TextSymbolScale = 0.8,
		Font = "LatoBold",
		FontSize = 18,
		Color = { 232, 232, 232, 125 },
		VerticalJustification = "Right",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},


	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"ActionBarBackground",
			"Background",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.9,
			AlphaTargetDuration = 0.3,
		},

		Background = 
		{
			Graphic = "BlankObstacle",
			Animation = "MailboxScreenIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				TitleText = 
				{
					Text = "MailboxScreen_Title",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = -182, OffsetY = -478,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					}
				},

				BasicResourceButton =
				{	
					Graphic = "BlankInteractableObstacle",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
					Scale = 0.7,
					OffsetX = 622,
					OffsetY = -334,
					Data =
					{
						ResourceName = "CharonPoints",
						--OnMouseOverFunctionName = "MouseOverResourceItem",
						--OnMouseOffFunctionName = "MouseOffResourceItem",
					},
					InteractProperties =
					{
						FreeFormSelectable = false,
					},
					TextArgs =
					{
						Font = "LatoBold",
						FontSize = 28,
						Color = Color.White,
						ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
						OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
						OffsetX = -36, OffsetY = 4,
						Justification = "Right",
						FadeTarget = 1.0, FadeOpacity = 1.0,
					},
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			UseScreenScaleX = true,
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
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Order",
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
						OnPressedFunctionName = "CloseMailboxScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

	},
}