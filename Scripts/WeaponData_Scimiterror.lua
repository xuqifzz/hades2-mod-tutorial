WeaponSetData =
{
	--[[ not in use, saving for potential miniboss use
	ScimiterrorStab =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScimiterrorStab",
			--FireProjectileStartDelay = 0.11,
			FireSelfVelocity = 2500,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			PreAttackSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteCharging",
			--FireFx = "EnemyHeavySlashWretchAssassin",

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Scimiterror_StabPreFire",
			FireAnimation = "Enemy_Scimiterror_StabFire",
			PostAttackAnimation = "Enemy_Scimiterror_StabPostFire",
			PreAttackDuration = 0.9,
			FireDuration = 0.42,
			PostAttackDuration = 0.5,

			AttackDistance = 600,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	ScimiterrorChop =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScimiterrorChop",
			FireProjectileStartDelay = 0.13,
			FireSelfVelocity = 0,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			PreAttackSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteCharging",

			PreAttackAnimation = "Enemy_Scimiterror_ChopPreFire",
			FireAnimation = "Enemy_Scimiterror_ChopFire",
			PostAttackAnimation = "Enemy_Scimiterror_ChopPostFire",
			PreAttackDuration = 0.48,
			FireDuration = 0.35,
			PostAttackDuration = 0.8,

			AttackDistance = 250,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
	]]

	ScimiterrorSlashLeft =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScimiterrorSlashLeft",
			FireProjectileStartDelay = 0.1,
			FireSelfVelocity = 1600,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			PreAttackSound = "/SFX/Enemy Sounds/Scimiterror/EmoteCharging",
			--FireFx = "ScimiterrorSlashLeft",
			PreAttackEndShake = true,

			--PreAttackAnimation = "Enemy_Scimiterror_SlashLeftPreFire",
			FireAnimation = "Enemy_Scimiterror_SlashLeftFire",
			PostAttackAnimation = "Enemy_Scimiterror_SlashLeftPostFire",
			
			PreAttackDuration = 0.8,
			PreAttackEndDuration = 0.45,

			FireDuration = 0.46,
			PostAttackDuration = 0.5,

			PreAttackTeleportToSpawnPoints = true,
			TeleportMaxDistance = 400,
			TeleportPreWaitAnimation = "Enemy_Scimiterror_SlashLeftPreFire",
			TeleportEndFx = "ScimiterrorTeleportFx",
			PreTeleportWait = 0.05,

			AttackDistance = 700,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 900,
			RetreatTimeout = 2.0,

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Scimiterror/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	ScimiterrorSlashRight =
	{
		InheritFrom = { "ScimiterrorSlashLeft", },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScimiterrorSlashRight",
			TeleportPreWaitAnimation = "Enemy_Scimiterror_SlashRightPreFire",
			FireAnimation = "Enemy_Scimiterror_SlashRightFire",
			PostAttackAnimation = "Enemy_Scimiterror_SlashRightPostFire",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil