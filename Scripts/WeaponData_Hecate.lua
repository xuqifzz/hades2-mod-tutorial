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
			TrackTargetDuringFire = true,
			PostAttackStop = true,

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
					{ Name = "HecateSpokeRecently", Time = 8 },
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

	HecatePolymorph_EM =
	{
		InheritFrom = { "HecatePolymorph", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "HecatePolymorph_EM",
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
			MoveWithinRange = false,
			PreAttackVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.2,
					ObjectType = "Hecate",
					Cooldowns =
					{
						{ Name = "HecateMeteoredRecently", Time = 80 },
						{ Name = "HecateSpokeRecently", Time = 12 }
					},

					{ Cue = "/VO/HecateField_0139", Text = "{#Emph}Total Eclipse!" },
					{ Cue = "/VO/HecateField_0140", Text = "{#Emph}Total Eclipse...!" },
					{ Cue = "/VO/HecateField_0142", Text = "Look now upon the Moon!", PlayFirst = true,
						Cooldowns =
						{
							{ Name = "HecateSaidMoonRecently", Time = 30 },
						},
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
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
			},
		},
	},

	HecateMeteorShower_EM =
	{
		InheritFrom = { "HecateMeteorShower" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ OffsetX = 0, OffsetY = 0, },
				{ OffsetX = 650, OffsetY = 0, },
				{ OffsetX = -650, OffsetY = 0, },
				{ OffsetX = 0, OffsetY = 370, },
				{ OffsetX = 0, OffsetY = -370, },
			},
			AttackSlotsPerTick = 3,
			AttackSlotInterval = 0.1,
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

	HecateMeteorSmallShower_EM =
	{
		InheritFrom = { "HecateMeteorSmallShower" },

		AIData =
		{
			DeepInheritance = true,

			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistance = 300,

			SkipIfInvalidLocation = true,

			AttackSlots =
			{
				{ Angle = 0, AnchorAngleOffset = 0, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 0, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 60, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 120, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 180, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 240, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
				{ Angle = 300, AnchorAngleOffset = 400, OffsetRadius = 0, OffsetScaleY = 0.55 },
			},
			AttackSlotsPerTick = 5,
			AttackSlotInterval = 0.2,
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

			ImmuneToProjectileSlow = true,

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
						{ Name = "HecateLaseredRecently", Time = 80 },
						{ Name = "HecateSpokeRecently", Time = 12 }
					},

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
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
			},
			FireDuration = 5.35,
			PostAttackDuration = 0.8,

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackAnimation = "Hecate_Combat_Meteor_Start",
			FireAnimation = "Hecate_Combat_Meteor_FireLoop1",
			PostAttackAnimation = "Hecate_Combat_Meteor_End",
			InterruptAnimation = "Hecate_Combat_Meteor_End",

			AttackDistance = 9999,
			MoveWithinRange = false,
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

	HecateLaser_EM =
	{
		InheritFrom = { "HecateLaser" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackFx = "nil",
			AttackSlots =
			{
				{ ProjectileName = "HecateLaser", },
				{ ProjectileName = "HecateLaser2", },
				{ ProjectileName = "HecateLaser3", },
				{ ProjectileName = "HecateLaser4", },
				{ ProjectileName = "HecateLaser5", },
				{ ProjectileName = "HecateLaser6", },
			},
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
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
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
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire2" },
			},
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
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
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
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraFlameBurst" },
			},
		},
	},

	HecateRangedTorchesHoming =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmallHoming",
			SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint",
			NumProjectiles = 18,
			ProjectileInterval = 0.17,

			TrackTargetDuringCharge = false,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
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
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire2" },
			},
		},
	},

	HecateRangedTorchesHoming_Short =
	{
		InheritFrom = { "HecateRangedTorchesHoming" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 9,
			FireDuration = 1.75,
			PostAttackDuration = 0.5,
		},
	},

	HecateRangedTorchesSpiralsPhase =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmallHoming",
			SpawnFromMarker = "WeaponHecateL_Rig:flame01_C_joint",
			NumProjectiles = 36,
			ProjectileAngleInterval = 180,
			ProjectileInterval = 0.085,

			ClearWeaponFireEffectsOnFireEnd = true,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.09,
			PostAttackStop = true,

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
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
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire2" },
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

	HecateRangedTorchesSpiralsPhase_EM =
	{
		InheritFrom = { "HecateRangedTorchesSpiralsPhase" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateRangedSmallHoming_Bounce",
			ProjectileInterval = 0.0425,
			ProjectileAngleInterval = 90,
		},
	},

	HecateRangedTorchesCone =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ AIDataOverrides = { FireProjectileAngleRelative = 0, BarrelLength = 200, }  },
				{ AIDataOverrides = { FireProjectileAngleRelative = 40, BarrelLength = 200, }  },
				{ AIDataOverrides = { FireProjectileAngleRelative = -40, BarrelLength = 200, }  },
			},
			ProjectileName = "HecateMeleeCone",
			BarrelLength = 0,
			FireTicks = 10,
			FireInterval = 0.15,

			PreAttackRotationDampening = 0.12,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.12,

			PreAttackDuration = 2.25,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
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
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireImpactQuiet" },
			},
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
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
			},

			RequireProjectileLoS = false,
			AttackDistance = 9999,
			MoveWithinRange = false,
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

	HecateRangedTorchesConePhase_EM =
	{
		InheritFrom = { "HecateRangedTorchesConePhase" },
		AIData =
		{
			DeepInheritance = true,

			Spread = 30,
			ProjectileName = "HecateMeleeCone_EM",

			FireTicks = 10,
			FireInterval = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 5.0,
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
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
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
						{ Name = "HecateBurnedRecently", Time = 80 },
						{ Name = "HecateSpokeRecently", Time = 12 },
					},

					{ Cue = "/VO/Hecate_0347", Text = "Beware!" },
					{ Cue = "/VO/Hecate_0348", Text = "{#Emph}Burn!" },
					{ Cue = "/VO/Hecate_0349", Text = "{#Emph}Fire!" },
					{ Cue = "/VO/Hecate_0350", Text = "{#Emph}Fire...!" },
					{ Cue = "/VO/Hecate_0351", Text = "Bathe in flame!" },
				},
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/HecateShockwaveRingSFX" },
			},
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
			ProjectileName = "HecateTorchRingPhase",

			PostAttackDuration = 3.6,

			AttackDistance = 9999,
			MoveWithinRange = false,
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

	HecateRangedTorchesRingPhase_EM =
	{
		InheritFrom = { "HecateRangedTorchesRingPhase" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateTorchRingPhase_EM",
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
							"HecateBossAboutArachne02",
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

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			PostAttackEndTeleport = true,
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

	HecateTeleport2 =
	{
		InheritFrom = {"HecateTeleport"},

		AIData =
		{
			DeepInheritance = true,

			PreAttackAngleTowardTarget = false,

			TeleportMinDistance = 350,
			TeleportMaxDistance = 2000,
			TeleportToSpawnPointType = "EnemyPointSupport",
			ChainedWeaponOptions = "nil",

			--PostAttackCooldown = 1.0,
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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.16,
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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.29,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			FireDuration = 0.4,
			PostAttackDuration = 0.35,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			--FireFx = "SwordSwipeADisplace-Arthur",
			--FireFxOffset = 200,
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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteEvading",
			FireDuration = 0.5,
			PostAttackDuration = 2.2,

			--FireFx = "SwordSwipeAFlippedDisplace",
			--FireFxOffset = 200,
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
	},

	HecateEM_MeleeCombo =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponOptions = { "HecateEM_MeleeRight", "HecateEM_MeleeLeft", }, GameStateRequirements = { ChanceToPlay = 0.5, }, },
			{ WeaponOptions = { "HecateEM_MeleeRight", "HecateEM_MeleeLeft", }, GameStateRequirements = { ChanceToPlay = 0.5, }, },
			{ WeaponOptions = { "HecateEM_MeleeRight", "HecateEM_MeleeLeft", "HecateEM_MeleeDouble", }, DataOverrides = { PostAttackDuration = 0.9, PostAttackMinWaitTime = 0.9 }, },
		},

	},

	HecateEM_MeleeRight =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
			AttackDistance = 500,
			DashIfOverDistance = 500,
			DashWeapon = "HecateDash",

			ProjectileName = "HecateMelee1",
			BarrelLength = 100,

			PreAttackDuration = 0.65,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.125,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteChargingFierce",
			FireDuration = 0.2,
			PostAttackDuration = 0.05,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			StopBeforeFire = true,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			PreAttackAnimation = "HecateMeleeAttack1_PreAttack",
			FireAnimation = "Hecate_Combat_MeleeRight_Fire_Fast",
			PostAttackAnimation = "HecateMeleeAttack1_ReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteAttackingFierce" },
			},
		},
	},

	HecateEM_MeleeLeft =
	{
		InheritFrom = { "HecateEM_MeleeRight", },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateMelee2",

			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			PreAttackAnimation = "HecateMeleeAttack2_PreAttack",
			FireAnimation = "Hecate_Combat_MeleeLeft_Fire_Fast",
			PostAttackAnimation = "HecateMeleeAttack2_ReturnToIdle",
		},
	},

	HecateEM_MeleeDouble =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
			AttackDistance = 500,
			DashIfOverDistance = 500,
			DashWeapon = "HecateDash",

			AttackSlots =
			{
				{ ProjectileName = "HecateMelee1", AIDataOverrides = { FireProjectileAngleRelative = 37, }  },
				{ ProjectileName = "HecateMelee2", AIDataOverrides = { FireProjectileAngleRelative = -35, }  },
			},
			BarrelLength = 100,

			FireSelfVelocity = -2100,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			StopBeforeFire = true,

			PreAttackDuration = 0.7,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.16,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			FireDuration = 0.2,
			PostAttackDuration = 0.5,
			PostAttackMinWaitTime = 0.5,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			PreAttackAnimation = "HecateMeleeAttack3_PreAttack",
			FireAnimation = "HecateMeleeAttack3_Fire",
			PostAttackAnimation = "HecateMeleeAttack3_ReturnToIdle",
			FireFx = "StaffProjectileFireFx1_Hecate",
			FireFxOffset = 400,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteAttackingFierce2" },
			},
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
			PreMoveTeleport = true,
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
					{ Name = "HecateDividedRecently", Time = 80 },
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/Hecate_0144", Text = "Face all of me!", PlayFirst = true },
				{ Cue = "/VO/Hecate_0146", Text = "We are three!" },
				{ Cue = "/VO/Hecate_0147", Text = "Three-fold!", PlayFirst = true },
				{ Cue = "/VO/Hecate_0354", Text = "Three against one...", PlayFirst = true },
				{ Cue = "/VO/Hecate_0355", Text = "Divide and strike." },
				{ Cue = "/VO/HecateField_0026", Text = "{#Emph}Triple Divide!" },
				{ Cue = "/VO/HecateField_0027", Text = "{#Emph}Triple Divide...!" },
				{ Cue = "/VO/HecateField_0028", Text = "Past, present, {#Emph}future...!" },
				{ Cue = "/VO/HecateField_0029", Text = "We are as one!" },
				{ Cue = "/VO/HecateField_0311", Text = "Here I am!" },
				{ Cue = "/VO/HecateField_0312", Text = "Here we are!" },
				{ Cue = "/VO/HecateField_0313", Text = "I am everywhere..." },
				{ Cue = "/VO/HecateField_0314", Text = "All around you..." },
				{ Cue = "/VO/HecateField_0315", Text = "Three as one!" },
				{ Cue = "/VO/HecateField_0316", Text = "We are one." },
				{ Cue = "/VO/HecateField_0317", Text = "You're surrounded!" },
				{ Cue = "/VO/HecateField_0318", Text = "Together we shine...!" },
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
			ChainedWeaponOptions = { "HecateRangedTorchesHoming", "HecateRangedTorchesFork" },
		},
	},

	HecateSplit3 =
	{	
		InheritFrom = { "HecateSplit1" },

		Requirements =
		{
			MinAttacksBetweenUse = 2,
			RequireMaxIdsOfType = { Name = "LightRanged", Count = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			ChainedWeaponOptions = { "HecateRangedTorchesRingChained" },
		},
	},

	HecateEMSplit =
	{
		InheritFrom = { "HecateSplit1" },
		Requirements =
		{
			RequireMaxIdsOfType = { Name = "HecateCopyEM", Count = 0 }
		},
		
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			SpawnedUnit = "HecateCopyEM",
			PreferredSpawnPointType = "EnemyPointRanged",
			--ChainedWeaponOptions = "nil",
			SyncChainedWeapons = true,
			PostAttackDuration = 0.0,
			--ChainedWeaponOptions = "nil",
		},
	},

	HecateComboBreakerSplit =
	{
		AIData =
		{
			DeepInheritance = true,

			FireFunctionName = "HecateComboBreakerSplit",

			MoveWithinRange = true,
			NoProjectile = true,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
	},

	HecateDash =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,


			NoProjectile = true,

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "QuickRotate",
					DataProperties = 
					{
						Duration = 0.2,
						RotationMultiplier = 10.0,
					}
				},
			},

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "DashGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.15,
						Modifier = 0.1,
						HaltOnEnd = true,
					}
				},
			},

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			FireSelfVelocity = 3000,

			PreAttackDuration = 0.25,
			FireDuration = 0.13,
			PostAttackDuration = 0.27,

			PreAttackAnimation = "Hecate_Combat_Dash_Start",
			FireAnimation = "Hecate_Combat_Dash_Fire",
			PostAttackAnimation = "Hecate_Combat_Dash_End",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteEvading2" },
			},
		},
	},

	HecateDarkSideTransform =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 16,
			MaxUses = 3,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "HecateDSRing",

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "HecateDarkSide",
					DataProperties =
					{
						Type = "TAG",
						Duration = 10,
					}
				}
			},

			FireProjectileStartDelay = 0.8,
			PreAttackDuration = 0.0,
			FireDuration = 2.0,
			PostAttackDuration = 0.5,

			FireAnimation = "Hecate_Combat_Transform",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},
	},
	HecateDarkSideTransform2 =
	{
		InheritFrom = { "HecateDarkSideTransform" },
		Requirements =
		{
			MinAttacksBetweenUse = 10,
		},
	},

	HecateDarkSideRanged =
	{
		Requirements =
		{
			HasEffect = "HecateDarkSide",
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateDSRanged",

			PreAttackSound = "/SFX/Enemy Sounds/Hecate/EmoteChargingFierce",
			PreAttackDuration = 1.0,
			FireDuration = 1.76,
			PostAttackDuration = 1.5,
			PostAttackMinWaitTime = 1.5,

			NumProjectiles = 8,
			ProjectileInterval = 0.22,
			Spread = 10,
			BarrelLength = 100,
			ProjectileFireSound = "/SFX/Player Sounds/TransformAttackFire",
			CancelProjectilesOnTransition = true,
			AIThreadName = "HecateDarkSideRangedThread",

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.12,
			PostAttackStop = true,

			PreAttackAnimation = "Hecate_Combat_DSRanged_Start",
			FireAnimation = "Hecate_Combat_DSRanged_Fire",
			PostAttackAnimation = "Hecate_Combat_DSRanged_End",

			MoveWithinRange = true,
			AttackDistance = 1600,
			DashIfOverDistance = 900,
			DashWeapon = "HecateDash",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/TransformAttackFire" },
			}
		}
	},

	HecateDarkSideRangedExtended =
	{
		InheritFrom = { "HecateDarkSideRanged", },
		GenusName = "HecateDarkSideRanged",
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 3.52,

			NumProjectiles = 16,
			ProjectileInterval = 0.22,
		},
	},

	HecateDarkSideRangedNoDash =
	{
		InheritFrom = { "HecateDarkSideRanged", },
		GenusName = "HecateDarkSideRanged",
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			DashIfOverDistance = "nil",
			DashWeapon = "nil",
		},
	},

	HecateDarkSideRing =
	{
		Requirements =
		{
			HasEffect = "HecateDarkSide",
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HecateDSRing",
			BarrelLength = 0,
			FireProjectileAtSelf = true,

			PreAttackDuration = 0.7,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.16,
			PreAttackSound = "/SFX/Enemy Sounds/Hecate/HecatePreFire",
			FireDuration = 1.365,
			PostAttackDuration = 0.3,
			PostAttackMinWaitTime = 0.3,

			PreAttackAnimation = "Hecate_Combat_DSRing",

			MoveWithinRange = true,
			AttackDistance = 500,
			DashIfOverDistance = 600,
			DashWeapon = "HecateDash",

			ChainedWeaponOptions = { "HecateDarkSideRangedNoDash", },

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
						{ Name = "HecateBurnedRecently", Time = 80 },
						{ Name = "HecateSpokeRecently", Time = 12 },
					},

					{ Cue = "/VO/Hecate_0347", Text = "Beware!" },
					{ Cue = "/VO/Hecate_0348", Text = "{#Emph}Burn!" },
					{ Cue = "/VO/Hecate_0349", Text = "{#Emph}Fire!" },
					{ Cue = "/VO/Hecate_0350", Text = "{#Emph}Fire...!" },
					{ Cue = "/VO/Hecate_0351", Text = "Bathe in flame!" },
				},
				{ GlobalVoiceLines = "HecateHexVoiceLines" },
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/HecateShockwaveRingSFX" },
			},
		},
	},

	HecateWolfHowl =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 9,
			MaxPlayerDistance = 430,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "HecateWolfHowlBlast",

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 350,
			OccupyTargetSpawnPoint = true,

			PreAttackFunctionName = "HecateWolfHowl",
			RiseDistance = 400,
			PreLeapTime = 0.16,
			RiseTime = 0.4,			--Ascent duration
			HangTime = 0.5,				--Pause at apex duration
			LandingTime = 0.175,			--Descent duration
			LeapRiseSound = "/SFX/Enemy Sounds/Hecate/EmoteCharging",
			LeapFlightSound = "/SFX/Enemy Sounds/Hecate/EmoteAttacking",
			LeapLandingSound = "/SFX/Player Sounds/LeapTraitImpact",
			PreLeapAnimation = "Hecate_Combat_WolfHowl_Start",
			LeapAnimation = "Hecate_Combat_WolfHowl_Fire",

			PreAttackDuration = 0,
			FireDuration = 0.0,
			PostAttackDuration = 1.5,
			PostAttackMinWaitTime = 1.5,

			WaitForAngleTowardTarget = true,

			MoveWithinRange = true,
			AttackDistance = 1300,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil