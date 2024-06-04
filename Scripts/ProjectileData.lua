ProjectileData = ProjectileData or {}
OverwriteTableKeys( ProjectileData, {
	NoShakeProjectile =
	{
		CancelCameraShake = true,
	},
	NoSlowFrameProjectile =
	{
		CancelSlowFrames = true,
	},

	-- Olympian Colors
	ZeusColorProjectile =
	{
		DamageTextStartColor = Color.ZeusDamageLight,
		DamageTextColor = Color.ZeusDamage,
	},
	AphroditeColorProjectile =
	{
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
	},
	DemeterColorProjectile =
	{
		DamageTextStartColor = Color.DemeterDamageLight,
		DamageTextColor = Color.DemeterDamage,
	},
	PoseidonColorProjectile =
	{
		DamageTextStartColor = Color.PoseidonDamageLight,
		DamageTextColor = Color.PoseidonDamage,
	},
	ApolloColorProjectile =
	{
		DamageTextStartColor = Color.ApolloDamageLight,
		DamageTextColor = Color.ApolloDamage,
	},
	DeflectedProjectileColor =
	{
		DamageTextStartColor = Color.ApolloDamageLight,
		DamageTextColor = Color.ApolloDamage,
	},
	HestiaColorProjectile =
	{
		DamageTextStartColor = Color.HestiaDamageLight,
		DamageTextColor = Color.HestiaDamage,
	},
	HephaestusColorProjectile =
	{
		DamageTextStartColor = Color.HephaestusDamageLight,
		DamageTextColor = Color.HephaestusDamage,
	},
	ArtemisColorProjectile =
	{
		DamageTextStartColor = Color.ArtemisDamageLight,
		DamageTextColor = Color.ArtemisDamage,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/GunBulletOrganicImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ProjectileCast = 
	{
		OnDeathFunctionName = "CastProjectileCleanup"
	},
	-- Olympian Weapons
	DemeterSprintStorm = 
	{
		InheritFrom = { "DemeterColorProjectile", },
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
	},
	PoseidonCollisionBlast = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonSplashSplinter = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonSprintBlast =
	{
		InheritFrom = { "PoseidonColorProjectile", },
		HitScreenshake = { Distance = 4, Speed = 1000, Duration = 0.10, FalloffSpeed = 3000 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.3, Duration = 0.18 },
		},

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.07 },
		},
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Brick = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Stone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Organic = "/Leftovers/World Sounds/PhysicalImpactPunch",
			},
		},
	},
	MassiveSlamBlast =
	{
		InheritFrom = { "HephaestusColorProjectile", },
		HitScreenshake = { Distance = 5, Speed = 600, Duration = 0.16, FalloffSpeed = 3000, Angle = 90 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.3, Duration = 0.18 },
		},
		HitSimSlowCustomName = "WeaponHitSlam",
		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.26, Fraction = 1.00, LerpTime = 0.50 },
		},
	},
	HephSprintBlast =
	{
		InheritFrom = { "MassiveSlamBlast" },
	},
	EncounterStartBuffWeapon =
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	HestiaSprintPuddle =
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
	},
	ProjectileFireball = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
	},
	HestiaBurnConsumeStrike = 
	{
		InheritFrom = { "HestiaColorProjectile", },
	},
	BurnNova = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
	},
	ShadeMercFireball = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
	},
	ProjectileZeusSpark =
	{
		InheritFrom = { "ZeusColorProjectile", },
		SelfMultiplier = 0,
	},

	ApolloCast = 
	{
		InheritFrom = { "ApolloColorProjectile", },	
		IsExProjectile = true,
		IsAdditionalCastProjectile = true,
	},
	PoseidonCast = 
	{
		InheritFrom = { "PoseidonColorProjectile", },	
		IsExProjectile = true,
	},
	ZeusSpecialStrike = 
	{
		InheritFrom = { "ZeusColorProjectile", },	
	},
	ZeusCastStrike = 
	{
		InheritFrom = { "ZeusColorProjectile", },	
		IsExProjectile = true,
		IsAdditionalCastProjectile = true,
		KillingEnemyVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.1,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_MiniBoss01", "F_MiniBoss02", "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
				},
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeCastSpeech", Time = 300 },
			},

			{ Cue = "/VO/MelinoeField_1381", Text = "Get shocked." },
			{ Cue = "/VO/MelinoeField_1382", Text = "Zeus take you.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1383", Text = "Struck down." },
		},

	},
	ZeusSprintStrike = 
	{
		InheritFrom = { "ZeusColorProjectile", },	
	},
	ZeusEchoStrike = 
	{
		InheritFrom = { "ZeusColorProjectile", },

		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.34, Angle = 90, DistanceThreshold = 280 },
		RumbleDistanceThreshold = 280,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.135, Duration = 0.22 },
		},

		SimSlowDistanceThreshold = 280,
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},	
	},
	ZeusZeroManaStrike =
	{
		InheritFrom = { "ZeusColorProjectile", },	
	},
	ProjectileCastFireball = 
	{
		CanIgnite = true,
	},
	CinderMeteorProjectile = 
	{
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 8,
			}
		}
	},
	AphroditeRushProjectile =
	{
		InheritFrom = { "AphroditeColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/AphroditeLoveImpact",
				Brick = "/SFX/Player Sounds/AphroditeLoveImpact",
				Stone = "/SFX/Player Sounds/AphroditeLoveImpact",
				Organic = "/SFX/Player Sounds/AphroditeLoveImpact",
			},
		}
	},
	AphroditeBurst =
	{
		InheritFrom = { "AphroditeColorProjectile" },

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.12, FalloffSpeed = 3000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	ApolloProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	ArtemisSupportingFire =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	ArtemisCastVolley =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	FrogFamiliarLand =
	{
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
	},
	CatFamiliarPounce =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/DaggerImpactWoodHard",
				Brick = "/SFX/DaggerImpactWoodSoft",
				Stone = "/SFX/DaggerImpactWoodSoft",
				Organic = "/SFX/DaggerImpactOrganic",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},

	RangedWeapon =
	{
		AmmoDropKillForceMin = 900,
		AmmoDropKillForceMax = 950,
		AmmoDropKillUpwardForceMin = 300,
		AmmoDropKillUpwardForceMax = 300,
	},

	-- Enemy weapons
	TreantBackstab =
	{
		ClearEffect = "Rooted"
	},


	-- Minos unused trap weapons
	RubbleColorProjectile =
	{
		DamageTextStartColor = Color.WallSlamDamageLight,
		DamageTextColor = Color.WallSlamDamage,
	},
	RubbleFall =
	{
		InheritFrom = { "RubbleColorProjectile" },

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 150.0,
			},
			{
				ObstacleMultiplier = 0.0,
			},
		}
	},
	RubbleFallLarge =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	RubbleFallElysium =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	BaseFireZone =
	{
		IgnoreOnHitEffects = true,
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	LavaTileWeapon =
	{
		IgnoreOnHitEffects = true,
		DamagedFx = "PlayerBurnDamage",
	},

	LavaTileTriangle01Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaTileTriangle02Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaPuddleLarge =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	Miasma = 
	{
		ExpireOldestCap = 16,
		BypassRetaliate = true,
	},
	ArtemisSniperBolt =
	{
		HealthTickDamage = 999,
	},
	ProjectileStaffBall = 
	{	
		--[[
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.08, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.38, Fraction = 1.0, LerpTime = 0.07 },
		},
		]]

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
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
			},
		},
	},
	ProjectileStaffBallCharged =
	{
		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1,

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
				Bone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Brick = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Stone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Organic = "/Leftovers/World Sounds/PhysicalImpactPunch",
			},
		},
	},
	DestructibleTreeSplinter =
	{
		HitPresentationIgnoresOwnership = true,
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0.0 },
			--{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.10 },
		},
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},
	},
	DestructibleMastSplinter =
	{
		HitPresentationIgnoresOwnership = true,
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0.0 },
			--{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.10 },
		},
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 10,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},
	},

	ProjectileTorchBall = 
	{
		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		HitScreenshake = { Distance = 4, Speed = 200, FalloffSpeed = 2000, Duration = 0.15, DistanceThreshold = 330 },

		--[[
		SimSlowDistanceThreshold = 130,
		HitSimSlowCooldown = 0.34,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.35, LerpTime = 0.00 },
			{ ScreenPreWait = 0.02, Fraction = 1.00, LerpTime = 0.10 },
		},
		]]
	},

	ProjectileTorchBallLarge = 
	{
		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

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

	ProjectileTorchExplosion = 
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
	ProjectileTorchSpiral = 
	{
		--HitScreenshake = { Distance = 2, Speed = 150, FalloffSpeed = 1000, Duration = 0.1, DistanceThreshold = 110 },
	},
	ProjectileTorchOrbit = 
	{
		--HitScreenshake = { Distance = 4, Speed = 200, FalloffSpeed = 0, Duration = 0.1, Angle = 90, DistanceThreshold = 110 },
	},

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

	ProjectileSkullImpulseWave = 
	{
		InheritFrom = { "ProjectileThrowCharged" },
	},
	
	HecateTorchRing =
	{
		HealthTickDamage = 0,
	},
	HecatePolymorph =
	{
		OnDeathNoVictimFunctionName = "GenericPresentation",
		OnDeathNoVictimFunctionArgs =
		{
			ThreadedVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				ObjectType = "Hecate",
				Cooldowns =
				{
					{ Name = "HecateRecentHexDodgeVO", Time = 240 },
				},
				TriggerCooldowns = { "HecateSpokeRecently" },

				{ Cue = "/VO/HecateField_0133", Text = "Eluded..." },
				{ Cue = "/VO/HecateField_0134", Text = "How did that miss..." },
				{ Cue = "/VO/HecateField_0135", Text = "That never used to miss...", PlayFirst = true },
				{ Cue = "/VO/HecateField_0136", Text = "So much for that..." },
			},
		},
	},
	HecateMeteor =
	{
		HitScreenshake = { Distance = 6, Speed = 600, Duration = 0.16, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateMeteorSmall =
	{
		HitScreenshake = { Distance = 4, Speed = 500, Duration = 0.11, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateLaser =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateLaser2 =
	{
		InheritFrom = { "HecateLaser" },
	},
	HecateLaser3 =
	{
		InheritFrom = { "HecateLaser" },
	},
	MageRanged2 =
	{
		ExpireOldestCap = 22,
	},
	ChasingVines =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},
	},
	ChasingVinesElite =
	{
		InheritFrom = { "ChasingVines" },
	},
	MineBlast =
	{
		HealthTickDamage = 10,
	},
	
	ArtemisHealVolleyShot =
	{
		OnDeathFunctionName = "ArtemisHealDrop",
		DropSound = "/SFX/GodAppearFlash",
	},

	ProjectileAxeBlockSpin =
	{
		IgnoreOnHitEffects = false,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
		CancelUnitShake = true,
		CancelCameraShake = true,
	},

	ProjectileAxeBlock2 = 
	{
		HitScreenshake = { Distance = 6, Speed = 800, Duration = 0.07, FalloffSpeed = 2500, Angle = 90 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.07, RightFraciton = 0.35, Duration = 0.35 },
		},
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
	SmokeTrapWeapon = 
	{
		OnHitFunctionNames = { "HitBySmokeTrapWeaponPresentation",  },
	},
	LavaTileWeapon = 
	{
		OnHitFunctionNames = { "CheckLavaPresentation", },
	},
	DevotionHephaestus =
	{
		OnHitFunctionNames = { "AddEnemyHitShield",  },
	},
	TimeTrapStasis =
	{
		Fuse = 0.25,
		--ReticleAnimation = "BlastWarningDecal",
	},

	FieldsDestructiblePillarDestruction =
	{
		KillingEnemyVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			ChanceToPlay = 0.2,
			--SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapKillSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1141", Text = "Stay far away." },
			{ Cue = "/VO/MelinoeField_1142", Text = "Don't you come near me." },
			{ Cue = "/VO/MelinoeField_1252", Text = "Out with you all...!" },
			{ Cue = "/VO/MelinoeField_1253", Text = "Lie in ruin." },
			{ Cue = "/VO/MelinoeField_1254", Text = "Back off." },
			{ Cue = "/VO/MelinoeField_1255", Text = "Back." },
		},
	},

	ThugSlamWave =
	{
		ProjectileFireSound = "/Leftovers/SFX/AuraThrowLarge",
	},
})