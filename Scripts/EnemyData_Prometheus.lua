UnitSetData.Prometheus =
{
	Prometheus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Prometheus_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.PrometheusVoice,
		SpeakerName = "Prometheus",
		SpeechParams =
		{
			Radius = 1,
		},
		SpeakingStatusAnimation = "StatusIconSpeaking_Hero",
		LoadPackages = { "Prometheus", },
		MaxHealth = 33000,
		AISetupDelay = 0,
		AnimOffsetZ = -65,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},

		InvulnerableFx = "nil",
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		SpeechCooldownTime = 9,
		SelfBuffDamage = 100, -- used for text

		OnDeathFunctionName = "PrometheusKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "PrometheusDefeatedMessage",
			CameraPanTime = 1.5,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			BatsAfterDeath = false,
			FlashRed = true,
			FlashDuration = 0.45,
			DeathFlashOffsetY = 50,
			AddInterBiomeTimerBlock = true,
			EndAngle = 210,
			KillerEndAngle = 30,
			PanZoomFraction = 1.3,
		},

		DeathAngle = 220,
		DeathAnimation = "Enemy_Prometheus_Death_End",
		DeathFx = "PrometheusDeathFxIn",
		DeathSound = "/SFX/StabSplatterEndSequence",
		DeathPanOffsetY = -170,

		ClearChillOnDeath = true,

		SpawnAnimation = "Enemy_Prometheus_IntroIdle",

		Material = "Organic",
		HealthBarTextId = "Prometheus_Full",
		HealthBarOffsetY = -275,
		AltHealthBarTextIds =
		{
			{ TextId = "NPC_Prometheus_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
			},
		},

		BossDifficultyShrineRequiredCount = 3,
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					MaxHealth = 36000,
					HealthBarLocationX = 670,
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
								ForcedWeaponInterrupt = "PrometheusDashBackward",
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

		--InvulnerableFx = "Invincibubble",
		TextLinesUseWeaponIdle = true,
		
		--[[
		DodgeAnimation = "Enemy_Prometheus_Dodge",
		DodgeDuration = 1.15,
		DodgeCooldown = 12.0,
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		]]

		ComboPartnerName = "Eagle",

		DefaultAIData =
		{
			--DashIfOverDistance = 800,
			--DashWeapon = "PrometheusJump",
			ForesightCooldown = 16.0,
			ForesightChance = 0.40,
		},
		--WeaponOptions = { "PrometheusKick_Base", },
		WeaponOptions =
		{
			"PrometheusSlam_P1",
			"PrometheusKick_P1",
			"PrometheusUppercut_P1",

			"PrometheusDashBackward",

			"PrometheusCastSelector_P1",
		},
		Using =
		{
			Weapons =
			{
				"PrometheusCombo_Spiral",
			},
		},

		PreBossAISetupFunctionName = "PrometheusBattleStart",
		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PrometheusSlam_P1",
						"PrometheusKick_P1", "PrometheusKick_Heavy_Passive",
						"PrometheusFlurry_P1",
						"PrometheusUppercut_P1",

						"PrometheusDashBackward",

						"PrometheusCastSelector_P1",
					},
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PrometheusMemory_P2_Intro",
				ClearEffects = true,
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PrometheusSlam_P2_Starter",
						"PrometheusKick_P2_Starter", "PrometheusKick_Heavy_Passive",
						"PrometheusFlurry_P2_Starter",
						"PrometheusUppercut_P2_Starter",

						"PrometheusDashBackward",
						"PrometheusDashForward",

						"PrometheusCastSelector_P2",
						--"PrometheusFireWall",
						"PrometheusSummonSelector_P2",
					},
					ThreadedEvents =
					{
						{
							FunctionName = "HeraclesMemoryBreak",
							Args =
							{
								HeraclesWeapon = "HeraclesEMRoar_Dummy",
							},
						},
					},
				},
				EquipWeapons =
				{
					"PrometheusSlam_P2_Starter",
					"PrometheusKick_P2_Starter",
					"PrometheusUppercut_P2_Starter",

					"PrometheusDashBackward",
					"PrometheusDashForward",

					"PrometheusCastSelector_P2",
					--"PrometheusFireWall",
					"PrometheusSummonSelector_P2",
				},
				UnequipAllWeapons = true,
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PrometheusMemory_P3_Intro",
				ClearEffects = true,
				EMStageDataOverrides =
				{
					AIData =
					{
						AIEndHealthThreshold = 0.01,
					},
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PrometheusSlam_P3_Starter",
						"PrometheusKick_P3_Starter", "PrometheusKick_Heavy_Passive",
						"PrometheusFlurry_P3_Starter",
						"PrometheusUppercut_P3_Starter",

						"PrometheusDashBackward",
						"PrometheusDashBackward",
						"PrometheusDashBackward",
						"PrometheusDashBackward",

						"PrometheusCastSelector_P3",

						--"PrometheusFireWall2",
						--"PrometheusCombo_Spiral",
						"PrometheusSummonSelector_P3"
					},
					ThreadedEvents =
					{
						{
							FunctionName = "HeraclesMemoryBreak",
							Args =
							{
								HeraclesWeapon = "HeraclesEMRoar_Dummy",
							},
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EquipWeapons =
				{
					"PrometheusSlam_P3_Starter",
					"PrometheusKick_P3_Starter",
					"PrometheusUppercut_P3_Starter",

					"PrometheusDashBackward",
					"PrometheusDashBackward",
					"PrometheusDashBackward",
					"PrometheusDashBackward",

					"PrometheusCastSelector_P3",

					--"PrometheusFireWall2",
					--"PrometheusCombo_Spiral",
					"PrometheusSummonSelector_P3"
				},
				UnequipAllWeapons = true,
			},
			{
				RandomAIFunctionNames = { "IdleAIStage" },
				DataOverrides =
				{
					RepulseOnMeleeInvulnerableHit = 150,
					IdleAIAnimation = "Enemy_Prometheus_Death_Start",
					KnockedOut = true,
				},
				SetMapFlags =
				{ 
					{ FlagName = "PrometheusKnockedOut" },
				},
				NewVulnerability = false,
				AIData =
				{
					AIEndLastAlive = true,
				},
				EndThreadNameWaits = { "PrometheusHeraclesRoleSwitcher" },
			},
			{
				RandomAIFunctionNames = { "DieAI" },
				NewVulnerability = true,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "PrometheusSpokeRecently", Time = 4 },
					{ Name = "PrometheusLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Prometheus_0103", Text = "But I do.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0771" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0103_B", Text = "But I do.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0772" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0104", Text = "I think otherwise.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0776", "/VO/Melinoe_0771", "/VO/Melinoe_0772" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0180", Text = "But soon.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0705" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0181", Text = "How about {#Emph}no.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0708" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0182", Text = "Not quite.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0705", "/VO/Melinoe_0776" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0183", Text = "You'll make plenty.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0707" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0184", Text = "No chance at all.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0709", "/VO/MelinoeField_0714" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0185", Text = "Oh you shall.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0704", "/VO/MelinoeField_0710" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0186", Text = "Not for long.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0712", "/VO/MelinoeField_0715" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0187", Text = "{#Emph}I {#Prev}do.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0772" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0188", Text = "Yes.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0774" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0188_B", Text = "Yes.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0716" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0189", Text = "Damn {#Emph}you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0775" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0105", Text = "Your strength fades.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0773", "/VO/MelinoeField_0713" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0106", Text = "Withstood all that...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0706", "/VO/MelinoeField_0711" },
						},
					},
				},
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
					{ Name = "PrometheusSpokeRecently", Time = 8 },
				},

				-- { Cue = "/VO/Hecate_0505", Text = "Time's up." },
			},
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			{ GlobalVoiceLines = "PrometheusDodgeReactionLines" },
		},

		MemoryAttackIntroVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.65,
				-- SuccessiveChanceToPlay = 0.15,
				ObjectType = "Prometheus",
				TriggerCooldowns = { "PrometheusSpokeRecently" },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "PrometheusFireWaves" },
						Comparison = "<=",
						Value = 1,
					},
				},
				Cooldowns =
				{
					{ Name = "PrometheusMemoryIntroPlayedRecently", Time = 20 },
				},

				{ Cue = "/VO/Prometheus_0099", Text = "What's life without pain?" },
				{ Cue = "/VO/Prometheus_0100", Text = "Suffer as I did." },
				{ Cue = "/VO/Prometheus_0101", Text = "Suffer, then." },
				{ Cue = "/VO/Prometheus_0102", Text = "Turn back." },
				{ Cue = "/VO/Prometheus_0172", Text = "Go back." },
				{ Cue = "/VO/Prometheus_0173", Text = "Return to hell." },
				{ Cue = "/VO/Prometheus_0174", Text = "Leave this place." },
				{ Cue = "/VO/Prometheus_0175", Text = "Do you see?" },
				{ Cue = "/VO/Prometheus_0176", Text = "I'll not hold back." },
				{ Cue = "/VO/Prometheus_0177", Text = "I'll burn you to ash.", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0393", Text = "You're not prepared for what awaits you at the summit!" },
				{ Cue = "/VO/Prometheus_0394", Text = "Come, show me what little foresight you can muster!" },
				{ Cue = "/VO/Prometheus_0395", Text = "You need but to evade three waves of flame, but {#Emph}where?" },
				{ Cue = "/VO/Prometheus_0396", Text = "Choose your path carefully, Agent of Change! Lest you burn." },
				{ Cue = "/VO/Prometheus_0397", Text = "You know where I intend to strike, but shall that be enough?" },
				{ Cue = "/VO/Prometheus_0399", Text = "But one false step and I shall char you to a crisp." },
				{ Cue = "/VO/Prometheus_0401", Text = "Was it the top path, or the middle path, perhaps...?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Prometheus_0402", Text = "Surely the lower path first, followed by the top?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Prometheus_0403", Text = "Best stay there in the middle path? Or, the lower path perhaps...?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Prometheus_0400", Text = "Am I becoming too predictable for you, Agent of Change?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Name = "P_Boss01", Count = 2 },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0398", Text = "How easily you can anticipate my flames by now...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Name = "P_Boss01", Count = 3 },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0179", Text = "You gods...",
					Cooldowns =
					{
						{ Name = "PrometeusSaidGodsRecently", Time = 20 }
					},
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.65,
				-- SuccessiveChanceToPlay = 0.15,
				ObjectType = "Prometheus",
				TriggerCooldowns = { "PrometheusSpokeRecently" },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "PrometheusFireWaves" },
						Comparison = ">",
						Value = 1,
					},
				},
				Cooldowns =
				{
					{ Name = "PrometheusMemoryIntroPlayedRecently", Time = 20 },
				},

				{ Cue = "/VO/Prometheus_0404", Text = "What have I to hide from the likes of you?" },
				{ Cue = "/VO/Prometheus_0405", Text = "All you gods, your memories are {#Emph}far {#Prev}too short." },
				{ Cue = "/VO/Prometheus_0406", Text = "Try to find a pattern if you wish; but there is none." },
				{ Cue = "/VO/Prometheus_0407", Text = "I know what is about to happen to you here; do you?", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0408", Text = "Remember what you are about to see..." },
				{ Cue = "/VO/Prometheus_0409", Text = "Can you predict what shall occur as easily as I?" },
				{ Cue = "/VO/Prometheus_0410", Text = "My flames shall not spare you or {#Emph}any {#Prev}god...!" },
				{ Cue = "/VO/Prometheus_0411", Text = "These flames never belonged to you, but here! {#Emph}Have {#Prev}them!" },
				{ Cue = "/VO/Prometheus_0412", Text = "I know what shall become of you, Agent of Change... but first..." },
				{ Cue = "/VO/Prometheus_0413", Text = "You gods have much to answer for, yet no one to make you..." },
				{ Cue = "/VO/Prometheus_0414", Text = "Let's see you once again evade these flames!" },
				{ Cue = "/VO/Prometheus_0415", Text = "I was shorn apart on a freezing mountain; {#Emph}this {#Prev}is {#Emph}nothing." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				ObjectType = "Heracles",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Heracles" },
						Comparison = ">=",
						Value = 0.25,
					},
				},
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 8 },
					{ Name = "HeraclesFlameSpeech", Time = 30 },
				},

				{ Cue = "/VO/Heracles_0381", Text = "You burn. I don't.", PlayFirst = true },
				{ Cue = "/VO/Heracles_0382", Text = "Now what, witch?" },
				{ Cue = "/VO/Heracles_0383", Text = "This may hurt." },
				{ Cue = "/VO/Heracles_0384", Text = "Burn the witch!" },
				{ Cue = "/VO/Heracles_0385", Text = "Quit blathering and {#Emph}shoot!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = {
								"/VO/Prometheus_0393",
								"/VO/Prometheus_0394",
								"/VO/Prometheus_0395",
								"/VO/Prometheus_0396",
								"/VO/Prometheus_0397",
								"/VO/Prometheus_0398",
								"/VO/Prometheus_0399",
								"/VO/Prometheus_0400",
								"/VO/Prometheus_0401",
								"/VO/Prometheus_0402",
								"/VO/Prometheus_0403",
								"/VO/Prometheus_0404",
								"/VO/Prometheus_0405",
								"/VO/Prometheus_0406",
								"/VO/Prometheus_0407",
								"/VO/Prometheus_0408",
								"/VO/Prometheus_0409",
								"/VO/Prometheus_0410",
								"/VO/Prometheus_0411",
								"/VO/Prometheus_0412",
								"/VO/Prometheus_0413",
								"/VO/Prometheus_0414",
								"/VO/Prometheus_0415",
							},
						},
					},
				},
				{ Cue = "/VO/Heracles_0386", Text = "There he goes." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PlayOnceFromTableThisRun = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.05,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_2859", Text = "Get back here!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2861", Text = "Revealing his plan...", PreLineWait = 1.2 },
				{ Cue = "/VO/MelinoeField_2862", Text = "Visions of flame...", PreLineWait = 0.8 },
				{ Cue = "/VO/MelinoeField_2863", Text = "Always a pattern...", PreLineWait = 1.2 },
				{ Cue = "/VO/MelinoeField_2864", Text = "Waves of flame...", PreLineWait = 0.8 },
				{ Cue = "/VO/MelinoeField_2860", Text = "Oh, no...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.5, },
						},
					},
				},
			},
		},
		MemoryAttackOutroVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			TriggerCooldowns = { "PrometheusSpokeRecently" },
			Cooldowns =
			{
				{ Name = "PrometheusMemoryOutroPlayedRecently", Time = 20 },
			},

			{ Cue = "/VO/Prometheus_0421", Text = "Let's carry on." },
			{ Cue = "/VO/Prometheus_0423", Text = "Now what do you see?!" },
			{ Cue = "/VO/Prometheus_0426", Text = "Enough!" },
			{ Cue = "/VO/Prometheus_0427", Text = "Now {#Emph}fight!" },
			{ Cue = "/VO/Prometheus_0254", Text = "...We're not finished!" },
			{ Cue = "/VO/Prometheus_0257", Text = "...Time cannot be stopped!" },
			{ Cue = "/VO/Prometheus_0261", Text = "...You'll never defeat us!" },
			{ Cue = "/VO/Prometheus_0191", Text = "As expected." },
			{ Cue = "/VO/Prometheus_0192", Text = "Predictable." },
			{ Cue = "/VO/Prometheus_0195", Text = "Saw that." },
			{ Cue = "/VO/Prometheus_0196", Text = "Come on." },
			{ Cue = "/VO/Prometheus_0199", Text = "{#Emph}<Scoff>" },
			{ Cue = "/VO/Prometheus_0200", Text = "{#Emph}Hmph." },
			{ Cue = "/VO/Prometheus_0108", Text = "...Curse you gods...!", PlayFirst = true,
				Cooldowns =
				{
					{ Name = "PrometeusSaidGodsRecently", Time = 20 }
				},
			},
			{ Cue = "/VO/Prometheus_0110", Text = "...Gods save you!",
				Cooldowns =
				{
					{ Name = "PrometeusSaidGodsRecently", Time = 20 }
				},
			},
		},

		MemoryAttackPerfectOutroVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			TriggerCooldowns = { "PrometheusSpokeRecently" },
			Cooldowns =
			{
				{ Name = "PrometheusMemoryOutroPlayedRecently", Time = 20 },
			},

			{ Cue = "/VO/Prometheus_0416", Text = "Enough of this." },
			{ Cue = "/VO/Prometheus_0417", Text = "Deftly evaded." },
			{ Cue = "/VO/Prometheus_0418", Text = "You saw the coming flames." },
			{ Cue = "/VO/Prometheus_0419", Text = "Eluded all of that." },
			{ Cue = "/VO/Prometheus_0420", Text = "Eluded once again." },
			{ Cue = "/VO/Prometheus_0422", Text = "You saw it all..." },
			{ Cue = "/VO/Prometheus_0425", Text = "Very clever." },
			{ Cue = "/VO/Prometheus_0424", Text = "Now dodge {#Emph}this." },
		},

		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "PrometheusSpokeRecently", Time = 18 },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "FrogFamiliarLand" },
					},
				},

				{ Cue = "/VO/Prometheus_0533", Text = "Merely a toad." },
				{ Cue = "/VO/Prometheus_0534", Text = "Wretched toad." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "CatFamiliarPounce" },
					},
				},

				{ Cue = "/VO/Prometheus_0282", Text = "Back, cat!", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0283", Text = "Get off me!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "RavenFamiliarMelee" },
					},
				},

				{ Cue = "/VO/Prometheus_0280", Text = "Begone, bird!", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0281", Text = "What is this?" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "HoundFamiliarBark" },
					},
				},

				{ Cue = "/VO/Prometheus_0284", Text = "Blasted beast.", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0285", Text = "Back off!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "PolecatFamiliarMelee" },
					},
				},
				{ Cue = "/VO/Prometheus_0535", Text = "Feral creature." },
				{ Cue = "/VO/Prometheus_0536", Text = "Well-trained..." },
				{ Cue = "/VO/Prometheus_0538", Text = "Back off, beast." },
			},

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
				{ Name = "PrometheusSpokeRecently", Time = 20 },
			},
			GameStateRequirements =
			{
			},

			{ Cue = "/VO/Prometheus_0202", Text = "Inconsequential." },
			{ Cue = "/VO/Prometheus_0203", Text = "Negligible." },
			{ Cue = "/VO/Prometheus_0204", Text = "Strange..." },
			{ Cue = "/VO/Prometheus_0205", Text = "I saw that..." },
			{ Cue = "/VO/Prometheus_0206", Text = "Connected..." },
			{ Cue = "/VO/Prometheus_0207", Text = "Anticipated me..." },
			{ Cue = "/VO/Prometheus_0208", Text = "This is nothing..." },
			{ Cue = "/VO/Prometheus_0209", Text = "Caught me..." },
			{ Cue = "/VO/Prometheus_0210", Text = "{#Emph}Ah{#Prev}, yes." },
			{ Cue = "/VO/Prometheus_0211", Text = "Is that all?" },
			{ Cue = "/VO/Prometheus_0212", Text = "No you don't." },
			{ Cue = "/VO/Prometheus_0213", Text = "You'll regret that...",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Prometheus_0240" },
					},
				},
			},
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.05,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "PrometheusSpokeRecently", Time = 20 },
			},
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
					Comparison = ">=",
					Value = 0.05,
				},
			},

			{ Cue = "/VO/Prometheus_0214", Text = "{#Emph}Eugh..." },
			{ Cue = "/VO/Prometheus_0215", Text = "You..." },
			{ Cue = "/VO/Prometheus_0216", Text = "{#Emph}Heh." },
			{ Cue = "/VO/Prometheus_0217", Text = "What..." },
			{ Cue = "/VO/Prometheus_0218", Text = "How...?" },
			{ Cue = "/VO/Prometheus_0219", Text = "I should've..." },
			{ Cue = "/VO/Prometheus_0220", Text = "You just..." },
			{ Cue = "/VO/Prometheus_0221", Text = "But I..." },
		},

		DefeatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Prometheus_01", SubtitleColor = Color.PrometheusVoice },

				{ Cue = "/VO/Prometheus_0262", Text = "This... changes... nothing..." },
				{ Cue = "/VO/Prometheus_0263", Text = "{#Emph}Heh... heheheheh... ungh..." },
				{ Cue = "/VO/Prometheus_0264", Text = "I should have... expected this..." },
				{ Cue = "/VO/Prometheus_0265", Text = "I've suffered... worse... {#Emph}urgh..." },
				{ Cue = "/VO/Prometheus_0266", Text = "This... too... shall... pass..." },
				{ Cue = "/VO/Prometheus_0268", Text = "All... according... to plan..." },
				{ Cue = "/VO/Prometheus_0269", Text = "You gods... I hate... you all...", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0270", Text = "Was there nothing... I could have done...?" },
				{ Cue = "/VO/Prometheus_0461", Text = "Such wrath... hold onto it..." },
				{ Cue = "/VO/Prometheus_0463", Text = "I am surpassed... but never beaten..." },
				{ Cue = "/VO/Prometheus_0464", Text = "You gods... have much... to learn..." },
				{ Cue = "/VO/Prometheus_0465", Text = "This was to be my future, then..." },
				{ Cue = "/VO/Prometheus_0466", Text = "You cannot break me; that I know." },
				{ Cue = "/VO/Prometheus_0467", Text = "The strength of Hades... blast..." },
				{ Cue = "/VO/Prometheus_0468", Text = "Far worse... awaits... above..." },
				{ Cue = "/VO/Prometheus_0470", Text = "I shall never... submit to you..." },
				{ Cue = "/VO/Prometheus_0472", Text = "Who would have... fought for you...?" },
				{ Cue = "/VO/Prometheus_0446", Text = "So... swift... {#Emph}urgh..." },
				{ Cue = "/VO/Prometheus_0447", Text = "In the blink... of an eye..." },
				{ Cue = "/VO/Prometheus_0448", Text = "I could not... keep up..." },
				{ Cue = "/VO/Prometheus_0462", Text = "My wounds... shall heal again...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "PrometheusBossMiscDefeat14" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0449", Text = "You're... far too quick...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">=", Value = 0.6 },
						},
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Name = "P_Boss01", Count = 3 },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0471", Text = "You know... what lies... ahead...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0469", Text = "Even with Heracles, I... {#Emph}urgh...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/Prometheus_0460", Text = "I cannot stop you... yet I fight...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Name = "P_Boss01", Count = 3 },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0267", Text = "I did... what needed... to be done...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "PrometheusBossMiscDefeat06" }
						},
					},
				},
				{ Cue = "/VO/Prometheus_0271", Text = "I knew... this would happen... yet...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasNone = { "PrometheusBossMiscDefeat03" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0473", Text = "Go give... that monster... hell...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},

				--[[
				{ Cue = "/VO/Prometheus_0107", Text = "...We'll meet again...!", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0108", Text = "...Curse you gods...!" },
				{ Cue = "/VO/Prometheus_0109", Text = "...I'll get you gods for this!" },
				{ Cue = "/VO/Prometheus_0110", Text = "...Gods save you!" },
				{ Cue = "/VO/Prometheus_0254", Text = "...We're not finished!" },
				{ Cue = "/VO/Prometheus_0255", Text = "...This changes nothing!" },
				{ Cue = "/VO/Prometheus_0256", Text = "...I shall be back!" },
				{ Cue = "/VO/Prometheus_0257", Text = "...Time cannot be stopped!", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0258", Text = "...Aetos, we fly!" },
				{ Cue = "/VO/Prometheus_0259", Text = "...Fly, Aetos!" },
				{ Cue = "/VO/Prometheus_0260", Text = "...Get us out, Aetos!" },
				{ Cue = "/VO/Prometheus_0261", Text = "...You'll never defeat us!" },
				]]--
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
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 8.5,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_2518", Text = "...He's gone.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2519", Text = "Did he know he'd lose...?" },
				{ Cue = "/VO/MelinoeField_2520", Text = "Go lick your wounds." },
				{ Cue = "/VO/MelinoeField_2521", Text = "Saw that coming." },
				{ Cue = "/VO/MelinoeField_2522", Text = "Enough of his foresight." },
				{ Cue = "/VO/MelinoeField_3742", Text = "They're in league...",
					PlayFirst = true, PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_5202", Text = "They're tough...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3742" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_5203", Text = "How long have they conspired...?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3742" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_5204", Text = "So long, you two...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/MelinoeField_5202", "/VO/MelinoeField_5203" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2523", Text = "See you later!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Prometheus" },
							Comparison = ">=",
							Value = 5,
						},
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},

			},

		},

		BossIntroTextLineSets =
		{
			PrometheusFirstMeeting =
			{
				PlayOnce = true,
				{ Cue = "/VO/Prometheus_0002",
					Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "{#Emph}Ah{#Prev}, here comes the unexpected wrinkle in my master's plan! I know who you are, lost daughter of Hades, and I know that you know who I am. I had a premonition of this very moment." },

				{ Cue = "/VO/MelinoeField_2381", UsePlayerSource = true,
					Text = "Lord Prometheus, I presume. You must have premonitions all the time. I'd not heard you were liberated, or that Chronos is the master you serve. Solidarity between Titans, then?" },

				{ Cue = "/VO/Prometheus_0003",
					Text = "Call it a change of heart. I was a coward and a fool, you see; to have sided once with gods against my kind. But no more. This is my attempt at atonement." },

				{ Cue = "/VO/MelinoeField_2382", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "What, by leading this reckless assault? I never took you for a coward, but you remain a fool." },

				{ Cue = "/VO/Prometheus_0004",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Perhaps you're right; but I shall be a victorious fool, at least. For I have seen you stand no chance at all." },
			},

			PrometheusWonAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
					},
				},
				{ Cue = "/VO/Prometheus_0007",
					Text = "You know what lies beyond, and still returned. I knew you would, of course, yet I don't know why. Because you won't tell me..." },

				{ Cue = "/VO/MelinoeField_2384", UsePlayerSource = true,
					Text = "That's right. Your nonsense riddles are a bigger threat to my health than you, or your blasted Eagle pet for that matter." },

				{ Cue = "/VO/Prometheus_0008",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The threat you face is beyond your understanding; that is the only reason you persevere. Your ignorance is a {#Emph}gift! {#Prev}Much like the fire that I shared with mortalkind, and now with you." },
			},
			PrometheusWonAgainstHim02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0031",
					Text = "I know your capability and can anticipate your every move, but... there are times my mind leads me astray, you see. Anticipating possibilities that do not come to pass... resulting in all too many mistakes." },
				{ Cue = "/VO/MelinoeField_2553", UsePlayerSource = true,
					Text = "Mistakes such as revealing this to me, or being here at all. Have you learned nothing from your past imprisonment?" },
				{ Cue = "/VO/Prometheus_0032",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "To be imprisoned is to be denied the opportunity to learn. A cruel form of torture in itself, but I did learn something, yes: I cannot break." },
			},

			PrometheusLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Prometheus" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0009",
					Text = "I know you think that you can get past me, if you but continue to try, and to try, and to try. The truth is you shall! Perhaps not this night, but inevitably nonetheless." },
				{ Cue = "/VO/MelinoeField_2385", UsePlayerSource = true,
					Text = "At least you saved me some suspense. If I knew every outcome as does the infamous Titan of Foresight, perhaps I too would become a disaffected, traitorous wretch." },
				{ Cue = "/VO/Prometheus_0010",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "What would you know of my plight?! You, who flail against Time itself? So much courage born of pride. Come then, Agent of Change, and show me what I know you can do!" },
			},
			PrometheusLostAgainstHim02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "SpawnRecord", "Eagle" },
					},
				},
				{ Cue = "/VO/Prometheus_0033",
					Text = "Aetos has excellent vision, of course. Saw you since you first set foot at the base of the mountain. Slowed you down, perhaps, but still... I knew you'd be here now." },
				{ Cue = "/VO/MelinoeField_2722", UsePlayerSource = true,
					Text = "Truly? And what shall be the outcome of our confrontation {#Emph}this {#Prev}time, since you know everything? Same as the last?" },
				{ Cue = "/VO/Prometheus_0034",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If you knew, the outcome would invariably be rather different than the one that's imminent. Though I suppose I can at least give you a hint..." },
			},

			-- alt below
			PrometheusAboutAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PrometheusAboutAltFight01_B" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_3551", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Heracles! What are you doing, fraternizing with our foe?" },
				{ Cue = "/VO/Heracles_0212",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					-- PreLineAnim = "Heracles_Hub_Greet", -- slow flex
					-- PreLineAnim = "Heracles_Hub_Granting", -- finger point
					-- PreLineAnim = "Heracles_Hub_Brooding", -- quick flex
					Text = "{#Emph}Our {#Prev}foe? {#Emph}Heh. {#Prev}Well you were right again, Prometheus. So then what now? She finally caught us in the act." },
				{ Cue = "/VO/Prometheus_0300",
					Text = "We fight is what, big man; slow her at least. She shall not tell a soul that you were here. The damage it would cause her family would be catastrophic if she did." },
				{ Cue = "/VO/MelinoeField_3552", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnimTarget = 768168,
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "So then you're {#Emph}both {#Prev}traitors. And you expect me not to notify Lord Zeus and the others? Heracles, he's your {#Emph}father! {#Prev}Yet you would turn on him?" },
				{ Cue = "/VO/Heracles_0214",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Don't we all? Besides, the Titan of Foresight here knew I would, and who am I to argue? Now allow me and my club to ensure you'll forget what you have seen." },
				--[[
				{ Cue = "/VO/Heracles_0214_B",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The Titan of Foresight here knew I would, and who am I to argue? Now allow me and my club to ensure you'll forget what you have seen." },
				]]--
			},
			PrometheusAboutAltFight01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PrometheusAboutAltFight01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_3999", UsePlayerSource = true,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}Heracles! {#Prev}What are you doing, fraternizing with {#Emph}him? {#Prev}You're supposed to be defending this mountain like before!" },
				{ Cue = "/VO/Heracles_0213",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					-- PreLineAnim = "Heracles_Hub_Greet", -- slow flex
					-- PreLineAnim = "Heracles_Hub_Granting", -- finger point
					-- PreLineAnim = "Heracles_Hub_Brooding", -- quick flex
					Text = "{#Emph}Fraternizing! Heh. {#Prev}Well you were right again, Prometheus. So then what now? She finally caught us in the act." },
				{ Cue = "/VO/Prometheus_0301",
					Text = "We fight is what, big man; slow her at least. She shall not tell a soul that you were here. Her family is in no position to absorb the truth of it, at least not now, or soon." },
				{ Cue = "/VO/MelinoeField_4000", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnimTarget = 768168,
					PreLineAnim = "Heracles_Hub_Greet",
					Text = "I don't know, this sounds a little treasonous. Yet you expect me not to notify Lord Zeus and the others? Heracles, he's your {#Emph}father! {#Prev}Of all the gods, you'd even turn on {#Emph}him?" },
				{ Cue = "/VO/Heracles_0214",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Don't we all? Besides, the Titan of Foresight here knew I would, and who am I to argue? Now allow me and my club to ensure you'll forget what you have seen." },
				--[[
				{ Cue = "/VO/Heracles_0214_B",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The Titan of Foresight here knew I would, and who am I to argue? Now allow me and my club to ensure you'll forget what you have seen." },
				]]--
			},

			-- lost to them in VoR
			PrometheusAboutAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
								Comparison = ">",
								Value = 0,
							},
						},
						{
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Heracles" },
								Comparison = ">",
								Value = 0,
							},
						},
					},
				},
				{ Cue = "/VO/Prometheus_0302",
					Text = "Agent of Change! I of course foresaw my own defeats. As to whether you can stop both Heracles {#Emph}and {#Prev}me, you'll find there are far fewer paths to that outcome." },
				{ Cue = "/VO/Heracles_0215",
					Source = "NPC_Heracles_01",
					PreLineAnimTarget = 768168,
					PreLineAnim = "Heracles_Hub_Granting",
					Text = "Is it necessary that you tell this witch such things, Flame Thief? Leave her to figure it out the hard way." },
				{ Cue = "/VO/Prometheus_0303",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I knew you'd say that, man. And you've the right of it of course; we are not here for conversation. {#Emph}Nor is she." },
			},
			-- beat them in VoR
			PrometheusAboutAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Heracles" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0304",
					Text = "If there exists a downside to having the ferocious strength of Heracles at one's call, it must be overconfidence. How could we possibly not prevail, I theorized. Well... there were ways." },
				{ Cue = "/VO/Heracles_0216",
					Source = "NPC_Heracles_01",
					Text = "You ought have told me of these ways, Flame Thief. For I am unaccustomed to defeat. It's fortunate we have no onlookers, for all the smoke and ash..." },
				{ Cue = "/VO/MelinoeField_3750", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "If you two would like to keep this lovely conversation going, I've no great impulse to break it up. But you're going to force me to fight, I suppose." },
				{ Cue = "/VO/Prometheus_0305",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It's ultimately why we're here, so {#Emph}yes. {#Prev}Where you're going, Change follows. And Change does not come without conflict." },
			},
			PrometheusAboutAltFight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesGift03" },
					},
				},
				{ Cue = "/VO/MelinoeField_3751", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Heracles! What do you have to say for yourself in all this? Are {#Emph}you {#Prev}the one who broke Prometheus from his bonds?" },
				{ Cue = "/VO/Heracles_0217",
					Source = "NPC_Heracles_01",
					Text = "You'll get no answers from me, sister; only a splitting headache. You're better off demanding truths from the Titan standing by my side, who speaks them willingly." },
				{ Cue = "/VO/Prometheus_0306",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Truths are only truths if they're believed. And no matter what I tell our adversary, she shall not believe me; not entirely at least... the splitting headache is the better course for now." },
			},
			-- deactivated VoR
			PrometheusAboutAltFight05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
				},
				{ Cue = "/VO/MelinoeField_3752", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "No sign of your big friend. It seems you'll have to contend with me on your own, since I'm ignoring your {#Emph}bird." },
				{ Cue = "/VO/Prometheus_0307",
					Text = "My {#Emph}big friend{#Prev}, as you call him, answers to a higher power, and I know that you know what it is. You wish to face the two of us again... you know precisely how." },
				{ Cue = "/VO/MelinoeField_3928", UsePlayerSource = true,
					Text = "And why would I possibly wish to go through {#Emph}that {#Prev}again? You're enough on your own, without also having to evade a club twice my size." },
				{ Cue = "/VO/Prometheus_0308",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're eager to please! To do that which you're called upon to do. That's why you're here. And that's why Heracles shall be here again not very long from now." },
			},

			PrometheusAboutAltFight05_2 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutAltFight05" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
				},
				{ Cue = "/VO/MelinoeField_3929", UsePlayerSource = true,
					Text = "Aetos has you to himself again! They say that Heracles once slew an entire flock of voracious birds... must make yours a bit uneasy." },

				{ Cue = "/VO/Prometheus_0311",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your insincere concern is meaningless to me. You gods have a shared purpose, merely to reassert your dominance. We share a purpose, too! But one completely different from your own." },
			},

			-- re-activated VoR
			PrometheusAboutAltFight06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
				},
				{ Cue = "/VO/Prometheus_0309",
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "You see, big man? She didn't keep you waiting long at all. Though I know how much you detest having your labors dictated by goddesses or gods." },

				{ Cue = "/VO/Heracles_0218",
					Source = "NPC_Heracles_01",
					Text = "I grow accustomed to it more and more. Relieves me of having to make hard choices; I need but make the easy ones, such as which bones to shatter first." },

				{ Cue = "/VO/Prometheus_0310",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And I look forward to seeing what you decide; though I already know, of course..." },
			},

			PrometheusAboutAltFight07 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/MelinoeField_3753", UsePlayerSource = true,
					Text = "We have some matters to discuss, Prometheus! So why not ask your big friend there to step aside? It would be rather rude of him to eavesdrop on our private conversations." },

				{ Cue = "/VO/Prometheus_0312",
					Text = "You shall not believe this for some time, Agent of Change, but Heracles {#Emph}can {#Prev}be trusted... certainly not in your present case, but still." },

				{ Cue = "/VO/Heracles_0219",
					Source = "NPC_Heracles_01",
					Text = "I care next to naught for what you say, sister. You wish for me to step aside, make me. Either here and now, or by whichever means you got me to show up." },

				{ Cue = "/VO/MelinoeField_3754", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "Well since the both of you are here, I just want you to know: Neither one of you is as strong as you look." },

				{ Cue = "/VO/Prometheus_0313",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You underestimate our combined strength, though not for much longer. Let's show her, Heracles!" },
			},

			PrometheusAboutAltFight08 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0316",
					Text = "If I may, Heracles? It is not necessary to converse with her like this. We could simply attack without warning." },

				{ Cue = "/VO/Heracles_0232",
					Source = "NPC_Heracles_01",
					Text = "I'm only making conversation here because of {#Emph}you. {#Prev}No need to persuade me about the benefits of attack without warning." },

				{ Cue = "/VO/Prometheus_0317",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then it's settled! We agree to keep her guessing. Even though we're going to fall back on old habits, with me doing most of the talking henceforth." },
			},

			PrometheusAboutAltFight09 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
					},
				},
				{ Cue = "/VO/MelinoeField_3755", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}You{#Prev}, Heracles! When we meet elsewhere it's as though nothing's changed, and still you face me here? I knew you for a great warrior, but you're just a great actor!" },

				{ Cue = "/VO/Heracles_0220",
					Source = "NPC_Heracles_01",
					Text = "We're all actors throughout our wretched lives, sister. And don't you dare address me here again; this is the Flame Thief's fight. I'm merely the supporting actor here." },

				{ Cue = "/VO/Prometheus_0314",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And is this not a fitting stage on which we're to perform before the gods? Including whichever dark gods you yourself invoked, forcing obedient Heracles to answer their call. Let's give them what they desire!" },
			},

			PrometheusAboutAltFightHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0221",
					Source = "NPC_Heracles_01",
					Text = "Why don't I take point for a while here, Flame Thief? There are such times as you are liable to talk too much." },
				{ Cue = "/VO/Prometheus_0315",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'd say I thought you'd never ask, big man, but we both know the truth. I don't foresee the two of you speaking for long." },
			},
			PrometheusAboutAltFightHeracles02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Heracles" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0222",
					Source = "NPC_Heracles_01",
					Text = "Been so long since I last lost a fight, that I'd forgotten how it felt. The shame... the anger... the blood boiling in my veins." },

				{ Cue = "/VO/MelinoeField_3756", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "And it probably doesn't make you feel any better knowing Prometheus there was certain you were going to lose." },

				{ Cue = "/VO/Heracles_0223",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No. But something else also occurred: I found myself longing to fight again. To tear my enemies to pieces. I still can suppress the worst part, but I thought all of it was gone..." },
			},
			PrometheusAboutAltFightHeracles03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/MelinoeField_3757", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "When first we met, you said you work alone, Heracles sir. Yet here you are cooperating with this Titan, and I'd say even that Eagle too. Another one of your lies, then?" },

				{ Cue = "/VO/Heracles_0224",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					Text = "Who says I'm working, sister? For all you know, this is what I do for sake of recreation. My work and interests coincide." },

				{ Cue = "/VO/MelinoeField_3758", UsePlayerSource = true,
					Text = "You expect me to believe you're here because you want to be, and not because the will of Night demanded it? I know you haven't shown up by coincidence alone." },

				{ Cue = "/VO/Heracles_0225",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Believe {#Prev}whatever you like. Now, {#Emph}I {#Prev}believe it's time to drive this club into your skull; not for business, but for {#Emph}pleasure." },
			},
			PrometheusAboutAltFightHeracles04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
				},
				{ Cue = "/VO/Heracles_0226",
					Source = "NPC_Heracles_01",
					Text = "It's dark out there, sister. Yet you always seem to find your way, stalking around like a {#Emph}cat. {#Prev}Know what I do to cats?" },

				{ Cue = "/VO/MelinoeField_3759", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Apparently you turn them into fashionable pelts! Well you're not doing that to {#Emph}me. {#Prev}How would it even work? I'm too small." },

				{ Cue = "/VO/Heracles_0227",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're too {#Emph}clever. {#Prev}How about you keep talking, while I let my club do the rest of the talking for {#Emph}me." },
			},
			PrometheusAboutAltFightHeracles05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 20,
					},
				},
				{ Cue = "/VO/Heracles_0228",
					Source = "NPC_Heracles_01",
					Text = "Whatever it is you do to get me to show up, tonight you must have done a lot of it, sister. It's crawling out there..." },

				{ Cue = "/VO/MelinoeField_3760", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "Is that a touch of fear in the voice of mighty Heracles? Though I ought to be the one afraid, having to confront you and Prometheus like this. He knows it's going to get {#Emph}ugly." },

				{ Cue = "/VO/Heracles_0229",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "When does it ever not? But this is nothing. You wish to know true fear, go train under the Centaur Chiron for a while..." },
			},
			PrometheusAboutAltFightHeracles06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Heracles" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Heracles_0230",
					Source = "NPC_Heracles_01",
					Text = "I never used to lose. Felt like the Flame Thief here probably does, knowing the outcome of every battle. Not anymore..." },

				{ Cue = "/VO/MelinoeField_3761", UsePlayerSource = true,
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					Text = "Surely the added bit of unexpectedness helps keep things livelier and more entertaining for you now." },

				{ Cue = "/VO/Heracles_0231",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No. I never used to lose, but I never liked surprises, either. So, all in all, things lately haven't gone too well for my career..." },
			},

			-- low health & similar
			PrometheusLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Prometheus_0049",
					Text = "I knew your injuries would be this grave, though perhaps you did not. Nothing a little {#Emph}time {#Prev}can't eventually heal of course." },
				{ Cue = "/VO/MelinoeField_2733", UsePlayerSource = true,
					Text = "I'm grateful for your concern, though best mind your {#Emph}own {#Prev}injuries. Those bandages... you aren't at your peak. Although perhaps this means we'll have a fairer fight." },
				{ Cue = "/VO/Prometheus_0050",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "My wounds have long since been a hindrance to me. I do not let them fully heal, so I am always cognizant of what I'm fighting for. And Aetos here appreciates it, too." },
			},
			-- alt below
			PrometheusLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.5, },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PrometheusLowHealth02_B" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsNone = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0128",
					Text = "My forces almost stopped you but they didn't quite succeed. Yet even now you're outnumbered against Aetos and me." },
				{ Cue = "/VO/MelinoeField_2883", UsePlayerSource = true,
					Text = "The prospect of exacting vengeance on your troublesome Eagle, if not you yourself, helps keep me going. Shall we commence?" },
				{ Cue = "/VO/Prometheus_0129",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes. I mustn't keep you waiting. For I know who shall have their vengeance here, and I'm eager for {#Emph}you {#Prev}to find out." },
			},
			PrometheusLowHealth02_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.5, },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PrometheusLowHealth02" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0128_B",
					Text = "My forces almost stopped you but they didn't quite succeed. Now you're against Aetos and me." },
				{ Cue = "/VO/MelinoeField_2883", UsePlayerSource = true,
					Text = "The prospect of exacting vengeance on your troublesome Eagle, if not you yourself, helps keep me going. Shall we commence?" },
				{ Cue = "/VO/Prometheus_0129",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes. I mustn't keep you waiting. For I know who shall have their vengeance here, and I'm eager for {#Emph}you {#Prev}to find out." },
			},
			PrometheusLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = ">",
						Value = 0,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.4, },
					},
				},
				{ Cue = "/VO/Prometheus_0130",
					Text = "How can you hope to surpass me in such a wretched state? Perhaps if I were bound in chains and my liver half-eaten this would have been more of an even match." },

				{ Cue = "/VO/MelinoeField_2884", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm not under the impression that you seek sporting competition here, Prometheus. Now let's get on with it." },

				{ Cue = "/VO/Prometheus_0131",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "A sporting competition! There must be a certain thrill in not knowing a battle's outcome before it occurs. Even outcomes as likely as this." },
			},

			PrometheusPackagedBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = {
							"PackageBountyChaos",
							"PackageBountyHera",
							"PackageBountySuitLegendary",
						},
					},
				},
				{ Cue = "/VO/Prometheus_0143",
					Text = "How quickly you arrived this night! Bending the very laws of nature to achieve your goal... forging alliances with beings who care nothing for you." },
				{ Cue = "/VO/MelinoeField_2890", UsePlayerSource = true,
					Text = "I did take a shortcut, but you're wrong about the rest. I know the being to whom you refer, and they're not what you presume them to be." },
				{ Cue = "/VO/Prometheus_0144",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No...? But isn't it {#Emph}Chaos {#Prev}that delivers you so close to your goal, yet shall let you go no farther... even if you should prevail here? I know where this all leads; let's see it through!" },
			},
			PrometheusAboutRandomBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.AllRandomPackagedBounties,
					},
				},
				{ Cue = "/VO/Prometheus_0334",
					Text = "What has the whim of Chaos wrought, that our existence led us to this point, in opposition to each other endlessly?" },
				{ Cue = "/VO/MelinoeField_3979", UsePlayerSource = true,
					Text = "You're welcome to surrender at any point, Titan. I'm certain that Chaos would find it terribly amusing if you did." },
				{ Cue = "/VO/Prometheus_0335",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "As would you, I suppose. But no such outcome ever shall occur, of that you can be certain. Perhaps, however, we may yet provide to Chaos some amusement anyway." },
			},

			-- other responses
			PrometheusAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Prometheus_0037",
					Text = "You gods coerced all mortalkind into worshiping you, and for what? You've nothing to gain by slaughtering them at your whim. Leave them be!" },

				{ Cue = "/VO/MelinoeField_2724", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'll be sure to put in the request with my Lord Uncle Zeus, if you could go ahead and let me past so I can pay him a visit." },

				{ Cue = "/VO/Prometheus_0038",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your Lord Uncle had me bound to a mountain for aeons, so that Aetos here could feast upon my flesh for all that time. Aetos came around eventually, but Zeus...? He never shall." },
			},
			PrometheusAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
					},
				},
				{ Cue = "/VO/MelinoeField_2725", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Why do you care so much for mortals, anyhow? Their lives are short, their flesh is weak. Only in death do many of them finally begin to gain some sense." },

				{ Cue = "/VO/Prometheus_0039",
					Text = "Any laborer of skill cares for their work. Mortals! Poor sods created in the image of the gods, yet forced to be inferior, so that they could never achieve what my master and I now intend." },

				{ Cue = "/VO/MelinoeField_2726", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You mean to say that {#Emph}you {#Prev}fashioned mortalkind? Then stole the fire from this mountain for {#Emph}their {#Prev}sake? Absurd." },

				{ Cue = "/VO/Prometheus_0040",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The truth can be difficult to absorb. Mortals live only to suffer; as I'm responsible for that, I sought to take some of their suffering from them. And redistribute it to all of you." },
			},
			PrometheusAboutMortals03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Prometheus_0118",
					Text = "Gods could learn something from mortals, you know. For all their many failings, they have an admirable tendency to cling to hope; a certain quality we deathless often lack." },

				{ Cue = "/VO/MelinoeField_2737", UsePlayerSource = true,
					Text = "Hope can be the salve for the naive. So many mortals hope they'll never die; a feeling born of delusion and fear." },

				{ Cue = "/VO/Prometheus_0119",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes! Mortals live short, painful lives. And even still they strive for something greater than they mostly can achieve. I fight for {#Emph}them! {#Prev}You gods fight only for {#Emph}yourselves." },
			},

			PrometheusAboutWorship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutPrometheus02" },
					},
				},
				{ Cue = "/VO/MelinoeField_3972", UsePlayerSource = true,
					Text = "It seems the mortals whom you love so much don't all reciprocate, Prometheus. For all you claim to have done, they still don't worship you." },
				{ Cue = "/VO/Prometheus_0365",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nor shall they ever, I know. Perhaps make cautionary tales I've inspired but that's it. Fortunately, I don't require affirmation; they can save their Nectar and Ambrosia for {#Emph}you." },
			},

			PrometheusAboutGoldenAge01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0114",
					Text = "Resist all you like, yet the age of gods shall end! {#Emph}Time {#Prev}shall see to it. And thereafter, a Golden Age of enlightenment shall begin, in which you gods hold far less sway." },

				{ Cue = "/VO/MelinoeField_2735", UsePlayerSource = true,
					Text = "If I somehow gave you the impression that I'm interested in your doomsaying and false prophecies, I assure you, I'm not." },

				{ Cue = "/VO/Prometheus_0115",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your disregard is the very reason you're no longer fit to rule. I know you'll never relinquish this mountain; fall with it, then!" },
			},

			PrometheusAboutPlans01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0035",
					Text = "My master's plan of course requires time. The objective here is not to stop you permanently, but to slow you down." },

				{ Cue = "/VO/MelinoeField_2723", UsePlayerSource = true,
					Text = "Unless you just can't help revealing vital information to your enemies, I'm going to assume you're spouting this drivel to mislead me. Either way, my own objective remains the same." },

				{ Cue = "/VO/Prometheus_0036",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes, bullheadedness is one of your family's defining traits. Then let us execute our respective plans; there is a possibility that mine shall succeed here beyond measure." },
			},

			PrometheusAboutForesight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PrometheusAboutForesight02", "PrometheusAboutForesight03" }, Min = 3 },
					},
				},
				{ Cue = "/VO/MelinoeField_2728", UsePlayerSource = true,
					Text = "Why bother talking to me all these nights, Titan? If you know everything I'm going to say. How tedious your life must be." },
				{ Cue = "/VO/Prometheus_0043",
					Text = "It used to be much worse! But to your point, I would not wish the curse of foresight unto anyone... except perhaps the worst of all my enemies. And you are not yet one." },
				{ Cue = "/VO/MelinoeField_2729", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Oh? I'll have to work harder to earn that distinction, then. And when I set my mind to something, I typically succeed." },
				{ Cue = "/VO/Prometheus_0044",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am aware. But I also know that pride, one of the defining traits of your kind, tends to precede a fall. You shall see where all your certainty gets you." },
			},

			PrometheusAboutForesight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PrometheusAboutForesight01", "PrometheusAboutForesight03" }, Min = 3 },
					},
				},
				{ Cue = "/VO/Prometheus_0045",
					Text = "You have questions for me about a great many things... I shall not answer them, not yet. The words must first escape your lips, for one." },
				{ Cue = "/VO/MelinoeField_2730", UsePlayerSource = true,
					Text = "How about I save my breath instead? You won't know what I'm going to say if I never say it." },
				{ Cue = "/VO/Prometheus_0046",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yet your heart if not your eyes and ears suggest to you that I am not the liar that your mind believes me to be. We stand in opposition nonetheless." },
			},

			PrometheusAboutForesight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PrometheusAboutForesight01", "PrometheusAboutForesight02" }, Min = 3 },
					},
				},
				{ Cue = "/VO/Prometheus_0120",
					Text = "The question you're about to ask is mocking nonsense to supplant the more important subject troubling you now. Go on! I cannot respond if you hold back." },
				{ Cue = "/VO/MelinoeField_2738", UsePlayerSource = true,
					Text = "No. You have no control over me or my future. And don't worry, I'm {#Emph}not {#Prev}going to hold back." },
				{ Cue = "/VO/Prometheus_0121",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I knew you would react this way, but knew no other way to broach the subject. How often I create the outcomes I'm attempting to prevent..." },
			},

			PrometheusAboutForesight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutForesight01", "PrometheusAboutForesight02", "PrometheusAboutForesight03", "PrometheusAboutForesight05" }
					},
					{
						Path = { "GameState", "EnemyKills", "Prometheus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/MelinoeField_2739", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Answer me this one question, Titan. If you know everything the future holds, why make the choices leading to the awful punishment that you endured? Why let yourself get caught?" },
				{ Cue = "/VO/Prometheus_0122",
					Text = "Our choices can reverberate through time, creating outcomes of far greater consequence. If not for my imprisonment, I wouldn't be here now; where I must be." },
				{ Cue = "/VO/MelinoeField_2740", UsePlayerSource = true,
					Text = "You suffered as you did just so I could beat you up some more tonight? You're a fraud... making unprovable claims to sound righteous and wise." },
				{ Cue = "/VO/Prometheus_0123",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You, of all gods, ought to understand something of sacrifice... but for now, at least, it matters not. I've nothing to prove to you, no secrets I'm willing to share; only my rage." },
			},

			PrometheusAboutForesight05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutForesight01", "PrometheusAboutForesight02", "PrometheusAboutForesight03", "PrometheusAboutForesight04" }
					},
					{
						Path = { "GameState", "EnemyKills", "Prometheus" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/MelinoeField_2880", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Either you're a liar when it comes to your supposed foresight, or you're letting me win. Who doesn't want a good thrashing from some witch every so often?" },
				{ Cue = "/VO/Prometheus_0124",
					Text = "The difference between you and me is that you merely can suspect and theorize, whilst I know for certain. Yet there are truths that I cannot impart." },
				{ Cue = "/VO/MelinoeField_2881", UsePlayerSource = true,
					Text = "That's quite all right, I didn't think you would. I can change the future with my actions whether I know what the future holds or not." },
				{ Cue = "/VO/Prometheus_0125",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Take it from me, Agent of Change: The more you know of the future, the less likely you are to shape it as you desire." },
			},

			PrometheusAboutFuture01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Prometheus_0041",
					Text = "I know what you're about to say, Agent of Change, and caution you: {#Emph}Don't say it. {#Prev}Should you verbalize your thoughts, the outcome shall be of no benefit to either of us." },
				{ Cue = "/VO/MelinoeField_2727", UsePlayerSource = true,
					Text = "Fine... just in case. But you'll forgive me if I'm a little skeptical that we changed the course of history like this." },
				{ Cue = "/VO/Prometheus_0042",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You still don't understand. We are as clay, the lot of us. Able to be moulded and re-moulded. One disastrous consequence we avoided; but there's no preventing the next." },
			},

			PrometheusAboutFire01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PrometheusAboutChronos01", "PrometheusAboutMortals02" }
					},
				},
				{ Cue = "/VO/Prometheus_0126",
					Text = "You, who condemn me as a criminal: Would you know {#Emph}why {#Prev}I liberated fire from this mountain, for the sake of mortalkind?" },
				{ Cue = "/VO/MelinoeField_2882", UsePlayerSource = true,
					Text = "My own increasingly strong sense of foresight indicates you're going to tell me no matter what." },
				{ Cue = "/VO/Prometheus_0127",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "When I gave mortals nourishment... the meat they would have sacrificed to you... they needed fire then, and more. But {#Emph}you hoarded all of it! {#Prev}So I saved them; and I'll do it again." },
			},

			PrometheusAboutTorch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				{ Cue = "/VO/Prometheus_0145",
					Text = "{#Emph}Ah... {#Prev}so it's to be my borrowed flames against your own this night. This could be rather entertaining if I didn't know already how it's going to play out..." },
				{ Cue = "/VO/MelinoeField_2891", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm not here for your amusement, Titan. Your stolen flame hasn't made you immune." },
				{ Cue = "/VO/Prometheus_0146",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Certainly not. And, I anticipate that Ygnium, for I know the weapons that you bear, shall rather sting. But I've felt worse." },
			},

			-- about other characters
			PrometheusAboutDora01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraAboutPrometheus02" }
					},
				},
				{ Cue = "/VO/MelinoeField_2886", UsePlayerSource = true,
					Text = "Tell me, Titan: Do you recall a mortal woman by the name of Dora? Her Shade responded strangely when I mentioned you, but can't seem to remember what you did." },
				{ Cue = "/VO/Prometheus_0137",
					Text = "Best leave it be, Agent of Change. That old Shade's latent memories have more to do with gods and their deceptions than with anything I did." },
				{ Cue = "/VO/MelinoeField_2887", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Elaborate! Tell me what happened to her. You keep blaming everything on the gods, as though all this is solely their responsibility." },
				{ Cue = "/VO/Prometheus_0138",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh{#Prev}, on the contrary, I take responsibility for mortalkind. But for all their failings, vices, and downfalls, I am not to blame. Nor is this {#Emph}Dora. {#Prev}You tell her I said that." },
			},
			PrometheusAboutDora02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraAboutPrometheus03", "DoraGrantsCosmeticsShop01", "DoraBathHouse02" }
					},
				},
				{ Cue = "/VO/Prometheus_0139",
					Text = "Your companion, Dora... she does not remember me, not yet. But she shall! And in so doing, remember why she chose to forget me to begin with... and forget so much more." },
				{ Cue = "/VO/MelinoeField_2888", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You say she's not to blame for the failings of mortalkind, as though she could have carried such a burden to begin with. What happened? How do you know her?" },
				{ Cue = "/VO/Prometheus_0140",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That one is haunted by her past, as you can see. But, it is not my place to tell you any more than I already have, lest she recall too much, too quickly. {#Emph}All in due time{#Prev}, as my master would say." },
			},
			PrometheusAboutDora03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories02" },
					},
				},
				{ Cue = "/VO/MelinoeField_3951", UsePlayerSource = true,
					Text = "You {#Emph}do {#Prev}know Dora, don't you? She and some brother of yours... they were {#Emph}wed? {#Prev}And somehow this resulted in her letting loose all sorts of daemons in the mortal world?" },

				{ Cue = "/VO/Prometheus_0318",
					Text = "That is one telling of it, more or less... so she remembers, finally? Perhaps with great regret. After all this time, mortals still cannot decide whether to blame themselves or gods for their plight..." },

				{ Cue = "/VO/MelinoeField_3952", UsePlayerSource = true,
					Text = "Oh they should blame only {#Emph}gods? {#Prev}Take no responsibility for their own wretched state? Not even Dora would do that, and she's one of the most complacent beings I know. In an impressive way!" },

				{ Cue = "/VO/Prometheus_0319",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your companion Dora remembers some of the events, but this does not mean she {#Emph}understands {#Prev}any of them. Her actions pitted mortalkind against itself forever!" },
			},
			PrometheusAboutDora04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PrometheusAboutDora03", "DoraAboutMemories04" },
					},
				},
				{ Cue = "/VO/MelinoeField_3953", UsePlayerSource = true,
					Text = "What became of Dora's husband? Your brother, by her recollection. He abandoned her after what happened?" },

				{ Cue = "/VO/Prometheus_0320",
					Text = "It's more correct to say that your companion Dora finally saw my scatter-minded brother for who he was. Their marriage lasted for about as long as many do." },

				{ Cue = "/VO/MelinoeField_3954", UsePlayerSource = true,
					Text = "All while you stood idly by and did nothing; but now feel bad and thus decided to shoulder this righteous cause? Perhaps to feel a bit of absolution that you never got from her." },

				{ Cue = "/VO/Prometheus_0321",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your words are harsh but for the most part accurate. Dora remembers now what your own family did to her. If she can forgive you all for that... then she's a stronger soul than I." },
			},
			PrometheusAboutDora05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PrometheusAboutDora04", "DoraAboutMemories05" },
					},
				},
				{ Cue = "/VO/Prometheus_0322",
					Text = "Look at us, Agent of Change! The daemons your companion Dora inadvertently set free... {#Emph}every ill {#Prev}that could befall mortalkind... most all of them yet plague the gods as well." },

				{ Cue = "/VO/MelinoeField_3955", UsePlayerSource = true,
					Text = "Existence has its hardships. I'm very familiar with many of these daemons, and they are nuisances; but their power has its limits, and they can be driven back." },

				{ Cue = "/VO/Prometheus_0323",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Perhaps... but mortals tend to have a harder time of it than you. Don't you see? So long as they suffer, so shall we all." },
			},

			PrometheusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "EnemyKills", "Prometheus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/MelinoeField_2731", UsePlayerSource = true,
					Text = "Perhaps your so-called master Chronos wants for you to fail... to suffer more than you already have. He seeks vengeance on the gods for overthrowing him before. When you were their ally!" },

				{ Cue = "/VO/Prometheus_0047",
					Text = "I don't seek my master's forgiveness, nor assume his loyalty. Alliances are born of shared goals, perhaps ideals; whereas the gods and I are at cross purposes." },

				{ Cue = "/VO/MelinoeField_2732", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Because they punished you for crimes you knowingly committed? What else could they have done after you deceived them, and took from them?" },

				{ Cue = "/VO/Prometheus_0048",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I took {#Emph}nothing! {#Prev}Fire spreads; burns anything that stands in its path. The gods sought to imprison it, but I set it loose. Now at last, we each are free. And burning still." },
			},

			PrometheusAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0147",
					Text = "I'm but a Titan, and unarmed. Should you get past me, however... I know that you know you're certainly no match for what awaits." },

				{ Cue = "/VO/MelinoeField_2969", UsePlayerSource = true,
					Text = "Perhaps you simply know less than you think. And now you're going to call me arrogant or something, I suppose?" },

				{ Cue = "/VO/Prometheus_0148",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I would have, yes; but since you've foreseen that outcome, it shall not come to pass. Well if you truly think you can withstand that monstrosity... let's see you withstand {#Emph}me." },
			},
			PrometheusAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				{ Cue = "/VO/Prometheus_0149",
					Text = "The monster Typhon isn't liable to stop, you know. He has your family on the back foot, cowering in your Lord Uncle's palace. Exactly where we want them." },
				{ Cue = "/VO/MelinoeField_2970", UsePlayerSource = true,
					Text = "A suitable distraction I can take advantage of... just as soon as you're out of the way, along with your bird." },
				{ Cue = "/VO/Prometheus_0150",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're telling me your plans! Now we're truly getting to know each other. I almost regret what's about to transpire." },
			},
			PrometheusAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0296",
					Text = "Do you hear that? Typhon climbs the dark side of the mountain even now. Impressive that you cast him down before... but he shall not rest till the Palace of Zeus lies in ruin." },

				{ Cue = "/VO/MelinoeField_3781", UsePlayerSource = true,
					Text = "He'll be destroyed. You along with him if that's what it takes. If he were truly unstoppable, you wouldn't be impeding my ascent. You're buying him time." },

				{ Cue = "/VO/Prometheus_0297",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am. It's strange to think that time can be a limited commodity, even for deathless such as we. But no more stalling for now." },
			},

			PrometheusAboutTyphonL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0298",
					Text = "It may have taken all your godly relatives, but they were able to resist the monster Typhon's wrath, despite the blunders that you made. Yet now you hurry back." },

				{ Cue = "/VO/MelinoeField_3782", UsePlayerSource = true,
					Text = "I realize this must be complicated for you, as someone whose loyalties are mostly to an Eagle, but I am not about to let that thing destroy everything my family built." },

				{ Cue = "/VO/Prometheus_0299",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You ought to choose your loyalties with greater care, not let them be decided by birthright. Well then, {#Emph}come on! {#Prev}You have a summit and a family to protect." },
			},

			PrometheusAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutPrometheus01" },
					},
				},
				{ Cue = "/VO/Prometheus_0116",
					Text = "{#Emph}Great Zeus {#Prev}did not have me bound and tortured merely for the supposed crime of taking fire from this mountain. No; he wanted certain information... about his eventual downfall." },
				{ Cue = "/VO/MelinoeField_2736", UsePlayerSource = true,
					Text = "So you threatened the King of the Olympians with false prophecies and he took it out on you. Perhaps not one of my Lord Uncle's proudest moments, and yet understandable. What did you tell him?" },
				{ Cue = "/VO/Prometheus_0117",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I told him {#Emph}nothing! {#Prev}Merely that his time shall come. A specific outcome that grows more likely with each passing night. {#Emph}You {#Prev}are but a wrinkle in the plan, nothing more." },
			},

			PrometheusAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
					},
				},
				{ Cue = "/VO/Prometheus_0294",
					Text = "Of all your kin on this accursed mountain, Lady Athena is the worthiest opponent. My master's legions must be keeping her quite busy, that she'd lend some of her strength to you." },

				{ Cue = "/VO/MelinoeField_3780", UsePlayerSource = true,
					Text = "You call her an opponent but have been avoiding any direct confrontations, throwing your disposable forces against her. You know you'd lose to her in a fair fight." },

				{ Cue = "/VO/Prometheus_0295",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I would. I lack her martial training, her divinity. But despite her vaunted wisdom, she, like all your kin, possesses what to mortals would be called a {#Emph}fatal flaw. {#Prev}And I know that you know what it is." },
			},

			PrometheusAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusAboutPrometheus02" }
					},
				},
				{ Cue = "/VO/MelinoeField_2893", UsePlayerSource = true,
					Text = "The gods, one of them anyway, extend an offering of peace, Prometheus! Lord Dionysus would have you as a guest of honor at his latest celebration, if you'll indulge him. Given your gift of foresight, you must know I'm entirely sincere." },
				{ Cue = "/VO/Prometheus_0132",
					Text = "My foresight only works if there is any possibility of an outcome taking place. Whatever deception you have in mind, you shall have to try harder than {#Emph}that." },
				{ Cue = "/VO/MelinoeField_2894", UsePlayerSource = true,
					Text = "You and your master are different; can you not accept that the gods aren't all aligned in their thinking, either? Dionysus wants no part in your feud!" },
				{ Cue = "/VO/Prometheus_0133",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Dionysus wants merely to drown his few remaining complicated thoughts, and seek more pleasures of the flesh. More beast than god, lacking all self-control." },
			},
			PrometheusAboutDionysus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusAboutPrometheus03" }
					},
				},
				{ Cue = "/VO/MelinoeField_2895", UsePlayerSource = true,
					Text = "Lord Dionysus was quite disappointed that you'd not accept the invitation to his feast! Is there truly not some future possibility in which you change your mind?" },
				{ Cue = "/VO/Prometheus_0134",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}None! {#Prev}I've had my liver shorn apart for aeons by good Aetos here; I'll not permit the god of wine to further damage it!" },
			},
			PrometheusAboutChaos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutChronos03" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0141",
					Text = "I know the tinge of gods, but you have something else. Something older... the mark of Chaos. The eldest, most indifferent force in existence, goaded into action!" },
				{ Cue = "/VO/MelinoeField_2889", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Not even Chaos wishes to see Chronos prevail. What does that tell you about your {#Emph}own {#Prev}decision to take sides?" },
				{ Cue = "/VO/Prometheus_0142",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It tells me that all beings are fallible, beginning with Chaos. We are {#Emph}all {#Prev}vulgar accidents, do you see? Yet still we strive toward perfection, which remains ever out of reach." },
			},

			PrometheusAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "CirceShrinkTrait", "CirceEnlargeTrait" },
					},
				},
				{ Cue = "/VO/Prometheus_0292",
					Text = "You work with enchantresses to try and gain the upper hand... but such distractions shall be of no avail against me. It is not the size of the opponent that's of consequence." },
				{ Cue = "/VO/MelinoeField_2892", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "To have recognized Madame Circe's craft, only to underestimate its potency. Your foresight evidently has its limits, Titan." },
				{ Cue = "/VO/Prometheus_0293",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That it does. But your incantations have {#Emph}their {#Prev}limitations, in kind. You would be wise not to depend on them too much." },
			},

			PrometheusAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" }
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Prometheus_0051",
					Text = "The future is a series of fixed points. Not even my master believes this to be true, but I have seen the many possibilities. The only question is... which is our destination?" },

				{ Cue = "/VO/MelinoeField_2734", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You fill my mind with this nonsense. Not even the Three Fates know entirely what the future holds, for they are always weaving." },

				{ Cue = "/VO/Prometheus_0052",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "They {#Emph}were {#Prev}always weaving, yes. I know that you know that they weave no longer now. Yet moment by moment, the future still unfolds. Let us give shape to it ourselves!" },
			},
			PrometheusAboutFates02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PrometheusAboutFates01" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Prometheus_0354",
					Text = "Where do you suppose they are, Agent of Change? The Fates, I mean. They, who set the Titans and the gods against each other to begin with, long ago." },

				{ Cue = "/VO/MelinoeField_3964", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Wherever they are, pray they can't hear you speaking ill of them. Though why ask me? You're the one who knows everything, including whether they'll ever be located or not." },

				{ Cue = "/VO/Prometheus_0355",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That I do. I but spur you to consider the possibility, and your place in their scheme; and, I suppose, in mine." },
			},

			PrometheusAboutBrothers01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 2,
					},
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0135",
					Text = "You have a brother you never even knew. I had a prideful one, a scatter-minded one, and a pathetic one bearing the weight of the world on his shoulders. Which do you suppose {#Emph}yours {#Prev}is most like?" },
				{ Cue = "/VO/MelinoeField_2885", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "No wonder you hate my family; you hate yours. Shall we proceed to try and kill each other now? I don't have all night." },
				{ Cue = "/VO/Prometheus_0136",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "My brothers and I also used to quarrel frequently. I thought I had outgrown it; become more civilized. But clearly no." },
			},

			PrometheusAboutRavenFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "RavenFamiliar" },
					},
				},
				{ Cue = "/VO/Prometheus_0338",
					Text = "You have an avian companion of your own. A scraggly and pallid raven, mediocre wingspan, lacking the raw instinct to hunt and kill like Aetos here. But still, a loyal bird." },
				{ Cue = "/VO/MelinoeField_3982", UsePlayerSource = true,
					Text = "And not once has Raki tried to rip my liver out of me. There are much more effective ways to forge bonds with animals, but you must know that now." },
				{ Cue = "/VO/Prometheus_0339",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I was in no position to negotiate with Aetos when first we met. But now he listens to me, typically... although when he identifies his prey, he can become {#Emph}quite {#Prev}fixated by it." },
			},

			-- alt below
			PrometheusAboutHeraclesKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DecayingBoostKeepsake" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B", "PrometheusAboutHeraclesKeepsake01_B" }
					},
				},
				{ Cue = "/VO/Prometheus_0336",
					Text = "You bear an artifact belonging to one whom I know, I sense it there. How did you get it...? {#Emph}Ah{#Prev}, no need to say; doubtless the gifting custom of Olympus, nothing more." },
				{ Cue = "/VO/MelinoeField_3980", UsePlayerSource = true,
					Text = "{#Emph}Gifting custom? {#Prev}You mean this Lion Fang from Heracles. What, were you counting on the son of Zeus giving his hard-fought trophy to one such as you instead?" },
				{ Cue = "/VO/Prometheus_0337",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You can be every bit as stubborn and brutish as the beast from which that tooth was torn. Yet you are unworthy of it all the same." },
			},
			PrometheusAboutHeraclesKeepsake01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DecayingBoostKeepsake" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PrometheusAboutHeraclesKeepsake01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0336",
					Text = "You bear an artifact belonging to one whom I know, I sense it there. How did you get it...? {#Emph}Ah{#Prev}, no need to say; doubtless the gifting custom of Olympus, nothing more." },
				{ Cue = "/VO/MelinoeField_3981", UsePlayerSource = true,
					Text = "You mean this Lion Fang from your friend Heracles. What, were you counting on the son of Zeus giving his hard-fought trophy to {#Emph}you {#Prev}instead?" },
				{ Cue = "/VO/Prometheus_0337",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You can be every bit as stubborn and brutish as the beast from which that tooth was torn. Yet you are unworthy of it all the same." },
			},

			PrometheusAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "F_Opening01", "F_Opening02", "F_Opening03" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Prometheus_0324",
					Text = "You have been busying yourself elsewhere... down in that Underworld of yours, no doubt. Unless you've started having greater difficulty getting to this point?" },
				{ Cue = "/VO/MelinoeField_3974", UsePlayerSource = true,
					Text = "You're the Titan of Foresight, why don't you tell me? It's a chance to prove this gift of yours is more than a tall claim." },
				{ Cue = "/VO/Prometheus_0325",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I knew you were going to say that; so that I could now take {#Emph}this {#Prev}as an opportunity to clarify that {#Emph}foresight is not mind-reading." },
			},

			-- @ ending
			PrometheusAboutUltimateProgress01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				{ Cue = "/VO/Prometheus_0342",
					Text = "Something has changed in you since when last you were here. I know what it is... and what shall happen when you finally make use of it, perhaps even tonight." },
				{ Cue = "/VO/MelinoeField_3956", UsePlayerSource = true,
					Text = "You must mean {#Emph}Disintegration of Monstrosity{#Prev}. Yes, I have something for Typhon here. You're fortunate I don't first put it to the test on {#Emph}you." },
				{ Cue = "/VO/Prometheus_0343",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Stay your threats! I know you shall not use this power against me; if gods and Titans could kill one another as mortals do, our history would have been {#Emph}much, much shorter." },
			},
			PrometheusAboutUltimateProgress02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusPalaceFirstMeeting" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeTimeStop" },
					},
				},
				{ Cue = "/VO/Prometheus_0340",
					Text = "My master does not realize what shall become of him once all is said and done; do you? How abhorrent, to try and steal away one's immortality." },

				{ Cue = "/VO/MelinoeField_3983", UsePlayerSource = true,
					Text = "I've truly heard it all. A {#Emph}thief{#Prev}, lecturing me about {#Emph}stealing! {#Prev}Chronos took my family, and more... he should realize what shall become of him." },

				{ Cue = "/VO/Prometheus_0341",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your father's father... you share some of his ancient lineage, and his obsession with the inevitable. Come get what you desire, then! But one outcome awaits as you continue down this path." },
			},

			PrometheusPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0344",
					Text = "Well, Agent of Change... the monster Typhon is eliminated and my master certainly is not himself; or rather, now he {#Emph}is. {#Prev}Many have said they knew you could do it but only {#Emph}I {#Prev}truly did. Yet you know as well as I that we're not finished." },
				{ Cue = "/VO/MelinoeField_3957", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Chronos has surrendered, but here you still are, giving his remnant legions their orders. Decided to take matters into your {#Emph}own {#Prev}thieving hands, then?" },
				{ Cue = "/VO/Prometheus_0345",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That I decided long ago, when I gave myself to your lord uncle's chains. And I still oppose you, yes. For what you seek beyond, you shall find only through the flames of battle!" },
			},
			PrometheusPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_3958", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The gods are grudgingly {#Emph}permitting {#Prev}this behavior of yours, Titan? The vandalizing of their mountain... the perpetual assaults on their defenses... fighting me?" },

				{ Cue = "/VO/Prometheus_0346",
					Text = "My master, or perhaps my {#Emph}former {#Prev}master as I now should say, wishes to undo certain perceived wrongs, as you are well aware. I merely have a part to play in this." },

				{ Cue = "/VO/MelinoeField_3959", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And you're prepared to fight eternally against me, then? For my grandfather to be absolved of the mistakes of his past, and for the future of the gods to be secured?" },

				{ Cue = "/VO/Prometheus_0347",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am prepared to fight eternally for what I believe in; and so that {#Emph}time flows freely forth{#Prev}, if that is what it takes." },
			},

			PrometheusPostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Name = "P_Boss01", Count = 2 },
					},
				},
				{ Cue = "/VO/MelinoeField_3961", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The war is over, Titan! Drop the act. You still refer to Chronos as your master, and seem no less charitable towards the gods, despite now doing this for their sake not just yours." },

				{ Cue = "/VO/Prometheus_0350",
					Text = "You know as well as I that the conditions of your climb need to approximate your prior path, if you are going to succeed. And I admit that the result I seek would otherwise not be possible. Thus, here we find ourselves." },

				{ Cue = "/VO/MelinoeField_3962", UsePlayerSource = true,
					Text = "The result you seek involves me repeatedly beating you up? Perhaps all you really {#Emph}do {#Prev}want is a proper thrashing, under the guise of acting like some sort of savior." },

				{ Cue = "/VO/Prometheus_0351",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I have extraordinarily high tolerance for pain. Though for such mockery, less so. Remember, we can {#Emph}both {#Prev}administer a thrashing here." },
			},
			PrometheusAboutPostTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0348",
					Text = "When my master lets you cross a boundary beyond this realm to face the monster Typhon as before, the outcome of {#Emph}that{#Prev}, I cannot foresee... how did the last one go?" },
				{ Cue = "/VO/MelinoeField_3960", UsePlayerSource = true,
					Text = "Perhaps I'll leave it to your imagination. It must be novel for you not to know the outcome of such incidents." },
				{ Cue = "/VO/Prometheus_0349",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh that it is. Well then don't tell me, if you like; I'm {#Emph}far {#Prev}more interested in the end result than in the many steps we shall be taking on the way." },
			},
			PrometheusAboutPostTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 9,
					},
					{
						Path = { "PrevRun", "EnemyKills" },
						HasAny = { "Chronos", "TyphonHead" },
					},
				},
				{ Cue = "/VO/Prometheus_0352",
					Text = "My master indicates that your accomplishments are mounting night by night. He awaits beyond, should you prevail again." },

				{ Cue = "/VO/MelinoeField_3963", UsePlayerSource = true,
					Text = "First you, then Typhon, same as ever. Though I'm delighted to know I'm living up to Grandfather's expectations. Could always use more family members to appease." },
						
				{ Cue = "/VO/Prometheus_0353",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I do not envy you in that. Nevertheless, so long as our paths are intertwined, I shall be here; no need to let me know ahead of time." },
			},
			PrometheusAboutEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Prometheus_0356",
					Text = "It's done...! It's finally done, except... I need to hear you say it first. To know for certain what I have foreseen. Now, please..." },
				{ Cue = "/VO/MelinoeField_3965", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "You may have to be a little more specific, but... I take it you mean that I found the Fates? Or they found me, but either way. I thought you didn't care for them too much." },
				{ Cue = "/VO/Prometheus_0357",
					Text = "I care for what they say... what they decide to make of this world of ours. What has their exile driven them to do? They would not make the same mistakes again." },
				{ Cue = "/VO/MelinoeField_3966", UsePlayerSource = true,
					Text = "They've had it with our squabbling; that I can understand. So they have deemed the coming of another age in which the gods apparently shall hold less sway. A time of fewer burdens on us, so our tempers can subside." },
				{ Cue = "/VO/Prometheus_0358",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "...The coming of a golden age... perhaps not quite the one my master had envisioned, but nevertheless. All this toil, at long last... and till then... I suppose we fight." },
			},
			PrometheusAboutEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue01" }
					},
				},
				{ Cue = "/VO/MelinoeField_3967", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So you truly saw all this coming? The Three Fates and their prophecy of a new age. Why have you fought so hard to stop me, then? What if you had prevailed?" },
				{ Cue = "/VO/Prometheus_0360",
					Text = "I knew my efforts to prevent you all would be for naught; but I was compelled to make those efforts anyhow. To put it simply, I could see no other way." },
				{ Cue = "/VO/MelinoeField_3968", UsePlayerSource = true,
					Text = "We might have fought on the same side. Surely that would have sooner led to your result than sending Aetos after me." },
				{ Cue = "/VO/Prometheus_0361",
					Text = "A reasonable theory but it never would have gone the way you expect. This was never about mortalkind for you." },
				{ Cue = "/VO/MelinoeField_3969", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "...You're right, it wasn't. I had my own problems to contend with before attempting to rid mortalkind of theirs." },
				{ Cue = "/VO/Prometheus_0362",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yet now you have done both. Fear not; the dead may worship you, but the living couldn't care less. Though still we did what needed to be done." },
			},
			PrometheusAboutEpilogue03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue02" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
				{ Cue = "/VO/MelinoeField_3970", UsePlayerSource = true,
					Text = "What of your companion Heracles? I suppose he's been in on your scheme this entire time as well. Appearing to defy the gods while serving them anyway." },
				{ Cue = "/VO/Prometheus_0363",
					Text = "You'll have no more success getting such answers out of me than out of him. You've seen the man; he has his reasons." },
				{ Cue = "/VO/MelinoeField_3971", UsePlayerSource = true,
					Text = "Hence your affiliation? You must have bonded over your disdain for this mountain and all it stands for. Was he the one who liberated you?" },
				{ Cue = "/VO/Prometheus_0364",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}No answers out of me{#Prev}, I said. Not when it comes to {#Emph}him. {#Prev}But at least you now know there are offshoots of your family made of stronger stuff." },
			},
			PrometheusAboutEpilogue04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/MelinoeField_3973", UsePlayerSource = true,
					Text = "Seeing as you know all about the coming age... any interesting details you can share about what's in store?" },
				{ Cue = "/VO/Prometheus_0366",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The world shall be a very different place, in ways you cannot possibly conceive. In other ways, nothing shall change at all; even regress. We shall all be forgotten, then remembered, and forgotten. Again, and again, and again..." },
			},

			PrometheusAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 12,
					},
				},
				{ Cue = "/VO/Prometheus_0332",
					Text = "This suffocating smoke on a night so black... it fills me with an older strength I thought I'd lost. A good reminder I yet live...!" },
				{ Cue = "/VO/MelinoeField_3978", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm pleased to hear about this positive new turn in your existence, Titan. A fearsome night can certainly instill heightened awareness, and a will to survive." },
				{ Cue = "/VO/Prometheus_0333",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You speak as though you are the cause yourself; impossible. Or quite unlikely I should say, but then again... {#Emph}augh{#Prev}, you dark gods. Come, let us see whether this is your night or mine!" },
			},
			PrometheusAboutShrineBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountySuitHeat1PBoss",
							"BountyLobHeat2PBoss",
							"BountyTorchHeat4PBoss",
							"BountyAxeHeat8PBoss",
							"BountyDaggerHeat12PBoss",
							"BountyStaffHeat16PBoss",

							"BountyShrineStaffPBoss ",
							"BountyShrineDaggerPBoss",
							"BountyShrineTorchPBoss",
							"BountyShrineAxePBoss",
							"BountyShrineLobPBoss",
							"BountyShrineSuitPBoss",
						},
					},
				},
				{ Cue = "/VO/Prometheus_0328",
					Text = "You've come specifically for me tonight, haven't you? Some barbarous assignment, perhaps, from dark gods far older and greater. Well here I am." },
				{ Cue = "/VO/MelinoeField_3975", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And how could you possibly know? I've said nothing of the sort, Titan. Nor shall I." },
				{ Cue = "/VO/Prometheus_0329",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not this eve you won't, but later. It shall slip your mind that we had this discussion earlier and you shall tell me more. For now, come fight me for the glory of your kind." },
			},
			PrometheusAboutShrineBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyShrineStaffQBoss ",
							"BountyShrineDaggerQBoss",
							"BountyShrineTorchQBoss",
							"BountyShrineAxeQBoss",
							"BountyShrineLobQBoss",
							"BountyShrineSuitQBoss",
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3976", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're not my objective, Titan. So what do we say we make this quick? Lest you impede the will of Night." },
				{ Cue = "/VO/Prometheus_0330",
					Text = "The will of Night, is it... demanding Typhon's sacrifice. Is that what you're after, scaling this mountain again and again?" },
				{ Cue = "/VO/MelinoeField_3977", UsePlayerSource = true,
					Text = "Not necessarily just Typhon's sacrifice. All enemies of the Underworld shall have their punishment. Even {#Emph}you{#Prev}, if you dare keep this up." },
				{ Cue = "/VO/Prometheus_0331",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am no stranger to the punishment of gods. It did not deter me then, nor shall it now, or evermore!" },
			},

			PrometheusAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0326",
					Text = "It seems we may be locked here in this struggle for some time; that is the consequence, of course, for what you did." },
				{ Cue = "/VO/MelinoeField_3984", UsePlayerSource = true,
					Text = "I got my family back. If it means having to get chastised every now and then by {#Emph}you{#Prev}, that's perfectly all right." },
				{ Cue = "/VO/Prometheus_0327",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I did not mean it thus. In fact, knowing these meetings may be quite habitual, perhaps it's best we keep our conversations curt. I ought not say too much from here." },
			},

			-- Repeatable / other general cases
			PrometheusMiscStart01 =
			{
				{ Cue = "/VO/Prometheus_0011",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You cannot die but can be driven back. And you can burn, and shall." },
			},
			PrometheusMiscStart02 =
			{
				{ Cue = "/VO/Prometheus_0012",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I know the outcome of our each and every clash; yet somehow you surprise me even still." },
			},
			PrometheusMiscStart03 =
			{
				{ Cue = "/VO/Prometheus_0013",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The entirety of my strength shall never again return, but I've enough for this." },
			},
			PrometheusMiscStart04 =
			{
				{ Cue = "/VO/Prometheus_0014",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Aetos here still longs for the taste of liver, and who are we to deny him that?" },
			},
			PrometheusMiscStart05 =
			{
				{ Cue = "/VO/Prometheus_0015",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The Agent of Change returns, and the course of history shall never be the same." },
			},
			PrometheusMiscStart06 =
			{
				{ Cue = "/VO/Prometheus_0016",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Sooner or later, the age of gods shall end, no matter how ferociously you fight." },
			},
			PrometheusMiscStart07 =
			{
				{ Cue = "/VO/Prometheus_0017",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'm still a little sore after what the gods did to me, for all my so-called crimes." },
			},
			PrometheusMiscStart08 =
			{
				{ Cue = "/VO/Prometheus_0018",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You gods seek worshipers, in all your vanity; we Titans seek only what is ours." },
			},
			PrometheusMiscStart09 =
			{
				{ Cue = "/VO/Prometheus_0019",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I endured having my liver eaten for an aeon; these bouts with you are nothing." },
			},
			PrometheusMiscStart10 =
			{
				{ Cue = "/VO/Prometheus_0020",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The gift of fire I bestowed to mortalkind; I made certain to save some for you." },
			},
			PrometheusMiscStart11 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0021",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Do you see? Each moment I delay you, Time's plan comes closer to fruition." },
			},
			PrometheusMiscStart12 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = ">",
						Value = 0,
					},
				},				
				{ Cue = "/VO/Prometheus_0022",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Whether you shall break me here again is for me to know and for you to find out." },
			},
			PrometheusMiscStart13 =
			{
				{ Cue = "/VO/Prometheus_0023",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I've seen your every trick; all that you are capable of! And you are not at your best." },
			},
			PrometheusMiscStart14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0024",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I shall not be the one to topple this mountain; neither shall you be the one to save it." },
			},
			PrometheusMiscStart15 =
			{
				{ Cue = "/VO/Prometheus_0155",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You've seen nothing of this world, yet defend it; I have seen it all, and shall burn it down." },
			},
			PrometheusMiscStart16 =
			{
				{ Cue = "/VO/Prometheus_0156",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You owe your family nothing, yet give everything to them. Fools, all of you." },
			},
			PrometheusMiscStart17 =
			{
				{ Cue = "/VO/Prometheus_0157",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There shall come a time when our conflict has ended; but I wouldn't hold my breath." },
			},
			PrometheusMiscStart18 =
			{
				{ Cue = "/VO/Prometheus_0158",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What gods and Titans did to one another can never be forgiven... merely forgotten." },
			},
			PrometheusMiscStart19 =
			{
				{ Cue = "/VO/Prometheus_0159",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "This fire coursing through me, burning me inside... I'll show you how it feels." },
			},
			PrometheusMiscStart20 =
			{
				{ Cue = "/VO/Prometheus_0160",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If I'm already guilty of unforgivable crimes according to Olympus, then this matters not." },
			},
			PrometheusMiscStart21 =
			{
				{ Cue = "/VO/Prometheus_0161",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No chains shall ever bind me again; I both swear it and I know it to be true." },
			},
			PrometheusMiscStart22 =
			{
				{ Cue = "/VO/Prometheus_0162",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You've some small amount of foresight by now, do you not? You know how this ends." },
			},
			PrometheusMiscStart23 =
			{
				{ Cue = "/VO/Prometheus_0478",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The gods demand your services and you comply; but I am obligated to resist." },
			},
			PrometheusMiscStart24 =
			{
				{ Cue = "/VO/Prometheus_0479",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'll not attempt to tell you what shall come of this... for you would never believe it." },
			},
			PrometheusMiscStart25 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0481",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I need no armaments to drive you back... unless you count this flame." },
			},
			PrometheusMiscStart26 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0482",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You've kept good Heracles there waiting patiently to put that club of his to further use." },
			},
			PrometheusMiscStart27 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0483",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We are the fury of Olympus here, not you; and we shall never abandon this fight." },
			},
			PrometheusMiscStart28 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0484",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Heracles is bound to serve the gods, as apparently are you. Yet {#Emph}this {#Prev}is the result." },
			},
			PrometheusMiscStart29 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Prometheus" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Prometheus_0485",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You cannot break us, Agent of Change; but perhaps you can break past us again." },
			},
			PrometheusMiscStart30 =
			{
				{ Cue = "/VO/Prometheus_0539",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I had a premonition of this very moment." },
			},
			PrometheusMiscStart31 =
			{
				{ Cue = "/VO/Prometheus_0540",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I know where this all leads. Let's see it through!" },
			},
			PrometheusMiscStart32 =
			{
				{ Cue = "/VO/Prometheus_0541",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I almost regret what's about to transpire." },
			},
			PrometheusMiscStart33 =
			{
				{ Cue = "/VO/Prometheus_0542",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Come, let us see whether this is your night or mine!" },
			},
			PrometheusMiscStart34 =
			{
				{ Cue = "/VO/Prometheus_0543",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Perhaps it's best we keep our conversations curt." },
			},
			PrometheusMiscStart35 =
			{
				{ Cue = "/VO/Prometheus_0544",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Change does not come without conflict." },
			},
			PrometheusMiscStart36 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Name = "P_Boss01", Count = 2 },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0480",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It seems I now pay penance to the gods once more, though they shall never bind me." },
			},

			HeraclesFightMiscStart01 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0640",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "One night after another you just keep turning up, sister. Are you enjoying this?" },
			},
			HeraclesFightMiscStart02 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" },
					},
				},
				{ Cue = "/VO/Heracles_0690",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Granting",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You got here rather quick tonight, didn't you, witch. Some dark gods aiding your ascent?" },
			},
			HeraclesFightMiscStart03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun" },
						HasAny = { "ActiveBounty", "ActiveShrineBounty" },
					},
				},
				{ Cue = "/VO/Heracles_0691",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Already made it all this way. Some strangeness is afoot... but I care not for that right now." },
			},
			HeraclesFightMiscStart04 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0349",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Whether we fight together or against each other matters not; only the fight itself." },
			},
			HeraclesFightMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0642",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Greet",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Should be more than enough carnage for the both of us here any moment now." },
			},
			HeraclesFightMiscStart06 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
					{
						FunctionName = "RequiredConsecutiveDeathsInRoom",
						FunctionArgs = { Name = "P_Boss01", Count = 1 },
					},
				},
				{ Cue = "/VO/Heracles_0402",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Brooding",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Go home, witch. You're no match for my club." },
			},
			HeraclesFightMiscStart07 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0342",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not too cold for you up here, sister? Or does battle warm you over as it does me?" },
			},
			HeraclesFightMiscStart08 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0340",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Notice it's harder to breathe up here, sister? Almost like this mountain's cursed." },
			},
			HeraclesFightMiscStart09 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0031",
					Source = "NPC_Heracles_01",
					PreLineAnim = "Heracles_Hub_Granting",
					PreLineAnimTarget = 768168,
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "Keep letting Olympus toss you around, and someday you'll be just like me." },
			},
			HeraclesFightMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Heracles_0024",
					Source = "NPC_Heracles_01",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					PostLineFunctionName = "StartHeraclesEncounterMusic",
					Text = "You're either good or ill fortune, not yet made up my mind." },
			},
		},

		-- following are for when he exits the encounter
		BossOutroTextLineSets =
		{
			PrometheusBossOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Prometheus_0005",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "{#Emph}Urgh... {#Prev}I knew this would happen. Yet I could not prevent it, do you see? I could only... do my part..." },
				{ Cue = "/VO/MelinoeField_2383", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Silence. Save your troubles for your master Chronos." },
				{ Cue = "/VO/Prometheus_0006",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "It's not my troubles that I mean to save... Agent of Change..." },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					-- { Cue = "/VO/Melinoe_0176", Text = "Thank you, Headmistress..." },
				},
			},

			PrometheusBossMiscDefeat01 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0025",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I've done my part here, just as you did yours... for this was bound to happen as it did." },
			},
			PrometheusBossMiscDefeat02 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0026",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...Curse these old wounds of mine... I once was stronger than this...!" },
			},
			PrometheusBossMiscDefeat03 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0027",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I knew that this would be a struggle... but hold always to the chance I may be wrong..." },
			},
			PrometheusBossMiscDefeat04 =
			{
				GameStateRequirements = 
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Prometheus_0463" },
					},
				},
				{ Cue = "/VO/Prometheus_0028",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I am beaten. But you cannot afford to give chase, and my strength shall return." },
			},
			PrometheusBossMiscDefeat05 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0029",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...The famous wrath of Olympus... it cannot easily be stopped, you see?" },
			},
			PrometheusBossMiscDefeat06 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0030",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...Aetos and I have done what needed to be done. Now you go do the same." },
			},
			PrometheusBossMiscDefeat07 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0151",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...If suffering today brings about a better tomorrow, so be it." },
			},
			PrometheusBossMiscDefeat08 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0152",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I foresaw your trickery yet still could not prevent it, no matter what I tried." },
			},
			PrometheusBossMiscDefeat09 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0153",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...{#Emph}Heh! {#Prev}Compared to what I have withstood before, this was nothing at all." },
			},
			PrometheusBossMiscDefeat10 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0154",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...If you could see what I've foreseen, you'd not believe it anyhow." },
			},
			PrometheusBossMiscDefeat11 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0451",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...You gods never forgive; why then should I, when I could fight instead?" },
			},
			PrometheusBossMiscDefeat12 =
			{
				PlayFirst = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Prometheus_0452_B",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...The strength to best both Heracles and me... I can foresee no way to stop it now." },
			},
			PrometheusBossMiscDefeat13 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0453",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I have foreseen defeats of mine before... every last one of them, in point of fact..." },
			},
			PrometheusBossMiscDefeat14 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0456",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...You have defeated me again... but all my wounds shall heal. They always do..." },
			},
			PrometheusBossMiscDefeat15 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0457",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...My strength has failed me repeatedly... but it always comes back..." },
			},
			PrometheusBossMiscDefeat16 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0458",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...The flames that you withstood... perhaps they were never meant for you..." },
			},
			PrometheusBossMiscDefeat17 =
			{
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {
							"PrometheusBossMiscDefeat01",
							"PrometheusBossMiscDefeat02",
							"PrometheusBossMiscDefeat03",
							"PrometheusBossMiscDefeat04",
							"PrometheusBossMiscDefeat05",
							"PrometheusBossMiscDefeat06",
							"PrometheusBossMiscDefeat07",
							"PrometheusBossMiscDefeat08",
							"PrometheusBossMiscDefeat09",
							"PrometheusBossMiscDefeat10",
							"PrometheusBossMiscDefeat11",
							-- "PrometheusBossMiscDefeat12",
							"PrometheusBossMiscDefeat13",
							"PrometheusBossMiscDefeat14",
							"PrometheusBossMiscDefeat15",
							"PrometheusBossMiscDefeat16",
							-- "PrometheusBossMiscDefeat17",
							-- "PrometheusBossMiscDefeat18",
							-- "PrometheusBossMiscDefeat19",
							-- "PrometheusBossMiscDefeat20",
						},
					},
				},
				{ Cue = "/VO/Prometheus_0459_B",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...My foreknowledge of this moment... it's as though... we've done this all before..." },
			},
			PrometheusBossMiscDefeat18 =
			{
				PlayFirst = true,
				GameStateRequirements = 
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Prometheus_0450",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...Now do you begin to understand... what I have done at every turn...?" },
			},
			PrometheusBossMiscDefeat19 =
			{
				PlayFirst = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Prometheus_0454",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...I knew I could not stop you... on the contrary, you... needed to prevail..." },
			},
			PrometheusBossMiscDefeat20 =
			{
				PlayFirst = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutPostTyphon01" },
					},
				},
				{ Cue = "/VO/Prometheus_0455",
					Portrait = "Portrait_Prometheus_Defeated_01",
					Text = "...Were it not for this fight... you'd never find a single remnant of Typhon..." },
			},
		},
	},
}

