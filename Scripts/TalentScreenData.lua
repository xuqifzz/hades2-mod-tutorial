ScreenData.TalentScreen = 
{
	DefaultStartX = 400,
	DefaultStartY = 340,
	DefaultTalentXSpacer = 165,
	DefaultTalentYSpacer = 70,
	TooltipOffsetXStart = ScreenWidth - 240,
	TooltipOffsetYStart = ScreenCenterY + 350,
	DefaultTalentScale = 0.3,
	TalentInactive = { 30, 30, 30, 255 },
	TalentPriorSelected = { 47, 79, 79, 255 },

	BlockPause = true,
	BlockExitsReady = true,

	Components = {},
	OpenSound = "/SFX/SeleneMoonPickup",

	OpenVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.75,
			SuccessiveChanceToPlayAll = 0.33,
			SkipCooldownCheckIfNonePlayed = true,
			PreLineWait = 0.7,
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "SlottedSpell", "HasDuoTalent"}
				},
				{
					PathFalse = { "CurrentRun", "Hero", "SlottedSpell", "ObtainedDuoTalent"}
				},
			},
			Cooldowns =
			{
				{ Name = "SeleneAnyQuipSpeech", Time = 90 },
			},
			{ Cue = "/VO/Selene_0435", Text = "Aid from a relative of yours..." },
			{ Cue = "/VO/Selene_0436", Text = "From the heavens themselves..." },
			{ Cue = "/VO/Selene_0437", Text = "A relative is offering their aid..." },
			-- { Cue = "/VO/Selene_0438", Text = "A god may cross your Path..." },
			-- { Cue = "/VO/Selene_0439", Text = "A goddess may cross your Path..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			-- SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.7,
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
			},
			Cooldowns =
			{
				{ Name = "SeleneAnyQuipSpeech", Time = 90 },
			},
			
			{ Cue = "/VO/Selene_0255", Text = "The Path of Stars...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/MelinoeField_1474", "/VO/MelinoeField_2380", },
					},
				},
			},
			{ Cue = "/VO/Selene_0256", Text = "Behold the stars..." },
			{ Cue = "/VO/Selene_0257", Text = "Grow strong under the stars..." },
			{ Cue = "/VO/Selene_0258", Text = "The infinite dark..." },
			{ Cue = "/VO/Selene_0259", Text = "The possibilities..." },
			{ Cue = "/VO/Selene_0260", Text = "The path you face..." },
			{ Cue = "/VO/Selene_0261", Text = "Choose your path." },
			{ Cue = "/VO/Selene_0262", Text = "Manifest your desire...", PlayFirst = true },
		},
	},

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		--FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 32,
		FreeFormSelectSuccessDistanceStep = 32,
	},

	ComponentData =
	{
		UseNativeScreenCenter = true,
		
		DefaultGroup = "Combat_Menu_Overlay",

		Order =
		{
			"BackgroundTint",
			"BackgroundImage",
			"Background",
			"ActionBarBackground",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.5,
			AlphaTargetDuration = 0.3,
		},

		BackgroundImage = 
		{
			AnimationName = "TalentScreenIn",
			GroupName = "Combat_Menu_Backing",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			GroupName = "Combat_Menu",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				TitleText = 
				{
					Text = "TalentScreenMenu_Title",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = 0, OffsetY = -470,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					}
				},

				FlavorText = 
				{
					Text = "TalentDrop_FlavorText01",
					TextArgs =
					{
						FontSize = 20,
						OffsetY = -430, Width = 1040,
						Color = {0.698, 0.698, 0.698, 1.0},
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = "Center" 
					}
				},

				SpellBacking = 
				{
					AnimationName = "BoonSlotBase",
					GroupName = "Combat_Menu_Overlay_Backing",
					OffsetX = 0,
					OffsetY = -290,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.3,
					Children = 
					{
						SpellIcon = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
						SpellFrame =
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
						SpellText = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							TextArgs = ScreenData.UpgradeChoice.TitleText,
						},
						SpellDescription = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							TextArgs = ScreenData.UpgradeChoice.DescriptionText,
						},
					}
				},

				TalentContainer = 
				{
					AnimationName = "BoonSlotBase",
					GroupName = "Combat_Menu_Overlay_Backing",
					OffsetX = 0,
					OffsetY = 350,
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.3,
					Children = 
					{
						TitleBox = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = ScreenData.UpgradeChoice.TitleText,
						},
						DetailsBacking = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							TextArgs = ScreenData.UpgradeChoice.DescriptionText,
						},
						RarityBox = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray_Backing",
							TextArgs = ScreenData.UpgradeChoice.RarityText,
						},
						StatLineLeft =
						{ 
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
						},
						StatLineRight =
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = ScreenData.UpgradeChoice.StatLineRight,
						},
						StatLineLeft2 =
						{ 
							Alpha = 1.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = MergeTables(ScreenData.UpgradeChoice.StatLineLeft, {OffsetY = ScreenData.UpgradeChoice.LineHeight })
						},
						StatLineRight2 =
						{
							Alpha = 1.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = MergeTables(ScreenData.UpgradeChoice.StatLineRight, {OffsetY = ScreenData.UpgradeChoice.LineHeight })
						},
						TalentIcon = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
						TalentFrame = 
						{
							Alpha = 0.0,
							AlphaTarget = 1.0,
							AlphaTargetDuration = 0.3,
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
					}
				},
			},
		},

		TalentPointText = 
		{
			X = 322,
			Y = 462,
			Alpha = 0,
			Text = "Blank",
			TextArgs =
			{
				FontSize = 64,
				OffsetX = -2,
				OffsetY = 79,
				Color = Color.White,
				Font = "LatoBold64",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center" 
			}
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
				"SelectButton",
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing - UIData.ContextualButtonSpacing,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						--Dummy Button
					},
					Text = " ",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					X = UIData.ContextualButtonXRight,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "LeaveTalentTree",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

		TalentHover = 
		{
			AnimationName = "TalentHighlight",
			GroupName = "Combat_Menu_TraitTray_Backing",
			X = 200,
			Y = 450,
			Scale = 0.5,
			Alpha = 0.0,
		},

		TalentPin = 
		{
			AnimationName = "TraitPinIn_NoHighlight",
			GroupName = "Combat_Menu_TraitTray_Backing",
			X = 200,
			Y = 450,
			Scale = 0.6,
			Alpha = 0
		},
	}
}