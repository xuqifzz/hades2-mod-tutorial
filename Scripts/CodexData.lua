ScreenData.Codex =
{
	Components = {},
	BlockPause = true,

	ChapterX = 420,
	ChapterY = 205,
	ChapterSpacingX = 94,

	CategoryIconScale = 0.45,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = -5,

	Tabs =
	{
		{ X = -175, Y = -85, Animation = "GUI\\Screens\\Codex\\CategoryTab1", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight1", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay1" },
		{ X = -155, Y = -85, Animation = "GUI\\Screens\\Codex\\CategoryTab2", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight2", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay2" },
		{ X = -135, Y = -85, Animation = "GUI\\Screens\\Codex\\CategoryTab3", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight3", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay3" },
		{ X = -115, Y = -88, Animation = "GUI\\Screens\\Codex\\CategoryTab1", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight1", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay1" },
		{ X = -95, Y = -88, Animation = "GUI\\Screens\\Codex\\CategoryTab2", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight2", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay2" },
		{ X = -75, Y = -88, Animation = "GUI\\Screens\\Codex\\CategoryTab3", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight3", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay3" },
		{ X = -55, Y = -88, Animation = "GUI\\Screens\\Codex\\CategoryTab1", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight1", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay1" },
		{ X = -35, Y = -88, Animation = "GUI\\Screens\\Codex\\CategoryTab1", Highlight = "GUI\\Screens\\Codex\\CategoryTabHighlight1", Active = "GUI\\Screens\\Codex\\CategoryTabActiveHighlightOverlay1" },
	},
	TabIconMouseOverShiftDistance = 5,
	TabIconMouseOverShiftSpeed = 300,

	SpacerX = 68,
	BaseIconOffsetX = 60,
	
	ItemStartX = 320,
	ItemStartY = 320,
	ItemSpacingY = 50,

	--UnreadStarOffsetX = 10,

	GiftTrackX = 1470,
	GiftTrackY = 785,
	GiftTrackSpacingX = 70,
	GiftTrackSpacingY = 60,
	GiftTrackAngle = 11,
	GiftTrackIconsPerRow = 5,

	MaxVisibleChapters = 4,
	MaxVisibleEntries = 11,
	ScrollOffset = 0,

	--EntryCursorOffsetX = -50,

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	EntryTextFormat =
	{
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		Color = { 46, 34, 43, 225 },
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 0 },
		ShadowOffset = {0, 0},
		FadeOpacity = 1.0,
		FadeTarget = 1.0,
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		}
	},

	UnselectedFormat =
	{
		Color = { 46, 34, 43, 225 },
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 0 },
		ShadowOffset = {0, 0},
	},

	UnreadUnselectedFormat =
	{
		Color = Color.CodexUnread,
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 1 },
		ShadowOffset = {0, 2},
	},

	SelectedFormat =
	{
		Color = Color.White,
		ShadowBlur = 0,
		ShadowColor = { 0, 0, 0, 1 },
		ShadowOffset = {0, 2},
	},

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 2,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	DefaultChapter = "ChthonicGods",
	DefaultEntry = "PlayerUnit",

	OpenSound = "/Leftovers/Menu Sounds/EmoteExcitement",
	CloseSound = "/Leftovers/World Sounds/SwathPageFlip",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundTint",
			"BackgroundBack",
			"ChapterButtons",
			"Background",
			"ImageShadow",
			"Image",
			"Pin",
			"ActionBarBackground",
			"BackgroundFront",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			Color = Color.Black,
			Alpha = 0,
			AlphaTarget = 0.75,
			AlphaTargetDuration = 0.2,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Image = 
		{
			X = ScreenCenterX+656,
			Y = ScreenCenterY-172,
			Scale = 1.0,
			Angle = 354,
		},

		ImageShadow = 
		{
			-- AnimationName = "GUI\\Screens\\Codex\\PortraitShadow01",
			X = ScreenCenterX+665,
			Y = ScreenCenterY-155,
			Scale = 1.0,
			Angle = 354,
			Color = Color.Black,
		},

		Background = 
		{
			AnimationName = "Screens\\CodexAnimIn\\Codex_Background",
			X = ScreenCenterX,
			Y = ScreenCenterY-2,
		},

		BackgroundBack = 
		{
			AnimationName = "Screens\\CodexAnimIn\\Codex_BackgroundBack",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},
		
		BackgroundFront = 
		{
			AnimationName = "Screens\\CodexAnimIn\\Codex_BackgroundFront",
			X = ScreenCenterX+1,
			Y = ScreenCenterY-2,
		},

		Pin = 
		{
			AnimationName = "GUI\\Screens\\Codex\\PortraitPin01",
			X = ScreenCenterX+574,
			Y = ScreenCenterY-365,
			Scale = 1.0,
			Angle = 0,
		},

		ChapterButtons = 
		{
			FunctionName = "CodexScreenCreateChapters",
		},

		--[[
		TitleText = 
		{
			Text = "Codex_Title",
			TextArgs =
			{
				OffsetX = 0,
				OffsetY = -440,
				Color = Color.White,
				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			},
		},
		]]

		CategoryTitleText =
		{
			TextArgs =
			{
				FontSize = 26,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Center",
				OffsetX = -640, OffsetY = -340,
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		RelationshipBar =
		{
			Graphic = "BlankObstacle",
			X = 500,
			Y = 275,
		},

		RelationshipBarHint =
		{
			Graphic = "BlankObstacle",
			X = 620,
			Y = 900,
			TextArgs =
			{
				FontSize = 22,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				Width = 760,
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset = {3, 3},
				Justification = "Left",
				VariableAutoFormat = "BoldFormatGraft",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		EnemyStatsText =
		{
			Graphic = "BlankObstacle",
			X = 1450,
			Y = 700,
			TextArgs =
			{
				FontSize = 22,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				Width = 760,
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset = {3, 3},
				Justification = "Left",
				VariableAutoFormat = "BoldFormatGraft",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		EntryTitle =
		{
			X = 580,
			Y = 238,
			TextArgs =
			{
				FontSize = 38,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowColor = {0,0,0,0},
				Justification = "LEFT",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		EntryText =
		{
			X = 620,
			Y = 490,
			TextArgs =
			{
				Color = Color.CodexText,
				Font = "LatoMedium",
				FontSize = 20,
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset = {0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
				OffsetY = -150,
				Width = 760,
				LineSpacingBottom = 10,
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			GroupName = "Combat_Menu_Overlay",
			X = 325,
			Y = 270,
			Alpha = 0.0,
			Scale = 1,
			InputBlockDuration = 0.02,
			Data =
			{
				OnPressedFunctionName = "CodexScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			GroupName = "Combat_Menu_Overlay",
			X = 325,
			Y = 900,
			Alpha = 0.0,
			Scale = 1,
			InputBlockDuration = 0.02,
			Data =
			{
				OnPressedFunctionName = "CodexScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
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
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ScrollRight",
				"ScrollLeft",
				"BoonInfoButton",
			},

			Children =
			{
				BoonInfoButton = 
				{
					Requirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeBoonList" },
						}
					},
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "AttemptOpenCodexBoonInfo",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_TraitList",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CodexPrevChapter",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CodexNextChapter",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
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
						OnPressedFunctionName = "CloseCodexScreen",
						ControlHotkeys = { "Cancel", },
						MouseControlHotkeys = { "Cancel", "Codex", }
					},
					Text = "Menu_Close",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}

CodexData =
{
	ChthonicGods = 
	{
		TitleText = "Codex_ChthonicGodsChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Unseen",
		Entries =
		{
			NPC_Hecate_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "Hecate" },
								Comparison = ">=",
								Value = 1,
							},
						},
						Text = "CodexData_Hecate_01",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "Hecate" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Hecate_02",
					},
				},
				Image = "Codex_Portrait_Hecate",
				--[[
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							-- None
						},					
						Text = "CodexData_0035",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_0036",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_0037",
					},
				},
				]]
			},

			SpellDrop =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "ItemInteractions", "SpellDrop" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Selene_01",
					},
				},
				Image = "Codex_Portrait_Selene",
			},

			PlayerUnit =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 0,
							},
						},
						Text = "CodexData_Melinoe_01",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
							},
						},
						Text = "CodexData_Melinoe_02",
					},
				},
				Image = "Codex_Portrait_Melinoe",
			},
			
			NPC_Odysseus_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Odysseus_01",
					},
				},
				Image = "Codex_Portrait_Odysseus",
			},
			
			NPC_Charon_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Charon_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Charon_01",
					},
				},
				Image = "Codex_Portrait_Charon",
			},

			NPC_Nemesis_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Nemesis_01",
					},
				},
				Image = "Codex_Portrait_Nemesis",
			},

			NPC_Moros_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Moros_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Moros_01",
					},
				},
				Image = "Codex_Portrait_Moros",
			},

			NPC_Dora_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Dora_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Dora_01",
					},
				},
				Image = "Codex_Portrait_Dora",
			},

			NPC_Skelly_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Skelly_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Skelly_01",
					},
				},
				Image = "Codex_Portrait_Skelly",
			},
		},
	},

	OtherDenizens =
	{
		TitleText = "Codex_OtherDenizensChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Other",
		Entries =
		{
			NPC_Hades_Field_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
								Comparison = ">=",
								Value = 2,
							},
							{
								PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
							},
						},
						Text = "CodexData_Hades_01",
					},
				},
				Image = "Codex_Portrait_Hades",
				--[[
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							-- None
						},					
						Text = "CodexData_0035",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_0036",
					},
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_0037",
					},
				},
				]]
			},
			NPC_Chronos_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAny = { "ChronosReveal01B", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
							},
						},
						Text = "CodexData_Chronos_01",
					},
				},
				Image = "Codex_Portrait_Chronos",
			},

			NPC_Hypnos_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Hypnos_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Hypnos_01",
					},
				},
				Image = "Codex_Portrait_Hypnos",
			},

			NPC_Arachne_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Arachne_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Arachne_01",
					},
				},
				Image = "Codex_Portrait_Arachne",
				BoonInfoEnemyName = "NPC_Arachne_01",
			},

			TrialUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "TrialUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Chaos_01",
					},
				},
				Image = "Codex_Portrait_Chaos",
			},


		},
	},

	OlympianGods =
	{
		TitleText = "Codex_OlympianGodsChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Olympian",
		Entries =
		{
			ZeusUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "ZeusUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Zeus_01",
					},
				},
				Image = "Codex_Portrait_Zeus",
			},
			PoseidonUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "PoseidonUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Poseidon_01",
					},
				},
				Image = "Codex_Portrait_Poseidon",
			},
			DemeterUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "DemeterUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Demeter_01",
					},
				},
				Image = "Codex_Portrait_Demeter",
			},
			ApolloUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "ApolloUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Apollo_01",
					},
				},
				Image = "Codex_Portrait_Apollo",
			},
			NPC_Artemis_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Artemis_01",
					},
				},
				Image = "Codex_Portrait_Artemis",
				BoonInfoEnemyName = "NPC_Artemis_Field_01",
			},
			AphroditeUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Aphrodite_01",
					},
				},
				Image = "Codex_Portrait_Aphrodite",
			},
			HephaestusUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "HephaestusUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Hephaestus_01",
					},
				},
				Image = "Codex_Portrait_Hephaestus",
			},
			HestiaUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "HestiaUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Hestia_01",
					},
				},
				Image = "Codex_Portrait_Hestia",
			},

		},
	},

	Weapons =
	{
		TitleText = "Codex_WeaponsChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Weapons",
		Entries =
		{
			WeaponStaffSwing =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffSwing5", "WeaponStaffBall", "WeaponStaffBall2", "WeaponStaffBolt", "WeaponStaffBoltCharged" },
								Comparison = ">=",
								Value = 100,
							},
						},
						Text = "CodexData_WeaponStaff_01",
					},
				},
				Image = "Codex_Portrait_WeaponStaff",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Staff",
			},
			WeaponDagger =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponDagger", "WeaponDagger2", "WeaponDaggerDouble", "WeaponDaggerMultiStab", "WeaponDaggerThrow", "WeaponDagger5", "WeaponDaggerDash" },
								Comparison = ">=",
								Value = 100,
							},
						},
						Text = "CodexData_WeaponDagger_01",
					},
				},
				Image = "Codex_Portrait_WeaponDagger",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Dagger",
			},
		},

	},

	EnemiesUW =
	{
		TitleText = "Codex_EnemiesUWChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-EnemiesUW",
		ShowKillCount = true,
		Entries =
		{
			Guard =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Guard", "Guard_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Guard_01",
					},
				},
				Image = "Codex_Portrait_Guard",
			},
			Guard2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Guard2", "Guard2_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Guard2_01",
					},
				},
				Image = "Codex_Portrait_Guard2",
			},
			Brawler =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Brawler", "Brawler_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Brawler_01",
					},
				},
				Image = "Codex_Portrait_Brawler",
			},
			Radiator =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Radiator", "Radiator_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Radiator_01",
					},
				},
				Image = "Codex_Portrait_Radiator",
			},
			Radiator2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Radiator2", "Radiator2_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Radiator2_01",
					},
				},
				Image = "Codex_Portrait_Radiator2",
			},
			Screamer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Screamer", "Screamer_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Screamer_01",
					},
				},
				Image = "Codex_Portrait_Screamer",
			},
			Screamer2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Screamer2", "Screamer2_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Screamer2_01",
					},
				},
				Image = "Codex_Portrait_Screamer2",
			},
			Mage =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mage", "Mage_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Mage_01",
					},
				},
				Image = "Codex_Portrait_Mage",
			},
			SiegeVine =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SiegeVine", "SiegeVine_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_SiegeVine_01",
					},
				},
				Image = "Codex_Portrait_SiegeVine",
			},
		},
	},

	Biomes =
	{
		TitleText = "Codex_BiomesChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Places",
		Entries =
		{
			Hub = 
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "Hub" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Hub_01",
					},
				},
				Image = "Codex_Portrait_BiomeCrossroads",
			},
			BiomeF =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "F" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_BiomeF_01",
					},
				},
				Image = "Codex_Portrait_BiomeErebus",
			},
		},
	},
}