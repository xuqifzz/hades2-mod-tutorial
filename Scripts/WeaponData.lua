WeaponData =
{
	DefaultWeaponValues =
	{	
		DefaultKnockbackForce = 800,
		DefaultKnockbackScale = 1,
		DefaultSpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
		},
	},

	BaseUnlockableWeapon =
	{
		UsePromptOffsetX = 64,
		UsePromptOffsetY = -64,
		StartingWeapon = true,

		UnlockUseText = "UseWeaponKit_LockedHasKey",
		LockedUseText = "UseWeaponKit_LockedNoKey",

		AspectAvailableAnimation = "WeaponAspectAvailableFront",
		InfoBackingAnimation = "WeaponSlotBase",

		MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/TarotCardSpecialInteract",
	},

	WeaponAnywhereCast=
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
		LinkedTraitNames = { "ArtemisCastCountBoon", "CastCountMetaUpgrade" },
		
		ArmedCastChargeStage = true,
		ShowManaIndicator = true,
		HideChargeDuration = 0.15,
		OnChargeFunctionName = "DoWeaponCharge",
		CustomChannelSlowEvent = "WeaponAnywhereCast",

		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyIndirectCastCharge",
			OnStageReachedFunctionName = "IndirectCastChargeStage"
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 15, 
				Wait = 0.8, 
				ChannelSlowEventOnStart = true,
			},
		},
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		SkipManaIndicatorIfZeroManaCost = true,
		OnFiredFunctionName = "FireAnywhereCastAtLocation",
		SpeedPropertyChanges = 
		{
			{
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Duration",
			},
		},
		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/Leftovers/SFX/WyrmCastAttack" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		SimSlowDistanceThreshold = 180,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		SelfMultiplier = 0,
	},
	WeaponCastProjectile =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
		LinkedTraitNames = { "ArtemisCastCountBoon", "CastCountMetaUpgrade" },
		
		ShowManaIndicator = true,
		HideChargeDuration = 0.15,
		OnChargeFunctionName = "DoWeaponCharge",
		CustomChannelSlowEvent = "WeaponCastProjectile",
		ArmedCastChargeStage = true,
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyIndirectCastCharge",
			OnStageReachedFunctionName = "IndirectCastChargeStage"
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 15, 
				Wait = 0.8, 
				ChannelSlowEventOnStart = true 
			},
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		SkipManaIndicatorIfZeroManaCost = true,
		OnProjectileDeathFunction = "FireCastAtLocation",
		SpeedPropertyChanges = 
		{
			{
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Duration",
			},
		},
		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/Leftovers/SFX/WyrmCastAttack" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		SimSlowDistanceThreshold = 180,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		SelfMultiplier = 0,
	},
	
	WeaponCastProjectileHades =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
		LinkedTraitNames = { "ArtemisCastCountBoon", "CastCountMetaUpgrade" },
		
		ShowManaIndicator = true,
		HideChargeDuration = 0.15,
		OnChargeFunctionName = "DoWeaponCharge",
		CustomChannelSlowEvent = "WeaponCastProjectileHades",
		ArmedCastChargeStage = true,
		ChargeWeaponData =
		{
			EmptyChargeFunctionName = "EmptyIndirectCastCharge",
			OnStageReachedFunctionName = "IndirectCastChargeStage"
		},
		ChargeWeaponStages = 
		{
			{ 
				ManaCost = 15, 
				Wait = 0.8, 
				ChannelSlowEventOnStart = true 
			},
		},
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		SkipManaIndicatorIfZeroManaCost = true,
		OnProjectileDeathFunction = "AttachCastAtLocation",
		SpeedPropertyChanges = 
		{
			{
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Duration",
			},
		},
		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/Leftovers/SFX/WyrmCastAttack" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		SimSlowDistanceThreshold = 180,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		SelfMultiplier = 0,
	},
	WeaponCast =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		--ManaCost = 0,
		--ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 1.04, Duration = 0.22 },
		--FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.1 },
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },

		--RumbleDistanceThreshold = 500,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},
		OnFiredFunctionName = "WeaponCastFired",
		OnFiredFunctionArgs = 
		{ 
			ProjectileNames = { },
		},

		OnHitFunctionNames = { "RefreshImpactSlow" },

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		SkipManaIndicatorIfZeroManaCost = true,
		
		UnarmedCastCompleteGraphic = "Melinoe_Cast_Fire_Quick",
		--NotReadySound = "/Leftovers/SFX/OutOfAmmo2",
		--NotReadyText = "OutOfAmmo_Alt",
		--NoAmmoFunctionName = "RangedFailedNoAmmoPresentation",
		--NotReadyAmmoPackText = "RetrieveAmmo",
		--NotReadyAmmoInEnemyText = "RetrieveAmmoFromEnemy",
		--NotReadyPulseStoredAmmo = true,
		--SkipAttackNotReadySounds = true,
		
		SpeedPropertyChanges = 
		{
			{
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Duration",
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/Leftovers/SFX/WyrmCastAttack" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		--[[
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
		
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.11, Duration = 0.11 },
		},
		]]
		OnArmedHitEffect = 
		{
			EffectName = "OnHitStun",
			DataProperties = 
			{
				Duration = 0.7,
				DisableMove = true,
				DisableRotate = true,
				DisableAttack = true,
				CanAffectInvulnerable = false,
			}
		},
		ArmedParameters = 
		{
			Sounds =
			{
				ImpactSounds =
				{
					Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
					Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
					BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				},
			},
			HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
			HitSimSlowParameters =
			{
				{ ScreenPreWait = 0.07, Fraction = 0.15, LerpTime = 0 },
				{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.10 },
			},
			
			SimSlowDistanceThreshold = 180,
			HitRumbleParameters =
			{
				{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
			},
		},
		SelfMultiplier = 0,
	},

	WeaponCastVacuum =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		ManaCost = 10,
		OutOfManaFunctionName = "WeaponCooldownOutOfMana",
		OutOfManaFunctionArgs = { Cooldown = 0.85 },
		FireScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},
		
		SpeedPropertyChanges = 
		{
			{
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Duration",
			},
			{
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Duration",
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{ Name = "/Leftovers/SFX/WyrmCastAttack" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		SelfMultiplier = 0,
	},
	WeaponCastArm =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",
		ManaCost = 15,
		HideChargeDuration = 0.25,
		--ManaChargeStartAnimation = "Melinoe_Cast_Start",
		HideOutOfManaPresentation = true,
		FireScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },
		
		OnFiredFunctionName = "CastArmedFunction",
		RepeatFailToFireFunction = true,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
		},
		
		SpeedPropertyChanges = 
		{
			{
				WeaponProperty = "ChargeTime",
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
				{ Name = "/Leftovers/SFX/AuraThrowSmall" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		SelfMultiplier = 0,
	},

	WeaponBlink =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Rush",
		IgnoreCancelSimOnEffects = { "RushWeaponDisable", "RushWeaponDisableCancelable" },
		CompleteObjectivesOnFire = { "RushWeapon" },
		ExpireProjectilesOnFire = {"ProjectileAxeSpin", "ProjectileDagger"},
		CancelWeaponOnFire = "WeaponAxeBlock2",
		OnChargeFunctionName = "WeaponBlinkFunction",
		--OnChargeFunctionArgs = { AlphaDuration = 0.3 },
		OnChargeCancelFunctionName = "ClearBlinkAlpha",
		SimSlowBlur =
		{
			Strength = 0.3,
			Distance = 1.6,
			FXInTime = 0.06,
			FXHoldTime = 0.4,
			FXOutTime = 0.4,
		},

		SkipAttackNotReadySounds = true,
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
				{ Name = "/VO/MelinoeEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/MelDash" },
			},

			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactMedium",
				Brick = "/SFX/FistImpactMedium",
				Stone = "/SFX/FistImpactMedium",
				Organic = "/SFX/FistImpactMedium",
			},

			CancelEffectSounds =
			{
			},
		},

		NoExpressiveAnim = true,

		Upgrades = { },
	},

	WeaponSprint =
	{
	
		HideChargeDuration = 0.25,
		NoManaNotificationCooldown = 1.8,
		--[[
		DrainManaEffect = 
		{
			Name = "SprintManaDrain",
			RequiredStartMana = 10,
			EffectName = "SprintInvuln",
			CostPerSecond = 60,
			OutOfManaFunctionName = "WeaponSprintOutOfMana",
		}
		]]
	},

	WeaponMorphedAttack =
	{
		FiredHeroVoiceLines = "SheepAttackVoiceLines",
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteSheepAttacking" },
				-- { Name = "/VO/MelinoeEmotes/EmoteSheepHit" }
			},

			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactMedium",
				Brick = "/SFX/FistImpactMedium",
				Stone = "/SFX/FistImpactMedium",
				Organic = "/SFX/FistImpactMedium",
			},

		},
	},

	FlashbackMelBlink =
	{
		SimSlowBlur =
		{
			Strength = 0.3,
			Distance = 1.6,
			FXInTime = 0.06,
			FXHoldTime = 0.4,
			FXOutTime = 0.4,
		},

		SkipAttackNotReadySounds = true,
		Sounds =
		{
			ChargeSounds =
			{
				{
					-- Name = "/VO/MelinoeEmotes/EmoteCharging",
					Name = "/SFX/Player Sounds/MelMagicalCharge",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},	
			FireSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/MelDaggerKnifeSwipe" },
			},

			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactMedium",
				Brick = "/SFX/FistImpactMedium",
				Stone = "/SFX/FistImpactMedium",
				Organic = "/SFX/FistImpactMedium",
			},

			CancelEffectSounds =
			{
			},
		},
	},

	-- Spell weapons
	BaseSpell = 
	{
		IsModifiedByTraits = true,
		SpellWeapon = true,
		FailToFireFunctionName = "SpellFailToFirePresentation",
		OnChargeFunctionName = "StartSpellCharge",
		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.001,
			Duration = 1.8,
			DisableBlink = true,
			Force = true,
		},
		--OnHasManaFunctionName = "SpellHasMana",
		--OnHasNoManaFunctionName = "SpellHasNoMana",
		OnChargeCancelFunctionName = "CheckSpellOutOfManaPresentation",
		BlockNotReadyWhenGiftableUseTarget = true,
		NotReadyText = "Spell_NotReady",
		ManaSpendCost = 10,
	},
	WeaponSpellTransform = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellTransformPrompt" },
		ManaSpendCost = 100,
		Duration = 5.0,

		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.001,
			Duration = 1.1,
			DisableBlink = true,
			Force = true,
		},

		OnFiredFunctionNames = { "SpellFire", "SpellTransform", },
		OnFiredFunctionArgs = 
		{
			TransformWeapons = { "WeaponTransformAttack", "WeaponTransformSpecial", "WeaponTransformBlink" },
			StartVfx = "SuperStartFlare",
			EndVfx = "SuperStartFlare",
			RevertAnimationSwaps = true,
			EndGraphic = "MelinoeEquip",
			Vfx = "GrenadeSelfDamageOutputFx",
			Scale = 1.1,
			TransformTexture = "Models/Melinoe/MelinoeTransform_Color",
		},
		FireSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/TimeSlowCharge" ,
					Key = "SpearWeaponSpin",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/TransformActivate" },
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingSpell" },
			},
		},

	},
	WeaponTransformAttack =
	{
		Sounds =
		{
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


	WeaponTransformSpecial =
	{
		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteChargingHowl",
					StoppedBy = { "ChargeCancel", "Fired" } },
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteHowlSlam" },
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

	WeaponTransformBlink = 
	{

	},

	WeaponSpellMeteor = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellMeteorPrompt" },
		OnFiredFunctionNames = {"SpellFire", "SpellMeteorPresentation", },
		ManaSpendCost = 200,
		
		FireSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},

		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.15, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.5, Fraction = 1.00, LerpTime = 0.16 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Player Sounds/TimeSlowChargeLoop",
					StoppedBy = { "ChargeCancel", "Fired" } },
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingFierce" },
				{ Name = "/SFX/Player Sounds/TimeSlowStart" },
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ElectricZapSmall",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ElectricZapSmall",
				Brick = "/SFX/Player Sounds/ElectricZapSmall",
				Stone = "/SFX/Player Sounds/ElectricZapSmall",
				Organic = "/SFX/Player Sounds/ElectricZapSmall",
				StoneObstacle = "/SFX/Player Sounds/ElectricZapSmall",
				BrickObstacle = "/SFX/Player Sounds/ElectricZapSmall",
				MetalObstacle = "/SFX/Player Sounds/ElectricZapSmall",
				BushObstacle = "/SFX/Player Sounds/ElectricZapSmall",
			},
		},
	},
	WeaponSpellLaser = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellLaserPrompt" },
		OnFiredFunctionNames = { "LaserSpellFire" },
		OnClipEmptyFunctionName = "LaserSpellReload", 
		MaxDuration = 3,
		ManaSpendCost = 70,

		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.001,
			Duration = 1.0,
			DisableBlink = true,
			Force = true,
		},
		
		Sounds =
		{
			ChargeSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteCharging" },
				{
					Name = "/SFX/Player Sounds/TimeSlowCharge" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteAttackingSpell" },
			},
		},

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.16, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.5 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.6, HoldDuration = 3.00, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 2.1 },
		},
	},
	WeaponSpellSummon = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellSummonPrompt" },
		SpawnName = "SwarmerSummon",
		Duration = 12,
		MaxSummons = 1,
		OnFiredFunctionNames = { "SpellReloadStarted", "SpellFire" },
		ManaSpendCost = 60,
		SummonMultipliers = 
		{
			MaxHealthMultiplier = 100,
			SpeedMultiplier = 1.6,
			ScaleMultiplier = 1.2,
			DamageMultiplier = 1.5,
		},

		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.001,
			Duration = 1.0,
			DisableBlink = true,
			Force = true,
		},

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.16, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.0 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.1, HoldDuration = 1.0, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 1.4 },
		},		

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/SummonFire" },
				{ Name = "/VO/MelinoeEmotes/EmoteCastingFierce" },
			},
		},
		Using = { Weapon = "SpellSummonRanged" },
	},
	WeaponSpellPolymorph = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellPolymorphPrompt" },
		OnFiredFunctionNames = { "SpellReloadStarted", "SpellFire" },
		ManaSpendCost = 50,

		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.001,
			Duration = 1.0,
			DisableBlink = true,
			Force = true,
		},

		PolymorphExtractModifier = 0.5,

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.16, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.5 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.6, HoldDuration = 0.02, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 1.4 },
		},

		--[[
		FireSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		HitScreenshake = { Distance = 4, Speed = 1000, Duration = 0.10, FalloffSpeed = 3000 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.3, Duration = 0.18 },
		},

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.00, LerpTime = 0.07 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingFierce" },
			},
		},		
	},
	WeaponSpellTimeSlow = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellTimeSlowPrompt" },
		OnFiredFunctionNames = { "SpellReloadStarted", "SpellFire", "StartSpellSlow" },
		OnFiredFunctionArgs = 
		{ 
			Modifier = 0.2, 
			Duration = 7.0, 
			LoopingSound = "/SFX/Player Sounds/TimeSlowLoop",
			EndWarnNum = 3,
			EndWarnPresentationFunction = "SpellSlowWarnPresentation",
			EndSlowMotionSound = "/VO/MelinoeEmotes/EmoteGasping",
			EndSlowMotionFunctionName = "EndTimeSlow" },
		BaseDuration = 5.0,
		ManaSpendCost = 150,

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.16, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.0 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.1, HoldDuration = 1.0, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 1.4 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				-- { Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
				{
					Name = "/SFX/Player Sounds/TimeSlowCharge" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			FireSounds =
			{
				{ Name = "/VO/MelinoeEmotes/EmoteCastingFierce" },
			},
		},
	},
	WeaponSpellPotion = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellPotionPrompt" },

		OnChargeFunctionName = "nil",
		OnChargeFunctionArgs = {},

		OnFiredFunctionNames = { "SpellPotion", "SpellFire" },
		OnFiredFunctionArgs = { Amount = 15, HealDelay = 0.35 },
		HealingAmount = 15,
		ShowManaIndicator = false,
		ManaSpendCost = 80,

		FireScreenshake = { Distance = 4, Speed = 400, FalloffSpeed = 1400, Duration = 0.08, Angle = 225, ScreenPreWait = 0.19 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.5 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.08, Duration = 1.6, HoldDuration = 1.0, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 1.5 },
		},
		
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/PotionTraitTrigger" },
				{ Name = "/VO/MelinoeEmotes/EmoteCastingAlt" },
			},
		},
		EffectsForPackaging = { "SelfBuffOutput" }
	},
	WeaponSpellLeap = 
	{
		InheritFrom = { "BaseSpell", },
		CompleteObjectivesOnFire = { "SpellLeapPrompt" },
		OnFiredFunctionNames = {"SpellFire", "SetupSpellLeap" },
		ExpireProjectilesOnFire = {"ProjectileAxeSpin"},
		ManaSpendCost = 40,
		ShowManaIndicator = false,
		RiseDistance = 400,
		RiseTime = 0.6,			--Ascent duration
		HangTime = 0.1,				--Pause at apex duration
		LandingTime = 0.175,			--Descent duration
		LeapRiseSound = "/VO/MelinoeEmotes/EmoteChargingAxe",
		LeapFlightSound = "/VO/MelinoeEmotes/EmotePoweringUpLeap",
		LeapLandingSound = "/SFX/Player Sounds/LeapTraitImpact",
		LeapRiseAnimation = "MelinoeCrossCastHold",
		LeapFlightAnimation = "MelinoeSpellFireHoldFrame",
		LeapLandingAnimation = "Melinoe_Leap_Landing",
		--[[
		TouchdownSimSlow = 
		{
			LeapFraction = 0.8,		--part of descent to pause
			Fraction = 0.05,		--Sim slow degree
			Duration = 0.3,			--Duration of slow hold
		},
		]]

		OnChargeFunctionArgs = 
		{
			TimeSlowModifier = 0.10,
			Duration = 1.0,
			DisableBlink = true,
			ManualBlinkReenable = true,
			SpellChargePresentationFunction = "SpellChargeTimeSlowPresentationSoftVignette",
		},
		OnChargeCancelFunctionName = "LeapEnableBlink",

		HitScreenshake = { Distance = 8, Speed = 800, FalloffSpeed = 1400, Duration = 0.24, Angle = 90, ScreenPreWait = 0.02 },

		ChargeScreenshake = { Distance = 2, Speed = 100, FalloffSpeed = 2000, Duration = 1.0 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.1, Duration = 1.1, HoldDuration = 1.0, RestoreDefaultDuration = 0.4 },

		ChargeRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.14, Duration = 1.0 },
		},

		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/LeapTraitCharge" },
			},
		},
	},		
	-- Enemy Weapons

	BaseCollisionWeapon =
	{
		StartingWeapon = false,
		BlockWrathGain = true,

		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},

		Upgrades = { },
		HitText = "BodySlamHit",
		KillText = "BodySlamHit",

		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Brick = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Stone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Organic = "/Leftovers/World Sounds/PhysicalImpactPunch",
			},
		},
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
				Multiplicative = true
			}
		}
	},

}

GameData.WeaponEquipOrder =
{
	"WeaponBlink",
	"WeaponCast",
	"WeaponCastArm",
}

GameData.MissingPackages =
ToLookup({
	"WeaponUpgrade",
	"WeaponCastArm",
	"WeaponDaggerThrow",
	"WeaponSprint",
	"WeaponAxeBlock2",
	"WeaponStaffBall",
	"WeaponLobSpecial",
	"StackUpgrade",
	"WeaponTorchSpecial",
	"FlashbackHadesBlink",
	"WeaponSpellNova",
	"WeaponCastProjectile",
	"WeaponCastProjectileHades",
	"EncounterStartBuffWeapon",
	"PoseidonSprintWeapon",
})