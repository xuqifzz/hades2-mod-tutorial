WeaponSetData =
{
	ErisSnipe =
	{
		ChainChance = 0.75,
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SniperGunWeapon",
			BarrelLength = 150,
			PreAttackFx = "ScyllaAimLine",
			EndPreAttackFx = true,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.27,
			--StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_SnipePreFire",
			FireAnimation = "Enemy_Eris_SnipeFire",
			PostAttackAnimation = "Enemy_Eris_SnipePostFire",
			PreAttackDurationMin = 1.75,
			PreAttackDurationMax = 3.15,
			FireDuration = 0.7,
			--PostAttackDuration = 0.82,
			PostAttackDuration = 1.5,

			FireSelfVelocity = 1200,
			FireSelfVelocityAngleOffset = 180,

			AttackDistance = 900,
			MoveSuccessDistance = 50,
			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ErisAttackVoiceLines,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/GunFinalBulletBlastSFX" },
			},
		},
	},

	ErisSnipe1 =
	{
		InheritFrom = { "ErisSnipe" },
		ChainChance = 0,
		Requirements = 
		{
			MaxUses = 1,
		},
	},

	ErisSnipe2 =
	{
		InheritFrom = { "ErisSnipe" },
		ChainChance = 0,
		Requirements = 
		{
			MaxUses = 1,
		},
	},

	ErisSnipe3 =
	{
		InheritFrom = { "ErisSnipe" },
		ChainChance = 0.5,
		Requirements = 
		{
			MaxUses = 1,
			MinAttacksBetweenUse = 12,
		},
	},

	ErisSpray =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunWeapon",
			FireTicksMin = 15,
			FireTicksMax = 15,
			FireInterval = 0.15,
			Spread = 7,

			FireTickSelfVelocity = 690,
			FireTickSelfVelocityAngleOffset = 180,
			FireTickSelfVelocityConsecutiveMultiplier = 0.995,

			ChainedWeaponOptions = { "ErisReload" },

			BarrelLength = 65,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.18,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.09,
			StopMoveWithinRange = true,
			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_SprayPreFire",
			FireAnimation = "Enemy_Eris_SprayFire",
			PostAttackAnimation = "Enemy_Eris_SprayPostFire",
			PreAttackDuration = 0.83,
			FireDuration = 0.23,
			PostAttackDuration = 0.82,

			RequireProjectileLoS = true,
			LoSBuffer = 100,
			LoSEndBuffer = 32,
			AttackDistance = 550,
			AttackDistanceScaleY = 0.8,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ErisAttackVoiceLines,
			},			
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ErisSpreadFire =
	{
		AIData =
		{
			--DeepInheritance = true,

			ProjectileName = "GunWeapon",

			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 0 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = 8 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -8 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = 16 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -16 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = 24 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -24 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = 32 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -32 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = 40 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -40 } },
			},
			FireTicks = 6,
			FireInterval = 0.5,
			FireProjectileTowardTarget = true,
			Spread = 0,
			BarrelLength = 100,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.16,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.11,
			StopMoveWithinRange = true,
			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_SpreadPreFire",
			FireAnimation = "Enemy_Eris_SpreadFire",
			PostAttackAnimation = "Enemy_Eris_SpreadPostFire",
			PreAttackDuration = 0.83,
			FireDuration = 0.23,
			PostAttackDuration = 0.82,

			AttackDistance = 370,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ErisAttackVoiceLines,
			},
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
				{ Name = "/SFX/Player Sounds/AphroditeLoveShotgunBlast" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ErisRicochet =
	{	
		InheritFrom = { "ErisSpray" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunWeaponBounce",
			FireTicksMin = 40,
			FireTicksMax = 40,
			FireInterval = 0.05,
			Spread = 1,		
		},
	},

	ErisReload =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,


			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 1.65, -- animation is 1.33

			FireAnimation = "Enemy_Eris_Reload",

			ChainedWeapon = "ErisReloadJam",

			--ChainedWeapon = "ErisSpray",

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/ErisField_0082", Text = "Reloading!" },
				{ Cue = "/VO/ErisField_0083", Text = "Reloading...!" },
				{ Cue = "/VO/ErisField_0084", Text = "Plenty more!" },
				{ Cue = "/VO/ErisField_0087", Text = "Fresh out..." },
				{ Cue = "/VO/ErisField_0088", Text = "I'm out..." },
				{ Cue = "/VO/ErisField_0089", Text = "Empty..." },
			},

		},

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
	},

	ErisReloadJam =
	{
		ChainChance = 0.33,
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 2.0,

			FireAnimation = "Enemy_Eris_ReloadJam",

			--ChainedWeapon = "ErisSpray",

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				TriggerCooldowns = { "ErisSpokeRecently" },

				{ Cue = "/VO/ErisField_0085", Text = "{#Emph}Load{#Prev}, damn it!" },
				{ Cue = "/VO/ErisField_0086", Text = "C'mon..." },
			},

		},
	},

	ErisGrenade =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunGrenadeToss",
			FireProjectileAtTarget = true,

			AngleTowardsTargetWhileFiring = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			StopBeforeFire = true,
			ImmuneToProjectileSlow = true,

			PreAttackDuration = 0.83,
			FireDuration = 0.43,
			PostAttackDuration = 0.82,

			AttackDistance = 2000,

			PreAttackAnimation = "Enemy_Eris_GrenadePreFire",
			FireAnimation = "Enemy_Eris_GrenadeFire",
			PostAttackAnimation = "Enemy_Eris_GrenadePostFire",

			--[[
			MoveToRandomSpawnPoint = true,
			MoveToSpawnPointFromSelf = true,
			MoveToSpawnPointDistanceMin = 200,
			MoveToSpawnPointDistanceMax = 1200,
			]]

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/ErisField_0070", Text = "Heads {#Emph}up!" },
				{ Cue = "/VO/ErisField_0071", Text = "Bombs {#Emph}away!" },
				{ Cue = "/VO/ErisField_0072", Text = "Catch!" },
				{ Cue = "/VO/ErisField_0073", Text = "{#Emph}Boom!" },
			},

		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
				{ Name = "/SFX/Enemy Sounds/Eris/EmoteAttacking" },
			},
		},
	},

	ErisGrenadeCluster01 =
	{
		InheritFrom = { "ErisGrenade" },

		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ UseRandomAngle = true, OffsetDistance = 0, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 250, OffsetDistanceMax = 350, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 450, OffsetDistanceMax = 550, UseTargetPosition = true },
			},
			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteAttacking",
			AttackSlotInterval = 0.2,
			NoProjectileAngle = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	ErisGrenadeCluster02 =
	{
		InheritFrom = { "ErisGrenade" },

		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ UseRandomAngle = true, OffsetDistance = 0, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 250, OffsetDistanceMax = 350, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 250, OffsetDistanceMax = 350, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 450, OffsetDistanceMax = 550, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 450, OffsetDistanceMax = 550, UseTargetPosition = true },
			},
			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteAttacking",
			AttackSlotInterval = 0.2,
			NoProjectileAngle = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	ErisGrenadeCluster03 =
	{
		InheritFrom = { "ErisGrenade" },

		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ UseRandomAngle = true, OffsetDistance = 0, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 250, OffsetDistanceMax = 350, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 250, OffsetDistanceMax = 350, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 450, OffsetDistanceMax = 550, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 450, OffsetDistanceMax = 550, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 550, OffsetDistanceMax = 600, UseTargetPosition = true },
				{ UseRandomAngle = true, OffsetDistanceMin = 550, OffsetDistanceMax = 600, UseTargetPosition = true },
			},
			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteAttacking",
			AttackSlotInterval = 0.2,
			NoProjectileAngle = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	ErisGrenadeSelfBuff =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunGrenadeTossSelf",
			TargetSelf = true,
			ImmuneToProjectileSlow = true,

			MoveWithinRange = false,
			AttackDistance = 9999,

			PreAttackDuration = 0.83,
			FireDuration = 0.43,
			PostAttackDuration = 0.8,

			PreAttackAnimation = "Enemy_Eris_GrenadePreFire",
			FireAnimation = "Enemy_Eris_GrenadeSelf",
			--PostAttackAnimation = "Enemy_Eris_Yell", -- the anim above does the chaining

			ChainedWeaponOptions = { "ErisPostBuffCombo1", "ErisPostBuffCombo2" },

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				-- SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
				},
				TriggerCooldowns = { "ErisSpokeRecently" },

				{ Cue = "/VO/ErisField_0106", Text = "That {#Emph}does {#Prev}it!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0107", Text = "How about {#Emph}this?" },
				{ Cue = "/VO/ErisField_0108", Text = "All right, {#Emph}fine!" },
				{ Cue = "/VO/ErisField_0109", Text = "I've {#Emph}had {#Prev}it!!" },
			},

		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
				{ Name = "/SFX/Enemy Sounds/Eris/EmoteAttacking" },
			},
		},
	},

	ErisGrenadeSelfBuffFinal =
	{
		InheritFrom = { "ErisGrenadeSelfBuff" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunGrenadeTossSelfFinal",

			ChainedWeaponOptions = { "ErisMultiStrike" },

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.75,
				GameStateRequirements =
				{
					--
				},
				TriggerCooldowns = { "ErisSpokeRecently" },

				{ Cue = "/VO/ErisField_0110", Text = "Come {#Emph}here{#Prev}, Trouble!!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0111", Text = "Catch {#Emph}this!" },
				{ Cue = "/VO/ErisField_0112", Text = "One for the both of us!!" },
				{ Cue = "/VO/ErisField_0113", Text = "Race you {#Emph}home!!" },

			},

		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
				{ Name = "/SFX/Enemy Sounds/Eris/EmoteAttacking" },
			},
		},
	},

	ErisDash =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunWeapon",
			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 40 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -40 } },
			},
			FireTicks = 10,
			FireInterval = 0.04,
			FireProjectileTowardTarget = true,
			Spread = 0,
			BarrelLength = 200,

			PreAttackEndStop = true,

			FireSelfVelocity = 2400,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_StrafePreFire",
			FireAnimation = "Enemy_Eris_StrafeFire",
			PostAttackAnimation = "Enemy_Eris_StrafePostFire",
			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.4,
			FireDuration = 0.35,
			PostAttackDuration = 1.5, -- animation is 0.92

			--CreateOwnTargetFromOriginalTarget = true,
			--TargetAngleOptions = { 30, -30 },
			--TargetOffsetDistance = 0,

			DumbFireWeapons = { "ErisKnockback" },

			AttackDistance = 720,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ErisAttackVoiceLines,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	ErisKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,
			ProjectileName = "ErisKnockback",

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

		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
		
		--[[x
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.000, LerpTime = 0.0 },
		},
		]]
	},

	ErisSummonSelector =
	{
		Requirements =
		{
			RequireTotalAttacks = 5,
			MinAttacksBetweenUse = 12,
			MaxUses = 4,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"ErisSummon01",
				"ErisSummon02",
				"ErisSummon03",
				"ErisSummon04",
			},
		},
	},

	ErisSummonSelector2 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 16,
			MaxUses = 4,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"ErisSummon01_Elite",
				"ErisSummon02_Elite",
				"ErisSummon03_Elite",
				"ErisSummon04_Elite",
			},
		},
	},

	ErisSummonBase =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			DashIfOverDistance = 99999,
			NoProjectile = true,

			PreAttackAnimation = "Enemy_Eris_FlyUp_Start",
			FireAnimation = "Enemy_Eris_FlyUp_Fire",
			FireSetZHeight = 800,
			FireSetZDuration = 0.55,

			PostAttackThreadedFunctionName = "ErisFlyByPresentation",
			PostAttackThreadedFunctionArgs = { FlyByDuration = 3.0, FlyBySpeedMultiplier = 15.0, FlyByScale = 9, TopGroup = true, FlybyZHeight = 100 },

			PreAttackDuration = 0.45,
			FireDuration = 1.5,
			PostAttackDuration = 3.5,

			ClearAllEffects = true,

			SpawnBurstOnFire = true,
			SpawnRate = 0.125,
			SpawnOnSpawnPoints = true,
			--RequiredSpawnPointType = "EnemyPointSupport",
			SpawnOnIdsOrdered = { 744265, 744267, 744272, 744330, 744331, 744332, },
			SpawnRadius = 99999,
			SpawnBurstDelay = 1.45,
			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 5,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Drunk", "Swab", "Stickler", "HarpyCutter" },
			SpawnAggroed = true,
			SkipLocationBlockedCheck = true,

			ChainedWeaponOptions = { "ErisFlyDown" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ErisSummon01 =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "HarpyCutter" },
		},
	},

	ErisSummon01_Elite =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "HarpyCutter_Elite" },
		},
	},

	ErisSummon02 =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Drunk" },
		},
	},

	ErisSummon02_Elite =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Drunk_Elite" },
		},
	},

	ErisSummon03 =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Stickler" },
		},
	},

	ErisSummon03_Elite =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Stickler_Elite" },
		},
	},

	ErisSummon04 =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Swab" },
		},
	},

	ErisSummon04_Elite =
	{
		InheritFrom = { "ErisSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "Swab_Elite" },
		},
	},

	ErisBombardment01 =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			DashIfOverDistance = 99999,

			ProjectileName = "ErisBombardment",
			AttackSlotInterval = 0.125,
			AttackSlots =
			{
				{ UseMapObjectId = 736810  },
				{ UseMapObjectId = 736815  },
				{ UseMapObjectId = 736814  },
				{ UseMapObjectId = 736811  },
				{ UseMapObjectId = 736808  },
				{ UseMapObjectId = 736809  },

				{ UseMapObjectId = 736804  },
				{ UseMapObjectId = 736805  },
				{ UseMapObjectId = 736806  },
				{ UseMapObjectId = 736807  },
				{ UseMapObjectId = 736808  },
				{ UseMapObjectId = 736809  },

				{ UseMapObjectId = 736810  },
				{ UseMapObjectId = 736815  },
				{ UseMapObjectId = 736814  },
				{ UseMapObjectId = 736811  },
				{ UseMapObjectId = 736822  },
				{ UseMapObjectId = 736820  },
				{ UseMapObjectId = 736821  },
				{ UseMapObjectId = 736818  },
			},

			FireProjectileAtTarget = true,
			SkipIfInvalidLocation = true,

			PreAttackThreadedFunctionName = "ErisFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByDuration = 1.0, FlyBySpeedMultiplier = 7.0, FlyByScale = 3.5 },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,

			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 0.05,
			PostAttackCooldownMax = 0.25,

			ChainedWeaponOptions = { "ErisFlyDown" },
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Eris/EmoteLaugh" },
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ErisBombardment02 =
	{
		InheritFrom = { "ErisBombardment01" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ OffsetX = -2400, OffsetY = 900, OffsetScaleY = 0.5 },
				{ OffsetX = -2000, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = -1600, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = -800, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = -400, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = -600, OffsetScaleY = 0.5 },
				{ OffsetX = 400, OffsetY = -900, OffsetScaleY = 0.5 },

				{ OffsetX = 1200, OffsetY = -900, OffsetScaleY = 0.5 },
				{ OffsetX = 800, OffsetY = -600, OffsetScaleY = 0.5 },
				{ OffsetX = 400, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = -400, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = -800, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = -1200, OffsetY = 900, OffsetScaleY = 0.5 },

				{ OffsetX = -400, OffsetY = 900, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = 400, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = 800, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 1200, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 1600, OffsetY = -600, OffsetScaleY = 0.5 },
				{ OffsetX = 2000, OffsetY = -900, OffsetScaleY = 0.5 },

				{ OffsetX = 2800, OffsetY = -900, OffsetScaleY = 0.5 },
				{ OffsetX = 2400, OffsetY = -600, OffsetScaleY = 0.5 },
				{ OffsetX = 2000, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 1600, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 1200, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = 800, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = 400, OffsetY = 900, OffsetScaleY = 0.5 },
			},

			ChainedWeaponOptions = { "ErisFlyDown" },
		},
	},

	ErisBombardment03 =
	{
		InheritFrom = { "ErisBombardment01" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlotInterval = 0.025,
			AttackSlotsPerTick = 18,
			AttackSlots =
			{
				{ Angle = 0, AnchorAngleOffset = 0, OffsetScaleY = 0.5, },
				{ Angle = 0, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 45, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 90, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 135, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 180, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 225, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 270, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },
				{ Angle = 315, AnchorAngleOffset = 600, OffsetScaleY = 0.5, },

				{ Angle = 0, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 30, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 60, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 90, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 120, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 150, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 180, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 210, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 240, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 270, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 300, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
				{ Angle = 330, AnchorAngleOffset = 1100, OffsetScaleY = 0.5, },
			},

			PostAttackDuration = 2.0,
			ChainedWeaponOptions = { "ErisFlyDown" },
		},
	},

	ErisBombardmentChase =
	{
		InheritFrom = { "ErisBombardment01" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots = "nil",
			FireTicksMin = 20,
			FireTicksMax = 30,
			FireInterval = 0.4,

			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 300,
			ResetTargetPerTick = true,

			PreAttackThreadedFunctionArgs = { FlyByDuration = 1.0, FlyBySpeedMultiplier = 4.0, FlyByScale = 2.0 },

			ChainedWeaponOptions = { "ErisFlyDown" },
		},
	},

	ErisFlyUp =
	{

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.45,
			FireDuration = 0.55,
			PostAttackDuration = 0.6,

			ClearAllEffects = true,

			ChainedWeaponOptions = { "ErisBombardment01", "ErisBombardment02", "ErisBombardment03", "ErisBombardmentChase" },
			--ChainedWeaponOptions = { "ErisBombardmentChase", },

			PreAttackAnimation = "Enemy_Eris_FlyUp_Start",
			FireAnimation = "Enemy_Eris_FlyUp_Fire",

			FireSetZHeight = 800,
			FireSetZDuration = 0.55,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 12,
			RequireTotalAttacks = 4,
		},
	},

	ErisFlyDown =
	{

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackTeleportToSpawnPoints = true,
			RequireTeleportTargetLoS = true,

			ChainedWeapon = "ErisSnipe3",

			PreAttackDuration = 0.0,
			FireDuration = 0.2,
			PostAttackDuration = 0.8, -- animation is 1.62 x 3

			FireAnimation = "Enemy_Eris_FlyDown",
			PreAttackSetZHeight = 800,
			FireSetZHeight = 5,
			FireSetZDuration = 0.19,
		}
	},

	ErisPostBuffCombo1 =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ErisSpreadFire",
			"ErisDash",
			"ErisSpreadFire",
			"ErisDash",
			"ErisSpray",
			"ErisGrenadeCluster01",
			"ErisSnipe1",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},


	ErisPostBuffCombo2 =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ErisGrenadeCluster01",
			"ErisDash",
			"ErisGrenadeCluster02",
			"ErisDash",
			"ErisGrenadeCluster03",
			"ErisDash",
			"ErisSnipe2",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ErisMultiStrike =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ErisRelocateStrike",
			"ErisRelocateStrike",
			"ErisRelocateStrike",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ErisRelocateStrike =
	{

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.225,
			FireDuration = 0.275,
			PostAttackDuration = 0,

			ChainedWeaponOptions = { "ErisRelocateStrike2", },

			PreAttackAnimation = "Enemy_Eris_FlyUp_Start_Fast",
			FireAnimation = "Enemy_Eris_FlyUp_Fire_Fast",

			FireSetZHeight = 800,
			FireSetZDuration = 0.275,
		},
	},

	ErisRelocateStrike2 =
	{

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackTeleportToSpawnPoints = true,

			RequireTeleportTargetLoS = true,

			ChainedWeapon = "ErisRelocate3",

			PreAttackDuration = 0.0,
			FireDuration = 0.2,
			PostAttackDuration = 0.35,

			FireAnimation = "Enemy_Eris_FlyDown",
			PreAttackSetZHeight = 800,
			FireSetZHeight = 5,
			FireSetZDuration = 0.19,
		}
	},

	ErisRelocate3 =
	{	
		InheritFrom = { "ErisSpray" },
		AIData =
		{
			DeepInheritance = true,

			--ProjectileName = "GunWeaponBounce",
			FireTicksMin = 10,
			FireTicksMax = 10,
			FireInterval = 0.05,
			Spread = 4,

			AttackDistance = 99999,

			PostAttackDuration = 0.75,
			ChainedWeaponOptions = { },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil