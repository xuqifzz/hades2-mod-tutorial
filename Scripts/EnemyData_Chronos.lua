UnitSetData.Chronos =
{
	-- see also Chronos_TyphonFight below
	Chronos =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Chronos_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ChronosVoice,
		EmoteOffsetY = -320,
		EmoteOffsetX = 85,
		SpeakerName = "Chronos",
		SpeakingStatusAnimation = "StatusIconSpeaking_Hero",
		LoadPackages = { "Chronos", },
		RunHistoryKilledByName = "NPC_Chronos_01",

		MaxHealth = 20000,
		Phases = 2,
		AISetupDelay = 4.5,
		ChronosFightStartMoveId = 704968,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,
		
		SpawnAnimation = "Enemy_Chronos_SittingIdle",
		--InvulnerableFx = "Invincibubble_Scylla",
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		InvulnerableFx = "ChronosInvincibubble",
		SpeechCooldownTime = 11,
		BlockPostBossMetaUpgrades= true,
		OnDeathFunctionName = "ChronosKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "ChronosDefeatedMessage",
			CameraPanTime = 1.5,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			BatsAfterDeath = false,
			FlashRed = true,
			FlashDuration = 0.45,
			AddInterBiomeTimerBlock = true,
			EndAngle = 210,
			KillerEndAngle = 30,
			KillerTeleportId = 609240,
			VictimTeleportId = 713403,
			SpecialKillRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
			},
			SpawnChronosRemainsRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},

		DeathAnimation = "Enemy_Chronos_BattleOutro_End",
		DeathPanOffsetY = -140,
		DeathAngle = 210,

		OnHitFlash = { MaxFraction = 0.45 },

		Material = "Organic",
		HealthBarTextId = "Chronos_Full",

		InvulnerableHitFx = "Chronos360BlockFront",
		
		HealthBarOffsetY = -275,
		IgnoreInvincibubbleOnHit = true,

		IgnoreTimeSlowEffects = true,
		AIWakeDelay = 1.00,
		PreBossAISetupFunctionName = "ChronosBattleStart",
		DefaultAIData =
		{
			--DashIfOverDistance = 1000,
			--DashWeapon = "ChronosRush",
			SpawnCountDampenTraits = { HadesChronosDebuffBoon = true, },
			MoveWithinRangeTimeout = 8.0,
		},
		WeaponOptions =
		{
			"ChronosDash",
			"ChronosBannerSummon",
			"ChronosGrind",
			"ChronosSwingRight",
			"ChronosSwingLeft",
			"ChronosCastOrbit",
			"ChronosScytheThrow", "ChronosScytheThrow",
			"ChronosRush", "ChronosRush",
		},
		
		BossDifficultyShrineRequiredCount = 4,
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					IgnoreTimeSlowEffects = false,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
					},
				},
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					Phases = 3,
					MaxHealth = 22000,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 2000,
								Window = 1.0,
								MaxComboBreakers = 1,
								ForcedWeaponInterrupt = "ChronosDashComboBreaker",
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
			{
				FunctionName = "CheckElapsedTimeMultiplierIgnores",
			},
		},

		AIEndHealthThreshold = 0.75,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.75,
				},
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					EquipWeapons =
					{
						"ChronosDash",
						"ChronosBannerSummon",
						"ChronosGrind",
						"ChronosEMComboSelector_P1", "ChronosEMComboSelector_P1",
						"ChronosScytheThrow",
						"ChronosCastOrbit",
						"ChronosDownStrike",
					},
					DataOverrides =
					{
						ForcedNextWeapon = "ChronosEMRushThrow",
					},
				},
			},
			-- 1.25
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense",
				WaitDuration = 1.4,
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
				EMStageDataOverrides =
				{
					WaitDuration = 1.2,
					FireWeapon = "ChronosDefense_Elite",
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
			},
			-- 1.5
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDash",
				UnequipAllWeapons = true,
				WaitDuration = 0.2,
				EquipWeapons =
				{
					"ChronosDash",
					"ChronosBannerSummon",
					"ChronosGrind",
					"ChronosMeleeComboSelector", "ChronosMeleeComboSelector", "ChronosMeleeComboSelector",
					"ChronosScytheThrow",
					"ChronosCastOrbit",
				},
				EMStageDataOverrides =
				{
					EquipWeapons =
					{
						"ChronosDash",
						"ChronosBannerSummon",
						"ChronosGrind",
						"ChronosEMComboSelector_P1", "ChronosEMComboSelector_P1",
						"ChronosScytheThrow",
						"ChronosCastOrbit",
						"ChronosDownStrike",
					},
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.25,
				},
			},
			-- 1.75
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense3",
				WaitDuration = 1.4,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EMStageDataOverrides =
				{
					WaitDuration = 1.2,
					FireWeapon = "ChronosDefense3_SuperElite",
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosPhaseTransition",
				WipeEnemyTypes = { "BattleStandardChronos" },
				NewMaxHealth = 16000,
				UnequipAllWeapons = true,
				SetMapFlags =
				{ 
					{ FlagName = "ChronosStage2" },
				},
				EquipWeapons =
				{
					"ChronosRush",
					"ChronosSwingCombo",
					"ChronosScytheThrow",
					"ChronosCastOrbit2",
					"ChronosUltimate",
					"ChronosRadial",
					"ChronosRadial2",
					"ChronosRadial3"
				},
				DumbFireWeapons = { "ChronosRadialIn" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
				EMStageDataOverrides =
				{
					NewMaxHealth = 18000,
					EquipWeapons =
					{
						"ChronosEMComboSelector_P2", "ChronosEMComboSelector_P2",
						"ChronosCastOrbit2",
						"ChronosUltimate",
						"ChronosRadial",
						"ChronosRadial2",
						"ChronosRadial3_EM",
					},
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
			},
			-- 2.5
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosDefense2",
				WaitDuration = 1.4,
				SetMapFlags = { 
					{ FlagName = "ChronosRoomWeapons2" },
				},
				UnequipAllWeapons = true,
				EquipWeapons =
				{
					"ChronosMeleeComboSelector", "ChronosMeleeComboSelector", "ChronosMeleeComboSelector",
					"ChronosScytheThrow",
					"ChronosCastOrbit2",
					"ChronosRadial",
					"ChronosRadial2",
					"ChronosRadial3"
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				EMStageDataOverrides =
				{
					WaitDuration = 1.2,
					FireWeapon = "ChronosDefense2_Elite",
					EquipWeapons =
					{
						"ChronosEMComboSelector_P2", "ChronosEMComboSelector_P2",
						"ChronosCastOrbit2",
						"ChronosRadial",
						"ChronosRadial2",
						"ChronosRadial3_EM",
					},
					DataOverrides =
					{
						ComboBreakersUsed = 0,
					},
				},
			},
			-- Phase 3
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosPhaseTransition",
				WipeEnemyTypes = { "BattleStandardChronos", "TimeElemental" },
				NewMaxHealth = 26000,
				UnequipAllWeapons = true,
				DumbFireWeapons = { "ChronosPassiveNumberSequence", },
				SetMapFlags =
				{ 
					{ FlagName = "ChronosStage3" },
				},
				EquipWeapons =
				{
					"ChronosTelescopeSwingRight_P3",
					"ChronosScytheThrowDouble_P3",
					"ChronosRush_P3",
					"ChronosGrind_P3",
					"ChronosLungeMelee_P3",
					"ChronosRadial_P3",
					"ChronosWringerSpawns",

					"ChronosUltimate_P3", --"ChronosRadial2", "ChronosRadial3", "ChronosCastOrbit2",
					"ChronosShadowSummon",

					"ChronosNumberCombo",
				},
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
				AIDataOverrides =
				{
					DumbFireWakeUpDelay = 5.0,
				},
				DataOverrides =
				{
					ForcedNextWeapon = "ChronosNumberCombo",
					ComboBreakersUsed = 0,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 2000,
								Window = 1.0,
								MaxComboBreakers = 1,
								ForcedWeaponInterrupt = "ChronosCastOrbitComboBreaker",
							},
						},
					},
				},
			},
			-- 3.5
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "ChronosMinorStageTransition",
				FireWeapon = "ChronosShadowSummonUltimate",
				WipeEnemyTypes = { "Chronos_EMShadow" },
				WaitDuration = 1.4,
				UnequipAllWeapons = true,
				EquipWeapons =
				{
					"ChronosTelescopeSwingRight_P3",
					"ChronosScytheThrowDouble_P3",
					"ChronosRush_P3",
					"ChronosGrind_P3",
					"ChronosLungeMelee_P3",
					"ChronosRadial_P3",
					"ChronosWringerSpawns",

					"ChronosUltimate_P3", --"ChronosRadial2", "ChronosRadial3", "ChronosCastOrbit2",
					"ChronosShadowSummon",

					"ChronosNumberCombo",
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				DataOverrides =
				{
					ComboBreakersUsed = 0,
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
				{ Name = "ChronosSpokeRecently", Time = 18 },
			},

			{ Cue = "/VO/Chronos_0311", Text = "A lasting pain..." },
			{ Cue = "/VO/Chronos_0312", Text = "It lingers, does it not?" },
			{ Cue = "/VO/Chronos_0313", Text = "Wither..." },
			{ Cue = "/VO/Chronos_0314", Text = "Begone..." },
			{ Cue = "/VO/Chronos_0315", Text = "Begone from here..." },
			{ Cue = "/VO/Chronos_0316", Text = "You shall be cut in twain..." },
			{ Cue = "/VO/Chronos_0317", Text = "You shall be brought to heel!" },
			{ Cue = "/VO/Chronos_0318", Text = "Expire..." },
			{ Cue = "/VO/Chronos_0319", Text = "Not so fast..." },
			{ Cue = "/VO/Chronos_0320", Text = "You cannot run forever..." },
			{ Cue = "/VO/Chronos_0321", Text = "Heedless whelp." },
			{ Cue = "/VO/Chronos_0322", Text = "Impetuous of you..." },
			{ Cue = "/VO/Chronos_0323", Text = "There..." },
			{ Cue = "/VO/Chronos_0324", Text = "Prepared for more?" },
			{ Cue = "/VO/Chronos_0325", Text = "What now?" },
			{ Cue = "/VO/Chronos_0326", Text = "How daft you are..." },
			{ Cue = "/VO/Chronos_0327", Text = "Learn some respect!" },
			{ Cue = "/VO/Chronos_0328", Text = "You had it coming." },
			{ Cue = "/VO/Chronos_0329", Text = "We are not done." },
			{ Cue = "/VO/Chronos_0330", Text = "Another, then?" },
			{ Cue = "/VO/Chronos_0331", Text = "Relent." },
			{ Cue = "/VO/Chronos_0332", Text = "Relent, blast you!" },
			{ Cue = "/VO/Chronos_0333", Text = "Embarrassing." },
			{ Cue = "/VO/Chronos_0334", Text = "Get from this hall." },
			{ Cue = "/VO/Chronos_0335", Text = "Time takes all." },
			{ Cue = "/VO/Chronos_0336", Text = "Too slow, my girl..." },
			{ Cue = "/VO/Chronos_0337", Text = "Alas, my girl..." },
			{ Cue = "/VO/Chronos_0338", Text = "My scythe shall find you." },
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
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
					{ Name = "ChronosLastStandReactionSpeech", Time = 25 },
				},

				{ Cue = "/VO/Chronos_0291", Text = "Still you resist...?" },
				{ Cue = "/VO/Chronos_0292", Text = "Not finished yet?" },
				{ Cue = "/VO/Chronos_0293", Text = "Our family's favorite trick..." },
				{ Cue = "/VO/Chronos_0294", Text = "Your strength shall fail you..." },
				{ Cue = "/VO/Chronos_0295", Text = "But one more cut or two..." },
				{ Cue = "/VO/Chronos_0296", Text = "You only make things worse!" },
				{ Cue = "/VO/Chronos_0297", Text = "Oh, please." },
				{ Cue = "/VO/Chronos_0298", Text = "My girl, would you please die?" },
				{ Cue = "/VO/Chronos_0299", Text = "Am I supposed to be impressed?" },
				{ Cue = "/VO/Chronos_0300", Text = "Youthful vigor, nothing more." },
				{ Cue = "/VO/Chronos_0301", Text = "Time is running out..." },
				{ Cue = "/VO/Chronos_0302", Text = "Time grows short..." },
				{ Cue = "/VO/Chronos_0303", Text = "Oh-{#Emph}ho...!" },
				{ Cue = "/VO/Chronos_0304", Text = "Ah-{#Emph}hah...!" },
				{ Cue = "/VO/Chronos_0305", Text = "{#Emph}<Laugh>" },
				{ Cue = "/VO/Chronos_0306", Text = "{#Emph}<Chuckle>" },
			},
		},
		BlockDeathReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.25,
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Chronos_0307", Text = "A few last moments, then?" },
				{ Cue = "/VO/Chronos_0308", Text = "This is the end for you." },
				{ Cue = "/VO/Chronos_0309", Text = "You have already lost." },
				{ Cue = "/VO/Chronos_0310", Text = "Have you no dignity at all?" },
			},
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			{ GlobalVoiceLines = "ChronosInvulnerableVoiceLines" },
		},
		ResistedVoiceLines =
		{
			{ GlobalVoiceLines = "ChronosResistedVoiceLines" },
		},

		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitVoiceLines =
		{
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ObjectType = "Chronos",
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "EffectName", },
						IsAny = { "HadesSweepEffect" },
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Chronos_1244", Text = "Your father's old technique...", PlayFirst = true },
				{ Cue = "/VO/Chronos_1245", Text = "Your father's wrath..." },
				{ Cue = "/VO/Chronos_1246", Text = "Did Hades teach you that?" },
				{ Cue = "/VO/Chronos_1247", Text = "You have your father's {#Emph}mood..." },
				{ Cue = "/VO/Chronos_1248", Text = "You truly are your father's child." },
			},

			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ObjectType = "Chronos",
				SuccessiveChanceToPlayAll = 0.1,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "TimeElementalHealBeam" },
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
					ChanceToPlay = 0.1,
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 18 },
				},

				{ Cue = "/VO/Chronos_1218", Text = "My strength shall be restored!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1213", Text = "Rejuvenation...!" },
				{ Cue = "/VO/Chronos_1214", Text = "Time heals all wounds..." },
				{ Cue = "/VO/Chronos_1215", Text = "Give me a moment to reconstitute..." },
				{ Cue = "/VO/Chronos_1216", Text = "I soon shall be like new!" },
				{ Cue = "/VO/Chronos_1217", Text = "I shall recover; {#Emph}you {#Prev}shall {#Emph}not." },
				{ Cue = "/VO/Chronos_1219", Text = "Heal me faster, blast you all!" },
				{ Cue = "/VO/Chronos_1220", Text = "I am feeling better already!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.5,
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
					{ Name = "ChronosSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/Chronos_0958", Text = "Contemptible {#Emph}toad!" },
				{ Cue = "/VO/Chronos_0959", Text = "A common toad, in {#Emph}here?" },
				{ Cue = "/VO/Chronos_0960", Text = "Foul {#Emph}frog!" },
				{ Cue = "/VO/Chronos_0961", Text = "What is this {#Emph}frog?", PlayFirst = true },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.5,
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
					{ Name = "ChronosSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/Chronos_0683", Text = "Foul bird!" },
				{ Cue = "/VO/Chronos_0684", Text = "A {#Emph}bird{#Prev}, in {#Emph}here?", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Chronos_0685", Text = "{#Emph}Pff! {#Prev}Feathers!" },
				{ Cue = "/VO/Chronos_0686", Text = "Begone, {#Emph}bird!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.5,
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
					{ Name = "ChronosSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/Chronos_0679", Text = "Accursed feline!" },
				{ Cue = "/VO/Chronos_0680", Text = "Damnable creature." },
				{ Cue = "/VO/Chronos_0681", Text = "Back off, {#Emph}cat.", PlayFirst = true },
				{ Cue = "/VO/Chronos_0682", Text = "It {#Emph}scratched {#Prev}me!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.5,
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
					{ Name = "ChronosSpokeRecently", Time = 6 },
				},

				-- { Cue = "/VO/Chronos_0914", Text = "A beast within this House?" },
				{ Cue = "/VO/Chronos_0915", Text = "{#Emph}Heel{#Prev}, foul beast!" },
				{ Cue = "/VO/Chronos_0916", Text = "Back, you {#Emph}dog." },
				{ Cue = "/VO/Chronos_0917", Text = "Malicious {#Emph}cur!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0918", Text = "You mongrel!" },
				{ Cue = "/VO/Chronos_0919", Text = "Contemptible hound!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.5,
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
					{ Name = "ChronosSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/Chronos_0950", Text = "Get off of me, weasel!" },
				{ Cue = "/VO/Chronos_0951", Text = "You dare scratch me, weasel?" },
				{ Cue = "/VO/Chronos_0952", Text = "Ill-tempered little brute!" },
				{ Cue = "/VO/Chronos_0953", Text = "A {#Emph}weasel {#Prev}bred for war?", PlayFirst = true },
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
				{ Name = "ChronosSpokeRecently", Time = 16 },
			},
			GameStateRequirements =
			{
			},

			{ Cue = "/VO/Chronos_0351", Text = "What is this?" },
			{ Cue = "/VO/Chronos_0352", Text = "And...?" },
			{ Cue = "/VO/Chronos_0353", Text = "Oh...?" },
			{ Cue = "/VO/Chronos_0354", Text = "Huh." },
			{ Cue = "/VO/Chronos_0355", Text = "Please." },
			{ Cue = "/VO/Chronos_0356", Text = "Pishposh." },
			{ Cue = "/VO/Chronos_0357", Text = "Meaningless." },
			{ Cue = "/VO/Chronos_0358", Text = "This matters not." },
			{ Cue = "/VO/Chronos_0359", Text = "Oh, {#Emph}stop." },
			{ Cue = "/VO/Chronos_0360", Text = "Calm down." },
			{ Cue = "/VO/Chronos_0361", Text = "That I felt." },
			{ Cue = "/VO/Chronos_0362", Text = "Such ferocity." },
			{ Cue = "/VO/Chronos_0363", Text = "Such rancor." },
			{ Cue = "/VO/Chronos_0364", Text = "Such rage." },
			{ Cue = "/VO/Chronos_0365", Text = "Mm." },
			{ Cue = "/VO/Chronos_0366", Text = "Mm, mm!" },
			{ Cue = "/VO/Chronos_0367", Text = "Tsk, tsk..." },
			{ Cue = "/VO/Chronos_0368", Text = "I see..." },
			{ Cue = "/VO/Chronos_0369", Text = "How uncouth." },
			{ Cue = "/VO/Chronos_0370", Text = "Manners...!" },
			{ Cue = "/VO/Chronos_0371", Text = "Vainglorious girl!" },
			{ Cue = "/VO/Chronos_0372", Text = "Arrogant child." },
			{ Cue = "/VO/Chronos_0373", Text = "Ignorant child." },
			{ Cue = "/VO/Chronos_0374", Text = "Mannerless child..." },
			{ Cue = "/VO/Chronos_0375", Text = "Contemptuous child..." },
			{ Cue = "/VO/Chronos_0376", Text = "Meddlesome brat!" },
			{ Cue = "/VO/Chronos_0377", Text = "Scurrilous brat..." },
			{ Cue = "/VO/Chronos_0378", Text = "Unrepentant scamp..." },
			{ Cue = "/VO/Chronos_0379", Text = "You little scamp..." },
			{ Cue = "/VO/Chronos_0380", Text = "You rascal..." },
			{ Cue = "/VO/Chronos_0381", Text = "Incorrigible..." },
			{ Cue = "/VO/Chronos_0382", Text = "You upstart!" },
			{ Cue = "/VO/Chronos_0383", Text = "You impertinent..." },
			{ Cue = "/VO/Chronos_0384", Text = "Bothersome little..." },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.05,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 12 },
					{ Name = "ChronosDamageSpeech", Time = 40 },
				},
				GameStateRequirements =
				{
				},

				{ Cue = "/VO/Chronos_0385", Text = "{#Emph}Bah..." },
				{ Cue = "/VO/Chronos_0386", Text = "{#Emph}Khh..." },
				{ Cue = "/VO/Chronos_0387", Text = "{#Emph}Nrgh...!" },
				{ Cue = "/VO/Chronos_0388", Text = "{#Emph}Hrn..." },
				{ Cue = "/VO/Chronos_0389", Text = "You..." },
				{ Cue = "/VO/Chronos_0390", Text = "How..." },
				{ Cue = "/VO/Chronos_0391", Text = "How...?" },
				{ Cue = "/VO/Chronos_0392", Text = "But..." },
				{ Cue = "/VO/Chronos_0393", Text = "This..." },
				{ Cue = "/VO/Chronos_0394", Text = "I..." },
				{ Cue = "/VO/Chronos_0395", Text = "You would dare?" },
				{ Cue = "/VO/Chronos_0397", Text = "Absurd..." },
				{ Cue = "/VO/Chronos_0398", Text = "Preposterous..." },
				{ Cue = "/VO/Chronos_0399", Text = "Nonsense..." },
				{ Cue = "/VO/Chronos_0400", Text = "Ridiculous..." },
				{ Cue = "/VO/Chronos_0401", Text = "Unbelievable..." },
				{ Cue = "/VO/Chronos_0402", Text = "Outrageous..." },
				{ Cue = "/VO/Chronos_0403", Text = "Damnation..." },
				{ Cue = "/VO/Chronos_0404", Text = "This is...!" },
				{ Cue = "/VO/Chronos_0405", Text = "Not... yet...!" },
				{ Cue = "/VO/Chronos_0406", Text = "Confound it...!" },
				{ Cue = "/VO/Chronos_0396", Text = "History repeats...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Chronos" },
							Comparison = ">=",
							Value = 3,
						},
					}
				},
			},
		},

		OnInvisStartVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "Chronos",
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.25,
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 6 },
				{ Name = "ChronosInvisReactionSpeech", Time = 40 },
			},

			{ Cue = "/VO/Chronos_0691", Text = "Show yourself!", PlayFirst = true },
			{ Cue = "/VO/Chronos_0692", Text = "Where did you go..." },
			{ Cue = "/VO/Chronos_0693", Text = "A trick of the eye." },
			{ Cue = "/VO/Chronos_0694", Text = "You cannot hide." },
			{ Cue = "/VO/Chronos_0695", Text = "You little sneak!" },
			{ Cue = "/VO/Chronos_0696", Text = "Your father's tricks?" },
		},

		PhaseEndedVoiceLines =
		{
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.15,
				GameStateRequirements =
				{
					--[[ also available
					{
						PathFromSource = true,
						Path = { "AIStageActive" },
						Comparison = ">=",
						Value = 4,
					},
					]]--
					{
						FunctionName = "RequiredBossPhase",
						FunctionArgs = { Phase = 1 },
					},
				},

				{ Cue = "/VO/MelinoeField_1408", Text = "Fall!" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredBossPhase",
						FunctionArgs = { Phase = 2 },
					},
				},

				{ Cue = "/VO/Chronos_0265", Text = "What... I..." },
				{ Cue = "/VO/Chronos_0266", Text = "You {#Emph}brat..." },
				{ Cue = "/VO/Chronos_0267", Text = "{#Emph}Urgh... gah..." },
				{ Cue = "/VO/Chronos_0268", Text = "How... {#Emph}dare..." },
				{ Cue = "/VO/Chronos_0269", Text = "But... {#Emph}ungh...", PlayFirst = true },
				{ Cue = "/VO/Chronos_0270", Text = "{#Emph}<Gasp>... <Gasp>..." },
				{ Cue = "/VO/Chronos_0271", Text = "{#Emph}Augh... ngh..." },
				{ Cue = "/VO/Chronos_0272", Text = "Blast... you..." },
				{ Cue = "/VO/Chronos_0273", Text = "Why... you..." },
				{ Cue = "/VO/Chronos_0878", Text = "Accursed... child..." },
				{ Cue = "/VO/Chronos_0880", Text = "{#Emph}Ungh... hrnn..." },
				{ Cue = "/VO/Chronos_0881", Text = "You... damnable..." },
				{ Cue = "/VO/Chronos_0882", Text = "{#Emph}Guh... {#Prev}absurd..." },
				{ Cue = "/VO/Chronos_0879", Text = "{#Emph}Gah... {#Prev}again...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
						}
					}
				},
				{ Cue = "/VO/Chronos_0883", Text = "Even... now...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Chronos" },
							Comparison = ">=",
							Value = 8,
						},
					},
				},
				{ Cue = "/VO/Chronos_0274", Text = "Time... out...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Chronos" },
							Comparison = ">=",
							Value = 20,
						},
					},
				},
			}
		},
		NextPhaseVoiceLines =
		{
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 1.0,
					-- SuccessiveChanceToPlay = 0.66,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredBossPhase",
							FunctionArgs = { Phase = 2 },
						},
					},
					TriggerCooldowns = { "ChronosSpokeRecently" },

					{ Cue = "/VO/Chronos_0245", Text = "Three... two... {#Emph}one..." },
					{ Cue = "/VO/Chronos_0246", Text = "Three... two... {#Emph}one...!" },
					{ Cue = "/VO/Chronos_0247", Text = "Three... two... {#Emph}one!", PlayFirst = true },
					{ Cue = "/VO/Chronos_0248", Text = "Three... two... {#Emph}one." },
					{ Cue = "/VO/Chronos_0249", Text = "This... ends... {#Emph}now...!" },
					{ Cue = "/VO/Chronos_0250", Text = "This... ends... {#Emph}now..." },
					{ Cue = "/VO/Chronos_0251", Text = "Time... to... {#Emph}die...!" },
					{ Cue = "/VO/Chronos_0252", Text = "Time... is... {#Emph}up...!" },
					{ Cue = "/VO/Chronos_0256", Text = "A moment, if you please...!" },
					{ Cue = "/VO/Chronos_0253", Text = "Now...", PreLineWait = 2.0 },
					{ Cue = "/VO/Chronos_0254", Text = "Now...!", PreLineWait = 2.0 },
					{ Cue = "/VO/Chronos_0255", Text = "Now!", PreLineWait = 2.0 },
					{ Cue = "/VO/Chronos_0872", Text = "One... more... {#Emph}time." },
					{ Cue = "/VO/Chronos_0873", Text = "I... think... {#Emph}not." },
					{ Cue = "/VO/Chronos_0874", Text = "I... felt... that.",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
							},
							{
								Path = { "GameState", "EnemyKills", "Chronos" },
								Comparison = ">=",
								Value = 5,
							},
						},
					},
					{ Cue = "/VO/Chronos_0875", Text = "You... shall... {#Emph}not." },
					{ Cue = "/VO/Chronos_0876", Text = "Come... with... {#Emph}me." },
					{ Cue = "/VO/Chronos_0877", Text = "You... are... {#Emph}done." },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 1.0,
					-- SuccessiveChanceToPlay = 0.66,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredBossPhase",
							FunctionArgs = { Phase = 3 },
						},
					},
					TriggerCooldowns = { "ChronosSpokeRecently" },

					{ Cue = "/VO/Chronos_0988", Text = "My patience... has its {#Emph}limits!" },
					{ Cue = "/VO/Chronos_0989", Text = "I... have had... {#Emph}enough!" },
					{ Cue = "/VO/Chronos_0990", Text = "Time... cannot... be {#Emph}stopped!" },
					{ Cue = "/VO/Chronos_0991", Text = "That... is quite... {#Emph}enough!" },
					{ Cue = "/VO/Chronos_0992", Text = "You... foolish... {#Emph}girl!" },
					{ Cue = "/VO/Chronos_0993", Text = "All... returns... to {#Emph}dust!" },
					{ Cue = "/VO/Chronos_0994", Text = "This... cannot... {#Emph}be!" },
					{ Cue = "/VO/Chronos_0995", Text = "This... is... the {#Emph}end!" },
					{ Cue = "/VO/Chronos_0996", Text = "You wish to see the end of Time? {#Emph}Here {#Prev}it is!", PlayFirst = true },
				},
			},
		},
		DefeatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

				{ Cue = "/VO/Chronos_0275", Text = "Time... cannot... be stopped...!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0276", Text = "Time... cannot... be stopped..." },
				{ Cue = "/VO/Chronos_0277", Text = "But, Time... cannot... be stopped..." },
				{ Cue = "/VO/Chronos_0278", Text = "You... shall not... succeed..." },
				{ Cue = "/VO/Chronos_0279", Text = "{#Emph}Hah, haha, hahah..." },
				{ Cue = "/VO/Chronos_0280", Text = "{#Emph}Hahaha, hah, hah..." },
				{ Cue = "/VO/Chronos_0281", Text = "I always... shall... return..." },
				{ Cue = "/VO/Chronos_0283", Text = "How is this... possible...?" },
				{ Cue = "/VO/Chronos_0284", Text = "Do not... presume... you won..." },
				{ Cue = "/VO/Chronos_0285", Text = "You think... that you... prevailed...?" },
				{ Cue = "/VO/Chronos_0286", Text = "May all... my kin... be damned...!" },
				{ Cue = "/VO/Chronos_0288", Text = "This I... shall not... forget..." },
				{ Cue = "/VO/Chronos_0289", Text = "Once more... you bested... me..." },
				{ Cue = "/VO/Chronos_0290", Text = "I shall... remember... this..." },
				{ Cue = "/VO/Chronos_0282", Text = "No god... can vanquish... me...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
						},
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0287", Text = "Curse you... and all... the gods...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
						},
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1364", Text = "{#Emph}Nrrraaaaauugggghhhh...!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1365", Text = "What is happening to me...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1366", Text = "{#Emph}Imposter! {#Prev}How did you...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1367", Text = "What, I... feel... most odd...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1368", Text = "Time... cannot... be...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1369", Text = "What have you done to me...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1370", Text = "The sting of my own scythe...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},
				{ Cue = "/VO/Chronos_1371", Text = "You, who did this to me, how...?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					}
				},

			},
		},
		DeathSound = "/SFX/StabSplatterEndSequence",

		TextLinesUseWeaponIdle = true,
		BossIntroTextLineSets =
		{
			ChronosBossFirstMeeting =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
				},
				{ Cue = "/VO/Chronos_0164", PreLineWait = 0.35,
					Text = "Let yourself in, I see. Through the gutter? This family never had any class! Though I am working on alleviating that within this House, if you would pardon all the {#Emph}dust. {#Prev}We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0165",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "A family with no class, and no civility, either. Have I not made clear to you that your attempt to do me harm shall be in vain? I am a deathless {#Emph}Titan. {#Prev}You merely are a poor, misguided {#Emph}girl." },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { StartWait = 0.2, EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, {#Emph}fighting {#Prev}is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time {#Prev}for you to {#Emph}go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},
			-- for early arrivals, never met
			ChronosBossFirstMeeting_B =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
				},
				{ Cue = "/VO/Chronos_0204", PreLineWait = 0.35,
					Text = "Pray, who might you be, my girl? It is not often that I entertain of late. Perhaps after this House becomes a little more presentable... though for the moment, you must pardon all the dust. We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0205",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "{#Emph}Ahh{#Prev}, what a surprise. My granddaughter! The one loose end I failed to tie up, now fully grown, almost. I have so many questions, if you please. How have you been? And how, exactly, did you find me here?" },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, fighting is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time for you to go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},
			-- for early arrivals after first postboss encounter
			ChronosBossFirstMeeting_C =
			{
				PlayOnce = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosReveal01", "ChronosReveal01B" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossFirstMeeting_B" },
					},
				},
				{ Cue = "/VO/Chronos_0207", PreLineWait = 0.35,
					Text = "A guest, arrived so soon! It is not often that I entertain of late. Perhaps after this House becomes a little more presentable... though for the moment, you must pardon all the dust. We have been {#Emph}renovating {#Prev}around here." },
				{ Cue = "/VO/MelinoeField_1311", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up. You get up off that stolen throne! You know who I am, and you know why I'm here." },
				{ Cue = "/VO/Chronos_0208",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "Come, now, Granddaughter. There is no need to rush! You have come all this way. And I have so many questions. How have you been? And how, exactly, did you find me here?" },
				{ Cue = "/VO/MelinoeField_1312", UsePlayerSource = true,
					PreLineThreadedFunctionName = "MagicWordPresentation", PreLineThreadedFunctionArgs = { EndWait = 12.2 },
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "Melinoe_Gesture", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Hear me, you enemy of Night and Darkness, now; \n {#Emph}For your transgressions, you shall imminently die; \n {#Emph}Under chthonic doctrine, this I vow! \n {#Emph}For there is no escape from Fate beneath the sky." },
				{ Cue = "/VO/Chronos_0166",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Manners! {#Prev}Cursing is forbidden in this House. By that token, fighting is forbidden as well. But for you, my girl? We shall have to make an exception. {#Emph}Time for you to go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						ObjectType = "Chronos",
						TriggerCooldowns = { "ChronosSpokeRecently" },

						{ Cue = "/VO/Chronos_0456", Text = "Behold!" },
					},
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1313", Text = "{#Emph}Death to Chronos!" },
					},
				},
			},

			ChronosBossLostAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/Chronos_0167",
					Text = "You slipped through my fingers before, only to return and give to me another opportunity to add you to my collection? Did Athena truly get all the wisdom in our family?" },
				{ Cue = "/VO/MelinoeField_1314", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Your {#Emph}collection... {#Prev}you speak of your kin as objects to be put on display. The gods ought have put {#Emph}you {#Prev}on display after cutting you to pieces, instead of discarding you like common filth." },
				{ Cue = "/VO/Chronos_0168",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You know, I am still rather sore about all that. I truly thought my children would be different; that they would show their elders some respect. But they did not. And my tolerance... has its limits." },
			},

			ChronosBossWonAgainstHim01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Chronos_0169",
					Text = "Your eyes do not deceive; I am as hale and hearty as can be! That sinking sense you must have felt after our previous exchange? The fear of the utter senselessness of your entire enterprise? You now know it to be true." },
				{ Cue = "/VO/MelinoeField_1315", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I was never going to destroy you in a single clash. You more than anybody ought to know results of any worth take time." },
				{ Cue = "/VO/Chronos_0170",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Ahh{#Prev}, so then you wish to make a habit of such unceremonious appearances as {#Emph}this! {#Prev}As though they might amount to something, in the end. Fine. For my part, I occasionally need to stretch my limbs." },
			},

			ChronosBossAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.49, },
					},
				},
				{ Cue = "/VO/Chronos_0171",
					Text = "You should have seen the hideous appearance of this place when I arrived! Or, I suppose you {#Emph}did{#Prev}, but were too little to recall. I daresay now it is a little more presentable. Yet you barge in, tracking blood and filth across the floor." },
				{ Cue = "/VO/MelinoeField_1316", UsePlayerSource = true,
					Text = "My apologies to your custodial staff. Next time, I'll have to try to be a little more presentable when I arrive." },
				{ Cue = "/VO/Chronos_0172",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You seethe with bitter irony; but look at yourself! Come to confront me whilst more dead than alive. Well, the sooner I cast you out, the sooner my {#Emph}custodial staff {#Prev}can start to tidy up." },
			},

			ChronosBossAboutStyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.49, },
					},
				},
				{ Cue = "/VO/Chronos_0609",
					Text = "Did you enjoy your swim? The River Styx once flowed through here like blood. Foul traces of it yet remain in the Fields above, but now in my vicinity, it is all grains of gold." },
				{ Cue = "/VO/MelinoeField_2021", UsePlayerSource = true,
					Text = "You would transform the River Styx itself to suit your fancy? Or perhaps I heard you incorrectly. I may still have too many of your grains of gold stuck in my ears." },
				{ Cue = "/VO/Chronos_0610",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No wonder you have had such difficulty listening to me. Nevertheless, I trust the point I am about to make shall come through loud and clear." },
			},

			ChronosBossAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Intro" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Chronos_0603",
					Text = "You have been busy on the surface, have you not? Paid witness to indomitable fleets that sail toward inevitable victory, and the destruction of the mountain of the gods." },
				{ Cue = "/VO/MelinoeField_1951", UsePlayerSource = true,
					Text = "The only fleet I saw up there was a ramshackle mess whose crew could barely stand, much less put up a fight. No wonder you have failed to take Olympus yet." },
				{ Cue = "/VO/Chronos_0604",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "My fleets may not be to your standards, girl; but they have one important characteristic, which the gods all sorely lack: They are loyal to {#Emph}me {#Prev}to the end. Whichever end I {#Emph}deem!" },
			},

			ChronosBossAboutGoldenAge01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0175",
					Text = "You are too young to know what it was like. Before the gods re-shaped the world to be like this. Mortals did not have to die in agony, and waste away within this {#Emph}pit. {#Prev}A simpler age, and all the better for it." },
				{ Cue = "/VO/MelinoeField_1318", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "All the better, because you controlled every detail, is that it? You couldn't stand that others had a different outlook than your own. You went to war with your own children! After eating them whole, so they say." },
				{ Cue = "/VO/Chronos_0176",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "They say a lot of things! {#Emph}They {#Prev}went to war with {#Emph}me. {#Prev}My offspring and my other charges did not always take to discipline; I had too many to look after to take cheek from any one. And {#Emph}you{#Prev}, my girl, are not entitled to anything more." },
			},
			ChronosBossAboutGoldenAge02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGoldenAge01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
				},
				{ Cue = "/VO/Chronos_0501",
					Text = "You have by now seen something of this world. Consider what the gods have wrought: war, famine, betrayal! During my Golden Age, there were no such concerns. It was a tranquil time... until the gods decided to wrest control forcibly!" },
				{ Cue = "/VO/MelinoeField_1504", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Perhaps your rule was not as perfect as you claim. Perhaps you were a stifling presence on your children and their generation, leaving them with little choice but to rid themselves of you." },
				{ Cue = "/VO/Chronos_0502",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Well, they {#Emph}failed! {#Prev}And thus presents itself this golden opportunity to teach my {#Emph}children and their generation {#Prev}a most-valuable lesson about having to live with the consequences of their actions!" },
			},

			ChronosBossAboutSatyrs01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0493",
					Text = "My legions know you well by now; the trouble you have caused. Yet only my most ardent followers may spill their blood within my halls." },
				{ Cue = "/VO/MelinoeField_1500", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "These Satyr worshipers of yours must be very honored to be the first to die here. Not the wisest creatures, though, are they?" },
				{ Cue = "/VO/Chronos_0494",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The wise do not follow; the wise {#Emph}lead. {#Prev}These Satyrs lack a mortal fear of death, believing that their sacrifice shall bring me strength and that they shall live on. Let us {#Emph}grant {#Prev}their desire." },
			},

			ChronosBossAboutHistory01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Chronos_0214",
					Text = "The course of history is mine to shape. Yet you continue vexing me, as though you wish to do so in my stead. Fine, what shall it be? Shall I just go ahead and cede my rightful throne?" },
				{ Cue = "/VO/MelinoeField_1403", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You don't set the course of history... you're Time. You're just the paving stones we cross along our way. More than getting back at the gods, you're getting back at the Fates, who know your rightful place in all of this." },
				{ Cue = "/VO/Chronos_0215",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I do, in fact, take issue with the Fates. Though they ought to be none of {#Emph}your {#Prev}concern, or anyone's. Imagine being free to make your own decisions now, only to long for the weight of their yoke upon your back! How {#Emph}pathetic." },
			},

			ChronosBossAboutFuture01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Chronos_0497",
					Text = "The future is unwoven; uncertain. Not even the Fates themselves can anticipate how all of this shall end, or {#Emph}when. {#Prev}Yet you press on." },
				{ Cue = "/VO/MelinoeField_1502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I thought you were all about the inevitable. Whether the outcome of all this has been foretold or not, I'll see it through. Call it a morbid curiosity." },
				{ Cue = "/VO/Chronos_0498",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I call it reckless abandon, nothing more. You fail to consider the many possibilities in which you prove unable to enjoy the fruits of your labors..." },
			},

			ChronosBossAboutTime01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/Chronos_0499",
					Text = "A moment passes... then another, and another. I have names for them in every measure, you know? The very brief ones. The ones that linger..." },
				{ Cue = "/VO/MelinoeField_1503", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "If you're quite finished, I'll try not to take up more than a few of the very brief ones you mentioned." },
				{ Cue = "/VO/Chronos_0500",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I understand the need to cut {#Emph}Time {#Prev}down to smaller bits, I do. Hours, cut down to minutes. Minutes, cut down to seconds. Because the whole of it, my girl... is {#Emph}too much to fathom." },
			},

			ChronosBossAboutWeapons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Weapons" },
						HasAny = { "WeaponTorch", "WeaponAxe", "WeaponLob" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob" },
					},
				},
				{ Cue = "/VO/Chronos_0503",
					Text = "What {#Emph}are {#Prev}those {#Emph}garish {#Prev}instruments with which you try to cause such harm? Like as not some {#Emph}gadgets {#Prev}that the Fates themselves had vainly hoped would put an end to me!" },
				{ Cue = "/VO/MelinoeField_1505", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Whether they {#Emph}vainly {#Prev}hoped is yet to be determined. These may not be the arms the gods once used to bring you down but they'll get the job done just the same. You watch." },
				{ Cue = "/VO/Chronos_0504",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh we shall do more than {#Emph}watch{#Prev}, Hrodreptus and I. This scythe of mine is not merely for cutting short the Mourning Fields wheat, whilst putting back the Hound of Hell..." },
			},
			ChronosBossAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
					-- back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossSuit01" },
					},
				},
				{ Cue = "/VO/Chronos_0901",
					Text = "Now {#Emph}what {#Prev}is that preposterous contraption which you wear? Alas not even {#Emph}I {#Prev}am able to keep up with you young upstarts and your perplexing fashion trends." },
				{ Cue = "/VO/MelinoeField_3325", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Oh this is the Black Coat. I haven't put it on for fashion's sake, although you're right in that you won't be able to keep up." },
				{ Cue = "/VO/Chronos_0902",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Such confidence in your abilities, or in the Fates' designs. But you must know, newfangled armaments such as that cannot compare with the classics." },
			},
			ChronosBossAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "GoldifyKeepsake" },
					},
				},
				{ Cue = "/VO/Chronos_1384",
					Text = "Now what is that you have, which gleams of gold? Why, that is {#Emph}mine! {#Prev}One of my finest Time Pieces...! You {#Emph}thief! {#Prev}And now you brazenly come here with it?" },
				{ Cue = "/VO/MelinoeField_5027", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Oh I'm no {#Emph}thief{#Prev}. This was a {#Emph}gift! {#Prev}But let's not bother to get into that. I don't have all night. Neither do you." },
				{ Cue = "/VO/Chronos_1385",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "How astonishingly presumptuous. I have all the time in the world! But {#Emph}you{#Prev}, my girl, are {#Emph}quickly running out." },
			},

			ChronosBossAboutThanatosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
				},
				{ Cue = "/VO/Chronos_0607",
					Text = "I recognize that blade you bear: The scythe of Death himself! Alas that he was momentarily without it when I caught him in my snare, along with this House's other former residents." },
				{ Cue = "/VO/MelinoeField_1953", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You may have taken Death, yet death is here for you. It would be fitting if you met your end by Zorephet." },
				{ Cue = "/VO/Chronos_0608",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "It would be most unlikely, I should think. Then let us match now, scythe to scythe! Your Zorephet against my Hrodreptus. And we shall imminently see who reaps, and who sows." },
			},

			ChronosBossAboutWretches01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/MelinoeField_1506", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Pardon my lateness, I had some wretches to contend with. I thought you let everyone go, regardless of past transgressions." },
				{ Cue = "/VO/Chronos_0505",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I let just about everyone go, yes. You may be surprised, however, to learn that some of those so-called {#Emph}wretches {#Prev}do not care for Hades very much. They were quite eager to serve me instead, when nicely asked. With you, I shall not even bother." },
			},
			ChronosBossAboutTitans01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGoldenAge02" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Boss01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1508", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're so indignant of my father's generation. What came of yours? I don't see many of your contemporaries rallied to your cause, or any other for that matter." },
				{ Cue = "/VO/Chronos_0507",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Well, you see, most of the other Titans met their end, just as did I. The doing of your father and his {#Emph}generation! {#Prev}Perhaps when all of this is settled, I shall see to bringing my contemporaries back! A few of them." },
			},
			ChronosBossAboutOrigin01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/MelinoeField_1509", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Get up, wretch. Titan. {#Emph}Lord Master Chronos. {#Prev}Whatever they call you now. It's {#Emph}time{#Prev}, as you might say." },
				{ Cue = "/VO/Chronos_0508",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "It is, indeed. And they have called me many things; many names, in aeons past. There are those who think me nothing more than the offspring of Heaven and Earth, of all the {#Emph}nerve. {#Prev}And you are even less cordial than {#Emph}they." },
			},
			ChronosBossAboutClockwork01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Chronos_0550",
					Text = "Have you once marveled at the ever-turning gears in Tartarus? My little contribution to the Underworld's design; a steady means of moving things along. I call it {#Emph}clockwork. {#Prev}A cycle without end! Akin to the turning of the seasons." },
				{ Cue = "/VO/MelinoeField_1594", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I'm not here for a tour. That {#Emph}clockwork {#Prev}could have only come from {#Emph}you. {#Prev}An eyesore, going nowhere, groaning all along." },
				{ Cue = "/VO/Chronos_0551",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Going {#Emph}nowhere? {#Prev}One with capacity for magick ought espouse a deeper understanding of this world! We are always going {#Emph}somewhere; {#Prev}the {#Emph}future{#Prev}, my girl! Into the {#Emph}future." },
			},

			-- other reactions
			ChronosBossAboutGameplayTimer01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
				},
				{ Cue = "/VO/Chronos_0554",
					Text = "So you are keeping careful track of Time; such things of course are plain for me to see. But your reasons for it, I hardly can surmise. To gauge, perhaps, how quickly you shall fall?" },
				{ Cue = "/VO/MelinoeField_1596", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Either me or you. So how much time shall we require here tonight? In all your wisdom, surely you must know." },
				{ Cue = "/VO/Chronos_0555",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh, this shall take but a {#Emph}trifle{#Prev}, I expect! Not yet a formal measurement, although perhaps that too shall change..." },
			},
			ChronosBossAboutGameplayTimer02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutGameplayTimer01" },
					},
					{
						PathFalse = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
				},
				{ Cue = "/VO/Chronos_0556",
					Text = "You ceased to track the measurement of just how quickly we may settle our disputes. Was it too much for you? To be so self-aware of your inexorable flight toward uncertainty?" },
				{ Cue = "/VO/MelinoeField_1597", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I am an immortal goddess of the Underworld. Time means nothing to me. I can do this forever." },
				{ Cue = "/VO/Chronos_0557",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Is that so? {#Emph}Forever {#Prev}is a very long while. We shall have to make this slow and excruciating, to sate your gluttonous desire for more..." },
			},
			ChronosBossAboutPausing01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAny = { "WorldUpgradePauseChronosFight", "WorldUpgradeTimeSlowChronosFight" }
					},
				},
				{ Cue = "/VO/Chronos_0601",
					Text = "You have considerable power over Time, that you can turn some of my innate power against {#Emph}me! {#Prev}Perhaps your knack for this is merely a recessive family trait." },
				{ Cue = "/VO/MelinoeField_1950", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Don't insult me, and don't fool yourself. When you took my family, you created in me a lifelong desire to see you destroyed. So I simply prepared." },
				{ Cue = "/VO/Chronos_0602",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "A lifelong desire. Your {#Emph}life{#Prev}, girl, is but a blink of an eye to {#Emph}me! {#Prev}No one achieves abilities as yours through force of will alone. Though you are no mere {#Emph}god{#Prev}; you are a {#Emph}witch." },
			},

			ChronosBossAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyStaffHeat20IBoss",
							"BountyAxeHeat20IBoss",
							"BountyLobHeat20IBoss",
							"BountyDaggerHeat24IBoss",
							"BountyTorchHeat24IBoss",
							"BountySuitHeat24IBoss",
						},
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "WeaponPointsRare", },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Chronos_0905",
					Text = "An evening most-unusual this has turned out to be! My forces fought so fiercely against you, yet somehow proved unable to succeed... I shall have to have a word with them." },
				{ Cue = "/VO/MelinoeField_3327", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "They still shall fear me more than you. Through all of this adversity that you put up, I grow in strength. And when you too lie in ruin, Night's will shall finally be done." },
				{ Cue = "/VO/Chronos_0906",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Spoken like a mindless follower. My girl, you are not entirely dissimilar from some of those who regularly fail to do my bidding... and I shall treat you very much the same." },
			},

			ChronosBossAboutRandomBounties1 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutChaos01" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.AllRandomPackagedBounties,
					},
				},
				{ Cue = "/VO/Chronos_1237",
					Text = "The ill effects of Chaos, here... such senselessness! So then have you persuaded the Primordial Originator into thinking that I somehow got the best of our exchange? Nyx and the Three Fates, for nothing at all!" },
				{ Cue = "/VO/MelinoeField_3807", UsePlayerSource = true,
					Text = "Chaos indicated some displeasure, yes. But the effects you sense are no more to my benefit than yours. We're talking about a perfectly impartial being." },
				{ Cue = "/VO/Chronos_1238",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Impartial{#Prev}, you say? A thinking being is incapable of that! The moment Chaos first conceived of anything, they renounced impartiality forever! And certainly they are not on {#Emph}my {#Prev}side." },
			},

			ChronosBossAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
				{ Cue = "/VO/Chronos_1386",

					Text = "{#Emph}You{#Prev}, with all that vengeance on your mind, claiming to care nothing for the family which I denied you! {#Emph}Good{#Prev}, because you {#Emph}certainly {#Prev}did not miss much! They cared nothing for {#Emph}our family{#Prev}, either! Left me to {#Emph}rot! {#Prev}You are {#Emph}no different!" },
				{ Cue = "/VO/MelinoeField_5043", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You alone care deeply for our family, is that it? Come on. They left you to rot because you gave them every reason to hate you." },
				{ Cue = "/VO/Chronos_1401",
					Emote = "PortraitEmoteAnger",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Pah! {#Prev}They sought power I refused to share. They had not worked for it! Perhaps if they asked nicely, none of this would have elapsed. But there is no undoing past mistakes." },
			},

			-- about characters / about other characters
			ChronosBossAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Chronos_0173",
					Text = "You saw your father out there, I presume? He required a special arrangement. For aeons, he incarcerated countless souls within this place; not to mention {#Emph}me. {#Prev}Seemed only fitting he should have to waste away accordingly." },
				{ Cue = "/VO/MelinoeField_1317", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You couch it in morality, when vengeance is reason enough. Though since you've reasoned it all out, by what right did you take the other members of my family? And Nyx and all the rest?" },
				{ Cue = "/VO/Chronos_0174",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Why, because they opposed me. Except you have this rather vexing knack for resisting some of my time-honored techniques... a recessive family trait, perhaps. Although, your brother... he was not so fortunate. You, too, shall break, however... soon enough." },
			},
			ChronosBossAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosBossAboutHades01", "ChronosBossAboutGoldenAge01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny =
						{
							"HadesLifestealBoon",
							"HadesCastProjectileBoon",
							"HadesPreDamageBoon",
							"HadesChronosDebuffBoon",
							"HadesDashSweepBoon",
							"HadesInvisibilityRetaliateBoon",
							"HadesDeathDefianceDamageBoon",
							"HadesManaUrnBoon"
						},
					},
				},
				{ Cue = "/VO/Chronos_0495",
					Text = "Hades used some of his failing strength to spur you on! Even whilst bound in chains no god can break, your father yet proves to be a pest." },
				{ Cue = "/VO/MelinoeField_1501", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You've tortured and humiliated him. All this talk of how you plan to bring about a bygone age, yet petty vengeance seems to be your chief concern." },
				{ Cue = "/VO/Chronos_0496",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The thing is, my girl, I can have {#Emph}both. {#Prev}You should have seen the cruel, inventive ways your father tortured mortal souls! Thus I dispense a form of justice to {#Emph}him{#Prev}, and to {#Emph}you." },
			},

			ChronosBossAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0547",
					Text = "You are {#Emph}quite {#Prev}dangerous, I must admit. You have repeatedly breached into Tartarus, and this House; impossibilities, if not for your tainted bloodline! And you are able to withstand my conjuring. Might I again politely ask you {#Emph}how?" },
				{ Cue = "/VO/MelinoeField_1592", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You call that {#Emph}politely? {#Prev}You didn't even say the magick word. But since you really want to know... I'm from the future. You'll later come to realize the error of your ways, and teach me to stop you before you can cause more harm." },
				{ Cue = "/VO/Chronos_0548",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Ha ha ha! {#Prev}Oh, quite an imaginative tale. A comedy, for the utterly outrageous premise beggars belief! My girl, one cannot travel {#Emph}back {#Prev}in Time! Time marches ever forward; and I alone determine at which rate." },
			},

			ChronosBossAboutCerberus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Chronos_0212",
					Text = "You are proving to be quite a nuisance, if only because you insist on continually setting loose your father's wretched old three-headed cur! To think how such a beast used to be kept within these walls." },
				{ Cue = "/VO/MelinoeField_1402", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So you keep casting out poor Cerberus into the Mourning Fields, where he rages alone. Of all your unforgivable offenses..." },
				{ Cue = "/VO/Chronos_0213",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "What would you have me do? I do not require him to guard the gates to this realm, for they are open wide. And I certainly do not require him to shed everywhere. Though {#Emph}blood{#Prev}shed, I accept." },
			},

			ChronosBossAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "N_Boss01", "N_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/Chronos_0605",
					Text = "My work is made much easier for all the enemies Olympus has accrued. From the Satyrs, to the Harpies, to the Cyclops Polyphemus and much more! It is not I alone who seeks the downfall of the gods." },
				{ Cue = "/VO/MelinoeField_1952", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So you gathered up the dregs lusting for power or revenge! Such company you keep. I know that Polyphemus well enough by now... his loyalty can almost certainly be bought." },
				{ Cue = "/VO/Chronos_0606",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Oh{#Prev}, that it {#Emph}can. Loyalty {#Prev}is either earned or bought, and it makes very little difference either way. Polyphemus has his limitations, to be sure. But he is not a {#Emph}lost cause." },
			},
			ChronosBossAboutPolyphemus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutPolyphemus01" }
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Polyphemus" }
					},
				},
				{ Cue = "/VO/Chronos_0711",
					Text = "Why do you ceaselessly attack my humble shepherd Polyphemus, who seeks merely to attend his flock in peace? At least you have given him a bit of reprieve by being {#Emph}here." },
				{ Cue = "/VO/MelinoeField_2552", UsePlayerSource = true,
					Text = "Your humble shepherd doesn't let me leave the city of Ephyra willingly, so I've been showing myself out. You should know, he often is asleep on the job..." },
				{ Cue = "/VO/Chronos_0712",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Punishable behavior, if true! Of course, I pay that Cyclops next to nothing. And you always get what you pay for, girl..." },
			},

			ChronosBossAboutNyx01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Chronos_0903",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "When first I came here to this House, your father and his servants, they did not put up much of a fight. Not even Nyx herself! Although in fairness, I did take them by surprise." },
				{ Cue = "/VO/MelinoeField_3326", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "What did you think you would accomplish, taking Night Incarnate as your captive, among all the rest? Her influence is not so easily undone." },
				{ Cue = "/VO/Chronos_0904",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I grant you that it has been rather dark in spite of Nyx's temporary leave. Nevertheless, I do prefer having fewer disagreeable sorts about. Not even one, in fact." },
			},

			ChronosBossAboutChaos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1590", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You know, I'm almost impressed. Not only have you ransacked my father's domain and made war on Olympus, you had the audacity to deceive Primordial Chaos! That takes a spine." },
				{ Cue = "/VO/Chronos_0545",
					PreLineAnim = "Enemy_Chronos_SittingGreeting",
					Text = "Why thank you, my girl! I must admit, I thought that Chaos would be something of a bargainer, for I was willing to exchange their daughter Nyx for the Three Fates. But now, I have them all!" },
				{ Cue = "/VO/MelinoeField_1591", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You played the chthonic gods for a pack of fools... these eldest, most powerful forces in existence. Such choices may come back to haunt you." },
				{ Cue = "/VO/Chronos_0546",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Yes, {#Emph}you {#Prev}have come back to haunt me here repeatedly. You, the best that the gods of the Underworld and Olympus have to offer. {#Emph}Bah!" },
			},

			ChronosBossAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutChaos01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1507", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "So what have you done with the Three Fates? You would incur the wrath of all chthonic gods, as though the wrath of all Olympus weren't enough..." },
				{ Cue = "/VO/Chronos_0506",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh, I banished them! Where, I cannot say, or {#Emph}when. {#Prev}In any event, they trouble us no longer, with their manipulative weavings. No, what happens now... is entirely up to {#Emph}us." },
			},

			ChronosBossAboutCharon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift02" },
					},
				},
				{ Cue = "/VO/Chronos_0552",
					Text = "I am quite flummoxed with that {#Emph}Boatman {#Prev}fellow just outside, who has the gall to scull his little boat right to my very doorstep! The Satyrs have more fear of {#Emph}him {#Prev}than {#Emph}you." },
				{ Cue = "/VO/MelinoeField_1595", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You ought fear him yourself. Lord Charon knows every stone in the Underworld... every drop in the five rivers. You say you can't be stopped? Neither can he." },
				{ Cue = "/VO/Chronos_0553",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "...That trinket-peddler, crudely hawking his ill-gotten wares to his very limited base of customers! And hoarding so much Gold I generously wrought. A noble ally that you have!" },
			},

			ChronosBossAboutScylla01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
				},
				{ Cue = "/VO/Chronos_0707",
					Text = "My understanding is that you attended quite the musical performance in the pit of Oceanus! To have navigated all of the infernal pipework just for that." },
				{ Cue = "/VO/MelinoeField_2550", UsePlayerSource = true,
					Text = "Oh, it's no trouble at all. Such a vibrant interest there in the performing arts! You should visit more often." },
				{ Cue = "/VO/Chronos_0708",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I truly ought, and wrest control over the blasted place as my rightful domain! For now, I merely sponsor some of the delightful programming you enjoy each night!" },
			},
			ChronosBossAboutScylla02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutScylla01" }
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
				},
				{ Cue = "/VO/Chronos_0709",
					Text = "Whilst I have yet to attend one myself, it is my understanding that performances by Scylla and her Siren cohort oft leave much to be desired. Perhaps I ought rescind my patronage..." },
				{ Cue = "/VO/MelinoeField_2551", UsePlayerSource = true,
					Text = "I do worry they're a bit of a sunk cost. I see the same handful of devoted listeners in their audience night after night, but no real signs of growth." },
				{ Cue = "/VO/Chronos_0710",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Well my girl, a small devoted audience is naught at which to scoff! I myself started with but a few Satyr devotees, and look how far I have come!" },
			},

			ChronosBossAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Eris_01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_1593", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I thought all the chthonic gods opposed you openly. But you persuaded {#Emph}Eris{#Prev}, of all creatures, to your side! A laughable alliance, though not bad for sowing more destruction and dissent." },
				{ Cue = "/VO/Chronos_0549",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I am owed credit for a great many things, my girl; but not for any such alliances with Strife! What use have I for Nyx's youngest whelp? Although perhaps she is no fool, if she has rallied to my banners as you say." },
			},

			ChronosBossAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					--[[
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					]]
				},
				{ Cue = "/VO/Chronos_0703",
					Text = "You somehow reached the mountain of the gods. Clashed with Prometheus himself, he claims! Whichever path you choose... we Titans shall be there." },
				{ Cue = "/VO/MelinoeField_2548", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Good. Then I have every opportunity to slay you all. So, you liberated the prisoner of Olympus in exchange for his servitude? I heard Prometheus once had integrity." },
				{ Cue = "/VO/Chronos_0704",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Oh {#Prev}but he has it still! Which is the reason he has joined my cause. Besides... who better to lead my strike forces against Olympus than one who was so unjustly wronged by the gods? For I cannot do {#Emph}everything {#Prev}myself!" },
			},
			ChronosBossAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutPrometheus01" },
					},
					-- Prometheus beaten PrevRun, the run before, or the run before
					{
						SumPrevRuns = 4,
						Path = { "EnemyKills", "Prometheus" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Chronos_0705",
					Text = "The Titan of Foresight confessed that you were able to withstand his fury. To which I said, {#Emph}Prometheus, my good fellow! If you knew this would transpire, why did you not forewarn me? And why did you not prevent it?" },
				{ Cue = "/VO/MelinoeField_2549", UsePlayerSource = true,
					Text = "Perhaps you overestimate the Titan of Foresight's power to clearly see into the future. Along with his strength." },
				{ Cue = "/VO/Chronos_0706",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "He claims to keep the details of the future to himself... so as not to alter the desired outcome. How convenient! It does not take a genius such as he to know I shall eventually prevail!" },
			},

			-- alt below
			ChronosBossAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossAboutTyphon01_B" },
					},
					--[[
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					]]--
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutChronos01" },
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0893",
					Text = "I understand your latest vainglorious attempt to re-claim Olympus for the gods did not pan out. Perhaps in the moment you witnessed the Father of All Monsters in all his terrifying stature, you at last understood your folly." },
				{ Cue = "/VO/MelinoeField_3320", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You awakened that monstrosity and call {#Emph}me {#Prev}vainglorious? Typhon is not going to take orders from you or {#Emph}anyone! {#Prev}You'll have nothing left to rule over if he has his way!" },
				{ Cue = "/VO/Chronos_0894",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No, you {#Emph}gods {#Prev}shall have nothing left to rule over if he has his way. And I, {#Emph}mine! {#Prev}Typhon may not be the negotiating type; but we need no agreement to pursue the same result." },
			},
			ChronosBossAboutTyphon01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossAboutTyphon01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutChronos01" },
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0997",
					Text = "I understand your latest vainglorious attempt to re-claim Olympus met with some success! Perhaps in the moment you witnessed the Father of All Monsters in all his terrifying stature, some primordial instinct took hold." },
				{ Cue = "/VO/MelinoeField_3320", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You awakened that monstrosity and call {#Emph}me {#Prev}vainglorious? Typhon is not going to take orders from you or {#Emph}anyone! {#Prev}You'll have nothing left to rule over if he has his way!" },
				{ Cue = "/VO/Chronos_0894",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No, you {#Emph}gods {#Prev}shall have nothing left to rule over if he has his way. And I, {#Emph}mine! {#Prev}Typhon may not be the negotiating type; but we need no agreement to pursue the same result." },
			},
			ChronosBossAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutTyphon01" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutChronos01" },
							},
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3321", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Tell me something, before I turn you back to dust again. If Typhon destroys Mount Olympus as you so desire, where do you expect he'll go from there? Back to sleep?" },
				{ Cue = "/VO/Chronos_0895",
					Text = "Oh, that is none of my concern. Ours is a wide world, and {#Emph}deep! {#Prev}Typhon shall have free rein to go where he pleases. Perhaps he shall rule over the seas in Poseidon's stead!" },
				{ Cue = "/VO/MelinoeField_3322", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Liar. You plan to double-cross him. Send him roaring back to the abyss after your use for him is ended. Not even {#Emph}you {#Prev}are fool enough to disregard him as a threat." },
				{ Cue = "/VO/Chronos_0896",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The future shall be well in hand, of that I can assure you, Granddaughter. Best focus on the present, and the many hardships we endure." },
			},
			ChronosBossAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutTyphon01" }
					},
					{
						SumPrevRuns = 4,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutChronos01" },
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0897",
					Text = "My, to have toppled Typhon from that mountaintop... certainly it was not something that you could have done alone, yet still! How {#Emph}proud {#Prev}you must have felt." },
				{ Cue = "/VO/MelinoeField_3323", UsePlayerSource = true,
					Text = "I felt a tinge of satisfaction, yes. But you do know what's an even greater feeling than thwarting the Father of All Monsters, don't you?" },
				{ Cue = "/VO/Chronos_0898",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "If you insinuate that besting me in battle is a thrill akin to overcoming the Great Despoiler of Olympus, then you flatter me, my girl. Go on and try... even as Typhon stirs." },
			},
			ChronosBossAboutTyphon04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutChronos01" },
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0899",
					Text = "{#Emph}Hmhmhm{#Prev}, angry now as ever! Do you wish to know exactly how I reawakened Typhon, my girl? Or how I managed it without you gods detecting what I had in store?" },
				{ Cue = "/VO/MelinoeField_3324", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Please indulge me, Grandfather. For I do so enjoy your tales." },
				{ Cue = "/VO/Chronos_0900",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You would never believe it if you knew. For you are narrow-minded, you and all the gods! I have {#Emph}outsmarted {#Prev}you... and I shall overpower you as well." },
			},
			ChronosBossAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" }
					},
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_0985",
					Text = "What have you done... to the Father of All Monsters, what have you {#Emph}done? {#Prev}For he is... nowhere to be found...!" },
				{ Cue = "/VO/MelinoeField_3879", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Such details are none of your concern, wretch. Know only that you're next. May your final moments be in pain." },
				{ Cue = "/VO/Chronos_0986",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You speak to me of pain... I can lock you with it for eternity. You shall come to understand it even better than I!" },
			},

			ChronosBossAboutAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},

				{ Cue = "/VO/MelinoeField_3662", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Odd. All of this looks entirely the same, and so do you, Titan. I had expected that perhaps this night had something new for me in store." },
				{ Cue = "/VO/Chronos_1063",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Oh, do not sound so disappointed, Granddaughter. If you wish for me to muster some newfangled trick of mine in order to enliven these proceedings, I am happy to oblige..." },
			},
			ChronosBossAboutAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--[[
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					]]--
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Chronos" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Chronos_1331",
					Text = "You think yourself quite clever and most skilled to have withstood the End of Time, but you achieved nothing at all! For I am here as usual, whilst you remain right {#Emph}there." },

				{ Cue = "/VO/MelinoeField_4563", UsePlayerSource = true,
					Text = "You also thought there was no possible way I could vanquish you, let alone in that End of Time place. You're more error-prone than you realize." },

				{ Cue = "/VO/Chronos_1332",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No, {#Emph}you {#Prev}are error-prone, my girl, because Time is by its very nature quite precise, and it is always right. But if you wish to test your suppositions, by all means." },
			},
			ChronosBossAboutAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Chronos" },
					},
				},

				{ Cue = "/VO/Chronos_1333",
					Text = "The End of Time was not to your liking, was it, {#Emph}hm? {#Prev}Why, if you wanted me to go a little {#Emph}easier{#Prev}, my girl, you merely could have asked..." },

				{ Cue = "/VO/MelinoeField_4564", UsePlayerSource = true,
					Text = "I'm here to see you destroyed, Titan, not to tour these bland locations that appear to be symbolic of your nature. I figure it shall go much more efficiently this way." },

				{ Cue = "/VO/Chronos_1334",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#Emph}Efficiently! {#Prev}Now you are truly sounding like a granddaughter of mine. Then let us settle once again our differences, but now in all due haste." },
			},

			ChronosBossAboutNoBoons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "MetGods" },
						UseLength = true,
						Comparison = "==",
						Value = 0,
					},
				},

				{ Cue = "/VO/Chronos_1329",
					Text = "I am accustomed to the {#Emph}stink {#Prev}of the Olympians and their {#Emph}supposed {#Prev}blessings on your person, so this occasion is a most-welcome reprieve. None of {#Emph}their {#Prev}power, merely {#Emph}yours!" },

				{ Cue = "/VO/MelinoeField_4562", UsePlayerSource = true,
					Text = "My power ought to be enough, I think. Though the more you underestimate me the better, I suppose. Shall we?" },

				{ Cue = "/VO/Chronos_1330",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Shall we {#Emph}what? {#Prev}Shall my Satyr worshipers and I dispose of our most-irritating interlopers {#Emph}again {#Prev}and {#Emph}again? {#Prev}Then {#Emph}yes{#Prev}, most certainly." },
			},

			-- @ ending
			ChronosBossAboutHecateKidnapped01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossKidnapped01" },
					},
					NamedRequirements = { "NearTrueEnding" },
				},

				{ Cue = "/VO/Chronos_0976", Source = "NPC_Chronos_01",
					Text = "What did you call that old witch whom you seem to care about so much? Your {#Emph}headmistress? {#Prev}Tell me now exactly who she is, if you yet value her well-being in the least." },

				{ Cue = "/VO/MelinoeField_3877", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "...She was my mother's handmaiden, nothing more. When you attacked my father's House, she took me away. When I came of age, I vowed to stop you; despite her efforts to dissuade me. Let her go." },

				{ Cue = "/VO/Chronos_0977", Source = "NPC_Chronos_01",
					PreLineWait = 0.35,
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "...At first I thought perhaps that you were a child of Zeus rather than Hades, but you are a terrible liar, Granddaughter. Now you shall suffer for your actions... or the {#Emph}handmaiden {#Prev}shall do so in your stead." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3878", Text = "{#Emph}Don't you touch her!" },
					},
				},
			},
			ChronosBossAboutHecateKidnapped02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutHecateKidnapped01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Chronos_0978", Source = "NPC_Chronos_01",
					PreLineWait = 0.35,
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "That headmistress of yours has proven not to be informative at all thus far. I can be even more persuasive if necessary, of course. But first, to the matter at hand..." },
			},

			ChronosBossPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Chronos_1049",
					Text = "Insolent girl. I do not know how you last managed to escape from me but you have gravely erred in setting foot again within these halls, thus giving {#Emph}me {#Prev}a second chance." },

				{ Cue = "/VO/MelinoeField_4135", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PostLineThreadedFunctionName = "SummonNeoChronos",
					Text = "This is not your second chance, Titan, but your last. You are an aberration and should not even exist, not here like this." },

				{ Cue = "/VO/Chronos_1050",
					PreLineWait = 1.0,
					Source = "NPC_Chronos_02",
					Text = "If I may interrupt? {#Emph}Erm{#Prev}, greetings! In case the resemblance is insufficient, I am {#Emph}you! {#Prev}Yet I am also {#Emph}me. {#Prev}I know this must be difficult to accept but my granddaughter is quite correct..." },

				{ Cue = "/VO/MelinoeField_4136", UsePlayerSource = true,
					PostLineThreadedFunctionName = "UnSummonNeoChronos",
					Text = "Grandfather, let me handle this. Knowing how {#Emph}you {#Prev}used to be, he won't be listening to reason here." },

				{ Cue = "/VO/Chronos_1051",
					PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "What is this foolishness, this... {#Emph}mockery?! {#Prev}You would confound me with these cheap illusions, whilst you deign to lecture {#Emph}me {#Prev}about what should exist or not? {#Emph}Begone!" },
			},
			ChronosBossPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Chronos_1271",
					Text = "You have seen that I do not stay gone. Fight me to your heart's content! No matter the outcome it is {#Emph}you {#Prev}who ends up banished from this place. Or are you here merely to rummage through your family's old, unneeded things?" },

				{ Cue = "/VO/MelinoeField_3871", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I have no need of anything of theirs. Only your head." },

				{ Cue = "/VO/Chronos_1272",
					PreLineWait = 0.35,
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "That you cannot have, my girl, for I shall be requiring it to rule the realms with wisdom such as my unruly children never had. And you, apparently, have even less." },
			},

			-- repeatable / other general cases
			ChronosBossMiscStart01 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0177",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Once more you have eluded my grasp in getting here, as though you wish to fall only to me." },
			},
			ChronosBossMiscStart02 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0178",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You shall find my patience limitless for all your foolish antics here, my girl." },
			},
			ChronosBossMiscStart03 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0179",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I spent aeons buried in the depths below; a few rude trespasses from you are hardly of concern." },
			},
			ChronosBossMiscStart04 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0180",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "This little spat with you was clearly never going to resolve in a more-civil way..." },
			},
			ChronosBossMiscStart05 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0181",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Long have I lorded on this throne; a bit of vigorous activity should do me well." },
			},
			ChronosBossMiscStart06 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0182",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "To think that the combined might of my forces proved insufficient against a mere girl." },
			},
			ChronosBossMiscStart07 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0183",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You are methodical, I grant you that. But I shall have to take from you much more." },
			},
			ChronosBossMiscStart08 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0184",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You cannot be in two places at once. Whilst you vainly lash out, Olympus burns..." },
			},
			ChronosBossMiscStart09 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0185",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Time can seem to pass in an instant, or last an eternity. On this occasion, let us make it quick." },
			},
			ChronosBossMiscStart10 =
			{
				GameStateRequirements =
				{
					{
						--
					},
				},
				{ Cue = "/VO/Chronos_0186",
					PostLineFunctionName = "StartFinalBossChronos",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The Fates themselves could not prevent my rightful rule; what hope have you?" },
			},

		},

		BossPhaseChangeTextLineSets =
		{
			ChronosBossR2Outro01 =
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
					{
						FunctionName = "RequiredBossPhase",
						FunctionArgs = { Phase = 3 },
					},
				},
				{ Cue = "/VO/Chronos_0987",
					Portrait = "Portrait_Chronos_Pained_01",
					-- PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					PreLineWait = 0.5,
					Text = "...I have withstood the gods... even the Fates! Yet you would deign to bring me low. How {#Emph}dare {#Prev}you. How {#Emph}dare {#Prev}you?" },
			},

			ChronosR1FirstWin =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0216",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Nngh! {#Prev}This audience has lasted long enough. You do not get to {#Emph}barge {#Prev}into this House, and waste {#Emph}my {#Prev}time! I {#Emph}am {#Prev}Time. And I can make your every moment {#Emph}hell." },
			},

			ChronosR1Win01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0221",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Nrgh{#Prev}, you wretched child...! Like father, like daughter, then, is it...?" },
			},
			ChronosR1Win02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0222",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...You do not belong here... you do not belong {#Emph}anywhere{#Prev}, at all..." },
			},
			ChronosR1Win03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0223",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "{#Emph}Pah...! {#Prev}It took six full-grown gods to thwart me once... not one mere {#Emph}child!" },
			},
			ChronosR1Win04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0224",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Heh heh... {#Prev}so, you possess some of your father's strength. Or rather, {#Emph}mine..." },
			},
			ChronosR1Win05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0225",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Augh... {#Prev}I grow quite weary of this dour place..." },
			},
			ChronosR1Win06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0226",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "...{#Emph}Ungh... {#Prev}perhaps... a change of scenery is best..." },
			},

		},

		BossOutroTextLineSets =
		{
			ChronosBossOutro01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0217",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}<Gasp> {#Prev}I thought... {#Emph}none {#Prev}could resist the ravages of Time... but, {#Emph}you? How...?" },
				{ Cue = "/VO/MelinoeField_1404", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You'll get no answers from me, and no mercy, either. Now {#Emph}die{#Prev}, already. And I'll collect the ichor from your veins. Or whatever flows through them." },
				{ Cue = "/VO/Chronos_0218",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "{#Emph}Hah, hah, hah! {#Prev}What is death to the deathless? A mere nuisance! This House is {#Emph}mine. {#Prev}Once I am gone... you shall be cast away." },
				{ Cue = "/VO/MelinoeField_1405",  UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I expect so. And you'll be re-made and back on the throne before I can return. But I {#Emph}shall {#Prev}return. And I'll slay you again, and again, and {#Emph}again{#Prev}, if I must." },
				{ Cue = "/VO/Chronos_0219",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "Even if, in so doing, it meant that you would never see your dear old family again? Because the mercy I have shown to them thus far is something I may have to re-evaluate." },
				{ Cue = "/VO/MelinoeField_1406",  UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}Our {#Prev}family. And what do I care? I don't even know them. But I {#Emph}do {#Prev}know you ought be dead here in another moment; any last words?" },
				{ Cue = "/VO/Chronos_0892",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "...For you, my girl...? A mere reminder... nothing more..." },
			},

			ChronosBossOutroUltimateProgress01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutFamily01" },
					},
				},
				{ Cue = "/VO/Chronos_1402",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },

					Text = "{#Emph}Argh... {#Prev}some family {#Emph}you {#Prev}are! Go on and try to cast me out as they once did! See what good shall come of it!" },

				{ Cue = "/VO/MelinoeField_5044", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I intend to. Though if you wished to be part of the family so much, perhaps you oughtn't have waged war with them." },

				{ Cue = "/VO/Chronos_1403",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "With {#Emph}them{#Prev}, you say! Not {#Emph}us! {#Prev}You, too, are a reject, daughter of Hades! Always shall be, and always would have been!" },
			},
			ChronosBossOutroUltimateProgress02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutroUltimateProgress01" },
					},
				},
				{ Cue = "/VO/Chronos_1404",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },

					Text = "{#Emph}Gah... {#Prev}you gods learn nothing from the past! Recklessly changed everything to suit your whim!" },

				{ Cue = "/VO/MelinoeField_5045", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're the one who's learned nothing. Despite all the time you've had to think on it." },

				{ Cue = "/VO/Chronos_1405",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "Oh on the contrary... I know change is inevitable, with Time... the only question is... which sort..." },
			},

			-- alt below
			ChronosBossOutroPreTrueEnding01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosBossPreTrueEndingOutro01_B", "ChronosBossAboutTyphonDeath01" },
					},
				},
				{ Cue = "/VO/Chronos_1275",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },

					Text = "{#Emph}...Gah. Hah, hah! {#Prev}Again you lay me low. And again you waste your {#Emph}time. {#Prev}I know what it is you seek..." },

				{ Cue = "/VO/MelinoeField_3880", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Shut up and die, Titan. And know these moments as you writhe shall be your last. Mere void awaits." },

				{ Cue = "/VO/Chronos_1276",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "You truly think... the Mirror of Night shall grant you such power? Nyx holds no sway here any longer! You shall see..." },
			},
			ChronosBossOutroPreTrueEnding01_B =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutTyphonDeath01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossPreTrueEndingOutro01" },
					},
				},
				{ Cue = "/VO/Chronos_1275",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },

					Text = "{#Emph}...Gah. Hah, hah! {#Prev}Again you lay me low. And again you waste your {#Emph}time. {#Prev}I know what it is you seek..." },

				{ Cue = "/VO/MelinoeField_3880", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Shut up and die, Titan. And know these moments as you writhe shall be your last. Mere void awaits." },

				{ Cue = "/VO/Chronos_1277",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "You truly think... the power which you used on Typhon can be turned on me? Then prove it! I would like to see you {#Emph}try!" },
			},

			ChronosBossOutroPostTrueEnding01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_1052",
					PreLineWait = 0.35,
					Portrait = "Portrait_Chronos_Pained_01",
					PortraitExitAnimation = "Portrait_Chronos_Pained_01_Exit",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.35 },

					PostLineThreadedFunctionName = "SummonNeoChronos", PostLineThreadedFunctionArgs = { UseSourceForDestination = true },

					Text = "{#Emph}Nraugh... {#Prev}but I thought... none could possibly resist the ravages of Time... but, {#Emph}you? How...?" },

				{ Cue = "/VO/Chronos_1053",
					PreLineWait = 1.0,
					Source = "NPC_Chronos_02",
					--PostLineThreadedFunctionName = "UnSummonNeoChronos",
					Text = "You, my vestige, shall unfortunately never know. Now forgive this old man his transgressions..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Chronos_02",

						-- { Cue = "/VO/Chronos_1108", Text = "{#Emph}May time flow freely forth!" },
					},
				},

			},

			ChronosBossMiscDefeat01 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0227",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ungh...! {#Prev}This matters not... my plans are already... well underway..." },
			},
			ChronosBossMiscDefeat02 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0228",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ngh... {#Prev}I have... returned from worse... suffered much worse... than from the likes of you..." },
			},
			ChronosBossMiscDefeat03 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0229",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh... {#Prev}you truly are a nuisance, to be sure... but you accomplish naught..." },
			},
			ChronosBossMiscDefeat04 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Chronos_0230",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Gah... {#Prev}to have been brought this low once more, by a mere {#Emph}god..." },
			},
			ChronosBossMiscDefeat05 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0231",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Urgh... {#Prev}you are no granddaughter of mine... that you would deign to treat me thus...!" },
			},
			ChronosBossMiscDefeat06 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0232",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Mmph... {#Prev}I always... hated... children such as you..." },
			},
			ChronosBossMiscDefeat07 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0233",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Khh... {#Prev}I curse the day... your father... sired you..." },
			},
			ChronosBossMiscDefeat08 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0234",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Rrngh...! {#Prev}How... are you able to resist...?" },
			},
			ChronosBossMiscDefeat09 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0235",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Guh... {#Prev}goodbye again, only for now, my girl..." },
			},
			ChronosBossMiscDefeat10 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0236",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Nrgh... {#Prev}you waste your precious time... Olympus {#Emph}burns..." },
			},
			ChronosBossMiscDefeat11 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0237",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Rngh... {#Prev}you cannot stop me... merely... slow me down a bit..." },
			},
			ChronosBossMiscDefeat12 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0238",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Argh...! {#Prev}How is it that I cannot vanquish such a {#Emph}brat...?" },
			},
			ChronosBossMiscDefeat13 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0239",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}<Gasp> {#Prev}My age, perhaps, is catching up with me..." },
			},
			ChronosBossMiscDefeat14 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0240",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Hngh... {#Prev}once more, you bring me low... but not for long..." },
			},
			ChronosBossMiscDefeat15 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0241",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Tsch... {#Prev}brought low once more... for what? Some grains of {#Emph}Sand?" },
			},
			ChronosBossMiscDefeat16 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0242",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Naugh... {#Prev}this victory of yours... shall be short-lived..." },
			},
			ChronosBossMiscDefeat17 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0243",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Nngh...! {#Prev}Once more... I am undone...! I shall be back... in the blink of an eye..." },
			},
			ChronosBossMiscDefeat18 =
			{
				SkipContextArt = true,
				GameStateRequirements = 
				{
				},
				{ Cue = "/VO/Chronos_0244",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Raugh... {#Prev}of all my vexing relatives... you are amongst the worst..." },
			},

			ChronosBossAltFightMiscDefeat01 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0998",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Grngh... {#Prev}monstrous... grandchild... you..." },
			},
			ChronosBossAltFightMiscDefeat02 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_0999",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Augh... {#Prev}but this... is impossible..." },
			},
			ChronosBossAltFightMiscDefeat03 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_1000",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Nrrgh... {#Prev}how... could this... transpire...?" },
			},
			ChronosBossAltFightMiscDefeat04 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Chronos_1001",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Rngh... {#Prev}you... accursed... Fates...!" },
			},
			ChronosBossAltFightMiscDefeat05 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossChronos01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossChronos02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_1002",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Argh... {#Prev}I struck... not even {#Emph}once...?" },
			},
			ChronosBossAltFightMiscDefeat06 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos01" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossChronos01", "TookDamage" }
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos02" }
							},
							{
								PathFalse = { "CurrentRun", "EncounterClearStats", "BossChronos02", "TookDamage" }
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_1003",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Hngh... {#Prev}you... eluded me... at each and every turn..." },
			},
			ChronosBossAltFightMiscDefeat07 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossChronos01", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossChronos02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_1004",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Gah... {#Prev}you were... too swift... even for Time...?" },
			},
			ChronosBossAltFightMiscDefeat08 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				GameStateRequirements = 
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos01" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossChronos01", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EncounterClearStats", "BossChronos02" }
							},
							{
								Path = { "CurrentRun", "EncounterClearStats", "BossChronos02", "ClearTime" },
								Comparison = "<=",
								Value = 40.0
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_1005",
					Portrait = "Portrait_Chronos_Pained_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#Emph}Ngh... {#Prev}such haste... I have not seen such haste since..." },
			},
		},
		Using = { Spawn = "ChronosRemains"},
	},

	Chronos_TyphonFight =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Chronos",
		Portrait = "Portrait_Chronos_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ChronosVoice,
		EmoteOffsetY = -320,
		EmoteOffsetX = 85,
		SpeakerName = "Chronos",
		LoadPackages = { "Chronos", },
		RunHistoryKilledByName = "NPC_Chronos_01",

		RequiredKill = false,

		CannotDieFromDamage = true,
		
		HitInvulnerablePresentationThreadedFunctionName = "ChronosTyphonFightHitPresentation",
		InvulnerableHitFx = "ChronosTeleportFxFront",
		IgnoreInvincibubbleOnHit = true,

		Material = "Organic",
		HealthBarTextId = "Chronos_Full",
		HealthBarOffsetY = -275,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,
		RepulseOnMeleeInvulnerableHit = 150,

		IgnoreTimeSlowEffects = true,

		MoneyDropOnDeath = {},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					IgnoreTimeSlowEffects = false,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
					},
				},
			},
			{
				FunctionName = "CheckElapsedTimeMultiplierIgnores",
			},
		},

		InvulnerableVoiceLines =
		{
			{ GlobalVoiceLines = "ChronosInvulnerableVoiceLines" },
		},
		ResistedVoiceLines =
		{
			{ GlobalVoiceLines = "ChronosResistedVoiceLines" },
		},

		PreFightVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.65,
				-- PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
				ObjectTypes = { "Chronos", "Chronos_TyphonFight" },
				Cooldowns =
				{
					{ Name = "ChronosFightIntroVO", Time = 10 },
				},

				{ Cue = "/VO/Chronos_1064", Text = "Expecting someone else?", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Chronos_1071", Text = "Oh good, you have arrived." },
				{ Cue = "/VO/Chronos_1072", Text = "To have come all this way..." },
				{ Cue = "/VO/Chronos_0008", Text = "Greetings, little one." },
				{ Cue = "/VO/Chronos_0024", Text = "How fare you, little one?" },
				{ Cue = "/VO/Chronos_0025", Text = "You." },
				{ Cue = "/VO/Chronos_0027", Text = "{#Emph}There {#Prev}you are." },
				{ Cue = "/VO/Chronos_0028", Text = "Just in time.", PlayFirst = true },
				{ Cue = "/VO/Chronos_0029", Text = "Greetings." },
				{ Cue = "/VO/Chronos_0783", Text = "Right on Time." },
				{ Cue = "/VO/Chronos_0791", Text = "What a coincidence." },
				{ Cue = "/VO/Chronos_1226", Text = "Olympus..." },
				{ Cue = "/VO/Chronos_1229", Text = "You called?" },
				{ Cue = "/VO/Chronos_1225", Text = "{#Emph}<Scoff>",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Names = { "Q_Boss02" }, Count = 1 },
						},
					},
				},
				{ Cue = "/VO/Chronos_1227", Text = "You little...!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Names = { "Q_Boss02" }, Count = 3 },
						},
					},
				},
				{ Cue = "/VO/Chronos_1228", Text = "{#Emph}Again...?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Names = { "Q_Boss02" }, Count = 3 },
						},
					},
				},
				{ Cue = "/VO/Chronos_1230", Text = "Such a night...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpentShrinePointsCache" },
							Comparison = ">=",
							Value = 20,
						},
					},
				},
			},
		},

		FightStartVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				-- PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
				SuccessiveChanceToPlayAll = 0.75,
				ObjectTypes = { "Chronos", "Chronos_TyphonFight" },
				Cooldowns =
				{
					-- { Name = "ChronosFightIntroVO", Time = 10 },
				},
				TriggerCooldowns = { "ChronosSpokeRecently" },

				{ Cue = "/VO/Chronos_1069", Text = "Come forth, Typhon!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1067", Text = "Oh, Typhon...?" },
				{ Cue = "/VO/Chronos_1068", Text = "Oh, Typhon?" },
				{ Cue = "/VO/Chronos_1070", Text = "Typhon, she is here!" },
				{ Cue = "/VO/Chronos_1112", Text = "{#Emph}Giant of Storms!" },
				{ Cue = "/VO/Chronos_1113", Text = "Behold the Father of All Monsters!" },
				{ Cue = "/VO/Chronos_1114", Text = "Come, Father of All Monsters!" },
				{ Cue = "/VO/Chronos_1115", Text = "I wish to introduce my dear old friend!" },
				{ Cue = "/VO/Chronos_1116", Text = "Prepare yourself...!" },
				{ Cue = "/VO/Chronos_1117", Text = "Look who!" },
				{ Cue = "/VO/Chronos_1119", Text = "Without further ado..." },
				{ Cue = "/VO/Chronos_1120", Text = "Foul weather, is it not?" },
				{ Cue = "/VO/Chronos_1121", Text = "You {#Emph}owe {#Prev}me this, Typhon!" },
				{ Cue = "/VO/Chronos_1118", Text = "Please give a warm welcome to... {#Emph}Typhon!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							CountOf =
							{
								"/VO/Chronos_1067",
								"/VO/Chronos_1068",
								"/VO/Chronos_1069",
								"/VO/Chronos_1112",
								"/VO/Chronos_1113",
								"/VO/Chronos_1114",
								"/VO/Chronos_1115",
								"/VO/Chronos_1116",
								"/VO/Chronos_1117",
								"/VO/Chronos_1119",
								"/VO/Chronos_1120",
								"/VO/Chronos_1121",
							},
							Comparison = ">=",
							Value = 8,
						},
					},
				},
				{ Cue = "/VO/Chronos_1122", Text = "{#Emph}Now{#Prev}, monster, exactly as before!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveDeathsInRoom",
							FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
						},
					},
				},
				{ Cue = "/VO/Chronos_1123", Text = "Fight her properly this time, Typhon?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
						},
					},
				},

			},
		},

		DefaultAIData =
		{

		},

		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"ChronosCastOrbit_Assist",
			"ChronosScytheThrow_Assist",
			"ChronosTelescopeSwingRight_Assist",
			"ChronosGrind_Assist",
			"ChronosTeleport_CurseAssist",
		},

		Using = { SpawnObstacle = "CapturePoint", },
	},

	Chronos_EMShadow =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Chronos",
		Portrait = "Portrait_Chronos_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ChronosVoice,
		EmoteOffsetY = -320,
		EmoteOffsetX = 85,
		SpeakerName = "Chronos",
		LoadPackages = { "Chronos", },
		RunHistoryKilledByName = "NPC_Chronos_01",

		AttachedAnimationName = "ChronosShadowDisplacement",

		UseActivatePresentation = false,
		WakeUpDelay = 0.0,

		CannotDieFromDamage = true,
		
		HitInvulnerablePresentationThreadedFunctionName = "ChronosTyphonFightHitPresentation",
		InvulnerableHitFx = "ChronosTeleportFxFront",
		IgnoreInvincibubbleOnHit = true,

		Material = "Organic",
		HealthBarTextId = "Chronos_Full",
		HealthBarOffsetY = -275,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,
		RepulseOnMeleeInvulnerableHit = 150,

		IgnoreTimeSlowEffects = true,

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					IgnoreTimeSlowEffects = false,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
					},
				},
			},
			{
				FunctionName = "CheckElapsedTimeMultiplierIgnores",
			},
		},

		DefaultAIData =
		{

		},

		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"ChronosTelescopeSwingRight_P3",
			"ChronosScytheThrowDouble_P3",
			"ChronosRush_P3",
			"ChronosGrind_P3",
			"ChronosLungeMelee_P3",
			"ChronosShadowExit",
		},
	},
}

-- Global Chronos Lines
GlobalVoiceLines.ChronosInvulnerableVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "SourceProjectile", },
			IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
		},
		OrRequirements =
		{
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.25,
				},
			},
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss02" },
				},
			},
		},
		ChanceToPlay = 0.2,
	},
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 6 },
		{ Name = "ChronosInvulnerableSpeech", Time = 35 },
	},

	{ Cue = "/VO/Chronos_0339", Text = "How frightening." },
	{ Cue = "/VO/Chronos_0340", Text = "{#Emph}Ohh{#Prev}, how fierce." },
	{ Cue = "/VO/Chronos_0341", Text = "Oh dear." },
	{ Cue = "/VO/Chronos_0342", Text = "{#Emph}Oh no...!" },
	{ Cue = "/VO/Chronos_0343", Text = "Shall that be all?" },
	{ Cue = "/VO/Chronos_0344", Text = "{#Emph}Tut-tut...!" },
	{ Cue = "/VO/Chronos_0345", Text = "Do cut it out?" },
	{ Cue = "/VO/Chronos_0346", Text = "That shall not work..." },
	{ Cue = "/VO/Chronos_0347", Text = "Embarrassing..." },
	{ Cue = "/VO/Chronos_0348", Text = "Are you quite done?" },
	{ Cue = "/VO/Chronos_0349", Text = "{#Emph}Uh-uh!" },
	{ Cue = "/VO/Chronos_0350", Text = "Alas..." },
	{ Cue = "/VO/Chronos_0094", Text = "Oh, {#Emph}please..." },
	{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!" },
	{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!" },
	{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
	{ Cue = "/VO/Chronos_1249", Text = "I am not even here!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_1250", Text = "Concern yourself with {#Emph}him!",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_1251", Text = "Leave me {#Emph}be {#Prev}you {#Emph}brat.",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_1252", Text = "I am a {#Emph}mere apparition.",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0014", Text = "I think not.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_Boss01", "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0095", Text = "That shall not work.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_Boss01", "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_Boss01", "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0098", Text = "I can wait...",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_Boss01", "Q_Boss02" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_Boss01", "Q_Boss02" },
			},
		},
	},
}
GlobalVoiceLines.ChronosResistedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.2,
		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "Q_Boss02" },
					},
				},
			},
		},
		Cooldowns =
		{
			{ Name = "ChronosSpokeRecently", Time = 3 },
			{ Name = "ChronosResistReactionSpeech", Time = 40 },
		},

		{ Cue = "/VO/Chronos_0659", Text = "This is my chosen form.", PlayFirst = true },
		{ Cue = "/VO/Chronos_0660", Text = "Useless." },
	},
	{ GlobalVoiceLines = "ChronosInvulnerableVoiceLines" },
}

GlobalVoiceLines.ChronosPreAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ObjectType = "Chronos",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.2,
		},
		ChanceToPlay = 0.2,
	},
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 18 },
	},

	{ Cue = "/VO/Chronos_0453", Text = "Now...!" },
	{ Cue = "/VO/Chronos_0454", Text = "Now then..." },
	{ Cue = "/VO/Chronos_0455", Text = "Perish!" },
	{ Cue = "/VO/Chronos_0457", Text = "Begone!" },
	{ Cue = "/VO/Chronos_0459", Text = "Prepare!" },
	{ Cue = "/VO/Chronos_0460", Text = "Observe!" },
	{ Cue = "/VO/Chronos_0461", Text = "Crumble!" },
	{ Cue = "/VO/Chronos_0462", Text = "Decay!" },
	{ Cue = "/VO/Chronos_0463", Text = "Watch this." },
	{ Cue = "/VO/Chronos_0464", Text = "Watch {#Emph}this!" },
	{ Cue = "/VO/Chronos_0465", Text = "Here!" },
	{ Cue = "/VO/Chronos_0466", Text = "Beware!" },
	{ Cue = "/VO/Chronos_0532", Text = "You..." },
	{ Cue = "/VO/Chronos_0533", Text = "Watch..." },
	{ Cue = "/VO/Chronos_0534", Text = "And now..." },
	{ Cue = "/VO/Chronos_0535", Text = "Now this!" },
	{ Cue = "/VO/Chronos_0536", Text = "Learn your place!" },
	{ Cue = "/VO/Chronos_0537", Text = "Expire!" },
	{ Cue = "/VO/Chronos_0538", Text = "More, then?" },
	{ Cue = "/VO/Chronos_0539", Text = "What now?" },
	{ Cue = "/VO/Chronos_0540", Text = "Here, then!" },
	{ Cue = "/VO/Chronos_0541", Text = "Poor girl..." },
	{ Cue = "/VO/Chronos_0542", Text = "Wretched girl..." },
	{ Cue = "/VO/Chronos_0543", Text = "You gods..." },
	{ Cue = "/VO/Chronos_0544", Text = "Have at you!" },
	{ Cue = "/VO/Chronos_0810", Text = "Run..." },
	-- { Cue = "/VO/Chronos_0811", Text = "Hrn...!" },
	{ Cue = "/VO/Chronos_0812", Text = "Now..." },
	-- { Cue = "/VO/Chronos_0813", Text = "{#Emph}Hyah!" },
	{ Cue = "/VO/Chronos_0814", Text = "Ready...?" },
	{ Cue = "/VO/Chronos_0815", Text = "You..." },
	{ Cue = "/VO/Chronos_0816", Text = "For you!" },
	{ Cue = "/VO/Chronos_0817", Text = "Come on!" },
	{ Cue = "/VO/Chronos_0818", Text = "Perish." },
	{ Cue = "/VO/Chronos_0819", Text = "Perish!" },
	{ Cue = "/VO/Chronos_0820", Text = "Out!" },
	{ Cue = "/VO/Chronos_0821", Text = "Get {#Emph}out!" },
	{ Cue = "/VO/Chronos_0822", Text = "Get out!" },
	{ Cue = "/VO/Chronos_0823", Text = "You dare?" },
	{ Cue = "/VO/Chronos_0824", Text = "Here, {#Emph}witch!" },
	{ Cue = "/VO/Chronos_0825", Text = "Another!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = "<=",
				Value = 0.5,
			},
		}
	},
	{ Cue = "/VO/Chronos_0826", Text = "See here!" },
	{ Cue = "/VO/Chronos_0827", Text = "Stand still!" },
	{ Cue = "/VO/Chronos_0458", Text = "Begone, I say!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0457" },
			},
		},
	},
	{ Cue = "/VO/Chronos_0456", Text = "Behold!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C", },
			},
		},
	},
}

GlobalVoiceLines.ChronosSummonVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	ObjectType = "Chronos",
	SuccessiveChanceToPlay = 0.75,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosSummonSpeech", Time = 75 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0423", Text = "Come, my subjects, spill your blood for me!", PlayFirst = true },
	{ Cue = "/VO/Chronos_0424", Text = "{#Emph}Hellooo{#Prev}, reinforcements?" },
	{ Cue = "/VO/Chronos_0425", Text = "Reinforcements, {#Emph}now?" },
	{ Cue = "/VO/Chronos_0426", Text = "I call upon my subjects, {#Emph}now!" },
	{ Cue = "/VO/Chronos_0427", Text = "Let us invite some guests!" },
	{ Cue = "/VO/Chronos_0428", Text = "Oh, look! Company!" },
	{ Cue = "/VO/Chronos_0429", Text = "Come one, come all!" },
	{ Cue = "/VO/Chronos_0509", Text = "Legions of the Golden Age, come forth!" },
	{ Cue = "/VO/Chronos_0510", Text = "Legions of the Golden Age, answer my call!" },
	{ Cue = "/VO/Chronos_0511", Text = "Come, Legions of the Golden Age!" },
	{ Cue = "/VO/Chronos_0512", Text = "Come, my subjects, prove yourselves to me!" },
	{ Cue = "/VO/Chronos_0513", Text = "Come forth, my subjects!" },
	{ Cue = "/VO/Chronos_0514", Text = "I have strength in numbers, lest you forget!" },
	{ Cue = "/VO/Chronos_0515", Text = "My subjects have been waiting for this!" },
	{ Cue = "/VO/Chronos_0516", Text = "My forces are as numerous as grains of sand!" },
	{ Cue = "/VO/Chronos_0517", Text = "You cannot best my legions single-handedly!" },
	{ Cue = "/VO/Chronos_0518", Text = "Vast are the armies at my beck and call!" },
	{ Cue = "/VO/Chronos_0519", Text = "I have more guests I wish for you to meet!" },
	{ Cue = "/VO/Chronos_0860", Text = "My legions shall be witness to your fall!" },
	{ Cue = "/VO/Chronos_0861", Text = "Do you not wish to meet more of my {#Emph}guests?" },
	{ Cue = "/VO/Chronos_0862", Text = "This chamber can accommodate more {#Emph}guests{#Prev}, I think!" },
	{ Cue = "/VO/Chronos_0863", Text = "It feels so empty here without my legions by my side!" },
	{ Cue = "/VO/Chronos_0864", Text = "I have more subjects here for you to fight!" },
	{ Cue = "/VO/Chronos_0865", Text = "How empty it is here without some guests!" },
	{ Cue = "/VO/Chronos_0866", Text = "Come join us, honored guests, and beg pardon all the dust!" },
	{ Cue = "/VO/Chronos_0867", Text = "Whichever forces are available, to me, right now!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
			},
		},
	},
	{ Cue = "/VO/Chronos_0868", Text = "You make an enemy of all my legions, not just {#Emph}me!" },
	{ Cue = "/VO/Chronos_0869", Text = "So many of my subjects long to face you one to one!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 4,
			},
		},
	},
	{ Cue = "/VO/Chronos_0870", Text = "Oh {#Emph}look{#Prev}, here come more of my subjects now!" },
	{ Cue = "/VO/Chronos_0871", Text = "My legions tend to be more punctual than this!" },
}

GlobalVoiceLines.ChronosChronomancyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Chronos",
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 6 },
		{ Name = "ChronosChronomancySpeech", Time = 45 },
	},

	{ Cue = "/VO/Chronos_0430", Text = "Hold it right there..." },
	{ Cue = "/VO/Chronos_0431", Text = "Hold it." },
	{ Cue = "/VO/Chronos_0432", Text = "Hold it...!" },
	{ Cue = "/VO/Chronos_0433", Text = "Why the rush?" },
	{ Cue = "/VO/Chronos_0434", Text = "Be still." },
	{ Cue = "/VO/Chronos_0435", Text = "Stop." },
	{ Cue = "/VO/Chronos_0436", Text = "Stop, now." },
	{ Cue = "/VO/Chronos_0437", Text = "Stop right there...", PlayFirst = true },
	{ Cue = "/VO/Chronos_0438", Text = "Freeze." },
	{ Cue = "/VO/Chronos_0439", Text = "Freeze!" },
	{ Cue = "/VO/Chronos_0440", Text = "A moment, please?" },
	{ Cue = "/VO/Chronos_0441", Text = "Pardon a moment." },
	{ Cue = "/VO/Chronos_0520", Text = "Halt." },
	{ Cue = "/VO/Chronos_0521", Text = "Got you." },
	{ Cue = "/VO/Chronos_0522", Text = "Trapped." },
	{ Cue = "/VO/Chronos_0523", Text = "Caught." },
	{ Cue = "/VO/Chronos_0524", Text = "Caught out." },
	{ Cue = "/VO/Chronos_0525", Text = "Caught you." },
	{ Cue = "/VO/Chronos_0526", Text = "I have you." },
	{ Cue = "/VO/Chronos_0527", Text = "{#Emph}Heh." },
	{ Cue = "/VO/Chronos_0528", Text = "{#Emph}Hah!" },
	{ Cue = "/VO/Chronos_0529", Text = "Slow down." },
	{ Cue = "/VO/Chronos_0530", Text = "Time out." },
	{ Cue = "/VO/Chronos_0531", Text = "Time out...!" },
	{ Cue = "/VO/Chronos_0828", Text = "Alas." },
	{ Cue = "/VO/Chronos_0829", Text = "Stuck." },
	{ Cue = "/VO/Chronos_0830", Text = "Stuck!" },
	{ Cue = "/VO/Chronos_0831", Text = "Pardon." },
	{ Cue = "/VO/Chronos_0832", Text = "Hold." },
	{ Cue = "/VO/Chronos_0833", Text = "Hold still!" },
	{ Cue = "/VO/Chronos_0834", Text = "Stop, I say." },
	{ Cue = "/VO/Chronos_0835", Text = "Infuriating, no?" },
	{ Cue = "/VO/Chronos_0836", Text = "Careful now." },
	{ Cue = "/VO/Chronos_0837", Text = "Nice pose." },
}

GlobalVoiceLines.ChronosUltimateVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Chronos",
	Cooldowns =
	{
		{ Name = "ChronosSpokeUltimateRecently", Time = 120 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0442", Text = "Your time is {#Emph}up!" },
	{ Cue = "/VO/Chronos_0443", Text = "The end is at hand!" },
	{ Cue = "/VO/Chronos_0444", Text = "I have {#Emph}had {#Prev}it with you!" },
	{ Cue = "/VO/Chronos_0445", Text = "This audience is {#Emph}over!" },
	{ Cue = "/VO/Chronos_0446", Text = "That {#Emph}does {#Prev}it!" },
	{ Cue = "/VO/Chronos_0447", Text = "Damnable girl!" },
	{ Cue = "/VO/Chronos_0448", Text = "{#Emph}All {#Prev}comes to an {#Emph}end!" },
	{ Cue = "/VO/Chronos_0449", Text = "Your final moments!" },
	{ Cue = "/VO/Chronos_0450", Text = "Enough is {#Emph}enough!" },
	{ Cue = "/VO/Chronos_0451", Text = "{#Emph}Granddaughter!!", PlayFirst = true },
	{ Cue = "/VO/Chronos_0452", Text = "Begone now from my {#Emph}sight!" },
	{ Cue = "/VO/Chronos_0838", Text = "I grow weary of your antics, girl!" },
	{ Cue = "/VO/Chronos_0839", Text = "I shall abide no disrespect from you!" },
	{ Cue = "/VO/Chronos_0840", Text = "You have {#Emph}everything {#Prev}to fear from {#Emph}me!" },
	{ Cue = "/VO/Chronos_0841", Text = "Why do you not stop?",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
			},
		}
	},
	{ Cue = "/VO/Chronos_0842", Text = "My patience has its limits!" },
	{ Cue = "/VO/Chronos_0843", Text = "Do you expect a show of mercy, {#Emph}here?" },
}

GlobalVoiceLines.ChronosSpellResistVoiceLines =
{
	-- while immune to TimeSlow
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "SpellTimeSlowTrait" },
			},
			{
				PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
		},
		-- only the first time
		{
			PlayOnce = true,
			PlayOnceContext = "TimeSlowFailedVoiceLines",
			PreLineWait = 0.15,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_0714", Text = "What the?" },
		},
		-- immunity to TimeSlow
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.35,
			PreLineWait = 0.2,
			ObjectType = "Chronos",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.15,
				},
			},
			Cooldowns =
			{
				{ Name = "ChronosSpellReactionSpeech", Time = 50 },
			},	
			TriggerCooldowns = { "ChronosSpokeRecently" },

			{ Cue = "/VO/Chronos_0631", Text = "You have no power over Time whilst here!" },
			{ Cue = "/VO/Chronos_0632", Text = "{#Emph}I {#Prev}control the flow of Time, not {#Emph}you!" },
			{ Cue = "/VO/Chronos_0633", Text = "No you shall not." },
			{ Cue = "/VO/Chronos_0634", Text = "How quaint!" },
			{ Cue = "/VO/Chronos_0635", Text = "Infantile!" },
			{ Cue = "/VO/Chronos_0636", Text = "You have no power over Time!" },
			{ Cue = "/VO/Chronos_0637", Text = "Time shall not stop for {#Emph}you." },
			{ Cue = "/VO/Chronos_0638", Text = "Again with these attempts?" },
		},
	},
	-- no longer immune to TimeSlow
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.75,
		ObjectType = "Chronos",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "SpellTimeSlowTrait" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeSlowChronosFight" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
		},
		Cooldowns =
		{
			{ Name = "ChronosSpellReactionSpeech", Time = 50 },
		},	
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_0639", Text = "What just... {#Emph}how?!", PlayFirst = true, PlayOnce = true, PlayOnceContext = "ChronosTimeSlowFirstReactionVO" },
		{ Cue = "/VO/Chronos_0640", Text = "Impossible...!" },
		{ Cue = "/VO/Chronos_0641", Text = "You witch!" },
		{ Cue = "/VO/Chronos_0642", Text = "Manipulative witch..." },
		{ Cue = "/VO/Chronos_0643", Text = "Stop doing that!" },
		{ Cue = "/VO/Chronos_0644", Text = "How {#Emph}dare {#Prev}you..." },
		{ Cue = "/VO/Chronos_0645", Text = "An interesting trick..." },
		{ Cue = "/VO/Chronos_0646", Text = "Why, you..." },

		{ Cue = "/VO/Chronos_0597", Text = "{#Emph}Rnngghh..." },
		{ Cue = "/VO/Chronos_0598", Text = "{#Emph}How...?" },
		{ Cue = "/VO/Chronos_0599", Text = "Such power..." },
		{ Cue = "/VO/Chronos_0374", Text = "Mannerless child..." },
		{ Cue = "/VO/Chronos_0375", Text = "Contemptuous child..." },
		{ Cue = "/VO/Chronos_0376", Text = "Meddlesome brat!" },
		{ Cue = "/VO/Chronos_0377", Text = "Scurrilous brat..." },
		{ Cue = "/VO/Chronos_0378", Text = "Unrepentant scamp..." },
		{ Cue = "/VO/Chronos_0379", Text = "You little scamp..." },
		{ Cue = "/VO/Chronos_0380", Text = "You rascal..." },
		{ Cue = "/VO/Chronos_0381", Text = "Incorrigible..." },
		{ Cue = "/VO/Chronos_0384", Text = "Bothersome little..." },
		{ Cue = "/VO/Chronos_0388", Text = "{#Emph}Hrn..." },
		{ Cue = "/VO/Chronos_0391", Text = "How...?" },
		{ Cue = "/VO/Chronos_0392", Text = "But..." },
		{ Cue = "/VO/Chronos_0395", Text = "You would dare?" },
		{ Cue = "/VO/Chronos_0397", Text = "Absurd..." },
		{ Cue = "/VO/Chronos_0398", Text = "Preposterous..." },
		{ Cue = "/VO/Chronos_0400", Text = "Ridiculous..." },
	},
}
GlobalVoiceLines.ChronosGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Chronos",
	SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosSpokeRecently", Time = 16 },
	},

	{ Cue = "/VO/Chronos_0687", Text = "Oh you {#Emph}found {#Prev}something!" },
	{ Cue = "/VO/Chronos_0688", Text = "A common thief!" },
	{ Cue = "/VO/Chronos_0689", Text = "You put that {#Emph}back." },
	{ Cue = "/VO/Chronos_0690", Text = "That is {#Emph}not {#Prev}yours." },
	{ Cue = "/VO/Chronos_0954", Text = "That was {#Emph}mine." },
	{ Cue = "/VO/Chronos_0955", Text = "Return that at once!" },
	{ Cue = "/VO/Chronos_0956", Text = "You little thief." },
	{ Cue = "/VO/Chronos_0957", Text = "My property!" },
}

GlobalVoiceLines.ChronosTimerOnReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlayAll = 0.1,
	ObjectType = "Chronos",
	Queue = "Interrupt",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosTimerOnReactionSpeech", Time = 30 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0647", Text = "Decided to keep {#Emph}Time?", PlayFirst = true },
	{ Cue = "/VO/Chronos_0648", Text = "Count your remaining moments." },
	{ Cue = "/VO/Chronos_0649", Text = "How quickly this shall end." },
	{ Cue = "/VO/Chronos_0650", Text = "I take {#Emph}your {#Prev}measure, not you mine!" },
	{ Cue = "/VO/Chronos_0560", Text = "Am I supposed to be {#Emph}impressed?" },
}
GlobalVoiceLines.ChronosTimerOffReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlayAll = 0.1,
	ObjectType = "Chronos",
	Queue = "Interrupt",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ChronosTimerOffReactionSpeech", Time = 30 },
	},
	TriggerCooldowns = { "ChronosSpokeRecently" },

	{ Cue = "/VO/Chronos_0651", Text = "Yet Time still slips away." },
	{ Cue = "/VO/Chronos_0652", Text = "Afraid of the inevitable?", PlayFirst = true },
	{ Cue = "/VO/Chronos_0558", Text = "Surely you jest." },
	{ Cue = "/VO/Chronos_0559", Text = "Now why would you do {#Emph}that?", PlayFirst = true },
	{ Cue = "/VO/Chronos_0561", Text = "Time slips away from you." },
}

GlobalVoiceLines.SkipZeusVoiceLines =
{
	Queue = "Interrupt",
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		TriggerCooldowns = { "ChronosSpokeRecently" },
		SkipAnim = true,

		{ Cue = "/VO/Chronos_1124", Text = "{#Emph}Hahaha{#Prev}, oh were you perhaps expecting someone else, my girl?", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Chronos_1137", Text = "If you think {#Emph}this {#Prev}is bothersome, just wait till you see my next trick!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1124" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1125", Text = "Alas the weather has been causing quite a few delays!" },
		{ Cue = "/VO/Chronos_1126", Text = "My dear son Zeus is presently preoccupied with even graver matters than your own!" },
		{ Cue = "/VO/Chronos_1127", Text = "If only my son Zeus and all his ilk could see you now, my girl!" },
		{ Cue = "/VO/Chronos_1128", Text = "The gods themselves have abandoned you, granddaughter...!" },
		{ Cue = "/VO/Chronos_1130", Text = "Not quite so powerful without your Lord Uncle's lightning bolt, are you?" },
		{ Cue = "/VO/Chronos_1131", Text = "Where is that good-for-nothing son of mine when you need him, {#Emph}hm?" },
		{ Cue = "/VO/Chronos_1132", Text = "{#Emph}Oh my{#Prev}, the view from up here truly is magnificent, my girl! " },
		{ Cue = "/VO/Chronos_1133", Text = "Such a shame that your Lord Uncle could not be here to join us!" },
		{ Cue = "/VO/Chronos_1134", Text = "Why {#Emph}look at me{#Prev}, I dilly-dally whilst the Father of All Monsters does the work!" },
		{ Cue = "/VO/Chronos_1135", Text = "{#Emph}Dum-dum-dum-dummm, dum-dum-dum-dummmm...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					CountOf =
					{
						"/VO/Chronos_1124",
						"/VO/Chronos_1126",
						"/VO/Chronos_1127",
						"/VO/Chronos_1128",
						"/VO/Chronos_1129",
						"/VO/Chronos_1130",
						"/VO/Chronos_1131",
						"/VO/Chronos_1132",
						"/VO/Chronos_1133",
						"/VO/Chronos_1137",
					},
					Comparison = ">=",
					Value = 8,
				},
			},
		},
		{ Cue = "/VO/Chronos_1136", Text = "{#Emph}Hmm-hmm-hmm-hmmm, hmm-hmm-hmm-hmmmm....",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					CountOf =
					{
						"/VO/Chronos_1124",
						"/VO/Chronos_1126",
						"/VO/Chronos_1127",
						"/VO/Chronos_1128",
						"/VO/Chronos_1129",
						"/VO/Chronos_1130",
						"/VO/Chronos_1131",
						"/VO/Chronos_1132",
						"/VO/Chronos_1133",
						"/VO/Chronos_1137",
					},
					Comparison = ">=",
					Value = 8,
				},
			},
		},
	},
	{
		{ Cue = "/VO/Chronos_1129", Text = "...or perhaps merely running late!",
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Chronos_1128" },
				},
			},
		},
	},
}

GlobalVoiceLines.PreBabalityVoiceLines =
{
	Queue = "Interrupt",
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Chronos_1138", Text = "Not so fast.", PlayFirst = true },
		{ Cue = "/VO/Chronos_1139", Text = "No! Not yet." },
		{ Cue = "/VO/Chronos_1140", Text = "I think not." },
		{ Cue = "/VO/Chronos_1141", Text = "We're not done!" },
		{ Cue = "/VO/Chronos_1142", Text = "Get back here, monster!" },
		{ Cue = "/VO/Chronos_1143", Text = "Oh {#Emph}come on{#Prev}, Typhon...!" },
		{ Cue = "/VO/Chronos_1144", Text = "Come {#Emph}on{#Prev}, Typhon...!" },
		{ Cue = "/VO/Chronos_1145", Text = "Get back {#Emph}up{#Prev}, monster!" },
		{ Cue = "/VO/Chronos_1146", Text = "Oh {#Emph}get up{#Prev}, Typhon..." },
		{ Cue = "/VO/Chronos_1147", Text = "Some monster {#Emph}he {#Prev}is..." },
		{ Cue = "/VO/Chronos_1148", Text = "{#Emph}Hrr...",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 3 },
				},
			},
		},
		{ Cue = "/VO/Chronos_1149", Text = "{#Emph}Augh...",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 3 },
				},
			},
		},
		{ Cue = "/VO/Chronos_1150", Text = "{#Emph}<Laughter>",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
				},
			},
		},
		{ Cue = "/VO/Chronos_1151", Text = "{#Emph}<Laughter>",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
				},
			},
		},
	},
}
GlobalVoiceLines.BabalityVoiceLines =
{
	Queue = "Interrupt",
	--[[
	{
		PreLineWait = 0.25,
		PlayOnce = true,
		PlayOnceContext = "BabalityIntroVO",
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Chronos_1152", Text = "And as for you...", PlayFirst = true },
	},
	]]--
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_1153", Text = "{#Emph}Turn back!", PlayFirst = true, },
		{ Cue = "/VO/Chronos_1154", Text = "{#Emph}Turn back!" },
		{ Cue = "/VO/Chronos_1155", Text = "{#Emph}Turn back{#Prev}, I say!" },
		{ Cue = "/VO/Chronos_1156", Text = "{#Emph}Turn back...!" },
		{ Cue = "/VO/Chronos_1157", Text = "{#Emph}Turn back." },
		{ Cue = "/VO/Chronos_1158", Text = "{#Emph}Turn back...?" },
		{ Cue = "/VO/Chronos_1159", Text = "Just, {#Emph}turn back...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
				},
			},
		},
		{ Cue = "/VO/Chronos_1160", Text = "Why won't you {#Emph}turn back?!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 3 },
				},
			},
		},
	},
	{
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.5,

		{ Cue = "/VO/MelinoeField_3787", Text = "{#Emph}Aaah!" },
	},
}
GlobalVoiceLines.PostBabalityVoiceLines =
{
	Queue = "Interrupt",
	{
		PreLineWait = 0.63,
		PlayOnce = true,
		PlayOnceContext = "FirstBabalityVO",
		UsePlayerSource = true,

		{ Cue = "/VO/MelinoeField_3789", Text = "You'll pay for this, Titan! I swear it!" },
	},
	{
		PreLineWait = 1.35,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_1173", Text = "Why, is she not {#Emph}adorable{#Prev}, Typhon? Look at her little {#Emph}feet {#Prev}as she goes running all about!", PlayFirst = true },
		{ Cue = "/VO/Chronos_1174", Text = "You make attempts to break my spell! How very {#Emph}clever{#Prev}, especially for one so very {#Emph}young!" },
		{ Cue = "/VO/Chronos_1175", Text = "{#Emph}Ah{#Prev}, the carefree joys of youth! Do you not miss those bygone times, my girl?" },
		{ Cue = "/VO/Chronos_1176", Text = "Now do go {#Emph}easy {#Prev}on her, Typhon! She is but a poor, {#Emph}defenseless {#Prev}little girl." },
		{ Cue = "/VO/Chronos_1177", Text = "Run, little girl, or try! But there is nowhere left for you to go, and these are nightmares that shall {#Emph}never {#Prev}cease." },
		{ Cue = "/VO/Chronos_1179", Text = "Now, Typhon, if you cannot even stop a helpless little girl, then I do not know what to tell you..." },
		{ Cue = "/VO/Chronos_1180", Text = "{#Emph}Well! {#Prev}If the Father of All Monsters and I cannot even stop this darling little child, then perhaps we are unfit to rule!" },
		{ Cue = "/VO/Chronos_1181", Text = "Cease with all your struggling, already! What can you possibly be hoping to achieve?!" },
		{ Cue = "/VO/Chronos_1182", Text = "Though it is terribly uncouth to take one's anger out on little children, you have left me with no other choice!" },
		{ Cue = "/VO/Chronos_1184", Text = "A fitting form for one as small-minded as you! Although barely a {#Emph}snack {#Prev}for Typhon here!" },
		{ Cue = "/VO/Chronos_1183", Text = "Would you look at us, Typhon? Having to beat up on little girls! How mortifying...!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					CountOf =
					{
						"/VO/Chronos_1173",
						"/VO/Chronos_1174",
						"/VO/Chronos_1175",
						"/VO/Chronos_1176",
						"/VO/Chronos_1177",
						"/VO/Chronos_1178",
						"/VO/Chronos_1179",
						"/VO/Chronos_1180",
						"/VO/Chronos_1181",
						"/VO/Chronos_1182",
						"/VO/Chronos_1183",
					},
					Comparison = ">=",
					Value = 8,
				},
			},
		},
		{ Cue = "/VO/Chronos_1178", Text = "Run, little girl! Perhaps evade from time to time as well! That is all you can do!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1177" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1161", Text = "You are nothing but a pathetic child. May you always remember that, should you somehow withstand what shall imminently transpire.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1163", Text = "Always remember how small and frightened you once must have felt. Inside, you are {#Emph}still {#Prev}that same old wretched girl.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1164", Text = "There is no way to turn back Time. But I can make exceptions here and there... because I {#Emph}make the blasted rules!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1165", Text = "Let me remind you just how small and weak you truly are. We all grow older, yes, but none of us shall ever change in our entirety.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1166", Text = "To think if I was but a bit more careful then I could have taken {#Emph}you {#Prev}along with all the rest of your dear family; and saved myself the trouble {#Emph}here!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1167", Text = "Stubborn little {#Emph}brat! That {#Prev}is what you are. Look at yourself, in all your youthful frailty. This is all you {#Emph}ever {#Prev}were.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1168", Text = "Know your insignificance, child! You may pitter-patter all about now to your heart's content. I certainly care {#Emph}not!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1169", Text = "Alas that you were raised without appropriate parental guidance for you lack even the most basic manners, even for a rotten little girl.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1170", Text = "You clearly never learned to listen to your elders, girl, so {#Emph}fine! {#Prev}I am quite finished with attempts at {#Emph}reasoning {#Prev}with you.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1171", Text = "Your {#Emph}mother {#Prev}would have been so very {#Emph}proud {#Prev}of the delightful little girl you once were! {#Emph}Ah {#Prev}well.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
		{ Cue = "/VO/Chronos_1172", Text = "{#Emph}Poor little girl{#Prev}, are you going to {#Emph}cry? {#Prev}For all the {#Emph}hardship {#Prev}which you have endured?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = GameData.ChronosFinalPhaseTauntEvents,
				},
			}
		},
	},

}

GlobalVoiceLines.ClearedBabalityVoiceLines =
{
	Queue = "Interrupt",
	{
		UsePlayerSource = true,
		RandomRemaining = true,

		{ Cue = "/VO/MelinoeField_3800", Text = "Let me {#Emph}go!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3801", Text = "All right that {#Emph}does it!" },
		{ Cue = "/VO/MelinoeField_3802", Text = "...{#Emph}My {#Prev}turn now!" },
		{ Cue = "/VO/MelinoeField_3803", Text = "I'll make you {#Emph}pay!" },
		{ Cue = "/VO/MelinoeField_3804", Text = "{#Emph}Unacceptable!" },
		{ Cue = "/VO/MelinoeField_3805", Text = "{#Emph}Enough!!" },
	},
	{
		PreLineWait = 0.85,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_1185", Text = "You broke free...", PlayFirst = true },
		{ Cue = "/VO/Chronos_1186", Text = "You've... grown..." },
		{ Cue = "/VO/Chronos_1187", Text = "My spell...!", PlayFirst = true },
		{ Cue = "/VO/Chronos_1188", Text = "How did you...?", PlayFirst = true },
		{ Cue = "/VO/Chronos_1189", Text = "How is this—" },
		{ Cue = "/VO/Chronos_1190", Text = "This cannot—" },
		{ Cue = "/VO/Chronos_1191", Text = "Oh, blast...", PlayFirst = true },
		{ Cue = "/VO/Chronos_1193", Text = "Back to your old self?" },
		{ Cue = "/VO/Chronos_1194", Text = "They grow up so fast..." },
		{ Cue = "/VO/Chronos_1192", Text = "Not again...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Names = { "Q_Boss02" }, Count = 2 },
				},
			},
		},
	},
}

GlobalVoiceLines.ChronosRunClearVoiceLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		PreLineWait = 1.4,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,
		SuccessiveChanceToPlayAll = 0.5,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss02" },
			},
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 4,
			},
		},

		{ Cue = "/VO/Chronos_1203", Text = "All right, all right, you {#Emph}win{#Prev}, you little...", PlayFirst = true },
		{ Cue = "/VO/Chronos_1195", Text = "Typhon! Wait! {#Emph}Augh..." },
		{ Cue = "/VO/Chronos_1196", Text = "This is an {#Emph}outrage! Augh!" },
		{ Cue = "/VO/Chronos_1197", Text = "He had a {#Emph}family{#Prev}, you monster!" },
		{ Cue = "/VO/Chronos_1198", Text = "...Would you look at the Time...?" },
		{ Cue = "/VO/Chronos_1199", Text = "...Well, I ought be getting back..." },
		{ Cue = "/VO/Chronos_1200", Text = "The blasted Fates must be abetting you!" },
		{ Cue = "/VO/Chronos_1201", Text = "So much for the Father of All Monsters then!" },
		{ Cue = "/VO/Chronos_1202", Text = "Well this did not exactly go as planned...!" },
		{ Cue = "/VO/Chronos_1204", Text = "All right, you won again, {#Emph}happy?!" },
		{ Cue = "/VO/Chronos_1205", Text = "Are you quite {#Emph}pleased {#Prev}with yourself now?!" },
		{ Cue = "/VO/Chronos_1206", Text = "Well glory unto you! {#Emph}Argh!" },
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.Chronos )