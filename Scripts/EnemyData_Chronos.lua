UnitSetData.Chronos =
{
	Chronos =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Chronos_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.ChronosVoice,
		SpeakerName = "Chronos",

		MaxHealth = 20000,
		Phases = 2,
		AISetupDelay = 4.5,
		ChronosFightStartMoveId = 704968,
		
		SpawnAnimation = "Enemy_Chronos_SittingIdle",
		--InvulnerableFx = "Invincibubble_Scylla",
		InvulnerableFx = "ChronosInvincibubble",
		SpeechCooldownTime = 11,
		Groups = { "GroundEnemies" },
		BlockPostBossMetaUpgrades= true,
		OnDeathFunctionName = "ChronosKillPresentation",
		OnDeathFunctionArgs = { Message = "ChronosDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, FlashDuration = 0.45, AddInterBiomeTimerBlock = true, EndAngle = 210, KillerEndAngle = 30, KillerTeleportId = 609240, VictimTeleportId = 713403,},

		DeathAnimation = "Enemy_Chronos_BattleOutro_End",
		DeathPanOffsetY = -140,
		--DeathFx = "CerberusTeleportCloud",
		DeathAngle = 210,

		OnHitFlash = { MaxFraction = 0.45 },

		Material = "Organic",
		HealthBarTextId = "Chronos_Full",

		--ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		--OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "Chronos360BlockFront",
		
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,

		IgnoreTimeSlowEffects = true,
		AIWakeDelay = 1.00,
		PreBossAISetupFunctionName = "ChronosBattleStart",
		DefaultAIData =
		{
			--DashIfOverDistance = 1000,
			--DashWeapon = "ChronosRush",
			SpawnCountDampenTraits = { HadesChronosDebuffBoon = true, },
			MoveWithinRangeTimeout = 8.0,
		},
		WeaponOptions = {
			"ChronosDash", "ChronosBannerSummon", "ChronosGrind",
			"ChronosRush", "ChronosSwingRight", "ChronosSwingLeft",
			"ChronosScytheThrow", "ChronosCastOrbit",
			--"ChronosRushCombo",

			"ChronosScytheThrow", "ChronosRush",
		},
		
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					IgnoreTimeSlowEffects = false,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
					},
				},
			},
			{
				FunctionName = "CheckElapsedTimeMultiplierIgnores",
			},
		},
		AIEndHealthThreshold = 0.75,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.75,
				},		
			},
			-- 1.25
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense",
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- 1.5
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDash",
				UnequipAllWeapons = true,
				EquipWeapons = {
					"ChronosDash", "ChronosBannerSummon", "ChronosGrind",
					"ChronosMeleeComboSelector", "ChronosMeleeComboSelector", "ChronosMeleeComboSelector",
					"ChronosScytheThrow", "ChronosCastOrbit",
				},
				AIData =
				{
					AIEndHealthThreshold = 0.25,
				},
			},
			-- 1.75
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense3",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosPhaseTransition",
				WipeEnemyTypes = { "BattleStandardChronos" },
				NewMaxHealth = 16000,
				UnequipAllWeapons = true,
				EquipWeapons = {
					"ChronosRush", "ChronosSwingRight", "ChronosSwingLeft",
					"ChronosGrind",
					"ChronosScytheThrow", "ChronosCastOrbit2",
					"ChronosUltimate",
					"ChronosRadial","ChronosRadial2", "ChronosRadial3"
				},
				DumbFireWeapons = { "ChronosRadialIn" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- 2.5
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense2",
				SetMapFlags = { 
					{ FlagName = "ChronosRoomWeapons2" },
				},
				UnequipAllWeapons = true,
				EquipWeapons = {
					"ChronosMeleeComboSelector", "ChronosMeleeComboSelector", "ChronosMeleeComboSelector",
					"ChronosGrind",
					"ChronosScytheThrow", "ChronosCastOrbit2",
					--"ChronosUltimate",
					"ChronosRadial","ChronosRadial2", "ChronosRadial3"
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.15,
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 18 },
			},

			{ Cue = "/VO/Chronos_0311", Text = "A lasting pain..." },
			{ Cue = "/VO/Chronos_0312", Text = "It lingers, does it not?" },
			{ Cue = "/VO/Chronos_0313", Text = "Wither..." },
			{ Cue = "/VO/Chronos_0314", Text = "Begone..." },
			{ Cue = "/VO/Chronos_0315", Text = "Begone from here..." },
			{ Cue = "/VO/Chronos_0316", Text = "You shall be cut in twain..." },
			{ Cue = "/VO/Chronos_0317", Text = "You shall be brought to heel!" },
			{ Cue = "/VO/Chronos_0318", Text = "Expire..." },
			{ Cue = "/VO/Chronos_0319", Text = "Not so fast..." },
			{ Cue = "/VO/Chronos_0320", Text = "You cannot run forever..." },
			{ Cue = "/VO/Chronos_0321", Text = "Heedless whelp." },
			{ Cue = "/VO/Chronos_0322", Text = "Impetuous of you..." },
			{ Cue = "/VO/Chronos_0323", Text = "There..." },
			{ Cue = "/VO/Chronos_0324", Text = "Prepared for more?" },
			{ Cue = "/VO/Chronos_0325", Text = "What now?" },
			{ Cue = "/VO/Chronos_0326", Text = "How daft you are..." },
			{ Cue = "/VO/Chronos_0327", Text = "Learn some respect!" },
			{ Cue = "/VO/Chronos_0328", Text = "You had it coming." },
			{ Cue = "/VO/Chronos_0329", Text = "We are not done." },
			{ Cue = "/VO/Chronos_0330", Text = "Another, then?" },
			{ Cue = "/VO/Chronos_0331", Text = "Relent." },
			{ Cue = "/VO/Chronos_0332", Text = "Relent, blast you!" },
			{ Cue = "/VO/Chronos_0333", Text = "Embarrassing." },
			{ Cue = "/VO/Chronos_0334", Text = "Get from this hall." },
			{ Cue = "/VO/Chronos_0335", Text = "Time takes all." },
			{ Cue = "/VO/Chronos_0336", Text = "Too slow, my girl..." },
			{ Cue = "/VO/Chronos_0337", Text = "Alas, my girl..." },
			{ Cue = "/VO/Chronos_0338", Text = "My scythe shall find you." },
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
					{ Name = "ChronosLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Chronos_0291", Text = "Still you resist...?" },
				{ Cue = "/VO/Chronos_0292", Text = "Not finished yet?" },
				{ Cue = "/VO/Chronos_0293", Text = "Our family's favorite trick..." },
				{ Cue = "/VO/Chronos_0294", Text = "Your strength shall fail you..." },
				{ Cue = "/VO/Chronos_0295", Text = "But one more cut or two..." },
				{ Cue = "/VO/Chronos_0296", Text = "You only make things worse!" },
				{ Cue = "/VO/Chronos_0297", Text = "Oh, please." },
				{ Cue = "/VO/Chronos_0298", Text = "My girl, would you please die?" },
				{ Cue = "/VO/Chronos_0299", Text = "Am I supposed to be impressed?" },
				{ Cue = "/VO/Chronos_0300", Text = "Youthful vigor, nothing more." },
				{ Cue = "/VO/Chronos_0301", Text = "Time is running out..." },
				{ Cue = "/VO/Chronos_0302", Text = "Time grows short..." },
				{ Cue = "/VO/Chronos_0303", Text = "Oh-{#Emph}ho...!" },
				{ Cue = "/VO/Chronos_0304", Text = "Ah-{#Emph}hah...!" },
				{ Cue = "/VO/Chronos_0305", Text = "{#Emph}<Laugh>" },
				{ Cue = "/VO/Chronos_0306", Text = "{#Emph}<Chuckle>" },
			},
		},
		BlockDeathReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Chronos_0307", Text = "A few last moments, then?" },
				{ Cue = "/VO/Chronos_0308", Text = "This is the end for you." },
				{ Cue = "/VO/Chronos_0309", Text = "You have already lost." },
				{ Cue = "/VO/Chronos_0310", Text = "Have you no dignity at all?" },
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
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.25,
				},
			},
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 18 },
			},

			{ Cue = "/VO/Chronos_0339", Text = "How frightening." },
			{ Cue = "/VO/Chronos_0340", Text = "{#Emph}Ooh{#Prev}, how fierce." },
			{ Cue = "/VO/Chronos_0341", Text = "Oh dear." },
			{ Cue = "/VO/Chronos_0342", Text = "Oh no...!" },
			{ Cue = "/VO/Chronos_0343", Text = "Shall that be all?" },
			{ Cue = "/VO/Chronos_0344", Text = "Tut-tut...!" },
			{ Cue = "/VO/Chronos_0345", Text = "Do cut it out?" },
			{ Cue = "/VO/Chronos_0346", Text = "That shall not work..." },
			{ Cue = "/VO/Chronos_0347", Text = "Embarrassing..." },
			{ Cue = "/VO/Chronos_0348", Text = "Are you quite done?" },
			{ Cue = "/VO/Chronos_0349", Text = "{#Emph}Uh-uh!" },
			{ Cue = "/VO/Chronos_0350", Text = "Alas..." },
			{ Cue = "/VO/Chronos_0014", Text = "I think not." },
			{ Cue = "/VO/Chronos_0094", Text = "Oh, please..." },
			{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
			{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
			{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
			{ Cue = "/VO/Chronos_0098", Text = "I can wait..." },
			{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught." },
			{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!" },
			{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!" },
		},
		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.2,
				},
			},
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 3 },
			},
			{ Cue = "/VO/Chronos_0342", Text = "Oh no...!" },
			{ Cue = "/VO/Chronos_0343", Text = "Shall that be all?" },
			{ Cue = "/VO/Chronos_0344", Text = "Tut-tut...!" },
			{ Cue = "/VO/Chronos_0345", Text = "Do cut it out?" },
			{ Cue = "/VO/Chronos_0346", Text = "That shall not work..." },
			{ Cue = "/VO/Chronos_0347", Text = "Embarrassing..." },
			{ Cue = "/VO/Chronos_0348", Text = "Are you quite done?" },
			{ Cue = "/VO/Chronos_0349", Text = "{#Emph}Uh-uh!" },
			{ Cue = "/VO/Chronos_0350", Text = "Alas..." },
			{ Cue = "/VO/Chronos_0014", Text = "I think not." },
			{ Cue = "/VO/Chronos_0094", Text = "Oh, please..." },
			{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
			{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
			{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
		},

		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.05,
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 18 },
			},				
			GameStateRequirements =
			{
				-- RequiredFalseTextLines = { "MegaeraGift10" },
			},

			{ Cue = "/VO/Chronos_0351", Text = "What is this?" },
			{ Cue = "/VO/Chronos_0352", Text = "And...?" },
			{ Cue = "/VO/Chronos_0353", Text = "Oh...?" },
			{ Cue = "/VO/Chronos_0354", Text = "Huh." },
			{ Cue = "/VO/Chronos_0355", Text = "Please." },
			{ Cue = "/VO/Chronos_0356", Text = "Pishposh." },
			{ Cue = "/VO/Chronos_0357", Text = "Meaningless." },
			{ Cue = "/VO/Chronos_0358", Text = "This matters not." },
			{ Cue = "/VO/Chronos_0359", Text = "Oh, {#Emph}stop." },
			{ Cue = "/VO/Chronos_0360", Text = "Calm down." },
			{ Cue = "/VO/Chronos_0361", Text = "That I felt." },
			{ Cue = "/VO/Chronos_0362", Text = "Such ferocity." },
			{ Cue = "/VO/Chronos_0363", Text = "Such rancor." },
			{ Cue = "/VO/Chronos_0364", Text = "Such rage." },
			{ Cue = "/VO/Chronos_0365", Text = "Mm." },
			{ Cue = "/VO/Chronos_0366", Text = "Mm, mm!" },
			{ Cue = "/VO/Chronos_0367", Text = "Tsk, tsk..." },
			{ Cue = "/VO/Chronos_0368", Text = "I see..." },
			{ Cue = "/VO/Chronos_0369", Text = "How uncouth." },
			{ Cue = "/VO/Chronos_0370", Text = "Manners...!" },
			{ Cue = "/VO/Chronos_0371", Text = "Vainglorious girl!" },
			{ Cue = "/VO/Chronos_0372", Text = "Arrogant child." },
			{ Cue = "/VO/Chronos_0373", Text = "Ignorant child." },
			{ Cue = "/VO/Chronos_0374", Text = "Mannerless child..." },
			{ Cue = "/VO/Chronos_0375", Text = "Contemptuous child..." },
			{ Cue = "/VO/Chronos_0376", Text = "Meddlesome brat!" },
			{ Cue = "/VO/Chronos_0377", Text = "Scurrilous brat..." },
			{ Cue = "/VO/Chronos_0378", Text = "Unrepentant scamp..." },
			{ Cue = "/VO/Chronos_0379", Text = "You little scamp..." },
			{ Cue = "/VO/Chronos_0380", Text = "You rascal..." },
			{ Cue = "/VO/Chronos_0381", Text = "Incorrigible..." },
			{ Cue = "/VO/Chronos_0382", Text = "You upstart!" },
			{ Cue = "/VO/Chronos_0383", Text = "You impertinent..." },
			{ Cue = "/VO/Chronos_0384", Text = "Bothersome little..." },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.05,
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 18 },
			},
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				-- RequiredFalseTextLines = { "MegaeraGift10" },
			},

			{ Cue = "/VO/Chronos_0385", Text = "{#Emph}Bah..." },
			{ Cue = "/VO/Chronos_0386", Text = "{#Emph}Khh..." },
			{ Cue = "/VO/Chronos_0387", Text = "{#Emph}Nrgh...!" },
			{ Cue = "/VO/Chronos_0388", Text = "{#Emph}Hrn..." },
			{ Cue = "/VO/Chronos_0389", Text = "You..." },
			{ Cue = "/VO/Chronos_0390", Text = "How..." },
			{ Cue = "/VO/Chronos_0391", Text = "How...?" },
			{ Cue = "/VO/Chronos_0392", Text = "But..." },
			{ Cue = "/VO/Chronos_0393", Text = "This..." },
			{ Cue = "/VO/Chronos_0394", Text = "I..." },
			{ Cue = "/VO/Chronos_0395", Text = "You would dare?" },
			{ Cue = "/VO/Chronos_0397", Text = "Absurd..." },
			{ Cue = "/VO/Chronos_0398", Text = "Preposterous..." },
			{ Cue = "/VO/Chronos_0399", Text = "Nonsense..." },
			{ Cue = "/VO/Chronos_0400", Text = "Ridiculous..." },
			{ Cue = "/VO/Chronos_0401", Text = "Unbelievable..." },
			{ Cue = "/VO/Chronos_0402", Text = "Outrageous..." },
			{ Cue = "/VO/Chronos_0403", Text = "Damnation..." },
			{ Cue = "/VO/Chronos_0404", Text = "This is...!" },
			{ Cue = "/VO/Chronos_0405", Text = "Not... yet...!" },
			{ Cue = "/VO/Chronos_0406", Text = "Confound it...!" },
			{ Cue = "/VO/Chronos_0396", Text = "History repeats...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 3,
					},
				}
			},
		},

		PhaseEndedVoiceLines =
		{
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.15,
				GameStateRequirements =
				{
					RequiredBossPhase = 1,
				},

				{ Cue = "/VO/MelinoeField_1408", Text = "Fall!" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					RequiredBossPhase = 2,
				},

				{ Cue = "/VO/Chronos_0265", Text = "What... I..." },
				{ Cue = "/VO/Chronos_0266", Text = "You {#Emph}brat..." },
				{ Cue = "/VO/Chronos_0267", Text = "{#Emph}Urgh... gah..." },
				{ Cue = "/VO/Chronos_0268", Text = "How... {#Emph}dare..." },
				{ Cue = "/VO/Chronos_0269", Text = "But... {#Emph}ungh...", PlayFirst = true },
				{ Cue = "/VO/Chronos_0270", Text = "{#Emph}<Gasp>... <Gasp>..." },
				{ Cue = "/VO/Chronos_0271", Text = "{#Emph}Augh... ngh..." },
				{ Cue = "/VO/Chronos_0272", Text = "Blast... you..." },
				{ Cue = "/VO/Chronos_0273", Text = "Why... you..." },
				{ Cue = "/VO/Chronos_0274", Text = "Time... out...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Chronos" },
							Comparison = ">=",
							Value = 8,
						},
					},
				},
			}
		},
		NextPhaseVoiceLines =
		{
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 1.0,
					-- SuccessiveChanceToPlay = 0.66,
					GameStateRequirements =
					{
						RequiredBossPhase = 2,
					},
					TriggerCooldowns = { "ChronosSpokeRecently" },

					{ Cue = "/VO/Chronos_0245", Text = "Three... two... {#Emph}one..." },
					{ Cue = "/VO/Chronos_0246", Text = "Three... two... {#Emph}one...!" },
					{ Cue = "/VO/Chronos_0247", Text = "Three... two... {#Emph}one!", PlayFirst = true },
					{ Cue = "/VO/Chronos_0248", Text = "Three... two... {#Emph}one." },
					{ Cue = "/VO/Chronos_0249", Text = "This... ends... {#Emph}now...!" },
					{ Cue = "/VO/Chronos_0250", Text = "This... ends... {#Emph}now..." },
					{ Cue = "/VO/Chronos_0251", Text = "Time... to... {#Emph}die...!" },
					{ Cue = "/VO/Chronos_0252", Text = "Time... is... {#Emph}up...!" },
					{ Cue = "/VO/Chronos_0256", Text = "A moment, if you please...!" },
					{ Cue = "/VO/Chronos_0253", Text = "Now...", PreLineWait = 2.0 },
					{ Cue = "/VO/Chronos_0254", Text = "Now...!", PreLineWait = 2.0 },
					{ Cue = "/VO/Chronos_0255", Text = "Now!", PreLineWait = 2.0 },
				},
			},
		},
		DefeatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

				{ Cue = "/VO/Chronos_0275", Text = "Time... cannot... be stopped...!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0276", Text = "Time... cannot... be stopped..." },
				{ Cue = "/VO/Chronos_0277", Text = "But, Time... cannot... be stopped..." },
				{ Cue = "/VO/Chronos_0278", Text = "You... shall not... succeed..." },
				{ Cue = "/VO/Chronos_0279", Text = "{#Emph}Hah, haha, hahah..." },
				{ Cue = "/VO/Chronos_0280", Text = "{#Emph}Hahaha, hah, hah..." },
				{ Cue = "/VO/Chronos_0281", Text = "I always... shall... return..." },
				{ Cue = "/VO/Chronos_0282", Text = "No god... can vanquish... me..." },
				{ Cue = "/VO/Chronos_0283", Text = "How is this... possible...?" },
				{ Cue = "/VO/Chronos_0284", Text = "Do not... presume... you won..." },
				{ Cue = "/VO/Chronos_0285", Text = "You think... that you... prevailed...?" },
				{ Cue = "/VO/Chronos_0286", Text = "May all... my kin... be damned...!" },
				{ Cue = "/VO/Chronos_0287", Text = "Curse you... and all... the gods..." },
				{ Cue = "/VO/Chronos_0288", Text = "This I... shall not... forget..." },
				{ Cue = "/VO/Chronos_0289", Text = "Once more... you bested... me..." },
				{ Cue = "/VO/Chronos_0290", Text = "I shall... remember... this..." },
			},
		},
		DeathSound = "/SFX/StabSplatterEndSequence",

		TextLinesUseWeaponIdle = true,
		BossIntroTextLineSets =
		{
			ChronosBossFirstMeeting =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
				},
				{ Cue = "/VO/Chronos_0164", PreLineWait = 0.35,
					Text = "Let yourself in, I see. Through the gutter? This family never had any class! Though I am working on alleviating that within this House, if you would pardon all the {#Emph}dust. {#Prev}We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0165",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "A family with no class, and no civility, either. Have I not made clear to you that your attempt to do me harm shall be in vain? I am a deathless {#Emph}Titan. {#Prev}You merely are a poor, misguided {#Emph}girl." },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { StartWait = 0.2, EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, {#Emph}fighting {#Prev}is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time {#Prev}for you to {#Emph}go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},
			-- for early arrivals, never met
			ChronosBossFirstMeeting_B =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
				},
				{ Cue = "/VO/Chronos_0204", PreLineWait = 0.35,
					Text = "Pray, who might you be, my girl? It is not often that I entertain of late. Perhaps after this House becomes a little more presentable... though for the moment, you must pardon all the dust. We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0205",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "{#Emph}Ahh{#Prev}, what a surprise. My granddaughter! The one loose end I failed to tie up, now fully grown, almost. I have so many questions, if you please. How have you been? And how, exactly, did you find me here?" },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, fighting is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time for you to go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},
			-- for early arrivals after first postboss encounter
			ChronosBossFirstMeeting_C =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosReveal01", "ChronosReveal01B" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossFirstMeeting_B" },
					},
				},
				{ Cue = "/VO/Chronos_0207", PreLineWait = 0.35,
					Text = "A guest, arrived so soon! It is not often that I entertain of late. Perhaps after this House becomes a little more presentable... though for the moment, you must pardon all the dust. We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0208",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "Come, now, Granddaughter. There is no need to rush! You have come all this way. And I have so many questions. How have you been? And how, exactly, did you find me here?" },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, fighting is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time for you to go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},

			ChronosBossLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				{ Cue = "/VO/Chronos_0167",
					Text = "You slipped through my fingers before, only to return and give to me another opportunity to add you to my collection? Did Athena truly get all the wisdom in our family?" },
				{ Cue = "/VO/MelinoeField_1314", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Your {#Emph}collection... {#Prev}you speak of your kin as objects to be put on display. The gods ought have put {#Emph}you {#Prev}on display after cutting you to pieces, instead of discarding you like common filth." },
				{ Cue = "/VO/Chronos_0168",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know, I am still rather sore about all that. I truly thought my children would be different; that they would show their elders some respect. But they did not. And my tolerance... has its limits." },
			},

			ChronosBossWonAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Chronos_0169",
					Text = "Your eyes do not deceive; I am as hale and hearty as can be! That sinking sense you must have felt after our previous exchange? The fear of the utter senselessness of your entire enterprise? You now know it to be true." },
				{ Cue = "/VO/MelinoeField_1315", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I was never going to destroy you in a single clash. You more than anybody ought to know results of any worth take time." },
				{ Cue = "/VO/Chronos_0170",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ahh{#Prev}, so then you wish to make a habit of such unceremonious appearances as this. As though they might amount to something, in the end. Fine. For my part, I occasionally need to stretch my limbs." },
			},

			ChronosBossAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.49,
				},
				{ Cue = "/VO/Chronos_0171",
					Text = "You should have seen the hideous appearance of this place when I arrived! Or, I suppose you {#Emph}did{#Prev}, but were too little to recall. I daresay now it is a little more presentable. Yet you barge in, tracking blood and filth across the floor." },
				{ Cue = "/VO/MelinoeField_1316", UsePlayerSource = true,
					Text = "My apologies to your custodial staff. Next time, I'll have to try to be a little more presentable when I arrive." },
				{ Cue = "/VO/Chronos_0172",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "You seethe with bitter irony; but look at yourself! Come to confront me whilst more dead than alive. Well, the sooner I cast you out, the sooner my {#Emph}custodial staff {#Prev}can start to tidy up." },
			},

			ChronosBossAboutStyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.49,
				},
				{ Cue = "/VO/Chronos_0609",
					Text = "Did you enjoy your swim? The River Styx once flowed through here like blood. Foul traces of it yet remain in the Fields above, but now in my vicinity, it is all grains of gold." },
				{ Cue = "/VO/MelinoeField_2021", UsePlayerSource = true,
					Text = "You would transform the River Styx itself to suit your fancy? Or perhaps I heard you incorrectly. I may still have too many of your grains of gold stuck in my ears." },
				{ Cue = "/VO/Chronos_0610",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No wonder you have had such difficulty listening to me. Nevertheless, I trust the point I am about to make shall come through loud and clear." },
			},

			ChronosBossAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Intro" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Chronos_0603",
					Text = "You have been busy on the surface, have you not? Paid witness to indomitable fleets that sail toward inevitable victory, and the destruction of the mountain of the gods." },
				{ Cue = "/VO/MelinoeField_1951", UsePlayerSource = true,
					Text = "The only fleet I saw up there was a ramshackle mess whose crew could barely stand, much less put up a fight. No wonder you have failed to take Olympus yet." },
				{ Cue = "/VO/Chronos_0604",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "My fleets may not be to your standards, girl; but they have one important characteristic, which the gods all sorely lack: They are loyal to {#Emph}me {#Prev}to the end. Whichever end I {#Emph}deem!" },
			},

			ChronosBossAboutGoldenAge01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0175",
					Text = "You are too young to know what it was like. Before the gods re-shaped the world to be like this. Mortals did not have to die in agony, and waste away within this {#Emph}pit. {#Prev}A simpler age, and all the better for it." },
				{ Cue = "/VO/MelinoeField_1318", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "All the better, because you controlled every detail, is that it? You couldn't stand that others had a different outlook than your own. You went to war with your own children! After eating them whole, so they say." },
				{ Cue = "/VO/Chronos_0176",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "They say a lot of things! {#Emph}They {#Prev}went to war with {#Emph}me. {#Prev}My offspring and my other charges did not always take to discipline; I had too many to look after to take cheek from any one. And {#Emph}you{#Prev}, my girl, are not entitled to anything more." },
			},
			ChronosBossAboutGoldenAge02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGoldenAge01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
				},
				{ Cue = "/VO/Chronos_0501",
					Text = "You have by now seen something of this world. Consider what the gods have wrought: war, famine, betrayal! During my Golden Age, there were no such concerns. It was a tranquil time... until the gods decided to wrest control forcibly!" },
				{ Cue = "/VO/MelinoeField_1504", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Perhaps your rule was not as perfect as you claim. Perhaps you were a stifling presence on your children and their generation, leaving them with little choice but to rid themselves of you." },
				{ Cue = "/VO/Chronos_0502",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well, they {#Emph}failed! {#Prev}And thus presents itself this golden opportunity to teach my {#Emph}children and their generation {#Prev}a most-valuable lesson about having to live with the consequences of their actions!" },
			},

			ChronosBossAboutSatyrs01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0493",
					Text = "My legions know you well by now; the trouble you have caused. Yet only my most ardent followers may spill their blood within my halls." },
				{ Cue = "/VO/MelinoeField_1500", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "These Satyr worshipers of yours must be very honored to be the first to die here. Not the wisest creatures, though, are they?" },
				{ Cue = "/VO/Chronos_0494",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "The wise do not follow; the wise {#Emph}lead. {#Prev}These Satyrs lack a mortal fear of death, believing that their sacrifice shall bring me strength, and that they shall live on. Let us {#Emph}grant their desire." },
			},

			ChronosBossAboutHistory01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Chronos_0214",
					Text = "The course of history is mine to shape. Yet you continue vexing me, as though you wish to do so in my stead. Fine, what shall it be? Shall I just go ahead and cede my rightful throne?" },
				{ Cue = "/VO/MelinoeField_1403", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You don't set the course of history... you're Time. You're just the paving stones we cross along our way. More than getting back at the gods, you're getting back at the Fates, who know your rightful place in all of this." },
				{ Cue = "/VO/Chronos_0215",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "I do, in fact, take issue with the Fates. Though they ought to be none of {#Emph}your {#Prev}concern, or anyone's. Imagine being free to make your own decisions now, only to long for the weight of their yoke upon your back! How {#Emph}pathetic." },
			},

			ChronosBossAboutFuture01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Chronos_0497",
					Text = "The future is unwoven; uncertain. Not even the Fates themselves can anticipate how all of this shall end, or {#Emph}when. {#Prev}Yet you press on." },
				{ Cue = "/VO/MelinoeField_1502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I thought you were all about the inevitable. Whether the outcome of all this has been foretold or not, I'll see it through. Call it a morbid curiosity." },
				{ Cue = "/VO/Chronos_0498",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "I call it reckless abandon, nothing more. You fail to consider the many possibilities in which you prove unable to enjoy the fruits of your labors..." },
			},

			ChronosBossAboutTime01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/Chronos_0499",
					Text = "A moment passes... then another, and another. I have names for them in every measure, you know? The very brief ones. The ones that linger..." },
				{ Cue = "/VO/MelinoeField_1503", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "If you're quite finished, I'll try to not to take up more than a few of the very brief ones you mentioned." },
				{ Cue = "/VO/Chronos_0500",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "I understand the need to cut {#Emph}Time {#Prev}down to smaller bits, I do. Hours, cut down to minutes. Minutes, cut down to seconds. Because the whole of it, my girl... is {#Emph}too much to fathom." },
			},

			ChronosBossAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponTorch", "WeaponAxe", "WeaponLob" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob" },
					},
				},
				{ Cue = "/VO/Chronos_0503",
					Text = "What {#Emph}are {#Prev}those {#Emph}garish {#Prev}instruments with which you try to do harm? Like as not some gadgets that the Fates themselves had vainly hoped would put an end to me." },
				{ Cue = "/VO/MelinoeField_1505", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Whether they {#Emph}vainly {#Prev}hoped is yet to be determined. These may not be the arms the gods once used to bring you down, but they'll get the job done just the same. You watch." },
				{ Cue = "/VO/Chronos_0504",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh, we are eager to learn more, Hrodreptus and I. This scythe is not merely for cutting short the wheat whilst I put Cerberus away; it is for cutting short just about anything, you see." },
			},

			ChronosBossAboutThanatosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
				},
				{ Cue = "/VO/Chronos_0607",
					Text = "I recognize that blade you bear: The scythe of Death himself! Alas that he was momentarily without it when I caught him in my snare, along with this House's other former residents." },
				{ Cue = "/VO/MelinoeField_1953", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You may have taken Death, yet death is here for you. It would be fitting if you met your end by Zorephet." },
				{ Cue = "/VO/Chronos_0608",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "It would be most unlikely, I should think. Then let us match now, scythe to scythe! Your Zorephet against my Hrodreptus. And we shall imminently see who reaps, and who sows." },
			},

			ChronosBossAboutWretches01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/MelinoeField_1506", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Pardon my lateness, I had some wretches to contend with. I thought you let everyone go, regardless of past transgressions." },
				{ Cue = "/VO/Chronos_0505",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "I let just about everyone go, yes. You may be surprised, however, to learn that some of those so-called {#Emph}wretches {#Prev}do not care for Hades very much. They were quite eager to serve me instead, when nicely asked. With you, I shall not even bother." },
			},
			ChronosBossAboutTitans01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGoldenAge02" },
					},
				},
				{ Cue = "/VO/MelinoeField_1508", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're so indignant of my father's generation. What came of yours? I don't see many of your contemporaries rallied to your cause, or any other for that matter." },
				{ Cue = "/VO/Chronos_0507",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well, you see, most of the other Titans met their end, just as did I! The doing of your father and his {#Emph}generation. {#Prev}Perhaps when all of this is settled, I shall see to bringing my {#Emph}contemporaries {#Prev}back. A few of them." },
			},
			ChronosBossAboutOrigin01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/MelinoeField_1509", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up, wretch. Titan. {#Emph}Lord Master Chronos. {#Prev}Whatever they call you now. It's {#Emph}time{#Prev}, as you might say." },
				{ Cue = "/VO/Chronos_0508",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "It is, indeed. And they have called me many things; many names, in aeons past. There are those who think me nothing more than the offspring of Heaven and Earth, of all the {#Emph}nerve. {#Prev}And you are even less cordial than {#Emph}they." },
			},
			ChronosBossAboutClockwork01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Chronos_0550",
					Text = "Have you once marveled at the ever-turning gears in Tartarus? My little contribution to the Underworld's design; a steady means of moving things along. I call it {#Emph}clockwork. {#Prev}A cycle without end! Akin to the turning of the seasons." },
				{ Cue = "/VO/MelinoeField_1594", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm not here for a tour. That {#Emph}clockwork {#Prev}could have only come from {#Emph}you. {#Prev}An eyesore, going nowhere, groaning all along." },
				{ Cue = "/VO/Chronos_0551",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Going {#Emph}nowhere? {#Prev}One with capacity for magick ought espouse a deeper understanding of this world! We are always going {#Emph}somewhere; {#Prev}the {#Emph}future{#Prev}, my girl! Into the {#Emph}future." },
			},

			-- other reactions
			ChronosBossAboutGameplayTimer01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
				},
				{ Cue = "/VO/Chronos_0554",
					Text = "So you are keeping careful track of Time; such things of course are plain for me to see. But your reasons for it, I hardly can surmise. To gauge, perhaps, how quickly you shall fall?" },
				{ Cue = "/VO/MelinoeField_1596", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Either me or you. So how much time shall we require here tonight? In all your wisdom, surely you must know." },
				{ Cue = "/VO/Chronos_0555",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, this shall take but a {#Emph}trifle{#Prev}, I expect! Not yet a formal measurement, although perhaps that too shall change..." },
			},
			ChronosBossAboutGameplayTimer02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGameplayTimer01" },
					},
					{
						PathFalse = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
				},
				{ Cue = "/VO/Chronos_0556",
					Text = "You ceased to track the measurement of just how quickly we may settle our disputes. Was it too much for you? To be so self-aware of your inexorable flight toward uncertainty?" },
				{ Cue = "/VO/MelinoeField_1597", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I am an immortal goddess of the Underworld. Time means nothing to me. I can do this forever." },
				{ Cue = "/VO/Chronos_0557",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Is that so? {#Emph}Forever {#Prev}is a very long while. We shall have to make this slow and excruciating, to sate your gluttonous desire for more..." },
			},
			ChronosBossAboutPausing01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" }
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" }
					},
				},
				{ Cue = "/VO/Chronos_0601",
					Text = "You have considerable power over Time, that you can turn some of my innate power against {#Emph}me! {#Prev}Perhaps your knack for this is merely a recessive family trait." },
				{ Cue = "/VO/MelinoeField_1950", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Don't insult me, and don't fool yourself. When you took my family, you created in me a lifelong desire to see you destroyed. So I simply prepared." },
				{ Cue = "/VO/Chronos_0602",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "A lifelong desire. Your {#Emph}life{#Prev}, girl, is but a blink of an eye to {#Emph}me! {#Prev}No one achieves abilities as yours through force of will alone. Though you are no mere {#Emph}god{#Prev}; you are a {#Emph}witch." },
			},

			-- about characters / about other characters
			ChronosBossAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Chronos_0173",
					Text = "You saw your father out there, I presume? He required a special arrangement. For aeons, he incarcerated countless souls within this place; not to mention {#Emph}me. {#Prev}Seemed only fitting he should have to waste away accordingly." },
				{ Cue = "/VO/MelinoeField_1317", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You couch it in morality, when vengeance is reason enough. Though, since you've reasoned it all out, by what right did you take the other members of my family? And Nyx and all the rest?" },
				{ Cue = "/VO/Chronos_0174",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Why, because they opposed me. Except you have this rather vexing knack for resisting some of my time-honored techniques... a recessive family trait, perhaps. Although, your brother... he was not so fortunate. You, too, shall break, however... soon enough." },
			},
			ChronosBossAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosBossAboutHades01", "ChronosBossAboutGoldenAge01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "HadesLifestealBoon", "HadesCastProjectileBoon", "HadesPreDamageBoon", "HadesChronosDebuffBoon", "HadesInvisibilityRetaliateBoon", "HadesDeathDefianceDamageBoon" },
					},
				},
				{ Cue = "/VO/Chronos_0495",
					Text = "Hades used some of his failing strength to spur you on! Even whilst bound in chains no god can break, your father yet proves to be a pest." },
				{ Cue = "/VO/MelinoeField_1501", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You've tortured and humiliated him. All this talk of how you plan to bring about a bygone age, yet petty vengeance seems to be your chief concern." },
				{ Cue = "/VO/Chronos_0496",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "The thing is, my girl, I can have {#Emph}both. {#Prev}You should have seen the cruel, inventive ways your father tortured mortal souls! Thus I dispense a form of justice to {#Emph}him{#Prev}, and to {#Emph}you." },
			},

			ChronosBossAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Chronos_0547",
					Text = "You are {#Emph}quite {#Prev}dangerous, I must admit. You have repeatedly breached into Tartarus, and this House; impossibilities, if not for your tainted bloodline! And you are able to withstand my conjuring. Might I again politely ask you {#Emph}how?" },
				{ Cue = "/VO/MelinoeField_1592", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You call that {#Emph}politely? {#Prev}You didn't even say the magick word. But since you really want to know... I'm from the future. You'll later come to realize the error of your ways, and teach me to stop you before you can cause more harm." },
				{ Cue = "/VO/Chronos_0548",
					Emote = "PortraitEmoteFiredUp",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ha ha ha! {#Prev}Oh, quite an imaginative tale. A comedy, for the utterly outrageous premise beggars belief! My girl, one cannot travel {#Emph}back {#Prev}in Time! Time marches ever forward; and I alone determine at which rate." },
			},

			ChronosBossAboutCerberus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0212",
					Text = "You are proving to be quite a nuisance, if only because you insist on continually setting loose your father's wretched old three-headed cur! To think how such a beast used to be kept within these walls." },
				{ Cue = "/VO/MelinoeField_1402", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So you keep casting out poor Cerberus into the Mourning Fields, where he rages alone. Of all your unforgivable offenses..." },
				{ Cue = "/VO/Chronos_0213",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "What would you have me do? I do not require him to guard the gates to this realm, for they are open wide. And I certainly do not require him to shed everywhere. Though {#Emph}blood{#Prev}shed, I accept." },
			},

			ChronosBossAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "N_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Chronos_0605",
					Text = "My work is made much easier for all the enemies Olympus has accrued. From the Satyrs, to the Harpies, to the Cyclops Polyphemus and much more! It is not I alone who seeks the downfall of the gods." },
				{ Cue = "/VO/MelinoeField_1952", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So you gathered up the dregs lusting for power or revenge! Such company you keep. I know that Polyphemus well enough by now... his loyalty can almost certainly be bought." },
				{ Cue = "/VO/Chronos_0606",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Oh{#Prev}, that it {#Emph}can. Loyalty {#Prev}is either earned or bought, and it makes very little difference either way. Polyphemus has his limitations, to be sure. But he is not a {#Emph}lost cause." },
			},

			ChronosBossAboutChaos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutChronosNightmare01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1590", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You know, I'm almost impressed. Not only have you ransacked my father's domain and made war on Olympus, you had the audacity to deceive Primordial Chaos! That takes a spine." },
				{ Cue = "/VO/Chronos_0545",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "Why thank you, my girl! I must admit, I thought that Chaos would be something of a bargainer, for I was willing to exchange their daughter Nyx for the Three Fates. But now, I have them all!" },
				{ Cue = "/VO/MelinoeField_1591", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You played the chthonic gods for a pack of fools... these eldest, most powerful forces in existence. Such choices may come back to haunt you." },
				{ Cue = "/VO/Chronos_0546",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes, {#Emph}you {#Prev}have come back to haunt me here repeatedly. You, the best that the gods of the Underworld and Olympus have to offer. {#Emph}Bah!" },
			},

			ChronosBossAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutChaos01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1507", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So what have you done with the Three Fates? You would incur the wrath of all chthonic gods, as though the wrath of all Olympus weren't enough..." },
				{ Cue = "/VO/Chronos_0506",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, I banished them! Where, I cannot say, or {#Emph}when. {#Prev}In any event, they trouble us no longer, with their manipulative weavings. No, what happens now... is entirely up to {#Emph}us." },
			},

			ChronosBossAboutCharon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift02" },
					},
				},
				{ Cue = "/VO/Chronos_0552",
					Text = "I am quite flummoxed with that {#Emph}Boatman {#Prev}fellow just outside, who has the gall to scull his little boat right to my very doorstep! The Satyrs have more fear of {#Emph}him {#Prev}than {#Emph}you." },
				{ Cue = "/VO/MelinoeField_1595", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You ought fear him yourself. Lord Charon knows every stone in the Underworld... every drop in the five rivers. You say you can't be stopped? Neither can he." },
				{ Cue = "/VO/Chronos_0553",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "...That trinket-peddler, crudely hawking his ill-gotten wares to his very limited base of customers! And hoarding so much Gold I generously wrought. A noble ally that you have!" },
			},

			ChronosBossAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Eris_01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					-- @ update with additional requirements
				},
				{ Cue = "/VO/MelinoeField_1593", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I thought all the chthonic gods opposed you openly. But you persuaded {#Emph}Eris{#Prev}, of all creatures, to your side! A laughable alliance, though not bad for sowing more destruction and dissent." },
				{ Cue = "/VO/Chronos_0549",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am owed credit for a great many things, my girl; but not for any such alliances with Strife! What use have I for Nyx's youngest whelp? Although perhaps she is no fool, if she has rallied to my banners as you say." },
			},

			-- repeatable / other general cases
			ChronosBossMiscStart01 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0177",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Once more you have eluded my grasp in getting here, as though you wish to fall only to me." },
			},
			ChronosBossMiscStart02 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0178",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You shall find my patience limitless for all your foolish antics here, my girl." },
			},
			ChronosBossMiscStart03 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0179",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I spent aeons buried in the depths below; a few rude trespasses from you are hardly of concern." },
			},
			ChronosBossMiscStart04 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0180",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "This little spat with you was clearly never going to resolve in a more-civil way..." },
			},
			ChronosBossMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0181",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Long have I lorded on this throne; a bit of vigorous activity should do me well." },
			},
			ChronosBossMiscStart06 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0182",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "To think that the combined might of my forces proved insufficient against a mere girl." },
			},
			ChronosBossMiscStart07 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0183",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You are methodical, I grant you that. But I shall have to take from you much more." },
			},
			ChronosBossMiscStart08 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0184",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You cannot be in two places at once. Whilst you vainly lash out, Olympus burns..." },
			},
			ChronosBossMiscStart09 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0185",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Time can seem to pass in an instant, or last an eternity. On this occasion, let us make it quick." },
			},
			ChronosBossMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0186",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The Fates themselves could not prevent my rightful rule; what hope have you?" },
			},

		},

		BossPhaseChangeTextLineSets =
		{
			ChronosR1FirstWin =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0216",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Nngh! {#Prev}This audience has lasted long enough. You do not get to {#Emph}barge {#Prev}into this House, and waste {#Emph}my {#Prev}time! I {#Emph}am {#Prev}Time. And I can make your every moment {#Emph}hell." },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},

			ChronosR1Win01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0221",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Nrgh{#Prev}, you wretched child...! Like father, like daughter, then, is it...?" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},
			ChronosR1Win02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0222",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...You do not belong here... you do not belong {#Emph}anywhere{#Prev}, at all..." },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},
			ChronosR1Win03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0223",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "{#Emph}Pah...! {#Prev}It took six full-grown gods to thwart me once... not one mere {#Emph}child!" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},
			ChronosR1Win04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0224",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Heh heh... {#Prev}so, you possess some of your father's strength. Or rather, {#Emph}mine..." },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},
			ChronosR1Win05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0225",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Augh... {#Prev}I grow quite weary of this dour place..." },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},
			ChronosR1Win06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					-- None
				},
				{ Cue = "/VO/Chronos_0226",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Ungh... {#Prev}perhaps... a change of scenery is best..." },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					{ Cue = "" },
				},
			},

		},

		BossOutroTextLineSets =
		{
			ChronosBossOutro01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0217",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}<Gasp> {#Prev}I thought... {#Emph}none {#Prev}could resist the ravages of Time... but, {#Emph}you? How...?" },
				{ Cue = "/VO/MelinoeField_1404", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You'll get no answers from me, and no mercy, either. Now {#Emph}die{#Prev}, already. And I'll collect the ichor from your veins. Or whatever flows through them." },
				{ Cue = "/VO/Chronos_0218",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "{#Emph}Hah, hah, hah! {#Prev}What is death to the deathless? A mere nuisance! This House is {#Emph}mine. {#Prev}Once I am gone... you shall be cast away." },
				{ Cue = "/VO/MelinoeField_1405",  UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I expect so. And you'll be re-made and back on the throne before I can return. But I {#Emph}shall {#Prev}return. And I'll slay you again, and again, and {#Emph}again{#Prev}, if I must." },
				{ Cue = "/VO/Chronos_0219",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "Even if, in so doing, it meant that you would never see your dear old family again? Because the mercy I have shown to them thus far is something I may have to re-evaluate." },
				{ Cue = "/VO/MelinoeField_1406",  UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}Our {#Prev}family. And what do I care? I don't even know them. But I {#Emph}do {#Prev}know you ought be dead here in another moment; any last words?" },
				{ Cue = "/VO/Chronos_0220",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "...For you, my girl...? No... none, for now..." },
			},

			ChronosBossMiscDefeat01 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0227",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ungh...! {#Prev}This matters not... my plans are already... well underway..." },
			},
			ChronosBossMiscDefeat02 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0228",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ngh... {#Prev}I have... returned from worse... suffered much worse... than from the likes of you..." },
			},
			ChronosBossMiscDefeat03 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0229",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh... {#Prev}you truly are a nuisance, to be sure... but you accomplish naught..." },
			},
			ChronosBossMiscDefeat04 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Chronos_0230",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Gah... {#Prev}to have been brought this low once more, by a mere {#Emph}god..." },
			},
			ChronosBossMiscDefeat05 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0231",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Urgh... {#Prev}you are no granddaughter of mine... that you would deign to treat me thus...!" },
			},
			ChronosBossMiscDefeat06 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0232",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Mmph... {#Prev}I always... hated... children such as you..." },
			},
			ChronosBossMiscDefeat07 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0233",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Khh... {#Prev}I curse the day... your father... sired you..." },
			},
			ChronosBossMiscDefeat08 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0234",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Rrngh...! {#Prev}How... are you able to resist...?" },
			},
			ChronosBossMiscDefeat09 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0235",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Guh... {#Prev}goodbye again, only for now, my girl..." },
			},
			ChronosBossMiscDefeat10 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0236",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Nrgh... {#Prev}you waste your precious time... Olympus {#Emph}burns..." },
			},
			ChronosBossMiscDefeat11 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0237",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Rngh... {#Prev}you cannot stop me... merely... slow me down a bit..." },
			},
			ChronosBossMiscDefeat12 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0238",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Argh...! {#Prev}How is it that I cannot vanquish such a {#Emph}brat...?" },
			},
			ChronosBossMiscDefeat13 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0239",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}<Gasp> {#Prev}My age, perhaps, is catching up with me..." },
			},
			ChronosBossMiscDefeat14 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0240",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Hngh... {#Prev}once more, you bring me low... but not for long..." },
			},
			ChronosBossMiscDefeat15 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0241",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Tsch... {#Prev}brought low once more... for what? Some grains of {#Emph}Sand?" },
			},
			ChronosBossMiscDefeat16 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0242",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Naugh... {#Prev}this victory of yours... shall be short-lived..." },
			},
			ChronosBossMiscDefeat17 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0243",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Nngh...! {#Prev}Once more... I am undone...! I shall be back... in the blink of an eye..." },
			},
			ChronosBossMiscDefeat18 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0244",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Raugh... {#Prev}of all my vexing relatives... you are amongst the worst..." },
			},

		},

		Using = { Spawn = "ChronosRemains"},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Chronos )