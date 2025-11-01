UnitSetData.Jellyfish =
{

	Jellyfish =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },
		RunHistoryKilledByName = "Octofish_Miniboss",

		ActivateAnimation = "Enemy_Jellyfish_Spawn",

		MaxHealth = 200,
		HealthBarOffsetY = -140,
		HealthBarType = "Small",
		ArmorSparkAnimation = "HitSparkArmor_Small",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetalRapid",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},

		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Jellyfish/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Jellyfish/EmoteDying",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Jellyfish_OnHit",
			Heavy = "Enemy_Jellyfish_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,

			TriggerGroups = { "HeroTeam" },
			WanderDistance = 400,
			WanderIntervalMin = 2.0,
			WanderIntervalMax = 4.0,
		},
		PostAggroAI = "GuardAI",

		WeaponOptions =
		{
			"JellyfishSting", 
		},

		ActiveCapWeight = 0.3,
		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"Jellyfish_Elite"}
		},
	},

	Jellyfish_Elite =
	{
		InheritFrom = { "Elite", "Jellyfish" },
		HealthBuffer = 200,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"Jellyfish"}
		},
	},

	Jellyfish_Scylla =
	{
		InheritFrom = { "Jellyfish_Elite" },
		GenusName = "Jellyfish_Elite",
		RunHistoryKilledByName = "Scylla",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AttackerAI",
		},
		WeaponOptions =
		{
			"JellyfishSting_Scylla", 
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Jellyfish )

WeaponSetData =
{
	JellyfishSting =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "JellyfishStingRing",
			FireProjectileAtSelf = true,

			MoveWithinRange = false,
			AttackDistance = 300,

			PreAttackAnimation = "Enemy_Jellyfish_StingPreFire",
			FireAnimation = "Enemy_Jellyfish_StingFire",
			PostAttackAnimation = "Enemy_Jellyfish_StingPostFire",

			PreAttackStop = true,

			PreAttackSound = "/SFX/Player Sounds/ElectricZapLarge",
			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Mourner/RangedAttackLoop",

			PreAttackDuration = 0.6,
			FireDuration = 0.28,
			PostAttackDuration = 1.25,
			PostAttackCooldownMin = 1.0,
			PostAttackCooldownMax = 2.0,
		},
	},

	JellyfishSting_Scylla =
	{
		InheritFrom = { "JellyfishSting" },
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
			AttackDistance = 375,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil