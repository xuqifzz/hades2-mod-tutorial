OverwriteTableKeys( ProjectileData, {

	ProjectileCast = 
	{
		OnDeathFunctionName = "CastProjectileCleanup"
	},

	-- Staff
	ProjectileStaffBall = 
	{

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1000, Duration = 0.2, Angle = 0, ScreenPreWait = 0.08 },

		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		SimSlowDistanceThreshold = 300,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.08, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.07 },
		},

		DefaultKnockbackForce = 480,
		DefaultKnockbackScale = 0.6,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.15, Duration = 0.05 },
		},
		Sounds = 
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	ProjectileStaffBallCharged =
	{
		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1,
		ImpactReactionHitsOverride = 10,
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.37, Duration = 0.23 },
		},
		FireScreenshake = { Distance = 3, Speed = 300, FalloffSpeed = 1000, Duration = 0.1 },
		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.34, Angle = 90, DistanceThreshold = 200 },

		RumbleDistanceThreshold = 180,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		SimSlowDistanceThreshold = 180,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.10 },
		},
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},

	-- Dagger
	ProjectileDaggerThrowCharged =
	{

	},

	-- Axe
	ProjectileAxeSpecial = 
	{
		--HitScreenshake = { Distance = 6, Speed = 800, Duration = 0.07, FalloffSpeed = 2500, Angle = 90 },
		--HitSimSlowCooldown = 0.5,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.13, LerpTime = 0.0 },
			{ ScreenPreWait = 0.01, Fraction = 1.00, LerpTime = 0.07 },
		},
		RumbleDistanceThreshold = 280,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},
	},

	ProjectileAxeBlock2 = 
	{
		HitScreenshake = { Distance = 6, Speed = 800, Duration = 0.07, FalloffSpeed = 2500, Angle = 90 },
		HitSimSlowCooldown = 1.3,
		--[[ intense version
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.005, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.18, Fraction = 0.10, LerpTime = 0.07 },
			{ ScreenPreWait = 0.40, Fraction = 1.0, LerpTime = 0.07 },
		},
		]]
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.005, Fraction = 0.09, LerpTime = 0.0 },
			{ ScreenPreWait = 0.045, Fraction = 1.0, LerpTime = 0.07 },
		},

		RumbleDistanceThreshold = 280,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		SimSlowDistanceThreshold = 280,
	},
	ProjectileAxeOverhead = 
	{

	},

	ProjectileAxeNergalFast = 
	{

	},
	ProjectileAxeNergalSlow = 
	{

	},

	HammerAxeNova =
	{

	},

	-- Torch
	ProjectileTorchBall = 
	{
		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		HitScreenshake = { Distance = 4, Speed = 200, FalloffSpeed = 2000, Duration = 0.15, DistanceThreshold = 205 },

		SimSlowDistanceThreshold = 205,
		HitSimSlowCooldown = 0.34,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.20, LerpTime = 0.00 },
			{ ScreenPreWait = 0.02, Fraction = 1.00, LerpTime = 0.10 },
		},
	},

	ProjectileTorchSupayBallEx =
	{
		InheritFrom = { "ProjectileTorchBall", },
	},

	ProjectileTorchWave =
	{
		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		HitScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 2000, Duration = 0.14, DistanceThreshold = 500 },

		SimSlowDistanceThreshold = 205,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.25, LerpTime = 0.00 },
			{ ScreenPreWait = 0.01, Fraction = 1.00, LerpTime = 0.00 },
		},
	},

	ProjectileTorchGhost = 
	{
		InheritFrom = { "ProjectileTorchBall", },
	},
	ProjectileTorchGhostLarge = 
	{
		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,
		IsExProjectile = true,

		HitScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 2000, Duration = 0.1, DistanceThreshold = 330 },

		--[[
		SimSlowDistanceThreshold = 130,
		HitSimSlowCooldown = 0.34,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.35, LerpTime = 0.00 },
			{ ScreenPreWait = 0.03, Fraction = 1.00, LerpTime = 0.10 },
		},
		]]
	},
	ProjectileTorchGhostExplosion = 
	{
		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.34, Angle = 90, DistanceThreshold = 280 },

		RumbleDistanceThreshold = 280,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		--[[
		SimSlowDistanceThreshold = 180,
		HitSimSlowCooldown = 0.21,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.20, LerpTime = 0.0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.10 },
		},
		]]
	},
	ProjectileTorchGhostLargeExplosion = 
	{
		InheritFrom = { "ProjectileTorchGhostExplosion", },
		IsExProjectile = true,
	},
	ProjectileTorchOrbit = 
	{
		IgnoreIndestructibleHitPresentation = true,
	},
	ProjectileTorchOrbitEx = 
	{
		IgnoreIndestructibleHitPresentation = true,
	},
	ProjectileTorchRepeatStrike = 
	{
		IsExProjectile = true,
	},
	ProjectileTorchBallEos = 
	{
		IsExProjectile = true,
	},

	-- Lob
	ProjectileLob =
	{
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1,
	},
	ProjectileLobCharged =
	{
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1.1,

		HitScreenshake = { Distance = 9, Speed = 450, FalloffSpeed = 2000, Duration = 0.30, Angle = 90, DistanceThreshold = 1500 },

		--[[
		SimSlowDistanceThreshold = 600,
		HitSimSlowCooldown = 0.21,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.20, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.10 },
		},
		]]

		RumbleDistanceThreshold = 1500,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.22, Duration = 0.3 },
		},
	},
	ProjectileThrowCharged =
	{
		IsExProjectile = true,
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1,
	},
	ProjectileLobOverheat = 
	{
		IsExProjectile = true,
		BlockCoalesce = true,
	},
	-- Suit
	ProjectileSuit = 
	{
		HitScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 0, Duration = 0.1, Angle = 0 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0 },			
			{ ScreenPreWait = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.22, Duration = 0.22 },
		},
	},
	ProjectileSuit2 = 
	{
		InheritFrom = { "ProjectileSuit" },
	},
	ProjectileSuitDash = 
	{
		HitScreenshake = { Distance = 5, Speed = 300, FalloffSpeed = 1200, Duration = 0.35, Angle = 90 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.030, Fraction = 0.1, LerpTime = 0 },			
			{ ScreenPreWait = 0.012, Fraction = 1.0, LerpTime = 0.06 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.185, Duration = 0.34 },
		},
	},
	ProjectileSuitRangedUnguided = 
	{
		IsNotExProjectile = true,

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1000, Duration = 0.2, Angle = 90, ScreenPreWait = 0.08 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.18, Duration = 0.19 },
		},
	},
	ProjectileSuitRangedGuided = 
	{
		IsNotExProjectile = true,

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1000, Duration = 0.4, Angle = 90, ScreenPreWait = 0.08 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.22, Duration = 0.28 },
		},
	},
	ProjectileSuitRangedChargedUnguided = 
	{
		IsExProjectile = true,

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1000, Duration = 0.4, Angle = 90, ScreenPreWait = 0.08 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.22, Duration = 0.5 },
		},
	},
	ProjectileSuitRangedCharged = 
	{
		IsExProjectile = true,

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1000, Duration = 0.4, Angle = 90, ScreenPreWait = 0.08 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.22, Duration = 0.5 },
		},
	},
	ProjectileSuitCharged = 
	{
		OnCreationEvents = 
		{
			{ FunctionName = "LogProjectileSuitCharged" }
		},
		OnDeathEvents = 
		{
			{ FunctionName = "UnlogProjectileSuitCharged" }		
		}
	},

	ProjectileSuitBomb = 
	{
		IsExProjectile = true,
	},
	ProjectileSuitBombStraight = 
	{
		IsExProjectile = true,
	},
	
	ProjectileSuitGrenade = 
	{
		IsNotExProjectile = true,
	},
	
	ProjectileSuitGrenadeStraight = 
	{
		IsNotExProjectile = true,
	},

	WomboStrike =
	{
		DamageTextStartColor = Color.MorriganDamageLight,
		DamageTextColor = Color.MorriganDamage,

		IgnoreAllModifiers = true,
		HitScreenshake = { Distance = 5, Speed = 300, FalloffSpeed = 1200, Duration = 0.35, Angle = 180 },
		HitSimSlowCustomName = "WomboStrike",
		HitSimSlowCooldown = 1.01,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.01, LerpTime = 0 },			
			{ ScreenPreWait = 0.04, Fraction = 0.12, LerpTime = 0.06 },			
			{ ScreenPreWait = 0.16, Fraction = 1.00, LerpTime = 0.06 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.185, Duration = 0.34 },
		},

	},
	NyxSprintBlast =
	{
		DamageTextStartColor = Color.LightPurple,
		DamageTextColor = Color.Purple,

		HitScreenshake = { Distance = 5, Speed = 300, FalloffSpeed = 1200, Duration = 0.35, Angle = 90 },

		HitSimSlowCooldown = 1.01,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },			
			{ ScreenPreWait = 0.03, Fraction = 0.08, LerpTime = 0 },			
			{ ScreenPreWait = 0.05, Fraction = 1.00, LerpTime = 0.06 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.185, Duration = 0.34 },
		},
	},

	FamiliarLinkLaser = 
	{
		DamageTextStartColor = Color.DeepPink,
		DamageTextColor = Color.DarkMagenta,
	},

	-- Spell
	SpellSummonMelee =
	{

	},
	ProjectileSpellMiniMeteor =
	{

	},
	SpellLaserStartAoE =
	{

	},
	PolymorphNova =
	{
		SkipAggro = true
	},
	SpearWeaponSpin = 
	{
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
		IgnoreIndestructibleHitPresentation = true,
	},
	MedeaStatusStrike = 
	{
		DamageTextStartColor = Color.ForestGreen,
		DamageTextColor = Color.DarkGreen,
	},
	MorphDamageProjectile = 
	{

	}

})