OverwriteTableKeys( WeaponData, 
{
	-- Dagger weapons
	WeaponDagger =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		GrannyModel = "WeaponDagger_Mesh",
		EquippedKitAnimation = "WeaponDaggerFloatingIdleOff",
		UnequippedKitAnimation = "WeaponDaggerFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponDaggerFloatingIdleVertical",
		FirstTimeWeaponFire = "WeaponDaggerDouble",
		FirstTimeEquipAnimation = "Melinoe_Dagger_Equip",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		UnlockName = "WeaponDagger_Unlock",
		DashWeapon = "WeaponDaggerDash",
		ExpireDashWeaponOnDash = true,
		DummyTraitName = "DummyWeaponDagger",
		
		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Dagger_Idle",
			["MelinoeDashStart"] = "Melinoe_Dagger_Dash_Start",
			["MelinoeDash"] = "Melinoe_Dagger_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Dagger_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Dagger_Run_Start",
			["MelinoeRun"] = "Melinoe_Dagger_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Dagger_Run_End",
			["MelinoeGetHit"] = "Melinoe_Dagger_GetHit",
			["MelinoeGetHitFinal"] = "Melinoe_Dagger_GetHit",

			["Melinoe_Cast_Start"] = "Melinoe_Dagger_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Dagger_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Dagger_Cast_Fire",
			["Melinoe_Cast_End"] = "Melinoe_Dagger_Cast_End",			
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Dagger_Cast_Fire_Quick",

			["Melinoe_CrossCast_Start"] = "Melinoe_Dagger_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Dagger_ForwardCast_Unequip",

			["MelinoeEquip"] = "Melinoe_Dagger_Equip",
			["MelinoeActionIdle"] = "Melinoe_Dagger_Idle",
			["MelinoeInteract"] = "Melinoe_Dagger_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Dagger_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Dagger_Unequip",
		WeaponInteractAnimation = "Melinoe_Dagger_Interact",
				
		SecondaryWeapon = "WeaponDaggerThrow",

		CompleteObjectivesOnFire = { "FistWeapon", "FistWeaponGilgamesh" },

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

		HitScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0 },			
			{ ScreenPreWait = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			[1] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingDagger" },
				{ Name = "/SFX/Player Sounds/MelDaggerKnifeSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/DaggerImpactWoodHard",
				Brick = "/SFX/DaggerImpactWoodSoft",
				Stone = "/SFX/DaggerImpactWoodSoft",
				Organic = "/SFX/DaggerImpactOrganic",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponDaggerDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,

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
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingDagger" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/DaggerImpactWoodHard",
				Brick = "/SFX/DaggerImpactWoodSoft",
				Stone = "/SFX/DaggerImpactWoodSoft",
				Organic = "/SFX/DaggerImpactOrganic",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponDagger2 =
	{
		InheritFrom = { "WeaponDagger", },
	},

	WeaponDaggerMultiStab =
	{
		InheritFrom = { "WeaponDagger", },

		DefaultKnockbackForce = 560,
		DefaultKnockbackScale = 0.7,

		HitSimSlowCooldown = 0.1,

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/DaggerImpactWoodHard",
				Brick = "/SFX/DaggerImpactWoodSoft",
				Stone = "/SFX/DaggerImpactWoodSoft",
				Organic = "/SFX/DaggerImpactOrganic",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},

	},
	WeaponDaggerDouble =
	{
		InheritFrom = { "WeaponDagger", },

		DefaultKnockbackForce = 960,
		DefaultKnockbackScale = 1.2,

		FireScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 1400, Duration = 0.1, Angle = 0 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.06 },
		},

		--[[
		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 0.3 },
		},
		]]--

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.35, Duration = 0.35 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCharging" },
				{ Name = "/SFX/Player Sounds/MelMagicalCharge",
					StoppedBy = { "ChargeCancel", "Fired" } },
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelDaggerMagicAttack" },
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
				Shell = "/SFX/ShellImpact",
			},
		}
	},

	WeaponDagger5 =
	{
		InheritFrom = { "WeaponDagger", },
		OnChargeFunctionName = "MarkDaggerTarget",
		OnChargeFunctionArgs = 
		{
			AutoLockArc = 180,
			Range = 600,
			BackstabDistance = 150,
		},
		ManaCost = 10,

		DefaultKnockbackForce = 880,
		DefaultKnockbackScale = 1.1,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.15, Fraction = 0.018, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.000, LerpTime = 0.06 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.27, Duration = 0.27 },
		},

		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.15, Angle = 0 },

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalCharge",
					StoppedBy = { "ChargeCancel", "Fired" }
				},
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingBackStab" },
				{ Name = "/SFX/Player Sounds/MelDaggerMagicAttack" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusCriticalFire",
				Brick = "/SFX/Player Sounds/ZagreusCriticalFire",
				Stone = "/SFX/Player Sounds/ZagreusCriticalFire",
				Organic = "/SFX/Player Sounds/ZagreusCriticalFire",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponDaggerThrow = 
	{
		StartingWeapon = false,
		FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 1200, Duration = 0.1 },
		MaxChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.4, OffsetY = -185, SkipShadow = true, SkipRise = true },
		HideChargeDuration = 0.25,
		CustomChannelSlowEvent = "DaggerThrowSlow",
		CompleteObjectivesOnStagedFire = { "WeaponDaggerThrowCharged" },
		ShowManaIndicator = true,
		OnChargeFunctionName = "DoWeaponCharge",
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyDaggerCharge",
			OnStageReachedFunctionName = "DaggerChargeStage"
		},
		ChargeWeaponStages = 
		{
				{ ManaCost = 6, WeaponProperties = { NumProjectiles = 2, AdditionalProjectileWaveChance = 0}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.32, HideStageReachedFx = true, ChannelSlowEventOnEnter = true },
				{ ManaCost = 9, WeaponProperties = { NumProjectiles = 3, AdditionalProjectileWaveChance = 0}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.14, HideStageReachedFx = true, },
				{ ManaCost = 12, WeaponProperties = { NumProjectiles = 4, AdditionalProjectileWaveChance = 0}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.14, HideStageReachedFx = true, },
				{ ManaCost = 15, WeaponProperties = { NumProjectiles = 5, AdditionalProjectileWaveChance = 0}, ApplyEffects = { "WeaponDaggerThrowEXDisable", "WeaponDaggerThrowEXDisableCancellable", "WeaponDaggerThrowEXDisableMoveHold" }, Wait = 0.14, },
		},
		CauseImpactReaction = true,
		RushOverride = true,
		DoProjectileBlockPresentation = true,

		DefaultKnockbackForce = 640,
		DefaultKnockbackScale = 0.8,

		SkipAttackNotReadySounds = true,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.18, Duration = 0.27 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				},
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
				},
				{ Name = "/SFX/Player Sounds/BowFire" },
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingDaggerThrow" },
			},
			FireStageSounds = 
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
				{ Name = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/DaggerThrowImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
		
		SelfMultiplier = 0,
		Upgrades = { },	
	},
})