WeaponSetData =
{

	AutomatonEnforcerSlash =
	{
		Requirements =
		{
			MaxPlayerDistance = 400,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.08,

			AttackSlots =
			{
				{ ProjectileName = "AutomatonMeleeArcLeft", PauseDuration = 0.25 },
				{ ProjectileName = "AutomatonMeleeArcRight", },
			},

			PreAttackDuration = 1.33,
			FireDuration = 0.65,
			PostAttackDuration = 1.1, -- anim is 0.98

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			AttackDistance = 400,
			AttackDistanceScaleY = 0.5,

			RequireUnitLoS = true,
			LoSBuffer = 50,

			PreAttackSound = "/SFX/Enemy Sounds/AutomatonEnforcer/EmoteCharging",
			PreAttackAnimation = "Enemy_Enforcer_SlashPreFire",
			FireAnimation = "Enemy_Enforcer_SlashFire",
			PostAttackAnimation = "Enemy_Enforcer_SlashPostFire",

			ExpireProjectilesOnHitStun = true,
			DoNotRepeatOnAttackFail = true,

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CrusherAttackImpact" },
			},
		},
	},

	AutomatonEnforcerSlash_Elite =
	{
		InheritFrom = { "AutomatonEnforcerSlash" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireInterval = 0.65,
		}
	},

	AutomatonEnforcerSlash_AmbientBattle =
	{
		InheritFrom = { "AutomatonEnforcerSlash" },
		
		Requirements =
		{
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathTrue = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,
		}
	},

	AutomatonEnforcerBoost =
	{
		Requirements =
		{
			MaxUses = 1,
			HealthPercentMax = 0.4,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,
			DoNotRepeatOnAttackFail = false,

			NoProjectile = true,

			FireFunctionName = "EnforcerBoostActivate",
			FireFunctionArgs = { ElapsedTimeMultiplier = 1.4, SpeedMultiplier = 1.6 },

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AutomatonEnforcerMeltdown",
					DataProperties =
					{
						Type = "DAMAGE_OVER_TIME",
						Duration = 99.0,
						Cooldown = 0.5,
						Amount = 50,
						IsVulnerabilityEffect = true,
						CanAffectInvulnerable = true,
					},
				},
			},

			TrackTargetDuringCharge = true,
			PreAttackDuration = 0.8,
			FireDuration = 0.0,
			PostAttackDuration = 1.0, -- anim is 1.33 total

			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Enforcer_Boost",

			-- Rifts ban
			DumbFireWeapons = {},
		},
	},

	AutomatonEnforcerWhirlwind =
	{
		Requirements =
		{
			MinPlayerDistance = 400,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "AutomatonWhirlwind",

			FireTicks = 10,
			FireInterval = 0.16,
			FireSelfVelocity = 450,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "WhirlwindLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 1.6,
						Modifier = 0.1,
					}
				},
			},

			PreAttackDuration = 1.5,
			FireDuration = 0.0,
			PostAttackDurationMin = 2.0, -- anim is 0.98
			PostAttackDurationMax = 2.3,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			AttackDistance = 700,

			RequireUnitLoS = true,
			LoSBuffer = 25,
			--LoSEndBuffer = 25,

			DoNotRepeatOnAttackFail = true,

			PreAttackSound = "/SFX/Enemy Sounds/AutomatonEnforcer/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Enforcer_WhirlwindPreFire",
			FireAnimation = "Enemy_Enforcer_WhirlwindFire",
			PostAttackAnimation = "Enemy_Enforcer_WhirlwindPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/AutomatonEnforcer/EnforcerSwipe" },
			},
		},
	},

	AutomatonEnforcerWhirlwind_Elite =
	{
		InheritFrom = { "AutomatonEnforcerWhirlwind" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "AutomatonWhirlwind_Elite",
			FireSelfVelocity = 500,
		},
	},

	AutomatonBeamForward =
	{
		Requirements =
		{
			MaxAttackers = 2,
			SkipRequirementsIfNotAggroed = true,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "AutomatonBeamBolt",
			BarrelLength = 150,
			--SpawnFromMarker = "AutomatonBeamer_Rig:headPanel_00_M_JNT",
			FireTicks = 10,
			FireInterval = 0.30,

			PreAttackStop = true,
			StopBeforeFire = true,
			PostAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PreAttackRotationDampening = 0.045,
			FireRotationDampening = 0.03,

			PreAttackDuration = 1.5,
			FireDuration = 0.0,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 3.0,

			RequireProjectileLoS = true,
			CheckUnits = true,
			LoSBuffer = 50,

			AttackDistance = 900,
			AttackDistanceScaleY = 0.5,

			PreAttackSound = "/SFX/Enemy Sounds/AutomatonBeamer/EmoteScanning",
			PreAttackAnimation = "Enemy_Beamer_RailPreFire",
			FireAnimation = "Enemy_Beamer_RailFireLoop",
			PostAttackAnimation = "Enemy_Beamer_RailPostFire",

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/AutomatonBeamer/BeamerRapidFireLoop",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/AutomatonBeamer/BeamerFireSingleShot" },
			},
		},
	},

	AutomatonBeamForward_Elite =
	{
		InheritFrom = { "AutomatonBeamForward" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackRotationDampening = 0.11,
			FireRotationDampening = 0.11,
		},
	},

	AutomatonBeamerDefense =
	{
		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,

			ProjectileName = "AutomatonOrbit",
			NumProjectiles = 4,
			ProjectileAngleEvenlySpaced = true,

			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,
			SkipCanAttack = true,

			PreAttackDuration = 1.0,
			FireDuration = 1.5,
			PostAttackDuration = 2.0,

			PreAttackFunctionName = "WeaponSetImmuneToStun",
			ApplyEffectsOnWeaponFire = { WeaponEffectData.AutomatonDefense },

			PostAttackFunctionName = "WeaponRevertStunImmunity",
			PostAttackRemoveIncomingDamageModifier = "AutomatonBeamerDefense",
			PreAttackSound = "/SFX/Enemy Sounds/AutomatonBeamer/EmoteSpotted",
			PreAttackAnimation = "Enemy_Beamer_DefenseEnter",
			FireAnimation = "Enemy_Beamer_DefenseLoop",
			PostAttackAnimation = "Enemy_Beamer_DefenseExit",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		},

		Requirements =
		{
			MaxUses = 1,
		},	
	},

	AutomatonBeamerScan =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "AutomatonScan",
			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,

			PreAttackDuration = 0.8,
			FireDuration = 1.7,
			PostAttackDuration = 0.2,

			PreAttackAnimation = "Enemy_Beamer_Scan",

			ChainedWeapon = "AutomatonBeamForward",

			SkipSurroundAICount = true,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},
	},


	SentryBotBurst =
	{

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			ProjectileName = "SentryBotBolt",
			BarrelLength = 75,
			Spread = 5,

			FireFx = "SentryBotBoltFireFx",
			
			PreAttackDuration = 0.9,
			PreAttackAnimationSpeed = 1.2,
			FireDuration = 0.2,
			PostAttackDurationMin = 1.0,
			PostAttackDurationMax = 1.2,

			PreAttackSound = "/SFX/Enemy Sounds/SentryBot/EmoteCharging",
			PreAttackAnimation = "Enemy_SentryBot_BurstPreFire",
			FireAnimation = "Enemy_SentryBot_BurstFire",
			PostAttackAnimation = "Enemy_SentryBot_BurstPostFire",

			AttackDistance = 1050,
			AttackDistanceScaleY = 0.48,
			RequireProjectileLoS = true,
			LoSBuffer = 25,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Mage/EmoteAttacking" },
			},
		},
	},

	SentryBotBurst_Elite =
	{
		InheritFrom = { "SentryBotBurst" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileInterval = 0.09,
		},
	},

	SentryBotBurst_AmbientBattle =
	{
		InheritFrom = { "SentryBotBurst" },

		Requirements =
		{
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathTrue = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,
		},
	},

	SentryBotVent =
	{
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,

			ProjectileName = "SentryBotVent",

			PreAttackDuration = 1.5,
			FireDuration = 0.32,
			PostAttackDurationMin = 0.6,
			PostAttackDurationMax = 0.9,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			AttackDistance = 99999,
			MoveWithinRange = false,
			MoveWithinRangeTimeout = 1.0,

			DoNotRepeatOnAttackFail = true,

			PreAttackSound = "/SFX/Enemy Sounds/SentryBot/EmotePowerCharging",
			PreAttackAnimation = "Enemy_SentryBot_VentPreFire",
			FireAnimation = "Enemy_SentryBot_VentFire",
			PostAttackAnimation = "Enemy_SentryBot_VentPostFire",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil