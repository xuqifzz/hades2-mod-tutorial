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
		MetaConversionEligible = true,
		UseTextTalkAndGift = "UseOrConvertConsumable",
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
	},
	RoomRewardHealDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UsePromptOffsetY = 30,
		ResourceCosts =
		{
			Money = 50,
		},
		HealFraction = 0.4,
		UseText = "UseHealDrop",
		ConsumeFx = "HealConsumableFx",
		OnUsedFunctionName = "UseConsumableItem",
		PurchaseText = "Shop_UseHealDrop",
		PurchaseRequirements =
		{
			RequiredMaxHealthFraction = 1,
		},
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
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
		HealFraction = 0.8,
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
		HealFraction = 0.01,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
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
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.75,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownTime = 6,

			-- @tbd 6 lines
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
	RoomMoneyDrop =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 100,
		},
		DoorIcon = "MoneyDropPreview",
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/SFX/GoldCoinRewardUse",
		UseText = "UseMoneyDrop",
		BlockExitText = "ExitBlockedByMoney",
		PlayInteract = true,
		HideWorldText = true,
		CanDuplicate = true,
		LastRewardEligible = true,
		EchoLastRewardId = "EchoLastReward_MoneyDrop",
		ExitUnlockDelay = 1.1,

		DropMoney = 100,
		OnSpawnVoiceLines =
		{
			PreLineWait = 0.65,
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
		Icon = "MoneyDropCoin",
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
		OnSpawnVoiceLines =	{},
	},
	LobAmmoPack =
	{
		InheritFrom = { "BaseConsumable" },
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

			{ Cue = "/VO/Melinoe_0194", Text = "A Centaur Heart...", ChanceToPlayAgain = 0.02, PreLineWait = 0.65, },
		},

		ConsumedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedHealDropVoiceLines,
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
		AddMaxHealth = 5,
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
	},
	EmptyMaxHealthDrop = 
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEmptyMaxHealthDrop",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseEmptyMaxHealthDrop",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/HealthIncreasePickup",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		HideWorldText = true,
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
		AddMaxMana = 10,
	},
	MaxManaDropBig = 
	{
		InheritFrom = { "MaxManaDrop", },
		DoorIcon = "MaxManaDropBig_Preview",
		AddMaxMana = 60,
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
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/SFX/GoldCoinRewardUse",
		UseText = "UseTalentDrop",
		BlockedLootInteractionText = "UseTalentDropLocked",
		BlockExitText = "ExitBlockedByMoney",
		HideWorldText = true,
		LastRewardEligible = true,
		ExitUnlockDelay = 1.1,
		UseFunctionName = "OpenTalentScreen",
		RerollColor = Color.White,
		AddTalentPoints = 3,
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
			RequiredConsumablesThisRun =
			{ 
				Count = 1,
				Names =
				{
					"SpellDrop",
				},
			},
			{
				PathFalse = { "CurrentRun", "AllSpellInvestedCache", },
			},
		},

		OnSpawnVoiceLines =
		{
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

			{ Cue = "/VO/MelinoeField_1474", Text = "The Path of Stars..." },
			{ Cue = "/VO/MelinoeField_2380", Text = "The Path of Stars...", PlayFirst = true },
			-- { Cue = "/VO/Melinoe_0192", Text = "A Star Drop...", ChanceToPlayAgain = 0.01, PreLineWait = 0.65, },
		},
	},

	MinorTalentDrop = 
	{
		InheritFrom = { "TalentDrop" },
		AddTalentPoints = 1,
	},
	StoreRewardRandomStack = 
	{
		InheritFrom = { "BaseConsumable", },
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
		PurchaseText = "Shop_UseLastStandDrop",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		HideWorldText = true,

		Cost = 200,
		GameStateRequirements =
		{
			RequiredMinMaximumLastStands = 1,
			NotMaxLastStands = true,
		},
		PurchaseRequirements =
		{
			NotMaxLastStands = true,
		},
		UseFunctionNames =  { "AddLastStand", "GainLastStandPresentation"} ,
		UseFunctionArgs =
		{
			{
				Icon = "ExtraLifeStyx",
				HealFraction = 0.5,
				ManaFraction = 0.5
			},
			{}
		},
	},
	MinorDodgeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEssence",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseEssence",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		ShowWorldText = true,

		Cost = 200,
		RequiredMinMaximumLastStands = 1,
		NotMaxLastStands = true,
		PurchaseRequirements =
		{
			NotMaxLastStands = true,
		},
		UseFunctionNames =  { "AddOrIncreaseTrait" } ,
		UseFunctionArgs =
		{
			{
				TraitName = "MinorDodgeEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},
	MinorDamageBoost =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEssence",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseEssence",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		ShowWorldText = true,

		Cost = 50,
		UseFunctionNames =  { "AddOrIncreaseTrait" } ,
		UseFunctionArgs =
		{
			{
				TraitName = "DamageEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},
	HitShieldDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseHitShieldDrop",
		PurchaseText = "Shop_UseHitShieldDrop",
		DoorIcon = "HitShieldDropPreview",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/Menu Sounds/KeepsakeEurydiceAcorn",
		ConsumeFx = "ItemConsumeFx",
		OnConsumedGlobalVoiceLines = "UsedShieldDropVoiceLines",
		PlayInteract = true,
		ResourceCosts =
		{
			Money = 60,
		},
		AddHitShield = 3,
		ExtractValues =
		{
			{
				Key = "AddHitShield",
				ExtractAs = "TooltipHitShield",
			},
		}
	},
	HitShieldBigDrop =
	{
		InheritFrom = { "HitShieldDrop", },
		ResourceCosts =
		{
			Money = 120,
		},
		AddHitShield = 6,
	},
	ArmorBoost =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseArmorDrop",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseArmorDrop",
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
	ArmorBigBoost =
	{
		InheritFrom = { "ArmorBoost", },
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
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
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
	MinorExDamageBoost =
	{
		InheritFrom = { "BaseConsumable", },
		UseText = "UseEssence",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseEssence",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ConsumeFx = "MaxHealthDropPickupFx",
		PlayInteract = true,
		ShowWorldText = true,

		Cost = 200,
		RequiredMinMaximumLastStands = 1,
		NotMaxLastStands = true,
		PurchaseRequirements =
		{
			NotMaxLastStands = true,
		},
		UseFunctionNames =  { "AddOrIncreaseTrait" } ,
		UseFunctionArgs =
		{
			{
				TraitName = "ExDamageEssence",
				ReportValues = { ReportedTraitName = "TraitName" }
			},
		},
	},	

	-- Loot substitutes
	ChaosWeaponUpgrade = 
	{
		InheritFrom = { "BaseConsumable", },
		HideWorldText = true,
		GameStateRequirements =
		{
			RequiredMinWeaponUpgrades = 1,
		},		
		PurchaseRequirements =
		{
			RequiredMinWeaponUpgrades = 1,
		},
		CannotPurchaseCombatText = "ChaosAnvil_NeedsMore",
		CannotPurchaseVoiceLines = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
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
	},
	WeaponUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		ResourceCosts =
		{
			Money = 200,
		},
		UseText = "UseWeaponUpgrade",
		UseFunctionName = "CreateWeaponLoot",
		SurfaceShopText = "WeaponUpgradeDrop_Store",
		SurfaceShopIcon = "WeaponUpgradeShop",
		GameStateRequirements = 
		{
			RequiredMaxWeaponUpgrades = 0,
			RequiredMinCompletedRuns = 3,
		}
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
			RequiredTextLines = {  "HermesFirstPickUp" },
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
		HideWorldText = true,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		PurchaseRequirements =
		{
			RequiredMaxHealthFraction = 1,
		},
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY",
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHealPercent",
				Format = "Percent",
			},
			{
				ExtractAs = "HealingReduction",
				Format = "TotalMetaUpgradeChangeValue",
				MetaUpgradeName = "HealingReductionShrineUpgrade"
			}
		},
	},
	LastStandShopItem =
	{
		InheritFrom = { "BaseWellShopConsumable" },
		ConsumeSound = "/EmptyCue",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		OnPurchasedGlobalVoiceLines = "PurchasedLastStandVoiceLines",
		CannotPurchaseVoiceLines = GlobalVoiceLines.FrustratedVoiceLines,
		Icon = "Shop_Jug",
		ResourceCosts =
		{
			Money = 200,
		},
		
		GameStateRequirements =
		{
			RequiredMinMaximumLastStands = 1,
			NotMaxLastStands = true,
		},
		PurchaseRequirements =
		{
			NotMaxLastStands = true,
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
		Icon = "Shop_MemPointsCommonRange",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerMemPointsCommon = 3,
		AddResources =
		{
			MemPointsCommon =
			{
				BaseMin = 11,
				BaseMax = 22,
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
		UseText = "UseResourcePickup",
		UseTextTalkAndGift = "UseOrConvertResourcePickup",
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
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
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
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
		ConsumeFx = "ItemConsumeFx",
		LastRewardEligible = true,
		ResourceCosts =
		{
			Money = 90,
		},
		IconPath = ResourceData.MetaCurrency.IconPath,
		AddResources =
		{
			MetaCurrency = 50,
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
					{
						--
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
			[2] = GlobalVoiceLines.ResourceFoundVoiceLines,
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
	OreNBronzeDrop =
	{
		InheritFrom = { "BaseResource", },
		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/SuperGemDropSFX",
		ConsumeSound = "/SFX/SuperGemPickup",
		AddResources =
		{
			OreNBronze = 1,
		},
	},
	OreOIronDrop =
	{
		InheritFrom = { "BaseResource", },
		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/SuperGemDropSFX",
		ConsumeSound = "/SFX/SuperGemPickup",
		AddResources =
		{
			OreOIron = 1,
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
	PlantMoneyDrop =
	{
		InheritFrom = { "BaseResource", },
		UseText = "UseResourcePickup",
		-- SpawnSound = "/SFX/SuperGemDropSFX",
		-- ConsumeSound = "/SFX/SuperGemPickup",
		AddResources =
		{
			PlantMoney = 1,
		},
	},
	MetaFabricDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			MetaFabric = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/AshRewardPickup",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
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
		UsePromptOffsetY = 30,
		UseText = "UseGiftPointDrop",
		UseTextTalkAndGift = "UseOrConvertGiftPointDrop",
		PurchaseText = "Shop_UseGiftPointDrop",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/SFX/GiftAmbrosiaBottlePickup",
		ConsumeFx = "GiftDropPickup",
		PlayInteract = true,
		HideWorldText = true,
		RequiredMinCompletedRuns = 2,
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
	GiftPointsRareDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			GiftPointsRare = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
	},
	GiftPointsEpicDrop =
	{
		InheritFrom = { "BaseResource", },
		AddResources =
		{
			GiftPointsEpic = 1,
		},

		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
	},
	TrashPointsDrop =
	{
		InheritFrom = { "BaseResource", },
		SpawnSound = "/SFX/CrappyRewardDrop",
		PickUpSound = "/SFX/CrappyRewardPickup", -- for HarvestPresentation
		ConsumeFx = "ItemConsumeFxSmall",
		ConsumeSound = "/SFX/CrappyRewardPickup",
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
		SpawnSound = "/SFX/KeyDrop",
		ConsumeSound = "/SFX/KeyPickup",
		AddResources =
		{
			WeaponPointsRare = 1,
		},
	},
	MixerFBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerFBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/SuperKeyDrop",
		ConsumeSound = "/SFX/SuperKeyPickup",
	},
	MixerGBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerGBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/HeatRewardDrop",
		ConsumeSound = "/SFX/HeatCollectionPickupReverse",
	},
	MixerHBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerHBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/HeatRewardDrop",
		ConsumeSound = "/SFX/HeatCollectionPickupReverse",
	},
	MixerIBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerIBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/HeatRewardDrop",
		ConsumeSound = "/SFX/HeatCollectionPickupReverse",
	},
	MixerNBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerNBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
	},
	MixerOBossDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			MixerOBoss = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
	},
	Mixer5CommonDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			Mixer5Common = 1,
		},

		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
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
	},
	CardUpgradePointsDrop =
	{
		InheritFrom = { "BaseSuperResource", },
		AddResources =
		{
			CardUpgradePoints = 3,
		},

		IconPath = ResourceData.CardUpgradePoints.IconPath,
		UseText = "UseResourcePickup",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
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
}