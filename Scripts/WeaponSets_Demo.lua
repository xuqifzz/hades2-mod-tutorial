WeaponSets =
{
	RubbleWeapons =
	{
		"RubbleFall",
		"RubbleFallLarge",
		"RubbleFallElysium"
	},
	HeroBlinkWeapons = 
	{
		"WeaponBlink",
	},
	HeroRushWeapons =
	{
		"WeaponBlink",
		"WeaponSprint",
	},

	HeroMeleeRangeWeapons =
	{
		"WeaponStaffSwing",
		"WeaponStaffSwing2",
		"WeaponStaffSwing3",
		"WeaponStaffSwing5", 
		"WeaponStaffDash",
		"WeaponDagger",
		"WeaponDaggerDash",
	},

	HeroPrimaryWeapons =
	{
		"WeaponStaffSwing",
		"WeaponDagger",
	},

	HeroDashWeapons =
	{
		"WeaponDaggerDash",
		"WeaponStaffDash",
	},

	HeroRangedWeapons =
	{
		"WeaponCast",
		"WeaponCastProjectileHades",
		"WeaponCastProjectile",
		"WeaponAnywhereCast",
	},

	HeroPrimarySecondaryWeapons =
	{
		"WeaponStaffSwing",
		"WeaponStaffBall",
		"WeaponDagger",
		"WeaponDaggerThrow",
	},

	HeroNonExWeapons =
	{
		"WeaponStaffSwing",
		"WeaponStaffSwing2",
		"WeaponStaffSwing3",
		"WeaponStaffDash",
		"WeaponStaffBall",

		"WeaponDagger",
		"WeaponDagger2",
		"WeaponDaggerDouble",
		"WeaponDaggerMultiStab",
		"WeaponDaggerDash",
		"WeaponDaggerThrow"
	},
	
	HeroAllWeapons =
	{
		"WeaponStaffSwing",
		"WeaponStaffBall",
		"WeaponDagger",
		"WeaponDaggerThrow",
		"WeaponCast",
	},

	HeroSecondaryWeapons =
	{
		"WeaponStaffBall",
		"WeaponDaggerThrow",
	},

	HeroNonPhysicalWeapons =
	{
		"WeaponCast",
	},

	HeroSpellWeapons = 
	{
		"WeaponSpellPolymorph",
		"WeaponSpellLaser",
		"WeaponSpellSummon",
		"WeaponSpellTimeSlow",
		"WeaponSpellPotion",
		"WeaponSpellLeap",
	},

	HeroTransformWeapons = 
	{
	},

	HeroWeaponSets =
	{
		WeaponStaffSwing = { "WeaponStaffSwing2","WeaponStaffSwing3","WeaponStaffSwing5",  "WeaponStaffBall", "WeaponStaffDash" },
		WeaponDagger = {"WeaponDaggerThrow", "WeaponDaggerBlink", "WeaponDaggerDash", "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDouble", "WeaponDaggerMultiStab"},
	},

	LinkedWeaponUpgrades =
	{
		WeaponStaffSwing = { "WeaponStaffSwing2","WeaponStaffSwing3","WeaponStaffSwing5", "WeaponStaffDash" },
		WeaponStaffBall = { "WeaponStaffBall2" },
		WeaponDagger = { "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDash", "WeaponDaggerDouble", "WeaponDaggerMultiStab"},
		WeaponDaggerThrow = {},
		WeaponBlink = { "WeaponSprint" },
		WeaponCast = { "WeaponCastArm" },
	},

	TrapWeapons =
	{
		"ExplosiveBlast",
		"BlastCubeExplosion",
		"DartTrapWeapon",
		"SpikeWallWeapon",
		"SpikeTrapWeapon",
		"SmokeTrapWeapon",
		"LavaSplash",
		"LavaPuddleLarge",
	},
	EnemyMagicWeapons =
	{
		"LightningAura",
	},
	EnemyCollisionWeapons =
	{
		"BaseCollisionWeapon"
	},
	TimeSlowExpireProjectileExcludeProjectileNames = --merged with below in rundata
	{
		"ProjectileStaffBall",
		"ProjectileStaffBallCharged",
		"ProjectileCast",
		"ApolloCast",
		"DemeterSprintStorm",
	},
	ExpireProjectileExcludeProjectileNames =
	{
		"AresProjectile",
		"AthenaDeflectingProjectile",
		"DemeterProjectile",
		"GunGrenadeToss",
		"GunGrenadeSelfDamage",
		"ConsecrationField",
		"DionysusLobProjectile",
		"DionysusField",
		"ArtemisProjectile",
		"ArtemisSuperProjectile",
		"AphroditeSuperCharm",
		"AphroditeMaxSuperCharm",
		"DemeterSuper",
		"DemeterMaxSuper",
		"TheseusSpearThrow ",
		"TheseusSpearThrowReturn",
		"LavaTileWeapon",
		"LavaTileTriangle01Weapon",
		"LavaTileTriangle02Weapon",
		"NPC_FurySister_01_Assist",
		"NPC_Thanatos_01_Assist",
		"ThanatosDeathCurseAoE",
		"NPC_Sisyphus_01_Assist",
		"TheseusSpearThrow",
		"HadesCastBeam",
		"HadesCastBeamNoTracking",
	},
	ExpireProjectileLastStandExcludeProjectileNames = 
	{
	},
	MapTransitionExpireProjectileExcludeNames = 
	{
	"DemeterSuper",
	"DemeterMaxSuper",
	"DionysusLobProjectile",
	"TheseusSpearThrow ",
	"TheseusSpearThrowReturn",
	"LavaTileWeapon",
	"LavaTileTriangle01Weapon",
	"LavaTileTriangle02Weapon",
	"NPC_FurySister_01_Assist",
	"NPC_Thanatos_01_Assist",
	"NPC_Sisyphus_01_Assist",
	"TheseusSpearThrow",
	"HadesCastBeam",
	"HadesCastBeamNoTracking"
	},

	LavaWeaponNames = 
	{
		"LavaTileWeapon",
		"LavaTileTriangle01Weapon",
		"LavaTileTriangle02Weapon",
		"LavaSplash",	
	},
}

UnitSets = 
{
	PlayerSummons = 
	{
		NPC_Thanatos_Field_01 = true,
		SwarmerSummon = true,
		SummonSelfDestruct = true,
	}
}