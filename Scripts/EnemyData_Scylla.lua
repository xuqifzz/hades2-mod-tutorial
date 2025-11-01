UnitSetData.Scylla =
{
	Scylla =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Scylla_Default_01",
		EndTextLinesThreadedFunctionName = "ResetScyllaMusicStem",
		EndTextLinesThreadedFunctionArgs =
		{
			Delay = 2,
			Duration = 0.25,
		},
		StartedVoiceLinesFunctionName = "GenericPresentation",
		StartedVoiceLinesFunctionArgs =
		{
			SetSoundCueValues =
			{
				{
					Name = "Vocals",
					Value = 0.0,
					AudioStateId = "MusicId",
					Duration = 0.1,
				}
			}
		},
		FinishedVoiceLinesFunctionName = "ResetScyllaMusicStem",
		FinishedVoiceLinesFunctionArgs =
		{
			Duration = 0.25,
		},
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ScyllaVoice,
		AnimOffsetZ = -80,
		MaxHealth = 7750,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -260,
		HealthBarOffsetY = -240,
		SpeakerName = "Scylla",
		LoadPackages = { "Scylla", },
		Material = "Organic",
		HealthBarTextId = "Scylla_Full",

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					GrannyTexture = "GR2/ScyllaEM_Color",
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 620,
								Window = 1.0,
								MaxComboBreakers = 1,
								ForcedWeaponInterrupt = "ScyllaClamUp3",
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
				FunctionName = "GenericPresentation",
				Args =
				{
					OverwriteSourceKeys =
					{
						PortraitSwapMap =
						{
							Portrait_Scylla_Default_01 = "Portrait_Scylla_Default_02",
							Portrait_Scylla_Default_01_Exit = "Portrait_Scylla_Default_02_Exit",
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
				}
			}
		},
		BossDifficultyShrineRequiredCount = 2,

		MusicStem = "Vocals",
		MusicStemOff = true,

		InvulnerableFx = "Invincibubble_Scylla",
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		InvulnerableHitFlash = true,
		InvulnerableBlockHint = true,
		OnHitFunctionName = "CheckUnitInvulnerableHit",

		DeathAnimation = "Enemy_Scylla_Death",
		DeathAngle = 270,
		DeathPanOffsetY = -130,
		
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		SpeechCooldownTime = 11,

		ClearChillOnDeath = true,
		GroupHealthBarOwner = true,

		OnDeathFunctionName = "ScyllaKillPresentation",
		OnDeathFunctionArgs = { Message = "SirensDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", EndMusicEarly = true, BatsAfterDeath = false, FlashRed = true, FlashDuration = 0.45, AddInterBiomeTimerBlock = true },

		PreBossAISetupFunctionName = "ScyllaActivatePresentation",

		DefaultAIData =
		{
			RetreatBufferDistance = 900,
			RetreatToSpawnPointType = "EnemyPoint",
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
		},
		WeaponOptions = { "ScyllaBelt", "ScyllaClamUp", "ScyllaSpin", "ScyllaWhip", "ScyllaNotes" }, 

		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons = { "ScyllaBelt", "ScyllaClamUp3", "ScyllaSpin", "ScyllaWhip", "ScyllaNotes" },
					DataOverrides =
					{
						ForcedNextWeapon = "ScyllaClamUp2",
						ComboBreakersUsed = 0,
					},
					--[[ThreadedEvents =
					{
						{ FunctionName = "CharybdisScyllaFightGroupAI",
							Args =
							{
								AttackRate = 3.0, AttackTimingVarianceMin = 1.0, AttackTimingVarianceMax = 1.0,
								TentacleIdsOrdered = { [1] = 737570, [2] = 737571, [3] = 737572, [4] = 737568, [5] = 737569, [6] = 737573, }
							} },
					}]]
				},
				DataOverrides =
				{
					ForcedNextWeapon = "ScyllaBelt",
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
				UnequipAllWeapons = true,
				TransitionAnimation = "Enemy_Scylla_ClamDefenseIntro",
				-- MusicStemOff = true,
				LowPassOn = true,
				AIData =
				{
					AIEndGroupHealthThreshold = 0.5,
					--PreAttackLowPass = true,
				},
				StageTransitionVoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlayAll = 0.5,
					ObjectType = "Scylla",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Kills" },
							NotHasAll = { "SirenKeytarist", "SirenDrummer" },
						},
					},
					Cooldowns =
					{
						{ Name = "ScyllaBandMemberKOSpeech", Time = 240 },
					},
					TriggerCooldowns = { "ScyllaSpokeRecently" },

					{ Cue = "/VO/Scylla_0101", Text = "{#Emph}Ow!!" },
					{ Cue = "/VO/Scylla_0102", Text = "{#Emph}Ow!" },
					{ Cue = "/VO/Scylla_0103", Text = "{#Emph}Hey!" },
					{ Cue = "/VO/Scylla_0104", Text = "{#Emph}Heeey!" },
					{ Cue = "/VO/Scylla_0105", Text = "{#Emph}Nngh!" },
					{ Cue = "/VO/Scylla_0106", Text = "{#Emph}Eh!" },
					{ Cue = "/VO/Scylla_0107", Text = "Give it to me!", PlayFirst = true },
					{ Cue = "/VO/Scylla_0108", Text = "Hit me!" },
					{ Cue = "/VO/Scylla_0109", Text = "Hit me one time!" },
					{ Cue = "/VO/Scylla_0110", Text = "Oh!" },
					{ Cue = "/VO/Scylla_0111", Text = "{#Emph}Rngh!" },
					{ Cue = "/VO/Scylla_0112", Text = "{#Emph}Hey...!" },
					{ Cue = "/VO/Scylla_0113", Text = "{#Emph}Nngh!" },
					{ Cue = "/VO/Scylla_0114", Text = "You!" },
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
				TransitionAnimation = "Enemy_Scylla_ClamDefenseReturnToIdle",
				WaitDuration = 1.5,
				LowPassOff = true,
				AIData =
				{
					AIEndHealthThreshold = 0.2,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ScyllaBelt", "ScyllaWhip", "ScyllaClamUp", "ScyllaNotes", "ScyllaSpotlightPassive", "ScyllaSpotlightCombo",  },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons = { "ScyllaBelt", "ScyllaWhip", "ScyllaClamUp3", "ScyllaNotes", "ScyllaSpotlightPassive", "ScyllaSpotlightCombo",  },
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
				ThreadedEvents =
				{
					{ FunctionName = "ApplyScyllaFightSpotlight", GameStateRequirements = { },
						Args =
						{
							Flags =
							{
								Scylla =
								{
									FlagName = "ScyllaBoost", Name = "Scylla",
									ApplyEffect =
									{
										EffectName = "ScyllaBoost",
										DataProperties =
										{
											Type = "Speed",
											Duration = 9999,
											Modifier = 1.1,
										}
									},
									SoloMusicFunction = "SoloSirenVocalist",
									SoloVoiceLines =
									{
										{
											RandomRemaining = true,
											BreakIfPlayed = true,
											PreLineWait = 0.25,
											SuccessiveChanceToPlayAll = 0.33,
											ObjectType = "Scylla",
											TriggerCooldowns = { "ScyllaSpokeRecently" },
											{ Cue = "/VO/Scylla_0079", Text = "{#Emph}Wow!" },
											{ Cue = "/VO/Scylla_0080", Text = "{#Emph}Rah!" },
											{ Cue = "/VO/Scylla_0081", Text = "{#Emph}Rah!" },
											{ Cue = "/VO/Scylla_0082", Text = "{#Emph}Everybody!" },
											{ Cue = "/VO/Scylla_0083", Text = "Everybody now!" },
											{ Cue = "/VO/Scylla_0098", Text = "{#Emph}Huahaha!" },
											{ Cue = "/VO/Scylla_0100", Text = "{#Emph}Huh!" },
											{ Cue = "/VO/Scylla_0236", Text = "I... am... {#Emph}Scylla!!", PlayFirst = true },
											{ Cue = "/VO/Scylla_0237", Text = "{#Emph}Come on{#Prev}, everybody!" },
											{ Cue = "/VO/Scylla_0238", Text = "She's all mine..." },
											{ Cue = "/VO/Scylla_0239", Text = "Who, me?" },
											{ Cue = "/VO/Scylla_0240", Text = "Oh, {#Emph}wow!" },
											{ Cue = "/VO/Scylla_0241", Text = "My big break...!" },
										},
										{ GlobalVoiceLines = "ScyllaSirenRallyVoiceLines" },
									},
								},
								Drummer =
								{
									FlagName = "DrummerBoost", Name = "SirenDrummer", SoloMusicFunction = "SoloSirenDrummer",
									SoloVoiceLines =
									{
										{
											RandomRemaining = true,
											BreakIfPlayed = true,
											PreLineWait = 0.25,
											SuccessiveChanceToPlayAll = 0.5,
											ObjectType = "Scylla",
											TriggerCooldowns = { "ScyllaSpokeRecently" },

											{ Cue = "/VO/Scylla_0084", Text = "{#Emph}Roxy!" },
											{ Cue = "/VO/Scylla_0085", Text = "Roxy?" },
											{ Cue = "/VO/Scylla_0086", Text = "{#Emph}All you{#Prev}, Roxy!" },
											{ Cue = "/VO/Scylla_0087", Text = "{#Emph}Hit it{#Prev}, Rox!" },
											{ Cue = "/VO/Scylla_0148", Text = "All right, {#Emph}Roxy!" },
											{ Cue = "/VO/Scylla_0149", Text = "{#Emph}Roxy{#Prev}, everybody!" },
											{ Cue = "/VO/Scylla_0150", Text = "Roxy, you're up!" },
											{ Cue = "/VO/Scylla_0151", Text = "Here comes {#Emph}Roxy!" },
											{ Cue = "/VO/Scylla_0152", Text = "Give it up for {#Emph}Roxy!" },
											{ Cue = "/VO/Scylla_0153", Text = "This is {#Emph}Roxy!", PlayFirst = true },
											{ Cue = "/VO/Scylla_0232", Text = "Let's hear it for Roxy!" },
											{ Cue = "/VO/Scylla_0233", Text = "Roxy, {#Emph}light it up!" },
											{ Cue = "/VO/Scylla_0234", Text = "Make waves, Roxy!" },
											{ Cue = "/VO/Scylla_0235", Text = "Roxy, {#Emph}go all out!" },
										},
										{ GlobalVoiceLines = "ScyllaSirenRallyVoiceLines" },
									},
								},
								Keytarist =
								{
									FlagName = "KeytaristBoost", Name = "SirenKeytarist", SoloMusicFunction = "SoloSirenKeytarist",
									SoloVoiceLines =
									{
										{
											RandomRemaining = true,
											BreakIfPlayed = true,
											PreLineWait = 0.25,
											SuccessiveChanceToPlayAll = 0.5,
											ObjectType = "Scylla",
											TriggerCooldowns = { "ScyllaSpokeRecently" },

											{ Cue = "/VO/Scylla_0088", Text = "Jetty!" },
											{ Cue = "/VO/Scylla_0090", Text = "{#Emph}Go{#Prev}, Jetty!" },
											{ Cue = "/VO/Scylla_0091", Text = "{#Emph}Do it{#Prev}, Jetty!" },
											{ Cue = "/VO/Scylla_0142", Text = "Jetty, everybody!" },
											{ Cue = "/VO/Scylla_0143", Text = "Jetty, {#Emph}make it happen!" },
											{ Cue = "/VO/Scylla_0144", Text = "{#Emph}Kill it{#Prev}, Jetty!" },
											{ Cue = "/VO/Scylla_0145", Text = "Jetty, {#Emph}go!", PlayFirst = true },
											{ Cue = "/VO/Scylla_0146", Text = "Slay 'em, Jetty!" },
											{ Cue = "/VO/Scylla_0147", Text = "Give it up for {#Emph}Jetty!" },
											{ Cue = "/VO/Scylla_0228", Text = "Let's hear it for {#Emph}Jetty!" },
											{ Cue = "/VO/Scylla_0229", Text = "Jetty, she's {#Emph}all yours!" },
											{ Cue = "/VO/Scylla_0230", Text = "Jetty, {#Emph}go for it!" },
											{ Cue = "/VO/Scylla_0231", Text = "{#Emph}Shredding time!" },
										},
										{ GlobalVoiceLines = "ScyllaSirenRallyVoiceLines" },
									},
								},
								Charybdis =
								{
									FlagName = "CharybdisBoost", Name = "Charybdis_ScyllaFight", SoloMusicFunction = "SoloSirenVocalist", ZoomFraction = 0.5,
									UnequipWeapons = { "CharybdisSpitScylla", "CharybdisWait" },

									SoloVoiceLines =
									{
										{
											RandomRemaining = true,
											BreakIfPlayed = true,
											PreLineWait = 0.25,
											SuccessiveChanceToPlayAll = 0.5,
											ObjectType = "Scylla",
											TriggerCooldowns = { "ScyllaSpokeRecently" },

											{ Cue = "/VO/Scylla_0370", Text = "{#Emph}Charybdis{#Prev}, everybody!" },
											{ Cue = "/VO/Scylla_0371", Text = "Let's hear it for Charybdis!" },
											{ Cue = "/VO/Scylla_0372", Text = "Give it up for Charybdis!" },
											{ Cue = "/VO/Scylla_0373", Text = "Charybdis, {#Emph}eat {#Prev}'em up!" },
											{ Cue = "/VO/Scylla_0374", Text = "Go, Charybdis!" },
											{ Cue = "/VO/Scylla_0375", Text = "Charybdis, {#Emph}knock 'em dead!" },
										},
										{ GlobalVoiceLines = "ScyllaSirenRallyVoiceLines" },
									},
								},
							}
						}
					},
				}
			},
			-- Wait for all dead
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = false,
				UnequipAllWeapons = true,
				TransitionAnimation = "Enemy_Scylla_ClamDefenseIntro",
				LowPassOn = true,
				AIData =
				{
					AIEndLastAlive = true,
					--PreAttackLowPass = true,
				},
				ThreadedEvents =
				{
					{ FunctionName = "RemoveScyllaFightSpotlight" }
				},
			},
			-- Phase 3 Final Stand
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					EquipWeapons = { "ScyllaHeadbangFinisher2" },
					DataOverrides =
					{
						ComboBreakersUsed = 1,
					},
				},
				TransitionFunction = "BossStageTransition",
				ThreadedEvents =
				{
					{
						FunctionName = "ScyllaFinalStandPresentation"
					}
				},
				WaitDuration = 0.0,
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
				TransitionAnimation = "Enemy_Scylla_ClamDefenseReturnToIdle",
				MusicStemOn = true,
				LowPassOff = true,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
					TargetMusicStemVolume = 1.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ScyllaHeadbangFinisher", "ScyllaHeadbangFinisherHold" },
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.15,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Kills" },
					NotHasAll = { "SirenKeytarist", "SirenDrummer" },
				},
			},
			Cooldowns =
			{
				{ Name = "ScyllaSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Scylla_0092", Text = "{#Emph}Yeah!" },
			{ Cue = "/VO/Scylla_0093", Text = "{#Emph}Ooh!" },
			{ Cue = "/VO/Scylla_0094", Text = "{#Emph}Woo!" },
			{ Cue = "/VO/Scylla_0095", Text = "Gotcha!" },
			{ Cue = "/VO/Scylla_0096", Text = "Tasty!", PlayFirst = true },
			{ Cue = "/VO/Scylla_0097", Text = "How's that?" },
			{ Cue = "/VO/Scylla_0098", Text = "{#Emph}Hahaha!" },
			{ Cue = "/VO/Scylla_0098", Text = "{#Emph}Huahaha!" },
			{ Cue = "/VO/Scylla_0099", Text = "Got 'er!" },
			{ Cue = "/VO/Scylla_0100", Text = "{#Emph}Huh!" },
			{ Cue = "/VO/Scylla_0075", Text = "Hit it!" },
			{ Cue = "/VO/Scylla_0076", Text = "Here!" },
			{ Cue = "/VO/Scylla_0077", Text = "{#Emph}Boom!" },
			{ Cue = "/VO/Scylla_0078", Text = "Ba-{#Emph}bam!" },
			{ Cue = "/VO/Scylla_0079", Text = "{#Emph}Wow!" },
			{ Cue = "/VO/Scylla_0080", Text = "{#Emph}Rah!" },
			{ Cue = "/VO/Scylla_0081", Text = "{#Emph}Rah!" },
			{ Cue = "/VO/Scylla_0082", Text = "{#Emph}Everybody!" },
			{ Cue = "/VO/Scylla_0083", Text = "Everybody now!" },
		},
		LastStandReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Scylla" },
						Comparison = ">=",
						Value = 0.2,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Kills" },
						NotHasAll = { "SirenKeytarist", "SirenDrummer" },
					},
				},
				Cooldowns =
				{
					{ Name = "ScyllaSpokeRecently", Time = 8 },
					{ Name = "ScyllaLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Scylla_0115", Text = "{#Emph}Wha?", PlayFirst = true },
				{ Cue = "/VO/Scylla_0116", Text = "How—?" },
				{ Cue = "/VO/Scylla_0117", Text = "Drown..." },
				{ Cue = "/VO/Scylla_0118", Text = "{#Emph}Hoh..." },
			},
		},
		BlockDeathReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Kills" },
						NotHasAll = { "SirenKeytarist", "SirenDrummer" },
					},
				},
				Cooldowns =
				{
					{ Name = "ScyllaSpokeRecently", Time = 8 },
				},

				-- { Cue = "/VO/Hecate_0505", Text = "Time's up." },
			},
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.2,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Kills" },
					NotHasAll = { "SirenKeytarist", "SirenDrummer" },
				},
			},
			Cooldowns =
			{
				{ Name = "ScyllaSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Scylla_0119", Text = "Uh-{#Emph}uh!", PlayFirst = true },
			{ Cue = "/VO/Scylla_0120", Text = "Nuh-{#Emph}uh!" },
			{ Cue = "/VO/Scylla_0121", Text = "Don't think so!" },
			{ Cue = "/VO/Scylla_0122", Text = "Sorry!" },
		},
		ResistedVoiceLines =
		{
			--[[
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.05,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Kills" },
					NotHasAll = { "SirenKeytarist", "SirenDrummer" },
				},
			},
			Cooldowns =
			{
				{ Name = "ScyllaSpokeRecently", Time = 3 },
			},

			{ Cue = "/VO/Scylla_0119", Text = "Uh-{#Emph}uh!", PlayFirst = true },
			{ Cue = "/VO/Scylla_0120", Text = "Nuh-{#Emph}uh!" },
			{ Cue = "/VO/Scylla_0121", Text = "Don't think so!" },
			{ Cue = "/VO/Scylla_0122", Text = "Sorry!" },
			]]--
		},

		--[[ handled in DeathReturnVoiceLines
		CauseOfDeathVoiceLines =
		{
		},
		]]--

		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.05,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Kills" },
					NotHasAll = { "SirenKeytarist", "SirenDrummer" },
				},
			},
			Cooldowns =
			{
				{ Name = "ScyllaSpokeRecently", Time = 25 },
			},				
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.05,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Kills" },
					NotHasAll = { "SirenKeytarist", "SirenDrummer" },
				},
			},
			Cooldowns =
			{
				{ Name = "ScyllaSpokeRecently", Time = 25 },
			},
			PreLineWait = 0.35,
		},

		DeathSound = "/SFX/StabSplatterEndSequence",
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Scylla_01", SubtitleColor = Color.ScyllaVoice },

				{ Cue = "/VO/Scylla_0123", Text = "{#Emph}Ungh{#Prev}, how can this be?!", PlayFirst = true },
				{ Cue = "/VO/Scylla_0124", Text = "{#Emph}Augh{#Prev}, our... show...!" },
				{ Cue = "/VO/Scylla_0125", Text = "{#Emph}Nngh{#Prev}, you ungrateful—!" },
				{ Cue = "/VO/Scylla_0126", Text = "{#Emph}Gaah{#Prev}, come... back...!" },
				{ Cue = "/VO/Scylla_0127", Text = "{#Emph}Urgh{#Prev}, don't... go...!" },
				{ Cue = "/VO/Scylla_0128", Text = "Show... must... {#Emph}gaaahh..." },
				{ Cue = "/VO/Scylla_0129", Text = "No, why {#Emph}me?!" },
				{ Cue = "/VO/Scylla_0254", Text = "You're... no... fan..." },
				{ Cue = "/VO/Scylla_0255", Text = "But did... you like... the... song...?" },
				{ Cue = "/VO/Scylla_0258", Text = "Thanks... everybody... {#Emph}guhh..." },
				{ Cue = "/VO/Scylla_0260", Text = "That's... our... show..." },
				{ Cue = "/VO/Scylla_0261", Text = "{#Emph}Tsch{#Prev}... why... you..." },
				{ Cue = "/VO/Scylla_0262", Text = "We'll have... other... shows..." },
				{ Cue = "/VO/Scylla_0263", Text = "Did you... enjoy... the show...?" },
				{ Cue = "/VO/Scylla_0412", Text = "We're Scylla... and the... {#Emph}guh..." },
				{ Cue = "/VO/Scylla_0413", Text = "But we're just... getting... started..." },
				{ Cue = "/VO/Scylla_0414", Text = "Tell all... your friends... about us..." },
				{ Cue = "/VO/Scylla_0415", Text = "Leave us a good... review..." },
				{ Cue = "/VO/Scylla_0417", Text = "That was... our set... tonight..." },
				{ Cue = "/VO/Scylla_0418", Text = "That's all the... time... we have..." },
				{ Cue = "/VO/Scylla_0419", Text = "{#Emph}Guh... {#Prev}I'll be in my shell...!" },
				{ Cue = "/VO/Scylla_0416", Text = "Not even... with... Charybdis...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Scylla_0259", Text = "Thank you... Oceanus...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0136" }
						},
					},
				},
				{ Cue = "/VO/Scylla_0256", Text = "{!Icons.Music} {#Emph}I'm... gonna... claw... {!Icons.Music}",
					GameStateRequirements = 
					{
						{
							Path = { "AudioState", "MusicName" },
							IsAny = { "/Music/IrisMusicScylla2_MC" },
						},
					},
				},
				{ Cue = "/VO/Scylla_0257", Text = "{!Icons.Music} {#Emph}Tonight you're gonna... drown... {!Icons.Music}",
					GameStateRequirements = 
					{
						{
							Path = { "AudioState", "MusicName" },
							IsAny = { "/Music/IrisMusicScylla1_MC" },
						},
					},
				},
			},
		},

		BossKillVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			{ GlobalVoiceLines = "SeleneVictoryVoiceLines" },
			{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
			{
				PlayOnce = true,
				PlayOnceContext = "ScyllaBalladFirstResponseVO",
				BreakIfPlayed = true,
				PreLineWait = 7.2,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla4_MC" },
					},
				},

				{ Cue = "/VO/MelinoeField_4310", Text = "...That was an odd song." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 7.2,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1098", Text = "That's quite enough of {#Emph}them.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1099", Text = "Blasted catchy song..." },
				{ Cue = "/VO/Melinoe_1100", Text = "Show's over." },
				{ Cue = "/VO/Melinoe_1101", Text = "That was awkward..." },
				{ Cue = "/VO/Melinoe_1102", Text = "Finally..." },
				{ Cue = "/VO/Melinoe_1103", Text = "They just won't shut up..." },
				{ Cue = "/VO/MelinoeField_0098", Text = "Peace and quiet." },
				{ Cue = "/VO/MelinoeField_0099", Text = "...I hate her.", PreLineWait = 7.5 },
				{ Cue = "/VO/MelinoeField_0100", Text = "Keep practicing!" },
				{ Cue = "/VO/MelinoeField_0101", Text = "Sing about {#Emph}that..." },
				{ Cue = "/VO/MelinoeField_4310", Text = "...That was an odd song.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4310" }
						},
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4310" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0102", Text = "That's for last night.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "PrevRun", "RoomsEntered" },
							HasAny = { "G_Boss01", "G_Boss02" },
						},
						{
							PathFalse = { "PrevRun", "RoomsEntered", "G_PostBoss01", },
						},
					},
				},
			},
		},

		BossIntroTextLineSets =
		{
			ScyllaFirstMeeting =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0002", Speaker = "NPC_Scylla_Unnamed_01",
					Emote = "PortraitEmoteCheerful",
					Text = "Ohh, {#Emph}hohoho{#Prev}, no way! {#Emph}No way. {#Prev}Lookit, gals, a {#Emph}lady! {#Prev}Ladies never come to see our shows, you must be different, what's your name? Oh, make yourself comfy, we're just about to start, aren't we, gals?" },
				{ Cue = "/VO/Melinoe_0498", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...Sirens. I should have known you were the source of all that singing. Slinked down into the Underworld, have you?" },
				{ Cue = "/VO/Scylla_0003",
					Emote = "PortraitEmoteSparkly",
					Text = "It's the perfect pressure down here! Beats the pressure trying to make art while all our fans are watching, begging, {#Emph}Scylla, where's your next song?!" },
				{ Cue = "/VO/Melinoe_0499", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't you drown your so-called fans to death? Have you even got any left?" },
				{ Cue = "/VO/Scylla_0004",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Don't {#Emph}ever {#Prev}say such things about our fans! {#Prev}Oh hey gals...? What say we give her the {#Emph}old song and dance?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla3_MC" },
					},
				},
				{ Cue = "/VO/Scylla_0279",
					Emote = "PortraitEmoteSparkly",
					PortraitExitAnimation = "Portrait_Scylla_Default_01_Exit",
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "CharybdisRevealPresentation",
					Text = "Soak it up, lady! One of our proud sponsors made all our dreams come true: a {#Emph}brand-new {#Prev}stage, {#Emph}and{#Prev}... a collaboration with one of the {#Emph}biggest {#Prev}names this side of the sea!" },
				{ Cue = "/VO/MelinoeField_3538", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Charybdis, here with you...? This is no sponsor's doing but the will of Night. As fear spreads, so do these manifestations of nightmares... my own apparently." },
				{ Cue = "/VO/Scylla_0280",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Bad-mouth our sponsor all you like, but they got taste, and you do not! We're debuting our latest single thanks to them, and there's nothing you can do to stop it...! At least not the first part." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Scylla_0282",
					Text = "Come to heckle us some more, lady? Well it won't {#Emph}work! {#Prev}No matter what you do, this crowd thinks it's all part of the act. They're not just here for the music, but the {#Emph}full experience!" },
				{ Cue = "/VO/MelinoeField_3539", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And watching you and your band get trounced repeatedly is the experience you're seeking to provide? You artists truly do make sacrifices for your craft." },
				{ Cue = "/VO/Scylla_0283",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "That's {#Emph}right! {#Prev}I've given {#Emph}everything {#Prev}to reach this point in my career, to reach {#Emph}this {#Prev}very moment, on {#Emph}this {#Prev}very stage! And I'm prepared to give even more... what about {#Emph}you?!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Scylla" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" },
					},
				},

				{ Cue = "/VO/Scylla_0284",
					Text = "Back to our old and smaller stage as you can see, {#Emph}just {#Prev}for the night I'm sure! But our sponsor's going to come through! Put us back in the {#Emph}spotlight {#Prev}where we {#Emph}belong, hm! {#Prev}Eventually!" },
				{ Cue = "/VO/MelinoeField_3540", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Who do you even think this mysterious sponsor is, setting the location for our clash and whether that horrid Charybdis makes a guest appearance?" },
				{ Cue = "/VO/Scylla_0285",
					-- PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 9.65, PlayScyllaTauntAnim = true },
					Text = "Nice try, lady. You can barge onto our stage, no {#Emph}matter {#Prev}the size... you can try and take our sense of style... {#Emph}even our fans! {#Prev}But you'll never take our {#Emph}sponsors!!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Scylla" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight03" },
					},
				},

				{ Cue = "/VO/Scylla_0286",
					Emote = "PortraitEmoteCheerful",
					Text = "Sometimes we like going back to this smaller venue for old time's sake! Lots of our fans want us sticking to our roots." },
				{ Cue = "/VO/MelinoeField_3541", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So you comply with their every request? They don't sound much like fans if they're forcing their will upon you." },
				{ Cue = "/VO/Scylla_0287",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 9.65 },
					Text = "Oh, spoken like somebody who never {#Emph}had {#Prev}any fans to satisfy. We're only here because our audience has come to {#Emph}love {#Prev}our songs. So it's a give-and-take sort of relationship: {#Emph}our {#Prev}music, sailors' {#Emph}lives! {#Prev}And {#Emph}yours!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Scylla" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight03" },
					},
				},

				{ Cue = "/VO/Scylla_0288",
					Emote = "PortraitEmoteFiredUp",
					Text = "This is the big break we've been {#Emph}waiting for! {#Prev}I told the gals we'd be back in the spotlight on the big stage in {#Emph}no {#Prev}time. {#Emph}Oh{#Prev}, but the {#Emph}bigger {#Prev}we get... the more {#Emph}detractors {#Prev}we'll get..." },
				{ Cue = "/VO/MelinoeField_3542", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And do you try to suffocate all your detractors as well as your fans, and if so, how will you keep accumulating more and more?" },
				{ Cue = "/VO/Scylla_0289",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Don't worry your pretty little head about that, lady! You've got bigger problems, like our special guest... who happens to be good at suffocating multiple detractors all at once." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0290",
					Emote = "PortraitEmoteSparkly",
					PortraitExitAnimation = "Portrait_Scylla_Default_01_Exit",
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "CharybdisRevealPresentation",
					Text = "Big crowd here tonight, lady! Oh, we don't get turnouts like this {#Emph}every {#Prev}time, {#Emph}even {#Prev}if we really should! Though at our scale, we can't help but pick up some more-casual fans!" },
				{ Cue = "/VO/MelinoeField_3543", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not every Shade here in the Underworld can devote their every evening to attending your performances, Scylla. You don't even have that many songs." },
				{ Cue = "/VO/Scylla_0291",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "How would you even know?! We like to play our greatest hits, but we got plenty more! Ones you haven't heard of, probably, since you're our most {#Emph}casual {#Prev}fan of all!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight07 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/MelinoeField_3544", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So what's next for Scylla and the Sirens now that you've had your big break? An even bigger venue? Better songs?" },
				{ Cue = "/VO/Scylla_0292",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Even bigger venue, {#Emph}possibly! {#Prev}Even better songs, {#Emph}impossibly. {#Prev}Because our music is {#Emph}already {#Prev}the best! We {#Emph}could {#Prev}always make more if we really want, {#Emph}heh! {#Prev}Though right now, me and the gals want {#Emph}something more..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutAltFight08 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Scylla" },
					},
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla3_MC" },
					},
				},

				{ Cue = "/VO/Scylla_0293",
					Text = "Too bad Charybdis couldn't be here tonight, lady! Like she was supposed to. Probably back up on the {#Emph}surface{#Prev}, stuffing her face as usual!" },
				{ Cue = "/VO/MelinoeField_3545", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can see that. It must take a lot of sustenance to regenerate all those tentacles I've had to slice off." },
				{ Cue = "/VO/Scylla_0294",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 9.65 },
					Text = "Well, the show must go on! We're playing {#Emph}Rock and a Hard Place{#Prev}, with or without our special guest! And our small but dedicated audience is gonna {#Emph}eat it up!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAmbitions01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0008",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}I knew it! {#Prev}She's come {#Emph}back! {#Prev}You ready for another show, lady? We've been rehearsing our material, practicing nonstop, because one day? I'm gonna be a {#Emph}star! {#Prev}Oh, me and the gals!" },
				{ Cue = "/VO/Melinoe_1042", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What do your musical ambitions have to do with unprovoked acts of violence against {#Emph}me?" },
				{ Cue = "/VO/Scylla_0009",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "She's just heckling us, gals, ignore her, and take it from the top, {#Emph}two, three, four...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAmbitions02 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0010",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh, always wanted to sing in front of a great big crowd, you know? And not just a bunch of crusty sailors, but like, one of those gigantic theaters they got up on land!" },
				{ Cue = "/VO/Melinoe_1828", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not my area of expertise. Do performances in these theaters typically involve attempts to drown the members of the audience?" },
				{ Cue = "/VO/Scylla_0011",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 8.1 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, yeah... and mortals show up to them in massive droves, kicking and screaming, just to get a glimpse, {#Emph}heh! {#Prev}Yet you get a show {#Emph}all to yourself!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSirens01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Melinoe_1830", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, I thought the Sirens were supposed to be the singing ones. But it's always {#Emph}you {#Prev}flapping your gills at me, Scylla..." },
				{ Cue = "/VO/Scylla_0023",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Don't {#Prev}listen to her, gals! Your backup vocals are the backbone of this act! I've got the voice, {#Emph}you've {#Prev}got the music, we've got {#Emph}the magick! {#Prev}Let's give her a little taste, {#Emph}huh?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSirens02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "TraitCache", "SpellSummonTrait" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Scylla" },
					},
					{
						Path = { "GameState", "SpeechRecord" },
						HasAny = {
							"/VO/Scylla_0242", "/VO/Scylla_0243", "/VO/Scylla_0244", "/VO/Scylla_0245", "/VO/Scylla_0246", "/VO/Scylla_0247", "/VO/Scylla_0248", "/VO/Scylla_0249",
						},
					},
				},
				{ Cue = "/VO/Scylla_0213",
					Emote = "PortraitEmoteSparkly",
					Text = "We have our ups and downs, Jetty and Roxy and me. Our little squabbles! But thanks to {#Emph}you{#Prev}, we started fighting with each other in {#Emph}public! {#Prev}And we can't have {#Emph}that." },
				{ Cue = "/VO/MelinoeField_2720", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If it makes you feel any better, the hex I put on them was only temporary. Quite frankly I'm surprised it worked on them at all! Night Bloom normally works only on the dead." },
				{ Cue = "/VO/Scylla_0214",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "This is my band. And if anybody's gonna turn Jetty and Roxy red with rage against each other, it's {#Emph}not {#Prev}going to be {#Emph}you! {#Prev}Right, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutStage01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0016",
					Emote = "PortraitEmoteSparkly",
					Text = "Just can't get enough of us, {#Emph}can {#Prev}you, lady? Oh, it's OK, happens to everybody, especially sailors, we're just that {#Emph}good! {#Prev}Do you sail?" },
				{ Cue = "/VO/Melinoe_2040", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your self-confidence is enviable, but I'm only here because I have to get past this ridiculous stage. So why don't we skip the show." },
				{ Cue = "/VO/Scylla_0017",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh I got a better idea: Why don't we {#Emph}start {#Prev}the show? All we needed was a little audience, and we've got {#Emph}you {#Prev}right where we want you." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutReputation01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0012",
					Text = "They say... our songs are {#Emph}to die for{#Prev}, but lately we don't get a lot of company. Oh, you wouldn't know anything about {#Emph}that{#Prev}, right? Because {#Emph}somebody's {#Prev}been smearing our good name..." },
				{ Cue = "/VO/Melinoe_1043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your reputation is yours to build or ruin. Doubt anyone I know has even heard of you, besides." },
				{ Cue = "/VO/Scylla_0013",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Come on, gals! Let's go {#Emph}all out {#Prev}again before the crowd shows up! They're {#Emph}going {#Prev}to show up! I just {#Emph}know {#Prev}it!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSurvey01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0021",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh hey, as one of our fans, {#Emph}what {#Prev}would you say is the best thing about Scylla and the Sirens, {#Emph}hm? {#Prev}Our latest hit song? Our impeccable style?" },
				{ Cue = "/VO/Melinoe_2039", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your sense of style isn't really to my taste, that I can say for certain." },
				{ Cue = "/VO/Scylla_0022",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aw, {#Prev}that's OK! Not everybody's got {#Emph}good taste{#Prev}. At least you're strong enough to admit it, though we're going to get you for that insult, anyway." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSongs01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla2_MC" },
					},
				},
				{ Cue = "/VO/Scylla_0014",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ooh, good, {#Prev}you're just in time for our set! Been working on a song called {#Emph}I Am Gonna Claw (Out Your Eyes then Drown You to Death), heh! {#Prev}Comes from a real personal place." },
				{ Cue = "/VO/Melinoe_1829", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is it any better than the one I heard on my way in?" },
				{ Cue = "/VO/Scylla_0015",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "No, it's {#Emph}not! {#Prev}Because {#Emph}all {#Prev}our songs are {#Emph}the best, heh! {#Prev}Each like a {#Emph}perfect {#Prev}little child! Not a {#Emph}bad {#Prev}one, like {#Emph}you..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutSongs02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs01" },
					},
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla1_MC", "/Music/IrisMusicScylla2_MC" },
					},
				},
				{ Cue = "/VO/Scylla_0138",
					Emote = "PortraitEmoteSparkly",
					Text = "How did you like our latest song, lady? Be honest! There's no right {#Emph}or {#Prev}wrong answer, OK? We {#Emph}thrive {#Prev}on feedback from our fans!" },
				{ Cue = "/VO/MelinoeField_2017", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you seek feedback from your fans, ask {#Emph}them. {#Prev}As for me, I felt the chorus was catchy enough, but the lyrics and their disturbing themes were rather distracting." },
				{ Cue = "/VO/Scylla_0139",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Disturbing? Distracting?! {#Emph}Compelling! That's {#Prev}what good music {#Emph}is{#Prev}. That's what Scylla and the Sirens {#Emph}are! {#Prev}As for our song, {#Emph}hee! {#Prev}You'll understand it better if you give it {#Emph}another {#Prev}listen..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSongs03 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla2_MC" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs02" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ScyllaAboutSongs02" }, Min = 3 },
					},
				},
				{ Cue = "/VO/MelinoeField_2564", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Scylla, I've noticed your song {#Emph}I Am Gonna Claw {#Prev}may be inspired by true events. Is trying to drown me not sufficiently entertaining that I must also be the subject of your ridicule?" },
				{ Cue = "/VO/Scylla_0207",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Oh, hoho {#Prev}how can you be so egotistical even? I had that song worked out since way before {#Emph}you {#Prev}showed up. Any and all similarity is entirely coincidence!" },
				{ Cue = "/VO/MelinoeField_2565", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come on. Insulting my hair and attire? Making claims that I'm obsessed with you? But if I'm not the subject of the song, who was, pray tell?" },
				{ Cue = "/VO/Scylla_0208",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "No need to get personal, lady! If I go sharing {#Emph}every {#Prev}detail of my private life with every deranged fan who barges in here, then it wouldn't be a {#Emph}private {#Prev}life, {#Emph}would it?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSongs04 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs03" }
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
						Comparison = ">=",
						Value = 10,
					},
				},
				{ Cue = "/VO/MelinoeField_2562", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't you have any new material yet, Scylla? You'd likely garner a much bigger audience if you had a few more songs." },
				{ Cue = "/VO/Scylla_0205",
					Emote = "PortraitEmoteAnger",
					Text = "Shut {#Emph}up! {#Prev}We have more songs than you can {#Emph}count! {#Prev}You're just not ready for them yet. {#Emph}Nobody {#Prev}is! {#Emph}Perfection {#Prev}takes time, {#Emph}lady." },
				{ Cue = "/VO/MelinoeField_2563", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But, perfection is always out of reach... if you keep pursuing it, you'll never get there. You must have a work-in-progress you could play instead of the same old stuff." },
				{ Cue = "/VO/Scylla_0206",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}The same old stuff...? {#Prev}Did you just hear that, gals? I think she meant to say your {#Emph}greatest hits{#Prev}, or your {#Emph}all-time classics{#Prev}, didn't she? {#Emph}Heh! {#Prev}You just don't get it, lady. We're here to {#Emph}please!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSongs05 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ScyllaAboutAltFight01", "ScyllaAboutBallad01" },
					},
				},
				{ Cue = "/VO/Scylla_0309",
					Emote = "PortraitEmoteCheerful",
					Text = "So, what's your favorite of our latest songs, lady? We've got something for just about {#Emph}everybody {#Prev}now! Even you." },
				{ Cue = "/VO/MelinoeField_3587", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Oh, I'm reluctant to choose. I think all these clashes with you lot must have had a significant impact on my ability to appreciate your music on its own merits." },
				{ Cue = "/VO/Scylla_0310",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, PlayScyllaTauntAnim = true, WaitTime = 8.3 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aw, that's {#Prev}too bad! If you can't appreciate art for its own sake and need to hold those of us who make it to outlandish standards, then {#Emph}what {#Prev}are you even {#Emph}doing?!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutBallad01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla4_MC" },
					},
					-- see also ScyllaBalladUnlocked
				},
				{ Cue = "/VO/MelinoeField_4308", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Was that a new song I heard on my way in? Something about treasures glimmering. Another one about the sea!" },

				{ Cue = "/VO/Scylla_0436",
					Emote = "PortraitEmoteSparkly",
					Text = "You {#Emph}could {#Prev}have said {#Emph}Scylla, I don't know anything about themes, so I just can't appreciate the depth of your work! {#Prev}But {#Emph}yeah{#Prev}, it {#Emph}is {#Prev}a new song! And only the first part." },

				{ Cue = "/VO/MelinoeField_4309", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I suppose the second part is imminent. You make your performances unnecessarily difficult by fighting me, but that's a choice you keep on making." },

				{ Cue = "/VO/Scylla_0437",
					Emote = "PortraitEmoteFiredUp",
					Text = "Well we have to drown {#Emph}someone! {#Prev}And sailors have gotten too {#Emph}easy{#Prev}, lady. You'll never be an artist if you don't push {#Emph}harder, and harder, and harder...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
				EndFunctionName = "ScyllaNewSongPresentation",
			},
			ScyllaAboutBallad02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutBallad01" },
					},
				},

				{ Cue = "/VO/Scylla_0439",
					Emote = "PortraitEmoteSparkly",
					Text = "What'd you think of our latest number, lady? Critics say {#Emph}Bewitching Eyes {#Prev}reveals a {#Emph}soulful{#Prev}, more {#Emph}vulnerable {#Prev}side of Scylla and the Sirens. But what do they know?" },

				{ Cue = "/VO/MelinoeField_4311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I couldn't make out all the lyrics while fighting back you lot, but you sang of red and green bewitching eyes and love potions and such. Is this truly how you feel about me?" },

				{ Cue = "/VO/Scylla_0440",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Pff, no! {#Prev}Why would I feel any of those things, especially about {#Emph}you{#Prev}, lady? It's called a {#Emph}fictionalized work? {#Prev}And besides, Jetty mostly wrote that one." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutBallad03 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla2_MC", "/Music/IrisMusicScylla4_MC" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutBallad02" },
					},
				},

				{ Cue = "/VO/MelinoeField_4312", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You truly expect me to believe that neither {#Emph}I Am Gonna Claw {#Prev}nor {#Emph}Bewitching Eyes {#Prev}concern our meetings? Though if you're drawn to me, you have an odd way of showing it." },

				{ Cue = "/VO/Scylla_0441",
					Emote = "PortraitEmoteFiredUp",
					Text = "No way! {#Emph}You're {#Prev}the one who always shows up {#Emph}here{#Prev}, lady. You are obviously drawn to {#Emph}me! {#Prev}Or one or more of us. Jetty knows it, Roxy knows it, {#Emph}everyone {#Prev}in Oceanus knows it!" },

				{ Cue = "/VO/MelinoeField_4313", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh come on, Scylla. I'll admit I don't dislike your songs as much as I previously let on, but that's as far as I'll go." },

				{ Cue = "/VO/Scylla_0442",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Aw{#Prev}, you hear that, gals? That's as far as she'll go! I {#Emph}told {#Prev}you. Now either {#Emph}she {#Prev}gets off this stage, or {#Emph}we {#Prev}do!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSongVolume01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = "<",
						Value = 0.05,
					},
				},
				{ Cue = "/VO/Scylla_0211",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 6.7 },
					Text = "I don't know what you did, lady, but lately, I can barely hear myself think... much less {#Emph}sing! {#Prev}I hate you, you {#Emph}witch! {#Prev}You {#Emph}better {#Prev}make it right!" },
				{ Cue = "/VO/MelinoeField_2719", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Or else what? I'll use what tactics I see fit. Not having to listen to you spout your nonsense makes it easier to send you back to the depths for the night." },
				{ Cue = "/VO/Scylla_0212",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You know you like our song. Can't live without it! And I will {#Emph}not {#Prev}be {#Emph}silenced! {#Prev}No matter what you do, I'll always be singing in {#Emph}my {#Prev}head, and {#Emph}yours!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutChlams01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0018",
					Text = "Oh hey gals, guess who?! It's the {#Emph}one that got away{#Prev}, that's who! {#Emph}Mm{#Prev}, something you ought to know about me, lady... is once I catch 'em... I never let 'em go." },
				{ Cue = "/VO/Melinoe_2037", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That comes as no surprise to me at all. Some sea creatures are famously clingy. Barnacles, chlams..." },
				{ Cue = "/VO/Scylla_0019",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I am {#Emph}not {#Prev}a chlam!! You take that back. I'll {#Emph}make {#Prev}you take that back!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutChlams02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutChlams01" },
					},
				},
				{ Cue = "/VO/Melinoe_2038", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Now, see here! I'd no intention to offend last time, and never said you {#Emph}were {#Prev}a chlam. The least you could do is base your anger in reality." },
				{ Cue = "/VO/Scylla_0020",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Would you listen to that, gals, she's still talking about chlams! Poking fun at my little shell here, huh, {#Emph}hm-hm! {#Prev}Well, let's show her how we deal with hecklers 'round {#Emph}these {#Prev}parts!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutComeback01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "G_PostBoss01" },
					},
				},
				{ Cue = "/VO/Scylla_0026",
					Text = "{#Emph}Hohh, {#Prev}surprised to see us again, lady? {#Emph}Heh, {#Prev}'cause we're not going anywhere. This is our big {#Emph}comeback tour{#Prev}, after all!" },
				{ Cue = "/VO/Melinoe_2042", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I thought I dealt with you last time, yet here you are. Am I going to have to drive you back into the sea?" },
				{ Cue = "/VO/Scylla_0027",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I don't know, am I going to have to tell Jetty and Roxy to {#Emph}play {#Prev}their hearts out? {#Emph}No{#Prev}, I'm not! 'Cause that's just what they do! {#Emph}Don't you{#Prev}, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutDying01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Scylla_0140",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ohh{#Prev}, you keep trying to {#Emph}kill {#Prev}me, lady! The former Sea-Nymph side of me says {#Emph}just forget it {#Prev}and move on! But, I don't like to listen to her anymore." },
				{ Cue = "/VO/MelinoeField_2018", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.7 },

					Text = "That you don't listen to yourself explains a lot. I know better than to try and kill an Oceanid. I just need you to get out of my way." },
				{ Cue = "/VO/Scylla_0141",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Hear that gals? I distinctly heard the lady say {#Emph}I need you {#Prev}there, {#Emph}hoho! {#Prev}Our art changes lives! What say we change {#Emph}this {#Prev}one right {#Emph}now...?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutPackagedBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Scylla_0209",
					Emote = "PortraitEmoteSparkly",
					Text = "Look who got here way too early for tonight's show! Doors weren't meant to open yet, lady! Not that {#Emph}you {#Prev}care about this venue's very reasonable code of conduct." },
				{ Cue = "/VO/MelinoeField_2718", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh I'm familiar with the venue at this point. And if you aren't ready to perform yet, great! I don't really want to hear it from you anyway." },
				{ Cue = "/VO/Scylla_0210",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Well, {#Emph}too bad! {#Prev}Because even though you're way too early, you are {#Emph}just {#Prev}in time for the private {#Emph}pre{#Prev}-show concert that was {#Emph}just about to start!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutOdysseus01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutScylla02" },
					},
				},
				{ Cue = "/VO/Scylla_0024",
					Emote = "PortraitEmoteSparkly",
					Text = "So tell me, lady, {#Emph}how is it {#Prev}that you seem to know our tricks? Other than the part where we keep playing the same act. Usually it slays!" },
				{ Cue = "/VO/Melinoe_2041", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Great Tactician Odysseus says hello. Told me all about you. You claim you never let anybody get away, though {#Emph}I {#Prev}understand all but six of his hapless men got well away from you." },
				{ Cue = "/VO/Scylla_0025",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Odysseus, hah! {#Prev}Oh, {#Emph}he's {#Prev}still on the hook! Big fish like that just {#Emph}takes a while to reel in{#Prev}, as he might say. Our song must still be bouncing around in his {#Emph}pretty {#Prev}little head! And now for yours..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutOdysseus02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutOdysseusQuest01" },
					},
				},
				{ Cue = "/VO/Scylla_0303",
					Text = "We know how come you keep on showing up here, don't we, lady? You're like Odysseus and {#Emph}all {#Prev}the rest! Though... what was with that Princess of the Underworld stuff he was going on about?" },
				{ Cue = "/VO/MelinoeField_3584", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 3 },
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Nothing that you need concern yourself with at this point. So you think I keep returning because I love your music? Why wouldn't I just listen to it then, instead of fighting you?" },
				{ Cue = "/VO/Scylla_0304",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Live music is an interactive experience. You don't just sit back and {#Emph}hear {#Prev}it! You {#Emph}immerse {#Prev}yourself in it... soak it in, {#Emph}ahaha! {#Prev}And you've been doing that more than {#Emph}just {#Prev}about anyone." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutOdysseusQuest01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusLooseEndsQuest02" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
				},

				{ Cue = "/VO/MelinoeField_4354",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 4, PowerWordPresentation = true, PowerWordWaitTime = 8.3 },

					PostLineFunctionName = "SummonOdysseus",
					PostLineFunctionArgs = { SummonTargetIds = { G_Boss01 = 736958, G_Boss02 = 800477 }, },
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "Scylla, would you mind if I put you in touch with a mutual acquaintance? It'll only be a moment. {#Emph}Heed now my voice, Odysseus; one whom you sought is here!" },

				{ Cue = "/VO/Scylla_0296",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteSparkly",
					Text = "I knew you'd come back, sailor. Once they hear our song, they always {#Emph}do! {#Prev}Unless they drown, and sometimes even after {#Emph}that. Ah{#Prev}, just had to get another listen, {#Emph}huh?" },

				{ Cue = "/VO/Odysseus_0567",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					Text = "Aye, Scylla, you and your Siren song left quite an impression on me in my mortal days! And I no longer wish to keep pretending otherwise." },

				{ Cue = "/VO/Scylla_0297",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Oh{#Prev}, well if you want an earful, {#Emph}suit yourself! {#Prev}Nothing we'd rather do than please our longtime fans. I {#Emph}think {#Prev}some of your old crew's already in the crowd! The ones I {#Emph}took." },

				{ Cue = "/VO/Odysseus_0568",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "We had no choice but to sail past you, and good men gave their lives. But now the Princess of the Underworld shall give them all a show to remember!" },

				{ Cue = "/VO/Scylla_0298",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					PostLineThreadedFunctionName = "UnSummonOdysseus",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Princess of the Underworld... this {#Prev}lady? {#Emph}Hah! {#Prev}You always were the scheming sort and haven't changed a bit. Well then listen up, all of you..." },

				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutOdysseusQuest02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutOdysseusQuest01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
					OrRequirements =
					{
						-- hasn't left for his journey yet
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "OdysseusLooseEndsQuestComplete01" },
							},
						},
						-- returned and reunited
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutReturn01" },
							},
						},
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				{ Cue = "/VO/MelinoeField_4355",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.6, PowerWordPresentation = true, PowerWordWaitTime = 6.3 },

					PostLineFunctionName = "SummonOdysseus",
					PostLineFunctionArgs = { SummonTargetIds = { G_Boss01 = 736958, G_Boss02 = 800477 }, },
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "I think a certain sailor would like another quick word! {#Emph}Heed now my voice, Odysseus; one whom you sought is here!" },

				{ Cue = "/VO/Scylla_0301",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteSparkly",
					Text = "How was our show for you last time, Odysseus, as good as you recall? It {#Emph}must {#Prev}have been if you're back here {#Emph}again. {#Prev}Not that you had much choice in the matter!" },

				{ Cue = "/VO/Odysseus_0569",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineThreadedFunctionName = "UnSummonOdysseus",
					Text = "I'm here because the Princess of the Underworld summoned me, Scylla. Though getting to hear your song again is a nice benefit. It's not my wish to delay your production so I'll be somewhere in the audience, all right?" },

				{ Cue = "/VO/Scylla_0302",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh you go right ahead, {#Emph}heh. {#Prev}We don't want everybody barging up on stage! Not with this {#Emph}Princess of the Underworld {#Prev}already soaking up all the {#Emph}spotlight!" },

				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutCurse01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "CodexEntriesViewed", "Scylla" }
					},
				},
				{ Cue = "/VO/MelinoeField_3590", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If I may ask, who made you this way, Scylla? Because my understanding is that you weren't always, well... the way you are." },

				{ Cue = "/VO/Scylla_0315",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Oh-hoh{#Prev}, I'm entirely self-made, {#Emph}thank you{#Prev}, lady! You think I'm going to attribute all my talent to {#Emph}somebody else? {#Prev}A {#Emph}wizened songmaster {#Prev}who taught me all I know?" },

				{ Cue = "/VO/MelinoeField_3591", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your musical talents being innate doesn't surprise me; I'm asking how did you become a sea-monster. Weren't you the victim of a curse?" },

				{ Cue = "/VO/Scylla_0316",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Hah! Oh{#Prev}, something you wouldn't understand is, the more famous you get, the more they're going to say about ya! Because they're {#Emph}jealous! {#Prev}I let all of it {#Emph}roll {#Prev}off my shell. No good artist lets a random lie or {#Emph}insult {#Prev}get to them!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceAboutScylla01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3592", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Are you familiar with the enchantress Circe? She mentioned that she knew you in her youth... though, I'm uncertain if you were on friendly terms." },

				{ Cue = "/VO/Scylla_0317",
					Text = "The {#Emph}enchantress {#Prev}Circe, no that doesn't ring a bell! The only Circe {#Emph}I {#Prev}knew was the talentless pathetic little runt of the litter of Helios himself! What has this {#Emph}other {#Prev}Circe got to say?" },

				{ Cue = "/VO/MelinoeField_3593", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She gave me the impression you were always rather boisterous, even back then. Perhaps already practicing the kinds of songs you think shall bring you fame." },

				{ Cue = "/VO/Scylla_0318",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 8.5 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "It's no secret I always knew what I wanted to be, lady. Always knew what I was {#Emph}meant {#Prev}to be! Circe and so many others... all they ever did was get in my {#Emph}way! Same as you." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAgents02" },
					},
				},
				{ Cue = "/VO/Scylla_0197",
					Emote = "PortraitEmoteSparkly",
					Text = "Well, if it isn't the little name-dropper! Off to see your good friend Mister Chronos again, {#Emph}hm? {#Prev}He {#Emph}loves {#Prev}our act! You'll {#Emph}drown {#Prev}before you take his sponsorship away from us!" },
				{ Cue = "/VO/MelinoeField_2558", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh I'm not after any sponsorships from him. And we're {#Emph}not {#Prev}friends. We merely have some business to resolve... which {#Emph}you {#Prev}continue to impede night after night." },
				{ Cue = "/VO/Scylla_0198",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Business? {#Prev}With {#Emph}him? {#Prev}Then you must be somebody's kid, no {#Emph}way {#Prev}you'd have connections like that on your own! You know, some of us had to {#Emph}earn {#Prev}our spotlight, lady!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutChronos01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosBossAboutScylla01" }
					},
				},
				{ Cue = "/VO/Scylla_0199",
					Text = "Gonna level with you, lady. We can't have you bugging Mister Chronos {#Emph}every night! {#Prev}He doesn't pay much attention to our venue here, and we want to {#Emph}keep {#Prev}it that way." },
				{ Cue = "/VO/MelinoeField_2559", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't think Chronos is concerned with you at all. So maybe back off, focus on your songwriting, instead of trying to asphyxiate me constantly?" },
				{ Cue = "/VO/Scylla_0200",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh she just doesn't get it, gals! But don't worry. They're {#Emph}never {#Prev}gonna shut us down, not while we keep on drawing crowds like {#Emph}this! {#Prev}It's {#Emph}good publicity!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutNarcissus01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NarcissusAboutSirens01", "NarcissusAboutEcho01", "NarcissusAboutEcho01B" },
					},
				},
				{ Cue = "/VO/Scylla_0338",
					Text = "By now, every single soul in Oceanus knows our name, lady! Especially {#Emph}mine! {#Prev}For all your efforts to defame us, all you've accomplished is the opposite!" },
				{ Cue = "/VO/MelinoeField_3606", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "At the risk of arguing over a technicality, I've met at least one soul in Oceanus who couldn't care less about your act. He'd much rather stare into a shallow pool than listen to you." },
				{ Cue = "/VO/Scylla_0339",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Well{#Prev}, we can't please everyone, can we? We'd be giving up all our {#Emph}integrity {#Prev}if we even {#Emph}tried... {#Prev}something {#Emph}you {#Prev}wouldn't know the first thing about!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift01" },
					},
				},
				{ Cue = "/VO/Scylla_0340",
					Text = "There's a lot to like about this part of Oceanus, don't you think? The acoustics are the {#Emph}perfect {#Prev}blend of {#Emph}land {#Prev}and {#Emph}sea... {#Prev}and that {#Emph}Poseidon {#Prev}has no control over {#Emph}any {#Prev}of it!" },
				{ Cue = "/VO/MelinoeField_3607", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're taking advantage of this place being past the border of the realm beneath the Earth. I don't think Lord Poseidon would appreciate that, should you ever return to his waters." },
				{ Cue = "/VO/Scylla_0341",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ohh{#Prev}, if we ever go back to {#Emph}his {#Prev}waters, we'll be {#Emph}so {#Prev}big that he wouldn't {#Emph}dare {#Prev}mess with us! He or {#Emph}any {#Prev}of the gods! Wherever we go, we're gonna be the {#Emph}main attraction." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutCharybdis01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_MiniBoss01" },
					},
					--[[
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" }
					},
					]]--
				},
				{ Cue = "/VO/Scylla_0203",
					Text = "We used to play the {#Emph}surface{#Prev}, you know! That's when we {#Emph}really {#Prev}started to hit it big! Even had {#Emph}Charybdis {#Prev}open for us a few times, can you imagine?" },
				{ Cue = "/VO/MelinoeField_2561", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So what? Charybdis opened for me just the other night. I practically couldn't get it to shut up!" },
				{ Cue = "/VO/Scylla_0204",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Like I believe {#Emph}that! {#Prev}Though I bet you {#Emph}are {#Prev}from up there, aren't you? You think you're underground, like us, but you'll {#Emph}always {#Prev}be {#Emph}mainstream!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutCharybdis02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/MelinoeField_3598", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Sharing the spotlight seems unlike you, Scylla. How will you make a name for yourself if you keep collaborating with a bigger performer like Charybdis? " },
				{ Cue = "/VO/Scylla_0328",
					Text = "Charybdis has the bigger {#Emph}mouth {#Prev}all right, but {#Emph}we {#Prev}got a pretty different act. Sailors often can't decide {#Emph}which {#Prev}of us they like more, so... we figured: Why not let them have both?" },
				{ Cue = "/VO/MelinoeField_3599", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "This also doesn't strike me as the simplest creative partnership. Yet you're working together, to please your audience, or simply to stop {#Emph}me. {#Prev}I'm almost impressed." },
				{ Cue = "/VO/Scylla_0329",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh{#Prev}, words we very often hear, yet always mean {#Emph}so {#Prev}much! Especially from our {#Emph}harshest {#Prev}detractors! Won't stop us from trying to drown you like always, lady... but {#Emph}thanks." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutGreenRoom01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "Inspect_G_PostBoss_02" }
							},							
						},
						{
							{
								Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
								Comparison = ">=",
								Value = 5,
							},
						},
					},
				},
				{ Cue = "/VO/Scylla_0189",
					Text = "See anything you like in our greenroom down there, {#Emph}hm? {#Prev}Maybe you didn't notice the sign but that's our {#Emph}private {#Prev}little area where fans are {#Emph}not supposed to go!" },
				{ Cue = "/VO/MelinoeField_2554", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your so-called {#Emph}greenroom {#Prev}happens to be built atop a drain that spills into the Mourning Fields below. You could always flush your sorry work down {#Emph}there{#Prev}, where it'll fit right in." },
				{ Cue = "/VO/Scylla_0190",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ohh{#Prev}, you went looking through our {#Emph}work! {#Prev}So what if a few ideas go unused here and there? If you don't {#Emph}cut... {#Prev}you never get to the {#Emph}good stuff." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutRumors01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutGreenRoom01" }
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 2 },
					},
				},
				{ Cue = "/VO/Scylla_0434",
					Text = "Go on and heckle us, lady! We're {#Emph}big{#Prev}, we've got thick scales! {#Emph}Scylla's got a voice like yelping dogs! Her lustrous hair looks like a bunch of snakey heads! {#Prev}We've heard it all!" },
				{ Cue = "/VO/MelinoeField_4307", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wasn't going to say any of those things, which strike me as bizarre. Perhaps if you didn't antagonize your audience so much, they'd be more charitable." },
				{ Cue = "/VO/Scylla_0435",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Their words roll {#Emph}right {#Prev}off our backs! At least {#Emph}mine. {#Prev}I only care about their {#Emph}cheers {#Prev}and their {#Emph}screams... {#Prev}which all start to sound the same after a while..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" }
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0201",
					Text = "{#Emph}Ohh{#Prev}, it's only {#Emph}you! {#Prev}Not just another one of those sailors we've been seeing more and more of lately here. Look at this {#Emph}crowd! {#Prev}We've been causing a {#Emph}real {#Prev}stir!" },
				{ Cue = "/VO/MelinoeField_2560", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps those sailors are just remnants of the sunken fleet that Chronos sends against the gods. I've had my scuffles with them recently." },
				{ Cue = "/VO/Scylla_0202",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh no, I don't think so, lady. Our fame is due to good old fashioned word-of-mouth! And there is {#Emph}nothing {#Prev}you can do to {#Emph}stop {#Prev}it now!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSlump01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSirens01" }
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 3 },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ScyllaAboutSirens01" }, Min = 2 },
					},
				},
				{ Cue = "/VO/Scylla_0191",
					Text = "Roxy, and Jetty, and I... we've been through bigger slumps than this, lady. It's gonna take more than your heckling to tear {#Emph}us {#Prev}apart!" },
				{ Cue = "/VO/MelinoeField_2555", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't know why I bother with you, Scylla. Or why Roxy and Jetty do! You've yet to let either one of them speak." },
				{ Cue = "/VO/Scylla_0192",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "They {#Emph}speak {#Prev}through their {#Emph}work! {#Prev}Besides I'm not just lead singer, I'm in charge of the talent! And the gals aren't taking interviews right now, especially from the likes of {#Emph}you!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAgents01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/Scylla_0193",
					Text = "In my meeting with the gals the other night, we got to talking, {#Emph}I was talking mostly{#Prev}, but we started wondering what is your {#Emph}deal? {#Prev}Jetty thinks maybe you're an {#Emph}agent?" },
				{ Cue = "/VO/MelinoeField_2556", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Jetty is rather perceptive, then... for I am indeed an agent of Night. This realm has fallen to the Titan; we shall see it restored to its rightful rule. No matter who gets in our way." },
				{ Cue = "/VO/Scylla_0194",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I can't believe it, Jetty, you were {#Emph}right? {#Prev}An agent on the hunt! Well your search is over, Agent Lady, because {#Emph}you {#Prev}won't find a bigger talent in the sea or out! Just {#Emph}watch!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAgents01_2 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAgents01" },
					},
					-- back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutAgents02" }
					},
				},
				{ Cue = "/VO/Scylla_0336",
					Emote = "PortraitEmoteCheerful",
					Text = "Agent Lady, welcome {#Emph}back! {#Prev}So who's this {#Emph}Night {#Prev}you're working for, and who else has she signed? She sounds intense." },
				{ Cue = "/VO/MelinoeField_3605", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I spoke of the one and only Night, whose presence fills the Underworld and surface. She is one of the eldest primordial powers; yet the Titan Chronos thought he could stop her." },
				{ Cue = "/VO/Scylla_0337",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ooh{#Prev}, sounds like some {#Emph}healthy competition! {#Prev}Well, if this Night {#Emph}really {#Prev}wants us to sign with her, she'd better make a {#Emph}good offer! {#Prev}Else Mister Chronos might snatch up all the talent!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAgents02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAgents01" },
					},
				},
				{ Cue = "/VO/Scylla_0195",
					Emote = "PortraitEmoteSparkly",
					Text = "You're not really an agent, are you, lady? Just pulling our fins, trying to get our hopes up, only to {#Emph}dash {#Prev}them against the rocks! How low can you {#Emph}sink?" },
				{ Cue = "/VO/MelinoeField_2557", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Get your hopes up? Listen to me: I seek {#Emph}Chronos{#Prev}, not you. Perhaps you shall be hunted by some other agent, though." },
				{ Cue = "/VO/Scylla_0196",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You better believe it, gals! Even {#Emph}this {#Prev}lady knows a rising star when she sees one. When she {#Emph}hears {#Prev}one! And she's gonna put in a good word for us, {#Emph}won't she?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			-- see similar ScyllaAboutGrandeur01
			ScyllaLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutGrandeur01" }
					},
				},
				{ Cue = "/VO/Scylla_0028",
					Text = "Oh no, you're bleeding. Trouble finding the place? Don't worry, gals. One day? They'll put us up on the biggest stage, for {#Emph}all the world to see!" },
				{ Cue = "/VO/Melinoe_2043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not particularly interested in listening to your delusions of grandeur right now, so why not start your little song." },
				{ Cue = "/VO/Scylla_0029",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, it may be a little song to you {#Emph}now{#Prev}, lady. But it's going to be huge someday. You'll see. We'll show her, won't we, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Scylla_0030",
					Text = "Oh you know, this is a reputable venue, lady, and we {#Emph}do {#Prev}impose a dress code at the door, {#Emph}hm-hm! {#Prev}Oh, but you come barging in, looking like hell." },
				{ Cue = "/VO/Melinoe_2044", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sea-dwellers are not so welcoming to strangers in your habitat. Thus I'm a bit unkempt. And a bit low on patience..." },
				{ Cue = "/VO/Scylla_0031",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Got that old sinking feeling, huh? Then let's not keep her waiting any longer, gals! {#Emph}Hit it!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.66, },
					},
				},
				{ Cue = "/VO/Scylla_0032",
					Text = "The sea can be a dangerous place if you don't know your way around, lady! {#Emph}Ohoho! {#Prev}Though it looks like you figured that out all on your own!" },
				{ Cue = "/VO/Melinoe_2045", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Everything is damp, and reeks to the heavens. And now I'm forced to listen to {#Emph}your {#Prev}snide remarks. And your insufferable song, I suppose?" },
				{ Cue = "/VO/Scylla_0033",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You're damn right! And we'll {#Emph}keep {#Prev}playing our song until it's {#Emph}pitch perfect{#Prev}. It's a work in progress. So don't hold your breath..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--[[
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					]]--
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Scylla_0034",
					Text = "Aw lookit, gals, she's hurt! She's already hurt {#Emph}real bad{#Prev}. Maybe we could ease her passing with a little {#Emph}music{#Prev}, huh?" },
				{ Cue = "/VO/Melinoe_2046", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I assure you any pain I'm experiencing is nothing compared with the pain I'll inflict on {#Emph}you {#Prev}if you continue to cross me." },
				{ Cue = "/VO/Scylla_0035",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Still got some fight left in you, huh? Well good, 'cause we just hate a passive audience! Come on, get in the pit, lady! The show's about to start!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutNoShow01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
						Comparison = ">=",
						Value = 10,
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" },
					},
					{
						SumPrevRuns = 5,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Scylla_0305",
					Emote = "PortraitEmoteCheerful",
					Text = "It's been {#Emph}so {#Prev}nice without {#Emph}you {#Prev}recently, lady! We've been playing our {#Emph}full {#Prev}set list night after night, {#Emph}no {#Prev}technical difficulties! Even had more and more {#Emph}sailors {#Prev}dropping in!" },
				{ Cue = "/VO/MelinoeField_3585", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Those sailors dropping in are probably the Titan's naval forces I've been vanquishing throughout the Rift of Thessaly above. I think I recognize a few out in the stands." },
				{ Cue = "/VO/Scylla_0306",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 6 },
					Text = "You expect me to believe you've been promoting our events? We're getting lots of word-of-mouth lately, sure, but you've had {#Emph}nothing {#Prev}to {#Emph}do {#Prev}with it! Except by going {#Emph}away!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutMerch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_FanPoster01" },
					},
				},
				{ Cue = "/VO/Scylla_0307",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 3.3 },
					Text = "The gals and I decided recently, we need a {#Emph}product line! {#Prev}Authentic tokens of our {#Emph}breathtaking {#Prev}performances our fans can purchase for a reasonable price after the show! But we can't sell them with {#Emph}you {#Prev}getting in our way." },
				{ Cue = "/VO/MelinoeField_3586", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're the ones getting in {#Emph}my {#Prev}way! I never chose to have these fights! What do I care if you sell wall-scrolls and such to audience members who have resources to spare?" },
				{ Cue = "/VO/Scylla_0308",
					Emote = "PortraitEmoteSurprise",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 10.7 },
					Text = "How did {#Emph}you {#Prev}know that we offer wall-scrolls? {#Emph}Oh, hohohoh! {#Prev}You probably already got some of our merchandise and want it {#Emph}all to yourself! {#Prev}Well, if you want special treatment, {#Emph}come get it!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				{ Cue = "/VO/Scylla_0311",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 5.8 },
					Text = "This is gonna be our night! Can't you just {#Emph}feel {#Prev}it, gals? Don't know about you all but {#Emph}I {#Prev}am feeling even more {#Emph}unstoppable {#Prev}than normal! {#Emph}Ohh{#Prev}, and just in {#Emph}time..." },

				{ Cue = "/VO/MelinoeField_3588", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh you're still stoppable, although the will of Night has made you stronger, yes. Shall we find out to what extent?" },

				{ Cue = "/VO/Scylla_0312",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Stoppable? {#Emph}Ahaha. Us? {#Prev}You don't get it, lady. We've never missed a single show, and we are {#Emph}not {#Prev}about to start! {#Emph}Oh{#Prev}, of course with live performances, there's no telling what might happen..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutShrine01" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				{ Cue = "/VO/Scylla_0313",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ooh! {#Prev}So glad you just decided to show up, lady, because you're really in for it tonight! We're {#Emph}fresh {#Prev}from rehearsing our {#Emph}best {#Prev}moves and can't {#Emph}wait {#Prev}to try them in concert...!" },

				{ Cue = "/VO/MelinoeField_3589", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Go on and do it, then. Though I already know all the ways in which you're going to be stronger than you used to be." },

				{ Cue = "/VO/Scylla_0314",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You're just saying that to try and hurt us before we hurt {#Emph}you! {#Prev}An artist's job is to {#Emph}enthrall {#Prev}her audience... and we can't {#Emph}do {#Prev}that just by doing things the same old way, {#Emph}can {#Prev}we?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutShrineBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyDaggerHeat1GBoss",
							"BountyStaffHeat2GBoss",
							"BountySuitHeat4GBoss",
							"BountyLobHeat8GBoss",
							"BountyTorchHeat12GBoss",
							"BountyAxeHeat16GBoss",

							"BountyShrineStaffGBoss",
							"BountyShrineDaggerGBoss",
							"BountyShrineTorchGBoss",
							"BountyShrineAxeGBoss",
							"BountyShrineLobGBoss",
							"BountyShrineSuitGBoss",
						},
					},
				},
				{ Cue = "/VO/Scylla_0319",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Aww{#Prev}, lookit gals, our number one {#Emph}obsessive {#Prev}fan, come to ruin our show for {#Emph}everybody else! {#Prev}One day, we'll get our own {#Emph}big {#Prev}security team to {#Emph}take care {#Prev}of little incidents like this." },
				{ Cue = "/VO/MelinoeField_3594", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've little choice but to ruin your shows since you refuse to let me by... though this time at least I'm here for you, Scylla. The will of Night demands it." },
				{ Cue = "/VO/Scylla_0320",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh well that figures. Can't make it big without making some enemies! Well, our audience likes our shows no {#Emph}matter {#Prev}what happens. Like {#Emph}real {#Prev}fans! So {#Emph}do your worst, lady." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutShrineBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
				},
				{ Cue = "/VO/Scylla_0321",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Whew{#Prev}, got a good feeling about this evening's show, how about you gals? The crowd is {#Emph}all worked up! {#Prev}And look who else...!" },
				{ Cue = "/VO/MelinoeField_3595", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You likely sense the Testament of Night; those who threaten the Underworld are to be cast into obscurity. Such is law." },
				{ Cue = "/VO/Scylla_0322",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Obscurity? {#Prev}We've never been {#Emph}bigger! {#Prev}And our stars are rising with each and every performance. And we're about to make {#Emph}this {#Prev}one to remember!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutDiving01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 2 },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0330",
					Text = "You better {#Emph}work {#Prev}with us tonight, lady! There's a potential sponsor somewhere in the stands so we have {#Emph}got {#Prev}to put on a {#Emph}big show! {#Prev}Bigger than when you beat us normally." },
				{ Cue = "/VO/MelinoeField_3600", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not here to contribute to your misguided attempts to earn stardom, or sponsorships for that matter. You truly thought I'd let you beat me just because you asked?" },
				{ Cue = "/VO/Scylla_0331",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", PlayScyllaTauntAnim = true, WaitTime = 10 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I {#Emph}truly thought {#Prev}that you might have a shred of {#Emph}decency! {#Prev}Look, we are gonna start our {#Emph}song {#Prev}now, as we try to {#Emph}drown {#Prev}you, so just think about letting me and the gals {#Emph}have {#Prev}this one!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			-- alt below
			ScyllaAboutDiving02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutDiving01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutDiving02_B" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/MelinoeField_3601", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So did you get the sponsorship the other night? I still feel ashamed for losing to you last time simply because you asked somewhat nicely. There had better be some upside." },
				{ Cue = "/VO/Scylla_0332",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Ooh-hoo-hoo{#Prev}, we got our sponsorship all right, {#Emph}hmhm...! {#Prev}At least, we will eventually. Apparently our sponsor showed up just to see us take a {#Emph}dive! {#Prev}Since {#Emph}you've {#Prev}been messing up our {#Emph}shows {#Prev}night after night!" },
				{ Cue = "/VO/MelinoeField_3602", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're saying I let you beat me for absolutely {#Emph}no reason?" },
				{ Cue = "/VO/Scylla_0333",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", PlayScyllaTauntAnim = true, WaitTime = 9 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You didn't let us beat you, you just {#Emph}lost! {#Prev}You're getting soft and easier to drown. {#Emph}You {#Prev}don't have what it {#Emph}takes {#Prev}to succeed in this business! But {#Emph}we {#Prev}do." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaAboutDiving02_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutDiving01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ScyllaAboutDiving02" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/MelinoeField_3603", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So did you end up getting the sponsorship the other night? If your benefactor is interested in supporting you, they may as well know of your propensity to lose to me." },
				{ Cue = "/VO/Scylla_0334",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Ohh {#Prev}we got our sponsorship all right! Our sponsor showed up {#Emph}just {#Prev}to see us take a dive, since {#Emph}you've {#Prev}been messing up our shows night after night. And they {#Emph}loved {#Prev}what they saw!" },
				{ Cue = "/VO/MelinoeField_3604", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But you had asked me to hold back; to let you win. Your sponsor {#Emph}wanted {#Prev}you to lose?" },
				{ Cue = "/VO/Scylla_0335",
					PreLineFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Our sponsor wanted an {#Emph}authentic performance{#Prev}, and that's {#Emph}exactly {#Prev}what we delivered! What we're {#Emph}always {#Prev}going to deliver from now on! So {#Emph}do your worst{#Prev}, lady." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaQuickMatch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla01" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossScylla01", "ClearTime" },
								Comparison = "<=",
								Value = 25.0
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla02" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossScylla02", "ClearTime" },
								Comparison = "<=",
								Value = 25.0
							},
						},
					},
				},
				{ Cue = "/VO/Scylla_0323",
					Text = "Last time you crashed our show so fast the crowd was left {#Emph}pretty upset{#Prev}, lady! They {#Emph}hardly {#Prev}got to hear our {#Emph}song!" },
				{ Cue = "/VO/MelinoeField_3596", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your concert would perhaps get a more rousing response if you let me pass. Otherwise it's liable to end abruptly again." },
				{ Cue = "/VO/Scylla_0324",
					PreLineFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Ohoho{#Prev}, you don't know the {#Emph}first {#Prev}thing about theatrics! We want our crowd to experience a {#Emph}full {#Prev}range of emotions! So if that means {#Emph}occasional crushing disappointment{#Prev}, so be it...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaQuickMatch02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla01" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossScylla01", "ClearTime" },
								Comparison = "<=",
								Value = 25.0
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla02" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossScylla02", "ClearTime" },
								Comparison = "<=",
								Value = 25.0
							},
						},
					},
				},
				{ Cue = "/VO/Scylla_0325",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 7.3  },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh {#Prev}we won't let you make short work of us again, lady! So why don't you take your {#Emph}time! {#Prev}Bask in the atmosphere while we {#Emph}drown you in it!!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaNoHitMatch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla01" },
							},
							{
								PathFalse = { "PrevRun", "EncounterClearStats", "BossScylla01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossScylla02" },
							},
							{
								PathFalse = { "PrevRun", "EncounterClearStats", "BossScylla02", "TookDamage" },
							},
						},
					},
				},
				{ Cue = "/VO/Scylla_0326",
					Emote = "PortraitEmoteDepressed",
					Text = "We didn't get even a little {#Emph}nibble {#Prev}on you last you showed your face here, lady. I've been trying to console Roxy ever since! But it's no {#Emph}use!" },
				{ Cue = "/VO/MelinoeField_3597", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps if Roxy learned some new percussive patterns she'd have an easier time hitting me against my will." },
				{ Cue = "/VO/Scylla_0327",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", PlayScyllaTauntAnim = true, DoShake = true, WaitTime = 8.1 },
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Sure, try and tear us down all you like. But we're just gonna build back up, {#Emph}stronger than ever! {#Prev}And {#Emph}then! {#Prev}We'll bite your head clean off." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutGrandeur01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},
				{ Cue = "/VO/Scylla_0028_B",
					Text = "Don't worry, gals. One day? They'll put us up on the biggest stage, for {#Emph}all the world to see!" },
				{ Cue = "/VO/Melinoe_2043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not particularly interested in listening to your delusions of grandeur right now, so why not start your little song." },
				{ Cue = "/VO/Scylla_0029",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, it may be a little song to you {#Emph}now{#Prev}, lady. But it's going to be huge someday. You'll see. We'll show her, won't we, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Scylla_0342",
					Text = "Hey... maybe {#Emph}you {#Prev}know, lady! What happened to Mister Chronos? Lately he stopped answering our calls, {#Emph}heh. {#Prev}He's probably just taking a little break!" },
				{ Cue = "/VO/MelinoeField_4122", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You could say that. Lord Hades has returned as rightful ruler of the Underworld, which means Chronos now can attend to other matters. He'll likely get back to you." },
				{ Cue = "/VO/Scylla_0343",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "What are you, his {#Emph}personal assistant? Of course {#Prev}he's getting back to us! And if he's paying no attention to what happens in our venue in the meantime, {#Emph}even better." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusPostTrueEnding03", "ScyllaAboutChronos02" },
					},
				},
				{ Cue = "/VO/Scylla_0443",
					Text = "Still haven't heard from Mister Chronos lately. Have you seen him anywhere, lady? Because his sponsorship seems to have fizzled out... good thing we {#Emph}do {#Prev}have others." },
				{ Cue = "/VO/MelinoeField_4314", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lately Chronos has been over at the Isles of the Blessed. Off doing other things, like perhaps you should be. Who else is underwriting these performances of yours?" },
				{ Cue = "/VO/Scylla_0444",
					PostLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 8.2, PlayScyllaTauntAnim = true },
					Text = "Nobody you'd know, I'm sure! And what with all the changes lately, this venue isn't taking on new acts. You're stuck with only {#Emph}me, forever! {#Prev}Me and the gals." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					-- NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Scylla_0445",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Stop! {#Prev}Don't say {#Emph}anything{#Prev}, lady, it's impolite to talk during the show in case you hadn't noticed! I'm through listening to {#Emph}you {#Prev}anyway! But definitely not the {#Emph}other {#Prev}way around." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			-- repeatable / other general cases
			ScyllaMiscStart01 =
			{
				{ Cue = "/VO/Scylla_0036",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Lookit, gals! {#Prev}We've got ourselves a {#Emph}crowd! {#Prev}Oh, let's knock \n'em {#Emph}dead{#Prev}, what do you say?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart02 =
			{
				{ Cue = "/VO/Scylla_0037",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "All right. All right, gals, this is it, this is the big one! Our {#Emph}big break. {#Prev}Right here!!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart03 =
			{
				{ Cue = "/VO/Scylla_0038",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ooh{#Prev}, hey lady! We've been {#Emph}practicing! {#Prev}You want to hear our latest jam?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart04 =
			{
				{ Cue = "/VO/Scylla_0039",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You {#Emph}love {#Prev}a good show, don't you, lady? And we {#Emph}love {#Prev}to satisfy our fans! Don't we, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart05 =
			{
				{ Cue = "/VO/Scylla_0040",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "That's the power of our songs, gals! Once they {#Emph}hear {#Prev}'em, they can't tear themselves away...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart06 =
			{
				{ Cue = "/VO/Scylla_0041",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You just don't know when to {#Emph}quit{#Prev}, lady. Us neither! Hit it, gals!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart07 =
			{
				{ Cue = "/VO/Scylla_0042",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "See, gals? Oh, if it really wasn't working, she wouldn't keep coming back, would she?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart08 =
			{
				{ Cue = "/VO/Scylla_0043",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We're still practicing our latest number, lady! So you're {#Emph}just in time." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart09 =
			{
				{ Cue = "/VO/Scylla_0044",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Come make {#Emph}sweet music {#Prev}with us, lady! Sure beats whatever it is {#Emph}you {#Prev}do." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart10 =
			{
				{ Cue = "/VO/Scylla_0045",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You should hear some of our {#Emph}classic {#Prev}numbers, {#Emph}haha! {#Prev}Oh but first: {#Emph}our latest hit..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart11 =
			{
				{ Cue = "/VO/Scylla_0046",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Mm{#Prev}, don't normally play private events... but for you, lady? We'll do {#Emph}anything..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart12 =
			{
				{ Cue = "/VO/Scylla_0047",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We'd like to dedicate this next song to {#Emph}all our fans! {#Prev}Especially {#Emph}you{#Prev}, lady." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart13 =
			{
				{ Cue = "/VO/Scylla_0048",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Now, lady, let the music {#Emph}fill your soul{#Prev}, and the brine {#Emph}fill your lungs!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart14 =
			{
				{ Cue = "/VO/Scylla_0049",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I'd like to introduce Jetty on strings, and Roxy on percussion. Ready, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart15 =
			{
				{ Cue = "/VO/Scylla_0050",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Hello, Oceanus!! {#Prev}Oh, how's everybody doing tonight? You ready for a {#Emph}show?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart16 =
			{
				{ Cue = "/VO/Scylla_0051",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We love our fans! They just keep coming back, no matter what!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart17 =
			{
				{ Cue = "/VO/Scylla_0052",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You got something to say, lady, you save it till after the show..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart18 =
			{
				{ Cue = "/VO/Scylla_0053",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh don't take this personally, lady, but... we kinda got to drown our fans..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart19 =
			{
				{ Cue = "/VO/Scylla_0054",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I'd love to drag you to the bottom of the sea... but we're already here." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart20 =
			{
				{ Cue = "/VO/Scylla_0055",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I know it's dark down here, lady, so... just follow the {#Emph}sound of my voice..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart21 =
			{
				{ Cue = "/VO/Scylla_0420",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ooh{#Prev}, you {#Emph}know {#Prev}we're on a hot streak when our fans keep coming back!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart22 =
			{
				{ Cue = "/VO/Scylla_0422",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Jetty, Roxy, and I, we're thinking maybe we'll try going solo after this!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0422",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Jetty, Roxy, and I, we're thinking maybe we'll try going solo after this!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart24 =
			{
				{ Cue = "/VO/Scylla_0425",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Get off my {#Emph}stage{#Prev}, lady! You are not the star of this show, no matter {#Emph}what {#Prev}anybody thinks!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart25 =
			{
				{ Cue = "/VO/Scylla_0426",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Remember, gals, practice makes perfect, right? So, let's take it from the {#Emph}top! Again!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart26 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.05,
					},
				},
				{ Cue = "/VO/Scylla_0427",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I'm not listening to a word you say, lady! But {#Emph}you {#Prev}get to listen to {#Emph}us!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart27 =
			{
				{ Cue = "/VO/Scylla_0428",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Can't get enough of Scylla and the Sirens, huh? Well {#Emph}you {#Prev}are {#Emph}not {#Prev}alone!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart28 =
			{
				{ Cue = "/VO/Scylla_0429",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We've got a {#Emph}real {#Prev}crowd here tonight, but {#Emph}you {#Prev}get the {#Emph}best {#Prev}seat in the house!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart29 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0430",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You're not cut out to make it on this great big stage, lady! {#Emph}You'll see." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart30 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0431",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Our special guest made it {#Emph}all {#Prev}the way down from the surface, just to see {#Emph}you!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart31 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0432",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ohh{#Prev}, the crowd is gonna {#Emph}love {#Prev}this! We wouldn't be here if not for {#Emph}you{#Prev}, lady!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart32 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Scylla_0433",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Why don't you go and give our guest Charybdis a {#Emph}big {#Prev}hug to say hello?!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart33 =
			{
				{ Cue = "/VO/Scylla_0446",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Well, if it isn't our number one {#Emph}obsessive {#Prev}fan, come to spoil the show like always!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart34 =
			{
				{ Cue = "/VO/Scylla_0447",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Looks like we got a {#Emph}heckler{#Prev}, gals! Where's our security? {#Emph}Oh! {#Prev}It's {#Emph}right here..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart35 =
			{
				{ Cue = "/VO/Scylla_0448",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Every time you show your face around here, lady, you sink to a new low!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart36 =
			{
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "MusicName" },
						IsAny = { "/Music/IrisMusicScylla1_MC" },
					},
				},
				{ Cue = "/VO/Scylla_0450",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We figured we'd open with our first big hit tonight! What do you say, lady?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaMiscStartWonAgainstHer01 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0056",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Our big break's just around the corner, gals! So don't blow it now!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer02 =
			{
				PlayFirst = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0057",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Now, pull yourselves together and don't screw it up like {#Emph}last time! {#Prev}OK, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer03 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0421",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Don't muck it up for us again, Roxy, {#Emph}OK? {#Prev}Now count us in, dammit!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer04 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0423",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Aren't Jetty and Roxy {#Emph}just {#Prev}the best? I'd like them even more if they could {#Emph}do {#Prev}something for once!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer05 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Scylla" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0424",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Tough crowd tonight! But if they can't appreciate our artistry, we'll {#Emph}make {#Prev}'em!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer06 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 3 },
					},
				},
				{ Cue = "/VO/Scylla_0449",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "This is {#Emph}my {#Prev}stage, and this is {#Emph}my {#Prev}show, and you are {#Emph}not {#Prev}going to ruin it {#Emph}again!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
		},

		Using = {
			"/SFX/ScyllaCrowdApplause1",
			"/SFX/ScyllaCrowdApplause2",
			"/SFX/ScyllaCrowdCrappyWoo1",
			"/SFX/ScyllaCrowdCrappyWoo3",
			"/SFX/TheseusCrowdCheer",
		}
	},
}

-- Global Scylla Lines
GlobalVoiceLines.ScyllaGreetingLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.85,
		ObjectType = "Scylla",

		{ Cue = "/VO/Scylla_0058", Text = "{#Emph}Oohh...", PlayFirst = true },
		{ Cue = "/VO/Scylla_0059", Text = "{#Emph}Hello..." },
		{ Cue = "/VO/Scylla_0060", Text = "{#Emph}Hello...!" },
		{ Cue = "/VO/Scylla_0061", Text = "She came...!" },
		{ Cue = "/VO/Scylla_0062", Text = "Hey {#Emph}gals!" },
		{ Cue = "/VO/Scylla_0063", Text = "She's {#Emph}back." },
		{ Cue = "/VO/Scylla_0064", Text = "{#Emph}Aw{#Prev}, look who!" },
		{ Cue = "/VO/Scylla_0065", Text = "{#Emph}Showtime..." },
		{ Cue = "/VO/Scylla_0066", Text = "{#Emph}Lookit {#Prev}here..." },
		{ Cue = "/VO/Scylla_0067", Text = "You again..." },
		{ Cue = "/VO/Scylla_0068", Text = "{#Emph}Hmm..." },
		{ Cue = "/VO/Scylla_0069", Text = "{#Emph}Hoh!" },
		{ Cue = "/VO/Scylla_0070", Text = "{#Emph}Mmm, hmhmhmhm!" },
		{ Cue = "/VO/Scylla_0271", Text = "Excuse me?" },
		{ Cue = "/VO/Scylla_0272", Text = "How's everyone doing tonight?!" },
		{ Cue = "/VO/Scylla_0273", Text = "Check it out, gals!" },
		{ Cue = "/VO/Scylla_0274", Text = "{#Emph}All right..." },
		{ Cue = "/VO/Scylla_0275", Text = "We're on...!" },
		{ Cue = "/VO/Scylla_0276", Text = "{#Emph}Now {#Prev}we're ready!" },
		{ Cue = "/VO/Scylla_0277", Text = "You called it, Rox!" },
		{ Cue = "/VO/Scylla_0278", Text = "You followed our {#Emph}song!" },
		{ Cue = "/VO/Scylla_0345", Text = "{#Emph}<Chuckle>" },
		{ Cue = "/VO/Scylla_0346", Text = "Lady..." },
		{ Cue = "/VO/Scylla_0347", Text = "Lady?" },
		{ Cue = "/VO/Scylla_0348", Text = "Lady!" },
		{ Cue = "/VO/Scylla_0349", Text = "Look, everyone!" },
		{ Cue = "/VO/Scylla_0350", Text = "You...!" },
		{ Cue = "/VO/Scylla_0353", Text = "Got a {#Emph}great {#Prev}show tonight!" },
		{ Cue = "/VO/Scylla_0356", Text = "You ready, gals?" },
		{ Cue = "/VO/Scylla_0352", Text = "Please welcome {#Emph}this {#Prev}lady!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutAltFight01" }
				},
			},
		},
		{ Cue = "/VO/Scylla_0354", Text = "We're up in {#Emph}lights!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0355", Text = "It's our big break!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0357", Text = "Center stage...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0358", Text = "Charybdis, {#Emph}look {#Prev}who!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0359", Text = "We're all here...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0344", Text = "Oh, no...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 3 },
				},
			},
		},
		{ Cue = "/VO/Scylla_0351", Text = "{#Emph}Welcome{#Prev}, everyone!!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0215", Text = "Whoa, what is she {#Emph}wearing?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0058" }
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/Scylla_0216", Text = "Well {#Emph}that's {#Prev}a fashion choice...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0058" }
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/Scylla_0217", Text = "I like your outfit!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0058" }
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/Scylla_0270", Text = "Our number-one fan.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "G_PostBoss01" },
					Comparison = ">=",
					Value = 10,
				}
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.35,
		SuccessiveChanceToPlayAll = 0.33,
		UsePlayerSource = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ScyllaFirstMeeting" },
			},
			{
				Path = { "GameState", "EnemyKills", "Scylla" },
				Comparison = ">=",
				Value = 4,
			},
			NamedRequirementsFalse = { "NoGreetingToScylla" },
		},

		{ Cue = "/VO/Melinoe_1447", Text = "Still practicing, are we?" },
		{ Cue = "/VO/Melinoe_1448", Text = "I beat the crowds, did I?" },
		{ Cue = "/VO/Melinoe_1449", Text = "On with the show?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1450", Text = "From the top, then?" },
	},
}

GlobalVoiceLines.ScyllaShowStartVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		ObjectType = "Scylla",
		-- SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ScyllaAboutOdysseusQuest01" },
			},
		},
		Cooldowns =
		{
			{ Name = "ScyllaSpokeRecently", Time = 20 },
		},

		{ Cue = "/VO/Scylla_0299", Text = "This one's for those of you who thought they'd get away!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		ObjectType = "Scylla",
		-- SuccessiveChanceToPlayAll = 0.2,
		Cooldowns =
		{
			{ Name = "ScyllaSpokeRecently", Time = 20 },
		},

		{ Cue = "/VO/Scylla_0005", Text = "We're {#Emph}Scylla and the Sirens!", PlayFirst = true, },
		{ Cue = "/VO/Scylla_0071", Text = "One, two, three, {#Emph}four!" },
		{ Cue = "/VO/Scylla_0072", Text = "And, here we {#Emph}go!" },
		{ Cue = "/VO/Scylla_0073", Text = "And, go!" },
		{ Cue = "/VO/Scylla_0074", Text = "...Go!", PreLineWait = 1.2 },	
		{ Cue = "/VO/Scylla_0218", Text = "...Hit it, gals!", PreLineWait = 1.0 },
		{ Cue = "/VO/Scylla_0219", Text = "Let's {#Emph}kill {#Prev}it!", PreLineWait = 1.0 },
		{ Cue = "/VO/Scylla_0222", Text = "Sing along, everybody!" },
		{ Cue = "/VO/Scylla_0223", Text = "Showtime, gals!" },
		{ Cue = "/VO/Scylla_0224", Text = "It... is... {#Emph}showtime!" },
		{ Cue = "/VO/Scylla_0225", Text = "All right gals, from the {#Emph}top!" },
		{ Cue = "/VO/Scylla_0226", Text = "{#Emph}Hellooo Oceanus!!" },
		{ Cue = "/VO/Scylla_0227", Text = "How's everybody doing tonight??" },
		{ Cue = "/VO/Scylla_0366", Text = "Welcome to our show!" },
		{ Cue = "/VO/Scylla_0367", Text = "{#Emph}Come on{#Prev}, everybody!" },
		{ Cue = "/VO/Scylla_0368", Text = "Is everybody {#Emph}ready?!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs01" }
				},
			},
		},
		{ Cue = "/VO/Scylla_0369", Text = "{#Emph}Now!" },
		-- { Cue = "/VO/Scylla_0365", Text = "We've got a special someone in the audience tonight!" },
		{ Cue = "/VO/Scylla_0299", Text = "This one's for those of you who thought they'd get away!",
			GameStateRequirements =
			{
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "ScyllaAboutOdysseusQuest01" }, Min = 9 },
				},
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla1_MC" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0006", Text = "We are {#Emph}Scylla and the Sirens!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/Scylla_0005" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0007", Text = "This song's called {#Emph}Coral Crown!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla1_MC" },
				},
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/Scylla_0005" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0220", Text = "This song's called {#Emph}I Am Gonna Claw!",
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla2_MC" },
				},
				{
					PathFalse = { "CurrentRun", "TextLinesRecord", "ScyllaAboutSongs01" }
				},
			},
		},
		{ Cue = "/VO/Scylla_0221", Text = "This song's called {#Emph}I Am Gonna Claw (Out Your Eyes then Drown You to Death)!",
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla2_MC" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0220" }
				},
			},
		},
		{ Cue = "/VO/Scylla_0281", Text = "This song's called {#Emph}Rock and a Hard Place!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla3_MC" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0360", Text = "This song's called {#Emph}Rock and a Hard Place!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla3_MC" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0281" }
				},
			},
		},
		{ Cue = "/VO/Scylla_0438", Text = "This song's called {#Emph}Bewitching Eyes...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "AudioState", "MusicName" },
					IsAny = { "/Music/IrisMusicScylla4_MC" },
				},
			},
		},
		{ Cue = "/VO/Scylla_0362", Text = "Please welcome a {#Emph}very {#Prev}special guest!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0361", Text = "We're Scylla and the Sirens, with special guest {#Emph}Charybdis!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0281" }
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},

		{ Cue = "/VO/Scylla_0363", Text = "Welcome... {#Emph}Charybdis the Devouring!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Scylla_0364", Text = "Charybdis is here, everybody!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
	},
}

GlobalVoiceLines.ScyllaSirenKOReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "Scylla",
	Cooldowns =
	{
		{ Name = "ScyllaSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Scylla_0158", Text = "{#Emph}Hey!" },
	{ Cue = "/VO/Scylla_0160", Text = "Our {#Emph}sound!" },
	{ Cue = "/VO/Scylla_0385", Text = "{#Emph}Ohh...!" },
	{ Cue = "/VO/Scylla_0393", Text = "{#Emph}Stop {#Prev}that!" },
	{ Cue = "/VO/Scylla_0394", Text = "{#Emph}Cut {#Prev}that out!" },
	{ Cue = "/VO/Scylla_0395", Text = "Keep playing!" },
	{ Cue = "/VO/Scylla_0396", Text = "Play on!" },
	{ Cue = "/VO/Scylla_0400", Text = "{#Emph}Quit it!" },
	{ Cue = "/VO/Scylla_0401", Text = "What happened?!" },
	{ Cue = "/VO/Scylla_0397", Text = "Already?!",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredConsecutiveClearsOfRoom",
				FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 2 },
			},
		},
	},
	{ Cue = "/VO/Scylla_0398", Text = "{#Emph}Come on!",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredConsecutiveClearsOfRoom",
				FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 2 },
			},
		},
	},
	{ Cue = "/VO/Scylla_0399", Text = "Slow {#Emph}down!",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredConsecutiveClearsOfRoom",
				FunctionArgs = { Names = { "G_Boss01", "G_Boss02" }, Count = 2 },
			},
		},
	},
}

GlobalVoiceLines.ScyllaSirenRallyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.75,
	Source = { LineHistoryName = "NPC_Scylla_01", SubtitleColor = Color.ScyllaVoice },
	-- SuccessiveChanceToPlayAll = 0.75,
	TriggerCooldowns = { "ScyllaSpokeRecently" },

	{ Cue = "/VO/Scylla_0173", Text = "Free admission!" },
	{ Cue = "/VO/Scylla_0174", Text = "Here {#Emph}fishy-fishy!" },
	{ Cue = "/VO/Scylla_0175", Text = "This is it!", PlayFirst = true },
	{ Cue = "/VO/Scylla_0176", Text = "One last {#Emph}verse!" },
	{ Cue = "/VO/Scylla_0177", Text = "Feel the beat!" },
	{ Cue = "/VO/Scylla_0178", Text = "{#Emph}Encore!!" },
	{ Cue = "/VO/Scylla_0164", Text = "Back on your fins!" },
	{ Cue = "/VO/Scylla_0166", Text = "Get it {#Emph}together{#Prev}, gals!" },
	{ Cue = "/VO/Scylla_0167", Text = "Get off your {#Emph}tails{#Prev}, gals!" },
	{ Cue = "/VO/Scylla_0169", Text = "{#Emph}Hah{#Prev}, show's not over {#Emph}yet!" },
	{ Cue = "/VO/Scylla_0402", Text = "{#Emph}...And {#Prev}we're back!" },
	{ Cue = "/VO/Scylla_0403", Text = "Let's finish {#Emph}strong!" },
	{ Cue = "/VO/Scylla_0404", Text = "All of you wake {#Emph}up!" },
	{ Cue = "/VO/Scylla_0405", Text = "Play on, dammit!" },
	{ Cue = "/VO/Scylla_0406", Text = "We're {#Emph}back!" },
	{ Cue = "/VO/Scylla_0407", Text = "We're {#Emph}on!!" },
	{ Cue = "/VO/Scylla_0408", Text = "{#Emph}Come on{#Prev}, everyone!" },
	{ Cue = "/VO/Scylla_0409", Text = "Now, {#Emph}snap out of it!" },
	{ Cue = "/VO/Scylla_0410", Text = "Back on your fins!" },
	{ Cue = "/VO/Scylla_0411", Text = "Still got it!" },
	{ Cue = "/VO/Scylla_0168", Text = "Both of you get {#Emph}up!", PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/Scylla_0163", Text = "Get back in it, you two!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/Scylla_0165", Text = "Roxy, Jetty, {#Emph}now!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/Scylla_0170", Text = "{#Emph}Now{#Prev}, you two!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/Scylla_0171", Text = "{#Emph}Come on{#Prev}, Sirens!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/Scylla_0172", Text = "Come on, you {#Emph}Pinheads!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Scylla_0171" }
			},
		}
	},
}

GlobalVoiceLines.ScyllaSirenDeathReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "Scylla",
	Cooldowns =
	{
		{ Name = "ScyllaSpokeRecently", Time = 16 },
	},

	{ Cue = "/VO/Scylla_0183", Text = "{#Emph}Oh{#Prev}, come {#Emph}on!" },
	{ Cue = "/VO/Scylla_0184", Text = "That's {#Emph}not {#Prev}part of the {#Emph}act!" },
	{ Cue = "/VO/Scylla_0185", Text = "What did you {#Emph}do {#Prev}to her?" },
	{ Cue = "/VO/Scylla_0186", Text = "No {#Emph}fair!!" },
	{ Cue = "/VO/Scylla_0187", Text = "{#Emph}Damn it{#Prev}, Sirens!" },
	{ Cue = "/VO/Scylla_0188", Text = "Guess it's all up to me!",
		PlayFirst = true,
		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "CurrentRun", "EnemyKills" },
						HasAll = { "SirenKeytarist", "SirenDrummer" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},

				},
				{
					{
						Path = { "CurrentRun", "EnemyKills" },
						HasAll = { "SirenKeytarist", "SirenDrummer", "Charybdis_ScyllaFight" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
	},
}
GlobalVoiceLines.ScyllaCharybdisDeathReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		SuccessiveChanceToPlayAll = 0.75,
		ObjectType = "Scylla",
		TriggerCooldowns = { "ScyllaSpokeRecently" },

		{ Cue = "/VO/Scylla_0380", Text = "Charybdis, {#Emph}how?!" },
		{ Cue = "/VO/Scylla_0381", Text = "No, {#Emph}Charybdis!!" },
		{ Cue = "/VO/Scylla_0382", Text = "Charybdis?!" },
		{ Cue = "/VO/Scylla_0383", Text = "Charybdis!" },
		{ Cue = "/VO/Scylla_0384", Text = "Our special guest!" },
	},
},

OverwriteTableKeys( EnemyData, UnitSetData.Scylla )