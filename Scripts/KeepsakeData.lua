GiftIconData = 
{
	GiftPoints = 
	{
		FilledWithGift = "FilledHeartWithGiftIcon",
		Filled = "FilledHeartIcon",
		Empty = "EmptyHeartIcon",
		EmptyWithGift = "EmptyHeartWithGiftIcon",
		Locked = "LockedHeartIcon",
		GiftText = "GiftUseText",
		Unavailable = "UnavailableHeartIcon",
		Mystery = "MysteryHeartIcon",
	},
	SuperGiftPoints = 
	{
		FilledWithGift = "FilledSuperHeartWithGiftIcon",
		Filled = "FilledSuperHeartIcon",
		Empty = "EmptySuperHeartIcon",
		EmptyWithGift = "EmptySuperHeartWithGiftIcon",
		Locked = "LockedSuperHeartIcon",
		GiftText = "SuperGiftUseText",
		Unavailable = "UnavailableHeartIcon",
		Mystery = "MysteryHeartIcon",
	},
}

GiftData =
{

	DefaultGiftData =
	{
		Value = 0,
		Locked = 5,
		Maximum = 8,
	},

	DefaultGodGiftData =
	{
		Value = 0,
		Locked = 5,
		Maximum = 7,
	},

	NPC_Dora_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "DoraGift01" },
				},
			},
			Gift = "DoorHealReserveKeepsake" 
		},
	},

	NPC_Nemesis_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NemesisGift01" },
				},
			},
			Gift = "DeathVengeanceKeepsake" 
		},
	},

	NPC_Charon_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "CharonGift01" },
				},
			},
			Gift = "BonusMoneyKeepsake" 
		},
	},

	NPC_Skelly_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "SkellyGift01" },
				},
			},
			Gift = "ReincarnationKeepsake" 
		},
	},

	NPC_Moros_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
				},
			},
			Gift = "BlockDeathKeepsake" 
		},
	},

	NPC_Odysseus_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "OdysseusGift01" },
				},
			},
			Gift = "BossPreDamageKeepsake" 
		},
	},

	NPC_Hecate_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateGift01" },
				},
			},
			Gift = "ManaOverTimeRefundKeepsake" 
		},
	},

	NPC_Artemis_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
				},
			},
			Gift = "LowHealthCritKeepsake" 
		},
	},

	SpellDrop = 
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "SeleneGift01" },
				},
			},
			Gift = "SpellTalentKeepsake" 
		},

	},

	NPC_Arachne_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
				},
			},
			Gift = "ArmorGainKeepsake" 
		},
	},
	
	NPC_Narcissus_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift01" },
				},
			},
			Gift = "FountainRarityKeepsake" 
		},
	},
	
	NPC_Eris_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "ErisGift01", "ErisGift01_B" },
				},
			},
			Gift = "EscalatingKeepsake" 
		},
	},

	NPC_Echo_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
			},
			Gift = "UnpickedBoonKeepsake" 
		},
	},

	NPC_Medea_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "MedeaGift01" },
				},
			},
			Gift = "DamagedDamageBoostKeepsake" 
		},
	},

	NPC_Heracles_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift01" },
				},
			},
			Gift = "DecayingBoostKeepsake" 
		},
	},

	NPC_Icarus_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
				},
			},
			Gift = "TempHammerKeepsake" 
		},
	},

	NPC_Circe_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "CirceGift01" },
				},
			},
			Gift = "BossMetaUpgradeKeepsake" 
		},
	},

	ZeusUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZeusGift01" },
				},
			},
			Gift = "ForceZeusBoonKeepsake" 
		},
	},
	HeraUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HeraGift01" },
				},
			},
			Gift = "ForceHeraBoonKeepsake" 
		},
	},
	PoseidonUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift01" },
				},
			},
			Gift = "ForcePoseidonBoonKeepsake" 
		},
	},
	ApolloUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ApolloGift01" },
				},
			},
			Gift = "ForceApolloBoonKeepsake" 
		},
	},
	DemeterUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
				},
			},
			Gift = "ForceDemeterBoonKeepsake" 
		},
	},
	AphroditeUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01" },
				},
			},
			Gift = "ForceAphroditeBoonKeepsake" 
		},
	},
	HephaestusUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift01" },
				},
			},
			Gift = "ForceHephaestusBoonKeepsake" 
		},
	},
	HestiaUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HestiaGift01" },
				},
			},
			Gift = "ForceHestiaBoonKeepsake" 
		},
	},
	HermesUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HermesGift01" },
				},
			},
			Gift = "TimedBuffKeepsake" 
		},
	},
	TrialUpgrade = 
	{
		InheritFrom = { "DefaultGiftData" },
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
				},
			},
			Gift = "RandomBlessingKeepsake" 
		},
	},

}

