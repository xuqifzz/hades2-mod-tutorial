UnitSetData.TyphonEye =
{
	TyphonEye =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },
		Material = "Organic",
		IsBoss = false,
		ImmuneToPolymorph = true,
		BlockCharm = true,
		BlockPostBossMetaUpgrades = true,
		BlockRaiseDead = true,
		Groups = { "GroundEnemies" },
		RunHistoryPortrait = "Codex_Portrait_TyphonEye",

		SpawnAnimation = "Enemy_TyphonEye_Shut_FireLoop",

		DeathAnimation = "Enemy_TyphonEye_Death",
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "TyphonEyeDefeatedMessage",
			CameraPanTime = 1.5,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			BatsAfterDeath = false,
			FlashRed = true,
			DestroyGroup = "FightEndDestroy",
			BlockMapSpawns = true,
			PanZoomFraction = 0.8,
		},
		DeathPanOffsetY = -300,

		AngleMin = 210,
		AngleMax = 220,

		MaxHealth = 25000,
		AISetupDelay = 0.5,

		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		InvulnerableHitSound = "/Leftovers/World Sounds/PhysicalImpact",
		InvulnerableHitFlash = true,
		InvulnerableBlockHint = true,
		OnHitFunctionName = "CheckUnitInvulnerableHit",

		SkipTransitionInvulnerability = true,
		AIEndHealthThreshold = 0.0,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},
		
		DefaultAIData =
		{
			DeepInheritance = true,
		},
		WeaponOptions =
		{
			"TyphonEyeCannon", "TyphonEyeSkyCast", "TyphonEyeSpawnEyeball"
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.TyphonEye )


WeaponSetData =
{
	TyphonEyeCannon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonEyeCannon",

			FireProjectileStartDelay = 0.12,
			AttackSlots =
			{
				{ AIDataOverrides = { SpawnFromMarker = "TyphonEye_Rig:eyeLidTweakLwr00_01_M_JNT", }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonEye_Rig:eyeLidTweakLwr00_02_M_JNT", }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonEye_Rig:eyeLidTweakLwr00_04_M_JNT", }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonEye_Rig:eyeLidTweakInner00_00_M_JNT", }, },
			},

			ImmuneToProjectileSlow = true,

			FireProjectileAtTarget = true,
			FireProjectileTowardTarget = true,
			Spread = 30,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/EmotePowerCharging",
			PreAttackDuration = 1.67,
			FireDuration = 0.58,
			PostAttackDuration = 2.0,

			PreAttackAnimation = "Enemy_TyphonEye_Sustain_Start",
			FireAnimation = "Enemy_TyphonEye_Sustain_Fire",
			PostAttackAnimation = "Enemy_TyphonEye_Sustain_End",

			AttackDistance = 9999,
			MoveWithinRange = false,

			AngleTowardsTargetWhileFiring = true,
			TrackTargetDuringCharge = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/TyphonEyeball/TyphonEyeballProjectileFire" },
			},
		},
	},

	TyphonEyeSkyCast =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
			MinPlayerDistance = 1500,
			MinPlayerDistanceScaleY = 0.5,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackDumbFireWeapons = { "TyphonEyeSky" },

			NoProjectile = true,

			PreAttackDuration = 4.0,
			FireDuration = 1.0,
			PostAttackDuration = 1.5,

			PreAttackAnimation = "Enemy_TyphonEye_Shut_Start",
			FireAnimation = "Enemy_TyphonEye_Shut_End",

			AttackDistance = 9999,
			MoveWithinRange = false,

			AngleTowardsTargetWhileFiring = true,
			TrackTargetDuringCharge = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_HeadAttackEmerge" },
			},
		},
	},

	TyphonEyeSky =
	{
		AIData =
		{
			DeepInheritance = true,

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			PreAttackDuration = 0.83,

			ProjectileName = "TyphonEyeSkyCast",
			AttackSlotInterval = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = 774553 },
				{ UseMapObjectId = 774751 },
				{ UseMapObjectId = 774750 },
				{ UseMapObjectId = 774556 },
				{ UseMapObjectId = 774555 },
				{ UseMapObjectId = 774749 },
				{ UseMapObjectId = 774558 },
				{ UseMapObjectId = 774748 },
				{ UseMapObjectId = 774747 },
				{ UseMapObjectId = 774746 },
			},
			RandomizeAttackSlotOrder = true,
		}
	},

	TyphonEyeSpawnEyeball =
	{
		Requirements =
		{
			RequireMaxIdsOfType = { Name = "Eyeball", Count = 0 },
			HealthPercentMin = 0.2,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SkipLocationBlockedCheck = true,
			--SpawnTowardSpawnPoints = true,
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 1,
			SpawnerOptions = { "Eyeball" },
			SpawnOnId = 779803,
			SpawnForce = 1400,
			SpawnOffsetX = 50,
			SpawnSound = "/SFX/Enemy Sounds/TyphonEyeball/TyphonEyballOpen",

			DamageSelfOnWeaponFire = 2500,

			UseTargetId = 779803,
			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			PreAttackStop = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			FireProjectileStartDelay = 0.04,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/EmoteCharging",
			PreAttackAnimation = "Enemy_TyphonEye_SpawnEyeball_Start",
			FireAnimation = "Enemy_TyphonEye_SpawnEyeball_Fire",
			PostAttackAnimation = "Enemy_TyphonEye_Shut_End",

			PreAttackDuration = 1.83,
			FireDuration = 3.0,
			PostAttackDurationMin = 2.35,
			PostAttackDurationMax = 2.85,

			AttackVoiceLines =
			{
				Queue = "Interrupt",
				PlayOnce = true,
				PlayOnceContext = "TyphonEyeIntroSpeech",
				PlayOnceFromTableThisRun = true,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				PreLineWait = 0.75,
				UsePlayerSource = true,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_0714", Text = "What the?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1925", Text = "Uh-oh!" },
				{ Cue = "/VO/Melinoe_1929", Text = "{#Emph}Urgh..." },
			},
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 9,
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil