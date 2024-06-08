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
		StopVfxes = { "ApolloGroundGlowDebuff" },
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
	},
	BuffInvulnerable = 
	{
		InheritFrom = {"InvulnerableEffect"},
	},
	EncounterStartInvulnerableBuff = 
	{
		InheritFrom = {"InvulnerableEffect"},
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
			Duration = 3,
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
		IconYOffset = 0,
		DamageOffsetY = 180,
		InflictedVfx = "HestiaFlare",
		OnApplyFunctionName = "BurnEffectApply",
		OnClearFunctionName = "BurnEffectClear",
		CustomStackHandling = true,
		DamageHoldDuration = 0.15,
		DamagePerSecond = 40,
		DamageInterval = 1/6, -- Logical times damage is applied
		DamagePresentationInterval = 1/40, -- maximum times to pop and update damage text
		DamageTextDisplayCount = 40,
		DamageTextDisplayWindow = 1,
		EffectData = {
			Type = "DAMAGE_OVER_TIME",
			EffectGroup = "Fire",
			ExtendDurationOnReapply = true,
			Duration = 3600,
			Amount = 0,
			IsVulnerabilityEffect = true,
			Stacks = true,
			MaxStacks = 500,
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
	ChillEffect =
	{
		DisplaySuffix = "Root",
		EffectGroup = "Root",
		Icon = "RootSmall",
		VfxRequireKey = "RootActive",
		Vfx = "DemeterRootFxFront",
		BackVfx = "DemeterRootFxBack",
		ShowDuration = true,
		EffectData = {
			Duration = 10,
			ElapsedTimeMultiplier = 0.01,
			ExpiringTimeThreshold = 0.1,
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
		Icon = "ChillSmall",
		Vfx = "DemeterSlowFront",
		EffectData = {
			Duration = 3,
			ElapsedTimeMultiplier = 0.8,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
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
		EffectData = 
		{
			Modifier = 1.0,
			Duration = 1000,
			CanAffectInvulnerable = true,
			OnlyAffectName = "_PlayerUnit"
		}
	},
	DelayedKnockbackEffect = 
	{
		DamageTextStartColor = Color.HephaestusDamageLight,
		DamageTextColor = Color.HephaestusDamage,
		DisplaySuffix = "PoseidonWet",
		EffectGroup = "PoseidonWet",
		Icon = "EarthSmall",
		Vfx = "PoseidonElementalStatusFrontLoop",
		BackVfx = "PoseidonElementalStatusBackLoop",
		--StopVfxes = {"PoseidonElementalStatusFront", "PoseidonElementalStatusBack", "PoseidonElementalStatusBackLoop", "PoseidonElementalStatusFrontLoop"},
		CreateAnimationOnDamage = "HephaestusKnockupFx",
		ShowDuration = true,
		EffectData = {
			Type = "DELAYED_KNOCKBACK",
			Duration = 5,					-- Delay before knockback is applied
			Amount = 0,					-- Force of knockback
			TriggerDamage = 300,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit",
		}
	},
	WetEffect = 
	{
		DisplaySuffix = "Wet",
		EffectGroup = "PoseidonWet",
		Icon = "WaterSmall",
		Vfx = "OlympianStatusFxFront_Poseidon",
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Duration = 9,
			Modifier = 1.0,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		}
	},
	AmplifyKnockbackEffect = 
	{
		Vfx = "PoseidonSlipStatusFx",
		-- BackVfx = "PoseidonElementalStatusBack",
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Duration = 3,
			Modifier = 1.0,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
		
		OnApplyFunctionName = "AmplifyKnockbackApply",
		OnClearFunctionName = "AmplifyKnockbackClear",
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
			Duration = 2.0,
		},
		StunThroughHealthBuffer = true,
		OnApplyFunctionName = "OnHitStunApply",
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
	DamageOverDistance = 
	{
		Vfx = "PoseidonDebuffSurge",
		SilentImpact = true,
		DamageTextStartColor = Color.PoseidonDamageLight,
		DamageTextColor = Color.PoseidonDamage,
		EffectData = {
          IgnoreName = "_PlayerUnit",
          Type = "DAMAGE_OVER_DISTANCE",
          Cooldown = 0.2,
          Duration = 3,
		  Modifier = 1,
          TimeModifierFraction = 0,
          IsVulnerabilityEffect = true,
		}
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
	WetPrimary = 
	{
		InheritFrom = {"WetEffect"},	
	},
	WetSecondary = 
	{
		InheritFrom = {"WetEffect"},	
	},
	WetSprint = 
	{
		InheritFrom = {"WetEffect"},	
	},
	WetCast= 
	{
		InheritFrom = {"WetEffect"},	
	},
	WetElectricPuddle = 
	{
		InheritFrom = {"WetEffect"},	
	},
	WetRain = 
	{
		InheritFrom = {"WetEffect"},	
		EffectData = {
			Type = "DAMAGE_TAKEN",
			Duration = 1000,
			Modifier = 1.2,
			IsVulnerabilityEffect = true,
		}
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
	ElectrifiedEffect = 
	{
		InheritFrom = { "ZeusColorProjectile" },
		DisplaySuffix = "Electrify",
		EffectGroup = "Electrify",
		Icon = "ShockSmall",
		Vfx = "ZeusStaticArcEmitter",
		EffectData = {
          IgnoreName = "_PlayerUnit",
          Duration = 10,
          IsVulnerabilityEffect = true,
		},
	},
	ElectrifiedSprint = 
	{
		InheritFrom = {"ElectrifiedEffect"},
	},
	ElectrifiedBoon = 
	{
		InheritFrom = {"ElectrifiedEffect"},
	},
	ElectrifiedPuddle = 
	{
		InheritFrom = {"ElectrifiedEffect"},
	},
	
	NearbyVulnerabilityEffect =
	{
		DisplaySuffix = "NearbyVulnerability",
		EffectGroup = "NearbyVulnerability",
		Icon = "AphroditeSmall",
		ActiveAnimation = "AphroditeActive",
		InactiveAnimation = "AphroditeInactive",
		Vfx = "OlympianStatusFx_Aphrodite",
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
		
		OnApplyFunctionName = "NearbyVulnerabilityApply",
		OnClearFunctionName = "NearbyVulnerabilityClear",
		DistanceThreshold = 350,
		EffectData = {
			Type = "DAMAGE_OUTPUT",
			Modifier = 0.9,
            Duration = 3,
            Amount = 1.3,
            IsVulnerabilityEffect = true,
            IgnoreName = "_PlayerUnit"
		},

	},
	WeakEffect = 
	{
		DisplaySuffix = "Weak",
		EffectGroup = "Weak",
		Vfx = "AphroditeWeakFxFront",
		BackVfx = "AphroditeWeakFxBack",
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
		EffectData = {
            Type = "DAMAGE_OUTPUT",
            Duration = 3,
            Modifier = 0.9,
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
		DamageTextStartColor = Color.LightPurple,
		DamageTextColor = Color.Purple,
		DamageTextSize = 25,
		OnApplyFunctionName = "DamageOverTimeApply",
		OnClearFunctionName = "DamageOverTimeClear",
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
	LavaSlow =
	{
		OnApplyFunctionName = "LavaSlowApply",
		OnClearFunctionName = "LavaSlowClear",
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
	OnHitStunAxeBlock =
	{
		InheritFrom = {"OnHitStun"},
		OnApplyFunctionName = "OnHitStunApply",
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
	HecatePolymorphStun = 
	{
		OnApplyFunctionName = "HecatePolymorphApply",
		OnClearFunctionName = "HecatePolymorphClear",
	},
	PolymorphTag = 
	{
		OnApplyFunctionName = "CheckPolymorphApply"
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
		--Vfx = "SpeedFront",
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
	ErisSelfBuff = 
	{
		Name = "ErisSelfBuff",
		Vfx = "ErisPowerUpFx",
		OnApplyFunctionName = "ErisSelfBuffApply",
		--OnClearFunctionName = "ErisSelfBuffClear",
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
	FastClearBuff = 
	{
		Name = "FastClearBuff",
		Vfx = "ErisPowerUpFx",	
		DataProperties = 
		{
			CanAffectInvulnerable = true,
			TimeModifierFraction = 0,
			OnlyAffectName = "_PlayerUnit",
	  		Type = "SPEED",
	  		Duration = 3600,
	  		Modifier = 1.2,
			DodgeChance = 0.2,
		},
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
	DaggerBlockInvincibubble = 
	{
		InheritFrom = {"InvulnerableEffect"},
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
		}
	},
	MiasmaSlow = 
	{
		AttackSpeedMultiplier = 1.5,
		SprintSpeedMultiplier = 0.5,
		OnApplyFunctionName = "MiasmaSlowApply",
		OnClearFunctionName = "MiasmaSlowClear"

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
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
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
			Duration = 26/60,
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
			Duration = 33/60,
			DisableRotate = true,
			DisableMove = true,
			Cancelable = true,
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
		OnApplyFunctionName = "BlinkTriggerLockApply",
		OnClearFunctionName = "BlinkTriggerLockClear",
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
		MaxDuration = 0.2,
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


  RamBerserk =
  {
    EffectName = "RamBerserk",
		DataProperties = 
		{
			Type = "SPEED",
			ChangeType = "ADD",
			Duration = 2.5,
			Modifier = 1.4,
			ClearOnCollision = false,
		}
  }
}

OverwriteTableKeys( EffectData, WeaponEffectData )