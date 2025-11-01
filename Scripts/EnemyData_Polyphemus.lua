UnitSetData.Polyphemus =
{
	Polyphemus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Cyclops_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.PolyphemusVoice,
		AnimOffsetZ = -130,
		MaxHealth = 8400,
		AISetupDelay = 1.5,
		EmoteOffsetY = -350,
		EmoteOffsetX = 120,

		SpeakerName = "Polyphemus",
		SpeakingStatusAnimation = "StatusIconSpeaking_Hero",
		LoadPackages = { "Polyphemus", },
		TextLinesUseWeaponIdle = true,
		SpawnAnimation = "Enemy_Polyphemus_Intro_Idle_Chained",

		InvulnerableFx = "Invincibubble_Scylla",
		SpeechCooldownTime = 11,

		DeathAnimation = "Enemy_Polyphemus_Death_Start",
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "CyclopsDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, AddInterBiomeTimerBlock = true,
			DeathFlashOffsetY = -200,
			--ShiftDistance = 300,
			--ShiftTowardId = 50063,
		},
		AngleTowardClosestTypeOnDeath = "HeroEnd",
		DeathPanOffsetY = -140,

		KillEnemyEvents =
		{
			{
				FunctionName = "WipeSpawnsOnKill",
			},
		},
		
		BossDifficultyShrineRequiredCount = 1,
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					OverwriteSourceKeys =
					{
						AISetupDelay = 0.5,
						ComboPartnerName = "Medea",
						PreBossAISetupFunctionName = "SetupComboPartners",
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					}
				}
			},

			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					MaxHealth = 10200,
				},
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredShrineLevel",
						FunctionArgs =
						{
							ShrineUpgradeName = "BossDifficultyShrineUpgrade",
							Comparison = ">=",
							Value = 1,
						},
					},
				},
			},
		},

		SpawnUnitOnDeath = "PolyphemusCorpse",
		SpawnUnitOnDeathMatchAngle = true,
		SpawnUnitOnDeathSetGeometryToMarkers =
		{
			"Polyphemus_Rig:ring_02_L_JNT_end",
			"Polyphemus_Rig:ring_02_R_JNT_end",
			"Polyphemus_Rig:pinky_02_L_JNT_end",
			"Polyphemus_Rig:pinky_02_R_JNT_end",
			"Polyphemus_Rig:middle_02_L_JNT",
			"Polyphemus_Rig:middle_02_R_JNT",
			"Polyphemus_Rig:kneeTwist_00_L_JNT",
			"Polyphemus_Rig:kneeTwist_00_R_JNT",
			"Polyphemus_Rig:ankle_00_L_JNT",
			"Polyphemus_Rig:ankle_00_R_JNT",
			"Polyphemus_Rig:toe_00_L_JNT",
			"Polyphemus_Rig:toe_00_R_JNT",
			"Polyphemus_Rig:toe_01_L_JNT_end",
			"Polyphemus_Rig:toe_01_R_JNT_end",
			"Polyphemus_Rig:prop_02_M_JNT",
			"Polyphemus_Rig:frontHair_01_JNT",
			"Polyphemus_Rig:capeSheepEyeLid_00_L_JNT",
			"Polyphemus_Rig:upperArmTwist_01_L_JNT",
			"Polyphemus_Rig:upperArmTwist_01_R_JNT",
			"Polyphemus_Rig:lowerArmTwist_01_L_JNT",
			"Polyphemus_Rig:lowerArmTwist_01_R_JNT",
			"Polyphemus_Rig:lowerArmTwist_01_R_JNT",
			"Polyphemus_Rig:lowerArmFix_01_R_JNT",
			"Polyphemus_Rig:lowerArmFix_01_L_JNT",
			"Polyphemus_Rig:lowerLegFix_00_L_JNT",
			"Polyphemus_Rig:handFix_00_L_JNT",
			"Polyphemus_Rig:handFix_00_R_JNT",
		},
		DestroyDelay = 0.0,

		OnDamagedFunctionNames = { "CheckWeaponInterrupt" },

		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarTextId = "Cyclops_Full",
		HealthBarOffsetY = -275,
		AltHealthBarTextIds =
		{
			{ TextId = "Cyclops_AltFight01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},
		IgnoreInvincibubbleOnHit = true,

		DefaultAIData =
		{
			InterruptWeapon = "PolyphemusBoulderThrow",
		},
		WeaponOptions = { "PolyphemusSlam", "PolyphemusKick", "PolyphemusLeap", "PolyphemusPlayerGrab", "PolyphemusGrab", },

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
				EMStageDataOverrides =
				{
					DataOverrides =
					{
						ForcedNextWeapon = "PolyphemusStomp",
					},
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PolyphemusLeap",
						"PolyphemusMeleeCombo",
						"PolyphemusStompKickCombo",
						"PolyphemusPlayerGrab_EM",
						"PolyphemusPlayerGrab_EM",
						"PolyphemusGrab",
					},
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PolyphemusMegaLeap",
				ExpireProjectiles = { "PolyphemusMarchRadial" },
				WaitDuration = 0,
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PolyphemusLeap",
						"PolyphemusMarch",
						"PolyphemusMeleeCombo",
						"PolyphemusStompKickCombo",
						"PolyphemusPlayerGrab_EM",
						"PolyphemusPlayerGrab_EM",
						"PolyphemusGrab",
					},
				},
				UnequipAllWeapons = true,
				EquipRandomWeapon = { "PolyphemusSearch", "PolyphemusSearch_Sick", "PolyphemusSearch_Zombie", "PolyphemusSearch_Explosive", },
				EquipWeapons= { "PolyphemusLeap", "PolyphemusMarch", "PolyphemusPlayerGrab", "PolyphemusPlayerGrab", "PolyphemusGrab" },
			},

			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "PolyphemusMegaLeapElite",
				ExpireProjectiles = { "PolyphemusMarchRadial" },
				WaitDuration = 0,
				--EquipWeapons = {  },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"PolyphemusLeap",
						"PolyphemusLeap",
						"PolyphemusMeleeCombo",
						"PolyphemusStompKickCombo",
						--"PolyphemusMarch",
						"PolyphemusPlayerGrab_EM",
						"PolyphemusPlayerGrab_EM",
					},
				},
				MusicSection = 3,
				UnequipAllWeapons = true,
				EquipRandomWeapon = { "PolyphemusSearch", "PolyphemusSearch_Sick", "PolyphemusSearch_Zombie", "PolyphemusSearch_Explosive", },
				EquipWeapons= { "PolyphemusStomp", "PolyphemusStomp", "PolyphemusLeap", "PolyphemusLeap", "PolyphemusKick", "PolyphemusSlam", "PolyphemusMarch" },

				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlay = 0.5,
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
					{ Cue = "/VO/Polyphemus_0369", Text = "Getting a little tired of you, meat!" },
					{ Cue = "/VO/Polyphemus_0370", Text = "You no good stinking {#Emph}urgh!" },
					{ Cue = "/VO/Polyphemus_0371", Text = "Done being nice to you." },
					{ Cue = "/VO/Polyphemus_0372", Text = "You're making me upset!" },
					{ Cue = "/VO/Polyphemus_0373", Text = "How 'bout we wrap this up?" },
					{ Cue = "/VO/Polyphemus_0374", Text = "Had just about enough of you..." },
					{ Cue = "/VO/Polyphemus_0375", Text = "You gotta stay for seconds..." },
					{ Cue = "/VO/Polyphemus_0376", Text = "Right {#Emph}that's {#Prev}it." },
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
			{ Cue = "/VO/Polyphemus_0057", Text = "{#Emph}Aw{#Prev}, what's the matter?" },
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
				ObjectType = "Medea",
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.75,
				GameStateRequirements =
				{
					--
				},
				Cooldowns =
				{
					{ Name = "CyclopsLastStandReactionSpeech", Time = 30 },
				},
				TriggerCooldowns = { "CyclopsSpokeRecently", "MedeaSpokeRecently" },

				{ Cue = "/VO/Medea_0409", Text = "You're dying, sorceress...!", PlayFirst = true },
				{ Cue = "/VO/Medea_0410", Text = "The Death Defiance..." },
				{ Cue = "/VO/Medea_0411", Text = "Your life drains..." },
				{ Cue = "/VO/Medea_0412", Text = "How you struggle..." },
				{ Cue = "/VO/Medea_0413", Text = "Grim resolve..." },
				{ Cue = "/VO/Medea_0414", Text = "Impressive..." },
				{ Cue = "/VO/Medea_0415", Text = "Oh, my..." },
				{ Cue = "/VO/Medea_0416", Text = "Immortality..." },
				{ Cue = "/VO/Medea_0417", Text = "You endure..." },
				{ Cue = "/VO/Medea_0418", Text = "That's it...!" },
			},
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
					{ Name = "CyclopsLastStandReactionSpeech", Time = 30 },
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
				TriggerCooldowns = { "CyclopsSpokeRecently" },

				{ Cue = "/VO/Polyphemus_0208", Text = "{#Emph}Mrm! {#Prev}Juicy!" },
				{ Cue = "/VO/Polyphemus_0209", Text = "{#Emph}Mmm{#Prev}, that's good." },
				{ Cue = "/VO/Polyphemus_0210", Text = "{#Emph}Aw{#Prev}, hits the spot..." },
				{ Cue = "/VO/Polyphemus_0211", Text = "{#Emph}Mmm{#Prev}, good stuff..." },
				{ Cue = "/VO/Polyphemus_0212", Text = "{#Emph}Augh{#Prev}, feeling better already." },
				{ Cue = "/VO/Polyphemus_0213", Text = "{#Emph}Mmm, mm..." },
				{ Cue = "/VO/Polyphemus_0214", Text = "{#Emph}Mm{#Prev}, my favorite." },
				{ Cue = "/VO/Polyphemus_0215", Text = "Just a quick snack..." },
				{ Cue = "/VO/Polyphemus_0389", Text = "{#Emph}<Chomp> {#Prev}Pretty good..." },
				{ Cue = "/VO/Polyphemus_0390", Text = "{#Emph}<Chomping>" },
				{ Cue = "/VO/Polyphemus_0391", Text = "{#Emph}Mm-mm{#Prev}, not bad..." },
				{ Cue = "/VO/Polyphemus_0392", Text = "{#Emph}Huh{#Prev}, tastes great!" },
			},
		},
		BadMealVoiceLines =
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			TriggerCooldowns = { "CyclopsSpokeRecently" },

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
			{ Cue = "/VO/Polyphemus_0393", Text = "No way." },
			{ Cue = "/VO/Polyphemus_0394", Text = "Nice try." },
			{ Cue = "/VO/Polyphemus_0395", Text = "Won't cut it." },
			{ Cue = "/VO/Polyphemus_0396", Text = "Nope!" },
			{ Cue = "/VO/Polyphemus_0397", Text = "Sorry!" },
			{ Cue = "/VO/Polyphemus_0398", Text = "{#Emph}Aw." },
		},
		ResistedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Polyphemus_0333", Text = "Hey, what was {#Emph}that?", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0334", Text = "Didn't even hurt." },
			{ Cue = "/VO/Polyphemus_0335", Text = "What the...?" },
			{ Cue = "/VO/Polyphemus_0336", Text = "Weak." },
		},
		PoisonBuffVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsPoisonedSpeech", Time = 45 },
					{ Name = "CyclopsSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Polyphemus_0497", Text = "{#Emph}Ooh{#Prev}, I'm pumped...", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0498", Text = "That {#Emph}itches..." },
				{ Cue = "/VO/Polyphemus_0499", Text = "Juiced up..." },
				{ Cue = "/VO/Polyphemus_0500", Text = "Toxified..." },
				{ Cue = "/VO/Polyphemus_0501", Text = "Souped up..." },
				{ Cue = "/VO/Polyphemus_0502", Text = "Special sauce..." },
				{ Cue = "/VO/Polyphemus_0503", Text = "{#Emph}Ahh{#Prev}, nice!" },
				{ Cue = "/VO/Polyphemus_0504", Text = "Thanks, witch..." },
				{ Cue = "/VO/Polyphemus_0505", Text = "{#Emph}There {#Prev}we go..." },
				{ Cue = "/VO/Polyphemus_0506", Text = "{#Emph}That's {#Prev}the stuff..." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				ObjectType = "Medea",
				GameStateRequirements =
				{
					--
				},
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Medea_0450", Text = "You're contagious, Cyclops...!" },
				{ Cue = "/VO/Medea_0451", Text = "You'll spread the plague, Cyclops...!" },
				{ Cue = "/VO/Medea_0452", Text = "The poor Cyclops is {#Emph}sick...!" },
				{ Cue = "/VO/Medea_0453", Text = "Who poisoned the Cyclops...?" },
				{ Cue = "/VO/Medea_0454", Text = "Plague-ridden..." },
				{ Cue = "/VO/Medea_0455", Text = "He's contagious...", PlayFirst = true },
			},
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "FrogFamiliarLand" },
					},
					{
						PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage" }
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 14 },
				},

				{ Cue = "/VO/Polyphemus_0464", Text = "Somethin' slimy..." },
				{ Cue = "/VO/Polyphemus_0465", Text = "That a frog?" },
				{ Cue = "/VO/Polyphemus_0466", Text = "Jumped by a {#Emph}frog?", PlayFirst = true},
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "RavenFamiliarMelee" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 14 },
				},

				{ Cue = "/VO/Polyphemus_0425", Text = "What's with the bird?", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0426", Text = "Quit your flappin'!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "CatFamiliarPounce" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 14 },
				},

				{ Cue = "/VO/Polyphemus_0341", Text = "That a {#Emph}cat?", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0342", Text = "Cool it, cat." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "HoundFamiliarBark" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 14 },
				},

				{ Cue = "/VO/Polyphemus_0427", Text = "Better not be a wolf.", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0428", Text = "Stray dog got in..." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "PolecatFamiliarMelee" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CyclopsSpokeRecently", Time = 14 },
				},

				{ Cue = "/VO/Polyphemus_0461", Text = "What scratched me?", PlayFirst = true },
				{ Cue = "/VO/Polyphemus_0462", Text = "Some kind of rat..." },
				{ Cue = "/VO/Polyphemus_0463", Text = "Dirty rat..." },
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
				{ Name = "CyclopsSpokeRecently", Time = 20 },
			},				
			GameStateRequirements =
			{
			},

			{ Cue = "/VO/Polyphemus_0062", Text = "Oof!" },
			{ Cue = "/VO/Polyphemus_0063", Text = "You no good..." },
			{ Cue = "/VO/Polyphemus_0068", Text = "{#Emph}Rngh..." },
			{ Cue = "/VO/Polyphemus_0069", Text = "{#Emph}Ugh, {#Prev}you..." },
			{ Cue = "/VO/Polyphemus_0070", Text = "Give me a break." },
			{ Cue = "/VO/Polyphemus_0071", Text = "Well damn." },
			{ Cue = "/VO/Polyphemus_0072", Text = "Really huh." },
			{ Cue = "/VO/Polyphemus_0073", Text = "So that's how it is?" },
			{ Cue = "/VO/Polyphemus_0075", Text = "That was nothing." },
			{ Cue = "/VO/Polyphemus_0077", Text = "{#Emph}Psh." },
			{ Cue = "/VO/Polyphemus_0181", Text = "{#Emph}Augh." },
			{ Cue = "/VO/Polyphemus_0429", Text = "{#Emph}Ehh..." },
			{ Cue = "/VO/Polyphemus_0430", Text = "That's low..." },
			{ Cue = "/VO/Polyphemus_0433", Text = "Get off of me!" },
			{ Cue = "/VO/Polyphemus_0434", Text = "{#Emph}Nah..." },
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
				{ Name = "CyclopsSpokeRecently", Time = 12 },
			},
			PreLineWait = 0.35,
			GameStateRequirements =
			{
			},
			{ Cue = "/VO/Polyphemus_0064", Text = "You little..." },
			{ Cue = "/VO/Polyphemus_0065", Text = "{#Emph}Buh..." },
			{ Cue = "/VO/Polyphemus_0066", Text = "{#Emph}Whu..." },
			{ Cue = "/VO/Polyphemus_0067", Text = "{#Emph}Grr..." },
			{ Cue = "/VO/Polyphemus_0074", Text = "Oh come on." },
			{ Cue = "/VO/Polyphemus_0076", Text = "{#Emph}Augh..." },
			{ Cue = "/VO/Polyphemus_0431", Text = "Tiring out...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Polyphemus_0432", Text = "{#Emph}<Yawn>",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
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
				{ Cue = "/VO/Polyphemus_0437", Text = "{#Emph}Ungh... {#Prev}you... little..." },
				{ Cue = "/VO/Polyphemus_0435", Text = "{#Emph}Guh... {#Prev}I'm... full...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 10,
						},
					},
				},
				{ Cue = "/VO/Polyphemus_0436", Text = "{#Emph}Urgh... {#Prev}good... night...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/Polyphemus_0438", Text = "{#Emph}Nghh... {#Prev}quick... nap...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Polyphemus" },
							Comparison = ">=",
							Value = 8,
						},
					},
				},
			},
			{
				PreLineWait = 0.35,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				Source = { LineHistoryName = "NPC_Medea_01", SubtitleColor = Color.MedeaVoice },
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/MelinoeField_3740" },
					},
				},

				{ Cue = "/VO/Medea_0510", Text = "{#Emph}Return to shadow, now!" },
				{ Cue = "/VO/Medea_0511", Text = "{#Emph}Return to shadow, now." },
				{ Cue = "/VO/Medea_0512", Text = "{#Emph}Return to shadow, now...!", PlayFirst = true },
				{ Cue = "/VO/Medea_0513", Text = "{#Emph}Return to shadow, now..." },
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
				PlayFirst = true,
				PlayOnce = true,
				PlayOnceContext = "FirstPolyphemusVORVictoryVO",
				BreakIfPlayed = true,
				PreLineWait = 7.2,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},

				{ Cue = "/VO/MelinoeField_3740", Text = "Where'd Lady Medea go..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 7.2,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.75,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = {
							"/VO/Medea_0510",
							"/VO/Medea_0511",
							"/VO/Medea_0512",
							"/VO/Medea_0513",
						},
					},
				},

				{ Cue = "/VO/Melinoe_1104", Text = "Lights out." },
				{ Cue = "/VO/Melinoe_1105", Text = "Good night." },
				{ Cue = "/VO/Melinoe_1106", Text = "And stay down.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1107", Text = "Sleep tight." },
				{ Cue = "/VO/Melinoe_1108", Text = "Out cold." },
				{ Cue = "/VO/Melinoe_1109", Text = "That'll show him." },
				{ Cue = "/VO/MelinoeField_1723", Text = "Don't stand in my way." },
				{ Cue = "/VO/MelinoeField_1726", Text = "...Eat {#Emph}that.", PreLineWait = 7.4 },
				{ Cue = "/VO/MelinoeField_3741", Text = "Lady Medea's gone...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3740" },
						},
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
					},
				},
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
					Text = "I apologize for my transgression, Cyclops. What do I owe you for the inconvenience? I can pay." },
				{ Cue = "/VO/Polyphemus_0003", Speaker = "NPC_Cyclops_Unnamed_01",
					Text = "Oh, you'll pay. The punishment's gettin' eaten alive. By {#Emph}me{#Prev}. Sorry, I don't make the rules." },
				{ Cue = "/VO/Melinoe_0491", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
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
					{ Cue = "/VO/MelinoeField_2448", Text = "Then you'll eat dust!" },
				},
			},

			-- alt below if you have yet to meet Medea
			PolyphemusAboutAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Story01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight01_B" }
					},
				},
				{ Cue = "/VO/Medea_0192",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					-- PreLineAnim = "Medea_Bless",
					-- PreLineAnim = "Medea_Scoff",
					-- PreLineAnim = "Medea_Sprinkle",
					-- PreLineAnim = "Medea_Casting_Start",
					-- PostLineAnim = "Medea_Casting_End",
					-- PreLineAnim = "Medea_Salute",
					Text = "I thank you, sorceress! Infusing Fear into the night lets me conduct certain experiments I normally cannot. Though I'm also bound to test you here, as does Great Hecate below." },
				{ Cue = "/VO/MelinoeField_3546", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}Test {#Prev}me! Lady Medea, what of the massive Cyclops already barring my path? He'll try to eat us both!" },
				{ Cue = "/VO/Polyphemus_0474",
					Text = "{#Emph}Nah. {#Prev}This witch here's not exactly to my taste, and besides... we got ourselves a little arrangement now. Since I can't smell as easy what with all the bodies popping up." },
				{ Cue = "/VO/Medea_0193",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Your fight is with the Cyclops still! My aim is merely to enact the will of Night in my own way. Do try your best to pretend I'm not even here, which may be difficult, admittedly..." },
			},
			-- if you have yet to meet Medea
			PolyphemusAboutAltFight01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "N_Story01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight01" }
					},
				},
				{ Cue = "/VO/Medea_0192",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					-- PreLineAnim = "Medea_Bless",
					-- PreLineAnim = "Medea_Scoff",
					-- PreLineAnim = "Medea_Sprinkle",
					-- PreLineAnim = "Medea_Casting_Start",
					-- PostLineAnim = "Medea_Casting_End",
					-- PreLineAnim = "Medea_Salute",
					Text = "I thank you, sorceress! Infusing Fear into the night lets me conduct certain experiments I normally cannot. Though I'm also bound to test you here, as does Great Hecate below." },
				{ Cue = "/VO/MelinoeField_4331", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Lady Medea! I thought you were supposed to be conducting research. And what do you mean, {#Emph}test me? {#Prev}That massive Cyclops already barring my path will try to eat us both!" },
				{ Cue = "/VO/Polyphemus_0474",
					Text = "Nah. This witch here's not exactly to my taste, and besides... we got ourselves a little arrangement now. Since I can't smell as easy what with all the bodies popping up." },
				{ Cue = "/VO/Medea_0193",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Your fight is with the Cyclops still! My aim is merely to enact the will of Night in my own way. Do try your best to pretend I'm not even here, which may be difficult, admittedly..." },
			},

			PolyphemusAboutAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0194",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "...Are you quite serious, Cyclops? The bodies of the dead ought {#Emph}not {#Prev}to be consumed; all sorts of diseases and the like!" },
				{ Cue = "/VO/Polyphemus_0475",
					Text = "I'm telling you, they can be pretty good! Just got to age 'em right. But anyways we can pick up on that later. Got a {#Emph}warm {#Prev}one over there." },
				{ Cue = "/VO/MelinoeField_3547", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Lady Medea, I cannot believe the two of you are getting on like this. The Testament of Night requires that you form alliances with those who stand in our way?" },
				{ Cue = "/VO/Medea_0195",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					Text = "We merely have a common interest, sorceress! The Cyclops yet stands in {#Emph}your {#Prev}way, so have at him! I'm here to make the night more foul at your own behest." },
			},

			PolyphemusAboutAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PolyphemusAboutAltFight01", "PolyphemusAboutAltFight01_B"  },
					},
				},
				{ Cue = "/VO/Polyphemus_0476",
					Text = "Where'd that one witch go, and all the bodies, {#Emph}huh? {#Prev}And just as I was starting to like the new aroma around here..." },
				{ Cue = "/VO/MelinoeField_3548", UsePlayerSource = true,
					Text = "You and all of us are subject to the will of Night, Cyclops. Lady Medea was drawn here for that reason alone. For my part, I find it easier not having to contend with you both." },
				{ Cue = "/VO/Polyphemus_0477",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You want things {#Emph}easy{#Prev}, then what are you even doing over here? You just passed through one of the hardest towns I know, and things are only gonna get rougher." },
			},

			PolyphemusAboutAltFight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight03" },
					},
				},
				{ Cue = "/VO/Polyphemus_0478",
					Text = "You fixed it, meat! This witch is back, there's bodies everywhere! I've had it good. But you're about to get it {#Emph}bad." },
				{ Cue = "/VO/MelinoeField_3549", UsePlayerSource = true,
					Text = "Lady Medea, aren't you supposed to stand with me here rather than with {#Emph}him? {#Prev}Though, the will of Night ought never to be questioned, and this is all part of the Vows I spoke..." },
				{ Cue = "/VO/Medea_0196",
					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Source = "NPC_Medea_01",
					Text = "Night brings terror, sorceress... a fear of the impossible and the unknown. I merely am fulfilling my responsibility unto that cause, so please! Address Lord Polyphemus here, not me." },
				{ Cue = "/VO/Polyphemus_0479",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Hah! Lord Polyphemus. {#Prev}Think I like the sound of that! After all, lords tend to have big appetites. Now come on over and I'll add you to the corpses on the ground." },
			},
			PolyphemusAboutAltFight05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight04" }
					},
				},
				{ Cue = "/VO/Polyphemus_0480",
					Text = "Even with all the extra bodies here, I can always sniff you out. You're on my turf, and you'll address me as {#Emph}Lord Polyphemus {#Prev}from now on." },
				{ Cue = "/VO/MelinoeField_3550", UsePlayerSource = true,
					Text = "You can't be serious. You're not entitled to a greater status just because you asked! Or has Lady Medea poisoned your mind with newfound delusions?" },
				{ Cue = "/VO/Medea_0199",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Don't look at {#Emph}me{#Prev}, sorceress. I'm here by will of Night alone, sworn to a Vow of Silence... even though it's difficult to keep." },
				{ Cue = "/VO/Polyphemus_0481",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "She don't want to talk to you, she said, but you keep on tryin'. And you know what? I don't want to talk to you, either." },
			},

			PolyphemusAboutAltFight06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight05" }
					},
				},
				{ Cue = "/VO/Polyphemus_0482",
					Text = "...I'm telling ya, it feels funny. Itches maybe, burns a little, I don't know. You sure it's gonna help me with my sleep?" },
				{ Cue = "/VO/Medea_0200",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Text = "Well for mortals, it induces an eternal sleep, preceded by a pain beyond compare. I made no more assurances, and... come to think? This may not be the remedy for you..." },
				{ Cue = "/VO/Polyphemus_0483",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Least it hasn't messed up my sense of smell too much. 'Cause otherwise I wouldn't know we got ourselves somebody else who probably could use your {#Emph}remedies." },
			},
			PolyphemusAboutAltFight07 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight06" }
					},
				},
				{ Cue = "/VO/Polyphemus_0484",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}<Sniff, Sniff> Eugh{#Prev}, my damn nose is all stuffed up. Think I'm allergic to something you got on you there, witch." },
				{ Cue = "/VO/Medea_0201",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "You're resistant to such toxins as could kill the strongest ox, Lord Polyphemus. Perhaps you've an aversion to the sorceress whom we must fight?" },
				{ Cue = "/VO/Polyphemus_0485",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}<Sniff> {#Prev}What, she's {#Emph}here? Ugh{#Prev}, I'm losin' it if I can't even smell 'er when she's right in front of me like this." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "Polyphemus",
					TriggerCooldowns = { "CyclopsSpokeRecently", "MedeaSpokeRecently" },
					{ Cue = "/VO/Polyphemus_0486", Text = "{#Emph}<Sniff> There {#Prev}she is..." },
				},
			},

			PolyphemusAboutAltFight08 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight07" }
					},
				},
				{ Cue = "/VO/Polyphemus_0487",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}<Sniff, Sniff> {#Prev}Well what am I supposed to do on nights like this? If I can't even smell her, I don't know where I'm supposed to kick." },
				{ Cue = "/VO/Medea_0202",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Sprinkle",
					PreLineAnimTarget = 737907,
					Text = "Lord Polyphemus, your nasal passages must be utterly congested. The one to whom you're referring is right {#Emph}there! {#Prev}Next time, I shall have to unearth something you can use." },
				{ Cue = "/VO/Polyphemus_0488",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}<Sniff> {#Prev}All right, sounds good, it's really not so bad. It's just if I can't smell my food, then I can't properly enjoy my meal." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "Polyphemus",
					TriggerCooldowns = { "CyclopsSpokeRecently", "MedeaSpokeRecently" },
					{ Cue = "/VO/Polyphemus_0489", Text = "{#Emph}<Sniff> Ahh..." },
				},
			},

			PolyphemusAboutAltFight09 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight08" }
					},
				},
				{ Cue = "/VO/Polyphemus_0490",
					Text = "{#Emph}<Inhale> Yeah{#Prev}, you know I think that might have done the trick! 'Cause I can smell every last corpse a couple fields away. You're all right, witch! What'd you even {#Emph}give {#Prev}me?" },
				{ Cue = "/VO/Medea_0203",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "{#Emph}Oh{#Prev}, it's just... I'd stashed away old herbal remedies my aunt had given me. Thought I would never find a use for them, but... didn't have the heart to throw them out." },
				{ Cue = "/VO/Polyphemus_0491",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well that was awful generous of you, though now I'm in the mood for a quick bite. Or maybe a quick nap? You want to stick around?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "Medea",
					TriggerCooldowns = { "MedeaSpokeRecently", "CyclopsSpokeRecently" },
					{ Cue = "/VO/Medea_0204", Text = "Why, {#Emph}certainly..." },
				},
			},

			PolyphemusAboutAltFight10 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight09" }
					},
				},
				{ Cue = "/VO/Medea_0205",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Salute",
					PreLineAnimTarget = 737907,
					Text = "...At any rate, Lord Polyphemus, we oughtn't even be speaking thus, for that is not my charge. But should you require any other remedies or toxins, I'm not far." },
				{ Cue = "/VO/MelinoeField_3663", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Lady Medea, you'd consort with Polyphemus there even without the Oath of the Unseen taking effect? I can't believe this! He's repeatedly attempted to devour me!" },
				{ Cue = "/VO/Polyphemus_0492",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Watch with the attitude there, meat. The witch just said that she don't want to talk. You ever got somethin' to say here, you say it to {#Emph}me." },
			},

			PolyphemusAboutAltFight11 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0206",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Such appalling silence in these outskirts! I've grown too much accustomed to the bustle of the city, and its lingering scents of blood and decay." },
				{ Cue = "/VO/MelinoeField_3816", UsePlayerSource = true,
					Text = "Lady Medea, does Headmistress even know what you're doing here? She hadn't mentioned you'd be testing me." },
				{ Cue = "/VO/Medea_0207",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Salute",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Great Hecate knows all. But now that you are Matron of the Oath, the consequences are yours to decide. And tonight, you spoke the Vows! Long have I been dying to oblige..." },
			},

			PolyphemusAboutAltFight12 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0210",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Am I to merely be a shadow in the dark...? I cannot help but intervene not just with actions here but words. Lord Polyphemus, talk to her, would you?" },
				{ Cue = "/VO/Polyphemus_0507",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Sure, whatever you say there, witch. Let me go ahead and give this piece of meat I smell here a {#Emph}real {#Prev}talking-to." },
			},

			PolyphemusAltFightAboutMedea01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Polyphemus_0509",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know it's {#Emph}nice {#Prev}here with this witch around. I'm normally not big on talk, more about the olfactory, and the auditory, and all that. So I might let her handle the conversatin' for a bit..." },
			},

			PolyphemusAboutAltFight13 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Medea_0211",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Sprinkle",
					PreLineAnimTarget = 737907,
					Text = "If I might briefly break my Vow of Silence, you look simply {#Emph}terrible{#Prev}, sorceress! More {#Emph}dead {#Prev}than {#Emph}alive. {#Prev}And now the Cyclops and I have to push you {#Emph}closer {#Prev}to the {#Emph}brink." },

				{ Cue = "/VO/MelinoeField_3818", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I had some difficulties in Ephyra on the way, though thank you for noticing. I know the will of Night demands you show no mercy to me here; anything but." },

				{ Cue = "/VO/Medea_0212",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I don't think the will of Night ought be your chief concern... Lord Polyphemus, he is positively {#Emph}salivating. {#Prev}The power of the scent of blood! Particularly {#Emph}yours." },
			},

			PolyphemusAboutAltFight14 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0213",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "Those accursed curing pools there in the corners of the field... the Mandragora thrives in bloodied soil, but in doing so, it filters toxins out. How rather {#Emph}fortunate {#Prev}for you." },

				{ Cue = "/VO/MelinoeField_3819", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Your toxins are so potent, they immediately make me feel as though I'm burning up, even with those curing pools nearby." },

				{ Cue = "/VO/Medea_0214",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What can I say? I try! You'll even find that, no matter how many times you take ill, you won't become resistant... let alone immune." },
			},
			PolyphemusAboutAltFight15 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
				},
				{ Cue = "/VO/Medea_0215",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "My curses and concoctions are quite lethal normally. But you've been able to withstand them! I don't know whether to be impressed with you, or disappointed in myself." },

				{ Cue = "/VO/MelinoeField_3931", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I thought this was to be a test of my abilities and growth! It more appears to be a test of your latest experiments." },

				{ Cue = "/VO/Medea_0216",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Sprinkle",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Must it merely be one or the other? Great Hecate has taught us always to be learning something more. {#Emph}That {#Prev}way, we shall grow as strong as the deadliest of poisons..." },
			},

			PolyphemusAltFightMetMedeaEarlier01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
				},
				{ Cue = "/VO/Medea_0217",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Text = "Well here we are already, sorceress! Mere moments prior we were speaking amicably by my cauldron, and yet now, it's come to {#Emph}this." },

				{ Cue = "/VO/MelinoeField_3932", UsePlayerSource = true,
					Text = "I know you're to confront me here because of the Oath we took, Lady Medea, but the Cyclops hasn't had as good of an excuse..." },

				{ Cue = "/VO/Medea_0218",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",

					Text = "Come, you've trespassed on his property, for one, and he is famished, for another! Look at him, he's at a loss for words. Lord Polyphemus, you {#Emph}must {#Prev}say something!" },
				EndVoiceLines =
				{
					PreLineWait = 0.75,
					ObjectType = "Polyphemus",
					TriggerCooldowns = { "CyclopsSpokeRecently", "MedeaSpokeRecently" },

					{ Cue = "/VO/Polyphemus_0508", Text = "How 'bout I let my {#Emph}feet {#Prev}do the talkin' {#Emph}this {#Prev}time?" },
				},
			},

			PolyphemusAboutAltFightBackOn01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
				},
				{ Cue = "/VO/Medea_0208",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					Text = "Well, sorceress! You're utterly committed to the Oath. As your fight remains with Lord Polyphemus, I'm to be mostly silent henceforth; though I have no wish to be rude." },
				{ Cue = "/VO/MelinoeField_3817", UsePlayerSource = true,
					Text = "I know you're here because of certain obligations, Lady Medea, so I certainly bear no ill will. Well not to you, at least, but to {#Emph}Lord Polyphemus{#Prev}, I am not so sure." },
				{ Cue = "/VO/Medea_0209",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Now he's upset again. Please understand that I am not responsible for any actions that the Cyclops takes... I hardly am responsible for {#Emph}mine." },
			},
			PolyphemusAboutAltFightBackOn02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
				},
				{ Cue = "/VO/Medea_0197",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Text = "{#Emph}Oh{#Prev}, I {#Emph}quite {#Prev}like it here! As much as I've enjoyed experimenting in my little corner of the city, a bit of the outdoors is giving me some benefit, I think." },
				{ Cue = "/VO/MelinoeField_3815", UsePlayerSource = true,
					Text = "If only I could say the same for your various toxins, venoms, poisons, and such, Lady Medea. Doesn't the will of Night forbid the use of certain substances?" },
				{ Cue = "/VO/Medea_0198",
					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Is that so...? Perhaps I'm not entirely caught up on all the latest bylaws; but you have bigger problems here than a bit of sour blood. {#Emph}Oh, Cyclops...?" },
			},

			PolyphemusAboutFlock01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0005",
					Text = "Can't you see I'm busy over here? Personally, I can't see a thing. Do I complain? No. I just tend my flock." },
				{ Cue = "/VO/Melinoe_0493", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Your blasted sheep are some of the most high-strung animals I have ever encountered." },
				{ Cue = "/VO/Polyphemus_0006",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Sheep are fast. It's not an easy job. And it's even harder when somebody makes a ruckus in my meadow. So what choice do I got? Besides eatin' {#Emph}you?" },
			},
			PolyphemusAboutFriendship01 =
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
				{ Cue = "/VO/Polyphemus_0007",
					Text = "You coulda had my friendship. A couple of my sheep. But instead? You spit in my eye." },
				{ Cue = "/VO/Melinoe_0494", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					Text = "Where I am from, we fast under the waxing moon, and grow nutritious plants and funguses. I could bring you some next time if you would like?" },
				{ Cue = "/VO/Polyphemus_0010",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "...I can't just save you for later. You'd try to run. They always do. Oh, {#Emph}I {#Prev}know! I'll just start with the legs!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0496", Text = "No you won't." },
				},
			},

			PolyphemusAboutName01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasAny = { "/VO/MelinoeField_0529", "/VO/MelinoeField_0530" }
					},
				},
				{ Cue = "/VO/Polyphemus_0347",
					Text = "Who told {#Emph}you {#Prev}you could call me by my name, {#Emph}eh? {#Prev}I never introduced myself to you. What, you gonna start calling me Poly next like I'm your pal?" },
				{ Cue = "/VO/MelinoeField_2858", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I can't imagine you have many {#Emph}pals {#Prev}with how you go on trying to eat anything that moves. Though, we could still be friends! Put all that trying-to-eat-me behind us?" },
				{ Cue = "/VO/Polyphemus_0348",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Nah! {#Prev}Got all the pals I need. The sheep back there, dead below the dirt down here. You know what I {#Emph}do {#Prev}need, though? {#Emph}Yeah {#Prev}I think you do." },
			},
			PolyphemusAboutMoving01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 8,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0455",
					Text = "Living here, it has its ups and downs. Lately for instance I don't get a lot of peace, though I sleep like a rock. I don't know, maybe I ought to move..." },
				{ Cue = "/VO/MelinoeField_3164", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I wholeheartedly support that choice. Aren't you more accustomed to island living anyhow? This city life, even on the outskirts here... the pace is far too quick." },
				{ Cue = "/VO/Polyphemus_0456",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I know what {#Emph}you {#Prev}want me to do. Although I miss the island life now that you bring it up. Still got unwanted company sometimes but not so much as now." },
			},

			PolyphemusAboutPast01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0139",
					Text = "Just wanted to be left alone. Move to the countryside, quiet life of the shepherd and all. Only for you to drag me out of retirement." },
				{ Cue = "/VO/MelinoeField_0320", UsePlayerSource = true,
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
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Polyphemus_0129",
					Text = "{#Emph}<Sigh> {#Prev}Look, I'm just a humble shepherd trying to live in peace. But I gotta protect my own, you understand. Plus, I gotta eat." },
				{ Cue = "/VO/MelinoeField_0313", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					Text = "Each time you know I'm here, no matter the softness of my approach or anything I do to mask my scent. Your senses are very keen." },
				{ Cue = "/VO/Polyphemus_0190",
					Text = "Yeah, well, when you lose your eye... you got to learn to compensate. And I never saw too good to start with. Could never tell how far away things were." },
				{ Cue = "/VO/MelinoeField_0353", UsePlayerSource = true,
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
					Text = "If you care so much about your sheep, why keep putting them in harm's way? Not to mention eating them. Let them leave here, now." },
				{ Cue = "/VO/Polyphemus_0141",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "'Scuse me? I didn't ask you for your shepherding advice, and besides... these sheep got nowhere else to be. And we're the {#Emph}dinner entertainment." },
			},

			PolyphemusAboutNobody01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Polyphemus_0011",
					Text = "You know who's disrespected me like this? Nobody. Nobody took my sheep. Took my eye." },
				{ Cue = "/VO/MelinoeField_2447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Yes, well, sometimes we've no one to blame but ourselves." },
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
					Text = "You said nobody took your eye before, as well as your sheep. How did you lose them, then?" },

				{ Cue = "/VO/Polyphemus_0131",
					Text = "Nobody played a dirty trick on me, is how. Bunch of sailors thought they could get away with my sheep, so I ate a couple of 'em. The sailors, that is! But Nobody got me when I wasn't looking. Then he got away..." },

				{ Cue = "/VO/MelinoeField_0315", UsePlayerSource = true,
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
					Text = "His name is Odysseus! He's a great hero and tactician, though you needn't worry about slaying him, for he's long dead already. Not your problem anymore." },
				{ Cue = "/VO/Polyphemus_0514",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Don't matter if he's dead, I'll eat him anyways. And don't care what he calls himself. He's always gonna be a Nobody to me. Now how 'bout I send him a message?" },
			},
			PolyphemusAboutNobody04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PolyphemusAboutOdysseusQuest01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0520",
					Text = "Nobody's not with you this time, is he? Good at running away, that guy. Knew I'd seen the last of him, found out I {#Emph}smelled {#Prev}the last of him, and maybe now I {#Emph}heard {#Prev}the last of him too." },
				{ Cue = "/VO/MelinoeField_4359", UsePlayerSource = true,
					Text = "I don't think Odysseus plans to make a habit of visiting, no. Which means you won't ever get to hear what happened when he first escaped from you. It's quite a tale!" },
				{ Cue = "/VO/Polyphemus_0521",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Think I can live with that. Nobody's a dirty sneak... who's gonna want a story about a guy like him?" },
			},

			PolyphemusAboutNobodyKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutNobody01" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "BossPreDamageKeepsake" },
					},
				},
				{ Cue = "/VO/Polyphemus_0287",
					Text = "{#Emph}<Sniff, Sniff> {#Prev}I never forget a scent, you know. And you got somethin' that's familiar to me from way back when. I know those Bones. {#Emph}Nobody {#Prev}had 'em before you." },

				{ Cue = "/VO/MelinoeField_1948", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You must mean these Knuckle Bones... if they've ever been a source of ill fortune for you before, then perhaps you know what's coming." },
						
				{ Cue = "/VO/Polyphemus_0288",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nobody's your {#Emph}pal{#Prev}, is that what you expect me to believe? Then first I'm gonna crush {#Emph}your {#Prev}bones, and then I'll eat 'em. And those Knuckle Bones, too." },
			},

			PolyphemusAboutOdysseusQuest01 =
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

				{ Cue = "/VO/Polyphemus_0515",
					Text = "Hey meat, smells to me like you brought those Knuckle Bones again. Nobody really gave you those, huh?" },

				{ Cue = "/VO/MelinoeField_4356",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 3.3, PowerWordPresentation = true, PowerWordWaitTime = 7.0 },

					PostLineFunctionName = "SummonOdysseus",
					PostLineFunctionArgs = { SummonTargetIds = { N_Boss01 = 756337, }, },
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "Ask him yourself, Cyclops. Nobody wants to speak with you. {#Emph}Heed now my voice, Odysseus; one whom you sought is here!" },

				{ Cue = "/VO/Polyphemus_0516",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					Text = "{#Emph}Nobody... {#Prev}can't smell ya for nothing but that's your voice, all right. Why not come a little {#Emph}closer {#Prev}so I can hear ya better?" },

				{ Cue = "/VO/Odysseus_0571",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					Text = "I'm afraid you won't be able to consume me in my current state, Cyclops, because I'm long since dead. A mere projection of a Shade, but I did wish to have a word!" },

				{ Cue = "/VO/Polyphemus_0517",
					Text = "{#Emph}Ah{#Prev}, ya really {#Emph}are {#Prev}already dead. Always thought I'd kill ya myself. But ya got the last laugh again." },

				{ Cue = "/VO/Odysseus_0572",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Not here to laugh, but to ask you a question. Back when you imprisoned me and my men, killing several of us, you ended up {#Emph}losing {#Prev}your one eye whilst we escaped... was it worth it?" },

				{ Cue = "/VO/Polyphemus_0518",
					PreLineWait = 0.35,
					Text = "...I don't remember most meals. Think that's pretty normal. But I remember your crew... tough meat, aged under the sun and all. But worth my eye? {#Emph}Nah{#Prev}, wasn't the best trade." },

				{ Cue = "/VO/Odysseus_0573",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					PortraitExitAnimation = "Portrait_Odysseus_Thoughtful_01_Exit",
					Text = "Nor was it good for me, or them. Well {#Emph}anyhow! {#Prev}It seems we each gave one another lasting, bitter scars. Though mine is merely psychological. I'll leave you to the Princess now, you murderous bastard." },

				{ Cue = "/VO/Polyphemus_0519",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PostLineThreadedFunctionName = "UnSummonOdysseus",
					Text = "Shove off, pal. I didn't ever want to see you again anyways." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PolyphemusAboutDocks01", "PolyphemusAboutEphyra01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0127",
					Text = "Hey what's your beef with Chronos, anyways? He wants to change stuff up a bit, so what? Life's hard up here. It could be easier." },
				{ Cue = "/VO/MelinoeField_0312", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "It won't be. That {#Emph}town {#Prev}back there, as you call it, would have been bustling with mortals. Now it's a festering necropolis. All thanks to the Titan." },
				{ Cue = "/VO/Polyphemus_0128",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "My sheep, they're glad to be alive. No complaints. But individuals like you? You got too many ideals. Best I {#Emph}eat {#Prev}you, and be done." },
			},

			PolyphemusAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutChronos01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/MelinoeField_2829", UsePlayerSource = true,
					Text = "So what does Chronos offer you exactly for these ineffectual attempts to bar my passage?" },
				{ Cue = "/VO/Polyphemus_0343",
					Text = "Don't see how that's any of your business, meat. {#Emph}You're {#Prev}the one barging into my turf, making a fuss in my town. Falls on me to keep things nice and orderly." },
				{ Cue = "/VO/MelinoeField_2830", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Ephyra is {#Emph}not {#Prev}your town. Unless that was your arrangement with the Titan, though the city wasn't his to give away. In any case, ready to earn your nightly keep?" },
				{ Cue = "/VO/Polyphemus_0344",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ohh {#Prev}you don't know the next thing about my {#Emph}arrangement. {#Prev}For one, I always take my pay up front. But with you here... I get a little {#Emph}bonus." },
			},

			PolyphemusAboutMedea01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" }
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight01" }
					},
				},
				{ Cue = "/VO/Polyphemus_0136",
					Text = "Somethin' {#Emph}nasty {#Prev}in the air tonight. And it's not just {#Emph}you {#Prev}or the stink from town. Must be that witch up to no good. You palling up with her?" },
				{ Cue = "/VO/MelinoeField_0318", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					Text = "How is it you detain {#Emph}me {#Prev}every time, yet the mighty Heracles can rampage through the city all he likes and never has to deal with you? Or so he says." },
				{ Cue = "/VO/Polyphemus_0138",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It's called a {#Emph}double standard{#Prev}, little sheep. Don't need my eye to know he's way bigger than you. You can knock me out for a nice short nap; he can knock me into next week. No thanks." },
			},
			PolyphemusAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Polyphemus_0445",
					Text = "I know your scent but don't got any real clue what you look like. Probably you're kind of like this shepherd's crook I got between my teeth. No meat on you at all." },
				{ Cue = "/VO/MelinoeField_3159", UsePlayerSource = true,
					Text = "Perhaps if you knew my appearance you'd be less inclined to treat me as livestock. My hair is pale as wheat; I'm clad in saffron and silver; and I wield the Nocturnal Arms, forged in the depths of Chaos." },
				{ Cue = "/VO/Polyphemus_0446",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Mmm{#Prev}, wheat and saffron! Throw in some sheep's milk, pinch of sea-salt, little of {#Emph}this{#Prev}, little of {#Emph}that{#Prev}? Then throw it in the fire for a bit... and you'll have bread to die for." },
			},

			PolyphemusAboutCyclopes01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_0317", UsePlayerSource = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusLostAgainstHim02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutUnderworld01B" },
					},
				},
				{ Cue = "/VO/Polyphemus_0119",
					Text = "You some kind of {#Emph}deathless goddess of the Underworld{#Prev}, you said? Seems you'd be better off staying on {#Emph}your {#Prev}side of the fence." },
				{ Cue = "/VO/MelinoeField_0307", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					Text = "Are you the one responsible for that spectral barrier at the city gates? It has the markings of Chronos all over it, and you seem to be the extra backup in case it fails." },
				{ Cue = "/VO/Polyphemus_0122",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh {#Emph}that {#Prev}thing, yeah. I knew it'd never hold. But they keep fixing it anyways! Almost like somebody out there don't want you here..." },
			},

			PolyphemusAboutDocks01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
					},
				},
				{ Cue = "/VO/Polyphemus_0123",
					Text = "I made those docks back there with my bare hands. Know some guys, they tally every skiff and trireme in the drink. We know where you're going." },
				{ Cue = "/VO/MelinoeField_0309", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So what if you do? You're just another servant of Chronos. The gods shall punish you when all this is over." },
				{ Cue = "/VO/Polyphemus_0124",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ehh{#Prev}, what do you know about it? They only care about their own! I'm just a joke to them. Am I a joke... to {#Emph}you?" },
			},

			PolyphemusAboutBarn01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_PostBoss01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0281",
					Text = "You went through my old barn the other night while I was out. Coulda cased the joint but you didn't. Drank from my well and that was it." },
				{ Cue = "/VO/MelinoeField_1929", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I'm no thief. And besides, your residence is filthy! You could stand to clean it up instead of facing me. Let me know if you need assistance, as I'll soon be passing through again." },
				{ Cue = "/VO/Polyphemus_0282",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Nah{#Prev}, thanks. If it was tidy in there I couldn't sniff my way around. And also, you {#Emph}shut up! {#Prev}I don't go tellin' {#Emph}you {#Prev}the way {#Emph}you {#Prev}ought to live!" },
			},

			PolyphemusAboutThessaly01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Polyphemus_0285",
					Text = "Where do you think you're goin', anyways? No ship that sails from the docks back there is gonna take the likes of {#Emph}you. {#Prev}Come to think of it... lately, we've had no ships at all." },
				{ Cue = "/VO/MelinoeField_1947", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The deathless fleet of Chronos is still out there in the waters of the Rift. Apparently when one ship sinks, another rises to replace it from the depths, drowned sailors for its crew..." },
				{ Cue = "/VO/Polyphemus_0286",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're pulling my leg. The dead can sail nowadays? I thought they were no good for anything but food. Might have to teach 'em to take on some of my household chores..." },
			},
			PolyphemusAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Intro" },
					},					
				},
				{ Cue = "/VO/Polyphemus_0345",
					Text = "So how is it over there, across the drink? Heard it's been snowing. Sounds like a real rotten place to live." },
				{ Cue = "/VO/MelinoeField_2831", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "What, you mean Mount Olympus? The gods themselves quite like it, enough to want to fiercely defend it from the Titan you decided to support. But, yes... it's rather cold." },
				{ Cue = "/VO/Polyphemus_0346",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh{#Prev}, I could never settle in a place like that. I like the temperature same way I like my meat, nice and hot. 'Course I can also eat it raw. Can't be too picky, and all that." },
			},

			PolyphemusAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" }
					},
				},
				{ Cue = "/VO/Polyphemus_0457",
					Text = "The dead... they talk sometimes, or try. Nothin' better to do around here. Know what they're going on about? I couldn't make it out at first, but sounds an awful lot like... {#Emph}Prometheus." },
				{ Cue = "/VO/MelinoeField_3165", UsePlayerSource = true,
					Text = "The Titan of Foresight, and one of your allies, in case you've not met; for apparently you serve the same master. What have the wretched dead to say about the likes of him?" },
				{ Cue = "/VO/Polyphemus_0458",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Mostly just moans and groans. Might be they're hungry like me! 'Cause if Prometheus really made off with fire from the gods like I'm hearin'... he probably knows how to cook." },
			},

			PolyphemusAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "N_Boss01", "N_Boss02" },
						Comparison = ">=",
						Value = 8,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3166", UsePlayerSource = true,
					Text = "I remember back when first we met, you seemed {#Emph}enormous... {#Prev}much bigger than most any other foe I'd ever faced. But now, you're hardly any match for me." },
				{ Cue = "/VO/Polyphemus_0459",
					Text = "{#Emph}Aw{#Prev}, thanks. And I remember back when first {#Emph}we {#Prev}met, my sleeping schedule was completely out of whack! But it's all better now. And I've still got my figure! {#Emph}Enormous{#Prev}, was it?" },
				{ Cue = "/VO/MelinoeField_3167", UsePlayerSource = true,
					Text = "That's all a matter of perspective, as I've learned. For instance, you're quite minuscule in comparison to the Father of All Monsters, Typhon. He's properly enormous." },
				{ Cue = "/VO/Polyphemus_0460",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'll have to take your word for it. Anyways just how big can he be? No more than three square meals' worth if I had to guess. Been too long since I had some monster meat..." },
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Polyphemus_0145",
					Text = "{#Emph}<Sniff> {#Prev}I smell {#Emph}blood. {#Prev}I was just getting ready to prepare my next meal... but the town welcoming committee must have prepped you already." },
				{ Cue = "/VO/MelinoeField_0324", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Polyphemus_0147",
					Text = "{#Emph}Ooh, {#Prev}I can tell the town welcoming committee must have done a number on you already. Softened you up {#Emph}good. {#Prev}All the better for {#Emph}me." },
				{ Cue = "/VO/MelinoeField_0325", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
						Value = 0,
					},
				},
				{ Cue = "/VO/Polyphemus_0115",
					Text = "{#Emph}Wow! {#Prev}Just when I thought I had you last time, you gave me the slip. Didn't think I'd get another shot." },
				{ Cue = "/VO/MelinoeField_0305", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
						Value = 0,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusLostAgainstHim01" },
					},
				},
				{ Cue = "/VO/Polyphemus_0117",
					Text = "Don't like playing with my food. Like it even less when my food plays with {#Emph}me. {#Prev}I'm on to that disappearing act of yours." },
				{ Cue = "/VO/MelinoeField_0306", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
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
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = "<=",
						Value = 10,
					},
				},
				{ Cue = "/VO/Polyphemus_0111",
					Text = "Oh, {#Emph}hey! {#Prev}I wanted to say thanks. Gave me a real zinger there last time, you know that?" },
				{ Cue = "/VO/Melinoe_0938", UsePlayerSource = true,
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
					Text = "It might. If you keep blocking my path, you'll get another thrashing, and you'll be sound asleep again in no time. That what you want?" },
				{ Cue = "/VO/Polyphemus_0114",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh! Got a dilemma on my hands! I'm always sleepy, yeah. But I'm always hungry, too. Guess that makes this a {#Emph}can't-lose proposition." },
			},

			PolyphemusAboutPackagedBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Polyphemus_0447",
					Text = "I know when somethin's off, and somethin's off. What are you up to, {#Emph}meat? {#Prev}Other than getting caught by me like every other time you tried to sneak through here." },
				{ Cue = "/VO/MelinoeField_3160", UsePlayerSource = true,
					Text = "Oh I'm not sneaking; in fact I'm here for {#Emph}you {#Prev}this time, Cyclops. The Origin of All Existence is interested to see if I have what it takes to lay you to rest." },
				{ Cue = "/VO/Polyphemus_0448",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Origin of All Existence...? {#Prev}You took a job to take me out, {#Emph}that's {#Prev}what I'm hearing from you? Well, you wouldn't be the first to try it. Now let me {#Emph}demonstrate {#Prev}what happened to the rest." },
			},
			PolyphemusAboutPackagedBounties02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/Polyphemus_0449",
					Text = "Oh hey! The Origin of All Existence wanted me to let you know, you're just not cuttin' it. And the whole deal is off. I also get to eat you now." },
				{ Cue = "/VO/MelinoeField_3161", UsePlayerSource = true,
					Text = "I find it exceedingly difficult to believe that Primordial Chaos would have been in contact with {#Emph}you {#Prev}about such matters. Easier to believe this is all part of the current Trial." },
				{ Cue = "/VO/Polyphemus_0450",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If this is all part of some {#Emph}Trial{#Prev}, that makes me the judge. And I hereby declare you're {#Emph}dinner. {#Prev}That is unless {#Emph}you {#Prev}or your pal {#Emph}Primordial Chaos {#Prev}plan to do somethin' about it." },
			},
			PolyphemusAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyAxeHeat1NBoss",
							"BountyDaggerHeat2NBoss",
							"BountyStaffHeat4NBoss",
							"BountySuitHeat8NBoss",
							"BountyLobHeat12NBoss",
							"BountyTorchHeat16NBoss",

							"BountyShrineStaffNBoss",
							"BountyShrineDaggerNBoss",
							"BountyShrineTorchNBoss",
							"BountyShrineAxeNBoss",
							"BountyShrineLobNBoss",
							"BountyShrineSuitNBoss",
						},
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PolyphemusAboutPackagedBounties01" }, Min = 3 },
					},
				},
				{ Cue = "/VO/Polyphemus_0451",
					Text = "Hairs on the back of my neck all standin' up, and not 'cause of {#Emph}you. {#Prev}Or maybe it is, but... it's like I got a {#Emph}mark {#Prev}on me. Not had this feeling in a while." },
				{ Cue = "/VO/MelinoeField_3162", UsePlayerSource = true,
					Text = "Nothing personal, Cyclops. But the Testament of Night requires your defeat. You needn't concern yourself with the inner workings of it, so how about we just fight." },
				{ Cue = "/VO/Polyphemus_0452",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Testament of {#Emph}what? {#Prev}I didn't get a damn word you said at the beginnin' there, but you got me on board at {#Emph}just fight!{#Prev}" },
			},
			-- alt below
			PolyphemusAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PolyphemusAboutShrine01", "PolyphemusAboutMedea01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutShrine02_B" }
					},
				},
				{ Cue = "/VO/Polyphemus_0453",
					Text = "So you can mess with how things work at night? Between the feeling in my gut and the nonsense you've been talkin', I can tell you've been up to no good. You some kind of {#Emph}witch?" },
				{ Cue = "/VO/MelinoeField_3163", UsePlayerSource = true,
					Text = "Lady Medea isn't the only one to practice around here. Since you're finally wising up to our true strength, know that you violate the will of Night herself by standing in my way." },
				{ Cue = "/VO/Polyphemus_0454",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "See, there you go again with all the fancy talk. But hey, I could go for a fancy meal just as soon as a tough piece of meat! Maybe you're both." },
			},
			PolyphemusAboutShrine02_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PolyphemusAboutShrine01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PolyphemusAboutShrine02" }
					},
				},
				{ Cue = "/VO/Polyphemus_0453",
					Text = "So you can mess with how things work at night? Between the feeling in my gut and the nonsense you've been talkin', I can tell you've been up to no good. You some kind of {#Emph}witch?" },
				{ Cue = "/VO/MelinoeField_3163_B", UsePlayerSource = true,
					Text = "Since you're finally wising up to our true strength, know that you violate the will of Night herself by standing in my way." },
				{ Cue = "/VO/Polyphemus_0454",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "See, there you go again with all the fancy talk. But hey, I could go for a fancy meal just as soon as a tough piece of meat! Maybe you're both." },
			},

			PolyphemusPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_4123", UsePlayerSource = true,
					Text = "Your service to the Titan Chronos is complete, Cyclops! His war against Olympus is ended if you've not already heard. I hold no enmity toward you. Be on your way!" },
				{ Cue = "/VO/Polyphemus_0493",
					Text = "I was just wondering how come I haven't gotten paid. Thought maybe my shepherding hasn't been up to snuff." },
				{ Cue = "/VO/MelinoeField_4124", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Chronos was compensating you for {#Emph}tending sheep? {#Prev}I thought you were supposed to be guarding the city gates." },
				{ Cue = "/VO/Polyphemus_0494",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What do you even know about it. You really think I'm gonna leave my flock now, after all we've been through? And I can always earn my meal ticket some other way." },
			},
			PolyphemusPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_4125", UsePlayerSource = true,
					Text = "I see you decided not to act on my prior recommendation, for the good of your flock, whose sheep you often eat. For how much longer do you plan to bar me from the Rift?" },
				{ Cue = "/VO/Polyphemus_0495",
					Text = "Thinking it might be a while. Got my flock, got my barn, been sleeping better lately... and having to uproot? Settle someplace else? Packing, and unpacking, I don't want any of that." },
				{ Cue = "/VO/MelinoeField_4126", UsePlayerSource = true,
					Text = "How fortunate you've made yourself such a comfortable arrangement that happens to be right in my blasted way." },
				{ Cue = "/VO/Polyphemus_0496",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aw{#Prev}, that's just another perk: I even get my nightly exercise." },
			},
			PolyphemusPostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 2 },
					},
					{
						SumPrevRuns = 2,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Polyphemus_0522",
					Text = "How come you said whatever war is over, {#Emph}huh? {#Prev}The town's about the same. Last I checked the dead are meant to be underground, not walking through the streets." },
				{ Cue = "/VO/MelinoeField_4360", UsePlayerSource = true,
					Text = "The war with Chronos is over, it's just... there are a few remaining details being sorted out, and the Underworld is in enough of a state of disrepair that it isn't back in order yet." },
				{ Cue = "/VO/Polyphemus_0523",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aw{#Prev}, that's too bad. I'd tell you to go down there and help 'em out, but that might cut into my sleep routine, which has been pretty good lately. Now come on, it's almost bedtime here." },
			},
			PolyphemusAboutMeat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_4361", UsePlayerSource = true,
					Text = "For all these nights we've fought, you don't even know my name, do you, Cyclops? I'm still nothing but a piece of meat." },
				{ Cue = "/VO/Polyphemus_0524",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Hey, you said it, not me. Besides, it's not like {#Emph}I'm {#Prev}the one stomping in here, frightening my sheep... well no I guess I do some of the time, but still." },
			},
			PolyphemusAboutSleep01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "N" },
						IgnoreCurrentRun = true,
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 2 },
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Polyphemus_0528",
					Text = "Not heard you show up in a while! Glad you're back. Been gone so long it's really been eatin' into my sleep schedule." },
				{ Cue = "/VO/MelinoeField_4364", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "For a moment there, I thought you were genuinely pleased at my return. But you just want me to render you unconscious." },
				{ Cue = "/VO/Polyphemus_0529",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yeah. That or stand still long enough for me to eat you up. But you don't seem interested in that, so I'll just go for the unconscious thing. I'm easy to please." },
			},
			PolyphemusPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/MelinoeField_4362", UsePlayerSource = true,
					Text = "This isn't going to last, you know, Cyclops. At some point, the City of Ephyra shall be rebuilt. Its streets will be teeming with mortals, the docks bustling with seafarers... rather than this." },
				{ Cue = "/VO/Polyphemus_0525",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What are you, an oracle or somethin'? If they try and put the town back together, great. More meat for me whenever I want! You'll have to do for now." },
			},
			PolyphemusAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutOdysseusQuest01" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Polyphemus_0526",
					Text = "Been finding if I talk too much, it messes with my sleep. Maybe we ought to cut with the chat and go straight to it. But I don't mean to be rude, so you... got any last words, meat?" },
				{ Cue = "/VO/MelinoeField_4363", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "...Certainly, my last words are: You're never going to eat me, and you're never going to stop me, but you're welcome to keep trying, and cheers for all the Wool!" },
				{ Cue = "/VO/Polyphemus_0527",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Wait, hold on... so {#Emph}you're {#Prev}the one who's been stealing all my Wool this whole time? {#Emph}Aw{#Prev}, now that {#Emph}does {#Prev}it..." },
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
					Text = "{#Emph}<Sniff> {#Prev}Somethin' stinks... oh I know what it is. It's {#Emph}you." },
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
					Text = "{#Emph}Shh! {#Prev}Think I heard somethin'. You hear it, right? The dinner bell..." },
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
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 1 },
					},
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
					Text = "I really got to do somethin' about that wall you keep on getting through..." },
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
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 2 },
					},
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
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 2 },
					},
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
			PolyphemusMiscStart31 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossPolyphemus01" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossPolyphemus01", "ClearTime" },
								Comparison = "<=",
								Value = 20.0
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossPolyphemus02" },
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossPolyphemus02", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
					},
				},
				{ Cue = "/VO/Polyphemus_0530",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Last time you knocked me out so fast, got the best sleep I had in a while!" },
			},
			PolyphemusMiscStart32 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossPolyphemus01" },
							},
							{
								PathFalse = { "PrevRun", "EncounterClearStats", "BossPolyphemus01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossPolyphemus02" },
							},
							{
								PathFalse = { "PrevRun", "EncounterClearStats", "BossPolyphemus02", "TookDamage" },
							},
						},
					},
				},
				{ Cue = "/VO/Polyphemus_0531",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineWait = 0.35,
					Text = "Didn't even get a piece of you last time, but you can't get away forever..." },
			},

			MedeaMiscStart01 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobCloseAttackAspect" },
					},
				},
				{ Cue = "/VO/Medea_0603",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "You bear my favored Aspect of Revaal! The Cyclops truly is in for it now." },
			},
			MedeaMiscStart02 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
					},
				},
				{ Cue = "/VO/Medea_0604",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Text = "The Aspect of the Goddess Hel... I shall enjoy bearing witness to her power." },
			},
			MedeaMiscStart03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0605",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "The Moon is full and getting in my eyes... on such an eve, I envy you, Lord Polyphemus." },
			},
			MedeaMiscStart04 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0606",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Salute",
					PreLineAnimTarget = 737907,
					Text = "I was right in the middle of a new concoction, but I'd abandon {#Emph}anything {#Prev}for {#Emph}this." },
			},
			MedeaMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0607",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Text = "There really is quite a distinct aroma here, between the corpses and the shepherd's flock..." },
			},
			MedeaMiscStart06 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0370",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "My poisons are for mortal use, but also work on goddesses." },
			},
			MedeaMiscStart07 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0351",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "Let's have another brush with death now, sorceress." },
			},
			MedeaMiscStart08 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0352",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "Come demonstrate to us your knowledge of the necromantic arts." },
			},
			MedeaMiscStart09 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0353",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,
					Source = "NPC_Medea_01",
					Text = "Great Hecate requires me to test your wherewithal, if you would be so kind?" },
			},
			MedeaMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0354",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,
					Source = "NPC_Medea_01",

					Text = "I shall not hesitate to draw some of your blood here, sorceress." },
			},
			MedeaMiscStart11 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0355",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "All my research has made me welcome this as a refreshing change of pace." },
			},
			MedeaMiscStart12 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0356",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					PreLineAnim = "Medea_Bless",
					PreLineAnimTarget = 737907,
					Source = "NPC_Medea_01",
					Text = "Perhaps I have {#Emph}already {#Prev}cursed you, sorceress! Let's see you break the spell." },
			},
			MedeaMiscStart13 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0357",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "Careful, lest I cut that tender throat of yours like that of a mewling babe." },
			},
			MedeaMiscStart14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
				},
				{ Cue = "/VO/Medea_0358",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "Sacrifices must be made on nights such as this. Yours or mine ought to suffice." },
			},
			MedeaMiscStart15 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0359",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "As blood is shortly to be drawn, rest easy knowing not one drop shall go to waste." },
			},
			MedeaMiscStart16 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0360",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "Know that your youth does not entitle you to mercy, sorceress." },
			},
			MedeaMiscStart17 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
					{
						Path = { "PrevRun", "BossHealthBarRecord", "Polyphemus" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/Medea_0361",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineAnim = "Medea_Sprinkle",
					PreLineAnimTarget = 737907,
					Source = "NPC_Medea_01",
					Text = "Come, sorceress! Seek vengeance now for what we did to you before..." },
			},
			MedeaMiscStart18 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0362",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineAnim = "Medea_Greet",
					PreLineAnimTarget = 737907,

					Source = "NPC_Medea_01",
					Text = "I heed the summons of the will of Night. Indeed, I'm more than happy to oblige." },
			},
			MedeaMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0363",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,

					Source = "NPC_Medea_01",
					Text = "You spoke the Vow of Rivals, so as mortals sometimes say: {#Emph}You asked for this." },
			},
			MedeaMiscStart20 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0364",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "My craft can kill most anything in moments, but not {#Emph}you. {#Prev}It may prove quite unpleasant though." },
			},
			MedeaMiscStart21 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0365",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,

					Source = "NPC_Medea_01",
					Text = "How is it that you're so resistant to my curses, sorceress...?" },
			},
			MedeaMiscStart22 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0366",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",
					PreLineAnim = "Medea_Scoff",
					PreLineAnimTarget = 737907,

					Source = "NPC_Medea_01",
					Text = "...Well, Lord Polyphemus. Perhaps we might catch up some more some other eve." },
			},
			MedeaMiscStart23 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Medea_0367",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPolyphemusTauntAnim",

					Source = "NPC_Medea_01",
					Text = "When you invoke the will of Night, you'd best not flinch." },
			},
		},
		
		Using = { GrannyModel = "Odysseus_Mesh", }, 
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
		SkipModifiers = true,
		IgnoreSprintPhasingStasisStun = true,
		StunAnimations = 
		{
			Default = "Enemy_Polyphemus_DeathOnHit",
		},
		
		EffectBlocks = { "WeakEffect", "BlindEffect", "ChillEffect" },
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
			{ Cue = "/VO/Polyphemus_0439", Text = "...don't go anywhere... sheep..." },
			{ Cue = "/VO/Polyphemus_0443", Text = "...be up... in a minute..." },
			{ Cue = "/VO/Polyphemus_0444", Text = "...{#Emph}ah... {#Prev}that's... good..." },
			{ Cue = "/VO/Polyphemus_0440", Text = "...three sheep... four sheep... five..." },
			{ Cue = "/VO/Polyphemus_0441", Text = "...seven sheep... eight sheep... nine..." },
			{ Cue = "/VO/Polyphemus_0442", Text = "...ten sheep... {#Emph}uhhh... {#Prev}one sheep... two...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/Polyphemus_0440", "/VO/Polyphemus_0441" }
					},
				},
			},
		},
	},	
}

-- Global Polyphemus Lines
GlobalVoiceLines.PolyphemusGreetingLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "PolyphemusMedeaIntroVO",
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		ObjectType = "Polyphemus",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "PolyphemusAboutAltFight01", "PolyphemusAboutAltFight01_B" },
			},
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "SessionMapState", "MedeaAlreadyPresent" },
			},
		},

		{ Cue = "/VO/Polyphemus_0510", Text = "...Look I only had a {#Emph}couple {#Prev}here and there...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "SessionMapState", "MedeaAlreadyPresent" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.4,
		SuccessiveChanceToPlay = 0.66,
		SuccessiveChanceToPlayAll = 0.33,
		ObjectType = "Medea",
		PreLineAnim = "Medea_Salute",
		GameStateRequirements =
		{
			--
		},

		{ Cue = "/VO/Medea_0337", Text = "It's {#Emph}you...", PlayFirst = true, IgnorePreLineAnim = true },
		{ Cue = "/VO/Medea_0338", Text = "I'm here...!", IgnorePreLineAnim = true },
		{ Cue = "/VO/Medea_0339", Text = "Sorceress..." },
		{ Cue = "/VO/Medea_0340", Text = "Ah, yes.", IgnorePreLineAnim = true },
		{ Cue = "/VO/Medea_0341", Text = "Cyclops.", IgnorePreLineAnim = true },
		{ Cue = "/VO/Medea_0344", Text = "By will of Night." },
		{ Cue = "/VO/Medea_0345", Text = "We're all here." },
		{ Cue = "/VO/Medea_0346", Text = "Good evening, you two." },
		{ Cue = "/VO/Medea_0347", Text = "Shall we...?" },
		{ Cue = "/VO/Medea_0348", Text = "Such a night..." },
		{ Cue = "/VO/Medea_0343", Text = "My lord.", IgnorePreLineAnim = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight04" },
				},
			},
		},
		{ Cue = "/VO/Medea_0342", Text = "Lord Polyphemus.", PreLineAnim = "Medea_Greet",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutAltFight04" },
				},
			},
		},
		{ Cue = "/VO/Medea_0349", Text = "The Moon is full...", IgnorePreLineAnim = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "GamePhase", },
					Comparison = "==",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Medea_0350", Text = "A new moon...", IgnorePreLineAnim = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "GamePhase", },
					Comparison = "==",
					Value = 5,
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.3,
		SuccessiveChanceToPlay = 0.1,
		UsePlayerSource = true,			
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered" },
				SumOf = { "N_Boss01", "N_Boss02" },
				Comparison = ">=",
				Value = 6,
			},
			{
				Path = { "GameState", "RoomsEntered", "N_Boss02" },
				Comparison = "~=",
				Value = 1,
			}
		},
		{ Cue = "/VO/MelinoeField_0529", Text = "Polyphemus!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0530", Text = "Polyphemus..." },
		{ Cue = "/VO/Melinoe_1451", Text = "You heard that, didn't you..." },
		{ Cue = "/VO/Melinoe_1452", Text = "Did you enjoy your nap?", PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "N_Boss01", "N_Boss02" }, Count = 1 },
				},
			},
		 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.33,
		PostLineWait = 0.0,
		ObjectType = "Polyphemus",

		{ Cue = "/VO/Polyphemus_0468", Text = "Oh there she is." },
		{ Cue = "/VO/Polyphemus_0099", Text = "{#Emph}<Sniff> Hrm.", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0100", Text = "Got to be kidding." },
		{ Cue = "/VO/Polyphemus_0101", Text = "Hi!" },
		{ Cue = "/VO/Polyphemus_0102", Text = "Really." },
		{ Cue = "/VO/Polyphemus_0103", Text = "You're no sheep." },
		{ Cue = "/VO/Polyphemus_0104", Text = "What is it now?" },
		{ Cue = "/VO/Polyphemus_0105", Text = "You again." },
		{ Cue = "/VO/Polyphemus_0106", Text = "You {#Emph}again?" },
		{ Cue = "/VO/Polyphemus_0107", Text = "Oh great." },
		{ Cue = "/VO/Polyphemus_0108", Text = "Somebody's there..." },
		{ Cue = "/VO/Polyphemus_0109", Text = "Heard you were back..." },
		{ Cue = "/VO/Polyphemus_0110", Text = "Who? {#Emph}Ohh..." },
		{ Cue = "/VO/Polyphemus_0192", Text = "Hold it." },
		{ Cue = "/VO/Polyphemus_0193", Text = "I {#Emph}see {#Prev}you." },
		{ Cue = "/VO/Polyphemus_0194", Text = "Heard you were in town." },
		{ Cue = "/VO/Polyphemus_0195", Text = "Chow time..." },
		{ Cue = "/VO/Polyphemus_0196", Text = "A dinner guest..." },
		{ Cue = "/VO/Polyphemus_0197", Text = "Let me guess..." },
		{ Cue = "/VO/Polyphemus_0198", Text = "We doing this?" },
		{ Cue = "/VO/Polyphemus_0199", Text = "Oh, good." },
		{ Cue = "/VO/Polyphemus_0349", Text = "{#Emph}<Sniff> Ahh..." },
		{ Cue = "/VO/Polyphemus_0350", Text = "Company..." },
		{ Cue = "/VO/Polyphemus_0351", Text = "Here, sheepie..." },
		{ Cue = "/VO/Polyphemus_0352", Text = "Where you going?" },
		{ Cue = "/VO/Polyphemus_0353", Text = "Hold up." },
		{ Cue = "/VO/Polyphemus_0354", Text = "Slow down." },
		{ Cue = "/VO/Polyphemus_0355", Text = "Wouldn't you know it." },
		{ Cue = "/VO/Polyphemus_0356", Text = "{#Emph}Tsch. Hrm." },
		{ Cue = "/VO/Polyphemus_0357", Text = "Step right up." },
		{ Cue = "/VO/Polyphemus_0511", Text = "...Think I {#Emph}smell {#Prev}her...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0512", Text = "...We'll pick this up later...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "SessionMapState", "MedeaAlreadyPresent" },
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0513", Text = "...Let me get back to you...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "SessionMapState", "MedeaAlreadyPresent" },
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0467", Text = "Oh, somethin's up...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0469", Text = "What a night...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0470", Text = "More witches?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutShrine02" },
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0471", Text = "More witches.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutShrine02" },
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0472", Text = "Two witches now...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "PolyphemusAboutShrine02" },
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0473", Text = "More company.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0358", Text = "Finally back.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered" },
					SumOf = { "N_Boss01", "N_Boss02" },
					Comparison = ">=",
					Value = 8,
				},
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
					Path = { "BiomesReached", "N" },
					CountPathTrue = true,
					Comparison = "==",
					Value = 0,
				},
			}
		},
		{ Cue = "/VO/Polyphemus_0359", Text = "'Bout time.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered" },
					SumOf = { "N_Boss01", "N_Boss02" },
					Comparison = ">=",
					Value = 8,
				},
				-- not seen him in the previous run or run before
				{
					SumPrevRuns = 3,
					IgnoreCurrentRun = true,
					Path = { "BiomesReached", "N" },
					CountPathTrue = true,
					Comparison = "==",
					Value = 0,
				},
			}
		},
		{ Cue = "/VO/Polyphemus_0360", Text = "{#Emph}Aw{#Prev}, I missed ya.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered" },
					SumOf = { "N_Boss01", "N_Boss02" },
					Comparison = ">=",
					Value = 10,
				},
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
					Path = { "BiomesReached", "N" },
					CountPathTrue = true,
					Comparison = "==",
					Value = 0,
				},
			}
		},
		{ Cue = "/VO/Polyphemus_0200", Text = "Nap time already?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Polyphemus" },
					Comparison = ">=",
					Value = 5,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Polyphemus" },
					Comparison = "<=",
					Value = 0,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0201", Text = "{#Emph}<Sniff> Ah..." },
	},
}