-- Global Prometheus Lines
GlobalVoiceLines.PrometheusSpawnWaveLines =
{
	Queue = "Interrupt",
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.85,
	-- SuccessiveChanceToPlay = 0.75,
	ObjectType = "Prometheus",
	Cooldowns =
	{
		{ Name = "PrometheusSummonedRecently", Time = 200 },
	},
	TriggerCooldowns = { "PrometheusSpokeRecently" },

	{ Cue = "/VO/Prometheus_0095", Text = "Legions of the Titan Lord, {#Emph}attack!", PlayFirst = true },
	{ Cue = "/VO/Prometheus_0096", Text = "Reinforcements, {#Emph}now!" },
	{ Cue = "/VO/Prometheus_0097", Text = "Here come my master's legions!" },
	{ Cue = "/VO/Prometheus_0098", Text = "My forces have regrouped!" },
	{ Cue = "/VO/Prometheus_0248", Text = "Legions, on me!" },
	{ Cue = "/VO/Prometheus_0249", Text = "Legions, form up!" },
	-- { Cue = "/VO/Prometheus_0250", Text = "Stand and fight, Legions of the Titan Lord!" },
	{ Cue = "/VO/Prometheus_0250_B", Text = "Legions of the Titan Lord!" },
	{ Cue = "/VO/Prometheus_0251", Text = "Assault forces, to me!" },
	{ Cue = "/VO/Prometheus_0252", Text = "You've more to contend with than me." },
	{ Cue = "/VO/Prometheus_0440", Text = "Quickly, Legions: Get her {#Emph}now!" },
	{ Cue = "/VO/Prometheus_0441", Text = "Now, Legions! {#Emph}Descend!" },
	{ Cue = "/VO/Prometheus_0442", Text = "We have you surrounded!" },
	{ Cue = "/VO/Prometheus_0443", Text = "Legions, fire support!" },
	{ Cue = "/VO/Prometheus_0444", Text = "Legions, open fire!" },
	{ Cue = "/VO/Prometheus_0445", Text = "Legions of the Titan Lord, {#Emph}come in!" },
	{ Cue = "/VO/Prometheus_0253", Text = "I do not fight alone!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = "<",
				Value = 3,
			},
		},
	},
}
GlobalVoiceLines.PrometheusPreAttackLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	ChanceToPlay = 0.15,
	ObjectType = "Prometheus",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
			Comparison = ">=",
			Value = 0.15,
		},
	},
	Cooldowns =
	{
		{ Name = "PrometheusSpokeRecently", Time = 20 },
	},

	{ Cue = "/VO/Prometheus_0065", Text = "Now..." },
	{ Cue = "/VO/Prometheus_0066", Text = "Now then..." },
	{ Cue = "/VO/Prometheus_0067", Text = "Ready...?" },
	{ Cue = "/VO/Prometheus_0068", Text = "Enough!" },
	{ Cue = "/VO/Prometheus_0069", Text = "See here..." },
	{ Cue = "/VO/Prometheus_0070", Text = "Very well..." },
	{ Cue = "/VO/Prometheus_0244", Text = "You'll suffer." },
	{ Cue = "/VO/Prometheus_0245", Text = "Back off...!" },
	{ Cue = "/VO/Prometheus_0517", Text = "Prepare...!" },
	{ Cue = "/VO/Prometheus_0518", Text = "You..." },
	{ Cue = "/VO/Prometheus_0519", Text = "Now this..." },
	{ Cue = "/VO/Prometheus_0520", Text = "For you..." },
	{ Cue = "/VO/Prometheus_0521", Text = "See this...?" },
	{ Cue = "/VO/Prometheus_0522", Text = "I see..." },
	{ Cue = "/VO/Prometheus_0242", Text = "Curse you gods!",
		Cooldowns =
		{
			{ Name = "PrometeusSaidGodsRecently", Time = 20 }
		},
	},
	{ Cue = "/VO/Prometheus_0243", Text = "For what you did!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},
}
GlobalVoiceLines.PrometheusAttackLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	SuccessiveChanceToPlay = 0.25,
	ObjectType = "Prometheus",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
			Comparison = ">=",
			Value = 0.15,
		},
	},
	Cooldowns =
	{
		{ Name = "PrometheusSpokeRecently", Time = 14 },
		{ Name = "PrometheusDamageSpeech", Time = 30 },
		{ Name = "AnyDamageSpeech", Time = 8 },
	},

	{ Cue = "/VO/Prometheus_0087", Text = "See {#Emph}this!" },
	{ Cue = "/VO/Prometheus_0088", Text = "Here!" },
	{ Cue = "/VO/Prometheus_0178", Text = "There!" },
	{ Cue = "/VO/Prometheus_0089", Text = "{#Emph}Here{#Prev}, then!" },
	{ Cue = "/VO/Prometheus_0090", Text = "Fall!" },
	{ Cue = "/VO/Prometheus_0091", Text = "Out of my sight!" },
	{ Cue = "/VO/Prometheus_0093", Text = "Watch {#Emph}this!" },
	{ Cue = "/VO/Prometheus_0523", Text = "{#Emph}Hrah!" },
	{ Cue = "/VO/Prometheus_0524", Text = "{#Emph}Hyah!" },
	{ Cue = "/VO/Prometheus_0525", Text = "{#Emph}Out!" },
	{ Cue = "/VO/Prometheus_0526", Text = "{#Emph}Back!" },
	{ Cue = "/VO/Prometheus_0527", Text = "Back off...!" },
	{ Cue = "/VO/Prometheus_0528", Text = "Return!" },
	{ Cue = "/VO/Prometheus_0092", Text = "This is {#Emph}over!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = "<=", Value = 0.33, },
			},
		}
	},
	{ Cue = "/VO/Prometheus_0094", Text = "You wretched gods...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
				Comparison = "<=",
				Value = 0.4,
			},
		},
		Cooldowns =
		{
			{ Name = "PrometeusSaidGodsRecently", Time = 20 }
		},
	},
}
GlobalVoiceLines.PrometheusEagleComboLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	-- SuccessiveChanceToPlay = 0.8,
	SuccessiveChanceToPlayAll = 0.8,
	ObjectType = "Prometheus",
	Cooldowns =
	{
		-- { Name = "PrometheusSpokeRecently", Time = 4 },
	},
	TriggerCooldowns = { "PrometheusSpokeRecently", },

	{ Cue = "/VO/Prometheus_0071", Text = "Aetos, attack!", PlayFirst = true },
	{ Cue = "/VO/Prometheus_0072", Text = "Now, Aetos!" },
	{ Cue = "/VO/Prometheus_0073", Text = "Aetos, {#Emph}now!" },
	{ Cue = "/VO/Prometheus_0074", Text = "Aetos, go!" },
	{ Cue = "/VO/Prometheus_0075", Text = "Go, Aetos!" },
	{ Cue = "/VO/Prometheus_0076", Text = "Together, Aetos!" },
	{ Cue = "/VO/Prometheus_0077", Text = "Get her, Aetos!" },
	{ Cue = "/VO/Prometheus_0078", Text = "Aetos!" },
	{ Cue = "/VO/Prometheus_0079", Text = "Talon Dive!" },
	{ Cue = "/VO/Prometheus_0259", Text = "Fly, Aetos!" },
	{ Cue = "/VO/Prometheus_0498", Text = "Get her!" },
	{ Cue = "/VO/Prometheus_0499", Text = "Go!" },
	{ Cue = "/VO/Prometheus_0500", Text = "Attack!" },
	{ Cue = "/VO/Prometheus_0501", Text = "Together!" },
	{ Cue = "/VO/Prometheus_0504", Text = "Let's go!" },
	{ Cue = "/VO/Prometheus_0537", Text = "Aetos shall feast on you." },
	{ Cue = "/VO/Prometheus_0258", Text = "Aetos, we fly!" },
	{ Cue = "/VO/Prometheus_0502", Text = "We {#Emph}fight!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
			},
		},
	},
	{ Cue = "/VO/Prometheus_0505", Text = "Run...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "P_Boss01" },
				Comparison = ">=",
				Value = 5,
			},
		},
	},
	{ Cue = "/VO/Prometheus_0503", Text = "Now, evade!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "P_Boss01" },
				Comparison = ">=",
				Value = 5,
			},
		},
	},
	{ Cue = "/VO/Prometheus_0359", Text = "For the age of mortalkind!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue01" },
			},
		},
	},
}
GlobalVoiceLines.PrometheusBurnLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		-- SuccessiveChanceToPlay = 0.66,
		SkipCooldownCheckIfNonePlayed = true,
		ObjectType = "Prometheus",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
				Comparison = ">=",
				Value = 0.15,
			},
		},
		Cooldowns =
		{
			{ Name = "PrometheusSpokeRecently", Time = 4 },
			{ Name = "PrometheusBurnLinesPlayedRecently", Time = 20 },
		},
		TriggerCooldowns = { "PrometheusSpokeRecently" },

		{ Cue = "/VO/Prometheus_0080", Text = "Phoenix Flame!" },
		{ Cue = "/VO/Prometheus_0081", Text = "Combust!" },
		{ Cue = "/VO/Prometheus_0082", Text = "Incinerate!" },
		{ Cue = "/VO/Prometheus_0083", Text = "Flame of Olympus!" },
		{ Cue = "/VO/Prometheus_0084", Text = "You'll {#Emph}burn!" },
		{ Cue = "/VO/Prometheus_0085", Text = "To ashes!" },
		{ Cue = "/VO/Prometheus_0086", Text = "Inferno!", PlayFirst = true },
		{ Cue = "/VO/Prometheus_0513", Text = "Flame!" },
		{ Cue = "/VO/Prometheus_0514", Text = "Burn...!" },
		{ Cue = "/VO/Prometheus_0515", Text = "Ignite!" },
		{ Cue = "/VO/Prometheus_0516", Text = "Fire!" },
		{ Cue = "/VO/Prometheus_0246", Text = "Fire Plume!" },
		{ Cue = "/VO/Prometheus_0247", Text = "Conflagration!" },
	},
}
GlobalVoiceLines.PrometheusDodgeFatalityLines =
{
	Queue = "Interrupt",
	BreakIfPlayed = true,
	RandomRemaining = true,
	TriggerCooldowns = { "PrometheusSpokeRecently" },

	{ Cue = "/VO/Prometheus_0190", Text = "Impossible." },
	{ Cue = "/VO/Prometheus_0198", Text = "No." },
	{ Cue = "/VO/Prometheus_0509", Text = "Not this time." },
	{ Cue = "/VO/Prometheus_0511", Text = "I think not.", PlayFirst = true },
	{ Cue = "/VO/Prometheus_0199", Text = "{#Emph}<Scoff>" },
	{ Cue = "/VO/Prometheus_0200", Text = "{#Emph}Hmph." },
	{ Cue = "/VO/Prometheus_0201", Text = "Mm-{#Emph}mm!" },
}
GlobalVoiceLines.PrometheusDodgeReactionLines =
{
	Queue = "Interrupt",
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.2,
	SuccessiveChanceToPlay = 0.75,
	SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "PrometheusDodgedRecently", Time = 25 },
		{ Name = "PrometheusSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/Prometheus_0190", Text = "Impossible." },
	{ Cue = "/VO/Prometheus_0191", Text = "As expected." },
	{ Cue = "/VO/Prometheus_0192", Text = "Predictable.", PlayFirst = true },
	{ Cue = "/VO/Prometheus_0193", Text = "Missed." },
	{ Cue = "/VO/Prometheus_0194", Text = "Try again." },
	{ Cue = "/VO/Prometheus_0195", Text = "Saw that." },
	{ Cue = "/VO/Prometheus_0196", Text = "Come on." },
	{ Cue = "/VO/Prometheus_0197", Text = "Never." },
	{ Cue = "/VO/Prometheus_0198", Text = "No." },
	{ Cue = "/VO/Prometheus_0509", Text = "Not this time." },
	{ Cue = "/VO/Prometheus_0510", Text = "Too slow." },
	{ Cue = "/VO/Prometheus_0511", Text = "I think not." },
	{ Cue = "/VO/Prometheus_0512", Text = "Expected." },
	{ Cue = "/VO/Prometheus_0199", Text = "{#Emph}<Scoff>" },
	{ Cue = "/VO/Prometheus_0200", Text = "{#Emph}Hmph." },
	{ Cue = "/VO/Prometheus_0201", Text = "Mm-{#Emph}mm!" },
	{ Cue = "/VO/Prometheus_0286", Text = "{#Emph}Heh.",
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "AIStageActive" },
				Comparison = "<=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/Prometheus_0287", Text = "{#Emph}Hah!",
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "AIStageActive" },
				Comparison = "<=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/Prometheus_0288", Text = "{#Emph}Heh-heh.",
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "AIStageActive" },
				Comparison = "<=",
				Value = 2,
			},
			{
				Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
				Comparison = "<=",
				Value = 0,
			},
		}
	},
	{ Cue = "/VO/Prometheus_0289", Text = "{#Emph}Hmhm.",
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "AIStageActive" },
				Comparison = "<=",
				Value = 2,
			},
		}
	},
	{ Cue = "/VO/Prometheus_0290", Text = "{#Emph}Hahahaha.",
		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "AIStageActive" },
				Comparison = "<=",
				Value = 1,
			},
			{
				Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},
}
GlobalVoiceLines.PrometheusGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Prometheus",
	SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "PrometheusSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Prometheus_0222", Text = "I'll not be ignored." },
	{ Cue = "/VO/Prometheus_0223", Text = "Face me!" },
	{ Cue = "/VO/Prometheus_0224", Text = "Fight, curse you." },
	{ Cue = "/VO/Prometheus_0225", Text = "What are you...?" },
	{ Cue = "/VO/Prometheus_0226", Text = "A consolation prize?" },
	{ Cue = "/VO/Prometheus_0227", Text = "Stealing from Olympus?", PlayFirst = true },
	{ Cue = "/VO/Prometheus_0228", Text = "Plunder away!" },
	{ Cue = "/VO/Prometheus_0229", Text = "Take it, you'll need it." },
	{ Cue = "/VO/Prometheus_0230", Text = "Couldn't wait?" },
	{ Cue = "/VO/Prometheus_0231", Text = "What now?" },
}
GlobalVoiceLines.PrometheusTagInLines =
{
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlay = 0.33,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "Prometheus",
	Cooldowns =
	{
		{ Name = "PrometheusSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Prometheus_0367", Text = "Get her, man!" },
	{ Cue = "/VO/Prometheus_0368", Text = "{#Emph}Do it{#Prev}, Heracles!" },
	{ Cue = "/VO/Prometheus_0369", Text = "Now, man!" },
	{ Cue = "/VO/Prometheus_0370", Text = "{#Emph}Now{#Prev}, Heracles!" },
	{ Cue = "/VO/Prometheus_0371", Text = "Heracles!" },
	{ Cue = "/VO/Prometheus_0372", Text = "Show her!" },
	{ Cue = "/VO/Prometheus_0373", Text = "You're in for it now." },
	{ Cue = "/VO/Prometheus_0374", Text = "Here he comes..." },
	{ Cue = "/VO/Prometheus_0375", Text = "{#Emph}His {#Prev}turn now." },
	{ Cue = "/VO/Prometheus_0376", Text = "Now you, big man!" },
	{ Cue = "/VO/Prometheus_0377", Text = "Best watch out..." },
	{ Cue = "/VO/Prometheus_0378", Text = "He's worse than I." },
}

OverwriteTableKeys( EnemyData, UnitSetData.Prometheus )