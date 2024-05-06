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
			ProjectileName = "OilPuddleFire",
			FireAnimation = "OilPuddleLit",
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
	},

	OilPuddleIgnite02 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "OilPuddleFire02",
			FireAnimation = "OilPuddle02Lit",
		},
	},

	OilPuddleIgnite03 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "OilPuddleFire03",
			FireAnimation = "OilPuddle03Lit",
		},
	},

	OilPuddleIgnite04 =
	{
		InheritFrom = { "OilPuddleIgnite" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "OilPuddleFire04",
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
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil