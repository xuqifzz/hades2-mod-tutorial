OverwriteTableKeys( WorldUpgradeData,
{
	-- Familiar Costumes
	DefaultFamiliarCostume =
	{
		DebugOnly = true,
		Icon = "CosmeticIcon_SwatchTeal",
		FlavorText = "Cosmetic_TentBlanket01_Flavor",

		GameStateRequirements =
		{
			-- None
		},
		Cost =
		{
			CosmeticsPoints = 50,
		},

		PostRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCostumeReactionVoiceLines" },
			{ GlobalVoiceLines = "PositiveReactionVoiceLines" },
		},
	},

	-- FrogFamiliar / Frinos
	FamiliarCostume_FrogDefault =
	{
		Icon = "Costume_Frog01",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "Frog_Mesh",
		AlwaysRevealImmediately = true,

		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarSwitchToDefaultCostumeVoiceLines" },
		},
	},

	FamiliarCostume_FrogChthonic =
	{
		Icon = "Costume_Frog02",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "FrogFamiliar_Chthonic_Mesh",

		Cost =
		{
			CosmeticsPoints = 900,
			MixerHBoss = 1,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarAngryCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_FrogCute =
	{
		Icon = "Costume_Frog04",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "FrogFamiliar_Cute_Mesh",

		Cost =
		{
			CosmeticsPoints = 1400,
			SuperGiftPoints = 2,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCuteCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_FrogMoon =
	{
		Icon = "Costume_Frog03",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "FrogFamiliar_Moon_Mesh",

		Cost =
		{
			CosmeticsPoints = 2200,
			CardUpgradePoints = 3,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarChillCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_FrogNightmare =
	{
		Icon = "Costume_Frog05",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "FrogFamiliar_Nightmare_Mesh",
		Outline =
		{
			R = 63,
			G = 216,
			B = 151,
			Alpha = 255,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		Cost =
		{
			CosmeticsPoints = 3400,
			WeaponPointsRare = 4,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarDarkCostumeUnlocked" },
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarFrogSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	-- CatFamiliar / Toula
	FamiliarCostume_CatDefault =
	{
		Icon = "Costume_Cat01",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "CatFamiliar_Mesh",
		AlwaysRevealImmediately = true,

		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarSwitchToDefaultCostumeVoiceLines" },
		},
	},

	FamiliarCostume_CatChthonic =
	{
		Icon = "Costume_Cat04",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "CatFamiliar_Chthonic_Mesh",

		Cost =
		{
			CosmeticsPoints = 700,
			Mixer6Common = 1,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCoolCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_CatHell =
	{
		Icon = "Costume_Cat02",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "CatFamiliar_Hell_Mesh",

		Cost =
		{
			CosmeticsPoints = 1300,
			MixerHBoss = 2,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarAngryCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_CatMoon =
	{
		Icon = "Costume_Cat03",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "CatFamiliar_Moon_Mesh",

		Cost =
		{
			CosmeticsPoints = 1900,
			CardUpgradePoints = 3,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarChillCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_CatNightmare =
	{
		Icon = "Costume_Cat05",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "CatFamiliar_Nightmare_Mesh",
		Outline =
		{
			R = 63,
			G = 216,
			B = 151,
			Alpha = 255,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		Cost =
		{
			CosmeticsPoints = 3100,
			WeaponPointsRare = 4,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarDarkCostumeUnlocked" },
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarCatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	-- RavenFamiliar / Raki
	FamiliarCostume_RavenDefault =
	{
		Icon = "Costume_Raven01",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "RavenFamiliar_Mesh",
		AlwaysRevealImmediately = true,

		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarSwitchToDefaultCostumeVoiceLines" },
		},
	},

	FamiliarCostume_RavenChthonic =
	{
		Icon = "Costume_Raven04",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "RavenFamiliar_Chthonic_Mesh",

		Cost =
		{
			CosmeticsPoints = 400,
			Mixer6Common = 1,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCoolCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_RavenCute =
	{
		Icon = "Costume_Raven02",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "RavenFamiliar_Cute_Mesh",

		Cost =
		{
			CosmeticsPoints = 1100,
			SuperGiftPoints = 2,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCuteCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_RavenMoon =
	{
		Icon = "Costume_Raven03",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "RavenFamiliar_Moon_Mesh",

		Cost =
		{
			CosmeticsPoints = 1500,
			CardUpgradePoints = 3,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarChillCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_RavenNightmare =
	{
		Icon = "Costume_Raven05",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "RavenFamiliar_Nightmare_Mesh",
		Outline =
		{
			R = 63,
			G = 216,
			B = 151,
			Alpha = 255,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		Cost =
		{
			CosmeticsPoints = 2700,
			WeaponPointsRare = 4,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarDarkCostumeUnlocked" },
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarRavenSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	-- HoundFamiliar / Hecuba
	FamiliarCostume_HoundDefault =
	{
		Icon = "Costume_Hound01",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "HoundFamiliar_Mesh",
		AlwaysRevealImmediately = true,

		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarSwitchToDefaultCostumeVoiceLines" },
		},
	},

	FamiliarCostume_HoundChaos =
	{
		Icon = "Costume_Hound04",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "HoundFamiliar_Chaos_Mesh",

		Cost =
		{
			CosmeticsPoints = 700,
			OreChaosProtoplasm = 1,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCoolCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_HoundHell =
	{
		Icon = "Costume_Hound02",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "HoundFamiliar_Hell_Mesh",

		Cost =
		{
			CosmeticsPoints = 1700,
			MixerHBoss = 2,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarAngryCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_HoundMoon =
	{
		Icon = "Costume_Hound03",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "HoundFamiliar_Moon_Mesh",

		Cost =
		{
			CosmeticsPoints = 2700,
			CardUpgradePoints = 3,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarChillCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_HoundNightmare =
	{
		Icon = "Costume_Hound05",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "HoundFamiliar_Nightmare_Mesh",
		Outline =
		{
			R = 63,
			G = 216,
			B = 151,
			Alpha = 255,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		Cost =
		{
			CosmeticsPoints = 3700,
			WeaponPointsRare = 4,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarDarkCostumeUnlocked" },
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarHoundSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	-- PolecatFamiliar / Gale
	FamiliarCostume_PolecatDefault =
	{
		Icon = "Costume_Polecat01",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "PolecatFamiliar_Mesh",
		AlwaysRevealImmediately = true,

		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarSwitchToDefaultCostumeVoiceLines" },
		},
	},

	FamiliarCostume_PolecatChthonic =
	{
		Icon = "Costume_Polecat04",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "PolecatFamiliar_Chthonic_Mesh",

		Cost =
		{
			CosmeticsPoints = 300,
			PlantIPoppy = 1,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCoolCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_PolecatCute =
	{
		Icon = "Costume_Polecat03",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "PolecatFamiliar_Cute_Mesh",

		Cost =
		{
			CosmeticsPoints = 600,
			SuperGiftPoints = 2,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarCuteCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_PolecatHell =
	{
		Icon = "Costume_Polecat02",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "PolecatFamiliar_Hell_Mesh",

		Cost =
		{
			CosmeticsPoints = 1200,
			MixerFBoss = 3,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarAngryCostumeUnlocked" },
			{ GlobalVoiceLines = "FamiliarMiscCostumeUnlocked" }
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

	FamiliarCostume_PolecatNightmare =
	{
		Icon = "Costume_Polecat05",
		InheritFrom = { "DefaultFamiliarCostume" },
		GrannyModel = "PolecatFamiliar_Nightmare_Mesh",
		Outline =
		{
			R = 63,
			G = 216,
			B = 151,
			Alpha = 255,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		Cost =
		{
			CosmeticsPoints = 3500,
			WeaponPointsRare = 4,
		},

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarDarkCostumeUnlocked" },
		},
		SwitchCostumeVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarPolecatSwitchCostumeVoiceLines" },
			{ GlobalVoiceLines = "FamiliarMiscSwitchCostumeVoiceLines" },
		},
	},

})

ScreenData.FamiliarCostumeShop =
{
	BlockPause = true,

	ItemCategories =
	{
		FrogFamiliar =
		{
			"FamiliarCostume_FrogDefault",
			"FamiliarCostume_FrogChthonic",
			"FamiliarCostume_FrogCute",
			"FamiliarCostume_FrogMoon",
			"FamiliarCostume_FrogNightmare",
		},

		CatFamiliar =
		{
			"FamiliarCostume_CatDefault",
			"FamiliarCostume_CatChthonic",
			"FamiliarCostume_CatHell",
			"FamiliarCostume_CatMoon",
			"FamiliarCostume_CatNightmare",
		},


		RavenFamiliar =
		{
			"FamiliarCostume_RavenDefault",
			"FamiliarCostume_RavenChthonic",
			"FamiliarCostume_RavenCute",
			"FamiliarCostume_RavenMoon",
			"FamiliarCostume_RavenNightmare",
		},

		HoundFamiliar =
		{
			"FamiliarCostume_HoundDefault",
			"FamiliarCostume_HoundChaos",
			"FamiliarCostume_HoundHell",
			"FamiliarCostume_HoundMoon",
			"FamiliarCostume_HoundNightmare",
		},

		PolecatFamiliar =
		{
			"FamiliarCostume_PolecatDefault",
			"FamiliarCostume_PolecatChthonic",
			"FamiliarCostume_PolecatCute",
			"FamiliarCostume_PolecatHell",
			"FamiliarCostume_PolecatNightmare",
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

	ItemStartX = 515,
	ItemStartY = 230,
	ItemSpacingY = 110,
	IconOffsetX = -388,
	IconOffsetY = -1,
	IconScale = 0.7,
	ItemsPerPage = 5,
	FreeFormSelectOffsetX = -470,

	ResourceSpendTextOffsetY = 11,

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

	ItemStateFormat =
	{
		OffsetX = 310,
		OffsetY = 0,
		FontSize = 28,
		Color = Color.White,
		Font = "LatoBold",
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 200,

	Components = {},

	TooltipX = 1690,
	TooltipY = 870,

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
	},

	ItemAvailableAnimation = "GhostAdminScreenCauldronButton",
	ItemAvailableMouseOverAnimation = "GhostAdminScreenCauldronButtonIn",
	ItemAvailableMouseOffAnimation = "GhostAdminScreenCauldronButtonOut",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"FamiliarShopBacking",
			"FamiliarShopAnimalBacking",
			"InfoBoxBacking",
			"ActionBarBackground",
			"ResourceCostBacking",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
			Y = ScreenCenterY,
			UseNativeScreenCenter = true,
			Color = { 1.0, 1.0, 1.0, 0.8 },
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

		FamiliarShopBacking =
		{
			AnimationName = "FamiliarShopBackdrop",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		FamiliarShopAnimalBacking =
		{
			X = ScreenCenterX + 540,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		InfoBoxBacking = 
		{
			AnimationName = "GUI\\Screens\\MusicPlayer\\Backing_Scroll",
			X = 1165,
			Y = 840,
			Alpha = 0.0,
			Children = 
			{
				InfoBoxDescription =
				{
					OffsetX = -300,
					OffsetY = -35,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.Black,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraftDark",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 610,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 5,
						TextSymbolScale = 0.8,
					}
				},
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
					Text = "Menu_FamiliarCostumeUnlock",
					TextArgs = UIData.ContextualButtonFormatRight,
					AltText = "Menu_FamiliarCostumeReAdd",
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseFamiliarCostumeScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			}
		}
	},

	AngleHeroTowardTarget = true,
	-- OpenPlayerAnimation = "MelTalkBrooding01",
	-- handled in GhostAdminScreenClosedPresentation()
	-- ClosePlayerAnimation = "MelTalkBrooding01ReturnToIdle",
	OpenSound = "/SFX/Menu Sounds/RunHistoryOpen",
	CloseSound = "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage",

	OpenEndVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.5,
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
				{ Name = "MelFamiliarCostumesMenuOpenedSpeech", Time = 20 }
			},

			{ Cue = "/VO/Melinoe_5399", Text = "Is it time for a new look?" },
			{ Cue = "/VO/Melinoe_5400", Text = "Appearances can be deceiving." },
			{ Cue = "/VO/Melinoe_5401", Text = "How about a change of style?" },
			{ Cue = "/VO/Melinoe_5402", Text = "In the mood for something different?" },
			{ Cue = "/VO/Melinoe_5403", Text = "Time for a change?" },
			{ Cue = "/VO/Melinoe_5404", Text = "Want to try something different?" },
			{ Cue = "/VO/Melinoe_5405", Text = "Alteration of Familiar Forms...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_5406", Text = "How do you see yourself tonight?" },
			{ Cue = "/VO/Melinoe_5407", Text = "Up for a little makeover?" },
		}
	}


}