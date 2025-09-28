UnitSetData.TyphonHead =
{
	TyphonHead =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },
		InvulnerableFx = "nil",
		SubtitleColor = Color.TyphonVoice,
		SpeakerName = "Typhon",
		
		BlockPostBossMetaUpgrades = true,
		DamagedFxAtImpactLocation = true,

		DeathAnimation = "Enemy_TyphonHead_Death",
		OnDeathFunctionName = "TyphonHeadKillPresentation", 
		OnDeathFunctionArgs =
		{
			Message = "TyphonDefeatedMessage",
			StartPanTime = 3.5,
			EndPanTime = 5.5,
			PanZoomFraction = 0.7,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			BatsAfterDeath = false,
			FlashRed = true,
			AddInterBiomeTimerBlock = true,
			SpecialKillRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
				},
			},
		},
		DeathPanOffsetY = -750,
		TextLinesUseWeaponIdle = true,
		ClearChillOnDeath = true,
		HideVengeanceText = true,
		CatFamiliarAttackDistance = 500,

		FakeDeathAltMessages = { "TyphonDefeatedMessageAlt01" },
		KillThreadNamesOnDeath =  { "TyphonHeadWeaponCameraThread", "TyphonHeadIncursionThread" },

		Material = "Organic",
		DeathSound = "/SFX/StabSplatterEndSequence",

		Groups = { "EnemyTeam", "GroundEnemies" },

		StunAnimations = 
		{
			Default = "Enemy_TyphonHead_StunnedOnHit",
		},

		DaggerExMarker = "TyphonHead_Rig:eyeballForehead_00_M_JNT",
		DaggerExScale = 1.5,
		SuitMarkStatusMarkerName = "TyphonHead_Rig:eyeballForeheadIris_00_M_JNT",

		OnEffectApplyFunctionNames =
		{
			WeakEffect = "TyphonWeakEffectApply",
			BlindEffect = "TyphonBlindEffectApply",
		},
		OnEffectClearFunctionNames =
		{
			WeakEffect = "TyphonWeakEffectClear",
			BlindEffect = "TyphonBlindEffectClear",
		},
		
		UniqueIconAttachments = 
		{
			ComboEx = "TyphonHead_Rig:noseRing_00_M_JNT",
			ComboSpecial = "TyphonHead_Rig:noseRing_00_M_JNT",
			ComboAttack = "TyphonHead_Rig:noseRing_00_M_JNT",
			WeakEffect = "TyphonHead_Rig:noseRing_00_M_JNT",
			BlindEffect = "TyphonHead_Rig:eyeballForehead_00_M_JNT",
		},
		UniqueIconOffsets = 
		{
			ComboEx = { X = 0, Y = 100 },
			ComboSpecial = { X = 0, Y = 100 },
			ComboAttack = { X = 0, Y = 100 },
		},
		OnDamagedFunctionNames = { "UpdatedBossHealthBarRecord", },

		MaxHealth = 65000,
		HideHealthBar = true,
		AISetupDelay = 1.5,
		EffectVfxOffsetZ = 5000,
		HealthBarOffsetY = 150, -- Damage numbers offset
		HealthBarTextId = "TyphonHead_Full",
		IgnoreShieldShrine = true,

		IncomingDamageModifiers =
		{
			{
				FriendMultiplier = 0.0,
			},
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
		},
		EndThreadWaitsOnStun = false,

		VoiceLinePlayedEvents =
		{
			{
				FunctionName = "TyphonSpeakingPresentation",
				Threaded = true,
				Args =
				{
				},
			},
		},
		VoiceLinePostPlayedEvents =
		{
			{
				FunctionName = "TyphonSpeakingEndPresentation",
				Args =
				{					
				},
			},
		},

		AngleMin = 235,
		AngleMax = 305,

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					--[[
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 2500,
								Window = 1.0,
								ComboBreakerCooldown = 10.0,
								ForcedWeaponInterrupt = "TyphonHeadDefenseKnockback",
							},
						},
					},
					]]
					Phases = 2,
					OnDeathFunctionArgs =
					{
						Message = "TyphonDefeatedMessage",
						StartPanTime = 3.5,
						EndPanTime = 5.5,
						PanZoomFraction = 0.7,
						StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
						BatsAfterDeath = false,
						FlashRed = true,
						AddInterBiomeTimerBlock = true,
						SubtitleTextOptions = { "TyphonDefeatedSubtitle" },
						SpecialKillRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
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
							Value = 4,
						},
					},
				},
			},
		},
		BossDifficultyShrineRequiredCount = 4,

		DefaultAIData =
		{
			MoveWithinRange = false,
			AttackDistance = 9999,
			PreAttackEndMinWaitTime = 0.3,
			SpawnCountDampenTraits = { HadesChronosDebuffBoon = true, },
		},
		WeaponOptions =
		{
			"TyphonHeadRam", "TyphonHeadRoar", "TyphonHeadTongue", "TyphonHeadCenterEye", "TyphonHeadVolley",
			--"TyphonHeadTongueSlamA", "TyphonHeadLaugh"
		},
		AIEndHealthThreshold = 52500/65000,
		AIStages =
		{
			-- 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				DumbFireWeapons =
				{
					"TyphonHeadGust",
				},
				AIData =
				{
					AIEndHealthThreshold = 52500/65000,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					DataOverrides =
					{
						ForcedNextWeapon = "TyphonHeadTongueSlamA",
						--ComboBreakersUsed = 0,
					},
					EquipWeapons =
					{
						"TyphonHeadRam", "TyphonHeadRoar", "TyphonHeadTongue", "TyphonHeadCenterEye", "TyphonHeadVolley",
						"TyphonHeadTongueSlamA"
					},
					DumbFireWeapons = {},
				},
			},
			-- 2 & Spawns 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireRandomWeapon = { "TyphonHeadCastSummon01", "TyphonHeadCastSummon03", },
				UnequipAllWeapons = true,
				KillDumbFireThreads = true,
				EquipWeapons = {
					"TyphonHeadRam", "TyphonHeadRoar", "TyphonHeadTongue", "TyphonHeadCenterEye", "TyphonHeadVolley",
				},
				AIData =
				{
					AIEndHealthThreshold = 40000/65000,
				},
				EMStageDataOverrides =
				{
					FireRandomWeapon = { "TyphonHeadCastSummonCaptain", },
					EquipWeapons =
					{
						"TyphonHeadRam", "TyphonHeadRoar", "TyphonHeadTongue", "TyphonHeadCenterEye", "TyphonHeadVolley",
						"TyphonHeadTongueSlamA"
					},
					ThreadedEvents =
					{
						{
							FunctionName = "TyphonChronosStageTransition",
							Args =
							{
								ChronosWeapon = "ChronosEggPhaseCombo1",
							},
						},
					},
				},
			},
			-- 3 & Olympian Interlude
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				SkipTransitionInvulnerability = true,
				TransitionUnthreadedEvents =
				{
					{
						FunctionName = "TyphonHeadStageTransition",
					},
				},
				WipeEnemyTypes = { "BattleStandardChronos" },
				WaitDuration = 0,
				UnequipAllWeapons = true,
				ExpireProjectiles = { "TyphonHeadBoltDirect", "TyphonHeadBoltChaotic", "TyphonTornadoSpin", "TyphonTornado", },
				EquipWeapons = {
					"TyphonHeadEnrage", "TyphonHeadRam", "TyphonHeadTongue", "TyphonHeadCenterEye",
				},
				AIData =
				{
					AIEndHealthThreshold = 25000/65000,
				},
				EMStageDataOverrides =
				{
					EquipWeapons =
					{
						"TyphonHeadEnrage", "TyphonHeadRam", "TyphonHeadTongue", "TyphonHeadCenterEye",
						"TyphonHeadTongueSlamA"
					},
					TransitionUnthreadedEvents =
					{
						{
							FunctionName = "TyphonHeadStageTransitionEM",
						},
					},
					SetMapFlags =
					{ 
						{ FlagName = "ChronosLevel2" },
					},
				},
			},
			-- 4 & Spawns 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireRandomWeapon = { "TyphonHeadCastSummon02", "TyphonHeadCastSummon05", },
				UnequipAllWeapons = true,
				EquipWeapons = {
					"TyphonHeadRam2", "TyphonHeadTongue2", "TyphonHeadCenterEye2", "TyphonHeadVolleySky",
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EMStageDataOverrides =
				{
					EquipWeapons =
					{
						"TyphonHeadRam2", "TyphonHeadTongue2", "TyphonHeadCenterEye2", "TyphonHeadVolleySky",
						"TyphonHeadTongueSlamA"
					},
					FireRandomWeapon = { "TyphonHeadCastSummonBoar", "TyphonHeadCastSummonDragon" },
					ThreadedEvents =
					{
						{
							FunctionName = "TyphonChronosStageTransition",
							Args =
							{
								ChronosWeapon = "ChronosEggPhaseCombo2",
							},
						},
					},
				},
			},
			-- 5 & Babality
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "TyphonFakeDeathTransition",
				NewMaxHealth = 10000,
				UnequipAllWeapons = true,
				WipeEnemyTypes = { "BattleStandardChronos" },
				EquipWeapons =
				{
					-- During Babality
					"TyphonHeadRam", "TyphonHeadTongue2", "TyphonHeadCenterEye2",
					-- Post Babality
					"TyphonHeadWeakCombo", "TyphonHeadCenterEyeWeak",
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				DumbFireWeapons =
				{
					--"TyphonHeadGustEM",
					--"TyphonHeadTimeElementalSpawns",
				},
				SetMapFlags =
				{ 
					{ FlagName = "ChronosLevel3" },
				},
			},
		},

		BossIntroTextLineSets =
		{
			TyphonBossAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					-- @ back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "TyphonHeadAltFight01" }
					},
				},
				{ Cue = "/VO/Chronos_1065", PreLineWait = 0.35,
					Source = "NPC_Chronos_01",
					Text = "Beg pardon the interruption, Granddaughter, but I have come to see the work of my monstrous associate upon these hallowed heights. For I have only heard the tales!" },
				{ Cue = "/VO/MelinoeField_3783", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I know the real reason that you're here on such a night. Well, I've grown accustomed to dealing with you {#Emph}and {#Prev}Typhon both. Perhaps not all at once..." },
				{ Cue = "/VO/Chronos_1066",
					Source = "NPC_Chronos_01",
					-- PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					-- PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					-- PreLineThreadedFunctionName = "PlayHecateTauntAnim", PreLineWait = 0.35,
					-- PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh fear not, for I am but a harmless apparition presently. {#Emph}Harmless{#Prev}, inasmuch as you cannot harm {#Emph}me {#Prev}at all. Although the other way around... well, you shall see." },
			},
			TyphonBossAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "TyphonHead" },
					},
					{
						FunctionName = "RequiredConsecutiveDeathsInRoom",
						FunctionArgs = { Name = "Q_Boss02", Count = 1 },
					},
				},
				{ Cue = "/VO/Chronos_1231", PreLineWait = 0.35,
					Source = "NPC_Chronos_01",
					Text = "How can you possibly believe that you possess the wherewithal to overcome us both? For even {#Emph}my {#Prev}considerable strength pales in comparison to that of the {#Emph}Father of All Monsters!" },
				{ Cue = "/VO/MelinoeField_3784", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I've vanquished each of you before. I see no reason why I couldn't do it again. You'll likely just be getting in each other's way." },
				{ Cue = "/VO/Chronos_1232",
					Source = "NPC_Chronos_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I do think that Typhon shall be {#Emph}inconvenienced {#Prev}by me. But as for {#Emph}you{#Prev}, my girl... well, let us imminently see." },
			},
			TyphonBossAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "TyphonHead" },
					},
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Name = "Q_Boss02", Count = 1 },
					},
				},
				{ Cue = "/VO/Chronos_1233", PreLineWait = 0.35,
					Source = "NPC_Chronos_01",
					Text = "It is impossible or at least utterly preposterous that you were somehow able to subdue the monster Typhon here, whilst I myself was harrying you with my various techniques! But you shall not be quite so fortunate again." },
				{ Cue = "/VO/MelinoeField_3785", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And what makes you think that? You're only here because the will of Night has brought you directly to me so I can deal with you both at once." },
				{ Cue = "/VO/Chronos_1234",
					Source = "NPC_Chronos_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Mere witchery and {#Emph}lies! {#Prev}The apparition that you see exists entirely because of my own will! To think that you could summon one such as I merely at {#Emph}whim!" },
			},
			TyphonBossAltFight04 =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "TyphonHead" },
					},
					{
						Path = { "GameState", "RoomsEntered", "Q_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Chronos_1235", PreLineWait = 0.35,
					Source = "NPC_Chronos_01",
					Text = "How many times are you going to drag my apparition all the way up here? Although I ought point out that doing so requires practically no effort on my part!" },
				{ Cue = "/VO/MelinoeField_3786", UsePlayerSource = true,
					Text = "Good, as I'd hate to inconvenience you, Grandfather; you should be off relaxing somewhere at your age. I hear the Isles of the Blessed are very comfortable!" },
				{ Cue = "/VO/Chronos_1236",
					Source = "NPC_Chronos_01",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh I am not considering retirement, my girl. It is {#Emph}you {#Prev}who should be giving it some serious thought instead." },
			},

		},

		BossPhaseChangeTextLineSets =
		{
			TyphonAltFightFinalRound01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3790", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Damn you{#Prev}, Chronos! Once I'm through with Typhon, I am coming after {#Emph}you!" },
				{ Cue = "/VO/Chronos_1161",
					Emote = "PortraitEmoteFiredUp",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "You are nothing but a pathetic child! May you always remember that, should you somehow withstand what shall imminently transpire!" },
			},

			TyphonAltFightFinalRound02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3791", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "Undo what you have done to me at once, or I shall purge you from existence, Titan!" },
				{ Cue = "/VO/Chronos_1162",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "My, how {#Emph}frightening. {#Prev}But it is most improper for a child to speak so rudely to her grandfather... so you shall have to be {#Emph}punished." },
			},
			TyphonAltFightFinalRound03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3792", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "How is this even possible? I am no longer the mere child I once was, and yet..." },
				{ Cue = "/VO/Chronos_1163",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Always remember how small and frightened you once must have felt. Inside, you are {#Emph}still {#Prev}that same old wretched girl." },
			},
			TyphonAltFightFinalRound04 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3793", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "You may chortle with that monster all you like, Titan, but the final laughter shall be mine alone!" },
				{ Cue = "/VO/Chronos_1164",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "There is no way to turn back Time. But I can make exceptions here and there... because I {#Emph}make the blasted rules!" },
			},
			TyphonAltFightFinalRound05 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3794", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					Text = "Do you think this is funny, Titan?!" },
				{ Cue = "/VO/Chronos_1165",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Let me remind you just how small and weak you truly are. We all grow older, yes, but none of us shall ever change in our entirety." },
			},
			TyphonAltFightFinalRound06 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3795", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "You have made a grave error in judgment!" },
				{ Cue = "/VO/Chronos_1166",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "To think if I was but a bit more careful then I could have taken {#Emph}you {#Prev}along with all the rest of your dear family; and saved myself the trouble {#Emph}here!" },
			},
			TyphonAltFightFinalRound07 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3796", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "How you shall {#Emph}suffer {#Prev}once I break this spell!" },
				{ Cue = "/VO/Chronos_1167",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Stubborn little {#Emph}brat! That {#Prev}is what you are. Look at yourself, in all your youthful frailty. This is all you {#Emph}ever {#Prev}were." },
			},
			TyphonAltFightFinalRound08 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3798", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "You'll soon learn that I'm {#Emph}not {#Prev}the little girl I once was!" },
				{ Cue = "/VO/Chronos_1168",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Know your insignificance, child! You may pitter-patter all about now to your heart's content. I certainly care {#Emph}not!" },
			},
			TyphonAltFightFinalRound09 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3797", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "There shall be consequences for humiliating me!" },
				{ Cue = "/VO/Chronos_1169",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Alas that you were raised without appropriate parental guidance for you lack even the most basic manners, even for a rotten little girl!" },
			},
			TyphonAltFightFinalRound10 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3799", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "Laugh all you like, you wretched fools!" },
				{ Cue = "/VO/Chronos_1170",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "You clearly never learned to listen to your elders, girl, so {#Emph}fine! {#Prev}I am quite finished with attempts at {#Emph}reasoning {#Prev}with you." },
			},
			TyphonAltFightFinalRound11 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3794", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "Do you think this is funny, Titan?!" },
				{ Cue = "/VO/Chronos_1171",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "Your {#Emph}mother {#Prev}would have been so very {#Emph}proud {#Prev}of the delightful little girl you once were! {#Emph}Ah {#Prev}well." },
			},
			TyphonAltFightFinalRound12 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3796", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "How you shall {#Emph}suffer {#Prev}once I break this spell!" },
				{ Cue = "/VO/Chronos_1172",
					Source = "NPC_Chronos_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "{#Emph}Poor little girl{#Prev}, are you going to {#Emph}cry? {#Prev}For all the {#Emph}hardship {#Prev}which you have endured?" },
			},

			-- repeatable
			TyphonAltFightRoundShort01 =
			{
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3794", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "Do you think this is funny, Titan?!" },
			},
			TyphonAltFightRoundShort02 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3795", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "You have made a grave error in judgment!" },
			},
			TyphonAltFightRoundShort03 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3796", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "How you shall {#Emph}suffer {#Prev}once I break this spell!" },
			},
			TyphonAltFightRoundShort04 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3798", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "You'll soon learn that I'm {#Emph}not {#Prev}the little girl I once was!" },
			},
			TyphonAltFightRoundShort05 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3797", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "There shall be consequences for humiliating me!" },
			},
			TyphonAltFightRoundShort06 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/MelinoeField_3799", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_Defiant_01",
					Speaker = "PlayerUnit_Flashback",
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Text = "Laugh all you like, you wretched fools!" },
			},
		},		

		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "CurrentRoom", "TyphonHiding" },
				},
			},
			-- high health
			{
				PlayOnce = true,
				PlayOnceContext = "FirstTyphonDamageReportVO",
				UsePlayerSource = true,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelDamagingTyphonSpeech", Time = 90 },
					{ Name = "MelFacingTyphonSpeech", Time = 15 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3002" }
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0.98,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">=",
						Value = 0.63,
					},
					ChanceToPlay = 0.2,
				},
				{ Cue = "/VO/MelinoeField_3186", Text = "My strikes are getting through but...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3351" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3188", Text = "Is this even working...?" },
			},
			-- reduced health
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.1,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 12,
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3002" }
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0.88,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">=",
						Value = 0.64,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
					ChanceToPlay = 0.2,
				},
				Cooldowns =
				{
					{ Name = "MelDamagingTyphonSpeech", Time = 90 },
					{ Name = "MelFacingTyphonSpeech", Time = 11 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/MelinoeField_3192", Text = "Is he weakening...?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				-- { Cue = "/VO/MelinoeField_3189", Text = "Just a foe, it's just another foe..." },
				{ Cue = "/VO/MelinoeField_3190", Text = "He's strong but {#Emph}not {#Prev}immune...!" },
				{ Cue = "/VO/MelinoeField_3191", Text = "I have to wear him down...!" },
				{ Cue = "/VO/MelinoeField_3198", Text = "Where is Lord Zeus...?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "OlympianFinalBattleAssists" },
							Comparison = ">",
							Value = 1,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3199", Text = "Come on, Lord Zeus...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "OlympianFinalBattleAssists" },
							Comparison = ">",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3200", Text = "Lord Zeus should be here soon...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "OlympianFinalBattleAssists" },
							Comparison = ">",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3201", Text = "{#Emph}Anytime{#Prev}, Lord Zeus...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "OlympianFinalBattleAssists" },
							Comparison = ">",
							Value = 2,
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.5, },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3202", Text = "Where are you Lord Uncle...?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "OlympianFinalBattleAssists" },
							Comparison = ">",
							Value = 2,
						},
					},
				},
			},
			-- lower health
			{
				PlayOnce = true,
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.1,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = "<",
						Value = 0.5,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">=",
						Value = 0.3,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelDamagingTyphonSpeech", Time = 90 },
					{ Name = "OlympianArrivalSpeech", Time = 20 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_3193", Text = "He's growing angrier... or weakening...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3194", Text = "He can't hold on forever..." },
				{ Cue = "/VO/MelinoeField_3195", Text = "He's weakening, I feel it...!" },
				{ Cue = "/VO/MelinoeField_3196", Text = "He's weakening...!" },
				{ Cue = "/VO/MelinoeField_3197", Text = "He's wearing down...!" },
				{ Cue = "/VO/MelinoeField_3220", Text = "That's it...!" },
				{ Cue = "/VO/MelinoeField_3221", Text = "Keep pushing...!" },
				{ Cue = "/VO/MelinoeField_3222", Text = "Keep this up...!" },
				{ Cue = "/VO/MelinoeField_3223", Text = "Press on...!" },
				{ Cue = "/VO/MelinoeField_3224", Text = "It's working...!" },
			},
			-- low health
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ChanceToPlay = 0.1,
				SuccessiveChanceToPlayAll = 0.01,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = "<",
						Value = 0.3,
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">=",
						Value = 0.1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelDamagingTyphonSpeech", Time = 90 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_3215", Text = "He can't hold much longer...!" },
				{ Cue = "/VO/MelinoeField_3216", Text = "He's running out of strength...!" },
				{ Cue = "/VO/MelinoeField_3217", Text = "The last of his strength...!" },
				{ Cue = "/VO/MelinoeField_3218", Text = "He's losing his grip...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3219", Text = "He's losing control...!" },
			},

		},

		LowHealthVoiceLineThreshold = 0.5,
		LowHealthVoiceLines =
		{
			{ GlobalVoiceLines = "TyphonWoundedVoiceLines" },
		},

		DefeatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.25,
				SkipAnim = true,
				Source = { LineHistoryName = "TyphonHead", SubtitleColor = Color.TyphonVoice },

				{ Cue = "/VO/Typhon_0063", Text = "{#TyphonFormat}NAAAAAUUUUGGGHH...!" },
				{ Cue = "/VO/Typhon_0064", Text = "{#TyphonFormat}RRAAAAAAUUUUGGGHH...!" },
				{ Cue = "/VO/Typhon_0065", Text = "{#TyphonFormat}NNNOOOOOAAAAUUUGGHH...!" },
				{ Cue = "/VO/Typhon_0066", Text = "{#TyphonFormat}NRRRAAAAAUUUUGGGHH...!" },
				{ Cue = "/VO/Typhon_0067", Text = "{#TyphonFormat}GRRAAAAUUUUGGGHH...!" },
				{ Cue = "/VO/Typhon_0135", Text = "{#TyphonFormat}NOT AGAAAIIINNN...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Typhon_0141", Text = "{#TyphonFormat}HRRRAAAAAUUUGGGHHH!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
					},
				},
				{ Cue = "/VO/Typhon_0137", Text = "{#TyphonFormat}AAAAAUUUGGGHHH!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0141" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0138", Text = "{#TyphonFormat}GRAAAAAUUUGGGHHH!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0141" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0139", Text = "{#TyphonFormat}NRAAAAAUUUGGGHHH!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0141" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0140", Text = "{#TyphonFormat}HAAAAADEEEAAAUUUGH!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0141" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0142", Text = "{#TyphonFormat}CHROOONNNOOOOOSSS!!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "TyphonSpecialKillPresentation" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0141" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0136", Text = "{#TyphonFormat}IMPOOAAUUUGGGHHHHH...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Typhon_0131", Text = "{#TyphonFormat}CHROOONNNOOOSSS...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0132", Text = "{#TyphonFormat}CHRONAAAAAUUUGGGHHH...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0133", Text = "{#TyphonFormat}HOOOOOWWW...?!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0134", Text = "{#TyphonFormat}TIIIIIMMMEEE...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0068", Text = "{#TyphonFormat}ZEEEUUUUUSSS...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0070" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0069", Text = "{#TyphonFormat}HAAAAADEEEESSS...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Typhon_0068" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0070", Text = "{#TyphonFormat}DAAAAAMN YOUUUUU...!", PlayFirst = true },
			},
		},

		Using = { "TyphonEggTimerFlash", SpawnUnits = { "TyphonTail", "TyphonArm", "TyphonTail_Incursion", "TyphonArm_Incursion", }, GrannyModel = "WeaponGigaros_Mesh", },
	},

	TyphonHeadStaggeredDummy =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "TyphonHead",
		DamagedFxAtImpactLocation = false,
		TriggersOnHitEffects = true,
		BlocksLootInteraction = false,
		UseActivatePresentation = false,
		ImmuneToPolymorph = true,
		HideVengeanceText = true,

		Health = 9999999,
		CannotDieFromDamage = true,
	},

	TyphonHeadEgg01 =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		Groups = { "EnemyTeam", "GroundEnemies" },

		UseActivatePresentation = false,
		HealthBarType = "Small",
		MaxHealth = 1450,
		BlockRaiseDead = true,
		DestroyOnPolymorph = true,
		DeathFx = "EnemyDeathFxTyphon",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnFx = "TyphonEggSpawnFx",
			SpawnOptions = { "Simple2" },

			HatchDuration = 6,
		},

		TriggerGroups = { "HeroTeam" },
		StartCharmedDataOverrides =
		{
			TriggerGroups = { "EnemyTeam" },
		},

		IncomingDamageModifiers =
		{
			{
				FriendMultiplier = 0.0,
			},
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 10,
				Multiplicative = true,
			},
		},

		DissipateAnimation = "LovesickHeartMineDissipate",
		FlashOnFuse = true,
		TriggerDistance = 150,
		TriggerDistanceScaleY = 0.5,
		WakeUpDelay = 0.15,
		ExpirationDuration = 99.0,

		MoneyDropOnDeath = {},

		AIOptions =
		{
			"TyphonHeadEggAI",
		},
		AttackDistance = 100,

		HatchVoiceLines =
		{
			PlayOnce = true,
			PlayOnceContext = "TyphonEggIntroVO",
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.75,
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_3289", Text = "They're hatching...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3291", Text = "So this is how monsters are made...?" },
		},
	},

	TyphonHeadEgg02 =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 3000,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -180,

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "Brute2" },
			HatchDuration = 8,
		},
	},

	TyphonHeadEgg03 =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 2550,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -180,

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "Mudman2" },
		},
	},

	TyphonHeadEgg04 =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 1500,
		HealthBarOffsetY = -100,

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "LycanSwarmer2" },
			HatchDuration = 8,
		},
	},

	TyphonHeadEgg05 =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 2050,
		HealthBarType = "Medium",
		HealthBarOffsetY = -100,

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "FishmanMelee2" },
			HatchDuration = 8,
		},
	},

	TyphonHeadEggCaptain =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 3500,
		HealthBarType = "Medium",
		HealthBarOffsetY = -210,
		AttachedAnimationName = "TyphonEggChronosFx",

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "Captain_SuperElite" },
			HatchDuration = 11,
		},
	},

	TyphonHeadEggBoar =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 3500,
		HealthBarType = "Medium",
		HealthBarOffsetY = -210,
		AttachedAnimationName = "TyphonEggChronosFx",

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "Boar_SuperElite" },
			HatchDuration = 13,
		},
	},

	TyphonHeadEggDragon =
	{
		InheritFrom = { "TyphonHeadEgg01" },
		MaxHealth = 3500,
		HealthBarType = "Medium",
		HealthBarOffsetY = -210,
		AttachedAnimationName = "TyphonEggChronosFx",

		DefaultAIData =
		{
			DeepInheritance = true,

			SpawnOptions = { "Dragon_SuperElite" },
			HatchDuration = 13,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.TyphonHead )


WeaponSetData =
{
	TyphonHeadRam =
	{
		Requirements =
		{
			MaxPlayerDistance = 700,
			MaxConsecutiveUses = 1,
		},

		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "MapState", "Flags", "ChronosPolymorph" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{
					{
						PathFromSource = true,
						Path = { "CurrentPhase", },
						Comparison = "<",
						Value = 2,
					},
				},
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,
			ImmuneToProjectileSlow = true,

			FireProjectileStartDelay = 0.1,
			AttackSlots =
			{
				{ ProjectileName = "TyphonRamHorn", UseAttackerAngle = true, OffsetAngle = 0, AIDataOverrides = { BarrelLength = 450 }, },
				{ ProjectileName = "TyphonRamHorn", UseAttackerAngle = true, OffsetAngle = -35 },
				{ ProjectileName = "TyphonRamHorn", UseAttackerAngle = true, OffsetAngle = 35, },
			},
			BarrelLength = 800,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlamCharge",
			PreAttackFx = "TyphonRamChargeFx",
			PreAttackAnimation = "Enemy_TyphonHead_RamPreFire",
			FireAnimation = "Enemy_TyphonHead_RamFire",
			PostAttackAnimation = "Enemy_TyphonHead_RamPostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.75,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.21,
			FireDuration = 0.67,
			PostAttackDuration = 1.4, --anim is 1.22
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 0.3, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlam" },
			},
		},
	},

	TyphonHeadRam2 =
	{
		InheritFrom = { "TyphonHeadRam" },

		AIData =
		{
			DeepInheritance = true,

			DumbFireWeapons = { "TyphonHeadAddSummonLeft", "TyphonHeadAddSummonMid", "TyphonHeadAddSummonRight", },
		},
	},

	TyphonHeadTongueSlamA =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,

			ImmuneToProjectileSlow = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueSlam", PauseDuration = 0.05 },
				{ ProjectileName = "TyphonHeadTongueSlamShockwave" },
			},
			FireProjectileStartDelay = 0.27,
			SpawnFromMarker = "TyphonHead_Rig:snakeMouthSphere_00_M_JNT",
			FireProjectileNoDestination = true,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlamCharge",
			PreAttackAnimation = "Enemy_TyphonHead_TongueSlamA_PreFire",
			FireAnimation = "Enemy_TyphonHead_TongueSlamA_Fire",
			PostAttackAnimation = "Enemy_TyphonHead_TongueSlam_PostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.92,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.35,
			FireDuration = 0.38,
			PostAttackDuration = 0.0,

			ChainedWeapon = "TyphonHeadTongueSlamB"
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 0.3, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlam" },
			},
		},
	},

	TyphonHeadTongueSlamB =
	{
		AIData =
		{
			DeepInheritance = true,

			ImmuneToProjectileSlow = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueSlam", PauseDuration = 0.05 },
				{ ProjectileName = "TyphonHeadTongueSlamShockwave" },
			},
			FireProjectileStartDelay = 0.25,
			SpawnFromMarker = "TyphonHead_Rig:snakeMouthSphere_00_M_JNT",
			FireProjectileNoDestination = true,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlamCharge",
			PreAttackAnimation = "Enemy_TyphonHead_TongueSlamB_PreFire",
			FireAnimation = "Enemy_TyphonHead_TongueSlamB_Fire",
			PostAttackAnimation = "Enemy_TyphonHead_TongueSlam_PostFire",

			PreAttackAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.28,
			PreAttackEndMinWaitTime = 0.28,
			FireDuration = 0.43,
			PostAttackDuration = 0.0,

			ChainedWeapon = "TyphonHeadTongueSlamC"
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 0.3, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlam" },
			},
		},
	},

	TyphonHeadTongueSlamC =
	{
		AIData =
		{
			DeepInheritance = true,

			ImmuneToProjectileSlow = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueSlam", PauseDuration = 0.05 },
				{ ProjectileName = "TyphonHeadTongueSlamShockwave" },
			},
			FireProjectileStartDelay = 0.27,
			SpawnFromMarker = "TyphonHead_Rig:snakeMouthSphere_00_M_JNT",
			FireProjectileNoDestination = true,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlamCharge",
			PreAttackAnimation = "Enemy_TyphonHead_TongueSlamC_PreFire",
			FireAnimation = "Enemy_TyphonHead_TongueSlamC_Fire",
			PostAttackAnimation = "Enemy_TyphonHead_TongueSlam_PostFire",

			PreAttackAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.82,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.26,
			FireDuration = 0.47,
			PostAttackDuration = 1.22,
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 0.3, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonTuskSlam" },
			},
		},
	},

	TyphonHeadTongueSlamWeak =
	{
		InheritFrom = { "TyphonHeadTongueSlamA", },

		Requirements = {},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueSlamWeak", },
			},

			FireProjectileStartDelay = 0.6,

			PreAttackAnimation = "Enemy_TyphonHead_TongueSlamA_PreFire_SlowCombo",
			FireAnimation = "Enemy_TyphonHead_TongueSlamA_Fire_Slow",
			PostAttackAnimation = "Enemy_TyphonHead_TongueSlam_PostFire_Slow",

			WaitForAngleTowardTarget = false,

			PreAttackSound = "nil",

			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.5,
			PreAttackStartMinWaitTime = 0.88,
			FireDuration = 0.76,
			FireDurationMinWaitTime = 0.76,
			PostAttackDuration = 0.1,

			ChainedWeapon = "nil",
		},

		FireScreenshake = {},
	},

	TyphonHeadAddSummon =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			SpawnBurstOnFire = true,
			SpawnRate = 0.0,
			SpawnOnIds = { 779851, 793224, 779854, },
			SpawnRadius = 99999,
			SpawnBurstDelay = 0,
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 3,
			SpawnerOptions = { "TyphonHeadAdd" },
			SkipLocationBlockedCheck = true,
		},

		Sounds =
		{
		},
	},
	TyphonHeadAddSummonLeft =
	{
		InheritFrom = { "TyphonHeadAddSummon" },

		AIData =
		{
			DeepInheritance = true,

			SpawnOnIds = { 779874, },
			SpawnOverrides =
			{
				WeaponOptions = { "TyphonHeadAddComboLeft", },
			},
		},
	},
	TyphonHeadAddSummonMid =
	{
		InheritFrom = { "TyphonHeadAddSummon" },

		AIData =
		{
			DeepInheritance = true,

			SpawnOnIds = { 779884, },
			SpawnOverrides =
			{
				WeaponOptions = { "TyphonHeadAddComboMid", },
			},
		},
	},
	TyphonHeadAddSummonRight =
	{
		InheritFrom = { "TyphonHeadAddSummon" },

		AIData =
		{
			DeepInheritance = true,

			SpawnOnIds = { 779863, },
			SpawnOverrides =
			{
				WeaponOptions = { "TyphonHeadAddComboRight", },
			},
		},
	},

	TyphonHeadCastSummon01 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonEggLob01",
			SpawnFromMarker = "TyphonHead_Rig:snakeMouthSphere_00_M_JNT",
			ImmuneToProjectileSlow = true,

			PreAttackThreadedFunctionName = "TyphonHeadSummonPresentation",
			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage1_Color", },

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 9999,
			ResetTargetPerTick = true,
			DoNotRepeatSpawnPointIds = true,
			SpawnCountDampenFireTicks = true,
			FireTicks = 5,
			FireInterval = 0.42,
			FireProjectileAtTarget = true,

			PreAttackAnimation = "Enemy_TyphonHead_CastPreFire",
			FireAnimation = "Enemy_TyphonHead_CastFireLoop",
			PostAttackAnimation = "Enemy_TyphonHead_CastPostFire",

			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 1.67,
			FireDuration = 0.0,
			PostAttackMinWaitTime = 17.0,
			PostAttackDuration = 17.0,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "TyphonSummonReactionVoiceLines" },
			},
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 3.34, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_FurballCough" },
			},
		},
	},
	TyphonHeadCastSummon02 =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireInterval = 1.05,
			ProjectileName = "TyphonEggLob02",

			PostAttackMinWaitTime = 23.0,
			PostAttackDuration = 23.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage3_Color", },
		},
	},
	TyphonHeadCastSummon03 =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireInterval = 0.7,
			ProjectileName = "TyphonEggLob03",
		},
	},
	TyphonHeadCastSummon04 =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 12,
			FireInterval = 0.21,
			ProjectileName = "TyphonEggLob04",

			PostAttackMinWaitTime = 23.0,
			PostAttackDuration = 23.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage3_Color", },
		},
	},
	TyphonHeadCastSummon05 =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 4,
			FireInterval = 0.42,
			ProjectileName = "TyphonEggLob05",

			PostAttackMinWaitTime = 23.0,
			PostAttackDuration = 23.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage3_Color", },
		},
	},
	TyphonHeadCastSummonCaptain =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireInterval = 1.05,
			ProjectileName = "TyphonEggLobCaptain",

			PostAttackMinWaitTime = 24.0,
			PostAttackDuration = 24.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage1_Color", IncursionDelay = 3.0 },
		},
	},
	TyphonHeadCastSummonBoar =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireInterval = 1.05,
			ProjectileName = "TyphonEggLobBoar",

			PostAttackMinWaitTime = 28.0,
			PostAttackDuration = 28.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage2_Color", IncursionDelay = 3.0 },
		},
	},
	TyphonHeadCastSummonDragon =
	{
		InheritFrom = { "TyphonHeadCastSummon01" },

		
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireInterval = 1.05,
			ProjectileName = "TyphonEggLobDragon",

			PostAttackMinWaitTime = 28.0,
			PostAttackDuration = 28.0,

			PreAttackThreadedFunctionArgs = { NewGrannyTexture = "GR2/TyphonHeadStage2_Color", IncursionDelay = 3.0 },
		},
	},

	TyphonHeadGust =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonHeadGust",

			PreAttackThreadedFunctionName = "TyphonHeadGustPresentation",
			PreAttackFx = "TyphonHeadGustSpawner",

			PreAttackDuration = 1.0,

			EndOnFlagName = "InTransition",

			DumbFireWakeUpDelayMin = 8.0,
			DumbFireWakeUpDelayMax = 16.0,

			EndDumbFireOnTimesFired = 2,

			DumbFireIntervalMin = 15,
			DumbFireIntervalMax = 25,

			UseTargetId = 779907,
			FireFromTarget = true,
			FireProjectileAngle = 180,

			PreAttackVoiceLines =
			{
				PlayOnceFromTableThisRun = true,
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "MelWindReactionSpeech", Time = 18 },
					{ Name = "MelFacingTyphonSpeech", Time = 30 },
				},

				{ Cue = "/VO/MelinoeField_3352", Text = "The storm...!" },
				{ Cue = "/VO/MelinoeField_3353", Text = "These winds...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3354", Text = "Wind...!" },
				{ Cue = "/VO/MelinoeField_3355", Text = "{#Emph}Urnggh...!" },
				{ Cue = "/VO/MelinoeField_3356", Text = "{#Emph}Aauggh...!" },
			},
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonWindBreathAttack" },
			},
		},
	},

	TyphonHeadGustEM =
	{
		InheritFrom = { "TyphonHeadGust" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackFx = "TyphonHeadGustSpawnerFlipped",
			FireProjectileAngle = 0,
			UseTargetId = 800242,
		},
	},

	TyphonHeadTimeElementalSpawns =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "TimeElemental2_Typhon" },
			SpawnOnIdsOrdered = { 779816, 800401, },
			SkipLocationBlockedCheck = true,
			SpawnsPerBurst = 2,
			MaxActiveSpawns = 2,
			SpawnRate = 1.0,
			SpawnAggroed = true,
			SpawnOverrides =
			{
				IncomingDamageModifiers =
				{
					NonPlayerMultiplier = 0,
				},
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	TyphonHeadCenterEye =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			--PreAttackThreadedFunctionName = "TyphonHeadCannonPresentation",

			ProjectileName = "TyphonHeadCannon",
			--BarrelLength = 375,
			SpawnFromMarker = "TyphonHead_Rig:eyeballForeheadIris_00_M_JNT",

			PreAttackFx = "TyphonCenterEyeChargeFx",
			PreAttackAnimation = "Enemy_TyphonHead_CenterEyePreFire",
			FireAnimation = "Enemy_TyphonHead_CenterEyeFire",
			PostAttackAnimation = "Enemy_TyphonHead_CenterEyePostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.67,
			PostAttackDuration = 1.5, -- anim is 1.42
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_HeadAttackEmerge" },
			},
		},
	},
	TyphonHeadCenterEye2 =
	{
		InheritFrom = { "TyphonHeadCenterEye" },

		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "MapState", "Flags", "ChronosPolymorph" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{
					{
						PathFromSource = true,
						Path = { "CurrentPhase", },
						Comparison = "<",
						Value = 2,
					},
				},
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonHeadCannonSplit",
		},
	},
	TyphonHeadCenterEyeWeak =
	{
		InheritFrom = { "TyphonHeadCenterEye" },

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			BarrelLength = 700,
			SpawnFromMarker = "nil",
			ProjectileName = "TyphonHeadCannonLobWeak",


			PreAttackDuration = 1.5,
			PreAttackEndMinWaitTime = 0.5,
			PreAttackStartMinWaitTime = 1.0,
			FireDuration = 0.67,
			FireDurationMinWaitTime = 0.67,
			PostAttackDuration = 2.5, -- anim is 1.42
		},
	},

	TyphonHeadVolley =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
			PreviousWeaponNot = { "TyphonHeadRoar", },
		},

		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			--PreAttackThreadedFunctionName = "TyphonHeadVolleyPresentation",

			UseTargetId = 50059,

			ProjectileName = "TyphonHeadBoltDirect",
			AttackSlots =
			{
				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballDeltoid_00_R_JNT" }, PauseDuration = 0.04, },

				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballDeltoid_00_L_JNT" }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballNeckB_00_L_JNT" }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballHead_00_L_JNT" }, PauseDuration = 0.04, },

				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballHead_00_R_JNT" }, },
				{ AIDataOverrides = { SpawnFromMarker = "TyphonHead_Rig:eyeballNeckA_00_L_JNT" }, },
			},
			FireProjectileStartDelay = 0.35,
			Spread = 45,

			PreAttackAnimation = "Enemy_TyphonHead_VolleyEyePreFire",
			FireAnimation = "Enemy_TyphonHead_VolleyEyeFire",
			PostAttackAnimation = "Enemy_TyphonHead_VolleyPostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 2.66,
			FireDuration = 0.77,
			PostAttackDuration = 1.5,
			PostAttackMinWaitTime = 1.2,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "TyphonPreAttackVoiceLines" },
			},
		},
	},

	TyphonHeadVolleySky =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
			PreviousWeaponNot = { "TyphonHeadRoar", },
		},

		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "MapState", "Flags", "ChronosPolymorph" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{
					{
						PathFromSource = true,
						Path = { "CurrentPhase", },
						Comparison = "<",
						Value = 2,
					},
				},
			},
		},

		AIData =
		{
			DeepInheritance = true,

			--PreAttackThreadedFunctionName = "TyphonHeadVolleyPresentation",

			NoProjectile = true,
			DumbFireWeapons = { "TyphonHeadSkyfall" },

			PreAttackAnimation = "Enemy_TyphonHead_VolleyEyePreFire",
			FireAnimation = "Enemy_TyphonHead_VolleyEyeFire",
			PostAttackAnimation = "Enemy_TyphonHead_VolleyPostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 2.66,
			FireDuration = 0.85,
			PostAttackDuration = 1.0,
			PostAttackMinWaitTime = 0.8,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "TyphonPreAttackVoiceLines" },
			},
		},
	},

	TyphonHeadSkyfall =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseMapObjectId = 779851, },
				{ UseMapObjectId = 779852, },
				{ UseMapObjectId = 793225, },
				{ UseMapObjectId = 779854, PauseDuration = 0.4, },

				{ UseMapObjectId = 793224, },
				{ UseMapObjectId = 779868, },
				{ UseMapObjectId = 779866, },
			},

			ProjectileName = "TyphonHeadSkyfall",
			FireProjectileAtTarget = true,
		},
	},

	TyphonHeadSkyfallLeft =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseMapObjectId = 779852, },
				{ UseMapObjectId = 779877, },
				{ UseMapObjectId = 779885, },
				{ UseMapObjectId = 779872, },
				{ UseMapObjectId = 779886, },
				{ UseMapObjectId = 779850, },
				{ UseMapObjectId = 779874, },
				{ UseMapObjectId = 779816, },
			},

			AttackSlotInterval = 0.05,
			RandomizeAttackSlotOrder = true,

			ProjectileName = "TyphonHeadSkyfall",
			FireProjectileAtTarget = true,
		},
	},

	TyphonHeadSkyfallRight =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseMapObjectId = 779853, },
				{ UseMapObjectId = 779878, },
				{ UseMapObjectId = 779890, },
				{ UseMapObjectId = 793225, },
				{ UseMapObjectId = 779879, },
				{ UseMapObjectId = 779855, },
				{ UseMapObjectId = 779864, },
				{ UseMapObjectId = 779857, },
			},

			AttackSlotInterval = 0.05,
			RandomizeAttackSlotOrder = true,

			ProjectileName = "TyphonHeadSkyfall",
			FireProjectileAtTarget = true,
		},
	},

	TyphonHeadEnrage =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						PreAttackDumbFireWeapons = { "TyphonHeadTimeBubbles" },
					},
				},
			},

			ImmuneToProjectileSlow = true,

			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballDeltoid_00_L_JNT" }, PauseDuration = 0.3 },
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballHead_00_L_JNT" }, PauseDuration = 0.3 },
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballHead_00_R_JNT" }, PauseDuration = 0.3 },
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballNeckA_00_L_JNT" }, PauseDuration = 0.3 },
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballNeckB_00_L_JNT" }, PauseDuration = 0.3 },
				{ ProjectileName = "TyphonHeadBoltDirectEnrage", AIDataOverrides = { Spread = 45, SpawnFromMarker = "TyphonHead_Rig:eyeballDeltoid_00_R_JNT" }, PauseDuration = 0.3 },

				{ ProjectileName = "TyphonTornadoSpinEnrage",  AIDataOverrides = { FireProjectileTowardTarget = true, BarrelLength = 250, EndScale = 3, ScaleDuration = 1, }, PauseDuration = 0.9 },
				{ ProjectileName = "TyphonTornadoSpinEnrage",  AIDataOverrides = { FireProjectileTowardTarget = true, BarrelLength = 250, EndScale = 3,	ScaleDuration = 1, }, PauseDuration = 0.9 },
			},
			RandomizeAttackSlotOrder = true,

			FireTicks = 3,
			FireInterval = 0.4,

			PreAttackAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_TyphonHead_EnragePreFire",
			FireAnimation = "Enemy_TyphonHead_EnrageFire",
			PostAttackAnimation = "Enemy_TyphonHead_EnragePostFire",

			PreAttackDuration = 0.5,
			FireDuration = 1.5,
			PostAttackDuration = 5.5, -- anim is 1.67,
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 4.17, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonWindBreathAttack" },
			},
		},
	},

	TyphonHeadTimeBubbles =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRadial",
			FireProjectileAtTarget = true,
			AttackSlots =
			{
				{ UseMapObjectId = 800403, },
				{ UseMapObjectId = 779850, },
				{ UseMapObjectId = 779851, },
				{ UseMapObjectId = 793224, },
				{ UseMapObjectId = 793225, },
				{ UseMapObjectId = 779855, },
				{ UseMapObjectId = 779857, },
				{ UseMapObjectId = 779864, },
				{ UseMapObjectId = 779879, },
				{ UseMapObjectId = 779884, },
				{ UseMapObjectId = 779886, },
				{ UseMapObjectId = 779870, },
				{ UseMapObjectId = 779867, },
				{ UseMapObjectId = 779876, },
				{ UseMapObjectId = 779865, },
			},

			AttackSlotInterval = 0.5,
			RandomizeAttackSlotOrder = true,
			RemoveAttackSlotCount = 5,


			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,

			AttackDistance = 9999,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
		},
	},

	TyphonHeadRoar =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
			PreviousWeaponNot = { "TyphonHeadVolley", "TyphonHeadVolleySky", },
		},

		AIData =
		{
			DeepInheritance = true,


			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						PreAttackDumbFireWeapons = {},
					},
				},
			},
			ImmuneToProjectileSlow = true,

			PreAttackThreadedFunctionName = "TyphonHeadRoarPresentation",

			PreAttackDumbFireWeapons = { "TyphonHeadVacuum" },

			ProjectileName = "TyphonTornadoSpin",
			FireProjectileStartDelay = 0.5,
			NumProjectiles = 3,
			CancelProjectilesOnTransition = true,
			ProjectileInterval = 0.54,
			FireProjectileTowardTarget = true,
			BarrelLength = 600,

			EndScale = 3,
			ScaleDuration = 1,

			PreAttackAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonWindInhale",
			PreAttackFx = "TyphonHeadRoarChargeFxSpawner",
			PreAttackAnimation = "Enemy_TyphonHead_Tornado_Start",
			FireAnimation = "Enemy_TyphonHead_Tornado_Fire_Fast",
			PostAttackAnimation = "Enemy_TyphonHead_Tornado_End",

			PreAttackDuration = 1.5,
			FireDuration = 2.0,
			PostAttackDuration = 1.4, -- anim is 1.38,
			PostAttackMinWaitTime = 1.12,
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 4.17, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonWindBreathAttack" },
				{ Name = "/SFX/Enemy Sounds/Typhon/EmotePowerAttacking" },
			},
		},
	},

	TyphonHeadVacuum =
	{
		AIData =
		{
			DeepInheritance = true,

			DumbFireWakeUpDelay = 0.2,
			ProjectileName = "TyphonRoarVacuum",
			FireProjectileAtSelf = true,
		},
	},

	TyphonHeadDefenseKnockback =
	{
		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			ProjectileName = "TyphonRoarPush",
			FireProjectileStartDelay = 0.2,
			FireProjectileAtSelf = true,

			PreAttackAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonWindInhale",
			PreAttackFx = "TyphonHeadRoarChargeFxSpawner",
			PreAttackAnimation = "Enemy_TyphonHead_Tornado_Start_Fast",
			FireAnimation = "Enemy_TyphonHead_Tornado_Fire_Fast",
			PostAttackAnimation = "Enemy_TyphonHead_Tornado_End_Fast",

			PreAttackDuration = 0.75,
			FireDuration = 1.0,
			PostAttackDuration = 0.7, -- anim is 1.38,
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 4.17, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonWindBreathAttack" },
				{ Name = "/SFX/Enemy Sounds/Typhon/EmotePowerAttacking" },
			},
		},
	},

	TyphonHeadLaugh =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackFx = "TyphonHeadRoarChargeFxSpawner",
			FireAnimation = "Enemy_TyphonHead_Laugh",

			PreAttackDuration = 0.0,
			FireDuration = 4.17,
			PostAttackDuration = 0.0,
		},

		FireScreenshake = { Distance = 5, Speed = 150, Duration = 4.17, FalloffSpeed = 3000, Angle = 90 },

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TyphonWindBreathAttack" },
			},
		},
	},

	TyphonHeadWait =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 1.0,
			PostAttackDuration = 0.0,

			PreAttackAngleTowardTarget = false,

			ChainedWeapon = "TyphonHeadWait",
		},
	},

	TyphonHeadTongue =
	{
		Requirements =
		{
			--MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueMelee", },
				{ ProjectileName = "TyphonHeadTongueKnockback", OffsetFromAttacker = true, AnchorAngleOffset = 0 },
			},

			ExpireProjectilesOnHitStun = true,

			PreAttackStop = true, 
			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			UseTargetId = 50059,
			FireProjectileStartDelay = 0.6,
			SkipFireProjectileIfInTransition = true,

			PreAttackDuration = 0.85,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.29,
			FireDuration = 1.9,
			PostAttackDuration = 1.1, -- anim is 0.92
			
			PreAttackSound = "/SFX/Enemy Sounds/Typhon/TyphonTongueCharge",
			PreAttackAnimation = "Enemy_TyphonHead_TonguePreFire",
			PreAttackFx = "TyphonHeadTongueChargeFx",
			FireAnimation = "Enemy_TyphonHead_TongueFire",
			PostAttackAnimation = "Enemy_TyphonHead_TonguePostFire",
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/EmoteAttackingRanged" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, Duration = 0.2, FalloffSpeed = 1000, Angle = 0, ScreenPreWait = 0.02 },
	},
	TyphonHeadTongue2 =
	{
		InheritFrom = { "TyphonHeadTongue" },

		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "MapState", "Flags", "ChronosPolymorph" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				{
					{
						PathFromSource = true,
						Path = { "CurrentPhase", },
						Comparison = "<",
						Value = 2,
					},
				},
			},
		},

		AIData =
		{
			DeepInheritance = true,

			FireDuration = 1.56,
			PostAttackDuration = 0.0,
			PostAttackAnimation = "nil",
			ChainedWeapon = "TyphonHeadTongueReverse",
		},
	},
	TyphonHeadTongueReverse =
	{
		InheritFrom = { "TyphonHeadTongue" },
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueMeleeReverse", },
				{ ProjectileName = "TyphonHeadTongueKnockback", OffsetFromAttacker = true, AnchorAngleOffset = 0 },
			},

			PreAttackDuration = 0.0,
			PreAttackEndMinWaitTime = "nil",
			PreAttackStartMinWaitTime = "nil",
			FireDuration = 0.88,
			PostAttackDuration = 1.1,
			FireProjectileStartDelay = 0.4,

			PreAttackAnimation = "nil",
			FireAnimation = "Enemy_TyphonHead_TongueReverseFire",
			PostAttackAnimation = "Enemy_TyphonHead_TongueReversePostFire",
		},
	},


	TyphonHeadTongueWeak =
	{
		InheritFrom = { "TyphonHeadTongue" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueKnockback", OffsetFromAttacker = true, AnchorAngleOffset = 0 },
			},

			PreAttackFx = "nil",
			WaitForAngleTowardTarget = false,
			PreAttackDuration = 0,
			FireDuration = 1.56,
			PostAttackDuration = 0.0,

			PreAttackAnimation = "nil",
			FireAnimation = "Enemy_TyphonHead_TongueFire_Weak",
			PostAttackAnimation = "nil",
		},
	},

	TyphonHeadTongueReverseWeak =
	{
		InheritFrom = { "TyphonHeadTongueReverse" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "TyphonHeadTongueKnockback", OffsetFromAttacker = true, AnchorAngleOffset = 0 },
			},

			PreAttackFx = "nil",
			WaitForAngleTowardTarget = false,
			FireDuration = 1.32,
			PostAttackDuration = 0,

			FireAnimation = "Enemy_TyphonHead_TongueReverseFire_Weak",
			PostAttackAnimation = "nil",
		},
	},

	TyphonHeadWeakCombo =
	{
		WeaponComboOnly = true,

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "TyphonHeadTongueSlamWeak", DataOverrides = { UseTargetId = 779875, PreAttackAnimation = "Enemy_TyphonHead_TongueSlamA_PreFire_Slow", PreAttackDuration = 1.38, }, },
			{ WeaponName = "TyphonHeadTongueSlamWeak", DataOverrides = { UseTargetId = 779869 }, GameStateRequirements = { ChanceToPlay = 0.5 }, },
			{ WeaponName = "TyphonHeadTongueWeak", },
			{ WeaponName = "TyphonHeadTongueSlamWeak", DataOverrides = { UseTargetId = 779866 }, },
			{ WeaponName = "TyphonHeadTongueSlamWeak", DataOverrides = { UseTargetId = 779865 }, GameStateRequirements = { ChanceToPlay = 0.5 }, },
			{ WeaponName = "TyphonHeadTongueReverseWeak", },
			{ WeaponName = "TyphonHeadTongueSlamWeak", DataOverrides = { PostAttackDuration = 2.5, }, },
		},
	},

	TyphonHeadStunned =
	{
		Requirements =
		{
			MaxUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			NoProjectile = true,

			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,
			PostAttackAnimation = "Enemy_TyphonHead_StunnedEnd",
			FireDuration = 10.0,
			PostAttackDuration = 3.0,
		}
	},
}

-- Global Typhon Lines
GlobalVoiceLines.TyphonPreAttackVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.1,
		ChanceToPlay = 0.2,
		ObjectType = "TyphonHead",
		Cooldowns =
		{
			{ Name = "TyphonSpokeRecently", Time = 36 },
		},

		{ Cue = "/VO/Typhon_0045", Text = "{#TyphonFormat}KILLLLL... YOUUU..." },
		{ Cue = "/VO/Typhon_0047", Text = "{#TyphonFormat}ALLLLL... SHALLLLL..." },
		{ Cue = "/VO/Typhon_0049", Text = "{#TyphonFormat}YOUUU... SHALLL...", PlayFirst = true },
		{ Cue = "/VO/Typhon_0051", Text = "{#TyphonFormat}TIIIME... TO..." },
		{ Cue = "/VO/Typhon_0053", Text = "{#TyphonFormat}NOWWW... YOUUU..." },
		{ Cue = "/VO/Typhon_0055", Text = "{#TyphonFormat}I... SSSAID..." },
		{ Cue = "/VO/Typhon_0057", Text = "{#TyphonFormat}WHERRRRE... ISSS..." },
		{ Cue = "/VO/Typhon_0059", Text = "{#TyphonFormat}YOUUU... SHAAAAALL..." },
		{ Cue = "/VO/Typhon_0085", Text = "{#TyphonFormat}ALLLL... MY..." },
		{ Cue = "/VO/Typhon_0087", Text = "{#TyphonFormat}FEAR... MY..." },
		{ Cue = "/VO/Typhon_0089", Text = "{#TyphonFormat}THIS... ENDS..." },
		{ Cue = "/VO/Typhon_0091", Text = "{#TyphonFormat}RUN... RUN..." },
		{ Cue = "/VO/Typhon_0093", Text = "{#TyphonFormat}FALL... FALL..." },
		{ Cue = "/VO/Typhon_0095", Text = "{#TyphonFormat}CURSE... YOU..." },
		{ Cue = "/VO/Typhon_0061", Text = "{#TyphonFormat}GO... TO...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "TyphonHead" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		ObjectType = "TyphonHead",
		TriggerCooldowns = { "TyphonSpokeRecently" },

		{ Cue = "/VO/Typhon_0046", Text = "{#TyphonFormat}...ALLLLL...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0045" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0048", Text = "{#TyphonFormat}...DIEEEEE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0047" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0050", Text = "{#TyphonFormat}...DIEEEEE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0049" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0052", Text = "{#TyphonFormat}...DIEEEEE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0051" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0054", Text = "{#TyphonFormat}...DIEEEEE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0053" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0056", Text = "{#TyphonFormat}...DIEEEEE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0055" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0058", Text = "{#TyphonFormat}...ZEUUUUUSSS?!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0057" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0060", Text = "{#TyphonFormat}...PAAAAAY...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0059" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0062", Text = "{#TyphonFormat}...HELLLLL...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0061" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0086", Text = "{#TyphonFormat}...RAAAAAGE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0085" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0088", Text = "{#TyphonFormat}...CAAAAALL...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0087" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0090", Text = "{#TyphonFormat}...HEEEEERE...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0089" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0092", Text = "{#TyphonFormat}RUUUUUN...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0091" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0094", Text = "{#TyphonFormat}FAAAAALL...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0093" },
				},
			},
		},
		{ Cue = "/VO/Typhon_0096", Text = "{#TyphonFormat}GODDDSSS...!",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Typhon_0095" },
				},
			},
		},

	}

}

GlobalVoiceLines.TyphonHidingVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	PreLineWait = 1.0,
	ObjectType = "TyphonHead",
	Cooldowns =
	{
		{ Name = "TyphonSpokeRecently", Time = 36 },
	},

	{ Cue = "/VO/Typhon_0097", Text = "{#TyphonFormat}NOWWWWW...", PlayFirst = true },
	{ Cue = "/VO/Typhon_0098", Text = "{#TyphonFormat}STORRRRRRM..." },
	{ Cue = "/VO/Typhon_0099", Text = "{#TyphonFormat}SPAAAAAWN..." },
	{ Cue = "/VO/Typhon_0100", Text = "{#TyphonFormat}RAAAAAGE..." },
	{ Cue = "/VO/Typhon_0101", Text = "{#TyphonFormat}RUUUUUN..." },
	{ Cue = "/VO/Typhon_0102", Text = "{#TyphonFormat}SOOOOON..." },
	{ Cue = "/VO/Typhon_0103", Text = "{#TyphonFormat}HAAAAATE..." },
	{ Cue = "/VO/Typhon_0104", Text = "{#TyphonFormat}FEEEEEAR..." },
	{ Cue = "/VO/Typhon_0129", Text = "{#TyphonFormat}CHRONOSSS...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	{ Cue = "/VO/Typhon_0130", Text = "{#TyphonFormat}TITANNN...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
}
GlobalVoiceLines.TyphonUnHidingVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	PreLineWait = 1.0,
	ObjectType = "TyphonHead",
	Cooldowns =
	{
		{ Name = "TyphonSpokeRecently", Time = 36 },
	},

	{ Cue = "/VO/Typhon_0105", Text = "{#TyphonFormat}HAAAAAH...!" },
	{ Cue = "/VO/Typhon_0106", Text = "{#TyphonFormat}NRAAAAAUGH...!" },
	{ Cue = "/VO/Typhon_0107", Text = "{#TyphonFormat}HEHHHHH..." },
	{ Cue = "/VO/Typhon_0108", Text = "{#TyphonFormat}BROOOOOD...",
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	{ Cue = "/VO/Typhon_0109", Text = "{#TyphonFormat}FEEEEED...",
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	{ Cue = "/VO/Typhon_0110", Text = "{#TyphonFormat}EAAAAAT...",
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	{ Cue = "/VO/Typhon_0111", Text = "{#TyphonFormat}FEEEEAST...",
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	{ Cue = "/VO/Typhon_0112", Text = "{#TyphonFormat}SWAAAAARM...",
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 4,
			},
		},
	},
}
GlobalVoiceLines.TyphonEnragedVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "ZeusFirstTyphonRecoveryVO",
		PreLineWait = 0.3,
		Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },

		{ Cue = "/VO/Zeus_0242", Text = "He's recovered!" },
	},
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		PreLineWait = 0.1,
		ObjectType = "TyphonHead",
		TriggerCooldowns = { "TyphonSpokeRecently" },

		{ Cue = "/VO/Typhon_0021", Text = "{#TyphonFormat}ZEUUUUUSSS...!", PlayFirst = true },
		{ Cue = "/VO/Typhon_0022", Text = "{#TyphonFormat}HAAAAAHH...!" },
		{ Cue = "/VO/Typhon_0023", Text = "{#TyphonFormat}NRAAAAAUUUGGHHH..." },
		{ Cue = "/VO/Typhon_0024", Text = "{#TyphonFormat}HAAAAATE...!" },
		{ Cue = "/VO/Typhon_0025", Text = "{#TyphonFormat}GODSSS... DIIIIIE...!" },
		{ Cue = "/VO/Typhon_0026", Text = "{#TyphonFormat}KIIIIILLL...!" },
		{ Cue = "/VO/Typhon_0027", Text = "{#TyphonFormat}DIIIIIE...!" },
		{ Cue = "/VO/Typhon_0028", Text = "{#TyphonFormat}FOOOOOLLL...!" },
		{ Cue = "/VO/Typhon_0029", Text = "{#TyphonFormat}HATREEEEED...!" },
		{ Cue = "/VO/Typhon_0020", Text = "{#TyphonFormat}YOUUUUU...!" },
		{ Cue = "/VO/Typhon_0017", Text = "{#TyphonFormat}ZEUUUUUSSS...!" },
		{ Cue = "/VO/Typhon_0030", Text = "{#TyphonFormat}HAAAAADESSS...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "TyphonHead" },
					Comparison = ">=",
					Value = 5,
				},
			}
		},
		{ Cue = "/VO/Typhon_0019", Text = "{#TyphonFormat}HADEEEEESSS...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "TyphonHead" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
	},
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		SuccessiveChanceToPlay = 0.75,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },
		TriggerCooldownsImmediately = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Zeus_0243", Text = "We'll hold the Palace, keep him occupied!" },
		{ Cue = "/VO/Zeus_0244", Text = "I have to fall back to the Palace! {#Emph}Fight!", PlayFirst = true },
		{ Cue = "/VO/Zeus_0245", Text = "Protect the Palace, everyone!" },
	},
}
GlobalVoiceLines.TyphonWoundedVoiceLines =
{
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.05,
	SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "OriginalSource", "AIStageActive" },
			Comparison = ">=",
			Value = 4,
		},
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
			Comparison = ">=",
			Value = 0.15,
		},
	},
	Cooldowns =
	{
		{ Name = "TyphonSpokeRecently", Time = 36 },
	},

	{ Cue = "/VO/Typhon_0040", Text = "{#TyphonFormat}RAAAAAGE..." },
	{ Cue = "/VO/Typhon_0041", Text = "{#TyphonFormat}PAIIIIIN..." },
	{ Cue = "/VO/Typhon_0042", Text = "{#TyphonFormat}HAAAAATE..." },
	{ Cue = "/VO/Typhon_0043", Text = "{#TyphonFormat}AUUUGHHH..." },
	{ Cue = "/VO/Typhon_0044", Text = "{#TyphonFormat}ZEUUUUUSSS..." },
	{ Cue = "/VO/Typhon_0079", Text = "{#TyphonFormat}HOWWWWW..." },
	{ Cue = "/VO/Typhon_0080", Text = "{#TyphonFormat}WHYYYYY..." },
	{ Cue = "/VO/Typhon_0081", Text = "{#TyphonFormat}GRAAAAAH..." },
	{ Cue = "/VO/Typhon_0082", Text = "{#TyphonFormat}AUUUUUGH..." },
	{ Cue = "/VO/Typhon_0083", Text = "{#TyphonFormat}NOOOOO..." },
	{ Cue = "/VO/Typhon_0084", Text = "{#TyphonFormat}YOUUUUU..." },
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil