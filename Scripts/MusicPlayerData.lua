ScreenData.MusicPlayer =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/GeneralWhooshMENULoud",
	CloseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",
	OpenEndVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.75,
			SuccessiveChanceToPlayAll = 0.33,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelMusicPlayerOpenedSpeech", Time = 30 },
				{ Name = "MelinoeMusicMakerSaluteSpeech", Time = 6 },
			},

			{ Cue = "/VO/Melinoe_3674", Text = "What are we in the mood for..." },
			{ Cue = "/VO/Melinoe_3675", Text = "I may have a new request..." },
			{ Cue = "/VO/Melinoe_3676", Text = "How about a change of tune...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3678", Text = "Evening, Music Maker!" },
			{ Cue = "/VO/Melinoe_3844", Text = "Hail, Music Maker.", PlayFirst = true },
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

	CameraOffetX = -150,
	CameraOffetY = 0,

	ItemStartX = 515,
	ItemStartY = 230,
	ItemSpacingY = 60,
	IconOffsetX = -388,
	IconOffsetY = 0,
	PurchaseButtonScaleY = 0.5,
	IconScale = 0.35,
	PausePlayIconScale = 0.5,
	ItemsPerPage = 8,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -470,
	ScrollbarSliderTopY = 210,
	ScrollbarSliderBottomY = 690,

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
		Color = {200,200,200,255},
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

	ItemAvailableAnimation = "CriticalItemShopButton",
	ItemAvailableHighlightAnimation = "CriticalItemShopButtonHighlight",
	ItemPurchasedAnimation = "CriticalItemShopButton",
	ItemPurchasedHighlightAnimation = "CriticalItemShopButtonHighlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
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

		ResourceCostBacking =
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Left",
			X = 450,
			Y = 865,
			Scale = 0.538,
			Alpha = 0.0,
		},

		InfoBoxBacking = 
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Scroll",
			X = 1165,
			Y = 840,
			ScaleY = 0.5,
			Alpha = 0.0,
			Children = 
			{
				InfoBoxDescription =
				{
					OffsetX = -282,
					OffsetY = -35,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.Black,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraftDark",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
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
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
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
				OnPressedFunctionName = "MusicPlayerScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
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
				OnPressedFunctionName = "MusicPlayerScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
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
					Text = "Menu_MusicPlayerUnlock",
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
			}
		}
	},

	Songs =
	{
		"Song_MainTheme",

		"Song_RunStart",

		"Song_CharonShopTheme",
		"Song_ArachneTheme",
		"Song_ArtemisTheme",
		"Song_NemesisTheme",
		"Song_MedeaTheme",
		"Song_HeraclesTheme",
		"Song_CirceTheme",
		"Song_DionysusMusic",

		"Song_Exploration1",
		"Song_Exploration2",
		"Song_Erebus2",

		"Song_Scylla1a",
		"Song_Scylla1b",
		"Song_Scylla2a",
		"Song_Scylla2b",

		"Song_MourningFields1",
		"Song_MourningFields2",

		"Song_ClockworkTartarusRegular",
		"Song_ClockworkTartarusMiniboss",

		"Song_FilthyArp",
		"Song_Ephyra2",
		"Song_Ephyra3",

		"Song_Ships1",
		"Song_Ships2",

		"Song_BiomeStartOlympus",
		"Song_Olympus1",
		"Song_Olympus2",

		"Song_MinibossTheme",
		"Song_TimedEncounter",
		"Song_FishingMusicLoop",

		"Song_EndThemeAcoustic",
		"Song_ChronosBossFightMusic",
	},
}

