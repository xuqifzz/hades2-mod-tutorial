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
		OnDeathFunctionArgs = { Message = "PrometheusDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, FlashDuration = 0.45, AddInterBiomeTimerBlock = true, EndAngle = 210, KillerEndAngle = 30, PanZoomFraction = 1.3 },

		DeathAngle = 220,
		DeathAnimation = "Enemy_Prometheus_Death_End",
		DeathFx = "PrometheusDeathFxIn",
		DeathSound = "/SFX/StabSplatterEndSequence",
		DeathPanOffsetY = -170,

		ClearChillOnDeath = true,

		SpawnAnimation = "Enemy_Prometheus_LaunchReadyLoop",

		Material = "Organic",
		HealthBarTextId = "Prometheus_Full",
		HealthBarOffsetY = -275,
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
			PreAttackEndMinWaitTime = 0.3,
		},
		--WeaponOptions = { "PrometheusKick_Base", },
		WeaponOptions =
		{
			"PrometheusSlam_P1",
			"PrometheusKick_P1",
			"PrometheusFlurry_P1",
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
				EquipWeapons =
				{
					"PrometheusSlam_P2_Starter",
					"PrometheusKick_P2_Starter",
					"PrometheusFlurry_P2_Starter",
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
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EquipWeapons =
				{
					"PrometheusSlam_P3_Starter",
					"PrometheusKick_P3_Starter",
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
				UnequipAllWeapons = true,
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
				{ Name = "PrometheusSpokeRecently", Time = 22 },
			},

			--[[
			{ Cue = "/VO/Prometheus_0099", Text = "What's life without pain?" },
			{ Cue = "/VO/Prometheus_0100", Text = "Suffer as I did." },
			{ Cue = "/VO/Prometheus_0101", Text = "Suffer, then." },
			{ Cue = "/VO/Prometheus_0102", Text = "Turn back." },
			{ Cue = "/VO/Prometheus_0172", Text = "Go back." },
			{ Cue = "/VO/Prometheus_0173", Text = "Return to hell." },
			{ Cue = "/VO/Prometheus_0174", Text = "Leave this place." },
			{ Cue = "/VO/Prometheus_0175", Text = "Do you see?" },
			{ Cue = "/VO/Prometheus_0176", Text = "I'll not hold back." },
			{ Cue = "/VO/Prometheus_0177", Text = "I'll burn you to ash." },
			{ Cue = "/VO/Prometheus_0178", Text = "There!" },
			{ Cue = "/VO/Prometheus_0179", Text = "You gods..." },
			]]--
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
			[1] = { GlobalVoiceLines = "PrometheusDodgeReactionLines" },
		},
		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "PrometheusSpokeRecently" },

			-- { Cue = "/VO/HecateField_0219", Text = "I'll keep this form, thank you.", PlayFirst = true },
		},

		MemoryAttackIntroVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.65,
				-- SuccessiveChanceToPlay = 0.15,
				ObjectType = "Prometheus",
				TriggerCooldowns = { "PrometheusSpokeRecently" },
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
				{ Cue = "/VO/Prometheus_0178", Text = "There!" },
				{ Cue = "/VO/Prometheus_0179", Text = "You gods...",
					Cooldowns =
					{
						{ Name = "PrometeusSaidGodsRecently", Time = 20 }
					},
				},
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
			{ Cue = "/VO/Prometheus_0254", Text = "...We're not finished!" },
			{ Cue = "/VO/Prometheus_0257", Text = "...Time cannot be stopped!" },
			{ Cue = "/VO/Prometheus_0261", Text = "...You'll never defeat us!" },
			{ Cue = "/VO/Prometheus_0191", Text = "As expected." },
			{ Cue = "/VO/Prometheus_0192", Text = "Predictable." },
			{ Cue = "/VO/Prometheus_0195", Text = "Saw that." },
			{ Cue = "/VO/Prometheus_0196", Text = "Come on." },
			{ Cue = "/VO/Prometheus_0199", Text = "{#Emph}<Scoff>" },
			{ Cue = "/VO/Prometheus_0200", Text = "{#Emph}Hmph." },
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
					Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
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

		DeathSound = "/SFX/StabSplatterEndSequence",
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
				{ Cue = "/VO/Prometheus_0263", Text = "Heh... heheheheh... {#Emph}ungh..." },
				{ Cue = "/VO/Prometheus_0264", Text = "I should have... expected this..." },
				{ Cue = "/VO/Prometheus_0265", Text = "I've suffered... worse... {#Emph}urgh..." },
				{ Cue = "/VO/Prometheus_0266", Text = "This... too... shall... pass..." },
				{ Cue = "/VO/Prometheus_0267", Text = "I did... what needed... to be done..." },
				{ Cue = "/VO/Prometheus_0268", Text = "All... according... to plan..." },
				{ Cue = "/VO/Prometheus_0269", Text = "You gods... I hate... you all...", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0270", Text = "Was there nothing... I could have done...?" },
				{ Cue = "/VO/Prometheus_0271", Text = "I knew... this would happen... yet..." },

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
			{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 8.5,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_2518", Text = "...He's gone....", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2519", Text = "Did he know he'd lose...?" },
				{ Cue = "/VO/MelinoeField_2520", Text = "Go lick your wounds." },
				{ Cue = "/VO/MelinoeField_2521", Text = "Saw that coming." },
				{ Cue = "/VO/MelinoeField_2522", Text = "Enough of his foresight." },
				{ Cue = "/VO/MelinoeField_2523", Text = "See you later!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Prometheus" },
							Comparison = ">=",
							Value = 4,
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
				{ Cue = "/VO/Prometheus_0002", Speaker = "NPC_Prometheus_Unnamed_01",
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
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = "<=",
						Value = 0,
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
					Text = "Truly? And what shall be the outcome of our confrontation this time, since you know everything? Same as the last?" },
				{ Cue = "/VO/Prometheus_0034",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If you knew, the outcome would invariably be rather different than the one that's imminent. Though I suppose I can at least give you a hint..." },
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
			PrometheusLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.5, },
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
			PrometheusLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/Prometheus_0143",
					Text = "How quickly you arrived this night! Bending the very laws of nature to achieve your goal... forging alliances with beings who care nothing for you." },
				{ Cue = "/VO/MelinoeField_2890", UsePlayerSource = true,
					Text = "I did take a shortcut, but you're wrong about the rest. I know the being to whom you refer, and they're not what you presume them to be." },
				{ Cue = "/VO/Prometheus_0144",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No? But isn't it Chaos that delivers you so close to your goal, yet shall let you go no farther... even if you should prevail here? I know where this all leads; let's see it through!" },
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
					--
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

			PrometheusAboutGoldenAge01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Prometheus_0114",
					Text = "Resist all you like, yet the age of gods shall end! {#Emph}Time {#Prev}shall see to it. And thereafter, a Golden Age of enlightenment shall begin, in which you gods hold far less sway." },
				{ Cue = "/VO/MelinoeField_2735", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					--
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
					Text = "You have questions for me about a great many different things... I shall not answer them, not yet. The words must first escape your lips, for one." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PrometheusAboutChronos01", "PrometheusAboutMortals03" }
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
						HasAll = { "DoraBathHouse02", "DoraAboutPrometheus02" }
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus03" }
					},
				},
				{ Cue = "/VO/Prometheus_0139",
					Text = "Your companion, Dora... she does not remember me, not yet. But she shall! And in so doing, remember why she chose to forget me to begin with... and forget so much more." },
				{ Cue = "/VO/MelinoeField_2888", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You say she's not to blame for the failings of mortalkind, as though she could have carried such a burden to begin with. What happened? How do you know her?" },
				{ Cue = "/VO/Prometheus_0140",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That one is haunted by her past, as you can see. But, it is not my place to tell you any more than I already have, lest she recall too much, too quickly. {#Emph}All in due time{#Prev}, as my master would say." },
			},

			PrometheusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
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

			PrometheusAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PathTrue", "TextLinesRecord", "DionysusAboutPrometheus02" }
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
						PathTrue = { "PathTrue", "TextLinesRecord", "DionysusAboutPrometheus03" }
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
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
					-- @ update with additional requirements
				},
				{ Cue = "/VO/Prometheus_0135",
					Text = "You have a brother whom you never even knew. I had a prideful one, a scatter-minded one, and a pathetic one bearing the weight of the world on his shoulders. Which do you suppose {#Emph}yours {#Prev}is most like?" },
				{ Cue = "/VO/MelinoeField_2885", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "No wonder you hate my family; you hate yours. Shall we proceed to try and kill each other now? I don't have all night." },
				{ Cue = "/VO/Prometheus_0136",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "My brothers and I also used to quarrel frequently. I thought I had outgrown it; become more civilized. But clearly no." },
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
				{ Cue = "/VO/Prometheus_0021",
					PreLineThreadedFunctionName = "PlayPrometheusTauntAnim",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Do you see? Each moment I delay you, Time's plan comes closer to fruition." },
			},
			PrometheusMiscStart12 =
			{
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

		},

		-- following are for when he exits the encounter
		BossOutroTextLineSets =
		{
			PrometheusBossOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Prometheus_0005",
					Text = "{#Emph}Urgh... {#Prev}I knew this would happen. Yet I could not prevent it, do you see? I could only... do my part..." },
				{ Cue = "/VO/MelinoeField_2383", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Silence. Save your troubles for your master Chronos." },
				{ Cue = "/VO/Prometheus_0006",
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
					Text = "...I've done my part here, just as you did yours... for this was bound to happen as it did." },
			},
			PrometheusBossMiscDefeat02 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0026",
					Text = "...Curse these old wounds of mine... I once was stronger than this...!" },
			},
			PrometheusBossMiscDefeat03 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0027",
					Text = "...I knew that this would be a struggle... but hold always to the chance I may be wrong..." },
			},
			PrometheusBossMiscDefeat04 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0028",
					Text = "...I am beaten. But you cannot afford to give chase, and my strength shall return." },
			},
			PrometheusBossMiscDefeat05 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0029",
					Text = "...The famous wrath of Olympus... it cannot easily be stopped, you see?" },
			},
			PrometheusBossMiscDefeat06 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0030",
					Text = "...Aetos and I have done what needed to be done. Now you go do the same." },
			},
			PrometheusBossMiscDefeat07 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0151",
					Text = "...If suffering today brings about a better tomorrow, so be it." },
			},
			PrometheusBossMiscDefeat08 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0152",
					Text = "...I foresaw your trickery yet still could not prevent it, no matter what I tried." },
			},
			PrometheusBossMiscDefeat09 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0153",
					Text = "...{#Emph}Heh! {#Prev}Compared to what I have withstood before, this was nothing at all." },
			},
			PrometheusBossMiscDefeat10 =
			{
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Prometheus_0154",
					Text = "...If you could see what I've foreseen, you'd not believe it anyhow." },
			},

		},
	},
}

