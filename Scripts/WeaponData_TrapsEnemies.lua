WeaponSetData =
{
	BloodMineToss =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			ProjectileName = "BloodMineToss",
			FireProjectileTowardTarget = true,
			
			Spread = 30,

			FireFx = "BloodlessGrenadierPotDropDust",

			PreLayDropAnimation = "Enemy_ThiefMineLayer_TossCharge",
			LayDropAnimation = "Enemy_ThiefMineLayer_TossFire",

			PreAttackAnimation = "Enemy_ThiefMineLayer_TossCharge",
			PostAttackAnimation = "Enemy_ThiefMineLayer_TossFire",

			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteAlerted",
			PreAttackDuration = 0.1,
			PostAttackDuration = 1.5,

			DropName = "BloodMine",
			SpawnDropAsUnit = true,
			DropOffsetZ = 100,
			DropUpwardForce = 500,
			DropScaleInDuration = 0.01,

			AttackOnMoveStart = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EnemyGrenadeMortarLaunch" },
			},
		},		
	},

	
	BattleStandardAoE =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BattleStandardAoE",
			FireProjectileAtSelf = true,
			FireFromTarget = true,
			
			PreAttackDuration = 0.4,
			FireDuration = 3.5,
			
			AttackDistance = 200,
			AIResetDistance = 250,
			PreAttackEndShake = false,
			PreAttackFx = "BattleStandardEmitFx",
			PreAttackLoopingSound = "/SFX/ThanatosCreepyBellLoop",
			EndPreAttackFx = true,

			PreAttackAnimation = "BattleStandardIdle",
			FireAnimation = "BattleStandardIdle",
			--PostAttackAnimation = "SafeZoneDisabled",
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	MiasmaGeyser =
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens" },
				HasNone = { "UpgradeChoice", "SpellScreen", "TalentScreen" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Miasma",
			FireProjectileTowardTarget = true,
			Range = 9999,
			Spread = 30,
			
			AttackDistance = 1200,

			PreAttackDuration = 0.7,
			PreAttackEndShake = true,
			PostAttackCooldownMin = 11.0,
			PostAttackCooldownMax = 14.0,
			PreAttackAnimation = "MiasmaGeyserPreFire",
			FireAnimation = "MiasmaGeyserFire",
			PostAttackAnimation = "MiasmaGeyserInactive",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/GasBomb" },
			},
		},
	},

	RootsAoE =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RootsDirect",
			FireAtAllTargetsWithinRange = 390,
			FireProjectileAtTarget = true,
			BarrelLength = 50,
			
			PreAttackDuration = 1.1,
			PostAttackCooldown = 9.5,
			
			AttackDistance = 370,
			AIResetDistance = 400,
			PreAttackEndShake = true,
			PreAttackFx = "RootingTreeWarningDecal",
			PreAttackAnimation = "RootingTreeIdle",
			FireAnimation = "RootingTreeActivated",
			PostAttackAnimation = "RootingTreeDisabled",
			PreAttackLoopingSound = "/SFX/ThanatosCreepyBellLoop",
			EndPreAttackFx = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	RootsAoESiegeVine =
	{
		AIData =
		{
			DeepInheritance = true,

			TriggerGroups =  { "HeroTeam" },
			TargetGroups = { "HeroTeam" },

			ProjectileName = "RootsDirectSiegeVine",
			FireAtAllTargetsWithinRange = 390,
			FireProjectileAtTarget = true,
			BarrelLength = 50,

			SkipCanAttack = true,
			
			PreAttackDuration = 0.0,
			FireDuration = 1.0,
			PostAttackCooldown = 5.5,
			
			AttackDistance = 370,
			FireFx = "RootsAoESiegeVineWarningDecal",
			--PreAttackLoopingSound = "/SFX/ThanatosCreepyBellLoop",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SiegeVine/EmoteCharging" },
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	CorruptedSpawns =
	{
		Requirements =
		{
			MaxActiveSpawns = 10,
			SpawnGroupName = "CorruptedSpawns",
		},

		AIData =
		{
			DeepInheritance = true,
			NoProjectile = true,

			PreAttackDuration = 3.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			SpawnBurstOnFire = true,
			SpawnRadius = 0,
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 5,
			SpawnerOptions =
			{
				"CorruptedShadeSmall", "CorruptedShadeMedium", 
			},
			SpawnsSkipActivatePresentation = true,
			SpawnAggroed = true,
			PreAttackEndShake = true,

			SkipFireWeapon = true,
			SkipMovement = true,
		},
	},

	SafeZone =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "SafeZoneDefense" },
				{ ProjectileName = "SafeZonePulse" },
			},
			ProjectileName = "SafeZonePulse",
			FireProjectileAtSelf = true,
			FireFromTarget = true,
			FireAsPlayerProjectile = true,
			FireStartFunctionName = "RecordSafeZoneFired",

			PreAttackDuration = 0.2,
			FireDuration = 5.0,
			PostAttackCooldown = 0.0,
			
			AttackDistance = 200,
			AIResetDistance = 250,
			PreAttackEndShake = true,
			--PreAttackFx = "RootingTreeWarningDecal",
			PreAttackLoopingSound = "/SFX/SafeZoneForcefieldLoop",
			EndPreAttackFx = true,

			PreAttackAnimation = "SafeZoneIdle",
			FireAnimation = "SafeZoneActivated",
			--PostAttackAnimation = "SafeZoneDisabled",

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.15,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 25 },
				},

				{ Cue = "/VO/MelinoeField_0274", Text = "Should stay in the circle...!" },
				{ Cue = "/VO/MelinoeField_0275", Text = "Safe in the circle..." },
				{ Cue = "/VO/MelinoeField_0276", Text = "Stay in the circle, Mel...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0277", Text = "The magick circle!" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	FloodTrapWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FloodTrapWeapon",
			BarrelLength = 170,

			FireTicks = 6,
			FireInterval = 0.55,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,

			PreAttackDuration = 0.8,
			FireDuration = 0.0,
			PostAttackDuration = 0, -- handled in RoomData

			--PreAttackEndShake = true,
			PreAttackAnimation = "FloodTrapPreparingToFire",
			PreAttackAnimation = "FloodTrapFiring",
			PostAttackAnimation = "FloodTrapIdle",
			FireFx = "FloodTrapFireFx",
		},


		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
			},
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},
	},

	BrambleTrapWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrambleTrap",

			PreAttackDuration = 0.0,
			FireDuration = 1.0,
			PostAttackDuration = 0.0,
			
			AttackDistance = 155,
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SteamTrapWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SteamTrap",
			FireProjectileAtSelf = true,

			PreAttackDuration = 0.2,
			FireDuration = 3.0,
			PostAttackDuration = 6.0,

			PreAttackAnimation = "SteamTrapPreparingToFire",
			FireAnimation = "SteamTrapFire",
			PostAttackAnimation = "SteamTrapReloading",
			
			AttackDistance = 160,
			AIResetDistance = 250,

			--PreAttackAnimation = "SpikeTrapPreFire",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/TrapSet",
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/SteamTrapFireSFX" },
			},
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
			},
		},
	},

	UnstableCauldronDamage =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "UnstableCauldronDamage",
			
			FireTicksMin = 2,
			FireTicksMax = 4,
			FireInterval = 0.2,
			ResetTargetPerTick = true,
			CreateOwnTarget = true,
			FireProjectileTowardTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 200,

			PreAttackDuration = 0.25,
			
			AttackDistance = 300,
			AIResetDistance = 310,
			PreAttackEndShake = true,
		},
	},

	UnstableCauldronHeal =
	{
		InheritFrom = {"UnstableCauldronDamage"},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "UnstableCauldronHeal",
		},
	},

	UnstableCauldronMana =
	{
		InheritFrom = {"UnstableCauldronDamage"},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "UnstableCauldronMana",
		},

		ManaDeltaOnHit = 10,
	},

	UnstableCauldronSlow =
	{
		InheritFrom = {"UnstableCauldronDamage"},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "UnstableCauldronSlow",
		},
	},

	LightningStorm =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LightningStormBolt",
			FireTicksMin = 1,
			FireTicksMax = 6,
			FireInterval = 0.05,
			ResetTargetPerTick = true,
			
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 420,
			TeleportToTargetId = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 1.5,
			PostAttackCooldownMax = 6.0,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ShipsBombardment =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ShipsBombardment",
			FireTicksMin = 8,
			FireTicksMax = 14,
			FireIntervalMin = 0.1,
			FireIntervalMax = 0.2,
			ResetTargetPerTick = true,
			
			TargetSpawnPoints = true,
			FireProjectileAtTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 6.5,
			PostAttackCooldownMax = 11.5,
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

	SlowPuddles =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SlowPuddle",
			
			FireTicksMin = 0,
			FireTicksMax = 5,
			ResetTargetPerTick = true,
			CreateOwnTarget = true,
			FireProjectileAtTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 25,
			TargetOffsetDistanceMax = 100,

			PreAttackAnimation = "Blank",
			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,
		},
	},

	ShatterCrystalCone =
	{
		AIData =
		{
			DeepInheritance = true,
			
			ProjectileName = "ShatterCrystalCone",
			
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackCooldown = 0.0,
			
			AttackDistance = 300,
			AIResetDistance = 310,
			PreAttackEndShake = true,
		},
	},

	DestructibleTreeSplinter =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DestructibleTreeSplinter",
			--FireProjectileTowardTarget = true,

			--FireTicksMin = 6,
			--FireTicksMax = 9,
			--FireInterval = 0.02,
			--ResetTargetPerTick = true,
			CreateOwnTarget = true,
			TargetOffsetDistance = 100,
			--TargetAngleSpread = 45,
			--TargetOffsetDistanceMin = 50,
			--TargetOffsetDistanceMax = 250,
			
			MoveWithinRange = false,
			PreAttackDuration = 0.0,
			FireWaitForAnimation = true,
			PostAttackDuration = 0.0,
			--FireAnimation = "DestructibleTree_01_Transition",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/TreeDestroyTemp" },
			},
		},
	},

	DestructibleMastSplinter =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DestructibleMastSplinter",
			CreateOwnTarget = true,
			TargetOffsetDistance = 100,
			
			MoveWithinRange = false,
			PreAttackDuration = 0.0,
			FireWaitForAnimation = true,
			PostAttackDuration = 0.0,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/TreeDestroyTemp" },
			},
		},
	},

	ThornTreeWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ThornTreeThorn",
			NumProjectiles = 3,
			ProjectileInterval = 0.04,
			Spread = 2,
			BarrelLength = 0,

			--CreateOwnTarget = true,
			--TargetOffsetDistance = 100,
			
			MoveWithinRange = false,
			AngleTowardTarget = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowRapidFire2" },
			},
		},
	},

	PuddleTileWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PuddleTile",
			TargetSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	OilPuddleSlick =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OilPuddleSlick",
			TargetSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,

			ForceUseIfReady = true
		},

		Requirements =
		{
			MaxUses = 1,
		},
	},

	OilPuddleSlick02 =
	{
		InheritFrom = { "OilPuddleSlick" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OilPuddleSlick02",
		},
	},

	OilPuddleSlick03 =
	{
		InheritFrom = { "OilPuddleSlick" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OilPuddleSlick03",
		},
	},

	OilPuddleSlick04 =
	{
		InheritFrom = { "OilPuddleSlick" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OilPuddleSlick04",
		},
	},

	GhostWallWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GhostWall",
			TargetSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	BeamTrap =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BeamTrap",

			FireProjectileAngle = 90,

			PreAttackEndShake = true,
			PreAttackDuration = 0.5,
			FireDuration = 9999.0,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 0.5,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = true,

			RequireUnitLoS = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Caster/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SpikeTrapClockwork =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SpikeTrapWeapon",

			TargetSelf = true,
			MoveWithinRange = false,

			PreAttackDuration = 0.2,
			FireDuration = 0.3,
			PostAttackDuration = 0.5,
			PreAttackEndShake = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/SpikeTrapFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SteamWallBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "SteamWallBlastWarning" },
				{ ProjectileName = "SteamWallBlast" },
			},
			FireProjectileAtSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeGasReleaseFly" },
			},
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
			},
		},	
	},

	SteamCubeExplosion =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "SteamCubeExplosion" },
				{ ProjectileName = "SteamTrapFast" },
			},
			FireProjectileAtSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,

			RemoveProjectileCollisionDuringAttack = true,

			WeaponFireLoopingSound = "/SFX/SteamTrapBurstLoop",

			FireAnimation = "SteamCubeDestroyed",

			PreAttackDuration = 0.0,
			WaitUntilProjectileDeath = "SteamTrapFast",
			PostAttackDuration = 0.0,
		},
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
			},
		},		
	},

	FireBarrelExplosion =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FireBarrelExplosion",
			TargetSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/LuciferBombExplosion" },
			},
		},
	},

	FireBarrelFireSpread =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FireBarrelFireLob",
			
			FireTicksMin = 3,
			FireTicksMax = 5,
			FireInterval = 0.025,
			ResetTargetPerTick = true,
			CreateOwnTarget = true,
			FireProjectileTowardTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 150,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
			ImmuneToProjectileSlow = true,
		},
	},

	CocoonSpawnBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CocoonSpawnBlast",

			FireAsPlayerProjectile = true,
			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	BlastCubeExplosion =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BlastCubeExplosion",

			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	MineBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MineBlast",

			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	SmokeTrapWeapon =
	{
		AIData =
		{
			DeepInheritance = true,
      		ProjectileName = "SmokeTrapWeapon",
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 10.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/GasBomb" },
			}
		},
	},

	OilPuddleIgnite =
	{
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,

		CancelArmorSpark = true,
		CancelRumble = true,
		CancelHitSpark = true,

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "OilPuddleFire" },
				{ ProjectileName = "OilPuddleFireFlying" },
			},
			FireAnimation = "OilPuddleLit",
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			SaveProjectileId = true,
		},
	},

	OilPuddleIgnite02 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "OilPuddleFire02" },
				{ ProjectileName = "OilPuddleFire02Flying" },
			},
			FireAnimation = "OilPuddle02Lit",
		},
	},

	OilPuddleIgnite03 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "OilPuddleFire03" },
				{ ProjectileName = "OilPuddleFire03Flying" },
			},
			FireAnimation = "OilPuddle03Lit",
		},
	},

	OilPuddleIgnite04 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlots =
			{
				{ ProjectileName = "OilPuddleFire04" },
				{ ProjectileName = "OilPuddleFire04Flying" },
			},
			FireAnimation = "OilPuddle04Lit",
		},
	},

	LavaTileWeapon =
	{
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,

		CancelArmorSpark = true,
		CancelRumble = true,
		CancelHitSpark = true,

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LavaTileWeapon",
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
	},

	LavaTileTriangle01Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LavaTileTriangle01Weapon"
		},
	},

	LavaTileTriangle02Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LavaTileTriangle02Weapon"
		},
	},

	LavaSplash =
	{
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaSplashPresentation", },
		MoveWithinRange = false
	},

	ZeusStatueLightningStorm =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZeusStatueLightningBolt",
			FireProjectileAtTarget = true,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 0 },
				{ UseAngleBetween = true, OffsetDistance = 250, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 20 },
				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 40 },
				{ UseAngleBetween = true, OffsetDistance = 350, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 60 },
				{ UseAngleBetween = true, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 80 },
				{ UseAngleBetween = true, OffsetDistance = 450, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 100 },
				{ UseAngleBetween = true, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 120 },
				{ UseAngleBetween = true, OffsetDistance = 550, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 140 },
				{ UseAngleBetween = true, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 160 },
				{ UseAngleBetween = true, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 180 },
				{ UseAngleBetween = true, OffsetDistance = 700, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 200 },
				{ UseAngleBetween = true, OffsetDistance = 750, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 220 },
				{ UseAngleBetween = true, OffsetDistance = 800, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 240 },
				{ UseAngleBetween = true, OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 260 },
				{ UseAngleBetween = true, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 280 },
				{ UseAngleBetween = true, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 300 },
				{ UseAngleBetween = true, OffsetDistance = 1000, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 320 },
				{ UseAngleBetween = true, OffsetDistance = 1050, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 340 },
				{ UseAngleBetween = true, OffsetDistance = 1100, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 360 },
			},
			AttackSlotInterval = 0.1,

			PreAttackAnimation = "ZeusStatuePreFire",
			PostAttackAnimation = "ZeusStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDuration = 10.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ZeusStatueLightningStorm2 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZeusStatueLightningBolt",
			FireProjectileAtTarget = true,

			FireTicksMin = 3,
			FireTicksMax = 12,
			FireInterval = 0.05,
			ResetTargetPerTick = true,
			TargetClosestToLastTarget = true,

			TargetFromGroup = "StatueTrapPoints",
			TargetRange = 1200,

			PreAttackAnimation = "ZeusStatuePreFire",
			PostAttackAnimation = "ZeusStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDuration = 10.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ZeusStatueChasingStorm =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZeusStatueChasingStorm",
			FireProjectileTowardTarget = true,
			BarrelLength = 125,
			Spread = 60,

			NumProjectiles = 3,
			ProjectileInterval = 0.3,

			PreAttackAnimation = "ZeusStatuePreFire",
			PostAttackAnimation = "ZeusStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDurationMin = 4.0,
			PostAttackDurationMax = 6.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFireball =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HestiaStatueFireball",
			FireProjectileTowardTarget = true,
			BarrelLength = 125,

			PreAttackAnimation = "HestiaStatuePreFire",
			PostAttackAnimation = "HestiaStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFireBalls =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HestiaStatueFireBall",
			BarrelLength = 50,
			NumProjectiles = 8,
			ProjectileAngleEvenlySpaced = true,

			PreAttackAnimation = "HestiaStatuePreFire",
			PostAttackAnimation = "HestiaStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDuration = 8.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFlamethrower =
	{
		AIData =
		{
			DeepInheritance = true,

			BarrelLength = 150,

			AttackSlots =
			{
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 }, ProjectileName = "HestiaStatueFlamethrower" },
				{ AnchorAngleOffset = 90, AIDataOverrides = { FireProjectileAngle = 0 }, ProjectileName = "HestiaStatueFlamethrower" },
				{ AnchorAngleOffset = 180, AIDataOverrides = { FireProjectileAngle = 0 }, ProjectileName = "HestiaStatueFlamethrower" },
				{ AnchorAngleOffset = 270, AIDataOverrides = { FireProjectileAngle = 0 }, ProjectileName = "HestiaStatueFlamethrower" },
			},

			FireProjectileAtTarget = true,
			FireProjectileTowardTarget = true,

			PreAttackEndShake = true,
			PreAttackDuration = 1.0,
			FireDuration = 3.5,
			PostAttackDurationMin = 2.85,
			PostAttackDurationMax = 3.65,

			PreAttackAnimation = "HestiaStatuePreFire",
			PostAttackAnimation = "HestiaStatueIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFlamethrowerDirect =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HestiaStatueFlamethrower",
			BarrelLength = 150,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.14,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.14,

			PreAttackEndShake = true,
			PreAttackDuration = 1.0,
			FireDuration = 3.5,
			PostAttackDurationMin = 2.85,
			PostAttackDurationMax = 3.65,

			PreAttackAnimation = "HestiaStatuePreFire",
			PostAttackAnimation = "HestiaStatueIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueRing =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HestiaStatueRing",
			BarrelLength = 0,

			PreAttackDuration = 1.4,
			FireDuration = 7.0,
			PostAttackDuration = 7.8,

			PreAttackAnimation = "HestiaStatuePreFire",
			PostAttackAnimation = "HestiaStatueIdle",

			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/HecateShockwaveRingSFX" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	PoseidonStatueWave =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PoseidonStatueWave",

			BarrelLength = 100,

			NumProjectiles = 5,
			ProjectileInterval = 0.05,
			ProjectileAngleInterval = 20,
			TargetFromGroup = "StatueTrapPoints",
			TargetRange = 800,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

			PreAttackAnimation = "PoseidonStatuePreFire",
			PostAttackAnimation = "PoseidonStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.85,
			PostAttackDurationMax = 5.65,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	DemeterStatueFrostStorm =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DemeterStatueFrostStorm",
			FireProjectileTowardTarget = true,
			BarrelLength = 200,

			TargetFromGroup = "StatueTrapPoints",
			TargetRange = 800,

			PreAttackAnimation = "DemeterStatuePreFire",
			PostAttackAnimation = "DemeterStatueIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 0.9,
			FireDuration = 0.0,
			PostAttackDuration = 6.0,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	EliteLavaSplash =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LavaSplash",

			DumbFireIntervalMin = 1.0,
			DumbFireIntervalMax = 5.0,
		},
	},

	EliteSpreadHitShields =
	{
		AIData =
		{
			DeepInheritance = true,
			TargetSelf = true,

			ProjectileName = "EliteSpreadHitShields",

			DumbFireWakeUpDelayMin = 1.0,
			DumbFireWakeUpDelayMax = 4.0,

			DumbFireIntervalMin = 9.5,
			DumbFireIntervalMax = 10.5,
			EndDumbFireOnTimesFired = 5,
		}
	},

	EliteManaDrain =
	{
		ProjectileName = "EliteManaDrain",

		SkipCanAttack = true,
		CancelOnPolymorph = true,
		ExpireProjectilesOnPolymorph = true,

		DumbFireInterval = 10.0,
	},

	EliteRooting =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 710,
			PreAttackFx = "TreantRootsPreviewFx",
			EndPreAttackFx = true,

			ProjectileName = "EliteRooting",
			FireProjectileAtSelf = true,

			PreAttackDuration = 1.0,

			DumbFireWakeUpDelayMin = 1.0,
			DumbFireWakeUpDelayMax = 4.0,

			DumbFireIntervalMin = 7.5,
			DumbFireIntervalMax = 8.5,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	EliteStasisDeath =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteStasisDeath",
			FireProjectileAtSelf = true,

			PreAttackFx = "StasisDeathPreviewA_In",
			EndPreAttackFx = true,

			PreAttackDuration = 1.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrab" },
			},
		},
	},

	EliteCastOrbit =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteBoltOrbit",
			NumProjectiles = 3,
			ProjectileAngleEvenlySpaced = true,
			--DumbFireInterval = 20.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosScytheWhirlStart" },
			},
		},
	},

	EliteRadialBeams =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteRadialBeam",

			DumbFireInterval = 6.0,
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingRanged" },
			},
		},
	},

	EliteVacuum =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteVacuum",
			FireProjectileAtSelf = true,

			DumbFireInterval = 6.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosSuctionStart" },
			},
		},
	},

	EliteRushRipple =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "EliteRift", UseAttackerAngle = true, },
				{ ProjectileName = "EliteRift", UseAttackerAngle = true, },
				{ ProjectileName = "EliteRift", UseAttackerAngle = true, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ ProjectileName = "EliteRift", UseAttackerAngle = true, },
				{ ProjectileName = "EliteRift", UseAttackerAngle = true, },
			},
			AttackSlotInterval = 0.06,
			FireProjectileAtSelf = true,
			FireFromTarget = true,

			DumbFireWeapons = {},
		}
	},

	EliteHex =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteHex",

			PreAttackFx = "EliteHexWarningDecal",
			EndPreAttackFx = true,

			PreAttackDuration = 1.0,

			DumbFireWakeUpDelayMin = 4.0,
			DumbFireWakeUpDelayMax = 8.0,

			DumbFireIntervalMin = 12.0,
			DumbFireIntervalMax = 20.0,

			FireFx = "StaffProjectileFireFx1_Hecate",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil