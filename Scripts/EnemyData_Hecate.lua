UnitSetData.Hecate =
{
	Hecate =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},

		Portrait = "Portrait_Hec_Default_01",
		Groups = { "NPCs", "GroundEnemies", "FlyingEnemies" },
		SubtitleColor = Color.HecateVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 50,
		SpeakerName = "Hecate",
		FieldSpeakerName = "HecateField",
		LoadPackages = { "Hecate", },
		RunHistoryKilledByName = "NPC_Hecate_01",
		SpeechParams =
		{
			Radius = 1,
		},
		AnimOffsetZ = 0,
		CreateAnimations =
		{
			"HecateGroundGlow",
		},

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		MaxHealth = 6050,
		AISetupDelay = 0.2, -- this delays the weapon firing off after the narrative sequence, please don't change

		SetupEvents =
		{
			{
				FunctionName = "SetupHecateBossIntroTextLines",
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					MaxHealth = 7250,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 800,
								Window = 1.0,
								MaxComboBreakers = 1,
								ComboBreakerCooldown = 9.5,
								ForcedWeaponInterrupt = "HecateComboBreakerSplit",
								Requirements =
								{
									HasEffectFalse = "HecateDarkSide",
								}
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
							Value = 1,
						},
					},
				},
			},
		},
		BossDifficultyShrineRequiredCount = 1,

		SpeechCooldownTime = 11,
		OnDeathFunctionName = "HecateKillPresentation",
		OnDeathFunctionArgs = { Message = "BiomeClearedMessage", CameraPanTime = 0.3, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", AddInterBiomeTimerBlock = true },
		DeathAnimation = "HecateBattleOutfitBattleOutro",
		LastHitAnimation = "HecateLastHit",
		InvulnerableFx = "Invincibubble_Hecate",
		ClearChillOnDeath = true,

		StopAnimationsOnDeath = { "HecateSpellChargeFx" },

		Material = "Organic",
		HealthBarTextId = "Hecate_Full",
		AltHealthBarTextIds =
		{
			{ TextId = "Hecate_AltFight01",
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
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,
		DefaultAIData =
		{
			DashRequireLoS = true,
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

		Using = {
			GrannyModel = { "WeaponHecateR_HecateScale_Mesh", "WeaponHecateL_HecateScale_Mesh", "WeaponHecateMultiple_Mesh", "WeaponHecateR_Mesh", },
			Animation = { "HecateTransformFlame", "HecateTransformFlameDark" },
			},

		PreBossAISetupFunctionName = "HecateBattleStart",
		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					DataOverrides =
					{
						ForcedNextWeapon = "HecateDarkSideTransform",
						ComboBreakersUsed = 0,
					},
					EquipWeapons =
					{
						"HecateEM_MeleeCombo", "HecateTeleport2"
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
			},
			-- Phase 1 Interlude
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HecateStageTransition1",
				EMStageDataOverrides =
				{
					SpawnEncounter = "HecateEMSpawns01",
					MidPhaseWeapons =
					{
						"HecateMeteorShower_EM",
						"HecateMeteorSmallShower_EM",
						"HecateRangedTorchesRingPhase_EM",
						"HecateRangedTorchesSpiralsPhase_EM",
						"HecateLaser_EM",
						"HecateRangedTorchesConePhase_EM",
					},
				},
				SpawnEncounter = "HecateSpawns01",
				WipeEnemyTypes = { "HecateCopy", "HecateCopyEM" },
				NewVulnerability = false,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				WaitDuration = 0.0,
				UnequipAllWeapons = true,
				MidPhaseWeapons = { "HecateMeteorShower", "HecateMeteorSmallShower", "HecateRangedTorchesRingPhase", "HecateRangedTorchesSpiralsPhase", "HecateLaser", "HecateRangedTorchesConePhase" },
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					DataOverrides =
					{
						ForcedNextWeapon = "HecateEMSplit",
						ComboBreakersUsed = 0,
					},
					EquipWeapons =
					{
						"HecateEM_MeleeCombo", "HecateTeleport2", "HecateWolfHowl", "HecateDarkSideTransform",
					},
					ExpireProjectiles = { "HecateMeleeCone_EM", },
				},
				TransitionFunction = "BossStageTransition",
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
				WaitDuration = 0.5,
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "HecateMeleeCombo1", "HecateMelee1", "HecateSplit2", "HecateRangedTorchesRing" },
			},
			-- Phase 2 Interlude
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HecateStageTransition2",
				EMStageDataOverrides =
				{
					SpawnEncounter = "HecateEMSpawns02",
					EquipWeapons = { "HecatePolymorph_EM" },
				},
				SpawnEncounter = "HecateSpawns02",
				WipeEnemyTypes = { "HecateCopy", "HecateCopyEM" },
				NewVulnerability = false,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				WaitDuration = 0.0,
				UnequipAllWeapons = true,
				EquipWeapons = { "HecatePolymorph" },
			},
			-- Phase 3
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					DataOverrides =
					{
						ForcedNextWeapon = "HecateEMSplit",
						ComboBreakersUsed = 0,
					},
					ExpireProjectiles = { "HecateMeleeCone_EM", },
					EquipWeapons =
					{
						"HecateEM_MeleeCombo", "HecateTeleport2", "HecateWolfHowl", "HecateDarkSideTransform", "HecateRangedTorchesCone",
					},
				},
				TransitionFunction = "BossStageTransition",
				StartDelay = 0.0,
				WaitDuration = 0.5,
				NewVulnerability = true,
				PlaySound = "/SFX/InvincibubbleBreak",
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
				{ Name = "HecateSpokeRecently", Time = 18 },
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
					{ Name = "HecateLastStandReactionSpeech", Time = 30 },
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
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = {
						"HecatePolymorph"
					},
				},
				ChanceToPlay = 0.25,
			},
			Cooldowns =
			{
				{ Name = "HecateSpokeRecently", Time = 18 },
			},

			{ Cue = "/VO/Hecate_0118", Text = "I'm afraid not." },
			{ Cue = "/VO/Hecate_0119", Text = "Felt not a thing." },
			{ Cue = "/VO/Hecate_0120", Text = "Irrelevant!" },
			{ Cue = "/VO/Hecate_0121", Text = "Control yourself." },
			{ Cue = "/VO/Hecate_0122", Text = "I think not." },
			{ Cue = "/VO/Hecate_0123", Text = "Try something else!", PlayFirst = true },
			{ Cue = "/VO/HecateField_0056", Text = "You strike to no avail." },
			{ Cue = "/VO/HecateField_0057", Text = "You cannot pierce my wards.", PlayFirst = true },
			{ Cue = "/VO/HecateField_0058", Text = "Back off." },
			{ Cue = "/VO/HecateField_0059", Text = "Conserve your strength." },
		},
		ResistedVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "EffectName", },
						IsNone = { "HecatePolymorphStun" },
					},
				},
				Cooldowns =
				{
					{ Name = "HecateResistReactionSpeech", Time = 40 },
				},
				TriggerCooldowns = { "HecateSpokeRecently" },

				{ Cue = "/VO/HecateField_0219", Text = "I'll keep this form, thank you.", PlayFirst = true },
				{ Cue = "/VO/HecateField_0220", Text = "{#Emph}Bah." },
				{ Cue = "/VO/Hecate_0118", Text = "I'm afraid not." },
				{ Cue = "/VO/Hecate_0119", Text = "Felt not a thing." },
				{ Cue = "/VO/Hecate_0120", Text = "Irrelevant!" },
				{ Cue = "/VO/Hecate_0122", Text = "I think not." },
				{ Cue = "/VO/Hecate_0123", Text = "Try something else!" },
				{ Cue = "/VO/HecateField_0056", Text = "You strike to no avail." },
				{ Cue = "/VO/HecateField_0384", Text = "That shall not work on me." },
				{ Cue = "/VO/HecateField_0385", Text = "Not at my age!" },
				{ Cue = "/VO/HecateField_0386", Text = "I cannot change {#Emph}that {#Prev}easily.", PlayFirst = true },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "EffectName", },
						IsAny = { "HecatePolymorphStun" },
					},
				},
				TriggerCooldowns = { "HecateSpokeRecently" },

				{ Cue = "/VO/HecateField_0070", Text = "Aren't you a cheeky one?" },
				{ Cue = "/VO/HecateField_0068", Text = "Truly now?", PlayFirst = true },
			},
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/HecateField_0396", Text = "{#Emph}Move it{#Prev}, frog!", PlayFirst = true },
				{ Cue = "/VO/HecateField_0397", Text = "That frog..." },
				{ Cue = "/VO/HecateField_0398", Text = "You and your frog..." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				-- { Cue = "/VO/HecateField_0387", Text = "Flap away, raven." },
				{ Cue = "/VO/HecateField_0388", Text = "This bird." },
				{ Cue = "/VO/HecateField_0389", Text = "Daring little bird...", PlayFirst = true },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/HecateField_0235", Text = "Back off, cat.", PlayFirst = true },
				{ Cue = "/VO/HecateField_0236", Text = "This {#Emph}cat..." },
				{ Cue = "/VO/HecateField_0237", Text = "Cat...?" },
				{ Cue = "/VO/HecateField_0238", Text = "Blasted cat..." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/HecateField_0390", Text = "Good girl, Hecuba!" },
				{ Cue = "/VO/HecateField_0391", Text = "Show your fangs!" },
				{ Cue = "/VO/HecateField_0392", Text = "Good hound!", PlayFirst = true },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					{ Name = "HecateSpokeRecently", Time = 16 },
				},

				{ Cue = "/VO/HecateField_0393", Text = "Gale, that I felt!" },
				{ Cue = "/VO/HecateField_0394", Text = "You dare, Gale?", PlayFirst = true },
				{ Cue = "/VO/HecateField_0395", Text = "Vicious polecat!" },
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
				{ Name = "HecateSpokeRecently", Time = 22 },
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
				{ Name = "HecateSpokeRecently", Time = 22 },
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
			{ Cue = "/VO/HecateField_0445", Text = "Hold! That was quick...!",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
			},
			{ Cue = "/VO/HecateField_0446", Text = "Hold! Short work...!",
				PlayFirst = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
			},
			{ Cue = "/VO/HecateField_0447", Text = "Hold! Swiftly done!",
				PlayFirst = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
			},
			{ Cue = "/VO/HecateField_0448", Text = "Hold! 'Twas nigh unfair...",
				PlayFirst = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				}
			},
			{ Cue = "/VO/HecateField_0449", Text = "Hold! I think you won...!",
				PlayFirst = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				}
			},
			{ Cue = "/VO/HecateField_0450", Text = "Hold! Flawless form.",
				PlayFirst = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				}
			},
			{ Cue = "/VO/HecateField_0451", Text = "Hold! I was outmatched...!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				}
			},
			{ Cue = "/VO/HecateField_0452", Text = "Hold! {#Emph}Whew! {#Prev}Good.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				}
			},
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				{ Cue = "/VO/HecateField_0271",
					Text = "'Twas not a compliment, merely a point of fact. Though I would see firsthand a demonstration of your capability." },
				{ Cue = "/VO/Melinoe_1171", UsePlayerSource = true,
					PreLineWait = 0.35,
					Text = "My capability? You'd have us face each other here... even though my task has already begun?" },
				{ Cue = "/VO/Hecate_0438",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your training shall never be complete. And I would know if you stand any chance at all against our enemy." },
			},

			HecateBossAboutRage01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = ">",
						Value = 0,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Hecate" },
					},
				},

				{ Cue = "/VO/HecateField_0341",
					Text = "Are you better prepared this time? Look at yourself, you are {#Emph}too calm. {#Prev}Suppressing your anger for the illusion of control." },
				{ Cue = "/VO/MelinoeField_4301", UsePlayerSource = true,
					Text = "You've taught me patience, Headmistress. But now you ask me to lash out at you in rage. Which shall it be?" },
				{ Cue = "/VO/HecateField_0342",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Give me both: rage, which you can {#Emph}control. {#Prev}Leave the serenity to our Sister the Moon, and {#Emph}fight me properly!" },
			},

			HecateBossAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "HecateAboutSelene01" },
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord" },
						HasAny =
						{
						 	"WeaponSpellLaser",
						 	"WeaponSpellPolymorph",
						 	"WeaponSpellSummon", 
						 	"WeaponSpellTimeSlow",
						 	"WeaponSpellPotion",
						 	"WeaponSpellMeteor",
						 	"WeaponSpellTransform",
						 	"WeaponSpellLeap",
						},
					},
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "F_Boss01", "F_Boss02" },
						Comparison = ">=",
						Value = 3,
					},

				},
				{ Cue = "/VO/Hecate_0076",
					Text = "Sister Selene aided you in getting here to me. But have you learned to harness her power?" },
				{ Cue = "/VO/Melinoe_0160", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp" },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sister Artemis appears quite well, so much as possible of late. If anything, she seems in better spirits than before." },
				{ Cue = "/VO/Hecate_0428",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Good. She, Selene, you, and I have all prepared for this contingency, and now 'tis time we shine... particularly you and I, right now." },
			},
			HecateBossAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0287",
					Text = "Athena deigned to grace these woods of ours, has she? Perhaps a mere projection of her power now that you and she have built up more of a working relationship." },
				{ Cue = "/VO/MelinoeField_3476", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Her Gorgon Amulet lets her locate me almost anywhere, though she can never stay for very long. I hate to inconvenience her." },
				{ Cue = "/VO/HecateField_0288",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "She would not bother if she deemed you unworthy. Whilst her power may be limited beyond Olympus, I shall not underestimate it here." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
				},
				{ Cue = "/VO/HecateField_0007",
					Text = "A chill swept through the air as you approached. Unseasonably cold; though perhaps it is as Demeter desires. She aids you, does she not?" },
				{ Cue = "/VO/MelinoeField_0007", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutDemeter01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HecateBossAboutDemeter01" }, Min = 2 },
					},
				},
				{ Cue = "/VO/HecateField_0009",
					Text = "I sense that Demeter is with you once again. I suspected she would either be among the first to lend support, or to refuse." },
				{ Cue = "/VO/MelinoeField_0008", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Hecate_0078",
					Text = "Our enemy's strength even exceeds my own. We're both Titans, yes, Chronos and I, but he is my elder... as I am yours. What say you?" },
				{ Cue = "/VO/Melinoe_0161", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/Melinoe_2136", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			HecateBossAboutChronosBossW00 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutChronosBossW01", "HecateAboutChronosBossW02", "HecateAboutChronosBossW03", },
					},
				},
				{ Cue = "/VO/HecateField_0293",
					Text = "You bested our enemy, and now are eager to reach him again. As much as I am curious to know more, you must have your reasons for withholding the details." },
				{ Cue = "/VO/MelinoeField_3481", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can hardly believe what happened, much less explain it. But, it went largely the way you expected, Headmistress. I apologize for not informing you." },
				{ Cue = "/VO/HecateField_0294",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Never apologize when you are not at fault. Speak no more of this than necessary, not to me or anyone. And press on." },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos seems to think my family bond with him is why I'm able to resist. He hasn't made the connection that {#Emph}you're {#Prev}the one who's prepared me." },
				{ Cue = "/VO/HecateField_0128",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}You {#Prev}have prepared {#Emph}yourself. {#Prev}'Tis good that you are drawing his attention and his wrath, whilst I remain unseen. We slowly undermine his strength... and through our efforts, buy your mountain relatives more time." },
			},

			HecateBossAboutEndingPath00 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossAboutEndingPath01", "ZagreusPastMeeting02_2" },
					},
					{
						SumPrevRuns = 3,
						-- IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "I_Intro" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/HecateField_0418",
					Text = "Trust in your training, ere you reach your destination at the House. That and your connection to Chronos affords you some degree of control over his abilities... an unwitting inheritance he gave to you." },

				{ Cue = "/VO/MelinoeField_5185", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My knowledge of dream, his command over Time... a potent combination, but one I know I must approach with a great deal of caution and respect." },

				{ Cue = "/VO/HecateField_0419",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Approaching matters with caution and respect shall rarely lead you astray. I shall await word of whatever it is you discover... and whether our plans may come to pass." },
			},

			HecateBossAboutEndingPath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						-- IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting02" },
					},
				},
				{ Cue = "/VO/HecateField_0297",
					Text = "{#Emph}To the abyss of the subconscious I descend... {#Prev}remember well those words and those that follow, lest the thrill of battle cloud your memory." },
				{ Cue = "/VO/MelinoeField_3483", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}To the abyss of the subconscious I descend. Night and Darkness, guide me to my blood beyond the grasp of Time." },
				{ Cue = "/VO/HecateField_0298",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "A potent prayer, although here it shall avail you not. Perhaps you soon shall have the opportunity to make the invocations in the proper place and time." },
			},

			HecateBossAboutEndingPath02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting02_2" },
					},
				},
				{ Cue = "/VO/MelinoeField_5098", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I've told my brother of what Chronos has done... but he expressed reluctance about having to destroy a member of our family. He even... suggested Father may be partly to blame." },

				{ Cue = "/VO/HecateField_0421",
					Text = "A complication. Your brother never was keen on taking direction, especially from your father. And now he's filling your own head with doubt. We have no recourse here, Melinoë. Persuade him, or all shall be for naught." },

				{ Cue = "/VO/MelinoeField_5099", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "He also asked me what exactly happened between Chronos and my father, and... I realized I didn't know. Does anyone? This war he's waged... it isn't merely over who should rule." },

				{ Cue = "/VO/HecateField_0422",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Their precise history is of no bearing to our present state. In war, one would be wise to not give undue credit to one's enemies. If you spend all your time so deep in thought, then you shall hesitate to act... and your moment shall pass!" },
			},
			HecateBossAboutEndingPath03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_2" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},
				{ Cue = "/VO/HecateField_0424",
					Text = "Tell me, ere we clash again: Has your brother come to understand yet the necessity of his participation in your task?" },

				{ Cue = "/VO/MelinoeField_5100", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "It's been a bit of a struggle. He's found a suitable weapon in our father's spear... but he hasn't granted me its essence yet." },

				{ Cue = "/VO/HecateField_0425",
					Text = "Then tell him what he needs to hear, if that is what it takes to spur him on. I do not like having to count on him any more than you, but... his cooperation is an absolute necessity." },

				{ Cue = "/VO/MelinoeField_5101", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I need more than his cooperation... I need his trust. I'm not going to deceive him, if that's what you suggest." },

				{ Cue = "/VO/HecateField_0426",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I suggest {#Emph}nothing. {#Prev}The task is yours, as are the methods you employ to achieve it. But, {#Emph}achieve it!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/MelinoeField_5102", Text = "I intend to!" },
					},
				},
			},
			HecateBossAboutEndingPath04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusPastMeeting04_2", "ZagreusPastMeeting04_3" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutUltimateProgress04" }
					},
				},

				{ Cue = "/VO/Melinoe_5731", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Zagreus and I finally reached an understanding. He knows what needs to be done... but, I wanted to ask you something, Headmistress. With Chronos, in the past... there's truly no other course but to destroy him?" },

				{ Cue = "/VO/Hecate_0942",
					Text = "{#Emph}Oh{#Prev}, blood and darkness, he's got to you, hasn't he? Your brother at least, if not Chronos himself. Why are you asking me such things when you have come so close to the completion of your task, Melinoë?" },

				{ Cue = "/VO/Melinoe_5732", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, for one... we're on the verge of destroying Time itself. For all you've taught me, I've never fully understood the repercussions this would have." },

				{ Cue = "/VO/Hecate_0943",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We cannot know such repercussions ere they come to pass. Our charge, {#Emph}your {#Prev}charge, is to stop Chronos. Whatever it takes. I trust you shall require no additional reminders?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_5733", Text = "...None." },
					},
				},
			},

			HecateBossAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutFates01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3477", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lately I dreamt of Father once again, when Chronos came for him, and you took me to safety. Except this time, I saw more than before..." },

				{ Cue = "/VO/HecateField_0289",
					Text = "Twas no mere dream, of course. What more did you learn whilst you lingered thus?" },

				{ Cue = "/VO/MelinoeField_3478", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos demanded Father tell him how to locate the Three Fates. Chronos hates them, or feels threatened by them. He was searching for them all this time... and must have found them finally." },

				{ Cue = "/VO/HecateField_0290",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Blast... {#Prev}Hermes suspected that this was the case, but has been unable to prove it beyond doubt. For now, let us proceed as though the Fates themselves oppose us; as though we've nobody to count on save ourselves." },
			},

			-- alt below
			HecateBossAboutTyphonFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Hecate_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
							"HecateAboutTyphonFight01",
							"HecateAboutTyphonFight01_B",
							-- "HecateBossAboutTyphonFight01",
							"HecateBossAboutTyphonFight01_B",
							"HecateAboutTyphonFight03",
							"HecateAboutTyphonFight03_B",
							"HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 2,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = "<=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Hecate_0751",
					Emote = "PortraitEmoteFiredUp",
					Text = "Has the thin air upon that mountain made you mad, Melinoë? Confronting Typhon of all creatures face to face! Hermes told me everything. Save what was going through your head." },
				{ Cue = "/VO/Melinoe_4042", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was not about to turn my back on my family, especially not after having come so far. What should I have done, flee at the first sight of that monster? We flee only as a last resort." },
				{ Cue = "/VO/Hecate_0752_B",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That we do. And you had best keep reminding yourself of it ere you confront the Father of All Monsters again. Do not take unnecessary risks, or lose sight of the task." },
			},
			HecateBossAboutTyphonFight01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Hecate_01" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
							"HecateAboutTyphonFight01",
							"HecateAboutTyphonFight01_B",
							"HecateBossAboutTyphonFight01",
							-- "HecateBossAboutTyphonFight01_B",
							"HecateAboutTyphonFight03",
							"HecateAboutTyphonFight03_B",
							"HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = "<=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Hecate_0751",
					Emote = "PortraitEmoteFiredUp",
					Text = "Has the thin air upon that mountain made you mad, Melinoë? Confronting Typhon of all creatures face to face! Hermes told me everything. Save what was going through your head." },
				{ Cue = "/VO/Melinoe_4043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's much, much larger than any other foe I've faced, but that doesn't make him invincible. I suspected he'd have a difficult time contending with a small, quick adversary." },
				{ Cue = "/VO/Hecate_0753_B",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I would commend you for the outcome were I not so utterly aghast. The Father of All Monsters may not be quite so easy to surprise ere you confront him again. Do not take unnecessary risks, or lose sight of the task!" },
			},
			HecateBossAboutTyphonFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						SumPrevRuns = 4,
						-- IgnoreCurrentRun = true,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					-- Surface run on PrevRun, the run before that, and the run before that; CurrentRun is ignored (would return false)
					{
						SumPrevRuns = 3,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/HecateField_0274",
					Text = "Had your fill of Olympus for a while? Surpassing me here must be far less burdensome than having to gouge all of Typhon's eyes." },
				{ Cue = "/VO/MelinoeField_3158", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's positively pleasant by comparison. But I'll get back to dealing with the Father of All Monsters soon enough." },
				{ Cue = "/VO/HecateField_0275",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then gather what strength you can in the meantime. For now, the Underworld awaits; but I yet hold the key." },
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
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = "<",
						Value = 30,
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
					},
				},
				{ Cue = "/VO/Hecate_0193",
					Text = "Your aura is different. Stronger. You have been studying the Arcana. Meditating at your Altar to prepare for your attempts." },
				{ Cue = "/VO/Melinoe_0581", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Hecate_0080",
					Text = "Forgive my bluntness but you're in a rather sorry-looking state, Witch. 'Tis unfair for me to fight you whilst I am at my best and you are not." },
				{ Cue = "/VO/Melinoe_0157", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Hecate_0082",
					Text = "You've suffered injuries, Melinoë. You know that I can cure them for you, and you know that I shall not. Not here. It brings me no pleasure." },
				{ Cue = "/VO/Melinoe_0158", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/Hecate_0084",
					Text = "Your wounds give me the upper hand, Melinoë. What hope have you of ever finding our enemy in such a state?" },
				{ Cue = "/VO/MelinoeField_0002", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" }
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
					Text = "I trust the dark of Erebus was not too much to handle with the ever-burning Flames of Ygnium to light your path?" },
				{ Cue = "/VO/Melinoe_1034", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HecateBossAboutTorch01" }, Min = 3 },
					},
				},
				{ Cue = "/VO/HecateField_0112",
					Text = "The Umbral Flames of Ygnium, at your command! You use them in your own way; not merely copy my technique." },
				{ Cue = "/VO/MelinoeField_0506", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "AxePerfectCriticalAspect", "AxeRallyAspect" },
					},
				},
				{ Cue = "/VO/HecateField_0108",
					Text = "Now that's a sight, you bearing down on me with that gigantic Moonstone Axe! I wasn't certain you'd prefer that one." },
				{ Cue = "/VO/MelinoeField_0504", UsePlayerSource = true,
					Text = "Zorephet is weightier than the other Arms. But having an axe such as this in woods such as these has been convenient, overall." },
				{ Cue = "/VO/HecateField_0109",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well, much as I hate to {#Emph}inconvenience {#Prev}you, I must. Although, that monstrous thing suggests this oughtn't take too long..." },
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
			HecateBossAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
				},
				{ Cue = "/VO/HecateField_0255",
					Text = "The Black Coat you now possess... surrounding you as though 'twas forged with you in mind. I feared that it was broken and beyond repair, but... it was merely waiting." },
				{ Cue = "/VO/MelinoeField_2857", UsePlayerSource = true,
					Text = "Waiting for me... I've never wielded anything like it. Xinth doesn't exactly listen to my thoughts, but heeds my every instinct." },
				{ Cue = "/VO/HecateField_0256",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not your {#Emph}every {#Prev}instinct; the Arms of Night have a singular purpose, which they go about each in their own peculiar respect. You are to execute that purpose without fail." },
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
			HecateBossAboutEosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
				},
				{ Cue = "/VO/HecateField_0291",
					Text = "That form of Ygnium is rather fetching! You could always decorate the Crossroads with those lights should they not prove sufficiently dependable for your task." },
				{ Cue = "/VO/MelinoeField_3480", UsePlayerSource = true,
					Text = "The Aspect of Eos is not as delicate as it appears. Though I'll admit I half-expected that this Aspect of the Flames would be your own." },
				{ Cue = "/VO/HecateField_0292",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nonsense. If I myself wielded those very torches, {#Emph}you {#Prev}would not be bearing them. Now come remind me what the rosy flickering of Dawn can do." },
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
				{ Cue = "/VO/MelinoeField_3479", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "So {#Emph}this {#Prev}is why Lord Charon has such definition in his arms. Do you suppose he used to row his boat with Zorephet?" },
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
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = ">=",
						Value = 2,
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
			HecateBossAboutWeaponAspects02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = ">=",
						Value = 18,
					},
				},
				{ Cue = "/VO/HecateField_0285",
					Text = "Each night, I wonder which of your forms I shall confront. Have you considered why so many different Aspects of the Nocturnal Arms are at your disposal?" },
				{ Cue = "/VO/MelinoeField_3475", UsePlayerSource = true,
					Text = "The bearers of the Arms safeguard the Underworld, but... I don't think they all could wield Aspects other than their own. Perhaps something about my task requires it." },
				{ Cue = "/VO/HecateField_0286",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Or perhaps the Arms have come to have affinity for you; not unlike a close companion who entrusts you with a secret that is never to be shared! Do not betray their confidence." },
			},

			HecateBossAboutHiddenAspects01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllHiddenAspects,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = GameData.AllHiddenAspects,
					},
				},
				{ Cue = "/VO/HecateField_0339",
					Text = "Each hidden Aspect of the Arms of Night is in your grasp, at least the ones that had been set aside for you. What have you surmised about their bearers?" },
				{ Cue = "/VO/MelinoeField_4300", UsePlayerSource = true,
					Text = "That they're all gods or goddesses of death or destruction. Some past, some future, others perhaps contemporaries but of realms other than our own. But, where...?" },
				{ Cue = "/VO/HecateField_0340",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Our realm is hidden; theirs may be as well. Besides, for as much of the world as you've seen, 'tis but a narrow swath. You have eternity to meet these other gods, or not." },
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
						Value = 7,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 8,
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
					Text = "Perhaps if I brought with me a legion of Animal Familiars next time, Headmistress? Not that any beast would bare its fangs at {#Emph}you." },
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
					Text = "You brought some company along! An unassuming choice. Your amphibious friend does not appear to have capacity to sway the outcome here." },
				{ Cue = "/VO/MelinoeField_2026", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I never trust appearances entirely, Headmistress, and know neither do you. This must be an exciting night for Frinos." },
				{ Cue = "/VO/HecateField_0163",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We are not here to entertain your woodland friends, Melinoë. Pray they don't get underfoot." },
			},
			HecateBossAboutRavenFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "RavenFamiliar" },
					},
				},
				{ Cue = "/VO/HecateField_0269",
					Text = "You have a raven friend with you! Birds seldom take to Erebus, if they can even make their way! A spy, I thought at first, but no. Perhaps Selene sent him down to you." },
				{ Cue = "/VO/MelinoeField_3155", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is Raki, whom I found in a secluded glade nearby all on his own. I know better than to trust inherently, though felt a strong connection to this one." },
				{ Cue = "/VO/HecateField_0270",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I likewise sense no ill intent from him. Our Familiars may take on a variety of forms, no different from our friends or enemies. Let's see how well this one keeps up!" },
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
				{ Cue = "/VO/HecateField_0338",
					Text = "That little cat there by your side, I noticed her within our Crossroads recently. Your power must be great indeed, to have persuaded her to follow you..." },
				{ Cue = "/VO/MelinoeField_2027", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Toula did take some convincing, Headmistress. But she seems to appreciate my company! At least, most of the time." },
				{ Cue = "/VO/HecateField_0165",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Moody creatures, cats; born huntresses but uncontrollable. I almost fear to see just what this little one can do! With hounds, at least I know exactly where I stand." },
			},
			HecateBossAboutHoundFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "HoundFamiliar" },
					},
				},
				{ Cue = "/VO/HecateField_0118",
					Text = "Look at that prim posture! We're in the presence of majestic Hecuba herself...! How fares my favored hound?" },
				{ Cue = "/VO/MelinoeField_0509", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She's very well, and a most-capable companion to have at my side. Though I hate to have to strain her loyalties like this." },
				{ Cue = "/VO/HecateField_0119",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Come, you want to see what she shall do! Her loyalty is absolute. I permitted her to serve you as she serves me! Let's all now bare our fangs." },
			},
			HecateBossAboutPolecatFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "PolecatFamiliar" },
					},
				},
				{ Cue = "/VO/HecateField_0114",
					Text = "Why, if it isn't little Gale scurrying about your feet! {#Emph}Ah{#Prev}, how the tables have turned. Her vengeance finally is nigh!" },
				{ Cue = "/VO/MelinoeField_0507", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You jest, Headmistress, but I put poor Gale in a terrible position here, to have to square against you. Can't she refuse to be a part of this?" },
				{ Cue = "/VO/HecateField_0115",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "She is to do your bidding when required, and besides, I do think she is going to enjoy this. I let you go all-out; same goes for {#Emph}her." },
			},

			-- arachne curse subplot
			HecateBossAboutArachne01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutArachne01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AthenaAboutArachne03" },
					},
				},
				{ Cue = "/VO/HecateField_0018",
					Text = "You are preoccupied with that Arachne's curse! I know about it, yes. The remedy is no straightforward feat." },

				{ Cue = "/VO/MelinoeField_2877", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nor is my task, yet here we are, night after night. If there's a way to aid my friend, I wish to know of it." },

				{ Cue = "/VO/HecateField_0019",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Athena is the one to persuade; so long as she wishes for the curse to remain, it shall. That, and you must discover who created it." },
					
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2878", Text = "Sounds straightforward enough!" },
				},
			},
			HecateBossAboutArachne02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "TextLinesRecord", "HecateWithArachne01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/MelinoeField_2879", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I appreciate your candor with Arachne, Headmistress. You must have known full well that she would not forgive you." },
				{ Cue = "/VO/HecateField_0020",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Far easier to beg forgiveness than to dole it out. As you grow longer in years, you, too, shall have relationships that cannot be repaired." },
			},

			HecateBossAboutArachneOutfit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllArachneCostumes,
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						HasAny = { "HecateBossAboutShrine01" },
					},
				},
				{ Cue = "/VO/HecateField_0122",
					Text = "Decided to forgo the Oath for now? A wise move, like as not. Or, evidence of some restraint and circumspection on your part, at least." },
				{ Cue = "/VO/MelinoeField_1511", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A little of each, Headmistress? Perhaps I made a terrible mistake. It's fortunate the Vows contained within the Oath can be undone... unlike most vows." },
				{ Cue = "/VO/HecateField_0125",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}All {#Prev}vows can be undone. But yes, the Oath is oddly forgiving in this way; its Vows, never strictly binding. Perhaps so that each evening may be interestingly different from the last." },
			},

			HecateBossAboutShrine04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateBossAboutShrine01" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyStaffHeat1FBoss",
							"BountySuitHeat2FBoss",
							"BountyLobHeat4FBoss",
							"BountyTorchHeat8FBoss",
							"BountyAxeHeat12FBoss",
							"BountyDaggerHeat16FBoss",

							"BountyShrineStaffFBoss",
							"BountyShrineDaggerFBoss",
							"BountyShrineTorchFBoss",
							"BountyShrineAxeFBoss",
							"BountyShrineLobFBoss",
							"BountyShrineSuitFBoss",
						},
					},
				},
				{ Cue = "/VO/HecateField_0299",
					Text = "The Testament of Night requires my defeat specifically, is that not so? The Titan Lord can wait; the key to making the Nocturnal Arms more powerful stands right in front of you." },
				{ Cue = "/VO/MelinoeField_3484", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know much more about the Oath of the Unseen than I, Headmistress. So why don't you tell me what it desires." },
				{ Cue = "/VO/HecateField_0300",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, I just did! Perhaps when you come to be my age, you too shall find a new connection to the Oath. For now, come earn the Nightmare that you seek." },
			},

			HecateBossAboutShrineUpgrade01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossGrantsShrineUpgrade01", "HecateGrantsShrineUpgrade01" }
					},
				},

				{ Cue = "/VO/HecateField_0276",
					Text = "The greatest teacher is out there, and evidently taught you quite a bit. You're able to surpass me here consistently. But has this proved to be enough...?" },
				{ Cue = "/VO/MelinoeField_3473", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There's always more to be learned, Headmistress; you taught me that yourself. If you believe that I'm prepared, why hesitate?" },
				{ Cue = "/VO/HecateField_0277",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Because your path toward mastery is yours alone; when you decide you are prepared for more, remember that the Oath of the Unseen is there for you. As am I." },
			},

			HecateBossAboutAltFight01 =
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

				{ Cue = "/VO/HecateField_0280",
					Text = "A frightful night... cold, and dark, and {#Emph}everything. {#Prev}You've spoken certain vows, and as the Moon is our witness, I too have spoken mine. Now we may clash in earnest finally." },
				{ Cue = "/VO/MelinoeField_3394", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "In earnest... so you {#Emph}have {#Prev}been holding back against me. You said you'd push me to my limits and beyond." },
				{ Cue = "/VO/HecateField_0281",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Our limits grow along with us. I know mine well enough by now; do you know yours? I am eager to find out for myself!" },
				EndVoiceLines =
				{
					PreLineWait = 2.5,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3395", Text = "Her Dark Side..." },
				},
			},
			HecateBossAboutAltFight02 =
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

				{ Cue = "/VO/HecateField_0283",
					Text = "You look upon the Oath of the Unseen night after night, but: Do you understand as yet the lesson it imparts?" },
				{ Cue = "/VO/MelinoeField_3397", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fear manifests at night. Either we give in to that fear, or we become its cause." },
				{ Cue = "/VO/HecateField_0284",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Either give in to fear or become its cause. {#Prev}Your words, not mine, though I concur with them. Let us become that fear for one another once again." },
			},

			HecateBossAboutAltFight03 =
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
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Hecate" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
					},
				},

				{ Cue = "/VO/HecateField_0320",
					Text = "Whether 'tis wise to speak the Vow of Rivals is for you to decide, but... I can see the wisdom in rescinding {#Emph}that {#Prev}one. I'd not wish to face me at my best, either." },
				{ Cue = "/VO/MelinoeField_4201", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I may not be finished with that Vow just yet, Headmistress. I wonder what else you're holding back, if you possess such power you suppress by will of Night alone." },
				{ Cue = "/VO/HecateField_0321",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Do wonder, by all means. And should you require more of an advanced test of your aptitude, I shall be waiting." },
			},

			HecateBossAboutErebus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Melinoe_1035", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Meaning you won't lift the wards barring the path to the surface. What if I remove them myself? I've seen how you do it." },
				{ Cue = "/VO/Hecate_0431",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then you'll be more prepared than you are now. Till then, remember your objective lies below. Past {#Emph}me." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeAltRunDoor" },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4840", Text = "{#Emph}Permeation of Witching-Wards..." },
				},
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						Path = { "PrevRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateTaverna02" },
					},
				},
				{ Cue = "/VO/Hecate_0302",
					Text = "You cannot beat me with anxiety, you know. Still your senses, and prepare yourself. Know you the purpose of these bouts of ours?" },
				{ Cue = "/VO/Melinoe_1036", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateTaverna02" },
					},
				},
				{ Cue = "/VO/HecateField_0158",
					Text = "Again you bear the Wheel I gave to you; rather, that I {#Emph}held {#Prev}for you ere you were ready, for it was always yours. A means of focusing your magickal acuity, if nothing else." },
				{ Cue = "/VO/MelinoeField_1997", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						Path = { "GameState", "LastAwardTrait" },
						IsAny = { "EscalatingKeepsake" },
					},
				},
				{ Cue = "/VO/HecateField_0171",
					Text = "{#Emph}Eugh...! {#Prev}Whatever foul Keepsake you decided to bring along for good fortune this eve, 'tis a horrid thing. Which sort of comrade would reward you thus?" },
				{ Cue = "/VO/MelinoeField_2028", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "N_Boss01", "N_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Hecate_0195",
					Text = "{#Emph}Hmm. {#Prev}I was beginning to think you had grown so fond of the surface that you would not be coming back here anytime soon." },
				{ Cue = "/VO/Melinoe_0654", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Our task takes me to the very ends of the Earth. I have unfinished business there as well as here. I'm much more comfortable in these environs, though." },
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
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Hecate_0308",
					Text = "Decided to take a break from all your recent outings to the surface, have you now?" },
				{ Cue = "/VO/Melinoe_1176", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There's much to be done, both above and below. You always say the greatest teacher is {#Emph}out there{#Prev}. But I always seem to find her here." },
				{ Cue = "/VO/Hecate_0309",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I taught you {#Emph}nothing {#Prev}of such flattery. One of Odysseus' tricks, perhaps...! Let's see what others you have learned." },
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
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = "<=",
						Value = 2,
					},
					{
						SumPrevRuns = 5,
						Path = { "EnemyKills", "Chronos" },
						Comparison = "<=",
						Value = 1,
					},
					{
						SumPrevRuns = 5,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 1,
					},
					{
						Path = { "PrevRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Melinoe_2138", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossAboutShrineUpgrade01" }
					},
				},
				{ Cue = "/VO/Hecate_0433",
					Text = "You surpassed me before, yet I wonder: Was it your mastery over our craft, or did the Fates themselves perhaps provide a little {#Emph}nudge?" },
				{ Cue = "/VO/Melinoe_1600", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
			HecateBossQuickMatch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "PrevRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "PrevRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0295",
					Text = "When last we fought like this, I posed no real threat to you at all, I know. But your enemies are stubborn; there is nothing you can do to make us stay out of your way." },
				{ Cue = "/VO/MelinoeField_3482", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All the more reason I would like to make this quick. Though if I'm in a different mood perhaps I'll make things go profoundly worse with just a few Vows from the Oath." },
				{ Cue = "/VO/HecateField_0296",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Each night has something of its own to offer. Whether you are concentrating on your swiftness or your strength, ensure you're using well this time we have." },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I got here as quickly as I could, Headmistress. And still you had to wait." },
				{ Cue = "/VO/Hecate_0073",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "To wait is the practice of patience. Now, on to other practices, I think." },
			},
			HecateBossAboutRespect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},

				{ Cue = "/VO/Hecate_0074",
					Text = "Set your respect for me aside whilst here. You must give no such quarter to our enemies." },
				{ Cue = "/VO/Melinoe_0040", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01", PostLineAnimTarget = "Hero",
					Text = "But you are not my enemy, Headmistress. How am I to treat you as one?" },
				{ Cue = "/VO/Hecate_0075",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}How? {#Prev}Allow me to give you a demonstration, then." },
			},
			HecateBossAboutRepetition01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "F_Boss01", "F_Boss02" }, Count = 3 },
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/MelinoeField_3156", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, why is it that we have to keep this up? I've passed your test repeatedly; we're each needed elsewhere." },
				{ Cue = "/VO/HecateField_0272",
					Text = "You may be strong but not yet strong enough! And evidently quite impatient, too. Shall you attempt to talk Chronos out of a fight as well?" },
				{ Cue = "/VO/MelinoeField_3157", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course not, but... I could be halfway to the Mourning Fields by now, if not for this." },
				{ Cue = "/VO/HecateField_0273",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Alas that things don't always go our way. Go on now, vent the anger that you feel! We each have much of it to spare." },
			},

			HecateBossPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/HecateField_0330",
					Text = "Everything as it once was, yet nothing is the same! A feeling I know only too well. It seems we are to prolong your training for a while..." },
				{ Cue = "/VO/MelinoeField_4121", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My training shall never be complete, isn't that right? Although it's odd to think that following my prior steps to Tartarus shall help maintain the proper course of Time..." },
				{ Cue = "/VO/HecateField_0331",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Whether we truly possess the capability to maintain Time remains to be seen! But we can at least maintain ourselves." },
			},
			HecateBossPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll =
						{
							"NeoChronosAboutTartarus02",
							"NeoChronosAboutOlympus02",
							"ChronosBossOutroPostTrueEnding01",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutErebus01" },
					},
				},

				{ Cue = "/VO/HecateField_0332",
					Text = "Your grandfather Chronos like as not awaits beyond this very threshold, where once he stalked that clearing as our bitter enemy. How has collaborating with him been?" },
				{ Cue = "/VO/MelinoeField_4202", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Unusual, I'd say... he's proven instrumental in eliminating the remnants of his past self. It must be very strange to face oneself in such a way." },
				{ Cue = "/VO/HecateField_0333",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "How very strange indeed. But if it works, I shall not question it too much. Perhaps we'll all learn more of the mysteries of Time ere this is ended." },
			},
			HecateBossPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" },
					},
				},

				{ Cue = "/VO/HecateField_0334",
					Text = "Tell me something now, Melinoë. Who is the fiercest enemy that you have overcome in all of this? Chronos? Typhon?" },
				{ Cue = "/VO/MelinoeField_4203", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know what you insinuate, Headmistress... Hecate. I got in my {#Emph}own {#Prev}way more than any of my foes. Save for you, perhaps, but that's more or less the same thing." },
				{ Cue = "/VO/HecateField_0335",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The limits we impose upon ourselves inhibit what we can achieve. Overcoming those limits is extraordinarily difficult. But, you have done it now... again, and again." },
			},
			HecateBossPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossPostEpilogue01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4387", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've had those flames for quite a while, haven't you, Hecate? Are they... from your place of origin?" },
				{ Cue = "/VO/HecateField_0336",
					Text = "They lighted my way in my youth, and even still. Care for your possessions, and they may last you a good while..." },
				{ Cue = "/VO/MelinoeField_4388", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I always wondered why none of the Aspects of the Nocturnal Arms I'd discovered were yours..." },
				{ Cue = "/VO/HecateField_0337",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Try not to dwell on it too much, lest it scatter your mind to no end. But yes, these flames and I do not truly belong. And for that very reason, I suspect the Fates figured me out." },
			},

			HecateBossAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutOlympus02" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				{ Cue = "/VO/HecateField_0343",
					Text = "Shall we continue with these clashes for eternity? 'Twould seem there are sufficient possibilities of Chronos to keep you occupied that long." },
				{ Cue = "/VO/MelinoeField_4302", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm in no hurry, Hecate. Besides, if I once dreaded having to confront you here, I came to enjoy it at some point." },
				{ Cue = "/VO/HecateField_0344",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I would prefer more frequent victories but I came to enjoy it in kind. Let us continue, then... for however long it takes." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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

			-- @ ending
			HecateBossKidnapped01 =
			{
				PlayOnce = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateKidnapping" },
					},
				},

				{ Cue = "/VO/Chronos_0973", Source = "NPC_Chronos_01",
					Text = "It seems the pathways into Erebus are not as well-protected as they used to be. I take it this here is the individual who pitted you against me, is this not?" },

				{ Cue = "/VO/MelinoeField_3873", UsePlayerSource = true,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Headmistress! Headmistress, fight him, {#Emph}fight! {#Prev}Fight back!!" },

				{ Cue = "/EmptyCue", Portrait = "Portrait_Hec_Frozen_01",
					Text = ". . . ." },

				{ Cue = "/VO/Chronos_0974", Source = "NPC_Chronos_01",
					Text = "This {#Emph}headmistress {#Prev}of yours has considerable knowledge, to have thus concealed you... but she is weary, such that {#Emph}Time {#Prev}caught up with her at last. She hears not a word you say." },

				{ Cue = "/VO/MelinoeField_3874", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Unhand her, wretch. Unhand her, or I'll tear you to pieces." },

				{ Cue = "/VO/Chronos_0975", Source = "NPC_Chronos_01",
					Text = "My own children tore me to pieces once before. Look where {#Emph}that {#Prev}got them! Whoever this is, perhaps she shall be more cooperative than you, although I am not particularly optimistic; nor should you be. Good evening!" },
				EndVoiceLines =
				{
					PreLineWait = 0.85,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3875", Text = "Come back! {#Emph}Augh!!" },
					PostLineFunctionName = "MuteSpeakerPermanent",
				},
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
						Comparison = ">",
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
						Comparison = ">",
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
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "F_Boss01", "F_Boss02" }, Count = 2 },
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
						Value = 5,
					},
				},
				{ Cue = "/VO/HecateField_0024",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "'Tis a new moon, and an opportunity for a new beginning. But first...!" },
			},
			HecateBossMiscStart24 =
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
			HecateBossMiscStart25 =
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
			HecateBossMiscStart26 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Hecate_0746",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "We witches oft are underestimated. But, I am well aware how capable you are." },
			},

			HecateBossMiscStart27 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
					},
				},
				{ Cue = "/VO/HecateField_0345",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "I can recall some of your many tricks whilst brandishing Descura there, though why don't you remind me?" },
			},
			HecateBossMiscStart28 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
				},
				{ Cue = "/VO/HecateField_0346",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "It's not my custom to let others rush at me with knives. But for you and Lim and Oros, {#Emph}anything." },
			},
			HecateBossMiscStart29 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				{ Cue = "/VO/HecateField_0347",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "So it's to be these old torches of mine against your own once more? I am quite partial to this clash." },
			},
			HecateBossMiscStart30 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				{ Cue = "/VO/HecateField_0348",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "These woods shall look more like a meadow soon as you keep swinging that old Moonstone Axe about..." },
			},
			HecateBossMiscStart31 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				{ Cue = "/VO/HecateField_0349",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "The Argent Skull, the very face of death... I daresay it shows the hint of a smile in our midst." },
			},
			HecateBossMiscStart32 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
				},
				{ Cue = "/VO/HecateField_0350",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Xinth the Black Coat once again tonight? Then I shall brace myself for impact, and suggest {#Emph}you {#Prev}do the same." },
			},
			HecateBossMiscStart33 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/HecateField_0351",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "We each have a Dark Side waiting to reveal itself. Now's as good a time as any to show {#Emph}mine." },
			},
			HecateBossMiscStart34 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
				},
				{ Cue = "/VO/HecateField_0352",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					Text = "Let us ensure that such a terrifying night is not to be forgotten by our witnesses." },
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
			HecateBossOutroAltFight01 =
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
				{ Cue = "/VO/HecateField_0282",
					PreLineWait = 0.35,
					Text = "...You've grown. There was a time you never could have stopped me had I used Dark Side against you thus. {#Emph}Hm." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3396", Text = "She still held something back..." },
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
					Text = "Do bring an Animal Familiar along next time, if but to keep things livelier for me! We have the means to keep them safe, even in scuffles such as these." },
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
						Value = 20,
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
						Value = 6,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf =
						{
							"WeaponStaffSwing",
							"WeaponDagger",
							"WeaponAxe",
							"WeaponTorch",
							"WeaponLob",
							-- purposely omitted
							-- "WeaponSuit",
						},
						Comparison = ">=",
						Value = 4,
					},
					--[[
					{
						Path = { "PrevRun", "WeaponsUnlocked" },
						HasNone = { "WeaponDagger", "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
					]]--
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsNone = { "PackageBountyChaosIntro" }
					},
					-- mutually exclusive variant
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateGrantsWeaponUpgradeSystem01"},
					},
					-- preventing other simultaneous unlocks
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HecateBossAboutHermes02" },
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
			HecateBossGrantsShrineUpgrade01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateGrantsShrineUpgrade01" }
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutShrineUpgrade01"},
							},
						},
						{
							{
								PathTrue = { "GameState", "ScreensViewed", "Shrine" },
							},
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
								Comparison = "<=",
								Value = 0,
							},
							{
								Path = { "GameState", "EnemyKills", "Hecate" },
								Comparison = ">=",
								Value = 2,
							},
							{
								PathTrue = { "GameState", "EnemyKills", "Polyphemus" },
							},
							{
								Path = { "GameState", "SpentShrinePointsCache" },
								Comparison = ">=",
								Value = 1,
							},
							--[[
							{
								Path = { "GameState", "RoomsEntered" },
								HasAll = { "N_Story01", "N_PostBoss01" },
							},
							]]--
						},

					},

				},
				{ Cue = "/VO/HecateField_0278",
					Text = "One further secret of the Oath of the Unseen I shall reveal now. When you feel suitably prepared, consider this. Then perhaps we shall clash under a new set of circumstances..." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "ShrineUpgradeGained", Text = "ShrineUpgradeGained_Subtitle01" },

				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3474", Text = "The secret to the Vow of Rivals..." },
				},
			},

			-- brief one-offs
			HecateBossMiscOutro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Hecate_0140",
					Text = "Well fought again, Melinoë. Proceed, and moonlight guide you." },
			},
			HecateBossMiscOutro02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.5, },
					},
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
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.4, },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
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
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.7, },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Hecate_0315",
					Text = "Impressive show of force. Hold nothing back as you continue on." },
			},
			HecateBossMiscOutro06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.5, },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
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
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
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
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/HecateField_0093",
					Text = "May you show even greater wrath against the enemies awaiting you below." },
			},
			HecateBossMiscOutro19 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/HecateField_0094",
					Text = "Well fought, and may the Fates be generous to you in your descent." },
			},
			HecateBossMiscOutro20 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/HecateField_0095",
					Text = "I have impeded you for long enough this night. Go, make the most of this attempt." },
			},
			HecateBossMiscOutro21 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				{ Cue = "/VO/HecateField_0353",
					Text = "The Flames of Ygnium burn bright for you... but mastery is an everlasting pursuit." },
			},
			HecateBossMiscOutro22 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
				},
				{ Cue = "/VO/HecateField_0354",
					Text = "You handle Zorephet as though its bulk is not an inconvenience but a strength..." },
			},
			HecateBossMiscOutro23 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
					},
				},
				{ Cue = "/VO/HecateField_0355",
					Text = "The Skull of Revaal is not a simple artifact to wield... but I can see you two have come to grips." },
			},
			HecateBossMiscOutro24 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0356",
					Text = "At least let me get in a strike or two next time for sake of pride, Melinoë?" },
			},
			HecateBossMiscOutro25 =
			{
				PlayFirst = true,
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0357",
					Text = "As elusive as a Shade. I don't believe I struck you even once." },
			},
			HecateBossMiscOutro26 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0358",
					Text = "Impressive work to have evaded every strike; my own and that of my Sisters as well." },
			},
			HecateBossMiscOutro27 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 1.0, },
					},
					{
						Path = { "CurrentRun", "WeaponsFiredRecord" },
						HasNone =
						{
							"WeaponSpellPotion",
						},
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossHecate02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0359",
					Text = "You arrived with not so much as a single cut or scrape, and thus depart. Such strength and agility as can stop Time." },
			},
			HecateBossMiscOutro28 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0361",
					Text = "You scarce afforded me a single opening. Show no such mercy to our enemies either." },
			},
			HecateBossMiscOutro29 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0362",
					Text = "Swiftly and thoroughly dispatched as though I was no threat to you at all." },
			},
			HecateBossMiscOutro30 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0363",
					Text = "I see you are not in any mood to be slowed down! Hold fast to that ferocity." },
			},
			HecateBossMiscOutro31 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0364",
					Text = "Well, go on! 'Tis clear that you are in a hurry, for how quickly you were able to overcome what threat I posed!" },
			},
			HecateBossMiscOutro32 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate01", "ClearTime" },
								Comparison = "<=",
								Value = 30.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossHecate02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossHecate02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/HecateField_0365",
					Text = "Lord Hermes would be most impressed with how swiftly and thoroughly you settled the score here." },
			},
			HecateBossMiscOutro33 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
				},
				{ Cue = "/VO/HecateField_0366",
					Text = "Know only that I would not willingly confront the fury of Xinth for merely anyone, Melinoë..." },
			},
		},
	},

	HecateCopy =
	{
		InheritFrom = { "BaseVulnerableEnemy"},
		GenusName = "Hecate",
		RunHistoryKilledByName = "NPC_Hecate_01",
		BlockCharm = true,
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

			DoNotRepeatOnAttackFail = true,
		},

		WeaponOptions =
		{
			"HecateRangedTorchesHoming", "HecateRangedTorchesLine", "HecateRangedTorchesFork", "HecateRangedTorchesRing",
		},

		StunAnimations =
		{

		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},
	},

	HecateCopyEM =
	{
		InheritFrom = { "HecateCopy"},

		ShrineUpgradeName = "BossDifficultyShrineUpgrade",

		AIOptions = { "AttackerAI" },

		GrannyTexture = "GR2/HecateEM_Color",

		WeaponOptions =
		{
			"HecateRangedTorchesHoming", "HecateRangedTorchesFork", "HecateRangedTorchesRing",
			"HecateWolfHowl"
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			--TeleportMaxPlayerArc = 90,

			ChainedWeaponOptions = { "HecateTeleport2", },
		},
	},
	
}

