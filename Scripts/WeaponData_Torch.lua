OverwriteTableKeys( WeaponData, 
{
	-- Torch weapons
	WeaponTorch =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		GrannyModel = "WeaponHecateMultiple_Mesh",
		EquippedKitAnimation = "WeaponTorchFloatingIdleOff",
		UnequippedKitAnimation = "WeaponTorchFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponTorchFloatingIdleVertical",
		FirstTimeEquipAnimation = "Melinoe_Torch_Equip",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		UnlockName = "WeaponTorch_Unlock",
		SkipAttackNotReadySounds = true,
		DummyTraitName = "DummyWeaponTorch",
		Using = { GrannyModel = { "WeaponTorchL_Mesh", "WeaponTorchR_Mesh",  } },
		
		SelfMultiplier = 0,
		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Torch_Idle",
			["MelinoeDashStart"] = "Melinoe_Torch_Dash_Start",
			["MelinoeDash"] = "Melinoe_Torch_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Torch_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Torch_Run_Start",
			["MelinoeRun"] = "Melinoe_Torch_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Torch_Run_End",
			["MelinoeGetHit"] = "Melinoe_Torch_GetHit",
			--["MelinoeGetHitFinal"] = "MelinoeTorchGetHitFinal",

			["Melinoe_Cast_Start"] = "Melinoe_Torch_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Torch_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Torch_Cast_Fire",
			["Melinoe_Cast_End"] = "Melinoe_Torch_Cast_End",
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Torch_Cast_Fire_Quick",

			["Melinoe_CrossCast_Start"] = "Melinoe_Torch_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Torch_ForwardCast_Unequip",

			["MelinoeEquip"] = "Melinoe_Torch_Equip",
			["MelinoeActionIdle"] = "Melinoe_Torch_Idle",
			["MelinoeInteract"] = "Melinoe_Torch_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Torch_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Torch_Unequip",
		WeaponInteractAnimation = "Melinoe_Torch_Interact",
		
		UseText = "UseWeaponKit",
		--ShowStaffUI = true,
		SecondaryWeapon = "WeaponTorchSpecial",

		CauseImpactReaction = true,
		--ImpactReactionHitsOverride = 0,

		ShowManaIndicator = true,
		IgnoreOOMAimlineAlpha = true,
		ChannelSlowIneligible = true,
		OnChargeFunctionNames = { "DoWeaponCharge", "MarkTorchTarget" },
		HideChargeDuration = 1.5,
		AllowManaRegenUntilChargeIndicator = true,

		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyTorchCharge",
			OnStageReachedFunctionName = "TorchChargeStage",
		},
		OnHasNoManaFunctionName = "TorchOutOfMana",
		OnFiredFunctionName = "TorchRepeatedFire",
		
		OutOfManaFunctionName = "WeaponCooldownOutOfMana",
		OutOfManaFunctionArgs = { Cooldown = 0.85 },

		OnFiredFunctionArgs = 
		{
			StartingAnimation = 
			{
				ChargeStartAnimation = "Melinoe_Torch_Attack1_StartSequence",
				FireGraphic = "Melinoe_Torch_Attack1_Fire"
			},
			SequencedAnimations = 
			{
				{
					ChargeStartAnimation = "Melinoe_Torch_Attack1_Start",
					FireGraphic = "Melinoe_Torch_Attack1_Fire"
				},
				{
					ChargeStartAnimation = "Melinoe_Torch_Attack2_Start",
					FireGraphic = "Melinoe_Torch_Attack2_Fire"
				},
				{
					ChargeStartAnimation = "Melinoe_Torch_Attack3_Start",
					FireGraphic = "Melinoe_Torch_Attack3_Fire"
				},
				{
					ChargeStartAnimation = "Melinoe_Torch_Attack4_Start",
					FireGraphic = "Melinoe_Torch_Attack4_Fire"
				},
				{
					ChargeStartAnimation = "Melinoe_Torch_Attack5_Start",
					FireGraphic = "Melinoe_Torch_Attack5_Fire"
				},
			}
		},
		OnWeaponTriggerReleaseFunctionName = "ResetFireSequence",
		
		ChargeWeaponStages = 
		{
			{
				SkipManaSpendOnFire = true,
				ManaCost = 3,
				Wait = 2.5,
				WeaponProperties =
				{
					Projectile = "ProjectileTorchBallLarge",
					AdditionalProjectileWaveChance = 0,
					Cooldown = 0.25,
				},
				CompleteObjective = "WeaponTorchCharged",
			},
		},
		SpeedPropertyChanges = 
		{
			{
				RecordExState = true,
				WeaponProperty = "Cooldown",
			},
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.3, Duration = 0.06 },
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
				-- { Name = "/VO/MelinoeEmotes/EmoteAttackingDaggerThrow" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/MelTorchFireBasic" },
			},
			FireStageSounds = 
			{
				{ Name = "/SFX/Player Sounds/MelTorchFireOmega" },
				{ 
					Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff",
					Cooldown = 10.0

				},
			},			
			ImpactSounds =
			{			
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamageTorches",
				Brick = "/SFX/BurnDamageTorches",
				Stone = "/SFX/BurnDamageTorches",
				Organic = "/SFX/BurnDamageTorches",
				StoneObstacle = "/SFX/BurnDamageTorches",
				BrickObstacle = "/SFX/BurnDamageTorches",
				MetalObstacle = "/SFX/BurnDamageTorches",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
	},

	WeaponTorchSpecial =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		StartingWeapon = false,
		IgnoreOOMAimlineAlpha = true,
		ShowManaIndicator = true,
		HideChargeDuration = 0.4,

		CauseImpactReaction = true,
		--ImpactReactionHitsOverride = 0,

		DefaultKnockbackForce = 640,
		DefaultKnockbackScale = 0.8,

		OnChargeFunctionNames = { "DoWeaponCharge" },
		
		ChargeWeaponStages = 
		{
			{
				ManaCost = 25,
				Wait = 0.925,
				ChannelSlowEventOnStart = true,
				ForceRelease = true,
				WeaponProperties =
				{
					Projectile = "ProjectileTorchOrbit",
					NumProjectiles = 2,
					FireGraphic = "Melinoe_Torch_Special1Ex_Fire",
					AdditionalProjectileWaveChance = 0
				},
				CompleteObjective = "WeaponTorchSpecialCharged",
			},
		},
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyTorchSpecialCharge",
			OnStageReachedFunctionName = "TorchSpecialChargeStage",
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.3, Duration = 0.06 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingDaggerThrow" },
				{
					Name = "/SFX/Player Sounds/MelMagicalCharge",
					StoppedBy = { "ChargeCancel", "Fired" }
				},
			},
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/MelTorchSpecialPreSpin" },
			},
			FireStageSounds = 
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
			},
			ImpactSounds =
			{			
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamageTorches",
				Brick = "/SFX/BurnDamageTorches",
				Stone = "/SFX/BurnDamageTorches",
				Organic = "/SFX/BurnDamageTorches",
				StoneObstacle = "/SFX/BurnDamageTorches",
				BrickObstacle = "/SFX/BurnDamageTorches",
				MetalObstacle = "/SFX/BurnDamageTorches",
				BushObstacle = "/SFX/BurnDamage",
			},
		},
	},
})
