UnitSetData.Heracles =
{
	Heracles =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Heracles_Default_01",
		SpeakerName = "Heracles",
		LoadPackages = { "Heracles", },
		SubtitleColor = Color.HeraclesVoice,
		EmoteOffsetY = -350,
		EmoteOffsetX = 120,
		AnimOffsetZ = -20,
		RunHistoryKilledByName = "NPC_Heracles_01",

		Groups = { "NPCs", "GroundEnemies" },
		MaxHealth = 34000,
		AIWakeDelay = 1.5,

		ForcedNextWeapon = "HeraclesEMRoar_Dummy",
		PreBossAISetupFunctionName = "HeraclesIntroPresentation",

		Material = "Organic",

		BlockPostBossMetaUpgrades = true,
		SkipDisableAllyUnitsOnDeath = true,

		DefaultAIData =
		{

		},

		AIOptions =
		{
			"AttackerAI",
		},

		StopAnimationsOnDeath =
		{
			"EliteUnitStatus2"
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					HealthBarLocationX = 1250,
					HealthBarScaleX = 0.7,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 600,
								Window = 0.6,
								--MaxComboBreakers = 6,
								ComboBreakerCooldown = 7,
								ForcedWeaponInterrupt = "HeraclesRetreatSpin",
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredShrineLevel",
						FunctionArgs =
						{
							ShrineUpgradeName = "BossDifficultyShrineUpgrade",
							Comparison = ">=",
							Value = 3,
						},
					},
				},
			},
		},

		WeaponOptions = { "HeraclesEMMeleeArc", "HeraclesEMLeap", "HeraclesEMMeleeArc_Passive", "HeraclesEMSpin", "HeraclesEMLeap_Passive" },
		--WeaponOptions = { "HeraclesEMLeap_Passive", },

		OnDeathFunctionName = "HeraclesKillPresentation",

		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Heracles_Combat_Idle",
				ThreadedEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							SetAlpha = 1.0,
							Duration = 0.0,
						},
					},
					{
						FunctionName = "ClearAllEffects",
					}
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "HeraclesEMMeleeArc", "HeraclesEMLeap", "HeraclesEMLeapSpinCombo",
							"HeraclesEMMeleeArc_Passive", "HeraclesEMSpin", "HeraclesEMLeap_Passive", },
				DataOverrides =
				{
					ForcedNextWeapon = "HeraclesEMRoar",
				},


				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					Cooldowns =
					{
						-- { Name = "CyclopsSearchedRecently", Time = 30 },
					},
					TriggerCooldowns = { "HeraclesAnyQuipSpeech" },

					{ Cue = "/VO/Heracles_0644", Text = "I have had {#Emph}enough!" },
					{ Cue = "/VO/Heracles_0645", Text = "{#Emph}This {#Prev}is a proper fight!" },
					{ Cue = "/VO/Heracles_0646", Text = "{#Emph}Now {#Prev}this is a fight!" },
					{ Cue = "/VO/Heracles_0647", Text = "You think you can beat {#Emph}me?!" },
					{ Cue = "/VO/Heracles_0650", Text = "No more holding {#Emph}back!" },
					{ Cue = "/VO/Heracles_0651", Text = "I've not felt this in {#Emph}ages!" },
					{ Cue = "/VO/Heracles_0652", Text = "The taste of my own {#Emph}blood!" },
					{ Cue = "/VO/Heracles_0653", Text = "This shall soon be {#Emph}over!" },
					{ Cue = "/VO/Heracles_0655", Text = "We'll {#Emph}never {#Prev}bow to any of you gods!" },
					{ Cue = "/VO/Heracles_0656", Text = "When are you going to {#Emph}learn?" },
					{ Cue = "/VO/Heracles_0657", Text = "We're not finished yet!" },
					{ Cue = "/VO/Heracles_0658", Text = "All right, witch, now we {#Emph}fight!" },
					{ Cue = "/VO/Heracles_0659", Text = "Curse you {#Emph}and {#Prev}your magick, witch!" },
					{ Cue = "/VO/Heracles_0648", Text = "You think you can take {#Emph}us?!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
								Comparison = ">",
								Value = 0.1,
							},
						}
					},
					{ Cue = "/VO/Heracles_0649", Text = "You think you have us, {#Emph}witch?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
								Comparison = ">",
								Value = 0.1,
							},
						},
					},
					{ Cue = "/VO/Heracles_0654", Text = "You won't burn alone, Prometheus!",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
								Comparison = "<",
								Value = 0.1,
							},
						},
					},

				},

			},
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Heracles" },
					Comparison = ">=",
					Value = 0.3,
				},
			},
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 12 },
				{ Name = "HeraclesDamageSpeech", Time = 30 },
				{ Name = "AnyDamageSpeech", Time = 8 },
			},

			{ Cue = "/VO/Heracles_0490", Text = "You bleed." },
			{ Cue = "/VO/Heracles_0491", Text = "Got you." },
			{ Cue = "/VO/Heracles_0492", Text = "Felt that?" },
			{ Cue = "/VO/Heracles_0493", Text = "Still up?" },
			{ Cue = "/VO/Heracles_0494", Text = "Still standing..." },
			{ Cue = "/VO/Heracles_0495", Text = "Survived...!" },
			{ Cue = "/VO/Heracles_0496", Text = "You're tough!" },
			{ Cue = "/VO/Heracles_0497", Text = "Break your bones." },
			{ Cue = "/VO/Heracles_0498", Text = "Dodge {#Emph}that." },
			{ Cue = "/VO/Heracles_0499", Text = "Go down." },
			{ Cue = "/VO/Heracles_0500", Text = "Foolish witch.", PlayFirst = true },
		},

		OnHitVoiceLinesQueueDelay = 0.35,
		OnHitVoiceLines =
		{
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Heracles" },
					Comparison = ">=",
					Value = 0.3,
				},
			},
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 12 },
			},
			{
				GameStateRequirements = 
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "FrogFamiliarLand" },
					},
				},
				{ Cue = "/VO/Heracles_0531", Text = "Bloody toad..." },
				{ Cue = "/VO/Heracles_0532", Text = "Back, toad..." },
			},
			{
				GameStateRequirements =
				{

					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "CatFamiliarPounce" },
					},
				},
				{ Cue = "/VO/Heracles_0535", Text = "Bloody cat..." },
				{ Cue = "/VO/Heracles_0536", Text = "Back off, cat..." },
			},
			{
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "RavenFamiliarMelee" },
					},
				},

				{ Cue = "/VO/Heracles_0533", Text = "Bloody bird..." },
				{ Cue = "/VO/Heracles_0534", Text = "Damn bird..." },
			},
			{
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "HoundFamiliarBark" },
					},
				},

				{ Cue = "/VO/Heracles_0537", Text = "Bloody dog..." },
				{ Cue = "/VO/Heracles_0538", Text = "Get off me, cur..." },
			},
			{
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "PolecatFamiliarMelee" },
					},
				},

				{ Cue = "/VO/Heracles_0539", Text = "Bloody weasel..." },
				{ Cue = "/VO/Heracles_0540", Text = "Blasted weasel..." },
			},
		},

		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlay = 0.75,
				SuccessiveChanceToPlayAll = 0.75,
				GameStateRequirements =
				{
					--
				},

				{ Cue = "/VO/Heracles_0407", Text = "Enough of this!" },
				{ Cue = "/VO/Heracles_0408", Text = "{#Emph}Gah! {#Prev}How..." },
				{ Cue = "/VO/Heracles_0409", Text = "{#Emph}Argh, blast!" },
				{ Cue = "/VO/Heracles_0410", Text = "{#Emph}Urgh, damn..." },
				{ Cue = "/VO/Heracles_0411", Text = "{#Emph}Urgh{#Prev}, embarrassing..." },
				{ Cue = "/VO/Heracles_0412", Text = "{#Emph}Argh{#Prev}, I'm done...!" },
				{ Cue = "/VO/Heracles_0413", Text = "How could this... {#Emph}argh!" },
				{ Cue = "/VO/Heracles_0414", Text = "Sorry, Flame Thief...", PlayFirst = true },
				{ Cue = "/VO/Heracles_0415", Text = "Fight on, brother!" },
				{ Cue = "/VO/Heracles_0416", Text = "Falling back...!" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.1,
				ObjectType = "Prometheus",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "PrometheusSpokeRecently", Time = 4 },
				},
				{ Cue = "/VO/Prometheus_0389", Text = "Heracles...!", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0379", Text = "Drove him back..." },
				{ Cue = "/VO/Prometheus_0380", Text = "You scared him off." },
				{ Cue = "/VO/Prometheus_0381", Text = "I tried to warn you, man!" },
				{ Cue = "/VO/Prometheus_0382", Text = "I {#Emph}told {#Prev}him!" },
				{ Cue = "/VO/Prometheus_0383", Text = "I warned him..." },
				{ Cue = "/VO/Prometheus_0384", Text = "I'll handle this!" },
				{ Cue = "/VO/Prometheus_0385", Text = "We're all that's left." },
				{ Cue = "/VO/Prometheus_0386", Text = "Enough of him." },
				{ Cue = "/VO/Prometheus_0387", Text = "You and me, then." },
				{ Cue = "/VO/Prometheus_0388", Text = "And now for me." },
				{ Cue = "/VO/Prometheus_0390", Text = "Leaving so soon?" },
				{ Cue = "/VO/Prometheus_0391", Text = "{#Emph}Eh {#Prev}off he goes..." },
				{ Cue = "/VO/Prometheus_0392", Text = "Oh, blast." },
			},
		},

	},

}
WeaponSetData =
{
	HeraclesEMMeleeArc =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
			MaxPlayerDistance = 600,
			MapAggressor = "Heracles",
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					Data =
					{
						ProjectileName = "HeraclesEMArcRight",
					},

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathFalse = { "Enraged" },
						},
					},
				},
				{
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "HeraclesEMArcRight" },
							{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -60, OffsetDistance = 500, OffsetScaleY = 0.5, PauseDuration = 0.04 },
							--{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 500, OffsetScaleY = 0.5, PauseDuration = 0.02 },
							{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.52, PauseDuration = 0.04 },
							--{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 500, OffsetScaleY = 0.52, PauseDuration = 0.02 },
							{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 500, OffsetScaleY = 0.54 },
						},
					},

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathTrue = { "Enraged" },
						},
					},
				}
			},

			FireSelfVelocity = 1300,
			FireProjectileStartDelay = 0.09,

			PreAttackDuration = 0.62,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.1,
			FireDuration = 0.22,
			PostAttackDuration = 1.7,
			PostAttackMinWaitTime = 1.53,

			AttackDistance = 350,
			MoveWithinRange = true,
			PreAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmoteCharging",
			PreAttackAnimation = "Heracles_Combat_Swipe_Start",
			FireAnimation = "Heracles_Combat_Swipe_Fire",
			PostAttackAnimation = "Heracles_Combat_Swipe_End",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.1,
			StopBeforeFire = true,
			ExpireProjectilesOnHitStun = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heracles/EmoteAttacking" },
			},
		},
	},

	HeraclesEMMeleeArc_Passive =
	{
		InheritFrom = { "HeraclesEMMeleeArc" },

		Requirements =
		{
			MapAggressor = "Prometheus",
			RequiresAMapAggressor = true,
			MaxPlayerDistance = 9999,
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData = {},

			AttackSlots =
			{
				{ ProjectileName = "HeraclesEMArcRight" },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, BarrelLength = 300 }, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 0, OffsetScaleY = 0.54 },
			},

			MoveWithinRange = false,
			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,
		},
	},

	HeraclesEMLeap =
	{
		Requirements =
		{
			MinPlayerDistance = 500,
			MapAggressor = "Heracles",
		},

		AIData =
		{
			DeepInheritance = true,
			ConditionalData =
			{
				{
					Data =
					{
						ProjectileName = "HeraclesEMLeap",
					},

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathFalse = { "Enraged" },
						},
					},
				},
				{
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "HeraclesEMLeap" },
							{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { BarrelLength = 400, }, },
						},
					},

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathTrue = { "Enraged" },
						},
					},
				}
			},

			MoveWithinRange = true,
			StopMoveWithinRange = true,
			AttackDistance = 800,
			AttackDistanceScaleY = 0.6,
			LoSBuffer = 120,
			RequireUnitLoS = true,

			PreAttackAngleTowardTarget = false,
			AngleTowardsTargetWhileFiring = false,
			TrackTargetDuringCharge = false,

			PreAttackDuration = 0.0,
			FireDuration = 0.1,
			PostAttackDuration = 1.25,
			PostAttackMinWaitTime = 1.125,

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
					SuccessiveChanceToPlay = 0.35,
					Cooldowns =
					{
						{ Name = "HeraclesAnyQuipSpeech", Time = 10 },
					},

					{ Cue = "/VO/Heracles_0197", Text = "Fall!" },
					{ Cue = "/VO/Heracles_0200", Text = "Now!" },
					{ Cue = "/VO/Heracles_0201", Text = "{#Emph}Hrah!" },
					{ Cue = "/VO/Heracles_0202", Text = "Here!" },
					{ Cue = "/VO/Heracles_0205", Text = "Prepare!" },
					{ Cue = "/VO/Heracles_0674", Text = "Again!" },
					{ Cue = "/VO/Heracles_0676", Text = "{#Emph}Raah!" },
					{ Cue = "/VO/Heracles_0681", Text = "Come!" },
					{ Cue = "/VO/Heracles_0683", Text = "I'll crush you!" },
					{ Cue = "/VO/Heracles_0689", Text = "You're {#Emph}dead!" },
					{ Cue = "/VO/Heracles_0677", Text = "Next!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0675", Text = "You there!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0678", Text = "Now {#Emph}you!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0679", Text = "One by one!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0680", Text = "All of you!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0682", Text = "Fool!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0684", Text = "Pathetic wretch!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0685", Text = "You are next!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0686", Text = "Now for {#Emph}you!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0687", Text = "How about you?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0688", Text = "Weaklings, all of you!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0196", Text = "Die!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0198", Text = "You!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0199", Text = "You!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0203", Text = "Your turn!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Heracles_0204", Text = "Your turn!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "P_Boss01" },
							},
						},
					},
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

	HeraclesEMLeap_Passive =
	{
		--InheritFrom = { "HeraclesEMLeap" },

		Requirements =
		{
			MapAggressor = "Prometheus",
			RequiresAMapAggressor = true,
			MaxPlayerDistance = 9999,
			MinAttacksBetweenUse = 5,
		},

		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			AttackDistance = 9999,

			ProjectileName = "HeraclesEMLeapSlam",
			BarrelLength = 0,
			FireFromTarget = true,
			FireProjectileStartDelay = 0.1,
			
			PreAttackFunctionName = "ClearAllEffects",

			PreAttackDuration = 0.62,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.1,
			FireDuration = 1.1,
			PostAttackDuration = 2.5,
			PostAttackMinWaitTime = 2.25,

			FireSetZHeight = 1000,
			FireSetZDuration = 0.2,

			FireAlpha = 0.0,
			FireAlphaDuration = 0.2,
			PostAttackSetZHeight = 200,
			PostAttackSelfUpwardVelocity = -1000,
			PostAttackAlpha = 1.0,

			PostAttackTeleport = true,
			TeleportToTarget = true,
			CreateOwnTargetFromOriginalTarget = true,

			TrackTargetDuringFire = true,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,

			PreAttackAnimation = "Heracles_Combat_LeapExit",
			PostAttackAnimation = "Heracles_Combat_Leap_Fire2",
		},
	},


	HeraclesEMRoar =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			PreAttackAnimation = "Heracles_Combat_Roar",

			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmotePowerAttacking",
			FireFx = "EliteUnitStatus2",
			PostAttackEnemyDataOverrides =
			{
				Enraged = true,
			},

			PreAttackDuration = 0.8,
			FireDuration = 2.2,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		FireRadialBlur = { Distance = 1.3, Strength = 1.0, FXHoldTime = 2.5, FXInTime = 0.15, FXOutTime = 0.15 },
		FireScreenshake = { Distance = 5, Speed = 300, Duration = 0.7, FalloffSpeed = 1500 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},
	},

	HeraclesEMRoar_Dummy =
	{
		InheritFrom = { "HeraclesEMRoar", },
		AIData =
		{
			DeepInheritance = true,

			FireFx = "nil",
			PostAttackEnemyDataOverrides = {},
		},
	},


	HeraclesEMSpin =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "HeraclesEMSpin",

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathFalse = { "Enraged" },
						},
					},
				},
				{
					ProjectileName = "HeraclesEMSpinEnraged",

					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathTrue = { "Enraged" },
						},
					},
				}
			},

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 4.8,
						Modifier = 0.001,
					},
				},
			},
			ClearWeaponFireEffectsOnFireEnd = true,

			FireTicks = 12,
			FireInterval = 0.4,

			FireTickSelfVelocity = 550,

			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmoteCharging",

			PreAttackAnimation = "Heracles_Combat_Spin_Start",
			FireAnimation = "Heracles_Combat_Spin_FireLoop",
			PostAttackAnimation = "Heracles_Combat_Spin_End",

			TrackTargetDuringFire = true,
			FireRotationDampening = 0.06,
			PostAttackStop = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.0,
			PostAttackDuration = 1.85,
			PostAttackMinWaitTime = 1.665,

			AttackDistance = 800,
			MoveWithinRange = true,
			
			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},

	HeraclesEMSpinUltimate =
	{
		InheritFrom = { "HeraclesEMSpin" },

		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles = {},

			AttackSlots =
			{
				{ ProjectileName = "HeraclesEMSpinEnraged" },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 0, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 60, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 120, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 180, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 240, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
				{ ProjectileName = "HeraclesEMWave", AIDataOverrides = { FireFromTarget = true, }, OffsetAngle = 300, UseAttackerAngle = true, OffsetFromAttacker = true, OffsetDistance = 0, OffsetScaleY = 0.54 },
			},
			FireTicks = 1,

			PreAttackEndShake = false,
			MoveWithinRange = false,
			PreAttackDuration = 0.75,
			PreAttackAnimation = "Heracles_Combat_Spin_Start_Fast",
			RetreatBeforeAttack = false,
		},
	},


	HeraclesRetreatSpin =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 4.8,
						Modifier = 0.001,
					},
				},
			},
			ClearWeaponFireEffectsOnFireEnd = true,

			ProjectileName = "HeraclesEMSpin",

			FireSelfVelocity = 1100,
			FireSelfVelocityAngleOffset = 180,

			PreAttackSound = "/SFX/Enemy Sounds/Heracles/EmoteCharging",

			PreAttackAnimation = "Heracles_Combat_Spin_Start_Fast",
			FireAnimation = "Heracles_Combat_Spin_FireLoop",
			PostAttackAnimation = "Heracles_Combat_Spin_End",

			TrackTargetDuringFire = true,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			PreAttackDuration = 0.75,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.2,
			FireDuration = 0.4,
			PostAttackDuration = 1.85,
			PostAttackMinWaitTime = 1.665,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},

	HeraclesEMLeapSpinCombo =
	{
		Requirements =
		{
			MapAggressor = "Heracles",
			MinAttacksBetweenUse = 5,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
			ForceUseIfReady = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "HeraclesEMLeap", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.1 } },
			{ WeaponName = "HeraclesEMSpinUltimate", IgnoreRequirements = true, },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil

OverwriteTableKeys( EnemyData, UnitSetData.Heracles )