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
		HealthBarOffsetY = -520,
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CharybdisDefeatedMessage", StartPanTime = 1.0, EndPanTime = 2.0, PanZoomFraction = 0.75, FlashRed = true, MessageDelay = 0.5 },
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
				RandomAIFunctionNames = { "IdleAIStage" },
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

	CharybdisTentacle =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		GenusName = "Charybdis",
		IsBoss = false,
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		BlockCharm = true,
		MaxHealth = 2800,

		DeathFx = "EnemyDeathFxIris",
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
}

OverwriteTableKeys( EnemyData, UnitSetData.Charybdis )