OverwriteTableKeys( WeaponData, 
{
	-- Unused Minos Trap Weapons
	ExplosiveBlast =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	BlastCubeExplosion =
	{
		ImpactReactionHitsOverride = 5,
	},

	BlastCubeExplosionElysium =
	{
		ImpactReactionHitsOverride = 5,
	},

	DartTrapWeapon =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/SwordWallHitClankSmall",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
			},
		},
	},

	ArcherTrapWeapon =
	{
		PresentationOnlyOnPlayerHit = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/SwordWallHitClankSmall",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
			},
		},		
	},
	
	RubbleFall =
	{
		StartingWeapon = false,
		BlockWrathGain = true,

		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},

		Upgrades = { },
		HitText = "RubbleSlamHit",
		KillText = "RubbleSlamKill",

		ImpactSounds =
		{
			Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Bone = "/SFX/ArrowMetalBoneSmash",
			Brick = "/SFX/ArrowMetalStoneClang",
			Stone = "/SFX/ArrowMetalStoneClang",
			Organic = "/SFX/ArrowImpactSplatter",
			StoneObstacle = "/SFX/ArrowWallHitClankSmall",
			BrickObstacle = "/SFX/ArrowWallHitClankSmall",
			MetalObstacle = "/SFX/ArrowWallHitClankSmall",
			BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
		},
		OnDestroyVoiceLines =
		{
			-- [1] = GlobalVoiceLines.RubbleKillVoiceLines,
		},
	},

	RubbleFallLarge =
	{
		InheritFrom = { "RubbleFall", },
		BlockWrathGain = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
})