WeaponSetData =
{
	MedeaTeleportOut =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreFireFx = "MedeaTeleportFx",
			PreAttackAnimation = "Enemy_Medea_TeleportOut",
			PreAttackDuration = 0.3,
			FireDuration = 0.1,
			PostAttackDurationMin = 9.0,
			PostAttackDurationMax = 10.5,
			PostAttackAlpha = 0,
			PostAttackAlphaDuration = 0.1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
			},
		},
	},

	MedeaDagger =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ ProjectileName = "MedeaDaggerMelee", AIDataOverrides = { FireFromTarget = false, }, PauseDuration = 0.05 },
				{ ProjectileName = "PoisonPuddle", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -60, OffsetDistance = 275, OffsetScaleY = 0.5, PauseDuration = 0.015 },
				--{ ProjectileName = "PoisonPuddleSmall", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 275, OffsetScaleY = 0.51, PauseDuration = 0.015 },
				{ ProjectileName = "PoisonPuddle", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 275, OffsetScaleY = 0.52, PauseDuration = 0.015 },
				--{ ProjectileName = "PoisonPuddleSmall", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 275, OffsetScaleY = 0.53, PauseDuration = 0.015 },
				{ ProjectileName = "PoisonPuddle", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 275, OffsetScaleY = 0.54, PauseDuration = 0.015, },
			},
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			FireProjectileStartDelay = 0.15,

			PreAttackDuration = 0.65,
			FireDuration = 0.47,
			PostAttackDuration = 0.3,
			PreAttackAnimation = "Enemy_Medea_DaggerPreFire",
			FireAnimation = "Enemy_Medea_DaggerFire",
			PostAttackAnimation = "Enemy_Medea_DaggerPostFire",

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PreAttackRotationDampening = 0.09,
			FireRotationDampening = 0.09,

			AttackDistance = 9999,
			MoveWithinRange = false,

			ChainedWeapon = "MedeaTeleportOut",

			PreMoveTeleport = true,
			TeleportMaxDistance = 200,
			TeleportMinDistance = 50,
			TeleportationInterval = 0,
			TeleportDestinationFx = "MedeaTeleportPreviewFx",
			TeleportAnimation = "Enemy_Medea_TeleportIn",
			TeleportEndFx = "MedeaTeleportFx",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
			},
		},
	},

	MedeaCast =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MedeaRanged",
			FireProjectileStartDelay = 0.3,
			BarrelLength = 100,

			PreAttackDuration = 0.835,
			FireDuration = 0.7,
			PostAttackDuration = 0.3,

			PreAttackAnimation = "Enemy_Medea_CastPreFire",
			FireAnimation = "Enemy_Medea_CastFire",
			PostAttackAnimation = "Enemy_Medea_CastPostFire",

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.3,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			ChainedWeapon = "MedeaTeleportOut",

			PreMoveTeleport = true,
			TeleportMaxDistance = 1000,
			TeleportMinDistance = 600,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Medea_TeleportIn",
			TeleportEndFx = "MedeaTeleportFx",
			TeleportDestinationFx = "MedeaTeleportPreviewFx",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			SpawnAwayFromTypes = "Polyphemus",
			SpawnAwayFromTypesDistance = 600,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/MedeaFire" },
			},
		},
	},

	MedeaCast_NoTeleport =
	{
		InheritFrom = { "MedeaCast", },
		Requirements =
		{
			MaxUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceFirst = true,

			ChainedWeapon = "MedeaTeleportOut",

			PreMoveTeleport = false,
		},
	},

	MedeaCastCombo1 =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "MedeaPlagueVoiceLines" },
			},
		},
		WeaponCombo =
		{
			{ WeaponName = "MedeaComboCast", DataOverrides = { AttackVoiceLines = { { GlobalVoiceLines = "MedeaPlagueVoiceLines" }, }, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 756328, AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 756338, AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 737958, FireProjectileAngle = 150, AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 756324, FireProjectileAngle = 150, AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaTeleportOut", },
		},
	},

	MedeaCastCombo2 =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},
		WeaponCombo =
		{
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 737954, UseTargetId = 756337, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.1, BarrelLength = 0, FireProjectileAngle = "nil", AttackVoiceLines = { { GlobalVoiceLines = "MedeaPlagueVoiceLines" }, }, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 756337, UseTargetId = 737958, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.1, BarrelLength = 0, FireProjectileAngle = "nil", AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 737958, UseTargetId = 756331, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.1, BarrelLength = 0, FireProjectileAngle = "nil", AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 756331, UseTargetId = 737967, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.1, BarrelLength = 0, FireProjectileAngle = "nil", AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaComboCast", DataOverrides = { TeleportToId = 737967, UseTargetId = 737954, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.1, BarrelLength = 0, FireProjectileAngle = "nil", AttackVoiceLines = {}, }, },
			{ WeaponName = "MedeaTeleportOut", },
		},
	},

	MedeaComboCast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MedeaRanged",
			FireProjectileStartDelay = 0.15,
			BarrelLength = 100,

			PreAttackDuration = 0,
			FireDuration = 0.35,
			PostAttackDuration = 0.15,

			FireAnimation = "Enemy_Medea_CastFire",

			AttackDistance = 9999,
			MoveWithinRange = false,

			FireFromSelf = true,
			FireProjectileAngle = 330,
			SetAngleTowardProjectileAngle = true,
			FireProjectileTowardTarget = true,

			PreMoveTeleport = true,
			TeleportToId = 756332,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Medea_TeleportIn",
			TeleportEndFx = "MedeaTeleportFx",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			PostTeleportWait = 0.1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/HecateShockwaveRingSFX" },
				{ Name = "/SFX/Player Sounds/MedeaFire" },
			},
		},
	},

	MedeaCorpseExplode =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
			RequireMinIdsOfTypes = { Names = { "Zombie", "Zombie_Elite" }, Count = 1 },
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			TargetClosestOfTypes = { "Zombie", "Zombie_Elite" },

			NoProjectile = true,
			FireFunctionName = "MedeaCorpseExplode",

			PreAttackDuration = 0.835,
			FireDuration = 0.7,
			PostAttackDuration = 0.3,

			PreAttackAnimation = "Enemy_Medea_CastPreFire",
			FireAnimation = "Enemy_Medea_CastFire",
			PostAttackAnimation = "Enemy_Medea_CastPostFire",

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.3,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			ChainedWeapon = "MedeaTeleportOut",

			PreMoveTeleport = true,
			TeleportMaxDistance = 1200,
			TeleportMinDistance = 650,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Medea_TeleportIn",
			TeleportEndFx = "MedeaTeleportFx",
			TeleportDestinationFx = "MedeaTeleportPreviewFx",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/MedeaFire" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil