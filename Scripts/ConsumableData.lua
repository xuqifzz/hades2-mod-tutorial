Import "ResourceData.lua"

ConsumableData =
{
	BaseConsumable =
	{
		UsePromptOffsetX = 65,
		UsePromptOffsetY = 0,
		DebugOnly = true,
		CanDuplicate = true,
	},
	BaseMetaRoomReward = 
	{
		GoldConversionEligible = true,
		GoldifyValue = 200,
		MetaConversionEligible = true,
		UseTextTalkAndGift = "UseOrConvertConsumable",
		UseTextTalkAndSpecial = "UseOrGoldifyResourcePickup",
		UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickup",
	},
	BaseResource =
	{
		InheritFrom = { "BaseConsumable" },
		UseText = "UseResourcePickup",
		PurchaseText = "BuyResourcePickup",
		PlayInteract = true,
		SpawnSound = "/SFX/KeyDrop",
		ConsumeSound = "/SFX/KeyPickup",
		ConsumeFx = "ItemConsumeFx",
		BlockExitText = "ExitBlockedByMetaPoint",
	},
	BaseSuperResource =
	{
		InheritFrom = { "BaseResource" },
		CanDuplicate = false,
		ConsumeFx = "ItemConsumeFxSuper",
	},
	BaseWellShopConsumable =
	{
		InheritFrom = { "BaseConsumable" },
		NoFrame = true,
		InfoBackingAnimation = "ShopSlotBase",
		--CanDuplicate = false,
	},
	Tier1Consumable =
	{
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.00,
				MaxMultiplier = 1.00,
			},
			Rare =
			{
				MinMultiplier = 1.3,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.5,
			}
		}
	},

	-- Consumable / Instants
	HealDrop =
	{
		InheritFrom = { "BaseConsumable" },
		Cost = 30,
		HealFixed = 25,
		UseText = "UseHealDrop",
		OnUsedFunctionName = "UseConsumableItem",
		PurchaseText = "Shop_UseHealDrop",
		HideWorldText = true,
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
	},
	HealDropMinor =
	{
		InheritFrom = { "HealDrop" },
		HealFixed = 10,
		CanDuplicate = false,
		BlockPurchasedVoiceLines = true,
	},
	HealDropSuperMinor =
	{
		InheritFrom = { "HealDrop" },
		HealFixed = 1,
		BlockPurchasedVoiceLines = true,
	},
	HealDropMajor =
	{
		InheritFrom = { "HealDrop" },
		UseText = "UseHealDropMajor",
		Cost = 65,
		HealFixed = 50,
		ExtractValues =
		{
			{
				Key = "HealFixed",
				ExtractAs = "TooltipHeal",
				Format = "FlatHeal"
			},
		},
	},
	RoomRewardHealDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UsePromptOffsetY = 30,
		ResourceCosts =
		{
			Money = 50,
		},
		SurfaceShopText = "RoomRewardHealDrop_Store",
		SurfaceShopIcon = "RoomRewardHealShop",
		HealFraction = 0.4,
		UseText = "UseHealDrop",
		ConsumeFx = "HealConsumableFx",
		OnUsedFunctionName = "UseConsumableItem",
		PurchaseText = "Shop_UseHealDrop",
		NeverForceRequired = true,
		PurchaseRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = "<", Value = 1.0, },
			},
		},
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		BlockExitText = "ExitBlockedByHeal",
		PlayInteract = true,
		HideWorldText = true,
		SpawnSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",

		OnSpawnVoiceLines =
		{

		},
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
	},
	HealBigDrop =
	{
		InheritFrom = { "RoomRewardHealDrop", },
		SurfaceShopText = "RoomRewardBigHealDrop_Store",
		SurfaceShopIcon = "HealBigShop",
		HealFraction = 0.6,
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		ResourceCosts =
		{
			Money = 90,
		},
	},
	RoomRewardConsolationPrize =
	{
		InheritFrom = { "BaseConsumable", },
		UsePromptOffsetY = 30,
		Cost =
		{
			BaseValue = 10,
			DepthMult = 0,
			AsInt = true,
		},
		HealFixed = 1,
		UseText = "UseHealDrop",
		
		UseTextTalkAndSpecial = "UseOrGoldifyHealDrop",
		GoldConversionEligible = true,
		GoldifyValue = 150,

		PurchaseText = "Shop_UseHealDrop",
		ExtractValues =
		{
			{
				Key = "HealFixed",
				ExtractAs = "TooltipHeal",
			},
		},
		BlockExitText = "ExitBlockedByHeal",
		PlayInteract = true,
		HideWorldText = true,
		SpawnSound = "/SFX/CrappyRewardDrop",
		ConsumeSound = "/SFX/CrappyRewardPickup",
		Icon = "ConsolationPrize",
		ConsumeFx = "ItemConsumeFx",

		OnSpawnVoiceLines =
		{

		},
		ConsumedVoiceLines =
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,
			Cooldowns =
			{
				{ Name = "LostToNemesisSpeech", Time = 3 },
			},

			{ Cue = "/VO/MelinoeField_0282", Text = "Onion...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0283", Text = "My favorite..." },
			{ Cue = "/VO/MelinoeField_0284", Text = "Crunchy...!" },
			{ Cue = "/VO/MelinoeField_0285", Text = "It's something..." },
		},
		BlockPurchasedVoiceLines = true,
	},

	BloodDrop =
	{
		InheritFrom = { "BaseConsumable" },
		CanDuplicate = false,
		OnUsedFunctionName = "UseConsumableItem",
		UseFunctionName = "BloodDropUse",
		ConsumeSound = "/Leftovers/SFX/AuraOff",
		SpeedBonus = 0.01,
		SpeedBonusDisplay = 1,	-- For display only, update to match SpeedBonus as percent
		SpawnCap = 10,
		HideWorldText = true,
		BlockPurchasedVoiceLines = true,
		DropArgs = 
		{
			Duration = 10,
			UpwardForceMin = 600,
			UpwardForceMax = 800,
			ForceMin = 600,
			ForceMax = 850,
			Sound = "/Leftovers/Menu Sounds/CoinFlash",
			ExpireFx = "AresBloodDropletDissipate",
		}
	},

	ManaDropMinor =
	{
		InheritFrom = { "BaseConsumable" },
		CanDuplicate = false,
		AddMana = 20,
		ConsumeSound = "/Leftovers/SFX/AuraOff",
		-- ConsumeFx = "ManaSparkleShower",
		HideWorldText = true,
		BlockPurchasedVoiceLines = true,
	},
	ManaDropMinorPoseidon =
	{
		InheritFrom = { "ManaDropMinor" },
		UseFunctionName = "ManaDropUsePresentation",
		AddMana = 20,
	},
	ManaDropMinorHound =
	{
		InheritFrom = { "ManaDropMinor" },
		UseFunctionName = "ManaDropUsePresentation",
		AddMana = 100,
	},
	ManaDropZeus =
	{
		InheritFrom = { "ManaDropMinor" },
		OnUsedFunctionName = "ZeusManaPickup",
		SpawnSound = "/SFX/Menu Sounds/KeepsakeZeusRing",

		UseText = "UseManaFountain",
		UseSound = "/SFX/Player Sounds/ZeusLightningShieldRush",
		OnUsedFunctionArgs = 
		{
			InputLockDuration = 0.3,
		}
	},
	PowerDrinkDrop =
	{
		InheritFrom = { "BaseConsumable" },
		CanDuplicate = false,
		ConsumeSound = "/SFX/PoisonCureFountainDrink2",
		HideWorldText = true,
		BlockPurchasedVoiceLines = true,
		OnUsedFunctionName = "DrinkPickup",
		SpawnSound = "/SFX/Menu Sounds/KeepsakeDionysusCup",

		UseText = "UsePowerDrop",
		UseSound = "/Leftovers/SFX/StaminaRefilled",
		OnUsedFunctionArgs = 
		{
			InputLockDuration = 0.3,
		},

		OnUsedGlobalVoiceLines = "UsedPowerDrinkVoiceLines",
	},
	RoomMoneyDrop =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 100,
		},
		DoorIcon = "MoneyDropPreview",
		TradeIcon = "MoneyDropPreview",
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/SFX/GoldCoinRewardUse",
		UseText = "UseMoneyDrop",
		BlockExitText = "ExitBlockedByMoney",
		PlayInteract = true,
		HideWorldText = true,
		CanDuplicate = true,
		LastRewardEligible = true,
		EchoLastRewardId = "EchoLastReward_MoneyDrop",
		ExitUnlockDelay = 0.6,

		DropMoneyPickupDelay = 0.3,
		DropMoney = 100,
		OnSpawnVoiceLines =
		{
			PreLineWait = 0.55,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_1288", Text = "Golden coins...", ChanceToPlayAgain = 0.01 },
		},

		OnUsedGlobalVoiceLines = "UsedMoneyDropVoiceLines",
	},
	RoomMoneyBigDrop =
	{
		InheritFrom = { "RoomMoneyDrop", },
		DoorIcon = "RoomMoneyBigDropPreview",
		Icon = "MoneyDropCoin",
		ResourceCosts =
		{
			Money = 200,
		},
		DropMoney = 200,
		OnSpawnVoiceLines =	{},
	},
	RoomMoneyTripleDrop =
	{
		InheritFrom = { "RoomMoneyDrop", },
		DoorIcon = "RoomMoneyTripleDropPreview",
		Icon = "RoomMoneyTripleDropPreview",
		ResourceCosts =
		{
			Money = 300,
		},
		DropMoney = 300,
		OnSpawnVoiceLines =	{},
	},
	RoomMoneySmallDrop =
	{
		InheritFrom = { "RoomMoneyDrop", },
		ResourceCosts =
		{
			Money = 50,
		},
		DropMoney = 50,
		OnSpawnVoiceLines =	{},
	},
	RoomMoneyTinyDrop =
	{
		InheritFrom = { "RoomMoneyDrop", },
		ResourceCosts =
		{
			Money = 20,
		},
		DropMoney = 20,
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/MakingMoneyChaChing",
		OnSpawnVoiceLines =	{},
		OnUsedGlobalVoiceLines = {},
	},
	MedeaMoneyTinyDrop =
	{
		InheritFrom = { "RoomMoneyTinyDrop", },
		CanDuplicate = false,
		LastRewardEligible = false,
		PlayInteract = false,
	},

	LobAmmoPack =
	{
		InheritFrom = { "BaseConsumable" },
		OnUsedFunctionName = "UseConsumableItem",
		CanDuplicate = false,
		Cost = 0,
		AddAmmoWeapon = "WeaponLob",
		AddAmmo = 1,
		HideWorldText = true,
		CannotUseText = "AmmoPackCannotUse",
		CannotUseSound = "/Leftovers/SFX/OutOfAmmo",
		ConsumeSound = "/SFX/Player Sounds/MelSkullsAmmoPickup",

		CompleteObjective = "WeaponLobPickup",

		MagnetismEscalateDelay = 10.0,
		MagnetismHintRemainingTime = 5.0,
		MagnetismEscalateAmount = 99000,

		SkipCheckRoomExitsReady = true,
	},

	-- Trait boosts
	MaxHealthDrop =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 125,
		},
		SurfaceShopText = "MaxHealthDrop_Store",
		SurfaceShopIcon = "RoomRewardMaxHealthDropShop",
		DoorIcon = "RoomRewardMaxHealthDropShop",
		AddMaxHealth = 25,
		UseText = "UseMaxHealthDrop",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseMaxHealthDrop",
		BlockExitText = "ExitBlockedByHeal",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/HealthIncreasePickup",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		HideWorldText = true,
		CanDuplicate = true,
		LastRewardEligible = true,

		UseTextTalkAndSpecial = "UseOrGoldifyMaxHealthDrop",
		GoldConversionEligible = true,
		GoldifyValue = 300,

		OnSpawnVoiceLines =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore", "Shop" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},		
			},

			{ Cue = "/VO/Melinoe_0194", Text = "A Centaur Heart...", ChanceToPlayAgain = 0.02, PreLineWait = 0.6, },
		},

		ConsumedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "UsedHealDropVoiceLines" },
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	},
	MaxHealthDropSmall =
	{
		InheritFrom = { "MaxHealthDrop" },
		DoorIcon = "MaxHealthDropSmallPreview",
		AddMaxHealth = 5,
		GoldConversionEligible = true,
		GoldifyValue = 200,
	},
	MaxHealthDropBig =
	{
		InheritFrom = { "MaxHealthDrop" },
		DoorIcon = "MaxHealthDropBigPreview",
		AddMaxHealth = 50,
		ResourceCosts =
		{
			Money = 250,
		},
		GoldConversionEligible = true,
		GoldifyValue = 400,
	},
	EmptyMaxHealthDrop = 
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEmptyMaxHealthDrop",
		UsePromptOffsetY = 30,
		DoorIcon = "EmptyMaxHealthPreview",
		PurchaseText = "Shop_UseEmptyMaxHealthDrop",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/HealthIncreasePickup",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		HideWorldText = true,

		UseTextTalkAndSpecial = "UseOrGoldifyEmptyMaxHealthDrop",
		GoldConversionEligible = true,
		GoldifyValue = 200,

		Cost =
		{
			BaseValue = 100,
			DepthMult = 0,
			AsInt = true,
		},
		AddMaxHealth = 25,
		AddMaxHealthArgs =
		{
			Thread = true,
			Delay = 0.5,
			NoHealing = true,
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	},
	EmptyMaxHealthSmallDrop = 
	{
		InheritFrom = { "EmptyMaxHealthDrop", },
		GoldifyValue = 150,
		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		AddMaxHealth = 10,
		AddMaxHealthArgs =
		{
			Thread = true,
			Delay = 0.5,
			NoHealing = true,
		},
	},

	MaxManaDrop =
	{
		InheritFrom = { "BaseConsumable", },
		DoorIcon = "MaxManaDrop_Preview",
		SurfaceShopText = "MaxManaDrop_Store",
		SurfaceShopIcon = "MaxManaDrop",
		ResourceCosts =
		{
			Money = 100,
		},
		AddMaxMana = 30,
		UseText = "UseMaxManaDrop",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseMaxManaDrop",
		BlockExitText = "ExitBlockedByHeal",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/MaxManaDrop",
		OnConsumedGlobalVoiceLines = "UsedManaDropVoiceLines",
		PlayInteract = true,
		HideWorldText = true,
		CanDuplicate = true,
		LastRewardEligible = true,
		ConsumeFx = "ItemConsumeFx",
		
		UseTextTalkAndSpecial = "UseOrGoldifyMaxManaDrop",
		GoldConversionEligible = true,
		GoldifyValue = 300,

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ChanceToPlayAgain = 0.02,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1536", Text = "Soul Tonic..." },
			{ Cue = "/VO/MelinoeField_1537", Text = "A Soul Tonic.", PlayFirst = true },
		},

		ExtractValues =
		{
			{
				Key = "AddMaxMana",
				ExtractAs = "TooltipMaxMana",
				Format = "MaxMana",
			},
		}
	},

	MaxManaDropSmall = 
	{
		InheritFrom = { "MaxManaDrop", },
		DoorIcon = "MaxManaDropSmall_Preview",
		AddMaxMana = 10,

		GoldConversionEligible = true,
		GoldifyValue = 200,
	},

	MaxManaDropBig = 
	{
		InheritFrom = { "MaxManaDrop", },
		DoorIcon = "MaxManaDropBig_Preview",
		AddMaxMana = 60,

		GoldConversionEligible = true,
		GoldifyValue = 400,
		ResourceCosts =
		{
			Money = 200,
		},
	},

	TalentDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		GenusName = "SpellDrop",
		SurfaceShopText = "TalentDrop_Store",
		SurfaceShopIcon = "TalentDropPreview",
		DoorIcon = "TalentDropPreview",
		TradeIcon = "TalentDropTrade",
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/SFX/GoldCoinRewardUse",
		UseText = "UseTalentDrop",
		BlockedLootInteractionText = "UseTalentDropLocked",
		BlockExitText = "ExitBlockedByMoney",
		HideWorldText = true,
		LastRewardEligible = true,
		ExitUnlockDelay = 1.1,
		SpeakerName = "Selene",
		LoadPackages = { "Selene", },
		UseFunctionName = "OpenTalentScreen",
		RerollColor = Color.White,
		AddTalentPoints = 3,
		EnemiesBlockInteraction = true,

		GoldConversionEligible = true,
		GoldifyValue = 300,

		ResourceCosts =
		{
			Money = 60,
		},
		FlavorTextIds =
		{
			"TalentDrop_FlavorText01",
			"TalentDrop_FlavorText02",
			"TalentDrop_FlavorText03",
		},
		GameStateRequirements =
		{
			NamedRequirements = { "TalentLegal" },
		},

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ChanceToPlayAgain = 0.02,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1474", Text = "The Path of Stars..." },
			{ Cue = "/VO/MelinoeField_2380", Text = "The Path of Stars...", PlayFirst = true },
			-- { Cue = "/VO/Melinoe_0192", Text = "A Star Drop...", ChanceToPlayAgain = 0.01, PreLineWait = 0.65, },
		},
	},

	MinorTalentDrop = 
	{
		InheritFrom = { "TalentDrop" },
		DoorIcon = "MinorTalentDropPreview",
		AddTalentPoints = 1,

		GoldConversionEligible = true,
		GoldifyValue = 200,
	},

	TalentBigDrop =
	{
		InheritFrom = { "TalentDrop" },
		AddTalentPoints = 5,

		GoldConversionEligible = true,
		GoldifyValue = 400,

	},

	StoreRewardRandomStack = 
	{
		InheritFrom = { "BaseConsumable", },
		DoorIcon = "RandomStackPreview",
		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		ConsumeSound = "/SFX/PomegranatePowerUpDrop",
		ConsumeFx = "ItemConsumeFx",
		UseFunctionName =  "UseStoreRewardRandomStack",
		UseFunctionArgs = { Thread = true, NumTraits = 1, NumStacks = 1, Delay = 0.25 },
		UseText = "UseRewardRandomStack",
		PurchaseText = "UseStoreRewardRandomStack",
		HideWorldText = true,
		PlayInteract = true,

		OnPurchaseGlobalVoiceLines = "PurchasedRandomPomVoiceLines",
	},

	RerollDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseRerollDrop",
		PurchaseText = "Shop_UseRerollDrop",

		GameStateRequirements =
		{
			NamedRequirements = { "RerollAvailable" },
		},

		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ConsumeFx = "ItemConsumeFx",
		PlayInteract = true,
		Cost =
		{
			BaseValue = 100,
			DepthMult = 0,
			AsInt = true,
		},
		AddRerolls = 1,
	},

	LastStandDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseLastStandDrop",
		UsePromptOffsetY = 30,

		SurfaceShopText = "LastStandDrop_Store",
		SurfaceShopIcon = "Shop_Jug",
		PurchaseText = "Shop_UseLastStandDrop",
		SpawnSound = "/SFX/LastStandDropSFX",
		ConsumeSound = "/SFX/LastStandPickupSFX",
		ConsumeFx = "MaxHealthDropPickupFx",
		OnPurchaseGlobalVoiceLines = "PurchasedLastStandVoiceLines",
		OnConsumedGlobalVoiceLines = "UsedLastStandDropVoiceLines",
		PlayInteract = true,
		HideWorldText = true,
		NeverForceRequired = true,

		GoldConversionEligible = true,
		UseTextTalkAndSpecial = "UseOrGoldifyLastStandDrop",
		GoldifyValue = 400,

		ResourceCosts =
		{
			Money = 200,
		},
		GameStateRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
		},
		PurchaseRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
		},
		UseFunctionNames =  { "AddLastStand", "UseLastStandDropPresentation", } ,
		UseFunctionArgs =
		{
			{
				Icon = "ExtraLifeStyx",
				HealFraction = 0.5,
				ManaFraction = 0.5
			},
			{
				HeroFx = "LastStandFxBurst",
			},
		},
		ExtractValues =
		{
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Heal",
				Format = "Percent",
				ExtractAs = "LastStandHeal",
				SkipAutoExtract = true,
			},
		}
	},

	ArmorBoost =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseArmorDrop",
		UsePromptOffsetY = 30,
		DoorIcon = "ArmorBoostPreview",
		SurfaceShopText = "ArmorBoost_Store",
		SurfaceShopIcon = "ArmorBoostShop",
		PurchaseText = "Shop_UseArmorDrop",

		GoldConversionEligible = true,
		UseTextTalkAndSpecial = "UseOrGoldifyArmorDrop",
		GoldifyValue = 200,
		
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/SFX/ShieldAlliesSFX",
		ConsumeFx = "ItemConsumeFx",
		OnConsumedGlobalVoiceLines = "UsedShieldDropVoiceLines",
		PlayInteract = true,
		ResourceCosts =
		{
			Money = 40,
		},
		AddArmor = 20,
		AddArmorArgs =
		{
			Thread = true,
			Delay = 0.5,
			Silent = true,
		},
		ExtractValues =
		{
			{
				Key = "AddArmor",
				ExtractAs = "TooltipArmor",
			},
		},
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "F_Story01" },
			},
		},
	},

	ArmorBoostStore = 
	{
		InheritFrom = { "ArmorBoost", "BaseWellShopConsumable" },
		Icon = "Shop_ArmorBoost",
		BoonInfoIgnoreRequirements = true,
		AddArmorArgs =
		{
			Thread = true,
			Delay = 0.5,
			Silent = true,
		},
	},

	ArmorBigBoost =
	{
		InheritFrom = { "ArmorBoost", },
		SurfaceShopText = "ArmorBigBoost_Store",
		SurfaceShopIcon = "ArmorBigBoostShop",
		GoldifyValue = 200,
		ResourceCosts =
		{
			Money = 80,
		},
		AddArmor = 40,
	},

	FireBoost =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEssence",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseEssence",
		SpawnSound = "/SFX/FireBoostDrop",
		ConsumeSound = "/SFX/FireBoostPickup",
		ConsumeFx = "ItemConsumeFx",
		PlayInteract = true,

		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeElementalBoons" },
			},
		},

		ResourceCosts =
		{
			Money = 20,
		},

		ExtractValues = {},
		UseFunctionNames =  { "AddTraitToHero" } ,
		UseFunctionArgs =
		{
			{
				TraitName = "FireEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},

	AirBoost =
	{
		InheritFrom = { "FireBoost", },
		SpawnSound = "/SFX/AirBoostDrop",
		ConsumeSound = "/SFX/AirBoostPickup",
		UseFunctionArgs =
		{
			{
				TraitName = "AirEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},

	EarthBoost =
	{
		InheritFrom = { "FireBoost", },
		SpawnSound = "/SFX/EarthBoostDrop",
		ConsumeSound = "/SFX/EarthBoostPickup",
		UseFunctionArgs =
		{
			{
				TraitName = "EarthEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},

	WaterBoost =
	{
		InheritFrom = { "FireBoost", },
		SpawnSound = "/SFX/WaterBoostDrop",
		ConsumeSound = "/SFX/WaterBoostPickup",
		UseFunctionArgs =
		{
			{
				TraitName = "WaterEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},

	ElementalBoost =
	{
		InheritFrom = { "FireBoost", },
		SpawnSound = "/SFX/GemDropSFX",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		DoorIcon = "ElementalEssenceDrop_Preview",
		ResourceCosts =
		{
			Money = 70,
		},
		UseFunctionArgs =
		{
			{
				TraitName = "ElementalEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},

	-- Loot substitutes
	ChaosWeaponUpgrade = 
	{
		InheritFrom = { "BaseConsumable", },
		HideWorldText = true,
		CanDuplicate = false,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
				Comparison = ">=",
				Value = 1,
			},
		},		
		PurchaseRequirements =
		{
			{
				Path = { "CurrentRun", "LootTypeHistory", "WeaponUpgrade" },
				Comparison = ">=",
				Value = 1,
			},
		},
		CannotPurchaseCombatText = "ChaosAnvil_NeedsMore",
		CannotPurchaseVoiceLines = { GlobalVoiceLines = "InvalidResourceInteractionVoiceLines" },
		Cost =
		{
			BaseValue = 275,
			DepthMult = 0,
			AsInt = true,
		},

		UseFunctionName =  "ChaosHammerUpgrade",
		UseFunctionArgs = { NumTraits = 2, ReportValues = { ReportedNumTraits = "NumTraits" } },
		UseText = "UseChaosWeaponUpgrade",
		PurchaseText = "UseChaosWeaponUpgrade",

		ConsumeSound = "/SFX/AnvilOfFatesUse",
		OnPurchaseGlobalVoiceLines = "PurchasedChaosWeaponUpgradeVoiceLines",
		ExtractValues =
		{
			{
				Key = "ReportedNumTraits",
				ExtractAs = "Number",
			},
		}
	},

	RandomLoot =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 150,
		},
		UseText = "UsePurchaseLoot",
		UseFunctionName = "GiveLoot",
		CanDuplicate = false,
	},

	BoostedRandomLoot =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 450,
		},
		CanDuplicate = false,
	},

	BlindBoxLoot = 
	{
		InheritFrom = { "BaseConsumable", },
		SurfaceShopIcon = "BlindBoxLootShop",
		BlockExitText = "ExitBlockedByBoon",
		ResourceCosts =
		{
			Money = 125,
		},
		GameStateRequirements = 
		{
			NamedRequirements = { "BlindBoxLootRequirements" },
		},
		UseText = "UseLoot",
		PurchaseText = "UseBlindBox",
		ReplaceWithRandomLoot = true,
		HideWorldText = true,
		BlockPurchasedVoiceLines = true,
		CanDuplicate = false,
		ScreenNameOnUse = UIData.BoonMenuId,
	},

	WeaponUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		GameStateRequirements = 
		{
			NamedRequirements = { "HammerLootRequirements" },
		},
		ResourceCosts =
		{
			Money = 200,
		},
		UseText = "UseWeaponUpgrade",
		UseFunctionName = "CreateWeaponLoot",
		SurfaceShopText = "WeaponUpgradeDrop_Store",
		SurfaceShopIcon = "WeaponUpgradeShop",
	},

	ShopHermesUpgrade =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 150,
		},
		UseText = "UsePurchaseLoot",
		UseFunctionName = "CreateHermesLoot",
		SurfaceShopText = "HermesUpgrade_Store",
		SurfaceShopIcon = "HermesUpgradeShop",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
			},
			{
				Path = { "CurrentRun", "BiomeUseRecord", },
				HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
			},
			{
				Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
				Comparison = "<=",
				Value = 1,
			},
		}
	},

	-- Well Shop
	HealDropRange =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		Icon = "Shop_Vase",
		HealCostPerPercent = 1,
		HealFraction =
		{
			BaseMin = 0.21,
			BaseMax = 0.39,
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		HideWorldText = true,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY",
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
		},
	},

	LastStandShopItem =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		ConsumeSound = "/EmptyCue",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		OnPurchaseGlobalVoiceLines = "PurchasedLastStandVoiceLines",
		CannotPurchaseVoiceLines = { GlobalVoiceLines = "FrustratedVoiceLines" },
		Icon = "Shop_Jug",
		ResourceCosts =
		{
			Money = 200,
		},
		
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
		},
		PurchaseRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
		},
		UseFunctionNames =  { "AddLastStand", "GainLastStandPresentation"} ,
		UseFunctionArgs =
		{
			{
				Name = "ShopItem",
				Icon = "ExtraLifeStyx",
				HealFraction = 0.4,
				ManaFraction = 0.4
			},
		},
		ExtractValues =
		{
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Heal",
				Format = "Percent",
				ExtractAs = "LastStandHeal",
				SkipAutoExtract = true,
			},
		}
	},

	LimitedManaRegenDrop = 
	{
		InheritFrom = { "BaseWellShopConsumable", },
		Icon = "Shop_LimitedManaRegenDrop",
		ResourceCosts =
		{
			Money = 10,
		},
		UseFunctionName = "AddLimitedManaRegen",
		UseFunctionArgs =
		{
			Amount = 500,
			Duration = 3,
			ReportValues = 
			{
				ReportedAmount = "Amount",
				ReportedDuration = "Duration",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedAmount",
				ExtractAs = "TooltipManaRecovery",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				DecimalPlaces = 1,
			},
		}
	},

	LimitedSwapTraitDrop = 
	{
		InheritFrom = { "BaseWellShopConsumable", },
		Icon = "Shop_LimitedSwapTraitDrop",
		ResourceCosts =
		{
			Money = 25,
		},
		UseFunctionName = "AddLimitedSwapTrait",
		UseFunctionArgs =
		{
			Amount = 1
		},
	},

	DamageSelfDrop = 
	{
		InheritFrom = { "BaseWellShopConsumable", },
		Icon = "Shop_Gold_Blood",
		HideWorldText = true,
		PayoutPerHealthPoint = { BaseMin = 1.1, BaseMax = 1.8 },
		NotEnoughCurrencyVoiceLines = HeroVoiceLines.NotEnoughHealthVoiceLines,
		DropMoneyDelay = 0,
		Cost = 0,
		HealthCost =
		{
			BaseMin = 10,
			BaseMax = 30,
			AsInt = true,
		},
		UseText = "UsePurchaseLoot",

		OnPurchaseSound = "/SFX/StabSplatterSmall",
		OnPurchaseGlobalVoiceLines = "PurchasedDamageSelfDropVoicelines",

		ExtractValues =
		{
			{
				Key = "HealthCost",
				ExtractAs = "TooltipHealthCost",
			},
		}
	},
	EmptyMaxHealthShopItem = 
	{
		InheritFrom = { "BaseWellShopConsumable", },
		Icon = "Shop_Soul",
		
		ResourceCosts =
		{
			Money = 110,
		},
		AddMaxHealth = 25,
		AddMaxHealthArgs =
		{
			Thread = true,
			Delay = 0.5,
			NoHealing = true,
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	},
	MetaCurrencyRange =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		Icon = "Shop_MetaCurrencyRange",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerMetaCurrency = 2,
		AddResources =
		{
			MetaCurrency =
			{
				BaseMin = 20,
				BaseMax = 40,
				AsInt = true,
			},
		},
		UseText = "UseTakeItem",
	},

	MetaCardPointsCommonRange =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		Icon = "Shop_MetaCardPointsCommonRange",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerMetaCardPointsCommon = 5,
		AddResources =
		{
			MetaCardPointsCommon =
			{
				BaseMin = 6,
				BaseMax = 12,
				AsInt = true,
			},
		},
		UseText = "UseTakeItem",
	},
	MemPointsCommonRange =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolExorcismBook" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 300,
			},
		},
		BoonInfoIgnoreRequirements = true,

		Icon = "Shop_MemPointsCommonRange",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerMemPointsCommon = 1,
		AddResources =
		{
			MemPointsCommon =
			{
				BaseMin = 20,
				BaseMax = 30,
				AsInt = true,
			},
		},
		UseText = "UseTakeItem",
	},
	SeedMysteryRange =
	{
		InheritFrom = { "BaseWellShopConsumable" },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolShovel" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
				Comparison = ">=",
				Value = 3,
			},
		},
		BoonInfoIgnoreRequirements = true,

		Icon = "Shop_SeedMysteryRange",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerSeedMystery = 15,
		AddResources =
		{
			SeedMystery =
			{
				BaseMin = 2,
				BaseMax = 2,
				AsInt = true,
			},
		},
		Text = "UseTakeItem",
	},
	SeedMysteryDrop =
	{
		InheritFrom = { "BaseResource", },
		UseText = "UseResourcePickup",
		-- SpawnSound = "/SFX/SuperGemDropSFX",
		-- ConsumeSound = "/SFX/SuperGemPickup",
		AddResources =
		{
			SeedMystery = 1,
		},
	},
	RandomStoreItem = 
	{
		InheritFrom = { "BaseWellShopConsumable", },
		Icon = "Shop_Twist",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		HideWorldText = true,
		
		ResourceCosts =
		{
			Money = 45,
		},
		CloseScreen = true,
		UseFunctionName =  "AwardRandomStoreItem",
		UseFunctionArgs = 
		{
			Traits = 
			{
				"TemporaryImprovedSecondaryTrait",
				"TemporaryImprovedCastTrait",
				"TemporaryMoveSpeedTrait",
				"TemporaryBoonRarityTrait",
				"TemporaryImprovedExTrait",
				"TemporaryImprovedDefenseTrait",
				"TemporaryDiscountTrait",
				"TemporaryHealExpirationTrait",
				"TemporaryDoorHealTrait",
			},
			Consumables = 
			{
				"LastStandShopItem",
				"EmptyMaxHealthShopItem",
				"HealDropRange",
				"MetaCurrencyRange",
				"MetaCardPointsCommonRange",
				"MemPointsCommonRange",
				"SeedMysteryRange",
			},
		},
		UseText = "UsePurchaseLoot",
	},

	-- Resources
	MetaCardPointsCommonDrop =
	{
		InheritFrom = { "BaseResource", "BaseMetaRoomReward" },
		SpawnSound = "/SFX/AshRewardPickup",
		ConsumeSound = "/SFX/AshRewardDrop",
		SurfaceShopText = "MetaCardPointsCommon_Surface",
		SurfaceShopTraitText = "MetaCardPointsCommon_Surface_Trait",
		SurfaceShopIcon = "MetaCardPointsCommonShop",
		UseTextTalkAndGift = "UseOrConvertResourcePickup",
		UseTextTalkAndSpecial = "UseOrGoldifyResourcePickup",
		UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickup",
		GoldifyValue = 200,
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
		NPCDrop = false,
		ResourceCosts =
		{
			Money = 50,
		},
		Icon = "MetaCardPointsCommonDrop",
		IconPath = ResourceData.MetaCardPointsCommon.IconPath,
		TextIconPath = ResourceData.MetaCardPointsCommon.TextIconPath,
		AddResources =
		{
			MetaCardPointsCommon = 5,
		},
		RunProgress =
		{
			ResourceIcon = "GUI\\Icons\\LifeUp",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeMetaCardPointsCommonRunProgress" },
				},
			},
			PropertyChanges =
			{
				AddMaxHealth = 5,
				AddMaxHealthArgs =
				{
					Thread = true,
					Delay = 0.25,
				},
				UseText = "UseResourcePickupRunProgress",
				UseTextTalkAndGift = "UseOrConvertResourcePickupRunProgress",
				UseTextTalkAndSpecial = "UseOrGoldifyResourcePickupRunProgress",
				UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickupRunProgress",
			},
		},
	},

	MetaCardPointsCommonBigDrop =
	{
		InheritFrom = { "MetaCardPointsCommonDrop" },
		ResourceCosts =
		{
			Money = 100,
		},
		Icon = "MetaCardPointsCommonBigDrop",
		AddResources =
		{
			MetaCardPointsCommon = 10,
		},
	},

	MemPointsCommonDrop =
	{
		InheritFrom = { "BaseResource", "BaseMetaRoomReward" },
		SpawnSound = "/SFX/Player Sounds/PsycheRewardDrop",
		ConsumeSound = "/SFX/Player Sounds/PsycheRewardPickup",
		SurfaceShopText = "MemPointsCommon_Surface",
		SurfaceShopTraitText = "MemPointsCommon_Surface_Trait",
		SurfaceShopIcon = "MemPointsCommonShop",
		UseTextTalkAndGift = "UseOrConvertResourcePickup",
		UseTextTalkAndSpecial = "UseOrGoldifyResourcePickup",
		UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickup",
		GoldifyValue = 200,
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
		NPCDrop = false,
		ResourceCosts =
		{
			Money = 50,
		},
		Icon = "MemPointsCommonDrop",
		IconPath = ResourceData.MemPointsCommon.IconPath,
		TextIconPath = ResourceData.MemPointsCommon.TextIconPath,
		AddResources =
		{
			MemPointsCommon = 10,
		},
	},

	MemPointsCommonBigDrop =
	{
		InheritFrom = { "MemPointsCommonDrop", },
		ResourceCosts =
		{
			Money = 100,
		},
		Icon = "MemPointsCommonBigDrop",
		AddResources =
		{
			MemPointsCommon = 20,
		},
	},

	MetaCurrencyDrop =
	{
		InheritFrom = { "BaseResource", "BaseMetaRoomReward" },
		DoorIcon = "MetaCurrencyDrop",
		SpawnSound = "/SFX/BoneRewardDrop",
		ConsumeSound = "/SFX/BoneRewardPickup",
		SurfaceShopText = "MetaCurrency_Surface",
		SurfaceShopTraitText = "MetaCurrency_Surface_Trait",
		SurfaceShopIcon = "MetaCurrencyDrop",
		UseTextTalkAndGift = "UseOrConvertResourcePickup",
		UseTextTalkAndSpecial = "UseOrGoldifyResourcePickup",
		UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickup",
		GoldifyValue = 200,
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
		NPCDrop = false,
		ResourceCosts =
		{
			Money = 90,
		},
		IconPath = ResourceData.MetaCurrency.IconPath,
		TextIconPath = ResourceData.MetaCurrency.TextIconPath,
		AddResources =
		{
			MetaCurrency = 50,
		},
		RunProgress =
		{
			ResourceIcon = "GUI\\Icons\\ManaUp",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeMetaCurrencyRunProgress" },
				},
			},
			PropertyChanges =
			{
				AddMaxMana = 5,
				AddMaxManaArgs =
				{
					Thread = true,
					Delay = 0.25,
				},
				UseText = "UseResourcePickupRunProgress",
				UseTextTalkAndGift = "UseOrConvertResourcePickupRunProgress",
				UseTextTalkAndSpecial = "UseOrGoldifyResourcePickupRunProgress",
				UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyResourcePickupRunProgress",
			},
		},
		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
				{ Cue = "/VO/Melinoe_3550", Text = "Always need Bones, just... not precisely now." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				PreLineWait = 0.55,
				GameStateRequirements =
				{
					-- for Chaos Trials
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" }
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "ErisResourceGranted", Time = 8 }
				},

				{ Cue = "/VO/Melinoe_1902", Text = "Some Bones for later use.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1905", Text = "These always come in handy." },
				{ Cue = "/VO/Melinoe_1330", Text = "Some Bones." },
				{ Cue = "/VO/Melinoe_1331", Text = "Bones for the Broker.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0696", Text = "I can use this for trade.", PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket", },
						},
					},
				},
			},
			{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
		},
	},

	MetaCurrencyBigDrop =
	{
		InheritFrom = { "MetaCurrencyDrop", },
		ResourceCosts =
		{
			Money = 180,
		},
		DoorIcon = "MetaCurrencyBigDrop",
		Icon = "MetaCurrencyBigDrop",
		AddResources =
		{
			MetaCurrency = 100,
		},
	},

	OreFSilverDrop =
	{
		InheritFrom = { "BaseResource", },
		SpawnSound = "/SFX/KeyDrop",
		ConsumeSound = "/SFX/KeyPickup",
		UseText = "UseResourcePickup",
		AddResources =
		{
			OreFSilver = 3,
		},
	},

	PlantFMolyDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			PlantFMoly = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/PomegranatePowerUpDrop",
		ConsumeSound = "/SFX/CrappyRewardPickup",
	},

	PlantFNightshadeDrop =
	{
		InheritFrom = { "BaseResource", },
		UseText = "UseResourcePickup",
		-- SpawnSound = "/SFX/SuperGemDropSFX",
		-- ConsumeSound = "/SFX/SuperGemPickup",
		AddResources =
		{
			PlantFNightshade = 1,
		},
	},

	PlantGLotusDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			PlantGLotus = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/PomegranatePowerUpDrop",
		ConsumeSound = "/SFX/CrappyRewardPickup",
	},

	MetaFabricDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			MetaFabric = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/AshRewardDrop",
		ConsumeSound = "/SFX/Menu Sounds/KeepsakeArachneSash",
	},

	GiftDrop =
	{
		InheritFrom = { "BaseResource", "BaseMetaRoomReward" },
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Elysium", "Styx", },
			},
		},
		SurfaceShopText = "GiftDrop_Surface",
		SurfaceShopIcon = "GiftDropPreview",
		ResourceCosts =
		{
			Money = 75,
		},
		AddResources =
		{
			GiftPoints = 1,
		},
		RunProgress =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGiftDropRunProgress" },
				},
			},
			PropertyChanges =
			{
				UseFunctionName =  "UseStoreRewardRandomStack",
				UseFunctionArgs = { Thread = true, NumTraits = 1, NumStacks = 1, Delay = 0.25 },
				UseText = "UseGiftPointDropRunProgress",
				UseTextTalkAndGift = "UseOrConvertGiftPointDropRunProgress",
				UseTextTalkAndSpecial = "UseOrGoldifyGiftPointDropRunProgress",
				UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyGiftPointDropRunProgress",
			},
		},
		UsePromptOffsetY = 30,
		UseText = "UseGiftPointDrop",
		UseTextTalkAndGift = "UseOrConvertGiftPointDrop",
		UseTextTalkAndSpecial = "UseOrGoldifyGiftPointDrop",
		UseTextTalkGiftAndSpecial = "UseConvertOrGoldifyGiftPointDrop",
		GoldifyValue = 200,
		PurchaseText = "Shop_UseGiftPointDrop",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/SFX/GiftAmbrosiaBottlePickup",
		ConsumeFx = "GiftDropPickup",
		PlayInteract = true,
		HideWorldText = true,
		LastRewardEligible = true,
		OnSpawnVoiceLines =
		{
			PlayOnce = true,
			PlayOnceContext = "NectarSpawnIntroVO",
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HealthRestore" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			{ Cue = "/VO/Melinoe_0794", Text = "Some Nectar.", PlayFirst = true, },
		},
	},
	TrashPointsDrop =
	{
		InheritFrom = { "BaseResource", },
		SpawnSound = "/SFX/CrappyRewardDrop",
		PickUpSound = "/SFX/TrashPickup", -- for HarvestPresentation
		ConsumeFx = "ItemConsumeFxSmall",
		ConsumeSound = "/SFX/TrashPickup",
		EmptyAnimation = "Blank",
		UseText = "UseTrashPoint",
		OnUsedFunctionName = "UseTrashPoint",
		AddResources =
		{
			TrashPoints = 1,
		}
	},

	-- Super Resources
	WeaponPointsRareDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		PurchaseText = "Shop_UseWeaponPointsRareDrop",
		AddResources =
		{
			WeaponPointsRare = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/NightmareDropSFX",
		ConsumeSound = "/SFX/NightmarePickup",
	},
	MixerFBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerFBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/HeatRewardDrop",
		ConsumeSound = "/SFX/HeatCollectionPickupReverse2",
	},
	MixerGBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerGBoss = 1,
		},

		OnUsedFunctionName = "UseScyllaPearl",
		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/PearlDropSFX",
		ConsumeSound = "/SFX/PearlPickup",
	},

	MixerHBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerHBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/TearDropSFX",
		ConsumeSound = "/SFX/TearPickup",
	},

	MixerIBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerIBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/ChronosZSandDropSFX",
		ConsumeSound = "/SFX/ChronosZSandPickupSFX",
	},

	MixerNBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerNBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/WoolDropSFX",
		ConsumeSound = "/SFX/WoolPickup",
	},

	MixerOBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerOBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/AppleDropSFX",
		ConsumeSound = "/SFX/ApplePickup",
	},

	MixerPBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerPBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/FeatherDropSFX",
		ConsumeSound = "/SFX/FeatherPickup",
	},

	MixerQBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerQBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/VoidLensDropSFX",
		ConsumeSound = "/SFX/VoidLensPickupSFX",
	},

	MixerMythicDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerMythic = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/EntropyDropSFX",
		ConsumeSound = "/SFX/EntropyPickup",

		OnSpawnVoiceLines =
		{
			PlayOnce = true,
			PlayOnceContext = "EntropyFirstDropVO",
			PreLineWait = 0.55,

			{ Cue = "/VO/MelinoeField_4180", Text = "Entropy..." },
		},
	},

	Mixer5CommonDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			Mixer5Common = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/Menu Sounds/StardustDrop",
		ConsumeSound = "/SFX/Menu Sounds/StardustPickup",
	},

	Mixer6CommonDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			Mixer6Common = 1,
		},
		--UseText = "UseMetaPointDrop",
		SpawnSound = "/SFX/Player Sounds/DarknessRewardDrop",
		ConsumeSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
		OnUsedOnExitFunctionName = "UseDarknessOnExit",
		SpeakerName = "Selene",		
		LoadPackages = { "Selene", },
	},

	CardUpgradePointsDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			CardUpgradePoints = 3,
		},

		IconPath = ResourceData.CardUpgradePoints.IconPath,
		TextIconPath = ResourceData.CardUpgradePoints.TextIconPath,
		UseText = "UseResourcePickup",
		SpawnSound = "/Leftovers/Menu Sounds/MoonDustSFX",
		ConsumeSound = "/Leftovers/Menu Sounds/MoonDustSFX2",
	},

	FamiliarPointsDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			FamiliarPoints = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
	},

	CharonPointsDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			CharonPoints = 1,
		},
		ResourceCosts =
		{
			Money = 600,
		},

		UseText = "UseCharonPointsDrop",
		PurchaseText = "Shop_UseCharonPointsDrop",
		SpawnSound = "/SFX/CharonMembershipCardDrop",
		ConsumeSound = "/SFX/CharonMembershipCardPickup",
		OnConsumedGlobalVoiceLines = "UsedCharonPointsDropVoiceLines",
	},

	GemPointsDrop =
	{
		InheritFrom = { "BaseSuperResource" },
		AddResources =
		{
			GemPoints = 10,
		},
		IncreasePerBiomeCleared = 10,

		SpawnSound = "/SFX/GemDropSFX",
		ConsumeSound = "/SFX/GemPickup",
	},

	GemPointsBigDrop =
	{
		InheritFrom = { "BaseSuperResource" },
		AddResources =
		{
			GemPoints = 50,
		},

		SpawnSound = "/SFX/GemDropSFX",
		ConsumeSound = "/SFX/GemPickup",

		OnUseEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					InputBlock = "AnomalyGemPickup",
					PreWait = 2.0,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "C_Boss01" },
					},
				},
			},
		},
	},
}