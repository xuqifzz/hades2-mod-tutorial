OverwriteTableKeys( WorldUpgradeData,
{
	-- alchemy / cooking recipes
	WorldUpgradeMixerShadow =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_MixerShadow",
		Cost =
		{
			--MetaCurrency = 50,
			MetaFabric = 3,
			MetaCardPointsCommon = 30,
			MemPointsCommon = 30,
		},
		CookTime = 12,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "MixerShadow", ResourceAmount = 1, WaitTime = 0.4, SoundName = "/Leftovers/Menu Sounds/TitanToggleLong" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			NamedRequirements = { "AlchemyUnlocked" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_2609", Text = "I need pure Shadow to permeate the surface wards... so what if...?" },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_2612", Text = "{#Emph}Essences of Shadow, to the surface rise." },
			},
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeFamiliarPoints =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_FamiliarPoints",
		Cost =
		{
			PlantGLotus = 2,
			Mixer5Common = 1,
		},
		CookTime = 14,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 2, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" }
			},
			{
				Path = { "GameState", "FamiliarStatus" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_3144", Text = "With this Star Dust I could form an immutable bond with a beast that has affinity for me..." }
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeCardUpgradePoints =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_CardUpgradePoints",
		Cost =
		{
			MixerFBoss = 1,
			MixerShadow = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
			},
		},
		CookTime = 8,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 5, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeCardUpgradePoints2 =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_CardUpgradePoints",
		Cost =
		{
			Mixer5Common = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "FamiliarPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
				Comparison = ">=",
				Value = 2,
			},
			{
				PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
			},
		},
		CookTime = 4,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 3, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeNectar =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_Nectar",
		Cost =
		{
			MixerOBoss = 1,
		},
		CookTime = 8,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "GiftPoints", ResourceAmount = 3, SoundName = "/SFX/GiftAmbrosiaBottlePickup" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNectar01", },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_1082", Text = "{#Emph}Come savor, unrivaled from heights of Olympus, to depths of the sea!" }
			},
		},
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},	
	-- Repeatable Spells
	WorldUpgradeCosmeticsPointsCommon =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_CosmeticsCommon",
		Cost =
		{
			PlantFNightshade = 1,
		},
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CosmeticsPointsCommon", ResourceAmount = 100, SoundName = "/Leftovers/World Sounds/LeavesRustle" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
		},

		RevealReactionGlobalVoiceLines = "ResourceTransmutationVoiceLines",
	},
	WorldUpgradeCosmeticsPointsRare =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_CosmeticsRare",
		Cost =
		{
			OreNBronze = 1,
		},
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CosmeticsPointsRare", ResourceAmount = 50, SoundName = "/SFX/CrystalPieceBreak" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
		},

		RevealReactionGlobalVoiceLines = "ResourceTransmutationVoiceLines",
	},
	WorldUpgradeCosmeticsPointsEpic =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_CosmeticsEpic",
		Cost =
		{
			MixerFBoss = 1,
		},
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CosmeticsPointsEpic", ResourceAmount = 25, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
		},

		RevealReactionGlobalVoiceLines = "ResourceTransmutationVoiceLines",
	},
})