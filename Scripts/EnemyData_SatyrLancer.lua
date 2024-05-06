UnitSetData.SatyrLancer =
{
	SatyrLancer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		ActivateAnimation = "Enemy_SatyrLancer_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_SatyrLancer_Death",

		MaxHealth = 990,
		HealthBarOffsetY = -220,
		HealthBarType = "MediumLarge",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteDying",
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,
		},
		
		StunAnimations = 
		{
			Default = "Enemy_SatyrLancer_OnHit",
			Heavy = "Enemy_SatyrLancer_OnHit_Heavy",
		},

		InvulnerableFx = "SatyrShielded",
		InvulnerableHitFx = "SatyrShieldBlock",
		--AdditionalAIFunctions = { "HandleUnitDefenseApply" },
		--OnHitFunctionName = "CheckUnitInvulnerableHit",
		--DefenseCooldown = 10.0,
		--DefenseWeapon = "SatyrLancerDefense",
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		WeaponOptions =
		{
			"SatyrLancerThrust", "SatyrLancerThrow",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},

		ActiveCapWeight = 1,
		GeneratorData =
		{
			DifficultyRating = 120,
			BlockEnemyTypes = {"SatyrLancer_Elite"}
		},

		EnemySightedVoiceLines =
		{
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				GameStateRequirements = 
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
				},
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_1631", Text = "Hoplites!" },
				{ Cue = "/VO/MelinoeField_1632", Text = "Hoplites...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1633", Text = "Those Hoplites." },
				{ Cue = "/VO/MelinoeField_1634", Text = "More Hoplites..." },
			},
			[2] = GlobalVoiceLines.SatyrsSightedVoiceLines,
		},

	},

	SatyrLancer_Elite =
	{
		InheritFrom = { "Elite", "SatyrLancer" },
		HealthBuffer = 790,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"SatyrLancerThrust_Elite", "SatyrLancerThrow_Elite",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},

		GeneratorData =
		{
			DifficultyRating = 220,
			BlockEnemyTypes = {"SatyrLancer"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrLancer )