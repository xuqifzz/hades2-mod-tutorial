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
		Groups = { "NPCs" },
		SubtitleColor = Color.ScyllaVoice,
		AnimOffsetZ = -80,
		MaxHealth = 6550,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,
		HealthBarOffsetY = -240,
		SpeakerName = "Scylla",
		Material = "Organic",
		HealthBarTextId = "Scylla_Full",

		MusicStem = "Vocals",
		MusicStemOff = true,

		InvulnerableFx = "Invincibubble_Scylla",
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		--InvulnerableHitFx = "TurtleInvincibubbleHit",
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

		Groups = { "GroundEnemies" },
		ClearChillOnDeath = true,
		GroupHealthBarOwner = true,

		OnDeathFunctionName = "ScyllaKillPresentation",
		OnDeathFunctionArgs = { Message = "SirensDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, FlashDuration = 0.45, AddInterBiomeTimerBlock = true },

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
		--WeaponOptions = { "ScyllaNotes", "ScyllaSpin" },
		WeaponOptions = { "ScyllaBelt", "ScyllaClamUp", "ScyllaSpin", "ScyllaWhip", "ScyllaNotes" }, 
		
		--IdleAIAnimation = "Enemy_Scylla_ClamDefenseIntro",

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
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = true,
				TransitionAnimation = "Enemy_Scylla_ClamDefenseReturnToIdle",
				WaitDuration = 1.5,
				LowPassOff = true,
				AIData =
				{
					AIEndHealthThreshold = 0.2,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ScyllaBelt", "ScyllaWhip", "ScyllaClamUp", "ScyllaNotes", "ScyllaSpotlightPassive", "ScyllaSpotlightCombo",  },
				ThreadedEvents =
				{
					{ FunctionName = "ApplyScyllaFightSpotlight", GameStateRequirements = { },
						Args =
						{
							Flags =
							{
								{ FlagName = "ScyllaBoost", Id = 557843,
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
										},
										[2] = GlobalVoiceLines.ScyllaSirenRallyVoiceLines,
									},

								},
								{ FlagName = "DrummerBoost", Id = 558409, SoloMusicFunction = "SoloSirenDrummer",
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
										},
										[2] = GlobalVoiceLines.ScyllaSirenRallyVoiceLines,
									},
								},
								{ FlagName = "KeytaristBoost", Id = 569244, SoloMusicFunction = "SoloSirenKeytarist",
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
										},
										[2] = GlobalVoiceLines.ScyllaSirenRallyVoiceLines,
									},

								},
							}
						}
					},
				}
			},
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
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = true,
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
			GameStateRequirements =
			{
			},
			--
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
			},
		},

		OnKillVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
			[2] =
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 7.8,
				SuccessiveChanceToPlayAll = 0.66,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1098", Text = "That's quite enough of {#Emph}them.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1099", Text = "Blasted catchy song..." },
				{ Cue = "/VO/Melinoe_1100", Text = "Show's over." },
				{ Cue = "/VO/Melinoe_1101", Text = "That was awkward..." },
				{ Cue = "/VO/Melinoe_1102", Text = "Finally..." },
				{ Cue = "/VO/Melinoe_1103", Text = "They just won't shut up..." },
				{ Cue = "/VO/MelinoeField_0098", Text = "Peace and quiet." },
				{ Cue = "/VO/MelinoeField_0099", Text = "...I hate her." },
				{ Cue = "/VO/MelinoeField_0100", Text = "Keep practicing!" },
				{ Cue = "/VO/MelinoeField_0101", Text = "Sing about that..." },
				{ Cue = "/VO/MelinoeField_0102", Text = "That's for last night.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "RoomCountCache", "G_Boss01" },
						},
						{
							PathFalse = { "PrevRun", "RoomCountCache", "G_PostBoss01", },
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
					Emote = "PortraitEmoteSparkly", Speaker = "NPC_Scylla_01",
					Text = "It's the perfect pressure down here! Beats the pressure trying to make art while all our fans are watching, begging, {#Emph}Scylla, where's your next song?!" },
				{ Cue = "/VO/Melinoe_0499", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't you drown your so-called fans to death? Have you even got any left?" },
				{ Cue = "/VO/Scylla_0004", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh don't {#Emph}ever {#Prev}say {#Emph}such things {#Prev}about our {#Emph}fans! {#Prev}Oh hey gals...? What say we give her the {#Emph}old song and dance?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAmbitions01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0008", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}I knew it! {#Prev}She's come {#Emph}back! {#Prev}You ready for another show, lady? We've been rehearsing our material, practicing nonstop, because one day? I'm gonna be a {#Emph}star! {#Prev}Oh, me and the gals!" },
				{ Cue = "/VO/Melinoe_1042", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What do your musical ambitions have to do with unprovoked acts of violence against {#Emph}me?" },
				{ Cue = "/VO/Scylla_0009", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "She's just heckling us, gals, ignore her, and take it from the top, {#Emph}two, three, four...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutAmbitions02 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0010", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh, always wanted to sing in front of a great big crowd, you know? And not just a bunch of crusty sailors, but like, one of those gigantic {#Emph}amphitheaters {#Prev}they got up on land!" },
				{ Cue = "/VO/Melinoe_1828", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not my area of expertise. Do performances in these amphitheaters typically involve attempts to drown the members of the audience?" },
				{ Cue = "/VO/Scylla_0011", Speaker = "NPC_Scylla_01",
					PreLineFunctionName = "PlayScyllaTauntAnim",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 8.1 },
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
				{ Cue = "/VO/Scylla_0023", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Don't {#Prev}listen to her, gals! Your backup vocals are the backbone of this act! I've got the voice, {#Emph}you've {#Prev}got the music, we've got {#Emph}the magick! {#Prev}Let's give her a little taste, huh?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutStage01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0016", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "Just can't get enough of us, {#Emph}can {#Prev}you, lady? Oh, it's OK, happens to everybody, especially sailors, we're just that {#Emph}good! {#Prev}Do you sail?" },
				{ Cue = "/VO/Melinoe_2040", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your self-confidence is enviable, but I'm only here because I have to get past this ridiculous stage. So why don't we skip the show." },
				{ Cue = "/VO/Scylla_0017", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh I got a better idea: Why don't we {#Emph}start {#Prev}the show? All we needed was a little audience, and we've got {#Emph}you {#Prev}right where we want you." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutReputation01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0012", Speaker = "NPC_Scylla_01",
					Text = "They say... our songs are {#Emph}to die for{#Prev}, but lately we don't get a lot of company. Oh, you wouldn't know anything about {#Emph}that{#Prev}, right? Because {#Emph}somebody's {#Prev}been smearing our good name..." },
				{ Cue = "/VO/Melinoe_1043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your reputation is yours to build or ruin. Doubt anyone I know has even heard of you, besides." },
				{ Cue = "/VO/Scylla_0013", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Come on, gals! Let's go {#Emph}all out {#Prev}again before the crowd shows up! They're {#Emph}going {#Prev}to show up! I just {#Emph}know {#Prev}it!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutSurvey01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0021", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh hey, as one of our fans, {#Emph}what {#Prev}would you say is the best thing about Scylla and the Sirens, {#Emph}hm? {#Prev}Our latest hit song? Our impeccable style?" },
				{ Cue = "/VO/Melinoe_2039", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your sense of style isn't really to my taste, that I can say for certain." },
				{ Cue = "/VO/Scylla_0022", Speaker = "NPC_Scylla_01",
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
				{ Cue = "/VO/Scylla_0014", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ooh good! {#Prev}You're just in time for our set! Been working on a song called {#Emph}I'm Gonna Claw (Out Your Eyes then Drown You to Death), heh! {#Prev}Comes from a real personal place." },
				{ Cue = "/VO/Melinoe_1829", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is it any better than the one I heard on my way in?" },
				{ Cue = "/VO/Scylla_0015", Speaker = "NPC_Scylla_01",
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
				},
				{ Cue = "/VO/Scylla_0138", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "How did you like our latest song, lady? Be honest! There's no right {#Emph}or {#Prev}wrong answer, OK? We {#Emph}thrive {#Prev}on feedback from our fans!" },
				{ Cue = "/VO/MelinoeField_2017", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you seek feedback from your fans, ask them. As for me, I felt the chorus was catchy enough, but the lyrics and their disturbing themes were rather distracting." },
				{ Cue = "/VO/Scylla_0139", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Disturbing? Distracting?! {#Emph}Compelling! That's {#Prev}what good music {#Emph}is{#Prev}. That's what Scylla and the Sirens {#Emph}are! {#Prev}As for our song, {#Emph}hee! {#Prev}You'll understand it better if you give it {#Emph}another {#Prev}listen..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaAboutChlams01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Scylla_0018", Speaker = "NPC_Scylla_01",
					Text = "Oh hey gals, guess who?! It's the {#Emph}one that got away{#Prev}, that's who! {#Emph}Mm{#Prev}, something you ought to know about me, lady... is once I catch 'em... I never let 'em go." },
				{ Cue = "/VO/Melinoe_2037", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That comes as no surprise to me at all. Some sea creatures are famously clingy. Barnacles, chlams..." },
				{ Cue = "/VO/Scylla_0019", Speaker = "NPC_Scylla_01",
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Now, see here! I'd no intention to offend last time, and never said you {#Emph}were {#Prev}a chlam. The least you could do is base your anger in reality." },
				{ Cue = "/VO/Scylla_0020", Speaker = "NPC_Scylla_01",
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
						PathTrue = { "PrevRun", "EncountersCompletedCache", "BossScylla01" },
					},
				},
				{ Cue = "/VO/Scylla_0026", Speaker = "NPC_Scylla_01",
					Text = "{#Emph}Hohh, {#Prev}surprised to see us again, lady? {#Emph}Heh, {#Prev}'cause we're not going anywhere. This is our big {#Emph}comeback tour{#Prev}, after all!" },
				{ Cue = "/VO/Melinoe_2042", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I thought I dealt with you last time, yet here you are. Am I going to have to drive you back into the sea?" },
				{ Cue = "/VO/Scylla_0027", Speaker = "NPC_Scylla_01",
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
				{ Cue = "/VO/Scylla_0140", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ohh{#Prev}, you keep trying to {#Emph}kill {#Prev}me, lady! The former sea-nymph side of me says {#Emph}just forget it {#Prev}and move on! But, I don't like to listen to her anymore." },
				{ Cue = "/VO/MelinoeField_2018", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That you don't listen to yourself explains a lot. I know better than to try and kill an Oceanid, former or not. I just need you to get out of my way." },
				{ Cue = "/VO/Scylla_0141", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Hear that gals? I distinctly heard the lady say {#Emph}I need you {#Prev}there, {#Emph}hoho! {#Prev}Our art changes lives! What say we change {#Emph}this {#Prev}one right {#Emph}now...?" },
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
				{ Cue = "/VO/Scylla_0024", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSparkly",
					Text = "So tell me, lady, {#Emph}how is it {#Prev}that you seem to know our tricks? Other than the part where we keep playing the same act. Usually it slays!" },
				{ Cue = "/VO/Melinoe_2041", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Great Tactician Odysseus says hello. Told me all about you. You claim you never let anybody get away, though {#Emph}I {#Prev}understand all but six of his hapless men got well away from you." },
				{ Cue = "/VO/Scylla_0025", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Odysseus, hah! {#Prev}Oh, {#Emph}he's {#Prev}still on the hook! Big fish like that just {#Emph}takes a while to reel in{#Prev}, as he might say. Our song must still be bouncing around in his {#Emph}pretty {#Prev}little head! And now for yours..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			ScyllaLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Scylla_0028", Speaker = "NPC_Scylla_01",
					Text = "Oh no, you're bleeding. Trouble finding the place? Don't worry, gals. One day? They'll put us up on the biggest stage, for {#Emph}all the world to see!" },
				{ Cue = "/VO/Melinoe_2043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not particularly interested in listening to your delusions of grandeur right now, so why not start your little song." },
				{ Cue = "/VO/Scylla_0029", Speaker = "NPC_Scylla_01",
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

					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Scylla_0030", Speaker = "NPC_Scylla_01",
					Text = "Oh you know, this is a reputable venue, lady, and we {#Emph}do {#Prev}impose a dress code at the door, {#Emph}hm-hm! {#Prev}Oh, but you come barging in, looking like hell." },
				{ Cue = "/VO/Melinoe_2044", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sea-dwellers are not so welcoming to strangers in your habitat. Thus I'm a bit unkempt. And a bit low on patience..." },
				{ Cue = "/VO/Scylla_0031", Speaker = "NPC_Scylla_01",
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
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Scylla_0032", Speaker = "NPC_Scylla_01",
					Text = "The sea can be a dangerous place if you don't know your way around, lady! {#Emph}Ohoho! {#Prev}Though it looks like you figured that out all on your own!" },
				{ Cue = "/VO/Melinoe_2045", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Everything is damp, and reeks to the heavens. And now I'm forced to listen to {#Emph}your {#Prev}snide remarks. And your insufferable song, I suppose?" },
				{ Cue = "/VO/Scylla_0033", Speaker = "NPC_Scylla_01",
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
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Scylla_0034", Speaker = "NPC_Scylla_01",
					Text = "Aw lookit, gals, she's hurt! She's already hurt {#Emph}real bad{#Prev}. Maybe we could ease her passing with a little {#Emph}music{#Prev}, huh?" },
				{ Cue = "/VO/Melinoe_2046", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I assure you any pain I'm experiencing is nothing compared with the pain I'll inflict on {#Emph}you {#Prev}if you continue to cross me." },
				{ Cue = "/VO/Scylla_0035", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Still got some fight left in you, huh? Well good, 'cause we just hate a passive audience! Come on, get in the pit, lady! The show's about to start!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

			-- Repeatable / other general cases
			ScyllaMiscStart01 =
			{
				{ Cue = "/VO/Scylla_0036", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Lookit, gals! {#Prev}We've got ourselves a {#Emph}crowd! {#Prev}Oh, let's knock \n'em {#Emph}dead{#Prev}, what do you say?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart02 =
			{
				{ Cue = "/VO/Scylla_0037", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "All right. All right, gals, this is it, this is the big one! Our {#Emph}big break. {#Prev}Right here!!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart03 =
			{
				{ Cue = "/VO/Scylla_0038", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ooh{#Prev}, hey lady! We've been {#Emph}practicing! {#Prev}You want to hear our latest jam?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart04 =
			{
				{ Cue = "/VO/Scylla_0039", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You {#Emph}love {#Prev}a good show, don't you, lady? And we {#Emph}love {#Prev}to satisfy our fans! Don't we, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart05 =
			{
				{ Cue = "/VO/Scylla_0040", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "That's the power of our songs, gals! Once they {#Emph}hear {#Prev}'em, they can't tear themselves away...!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart06 =
			{
				{ Cue = "/VO/Scylla_0041", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You just don't know when to {#Emph}quit{#Prev}, lady. Us neither! Hit it, gals!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart07 =
			{
				{ Cue = "/VO/Scylla_0042", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "See, gals? Oh, if it really wasn't working, she wouldn't keep coming back, would she?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart08 =
			{
				{ Cue = "/VO/Scylla_0043", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We're still practicing our latest number, lady! So you're {#Emph}just in time." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart09 =
			{
				{ Cue = "/VO/Scylla_0044", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Come make {#Emph}sweet music {#Prev}with us, lady! Sure beats whatever it is {#Emph}you {#Prev}do." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart10 =
			{
				{ Cue = "/VO/Scylla_0045", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You should hear some of our {#Emph}classic {#Prev}numbers, {#Emph}haha! {#Prev}Oh but first: {#Emph}our latest hit..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart11 =
			{
				{ Cue = "/VO/Scylla_0046", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Mm{#Prev}, don't normally play private events... but for you, lady? We'll do {#Emph}anything..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart12 =
			{
				{ Cue = "/VO/Scylla_0047", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We'd like to dedicate this next song to {#Emph}all our fans! {#Prev}Especially {#Emph}you{#Prev}, lady." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart13 =
			{
				{ Cue = "/VO/Scylla_0048", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Now, lady, let the music {#Emph}fill your soul{#Prev}, and the brine {#Emph}fill your lungs!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart14 =
			{
				{ Cue = "/VO/Scylla_0049", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I'd like to introduce Jetty on strings, and Roxy on percussion. Ready, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart15 =
			{
				{ Cue = "/VO/Scylla_0050", Speaker = "NPC_Scylla_01",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Hello, Oceanus!! {#Prev}Oh, how's everybody doing tonight? You ready for a {#Emph}show?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart16 =
			{
				{ Cue = "/VO/Scylla_0051", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "We love our fans! They just keep coming back, no matter what!" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart17 =
			{
				{ Cue = "/VO/Scylla_0052", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "You got something to say, lady, you save it till after the show..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart18 =
			{
				{ Cue = "/VO/Scylla_0053", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Oh don't take this personally, lady, but... we kinda got to drown our fans..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart19 =
			{
				{ Cue = "/VO/Scylla_0054", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I'd love to drag you to the bottom of the sea... but we're already here." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStart20 =
			{
				{ Cue = "/VO/Scylla_0055", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "I know it's dark down here, lady, so... just follow the {#Emph}sound of my voice..." },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},
			ScyllaMiscStartWonAgainstHer01 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "BossScylla01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0056", Speaker = "NPC_Scylla_01",
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
						Path = { "GameState", "LastBossHealthBarRecord", "BossScylla01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Scylla_0057", Speaker = "NPC_Scylla_01",
					PreLineThreadedFunctionName = "PlayScyllaTauntAnim",
					PostLineFunctionName = "StartBossRoomMusic",
					Text = "Now, pull yourselves together and don't screw it up like {#Emph}last time! {#Prev}OK, gals?" },
				EndGlobalVoiceLines = "ScyllaShowStartVoiceLines",
			},

		},

		Using = {
			"/SFX/ScyllaCrowdApplause1",
			"/SFX/ScyllaCrowdApplause2",
			"/SFX/ScyllaCrowdCrappyWoo1",
			"/SFX/ScyllaCrowdCrappyWoo3"
		}
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Scylla )