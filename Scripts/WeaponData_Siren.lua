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
			SkipFireWeapon = true,

			PreMoveFunctionName = "ScyllaFightTrackSpotlight",

			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 5.5,

			PostAttackEndMusicStemVolume = 1.0,
		},
	},

	SirenDrummerCircleCombo01 =
	{
		GenusName = "SirenDrummerCircle",
		AIData =
		{
			WeaponComboOnly = true,
			SkipFireWeapon = true,

		},

		WeaponCombo =
		{
			{ WeaponOptions = { "SirenDrummerCircle", "SirenDrummerCircle_EM", }, },
			{ WeaponOptions = { "SirenDrummerCircleInverted", "SirenDrummerCircleInverted_EM", }, },
			{ WeaponOptions = { "SirenDrummerCircle", "SirenDrummerCircle_EM", }, },
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
		},

		WeaponCombo =
		{
			{ WeaponOptions = { "SirenDrummerCircleInverted", "SirenDrummerCircleInverted_EM", }, },
			{ WeaponOptions = { "SirenDrummerCircle", "SirenDrummerCircle_EM", }, },
			{ WeaponOptions = { "SirenDrummerCircleInverted", "SirenDrummerCircleInverted_EM", }, },
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
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			}
		},
		AIData =
		{
			DeepInheritance = true,

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

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/LuciferBombExplosion" },
				{ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD" },
			},
		},
	},

	SirenDrummerCircle_EM =
	{
		InheritFrom = { "SirenDrummerCircle", },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			}
		},
		AIData =
		{
			TargetSelf = "nil",
			PreAttackFx = "nil",
			PreAttackFxAtTarget = "SirenDrummerCircleLargePreview",
			FireProjectileAtTarget = true,
			FireFromTarget = true,
			TargetId = 793540,
		},
	},

	SirenDrummerCircleInverted =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			}
		},

		AIData =
		{
			DeepInheritance = true,

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

			AttackDistance = 9999,
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

	SirenDrummerCircleInverted_EM =
	{
		InheritFrom = { "SirenDrummerCircleInverted", },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			}
		},
		AIData =
		{
			TargetSelf = "nil",
			PreAttackFx = "nil",
			PreAttackFxAtTarget = "SirenDrummerInvertedCircle",
			FireProjectileAtTarget = true,
			FireFromTarget = true,
			TargetId = 793540,
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
					Data =
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

	SirenDrummerBeatConeIn_EM =
	{
		InheritFrom = { "SirenDrummerBeatConeIn", },
		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ OffsetAngle = -15, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -45, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -15, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

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

				{ OffsetAngle = 0, OffsetDistance = 300, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 0, OffsetDistance = -300, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = -80, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 80, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
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

	SirenDrummerBeatConeOut_EM =
	{
		InheritFrom = { "SirenDrummerBeatConeOut", },
		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{

				{ OffsetAngle = 0, OffsetDistance = 300, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 0, OffsetDistance = -300, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = -80, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 80, OffsetDistance = -600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

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

				{ OffsetAngle = -45, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -30, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = -15, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 45, OffsetDistance = 2600, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.759 },

				{ OffsetAngle = -15, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 0, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 30, OffsetDistance = 3200, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
			},
		},
	},

	SirenDrummerBeatCoralClose =
	{
		AIData =
		{
			DeepInheritance = true,
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
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = -45, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },

				{ OffsetAngle = -25, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = -5, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 15, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = 35, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.75 },

				{ OffsetAngle = 55, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.2 },
				{ OffsetAngle = 35, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.40 },

				{ OffsetAngle = 15, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = -5, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = -25, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.05 },
				{ OffsetAngle = -45, OffsetDistance = 1900, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.6 },
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
			ProjectileName = "SirenDrummerBeatBoosted",
			
			AttackSlots =
			{
				{ OffsetAngle = 55, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -45, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 55, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -45, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 35, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -25, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = 35, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -25, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = -5, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = 15, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },
				{ OffsetAngle = -5, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },

				{ OffsetAngle = 35, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -25, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },
				{ OffsetAngle = 35, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -25, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.18 },

				{ OffsetAngle = 55, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -45, OffsetDistance = 2200, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },
				{ OffsetAngle = 55, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true },
				{ OffsetAngle = -45, OffsetDistance = 1500, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 1.0 },

				{ OffsetAngle = 55, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, PauseDuration = 0.44 },
				{ OffsetAngle = 35, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = 15, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = -5, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = -25, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
				{ OffsetAngle = -45, OffsetDistance = 1750, OffsetScaleY = 0.5, OffsetFromAttacker = true, },
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

				{ OffsetAngle = 60, OffsetDistance = 550, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 1250, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
				{ OffsetAngle = 60, OffsetDistance = 2000, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, PauseDuration = 0.44 },

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

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 2,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, PauseDuration = 1.0 },

							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, UseMapObjectId = 800463 },

							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, UseMapObjectId = 800464, },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, UseMapObjectId = 800464, PauseDuration = 1.0 },

							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, PauseDuration = 1.0 },

							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, UseMapObjectId = 800463 },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, UseMapObjectId = 800463 },

							{ OffsetX = 200, OffsetY = -50, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -300, OffsetY = 200, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -800, OffsetY = 450, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -1300, OffsetY = 700, OffsetFromAttacker = true, UseMapObjectId = 800464 },
							{ OffsetX = -1800, OffsetY = 950, OffsetFromAttacker = true, UseMapObjectId = 800464, },
							{ OffsetX = -2300, OffsetY = 1200, OffsetFromAttacker = true, UseMapObjectId = 800464, PauseDuration = 1.0 },
						},
					},
				},
			},

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

			PostAttackEndMusicStemVolume = 1.0,
		},
	},
	
	SirenKeytaristSurface =
	{
		GenusName = "SirenKeytaristDive",
		BlockInterrupt = true,
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
	},

	SirenKeytaristDive =
	{
		GenusName = "SirenKeytaristDive",
		BlockInterrupt = true,
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

			ClearAllEffects = true,
			PostAttackEndTeleport = true,
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
	},


	SirenKeytaristDiveComboBreaker =
	{
		InheritFrom = { "SirenKeytaristDive", },
		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			WaitForAngleTowardTarget = false,
			TargetSpawnPoints = false,
			TargetSelf = true,
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
			WaitForAngleTowardTargetTimeOut = 1.0,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.065,
			TrackTargetDuringFire = true,
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
					Data =
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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.25,
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
					Data =
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

	SirenKeytaristPowerslideRetreat =
	{
		InheritFrom = { "SirenKeytaristPowerslide" },

		AIData =
		{
			DeepInheritance = true,

			CreateOwnTarget = true,
			TargetAngleOffset = 180,
			TargetOffsetDistance = 300,
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
					Data =
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
			WaitForAngleTowardTargetTimeOut = 1.0,
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