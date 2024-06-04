UnitSetData.Polyphemus =
{
	Polyphemus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Cyclops_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.PolyphemusVoice,
		AnimOffsetZ = -130,
		MaxHealth = 8400,
		AISetupDelay = 1.5,
		EmoteOffsetX = -100,
		SpeakerName = "Polyphemus",

		InvulnerableFx = "Invincibubble_Scylla",
		SpeechCooldownTime = 11,

		Groups = { "GroundEnemies" },
		DeathAnimation = "Enemy_Polyphemus_Death_Start",
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CyclopsDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, AddInterBiomeTimerBlock = true },

		KillEnemyEvents =
		{
			{
				FunctionName = "WipeSpawnsOnKill",
			},
		},

		SpawnUnitOnDeath = "PolyphemusCorpse",
		SpawnUnitOnDeathMatchAngle = true,
		DestroyDelay = 0.0,

		OnDamagedFunctionNames = { "CheckWeaponInterrupt" },

		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarTextId = "Cyclops_Full",
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,


		DefaultAIData =
		{
			--BeginPickupAnimation = "Enemy_MaleGrey_GroundPunch",
			--PickupAnimation = "Enemy_MaleGrey_Idle",
			AIPickupTime = 0.2,
			AIPickupRange = 250,
			MoveToPickupTimeout = 10.0,

			DashIfOverDistance = 1,
			DashWeapon = "PolyphemusLeap",

			InterruptWeapon = "PolyphemusBoulderThrow",
		},
		WeaponOptions = { "PolyphemusSlam", "PolyphemusKick", "PolyphemusLeap", "PolyphemusPlayerGrab", "PolyphemusGrab", },
		--WeaponOptions = { "PolyphemusLeap", "PolyphemusPlayerGrab", "PolyphemusMarch" },

		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "PolyphemusSearch", "PolyphemusSearch_Sick", "PolyphemusSearch_Zombie", "PolyphemusSearch_Explosive", },
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},				
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PolyphemusMegaLeap",
				WaitDuration = 0,
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				UnequipAllWeapons = true,
				EquipRandomWeapon = { "PolyphemusSearch", "PolyphemusSearch_Sick", "PolyphemusSearch_Zombie", "PolyphemusSearch_Explosive", },
				EquipWeapons= { "PolyphemusLeap", "PolyphemusMarch", "PolyphemusPlayerGrab", "PolyphemusPlayerGrab", "PolyphemusGrab" },
			},

			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PolyphemusMegaLeapElite",
				WaitDuration = 0,
				--EquipWeapons = {  },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				MusicSection = 3,
				UnequipAllWeapons = true,
				EquipRandomWeapon = { "PolyphemusSearch", "PolyphemusSearch_Sick", "PolyphemusSearch_Zombie", "PolyphemusSearch_Explosive", },
				EquipWeapons= { "PolyphemusStomp", "PolyphemusStomp", "PolyphemusLeap", "PolyphemusLeap", "PolyphemusKick", "PolyphemusSlam", "PolyphemusMarchElite" },

				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlay = 0.75,
					Cooldowns =
					{
						-- { Name = "CyclopsSearchedRecently", Time = 30 },
					},
					TriggerCooldowns = { "CyclopsSpokeRecently" },

					{ Cue = "/VO/Polyphemus_0256", Text = "All right that does it." },
					{ Cue = "/VO/Polyphemus_0257", Text = "That does it." },
					{ Cue = "/VO/Polyphemus_0258", Text = "Making me mad here." },
					{ Cue = "/VO/Polyphemus_0259", Text = "'Nough foolin' around." },
					{ Cue = "/VO/Polyphemus_0260", Text = "All right then..." },
					{ Cue = "/VO/Polyphemus_0261", Text = "You're gonna pay real soon..." },
					{ Cue = "/VO/Polyphemus_0262", Text = "I'm not appreciatin' this." },
					{ Cue = "/VO/Polyphemus_0263", Text = "You lousy little..." },
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
				{ Name = "CyclopsSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Polyphemus_0054", Text = "Oh you like that?" },
			{ Cue = "/VO/Polyphemus_0055", Text = "Still kicking are you?" },
			{ Cue = "/VO/Polyphemus_0056", Text = "Not finished with you yet." },
			{ Cue = "/VO/Polyphemus_0057", Text = "Aw, what's the matter?" },
			{ Cue = "/VO/Polyphemus_0058", Text = "That's what you get." },
			{ Cue = "/VO/Polyphemus_0059", Text = "{#Emph}Heheheheh..." },
			{ Cue = "/VO/Polyphemus_0060", Text = "Gonna eat you...", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0061", Text = "Gonna eat you...!" },
			{ Cue = "/VO/Polyphemus_0232", Text = "That's right." },
			{ Cue = "/VO/Polyphemus_0233", Text = "Nicked you there." },
			{ Cue = "/VO/Polyphemus_0234", Text = "Must have hurt." },
			{ Cue = "/VO/Polyphemus_0235", Text = "How 'bout another?" },
			{ Cue = "/VO/Polyphemus_0236", Text = "Have some of that." },
			{ Cue = "/VO/Polyphemus_0237", Text = "Got plenty more." },
			{ Cue = "/VO/Polyphemus_0238", Text = "Eat that." },
			{ Cue = "/VO/Polyphemus_0239", Text = "Squirm all you want." },
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "CyclopsLastStandReactionSpeech", Time = 25 },
				},
				TriggerCooldowns = { "CyclopsSpokeRecently" },

				{ Cue = "/VO/Polyphemus_0163", Text = "Tough bit of meat..." },
				{ Cue = "/VO/Polyphemus_0164", Text = "Got you good." },
				{ Cue = "/VO/Polyphemus_0165", Text = "Thought I had you..." },
				{ Cue = "/VO/Polyphemus_0166", Text = "What'd you just do...?" },
				{ Cue = "/VO/Polyphemus_0167", Text = "Slippery, aren't you..." },
				{ Cue = "/VO/Polyphemus_0168", Text = "Food's almost ready..." },
				{ Cue = "/VO/Polyphemus_0169", Text = "Oh I smell blood...", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0170", Text = "Tough break." },
				{ Cue = "/VO/Polyphemus_0171", Text = "Come on, little sheep..." },
				{ Cue = "/VO/Polyphemus_0172", Text = "How about that?" },
				{ Cue = "/VO/Polyphemus_0173", Text = "That'll show you." },
				{ Cue = "/VO/Polyphemus_0174", Text = "Soften you up a bit..." },
				{ Cue = "/VO/Polyphemus_0175", Text = "So you can take a hit." },
				{ Cue = "/VO/Polyphemus_0176", Text = "That must've hurt." },
			},
		},

		GoodMealVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 10 },
				},

				{ Cue = "/VO/Polyphemus_0208", Text = "{#Emph}Mrm! {#Prev}Juicy!" },
				{ Cue = "/VO/Polyphemus_0209", Text = "{#Emph}Mmm{#Prev}, that's good." },
				{ Cue = "/VO/Polyphemus_0210", Text = "{#Emph}Aw{#Prev}, hits the spot..." },
				{ Cue = "/VO/Polyphemus_0211", Text = "{#Emph}Mmm{#Prev}, good stuff..." },
				{ Cue = "/VO/Polyphemus_0212", Text = "{#Emph}Augh{#Prev}, feeling better already." },
				{ Cue = "/VO/Polyphemus_0213", Text = "{#Emph}Mmm, mm..." },
				{ Cue = "/VO/Polyphemus_0214", Text = "{#Emph}Mm{#Prev}, my favorite." },
				{ Cue = "/VO/Polyphemus_0215", Text = "Just a quick snack..." },
			},
		},
		BadMealVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 10 },
			},

			{ Cue = "/VO/Polyphemus_0216", Text = "{#Emph}Uuagh!!" },
			{ Cue = "/VO/Polyphemus_0217", Text = "Yuck..." },
			{ Cue = "/VO/Polyphemus_0218", Text = "{#Emph}Yeugh..." },
			{ Cue = "/VO/Polyphemus_0219", Text = "{#Emph}Augh{#Prev}, rotten meat...!" },
			{ Cue = "/VO/Polyphemus_0220", Text = "{#Emph}Mph{#Prev}, meat's no good!" },
			{ Cue = "/VO/Polyphemus_0221", Text = "{#Emph}Buh{#Prev}, what'd I just eat..." },
			{ Cue = "/VO/Polyphemus_0222", Text = "{#Emph}Urgh{#Prev}, gonna be sick..." },
			{ Cue = "/VO/Polyphemus_0223", Text = "{#Emph}Mwuh! {#Prev}This isn't sheep!" },
			{ Cue = "/VO/Polyphemus_0305", Text = "{#Emph}Eugh! {#Prev}That's not good sheep." },
			{ Cue = "/VO/Polyphemus_0306", Text = "{#Emph}Eugh{#Prev}, this sheep's no good..." },
			{ Cue = "/VO/Polyphemus_0308", Text = "{#Emph}Eugh{#Prev}, spoiled meat..." },			
			{ Cue = "/VO/Polyphemus_0303", Text = "This is some nasty sheep...", PreLineWait = 0.5 },
			{ Cue = "/VO/Polyphemus_0304", Text = "Sheep's gone rotten...", PreLineWait = 0.5 },
			{ Cue = "/VO/Polyphemus_0307", Text = "Not the best meal I ever had...", PreLineWait = 0.5 },
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.2,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.15,
				},
			},
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Polyphemus_0177", Text = "Yeah right." },
			{ Cue = "/VO/Polyphemus_0178", Text = "{#Emph}Nuh-uh." },
			{ Cue = "/VO/Polyphemus_0179", Text = "That almost tickles." },
			{ Cue = "/VO/Polyphemus_0180", Text = "{#Emph}Aw{#Prev}, too bad." },
			{ Cue = "/VO/Polyphemus_0182", Text = "{#Emph}Psh." },
		},
		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "CyclopsSpokeRecently" },

			{ Cue = "/VO/Polyphemus_0333", Text = "Hey, what was {#Emph}that?", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0334", Text = "Didn't even hurt." },
			{ Cue = "/VO/Polyphemus_0335", Text = "What the...?" },
			{ Cue = "/VO/Polyphemus_0336", Text = "Weak." },
		},

		--[[ handled in GlobalVoiceLines.DeathVoiceLines
		CauseOfDeathVoiceLines =
		{
		},
		]]--

		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
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
				TriggerCooldowns = { "CyclopsSpokeRecently" },

				{ Cue = "/VO/Polyphemus_0341", Text = "That a {#Emph}cat?", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0342", Text = "Cool it, cat." },
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
				{ Name = "CyclopsSpokeRecently", Time = 25 },
			},				
			GameStateRequirements =
			{
				-- RequiredFalseTextLines = { "MegaeraGift10" },
			},

			{ Cue = "/VO/Polyphemus_0062", Text = "Oof!" },
			{ Cue = "/VO/Polyphemus_0063", Text = "You no good..." },
			{ Cue = "/VO/Polyphemus_0068", Text = "{#Emph}Rngh...." },
			{ Cue = "/VO/Polyphemus_0069", Text = "{#Emph}Ugh, {#Prev}you..." },
			{ Cue = "/VO/Polyphemus_0070", Text = "Give me a break." },
			{ Cue = "/VO/Polyphemus_0071", Text = "Well damn." },
			{ Cue = "/VO/Polyphemus_0072", Text = "Really huh." },
			{ Cue = "/VO/Polyphemus_0073", Text = "So that's how it is?" },
			{ Cue = "/VO/Polyphemus_0075", Text = "That was nothing." },
			{ Cue = "/VO/Polyphemus_0077", Text = "{#Emph}Psh." },
			{ Cue = "/VO/Polyphemus_0181", Text = "{#Emph}Augh." },
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
				{ Name = "CyclopsSpokeRecently", Time = 25 },
			},
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				RequiredFalseTextLines = { "MegaeraGift10" },
			},
			{ Cue = "/VO/Polyphemus_0064", Text = "You little..." },
			{ Cue = "/VO/Polyphemus_0065", Text = "{#Emph}Buh..." },
			{ Cue = "/VO/Polyphemus_0066", Text = "{#Emph}Whu..." },
			{ Cue = "/VO/Polyphemus_0067", Text = "{#Emph}Grr..." },
			{ Cue = "/VO/Polyphemus_0074", Text = "Oh come on." },
			{ Cue = "/VO/Polyphemus_0076", Text = "{#Emph}Augh..." },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },

				{ Cue = "/VO/Polyphemus_0078", Text = "{#Emph}Urghh... {#Prev}my... sheep..." },
				{ Cue = "/VO/Polyphemus_0079", Text = "{#Emph}Urkk... unggh...." },
				{ Cue = "/VO/Polyphemus_0080", Text = "{#Emph}Ungh... {#Prev}lights... out..." },
				{ Cue = "/VO/Polyphemus_0081", Text = "{#Emph}Ngh... {#Prev}so... tired..." },
				{ Cue = "/VO/Polyphemus_0082", Text = "{#Emph}Urgh... {#Prev}why... you...", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0183", Text = "{#Emph}Eugh... {#Prev}I'm... out..." },
				{ Cue = "/VO/Polyphemus_0184", Text = "{#Emph}Augh... {#Prev}break... time..." },
				{ Cue = "/VO/Polyphemus_0185", Text = "{#Emph}Nghh... auugghhh..." },
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
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1104", Text = "Lights out." },
				{ Cue = "/VO/Melinoe_1105", Text = "Good night." },
				{ Cue = "/VO/Melinoe_1106", Text = "And stay down.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1107", Text = "Sleep tight." },
				{ Cue = "/VO/Melinoe_1108", Text = "Out cold." },
				{ Cue = "/VO/Melinoe_1109", Text = "That'll show him." },
				{ Cue = "/VO/MelinoeField_1723", Text = "Don't stand in my way." },
				{ Cue = "/VO/MelinoeField_1726", Text = "...Eat {#Emph}that.", PreLineWait = 7.4 },
				{ Cue = "/VO/MelinoeField_1724", Text = "Fast asleep again...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1725", Text = "Sleep well, Cyclops...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1727", Text = "All tired out.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1728", Text = "Nap time.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
			},
		},

		BossIntroTextLineSets =
		{
			PolyphemusFirstMeeting =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0002", Speaker = "NPC_Cyclops_Unnamed_01",
					Text = "You frightened my sheep. That's a real no-no in this town." },
				{ Cue = "/VO/Melinoe_0490", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I apologize for my transgression, Cyclops. What do I owe you for the inconvenience? I can pay." },
				{ Cue = "/VO/Polyphemus_0003", Speaker = "NPC_Cyclops_Unnamed_01",
					Text = "Oh, you'll pay. The punishment's gettin' eaten alive. By {#Emph}me{#Prev}. Sorry, I don't make the rules." },
				{ Cue = "/VO/Melinoe_0491", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "That seems unusually strict. There's no use following a senseless code of law." },
				{ Cue = "/VO/Polyphemus_0004", Speaker = "NPC_Cyclops_Unnamed_01",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Hah{#Prev}, only kiddin'! I {#Emph}do {#Prev}make the rules. And I get real tired only eatin' sheep." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					TriggerCooldowns = { "CyclopsSpokeRecently" },
					{ Cue = "/VO/Melinoe_0492", Text = "I know who you are. You'll eat dust!" },
				},
			},
			PolyphemusAboutFlock01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0005",
					Text = "Can't you see I'm busy over here? Personally, I can't see a thing. Do I complain? No. I just tend my flock." },
				{ Cue = "/VO/Melinoe_0493", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Your blasted sheep are some of the most high-strung animals I have ever encountered." },
				{ Cue = "/VO/Polyphemus_0006",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Sheep are fast. It's not an easy job. And it's even harder when somebody makes a ruckus in my meadow. So what choice do I have? Besides eating {#Emph}you?" },
			},
			PolyphemusAboutFriendship01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0007",
					Text = "You coulda had my friendship. A couple of my sheep. But instead? You spit in my eye." },
				{ Cue = "/VO/Melinoe_0494", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I have done no such thing. I merely need access to the docks. Yet you insist on getting in my way." },
				{ Cue = "/VO/Polyphemus_0008",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Put yourself in my sandals. What would {#Emph}you {#Prev}do? You'd say: {#Emph}I don't like the way you're treating me. I am gonna eat you." },
			},
			PolyphemusAboutDiet01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0009",
					Text = "I try to watch my diet. Three square meals, that's it. No snacks. You're making it real difficult for me." },
				{ Cue = "/VO/Melinoe_0495", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Where I am from, we fast under the waxing moon. And we grow many nutritious plants and fungus. I could bring you some next time if you would like?" },
				{ Cue = "/VO/Polyphemus_0010",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I can't just save you for later. You'd try to run. They always do. Oh, {#Emph}I {#Prev}know! I'll just start with the legs!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0496", Text = "No you won't." },
				},
			},

			PolyphemusAboutPast01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0139",
					Text = "Just wanted to be left alone. Move to the countryside, quiet life of the shepherd and all. Only for you to drag me out of retirement." },
				{ Cue = "/VO/MelinoeField_0320", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I've done no such thing. I'm going to the docks. You're choosing to try and stop me, when you could be tending to your sheep instead." },
				{ Cue = "/VO/Polyphemus_0140",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh I'll {#Emph}tend {#Prev}to them all right. But in order to do that, I got to tend to the likes of {#Emph}you {#Prev}first. Just like I used to in the good old days." },
			},

			PolyphemusAboutWar01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0129",
					Text = "{#Emph}<Sigh> {#Prev}Look, I'm just a humble shepherd trying to live in peace. But I gotta protect my own, you understand. Plus, I gotta eat." },
				{ Cue = "/VO/MelinoeField_0313", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You call this trying to live in peace?! Perhaps you shouldn't be interfering with my efforts to put an end to this war raging all around us!" },
				{ Cue = "/VO/Polyphemus_0130",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The dead don't bother me. It's the living always been a pain in my behind. Good thing the {#Emph}living {#Prev}taste better than the {#Emph}dead." },
			},

			PolyphemusAboutBoulders01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0133",
					Text = "You know I can always hear you storming through town all the way from this calm relaxing pasture. Even before my sheep get spooked." },
				{ Cue = "/VO/MelinoeField_0316", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Yes, I figured the boulders raining down back there weren't landing near me by coincidence. You have excellent hearing, and rather good aim." },
				{ Cue = "/VO/Polyphemus_0134",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Aw, thanks. And you got {#Emph}excellent {#Prev}taste, I'm sure. Now hold still, so I can practice my {#Emph}rather good aim {#Prev}some more." },
			},

			PolyphemusAboutBlindness01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_0352", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Each time you know I'm here, no matter the softness of my approach or anything I do to mask my scent. Your senses are very keen." },
				{ Cue = "/VO/Polyphemus_0190",
					Text = "Yeah, well, when you lose your eye... you got to learn to compensate. And I never saw too good to start with. Could never tell how far away things were." },
				{ Cue = "/VO/MelinoeField_0353", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It must have been extraordinarily difficult, nevertheless. And now you use these heightened abilities to tend your flock..." },
				{ Cue = "/VO/Polyphemus_0191",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Heightened abilities{#Prev}, I like that. Look, this world's a real ugly place. Difference between you and me is, I don't got to look at it no more. Now, hold still or start running... I don't even care." },
			},

			PolyphemusAboutSheep01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_0321", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "If you care so much about your sheep, why keep putting them in harm's way? Not to mention eating them. Let them leave here, now." },
				{ Cue = "/VO/Polyphemus_0141",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "Scuse me? I didn't ask you for your shepherding advice, and besides... these sheep got nowhere else to be. And we're the {#Emph}dinner entertainment." },
			},

			PolyphemusAboutNobody01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0011",
					Text = "You know who's disrespected me like this? Nobody. Nobody took my sheep. Took my eye." },
				{ Cue = "/VO/Melinoe_0497", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Nobody took your eye? You must have lost it. I'll keep an eye out for it! I mean... {#Emph}augh..." },
				{ Cue = "/VO/Polyphemus_0012",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nobody's gonna pay for all that someday. But you're gonna pay right now. {#Emph}Heh. {#Prev}Metaphorically, I mean! I'm not gonna take your money. Just gonna eat ya... bones and all." },
			},
			PolyphemusAboutNobody02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutNobody01" },
					},
				},
				{ Cue = "/VO/MelinoeField_0314", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You said nobody took your eye before, as well as your sheep. How did you lose them, then?" },
				{ Cue = "/VO/Polyphemus_0131",
					Text = "Nobody played a dirty trick on me, is how. Bunch of sailors thought they could get away with my sheep, so I ate a couple of 'em. The sailors, that is! But Nobody got me when I wasn't looking. Then he got away..." },
				{ Cue = "/VO/MelinoeField_0315", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "And you've sought vengeance on this Nobody ever since?" },
				{ Cue = "/VO/Polyphemus_0132",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, not me personally! Someday, somebody's gonna get Nobody for what he did. Though, I am gonna get {#Emph}you {#Prev}right here and now." },
			},
			PolyphemusAboutNobody03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PolyphemusAboutNobody02", "PolyphemusAboutNobodyKeepsake01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0289",
					Text = "No wonder you and Nobody are pals. He and his rats are the only ones that ever got away from me, other than you. That worthless good-for-nothing put you up to this?" },
				{ Cue = "/VO/MelinoeField_1949", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "His name is Odysseus! He's a great hero and tactician, though you needn't worry about slaying him, for he's long dead already. Not your problem anymore." },
				{ Cue = "/VO/Polyphemus_0290",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not my problem, I'm not so sure. You and the dead seem to go hand-in-hand! Don't care what he's callin' himself now, he's {#Emph}Nobody {#Prev}to me. Now how 'bout I send him a {#Emph}message?" },
			},

			PolyphemusAboutNobodyKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "BossPreDamageKeepsake" },
					},
				},
				{ Cue = "/VO/Polyphemus_0287",
					Text = "{#Emph}<Sniff, Sniff> {#Prev}I never forget a scent, you know. And you got something that's familiar to me from way back when. I know those Bones. {#Emph}Nobody {#Prev}had 'em before you." },
				{ Cue = "/VO/MelinoeField_1948", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You must mean these Knuckle Bones... if they've ever been a source of ill fortune for you before, then perhaps you know what's coming." },
				{ Cue = "/VO/Polyphemus_0288",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nobody's your {#Emph}pal{#Prev}, is that what you expect me to believe? Then first I'm gonna crush {#Emph}your {#Prev}bones, and then I'll eat 'em. And those Knuckle Bones, too." },
			},

			PolyphemusAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutPolyphemus01" },
					},
				},
				{ Cue = "/VO/MelinoeField_0310", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You're very obstinate for a peaceful shepherd. Did Poseidon do something to offend you at some point? Is {#Emph}that {#Prev}what this is about?" },
				{ Cue = "/VO/Polyphemus_0125",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, I don't get {#Emph}offended... {#Prev}I get {#Emph}even. {#Prev}And you don't get to ask questions no more... you get {#Emph}eaten." },
			},
			PolyphemusAboutPoseidon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutPoseidon01" },
					},
				},
				{ Cue = "/VO/MelinoeField_0311", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Last I'll say about Poseidon, I swear. He's my uncle, you know. For what it's worth... I'm sorry if he truly led you to believe you were his son." },
				{ Cue = "/VO/Polyphemus_0126",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yeah, well, I like to play up the family resemblance just in case. Though I'm glad he's not my pop neither. Otherwise I'd be about to eat my own cousin, and that'd be real weird." },
			},

			PolyphemusAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PolyphemusAboutDocks01", "PolyphemusAboutEphyra01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0127",
					Text = "Hey what's your beef with Chronos, anyhow? He wants to change stuff up a bit, so what. Life's hard up here. It could be easier." },
				{ Cue = "/VO/MelinoeField_0312", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It won't be. That {#Emph}town {#Prev}back there, as you call it, would have been bustling with mortals. Now it's a festering necropolis. All thanks to the Titan." },
				{ Cue = "/VO/Polyphemus_0128",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "My sheep, they're glad to be alive. No complaints. But individuals like you? You got too many ideals. Best I {#Emph}eat {#Prev}you, and be done." },
			},

			PolyphemusAboutMedea01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" }
					},
				},
				{ Cue = "/VO/Polyphemus_0136",
					Text = "Something {#Emph}nasty {#Prev}in the air tonight. And it's not just {#Emph}you {#Prev}or the stink from town. Must be that witch up to no good. You palling up with her?" },
				{ Cue = "/VO/MelinoeField_0318", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "If you know of Lady Medea then you must know she's not somebody to be crossed. She would not hesitate to curse my foes; including you." },
				{ Cue = "/VO/Polyphemus_0137",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Was that a threat? I think it was. You don't go saying stuff like that, not in this town. Your {#Emph}pal {#Prev}knows to stay where I can't smell her, unlike {#Emph}you." },
			},
			PolyphemusAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFieldAboutPolyphemus01" }
					},
				},
				{ Cue = "/VO/MelinoeField_0319", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "How is it you detain {#Emph}me {#Prev}every time, yet the mighty Heracles can rampage through the city all he likes and never has to deal with you? Or so he says." },
				{ Cue = "/VO/Polyphemus_0138",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It's called a {#Emph}double standard{#Prev}, little sheep. Don't need my eye to know he's way bigger than you. You can knock me out for a nice short nap; he can knock me into next week. No thanks." },
			},

			PolyphemusAboutCyclopes01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_0317", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "What's become of the other Cyclopes? Your kind once aided the gods against the Titans, crafting weapons of war and such. Yet {#Emph}you {#Prev}turn your back..." },
				{ Cue = "/VO/Polyphemus_0135",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What, you think we all keep in touch just 'cause we got one eye at most? What they did and what happened to 'em don't matter to me. 'Specially not when I'm {#Emph}hungry..." },
			},

			PolyphemusAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusLostAgainstHim02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutUnderworld01B" },
					},
				},
				{ Cue = "/VO/Polyphemus_0119",
					Text = "You some kind of {#Emph}deathless goddess of the Underworld{#Prev}, you said? Seems you'd be better off staying on {#Emph}your {#Prev}side of the fence." },
				{ Cue = "/VO/MelinoeField_0307", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'm here to pay my relatives a visit. You just keep getting in the way. Almost as though violence better suits you than the shepherd's life." },
				{ Cue = "/VO/Polyphemus_0120",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Why, you're a real thinker for a slice of meat! Just 'cause I'm retired don't mean I don't want to work up an appetite no more, does it now?" },
			},
			PolyphemusAboutUnderworld01B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutUnderworld01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0121",
					Text = "{#Emph}<Sniff> {#Prev}You stink like the dead. But you're not from the town. You're from further below. You'd be better off staying on your side of the fence." },
				{ Cue = "/VO/MelinoeField_0307", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'm here to pay my relatives a visit. You just keep getting in the way. Almost as though violence better suits you than the shepherd's life." },
				{ Cue = "/VO/Polyphemus_0120",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Why, you're a real thinker for a slice of meat! Just 'cause I'm retired don't mean I don't want to work up an appetite no more, does it now?" },
			},

			PolyphemusAboutEphyra01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_0308", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Are you the one responsible for that spectral barrier at the city gates? It has the markings of Chronos all over it, and you seem to be the extra backup in case it fails." },
				{ Cue = "/VO/Polyphemus_0122",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh that thing, yeah, I knew it'd never hold. But they keep fixing it anyway. Almost like somebody out there don't want you here..." },
			},

			PolyphemusAboutDocks01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "O_Intro" },
					},
				},
				{ Cue = "/VO/Polyphemus_0123",
					Text = "I made those docks back there with my bare hands. Know some guys, they tally every skiff and trireme in the drink. We know where you're going." },
				{ Cue = "/VO/MelinoeField_0309", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "So what if you do? You're just another servant of Chronos. The gods shall punish you when all this is over." },
				{ Cue = "/VO/Polyphemus_0124",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ehh{#Prev}, what do you know about it? They only care about their own. I'm just a joke to them. Am I a joke... to {#Emph}you?" },
			},

			PolyphemusAboutBarn01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "N_PostBoss01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0281",
					Text = "You went through my old barn the other night while I was out. Coulda cased the joint but you didn't. Drank from my well and that was it." },
				{ Cue = "/VO/MelinoeField_1929", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'm no thief. And besides, your residence is filthy! You could stand to clean it up instead of facing me. Let me know if you need assistance, as I'll soon be passing through again." },
				{ Cue = "/VO/Polyphemus_0282",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Nah{#Prev}, thanks. If it was tidy in there I couldn't sniff my way around. And also, you {#Emph}shut up! {#Prev}I don't go tellin' {#Emph}you {#Prev}the way {#Emph}you {#Prev}oughtta live!" },
			},

			PolyphemusAboutThessaly01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0285",
					Text = "Where do you think you're goin', anyway? No ship that sails from the docks back there is gonna take the likes of {#Emph}you. {#Prev}Come to think of it... lately, we've had no ships at all." },
				{ Cue = "/VO/MelinoeField_1947", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "The deathless fleet of Chronos is still out there in the waters of the Rift. Apparently when one ship sinks, another rises to replace it from the depths, drowned sailors for its crew..." },
				{ Cue = "/VO/Polyphemus_0286",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're pulling my leg. The dead can sail nowadays? I thought they were no good for anything but food. Might have to teach 'em to take on some of my household chores..." },
			},

			PolyphemusAboutInsomnia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0142",
					Text = "Funny. Running into you again and again like this? It's made for some of the best sleep I got in years." },
				{ Cue = "/VO/MelinoeField_0322", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Is that so? Well it would be even easier for me to knock you out cold if you didn't fight back." },
				{ Cue = "/VO/Polyphemus_0143",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Eh{#Prev}, the fight's what does the trick. I don't give it my all, I don't get that deep relaxing slumber afterwards. Or the opportunity to get a hearty meal." },
			},
			PolyphemusAboutInsomnia02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutInsomnia01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/MelinoeField_0323", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You know, if you've been having trouble sleeping, there's got to be a better solution than these repeated drubbings from me." },
				{ Cue = "/VO/Polyphemus_0144",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I tried a lot of stuff. Sleeping on a full stomach, sleeping on an empty stomach. Nothing worked, but this? This works just fine for now..." },
			},

			PolyphemusLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 2,
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Polyphemus_0145",
					Text = "{#Emph}<Sniff> {#Prev}I smell {#Emph}blood. {#Prev}I was just getting ready to prepare my next meal... but the town welcoming committee must have prepped you already." },
				{ Cue = "/VO/MelinoeField_0324", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "The {#Emph}welcoming committee{#Prev}, as you call it, are servants of Chronos... and shall suffer for their arrogance. You would cast your lot with {#Emph}them?" },
				{ Cue = "/VO/Polyphemus_0146",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know, I used to have a little trouble eating food that looked back at me, or talked back at me. But I don't got that problem no more." },
			},
			PolyphemusLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 2,
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Polyphemus_0147",
					Text = "{#Emph}Ooh, {#Prev}I can tell the town welcoming committee must have done a number on you already. Softened you up {#Emph}good. {#Prev}All the better for {#Emph}me." },
				{ Cue = "/VO/MelinoeField_0325", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "The city's filled with the unburied dead. I can slay them but they merely rise again; they're very troublesome. The same as you." },
				{ Cue = "/VO/Polyphemus_0148",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Now don't you get testy. This is {#Emph}my {#Prev}pasture not yours. And every little sheep around here answers to {#Emph}me." },
			},

			PolyphemusLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				{ Cue = "/VO/Polyphemus_0115",
					Text = "{#Emph}Ah! {#Prev}Just when I thought I had you last time, you gave me the slip. Didn't think I'd have another shot." },
				{ Cue = "/VO/MelinoeField_0305", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You'll soon have many more such {#Emph}shots. {#Prev}But you're going to fail every time, I promise you." },
				{ Cue = "/VO/Polyphemus_0116",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "How 'bout you promise me the {#Emph}meat on your bones. {#Prev}Though I get the feeling you don't got much to offer." },
			},
			PolyphemusLostAgainstHim02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = ">",
						Value = 0.1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusLostAgainstHim01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0117",
					Text = "Don't like playing with my food. Like it even less when my food plays with {#Emph}me. {#Prev}I'm on to that disappearing act of yours." },
				{ Cue = "/VO/MelinoeField_0306", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I am a deathless goddess of the Underworld; the shadows will always take me before you will. Yet you would fight me endlessly anyway?" },
				{ Cue = "/VO/Polyphemus_0118",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh yeah! Everybody slips up once in a while. Even you. And when you do... we'll find out just how {#Emph}deathless {#Prev}you are." },
			},
			PolyphemusBarelyLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "N_Boss01" },
					},					
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = ">",
						Value = 0.0,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<",
						Value = 0.25,
					},
				},
				{ Cue = "/VO/Polyphemus_0283",
					Text = "Almost got me last time, but not quite. Come to finish the job? You wouldn't be the first to try. But I'm still here, and you don't see anybody else around, do ya?" },
				{ Cue = "/VO/MelinoeField_1946", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Finish {#Emph}what {#Prev}job? You're not my mark. I'd just as soon slip past you and be on my way, except your blasted sense of smell and hearing are too good." },
				{ Cue = "/VO/Polyphemus_0284",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Why, thanks. And you know how I keep 'em top-notch like this, don't ya? When you got gifts like these, you gotta put 'em to good use." },
			},
			PolyphemusWonAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0111",
					Text = "Oh, {#Emph}hey! {#Prev}I wanted to say thanks. Gave me a real zinger there last time, you know that?" },
				{ Cue = "/VO/Melinoe_0938", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You're back. And you're grateful that I vanquished you earlier? You seem more the sort to hold a grudge." },
				{ Cue = "/VO/Polyphemus_0112",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I am, I am, it's just... I hadn't had a good night's sleep in I-don't-know-how-long. After you knocked me out cold, I woke up feeling more refreshed than ever! And real hungry, too." },
			},
			PolyphemusWonAgainstHim02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0113",
					Text = "{#Emph}Tsch! {#Prev}Don't even try and sneak by. What, you think you were gonna catch me napping here? Not gonna happen." },
				{ Cue = "/VO/Melinoe_0939", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It might. If you keep blocking my path, you'll get another thrashing, and you'll be sound asleep again in no time. That what you want?" },
				{ Cue = "/VO/Polyphemus_0114",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh! Got a dilemma on my hands! I'm always sleepy, yeah. But I'm always hungry, too. Guess that makes this a {#Emph}can't-lose proposition." },
			},

			-- Repeatable / other general cases
			PolyphemusMiscStart01 =
			{
				{ Cue = "/VO/Polyphemus_0013",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Stepped out of line {#Emph}again{#Prev}, little sheep. You know what happens next." },
			},
			PolyphemusMiscStart02 =
			{
				{ Cue = "/VO/Polyphemus_0014",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "{#Emph}<Sniff> {#Prev}Something stinks... oh I know what it is. It's {#Emph}you." },
			},
			PolyphemusMiscStart03 =
			{
				{ Cue = "/VO/Polyphemus_0015",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "No sneaking past my sheep. No sneaking past me, neither." },
			},
			PolyphemusMiscStart04 =
			{
				{ Cue = "/VO/Polyphemus_0016",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "One of these nights... I'm gonna catch you. And I'm gonna eat you." },
			},
			PolyphemusMiscStart05 =
			{
				{ Cue = "/VO/Polyphemus_0017",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "It's a little early for my dinnertime, but hey! I can be flexible." },
			},
			PolyphemusMiscStart06 =
			{
				{ Cue = "/VO/Polyphemus_0018",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "{#Emph}Phew! {#Prev}Know I could smell you from a league away?" },
			},
			PolyphemusMiscStart07 =
			{
				{ Cue = "/VO/Polyphemus_0019",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You just don't know what's good for you, do you?" },
			},
			PolyphemusMiscStart08 =
			{
				{ Cue = "/VO/Polyphemus_0020",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You want some more of this, that's fine by me. Oh, I got plenty." },
			},
			PolyphemusMiscStart09 =
			{
				{ Cue = "/VO/Polyphemus_0021",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Don't normally like eating my food raw. But then, I like to try new stuff." },
			},
			PolyphemusMiscStart10 =
			{
				{ Cue = "/VO/Polyphemus_0022",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Shh! {#Prev}Think I heard something. You hear it, right? The dinner bell..." },
			},
			PolyphemusMiscStart11 =
			{
				{ Cue = "/VO/Polyphemus_0149",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Well, what do you know? It's dinnertime already..." },
			},
			PolyphemusMiscStart12 =
			{
				{ Cue = "/VO/Polyphemus_0150",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "All this shepherding all day works up a real appetite..." },
			},
			PolyphemusMiscStart13 =
			{
				{ Cue = "/VO/Polyphemus_0151",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Welcome back to the flock, little sheep. Now, come 'ere..." },
			},
			PolyphemusMiscStart14 =
			{
				GameStateRequirements =
				{
					{
						--
					},
					ConsecutiveClearsOfRoom = { Name = "N_Boss01", Count = 1 },
				},
				{ Cue = "/VO/Polyphemus_0152",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Got myself a good night's rest, but not enough to eat..." },
			},
			PolyphemusMiscStart15 =
			{
				{ Cue = "/VO/Polyphemus_0153",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You want to get to those docks, I want to eat you. Just the way it is." },
			},
			PolyphemusMiscStart16 =
			{
				{ Cue = "/VO/Polyphemus_0154",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Do remember to watch for falling rocks in this town." },
			},
			PolyphemusMiscStart17 =
			{
				{ Cue = "/VO/Polyphemus_0155",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Here comes some {#Emph}dead meat{#Prev}, fresh from out of town..." },
			},
			PolyphemusMiscStart18 =
			{
				{ Cue = "/VO/Polyphemus_0156",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "I really got to do something about that wall you keep on getting through..." },
			},
			PolyphemusMiscStart19 =
			{
				{ Cue = "/VO/Polyphemus_0157",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You're back for some more shepherding, huh, little sheep?" },
			},
			PolyphemusMiscStart20 =
			{
				{ Cue = "/VO/Polyphemus_0158",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "No one gets in this town, no one gets out; those are the rules." },
			},
			PolyphemusMiscStart21 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0159",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Got to hand it to ya. I've been sleeping like a baby lately over here." },
			},
			PolyphemusMiscStart22 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0160",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "After a hard day's shepherding, I could go for a good knock-out about now." },
			},
			PolyphemusMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						--
					},
					ConsecutiveClearsOfRoom = { Name = "N_Boss01", Count = 2 },
				},
				{ Cue = "/VO/Polyphemus_0161",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Even if I can't eat you, least I'll get some decent sleep here in a bit." },
			},
			PolyphemusMiscStart24 =
			{
				GameStateRequirements =
				{
					{
						--
					},
					ConsecutiveClearsOfRoom = { Name = "N_Boss01", Count = 2 },
				},
				{ Cue = "/VO/Polyphemus_0162",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Guess it's almost my bedtime. But first, a little bit of exercise..." },
			},
			PolyphemusMiscStart25 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Polyphemus_0321",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Kick you right into the Moon right now if I could see the thing." },
			},
			PolyphemusMiscStart26 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0322",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Really want to get stomped on some more, I'm good for it." },
			},
			PolyphemusMiscStart27 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0323",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You want to end up like my sheep, you keep this up." },
			},
			PolyphemusMiscStart28 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0324",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "{#Emph}Ohh{#Prev}, you just wait'll I get these hands on {#Emph}you." },
			},
			PolyphemusMiscStart29 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0325",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Little early for my dinnertime, but then, I shouldn't eat so late." },
			},
			PolyphemusMiscStart30 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0326",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "You step onto my turf, you pay the price, that's just the rules." },
			},

		},
	},

	PolyphemusCorpse =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Polyphemus",
		RequiredKill = false,
		TriggersOnHitEffects = true,
		BlocksLootInteraction = false,
		CannotDieFromDamage = true,
		UseActivatePresentation = false,
		ImmuneToPolymorph = true,
		StunAnimations = 
		{
			Default = "Enemy_Polyphemus_DeathOnHit",
		},

		Material = "OrganicObstacle",
		OnHitVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.45,
			ChanceToPlay = 0.33,
			Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 15 },
			},

			{ Cue = "/VO/Polyphemus_0085", Text = "...so... fluffy..." },
			{ Cue = "/VO/Polyphemus_0086", Text = "...that... {#Emph}hmhm... {#Prev}tickles...", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0087", Text = "...my... sheep..." },
			{ Cue = "/VO/Polyphemus_0088", Text = "...so... tired..." },
			{ Cue = "/VO/Polyphemus_0186", Text = "...{#Emph}n'huh... huh..." },
			{ Cue = "/VO/Polyphemus_0187", Text = "...still... sleeping... here..." },
			{ Cue = "/VO/Polyphemus_0188", Text = "...not... now... Pop..." },
			{ Cue = "/VO/Polyphemus_0189", Text = "...be... up... soon..." },
		},
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.Polyphemus )