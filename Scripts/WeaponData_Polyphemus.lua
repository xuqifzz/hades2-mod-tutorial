WeaponSetData =
{
	-- Polyphemus
	PolyphemusStomp =
	{
		Requirements =
		{
			MinPlayerDistance = 400,
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,
			NoProjectile = true,

			CreateOwnTargetFromOriginalTarget = true,
			PreAttackEndStop = true,

			PreAttackDumbFireWeapons = { "PolyphemusStompWave" },

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging",

			AttackDistance = 9999,
			MoveWithinRangeTimeout = 0.0,

			PreAttackAnimation = "Enemy_Polyphemus_StompPreFire",
			FireAnimation = "Enemy_Polyphemus_StompFire",
			--PostAttackAnimation = "Enemy_Polyphemus_StompReturnToIdle",
			PreAttackDuration = 1.03,
			FireDuration = 0.0,
			PostAttackDuration = 2.1,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.15,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 22 },
				},

				{ Cue = "/VO/Polyphemus_0043", Text = "Have some of this!" },
				{ Cue = "/VO/Polyphemus_0044", Text = "Here!" },
				{ Cue = "/VO/Polyphemus_0045", Text = "Want some of this?" },
				{ Cue = "/VO/Polyphemus_0046", Text = "Want some more?" },
				{ Cue = "/VO/Polyphemus_0047", Text = "I'll get you." },
				{ Cue = "/VO/Polyphemus_0048", Text = "You..." },
				{ Cue = "/VO/Polyphemus_0049", Text = "That's it!" },
				{ Cue = "/VO/Polyphemus_0050", Text = "This one's on me!" },
				{ Cue = "/VO/Polyphemus_0051", Text = "Eat this!" },
				{ Cue = "/VO/Polyphemus_0052", Text = "Chew on this!" },
				{ Cue = "/VO/Polyphemus_0053", Text = "You little..." },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/CaravanDamage" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 8, Speed = 600, Duration = 0.60, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusStompWave =
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
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						ProjectileName = "PolyphemusStompSmall_Poison",
					},
				},
			},

			AttackSlots =
			{
				{ OffsetDistance = 350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30, PauseDuration = 0.3 },

				{ OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -60 },
				{ OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30 },
				{ OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 60, PauseDuration = 0.3 },


				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -90 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -60 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 60 },
				{ OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 90, PauseDuration = 0.3 },


				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -90 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -75 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -60 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -45 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -15 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 15 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 45 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 60 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 75 },
				{ OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 90, PauseDuration = 0.3 },


				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -90 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -75 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -60 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -45 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -15 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 15 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 45 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 60 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 75 },
				{ OffsetDistance = 1350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 90, PauseDuration = 0.3 },


				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -90 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -75 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -60 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -45 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -30 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = -15 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 30 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 15 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 45 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 60 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 75 },
				{ OffsetDistance = 1600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetY = -75, OffsetAngle = 90 },
			},

			CreateOwnTargetFromOriginalTarget = true,

			PreAttackDuration = 1.03,

			ProjectileName = "PolyphemusStompSmall",
			FireProjectileAtTarget = true,
			SpawnFromMarker = "Polyphemus_Rig:toe_00_L_JNT",
		},
	},

	PolyphemusLeap =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "PolyphemusLeapTouchdown_Poison", AIDataOverrides = { FireProjectileTowardTarget = true } },
						},
					},
				},
			},

			ChargeSelfVelocity = 1000,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "PolyphemusLeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 1.2,
						Modifier = 0.1,
						HaltOnEnd = true,
					}
				},
			},

			AttackSlots =
			{
				{ ProjectileName = "PolyphemusLeapTouchdown", AIDataOverrides = { FireProjectileTowardTarget = true } },
			},

			CreateOwnTargetFromOriginalTarget = true,
			FireProjectileTowardTarget = true,
			PreAttackStop = true,
			Range = 500,

			MoveWithinRange = false,
			AttackDistance = 9999,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Polyphemus_LeapPreFire",
			PreFireAnimation = "Enemy_Polyphemus_LeapFire",
			FireAnimation = "Enemy_Polyphemus_LeapReturnToIdle",
			PreAttackDuration = 0.48,
			PreAttackEndMinWaitTime = 0.4,
			PreFireDuration = 0.97,
			FireDuration = 0.4,
			PostAttackDuration = 1.3,

			DumbFireWeapons = { "PolyphemusLeapKnockback" },

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				GameStateRequirements =
				{
					ChanceToPlay = 0.5,
				},
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 25 },
				},

				{ Cue = "/VO/Polyphemus_0225", Text = "Got something for ya!" },
				{ Cue = "/VO/Polyphemus_0226", Text = "This one's for you!" },
				{ Cue = "/VO/Polyphemus_0227", Text = "I hear you..." },
				{ Cue = "/VO/Polyphemus_0228", Text = "Heads up...", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0229", Text = "I squash you flat." },
				{ Cue = "/VO/Polyphemus_0230", Text = "Here, have another!" },
				{ Cue = "/VO/Polyphemus_0231", Text = "And, {#Emph}heave...!" },
				{ Cue = "/VO/Polyphemus_0532", Text = "Comin' at ya!" },
				{ Cue = "/VO/Polyphemus_0533", Text = "Up we go!" },
				{ Cue = "/VO/Polyphemus_0534", Text = "I'm hoppin' mad!" },
				{ Cue = "/VO/Polyphemus_0535", Text = "Get stomped." },
				{ Cue = "/VO/Polyphemus_0536", Text = "Get flat." },
				{ Cue = "/VO/Polyphemus_0537", Text = "Have a foot." },
				{ Cue = "/VO/Polyphemus_0538", Text = "Look out below!" },
				{ Cue = "/VO/Polyphemus_0539", Text = "I'll stomp ya." },
				{ Cue = "/VO/Polyphemus_0540", Text = "Watch my step." },
				{ Cue = "/VO/Polyphemus_0541", Text = "Kick ya." },
				{ Cue = "/VO/Polyphemus_0542", Text = "I'll flatten ya." },
				{ Cue = "/VO/Polyphemus_0543", Text = "Ground meat." },
			},
		},

		FireScreenshake = { Distance = 16, Speed = 400, Duration = 0.82, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusMegaLeap =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

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
								Value = 1,
							},
						}
					},
					Data =
					{
						PartnerForceWeaponInterrupt = "MedeaCastCombo1",
						SpawnerOptions = { "ZombieHeavyRanged_EM" },
					},
				},
			},

			ChargeSelfVelocity = 1500,
			ChargeSelfUpwardVelocity = 7000,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "PolyphemusLeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 1.2,
						Modifier = 0.1,
						HaltOnEnd = true,
					},
				},
			},

			ProjectileName = "PolyphemusMegaLeapTouchdown",

			PreAttackStop = true,
			Range = 10,
			BarrelLength = 180,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging",

			MoveWithinRange = false,
			AttackDistance = 9999,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Polyphemus_MegaLeap_Start",
			PreFireAnimation = "Enemy_Polyphemus_MegaLeap_Start2",
			FireAnimation = "Enemy_Polyphemus_MegaLeap_Fire",
			PreAttackDuration = 0.88,
			PreFireDuration = 0.70,
			FireDuration = 0,
			PostAttackDuration = 3.1,

			PreFireFx = "FallingCrusherShadowPolyphemus",

			SpawnBurstOnFire = true,
			SpawnBurstDelay = 0.15,
			SpawnRate = 0.4,
			SpawnOnSpawnPoints = true,
			SpawnRadiusMin = 400,
			SpawnRadius = 480,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "ZombieHeavyRanged" },
			SpawnAggroed = true,
			
			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PolyphemusSummonVoiceLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/CaravanDamage" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 16, Speed = 600, Duration = 0.82, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusMegaLeapElite =
	{
		InheritFrom = { "PolyphemusMegaLeap" },

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
								Value = 1,
							},
						}
					},
					Data =
					{
						PartnerForceWeaponInterrupt = "MedeaCastCombo2",
						SpawnerOptions = { "ZombieHeavyRanged_EM" },
					},
				},
			},

			SpawnerOptions = { "ZombieHeavyRanged" },
		},
	},

	PolyphemusLeapKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PolyphemusLeapKnockback",
			FireTicks = 7,
			FireInterval = 0.1,
			FireProjectileStartDelay = 0.4,

			NumProjectiles = 1,

			FireProjectileAtTarget = true,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 0,
			ResetTargetPerTick = true,
			PreAttackStop = false,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/Leftovers/SFX/CaravanDamage" },
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},
	},

	PolyphemusMarchKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PolyphemusLeapKnockback",
			FireTicks = 50,
			FireInterval = 0.1,
			FireProjectileStartDelay = 0,

			NumProjectiles = 1,

			FireProjectileAtTarget = true,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 0,
			ResetTargetPerTick = true,
			PreAttackStop = false,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/Leftovers/SFX/CaravanDamage" },
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},
	},

	PolyphemusBoulderThrow =
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
								Value = 1,
							},
						},
					},
					Data =
					{
						FireDuration = 0.65,
						AttackSlots =
						{
							{ UseAngleBetween = true, PauseDuration = 0.05 },
							{ UseAngleBetween = true, OffsetDistance = 300, OffsetAngle = -90, PauseDuration = 0.05 },
							{ UseAngleBetween = true, OffsetDistance = 300, OffsetAngle = 90, PauseDuration = 0.05 },
						},
					},
				},

				{
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						ProjectileName = "PolyphemusBoulder_Poison",
					},
				},
			},
			--ChargeSelfVelocity = 1500,
			FireSelfUpwardVelocity = 7000,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "PolyphemusLeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 1.2,
						Modifier = 0.1,
						HaltOnEnd = true,
					},
				},
			},

			ProjectileName = "PolyphemusBoulder",

			PreAttackFunctionName = "PolyphemusInterruptWeaponPresentation",

			CreateOwnTargetFromOriginalTarget = true,
			FireProjectileTowardTarget = true,

			AngleTowardsTargetWhileFiring = true,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			Range = 10,
			BarrelLength = 180,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging",

			MoveWithinRange = false,
			AttackDistance = 9999,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Polyphemus_BoulderThrow_Start",
			FireAnimation = "Enemy_Polyphemus_BoulderThrow_Fire",
			PostAttackAnimation = "Enemy_Polyphemus_BoulderThrow_End",

			PreAttackDuration = 1.0,
			FireDuration = 0.8,
			PostAttackDuration = 2.75,
			FireProjectileStartDelay = 0.35,

			PreAttackFx = "PolyphemusMeleeRPreAttackGlow",

			--PreFireFx = "FallingCrusherShadowPolyphemus",
			PreAttackVoiceLines =
			{
				Queue = "Interrupt",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.85,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "CyclopsThrewBoulderRecently", Time = 40 },
				},
				TriggerCooldowns = { "CyclopsSpokeRecently" },

				{ Cue = "/VO/Polyphemus_0224", Text = "Here, catch!" },
				{ Cue = "/VO/Polyphemus_0240", Text = "There...!" },
				{ Cue = "/VO/Polyphemus_0241", Text = "Ah-{#Emph}ha!", PlayFirst = true, },
				{ Cue = "/VO/Polyphemus_0242", Text = "{#Emph}Haaah!" },
				{ Cue = "/VO/Polyphemus_0243", Text = "Got you!" },
				{ Cue = "/VO/Polyphemus_0244", Text = "There you are." },
				{ Cue = "/VO/Polyphemus_0245", Text = "I {#Emph}see {#Prev}you." },
				{ Cue = "/VO/Polyphemus_0246", Text = "Shouldnt've done that!" },
				{ Cue = "/VO/Polyphemus_0417", Text = "Bad move!" },
				{ Cue = "/VO/Polyphemus_0418", Text = "Up we go!" },
				{ Cue = "/VO/Polyphemus_0419", Text = "Don't you get it?" },
				{ Cue = "/VO/Polyphemus_0420", Text = "Took the bait!" },
				{ Cue = "/VO/Polyphemus_0421", Text = "Here's something!" },
				{ Cue = "/VO/Polyphemus_0422", Text = "I'll flatten ya!" },
				{ Cue = "/VO/Polyphemus_0423", Text = "Get squashed!" },
				{ Cue = "/VO/Polyphemus_0424", Text = "Splat you like a bug!" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusRockThrowWhoosh" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteRanged" },
			},
		},

		FireScreenshake = { Distance = 16, Speed = 600, Duration = 0.82, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.8 },
	},

	PolyphemusSlam =
	{
		Requirements =
		{
			MaxPlayerDistance = 450,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						ProjectileName = "PolyphemusFistSlam_Poison",
					},
				},
			},

			ProjectileName = "PolyphemusFistSlam",
			--SpawnFromMarker = "Polyphemus_Rig:middle_00_R_JNT",
			BarrelLength = 150,
			FireProjectileStartDelay = 0.06,
			FireProjectileAtSelf = true,

			PreAttackEndStop = true,
			PreAttackAngleTowardTarget = false,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.40,
			PreAttackEndFlashFraction = 0.8,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging",

			AttackDistance = 550,
			StopMoveWithinRange = true,
			MoveWithinRangeTimeout = 0.0,
			SkipAttackIfMoveTimeout = true,

			PreAttackAnimation = "Enemy_Polyphemus_SlamPreFire",
			FireAnimation = "Enemy_Polyphemus_SlamFire",
			--PostAttackAnimation = "Enemy_Polyphemus_StompReturnToIdle",

			PreAttackDuration = 1.19,
			FireDuration = 0.3,
			PostAttackDuration = 2.5,
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlam" }, -- added to animation
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 10, Speed = 400, Duration = 0.25, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusSearch =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 5,
			RequireTotalAttacks = 5,
		},
		EquipRequirements =
		{
			WeaponHistoryMax =
			{
				PolyphemusSearch_Sick = 1,
				PolyphemusSearch_Zombie = 1,
				PolyphemusSearch_Explosive = 1,
			},
		},
		SkipInterruptIdle = true,

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			FireTicks = 2,
			FireInterval = 2.5,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.3,
			
			SpawnBurstPerTick = true,
			SpawnOnGroupName = "SheepSpawnPoints",
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 5,
			SpawnerOptions = { "Sheep" },
			SpawnBurstDelay = 1.5, -- space out the first aggro sound from VO

			InterruptOnDamaged = true,
			InterruptOnDamagedGracePeriod = 1.55,
			InterruptOnDamagedGracePeriodEnd = 4.5,

			PreAttackAnimation = "Enemy_Polyphemus_Listen",

			PreAttackVoiceLines =
			{
				Cooldowns =
				{
					{ Name = "CyclopsSearchedRecently", Time = 40 },
				},
				TriggerCooldowns = { "CyclopsSpokeRecently" },
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlay = 0.75,
					SuccessiveChanceToPlayAll = 0.5,

					{ Cue = "/VO/Polyphemus_0023", Text = "Where are you...?", PlayFirst = true },
					{ Cue = "/VO/Polyphemus_0024", Text = "Where are you..." },
					{ Cue = "/VO/Polyphemus_0025", Text = "No use hiding from me..." },
					{ Cue = "/VO/Polyphemus_0026", Text = "I'll find you..." },
					{ Cue = "/VO/Polyphemus_0027", Text = "Where'd you go...?" },
					{ Cue = "/VO/Polyphemus_0028", Text = "I know you're here..." },
					{ Cue = "/VO/Polyphemus_0029", Text = "Can't hide forever..." },
					{ Cue = "/VO/Polyphemus_0030", Text = "You're gonna pay..." },
					{ Cue = "/VO/Polyphemus_0412", Text = "You're out there somewhere..." },
					{ Cue = "/VO/Polyphemus_0413", Text = "Go on, just try me..." },
					{ Cue = "/VO/Polyphemus_0414", Text = "Oh when I find you..." },
					{ Cue = "/VO/Polyphemus_0031", Text = "Here, little sheep...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.2,
							},
						},
					},
					{ Cue = "/VO/Polyphemus_0032", Text = "Couldn'ta gone far...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.2,
							},
						},
					},
					{ Cue = "/VO/Polyphemus_0411", Text = "Oh look, I'm wide open!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.2,
							},
						},
					},
					{ Cue = "/VO/Polyphemus_0415", Text = "Don't leave me hanging here.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.2,
							},
						},
					},
					{ Cue = "/VO/Polyphemus_0416", Text = "Too damn noisy {#Emph}eh?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.2,
							},
						},
					},
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlayAll = 0.5,
					GameStateRequirements =
					{
						ChanceToPlay = 0.2,
					},

					{ Cue = "/VO/Polyphemus_0409", Text = "{#Emph}Dumm, dum, dun, dumm...",
						GameStateRequirements =
						{
							-- ChanceToPlay = 0.2,
							{
								PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutChronos01" }
							},
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.4,
							},
						}
					},
					{ Cue = "/VO/Polyphemus_0410", Text = "{#Emph}Dum, dumm, dum, dumm...",
						GameStateRequirements =
						{
							-- ChanceToPlay = 0.2,
							{
								PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutChronos01" }
							},
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
								Comparison = ">=",
								Value = 0.4,
							},
						}
					},
				}
			},

		},
	},

	PolyphemusSearch_Sick =
	{
		InheritFrom = { "PolyphemusSearch" },

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				SumOf = { "BossPolyphemus01", "BossPolyphemus02" },
				Comparison = ">=",
				Value = 4,
			},
		},
		EquipRequirements =
		{
			WeaponHistoryMax =
			{
				PolyphemusSearch = 1,
				PolyphemusSearch_Zombie = 1,
				PolyphemusSearch_Explosive = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			SpawnerOptions = { "Sheep_Sick" },
		},
	},

	PolyphemusSearch_Zombie =
	{
		InheritFrom = { "PolyphemusSearch_Sick" },
		
		EquipRequirements =
		{
			WeaponHistoryMax =
			{
				PolyphemusSearch = 1,
				PolyphemusSearch_Sick = 1,
				PolyphemusSearch_Explosive = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 1,
			FireInterval = 5.0,
			SpawnerOptions = { "Sheep_Zombie" },
		},
	},

	PolyphemusSearch_Explosive =
	{
		InheritFrom = { "PolyphemusSearch_Sick" },

		EquipRequirements =
		{
			WeaponHistoryMax =
			{
				PolyphemusSearch = 1,
				PolyphemusSearch_Sick = 1,
				PolyphemusSearch_Zombie = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 5,
			FireInterval = 1.0,
			MaxActiveSpawns = 8,
			SpawnerOptions = { "Sheep_Explosive" },
		},
	},

	PolyphemusGrab =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			RequireOneOfTypesWithinAttackDistance = { "Sheep", "Sheep_Zombie", "Sheep_Explosive", "Sheep_Sick" },
			RequireExistingIdsOfTypes = { "Sheep", "Sheep_Zombie", "Sheep_Explosive", "Sheep_Sick" },
			PreviousWeaponNot = { "PolyphemusMarch", },
		},

		AIData =
		{
			DeepInheritance = true,
			
			Using = { EffectName = "PolyphemusStomachAche" },

			TargetGroups = { "GroundEnemies", "FlyingEnemies" },
			TargetClosestOfTypes = { "Sheep", "Sheep_Zombie", "Sheep_Explosive", "Sheep_Sick" },

			PickupFx = "Blank",
			BeginPickupAnimation = "Enemy_Polyphemus_GrabPreFire",
			PickupAnimation = "Enemy_Polyphemus_GrabFire",
			PickupFailedAnimation = "Enemy_Polyphemus_GrabReturnUnsatisfied",
			BeginPickupDuration = 1.0,

			MoveWithinRange = false,

			PreAttackEndFunctionName = "PolyphemusPickup",
			HealTicksPerConsume = 6,
			HealPerTick = 100,
			HealTickInterval = 0.5,
			SetAnimationOnConsumeEnd = "Enemy_Polyphemus_GrabReturnSatisfied",

			NoProjectile = true,

			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.3,
			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmotePowerCharging",
			FireDuration = 0.0,
			PostAttackDuration = 3.0,
			PostAttackMinWaitTime = 2.7,
			
			TargetArcRange = 180,
			AttackDistance = 450,
			AttackDistanceScaleY = 0.6,
			MoveWithinRangeTimeout = 3.0,
			SkipAttackIfMoveTimeout = true,

			ForceUseIfReady = true,

			PreAttackVoiceLines =
			{
				Queue = "Interrupt",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.15,
				Cooldowns =
				{
					-- { Name = "CyclopsSpokeRecently", Time = 20 },
				},

				{ Cue = "/VO/Polyphemus_0040", Text = "Oh-{#Emph}hoh!" },
				{ Cue = "/VO/Polyphemus_0041", Text = "There!" },
				{ Cue = "/VO/Polyphemus_0250", Text = "Dinner!" },
				{ Cue = "/VO/Polyphemus_0251", Text = "Let's eat!" },
				{ Cue = "/VO/Polyphemus_0252", Text = "My favorite." },
				{ Cue = "/VO/Polyphemus_0253", Text = "Yum." },
				{ Cue = "/VO/Polyphemus_0254", Text = "Time for seconds." },
				{ Cue = "/VO/Polyphemus_0255", Text = "Chow time." },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging" },
				{ Name = "/Leftovers/World Sounds/QuickSnap" },
			},
		},
	},

	PolyphemusPlayerGrab =
	{
		Requirements = 
		{
			MaxPlayerDistance = 400,
			MaxPlayerDistanceScaleY = 0.6,
			MinAttacksBetweenUse = 7,
		},

		AIData =
		{
			DeepInheritance = true,

			PickupFx = "BloodlessGrenadierPotDropDust",
			BeginPickupAnimation = "Enemy_Polyphemus_GrabPreFire",
			BeginPickupDuration = 1.0,
			PickupAnimation = "Enemy_Polyphemus_GrabFire_Mel",
			PickupFailedAnimation = "Enemy_Polyphemus_GrabReturnUnsatisfied",
			AIPickupDuration = 3.5,

			PreAttackRotationDampening = 0.1,
			PreAttackRotationDampeningDuration = 99,
			PreAttackEndFunctionName = "PolyphemusPickup",

			NoProjectile = true,

			PreAttackDuration = 0.01,
			FireDuration = 0.0,
			PostAttackDuration = 3.0,
			PostAttackMinWaitTime = 2.7,
			PostAttackAnimation = "Enemy_Polyphemus_GrabReturnToss",
			
			TargetArcRange = 100,
			AttackDistance = 450,
			AttackDistanceScaleY = 0.6,
			MoveWithinRangeTimeout = 0.0,
			SkipAttackIfMoveTimeout = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging" },
				{ Name = "/Leftovers/World Sounds/QuickSnap" },
			},
		},
	},

	PolyphemusPlayerGrab_EM =
	{
		InheritFrom = { "PolyphemusPlayerGrab" },

		AIData =
		{
			DeepInheritance = true,
			BeginPickupDuration = 0.75,
		},
	},

	PolyphemusMarch =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,

			PreMoveDuration = 3.19,
			PreMoveAnimation = "Enemy_Polyphemus_March_Start",
			SetStopGraphicOnMove = "Enemy_Polyphemus_Move",
			PostAttackStop = true,
			PostAttackDuration = 2,

			NoProjectile = true,
			SkipFireWeapon = false,

			CreateOwnTargetFromOriginalTarget = true,
			UseAngleBetweenTarget = true,
			TargetOffsetDistance = 1000,
			DoNotRepeatOnAttackFail = true,

			AttackDistance = 1,
			MoveSuccessDistance = 1,
			MoveWithinRangeTimeout = 5.0,
			StopMoveWithinRange = false,

			--MoveDumbFireWeapons = { "PolyphemusMarchRadial", "PolyphemusMarchKnockback" },
			MoveDumbFireWeapons = { "PolyphemusMarchRadial" },

			SpawnBurstOnMove = true,
			SpawnBurstDelay = 1.0,
			SpawnRate = 0.5,
			SpawnOnSpawnPoints = true,
			SpawnRadiusMin = 220,
			SpawnRadius = 300,
			SpawnsPerBurstMin = 10,
			SpawnsPerBurstMax = 10,
			MaxActiveSpawns = 9,
			SpawnerOptions = { "Zombie" },
			SpawnAggroed = true,

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PolyphemusSummonVoiceLines" },
			},
		},

		--[[
		Sounds =
		{
			FireSounds =
			{
			},
		},
		]]--
	},

	PolyphemusMarchElite =
	{
		InheritFrom = { "PolyphemusMarch", },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
			MinAttacksBetweenUse = 15,
		},

		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "Zombie_Elite" },
		},
	},

	PolyphemusMarchRadial =
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
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						ProjectileName = "PolyphemusMarchRadial_Poison",
					},
				},
			},

			ProjectileName = "PolyphemusMarchRadial",
			AttackSlots =
			{
				{ OffsetFromAttacker = true, PauseDuration = 1.52, },
				{ OffsetFromAttacker = true, PauseDuration = 1.42, },
				{ OffsetFromAttacker = true, PauseDuration = 1.52, },
				{ OffsetFromAttacker = true, },
			},

			EndOnFlagName = "InTransition",

			FireProjectileStartDelay = 0.60,

			FireProjectileAtTarget = true,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 10,
			TargetOffsetDistanceMax = 20,
			ResetTargetPerTick = true,
			PreAttackStop = true,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/CaravanDamage" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 15, Speed = 600, Duration = 0.70, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusKick =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
			MinPlayerDistance = 450,
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						ProjectileName = "PolyphemusKick_Poison",
					},
				},
			},

			ProjectileName = "PolyphemusKick",
			FireSelfVelocity = 800,
			BarrelLength = 0,
			FireProjectileStartDelay = 0.125,

			CreateOwnTargetFromOriginalTarget = true,
			PreAttackEndStop = true,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			AttackDistance = 9999,
			MoveWithinRangeTimeout = 0.0,

			PreAttackSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteCharging",

			PreAttackAnimation = "Enemy_Polyphemus_KickPreFire",
			FireAnimation = "Enemy_Polyphemus_KickFire",
			PostAttackAnimation = "Enemy_Polyphemus_KickReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 0.6,
			PostAttackDuration = 1.0,
			FireFxOffset = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmoteAttacking" },
			},
		},
	},

	PolyphemusStompKickCombo =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 5,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "PolyphemusStomp", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.25 } },
			{ WeaponName = "PolyphemusKick", IgnoreRequirements = true, DataOverrides = { PreAttackAngleTowardTarget = false, PreAttackDuration = 0.55, PreAttackAnimationSpeed = 1.3, PostAttackMinWaitTime = 0.9, } },
		},
	},

	PolyphemusSwipe =
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
							PathFromSource = true,
							Path = { "ActiveEffects", "MedeaPoisonAllyBoost" },
							Comparison = ">=",
							Value = 1,
						},
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "PolyphemusSwipeL_Poison", },
							{ ProjectileName = "PolyphemusSwipeR_Poison", },
						},
					},
				},
			},

			AttackSlots =
			{
				{ ProjectileName = "PolyphemusSwipeL", },
				{ ProjectileName = "PolyphemusSwipeR", },
			},
			
			FireProjectileStartDelay = 0.11,
			FireProjectileAtSelf = true,

			PreAttackEndStop = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.3,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.40,
			PreAttackEndFlashFraction = 0.8,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/EmoteCharging",

			AttackDistance = 9999,
			StopMoveWithinRange = true,
			MoveWithinRangeTimeout = 0.0,
			SkipAttackIfMoveTimeout = true,

			PreAttackAnimation = "Enemy_Polyphemus_Swipe_Start",
			FireAnimation = "Enemy_Polyphemus_Swipe_Fire",
			--PostAttackAnimation = "Enemy_Polyphemus_StompReturnToIdle",

			PreAttackDuration = 0.8,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.25,
			FireDuration = 0.2,
			PostAttackDuration = 0.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		--FireScreenshake = { Distance = 10, Speed = 400, Duration = 0.25, FalloffSpeed = 3000, Angle = 90 },
	},

	PolyphemusMeleeCombo =
	{
		Requirements =
		{
			MaxPlayerDistance = 500,
			MinAttacksBetweenUse = 5,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},
		WeaponCombo =
		{
			{ WeaponName = "PolyphemusSwipe", IgnoreRequirements = true, },
			{ WeaponName = "PolyphemusSlam", IgnoreRequirements = true, DataOverrides = { AttackDistance = 9999, PreAttackDuration = 0.6, PreAttackAnimationSpeed = 0.7, PostAttackMinWaitTime = 2.25, } },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil