WeaponDataAllies =
{
	SpellSummonMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SpellSummonMelee",

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.MeleeAttackGrip,
			},

			PreAttackDuration = 0.15,
			FireDuration = 0.3,
			PostAttackDuration = 0.3,

			AttackDistance = 225,

			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackAnimation = "Enemy_Swarmer_MeleeAttackPreAttack",
			FireAnimation = "Enemy_Swarmer_MeleeAttackFire",
			PostAttackAnimation = "Enemy_Swarmer_MeleeAttackReturnToIdle",
		},


		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/FlameTrapFire" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/DaggerImpactWoodHard",
				Brick = "/SFX/DaggerImpactWoodSoft",
				Stone = "/SFX/DaggerImpactWoodSoft",
				Organic = "/SFX/DaggerImpactOrganic",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},		
		},		
	},

	SoulPylonDeath =
	{

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SoulPylonSpiritball",
			BarrelLength = 0,

			FireTicksMin = 15,
			FireTicksMax = 15,
			FireInterval = 0.01,
			Spread = 360,


			FireProjectileAtTarget = true,
			ResetTargetPerTick = true,
			TargetRequiredKillEnemy = true,
			IgnoreInvulnerable = true,		
			FireAlliedToPlayer = true,
			TargetGroups = { "GroundEnemies", "FlyingEnemies" },

			PreAttackDuration = 0,
			FireDuration = 0.05,
			PostAttackDuration = 0.0,

			AttackDistance = 99999,
		}
	},
	
	ShadeMercSpiritball =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeShadeMercs", },
			},
		},

		AIData =
		{
			DeepInheritance = true,
			SaveProjectileId = true,
			ProjectileName = "ShadeMercSpiritball",
			BarrelLength = 0,

			PreAttackDuration = 0.0,
			FireDuration = 0.05,
			PostAttackDuration = 0.0,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,

			AttackDistance = 99999,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.15,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "UsedShadeMercRecently", Time = 400 },
					},
					GameStateRequirements =
					{
						ChanceToPlay = 0.2,
					},
					{ Cue = "/VO/Melinoe_0132", Text = "Go!", PlayFirst = true },
					{ Cue = "/VO/Melinoe_0135", Text = "Now!" },
					{ Cue = "/VO/Melinoe_3977", Text = "Now, Shade!" },
					{ Cue = "/VO/Melinoe_3979", Text = "For the Underworld!" },
					{ Cue = "/VO/Melinoe_3980", Text = "We fight!" },
					{ Cue = "/VO/Melinoe_3982", Text = "Show the Commander!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_0133", Text = "You're free!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_0134", Text = "Fight!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_3978", Text = "Fight back!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_3981", Text = "I release you!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0580", Text = "Attack!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0581", Text = "Together!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0582", Text = "Aid me!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0583", Text = "Strike true!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_0335", Text = "Smite them!",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
							{
								Path = { "RequiredKillEnemies" },
								UseLength = true,
								Comparison = ">=",
								Value = 2,
							},
						},
					},
				},
				{
					PlayOnce = true,
					PlayOnceContext = "HecateFirstShadeMercReactionVO",
					BreakIfPlayed = true,
					PreLineWait = 0.66,
					ChanceToPlay = 0.5,
					ObjectType = "Hecate",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
							Comparison = ">",
							Value = 0.2,
						},
					},
					TriggerCooldowns = { "HecateSpokeRecently" },

					{ Cue = "/VO/HecateField_0245", Text = "Shades on your side..." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "HecateShadeMercReactionVO",
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.66,
					SuccessiveChanceToPlay = 0.1,
					ObjectType = "Hecate",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
							Comparison = ">",
							Value = 0.2,
						},
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/HecateField_0245" }
						},
						ChanceToPlay = 0.33,
					},
					Cooldowns =
					{
						{ Name = "HecateSpokeRecently", Time = 10 },
					},

					{ Cue = "/VO/HecateField_0243", Text = "They favor you!" },
					{ Cue = "/VO/HecateField_0244", Text = "They fight for you!", PlayFirst = true },
					{ Cue = "/VO/HecateField_0245", Text = "Shades on your side..." },
					{ Cue = "/VO/HecateField_0246", Text = "You're their Princess!" },
				},

			},
		},
		
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Exalted/NakedShadeRespawned" },
			},

			ImpactSounds =
			{			
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
				StoneObstacle = "/SFX/BurnDamage",
				BrickObstacle = "/SFX/BurnDamage",
				MetalObstacle = "/SFX/BurnDamage",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
	},
	ShadeMercAspectSpiritball = 
	{
		InheritFrom = {"ShadeMercSpiritball"},
		
		GameStateRequirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "ShadeMercAspectSpiritball",
		},

	},
	IcarusBombardmentLine =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment",
			AttackSlotInterval = 0.2,
			AttackSlots =
			{
				{ OffsetX = -600, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = -300, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 300, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 600, OffsetY = -600, OffsetScaleY = 0.5 },
			},
			
			TargetSpawnPoints = true,
			FireProjectileAtTarget = true,


			PreAttackThreadedFunctionName = "IcarusFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8, },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 4.5,
			PostAttackCooldownMax = 4.5,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 6,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	IcarusBombardmentLineReverse =
	{
		InheritFrom = { "IcarusBombardmentLine" },
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ OffsetX = 600, OffsetY = -600, OffsetScaleY = 0.5 },
				{ OffsetX = 300, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = -300, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = -600, OffsetY = 600, OffsetScaleY = 0.5 },
			},

			PreAttackThreadedFunctionName = "IcarusFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8, ReverseDirection = true },
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
	},

	IcarusBombardmentLine2 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment",
			AttackSlotInterval = 0.2,
			AttackSlots =
			{
				{ OffsetX = 0, OffsetY = 600, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = -300, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = -600, OffsetScaleY = 0.5 },
			},

			TargetSpawnPoints = true,
			FireProjectileAtTarget = true,
			SkipIfInvalidLocation = true,

			PreAttackThreadedFunctionName = "IcarusFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8 },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 4.5,
			PostAttackCooldownMax = 4.5,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	IcarusBombardmentLine3 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment",
			AttackSlotInterval = 0.2,
			AttackSlots =
			{
				{ OffsetX = -600, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = -300, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 0, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 300, OffsetY = 0, OffsetScaleY = 0.5 },
				{ OffsetX = 600, OffsetY = 0, OffsetScaleY = 0.5 },
			},
			
			TargetSpawnPoints = true,
			FireProjectileAtTarget = true,

			PreAttackThreadedFunctionName = "IcarusFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8, },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 4.5,
			PostAttackCooldownMax = 4.5,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	IcarusBombardmentSingle =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment_Large",
			
			TargetRequiredKillEnemy = true,

			PreAttackThreadedFunctionName = "IcarusFlyByPresentation",
			PreAttackThreadedFunctionArgs = { FlyByZHeight = 450, FlyByDuration = 1.0, FlyBySpeed = 4500, FlyByScale = 1.8, ReverseDirection = true },

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.15,
			PostAttackCooldownMax = 3.65,
		},

		Requirements =
		{
			-- MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	--[[IcarusBombardmentCluster =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment_Small",

			FireTicks = 10,
			FireInterval = 0.05,
			ResetTargetPerTick = true,
			
			TargetSpawnPoints = true,
			FireProjectileAtTarget = true,


			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 5.0,
			PostAttackCooldownMax = 7.5,
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
	},]]

	ArtemisSniper =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ArtemisSniperBolt",
			TargetRequiredKillEnemy = true,
			ProjectileLeadTarget = true,
			FireProjectileAtTarget = true,
			CancelIfTargetIsDead = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			PreAttackDuration = 1.8,
			FireDuration = 0.5,
			PostAttackDurationMin = 3.0,
			PostAttackDurationMax = 3.5,

			HealthTickDamage = 999,

			PreAttackEndShake = true,
			PreAttackFx = "ArtemisAimLine",
			EndPreAttackFx = true,

			AttackDistance = 99999,
			TrackTargetDuringCharge = true,

			TrackKillSteal = true,

			ForceFirst = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
			},
		},
	},

	ArtemisHuntersMark =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ArtemisHuntersMark",
			FireProjectileAtTarget = true,
			TargetClosestToPlayer = false,
			
			PreAttackDuration = 0.5,
			FireDuration = 0.0,
			PostAttackDurationMin = 5.0,
			PostAttackDurationMax = 5.5,

			AttackDistance = 9999,
			MinAttacksBetweenUse = 3,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.25,
					SuccessiveChanceToPlay = 0.5,
					Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
					Cooldowns =
					{
						{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
					},

					{ Cue = "/VO/Artemis_0216", Text = "One's exposed." },
					{ Cue = "/VO/Artemis_0217", Text = "Get that one.", PlayFirst = true },
					{ Cue = "/VO/Artemis_0218", Text = "Easy mark." },
					{ Cue = "/VO/Artemis_0219", Text = "Easy target." },
					{ Cue = "/VO/Artemis_0220", Text = "See that one?" },
					{ Cue = "/VO/Artemis_0221", Text = "Picked one out." },
					{ Cue = "/VO/Artemis_0222", Text = "Marked one." },
					{ Cue = "/VO/Artemis_0060", Text = "See that?", PlayFirst = true },
					{ Cue = "/VO/Artemis_0056", Text = "There." },
					{ Cue = "/VO/Artemis_0441", Text = "Target marked." },
					{ Cue = "/VO/Artemis_0442", Text = "That one there." },
					{ Cue = "/VO/Artemis_0443", Text = "Get the mark." },
					{ Cue = "/VO/Artemis_0444", Text = "One's open." },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.25,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.25,
					SuccessiveChanceToPlayAll = 0.05,
					Cooldowns =
					{
						{ Name = "MelinoeHuntersMarkSpeech", Time = 35 },
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/Melinoe_1943", Text = "Marked one for me, did you?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1944", Text = "She marked that one for me." },
					{ Cue = "/VO/Melinoe_1945", Text = "The Hunter's Mark again." },
					{ Cue = "/VO/Melinoe_1946", Text = "There's her Mark." },
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/HadesHealingTick" },
			},
		},
	},

	ArtemisVolley =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ArtemisVolleyShot",
			FireTicksMin = 8,
			FireTicksMax = 12,
			FireIntervalMin = 0.01,
			FireIntervalMax = 0.05,
			ResetTargetPerTick = true,
			ProjectileDestinationOffsetFromTarget = true,
			ProjectileOffsetDistanceMin = 0,
			ProjectileOffsetDistanceMax = 325,
			ProjectileOffsetRandomAngle = true,
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			PreAttackDuration = 1.2,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.0,
			PostAttackDurationMax = 3.5,

			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowRapidFire" },
			},
		},
	},

	ArtemisHealDrop =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ArtemisHealVolleyShot",
			ProjectileDestinationOffsetFromTarget = true,
			ProjectileOffsetDistanceMin = 500,
			ProjectileOffsetDistanceMax = 600,
			ProjectileOffsetRandomAngle = true,
			FireProjectileAtTarget = true,
			FireProjectileTowardTarget = true,

			TargetRequiredKillEnemy = false,
			TargetClosestToPlayer = false,

			PreAttackDuration = 0.0,
			FireDuration = 1.2,
			PostAttackDurationMin = 6.0,
			PostAttackDurationMax = 6.5,

			AttackDistance = 9999,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				TriggerCooldowns = { "ArtemisAnyQuipSpeech" },

				{ Cue = "/VO/Artemis_0227", Text = "Incoming supplies." },
				{ Cue = "/VO/Artemis_0228", Text = "Supplies inbound." },
				{ Cue = "/VO/Artemis_0229", Text = "Got something for you." },
				{ Cue = "/VO/Artemis_0230", Text = "Heads up, Sister." },
				{ Cue = "/VO/Artemis_0231", Text = "Here, patch up.", PlayFirst = true },
				{ Cue = "/VO/Artemis_0232", Text = "Patch yourself up." },
				{ Cue = "/VO/Artemis_0233", Text = "How about a snack?" },
				{ Cue = "/VO/Artemis_0234", Text = "Have a quick bite." },
			},
			MaxUses = 1,
			
		},
		Requirements =
		{
			PlayerHealthPercentMax = 0.5,
			MinAttacksBetweenUse = 8,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusMortarLaunch" },
			},
		},
	},

	NemesisAttack1 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "NemesisAttack1",

			FireSelfVelocity = 700,
			FireProjectileStartDelay = 0.1,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,

			PreAttackDuration = 0.22,
			PreAttackSound = "/SFX/Enemy Sounds/Nemesis/EmoteCharging",
			FireDuration = 0.14,
			PostAttackDuration = 0.0, -- animation is 0.68

			AttackDistance = 230,
			MoveWithinRange = true,
			PreAttackStop = true,

			PreAttackEndShake = false,
			PreAttackAnimation = "Nemesis_Combat_Attack1_Start",
			FireAnimation = "Nemesis_Combat_Attack1_Fire",
			--PostAttackAnimation = "Nemesis_Combat_Attack1_End",

			ExpireProjectilesOnHitStun = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,

			ChainedWeapon = "NemesisAttack2",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSwordOverhead" },
				{ Name = "/SFX/Enemy Sounds/Nemesis/EmoteAttacking" },		
			},
		},
	},

	NemesisAttack2 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "NemesisAttack2",

			FireSelfVelocity = 1100,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,

			PreAttackDuration = 0.27,
			PreAttackSound = "/SFX/Enemy Sounds/Nemesis/EmoteCharging",
			FireDuration = 0.24,
			PostAttackDuration = 0.0, -- animation is 0.68

			MoveWithinRange = false,
			PreAttackStop = true,

			PreAttackEndShake = false,
			PreAttackAnimation = "Nemesis_Combat_Attack2_Start",
			FireAnimation = "Nemesis_Combat_Attack2_Fire",
			--PostAttackAnimation = "Nemesis_Combat_Attack2_End",

			ExpireProjectilesOnHitStun = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,

			ChainedWeapon = "NemesisAttack3",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSwordOverhead" },
				{ Name = "/SFX/Enemy Sounds/Nemesis/EmoteAttacking" },		
			},
		},
	},

	NemesisAttack3 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "NemesisAttack3",
			FireProjectileStartDelay = 0.15,

			FireSelfVelocity = 1100,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,

			PreAttackDuration = 0.55,
			PreAttackSound = "/SFX/Enemy Sounds/Nemesis/EmoteCharging",
			FireDuration = 0.35,
			PostAttackDuration = 0.9, -- animation is 0.68

			MoveWithinRange = false,
			PreAttackStop = true,

			PreAttackEndShake = false,
			PreAttackAnimation = "Nemesis_Combat_Attack3_Start",
			FireAnimation = "Nemesis_Combat_Attack3_Fire",
			PostAttackAnimation = "Nemesis_Combat_Attack3_End",

			ExpireProjectilesOnHitStun = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSwordOverhead" },
				{ Name = "/SFX/Enemy Sounds/Nemesis/EmoteAttacking" },		
			},
		},
	},

	NemesisSpecial =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "NemesisSpecial",

			BarrelLength = 150,
			FireProjectileStartDelay = 0.1,

			PreAttackDuration = 0.67,
			PreAttackSound = "/SFX/Enemy Sounds/Nemesis/EmotePowerCharging",
			FireDuration = 0.35,
			PostAttackDuration = 0.6, -- animation is 0.58

			AttackDistance = 250,
			MoveWithinRange = true,
			PreAttackStop = true,

			PreAttackEndShake = false,
			PreAttackAnimation = "Nemesis_Combat_Special_Start",
			FireAnimation = "Nemesis_Combat_Special_Fire",
			PostAttackAnimation = "Nemesis_Combat_Special_End",

			ExpireProjectilesOnHitStun = true,
			PreAttackAngleTowardTarget = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSwordParry" },
				{ Name = "/SFX/Enemy Sounds/Nemesis/EmoteSpecialAttack" },
			},
		},

	},

	NemesisDash =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			FireSelfVelocity = 2000,

			PreAttackDuration = 0.2,
			FireDuration = 0.45,
			PostAttackDuration = 0.3,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Nemesis_Combat_Dash_Start",
			FireAnimation = "Nemesis_Combat_Dash_Fire",
			PostAttackAnimation = "Nemesis_Combat_Dash_End",

			ExpireProjectilesOnHitStun = true,
			PreAttackAngleTowardTarget = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,

			MaxConsecutiveUses = 1,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Nemesis/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Exalted/ExaltedDash" },
			},
		},
	},

	HeraclesMeleeArc =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HeraclesArcRight",

			FireSelfVelocity = 1300,
			FireProjectileStartDelay = 0.09,

			PreAttackDuration = 0.62,
			FireDuration = 0.22,
			PostAttackDuration = 1.7,

			AttackDistance = 350,
			MoveWithinRange = true,
			PreAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmoteCharging",
			PreAttackAnimation = "Heracles_Combat_Swipe_Start",
			FireAnimation = "Heracles_Combat_Swipe_Fire",
			PostAttackAnimation = "Heracles_Combat_Swipe_End",

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			ExpireProjectilesOnHitStun = true,
			TargetRequiredKillEnemy = true,
			TrackKillSteal = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heracles/EmoteAttacking" },
			},
		},

	},

	HeraclesLeap =
	{
		Requirements =
		{
			--MaxConsecutiveUses = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HeraclesLeap",

			TargetRequiredKillEnemy = true,
			TargetMinDistance = 500,
			TrackKillSteal = true,

			MoveWithinRange = true,
			StopMoveWithinRange = true,
			AttackDistance = 800,
			LoSBuffer = 120,
			RequireUnitLoS = true,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			PreAttackStop = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.1,
			PostAttackDuration = 1.25,

			PreAttackLeap = true,
			LeapToTarget = true,
			LeapSound = "/Leftovers/SFX/PlayerJump",
			LeapSpeed = 2000,
			LeapPrepareTime = 0.6,
			LeapRecoveryTime = 0.0,
			LeapChargeAnimation = "Heracles_Combat_Leap_Start",
			LeapAnimation = "Heracles_Combat_Leap_Fire",
			LeapLandingAnimation = "Heracles_Combat_Leap_Fire2",
			PostAttackAnimation = "Heracles_Combat_Leap_End",

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.45,
					Cooldowns =
					{
						{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
					},

					{ Cue = "/VO/Heracles_0196", Text = "Die!" },
					{ Cue = "/VO/Heracles_0197", Text = "Fall!" },
					{ Cue = "/VO/Heracles_0198", Text = "You!" },
					{ Cue = "/VO/Heracles_0199", Text = "You!" },
					{ Cue = "/VO/Heracles_0200", Text = "Now!" },
					{ Cue = "/VO/Heracles_0201", Text = "{#Emph}Hrah!" },
					{ Cue = "/VO/Heracles_0202", Text = "Here!" },
					{ Cue = "/VO/Heracles_0203", Text = "Your turn!" },
					{ Cue = "/VO/Heracles_0204", Text = "Your turn!" },
					{ Cue = "/VO/Heracles_0205", Text = "Prepare!" },
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heracles/EmoteCharging" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponDataAllies )