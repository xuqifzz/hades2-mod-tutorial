ScreenData.CosmeticsShop =
{
	BlockPause = true,

	ItemCategories =
	{
		{
			Name = "CosmeticsShop_Tent",
			GameStateRequirements =
			{
				-- None
			},
			--[[
			"Cosmetic_TentRugBrown",
			"Cosmetic_TentRugPurple",
			"Cosmetic_TentRugGrey",
			"Cosmetic_TentRugRed",
			]]

			"Cosmetic_TentBlanket01",
			"Cosmetic_TentBlanket01a",
			"Cosmetic_TentBlanket01b",

			"Cosmetic_TentMoodcrystal01",
		},		
		{
			Name = "CosmeticsShop_Main",
			GameStateRequirements =
			{
				-- None
			},

			"Cosmetic_MainLantern01",
			"Cosmetic_MainLantern01a",
			"Cosmetic_MainLantern01b",

			"Cosmetic_MainCrystalBall01",
		},
		{
			Name = "CosmeticsShop_PreRun",
			GameStateRequirements =
			{
				-- None
			},
			"Cosmetic_PreRunTerrainA",
			"Cosmetic_PreRunTerrainB",
			"Cosmetic_PreRunTerrainC",

			"Cosmetic_PreRunFrogPond01",
		},
	},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	CategoryStartX = 130,
	CategoryStartY = 100,
	CategorySpacingX = 94,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 400,
	ItemStartY = 190,
	ItemSpacingY = 96,
	IconOffsetX = -325,
	IconOffsetY = 0,
	ItemsPerPage = 6,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -300,

	PinOffsetX = 200,

	Components = {},

	SaleData = {},
	NumSales = 0,
	NumItemsOffered = 0,

	TooltipX = 1690,
	TooltipY = 700,

	CostDisplay =
	{
		StartX = 300,
		StartY = 870,
		SpacerX = 95
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",

		Order =
		{
			"ShopBackgroundDim",
			"ListBackground",
			"InfoBoxBacking",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			GroupName = "Combat_Menu_Backing",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 200,
			Y = ScreenCenterY,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		ListBackground = 
		{
			Graphic = "WeaponShopBacking",
			GroupName = "Combat_Menu",
			X = 400,
			Y = 430,
			ScaleY = 0.77,
		},

		ResourceCostBacking =
		{
			Graphic = "WeaponShopBacking",
			GroupName = "Combat_Menu",
			X = 300,
			Y = 860,
			ScaleY = 0.3,
			ScaleX = 0.6,
			Alpha = 0.0,
		},

		InfoBoxBacking = 
		{
			Graphic = "BlankObstacle",
			Animation = "WeaponShopBacking",
			X = 1120,
			Y = 750,
			ScaleY = 0.3,
			ScaleX = 0.75,
			Alpha = 0.0,
			Children = 
			{
				--[[
				TitleText = 
				{
					Text = "GhostAdminScreen_Title",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = 0, OffsetY = -493,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					},
				},

				HintText = 
				{
					Text = "GhostAdminScreen_Hint",
					TextArgs =
					{
						FontSize = 19,
						OffsetX = 0, OffsetY = -443,
						Width = 840,
						Color = {120, 120, 120, 255},
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},
				]]

				--[[
				InfoBoxName =
				{
					OffsetX = 0,
					OffsetY = 100,
					TextArgs =
					{
						FontSize = 22,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 400,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
				]]
				--[[
				InfoBoxCost =
				{
					OffsetX = 0,
					OffsetY = 200,
					TextArgs =
					{
						FontSize = 22,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 400,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						TextSymbolScale = 0.7,
					}
				},
				]]
				InfoBoxDescription =
				{ 
					OffsetX = -275,
					OffsetY = -100,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.White,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraft",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 573,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 5,
					}
				},
				InfoBoxFlavor =
				{
					OffsetX = -275,
					OffsetY = 20,
					TextArgs =
					{
						FontSize = 18,
						Color = {132,83,50,255},
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 573,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
			},
		},

		CategoryTitleText = 
		{
			X = 80,
			Y = 50,
			TextArgs =
			{
				FontSize = 26,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			GroupName = "Combat_Menu",
			X = 50,
			Y = 110,
			Alpha = 0.0,
			Scale = 0.75,
			Data =
			{
				OnPressedFunctionName = "GhostAdminScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			GroupName = "Combat_Menu",
			X = 50,
			Y = 740,
			Alpha = 0.0,
			Scale = 0.75,
			Data =
			{
				OnPressedFunctionName = "GhostAdminScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		SelectButton =
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			Alpha = 0.0,
			Data =
			{
				-- Dummy button
			},
			Text = "Menu_CauldronUnlock",
			TextArgs = UIData.ContextualButtonFormatLeft,
		},

		PinButton = 
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXLeft + UIData.ContextualButtonSpacing,
			Y = UIData.ContextualButtonY,
			Alpha = 0.0,
			Data =
			{
				-- Hotkey only
				OnPressedFunctionName = "GhostAdminPinItem",
				ControlHotkeys = { "ItemPin", },
			},
			Text = "Menu_Pin",
			TextArgs = UIData.ContextualButtonFormatLeft,
		},

		ScrollLeft =
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXMiddleLeft,
			Y = UIData.ContextualButtonY,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "CosmeticShopPrevCategory",
				ControlHotkeys = { "MenuLeft", },
			},
			Text = "Menu_PrevCategory",
			TextArgs = UIData.ContextualButtonFormatRight,
		},

		ScrollRight = 
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXMiddleRight,
			Y = UIData.ContextualButtonY,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "CosmeticShopNextCategory",
				ControlHotkeys = { "MenuRight", },
			},
			Text = "Menu_NextCategory",
			TextArgs = UIData.ContextualButtonFormatLeft,
		},

		CloseButton = 
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "CloseGhostAdminScreen",
				ControlHotkeys = { "Cancel", },
			},
			Text = "Menu_Exit",
			TextArgs = UIData.ContextualButtonFormatRight,
		},
	},

	OpenSound = "/Leftovers/World Sounds/RonEnter",
	CloseSound = "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage",
	OpenVoiceLines = 
	{
		Cooldowns =
		{
			{ Name = "MelCosmeticsOpenedSpeech", Time = 200 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlay = 0.75,
			ObjectType = "NPC_Dora_01",

			{ Cue = "/VO/Dora_0108", Text = "So, {#Emph}uh, {#Prev}what's up?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0109", Text = "What's going on, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0239", Text = "What's it going to be?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0240", PlayFirst = true, Text = "Any of these?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0241", Text = "What are we thinking?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0242", Text = "Want to... mix things up?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0243", Text = "Time to move stuff around?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0244", Text = "You know the drill.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			-- SGV
			{ Cue = "/VO/Dora_0245", Text = "{#Emph}What shall it be, Witch?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
			},
			{ Cue = "/VO/Dora_0246", Text = "{#Emph}State your bidding.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
			},
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlay = 0.75,

			{ Cue = "/VO/Melinoe_1393", Text = "Let's see what we can do.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1394", Text = "What do you think, Dora?" },
			{ Cue = "/VO/Melinoe_1395", Text = "We can make things better." },
			{ Cue = "/VO/Melinoe_1396", Text = "We needn't settle for the way it is." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlay = 0.75,
			ObjectType = "NPC_Dora_01",

			{ Cue = "/VO/Dora_0247", Text = "You got it.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1393" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0248", Text = "They don't pay me to think.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1394" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0249", Text = "Or we can just mess with things.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1395" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
			{ Cue = "/VO/Dora_0250", Text = "Though maybe we should?",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_1396" },
					},
				},
				PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			},
		},
	},
}