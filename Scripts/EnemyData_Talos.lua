UnitSetData.Talos =
{
	Talos =
	{
		InheritFrom = { "BaseBossEnemy", "BaseAutomaton","BaseVulnerableEnemy" },
		
		BlockRaiseDead = true,
		IsBoss = false,
		BlockCharm = true,
		IgnoreSpeedShrine = true,
		ImmuneToPolymorph = true,

		MaxHealth = 13300,
		HealthBarTextId = "Talos_Full",

		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "TalosDefeatedMessage", StartPanTime = 1.0, EndPanTime = 4.25, EndAngle = 270, FlashRed = true, PanZoomFraction = 1.0, MessageDelay = 0.5, EndMusicEarly = true, },

		DeathAnimation = "Enemy_Talos_Death",
		DeathPanOffsetY = -220,
		DeathAngle = 270,

		IsAggroedSound = "/SFX/Enemy Sounds/Talos/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Talos/EmoteDying",

		Groups = { "FlyingEnemies", "Automatons" },

		Material = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "InvincibleHitSpark",
		InvulnerableHitImpactVelocity = 1000,
		
		StunAnimations = 
		{
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			--"TalosSprint"
			"TalosShieldThrow", "TalosShieldStraightThrowSelector", "TalosMagnet", "TalosSpin", "TalosSprint",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AISetupDelay = 1.5,

		GeneratorData =
		{
			DifficultyRating = 500,
		},
	},

	--[[
	Talos_Shadow =
	{
		InheritFrom = { "Shadow", "Talos", },
		GenusName = "Talos",

		MaxHealth = 1000,
		HealthBuffer = 1500,
		HealthBarOffsetY = -250,
		HealthBarType = "Medium",

		WeaponOptions =
		{
			"TalosSpin_Shadow",
		},
	},
	]]

}

OverwriteTableKeys( EnemyData, UnitSetData.Talos )