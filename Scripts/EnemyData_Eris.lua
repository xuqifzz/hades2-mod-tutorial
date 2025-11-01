UnitSetData.Eris =
{
	Eris =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_Eris_Default_01",
		Groups = { "NPCs", "GroundEnemies" },
		SubtitleColor = Color.ErisVoice,
		SpeakerName = "Eris",
		SpeakingStatusAnimation = "StatusIconSpeaking_Hero",
		FieldSpeakerName = "ErisField",
		LoadPackages = { "Eris", },
		RunHistoryKilledByName = "NPC_Eris_01",
		SpeechParams =
		{
			Radius = 1,
		},
		MaxHealth = 16000,
		AISetupDelay = 0.75,
		EmoteOffsetX = 0,
		EmoteOffsetY = -205,

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		StopAnimationsOnHeroKill =
		{
			"ErisPowerUpFx",
			"ErisPowerUpFxA",
			"ErisPowerUpFxB",
			"ErisPowerUpFxB",
			"ErisPowerUpFxC",
			"ErisPowerUpFxD",
			"ErisPowerUpFxE",
			"ErisPowerUpFxF",
			"ErisPowerUpFxG",
			"ErisPowerUpFxH",
			"ErisPowerUpFxDarkA",
			"ErisPowerUpFxDarkB",
			"ErisPowerUpFxDarkC",
			"ErisPowerUpFxDarkD",
			"ErisPowerUpFxDarkE",
			"ErisPowerUpFxDarkF",
			"ErisPowerUpFxDarkG",
			"ErisPowerUpFxDarkH",
			"ErisPowerUpStart",
		},

		SpeechCooldownTime = 9,
		SelfBuffDamage = 100, -- used for text

		WipeEnemyTypesOnDeath = { "GunBombUnit" },

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
		DeathFx = "ErisDeathFx",
		DeathSound = "/SFX/Enemy Sounds/Hades/HadesSpearEmerge",
		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarTextId = "Eris_Full",
		HealthBarOffsetY = -275,
		AltHealthBarTextIds =
		{
			{ TextId = "Eris_AltFight01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},

		--IgnoreInvincibubbleOnHit = true,
		InvulnerableFx = "Invincibubble",
		TextLinesUseWeaponIdle = true,

		BurningHitReactionWeapon = "ErisRelocate_Up",
		DefaultAIData =
		{
			--DashIfOverDistance = 600,
			DashWeapon = "ErisDash",

			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
		},
		WeaponOptions = { "ErisSpray", "ErisGrenadeCluster01", "ErisDash", "ErisFlyUp", "ErisSummonSelector" },
		--WeaponOptions = { "ErisSummonSelector3", "ErisSpray" },

		BossDifficultyShrineRequiredCount = 2,

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					AISetupDelay = 0.5,
					MaxHealth = 18500,
					OnDamagedEvents =
					{
						{
							FunctionName = "CheckComboBreakerDamageInWindow",
							Args =
							{
								Threshold = 800,
								Window = 1.0,
								ComboBreakerCooldown = 15.0,
								ForcedWeaponInterrupt = "ErisBackDashCombo",
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
							Value = 2,
						},
					},
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAnimation = "Enemy_Eris_HubIdle",
					ThingProperties =
					{
						GrannyModel = "Eris_Lucifer_Mesh"
					},
					OverwriteSourceKeys =
					{
						PortraitSwapMap =
						{
							Portrait_Eris_Default_01 = "Portrait_Eris_Default_02",
							Portrait_Eris_FiredUp_01 = "Portrait_Eris_FiredUp_02",
							Portrait_Eris_Unsure_01 = "Portrait_Eris_Unsure_02",
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
							Value = 2,
						},
					},
				}
			}
		},

		PreBossAISetupFunctionName = "GenericPresentation",
		PreBossAISetupFunctionArgs = { SetAnimation = "Enemy_Eris_Idle" },
		AIEndHealthThreshold = 0.68,
		AIStages =
		{
			-- 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					UnequipAllWeapons = true,
					WaitDuration = 0.5,
					EquipWeapons =
					{
						"ErisLaserSweepLeft",
						"ErisLaserSweepRight",
						"ErisLaserStrafeLeft",
						"ErisLaserStrafeRight",
						"ErisDashLucifer",
						"ErisGrenadeLucifer",
						"ErisBombClear",
						"ErisFlyUp",
						"ErisWindBuffet",
						"ErisBackDashLucifer"
					},
					AIData =
					{
						AIEndHealthThreshold = 0.68,
						ForcedNextWeapon = "ErisBackDashCombo",
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.68,
				},
			},
			-- 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					WaitDuration = 0.5,
					EquipWeapons =
					{
						"ErisLaserSweepLeft",
						"ErisLaserSweepRight",
						"ErisLaserStrafeLeft",
						"ErisLaserStrafeRight",
						"ErisGrenadeLucifer",
						"ErisDashLucifer",
						"ErisBombClear",
						"ErisFlyUp",
						"ErisWindBuffet",
						"ErisBackDashLucifer"
					},
					FireWeapon = "ErisGrenadeLuciferCluster01",
					AIDataOverrides =
					{
						PreferredSpawnPointGroup = "SpawnPointsPhase2"
					},
					ThreadedEvents =
					{
						{
							FunctionName = "ErisOilTransition",
							Args =
							{
								GroupName = "Oil2",
								Delay = 3.0,
							},
						},
					},
				},
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
							Delay = 4.0,
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.36,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisSpreadFire", "ErisGrenadeCluster02", "ErisDash", "ErisFlyUp", "ErisSummonSelector" },
			},
			-- 3
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EMStageDataOverrides =
				{
					WaitDuration = 0.5,
					EquipWeapons =
					{
						"ErisLaserSweepLeft2",
						"ErisLaserSweepRight2",
						"ErisLaserStrafeLeft2",
						"ErisLaserStrafeRight2",
						"ErisRelocateStrike",
						"ErisGrenadeLucifer",
						"ErisDashLucifer",
						"ErisBombClear",
						"ErisFlyUp",
						"ErisWindBuffet",
						"ErisBackDashLucifer"
					},
					FireWeapon = "ErisGrenadeLuciferCluster02",
					AIDataOverrides =
					{
						PreferredSpawnPointGroup = "SpawnPointsPhase3"
					},
					ThreadedEvents =
					{
						{
							FunctionName = "ErisOilTransition",
							Args =
							{
								GroupName = "Oil3",
								Delay = 3.0,
							},
						},
					},
				},
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
							Delay = 4.0,
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
			-- 4
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				FireWeapon = "ErisGrenadeSelfBuffFinal",
				ClearEffects = true,
				ThreadedEvents =
				{
					{
						FunctionName = "ErisOilTransition",
						Args =
						{
							GroupName = "Oil4",
							Delay = 4.0,
						},
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				UnequipAllWeapons = true,
				EquipWeapons = { "ErisRelocateStrike", "ErisFlyUp", "ErisSummonSelector2", "ErisSnipe3" },
				EMStageDataOverrides =
				{
					WaitDuration = 0.5,
					FireWeapon = "ErisGrenadeLuciferCluster03",
					EquipWeapons =
					{
						"ErisRelocateStrike",
						"ErisFlyUp_P4",
						"ErisBackDashLucifer",
					},
					AIDataOverrides =
					{
						PreferredSpawnPointGroup = "SpawnPointsPhase4"
					},
					DataOverrides =
					{
						BurningHitReactionWeapon = "ErisRelocate_Up_P4",
					},
					ThreadedEvents =
					{
						{
							FunctionName = "ErisOilTransition",
							Args =
							{
								GroupName = "Oil4",
								Delay = 3.0,
							},
						},
					},
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
				{ Name = "ErisSpokeRecently", Time = 12 },
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
					{ Name = "ErisSpokeRecently", Time = 6 },
					{ Name = "ErisLastStandReactionSpeech", Time = 30 },
				},

				{ Cue = "/VO/ErisField_0100", Text = "Still going, {#Emph}huh?" },
				{ Cue = "/VO/ErisField_0101", Text = "Give {#Emph}up!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0102", Text = "Oh come {#Emph}on!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0103", Text = "Just {#Emph}die!" },
				{ Cue = "/VO/ErisField_0104", Text = "Again?" },
				{ Cue = "/VO/ErisField_0105", Text = "Aw, {#Emph}really?", PlayFirst = true },
				{ Cue = "/VO/ErisField_0342", Text = "Last {#Emph}chaaance!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0707", "/VO/MelinoeField_0709", "/VO/MelinoeField_0710", "/VO/MelinoeField_0711", "/VO/MelinoeField_0713", "/VO/MelinoeField_0714", "/VO/MelinoeField_0715", "/VO/MelinoeField_0716" },
						},
					},
				},
				{ Cue = "/VO/ErisField_0343", Text = "{#Emph}No more mistakes!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0707" },
						},
					},
				},
				{ Cue = "/VO/ErisField_0344", Text = "{#Emph}I'll make this count!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0712" },
						},
					},
				},
				-- { Cue = "/VO/ErisField_0345", Text = "{#Emph}I still can fight...!" },
			},
		},
		BlockDeathReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 10 },
				},

				{ Cue = "/VO/ErisField_0433", Text = "{#Emph}Moros...!" },
				{ Cue = "/VO/ErisField_0434", Text = "Cheater!" },
				{ Cue = "/VO/ErisField_0435", Text = "That stupid Pin!" },
				{ Cue = "/VO/ErisField_0436", Text = "I {#Emph}had {#Prev}you!" },
			},
		},
		ShotsDestroyedReactionVoiceLines =
		{
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				SuccessiveChanceToPlayAll = 0.05,
				GameStateRequirements =
				{
					ChanceToPlay = 0.1,
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 10 },
				},
				{ Cue = "/VO/ErisField_0431", Text = "You're burning up my shots!",
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "BlockingProjectileName", },
							IsAny = { "HestiaSprintDefense" },
						},
					}
				},
				{ Cue = "/VO/ErisField_0432", Text = "My shots aren't getting through?!", PlayFirst = true },
			},
		},

		InvulnerableVoiceLines =
		{
			{ GlobalVoiceLines = "ErisInvulnerableVoiceLines" },
		},
		ResistedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.1,
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "ErisSpokeRecently", Time = 10 },
			},

			{ Cue = "/VO/ErisField_0301", Text = "Nuh-{#Emph}uh!" },
			{ Cue = "/VO/ErisField_0302", Text = "I'll never change!", PlayFirst = true },
		},

		OnHitVoiceLinesQueueDelay = 0.35,
		OnHitVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "ErisSuitHitReactionSpeech",
				RandomRemaining = true,
                GameStateRequirements =
                {
                    {
                        PathFromArgs = true,
                        Path = { "SourceProjectile", },
                        IsAny = {
                            "ProjectileSuitCharged",
                            "ProjectileSuitSplit",
                            "ProjectileSuitSplit2",
                            "ProjectileSuitRangedGuided",
                            "ProjectileSuitRangedUnguided",
                            "ProjectileSuitRangedCharged",
                            "ProjectileSuitRangedChargedUnguided",
                            "ProjectileSuitRangedGuidedSplit",
                            "ProjectileSuitRangedChargedSplit",
                            "NyxSprintBlast",
                        },
                    },
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/ErisField_0160", Text = "What in the?!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0161", Text = "{#Emph}Hey{#Prev}, what {#Emph}gives?" },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
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
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0426", Text = "I {#Emph}hate {#Prev}frogs!" },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
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
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0319", Text = "I {#Emph}hate {#Prev}cats!" },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
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
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0320", Text = "I {#Emph}hate {#Prev}birds!" },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
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
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0321", Text = "I {#Emph}hate {#Prev}dogs!" },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
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
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0424", Text = "I {#Emph}hate {#Prev}polecats!" },
			},
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
				{ Name = "ErisSpokeRecently", Time = 16 },
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
				{ Cue = "/VO/ErisField_0346", Text = "...Return to shadow... now...?", PreLineWait = 1.3 },
				{ Cue = "/VO/ErisField_0347", Text = "But I don't wanna go, I just {#Emph}got {#Prev}here!" },
				{ Cue = "/VO/ErisField_0348", Text = "Can't drag me back to hell without a fight!" },
				{ Cue = "/VO/ErisField_0349", Text = "I always get the last laugh, babe! {#Emph}Hahaha-oww!" },
				{ Cue = "/VO/ErisField_0479", Text = "{#Emph}Ow ow ow ow ow ow OW!" },
				{ Cue = "/VO/ErisField_0480", Text = "{#Emph}I'm... just... gonna... fly... back!" },
				{ Cue = "/VO/ErisField_0484", Text = "{#Emph}All right{#Prev}, all right, I'm going. {#Emph}Bye!" },
				{ Cue = "/VO/ErisField_0481", Text = "{#Emph}Augh! {#Prev}Same time again tomorrow, babe?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "PrevRun", "EnemyKills", "Eris" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" }
						},
					},
				},
				{ Cue = "/VO/ErisField_0482", Text = "{#Emph}Ow! {#Prev}How about giving me a {#Emph}chance {#Prev}next time?",
					PlayFirst = true,
					GameStateRequirements =
					{
						OrRequirements =
						{
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris01" }
								},
								{
									PathFalse = { "CurrentRun", "EncounterClearStats", "BossEris01", "TookDamage" }
								},
							},
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris02" }
								},
								{
									PathFalse = { "CurrentRun", "EncounterClearStats", "BossEris02", "TookDamage" }
								},
							},
						},
					}
				},
				{ Cue = "/VO/ErisField_0483", Text = "{#Emph}Ungh{#Prev}, why does this always {#Emph}happen {#Prev}to me?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredConsecutiveClearsOfRoom",
							FunctionArgs = { Names = { "O_Boss01", "O_Boss02" }, Count = 3 },
						},
					},
				},
				{ Cue = "/VO/ErisField_0485", Text = "How did you... get so fast?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Eris" },
							Comparison = ">",
							Value = 3,
						},
						OrRequirements =
						{
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris01" }
								},
								{
									Path = { "CurrentRun", "EncounterClearStats", "BossEris01", "ClearTime" },
									Comparison = "<=",
									Value = 20.0
								},
							},
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris02" }
								},
								{
									Path = { "CurrentRun", "EncounterClearStats", "BossEris02", "ClearTime" },
									Comparison = "<=",
									Value = 20.0
								},
							},
						},
					}
				},
				{ Cue = "/VO/ErisField_0486", Text = "Did I not even hit you {#Emph}once?",
					PlayFirst = true,
					GameStateRequirements =
					{
						OrRequirements =
						{
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris01" }
								},
								{
									PathFalse = { "CurrentRun", "EncounterClearStats", "BossEris01", "TookDamage" }
								},
							},
							{
								{
									PathTrue = { "CurrentRun", "EncounterClearStats", "BossEris02" }
								},
								{
									PathFalse = { "CurrentRun", "EncounterClearStats", "BossEris02", "TookDamage" }
								},
							},
						},
					}
				},
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
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 7.2,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.75,
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
					-- Portrait = "Portrait_Eris_FiredUp_01",
					-- Portrait = "Portrait_Eris_Unsure_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",
					-- PreLineAnim = "Enemy_Eris_Hub_Flattered",
					-- PreLineAnim = "Enemy_Eris_Hub_Greet",
					-- PreLineAnim = "Enemy_Eris_Hub_Scoff",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Text = "Hate to break it to you, Trouble: Obstacles are things you're supposed to {#Emph}avoid! {#Prev}But in {#Emph}this {#Prev}channel, you're going to run into me {#Emph}every time." },
			},
			ErisBossAboutRandomness01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutObstacles01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3267", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Why is it that you're putting all your effort into stopping me? You're Strife; you should be unpredictable! Perhaps lash out at the forces of Chronos, for a change of pace..." },
				{ Cue = "/VO/ErisField_0355",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What makes you think I {#Emph}don't? {#Prev}You're not the center of the world, babe! And I couldn't be {#Emph}more {#Prev}unpredictable! Don't know why I keep running into you, though. It's so {#Emph}random!" },
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

			ErisBossAboutRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Eris_01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift05" },
					},
				},
				{ Cue = "/VO/ErisField_0155",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You think just 'cause you've been cozying up to me at the Crossroads that I'm gonna let up on you here? Well you're wrong, babe! I know what you're trying to do." },
				{ Cue = "/VO/MelinoeField_3075", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You know what I'm trying to do because I've plainly and repeatedly explained myself. And yet, you still pretend as though there's something much more complicated going on." },
				{ Cue = "/VO/ErisField_0156",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ohh{#Prev}, and now you're trying to guilt-trip me to top it off. Well I don't need to take that kind of guff from you. Nobody pushes me around, get it?" },
			},
			ErisBossAboutPurpose01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					}
				},
				{ Cue = "/VO/MelinoeField_3076", UsePlayerSource = true,
					Text = "Always ready and eager for the fight. I've never met someone so driven, yet so lacking in any purpose whatsoever." },
				{ Cue = "/VO/ErisField_0157",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'm about to blow your mind, you ready, babe? No purpose {#Emph}is {#Prev}a purpose. Think about it! And now I'm gonna blow away the rest of you, too." },
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

			ErisBossAboutProblems01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/MelinoeField_3082", UsePlayerSource = true,
					Text = "I must say, especially for someone who claims to thrive on pure disorder, you {#Emph}are {#Prev}very punctual and consistent, Eris. Every time I've crossed the Rift, you've been right here." },
				{ Cue = "/VO/ErisField_0169",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Portrait = "Portrait_Eris_Unsure_01",
					Text = "No need to rub it in! Look, I know this is becoming a problem, but I swear, I can get it under control. Just promise me you won't tell anybody?" },
				{ Cue = "/VO/MelinoeField_3083", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "You want me to promise not to tell anybody that you're punctual and consistent. Why, because you'd hate for them to start to think better of you for a change?" },
				{ Cue = "/VO/ErisField_0170",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Um, {#Emph}yeah! {#Prev}Although, since when do I even care what anybody thinks of me...? That's not who I am! It's all because you're ruining it for me!" },
			},
			ErisBossAboutProblems02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisBossAboutProblems01", "NemesisGift06", "ErisGift06" }
					},
				},
				{ Cue = "/VO/MelinoeField_4060", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "You have yet to be late for our clashes even once — no matter how quickly I reach these shores, you're here first. But your goal is to be {#Emph}less {#Prev}dependable, not {#Emph}more?" },
				{ Cue = "/VO/ErisField_0437",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "My goal is {#Emph}never {#Prev}to have a goal in my life! It's just, I'm going through some sort of phase I think. All the competition with you and Nemmie must have got to me." },
				{ Cue = "/VO/MelinoeField_4061", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "And what is it you think {#Emph}we're {#Prev}competing for? First to be forced back to the depths of the Underworld?" },
				{ Cue = "/VO/ErisField_0438",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Never said it's you I'm competing with, babe. And you know what I realized about this whole thing we've got going? Discipline and Disorder go hand in hand." },
			},
			ErisBossAboutProblems03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ErisBossAboutProblems02" }
					},
				},
				{ Cue = "/VO/ErisField_0439",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Maybe it's not such a bad thing that I keep showing up on time. {#Emph}You can always count on Strife! {#Prev}That's kind of got a ring to it, right?" },
				{ Cue = "/VO/MelinoeField_4062", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "If you wish to be dependable, that means not just showing up on time, but making yourself useful in some way. Though I suppose that's probably a step too far." },
				{ Cue = "/VO/ErisField_0440",
					-- Portrait = "Portrait_Eris_Unsure_01",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I can't believe you almost got me thinking there was something wrong with me, and just because I {#Emph}care! {#Prev}But don't worry... I'll make sure {#Emph}something's {#Prev}wrong at least!" },
			},

			-- about other characters
			ErisBossAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "UseRecord" },
						CountOf =
						{
							"ZeusUpgrade",
							"HeraUpgrade",
							"PoseidonUpgrade",
							"DemeterUpgrade",
							"HephaestusUpgrade",
							"AphroditeUpgrade",
							"HestiaUpgrade",
							"HermesUpgrade",
						},
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/ErisField_0162",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Just about everybody on Olympus giving you their best, huh? You must be {#Emph}very {#Prev}proud. The gods, they don't agree on much at all." },
				{ Cue = "/VO/MelinoeField_3078", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "No they do not. Yet when the need arises, they can set their differences aside. Something to try with your own kin." },
				{ Cue = "/VO/ErisField_0163",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know who really gets what's going on up there? Ares. If anybody's brought {#Emph}that {#Prev}family together, it's the god of war. {#Emph}His {#Prev}cause even I can get behind!" },
			},
			ErisBossAboutAres02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutAres01" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				{ Cue = "/VO/MelinoeField_3079", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "If you admire Ares so much, know that he has lent me his aid; I have his blessing even now. Though I suppose you still won't be compelled to step aside?" },
				{ Cue = "/VO/ErisField_0164",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You suppose right! And say you {#Emph}do {#Prev}have Ares making up for all your weakness, it's probably because he wants this war to {#Emph}last {#Prev}and {#Emph}last! {#Prev}He can aid {#Emph}you{#Prev}; I can aid {#Emph}him." },
			},
			ErisBossAboutAres03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutAres02" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				{ Cue = "/VO/ErisField_0350",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "I can't believe Ares is helping {#Emph}you {#Prev}not me. I kept trying to get through to him, figured he'd hear me out, but it's too stormy on Olympus. Say, would you...? You know..." },
				{ Cue = "/VO/MelinoeField_3264", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You want me to ask the god of war to lend you his aid, to make my efforts to support him and his family in their near-hopeless battle against Typhon even more difficult?" },
				{ Cue = "/VO/ErisField_0351",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Quit with the {#Emph}sarcasm{#Prev}, Trouble! All I did was ask you for a favor {#Emph}once{#Prev}, but... you had to go and make an {#Emph}insult {#Prev}out of it. {#Emph}Fine! {#Prev}I can get the god of war's attention on my {#Emph}own!" },
			},

			ErisBossAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
					},
				},
				{ Cue = "/VO/ErisField_0171",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Whoa, Trouble, you're {#Emph}huge! {#Prev}Like you and Nemmie had a child! Which, come to think of it, is just about the {#Emph}worst {#Prev}thing I've ever imagined. And I've imagined {#Emph}a lot." },
				{ Cue = "/VO/MelinoeField_3084", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Then imagine what I'm about to do to you in this form, courtesy of Circe the Enchantress. Had you not been so delinquent, you could have learned from her yourself." },
				{ Cue = "/VO/ErisField_0172",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Learned to become a {#Emph}freak{#Prev}, you mean? That's the difference between you and me: You need somebody to teach you {#Emph}everything{#Prev}, while {#Emph}I've {#Prev}got pure instinct!" },
			},
			ErisBossAboutCirce02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
					},
				},
				{ Cue = "/VO/ErisField_0173",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Ah, hahaha{#Prev}, you're so {#Emph}tiny {#Prev}right now, babe! How {#Emph}cuuute. {#Prev}Old Circe must have done that to you, yeah? I've flown by her little island where she's doing all her lunatic experiments." },
				{ Cue = "/VO/MelinoeField_3085", UsePlayerSource = true,
					Text = "You had so much promise as a student, Eris... even now you easily identified the work of an experienced enchantress. But only to spurn our craft." },
				{ Cue = "/VO/ErisField_0174",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your craft turns you into a walking joke! I'm just pointing it out. Well, whatever happens next, thanks for the laughs!" },
			},

			ErisBossAboutIcarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Icarus_01" },
					},
				},
				{ Cue = "/VO/ErisField_0356",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You know that wispy Shade-kid, what's-his-name...? {#Emph}Ick, Icky... Icarus! {#Prev}I've seen him stealing glances, flying around... {#Emph}copying {#Prev}me! Where'd he get the {#Emph}wings?" },
				{ Cue = "/VO/MelinoeField_3268", UsePlayerSource = true,
					Text = "Icarus assuredly is not copying you. This may come as a shock, but there are those attempting to be useful currently... rather than interfering with our plans." },
				{ Cue = "/VO/ErisField_0357",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You think he's {#Emph}attempting to be useful? Pff{#Prev}, come {#Emph}on! {#Prev}He's just a little freak. Maybe he's into {#Emph}Harpies {#Prev}and is trying to get in with them... but then again, who cares!" },
			},
			ErisBossAboutRavenFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "RavenFamiliar" },
					},
				},
				{ Cue = "/VO/ErisField_0358",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteAffection",
					Text = "{#Emph}Aww, loook! {#Prev}You brought an ugly little bird with you! Close as you're ever gonna get to wings like {#Emph}these{#Prev}, babe. But you have to walk everywhere. No {#Emph}wonder {#Prev}you're so unhappy!" },
				{ Cue = "/VO/MelinoeField_3269", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I am {#Emph}not {#Prev}unhappy. And I took a boat most of the way here, thanks! Multiple boats! And I'm not about to let you insult Raki to my face, or his." },
				{ Cue = "/VO/ErisField_0359",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Babe{#Prev}, come {#Emph}on.{#Prev} That bird is so pale it's probably {#Emph}dying! {#Prev}Here, maybe I can put it out of its misery. And {#Emph}you{#Prev}, too." },
			},

			ErisBossAboutCharon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ResourcesSpent", "Money" },
						Comparison = ">=",
						Value = 725,
					},
				},
				{ Cue = "/VO/ErisField_0445",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Done with your shopping finally, Trouble? Charon sure seems to have a lot in stock there on that fancy ship of his! Although he hasn't sold {#Emph}me {#Prev}anything." },
				{ Cue = "/VO/MelinoeField_4065", UsePlayerSource = true,
					Text = "I doubt he ever would. Lord Charon's loyal to the realm. You're not. It's as simple as that, even if you are his sister." },
				{ Cue = "/VO/ErisField_0446",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Loyal to the realm. {#Prev}At least I'm not a suck-up! Though if you {#Emph}like {#Prev}him so much, here's something you can moan and groan about." },
			},
			ErisBossAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
					},
				},
				{ Cue = "/VO/ErisField_0447",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Moonlight sure is guiding you tonight! Too bad Selene can't just whisk you over to Olympus on that chariot of hers. Why {#Emph}can't {#Prev}she, anyway? I thought she was your friend!" },
				{ Cue = "/VO/MelinoeField_4066", UsePlayerSource = true,
					Text = "Perhaps Selene doesn't easily abandon her responsibilities, although I know that concept may be difficult for you to comprehend. Care to whisk me to Olympus in her stead?" },
				{ Cue = "/VO/ErisField_0448",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'll have to pass. Not like these wings could lift the both of us! Although I {#Emph}do {#Prev}have something here for you instead." },
			},
			ErisBossAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/ErisField_0443",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What's with that Cyclops over by the Ephyra docks? He almost hit me with a boulder as I flew over here a couple nights ago!" },
				{ Cue = "/VO/MelinoeField_4064", UsePlayerSource = true,
					Text = "That's Polyphemus. He's blind so there's no need to take his boulder-throwing as a personal affront. He was probably aiming at me." },
				{ Cue = "/VO/ErisField_0444",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, {#Emph}that's {#Prev}a relief! I took a bunch of his sheep, you don't wanna know why, and was starting to worry he caught on. I get the livestock, {#Emph}you {#Prev}get the heat!" },
			},
			ErisBossAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				{ Cue = "/VO/ErisField_0165",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Wait so {#Emph}Prometheus {#Prev}is supposed to be in charge where the real action is? Thought he was busy getting pecked to the brink of death over and over by some {#Emph}bird." },
				{ Cue = "/VO/MelinoeField_3080", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "I can attest he and that bird have come to terms. Come on, have pity on me, Eris. I have to deal with fire and feathers here, and again at the top of Olympus." },
				{ Cue = "/VO/ErisField_0166",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That is a pretty good appeal, babe... {#Emph}but{#Prev}, unfortunately for you, I don't have a heart. So, come on! Here comes your first helping of fire and feathers for the night." },
			},
			ErisBossAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutPrometheus01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				{ Cue = "/VO/ErisField_0167",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "So if you get past me again, what's next for you, Trouble? I've never seen someone go through so {#Emph}much {#Prev}just to see their family. Most of us have to try to stay away from ours!" },
				{ Cue = "/VO/MelinoeField_3081", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "That terrifying cloud encompassing the summit of Olympus conceals Typhon, in case you haven't heard. I'm surprised you haven't gone to see him for yourself! Anyway Prometheus is next, {#Emph}then {#Prev}Typhon. But you first." },
				{ Cue = "/VO/ErisField_0168",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're telling me you're here to pick bigger and bigger fights? {#Emph}Baaabe! {#Prev}I knew we had something going on, but we have more in common than I thought! C'mon, let's go." },
			},
			ErisBossAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutTyphon01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3265", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're really never going to get out of my way, are you, Eris? You'd rather Typhon lay Mount Olympus to ruin. Although at that point I suppose this war would end." },
				{ Cue = "/VO/ErisField_0352",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It sure would! But after that things might not get too orderly for a while, and... who knows what Typhon does from {#Emph}there? {#Prev}Think of the {#Emph}possibilities{#Prev}, babe!" },
			},
			ErisBossAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutTyphon01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Eris_01" },
					},
				},
				{ Cue = "/VO/ErisField_0353",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What happened up there on Olympus last night, babe? Looked like the storm cleared for a little while. Almost flew in for a looksee, but... I don't like the cold!" },
				{ Cue = "/VO/MelinoeField_3266", UsePlayerSource = true,
					Text = "What happened was, after I got past {#Emph}you{#Prev}, I eventually climbed all the way up to the summit where I sent the Father of All Monsters Typhon crashing to the Earth." },
				{ Cue = "/VO/ErisField_0354",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",
					Text = "You {#Emph}did? Whoa{#Prev}, you must be really {#Emph}strong{#Prev}, or Typhon must be really {#Emph}weak! {#Prev}And since you're back already then I guess whatever happened didn't mean a thing!" },
			},
			ErisBossAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				{ Cue = "/VO/ErisField_0441",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "Not seen you here in a while, babe. And what happened to Typhon, anyway? There's been no sign of him at all!" },
				{ Cue = "/VO/MelinoeField_4063", UsePlayerSource = true,
					Text = "Typhon had to leave reality as we know it. Though, sorry, Eris. I suppose you didn't even have a chance to introduce yourself to him, did you?" },
				{ Cue = "/VO/ErisField_0442",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "No I didn't, though if he's so easy to get rid of, maybe it's for the best! So what are you going to Olympus for, anyway? It better not be some sort of {#Emph}feast. {#Prev}Because I {#Emph}wasn't {#Prev}invited!" },
			},

			ErisBossAboutHarpies01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "EnemyKills" },
						HasAny = { "HarpyCutter", "HarpyCutter_Elite" }
					},
				},
				{ Cue = "/VO/ErisField_0372",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Too many Harpies around here, though they're all just a bunch of pushovers. They know who's the top bird and treat me like a {#Emph}goddess!" },
				{ Cue = "/VO/MelinoeField_3276", UsePlayerSource = true,
					Text = "You {#Emph}are {#Prev}a goddess, Eris. Although the Harpies aren't as quick to recognize my own divinity..." },
				{ Cue = "/VO/ErisField_0373",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Maybe they don't like you, since you don't have any wings? Although in your case, it could {#Emph}really {#Prev}be a lot of things..." },
			},

			-- other reactions
			ErisBossLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_PostBoss01" },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "HealingReductionShrineUpgrade" },
						Comparison = "<",
						Value = 3,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/ErisField_0370",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Pff. {#Prev}You took {#Emph}forever {#Prev}getting here! Only to turn up practically as dead as the crews of all those {#Emph}ships {#Prev}headed this way!" },
				{ Cue = "/VO/MelinoeField_3275", UsePlayerSource = true,
					Text = "Apologies for any inconvenience, Eris. Fortunately there's a quite-refreshing fountain not too far from here, which should do wonders for my injuries." },
				{ Cue = "/VO/ErisField_0371",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh{#Prev}, then you're so {#Emph}close! {#Prev}Maybe you could make a break for it. The pathway out of here is right behind me..." },
			},
			ErisBossLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				{ Cue = "/VO/ErisField_0374",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Aww{#Prev}, looks like those mean old sailors back there took a couple pieces out of you along your way! But don't worry, babe. {#Emph}I'll {#Prev}end your suffering!" },
			},
			ErisBossCloseMatch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0.15,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = ">",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0379",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You got so {#Emph}close {#Prev}to beating me last time, babe! I could feel my wings growing heavy... like the Underworld was calling me {#Emph}home. {#Prev}But I'm totally fine now!" },
				{ Cue = "/VO/MelinoeField_3280", UsePlayerSource = true,
					Text = "For the moment. You'll soon feel the Underworld calling you home once more. And you'll go, whether you like it or not." },
				{ Cue = "/VO/ErisField_0380",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Ooh{#Prev}, I {#Emph}love {#Prev}a good threat! Well then, let's see who's going home {#Emph}first{#Prev}, huh? Maybe it'll be just like {#Emph}before..." },
			},

			ErisBossAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				},
				{ Cue = "/VO/ErisField_0158",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteSurprise",
					Text = "OK what in the hell is {#Emph}that {#Prev}you've got on, babe? You could use a change of style, sure, but {#Emph}this {#Prev}is {#Emph}way {#Prev}out-there." },
				{ Cue = "/VO/MelinoeField_3077", UsePlayerSource = true,
					Text = "Oh, you must be referring to the Black Coat. You're right that it's not necessarily my preference for attire, but it's not primarily for show. You'll understand in a moment." },
				{ Cue = "/VO/ErisField_0159",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Wait I remember the Black Coat! So {#Emph}that's {#Prev}what it looks like? And I thought the Adamant Rail looked ridiculous! Nyx had {#Emph}such {#Prev}bad taste." },
			},
			ErisBossAboutNyxAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutSuit01" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				},
				{ Cue = "/VO/ErisField_0381",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Eugh{#Prev}, you look like {#Emph}Nyx! {#Prev}That's still the Black Coat thing you're wearing, isn't it? Except you {#Emph}did {#Prev}something..." },
				{ Cue = "/VO/MelinoeField_3315", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "This is Nyx's own Aspect of Xinth, which deemed me worthy to be its bearer. Perhaps so I could discipline you in your mother's stead." },
				{ Cue = "/VO/ErisField_0382",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Discipline me? {#Prev}Babe, I used to fight with Nyx all the time, but not like {#Emph}this. {#Prev}This is {#Emph}way {#Prev}better! Come on, Mother, give me the best you've got." },
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
			ErisBossAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LastAwardTrait" },
						IsAny = { "EscalatingKeepsake" },
					},
				},
				{ Cue = "/VO/ErisField_0175",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Was that the ringing in my ears just now, or did I maybe hear a little Bell? {#Emph}Oh{#Prev}, you brought along my {#Emph}Keepsake{#Prev}, haven't you! Think that thing's gonna help you {#Emph}here?" },
				{ Cue = "/VO/MelinoeField_3086", UsePlayerSource = true,
					Text = "If it bothers or confounds you the slightest bit, I'll consider it worthwhile. I know you can't so much as give a simple gift without some underhanded motive." },
				{ Cue = "/VO/ErisField_0176",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "While {#Emph}you {#Prev}give gifts with only perfectly pure thoughts bouncing around inside your big, targetable head! Come on. Nobody's like that, babe. Not even you." },
			},
			ErisBossAboutNemesisKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DeathVengeanceKeepsake" },
					},
				},
				{ Cue = "/VO/ErisField_0451",
					Emote = "PortraitEmoteSurprise",					
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Oh no{#Prev}, did you bring Nemmie's Evil Eye? Goes to show how much she really thinks of fairness, making you use {#Emph}that {#Prev}thing just to get me back!" },
				{ Cue = "/VO/MelinoeField_4068", UsePlayerSource = true,
					Text = "{#Emph}I {#Prev}made the choice to bring the Eye, not Nemesis. Although she {#Emph}is {#Prev}Retribution Incarnate, so I'd like to think she would've been supportive had she known." },
				{ Cue = "/VO/ErisField_0452",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Doesn't take a genius to put {#Emph}that {#Prev}one together, babe. {#Emph}I'm {#Prev}her little sister! The {#Emph}runt {#Prev}of Nyx's litter, the {#Emph}smallest {#Prev}and {#Emph}easiest {#Prev}to push around. But I always push back... {#Emph}or {#Prev}push first!" },
			},
			ErisBossAboutMorosKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BlockDeathKeepsake" },
					},
				},
				{ Cue = "/VO/ErisField_0453",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You must be {#Emph}really {#Prev}special to Moros if he gave you one of his shiny Pins! Maybe he thinks you won't make it {#Emph}without {#Prev}him! You {#Emph}look {#Prev}like someone who needs saving, babe." },
				{ Cue = "/VO/MelinoeField_4069", UsePlayerSource = true,
					Text = "And what is that supposed to mean? I'll have you know Lord Moros offered me this Keepsake as a simple courtesy and nothing more." },
				{ Cue = "/VO/ErisField_0454",
					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Uh huh, sure {#Prev}he did. You're both so dense sometimes, I swear! Now let's see if Lord Moros comes to your rescue..." },
			},

			ErisBossAboutFishing01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisFishing01" },
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						Path = { "GameState", "FishingSuccessesManual" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathNotEmpty = { "CurrentRun", "CurrentRoom", "FishingPointChoices" },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsNone = { "CatFamiliar" },
					},
				},
				{ Cue = "/VO/ErisField_0449",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Emote = "PortraitEmoteSurprise",
					Text = "One thing I'll say for this place, it's way easier to fish here than at the Crossroads. I almost feel {#Emph}sorry {#Prev}for you, having to use a rod like some kind of starving mortal." },
				{ Cue = "/VO/MelinoeField_4067", UsePlayerSource = true,
					Text = "I thought you didn't care for fishing. If now you do, you ought have more respect for the traditional technique." },
				{ Cue = "/VO/ErisField_0450",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well then I guess that means I {#Emph}don't! {#Prev}But I was just about to shoot that fish swimming around right near the shore when you showed up. Now {#Emph}you {#Prev}get to be first!" },
			},


			ErisBossAboutDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 8,
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Eris" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/MelinoeField_3277", UsePlayerSource = true,
					Text = "So what's it like, having been forcibly dragged back to hell this many times? At least you know where you truly belong." },
				{ Cue = "/VO/ErisField_0375",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "You and me {#Emph}both{#Prev}, babe. {#Emph}You're {#Prev}the one who's not supposed to {#Emph}be {#Prev}up here! As for getting dragged back {#Emph}down{#Prev}, it's no big deal. I can just fly on back!" },
				{ Cue = "/VO/MelinoeField_3278", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "But as soon as your strength falters, the spirits of the dead shall take hold of you again. Many of them probably seek vengeance for something you did..." },
				{ Cue = "/VO/ErisField_0376",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well, then they can have a {#Emph}piece {#Prev}of me and feel all {#Emph}better {#Prev}about themselves! After all, I've got {#Emph}so {#Prev}much to {#Emph}give!" },
			},
			ErisBossAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisGift02" },
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/ErisField_0377",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "I almost thought you weren't going to show up! Leave me hanging yet another night, I mean... why {#Emph}not? {#Prev}You're so {#Emph}inconsiderate {#Prev}sometimes!" },
				{ Cue = "/VO/MelinoeField_3279", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You're telling me while I've been in the Underworld, you've just been waiting here night after night? What am I, supposed to tell you where I'm going in advance?" },
				{ Cue = "/VO/ErisField_0378",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That's what a real friend would do, so {#Emph}no{#Prev}, I guess not! Maybe you shouldn't come back. What do I care?" },
			},

			ErisBossAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyTorchHeat1OBoss",
							"BountyAxeHeat2OBoss",
							"BountyDaggerHeat4OBoss",
							"BountyStaffHeat8OBoss",
							"BountySuitHeat12OBoss",
							"BountyLobHeat16OBoss",

							"BountyShrineStaffOBoss",
							"BountyShrineDaggerOBoss",
							"BountyShrineTorchOBoss",
							"BountyShrineAxeOBoss",
							"BountyShrineLobOBoss",
							"BountyShrineSuitOBoss",
						},
					},
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">",
						Value = 2,
					},
					-- back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisAboutShrine01" }
					},
					--[[
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PolyphemusAboutPackagedBounties01" }, Min = 3 },
					},
					]]--
				},
				{ Cue = "/VO/ErisField_0360",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Portrait = "Portrait_Eris_Unsure_01",
					Emote = "PortraitEmoteDepressed",
					Text = "Sure is dark out there tonight, {#Emph}huh? {#Prev}Even the dead sailors on the Rift looked a little spooked. Maybe something's up...?" },
				{ Cue = "/VO/MelinoeField_3270", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "There's {#Emph}Fear {#Prev}in the air. You've defied the will of Night too often, Eris. This time I'm not here merely for Olympus, but for {#Emph}you." },
				{ Cue = "/VO/ErisField_0361",
					Portrait = "Portrait_Eris_FiredUp_01",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're telling me {#Emph}Nyx {#Prev}put you up to this? {#Emph}Pff, right! {#Prev}She never cared about me, and she's {#Emph}not {#Prev}about to start now." },
			},
			ErisBossAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ActiveShrineBounty" },
						IsAny =
						{
							"BountyTorchHeat1OBoss",
							"BountyAxeHeat2OBoss",
							"BountyDaggerHeat4OBoss",
							"BountyStaffHeat8OBoss",
							"BountySuitHeat12OBoss",
							"BountyLobHeat16OBoss",

							"BountyShrineStaffOBoss",
							"BountyShrineDaggerOBoss",
							"BountyShrineTorchOBoss",
							"BountyShrineAxeOBoss",
							"BountyShrineLobOBoss",
							"BountyShrineSuitOBoss",
						},
					},
					-- back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisAboutShrine02" }
					},
					--[[
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PolyphemusAboutPackagedBounties01" }, Min = 3 },
					},
					]]--
				},
				{ Cue = "/VO/ErisField_0362",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "{#Emph}Fear in the air{#Prev}, you said, last time it was like this. Maybe you really {#Emph}are {#Prev}doing some of Nyx's dirty work! In which case, you're {#Emph}way {#Prev}dumber than I thought..." },
				{ Cue = "/VO/MelinoeField_3271", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You were invited and expected to be part of the Unseen. But you turned your back not only on us, but your mother, and the Underworld itself. A price is to be paid for that." },
				{ Cue = "/VO/ErisField_0363",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And you've come to collect! Too bad I've got nothing to give. Unless you take payment in these little {#Emph}metal {#Prev}things that the Rail chews up and spits out." },
			},
			ErisBossAboutShrine03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 14,
					},
					-- back compat
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisAboutShrine03" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				{ Cue = "/VO/ErisField_0368",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "{#Emph}Whew{#Prev}, this is my kind of {#Emph}night! {#Prev}Real feeding frenzy out there, like everything is just... {#Emph}way... more. {#Prev}No idea what's going on but I {#Emph}like {#Prev}it." },
				{ Cue = "/VO/MelinoeField_3274", UsePlayerSource = true,
					Text = "You never gave any consideration to the Oath of the Unseen, yet remain one of its main beneficiaries. Perhaps your mother Nyx did something for you after all." },
				{ Cue = "/VO/ErisField_0369",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You mean these occasional evenings of complete and total depravity are meant to make up for everything Nyx {#Emph}didn't {#Prev}do...? Well I guess it's a start!" },
			},
			ErisAboutPackagedBounties01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/ErisField_0364",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", Portrait = "Portrait_Eris_Unsure_01", WaitTime = 4.35 },
					Text = "{#Emph}Ah{#Prev}, you almost beat me here tonight, Trouble! You're {#Emph}way {#Prev}ahead of schedule! Although... {#Emph}huh... {#Prev}What am I {#Emph}saying? Schedule?! {#Prev}What's happening to me...?" },
				{ Cue = "/VO/MelinoeField_3272", UsePlayerSource = true,
					Text = "If you're feeling a little out of sorts this evening, perhaps it's simply because Primordial Chaos is exerting influence over reality as we know it." },
				{ Cue = "/VO/ErisField_0365",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, {#Emph}right{#Prev}, that makes sense! {#Emph}Chaos {#Prev}made everything. But you know what? Now {#Emph}we {#Prev}can make some chaos, too." },
			},
			ErisAboutPackagedBounties02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutPackagedBounties01" },
					},
					NamedRequirements = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/ErisField_0366",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "You made it past Ephyra {#Emph}real {#Prev}quick, Trouble. Must be {#Emph}Primordial Chaos exerting influence over reality {#Prev}again, {#Emph}huh...?" },
				{ Cue = "/VO/MelinoeField_3273", UsePlayerSource = true,
					Text = "The thing is, Eris... I can be entirely forthright with you, yet you still take the absolute {#Emph}least {#Prev}charitable view of anything I say. So what does it matter how I respond?" },
				{ Cue = "/VO/ErisField_0367",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "See, that's exactly how {#Emph}I {#Prev}feel — what {#Emph}does {#Prev}it matter. Maybe it matters to {#Emph}Chaos, huh? {#Prev}Only {#Emph}one {#Prev}way to find out." },
			},

			ErisBossAboutAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/ErisField_0386",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					-- Portrait = "Portrait_Eris_Unsure_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",
					Text = "See anything different about me, babe? Probably not! {#Emph}I {#Prev}haven't changed a bit, but you know what {#Emph}has {#Prev}is the Adamant Rail! I mean just {#Emph}look {#Prev}at it!" },
				{ Cue = "/VO/MelinoeField_3487", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "That must be someone else's Aspect of the Rail. Perhaps you did or said something to make it change its form... though this could have been my doing as well." },
				{ Cue = "/VO/ErisField_0387",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There you go, always trying to take all the credit for yourself! Well the Rail doesn't answer to {#Emph}you{#Prev}, it answers to {#Emph}me. {#Prev}And I've already figured out all the new {#Emph}stuff {#Prev}it can do!" },
				EndVoiceLines =
				{
					PreLineWait = 1.0,
					ObjectType = "Eris",
					TriggerCooldowns = { "ErisSpokeRecently" },

					{ Cue = "/VO/ErisField_0388", Text = "Now watch {#Emph}this...!" },
				},
			},
			ErisBossAboutAltFight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/ErisField_0389",
					-- Portrait = "Portrait_Eris_Unsure_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",
					Text = "Earlier the Rail magickally switched over to this other style again. Like it {#Emph}knew {#Prev}you were on the way! I {#Emph}also {#Prev}knew you were on the way, pretty easy to spot you up there." },
				{ Cue = "/VO/MelinoeField_3488", UsePlayerSource = true,
					Text = "Have you any idea whose Aspect that even is, or why your ancient Fate-forged weapon might be magickally changing forms without your influence?" },
				{ Cue = "/VO/ErisField_0390",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}No! {#Prev}You talk like I'm supposed to be afraid of this thing when {#Emph}you're {#Prev}the one staring down the part that shoots." },
			},
			ErisBossAboutAltFight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Eris" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutAltFight01" },
					},
				},

				{ Cue = "/VO/ErisField_0391",
					Portrait = "Portrait_Eris_Unsure_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Damn it {#Prev}I kept waiting for this stupid Rail to switch over to that other form again but it won't {#Emph}budge! {#Prev}Same old piece of junk. Doesn't even reload half the time..." },
				{ Cue = "/VO/MelinoeField_3489", UsePlayerSource = true,
					Text = "Keep speaking ill of it that way and it may do your bidding less and less! I'm surprised you have an Aspect to your name at all." },
				{ Cue = "/VO/ErisField_0392",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteCheerful",
					Text = "Well life's just full of surprises, Trouble! I like this Aspect better anyway. Let's see if it still does my {#Emph}bidding!" },
			},
			ErisBossAboutAltFight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Eris" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisBossAboutAltFight03" },
					},
				},

				{ Cue = "/VO/ErisField_0393",
					Portrait = "Portrait_Eris_FiredUp_01",
					-- Portrait = "Portrait_Eris_Default_02",
					-- Portrait = "Portrait_Eris_FiredUp_02",
					-- Portrait = "Portrait_Eris_Unsure_02",
					Emote = "PortraitEmoteFiredUp",
					Text = "The Rail switched up on me again! Hey, what if {#Emph}this {#Prev}is my true Aspect and the other one is for somebody else? This one's even got a {#Emph}face {#Prev}like mine, and {#Emph}wings!" },
				{ Cue = "/VO/MelinoeField_3490", UsePlayerSource = true,
					Text = "Look, the only reason you can sometimes use this Aspect is the Oath of the Unseen. Can't you feel the Fear in the night?" },
				{ Cue = "/VO/ErisField_0394",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "All I feel right now, babe, is an overwhelming urge to turn you into little crispy slices with this thing. You think I care about some {#Emph}Oath? {#Prev}What am I, {#Emph}Nyx?!" },
			},
			ErisBossAboutAltFight05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/ErisField_0395",
					Text = "You washed up on the wrong part of the beach, Trouble. You see that giant stinking carcass over there? {#Emph}That's {#Prev}what you're gonna look like after this." },
				{ Cue = "/VO/MelinoeField_3491", UsePlayerSource = true,
					Text = "I'm not nearly that size, Eris! Nor am I an aquatic animal, nor are you going to kill me. Though I must say, this part of the beach is horrid, and the carcass doesn't help." },
				{ Cue = "/VO/ErisField_0396",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What do you even know about {#Emph}beaches{#Prev}, or carcasses? I've got my special Aspect of the Rail here, and {#Emph}all {#Prev}the sights and sounds and smells of the sea. So who needs {#Emph}you?!" },
			},

			ErisBossAboutRelationship02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutRelationship01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisAboutRelationship02"}
					},
				},

				{ Cue = "/VO/Melinoe_4367", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When last we spoke you said whatever's wrong with you couldn't be fixed. What makes you say such things?" },

				{ Cue = "/VO/Eris_0260",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Text = "Appreciate all the concern but I just had a little moment that you're making a big deal. We're all a little broken, right?" },

				{ Cue = "/VO/Melinoe_4368", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps so. But we can better ourselves through effort and discipline, as much as we can muster. Or, we could endlessly get in each other's way." },

				{ Cue = "/VO/Eris_0261",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The thing is, I don't want to have to {#Emph}try. {#Prev}Not with {#Emph}this{#Prev}, not with {#Emph}you. {#Prev}I want things to be {#Emph}easy{#Prev}, you want things to be {#Emph}hard. {#Prev}But at least we really {#Emph}get {#Prev}each other now!" },
			},

			ErisBossAboutBecomingCloser01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
						IsAny = { "Choice_ErisAccept" },
					},
				},

				{ Cue = "/VO/ErisField_0383",
					PreLineAnim = "Enemy_Eris_Hub_Flattered",
					Emote = "PortraitEmoteCheerful",
					Text = "Back to doing what we do! Nothing like trying to shoot you to pieces night after night like nothing happened, huh?" },

				{ Cue = "/VO/MelinoeField_3527", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know I shouldn't be surprised that you're about to fight me as per usual, Eris, but... I held out hope you'd start to see me in a different light. So much for that?" },

				{ Cue = "/VO/ErisField_0384",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "So much for that! And don't be so full of yourself. It's not like we bared our souls to one another! Not sure I even {#Emph}have {#Prev}one. Anyway, no deferential treatment from me here." },

				{ Cue = "/VO/MelinoeField_3528", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The part where you keep going out of your way to bar my passage to Olympus {#Emph}isn't {#Prev}what you would consider deferential treatment then?" },

				{ Cue = "/VO/ErisField_0385",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know you {#Emph}do {#Prev}make a good point there, babe! But I'm not gonna dwell on it and just start shooting you, OK?" },
			},

			ErisBossPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisPostTrueEnding01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_4070", UsePlayerSource = true,
					Text = "Now that my brother's back, you still have no intention to return the Rail of Adamant, do you? Even though it was in his possession prior to all this." },
				{ Cue = "/VO/ErisField_0455",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					Text = "What makes you think he has greater right to it than {#Emph}me, huh{#Prev}, babe? He wasn't even using it five-sixths of the time! Just another weapon to him, but it's {#Emph}my {#Prev}one-and-only." },
				{ Cue = "/VO/MelinoeField_4071", UsePlayerSource = true,
					Text = "How touching! I trust your mother shall make sure it all works out, seeing as she's back as well. I wonder if she's always known you'd get your hands on that thing." },
				{ Cue = "/VO/ErisField_0456",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#Emph}Oh {#Prev}she {#Emph}has! {#Prev}Because this isn't my first time! Then I kind of lost it at one point, and your brother got his hands on it instead... but I {#Emph}always {#Prev}take what's mine." },
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 2,
					},
				},
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
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
				},
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
					{
						FunctionName = "RequiredConsecutiveDeathsInRoom",
						FunctionArgs = { Names = { "O_Boss01", "O_Boss02" }, Count = 2 },
					},
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
			ErisBossMiscStart24 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasNone = { "O_Boss01", "O_Boss02" }
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Eris_01" }
					},
					--[[
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "O_Boss01" },
						Comparison = ">=",
						Value = 0,
					},
					]]--
				},
				{ Cue = "/VO/ErisField_0148",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "{#Emph}Finally! {#Prev}I can only stand here contemplating the water for so long, you know!" },
			},
			ErisBossMiscStart25 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" }
					},
				},
				{ Cue = "/VO/ErisField_0149",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Never thought I was the type to get into any sort of regular routine, but {#Emph}now {#Prev}look at me, babe!" },
			},
			ErisBossMiscStart26 =
			{
				{ Cue = "/VO/ErisField_0150",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "You don't {#Emph}really {#Prev}have to climb all the way up that mountain back there, do you, Trouble?" },
			},
			ErisBossMiscStart27 =
			{
				{ Cue = "/VO/ErisField_0151",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Let's just have our fun, babe! I don't have all night, and neither do you." },
			},
			ErisBossMiscStart28 =
			{
				{ Cue = "/VO/ErisField_0152",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Difference between you and me is I don't care {#Emph}one bit {#Prev}whether I win or lose." },
			},
			ErisBossMiscStart29 =
			{
				{ Cue = "/VO/ErisField_0153",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "You {#Emph}like {#Prev}this, don't you, Trouble? You don't have to tell me. Just admit it to yourself!" },
			},
			ErisBossMiscStart30 =
			{
				{ Cue = "/VO/ErisField_0154",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "I hate to be so predictable, but I love making you mad, so... it's kind of a wash!" },
			},
			ErisBossMiscStart31 =
			{
				{ Cue = "/VO/ErisField_0026",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Don't take this personally, babe, but some things we just have to do, you know?" },
			},
			ErisBossMiscStart32 =
			{
				{ Cue = "/VO/ErisField_0027",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "While I'd love to slow you down with a delightful chat, I think {#Emph}this {#Prev}will get the job done {#Emph}even better." },
			},
			ErisBossMiscStart33 =
			{
				{ Cue = "/VO/ErisField_0028",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Look, {#Emph}heh! {#Prev}I know it's been a little rocky between us, but... we'll probably look back at this and laugh!", },
			},
			ErisBossMiscStart34 =
			{
				{ Cue = "/VO/ErisField_0029",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "You don't look so happy to see me, babe! And I haven't even {#Emph}done {#Prev}anything yet..." },
			},
			ErisBossMiscStart35 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "O_Boss01", "O_Boss02" }, Count = 3 },
					},
				},
				{ Cue = "/VO/ErisField_0030",
					Portrait = "Portrait_Eris_Unsure_01",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ungh! {#Prev}This isn't working...! Why won't you stop? What's it going to take, {#Emph}huh?" },
			},
			ErisBossMiscStart36 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredConsecutiveClearsOfRoom",
						FunctionArgs = { Names = { "O_Boss01", "O_Boss02" }, Count = 3 },
					},
				},
				{ Cue = "/VO/ErisField_0031",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Emote = "PortraitEmoteAnger",
					Text = "You just don't know when to quit, do you, Trouble? {#Emph}Fine!" },
			},
			ErisBossMiscStart37 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "Eris" },
					},
				},
				{ Cue = "/VO/ErisField_0457",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Emote = "PortraitEmoteSparkly",
					Text = "Look what {#Emph}I {#Prev}got back for some strange reason I can't figure out, Trouble!" },
			},
			ErisBossMiscStart38 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/ErisField_0458",
					Emote = "PortraitEmoteSparkly",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "I like the old Rail fine, but this {#Emph}new {#Prev}one's even better! Though, maybe not for you." },
			},
			ErisBossMiscStart39 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/ErisField_0459",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "What a {#Emph}night! {#Prev}Got my new Aspect of the Rail, {#Emph}and {#Prev}a juicy target to try it on." },
			},
			ErisBossMiscStart40 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/ErisField_0460",
					Portrait = "Portrait_Eris_FiredUp_01",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "Let's work together, babe, to figure out what this new Aspect of the Rail can do!" },
			},
			ErisBossMiscStart41 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/ErisField_0461",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "No fooling around, Trouble! I may not be Misery, but I'm the next best thing!" },
			},
			ErisBossMiscStart42 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisTaverna02" }
					},
				},
				{ Cue = "/VO/ErisField_0462",
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayErisTauntAnim", PreLineWait = 0.35,
					Text = "I {#Emph}may {#Prev}kind of like you, babe, but that won't stop me from doing what needs to be done." },
			},
		},

		Using = 
		{
			Sounds = 
			{
				"/SFX/Player Sounds/ZagreusGunRunningMisc",
			},
		},
	},

}

-- Global Eris Lines
GlobalVoiceLines.ErisBossGreetingLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		SuccessiveChanceToPlay = 0.85,
		ObjectType = "Eris",
		PreLineAnim = "Enemy_Eris_Hub_Greet",

		{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
		{ Cue = "/VO/Eris_0074", Text = "{#Emph}Ahh, heh!" },
		{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
		{ Cue = "/VO/ErisField_0050", Text = "Hiya babe!" },
		{ Cue = "/VO/ErisField_0051", Text = "Hey hey!" },
		{ Cue = "/VO/ErisField_0052", Text = "Thought that was you." },
		{ Cue = "/VO/ErisField_0053", Text = "Look who!" },
		{ Cue = "/VO/ErisField_0054", Text = "Got here {#Emph}first!" },
		{ Cue = "/VO/ErisField_0055", Text = "You made it!", PlayFirst = true },
		{ Cue = "/VO/ErisField_0405", Text = "Look what washed up..." },
		{ Cue = "/VO/ErisField_0406", Text = "What took you so long?" },
		{ Cue = "/VO/ErisField_0407", Text = "{#Emph}Uh-uh-uhh!" },
		{ Cue = "/VO/ErisField_0408", Text = "Oh it's {#Emph}you!" },
		{ Cue = "/VO/ErisField_0409", Text = "Like magick...!" },
		{ Cue = "/VO/ErisField_0410", Text = "You're here!" },
		{ Cue = "/VO/ErisField_0411", Text = "Target practice..." },
		{ Cue = "/VO/ErisField_0403", Text = "Who cleaned up the beach...?", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Boss01" },
				},
				{
					PathTrue = { "GameState", "LastBossDifficultyRecord", "Eris" },
				},
			},
		},
		{ Cue = "/VO/ErisField_0404", Text = "Stupid Rail...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Boss01" },
				},
				{
					PathTrue = { "GameState", "LastBossDifficultyRecord", "Eris" },
				},
			},
		},
		{ Cue = "/VO/ErisField_0056", Text = "Trouble!",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredQueuedTextLine",
					FunctionArgs = { IsNone = { "ErisBossAboutTyphon01", }, },
				},
			},
		},
		{ Cue = "/VO/ErisField_0057", Text = "Trouble.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredQueuedTextLine",
					FunctionArgs = { IsNone = { "ErisBossAboutTyphon01", }, },
				},
			},
		},

		{ Cue = "/VO/ErisField_0397", Text = "{#Emph}Eugh{#Prev}, what happened to this beach...?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/ErisField_0398", Text = "Something {#Emph}stinks...!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/ErisField_0399", Text = "Get a load of {#Emph}this!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/ErisField_0400", Text = "Look what {#Emph}I {#Prev}got!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/ErisField_0401", Text = "Look what I got...!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/ErisField_0402", Text = "It's the nightly special!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.5,
		UsePlayerSource = true,

		{ Cue = "/VO/MelinoeField_3485", Text = "What happened here...?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3486", Text = "This beach...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},

		{ Cue = "/VO/MelinoeField_1903", Text = "Eris...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1905", Text = "You.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1904", Text = "You're in my way." },
		{ Cue = "/VO/MelinoeField_1906", Text = "Every time..." },
	},
}

GlobalVoiceLines.ErisAttemptedExitVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	ObjectTypes = { "Eris", "NPC_Eris_01" },
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/ErisField_0038", Text = "Excuse me?" },
	{ Cue = "/VO/ErisField_0039", Text = "Oh, no you {#Emph}don't!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0041", Text = "Hold up, babe." },
	{ Cue = "/VO/Eris_0081", Text = "What's the matter?" },
	{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?" },
	{ Cue = "/VO/ErisField_0338", Text = "{#Emph}Excuse {#Prev}me?" },
	{ Cue = "/VO/ErisField_0339", Text = "You're not going anywhere.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},
	},
	{ Cue = "/VO/ErisField_0340", Text = "Babe don't {#Emph}go!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},
	},
	{ Cue = "/VO/ErisField_0341", Text = "You're staying {#Emph}here!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},
	},
	{ Cue = "/VO/ErisField_0040", Text = "{#Emph}Aw{#Prev}, c'mon.",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Boss01", "O_Boss02" },
			},
		},
	},
}
GlobalVoiceLines.ErisInvulnerableVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.25,
	ObjectTypes = { "Eris", "NPC_Eris_01" },
	GameStateRequirements =
	{
		{
			PathFromArgs = true,
			Path = { "SourceProjectile", },
			IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 6 },
	},

	{ Cue = "/VO/ErisField_0043", Text = "Nu-{#Emph}uh!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0044", Text = "Not now." },
	{ Cue = "/VO/ErisField_0045", Text = "Nice try!" },
	{ Cue = "/VO/ErisField_0046", Text = "You wish!" },
	{ Cue = "/VO/ErisField_0047", Text = "{#Emph}Cute!" },
	{ Cue = "/VO/ErisField_0333", Text = "{#Emph}Hah! {#Prev}No." },
	{ Cue = "/VO/ErisField_0334", Text = "Didn't hurt!" },
	{ Cue = "/VO/ErisField_0336", Text = "Nice try." },
	{ Cue = "/VO/ErisField_0335", Text = "Didn't hurt.",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/ErisField_0334" }
			},
		},
	},
	{ Cue = "/VO/ErisField_0042", Text = "Maybe later?",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Boss01", "O_Boss02" },
			},
		},
	},
	{ Cue = "/VO/ErisField_0332", Text = "Oh no you {#Emph}don't!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},
	},
	{ Cue = "/VO/ErisField_0337", Text = "Sorry!",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},
	},
}
GlobalVoiceLines.ErisAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
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
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0058", Text = "Here!" },
	{ Cue = "/VO/ErisField_0059", Text = "Run...!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0060", Text = "Got you!" },
	{ Cue = "/VO/ErisField_0061", Text = "Now..." },
	{ Cue = "/VO/ErisField_0062", Text = "Eat {#Emph}this!" },
	{ Cue = "/VO/ErisField_0063", Text = "Now...!" },
	{ Cue = "/VO/ErisField_0064", Text = "{#Emph}<Chuckle>" },
	{ Cue = "/VO/ErisField_0065", Text = "{#Emph}Boom!" },
	{ Cue = "/VO/ErisField_0066", Text = "Better {#Emph}hide!" },
	{ Cue = "/VO/ErisField_0067", Text = "How's this?" },
	{ Cue = "/VO/ErisField_0068", Text = "Want more?" },
	{ Cue = "/VO/ErisField_0069", Text = "All mine." },
}
GlobalVoiceLines.ErisShotgunVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0251", Text = "Spread fire!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0252", Text = "Chew on {#Emph}this!" },
	{ Cue = "/VO/ErisField_0253", Text = "Open {#Emph}wide...!" },
	{ Cue = "/VO/ErisField_0254", Text = "Have a {#Emph}blast!" },
	{ Cue = "/VO/ErisField_0255", Text = "Keep running!" },
	{ Cue = "/VO/ErisField_0256", Text = "Hold {#Emph}still!" },
}
GlobalVoiceLines.ErisGrenadeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	SuccessiveChanceToPlay = 0.33,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0070", Text = "Heads {#Emph}up!" },
	{ Cue = "/VO/ErisField_0071", Text = "Bombs {#Emph}away!" },
	{ Cue = "/VO/ErisField_0072", Text = "Catch!" },
	{ Cue = "/VO/ErisField_0073", Text = "{#Emph}Boom!" },
	{ Cue = "/VO/ErisField_0258", Text = "Want some?" },
	{ Cue = "/VO/ErisField_0259", Text = "Here you go!" },
	{ Cue = "/VO/ErisField_0262", Text = "Look out below!" },
	{ Cue = "/VO/ErisField_0415", Text = "Have a glowie!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
}
GlobalVoiceLines.ErisGrenadeClusterVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlay = 0.5,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0257", Text = "Have a couple!" },
	{ Cue = "/VO/ErisField_0260", Text = "Look at 'em fly!" },
	{ Cue = "/VO/ErisField_0262", Text = "Look out {#Emph}below!" },
	{ Cue = "/VO/ErisField_0412", Text = "Have some of {#Emph}these!" },
	{ Cue = "/VO/ErisField_0417", Text = "Watch your step, babe!" },
	{ Cue = "/VO/ErisField_0471", Text = "{#Emph}And {#Prev}they're off!" },
	{ Cue = "/VO/ErisField_0472", Text = "{#Emph}Boom time!" },
	{ Cue = "/VO/ErisField_0473", Text = "Watch {#Emph}out!" },
	{ Cue = "/VO/ErisField_0474", Text = "Heads up!" },
	{ Cue = "/VO/ErisField_0475", Text = "{#Emph}Whoosh..." },
	{ Cue = "/VO/ErisField_0476", Text = "{#Emph}Ba-boom!" },	
	{ Cue = "/VO/ErisField_0413", Text = "Ooh, {#Emph}glowy!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/ErisField_0414", Text = "Night lights!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	{ Cue = "/VO/ErisField_0416", Text = "Glow-bombs!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
}
GlobalVoiceLines.ErisSniperAimVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.2,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Eris",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
		{ Name = "ErisSnipedRecently", Time = 40 },
	},

	{ Cue = "/VO/ErisField_0271", Text = "I {#Emph}see {#Prev}you...!" },
	{ Cue = "/VO/ErisField_0272", Text = "{#Emph}There {#Prev}you are..." },
	{ Cue = "/VO/ErisField_0273", Text = "I got you..." },
	{ Cue = "/VO/ErisField_0274", Text = "Don't try to hide..." },
	{ Cue = "/VO/ErisField_0275", Text = "Got you in my sights...", PlayFirst = true },
	{ Cue = "/VO/ErisField_0276", Text = "One good shot..." },
	{ Cue = "/VO/ErisField_0277", Text = "Got a lock on you..." },
	{ Cue = "/VO/ErisField_0278", Text = "Ready... aim..." },
}
GlobalVoiceLines.ErisSniperFireVoiceLines =
{
	Queue = "Never",
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.05,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Eris",
	-- TriggerCooldowns = { "ErisSpokeRecently" },
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},

	{ Cue = "/VO/ErisField_0279", Text = "{#Emph}Fire!!" },
	{ Cue = "/VO/ErisField_0280", Text = "{#Emph}Bang!" },
	{ Cue = "/VO/ErisField_0281", Text = "{#Emph}Blam!" },
	{ Cue = "/VO/ErisField_0282", Text = "{#Emph}Blamm-o!" },
	{ Cue = "/VO/ErisField_0283", Text = "{#Emph}Ka-blam!" },
	{ Cue = "/VO/ErisField_0284", Text = "{#Emph}Ka-pow!" },
}
GlobalVoiceLines.ErisSwoopInVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.4,
	SuccessiveChanceToPlay = 0.33,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
		{ Name = "ErisSwoopedDownRecently", Time = 60 },
	},

	{ Cue = "/VO/ErisField_0245", Text = "Here I am!" },
	{ Cue = "/VO/ErisField_0246", Text = "{#Emph}Yoo-hoo!" },
	{ Cue = "/VO/ErisField_0247", Text = "Over {#Emph}here!" },
	{ Cue = "/VO/ErisField_0248", Text = "Hey {#Emph}babe!" },
	{ Cue = "/VO/ErisField_0249", Text = "I'm {#Emph}back!" },
	{ Cue = "/VO/ErisField_0250", Text = "Miss me?" },
}
GlobalVoiceLines.ErisSpawnWaveVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.75,
	ObjectType = "Eris",
	SkipAnim = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSummonedRecently", Time = 60 },
	},
	TriggerCooldowns = { "ErisSpokeRecently" },

	{ Cue = "/VO/ErisField_0233", Text = "Look what {#Emph}I {#Prev}found!" },
	{ Cue = "/VO/ErisField_0234", Text = "{#Emph}Incoming!" },
	{ Cue = "/VO/ErisField_0235", Text = "Incoming...!" },
	{ Cue = "/VO/ErisField_0236", Text = "Special delivery!" },
	{ Cue = "/VO/ErisField_0237", Text = "Think you dropped these, babe!" },
	{ Cue = "/VO/ErisField_0238", Text = "We just want to be {#Emph}friends!" },
	{ Cue = "/VO/ErisField_0239", Text = "Look at these washed-up freaks!" },
	{ Cue = "/VO/ErisField_0241", Text = "Come on, everybody, join in!" },
	{ Cue = "/VO/ErisField_0242", Text = "Free-for-all, {#Emph}everybody!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0243", Text = "Looks like the tide's come in!" },
	{ Cue = "/VO/ErisField_0244", Text = "Found some of your old friends!" },
	{ Cue = "/VO/ErisField_0468", Text = "How about some of {#Emph}these?" },
	{ Cue = "/VO/ErisField_0470", Text = "{#Emph}Everyone's {#Prev}invited!" },
	{ Cue = "/VO/ErisField_0240", Text = "Got some more freaks for you!",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/ErisField_0239" }
			},
		},
	},
}
GlobalVoiceLines.ErisFishSpawnWaveVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.75,
	SuccessiveChanceToPlayAll = 0.25,
	ObjectType = "Eris",
	SkipAnim = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSummonedRecently", Time = 60 },
	},
	TriggerCooldowns = { "ErisSpokeRecently" },


	-- { Cue = "/VO/ErisField_0463", Text = "Hey {#Emph}you're {#Prev}not from around here!" },
	-- { Cue = "/VO/ErisField_0464", Text = "Aren't these supposed to be on Olympus?" },
	-- { Cue = "/VO/ErisField_0465", Text = "Got some rare imports for you here!" },
	{ Cue = "/VO/ErisField_0466", Text = "Here comes the catch of the {#Emph}night!" },
	{ Cue = "/VO/ErisField_0467", Text = "You're fish-food, babe!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0469", Text = "{#Emph}Eugh{#Prev}, where'd {#Emph}those {#Prev}come from?" },
}
GlobalVoiceLines.ErisAutomatonSpawnWaveVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.75,
	SuccessiveChanceToPlayAll = 0.25,
	ObjectType = "Eris",
	SkipAnim = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSummonedRecently", Time = 60 },
	},
	TriggerCooldowns = { "ErisSpokeRecently" },

	{ Cue = "/VO/ErisField_0463", Text = "Hey {#Emph}you're {#Prev}not from around here!" },
	{ Cue = "/VO/ErisField_0464", Text = "Aren't these supposed to be on Olympus?", PlayFirst = true },
	{ Cue = "/VO/ErisField_0465", Text = "Got some rare imports for you here!" },
}
GlobalVoiceLines.ErisSelfBuffAppliedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
	GameStateRequirements =
	{
	},
	Cooldowns =
	{
		-- { Name = "ErisSpokeRecently", Time = 8 },
		{ Name = "ErisPoweredUpRecently", Time = 20 },
	},
	TriggerCooldowns = { "ErisSpokeRecently" },

	{ Cue = "/VO/ErisField_0209", Text = "{#Emph}Aw{#Prev}, yeah..." },
	{ Cue = "/VO/ErisField_0210", Text = "Ah, {#Emph}yeah!" },
	{ Cue = "/VO/ErisField_0211", Text = "{#Emph}Woo, that's {#Prev}it!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0212", Text = "{#Emph}That's {#Prev}the stuff!" },
	{ Cue = "/VO/ErisField_0213", Text = "{#Emph}Wooo!" },
	{ Cue = "/VO/ErisField_0214", Text = "Oh, {#Emph}hohohohohoh!" },
	{ Cue = "/VO/ErisField_0215", Text = "{#Emph}Now {#Prev}you're in for it!" },
	{ Cue = "/VO/ErisField_0216", Text = "{#Emph}Now {#Prev}it's on..." },
	{ Cue = "/VO/ErisField_0217", Text = "Better {#Emph}run{#Prev}, babe!" },
	{ Cue = "/VO/ErisField_0218", Text = "This is gonna {#Emph}hurt!" },
	{ Cue = "/VO/ErisField_0219", Text = "Fired {#Emph}up!" },
	{ Cue = "/VO/ErisField_0220", Text = "All right!!" },
	{ Cue = "/VO/ErisField_0221", Text = "...Double damage." },
	{ Cue = "/VO/ErisField_0222", Text = "{#Emph}Double damage...!" },
}
GlobalVoiceLines.ErisSelfBuffClearedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 8 },
		{ Name = "ErisPoweredDownRecently", Time = 60 },
	},

	{ Cue = "/VO/ErisField_0223", Text = "{#Emph}Whew..." },
	{ Cue = "/VO/ErisField_0224", Text = "Back to normal...", PlayFirst = true },
	{ Cue = "/VO/ErisField_0226", Text = "{#Emph}Aw {#Prev}that's {#Emph}it?" },
	{ Cue = "/VO/ErisField_0227", Text = "Out of juice..." },
	{ Cue = "/VO/ErisField_0228", Text = "There goes that..." },
	{ Cue = "/VO/ErisField_0229", Text = "So much for that..." },
	{ Cue = "/VO/ErisField_0230", Text = "Fun while it lasted..." },
	{ Cue = "/VO/ErisField_0231", Text = "Safe to come out now..." },
	{ Cue = "/VO/ErisField_0232", Text = "Your turn again..." },
	{ Cue = "/VO/ErisField_0225", Text = "Single damage...",
		PlayFirst = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
				HasAny = { "/VO/ErisField_0221", "/VO/ErisField_0222" }
			},
		},
	},
}
GlobalVoiceLines.ErisFireEscapeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "Eris",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.2,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0326", Text = "Out of the fire!" },
	{ Cue = "/VO/ErisField_0327", Text = "{#Emph}Whew {#Prev}that's hot enough!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0328", Text = "Why don't {#Emph}you {#Prev}jump in the fire for a change?" },
	{ Cue = "/VO/ErisField_0329", Text = "It's warm, you should get in!" },
	{ Cue = "/VO/ErisField_0330", Text = "Hop in, the fire's just fine!" },
	{ Cue = "/VO/ErisField_0331", Text = "Hot air rises!" },
}
GlobalVoiceLines.ErisGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Eris",
	-- SkipCooldownCheckIfNonePlayed = true,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
			Comparison = ">=",
			Value = 0.25,
		},
	},
	Cooldowns =
	{
		{ Name = "ErisSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/ErisField_0263", Text = "What'd you {#Emph}get?" },
	{ Cue = "/VO/ErisField_0264", Text = "I {#Emph}saw {#Prev}that!" },
	{ Cue = "/VO/ErisField_0265", Text = "That was {#Emph}mine!", PlayFirst = true },
	{ Cue = "/VO/ErisField_0266", Text = "Put that {#Emph}back!" },
	{ Cue = "/VO/ErisField_0267", Text = "{#Emph}Really{#Prev}, Trouble?" },
	{ Cue = "/VO/ErisField_0268", Text = "Just leave it?" },
	{ Cue = "/VO/ErisField_0269", Text = "Stop picking things up!" },
	{ Cue = "/VO/ErisField_0270", Text = "{#Emph}Neat-freak!" },
}

OverwriteTableKeys( EnemyData, UnitSetData.Eris )