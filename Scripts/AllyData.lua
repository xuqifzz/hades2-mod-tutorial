UnitSetData.Allies =
{
	BaseAlly =
	{
		DamageType = "Ally",

		RequiredKill = false,
		DropItemsOnDeath = false,
		UseShrineUpgrades = false,
		SkipModifiers = true,

		AddToEnemyTeam = false,

		ActivateFx = "Blank",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "Blank",
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.3,
		ActivateFadeInDuration = 0.3,
		ActivateTint = false,
		ActivateTintDelay = 0.15,
		ActivateTintDuration = 0.05,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.3,

		HideHealthBar = true,
		HideLevelDisplay = true,

		DefaultAIData = 
		{
			DeepInheritance = true,

			TargetRequiredKillEnemy = true,
			IgnoreInvulnerable = true,
		},
			

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},

		MeterMultiplier = 0,
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},
	},

	-- Base Summon
	SwarmerSummon = 
	{
		InheritFrom = { "BaseAlly", "BaseVulnerableEnemy" },
		MaxHealth = 400,

		HealthBarOffsetY = -145,
		HealthBarType = "MediumLarge",
		AnimOffsetZ = 120,
		Groups = { "HeroTeam" },
		Material = "Bone",

		DefaultAIData = 
		{
			DeepInheritance = true,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			AggroAnimation = "Enemy_Swarmer_Alert",
			IdleAnimation = "Enemy_Swarmer_Idle",

			AttackDistance = 350,
			RetreatAfterAttack = false,

			RequireProjectileLoS = true,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
			AngleTowardsTargetWhileFiring = false,
			TrackTargetDuringCharge = false,

			TargetClosest = true,
		},

		AIOptions =
		{
			"AttackerAI",
		},
		WakeUpDelay = 0.2,

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		WeaponOptions =
		{
			"SpellSummonMelee",
		},
	},
	
	SummonSelfDestruct =
	{
		InheritFrom = { "SwarmerSummon" },

		WeaponOptions = { "SummonSelfDestruct" },
		DestroyDelay = 0.2,
		PreDeathFunctionName = "FireSummonDeathWeapon",
	},
	

	ShadeMerc =
	{
		InheritFrom = { "BaseAlly", "BaseTrap" },

		CollisionReactions =
		{
			{
				DisappearDuration = 0.1,
			},
		},
		ImpactReaction =
		{
			DisappearDuration = 0.1,
		},

		NonHeroKillCombatText = "ShadeMercKill",
		NonHeroKillCombatTextUsePlayerSource = true,

		DefaultAIData =
		{
			DeepInheritance = true,

			RecruitDistance = 150,
			ResetTime = 10.0,

			IdleAnimation = "ShadeHubMIdle",
			DisabledAnimation = "Blank",

			TargetClosest = true,
			TargetRequiredKillEnemy = true,
			IgnoreInvulnerable = true,
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 1.0,
			},
		},

		WeaponOptions =
		{
			"ShadeMercSpiritball",
		},

		AIOptions =
		{
			"ShadeMercAI",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Allies )