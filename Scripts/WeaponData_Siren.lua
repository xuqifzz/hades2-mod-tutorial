WeaponSetData =
{
	SirenDrummerSpotlightCombo =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		WeaponComboOnly = true,
		WeaponCombo =
		{
			"SirenDrummerBeatOpener",
			"SirenDrummerBeatClawMid",
			"SirenDrummerBeatSweepMid",
		},

		AIData =
		{
			ForceUseIfReady = true,
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},
	SirenDrummerSpotlightPassive =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		AIData =
		{
			DeepInheritance = true,

			ForceUseIfReady = true,
			MoveWithinRange = false,
			SkipFireWeapon = true,

			PreMoveFunctionName = "ScyllaFightTrackSpotlight",

			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 5.5,

			PostAttackEndMusicStemVolume = 0.85,
		},
	},

	SirenDrummerCircleCombo01 =
	{
		GenusName = "SirenDrummerCircle",
		AIData =
		{
			WeaponComboOnly = true,
			SkipFireWeapon = true,
			MoveWithinRange = false,

		},

		WeaponCombo =
		{
			"SirenDrummerCircle",
			"SirenDrummerCircleInverted",
			"SirenDrummerCircle",
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
			RequireTotalAttacks = 3,
		},
	},

	SirenDrummerCircleCombo02 =
	{
		GenusName = "SirenDrummerCircle",
		AIData =
		{
			WeaponComboOnly = true,
			SkipFireWeapon = true,
			MoveWithinRange = false,

		},

		WeaponCombo =
		{
			"SirenDrummerCircleInverted",
			"SirenDrummerCircle",
			"SirenDrummerCircleInverted",
		},

		Requirements =
		{
			MinPlayerDistance = 800,
			MinAttacksBetweenUse = 3,
			RequireTotalAttacks = 3,
		},
	},

	SirenDrummerCircle =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			TargetSelf = true,
			FireProjectileAtTarget = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenDrummerCircle",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenDrummerCircle",
					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			PreAttackFx = "SirenDrummerCircleLargePreview",
			EndPreAttackFx = true,
			PreAttackSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteAboutToExplode",

			PreAttackDuration = 2.0,
			FireDuration = 0.7,
			PostAttackDuration = 0.4,
			
			PreAttackAnimation = "Enemy_SirenDrummer_RumbleIntro",
			FireAnimation = "Enemy_SirenDrummer_RumbleFire",
			--PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",

			AttackDistance = 9999,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/LuciferBombExplosion" },
				{ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD" },
			},
		},
	},

	SirenDrummerCircleInverted =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			TargetSelf = true,
			FireProjectileAtTarget = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenDrummerCircleInverted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenDrummerCircleInvertedBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			PreAttackFx = "SirenDrummerInvertedCircle",
			EndPreAttackFx = true,

			PreAttackDuration = 4.0,
			FireDuration = 0.7,
			PostAttackDuration = 0.4,

			PreAttackAnimation = "Enemy_SirenDrummer_RumbleIntroSlow",
			--FireAnimation = "Enemy_SirenDrummer_RumbleFire",
			--PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",

			AttackDistance = 9999,

			--[[
			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ChanceToPlay = 0.1,
				ObjectType = "Scylla",
				Cooldowns =
				{
					{ Name = "ScyllaSpokeRecently", Time = 20 },
				},
			},
			]]--
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/LuciferBombExplosion" },
				{ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SirenDrummerBeatBounce =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SirenDrummerLob",
			MoveWithinRange = false,
			ImmuneToProjectileSlow = true,
			
			AttackSlots =
			{
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = -100, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = -50, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 5, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 33, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 50, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 80, FireProjectileAtTarget = true } },
			},

			TargetSelf = true,

			FireTicks = 5,
			FireInterval = 1,

			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 5.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroB",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopB",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	SirenDrummerBoostedLob =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SirenDrummerLobBoosted",
			MoveWithinRange = false,
			ImmuneToProjectileSlow = true,
			
			AttackSlots =
			{
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = -100, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = -50, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 5, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 33, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 50, FireProjectileAtTarget = true } },
				{ AnchorAngleOffset = 350, OffsetFromAttacker = true, AIDataOverrides = { FireProjectileAngleRelative = 80, FireProjectileAtTarget = true } },
			},

			FireTicks = 1,
			FireInterval = 1,

			TargetSelf = true,

			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 2.5,
			
			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroB",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopB",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatConeIn =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenDrummerBeat",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenDrummerBeatBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				},
			},

			ConditionalData =
			{
				{
					AIData =
					{
						PostAttackDurationMin = 3.5,
						PostAttackDurationMax = 4.0,
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "DrummerBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			MoveWithinRange = false,
			
			AttackSlots =
			{
				{ OffsetAngle = -45, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -15, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -60, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -45, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = 0, OffsetDistance = 0, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 0, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = -60, OffsetDistance = -800, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 60, OffsetDistance = -800, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			--NumProjectiles = 7,
			--ProjectileAngleInterval = 30,

			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDurationMin = 6.00,
			PostAttackDurationMax = 6.55,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	SirenDrummerBeatConeOut =
	{
		InheritFrom = { "SirenDrummerBeatConeIn" },
		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ OffsetAngle = 0, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = -60, OffsetDistance = -800, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 60, OffsetDistance = -800, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 0, OffsetDistance = 0, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -45, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -60, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 1750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -45, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -15, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
			},

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	SirenDrummerBeatCoralClose =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },

				{ OffsetAngle = 120, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 180, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 260, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 320, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.75 },

				{ OffsetAngle = 260, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.2 },
				{ OffsetAngle = 180, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.40 },

				{ OffsetAngle = -60, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 80, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 140, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.5,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MaxPlayerDistance = 1000,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatCoralFar =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 360, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },

				{ OffsetAngle = 336.25, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 312.5, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 288.75, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 265, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.75 },

				{ OffsetAngle = 265, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.2 },
				{ OffsetAngle = 284, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.40 },

				{ OffsetAngle = 303, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 322, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 341, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 360, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.5,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinPlayerDistance = 1000,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatClawClose =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 220, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 280, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 160, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 340, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 220, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 280, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 340, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 160, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },


				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 1.0 },
				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 160, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 220, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 280, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 340, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.5,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MaxPlayerDistance = 600,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatClawMid =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 0, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 1100, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 1100, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 45, OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -45, OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 1500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -15, OffsetDistance = 1500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 1100, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 1100, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = -30, OffsetDistance = 1200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -50, OffsetDistance = 1700, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 1200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 50, OffsetDistance = 1700, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 3.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinPlayerDistance = 500,
			MaxPlayerDistance = 1500,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatClawFar =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 265, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 360, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 265, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 360, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 284, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 341, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 284, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 341, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 303, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 322, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 303, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 322, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 284, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 341, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },
				{ OffsetAngle = 284, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 341, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },

				{ OffsetAngle = 265, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 360, OffsetDistance = 2500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },
				{ OffsetAngle = 265, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 360, OffsetDistance = 2000, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },

				{ OffsetAngle = 265, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 1.0 },
				{ OffsetAngle = 288.75, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 312.5, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 336.25, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 360, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 3.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinPlayerDistance = 1500,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatOpener =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 160, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 220, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 280, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 340, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = -60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -60, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -60, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = -40, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = -20, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 0, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 20, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 2750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 40, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 2750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 1.0 },
				{ OffsetAngle = 60, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },

				{ OffsetAngle = 340, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 1.0 },
				{ OffsetAngle = 280, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 220, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 160, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
			},

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinPlayerDistance = 500,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatOpenerMixed =
	{
		InheritFrom = { "SirenDrummerBeatOpener" },
		AIData =
		{
			DeepInheritance = true,

			RemoveAttackSlotCount = 5,
			RandomizeAttackSlotOrder = true,
		},
	},

	SirenDrummerBeatSweepMid =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeat",

			ChainedWeapon = "SirenDrummerBeatClawFar",
			
			AttackSlots =
			{
				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, PauseDuration = 1.0 },

				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, UseMapObjectId = 736951 },

				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, UseMapObjectId = 736952, PauseDuration = 1.0 },

				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, PauseDuration = 1.0 },

				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, UseMapObjectId = 736951 },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, UseMapObjectId = 736951 },

				{ OffsetX = -300, OffsetY = -150, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 200, OffsetY = 100, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 700, OffsetY = 350, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 1200, OffsetY = 600, OffsetFromAttacker = true, UseMapObjectId = 736952 },
				{ OffsetX = 1700, OffsetY = 850, OffsetFromAttacker = true, UseMapObjectId = 736952, },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenDrummerBeatSweepLeft =
	{
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "SirenDrummerBeat",
			
			AttackSlots =
			{
				{ OffsetAngle = 60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 40, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 40, OffsetDistance = 2750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 20, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 20, OffsetDistance = 2750, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = 0, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = -20, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -20, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = -40, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -40, OffsetDistance = 2500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },

				{ OffsetAngle = -60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -60, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -60, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.78 },
			},
			AttackSlotInterval = 0.0,

			FireProjectileAtTarget = true,

			PreAttackDuration = 0.38,
			FireDuration = 0.6,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.0,

			PreAttackAnimation = "Enemy_SirenDrummer_BeatIntroC",
			FireAnimation = "Enemy_SirenDrummer_BeatLoopC",
			PostAttackAnimation = "Enemy_SirenDrummer_BeatIntroA",
			
			AttackDistance = 9999,
		},

		Requirements =
		{
			MinPlayerDistance = 500,
			MinAttacksBetweenUse = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "DrummerBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	SirenKeytaristSpotlightCombo =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		WeaponComboOnly = true,
		WeaponCombo =
		{
			"SirenKeytaristPowerslide",
			"SirenKeytaristPowerslide",
			"SirenKeytaristPowerslide",
			"SirenKeytaristBounceBalls",
		},

		AIData =
		{
			ForceUseIfReady = true,
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},
	SirenKeytaristSpotlightPassive =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		AIData =
		{
			DeepInheritance = true,

			ForceUseIfReady = true,
			MoveWithinRange = false,
			SkipFireWeapon = true,

			PreMoveFunctionName = "ScyllaFightTrackSpotlight",

			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 5.5,

			PostAttackEndMusicStemVolume = 0.85,
		},
	},
	
	SirenKeytaristSurface =
	{
		GenusName = "SirenKeytaristDive",
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			MoveWithinRange = false,

			AttackDistance = 1000,
			WaitForAngleTowardTarget = true,
			TargetSpawnPoints = true,
			TargetSpawnPointsNearSelf = true,
			TargetSpawnPointsRadius = 250,
			TargetSpawnPointsType = "EnemyPointMelee",

			FireSelfUpwardVelocity = 2500,
			FireSelfVelocity = 700,

			PreAttackAnimation = "Enemy_SirenKeytar_Hidden",
			PreAttackAlpha = 0,
			PreAttackDurationMin = 1.5,
			PreAttackDurationMax = 2.5,
			FireFx = "WaterUnitSurface",
			FireAnimation = "Enemy_SirenKeytar_DiveResurface",
			FireAlpha = 1,
			FireDuration = 0.5,
			PostAttackDurationMin = 0.9,
			PostAttackDurationMax = 1.1,

			DoNotRepeatOnAttackFail = true,
			FireCreateHealthBar = true,

			RetreatAfterAttack = false,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	SirenKeytaristDive =
	{
		GenusName = "SirenKeytaristDive",
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			FireSelfUpwardVelocity = 2500,
			FireSelfVelocity = 700,

			PreAttackDuration = 0.0,
			PreAttackFx = "WaterTeleportStartFx",
			FireAnimation = "Enemy_SirenKeytar_Dive",
			FireFx = "WaterUnitSurface",
			FireDuration = 0.45,
			PostAttackAnimation = "Enemy_SirenKeytar_Hidden",
			PostAttackAlpha = 0,
			PostAttackDuration = 1.0,

			PostAttackTeleportToSpawnPoints = true,
			TeleportMinDistance = 500,
			TeleportMaxDistance = 99999,
			TeleportToSpawnPointType = "EnemyPointRanged",

			AttackDistance = 220,
			WaitForAngleTowardTarget = true,
			TargetSpawnPoints = true,
			TargetSpawnPointsNearSelf = true,
			TargetSpawnPointsRadius = 600,
			TargetSpawnPointsType = "EnemyPointRanged",

			PreAttackStop = true,
			StopMoveWithinRange = true,

			ChainedWeapon = "SirenKeytaristSurface",

			PostAttackRemoveEnemyUI = true,

			ForceFirst = true,

			RetreatAfterAttack = false,
		},


		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	SirenKeytaristShred =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenKeytaristSonic",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenKeytaristSonicBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			BarrelLength = 110,
			FireTicksMin = 12,
			FireTicksMax = 12,
			FireInterval = 0.1,
			--Spread = 5.0,

			PreAttackDuration = 1.2,
			PreAttackAnimationSpeed = 0.67,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.65,
			FireDuration = 0.0,
			PostAttackDuration = 1.2,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.065,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.065,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_SirenKeytar_ShredIntro",
			FireAnimation = "Enemy_SirenKeytar_ShredLoop",
			PostAttackAnimation = "Enemy_SirenKeytar_ShredReturnToIdle",

			FireFx = "SirenKeytaristShredFireFx",

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1550,
			RetreatTimeoutMin = 3.85,
			RetreatTimeoutMax = 4.65,

			AttackDistance = 410,
			LoSBuffer = 80,
			RequireUnitLoS = true,
		},

		Requirements =
		{

		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SirenKeytaristBoostedLob =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenKeytaristSonic",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenDrummerLobBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ConditionalData =
			{
				{
					AIData =
					{
						--TrackTargetDuringCharge = true,
						--PostAttackDuration = 0.15,
						--AttackDistance = 810,
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "RotationDamp",
					DataProperties = 
					{
						Duration = 999,
						RotationMultiplier = 0.045,
					}
				}
			},
			ClearWeaponFireEffectsOnFireEnd = true,
			ImmuneToProjectileSlow = true,

			BarrelLength = 110,
			FireTicksMin = 3,
			FireTicksMax = 3,
			FireInterval = 0.25,
			--Spread = 5.0,

			PreAttackDuration = 1.2,
			PreAttackAnimationSpeed = 0.67,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.65,
			FireDuration = 0.0,
			PostAttackDuration = 2.0,

			AngleTowardsTargetWhileFiring = true,
			TrackTargetDuringCharge = false,
			--WaitForAngleTowardTarget = true,

			--PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_SirenKeytar_ShredIntro",
			FireAnimation = "Enemy_SirenKeytar_ShredLoop",
			PostAttackAnimation = "Enemy_SirenKeytar_ShredReturnToIdle",

			FireFx = "SirenKeytaristShredFireFx",

			--[[
			MoveToRandomSpawnPoint = true,
			MoveToSpawnPointDistanceMin = 900,
			MoveToSpawnPointDistanceMax = 9999,
			MoveToSpawnPointType = "EnemyPoint",
			]]

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeoutMin = 3.5,
			RetreatTimeoutMax = 4.5,

			AttackDistance = 410,
			LoSBuffer = 80,
			RequireUnitLoS = true,

			--[[
			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ChanceToPlay = 0.1,
				ObjectType = "Scylla",
				Cooldowns =
				{
					{ Name = "ScyllaSpokeRecently", Time = 20 },
				},
				--
			},
			]]--
		},

		Requirements =
		{

		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SirenKeytaristPowerslide =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SirenKeytaristPowerslideMelee",
			FireProjectileStartDelay = 0.05,

			FireSelfVelocity = 1600,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "SirenKeytaristPowerslideGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.7,
						Modifier = 0,
						HaltOnEnd = true,
					},
				},
			},

			ConditionalData =
			{
				{
					AIData =
					{
						FireSelfVelocity = 2000,
						AttackDistance = 1100,
						AttackDistanceScaleY = 0.45,

						DumbFireWeapons = { "SirenKeytaristPowerslideEndDumbFire" },
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},
			
			--PreAttackFx = "AuraAimLineSirenKeytarist",
			--EndPreAttackFx = true,
			PreAttackSound = "/SFX/Enemy Sounds/Scylla/SirenPowerslideChargeup",

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.6,
			PreAttackDuration = 0.8,
			FireDuration = 0.6,
			PostAttackDuration = 0.0,

			AttackDistance = 675,
			AttackDistanceScaleY = 0.7,
			LoSBuffer = 160,
			RequireUnitLoS = true,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			StopBeforeFire = true,

			PreAttackAnimation = "Enemy_SirenKeytar_PowerslideIntro",
			FireAnimation = "Enemy_SirenKeytar_PowerslideLoop",
			--PostAttackAnimation = "Enemy_SirenKeytar_PowerslideReturnToIdle",

			ChainedWeapon = "SirenKeytaristPowerslideEnd",

			RetreatAfterAttack = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Scylla/SirenPowerslideAttackLong" },
			},
		},
		--[[
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "KeytaristBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		]]
	},
	SirenKeytaristPowerslideEnd =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "SirenKeytaristPowerslideWave",
					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "SirenKeytaristPowerslideWaveBoosted",
					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ConditionalData =
			{
				{
					AIData =
					{
						PostAttackDuration = 5.85,
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			FireProjectileStartDelay = 0.05,
			NumProjectiles = 12,
			ProjectileAngleInterval = 30,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 3.25,

			PostAttackAnimation = "Enemy_SirenKeytar_PowerslideReturnToIdle",

			AttackDistance = 9999,
			MoveWithinRange = false,

			RetreatAfterAttack = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/PoseidonCastSplash" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
	},
	SirenKeytaristPowerslideEndDumbFire =
	{
		InheritFrom = { "SirenKeytaristPowerslideEnd" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackAnimation = "nil",
		},
	},

	SirenKeytaristBounceBalls =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "KeytaristBounceBall",

			ConditionalProjectiles =
			{
				{
					ProjectileName = "KeytaristBounceBall",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "KeytaristBounceBallBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ConditionalData =
			{
				{
					AIData =
					{
						RetreatAfterAttack = false,
						PostAttackDurationMin = 1.75,
						PostAttackDurationMax = 2.00,
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "KeytaristBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.2,
			StopBeforeFire = true,

			NumProjectiles = 5,
			ProjectileInterval = 0.78,
			ProjectileAngleInterval = 0,
			
			PreAttackDuration = 0.3,
			FireDuration = 3.9,
			PostAttackDurationMin = 1.55,
			PostAttackDurationMax = 1.85,

			PreAttackAnimation = "Enemy_SirenKeytar_ShredIntro",
			FireAnimation = "Enemy_SirenKeytar_ShredLoop",
			PostAttackAnimation = "Enemy_SirenKeytar_ShredReturnToIdle",

			FireFx = "SirenKeytaristShredFireFx",
			
			AttackDistance = 1100,
			AttackDistanceScaleY = 0.40,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1600,
			RetreatTimeoutMin = 4.5,
			RetreatTimeoutMax = 5.5,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil