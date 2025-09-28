OverwriteTableKeys( ProjectileData, {

	-- Base
	RubbleColorProjectile =
	{
		DamageTextStartColor = Color.WallSlamDamageLight,
		DamageTextColor = Color.WallSlamDamage,
	},
	RubbleFall =
	{
		InheritFrom = { "RubbleColorProjectile" },

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 20.0,
			},
			{
				ObstacleMultiplier = 0.0,
			},
		},

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},

		KillingEnemyVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				PreLineWait = 0.45,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.1,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "Health" },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I_MiniBoss01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "MelinoeTrapKillSpeech", Time = 80 },
				},
				TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

				{ Cue = "/VO/MelinoeField_2199", Text = "You'll rot here." },
				{ Cue = "/VO/MelinoeField_2201", Text = "Die with your master!" },
				{ Cue = "/VO/MelinoeField_2202", Text = "I'll bury you." },
				{ Cue = "/VO/MelinoeField_2200", Text = "Hades take you!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
						},
					}
				},
			},
		},
	},
	RubbleFallLarge =
	{
		InheritFrom = { "RubbleColorProjectile" },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	RubbleFallElysium =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	ShadeMercSpiritball =
	{
		CheckProjectileDeath = true,
		HealthTickDamage = 1,
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	ShadeMercAspectSpiritball =
	{
		InheritFrom = { "ShadeMercSpiritball" }
	},
	ShovelPointBomb =
	{

	},

	-- Elite attributes
	EliteRift =
	{
		Fuse = 1.2,
		ReticleAnimation = "ChronosRiftStraightInteriorIn",
		ReticleUseProjectileAngle = true,
		ReticleGroupName = "FX_Standing_Top",
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},

	EliteBoltOrbit =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	EliteRadialBeam =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	-- BiomeF
	DestructibleTreeSplinter =
	{
		HitPresentationIgnoresOwnership = true,
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0.0 },
			--{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.10 },
		},
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},
	},
	SafeZoneDefense =
	{

	},
	SafeZonePulse =
	{

	},
	CocoonSpawnBlast =
	{

	},

	-- BiomeG
	SteamTrap =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamTrapFast =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamWallBlast =
	{
		DamagedFx = "PlayerBurnDamage",
		
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 10,
			}
		},

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamCubeExplosion =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0.0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	MineBlast =
	{
		HealthTickDamage = 10,
	},
	BloodMineToss =
	{

	},
	FloodTrapWeapon = 
	{
		ExpireOldestCap = 20,

		TriggersPlayerOnHitPresentation = true,
		PresentationOnlyOnPlayerHit = true,
		HitScreenshake = { Distance = 5, Speed = 500, Duration = 0.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	FloodTrapWeapon2 =
	{
		InheritFrom = { "FloodTrapWeapon" },

		CollideWithGroups =
		{
			"HeroTeam",
		},
	},

	-- BiomeH
	FieldsDestructiblePillarDestruction =
	{
		KillingEnemyVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			ChanceToPlay = 0.2,
			--SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapKillSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1141", Text = "Stay far away." },
			{ Cue = "/VO/MelinoeField_1142", Text = "Don't you come near me." },
			{ Cue = "/VO/MelinoeField_1252", Text = "Out with you all...!" },
			{ Cue = "/VO/MelinoeField_1253", Text = "Lie in ruin." },
			{ Cue = "/VO/MelinoeField_1254", Text = "Back off." },
			{ Cue = "/VO/MelinoeField_1255", Text = "Back." },
		},
	},
	ThornTreeThorn =
	{
	},
	Miasma = 
	{
		ExpireOldestCap = 16,
		BypassRetaliate = true,
	},
	BrambleTrap =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	GhostWall =
	{

	},

	-- BiomeI
	TimeTrapStasis =
	{
		Fuse = 0.25,
		--ReticleAnimation = "BlastWarningDecal",
	},
	SpikeTrapWeapon =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
	BeamTrap =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	-- BiomeN
	FireBarrelExplosion =
	{
		CanIgnite = true,
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.02, Fraction = 0.07, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	FireBarrelExplosionShips =
	{
		InheritFrom = { "FireBarrelExplosion" },
	},
	FireBarrelFireLob =
	{
	},
	SoulPylonSpiritball =
	{
	},
	BattleStandardAoE =
	{
		OnHitFunctionNames = { "AddEnemyHitShield",  },
	},

	-- BiomeO
	DestructibleMastSplinter =
	{
		HitPresentationIgnoresOwnership = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.16, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.07, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.10 },
		},
	},

	OilPuddleFire =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire02 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire03 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire04 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFireFlying =
	{
		InheritFrom = { "BaseFireZone" },
		OnHitFunctionNames =
		{
			"CheckBurningHitReaction",
		},
		
		CanIgnite = true,
	},
	OilPuddleFire02Flying =
	{
		InheritFrom = { "BaseFireZone" },
		OnHitFunctionNames =
		{
			"CheckBurningHitReaction",
		},
		
		CanIgnite = true,
	},
	OilPuddleFire03Flying =
	{
		InheritFrom = { "BaseFireZone" },
		OnHitFunctionNames =
		{
			"CheckBurningHitReaction",
		},
		
		CanIgnite = true,
	},
	OilPuddleFire04Flying =
	{
		InheritFrom = { "BaseFireZone" },
		OnHitFunctionNames =
		{
			"CheckBurningHitReaction",
		},
		
		CanIgnite = true,
	},

	OilPuddleSlick =
	{
		CollideWithGroups = { "HeroTeam", "EnemyTeam", },
	},
	OilPuddleSlick02 =
	{
		InheritFrom = { "OilPuddleSlick" },
	},
	OilPuddleSlick03 =
	{
		InheritFrom = { "OilPuddleSlick" },
	},
	OilPuddleSlick04 =
	{
		InheritFrom = { "OilPuddleSlick" },
	},

	ShipsBombardment =
	{
		ReticleAnimation = "BlastWarningDecal",

		Fuse = 3.0,
		WanderToOwner = true,
		WanderOwnerDetonateBuffer = 0.35,
		WanderSpeed = 80.0,
		WanderRadius = 200,
		WanderTickMin = 0.75,
		WanderTickMax = 1.25,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	-- BiomeP
	IcicleSplinter =
	{
	},
	RubbleFallOlympus =
	{
		SkipAggro = true,
		HitScreenshake = { Distance = 4, Speed = 400, Duration = 0.25, FalloffSpeed = 3000 },
		ImpactReactionHitsOverride = 0,

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 3.0,
			},
			{
				ObstacleMultiplier = 0.0,
			},
		},
	},
	HeroSkyTouchdown =
	{
		HealthTickDamage = 999,
		SkipDamageText = true,
		KillPresentationCombatTextEnemyTeam = "LeapKill",

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.11, Fraction = 0.37, Duration = 0.38 },
		},

		HitScreenshake = { Distance = 8, Speed = 400, Angle = 90, FalloffSpeed = 1000, Duration = 0.38 },
		
		SimSlowDistanceThreshold = 290,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.10 },
		},
	},

	ZeusStatueChasingStorm =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFireball =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HestiaStatueFireRing =
	{

	},

	PoseidonStatueWave =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	DemeterStatueFrostStorm =
	{

	},

	-- BiomeQ
	TyphonSpike =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
	TyphonSpikeSplinter =
	{

	},
	EyeBombImpact =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
	EyeBombExplosion =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
	TyphonEggExplosion =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0 },
		},
	},
	TyphonEggExplosionLarge =
	{
	},

	-- Asphodel
	LavaTileWeapon =
	{
		OnHitFunctionNames = { "CheckLavaPresentation", },
		IgnoreOnHitEffects = true,
		DamagedFx = "PlayerBurnDamage",
	},
	LavaTileTriangle01Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaTileTriangle02Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaPuddleLarge =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	SmokeTrapWeapon = 
	{
		OnHitFunctionNames = { "HitBySmokeTrapWeaponPresentation",  },
	},
	BlastCubeExplosion =
	{
		ImpactReactionHitsOverride = 5,
	},
	CerberusMagmaPuddle  =
	{
		InheritFrom = { "LavaTileWeapon", },
	},

})