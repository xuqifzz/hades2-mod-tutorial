OverwriteTableKeys( ProjectileData, {

	-- Artemis
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
	ArtemisSupportingFire =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	ArtemisCastVolley =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	ArtemisVolleyShot =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	ArtemisSniperBolt =
	{
		HealthTickDamage = 999,
	},
	ArtemisHuntersMark =
	{

	},
	ArtemisHealVolleyShot =
	{
		OnDeathFunctionName = "ArtemisHealDrop",
		DropSound = "/SFX/GodAppearFlash",
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	-- Nemesis
	NemesisAttack1 =
	{

	},
	NemesisAttack2 =
	{

	},
	NemesisAttack3 =
	{

	},
	NemesisSpecial =
	{

	},

	-- Dionysus
	DionysusColorProjectile =
	{
		DamageTextStartColor = Color.DionysusDamageLight,
		DamageTextColor = Color.DionysusDamage,
	},
	ProjectileCastLob =
	{
		InheritFrom = { "DionysusColorProjectile" },
	},

	-- Athena
	AthenaColorProjectile =
	{
		DamageTextStartColor = Color.AthenaDamageLight,
		DamageTextColor = Color.AthenaDamage,
	},
	DeflectedProjectileColor =
	{
		DamageTextStartColor = Color.AthenaDamageLight,
		DamageTextColor = Color.AthenaDamage,
	},
	AthenaLandingNova =
	{
		InheritFrom = { "AthenaColorProjectile" },
	},
	AthenaCastProjectile =
	{
		InheritFrom = { "AthenaColorProjectile" },
	},
	AthenaRushProjectile =
	{
		InheritFrom = { "AthenaColorProjectile" },
		IgnoreIndestructibleHitPresentation = true,
	},
	AthenaDeflectingProjectile =
	{
		InheritFrom = { "AthenaColorProjectile" },
	},
	ProjectileAthenaManaSpear =
	{
		InheritFrom = { "AthenaColorProjectile" },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.10 },
		},
	},

	-- Heracles
	HeraclesArcLeft = 
	{
		TriggersPlayerOnHitPresentation = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.16, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 1.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	HeraclesArcRight = 
	{
		TriggersPlayerOnHitPresentation = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.16, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 1.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.00, LerpTime = 0.04 },
		},

		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		}
	},

	HeraclesLeap = 
	{
		TriggersPlayerOnHitPresentation = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.16, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 1.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.00, LerpTime = 0.04 },
		},

		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		}
	},

	-- Icarus
	IcarusBombardment =
	{
		ReticleAnimation = "LobWarningDecalIris_Icarus",

		Fuse = 2.25,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},	
	IcarusBombardment_Small =
	{
		InheritFrom = { "IcarusBombardment" },
		HitScreenshake = "nil",
	},
	IcarusBombardment_Large =
	{
		InheritFrom = { "IcarusBombardment" },
		HitScreenshake = "nil",
		AttachToTarget = true,
	},
	IcarusHazardExplosion = 
	{
		SelfMultiplier = 0,
		SelfDamage = true,
		ReticleAnimation = "LobWarningDecalIcarus",
	},
	IcarusExplosion =
	{

	},
	IcarusArmorExplosion =
	{

	},

	-- Hades
	HadesUrnDeath =
	{

	},

	-- Zagreus
	ZagreusSpearStab1 =
	{

	},
	ZagreusSpearStab2 =
	{

	},
	ZagreusSpearStab3 =
	{

	},
	ZagreusSpearSpin =
	{

	},
	ZagreusSpearRush =
	{
		
	},
	ZagreusCast =
	{
		OnDeathFunctionName = "HandleStoredProjectileDeath",
		AmmoDropProjectile = "AmmoDrop",
		StoredAmmoVulnerabilityMultiplier = 1.5,
	},
})