-- Global Hecate Lines
GlobalVoiceLines.HecateBossGreetingLines =
{
	-- @ ending
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "BossHecateKidnapping" },
			},
		},
		{
			PreLineWait = 1.0,
			ObjectType = "NPC_Chronos_01",

			{ Cue = "/VO/Chronos_0972", Text = "Oh, hello, Granddaughter." },
		},
		{
			BreakIfPlayed = true,
			UsePlayerSource = true,
			PostLineWait = 0.35,

			{ Cue = "/VO/MelinoeField_3872", Text = "No...!" },
		},
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		ObjectType = "Hecate",
		PreLineAnim = "HecateHubGreet_Battle",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "QueuedBossIntroTextLines", "Name" },
				IsAny = {
					"HecateBossAboutChronos01",
					"HecateBossAboutEndingPath04",
					"HecateBossAboutErebus01",
					"HecateBossAboutHermes01",
					"HecateBossAboutFailure01",
					"HecateBossAboutRepetition01",
					"HecateBossPostEpilogue02",
				},
			},
		},
		{ Cue = "/VO/HecateField_0457", Text = "You look inquisitive." },
		{ Cue = "/VO/HecateField_0458", Text = "You've a question." },
		{ Cue = "/VO/HecateField_0460", Text = "Aught to discuss?" },
		{ Cue = "/VO/HecateField_0459", Text = "What concerns you?", PlayFirst = true,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "ReachedEpilogue" },
			},
		},
		{ Cue = "/VO/HecateField_0461", Text = "You are concerned.", PlayFirst = true,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "ReachedEpilogue" },
			},
		},
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		ObjectType = "Hecate",
		PreLineAnim = "HecateHubGreet_Battle",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "QueuedBossIntroTextLines", "Name" },
				IsAny = { "HecateBossAboutEndingPath00" },
			},
		},
		{ Cue = "/VO/HecateField_0417", Text = "Steady yourself..." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		ObjectType = "Hecate",
		PreLineAnim = "HecateHubGreet_Battle",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "QueuedBossIntroTextLines", "Name" },
				IsAny = { "HecateBossAboutEndingPath02" },
			},
		},
		{ Cue = "/VO/HecateField_0420", Text = "How fares the task?" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		ObjectType = "Hecate",
		PreLineAnim = "HecateHubGreet_Battle",
		GameStateRequirements =
		{
			{
				Path = { "SessionMapState", "QueuedBossIntroTextLines", "Name" },
				IsAny = { "HecateBossAboutEndingPath03" },
			},
		},
		{ Cue = "/VO/HecateField_0423", Text = "Question..." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "HecateBossFirstVO",
		SuccessiveChanceToPlay = 0.25,

		{ Cue = "/VO/Melinoe_0036", Text = "Headmistress...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_0036" },
				},
				{
					PathFalse = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4305", Text = "Head— Hecate.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateFishing02" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4303", Text = "Hecate...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateFishing02" }
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4305" }
				},
				{
					SumPrevRuns = 3,
					Path = { "SpeechRecord", "/VO/MelinoeField_4305" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4306", Text = "Good evening...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_4304", Text = "Hecate.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.66,
		ObjectType = "Hecate",
		PreLineAnim = "HecateHubGreet_Battle",
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsNone = { "/VO/MelinoeField_4303", "/VO/MelinoeField_4304", "/VO/MelinoeField_4305", "/VO/MelinoeField_4306" },
			},
		},

		{ Cue = "/VO/Hecate_0487", Text = "There she is.", PlayFirst = true },
		{ Cue = "/VO/Hecate_0066", Text = "{#Emph}Ah.", IgnorePreLineAnim = true },
		{ Cue = "/VO/Hecate_0067", Text = "{#Emph}Hm.", IgnorePreLineAnim = true },
		{ Cue = "/VO/Hecate_0071", Text = "I sensed your presence." },
		{ Cue = "/VO/Hecate_0334", Text = "At last." },
		{ Cue = "/VO/Hecate_0336", Text = "Well, well." },
		{ Cue = "/VO/Hecate_0337", Text = "{#Emph}Hrm...", IgnorePreLineAnim = true, },
		{ Cue = "/VO/Hecate_0338", Text = "Come forward." },
		{ Cue = "/VO/Hecate_0483", Text = "Shall we?" },
		{ Cue = "/VO/Hecate_0484", Text = "Ready?" },
		{ Cue = "/VO/Hecate_0485", Text = "Breathe." },
		{ Cue = "/VO/Hecate_0486", Text = "There you are." },
		{ Cue = "/VO/Hecate_0488", Text = "Sure enough." },
		{ Cue = "/VO/HecateField_0179", Text = "Welcome." },
		{ Cue = "/VO/HecateField_0180", Text = "Hold.", IgnorePreLineAnim = true },
		{ Cue = "/VO/HecateField_0183", Text = "That was quick." },
		{ Cue = "/VO/HecateField_0417", Text = "Steady yourself...",
			GameStateRequirements =
			{
				{
					SumPrevRuns = 8,
					Path = { "SpeechRecord", "/VO/HecateField_0417" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			}
		},
		{ Cue = "/VO/HecateField_0367", Text = "A hidden Aspect of the Arms...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllHiddenAspects,
				},
			},
		},
		{ Cue = "/VO/HecateField_0368", Text = "One of the hidden Aspects...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllHiddenAspects,
				},
			},
		},
		{ Cue = "/VO/HecateField_0369", Text = "You made the Vow again.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathFalse = { "GameState", "LastBossDifficultyRecord", "Hecate" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0370", Text = "Returned from above?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
					Path = { "BiomesReached", "N" },
					CountPathTrue = true,
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/HecateField_0329", Text = "And there she is...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
			},
		},

		{ Cue = "/VO/HecateField_0466", Text = "The Princess appears.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0467", Text = "Foreboding night...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache" },
					Comparison = ">=",
					Value = 24,
				},
			},
		},
		{ Cue = "/VO/HecateField_0468", Text = "'Tis dark out there...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache" },
					Comparison = ">=",
					Value = 24,
				},
			},
		},
		{ Cue = "/VO/HecateField_0469", Text = "A fearsome night.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache" },
					Comparison = ">=",
					Value = 32,
				},
			},
		},
		{ Cue = "/VO/HecateField_0470", Text = "The image of Fear...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache" },
					Comparison = ">=",
					Value = 32,
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0471", Text = "Forgone the Vow?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = "<=",
					Value = 0,
				},
				{
					PathTrue = { "GameState", "LastBossDifficultyRecord", "Hecate" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0279", Text = "You found me.",
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
		{ Cue = "/VO/HecateField_0472", Text = "You chose to face me thus.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
				},
				{
					PathFalse = { "GameState", "LastBossDifficultyRecord", "Hecate" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/HecateField_0473", Text = "Your Vow remains.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
				},
				{
					PathTrue = { "GameState", "LastBossDifficultyRecord", "Hecate" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/HecateField_0474", Text = "Fulfill the Oath.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Hecate_0068", Text = "Greetings, Witch.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
				},
			},
		},
		{ Cue = "/VO/Hecate_0070", Text = "There you are.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
				},
			},
		},
		{ Cue = "/VO/Hecate_0333", Text = "Prompt as ever.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
				},
			},
		},
		{ Cue = "/VO/Hecate_0335", Text = "Compose yourself.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
				},
			},
		},
		{ Cue = "/VO/Hecate_0069", Text = "Melinoë.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
				},
			},
		},				
		{ Cue = "/VO/HecateField_0181", Text = "Not even a scratch!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0462", Text = "Entirely unscathed.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0463", Text = "Immaculate.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0464", Text = "Still at full strength.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0465", Text = "No problem getting here?",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 1.0, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0182", Text = "Fresh as rain.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomeStateName" },
					IsAny = { "Rain" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.9, },
				},
			},
		},
		{ Cue = "/VO/HecateField_0184", Text = "Descura...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0185", Text = "Lim and Oros...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0186", Text = "Ygnium...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0187", Text = "Zorephet...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0188", Text = "Revaal...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0267", Text = "Xinth...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0268", Text = "Come, bearer of the Black Coat.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/HecateField_0267" }
				},
				{
					PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0475", Text = "The Aspect of Circe...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffClearCastAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0476", Text = "The Aspect of Momus...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffSelfHitAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0477", Text = "The Aspect of Anubis...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0478", Text = "The Aspect of Artemis...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerBlockAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0479", Text = "The Aspect of Pan...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerHomingThrowAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0480", Text = "The Aspect of the Morrigan...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0481", Text = "The Aspect of Moros...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchDetonateAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0482", Text = "The Aspect of Eos...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0483", Text = "The Aspect of Supay...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0484", Text = "The Aspect of Charon...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0485", Text = "The Aspect of Thanatos...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0486", Text = "The Aspect of Nergal...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0487", Text = "The Aspect of Medea...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobCloseAttackAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0488", Text = "The Aspect of the Queen...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0489", Text = "The Aspect of Hel...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0490", Text = "The Aspect of Selene...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0491", Text = "The Aspect of Nyx...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0492", Text = "The Aspect of Shiva...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
				},
			},
		},
		{ Cue = "/VO/HecateField_0493", Text = "What's that you have...?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllHiddenAspects,
				},
			},
		},
		{ Cue = "/VO/HecateField_0257", Text = "Found something new to wear?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/HecateField_0258", Text = "Dressed all in spider's silk!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/HecateField_0259", Text = "Clad in Arachne's weavings once again.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = GameData.AllArachneCostumes,
				},
			},
		},
		{ Cue = "/VO/HecateField_0260", Text = "That azure color suits you well.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"ManaCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0261", Text = "Wearing the black of Night...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"HighArmorCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0262", Text = "As pale as the Moon...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"SpellCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0263", Text = "Vengeance in a blood-red dress...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"EscalatingCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0264", Text = "Lavender-colored silk...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"AgilityCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0265", Text = "Silk, green as verdant fields...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"VitalityCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0266", Text = "Silk, blue as surface seas.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"ManaCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0371", Text = "That is quite a color on you!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"CastDamageCostume",
					},
				},
			},
		},
		{ Cue = "/VO/HecateField_0372", Text = "Is that silk you wear, or gold?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = {
						"IncomeCostume",
					},
				},
			},
		},
	},
}

