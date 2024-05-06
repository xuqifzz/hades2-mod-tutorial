WeaponSetData =
{
	SwabSwing =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			AttackSlots =
			{
				{ ProjectileName = "SwabShockwave", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }, PauseDuration = 0.32,  },
				{ ProjectileName = "SwabShockwaveWarning", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }, PauseDuration = 1.73, },
				{ ProjectileName = "SwabShockwavePull", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }  },
			},
			--EndAttackSlotsOnHit = true,

			FireStartFunctionName = "WeaponSetImmuneToStun",
			PostAttackFunctionName = "WeaponRevertStunImmunity",

			WaitForAngleTowardTarget = true,

			--PreAttackEndStop = true,
			--PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteCharging",
			FireProjectileStartDelay = 0.08,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Swab_SwingPreFire",
			FireAnimation = "Enemy_Swab_SwingFire",
			--PostAttackAnimation = "Enemy_Swab_SwingPostFire",
			PreAttackDuration = 1.5,
			--FireDuration = 0.68, -- attack slot duration = 2.05
			PostAttackDuration = 1.2, -- animation is 2.53

			AttackDistance = 440,
			AttackDistanceScaleY = 0.8,
		},
		
		FireScreenshake = { Distance = 6, Speed = 400, DistanceThreshold = 700, Duration = 0.2, FalloffSpeed = 1000, Angle = 0, ScreenPreWait = 0.02 },
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},

	SwabSwing_Elite =
	{
		InheritFrom = { "SwabSwing" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "SwabShockwave_Elite", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }, PauseDuration = 0.4,  },
				{ ProjectileName = "SwabShockwaveWarning_Elite", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }, PauseDuration = 1.1 },
				{ ProjectileName = "SwabShockwavePullElite", AIDataOverrides = { FireProjectileNoDestination = true, SpawnFromMarker = "DeadSeaSwab_Rig:weoponDn_01_R_JNT" }  },
			},
			PostAttackDuration = 0.9, -- anim is 1.68 
			FireAnimation = "Enemy_Swab_SwingFire_Fast"
		},
		FireScreenshake = { Distance = 6, Speed = 400, DistanceThreshold = 1000, Duration = 0.2, FalloffSpeed = 1000, Angle = 0, ScreenPreWait = 0.02 },
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil