WeaponSetData =
{
	RubbleFall =
	{
		StartingWeapon = false,

		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		Upgrades = { },
		KillText = "RubbleSlamKill",

		ImpactSounds =
		{
			Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Bone = "/SFX/ArrowMetalBoneSmash",
			Brick = "/SFX/ArrowMetalStoneClang",
			Stone = "/SFX/ArrowMetalStoneClang",
			Organic = "/SFX/ArrowImpactSplatter",
			StoneObstacle = "/SFX/ArrowWallHitClankSmall",
			BrickObstacle = "/SFX/ArrowWallHitClankSmall",
			MetalObstacle = "/SFX/ArrowWallHitClankSmall",
			BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
		},
	},

	RubbleFallLarge =
	{
		InheritFrom = { "RubbleFall", },
	},

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

			FireFx = "BattleStandardFxEmitter",

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

			ConditionalProjectiles =
			{
				{
					ProjectileName = "FloodTrapWeapon",

					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							Comparison = "~=",
							Value = "G_Boss02",
						},
					},
				},
				{
					ProjectileName = "FloodTrapWeapon2",

					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							Comparison = "==",
							Value = "G_Boss02",
						},
					},
				}
			},
			BarrelLength = 170,

			FireTicks = 6,
			FireInterval = 0.55,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,

			PreAttackDuration = 0.55,
			FireDuration = 0.0,
			PostAttackDuration = 0, -- handled in RoomData

			--PreAttackEndShake = true,
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
	},

	TyphonSpikeSplinter =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonSpikeSplinter",

			FireAsPlayerProjectile = true,
			TargetSelf = true,
			FireFromTarget = true,
			SkipCanAttack = true,

			CreateOwnTargetFromOriginalTarget = true,
			TargetOffsetDistance = 100,
			PostAttackKillSelf = true,

			MoveWithinRange = false,
			PreAttackDuration = 0.0,
			FireWaitForAnimation = true,
			PostAttackDuration = 0.0,
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

	FireBarrelExplosionShips =
	{
		InheritFrom = { "FireBarrelExplosion" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FireBarrelExplosionShips",
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

	EyeBombExplosion =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EyeBombExplosion",

			FireProjectileAtSelf = true,
			FireFromSelf = true,

			PreAttackAnimation = "EyeBombExploding",

			PreAttackEndDuration = 1.0,
			PreAttackEndShake = true,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
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
			PreAttackDuration = 0.05,
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
			ImmuneToProjectileSlow = true,

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
	},

	ZeusStatueLightningStorm2 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZeusStatueChasingStorm",
			FireProjectileAtTarget = true,
			ImmuneToProjectileSlow = true,

			FireTicksMin = 3,
			FireTicksMax = 12,
			FireInterval = 0.05,
			ResetTargetPerTick = true,
			TargetClosestToLastTarget = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsNearSelf = true,
			TargetSpawnPointsRadius = 1200,

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
				{ Name = "/SFX/Player Sounds/ZeusLightningImpact" },
			},
		},
	},

	ZeusStatueChasingStorm =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "ZeusStatueChasingStorm",

			ProjectileName = "ZeusStatueChasingStorm",
			FireProjectileAtTarget = true,
			TargetRequiredKillEnemy = true,
			TargetClosest = true,
			ImmuneToProjectileSlow = true,

			ProjectileDestinationOffsetFromTarget = true,
			ProjectileOffsetRandomAngle = true,
			ProjectileOffsetDistanceMin = 100,
			ProjectileOffsetDistanceMax = 400,

			FireTicksMin = 5,
			FireTicksMax = 7,
			FireInterval = 0.2,
			ResetTargetPerTick = true,

			PreAttackAnimation = "ZeusStatuePreFire",
			PreAttackDuration = 0.5,
			PostAttackAnimation = "ZeusStatueDepleted",

			FireFromSelf = true,
			FireAsPlayerProjectile = true,
			FireFromTarget = true,
			SkipCanAttack = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZeusLightningImpact" },
			},
		},
	},

	HestiaStatueFireballs =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "HestiaStatueFireballs",
			ImmuneToProjectileSlow = true,

			ProjectileName = "HestiaStatueFireball",
			BarrelLength = 170,
			NumProjectiles = 8,
			ProjectileInterval = 0.05,
			ProjectileAngleEvenlySpaced = true,

			PreAttackAnimation = "HestiaStatuePreFire",
			PreAttackDuration = 0.5,
			PostAttackAnimation = "HestiaStatueDepleted",

			FireAsPlayerProjectile = true,
			FireProjectileAtSelf = true,
			FireFromTarget = true,
			SkipCanAttack = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/HestiaFireballImpactSingle" },
			},
		},
	},

	PoseidonStatueWave =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "PoseidonStatueWave",
			ImmuneToProjectileSlow = true,
			
			ProjectileName = "PoseidonStatueWave",

			BarrelLength = 50,

			FireAtAllTargetsWithinRange = 800,
			TargetGroups = "StatueTrapPoints",
			FireFromSelf = true,

			PreAttackAnimation = "PoseidonStatuePreFire",
			PreAttackDuration = 0.5,
			PostAttackAnimation = "PoseidonStatueDepleted",
			
			FireProjectileTowardTarget = true,
			FireAsPlayerProjectile = true,
			SkipCanAttack = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/PoseidonWaterArrowFireLong" },
			},
		},
	},

	DemeterStatueFrostStorm =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "DemeterStatueFrostStorm",
			ImmuneToProjectileSlow = true,

			ProjectileName = "DemeterStatueFrostStorm",
			BarrelLength = 200,

			FireAtAllTargetsWithinRange = 800,
			TargetGroups = "StatueTrapPoints",
			FireFromSelf = true,

			PreAttackAnimation = "DemeterStatuePreFire",
			PreAttackDuration = 0.5,
			PostAttackAnimation = "DemeterStatueDepleted",

			FireProjectileTowardTarget = true,
			FireAsPlayerProjectile = true,
			SkipCanAttack = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/DemeterColdNova" },
			},
		},
	},

	TyphonSpike =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonSpike",

			TargetSelf = true,
			MoveWithinRange = false,

			PreAttackEndShake = true,
			PreAttackDuration = 0.2,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			PreAttackAnimation = "TyphonMinePreFire",
			FireAnimation = "TyphonMineFire",
			PostAttackAnimation = "TyphonMineDepleted",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",

			SpawnObstaclesOnFire = { "TyphonSpike", },
			SpawnedObstaclesSyncFlip = true,
			
			AttackDistance = 100,

			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TailPincerAttack" },
			},
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

			-- Rifts ban
			DumbFireWeapons = {},
		},
	},

	EliteSpreadHitShields =
	{
		AIData =
		{
			DeepInheritance = true,
			TargetSelf = true,

			ProjectileName = "EliteSpreadHitShields",

			DumbFireWakeUpDelayMin = 2.5,
			DumbFireWakeUpDelayMax = 4.0,

			DumbFireIntervalMin = 9.5,
			DumbFireIntervalMax = 10.5,
			EndDumbFireOnTimesFired = 5,

			-- Rifts ban
			DumbFireWeapons = {},
		}
	},

	EliteManaDrain =
	{
		AIData =
		{
			ProjectileName = "EliteManaDrain",

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			ExpireProjectilesOnPolymorph = true,

			DumbFireInterval = 10.0,

			-- Rifts ban
			DumbFireWeapons = {},
		},
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

			-- Rifts ban
			DumbFireWeapons = {},
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

			ProjectileName = "EliteStasisDeathOrb",
			FireProjectileAtSelf = true,

			PreAttackStop = true,
			PreAttackDuration = 0.0,

			-- Rifts ban
			DumbFireWeapons = {},
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
			NumProjectiles = 1,
			ProjectileAngleEvenlySpaced = true,
			--DumbFireInterval = 20.0,

			-- Rifts ban
			DumbFireWeapons = {},
		},
	},

	EliteRadialBeams =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EliteRadialBeam",

			ExpireProjectilesOnFreeze = true,

			DumbFireInterval = 6.0,

			-- Rifts ban
			DumbFireWeapons = {},
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

			-- Rifts ban
			DumbFireWeapons = {},
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

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},
	},

	TyphonEggDeathWeapon =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "TyphonEggDeathWeapon",

			ProjectileName = "TyphonEggExplosion",

			PreAttackLoopingSound = "/SFX/BombFusePreExplode",
			PreAttackDurationMin = 0.5,
			PreAttackDurationMax = 1.5,
			PreAttackEndShake = true,
			PreAttackEndFullDuration = true,

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			SkipCanAttack = true,
		},
	},

	TyphonEggDeathWeaponLarge =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "TyphonEggDeathWeapon",

			ProjectileName = "TyphonEggExplosionLarge",

			PreAttackLoopingSound = "/SFX/BombFusePreExplode",
			PreAttackDurationMin = 0.5,
			PreAttackDurationMax = 1.5,
			PreAttackEndShake = true,
			PreAttackEndFullDuration = true,

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			SkipCanAttack = true,
		},
	},

	TyphonEggDeathWeapon2 =
	{
		AIData =
		{
			DeepInheritance = true,
			WeaponName = "TyphonEggDeathWeapon2",

			ProjectileName = "TyphonEggRadial",

			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			FireDuration = 5.0,

			BarrelLength = 100,
			NumProjectiles = 3,
			ProjectileAngleEvenlySpaced = true,

			FireAsPlayerProjectile = true,
			FireProjectileAtSelf = true,
			FireFromTarget = true,
			SkipCanAttack = true,
		},
	},

	GunBombWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GunBombWeapon",
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

	GunBombImmolation =
	{
		AIData =
		{
			ProjectileName = "GunBombImmolation",
			TargetSelf = true,

			MoveWithinRange = false,
			AttackDistance = 9999999,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			DumbFireInterval = 1.0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil