EnemyUpgradeData =
{
	HeroRegen =
	{
		ScreenPanel = "Easier",
		MetaPointMultiplier = -1.0,
		PropertyChanges =
		{

		},
	},

	EnemySpeedReduction =
	{
		ScreenPanel = "Easier",
		MythPointAddition = -1.0,
		PropertyChanges =
		{
			{
				LuaProperty = "SpeedMin",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
			{
				LuaProperty = "SpeedMax",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
		},
	},

	EnemyVolumeReduction =
	{
		ScreenPanel = "Easier",
		MoneyMultiplier = -1.0,
		SpawnMultiplier = 0.5,
		PropertyChanges =
		{

		},
	},

	SampleUpgrade8 =
	{
		ScreenPanel = "Different",
		PropertyChanges =
		{

		},
	},

	SampleUpgrade9 =
	{
		ScreenPanel = "Different",
		PropertyChanges =
		{

		},
	},


	-- God Boon Devotion / Spurn Upgrades --

	ZeusUpgrade =
	{
		UpgradeString = "LtUpgrade_Zeus",
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = { },
	},

	ArtemisUpgrade =
	{
		UpgradeString = "LtUpgrade_Artemis",
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = { },
	},

	AphroditeUpgrade =
	{
		UpgradeString = "LtUpgrade_Aphrodite",
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = {	},
	},

	PoseidonUpgrade =
	{
		UpgradeString = "LtUpgrade_Poseidon",
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = {	},
	},

	DemeterUpgrade =
	{
		UpgradeString = "LtUpgrade_Dionysus",
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = {	},
	},

}
