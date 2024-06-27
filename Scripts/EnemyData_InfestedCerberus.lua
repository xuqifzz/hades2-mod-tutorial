UnitSetData.InfestedCerberus =
{
	InfestedCerberus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		MaxHealth = 20500,

		AttachedAnimationName = "CerbBibFront",
		
		--InvulnerableFx = "Invincibubble_Scylla",
		InvulnerableFx = "Blank",
		SpeechCooldownTime = 11,
		Groups = { "GroundEnemies" },

		OnDeathFunctionName = "InfestedCerberusKillPresentation",
		OnDeathFunctionArgs = { Message = "CerberusDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = false, FlashRed = true, AddInterBiomeTimerBlock = true },
		DeathAnimation = "Enemy_InfestedCerberus_DeathTransition",
		UsingGrannyModel = "Cerberus_Mesh",
		DeathPanOffsetY = -140,
		DeathFx = "CerberusTeleportCloud",
		DeathAngle = 210,

		BackstabDistance = 320,
		BackstabDistanceScaleY = 0.6,

		OnHitFlash = { MaxFraction = 0.45 },

		Material = "Organic",
		HealthBarTextId = "InfestedCerberus",
		AltHealthBarTextIds =
		{
			{ TextId = "InfestedCerberus_Named", Requirements = { RequiredPlayed = { "/VO/MelinoeField_0934" } } },
		},

		PreBossHealthBarSetupFunctionName = "InfestedCerberusSpawnPresentation",

		SpawnEvents =
		{
			{
				FunctionName = "InfestedCerberusSetupPresentation",
			}
		},
		
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,
		DefaultAIData =
		{
		},

		WeaponOptions =
		{
			-- Melee
			"InfestedCerberusSwipe", 
			"InfestedCerberusSwipe", 
			"InfestedCerberusTurnSlam",
			"InfestedCerberusPoundL",
			"InfestedCerberusPoundR",

			-- Special
			"InfestedCerberusCirclesP1_Intro",
			"InfestedCerberusCircleSelectorP1",

			"InfestedCerberusHowlSummonSelector",
			"InfestedCerberusHowlSummonSelector",

			-- Ranged
			"InfestedCerberusMiasmaGeyser",
			"InfestedCerberusFireBallCombo",
			"InfestedCerberusVacuumC",
		},


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
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CerberusStageExit",
				RandomSpawnEncounter = { "CerberusSpawns01", "CerberusSpawns02", "CerberusSpawns03", "CerberusSpawns04", "CerberusSpawns05", },

				AIData =
				{
					AIEndWithSpawnedEncounter = true,
					AIEndWithSpawnedEncounterTimeout = 20,
				},
				UnequipAllWeapons = true,
				EquipWeapons =
				{
					"InfestedCerberusHide",
				},

				StageTransitionVoiceLines =
				{
					Cooldowns =
					{
						{ Name = "CerberusStageTransitionVO", Time = 120 },
					},
					{
						RandomRemaining = true,
						UsePlayerSource = true,
						PreLineWait = 1.4,
						SuccessiveChanceToPlayAll = 0.75,
						SuccessiveChanceToPlay = 0.25,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/MelinoeField_1243", Text = "Come to your senses, boy!" },
						{ Cue = "/VO/MelinoeField_2118", Text = "Hey, get back here...!", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_2119", Text = "Cerberus, come back...!" },
						{ Cue = "/VO/MelinoeField_1241", Text = "Just getting started..." },
						{ Cue = "/VO/MelinoeField_1242", Text = "And here we go..." },
						{ Cue = "/VO/MelinoeField_1244", Text = "This isn't who you are!" },
						{ Cue = "/VO/MelinoeField_1245", Text = "You'll soon be good and clean!",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
								}
							},
						},
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						PreLineWait = 1.5,
						SuccessiveChanceToPlayAll = 0.75,
						SuccessiveChanceToPlay = 0.25,

						{ Cue = "/VO/MelinoeField_2120", Text = "You all stay out of this!", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_2121", Text = "You leave that dog alone!" },
						{ Cue = "/VO/MelinoeField_2122", Text = "Stop bothering the dog!" },
						{ Cue = "/VO/MelinoeField_2123", Text = "You get out of here!" },
						{ Cue = "/VO/MelinoeField_2124", Text = "Tormenting him are you?" },
						{ Cue = "/VO/MelinoeField_2125", Text = "Infested with these things..." },
						{ Cue = "/VO/MelinoeField_2126", Text = "All these daemons..." },
					},

				},

			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CerberusStageEnter",
				UsingProjectile = "CerberusTransitionRadial",
				SkipTransitionInvulnerability = true,
				WaitDuration = 0,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons =
				{ 
					-- melee
					"InfestedCerberusPoundCombo",
					"InfestedCerberusPoundCombo",

					"InfestedCerberusForwardBite",
					"InfestedCerberusForwardBite",

					"InfestedCerberusLungeTurn",
					"InfestedCerberusTurnSlam",
					
					-- ranged
					"InfestedCerberus_C_Breath",
					"InfestedCerberus_C_Breath",

					"InfestedCerberusFireBallCombo2",

					-- special
					"InfestedCerberusBurrow",
					"InfestedCerberusBurrow",
					-- "InfestedCerberusHowlSummonSelectorPhase2", -- removed until mini-lycan heads are in
					--"InfestedCerberusHowlSummonFogEmitters", -- Forced first and fires once

					-- circles
					"InfestedCerberusCircleSelectorP2",
				},
			},
		},

		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SkipAnim = true,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1221", Text = "{#Emph}Spirits of Despair, begone!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1222", Text = "You Shades leave him alone!" },
				{ Cue = "/VO/MelinoeField_1223", Text = "Cerberus, you're free!" },
				{ Cue = "/VO/MelinoeField_1224", Text = "Now I release you!" },
			}
		},

		PostOutroVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			[1] =
			{
				PlayOnce = true,
				PreLineWait = 2.0,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0936", Text = "Where did he go...?", BreakIfPlayed = true },
			},
			[2] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
			[3] =
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.0,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0937", Text = "Feel better, Cerberus..." },
				{ Cue = "/VO/MelinoeField_0938", Text = "You're safe now, you're all right...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0939", Text = "You're looking better already..." },
				{ Cue = "/VO/MelinoeField_0941", Text = "You're free again, for now." },
				{ Cue = "/VO/MelinoeField_0942", Text = "Go find your master now.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
						}
					}
				},
				{ Cue = "/VO/MelinoeField_0943", Text = "Return now to your master and abode.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
						}
					}
				},
				{ Cue = "/VO/MelinoeField_0944", Text = "Now be at peace again." },
			},
		},

		BossOutroTextLineSets =
		{
			CerberusBossOutro01 =
			{
				PlayOnce = true,

				{ Cue = "/VO/MelinoeField_0934", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Cerberus... it's really you." },
				{ Cue = "/VO/Storyteller_0188", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Having shed its coat of torment, the soul-devouring Infernal Beast beyond the gates of Tartarus reveals that it is not the monster it appeared, but one more infamously vicious still." },
				EndVoiceLines =
				{
					PreLineWait = 2.0,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_0935", Text = "No, wait, stay!" },
				},
			},
			CerberusBossOutro02 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Storyteller_0189", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}His rage dispelled, and his true form revealed, infernal watch-dog Cerberus regards the Underworld Princess with mixed emotions, from purest joy to deepest melancholy." },
				EndVoiceLines =
				{
					PreLineWait = 1.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_0940", Text = "Now calm yourself. It's only me...!" },
				},
			},

			-- repeatable
			CerberusBossMiscOutro01 =
			{
				{ Cue = "/VO/Storyteller_0190", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Placated for the moment, terrifying Cerberus turns his attention from the Princess to the gates of Tartarus below." },
			},
			CerberusBossMiscOutro02 =
			{
				{ Cue = "/VO/Storyteller_0191", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Whether he fought ferociously or merely played, three-headed terror Cerberus does not let on." },
			},
			CerberusBossMiscOutro03 =
			{
				{ Cue = "/VO/Storyteller_0192", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}The bestial triple-headed guardian of Tartarus regains his senses once again." },
			},
			CerberusBossMiscOutro04 =
			{
				{ Cue = "/VO/Storyteller_0193", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}His coat all matted still with gaping souls, the Hound of Hell nevertheless seems satisfied." },
			},
			CerberusBossMiscOutro05 =
			{
				{ Cue = "/VO/Storyteller_0194", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Unmired for the moment, fearsome Cerberus gives the Princess an appreciative look." },
			},
			CerberusBossMiscOutro06 =
			{
				{ Cue = "/VO/Storyteller_0195", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}A flash of recognition passes 'cross the countenances of the monstrous Hound of Hell." },
			},
			CerberusBossMiscOutro07 =
			{
				{ Cue = "/VO/Storyteller_0196", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Cleansed of his thick miasma-coat, the triple-headed Cerberus finally relents." },
			},
			CerberusBossMiscOutro08 =
			{
				{ Cue = "/VO/Storyteller_0197", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Three frightful yet familiar canine countenances then emerge." },
			},
			CerberusBossMiscOutro09 =
			{
				{ Cue = "/VO/Storyteller_0198", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineSad",
					Text = "{#Emph}Then all three monstrously sharp-fanged heads of Cerberus bend low in shame." },
			},
			CerberusBossMiscOutro10 =
			{
				{ Cue = "/VO/Storyteller_0199", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}The beast-defeating Princess returns terrifying Cerberus to his senses and familiar form." },
			},
			CerberusBossMiscOutro11 =
			{
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.3,
				},
				{ Cue = "/VO/Storyteller_0200", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}The barely-breathing Princess of the Dead somehow manages to overcome the beast." },
			},
			CerberusBossMiscOutro12 =
			{
				{ Cue = "/VO/Storyteller_0201", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}Three-headed Cerberus tempers his boundless rage and hides for now his fangs." },
			},
			CerberusBossMiscOutro13 =
			{
				{ Cue = "/VO/Storyteller_0202", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhineHappy",
					Text = "{#Emph}Relieved at last of an infernal itchy-spot, the fire-breathing watchdog looks appeased." },
			},
			CerberusBossMiscOutro14 =
			{
				{ Cue = "/VO/Storyteller_0203", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}Three red and many-fanged maws turn now appreciatively toward the Princess of the Dead." },
			},
			CerberusBossMiscOutro15 =
			{
				{ Cue = "/VO/Storyteller_0204", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}The dreaded Hound of Hell assumes again a shape so sinister as scarce can be described." },
			},
			CerberusBossMiscOutro16 =
			{
				{ Cue = "/VO/Storyteller_0205", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}What constitutes mere playtime for the terrifying Hound of Hell is ended for the while." },
			},
			CerberusBossMiscOutro17 =
			{
				{ Cue = "/VO/Storyteller_0206", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}The grim resourceful Underworld Princess somehow soothes the savage beast." },
			},
			CerberusBossMiscOutro18 =
			{
				{ Cue = "/VO/Storyteller_0207", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}After a furious and world-shaking clash, the dreadful Cerberus recovers his true form." },
			},
			CerberusBossMiscOutro19 =
			{
				{ Cue = "/VO/Storyteller_0208", PreLineWait = 0.75, IsNarration = true, StartSound = "/VO/CerberusWhine",
					Text = "{#Emph}Finally the vengeful Princess overcomes again the hellish monster standing in her way." },
			},

		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.InfestedCerberus )