OverwriteTableKeys( WeaponData, 
{
	-- Lob weapons
	WeaponLob =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		GrannyModel = "WeaponLob_Mesh",
		EquippedKitAnimation = "WeaponLobFloatingIdleOff",
		UnequippedKitAnimation = "WeaponLobFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponLobFloatingIdleVertical",
		BountyScreenKitAnimation = "WeaponLobIdle",
		--FirstTimeWeaponFire = "WeaponDaggerDouble",
		FirstTimeEquipAnimation = "Melinoe_Lob_Equip",
		--FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		NoBountyAvailableText = "ShrineScreen_NoBountyAvailable_Lob",
		UnlockName = "WeaponLob_Unlock",
		--DashWeapon = "WeaponDaggerDash",
		--ExpireDashWeaponOnDash = true,
		DummyTraitName = "DummyWeaponLob",
		
		NoAmmoText = "Hint_OutOfLobAmmo",
		NoAmmoVoiceLines = HeroVoiceLines.WeaponLobOutOfAmmoVoiceLines,

		CompleteObjectivesOnFire = { },
		CompleteObjectivesOnStagedFire = { },

		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Lob_Idle",
			["MelinoeDashStart"] = "Melinoe_Lob_Dash_Start",
			["MelinoeDash"] = "Melinoe_Lob_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Lob_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Lob_Run_Start",
			["MelinoeRun"] = "Melinoe_Lob_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Lob_Run_End",
			["MelinoeGetHit"] = "Melinoe_Lob_GetHit",
			["Melinoe_GetHit_LastStand"] = "Melinoe_Lob_GetHit_LastStand",

			["Melinoe_Cast_Start"] = "Melinoe_Lob_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Lob_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Lob_Cast_Fire",
			["Melinoe_Cast_End"] = "Melinoe_Lob_Cast_End",			
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Lob_Cast_Fire_Quick",

			["Melinoe_CrossCast_Start"] = "Melinoe_Lob_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Lob_ForwardCast_Unequip",

			["MelinoeEquip"] = "Melinoe_Lob_Equip",
			["MelinoeActionIdle"] = "Melinoe_Lob_Idle",
			["MelinoeInteract"] = "Melinoe_Lob_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Lob_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Lob_Unequip",
		WeaponInteractAnimation = "Melinoe_Lob_Interact",

		SkipAttackNotReadySounds = true,

		SecondaryWeapon = "WeaponLobSpecial",
		ShowAmmoUI = true,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5, 
		OnProjectileDeathFunction = "WeaponLobAmmoDrop",
		OnProjectileDeathFunctionArgs = 
		{
			CollideForces = 
			{
				UpwardForceMin = 200,
				UpwardForceMax = 220, 
				ForceMin = 840,
				ForceMax = 880,
				Scatter = 45,
			},
			DropForces = 
			{
				UpwardForceMin = 435,
				UpwardForceMax = 445,
				ForceMin = 500,
				ForceMax = 530,
				Scatter = 0,
			},
		},
		NotReadyText = "OutOfAmmo",
		NotReadyAmmoPackText = "RetrieveAmmo",
		NoAmmoFunctionName = "RangedFailedNoAmmoPresentation",
		AmmoPackName = "LobAmmoPack",
		CheckPostFireFail = true,
		MaxAmmo = 4,

		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
			{
				WeaponProperty = "Cooldown",
			},
			{
				EffectName = "Lob1DisableCancellable",
				EffectProperty = "Duration",
			},
		},

		StartRoomEvents = 
		{
			{
				FunctionName = "ReloadAmmo",
				Args = {}
			},
		},
		PostWeaponUpgradeScreenFunctionName = "ResetAmmo",
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.3, Duration = 0.06 },
		},
		
		ShowManaIndicator = true,
		IgnoreOOMAimlineAlpha = true,
		HideChargeDuration = 0.2,
		HideChargeDurationIncludesBlinkDuration = true,

		OnChargeFunctionNames = { "DoWeaponCharge", "TriggerLockForSpecial" },
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyLobCharge",
			OnStageReachedFunctionName = "LobChargeStage",
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 10,
				Wait = 0.55,
				ExChargeAnimationDelay = 0.06,
				ExChargeAnimation = "Melinoe_Lob_AttackEx1_Start",
				EarlyPropertySwaps = 
				{
					Delay = 0.2,
					SwapProperties = 
					{
						WeaponProperties =
						{
							TargetReticleAnimation = "LobEXProjectileReticle",
							AutoLock = false,
      						ShowFreeAimLine = true,
							ReticleRadiusOverride = 530,
							WeaponRange = 505,
						},
					},
				},
				WeaponProperties = 
				{ 
					Projectile = "ProjectileLobCharged",
					FireGraphic = "Melinoe_Lob_AttackEx1_Fire",
					FireFx = "DashDustPuffReverseLarge",
      				SelfVelocity = 0,
					AdditionalProjectileWaveChance = 0,
				},
				CompleteObjective = "WeaponLobCharged",
				ChannelSlowEventOnStart = true
			},
		},

		--[[
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.3, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.07 },
		},
		]]

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelinoeSkullsChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				},
			},			
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/HelEmoteAttacking1" },
			},
			FireStageSounds = 
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelSkullsOmegaAttackStart" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/GunBulletOrganicImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},

		EquipVoiceLines =
		{
			{ GlobalVoiceLines = "MiscWeaponEquipVoiceLines" },
			{ GlobalVoiceLines = "SkellyWeaponEquipReactionVoiceLines" },
		},
	},

	WeaponLobSpecial =
	{
		StartingWeapon = false,
		SkipAttackNotReadySounds = true,		
		CompleteObjectivesOnStagedFire = { "WeaponLobSpecialCharged" },
		CompleteObjectivesOnNonStagedFire = {},
		CompleteObjectivesOnFire = {},

		CustomManaIndicatorOffsetY = -210,
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.17 },
		},

		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		MagnetismMultiplier = 3.8,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 1,
		MinSimSpeedAdjustValue = 0.25,
		ShowManaIndicator = true,
		IgnoreOOMAimlineAlpha = true,
		HideChargeDuration = 0.35,
		ScaledFireEndEffects = { "LobWeaponSpecialDisable", "LobWeaponSpecialDisableCancellable", "LobWeaponSpecialRotateLock" },
		OnFiredFunctionNames = { "RecordWeaponCharge", },
		OnChargeFunctionNames = { "DoWeaponCharge", "AllowLobLock" },
		IsExWithMapStateVariable = "ThrowWeaponDeferred",
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyThrowCharge",
			OnStageReachedFunctionName = "ThrowChargeStage",
		},
		Using = { Effect = "LobWeaponInvulnerable" },
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 20,
				Wait = 0.8,
				AnimOnComplete = "Melinoe_Lob_Special1Ex_StartTransition",
				WeaponProperties = 
				{ 
					FireGraphic = "Melinoe_Lob_Special1Ex_Fire",
					BlinkDetonateOnInterval = 9999,
					BlinkDetonateAtOrigin = false,
					AimLineWidthOverride = 300,
				},
				ChannelSlowEventOnStart = true,
				DeferRevert = true,
				SkipManaSpendOnFire = true,
			},
		},

		HitSimSlowCooldown = 0.05,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.15, LerpTime = 0 },			
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
		--[[ Shield for reference
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},	]]	

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Enemy Sounds/Hades/HadesSkullPreAttack",
					StoppedBy = { "TriggerRelease" }
				},
				{
					Name = "/SFX/Enemy Sounds/Hades/HadesLaserBlastChargeUp" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				},
				{ Name = "/SFX/Player Sounds/MelSkullsDash" },
				{
					Name = "/VO/MelinoeEmotes/EmoteAttackingDaggerThrow",
					Cooldown = 0.5
				},
			},
			FireStageSounds = 
			{
				{ Name = "/SFX/Player Sounds/MelSkullsOmegaSpecialFire" },
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
		
		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "BlinkDuration",
			},
			{
				WeaponProperty = "ChargeTime",
			},
			{
				WeaponProperty = "ClipRegenInterval",
			},
		},
		Upgrades = { },
	},
	WeaponLobGun =
	{
		StartingWeapon = false,
		SkipAttackNotReadySounds = true,		
		CompleteObjectivesOnStagedFire = { "WeaponLobSpecialCharged" },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.17 },
		},

		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 1,
		MinSimSpeedAdjustValue = 0.25,
		ShowManaIndicator = true,
		IgnoreOOMAimlineAlpha = true,
		HideChargeDuration = 0.35,
		OnChargeFunctionNames = { "DoWeaponCharge", },
		CustomChannelSlowEvent = "StaffBallSlow",
		CheckPostFireFail = true,
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyThrowAspectCharge",
			OnStageReachedFunctionName = "ThrowAspectChargeStage"
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 20,
				Wait = 0.9,
				WeaponProperties = 
				{ 
					Projectile = "ProjectileThrowCharged",
					ProjectileScaleMultiplier = 1,
					AimLineWidthOverride = 300,
				},
				ProjectileProperties = 
				{
					Fuse = 0.8,
					CollisionLayer = "Lyre",
					DetonatesProjectilesOnLayer = true,
					DetonateOnImpact = false,
				},
				ChannelSlowEventOnStart = true,
			},
		},

		HitSimSlowCooldown = 0.05,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.15, LerpTime = 0 },			
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Enemy Sounds/Hades/HadesSkullPreAttack",
					StoppedBy = { "TriggerRelease" }
				},
				{
					Name = "/SFX/Enemy Sounds/Hades/HadesLaserBlastChargeUp" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				},
				{ Name = "/SFX/Player Sounds/MelSkullsDash" },
				{
					Name = "/VO/MelinoeEmotes/EmoteAttackingDaggerThrow",
					Cooldown = 0.5
				},
			},
			FireStageSounds = 
			{
				{ Name = "/SFX/Player Sounds/MelSkullsOmegaSpecialFire" },
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
		
		SpeedPropertyChanges = 
		{
			{
				ProjectileProperty = "Speed",
				InvertSource = true
			},
			{
				WeaponProperty = "ChargeTime",
			},
		},
		Upgrades = { },
		IsModifiedByTraits = true,
	},
	WeaponSkullImpulse = 
	{
		IsModifiedByTraits = true,
	},
	WeaponLobPulse = 
	{
		IsModifiedByTraits = true,
		BaseDamageBonusMultiplier = "LobBaseDamageBonusMultiplier",
	},

	WeaponLobChargedPulse = 
	{
		IsModifiedByTraits = true,
		IsExWeapon = true,
	},

	WeaponTest =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponSwordFloatingIdleOff",
		UnequippedKitAnimation = "WeaponSwordFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponSwordFloatingIdleVertical",
		FirstTimeEquipAnimation = "Melinoe_Torch_Equip",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		-- ShortName = "SwordWeapon_Short",
		ExpireDashWeaponOnDash = true,
		SecondaryWeapon = "WeaponStaffBolt",

		CompleteObjectivesOnFire = { "SwordWeapon", "SwordWeaponArthur" },

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Sword" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
})