UnitSetData.InfestedCerberus =
{
	InfestedCerberus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		MaxHealth = 21500,

		AttachedAnimationName = "CerbBibFront",

		DamagedFxAtImpactLocation = true,
		
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

		MaxHitShields = 25,
		LoadPackages = { "Cerberus", },
		RunHistoryPortrait = "Codex_Portrait_InfestedCerberus",

		Material = "Organic",
		HealthBarTextId = "InfestedCerberus",
		AltHealthBarTextIds =
		{
			{
				TextId = "InfestedCerberus_Named",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0934" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
				},
			},
			{ TextId = "InfestedCerberus_AltFight01",
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

		PreBossHealthBarSetupFunctionName = "InfestedCerberusSpawnPresentation",

		SpawnEvents =
		{
			{
				FunctionName = "InfestedCerberusSetupPresentation",
			}
		},


		IncomingDamageModifiers =
		{
			{
				TrapDamageTakenMultiplier = 0,
			},
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
		},
		
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					MaxHealth = 31500,
					GrannyTexture = "GR2/InfestedCerberusEM_Color",
					AISetupDelay = 1.0,
					AIEndHealthThreshold = 0.65,
					InvulnerableHitFx = "SatyrShieldBlock",
					ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
					ProjectileBlockFunctionName = "BlockDumbFireWeapons",
					ProjectileBlockDumbFireWeapons = { "InfestedCerberusFireballCone_Block" },
					BlockDumbFireBlacklist =
					{
						-- Casts
						DemeterCastBlast = {},
						PoseidonCastSplashSplinter = {},
						HephCastBlast = {},
						IcarusHazardExplosion = {},
						ArtemisCastVolley = {},
						WeaponCastProjectileHades = {},
						AthenaCastProjectile = {},

						-- Aspects
						FamiliarLinkLaser = {},
						ProjectileTorchBall = { RequiredTraitName = "TorchAutofireAspect", },
						ProjectileTorchSupayBallEx = {},
						ProjectileStaffSingle = {},
						ProjectileStaffWall = {},

						-- Familiars
						CatFamiliarPounce = {},
						FrogFamiliarLand = {},
						RavenFamiliarMelee = {},
						RavenFamiliarMelee_Crit = {},
						PolecatFamiliarMelee = {},
					},
					BlockDumbFireWeaponsCooldown = 0.4,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 600,
								Window = 0.6,
								MaxComboBreakers = 4,
								ComboBreakerCooldown = 11,
								ForcedWeaponInterrupt = "InfestedCerberusBlock",
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
		BossDifficultyShrineRequiredCount = 3,

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
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						-- New
						"InfestedCerberusBackSwipeR",
						"InfestedCerberusBackSwipeL",

						-- Melee
						"InfestedCerberusSwipe", 
						"InfestedCerberusSwipe", 
						"InfestedCerberusTurnSlam",
						"InfestedCerberusPoundL",
						"InfestedCerberusPoundR",

						"InfestedCerberusHowlSummonSelector",
						"InfestedCerberusHowlSummonSelector",

						-- Ranged
						"InfestedCerberusFireStream_Short",
						"InfestedCerberusMiasmaGeyser",
						"InfestedCerberusFireBallCombo",
					},
					DumbFireWeapons = { "InfestedCerberusCirclesP1_EM" },
					DataOverrides =
					{
						ForcedNextWeapon = "InfestedCerberusFireStream_Short",
					},
					AIData =
					{
						AIEndHealthThreshold = 0.65,
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			-- Phase 1 Spawns
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CerberusStageExit",
				RandomSpawnEncounter = { "CerberusSpawns01", "CerberusSpawns02", "CerberusSpawns03", "CerberusSpawns04", "CerberusSpawns05", },
				EMStageDataOverrides =
				{
					RandomSpawnEncounter = { "CerberusEMSpawns01", "CerberusEMSpawns02", "CerberusEMSpawns03", "CerberusEMSpawns04", "CerberusEMSpawns04" },
					KillDumbFireThreads = true,
					TransitionDumbFireAttack = "InfestedCerberusBurrowMiasmaMagma_EM",

					AIData =
					{
						AIEndWithSpawnedEncounter = true,
						AIEndWithSpawnedEncounterTimeout = 14,
					},
				},
				NewVulnerability = false,

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
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">", Value = 0.2, },
						},
					},
					SkipCooldownCheckIfNonePlayed = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
					{
						RandomRemaining = true,
						UsePlayerSource = true,
						PreLineWait = 2.35,
						SuccessiveChanceToPlay = 0.75,
						SuccessiveChanceToPlayAll = 0.25,

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
						SuccessiveChanceToPlay = 0.75,
						SuccessiveChanceToPlayAll = 0.25,

						{ Cue = "/VO/MelinoeField_3535", Text = "Which infernal pit did you come from?", PlayFirst = true,
							PreLineWait = 2.25,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
									Comparison = ">=",
									Value = 3,
								},
							}
						},
						{ Cue = "/VO/MelinoeField_2120", Text = "You all stay out of this!", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_2121", Text = "You leave that dog alone!" },
						{ Cue = "/VO/MelinoeField_2122", Text = "Stop bothering the dog!" },
						{ Cue = "/VO/MelinoeField_2123", Text = "You get out of here!" },
						{ Cue = "/VO/MelinoeField_2124", Text = "Tormenting him are you?" },
						{ Cue = "/VO/MelinoeField_2125", Text = "Infested with these things..." },
						{ Cue = "/VO/MelinoeField_2126", Text = "All these Daemons..." },
					},

				},
			},
			-- Phase 2
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
				EMStageDataOverrides =
				{
					EquipWeapons =
					{
						-- New
						--"InfestedCerberusBackSwipeR",

						-- melee
						"InfestedCerberusPoundCombo",
						"InfestedCerberusPoundCombo",

						"InfestedCerberusForwardBite",
						"InfestedCerberusForwardBite",

						"InfestedCerberusLungeTurn",
						"InfestedCerberusTurnSlam",
						
						-- ranged
						--"InfestedCerberus_C_Breath",
						"InfestedCerberusFireStreamLungeCombo",

						"InfestedCerberusFireBallCombo2",

						-- special
						"InfestedCerberusBurrow",
						"InfestedCerberusBurrow",
						-- "InfestedCerberusHowlSummonSelectorPhase2", -- removed until mini-lycan heads are in
						--"InfestedCerberusHowlSummonFogEmitters", -- Forced first and fires once
					},
					DumbFireWeapons = { "InfestedCerberusCirclesP2_EM" },
					TransitionArgs =
					{
						GrannyTexture = "GR2/InfestedCerberusEM2_Color",
						TransitionRadialCount = 2,
						TransitionRadialInitialId = 621276,
						TransitionRadialIds = { 739776, 739811, 739924, 792223, 739937, 739788, 739780 },
					},
				},

				StageTransitionVoiceLines =
				{
					{
						PlayOnce = true,
						-- RandomRemaining = true,
						BreakIfPlayed =  true,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 3,
							},
						},

						{ Cue = "/VO/MelinoeField_3533", Text = "He's cooling off...!", PlayFirst = true, },
						{ Cue = "/VO/MelinoeField_3534", Text = "Down to his final coat..." },
					}
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
				{ Cue = "/VO/MelinoeField_4572", Text = "All right, boy, calm yourself!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4573", Text = "Enough trying to massacre me just for fun!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4574", Text = "I'd say we have sufficiently retraced our steps...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4575", Text = "Looks like you've had enough for now!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4576", Text = "Heel, boy, that's enough!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4577", Text = "There! You must be tuckered out by now!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4186", Text = "Playtime... is {#Emph}over!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4187", Text = "Playtime... is {#Emph}over...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
			}
		},

		PostOutroVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "CerberusFirstDefeatVO",
				PreLineWait = 2.0,
				UsePlayerSource = true,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_0936", Text = "Where did he go...?", BreakIfPlayed = true },
			},
			{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.0,
				SuccessiveChanceToPlayAll = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0937", Text = "Feel better, Cerberus..." },
				{ Cue = "/VO/MelinoeField_0938", Text = "You're safe now, you're all right...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0939", Text = "You're looking better already..." },
				{ Cue = "/VO/MelinoeField_0941", Text = "You're free again, for now.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "CerberusBossMiscOutro12" },
						},
					},
				},
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
				{ Cue = "/VO/Storyteller_0188", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
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
				{ Cue = "/VO/Storyteller_0299", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}His rage dispelled, and his true form revealed, infernal watch-dog Cerberus regards the Underworld Princess with but the faintest glint of recognition in his six terrible eyes." },
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
				{ Cue = "/VO/Storyteller_0190", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Placated for the moment, terrifying Cerberus turns his attention from the Princess to the gates of Tartarus below." },
			},
			CerberusBossMiscOutro02 =
			{
				{ Cue = "/VO/Storyteller_0191", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Whether he fought ferociously or merely played, three-headed terror Cerberus does not let on." },
			},
			CerberusBossMiscOutro03 =
			{
				{ Cue = "/VO/Storyteller_0192", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The bestial triple-headed guardian of Tartarus regains his senses once again." },
			},
			CerberusBossMiscOutro04 =
			{
				{ Cue = "/VO/Storyteller_0193", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}His coat all matted still with gaping souls, the Hound of Hell nevertheless seems satisfied." },
			},
			CerberusBossMiscOutro05 =
			{
				{ Cue = "/VO/Storyteller_0194", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Unmired for the moment, fearsome Cerberus gives the Princess an appreciative look." },
			},
			CerberusBossMiscOutro06 =
			{
				{ Cue = "/VO/Storyteller_0195", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}A flash of recognition passes 'cross the countenances of the monstrous Hound of Hell." },
			},
			CerberusBossMiscOutro07 =
			{
				{ Cue = "/VO/Storyteller_0196", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Cleansed of his thick miasma-coat, the triple-headed Cerberus finally relents." },
			},
			CerberusBossMiscOutro08 =
			{
				{ Cue = "/VO/Storyteller_0197", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Three frightful yet familiar canine countenances then emerge." },
			},
			CerberusBossMiscOutro09 =
			{
				{ Cue = "/VO/Storyteller_0198", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineSad",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Then all three monstrously sharp-fanged heads of Cerberus bend low in shame." },
			},
			CerberusBossMiscOutro10 =
			{
				{ Cue = "/VO/Storyteller_0199", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The beast-defeating Princess returns terrifying Cerberus to his senses and familiar form." },
			},
			CerberusBossMiscOutro11 =
			{
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				{ Cue = "/VO/Storyteller_0200", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The barely-breathing Princess of the Dead somehow manages to overcome the beast." },
			},
			CerberusBossMiscOutro12 =
			{
				{ Cue = "/VO/Storyteller_0201", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Three-headed Cerberus tempers his boundless rage and hides for now his fangs." },
			},
			CerberusBossMiscOutro13 =
			{
				{ Cue = "/VO/Storyteller_0202", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhineHappy",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Relieved at last of an infernal itchy-spot, the fire-breathing watchdog looks appeased." },
			},
			CerberusBossMiscOutro14 =
			{
				{ Cue = "/VO/Storyteller_0203", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Three red and many-fanged maws turn now appreciatively toward the Princess of the Dead." },
			},
			CerberusBossMiscOutro15 =
			{
				{ Cue = "/VO/Storyteller_0204", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The dreaded Hound of Hell assumes again a shape so sinister as scarce can be described." },
			},
			CerberusBossMiscOutro16 =
			{
				{ Cue = "/VO/Storyteller_0205", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}What constitutes mere playtime for the terrifying Hound of Hell is ended for the while." },
			},
			CerberusBossMiscOutro17 =
			{
				{ Cue = "/VO/Storyteller_0206", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The grim resourceful Underworld Princess somehow soothes the savage beast." },
			},
			CerberusBossMiscOutro18 =
			{
				{ Cue = "/VO/Storyteller_0207", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}After a furious and world-shaking clash, the dreadful Cerberus recovers his true form." },
			},
			CerberusBossMiscOutro19 =
			{
				{ Cue = "/VO/Storyteller_0208", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Finally the vengeful Princess overcomes again the hellish monster standing in her way." },
			},
			CerberusBossMiscOutro20 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Storyteller_0468", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Nightmarish Cerberus regains composure and again sets off, perhaps to notify his master that his daughter is nearby." },
			},
			CerberusBossMiscOutro21 =
			{
				{ Cue = "/VO/Storyteller_0470", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The fire-spewing hound of hell grows momentarily quite calm, having detected finally the Princess of the Dead." },
			},
			CerberusBossMiscOutro22 =
			{
				{ Cue = "/VO/Storyteller_0471", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The many tiny daemons causing hellish Cerberus to itch and scratch so much no longer bother him, for now." },
			},
			CerberusBossMiscOutro23 =
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
				{ Cue = "/VO/Storyteller_0472", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Even the hottest flames can be extinguished, though the three-headed guardian of hell could always summon more." },
			},
			CerberusBossMiscOutro24 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0469", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}If all of this was but a playful game for the three-headed Cerberus, then he at least is finally tuckered out." },
			},
			CerberusBossMiscOutro25 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},				
				{ Cue = "/VO/Storyteller_0489", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Playtime at last is over for old Cerberus, but he shall have another playtime hence." },
			},
			CerberusBossMiscOutro26 =
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
				{ Cue = "/VO/Storyteller_0490", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The ever-burning hound of hell has finally cooled off for the time being." },
			},
			CerberusBossMiscOutro27 =
			{	
				{ Cue = "/VO/Storyteller_0491", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The dreaded watchdog of the gates of Hell decides the time has come to take his leave." },
			},
			CerberusBossMiscOutro28 =
			{	
				{ Cue = "/VO/Storyteller_0492", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Ferocious fully-clean and multi-headed Cerberus descends again into the comfort of his pit." },
			},
			CerberusBossMiscOutro29 =
			{	
				{ Cue = "/VO/Storyteller_0493", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The Princess once again somehow withstands the fangs and flames of Cerberus himself." },
			},
			CerberusBossMiscOutro30 =
			{	
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0510", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Playtime for the multi-headed hound of hell is ended for the eve." },
			},
			CerberusBossMiscOutro31 =
			{	
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0511", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}Ensuring time flows freely forth apparently requires cleaning up the mired hound of hell." },
			},
			CerberusBossMiscOutro32 =
			{	
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0512", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}For this most-brutal and ferocious beast, all that preceded merely was a treat." },
			},
			CerberusBossMiscOutro33 =
			{	
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0513", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}The fire-breathing guardian of hell has had his fill of brisk activity for the time being." },
			},
			CerberusBossMiscOutro34 =
			{	
				{ Cue = "/VO/Storyteller_0514", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}After some thought, ferocious Cerberus decides not to devour the Princess." },
			},
			CerberusBossMiscOutro35 =
			{	
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0515", PreLineWait = 0.75, IsNarration = true, LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice, StartSound = "/VO/CerberusWhine",
					Portrait = "Portrait_Cerberus_Default_01",
					Text = "{#Emph}This sure beats guarding Underworld gates, the monstrous hound perhaps is thinking at this time." },
			},
		},

		Using = { CerberusSounds =
					{
						"/VO/CerberusWhine",
						"/VO/CerberusWhineHappy",
						"/VO/CerberusWhineSad",
						"/VO/CerberusGrowl",
						"/VO/CerberusCuteGrowl_1",
						"/VO/CerberusCuteGrowl_2",
						"/VO/CerberusCuteGrowl_3",
						"/VO/CerberusCuteGrowl_4",
					},
				},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.InfestedCerberus )