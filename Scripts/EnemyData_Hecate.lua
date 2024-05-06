UnitSetData.Hecate =
{
	Hecate =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},

		Portrait = "Portrait_Hec_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.HecateVoice,
		SpeakerName = "Hecate",
		SpeechParams =
		{
			Radius = 1,
		},
		AnimOffsetZ = 0,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,
		CreateAnimations =
		{
			"HecateGroundGlow",
		},

		MaxHealth = 5800,
		AISetupDelay = 0.2, -- this delays the weapon firing off after the narrative sequence, please don't change		

		SpeechCooldownTime = 11,

		Groups = { "GroundEnemies", "FlyingEnemies" },
		OnDeathFunctionName = "HecateKillPresentation",
		OnDeathFunctionArgs = { Message = "BiomeClearedMessage", CameraPanTime = 0.3, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", AddInterBiomeTimerBlock = true },
		DeathAnimation = "HecateBattleOutfitBattleOutro",
		LastHitAnimation = "HecateLastHit",
		InvulnerableFx = "Invincibubble_Hecate",
		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarTextId = "Hecate_Full",
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,
		DefaultAIData =
		{

		},
		WeaponOptions = { "HecateMeleeCombo1", "HecateMelee1", "HecateSplit1" },
		--WeaponOptions = { "HecateSplit1" },
		EndSpawnEncounterOnDeath = true,

		OutgoingDamageModifiers =
		{ 
			{
				SelfMultiplier = 0.0,
			},
		},

		Using = { GrannyModel = { "WeaponHecateR_HecateScale_Mesh", "WeaponHecateL_HecateScale_Mesh", "WeaponHecateMultiple_Mesh", "WeaponHecateR_Mesh", "WeaponHecateL_Mesh" } },

		PreBossAISetupFunctionName = "HecateBattleStart",
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
				TransitionFunction = "HecateStageTransition1",
				SpawnEncounter = "HecateSpawns01",
				WipeEnemyTypes = { "HecateCopy" },
				NewVulnerability = false,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				WaitDuration = 0.0,
				UnequipAllWeapons = true,
				MidPhaseWeapons = { "HecateMeteorShower", "HecateMeteorSmallShower", "HecateRangedTorchesRingPhase", "HecateRangedTorchesSpiralsPhase", "HecateLaser", "HecateRangedTorchesConePhase" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				NewVulnerability = true,
				SpawnEncounter = "HecatePassiveSpawns01",
				StageEndEndSpawnEncounter = true,
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				UnequipAllWeapons = true,
				--EquipWeapons = { "HecateMeleeCombo1", "HecateMelee1", "HecateTeleport", "HecateSplit1" },
				EquipWeapons = { "HecateMeleeCombo1", "HecateMelee1", "HecateSplit2", "HecateRangedTorchesRing" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HecateStageTransition2",
				SpawnEncounter = "HecateSpawns02",
				WipeEnemyTypes = { "HecateCopy" },
				NewVulnerability = false,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				WaitDuration = 0.0,
				UnequipAllWeapons = true,
				EquipWeapons = { "HecatePolymorph" },
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				StartDelay = 0.0,
				NewVulnerability = true,
				SpawnEncounter = "HecatePassiveSpawns02",
				StageEndEndSpawnEncounter = true,
				AIData =
				{
					AIEndHealthThreshold = 0.00,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "HecateTeleport", "HecateSplit3", "HecateRangedTorchesRing", "HecateRangedTorchesCone" },
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
				{ Name = "HecateSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Hecate_0095", Text = "You could have avoided that." },
			{ Cue = "/VO/Hecate_0096", Text = "Stand up, Melinoë!" },
			{ Cue = "/VO/Hecate_0097", Text = "Too slow!" },
			{ Cue = "/VO/Hecate_0098", Text = "Wide open." },
			{ Cue = "/VO/Hecate_0099", Text = "Your guard was down." },
			{ Cue = "/VO/Hecate_0100", Text = "Preventable!" },
			{ Cue = "/VO/Hecate_0101", Text = "Defend yourself!" },
			{ Cue = "/VO/Hecate_0102", Text = "Come now." },
			{ Cue = "/VO/HecateField_0030", Text = "Caught out." },
			{ Cue = "/VO/HecateField_0031", Text = "Got you." },
			{ Cue = "/VO/HecateField_0032", Text = "Anticipate my strikes." },
			{ Cue = "/VO/HecateField_0033", Text = "Retaliate!" },
			{ Cue = "/VO/HecateField_0034", Text = "Avoidable." },
			{ Cue = "/VO/HecateField_0035", Text = "I'll not hold back." },
			{ Cue = "/VO/HecateField_0036", Text = "Remain alert!" },
			{ Cue = "/VO/HecateField_0037", Text = "Evade!" },
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "HecateSpokeRecently", Time = 8 },
					{ Name = "HecateLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Hecate_0339", Text = "My, my!" },
				{ Cue = "/VO/Hecate_0340", Text = "Focus, Melinoë!" },
				{ Cue = "/VO/Hecate_0341", Text = "Indeed!" },
				{ Cue = "/VO/Hecate_0342", Text = "Resisted me, have you?" },
				{ Cue = "/VO/Hecate_0343", Text = "Fight back!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
							Comparison = ">=",
							Value = 0.66,
						},
					}
				},
				{ Cue = "/VO/Hecate_0344", Text = "Hold fast, Witch!" },
				{ Cue = "/VO/Hecate_0345", Text = "Still on your feet?" },
				{ Cue = "/VO/Hecate_0346", Text = "You withstood that?", PlayFirst = true },
				{ Cue = "/VO/Hecate_0497", Text = "Shadows take you." },
				{ Cue = "/VO/Hecate_0498", Text = "Such an outburst!" },
				{ Cue = "/VO/Hecate_0499", Text = "Maintain control." },
				{ Cue = "/VO/Hecate_0500", Text = "Do not get careless here." },
				{ Cue = "/VO/Hecate_0501", Text = "Not ready to return?" },
				{ Cue = "/VO/Hecate_0502", Text = "Resilient aren't you." },
				{ Cue = "/VO/Hecate_0503", Text = "Resisted me again." },
				{ Cue = "/VO/Hecate_0504", Text = "Steady yourself." },
				{ Cue = "/VO/HecateField_0053", Text = "Lesson learned." },
				{ Cue = "/VO/HecateField_0054", Text = "Let us proceed..." },
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
					{ Name = "HecateSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Hecate_0505", Text = "Time's up." },
				{ Cue = "/VO/Hecate_0506", Text = "You're out of time." },
				{ Cue = "/VO/Hecate_0507", Text = "What shall you do?", PlayFirst = true },
			},
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.2,
			Cooldowns =
			{
				{ Name = "HecateSpokeRecently", Time = 25 },
			},

			{ Cue = "/VO/Hecate_0118", Text = "I'm afraid not." },
			{ Cue = "/VO/Hecate_0119", Text = "Felt not a thing." },
			{ Cue = "/VO/Hecate_0120", Text = "Irrelevant!" },
			{ Cue = "/VO/Hecate_0121", Text = "Control yourself." },
			{ Cue = "/VO/Hecate_0122", Text = "I think not." },
			{ Cue = "/VO/Hecate_0123", Text = "Try something else!" },
			{ Cue = "/VO/HecateField_0056", Text = "You strike to no avail." },
			{ Cue = "/VO/HecateField_0057", Text = "You cannot pierce my wards." },
			{ Cue = "/VO/HecateField_0058", Text = "Back off." },
			{ Cue = "/VO/HecateField_0059", Text = "Conserve your strength." },
		},
		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "HecateSpokeRecently" },

			{ Cue = "/VO/HecateField_0219", Text = "I'll keep this form, thank you.", PlayFirst = true },
			{ Cue = "/VO/HecateField_0220", Text = "{#Emph}Bah." },
			{ Cue = "/VO/Hecate_0118", Text = "I'm afraid not." },
			{ Cue = "/VO/Hecate_0119", Text = "Felt not a thing." },
			{ Cue = "/VO/Hecate_0120", Text = "Irrelevant!" },
			{ Cue = "/VO/Hecate_0122", Text = "I think not." },
			{ Cue = "/VO/Hecate_0123", Text = "Try something else!" },
			{ Cue = "/VO/HecateField_0056", Text = "You strike to no avail." },
		},

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
				TriggerCooldowns = { "HecateSpokeRecently" },

				{ Cue = "/VO/HecateField_0235", Text = "Back off, cat.", PlayFirst = true },
				{ Cue = "/VO/HecateField_0236", Text = "This {#Emph}cat..." },
				{ Cue = "/VO/HecateField_0237", Text = "Cat...?" },
				{ Cue = "/VO/HecateField_0238", Text = "Blasted cat..." },
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
				{ Name = "HecateSpokeRecently", Time = 25 },
			},				
			GameStateRequirements =
			{
			},

			-- { Cue = "/VO/Hecate_0104", Text = "Good." },
			-- { Cue = "/VO/Hecate_0107", Text = "Well done!" },
			{ Cue = "/VO/Hecate_0108", Text = "Hold nothing back!" },
			{ Cue = "/VO/Hecate_0110", Text = "There!" },
			-- { Cue = "/VO/Hecate_0111", Text = "Good form." },
			{ Cue = "/VO/Hecate_0112", Text = "Faster!" },
			{ Cue = "/VO/Hecate_0113", Text = "Again." },
			{ Cue = "/VO/Hecate_0114", Text = "Again!" },
			{ Cue = "/VO/Hecate_0115", Text = "Press the attack!" },
			{ Cue = "/VO/Hecate_0116", Text = "That's it!" },
			-- { Cue = "/VO/Hecate_0117", Text = "Well struck." },
			-- { Cue = "/VO/HecateField_0038", Text = "Do not overextend." },
			-- { Cue = "/VO/HecateField_0039", Text = "{#Emph}That {#Prev}I felt." },
			{ Cue = "/VO/HecateField_0040", Text = "Good hit." },
			{ Cue = "/VO/HecateField_0041", Text = "Well done." },
			-- { Cue = "/VO/HecateField_0042", Text = "Careful now." },
			-- { Cue = "/VO/HecateField_0043", Text = "That's it." },
			-- { Cue = "/VO/HecateField_0044", Text = "Like that." },
			{ Cue = "/VO/HecateField_0045", Text = "Follow through." },		
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
				{ Name = "HecateSpokeRecently", Time = 25 },
			},
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.05,
				},
			},

			-- { Cue = "/VO/Hecate_0103", Text = "Good!" },
			-- { Cue = "/VO/Hecate_0106", Text = "Well done." },
			-- { Cue = "/VO/Hecate_0105", Text = "{#Emph}Rngh{#Prev}, good!" },
			{ Cue = "/VO/Hecate_0109", Text = "{#Emph}Mmph..." },
			{ Cue = "/VO/Hecate_0364", Text = "{#Emph}Khh..." },
			-- { Cue = "/VO/Hecate_0365", Text = "{#Emph}Heh..." },
			{ Cue = "/VO/Hecate_0366", Text = "{#Emph}Rngh..." },
			{ Cue = "/VO/Hecate_0367", Text = "Top form..." },
			{ Cue = "/VO/Hecate_0368", Text = "End it...!" },
			{ Cue = "/VO/HecateField_0046", Text = "Press the attack...!" },
			{ Cue = "/VO/HecateField_0047", Text = "Growing strong." },
			-- { Cue = "/VO/HecateField_0048", Text = "Like that...!" },
			{ Cue = "/VO/HecateField_0049", Text = "Make the kill!" },
		},

		DeathSound = "/SFX/StabSplatterEndSequence",
		BossKillVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Queue = "Interrupt",

			{ Cue = "/VO/Hecate_0011", Text = "Stand down!" },
			{ Cue = "/VO/Hecate_0124", Text = "Enough!", PlayFirst = true },
			{ Cue = "/VO/Hecate_0125", Text = "That's quite enough!" },
			{ Cue = "/VO/Hecate_0126", Text = "Good!" },
			{ Cue = "/VO/Hecate_0127", Text = "Very good!" },
			{ Cue = "/VO/Hecate_0128", Text = "At ease!" },
			{ Cue = "/VO/Hecate_0129", Text = "Excellent." },
			{ Cue = "/VO/Hecate_0130", Text = "{#Emph}Urgh... {#Prev}excellent.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Hecate_0131", Text = "All right, all right!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Hecate" },
					},
				},
			},
			{ Cue = "/VO/Hecate_0369", Text = "Well done!" },
			{ Cue = "/VO/Hecate_0370", Text = "That is enough!" },
			{ Cue = "/VO/Hecate_0371", Text = "Enough! I yield." },
			{ Cue = "/VO/Hecate_0372", Text = "Stop! Well fought." },
			{ Cue = "/VO/Hecate_0373", Text = "All right, stand down!" },
			{ Cue = "/VO/Hecate_0374", Text = "Satisfactory!" },
			{ Cue = "/VO/Hecate_0375", Text = "{#Emph}Ungh... {#Prev}satisfactory!" },
			{ Cue = "/VO/Hecate_0376", Text = "And, hold!" },
			{ Cue = "/VO/HecateField_0080", Text = "Hold!" },
			{ Cue = "/VO/HecateField_0081", Text = "Hold! I yield." },
			{ Cue = "/VO/HecateField_0082", Text = "Hold! At ease." },
			{ Cue = "/VO/HecateField_0083", Text = "Hold! Good." },
			{ Cue = "/VO/HecateField_0084", Text = "Hold! Excellent." },
			{ Cue = "/VO/HecateField_0085", Text = "That's quite enough!" },
		},

		BossIntroTextLineSets =
		{
			HecateBossFirstAppearance =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossFirstAppearanceAlt" },
					},
				},
				{ Cue = "/VO/Hecate_0007",
					Text = "Welcome to the edge of Erebus. Well done, Melinoë." },
				{ Cue = "/VO/Melinoe_0037", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Thank you, Headmistress Hecate. I could not have reached this point without your guidance." },
				{ Cue = "/VO/Hecate_0008",
					Text = "And, in turn, you shall not {#Emph}pass {#Prev}this point without a demonstration of your capability." },
				{ Cue = "/VO/Melinoe_1171", UsePlayerSource = true,
					PreLineWait = 0.35,
					Text = "My capability? You'd have us face each other here... even though my task has already begun?" },
				{ Cue = "/VO/Hecate_0438",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your training shall never be complete. And I would know if you stand any chance at all against our enemy." },
			},
			HecateBossFirstAppearanceAlt =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossFirstAppearance" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<",
						Value = 1,
					},
				},

				{ Cue = "/VO/Hecate_0436",
					Text = "You reached the edge of Erebus already. You have surpassed my expectations, Melinoë." },
				{ Cue = "/VO/Melinoe_1170", UsePlayerSource = true,
					Text = "Thank you, Headmistress Hecate. For all your guidance, and the compliment." },
				{ Cue = "/VO/Hecate_0437",
					Text = "In my place you'd have done the same. However, now is not the time for pleasantries; 'tis for a demonstration of your capability." },
				{ Cue = "/VO/Melinoe_1171", UsePlayerSource = true,
					PreLineWait = 0.35,
					Text = "My capability...? You'd have us face each other here, even though my task has already begun?" },
				{ Cue = "/VO/Hecate_0438",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your training shall never be complete. And I would know if you stand any chance at all against our enemy." },
			},

			HecateBossAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "HecateAboutSelene01" },
					},
					-- @ update with updated requirements
					{
						Path = { "CurrentRun", "WeaponsFiredRecord" },
						CountOf = {
						 	"WeaponSpellLaser",
						 	"WeaponSpellPolymorph",
						 	"WeaponSpellSummon", 
						 	"WeaponSpellTimeSlow",
						 	"WeaponSpellPotion",
						 	"WeaponSpellMeteor",
						 	"WeaponSpellTransform",
						 	-- "SpellDrainTrait",
						 },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "RoomCountCache", "F_Boss01", },
						Comparison = ">=",
						Value = 3,
					},

				},
				{ Cue = "/VO/Hecate_0076",
					Text = "Sister Selene aided you in getting here to me. But have you learned to harness her power?" },
				{ Cue = "/VO/Melinoe_0160", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "On that account, I would prefer to demonstrate than speak. With your permission, of course, Headmistress." },
				{ Cue = "/VO/Hecate_0077",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Permission granted. Now, show me what the Moon can do once in your grasp." },
			},

			HecateBossAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Artemis_Field_01", },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Hecate_0427",
					Text = "How fares the goddess of the hunt? By now these woods must feel a second home to her." },
				{ Cue = "/VO/Melinoe_1601", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Sister Artemis appears quite well, so much as possible of late. If anything, she seems in better spirits than before." },
				{ Cue = "/VO/Hecate_0428",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Good. She, Selene, you, and I have all prepared for this contingency, and now 'tis time we shine... particularly you and I, right now." },
			},

			HecateBossAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisCombatFirstIntro" },
					},
				},
				{ Cue = "/VO/MelinoeField_0010", UsePlayerSource = true,
					Text = "Does anyone besides me ever happen on you in this glade? Perhaps some evening Artemis or someone may appear instead." },
				{ Cue = "/VO/HecateField_0012",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "This clearing, rest assured, is ours alone; these woods are vast enough. Yet I see everyone who passes through. No matter how clandestine they may think they are..." },
			},

			HecateBossAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
				},
				{ Cue = "/VO/HecateField_0007",
					Text = "A chill swept through the air as you approached. Unseasonably cold; though perhaps it is as Demeter desires. She aids you, does she not?" },
				{ Cue = "/VO/MelinoeField_0007", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "She does. She knew me for her granddaughter at once. Have you had opportunity to speak with her, about me and all that's transpired?" },
				{ Cue = "/VO/HecateField_0008",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No; I've been a bit preoccupied. At least here, Demeter shall be able to cool her wrath against me for keeping you a secret for so long..." },
			},
			HecateBossAboutDemeter02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutDemeter01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HecateBossAboutDemeter01" }, Count = 2 },
				},
				{ Cue = "/VO/HecateField_0009",
					Text = "I sense that Demeter is with you once again. I suspected she would either be among the first to lend support, or to refuse." },
				{ Cue = "/VO/MelinoeField_0008", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Could you not have told her about me, Headmistress? To have lost her daughter and grandchildren... I cannot imagine her sorrow." },
				{ Cue = "/VO/HecateField_0010",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Twas a painful choice to leave her in the dark. She would have gone to war immediately; but our task requires patience, as you know." },
			},

			HecateBossAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosRevealFollowUp", "ChronosMeeting03", "ChronosPostBattleMeeting01" },
					},
				},
				{ Cue = "/VO/MelinoeField_0004", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I'm concerned Chronos may find us. I first encountered him not far beyond these woods..." },
				{ Cue = "/VO/HecateField_0003",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There are so many passageways to Erebus, 'tis exceedingly unlikely he shall find the way. {#Emph}You {#Prev}face a greater risk than {#Emph}that {#Prev}right now..." },
			},
			HecateBossAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					--[[ @ update with real prereqs
					{
						Path = { "GameState", "ClearedRunsCache" },
						Comparison = "<",
						Value = 3,
					},
					]]--
				},
				{ Cue = "/VO/Hecate_0078",
					Text = "Our enemy's strength even exceeds my own. We're both Titans, yes, Chronos and I, but he is my elder... as I am yours. What say you?" },
				{ Cue = "/VO/Melinoe_0161", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "His age doesn't mean anything to me. The old are seldom wise, and often weak. And, he did not study under {#Emph}you{#Prev}, Headmistress. Only I have." },
				{ Cue = "/VO/Hecate_0079",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Hah! {#Prev}Just so. He is an arrogant old fool. The impression of wisdom comes with age more than the real thing. Remember that." },
			},
			HecateBossAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
					},
				},
				{ Cue = "/VO/Melinoe_2136", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'll get him, Headmistress. I swear it. All that you've taught, I'll bring to bear. And no matter the obstacles that stand in the way, Chronos shall fall by {#Emph}my {#Prev}hand." },
				{ Cue = "/VO/HecateField_0100",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I require no convincing, Melinoë, although perhaps you do. However much I've taught, what's important is you're a capable student." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2137", Text = "I have to be more than that." },
				},
			},

			HecateBossAboutChronosBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/MelinoeField_1513", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I've vanquished Chronos... everything you've trained me to do. Yet still you stand in my way. Still more to learn even now." },
				{ Cue = "/VO/HecateField_0126",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Now and always. That tinge of frustration you expressed? I would see you rid yourself of it, in your attempts to rid yourself of {#Emph}me." },
			},
			HecateBossAboutChronosBossW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateBossAboutChronosBossW01", "ChronosBossAboutHades01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				{ Cue = "/VO/HecateField_0127",
					Text = "Our enemy surely is beginning to wonder how you are able to thwart him. Do leave him in the dark. The less he knows of us, the better." },
				{ Cue = "/VO/MelinoeField_1514", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Chronos seems to think my family bond with him is why I'm able to resist. He hasn't made the connection that {#Emph}you're {#Prev}the one who's prepared me." },
				{ Cue = "/VO/HecateField_0128",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}You {#Prev}have prepared {#Emph}yourself. {#Prev}'Tis good that you are drawing his attention and his wrath, whilst I remain unseen. We slowly undermine his strength... and through our efforts, buy your mountain relatives more time." },
			},

			HecateBossAboutArcana01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 18,
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
					},
				},
				{ Cue = "/VO/Hecate_0193",
					Text = "Your aura is different. Stronger. You have been studying the Arcana. Meditating at your Altar to prepare for your attempts." },
				{ Cue = "/VO/Melinoe_0581", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Each Card reveals to me a different strength. If I steady myself and concentrate, then it's as though I become one with whomever they depict. If only I could focus on them all." },
				{ Cue = "/VO/Hecate_0194",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "To focus, by its nature, is to choose. Come, demonstrate to me this newfound understanding of yours..." },
			},
			HecateBossAboutArcana02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">",
						Value = 0,						
					},
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0442",
					Text = "The Altar in our training grounds is for your benefit, yet you would face me whilst ignoring the Arcana! An oversight, or bit of cheekiness?" },
				{ Cue = "/VO/MelinoeField_0003", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Merely a bit of deception with which to take you off your guard, Headmistress." },
				{ Cue = "/VO/Hecate_0443",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Hah! {#Prev}I think not. I'm fully on my guard, and suggest {#Emph}you {#Prev}be on yours." },
			},

			HecateBossLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Hecate_0080",
					Text = "Forgive my bluntness but you're in a rather sorry-looking state, Witch. 'Tis unfair for me to fight you whilst I am at my best and you are not." },
				{ Cue = "/VO/Melinoe_0157", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Life, however, is unfair, is it not, Headmistress? Here lies a lesson to be learned I think." },
				{ Cue = "/VO/Hecate_0081",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Just so. Pray you fare as capably in battle as in speech. Now commence!" },
			},
			HecateBossLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Hecate_0082",
					Text = "You've suffered injuries, Melinoë. You know that I can cure them for you, and you know that I shall not. Not here. It brings me no pleasure." },
				{ Cue = "/VO/Melinoe_0158", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "My injuries are teachings, Headmistress. I could have been more careful getting here. Now I face the consequence." },
				{ Cue = "/VO/Hecate_0083",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Correct! Stand tall and fight me, then. Use well your last remaining strength." },
			},
			HecateBossLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/Hecate_0084",
					Text = "Your wounds give me the upper hand, Melinoë. What hope have you of ever finding our enemy in such a state?" },
				{ Cue = "/VO/MelinoeField_0002", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I've not much hope for it at all, Headmistress. Although perhaps I'll get through {#Emph}you{#Prev}, at least." },
				{ Cue = "/VO/HecateField_0002",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Perhaps{#Prev}, as you say. We fight for every step, for every scrap that we can get. Get through {#Emph}me {#Prev}if you can!" },
			},

			HecateBossAboutDagger01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = { "WeaponTorch", "WeaponAxe", "WeaponLob" },
						Comparison = "<=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Hecate_0440",
					Text = "A flash of silver... Lim and Oros. So, the Sister Blades availed themselves to you. The other Nocturnal Arms shall follow their lead, I expect." },
				{ Cue = "/VO/Melinoe_1801", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nyx entrusted them to you to safeguard the realm as a last resort. But, this cannot possibly be how they were meant to be used..." },
				{ Cue = "/VO/Hecate_0441",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And whyever not? To safeguard the realm, you shall have to clear a wide variety of obstacles standing in your way. {#Emph}I {#Prev}am but one." },
			},
			HecateBossAboutTorch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				{ Cue = "/VO/HecateField_0167",
					Text = "I trust the dark of Erebus was not too much to handle with the ever-burning flames of Ygnium to light your path?" },
				{ Cue = "/VO/Melinoe_1034", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "No, Headmistress, it was not. Although, I've much to learn in how to wield these Flames." },
				{ Cue = "/VO/Hecate_0300",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then you have come to the right place. Show me how you make the shadows dance." },
			},
			HecateBossAboutTorch02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HecateBossAboutTorch01" }, Count = 3 },
				},
				{ Cue = "/VO/HecateField_0112",
					Text = "The Umbral Flames of Ygnium, at your command! You use them in your own way; not merely copy my technique." },
				{ Cue = "/VO/MelinoeField_0506", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You always said once I was ready to brandish the Flames, that I ought wield them with my intuition as my guide." },
				{ Cue = "/VO/HecateField_0113",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Just so. I always favored these old Flames of mine, but... as to whether {#Emph}you {#Prev}and {#Emph}yours {#Prev}truly connect, we'll have to see." },
			},
			HecateBossAboutAxe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				{ Cue = "/VO/HecateField_0108",
					Text = "Now that's a sight, you bearing down on me with that gigantic Moonstone Axe! I wasn't certain you'd prefer that one." },
				{ Cue = "/VO/MelinoeField_0504", UsePlayerSource = true,
					Text = "Zorephet is weightier than the other Arms. But having an axe such as this in woods such as these has been convenient, overall." },
				{ Cue = "/VO/HecateField_0109",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well, much as I hate to {#Emph}inconvenience {#Prev}you, I must. Although, that monstrous thing suggests this oughn't take too long..." },
			},
			HecateBossAboutLob01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				{ Cue = "/VO/HecateField_0110",
					Text = "Using the Argent Skull of Revaal, now, are we? You're becoming a most-capable necromancer, to have earned its trust." },
				{ Cue = "/VO/MelinoeField_0505", UsePlayerSource = true,
					Text = "Was this once a living creature's skull, Headmistress? Only to be infused with silver and enchanted as an instrument of Night..." },
				{ Cue = "/VO/HecateField_0111",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}That {#Prev}is rather a personal question, considering all evidence at hand! Perhaps Revaal herself shall reveal to you the answer in due course." },
			},

			HecateBossAboutCirceAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffClearCastAspect" },
					},
				},
				{ Cue = "/VO/HecateField_0104",
					Text = "Your staff takes on an unexpected form. Last I saw it thus was on a distant isle in the seas above. Where the enchantress Circe plied her trade." },
				{ Cue = "/VO/MelinoeField_0502", UsePlayerSource = true,
					Text = "This is the form Descura took with her. I feel a greater sense of calm and focus now, as though her own experience fused with mine." },
				{ Cue = "/VO/HecateField_0105",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Circe knew Descura's next bearer would need it for a task of some import. Thus she lent some of her strength to complement your own." },
			},
			HecateBossAboutMorosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchDetonateAspect" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutMorosAspect01" },
					},
				},
				{ Cue = "/VO/HecateField_0173",
					Text = "Now in whose guise is Ygnium this time? If you are comfortable answering. 'Tis not {#Emph}your {#Prev}Aspect of the Umbral Flames, that much is clear." },
				{ Cue = "/VO/MelinoeField_2129", UsePlayerSource = true,
					Text = "This Aspect is of Moros, Headmistress. But he has not yet used the Flames. Perhaps in knowing first... we become instrumental in bringing him into our fold." },
				{ Cue = "/VO/HecateField_0174",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Tis how the Fates do like to operate. As soon as we know what the future holds, we may try to resist... only to stumble into bringing it about." },
			},
			HecateBossAboutCharonAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
					}, 
				},
				{ Cue = "/VO/HecateField_0175",
					Text = "'Tis not the typical slim figure of the Moonstone Axe. {#Emph}Ah! {#Prev}The Aspect of Charon! He has since taken up the simple oar." },
				{ Cue = "/VO/MelinoeField_2130", UsePlayerSource = true,
					Text = "Lord Charon used to wield such a thing? I scarce imagine him heaving this around. Perhaps he rowed with it." },
				{ Cue = "/VO/HecateField_0176",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Perhaps he did, or hewed off a few heads. If Nyx and the Three Fates entrusted the protection of the Underworld to a certain few, they could have chosen worse." },
			},
			HecateBossAboutWeaponAspects01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllWeaponAspects,
					},
				},
				{ Cue = "/VO/HecateField_0106",
					Text = "What's that you're brandishing? {#Emph}Ahh{#Prev}, the Nocturnal Arms begin to show their myriad colors. The silver you well know is but one." },
				{ Cue = "/VO/MelinoeField_0503", UsePlayerSource = true,
					Text = "Each of the Aspects of the Arms of Night represents a bearer from another time. I'm still learning the full extent of what they can do." },
				{ Cue = "/VO/HecateField_0107",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And I suspect you shall continue doing so. If nothing else, this ought to make things further interesting here for the both of us." },
			},

			HecateBossAboutFamiliarSystem01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EquippedFamiliar" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" },
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "PickaxeSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "ShovelSuccesses" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsNone = { "PackageBountyChaosIntro" }
					},
				},
				{ Cue = "/VO/HecateField_0156",
					Text = "There's not much glory in confronting adversaries one to one. I myself invoke Shades of the dead to alter the odds. Some may well favor {#Emph}you{#Prev}, instead." },
				{ Cue = "/VO/MelinoeField_1998", UsePlayerSource = true,
					Text = "Perhaps if I brought with me a legion of animal Familiars next time, Headmistress? Not that any beast would bare its fangs at you." },
				{ Cue = "/VO/HecateField_0157",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You jest, yet a Familiar may be of considerable benefit given all that you have to do. A possibility to think upon, once you are rid of me..." },
			},

			HecateBossAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
				{ Cue = "/VO/HecateField_0162",
					Text = "You brought some company along! An unassuming choice; your amphibious friend does not appear to have capacity to sway the outcome here." },
				{ Cue = "/VO/MelinoeField_2026", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I never trust appearances entirely, Headmistress, and know neither do you. This must be an exciting night for Frinos." },
				{ Cue = "/VO/HecateField_0163",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We are not here to entertain your woodland friends, Melinoë. Pray they don't get underfoot." },
			},
			HecateBossAboutCatFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
				},
				{ Cue = "/VO/HecateField_0164",
					Text = "I scarce believe my eyes! I've seen that little cat about these woods. You have persuaded her to follow you..." },
				{ Cue = "/VO/MelinoeField_2027", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Toula did take some convincing, Headmistress. But she seems to appreciate my company! At least, most of the time." },
				{ Cue = "/VO/HecateField_0165",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Moody creatures, cats; born huntresses but uncontrollable. I almost fear to see just what this little one can do! With hounds, at least I know exactly where I stand." },
			},

			HecateBossAboutArachneOutfit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = {
							"AgilityCostume",
							"ManaCostume",
							"VitalityCostume",
							"HighArmorCostume",
							"CastDamageCostume",
							"IncomeCostume",
						},
					},
				},
				{ Cue = "/VO/HecateField_0166",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "You wear one of those silken dresses, always with a vivid hue. I know whose handiwork they are. This one quite suits you, though it is unlikely to withstand the heat..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2029", Text = "Just have to avoid it!" },
				},
			},

			-- alt below
			HecateBossAboutPackagedBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutBountyBoard01", "HecateAboutChaos01" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/HecateField_0116",
					Text = "You've a particular objective to achieve here, haven't you? Seen what must be done within the facets of the {#Emph}Pitch-Black Stone." },
				{ Cue = "/VO/MelinoeField_1928", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "A trial, on top of a trial. This is one of the infinite possibilities that Chaos anticipated. I chose this path, but... it was already there for me to find." },
				{ Cue = "/VO/HecateField_0117",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Tis very much disquieting to know the choices that we make might all be preordained to some extent. Nevertheless, Night's will is to be done." },
			},
			HecateBossAboutPackagedBounties01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutBountyBoard01", "HecateAboutChaos01" },
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/Hecate_0624",
					Text = "That Pitch-Black Stone in our training grounds... I've sensed it ever since your incantation. The subtle influence of Chaos on this realm." },
				{ Cue = "/VO/Melinoe_2796", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Our goals are intertwined. When I gaze upon the Stone, I begin to see different paths and possibilities in every facet. Some leading closer to our victory." },
				{ Cue = "/VO/HecateField_0117",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Tis very much disquieting to know the choices that we make might all be preordained to some extent. Nevertheless, Night's will is to be done." },
			},

			HecateBossAboutPackagedBounties02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateBossAboutPackagedBounties01", "HecateBossAboutPackagedBounties01_B" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyStarter" },
					},
				},
				{ Cue = "/VO/HecateField_0168",
					Text = "I sense the changes in the night; in {#Emph}you. {#Prev}Your strength has waned significantly. Chaos wishes to see the outcome of this particular arrangement, then?" },
				{ Cue = "/VO/MelinoeField_2030", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Another trial, Headmistress. My magick may be weakened, but you taught me never to depend on it entirely." },
				{ Cue = "/VO/HecateField_0169",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And whether you took such lessons to heart, we shall imminently see. As Selene be our witness above, so shall Chaos below." },
			},

			HecateBossAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
				},
				{ Cue = "/VO/HecateField_0120",
					Text = "You spoke the Oath of the Unseen, and would enact Night's Testament this eve. I sensed the growing Fear. How much of it is yours?" },
				{ Cue = "/VO/MelinoeField_1510", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "A healthy fear, no more, no less, Headmistress. I'm honored that you granted me the right to take the Oath. Assuming it was your doing, rather than Commander Schelemeus." },
				{ Cue = "/VO/HecateField_0121",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Best not to speculate too much. 'Twas your own doing most of all. Then, face me on this terror-stricken eve! You have made certain vows, and shall experience the consequence." },
			},
			HecateBossAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateBossAboutShrine01", "HecateBossAboutShrine03" },
					},
				},
				{ Cue = "/VO/HecateField_0122",
					Text = "Decided to forgo the Oath for now? A wise move, like as not. Or, evidence of some restraint and circumspection on your part, at least." },
				{ Cue = "/VO/MelinoeField_1511", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "My path is treacherous enough as it is; why make such Vows as would reduce my chances of success?" },
				{ Cue = "/VO/HecateField_0123",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Tis through adversity that we grow strong! But to your point, you face adversity enough. The Oath is there to guarantee you always shall." },
			},
			HecateBossAboutShrine03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
				},
				{ Cue = "/VO/HecateField_0124",
					Text = "The Fear in the air... 'tis almost palpable tonight. You have made many Vows this eve. Feeling so very bold, or merely curious to see what shall transpire?" },
				{ Cue = "/VO/MelinoeField_1512", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "A little of each, Headmistress? Perhaps I made a terrible mistake. It's fortunate the Vows contained within the Oath can be undone... unlike most vows." },
				{ Cue = "/VO/HecateField_0125",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}All {#Prev}vows can be undone. But yes, the Oath is oddly forgiving in this way; its Vows, never strictly binding. Perhaps so that each evening may be interestingly different from the last." },
			},

			HecateBossAboutErebus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Melinoe_1035", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "What can we do for the wretched souls wandering lost in Erebus, Headmistress? An afterlife of lashing out in impotent rage..." },
				{ Cue = "/VO/Hecate_0301",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We can achieve our task. The souls of Erebus ought have been placed somewhere within your father's realm, but all that ceased once Chronos took the throne. Go, wrest it back from him." },
			},
			HecateBossAboutErebus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Melinoe_1599", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "This grove is already regrown since last we clashed. For all the death in Erebus, life flourishes as well." },
				{ Cue = "/VO/Hecate_0432",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Death and life; the two are intricately intertwined. These woods shall easily survive our clashes here. What about {#Emph}you?" },
			},

			HecateBossAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutHermes01" },
					},					
				},
				{ Cue = "/VO/Melinoe_1172", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I heard from Hermes, Headmistress. He gave me the impression that Olympus needs my aid. What of my task?" },
				{ Cue = "/VO/Hecate_0429",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your task remains, as does the adversary whom you face. We shall discuss the matter with Hermes elsewhere. We have other matters first." },
			},
			HecateBossAboutHermes02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutHermes01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutHermes01" },
					},
				},
				{ Cue = "/VO/Hecate_0430",
					Text = "Hermes urged me to address a certain matter with you here. However, my view is you are unprepared for the surface, as of yet." },
				{ Cue = "/VO/Melinoe_1175", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Meaning you won't lift the wards barring the path to the surface. What if I remove them myself? I've seen how you do it." },
				{ Cue = "/VO/Hecate_0431",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then you'll be more prepared than you are now. Till then, remember your objective lies below. Past {#Emph}me." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeAltRunDoor" },
			},
			HecateBossAboutHermes03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_0009", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps some evening I shall reach this point so quickly that I'll slip by before you arrive, Headmistress." },
				{ Cue = "/VO/HecateField_0011",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I've no intent to permit any such possibility, not even if you've the swiftness of Hermes speeding you on. Though, why don't we get to it, then." },
			},

			HecateBossAboutLearning01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomCountCache" },
						HasNone = { "G_Intro", "N_Hub" },
					},
					--[[
					{
						Path = { "PrevRun", "RoomCountCache", "G_Intro" },
						Comparison = "<=",
						Value = 5,
					},
					]]--
				},
				{ Cue = "/VO/Hecate_0302",
					Text = "You cannot beat me with anxiety, you know. Still your senses, and prepare yourself. Know you the purpose of these bouts of ours?" },
				{ Cue = "/VO/Melinoe_1036", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "To complete my training. Each clash between us is an opportunity to learn and grow strong." },
				{ Cue = "/VO/Hecate_0303",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're partially correct. For our training shall never be complete. Yet, onward we must strive." },
			},

			HecateBossAboutHecateKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ManaOverTimeRefundKeepsake" },
					},
				},
				{ Cue = "/VO/Hecate_0304",
					Text = "You bear the Wheel trinket I bestowed. I once used it to hone my craft. May it now help you do the same." },
				{ Cue = "/VO/Melinoe_1037", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "This wheel, a labyrinth with no beginning and no end... pathways that circle back upon themselves. Like Erebus..." },
				{ Cue = "/VO/Hecate_0305",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Like life itself! Three stages, intertwined. Let us go through the stages now." },
			},
			HecateBossAboutHecateKeepsake02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutHecateKeepsake01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ManaOverTimeRefundKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0158",
					Text = "Again you bear the Wheel I gave to you; rather, that I {#Emph}held {#Prev}for you ere you were ready, for it was always yours. A means of focusing your magickal acuity, if nothing else." },
				{ Cue = "/VO/MelinoeField_1997", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It's much more. A never-ending labyrinth with three distinct sides... a reminder of our home, and the limits of our power." },
				{ Cue = "/VO/HecateField_0159",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The Crossroads may serve as something of a home to you, but most certainly it is {#Emph}not your home. {#Prev}It is that labyrinth in which you are trapped. {#Emph}Break free!" },
			},

			HecateBossAboutNemesisKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DeathVengeanceKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0013",
					Text = "What is that foul artifact you bear? {#Emph}Ah! {#Prev}An Eye of Nemesis. Warding against those harboring ill will. The sheer irony of it, coming from her." },
				{ Cue = "/VO/MelinoeField_0011", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I mean nothing untoward, Headmistress. The Eye is indiscriminate in its effect, and makes me match more strongly with my strongest foes." },
				{ Cue = "/VO/HecateField_0170",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "'Tis a wonder this Eye does not cause the two of us to combust on the spot! Then take your vengeance, if you can!" },
			},
			HecateBossAboutOdysseusKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0015",
					Text = "Blood and darkness, I can sense you've those accursed Knuckle Bones on you. I shall have to thank Odysseus for providing such a gift..." },
				{ Cue = "/VO/MelinoeField_0012", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "My Keepsake? I'm surprised these have any effect on you, Headmistress. I thought for certain you enchanted them yourself." },
				{ Cue = "/VO/HecateField_0016",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Odysseus has known his share of witches besides us. Well, I'm braced for impact; the Knuckle Bones strike first, and then, we fight." },
			},
			HecateBossAboutMorosKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BlockDeathKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0017",
					Text = "Do I detect an artifact from Moros? Something to bring Doom swiftly to your foes by forestalling your own. Seems rather handy, that." },
				{ Cue = "/VO/MelinoeField_0013", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'm certain Lord Moros means you no offense. But his Keepsake is of benefit to me, and I'm to take every advantage that I can." },
				{ Cue = "/VO/HecateField_0025",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Correct. 'Tis no wonder Doom has come to stay with us for now. His presence lingers over every action that we take..." },
			},
			HecateBossAboutMedeaKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DamagedDamageBoostKeepsake" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
					},
				},
				{ Cue = "/VO/HecateField_0102",
					Text = "The air hangs heavily about you here tonight. {#Emph}Ah! {#Prev}'Tis from the scrap of something that Medea gave to you. A gift more than a curse, I trust?" },
				{ Cue = "/VO/MelinoeField_0501", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Her Keepsake, yes. A bit of fleece... sheep roam about Ephyra, but none with coats as black and brilliant as this. It's something special, I can tell." },
				{ Cue = "/VO/HecateField_0103",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Indeed it is, as fleeces go, at least. Medea is not quick to accept others into her circle; bit of a black sheep herself. But, aren't we all?" },
			},
			HecateBossAboutErisKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "EscalatingKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0171",
					Text = "{#Emph}Eugh...! {#Prev}Whatever foul Keepsake you decided to bring along for good fortune this eve, 'tis a horrid thing. Which sort of comrade would reward you thus?" },
				{ Cue = "/VO/MelinoeField_2028", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It... was a gift from Eris, Headmistress. I know the effect isn't strictly to my benefit, or anyone's... but I just thought..." },
				{ Cue = "/VO/HecateField_0172",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "...That Eris was doing you a favor? Or has {#Emph}any {#Prev}sense of purpose other than to sow disorder where she can? You two make a strange match, Melinoë. So shall {#Emph}this {#Prev}be." },
			},

			HecateBossAboutOlympians01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LootTypeHistory" },
						HasAny = { "ZeusUpgrade", "HeraUpgrade", "PoseidonUpgrade", "ApolloUpgrade", "DemeterUpgrade", "AphroditeUpgrade", "HephaestusUpgrade", "HestiaUpgrade", "HermesUpgrade" },
					},
				},
				{ Cue = "/VO/Hecate_0306",
					Text = "Olympus has emboldened you, and made you strong. Yet, 'tis a fleeting strength; one false step, and I could wipe it all away." },
				{ Cue = "/VO/Melinoe_1038", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I'll take a fleeting strength over no strength at all. We take every advantage that avails itself." },
				{ Cue = "/VO/Hecate_0307",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Just so. Then come and show me how you would make use of such {#Emph}advantages." },
			},

			HecateBossAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Boss01", },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Hecate_0195",
					Text = "{#Emph}Hmm. {#Prev}I was beginning to think you had grown so fond of the surface that you would not be coming back here anytime soon." },
				{ Cue = "/VO/Melinoe_0654", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Our task takes me to the very ends of the earth. I have unfinished business there as well as here. I'm much more comfortable in these environs, though." },
				{ Cue = "/VO/Hecate_0196",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Comfortable? {#Prev}You should be fully on your guard, and braced for battle! Let's see how {#Emph}comfortable {#Prev}this is for both of us." },
			},

			HecateBossAboutFlattery01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Opening01" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Opening01", },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Hecate_0308",
					Text = "Decided to take a break from all your recent outings to the surface, have you now?" },
				{ Cue = "/VO/Melinoe_1176", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "There's much to be done, both above and below. You always say the greatest teacher is {#Emph}out there{#Prev}. But I always seem to find her here." },
				{ Cue = "/VO/Hecate_0309",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I taught you nothing of such flattery. One of Odysseus' tricks, perhaps! Let's see what others you have learned." },
			},

			HecateBossAboutFailure01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 9,
					},
					--[[
					{
						Path = { "GameState", "ClearedRunsCache", },
						Comparison = "<",
						Value = 1,
					},
					]]--
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/Melinoe_2138", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "You must wear that veil so as not to betray your disappointment, Headmistress. All these failures yet you still do not admonish me?" },
				{ Cue = "/VO/HecateField_0101",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh silence, Melinoë. For your setbacks I've boundless patience, but for your petulance, I've none. You ought find a better catalyst for such inner turmoils, as I lack sympathy for them!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2139", Text = "That's fine...!" },
				},
			},

			HecateBossAboutSolitude01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/MelinoeField_0005", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I didn't mean to keep you waiting long, Headmistress. Or do you always arrive at just the right instant?" },
				{ Cue = "/VO/HecateField_0004",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "A bit of solitude here hardly is a waste of time; I never merely wait. I've more matters to attend to in these woods, besides. But {#Emph}first..." },
			},			

			HecateBossAboutSilence01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 4,
					},
				},
				{ Cue = "/VO/HecateField_0005",
					Text = "'Tis a particularly quiet night. Observe the silence for a moment, ere we begin our little test of just how capable you have become." },
				{ Cue = "/VO/MelinoeField_0006", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "It does seem unusually still, and the Moon wanes. An ill portent, Headmistress? Our Shades should check up on your hounds..." },
				{ Cue = "/VO/HecateField_0006",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No need, the hounds fend mostly for themselves. Like as not, they use this time to rest; as you'd be wise to do, now and again." },
			},

			HecateBossRepeatedWins01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Hecate" },
					},
				},
				{ Cue = "/VO/Hecate_0310",
					Text = "Strength; knowledge; patience. You have exhibited the three repeatedly. Well done." },
				{ Cue = "/VO/Melinoe_1040", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Thank you, Headmistress. Though I continue learning from our every clash." },
				{ Cue = "/VO/Hecate_0311",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Good, because I've no intent to stand aside. Our craft is called a {#Emph}practice {#Prev}for a reason. Now, on your guard." },
			},
			HecateBossRepeatedWins02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "EnemyKills", "Hecate" },
					}
				},
				{ Cue = "/VO/Hecate_0433",
					Text = "You surpassed me before, yet I wonder: Was it your mastery over our craft, or did the Fates themselves perhaps provide a little {#Emph}nudge?" },
				{ Cue = "/VO/Melinoe_1600", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "Come, Headmistress. If I could be provoked {#Emph}that {#Prev}easily, I'd stand no chance at all. Not even if the Fates desired otherwise." },
				{ Cue = "/VO/Hecate_0434",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Good fortune seldom comes to those in no position to receive it. Show me your victory was no mere accident." },
			},
			HecateBossCloseMatch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0.15,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0435",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You almost had me last we clashed, although a narrow loss is nonetheless a loss. I expect you to follow through to victory this time." },
			},
			HecateBossMissedFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_PreHub01" },
					},
				},
				{ Cue = "/VO/Hecate_0439",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I had expected your arrival here the prior eve, but 'twas not for me to cut short that attempt. However, I shan't hesitate to cut short {#Emph}this {#Prev}one." },
			},

			HecateBossStrictlyBusiness01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Hecate_0312",
					Text = "So much ado of late, both on Olympus and below. Yet I would have you cast all your worldly troubles aside whilst here." },
				{ Cue = "/VO/Melinoe_1041", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "My circumstances are what spur me on. Casting them aside shall be difficult, Headmistress..." },
				{ Cue = "/VO/Hecate_0313",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I've no concern for {#Emph}difficult{#Prev}. We've time enough to gaze upon our navels at the Crossroads. Here, we are adversaries. Nothing more." },
			},

			HecateBossAboutTesting01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Hecate_0070" },
					},
				},
				{ Cue = "/VO/Hecate_0072",
					Text = "There you are. I cannot stay for long. Just long enough to put you to the test." },
				{ Cue = "/VO/Melinoe_0039", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "I got here as quickly as I could, Headmistress. And still you had to wait." },
				{ Cue = "/VO/Hecate_0073",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "To wait is the practice of patience. Now, on to other practices, I think." },
			},
			HecateBossAboutRespect01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0074",
					Text = "Set your respect for me aside whilst here. You must give no such quarter to our enemies." },
				{ Cue = "/VO/Melinoe_0040", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
					Text = "But you are not my enemy, Headmistress. How am I to treat you as one?" },
				{ Cue = "/VO/Hecate_0075",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}How? {#Prev}Allow me to give you a demonstration, then." },
			},
			HecateBossAboutSolitude02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "~=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutSolitude01" },
					},
				},
				{ Cue = "/VO/Hecate_0444",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We are alone; nary the baying of a single hound is to be heard. Selene high above shall have to be sufficient for an audience." },
			},

			HecateBossAboutExpectations01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/Hecate_0447",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Much is expected of you. So you must learn to bear that burden with grace." },
			},
			HecateBossAboutTask01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/Hecate_0048",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
				Text = "I know your task is difficult, and also know you have it in you to succeed." },
			},
			HecateBossAboutTask02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/Hecate_0450",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
				Text = "Your task may be an honor, but the wisest whom you know shall not envy you for it." },
			},
			HecateBossAboutWitchcraft01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/HecateField_0096",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
				Text = "Our craft leaves little room for doubt, yet some always remains; and even a little can be far too much." },
			},
			HecateBossAboutConfidence01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				{ Cue = "/VO/HecateField_0098",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
				Text = "If you lack confidence, then how are you to manifest your will? Be certain of your heart's desire." },
			},
			HecateBossAboutAnger01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},

				{ Cue = "/VO/HecateField_0099",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
				Text = "You're angry; let it out. Anger's not to be suppressed, nor misdirected. To be {#Emph}angry{#Prev}... is to be {#Emph}alive." },
			},

			-- Repeatable / other general cases
			HecateBossMiscStart01 =
			{
				{ Cue = "/VO/Hecate_0086",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Come show to me what you have lately learned." },
			},
			HecateBossMiscStart02 =
			{
				{ Cue = "/VO/Hecate_0087",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Let us begin the lesson, then, Melinoë." },
			},
			HecateBossMiscStart03 =
			{
				{ Cue = "/VO/Hecate_0088",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "The Moon shall be our witness here tonight. Prepare!" },
			},
			HecateBossMiscStart04 =
			{
				{ Cue = "/VO/Hecate_0089",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Are all your sorceries prepared? Then let us clash." },
			},
			HecateBossMiscStart05 =
			{
				{ Cue = "/VO/Hecate_0090",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Strike at me so that the heavens themselves shudder!" },
			},
			HecateBossMiscStart06 =
			{
				{ Cue = "/VO/Hecate_0091",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Steady your breathing, and steel your nerves, Melinoë." },
			},
			HecateBossMiscStart07 =
			{
				{ Cue = "/VO/Hecate_0092",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Hold nothing back against me here, Melinoë." },
			},
			HecateBossMiscStart08 =
			{
				{ Cue = "/VO/Hecate_0093",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Each time you face me you step closer to your true potential, Witch." },
			},
			HecateBossMiscStart09 =
			{
				{ Cue = "/VO/Hecate_0094",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Now let us match our powers, one Witch to another." },
			},
			HecateBossMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0166",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Shall we discern if you can vanquish me again, Witch?" },
			},
			HecateBossMiscStart11 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0167",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "You may surpass me, but how much strength shall doing so cost you?" },
			},
			HecateBossMiscStart12 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0168",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Come forth, and I expect a better outcome than when last we clashed." },
			},
			HecateBossMiscStart13 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0169",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Are you prepared for another hard lesson, or are you going to get past me?" },
			},
			HecateBossMiscStart14 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Hecate_0170",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "You got here quickly, though with haste comes more capacity to make mistakes." },
			},
			HecateBossMiscStart15 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Hecate_0171",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "No getting out of Erebus except through me." },
			},
			HecateBossMiscStart16 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Hecate_0172",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "It seems to me that you are well prepared, so let's begin." },
			},
			HecateBossMiscStart17 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Hecate_0173",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "You are not merely being tested here; you are never to cease learning." },
			},
			HecateBossMiscStart17 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Hecate_0453",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Let us see if you shall keep your streak of victories intact." },
			},
			HecateBossMiscStart18 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 10,
					},
				},
				{ Cue = "/VO/Hecate_0454",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Do me the dignity of never letting down your guard." },
			},
			HecateBossMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 10,
					},
				},
				{ Cue = "/VO/Hecate_0455",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "You have learned much since first we fought, though there is always more." },
			},
			HecateBossMiscStart20 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Hecate_0456",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "The pleasantries can wait until we reunite at the Crossroads anon." },
			},

			HecateBossMiscStart21 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/HecateField_0021",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "I've a sense this shan't take very long at all." },
			},
			HecateBossMiscStart22 =
			{
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/HecateField_0022",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "What say we give Sister Selene a good show up there." },
			},
			HecateBossMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/HecateField_0023",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "The Moon is full and clear this eve. Brings a certain drama to our confrontation, does it not?" },
			},
			HecateBossMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				{ Cue = "/VO/HecateField_0024",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "'Tis a new moon, and an opportunity for a new beginning. But first...!" },
			},

		},

		-- following are for when she exits the encounter
		BossOutroTextLineSets =
		{
			HecateBossOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0012",
					Text = "You fought with diligence and with ferocity. But surely there is more for you to learn beyond this threshold." },
				{ Cue = "/VO/Melinoe_0041", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I look forward to it, Headmistress. What about you? Can you not join me?" },
				{ Cue = "/VO/Hecate_0445",
					Text = "No; I dare not stray too far from our abode. Continue now your task. I shall await your safe return." },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0176", Text = "Thank you, Headmistress..." },
				},
			},
			HecateBossOutroNoArcana01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "QuestsViewed" },
						HasAny = { "QuestBeatHecateWithoutArcana" },
					},
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/HecateField_0161",
					Text = "The Arcana gave to you no benefit at all this eve and still you bested me. I know not whether to heap praise, or reprimand you for being such a little show-off! {#Emph}Hah!" },
				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2031", Text = "I've gotten stronger..." },
				},
			},

			-- granted incantations
			HecateBossGrantsCodex01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Hecate_0143",
					PostLineThreadedFunctionName = "EnableCodex",
					Text = "You have survived against me, and for {#Emph}that{#Prev}, you're owed a gift. May you learn well through it, Melinoë." },
				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0177", Text = "The Book of Shadows..." },
				},
			},
			HecateBossGrantsFamiliarSystem01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutFamiliarSystem01" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsNone = { "PackageBountyChaosIntro" }
					},
					-- backward compatibility
					{
						PathFalse = { "GameState", "EquippedFamiliar" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" },
					},
				},
				{ Cue = "/VO/HecateField_0160",
					Text = "Do bring an animal Familiar along next time, if but to keep things livelier for me! We have the means to keep them safe, even in scuffles such as these." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeFamiliarSystem" },

				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_1999", Text = "{#Emph}Faith of Familiar Spirits{#Prev}... this should work on Frinos, or perhaps..." },
				},
			},
			HecateBossGrantsCardUpgradeSystem01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 18,
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 10,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsNone = { "PackageBountyChaosIntro" }
					},
					-- backward compatibility
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
					},
					--[[
					{
						PathFalse = { "CurrentRun", "WorldUpgradesRevealed", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesRevealed", "WorldUpgradeMixerShadow" },
					},
					]]--
				},
				{ Cue = "/VO/HecateField_0178",
					Text = "You have grown physically quite strong... but spiritually, more is to be done. The Altar of Ashes; there is an incantation that may make your nightly meditations at it better spent." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeCardUpgradeSystem" },

				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3449", Text = "{#Emph}The Consecration of Ashes..." },
				},
			},
			HecateBossGrantsWeaponUpgradeSystem01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponDagger", "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
					{
						Path = { "PrevRun", "WeaponsUnlocked" },
						HasNone = { "WeaponDagger", "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsNone = { "PackageBountyChaosIntro" }
					},
					-- backward compatibility
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
				},
				{ Cue = "/VO/HecateField_0177",
					Text = "To bear each of the Nocturnal Arms is a terrible responsibility. You've only begun to realize their nature; a certain incantation shall deepen your understanding." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeWeaponUpgradeSystem" },

				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3448", Text = "{#Emph}The Aspects of Night and Darkness..." },
				},
			},

			-- brief one-offs
			HecateBossMiscOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0140",
					Text = "Well fought again, Melinoë. Proceed, and moonlight guide you." },
			},
			HecateBossMiscOutro02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMinHealthFraction = 0.5,
				},
				{ Cue = "/VO/Hecate_0141",
					Text = "May all your enemies beyond succumb to you as readily." },
			},
			HecateBossMiscOutro03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.4,
				},
				{ Cue = "/VO/Hecate_0142",
					Text = "Well fought. But I cannot mend your wounds, and neither shall your enemies." },
			},
			HecateBossMiscOutro04 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0314",
					Text = "You'll continue to grow, whilst I continue thusly testing you." },
			},
			HecateBossMiscOutro05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMinHealthFraction = 0.7,
				},
				{ Cue = "/VO/Hecate_0315",
					Text = "Impressive show of force. Hold nothing back as you continue on." },
			},
			HecateBossMiscOutro06 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0316",
					Text = "You passed this test again, though how much farther you can go, we'll see." },
			},
			HecateBossMiscOutro07 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0317",
					Text = "You've earned these spoils; may they strengthen your craft." },
			},
			HecateBossMiscOutro08 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0318",
					Text = "I shall see you at the Crossroads anon. I shall be catching there my breath..." },
			},
			HecateBossMiscOutro09 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0319",
					Text = "{#Emph}Whew! {#Prev}No further need to keep each other here, I suppose..." },
			},
			HecateBossMiscOutro10 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Hecate_0320",
					Text = "Go on, Melinoë. The greatest teacher is out {#Emph}there." },
			},
			HecateBossMiscOutro11 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.33,
				},
				{ Cue = "/VO/HecateField_0086",
					Text = "Just when I thought I had you, you seized control of the fight! Well fought!" },
			},
			HecateBossMiscOutro12 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.5,
				},
				{ Cue = "/VO/HecateField_0087",
					Text = "You used your last remaining moments very well. May you fare well below." },
			},
			HecateBossMiscOutro13 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{ Cue = "/VO/HecateField_0088",
					Text = "You wield Descura capably, and I can tell the bond you share is strong. Now farewell." },
			},
			HecateBossMiscOutro14 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 10,
					},
				},
				{ Cue = "/VO/HecateField_0089",
					Text = "Your growing skill with Lim and Oros makes you something to be feared. Good." },
			},
			HecateBossMiscOutro15 =
			{
				PlayOnce = true,
				{ Cue = "/VO/HecateField_0090",
					Text = "I shall return to shadows hence. Trust that your eve is only beginning." },
			},
			HecateBossMiscOutro16 =
			{
				PlayOnce = true,
				{ Cue = "/VO/HecateField_0091",
					Text = "We shall have to do this again some other eve." },
			},
			HecateBossMiscOutro17 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 15,
					},
				},
				{ Cue = "/VO/HecateField_0092",
					Text = "You have grown strong, although we've an eternity to hone our craft." },
			},
			HecateBossMiscOutro18 =
			{
				PlayOnce = true,
				{ Cue = "/VO/HecateField_0093",
					Text = "May you show even greater wrath against the enemies awaiting you below." },
			},
			HecateBossMiscOutro19 =
			{
				PlayOnce = true,
				{ Cue = "/VO/HecateField_0094",
					Text = "Well fought, and may the Fates be generous to you in your descent." },
			},
			HecateBossMiscOutro20 =
			{
				PlayOnce = true,
				{ Cue = "/VO/HecateField_0095",
					Text = "I have impeded you for long enough this night. Go, make the most of this attempt." },
			},
		},
	},

	HecateCopy =
	{
		InheritFrom = { "BaseVulnerableEnemy"},
		GenusName = "Hecate",
		MaxHealth = 999999,
		ProjectileBlockPresentationFunctionName = "HecateCloneHitPresentation",
		--IgnoreDamage = true,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		BlockRespawnShrineUpgrade = true,

		UseActivatePresentation = false,
		SpawnFx = "HecateCloneDeathFx",
		DeathAnimation = "HecateCloneDeathFx",
		SpawnAnimation = "HecateTeleportIn",
		CreateAnimations =
		{
			"HecateGroundGlow",
			"HecateTorchFlameLeft",
			"HecateTorchFlameRight",
		},
		DestroyDelay = 0.0,

		WakeUpDelay = 0.3,

		AIOptions = { "AttackAndDie" },

		DefaultAIData =
		{
			DeepInheritance = true,
			--TeleportToSpawnPointType = "EnemyPointRanged",
			MoveWithinRange = false,
		},

		WeaponOptions =
		{
			"HecateRangedTorchesSpirals", "HecateRangedTorchesLine", "HecateRangedTorchesFork", "HecateRangedTorchesRing",
		},

		StunAnimations =
		{

		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.Hecate )