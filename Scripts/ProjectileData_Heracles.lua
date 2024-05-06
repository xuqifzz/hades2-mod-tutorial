OverwriteTableKeys( ProjectileData, {
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
				Organic = "/SFX/StabSplatterSmall",
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
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		}
	},
})