-- Global Prometheus Lines
GlobalVoiceLines.PrometheusSpawnWaveLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.85,
	SuccessiveChanceToPlay = 0.75,
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
	{ Cue = "/VO/Prometheus_0250", Text = "Stand and fight, Legions of the Titan Lord!" },
	{ Cue = "/VO/Prometheus_0251", Text = "Assault forces, to me!" },
	{ Cue = "/VO/Prometheus_0252", Text = "You've more to contend with than me." },
	{ Cue = "/VO/Prometheus_0253", Text = "I do not fight alone!" },
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
	{ Cue = "/VO/Prometheus_0242", Text = "Curse you gods!" },
	{ Cue = "/VO/Prometheus_0244", Text = "You'll suffer." },
	{ Cue = "/VO/Prometheus_0245", Text = "Back off...!" },
	{ Cue = "/VO/Prometheus_0243", Text = "For what you did!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
				Comparison = "<=",
				Value = 0,
			},
		}
	},
}
GlobalVoiceLines.PrometheusEagleComboLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	SuccessiveChanceToPlay = 0.75,
	SuccessiveChanceToPlayAll = 0.5,
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
	{ Cue = "/VO/Prometheus_0259", Text = "Fly, Aetos!" },
}
GlobalVoiceLines.PrometheusBurnLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		-- SuccessiveChanceToPlay = 0.5,
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
			{ Name = "PrometheusBurnLinesPlayedRecently", Time = 20 },
		},
		TriggerCooldowns = { "PrometheusSpokeRecently" },

		{ Cue = "/VO/Prometheus_0081", Text = "Combust!" },
		{ Cue = "/VO/Prometheus_0082", Text = "Incinerate!" },
		{ Cue = "/VO/Prometheus_0083", Text = "Flame of Olympus!" },
		{ Cue = "/VO/Prometheus_0084", Text = "You'll {#Emph}burn!" },
		{ Cue = "/VO/Prometheus_0085", Text = "To ashes!" },
		{ Cue = "/VO/Prometheus_0086", Text = "Inferno!", PlayFirst = true },
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
		{ Name = "PrometheusSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Prometheus_0087", Text = "See this!" },
	{ Cue = "/VO/Prometheus_0088", Text = "Here!" },
	{ Cue = "/VO/Prometheus_0089", Text = "{#Emph}Here{#Prev}, then!" },
	{ Cue = "/VO/Prometheus_0090", Text = "Fall!" },
	{ Cue = "/VO/Prometheus_0091", Text = "Out of my sight!" },
	{ Cue = "/VO/Prometheus_0093", Text = "Watch {#Emph}this!" },
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
GlobalVoiceLines.PrometheusDodgeReactionLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.2,
	ChanceToPlay = 0.2,
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

	{ Cue = "/VO/Prometheus_0190", Text = "Impossible." },
	{ Cue = "/VO/Prometheus_0191", Text = "As expected." },
	{ Cue = "/VO/Prometheus_0192", Text = "Predictable." },
	{ Cue = "/VO/Prometheus_0193", Text = "Missed." },
	{ Cue = "/VO/Prometheus_0194", Text = "Try again." },
	{ Cue = "/VO/Prometheus_0195", Text = "Saw that." },
	{ Cue = "/VO/Prometheus_0196", Text = "Come on." },
	{ Cue = "/VO/Prometheus_0197", Text = "Never." },
	{ Cue = "/VO/Prometheus_0198", Text = "No." },
	{ Cue = "/VO/Prometheus_0199", Text = "{#Emph}<Scoff>" },
	{ Cue = "/VO/Prometheus_0200", Text = "{#Emph}Hmph." },
	{ Cue = "/VO/Prometheus_0201", Text = "Mm-{#Emph}mm!" },
}
GlobalVoiceLines.PrometheusGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Prometheus",
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

OverwriteTableKeys( EnemyData, UnitSetData.Prometheus )