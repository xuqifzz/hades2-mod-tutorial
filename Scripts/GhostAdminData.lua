ScreenData.GhostAdmin = ScreenData.GhostAdmin or {}
OverwriteTableKeys( ScreenData.GhostAdmin, 
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/CauldronMenuOpenNew",
	OpenVoiceLines =
	{
		-- Alchemy revealed
		{
			SkipAnim = true,
			PlayOnce = true,
			PreLineWait = 1.0,
			Cooldowns =
			{
				{ Name = "MelCauldronOpenedSpeech", Time = 200 },
			},
			GameStateRequirements =
			{
				NamedRequirements = { "AlchemyUnlocked" },
			},
			-- { Cue = "/VO/Melinoe_2608", Text = "There's more I can do with this cauldron..." },
		},
	},
	OpenEndVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.5,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
				{ Name = "MelCauldronOpenedSpeech", Time = 200 },
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 40 }
			},

			{ Cue = "/VO/Melinoe_0508", Text = "Our cauldron..." },
			{ Cue = "/VO/Melinoe_0509", Text = "Must be an incantation that can help...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_4330", Text = "Every possibility..." },
			{ Cue = "/VO/Melinoe_4331", Text = "Our nightly ritual..." },
			{ Cue = "/VO/Melinoe_4332", Text = "Pure potential..." },
			{ Cue = "/VO/Melinoe_4333", Text = "Nice and warm..." },
			{ Cue = "/VO/Melinoe_0510", Text = "What now...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_4327", Text = "What's to be done...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_4328", Text = "What's possible...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_4329", Text = "What can we do...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_0511", Text = "What to cast...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ZeusPalaceAboutTyphonDeath01" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_4334", Text = "It's a new moon...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Melinoe_2969", Text = "I've had these in my head for long enough...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeAltRunDoor" },
					},
				},
			},
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

	CameraOffetX = -200,
	CameraOffetY = 180,

	CategoryStartX = 150,
	CategoryStartY = 160,
	CategorySpacingX = 110,

	CategoryIconScale = 0.60,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = -6,
	CategoryIconMouseOverShiftDistance = 5,
	CategoryIconMouseOverShiftSpeed = 300,

	ItemStartX = 515,
	ItemStartY = 230,
	ItemSpacingY = 110,
	IconOffsetX = -388,
	IconOffsetY = -1,
	IconScale = 0.7,
	CheckmarkOffsetX = 310,
	ItemsPerPage = 5,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -470,
	ScrollbarSliderTopY = 210,
	ScrollbarSliderBottomY = 690,

	FadeOutTime = 0.20,
	CloseDestroyWait = 0.35,

	AllowedRevealsPerRun = 3, -- per category

	ItemAvailableAffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {85,202,152,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAvailableUnaffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostUnffordableShop,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemPurchasedNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {110,110,110,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 315,

	Components = {},

	TooltipX = 1680,
	TooltipY = 1280,

	ResourceSpendTextInitialOffsetY = 10,
	ResourceSpendTextSpacingY = -102,
	ResourceSpendTextOffsetY = 11,

	CostDisplay =
	{
		StartX = 450,
		StartY = 848,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,

		ResourceNameAffordableFormat =
		{
			Font = "LatoMedium",
			FontSize = 17,
			OffsetX = 0,
			OffsetY = -55,
			Color = Color.Black,
			Height = 70,
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceNameUnaffordableFormat =
		{
			Font = "LatoMedium",
			FontSize = 17,
			OffsetX = 0,
			OffsetY = -55,
			Color = Color.CostUnffordableShop,
			Height = 70,
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceAmountAffordableFormat =
		{
			Font = "LatoBold",
			FontSize = 19,
			OffsetX = 0,
			OffsetY = 62,
			Color = Color.CostAffordable,
			Justification = "Center",
			ShadowColor = {0,0,0,1},
			OutlineColor = {0,0,0,1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 3},
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceAmountUnaffordableFormat =
		{
			Font = "LatoBold",
			FontSize = 19,
			OffsetX = 0,
			OffsetY = 60,
			Color = Color.CostUnffordableShop,
			Justification = "Center",
			ShadowColor = {0,0,0,1},
			OutlineColor = {0,0,0,1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 3},
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		InventoryAmountFormat =
		{
			Text = "ResourceCostInventoryAmount",
			Font = "LatoBold",
			FontSize = 16,
			TextSymbolScale = 0.8,
			OffsetX = 0,
			OffsetY = 115,
			Color = { 232, 232, 232, 125 },
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},
	},

	ItemAvailableAnimation = "GhostAdminScreenCauldronButton",
	ItemAvailableMouseOverAnimation = "GhostAdminScreenCauldronButtonIn",
	ItemAvailableMouseOffAnimation = "GhostAdminScreenCauldronButtonOut",
	ItemPurchasedAnimation = "GhostAdminScreenCauldronButtonPurchased",
	ItemPurchasedMouseOverAnimation = "GhostAdminScreenCauldronButtonInPurchased",
	ItemPurchasedMouseOffAnimation = "GhostAdminScreenCauldronButtonOutPurchased",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundIllustration01",
			"ShopBackgroundDim",
			"ListBackground",
			"InfoBoxBacking",
			"Scrollbar",
			"ScrollbarSlider",
			"ScrollUp",
			"ScrollDown",
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

		CategoryTitleText = 
		{
			X = 90,
			Y = 85,
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

		ResourceCostBacking =
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Left",
			X = 450,
			Y = 865,
			Scale = 0.538,
			Alpha = 0.0,
		},

		BackgroundIllustration01 =
		{
			AnimationName = "GhostAdminScreenCauldronIn",
			X = 960,
			Y = 540,
			Scale = 1.0,
		},

		InfoBoxBacking = 
		{
			AnimationName = "GhostAdminScreenCauldronScrollHold",
			X = 1165,
			Y = 790,
			Scale = 1.0,
			Alpha = 0.0,
			Children = 
			{
				InfoBoxDescription =
				{ 
					OffsetX = -282,
					OffsetY = -100,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.Black,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraftDark",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						LineSpacingBottom = 5,
						TextSymbolScale = 0.8,
					}
				},
				InfoBoxFlavor =
				{
					OffsetX = -282,
					OffsetY = 20,
					TextArgs =
					{
						FontSize = 18,
						Color = Color.FlavorTextPurple,
						Font = "LatoItalic",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
					}
				},
			},
		},

		Scrollbar =
		{
			AnimationName = "PageScrollbar",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 450,
			Alpha = 0.0,
		},

		ScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 210,
			Alpha = 0.0,
		},
		
		ScrollUp =
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Up",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 210,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "GhostAdminScrollUp",
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
			X = 30,
			Y = 695,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "GhostAdminScrollDown",
				ControlHotkey = "MenuDown",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
				"ScrollLeft",
				"ScrollRight",
			},

			Children = 
			{
				ScrollLeft =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "GhostAdminPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "GhostAdminNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},
			},
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
				"PinButton",
			},

			Children =
			{
				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "GhostAdminPinItem",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_Pin",
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
					Text = "Menu_CauldronUnlock",
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
						OnPressedFunctionName = "CloseGhostAdminScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
})


-- Global Hecate Lines
GlobalVoiceLines.HecateCauldronAssistanceLines =
{
	{
		PreLineWait = 1.0,
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Hecate_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				CountOf = {
					"/VO/Melinoe_2465",
					"/VO/Melinoe_2466",
					"/VO/Melinoe_2467",
					"/VO/Melinoe_2468",
					"/VO/Melinoe_2469",
					"/VO/Melinoe_2470",
					"/VO/Melinoe_2471",
					"/VO/Melinoe_2472",

					"/VO/Melinoe_2577",
					"/VO/Melinoe_2578",
					"/VO/Melinoe_2579",
					"/VO/Melinoe_2580",
					"/VO/Melinoe_2581",
					"/VO/Melinoe_2582",
					"/VO/Melinoe_2583",
					"/VO/Melinoe_2584",
				},
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasAny = { "/VO/Melinoe_2472" },
			},
		},
		{ Cue = "/VO/Hecate_0604", Text = "Appreciate your strength." },
		{ Cue = "/VO/Hecate_0605", Text = "Our wards are that much stronger thanks to you.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0606", Text = "Thus we remain concealed." },
		{ Cue = "/VO/Hecate_0607", Text = "Thank you for that, Melinoë." },
		{ Cue = "/VO/Hecate_0608", Text = "The wards about this place are back at strength." },
		{ Cue = "/VO/Hecate_0609", Text = "Our voices joined, thus we remain unseen." },
	},
}
GlobalVoiceLines.AddingReagentVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.05,
		SuccessiveChanceToPlay = 0.66,
		BreakIfPlayed = true,
		UsePlayerSource = true,

		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0518", Text = "I'm ready.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0519", Text = "Let's begin.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0520", Text = "This should help.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0522", Text = "Should have everything here." },
		{ Cue = "/VO/Melinoe_0523", Text = "Into the pot..." },
		{ Cue = "/VO/Melinoe_0524", Text = "In you go." },
		-- { Cue = "/VO/Melinoe_0525", Text = "One at a time..." },
		{ Cue = "/VO/Melinoe_0526", Text = "Temperature looks good..." },
		{ Cue = "/VO/Melinoe_0527", Text = "Should be everything." },
		{ Cue = "/VO/Melinoe_0791", Text = "That's everything I need." },
		{ Cue = "/VO/Melinoe_0792", Text = "Got everything." },
		{ Cue = "/VO/Melinoe_0521", Text = "Headmistress, if I may?", PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids =  { 556921 }, },
				},
			},
		},
	},
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Hecate_01",
		-- RequiredSourceValueFalse = "InPartnerConversation",

		{ Cue = "/VO/Hecate_0174", Text = "You may proceed.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0175", Text = "Ah, I see." ,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0176", Text = "Begin." },
		{ Cue = "/VO/Hecate_0177", Text = "Go on." },
		{ Cue = "/VO/Hecate_0178", Text = "Go on." },
		{ Cue = "/VO/Hecate_0179", Text = "Now say the words.", BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0180", Text = "Now, say the words.", BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_0521" },
				},
			},
		},
		{ Cue = "/VO/Hecate_0181", Text = "Carefully..." },
		{ Cue = "/VO/Hecate_0182", Text = "What else?" },
		{ Cue = "/VO/Hecate_0183", Text = "And...?" },
		{ Cue = "/VO/Hecate_0184", Text = "Any more?" },
		{ Cue = "/VO/Hecate_0185", Text = "{#Emph}Ah." },
	},
}
GlobalVoiceLines.CauldronReactionVoiceLines =
{
	{
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Ids = { 556921 }, Alive = false },
			},
		},
		{
			PreLineWait = 1.95,
			RandomRemaining = true,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_0535", Text = "So mote it be..." },
			{ Cue = "/VO/Melinoe_0536", Text = "So mote it be." },
			{ Cue = "/VO/Melinoe_0537", Text = "...It is done." },
		},
	},
	{
		{
			PreLineWait = 0.95,
			BreakIfPlayed = true,
			RandomRemaining = true,
			ObjectType = "NPC_Hecate_01",
			SuccessiveChanceToPlay = 0.5,
			PreLineThreadedFunctionName = "LightRangedSalute",
			RequiredSourceValueFalse = "InPartnerConversation",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastGhostAdminPurchase" },
					IsNone = { "WorldUpgradeAltRunDoor", "WorldUpgradeSurfacePenaltyCure", "WorldUpgradeTimeStop", "WorldUpgradeStormStop" }
				},
			},
			Cooldowns =
			{
				{ Name = "SoMoteItBeUtteredRecently", Time = 30 },
			},
			TriggerCooldowns = { "HecateSpokeRecently" },

			{ Cue = "/VO/Hecate_0065", Text = "So mote it be...",
				PlayedThreadedFunctionName = "CauldronCastingVoiceLines",
				PlayedThreadedFunctionArgs =
				{
					VoiceLines =
					{
						{ Cue = "/VO/Melinoe_3918", Text = "So mote it be..." },
					},
				},
			},
			{ Cue = "/VO/Hecate_0186", Text = "So mote it be...", 
				PlayedThreadedFunctionName = "CauldronCastingVoiceLines",
				PlayedThreadedFunctionArgs =
				{
					VoiceLines =
					{
						{ Cue = "/VO/Melinoe_3919", Text = "So mote it be..." },
					},
				},
			},
			{ Cue = "/VO/Hecate_0187", Text = "So mote it be.", 
				PlayedThreadedFunctionName = "CauldronCastingVoiceLines",
				PlayedThreadedFunctionArgs =
				{
					VoiceLines =
					{
						{ Cue = "/VO/Melinoe_3920", Text = "So mote it be." },
					},
				},
			},
			{ Cue = "/VO/Hecate_0188", Text = "So mote it be.", PlayFirst = true,
				PlayedThreadedFunctionName = "CauldronCastingVoiceLines",
				PlayedThreadedFunctionArgs =
				{
					VoiceLines =
					{
						{ Cue = "/VO/Melinoe_3921", Text = "So mote it be." },
					},
				},
			},
		},
		{
			PreLineWait = 0.95,
			RandomRemaining = true,
			ObjectType = "NPC_Hecate_01",
			PreLineThreadedFunctionName = "LightRangedSalute",
			-- RequiredSourceValueFalse = "InPartnerConversation",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Melinoe_4569" },
				},
			},
			TriggerCooldowns = { "HecateSpokeRecently" },

			{ Cue = "/VO/Hecate_0189", Text = "'Tis done." },
			{ Cue = "/VO/Hecate_0329", Text = "'Tis done..." },
			{ Cue = "/VO/Hecate_0190", Text = "{#Emph}Hmm{#Prev}, yes..." },
			{ Cue = "/VO/Hecate_0191", Text = "There." },
			{ Cue = "/VO/Hecate_0330", Text = "Interesting..." },
			{ Cue = "/VO/Hecate_0331", Text = "You've done it..." },
			{ Cue = "/VO/Hecate_0480", Text = "So it shall be." },
			{ Cue = "/VO/Hecate_0481", Text = "Your will is done." },
			{ Cue = "/VO/Hecate_0482", Text = "You have it." },
			{ Cue = "/VO/Hecate_0687", Text = "Your intent was true." },
			{ Cue = "/VO/Hecate_0688", Text = "Carefully said." },
			{ Cue = "/VO/Hecate_0689", Text = "I felt your words." },
			{ Cue = "/VO/Hecate_0690", Text = "Aught else?" },
			{ Cue = "/VO/Hecate_0735", Text = "By your will." },
			{ Cue = "/VO/Hecate_0736", Text = "It shall be thus." },
			{ Cue = "/VO/Hecate_0737", Text = "As you say." },
			{ Cue = "/VO/Hecate_0738", Text = "Very well, then." },
			{ Cue = "/VO/Hecate_0686", Text = "Hear that, Selene?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift02", "SeleneGift02" },
					},
				}
			},
			{ Cue = "/VO/Hecate_0691", Text = "See that, Sisters?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 10,
					},
				}
			},
		},
	},
}
GlobalVoiceLines.CauldronReactionFollowUpVoiceLines =
{
	Queue = "Always",
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.42,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
		},

		{ Cue = "/VO/Melinoe_0853", Text = "Let's try the surface one more time..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.66,
		ObjectType = "NPC_Hecate_01",
		-- SuccessiveChanceToPlay = 0.5,
		-- RequiredSourceValueFalse = "InPartnerConversation",
		TriggerCooldowns = { "HecateSpokeRecently" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
			},
		},

		{ Cue = "/VO/Hecate_0920", Text = "The Fates shall not protect you there..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.66,
		ObjectType = "NPC_Hecate_01",
		-- SuccessiveChanceToPlay = 0.5,
		-- RequiredSourceValueFalse = "InPartnerConversation",
		TriggerCooldowns = { "HecateSpokeRecently" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
		},

		{ Cue = "/VO/Hecate_0921", Text = "Impressive, though your path shall still be fraught." },
	},
	{
		Queue = "Always",
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 3.0,
		ObjectType = "NPC_Hecate_01",
		-- SuccessiveChanceToPlay = 0.5,
		-- RequiredSourceValueFalse = "InPartnerConversation",
		TriggerCooldowns = { "HecateSpokeRecently" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
			},
		},

		{ Cue = "/VO/Hecate_0922", Text = "There. Now wield that power at the summit." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 3.0,
		ObjectType = "NPC_Hecate_01",
		-- SuccessiveChanceToPlay = 0.5,
		-- RequiredSourceValueFalse = "InPartnerConversation",
		TriggerCooldowns = { "HecateSpokeRecently" },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
			},
		},

		{ Cue = "/VO/Hecate_0923", Text = "'Tis done. {#Emph}Death to Chronos..." },
	},
}

-- Cauldron -- Crossroads Cauldron
GlobalVoiceLines.AboutToCastSpell =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.75,

	{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
	{ Cue = "/VO/Melinoe_0179", Text = "All right." },
}

-- Cauldron Alchemy
GlobalVoiceLines.ResourceTransmutationVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		Queue = "Always",
		Cooldowns =
		{
			-- { "MelinoeAnyQuipSpeech" },
		},
	
		{ Cue = "/VO/Melinoe_1352", Text = "Transmutation complete.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1353", Text = "Transmutation succeeded." },
		{ Cue = "/VO/Melinoe_1354", Text = "My will is manifest." },
		{ Cue = "/VO/Melinoe_1355", Text = "Re-shaped by Chaos..." },
	}
}