GlobalVoiceLines.HecateTransformVoiceLines =
{	
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.2,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
			Comparison = ">",
			Value = 0.2,
		},
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "HecateDarkSidedRecently", Time = 80 },
		{ Name = "HecateSpokeRecently", Time = 16 },
	},

	{ Cue = "/VO/HecateField_0301", Text = "{#Emph}Dark Side!" },
	{ Cue = "/VO/HecateField_0302", Text = "{#Emph}Dark Side...!" },
	{ Cue = "/VO/HecateField_0303", Text = "{#Emph}Dark Side..." },
	{ Cue = "/VO/HecateField_0304", Text = "To shadow!" },
	{ Cue = "/VO/HecateField_0305", Text = "To shadow..." },
	{ Cue = "/VO/HecateField_0306", Text = "{#Emph}Fear!" },
	{ Cue = "/VO/HecateField_0307", Text = "{#Emph}Behold!" },
	{ Cue = "/VO/HecateField_0308", Text = "{#Emph}Look upon me!", PlayFirst = true },
	{ Cue = "/VO/HecateField_0309", Text = "{#Emph}Hraaugh!" },
	{ Cue = "/VO/HecateField_0310", Text = "See {#Emph}this!" },
}

GlobalVoiceLines.HecatePolymorphVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	ObjectType = "Hecate",
	Cooldowns =
	{
		{ Name = "HecatePolymorphedRecently", Time = 60 },
	},
	TriggerCooldowns = { "HecateSpokeRecently" },

	{ Cue = "/VO/Hecate_0148", Text = "{#Emph}Ah{#Prev}, to be a beast!", },
	{ Cue = "/VO/Hecate_0149", Text = "Caught you!", },
	{ Cue = "/VO/Hecate_0150", Text = "A hex upon you!", PlayFirst = true },
	{ Cue = "/VO/Hecate_0151", Text = "Enjoy your newfound form.", },
	{ Cue = "/VO/Hecate_0152", Text = "If you could see yourself.",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "SpeechRecord", "/VO/HecateField_0209" },
			},
		},
	},
	{ Cue = "/VO/Hecate_0153", Text = "I know you hate this trick." },
	{ Cue = "/VO/Hecate_0356", Text = "What's wrong, Melinoë?" },
	{ Cue = "/VO/Hecate_0357", Text = "The curse of Night!" },
	{ Cue = "/VO/Hecate_0358", Text = "Unpleasant, isn't it?" },
	{ Cue = "/VO/Hecate_0359", Text = "Caught out again." },
	{ Cue = "/VO/HecateField_0060", Text = "All you can do is run." },
	{ Cue = "/VO/HecateField_0061", Text = "Now run, Melinoë." },
	{ Cue = "/VO/HecateField_0062", Text = "I suggest you run." },
	{ Cue = "/VO/HecateField_0063", Text = "The tables have turned..." },
	{ Cue = "/VO/HecateField_0064", Text = "Not simple to evade that one." },
	{ Cue = "/VO/HecateField_0065", Text = "You look adorable." },
	{ Cue = "/VO/HecateField_0149", Text = "Take on a lesser form!" },
	{ Cue = "/VO/HecateField_0150", Text = "Time for a {#Emph}change." },
	{ Cue = "/VO/HecateField_0193", Text = "Pardon the interruption." },
	{ Cue = "/VO/HecateField_0191", Text = "No you don't." },
	{ Cue = "/VO/HecateField_0453", Text = "The Circe special!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "PolymorphType" },
				IsAny = { "Pig" },
			},
		},
	},
	{ Cue = "/VO/HecateField_0454", Text = "Circe sends her regards!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "PolymorphType" },
				IsAny = { "Pig" },
			},
		},
	},
	{ Cue = "/VO/HecateField_0455", Text = "Beware, little rodent.",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "PolymorphType" },
				IsAny = { "Rat" },
			},
		},
	},
	{ Cue = "/VO/HecateField_0456", Text = "Go scurry for a bit!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "PolymorphType" },
				IsAny = { "Rat" },
			},
		},
	},
	{ Cue = "/VO/HecateField_0192", Text = "No, you don't!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/HecateField_0191" }
			},
		},
	},
	{ Cue = "/VO/HecateField_0194", Text = "Your {#Emph}favorite!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered" },
				SumOf = { "F_Boss01", "F_Boss02" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
}

GlobalVoiceLines.HecateHexVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Hecate",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
			Comparison = ">",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "HecateHexedRecently", Time = 45 },
		{ Name = "HecateSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Hecate_0353", Text = "Now beware..." },
	{ Cue = "/VO/Hecate_0145", Text = "Behold!" },
	{ Cue = "/VO/Hecate_0352", Text = "How about this?" },
	{ Cue = "/VO/Hecate_0493", Text = "{#Emph}Kataskion aski!" },
	-- { Cue = "/VO/HecateField_0441", Text = "Kataskion aski!" },
	{ Cue = "/VO/HecateField_0442", Text = "{#Emph}Kataskion aski...!" },
	{ Cue = "/VO/Hecate_0496", Text = "{#Emph}Askion kataski...!" },
	{ Cue = "/VO/HecateField_0443", Text = "{#Emph}Askion kataski!" },
	-- { Cue = "/VO/HecateField_0444", Text = "Askion kataski...!" },
	{ Cue = "/VO/HecateField_0205", Text = "{#Emph}Damname aision!" },
	-- { Cue = "/VO/Hecate_0494", Text = "{#Emph}Kataskion aski...!" },
	-- { Cue = "/VO/Hecate_0495", Text = "{#Emph}Askion kataski!" },
	-- { Cue = "/VO/HecateField_0206", Text = "{#Emph}Damname aision...!" },
	-- { Cue = "/VO/HecateField_0207", Text = "{#Emph}Damnaski traxon!" },
	-- { Cue = "/VO/HecateField_0208", Text = "{#Emph}Damnaski traxon!" },
	{ Cue = "/VO/HecateField_0409", Text = "Now see {#Emph}this!" },
	{ Cue = "/VO/HecateField_0410", Text = "{#Emph}Here{#Prev}, then!" },
	{ Cue = "/VO/HecateField_0411", Text = "Careful now...!" },
	{ Cue = "/VO/HecateField_0412", Text = "Beware...!" },
	{ Cue = "/VO/HecateField_0151", Text = "Behold the Moon!",
		Cooldowns =
		{
			{ Name = "HecateSaidMoonRecently", Time = 30 },
		},
	},
	{ Cue = "/VO/HecateField_0153", Text = "Tremble beneath the Moon!",
		Cooldowns =
		{
			{ Name = "HecateSaidMoonRecently", Time = 30 },
		},
	},
	{ Cue = "/VO/HecateField_0154", Text = "I have more hexes up my sleeve!" },
	{ Cue = "/VO/HecateField_0155", Text = "Let's see you evade {#Emph}this!", PlayFirst = true },
}

GlobalVoiceLines.HecatePhaseChangeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">=",
				Value = 0.65,
			},
			{
				Path = { "GameState", "RoomsEntered", "F_PostBoss01" },
				Comparison = "<=",
				Value = 30,
			},
		},
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 18 },
		},
		TriggerCooldowns = { "HecateLaseredRecently", "HecateMeteoredRecently", "HecateHexedRecently" },

		{ Cue = "/VO/Hecate_0104", Text = "Good." },
		{ Cue = "/VO/Hecate_0107", Text = "Well done!" },
		{ Cue = "/VO/Hecate_0111", Text = "Good form." },
		{ Cue = "/VO/Hecate_0117", Text = "Well struck." },
		{ Cue = "/VO/HecateField_0038", Text = "Do not overextend." },
		{ Cue = "/VO/HecateField_0039", Text = "{#Emph}That {#Prev}I felt." },
		{ Cue = "/VO/HecateField_0042", Text = "Careful now." },
		{ Cue = "/VO/HecateField_0043", Text = "That's it." },
		{ Cue = "/VO/HecateField_0044", Text = "Like that." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = "<=",
				Value = 0.35,
			},
		},
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 18 },
		},
		TriggerCooldowns = { "HecateLaseredRecently", "HecateMeteoredRecently" },

		{ Cue = "/VO/Hecate_0103", Text = "Good!" },
		{ Cue = "/VO/Hecate_0106", Text = "Well done." },
		{ Cue = "/VO/Hecate_0105", Text = "{#Emph}Rngh{#Prev}, good!" },
		{ Cue = "/VO/Hecate_0365", Text = "{#Emph}Heh..." },
		{ Cue = "/VO/HecateField_0048", Text = "Like that...!" },
	},

}

GlobalVoiceLines.HecateBossSpawnWaveVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "HecateEMWitchesIntroVO",
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		ObjectType = "Hecate",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 1,
			},
		},
		TriggerCooldowns = { "HecateSpokeRecently", "HecateSummonedRecently" },

		{ Cue = "/VO/HecateField_0319", Text = "See how strong our Sisters have become!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.75,
		ObjectType = "Hecate",
		Cooldowns =
		{
			{ Name = "HecateSummonedRecently", Time = 200 },
		},
		TriggerCooldowns = { "HecateSpokeRecently" },

		{ Cue = "/VO/Hecate_0154", Text = "To me, my Sisters!" },
		{ Cue = "/VO/Hecate_0155", Text = "Join me, Sisters!" },
		{ Cue = "/VO/Hecate_0508", Text = "Into the fray, Sisters!" },
		{ Cue = "/VO/Hecate_0509", Text = "Once more with me, Sisters!" },
		{ Cue = "/VO/Hecate_0510", Text = "Return to me, Sisters!" },
		{ Cue = "/VO/Hecate_0511", Text = "Return to fight, Sisters!" },
		{ Cue = "/VO/Hecate_0512", Text = "Arise, Sisters!", PlayFirst = true },
		{ Cue = "/VO/Hecate_0513", Text = "Arise again, Sisters!" },	
		-- { Cue = "/VO/HecateField_0050", Text = "So..." },
		{ Cue = "/VO/HecateField_0195", Text = "{#Emph}Night Bloom!" },
		{ Cue = "/VO/HecateField_0196", Text = "{#Emph}Night Bloom...!", PlayFirst = true },
		{ Cue = "/VO/HecateField_0197", Text = "Sisters, to {#Emph}me!" },
		{ Cue = "/VO/HecateField_0198", Text = "Come, Sisters of the Dead!" },
		{ Cue = "/VO/HecateField_0200", Text = "Sisters, {#Emph}now!" },
		{ Cue = "/VO/HecateField_0199", Text = "Oh, Sisters?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EnemyKills", "Chronos" },
				},
				{
					Path = { "GameState", "RoomsEntered" },
					SumOf = { "F_Boss01", "F_Boss02" },
					Comparison = ">=",
					Value = 8,
				},
			},
		},
		{ Cue = "/VO/HecateField_0319", Text = "See how strong our Sisters have become!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					SumPrevRuns = 8,
					Path = { "SpeechRecord", "/VO/HecateField_0319" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
	},
}

GlobalVoiceLines.HecateGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Hecate",
	-- SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "HecateSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/Hecate_0360", Text = "Don't you think that can wait?" },
	{ Cue = "/VO/Hecate_0361", Text = "A valuable!" },
	{ Cue = "/VO/Hecate_0362", Text = "Find anything good?", PlayFirst = true },
	{ Cue = "/VO/Hecate_0363", Text = "Hello, this is a {#Emph}fight!" },
	{ Cue = "/VO/HecateField_0070", Text = "Aren't you a cheeky one?" },
	{ Cue = "/VO/HecateField_0071", Text = "You'll soon get more than {#Emph}that.", PlayFirst = true },
	{ Cue = "/VO/HecateField_0072", Text = "How nice for you." },
	{ Cue = "/VO/HecateField_0073", Text = "{#Emph}Ooh {#Prev}let me see!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				CountOf =
				{
					"/VO/Hecate_0360",
					"/VO/Hecate_0361",
					"/VO/Hecate_0362",
					"/VO/Hecate_0363",
					"/VO/HecateField_0070",
					"/VO/HecateField_0071",
					"/VO/HecateField_0072",
				},
				Comparison = ">=",
				Value = 5,
			},
		}
	},
}

GlobalVoiceLines.HecateAddsDeadVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.25,
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 18 },
		},

		{ Cue = "/VO/Hecate_0103", Text = "Good!" },
		{ Cue = "/VO/Hecate_0104", Text = "Good." },
		{ Cue = "/VO/Hecate_0106", Text = "Well done." },
		{ Cue = "/VO/Hecate_0107", Text = "Well done!" },
		{ Cue = "/VO/Hecate_0111", Text = "Good form." },
		{ Cue = "/VO/Hecate_0117", Text = "Well struck." },
		-- { Cue = "/VO/HecateField_0038", Text = "Do not overextend!" },
		-- { Cue = "/VO/HecateField_0043", Text = "That's it." },
		-- { Cue = "/VO/HecateField_0044", Text = "Like that." },
		{ Cue = "/VO/HecateField_0399", Text = "Alone again." },
		{ Cue = "/VO/HecateField_0400", Text = "Short work." },
		{ Cue = "/VO/HecateField_0401", Text = "So much for {#Emph}them!" },
		{ Cue = "/VO/HecateField_0402", Text = "And now for me.", PlayFirst = true },
		{ Cue = "/VO/HecateField_0403", Text = "They shall return." },
		{ Cue = "/VO/HecateField_0405", Text = "And there they go.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = ">=",
					Value = 6,
				},
			},
		},
		{ Cue = "/VO/HecateField_0406", Text = "Got them all...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = "<=",
					Value = 35,
				},
			},
		},
		{ Cue = "/VO/HecateField_0407", Text = "Gone already?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{ Cue = "/VO/HecateField_0408", Text = "You scared them off.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = ">=",
					Value = 7,
				},
			},
		},
		{ Cue = "/VO/HecateField_0404", Text = "Thank you, Sisters!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = ">=",
					Value = 10,
				},
			},
		},
	},
}

GlobalVoiceLines.HecateReturnVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	SuccessiveChanceToPlay = 0.33,
	PreLineWait = 0.4,
	GameStateRequirements =
	{
		{
			Path = { "GameState", "EnemyKills", "Hecate" },
			Comparison = ">=",
			Value = 1,
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = 
			{
				"HecateBossMiscOutro15",
				"HecateBossOutro01",
				"HecateBossOutroNoArcana01",
				"HecateBossOutroAltFight01",
				"HecateBossGrantsCodex01",
				"HecateBossGrantsCardUpgradeSystem01",
				"HecateBossGrantsFamiliarSystem01",
				"HecateBossGrantsWeaponUpgradeSystem01",
				"HecateBossGrantsShrineUpgrade01",
			},
		},
	},

	{ Cue = "/VO/HecateField_0251", Text = "Return to shadow, now!" },
	{ Cue = "/VO/HecateField_0252", Text = "Return to shadow, now..." },
	{ Cue = "/VO/HecateField_0253", Text = "Return to shadow, now.", PlayFirst = true, },
	{ Cue = "/VO/HecateField_0254", Text = "Return to shadow, now." },
	{ Cue = "/VO/HecateField_0437", Text = "Return to shadow, now!" },
	{ Cue = "/VO/HecateField_0438", Text = "Return to shadow, now..." },
	-- { Cue = "/VO/HecateField_0439", Text = "Return to shadow, now." },
	-- { Cue = "/VO/HecateField_0440", Text = "Return to shadow, now." },
}

OverwriteTableKeys( EnemyData, UnitSetData.Hecate )