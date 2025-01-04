CodexOrdering =
{
	Order =
	{
		"ChthonicGods", "OlympianGods", "OtherDenizens", "EnemiesUW", "EnemiesSF", "Weapons", "Familiars", "Biomes",
	},
	ChthonicGods =
	{
		"NPC_Hecate_01", "SpellDrop", "PlayerUnit", "NPC_Odysseus_01", "NPC_Nemesis_01", "NPC_Moros_01", "NPC_Dora_01", "NPC_Skelly_01", "NPC_Charon_01", "NPC_Circe_01", "NPC_Medea_01",
	},
	OlympianGods =
	{
		"ZeusUpgrade", "HeraUpgrade", "PoseidonUpgrade", "DemeterUpgrade", "ApolloUpgrade", "AphroditeUpgrade", "HephaestusUpgrade", "HestiaUpgrade", "NPC_Athena_01", "NPC_Dionysus_01", "NPC_Artemis_01", "HermesUpgrade",
	},
	OtherDenizens =
	{
		"NPC_Chronos_01", "NPC_Hades_Field_01", "NPC_Cerberus_01", "NPC_Heracles_01", "NPC_Icarus_01", "NPC_Arachne_01", "NPC_Narcissus_01", "NPC_Echo_01", "Scylla", "Polyphemus", "NPC_Eris_01", "Prometheus", "NPC_Hypnos_01", "TrialUpgrade",
	},
	Familiars =
	{
		"FrogFamiliar", "CatFamiliar", "RavenFamiliar", "HoundFamiliar",
	},
	Weapons =
	{
		"WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit",
	},
	EnemiesUW =
	{
		-- Erebus
		"Guard", "Guard2", "Brawler", "Radiator", "Radiator2", "Screamer", "Screamer2", "Mage", "SiegeVine", "FogEmitter", "FogEmitter2", "Treant", "Treant2", "LightRanged",
		-- Asphodel
		"SpreadShotUnit", "Swarmer", "BloodlessNaked", "BloodlessWaveFist", "BloodlessBerserker", "BloodlessGrenadier", "BloodlessSelfDestruct", "BloodlessPitcher",
		-- Oceanus
		"FishSwarmer", "FishmanMelee", "FishmanRanged", "Turtle", "WaterUnit", "WaterUnitMiniboss", "ThiefMineLayer", "CrawlerMinibossCodex",
		-- Fields
		"CorruptedShadeSmall", "CorruptedShadeMedium", "CorruptedShadeLarge", "DespairElemental", "BrokenHearted", "Lovesick", "Mourner", "LycanSwarmer", "Lycanthrope", "Vampire", "Lamia", "Lamia_Miniboss",
		-- Tartarus
		"SwarmerClockwork", "ClockworkHeavyMelee", "TimeElemental", "GoldElemental", "GoldElemental_MiniBoss", "Crawler", "SatyrCultist", "SatyrLancer", "SatyrRatCatcher", "SatyrRatCatcher_Miniboss",
	},
	EnemiesSF =
	{
		-- City of Ephyra
		"Carrion", "Zombie", "ZombieCrewman", "ZombieOlympus", "ZombieAssassin", "ZombieHeavyRanged", "ZombieSpawner", "Mudman",
		-- Rift of Thessaly
		"WaterElemental", "Scimiterror", "Mage2", "Stickler", "Drunk", "Swab", "HarpyCutter", "HarpyDropper", "Charybdis",
		-- Olympus
		"SatyrLancer2", "SatyrSapper", "SatyrCrossbow2", "SatyrCrossbow", "Dragon", "Dragon_MiniBoss", "SentryBot", "AutomatonBeamer", "AutomatonEnforcer", "Talos",
	},
	Biomes =
	{
		"BiomeP", "BiomeO", "BiomeN", "Hub", "BiomeF", "BiomeG", "BiomeB", "BiomeH", "BiomeI", "BiomeHouse", "BiomeChaos",
	},

}
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

	GiftTrackX = 1480,
	GiftTrackY = 725,
	GiftTrackSpacingX = 70,
	GiftTrackSpacingY = 60,
	GiftTrackAngle = 10,
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
			Y = 865,
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
			BottomOffset = UIData.ContextualButtonBottomOffset,
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
								Path = { "GameState", "UseRecord", "SpellDrop" },
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

			NPC_Medea_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Medea_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Medea_01",
					},
				},
				Image = "Codex_Portrait_Medea",
				BoonInfoEnemyName = "NPC_Medea_01",
			},

			NPC_Circe_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Circe_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Circe_01",
					},
				},
				Image = "Codex_Portrait_Circe",
				BoonInfoEnemyName = "NPC_Circe_01",
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

			NPC_Eris_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Eris_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Eris_01",
					},
				},
				Image = "Codex_Portrait_Eris",
			},
		
			NPC_Icarus_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Icarus_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Icarus_01",
					},
				},
				Image = "Codex_Portrait_Icarus",
				BoonInfoEnemyName = "NPC_Icarus_01",
			},
			NPC_Narcissus_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Narcissus_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Narcissus_01",
					},
				},
				Image = "Codex_Portrait_Narcissus",
				BoonInfoEnemyName = "NPC_Narcissus_01",
			},
			NPC_Echo_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Echo_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Echo_01",
					},
				},
				Image = "Codex_Portrait_Echo",
				BoonInfoEnemyName = "NPC_Echo_01",
			},
			NPC_Heracles_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Heracles_01",
					},
				},
				Image = "Codex_Portrait_Heracles",
			},
			Scylla =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "Scylla" },
								Comparison = ">=",
								Value = 1,
							},
						},
						Text = "CodexData_Scylla_01",
					},
				},
				Image = "Codex_Portrait_Scylla",
			},
			Polyphemus =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "Polyphemus" },
								Comparison = ">=",
								Value = 1,
							},
						},
						Text = "CodexData_Polyphemus_01",
					},
				},
				Image = "Codex_Portrait_Polyphemus",
			},
			NPC_Cerberus_01 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "InfestedCerberus" },
								Comparison = ">=",
								Value = 1,
							},
						},
						Text = "CodexData_Cerberus_01",
					},
				},
				Image = "Codex_Portrait_Cerberus",
			},
			Prometheus =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills", "Prometheus" },
								Comparison = ">=",
								Value = 1,
							},
						},
						Text = "CodexData_Prometheus_01",
					},
				},
				Image = "Codex_Portrait_Prometheus",
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
			HeraUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "HeraUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Hera_01",
					},
				},
				Image = "Codex_Portrait_Hera",
			},
			HermesUpgrade =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "HermesUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Hermes_01",
					},
				},
				Image = "Codex_Portrait_Hermes",
			},
			NPC_Athena_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Athena_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Athena_01",
					},
				},
				Image = "Codex_Portrait_Athena",
				BoonInfoEnemyName = "NPC_Athena_01",
			},
			NPC_Dionysus_01 =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "UseRecord", "NPC_Dionysus_01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Dionysus_01",
					},
				},
				Image = "Codex_Portrait_Dionysus",
				BoonInfoEnemyName = "NPC_Dionysus_01",
			},
		},
	},

	Familiars =
	{
		TitleText = "Codex_FamiliarsChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-Familiars",
		Entries =
		{
			FrogFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar", },
							},
						},
						Text = "CodexData_Frinos_01",
					},
				},
				Image = "Codex_Portrait_FrogFamiliar",
			},
			CatFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar", },
							},
						},
						Text = "CodexData_Toula_01",
					},
				},
				Image = "Codex_Portrait_CatFamiliar",
			},
			RavenFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar", },
							},
						},
						Text = "CodexData_Raki_01",
					},
				},
				Image = "Codex_Portrait_RavenFamiliar",
			},
			HoundFamiliar =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar", },
							},
						},
						Text = "CodexData_Hecuba_01",
					},
				},
				Image = "Codex_Portrait_HoundFamiliar",
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
			WeaponTorch =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponTorch", "WeaponTorchSpecial" },
								Comparison = ">=",
								Value = 100,
							},
						},
						Text = "CodexData_WeaponTorch_01",
					},
				},
				Image = "Codex_Portrait_WeaponTorch",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Torch",
			},
			WeaponAxe =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxeSpin", "WeaponAxeBlock2", "WeaponAxeSpecial", "WeaponAxeSpecialSwing" },
								Comparison = ">=",
								Value = 100,
							},
						},
						Text = "CodexData_WeaponAxe_01",
					},
				},
				Image = "Codex_Portrait_WeaponAxe",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Axe",
			},
			WeaponLob =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponLob", "WeaponLobSpecial", "WeaponLobGun" },
								Comparison = ">=",
								Value = 100,
							},
							{
								PathTrue = { "GameState", "CodexEntriesViewed", "PlayerUnit" },
							},
						},
						Text = "CodexData_WeaponLob_01",
					},
				},
				Image = "Codex_Portrait_WeaponLob",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Lob",
			},
			WeaponSuit =
			{
				NoRequirements = true,
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "WeaponKills" },
								SumOf = { "WeaponSuit", "WeaponSuit2", "WeaponSuitCharged", "WeaponSuitDash", "WeaponSuitRanged" },
								Comparison = ">=",
								Value = 100,
							},
							{
								PathTrue = { "GameState", "CodexEntriesViewed", "PlayerUnit" },
							},
						},
						Text = "CodexData_WeaponSuit_01",
					},
				},
				Image = "Codex_Portrait_WeaponSuit",
				BoonInfoLootName = "WeaponUpgrade",
				BoonInfoTitle = "Codex_BoonInfo_Title_Hammer_Suit",
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
			Treant =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Treant" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_Treant_01",
					},
				},
				Image = "Codex_Portrait_Treant",
			},
			Treant2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Treant2" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_Treant2_01",
					},
				},
				Image = "Codex_Portrait_Treant2",
			},
			FogEmitter =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "FogEmitter", "FogEmitter_Elite" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_FogEmitter_01",
					},
				},
				Image = "Codex_Portrait_FogEmitter",
			},
			FogEmitter2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "FogEmitter2" },
								Comparison = ">=",
								Value = 5,
							},
						},
						Text = "CodexData_FogEmitter2_01",
					},
				},
				Image = "Codex_Portrait_FogEmitter2",
			},

			FishSwarmer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "FishSwarmer", "FishSwarmer_Elite" },
								Comparison = ">=",
								Value = 100,
							},
						},
						Text = "CodexData_FishSwarmer_01",
					},
				},
				Image = "Codex_Portrait_FishmanSwarmer",
			},
			FishmanMelee =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "FishmanMelee", "FishmanMelee_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_FishmanMelee_01",
					},
				},
				Image = "Codex_Portrait_FishmanMelee",
			},
			FishmanRanged =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "FishmanRanged", "FishmanRanged_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_FishmanRanged_01",
					},
				},
				Image = "Codex_Portrait_FishmanRanged",
			},
			Turtle =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Turtle", "Turtle_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_Turtle_01",
					},
				},
				Image = "Codex_Portrait_Turtle",
			},
			WaterUnit =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "WaterUnit", "WaterUnit_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_WaterUnit_01",
					},
				},
				Image = "Codex_Portrait_WaterUnit",
			},
			WaterUnitMiniboss =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "WaterUnitMiniboss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_WaterUnitMiniboss_01",
					},
				},
				Image = "Codex_Portrait_WaterUnitMiniBoss",
			},
			ThiefMineLayer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ThiefMineLayer", "ThiefMineLayer_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_ThiefMineLayer_01",
					},
				},
				Image = "Codex_Portrait_ThiefMineLayer",
			},
			CrawlerMinibossCodex =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "CrawlerMiniboss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_CrawlerMiniboss_01",
					},
				},
				Image = "Codex_Portrait_CrawlerMiniBoss",
			},

			LightRanged =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "LightRanged", "LightRanged_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_LightRanged_01",
					},
				},
				Image = "Codex_Portrait_LightRanged",
			},
			SpreadShotUnit =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SpreadShotUnit", "SpreadShotUnit_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_SpreadShotUnit_01",
					},
				},
				Image = "Codex_Portrait_LightRangedAsphodel",
			},
			BloodlessNaked =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessNaked", "BloodlessNaked_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessNaked_01",
					},
				},
				Image = "Codex_Portrait_BloodlessNaked",
			},
			BloodlessWaveFist =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessWaveFist", "BloodlessWaveFist_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessWaveFist_01",
					},
				},
				Image = "Codex_Portrait_BloodlessWaveMaker",
			},
			BloodlessBerserker =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessBerserker", "BloodlessBerserker_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessBerserker_01",
					},
				},
				Image = "Codex_Portrait_BloodlessBerserker",
			},
			BloodlessGrenadier =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessGrenadier", "BloodlessGrenadier_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessGrenadier_01",
					},
				},
				Image = "Codex_Portrait_BloodlessGrenadier",
			},
			BloodlessSelfDestruct =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessSelfDestruct", "BloodlessSelfDestruct_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessSelfDestruct_01",
					},
				},
				Image = "Codex_Portrait_BloodlessSelfDestruct",
			},
			BloodlessPitcher =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BloodlessPitcher", "BloodlessPitcher_Elite" },
								Comparison = ">=",
								Value = 8,
							},
						},
						Text = "CodexData_BloodlessPitcher_01",
					},
				},
				Image = "Codex_Portrait_BloodlessPitcher",
			},
			CorruptedShadeSmall =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "CorruptedShadeSmall", "CorruptedShadeSmall_Elite" },
								Comparison = ">=",
								Value = 25,
							},
						},
						Text = "CodexData_CorruptedShadeSmall_01",
					},
				},
				Image = "Codex_Portrait_CorruptedShadeS",
			},
			CorruptedShadeMedium =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "CorruptedShadeMedium", "CorruptedShadeMedium_Elite" },
								Comparison = ">=",
								Value = 20,
							},
						},
						Text = "CodexData_CorruptedShadeMedium_01",
					},
				},
				Image = "Codex_Portrait_CorruptedShadeM",
			},
			CorruptedShadeLarge =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "CorruptedShadeLarge", "CorruptedShadeLarge_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_CorruptedShadeLarge_01",
					},
				},
				Image = "Codex_Portrait_CorruptedShadeL",
			},
			DespairElemental =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "DespairElemental",  "DespairElemental_Elite", "DespairElementalLarge", "DespairElementalLarge_Elite",  },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_DespairElemental_01",
					},
				},
				Image = "Codex_Portrait_DespairElemental",
			},

			BrokenHearted =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "BrokenHearted", "BrokenHearted_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_BrokenHearted_01",
					},
				},
				Image = "Codex_Portrait_BrokenHearted",
			},
			Lovesick =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Lovesick", "Lovesick_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Lovesick_01",
					},
				},
				Image = "Codex_Portrait_Lovesick",
			},
			Mourner =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mourner", "Mourner_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Mourner_01",
					},
				},
				Image = "Codex_Portrait_Mourner",
			},
			LycanSwarmer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "LycanSwarmer", "LycanSwarmer_Elite" },
								Comparison = ">=",
								Value = 20,
							},
						},
						Text = "CodexData_LycanSwarmer_01",
					},
				},
				Image = "Codex_Portrait_LycanSwarmer",
			},
			Lycanthrope =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Lycanthrope", "Lycanthrope_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Lycanthrope_01",
					},
				},
				Image = "Codex_Portrait_Lycanthrope",
			},
			Vampire =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Vampire", "Vampire_Elite" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Vampire_01",
					},
				},
				Image = "Codex_Portrait_Vampire",
			},
			Lamia =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Lamia", "Lamia_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Lamia_01",
					},
				},
				Image = "Codex_Portrait_Lamia",
			},
			Lamia_Miniboss =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Lamia_Miniboss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_LamiaMiniboss_01",
					},
				},
				Image = "Codex_Portrait_LamiaMiniBoss",
			},

			Swarmer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Swarmer", "Swarmer_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_Swarmer_01",
					},
				},
				Image = "Codex_Portrait_Swarmer",
			},
			SwarmerClockwork =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SwarmerClockwork", "SwarmerClockwork_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_SwarmerClockwork_01",
					},
				},
				Image = "Codex_Portrait_SwarmerClockwork",
			},			
			ClockworkHeavyMelee =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ClockworkHeavyMelee", "ClockworkHeavyMelee_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ClockworkHeavyMelee_01",
					},
				},
				Image = "Codex_Portrait_WretchThug",
			},
			Crawler =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Crawler", "Crawler_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Crawler_01",
					},
				},
				Image = "Codex_Portrait_Crawler",
			},
			SatyrRatCatcher =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrRatCatcher", "SatyrRatCatcher_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_SatyrRatCatcher_01",
					},
				},
				Image = "Codex_Portrait_SatyrRatCatcher",
			},
			SatyrLancer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrLancer", "SatyrLancer_Elite" },
								Comparison = ">=",
								Value = 20,
							},
						},
						Text = "CodexData_SatyrLancer_01",
					},
				},
				Image = "Codex_Portrait_SatyrLancer",
			},
			SatyrCultist =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrCultist", "SatyrCultist_Elite" },
								Comparison = ">=",
								Value = 25,
							},
						},
						Text = "CodexData_SatyrCultist_01",
					},
				},
				Image = "TempIcon",
			},
			TimeElemental =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "TimeElemental", "TimeElemental_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_TimeElemental_01",
					},
				},
				Image = "Codex_Portrait_TimeElemental",
			},
			GoldElemental =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "GoldElemental", "GoldElemental_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_GoldElemental_01",
					},
				},
				Image = "Codex_Portrait_GoldElemental",
			},
			GoldElemental_MiniBoss =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "GoldElemental_MiniBoss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_GoldElementalMiniboss_01",
					},
				},
				Image = "Codex_Portrait_GoldElementalMiniBoss",
			},
			SatyrRatCatcher_Miniboss =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrRatCatcher_Miniboss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_SatyrRatCatcherMiniboss_01",
					},
				},
				Image = "Codex_Portrait_SatyrRatCatcherMiniBoss",
			},
		},
	},

	EnemiesSF =
	{
		TitleText = "Codex_EnemiesSFChapter",
		Icon = "GUI\\Screens\\Codex\\Icon-EnemiesSF",
		ShowKillCount = true,
		Entries =
		{
			Carrion =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Carrion", "Carrion_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Carrion_01",
					},
				},
				Image = "Codex_Portrait_Carrion",
			},
			Zombie =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Zombie", "Zombie_Elite" },
								Comparison = ">=",
								Value = 50,
							},
						},
						Text = "CodexData_Zombie_01",
					},
				},
				Image = "Codex_Portrait_Zombie",
			},
			ZombieOlympus =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieOlympus", "ZombieOlympus_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieOlympus_01",
					},
				},
				Image = "Codex_Portrait_ZombieOlympus",
			},
			ZombieCrewman =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieCrewman", "ZombieCrewman_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_ZombieCrewman_01",
					},
				},
				Image = "Codex_Portrait_ZombieCrewman",
			},
			ZombieAssassin =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieAssassin", "ZombieAssassin_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieAssassin_01",
					},
				},
				Image = "Codex_Portrait_ZombieAssassin",
			},
			ZombieHeavyRanged =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieHeavyRanged", "ZombieHeavyRanged_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieHeavyRanged_01",
					},
				},
				Image = "Codex_Portrait_ZombieHeavyRanged",
			},
			ZombieSpawner =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "ZombieSpawner", "ZombieSpawner_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_ZombieSpawner_01",
					},
				},
				Image = "Codex_Portrait_ZombieSpawner",
			},
			Mudman =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mudman", "Mudman_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_Mudman_01",
					},
				},
				Image = "Codex_Portrait_Mudman",
			},
			SatyrCrossbow =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrCrossbow" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_SatyrCrossbow_01",
					},
				},
				Image = "Codex_Portrait_SatyrCrossbow",
			},
			WaterElemental =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "WaterElemental", "WaterElemental_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_WaterElemental_01",
					},
				},
				Image = "Codex_Portrait_WaterElemental",
			},
			Scimiterror =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Scimiterror", "Scimiterror_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Scimiterror_01",
					},
				},
				Image = "Codex_Portrait_Scimiterror",
			},
			Mage2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Mage2", "Mage2_Elite" },
								Comparison = ">=",
								Value = 10,
							},
						},
						Text = "CodexData_Mage2_01",
					},
				},
				Image = "Codex_Portrait_Mage2",
			},
			Stickler =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Stickler", "Stickler_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Stickler_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaStickler",
			},
			Drunk =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Drunk", "Drunk_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Drunk_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaDrunk",
			},
			Swab =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Swab", "Swab_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_Swab_01",
					},
				},
				Image = "Codex_Portrait_DeadSeaSwab",
			},
			HarpyCutter =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "HarpyCutter", "HarpyCutter_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_HarpyCutter_01",
					},
				},
				Image = "Codex_Portrait_HarpyTalonCutter",
			},
			Charybdis =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Charybdis" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Charybdis_01",
					},
				},
				Image = "Codex_Portrait_Charybdis",
			},

			SentryBot =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SentryBot", "SentryBot_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_SentryBot_01",
					},
				},
				Image = "Codex_Portrait_SentryBot",
			},
			AutomatonBeamer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "AutomatonBeamer", "AutomatonBeamer_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_AutomatonBeamer_01",
					},
				},
				Image = "Codex_Portrait_AutomatonBeamer",
			},
			AutomatonEnforcer =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "AutomatonEnforcer", "AutomatonEnforcer_Elite" },
								Comparison = ">=",
								Value = 15,
							},
						},
						Text = "CodexData_AutomatonEnforcer_01",
					},
				},
				Image = "Codex_Portrait_AutomatonEnforcer",
			},
			SatyrLancer2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrLancer2", "SatyrLancer2_Elite" },
								Comparison = ">=",
								Value = 20,
							},
						},
						Text = "CodexData_SatyrLancer2_01",
					},
				},
				Image = "Codex_Portrait_SatyrLancer2",
			},
			SatyrCrossbow2 =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrCrossbow2", "SatyrCrossbow2_Elite" },
								Comparison = ">=",
								Value = 20,
							},
						},
						Text = "CodexData_SatyrCrossbow2_01",
					},
				},
				Image = "Codex_Portrait_SatyrCrossbow2",
			},
			SatyrSapper =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "SatyrSapper", "SatyrSapper_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_SatyrSapper_01",
					},
				},
				Image = "Codex_Portrait_SatyrSapper",
			},
			HarpyDropper =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "HarpyDropper", "HarpyDropper_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_HarpyDropper_01",
					},
				},
				Image = "Codex_Portrait_HarpyDropper",
			},
			Dragon =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Dragon", "Dragon_Elite" },
								Comparison = ">=",
								Value = 30,
							},
						},
						Text = "CodexData_Dragon_01",
					},
				},
				Image = "Codex_Portrait_Dragon",
			},
			Dragon_MiniBoss =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Dragon_MiniBoss" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_DragonMiniboss_01",
					},
				},
				Image = "Codex_Portrait_DragonMiniboss",
			},
			Talos =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "EnemyKills" },
								SumOf = { "Talos" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_Talos_01",
					},
				},
				Image = "Codex_Portrait_Talos",
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
			BiomeG =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "G" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeG_01",
					},
				},
				Image = "Codex_Portrait_BiomeOceanus",
			},
			BiomeH =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "H" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeH_01",
					},
				},
				Image = "Codex_Portrait_BiomeFields",
			},
			BiomeI =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "I" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeI_01",
					},
				},
				Image = "Codex_Portrait_BiomeTartarus",
			},

			BiomeN =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "N" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeN_01",
					},
				},
				Image = "Codex_Portrait_BiomeEphyra",
			},
			BiomeO =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "O" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeO_01",
					},
				},
				Image = "Codex_Portrait_BiomeThessaly",
			},
			BiomeP =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "P" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeP_01",
					},
				},
				Image = "Codex_Portrait_BiomeOlympus",
			},
			BiomeB =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "Anomaly" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_BiomeB_01",
					},
				},
				Image = "Codex_Portrait_AsphodelBiome",
			},
			BiomeHouse =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "RoomsEntered", "I_Boss01" },
								Comparison = ">=",
								Value = 2,
							},
						},
						Text = "CodexData_BiomeHouse_01",
					},
				},
				Image = "Codex_Portrait_BiomeHouseOfHades",
			},
			BiomeChaos =
			{
				Entries =
				{
					{
						UnlockGameStateRequirements =
						{
							{
								Path = { "GameState", "BiomeVisits", "Chaos" },
								Comparison = ">=",
								Value = 3,
							},
						},
						Text = "CodexData_BiomeChaos_01",
					},
				},
				Image = "Codex_Portrait_ChaosBiome",
			},
		},
	},
}