DebugData = DebugData or {}
DebugState = DebugState or {}
DebugState.TextLinesFilter = DebugState.TextLinesFilter or {}

HotLoadInfo = HotLoadInfo or {}

ScreenData.DebugEnemySpawn =
{
	Name = "DebugEnemySpawn",
	BlockPause = true,
	Components = {},
	
	ButtonsPerRow = 6,
	SpacingX = 280,
	SpacingY = 86,
	
	PagesPerRow = 5,
	PageStartX = 600,
	PageSpacingX = 240,
	PageSpacingY = 100,
	PageHighlightColor = { 0, 64, 64, 255 },
	
	FadeOutTime = 0.0,

	OpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
	CloseSound = "/Leftovers/Menu Sounds/InfoPanelOutURSA",

	Pages =
	{
		-- Underworld
		{
			Name = "BiomeF",
			Biomes = { "BiomeF", },
			ManualEnemies =
			{
				"Treant",
				"FogEmitter",
				"Hecate",
			},
		},
		{
			Name = "BiomeG",
			Biomes = { "BiomeG", },
			ManualEnemies =
			{
				"WaterUnitMiniboss",
				"CrawlerMiniboss",
				"Scylla",
				"SirenKeytarist",
				"SirenDrummer",
			},
		},
		{
			Name = "BiomeH",
			RoomSetName = "H",
			Biomes = { "BiomeHDebugSpawnScreen", },
			ManualEnemies =
			{
				"InfestedCerberus",
			},
		},
		{
			Name = "BiomeI",
			Biomes = { "BiomeI", },
			ManualEnemies =
			{
				"GoldElemental_MiniBoss",
				"Chronos",
			},
		},
		{
			Name = "BiomeB",
			Biomes = { "BiomeB", },
		},
		
		-- Surface
		{
			Name = "BiomeN",
			Biomes = { "BiomeN", },
			ManualEnemies =
			{
				"SatyrCrossbow",
				"Polyphemus",
			},
		},
		{
			Name = "BiomeO",
			Biomes = { "BiomeO", },
			ManualEnemies =
			{
				"Charybdis",
				"Eris",
			},
		},
		{
			Name = "BiomeP",
			Biomes = { "BiomeP", },
		},
		{
			Name = "BiomeQ",
			Biomes = { "BiomeQ", },
		},
		{
			Name = "NPCs",
			Biomes = {},
			ManualEnemies =
			{
				"NPC_Hecate_01",
				"NPC_Odysseus_01",
				"NPC_Dora_01",
				"NPC_Nemesis_01",
				"NPC_Eris_01",
				"NPC_Moros_01",
				"NPC_Hypnos_01",
				"NPC_Charon_01",
				"NPC_Selene_01",
				"NPC_Skelly_01",

				"NPC_Chronos_01",
				"NPC_Chronos_Story_01",
				"NPC_Arachne_01",
				"NPC_Heracles_01",

				"NPC_Artemis_Field_01",
				"NPC_Artemis_01",
				"NPC_Hermes_01",

				"NPC_Narcissus_01",
				"NPC_Narcissus_Field_01",
				"NPC_Echo_01",
				"NPC_Icarus_01",
				"NPC_Medea_01",
				"NPC_Circe_01",

				"NPC_Hecate_Story_01",
				"NPC_Nyx_01",

				"NPC_Hades_Field_01",
				"NPC_Cerberus_Field_01",
				"NPC_Bouldy_01",
			},
		},
		--[[
		{
			Name = "BiomeQ",
			Biomes = { "BiomeQ", },
		},
		]]
		{
			Name = "TestEnemies",
			Biomes = { "TestEnemies", },
		},
	},
	PageIds = {},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = { 0.15, 0.15, 0.15, 0.85 },
			Children = 
			{
				ToggleSpawnIdle =
				{
					Graphic = "ToggleButton",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.8,
					OffsetX = -900,
					OffsetY = -400,
					Text = "DebugEnemySpawnIdle",
					TextArgs =
					{
						FontSize = 24,
						OffsetX = 36, OffsetY = 0,
						Color = Color.White,
						Font = "LatoBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						FadeOpacity = 1.0,
					},
					Data =
					{
						OnPressedFunctionName = "ToggleDebugEnemySpawnIdle",
					},
				},

				ToggleSpawnAtHero =
				{
					Graphic = "ToggleButton",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.8,
					OffsetX = -900,
					OffsetY = -340,
					Text = "DebugEnemySpawnAtHero",
					TextArgs =
					{
						FontSize = 24,
						OffsetX = 36, OffsetY = 0,
						Color = Color.White,
						Font = "LatoBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						FadeOpacity = 1.0,
					},
					Data =
					{
						OnPressedFunctionName = "ToggleDebugEnemySpawnAtHero",
					},
				},

				ToggleSpawnWithAttribute =
				{
					Graphic = "ToggleButton",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.8,
					OffsetX = -900,
					OffsetY = -280,
					Text = "DebugEnemySpawnWithAttribute",
					TextArgs =
					{
						FontSize = 24,
						OffsetX = 36, OffsetY = 0,
						Color = Color.White,
						Font = "LatoBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						FadeOpacity = 1.0,
					},
					Data =
					{
						OnPressedFunctionName = "ToggleDebugEnemySpawnWithAttribute",
					},
				},

				CloseButton = 
				{
					Graphic = "ButtonClose",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.5,
					OffsetX = 900,
					OffsetY = 500,
					Data =
					{
						OnPressedFunctionName = "DebugEnemySpawnScreenClose",
						ControlHotkeys = { "Cancel", },
					},
				},
			},
		},
	},
}

