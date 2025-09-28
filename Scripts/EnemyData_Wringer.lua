UnitSetData.Wringer =
{
	Wringer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 1000,

		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Wringer/WringerAlerted",
		DeathSound = "/SFX/Enemy Sounds/GoldElemental/GoldElementalDeathSFX",
		HealthDamageSound = "/SFX/Enemy Sounds/GoldElemental/EmoteHurt",

		StunAnimations = 
		{
			Default = "Enemy_Wringer_OnHit",
			Heavy = "Enemy_Wringer_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"WringerGrab"
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			MaintainSurroundDistance = false,
			SurroundDistance = 550,
			SurroundRefreshInterval = 0.2,
			--MaxAttackers = 2,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Wringer_Elite"}
		},
	},

	Wringer_Elite =
	{
		InheritFrom = { "Elite", "Wringer" },
		HealthBuffer = 1000,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"WringerGrab"
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		GeneratorData =
		{
			DifficultyRating = 100,
			BlockEnemyTypes = {"Wringer"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Wringer )

WeaponSetData =
{
	WringerGrab =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WringerGrab",

			AttackDistance = 250,
			--OnlyClosestOfTypesMove = { "DisembodiedHand", "DisembodiedHandElite", "DisembodiedHandSuperElite" },
			NotClosestSleepTime = 0.3,

			FireSelfVelocity = 1000,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Wringer_Grab_PreFire",
			FireAnimation = "Enemy_Wringer_Grab_Fire",
			--PostAttackAnimation = "Enemy_Wringer_Grab_PostFire",

			PreAttackDuration = 0.3,
			FireDuration = 0.1,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 2.0,

			RequireUnitLoS = true,
			LineOfSightEndBuffer = 30,

			MoveSuccessDistance = 80,
		}
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil