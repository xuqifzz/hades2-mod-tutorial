UnitSetData.Template =
{
	Template =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 1,

		StunAnimations = 
		{
			Default = "Enemy_Brawler_HitStun",
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions =
		{
			
		},

		GeneratorData =
		{
			DifficultyRating = 1,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Template )