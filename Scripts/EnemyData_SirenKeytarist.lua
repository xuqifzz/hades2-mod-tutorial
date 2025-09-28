UnitSetData.SirenKeytarist =
{
	SirenKeytarist =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		--Portrait = "Portrait_Scylla_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		AnimOffsetZ = 260,
		MaxHealth = 5100,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,
		ForceAllowRaiseDead = true,
		UniqueRaise = true,
		SkipDisableAllyUnitsOnDeath = true,
		RunHistoryKilledByName = "Scylla",
		
		SpeechCooldownTime = 11,

		ClearChillOnDeath = true,

		Material = "Organic",
		--HealthBarTextId = "Cyclops_Full",
		HealthBarOffsetY = -175,
		IgnoreInvincibubbleOnHit = true,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		MusicStem = "Guitar",
		MusicStemOff = true,

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GrannyTexture = "GR2/SirensKeytaristEM_Color",
					GrannyAttachmentTexture = { MeshName = "SirensInstrumentKeytar_Mesh", GrannyTexture = "GR2/KeytarEM_Color", },
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 400,
								Window = 1.0,
								ComboBreakerCooldown = 15.0,
								ForcedWeaponInterrupt = "SirenKeytaristDiveComboBreaker",
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
		},
		BossDifficultyShrineRequriedCount = 2,

		OnDeathFunctionName = "SirenKillPresentation",
		OnDeathThreadedFunctionName = "RemoveScyllaFightSpotlight",

		ManualDeathAnimation = false,
		DeathAnimation = "Enemy_SirenKeytar_Death",
		DeathSound = "/SFX/Enemy Sounds/Scylla/SirenKeytarStemOffSFX",

		SpellSummonDataOverrides =
		{
			SkipAISetupOnActivate = false,

			WeaponOptions ={ "SirenKeytaristBounceBalls" },
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
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			RetreatAfterAttack = true,
			RetreatGameStateRequirements =
			{
				{
					Path = { "MapState", "IdleUnits" },
					UseLength = true,
					Comparison = "<",
					Value = 2,
				},
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				}
			},
			
			RetreatBufferDistance = 900,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointFromSelf = true,
			RetreatToSpawnPointType = "EnemyPoint",
			RetreatAfterAttackEndWait = 2.75,
			RetreatToSpawnPointRadiusMin = 900,
			RetreatToSpawnPointRadius = 2000,
		},

		--WeaponOptions = { "SirenKeytaristBounceBalls" },
		WeaponOptions = { "SirenKeytaristPowerslide", "SirenKeytaristPowerslide", "SirenKeytaristShred", "SirenKeytaristDive", "SirenKeytaristBounceBalls" },

		--IdleAIAnimation = "Enemy_SirenKeytar_IncapacitateIntro",
		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons = { "SirenKeytaristPowerslide", "SirenKeytaristPowerslide", "SirenKeytaristShred", "SirenKeytaristDive", "SirenKeytaristBounceBalls" },
				},
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
				TransitionSound = "/SFX/Enemy Sounds/Scylla/SirenKeytarStemOffSFX",
				TransitionAnimation = "Enemy_SirenKeytar_IncapacitateIntro",
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

						{ Cue = "/VO/Scylla_0154", Text = "Jetty, {#Emph}hey!" },
						{ Cue = "/VO/Scylla_0155", Text = "What, {#Emph}Jetty!" },
						{ Cue = "/VO/Scylla_0159", Text = "Our {#Emph}strings!" },
						{ Cue = "/VO/Scylla_0386", Text = "Jetty...!" },
						{ Cue = "/VO/Scylla_0387", Text = "{#Emph}Again{#Prev}, Jetty?!" },
						{ Cue = "/VO/Scylla_0392", Text = "Our melody!" },
					},
					{ GlobalVoiceLines = "ScyllaSirenKOReactionVoiceLines" },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Enemy_SirenKeytar_IncapacitateReturnToIdle",
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
				WaitDuration = 2.2,
				EquipWeapons = { "SirenKeytaristSpotlightPassive", "SirenKeytaristSpotlightCombo", "SirenKeytaristPowerslide", "SirenKeytaristShred", "SirenKeytaristBounceBalls", "SirenKeytaristDive" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons = { "SirenKeytaristSpotlightPassive", "SirenKeytaristSpotlightCombo", "SirenKeytaristPowerslide", "SirenKeytaristShred", "SirenKeytaristBounceBalls", "SirenKeytaristDive" },
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

				{ Cue = "/VO/Scylla_0089", Text = "Jetty?!" },
				{ Cue = "/VO/Scylla_0132", Text = "What happened to Jetty?!", PlayFirst = true },
				{ Cue = "/VO/Scylla_0133", Text = "Come on, Jetty, {#Emph}get up!" },
				{ Cue = "/VO/Scylla_0179", Text = "Jetty, not {#Emph}again!" },
				{ Cue = "/VO/Scylla_0182", Text = "Jetty, you {#Emph}slacker!" },
			},
			[2] = { GlobalVoiceLines = "ScyllaSirenDeathReactionVoiceLines" },
		},

		Using = { GrannyModel = "SirensInstrumentKeytar_Mesh"},
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.SirenKeytarist )