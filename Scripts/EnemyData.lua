

CollisionReactionData =
{
	WallSlam =
	{
		MinVelocity = 700,
		Cooldown = 0.25,
		Damage = 
		{
			PerVelocity = 0.01,
		}
	}
}

ConstantsData.DefaultHealthBarOffsetY = -155

UnitSetData.Enemies =
{
	-- Top-level inheritance
	IsNeutral =
	{
		DamageType = "Neutral",
		TriggersOnDamageEffects = false,
		TriggersOnHitEffects = true,
		SkipModifiers = true,
		DropItemsOnDeath = false,
		BlockWrathGain = true,
		BlocksLootInteraction = false,
		SimulationSlowOnHit = false,
		UseShrineUpgrades = false,
		CanBeFrozen = false,
		AggroMinimumDistance = 500,
		SkipDamageText = true,
		SkipDamagePresentation = true,
		HideLevelDisplay = true,
		BlockLifeSteal = true,
		BlockPolymorph = true,
		IgnoreAutoLock = true,
		MaxHitShields = 5,
	},

	LowPolyEnemy = 
	{
		PolymorphModelOverride = "PolyphemusSheepSmall_Mesh",
	},

	BaseVulnerableEnemy =
	{
		HitInvulnerableText = "Combat_Invulnerable",
		InvulnerableFx = "Invincibubble",
		Material = "Organic",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamaged",
			Rapid = "HitSparkEnemyDamagedRapid",
		},
		StunAnimationOrder = 
		{
			Heavy = 1,
			Light = 2,
			Default = 1,
			Lightning = 1,
			BlockStun = 2,
		},
		InvulnerableHitFx = "InvincibleHitSpark",
		DamageType = "Enemy",
		DestroyDelay = 2.0,
		
		StunAnimations = 
		{
			Default = "Blank",
		},
		--StopOnHitStun = true,
		EndThreadWaitsOnStun = true,
		Groups = { "GroundEnemies" },
		AddToEnemyTeam = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Swarmer/EmoteAlerted",
		
		UseActivatePresentation = true,
		-- ActivateAnimation = "AresBladeSpinOut",
		
		ActivateFx = "EnemyPreSpawnTerrain",
		ActivateFx2 = "EnemyPreSpawnStanding",
		ActivateFxPreSpawn = "EnemySpawnBurst",
		ActivateFxPreSpawnDelay = 1.50,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.50,
		ActivateFadeInDuration = 1.00,
		ActivateTint = true,
		ActivateTintDelay = 1.50,
		ActivateTintDuration = 0.25,
		ActivateStartAlpha = 0, 
		ActivateDuration = 1.8,

		DeathAnimation = "EnemyDeathFx",
		--,
		DeathSound = "/SFX/Enemy Sounds/EnemyDeathSFXIris",

		TriggersOnDamageEffects = true,
		TriggersOnHitEffects = true,
		DropItemsOnDeath  = true,
		BlocksLootInteraction = true,
		SimulationSlowOnHit = true,
		UseShrineUpgrades = true,
		RequiredKill = true,
		AggroIfLastAlive = true,
		CanBeFrozen = true,
		ChainAggroAllEnemies = true,
		CanBeChainAggroed = true,

		HealthBufferedGripBonus = 0,
		HealthBufferedRegenAmount = 0.01,
		HealthBufferedRegenTick = 0.05,
		HealthBufferedRegenHitDelay = 1.0,

		AIAggroRange = 600,
		AggroReactionTimeMin = 0.05,
		AggroReactionTimeMax = 0.2,
		AIWanderDistance = 200,
		RotateOnAggro = true,
		PreSpawnAggroReactionTimeMin = 0.05,
		PreSpawnAggroReactionTimeMax = 0.45,
		NoTargetWanderDuration = 1.0,
		NoTargetWanderDistance = 200,

		MaxHitShields = 5,

		BlockDamageNumbersByGroups = { "EnemyTeam" },

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackStop = false,
			PreAttackEndStop = false,
			PostAttackStop = false,
			PreAttackAngleTowardTarget = true,
			MoveWithinRange = true,
			StopMoveWithinRange = true,

			SkipSelfVelocityIfImpactSlow = false,

			DontRetreatIfCharmed = true,

			--PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			--PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",

			AttackDistanceBuffer = 50,
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			PostAggroAI = "AttackerAI",
		},
		SpellSummonDefaultAIDataOverrides =
		{
			SurroundAIKey = "SummonedUnit",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		HeraclesCombatMoneyValue = 1,
		
		-- Wall Slam
		CollisionReactions =
		{
			CollisionReactionData.WallSlam,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
		IncomingDamageModifiers =
		{
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
		},
		ProjectilesCollideWithGroupsCharmed =
		{
			"EnemyTeam"
		},

		GeneratorData =
		{
			DifficultyRating = 1,
		},
	},

	BaseBossEnemy =
	{
		IsBoss = true,
		UseBossHealthBar = true,
		UseActivatePresentation = false,
		BlockRespawnShrineUpgrade = true,
		IgnoreFinalEnemyDirectionHint = true,
		IgnoreCastSlow = true,
		NeverLeavesShadeMerc = true,

		SkipAISetupOnActivate = true,
		ManualDeathAnimation = true,
		
		ClearChillOnDeath = true,

		ShrineUpgradeName = "BossDifficultyShrineUpgrade",
		BossDifficultyShrineRequiredCount = 4,

		IncomingDamageModifiers =
		{
			{
				Name = "BaseVulnerability", 
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		StunAnimations = 
		{
		},
	},

	Elite =
	{
		IsElite = true,
		EliteIcon = true,
		AddOutlineImmediately = true,

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
			FadeInDuration = 0.6,
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		EliteAttributeOptions = EnemySets.GenericEliteAttributes,
		EliteAttributeData =
		{
			DeepInheritance = true,
			
			-- Blink: Teleports to a random spawn point every so often
			Blink =
			{
				AIDataOverrides =
				{
					PreMoveTeleport = true,
					TeleportationIntervalMin = 5.5,
					TeleportationIntervalMax = 9.0,
					TeleportStartFx = "BlinkStart",
					TeleportEndFx = "BlinkEnd",
					TeleportPreWaitFx = "BlinkPreWait",
					PreTeleportWait = 0.5,
					PostTeleportWait = 0.2,
					AngleTowardsTeleportTarget = true,
				},
				BlockAttributes = { "Orbit" },
			},

			-- Frenzy: 50% enemy attack and move speed
			Frenzy =
			{
				DataOverrides =
				{
					EliteAdditionalSpeedMultiplier = 0.5,
					AttachedAnimationName = "EliteUnitStatus2"
				},
				BlockAttributes = { "Homing", "Vacuuming" },
			},

			-- HeavyArmor: 50% armor increase
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 1.5,
					HealthBarType = "ExtraLarge",
				},
				RequiresFalseSuperElite = true,
			},

			-- ExtraDamage: Increased damage + hitstun
			ExtraDamage =
			{
				DataOverrides =
				{
					AttachedAnimationName = "EliteUnitStatus",
					OnDealDamageFunctionName = "ShrineEliteAttributeHitStun",		
					OnDealDamageFunctionArgs =
					{
						EffectName = "EliteAttributeStun",
						Cooldown = 1.5,
						DataProperties = 
						{
							Duration = 0.1,
						}
					},
				},
				BlockAttributes = { "Molten" },

				AddOutgoingDamageModifiers =
				{
					{
						PlayerMultiplier = 2.0,
					},
				},
			},

			SpreadHitShields =
			{
				DifficultyRatingMultiplier = 1.2,
				AddDumbFireWeaponsOnSpawn = { "EliteSpreadHitShields" },
			},

			Vacuuming =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteVacuum" },
				BlockAttributes = { "Frenzy" },
			},

			Molten =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteLavaSplash" },

				BlockAttributes = { "ExtraDamage" },
			},

			Homing =
			{
				AIDataOverrides =
				{
					ProjectileDataOverrides = 
					{
						MaxAdjustRate = math.rad(60),
						AdjustRateAcceleration = math.rad(-20),
					}
				},
				BlockAttributes = { "Frenzy" },
			},

			Tracking =
			{
				AIDataOverrides =
				{
					PreAttackAngleTowardTarget = true,
					TrackTargetDuringCharge = true,
					AngleTowardsTargetWhileFiring = true,
				},
			},

			ManaDrain =
			{
				DifficultyRatingMultiplier = 1.2,
				AddDumbFireWeaponsOnSpawn = { "EliteManaDrain" },
			},

			Unflinching =
			{
				DataOverrides =
				{
					StunAnimations = {},
					WasImmuneToStunWithoutArmor = true,
					PlayStunAnimationOnHealthBufferDeplete = false,
				},
				UnitPropertyChanges =
				{
					{
						UnitProperty = "ImmuneToStun",
						ChangeValue = true,
					},
				},
			},

			Orbit =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteCastOrbit" },
				BlockAttributes = { "Blink" },
			},

			Massive =
			{
				ScaleMultiplier = 1.5,
				DataOverrides =
				{
					HealthMultiplier = 1.2,
					HealthBarType = "Large",
				},
				AIDataOverrides =
				{
					ProjectileScaleMultiplier = 1.5,
					ProjectileBlastRadiusMultiplier = 1.5,
				},
			},

			Rooting =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "H" },
					},
				},
				AddDumbFireWeaponsOnSpawn = { "EliteRooting" },
			},

			Rifts =
			{
				AIDataOverrides =
				{
					DumbFireWeapons = { "EliteRushRipple" },
				},
			},

			StasisDeath =
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", "N_SubRooms", "O", "P", },
					},
				},
				AddDeathWeapons = { "EliteStasisDeath" },
			},

			Radial =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteRadialBeams" },
			},

			Miasma =
			{
				DataOverrides =
				{
					OnDamagedFireProjectilesCooldown = 2.0,
					OnDamagedFireProjectiles =
					{
						{
							ProjectileName = "EliteMiasmaLob",
							Spread = 360,
						},
					}
				},
			},

			Fog =
			{
				MaxPerRoom = 1,

				AddAdditionalAIFunctions = { "FogAI" },
				DataOverrides =
				{
					StopAnimationsOnDeath = { "FogEmitterInside", "FogEmitterOutside" },
				},
				BlockAttributes = { "Metallic" },

				AIDataOverrides =
				{
					FogRadius = 725,
					FogRadiusScaleY = 0.85,
					EnterFogRadiusBuffer = 0,
					ExitFogRadiusBuffer = 0,
					OutsideFogFx = "FogEmitterOutside",
					InsideFogFx = "FogEmitterInside",
				},
			},

			Hex =
			{
				MaxPerRoom = 1,
				AddDumbFireWeaponsOnSpawn = { "EliteHex" },
			},

			Metallic =
			{
				MaxPerRoom = 1,
				
				AddAdditionalAIFunctions = { "EliteMetallicInvulnerability" },
				DataOverrides =
				{
					InvulnerableFx = "Invincibubble",
				},
				BlockAttributes = { "Fog" },
			},
		},
	},

	SuperElite =
	{
		IsSuperElite = true,

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.85,
		},
	},

	Shadow =
	{
		AddOutlineImmediately = true,
		BlockRespawnShrineUpgrade = true,

		Outline =
		{
			R = 128,
			G = 0,
			B = 250,
			Opacity = 0.7,
			Thickness = 3,
			Threshold = 0.6,
			FadeInDuration = 0.6,
		},
	},

	BaseOEnemy =
	{
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.125,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	BasePEnemy =
	{
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.035,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	BaseQEnemy =
	{
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.16,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	-- Oceanus Base
	OceanusUnitData =
	{
		DoActivateFxAtNearestTypeId = "EnemyPointRanged",
		ActivateFx = "WaterUnitSurface",
		ActivateFx2 = "nil",
		ActivateVerticalForce = 2300,
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateTint = false,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.95,
		RequiredSpawnPoint = "EnemyPointMelee",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedFish",
			Rapid = "HitSparkEnemyDamagedFishRapid",
		},
		--IntroEncounterName = "FishmanIntro",
	},

	-- Olympus

	BaseAutomaton =
	{
		AIAggroRange = 1200,

		PreferredSpawnPoint = "EnemyPointSupport",
		SpawnCloseToGroup = "Automatons",

		AIWanderDistance = 2000,
		AggroAIRefreshDurationMin = 5.0,
		AggroAIRefreshDurationMax = 10.0,
		AIWanderFrequency = 5.0,
		AmbientBattleAggroReactionTime = 3.0,
		ClearChillOnDeath = true,
		DefaultAIData =
		{
			DeepInheritance = true,

			AmbientBattleTargetGroups = { "ChronosForces" },
			TeleportToBattleFoeChance = 0.0,
		},
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},

		OutgoingDamageModifiers =
		{
			{
				Name = "GroupImmunity",
				TargetGroup = "Automatons",
				GroupMultiplier = 0,
				Multiplicative = true,
			},
		},

		ProjectilesCollideWithGroups =
		{
			"ChronosForces",
			"HeroTeam",
		},
	},

	BaseChronosForces =
	{
		--PreferredSpawnPoint = "EnemyPointRanged",
		--SpawnCloseToGroup = "ChronosForces",

		AIWanderDistance = 2000,
		AggroAIRefreshDurationMin = 5.0,
		AggroAIRefreshDurationMax = 10.0,
		AIWanderFrequency = 5.0,
		
		DefaultAIData =
		{
			DeepInheritance = true,

			AmbientBattleTargetGroups = { "Automatons" },
			TeleportToBattleFoeChance = 0.5,
		},

		OutgoingDamageModifiers =
		{
			{
				Name = "GroupImmunity",
				TargetGroup = "ChronosForces",
				GroupMultiplier = 0,
				Multiplicative = true,
			},
		},

		ProjectilesCollideWithGroups =
		{
			"Automatons",
			"HeroTeam",
		},
	},

	DummyOlympusTarget =
	{
		InheritFrom = { "IsNeutral", },
		RequiredKill = false,
		TriggersOnHitEffects = false,
		CanBeFrozen = false,
		HideHealthBar = true,
		Groups = { "Automatons", "GroundEnemies" },
	},

	-- Misc / Unsorted

	-- Devotion weapons
	PassiveRoomWeapon =
	{
		InheritFrom = { "IsNeutral" },
		DamageType = "Enemy",
		RequiredKill = false,
		HideHealthBar = true,

		WakeUpDelay = 1.75,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackStop = false,
			PreAttackEndStop = false,
			PostAttackStop = false,
			MoveWithinRange = true,
			PreAttackAngleTowardTarget = true,

			AttackDistance = 99999,
		},

		AIOptions =
		{
			"AttackerAI",
		},
	},

	ZeusUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "ZeusUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionZeus",
		},
	},

	PoseidonUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "PoseidonUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionPoseidon",
		},
	},

	HestiaUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "HestiaUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionHestia",
		},
	},

	ApolloUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "ApolloUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionApollo",
		},
	},

	HeraUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "HeraUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionHera",
		},
	},

	DemeterUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "DemeterUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionDemeter",
		},
	},

	AphroditeUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "AphroditeUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionAphrodite",
		},
	},

	HephaestusUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "HephaestusUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionHephaestus",
		},
	},

	AresUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },
		RunHistoryKilledByName = "AresUpgrade",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionAres",
		},
	},

	ShipsBombardment =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		WakeUpDelay = 0.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"ShipsBombardment",
		},
	},

	PolyphemusBoulders =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		WakeUpDelay = 0.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"EmptyAI",
		},
	},


	-- Test enemies
	AliceTestEnemy =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Material = "MetalObstacle",

		AggroIfLastAlive = true,
		PreAttackDuration = 0.5,
		FireDuration = 0.1,
		PostAttackDuration = 0.5,

		RequireProjectileLoS = false,
		RequireUnitLoS = false,
		LoSBuffer = 80,
		AngleTowardsTargetWhileFiring = false,
		TrackTargetDuringCharge = false,

		WeaponOptions =
		{
			"BaseAliceWeapon",
			"BaseAliceLaser",
		},

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/Brimstone/CrystalTargetAcquired",
			PreAttackEndShake = true,
		},
		AIOptions =
		{
			"AliceTestAI",
		},
	},

	TestCharacter =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		RequiredKill = true,

		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 460,
		HealthBarOffsetY = -230,

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteAlerted",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 900,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"TestCharacterRanged",
		},
	},

	TestEnemy1 =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		RequiredKill = true,
		MaxHealth = 100,
		HealthBarOffsetY = -180,

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteAlerted",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 900,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"TestCharacterRanged",
		},
	},

	TestEnemy2 =
	{
		InheritFrom = { "TestEnemy1", "BaseVulnerableEnemy", },
	},

	TestEnemy3 =
	{
		InheritFrom = { "TestEnemy1", "BaseVulnerableEnemy", },
	},

	---- Dependent Minos data ---

	ThiefMineLayer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "ThiefMineLayer",

		RequiredSpawnPoint = "EnemyPoint",

		MaxHealth = 40,
		HealthBarOffsetY = -135,

		HitSparkScale = 1.75,

		KillEnemyEvents =
		{
			{
				FunctionName = "FuseSpawns",
				Threaded = true,
				Args =
				{
					Interval = 0.3,
				},
			},
		},

		Material = "Stone",
		PreAttackSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteCharging",
		IsAggroedSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteAlerted",

		DeathSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteDying",
		--DeathAnimation = "BaseThiefDeath",
		DeathFx = "EnemyDeathFx_Small",
		StunAnimations = 
		{
			Default = "Enemy_ThiefMineLayer_HitStun",
			Heavy = "Enemy_ThiefMineLayer_HitStun_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { "Breakable_B", "Breakable_F", "Breakable_G", "Breakable_H", "Breakable_I" },
			BlendMinDistance = 800,
			BlendMaxDistance = 2000,
			--MoveSuccessDistance = 76,
			AIWanderDistanceMin = 300,
			AIWanderDistance = 600,
			AIRetreatDistance = 450,
			BlendInTime = 0.5,
			BlendTimeoutMin = 5.0,
			BlendTimeoutMax = 6.0,
			AttackWhileBlending = true,
			AttackWhileBlendingIntervalMin = 3.0,
			AttackWhileBlendingIntervalMax = 3.5,
			AttackWhileMovingIntervalMin = 1.50,
			AttackWhileMovingIntervalMax = 1.50,
			MaxActiveSpawns = 7,
		},

		AIOptions =
		{
			"BlendInAI",
		},

		WeaponOptions = { "BloodMineToss" },

		GeneratorData =
		{
			DifficultyRating = 8,
			BlockSolo = true,
			BlockEnemyTypes = {"ThiefMineLayer_Elite"}
		},
	},

	ThiefMineLayer_Elite =
	{
		InheritFrom = { "Elite", "ThiefMineLayer" },
		HealthBuffer = 60,

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { },
			BlendMinDistance = 0,
			BlendMaxDistance = 0,
			BlendInTime = 0,
			BlendTimeoutMin = 0,
			BlendTimeoutMax = 0,
			MaxActiveSpawns = 8,

			AIWanderDistanceMin = 150,
			AIWanderDistance = 300,
			AIWanderDistanceDuration = 1,

			AttackWhileMovingIntervalMin = 1.0,
			AttackWhileMovingIntervalMax = 1.0,

			AttackWhileBlendingIntervalMin = 2.0,
			AttackWhileBlendingIntervalMax = 2.0,
		},

		GameStateRequirements =
		{
		--	RequiredMinBiomeDepth = 3,
		},

		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				NonPlayerMultiplier = 0.0,
			}
		},

		GeneratorData =
		{
			DifficultyRating = 16,
			BlockSolo = true,
			BlockEnemyTypes = { "ThiefMineLayer" }
		},
	},


	BaseSpawner =
	{
		BlockAttributes = { "Blink", "ExtraDamage" },

		PreferredSpawnPoint = "EnemyPointSupport",
		Material = "Bone",

		HealthBarOffsetY = -130,
		HitSparkScale = 2.4,

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 99999,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 4.5,
		},

		AIOptions =
		{
			"AttackerAI",
		},
		OnDamagedFunctionName = "AggroSpawns",
	},

	-- Unused Minos Traps
	TrapPadDisabled =
	{
		InheritFrom = { "BaseTrap" },
	},
	TrapFissureDisabled =
	{
		InheritFrom = { "BaseTrap" },
	},
	HazardPoint =
	{
		InheritFrom = { "BaseTrap" },
	},
	SpikeTrap =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData = {
			PreAttackDuration = 0.2,
			PostAttackCooldown = 2.0,
			
			AttackDistance = 100,
			AIResetDistance = 110,

			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
			IdleAnimation = "SpikeTrapIdle",
			PreAttackAnimation = "SpikeTrapPreFire",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",
			PostAttackAnimation = "SpikeTrapPressed",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/TrapSet",
			DisabledAnimation = "SpikeTrapDeactivated",
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SpikeTrapWeapon",
		},
		AIOptions =
		{
			"GuardAI",
		},
		ToggleTrap = true,
	},

	BlastCubeFused =
	{
		InheritFrom = { "BaseTrap" },

		MaxHealth = 9999,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		FlashOnFuse = true,
		FuseDuration = 1.5,
		FuseAnimation = "BlastCubeLit",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningProjectileName = "BlastCubeExplosion",

		OnDeathFireWeapons = { "BlastCubeExplosion" },

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnDamagedFunctionName = "ActivateFuse",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},
	HadesTombstone =
	{
		InheritFrom = { "IsNeutral", "BaseVulnerableEnemy" },
		MaxHealth = 1,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		RequiredKill = false,
		ActivateAnimation = "HadesTombstoneSpawn",
		ActivateWaitForAnimation = true,
		OnDeathFunctionName = "CheckUrnDetonation",
		OnDeathFunctionArgs = { ProjectileName = "HadesUrnDeath" },
		
        DeathAnimation = "HadesTombstoneExplode",
        DeathSound = "/SFX/CeramicPotSmash",
		DestroyDelay = 0.8,
		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Enemies )

StatusAnimations =
{
	WantsToTalk = "StatusIconWantsToTalk",
	Speaking = "StatusIconSpeaking",
}