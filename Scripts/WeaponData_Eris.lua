WeaponSetData =
{
	ErisSnipe =
	{
		ChainChance = 0.75,
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

			ProjectileName = "SniperGunWeapon",
			BarrelLength = 150,
			PreAttackFx = "ErisLaserAimLineSnipe",
			FireFx = "GunWeaponMuzzleFlashSniper",
			EndPreAttackFx = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.27,
			--StopBeforeFire = true,
			PostAttackStop = true,

			PreAttackLoopingSound = "/SFX/Enemy Sounds/Eris/ErisAimLine",
			PreAttackAnimation = "Enemy_Eris_SnipePreFire",
			FireAnimation = "Enemy_Eris_SnipeFire",
			PostAttackAnimation = "Enemy_Eris_SnipePostFire",
			PreAttackDurationMin = 1.75,
			PreAttackDurationMax = 3.15,
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisSniperAimVoiceLines" },
			},
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

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisSniperFireVoiceLines" },
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

			PreAttackFx = "ErisLaserAimline",
			EndPreAttackFx = true,

			ProjectileName = "GunWeaponSpray",
			FireFx = "GunWeaponMuzzleFlash",
			FireTicksMin = 15,
			FireTicksMax = 15,
			FireInterval = 0.15,
			Spread = 7,
			CancelOnNoLosBetweenTicksChance = 0.33,
			MinTicksBeforeEarlyCancel = 3,
			ForceWeaponOnLoSCancel = "ErisGrenadeCluster01",
			CancelChainedWeaponOnLoSCancel = "ErisGrenadeCluster01",

			FireTickSelfVelocity = 690,
			FireTickSelfVelocityAngleOffset = 180,
			FireTickSelfVelocityConsecutiveMultiplier = 0.995,

			ChainedWeaponOptions = { "ErisReload" },

			BarrelLength = 65,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.18,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.12,
			StopMoveWithinRange = true,
			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_SprayPreFire",
			FireAnimation = "Enemy_Eris_SprayFire",
			PostAttackAnimation = "Enemy_Eris_SprayPostFire",
			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 0.23,
			PostAttackDuration = 0.82,

			RequireProjectileLoS = true,
			LoSBuffer = 100,
			LoSEndBuffer = 32,
			AttackDistance = 550,
			AttackDistanceScaleY = 0.8,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
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
	},
	ErisSpreadFire =
	{
		AIData =
		{
			--DeepInheritance = true,

			ProjectileName = "GunWeaponSpread",
			FireFx = "GunWeaponMuzzleFlash",

			PreAttackFx = "ErisSpreadFirePreviewDecal",
			EndPreAttackFx = true,

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

			CancelOnNoLosBetweenTicksChance = 0.33,
			MinTicksBeforeEarlyCancel = 1,
			ForceWeaponOnLoSCancel = "ErisGrenadeCluster01",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.16,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.11,
			StopMoveWithinRange = true,
			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_SpreadPreFire",
			FireAnimation = "Enemy_Eris_SpreadFire",
			PostAttackAnimation = "Enemy_Eris_SpreadPostFire",
			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 0.23,
			PostAttackDuration = 0.82,

			AttackDistance = 370,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisShotgunVoiceLines" },
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
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

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						ChanceToPlay = 0.33
					},
					Data =
					{
						ChainedWeapon = "ErisReloadJam",
						PreAttackThreadedFunctionName = "ErisReloadJamPresentation",
						PreAttackThreadedFunctionArgs = {},
					},
				},
			},

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.5,
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
					{ Name = "ErisReloadedRecently", Time = 12 },
				},
				TriggerCooldowns = { "ErisSpokeRecently" },

				{ Cue = "/VO/ErisField_0082", Text = "Reloading!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0083", Text = "Reloading...!" },
				{ Cue = "/VO/ErisField_0084", Text = "Plenty more!" },
				{ Cue = "/VO/ErisField_0087", Text = "Fresh out..." },
				{ Cue = "/VO/ErisField_0088", Text = "I'm out..." },
				{ Cue = "/VO/ErisField_0089", Text = "Empty..." },
				{ Cue = "/VO/ErisField_0177", Text = "Loading up..." },
				{ Cue = "/VO/ErisField_0178", Text = "Loading up...!" },
				{ Cue = "/VO/ErisField_0179", Text = "Empty again?" },
				{ Cue = "/VO/ErisField_0180", Text = "Chamber's empty..." },
				{ Cue = "/VO/ErisField_0181", Text = "Plenty of ammo!" },
				{ Cue = "/VO/ErisField_0182", Text = "Out of ammo..." },
				{ Cue = "/VO/ErisField_0183", Text = "Out of ammo?" },
				{ Cue = "/VO/ErisField_0184", Text = "Hang on, reloading!" },
			},

		},

		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},
	},
	ErisReloadJam =
	{
		GenusName = "ErisReload",
		
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

			AttackVoiceLines =
			{	
				Queue = "Interrupt",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				Cooldowns =
				{
					{ Name = "ErisReloadJammedRecently", Time = 12 },
				},
				TriggerCooldowns = { "ErisSpokeRecently", "ErisReloadedRecently" },

				{ Cue = "/VO/ErisField_0085", Text = "{#Emph}Load{#Prev}, damn it!" },
				{ Cue = "/VO/ErisField_0086", Text = "C'mon..." },

				{ Cue = "/VO/ErisField_0185", Text = "C'mon, reload...!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0186", Text = "C'mon you stupid thing!" },
				{ Cue = "/VO/ErisField_0187", Text = "Reload already!" },
				{ Cue = "/VO/ErisField_0188", Text = "{#Emph}Re-load-ing!" },
				{ Cue = "/VO/ErisField_0189", Text = "Jammed {#Emph}again?" },
				{ Cue = "/VO/ErisField_0190", Text = "Why won't it shoot?!" },
				{ Cue = "/VO/ErisField_0191", Text = "{#Emph}Ungh {#Prev}this thing is {#Emph}stuck!" },
				{ Cue = "/VO/ErisField_0192", Text = "{#Emph}Augh {#Prev}this piece of {#Emph}junk!" },
				{ Cue = "/VO/ErisField_0193", Text = "This thing is full of sand!" },
				{ Cue = "/VO/ErisField_0194", Text = "Keeps getting stuck..." },
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
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
			},
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

			PreAttackVoiceLines =
			{	
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
				{ GlobalVoiceLines = "ErisGrenadeClusterVoiceLines" },
			},
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

			PreAttackVoiceLines =
			{	
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
				{ GlobalVoiceLines = "ErisGrenadeClusterVoiceLines" },
			},
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

			PreAttackVoiceLines =
			{	
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
				{ GlobalVoiceLines = "ErisGrenadeClusterVoiceLines" },
			},
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
				{ Cue = "/VO/ErisField_0195", Text = "Got something for you!" },
				{ Cue = "/VO/ErisField_0196", Text = "Come {#Emph}here{#Prev}, babe..." },
				{ Cue = "/VO/ErisField_0197", Text = "Here comes my favorite part..." },
				{ Cue = "/VO/ErisField_0198", Text = "All right, {#Emph}enough!" },
				{ Cue = "/VO/ErisField_0199", Text = "Now watch {#Emph}this!" },
				{ Cue = "/VO/ErisField_0200", Text = "Now it's {#Emph}my {#Prev}turn!" },
				{ Cue = "/VO/ErisField_0201", Text = "I'll be {#Emph}right {#Prev}with you!" },
				{ Cue = "/VO/ErisField_0202", Text = "Here it {#Emph}comes!" },
			},

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
				{ Cue = "/VO/ErisField_0208", Text = "Let's blow {#Emph}everything {#Prev}up!" },
				{ Cue = "/VO/ErisField_0203", Text = "One... last... gasp!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/ErisField_0204", Text = "We're... not... {#Emph}through!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/ErisField_0205", Text = "No... you... don't!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/ErisField_0206", Text = "Die... die... {#Emph}die!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/ErisField_0207", Text = "We'll {#Emph}both {#Prev}go back to hell!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "Eris" }
						},
					},
				},
			},
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
		Requirements =
		{
			RequireUnitLoS = true,
			LoSStopsUnits = false,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunWeaponDash",
			FireFx = "GunWeaponMuzzleFlash",
			
			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 40 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -40 } },
			},
			FireTicks = 10,
			FireInterval = 0.04,
			FireProjectileTowardTarget = true,
			Spread = 0,
			BarrelLength = 120,

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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.42,
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
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
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
	},

	ErisSummonSelector =
	{
		Requirements =
		{
			RequireTotalAttacks = 5,
			MinAttacksBetweenUse = 12,
			MaxUses = 2,
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
			},
		},
	},
	ErisSummonSelector2 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 16,
			MaxUses = 2,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"ErisSummon03",
				"ErisSummon04",
			},
		},
	},

	ErisSummonBase =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackAnimation = "Enemy_Eris_FlyUp_Start",
			FireAnimation = "Enemy_Eris_FlyUp_Fire",
			FireSetZHeight = 800,
			FireSetZDuration = 0.55,


			PreAttackSetInvulnerable = true,
			PreAttackSetInvulnerableArgs = { Silent = true },
			PostAttackThreadedFunctionName = "ErisFlyByPresentation",
			PostAttackThreadedFunctionArgs = { FlyByDuration = 1.0, FlyBySpeedMultiplier = 7.0, FlyByScale = 3.5 },

			PreAttackDuration = 0.45,
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},

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

	ErisEMSummonSelector =
	{
		Requirements =
		{
			RequireTotalAttacks = 5,
			MinAttacksBetweenUse = 20,
			MaxUses = 2,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,
			ForceUseIfReady = true,

			ChainedWeaponOptions =
			{
				"ErisEMSummonHarpy",
				"ErisEMSummonSwab",
				"ErisEMSummonJellyfish",
				"ErisEMSummonTurtle",
			},
		},
	},
	ErisEMSummonSelector2 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 20,
			MaxUses = 2,
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,
			ForceUseIfReady = true,

			ChainedWeaponOptions =
			{
				"ErisEMSummonFishmanRanged",
				"ErisEMSummonFishmanMelee",
				"ErisEMSummonFishSwarmer",
				"ErisEMSummonAutomaton",
			},
		},
	},
	ErisEMSummonBase =
	{
		InheritFrom = { "ErisSummonBase" },

		AIData =
		{
			DeepInheritance = true,

			SpawnOnIdsOrdered = { 744610, 744615, 744609, 744616, 744608, 744617, 744607, 744618, },
		}
	},
	ErisEMSummonHarpy =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
			SpawnerOptions = { "HarpyCutter_Elite" },
		},
	},
	ErisEMSummonSwab =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
	ErisEMSummonTurtle =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
			SpawnerOptions = { "Turtle_Elite" },
			PreAttackVoiceLines =
			{
				-- { GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},
	ErisEMSummonJellyfish =
	{
		InheritFrom = { "ErisEMSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnOnIdsOrdered = "nil",
			SpawnOverrides =
			{
				RequiredSpawnPoint = "EnemyPoint",
			},

			SpawnsPerBurstMin = 6,
			SpawnsPerBurstMax = 6,
			MaxActiveSpawns = 12,
			SpawnerOptions = { "Jellyfish_Elite" },
			PreAttackVoiceLines =
			{
				-- { GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},
	ErisEMSummonFishmanRanged =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
			SpawnerOptions = { "FishmanRanged_Elite" },
			PreAttackVoiceLines =
			{
				-- { GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},
	ErisEMSummonFishmanMelee =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
			SpawnerOptions = { "FishmanMelee_Elite" },
			PreAttackVoiceLines =
			{
				-- { GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},
	ErisEMSummonFishSwarmer =
	{
		InheritFrom = { "ErisEMSummonBase" },
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			SpawnOnIdsOrdered = "nil",
			SpawnOverrides =
			{
				RequiredSpawnPoint = "EnemyPoint",
			},

			SpawnsPerBurstMin = 6,
			SpawnsPerBurstMax = 6,
			MaxActiveSpawns = 12,
			SpawnerOptions = { "FishSwarmer_Elite", },
			PreAttackVoiceLines =
			{
				-- { GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},
	ErisEMSummonAutomaton =
	{
		InheritFrom = { "ErisEMSummonBase" },
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
			SpawnerOptions = { "AutomatonBeamer_Elite", "AutomatonEnforcer_Elite" },
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisAutomatonSpawnWaveVoiceLines" },
				-- { GlobalVoiceLines = "ErisFishSpawnWaveVoiceLines" },
				{ GlobalVoiceLines = "ErisSpawnWaveVoiceLines" },
			},
		},
	},

	ErisBombardment01 =
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
						ProjectileName = "ErisBombardmentEM",
					},
				},
			},

			MoveWithinRange = false,

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
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
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
			FireTicksMin = 10,
			FireTicksMax = 15,
			FireInterval = 0.25,

			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 300,
			ResetTargetPerTick = true,

			PreAttackThreadedFunctionArgs = { FlyByDuration = 1.0, FlyBySpeedMultiplier = 4.0, FlyByScale = 2.0 },

			ChainedWeaponOptions = { "ErisFlyDown" },

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
						FireTicksMin = 10,
						FireTicksMax = 15,
					},
				},
			},
		},
	},
	ErisBombardmentEM01 =
	{
		InheritFrom = { "ErisBombardment01" },
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseMapObjectId = 792631  },
				{ UseMapObjectId = 792632  },
				{ UseMapObjectId = 792633  },

				{ UseMapObjectId = 792639  },
				{ UseMapObjectId = 792637  },
				{ UseMapObjectId = 792638  },
				
				{ UseMapObjectId = 792642  },
				{ UseMapObjectId = 792640  },
				{ UseMapObjectId = 792641  },
				
				{ UseMapObjectId = 792645  },
				{ UseMapObjectId = 792643  },
				{ UseMapObjectId = 792644  },
				
				{ UseMapObjectId = 792648  },
				{ UseMapObjectId = 792647  },
				{ UseMapObjectId = 792646  },
				
				{ UseMapObjectId = 792648  },
				{ UseMapObjectId = 792647  },
				{ UseMapObjectId = 792646  },
				
				{ UseMapObjectId = 792651  },
				{ UseMapObjectId = 792650  },
				{ UseMapObjectId = 792649  },
				
				{ UseMapObjectId = 792654  },
				{ UseMapObjectId = 792653  },
				{ UseMapObjectId = 792649  },
			},
		},
	},
	ErisBombardmentEM02 =
	{
		InheritFrom = { "ErisBombardment01" },
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseMapObjectId = 792633  },
				{ UseMapObjectId = 792637  },
				{ UseMapObjectId = 792642  },
				{ UseMapObjectId = 792643  },
				{ UseMapObjectId = 792646  },
				{ UseMapObjectId = 792650  },

				{ UseMapObjectId = 792654  },
				{ UseMapObjectId = 792653  },
				{ UseMapObjectId = 792649  },
				{ UseMapObjectId = 792647  },
				{ UseMapObjectId = 792645  },
				{ UseMapObjectId = 792640  },

				{ UseMapObjectId = 792638  },
				{ UseMapObjectId = 792632  },
			},
		},
	},

	ErisFlyUp =
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
						ChainedWeaponOptions = { "ErisBombardmentEM01", "ErisBombardmentEM02", "ErisBombardment02", "ErisBombardment03", },
					},
				},
			},

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.45,
			PreAttackEndMinWaitTime = 0.45,
			FireDuration = 0.55,
			PostAttackDuration = 0.6,

			ClearAllEffects = true,
			PreAttackSetInvulnerable = true,
			PreAttackSetInvulnerableArgs = { Silent = true },

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
	ErisFlyUp_P4 =
	{
		InheritFrom = { "ErisFlyUp", },
		Requirements =
		{
			MaxUses = 1,
		},
	},
	ErisFlyDown =
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
						PostAttackDuration = 0.35,
						TeleportToSpawnPointType = "EnemyPointSupport",
					},
				},
			},

			PostAttackStartSetVulnerable = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackTeleport = true,
			RequireTeleportTargetLoS = true,

			ChainedWeaponOptions = { "ErisSnipe3", },

			PreAttackDuration = 0.0,
			FireDuration = 0.2,
			PostAttackDuration = 0.8, -- animation is 1.62 x 3

			FireAnimation = "Enemy_Eris_FlyDown",
			PreAttackSetZHeight = 800,
			FireSetZHeight = 5,
			FireSetZDuration = 0.19,

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisSwoopInVoiceLines" },
			},
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

			ClearAllEffects = true,

			PreAttackDuration = 0.225,
			PreAttackEndMinWaitTime = 0.225,
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
			AttackDistance = 9999,
			NoProjectile = true,
			PreAttackTeleport = true,

			RequireTeleportTargetLoS = true,

			ChainedWeaponOptions = { "ErisRelocate3", "ErisLaserStrafeLeft3", "ErisLaserStrafeRight3" },

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
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 2,
				},
			},
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunWeaponRelocate",

			FireTicksMin = 10,
			FireTicksMax = 10,
			FireInterval = 0.05,
			Spread = 4,

			AttackDistance = 99999,

			PreAttackRotationDampening = 0.09,

			PostAttackDuration = 1.1,
			ChainedWeaponOptions = { },
		},
	},

	ErisRelocate_Up =
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
			PostAttackDuration = 0.5,

			ClearAllEffects = true,

			ChainedWeaponOptions = { "ErisRelocate_Down", },

			PreAttackAnimation = "Enemy_Eris_FlyUp_Start_Fast",
			FireAnimation = "Enemy_Eris_FlyUp_Fire_Fast",

			FireSetZHeight = 800,
			FireSetZDuration = 0.275,

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisFireEscapeVoiceLines" },
			},	
		},
	},
	ErisRelocate_Up_P4 =
	{
		InheritFrom = { "ErisRelocate_Up", },
		AIData =
		{
			ChainedWeaponOptions = { "ErisRelocate_Down_P4", },
		},
	},
	ErisRelocate_Down =
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
						TeleportToSpawnPointType = "EnemyPointSupport",
						PostAttackDuration = 0.35,
					},
				},
			},

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackTeleport = true,

			RequireTeleportTargetLoS = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.2,
			PostAttackDuration = 1.25,

			FireAnimation = "Enemy_Eris_FlyDown",
			PreAttackSetZHeight = 800,
			FireSetZHeight = 5,
			FireSetZDuration = 0.19,
		}
	},
	ErisRelocate_Down_P4 =
	{
		InheritFrom = { "ErisRelocate_Down", },
		AIData =
		{
			ChainedWeaponOptions = { "ErisLaserStrafeLeft3", "ErisLaserStrafeRight3", },
		},
	},

	ErisWindBuffet =
	{
		Requirements =
		{
			MinPlayerArc = 60,
			MaxPlayerDistance = 525,
			MaxConsecutiveUses = 1,
			MinAttacksBetweenUse = 6,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			AngleTowardsTargetWhileFiring = false,
			TrackTargetDuringCharge = false,

			ProjectileName = "ErisWindBuffet",
			FireProjectileAtSelf = true,

			AttackDistance = 9999,

			PreAttackFx = "ErisWindPreviewSpawner",

			PreAttackDuration = 0.6,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.08,
			FireDuration = 0.5,
			PostAttackDuration = 0.6,

			PreAttackAnimation = "Enemy_Eris_Wind_Start",
			FireAnimation = "Enemy_Eris_Wind_Fire",
			PostAttackAnimation = "Enemy_Eris_Wind_End"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/TisiphoneHarpySlowBeam" },
			},
		},
	},


	ErisLaserStrafeLeft =
	{
		Requirements =
		{
			MaxPlayerDistance = 700,
		},

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
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ExpireProjectilesOnHitStun = true,

			PreAttackFx = "ErisLaserAimLineLucifer",
			EndPreAttackFx = true,

			ProjectileName = "ErisLaser",
			--FireFx = "GunWeaponMuzzleFlash",

			FireSelfVelocity = 2000,
			FireSelfVelocityAngleOffset = 50,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGripLong,
			},
			TargetPlayer = true,
			CreateOwnTargetFromOriginalTarget = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.25,
			StopMoveWithinRange = true,
			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Player Sounds/ZagreusLuciferPreAttack",
			PreAttackAnimation = "Enemy_Eris_SprayPreFire",
			FireAnimation = "Enemy_Eris_SprayFire",
			PostAttackAnimation = "Enemy_Eris_SprayPostFire_Fast",
			PreAttackDuration = 0.72,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.01,
			FireDuration = 0.5,
			PostAttackDuration = 0.92,

			RequireProjectileLoS = true,
			LoSBuffer = 100,
			LoSEndBuffer = 32,
			AttackDistance = 700,
			AttackDistanceScaleY = 0.8,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
			},			

			WeaponFireLoopingSound = "/SFX/Player Sounds/ZagreusLuciferFireStartAndLoop",
		},
	},
	ErisLaserStrafeRight =
	{
		InheritFrom = { "ErisLaserStrafeLeft" },

		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocityAngleOffset = -50,
		},
	},
	ErisLaserStrafeLeft2 =
	{
		InheritFrom = { "ErisLaserStrafeLeft" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 20,
		},
	},
	ErisLaserStrafeRight2 =
	{
		InheritFrom = { "ErisLaserStrafeRight" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 20,
		},
	},

	ErisLaserStrafeLeft3 =
	{
		InheritFrom = { "ErisLaserStrafeLeft2" },
		Requirements = {},
		AIData =
		{
			DeepInheritance = true,
			PostAttackMinWaitTime = 0.83,
		},
	},
	ErisLaserStrafeRight3 =
	{
		InheritFrom = { "ErisLaserStrafeRight2" },
		Requirements = {},
		AIData =
		{
			DeepInheritance = true,
			PostAttackMinWaitTime = 0.83,
		},
	},

	ErisLaserSweepLeft =
	{
		Requirements =
		{
			MinPlayerDistance = 700,
		},

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
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ExpireProjectilesOnHitStun = true,

			PreAttackFx = "ErisLaserAimLineLucifer",
			EndPreAttackFx = true,

			ProjectileName = "ErisLaserSweep",

			FireSelfVelocity = 690,
			FireSelfVelocityAngleOffset = 180,
			FireSelfVelocityConsecutiveMultiplier = 0.995,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.7,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
			FireRotationDampening = 0.13,
			FireSetGoalAngleOffset = 90,

			CreateOwnTargetFromOriginalTarget = true,
			UseAngleBetweenTarget = true,
			TargetAngleOffset = -90,
			TargetOffsetDistance = 500,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Player Sounds/ZagreusLuciferPreAttack",
			PreAttackAnimation = "Enemy_Eris_SprayPreFire",
			FireAnimation = "Enemy_Eris_SprayFire",
			PostAttackAnimation = "Enemy_Eris_SprayPostFire_Fast",
			PreAttackDuration = 0.72,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.01,
			FireDuration = 0.7,
			PostAttackDuration = 0.92,

			RequireProjectileLoS = false,
			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
			},			

			WeaponFireLoopingSound = "/SFX/Player Sounds/ZagreusLuciferFireStartAndLoop",
		},
	},
	ErisLaserSweepRight =
	{
		InheritFrom = { "ErisLaserSweepLeft" },

		AIData =
		{
			DeepInheritance = true,

			FireSetGoalAngleOffset = -90,

			TargetAngleOffset = 90,
			TargetOffsetDistance = 500,
		},
	},
	ErisLaserSweepLeft2 =
	{
		InheritFrom = { "ErisLaserSweepLeft" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 15,
		},
	},
	ErisLaserSweepRight2 =
	{
		InheritFrom = { "ErisLaserSweepRight" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 15,
		},
	},

	ErisDashLucifer =
	{
		InheritFrom = { "ErisDash" },

		Requirements =
		{
			RequireUnitLoS = true,
			LoSStopsUnits = false,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ErisLaserDash",
			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 40 } },
				{ AIDataOverrides = { FireProjectileAngleRelative = -40 } },
			},
			BarrelLength = 25,

			FireTicks = 5,
			FireSelfVelocity = 1900,
			FireInterval = 0.08,

			PostAttackAnimation = "Enemy_Eris_StrafePostFire_Fast",
			PostAttackDuration = 0.92,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
		},
	},

	ErisBombClear =
	{
		InheritFrom = { "ErisDashLucifer" },

		Requirements =
		{
			RequireMinIdsOfTypes =
			{
				Names = { "GunBombUnit" },
				Count = 6,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			TargetClosestOfTypes = { "GunBombUnit" },
		},
	},

	ErisBackDashLucifer =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MaxPlayerDistance = 550,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "GunGrenadeTossLucifer",
			FireProjectileAtTarget = true,
			FireTicks = 1,
			FireInterval = 0.1,
			Spread = 10,
			CreateOwnTarget = true,
			TargetOffsetDistance = 300,
			ResetTargetPerTick = true,
			ImmuneToProjectileSlow = true,

			PreAttackEndStop = true,

			FireSelfVelocity = 2400,
			FireSelfVelocityAngleOffset = 180,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.24,
						Modifier = 0.6,
						HaltOnEnd = true,
					}
				},
			},

			WaitForAngleTowardTarget = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/Eris/EmoteCharging",
			PreAttackAnimation = "Enemy_Eris_GrenadePreFire_Fast",
			FireAnimation = "Enemy_Eris_GrenadeFire",
			PostAttackAnimation = "Enemy_Eris_GrenadePostFire_Fast",
			PreAttackDuration = 0.415,
			FireDuration = 0.35,
			PostAttackDuration = 0.42,

			--DumbFireWeapons = { "ErisKnockback" },

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisAttackVoiceLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
		},
	},
	ErisBackDashCombo =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ErisBackDashLucifer", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.1 }, },
			{ WeaponName = "ErisLaserSweepLeft", IgnoreRequirements = true, DataOverrides = { TargetSelf = true, UseAngleBetweenTarget = false, FireSetGoalAngleOffset = 60, TargetAngleOffset = -25, }, },
		},
	},

	ErisGrenadeLucifer =
	{
		InheritFrom = { "ErisGrenade" },

		Requirements =
		{
			MinAttacksBetweenUse = 9,
		},

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
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "GunGrenadeTossLucifer",

			FireProjectileStartDelay = 0.05,

			PreAttackDuration = 0.415,
			PreAttackAnimation = "Enemy_Eris_GrenadePreFire_Fast",
			FireDuration = 0.26,
			PostAttackDuration = 0.42,
			PostAttackAnimation = "Enemy_Eris_GrenadePostFire_Fast",
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
			},
		},
	},
	ErisGrenadeLuciferCluster01 =
	{
		InheritFrom = { "ErisGrenade" },

		Requirements =
		{
			MinAttacksBetweenUse = 5,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			FireTicks = 3,
			FireInterval = 0.55,
			FireProjectileAtTarget = true,

			ProjectileName = "GunGrenadeTossLucifer",
			FireProjectileStartDelay = 0.05,
			FireDuration = 0.26,
			PostAttackDuration = 0.42,
			PostAttackAnimation = "Enemy_Eris_GrenadePostFire_Fast",

			PreAttackVoiceLines =
			{	
				{ GlobalVoiceLines = "ErisGrenadeClusterVoiceLines" },
				{ GlobalVoiceLines = "ErisGrenadeVoiceLines" },
			},

			ChainedWeaponOptions = { "ErisEMSummonSelector" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},
	ErisGrenadeLuciferCluster02 =
	{
		InheritFrom = { "ErisGrenadeLuciferCluster01" },

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			FireTicks = 5,

			ChainedWeaponOptions = { "ErisEMSummonSelector2" },
		},
	},
	ErisGrenadeLuciferCluster03 =
	{
		InheritFrom = { "ErisGrenadeLuciferCluster01" },

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			FireTicks = 7,

			ChainedWeaponOptions = { "ErisBombClear", "ErisLaserStrafeLeft2", "ErisLaserStrafeRight2", "ErisLaserSweepLeft2", "ErisLaserSweepRight2" },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil