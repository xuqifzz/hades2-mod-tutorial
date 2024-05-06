-- Oceanus
OverwriteTableKeys( ObstacleData, {
	OceanusExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",

		ExitFunctionName = "ExitBiomeGRoomPresentation",
		OnUsedEncounterCostPresentationFunctionName = "EncounterCostDoorUsedPresentation",

		UnlockedSound = "/SFX/DartTrapEmitterActivateSlide",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

		ExitDoorOpenAnimation = "OceanusExitDoorTaken",
		ExitDoorCloseAnimation = "OceanusExitDoorClosed",
		UnlockedAnimation = "OceanusExitDoorOpen",
		PreExitsUnlockedFunctionName = "CheckExitPreUnlock",
		LockedWithEncounterChance = 0.80,
		EncounterCostUseText = "UseEncounterCost",
		EncounterCostStartedUseText = "UseEncounterCostPending",

		NemesisTeleport = true,
	},

	Breakable_G =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "OceanusKelpCocoonDead",
		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "Breakable_G01" },
							OverwriteData =
							{
								DeathFx = "OceanusVase01Shatter",
							},
						},
						{
							Animation = { "Breakable_G02" },
							OverwriteData =
							{
								DeathFx = "OceanusVase02Shatter",
							},
						},
						{
							Animation = { "Breakable_G03" },
							OverwriteData =
							{
								DeathFx = "OceanusVase03Shatter",
							},
						},
					},
				},
			},
		},

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	HealthFountainG =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainG_Empty",
	},
	
	ShadeOceanusMIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeOceanusSIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeOceanusTIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

})