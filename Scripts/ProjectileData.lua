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
				Organic = "/SFX/DaggerThrowImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},
	DionysusColorProjectile =
	{
		DamageTextStartColor = Color.DionysusDamageLight,
		DamageTextColor = Color.DionysusDamage,
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
	PoseidonOmegaProjectile = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonCollisionBlast = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonSplashSplinter = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonCastSplashSplinter = 
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
				StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
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
		InheritFrom = { "HephaestusColorProjectile" },

		HitScreenshake = { Distance = 3, Speed = 400, Duration = 0.1, FalloffSpeed = 3000, Angle = 90 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.1, Duration = 0.12 },
		},
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

	ZeusOnSpawn =
	{
		InheritFrom = { "ZeusColorProjectile", },
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
	ApolloRetaliateStrike =
	{

	},
	DemeterMiniStorm =
	{
		InheritFrom = { "ApolloColorProjectile", },	-- Apollo x Demeter duo
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
		IsAdditionalCastProjectile = true,
		CancelRumble = true,
		CancelCameraShake = true,
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
	ZeusRootStrike = 
	{
		InheritFrom = { "ZeusColorProjectile", },	
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

		--[[
		SimSlowDistanceThreshold = 280,
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},	
		]]
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
	ProjectileCastLob =
	{
		InheritFrom = { "DionysusColorProjectile" },
	},
	IcarusExplosion =
	{

	},

	IcarusArmorExplosion =
	{

	},

	LinkNova =
	{

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
	RavenFamiliarMelee =
	{
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

	RavenFamiliarMelee_Crit =
	{
		InheritFrom = { "RavenFamiliarMelee" },
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
				NonPlayerMultiplier = 20.0,
			},
			{
				ObstacleMultiplier = 0.0,
			},
		},

		KillingEnemyVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				PreLineWait = 0.45,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.1,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Health" },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I_MiniBoss01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "MelinoeTrapKillSpeech", Time = 80 },
				},
				TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

				{ Cue = "/VO/MelinoeField_2199", Text = "You'll rot here." },
				{ Cue = "/VO/MelinoeField_2201", Text = "Die with your master!" },
				{ Cue = "/VO/MelinoeField_2202", Text = "I'll bury you." },
				{ Cue = "/VO/MelinoeField_2200", Text = "Hades take you!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
						},
					}
				},
			},
		},
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
		OnHitFunctionNames = { "CheckLavaPresentation", },
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
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
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
	IcicleSplinter =
	{

	},
	FireBarrelFireLob =
	{

	},
	SoulPylonSpiritball =
	{

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
	ProjectileTorchExplosionLarge = 
	{
		IsExProjectile = true,
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
	ProjectileTorchRepeatStrike = 
	{
		IsExProjectile = true,
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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateTorchRingPhase =
	{
		InheritFrom = { "HecateTorchRing" },
	},

	HecateMelee1 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	HecateMelee2 =
	{
		InheritFrom = { "HecateMelee1" },
	},

	HecateTorchCone =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateRangedSmallSpirals =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateRangedSmall =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	HecateMeleeCone =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
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

	CerberusVacuum =
	{
		BypassRetaliate = true,
	},

	ProjectileAxeBlockSpin =
	{
		IgnoreOnHitEffects = false,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
		CancelUnitShake = true,
		CancelCameraShake = true,
	},

	ProjectileAxeSpecial = 
	{
		--HitScreenshake = { Distance = 6, Speed = 800, Duration = 0.07, FalloffSpeed = 2500, Angle = 90 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.07, RightFraciton = 0.35, Duration = 0.15 },
		},
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

	NyxSprintBlast =
	{
		DamageTextStartColor = Color.LightPurple,
		DamageTextColor = Color.Purple,

		HitScreenshake = { Distance = 5, Speed = 300, FalloffSpeed = 1200, Duration = 0.35, Angle = 90 },

		HitSimSlowCooldown = 1.01,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.12, LerpTime = 0 },			
			{ ScreenPreWait = 0.25, Fraction = 1.00, LerpTime = 0.06 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.185, Duration = 0.34 },
		},
	},
	SmokeTrapWeapon = 
	{
		OnHitFunctionNames = { "HitBySmokeTrapWeaponPresentation",  },
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

	TreantRanged =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
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

	RubbleFallOlympus =
	{
		SkipAggro = true,
		HitScreenshake = { Distance = 4, Speed = 400, Duration = 0.25, FalloffSpeed = 3000 },
		ImpactReactionHitsOverride = 0,

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 3.0,
			},
			{
				ObstacleMultiplier = 0.0,
			},
		},
	},

	TentacleSpike =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.25, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TentacleSlamWave =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.25, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	CharybdisRanged =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	CharydisRangedTransport =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	EagleSwoop =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	EagleSweep =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	EagleFlyUpWhirlwind =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	AutomatonBeamBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonOrbit =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	AutomatonMeleeArcLeft =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonMeleeArcRight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonWhirlwind =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonWhirlwind_Elite =
	{
		InheritFrom = { "AutomatonWhirlwind" },
	},

	HarpySlice =
	{
		HitScreenshake = { Distance = 4, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.11, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HarpySlice2 =
	{
		HitScreenshake = { Distance = 4, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.11, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrRocket =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrSapperLob =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrSapperMelee =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrCrossbow2Bolt =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SentryBotBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.09, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SentryBotExplosion =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.09, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.11, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreathGround =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreathGround_Miniboss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreath_MiniBoss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonTailWhip =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonGlideGround =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonGlideGround_Miniboss =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonTailWhip_Miniboss =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowLeft =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowRight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowStraight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldSpin =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosMagnet =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.25, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.13, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TalosPunch =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0 },
			{ ScreenPreWait = 0.30, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TalosFire =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.015, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.035, Fraction = 1.0, LerpTime = 0 },
		},
	},

	PrometheusGroundPound =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.32, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusGroundPoundNova =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.35, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusKick =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.33, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.46, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusKickFireWave =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusPunch =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.21, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFlurry =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusUppercut =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusUppercutWhirlwind =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFireCircle =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFirePillar =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.31, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusSkyCast =
	{
		Fuse = 3.2,
		ReticleAnimation = "PrometheusSkyCastPreview_In",
		ReticleGroupName = "FX_Terrain",
		AttachToTarget = true,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusMagicCircle =
	{
		Fuse = 4.0,
		ReticleAnimation = "PrometheusMagicCirclePreview",
	},
	PrometheusMagicCircleInverted =
	{
		Fuse = 4.0,
		ReticleAnimation = "PrometheusMagicCircleInvertedPreview",
	},
	PrometheusMemory_P2 =
	{
		Fuse = 4.2,
		ReticleAnimation = "PrometheusMemoryReticle",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusMemory_P3 =
	{
		Fuse = 7,
		ReticleAnimation = "PrometheusMemoryReticle",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusUppercutWhirlwindVacuum =
	{
		BypassRetaliate = true,
	},
	
	EliteBoltOrbit =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	HeroSkyTouchdown =
	{
		HealthTickDamage = 999,
		SkipDamageText = true,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.11, Fraction = 0.37, Duration = 0.38 },
		},

		HitScreenshake = { Distance = 8, Speed = 400, Angle = 90, FalloffSpeed = 1000, Duration = 0.38 },
		
		SimSlowDistanceThreshold = 290,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.10 },
		},
	},
})