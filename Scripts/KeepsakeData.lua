GiftData =
{

	DefaultGiftData =
	{
		Value = 0,
		Locked = 5,
		Maximum = 8,
	},

	NPC_Dora_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" }
			},
		},
		MaxedIcon = "Keepsake_Dora_Corner",
		MaxedSticker = "Keepsake_Dora",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisBathHouse03" }
			},
		},
		MaxedIcon = "Keepsake_Nemesis_Corner",
		MaxedSticker = "Keepsake_Nemesis",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGift08" }
			},
		},
		MaxedIcon = "Keepsake_Charon_Corner",
		MaxedSticker = "Keepsake_Charon",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SkellyGift09" }
			},
		},
		MaxedIcon = "Keepsake_Skelly_Corner",
		MaxedSticker = "Keepsake_Skelly",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna02" }
			},
		},
		MaxedIcon = "Keepsake_Moros_Corner",
		MaxedSticker = "Keepsake_Moros",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "OdysseusFishing02" }
			},
		},
		MaxedIcon = "Keepsake_Odysseus_Corner",
		MaxedSticker = "Keepsake_Odysseus",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" }
			},
		},
		MaxedIcon = "Keepsake_Hecate_Corner",
		MaxedSticker = "Keepsake_Hecate",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift10" }
			},
		},
		MaxedIcon = "Keepsake_Artemis_Corner",
		MaxedSticker = "Keepsake_Artemis",
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
	NPC_Dionysus_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DionysusGift07" }
			},
		},
		MaxedIcon = "Keepsake_Dionysus_Corner",
		MaxedSticker = "Keepsake_Dionysus",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "DionysusGift01" },
				},
			},
			Gift = "SkipEncounterKeepsake" 
		},
	},
	NPC_Athena_01 =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AthenaGift07" }
			},
		},
		MaxedIcon = "Keepsake_Athena_Corner",
		MaxedSticker = "Keepsake_Athena",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "AthenaGift01" },
				},
			},
			Gift = "AthenaEncounterKeepsake" 
		},
	},

	SpellDrop = 
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneGift09" }
			},
		},
		MaxedIcon = "Keepsake_Selene_Corner",
		MaxedSticker = "Keepsake_Selene",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGift09" }
			},
		},
		MaxedIcon = "Keepsake_Arachne_Corner",
		MaxedSticker = "Keepsake_Arachne",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift07" }
			},
		},
		MaxedIcon = "Keepsake_Narcissus_Corner",
		MaxedSticker = "Keepsake_Narcissus",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" }
			},
		},
		MaxedIcon = "Keepsake_Eris_Corner",
		MaxedSticker = "Keepsake_Eris",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ErisGift01" },
				},
			},
			Gift = "EscalatingKeepsake" 
		},
	},

	NPC_Echo_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "EchoGift08" }
			},
		},
		MaxedIcon = "Keepsake_Echo_Corner",
		MaxedSticker = "Keepsake_Echo",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGift08" }
			},
		},
		MaxedIcon = "Keepsake_Medea_Corner",
		MaxedSticker = "Keepsake_Medea",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift07" }
			},
		},
		MaxedIcon = "Keepsake_Heracles_Corner",
		MaxedSticker = "Keepsake_Heracles",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift10" }
			},
		},
		MaxedIcon = "Keepsake_Icarus_Corner",
		MaxedSticker = "Keepsake_Icarus",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGift08" }
			},
		},
		MaxedIcon = "Keepsake_Circe_Corner",
		MaxedSticker = "Keepsake_Circe",
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

	NPC_Zagreus_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsBondForged01" }
			},
		},
		MaxedIcon = "Keepsake_Zagreus_Corner",
		MaxedSticker = "Keepsake_Zagreus",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsKeepsakeOutro01" },
				},
			},
			Gift = "RarifyKeepsake" 
		},
	},

	NPC_Hades_Field_01 = 
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift06" }
			},
		},
		MaxedIcon = "Keepsake_HadesAndPersephone_Corner",
		MaxedSticker = "Keepsake_HadesAndPersephone",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift01" },
				},
			},
			Gift = "HadesAndPersephoneKeepsake" 
		},
	},

	NPC_Chronos_02 = 
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" }
			},
		},
		MaxedIcon = "Keepsake_Chronos_Corner",
		MaxedSticker = "Keepsake_Chronos",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift01" },
				},
			},
			Gift = "GoldifyKeepsake" 
		},
	},

	ZeusUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusGift07" }
			},
		},
		MaxedIcon = "Keepsake_Zeus_Corner",
		MaxedSticker = "Keepsake_Zeus",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraGift07" }
			},
		},
		MaxedIcon = "Keepsake_Hera_Corner",
		MaxedSticker = "Keepsake_Hera",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift07" }
			},
		},
		MaxedIcon = "Keepsake_Poseidon_Corner",
		MaxedSticker = "Keepsake_Poseidon",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ApolloGift07" }
			},
		},
		MaxedIcon = "Keepsake_Apollo_Corner",
		MaxedSticker = "Keepsake_Apollo",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DemeterGift08" }
			},
		},
		MaxedIcon = "Keepsake_Demeter_Corner",
		MaxedSticker = "Keepsake_Demeter",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift07" }
			},
		},
		MaxedIcon = "Keepsake_Aphrodite_Corner",
		MaxedSticker = "Keepsake_Aphrodite",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift07" }
			},
		},
		MaxedIcon = "Keepsake_Hephaestus_Corner",
		MaxedSticker = "Keepsake_Hephaestus",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HestiaGift07" }
			},
		},
		MaxedIcon = "Keepsake_Hestia_Corner",
		MaxedSticker = "Keepsake_Hestia",
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
	AresUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AresGift07" }
			},
		},
		MaxedIcon = "Keepsake_Ares_Corner",
		MaxedSticker = "Keepsake_Ares",
		[1] = 
		{ 
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "AresGift01" },
				},
			},
			Gift = "ForceAresBoonKeepsake" 
		},
	},
	HermesUpgrade =
	{
		InheritFrom = { "DefaultGiftData" },
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" }
			},
		},
		MaxedIcon = "Keepsake_Hermes_Corner",
		MaxedSticker = "Keepsake_Hermes",
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
		MaxedRequirement =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGift07" }
			},
		},
		MaxedIcon = "Keepsake_Chaos_Corner",
		MaxedSticker = "Keepsake_Chaos",
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

	BaseIconScale = 0.55,
	HoverIconScale = 0.65,

	RankAnimations =
	{
		"Frame_Keepsake_Rank1",
		"Frame_Keepsake_Rank2",
		"Frame_Keepsake_Rank3",
		"Frame_Keepsake_Rank4",
		"Frame_Keepsake_Rank5",
	},
	RankOffsetY = 100,
	RankScale = 0.5,

	SpacerX = 115.5,
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
		"BonusMoneyKeepsake",			-- Charon
		"BlockDeathKeepsake",			-- Moros
		"EscalatingKeepsake",			-- Eris
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
		"ForceAresBoonKeepsake",		-- Ares
		"AthenaEncounterKeepsake",		-- Athena
		"SkipEncounterKeepsake",		-- Dionysus

		-- row 3
		"ArmorGainKeepsake",			-- Arachne
		"FountainRarityKeepsake",		-- Narcissus
		"UnpickedBoonKeepsake",			-- Echo
		"DecayingBoostKeepsake",		-- Heracles
		"DamagedDamageBoostKeepsake",	-- Medea
		"BossMetaUpgradeKeepsake",		-- Circe
		"TempHammerKeepsake",			-- Icarus
		"HadesAndPersephoneKeepsake",	-- Hades & Persephone
		"RarifyKeepsake",				-- Zagreus
		"GoldifyKeepsake",				-- Chronos
		"RandomBlessingKeepsake",		-- Chaos
	},

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundTint",
			"ActionBarBackground",
			"ShopBackground",
			"InfoBoxBacking",
			"RankProgressBox",
			"EquippedFrame",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {20, 23, 46, 216}
		},

		ShopBackground = 
		{
			Animation = "AwardMenuBackground",
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
					TextArgs = 
					{
						OffsetX = -420,
						OffsetY = 80,
						LineSpacingBottom = 4,
						LangOffsetY = 
						{
							{ Code = "zh-TW", Value = 83 },
							{ Code = "ko", Value = 85 },
						},
						LangLineSpacingBottom =
						{
							{ Code = "zh-TW", Value = -10 },
						},
						Width = 920.5,
						Color = {0.384, 0.408, 0.475, 1.0},
						Font = "LatoItalic",
						FontSize = 18,
						ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2},
						Justification = "Left",
					},
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
				Sticker = 
				{
					OffsetX = 610,
					OffsetY = -145,
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
			AnimationName = "AwardMenuItemEquippedIn",
			Alpha = 0.0, 
			GroupName = "Combat_Menu_TraitTray",
		},

		SaveFirstFrame =
		{
			Graphic = "BlankObstacle",
			AnimationName = "AwardMenuItemSaveFirst",
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
				"SaveFirstButton",
			},

			Children =
			{
				SaveFirstButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "KeepsakeScreenSaveFirst",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_SaveKeepsake",
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

-- Keepsakes Lines
GlobalVoiceLines.OpenedAwardMenuVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	Cooldowns =
	{
		{ Name = "KeepsakesMentionedRecently", Time = 200 },
		{ Name = "MelinoeRemainsSilent", Time = 8 },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "StoryResetCount" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				CountOf =
				{
					"HadesWithPersephoneGift01",
					"NeoChronosGift01",
					"ZagreusBossGrantsBondForged01",
				},
				Comparison = ">=",
				Value = 2,
			},
		},
		{ Cue = "/VO/Melinoe_5781", Text = "These Keepsakes, have I... had them all this time...?" },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "KeepsakeFavoritesAddedVO",
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeKeepsakeSaveFirst" },
			},
		},
		{ Cue = "/VO/Melinoe_3760", Text = "I now can remember a Keepsake to start with each night..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "NPC_Chronos_01",
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
		},

		{ Cue = "/VO/Chronos_0697", Text = "{#Emph}Hmm, hm, hmm, hmmm..." },
		{ Cue = "/VO/Chronos_0698", Text = "{#Emph}...hm, hmm, hm, hmmm..." },
		{ Cue = "/VO/Chronos_0699", Text = "I shall wait.", PlayFirst = true },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.33,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
		},
		Cooldowns =
		{
			{ Name = "MelSwitchKeepsakeHintVO", Time = 20 },
		},

		{ Cue = "/VO/MelinoeField_0721", Text = "Should I change things up?" },
		{ Cue = "/VO/MelinoeField_0722", Text = "Maybe I should switch." },
		{ Cue = "/VO/MelinoeField_0723", Text = "Try another one maybe..." },
		{ Cue = "/VO/MelinoeField_0724", Text = "Could try a different one..." },
		{ Cue = "/VO/MelinoeField_0725", Text = "Which one would help..." },
		{ Cue = "/VO/MelinoeField_0726", Text = "Which Keepsake now..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.2,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 8 },
		},

		{ Cue = "/VO/Melinoe_0834", Text = "My Keepsakes...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2642", Text = "Which one..." },
		{ Cue = "/VO/Melinoe_2643", Text = "I'm in the mood for..." },
		{ Cue = "/VO/Melinoe_2644", Text = "Faith of my comrades..." },
		{ Cue = "/VO/Melinoe_2645", Text = "Another Keepsake perhaps...?" },
		{ Cue = "/VO/Melinoe_3174", Text = "This night calls for..." },
		{ Cue = "/VO/Melinoe_3177", Text = "Which shall it be..." },
		{ Cue = "/VO/Melinoe_3175", Text = "Which Keepsake for tonight...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3176", Text = "Everything's in order...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3178", Text = "Which to use first...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3179", Text = "Which to start with...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
	},
}
GlobalVoiceLines.AwardMenuNewAvailableVoiceLines =
{
	Cooldowns =
	{
		{ Name = "KeepsakesMentionedRecently", Time = 200 },
	},
	{
		{
			SkipAnim = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
					PathTrue = { "ActiveScreens", "KeepsakeRack" },
				},
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Chronos_01" }, Alive = false },
				},
			},

			-- ~8 variants?
			{ Cue = "/VO/Melinoe_0834", Text = "My Keepsakes...",
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/Melinoe_3207", Text = "What's that one do?" },
			{ Cue = "/VO/Melinoe_3208", Text = "A new Keepsake...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3209", Text = "My collection grows..." },
			{ Cue = "/VO/Melinoe_3210", Text = "New Keepsake there..." },
			{ Cue = "/VO/Melinoe_0836", Text = "Something new there?" },
			{ Cue = "/VO/Melinoe_0837", Text = "Expanded my collection..." },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			ObjectType = "NPC_Skelly_01",

			{ Cue = "/VO/Skelly_0082", Text = "Behold that heirloom storage case over there!" },
		},
	},
}
GlobalVoiceLines.AwardMenuEmptyVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		PreLineWait = 0.4,

		{ Cue = "/VO/Melinoe_0835", Text = "I'd store my Keepsakes here, if I had any..." },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Skelly_01",

		{ Cue = "/VO/Skelly_0082", Text = "Behold that heirloom storage case over there!" },
	},
}
GlobalVoiceLines.AwardSelectedVoiceLines =
{
	{
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredAlive",
				FunctionArgs = { Units = { "NPC_Chronos_01" }, Alive = false },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0838", Text = "This one." },
		{ Cue = "/VO/Melinoe_0839", Text = "That one." },
		{ Cue = "/VO/Melinoe_0840", Text = "Should work." },
		{ Cue = "/VO/Melinoe_0841", Text = "Should keep me company." },
		{ Cue = "/VO/Melinoe_2646", Text = "Ought to help." },
		{ Cue = "/VO/Melinoe_2647", Text = "Very well." },
		{ Cue = "/VO/Melinoe_2648", Text = "Sure." },
		{ Cue = "/VO/Melinoe_3204", Text = "All right." },
		{ Cue = "/VO/Melinoe_3205", Text = "This, then." },
		{ Cue = "/VO/Melinoe_3206", Text = "Might as well." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.15,
		ObjectType = "NPC_Skelly_01",
		Cooldowns =
		{
			{ Name = "SkellyKeepsakeSpeech", Time = 60 },
		},

		{ Cue = "/VO/Skelly_0128", Text = "May it serve you well." },
		{ Cue = "/VO/Skelly_0129", Text = "A fine selection!" },
		{ Cue = "/VO/Skelly_0130", Text = "A fine selection." },
		{ Cue = "/VO/Skelly_0131", Text = "That's no mere trinket, huh?" },
		{ Cue = "/VO/Skelly_0740", Text = "Preparation is {#Emph}key!" },
		{ Cue = "/VO/Skelly_0741", Text = "What's that you got?" },
		{ Cue = "/VO/Skelly_0742", Text = "Which one'd you pick?" },
		{ Cue = "/VO/Skelly_0743", Text = "{#Emph}Ah{#Prev}, yes..." },
		{ Cue = "/VO/Skelly_0744", Text = "Should do you good." },
		{ Cue = "/VO/Skelly_0745", Text = "You done back there?" },
	},
}
GlobalVoiceLines.AwardMenuClosedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.25,
		ObjectType = "NPC_Chronos_01",
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "ChronosAnyQuipSpeech", Time = 8 },
		},

		{ Cue = "/VO/Chronos_0081", Text = "{#Emph}Ahem?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Chronos_0081" },
				},
			},
		},
		{ Cue = "/VO/Chronos_0082", Text = "Please take your time.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Chronos_0082" },
				},
			},
		},
		{ Cue = "/VO/Chronos_0700", Text = "Are we quite done?", PlayFirst = true },
		{ Cue = "/VO/Chronos_0701", Text = "Fine choice." },
		{ Cue = "/VO/Chronos_0776", Text = "What have you there?" },
		{ Cue = "/VO/Chronos_0777", Text = "A trinket of some sort?" },
		{ Cue = "/VO/Chronos_0778", Text = "{#Emph}Oh{#Prev}, fine choice!" },
		{ Cue = "/VO/Chronos_0779", Text = "{#Emph}Oh{#Prev}, very wise!" },
		{ Cue = "/VO/Chronos_0780", Text = "Cleverly decided." },
		{ Cue = "/VO/Chronos_0702", Text = "Now if I may?" },
		{ Cue = "/VO/Chronos_0781", Text = "Now, if I may?" },
	},	
	{
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0204", Text = "Excellent." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
		{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0244", Text = "Very well..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0180", Text = "Set." },
	},
}