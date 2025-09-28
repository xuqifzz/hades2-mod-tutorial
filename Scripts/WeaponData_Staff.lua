OverwriteTableKeys( WeaponData, 
{	
	-- Staff weapons
	WeaponStaffSwing =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		GrannyModel = "WeaponStaff_Mesh",
		EquippedKitAnimation = "WeaponStaffFloatingIdleOff",
		UnequippedKitAnimation = "WeaponStaffFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponStaffFloatingIdleVertical",
		BountyScreenKitAnimation = "WeaponStaffIdle",
		FirstTimeEquipAnimation = "Melinoe_Staff_Equip",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		NoBountyAvailableText = "ShrineScreen_NoBountyAvailable_Staff",
		DummyTraitName = "DummyWeaponStaff",
		Using = { GrannyModel = "WeaponBlurWheel_Mesh" },

		CompleteObjectivesOnFire = { },
		
		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Staff_Idle",
			["MelinoeDashStart"] = "Melinoe_Staff_Dash_Start",
			["MelinoeDash"] = "Melinoe_Staff_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Staff_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Staff_Run_Start",
			["MelinoeRun"] = "Melinoe_Staff_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Staff_Run_End",
			["MelinoeGetHit"] = "Melinoe_Staff_GetHit",
			["Melinoe_GetHit_LastStand"] = "Melinoe_Staff_GetHit_LastStand",

			["Melinoe_Cast_Start"] = "Melinoe_Staff_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Staff_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Staff_Cast_Fire",
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Staff_Cast_Fire_Quick",
			["Melinoe_Cast_End"] = "Melinoe_Staff_Cast_End",

			["Melinoe_CrossCast_Start"] = "Melinoe_Staff_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Staff_ForwardCast_Unequip",

			["MelinoeEquip"] = "Melinoe_Staff_Equip",
			["MelinoeActionIdle"] = "Melinoe_Staff_Idle",
			["MelinoeInteract"] = "Melinoe_Staff_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Staff_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Staff_Unequip",
		WeaponInteractAnimation = "Melinoe_Staff_Interact",

		ExpireDashWeaponOnDash = true,
		DashWeapon = "WeaponStaffDash",
		SecondaryWeapon = "WeaponStaffBall",

		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 }
		ManaChanges = { Disabled = {}, Enabled = {} },

		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.025, Fraction = 0.06, LerpTime = 0 },
			{ ScreenPreWait = 0.01, Fraction = 1.00, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.18 },
		},
		FireScreenshake = { },
				
		HitScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 0, Duration = 0.08, Angle = 0 },

		EquipVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiscWeaponEquipVoiceLines" },
			[2] = { GlobalVoiceLines = "SkellyWeaponEquipReactionVoiceLines" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/StaffImpact",
				Robot = "/SFX/MetalStoneClangShort",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/StaffImpact",
				StoneObstacle = "/SFX/StaffImpact",
				BrickObstacle = "/SFX/StaffImpact",
				MetalObstacle = "/SFX/StaffImpact",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponStaffSwing2 =
	{
		InheritFrom = { "WeaponStaffSwing", },

		SkipAttackNotReadySounds = true,
		OnChargeFunctionNames = { "BlockDashDisable", },

		CauseImpactReaction = true,

		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1.0,

		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 },

		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.065, Fraction = 0.07, LerpTime = 0 },
			{ ScreenPreWait = 0.01, Fraction = 1.00, LerpTime = 0.02 },
		},
		--[[
		HitSimSlowCooldown = 0.03,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.035, Fraction = 1.0, LerpTime = 0.07 },
		},
		]]

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.22, Duration = 0.23 },
		},

		HitScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 0, Duration = 0.08, Angle = 0 },

		Sounds =
		{		
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/StaffImpact",
				Robot = "/SFX/MetalStoneClangShort",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/StaffImpact",
				StoneObstacle = "/SFX/StaffImpactSmall",
				BrickObstacle = "/SFX/StaffImpactSmall",
				MetalObstacle = "/SFX/StaffImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponStaffSwing3 =
	{
		InheritFrom = { "WeaponStaffSwing", },

		SkipAttackNotReadySounds = true,
		OnChargeFunctionNames = { "BlockDashDisable", },

		CauseImpactReaction = true,

		DefaultKnockbackForce = 880,
		DefaultKnockbackScale = 1.1,

		FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225, ScreenPreWait = 0.08 },

		--[[
		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.12, Fraction = 0.07, LerpTime = 0 },
			{ ScreenPreWait = 0.5, Fraction = 1.0, LerpTime = 0.03 },
		},
		]]

		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.07, Fraction = 0.06, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.25, Duration = 0.35 },
		},

		HitScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 0, Duration = 0.23, Angle = 0 },

		Sounds =
		{	
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalCharge",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},	
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/StaffImpactBig",
				Robot = "/SFX/MetalStoneClangShort",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/StaffImpactBig",
				StoneObstacle = "/SFX/StaffImpactSmall",
				BrickObstacle = "/SFX/StaffImpactSmall",
				MetalObstacle = "/SFX/StaffImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},

	WeaponStaffSwing5 =
	{
		InheritFrom = { "WeaponStaffSwing", },
		ManaCost = 20,

		SkipAttackNotReadySounds = true,

		OutOfManaFunctionName = "WeaponCooldownOutOfMana",
		OutOfManaFunctionArgs = { Cooldown = 0.85 },
		CauseImpactReaction = true,

		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.16, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.0 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.1, HoldDuration = 0.01, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 0.9 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.37, Duration = 0.23 },
		},

		HitSimSlowCooldown = 0.01,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.12, LerpTime = 0.06 },
			--{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0.08 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		--HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.2, Angle = 90 },

		RepeatFireSound = "/SFX/Player Sounds/MelStaffFissureCOMBINED",
		Sounds =
		{		
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/ZagreusBowChargeup" ,
					Key = "SpearWeaponSpin",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
				{ Name = "/VO/MelinoeEmotes/EmoteChargingAxe" },
				{ Name = "/Leftovers/SFX/PlayerJump" },
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmotePoweringUp" },
				{ Name = "/SFX/Player Sounds/MelStaffFissureCOMBINED",}
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/StaffImpactBig",
				Robot = "/SFX/MetalStoneClangShort",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/StaffImpactBig",
				StoneObstacle = "/SFX/StaffImpactSmall",
				BrickObstacle = "/SFX/StaffImpactSmall",
				MetalObstacle = "/SFX/StaffImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponStaffDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,

		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,
		ManaChanges = { Disabled = {}, Enabled = {} },

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
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelStaffSwipeWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/StaffImpact",
				Robot = "/SFX/MetalStoneClangShort",
				Brick = "/SFX/MetalStoneClangShort",
				Stone = "/SFX/MetalStoneClangShort",
				Organic = "/SFX/StaffImpact",
				StoneObstacle = "/SFX/StaffImpactSmall",
				BrickObstacle = "/SFX/StaffImpactSmall",
				MetalObstacle = "/SFX/StaffImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponStaffBolt =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,

		SkipAttackNotReadySounds = true,
		SelfMultiplier = 0,


		FireRumbleParameters =
		{
		},

		Sounds =
		{
			ChargeSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteEvading" },
				-- { Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			FireSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteAttackingStaff" },
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},

			-- ImpactSounds handled in ProjectileData
		},
		
		SpeedPropertyChanges = 
		{
			{
				ProjectileProperty = "Acceleration",
				InvertSource = true,
			},
			{
				WeaponProperty = "Cooldown",
			},
		},
		Upgrades = { },
	},
	WeaponStaffBoltCharged =
	{
		ManaCost = 2.0,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.17, Duration = 0.17 },
		},
		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.2, Angle = 90, DistanceThreshold = 200 },
		RumbleDistanceThreshold = 180,
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		SimSlowDistanceThreshold = 180,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.39, Fraction = 1.0, LerpTime = 0.07 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				 { Name = "/VO/MelinoeEmotes/EmoteCharging" },
				--{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				},
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},

			-- ImpactSounds handled in ProjectileData
		},
		SpeedPropertyChanges = 
		{
			{
				ProjectileProperty = "Acceleration",
				InvertSource = true,
			},
			{
				WeaponProperty = "ChargeTime",
			},
		},
	},
	WeaponStaffBall =
	{
		InheritFrom = { "WeaponStaffBolt", },
		ShowManaIndicator = true,
		HideChargeDuration = 0.325,
		OnChargeFunctionNames = { "DoWeaponCharge", },
		CustomChannelSlowEvent = "StaffBallSlow",
		
		CompleteObjectivesOnNonStagedFire = { },
		CompleteObjectivesOnFire = {  },
		
		CheckPostFireFail = true,
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyStaffCharge",
			OnStageReachedFunctionName = "StaffChargeStage"
		},
		CompleteObjectivesOnStagedFire = { "WeaponStaffBall2" },
		RepeatFireSound = "/SFX/Player Sounds/StaffSpecialNew",
		
		CustomManaIndicatorOffsetY = -190,
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 10, 
				Wait = 0.65, 
				 
				WeaponProperties =
				{
					Projectile = "ProjectileStaffBallCharged",
					AdditionalProjectileWaveChance = 0,
					Cooldown = 0.31,
					ClipRegenInterval = 0,
					FireGraphic = "Melinoe_Staff_SpecialEx1_Fire",
					SelfVelocity = 0,
				},
				ApplyEffects = { "Special1DisableMoveHold", },
				--AnimOnStart = "Melinoe_Staff_Special1_Start", 
				FxOnStart = "StaffBoltCharge", 
				ChargeRumbleParameters =
				{
					-- { ScreenPreWait = 0.02, RightFraction = 0.14, Duration = 0.13 },
				},
				FireRumbleParameters =
				{
					-- { ScreenPreWait = 0.06, RightFraction = 0.2, Duration = 0.23 },
				},
				ChannelSlowEventOnStart = true 
			},
		},
		Sounds =
		{
			ChargeSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteCharging" },
				{
					Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				},
			},
			ChargeStageSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCharging",
					StoppedBy = { "ChargeCancel", "Fired", "ChargeStage" }
				},
				{
					Name = "/SFX/Player Sounds/ZagreusWeaponChargeup",
					StoppedBy = { "ChargeCancel", "Fired", }
				}
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				},
				{ Name = "/VO/MelinoeEmotes/EmoteLaunchingSuit" },
			},
			FireStageSounds = 
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
				{ Name = "/Leftovers/SFX/AuraThrowSmall" },
			},

			-- ImpactSounds handled in ProjectileData
		},
		SpeedPropertyChanges = 
		{
			{
				ProjectileProperty = "Acceleration",
				InvertSource = true,
			},
			{
				WeaponProperty = "ChargeTime",
			},
			{
				WeaponProperty = "Cooldown",
			},
			{
				WeaponProperty = "ClipRegenInterval",
			},
		},
	},
	WeaponStaffBall2 =
	{
		-- Only used for misnamed objective
	}
})