GlobalVoiceLines.PolyphemusSummonVoiceLines =
{
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.75,
		SuccessiveChanceToPlayAll = 0.75,
		ObjectType = "Medea",
		GameStateRequirements =
		{
			--
		},
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 16 },
		},

		{ Cue = "/VO/Medea_0432", Text = "The dead rise..." },
		{ Cue = "/VO/Medea_0433", Text = "Welcome, everyone...!" },
		{ Cue = "/VO/Medea_0434", Text = "I can raise a few...!" },
		{ Cue = "/VO/Medea_0435", Text = "I think I know that one..." },
		{ Cue = "/VO/Medea_0436", Text = "Look who's back..." },
		{ Cue = "/VO/Medea_0437", Text = "By the dark..." },
		{ Cue = "/VO/Medea_0438", Text = "Sprouting like weeds..." },
		{ Cue = "/VO/Medea_0439", Text = "{#Emph}Dead souls, arise...!", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.95,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "Polyphemus",
		TriggerCooldowns = { "CyclopsSpokeRecently" },
		Cooldowns =
		{
			{ Name = "CyclopsSummonSpeech", Time = 45 },
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">=",
				Value = 0.15,
			},
		},

		{ Cue = "/VO/Polyphemus_0264", Text = "I'll wake the dead!" },
		{ Cue = "/VO/Polyphemus_0265", Text = "Wake up down there!" },
		{ Cue = "/VO/Polyphemus_0266", Text = "Rise up you good-for-nothings!" },
		{ Cue = "/VO/Polyphemus_0267", Text = "Here's some of my pals." },
		{ Cue = "/VO/Polyphemus_0361", Text = "Time to walk this off." },
		{ Cue = "/VO/Polyphemus_0362", Text = "Let's shake things up." },
		{ Cue = "/VO/Polyphemus_0363", Text = "Wake up down there!" },
		{ Cue = "/VO/Polyphemus_0365", Text = "This town's crawling." },
		{ Cue = "/VO/Polyphemus_0367", Text = "If I'm not sleeping, no one is." },
		{ Cue = "/VO/Polyphemus_0368", Text = "All right wake up, {#Emph}wake {#Prev}up." },
		{ Cue = "/VO/Polyphemus_0268", Text = "Having some {#Emph}friends {#Prev}over!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0269", Text = "Some friends over for dinner!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0270", Text = "This ought to keep you busy!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0271", Text = "Wake up, sleepyheads!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0364", Text = "You gotta meet some of the guys.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/Polyphemus_0366", Text = "Oh look the crop's come in.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		},
	},
}

