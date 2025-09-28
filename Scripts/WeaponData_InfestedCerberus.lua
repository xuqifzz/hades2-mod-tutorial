WeaponSetData =
{
	InfestedCerberusForwardBite =
	{
		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "InfestedCerberusRam", PauseDuration = 0.1 },
				{ ProjectileName = "InfestedCerberusWaveLarge", AIDataOverrides = { BarrelLength = 200, FireProjectileAngleRelative = 0, }  },
			},

			FireProjectileStartDelay = 0.1,

			ChargeSelfVelocity = 3500,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackHighGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.4,
						Modifier = 1.3,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackAnimationSpeed = 0.6,
			PreAttackDuration = 1.2,
			FireDuration = 0.65,
			PostAttackDuration = 0.8,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.45,
			PreAttackEndFlashFraction = 0.6,

			AttackDistance = 1600,
			RequireUnitLoS = true,
			LoSBuffer = 300,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_ChargeGrowl",
			PreAttackAnimation = "Enemy_InfestedCerberus_ForwardBitePreFire",
			FireAnimation = "Enemy_InfestedCerberus_ForwardBiteFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_ForwardBitePostFire",

			MoveWithinRange = true,
			WaitForAngleTowardTarget = true,
			PostAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, Duration = 0.2, FalloffSpeed = 1000, Angle = 0, ScreenPreWait = 0.02 },
	},

	InfestedCerberusLungeTurn =
	{
		Requirements =
		{
			MinPlayerArc = 100,
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			PreAttackAngleTowardTarget = false,
			ProjectileName = "CerberusLungeKnockback",

			ChargeSelfVelocity = 3900,

			PreAttackDuration = 0.67,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.14,
			FireDuration = 0.65,
			PostAttackDuration = 1.1,

			TrackTargetDuringFire = true,
			PostAttackStop = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			
			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_ChargeGrowl",
			PreAttackAnimation = "Enemy_InfestedCerberus_ForwardBitePreFire",
			FireAnimation = "Enemy_InfestedCerberus_LungeTurn",
			PostAttackAnimation = "Enemy_InfestedCerberus_ForwardBitePostFire",

			ChainedWeaponOptions = { "InfestedCerberusSwipe", "InfestedCerberus_C_Breath", },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
			},
		},
	},

	InfestedCerberusSwipe =
	{
		Requirements =
		{
			MinPlayerArc = 0,
			MaxPlayerArc = 75,
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,
			MoveWithinRange = false,

			AttackSlots =
			{
				{ ProjectileName = "InfestedCerberusSwipe", AIDataOverrides = { }, PauseDuration = 0.06 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = -60, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.0 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = -45, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.01 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = -30, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.01 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = -15, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.01 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = 0, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.015  },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = 15, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.015  },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = 30, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.015  },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = 45, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.015 },
				{ ProjectileName = "InfestedCerberusWave", AIDataOverrides = { BarrelLength = 550, FireProjectileAngleRelative = 60, SpawnFromMarker = "InfestedCerberus_Rig:handGhostG_01_R_JNT", }, PauseDuration = 0.015  },
			},

			PreAttackDuration = 1.06,
			FireDuration = 0.55,
			PostAttackDuration = 1.8,
			FireProjectileStartDelay = 0.08,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			AttackDistance = 965,
			AttackDistanceBuffer = 375,
			
			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_SwipePreFire",
			FireAnimation = "Enemy_InfestedCerberus_SwipeFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_SwipePostFire",

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.45,
			PreAttackEndFlashFraction = 0.6,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, Duration = 0.2, FalloffSpeed = 1000, Angle = 0, ScreenPreWait = 0.02 },
	},

	InfestedCerberusTurnSlam =
	{
		Requirements =
		{
			MinPlayerArc = 100,
			MaxPlayerArc = 360,
			MinAttacksBetweenUse = 4,
			MaxPlayerDistance = 700,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "CerberusTurnSlam", AIDataOverrides = { FireProjectileAngleRelative = 0, SpawnFromMarker = "InfestedCerberus_Rig:handGhostC_01_R_JNT" }  },
				{ ProjectileName = "CerberusTurnSlam", AIDataOverrides = { FireProjectileAngleRelative = 0, SpawnFromMarker = "InfestedCerberus_Rig:handSqz_01_L_JNT" }  },
			},

			FireProjectileStartDelay = 0.15,

			CreateOwnTarget = true,
			TargetAngleOffset = 180,
			TargetOffsetDistance = 1000,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.3,

			PreAttackDuration = 1.15,
			PreAttackAnimationSpeed = 0.35,
			FireDuration = 0.60,
			PostAttackDuration = 1.7,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_TurnHopPreFire",
			FireAnimation = "Enemy_InfestedCerberus_TurnHopFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},

		FireScreenshake = { Distance = 8, Speed = 700, Duration = 0.4, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.48 },
	},

	InfestedCerberusPoundL =
	{
		Requirements =
		{
			MaxPlayerDistance = 900,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "InfestedCerberusPound",
			SpawnFromMarker = "InfestedCerberus_Rig:handGhostC_01_L_JNT",

			FireProjectileStartDelay = 0.18,

			PreAttackDuration = 0.77,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.225,
			FireDuration = 0.45,
			PostAttackDuration = 1.7,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.6,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_PoundLPreFire",
			FireAnimation = "Enemy_InfestedCerberus_PoundLFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_PoundLPostFire",

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
								Value = 3,
							},
						},
					},
					Data =
					{
						ProjectileName = "InfestedCerberusPoundMagma",
					},
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},

		FireScreenshake = { Distance = 8, Speed = 700, Duration = 0.8, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.48 },
	},

	InfestedCerberusPoundR =
	{
		InheritFrom = { "InfestedCerberusPoundL" },
		AIData =
		{
			DeepInheritance = true,
			SpawnFromMarker = "InfestedCerberus_Rig:hand_01_R_JNT",

			PreAttackAnimation = "Enemy_InfestedCerberus_PoundRPreFire",
			FireAnimation = "Enemy_InfestedCerberus_PoundRFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_PoundRPostFire",

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
								Value = 3,
							},
						},
					},
					Data =
					{
						ProjectileName = "InfestedCerberusPoundMagma",
					},
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_ChargeGrowl" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},

		FireScreenshake = { Distance = 8, Speed = 700, Duration = 0.8, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.48 },
	},

	InfestedCerberusHyperPoundR1 =
	{
		InheritFrom = { "InfestedCerberusPoundR" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.34,
			PreAttackAnimationSpeed = 2.26,

			PostAttackDurationMin = 0.1,
			PostAttackDurationMax = 0.5,

			ChainedWeaponOptions = { "InfestedCerberusHyperPoundL1" },
		},
	},

	InfestedCerberusHyperPoundL1 =
	{
		InheritFrom = { "InfestedCerberusPoundL" },
		Requirements =
		{
			-- none
		},
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.34,
			PreAttackAnimationSpeed = 2.26,

			PostAttackDurationMin = 1.1,
			PostAttackDurationMax = 1.5,
		},
	},

	InfestedCerberusHyperPoundR2 =
	{
		InheritFrom = { "InfestedCerberusPoundR" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.34,
			PreAttackAnimationSpeed = 2.26,

			PostAttackDurationMin = 0.1,
			PostAttackDurationMax = 0.1,

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "CerberusMeleeRotationDampener",
					DataProperties = 
					{
						Duration = 1,
						RotationMultiplier = 0.20,
					},
				}
			},
			--ClearPreAttackStartEffectsOnFireEnd = true,

			FireSelfVelocity = 2250,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},
			ClearWeaponFireEffectsOnFireEnd = true,
		},
	},

	InfestedCerberusHyperPoundL2 =
	{
		InheritFrom = { "InfestedCerberusPoundL" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.34,
			PreAttackAnimationSpeed = 2.26,

			PostAttackDurationMin = 0.1,
			PostAttackDurationMax = 0.1,

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "CerberusMeleeRotationDampener",
					DataProperties = 
					{
						Duration = 1,
						RotationMultiplier = 0.20,
					},
				}
			},
			ClearPreAttackStartEffectsOnFireEnd = true,

			FireSelfVelocity = 2250,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},
			ClearWeaponFireEffectsOnFireEnd = true,
		},
	},

	InfestedCerberusHyperPoundL2Final =
	{
		InheritFrom = { "InfestedCerberusHyperPoundL2" },
		AIData =
		{
			PostAttackDurationMin = 2.0,
			PostAttackDurationMax = 2.3,
		},
	},

	InfestedCerberusPoundCombo =
	{
		Requirements =
		{
			MaxPlayerDistance = 2000,
			MinAttacksBetweenUse = 14,
		},
		WeaponComboOnly = true,
		WeaponCombo =
		{
			{ WeaponName = "InfestedCerberusHyperPoundR2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundL2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundR2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundL2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusLungeTurn",
				IgnoreRequirements = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredShrineLevel",
						FunctionArgs =
						{
							ShrineUpgradeName = "BossDifficultyShrineUpgrade",
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				DataOverrides =
				{
					PreAttackAngleTowardTarget = true,
					WaitForAngleTowardTarget = true,
					WaitForAngleTowardTargetTimeOut = 0.2,
					PreAttackDuration = 0.335,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackAnimationSpeed = 2.0,
					PostAttackDuration = 0.2,
					ChainedWeaponOptions = {},
				},
			},
			{ WeaponName = "InfestedCerberusHyperPoundR2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundL2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundR2", IgnoreRequirements = true, },
			{ WeaponName = "InfestedCerberusHyperPoundL2Final", IgnoreRequirements = true, },
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 15000,
		},
	},

	InfestedCerberus_C_Breath =
	{
		Requirements =
		{
			MinPlayerDistance = 1200,
			MinPlayerDistanceScaleY = 0.6,
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "InfestedCerberusBreath",
			FireProjectileStartDelay = 0.21,
			NumProjectiles = 90,
			ProjectileInterval = 0.05,
			Spread = 8,
			SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_M_JNT",
			BarrelLength = 50,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.09,
			PostAttackStop = true,

			PreAttackDuration = 1.0,
			FireDuration = 5.6,
			PostAttackDuration = 2.0,

			AttackDistance = 3000,

			SoundManagerCap = 30,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_C_BreathPreAttack",
			FireAnimation = "Enemy_InfestedCerberus_C_BreathFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_C_BreathPostFire",

			PreAttackVoiceLines =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.15, },
					},
				},
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					PreLineWait = 1.6,
					SuccessiveChanceToPlayAll = 0.75,
					SuccessiveChanceToPlay = 0.15,
					GameStateRequirements =
					{
						-- { FunctionName = "RequiredHealthFraction", FunctionArgs = { Comparison = "<=", Value = 0.8, }, },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
					Cooldowns =
					{
						{ Name = "MelinoeCerberusFireReactionVO", Time = 120 },
					},
					{ Cue = "/VO/MelinoeField_1229", Text = "{#Emph}Erm...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2127", Text = "No not the breath...!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1229" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2128", Text = "I'm out in the open!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_2127" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1228", Text = "Not good...!" },
					{ Cue = "/VO/MelinoeField_1230", Text = "Incoming...!" },
					{ Cue = "/VO/MelinoeField_1235", Text = "Down, boy!" },
					{ Cue = "/VO/MelinoeField_1237", Text = "Whoa!" },
				},
			},

		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" },
			},
		},
	},
	InfestedCerberusFireStream_Short =
	{
		InheritFrom = { "InfestedCerberus_C_Breath" },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseAttackerAngle = true, AIDataOverrides = { SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_L_JNT", } },
				{ UseAttackerAngle = true, AIDataOverrides = { SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_M_JNT", } },
				{ UseAttackerAngle = true, AIDataOverrides = { SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_R_JNT", } },
			},

			RandomizeAttackSlotOrder = true,
			AttackSlotInterval = 0.05,
			ProjectileInterval = 0.1,
			FireProjectileNoDestination = true,
			FireProjectileAngleRelative = 0,
			NumProjectiles = 10,
			Spread = 15,

			SpawnFromMarker = "nil",

			PreAttackRotationDampening = 0.2,
			FireRotationDampening = 0.14,

			FireDuration = 1.1,
		},
	},

	InfestedCerberusFireStreamLungeCombo =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "InfestedCerberusFireStream_Short", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.2} },
			{ WeaponName = "InfestedCerberusLungeTurn", IgnoreRequirements = true, DataOverrides = { PreAttackDuration = 0.335, PreAttackEndMinWaitTime = "nil", PreAttackStartMinWaitTime = "nil", PreAttackAnimationSpeed = 2.0, PostAttackDuration = 0.2, ChainedWeaponOptions = {}, } },
			{ WeaponName = "InfestedCerberusFireStream_Short", IgnoreRequirements = true, DataOverrides = { PreAttackDuration = 0.2, PreAttackAnimationSpeed = 5.0 } },
		},
	},

	InfestedCerberusFireBallCombo =
	{
		Requirements =
		{
			MinPlayerDistance = 500,
		},
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"InfestedCerberusFireBallL",
			"InfestedCerberusFireBallC",
			"InfestedCerberusFireBallR",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 15000,
			--MinAttacksBetweenUse = 3,
		},
	},

	InfestedCerberusFireBallCombo2 =
	{
		Requirements =
		{
			--MinPlayerDistance = 500,
			MaxPlayerDistance = 1500,
		},
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"InfestedCerberusFireBallC2",
			"InfestedCerberusFireBallC2",
			"InfestedCerberusFireBallC2",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 15000,
			--MinAttacksBetweenUse = 3,
		},
	},

	InfestedCerberusFireBallL =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "InfestedCerberusExplosiveFireball",
			FireProjectileStartDelay = 0.21,
			SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_01_L_JNT",
			BarrelLength = 50,

			PreAttackAnimationSpeed = 1.3,
			PreAttackDuration = 0.8,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.25,
			FireDuration = 0.3,
			PostAttackDuration = 0.3,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackEndFlashFraction = 0.45,

			AttackDistance = 3000,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_L_BreathPreAttack",
			FireAnimation = "Enemy_InfestedCerberus_L_BreathFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_L_BreathPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteRangedAttacking" },
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_FurballCough" },
			},
		},
	},

	InfestedCerberusFireBallC =
	{
		InheritFrom = { "InfestedCerberusFireBallL" },
		AIData =
		{
			DeepInheritance = true,
			SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_M_JNT",

			PreAttackAnimation = "Enemy_InfestedCerberus_C_BreathPreAttack",
			FireAnimation = "Enemy_InfestedCerberus_C_BreathFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_C_BreathPostFire",
		},
	},

	InfestedCerberusFireBallR =
	{
		InheritFrom = { "InfestedCerberusFireBallL" },
		AIData =
		{
			DeepInheritance = true,
			SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_01_R_JNT",

			PostAttackDuration = 1.2,

			PreAttackAnimation = "Enemy_InfestedCerberus_R_BreathPreAttack",
			FireAnimation = "Enemy_InfestedCerberus_R_BreathFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_R_BreathPostFire",
		},
	},

	InfestedCerberusFireBallC2 =
	{
		InheritFrom = { "InfestedCerberusFireBallL" },
		AIData =
		{
			DeepInheritance = true,
			SpawnFromMarker = "InfestedCerberus_Rig:lowerTeeth_00_M_JNT",

			PreAttackAnimation = "Enemy_InfestedCerberus_C_BreathPreAttack",
			FireAnimation = "Enemy_InfestedCerberus_C_BreathFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_C_BreathPostFire",

			ProjectileName = "InfestedCerberusExplosiveFireball2",
			NumProjectiles = 3,
			Spread = 75,
		},
	},

	InfestedCerberusVacuumC =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
			MinPlayerDistance = 500,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CerberusVacuum",
			BarrelLength = 200,

			FireProjectileStartDelay = 0.35,

			PreAttackAnimationSpeed = 1.5,
			PreAttackDuration = 0.5,
			PreAttackEndMinWaitTime = 0.42,
			FireDuration = 1.35,
			PostAttackDuration = 0.3,

			AttackDistance = 2000,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_VacuumPreFire",
			FireAnimation = "Enemy_InfestedCerberus_VacuumFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_VacuumPostFire",

			ChainedWeaponOptions = { "InfestedCerberusHyperPoundL1", "InfestedCerberusHyperPoundR1" },
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" },
			},
		},
	},

	InfestedCerberusCircles =
	{
		GenusName = "InfestedCerberusHowl",
		SkipWeaponCount = true,
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
								Comparison = "<",
								Value = 3,
							},
						}
					},
					Data =
					{
						PreAttackDuration = 0.25,
						PreAttackAnimationSpeed = 2.0,
						FireDuration = 0.3,
						PostAttackDuration = 0.4,
						PreAttackAnimation = "Enemy_InfestedCerberus_BarkPreFire",
						FireAnimation = "Enemy_InfestedCerberus_BarkFireLoop",
						PostAttackAnimation = "Enemy_InfestedCerberus_BarkPostFire",
					},
				},
			},

			--[[
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
			]]
			FireProjectileAtTarget = true,

			ImmuneToProjectileSlow = true,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_ChargeGrowl",

			PreAttackAngleTowardTarget = false,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteHowling" },
			},
		},
	},

	InfestedCerberusCirclesP1_Intro =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		GenusName = "InfestedCerberusHowl",

		Requirements =
		{
			MaxUses = 1,
			RequireTotalAttacks = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 950, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	InfestedCerberusCircleSelectorP1 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
			RequireTotalAttacks = 7,
		},
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			SkipFireWeapon = true,
			AttackDistance = 99999,

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
								Value = 3,
							},
						}
					},
					Data =
					{
						NoProjectile = true,
						ChainedWeaponOptions =
						{
							"InfestedCerberusCirclesP1_Far",
							"InfestedCerberusCirclesP1_Spiral",
							"InfestedCerberusCirclesP1_Rotating",
							"InfestedCerberusCirclesP1_Player",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"InfestedCerberusCirclesP1_Close",
				"InfestedCerberusCirclesP1_Far",
				"InfestedCerberusCirclesP1_Spiral",
				"InfestedCerberusCirclesP1_Rotating",
				"InfestedCerberusCirclesP1_Player",
			},
		},
	},

	InfestedCerberusCirclesP1_Close =
	{
		InheritFrom = { "InfestedCerberusCircles" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 72, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 144, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 216, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 288, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	InfestedCerberusCirclesP1_Far =
	{
		InheritFrom = { "InfestedCerberusCircles" },
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
								Value = 3,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
							{ ProjectileName = "CerberusSkyProjectile", Angle = 72, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
							{ ProjectileName = "CerberusSkyProjectile", Angle = 144, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
							{ ProjectileName = "CerberusSkyProjectile", Angle = 216, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
							{ ProjectileName = "CerberusSkyProjectile", Angle = 288, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
						},
					},
				},
			},
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 45, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 90, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 135, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 225, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 270, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 315, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	InfestedCerberusCirclesP1_Spiral =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		GenusName = "InfestedCerberusHowl",
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = -45, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 45, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.75 },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 75, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 165, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.75 },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 195, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 285, AnchorAngleOffset = 1700, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true },
			},
		},
	},

	InfestedCerberusCirclesP1_Rotating =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		GenusName = "InfestedCerberusHowl",
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 120, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 120, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 240, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 240, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromAttacker = true },
			},
			PostAttackDuration = 0.5,

			PreAttackVoiceLines =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.18, },
					},
				},
				{
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					PreLineWait = 1.25,
					SuccessiveChanceToPlay = 0.15,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 25 },
					},
					{ Cue = "/VO/MelinoeField_1234", Text = "Easy now...!" },
					{ Cue = "/VO/MelinoeField_1236", Text = "Easy, boy!" },
					{ Cue = "/VO/MelinoeField_1238", Text = "Calm yourself...!" },
				},
			},

		},
	},

	InfestedCerberusCirclesP1_Player =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48,  },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48,  },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 800, OffsetRadius = 0, OffsetScaleY = 0.48,  },
			},
		},
	},

	InfestedCerberusCirclesBackGuard =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 600, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 260, AnchorAngleOffset = 1500, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 100, AnchorAngleOffset = 1500, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1, },

				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 1800, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 220, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 140, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1, },
			},
		},
	},

	InfestedCerberusCircleSelectorP2 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			SkipFireWeapon = true,
			AttackDistance = 99999,

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
								Value = 3,
							},
						},
					},
					Data =
					{
						NoProjectile = true,
						ChainedWeaponOptions =
						{
							"InfestedCerberusCirclesP2_Close",
							"InfestedCerberusCirclesP2_Mid",
							"InfestedCerberusCirclesP2_Player",
							"InfestedCerberusCirclesP2_Cone",
							"InfestedCerberusCirclesP2_Scatter",
							--"InfestedCerberusCirclesP2_Spiral",
							"InfestedCerberusCirclesP2_Rotating",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"InfestedCerberusCirclesP2_Close",
				"InfestedCerberusCirclesP2_Mid",
				"InfestedCerberusCirclesP2_Player",
				"InfestedCerberusCirclesP2_Cone",
				"InfestedCerberusCirclesP2_Scatter",
				"InfestedCerberusCirclesP2_Spiral",
				"InfestedCerberusCirclesP2_Rotating",
			},
		},
	},

	InfestedCerberusCirclesP2_Close =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 60, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 120, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 240, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 300, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	InfestedCerberusCirclesP2_Mid =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 45, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 90, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 135, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 225, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 270, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 315, AnchorAngleOffset = 1900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	InfestedCerberusCirclesP2_Player =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetScaleY = 0.48, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 72, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 144, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 216, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 288, AnchorAngleOffset = 1300, OffsetRadius = 0, OffsetScaleY = 0.48, },
			},
		},
	},

	InfestedCerberusCirclesP2_Cone =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1, },

				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 1600, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 60, AnchorAngleOffset = 1600, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 300, AnchorAngleOffset = 1600, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1, },

				{ ProjectileName = "CerberusSkyProjectile", Angle = 30, AnchorAngleOffset = 2200, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 330, AnchorAngleOffset = 2200, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1, },

				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 2900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 60, AnchorAngleOffset = 2900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 300, AnchorAngleOffset = 2900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },

			},
		},
	},

	InfestedCerberusCirclesP2_Scatter =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,

			RandomizeAttackSlotOrder = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626601, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626573, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626575, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 702572, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626681, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626707, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 723317, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 723339, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 723326, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626646, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626701, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 723323, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626594, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626617, PauseDuration = 0.1, },
				{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 626641, PauseDuration = 0.1, },
			},

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
								Value = 3,
							},
						},
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739185, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739198, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739193, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739188, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739828, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739810, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739806, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739804, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739799, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739798, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739795, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739790, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739786, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739784, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739780, PauseDuration = 0.1, },
							{ ProjectileName = "CerberusSkyProjectile", AnchorAngleOffset = 0, UseMapObjectId = 739814, PauseDuration = 0.1, },
						},
					},
				},
			},
		},
	},

	InfestedCerberusCirclesP2_Spiral =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectile", Angle = 0, AnchorAngleOffset = 900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 25, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 65, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 90, AnchorAngleOffset = 900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 115, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 155, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 180, AnchorAngleOffset = 900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 205, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 245, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 270, AnchorAngleOffset = 900, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 295, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },
				{ ProjectileName = "CerberusSkyProjectile", Angle = 335, AnchorAngleOffset = 2000, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromOriginalAttackerPosition = true, PauseDuration = 0.2, },

			},
		},
	},

	InfestedCerberusCirclesP2_Rotating =
	{
		InheritFrom = { "InfestedCerberusCircles" },
		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 0, AnchorAngleOffset = 3600, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 120, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 120, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 120, AnchorAngleOffset = 3600, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 240, AnchorAngleOffset = 1200, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 240, AnchorAngleOffset = 2400, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
				{ ProjectileName = "CerberusSkyProjectileRotating", Angle = 240, AnchorAngleOffset = 3600, OffsetRadius = 0, OffsetFromOriginalAttackerPosition = true },
			},
		},
	},

	InfestedCerberusCirclesP1_EM =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			EndOnFlagName = "InTransition",

			DumbFireWakeUpDelayMin = 9,
			DumbFireWakeUpDelayMax = 11,

			DumbFireIntervalMin = 9,
			DumbFireIntervalMax = 11,

			DumbFireWeapons = { "InfestedCerberusCircleSelectorP1" },
		},
	},

	InfestedCerberusCirclesP2_EM =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			EndOnFlagName = "InTransition",

			DumbFireWakeUpDelayMin = 9,
			DumbFireWakeUpDelayMax = 11,

			DumbFireIntervalMin = 9,
			DumbFireIntervalMax = 11,

			DumbFireWeapons = { "InfestedCerberusCircleSelectorP2" },
		},
	},

	InfestedCerberusHowlSummonSelector =
	{
		Requirements =
		{
			RequireTotalAttacks = 12,
			MaxUses = 1,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"InfestedCerberusHowlSummonShadeSmall",
				"InfestedCerberusHowlSummonShadeMedium",
				"InfestedCerberusHowlSummonShadeLarge",
			},

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
								Value = 3,
							},
						},
					},
					Data =
					{
						ChainedWeaponOptions = 
						{
							"InfestedCerberusHowlSummonShadeSmallElite",
							"InfestedCerberusHowlSummonShadeMediumElite",
							"InfestedCerberusHowlSummonShadeLargeElite",
						},
					},
				},
			},
		},
	},

	InfestedCerberusHowlSummonSelectorPhase2 =
	{	
		Requirements =
		{
			MaxUses = 1,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,

			ChainedWeaponOptions =
			{
				--"InfestedCerberusHowlSummonLamiaElite",
				"InfestedCerberusHowlSummonLycanthropeElite",
				--"InfestedCerberusHowlSummonMournerElite",
				--"InfestedCerberusHowlSummonLovesickElite",
			},
		},
	},

	InfestedCerberusHowlSummons =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,

			AttackDistance = 99999,
			MoveWithinRange = false,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_SwipeCharge",
			PreAttackAnimation = "Enemy_InfestedCerberus_Howl_Summons",

			PreAttackDuration = 1.0,
			PostAttackDuration = 3.0,

			ProjectileName = "CerberusSummonHowl",
			
			SpawnBurstOnFire = true,
			SpawnBurstDelay = 1.0,
			SpawnRate = 0.25,
			SpawnOnSpawnPoints = true,
			SpawnNearPlayer = true,
			SpawnRadiusMin = 1200,
			SpawnRadius = 2400,
			SpawnsPerBurstMin = 8,
			SpawnsPerBurstMax = 12,
			MaxActiveSpawns = 15,
			SpawnerOptions = { "CorruptedShadeSmall", "CorruptedShadeMedium", "CorruptedShadeLarge" },
			SpawnAggroed = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_PlagueRoar" },
			},
		},
	},

	InfestedCerberusHowlSummonShadeSmall =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 8,
			SpawnsPerBurstMax = 8,
			MaxActiveSpawns = 22,
			SpawnerOptions = { "CorruptedShadeSmall" },
			SpawnOnGroupName = "SpawnPointsPhase1",
		},
	},

	InfestedCerberusHowlSummonShadeSmallElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 8,
			SpawnsPerBurstMax = 8,
			MaxActiveSpawns = 22,
			SpawnerOptions = { "CorruptedShadeSmall_Elite" },
			SpawnOnSpawnPoints = false,
		},
	},

	InfestedCerberusHowlSummonShadeMedium =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			MaxActiveSpawns = 16,
			SpawnerOptions = { "CorruptedShadeMedium" },
			SpawnOnGroupName = "SpawnPointsPhase1",
		},
	},

	InfestedCerberusHowlSummonShadeMediumElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			MaxActiveSpawns = 16,
			SpawnerOptions = { "CorruptedShadeMedium_Elite" },
		},
	},

	InfestedCerberusHowlSummonShadeLarge =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "CorruptedShadeLarge" },
			SpawnOnGroupName = "SpawnPointsPhase1",
		},
	},

	InfestedCerberusHowlSummonShadeLargeElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "CorruptedShadeLarge_Elite" },
			SpawnOnGroupName = "SpawnPointsPhase1",
		},
	},

	InfestedCerberusHowlSummonLamiaElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Lamia_Elite" },
		},
	},

	InfestedCerberusHowlSummonLycanthropeElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Lycanthrope" },
		},
	},

	InfestedCerberusHowlSummonMournerElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Mourner_Elite" },
		},
	},

	InfestedCerberusHowlSummonLovesickElite =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },

		AIData =
		{
			DeepInheritance = true,
			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Lovesick_Elite" },
		},
	},

	InfestedCerberusHowlSummonFogEmitters =
	{
		InheritFrom = { "InfestedCerberusHowlSummons" },
		Requirements =
		{
			MaxUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 4,
			SpawnerOptions = { "FogEmitter2" },

			PostAttackDuration = 1.5,
			PreAttackAnimationSpeed = 2.0,
		},
	},

	InfestedCerberusHide =
	{

		AIData =
		{
			DeepInheritance = true,

			SkipFireWeapon = true,
			MoveWithinRange = false,
			AttackDistance = 99999,

			PostAttackAnimation = "Enemy_InfestedCerberus_Hidden",

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 1.0,

		},
	},

	InfestedCerberusBurrow =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 8,
		},

		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CerberusUnburrowRadial",
			FireProjectileAtSelf = true,

			MoveWithinRange = false,
			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,
			PreAttackEndStop = true,
			PostAttackStop = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.7,
			PostAttackDuration = 0.45,
			TeleportPreWaitAnimation = "Enemy_InfestedCerberus_BurrowStart",
			TeleportAnimation = "Enemy_InfestedCerberus_BurrowEmerge",

			AttackDistance = 9999,
			
			PreTeleportClearAllEffects = true,

			PreMoveTeleport = true,
			--TeleportToSpawnPointType = "EnemyPointMelee",
			TeleportMinDistance = 1200,
			TeleportMaxDistance = 4750,
			TeleportPreWaitFx = "EnemyBurrowExitSmall",
			TeleportEndFx = "EnemyBurrowEntranceSmall",
			TeleportDestinationFx = "CerbAoEDecal_In_Unburrow",
			StartTeleportScreenShake = { Distance = 7, Speed = 350, Duration = 1.5, Angle = 90, FalloffSpeed = 1500 },
			MidTeleportScreenShake = { Distance = 3, Speed = 200, Duration = 0.95, FalloffSpeed = 1500 },
			PreTeleportWait = 2.5,
			MidTeleportWait = 1.0,
			PostTeleportWait = 0,
			StopBeforeTeleport = true,
			AngleTowardsTeleportTarget = false,
			AngleTowardsTeleportTargetMidTeleport = true,

			ChainedWeapon = "InfestedCerberusUnburrowRadialInverted",

			PreMoveVoiceLines =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.18, },
					},
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 1.25,
					SuccessiveChanceToPlay = 0.15,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.3, },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelinoeCerberusBorrowReactionVO", Time = 120 },
					},
					{ Cue = "/VO/MelinoeField_0528", Text = "Uh-oh...!" },
					{ Cue = "/VO/MelinoeField_1239", Text = "Down he goes..." },
					{ Cue = "/VO/MelinoeField_1240", Text = "Off he goes..." },
					{ Cue = "/VO/MelinoeField_1227", Text = "Steady, Mel..." },
					{ Cue = "/VO/MelinoeField_1226", Text = "This again...!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "RoomsEntered", "H_Boss01" },
								Comparison = ">=",
								Value = 3,
							}
						}
					},
					{ Cue = "/VO/MelinoeField_1229", Text = "{#Emph}Erm...!" },
				},
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/PoseidonWrathWaveCrash" },
			},
		},

		FireScreenshake = {  Distance = 13, Speed = 600, Duration = 1.3, Angle = 90, FalloffSpeed = 1500 },
	},

	InfestedCerberusUnburrowRadialInverted =
	{
		BlockInterrupt = true,
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
								Value = 3,
							},
						},
					},
					Data =
					{
						ExpireFusedProjectilesOnFire = true,
					},
				},
			},

			NoProjectile = true,

			PreAttackAnimation = "Enemy_InfestedCerberus_BarkPreFire",
			FireAnimation = "Enemy_InfestedCerberus_BarkFireLoop",
			PostAttackAnimation = "Enemy_InfestedCerberus_BarkPostFire",

			MoveWithinRange = false,
			AttackDistance = 9999,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.2,
			PostAttackDuration = 0.37,

			DumbFireWeapons = { "InfestedCerberusUnburrowRadialInvertedCircle", },
			ChainedWeaponOptions =
			{
				"InfestedCerberusSwipe",
				"InfestedCerberusPoundL",
				"InfestedCerberusPoundR",
				"InfestedCerberusTurnSlam",
				"InfestedCerberusFireBallCombo2",
			},
		},
	},

	InfestedCerberusUnburrowRadialInvertedCircle =
	{
		AIData =
		{
			DeepInheritance = true,

			TargetSelf = true,
			FireProjectileAtTarget = true,

			PreAttackFx = "CerbInvertedCircle",
			EndPreAttackFx = true,

			PreAttackDuration = 3.0, -- CerbInvertedCircleDarken needs to match this duration
			FireDuration = 0,
			PostAttackDuration = 0,

			AttackDistance = 9999,

			ProjectileName = "CerberusUnburrowRadialInverted",


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
								Value = 3,
							},
						},
					},
					Data =
					{
						ExpireFusedProjectilesOnFire = true,
					},
				},
			},

			PreAttackVoiceLines =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.18, },
					},
				},
				{
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					PreLineWait = 1.25,
					SuccessiveChanceToPlay = 0.15,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 40 },
					},
					{ Cue = "/VO/MelinoeField_0528", Text = "Uh-oh...!" },
					{ Cue = "/VO/MelinoeField_1228", Text = "Not good...!" },
					{ Cue = "/VO/MelinoeField_1230", Text = "Incoming...!" },
					{ Cue = "/VO/MelinoeField_1232", Text = "Oh, no..." },
					{ Cue = "/VO/MelinoeField_1233", Text = "Oh great...." },
				},
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/PoseidonWrathWaveCrash" },
				{ Name = "/SFX/ZeusWrathThunder" },
			},
		},

		FireScreenshake = {  Distance = 7, Speed = 500, Duration = 0.6, FalloffSpeed = 1500 },
	},

	InfestedCerberusMiasmaGeyser =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 12,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MiasmaLobEdge",
			NumProjectiles = 10,
			ProjectileInterval = 0.06,
			Spread = 360,
			BarrelLength = 0,
			FireProjectileAtSelf = true,
			SpawnFromRandomMarker = { "InfestedCerberus_Rig:spineFixB_03_M_JNT", "InfestedCerberus_Rig:clav_00_R_JNT",
				"InfestedCerberus_Rig:lowerArm_00_L_JNT", "InfestedCerberus_Rig:lowerArm_00_R_JNT",
				"InfestedCerberus_Rig:handGhostE_01_L_JNT", "InfestedCerberus_Rig:handGhostE_00_R_JNT" },

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			PreAttackEndStop = true,
			PostAttackStop = true,

			ImmuneToProjectileSlow = true,
			PreAttackDuration = 0.5,
			FireDuration = 1.5,
			PostAttackDuration = 0.5,

			PreAttackAnimationSpeed = 1.5,
			PreAttackAnimation = "Enemy_InfestedCerberus_Shake",

			PreAttackVoiceLines =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.18, },
					},
				},
				{
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					PreLineWait = 1.25,
					SuccessiveChanceToPlay = 0.15,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 40 },
					},
					{ Cue = "/VO/MelinoeField_1226", Text = "This again...!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1232", Text = "Oh, no..." },
					{ Cue = "/VO/MelinoeField_1233", Text = "Oh great...." },
				},
			},

		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/PoseidonWrathWaveCrash" },
			},
		},

		FireScreenshake = {  Distance = 5, Speed = 300, Duration = 0.8, Angle = 0, FalloffSpeed = 1500 },
	},

	InfestedCerberusBlock =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			--PreAttackEndFunctionName = "EnemyGainHitShields",
			--PreAttackEndFunctionArgs = { Count = 5 },
			--EndPreAttackFx = true,
			--FireFx = "ShielderNova_DeathAlly",

			PreAttackLoopingSound = "/SFX/ThanatosCreepyBellLoop",

			MoveWithinRange = false,

			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 1.5,
			PostAttackDuration = 0.35,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.45,
			PostAttackStop = true,
			
			PreAttackAnimation = "Enemy_InfestedCerberus_BlockStart",
			FireAnimation = "Enemy_InfestedCerberus_BlockLoop",
			PostAttackAnimation = "Enemy_InfestedCerberus_BlockEnd",

			ChainedWeaponOptions = { "InfestedCerberusBlockFollowUp", },
		}
	},

	InfestedCerberusBackSwipeR =
	{
		GenusName = "InfestedCerberusBackSwipe",

		Requirements =
		{
			MinPlayerArc = 100,
			MinAttacksBetweenUse = 4,
			RequirePlayerRightSide = true,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "InfestedCerberusBackSwipeR", PauseDuration = 0.1 },
				{ ProjectileName = "InfestedCerberusWaveLarge", AIDataOverrides = { BarrelLength = 200, FireProjectileAngleRelative = 180, }  },
			},
			
			FireProjectileStartDelay = 0.1,

			AttackDistance = 9999,
			PreAttackStop = true,
			MoveWithinRange = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackAngleTowardTarget = false,

			PreAttackDuration = 0.5,
			PreAttackEndMinWaitTime = 0.42,
			FireDuration = 0.47,
			PostAttackDuration = 0.93,
			
			PreAttackAnimation = "Enemy_InfestedCerberus_BackSwipeRPreFire",
			FireAnimation = "Enemy_InfestedCerberus_BackSwipeRFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_BackSwipeRPostFire",
		}
	},

	InfestedCerberusBackSwipeL =
	{
		InheritFrom = { "InfestedCerberusBackSwipeR" },
		GenusName = "InfestedCerberusBackSwipe",

		Requirements =
		{
			MinPlayerArc = 100,
			MinAttacksBetweenUse = 4,
			RequirePlayerLeftSide = true,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "InfestedCerberusBackSwipeL", PauseDuration = 0.1 },
				{ ProjectileName = "InfestedCerberusWaveLarge", AIDataOverrides = { BarrelLength = 200, FireProjectileAngleRelative = 180, }  },
			},

			PreAttackAnimation = "Enemy_InfestedCerberus_BackSwipeLPreFire",
			FireAnimation = "Enemy_InfestedCerberus_BackSwipeLFire",
			PostAttackAnimation = "Enemy_InfestedCerberus_BackSwipeLPostFire",
		},
	},

	InfestedCerberusBlockFollowUp =
	{
		InheritFrom = { "InfestedCerberusPoundL" },
		Requirements =
		{
			-- none
		},
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.34,
			PreAttackEndMinWaitTime = 0.34,
			PreAttackStartMinWaitTime = "nil",
			PreAttackAnimationSpeed = 2.26,

			PostAttackDuration = 0.35,
			ChainedWeaponOptions = { "InfestedCerberusBlockFollowUp2" },
		},
	},

	InfestedCerberusBlockFollowUp2 =
	{
		GenusName = "InfestedCerberusBackSwipe",

		InheritFrom = { "InfestedCerberusBackSwipeR" },
		Requirements =
		{
			-- none
		},
	},

	InfestedCerberus_MagmaSplashRadial =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CerberusMagmaSplash",

			AttackSlots =
			{
				{ Angle = 0, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 45, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 90, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 135, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 235, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 270, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 315, AnchorAngleOffset = 550, OffsetRadius = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},

			AttackSlotInterval = 0.05,
			RandomizeAttackSlotOrder = true,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},
	},

	InfestedCerberus_MagmaSplashLine =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CerberusMagmaSplash",

			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 90, }, },
				{ AIDataOverrides = { FireProjectileAngleRelative = 270, }, PauseDuration = 0.1 },
				{ AIDataOverrides = { FireProjectileAngleRelative = 90, }, },
				{ AIDataOverrides = { FireProjectileAngleRelative = 270, }, PauseDuration = 0.1 },
				{ AIDataOverrides = { FireProjectileAngleRelative = 90, }, },
				{ AIDataOverrides = { FireProjectileAngleRelative = 270, }, PauseDuration = 0.1 },
				{ AIDataOverrides = { FireProjectileAngleRelative = 90, }, },
				{ AIDataOverrides = { FireProjectileAngleRelative = 270, }, PauseDuration = 0.1 },
			},

			Spread = 15,

			FireProjectileNoDestination = true,

			AttackSlotInterval = 0.02,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},
	},

	InfestedCerberusFireballCone_Block =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "InfestedCerberusBreath",

			FireProjectileStartDelay = 0.21,
			NumProjectiles = 10,
			ProjectileAngleInterval = 10,
			ProjectileInterval = 0.03,
			Spread = 10,
			BarrelLength = 200,

			FireProjectileNoDestination = true,
		},
	},

	InfestedCerberusBurrowMiasmaMagma_EM =
	{

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "CerberusMagmaSplashWithPuddle", },
				{ ProjectileName = "MiasmaLobClose", },
			},

			DumbFireWakeUpDelay = 0.7,

			NumProjectiles = 6,
			ProjectileInterval = 0.06,
			ProjectileAngleInterval = 60,
			Spread = 15,
			BarrelLength = 0,
			FireProjectileAtSelf = true,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,

			ImmuneToProjectileSlow = true,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil