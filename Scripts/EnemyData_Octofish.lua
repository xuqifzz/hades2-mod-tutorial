UnitSetData.Octofish =
{

	Octofish =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },

		ActivateAnimation = "Enemy_Octofish_Spawn",
		ActivateDuration = 0.9,
		WakeUpDelay = 0.15,
		MaxHealth = 300,

		HealthBarOffsetY = -200,
		HealthBarType = "MediumLarge",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetalRapid",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},

		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Jellyfish/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/Jellyfish/EmoteDying",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Octofish_OnHit",
			Heavy = "Enemy_Octofish_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},

		WeaponOptions =
		{
			"OctofishSpin", "OctofishInk"
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"OctofishSpin_Ally",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"Octofish_Elite"}
		},
	},

	Octofish_Elite =
	{
		InheritFrom = { "Elite", "Octofish" },
		HealthBuffer = 300,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"Octofish"}
		},
	},

	Octofish_Miniboss =
	{
		InheritFrom = { "Elite", "Octofish" },
		RunHistoryKilledByName = "Octofish_Miniboss",
		MaxHealth = 500,
		HealthBuffer = 3000,
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -140,
		HealthBarType = "ExtraLarge",
		
		BlockRespawnShrineUpgrade = true,
		BlockRaiseDead = true,
		IsBoss = false,
		BlockCharm = true,
		IgnoreSpeedShrine = true,
		IgnoreSprintPhasingStasisStun = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockEnemyTypes = {"Octofish"}
		},
	},

	Octofish_Shadow =
	{
		InheritFrom = { "Shadow", "Octofish_Miniboss" },
	},


	Octofish_SuperElite =
	{
		InheritFrom = { "SuperElite", "Octofish_Miniboss" },
		MaxHealth = 1000,
		HealthBuffer = 5000,
		BlockRaiseDead = false,
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Octofish )

WeaponSetData =
{
	OctofishSpin =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OctofishSpin",

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 5.4,
						Modifier = 0.1,
					}
				},
			},

			FireTicks = 10,
			FireInterval = 0.36,
			FireSelfVelocity = 400,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Octofish_StingPreFire",
			FireAnimation = "Enemy_Octofish_StingFireLoop",
			PostAttackAnimation = "Enemy_Octofish_StingPostFire",
			
			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Jellyfish/HellifishMiniBossSpinLoop",

			PreAttackDuration = 1.28,
			FireDuration = 0.0,
			PostAttackDuration = 3.0, -- anim is 1.65

			PostAttackSelfUpwardVelocity = 2000,
			PostAttackSelfVelocity = 1000,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,
		},
	},
	OctofishSpin_Ally =
	{
		InheritFrom = { "OctofishSpin" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,
		},
	},

	OctofishInk =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "OctofishInkRanged",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Octofish_InkPreFire",
			FireAnimation = "Enemy_Octofish_InkFire",
			PostAttackAnimation = "Enemy_Octofish_InkPostFire",

			PreAttackDuration = 0.7,
			FireDuration = 0.5,
			PostAttackDuration = 0.8, -- anim is 0.6
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil