WeaponSetData =
{
	-- DASHES
	ZagreusDash =
	{
		Requirements =
		{
			MinPlayerDistance = 400,
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			FireAnimation = "Enemy_Zagreus_Spear_Dash",

			WaitForAngleTowardTarget = true,
			PreAttackDuration = 0.0, -- Dash as soon as rotation complete
			PreAttackEndMinWaitTime = 0.15,
			FireDuration = 0.2, -- Anim is 0.98
			PostAttackDuration = 0.78,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 99,
			StopBeforeFire = true,

			AttackDistance = 9999,
			MoveWithinRange = true,

			RequireUnitLoS = true,
			LoSBuffer = 80,

			TargetFromGroup = "DashTargets",
			TargetDistanceFromPlayer = true,
			TargetRange = 250,

      		PreAttackFx = "DashCrack",
      		FireFx = "BlinkTrailVerticalB",

      		FireSelfVelocity = 2450,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			DashWeapons = {},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusDash" },
			},
		},
	},
	ZagreusDoubleDash =
	{
		InheritFrom = { "ZagreusDash" },
		GenusName = "ZagreusDash",

		Requirements =
		{
			MinPlayerDistance = 800,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			FireDuration = 0.1, -- Anim is 0.98
			PostAttackDuration = 0.15,
			ChainedWeapon = "ZagreusDash",
		},
	},
	ZagreusDashSpread =
	{
		InheritFrom = { "ZagreusDash" },
		GenusName = "ZagreusDash",

		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			FireDuration = 0.05, -- Anim is 0.98
			PostAttackDurationMin = 0.4,
			PostAttackDurationMax = 0.93, -- Simulate animation cancel

			CreateOwnTargetFromOriginalTarget = true,
			UseAngleBetweenTarget = true,
			TargetOffsetDistance = 200,
			TargetAngleSpread = 120,
			SkipIfTargetLocationBlocked = true,
		},
	},
	ZagreusDoubleDashRetreat =
	{
		InheritFrom = { "ZagreusDash" },
		GenusName = "ZagreusDashRetreat",

		Requirements =
		{
			MaxPlayerDistance = 800,
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.2, -- Time to rotate

			TargetRange = "nil",
			TargetMinDistance = 1200,
			MoveWithinRange = false,

			SkipIfTargetLocationBlocked = true,

			FireDuration = 0.1, -- Anim is 0.98
			PostAttackDuration = 0.15,
			ChainedWeapon = "ZagreusDashRetreat",
		},
	},
	ZagreusDashRetreat =
	{
		InheritFrom = { "ZagreusDash" },
		GenusName = "ZagreusDashRetreat",

		Requirements =
		{
			MaxPlayerDistance = 600,
		},

		AIData =
		{
			DeepInheritance = true,

			TargetRange = "nil",
			TargetMinDistance = 1200,
			MoveWithinRange = false,

			SkipIfTargetLocationBlocked = true,
		},
	},

	-- MISC
	ZagreusDarknessOut =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},

		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			ClearAllEffects = true,

			PreFireFx = "HadesDisappear_Player",
			PreAttackAnimation = "Enemy_Zagreus_Spear_Darkness",
			PostAttackAnimation = "Enemy_Zagreus_Hidden",
			PreAttackDuration = 0.13,
			FireDuration = 0.2,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 3.0,

			PostAttackEndTeleport = true,
			PreferredSpawnPointGroup = "DarknessTargets",
			TeleportMinDistance = 100,
			TeleportMaxDistance = 600,
			TeleportMinPlayerArc = 140,
			TeleportPreWaitAnimation = "Enemy_Zagreus_Hidden",
			TeleportAnimation = "Enemy_Zagreus_Spear_Idle",
			TeleportEndFx = "HadesDisappear_Player",
			TeleportationInterval = 0,
			PreTeleportWait = 0,
			PostTeleportWait = 0,
			PostTeleportAngleTowardTarget = true,

			PostAttackCooldown = 0.25,
			PostAttackCooldownMinWaitTime = 0.25,
			
			ChainedWeaponOptions = { "ZagreusSpearSpinDouble", "ZagreusSpearDashStrike", "ZagreusSpearStabCombo", },
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteDarkness" },
			},
		},
	},

	-- DASH ATTACK
	ZagreusSpearDashStrike =
	{
		Requirements =
		{
			MinPlayerDistance = 800,
			MaxConsecutiveUses = 2,
		},

		WeaponComboOnly = true,

		AIData = {},

		WeaponCombo =
		{
			{
				WeaponName = "ZagreusDash",
				IgnoreRequirements = true,
				DataOverrides =
				{
					TargetPlayer = true,
					TargetFromGroup = "nil",
					FireDuration = 0.1,
					PostAttackDuration = 0.1,
				},
			},
			{ WeaponName = "ZagreusSpearDashStrikeHit", },
		},
		ChainChance = 0.5,
	},
	ZagreusSpearDashStrikeHit =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZagreusSpearRush",

			PreAttackAngleTowardTarget = false,

			FireProjectileStartDelay = 0.1,

			PreAttackDuration = 0.1,
			FireDuration = 0.44,
			PostAttackDurationMin = 0.3,
			PostAttackDurationMax = 0.8,

			FireAnimation = "Enemy_Zagreus_Spear_DashAttack_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Spear_DashAttack_End",

			ChainedWeaponOptions = { "ZagreusSpearStabCombo", "ZagreusSpearSpin" },

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteMartialSpearSpinAttack" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
			},
		},
	},

	-- STABS
	ZagreusSpearStab1 =
	{
		GenusName = "ZagreusSpearStab",

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZagreusSpearStab1",
			FireProjectileStartDelay = 0.03,

			FireSelfVelocity = 700,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "ZagreusLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.1,
						Modifier = 0.000001,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackAnimation = "Enemy_Zagreus_Spear_Stab1_Start",
			FireAnimation = "Enemy_Zagreus_Spear_Stab1_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Spear_Stab1_End",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.13,
			StopBeforeFire = true,

			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 0.15,

			AttackDistance = 500,
			AttackDistanceScaleY = 0.55,
			MoveWithinRange = true,
			DashIfOverDistance = 600,
			DashRequireLoS = true,
			DashWeapon = "ZagreusDashSpread",

			RequireUnitLoS = true,
			LoSBuffer = 80,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ZagreusMeleePreAttackVoiceLines" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
			},
		},
	},
	ZagreusSpearStab2 =
	{
		GenusName = "ZagreusSpearStab",
		
		Requirements =
		{
			MaxPlayerDistance = 800,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZagreusSpearStab2",
			FireProjectileStartDelay = 0.05,

			PreAttackSelfVelocity = 700,
			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "ZagreusLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.4,
						Modifier = 0.03,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackAnimation = "Enemy_Zagreus_Spear_Stab2_Start",
			FireAnimation = "Enemy_Zagreus_Spear_Stab2_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Spear_Stab2_End",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.12,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.23,
			StopBeforeFire = true,

			PreAttackDuration = 0.4,
			FireDuration = 0.34,
			PostAttackDuration = 0.2,

			AttackDistance = 800,
			AttackDistanceScaleY = 0.55,
			MoveWithinRange = true,
			DashIfOverDistance = 300,
			DashRequireLoS = true,
			DashWeapon = "ZagreusDashSpread",

			RequireProjectileLoS = true,
			LoSBuffer = 80,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ZagreusMeleePreAttackVoiceLines" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
			},
		},
	},
	ZagreusSpearStab3 =
	{
		GenusName = "ZagreusSpearStab",
		
		Requirements =
		{
			MaxPlayerDistance = 800,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZagreusSpearStab3",
			FireProjectileStartDelay = 0.11,

			PreAttackSelfVelocity = 700,
			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "ZagreusLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.4,
						Modifier = 0.03,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackAnimation = "Enemy_Zagreus_Spear_Stab3_Start", -- 1.57s
			FireAnimation = "Enemy_Zagreus_Spear_Stab3_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Spear_Stab3_End",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.12,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.23,
			StopBeforeFire = true,

			PreAttackDuration = 0.4,
			FireDuration = 0.22,
			PostAttackDurationMin = 0.3,
			PostAttackDurationMax = 0.8,

			AttackDistance = 800,
			AttackDistanceScaleY = 0.55,
			MoveWithinRange = true,
			DashIfOverDistance = 300,
			DashRequireLoS = true,
			DashWeapon = "ZagreusDashSpread",
			
			RetreatAfterAttack = true,
			RetreatGameStateRequirements = { ChanceToPlay = 0.4 },
			RetreatBufferDistance = 900,
			RetreatTimeout = 2.5,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 9999,
			RetreatToSpawnPointRadiusMin = 900,

			RequireProjectileLoS = true,
			LoSBuffer = 80,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ZagreusMeleePreAttackVoiceLines" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
			},
		},
	},

	ZagreusSpearStabCombo =
	{
		GenusName = "ZagreusSpearStab",

		WeaponComboOnly = true,

		WeaponCombo =
		{
			{ WeaponName = "ZagreusSpearStab1", DataOverrides = { MoveWithinRange = true } },
			{ WeaponName = "ZagreusSpearStab2", DataOverrides = { MoveWithinRange = true } },
			{ WeaponName = "ZagreusSpearStab3", DataOverrides = { MoveWithinRange = true } },
		},
		AIData =
		{
			DeepInheritance = true,
		},
	},

	-- SPIN
	ZagreusSpearSpin =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "ZagreusSpinGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.2,
						Modifier = 0.6,
						HaltOnEnd = true,
					}
				},
			},

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,

			FireProjectileStartDelay = 0.1,
			ProjectileName = "ZagreusSpearSpin",

			PreAttackAnimation = "Enemy_Zagreus_Spear_Spin_Start",
			FireAnimation = "Enemy_Zagreus_Spear_Spin_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Spear_Spin_End",

			PreAttackDuration = 0.88, -- Anim is 0.22
			FireDuration = 0.615, -- anim: 1.23 x 2
			PostAttackDuration = 0.6, -- Anim is 1.18
			PreAttackEndShake = true,

			RetreatAfterAttack = true,
			RetreatGameStateRequirements = { ChanceToPlay = 0.4 },
			RetreatBufferDistance = 900,
			RetreatTimeout = 2.5,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 9999,
			RetreatToSpawnPointRadiusMin = 900,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			FireSelfVelocityIfOverDistance = 300,
			FireSelfVelocity = 2500,

			AttackDistance = 600,
			MoveWithinRange = true,

			PreAttackLoopingSound = "/SFX/Player Sounds/ZagreusWeaponChargeup",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ZagreusMeleePreAttackVoiceLines" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteHeavySpecialAttack" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" }
			}
		},
	},

	ZagreusSpearOffenseCombo1 =
	{
		WeaponComboOnly = true,

		WeaponCombo =
		{
			{ WeaponName = "ZagreusDashSpread", DataOverrides = { MoveWithinRange = false, PostAttackDuration = 0.4, } },
			{ WeaponName = "ZagreusSpearSpin", },
		},
	},
	ZagreusSpearSpinDouble =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		WeaponComboOnly = true,

		WeaponCombo =
		{
			{ WeaponName = "ZagreusSpearSpin", DataOverrides = { PostAttackDuration = 0.1, RetreatAfterAttack = false } },
			{ WeaponName = "ZagreusSpearSpin", DataOverrides = { MoveWithinRange = false, PreAttackDuration = 0.44, PreAttackAnimation = "Enemy_Zagreus_Spear_Spin_Start_Fast", PreAttackThreadedFunctionName = "nil", } },
		},
		AIData =
		{
			DeepInheritance = true,
		},
	},

	-- CAST
	ZagreusCast =
	{
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "CastAmmo" },
				Comparison = ">",
				Value = 0
			}
		},

		AIData =
		{
			DeepInheritance = true,

			FireFunctionName = "ZagreusUseCastAmmo",

			ProjectileName = "ZagreusCast",

			PreAttackAnimation = "Enemy_Zagreus_Cast_Start",
			FireAnimation = "Enemy_Zagreus_Cast_Fire",
			PostAttackAnimation = "Enemy_Zagreus_Cast_End",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,
			PreAttackStop = true,

			PreAttackDuration = 0.42, -- Anim is 0.42
			FireDuration = 0.25, -- Anim is 0.25
			PostAttackDurationMin = 0.6,
			PostAttackDurationMax = 1.2, -- Anim is 1.55

			AttackDistance = 1000,
			MoveWithinRange = true,

			RetreatBeforeAttack = true,
			RetreatGameStateRequirements = { ChanceToPlay = 0.5 },
			RetreatBufferDistance = 900,
			RetreatTimeout = 2.5,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 9999,
			RetreatToSpawnPointRadiusMin = 900,

			RequireProjectileLoS = true,
			LoSBuffer = 80,

			PreAttackSound = "/VO/ZagreusEmotes/EmoteRangedCharging",
			FireFx = "CastDust", "ProjectileFireRing-Bloodstone",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ZagreusRangedPreAttackVoiceLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteRanged" },
			},
		},
	},
	ZagreusBloodstonePickup =
	{
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "CastAmmo" },
				Comparison = "==",
				Value = 0
			}
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			SkipFireWeapon = true,
			SkipFireWeaponSound = "/SFX/BloodstoneAmmoPickup",

			DashIfOverDistance = 200,
			DashRequireLoS = true,
			DashWeapon = "ZagreusDash",
			AttackDistance = 100,
			MoveWithinRange = true,

			TargetClosestOfType = "AmmoPack",
		},
	},

	ZagreusCastCombo =
	{
		WeaponComboOnly = true,

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "CastAmmo" },
				Comparison = ">",
				Value = 0
			}
		},

		AIData = {},

		WeaponCombo =
		{
			{ WeaponName = "ZagreusCast", DataOverrides = { PostAttackDurationMin = 0.2, PostAttackDurationMax = 0.3 } },
			{ WeaponName = "ZagreusCast", DataOverrides = { PostAttackDurationMin = 0.2, PostAttackDurationMax = 0.3 } },
			{ WeaponName = "ZagreusCast", },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil