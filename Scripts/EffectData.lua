EffectData =
{
	NoShakeEffect =
	{
		CancelCameraShake = true,
	},
	NoSlowFrameEffect =
	{
		CancelSlowFrames = true,
	},
	BlockReloadEffect = 
	{
		BlockReload = true
	},
	ApolloColorProjectile =
	{
		DamageTextStartColor = Color.ApolloDamageLight,
		DamageTextColor = Color.ApolloDamage,
	},

	VulnerabilityIndicator = 
	{
		DisplaySuffix = "VulnerabilityIcon",
		Icon = "HealthbarVulnerability",
		AttachIconToHealthbar = true,
		HideOnHero = true,
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},

	Charm = 
	{
		Vfx = "AphroditeDebuffStatus",
	},
	LaserFireCancelable = 
	{
		OnClearFunctionName = "LaserHoldClear",
		DataProperties = 
		{
			Duration = 3600,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			Cancelable = true,
			RequestTriggerLock = true,
			Active = true,
		}
	},
	LaserFireEndCancelable = 
	{
		DataProperties = 
		{
			Duration = 12/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = false,
			Cancelable = true,
			RequestTriggerLock = true,
			Active = true,
		}
	},
	StunEffect = 
	{
		EffectData = {
			DeepInheritance = true,
			Duration = 1,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			Active = true,
			CanAffectInvulnerable = false,
			IgnoreName = "_PlayerUnit"
		}
	},
	BlindEffect = 
	{
		InheritFrom = { "ApolloColorProjectile" },
		DisplaySuffix = "Blind",
		Vfx = "ApolloBlindDebuffFx",
		StopVfxes = { "ApolloGroundGlowDebuff", "ApolloBlindDebuffFlare" },
		EffectGroup = "Blind",
		EffectData = {
			DeepInheritance = true,
			EffectGroup = "Blind",
			StacksWithEffectGroup = "Blind",
			DeduplicateGroup = "Blind",
			Stacks = false,
			Duration = 9,
			MissChance = 0.2,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	BlindPrimary = 
	{
		InheritFrom = {"BlindEffect"},
	},
	BlindSecondary = 
	{
		InheritFrom = {"BlindEffect"},
	},
	BlindDash = 
	{
		InheritFrom = {"BlindEffect"},
		EffectData = {
			Duration = 9,
		}
	},
	BlindRetaliate = 
	{
		InheritFrom = {"BlindEffect"},
	},
	InvulnerableEffect = 
	{
		ShowInvincububble = true
	},
	ShoutSelfSlow = 
	{
		EffectData = 
		{
			Type = "SPEED",
			Duration = 0.4,
			Modifier = 0.3,
			Active = true,
			DisableRotate = true,
			CanAffectInvulnerable = true,
		}
	},
	BlockEffect = 
	{
		BlockEffect = true
	},
	CastInvulnerable = 
	{
		InheritFrom = {"InvulnerableEffect"},
	},
	SafeZone = 
	{
		InheritFrom = {"InvulnerableEffect"},
		OnApplyFunctionName = "CheckSafeZoneRecharge",
	},
	BuffInvulnerable = 
	{
		InheritFrom = {"InvulnerableEffect"},
	},
	EncounterStartInvulnerableBuff = 
	{
		InheritFrom = {"InvulnerableEffect"},
		OnApplyFunctionName = "CheckInvulnerableFalloff",
	},
	HeraColorProjectile =
	{
		DamageTextStartColor = Color.HeraDamageLight,
		DamageTextColor = Color.HeraDamage,
	},
	DamageEchoEffect = 
	{
		InheritFrom = { "ZeusColorProjectile" },
		DisplaySuffix = "Amplify",
		Vfx = "ZeusEchoDebuff",
		EffectData = { 
			Duration = 4,
			DamageThreshold = 120,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
		Cooldown = 0.6,
		OnDamagedFunctionName = "DamageEchoProcess",
		OnApplyFunctionName = "DamageEchoApply",
		OnClearFunctionName = "DamageEchoClear",
		ProjectileName = "ZeusEchoStrike",
	},
	DamageEchoVulnerabilityPlaceholder = 
	{
		DataProperties = 
		{
			Duration = 0.5,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit",
		}
	},
	SelfBuffOutput = 
	{
		OverrideVfxName = "GrenadeSelfDamageOutputFx",
		DefaultVfxName = "GrenadeSelfDamageOutputFx",
		OnApplyFunctionName = "SelfBuffOutputApply",
		OnClearFunctionName = "SelfBuffOutputClear",
	},
	ManaSpendBuff = 
	{
		Vfx = "AresKillDamageBuffFx",
	},
	DamageEchoPrimary = 
	{
		InheritFrom = {"DamageEchoEffect"},	
	},
	DamageEchoSecondary = 
	{
		InheritFrom = {"DamageEchoEffect"},	
	},
	DamageEchoSprint = 
	{
		InheritFrom = {"DamageEchoEffect"},	
	},
	HestiaColorProjectile =
	{
		DamageTextStartColor = Color.HestiaDamageLight,
		DamageTextColor = Color.HestiaDamage,
	},
	GhostEffect = 
	{
		EffectData = 
		{
			Type = "SPEED",
			Duration = 3,
			DodgeChance = 0.0,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	SpeedBoostEffect = 
	{
		DataProperties = 
		{
			Type = "SPEED",
			Duration = 1.15,
			DodgeChance = 0.0,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	CastSpeedBoostEffect = 
	{
		DataProperties = 
		{
			Type = "SPEED",
			Duration = 3600,
			Modifier = 1.5,
			CanAffectInvulnerable = true,
		}
	},
	CastGripEffect = 
	{
		Vfx = "CastSpeedSparkleEmitter",
		DataProperties = 
		{
			Type = "GRIP",
			Duration = 2,
			Modifier = 2,
			CanAffectInvulnerable = true,
		}
	},
	BurnEffect =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect", "HestiaColorProjectile" },
		DisplaySuffix = "Burn",
		EffectGroup = "Burn",
		HideStacks = false,
		--Color = Color.DarkGray,
		Color = Color.Orange,
		Icon = "FireWorldSmall",
		DamageRandomOffsetX = 0,
		DamageTextSizeOffsetY = -15,
		ShowDuration = false,
		BlockCrit = true,
		BlockDoubleDamage = true,
		BlockDamageFloor = true,
		DurationAlpha = 0.6,
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		RapidDamageType = true,
		SkipDamageText = true,
		UpdateStacksOnReapply = true,
		AttachIconToUnit = true,
		AttachToMarker = true,
		IconYOffset = 0,
		DamageOffsetY = 180,
		InflictedVfx = "HestiaFlare",
		OnApplyFunctionName = "BurnEffectApply",
		OnClearFunctionName = "BurnEffectClear",
		CustomStackHandling = true,
		DamageHoldDuration = 0.15,
		DamagePerSecond = 100,
		DamageInterval = 1/6, -- Logical times damage is applied
		DamagePresentationInterval = 1/40, -- maximum times to pop and update damage text
		DamageTextDisplayCount = 40,
		DamageTextDisplayWindow = 1,
		MaxStacks = 999,
		EffectData = {
			Type = "DAMAGE_OVER_TIME",
			EffectGroup = "Fire",
			ExtendDurationOnReapply = true,
			Duration = 3600,
			Amount = 0,
			IsVulnerabilityEffect = true,
			Stacks = true,
			IgnoreName = "_PlayerUnit"
		},
		ScaleArgs = 
		{
			ScaleMinBelow = 5,
			ScaleMaxAbove = 200,
			MaxScale = 2.5,
			MinScale = 0.5,
		},
		TextSizeArgs = 
		{
			MinBelow = 20,
			MaxAbove = 300,
			MaxScale = 1.8,
			MinScale = 1.1,
		}
	},
	BurnSprint = 
	{
		InheritFrom = {"BurnEffect"},	
	},
	BurnPrimary= 
	{
		InheritFrom = {"BurnEffect"},	
	},
	BurnSecondary = 
	{
		InheritFrom = {"BurnEffect"},	
	},
	BurnCast = 
	{
		InheritFrom = {"BurnEffect"},	
	},
	BurnDeath = 
	{
		InheritFrom = {"BurnEffect"},	
	},
	BurnBlind = 
	{
		DataProperties = {
			Stacks = false,
			Duration = 9,
			MissChance = 0.2,
			IgnoreName = "_PlayerUnit"
		}
	},
	SteamEffect =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},	
		Vfx = "SteamFx",
		EffectData = {
			Type = "DAMAGE_OVER_TIME",
			Duration = 8,
			Cooldown = 0.2,
			Amount = 2,
			IsVulnerabilityEffect = true,
			RefreshOnExpireWithEffect = "RefreshBurn"
		},
	},
	PolyphemusStomachAche =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},	
		Vfx = "SteamFx",
		EffectData = {
			Type = "DAMAGE_OVER_TIME",
			Duration = 5,
			Cooldown = 0.5,
			Amount = 20,
			IsVulnerabilityEffect = true,
			RefreshOnExpireWithEffect = "RefreshBurn"
		},
	},
	SprintStasisEffect =
	{
		DataProperties = {
			Duration = 0.315,
			ElapsedTimeMultiplier = 0.001,
			ExtendDurationOnReapply = false,
			IgnoreName = "_PlayerUnit"
		},
		OnApplyFunctionName = "TimeSlowApply",
		OnClearFunctionName = "TimeSlowClear",
	},
	ChillEffect =
	{
		DisplaySuffix = "Root",
		EffectGroup = "Root",
		Icon = "RootSmall",
		VfxRequireKey = "RootActive",
		Vfx = "DemeterRootFxFront",
		BackVfx = "DemeterRootFxBack",
		VfxRequiresTimeSlow = true,
		ShowDuration = true,
		SharedVulnerabilityCategory = "Root",
		EffectData = {
			Duration = 10,
			ElapsedTimeMultiplier = 0.01,
			ExpiringTimeThreshold = 8,
			ExpiringModifierFalloff = 1,
			IsVulnerabilityEffect = true,
			ExtendDurationOnReapply = false,
			IgnoreName = "_PlayerUnit"
		},
		OnApplyPresentationFunctionName = "RootApplyPresentation",
		OnStackDecreasePresentationFunctionName = "RootClearPresentation",
		OnClearPresentationFunctionName = "RootClearPresentation",
		OnApplyFunctionName = "TimeSlowApply",
		OnEffectStackDecreaseFunctionName = "TimeSlowUpdate",
		OnClearFunctionName = "TimeSlowClear",
	},
	ChillPrimary = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	ChillStatueEffect = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	ChillSecondary = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	ChillSprint = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	ChillCast = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	ChillCastBonus = 
	{
		InheritFrom = {"ChillEffect"},	
	},
	LegacyChillEffect =
	{
		DisplaySuffix = "Chill",
		EffectGroup = "Chill",
		Vfx = "DemeterSlowFront",
		SharedVulnerabilityCategory = "Root",
		EffectData = {
			Duration = 3,
			ElapsedTimeMultiplier = 0.8,
			IgnoreName = "_PlayerUnit",
			IsVulnerabilityEffect = true,
		},
		OnApplyPresentationFunctionName = "ChillApplyPresentation",
		OnClearPresentationFunctionName = "ChillClearPresentation",
		OnApplyFunctionName = "TimeSlowApply",
		OnClearFunctionName = "TimeSlowClear",
	},
	DemeterStun =
	{
		InheritFrom = {"StunEffect"},	
	
		EffectData = {
			Duration = 3,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
		OnApplyFunctionName = "FreezeFrameApply",
		OnClearFunctionName = "FreezeFrameClear",
	},

	HoundStun =
	{
		InheritFrom = {"StunEffect"},	
	
		EffectData = {
			Duration = 1.0,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit",

			ElapsedTimeMultiplier = 0.01,
			ExpiringTimeThreshold = 1,
			ExpiringModifierFalloff = 1,
		},
		--OnApplyFunctionName = "FreezeFrameApply",
		--OnClearFunctionName = "FreezeFrameClear",
	},
	CastVacuumStun =
	{
		--InheritFrom = {"StunEffect"},	
	
		EffectData = {
			Duration = 1.0,
			IsVulnerabilityEffect = false,
			IgnoreName = "_PlayerUnit"
		},
		OnApplyFunctionName = "FreezeFrameApply",
		OnClearFunctionName = "FreezeFrameClear",
	},
	IcedEffect = 
	{
		Vfx = "DemeterSlowImpact",
		EffectData = {
			Duration = 3600,
			IgnoreName = "_PlayerUnit"
		}
	},
	ReserveManaInvulnerability = 
	{
		Vfx = "DemeterHitShieldIn",
		OffsetZ = 120,
		EffectData = 
		{
			Modifier = 1.0,
			Duration = 1000,
			CanAffectInvulnerable = true,
			OnlyAffectName = "_PlayerUnit"
		},
		OnClearFunctionName = "ClearReserveManaInvulnerability",
	},
	DelayedKnockbackEffect = 
	{
		DamageTextStartColor = Color.HephaestusDamageLight,
		DamageTextColor = Color.HephaestusDamage,
		DisplaySuffix = "PoseidonWet",
		EffectGroup = "PoseidonWet",
		Vfx = "HephaestusVentDecal",
		-- BackVfx = "PoseidonElementalStatusBackLoop",
		--StopVfxesPreventChain = {"PoseidonElementalStatusFront", "PoseidonElementalStatusBack", "PoseidonElementalStatusBackLoop", "PoseidonElementalStatusFrontLoop"},
		CreateAnimationOnDamage = "HephaestusVentExplosion",
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Modifier = 1.2,
			Duration = 5,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit",
		}
	},

	AmplifyKnockbackEffect = 
	{
		Vfx = "PoseidonElementalStatusFrontLoop",
		BackVfx = "PoseidonElementalStatusBackLoop",
		DisplaySuffix = "Froth",
		StopVfxes = {"PoseidonElementalStatusFrontLoop", "PoseidonElementalStatusBackLoop" },
		StopVfxesPreventChainOnCancel = {"PoseidonElementalStatusFrontLoop", "PoseidonElementalStatusBackLoop" },
		EffectData = {
			Duration = 3,
			Modifier = 1.05,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
		OnDamagedFunctionName = "CheckPoseidonFont",
		ProjectileName = "PoseidonEffectFont",
		ProjectileNameBlacklist = 
		{
			"PoseidonEffectFont",
			"SteamBlast",
		},
		Chance = 0.25,
		Cooldown = 0.6,
	},
	PoseidonStun = 
	{
		InheritFrom = {"StunEffect"},
		StunAnimationType = "Heavy",
		EffectData = {
			Duration = 1.7,
		},
	},
	BlockStun = 
	{
		InheritFrom = { "StunEffect" },
		StunAnimationType = "BlockStun",
		EffectData = {
			Duration = 0.5,
		},
		StunThroughHealthBuffer = true,
		OnApplyFunctionName = "OnHitStunApply",
		OnClearFunctionName = "OnHitStunClear",
		Vfx = "DionysusStunnedFx",
	},
	ImpactSlow = 
	{
		Name = "ImpactSlow",
		Vfx = "GraspingHandsFxIn",
		StopVfxes = { "GraspingHandsFxLoop" },
		StopVfxesPreventChain = { "GraspingHandsFxIn" },
		DataProperties = 
		{
			IgnoreName = "_PlayerUnit",
			Type = "SPEED",
			Duration = 0.2,
			Modifier = 0.05,
			Active = true,
			CanAffectInvulnerable = false,
			HaltOnStart = true,
			TimeModifierFraction = 0,
		},
	},
	ImpactGrip = 
	{
		Name = "ImpactGrip",
		DataProperties = 
		{
			IgnoreName = "_PlayerUnit",
			Type = "GRIP",
			Duration = 0.2,
			Modifier = 10,
			CanAffectInvulnerable = false,
		},
	},
	EncounterStartOffense = 
	{
		Vfx = "PoseidonEncounterStartBuff",
		EffectData = {
          Duration = 10,
		  Modifier = 1,
          TimeModifierFraction = 0,
		}

	},
	DrainStun = 
	{
		InheritFrom = { "StunEffect" },
		EffectData = {
			Duration = 0.5,
		},
		Vfx = "DionysusStunnedFx",
		OnApplyFunctionName = "FreezeFrameApply",
		OnClearFunctionName = "FreezeFrameClear",
	},
	ShieldSelfInvulnerableRush = 
	{
		InheritFrom = { "BlockEffect" },
	},
	ShieldSelfReflectRush = 
	{
		InheritFrom = { "BlockEffect" },
	},

	ZeusColorProjectile =
	{
		DamageTextStartColor = Color.ZeusDamageLight,
		DamageTextColor = Color.ZeusDamage,
	},
	ZeusStun = 
	{
		InheritFrom = {"StunEffect"},
		StunAnimationType = "Lightning",
		EffectData = {
			Duration = 0.3,
		},
		Vfx = "ZeusStaticArcEmitter",
	},
	ZeusRepeatedStun = 
	{
		--InheritFrom = {"StunEffect"},
		Interval = 0.35,
		--StunAnimationType = "Lightning",
		EffectData = {
			Duration = 3.0,
			IgnoreName = "_PlayerUnit"
		},
	},
	
	WeakEffect = 
	{
		DisplaySuffix = "Weak",
		EffectGroup = "Weak",
		Vfx = "AphroditeWeakFxFront_In",
		BackVfx = "AphroditeWeakFxBack_In",
		VfxPreventChainOnStop = true,
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
		EffectData =
		{
            Type = "DAMAGE_OUTPUT",
            Duration = 1,
            Modifier = 0.7,
            IsVulnerabilityEffect = true,
            IgnoreName = "_PlayerUnit"
		},
	},
	WeakCast = 
	{
		InheritFrom = {"WeakEffect"},
	},
	WeakPrimary = 
	{
		InheritFrom = {"WeakEffect"},
	},
	WeakSecondary = 
	{
		InheritFrom = {"WeakEffect"},
	},
	WeakDash = 
	{
		InheritFrom = {"WeakEffect"},
	},
	WeakDamageTaken = 
	{
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Duration = 3,
			Modifier = 1.3,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	WeakDamageOutput = 
	{
		EffectData = {
			Type = "DAMAGE_OUTPUT",
			Duration = 3,
			Modifier = 0.9,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	DamageShareDeath = 
	{
		-- Not a real effect, here for color @alice
		DamageTextStartColor = Color.HeraDamageLight,
		DamageTextColor = Color.HeraDamage,
	},
	DamageShareEffect =
	{
		DisplaySuffix = "DamageShare",
		EffectGroup = "DamageShare",
		Icon = "DamageShareSmall",
		Vfx = "HeraTwistStatus",
		DamageTextStartColor = Color.HeraDamageLight,
		DamageTextColor = Color.HeraDamage,
		OnDamagedFunctionName = "ProcessDamageShare",
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,		
		Using = "HeraRope",
		OnApplyFunctionName = "DamageShareApply",
		OnClearFunctionName = "DamageShareClear",
		TriggerOnKillingBlow = true,
		DistanceCheckDamageNumbers = true,
		Range = 1200,
		EffectData = {
			Type = "DAMAGE_OUTPUT",
			Duration = 8,
			Cooldown = 2,
			Amount = 0.30,
			Modifier = 1,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
	},
	DamageOverTime =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		DamageTextStartColor = Color.DionysusDamageLight,
		DamageTextColor = Color.DionysusDamage,
		DamageTextSize = 25,
		DisplaySuffix = "Poison",
		Icon = "PoisonSmall",
		OnApplyFunctionName = "DamageOverTimeApply",
		DataProperties = {
			Type = "DAMAGE_OVER_TIME",
			Duration = 4,
			Cooldown = 0.5,
			Amount = 25,
			CanAffectInvulnerable = true,
		},
	},
	InsideCastBuff = 
	{
		OnApplyFunctionName = "InsideCastBuffApply",
		OnClearFunctionName = "InsideCastBuffClear",
		MetaUpgradeActiveVfx = "ManaRegenLoopingNoSound",
		ManaRegenStartVfx = "ManaRegenFlashFx",
		DataProperties = 
		{
			Duration = 0.2,
			Active = true,
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0
		}
	},
	LavaVignette =
	{
		OnApplyFunctionName = "LavaVignetteApply",
		OnClearFunctionName = "LavaVignetteClear",
	},
	SatyrEnlarge =
	{
		OnApplyFunctionName = "EnlargeApply",
		--OnClearFunctionName = "EnlargeClear",
		ScaleMultiplier = 1.6,
		HealthMultiplier = 400,
		DamageMultiplier = 5,
	},
	OnHitStunHeavy =
	{
		OnApplyFunctionName = "OnHitStunApply",
		OnClearFunctionName = "OnHitStunClear",
		StunAnimationType = "Heavy",
	},
	FreezeStun =
	{
		OnApplyFunctionName = "FreezeStunApply",
	},
	StasisStun =
	{
		OnApplyFunctionName = "StasisStunApply",
		OnClearFunctionName = "StasisStunClear",
		IgnoreName = "Chronos"
	},
	OnHitStun =
	{
		StunAnimationType = "Default",
		BlockReload = true
	},
	OnSprintHitStun = 
	{
		InheritFrom = {"OnHitStun"},
		StunThroughHealthBuffer = true,
		DataProperties = 
		{
			Duration = 0.2,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = false,
		},
		OnApplyFunctionName = "OnHitStunApply",
		OnClearFunctionName = "OnHitStunClear",
	},
	OnHitStunAxeBlock =
	{
		InheritFrom = {"OnHitStun"},
		OnApplyFunctionName = "OnHitStunApply",
		OnClearFunctionName = "OnHitStunClear",
	},
	HeroOnHitStun = 
	{
		BlockReload = true
	},
	HadesInvisible = 
	{
		OnClearFunctionName = "HadesInvisibleClear",
		EffectData = 
		{
			Duration = 10,
		}
	},
	MatiHypnosis =
	{
		OnApplyFunctionName = "MatiHypnosisApply",
		OnClearFunctionName = "MatiHypnosisClear",

		DataProperties = 
		{
			MoveSpeed = 200,
		}
	},
	HecatePolymorphStun = 
	{
		OnApplyFunctionName = "HecatePolymorphApply",
		OnClearFunctionName = "HecatePolymorphClear",
	},
	HostilePolymorphSpeed = 
	{
		DataProperties = 
		{
			Type = "SPEED",
			Modifier = 0.35,
			Duration = 1,
			Active = true,
		}
	},
	ChronosPolymorphStun = 
	{
		OnApplyFunctionName = "ChronosPolymorphApply",
		OnClearFunctionName = "ChronosPolymorphClear",
		DataProperties = 
		{
			Duration = 9999,
			Active = true,
			CanAffectInvulnerable = true,
		}
	},
	PolymorphTag = 
	{
		EffectName = "PolymorphTag",
		OnApplyFunctionName = "CheckPolymorphApply",
		Vfx = "SorceryNightCurseStatusFront",
		BackVfx = "SorceryNightCurseStatusBack",
		DataProperties = 
		{
			IgnoreExactName = "_PlayerUnit",
			Duration = 4,
			Active = true,
			CanAffectInvulnerable = false,
		},
		FireProjectileOnApply = 
		{
			WeaponName = "WeaponSpellPolymorph",
			ProjectileName = "MorphDamageProjectile"
		}
	},
	PolymorphDamageTaken = 
	{
		EffectName = "PolymorphDamageTaken",
		DataProperties = 
		{	
			Type = "DAMAGE_TAKEN",
			Duration = 10,
			Modifier = 1.5,
			Active = true,
		}
	},
	PolymorphStun = 
	{
		OnApplyFunctionName = "PolymorphStunApply",
		OnClearFunctionName = "PolymorphStunClear",
	},
	PolyphemusPlayerGrab = 
	{
		EffectName = "PolyphemusPlayerGrab",
		OnApplyFunctionName = "PolyphemusPlayerGrabApply",
		OnClearFunctionName = "PolyphemusPlayerGrabClear",
		EffectData = {
			Type = "DAMAGE_OVER_TIME",
			Duration = 3.5,
			Cooldown = 0.5,
			Amount = 5,
			IsVulnerabilityEffect = true,
			CanAffectInvulnerable = true,
		},
	},
	MedeaPoison = 
	{
		EffectName = "MedeaPoison",
		CancelCameraShake = true,
		CancelSlowFrames = true,
		RapidDamageType = true,
		IgnoreOnHitEffects = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		DamageTextSize = 25,
		OnApplyFunctionName = "MedeaPoisonApply",
		OnClearFunctionName = "MedeaPoisonClear",
	},
	MedeaPoisonAllyBoost =
	{
		OnApplyFunctionName = "MedeaPoisonAllyBoostApply",
		OnClearFunctionName = "MedeaPoisonAllyBoostClear",
	},
	TimeElementalHeal =
	{
		OnApplyFunctionName = "TimeElementalHealApply",
	},
	Rooted =
	{
		Vfx = "DionysusStunnedFx",
		OnApplyFunctionName = "RootedApply",
		OnClearFunctionName = "RootedClear",
	},
	AcidDoT =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
	},
	TimeElementalSpeedBoost =
	{
		EffectName = "SpeedBoost",
		DataProperties = 
		{
			Type = "SPEED",
			Modifier = 1.60,
			Duration = 1.30,
		}
	},
	DoraSlow =
	{
  		EffectName = "DoraSlow",
		EffectData = {
			Type = "SPEED",
			Modifier = 0.8,
			Duration = 0.5,
			Active = true,
		},
	},

	WebSlow =
	{
		EffectName = "WebSlow",
		Vfx = "DemeterSlowFront",
		DataProperties = 
		{
			Type = "SPEED",
			Modifier = 0.7,
			Duration = 2.0,
		}
	},
	GhostWallHalt =
	{
		EffectName = "GhostWallHalt",
		--Vfx = "DemeterSlowFront",
		DataProperties = 
		{
			Type = "GRIP",
			Duration = 0.12,
			Modifier = 1.0,
			HaltOnEnd = true,
		}
	},
	
	AddHitShields =
	{
		OnApplyFunctionName = "EliteSpreadHitShields",
	},
	
	EliteManaDrain =
	{
		OnApplyFunctionName = "ShrineEliteAttributeManaDrain",
		OnApplyFunctionArgs =
		{
			Amount = -10,
		}
	},
	AutomatonMark =
	{
		EffectName = "AutomatonMark",
		Vfx = "AutomatonBeamerVulnerableFxFront",
		BackVfx = "AutomatonBeamerVulnerableFxBack",
		OnApplyFunctionName = "HuntersMarkApplyPresentation",
		CritVulnerability = 1,
	},
	ArtemisHuntersMark =
	{
		EffectName = "WebSlow",
		Vfx = "ArtemisCritVulnerabilityStatus",
		OnApplyFunctionName = "HuntersMarkApplyPresentation",
		UnitDeathFunctionName = "HuntersMarkUnitDeathPresentation",
		CritVulnerability = 1,
	},
	ArtemisBoonHuntersMark =
	{
		EffectName = "ArtemisHunterMark",
		Vfx = "ArtemisCritVulnerabilityStatusIn",
		StopVfxesPreventChain = { "ArtemisCritVulnerabilityStatusIn" },
		CritVulnerability = 0.3,
		EffectData = 
		{
			Duration = 6,
			Modifier = 1,
			TimeModifierFraction = 0,
		}
	},
	RavenFamiliarMark =
	{
		EffectName = "RavenFamiliarMark",
		Vfx = "RakiCritVulnerabilityStatusIn",
		StopVfxesPreventChain = { "RakiCritVulnerabilityStatusIn" },
		CritVulnerability = 0.15,
		EffectData = 
		{
			Duration = 6,
			Modifier = 1,
			TimeModifierFraction = 0,
		},
	},
	ErisSelfBuff = 
	{
		Name = "ErisSelfBuff",
		Vfx = "ErisPowerUpFx",
		OnApplyFunctionName = "ErisSelfBuffApply",
		OnClearFunctionName = "ErisSelfBuffClear",
	},

	HecateDarkSide =
	{
		OnApplyFunctionName = "HecateDarkSideApply",
		OnClearFunctionName = "HecateDarkSideClear",
		OnApplyFunctionArgs =
		{
			AddIncomingDamageModifier =
			{
				Name = "HecateDarkSide",
				PlayerMultiplier = 0.8,
			},
			TemporaryWeaponOptions = { "HecateDarkSideRanged", "HecateDarkSideRangedExtended", "HecateDarkSideRing", },
		},
		OnClearFunctionArgs =
		{
			RemoveIncomingDamageModifier ="HecateDarkSide"
		},
	},

	BlockEmpower = 
	{
		Name = "BlockEmpower",
		Vfx = "ErisPowerUpFx",	
		DataProperties = 
		{
			Type = "DAMAGE_OUTPUT",
			Duration = 10,
			Modifier = 1,
			TimeModifierFraction = 0,
		}
	},
	StaffSelfBuff = 
	{
		Name = "StaffSelfBuff",
		Vfx = "ErisPowerUpFx",	
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			OnlyAffectName = "_PlayerUnit"
		},
		OnApplyFunctionName = "StaffSelfBuffApply",
		OnClearFunctionName = "StaffSelfBuffClear"
	},

	ClearCast = 
	{
		Name = "ClearCast",
		Vfx = "ErisPowerUpFx",
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			OnlyAffectName = "_PlayerUnit",
			Amount = 1.5,
			Duration = 5,
		},
		OnApplyFunctionName = "ClearCastApply",
		OnClearFunctionName = "ClearCastClear"
	},
	ClearCastPoseidon = 
	{
		InheritFrom = { "ClearCast" },
		Vfx = "PoseidonManaBoonFxEmitter",
		-- BackVfx = "PoseidonElementalStatusBackLoopBase",
		StopVfxesPreventChain = {"PoseidonManaBoonFxFront", "PoseidonManaBoonFxBack" },
	},
	NyxBlastReady = 
	{
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			Type = "SPEED",
			Modifier = 1.05,
		}
	},
	NyxHitBuff = 
	{
		Vfx = "WeaponBonusFxNyx",
		StopVfxes = { "WeaponBonusFx", "WeaponBonusFxBack"},
		DataProperties = 
		{
			Active = true,
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0
		}
	},
	OmegaDamageBuffEffect = 
	{
		Name = "OmegaBuff",
		Vfx = "OmegaDamageBuffFx",
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			Amount = 1.3,
			OnlyAffectName = "_PlayerUnit"
		},
		OnApplyFunctionName = "OmegaBuffApply",
		OnClearFunctionName = "OmegaBuffClear"

	},

	DrainVulnerabilityEffect = 
	{
		Name = "DrainVulnerabilityEffect",
		Vfx = "DemeterSlowFront",
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Duration = 10,
			Modifier = 1.3,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	MeteorVulnerabilityEffect = 
	{
		Name = "MeteorVulnerabilityEffect",
		DataProperties = {
			Type = "DAMAGE_TAKEN",
			Duration = 0.3,
			Modifier = 0.3,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	MeteorSlowEffect = 
	{
		Name = "MeteorSlowEffect",
		DataProperties = {
			Type = "SPEED",
			Duration = 0.3,
			Modifier = 0.3,
			IgnoreName = "_PlayerUnit"
		}
	},
	MeteorGripEffect = 
	{
		Name = "MeteorGripEffect",
		DataProperties = {
			Type = "GRIP",
			Duration = 0.3,
			Modifier = 10,
			IgnoreName = "_PlayerUnit"
		}
	},

	RushWeaponInvulnerable = 
	{
		Name = "RushWeaponInvulnerable",
		OnApplyFunctionName = "PlayerSprintPhasingApply",
		OnClearFunctionName = "PlayerSprintPhasingClear"
	},

	RushWeaponInvulnerableCharge = 
	{
		Name = "RushWeaponInvulnerableCharge",
		OnApplyFunctionName = "PlayerSprintPhasingApply",
		OnClearFunctionName = "PlayerSprintPhasingClear"
	},
	LobWeaponInvulnerable = 
	{
		Vfx = "LobInvincibubbleIn",
		StopVfxes = { "LobInvincibubble" },
		StopVfxesPreventChain = { "LobInvincibubbleIn"},
		EffectData = {
			Type = "INVULNERABLE",
			Duration = 2,
			Modifier = 1.0,
			NoUnitCollision = true,
			CanAffectInvulnerable = true,
		}
	},
	LobWeaponShortInvulnerable = 
	{
		OnApplyFunctionName = "LobShortInvulnerableApply",
		OnClearFunctionName = "LobShortInvulnerableClear",
		EffectData = {
			Type = "INVULNERABLE",
			Duration = 3/60,		--3 frames of invulnerability
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	
	AthenaInvulnerable = 
	{
		ShowInvincububble = false,
        Vfx = "AthenaProtectionFront",
		BackVfx = "AthenaProtectionBack",
		StopVfxesPreventChainOnCancel = { "AthenaProtectionFront", "AthenaProtectionFrontOut", "AthenaProtectionBack", "AthenaProtectionBackOut" },
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
			FlashFrontFxWhenExpiring = false,
			FlashBackFxWhenExpiring = false,
		}
	},

	AthenaProjectileDefense = 
	{
		DataProperties = {
			Type = "PROJECTILE_DEFENSE",
			Duration = 8,
			Modifier = 1.0,
			Range = 120,
			Deflect = true,
			CanAffectInvulnerable = true,
		}
	},
	
	AthenaDeflect= 
	{
		InheritFrom = {"InvulnerableEffect"},
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	IcarusInvulnerable = 
	{
		InheritFrom = {"InvulnerableEffect"},
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			NoUnitCollision = true,
			CanAffectInvulnerable = true,
		}
	},
	MeteorInvincibubble = 
	{
		InheritFrom = {"InvulnerableEffect"},
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	PotionBuff= 
	{
		Vfx = "PoseidonElementalStatusFrontLoop",
		BackVfx = "PoseidonElementalStatusBackLoop",
		StopVfxes = {"PoseidonElementalStatusFrontLoop", "PoseidonElementalStatusBackLoop" },
		DataProperties = {
			Duration = 20,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		},
		OnApplyFunctionName = "PotionBuffApply",
		OnClearFunctionName = "PotionBuffClear"
	},
	DaggerBlockInvincibubble = 
	{
		InheritFrom = {"InvulnerableEffect"},
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		},
		OnApplyFunctionName = "EffectUninterruptibleApply",
		OnClearFunctionName = "EffectUninterruptibleClear"
	},
	MiasmaSlow = 
	{
		AttackSpeedMultiplier = 1.5,
		SprintSpeedMultiplier = 0.5,
		OnApplyFunctionName = "MiasmaSlowApply",
		OnClearFunctionName = "MiasmaSlowClear"

	},
	SheepSickSlow = 
	{
		AttackSpeedMultiplier = 1.0,
		SprintSpeedMultiplier = 0.5,
		SkipPresentation = true,
		OnApplyFunctionName = "MiasmaSlowApply",
		OnClearFunctionName = "MiasmaSlowClear"

	},
	DemeterSlow = 
	{
		AttackSpeedMultiplier = 1.5,
		SprintSpeedMultiplier = 0.5,
		Vfx = "DemeterRootFxFront",
		BackVfx = "DemeterRootFxBack",
	},

	ChaosStun =
	{
		Vfx = "DionysusStunnedFx",
		EffectData = 
		{
			Duration = 1.2,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			Cancelable = false,
		}
	},

	EliteAttributeStun = 
	{
		Vfx = "DionysusStunnedFx",
		EffectData = 
		{
			Duration = 1.2,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			Cancelable = false,
		}
	},
	-- Staff Disables
	Swing1Disable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	Swing2Disable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	Swing3Disable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	Swing5Disable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	SwingDashDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	Special1Disable =
	{
		OnApplyFunctionName = "StaffSpecialTriggerLockApply",
		OnClearFunctionName = "StaffSpecialTriggerLockClear",
	},

	-- Dagger Disables
	-- Swing1Disable, Swing2Disable, Swing5Disable

	DaggerSpecial1Disable =
	{
		OnApplyFunctionName = "DaggerSpecialTriggerLockApply",
		OnClearFunctionName = "DaggerSpecialTriggerLockClear",
	},
	SwingMultiDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	SwingDoubleDisable =
	{
		OnApplyFunctionName = "BlinkAndCastTriggerLockApply",
		OnClearFunctionName = "BlinkAndCastTriggerLockClear",
	},

	Special1DisableMoveHold =
	{
		EffectData =
		{
			Duration = 0.35,
			DisableRotate = true,
			DisableMove = true,
			Cancelable = true,
		},
	},
	WeaponDaggerThrowEXDisable =
	{
		EffectData =
		{
			Duration = 16/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
		},
		OnApplyFunctionName = "DaggerSpecialTriggerLockApply",
		OnClearFunctionName = "DaggerSpecialTriggerLockClear",
	},
	WeaponDaggerThrowEXDisableCancellable =
	{
		EffectData =
		{
			Duration = 23/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
			Cancelable = true,
		},
	},
	WeaponDaggerThrowEXDisableMoveHold =
	{
		EffectData =
		{
			Duration = 30/60,
			DisableRotate = true,
			DisableMove = true,
			Cancelable = true,
		},
	},
	WeaponDaggerMorriganThrowEXDisable =
	{
		EffectData =
		{
			Duration = 14/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
		},
		OnApplyFunctionName = "DaggerSpecialTriggerLockApply",
		OnClearFunctionName = "DaggerSpecialTriggerLockClear",
	},
	WeaponDaggerMorriganThrowEXDisableCancellable =
	{
		EffectData =
		{
			Duration = 21/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
			Cancelable = true,
		},
	},
	WeaponDaggerMorriganThrowEXDisableMoveHold =
	{
		EffectData =
		{
			Duration = 30/60,
			DisableRotate = true,
			DisableMove = true,
			Cancelable = true,
		},
	},
	WeaponLobHelAttackEXDisable =
	{
		EffectData =
		{
			Duration = 18/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
		},
	},
	WeaponLobHelAttackEXDisableCancellable =
	{
		EffectData =
		{
			Duration = 30/60,
			DisableMove = true,
			DisableRotate = true,
			DisableAttack = true,
			RequestTriggerLock = true,
			Cancelable = true,
		},
	},
	DemeterTickEffect =
	{
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		RapidDamageType = true,
		DisplaySuffix = "DemeterTick",
		DataProperties = {
			Type = "DAMAGE_OVER_TIME",
			Duration = 3600,
			Cooldown = 0.2,
			Amount = 20,
		},
	},

	-- Axe Disables
	-- Swing1Disable, SwingDashDisable, Swing2Disable, Swing3Disable
	AxeSpinAttackDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	BigDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},

	-- Torch Disables
	TorchSpecialDisable =
	{
		OnApplyFunctionName = "TorchSpecialTriggerLockApply",
		OnClearFunctionName = "TorchSpecialTriggerLockClear",
	},

	-- Lob Disables
	Lob1Disable =
	{
		OnApplyFunctionName = "BlinkAndSpecialTriggerLockApply",
		OnClearFunctionName = "BlinkAndSpecialTriggerLockClear",
	},
	LobWeaponSpecialDisable = 
	{ 
		MaxDuration = 0.12,
		EffectData = 
        {
          DisableMove = true,
          DisableRotate = true,
          DisableAttack = true,
          Cancelable = false,
          RequestTriggerLock = true,
        },
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	LobWeaponSpecialDisableCancellable =
	{
		MaxDuration = 0.3,
		EffectData = 
        {
          DisableMove = true,
          DisableRotate = true,
          DisableAttack = true,
          Cancelable = true,
          RequestTriggerLock = true,
		},
		OnApplyFunctionName = "LobDisableTriggerLockApply",
		OnClearFunctionName = "LobDisableTriggerLockClear",
	},
	LobWeaponSpecialRotateLock = 
	{
		MaxDuration = 0.3,
		EffectData = 
        {
          DisableMove = false,
          DisableRotate = true,
          DisableAttack = false,
          Cancelable = true,
        }
	},
	-- Suit effects
	Suit2DisableCancellable =
	{
		OnApplyFunctionName = "SuitDisableTriggerLockApply",
		OnClearFunctionName = "SuitDisableTriggerLockClear",
	},
	SuitAttackDashDisable =
	{
		OnClearFunctionName = "SuitDashAttackLockApply",
	},
	ExAttackSuitShield = 
	{
		InheritFrom = { "BlockEffect" },
		OnClearFunctionName = "ClearSuitAttackShield",
		DataProperties = 
		{
			Type = "INVULNERABLE",
			AngleCoverage =  math.rad(220),
			CanAffectInvulnerable = true,
		},
	},
	ExAttackSuitDefense = 
	{
		InheritFrom = { "BlockEffect" },
		DataProperties = 
		{
			Type = "PROJECTILE_DEFENSE",
			AngleCoverage = math.rad(220),
			Range = 120,
			CanAffectInvulnerable = true,
		},
	},
	SuitSpecialLock = 
	{
		DataProperties = 
		{
			Duration = 3600,
			DisableMove = true,
			DisableRotate = false,
			DisableAttack = false,
			Active = true,
		}
	},
	-- Spell Disables
	LaserDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	PolymorphCastDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	SpellHealDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	WeaponLeapDisable =
	{
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
	},
	ShivaAttackBoost = 
	{
		Name = "ShivaAttackBoost",
		Vfx = "ShivaAttackBoostFx",	
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			Duration = 7200,
			Stacks = true,
			OnlyAffectName = "_PlayerUnit",
		},
		CustomStackHandling = true,
		OnApplyFunctionName = "ShivaAttackBoostApply",
		OnClearFunctionName = "ShivaAttackBoostClear",
	},
	ExecuteIndicator = 
	{
		DisplaySuffix = "ExecuteMarker",
		Icon = "HealthBarMarkerExecute",
		--AttachIconToHealthbar = true, 
		--OffsetX = -75,
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	ComboAttackIndicator = 
	{
		DisplaySuffix = "ComboAttack",
		Icon = "HealthBarMarkerAttack",
		AttachIconToUnit = true,
		AttachToMarker = true,
		IgnoreHideHealthBarOnUnits = 
		{
			NPC_Nemesis_01 = true,
			TyphonHead = true,
		},
		
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	ComboSpecialIndicator = 
	{
		DisplaySuffix = "ComboSpecial",
		Icon = "HealthBarMarkerSpecial",
		AttachIconToUnit = true,
		AttachToMarker = true,
		IgnoreHideHealthBarOnUnits = 
		{
			NPC_Nemesis_01 = true,
			TyphonHead = true,
		},
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	ComboExIndicator = 
	{
		DisplaySuffix = "ComboEx",
		Icon = "HealthBarMarkerAttackOmega",
		IgnoreHideHealthBarOnUnits = 
		{
			NPC_Nemesis_01 = true,
			TyphonHead = true,
		},
		--AttachIconToHealthbar = true, 
		--OffsetX = -25,
		AttachIconToUnit = true,
		AttachToMarker = true,
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	ComboAttackExIndicator = 
	{
		DisplaySuffix = "ComboAttackEx",
		Icon = "HealthBarMarkerAttackOmega",
		AttachIconToHealthbar = true, 
		OffsetX = -25,
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	ComboSpecialExIndicator = 
	{
		DisplaySuffix = "ComboSpecialEx",
		Icon = "HealthBarMarkerSpecialOmega",
		AttachIconToHealthbar = true, 
		OffsetX = 0,
		DataProperties = 
		{
			Duration = 3600,
			Active = true,
		}
	},
	MoonBeamVulnerability = 
	{ 
	
		OnApplyFunctionName = "MoonBeamVulnerabilityApply",
		OnClearFunctionName = "MoonBeamVulnerabilityClear",
		Vfx = "SorceryDebuffMoonLoopIn",
		StopVfxesPreventChain = { "SorceryDebuffMoonLoopIn","SorceryDebuffMoonLoop" },
		
		DataProperties = 
		{
			Duration = 8,
			Modifier = 1.5,
			FlashFrontFxWhenExpiring = false,
			FlashBackFxWhenExpiring = false,
		}
	},
	DelayedDamageEffect = 
	{
		SharedVulnerabilityCategory = "Curse",
		DataProperties = 
		{
          IgnoreName = "_PlayerUnit",
		  Type = "DAMAGE_OVER_TIME",
          Stacks = false,
          ExtendDurationOnReapply = false,
          Duration = 1.1,
          FrontFx = "AresSwordHoverLoopA",
          Active = true,
          TimeModifierFraction = 0,
          ExpiringTimeThreshold = 0.26,
          ExpiringFrontFx = "AresSwordHoverDrop",
          DamageOnExpire = true,
          IsVulnerabilityEffect = true,
		}
	},
	AresStatus = 
	{
		DisplaySuffix = "Rend",
		EffectGroup = "Rend",
		ShowDuration = false,
		Vfx = "AresDebuffFx",
		SharedVulnerabilityCategory = "Curse",
		BonusBaseDamageOnInflict = 50,
		EffectData = {
			Duration = 3,
			IsVulnerabilityEffect = true,
			ExtendDurationOnReapply = false,
			IgnoreName = "_PlayerUnit"
		},
	},
	HelOverheat = 
	{
		Vfx = "HelOverheatFx",
		OnApplyFunctionName = "OverheatApply",
		OnClearFunctionName = "OverheatClear", 
		DataProperties = 
		{
			Duration = 4,
			ExtendDurationOnReapply = false,
			FlashFrontFxWhenExpiring = false,
			FlashBackFxWhenExpiring = false,
		}
	},
	Frenzy = 
	{
		Name = "Frenzy",
		Vfx = "NergalFrenzyFx",
		BaseLifeSteal = 1,
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			OnlyAffectName = "_PlayerUnit",
			Modifier = 0.605,
			Duration = 8,
		},
		OnApplyFunctionName = "FrenzyApply",
		OnClearFunctionName = "FrenzyClear"
	},
	HadesSweepEffect = 
	{
		Name = "HadesSweep",
		Vfx = "MarkTargetHades",
		EffectData = 
		{
			Duration = 10,
			IgnoreName = "_PlayerUnit"
		}
	},
}

WeaponEffectData =
{
	AttackLowGrip =
	{
		EffectName = "AttackLowGrip",
		DataProperties = 
		{
			Type = "GRIP",
			Duration = 0.3,
			Modifier = 0.6,
			HaltOnEnd = true,
		}
	},
	AttackLowGripLong =
	{
		EffectName = "AttackLowGrip",
		DataProperties = 
		{
			Type = "GRIP",
			Duration = 0.6,
			Modifier = 0.6,
			HaltOnEnd = true,
		}
	},
	AttackHighGrip =
	{
		EffectName = "AttackHighGrip",
		DataProperties = 
		{
			Type = "GRIP",
			Duration = 0.3,
			Modifier = 1.3,
			HaltOnEnd = true,
		}
	},

  RushSpeed =
  {
  	EffectName = "RushSpeed",
	DataProperties = 
	{
  		Type = "SPEED",
  		--ChangeType = "ADD",
  		Duration = 9.0,
  		Modifier = 6,
	  }
  },

  SlowRotation =
  {
  	EffectName = "SlowRotation",
		DataProperties = 
		{
	  		Type = "SPEED",
	  		Duration = 9.0,
	  		Modifier = 1,
	  		RotationMultiplier = 0.5
		}
  },

  AssassinStalkSpeed =
  {
  	EffectName = "AssassinStalkSpeed",
		DataProperties = 
		{
	  		Type = "SPEED",
	  		Duration = 999.0,
	  		Modifier = 2.0,
		}
  },

	AutomatonDefense = 
	{
		EffectName = "AutomatonDefense",
		ClearEffectOnHit = true,
		DataProperties = 
		{
			Type = "DAMAGE_TAKEN",
			ChangeType = "ADD",
			Duration = 1.6,
			Modifier = 0.1,
			IsVulnerabilityEffect = true,
		}
	},

	Inked =
	{
		OnApplyFunctionName = "OctofishInkApply",
		OnApplyFunctionArgs =
		{
			AnimationName = "OctofishInkInside"
		},
		OnClearFunctionName = "OctofishInkClear",
		OnClearFunctionArgs =
		{
			AnimationName = "OctofishInkInside"
		},
	},
	StalkerBurrowSpeedBoost =
	{
		EffectName = "SpeedBoost",
		DataProperties = 
		{
			Type = "SPEED",
			Modifier = 2.0,
			Duration = 9999,
		}
	},
}

OverwriteTableKeys( EffectData, WeaponEffectData )