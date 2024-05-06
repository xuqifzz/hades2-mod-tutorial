WeaponSetData =
{
	HecatePolymorph =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecatePolymorph",
			BarrelLength = 100,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			PreAttackEndShake = true,
			PreAttackDuration = 1.75,
			FireDuration = 0.2,
			PostAttackDuration = 1.3,

			PreAttackAnimation = "HecateCast",
			PreAttackLoopingSound = "/SFX/Player Sounds/MelCastCircleLoopEX",
			-- PreAttackFx = "HecateTorchChargeLeft",
			--FireAnimation = "HecateCastFire",
			--PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",
			FireFx = "StaffProjectileFireFx1_Hecate",

			AttackDistance = 9999,

			UnequipWeaponAfterUse = true,
			ForceUseIfReady = true,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ChanceToPlay = 0.35,
				ObjectType = "Hecate",
				Cooldowns =
				{
					{ Name = "HecateSpokeRecently", Time = 25 },
				},
				{ Cue = "/VO/HecateField_0051", Text = "All right." },
				{ Cue = "/VO/HecateField_0052", Text = "Let us try {#Emph}this." },
				{ Cue = "/VO/HecateField_0055", Text = "Now..." },
				{ Cue = "/VO/HecateField_0189", Text = "{#Emph}Twilight Curse!" },
				{ Cue = "/VO/HecateField_0190", Text = "{#Emph}Twilight Curse...!", PlayFirst = true },

			},
		},
		
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteCasting" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},
	},

	HecateMeteorShower =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateMeteor",
			FireTicksMin = 7,
			FireTicksMax = 7,
			FireIntervalMin = 1.15,
			FireIntervalMax = 1.35,
			ResetTargetPerTick = true,
			ProjectileLeadTarget = true,
			--ProjectileDestinationOffsetFromTarget = true,
			--ProjectileOffsetDistance = 150,
			--ProjectileOffsetDistanceMin = 0,
			--ProjectileOffsetDistanceMax = 200,
			--ProjectileOffsetRandomAngle = true,
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			PreAttackDuration = 0.6,
			FireDuration = 0.0,
			PostAttackDuration = 1.6,

			PreAttackAnimation = "Hecate_Combat_Meteor_Start",
			--FireAnimation = "Hecate_Combat_Meteor_FireLoop1",
			PostAttackAnimation = "Hecate_Combat_Meteor_End",
			InterruptAnimation = "Hecate_Combat_Meteor_End",

			AttackDistance = 9999,
			PreAttackVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.2,
					ObjectType = "Hecate",
					Cooldowns =
					{
						{ Name = "HecateMeteoredRecently", Time = 60 },
					},
					TriggerCooldowns = { "HecateSpokeRecently" },

					{ Cue = "/VO/HecateField_0139", Text = "{#Emph}Total Eclipse!" },
					{ Cue = "/VO/HecateField_0140", Text = "{#Emph}Total Eclipse...!" },
					{ Cue = "/VO/HecateField_0142", Text = "Look now upon the Moon!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "SpeechRecord" },
								HasNone = { "/VO/HecateField_0228", "/VO/HecateField_0234" },
							},
						},	
					},
					{ Cue = "/VO/HecateField_0141", Text = "Selene smite you!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "SpellDrop" }
							},
						},
					},
					{ Cue = "/VO/HecateField_0152", Text = "Selene tests your will!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "SpellDrop" }
							},
						},
					},
				},
				[2] = GlobalVoiceLines.HecateHexVoiceLines,
			},

		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateMeteorSmallShower =
	{
		InheritFrom = { "HecateMeteorShower" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "HecateMeteorSmall",
			FireTicksMin = 10,
			FireTicksMax = 10,
			FireIntervalMin = 0.5,
			FireIntervalMax = 0.5,
			FireDuration = 5,
			PostAttackDuration = 1.6,

			ProjectileLeadTarget = false,
			ProjectileDestinationOffsetFromTarget = true,
			ProjectileOffsetRandomAngle = true,
			ProjectileOffsetDistance = nil,
			ProjectileOffsetDistanceMin = 60,
			ProjectileOffsetDistanceMax = 120,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "BossHecate01", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},

	HecateLaser =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackFx = "HecateLaserPreview",
			EndPreAttackFx = true,
			PreAttackStop = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateLaser", },
				{ ProjectileName = "HecateLaser2", },
				{ ProjectileName = "HecateLaser3", },
			},

			FireProjectileStartDelay = 0.15,

			PreAttackDuration = 1.5,
			PreAttackAnimationSpeed = 0.35,
			PreAttackVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.65,
					ObjectType = "Hecate",
					Cooldowns =
					{
						{ Name = "HecateLaseredRecently", Time = 60 },
					},
					TriggerCooldowns = { "HecateSpokeRecently" },

					{ Cue = "/VO/HecateField_0143", Text = "{#Emph}Lunar Ray!" },
					{ Cue = "/VO/HecateField_0144", Text = "{#Emph}Lunar Ray...!" },
					{ Cue = "/VO/HecateField_0145", Text = "Selene's burning light!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "SpellDrop" }
							},
						},
					},
					{ Cue = "/VO/HecateField_0146", Text = "Behold Selene's light!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "UseRecord", "SpellDrop" }
							},
						},
					},
				},
				[2] = GlobalVoiceLines.HecateHexVoiceLines,
			},
			FireDuration = 5.35,
			PostAttackDuration = 0.8,

			PreAttackAnimation = "Hecate_Combat_Meteor_Start",
			FireAnimation = "Hecate_Combat_Meteor_FireLoop1",
			PostAttackAnimation = "Hecate_Combat_Meteor_End",
			InterruptAnimation = "Hecate_Combat_Meteor_End",

			AttackDistance = 9999,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "BossHecate01", },
				Comparison = ">=",
				Value = 10,
			},
		},
	},

	HecateRanged =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRanged",
			BarrelLength = 55,

			PreAttackDuration = 0.6,
			FireDuration = 0.2,
			PostAttackDuration = 0.8,

			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			PreAttackAnimation = "HecateRangedTorchStartLeft",
			FireAnimation = "HecateRangedTorchLoopLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",
			FireFx = "StaffProjectileFireFx1_Hecate",
			AttackDistance = 1000,
			RequireProjectileLoS = true,
			LoSBuffer = 40,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},
		
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},

	},

	HecateRangedTorchesSpread =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmall",
			BarrelLength = 200,
			FireTicks = 10,
			FireInterval = 0.15,
			Spread = 30,

			TargetId = 510277,

			PreAttackDuration = 0.6,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			FireDuration = 0.0,
			PostAttackDuration = 2.2,

			PreAttackAnimation = "HecateRangedTorchStartLeft",
			FireAnimation = "HecateRangedTorchLoopLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",

			AttackDistance = 1000,
			RequireProjectileLoS = true,
			LoSBuffer = 40,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateRangedTorchesFork =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateRangedSmall", AIDataOverrides = { FireProjectileAngleRelative = 0, SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint" }  },
				{ ProjectileName = "HecateRangedSmall", AIDataOverrides = { FireProjectileAngleRelative = -180, SpawnFromMarker = "WeaponHecateR_Rig:flame01_C_joint" }  },
			},
			FireTicks = 10,
			FireInterval = 0.3,

			--TargetId = 510277,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			FireDuration = 0.0,
			PostAttackDuration = 2.2,

			PreAttackAnimation = "HecateRangedTorchChargeStartLeft",
			FireAnimation = "HecateRangedTorchFireStartLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",

			AttackDistance = 9999,
			RequireProjectileLoS = true,
			LoSBuffer = 40,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.05,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateRangedTorchesLine =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateTorchCone", AIDataOverrides = { FireProjectileAngleRelative = 0, SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint", }  },
				{ ProjectileName = "HecateTorchCone", AIDataOverrides = { FireProjectileAngleRelative = 180, SpawnFromMarker = "WeaponHecateR_Rig:flame01_C_joint", }  },
			},
			FireTicks = 7,
			FireInterval = 0.5,

			--TargetId = 510277,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			PreAttackLoopingSound = "/SFX/Enemy Sounds/Hecate/HecateFlameLoop",
			FireDuration = 0.0,
			PostAttackDuration = 2.2,

			PreAttackAnimation = "HecateRangedTorchChargeStartLeft",
			FireAnimation = "HecateRangedTorchFireStartLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",

			AttackDistance = 9999,
			RequireProjectileLoS = true,
			LoSBuffer = 40,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.05,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireImpactQuiet" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateRangedTorchesSpirals =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmallSpirals",
			SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint",
			NumProjectiles = 18,
			--ProjectileAngleInterval = 15,
			ProjectileInterval = 0.17,

			TargetId = 510277,

			TrackTargetDuringCharge = false,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			FireDuration = 3.5,
			PostAttackDuration = 2.2,

			PreAttackAnimation = "HecateRangedTorchChargeStartLeft",
			FireAnimation = "HecateRangedTorchFireStartLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",

			AttackDistance = 9999,
			RequireProjectileLoS = true,
			LoSBuffer = 40,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateRangedTorchesSpiralsPhase =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmallSpirals",
			SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint",
			NumProjectiles = 36,
			ProjectileAngleInterval = 180,
			ProjectileInterval = 0.085,

			ClearWeaponFireEffectsOnFireEnd = true,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.09,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.HecateHexVoiceLines,
			},
			FireDuration = 3.5,
			PostAttackDuration = 1.2,
			PreAttackAnimation = "HecateRangedTorchChargeStartLeft",
			FireAnimation = "HecateRangedTorchFireStartLeft",
			PostAttackAnimation = "HecateRangedTorchReturnToIdleLeft",
			InterruptAnimation = "HecateRangedTorchReturnToIdleLeft",

			AttackDistance = 9999,
			MoveWithinRange = false,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "BossHecate01", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},

	HecateRangedTorchesCone =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateMeleeCone", AIDataOverrides = { FireProjectileAngleRelative = 0, BarrelLength = 200, }  },
				{ ProjectileName = "HecateMeleeCone", AIDataOverrides = { FireProjectileAngleRelative = 40, BarrelLength = 200, }  },
				{ ProjectileName = "HecateMeleeCone", AIDataOverrides = { FireProjectileAngleRelative = -40, BarrelLength = 200, }  },
			},
			BarrelLength = 0,
			FireTicks = 10,
			FireInterval = 0.15,

			PreAttackRotationDampening = 0.12,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.12,

			PreAttackDuration = 2.25,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			FireDuration = 2.0,
			PostAttackDuration = 3.0,

			PreAttackAnimation = "HecateRangedTorchConeLongStart",
			FireAnimation = "HecateRangedTorchConeLongLoop",
			PostAttackAnimation = "HecateRangedTorchConeLoopReturnToIdle",

			AttackDistance = 2000,
			RequireProjectileLoS = true,
			LoSBuffer = 40,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireImpactQuiet" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HecateRangedTorchesConePhase =
	{
		InheritFrom = { "HecateRangedTorchesCone" },
		AIData =
		{
			DeepInheritance = true,
			InterruptAnimation = "HecateRangedTorchConeLoopReturnToIdle",
			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.HecateHexVoiceLines,
			},
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "BossHecate01", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},

	HecateRangedTorchesRing =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateTorchRing",
			BarrelLength = 0,

			PreAttackDuration = 1.4,
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastStartup",
			FireDuration = 3.0,
			PostAttackDuration = 1.8,

			PreAttackAnimation = "HecateRangedTorchRing",

			AttackDistance = 700,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.5,
					ObjectType = "Hecate",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
							Comparison = ">",
							Value = 0.2,
						},
					},
					Cooldowns =
					{
						{ Name = "HecateBurnedRecently", Time = 30 },
						{ Name = "HecateSpokeRecently", Time = 12 },
					},
					TriggerCooldowns = { "HecateSpokeRecently" },

					{ Cue = "/VO/Hecate_0347", Text = "Beware!" },
					{ Cue = "/VO/Hecate_0348", Text = "{#Emph}Burn!" },
					{ Cue = "/VO/Hecate_0349", Text = "{#Emph}Fire!" },
					{ Cue = "/VO/Hecate_0350", Text = "{#Emph}Fire...!" },
					{ Cue = "/VO/Hecate_0351", Text = "Bathe in flame!" },
				},
				[2] = GlobalVoiceLines.HecateHexVoiceLines,
			},

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

	HecateRangedTorchesRingChained =
	{
		InheritFrom = { "HecateRangedTorchesRing" },
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
		}
	},

	HecateRangedTorchesRingPhase =
	{
		InheritFrom = { "HecateRangedTorchesRing" },
		AIData =
		{
			DeepInheritance = true,
			MoveWithinRange = false,
			ProjectileName = "HecateTorchRingPhase",

			PostAttackDuration = 3.6,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "BossHecate01", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},

	HecateBattleIntro =
	{
		InheritFrom = { "HecateRangedTorchesRing" },
		AIData =
		{
			DeepInheritance = true,
			
			PreAttackDuration = 0.15,
			FireDuration = 2.6,
			PreAttackAnimation = "HecateBattleOutfitBattleIntro",

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.0,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = {
							"HecateBossAboutChronos03",
							"HecateBossAbouotArachneOutfit01",
							"HecateBossAboutFailure01",
						},
					},
				},
				Cooldowns =
				{
					{ Name = "HecateSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Hecate_0489", Text = "{#Emph}Crossed Flames{#Prev}, awaken!", PlayFirst = true },
				{ Cue = "/VO/Hecate_0490", Text = "{#Emph}Crossed Flames{#Prev}, awaken...!" },
				{ Cue = "/VO/Hecate_0491", Text = "{#Emph}Crossed Flames!" },
				{ Cue = "/VO/Hecate_0492", Text = "The all-consuming flame!" },
				{ Cue = "/VO/HecateField_0201", Text = "{#Emph}Crossed Flames!" },
				{ Cue = "/VO/HecateField_0202", Text = "Now, the {#Emph}Crossed Flames...!" },
				{ Cue = "/VO/HecateField_0203", Text = "{#Emph}Crossed Flames burn!" },
				{ Cue = "/VO/HecateField_0204", Text = "{#Emph}Crossed Flames, burn...!" },
			},
		},
	},

	HecateTeleport =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			SkipFireWeapon = true,

			PreTeleportWait = 0.5,
			PostTeleportWait = 0.8,

			PostAttackTeleportToSpawnPoints = true,
			TeleportMaxDistance = 200,
			TeleportationInterval = 0,
			TeleportPreWaitAnimation = "HecateTeleportOut",
			TeleportAnimation = "HecateTeleportIn",
			TeleportStartFx = "HecateTeleportFxFront",
			TeleportEndFx = "HecateTeleportFxFront",

			ChainedWeaponOptions = { "HecateMelee1" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
			},
		},

	},

	HecateMelee1 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateMelee1", AIDataOverrides = { FireProjectileAngleRelative = 37, BarrelLength = 100, }  },
				{ ProjectileName = "HecateMelee2", AIDataOverrides = { FireProjectileAngleRelative = -35, BarrelLength = 100, }  },
			},
			BarrelLength = 230,

			FireSelfVelocity = -2100,

			PreAttackDuration = 0.7,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			FireDuration = 0.2,
			PostAttackDuration = 2.2,

			AttackDistance = 500,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			PreAttackAnimation = "HecateMeleeAttack3_PreAttack",
			FireAnimation = "HecateMeleeAttack3_Fire",
			PostAttackAnimation = "HecateMeleeAttack3_ReturnToIdle",
			FireFx = "StaffProjectileFireFx1_Hecate",
			FireFxOffset = 400,

			PreAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HecateMeleeCombo1 =
	{
		WeaponComboOnly = true,
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{

			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			"HecateMeleeArcRight",
			"HecateMeleeArcLeft",
		},
	},

	HecateMeleeArcRight =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateMelee1", AIDataOverrides = { BarrelLength = 100, }  },
			},

			MoveWithinRange = true,
			AttackDistance = 400,


			PreAttackDuration = 0.85,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			FireDuration = 0.4,
			PostAttackDuration = 0.35,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			FireFx = "SwordSwipeADisplace-Arthur",
			FireFxOffset = 200,
			PreAttackAnimation = "HecateMeleeAttack1_PreAttack",
			FireAnimation = "HecateMeleeAttack1_Fire",
			PostAttackAnimation = "HecateMeleeAttack1_ReturnToIdle",

			AngleTowardsTargetWhileFiring = true,
			PreAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HecateMeleeArcLeft =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HecateMelee2", AIDataOverrides = { BarrelLength = 100 }  },
			},

			MoveWithinRange = false,
			AttackDistance = 9999,

			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteEvading",
			FireDuration = 0.5,
			PostAttackDuration = 2.2,

			FireFx = "SwordSwipeAFlippedDisplace",
			FireFxOffset = 200,
			PreAttackAnimation = "HecateMeleeAttack2_PreAttack",
			FireAnimation = "HecateMeleeAttack2_Fire",
			PostAttackAnimation = "HecateMeleeAttack2_ReturnToIdle",

			AngleTowardsTargetWhileFiring = true,
			PreAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HecateSplit1 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},
		AIData =
		{
			DeepInheritance = true,
			ChainedWeaponOptions = { "HecateRangedTorchesLine" },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			AttackDistance = 9999,

			PreAttackAnimation = "HecateTeleportOut",
			PostAttackAnimation = "HecateTeleportIn",

			PreTeleportWait = 0.0,
			PostTeleportWait = 0.0,
			TeleportToSpawnPoints = true,
			TeleportMinDistance = 350,
			TeleportMaxDistance = 2000,
			TeleportationInterval = 0,
			TeleportSound = "/Leftovers/SFX/SpellFireAttackSmall",
			--TeleportStartFx = "IllusionistPuff",
			TeleportEndFx = "HecateTeleportFxFront",

			FireFunctionName = "UnitSplit",
			SpawnedUnit = "HecateCopy",
			SpawnCount = 2,
			SpawnRadius = 2000,
			SpawnRadiusMin = 350,
			SpawnAwayFromTypes = { "Hecate", "HecateCopy" },
			SpawnAwayFromTypesDistance = 800,
			SyncChainedWeapons = true,

			MoveWithinRange = false,
			SkipFireWeapon = true,

			MaxActiveSpawns = 1,

			PreAttackVoiceLines =
			{	
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
						Comparison = ">",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "HecateDividedRecently", Time = 30 },
					{ Name = "HecateSpokeRecently", Time = 12 },
				},
				TriggerCooldowns = { "HecateSpokeRecently" },

				{ Cue = "/VO/Hecate_0144", Text = "Face all of me!" },
				{ Cue = "/VO/Hecate_0146", Text = "We are three!" },
				{ Cue = "/VO/Hecate_0147", Text = "Three-fold!", PlayFirst = true },
				{ Cue = "/VO/Hecate_0354", Text = "Three against one..." },
				{ Cue = "/VO/Hecate_0355", Text = "Divide and strike." },
				{ Cue = "/VO/HecateField_0026", Text = "{#Emph}Triple Divide!" },
				{ Cue = "/VO/HecateField_0027", Text = "{#Emph}Triple Divide...!" },
				{ Cue = "/VO/HecateField_0028", Text = "Past, present, {#Emph}future...!" },
				{ Cue = "/VO/HecateField_0029", Text = "We are as one." },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteCharging" },
			},
		},

	},

	HecateSplit2 =
	{
		InheritFrom = { "HecateSplit1" },
		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},
		
		AIData =
		{
			DeepInheritance = true,
			ChainedWeaponOptions = { "HecateRangedTorchesSpirals", "HecateRangedTorchesFork" },
		},
	},

	HecateSplit3 =
	{	
		InheritFrom = { "HecateSplit1" },

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,
			ChainedWeaponOptions = { "HecateRangedTorchesRingChained" },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil