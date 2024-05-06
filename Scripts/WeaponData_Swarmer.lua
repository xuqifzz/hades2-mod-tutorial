WeaponSetData =
{
	SwarmerMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SwarmerMelee",

			PreAttackEndShake = true,

			FireProjectileStartDelay = 0.03,
			FireSelfVelocity = 1800,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackDuration = 0.5,
			FireDuration = 0.25,
			PostAttackDuration = 0.5,
			PreAttackAnimation = "Enemy_Swarmer_MeleeAttackPreAttack",
			FireAnimation = "Enemy_Swarmer_MeleeAttackFire",
			PostAttackAnimation = "Enemy_Swarmer_MeleeAttackReturnToIdle",

			AttackDistance = 350,
			RetreatBufferDistance = 550,
			RetreatAfterAttack = true,

			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SwarmerClockworkMelee =
	{
		InheritFrom = { "SwarmerMelee" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackStop = true,

			ProjectileName = "SwarmerClockworkMelee",

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.03,
			StopBeforeFire = true,

			PreAttackDuration = 0.8,
			PreAttackAnimationSpeed = 0.625,

			AttackDistance = 760,
			AttackDistanceScaleY = 0.50,
			FireSelfVelocity = 3650,
			RetreatBufferDistance = 610,
			RetreatAfterAttackEndWait = 0.75,
			--DumbFireWeapons = { "SwarmerRushRipple" },
		},
	},

	SwarmerClockworkMelee_Elite =
	{
		InheritFrom = { "SwarmerClockworkMelee" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.35,
			RetreatAfterAttack = false,
		},
	},

	SwarmerClockworkRepositionTeleport =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			MoveWithinRange = false,
			SkipFireWeapon = true,

			SkipCanAttack = true,

			PreAttackTeleportToSpawnPoints = true,
			TeleportMinDistance = 400,
			TeleportMaxDistance = 1000,
			TeleportEndFx = "SwarmerTeleportFxFront",
			PreTeleportWait = 0.05,
			PostAttackDurationMin = 0.15,
			PostAttackDurationMax = 0.25,
		},
	},

	--[[SwarmerRushRipple =
	{
		InheritFrom = { "ChronosRushRipple" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "SwarmerRushRipple", UseAttackerAngle = true, },
				{ ProjectileName = "SwarmerRushRipple", UseAttackerAngle = true, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ ProjectileName = "SwarmerRushRipple", UseAttackerAngle = true, },
			},
		}
	},]]
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil