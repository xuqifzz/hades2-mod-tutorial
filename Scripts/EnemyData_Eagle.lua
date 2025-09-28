UnitSetData.Eagle =
{
	Eagle =
	{
		InheritFrom = { "BaseVulnerableEnemy"},
		GenusName = "Prometheus",
		RequiredKill = false,

		Groups = { "FlyingEnemies" },
		MaxHealth = 8000,
		CannotDieFromDamage = true,
		HideHealthBar = true,

		Material = "Organic",

		ComboPartnerName = "Prometheus",
		PreBossAISetupFunctionName = "EagleBattleStart",

		SpawnAnimation = "Enemy_Eagle_Invisible",

		OnDamagedFunctionName = "CheckEagleRetreat",

		MoneyDropOnDeath = { Chance = 0 },

		DefaultAIData =
		{
			OlympusStartWeapon = "EagleDive_Olympus",
			OlympusEndWeapon = "EagleFlyUpWhirlwind_Olympus",
			OlympusWeaponOptions = { "EagleRollLeft_Olympus", "EagleRush_Olympus", "EagleRush_Olympus", "EagleRollRight_Olympus" },
			OlympusWeaponCountMin = 3,
			OlympusWeaponCountMax = 5,
		},
		WeaponOptions = { "EagleFlyUp", "EagleDive_Solo" },
		Using =
		{
			Weapons =
			{
				"EagleDive_Olympus",
				"EagleFlyUpWhirlwind_Olympus",
			},

			Sounds =
			{
				"/SFX/Enemy Sounds/EagleCall",
				"/SFX/Enemy Sounds/EagleAlerted",
				"/SFX/Enemy Sounds/EagleAttackScream",
			},
		},

		AIOptions =
		{
			"AttackerAI",
		},

		FledVoiceLines =
		{
			UsePlayerSource = true,
			PlayOnce = true,
			PlayOnceContext = "EagleFirstExitVO",
			PreLineWait = 0.75,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0988", Text = "Flew off...", PlayFirst = true },
		},

		OnKillVoiceLines =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
					Comparison = ">=",
					Value = 0.2,
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.66,
				ObjectType = "Prometheus",
				TriggerCooldowns = { "PrometheusSpokeRecently" },

				{ Cue = "/VO/Prometheus_0232", Text = "Aetos!" },
				{ Cue = "/VO/Prometheus_0233", Text = "Aetos, retreat!" },
				{ Cue = "/VO/Prometheus_0234", Text = "Fly, Aetos!" },
				{ Cue = "/VO/Prometheus_0235", Text = "Away, Aetos!" },
				{ Cue = "/VO/Prometheus_0236", Text = "Get out, Aetos!" },
				{ Cue = "/VO/Prometheus_0237", Text = "I have this, Aetos!" },
				{ Cue = "/VO/Prometheus_0238", Text = "Leave this to me, Aetos!" },
				{ Cue = "/VO/Prometheus_0239", Text = "How dare you." },
				{ Cue = "/VO/Prometheus_0240", Text = "You'll regret that!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Prometheus_0213" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0241", Text = "I'll get you for that." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.5,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Boss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "Prometheus", }, Alive = true },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
				},
				{ Cue = "/VO/MelinoeField_2804", Text = "Blasted bird..." },
				{ Cue = "/VO/MelinoeField_2805", Text = "Got you, Eagle!" },
				{ Cue = "/VO/MelinoeField_2806", Text = "Bye, Aetos." },
				{ Cue = "/VO/MelinoeField_2807", Text = "Fly on home!" },
			}
		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Eagle )