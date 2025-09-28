OverwriteTableKeys( ProjectileData, {

	-- Colors
	AphroditeColorProjectile =
	{
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
	},
	ApolloColorProjectile =
	{
		DamageTextStartColor = Color.ApolloDamageLight,
		DamageTextColor = Color.ApolloDamage,
	},
	AresColorProjectile =
	{
		DamageTextStartColor = Color.AresDamageLight,
		DamageTextColor = Color.AresDamage,
	},
	DemeterColorProjectile =
	{
		DamageTextStartColor = Color.DemeterDamageLight,
		DamageTextColor = Color.DemeterDamage,
	},
	HephaestusColorProjectile =
	{
		DamageTextStartColor = Color.HephaestusDamageLight,
		DamageTextColor = Color.HephaestusDamage,
	},
	HeraColorProjectile =
	{
		DamageTextStartColor = Color.HeraDamageLight,
		DamageTextColor = Color.HeraDamage,
	},
	HestiaColorProjectile =
	{
		DamageTextStartColor = Color.HestiaDamageLight,
		DamageTextColor = Color.HestiaDamage,
	},
	PoseidonColorProjectile =
	{
		DamageTextStartColor = Color.PoseidonDamageLight,
		DamageTextColor = Color.PoseidonDamage,
	},
	ZeusColorProjectile =
	{
		DamageTextStartColor = Color.ZeusDamageLight,
		DamageTextColor = Color.ZeusDamage,
	},

	-- Traits

	-- Aphrodite
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
		},
		IgnoreIndestructibleHitPresentation = true,
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
	AphroditeCastProjectile =
	{
		InheritFrom = { "AphroditeColorProjectile" },
		--[[
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamageTorches",
				Brick = "/SFX/BurnDamageTorches",
				Stone = "/SFX/BurnDamageTorches",
				Organic = "/SFX/BurnDamageTorches",
				StoneObstacle = "/SFX/BurnDamageTorches",
				BrickObstacle = "/SFX/BurnDamageTorches",
				MetalObstacle = "/SFX/BurnDamageTorches",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
		]]--
	},

	-- Apollo
	ApolloCast = 
	{
		InheritFrom = { "ApolloColorProjectile", },	
		IsExProjectile = true,
		IsAdditionalCastProjectile = true,
	},
	ApolloSingleCastStrike =
	{
		InheritFrom = { "ApolloColorProjectile", },
	},
	ApolloCastRapid =
	{
		InheritFrom = { "ApolloColorProjectile", },
	},
	ApolloRetaliateStrike =
	{
		InheritFrom = { "ApolloColorProjectile", },
	},

	-- Ares
	ProjectileAresSwordEx =
	{
		InheritFrom = { "AresColorProjectile", },
	},
	AresProjectile =
	{
		InheritFrom = { "AresColorProjectile" },

		IgnoreIndestructibleHitPresentation = true,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/AresBladeSlice2",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/AresBladeSlice2",
				Brick = "/SFX/AresBladeSlice2",
				Stone = "/SFX/AresBladeSlice2",
				Organic = "/SFX/AresBladeSlice2",
				StoneObstacle = "/SFX/AresBladeSlice2",
				BrickObstacle = "/SFX/AresBladeSlice2",
				MetalObstacle = "/SFX/AresBladeSlice2",
				BushObstacle = "/SFX/AresBladeSlice2",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	ProjectileAresSwordCast =
	{
		InheritFrom = { "AresColorProjectile" },
	},
	ProjectileAresSwordWake =
	{
		InheritFrom = { "AresColorProjectile" },
		IgnoreIndestructibleHitPresentation = true,
	},

	-- Demeter
	DemeterSprintStorm = 
	{
		InheritFrom = { "DemeterColorProjectile", },
		ImpactReactionHitsOverride = 0,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
		IgnoreIndestructibleHitPresentation = true,
		LifetimeSound = "/SFX/Player Sounds/DemeterBlizzardVortexSmall",
	},
	DemeterCastStorm = 
	{
		InheritFrom = { "DemeterColorProjectile" },
	},
	DemeterChillKill =
	{
		InheritFrom = { "DemeterColorProjectile", },
	},
	DemeterSprintDefense =
	{
		InheritFrom = { "DemeterColorProjectile", },
	},
	DemeterCastBlast =
	{
		InheritFrom = { "DemeterColorProjectile", },
	},

	-- Hephaestus
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
		SimSlowDistanceThreshold = 250,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.11, Fraction = 1.00, LerpTime = 0.50 },
		},
	},
	HephCastBlast =
	{
		InheritFrom = { "HephaestusColorProjectile" },
	},
	HephSprintBlast =
	{
		InheritFrom = { "HephaestusColorProjectile" },

		HitScreenshake = { Distance = 3, Speed = 400, Duration = 0.1, FalloffSpeed = 3000, Angle = 90 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.1, Duration = 0.12 },
		},

		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.11, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.06 },
		},
	},
	HephLeapBlast =
	{
		InheritFrom = { "HephaestusColorProjectile" },

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
	EncounterStartBuffWeapon =
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	PoseidonEffectFont =
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	-- Hera
	HeraDamageShareProjectile = 
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	ProjectileHeraOmega = 
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	HeraCastSummonProjectile =
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	HeraSprintProjectile =
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	HeraCastDamageProjectile =
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	-- Hestia
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
		IgnoreIndestructibleHitPresentation = true,
	},
	ProjectileFireball = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
	},
	HestiaBurnConsumeStrike = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		BlockCrit = true,
	},
	BurnNova = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
		SkipAggro = true,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamageTorches",
				Brick = "/SFX/BurnDamageTorches",
				Stone = "/SFX/BurnDamageTorches",
				Organic = "/SFX/BurnDamageTorches",
				StoneObstacle = "/SFX/BurnDamageTorches",
				BrickObstacle = "/SFX/BurnDamageTorches",
				MetalObstacle = "/SFX/BurnDamageTorches",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
	},
	ProjectileCastFireball = 
	{
		InheritFrom = { "HestiaColorProjectile", },
		CanIgnite = true,
	},
	-- Poseidon
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

		HitScreenshake = { Distance = 4, Speed = 400, Duration = 0.08, FalloffSpeed = 3000, DistanceThreshold = 310 },

		SimSlowDistanceThreshold = 310,
		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.025, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.060, Fraction = 1.00, LerpTime = 0.07 },
		},
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
		IgnoreIndestructibleHitPresentation = true,
	},
	PoseidonSprintSecondaryBlast = 
	{
		InheritFrom = { "PoseidonSprintBlast", },
	},
	PoseidonCast = 
	{
		InheritFrom = { "PoseidonColorProjectile", },
		IsExProjectile = true,
	},
	PoseidonOmegaWave = 
	{
		InheritFrom = { "PoseidonColorProjectile", },	
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000, DistanceThreshold = 200 },
		SimSlowDistanceThreshold = 200,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	ProjectilePotionBall =
	{
		InheritFrom = { "PoseidonColorProjectile", },
	},
	-- Zeus
	ZeusOnSpawn =
	{
		InheritFrom = { "ZeusColorProjectile", },
		IgnoreAllModifiers = true,
	},
	ProjectileZeusSpark =
	{
		InheritFrom = { "ZeusColorProjectile", },
		SelfMultiplier = 0,
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
					IsNone = { "F_MiniBoss01", "F_MiniBoss02", "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
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

		IgnoreIndestructibleHitPresentation = true,
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
	ZeusRetaliateStrike =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	ZeusPolymorphStrike =
	{
		InheritFrom = {"ZeusColorProjectile"}	
	},


	-- Other (Duo, etc.)
	DemeterMiniStorm = -- Apollo x Demeter
	{
		InheritFrom = { "ApolloColorProjectile", },	
	},
	ManaRestoreBlast = -- Hera x Hestia
	{
		InheritFrom = { "HeraColorProjectile", },	
		IgnoreDamageShare = true,
		BlockCrit = true,
	},
	SteamBlast = -- Hestia x Poseidon
	{
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		CancelArmorSpark = true,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamageTorches",
				Brick = "/SFX/BurnDamageTorches",
				Stone = "/SFX/BurnDamageTorches",
				Organic = "/SFX/BurnDamageTorches",
				StoneObstacle = "/SFX/BurnDamageTorches",
				BrickObstacle = "/SFX/BurnDamageTorches",
				MetalObstacle = "/SFX/BurnDamageTorches",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
	},
	ProjectileSprintBall = -- Apollo x Poseidon
	{

	},
	MassiveSlamBlastCast = -- Hephaestus x Poseidon
	{
		InheritFrom = { "HephaestusColorProjectile", },
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
})