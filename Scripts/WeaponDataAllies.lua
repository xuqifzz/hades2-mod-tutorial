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
	SpellSummonRanged = 
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SpellSummonRanged",
			BarrelLength = 55,

			PreAttackDuration = 0.3,
			FireDuration = 0.3,
			PostAttackDuration = 0.6,
			
			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackAnimation = "Enemy_Swarmer_MeleeAttackPreAttack",
			FireAnimation = "Enemy_Swarmer_MeleeAttackFire",
			PostAttackAnimation = "Enemy_Swarmer_MeleeAttackReturnToIdle",

			DeathSound = "/SFX/Enemy Sounds/Swarmer/EmoteDying",

			AttackDistance = 1000,
			RequireProjectileLoS = true,
			LoSBuffer = 40,
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

	SummonSelfDestruct =
	{
		StartingWeapon = false,
		IgnoreHealthBuffer = true,
		OnFiredFunctionName = "SelfDestruct",
		
		AIData =
		{
			DeepInheritance = true,
			
			AttackDistance = 200,
			PreAttackDuration = 0.1,
		},
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
	},

	RavenFamiliarMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RavenFamiliarMelee",

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.MeleeAttackGrip,
			},

			PreAttackDuration = 0.15,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			AttackDistance = 525,
		},
		
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Familiars/RavenSquawk2" },
				{ Name = "/SFX/Familiars/RavenFlap" },
				{ Name = "/SFX/Player Sounds/WeaponSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
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
			BarrelLength = 0,
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
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" }
						},
						ChanceToPlay = 0.2,
					},
					{ Cue = "/VO/Melinoe_0132", Text = "Go!", PlayFirst = true },
					{ Cue = "/VO/Melinoe_0133", Text = "You're free!" },
					{ Cue = "/VO/Melinoe_0134", Text = "Fight!" },
					{ Cue = "/VO/Melinoe_0135", Text = "Now!" },
					{ Cue = "/VO/MelinoeField_0580", Text = "Attack!" },
					{ Cue = "/VO/MelinoeField_0581", Text = "Together!" },
					{ Cue = "/VO/MelinoeField_0582", Text = "Aid me!" },
					{ Cue = "/VO/MelinoeField_0583", Text = "Strike true!" },
					{ Cue = "/VO/Melinoe_0335", Text = "Smite them!",
						GameStateRequirements =
						{
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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
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

			PreAttackFxAtTarget = "IcarusFlyBy",

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

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
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
			
			PreAttackFxAtTarget = "IcarusFlyByReverse",
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

			PreAttackFxAtTarget = "IcarusFlyBy",

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

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
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

			PreAttackFxAtTarget = "IcarusFlyBy",

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

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	IcarusBombardmentSingle =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "IcarusBombardment_Large",
			
			TargetRequiredKillEnemy = true,

			PreAttackFxAtTarget = "IcarusFlyBy",

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 5.5,
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

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
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
			--AIChargeTargetMarker = "ArtemisTargetMarker",
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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
	},

	ArtemisHuntersMark =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ArtemisHuntersMark",
			FireProjectileAtTarget = true,
			
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
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.25,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.5,
					Cooldowns =
					{
						{ Name = "MelinoeHuntersMarkSpeech", Time = 35 },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

					{ Cue = "/VO/Melinoe_1943", Text = "Marked one for me did you?", PlayFirst = true },
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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
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

			FireProjectileStartDelay = 0.025,

			PreAttackDuration = 0.6,
			FireDuration = 0.22,
			PostAttackDuration = 1.7,

			AttackDistance = 350,
			MoveWithinRange = true,
			PreAttackStop = true,

			FireFx = "MinotaurAxeArcRight",
			--PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmoteCharging",
			PreAttackAnimation = "Heracles_Combat_AttackPreFire",
			FireAnimation = "Heracles_Combat_AttackFire",
			PostAttackAnimation = "Heracles_Combat_AttackPostFire",

			--PreAttackAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
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

			FireFx = "EnemyHeavySlash",
			FireFxOffset = 300,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			PreAttackStop = true,

			PreAttackDuration = 0.0,
			--PreFireDuration = 0.3,
			FireDuration = 0.3,
			PostAttackDuration = 0.3,

			PreAttackLeap = true,
			LeapToTarget = true,
			LeapSound = "/Leftovers/SFX/PlayerJump",
			--LeapLandingSound = "",
			LeapSpeed = 2000,
			LeapPrepareTime = 0.6,
			LeapRecoveryTime = 0.0,
			LeapChargeAnimation = "Heracles_Combat_LeapPreFire",
			LeapAnimation = "Heracles_Combat_LeapFire",

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