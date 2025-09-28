UnitSetData.SirenDrummer =
{
	SirenDrummer =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		--Portrait = "Portrait_Scylla_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		AnimOffsetZ = 260,
		ForceAllowRaiseDead = true,
		UniqueRaise = true,
		ImmobileRaise = true,
		SkipDisableAllyUnitsOnDeath = true,
		RunHistoryKilledByName = "Scylla",
		
		MaxHealth = 7100,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,
		EffectVfxOffsetZ = 60,
		SpeechCooldownTime = 11,

		ClearChillOnDeath = true,

		SpawnAnimation = "Enemy_SirenDrummer_IdleA",

		Material = "Organic",
		--HealthBarTextId = "Cyclops_Full",
		HealthBarOffsetY = -205,
		IgnoreInvincibubbleOnHit = true,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		MusicStem = "Drums",
		MusicStemOff = true,

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GrannyTexture = "GR2/SirenDrummerEM_Color",
					GrannyAttachmentTexture = { MeshName = "SirensInstrumentDrums_Mesh", GrannyTexture = "GR2/DrumsEM_Color", },
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 590,
								Window = 1.0,
								ComboBreakerCooldown = 10.0,
								ForcedWeaponInterrupt = "SirenDrummerCircle_EM",
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
							Value = 2,
						},
					},
				},
			},
			{
				FunctionName = "PickSpawnAngle",
			},
		},
		BossDifficultyShrineRequiredCount = 2,

		OnDeathFunctionName = "SirenKillPresentation",
		OnDeathThreadedFunctionName = "RemoveScyllaFightSpotlight",

		ManualDeathAnimation = false,
		DeathAnimation = "Enemy_SirenDrummer_Death",
		DeathSound = "/SFX/Enemy Sounds/Scylla/SirenDrumStemOffSFX",

		SpellSummonDataOverrides =
		{
			SkipAISetupOnActivate = false,

			WeaponOptions =
			{
				"SirenDrummerBeatOpener",
				"SirenDrummerBeatConeIn", "SirenDrummerBeatConeOut", "SirenDrummerBeatClawClose", "SirenDrummerBeatClawMid", "SirenDrummerBeatClawFar", "SirenDrummerBeatCoralClose", "SirenDrummerBeatCoralFar"
			},
			AIStages =
			{
				{
					RandomAIFunctionNames = { "AttackerAI" },
					AIData =
					{
						AIEndHealthThreshold = 0.0,
					},
				},
			},
			SpawnAnglePerMap =
			{
				G_Boss01 = 310,
				G_Boss02 = 228,
			},
		},
		SpellSummonSpawnOnIdPerMap =
		{
			G_Boss01 = 558524,
			G_Boss02 = 569054,
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
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
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					AIDataOverrides =
					{
						PreAttackThreadedFunctionName = "FireFloodTraps",
						PreAttackThreadedFunctionArgs =
						{
							MaxPlayerDistance = 500,
						}
					},
					DataOverrides =
					{
						ForcedNextWeapon = "SirenDrummerBeatConeOut_EM",
					},
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"SirenDrummerCircleCombo01",
						"SirenDrummerCircleCombo02",

						"SirenDrummerBeatConeIn_EM",
						"SirenDrummerBeatConeOut_EM",
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- Wait for all incapacitated
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
						{ Cue = "/VO/Scylla_0388", Text = "Roxy...!" },
						{ Cue = "/VO/Scylla_0389", Text = "{#Emph}Really{#Prev}, Roxy?" },
						{ Cue = "/VO/Scylla_0390", Text = "Our rhythm!" },
						{ Cue = "/VO/Scylla_0391", Text = "Our beat!" },
					},
					{ GlobalVoiceLines = "ScyllaSirenKOReactionVoiceLines" },
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Enemy_SirenDrummer_IncapacitateReturnToIdle",
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
				WaitDuration = 2.2,
				EMStageDataOverrides =
				{
					EquipWeapons =
					{
						-- If spotlighted
						"SirenDrummerSpotlightPassive",
						"SirenDrummerSpotlightCombo",

						"SirenDrummerCircleCombo01",
						"SirenDrummerCircleCombo02",
						"SirenDrummerBeatOpener",
						"SirenDrummerBeatConeIn_EM",
						"SirenDrummerBeatConeOut_EM",
						"SirenDrummerBeatClawClose",
						"SirenDrummerBeatClawMid",
						"SirenDrummerBeatClawFar",
						"SirenDrummerBeatCoralClose",
						"SirenDrummerBeatCoralFar"
					},
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "SirenDrummerSpotlightPassive", "SirenDrummerSpotlightCombo", -- If spotlighted
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
				Cooldowns =
				{
					{ Name = "ScyllaSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/Scylla_0130", Text = "{#Emph}Dammit{#Prev}, Roxy!" },
				{ Cue = "/VO/Scylla_0131", Text = "Roxy, {#Emph}no!" },
				{ Cue = "/VO/Scylla_0180", Text = "Roxy!!" },
				{ Cue = "/VO/Scylla_0181", Text = "{#Emph}Ngh, dammit{#Prev}, Roxy!" },
			},
			[2] = { GlobalVoiceLines = "ScyllaSirenDeathReactionVoiceLines" },
		},		
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.SirenDrummer )