OverwriteTableKeys( WeaponData, 
{
	-- Axe weapons
	WeaponAxe =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		GrannyModel = "Melinoe_Axe_Mesh1",
		EquippedKitAnimation = "WeaponAxeFloatingIdleOff",
		UnequippedKitAnimation = "WeaponAxeFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponAxeFloatingIdleVertical",
		FirstTimeEquipAnimation = "Melinoe_Axe_Equip",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		UnlockName = "WeaponAxe_Unlock",
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		DashWeapon = "WeaponAxeDash",
		PreserveDashWeaponSwapNames = { "WeaponAxe2", "WeaponAxe3" },
		DamagedAnimation = "Melinoe_Axe_GetHit",
		ExpireDashWeaponOnDash = true,
		SecondaryWeapon = "WeaponAxeBlock2",
		DummyTraitName = "DummyWeaponAxe",
		Using = { GrannyModel = "WeaponAxeBlurWheel_Mesh" },

		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Axe_Idle",
			["MelinoeDashStart"] = "Melinoe_Axe_Dash_Start",
			["MelinoeDash"] = "Melinoe_Axe_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Axe_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Axe_Run_Start",
			["MelinoeRun"] = "Melinoe_Axe_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Axe_Run_End",
			["MelinoeGetHit"] = "Melinoe_Axe_GetHit",
			["MelinoeGetHitFinal"] = "Melinoe_Axe_GetHit",

			
			["Melinoe_Cast_Start"] = "Melinoe_Axe_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Axe_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Axe_Cast_Fire",
			["Melinoe_Cast_End"] = "Melinoe_Axe_Cast_End",			
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Axe_Cast_Fire_Quick",

			["Melinoe_CrossCast_Start"] = "Melinoe_Axe_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Axe_ForwardCast_Unequip",
			
			["MelinoeEquip"] = "Melinoe_Axe_Equip",
			["MelinoeActionIdle"] = "Melinoe_Axe_Idle",
			["MelinoeInteract"] = "Melinoe_Axe_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Axe_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Axe_Unequip",
		WeaponInteractAnimation = "Melinoe_Axe_Interact",

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,
		DefaultKnockbackForce = 880,
		DefaultKnockbackScale = 1.1,
		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 },

		FireScreenshake = { Distance = 3, Speed = 300, FalloffSpeed = 3000, Duration = 0.12, DynamicAngleOffset = 0 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.10, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.09 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			[1] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeAxeSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},
	WeaponAxeDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		OnFiredFunctionName = "AllowAxeSpin",
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1.0,

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.04, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.07 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeAxeSwingShort" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},
	WeaponAxe2 =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		DefaultKnockbackForce = 880,
		DefaultKnockbackScale = 1.1,
		
		DashWeapon = "WeaponAxeDash",
		OnChargeFunctionName = "BlockDashDisable",
		--FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 3000, Duration = 0.15, DynamicAngleOffset = 0 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.09, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.09 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.2, Duration = 0.15 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
					StoppedBy = { "ChargeCancel","TriggerRelease",  "Fired" } }
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeHugeAxeSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},
	WeaponAxe3 =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		DefaultKnockbackForce = 960,
		DefaultKnockbackScale = 1.2,
		SkipManaIndicatorIfZeroManaCost = true,
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 0.96, Duration = 0.8, HoldDuration = 0.1, RestoreDefaultDuration = 0.2 },

		BlockDashSwapIfCharging = true,
		DashWeapon = "WeaponAxeDash",
		OnChargeFunctionName = "BlockDashDisable",
		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, Duration = 0.80 },
		},

		FireScreenshake = { Distance = 12, Speed = 800, FalloffSpeed = 3000, Duration = 0.2, Angle = 90, ScreenPreWait = 0.15 },
		HitSimSlowCooldown = 0.1,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.10, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.11, Fraction = 1.0, LerpTime = 0.07 },

			--{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.06, Fraction = 0.3, LerpTime = 0.07 },
			--{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.07 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.25, Duration = 0.2 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" }
				},
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe" },
				{ Name = "/SFX/Player Sounds/MelinoeHugeAxeSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},
	WeaponAxeSpin =
	{
		StartingWeapon = false,
		FireScreenshake = { Distance = 10, Speed = 400, FalloffSpeed = 0, Duration = 0.35, DynamicAngleOffset = 0 },
		ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 0.96, Duration = 0.2 },
		ChargeCancelCameraMotion = { ZoomType = "Undershoot", Fraction = 1.0, Duration = 0.1, RestoreDefaultDuration = 0.1  },
		SkipAttackNotReadySounds = true,
		ChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.2, OffsetY = -160, SkipShadow = true, SkipFlash = true, SkipRise = true },
		MaxChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.3, OffsetY = -160, SkipShadow = true, SkipRise = true },

		DefaultKnockbackForce = 640,
		DefaultKnockbackScale = 0.8,
		RequireProjectilesForPresentation = true,
		
		CompleteObjectivesOnFire = { "WeaponAxeSpin" },
		OnChargeFunctionName = "DoWeaponCharge",
		OnFiredFunctionName = "CheckAxeSpinDisable",
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyAxeCharge",
			OnStageReachedFunctionName = "AxeChargeStage"
		},
		ChargeWeaponStages = 
		{
				{ ManaCost = 10, WeaponProperties = { NumProjectiles = 1, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.32, ChannelSlowEventOnEnter = true, HideStageReachedFx = true },
				{ ManaCost = 11, WeaponProperties = { NumProjectiles  = 2, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 12, WeaponProperties = { NumProjectiles  = 3, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 13, WeaponProperties = { NumProjectiles  = 4, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 14, WeaponProperties = { NumProjectiles  = 5, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 15, WeaponProperties = { NumProjectiles  = 6, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 16, WeaponProperties = { NumProjectiles  = 7, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 17, WeaponProperties = { NumProjectiles  = 8, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 18, WeaponProperties = { NumProjectiles  = 9, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 19, WeaponProperties = { NumProjectiles  = 10, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, HideStageReachedFx = true },
				{ ManaCost = 20, WeaponProperties = { NumProjectiles  = 11, FireEndGraphic = "Melinoe_Axe_AttackEx1_End" }, Wait = 0.2, },
		},
		ShowManaIndicator = true,
		OnWeaponTriggerReleaseFunctionName = "CheckCastControl",
		OutOfManaFunctionName = "WeaponCooldownOutOfMana",
		OutOfManaFunctionArgs = { Cooldown = 0.85 },

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.16, Duration = 0.3 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingAxe" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" }
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},

			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
				{
					Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
					Key = "SpearWeaponSpin",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
		},

		Upgrades = { },
	},
	WeaponAxeBlock2 =
	{
		StartingWeapon = false,
		ShowManaIndicator = true,
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		DoProjectileBlockPresentation = true,
		OnChargeFunctionNames = { "DoWeaponCharge", "CheckAxeBlockThread" },
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyAxeBlockCharge",
			OnStageReachedFunctionName = "AxeBlockChargeStage",
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 25,
				Wait = 1.25,
				SkipManaSpendOnFire = true,
				DeferSwap = "WeaponAxeSpecialSwing",
				ChannelSlowEventOnStart = true,
				CompleteObjective = "WeaponAxeSpecialSwing",
				ForceRelease = false,
			},
		},

		DefaultKnockbackForce = 480,
		DefaultKnockbackScale = 0.6,

		HideChargeDuration = 0.45,
		--ProjectileBlockFunctionName = "ShieldBlock",
		--ProjectileBlockFunctionArgs = { EffectName = "BlockStun", MaxDistance = 350 },
		SkipAttackNotReadySounds = true,
		NoControlSound = "/Leftovers/SFX/OutOfAmmo2",


		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ShieldObstacleHit",
				Brick = "/SFX/Player Sounds/ShieldObstacleHit",
				Stone = "/SFX/Player Sounds/ShieldObstacleHit",
				Organic = "/SFX/Player Sounds/ShieldObstacleHit",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelinoeAxeSpecialChargeLoop",
					StoppedBy = { "ChargeCancel", "TriggerRelease" },
				},
			},

		},

		Upgrades = { },
	},
	WeaponAxeSpecialSwing =
	{
		StartingWeapon = false,
		IsExWeapon = true,
		OnChargeFunctionName = "SpendQueuedMana",

		DefaultKnockbackForce = 960,
		DefaultKnockbackScale = 1.2,

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmotePoweringUp" },
				{ Name = "/SFX/Player Sounds/ZagreusFistWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmashSHIELD",
				Brick = "/SFX/MetalStoneClangSHIELD",
				Stone = "/SFX/MetalStoneClangSHIELD",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
		OnFiredFunctionName = "RevertWeaponChanges",
		Upgrades = { },
	},	
})