UnitSetData.Charybdis =
{
	Charybdis =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy", },
		IsBoss = false,
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		IgnoreSpeedShrine = true,
		BlockCharm = true,
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CharybdisDefeatedMessage", StartPanTime = 1.0, EndPanTime = 2.0, PanZoomFraction = 0.75, FlashRed = true, MessageDelay = 0.5, IgnoreEndMusic = true, },
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
		AIEndGroupHealthThreshold = 0.75,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				AIData =
				{
					AIEndGroupHealthThreshold = 0.75,
				},				
			},
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				TransitionFunction = "CharybdisTransition",
				TransitionWeapon = "CharybdisSpit1",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
				},
			},

			{
				RandomAIFunctionNames = { "IdleAIStage" },
				TransitionFunction = "CharybdisTransition",
				TransitionWeapon = "CharybdisSpit2",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.25,
				},
			},

			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CharybdisTransition",
				TransitionWeapon = "CharybdisSpit3",
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

	CharybdisTentacle =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		IsBoss = false,
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		MaxHealth = 2000,

		DeathFx = "EnemyDeathFxIris",
		DeathSound = "/SFX/Enemy Sounds/Charybdis/EmoteDying",

		StunAnimations = 
		{
			Default = "Enemy_CharybdisTentacle_OnHit",
		},

		WeaponOptions =
		{
			"CharybdisTentacleSlap",
		},

		SkipTransitionInvulnerability = true,
		AIEndGroupHealthThreshold = 0.75,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				WaitDuration = 1.0,
				AIData =
				{
					AIEndGroupHealthThreshold = 0.75,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				WaitDuration = 1.0,
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
				TransitionFunction = "BossStageTransition",
				WaitDuration = 1.0,
				FireWeapon = "CharybdisTentacleBurrow",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.25,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "CharybdisTentacleWhip", "CharybdisTentacleSpike" },	
			},

			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				WaitDuration = 1.0,
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
}

OverwriteTableKeys( EnemyData, UnitSetData.Charybdis )