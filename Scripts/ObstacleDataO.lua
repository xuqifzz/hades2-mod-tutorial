-- Ships
OverwriteTableKeys( ObstacleData, {
	ShipsPostBossDoor =
	{
		InheritFrom = { "PostBossDoor", },
		UnlockedAnimation = "DoorExitLightSoftNE",
		RewardPreviewOffsetX = -30,
		RewardPreviewOffsetZ = 0,
		InteractOffsetX = -75,
		InteractOffsetY = 140,

		--ExitThroughCenter = true,
	},
	ShipsSteeringWheel =
	{
		OnUseEvents =
		{
			{ FunctionName = "UseShipWheelForward", },
		},

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAngle = 207,
				},
			}
		},
		
		RerollFunctionName = "AttemptRerollShipWheel",
		GetUseTextFunctionName = "GetShipWheelUseText",
		GetUseTextFunctionArgs =
		{
			Default = "UseShipWheel",
			Reroll = "UseShipWheel_Reroll",
		},
		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 130,
		RewardPreviewOffsetX = -40,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",
		SkipResourcePinIcons = true,

		UnlockedSound = "/SFX/DartTrapEmitterActivateSlide",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

		UsingSpawn = { "ShipsGustSpawnerLeft", "ShipsGustSpawnerRight" },
		Using = { "ShipsSteeringWheelBreak" },

		--UnlockedAnimation = "ShipsSteeringWheelActivate",
		--UsedAnimation = "ShipsSteeringWheelDeactivate",
	},

	ShipsSteeringWheelLeft =
	{

		OnUseEvents =
		{
			{ FunctionName = "UseShipWheelLeft", },
		},

		RerollFunctionName = "AttemptRerollShipWheel",
		GetUseTextFunctionName = "GetShipWheelUseText",
		GetUseTextFunctionArgs =
		{
			Default = "UseShipWheel",
			Reroll = "UseShipWheel_Reroll",
		},
		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",
		SkipResourcePinIcons = true,

		UnlockedSound = "/SFX/DartTrapEmitterActivateSlide",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

		--UnlockedAnimation = "ShipsSteeringWheelActivate",
		--UsedAnimation = "ShipsSteeringWheelDeactivate",
	},

	ShipsSteeringWheelRight =
	{

		OnUseEvents =
		{
			{ FunctionName = "UseShipWheelRight", },
		},

		RerollFunctionName = "AttemptRerollShipWheel",
		GetUseTextFunctionName = "GetShipWheelUseText",
		GetUseTextFunctionArgs =
		{
			Default = "UseShipWheel",
			Reroll = "UseShipWheel_Reroll",
		},
		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",
		SkipResourcePinIcons = true,

		UnlockedSound = "/SFX/DartTrapEmitterActivateSlide",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

		--UnlockedAnimation = "ShipsSteeringWheelActivate",
		--UsedAnimation = "ShipsSteeringWheelDeactivate",
	},

	ShipsPowerCell =
	{
		UsedAnimation = "ShipsPowerCellEmpty",
	},

	ShipsExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 145,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,
		AllowReroll = false,

		DefaultRewardPreviewOverride = "ExitAheadPreview",

		ExitFunctionName = "ShipsLeaveRoomPresentation",

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "ShipsExitDoorUnlocked",
		--ExitDoorOpenAnimation = "ShipsExitDoorUnlocked",
		--ExitDoorCloseAnimation = "ShipsExitDoorUnlocked",
	},

	ShipsJerkyhoard01 =
	{
		InheritFrom = { "BaseDestructible" },

		MaxHealth = 0,
		HealthTicks = 2,
		CannotDieFromDamage = true,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		SkipDestroy = true,
		DeathAnimation = "ShipsJerkyhoard01DestructionFx",
		DamagedFxStyles =
		{
			Default = "EphyraDestructibleWoodSplinters",
			Rapid = "EphyraDestructibleWoodSplinters",
		},
	},

	ShipsStatue01 =
	{
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			RequiredSourceProjectile = { "SniperGunWeapon" },
			Animation = "ShipsStatueDestroyed",
			SwapData = "ShipsStatue01_Destroyed",
			RequiredHitsForImpactReaction = 1,
			ReactionEvents =
			{
				{
					FunctionName = "GenericPresentation",
					Threaded = true,
					Args =
					{
						VoiceLines =
						{
							RandomRemaining = true,
							BreakIfPlayed = true,
							PreLineWait = 0.5,
							SuccessiveChanceToPlay = 0.33,
							ObjectType = "Eris",
							Cooldowns =
							{
								{ Name = "ErisSpokeRecently", Time = 8 },
							},

							{ Cue = "/VO/ErisField_0285", Text = "There goes your cover!", PlayFirst = true },
							{ Cue = "/VO/ErisField_0286", Text = "So much for your hiding spot!" },
							{ Cue = "/VO/ErisField_0287", Text = "One less place to hide!" },
							{ Cue = "/VO/ErisField_0288", Text = "We'll fix that later." },
							{ Cue = "/VO/ErisField_0289", Text = "Collateral damage!" },
							{ Cue = "/VO/ErisField_0290", Text = "{#Emph}Oopsie!" },
						},
					},
				},
			},
		},
	},

	ShipsStatue01_Destroyed =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	Breakable_O =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "ShipsBreakable01Shatter",

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "Breakable_O01" },
							OverwriteData =
							{
								DeathFx = "ShipsBreakable01Shatter",
							},
						},
						{
							Animation = { "Breakable_O02" },
							OverwriteData =
							{
								DeathFx = "ShipsBreakable02Shatter",
							},
						},
						{
							Animation = { "Breakable_O03" },
							OverwriteData =
							{
								DeathFx = "ShipsBreakable03Shatter",
							},
						},
					},
				},
			},
		},
	},

	-- Ships
	ShipsCrate01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	ShipsBucket01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},
	ShipsBarrel01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},
	ShipsChest01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},
	ShipsTableGroup01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},
	ShipsSackGroup01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},
	ShipsSackGroup02 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},

	HealthFountainO =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainO_Empty",
	},

	ShadeShipsFiveIdle01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeShipsFiveSwaySW01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeShipsThreeIdle01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeShipsThreeSwaySW01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeShipsOneIdle01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeShipsOneSwaySW01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

})