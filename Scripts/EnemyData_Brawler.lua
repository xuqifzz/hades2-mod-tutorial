UnitSetData.Brawler =
{
	-- tough Terminator-like foe that bursts like an explosive grape
	Brawler =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		UseActivatePresentation = true,
		ActivateAnimation = "Enemy_Brawler_Spawn",
		ActivateStartAlpha = 1.0,
		ActivateFx = "EnemyPreSpawnTerrainLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLarge",
		ActivateFxPreSpawn = "EnemySpawnBurstLarge",

		DeathAnimation = "Enemy_Brawler_Death",
		DeathFx = "EnemyDeathFxIris",

		MaxHealth = 255,
		HealthBarOffsetY = -200,
		Material = "Organic",

		IsAggroedSound = "/SFX/Enemy Sounds/Brawler/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Brawler/EmoteDying",

		PreferredSpawnPoint = "EnemyPointMelee",

		AIOptions =
		{
			"AggroAI",
		},

		StunAnimations = 
		{
			Default = "Enemy_Brawler_HitStun",
			Heavy = "Enemy_Brawler_HitStunLong",
			Light = "Enemy_Brawler_HitStun2",
			BlockStun = "Enemy_Brawler_HitStunBlock",
			Lightning = "Enemy_Brawler_HitStunLightning",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Brawler/EmoteCharging",
		},

		WeaponOptions =
		{
			"BrawlerMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 18,
			BlockEnemyTypes = {"Brawler_Elite"}
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				-- None
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1435", Text = "Wastrels." },
			{ Cue = "/VO/Melinoe_1436", Text = "Wastrels!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1437", Text = "More Wastrels." },
			{ Cue = "/VO/Melinoe_1438", Text = "Come, Wastrels." },
		},
	},

	Brawler_Elite =
	{
		InheritFrom = { "Elite", "Brawler" },
		HealthBuffer = 330,
		IsAggroedSound = "/SFX/Enemy Sounds/Brawler/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"BrawlerMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 39,
			BlockEnemyTypes = {"Brawler"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Brawler )

WeaponSetData =
{
	BrawlerMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrawlerMelee",
			FireSelfVelocity = 1800,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackDuration = 1.15,
			FireDuration = 0.4,
			PostAttackDuration = 0.0,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			AttackDistance = 500,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Brawler_MeleePreAttack",
			FireAnimation = "Enemy_Brawler_MeleeFire",
			PostAttackAnimation = "Enemy_Brawler_MeleeReturnToIdle",

			ChainedWeapon = "BrawlerMeleeClose",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Brawler/EmoteAttacking" },
			},
		},
	},

	BrawlerMeleeClose =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrawlerMeleeClose",
			FireSelfVelocity = 300,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackRotationDampening = 0.02,
			FireRotationDampening = 0.1,

			PreAttackDuration = 0.65,
			FireDuration = 0.4,
			PostAttackDuration = 1.1,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackFlash = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Brawler_MeleePreAttack_2",
			FireAnimation = "Enemy_Brawler_MeleeFire_2",
			PostAttackAnimation = "Enemy_Brawler_MeleeReturnToIdle",

			DoNotRepeatOnAttackFail = true,

			-- Blink ban
			PreMoveTeleport = false,
			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Brawler/EmoteAttacking" },
			},
		},
	},

}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil