UnitSetData.Zagreus =
{
	Zagreus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },
		
		Portrait = "Portrait_ZagPresent_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ZagreusVoice,
		GiftName = "NPC_Zagreus_01",
		RunHistoryKilledByName = "NPC_Zagreus_01",
		EmoteOffsetY = -280,
		EmoteOffsetX = 15,

		MaxHealth = 10800,
		HealthBarTextId = "Zagreus_Full",
		InvulnerableFx = "nil",

		OnDeathFunctionName = "ZagreusKillPresentation",
		OnDeathFunctionArgs = { Message = "ChampionDefeatedMessage", StartPanTime = 1.0, EndPanTime = 4.0, FlashRed = true, MessageDelay = 0.5, StartSound = "/SFX/Player Sounds/PlayerDeath" },
		DeathAnimation = "Enemy_Zagreus_Death_Start",
		DeathAngle = 210,

		DestroyDelay = 0.0,

		AISetupDelay = 1.05,
		
		BlockPostBossMetaUpgrades = true,
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		NoTargetWanderDuration = 0.1,
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		OnDamagedEvents =
		{
			{
				FunctionName = "CheckComboBreakerDamageInWindow",
				Args =
				{
					Threshold = 650,
					Window = 1.0,
					ComboBreakerCooldown = 9.5,
					ForcedWeaponInterrupt = "ZagreusDoubleDashRetreat",
				},
			},
		},

		CastAmmo = 3,
		WeaponOptions =
		{
			"ZagreusSpearSpin",
			"ZagreusSpearDashStrike",
			"ZagreusSpearStabCombo",

			"ZagreusDash",
			"ZagreusDoubleDash",
			"ZagreusDoubleDashRetreat",

			"ZagreusCast",
			"ZagreusBloodstonePickup", "ZagreusBloodstonePickup",
		},
		ForcedNextWeapon = "ZagreusSpearOffenseCombo1",

		Phases = 2,
		AIEndHealthThreshold = 0.0,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,

				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ZagreusDeathDefiancePresentation",
				SetHealthPercent = 0.5,
				AIData =
				{
					AIEndHealthThreshold = 0.0,

				},
				UnequipAllWeapons = true,
				EquipWeapons =
				{
					"ZagreusSpearSpinDouble", "ZagreusSpearSpinDouble", "ZagreusSpearSpinDouble",
					"ZagreusSpearDashStrike",
					"ZagreusSpearStabCombo",

					"ZagreusDash",
					"ZagreusDoubleDash",
					"ZagreusDoubleDashRetreat",

					"ZagreusCast",
					"ZagreusBloodstonePickup", "ZagreusBloodstonePickup",

					"ZagreusDarknessOut",
				},
				DataOverrides =
				{
					ForcedNextWeapon = "ZagreusDarknessOut",
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
				{ Name = "ZagreusSpokeRecently", Time = 14 },
			},

			{ Cue = "/VO/Zagreus_0284", Text = "Got you.", PlayFirst = true },
			{ Cue = "/VO/Zagreus_0285", Text = "Nicked you." },
			{ Cue = "/VO/Zagreus_0287", Text = "Tag, you're it." },
			{ Cue = "/VO/Zagreus_0288", Text = "You all right?" },
			{ Cue = "/VO/Zagreus_0289", Text = "Still going?" },
			{ Cue = "/VO/Zagreus_0290", Text = "Angry now..." },
			{ Cue = "/VO/Zagreus_0291", Text = "{#Emph}Oof." },
			{ Cue = "/VO/Zagreus_0292", Text = "{#Emph}...Ouch." },
			{ Cue = "/VO/Zagreus_0293", Text = "See that?" },
			{ Cue = "/VO/Zagreus_0294", Text = "There we go." },
			{ Cue = "/VO/Zagreus_0295", Text = "Too slow." },
			{ Cue = "/VO/Zagreus_0296", Text = "Come on now." },
			{ Cue = "/VO/Zagreus_0297", Text = "Bad move..." },
			{ Cue = "/VO/Zagreus_0286", Text = "Tag!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Zagreus_0287" },
					},
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ZagreusSpokeRecently", Time = 6 },
					{ Name = "ZagreusLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Zagreus_0298", Text = "Still up?" },
				{ Cue = "/VO/Zagreus_0299", Text = "Runs in the family!" },
				{ Cue = "/VO/Zagreus_0300", Text = "Survived, {#Emph}huh...?" },
				{ Cue = "/VO/Zagreus_0303", Text = "Easy now...!" },
				{ Cue = "/VO/Zagreus_0304", Text = "Took that well..." },
				{ Cue = "/VO/Zagreus_0305", Text = "No backing down!" },
				{ Cue = "/VO/Zagreus_0306", Text = "Fight on!" },
				{ Cue = "/VO/Zagreus_0307", Text = "Gonna take that?" },
				{ Cue = "/VO/Zagreus_0308", Text = "{#Emph}Uh oh...", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0309", Text = "You're tough..." },
				{ Cue = "/VO/Zagreus_0301", Text = "Sticking around?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Zagreus_0104" },
						},
					},
				},
				{ Cue = "/VO/Zagreus_0302", Text = "Not leaving yet?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Zagreus_0104" },
						},
					},
				},
			},
		},
		InvulnerableVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusInvulnerableVoiceLines" },
		},
		ResistedVoiceLines =
		{
			-- { GlobalVoiceLines = "ZagreusInvulnerableVoiceLines" },
		},

		OnInvisStartVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "Zagreus",
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
					Comparison = ">=",
					Value = 0.2,
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "ZagreusSpokeRecently", Time = 12 },
				{ Name = "ZagreusInvisReactionSpeech", Time = 40 },
			},
			TriggerCooldowns = { "ChronosSpokeRecently" },

			{ Cue = "/VO/Zagreus_0383", Text = "No fair." },
			{ Cue = "/VO/Zagreus_0384", Text = "Hey where'd you go?" },
			{ Cue = "/VO/Zagreus_0385", Text = "That's my line." },
			{ Cue = "/VO/Zagreus_0386", Text = "Father's tricks..." },
			{ Cue = "/VO/Zagreus_0387", Text = "Father playing favorites?" },
		},

		CriticalHealthVoiceLineThreshold = 0.4,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.05,
			Cooldowns =
			{
				{ Name = "ZagreusSpokeRecently", Time = 14 },
				{ Name = "ZagreusDamageSpeech", Time = 40 },
			},

			{ Cue = "/VO/Zagreus_0244", Text = "Not bad...!" },
			{ Cue = "/VO/Zagreus_0245", Text = "Not good..." },
			{ Cue = "/VO/Zagreus_0246", Text = "{#Emph}Ow...!" },
			{ Cue = "/VO/Zagreus_0247", Text = "Felt {#Emph}that..." },
			{ Cue = "/VO/Zagreus_0248", Text = "That hurt..." },
			{ Cue = "/VO/Zagreus_0249", Text = "{#Emph}Argh..." },
			{ Cue = "/VO/Zagreus_0250", Text = "Hey...!" },
			{ Cue = "/VO/Zagreus_0251", Text = "{#Emph}Augh..." },
			{ Cue = "/VO/Zagreus_0252", Text = "{#Emph}Urgh..." },
			{ Cue = "/VO/Zagreus_0253", Text = "{#Emph}Oh {#Prev}come on..." },
			{ Cue = "/VO/Zagreus_0254", Text = "{#Emph}Rngh..." },
			{ Cue = "/VO/Zagreus_0255", Text = "Damn it..." },
			{ Cue = "/VO/Zagreus_0256", Text = "Blast..." },
			{ Cue = "/VO/Zagreus_0257", Text = "{#Emph}Buh..." },
			{ Cue = "/VO/Zagreus_0258", Text = "Seriously...?" },
			{ Cue = "/VO/Zagreus_0259", Text = "No no no!" },
			{ Cue = "/VO/Zagreus_0260", Text = "Not dead yet!" },
			{ Cue = "/VO/Zagreus_0261", Text = "What..." },
		},

		PhaseEndedVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredBossPhase",
						FunctionArgs = { Phase = 2 },
					},
				},

				{ Cue = "/VO/Zagreus_0262", Text = "No you don't...!" },
				{ Cue = "/VO/Zagreus_0263", Text = "Not... finished!" },
				{ Cue = "/VO/Zagreus_0264", Text = "{#Emph}Hah... {#Prev}no.", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0265", Text = "Not... yet...!" },
				{ Cue = "/VO/Zagreus_0266", Text = "...Staying right here thanks...!" },
				{ Cue = "/VO/Zagreus_0267", Text = "...Well done...!" },
				{ Cue = "/VO/Zagreus_0268", Text = "All right that hurt..." },
				{ Cue = "/VO/Zagreus_0269", Text = "...Not nice, Sister." },
				{ Cue = "/VO/Zagreus_0271", Text = "...Just, no!" },
				{ Cue = "/VO/Zagreus_0272", Text = "...Stop that!" },
				{ Cue = "/VO/Zagreus_0273", Text = "...Cut that out!" },
				{ Cue = "/VO/Zagreus_0270", Text = "...Not... dead...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0274", Text = "...{#Emph}Augh{#Prev}, blast...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0270", Text = "...Not... dead...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0275", Text = "...No good...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0276", Text = "...{#Emph}Augh{#Prev}, this is it...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0277", Text = "...{#Emph}Rngh{#Prev}, last chance...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0278", Text = "...{#Emph}Ngh{#Prev}, not... finished...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0279", Text = "...Can... still... fight!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0280", Text = "...No... you... don't!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0281", Text = "...We're... not... through!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0282", Text = "...Blood and... {#Emph}augh...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0283", Text = "...Don't... back... down...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 5,
						},
					},
				},
			},
		},

		DefeatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },

				{ Cue = "/VO/Zagreus_0108", Text = "That was... beginner's... luck...", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Zagreus_0341", Text = "I'll... be going... now..." },
				{ Cue = "/VO/Zagreus_0342", Text = "You're... not... bad..." },
				{ Cue = "/VO/Zagreus_0343", Text = "Let's... do this... again..." },
				{ Cue = "/VO/Zagreus_0344", Text = "See... you... soon..." },
				{ Cue = "/VO/Zagreus_0345", Text = "Down... we... go..." },
				{ Cue = "/VO/Zagreus_0347", Text = "Don't... wait... up..." },
				{ Cue = "/VO/Zagreus_0349", Text = "Well... done... Sis..." },
				{ Cue = "/VO/Zagreus_0351", Text = "You... got... me..." },
				{ Cue = "/VO/Zagreus_0413", Text = "Forgot something... at home..." },
				{ Cue = "/VO/Zagreus_0415", Text = "Next stop... Tartarus..." },
				{ Cue = "/VO/Zagreus_0416", Text = "Hey, easy on the cape..." },
				{ Cue = "/VO/Zagreus_0417", Text = "Occupational... hazard...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Zagreus_0414", Text = "These grabby hands... again...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Zagreus" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
			}
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
				PreLineWait = 9.2,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_4242", Text = "Well fought, Big Brother." },
				{ Cue = "/VO/MelinoeField_4243", Text = "Does this mean I'm the Champion...?" },
				{ Cue = "/VO/MelinoeField_4992", Text = "Took you down, Big Brother...", PlayFirst = true },
			},
		},

		BossIntroTextLineSets =
		{
			ZagreusBossFirstMeeting =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					--
				},
				{ Cue = "/VO/Zagreus_0099",
					PreLineWait = 0.35,
					-- Portrait = "Portrait_ZagPresent_Unwell_01",
					-- Portrait = "Portrait_ZagPresent_Pained_01",
					-- Portrait = "Portrait_ZagPresent_Serious_01",
					-- Portrait = "Portrait_ZagPresent_Empathetic_01",
					-- Portrait = "Portrait_ZagPresent_Defiant_01",
					-- PreLineAnim = "Zagreus_Greet",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_ZagPresent_Default_01", WaitTime = 3 },

					Text = "Well this is awkward. Melinoë, what are you doing here? I was just basking in the adulation of the crowd. They never tire of seeing the Champion or Champions of Elysium fall." },

				{ Cue = "/VO/MelinoeField_4237", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm{#Prev}, hello Zagreus! Wow, this is Elysium, but I don't know what I'm doing here. Last I recall I'd picked up some sort of burning parchment from Charon's shop..." },

				{ Cue = "/VO/Zagreus_0100",
					PreLineWait = 0.35,
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Oh gods... you really accepted an Infernal Contract. Read all the fine print, and still thought it was a good idea?" },

				{ Cue = "/VO/MelinoeField_4238", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I... can't exactly say I read all the fine print, I mean, there seemed an awful lot, and... could you perhaps summarize what I consented to?" },

				{ Cue = "/VO/Zagreus_0101",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "A free trip to Elysium, for one...! And an exhibition match with its present Champion or Champions for another. Though exhibition does mean deadly battle in this case. You ready?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Zagreus",
						TriggerCooldowns = { "ZagreusSpokeRecently" },

						{ Cue = "/VO/Zagreus_0102", Text = "Let's give these Shades a show!" },
					},
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/MelinoeField_4239", Text = "If you insist!" },
					},
					{
						PreLineWait = 1.5,
						ObjectType = "Zagreus",
						TriggerCooldowns = { "ZagreusSpokeRecently" },

						{ Cue = "/VO/Zagreus_0103", Text = "Meet the Princess of the Underworld, everyone!" },
					},
				},
			},

			ZagreusBossLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = ">=",
						Value = 0.25,
					},
				},

				{ Cue = "/VO/Zagreus_0149",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Got you quite decisively last time as I recall, Sister, so I am mildly surprised you'd dare to show your face again in such a competitive environment." },

				{ Cue = "/VO/MelinoeField_4612", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm accustomed to the occasional setback here and there. What about you? You've been trapped in Time. That can't be good for your physical and mental acuity." },

				{ Cue = "/VO/Zagreus_0150",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "I don't know, it's like I didn't miss a beat! Though why don't {#Emph}you {#Prev}be the judge of my {#Emph}physical and mental acuity {#Prev}in just a moment here." },
			},
			ZagreusBossWonAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Zagreus_0152",
					Text = "There came a point in my Security Specialist career where my victories became too numerous to count! So... thanks for last time, reminding me about defeat!" },

				{ Cue = "/VO/MelinoeField_4614", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 4.4 },

					Text = "You're very welcome. And likewise have my own defeats become a little less common recently. Though I don't know where that leaves us... somebody always has to lose here?" },

				{ Cue = "/VO/Zagreus_0153",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "The Shades would never tolerate it any other way. Well let's make this a victory-or-defeat to never forget!" },
			},

			ZagreusBossAboutSecurity01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MelinoeField_4539", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So you're back to being Security Specialist! It must be easier trying to break out of the Underworld when the gates are still flung open." },

				{ Cue = "/VO/Zagreus_0116",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "As a matter of fact, it is, yes! Particularly that very last part where I previously had to get past Cerberus and worse. For now it's more about surveying than escape." },

				{ Cue = "/VO/MelinoeField_4540", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You call this {#Emph}surveying? {#Prev}We're in a battle nearly to the death, all for the entertainment of these bloodthirsty Shades." },

				{ Cue = "/VO/Zagreus_0117",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "Now, now, Sister, the Shades of Elysium are some of our most valuable and influential residents! If spilling a little blood will satisfy them, that seems like a worthy sacrifice." },
			},

			ZagreusBossAboutCrossroads01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Zagreus_0118",
					PreLineAnim = "Zagreus_Talk_Start",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					Text = "So where exactly {#Emph}are {#Prev}these Crossroads where you're from? I feel as though, as Security Specialist, I ought to have been fully disclosed by this point." },

				{ Cue = "/VO/MelinoeField_4603", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well the Crossroads are in Erebus, but simply knowing that won't help with locating the place. Have Mother and Father not informed you?" },

				{ Cue = "/VO/Zagreus_0119",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "No. They're probably concerned that if I ever went, I'd want to stay, if {#Emph}you {#Prev}like it so much. That, or they're trying to protect your secrecy. Oh well! We can see each other {#Emph}here." },
			},

			ZagreusBossAboutGigaros01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "Zagreus" }
					},
				},
				{ Cue = "/VO/Zagreus_0120",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Not yet accustomed to the weight of Gigaros... I used to have a much wider variety of Arms at my disposal, you know! But now it seems they've been picked through." },

				{ Cue = "/VO/MelinoeField_4604", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm quite familiar with a couple of their current bearers, at least. The Blade of the Underworld is in the capable hands of Nemesis, while the Rail of Adamant is in the... hands of Eris." },

				{ Cue = "/VO/Zagreus_0121",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "I happen to miss those! But I was using their Aspects for a while, so perhaps it's all as it should be. They better be well taken care of, better than {#Emph}this {#Prev}old spear." },
			},
			ZagreusBossAboutGigaros02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossAboutGigaros01" }
					}
				},
				{ Cue = "/VO/MelinoeField_4605", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How did you get Gigaros anyhow? You never told me. Father truly just handed it over as a gift?" },

				{ Cue = "/VO/Zagreus_0122",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "I persuaded him like you suggested! {#Emph}Father, if I'm to command respect in my role as Security Specialist, I ought to wield the authority of the House of Hades! {#Prev}He had a lot of bad memories attached to this thing, besides." },

				{ Cue = "/VO/MelinoeField_4606", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "From fighting against {#Emph}you...? {#Prev}While I was growing up Headmistress Hecate told me all about how you did that." },

				{ Cue = "/VO/Zagreus_0123",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "Now she is quite the cagey one, must have served Mother in secrecy way back when. Well if she taught you all your magick and whatnot, then she must know {#Emph}plenty!" },
			},
			ZagreusBossAboutThanatosAspect01 =
			{
				PlayOnce = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AchillesTrueEnding01" },
					},
				},
				{ Cue = "/VO/Zagreus_0486",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Say, I know the son of Nyx and incarnate of Death to whom that rather sinister scythe belongs. As do you, in a way! I could give it back to him, rather than getting sliced?" },

				{ Cue = "/VO/MelinoeField_5175", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "Thank you for the generous offer, but I have need of it right now. Besides, Nyx knows where to find me if her son ever needs it back. How are you and Thanatos doing lately anyhow?" },

				{ Cue = "/VO/Zagreus_0487",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "Oh we're good. Much better now that we're not frozen in time, same for Megaera. They miss you! She says hello, while he says {#Emph}tell the Princess that she has my gratitude." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/MelinoeField_4547", Text = "Tell him I'm grateful for the scythe!" },
					},
				}
			},

			ZagreusBossAboutSurfacePenalty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Zagreus_0127",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "So you can just... go to the surface, and head all the way up to Olympus, and not die? I could never get very far." },

				{ Cue = "/VO/MelinoeField_4607", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 6.4 },

					Text = "I owe it to a complicated incantation called {#Emph}Unraveling a Fateful Bond{#Prev}. Without that, I could not get very far either. You must have longed to see Olympus for yourself... I wonder if..." },

				{ Cue = "/VO/Zagreus_0128",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PreLineWait = 0.25,
					Emote = "PortraitEmoteSurprise",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_ZagPresent_Default_01", WaitTime = 3.3, PlayZagreusTauntAnim = true },
					PostLineFunctionName = "StartZagreusBossFight",

					Text = "Hey, no need to defy the Fates on my account, Sister! I'd rather leave things be. Perhaps once the Underworld's back in business, I'll feel a stronger urge to see the mountain in all its glory, but... for now, the glory of Elysium's enough!" },
			},

			ZagreusBossAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastAwardTrait" },
						IsAny = { "RarifyKeepsake" },
					},
				},
				{ Cue = "/VO/Zagreus_0135",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "I know that gleam... you brought my Calling Card along! So has Olympus still been as forthcoming with Boons and such now that things have cooled off a bit?" },

				{ Cue = "/VO/MelinoeField_4608", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I think our relatives are quite eager to ensure things remain as-is. Which seems a little strange since it's all still quite a mess... though perhaps not to the previous extent." },

				{ Cue = "/VO/Zagreus_0136",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "Having things remain familiar for a while sounds like quite a pleasant change of pace, now that you mention it. Hey, these vicious battles can be part of {#Emph}our {#Prev}routine!" },
			},

			ZagreusBossAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
					},
				},
				{ Cue = "/VO/Zagreus_0409",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "What happened to you, one of your incantations backfire or something? Last time I remember you being this small it was potentially all just a dream of mine." },

				{ Cue = "/VO/MelinoeField_4990",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is the work of the Enchantress Circe, and I'll have you know, it is entirely intentional! You won't be ridiculing me when you see how elusive I've become." },

				{ Cue = "/VO/Zagreus_0410",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					-- PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", Portrait = "Portrait_ZagPresent_Defiant_01", WaitTime = 5.1, PlayZagreusTauntAnim = true },

					Text = "I didn't mean to ridicule you to begin with, although I think the Shades around here would probably enjoy a bit of verbal hostility before the main event. Come on then, {#Emph}Little Sister!" },
			},
			ZagreusBossAboutCirce02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
					},
				},
				{ Cue = "/VO/Zagreus_0406",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					Text = "Sister, you... {#Emph}erm... {#Prev}look, you're causing me to feel a little insecure about my height. How did you get to such a stature, or more importantly, how can I?" },

				{ Cue = "/VO/MelinoeField_4989",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, you'd have to pay a visit to the Enchantress Circe over on her remote isle, so it might be far out of your way. The effect is only temporary, though." },

				{ Cue = "/VO/Zagreus_0407",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					
					Text = "Even your voice is changed! Well, at least it's good to know I'll only feel humiliated here for the time being. Let's see what you've got, {#Emph}Little Sister." },
			},

			ZagreusBossAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HadesWithPersephone01", "AchillesTrueEnding01" },
					},
				},
				{ Cue = "/VO/MelinoeField_5173", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How are the Houseservants recovering, everybody back on their feet by now? I have fond memories of them... glimpses all through my childhood and growing up." },

				{ Cue = "/VO/Zagreus_0483",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "They have similarly kind things to say, whenever they're not bewildered by what happened. But yes, everybody's back on their feet, thanks... besides Dusa who doesn't have any." },

				{ Cue = "/VO/MelinoeField_5174", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm glad to hear it, besides the bewilderment part. You're not officially supposed to speak of what happened, are you? But please tell Dusa and the rest I said hello." },

				{ Cue = "/VO/Zagreus_0484",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "You got it. And officially or not, you're getting quite the terrifying reputation! Our rumor-spreading court musician Orpheus especially enjoys the tales of dark Melinoë. I take it you're about to show off your daemonic prowess here!" },
			},

			ZagreusBossAboutParents01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift06" }
					},
					{
						SumPrevRuns = 6,
						Path = { "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/MelinoeField_4548", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How have Mother and Father been, and Nyx? All this must be quite an adjustment for them." },

				{ Cue = "/VO/Zagreus_0143",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Oh they're all right. You're seeing Mother and Father not too infrequently yourself, as far as I've gathered. They're keeping an eye on things in Tartarus, probably in part to see {#Emph}you." },

				{ Cue = "/VO/MelinoeField_4549", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Or have some time alone I suppose. Meanwhile your current charge is here in Elysium, entertaining all these Shades?" },

				{ Cue = "/VO/Zagreus_0144",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "I'd like to think of it as {#Emph}inspiring {#Prev}moreso than {#Emph}entertaining{#Prev}, but if you must ask so pointedly, then... yes. Keeping the Shades of the Underworld happy is our highest priority! Next to keeping them from getting out, of course." },
			},

			ZagreusBossAboutRelationships01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosBecomingCloser01",
							"ErisBecomingCloser01",
							"NemesisPostCombatBecomingCloser01",
							"IcarusBecomingCloser01",
						},
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/Zagreus_0145",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "How is it in those Crossroads, anyway? Do you have friends, more-than-friends, that sort of thing? Do tell." },

				{ Cue = "/VO/MelinoeField_4611", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I suppose so, yes. Some of each. It's peaceful there. And I can see the Moon and stars under a canopy of trees... it even rains every so often." },

				{ Cue = "/VO/Zagreus_0146",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "{#Emph}Mm{#Prev}, getting rained on. I've heard that's unpleasant but perhaps it's nice! You didn't really get to meet my friends or more-than-friends, though who knows? We have eternity. Unless we somehow manage to kill each other here first." },
			},

			ZagreusBossAboutHypnosWakeUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AchillesTrueEnding01" },
					},
				},
				{ Cue = "/VO/Zagreus_0129",
					Text = "Hypnos recently returned to us! You've no idea how grateful he was to be back. Practically jumped right into my arms, although that might have been from abject fear." },

				{ Cue = "/VO/MelinoeField_4544", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "I'm uncertain whether he realized the House of Hades was out of commission for most of the time he was asleep. He left before I could explain. Do you know if he remembers the other past we saw...?" },

				{ Cue = "/VO/Zagreus_0485",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "I think so? He's still a bit frazzled from everything... perhaps keyed up from having overslept a bit. He still loves when I return to the House in failure, keeping track of all my deaths. So if you'd like to do him another favor, here's your shot!" },
			},
			ZagreusBossAboutSkelly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusBossAboutCrossroads01", "SkellyAboutPast04" },
					},
				},
				{ Cue = "/VO/Zagreus_0131",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Didn't you mention that a certain Schelemeus was residing with you, wherever your secret witch encampment is? How's he doing?" },

				{ Cue = "/VO/MelinoeField_4545", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 5.5 },

					Text = "He's as resolute as ever, teaching our loyal Shades our ways. He also serves as a practice partner of sorts. Though, I realize I'm not supposed to speak of him..." },

				{ Cue = "/VO/Zagreus_0132",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "{#Emph}Uh-huh. {#Prev}He probably just stands indulging in his twisted desire to be savaged by a variety of powerful weapons. Which I... now realize has started to rub off on {#Emph}me..." },
			},

			ZagreusBossAboutHomer01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Zagreus" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Storyteller_0496", IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice,
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PortraitExitAnimation = "Portrait_ZagPresent_Defiant_01_NoEnter_Exit",
					PreLineWait = 0.35,
					Text = "{#Emph}The Princess of the Dead again confronts her willful brother Zagreus, who has unlearned some of his finer fighting-skills whilst trapped in the clutches of the Titan of Time." },

				{ Cue = "/VO/Zagreus_0147",
					Portrait = "Portrait_ZagPresent_Defiant_01_NoEnter",
					PortraitExitAnimation = "Portrait_ZagPresent_Defiant_01_Exit",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Hey it's {#Emph}you{#Prev}, old man! I was beginning to wonder where you wound up. Abandoned me for my dear sister, is that it?" },

				{ Cue = "/VO/MelinoeField_4550", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "Wait, {#Emph}what? {#Prev}Homer's been with me all this time. How do you know each other? What did I miss...?" },

				{ Cue = "/VO/Zagreus_0148",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "I can't even begin trying to answer that right now. {#Emph}Homer{#Prev}, you say? I should have figured he'd have such a silly name. Well let's give him {#Emph}another {#Prev}tale to tell!" },
			},

			ZagreusBossAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 32,
					},
				},
				{ Cue = "/VO/Zagreus_0411",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "Fair warning, Sister, I am feeling very spry right now. You must have done something to the Mirror of Night. It's always made me feel more capable, but {#Emph}this {#Prev}is something else." },

				{ Cue = "/VO/MelinoeField_4991", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It isn't from the Mirror, I don't think, but I can safely say it is Night-related. You make a fearsome adversary, Zagreus... imbued with the dark strength of Nyx herself." },

				{ Cue = "/VO/Zagreus_0412",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					Text = "Oh, you did this {#Emph}somehow. {#Prev}Well fine! One of these days or nights I ought to fire up Father's old Pact of Punishment, and make {#Emph}you {#Prev}immensely strong, and we'll see how {#Emph}you {#Prev}like it!" },
			},

			ZagreusBossGrantsBondForged01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossGrantsKeepsakeOutro01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4541", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Will I ever see you again beyond the confines of this crowded competitive arena? We ought to be sharing Ambrosia, rather than trying to kill one another for sport." },

				{ Cue = "/VO/Zagreus_0124",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreLineAnim = "Zagreus_Talk_Start",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_ZagPresent_Default_01", WaitTime = 4.1 },

					Text = "Nobody knows but the Fates, and from what I've recently been hearing, perhaps not even them! As for the Ambrosia, you've already got a Keepsake from me, so no need!" },

				{ Cue = "/VO/MelinoeField_4542", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}What? {#Prev}Nectar and Ambrosia aren't just for barter! You of everyone must understand the value of forging strong bonds with relatives, comrades, and loved ones." },

				{ Cue = "/VO/Zagreus_0125",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Zagreus_01", Icon = "Keepsake_Zagreus" },

					Text = "Of course, but... we've been through quite a bit together at this point! And I've known you since before you were born. But here, we can make it official if you like!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/MelinoeField_4543", Text = "Well all right then! Now to the death?" },
					},
					{
						PreLineWait = 0.9,
						ObjectType = "Zagreus",
						TriggerCooldowns = { "ZagreusSpokeRecently" },

						{ Cue = "/VO/Zagreus_0126", Text = "To the death! Or close enough!" },
					},
				},
			},

			ZagreusBossAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusBossAboutParents01", "ZagreusBossAboutRelationships01" },
					},
				},

				{ Cue = "/VO/Zagreus_0155",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					PreLineAnim = "Zagreus_Talk_Start",
					Text = "You know I'm starting to worry all these Shades here think we truly get along, and that you're not the terrifying harbinger of the Underworld's vengeance you're cracked up to be." },

				{ Cue = "/VO/MelinoeField_4616", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What if I glower at you like this, and demand your head, if not your soul...?" },

				{ Cue = "/VO/Zagreus_0156",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", Portrait = "Portrait_ZagPresent_Defiant_01", WaitTime = 4.1, PlayZagreusTauntAnim = true },

					Text = "That works, and we can always keep our cordial little conversations nice and brief. Now face me, daemon-sister!" },
			},

			-- repeatable / other general cases
			ZagreusBossMiscStart01 =
			{
				{ Cue = "/VO/Zagreus_0176",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "All right, Little Sister, let's give these Shades of Elysium a match to remember!" },
			},
			ZagreusBossMiscStart02 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Zagreus_0177",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Know that if you {#Emph}do {#Prev}beat me it's because I'm going easy on you, all right?" },
			},
			ZagreusBossMiscStart03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = "<=",
						Value = 0,
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Name = "C_Boss01", Count = 2 },
					},
				},
				{ Cue = "/VO/Zagreus_0178",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					Text = "As much as I'm glad to see you, this attempt {#Emph}was {#Prev}going so well till you showed up..." },
			},
			ZagreusBossMiscStart04 =
			{
				{ Cue = "/VO/Zagreus_0179",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "We're much alike in that you, too, seem to enjoy accepting Contracts without reading them." },
			},
			ZagreusBossMiscStart05 =
			{
				{ Cue = "/VO/Zagreus_0180",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Your magick against my spear. Father's spear. You know what I mean." },
			},
			ZagreusBossMiscStart06 =
			{
				{ Cue = "/VO/Zagreus_0181",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "We'll have to catch up sometime without all the violence, but for now?" },
			},
			ZagreusBossMiscStart07 =
			{
				{ Cue = "/VO/Zagreus_0182",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Serious_01",
					Text = "I've fought through Elysium way too many times to back down now." },
			},
			ZagreusBossMiscStart08 =
			{
				{ Cue = "/VO/Zagreus_0183",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Our paths have crossed again, Sister! And our weapons are about to." },
			},
			ZagreusBossMiscStart09 =
			{
				{ Cue = "/VO/Zagreus_0184",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Brothers and sisters often fight like this as far as I'm aware." },
			},
			ZagreusBossMiscStart10 =
			{
				{ Cue = "/VO/Zagreus_0186",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Don't hold back against me now. The crowd won't have it!" },
			},
			ZagreusBossMiscStart11 =
			{
				{ Cue = "/VO/Zagreus_0187",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Just be thankful you're not fighting the previous Champion." },
			},
			ZagreusBossMiscStart12 =
			{
				{ Cue = "/VO/Zagreus_0188",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Well, Shades? Looks like we have a special exhibition match!" },
			},
			ZagreusBossMiscStart13 =
			{
				{ Cue = "/VO/Zagreus_0189",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "How do you always show up right in my moment of glory?" },
			},
			ZagreusBossMiscStart14 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.75, },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				{ Cue = "/VO/Zagreus_0190",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Empathetic_01",
					Text = "Oh hey Melinoë, how you're looking well! Though not for long perhaps, sorry..." },
			},
			ZagreusBossMiscStart15 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Zagreus_0191",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "You're worse than fighting Father! Don't tell him I said that." },
			},
			ZagreusBossMiscStart16 =
			{
				{ Cue = "/VO/Zagreus_0193",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Bring it on, Sister, I can do this all day. Night? Whenever!" },
			},
			ZagreusBossMiscStart17 =
			{
				{ Cue = "/VO/Zagreus_0194",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Come show me what the esteemed Schelemeus taught you." },
			},
			ZagreusBossMiscStart18 =
			{
				{ Cue = "/VO/Zagreus_0195",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Always a welcome break from my routine, Sister! Mostly." },
			},
			ZagreusBossMiscStart19 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Zagreus_0104" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Zagreus" }
					},
				},
				{ Cue = "/VO/Zagreus_0203",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Always a pleasure, Sister! Especially when I don't lose." },
			},
			ZagreusBossMiscStart20 =
			{
				{ Cue = "/VO/Zagreus_0204",
					PreLineThreadedFunctionName = "PlayZagreusTauntAnim",
					PostLineFunctionName = "StartZagreusBossFight", PreLineWait = 0.25,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_ZagPresent_Defiant_01",
					Text = "Far be it from me to disappoint all these expectant Shades, Sister!" },
			},
		},

		-- following are for when he exits the encounter
		BossOutroTextLineSets =
		{
			ZagreusBossOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Zagreus_0106",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Portrait = "Portrait_ZagPresent_Unwell_01",
					Text = "...{#Emph}Oof! {#Prev}You did not hold back at all, there. Blast..." },
				{ Cue = "/VO/MelinoeField_4241", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Zagreus, are you all right? I wasn't certain whether this was meant to be more for show or for real." },
				{ Cue = "/VO/Zagreus_0107",
					PreLineWait = 0.35,
					Portrait = "Portrait_ZagPresent_Pained_01",
					Text = "...I have to assume you decided {#Emph}for real {#Prev}was the way to go. Anyway, if anybody asks, I went easy on my little sister! Now if you'll excuse me, I, {#Emph}erm{#Prev}, lost a little blood..." },
			},

			ZagreusBossGrantsKeepsakeOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Zagreus_0321",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Portrait = "Portrait_ZagPresent_Pained_01",
					Text = "{#Emph}Augh... {#Prev}congratulations, Melinoë, for I have deemed you {#Emph}Blasted Strong{#Prev}. Well above {#Emph}Rather Strong {#Prev}on my scale." },

				{ Cue = "/VO/MelinoeField_4551", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 1.7 },

					Text = "Thank you, Brother, I try. Do you normally even win anything when you prevail in this place?" },

				{ Cue = "/VO/Zagreus_0322",
					PreLineWait = 0.35,
					Portrait = "Portrait_ZagPresent_Pained_01",
					Text = "...Usually just Darkness, but... I do have something for you here. I've always wanted to give somebody one of these..." },

				EndEvents =
				{
					{
						FunctionName = "GiveGiftDirectly",
						Args =
						{
						},
					},
				},

				EndVoiceLines =
				{
					PreLineWait = 1.0,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_4552", Text = "A Keepsake of some sort? {#Emph}Thank you!" },
				},
			},

			ZagreusBossOutro03 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Zagreus_0323",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Portrait = "Portrait_ZagPresent_Unwell_01",
					Text = "{#Emph}Oof... {#Prev}I didn't... bring you any other prizes... for your victory..." },

				{ Cue = "/VO/MelinoeField_4553", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's all right. I still have the Contract as an added benefit. Free goods from Charon's Shop is nothing to scoff at!" },

				{ Cue = "/VO/Zagreus_0324",
					PreLineWait = 0.35,
					Portrait = "Portrait_ZagPresent_Pained_01",
					Text = "...I'm glad... you feel... that way, I... ought to head on back..." },
			},

			ZagreusBossMiscDefeat01 =
			{
				{ Cue = "/VO/Zagreus_0329",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh...! {#Prev}All right, all right, you win this round... and I should go!" },
			},
			ZagreusBossMiscDefeat02 =
			{
				{ Cue = "/VO/Zagreus_0330",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Guh...! {#Prev}Well, I think it's time I made my dramatic exit... {#Emph}heh..." },
			},
			ZagreusBossMiscDefeat03 =
			{
				{ Cue = "/VO/Zagreus_0331",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ungh...! {#Prev}Would you... look at the time..." },
			},
			ZagreusBossMiscDefeat04 =
			{
				{ Cue = "/VO/Zagreus_0332",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh...! {#Prev}I forgot... something I need... back at the House..." },
			},
			ZagreusBossMiscDefeat05 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus01_B", "NeoChronosAboutOlympus01_B" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus02", "NeoChronosAboutOlympus02" }
					},
				},

				{ Cue = "/VO/Zagreus_0333",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Eugh... {#Prev}well go get Chronos then... or Typhon... either one..." },
			},
			ZagreusBossMiscDefeat06 =
			{
				{ Cue = "/VO/Zagreus_0334",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh...! {#Prev}Enjoy... the many benefits... of membership..." },
			},
			ZagreusBossMiscDefeat07 =
			{
				{ Cue = "/VO/Zagreus_0335",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Guh... {#Prev}the Shades... they love... a bit of drama... {#Emph}heh." },
			},
			ZagreusBossMiscDefeat08 =
			{
				{ Cue = "/VO/Zagreus_0336",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh{#Prev}, I'm fine, I'm... just a little winded... that's all...!" },
			},
			ZagreusBossMiscDefeat09 =
			{
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" },
							},
						},
					},
				},
				{ Cue = "/VO/Zagreus_0337",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh... {#Prev}I ought to... learn some magick... for myself..." },
			},
			ZagreusBossMiscDefeat10 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Zagreus" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{ Cue = "/VO/Zagreus_0338",
					Portrait = "Portrait_ZagPresent_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ow{#Prev}, you are a nightmare, let me tell you... not a witch..." },
			},
		},

		Using = { GrannyModel = "WeaponGigaros_Mesh", },
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Zagreus )

-- Global Zagreus Lines
GlobalVoiceLines.ZagreusRarifyVoiceLines = 
{
	PlayOnceFromTableThisRun = true,
	PlayOnceContext = "ZagreusRarifyVoiceLines",
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
	GameStateRequirements =
	{
		{
			PathTrue = { "GameState", "ReachedTrueEnding" },
		},
		{
			PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "RarifyKeepsake" },
		},
	},
	Cooldowns =
	{
		{ Name = "BoonRarifiedSpeech", Time = 60 },
	},

	{ Cue = "/VO/Zagreus_0388", Text = "Well sure!" },
	{ Cue = "/VO/Zagreus_0389", Text = "Sure." },
	{ Cue = "/VO/Zagreus_0390", Text = "Sure thing." },
	{ Cue = "/VO/Zagreus_0391", Text = "Rarified!" },
	{ Cue = "/VO/Zagreus_0392", Text = "Rarified." },
	{ Cue = "/VO/Zagreus_0393", Text = "You got it." },
	{ Cue = "/VO/Zagreus_0394", Text = "On the House!", PlayFirst = true },
	{ Cue = "/VO/Zagreus_0395", Text = "On the House." },
	{ Cue = "/VO/Zagreus_0396", Text = "This one's on me!" },
	{ Cue = "/VO/Zagreus_0397", Text = "Let me spot you." },
	{ Cue = "/VO/Zagreus_0398", Text = "I got this." },
	{ Cue = "/VO/Zagreus_0399", Text = "Here you go." },
	{ Cue = "/VO/Zagreus_0082_B", Text = "Oh hello..." },
	{ Cue = "/VO/Zagreus_0091_B", Text = "Cheers." },
	{ Cue = "/VO/Zagreus_0093_B", Text = "Why not!" },
	{ Cue = "/VO/Zagreus_0160_B", Text = "Oh hello!" },
	{ Cue = "/VO/Zagreus_0171_B", Text = "Back for more?" },
	{ Cue = "/VO/Zagreus_0173_B", Text = "Why hello." },
}

GlobalVoiceLines.ZagreusBossGreetingLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		ObjectType = "Zagreus",
		PreLineAnim = "Zagreus_Greet",

		{ Cue = "/VO/Zagreus_0115", Text = "{#Emph}Melinoë...!", PlayFirst = true },
		{ Cue = "/VO/Zagreus_0098", Text = "Melinoë...!" },

		{ Cue = "/VO/Zagreus_0157", Text = "Melinoë!" },
		{ Cue = "/VO/Zagreus_0158", Text = "Sister!" },
		{ Cue = "/VO/Zagreus_0159", Text = "Oh hi, Sister." },
		{ Cue = "/VO/Zagreus_0160", Text = "Oh hello!" },
		{ Cue = "/VO/Zagreus_0161", Text = "A challenger!" },
		{ Cue = "/VO/Zagreus_0162", Text = "Well look who!" },
		{ Cue = "/VO/Zagreus_0163", Text = "Hi there." },
		{ Cue = "/VO/Zagreus_0164", Text = "Contract again?" },
		{ Cue = "/VO/Zagreus_0165", Text = "Look, everyone!" },
		{ Cue = "/VO/Zagreus_0166", Text = "Look who!" },
		{ Cue = "/VO/Zagreus_0167", Text = "Look who's back!" },
		{ Cue = "/VO/Zagreus_0168", Text = "It's the Princess!" },
		{ Cue = "/VO/Zagreus_0170", Text = "You're back!" },
		{ Cue = "/VO/Zagreus_0172", Text = "Back again?" },
		{ Cue = "/VO/Zagreus_0173", Text = "Why hello." },
		{ Cue = "/VO/Zagreus_0174", Text = "I beg your pardon!" },
		{ Cue = "/VO/Zagreus_0405", Text = "{#Emph}Hello...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossFirstMeeting" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
				},
			},
		},
		{ Cue = "/VO/Zagreus_0408", Text = "{#Emph}Hah! {#Prev}Sorry.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossFirstMeeting" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
				},
			},
		},
		{ Cue = "/VO/Zagreus_0171", Text = "Back for more?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossFirstMeeting" },
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
					Comparison = ">=",
					Value = 0.2,
				},
			}
		},
		{ Cue = "/VO/Zagreus_0169", Text = "It's been a while!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossFirstMeeting" },
				},
				{
					SumPrevRuns = 5,
					IgnoreCurrentRun = true,
					Path = { "RoomsEntered", "C_Boss01" },
					Comparison = "==",
					Value = 0,
				},
			}
		},
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			--
		},

		{ Cue = "/VO/MelinoeField_4236", Text = "{#Emph}Wha... {#Prev}Brother!", PlayOnce = true, PlayOnceContext = "ZagreusBossFirstMeetingVO" },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
				Comparison = "<=",
				Value = 0,
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.5, },
			},
		},

		{ Cue = "/VO/MelinoeField_4999", Text = "Hello, Brother!" },
		{ Cue = "/VO/MelinoeField_5000", Text = "Hi there...!" },
		{ Cue = "/VO/MelinoeField_5001", Text = "{#Emph}Raaah!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossAboutHouse01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_5002", Text = "{#Emph}Hello{#Prev}, Brother...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossAboutHouse01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_5003", Text = "{#Emph}It is I!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossAboutHouse01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_5004", Text = "I have returned...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusBossAboutHouse01" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_5005", Text = "Brother." },
		{ Cue = "/VO/MelinoeField_5006", Text = "...Hi." },
	},
}

GlobalVoiceLines.ZagreusInvulnerableVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	GameStateRequirements =
	{
		ChanceToPlay = 0.25,
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "ZagreusSpokeRecently", Time = 14 },
	},

	{ Cue = "/VO/Zagreus_0378", Text = "{#Emph}Uh-uh!" },
	{ Cue = "/VO/Zagreus_0379", Text = "No you don't." },
	{ Cue = "/VO/Zagreus_0380", Text = "Sorry!" },
	{ Cue = "/VO/Zagreus_0381", Text = "Didn't hurt!" },
}

GlobalVoiceLines.ZagreusMeleePreAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ObjectType = "Zagreus",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
			Comparison = ">=",
			Value = 0.2,
		},
		ChanceToPlay = 0.2,
	},
	Cooldowns =
	{
		{ Name = "ZagreusSpokeRecently", Time = 14 },
	},

	{ Cue = "/VO/Zagreus_0216", Text = "Here!" },
	{ Cue = "/VO/Zagreus_0217", Text = "Here...!" },
	{ Cue = "/VO/Zagreus_0218", Text = "Sister!" },
	{ Cue = "/VO/Zagreus_0219", Text = "Now...!" },
	{ Cue = "/VO/Zagreus_0220", Text = "{#Emph}Now!" },
	{ Cue = "/VO/Zagreus_0221", Text = "All right!" },
	{ Cue = "/VO/Zagreus_0222", Text = "Come on!" },
	{ Cue = "/VO/Zagreus_0223", Text = "{#Emph}Hyah!" },
	{ Cue = "/VO/Zagreus_0224", Text = "{#Emph}Hruh!" },
	{ Cue = "/VO/Zagreus_0225", Text = "Take... {#Emph}this!" },
	{ Cue = "/VO/Zagreus_0226", Text = "Watch this!", PlayFirst = true },
	{ Cue = "/VO/Zagreus_0227", Text = "Fine!" },
	{ Cue = "/VO/Zagreus_0228", Text = "How's {#Emph}this?" },
	{ Cue = "/VO/Zagreus_0229", Text = "Don't blink!" },
	{ Cue = "/VO/Zagreus_0230", Text = "{#Emph}Hello!" },
	{ Cue = "/VO/Zagreus_0231", Text = "Back off!" },
}
GlobalVoiceLines.ZagreusRangedPreAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ObjectType = "Zagreus",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
			Comparison = ">=",
			Value = 0.2,
		},
		ChanceToPlay = 0.2,
	},
	Cooldowns =
	{
		{ Name = "ZagreusSpokeRecently", Time = 14 },
	},

	{ Cue = "/VO/Zagreus_0232", Text = "Catch!" },
	{ Cue = "/VO/Zagreus_0233", Text = "Dodge {#Emph}this!", PlayFirst = true },
	{ Cue = "/VO/Zagreus_0234", Text = "{#Emph}Fire!" },
	{ Cue = "/VO/Zagreus_0235", Text = "Another?" },
	{ Cue = "/VO/Zagreus_0236", Text = "Another!" },
	{ Cue = "/VO/Zagreus_0237", Text = "Here, Sis!" },
	{ Cue = "/VO/Zagreus_0238", Text = "Hold it!" },
	{ Cue = "/VO/Zagreus_0239", Text = "Heads up!" },
	{ Cue = "/VO/Zagreus_0240", Text = "For you!" },
	{ Cue = "/VO/Zagreus_0241", Text = "Got you {#Emph}this!" },
	{ Cue = "/VO/Zagreus_0242", Text = "Have one!" },
	{ Cue = "/VO/Zagreus_0243", Text = "Surprise!" },
}

GlobalVoiceLines.ZagreusBoilingBloodVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "Zagreus",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "ZagreusSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Zagreus_0418", Text = "You're in for it..." },
	{ Cue = "/VO/Zagreus_0419", Text = "Watch out, Sis...", PlayFirst = true },
	{ Cue = "/VO/Zagreus_0420", Text = "Feel that...?" },
	{ Cue = "/VO/Zagreus_0421", Text = "Caught you." },
	{ Cue = "/VO/Zagreus_0422", Text = "What a shot!" },
	{ Cue = "/VO/Zagreus_0423", Text = "Too slow!" },
}