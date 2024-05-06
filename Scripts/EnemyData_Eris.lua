UnitSetData.Eris =
{
	Eris =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Eris_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.ErisVoice,
		SpeakerName = "Eris",
		SpeechParams =
		{
			Radius = 1,
		},
		MaxHealth = 16000,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,

		InvulnerableFx = "nil",

		SpeechCooldownTime = 9,
		SelfBuffDamage = 100, -- used for text

		Groups = { "GroundEnemies" },
		OnDeathFunctionName = "ErisKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "ErisDefeatedMessage",
			CameraPanTime = 1.5,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			FlashRed = true,
			AddInterBiomeTimerBlock = true
		},
		DeathAngle = 220,
		DeathAnimation = "Enemy_Eris_Death",
		DeathSound = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge",
		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarTextId = "Eris_Full",
		HealthBarOffsetY = -275,
		--IgnoreInvincibubbleOnHit = true,
		InvulnerableFx = "Invincibubble",
		TextLinesUseWeaponIdle = true,

		DefaultAIData =
		{
			--DashIfOverDistance = 600,
			DashWeapon = "ErisDash",

			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
		},
		WeaponOptions = { "ErisSpray", "ErisGrenade", "ErisDash", "ErisFlyUp", "ErisSummonSelector" },
		--WeaponOptions = { "ErisSummonSelector3", "ErisSpray" },

		PreBossAISetupFunctionName = "GenericPresentation",
		PreBossAISetupFunctionArgs = { SetAnimation = "Enemy_Eris_Idle" },
		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.75,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "ErisGrenadeSelfBuff",
				ClearEffects = true,
				ThreadedEvents =
				{
					{
						FunctionName = "ErisOilTransition",
						Args =
						{
							GroupName = "Oil2",
							Delay = 2.5,
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisSpreadFire", "ErisGrenadeCluster01", "ErisDash", "ErisFlyUp", "ErisSummonSelector" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "ErisGrenadeSelfBuff",
				ClearEffects = true,
				ThreadedEvents =
				{
					{
						FunctionName = "ErisOilTransition",
						Args =
						{
							GroupName = "Oil3",
							Delay = 2.5,
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.25,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisSpreadFire", "ErisGrenadeCluster02", "ErisDash", "ErisFlyUp", "ErisSummonSelector" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "ErisGrenadeSelfBuff",
				ClearEffects = true,
				ThreadedEvents =
				{
					{
						FunctionName = "ErisOilTransition",
						Args =
						{
							GroupName = "Oil4",
							Delay = 2.5,
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.05,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisRelocateStrike", "ErisGrenadeCluster03", "ErisDash", "ErisFlyUp", "ErisSummonSelector2" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "ErisGrenadeSelfBuffFinal",
				ClearEffects = true,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisRelocateStrike", "ErisFlyUp", "ErisSummonSelector2", "ErisSnipe3" },
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
				{ Name = "ErisSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/ErisField_0074", Text = "{#Emph}Yeah..." },
			{ Cue = "/VO/ErisField_0075", Text = "Got you." },
			{ Cue = "/VO/ErisField_0076", Text = "Want more?" },
			{ Cue = "/VO/ErisField_0077", Text = "How's that?" },
			{ Cue = "/VO/ErisField_0078", Text = "Got plenty more." },
			{ Cue = "/VO/ErisField_0079", Text = "Good as dead." },
			{ Cue = "/VO/ErisField_0080", Text = "Isn't this fun?" },
			{ Cue = "/VO/ErisField_0081", Text = "{#Emph}Aw{#Prev}, poor thing!" },
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">=",
						Value = 0.15,
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 8 },
					{ Name = "ErisLastStandReactionSpeech", Time = 20 },
				},

				{ Cue = "/VO/ErisField_0100", Text = "Still going, {#Emph}huh?" },
				{ Cue = "/VO/ErisField_0101", Text = "Give {#Emph}up!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0102", Text = "Oh come {#Emph}on!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0103", Text = "Just {#Emph}die!" },
				{ Cue = "/VO/ErisField_0104", Text = "Again?" },
				{ Cue = "/VO/ErisField_0105", Text = "Aw, {#Emph}really?", PlayFirst = true },
			},
		},

		InvulnerableVoiceLines =
		{
			[1] = GlobalVoiceLines.ErisInvulnerableVoiceLines,
		},
		ResistedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "ErisSpokeRecently", Time = 3 },
			},

			{ Cue = "/VO/ErisField_0043", Text = "Nu-{#Emph}uh!", PlayFirst = true },
			{ Cue = "/VO/ErisField_0045", Text = "Nice try!" },
			{ Cue = "/VO/ErisField_0046", Text = "You wish!" },
			{ Cue = "/VO/ErisField_0047", Text = "{#Emph}Cute!" },
		},

		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlayAll = 0.01,
			Cooldowns =
			{
				{ Name = "ErisSpokeRecently", Time = 25 },
			},				
			GameStateRequirements =
			{
			},

			{ Cue = "/VO/ErisField_0096", Text = "Really?" },
			{ Cue = "/VO/ErisField_0097", Text = "Really!" },
			{ Cue = "/VO/ErisField_0098", Text = "Come on..." },
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
				{ Name = "ErisSpokeRecently", Time = 25 },
			},
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
					Comparison = ">=",
					Value = 0.05,
				},
			},

			{ Cue = "/VO/ErisField_0090", Text = "{#Emph}Hey!" },
			{ Cue = "/VO/ErisField_0091", Text = "{#Emph}Babe!" },
			{ Cue = "/VO/ErisField_0093", Text = "{#Emph}Ow!", PlayFirst = true },
			{ Cue = "/VO/ErisField_0094", Text = "You..." },
			{ Cue = "/VO/ErisField_0095", Text = "Not OK...!" },
			{ Cue = "/VO/ErisField_0092", Text = "{#Emph}Ungh!" },
			{ Cue = "/VO/ErisField_0099", Text = "{#Emph}Guh!" },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },

				{ Cue = "/VO/ErisField_0120", Text = "How could you... be so {#Emph}cruel...?", PlayFirst = true },
				{ Cue = "/VO/ErisField_0114", Text = "{#Emph}No! {#Prev}Nononono, come on, wait!" },
				{ Cue = "/VO/ErisField_0115", Text = "Oh no not again, not {#Emph}again!" },
				{ Cue = "/VO/ErisField_0116", Text = "Oh, {#Emph}haha! {#Prev}I'll get you for this!!" },
				{ Cue = "/VO/ErisField_0117", Text = "I thought that we were friends?!" },
				{ Cue = "/VO/ErisField_0118", Text = "How could you do this to me, babe?!" },
				{ Cue = "/VO/ErisField_0119", Text = "Cold... darkness... {#Emph}ungh..." },
				{ Cue = "/VO/ErisField_0121", Text = "No...! You're making a mistake...!" },
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
				PreLineWait = 7.2,
				SuccessiveChanceToPlayAll = 0.66,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1907", Text = "You started it.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1908", Text = "She started it." },
				{ Cue = "/VO/MelinoeField_1909", Text = "Get out of here." },
				{ Cue = "/VO/MelinoeField_1910", Text = "Buzz off." },
				{ Cue = "/VO/MelinoeField_1911", Text = "Remember that." },
				{ Cue = "/VO/MelinoeField_1912", Text = "She never learns." },
				{ Cue = "/VO/MelinoeField_1913", Text = "See you, Strife." },
				{ Cue = "/VO/MelinoeField_1914", Text = "Much better..." },
			},
		},

		BossIntroTextLineSets =
		{
			ErisBossFirstMeeting =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/ErisField_0002",
					Text = "Heya, sailor! What a coincidence, running into you like this {#Emph}so {#Prev}far away from home. Where you headed? Maybe I could give you a lift." },
				{ Cue = "/VO/MelinoeField_1806", UsePlayerSource = true,
					Text = "You know perfectly well where I'm headed. And I can get there on my own, thanks." },
				{ Cue = "/VO/ErisField_0003",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You sure about that? Because it looks like you've been having a {#Emph}pretty {#Prev}rough night so far. And it's only going to get worse." },
				{ Cue = "/VO/MelinoeField_1807", UsePlayerSource = true,
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I don't care for your insinuations here, Eris. Speak plain, or get out of my way." },
				{ Cue = "/VO/ErisField_0004",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh I'll speak plain: You're boring. I don't {#Emph}like {#Prev}you. And you don't get to order me around...!" },
			},

			ErisBossAboutObstacles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/ErisField_0011",
					Emote = "PortraitEmoteDepressed",
					-- PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Come on, {#Emph}really? {#Prev}I thought I made myself real clear with you before, but here you are like nothing happened, and it's just another night!" },
				{ Cue = "/VO/MelinoeField_1920", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "This {#Emph}is {#Prev}just another night to me, Eris. So you stand with Chronos against the gods, so what? You're just another obstacle on my path." },
				{ Cue = "/VO/ErisField_0012",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Hate to break it to you, Trouble: Obstacles are things you're supposed to {#Emph}avoid. {#Prev}But in {#Emph}this {#Prev}channel, you're going to run into me {#Emph}every time." },
			},

			ErisBossAboutMistakes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/ErisField_0013",
					Text = "Another go? Can't always tell if you're stubborn, or just plain... {#Emph}you {#Prev}know. Not that it matters either way." },
				{ Cue = "/VO/MelinoeField_1921", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",

					PreLineThreadedFunctionName = "GenericPresentation",
					PreLineThreadedFunctionArgs = { SetAnimation = "Enemy_Eris_HubToCombatIdle" },

					Text = "You're standing between me and my objective, Eris... or, floating. The point is, sooner or later, you'll come to understand that's a mistake." },
				{ Cue = "/VO/ErisField_0014",

					PreLineThreadedFunctionName = "GenericPresentation",
					PreLineThreadedFunctionArgs = { SetAnimation = "Enemy_Eris_Reload_PreFight" },

					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aw{#Prev}, but we all make mistakes, right? Neither one of us would be here otherwise. So you ready now, or what? Let's have some {#Emph}fun." },
			},

			ErisBossAboutRelaxation01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "~=",
						Value = 5,
					},
				},
				{ Cue = "/VO/ErisField_0015",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Isn't this {#Emph}great{#Prev}, Trouble? Now before I shoot you all to hell, I just want us both to take a moment to {#Emph}breathe, relax... really {#Prev}just appreciate all that we have." },
				{ Cue = "/VO/MelinoeField_1922", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "These senseless fights with you... I cannot rightly say I appreciate them at all. Though, at least the Moon is beautiful tonight?" },
				{ Cue = "/VO/ErisField_0016",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}That's {#Prev}the spirit! Now how 'bout we stain that pale glow of hers in blood and ichor, huh? And we'll let the sea drink its fill, for good measure!" },
			},

			ErisBossAboutConsequences01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0048",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You're tougher than you look, I'll give you that, Trouble. And I'll give you something {#Emph}else {#Prev}for what you did to me last time." },
				{ Cue = "/VO/MelinoeField_1923", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The outcome of our prior meeting was the direct result of your provocation and hostility. Tonight may go even worse." },
				{ Cue = "/VO/ErisField_0049",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Wait, you're telling me our choices have {#Emph}c-c-consequences...? C'mon{#Prev}, don't be so gullible. Anyway! I'm gonna open fire now." },
			},

			ErisBossAboutGoldenApples01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MixerOBoss" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/ErisField_0146",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Give back the Golden Apple that you took from me last time, and I might just let you walk this once. What do you say?" },
				{ Cue = "/VO/MelinoeField_1924", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You mean the Golden Apple that you very likely {#Emph}stole? {#Prev}Supposedly they grow but in a single garden, and I highly doubt that such a place would let {#Emph}you {#Prev}in." },
				{ Cue = "/VO/ErisField_0147",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Life starts to get a {#Emph}lot {#Prev}more interesting once you accept that you {#Emph}don't {#Prev}always need an invitation to show up. Fine! Keep the Apple, then. I've got a whole lot more..." },
			},

			-- Repeatable / other general cases
			ErisBossMiscStart01 =
			{
				{ Cue = "/VO/ErisField_0005",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Already locked and loaded here, so make your move, Trouble." },
			},
			ErisBossMiscStart02 =
			{
				{ Cue = "/VO/ErisField_0006",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "No going back to how things used to be, no matter {#Emph}what you do." },
			},
			ErisBossMiscStart03 =
			{
				{ Cue = "/VO/ErisField_0007",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Ready to give it your best shot here, Trouble? Because {#Emph}I {#Prev}sure am!" },
			},
			ErisBossMiscStart04 =
			{
				{ Cue = "/VO/ErisField_0008",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Everybody always trying to make a difference. Nobody pulling it off." },
			},
			ErisBossMiscStart05 =
			{
				{ Cue = "/VO/ErisField_0009",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Just when I was starting to feel a little bored, {#Emph}along comes Trouble!" },
			},
			ErisBossMiscStart06 =
			{
				{ Cue = "/VO/ErisField_0010",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Nothing's gonna change! Except the number of holes you got in you." },
			},

			ErisBossMiscStart07 =
			{
				{ Cue = "/VO/ErisField_0130",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "This is for your own good, Trouble. Mine, too!" },
			},
			ErisBossMiscStart08 =
			{
				{ Cue = "/VO/ErisField_0131",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Uh-uh-{#Emph}uh! {#Prev}The trail to the mountain's {#Emph}closed{#Prev}, in case you hadn't heard the latest, babe." },
			},
			ErisBossMiscStart09 =
			{
				{ Cue = "/VO/ErisField_0132",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Back for another round? Good, 'cause I've got {#Emph}thousands." },
			},
			ErisBossMiscStart10 =
			{
				{ Cue = "/VO/ErisField_0133",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Look at us, all settled into our routine. I {#Emph}hate {#Prev}routines!" },
			},
			ErisBossMiscStart11 =
			{
				{ Cue = "/VO/ErisField_0134",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Hate to do this to you, babe, but... oh, who am I kidding?" },
			},
			ErisBossMiscStart12 =
			{
				{ Cue = "/VO/ErisField_0135",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "You look lost, Trouble. Let me help you find your way back home." },
			},
			ErisBossMiscStart13 =
			{
				{ Cue = "/VO/ErisField_0136",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Don't need a reason to get in your face. But I just happen to like it!" },
			},
			ErisBossMiscStart14 =
			{
				{ Cue = "/VO/ErisField_0137",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "So, ready to get shot all the way back to hell, Trouble?" },
			},
			ErisBossMiscStart15 =
			{
				{ Cue = "/VO/ErisField_0138",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Hope you're not sea-sick, babe. 'Cause {#Emph}you {#Prev}are about to get {#Emph}rocked." },
			},
			ErisBossMiscStart16 =
			{
				{ Cue = "/VO/ErisField_0139",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "If only you could fly, babe. But you can't! And I can't let you out of here." },
			},
			ErisBossMiscStart17 =
			{
				{ Cue = "/VO/ErisField_0140",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "What we're about to do, babe, I can do {#Emph}all night... {#Prev}after {#Emph}night{#Prev}, after {#Emph}night." },
			},
			ErisBossMiscStart18 =
			{
				{ Cue = "/VO/ErisField_0141",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "So maybe I can't kill you, Trouble, but I sure can try." },
			},
			ErisBossMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0141",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "So maybe I can't kill you, Trouble, but I sure can try." },
			},
			ErisBossMiscStart20 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = ">=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0142",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "How many times am I gonna have to shoot you down, here, babe?" },
			},
			ErisBossMiscStart21 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = ">=",
						Value = 0,
					},
					ConsecutiveDeathsInRoom = { Name = "O_Boss01", Count = 2 },
				},
				{ Cue = "/VO/ErisField_0143",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "You're {#Emph}sick{#Prev}, babe! Losing over and over and {#Emph}over{#Prev}, and still you keep on?" },
			},
			ErisBossMiscStart22 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0144",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Can't always stop you, but I can {#Emph}always {#Prev}slow you down." },
			},
			ErisBossMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0145",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "I'm a good sport, Trouble. Win or lose, it's all the same to me." },
			},

		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Eris )