

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

		MaxHitShields = 5,

		IsAggroedSound = "/SFX/Enemy Sounds/Swarmer/EmoteAlerted",
		
		UseActivatePresentation = true,
		-- ActivateAnimation = "AresBladeSpinOut",
		--ActivateFx = "TeleportDisappearSmall",
		
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

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackStop = false,
			PreAttackEndStop = false,
			PostAttackStop = false,
			PreAttackAngleTowardTarget = true,
			MoveWithinRange = true,
			StopMoveWithinRange = true,

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

		SkipAISetupOnActivate = true,
		
		ClearChillOnDeath = true,

		IncomingDamageModifiers =
		{
			{
				Name = "BaseVulnerability", 
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
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

		EliteAttributeOptions = EnemySets.AllEliteAttributes,
		EliteAttributeData =
		{
			DeepInheritance = true,
			
			-- Blink: Teleports to a random spawn point every so often
			Blink =
			{
				AIDataOverrides =
				{
					TeleportToSpawnPoints = true,
					TeleportationIntervalMin = 5.5,
					TeleportationIntervalMax = 9.0,
					TeleportStartFx = "BlinkStart",
					TeleportEndFx = "BlinkEnd",
					TeleportPreWaitFx = "BlinkPreWait",
					PreTeleportWait = 0.5,
					PostTeleportWait = 0.2,
					AngleTowardsTeleportTarget = true,
				},
				RequiresFalseSuperElite = true,
				BlockAttributes = { "Beams" },
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

			-- HeavyArmor: Passive Lava lob
			--[[
			Molten =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteLavaSplash" },
			},
			]]

			--[[
			Homing =
			{
				WeaponPropertyChanges =
				{
					{
						ProjectileProperty = "Type",
						ChangeValue = "HOMING",
					},
					{
						ProjectileProperty = "AutoAdjustForTarget",
						ChangeValue = true,
					},
					{
						ProjectileProperty = "MaxAdjustRate",
						ChangeValue = math.rad(90),
						ChangeType = "Absolute",
					},
				},
				BlockAttributes = { "Frenzy" },
			},
			]]

			Tracking =
			{
				AIDataOverrides =
				{
					PreAttackAngleTowardTarget = true,
					TrackTargetDuringCharge = true,
					AngleTowardsTargetWhileFiring = true,
				},
			},

			ExtraDamage =
			{
				DataOverrides =
				{
					AttachedAnimationName = "EliteUnitStatus"
				},
				WeaponPropertyChanges =
				{
					{
						ProjectileProperty = "DamageLow",
						ChangeValue = 2.0,
						ChangeType = "Multiply",
					},
					{
						ProjectileProperty = "DamageHigh",
						ChangeValue = 2.0,
						ChangeType = "Multiply",
					},
				}
			},

			HitStun =
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
							Duration = 0.5,
						}
					},
				},
			},

			Vacuuming =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteVacuum" },
				BlockAttributes = { "Frenzy" },
			},

			-- Smoked: Passive smoke puff
			--[[
			Smoked =
			{
				RequireEncounterCompleted = "BossHarpy1", -- Require that you've been to Asphodel
				AddDumbFireWeaponsOnSpawn = { "EliteSmoke" },
			},
			]]

			-- Smoked: Passive smoke puff
			--[[
			Disguise =
			{
				SkipApplyOnClones = true,
				DifficultyRatingMultiplier = 5.0,
				AddDumbFireWeaponsOnSpawn = { "EliteClones" },
				DataOverrides =
				{
					KillSpawnsOnDeath = true,
				},
				BlockAttributes = { "DeathSpreadHitShields" },
			},
			]]

			Beams =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteBeams" },
				BlockAttributes = { "Blink" },
			},

			DeathSpreadHitShields =
			{
				DifficultyRatingMultiplier = 1.2,
				AddDumbFireWeaponsOnSpawn = { "EliteDeathAllyHitShields" },
				--BlockAttributes = { "Disguise" },
			},

			ManaDrain =
			{
				DifficultyRatingMultiplier = 1.2,
				ThreadedFunctionName = "ShrineEliteAttributeManaDrain",
				ThreadedFunctionArgs =
				{
					StartDelayMin = 1.0,
					StartDelayMax = 2.0,
					TickInterval = 3.0,
					Amount = -3,
				}
			},
		},

		--ActivateFx = "HadesDisappearElite",
	},

	SuperElite =
	{
		IsSuperElite = true,
	},

	-- Oceanus Base
	OceanusUnitData =
	{
		DoActivateFxAtNearestTypeId = "EnemyPointRanged",
		ActivateFx = "WaterUnitSurface",
		ActivateFx2 = "nil",
		ActivateVerticalForce = 2300,
		ActivateFxPreSpawn = "Blank",
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

	Turret =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 1200,
		HealthBarOffsetY = -200,

		PreferredSpawnPoint = "EnemyPointRanged",
		Groups = { "GroundEnemies" },
		Material = "Bone",

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			AttackDistance = 999999,
			MoveWithinRange = false,

		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"TurretRanged01"
		},

		GeneratorData =
		{
			DifficultyRating = 100,
			BlockEnemyTypes = {"Mage_Elite"}
		},
	},	

	-- Olympus

	BaseAutomaton =
	{
		AIWanderDistance = 0,

		DefaultAIData =
		{
			DeepInheritance = true,

			AmbientBattleTargetGroups = { "ChronosForces" },
		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		AIOptions =
		{
			"AmbientBattleAggroAI",
		},
	},

	-- Satyrs dependent on Minos data
	SatyrCommando =
	{
		InheritFrom = {  "BaseSatyr", "BaseVulnerableEnemy", },
		GenusName = "SatyrRanged",
		PreferredSpawnPoint = "EnemyPointRanged",
		Groups = { "GroundEnemies", "ChronosForces" },

		MaxHealth = 1100,
		HealthBarOffsetY = -185,
		HealthBarType = "Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/Satyr/EmoteAlerted",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",
		
		StunAnimations = 
		{
			Default = "Enemy_MaleGrey_HitStun",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			TargetGroups = { "Automatons", "HeroTeam" },
			TargetRequiredKillEnemy = true,
			TargetPlayerAndRequiredKills = true,

			PreAttackSound = "/SFX/DusaHiss",

			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 4.0,
			AttackDistance = 1300,

			AmbientBattleTargetGroups = { "Automatons" },
			TeleportToBattleFoeChance = 0.75,
		},

		SpawnObstaclesOnDeath =
		{
		},

		WeaponOptions =
		{
			"SatyrCombo01", "SatyrVolley01",
		},

		AIOptions =
		{
			"AmbientBattleAggroAI",
		},
		PostAggroAI = "AttackerAI",

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"SatyrCommando_Elite"}
		},

		LargeUnitCap = 5,
	},

	SatyrCommando_Elite =
	{
		InheritFrom = { "Elite", "SatyrCommando" },
		MaxHealth = 800,
		HealthBuffer = 2000,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"SatyrCommando"}
		},
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

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DevotionHephaestus",
		},
	},

	LightningStorm =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"LightningStorm",
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

		MaxHealth = 100,

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

		BlockAttributes = { "ExtraDamage" },

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
	BaseSatyr =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",
		HealthBarOffsetY = -200,
		HitSparkOffsetZ = 140,
		
		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		DefaultAIData =
		{
			DeepInheritance = true,
			MoveWithinRangeTimeoutMin = 4.0,
			MoveWithinRangeTimeoutMax = 8.0,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.5,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		HitSparkScale = 1.5,
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
	AxeTrap =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData =
		{
			PreAttackDuration = 0.3,
			PostAttackDuration = 1.0,
			PostAttackCooldown = 0.5,

			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
			IdleAnimation = "AxeTrapReset",
			PreAttackAnimation = "AxeTrapActivated",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/TrapSet",
			DisabledAnimation = "AxeTrapIdle",
			PreAttackAngleTowardTarget = false,

			AddUnitCollisionDuringAttack = true,
			AddProjectileCollisionDuringAttack = true,
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"AxeTrapWeapon",
		},
		ToggleTrap = true
	},
	AxeTrapTrigger =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.2,
		PostAttackCooldown = 2.0,

		TargetGroups = { "GroundEnemies", "HeroTeam" },
		LinkedEnemy = "DartTrapEmitter",
		IdleAnimation = "DartTrapIdle",
		PreAttackAnimation = "DartTrapPreFire",
		PreAttackSound = "/SFX/TrapSet",
		PostAttackAnimation = "DartTrapPressed",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",
		PreAttackAngleTowardTarget = false,

		DisabledAnimation = "DartTrapDeactivated",

		WeaponOptions =
		{
			"AxeTrapWeapon",
		},
		AIOptions =
		{
			"RemoteAI",
		},
		AttackDistance = 100,
		AIResetDistance = 110,
		ToggleTrap = true
	},

	SpikeCube =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.01,
		PostAttackCooldown = 0.75,

		--RequiredVictimVelocity = 1000,
		Color = { 255, 0, 0, 255 },

		AttackWarningAnimation = "LobWarningDecal",
		AttackWarningAnimationRadius = 210,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SpikeWallWeapon",
		},
		AIOptions =
		{
			"CollisionRetaliateAI",
		},
		ToggleTrap = true,
	},

	BannerSupport =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.1,
		FireDuration = 0,
		PostAttackDuration = 0.1,
		PostAttackCooldown = 0.0,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		--ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		AttackDistance = 9999,
		RetreatBufferDistance = 9999,


		Material = "MetalObstacle",

		WeaponOptions =
		{
			"MoveSpeedAoE",
		},
		AIOptions =
		{
			"AttackerAI",
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

	BlastCubeFusedRegenerating =
	{
		InheritFrom = { "BaseTrap" },

		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		FlashOnFuse = true,
		FuseDuration = 2.0,
		FuseAnimation = "BlastCubeFusedRegeneratingLit",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningProjectileName = "BlastCubeExplosionElysium",
		PostFuseWeapon = "BlastCubeExplosionElysium",
		FuseDormantDuration = 6.0,
		PostFuseRevive = true,
		PostFuseReviveAnimation = "BlastCubeFusedRegeneratingOnSpawn",

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnHitFunctionName = "ActivateFuse",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 33.33,
			},
		},
	},
	
	DartTrap =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.2,
		PostAttackCooldown = 2.0,

		TargetGroups = { "GroundEnemies", "HeroTeam" },
		LinkedEnemy = "DartTrapEmitter",
		IdleAnimation = "DartTrapIdle",
		PreAttackAnimation = "DartTrapPreFire",
		PreAttackSound = "/SFX/TrapSet",
		PostAttackAnimation = "DartTrapPressed",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		DisabledAnimation = "DartTrapDeactivated",

		AIOptions =
		{
			"RemoteAI",
		},
		AttackDistance = 100,
		AIResetDistance = 110,
		MaxVictimZ = 1,
		ToggleTrap = true,
	},
	DartTrapEmitter =
	{
		InheritFrom = { "IsNeutral" },
		Type = "Trap",
		TriggersOnHitEffects = false,

		PreAttackAnimation = "DartTrapEmitterFire",
		PostAttackAnimation = "DartTrapEmitterReturnToIdle",

		PreAttackDuration = 0.0,
		PostAttackDuration = 0.0,

		FireTicksMin = 3,
		FireTicksMax = 3,
		FireInterval = 0.15,
		TrackTargetDuringCharge = false,

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"DartTrapWeapon",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 33.33,
			},
		},
	},


	--[[BreakableAsphodel =
	{
		InheritFrom = { "IsNeutral" },
		GenusName = "Breakable",
		MaxHealth = 1,
		HideHealthBar = true,
		HideLevelDisplay = true,
		SkipDamageText = true,
		RequiredKill = false,
		CanBeFrozen = false,
		OnKillGlobalVoiceLines = "BreakableDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 2,
		MeterMultiplier = 0,

		CollisionReaction =
		{
			MinVelocity = 1000,
			KillSelf = true,
		}
	},]]


}

OverwriteTableKeys( EnemyData, UnitSetData.Enemies )

StatusAnimations =
{
	WantsToTalk = "StatusIconWantsToTalk",
	Speaking = "StatusIconSpeaking",
	Charmed = "StatusIconNPCCharmed"
}