ScreenData.KeepsakeRack = 
{
	Components = {},
	BlockPause = true,
	GamepadNavigation =
	{
		FreeFormSelecSearchFromId = 0,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},
	-- OpenSound = "/Leftovers/World Sounds/Caravan Interior/CabinetClose",

	BaseIconScale = 0.48,
	HoverIconScale = 0.58,

	SpacerX = 115,
	SpacerY = 176,
	StartX = 446,
	StartY = 226,
	RowMax = 11,

	TooltipX = 1634,
	TooltipY = 740,

	ItemOrder =
	{
		-- row 1 (11 items)
		"ManaOverTimeRefundKeepsake",	-- Hecate
		"BossPreDamageKeepsake",		-- Odysseus
		"ReincarnationKeepsake",		-- Skelly
		"DoorHealReserveKeepsake",		-- Dora
		"DeathVengeanceKeepsake",		-- Nemesis
		"BlockDeathKeepsake",			-- Moros
		"EscalatingKeepsake",			-- Eris
		"BonusMoneyKeepsake",			-- Charon
		"TimedBuffKeepsake",			-- Hermes
		"LowHealthCritKeepsake",		-- Artemis
		"SpellTalentKeepsake",			-- Selene

		-- row 2
		"ForceZeusBoonKeepsake",		-- Zeus
		"ForceHeraBoonKeepsake",		-- Hera
		"ForcePoseidonBoonKeepsake",	-- Poseidon
		"ForceDemeterBoonKeepsake",		-- Demeter
		"ForceApolloBoonKeepsake",		-- Apollo
		"ForceAphroditeBoonKeepsake",	-- Aphrodite
		"ForceHephaestusBoonKeepsake",	-- Hephaestus
		"ForceHestiaBoonKeepsake",		-- Hestia
		"DecayingBoostKeepsake",		-- Heracles
		"DamagedDamageBoostKeepsake",	-- Medea
		"BossMetaUpgradeKeepsake",		-- Circe

		-- row 3
		"ArmorGainKeepsake",			-- Arachne
		"FountainRarityKeepsake",		-- Narcissus
		"UnpickedBoonKeepsake",			-- Echo
		"TempHammerKeepsake",			-- Icarus
		"RandomBlessingKeepsake",		-- Chaos
	},

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,
		UseNativeScreenCenter = true,
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundTint",
			"ActionBarBackground",
			"ShopBackground",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.15, 0.15, 0.15, 0.85}
		},

		ShopBackground = 
		{
			Graphic = "AwardMenuBackground", 
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				--[[
				ShopTitle = 
				{
					Text = "AwardMenu_Title",
					TextArgs =  
					{
						FontSize = 36, 
						OffsetX = -230, 
						OffsetY = -490, 
						Color = Color.White, 
						Font = "SpectralSCLightTitling", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center" 
					}
				},
				ShopSubtitle = 
				{
					Text = "AwardMenu_SubTitle",
					TextArgs =  
					{
						OffsetX = -230, 
						OffsetY = -440, 
						Width = 840, 
						Color = Color.SubTitle, 
						Font = "P22UndergroundSCMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center"
					}
				},
				]]--
			},
		},

		--[[
		Sticker = 
		{
			X = 1325 + 230,
			Y = 795,
			GroupName = "Combat_Menu_Additive"
		},
		]]

		InfoBoxBacking =
		{
			Graphic = "BlankObstacle",
			Animation = "KeepsakeSlotBase",
			X = 714,
			Y = 803,
			Alpha = 0.0,

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

		RankProgressBox = 
		{
			--[[Graphic = "WeaponShopBacking",]]--
			ScaleY = 0.06,
			ScaleX = 1.56,
			X = 700,
			Y = 945,
			Alpha = 1.0,
			Children = 
			{
				--[[
				EquipSubtitle = 
				{
					OffsetX = 550,
					OffsetY = 8,
					TextArgs = 
					{
						FontSize = 22, 
						Width = 999,
						Color = Color.LightSlateGray, 
						Font = "LatoMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset = {0, 2}, 
						Justification = "Right",
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					},
				},
				]]

				--[[
				CurrentLevel = 
				{
					OffsetX = -550,
					OffsetY = -12,
					TextArgs = 
					{
						FontSize = 24,
						Width = 450,
						Justification = "Left",
						Font = "P22UndergroundSCMedium",
						Format = "BaseFormat",
						VariableAutoFormat = "BoldFormatGraft",
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					}
				},
				]]

				LevelProgress = 
				{
					OffsetX = 50,
					OffsetY = -4,
					TextArgs = 
					{
						FontSize = 20,
						Width = 999,
						Justification = "Center",
						Font = "LatoMedium",
						Format = "BaseFormat",
						VariableAutoFormat = "BoldFormatGraft",
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					}
				},
			}
		},

		HoverFrame =
		{
			Graphic = "BlankObstacle",
			AnimationName = "AwardMenuCursorHighlight",
			Alpha = 0.0,
		},

		EquippedFrame =
		{
			Graphic = "BlankObstacle",
			AnimationName = "AwardMenuItemEquipped",
			Alpha = 0.0,
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
					Text = "Menu_Equip",
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
						OnPressedFunctionName = "KeepsakeScreenClose",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	}
}