OverwriteTableKeys( WorldUpgradeData,
{
	-- Music Player Tracks
	DefaultSongItem =
	{
		DebugOnly = true,
		Icon = "Cosmetic_MusicTrack",

		Cost =
		{
			CosmeticsPoints = 100,
		},
		GameStateRequirements =
		{
			-- None
		},

		PreRevealVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelMusicPlayerRequestSpeech", Time = 10 },
				},

				{ Cue = "/VO/Melinoe_3832", Text = "I'd like to hear this one." },
				{ Cue = "/VO/Melinoe_3833", Text = "Would you play this one, please?" },
				{ Cue = "/VO/Melinoe_3834", Text = "Let's hear this one." },
				{ Cue = "/VO/Melinoe_3835", Text = "Play this one next, would you?" },
				{ Cue = "/VO/Melinoe_3836", Text = "Play us another song, if you don't mind!" },
				{ Cue = "/VO/Melinoe_3837", Text = "Mind playing this one next?" },
				{ Cue = "/VO/Melinoe_3838", Text = "Got a request for you.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3839", Text = "Up for another song?" },
			},
		},
	},

	Song_MainTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMainThemeMusicPlayer",

		-- Cost is free
	},
	Song_RunStart =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/MusicRunstartMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 100,
		},
	},
	Song_Exploration1 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicExploration1MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 350,
			MixerFBoss = 1,
		},
		GameStateRequirements =
		{
			--
		},
	},
	Song_Exploration2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicExploration2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 350,
			MixerFBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateGift03" },
			},
		},
	},
	Song_Erebus2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicErebus2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 350,
			MixerFBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Hecate" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	Song_ArachneTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisArachneThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 250,
			MetaFabric = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGift03" },
			},
		},
	},
	Song_ArtemisTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/ArtemisThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 300,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift03" },
			},
		},
	},
	Song_NemesisTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicNemesisThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 250,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "NemesisGift03", "NemesisCombatFirstIntro" },
			},
		},
	},
	Song_CharonShopTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/CharonShopThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 150,
			CharonPoints = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGift03" },
			},
		},
	},
	Song_Scylla1a =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicScylla1MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 150,
			MixerGBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "G_Intro" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Scylla1b =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicScylla1bMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 550,
			MixerGBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Scylla" },
				Comparison = ">=",
				Value = 2,
			},
		},
		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelMusicPlayerRequestSpeech", Time = 10 },
				},
				{ Cue = "/VO/Melinoe_3841", Text = "Surprised you've heard of this one, but all right..." },
			},
		},
	},
	Song_Scylla2a =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicScylla2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 150,
			MixerGBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs01" }
			},
			{
				Path = { "GameState", "EnemyKills", "Scylla" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Scylla2b =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicScylla2bMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 550,
			MixerGBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs01" }
			},
			{
				Path = { "GameState", "EnemyKills", "Scylla" },
				Comparison = ">=",
				Value = 3,
			},
		},
		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelMusicPlayerRequestSpeech", Time = 10 },
				},

				{ Cue = "/VO/Melinoe_3840", Text = "I almost hesitate to ask..." },
			},
		},
	},
	Song_MourningFields1 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicMourningFields1MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 300,
			MixerHBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered" },
				HasAll = { "H_MiniBoss01", "H_MiniBoss02" }, 
			},
		},
	},
	Song_MourningFields2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicMourningFields2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 300,
			MixerHBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "H_Intro" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	Song_ClockworkTartarusMiniboss =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicClockworkTartarusMinibossMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 400,
			MixerIBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "MiniBossRatCatcher", "MiniBossGoldElemental" }
			},
		},
	},
	Song_ClockworkTartarusRegular =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicClockworkTartarusRegularMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 400,
			MixerIBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "I_Intro" },
			},
		},
	},
	Song_ChronosBossFightMusic =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/ChronosBossFightMusicMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 2400,
			MixerIBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	Song_EndThemeAcoustic =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/EndThemeACOUSTICMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 600,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "HadesGift01", "ChronosNightmare01" },
			},
		},
	},
	Song_TimedEncounter =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisTimedEncounterMusicMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 200,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "GeneratedAnomalyB" }
			},
		},
	},
	Song_FishingMusicLoop =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/FishingMusicLoopMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 200,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "FishingSuccessesManual" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	Song_MinibossTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMinibossMusicMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 200,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "MiniBossRatCatcher", "MiniBossWaterUnit" }
			},
		},
	},
	Song_FilthyArp =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicFilthyArpMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 500,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Polyphemus" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Ephyra2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicEphyra2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 500,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "N_Hub" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Ephyra3 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicEphyra3MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 500,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "N_Boss01" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_HeraclesTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicHeraclesThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 250,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift02" },
			},
		},
	},
	Song_MedeaTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicMedeaThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 250,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGift02" },
			},
		},
	},
	Song_CirceTheme =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicCirceThemeMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 250,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" }
			},
		},
	},
	Song_Ships1 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicShips1MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 400,
			MixerOBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "O_Boss01" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Ships2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicShips2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 400,
			MixerOBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Eris" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	Song_BiomeStartOlympus =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicBiomeStartOlympusMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 800,
			MixerOBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "P_Intro" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_Olympus1 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicOlympus1MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 800,
			MixerPBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "MiniBossTalos", "MiniBossDragon" },
			},
		},
	},
	Song_Olympus2 =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/IrisMusicOlympus2MusicPlayer",

		Cost =
		{
			CosmeticsPoints = 800,
			MixerPBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Prometheus" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	Song_DionysusMusic =
	{
		InheritFrom = { "DefaultSongItem" },
		TrackName = "/Music/MusicPlayer/Iris/DionysusMusicMusicPlayer",

		Cost =
		{
			CosmeticsPoints = 700,
			SuperGiftPoints = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DionysusGift02" },
			},
		},
	},
})