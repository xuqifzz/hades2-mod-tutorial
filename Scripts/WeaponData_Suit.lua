OverwriteTableKeys( WeaponData, 
{
	-- Suit weapons
	WeaponSuit =
	{
		InheritFrom = { "BaseUnlockableWeapon", },

		GrannyModel = "WeaponSuitMultiple_Base_Mesh",
		EquippedKitAnimation = "WeaponSuitFloatingIdleOff",
		UnequippedKitAnimation = "WeaponSuitFloatingIdle",
		UpgradeScreenKitAnimation = "WeaponSuitFloatingIdleVertical",
		BountyScreenKitAnimation = "WeaponSuitIdle",
		FirstTimeWeaponFire = "WeaponSuit",
		FirstTimeEquipAnimation = "Melinoe_Suit_Equip",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		SprintLoopSound = "/SFX/Player Sounds/MelinoeSuitHoverStartAndLoop",
		SprintEndSound = "/SFX/Player Sounds/MelinoeSuitHoverEnd",
		EndEffectsOnBlink = { "ExAttackSuitShield", "ExAttackSuitDefense","SuitChargeDisableRotation" },
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		NoBountyAvailableText = "ShrineScreen_NoBountyAvailable_Suit",
		UnequipFunctionName = "ClearSuitMarkers",
		UnlockName = "WeaponSuit_Unlock",
		ExpireDashWeaponOnDash = true,
		DummyTraitName = "DummyWeaponSuit",
		SecondaryWeapon = "WeaponSuitRanged",
		CheckPostFireFail = true,
		DashSwaps = {"WeaponSuit", "WeaponSuit2"},
		StartRoomEvents = 
		{
			{
				FunctionName = "ApplySprintSpeedIncrease",
				Args = 
				{
					
					PropertyChanges = 
					{
						{
							WeaponNames = { "WeaponSprint" },
							WeaponProperty = "SelfVelocity",
							ChangeValue = 357,
							ChangeType = "Add",
						},
						{
							WeaponNames = { "WeaponSprint" },
							WeaponProperty = "SelfVelocityCap",
							ChangeValue = 233.5,
							ChangeType = "Add",
						},
					}
				}
			},
		},
		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
			{
				EffectName = "SuitAttack1DisableCancellable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "SuitAttack1Disable",
				EffectProperty = "Duration",
			},
		},
		SwapAnimations =
		{
			["MelinoeIdle"] = "Melinoe_Suit_Idle",
			["MelinoeDashStart"] = "Melinoe_Suit_Dash_Start",
			["MelinoeDash"] = "Melinoe_Suit_Dash_Fire",
			["MelinoeSprint"] = "Melinoe_Suit_Sprint_FireLoop",
			["MelinoeStart"] = "Melinoe_Suit_Run_Start",
			["MelinoeRun"] = "Melinoe_Suit_Run_FireLoop",
			["MelinoeStop"] = "Melinoe_Suit_Run_End",
			["MelinoeGetHit"] = "Melinoe_Suit_GetHit",
			["Melinoe_GetHit_LastStand"] = "Melinoe_Suit_GetHit_LastStand",

			["Melinoe_Cast_Start"] = "Melinoe_Suit_Cast_Start",
			["Melinoe_Cast_StartLoop"] = "Melinoe_Suit_Cast_StartLoop",
			["Melinoe_Cast_Fire"] = "Melinoe_Suit_Cast_Fire",
			["Melinoe_Cast_End"] = "Melinoe_Suit_Cast_End",
			["Melinoe_Cast_Fire_Quick"] = "Melinoe_Suit_Cast_Fire_Quick",

			["Melinoe_CrossCast_Start"] = "Melinoe_Suit_CrossCast_Start",
			["Melinoe_ForwardCast_Unequip"] = "Melinoe_Suit_ForwardCast_Unequip",

			["MelinoeEquip"] = "Melinoe_Suit_Equip",
			["MelinoeActionIdle"] = "Melinoe_Suit_Idle",
			["MelinoeInteract"] = "Melinoe_Suit_InteractUnequip",
			["MelinoeBoonPreInteract"] = "Melinoe_Suit_InteractUnequip",
		},
		UnequipAnimation = "Melinoe_Suit_Unequip",
		WeaponInteractAnimation = "Melinoe_Suit_Interact",
		DashWeapon = "WeaponSuitDash",
		OnEnemyDamagedFunction = 
		{
			FunctionName = "SuitHaltPlayer",
		},


		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

		EquipVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiscWeaponEquipVoiceLines" },
			[2] = { GlobalVoiceLines = "SkellyWeaponEquipReactionVoiceLines" },
		},
		HitScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0 },			
			{ ScreenPreWait = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingSuit" },
				-- { Name = "/SFX/Player Sounds/ZagreusLuciferSpecialFire" },
				-- { Name = "/SFX/Player Sounds/AphroditeLoveRadialNovaBlast" },
				-- { Name = "/SFX/Player Sounds/AphroditeLoveShotgunBlastSingle" },
				-- { Name = "/VO/MelinoeEmotes/EmoteChargingSuit" },
				-- { Name = "/VO/MelinoeEmotes/EmoteFullPowerAttackingSuit" },
				-- { Name = "/VO/MelinoeEmotes/EmotePowerAttackingSuit" },
				-- { Name = "/VO/MelinoeEmotes/EmotePowerLaunchingSuit" },
				-- { Name = "/VO/MelinoeEmotes/EmoteSpecialChargingSuit" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactBig",
				Brick = "/SFX/FistImpactBig",
				Stone = "/SFX/FistImpactBig",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
				Shell = "/SFX/ShellImpact",
			},
		},
	},
	WeaponSuit2 =
	{
		InheritFrom = { "WeaponSuit", },
		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
			{
				EffectName = "SuitAttack2Disable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "SuitAttack2DisableCancellable",
				EffectProperty = "Duration",
			},
		},
	},
	--[[
	WeaponSuit3 =
	{
		InheritFrom = { "WeaponSuit", },
	},
	]]
	WeaponSuitDash =
	{
		InheritFrom = { "WeaponSuit", },
	},
	WeaponSuitCharged =
	{
		IsExWeapon = true,
		DoProjectileBlockPresentation = true,
		BlockSound = "/SFX/Enemy Sounds/Exalted/EnergyShieldBlock",
		InheritFrom = { "WeaponSuit", },
		--ChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.2, OffsetY = -160, SkipShadow = true, SkipFlash = true, SkipRise = true },
		--MaxChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.3, OffsetY = -160, SkipShadow = true, SkipRise = true },
		ShowManaIndicator = true,
		SkipAttackNotReadySounds = true,
		OutOfManaFunctionName = "WeaponCooldownOutOfMana",
		OutOfManaFunctionArgs = { Cooldown = 0.85 },
		OnChargeFunctionNames = { "DoWeaponCharge", "EndDashDisableForce" },
		OnFiredFunctionNames = { "CheckSuitChargedDisable", },
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptySuitAttackCharge",
			OnStageReachedFunctionName = "SuitAttackChargeStage"
		},
		CompleteObjectivesOnFire = { "WeaponSuitCharged" },

		ProjectileBlockFunctionName = "ShieldBlock",
		ProjectileBlockFunctionArgs = { EffectName = "BlockStun", MaxDistance = 600 },
		
		OnEnemyDamagedFunction = 
		{
		},
		RequireProjectilesForPresentation = true,
		CauseImpactReaction = true,
		BlockGraphic = "SuitDeflectBase",
		BlockLingerDuration = 0.30,
		FireBlockLingerDuration = 0.35,
		ManaIndicatorUsesStageProgression = true,
		
		MinWeaponChargeTime = 0.02,
		ChargeWeaponStages = 
		{
				{ ManaCost = 1, Force = 700, WeaponProperties = { NumProjectiles = 1, FireGraphic = "Melinoe_Suit_AttackExPunch_Start", DamageMultiplier  = 1 }, Wait = 0.15, HideStageReachedFx = true },
				{ ManaCost = 2, Force = 725, WeaponProperties = { DamageMultiplier  = 1.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 3, Force = 750, WeaponProperties = { DamageMultiplier = 1.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 4, Force = 775, WeaponProperties = { DamageMultiplier = 1.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 5, Force = 800, WeaponProperties = { DamageMultiplier = 2.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 6, Force = 825, WeaponProperties = { DamageMultiplier = 2.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 7, Force = 850, WeaponProperties = { DamageMultiplier = 2.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 8, Force = 875, WeaponProperties = { DamageMultiplier = 2.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 9, Force = 900, WeaponProperties = { DamageMultiplier = 3.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 10, Force = 900, WeaponProperties = { DamageMultiplier = 3.25 }, Wait = 0.05, HideStageReachedFx = true },

				{ ManaCost = 11, Force = 900, WeaponProperties = { DamageMultiplier  = 3.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 12, Force = 900, WeaponProperties = { DamageMultiplier = 3.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 13, Force = 900, WeaponProperties = { DamageMultiplier = 4.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 14, Force = 900, WeaponProperties = { DamageMultiplier = 4.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 15, Force = 900, WeaponProperties = { DamageMultiplier = 4.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 16, Force = 900, WeaponProperties = { DamageMultiplier = 4.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 17, Force = 900, WeaponProperties = { DamageMultiplier = 5.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 18, Force = 900, WeaponProperties = { DamageMultiplier = 5.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 19, Force = 900, WeaponProperties = { DamageMultiplier = 5.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 20, Force = 900, WeaponProperties = { DamageMultiplier = 5.75 }, Wait = 0.05, HideStageReachedFx = true },

				{ ManaCost = 21, Force = 900, WeaponProperties = { DamageMultiplier  = 6.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 22, Force = 900, WeaponProperties = { DamageMultiplier = 6.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 23, Force = 900, WeaponProperties = { DamageMultiplier = 6.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 24, Force = 900, WeaponProperties = { DamageMultiplier = 6.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 25, Force = 900, WeaponProperties = { DamageMultiplier = 7.00 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 26, Force = 900, WeaponProperties = { DamageMultiplier = 7.25 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 27, Force = 900, WeaponProperties = { DamageMultiplier = 7.50 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 28, Force = 900, WeaponProperties = { DamageMultiplier = 7.75 }, Wait = 0.05, HideStageReachedFx = true },
				{ ManaCost = 29, Force = 900, WeaponProperties = { DamageMultiplier = 8.00 }, Wait = 0.05, HideStageReachedFx = true },

				{ ManaCost = 30, Force = 900, WeaponProperties = { DamageMultiplier = 10.00 }, Wait = 0.1, ForceRelease = true, BlockForceReleaseWithoutMana = true},
		},
		DefaultKnockbackForce = 720,
		DefaultKnockbackScale = 0.9,

		FireScreenshake = { Distance = 8, Speed = 500, FalloffSpeed = 1400, Duration = 0.22, Angle = 0, ScreenPreWait = 0.11 },

		ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 1.045, Duration = 2.08, },
		ChargeCancelCameraMotion = { ZoomType = "Undershoot", Fraction = 1.0, Duration = 0.1, RestoreDefaultDuration = 0.1  },
		FireCameraMotion = { ZoomType = "Ease", Fraction = 0.96, Duration = 0.3, HoldDuration = 0.3, RestoreDefaultDuration = 0.4  },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.09, Duration = 0.15 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.16, Fraction = 0.37, Duration = 0.34 },
		},

		HitSimSlowCooldown = 0.1,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.11, Fraction = 1.0, LerpTime = 0.07 },
		},

		--[[
		ScaledHitSimSlowParameters = 
		{
			{ ScreenPreWait = 0.04, Fraction = 0.06, LerpTime = 0.06 },
			{ ScreenPreWait = 0.02, ScreenPreWaitPerStage = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},
		]]

		Sounds =
		{		
			ChargeSounds =
			{
				{
					Name = "/VO/MelinoeEmotes/EmotePowerChargingSuit" ,
					Key = "SpearWeaponSpin",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
			MaxStageSounds = 
			{
				{ Name = "/VO/MelinoeEmotes/EmoteFullPowerAttackingSuit" },
			},
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
				},
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingSuit" },
				-- handled in Suit_Attacks_Animation
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
	WeaponSuitRanged = 
	{
		StartingWeapon = false,
		FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 1200, Duration = 0.1 },
		HideChargeDuration = 0.3,
		CustomChannelSlowEvent = "DaggerThrowSlow",
		CompleteObjectivesOnStagedFire = { "WeaponDaggerThrowCharged" },
		ShowManaIndicator = true,
		MaxMissileChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.3, OffsetY = -160, SkipShadow = true, SkipRise = true },
		OnChargeFunctionNames = { "DoWeaponCharge", "CheckSuitEnemiesInRange" },
		OnProjectileDeathFunction = "WeaponSuitAmmoTransform",
		OnEnemyDamagedFunction = { FunctionName = "RemoveMissileMark" },
		NoTargetColor = { 142, 142, 142, 255 },
		NoTargetHSV = { 1.0, -1.0, -0.5 },

		OnProjectileDeathFunctionArgs = 
		{
			ProjectileSuitRangedUnguided = 
			{
				Name = "ProjectileSuitRangedGuided",
				PrioritizeDifferent = true,
			},
			ProjectileSuitRangedChargedUnguided = 
			{
				UseMarks = true,
				Name = "ProjectileSuitRangedCharged",
			}
		},
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptySuitCharge",
			OnStageReachedFunctionName = "SuitChargeStage"
		},
		ManualSetMaxChargeCache = true,
		SeekInterval = 0.08, 				-- Interval per target
		FireInterval = 0.1,					-- Interval per fire
		BaseFuse = 0.4,						-- How long the first EX attack projectile takes to activate
		BaseFuseAddition = 0.05,			-- How much longer each subsequent EX attack projectile takes to activate
		BaseCooldown = 0.6,					-- How long the base cooldown is
		BaseExCooldown = 0.1,				-- How long the base cooldown is for the EX attack
		BaseCooldownAddition = 0.1,			-- How each subsequent EX attack projectile increases cooldown by this amount
		SeekAngle = 30,						-- Seek arc
		UnguidedSeekAngle = 110,			-- Base seek arc (doubled, so 180 is full 360)
		SeekScaleY = 0.6,					-- Y adjustment to maintain isometry. Needs to match the PostRotateScaleY value of the SeekGuideMid animation
		ChargedProjectileName = "ProjectileSuitRangedChargedUnguided",
		MaxTargets = 6,
		stageManaCost = 2,
		SeekGuideMid = "SuitCenterAimline",
		SeekEffect = "SuitSpecialLock",
		Range = 1100,
		Spread = 90, -- Base spread for the unguided version
		ThreadName = "SuitFireThread",
		IsExWithMapStateVariable = "ValidSuitRangedTargets",
		ManaIndicatorUsesStageProgression = true,
		ChargeWeaponStages = 
		{
			{
				ManaCost = 5, 
				Wait = 0.35,
				SkipManaSpendOnFire = true,
				WeaponProperties = 
				{
					NumProjectiles = 0, 
					AdditionalProjectileWaveChance = 0,
					Spread = math.rad(20),
				},
				FxOnStart = "StaffBoltCharge", 
				ChannelSlowEventOnStart = true,
				CompleteObjective = "WeaponSuitRangedCharged",
			},
		},
		CauseImpactReaction = true,
		RushOverride = true,
		DoProjectileBlockPresentation = true,

		DefaultKnockbackForce = 640,
		DefaultKnockbackScale = 0.8,

		SkipAttackNotReadySounds = true,

		--[[
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
		]]

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.18, Duration = 0.27 },
		},

		Sounds =
		{
			FireSounds =
			{
				-- Look at SuitBaseMissileAttack to change fire sounds
			},
			FireStageSounds = 
			{
				{ Name = "/SFX/Player Sounds/MelinoeSuitSpecialPreLaunch" },
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingSuit" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
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

	WeaponSuitDouble =
	{
		InheritFrom = { "WeaponSuit", },
		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
			{
				EffectName = "SuitAttack3Disable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "SuitAttack3DisableCancellable",
				EffectProperty = "Duration",
			},
		},
	},
})