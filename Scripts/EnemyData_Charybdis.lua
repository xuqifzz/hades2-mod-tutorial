UnitSetData.Charybdis =
{
	Charybdis =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy", },
		IsBoss = false,
		BlockRaiseDead = true,
		SkipDisableAllyUnitsOnDeath = true,
		BlockRespawnShrineUpgrade = true,
		IgnoreSpeedShrine = true,
		BlockCharm = true,
		HealthBarOffsetY = -520,
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CharybdisDefeatedMessage", StartPanTime = 1.0, EndPanTime = 2.5, PanZoomFraction = 0.75, FlashRed = true, MessageDelay = 0.5 },
		DeathPanOffsetY = -200,
		DeathAnimation = "Enemy_Charybdis_Retreat",
		DeathSound = "/SFX/StabSplatterEndSequence",
		UseActivatePresentation = false,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetUntargetable = true,
				},
			},
		},

		MaxHealth = 1,
		CannotDieFromDamage = true,
		GroupHealthBarOwner = true,

		Material = "Organic",

		WakeUpDelay = 8.0,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Treant/EmoteCharging",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		WeaponOptions =
		{
			
		},

		SkipTransitionInvulnerability = true,
		AIEndGroupHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
				},				
			},
			{
				TransitionFunction = "CharybdisTransition",
				TransitionWeapon = "CharybdisSpit3",
				RandomAIFunctionNames = { "AttackerAI" },
				EquipWeapons = {"CharybdisSpitSmall",},
				AIData =
				{
					AIEndGroupHealthThreshold = 0.0,
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 1000,
		},
	},

	Charybdis_ScyllaFight =
	{
		InheritFrom = { "Charybdis"},
		GenusName = "Charybdis",
		RequiredKill = false,
		OnDeathFunctionName = "nil",
		
		DestroyDelay = 2.0,
		ManualDeathAnimation = false,

		GroupHealthBarOwner = false,

		DestroyIdsOnDeath = { 793885, 793899, 793884, 793274, 793900, 793886, 793889, 793906, 793895, 793902, 793905, 793892, 793907, 793888, 793901, 793904, 793891, 794081, 793266, 793275, 793268, 794083, 793882, 793272, 793269, 793271, 794084, 794082, 793267, 793273, 792351, 792350, },
		GrannyTexture = "GR2/CharybdisEM_Color",

		WakeUpDelay = 0.0,

		WeaponOptions = { "CharybdisSpitScyllaEasy_P1", "CharybdisSpitScyllaHard_P1", "CharybdisSpitScyllaEasy_P2", "CharybdisSpitScyllaHard_P2", "CharybdisWait", "CharybdisSpitScyllaBoosted" },

		AIOptions = { "AttackerAI" },
		AIStages = "nil",
		AIEndGroupHealthThreshold = 0.0,
		PreAISetupFunctionName = "CharybdisScyllaFightStartPresentation",
	},

	CharybdisTentacle =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		GenusName = "Charybdis",
		RunHistoryKilledByName = "Charybdis",
		IsBoss = false,
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		BlockCharm = true,
		MaxHealth = 2800,

		ManualDeathAnimation = false,
		DeathAnimation = "Enemy_CharybdisTentacle_Death",
		DeathFx = "EnemyDeathFxIris_Large",
		DeathSound = "/SFX/Enemy Sounds/Charybdis/EmoteDying",

		StunAnimations = 
		{
			Default = "Enemy_CharybdisTentacle_OnHit",
		},

		WeaponOptions =
		{
			"CharybdisTentacleSlap"
		},

		SkipTransitionInvulnerability = true,
		AIEndGroupHealthThreshold = 0.8,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.8,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				WaitDuration = 0.0,
				DataOverrides =
				{
					WakeUpDelayMin = 0.0,
					WakeUpDelayMax = 0.0,
				},
				TransitionFunction = "BossStageTransition",
				FireWeapon = "CharybdisTentacleBurrow",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "CharybdisTentacleSpike", },	
			},

			{
				RandomAIFunctionNames = { "AttackerAI" },
				WaitDuration = 9.0,
				TransitionFunction = "BossStageTransition",
				FireWeapon = "CharybdisTentacleBurrow",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.3,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "CharybdisTentacleWhip", "CharybdisTentacleSpike" },	
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				WaitDuration = 0.0,
				TransitionFunction = "BossStageTransition",
				FireWeapon = "CharybdisTentacleBurrow",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.15,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "CharybdisTentacleSlap", "CharybdisTentacleSpike", "CharybdisTentacleWhip" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				WaitDuration = 0.0,
				TransitionFunction = "BossStageTransition",
				FireWeapon = "CharybdisTentacleBurrow",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "CharybdisTentacleSlap", "CharybdisTentacleSpike", "CharybdisTentacleWhip" },
			},
		},
		WakeUpDelayMin = 0.5,
		WakeUpDelayMax = 1.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
		},
	},

	CharybdisTentacle2 =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		GenusName = "Charybdis",
		RunHistoryKilledByName = "Charybdis",
		MaxHealth = 2100,
		ForceAllowRaiseDead = true,
		UniqueRaise = true,
		ImmobileRaise = true,
		SkipDisableAllyUnitsOnDeath = true,

		RequiredSpawnPoint = "EnemyPointRanged",

		ActivateFx = "",
		ActivateFx2 = "",
		ActivateFxPreSpawn = "",
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateTint = false,
		ActivateDuration = 0.8,
		ActivateStartAlpha = 1.0,
		ActivateAnimation = "Enemy_CharybdisTentacle_Surface",

		AttachedAnimationName = "CharybdisTentacleRipples",

		InvulnerableFx = "nil",

		GrannyTexture = "GR2/CharybdisTentaclesEM_Color",

		ManualDeathAnimation = false,
		DeathAnimation = "Enemy_CharybdisTentacle_Death",
		DeathFx = "EnemyDeathFxIris_Large",
		DeathSound = "/SFX/Enemy Sounds/Charybdis/EmoteDying",

		OnDeathFunctionName = "TentacleDeathCheck",

		StunAnimations = 
		{
			Default = "Enemy_CharybdisTentacle_OnHit",
		},
		AIOptions = { "AttackerAI" },

		WeaponOptions =
		{
			"CharybdisTentacleSpike2", "CharybdisTentacleWhip2",
			"CharybdisTentacleWait",
		},

		SpellSummonDataOverrides =
		{
			SkipAISetupOnActivate = false,

			WeaponOptions ={ "CharybdisTentacleSpike2_Ally" },
			AIStages =
			{
				{
					RandomAIFunctionNames = { "AttackerAI" },
					AIData =
					{
						AIEndHealthThreshold = 0.0,
					},
				},
			},

			OnDeathFunctionName = "nil",
		},

		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- Wait for all incapacitated
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				TransitionFunction = "CharybdisTentacleHidePresentation",
				NewVulnerability = false,
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CharybdisTentacleSurfacePresentation",
				NewVulnerability = true,
				WaitDuration = 2.2,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
		},
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.Charybdis )