ScreenData.DebugConversations =
{
	Name = "DebugConversations",
	BlockPause = true,
	Components = {},

	OpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
	CloseSound = "/Leftovers/Menu Sounds/InfoPanelOutURSA",

	ButtonStartX = 60,
	ButtonStartY = 270,
	ButtonScaleX = 0.5,
	ButtonScaleY = 0.5,
	SpacingX = 120,
	SpacingY = 40,
	ColumnsPerRow = 2,
	
	ListStartX = 320,
	ListStartY = 100,
	ListSpacingX = 550,
	ListSpacingY = 50,
	ListMaxY = 1050,
	ListSpacingYBucket = 35,
	ListColumnsPerScreen = 3,

	ColumnOffset = 0,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_TraitTray",

		Order =
		{
			"BackgroundDim",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = { 0.090, 0.055, 0.157, 0.9 },
		},

		TooltipBacking = 
		{
			AnimationName = "DebugConversationTooltipBacking",
			GroupName = "Combat_Menu_TraitTray_Overlay",
			Alpha = 0.0,
			AlphaTarget = 0.0,
		},

		PageLeft = 
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "GUI\\Graybox\\Arrow_Left",
			X = 300,
			Y = 50,
			Scale = 0.8,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Sound = "/SFX/Menu Sounds/DialoguePanelOutMenu",
			Data =
			{
				OnPressedFunctionName = "DebugConversationsPageLeft",
				ControlHotkey = "MenuLeft",
			},
		},

		PageRight = 
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "GUI\\Graybox\\Arrow_Right",
			X = 400,
			Y = 50,
			Scale = 0.8,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Sound = "/SFX/Menu Sounds/DialoguePanelOutMenu",
			Data =
			{
				OnPressedFunctionName = "DebugConversationsPageRight",
				ControlHotkey = "MenuRight",
			},
		},

		CloseButton = 
		{
			Graphic = "ButtonClose",
			Scale = 0.7,
			Color = Color.TransparentBlack,
			X = 1920 - 50,
			Y = 1080 - 50,
			Data =
			{
				OnPressedFunctionName = "DebugConversationsClose",
				ControlHotkey = "Cancel",
			},
		},
	},
}

UserDebugEquip =
{
	Amir =
	{
		Weapon = "WeaponAxe",
		Traits =
		{
			"AxeSecondStageTrait",
			-- "OmegaZeroBurnBoon",
			-- "BlindChanceBoon",
			-- "ZeusSprintBoon",

			-- "SpellLaserTrait",
			-- "SpellTimeSlowTrait",
			-- "SpellPotionTrait",
			-- "SpellMeteorTrait",
			-- "SpellLeapTrait",
			-- "SpellPolymorphTrait",
			-- "SpellTransformTrait",
			-- "SpellSummonTrait",
		}
	},
	Alice = 
	{
		Traits =
		{
			"IcedEnemyBoon",
		}		
	},
	["Josh Barnett"] = 
	{
		Traits = 
		{
			-- "SpellMeteorTrait",
			-- "MeteorShowerTalent",
			"OmegaPoseidonProjectileBoon",
			-- "ApolloWeaponBoon",
			-- "AphroditeWeaponBoon",
			-- "AresWeaponBoon",
			-- "DemeterWeaponBoon",
			-- "HeraWeaponBoon",
			-- "HephaestusWeaponBoon",
			-- "PoseidonWeaponBoon",
			-- "ZeusWeaponBoon",

			-- "ApolloSpecialBoon",
			-- "AphroditeSpecialBoon",
			-- "AresSpecialBoon",
			-- "DemeterSpecialBoon",
			-- "HeraSpecialBoon",
			-- "HephaestusSpecialBoon",
			-- "PoseidonSpecialBoon",
			-- "ZeusSpecialBoon",

			-- "ApolloCastBoon",
			-- "AphroditeCastBoon",
			-- "AresCastBoon",
			-- "DemeterCastBoon",
			-- "HeraCastBoon",
			-- "HephaestusCastBoon",
			-- "PoseidonCastBoon",
			-- "ZeusCastBoon",

			-- "ApolloSprintBoon",
			-- "AphroditeSprintBoon",
			-- "AresSprintBoon",
			-- "DemeterSprintBoon",
			-- "HeraSprintBoon",
			-- "HephaestusSprintBoon",
			-- "PoseidonSprintBoon",
			-- "ZeusSprintBoon",
		}
	},
	["Eduardo G"] = 
	{
		Traits = 
		{
			"SpellSummonTrait",
		}
	},
	-- boon test
	["Greg Kasavin"] =
	{
		-- Weapon = "WeaponAxe",
		Traits =
		{
			"SpellPolymorphTrait",
			"PolymorphZeusTalent",
			-- "StaffRaiseDeadAspect",
			-- "DaggerTripleAspect",
			-- "TorchAutofireAspect",
			-- "AxeRallyAspect",
			-- "LobGunAspect",
			-- "SuitComboAspect",

			-- "ZeusWeaponBoon",
			-- "HeraWeaponBoon",
			-- "PoseidonWeaponBoon",
			-- "DemeterWeaponBoon",
			-- "ApolloWeaponBoon",
			-- "AphroditeWeaponBoon",
			-- "HephaestusWeaponBoon",
			-- "HestiaWeaponBoon",
			-- "AresWeaponBoon",
			-- "SpellLaserTrait",
			-- "SpellTimeSlowTrait",
			-- "SpellPotionTrait",
			-- "SpellMeteorTrait",
			-- "SpellLeapTrait",
			-- "SpellPolymorphTrait",
			-- "SpellTransformTrait",
			-- "SpellSummonTrait",
			-- "SpellMoonBeamTrait",
		}
	},	
}