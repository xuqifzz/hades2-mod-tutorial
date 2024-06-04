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
		"WeaponAxe",
		"WeaponAxe2",
		"WeaponAxe3",
		"WeaponAxeDash",
		"WeaponAxeSpin",
		"WeaponDagger",
		"WeaponDaggerDash",
	},

	HeroPrimaryWeapons =
	{
		"WeaponStaffSwing",
		"WeaponAxe",
		"WeaponDagger",
		"WeaponTorch",
		"WeaponLob",
	},

	HeroDashWeapons =
	{
		"WeaponDaggerDash",
		"WeaponStaffDash",
		"WeaponAxeDash",
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
		"WeaponAxe",
		"WeaponAxeBlock2",
		"WeaponTorch",
		"WeaponTorchSpecial",
		"WeaponLob",
		"WeaponLobSpecial",
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
		"WeaponDaggerThrow",
		
		"WeaponAxe",
		"WeaponAxe2",
		"WeaponAxe3",
		"WeaponAxeDash",

		"WeaponTorch",
		"WeaponTorchSpecial",
		
		"WeaponLob",
		"WeaponLobSpecial",
	},
	
	HeroAllWeapons =
	{
		"WeaponStaffSwing",
		"WeaponStaffBall",
		"WeaponDagger",
		"WeaponDaggerThrow",
		"WeaponCast",
		"WeaponAxe",
		"WeaponAxeBlock2",
		"WeaponTorch",
		"WeaponTorchSpecial",
		"WeaponLob",
		"WeaponLobSpecial",
	},

	HeroSecondaryWeapons =
	{
		"WeaponStaffBall",
		"WeaponDaggerThrow",
		"WeaponAxeBlock2",
		"WeaponTorchSpecial",
		"WeaponLobSpecial",
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
		"WeaponSpellMeteor",
		"WeaponSpellTimeSlow",
		"WeaponSpellPotion",
		"WeaponSpellLeap",
	},

	HeroTransformWeapons = 
	{
		"WeaponTransformAttack", 
		"WeaponTransformSpecial", 
		"WeaponTransformCast", 
		"WeaponTransformBlink"
	},

	HeroWeaponSets =
	{
		WeaponStaffSwing = { "WeaponStaffSwing2","WeaponStaffSwing3","WeaponStaffSwing5",  "WeaponStaffBall", "WeaponStaffDash" },
		WeaponAxe = { "WeaponAxe2", "WeaponAxe3", "WeaponAxeDash", "WeaponAxeSpin", "WeaponAxeBlock2", "WeaponAxeSpecialSwing"},
		WeaponDagger = {"WeaponDaggerThrow", "WeaponDaggerBlink", "WeaponDaggerDash", "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDouble", "WeaponDaggerMultiStab"},
		WeaponTorch = {  "WeaponTorchSpecial" },		
		WeaponLob = { "WeaponLobSpecial", "WeaponLobChargedPulse", "WeaponSkullImpulse" },
	},

	LinkedWeaponUpgrades =
	{
		WeaponStaffSwing = { "WeaponStaffSwing2","WeaponStaffSwing3","WeaponStaffSwing5", "WeaponStaffDash" },
		WeaponStaffBall = { "WeaponStaffBall2" },
		WeaponDagger = { "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDash", "WeaponDaggerDouble", "WeaponDaggerMultiStab"},
		WeaponDaggerThrow = {},
		WeaponAxe = { "WeaponAxeDash", "WeaponAxe2", "WeaponAxe3", "WeaponAxeSpin"},
		WeaponAxeBlock2 = { "WeaponAxeSpecialSwing" },
		WeaponTorch = {},
		WeaponTorchSpecial = {},
		WeaponLob = { "WeaponLobPulse", "WeaponLobChargedPulse" },
		WeaponLobSpecial = { "WeaponSkullImpulse" },
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
	"ProjectileLob",
	"ProjectileLobCharged",
	"ProjectileTorchBall",
	"ProjectileCast",
	"ApolloCast",
	"DemeterSprintStorm",
	"ProjectileTorchRepeatStrike",
	"ProjectileTorchBallLarge",
	"ProjectileTorchRepeatStrikeLarge",
	"ProjectileTorchSpiral",
	"ProjectileTorchOrbit",
	"ProjectileAxeSpin",
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
	"HadesCerberusAssist",
	"GhostWall",
	"SafeZoneDefense",
	"SafeZonePulse",
	"ScyllaCone",
	"OilPuddleFire",
	"OilPuddleFire02",
	"OilPuddleFire03",
	"OilPuddleFire04",
	"OilPuddleSlick",
	"OilPuddleSlick02",
	"OilPuddleSlick03",
	"OilPuddleSlick04",
	"SheepSickAura",
	},
	ExpireProjectileLastStandExcludeProjectileNames = 
	{
		"ProjectileSpellMeteor",
		"ChronosGrindWall",
		"ChronosGrindVacuum",
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
		CatFamiliar = true,
		FrogFamiliar = true,
	}
}