GlobalVoiceLines.PolyphemusGrabbedPlayerVoiceLines =
{
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		-- SuccessiveChanceToPlay = 0.75,
		ObjectType = "Polyphemus",
		TriggerCooldowns = { "CyclopsSpokeRecently", "CyclopsLastStandReactionSpeech" },
		Cooldowns =
		{
			-- { Name = "CyclopsSpokeRecently", Time = 20 },
			{ Name = "CyclopsSpottedRecently", Time = 30 },
		},

		{ Cue = "/VO/Polyphemus_0033", Text = "{#Emph}Ah{#Prev}, there you are!" },
		{ Cue = "/VO/Polyphemus_0034", Text = "Got you." },
		{ Cue = "/VO/Polyphemus_0035", Text = "Got you!" },
		{ Cue = "/VO/Polyphemus_0036", Text = "Caught you." },
		{ Cue = "/VO/Polyphemus_0037", Text = "Caught out!" },
		{ Cue = "/VO/Polyphemus_0038", Text = "Found you!" },
		{ Cue = "/VO/Polyphemus_0039", Text = "Ah-{#Emph}ha!" },
		{ Cue = "/VO/Polyphemus_0042", Text = "There she is!" },
		{ Cue = "/VO/Polyphemus_0248", Text = "You're mine." },
		{ Cue = "/VO/Polyphemus_0249", Text = "What'd I tell you?" },
		{ Cue = "/VO/Polyphemus_0377", Text = "Got ya!" },
		{ Cue = "/VO/Polyphemus_0378", Text = "No you don't!" },
		{ Cue = "/VO/Polyphemus_0379", Text = "{#Emph}Ohh..." },
		{ Cue = "/VO/Polyphemus_0380", Text = "Hello!" },
		{ Cue = "/VO/Polyphemus_0381", Text = "{#Emph}Heh!" },
		{ Cue = "/VO/Polyphemus_0382", Text = "You're cooked." },
		{ Cue = "/VO/Polyphemus_0383", Text = "Just a quick bite!" },
		{ Cue = "/VO/Polyphemus_0384", Text = "Now..." },
		{ Cue = "/VO/Polyphemus_0385", Text = "{#Emph}Mm, mm." },
		{ Cue = "/VO/Polyphemus_0386", Text = "Snacktime." },
		{ Cue = "/VO/Polyphemus_0387", Text = "Quit squirmin'!" },
		{ Cue = "/VO/Polyphemus_0388", Text = "You're meat." },
	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0531", Text = "You... {#Emph}stink!" },
		{ Cue = "/VO/MelinoeField_0532", Text = "Get... {#Emph}off!" },
		{ Cue = "/VO/MelinoeField_0533", Text = "Let... {#Emph}go!" },
		{ Cue = "/VO/MelinoeField_0534", Text = "Not... {#Emph}this!" },
	}
}

GlobalVoiceLines.PolyphemusMiscGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Polyphemus",
	Cooldowns =
	{
		{ Name = "CyclopsSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Polyphemus_0272", Text = "What are you up to?" },
	{ Cue = "/VO/Polyphemus_0273", Text = "You disrespecting me?" },
	{ Cue = "/VO/Polyphemus_0275", Text = "I heard that..." },
	{ Cue = "/VO/Polyphemus_0278", Text = "Doing somethin' sneaky {#Emph}huh..." },
}
GlobalVoiceLines.PolyphemusGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.05,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0274", Text = "Picking my plants?" },
	},
	{ GlobalVoiceLines = "PolyphemusMiscGatherReactionVoiceLines" },
}

GlobalVoiceLines.PolyphemusPickaxeReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0279", Text = "I hear a pickaxe or somethin'?",	PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0280", Text = "Clanking away again..." },
	},
	{ GlobalVoiceLines = "PolyphemusMiscGatherReactionVoiceLines" },
}
GlobalVoiceLines.PolyphemusShovelReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.1,
		ObjectType = "Polyphemus",
		Cooldowns =
		{
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Polyphemus_0276", Text = "Are you... shoveling?", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0277", Text = "You're digging your own grave." },
	},
	{ GlobalVoiceLines = "PolyphemusMiscGatherReactionVoiceLines" },
}

OverwriteTableKeys( EnemyData, UnitSetData.Polyphemus )