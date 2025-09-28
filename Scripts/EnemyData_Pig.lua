UnitSetData.Pig =
{
	Pig =
	{
		InheritFrom = { "IsNeutral", "BaseVulnerableEnemy" },
		RequiredKill = false,

		MaxHealth = 99999,
		HideHealthBar = true,

		UseActivatePresentation = false,

		OnDeathThreadedFunctionName = "SpawnSheepGhost",

		OnDamagedFunctionName = "PigHit",
		PigHitVelocity = 750,
		IsAggroedSound = "/SFX/Object Ambiences/PigSFXOnHit",
		--DeathSound = "/SFX/Enemy Sounds/Sheep/EmoteDying",
   		DeathAnimation = "Blank",
   		DeathFx = "SheepDisappearFx",
		Material = "Shell",

		CollisionReactions = {},

		StunAnimations = 
		{
			Default = "Enemy_Pig_OnHit",
			Heavy = "Enemy_Pig_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			LiveOffsetDistance = 100,
			PostMoveIdleDuration = 3.0,
		},

		WeaponOptions = { "PigSkip" },

		AIAggroRange = 0,
		AIWanderFrequency = 4.0,
		AggroAIRefreshDurationMin = 0.0,
		AggroAIRefreshDurationMax = 5.0,

		AIOptions =
		{
			"AggroAI",
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.55,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "NPC_Circe_01",
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CirceSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/Circe_0166", Text = "They're enchanted!", PlayFirst = true },
			{ Cue = "/VO/Circe_0167", Text = "Look at them {#Emph}go!" },
			{ Cue = "/VO/Circe_0168", Text = "I think they like you!" },
			{ Cue = "/VO/Circe_0170", Text = "{#Emph}Oh{#Prev}, stop." },
			{ Cue = "/VO/Circe_0171", Text = "{#Emph}Poor {#Prev}piggies!" },
			{ Cue = "/VO/Circe_0169", Text = "{#Emph}Behave {#Prev}yourselves!",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_1886" },
					},
				},
			},
		},
	},

	PigAngry =
	{
		InheritFrom = { "Pig" },
	},

	PigSad =
	{
		InheritFrom = { "Pig" },
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Pig )


WeaponSetData =
{
	PigSkip =
	{
		AIData =
		{
			DeepInheritance = true,
			SkipCanAttack = true,

			FireSelfVelocity = 1100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireTicksMin = 2,
			FireTicksMax = 5,
			FireInterval = 0.4,
			ResetTargetPerTick = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistance = 500,
			DeaggroAfterAttack = true,

			--PreAttackAnimation = "Enemy_Sheep_DashPreFire",
			FireAnimation = "Enemy_Pig_Dash_Start",
			--PostAttackAnimation = "Enemy_Sheep_DashReturnToIdle",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil