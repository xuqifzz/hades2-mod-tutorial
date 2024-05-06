UnitSetData.SirenDrummer =
{
	SirenDrummer =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		--Portrait = "Portrait_Scylla_Default_01",
		Groups = { "NPCs" },
		AnimOffsetZ = 260,
		ForceAllowRaiseDead = true,
		
		MaxHealth = 5950,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,
		EffectVfxOffsetZ = 60,
		SpeechCooldownTime = 11,

		Groups = { "GroundEnemies" },
		ClearChillOnDeath = true,

		SpawnAnimation = "Enemy_SirenDrummer_IdleA",

		Material = "Organic",
		--HealthBarTextId = "Cyclops_Full",
		HealthBarOffsetY = -205,
		IgnoreInvincibubbleOnHit = true,

		MusicStem = "Drums",
		MusicStemOff = true,

		OnDeathFunctionName = "SirenKillPresentation",
		OnDeathThreadedFunctionName = "RemoveScyllaFightSpotlight",

		DeathAnimation = "Enemy_SirenDrummer_Death",
		DeathSound = "/SFX/Enemy Sounds/Scylla/SirenDrumStemOffSFX",

		SpellSummonDataOverrides =
		{
			SkipAISetupOnActivate = false,

			WeaponOptions =
			{
				"SirenDrummerCircleCombo01", "SirenDrummerCircleCombo02", "SirenDrummerBeatOpener",
				"SirenDrummerBeatConeIn", "SirenDrummerBeatConeOut", "SirenDrummerBeatClawClose", "SirenDrummerBeatClawMid", "SirenDrummerBeatClawFar", "SirenDrummerBeatCoralClose", "SirenDrummerBeatCoralFar"
			},
		},
		SpellSummonSpawnOnId = 558524,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		WeaponOptions =
		{
			-- Arena Circle Weapons
			"SirenDrummerCircleCombo01",
			"SirenDrummerCircleCombo02",
			
			-- Basic Circle Weapons
			"SirenDrummerBeatConeIn",
			"SirenDrummerBeatConeOut",

			-- Multi Circle Weapons
			-- "SirenDrummerBeatClawClose",
			-- "SirenDrummerBeatClawFar",
			-- "SirenDrummerBeatCoralClose",
			-- "SirenDrummerBeatCoralFar",
		},
						
		--WeaponOptions = { "SirenDrummerBeatSweepMid", },

		--IdleAIAnimation = "Enemy_SirenDrummer_IncapacitateIntro",
		--IdleAIEndAnimation = "Enemy_SirenDrummer_IncapacitateReturnToIdle",
		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = false,
				MusicStemOff = true,
				TransitionSound = "/SFX/Enemy Sounds/Scylla/SirenDrumStemOffSFX",
				TransitionAnimation = "Enemy_SirenDrummer_IncapacitateIntro",
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
				},
				StageTransitionVoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						SuccessiveChanceToPlay = 0.75,
						ObjectType = "Scylla",
						Cooldowns =
						{
							{ Name = "ScyllaBandMemberKOSpeech", Time = 240 },
						},
						TriggerCooldowns = { "ScyllaSpokeRecently" },

						{ Cue = "/VO/Scylla_0156", Text = "Roxy, {#Emph}what?" },
						{ Cue = "/VO/Scylla_0157", Text = "Come {#Emph}on{#Prev}, Rox!" },
						{ Cue = "/VO/Scylla_0161", Text = "Our {#Emph}percussion!" },
						{ Cue = "/VO/Scylla_0162", Text = "The {#Emph}drums!" },
					},
					[2] = GlobalVoiceLines.ScyllaSirenKOReactionVoiceLines,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Enemy_SirenDrummer_IncapacitateReturnToIdle",
				NewVulnerability = true,
				WaitDuration = 2.2,
				EquipWeapons = { "SirenDrummerSpotlightPassive", "SirenDrummerSpotlightCombo",
								"SirenDrummerCircleCombo01", "SirenDrummerCircleCombo02", "SirenDrummerBeatOpener",
								"SirenDrummerBeatConeIn",	"SirenDrummerBeatConeOut", "SirenDrummerBeatClawClose", "SirenDrummerBeatClawMid", "SirenDrummerBeatClawFar", "SirenDrummerBeatCoralClose", "SirenDrummerBeatCoralFar" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},
		OnKillVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlayAll = 0.5,
				ObjectType = "Scylla",

				{ Cue = "/VO/Scylla_0130", Text = "{#Emph}Dammit{#Prev}, Roxy!" },
				{ Cue = "/VO/Scylla_0131", Text = "Roxy, {#Emph}no!" },
				{ Cue = "/VO/Scylla_0180", Text = "Roxy!!" },
				{ Cue = "/VO/Scylla_0181", Text = "{#Emph}Ngh, dammit{#Prev}, Roxy!" },
			},
			[2] = GlobalVoiceLines.ScyllaSirenDeathReactionVoiceLines,
		},		
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.SirenDrummer )