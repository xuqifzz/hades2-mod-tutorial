HeroData =
{
	Name = "Default",
	DefaultWeapon = "WeaponStaffSwing",
	TempArmorVfx = "HephaestusLaurels",
	MaxHealth = 30,
	MaxHealthMultiplier = 1,
	MaxMana = 50,
	ReserveManaSources = {},
	LastStands = {},
	Traits = {},
	TraitDictionary = {},
	UniqueGodCount = 0,
	UnusedWeaponThreshold = 3,
	DashManeuverTimeThreshold = 0.22,
	SpeedMultiplierCap = 2,	-- Applies to sprint speed and move speed
	AutoSprintBuffer = 0.42,	-- How long after the sprint ends to continue holding for it to cancel auto-sprint behavior
	LastStandData = 
	{
		Heal = 0.4,
		Duration = 5.0,
		Modifier = 0.3,
	},

	ManaData = 
	{
		MinManaTickRate = 0.05,
		ManaRegenCooldown = 1.0,
		--BaseManaRegen = 1,
	},
	
	Outline =
	{
		R = Color.Turquoise[1],
		G = Color.Turquoise[2],
		B = Color.Turquoise[3],
		Opacity = 0.7,
		Thickness = 3,
		Threshold = 0.6,
		FadeInDuration = 0.6,
	},
	InvulnerableFrameThreshold = 0.25,
	InvulnerableFrameMinDamage = 15, -- this was 10 on Minos
	InvulnerableFrameCumulativeDamageDuration = 0.6,
	InvulnerableFrameDuration = 1.3,
	PerfectDashHitDisableDuration = 0.3,

	TriggersOnDamageEffects = true,
	TriggersOnHitEffects = true,

	ComboThreshold = 12,

	CanBeFrozen = true,
	FreezeTimeReductionPerInput = 1.3,
	UnfreezeAnimation = "MelinoeIdle",

	LineHistoryName = "PlayerUnit",
	SubtitleColor = Color.White,
	NarrativeFadeInColor = Color.Teal,
	EmoteOffsetY = -220,
	EmoteOffsetX = 60,
	AnimOffsetZ = 0,

	SpeechCooldownTime = 15,
	SpeakingStatusAnimation = "StatusIconSpeaking_Hero",

	EasyModeDamageMultiplierBase = 0.8,
	EasyModeDamageMultiplierPerDeath = -0.02,
	EasyModeDamageMultiplierDeathCap = 30,

	TargetMetaRewardsRatio = 0.45,
	TargetMetaRewardsAdjustSpeed = 10.0,

	SecretDoorCostBase = 10,
	SecretDoorCostDepthScalar = 0.4,

	DamagedSound = "/VO/MelinoeEmotes/EmoteHurt",
	ChokingSound = "/VO/MelinoeEmotes/EmoteStunned",
	FrozenSound = "/VO/MelinoeEmotes/EmoteHurt",
	UnFrozenSound = "/VO/MelinoeEmotes/EmoteGasping",

	PlayerInjuredVoiceLineThreshold = 0.65,

	OnDeathShakeScreenSpeed = 250,
	OnDeathShakeScreenDistance = 5,
	OnDeathShakeScreenDuration = 0.25,
	OnDeathShakeScreenAngle = 90,

	InteractAnimation = "MelinoeInteract",
	BoonInteractAnimation = "MelinoeBoonInteract",
	TurnInPlaceAngleMin = 30,
	DamagedAnimation = "MelinoeGetHit",
	DamagedFxStyles =
	{
		Default = "PlayerHitSpark",
	},
	InvulnerableHitFx = "PlayerArmorHitSpark",

	SetupEvents =
	{
		{
			FunctionName = "OverwriteSelf",
			Args =
			{
				Speaker = "PlayerUnit_Intro",
				SpeakerLabelOffsetY = 18,
			},
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = "<=",
					Value = 0,
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead", },
				},
			},
		},
		{
			FunctionName = "OverwriteSelf",
			Args =
			{
				Speaker = "PlayerUnit",
				SpeakerLabelOffsetY = "nil",
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead", },
				},
			},
		},
	},

	HeroHitRumbleParameters =
	{
		{ ScreenPreWait = 0.0, LeftFraction = 0.2, Duration = 0.2 },
	},

	HeroMajorHitRumbleParameters =
	{
		{ ScreenPreWait = 0.0, RightFraction = 0.4, Duration = 0.35 },
	},

	HeroFinalHitRumbleParameters =
	{
		{ ScreenPreWait = 0.02, RightFraction = 0.4, Duration = 0.6 },
		--{ ScreenPreWait = 0.85, RightFraction = 0.4, Duration = 0.5 },
		--{ ScreenPreWait = 2.45, LeftFraction = 0.4, Duration = 0.5 },
	},
	
	ShoutSlowParameters =
	{
		{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
		{ ScreenPreWait = 1.20, Fraction = 1.0, LerpTime = 0.1 },
	},

	EnemyMoneyDropBaseValue = 1.0,

	Weapons =
	{
		WeaponBlink = true,
		WeaponSprint = true,
		WeaponCast = true,
	},

	MaxGodsPerRun = 4,

	BoonData =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
		ForceCommon = false,
		RarityChances = 
		{
			Rare = 0.10,
			Epic = 0.05,
			Duo = 0.12,
			Legendary = 0.10,
		},
		ReplaceChance = 0.1,
	},
	HermesData =
	{
		ForceCommon = false,
		RarityChances = 
		{
			Rare = 0.06,
			Epic = 0.03,
			Legendary = 0.01,
		},
	},
	StackData =
	{
		ForceCommon = true,
		AllowRarityOverride = false,
	},
	WeaponData =
	{
		ForceCommon = true,
	},
	RushWeaponMaxRange = 400,
	AttachedAnimationName = "LaurelCindersSpawner",
	AttachedLightName = "LightCharacterEllipse01",
	AttachedLightScale = 1.2,
	AttachedLightColor = { 232, 131, 0, 255 },
	AttachedLightCount = 1,
	
	Speaker = "PlayerUnit",
	Portrait = "Portrait_Mel_Default_01",

	VoiceLineBufferTime = 9,
	LowHealthVoiceLineThreshold = 0.35,
	LowHealthVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.25,
		CooldownTime = 100,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead", },
			},
		},
		TriggerCooldowns = { "MedeaSpokeRecently" },

		{ Cue = "/VO/Melinoe_0319", Text = "You..." },
		{ Cue = "/VO/Melinoe_0320", Text = "{#Emph}Rngh." },
		{ Cue = "/VO/Melinoe_0321", Text = "{#Emph}Tsch." },
		{ Cue = "/VO/Melinoe_0322", Text = "{#Emph}Grr!" },
		{ Cue = "/VO/Melinoe_0323", Text = "{#Emph}Pah." },
		{ Cue = "/VO/Melinoe_0324", Text = "Really." },
		{ Cue = "/VO/Melinoe_0325", Text = "{#Emph}Nrgh." },
		{ Cue = "/VO/Melinoe_0326", Text = "Truly." },
		{ Cue = "/VO/Melinoe_0327", Text = "No...!" },
		{ Cue = "/VO/Melinoe_1956", Text = "Damn it!" },
		{ Cue = "/VO/Melinoe_0328", Text = "Damn you...!" ,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", "F_Boss02" },
				},
			},
		},

	},
	LightBarColor = { 0, 0, 255, 255 }
}

PreCacheTraitValues = ToLookup(
{
	"OnSprintAction",
	"SetupFunction",
	"OverrideWeaponFireNames",
	"DamageOnFireWeapons",
	"ManaCostModifiers",
	"OnWeaponFiredFunctions",
	"OnWeaponChargeCanceledFunctions",
	"EnemySetupFunctionName",
	"OnEffectApplyFunction",
	"OnCastEffectApplyFunction",
	"OnEffectClearFunction",
	"OnDamageEnemyFunction",
	"OnPlayerHealthChangedFunctionName",
	"DropOnKill",
	"AddEnemyOnDeathProjectile",
	"OnEnemyDeathFunction",
	"CustomExDefinitions",
	"OnProjectileCreationFunction",
	"OnEnemyCrittedFunction",
	"AddSummonWeaponsToTraits",
	"AddWeaponsToTraits",
	"ActivatedDamageFloor",
	"BlockMoney",
	"BlockDeathTimer",
	"MagnetizeBloodDrops",
})

HeroVoiceLines =
{
	HitInvulnerableVoiceLines =
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.85,
		CooldownTime = 40,
		SuccessiveChanceToPlayAll = 0.33,

		GameStateRequirements =
		{
			-- None
		},

		-- 
	},

	NotReadyVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.15,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},

			{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
			{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
			{ Cue = "/VO/Melinoe_0388", Text = "I'm spent." },
			{ Cue = "/VO/Melinoe_0389", Text = "I'm out." },
			{ Cue = "/VO/Melinoe_0390", Text = "No use." },
			{ Cue = "/VO/Melinoe_2385", Text = "Can't right now." },
			{ Cue = "/VO/Melinoe_2386", Text = "Can't do it." },
			{ Cue = "/VO/Melinoe_2387", Text = "Out of magick." },
			{ Cue = "/VO/Melinoe_2388", Text = "Need magick." },
			{ Cue = "/VO/Melinoe_2389", Text = "Need to recharge." },
			{ Cue = "/VO/Melinoe_2390", Text = "Spent..." },
			{ Cue = "/VO/Melinoe_3082", Text = "Low on magick." },
			{ Cue = "/VO/Melinoe_3083", Text = "No magick." },
			{ Cue = "/VO/Melinoe_3084", Text = "No use." },
			{ Cue = "/VO/Melinoe_3085", Text = "{#Emph}Ngh." },
			{ Cue = "/VO/Melinoe_3086", Text = "I wish." },
			{ Cue = "/VO/Melinoe_3087", Text = "Can't do it." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.15,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},

			{ Cue = "/VO/Melinoe_0127", Text = "I can't!" },
			{ Cue = "/VO/Melinoe_0128", Text = "Not now!" },
			{ Cue = "/VO/Melinoe_0129", Text = "I'm spent!" },
			{ Cue = "/VO/Melinoe_0130", Text = "I'm out!" },
			{ Cue = "/VO/Melinoe_0131", Text = "It's no use!" },
			{ Cue = "/VO/Melinoe_2391", Text = "Can't right now!" },
			{ Cue = "/VO/Melinoe_2392", Text = "Can't do it!" },
			{ Cue = "/VO/Melinoe_2393", Text = "Out of magick!" },
			{ Cue = "/VO/Melinoe_2394", Text = "Need magick!" },
			{ Cue = "/VO/Melinoe_2395", Text = "Need to recharge!" },
			{ Cue = "/VO/Melinoe_2396", Text = "Damn it...!" },
			{ Cue = "/VO/Melinoe_3088", Text = "No magick!" },
			{ Cue = "/VO/Melinoe_3089", Text = "No good...!" },
			{ Cue = "/VO/Melinoe_3090", Text = "Can't go full blast..." },
			{ Cue = "/VO/Melinoe_3091", Text = "Couldn't do it..." },
			{ Cue = "/VO/Melinoe_3092", Text = "{#Emph}Argh..." },
			{ Cue = "/VO/Melinoe_3093", Text = "My magick..." },
		},
	},

	SpellNotReadyVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
				{
					PathFalse = { "MapState", "BabyPolymorph" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelSpellNotReadySpeech", Time = 120 },
			},

			{ Cue = "/VO/MelinoeField_2203", Text = "Can't use my Hex just yet...!" },
			{ Cue = "/VO/MelinoeField_2204", Text = "My Hex is spent for now!" },
			{ Cue = "/VO/MelinoeField_2205", Text = "My Hex isn't prepared...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2206", Text = "Just a bit longer...!" },
			{ Cue = "/VO/MelinoeField_4808", Text = "Not yet...!" },
			{ Cue = "/VO/MelinoeField_4809", Text = "It's not ready...!" },
			{ Cue = "/VO/MelinoeField_4810", Text = "Come on...!" },
			{ Cue = "/VO/MelinoeField_4811", Text = "Where's my Hex...?" },
		},
		{ GlobalVoiceLines = "OutOfManaVoiceLines" },
	},

	TremorReactionVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTremorSpeech", Time = 420 },
			},

			{ Cue = "/VO/MelinoeField_2506", Text = "Rumbling..." },
			{ Cue = "/VO/MelinoeField_2507", Text = "What was that...?", PlayFirst = true, },
			{ Cue = "/VO/MelinoeField_2508", Text = "Another tremor..." },
			{ Cue = "/VO/MelinoeField_2509", Text = "More shaking..." },
		},
	},
	PoisonAppliedVoiceLines =
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = { PreWait = 0.35 },
		{
			RandomRemaining = true,
			-- PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.75,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelPoisonSpeechPlayedRecently", Time = 20 },
			},

			{ Cue = "/VO/MelinoeField_3559", Text = "Poison...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3560", Text = "Poisoned...!" },
			{ Cue = "/VO/MelinoeField_3561", Text = "Poisoned..." },
			{ Cue = "/VO/MelinoeField_3562", Text = "Not again..." },
			{ Cue = "/VO/MelinoeField_3563", Text = "{#Emph}Ungh..." },
			{ Cue = "/VO/MelinoeField_3564", Text = "Got me..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			-- PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			ObjectType = "Medea",
			-- SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				--
			},
			Cooldowns =
			{
				{ Name = "MedeaSpokeRecently", Time = 16 },
				{ Name = "MedeaPoisonedRecently", Time = 40 },
			},

			{ Cue = "/VO/Medea_0383", Text = "You look unwell...!" },
			{ Cue = "/VO/Medea_0384", Text = "You look pale...!" },
			{ Cue = "/VO/Medea_0385", Text = "You look ill...!" },
			{ Cue = "/VO/Medea_0386", Text = "You're sick...!" },
			{ Cue = "/VO/Medea_0387", Text = "Intoxicated..." },
			{ Cue = "/VO/Medea_0388", Text = "Feel {#Emph}that...?" },
			{ Cue = "/VO/Medea_0389", Text = "Oh what {#Emph}happened?" },
			{ Cue = "/VO/Medea_0390", Text = "Apologies!" },
			{ Cue = "/VO/Medea_0391", Text = "Works every time." },
			{ Cue = "/VO/Medea_0392", Text = "Got you!" },
			{ Cue = "/VO/Medea_0393", Text = "Got you again." },
			{ Cue = "/VO/Medea_0394", Text = "Noxious, right?" },
			{ Cue = "/VO/Medea_0395", Text = "Toxicity..." },
			{ Cue = "/VO/Medea_0396", Text = "Poisonous..." },
			{ Cue = "/VO/Medea_0397", Text = "{#Emph}Curse you!" },
			{ Cue = "/VO/Medea_0398", Text = "Suffer my curse!", PlayFirst = true },
		},
	},
	PoisonCuredVoiceLines =
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = { PreWait = 0.45 },
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			-- PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.1,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "CurrentlyPoisoned" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelPoisonCureSpeechPlayedRecently", Time = 20 },
			},

			{ Cue = "/VO/MelinoeField_3565", Text = "Cured...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3566", Text = "{#Emph}Whew..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			-- PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.66,
			SuccessiveChanceToPlayAll = 0.33,
			ObjectType = "Medea",
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				--
			},
			Cooldowns =
			{
				{ Name = "MedeaSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Medea_0399", Text = "You could have let it run its course..." },
			{ Cue = "/VO/Medea_0400", Text = "Was that so bad?" },
			{ Cue = "/VO/Medea_0401", Text = "...I hate those." },
			{ Cue = "/VO/Medea_0402", Text = "Already...?" },
			{ Cue = "/VO/Medea_0403", Text = "Cured..." },
			{ Cue = "/VO/Medea_0404", Text = "Cleansed..." },
			{ Cue = "/VO/Medea_0405", Text = "All better?", PlayFirst = true },
			{ Cue = "/VO/Medea_0406", Text = "Got you, though!" },
			{ Cue = "/VO/Medea_0407", Text = "Oh, {#Emph}foo." },
			{ Cue = "/VO/Medea_0408", Text = "But I just cursed you..." },
		},
	},
	EagleIncomingVoiceLines =
	{
		{
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					-- PathEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				-- { Name = "MelinoeEagleSpeech", Time = 360 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },


			{ Cue = "/VO/MelinoeField_2486", Text = "An Eagle!", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Boss01" }
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2487", Text = "Eagle...!" },
			{ Cue = "/VO/MelinoeField_2800", Text = "That Eagle..." },
			{ Cue = "/VO/MelinoeField_2801", Text = "Eagle spotted me..." },
			{ Cue = "/VO/MelinoeField_2802", Text = "Eagle..." },
			{ Cue = "/VO/MelinoeField_2803", Text = "It's that bird..." },
			{ Cue = "/VO/MelinoeField_2798", Text = "Aetos...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusLowHealth01", "PrometheusAboutMortals01", "PrometheusLostAgainstHim02" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2799", Text = "Hi, Aetos!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusLowHealth01", "PrometheusAboutMortals01", "PrometheusLostAgainstHim02" },
					},
				},
			},

		},
	},

	-- Resource Gathering
	PlantingVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.15,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_2359", Text = "Grow strong." },
			{ Cue = "/VO/Melinoe_2360", Text = "Grow and flourish." },
			{ Cue = "/VO/Melinoe_2361", Text = "Take all the time you need." },
			{ Cue = "/VO/Melinoe_2362", Text = "Into the earth you go." },
			{ Cue = "/VO/Melinoe_2363", Text = "You'll flourish here.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2364", Text = "Here you'll grow strong." },
			{ Cue = "/VO/Melinoe_2365", Text = "Drink of the Earth." },
			{ Cue = "/VO/Melinoe_2366", Text = "Live and thrive." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.39,
			SuccessiveChanceToPlay = 0.15,
			SuccessiveChanceToPlayAll = 0.5,
			ObjectType = "NPC_Odysseus_01",
			RequiredSourceValueFalse = "InPartnerConversation",
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
				},
				-- not interested in garden straightaway...
				{
					SumPrevRuns = 4,
					Path = { "WorldUpgradesAdded", "WorldUpgradeGarden" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusAnyQuipSpeech", Time = 12 },
			},

			{ Cue = "/VO/Odysseus_0328", Text = "{#Emph}Ah{#Prev}, that's a nice touch." },
			{ Cue = "/VO/Odysseus_0331", Text = "{#Emph}Oh{#Prev}, what have we there." },
			{ Cue = "/VO/Odysseus_0501", Text = "I'll keep an eye on it." },
			{ Cue = "/VO/Odysseus_0502", Text = "I'll watch that one." },
			{ Cue = "/VO/Odysseus_0503", Text = "A new crop." },
			{ Cue = "/VO/Odysseus_0504", Text = "{#Emph}Ooh {#Prev}good." },
			{ Cue = "/VO/Odysseus_0505", Text = "We'll keep it safe." },
			{ Cue = "/VO/Odysseus_0329", Text = "Plenty of room to grow.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/Melinoe_2359", "/VO/Melinoe_2360", "/VO/Melinoe_2362" },
					},
				},
			},
			{ Cue = "/VO/Odysseus_0330", Text = "Our garden flourishes.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/Melinoe_2360", "/VO/Melinoe_2363" },
					},
				},
			},
			{ Cue = "/VO/Odysseus_0506", Text = "And soon.",
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/Melinoe_2363", "/VO/Melinoe_2364" },
					},
				},
			},
			{ Cue = "/VO/Odysseus_0495", Text = "Odd one there...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GardenLastSeedPlanted" },
						IsAny = GameData.StrangeSeeds
					}
				}
			},
			-- { Cue = "/VO/Odysseus_0332", Text = "How unexpected, that." },
			-- { Cue = "/VO/Odysseus_0333", Text = "Such sorcery." },
		},
	},
	HarvestVoiceLines =
	{
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "HarvestPoint", "Name" },
				IsNone =
				{
					"TrashPointsDrop",
				},
			},
		},
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = { PreWait = 0.27 },
		{
			RandomRemaining = true,
			PreLineWait = 0.38,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/Melinoe_2367", Text = "You're ready." },
			{ Cue = "/VO/Melinoe_2368", Text = "May I...?" },
			{ Cue = "/VO/Melinoe_2369", Text = "Come along." },
			{ Cue = "/VO/Melinoe_2370", Text = "Full bloom.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2371", Text = "Full grown." },
			{ Cue = "/VO/Melinoe_2372", Text = "All grown up." },
			{ Cue = "/VO/Melinoe_2373", Text = "Ready to come out?" },
			{ Cue = "/VO/Melinoe_2374", Text = "Up you go." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.38,
			SuccessiveChanceToPlay = 0.15,
			SuccessiveChanceToPlayAll = 0.5,
			ObjectType = "NPC_Odysseus_01",
			RequiredSourceValueFalse = "InPartnerConversation",
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
				},
				-- not interested in garden straightaway...
				{
					SumPrevRuns = 4,
					Path = { "WorldUpgradesAdded", "WorldUpgradeGarden" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusAnyQuipSpeech", Time = 12 },
			},
			TriggerCooldownsImmediately = true,
			TriggerCooldowns = { "OdysseusHarvestVO" },

			{ Cue = "/VO/Odysseus_0507", Text = "Some Nightshade?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantFNightshade" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0508", Text = "Nightshade...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantFNightshade" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0509", Text = "Some Cattails...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantGCattail" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0510", Text = "Cattails then.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantGCattail" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0511", Text = "Wheat, is it?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantHWheat" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0512", Text = "Some Wheat...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantHWheat" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0513", Text = "Poppies, is it?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantIPoppy" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0514", Text = "More Poppies.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantIPoppy" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0517", Text = "Garlic there?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantNGarlic" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0518", Text = "Garlic again.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantNGarlic" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0519", Text = "Mandrake...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantOMandrake" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0520", Text = "More Mandrake.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantOMandrake" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0521", Text = "Oh, Olives.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantPOlive" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0522", Text = "More Olives.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantPOlive" },
					}
				}
			},
			{ Cue = "/VO/Odysseus_0500", Text = "That's quite a plant you got...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = { "PlantPOlive", "PlantHWheat", "PlantIPoppy" }
					}
				}
			},
			{ Cue = "/VO/Odysseus_0515", Text = "What is that?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0516", Text = "That stuff again.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0523", Text = "Whatever {#Emph}that {#Prev}is.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0524", Text = "Strange stuff.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0496", Text = "Won't have to look at that again...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0497", Text = "What even was that...",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0498", Text = "Not seen too many of that sort.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangePlants
					}
				}
			},
			{ Cue = "/VO/Odysseus_0499", Text = "Disturbing isn't it?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "PlantName" },
						IsAny = GameData.StrangeSeeds
					}
				}
			},
		},
		{ GlobalVoiceLines = "ResourceFoundVoiceLines" },
	},
	PickaxeUseInProgressVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_Boss01", "Q_Boss02" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.25, },
			},
		},
		{
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				},
				{
					Path = { "GameState", "PickaxeSuccessesFamiliar" },
					Comparison = ">=",
					Value = 1,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			TriggerCooldowns = { "MelinoeCombatResourceVoiceLines" },

			{ Cue = "/VO/MelinoeField_3302", Text = "I'll take this one, Raki...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3303", Text = "Raki, hold them off!" },
			{ Cue = "/VO/MelinoeField_3304", Text = "I have this, Raki!" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.15,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeCombatResourceVoiceLines", Time = 300 },
			},

			{ Cue = "/VO/MelinoeField_0584", Text = "Oh why not..." },
			{ Cue = "/VO/MelinoeField_0585", Text = "One moment...!" },
			{ Cue = "/VO/MelinoeField_0586", Text = "Before I forget..." },
			{ Cue = "/VO/MelinoeField_0587", Text = "Quickly..." },
			{ Cue = "/VO/MelinoeField_0588", Text = "Quickly now..." },
			{ Cue = "/VO/MelinoeField_0589", Text = "Excuse me...!" },
			{ Cue = "/VO/MelinoeField_0590", Text = "Beg pardon...!" },
			{ Cue = "/VO/MelinoeField_0591", Text = "Now or never!" },
			{ Cue = "/VO/MelinoeField_0592", Text = "This can't wait..." },
			{ Cue = "/VO/MelinoeField_0593", Text = "Come on..." },
		},
	},
	PickaxeDepositDestroyedVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" } 
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_Bridge01" }
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_1617", Text = "I'll use this well." },
			{ Cue = "/VO/Melinoe_1618", Text = "A gift from the Earth." },
			{ Cue = "/VO/Melinoe_1619", Text = "The Earth's bounty." },
			{ Cue = "/VO/Melinoe_1620", Text = "I merely borrow this.", PlayFirst = true },
		},
		{ GlobalVoiceLines = "HecateGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ArachnePickaxeReactionVoiceLines" },
		{ GlobalVoiceLines = "NemesisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ArtemisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "IcarusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "CharonGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "PolyphemusPickaxeReactionVoiceLines" },
		{ GlobalVoiceLines = "ErisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "PrometheusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "HadesPickaxeReactionVoiceLines" },
		{ GlobalVoiceLines = "DionysusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "AthenaGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ChronosGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ChaosHarvestReactionVoiceLines" },
	},
	ShovelVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.25,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_Bridge01" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0286", Text = "Carefully...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0287", Text = "And, scoop..." },
			{ Cue = "/VO/MelinoeField_0288", Text = "Carefully now..." },
			{ Cue = "/VO/MelinoeField_0289", Text = "Come on up..." },
			{ Cue = "/VO/MelinoeField_0290", Text = "I see you..." },
			{ Cue = "/VO/MelinoeField_0291", Text = "Gently now..." },
		},
		{ GlobalVoiceLines = "HecateGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ArachneGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "NemesisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ArtemisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "IcarusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "CharonGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "PolyphemusShovelReactionVoiceLines" },
		{ GlobalVoiceLines = "ErisGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "PrometheusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "HadesHarvestReactionVoiceLines" },
		{ GlobalVoiceLines = "DionysusGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "AthenaGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ChronosGatherReactionVoiceLines" },
		{ GlobalVoiceLines = "ChaosHarvestReactionVoiceLines" },
	},
	ShovelFoundBombVoiceLines =
	{
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.75,
			PreLineWait = 0.15,
			Cooldowns =
			{
				{ Name = "MelFoundBombSpeech", Time = 30 },
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0714", Text = "What the?" },
			{ Cue = "/VO/Melinoe_0715", Text = "Wha—?", PlayFirst = true, },
		},
		{ GlobalVoiceLines = "ArachneMineReactionVoiceLines" },
	},
	ExorcismStartVoiceLines =
	{
		UsePlayerSource = true,
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "DieHardFanShade" },
				},
			},

			{ Cue = "/VO/MelinoeField_3046", Text = "You don't belong here... I can show you to a better place." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
			Cooldowns =
			{
				{ Name = "MelinoeExorcismSpeech", Time = 10 },
			},

			{ Cue = "/VO/Melinoe_1621", Text = "Be not afraid..." },
			{ Cue = "/VO/Melinoe_1622", Text = "Let me show you the way..." },
			{ Cue = "/VO/Melinoe_1623", Text = "Let me help you...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1624", Text = "Look upon me..." },
			{ Cue = "/VO/Melinoe_0333", Text = "Join me!" },
			{ Cue = "/VO/MelinoeField_4878", Text = "It'll be all right..." },
			{ Cue = "/VO/MelinoeField_4879", Text = "Let's get you someplace safe..." },
			{ Cue = "/VO/MelinoeField_4880", Text = "Don't be frightened..." },
		},
	},
	ExorcismResistedVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 1.0,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "MelinoeExorcismSpeech" },

			{ Cue = "/VO/Melinoe_1631", Text = "Why don't we try again.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1632", Text = "Resisted me..." },
			{ Cue = "/VO/Melinoe_1633", Text = "Didn't work..." },
			{ Cue = "/VO/Melinoe_1634", Text = "Stubborn, aren't you..." },
			{ Cue = "/VO/Melinoe_0321", Text = "{#Emph}Tsch." },
			{ Cue = "/VO/Melinoe_0325", Text = "{#Emph}Nrgh..." },
		},
		{ GlobalVoiceLines = "NemesisScoffingVoiceLines" },
	},
	ExorcismFailedVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0761", Text = "{#Emph}Ungh..." },
			{ Cue = "/VO/Melinoe_0762", Text = "Blast...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0763", Text = "Got away..." },
			{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
			{ Cue = "/VO/Melinoe_0578", Text = "Hrm." },
		},
		{ GlobalVoiceLines = "NemesisScoffingVoiceLines" },
	},
	ExorcismSucceededVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_1625", Text = "Be free..." },
			{ Cue = "/VO/Melinoe_1626", Text = "Be at peace." },
			{ Cue = "/VO/Melinoe_1627", Text = "Rest easy now..." },
			{ Cue = "/VO/Melinoe_1628", Text = "See you in the Crossroads...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1629", Text = "See you in the Crossroads." },
			{ Cue = "/VO/Melinoe_1630", Text = "See you in the Crossroads...?" },
			{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
			{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh." },
			{ Cue = "/VO/Melinoe_0206", Text = "Good." },
			{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
			{ Cue = "/VO/Melinoe_0209", Text = "There." },
			{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
		},
		{ GlobalVoiceLines = "ArachneExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "NarcissusExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "NemesisExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "HadesExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "HeraclesExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "MedeaExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "IcarusExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "DionysusExorcismReactionVoiceLines" },
		{ GlobalVoiceLines = "SeleneExorcismReactionVoiceLines" },
	},

	PlantInteractVoiceLines =
	{
		UsePlayerSource = true,
		-- check GameState.GardenPlots
		-- just planted
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "GrowTimeRemaining" },
					Comparison = ">=",
					Value = 6,
				},
			},
			{ Cue = "/VO/Melinoe_2589", Text = "Grow strong, all right?" },
			{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
			{ Cue = "/VO/Melinoe_2592", Text = "Take all the time you require." },
			{ Cue = "/VO/Melinoe_2593", Text = "You'll grow up in no time.", PlayFirst = true },
		},
		-- growing in progress
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "GrowTimeRemaining" },
					Comparison = "<=",
					Value = 5,
				},
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "GrowTimeRemaining" },
					Comparison = ">=",
					Value = 1,
				}
			},

			{ Cue = "/VO/Melinoe_2304", Text = "Grow and thrive.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2306", Text = "Drink deep and grow tall.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2307", Text = "Thank you for growing here.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2303", Text = "You're growing strong.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2591", Text = "You getting enough light?" },
			{ Cue = "/VO/Melinoe_2594", Text = "How fare you, little seedling?" },
			{ Cue = "/VO/Melinoe_2590", Text = "You've all the nourishment you need." },
		},
		-- finished growing
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			-- SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "GrowTimeRemaining" },
					Comparison = "<=",
					Value = 0,
				}
			},
			Cooldowns =
			{
				-- { Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0569", Text = "{#Emph}<Inhale>",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "Name" },
						IsNone =
						{
							"PlantGCattail",
						},
					}
				},
			},
			{ Cue = "/VO/Melinoe_1515", Text = "Beautiful." },
			{ Cue = "/VO/Melinoe_2298", Text = "{#Emph}<Sniff>", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2299", Text = "{#Emph}<Sniff>" },
			{ Cue = "/VO/Melinoe_2300", Text = "{#Emph}<Sniff> <Sigh>" },
			{ Cue = "/VO/Melinoe_2301", Text = "{#Emph}<Sniff> Ah." },
			{ Cue = "/VO/Melinoe_2302", Text = "{#Emph}<Sniff> Mm..." },
			{ Cue = "/VO/Melinoe_2305", Text = "You're welcome here and safe.",
				Cooldowns =
				{
					{ Name = "SaidWelcomeHereRecently", Time = 180 },
				},
			},
			{ Cue = "/VO/Melinoe_2595", Text = "You're all grown up." },
			{ Cue = "/VO/Melinoe_2596", Text = "Sprang up so fast." },
			{ Cue = "/VO/Melinoe_2597", Text = "How tall you've grown..." },
			{ Cue = "/VO/Melinoe_2598", Text = "You're a sight to behold." },
			{ Cue = "/VO/Melinoe_2599", Text = "How's the soil, good?" },
		},
		-- { GlobalVoiceLines = "HecateGatherReactionVoiceLines" },
		-- { GlobalVoiceLines = "ArachneGatherReactionVoiceLines" },
	},

	-- Familiars
	FamiliarUnequipVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2775", Text = "Stay here.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2776", Text = "Rest up, OK?" },
		{ Cue = "/VO/Melinoe_2777", Text = "Stay." },
		{ Cue = "/VO/Melinoe_2778", Text = "Wait for me here." },
		{ Cue = "/VO/Melinoe_1253", Text = "Farewell." },
		{ Cue = "/VO/Melinoe_1256", Text = "See you." },
		{ Cue = "/VO/Melinoe_1258", Text = "Let's do this again sometime." },
	},

	FamiliarHarvestVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" }
			},
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HecateBossKidnapped01" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
			},

			{ Cue = "/VO/MelinoeField_2067", Text = "The honors please, Frinos." },
			{ Cue = "/VO/MelinoeField_2068", Text = "Frinos, hypnotize." },
			{ Cue = "/VO/MelinoeField_2069", Text = "Frinos, do your thing." },
			{ Cue = "/VO/MelinoeField_2070", Text = "That Shade needs you, Frinos." },
			{ Cue = "/VO/MelinoeField_2071", Text = "Go show that Shade the way." },
			{ Cue = "/VO/MelinoeField_2072", Text = "Calm that Shade down, Frinos.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2073", Text = "Go, Frinos." },
			{ Cue = "/VO/MelinoeField_2074", Text = "Go, Frinos!" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2075", Text = "Toula, go for it!" },
			{ Cue = "/VO/MelinoeField_2076", Text = "Toula, catch!" },
			{ Cue = "/VO/MelinoeField_2077", Text = "Toula, fish!" },
			{ Cue = "/VO/MelinoeField_2078", Text = "See that one, Toula?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2079", Text = "Toula, be my guest." },
			{ Cue = "/VO/MelinoeField_2080", Text = "Go on, Toula." },
			{ Cue = "/VO/MelinoeField_2083", Text = "Go, Toula." },
			{ Cue = "/VO/MelinoeField_2084", Text = "Go, Toula!" },
			{ Cue = "/VO/MelinoeField_2081", Text = "Some assistance, please?" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "RavenFamiliar" },
				}
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2591", Text = "Raki, go.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2592", Text = "Go, Raki." },
			{ Cue = "/VO/MelinoeField_2593", Text = "Raki, fetch." },
			{ Cue = "/VO/MelinoeField_2594", Text = "Fetch, Raki." },
			{ Cue = "/VO/MelinoeField_2595", Text = "Fetch that please, Raki." },
			{ Cue = "/VO/MelinoeField_2596", Text = "Raki, use that beak." },
			{ Cue = "/VO/MelinoeField_2597", Text = "Chip away, Raki." },
			{ Cue = "/VO/MelinoeField_2598", Text = "Looks valuable, Raki." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "HoundFamiliar" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2599", Text = "Hecuba." },
			{ Cue = "/VO/MelinoeField_2600", Text = "Go, Hecuba.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2601", Text = "Hecuba, go fetch." },
			{ Cue = "/VO/MelinoeField_2602", Text = "Hecuba, go dig." },
			{ Cue = "/VO/MelinoeField_2603", Text = "Get it, Hecuba." },
			{ Cue = "/VO/MelinoeField_2604", Text = "Dig please, Hecuba." },
			{ Cue = "/VO/MelinoeField_2605", Text = "Digging spot there." },
			{ Cue = "/VO/MelinoeField_2606", Text = "Dig here, girl." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "PolecatFamiliar" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_3058", Text = "Gale, fetch!" },
			{ Cue = "/VO/MelinoeField_3059", Text = "Get that, Gale!" },
			{ Cue = "/VO/MelinoeField_3060", Text = "Go for it, Gale!" },
			{ Cue = "/VO/MelinoeField_3061", Text = "Gale, get it!" },
			{ Cue = "/VO/MelinoeField_3062", Text = "See that, Gale?" },
			{ Cue = "/VO/MelinoeField_3063", Text = "Reagent over there." },
			{ Cue = "/VO/MelinoeField_3064", Text = "Mind getting that for me?" },
			{ Cue = "/VO/MelinoeField_3065", Text = "All yours, Gale." },
		},

	},
	FamiliarThankingVoiceLines =
	{
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HecateBossKidnapped01" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_Bridge01" }
				},
			},
			--[[
			{ Cue = "/VO/Melinoe_0651", Text = "Thank you." },
			{ Cue = "/VO/Melinoe_0764", Text = "Thank you!" },
			{ Cue = "/VO/Melinoe_0765", Text = "Thank you." },
			{ Cue = "/VO/Melinoe_0766", Text = "For me?" },
			{ Cue = "/VO/Melinoe_0767", Text = "Thanks..." },
			]]--

			{ Cue = "/VO/MelinoeField_2087", Text = "Thanks, little one." },
			{ Cue = "/VO/MelinoeField_2088", Text = "Why thank you." },
			{ Cue = "/VO/MelinoeField_2089", Text = "Well done." },
			{ Cue = "/VO/MelinoeField_2090", Text = "Nicely done." },
			{ Cue = "/VO/MelinoeField_2091", Text = "Good job!" },
			{ Cue = "/VO/MelinoeField_2092", Text = "Appreciate the help." },
			{ Cue = "/VO/MelinoeField_2093", Text = "Cheers, Frinos.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/MelinoeField_2067", "MelinoeField_2068", "MelinoeField_2069", "MelinoeField_2070", "MelinoeField_2072", "MelinoeField_2073", "MelinoeField_2074" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2094", Text = "Well done, Frinos.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/MelinoeField_2067", "MelinoeField_2068", "MelinoeField_2069", "MelinoeField_2070", "MelinoeField_2072", "MelinoeField_2073", "MelinoeField_2074" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_Bridge01" }
				},
			},

			{ Cue = "/VO/MelinoeField_2087_B", Text = "Thanks, little one." },
			{ Cue = "/VO/MelinoeField_2088_B", Text = "Why thank you." },
			{ Cue = "/VO/MelinoeField_2089_B", Text = "Well done." },
			{ Cue = "/VO/MelinoeField_2090_B", Text = "Nicely done." },
			{ Cue = "/VO/MelinoeField_2091_B", Text = "Good job!" },
			{ Cue = "/VO/MelinoeField_2092_B", Text = "Appreciate the help." },
			{ Cue = "/VO/MelinoeField_2095", Text = "Good work, Toula.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/MelinoeField_2067", "MelinoeField_2075", "MelinoeField_2076", "MelinoeField_2077", "MelinoeField_2078", "MelinoeField_2079", "MelinoeField_2080", "MelinoeField_2083", "MelinoeField_2084" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2096", Text = "Cheers, Toula.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/MelinoeField_2067", "MelinoeField_2075", "MelinoeField_2076", "MelinoeField_2077", "MelinoeField_2078", "MelinoeField_2079", "MelinoeField_2080", "MelinoeField_2083", "MelinoeField_2084" },
					},
				},
			},
		},
	},

	-- Cauldron
	CauldronTyphonHintVoiceLines =
	{
		{
			SkipAnim = true,
			PlayOnce = true,
			PlayOnceContext = "PostTyphonFightCauldronSpeech",
			PreLineWait = 1.0,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
				},
				{
					Path = { "CurrentRun", "RoomsEntered" },
					HasAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", "MelCauldronOpenedSpeech", "MelCauldronSpellRevealedSpeech" },
			
			{ Cue = "/VO/Melinoe_4247", Text = "No way of knowing how much life-force Typhon has..." },
			{ Cue = "/VO/Melinoe_4248", Text = "...just have to slay him anyway.", PreLineWait = 0.8, BreakIfPlayed = true },
		},
		{
			SkipAnim = true,
			PlayOnce = true,
			PlayOnceContext = "CanCastStormStopVO",
			PreLineWait = 1.0,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
				},
				{
					Path = { "GameState", "Resources", "HadesSpearPoints" },
					Comparison = ">=",
					Value = 1,
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", "MelCauldronOpenedSpeech", "MelCauldronSpellRevealedSpeech" },
			
			{ Cue = "/VO/Melinoe_5709", Text = "At last..." },
		},
		{
			SkipAnim = true,
			PlayOnce = true,
			PlayOnceContext = "CanCastTimeStopVO",
			PreLineWait = 1.0,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "Resources", "MixerMythic" },
					Comparison = ">=",
					Value = 1,
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", "MelCauldronOpenedSpeech", "MelCauldronSpellRevealedSpeech" },
			
			{ Cue = "/VO/Melinoe_5710", Text = "Finally..." },
		},
	},
	CauldronSpellsRevealingVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		-- SuccessiveChanceToPlayAll = 0.33,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
			{ Name = "MelCauldronOpenedSpeech", Time = 30 },
			{ Name = "MelCauldronSpellRevealedSpeech", Time = 40 },
		},

		{ Cue = "/VO/Melinoe_3411", Text = "Last night I dreamt of this...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3412", Text = "I know what to do..." },
		{ Cue = "/VO/Melinoe_0512", Text = "I have an idea..." },
		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_3413", Text = "Been meaning to try this..." },
		{ Cue = "/VO/Melinoe_0513", Text = "I know...!" },
		{ Cue = "/VO/Melinoe_1349", Text = "This should be possible..." },
		{ Cue = "/VO/Melinoe_2970", Text = "As we improve ourselves, so does our craft..." },
		{ Cue = "/VO/Melinoe_2971", Text = "Each night, another possibility..." },
		{ Cue = "/VO/Melinoe_2972", Text = "May my intent be true..." },
		{ Cue = "/VO/Melinoe_2608", Text = "There's more I can do with this cauldron..." },
		{ Cue = "/VO/Melinoe_4335", Text = "Here's a thought..." },
		{ Cue = "/VO/Melinoe_4336", Text = "{#Emph}Ah-ha..." },
		{ Cue = "/VO/Melinoe_4337", Text = "I think that's it...!" },
		{ Cue = "/VO/Melinoe_4338", Text = "Yes, that's it..." },
		-- { Cue = "/VO/Melinoe_4339", Text = "Inspiration..." },
		{ Cue = "/VO/Melinoe_4340", Text = "What if...?" },
	},

	CauldronSpellDiscoveredVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.1,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			{ Name = "MelCauldronOpenedSpeech", Time = 30 },
			{ Name = "MelCauldronSpellRevealedSpeech", Time = 40 },
		},

		{ Cue = "/VO/Melinoe_0514", Text = "This should work...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = "<=",
					Value = 50,
				},
			},
		},
		{ Cue = "/VO/Melinoe_0515", Text = "What if I try {#Emph}this...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = "<=",
					Value = 50,
				},
			},
		},
		{ Cue = "/VO/Melinoe_3414", Text = "Epiphany...!" },
		{ Cue = "/VO/Melinoe_4341", Text = "New possibility..." },
		{ Cue = "/VO/Melinoe_4342", Text = "That's something..." },
		{ Cue = "/VO/Melinoe_4343", Text = "Yes, that ought to work..." },
		{ Cue = "/VO/Melinoe_4344", Text = "This has to be..." },
	},

	CauldronSpellLearnedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			}
		},
		Cooldowns =
		{
			{ Name = "MelCauldronOpenedSpeech", Time = 20 },
		},

		{ Cue = "/VO/Melinoe_1415", Text = "Should try this at the cauldron..." },
		-- { Cue = "/VO/Melinoe_1416", Text = "An incantation to attempt..." },
		{ Cue = "/VO/Melinoe_1417", Text = "That just might work..." },
		{ Cue = "/VO/Melinoe_1418", Text = "That does seem viable..." },
	},

	-- Locked Interactions
	LockedCauldronVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.35,

			{ Cue = "/VO/Melinoe_2821", Text = "It's being purified...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0516", Text = "Not right now...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0517", Text = "I'd better not..." },
		},
		{
			PreLineWait = 0.15,
			ObjectType = "NPC_Hecate_01",
			PlayOnce = true,
			PlayOnceContext = "FailedToUseCauldron",

			-- { Cue = "/VO/Hecate_0067", Text = "Hmm." },
		},
	},
	LockedBountyBoardVoiceLines =
	{
		{
			Queue = "Always",
			RandomRemaining = true,
			PreLineWait = 0.55,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0973", Text = "Can't see anything in here...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3081" },
					}
				},
			},
			{ Cue = "/VO/Melinoe_1861", Text = "Not happening." },
			{ Cue = "/VO/Melinoe_1862", Text = "Won't work." },
		},
	},
	LockedEphyraExitGateVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlayAll = 0.5,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
			Cooldowns =
			{
				{ Name = "MelinoeBarrierExitSpeech", Time = 120 },
			},

			{ Cue = "/VO/MelinoeField_0377", Text = "Can't get through, yet." },
			{ Cue = "/VO/MelinoeField_0378", Text = "It's drawing strength from somewhere nearby.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0379", Text = "Blast this thing." },
			{ Cue = "/VO/MelinoeField_0380", Text = "Getting somewhere...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
						Comparison = ">=",
						Value = 3,
					}
				}
			},
		},
	},
	LockedSellTraitShopVoiceLines =
	{
		{
			PlayOnce = true,
			PreLineWait = 0.35,
			BreakIfPlayed = true,

			{ Cue = "/VO/MelinoeField_3506", Text = "An old Pool of Purging. {#Emph}Hm." },
		},
		{ GlobalVoiceLines = "EndTechTestVoiceLines" },
	},
	UsedCharonScarecrowVoiceLines =
	{
		{
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "UsedCharonScarecrow",
			UsePlayerSource = true,
			BreakIfPlayed = true,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2492", Text = "A note says... {#Emph}Hey M. Take what you need for Gold. Honor system." },
		},
	},
	EnteredFortressVoiceLines =
	{
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.5,
			PreLineWait = 0.5,
			ThreadName = "RoomThread",
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Intro" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
			},

			{ Cue = "/VO/MelinoeField_2938", Text = "{#Emph}To all our family, welcome." },
			{ Cue = "/VO/MelinoeField_2939", Text = "The Fortress of the Gods...." },
			{ Cue = "/VO/MelinoeField_2940", Text = "Shelter from the storm." },
			{ Cue = "/VO/MelinoeField_2941", Text = "{#Emph}<Exhale>", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2942", Text = "...Ominous..." },
			{ Cue = "/VO/MelinoeField_2943", Text = "I'll show myself in." },
		},
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.5,
			PreLineWait = 0.5,
			ThreadName = "RoomThread",
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_PreBoss01" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
			},
			{ Cue = "/VO/MelinoeField_3107", Text = "...This is it.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3108", Text = "{#Emph}<Exhale>" },
			{ Cue = "/VO/MelinoeField_3109", Text = "OK..." },
			{ Cue = "/VO/MelinoeField_3110", Text = "Come on." },
			{ Cue = "/VO/MelinoeField_3111", Text = "Now..." },
			{ Cue = "/VO/MelinoeField_3112", Text = "Into the storm..." },
		},
	},

	CannotInteractVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionState", "InFlashback" },
			},
			{
				PathEmpty = { "RequiredKillEnemies" },
			}
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 8 },
		},

		{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
		-- { Cue = "/VO/Melinoe_0387", Text = "Not now." },
		-- { Cue = "/VO/Melinoe_0388", Text = "I'm spent." },
		-- { Cue = "/VO/Melinoe_0389", Text = "I'm out." },
		{ Cue = "/VO/Melinoe_0390", Text = "No use." },
	},
	TriedToBatheVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		GameStateRequirements =
		{
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{ Cue = "/VO/Melinoe_2999", Text = "Could ask someone to join me for a soak...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "Resources", "GiftPointsRare" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Melinoe_3000", Text = "They say to never bathe alone..." },
		{ Cue = "/VO/Melinoe_3001", Text = "Perhaps later..." },
		{ Cue = "/VO/Melinoe_3002", Text = "I shouldn't..." },
	},

	TriedToSitVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements =
			{
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
			},

			{ Cue = "/VO/Melinoe_3075", Text = "I won't sit idly by." },
			{ Cue = "/VO/Melinoe_3076", Text = "I'm rested well enough." },
			{ Cue = "/VO/Melinoe_3077", Text = "The task comes first.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3078", Text = "I don't think so." },
			{ Cue = "/VO/Melinoe_3079", Text = "I don't sit." },
			{ Cue = "/VO/Melinoe_3080", Text = "I much prefer to stand." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,

			{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}<Scoff>" },
			{ Cue = "/VO/Melinoe_1948", Text = "{#Emph}Ngh." },
			{ Cue = "/VO/Melinoe_1950", Text = "{#Emph}<Sigh>" },
			{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
		}
	},
	DocksDoorShutVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeLockedDoorSpeech", Time = 20 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_2958", Text = "The river's overflowed back there.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun", }
					},
				}
			},

			{ Cue = "/VO/Melinoe_3956", Text = "I made a Vow.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "LimitGraspShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun", }
					},
				},
			},
			{ Cue = "/VO/Melinoe_3957", Text = "The Altar first.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "LimitGraspShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun", }
					},
				},
			},
			{ Cue = "/VO/Melinoe_3958", Text = "Need to reduce my Grasp.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "LimitGraspShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun", }
					},
				},
			},
			{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
			{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
			{ Cue = "/VO/Melinoe_0390", Text = "No use." },
			{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
			{ Cue = "/VO/Melinoe_1854", Text = "Afraid not..." },
			{ Cue = "/VO/Melinoe_1855", Text = "Denied." },
			{ Cue = "/VO/Melinoe_1856", Text = "Denied..." },
		},
	},
	TriedCirceHutVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Circe_01",
			GameStateRequirements =
			{
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CirceSpokeRecently", Time = 4 },
			},
			{ Cue = "/VO/Circe_0162", Text = "I haven't tidied up!" },
			{ Cue = "/VO/Circe_0163", Text = "Nothing to see in there!" },
			{ Cue = "/VO/Circe_0164", Text = "No need to go in." },
			{ Cue = "/VO/Circe_0165", Text = "It's too much of a mess!", PlayFirst = true },
		},
	},

	WeaponLobOutOfAmmoVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.66,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				IsNone = { "Hub_Main", "Flashback_Hub_Main", "Flashback_DeathAreaBedroomHades", "Flashback_DeathArea", }
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "H_Bridge01" }
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2 },
			},
		},
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "NoLobAmmoSpeechPlayedRecently", Time = 180 },
		},
		{ Cue = "/VO/Melinoe_2744", Text = "Out of Shells.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2745", Text = "No Shells." },
		{ Cue = "/VO/Melinoe_2746", Text = "Need Shells." },
		{ Cue = "/VO/Melinoe_2747", Text = "Revaal's empty." },
	},

	WeaponSuitNoTargetVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		ChanceToPlay = 0.5,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.05,
		GameStateRequirements =
		{
			{
				Path = { "CurrentHubRoom", "Name" },
				IsNone = { "Hub_Main", "Flashback_Hub_Main", "Flashback_DeathAreaBedroomHades", "Flashback_DeathArea", }
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "SuitNoTargetSpeechPlayedRecently", Time = 180 },
		},
		{ Cue = "/VO/Melinoe_3913", Text = "No targets..." },
		{ Cue = "/VO/Melinoe_3914", Text = "Nothing in range..." },
		{ Cue = "/VO/Melinoe_3915", Text = "Need a target..." },
	},

	UsedChronosRemainsVoiceLines =
	{
		{
			PlayOnce = true,
			PlayOnceContext = "ChronosRemainsVO",
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},

			{ Cue = "/VO/MelinoeField_5096", Text = "That ought to hold you. A little extra time for what comes next." },
			{ Cue = "/VO/MelinoeField_3882", Text = "Not here... the past provides the guarantee." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.45,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_1600", Text = "Such power..." },
			{ Cue = "/VO/MelinoeField_1601", Text = "He's gone for now..." },
			{ Cue = "/VO/MelinoeField_1602", Text = "The remains of Time...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1603", Text = "So much for the ravages of Time..." },
			{ Cue = "/VO/MelinoeField_1604", Text = "I have what I need for now..." },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			PreLineWait = 2.0,

			{ Cue = "/VO/MelinoeField_1961", Text = "The chambers down the hall..." },
			{ Cue = "/VO/MelinoeField_1962", Text = "Should have a look around...", PlayFirst = true, },
		}
	},

	-- Tutorials
	ToolTutorialVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.5,
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasNone = { "ToolPickaxe", "ToolExorcismBook" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			{ Cue = "/VO/Melinoe_1912", Text = "Don't have the means just yet." },
			{ Cue = "/VO/Melinoe_1913", Text = "I lack the tools for this." },
		},
	},
	-- Surface Curse / Surface Penalty / SurfacePenalty
	CurseActiveVoiceLines =
	{
		Queue = "Interrupt",
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.33,
		SuccessiveChanceToPlayAll = 0.75,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
		},

		{ Cue = "/VO/Melinoe_0564", Text = "{#Emph}Ungh! {#Prev}What, I...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0565", Text = "{#Emph}Augh{#Prev}, this... again...?!" },
		{ Cue = "/VO/Melinoe_0566", Text = "{#Emph}Ngh{#Prev}, I... can't..." },
		-- { Cue = "/VO/Melinoe_0567", Text = "Rngh... the surface... I..." },
	},

	InteractionBlockedVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.15,
			SuccessiveChanceToPlay = 0.25,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				}
			},

			{ Cue = "/VO/Melinoe_0386", Text = "I can't.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
			{ Cue = "/VO/Melinoe_0390", Text = "No use." },
			{ Cue = "/VO/Melinoe_1859", Text = "Can't right now." },
			{ Cue = "/VO/Melinoe_1860", Text = "Can't." },
			{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
			{ Cue = "/VO/Melinoe_1861", Text = "Not happening." },
			{ Cue = "/VO/Melinoe_1862", Text = "Won't work." },

		},
		{
			RandomRemaining = true,
			PreLineWait = 0.15,
			SuccessiveChanceToPlay = 0.25,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionState", "InFlashback" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				}
			},

			{ Cue = "/VO/Melinoe_0127", Text = "I can't!" },
			{ Cue = "/VO/Melinoe_0128", Text = "Not now!" },
			{ Cue = "/VO/Melinoe_0131", Text = "It's no use!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0226", Text = "I can't!" },
			{ Cue = "/VO/Melinoe_1863", Text = "{#Emph}Erm{#Prev}, no!" },
			{ Cue = "/VO/Melinoe_1864", Text = "I can't right now!" },
			{ Cue = "/VO/Melinoe_1865", Text = "No time for that...!" },
			{ Cue = "/VO/Melinoe_1866", Text = "Can't do that now...!" },
		},
		{
			ObjectType = "Hecate",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "HecateSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/HecateField_0239", Text = "Seems not the time!" },
			{ Cue = "/VO/HecateField_0240", Text = "{#Emph}Hello?" },
			{ Cue = "/VO/HecateField_0241", Text = "Leave them be!" },
			{ Cue = "/VO/HecateField_0242", Text = "The fight comes first!", PlayFirst = true },
		},
		{
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Hermes_01",
			-- SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_PreBoss01" },
				},
			},
			Cooldowns =
			{
				{ Name = "HermesSpokeRecently", Time = 4 },
			},

			{ Cue = "/VO/Hermes_0148", Text = "Hello?", PlayFirst = true },
			{ Cue = "/VO/Hermes_0146", Text = "Anytime...?" },
			{ Cue = "/VO/Hermes_0147", Text = "Hey, {#Emph}erm...?" },
		},
	},
	KeepsakeExpiredVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		GameStateRequirements =
		{
			{
				-- PathEmpty = { "RequiredKillEnemies" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeKeepsakeExpiredSpeech", Time = 180 },
		},

		{ Cue = "/VO/MelinoeField_2207", Text = "Keepsake ran out..." },
		{ Cue = "/VO/MelinoeField_2208", Text = "My Keepsake's out..." },
		{ Cue = "/VO/MelinoeField_2209", Text = "This Keepsake's done..." },
		{ Cue = "/VO/MelinoeField_2210", Text = "My Keepsake expired...", PlayFirst = true },
	},
	NotEnoughCurrencyVoiceLines =
	{
		Queue = "Never",
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.75,
			ObjectType = "NPC_Dora_01",
			Cooldowns =
			{
				{ Name = "DoraAnyQuipSpeech", Time = 8 },
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "ActiveScreens", "CosmeticsShop" }
				},
			},

			{ Cue = "/VO/Dora_0265", Text = "Can't do that, Mel." },
			{ Cue = "/VO/Dora_0266", Text = "Don't have enough." },
			{ Cue = "/VO/Dora_0267", Text = "You don't have the goods." },
			{ Cue = "/VO/Dora_0268", Text = "Can't spot you, sorry." },
			{ Cue = "/VO/Dora_0269", Text = "Nah, can't." },
			{ Cue = "/VO/Dora_0270", Text = "Nope." },
			{ Cue = "/VO/Dora_0115", Text = "I'm gonna go with no...?" },
			{ Cue = "/VO/Dora_0117", Text = "No way." },
			{ Cue = "/VO/Dora_0118", Text = "Not happening." },
			{ Cue = "/VO/Dora_0119", Text = "No!", PlayFirst = true },
			{ Cue = "/VO/Dora_0120", Text = "How about... no?" },
		},
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},

				{ Cue = "/VO/MelinoeField_2493", Text = "I'm not some common thief...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsAny = { "P_Shop01", "P_PreBoss01", "Q_PreBoss01" }
						},
					}
				},
				{ Cue = "/VO/Melinoe_1223", Text = "Thought I had more Gold..." },
				{ Cue = "/VO/Melinoe_1224", Text = "Don't have the Gold for this." },
				{ Cue = "/VO/Melinoe_1225", Text = "I can't afford this." },
				{ Cue = "/VO/Melinoe_1226", Text = "That's out of my price range." },
				{ Cue = "/VO/Melinoe_1227", Text = "No Gold, no sale...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1228", Text = "I've insufficient funds..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.65,
				ChanceToPlay = 0.2,
				-- RequiresNullAmbientMusicId = true,
				ObjectType = "NPC_Charon_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				Cooldowns =
				{
					{ Name = "CharonSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Charon_0064", Text = "{#Emph}Mmm..." },
				{ Cue = "/VO/Charon_0065", Text = "{#Emph}Rrngh..." },
				{ Cue = "/VO/Charon_0066", Text = "{#Emph}Nghh..." },
				{ Cue = "/VO/Charon_0067", Text = "{#Emph}Heehh..." },
				{ Cue = "/VO/Charon_0068", Text = "{#Emph}Grngh..." },
				{ Cue = "/VO/Charon_0069", Text = "{#Emph}Aaugh..." },
			}
		},
		{ GlobalVoiceLines = "HermesNoMoneyReactionVoiceLines" },
		{ GlobalVoiceLines = "InsufficientMetaCurrencyVoiceLines" },
		{ GlobalVoiceLines = "InvalidResourceInteractionVoiceLines" },
	},
	NotEnoughHealthVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 5,
		CooldownName = "InteractBlockedRecently",

		GameStateRequirements =
		{
			-- None
		},

		{ Cue = "/VO/MelinoeField_0963", Text = "No blood to spare.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0964", Text = "Lost too much blood...",
			GameStateRequirements = 
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.85, },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_0965", Text = "Fresh out of blood...",
			GameStateRequirements = 
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.85, },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_0966", Text = "{#Emph}Ah{#Prev}, blast..." },
		{ Cue = "/VO/MelinoeField_0967", Text = "Some other time, Chaos..." },
		{ Cue = "/VO/MelinoeField_0968", Text = "I'm too scratched up...",
			GameStateRequirements = 
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.85, },
				},
			},
		},
	},
	CannotPurchaseVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 10,

		-- TKTK
	},
	ExitBlockedByEnemiesVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			ObjectType = "Hecate",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Boss01", "F_Boss02" },
				},
			},
			Cooldowns =
			{
				{ Name = "HecateSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/HecateField_0066", Text = "Face me!" },
			{ Cue = "/VO/HecateField_0067", Text = "Stand and fight!" },
			{ Cue = "/VO/HecateField_0068", Text = "Truly now?" },
			{ Cue = "/VO/HecateField_0069", Text = "There's no escaping me.", PlayFirst = true, },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			ObjectType = "Polyphemus",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Boss01", "N_Boss02" },
				},
			},
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/Polyphemus_0327", Text = "Why don't ya stick around?" },
			{ Cue = "/VO/Polyphemus_0328", Text = "Stay outta my barn." },
			{ Cue = "/VO/Polyphemus_0329", Text = "'Scuse me?" },
			{ Cue = "/VO/Polyphemus_0330", Text = "Nobody gets out.", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0331", Text = "You stay right there." },
			{ Cue = "/VO/Polyphemus_0332", Text = "{#Emph}Aw{#Prev}, don't go." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Icarus_01",
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "IcarusAnyQuipSpeech", Time = 6 },
			},

			{ Cue = "/VO/Icarus_0298", Text = "Wait up...!" },
			{ Cue = "/VO/Icarus_0299", Text = "Hang on...", PlayFirst = true },
			{ Cue = "/VO/Icarus_0300", Text = "{#Emph}Talk {#Prev}to me, Meli...!" },
			{ Cue = "/VO/Icarus_0301", Text = "That's cold...!" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			ObjectTypes = { "NPC_Heracles_01", "Heracles" },
			Cooldowns =
			{
				{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
			},

			{ Cue = "/VO/Heracles_0417", Text = "Stand and fight!",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0418", Text = "No retreating!",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0419", Text = "We're on the job, sister!",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0420", Text = "This isn't over!",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0421", Text = "Here.",
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
			},
			{ Cue = "/VO/Heracles_0422", Text = "Come.",
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			ObjectType = "Prometheus",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "PrometheusSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/Prometheus_0529", Text = "Such cowardice." },
			{ Cue = "/VO/Prometheus_0530", Text = "You're not going anywhere." },
			{ Cue = "/VO/Prometheus_0531", Text = "Fight me, blast you!", PlayFirst = true },
			{ Cue = "/VO/Prometheus_0532", Text = "You're staying here." },
		},
		{ GlobalVoiceLines = "ErisAttemptedExitVoiceLines" },
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0221", Text = "Locked." },
			{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
			{ Cue = "/VO/Melinoe_0223", Text = "Not an option." },
			{ Cue = "/VO/Melinoe_0224", Text = "Won't open." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0225", Text = "It's locked!" },
			{ Cue = "/VO/Melinoe_0226", Text = "I can't!" },
			{ Cue = "/VO/Melinoe_0227", Text = "Won't open!" },
		},
	},
	ExitBlockedByHealthVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		GameStateRequirements =
		{
			-- None
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_1327", Text = "No blood to spare right now..." },
		{ Cue = "/VO/MelinoeField_1328", Text = "Lost too much blood...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1329", Text = "I think Chaos can wait..." },
		{ Cue = "/VO/MelinoeField_1330", Text = "I can't go in like this..." },
		{ Cue = "/VO/MelinoeField_1331", Text = "Apologies, Chaos..." },
		{ Cue = "/VO/MelinoeField_1332", Text = "I'd visit if I could..." },
	},
	ExitBlockedByNemesisVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		GameStateRequirements =
		{
			-- None
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_1333", Text = "She locked me out...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1334", Text = "Nemesis..." },
		{ Cue = "/VO/MelinoeField_1335", Text = "Beat me to it." },
		{ Cue = "/VO/MelinoeField_1336", Text = "She got there first." },
	},
	FleeingEncounterVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		GameStateRequirements =
		{
			--
		},

		{ Cue = "/VO/Melinoe_1750", Text = "{#Emph}No {#Prev}thanks...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1751", Text = "Sorry, running late!" },
		{ Cue = "/VO/Melinoe_1752", Text = "You all take care!" },
		{ Cue = "/VO/Melinoe_1753", Text = "I'll be back!" },
	},

	SecretUnlockedVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "Chaos_01", "Chaos_02", "Chaos_03", "Chaos_04", "Chaos_05", "Chaos_06" },
			},
		},
		{
			PlayOnce = true,
			PreLineWait = 0.35,

			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
					HasNone = { "TemporaryForcedSecretDoorTrait" },
				},
			},

			{ Cue = "/VO/MelinoeField_0774", Text = "It wants some of my life essence before letting me in..." },
			{ Cue = "/VO/MelinoeField_0775", Text = "{#Emph}Gah{#Prev}, fine! It's only blood!", PreLineWait = 1.5, BreakIfPlayed = true },
		},
		Queue = "Never",
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_0788", Text = "I'm ready...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0789", Text = "To Chaos..." },
				{ Cue = "/VO/MelinoeField_0790", Text = "Going." },
				{ Cue = "/VO/MelinoeField_0791", Text = "{#Emph}<Inhale>" },
				{ Cue = "/VO/MelinoeField_0792", Text = "{#Emph}Eh{#Prev}, why not?" },
				{ Cue = "/VO/MelinoeField_0793", Text = "Chaos seeks me." },
				{ Cue = "/VO/MelinoeField_0973", Text = "Won't hurt at all.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
							HasAny = { "TemporaryForcedSecretDoorTrait" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0794", Text = "I've blood to spare...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
							HasNone = { "TemporaryForcedSecretDoorTrait" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0795", Text = "Sting away.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
							HasNone = { "TemporaryForcedSecretDoorTrait" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0796", Text = "A little pain is all.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
							HasNone = { "TemporaryForcedSecretDoorTrait" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0797", Text = "Hit me then.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "TraitUses" },
							HasNone = { "TemporaryForcedSecretDoorTrait" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0971", Text = "Let's meet your parent, Embryo.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "RandomBlessingKeepsake" },
						},
					}
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				ObjectType = "NPC_Arachne_01",

				{ Cue = "/VO/Arachne_0219", Text = "Oh do be careful!", PlayFirst = true },
				{ Cue = "/VO/Arachne_0220", Text = "Oh no!" },
				{ Cue = "/VO/Arachne_0250", Text = "You can {#Emph}do {#Prev}this!" },
				{ Cue = "/VO/Arachne_0251", Text = "You have this!" },
				{ Cue = "/VO/Arachne_0258", Text = "{#Emph}Oh...!" },
				{ Cue = "/VO/Arachne_0345", Text = "{#Emph}Huh?" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				ObjectType = "NPC_Narcissus_01",

				{ Cue = "/VO/Narcissus_0309", Text = "{#Emph}<Groan>" },
				{ Cue = "/VO/Narcissus_0310", Text = "{#Emph}<Groan>" },
				{ Cue = "/VO/Narcissus_0311", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/Narcissus_0312", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/Narcissus_0313", Text = "Anyway..." },
				{ Cue = "/VO/Narcissus_0314", Text = "Where were we...?" },
			},
		},
	},

	ContractAcceptedVoiceLines =
	{
		Queue = "Interrupt",
		{
			PlayOnce = true,
			PlayOnceContext = "FirstInfernalContractVO",
			PreLineWait = 0.25,

			{ Cue = "/VO/MelinoeField_4282", Text = "{#Emph}Whosoever claims this contract shall forthwith... <Scoff> {#Prev}I'm not reading all this..." },
			{ Cue = "/VO/MelinoeField_4283", Text = "Wait... {#Emph}gah!", PreLineWait = 0.5, BreakIfPlayed = true },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "C_Boss01" },
				},
			},
			Cooldowns =
			{
				-- { Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_4284", Text = "I accept these terms!" },
			{ Cue = "/VO/MelinoeField_4285", Text = "I accept this contract." },
			{ Cue = "/VO/MelinoeField_4286", Text = "I accept these terms... I think!" },
			{ Cue = "/VO/MelinoeField_4287", Text = "I accept this contract?" },
			{ Cue = "/VO/MelinoeField_4288", Text = "I'd like to see my brother so, I accept these terms!", },
			{ Cue = "/VO/MelinoeField_4289", Text = "All right, Zagreus. I accept these terms!", PlayFirst = true },
		},
	},

	RunClearedVoiceLines =
	{
		Queue = "Always",
		{
			PlayOnce = true,
			PlayOnceContext = "UniqueRunClearedVO",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.35,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
				},
				{
					PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
			{ Cue = "/VO/MelinoeField_5009", Text = "Disintegration of Monstrosity... it worked." },
		},
		{
			PlayOnce = true,
			PlayOnceContext = "FinalChronosKillVO",
			PreLineWait = 1.2,
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTimeStop" },
				},
				{
					PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
				},
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},

			{ Cue = "/VO/MelinoeField_5097", Text = "Done here. Now for the final step." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.11,
			SuccessiveChanceToPlayAll = 0.23,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAny = { "ChaosAboutKeepsakeQuest01", "ChaosAboutKeepsakeQuest01_B" },
				},
				{
					Path = { "CurrentRun", "KeepsakeCache" },
					UseLength = true,
					Comparison = "==",
					Value = 1,
				},
				{
					PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "RandomBlessingKeepsake" },
				},
			},
			{ Cue = "/VO/Chaos_0185", Text = "That was amusing to behold.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0151", Text = "{#Emph}<Laughter>" },
			{ Cue = "/VO/Chaos_0152", Text = "{#Emph}<Chuckle>" },
			{ Cue = "/VO/Chaos_0166", Text = "A desirable outcome." },
		},
		{ GlobalVoiceLines = "ChronosRunClearVoiceLines" },
		{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.15,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny =
					{
						"PackageBountyRandomUnderworld_Difficulty1",
						"PackageBountyRandomUnderworld_Difficulty2",
						"PackageBountyRandomSurface_Difficulty1",
						"PackageBountyRandomSurface_Difficulty2",
					},
				},
			},

			{ Cue = "/VO/MelinoeField_3746", Text = "For Almighty Chaos." },
			{ Cue = "/VO/MelinoeField_3747", Text = "By the will of Chaos.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3748", Text = "Everything is possible." },
			{ Cue = "/VO/MelinoeField_3749", Text = "Did Chaos witness this?" },
			{ Cue = "/VO/MelinoeField_4818", Text = "See that, Almighty Chaos?" },
			{ Cue = "/VO/MelinoeField_4819", Text = "This one's for you, Chaos." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.15,
			GameStateRequirements =
			{
				-- None
			},

			{ Cue = "/VO/MelinoeField_1407", Text = "Suffer in darkness...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1416", Text = "For my father!" },
			{ Cue = "/VO/MelinoeField_1417", Text = "For my mother!" },
			{ Cue = "/VO/MelinoeField_4814", Text = "In the name of Hades." },
			{ Cue = "/VO/MelinoeField_4816", Text = "For the Unseen!" },
			{ Cue = "/VO/MelinoeField_4817", Text = "You're gone." },
			{ Cue = "/VO/MelinoeField_4812", Text = "Time flows freely forth...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4815", Text = "For Hecate!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
					},
				},
			},

			-- underworld-specific
			{ Cue = "/VO/MelinoeField_1412", Text = "Fall, I said...!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1415", Text = "What did I tell you?",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1418", Text = "For my brother!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1419", Text = "For Cerberus!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1426", Text = "For the Underworld!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1420", Text = "For Nyx!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitMarkCritAspect" },
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1421", Text = "For Thanatos!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1422", Text = "For Hypnos!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HypnosFinalDreamMeeting01" }, Max = 6 },
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1423", Text = "For Olympus!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1424", Text = "For Charon!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1425", Text = "For what you did to this House!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1427", Text = "For Schelemeus!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 10,
					},
				}
			},

			-- surface-specific
			{ Cue = "/VO/MelinoeField_4813", Text = "This is our time.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3225", Text = "Fall, you monster.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3226", Text = "Got you, you monster.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3227", Text = "This is {#Emph}our {#Prev}mountain.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3228", Text = "Return to shadow, {#Emph}now.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3229", Text = "Down with Typhon.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3230", Text = "Olympus is secure.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1413", Text = "Fall, damn you.",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.25, },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1414", Text = "...Fall.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "Q" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3744", Text = "Chronos vanished too...",
				PlayFirst = true, PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "Q_Boss02" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3745", Text = "Takes care of both of them...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3744" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "Q_Boss02" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
				},
			},

		},
	},

	ShrineDoorUnlockedVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.35,

		--
	},

	UsedRerollVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				-- None
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 8 },
			},

			{ Cue = "/VO/MelinoeField_2362", Text = "Something else." },
			{ Cue = "/VO/MelinoeField_2363", Text = "What else?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2364", Text = "Not this." },
			{ Cue = "/VO/MelinoeField_2365", Text = "No." },

			{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
			{ Cue = "/VO/Melinoe_0214", Text = "This one." },
			{ Cue = "/VO/Melinoe_0215", Text = "How about..." },
			{ Cue = "/VO/Melinoe_0216", Text = "Should work." },
			{ Cue = "/VO/Melinoe_0218", Text = "Why not." },
			{ Cue = "/VO/Melinoe_0238", Text = "Sure." },
			{ Cue = "/VO/MelinoeField_4794", Text = "Anything else?" },
			{ Cue = "/VO/MelinoeField_4795", Text = "Not this." },
			{ Cue = "/VO/MelinoeField_4796", Text = "No thanks." },
			{ Cue = "/VO/MelinoeField_4797", Text = "Change of Fate." },
			{ Cue = "/VO/MelinoeField_4798", Text = "Something else." },
			{ Cue = "/VO/MelinoeField_4799", Text = "What else..." },
		},
	},
	RerollOutcomeVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				-- None
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0554_B", Text = "...OK." },
			{ Cue = "/VO/MelinoeField_0555_B", Text = "...There." },
			{ Cue = "/VO/MelinoeField_0557_B", Text = "...Good." },
			{ Cue = "/VO/MelinoeField_0559_B", Text = "It's done." },
			{ Cue = "/VO/MelinoeField_0561_B", Text = "{#Emph}Huh!" },
			{ Cue = "/VO/MelinoeField_4800", Text = "{#Emph}Hm." },
			{ Cue = "/VO/MelinoeField_4801", Text = "Oh." },
			{ Cue = "/VO/MelinoeField_4802", Text = "Right." },
			{ Cue = "/VO/MelinoeField_4803", Text = "Well then." },
		},
	},

	UsedRerollPanelVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				-- None
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0783", Text = "Infinite possibility..." },
			{ Cue = "/VO/MelinoeField_0784", Text = "Let's see how this goes..." },
			{ Cue = "/VO/MelinoeField_0786", Text = "Worth the risk." },
			{ Cue = "/VO/MelinoeField_0787", Text = "The Fates won't mind..." },
			{ Cue = "/VO/Melinoe_1398", Text = "Let's do it." },
			{ Cue = "/VO/Melinoe_1400", Text = "Sure, why not." },
			{ Cue = "/VO/MelinoeField_4788", Text = "Something else?" },
			{ Cue = "/VO/MelinoeField_4789", Text = "Let's see what else." },
			{ Cue = "/VO/MelinoeField_4790", Text = "I choose otherwise." },
			{ Cue = "/VO/MelinoeField_4791", Text = "Let's try this again." },
			{ Cue = "/VO/MelinoeField_4792", Text = "Not what I want." },
			{ Cue = "/VO/MelinoeField_4793", Text = "{#Emph}Mm{#Prev}, what else?" },
		},
		{ GlobalVoiceLines = "ArtemisReRollReactionVoiceLines" },
	},

	ChangedRNGVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				-- None
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_4012", Text = "My Fate is mine.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_4013", Text = "This is Fate." },
			{ Cue = "/VO/Melinoe_4014", Text = "For the Fates." },
			{ Cue = "/VO/Melinoe_4015", Text = "For the daughters of Night." },
		},
	},

	CannotRerollVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,
			CooldownTime = 7,

			-- TKTK
		},
	},

	UsedTransformVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				-- None
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1665", Text = "Transform." },
			{ Cue = "/VO/MelinoeField_1666", Text = "Transform...!" },
			{ Cue = "/VO/MelinoeField_1667", Text = "Transform..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Story01" },
				},
			},
			ObjectType = "NPC_Narcissus_01",
			Cooldowns =
			{
				{ Name = "NarcissusSpokeRecently", Time = 8 },
			},

			{ Cue = "/VO/Narcissus_0225", Text = "Wait, what?" },
			{ Cue = "/VO/Narcissus_0226", Text = "Wha?" },
			{ Cue = "/VO/Narcissus_0227", Text = "How did you...?" },
			{ Cue = "/VO/Narcissus_0228", Text = "Weird!", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0229", Text = "Whoa...!" },
			{ Cue = "/VO/Narcissus_0230", Text = "Huh!" },
		},
	},

	CannotFightVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0231", Text = "Not here." },
			{ Cue = "/VO/Melinoe_0232", Text = "Not permitted.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0233", Text = "Not happening." },
		},
	},

	StruckArmorVoiceLines =
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.66,
		ChanceToPlay = 0.66,
		CooldownTime = 500,

		GameStateRequirements =
		{
			-- None
		},

		{ Cue = "/VO/Melinoe_1119", Text = "This one's armored..." },
		{ Cue = "/VO/Melinoe_1120", Text = "Absorbed my strike...", PlayFirst = true },
	},

	RootedFoesVoiceLines =
	{
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_MiniBoss01", "F_MiniBoss02", "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.25, },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeCastSpeech", Time = 330 },
		},
		{
			BreakIfPlayed = true,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_2061" },
				},
			},

			{ Cue = "/VO/MelinoeField_2062", Text = "Got you." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.033,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "DemeterCastBoon" },
				},
			},

			{ Cue = "/VO/MelinoeField_1378", Text = "Freeze." },
			{ Cue = "/VO/MelinoeField_1379", Text = "Shiver." },
			{ Cue = "/VO/MelinoeField_1380", Text = "Cold take you." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.033,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "HestiaCastBoon" },
				},
			},

			{ Cue = "/VO/MelinoeField_1375", Text = "Burn...!" },
			{ Cue = "/VO/MelinoeField_1376", Text = "Burn." },
			{ Cue = "/VO/MelinoeField_1377", Text = "You'll burn." },
		},
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.033,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty", "PoseidonCastBoon" },
				},
			},

			{ Cue = "/VO/MelinoeField_0262", Text = "Caught." },
			{ Cue = "/VO/MelinoeField_0263", Text = "Caught you." },
			{ Cue = "/VO/MelinoeField_0264", Text = "Hold still.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0266", Text = "Hold." },
			{ Cue = "/VO/MelinoeField_0267", Text = "Ensnared." },
			{ Cue = "/VO/MelinoeField_0268", Text = "Bound." },
			{ Cue = "/VO/MelinoeField_0269", Text = "Stay where you are." },
			{ Cue = "/VO/MelinoeField_0270", Text = "No you don't." },
			{ Cue = "/VO/MelinoeField_0271", Text = "Stop." },
			{ Cue = "/VO/MelinoeField_2062", Text = "Got you." },
		},
		{
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.5,
			PreLineWait = 0.66,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Story01" },
				},
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasNone = GameData.ArachneUpsetEvents,
				},
			},
			ObjectType = "NPC_Arachne_01",
			Cooldowns =
			{
				{ Name = "ArachneSpokeRecently", Time = 10 },
			},

			{ Cue = "/VO/Arachne_0226", Text = "Pinned them!" },
			{ Cue = "/VO/Arachne_0227", Text = "They're stuck!" },
			{ Cue = "/VO/Arachne_0228", Text = "Don't mess with her!" },
			{ Cue = "/VO/Arachne_0229", Text = "Get away from her!" },
			{ Cue = "/VO/Arachne_0230", Text = "Now {#Emph}shoo!" },
			{ Cue = "/VO/Arachne_0231", Text = "Back off!" },
		},

	},

	WonExitRaceVoiceLines =
	{
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.66,
		ThreadName = "RoomThread",
		PreLineWait = 0.25,
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_0056", Text = "No you don't...!", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0057", Text = "Got to go!" },
		{ Cue = "/VO/MelinoeField_0058", Text = "Well I'm off!" },
		{ Cue = "/VO/MelinoeField_0059", Text = "Bye Nem!" },
		{ Cue = "/VO/MelinoeField_0060", Text = "Mine!" },
		{ Cue = "/VO/MelinoeField_0061", Text = "Don't you dare!" },
		{ Cue = "/VO/MelinoeField_0062", Text = "I think not!" },
		{ Cue = "/VO/MelinoeField_0063", Text = "Nice try!" },
	},

	UniqueLastStandSourcesLookup =  
	{
		ReincarnationKeepsake = true,
		LastStandFamiliar = true,
		Athena = true,
	},

	LastStandVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeLastStandSpeech", Time = 60 }
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0771", Text = "I think not!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0772", Text = "I don't think so!" },
			{ Cue = "/VO/Melinoe_0773", Text = "{#Emph}Augh{#Prev}, blast!" },
			{ Cue = "/VO/Melinoe_0774", Text = "{#Emph}Rngh {#Prev}no..." },
			{ Cue = "/VO/Melinoe_0775", Text = "{#Emph}Nrgh {#Prev}damn it!" },
			{ Cue = "/VO/Melinoe_0776", Text = "{#Emph}Nghh {#Prev}not finished!" },
			{ Cue = "/VO/MelinoeField_0704", Text = "...won't... fail...!" },
			{ Cue = "/VO/MelinoeField_0705", Text = "{#Emph}Augh! {#Prev}Not... yet!" },
			{ Cue = "/VO/MelinoeField_0706", Text = "{#Emph}Ungh! {#Prev}All right!" },
			{ Cue = "/VO/MelinoeField_0708", Text = "How about {#Emph}this...!" },
			{ Cue = "/VO/MelinoeField_4848", Text = "The Commander's Tooth!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "ReincarnationKeepsake" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4849", Text = "For Commander Schelemeus!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "ReincarnationKeepsake" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4850", Text = "The Luckier Tooth!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "ReincarnationKeepsake" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4851", Text = "Commander, I won't fail!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "ReincarnationKeepsake" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4852", Text = "Cheers Toula...!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "LastStandFamiliar" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4853", Text = "I'm OK, Toula...!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "LastStandFamiliar" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4854", Text = "Thanks, Toula...!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "LastStandFamiliar" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4855", Text = "Good, Toula!",
				PlayFirst = true,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "LastStandFamiliar" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4856", Text = "Athena!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "Athena" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4857", Text = "Lady Athena!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "Athena" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4858", Text = "Gods grant me strength!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "Athena" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4859", Text = "For Olympus!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "LastStandUsed", "Name", },
						IsAny = { "Athena" },
					},
				},
			},
		},
	},
	LastStandLastLifeVoiceLines =
	{
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			CooldownTime = 60,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_0707", Text = "No more mistakes!" },
			{ Cue = "/VO/MelinoeField_0709", Text = "One... last... chance!" },
			{ Cue = "/VO/MelinoeField_0710", Text = "{#Emph}Nngh{#Prev}... won't... fail...!" },
			{ Cue = "/VO/MelinoeField_0711", Text = "I can't do that again..." },
			{ Cue = "/VO/MelinoeField_0712", Text = "I'll make this count!" },
			{ Cue = "/VO/MelinoeField_0713", Text = "I'm not returning {#Emph}yet...!" },
			{ Cue = "/VO/MelinoeField_0714", Text = "{#Emph}Gah! {#Prev}Just... fight!" },
			{ Cue = "/VO/MelinoeField_0715", Text = "I still can fight...!" },
			{ Cue = "/VO/MelinoeField_0716", Text = "{#Emph}Ungh{#Prev}, this is it!" },
		},
	},
	InfiniteLastStandVoiceLines =
	{
		Queue = "Interrupt",
		{
			PlayOnceThisRun = true,
			PlayOnceContext = "InfiniteLastStandUsedVO",
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_5197", Text = "{#Emph}Chronos! Enough!!" },
			{ Cue = "/VO/MelinoeField_5198", Text = "I said {#Emph}stop!" },
		},
	},
	BlockDeathVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.75,
			Cooldowns =
			{
				{ Name = "MelBlockedDeathSpeech", Time = 240 },
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_2001", Text = "It's not my time just yet...!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2002", Text = "If I could just...!" },
			{ Cue = "/VO/Melinoe_2003", Text = "I can hold on, I—!" },
			{ Cue = "/VO/Melinoe_2004", Text = "It's now or never...!" },
			{ Cue = "/VO/Melinoe_2005", Text = "Forestall my doom...!" },
			{ Cue = "/VO/Melinoe_2006", Text = "My doom forestalled again...!" },
		},
	},

	ChronosFatalityVoiceLines =
	{
		{
			PreLineWait = 1.0,
			{ Cue = "/VO/MelinoeField_5094", Text = "Then {#Emph}this {#Prev}is for that future..." },
		},
		{
			PreLineWait = 0.4,
			SkipAnim = true,
			{ Cue = "/VO/MelinoeField_5095", Text = "...{#Emph}and our family!" },
		},
	},

	TyphonFatalityVoiceLines =
	{
		{
			PreLineWait = 0.9,
			RandomRemaining = true,

			{ Cue = "/VO/MelinoeField_4174", Text = "{#Emph}Typhon!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_4175", Text = "{#Emph}Typhon...!" },
			{ Cue = "/VO/MelinoeField_5013", Text = "Hey {#Emph}Typhon...!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/MelinoeField_4174", "/VO/MelinoeField_4175" },
					},
					ChanceToPlay = 0.5,
				},
			},
			{ Cue = "/VO/MelinoeField_5012", Text = "Oh, {#Emph}Typhon!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/MelinoeField_4174", "/VO/MelinoeField_4175", "/VO/MelinoeField_5013" },
					},
					ChanceToPlay = 0.5,
				},
			},
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,

			{ Cue = "/VO/MelinoeField_4176", Text = "Your time is {#Emph}over!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_4177", Text = "This ends {#Emph}now!" },
			{ Cue = "/VO/MelinoeField_4178", Text = "There is no escape!" },
			{ Cue = "/VO/MelinoeField_4179", Text = "Return to shadow, {#Emph}now!" },
			{ Cue = "/VO/MelinoeField_5014", Text = "This is for you!" },
			{ Cue = "/VO/MelinoeField_5015", Text = "In the name of Hades!" },
			{ Cue = "/VO/MelinoeField_5016", Text = "You're {#Emph}nothing!" },
			{ Cue = "/VO/MelinoeField_5017", Text = "Back to the abyss!" },
		},
	},

	BoulderIncomingVoiceLines =
	{
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			PreLineWait = 0.35,
			Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "N_Boss01" }
				},
			},

			{ Cue = "/VO/Polyphemus_0309", Text = "Heads up...!", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0310", Text = "Heads up over there!" },
			{ Cue = "/VO/Polyphemus_0311", Text = "Got something for ya!" },
			{ Cue = "/VO/Polyphemus_0312", Text = "Oops I dropped something!" },
			{ Cue = "/VO/Polyphemus_0313", Text = "Hey, catch this!" },
			{ Cue = "/VO/Polyphemus_0314", Text = "Heard ya from way over here!" },
		},
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlayAll = 0.33,
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0525", Text = "Incoming...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0526", Text = "Up there...!" },
			{ Cue = "/VO/MelinoeField_0527", Text = "Boulder...!", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0526" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_0528", Text = "Uh-oh...!" },
		},
	},

	SelfDamageVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.05,
			Cooldowns =
			{
				{ Name = "ChaosDamageSpeech", Time = 100 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			GameStateRequirements =
			{
				-- None
			},

			{ Cue = "/VO/MelinoeField_0957", Text = "{#Emph}Augh, {#Prev}Chaos, right!" },
			{ Cue = "/VO/MelinoeField_0958", Text = "{#Emph}Urgh, {#Prev}Chaos curse!" },
			{ Cue = "/VO/MelinoeField_0959", Text = "{#Emph}Guh, {#Prev}cheers Chaos!" },
			{ Cue = "/VO/MelinoeField_0960", Text = "{#Emph}Argh, {#Prev}cursed...!" },
			{ Cue = "/VO/MelinoeField_0961", Text = "{#Emph}Ngh, {#Prev}I'm cursed!" },
			{ Cue = "/VO/MelinoeField_0962", Text = "{#Emph}Uff, {#Prev}that was Chaos...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.21,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift01" },
				},
			},
			Cooldowns =
			{
				{ Name = "ChaosSpokeRecently", Time = 30 },
			},

			{ Cue = "/VO/Chaos_0141", Text = "Be careful, Spawn of Hades." },
			{ Cue = "/VO/Chaos_0142", Text = "This was avoidable." },
			{ Cue = "/VO/Chaos_0143", Text = "A momentary lapse." },
			{ Cue = "/VO/Chaos_0144", Text = "Be mindful of my mark." },
			{ Cue = "/VO/Chaos_0145", Text = "Remember my mark." },
			{ Cue = "/VO/Chaos_0146", Text = "You did agree to this...", PlayFirst = true },
			{ Cue = "/VO/Chaos_0147", Text = "Was that worthwhile?" },
			{ Cue = "/VO/Chaos_0148", Text = "A questionable choice." },
			{ Cue = "/VO/Chaos_0149", Text = "Ill-advised." },
			{ Cue = "/VO/Chaos_0150", Text = "Do not forget my mark." },
			{ Cue = "/VO/Chaos_0151", Text = "{#Emph}<Laughter>" },
			{ Cue = "/VO/Chaos_0152", Text = "{#Emph}<Chuckle>" },
		},
	},
	HitByMiasmaVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Cooldowns =
			{
				{ Name = "HitByMiasmaSpeech", Time = 120 },
				{ Name = "RecoveredFromMiasmaSpeech", Time = 3 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.75, },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H" },
				},
			},

			{ Cue = "/VO/MelinoeField_0868", Text = "{#Emph}Ungh... {#Prev}what...?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0869", Text = "...I can't..." },
			{ Cue = "/VO/MelinoeField_0870", Text = "...What's the use..." },
			{ Cue = "/VO/MelinoeField_0871", Text = "This... {#Emph}ungh..." },
			{ Cue = "/VO/MelinoeField_0872", Text = "...I can't do this..." },
			{ Cue = "/VO/MelinoeField_0873", Text = "...I'm a failure..." },
			{ Cue = "/VO/MelinoeField_0874", Text = "...I'm a fraud..." },
			{ Cue = "/VO/MelinoeField_0875", Text = "...No one cares..." },
			{ Cue = "/VO/MelinoeField_0876", Text = "...I'm alone..." },
			{ Cue = "/VO/MelinoeField_0877", Text = "...Nothing matters..." },
		},
	},
	RecovedFromMiasmaVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Cooldowns =
			{
				{ Name = "RecovederFromMiasmaSpeech", Time = 120 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/MelinoeField_0869", "/VO/MelinoeField_0870", "/VO/MelinoeField_0872", "/VO/MelinoeField_0873", "/VO/MelinoeField_0874", "/VO/MelinoeField_0875", "/VO/MelinoeField_0876", "/VO/MelinoeField_0877" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H" },
				},
			},

			{ Cue = "/VO/MelinoeField_0878", Text = "...No." },
			{ Cue = "/VO/MelinoeField_0879", Text = "...Nonsense." },
			{ Cue = "/VO/MelinoeField_0880", Text = "...Mustn't listen." },
			{ Cue = "/VO/MelinoeField_0881", Text = "...Not true..." },
		},
	},
	FieldsEncounterStartedVoiceLines =
	{
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "FieldsEncounterStartedSpeech" },

			{ Cue = "/VO/MelinoeField_0890", Text = "It's stuck...! Uh-oh...", PlayFirst = true, PlayOnce = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				{
					PathFromArgs = true,
					Path = { "Encounter", "Name", },
					IsNone = { "NemesisCombatH" },
				},
			},

			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "FieldsEncounterStartedSpeech", Time = 240 },
			},

			{ Cue = "/VO/MelinoeField_0891", Text = "I've drawn them out..." },
			{ Cue = "/VO/MelinoeField_0892", Text = "They know I'm here..." },
			{ Cue = "/VO/MelinoeField_0893", Text = "Here they come..." },
			{ Cue = "/VO/MelinoeField_0894", Text = "Come fight me!" },
			{ Cue = "/VO/MelinoeField_0895", Text = "I'm ready for you!" },
			{ Cue = "/VO/MelinoeField_0896", Text = "I'm not your prey." },
			{ Cue = "/VO/MelinoeField_0897", Text = "Incoming..." },
			{ Cue = "/VO/MelinoeField_0898", Text = "This corruption..." },
			{ Cue = "/VO/MelinoeField_0899", Text = "This doesn't belong here." },
			{ Cue = "/VO/MelinoeField_0900", Text = "They won't like this..." },
			{ Cue = "/VO/MelinoeField_0905", Text = "Stuck!", PreLineWait = 0.4 },
			{ Cue = "/VO/MelinoeField_0906", Text = "First, my foes...!", PreLineWait = 0.4 },
			{ Cue = "/VO/MelinoeField_0907", Text = "It's sealed in...!", PreLineWait = 0.5 },
			{ Cue = "/VO/MelinoeField_0908", Text = "Can't take this yet...", PreLineWait = 0.5 },

			{ Cue = "/VO/MelinoeField_0901", Text = "Got their attention, huh..." },
			{ Cue = "/VO/MelinoeField_0902", Text = "Going to be a problem..." },
			{ Cue = "/VO/MelinoeField_0903", Text = "That one again...?",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "H_Boss01", "H_Boss02" },
						Comparison = ">=",
						Value = 10,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0904", Text = "Come on out!" },
		},
	},
	FieldsEncounterClearedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelCombatResolvedSpeech", Time = 180 },
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.33,
			PreLineWait = 1.0,
			ThreadName = "RoomThread",

			{ Cue = "/VO/MelinoeField_0909", Text = "It's over." },
			{ Cue = "/VO/MelinoeField_0910", Text = "It's cleared up." },
			{ Cue = "/VO/MelinoeField_0911", Text = "Point secured." },
			{ Cue = "/VO/MelinoeField_0912", Text = "Now my reward..." },
			{ Cue = "/VO/MelinoeField_0913", Text = "Now for what's mine." },
			{ Cue = "/VO/MelinoeField_0914", Text = "Corruption cleared." },
			{ Cue = "/VO/MelinoeField_0915", Text = "Where was I...?" },
			{ Cue = "/VO/MelinoeField_0916", Text = "And now my claim.", PlayFirst = true },
		},
		{ GlobalVoiceLines = "CombatResolvedVoiceLines" },
	},

	ExitsUnlockedVoiceLines =
	{
		-- Low Health context
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 3.15,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "N" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone =
					{
						"F_PreBoss01", "F_Boss01", "F_Boss02", "F_Reprieve01", "F_Shop01",
						"G_PreBoss01", "G_Boss01", "G_Boss02", "G_Reprieve01", "G_Shop01",
						"H_Boss01", "H_Boss02", "H_Reprieve01", "H_Shop01",
						"I_Boss01", "I_Reprieve01", "I_Shop01",
						"N_PreBoss01", "N_Boss01", "N_Boss02", "N_Reprieve01", "N_Shop01",
						"O_PreBoss01", "O_Boss01", "O_Boss02", "O_Reprieve01", "O_Shop01",
						"P_PreBoss01", "P_Boss01", "P_Reprieve01", "P_Shop01",
						"Q_Combat10", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02",
					},
				},				
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = "<",
					Value = 20,
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					Path = { "CurrentRun", "Hero", "LastStands", },
					UseLength = true,
					Comparison = "<=",
					Value = 0,
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = "<=", Value = 0.33, },
				},
			},

			{ Cue = "/VO/Melinoe_1831", Text = "Can't recover here... need to press on...", PlayFirst = true, PlayOnce = true },
			{ Cue = "/VO/Melinoe_1832", Text = "Keep going..." },
			{ Cue = "/VO/Melinoe_1833", Text = "Keep pushing..." },
			-- { Cue = "/VO/Melinoe_1834", Text = "Farther..." },
			{ Cue = "/VO/Melinoe_1835", Text = "Not finished..." },
			{ Cue = "/VO/Melinoe_1836", Text = "No mistakes..." },
		},
	},
	LockedExtraExitsFoundVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.33,
			PlayOnceFromTableThisRun = true,

			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "G_Intro", "G_Story01", "G_Boss01", "G_Boss02" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1731", Text = "Could unseal one of the other paths." },
			{ Cue = "/VO/MelinoeField_1732", Text = "Unseal one of the other paths perhaps...?" },
			{ Cue = "/VO/MelinoeField_1733", Text = "Worth it to unseal another path...?" },
			{ Cue = "/VO/MelinoeField_1734", Text = "Risky to unseal a different path..." },
		},
	},

	OceanusExitVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.33,
			PlayOnceFromTableThisRun = true,

			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "G_Intro", "G_Story01", "G_Boss01", "G_Boss02" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0142", Text = "Down we go." },
			{ Cue = "/VO/MelinoeField_0143", Text = "Down the drain..." },
			{ Cue = "/VO/MelinoeField_0144", Text = "Going in..." },
			{ Cue = "/VO/MelinoeField_0145", Text = "Here goes..." },
			{ Cue = "/VO/MelinoeField_0146", Text = "Don't look down..." },
			{ Cue = "/VO/MelinoeField_0147", Text = "Jump..." },
		},
	},

	ShipsRouteChoiceOfferedVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.45,
			PlayOnce = true,
			PlayOnceContext = "ShipsChoiceFirstVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "MelinoeRouteOfferedSpeech" },

			{ Cue = "/VO/MelinoeField_1817", Text = "That strange wheel...", PlayFirst = true, PlayOnce = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.4,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeRouteOfferedSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1747", Text = "Sailing on." },
			{ Cue = "/VO/MelinoeField_1748", Text = "Next bearing.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1820", Text = "The ship's helm..." },
			{ Cue = "/VO/MelinoeField_1821", Text = "Now for the captain's wheel..." },
			{ Cue = "/VO/MelinoeField_1818", Text = "And now to set a course...",
				GameStateRequirements =
				{
					{
						Path = { "MapState", "ShipWheels", },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1819", Text = "New course needs to be set...",
				GameStateRequirements =
				{
					{
						Path = { "MapState", "ShipWheels", },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1745", Text = "Which way now?",
				GameStateRequirements =
				{
					{
						Path = { "MapState", "ShipWheels", },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1746", Text = "Change of course...?",
				GameStateRequirements =
				{
					{
						Path = { "MapState", "ShipWheels", },
						UseLength = true,
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
	},

	ShipsMutinyVoiceLines =
	{
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "O" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.2, },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeMutinySpeech", Time = 180 },
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/MelinoeField_2110", Text = "Beg pardon." },
		{ Cue = "/VO/MelinoeField_2111", Text = "Out of my way.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2112", Text = "I'll take it from here." },
		{ Cue = "/VO/MelinoeField_2113", Text = "Stand down." },
	},

	ShipsRouteChoiceMadeVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			PlayOnce = true,
			PlayOnceContext = "ShipsFirstChoiceMadeVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "MelinoeRouteChoiceSpeech" },

			{ Cue = "/VO/MelinoeField_1824", Text = "Bearing set!" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeRouteChoiceSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1822", Text = "Need to get closer!" },
			{ Cue = "/VO/MelinoeField_1824", Text = "Bearing set!" },
			{ Cue = "/VO/MelinoeField_1827", Text = "Sink or swim!" },
			{ Cue = "/VO/MelinoeField_1829", Text = "Breaking through!" },
			{ Cue = "/VO/MelinoeField_1830", Text = "Push closer!" },
			{ Cue = "/VO/MelinoeField_1831", Text = "Faster!" },
			{ Cue = "/VO/MelinoeField_1823", Text = "This way!",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Wheel", "Name", },
						IsAny = { "ShipsSteeringWheelLeft", "ShipsSteeringWheelRight", },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1825", Text = "We'll go around!",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Wheel", "Name", },
						IsAny = { "ShipsSteeringWheelLeft", "ShipsSteeringWheelRight", },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1826", Text = "Dead ahead!", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Wheel", "Name", },
						IsNone = { "ShipsSteeringWheelLeft", "ShipsSteeringWheelRight", },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1828", Text = "Full speed ahead.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Wheel", "Name", },
						IsNone = { "ShipsSteeringWheelLeft", "ShipsSteeringWheelRight", },
					},
				},
			},

		},
	},

	ShipsWheelDestroyedVoiceLines =
	{
		{
			PlayOnce = true,
			PlayOnceContext = "ShipsFirstWheelDestroyedVO",
			Queue = "Interrupt",
			PreLineWait = 0.75,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_0528", Text = "Uh-oh...!" },
		},
	},

	ShipsCanExitVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			PlayOnce = true,
			PlayOnceContext = "ShipsExitFirstVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_Shop01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "MelinoeShipsExitOpenedSpeech" },

			{ Cue = "/VO/MelinoeField_1743", Text = "Need to get off this ship...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_Shop01", "O_PreBoss01", "O_Boss01", "O_Boss02" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeShipsExitOpenedSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1744", Text = "Exit gateway activated...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1832", Text = "Time to abandon ship.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1833", Text = "Pushed her far enough...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1834", Text = "Now for the next one.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1835", Text = "Spectral Gate activated.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1743", Text = "Need to get off this ship..." },
		},
	},
	ShipsExitVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			PlayOnce = true,
			PlayOnceContext = "ShipsFirstIntroExitVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "MelinoeShipsExitUsedSpeech" },

			{ Cue = "/VO/MelinoeField_1809", Text = "Take me away." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_PreBoss01" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.15, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1854", Text = "Now take me to the coast!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1855", Text = "To dry land!" },
			{ Cue = "/VO/MelinoeField_1856", Text = "To the shore!" },
			{ Cue = "/VO/MelinoeField_1857", Text = "One last stop." },
		},
		{
			{
				PreLineWait = 0.35,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "O_Story01" },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.15, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_1898", Text = "Farewell, Madame!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1899", Text = "Thank you for having me!" },
				{ Cue = "/VO/MelinoeField_1900", Text = "Good seeing you again!" },
				{ Cue = "/VO/MelinoeField_1901", Text = "Be well, Madame!" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.75,
				ObjectType = "NPC_Circe_01",

				{ Cue = "/VO/Circe_0172", Text = "Farewell!", PlayFirst = true },
				{ Cue = "/VO/Circe_0173", Text = "Safe travels!" },
				{ Cue = "/VO/Circe_0173_B", Text = "Safe {#Emph}travels!" },
				{ Cue = "/VO/Circe_0174", Text = "Carry on!" },
				{ Cue = "/VO/Circe_0175", Text = "Come back soon!" },
				{ Cue = "/VO/Circe_0176", Text = "Moonlight guide you!" },
				{ Cue = "/VO/Circe_0177", Text = "She'll be back, piggies." },
			},
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "O_PreBoss01", "O_Boss01" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeShipsExitUsedSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_1809", Text = "Take me away." },
			{ Cue = "/VO/MelinoeField_1813", Text = "Transfer now!" },
			{ Cue = "/VO/MelinoeField_1814", Text = "Transfer me." },
			{ Cue = "/VO/Melinoe_0806", Text = "This way..." },
			{ Cue = "/VO/Melinoe_0807", Text = "Steady now...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_Intro" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1812", Text = "To the next vessel!", PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_Intro" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1810", Text = "Next vessel!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_Intro" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1811", Text = "Next vessel.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_Intro" },
					},
				},
			},
		},
	},
	OlympusSkyExitVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.92,
			SuccessiveChanceToPlay = 0.33,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "P" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "P_Shop01", "P_PostBoss01" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeOlympusExitUsedSpeech", Time = 180 },
			},

			{ Cue = "/VO/MelinoeField_2494", Text = "{#Emph}Whuh?!", PlayFirst = true, PlayOnce = true, PlayOnceContext = "OlympusSkyExitIntroVO", PreLineWait = 1.22, },
			{ Cue = "/VO/MelinoeField_2495", Text = "Taking off!" },
			{ Cue = "/VO/MelinoeField_2496", Text = "Take me away!" },
			{ Cue = "/VO/MelinoeField_2497", Text = "Blast off!" },
			{ Cue = "/VO/MelinoeField_2498", Text = "Here goes." },
			{ Cue = "/VO/MelinoeField_2499", Text = "Going up." },
			{ Cue = "/VO/MelinoeField_2793", Text = "Skyward!" },
			{ Cue = "/VO/MelinoeField_1350", Text = "Here we go!" },
		},

	},
	OlympusSkyEntranceVoiceLines =
	{
		{
			PlayOnce = true,
			PlayOnceContext = "PostTrueEndingOlympusIntroVO",
			PreLineWait = 0.5,
			SkipAnim = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			{ Cue = "/VO/MelinoeField_4582", Text = "The Titan's remnant Legions still not giving up..." },
		},
		{
			PlayOnce = true,
			PlayOnceContext = "AutomatonIntroVO",
			PreLineWait = 0.75,
			SkipAnim = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "OlympusIntro" },
				},
			},

			{ Cue = "/VO/MelinoeField_2679", Text = "Olympian Automatons, defending the mountain..." },
			{ Cue = "/VO/MelinoeField_2680", Text = "Let me see if I can't help a bit!", PreLineWait = 1.2 },

			{ Cue = "/VO/MelinoeField_2681", Text = "Wait, why are you attacking {#Emph}me?", PreLineWait = 3.3 },
			{ Cue = "/VO/MelinoeField_2682", Text = "You leave me little choice...!", PreLineWait = 2.3, BreakIfPlayed = true },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			SuccessiveChanceToPlay = 0.25,
			SkipAnim = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "P" },
				},
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "OlympusIntro" },
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeOlympusJumpEntranceSpeech", Time = 180 },
				{ Name = "OlympusEnemiesSightedVO", Time = 12 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2500", Text = "I'm flying...! Wait...", PlayFirst = true, PlayOnce = true },
			{ Cue = "/VO/MelinoeField_2501", Text = "...Hello!",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2502", Text = "There they are...",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2503", Text = "Spotted them...",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2504", Text = "Targets sighted...",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2505", Text = "Look out below...",
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2795", Text = "Clear landing spot...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2796", Text = "Looks to be clear...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					}
				},
			},
			{ Cue = "/VO/MelinoeField_2794", Text = "I have this..." },
			{ Cue = "/VO/MelinoeField_2797", Text = "And down we go..." },
		},
	},

	NextWaveVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone =
				{
					"ArtemisCombatIntro",
					"ArtemisCombatF",
					"ArtemisCombatG",
					"ArtemisCombatN",
					"NemesisCombatIntro",
					"NemesisCombatF",
					"NemesisCombatG",
					"HeraclesCombatN",
					"DevotionTestF",
					"DevotionTestG",
					"DevotionTestN",
					"BossHecate01",
					"BossHecate02",
					"BossPolyphemus01",
					"BossPolyphemus02",
					"BossScylla01",
					"BossScylla02",
					"BossInfestedCerberus01",
					"BossInfestedCerberus02",
					"BossChronos01",
					"BossChronos02"
				},
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.15,
		SuccessiveChanceToPlay = 0.15,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeCombatQuipPlayed", Time = 360 },
		},

		{ Cue = "/VO/Melinoe_0293", Text = "Who's next." },
		{ Cue = "/VO/Melinoe_0294", Text = "Who else?" },
		{ Cue = "/VO/Melinoe_0295", Text = "Come on!" },
		{ Cue = "/VO/Melinoe_0296", Text = "You dare?", 
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasNone = { "/VO/Melinoe_1778" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0297", Text = "Hmph." },
		{ Cue = "/VO/Melinoe_0298", Text = "{#Emph}Tsch." },
		{ Cue = "/VO/Melinoe_0299", Text = "Right." },
		{ Cue = "/VO/Melinoe_0300", Text = "More coming..." },
		{ Cue = "/VO/Melinoe_0301", Text = "More...!" },
		{ Cue = "/VO/Melinoe_0302", Text = "More?" },
	},
	FinalWaveVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.8,
		SuccessiveChanceToPlay = 0.03,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeFinalWaveSpeech", Time = 600 },
		},

		{ Cue = "/VO/Melinoe_1970", Text = "They're slowing down...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1971", Text = "Should be the last of them..." },
		{ Cue = "/VO/Melinoe_1972", Text = "The final reinforcements..." },
		{ Cue = "/VO/Melinoe_1973", Text = "We're almost there, hold on...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "F" },
				},
			},
		},
	},
	TrapsActivatedVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapsActivatedSpeech", Time = 600 },
			},

			{ Cue = "/VO/Melinoe_0714", Text = "What the?", PlayFirst = true, PlayFirstContext = "OceanusTrapIntroVO" },
			{ Cue = "/VO/MelinoeField_0156", Text = "Water spouts activated..." },
			{ Cue = "/VO/MelinoeField_0157", Text = "Those spouts again..." },
			{ Cue = "/VO/MelinoeField_0158", Text = "The water spouts..." },
			{ Cue = "/VO/MelinoeField_0159", Text = "Spouts are up..." },
		},
	},

	-- Typhon
	TyphonIncursionVoiceLines =
	{
		{
			Queue = "Interrupt",
			-- RandomRemaining = true,
			-- SuccessiveChanceToPlay = 0.85,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_MiniBoss03" },
				},
			},
			Cooldowns =
			{
				-- { Name = "MelinoeAnyQuipSpeech" },
			},
			{ Cue = "/VO/MelinoeField_3000", Text = "{#Emph}<Gasp>",
				PlayOnce = true, PlayOnceContext = "TyphonTailJumpScareVO" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.0,
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_MiniBoss03" },
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_3236", Text = "That's... a {#Emph}tail...!", PlayFirst = true, PlayOnce = true, },
			{ Cue = "/VO/MelinoeField_3237", Text = "No you don't...!" },
			{ Cue = "/VO/MelinoeField_3238", Text = "There you are...!" },
			{ Cue = "/VO/MelinoeField_3239", Text = "Come on!" },
			{ Cue = "/VO/MelinoeField_3290", Text = "{#Emph}Blast!" },
			{ Cue = "/VO/MelinoeField_3240", Text = "Oh {#Emph}hello!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" }
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				}
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "Q_MiniBoss03", "Q_Boss01", "Q_Boss02" },
				},
			},
			Cooldowns =
			{
				-- { Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_0535", Text = "Wha...?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0536", Text = "What?!" },
			{ Cue = "/VO/MelinoeField_3000", Text = "{#Emph}<Gasp>" },
			{ Cue = "/VO/MelinoeField_0525", Text = "Incoming...!" },
			{ Cue = "/VO/MelinoeField_0526", Text = "Up there...!" },
			{ Cue = "/VO/MelinoeField_0528", Text = "Uh-oh...!" },
			{ Cue = "/VO/MelinoeField_3113", Text = "Typhon...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3114", Text = "Typhon...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3115", Text = "Here he comes...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3116", Text = "Here he comes...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3117", Text = "Found me...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3118", Text = "There he is...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
		},
	},
	TyphonRetreatReactionVoiceLines =
	{
		{
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.25,
			RecheckRequirementsPostWait = true,
			RecheckRequirementsForSubLines = true,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_3348", Text = "He's gone into the storm...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3349", Text = "Here comes the brood...", PreLineWait = 1.3 },
			{ Cue = "/VO/MelinoeField_3337", Text = "Where do you think {#Emph}you're {#Prev}going?!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3338", Text = "Get back here and {#Emph}fight!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3339", Text = "Making your {#Emph}children {#Prev}do the work?!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3340", Text = "But you just {#Emph}got {#Prev}here!!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
		},
		{ GlobalVoiceLines = "TyphonHidingVoiceLines" },
	},
	TyphonInjuredReactionVoiceLines =
	{
		{
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 1.0,
			SuccessiveChanceToPlayAll = 0.1,
			RecheckRequirementsPostWait = true,
			RecheckRequirementsForSubLines = true,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "TyphonHead" },
					Comparison = "<=",
					Value = 2,
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			{ Cue = "/VO/MelinoeField_3350", Text = "He's looking worse...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3351", Text = "My strikes are getting through...!",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3186" }
					},
				},
			},
		},
		{ GlobalVoiceLines = "TyphonUnHidingVoiceLines" },
	},
	TyphonPhaseSkipReactionVoiceLines =
	{
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlay = 0.75,
			SuccessiveChanceToPlayAll = 0.25,
			RecheckRequirementsPostWait = true,
			RecheckRequirementsForSubLines = true,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "TyphonHighDamagePhaseSkip" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_3346", Text = "That's what you {#Emph}get!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3341", Text = "Like {#Emph}that?!" },
			{ Cue = "/VO/MelinoeField_3342", Text = "Get {#Emph}out!!" },
			{ Cue = "/VO/MelinoeField_3343", Text = "{#Emph}There!!" },
			{ Cue = "/VO/MelinoeField_3344", Text = "Blasted {#Emph}fiend!" },
			{ Cue = "/VO/MelinoeField_3345", Text = "Die {#Emph}yourself!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
						HasAny =
						{
							"/VO/Typhon_0048",
							"/VO/Typhon_0050",
							"/VO/Typhon_0052",
							"/VO/Typhon_0054",
							"/VO/Typhon_0056",
						},
					},
				},
			},
		},
		{ GlobalVoiceLines = "TyphonWoundedVoiceLines" },
	},

	OlympianArrivalVoiceLines =
	{
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			-- SuccessiveChanceToPlayAll = 0.66,
			GameStateRequirements =
			{
				--[[
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				]]--
			},
			Cooldowns =
			{
				{ Name = "OlympianArrivalSpeech", Time = 20 },
			},

			{ Cue = "/VO/MelinoeField_3000", Text = "{#Emph}<Gasp>" },
			{ Cue = "/VO/MelinoeField_3119", Text = "The gods...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3120", Text = "The gods..." },
			{ Cue = "/VO/MelinoeField_3121", Text = "Olympus...!" },
			{ Cue = "/VO/MelinoeField_3122", Text = "Lord Zeus...!" },
			{ Cue = "/VO/MelinoeField_3203", Text = "Lord Zeus...!" },
			{ Cue = "/VO/MelinoeField_3125", Text = "They're here!" },
			{ Cue = "/VO/MelinoeField_3126", Text = "Reinforcements...!" },
			{ Cue = "/VO/MelinoeField_3127", Text = "There they are..." },
			{ Cue = "/VO/MelinoeField_3204", Text = "There he is!" },
			{ Cue = "/VO/MelinoeField_3205", Text = "Finally...!" },
			{ Cue = "/VO/MelinoeField_3206", Text = "At last...!" },
			{ Cue = "/VO/MelinoeField_3207", Text = "Right on time..." },
			{ Cue = "/VO/MelinoeField_3208", Text = "Hello, Lord Uncle!" },
		},
	},
	TyphonKnockdownVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlay = 0.5,
			Source = { LineHistoryName = "NPC_Zeus_01", SubtitleColor = Color.ZeusVoice },

			{ Cue = "/VO/Zeus_0220", Text = "{#Emph}Now{#Prev}, young lady, {#Emph}finish {#Prev}this!", PlayFirst = true },
			{ Cue = "/VO/Zeus_0221", Text = "He's weakened, end this {#Emph}now!" },
			{ Cue = "/VO/Zeus_0222", Text = "Quickly now, {#Emph}attack!" },
			{ Cue = "/VO/Zeus_0223", Text = "End this now, Melinoë!" },
			{ Cue = "/VO/Zeus_0224", Text = "He's down, now hit him hard!" },
			{ Cue = "/VO/Zeus_0225", Text = "Melinoë, we're all counting on you!" },
			{ Cue = "/VO/Zeus_0226", Text = "That ought to soften him for you!" },
			{ Cue = "/VO/Zeus_0227", Text = "Go, you know what to do!" },
			{ Cue = "/VO/Zeus_0363", Text = "Young lady, I must leave the rest to you!" },
			{ Cue = "/VO/Zeus_0364", Text = "Fight on, this was as long as I could stay!" },
			{ Cue = "/VO/Zeus_0365", Text = "Now get him, Niece, exactly as before!" },
			{ Cue = "/VO/Zeus_0366", Text = "You have him now, Melinoë, fight on!" },
			{ Cue = "/VO/Zeus_0232", Text = "Hold nothing back!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Zeus_0233", Text = "Keep fighting him!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Zeus_0234", Text = "Take that monster down!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				--[[
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				]]--
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_3128", Text = "Now's our chance...!" },
			{ Cue = "/VO/MelinoeField_3129", Text = "He's down...!" },
			{ Cue = "/VO/MelinoeField_3130", Text = "Now...!" },
			{ Cue = "/VO/MelinoeField_3131", Text = "{#Emph}Thank you!!" },
			{ Cue = "/VO/MelinoeField_3209", Text = "This is it!!" },
			{ Cue = "/VO/MelinoeField_3210", Text = "All right, {#Emph}now!" },
			{ Cue = "/VO/MelinoeField_3211", Text = "He's vulnerable...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3212", Text = "Quickly now...!" },
			{ Cue = "/VO/MelinoeField_3213", Text = "Get him {#Emph}now...!" },
			{ Cue = "/VO/MelinoeField_3214", Text = "I have this...!" },
		},
	},

	AnomalySearchingForExitVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PlayOnce = true,
			PlayOnceContext = "AnomalyPostTrueEndingIntroVO",
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/MelinoeField_0205", "/VO/MelinoeField_0206", "/VO/MelinoeField_0207", "/VO/MelinoeField_0208", "/VO/MelinoeField_0209", "/VO/MelinoeField_0210" },
				},
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "GeneratedAnomalyB" }
				},
			},

			{ Cue = "/VO/MelinoeField_4781", Text = "This still can happen..." },
		},
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.35,
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/MelinoeField_0205", "/VO/MelinoeField_0206", "/VO/MelinoeField_0207", "/VO/MelinoeField_0208", "/VO/MelinoeField_0209", "/VO/MelinoeField_0210" },
				},
				{
					PathTrue = { "GameState", "EncountersCompletedCache", "GeneratedAnomalyB" }
				},
			},
			Cooldowns =
			{
				{ Name = "AnomalyVOPlayed", Time = 4 },
			},

			{ Cue = "/VO/MelinoeField_4781", Text = "This still can happen...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/MelinoeField_4781" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_4782", Text = "Some trace of a bad dream...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0197", Text = "Must be a way out." },
			{ Cue = "/VO/MelinoeField_0198", Text = "Won't be staying long..." },
			{ Cue = "/VO/MelinoeField_0199", Text = "Need to get out...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0200", Text = "He can't contain me here..." },
		},
	},

	AnomalyCombatBeginsVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { Name = "AnomalyVOPlayed" },

		{ Cue = "/VO/MelinoeField_0205", Text = "Every bad dream has an escape..." },
		{ Cue = "/VO/MelinoeField_0206", Text = "Just need to hold within this rift...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0207", Text = "This rift should open if I concentrate..." },
		{ Cue = "/VO/MelinoeField_0208", Text = "I'm going back where I belong..." },
		{ Cue = "/VO/MelinoeField_0209", Text = "Headmistress taught me well..." },
		{ Cue = "/VO/MelinoeField_0210", Text = "I'm getting out of here." },
	},

	AnomalyEncounterSurvivedVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 4.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/MelinoeField_0211", Text = "...Finally." },
		{ Cue = "/VO/MelinoeField_0212", Text = "...At last." },
		{ Cue = "/VO/MelinoeField_0213", Text = "...There we are." },
		{ Cue = "/VO/MelinoeField_0214", Text = "...What's this?" },
		{ Cue = "/VO/MelinoeField_0215", Text = "...What's that..." },
	},

	HecateDefeatedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "BossVanquishedSpeech", Time = 60 },
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ GlobalVoiceLines = "SeleneVictoryVoiceLines" },
		{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
		-- Selene reactions
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 1.3,
			Queue = "Always",
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "SeleneGift02" },
				},
				{
					Path = { "GameState", "GamePhase", },
					Comparison = "~=",
					Value = 5,
				},
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/HecateField_0251", "/VO/HecateField_0252", "/VO/HecateField_0253", "/VO/HecateField_0254" },
				},
			},

			{ Cue = "/VO/Selene_0285", Text = "I knew you would prevail.", PlayFirst = true },
			{ Cue = "/VO/Selene_0286", Text = "I merely watch impartially." },
			{ Cue = "/VO/Selene_0287", Text = "Here I do not take sides." },
			{ Cue = "/VO/Selene_0289", Text = "You have prevailed again." },
			{ Cue = "/VO/Selene_0290", Text = "Another victory." },
			{ Cue = "/VO/Selene_0291", Text = "Impressive, little star." },
			{ Cue = "/VO/Selene_0292", Text = "The true test lies beyond." },
			{ Cue = "/VO/Selene_0288", Text = "A hard-fought victory.",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<", Value = 0.4, },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.25,
			SuccessiveChanceToPlayAll = 0.5,

			{ Cue = "/VO/Melinoe_0172", Text = "Victory..." },
			{ Cue = "/VO/Melinoe_0173", Text = "I prevailed..." },
			{ Cue = "/VO/Melinoe_0174", Text = "I passed the test...", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_0175", Text = "Outlasted her..." },
			{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
			{ Cue = "/VO/Melinoe_0176", Text = "Thank you, Headmistress...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossOutro01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HecateBossOutro01" }, Min = 6 },
					},
				},
			},
		},
		{
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
				},
				{
					Path = { "GameState", "UseRecord", "InspectPoint" },
					Comparison = ">=",
					Value = 10,
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = "<=",
					Value = 10,
				},
			},

			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.25,
			SuccessiveChanceToPlay = 0.25,
			Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
			StatusAnimation = "StatusIconStorytellerSpeaking",
			StatusAnimSourceIsHero = true,

			{ Cue = "/VO/Storyteller_0111", Text = "{#Emph}The Princess stands victorious again.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 12,
					},
				},
			},
			{ Cue = "/VO/Storyteller_0112", Text = "{#Emph}She trained relentlessly for this." },
			{ Cue = "/VO/Storyteller_0070", Text = "{#Emph}The fire-stepping Princess stands alone." },
		},
	},

	BarrierWeakenedVoiceLines =
	{
		-- if this changes, update PylonObjectiveRevealed =
		{
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "BarrierStatusVOPlayedRecently" },

			{ Cue = "/VO/MelinoeField_0619", Text = "{#Emph}Hm. {#Prev}Part of the barrier is down... must've been that Pylon I destroyed.", PreLineWait = 0.75 },
			{ Cue = "/VO/MelinoeField_0619_02", Text = "So what, five more to go...?", PreLineWait = 0.8 },
		},
	},

	AltRunDoorUnlockedVoiceLines =
	{
		{
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_1843", Text = "OK...", PreLineWait = 0.6 },
			{ Cue = "/VO/Melinoe_0852", Text = "Should be able to head to the surface now...", PreLineWait = 1.6 },
		},
	},
	NextStopTyphonVoiceLines =
	{
		{
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_5159", Text = "All right, Typhon. Perhaps this night shall be your last." },
		},
	},
	NextStopChronosVoiceLines =
	{
		{
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_5160", Text = "It's finally time... {#Emph}Death to Chronos..." },
		},
	},

	NextStopPostTrueEndingVoiceLines =
	{
		{
			PreLineWait = 0.85,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_5740", Text = "All right. Time to put Grandfather's theories to the test..." },
			{ Cue = "/VO/Melinoe_5741", Text = "Only question is where to begin.", PreLineWait = 1.0 },
			-- { Cue = "/VO/Melinoe_5672", Text = "Grandfather should be somewhere up ahead..." },
			-- { Cue = "/VO/Melinoe_5671", Text = "Let's see how this goes...", PreLineWait = 1.0 },
		},
	},

	NewDoorHintVoiceLines =
	{
		Queue = "Interrupt",
		{
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_1900", Text = "Come on, Mel. Exit's back the other way...", PreLineWait = 0.5 },
		},
	},
	BountyBoardUnlockedVoiceLines =
	{
		{
			PreLineWait = 0.6,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_1960", Text = "Oh..." },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			ObjectType = "NPC_Skelly_01",
			PreLineAnim = "Skelly_Explaining",

			{ Cue = "/VO/Skelly_0087", Text = "What sorcery has touched the Pitch-Black Stone?" },
		},
	},
	ShrineUnlockedVoiceLines =
	{
		{
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_0898", Text = "{#Emph}<Gasp>", PreLineWait = 0.6 },
			{ Cue = "/VO/Melinoe_2855", Text = "It can't be... that's...", PreLineWait = 0.6 },
			{ Cue = "/VO/Melinoe_2863", Text = "The Oath of the Unseen...", PreLineWait = 1.0 },
		},
	},
	TrophyQuestUnlockedVoiceLines =
	{
		{
			{
				UsePlayerSource = true,
				PreLineWait = 0.4,

				{ Cue = "/VO/Melinoe_0810", Text = "What...?" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "SkellyAboutTrophy1VO",
				PreLineWait = 0.8,
				ObjectType = "NPC_Skelly_01",
				PreLineAnim = "Skelly_Explaining",

				{ Cue = "/VO/Skelly_0300", Text = "At last, you are {#Emph}prepared{#Prev}, young one!", PlayFirst = true },
			},
			{
				PlayOnce = true,
				UsePlayerSource = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,

				{ Cue = "/VO/Melinoe_3267", Text = "Commander, what is {#Emph}that?" },
			},
		},
	},
	TrophyAdmirationVoiceLines =
	{
		-- while locked
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
				},
			},

			{ Cue = "/VO/Melinoe_3517", Text = "The Gifts of the Veil..." },
			{ Cue = "/VO/Melinoe_3518", Text = "I mustn't look...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3519", Text = "I won't betray my vows." },
			{ Cue = "/VO/Melinoe_3520", Text = "I've not yet earned the right." },
		},

		-- once unlocked
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
				},
			},

			{ Cue = "/VO/Melinoe_3523", Text = "She sure looks strong.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3521", Text = "Quite a likeness..." },
			{ Cue = "/VO/Melinoe_3522", Text = "Not how I picture myself..." },
			{ Cue = "/VO/Melinoe_3524", Text = "She's tall, I'll give her that." },
			{ Cue = "/VO/Melinoe_3526", Text = "I'm huge..." },
			{ Cue = "/VO/Melinoe_3279", Text = "Wow..." },
			{ Cue = "/VO/Melinoe_3284", Text = "Huh..." },
			{ Cue = "/VO/Melinoe_3268", Text = "The Gifts of Night...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
				},
			},		
			{ Cue = "/VO/Melinoe_3525", Text = "Hello, ladies...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3447", Text = "Past, present, future...?",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.85,
			ObjectType = "NPC_Skelly_01",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
				},
			},

			{ Cue = "/VO/Skelly_0112", Text = "Behold...!" },
			{ Cue = "/VO/Skelly_0113", Text = "Behold." },
			{ Cue = "/VO/Skelly_0114", Text = "{#Emph}Behold!" },
			{ Cue = "/VO/Skelly_0124", Text = "Such youthful vigor..." },
			{ Cue = "/VO/Skelly_0384", Text = "Pretty nice, {#Emph}huh?" },
			{ Cue = "/VO/Skelly_0385", Text = "Isn't she a beaut?", PlayFirst = true },
			{ Cue = "/VO/Skelly_0386", Text = "Look at them {#Emph}femurs!" },
			{ Cue = "/VO/Skelly_0387", Text = "The Gifts of the Veil!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" },
					},
				},
			},
		},
		{
			PlayOnce = true,
			PlayOnceContext = "SkellyLockedStatueReaction",
			BreakIfPlayed = true,
			PreLineWait = 0.55,
			SuccessiveChanceToPlay = 0.85,
			ObjectType = "NPC_Skelly_01",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
				},
			},

			{ Cue = "/VO/Skelly_0122", Text = "Cease messing with that thing!", PreLineAnim = "Skelly_Babbling" },
		},

	},

	ElementsUnlockedVoiceLines =
	{
		{
			PlayOnce = true,
			PlayOnceContext = "ElementalBoonIntroVO",
			PreLineWait = 1.35,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			-- { Cue = "/VO/MelinoeField_0510", Text = "I sense the elemental essences here now..." },
			{ Cue = "/VO/MelinoeField_1045", Text = "Through Divination of the Elements, I see it now." },
		},
	},

	FirstUnityBoonUnlockedVoiceLines =
	{
		{
			PlayOnce = true,
			PlayOnceContext = "UnityBoonIntroVO",
			PreLineWait = 1.2,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "TestAllThings" },
				},
			},
			{ Cue = "/VO/MelinoeField_0510", Text = "I sense the elemental essences here now..." },
		},
	},

	UpgradeMenuOpenVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.35,
			PreLineWait = 1.35,
			RecheckRequirementsPostWait = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentLootData", "HasExchange" },
				},
				{
					PathTrue = { "ActiveScreens", "UpgradeChoice" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "SwapBoonSpeech", Time = 300 }
			},

			{ Cue = "/VO/MelinoeField_2250", Text = "Give up a Boon...?" },
			{ Cue = "/VO/MelinoeField_2251", Text = "Make the sacrifice...?" },
			{ Cue = "/VO/MelinoeField_2252", Text = "I could switch Boons..." },
			{ Cue = "/VO/MelinoeField_2253", Text = "Could sacrifice a Boon..." },
			{ Cue = "/VO/MelinoeField_2254", Text = "A possible exchange..." },
			{ Cue = "/VO/MelinoeField_2257", Text = "Switch to a rarer Boon...?" },
			{ Cue = "/VO/Melinoe_1991", Text = "A Boon for another." },
			{ Cue = "/VO/Melinoe_1992", Text = "A possible exchange..." },
			{ Cue = "/VO/Melinoe_1993", Text = "I can make an exchange..." },
			{ Cue = "/VO/Melinoe_1994", Text = "Could make a trade..." },
			{ Cue = "/VO/MelinoeField_2255", Text = "He wants a sacrifice...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Gender" },
						IsAny = { "Male" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1996", Text = "He's suggesting an exchange.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Gender" },
						IsAny = { "Male" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2256", Text = "She wants a sacrifice...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Gender" },
						IsAny = { "Female" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1995", Text = "She's suggesting an exchange.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Gender" },
						IsAny = { "Female" },
					},
				},
			},
		},
	},
	SwapUpgradePickedVoiceLines =
	{
		--[[
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownName = "SaidZeusRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownName = "SaidPoseidonRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownName = "SaidAphroditeRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownName = "SaidDemeterRecently",
			CooldownTime = 40,

			-- TKTK
		},
		]]--
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.5,
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "ReplacedTraitSource", },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},

			{ Cue = "/VO/MelinoeField_2261", Text = "A necessary sacrifice.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2258", Text = "This Boon is worth the sacrifice." },
			{ Cue = "/VO/MelinoeField_2259", Text = "This is the Boon I need." },
			{ Cue = "/VO/MelinoeField_2260", Text = "Some sacrifices must be made." },
			{ Cue = "/VO/MelinoeField_2262", Text = "I really need this Boon." },
			{ Cue = "/VO/MelinoeField_2263", Text = "Too good a Boon to miss." },
			{ Cue = "/VO/MelinoeField_2264", Text = "They're making me pick favorites..." },
			{ Cue = "/VO/MelinoeField_2265", Text = "How could I possibly refuse?" },
		},
	},

	ReturnToHubVoiceLines =
	{
		{
			UsePlayerSource = true,
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlay = 0.25,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N" },
				},
				{
					Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
					Comparison = ">=",
					Value = 1,
				},
				{
					Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
					Comparison = "<=",
					Value = 4,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "N_Opening01", "N_PreHub01", "N_Hub", "N_Story01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.CombatNPCEncounters
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
			},
			ThreadName = "RoomThread",
			Cooldowns =
			{
				{ Name = "NCombatResolvedSpeech", Time = 120 },
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_0410", Text = "Should head back out..." },
			{ Cue = "/VO/MelinoeField_0411", Text = "Think I'm finished here." },
			{ Cue = "/VO/MelinoeField_0412", Text = "Done here." },
			{ Cue = "/VO/MelinoeField_0413", Text = "Now to head back." },
			{ Cue = "/VO/Melinoe_1378", Text = "Should head to the main square.", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_1379", Text = "Shall we head back, Homer?", ChanceToPlay = 0.05 },
		},
		{ GlobalVoiceLines = "StorytellerReturnToHubVoiceLines" },
		{ GlobalVoiceLines = "StorytellerFightReactionVoiceLines" },
	},

	UpgradePickedVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings", "H_Bridge01", "I_PreBoss01", "I_PreBoss02", "N_Story01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		-- @ remember this affects the entire table no matter where it is (so always put cooldowns at the top of tables)
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		-- Artemis
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				-- SuccessiveChanceToPlayAll = 0.5,
				PreLineWait = 0.35,
				PreLineAnim = "Artemis_Blessing",
				ObjectType = "NPC_Artemis_Field_01",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsNone = { "StackUpgrade" },
					},
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "Name" },
						IsAny = { "NPC_Artemis_Field_01" },
					},
				},

				{ Cue = "/VO/Artemis_0117", Text = "Very well." },
				{ Cue = "/VO/Artemis_0118", Text = "There." },
				{ Cue = "/VO/Artemis_0120", Text = "My blessing is yours.", PlayFirst = true },
				{ Cue = "/VO/Artemis_0121", Text = "Then it's yours." },
				{ Cue = "/VO/Artemis_0122", Text = "My mark be with you." },
				{ Cue = "/VO/Artemis_0123", Text = "My mark is yours." },
				{ Cue = "/VO/Artemis_0124", Text = "My strength is yours." },
				{ Cue = "/VO/Artemis_0125", Text = "Together we shine." },
				{ Cue = "/VO/Artemis_0367", Text = "You have it." },
				{ Cue = "/VO/Artemis_0368", Text = "It's already within." },
				{ Cue = "/VO/Artemis_0369", Text = "Perfect." },
				{ Cue = "/VO/Artemis_0370", Text = "Smart." },
			},
		},
		-- Athena
		{
			{
				-- BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				PreLineAnim = "Athena_Blessing",
				ObjectType = "NPC_Athena_01",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "Name" },
						IsAny = { "NPC_Athena_01" },
					},
				},

				{ Cue = "/VO/Athena_0005", Text = "The might and fury of Olympus be with you!", PlayFirst = true },
				{ Cue = "/VO/Athena_0087", Text = "Wise choice." },
				{ Cue = "/VO/Athena_0088", Text = "Wisely decided." },
				{ Cue = "/VO/Athena_0089", Text = "A sound plan." },
				{ Cue = "/VO/Athena_0090", Text = "Then very well." },
				{ Cue = "/VO/Athena_0091", Text = "Excellent." },
				{ Cue = "/VO/Athena_0092", Text = "I see." },
				{ Cue = "/VO/Athena_0093", Text = "Done." },
				{ Cue = "/VO/Athena_0094", Text = "I concur." },
				{ Cue = "/VO/Athena_0095", Text = "You shall have it." },
				{ Cue = "/VO/Athena_0096", Text = "Go with grace." },
				{ Cue = "/VO/Athena_0102", Text = "Then make haste." },
				{ Cue = "/VO/Athena_0097", Text = "Your brother's favorite.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "InvulnerabilityDashBoon" },
						},
					},
				},
				{ Cue = "/VO/Athena_0098", Text = "{#Emph}Ah{#Prev}, yes.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "InvulnerabilityDashBoon" },
						},
					},
				},
				{ Cue = "/VO/Athena_0099", Text = "A safe choice.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "InvulnerabilityDashBoon" },
						},
					},
				},
				{ Cue = "/VO/Athena_0100", Text = "When in doubt...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "InvulnerabilityDashBoon" },
						},
					},
				},
				{ Cue = "/VO/Athena_0101", Text = "How did I know?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "InvulnerabilityDashBoon" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "ThankingAthenaVoiceLines" },
		},
		-- Dionysus
		{
			{
				-- BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.65,
				PreLineAnim = "Dionysus_Blessing",
				ObjectType = "NPC_Dionysus_01",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Story01" },
					},
				},

				{ Cue = "/VO/Dionysus_0005", Text = "...And, don't tell Athena or anybody that you saw us here.", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Dionysus_0087", Text = "Done and done!" },
				{ Cue = "/VO/Dionysus_0088", Text = "Oh, {#Emph}yeah!" },
				{ Cue = "/VO/Dionysus_0089", Text = "Coming right up!" },
				{ Cue = "/VO/Dionysus_0090", Text = "Coming right up." },
				{ Cue = "/VO/Dionysus_0091", Text = "Perk you right up." },
				{ Cue = "/VO/Dionysus_0092", Text = "Nice." },
				{ Cue = "/VO/Dionysus_0093", Text = "Called it!" },
				{ Cue = "/VO/Dionysus_0094", Text = "Absolutely." },
				{ Cue = "/VO/Dionysus_0095", Text = "Good choice!" },
				{ Cue = "/VO/Dionysus_0096", Text = "Enjoy!" },
				{ Cue = "/VO/Dionysus_0097", Text = "Well all right!" },
				{ Cue = "/VO/Dionysus_0098", Text = "Drink up!" },
				{ Cue = "/VO/Dionysus_0099", Text = "Cool!" },
				{ Cue = "/VO/Dionysus_0100", Text = "Right on!" },
				{ Cue = "/VO/Dionysus_0101", Text = "Smashing!" },
				{ Cue = "/VO/Dionysus_0102", Text = "I'm into it!" },
				{ Cue = "/VO/Dionysus_0085", Text = "Cheers!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "/VO/Dionysus_0086", "/VO/Dionysus_0126" }
						},
					},
				},
				{ Cue = "/VO/Dionysus_0086", Text = "Cheers.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "/VO/Dionysus_0086", "/VO/Dionysus_0126" }
						},
					},
				},
			},
			{ GlobalVoiceLines = "ThankingDionysusVoiceLines" },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "Shop" },
				},
				{
					Path = { "CurrentLootData", "Name" },
					IsNone = { "NPC_Artemis_Field_01" },
				},
			},

			-- Apollo
			{ 
				Queue = "Always",
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0631", Text = "They need my aid. We'll see if I need theirs.", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "ApolloUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ApolloFirstPickUp" },
					},
				},
			},

			-- Zeus
			{	
				UsePlayerSource = true,
				Cue = "/VO/MelinoeField_1599", Text = "{#Emph}Ngh! {#Prev}Lord Uncle's Titan-killing strength...!",
				PreLineWait = 0.4,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "ZeusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ZeusFirstPickUp" },
					},
				},
			},

			-- Hera
			{
				UsePlayerSource = true,
				Cue = "/VO/MelinoeField_0641", Text = "Her Majesty the Queen is with me now." ,
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HeraUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
			},

			-- Poseidon
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0635", Text = "May all our enemies drown.", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "PoseidonUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "PoseidonFirstPickUp" },
					},
				},
			},

			-- Aphrodite
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0643", Text = "I've much to learn from her I think...", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "AphroditeUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "AphroditeFirstPickUp" },
					},
				},
			},

			-- Demeter
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0649", Text = "Grandmother...", 
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_0649" }
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_1481" },
					},
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "DemeterUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "DemeterFirstPickUp" },
					},
				},
			},

			-- Hephaestus
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0942", Text = "My silver all grew stronger, didn't it...", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HephaestusFirstPickUp" },
					},
				},
			},

			-- Hestia
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0646", Text = "{#Emph}Whew{#Prev}, that almost burns...", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HestiaUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HestiaFirstPickUp" },
					},
				},
			},

			-- Hermes
			{
				UsePlayerSource = true,
				Cue = "/VO/Melinoe_0945", Text = "Now we make haste.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HermesUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HermesFirstPickUp" },
					},
				},
			},

			-- Ares
			{
				UsePlayerSource = true,
				Cue = "/VO/MelinoeField_2917", Text = "The will to fight...", 
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "AresUpgrade" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "AresFirstPickUp" },
					},
				},
			},

		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "ApolloUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_0210", Text = "Apollo's light." },
			{ Cue = "/VO/Melinoe_0202", Text = "The might of Olympus." },
			{ Cue = "/VO/Melinoe_1486", Text = "Can never get accustomed to this light...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "ApolloUpgrade" },
						Comparison = ">=",
						Value = 6,
					},
				},
			},
			{ Cue = "/VO/Melinoe_1487", Text = "The light of the sun..." },
			{ Cue = "/VO/Melinoe_1488", Text = "Brilliant as always, Cousin...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "ApolloUpgrade" },
						Comparison = ">=",
						Value = 8,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
			{ Cue = "/VO/Melinoe_1489", Text = "Apollo's light..." },
			{ Cue = "/VO/Melinoe_1490", Text = "So bright..." },
			{ Cue = "/VO/Melinoe_1491", Text = "Not moonlight, that's for sure..." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "ZeusUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1492", Text = "The might of the heavens..." },
			{ Cue = "/VO/Melinoe_1493", Text = "Thunderous power..." },
			{ Cue = "/VO/Melinoe_1494", Text = "Lightning from on high..." },
			{ Cue = "/VO/Melinoe_1495", Text = "No getting used to {#Emph}that..." },
			{ Cue = "/VO/Melinoe_1496", Text = "Electric..." },
			{ Cue = "/VO/Melinoe_1497", Text = "Shocking every time..." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.35,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "HeraUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1498", Text = "The sacred bond..." },
			{ Cue = "/VO/Melinoe_1499", Text = "My strength reborn..." },
			{ Cue = "/VO/Melinoe_1500", Text = "Fit for a Queen..." },
			{ Cue = "/VO/Melinoe_1501", Text = "Vested in me..." },
			{ Cue = "/VO/Melinoe_1502", Text = "By her grace." },
			{ Cue = "/VO/Melinoe_1503", Text = "Our bond renewed." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "PoseidonUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1504", Text = "Surging on." },
			{ Cue = "/VO/Melinoe_1505", Text = "Strength of the sea." },
			{ Cue = "/VO/Melinoe_1506", Text = "A wave of power..." },
			{ Cue = "/VO/Melinoe_1507", Text = "The tide's come in..." },
			{ Cue = "/VO/Melinoe_1508", Text = "The ocean's fury." },
			{ Cue = "/VO/Melinoe_1509", Text = "They'll drown..." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "AphroditeUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1510", Text = "That's a feeling there..." },
			{ Cue = "/VO/Melinoe_1511", Text = "My heart..." },
			{ Cue = "/VO/Melinoe_1512", Text = "{#Emph}Ah-haha{#Prev}, wow..." },
			{ Cue = "/VO/Melinoe_1513", Text = "This must be love..." },
			{ Cue = "/VO/Melinoe_1514", Text = "This feeling, {#Emph}augh..." },
			{ Cue = "/VO/Melinoe_1515", Text = "Beautiful." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "DemeterUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1534", Text = "Cold comfort..." },
			{ Cue = "/VO/Melinoe_1535", Text = "Cool and brisk..." },
			{ Cue = "/VO/Melinoe_1536", Text = "Icy." },
			{ Cue = "/VO/Melinoe_1537", Text = "Desolation..." },
			{ Cue = "/VO/Melinoe_1538", Text = "For my mother." },
			{ Cue = "/VO/Melinoe_1539", Text = "Life or death..." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "HestiaUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1522", Text = "Getting warmer..." },
			{ Cue = "/VO/Melinoe_1523", Text = "They'll {#Emph}burn..." },
			{ Cue = "/VO/Melinoe_1524", Text = "Flame of the hearth...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1525", Text = "Fired up..." },
			{ Cue = "/VO/Melinoe_1526", Text = "{#Emph}Whew {#Prev}that's hot..." },
			{ Cue = "/VO/Melinoe_1527", Text = "Let's get them, Great-Auntie.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HestiaGift02" }
					},
				},
			},
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "HephaestusUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1516", Text = "My silver..." },
			{ Cue = "/VO/Melinoe_1517", Text = "Such strength..." },
			{ Cue = "/VO/Melinoe_1518", Text = "The forge of the heavens..." },
			{ Cue = "/VO/Melinoe_1519", Text = "The smith-god's power..." },
			{ Cue = "/VO/Melinoe_1520", Text = "My silver's come alive..." },
			{ Cue = "/VO/Melinoe_1521", Text = "Fine work as always." },
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "HermesUpgrade" },
				},
			},

			{ Cue = "/VO/Melinoe_1528", Text = "Little spring in my step..." },
			{ Cue = "/VO/Melinoe_1529", Text = "Here we go." },
			{ Cue = "/VO/Melinoe_1530", Text = "And we're off..." },
			{ Cue = "/VO/Melinoe_1532", Text = "Time to send a message..." },
			{ Cue = "/VO/Melinoe_1533", Text = "Let's pick up the pace." },
			{ Cue = "/VO/MelinoeField_0386", Text = "Haste...!" },
			{ Cue = "/VO/MelinoeField_0385", Text = "Off I go!" },
			{ Cue = "/VO/MelinoeField_0384", Text = "Cheers, Hermes...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift04" }
					},
				},
			},
		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "AresUpgrade" },
				},
			},

			{ Cue = "/VO/MelinoeField_2921", Text = "The scent of blood." },
			{ Cue = "/VO/MelinoeField_2922", Text = "Blood and darkness..." },
			{ Cue = "/VO/MelinoeField_2923", Text = "Death to our foes." },
			{ Cue = "/VO/MelinoeField_2924", Text = "War rages." },
			{ Cue = "/VO/MelinoeField_2925", Text = "Peace can wait." },
			{ Cue = "/VO/MelinoeField_2926", Text = "For the battle to come." },
		},
		{
			-- Hades
			{
				RandomRemaining = true,
				PreLineWait = 0.71,
				-- SuccessiveChanceToPlayAll = 0.75,
				PreLineAnim = "Hades_Blessing",
				ObjectType = "NPC_Hades_Field_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				TriggerCooldowns = { "HadesSpokeRecently", "HadesCerberusPetSpeech" },

				{ Cue = "/VO/Hades_0240", Text = "Be well." },
				{ Cue = "/VO/Hades_0241", Text = "Till next we meet.", PlayFirst = true },
				{ Cue = "/VO/Hades_0242", Text = "Goodbye, Daughter." },
				{ Cue = "/VO/Hades_0244", Text = "Take care of yourself." },
				{ Cue = "/VO/Hades_0245", Text = "Take care, then." },
				{ Cue = "/VO/Hades_0246", Text = "...Thank you." },
				{ Cue = "/VO/Hades_0247", Text = "Of course." },
				{ Cue = "/VO/Hades_0248", Text = "Very well." },
				{ Cue = "/VO/Hades_0249", Text = "You have it." },
				{ Cue = "/VO/Hades_0250", Text = "Granted." },
				{ Cue = "/VO/Hades_0251", Text = "Shadows conceal you.",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 6,
							Path = { "SpeechRecord", "/VO/Hades_0251" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 8,
						},
					},
				},
				{ Cue = "/VO/Hades_0069", Text = "There." },
				{ Cue = "/VO/Hades_0066", Text = "Granted." },
				{ Cue = "/VO/Hades_0266", Text = "It is yours." },
				{ Cue = "/VO/Hades_0267", Text = "There." },
				{ Cue = "/VO/Hades_0268", Text = "Very well." },
				{ Cue = "/VO/Hades_0269", Text = "Of course." },
				{ Cue = "/VO/Hades_0270", Text = "Then go." },
				{ Cue = "/VO/Hades_0271", Text = "Go, Daughter." },
				{ Cue = "/VO/Hades_0243", Text = "Our blessings.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" }, Alive = true },
						},
					}
				},
			},
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentLootData", "Name" },
						IsAny = { "NPC_Hades_Field_01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "TextLinesRecord" },
						HasAny = { "HadesFirstMeeting", "HadesFirstMeeting_B", "HadesFirstMeeting_C" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1060", Text = "I'll be back for you." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					PreLineAnim = "Hades_Blessing",
					ObjectType = "NPC_Hades_Field_01",
					{ Cue = "/VO/Hades_0030", Text = "Don't be a fool..." },
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.81,
				-- SuccessiveChanceToPlayAll = 0.75,
				PreLineAnim = "Hades_Blessing",
				ObjectType = "NPC_Hades_Field_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				TriggerCooldowns = { "HadesSpokeRecently" },

				{ Cue = "/VO/Hades_0055", Text = "Go. I've no more strength for now." },
				{ Cue = "/VO/Hades_0056", Text = "Go. Fear not for me." },
				{ Cue = "/VO/Hades_0057", Text = "There. Now get out of here." },
				{ Cue = "/VO/Hades_0058", Text = "Now, leave me be." },
				{ Cue = "/VO/Hades_0059", Text = "It is done. Now, go." },
				{ Cue = "/VO/Hades_0060", Text = "Fine. There." },
				{ Cue = "/VO/Hades_0061", Text = "Fine. But you cannot stay." },
				{ Cue = "/VO/Hades_0062", Text = "All right..." },
				{ Cue = "/VO/Hades_0063", Text = "Very well. Now, off with you." },
				{ Cue = "/VO/Hades_0064", Text = "Indeed. May it be of use." },
				{ Cue = "/VO/Hades_0065", Text = "{#Emph}Hm. {#Prev}That I can spare." },
				{ Cue = "/VO/Hades_0069", Text = "There." },
				{ Cue = "/VO/Hades_0070", Text = "Now go." },
				{ Cue = "/VO/Hades_0071", Text = "{#Emph}Ngh...", PlayFirst = true },
				{ Cue = "/VO/Hades_0072", Text = "Go." },
				{ Cue = "/VO/Hades_0066", Text = "Granted." },
				{ Cue = "/VO/Hades_0266", Text = "It is yours." },
				{ Cue = "/VO/Hades_0267", Text = "There." },
				{ Cue = "/VO/Hades_0268", Text = "Very well." },
				{ Cue = "/VO/Hades_0269", Text = "Of course." },
				{ Cue = "/VO/Hades_0270", Text = "Then go." },
				{ Cue = "/VO/Hades_0271", Text = "Go, Daughter." },
				{ Cue = "/VO/Hades_0067", Text = "Granted. That is all.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "SpeechRecord", "/VO/Hades_0066" }
						},
					},
				},
				{ Cue = "/VO/Hades_0068", Text = "Granted. Go on, then.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "SpeechRecord", "/VO/Hades_0066" }
						},
					},
				},
				{ Cue = "/VO/Hades_0262", Text = "{#Emph}Hm.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Story01" },
							Comparison = ">=",
							Value = 15,
						},
					},
				},
				{ Cue = "/VO/Hades_0263", Text = "{#Emph}Mm.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Story01" },
							Comparison = ">=",
							Value = 15,
						},
					},
				},
				{ Cue = "/VO/Hades_0264", Text = "{#Emph}Hm!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Story01" },
							Comparison = ">=",
							Value = 15,
						},
					},
				},
				{ Cue = "/VO/Hades_0265", Text = "{#Emph}Hrm!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Story01" },
							Comparison = ">=",
							Value = 15,
						},
					},
				},
			},
			{ GlobalVoiceLines = "ThankingHadesVoiceLines" }
		},
		-- Poms
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.25,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "StackUpgrade" },
				},
			},

			{ Cue = "/VO/MelinoeField_1370", Text = "Thought these only grew below...", PlayFirst = true, PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", "O", "P" },
					},					
				},
			},
			{ Cue = "/VO/Melinoe_1287", Text = "These still grow in the Underworld...", PlayFirst = true, PlayOnce = true, PlayOnceContext = "FirstPomPickupSpeech" },
			{ Cue = "/VO/Melinoe_1985", Text = "My mother's strength..." },
			{ Cue = "/VO/Melinoe_1986", Text = "The Underworld's power..." },
			{ Cue = "/VO/Melinoe_1987", Text = "Strength of the gods..." },
			{ Cue = "/VO/Melinoe_1988", Text = "Felt that for sure." },
			{ Cue = "/VO/MelinoeField_0668", Text = "My Boon grows stronger." },
			{ Cue = "/VO/MelinoeField_0669", Text = "Feeling fine...." },
			{ Cue = "/VO/MelinoeField_0670", Text = "Never get enough of those." },
			{ Cue = "/VO/MelinoeField_0671", Text = "Always a treat." },
			{ Cue = "/VO/MelinoeField_0672", Text = "{#Emph}Mm{#Prev}, there we go." },
			{ Cue = "/VO/MelinoeField_0673", Text = "Excellent stuff." },
			{ Cue = "/VO/MelinoeField_0674", Text = "That's better..." },
			{ Cue = "/VO/MelinoeField_0675", Text = "That was good..." },
		},
		{
			UsePlayerSource = true,
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.75,
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "TrialUpgrade" },
				},
			},

			{ Cue = "/VO/MelinoeField_0778", Text = "There. Just have to live with the side effect for now.", PlayFirst = true, PlayOnce = true },
			{ Cue = "/VO/MelinoeField_0779", Text = "Almighty Chaos...",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_0779" }
					},
				}
			},
			{ Cue = "/VO/MelinoeField_0780", Text = "Something's changed in me..." },
			{ Cue = "/VO/MelinoeField_0781", Text = "Chaotic might..." },
			{ Cue = "/VO/MelinoeField_0782", Text = "Primordial strength..." },
			{ Cue = "/VO/MelinoeField_0783", Text = "Infinite possibility..." },
			{ Cue = "/VO/MelinoeField_0784", Text = "Let's see how this goes..." },
			{ Cue = "/VO/MelinoeField_0785", Text = "Should be manageable..." },
			{ Cue = "/VO/MelinoeField_0786", Text = "Worth the risk." },
			{ Cue = "/VO/MelinoeField_0787", Text = "The Fates won't mind..." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.75,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					Path = { "CurrentLootData", "Name" },
					IsAny = { "TrialUpgrade" },
				},
			},

			{ Cue = "/VO/Chaos_0079", Text = "My mark is yours." },
			{ Cue = "/VO/Chaos_0080", Text = "Thus I have left my mark." },
			{ Cue = "/VO/Chaos_0081", Text = "Then it is yours." },
			{ Cue = "/VO/Chaos_0082", Text = "An interesting choice." },
			{ Cue = "/VO/Chaos_0083", Text = "You may experience a mild discomfort..." },
			{ Cue = "/VO/Chaos_0084", Text = "I had expected you to thusly choose." },
			{ Cue = "/VO/Chaos_0085", Text = "So shall it be." },
			{ Cue = "/VO/Chaos_0086", Text = "It is decided, then." },
			{ Cue = "/VO/Chaos_0087", Text = "Your choice is made." },
			{ Cue = "/VO/Chaos_0088", Text = "This I shall be curious to see." },
			{ Cue = "/VO/Chaos_0089", Text = "This shall affect your chances to succeed." },
			{ Cue = "/VO/Chaos_0090", Text = "I see no reason to refute." },
			{ Cue = "/VO/Chaos_0091", Text = "Do as you shall." },
			{ Cue = "/VO/Chaos_0092", Text = "If that is your wish." },
			{ Cue = "/VO/Chaos_0093", Text = "A tolerable risk." },
			{ Cue = "/VO/Chaos_0094", Text = "I understand and accept." },
			{ Cue = "/VO/Chaos_0095", Text = "It is already done." },
			{ Cue = "/VO/Chaos_0096", Text = "All part of our arrangement." },
			{ Cue = "/VO/Chaos_0103", Text = "Return now whence you came." },
			{ Cue = "/VO/Chaos_0104", Text = "You now are changed accordingly." },
		},		
		-- { GlobalVoiceLines = "StorytellerFightReactionVoiceLines" },
	},
	BoonActivatedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0292", Text = "A Boon awakened." },
		{ Cue = "/VO/MelinoeField_0293", Text = "That was my Boon..." },
		{ Cue = "/VO/MelinoeField_0294", Text = "I felt something..." },
		{ Cue = "/VO/MelinoeField_0295", Text = "A sudden surge..." },
		{ Cue = "/VO/MelinoeField_0296", Text = "The force of fire...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalBaseDamageBoon", "ElementalRallyBoon" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0297", Text = "The strength of earth...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalOlympianDamageBoon", "ElementalDamageBoon", },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0298", Text = "The rush of air...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalDodgeBoon", "ElementalDamageFloorBoon", },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0299", Text = "The will of water...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalHealthBoon", "ElementalDamageCapBoon" },
				}
			},
		},
		-- { Cue = "/VO/MelinoeField_0300", Text = "The spark of aether..." },
	},
	BoonDeactivatedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		GameStateRequirements =
		{
			{
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/MelinoeField_0301", Text = "My Boon lost potency..." },
		{ Cue = "/VO/MelinoeField_0302", Text = "A Boon grew weaker there..." },
		{ Cue = "/VO/MelinoeField_0303", Text = "My elemental strength...", 
		
			GameStateRequirements =
			{
				{
					PathTrue = { "SessionState", "ElementalTraitDeactivated"},
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0304", Text = "The elements escape...",
		
			GameStateRequirements =
			{
				{
					PathTrue = { "SessionState", "ElementalTraitDeactivated"},
				}
			},
		},
	},

	GhostWallInteractionVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Intro", "H_PreBoss01" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeGhostWallSpeech", Time = 120 },
		},

		{ Cue = "/VO/MelinoeField_0860", Text = "All these Shades..." },
		{ Cue = "/VO/MelinoeField_0861", Text = "Can't get through...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0862", Text = "They've sealed me in..." },
		{ Cue = "/VO/MelinoeField_0863", Text = "What do they want?" },
		{ Cue = "/VO/MelinoeField_0864", Text = "Excuse me...!" },
		{ Cue = "/VO/MelinoeField_0865", Text = "They won't budge..." },
	},

	HermesDeliveryVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.7,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Artemis_Field_01", "NPC_Heracles_01", "NPC_Icarus_01", "NPC_Athena_01" }, Alive = false },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_1484", Text = "Lord Hermes..." },
			{ Cue = "/VO/Melinoe_1485", Text = "Special delivery..." },
			{ Cue = "/VO/Melinoe_0943", Text = "The messenger..." },
			{ Cue = "/VO/MelinoeField_1713", Text = "Delivery arrived." },
			{ Cue = "/VO/MelinoeField_1714", Text = "There's my order.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1715", Text = "Cheers, Hermes." },
			{ Cue = "/VO/MelinoeField_1716", Text = "Special delivery." },
		},
	},

	TrialUpgradeTransformedVoiceLines =
	{
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "GeneratedAnomalyB", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "IcarusCombatO", "IcarusCombatO2" },
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.7,
				Cooldowns =
				{
					{ Name = "MelinoeChaosBoonTransformSpeech", Time = 120 },
					{ Name = "ChaosSpokeRecently", Time = 6 },
				},
				TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_0949", Text = "My Boon from Chaos came alive..." },
				{ Cue = "/VO/MelinoeField_0950", Text = "My Chaos Boon just changed..." },
				{ Cue = "/VO/MelinoeField_0951", Text = "Something changed about my Chaos Boon...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0953", Text = "The Boon from Chaos just took hold..." },
				{ Cue = "/VO/MelinoeField_0954", Text = "Must have been my Chaos Boon just then." },
				{ Cue = "/VO/MelinoeField_0952", Text = "My Chaos curse subsided...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasNone = { "RandomBlessingKeepsake" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0955", Text = "Withstood that Chaos curse I had...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasNone = { "RandomBlessingKeepsake" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0956", Text = "That Chaos curse of mine is finally gone...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasNone = { "RandomBlessingKeepsake" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				ChanceToPlay = 0.33,
				PreLineWait = 0.41,
				Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
					}
				},

				{ Cue = "/VO/Chaos_0158", Text = "Now..." },
				{ Cue = "/VO/Chaos_0159", Text = "Behold..." },
				{ Cue = "/VO/Chaos_0160", Text = "Observe..." },
				{ Cue = "/VO/Chaos_0161", Text = "Here..." },
				{ Cue = "/VO/Chaos_0162", Text = "Power..." },
				{ Cue = "/VO/Chaos_0163", Text = "Evolution...", PlayFirst = true },
			}
		},
	},

	BiomeTimerAboutToExpireVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlayAll = 0.75,
			ObjectTypes = { "Chronos", "NPC_Chronos_01" },
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.2,
				},
			},
			Cooldowns =
			{
				{ Name = "ChronosSpokeRecently", Time = 4 },
			},

			{ Cue = "/VO/Chronos_0844", Text = "Your Time runs short..." },
			{ Cue = "/VO/Chronos_0845", Text = "The hour grows late!" },
			{ Cue = "/VO/Chronos_0846", Text = "Mere moments remain!" },
			{ Cue = "/VO/Chronos_0847", Text = "So little Time remains..." },
			{ Cue = "/VO/Chronos_0848", Text = "You had best hurry up..." },
			{ Cue = "/VO/Chronos_0849", Text = "{#Emph}Time {#Prev}is of the essence...!" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.75,

			GameStateRequirements =
			{
				-- None
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_1668", Text = "Time's running out...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1669", Text = "Hurry, Mel..." },
			{ Cue = "/VO/MelinoeField_1670", Text = "Not much time left..." },
			{ Cue = "/VO/MelinoeField_1671", Text = "Time's almost up..." },
			{ Cue = "/VO/MelinoeField_1672", Text = "Don't have much time..." },
			{ Cue = "/VO/MelinoeField_1673", Text = "Nearly out of time..." },
			{ Cue = "/VO/MelinoeField_2249", Text = "Got to move...!" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlayAll = 0.75,
			ObjectTypes = { "Chronos", "NPC_Chronos_01" },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.1,
				},
			},
			TriggerCooldowns = { Name = "ChronosSpokeRecently" },

			{ Cue = "/VO/Chronos_0850", Text = "{#Emph}Oh {#Prev}that it is.",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1668" },
					},
				},
			},
			{ Cue = "/VO/Chronos_0851", Text = "Please do.",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1669", "/VO/MelinoeField_2249" },
					},
				},
			},
			{ Cue = "/VO/Chronos_0852", Text = "I am right here!",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1670" },
					},
				},
			},
			{ Cue = "/VO/Chronos_0853", Text = "I am quite well thank you!",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1671" },
					},
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.4,
					},
				},
			},
			{ Cue = "/VO/Chronos_0854", Text = "No you do not.",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1672" },
					},
				},
			},
			{ Cue = "/VO/Chronos_0855", Text = "Yes, that you are.",
				GameStateRequirements = 
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/MelinoeField_1673" },
					},
				},
			},
		},
	},
	BiomeTimerExpiredVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlayAll = 0.75,
			GameStateRequirements =
			{
				-- None
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2195", Text = "Oh, no." },
			{ Cue = "/VO/MelinoeField_2196", Text = "Out of time...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2197", Text = "No time to spare...!" },
			{ Cue = "/VO/MelinoeField_2198", Text = "Time's up...!" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			ObjectTypes = { "Chronos", "NPC_Chronos_01" },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = ">=",
					Value = 0.1,
				},
			},
			TriggerCooldowns = { Name = "ChronosSpokeRecently" },

			{ Cue = "/VO/Chronos_0856", Text = "Bye now." },
			{ Cue = "/VO/Chronos_0857", Text = "And, {#Emph}Time." },
			{ Cue = "/VO/Chronos_0858", Text = "Time is up..." },
			{ Cue = "/VO/Chronos_0859", Text = "That is that." },
		},
	},

	OverlookVoiceLines =
	{
		Queue = "Always",
		-- Surface Route
		{
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "NOverlookPenaltyVO",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.55,
			SuccessiveChanceToPlayAll = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Opening01" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "SurfacePenalty" },
				},
			},

			{ Cue = "/VO/MelinoeField_0354", Text = "...Through... all... that...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0355", Text = "...It's... too... far...", PlayFirst = true },
		},
		{
			PlayOnce = true,
			PlayOnceContext = "NOverlookVO",
			PreLineWait = 1.55,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Opening01" },
				},
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},

			{ Cue = "/VO/Melinoe_1336", Text = "Have to get out of this damned city..."	},
			{ Cue = "/VO/Melinoe_1337", Text = "From the docks I can find a ship to cross the rift...", PreLineWait = 0.9,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasAny = { "/VO/Melinoe_1336" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_1338", Text = "Should be able to reach Olympus from there.", PreLineWait = 0.9, BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasAny = { "/VO/Melinoe_1337" },
					},
				}
			},
		},
		{
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "NOverlookVO",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.85,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Opening01" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/MelinoeField_0356", Text = "No way around the city... have to get through...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0357", Text = "{#Emph}...Follow the River Acheron, beyond the necropolis..." },
			{ Cue = "/VO/MelinoeField_0360", Text = "Looks almost peaceful from afar..." },
			{ Cue = "/VO/MelinoeField_0361", Text = "Can't quite see the docks from here..." },
			{ Cue = "/VO/MelinoeField_0358", Text = "What horrors lurk within Ephyra on this night...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "N_Hub" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0359", Text = "Just another night on the town...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "N_Hub" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/Melinoe_1336", Text = "Have to get out of this damned city...",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/Melinoe_1336" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
		},
		{
			PreLineWait = 1.85,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "OOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Intro" },
				},
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			{ Cue = "/VO/MelinoeField_1739", Text = "Warships risen from the depths... all headed for Olympus.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1740", Text = "Beyond this rift, the mountain of the gods..." },
			{ Cue = "/VO/MelinoeField_1741", Text = "Just a little night sea journey... what's to fear?" },
			{ Cue = "/VO/MelinoeField_1742", Text = "Too far to swim... but all those ships out there are swift..." },
			{ Cue = "/VO/MelinoeField_2059", Text = "As soon as one ship sinks, another rises from the depths..." },
			{ Cue = "/VO/MelinoeField_2060", Text = "Such a strange and awful fleet that Chronos has..." },
		},
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "P_Intro" },
				},
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			{
				PreLineWait = 3,
				PlayOnce = true,
				PlayOnceContext = "FirstOlympusOverlook",

				{ Cue = "/VO/MelinoeField_2714", Text = "Deep breath, Mel..." },
				{ Cue = "/VO/MelinoeField_2715", Text = "Made it this far and yet... the real climb is just about to start.",
					PreLineWait = 1.0,
					GameStateRequirements = 
					{
						{
							PathTrue = { "MapState", "InOverlook" },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_2714" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2716", Text = "The family may be much too proud to ask for help, but it's their time of need.",
					PreLineWait = 1.0,
					GameStateRequirements = 
					{
						{
							PathTrue = { "MapState", "InOverlook" },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_2715" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2717", Text = "Together, we can all prevail.",
					BreakIfPlayed = true,
					PreLineWait = 1.3,
					GameStateRequirements = 
					{
						{
							PathTrue = { "MapState", "InOverlook" },
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_2716" },
						},
					},
				},
			},
			{
				PreLineWait = 3.3,
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				PlayOnceContext = "POverlookVO",
				SuccessiveChanceToPlayAll = 0.66,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_Intro" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_2480", Text = "Just have to get from here to... all the way up there...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2482", Text = "No wonder mortals made their sacrifices to the gods here..." },
				{ Cue = "/VO/MelinoeField_2483", Text = "A natural stronghold... no easy way up, not during this siege." },
				{ Cue = "/VO/MelinoeField_2715", Text = "Made it this far and yet... the real climb is just about to start." },
				{ Cue = "/VO/MelinoeField_2717", Text = "Together, we can all prevail." },
				{ Cue = "/VO/MelinoeField_2716", Text = "The family may be much too proud to ask for help, but it's their time of need.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2484", Text = "You know I'm here, don't you, Prometheus...?",
					GameStateRequirements = 
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2485", Text = "Why does my family live in the most inconvenient places...",
					GameStateRequirements = 
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2481", Text = "Concern yourself with each next step... and make it to the top...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutMountains01" },
						},
					},
				},
			},
		},
		{
			PreLineWait = 2.55,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "QOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Intro" },
				},
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			{ Cue = "/VO/MelinoeField_3357", Text = "...Out there, is that...? Something's inside those clouds.... Oh, gods...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2932", Text = "...Can't see a blasted thing out there..." },
			{ Cue = "/VO/MelinoeField_2933", Text = "...The elements themselves, turning against the gods..." },
			{ Cue = "/VO/MelinoeField_2953", Text = "...Something's out there..." },
			{ Cue = "/VO/MelinoeField_2934", Text = "...Typhon brought this storm upon the gods...",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2935", Text = "...The Father of All Monsters, the Bringer of Storms...",
				PlayFirst = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2936", Text = "...You'll find I'm just as stubborn as you are, Typhon...",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2937", Text = "...You can't hide from me out there, monster...",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
			},
		},
		{
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_PostBoss01" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},
			PreLineFunctionName = "GenericPresentation",
			PreLineFunctionArgs = { PreWait = 3.55 },
			{
				BreakIfPlayed = true,
				PreLineWait = 3.5,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_5018", Text = "Hermes probably already spread the news..." },
			},
			{
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.5,

				{ Cue = "/VO/MelinoeField_3463", Text = "{#Emph}<Gasp> {#Prev}It's...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3466", Text = "...That's... the Sun...", BreakIfPlayed = true, PlayOnce = true },
			},
			{
				PreLineWait = 1.55,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.5,

				{ Cue = "/VO/MelinoeField_3465", Text = "...Daybreak...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3464", Text = "...Beautiful..." },
				{ Cue = "/VO/MelinoeField_3467", Text = "...Dawn..." },
			},
		},

		-- Underworld Route
		{
			PreLineWait = 1.55,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "GOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "G_Intro" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/MelinoeField_0135", Text = "Beyond lies Uncle Poseidon's realm..." },
			{ Cue = "/VO/MelinoeField_0136", Text = "Countless dead ends... one way through...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0137", Text = "All that metal holds the very sea at bay..." },
			{ Cue = "/VO/MelinoeField_0138", Text = "Each chamber here leads to a deeper one..." },
			{ Cue = "/VO/MelinoeField_0139", Text = "Wonder what other terrors lurk within the sea..." },
			{ Cue = "/VO/MelinoeField_0140", Text = "The peerless work of Master Daedalus..." },
			{ Cue = "/VO/MelinoeField_0141", Text = "To think this is a safer path than through Elysium...",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
		},
		{
			PreLineWait = 2.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			RecheckRequirementsPostWait = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "HOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_Intro" },
				},
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = { "NPC_Eris_01", }, Alive = false },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/MelinoeField_0842", Text = "So many mortal lives left unfulfilled..." },
			{ Cue = "/VO/MelinoeField_0843", Text = "{#Emph}Across the Fields, beyond the bridge, seek there a pathway down...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0844", Text = "Lost loves... failed dreams... regrets..." },
			{ Cue = "/VO/MelinoeField_0845", Text = "Hopelessness... failure... despair..." },
			{ Cue = "/VO/MelinoeField_0846", Text = "Don't give in... don't give in..." },
			{ Cue = "/VO/MelinoeField_0847", Text = "Come on, Mel... what are you waiting for..." },
			{ Cue = "/VO/MelinoeField_0848", Text = "This horrid feeling... just a trick of the mind..." },
			{ Cue = "/VO/MelinoeField_0849", Text = "I won't wind up like all these wretches here..." },
		},
		{
			PreLineWait = 1.55,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "IOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Intro" },
				},
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/MelinoeField_1285", Text = "The ever-shifting halls of Tartarus..." },
			{ Cue = "/VO/MelinoeField_1286", Text = "All this... machinery. For what...?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1287", Text = "Did Chronos build all this...?" },
			{ Cue = "/VO/MelinoeField_1288", Text = "This must be how the chambers rearrange..." },
			{ Cue = "/VO/MelinoeField_1289", Text = "Chronos and his wheels of change..." },
			{ Cue = "/VO/MelinoeField_1290", Text = "Such an infernal racket around here..." },
		},

		-- Hub
		{
			PlayOnce = true,
			{ Cue = "/VO/Melinoe_0865", Text = "Death to Chronos. I'll see to that. No one is more prepared.",
				PreLineWait = 3.85,
				GameStateRequirements = 
				{
					{
						PathTrue = { "MapState", "InOverlook" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			 },
			{ Cue = "/VO/Melinoe_0866", Text = "Beyond the mists of Erebus there should be a way down.",
				PreLineWait = 1.0,
				GameStateRequirements = 
				{
					{
						PathTrue = { "MapState", "InOverlook" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},
			 },
			{ Cue = "/VO/Melinoe_0867", Text = "Too risky heading through Elysium. And too risky to stay.",
				PreLineWait = 1.0,
				GameStateRequirements = 
				{
					{
						PathTrue = { "MapState", "InOverlook" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_0866" },
					},
				},
			 },
			{ Cue = "/VO/Melinoe_0868", Text = "All right. It's time.",
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "MapState", "InOverlook" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Melinoe_0867" },
					},
				},
			 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 3.85,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "PreRunOverlookVO",
			SuccessiveChanceToPlay = 0.75,
			SuccessiveChanceToAll = 0.2,
			GameStateRequirements = 
			{
				{
					PathTrue = { "MapState", "InOverlook" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" }
				},
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Melinoe_0865", "/VO/Melinoe_0866", "/VO/Melinoe_0867", "/VO/Melinoe_0868" },
				}
			},

			{ Cue = "/VO/Melinoe_0869", Text = "I'll get through all that gloom somehow.",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/Melinoe_0869" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/Melinoe_4301", Text = "Few places such as this where two realms meet...",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/Melinoe_4301" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},

			{ Cue = "/VO/Melinoe_4298", Text = "Chronos on my father's throne far below... Typhon threatening Olympus far above.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered" },
						HasAll = { "I_Boss01", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/Melinoe_4298" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/Melinoe_4299", Text = "Whichever way I choose, I can prevail... but where to focus next...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Cue = "/VO/Melinoe_4300", Text = "Each time I head toward Olympus, I defy the Fates themselves...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
			{ Cue = "/VO/Melinoe_0870", Text = "Below, the path to Tartarus. Above, the way to Olympus.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
				},
			 },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 4.0,
			GameStateRequirements =
			{
				{
					PathTrue = { "MapState", "InOverlook" },
				},
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Melinoe_0865" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" }
				},
			},

			{ Cue = "/VO/Melinoe_1321", Text = "The Moon is full...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1327", Text = "The Moon is beautiful...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1323", Text = "The Moon's waning...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 2,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1328", Text = "The Moon's at half-strength...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 3,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1324", Text = "The Moon wanes...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 4,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1322", Text = "The Moon is new...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1325", Text = "The Moon is waxing...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 6,
					},
				}
			},
			{ Cue = "/VO/Melinoe_1329", Text = "The Eye of Night...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 7,
					},
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
				}
			},
			{ Cue = "/VO/Melinoe_1326", Text = "The Moon waxes...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 8,
					},
				}
			},
		},		
	},

	OverlookLeaveVoiceLines =
	{
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 3.0,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_PostBoss01" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceFirstMeeting" },
				},
			},

			{ Cue = "/VO/MelinoeField_5227", Text = "Does Chronos truly wish for such a place to be destroyed...?",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastFirstMeeting" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_5228", Text = "I did tell Zagreus preparing Gigaros may take a little while..." ,
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"ZeusPalaceMeeting03",
							"ZeusPalaceMeeting03_A",
							"ZeusPalaceMeeting03_B",
						},
					},
				},
			},
			{ Cue = "/VO/MelinoeField_5229", Text = "First we settle things here, then Chronos last...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_5230", Text = "Zagreus... if only you could see this for yourself...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"ZeusPalaceMeeting04",
							"ZeusPalaceMeeting04_B",
						},
					},
				},
			},
		},

	},

	UsedFamilyPortraitVoiceLines =
	{
		-- @ ending
		{
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.9,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "PlayedTrueEnding" }
				},
			},
			Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },

			{ Cue = "/VO/Storyteller_0450", Text = "{#Emph}Thus was Hades, feared ruler of the dead, restored to his rightful throne alongside splendorous Persephone the Queen.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0451", Text = "{#Emph}The attacks upon Olympus finally ceased, and ever since, the gods governed our world with newfound care.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0452", Text = "{#Emph}As for the Princess of the Dead, Melinoë, she stayed in steady touch with all her family from the dark comfort of the shadows that had long since been her home.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0453", Text = "{#Emph}And she and the Silver Sisters kept their secret vigil over all the realms forevermore.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			-- goes to HubPostCreditsStartPresentation
		},
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			SuccessiveChanceToPlayAll = 0.1,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "FamilyPortraitVO",
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
			SuppressLyrics = true,

			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},

			{ Cue = "/VO/Melinoe_2932", Text = "This old unfinished painting... don't look away. Don't forget all that the Titan took from you.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3989", Text = "You'll find them. And you'll have so much to talk about. Let the longing for them spur you on for now.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3988", Text = "Are you growing more motivated to find your family? Or merely growing more despondent...?",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2936", Text = "They were all so happy together, weren't they? And oblivious to the Titan's threat...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5190", Text = "Chronos threatened that you'd never see your family again, the wretch. But you have, and shall.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2935", Text = "One of these nights you ought to ask Headmistress how she got this from the House.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutFamilyPortrait01" }
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2938", Text = "Father... he was so happy then, but now...? Don't let the Titan break his spirit...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2939", Text = "Brother... you don't remember him at all, and yet... you miss him. Somehow you do.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"ZeusAboutZagreus01",
							"PoseidonAboutZagreus01",
							"DemeterAboutZagreus01",
							"HephaestusAboutZagreus01",
							"AphroditeAboutZagreus01",
							"HermesAboutZagreus01",
							"ChaosAboutZagreus01",
							"SkellyAboutZagreus01",
							"ZagreusPastFirstMeeting",
						},
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2940", Text = "Mother... you have her hair, at least. She seems so different from Headmistress, doesn't she...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"AphroditeAboutPersephone01",
							"HermesAboutPersephone01",
							"SeleneAboutPersephone01",
							"HecateAboutFamily01"
						},
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2943", Text = "You don't remember them, besides this painting and your dreams. But still you fight for them...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 4,
					},
				},
			},
			{ Cue = "/VO/Melinoe_5779", Text = "Chronos... is this what he wants? His family back? Odd way of showing it.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutFamily03" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5780", Text = "The power to destroy a member of your family... it can't be the only way.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutFamily05" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2934", Text = "This memory of all you lost... it stokes your want for vengeance even now.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_2937", Text = "The Titan has your family in his thrall, or worse... what has he done with them?" },
			{ Cue = "/VO/Melinoe_2933", Text = "Father... Mother... Brother... please be safe. Please..." },
			{ Cue = "/VO/Melinoe_2941", Text = "{#Emph}All that you lost is all that you are{#Prev}, as Headmistress would say..." },
			{ Cue = "/VO/Melinoe_2942", Text = "This family... lost to you since you were born. They deserve their vengeance, and so do you.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" }
					},
				},
			},
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "FamilyPortrait",
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},

			{ Cue = "/VO/Melinoe_2944", Text = "{#Emph}<Sigh>" },
			{ Cue = "/VO/Melinoe_2945", Text = "{#Emph}<Sigh>" },
			{ Cue = "/VO/Melinoe_1607", Text = "Vengeance for my family.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_0347", Text = "Vengeance for my father.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesAboutUltimateProgress01", "ZagreusPastMeeting05" },
					},
				},
			},
			-- { Cue = "/VO/Melinoe_0121", Text = "Hold on, everyone." },
		},
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			SuccessiveChanceToPlayAll = 0.1,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "FamilyPortraitVO",
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
			SuppressLyrics = true,

			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "TrueEndingFinaleResponse01" },
				},
			},

			{ Cue = "/VO/Melinoe_5715", Text = "Mother and Father... we'll see each other again soon.",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5714", Text = "How happy we all seem... and in that moment in time, we truly were...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_5717", Text = "Good evening, everyone... be well all right?",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_5719", Text = "May the Underworld renovations go smoothly..." },
			{ Cue = "/VO/Melinoe_5179", Text = "Your family... you may not be living under the same roof, though you're together still." },
			{ Cue = "/VO/Melinoe_5180", Text = "The memory of your reunion, committed to canvas in such a beautiful way..." },
			{ Cue = "/VO/Melinoe_5181", Text = "Don't know how they managed to get Cerberus to sit still long enough for this..." },
			{ Cue = "/VO/Melinoe_5182", Text = "You won't forget them, {#Emph}ever... {#Prev}and with {#Emph}this{#Prev}, perhaps Dora won't forget them either." },
			{ Cue = "/VO/Melinoe_5185", Text = "The House of Hades was so luxurious... nice to have your own space though." },
			{ Cue = "/VO/Melinoe_5187", Text = "The old painting's safely tucked away. That memory isn't going anywhere." },
			{ Cue = "/VO/Melinoe_5184", Text = "Such a beautiful dress they fashioned for me... though not as soft as Arachne's silk.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift04" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5189", Text = "You'll see them again soon. Perhaps tonight.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "I_Story01", "C_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5186", Text = "Brother... he's so different, yet... it's like part of you was missing till you met.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "C_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5188", Text = "Mother... Father... Brother... Cerberus... you.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/Melinoe_5179", "/VO/Melinoe_5180", "/VO/Melinoe_5181", "/VO/Melinoe_5182", "/VO/Melinoe_5184", "/VO/Melinoe_5185", "/VO/Melinoe_5186", "/VO/Melinoe_5187" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5716", Text = "We've all the time in the world...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/Melinoe_5179", "/VO/Melinoe_5180", "/VO/Melinoe_5181", "/VO/Melinoe_5182", "/VO/Melinoe_5184", "/VO/Melinoe_5185", "/VO/Melinoe_5186", "/VO/Melinoe_5187" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5718", Text = "Take care, all of you... till next we meet.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpeechRecord" },
						HasAll = { "/VO/Melinoe_5179", "/VO/Melinoe_5180", "/VO/Melinoe_5181", "/VO/Melinoe_5182", "/VO/Melinoe_5184", "/VO/Melinoe_5185", "/VO/Melinoe_5186", "/VO/Melinoe_5187" },
					},
				},
			},
		},
	},
	CoveredFamilyPortraitVoiceLines =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "UseRecord", "CrossroadsFamilyPortrait02" },
			},
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlayAll = 0.1,

			{ Cue = "/VO/Melinoe_3990", Text = "See you all again in a few nights...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3991", Text = "See you later." },
			{ Cue = "/VO/Melinoe_3992", Text = "See you all." },
		},
	},

	StoryResetStartVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.35,

			{ Cue = "/VO/Melinoe_5754", Text = "{#Emph}I shall return!" },
		},
	},
	StoryResetEndVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PreLineWait = 0.8,

			{ Cue = "/VO/Melinoe_5755", Text = "{#Emph}Ungh... {#Prev}head hurts... {#Emph}Death to Chronos." },
		},
	},

	TavernaVictoryVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.75,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 2,
			},
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech", "AnyGreetingSpeech" },

		{ Cue = "/VO/Melinoe_5696", Text = "Don't mind me, everyone." },
		{ Cue = "/VO/Melinoe_5697", Text = "You all enjoy yourselves!" },
		{ Cue = "/VO/Melinoe_5698", Text = "Another victory for the Unseen!" },
		{ Cue = "/VO/Melinoe_5699", Text = "The night is ours, Shades!" },
		{ Cue = "/VO/Melinoe_5700", Text = "Another victory!" },
		{ Cue = "/VO/Melinoe_5701", Text = "This night is ours!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_5702", Text = "I salute you, Shades!" },
		{ Cue = "/VO/Melinoe_5703", Text = "Good evening, Shades!" },
	},

	SurfaceShopUsedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeShopUsedSpeech", Time = 90 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.45,
			-- SkipAnim = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "N_PostBoss01", "O_PostBoss01", "P_PostBoss01" },
				},
				{
					Path = { "GameState", "Resources", "Money" },
					Comparison = ">",
					Value = 30,
				},
			},

			{ Cue = "/VO/Melinoe_1356", Text = "Hermes must be in the area.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1357", Text = "What's Hermes offering this eve?" },
			{ Cue = "/VO/Melinoe_1358", Text = "What's for delivery?" },
			{ Cue = "/VO/Melinoe_1359", Text = "What's good here..." },
		},
	},
	WellShopUsedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeShopUsedSpeech", Time = 90 },
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_PostBoss01", "G_PostBoss01", "H_PostBoss01" },
			},
			{
				Path = { "GameState", "Resources", "Money" },
				Comparison = ">",
				Value = 30,
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.66,
			PreLineWait = 0.65,

			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "StoreOptionsDictionary" },
					HasAny = { "LastStandShopItem" },
				},
				{
					Path = { "CurrentRun", "Hero", "LastStandsUsed" },
					Comparison = ">=",
					Value = 1,
				},
			},
			{ Cue = "/VO/MelinoeField_1447", Text = "Ah-{#Emph}hah...!" },
			{ Cue = "/VO/MelinoeField_1448", Text = "Look what we have here.", PlayFirst = true },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.65,
			-- SkipAnim = true,

			{ Cue = "/VO/MelinoeField_1441", Text = "What's in the Well this time...?" },
			{ Cue = "/VO/MelinoeField_1442", Text = "What do we have in here...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1443", Text = "Something I need...?" },
			{ Cue = "/VO/MelinoeField_1444", Text = "Let's see here..." },
			{ Cue = "/VO/MelinoeField_1446", Text = "Some of Lord Charon's wares..." },
			{ Cue = "/VO/MelinoeField_1445", Text = "I do have Gold to spare...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "Money" },
						Comparison = ">",
						Value = 200,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1449", Text = "Don't have much Gold...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "Money" },
						Comparison = "<",
						Value = 60,
					},
					{
						Path = { "GameState", "Resources", "Money" },
						Comparison = ">",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1450", Text = "Can't pay for much right now...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "Money" },
						Comparison = "<",
						Value = 60,
					},
					{
						Path = { "GameState", "Resources", "Money" },
						Comparison = ">",
						Value = 0,
					},
				}
			},

		},
	},
	WellShopSoldOutVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SkipAnim = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyShopSoldOutSpeech", Time = 60 },
		},

		{ Cue = "/VO/MelinoeField_1458", Text = "Bought it all." },
		{ Cue = "/VO/MelinoeField_1459", Text = "No more for now." },
		{ Cue = "/VO/MelinoeField_1460", Text = "Depleted." },
		{ Cue = "/VO/MelinoeField_1461", Text = "Nothing more here." },
	},

	SellTraitShopUsedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
			{ Name = "MelinoeShopUsedSpeech", Time = 90 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.65,
			SkipCooldownCheckIfNonePlayed = true,
			-- SkipAnim = true,

			{ Cue = "/VO/MelinoeField_2607", Text = "A Pool of Purging..." },
			{ Cue = "/VO/MelinoeField_2608", Text = "Could wash away my Boons...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2609", Text = "There's Gold in this Pool..." },
			{ Cue = "/VO/MelinoeField_2610", Text = "Should I do this...?" },
			{ Cue = "/VO/MelinoeField_1442", Text = "What do we have in here..." },
			{ Cue = "/VO/MelinoeField_1444", Text = "Let's see here..." },
			{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
			{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
			{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
		},
	},
	SellTraitShopSoldOutVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SkipAnim = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyShopSoldOutSpeech", Time = 60 },
		},

		{ Cue = "/VO/MelinoeField_1459", Text = "No more for now." },
		{ Cue = "/VO/MelinoeField_1460", Text = "Depleted." },
		{ Cue = "/VO/MelinoeField_1461", Text = "Nothing more here." },
	},
	SoldTraitVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
				{ Name = "MelinoeSoldTraitSpeech", Time = 240 },
			},

			{ Cue = "/VO/MelinoeField_2611", Text = "I can make do." },
			{ Cue = "/VO/MelinoeField_2612", Text = "As Father would have wanted...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2613", Text = "The old traditions..." },
			{ Cue = "/VO/MelinoeField_2614", Text = "It's done..." },
			{ Cue = "/VO/Melinoe_1216", Text = "I need this." },
			{ Cue = "/VO/Melinoe_1222", Text = "Valuable enough." },
			{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		},
	},

	ChamberMoverUsedVoiceLines =
	{
		GameStateRequirements =
		{
			-- None
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/MelinoeField_1319", "/VO/MelinoeField_1321", "/VO/MelinoeField_1322", "/VO/MelinoeField_1323", "/VO/MelinoeField_1275" },
				},
			},

			{ Cue = "/VO/MelinoeField_4588", Text = "{#Emph}Ever-shifting chambers, realign." },
			{ Cue = "/VO/MelinoeField_4589", Text = "{#Emph}Ever-shifting chambers, realign!" },
			{ Cue = "/VO/MelinoeField_4590", Text = "{#Emph}Ever-shifting chambers, realign..." },
			{ Cue = "/VO/MelinoeField_1321", Text = "Just a few chambers to the House...",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/MelinoeField_1321" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1322", Text = "Should be a clear path to the House.",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/MelinoeField_1322" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/MelinoeField_1323", Text = "They'll know I'm here...",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/MelinoeField_1323" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
			},
		},
		{
			PlayOnce = true,
			PlayOnceContext = "ChamberMoverIntroLines",
			RandomRemaining = true,
			PreLineWait = 0.35,

			{ Cue = "/VO/MelinoeField_1319", Text = "Central Control... just need a moment.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1321", Text = "Just a few chambers to the House..." },
			{ Cue = "/VO/MelinoeField_1322", Text = "Should be a clear path to the House." },
			{ Cue = "/VO/MelinoeField_1323", Text = "They'll know I'm here..." },
			{ Cue = "/VO/MelinoeField_1275", Text = "It worked...", PreLineWait = 4.8 },
		},
		{
			BreakIfPlayed = true,
			-- RandomRemaining = true,
			PreLineWait = 1.5,
			PlayOnce = true,
			PlayOnceContext = "ChamberMoverIntroVO",

			{ Cue = "/VO/MelinoeField_1320", Text = "There." },
		},
	},

	-- Fishing
	FishingInitiatedVoiceLines =
	{
		{
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,
			SuccessiveChanceToPlay = 0.2,
			SuccessiveChanceToPlayAll = 0.5,
			StatusAnimation = "StatusIconStorytellerSpeaking",
			StatusAnimSourceIsHero = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "UseRecord", "InspectPoint" },
					Comparison = ">=",
					Value = 40,
				},
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Units = GameData.AllRunNPCs, Alive = false },
				},
				NamedRequirements = { "NoRecentInspectPointUsed" },
			},
			Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
			TriggerCooldowns = { "HomerSpokeRecently" },

			{ Cue = "/VO/Storyteller_0384", Text = "{#Emph}The trap is set as steadily the Princess waits..." },
			{ Cue = "/VO/Storyteller_0385", Text = "{#Emph}That which is lurking soon is to be caught..." },
			{ Cue = "/VO/Storyteller_0386", Text = "{#Emph}Which water-dwelling denizen is she to find...?" },
			{ Cue = "/VO/Storyteller_0387", Text = "{#Emph}Her eye detects a surface ripple there..." },
			{ Cue = "/VO/Storyteller_0388", Text = "{#Emph}Within those waters teems the strangest life..." },
			{ Cue = "/VO/Storyteller_0389", Text = "{#Emph}She stops to cast that dreaded lure again..." },
			{ Cue = "/VO/Storyteller_0390", Text = "{#Emph}What hides in waters soon is to be found..." },
			{ Cue = "/VO/Storyteller_0391", Text = "{#Emph}Something yet stirs within that murky deep..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelStartedFishingSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_0753", Text = "Can't hide from me..." },
			{ Cue = "/VO/Melinoe_0754", Text = "Here, little fish..." },
			{ Cue = "/VO/Melinoe_0755", Text = "All right, fish..." },
			{ Cue = "/VO/Melinoe_0756", Text = "Let's fish?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1342", Text = "Prepare, fishie..." },
			{ Cue = "/VO/MelinoeField_1343", Text = "Here, fishie..." },
			{ Cue = "/VO/MelinoeField_1344", Text = "The trap is set..." },
			{ Cue = "/VO/MelinoeField_1345", Text = "The hunt begins..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Medea_01",

			{ Cue = "/VO/Medea_0315", Text = "What lurks within...?" },
			{ Cue = "/VO/Medea_0316", Text = "Lure it out of there..." },
			{ Cue = "/VO/Medea_0317", Text = "I believe in you..." },
			{ Cue = "/VO/Medea_0318", Text = "Great Hecate guide you..." },
			{ Cue = "/VO/Medea_0319", Text = "You can see in there?" },
			{ Cue = "/VO/Medea_0320", Text = "Something stirs..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Circe_01",

			{ Cue = "/VO/Circe_0184", Text = "The waters teem with life!", PlayFirst = true },
			{ Cue = "/VO/Circe_0185", Text = "I believe in you!" },
			{ Cue = "/VO/Circe_0186", Text = "Spotted a Shrimp, perchance?" },
			{ Cue = "/VO/Circe_0187", Text = "Steady, little miss!" },
			{ Cue = "/VO/Circe_0188", Text = "Oh I shall hush up!" },
			{ Cue = "/VO/Circe_0189", Text = "What do you see...?" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Heracles_01",

			{ Cue = "/VO/Heracles_0597", Text = "Sure, why not." },
			{ Cue = "/VO/Heracles_0598", Text = "The hunt continues." },
			{ Cue = "/VO/Heracles_0599", Text = "After all that?", PlayFirst = true },
			{ Cue = "/VO/Heracles_0600", Text = "Why now...?" },
			{ Cue = "/VO/Heracles_0601", Text = "...Absurd." },
			{ Cue = "/VO/Heracles_0602", Text = "...Shameless." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			-- PreLineAnim = "Artemis_Blessing",
			ObjectType = "NPC_Athena_01",

			{ Cue = "/VO/Athena_0142", Text = "I'll wait..." },
			{ Cue = "/VO/Athena_0143", Text = "Truly...?" },
			{ Cue = "/VO/Athena_0144", Text = "Whenever you're ready." },
			{ Cue = "/VO/Athena_0145", Text = "Can this not wait?", PlayFirst = true },
			{ Cue = "/VO/Athena_0146", Text = "Certainly, why not?" },
			{ Cue = "/VO/Athena_0147", Text = "We're at war, Cousin." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Dionysus_01",
			PreLineAnim = "Dionysus_Surprise",

			{ Cue = "/VO/Dionysus_0195", Text = "{#Emph}Whoa {#Prev}that's our pool!", PlayFirst = true, PlayOnce = true, PreLineAnim = "Dionysus_Eager", PreLineWait = 0.35 },
			{ Cue = "/VO/Dionysus_0196", Text = "Just watch it with the hooks yeah?" },
			{ Cue = "/VO/Dionysus_0197", Text = "Everybody just give her a moment!" },
			{ Cue = "/VO/Dionysus_0198", Text = "Now this I got to see...", PreLineAnim = "Dionysus_Eager" },
			{ Cue = "/VO/Dionysus_0199", Text = "You catch it you keep it baby!", PreLineAnim = "Dionysus_Eager" },
			{ Cue = "/VO/Dionysus_0200", Text = "All right let's see your stuff!", PreLineAnim = "Dionysus_Eager" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Artemis_Field_01",

			{ Cue = "/VO/Artemis_0326", Text = "Sure, go for it!" },
			{ Cue = "/VO/Artemis_0327", Text = "The hunt is on...", PlayFirst = true },
			{ Cue = "/VO/Artemis_0328", Text = "I can wait!" },
			{ Cue = "/VO/Artemis_0329", Text = "Something in the water..." },
			{ Cue = "/VO/Artemis_0330", Text = "Let's see it, then." },
			{ Cue = "/VO/Artemis_0331", Text = "Catch away." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Icarus_01",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Icarus_0210", Text = "Go get 'em." },
			{ Cue = "/VO/Icarus_0211", Text = "I {#Emph}believe..." },
			{ Cue = "/VO/Icarus_0212", Text = "Here we go." },
			{ Cue = "/VO/Icarus_0213", Text = "Spot one there?" },
			{ Cue = "/VO/Icarus_0214", Text = "Do it, Meli." },
			{ Cue = "/VO/Icarus_0514", Text = "Spot something in there?" },
			{ Cue = "/VO/Icarus_0515", Text = "A bit of fishing hey?" },
			{ Cue = "/VO/Icarus_0550", Text = "{#Emph}Oh{#Prev}, this I have to see." },
			{ Cue = "/VO/Icarus_0551", Text = "What's that there?" },
			{ Cue = "/VO/Icarus_0552", Text = "{#Emph}Some {#Prev}sort of fish..." },
			{ Cue = "/VO/Icarus_0553", Text = "You have this." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.55,
			Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "UseRecord", "PoseidonUpgrade" }
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutFishing04" }
				},
			},

			{ Cue = "/VO/Poseidon_0323", Text = "I shall permit it!" },
			{ Cue = "/VO/Poseidon_0324", Text = "I encourage it!" },
			{ Cue = "/VO/Poseidon_0325", Text = "Now we're {#Emph}talking!" },
			{ Cue = "/VO/Poseidon_0326", Text = "No pressure!", PlayFirst = true },
			{ Cue = "/VO/Poseidon_0327", Text = "Steady, Niece!" },
			{ Cue = "/VO/Poseidon_0328", Text = "Quietly, Niece...!" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.66,
			ObjectType = "NPC_Charon_01",
			PreLineAnim = "Charon_Fierce",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Charon_0122", Text = "{#Emph}Ohhhh..." },
			{ Cue = "/VO/Charon_0123", Text = "{#Emph}Mmmm..." },
			{ Cue = "/VO/Charon_0124", Text = "{#Emph}Haaah..." },
			{ Cue = "/VO/Charon_0125", Text = "{#Emph}Ehhh..." },
		},
	},
	FishingInProgressVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Hecate_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "HecateFishing01", "HecateFishing02" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Hecate_0382", Text = "{#Emph}Hrm..." },
			{ Cue = "/VO/Hecate_0383", Text = "Be still...", PlayFirst = true },
			{ Cue = "/VO/Hecate_0384", Text = "Steady now..." },
			{ Cue = "/VO/Hecate_0385", Text = "They stir below..." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Dora_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "DoraFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Dora_0087", Text = "Anything yet?" },
			{ Cue = "/VO/Dora_0088", Text = "Hey is that...?" },
			{ Cue = "/VO/Dora_0089", Text = "Anytime now...", PlayFirst = true },
			{ Cue = "/VO/Dora_0090", Text = "So this is it huh." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Odysseus_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "OdysseusFishing01", "OdysseusFishing02" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Odysseus_0072", Text = "Where are they...", PlayFirst = true },
			{ Cue = "/VO/Odysseus_0073", Text = "Wait for it..." },
			{ Cue = "/VO/Odysseus_0074", Text = "Is that...?" },
			{ Cue = "/VO/Odysseus_0075", Text = "Steady now..." },
			{ Cue = "/VO/Odysseus_0762", Text = "Hold..." },
			{ Cue = "/VO/Odysseus_0763", Text = "Patient, aren't they...?" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Nemesis_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "NemesisFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Nemesis_0178", Text = "Hold..." },
			{ Cue = "/VO/Nemesis_0179", Text = "See one down there...?", PlayFirst = true },
			{ Cue = "/VO/Nemesis_0181", Text = "Eyes open..." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Moros_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "MorosFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Moros_0348", Text = "I sense something..." },
			{ Cue = "/VO/Moros_0349", Text = "So peaceful here..." },
			{ Cue = "/VO/Moros_0350", Text = "Here it comes..." },
			{ Cue = "/VO/Moros_0351", Text = "Steady, Princess...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Eris_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "ErisFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Eris_0224", Text = "Any action yet?" },
			{ Cue = "/VO/Eris_0225", Text = "{#Emph}There! {#Prev}Wait...", PlayFirst = true },
			{ Cue = "/VO/Eris_0226", Text = "Come on, come {#Emph}on..." },
			{ Cue = "/VO/Eris_0227", Text = "{#Emph}Anytime..." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			ObjectType = "NPC_Icarus_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "IcarusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Icarus_0215", Text = "Was {#Emph}that {#Prev}something...?" },
			{ Cue = "/VO/Icarus_0216", Text = "Too murky to see...", PlayFirst = true },
			{ Cue = "/VO/Icarus_0217", Text = "Not seeing anything..." },
			{ Cue = "/VO/Icarus_0218", Text = "Holding still..." },
		},

		--[[
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.85,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelStartedFishingSpeech", Time = 5 },
			},

			{ Cue = "/VO/MelinoeField_1344", Text = "The trap is set..." },
			{ Cue = "/VO/MelinoeField_1343", Text = "Here, fishie..." },
		},
		]]--
	},
	FishNotCaughtVoiceLines =
	{
		{
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 0.73,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Melinoe_0761", Text = "{#Emph}Ungh..." },
			{ Cue = "/VO/Melinoe_0762", Text = "Blast..." },
			{ Cue = "/VO/Melinoe_0763", Text = "Got away..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.4,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Melinoe_0761", Text = "{#Emph}Ungh..." },
			{ Cue = "/VO/Melinoe_0762", Text = "Blast..." },
			{ Cue = "/VO/Melinoe_0763", Text = "Got away..." },
		},
		{ GlobalVoiceLines = "FishNotCaughtReactionLines" },
	},
	FishNotCaughtTooLateVoiceLines =
	{
		{
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 1.43,
			Cooldowns =
			{
			},

			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1357", Text = "Come back...!" },
			{ Cue = "/VO/MelinoeField_1358", Text = "Wait...!" },
		},
		{
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 1.43,
			Cooldowns =
			{
			},

			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1357", Text = "Come back...!" },
			{ Cue = "/VO/MelinoeField_1358", Text = "Wait...!" },
		},
		{ GlobalVoiceLines = "FishNotCaughtReactionLines" },
	},
	FishNotCaughtWayTooLateVoiceLines =
	{
		{
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 1.43,
			Cooldowns =
			{
			},

			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1357", Text = "Come back...!" },
			{ Cue = "/VO/MelinoeField_1358", Text = "Wait...!" },
		},
		{
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 1.43,
			Cooldowns =
			{
			},

			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1357", Text = "Come back...!" },
			{ Cue = "/VO/MelinoeField_1358", Text = "Wait...!" },
		},
		{ GlobalVoiceLines = "FishNotCaughtReactionLines" },
	},

	UsedAquariumVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.56,
		Cooldowns =
		{
			{ Name = "MelUsedAquariumVoiceLines", Time = 10 },
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_5340", Text = "How fare you, fishies?" },
		{ Cue = "/VO/Melinoe_5341", Text = "Much roomier than it looks..." },
		{ Cue = "/VO/Melinoe_5342", Text = "You're all getting along..." },
		{ Cue = "/VO/Melinoe_5343", Text = "Looks oddly comfortable in there..." },
		{ Cue = "/VO/Melinoe_5346", Text = "So many of you..." },
		{ Cue = "/VO/Melinoe_5347", Text = "You're welcome here and safe, fishies." },
		{ Cue = "/VO/Melinoe_5348", Text = "A window to Uncle Poseidon's realm..." },
		{ Cue = "/VO/Melinoe_5349", Text = "How's everyone this eve?" },
		{ Cue = "/VO/Melinoe_5345", Text = "From the Broker straight to here.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesSpent" },
					HasAny = {
						"FishFCommon",
						"FishFRare",
						"FishFLegendary",
						"FishGCommon",
						"FishGRare",
						"FishFLegendary",
						"FishNCommon",
						"FishNRare",
						"FishNLegendary",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5344", Text = "Now if only I could catch Scylla...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "EnemyKills", "Scylla" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutBallad01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5350", Text = "Look at the little Moper...",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishFCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5351", Text = "There's a Figment!",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishFRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5352", Text = "Soulbelly lying in wait...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishFLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5353", Text = "Chiton back there...",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishGCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5354", Text = "Gutterpop swimming around.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishGRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5355", Text = "I see that Stalkfin back there...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishGLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5356", Text = "That Soby doesn't look so sad.",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishHCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5357", Text = "Seems happy for an Anguish.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishHRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5358", Text = "Not the saddest Tearjerker.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishHLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5359", Text = "Was that a Jiffy?",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishICommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5360", Text = "What a fine Goldfish.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishIRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5361", Text = "{#Emph}Ooh {#Prev}look at that Styxeon...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishILegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5362", Text = "Good home for a Ribeye.",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishNCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5363", Text = "Hey that's a Zeel...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishNRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5364", Text = "Mean-looking Neckbiter...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishNLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5365", Text = "Plenty of room for a Shrimp.",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishOCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5366", Text = "That's a Chrab scuttling around...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishORare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5367", Text = "Squids are so strange...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishOLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5368", Text = "A Pillartop making its home.",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishPCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5369", Text = "A Chrestle in its shell.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishPRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5370", Text = "Starsailor looking graceful there.",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishPLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5371", Text = "That Lamprey looks stuck...",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishQCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5372", Text = "That Stormgullet keeps staring...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishQRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5373", Text = "Chimaerids can be friendly, huh?",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishQLegendary" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5374", Text = "A Mati from the depths of Chaos...",
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishChaosCommon" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5375", Text = "Projelly just floating about...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishChaosRare" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5376", Text = "Look at that Voidskate go...",
			PlayFirst = true,
			SuccessiveChanceToPlay = 0.02,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "LifetimeResourcesGained", "FishChaosLegendary" },
				},
			},
		},

	},

	DieHardShadeRecruitVoiceLines =
	{
		PreLineWait = 0.65,
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_1629", Text = "See you in the Crossroads." },
	},

	ShadeEavesdropVoiceLines =
	{
		UsePlayerSource = true,
		{
			PreLineWait = 0.3,
			PlayOnce = true,
			PlayOnceContext = "DieHardFanShadeIntroVO",
			-- RandomRemaining = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsNone = { "Hub_PreRun" },
				},
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "DieHardFanShade" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeSaluteSpeech", Time = 4 },
			},

			{ Cue = "/VO/MelinoeField_3041", Text = "You there... you're from Elysium..." },
			{ Cue = "/VO/MelinoeField_3042", Text = "I'll leave you to it, then.", BreakIfPlayed = true, PreLineWait = 2.0 },
		},
		{
			PlayOnce = true,
			PlayOnceContext = "DieHardFanShadeRecruitVO",
			PreLineWait = 0.4,
			-- RandomRemaining = true,
			BreakIfPlayed = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsNone = { "Hub_PreRun" },
				},
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "DieHardFanShade" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeSaluteSpeech", Time = 4 },
			},

			{ Cue = "/VO/Melinoe_4351", Text = "No more despair, good Shade." },
			{ Cue = "/VO/Melinoe_4352", Text = "Hello again, good Shade." },
			{ Cue = "/VO/MelinoeField_3045", Text = "You're always here, good Shade." },
			{ Cue = "/VO/MelinoeField_3047", Text = "Something about my brother..." },
			{ Cue = "/VO/MelinoeField_3048", Text = "My brother's biggest fan...?" },
		},
		{
			PreLineWait = 0.3,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PlayOnceThisRun = true,
			-- RandomRemaining = true,
			-- SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements = 
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "DieHardFanShade" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeSaluteSpeech", Time = 4 },
			},

			{ Cue = "/VO/Melinoe_4011", Text = "Good Shade, you made it here!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_4352", Text = "Hello again, good Shade." },
			{ Cue = "/VO/Melinoe_2321", Text = "Hold fast to hope, good Shade." },
			{ Cue = "/VO/Melinoe_2322", Text = "Moonlight guide you, good Shade." },
			{ Cue = "/VO/Melinoe_2323", Text = "Listen well to the Commander, all right?" },
			{ Cue = "/VO/Melinoe_4351", Text = "No more despair, good Shade.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2324", Text = "We shall prevail; I swear it.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5519", Text = "Thank you for having faith in him and me.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5520", Text = "For always believing in us.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5521", Text = "He's safe and sound.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5522", Text = "You'll never guess whom I ran into in Elysium...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "C_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2320", Text = "Have faith in him for me.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_4011" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2319", Text = "We're going to find him. I swear it.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_4011" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.45,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun", }
				},
				{
					PathTrue = { "CurrentRun", "ExorcismSuccesses" },
				},
				--[[
				{
					Path = { "CurrentRun", "ExorcisedNames", },
					HasAny =
					{
						"ShadeErebusIdle",
						"ShadeEphyraIdle",
						"ShadeOceanusSIdle",
						"ShadeFieldsGreyIdle",
						"ShadeClockworkIdle",
						"ShadeShipsOneIdle",
						"ShadeTyphonIdle",
					},
				},
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "GhostRecruit" },
				},
				]]--
			},
			Cooldowns =
			{
				{ Name = "MelinoeShadeInteractVoiceLines", Time = 4 },
			},
			PreLineThreadedFunctionName = "PlayEmoteSimple",
			PreLineThreadedFunctionArgs =
			{
				UseOriginalSource = true,
				Delay = 2.1,
				AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed", "StatusIconDetermined" },
			},

			{ Cue = "/VO/Melinoe_1713", Text = "I see you found your way from Erebus.",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeErebusIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_1714", Text = "You found us after all." },
			{ Cue = "/VO/Melinoe_1715", Text = "I'm pleased to see you made it here.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1716", Text = "Welcome to your new abode." },
			{ Cue = "/VO/Melinoe_2433", Text = "I see you found your way." },
			{ Cue = "/VO/Melinoe_2434", Text = "I knew you'd make it here." },
			{ Cue = "/VO/Melinoe_2435", Text = "Welcome to your new home." },
			{ Cue = "/VO/Melinoe_2436", Text = "Hey I remember you...!" },
			{ Cue = "/VO/Melinoe_2437", Text = "You made it safe and sound." },
			{ Cue = "/VO/Melinoe_2438", Text = "Please make yourself at home." },
			{ Cue = "/VO/Melinoe_4268", Text = "We meet again, and welcome." },
			{ Cue = "/VO/Melinoe_4269", Text = "Welcome, everyone, to the Unseen." },
			{ Cue = "/VO/Melinoe_4270", Text = "Greetings, and heed well the Commander." },
			{ Cue = "/VO/Melinoe_4261", Text = "I see you're getting acclimated to this place." },
			{ Cue = "/VO/Melinoe_3557", Text = "Not quite as damp as Oceanus here, is it?",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeOceanusSIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3558", Text = "You made it from Oceanus, good...!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeOceanusSIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3559", Text = "Much better off here than the Mourning Fields.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeFieldsGreyIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3560", Text = "You found your way here from the Fields...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeFieldsGreyIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3561", Text = "I'm glad you're out of Tartarus at last.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeClockworkIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3562", Text = "I think you'll like it better here than Tartarus...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeClockworkIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_4265", Text = "This must be quite a change from Thessaly.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeShipsOneIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_4266", Text = "You made it from Olympus all this way...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeTyphonIdle" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_4267", Text = "You were all the way up at the summit, weren't you.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "OriginalSource", "GhostType" },
						IsAny = { "ShadeTyphonIdle" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "Q_Intro" },
					},
				},
			},
		},
		-- Hub_Main GhostEavesdrop interactions
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.45,
			-- SuccessiveChanceToPlayAll = 0.5,
			Cooldowns =
			{
				{ Name = "MelinoeShadeInteractVoiceLines", Time = 4 },
			},

			{ Cue = "/VO/Melinoe_3563", Text = "Hail, Shades. Our fight is just getting started.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 25,
					},
				},
			},
			{ Cue = "/VO/Melinoe_0342", Text = "Shades of the Crossroads, greetings." },
			{ Cue = "/VO/Melinoe_0344", Text = "Hail, Shades!" },
			{ Cue = "/VO/Melinoe_0345", Text = "Hail, O Spirits!" },
			{ Cue = "/VO/Melinoe_0346", Text = "Stay strong, my friends." },
			{ Cue = "/VO/Melinoe_0348", Text = "Welcome to the Crossroads, Shade." },
			{ Cue = "/VO/Melinoe_1698", Text = "Salutations." },
			{ Cue = "/VO/Melinoe_1699", Text = "Salutations!" },
			{ Cue = "/VO/Melinoe_1700", Text = "Death to Chronos!",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
						},
					},
				},
			},
			{ Cue = "/VO/Melinoe_1701", Text = "Moonlight guide you." },
			{ Cue = "/VO/Melinoe_1702", Text = "Moonlight guide you, Shades." },
			{ Cue = "/VO/Melinoe_1703", Text = "May moonlight guide you." },
			{ Cue = "/VO/Melinoe_1704", Text = "Moonlight guide us." },
			{ Cue = "/VO/Melinoe_1705", Text = "May moonlight guide us." },
			{ Cue = "/VO/Melinoe_4257", Text = "How fare you all tonight?" },
			{ Cue = "/VO/Melinoe_4260", Text = "Thank you for having faith in me." },
			{ Cue = "/VO/Melinoe_4262", Text = "Do let me know if anything's amiss." },
			{ Cue = "/VO/Melinoe_4263", Text = "Salutations to the Shades of the Unseen." },
			{ Cue = "/VO/Melinoe_4264", Text = "It's good to see you all again." },
			{ Cue = "/VO/Melinoe_5517", Text = "There's more still to be done.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5518", Text = "We'll see this realm restored.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_0347", Text = "Vengeance for my father.",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZagreusPastMeeting05", "HadesAboutUltimateProgress01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_0349", Text = "You are welcome here and you are safe.",
				Cooldowns =
				{
					{ Name = "SaidWelcomeHereRecently", Time = 180 },
				},
			},
			{ Cue = "/VO/Melinoe_4258", Text = "To further victories!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_4259", Text = "Another victory for all of us.",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},
			},
		},
	},

	FountainPrayerVoiceLines =
	{
		UsePlayerSource = true,
		{
			PreLineWait = 0.3,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PlayOnceFromTableThisRun = true,
			-- RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements = 
			{
			},
			Cooldowns =
			{
				{ Name = "MelinoeSaluteSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_4016", Text = "Father.", },
			{ Cue = "/VO/Melinoe_4017", Text = "Father..." },
			{ Cue = "/VO/Melinoe_4018", Text = "Greetings, Father..." },
			{ Cue = "/VO/Melinoe_4019", Text = "In shadow, I serve..." },
			{ Cue = "/VO/Melinoe_5560", Text = "The Underworld shall be restored...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5176", Text = "Grateful to have you back...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5175", Text = "See you again soon, Father.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_5177", Text = "Take care of our family...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_0169_B", Text = "What was forgotten shall be feared again.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_4020", Text = "Take care, Father...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_4021", Text = "Hold on, Father.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
		}
	},
	AdmireOlympusStatueVoiceLines =
	{
		UsePlayerSource = true,
		{
			PreLineWait = 0.3,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PlayOnceFromTableThisRun = true,
			-- RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements = 
			{
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
			},

			{ Cue = "/VO/Melinoe_5169", Text = "Generously provided by Apollo and Artemis...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_5170", Text = "Reminds me of Selene's chariot..." },
			{ Cue = "/VO/Melinoe_5171", Text = "The glowing moon and shining sun..." },
			{ Cue = "/VO/Melinoe_5172", Text = "Time belongs to us..." },
			{ Cue = "/VO/Melinoe_5173", Text = "A symbol of our families..." },
			{ Cue = "/VO/Melinoe_5174", Text = "It's beautiful..." },
			--[[
			{ Cue = "/VO/Melinoe_5168", Text = "Lord Hephaestus must have crafted this himself.",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 8,
						Path = { "SpeechRecord", "/VO/Melinoe_5168" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
				}
			},
			]]--
		}
	},
	StoppedSingingVoiceLines =
	{
		UsePlayerSource = true,
		{
			PreLineWait = 1.0,
			BreakIfPlayed = true,
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			ChanceToPlay = 0.33,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements = 
			{
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_4031", Text = "...I should go.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_4032", Text = "Next time?" },
			{ Cue = "/VO/Melinoe_4033", Text = "That was nice." },
			{ Cue = "/VO/Melinoe_4034", Text = "Take it away." },
		}
	},

	-- Biome Map
	RegionClearedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "LeftBiomeSpeech", Time = 10 },
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HecateBossKidnapped01" },
			},
		},
		-- Bounty Cleared
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.0,
			PlayOnceFromTableThisRun = true,
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "CurrentRun", "ShrineBountiesCompleted" },
				},
			},
			Cooldowns =
			{
				{ Name = "LeftBiomeSpeech", Time = 6 },
			},

			{ Cue = "/VO/MelinoeField_2531", Text = "Done!" },
			{ Cue = "/VO/MelinoeField_2532", Text = "Done there." },
			{ Cue = "/VO/MelinoeField_2534", Text = "Check." },
			{ Cue = "/VO/MelinoeField_2538", Text = "As planned." },
			{ Cue = "/VO/MelinoeField_4595", Text = "There." },
			{ Cue = "/VO/MelinoeField_4596", Text = "Victory." },
			{ Cue = "/VO/MelinoeField_4597", Text = "For Night.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_4598", Text = "For Nyx.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
		},
		-- Other Cases
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.65,
			SuccessiveChanceToPlay = 0.85,
			SuccessiveChanceToPlayAll = 0.25,

			{ Cue = "/VO/MelinoeField_2533", Text = "Onward." },
			{ Cue = "/VO/MelinoeField_2535", Text = "Next." },
			{ Cue = "/VO/MelinoeField_2536", Text = "Now then." },
			{ Cue = "/VO/MelinoeField_2537", Text = "This way." },
			{ Cue = "/VO/MelinoeField_4591", Text = "All set." },
			{ Cue = "/VO/MelinoeField_4592", Text = "That's that." },
			{ Cue = "/VO/MelinoeField_4593", Text = "Moving on." },
			{ Cue = "/VO/MelinoeField_4594", Text = "Good." },
			{ Cue = "/VO/MelinoeField_2542", Text = "Solid ground.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", "O" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2543", Text = "Made it.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H", "O" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2544", Text = "Now the climb.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_2458" }
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2539", Text = "Downward.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "G", "H" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2540", Text = "This is it.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H", "P" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_2541", Text = "My destination.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I", "P" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3880", Text = "Let's go, Frinos.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_3880" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_3881", Text = "Onward, Raki.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "RavenFamiliar" },
					},
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_3881" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_3882", Text = "Come on, Toula.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_3882" }
					},
				},
			},
			{ Cue = "/VO/Melinoe_3883", Text = "Onward, Hecuba.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "HoundFamiliar" },
					},
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_3883" }
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3056", Text = "Let's go, Gale.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "PolecatFamiliar" },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_3057", Text = "Onward, Gale.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "PolecatFamiliar" },
					},
				},
			},
		},
	},

	-- Interaction Events
	WeaponUpgradeLockedVoiceLines =
	{
		{ GlobalVoiceLines = "NotEnoughSuperLockKeysVoiceLines" },
	},
	GiftRackLockedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		GameStateRequirements =
		{
			-- None
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0221", Text = "Locked." },
		{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
		{ Cue = "/VO/Melinoe_0223", Text = "Not an option." },
		{ Cue = "/VO/Melinoe_0224", Text = "Won't open." },
	},
	WeaponKitUnlockedVoiceLines =
	{
		{
			PlayOnce = true,
			RandomRemaining = true,
			PlayOnceContext = "WeaponKitUnlockLines",
			PreLineWait = 0.35,
			CooldownTime = 5,

			{ Cue = "/VO/Melinoe_0234", Text = "Open." },
			{ Cue = "/VO/Melinoe_0235", Text = "Open up." },
			{ Cue = "/VO/Melinoe_0236", Text = "This one." },
			{ Cue = "/VO/Melinoe_0237", Text = "You're mine." },
			{ Cue = "/VO/Melinoe_0238", Text = "Sure." },
			{ Cue = "/VO/Melinoe_0239", Text = "Join with me." },
			{ Cue = "/VO/Melinoe_0240", Text = "You are mine now." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			CooldownTime = 5,
			SuccessiveChanceToPlayAll = 0.1,
			ObjectType = "NPC_Skelly_01",

			{ Cue = "/VO/Skelly_0014", Text = "Requisition authorized!" },
			{ Cue = "/VO/Skelly_0015", Text = "A fitting armament.", PlayFirst = true },
			-- { Cue = "/VO/Skelly_0112", Text = "Behold...!" },
			-- { Cue = "/VO/Skelly_0113", Text = "Behold." },
			{ Cue = "/VO/Skelly_0114", Text = "{#Emph}Behold!" },
			{ Cue = "/VO/Skelly_0115", Text = "You have proven worthy." },
			{ Cue = "/VO/Skelly_0116", Text = "Responsibility is earned." },
			-- { Cue = "/VO/Skelly_0117", Text = "Take the next step, young one." },
			-- { Cue = "/VO/Skelly_0118", Text = "The path to perfection!" },
			-- { Cue = "/VO/Skelly_0119", Text = "The path to perfection..." },
			-- { Cue = "/VO/Skelly_0120", Text = "This is for you." },
			{ Cue = "/VO/Skelly_0121", Text = "That is for you." },			
		},
	},
	-- QuestLog
	OpenedQuestLogSingleQuestCompleteVoiceLines =
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "MelQuestLogOpenedSpeech", Time = 200 },
		},
		{ Cue = "/VO/Melinoe_0739", Text = "Fulfilled that one did I?", PlayFirst = true,
			GameStateRequirements = 
			{
				{
					PathTrue = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_0737" },
				}
			}
		},

		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_0245", Text = "So..." },
		{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
	},
	OpenedQuestLogMultiQuestsCompleteVoiceLines =
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "MelQuestLogOpenedSpeech", Time = 200 },
		},

		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_0245", Text = "So..." },
		{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
		{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
	},
	OpenedQuestLogNewQuestsAddedVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Cooldowns =
			{
				{ Name = "MelQuestLogOpenedSpeech", Time = 200 },
			},

			{ Cue = "/VO/Melinoe_2793", Text = "No prophecies about me on the surface... so they don't know... or know I won't succeed...", PlayFirst = true,
				PreLineWait = 1.0,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
					},
				},
			},

			{ Cue = "/VO/Melinoe_1586", Text = "This is from the Three Fates...", PlayFirst = true, PlayOnce = true, PlayOnceContext = "FatedListIntroVO" },
			{ Cue = "/VO/Melinoe_0737", Text = "The Fated List of Minor Prophecies..." },
			{ Cue = "/VO/Melinoe_0745", Text = "This wasn't on the List before..." },
			{ Cue = "/VO/Melinoe_0746", Text = "Another prophecy..." },
			{ Cue = "/VO/Melinoe_0747", Text = "Will this truly come to pass?" },
			{ Cue = "/VO/Melinoe_0571", Text = "There's something new here..." },
			-- { Cue = "/VO/Melinoe_5155", Text = "Another message from the Fates..." },
			{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
			{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
			{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
			{ Cue = "/VO/Melinoe_0245", Text = "So..." },
			{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
			{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
		},
	},

	OpenedQuestLogVoiceLines =
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "MelQuestLogOpenedSpeech", Time = 200 },
		},

		{ Cue = "/VO/Melinoe_0850", Text = "The Fates would have me do their bidding...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0737", Text = "The Fated List of Minor Prophecies..." },
		{ Cue = "/VO/Melinoe_0738", Text = "The Fated List..." },
		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_5157", Text = "No more Prophecies for now...",
			PlayFirst = true,
			GameStateRequirements =
			{
				NamedRequirements = { "AllQuestsCompleted" },
			},
		},
	},
	CashedOutQuestVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MorosProphecyFulfilledSpeech", Time = 3 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			RequiredSourceValueFalse = "InPartnerConversation",
			ObjectType = "NPC_Moros_01",
			SuccessiveChanceToPlay = 0.33,

			{ Cue = "/VO/Moros_0290", Text = "My sisters must be pleased." },
			{ Cue = "/VO/Moros_0291", Text = "Another prophecy fulfilled?" },
			{ Cue = "/VO/Moros_0292", Text = "Prophecy fulfilled.", PlayFirst = true },
			{ Cue = "/VO/Moros_0293", Text = "Well done, Princess." },
			{ Cue = "/VO/Moros_0294", Text = "Your fate continues to unfold." },
			{ Cue = "/VO/Moros_0295", Text = "The Fates bestow a gift." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.55,

			{ Cue = "/VO/Melinoe_0748", Text = "Prophecy fulfilled.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0749", Text = "Another prophecy fulfilled.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0750", Text = "The Fates expected this.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0740", Text = "Looks like I did it...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0741", Text = "An inevitability.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0742", Text = "So it is written.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0743", Text = "A matter of time...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
			{ Cue = "/VO/Melinoe_0201", Text = "I accept this gift." },
			{ Cue = "/VO/Melinoe_0740", Text = "Looks like I did it...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
			{ Cue = "/VO/Melinoe_0204", Text = "Excellent." },
			{ Cue = "/VO/Melinoe_0206", Text = "Good." },
			{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm." },
			{ Cue = "/VO/Melinoe_0209", Text = "There." },
		},
	},

	-- Music Player
	PlayRandomMusicVoiceLines =
	{
		{
			SkipAnim = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.37,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelMusicPlayerRequestSpeech", Time = 10 },
			},

			{ Cue = "/VO/Melinoe_3842", Text = "Surprise me, Music Maker.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_3843", Text = "You pick this time, all right?" },
			{ Cue = "/VO/Melinoe_4001", Text = "Surprise me." },
			{ Cue = "/VO/Melinoe_4002", Text = "You pick this time." },
			{ Cue = "/VO/Melinoe_4003", Text = "Play whatever you like." },
			{ Cue = "/VO/Melinoe_4004", Text = "Whatever suits you." },
			{ Cue = "/VO/Melinoe_4005", Text = "Care to decide?" },
			{ Cue = "/VO/Melinoe_4006", Text = "Anything is fine." },
		},
		{ GlobalVoiceLines = "ArtemisSongStoppedReactionVoiceLines" },
		{ GlobalVoiceLines = "OdysseusSongReactionVoiceLines" },
	},

	-- Bounty Board
	BountyBoardOpenedVoiceLines =
	{
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoardRepeat" }
				},
				{
					Path = { "GameState", "PackgedBountyAttempts" },
					HasNone = GameData.AllRandomPackagedBounties,
				},
				NamedRequirements = { "PackageBountyRandom" },
			},
			Cooldowns =
			{
				{ Name = "MelBountyLogOpenedSpeech", Time = 200 },
			},

			{ Cue = "/VO/Melinoe_4822", Text = "{#Emph}Chaos Above{#Prev}, {#Emph}Chaos Below{#Prev}... that's new..." },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoardRepeat" }
				},
			},
			Cooldowns =
			{
				{ Name = "MelBountyLogOpenedSpeech", Time = 200 },
			},

			{ Cue = "/VO/Melinoe_3847", Text = "I can now redo prior Chaos Trials, just because." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				{ Name = "MelBountyLogOpenedSpeech", Time = 200 },
			},

			{ Cue = "/VO/Melinoe_0848", Text = "Let's see here." },
			{ Cue = "/VO/Melinoe_0849", Text = "New assignments." },
			-- { Cue = "/VO/Melinoe_0974", Text = "Night missions..." },
			{ Cue = "/VO/Melinoe_2624", Text = "Visions of darkness..." },
			{ Cue = "/VO/Melinoe_2625", Text = "Abyssal visions..." },
			{ Cue = "/VO/Melinoe_2626", Text = "Infinite possibilities...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2627", Text = "The depths of Chaos..." },
			{ Cue = "/VO/Melinoe_1420", Text = "I can see even deeper now..." },
			{ Cue = "/VO/Melinoe_3081", Text = "Conceal us, O Night..." },
			{ Cue = "/VO/Melinoe_5495", Text = "The Pitch-Black Stone..." },
			{ Cue = "/VO/Melinoe_5496", Text = "What would Chaos have me do?" },
			{ Cue = "/VO/Melinoe_5497", Text = "The depths of the abyss..." },
			{ Cue = "/VO/Melinoe_5498", Text = "What are the chances...?" },
		},
		{
			PlayOnce = true,
			PlayOnceContext = "SkellyBountyBoardScreenIntroVO",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Skelly_01",
			SuccessiveChanceToPlay = 0.1,
			Cooldowns =
			{
				{ Name = "SkellyMiscSpeech", Time = 20 },
			},

			{ Cue = "/VO/Skelly_0088", Text = "Observe the Pitch-Black Stone..." },
		},
	},
	BountyEarnedVoiceLines =
	{
		-- Oath / Testaments / Night Missions
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.1,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ActiveShrineBounty" },
				},
			},

			{ Cue = "/VO/MelinoeField_2036", Text = "Testament enacted.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2037", Text = "The Testament of Night.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2038", Text = "Fear of the realm spreads.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2039", Text = "In shadow, I serve.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1088", Text = "By will of Night.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1424", Text = "For the will of Night.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0981", Text = "Thank you, Nyx." },
			{ Cue = "/VO/Melinoe_0982", Text = "For the realm." },
			{ Cue = "/VO/Melinoe_1087", Text = "For the realm." },
			{ Cue = "/VO/Melinoe_1089", Text = "The realm grows stronger." },
			{ Cue = "/VO/Melinoe_1090", Text = "For the Underworld." },
		},
	},
	PackagedBountyClearedVoiceLines =
	{
		-- Chaos Trials
		{
			RandomRemaining = true,
			PreLineWait = 0.6,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "ActiveBounty" },
				},
			},

			{ Cue = "/VO/MelinoeField_2042", Text = "I did as Chaos asked.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2040", Text = "Experiment complete?", BreakIfPlayed = true },
			{ Cue = "/VO/MelinoeField_2041", Text = "Did you see that, Chaos...?", BreakIfPlayed = true },
			{ Cue = "/VO/MelinoeField_2043", Text = "Return to shadow, now...?", BreakIfPlayed = true },
			{ Cue = "/VO/Melinoe_0978", Text = "Mission complete." },
			{ Cue = "/VO/Melinoe_0979", Text = "Mission complete..." },
			{ Cue = "/VO/Melinoe_0980", Text = "Mission complete...!" },
			{ Cue = "/VO/Melinoe_1083", Text = "Done." },
			{ Cue = "/VO/Melinoe_1084", Text = "And, done." },
			{ Cue = "/VO/Melinoe_1085", Text = "Check." },
			{ Cue = "/VO/Melinoe_1086", Text = "And, check." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.6,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "ActiveBounty" },
				},
			},

			{ Cue = "/VO/MelinoeField_3739", Text = "{#Emph}Erm{#Prev}, what's going on...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "FirstChaosTrialCompleteVO" },
			{ Cue = "/VO/MelinoeField_0788", Text = "I'm ready..." },
			{ Cue = "/VO/MelinoeField_0790", Text = "Going." },
			{ Cue = "/VO/MelinoeField_0791", Text = "{#Emph}<Inhale>" },
			{ Cue = "/VO/MelinoeField_0795", Text = "Sting away." },
			{ Cue = "/VO/MelinoeField_0797", Text = "Hit me then." },
		},
	},
	ReceivedSupplyDropVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,

			{ Cue = "/VO/Melinoe_2284", Text = "Right on time." },
			{ Cue = "/VO/Melinoe_2285", Text = "Perfect condition.", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_2286", Text = "As promised." },
			{ Cue = "/VO/Melinoe_2287", Text = "It's all here." },

			--[[
			-- { Cue = "/VO/Melinoe_0764", Text = "Thank you!" },
			-- { Cue = "/VO/Melinoe_0765", Text = "Thank you." },
			-- { Cue = "/VO/Melinoe_0766", Text = "For me?" },
			-- { Cue = "/VO/Melinoe_0767", Text = "Thanks..." },
			-- { Cue = "/VO/Melinoe_0716", Text = "Got it." },
			-- { Cue = "/VO/Melinoe_0722", Text = "Mine." },
			-- { Cue = "/VO/Melinoe_0723", Text = "Tucked away." },
			-- { Cue = "/VO/Melinoe_0724", Text = "Into the purse." },
			-- { Cue = "/VO/Melinoe_0829", Text = "There." },
			-- { Cue = "/VO/Melinoe_0830", Text = "Oh." },
			]]--
		},
	},
}

GlobalModifiers =
{
	WeaponSimulationSlowPreWaitMultiplier = 1.0,
	WeaponSimulationSlowLerpTimeMultiplier = 1.0,
}

-- Early Access / Endgame Endings
GameOutroPriorities =
{
	"Outro_PostTrueEnding01",
	"Outro_PostTrueEnding01_B",
	"Outro_PostTrueEnding02",
	"Outro_PostTrueEnding_Surface01",
	"Outro_PostTrueEnding03",

	"Outro_Epilogue01",
	"Outro_StoryReset01",
	"Outro_TechTest02",

	"Outro_EarlyEnd_Typhon01",
	{
		"Outro_EarlyEnd_Typhon04",
		"Outro_EarlyEnd_Typhon06",
	},
	{
		"Outro_EarlyEnd_Typhon03",
		"Outro_EarlyEnd_Typhon05",
	},
	{
		"Outro_EarlyEnd_Frightful",
		"Outro_EarlyEnd_Future01",
		"Outro_EarlyEnd_DeusExMachina",
	},
	{
		"Outro_EarlyEnd_Palace01",
		"Outro_EarlyEnd_Olympus01",
		"Outro_EarlyEnd_Summit",
		"Outro_EarlyEnd_Heart",
		"Outro_EarlyEnd_Guardian",
		"Outro_EarlyEnd_Future02",
		"Outro_EarlyEnd_Typhon07",
		"Outro_EarlyEnd_Typhon08",
		"Outro_EarlyEnd_Typhon09",
		"Outro_EarlyEnd_Typhon10",
	},
	{
		"Outro_EarlyEnd_Foes",
		"Outro_EarlyEnd_Precarious",
		"Outro_EarlyEnd_Unimaginable",
		"Outro_EarlyEnd_Goal",
		"Outro_EarlyEnd_Night",
		"Outro_EarlyEnd_Olympus02",
		"Outro_EarlyEnd_Foresight01",
		"Outro_EarlyEnd_Modesty",
		"Outro_EarlyEnd_Immortals",
		"Outro_EarlyEnd_Dangers",
		"Outro_EarlyEnd_Countless",
		"Outro_EarlyEnd09",
	},
	{
		"Outro_EarlyEnd01b",
		"Outro_EarlyEnd07",
		"Outro_EarlyEnd_Typhon02",
	},
	{
		"Outro_EarlyEnd04",
		"Outro_EarlyEnd_Epic",
	},
	{
		"Outro_EarlyEnd06",
		"Outro_EarlyEnd08",
		"Outro_EarlyEnd10",
		"Outro_EarlyEnd_Ambiguity",
	},
	{
		"Outro_EarlyEnd12",
		"Outro_EarlyEnd13",
		"Outro_EarlyEnd14",
		"Outro_EarlyEnd15",
		"Outro_EarlyEnd_Gods",
		"Outro_EarlyEnd_Love",
		"Outro_EarlyEnd_Chronos",
		"Outro_EarlyEnd_Fiery",
		"Outro_EarlyEnd_Forgot",
		"Outro_EarlyEnd_Dream",
		"Outro_EarlyEnd_Dead",
		"Outro_EarlyEnd_Dance",
		"Outro_EarlyEnd_Titan",
		"Outro_EarlyEnd_Peace",
		"Outro_EarlyEnd_Reasoning",
		"Outro_EarlyEnd_Mystery",
		"Outro_EarlyEnd_Horror",
		"Outro_EarlyEnd_Adversary",
		"Outro_EarlyEnd_Feud",
		"Outro_EarlyEnd_Home",
		"Outro_EarlyEnd_Unpleasant",
		"Outro_EarlyEnd_Oath",
		"Outro_EarlyEnd_Dionysus",
	},
	{
		"Outro_EarlyEnd_Forgotten",
		"Outro_TechTest04",
		"Outro_TechTest05",
	},
	{
		"Outro_PostTrueEnding_Loop01",
	},
}

-- Early Access Endings / Endgame Endings (see: GameOutroPriorities)
GameOutroData =
{
	Outro_PostTrueEnding01 =
	{
		PlayOnce = true,
		TextDelay = 6.0,
		FadeOutWait = 23,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
			},
			{
				PathFalse = { "GameState", "SpeechRecord", "/VO/Storyteller_0481" }
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0481", Text = "{#Emph}Thus did Melinoë, the Unseen Princess of the Underworld, prevent the very possibility that Time could turn so cruelly against the gods again...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0482", Text = "{#Emph}At least one possibility, of which there may be many, many more. For Time flows like a river, and its passage and its currents take strange turns.", TextLimit = 300, PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0483", Text = "{#Emph}The Princess never did see the true House of Hades again; not on this night at least. But it is still entirely a mess from all which the Titan wrought, so she did not miss much.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_PostTrueEnding01_B =
	{
		PlayOnce = true,
		TextDelay = 6.0,
		FadeOutWait = 23,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
			},
			{
				PathFalse = { "GameState", "SpeechRecord", "/VO/Storyteller_0481" }
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0481", Text = "{#Emph}Thus did Melinoë, the Unseen Princess of the Underworld, prevent the very possibility that Time could turn so cruelly against the gods again...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0482", Text = "{#Emph}At least one possibility, of which there may be many, many more. For Time flows like a river, and its passage and its currents take strange turns.", TextLimit = 300, PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0484", Text = "{#Emph}The Princess never did return to the Palace of Zeus; not on this night at least. And neither did she truly mind, because the air and light up there were not quite to her taste.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_PostTrueEnding02 =
	{
		FadeOutWait = 16.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0485", Text = "{#Emph}Once more has the fierce Princess of the Underworld ensured that time flows freely forth; and in so doing, vanquished a foul remnant of her foe.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0486", Text = "{#Emph}The work itself can be quite rigorous, having to cross to other possibilities out of the singular reality we know. Thus the Princess now feels ready for a nap.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_PostTrueEnding_Surface01 =
	{
		FadeOutWait = 10,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0487", Text = "{#Emph}A figment of the monstrous Typhon is destroyed, yet none perhaps shall know of it, save for the Princess of the Dead and her grandfather, Time. And you, and I, and whosoever else shall hear my tale, I suppose...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_PostTrueEnding03 =
	{
		FadeOutWait = 5.8,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0488", Text = "{#Emph}The only Time that we experience is now. We have the Princess of the Dead to thank for it, through all her tireless endeavors, such as what transpired on this very night.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_Epilogue01 =
	{
		PlayOnce = true,
		TextDelay = 8.5,
		FadeOutWait = 46.0,
		SubtitleColor = Color.NarratorVoice,
		TextColor1 = Color.White,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0475", Text = "{#Emph}Thus did the Three reclusive and feared Fates, whose often-unpredictable weavings determine all that is to come, even for gods, declare the dawning of another age...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0476", Text = "{#Emph}...an age in which both mortals and immortals shall be free to choose their path, so long as they believe the choice exists...", TextLimit = 300, PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0477", Text = "{#Emph}...a golden age, during which mortalkind shall not be ruled entirely by divine right, but by itself.", TextLimit = 310, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0478", Text = "{#Emph}Word quickly spreads, from the heights of Olympus to the depths of the Underworld, foretelling of this perhaps very very distant future filled with possibility and the unknown.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0479", Text = "{#Emph}Many rejoice; but others know that gods do not go quietly, and history repeats.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0480", Text = "{#Emph}For now, we can but use the Time we have; both to prepare, and, to the best of our ability, to live.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_StoryReset01 =
	{
		FadeOutWait = 26,
		PauseMusic = true,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "UsedStoryReset" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0528", Text = "{#Emph}Few tales are told of Hades, especially whilst he is bound in chains, in Tartarus... a prisoner of Time, no longer ruler of the Underworld.", PreLineWait = 0.72, NoTarget = true },
			{ Cue = "/VO/Storyteller_0530", Text = "{#Emph}His sole salvation, and our own, is the fierce Princess of the Dead. She has at last confronted both of her great foes...", PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0531", Text = "{#Emph}...scheming Chronos, the Titan of Time; and colossal Typhon, the Father of All Monsters — confronted, but not vanquished either one. Yet.", PreLineWait = 0.5, NoTarget = true },
		},
	},

	-- Kiosk Mode
	Outro_TechTest02 =
	{
		PlayOnce = true,
		FadeOutWait = 8.25,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01" },
			},
			{
				PathTrue = { "ConfigOptionCache", "DemoMode" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0275", Text = "{#Emph}Having passed a test of her ability, the witch Melinoë prepares for the true test of both her training and resolve. But since this also is a Test, no more from that is to be shared for now.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest04 =
	{
		PlayOnce = true,
		FadeOutWait = 3.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0277", Text = "{#Emph}Born in shadow, the nightmare-bringing Princess of the Underworld shall return now whence she came.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest05 =
	{
		PlayOnce = true,
		FadeOutWait = 6.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0278", Text = "{#Emph}What is life but a series of tests and trials? One of which the shadow-stepping Princess has completed, whilst another looms on the horizon, coming soon.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- Underworld variants
	Outro_EarlyEnd13 =
	{
		FadeOutWait = 6.3,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0100", Text = "{#Emph}Surely from there the Princess of the Underworld vanquished hateful Chronos utterly, restoring peace wherever it was lost, and then lived joyfully for all eternity?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Titan =
	{
		FadeOutWait = 7.7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0183", Text = "{#Emph}The vengeful Princess and the hateful Titan fought and fought. That is until the Titan, with the Princess at his mercy, took the opportunity to give a speech... during which the Princess slew him after all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Mystery =
	{
		FadeOutWait = 10,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0226", Text = "{#Emph}And what do you suppose the Princess found within that unassuming chamber in her father's former House? Naught but suggestive wall-scrolls, or a gaming-table, long unused? Eh... we shall eventually find out...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Horror =
	{
		FadeOutWait = 7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0227", Text = "{#Emph}Just as the Princess walks defiantly away, something begins to slightly stir behind her... is it the Titan Chronos, scythe in hand?! Oh gods, Melinoë, watch out!", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Adversary =
	{
		FadeOutWait = 11,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0228", Text = "{#Emph}Another victory, and yet, an adversary such as Time has proven a most-stubborn one indeed. If I myself were Time, why, I would simply turn back the sun-dial, assuming that I could, so that this night would never come to pass.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Feud =
	{
		FadeOutWait = 8.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0229", Text = "{#Emph}Having resolved her family's blood-feud, now the Princess has scarce anything to do, except to call this one a night; and on the next, give the rekindled blood-feud yet another go.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Home =
	{
		FadeOutWait = 9.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0231", Text = "{#Emph}Returned now to her long-abandoned home, fearsome Melinoë there finds too many curiosities; a leading cause of death for cats, and she likes cats, so exercises prudence and restraint.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Unpleasant =
	{
		TextDelay = 5.5,
		FadeOutWait = 4.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0232", Text = "{#Emph}What would become of us if Time could utterly be stopped... destroyed outright? It is unpleasant, frankly, just to think about, so we had best not dwell upon such things at all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Chronos =
	{
		FadeOutWait = 5.7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0163", Text = "{#Emph}And so, conniving Chronos was never heard from again, and young Melinoë and all her comrades lived happily ever after. {#Prev}Or did they...?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Immortals =
	{
		FadeOutWait = 6.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0466", Text = "{#Emph}Time itself is every mortal's enemy; and enemy to some immortals, too. So let us all be thankful that the Princess of the Dead has really throttled him again.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	
	-- Olympus route / -- Surface route
	Outro_EarlyEnd_Typhon01 =
	{
		FadeOutWait = 23.7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0085", Text = "{#Emph}Thus the ever-ready Princess of the Underworld gained the very heights of Mount Olympus, to confront an unspeakable horror that awaits.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0319", Text = "{#Emph}It is no secret to which horror I refer; no secret now to its enormity, its boundless anger, or its many, many eyes.", TextLimit = 300, PreLineWait = 1, NoTarget = true },
			{ Cue = "/VO/Storyteller_0319_B", Text = "{#Emph}Such horrors cannot truly be destroyed... unless the Princess can come up with something at a Future Time.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon02 =
	{
		TextDelay = 3.5,
		FadeOutWait = 6.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0320", Text = "{#Emph}Another night, another massive undulating monster brought to heel; and for the Princess of the Dead, such victories are to be savored. But only for a bit.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon03 =
	{
		FadeOutWait = 10.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0321", Text = "{#Emph}After a grueling confrontation with the father of monstrosity, the Princess of the Dead yet stands, whilst the monstrosity does not. But since the hour now grows late, the sleepy Princess figures she ought to retire for the night.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon04 =
	{
		TextDelay = 4.5,
		FadeOutWait = 4.8,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0322", Text = "{#Emph}This world is filled with monsters large and small. And for the most part, they are not unstoppable, as evidenced by our dark Princess of the Dead, who thus decides to take a little break.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon05 =
	{
		TextDelay = 5.0,
		FadeOutWait = 5.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0323", Text = "{#Emph}It is most-natural to wonder, now that our Princess of the Underworld withstood the terrifying fury of the Father of All Monsters, what comes next? So please, go right ahead and wonder that.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon06 =
	{
		TextDelay = 6.0,
		FadeOutWait = 8.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0324", Text = "{#Emph}Much is required to subdue the hulking, furious progenitor of all the world's monstrosities: courage, strength, agility, a lifelong training regimen from a great witch; perhaps even a stroke of Fate. This night, at least, the Princess has it all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon07 =
	{
		FadeOutWait = 8.75,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0325", Text = "{#Emph}Beyond that besieged precipice, the Princess of the Dead discovers all the splendors for which Mount Olympus is well known... and she partakes of them, including an express trip back to her more-modest home.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon08 =
	{
		FadeOutWait = 8.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0326", Text = "{#Emph}Upon the mountain of the gods, one's mortal senses surely would be overwhelmed; so if you are unable now to see or hear or smell or touch or taste it, that is surely for the best.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon09 =
	{
		TextDelay = 3,
		FadeOutWait = 4,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0327", Text = "{#Emph}If one is of the Underworld, having to battle at extraordinarily high altitudes is ill-advised. There must be some more down-to-earth approach.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Typhon10 =
	{
		FadeOutWait = 7.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0328", Text = "{#Emph}It takes practically all night for the hard-toiling Princess of the Dead to clamber to the highest point upon Olympus. But as often is the case, her return trip flies by in no time at all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- olympus variants
	Outro_EarlyEnd_Olympus01 =
	{
		FadeOutWait = 5.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0284", Text = "{#Emph}The summit of Olympus looms so close, and yet... try as she might, the surface-scouring Princess can climb no closer for the time. Although it never hurts to try.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Foes =
	{
		FadeOutWait = 7.9,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0251", Text = "{#Emph}Once fearsome witch Melinoë surpasses all the many foes standing between her and the summit of Olympus, a most extraordinary thing occurs! But all those in attendance made a promise not to tell a soul.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Precarious =
	{
		FadeOutWait = 8.7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0252", Text = "{#Emph}The summit of Olympus is a hallowed yet precarious locale. And so the Underworld Princess, unaccustomed to such rarified terrain, decides to take the last leg of her journey very, very slow...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Unimaginable =
	{
		FadeOutWait = 7.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0253", Text = "{#Emph}Such unimaginable sights await the surface-voyaging Princess as she ascends the heights of Mount Olympus that, to our mortal minds and senses, why... they simply cannot be described.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Summit =
	{
		FadeOutWait = 7.3,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "Q" },
			},
			{
				PathTrue = { "GameState", "EnemyKills", "Chronos" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0254", Text = "{#Emph}From the summit of Olympus, Titan-slaying witch Melinoë regards the world to which the gods lay claim; and she decides this precious world which we all share is perfect, just the way it is.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Dionysus =
	{
		FadeOutWait = 7.2,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "P_Story01" },
			},
			{
				PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0463", Text = "{#Emph}After vanquishing the abomination that is Typhon for the umpteenth time, the Princess of the Dead backtracks a bit to revel with the mirthful Dionysus, but retains no memory of that at all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Countless =
	{
		FadeOutWait = 7.6,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0464", Text = "{#Emph}It is said that the Father of All Monsters possesses countless snaking limbs and peering eyes; so if the Princess of the Dead took out a few this night, perhaps it was of little consequence.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Dangers =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0465", Text = "{#Emph}Again the Fate-defying Princess braves the dangers of the mountain of the gods, and stands defiantly upon its tallest peak; but then the moment passes, \n {#Emph}and she calls it a night.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- misc outcomes
	Outro_EarlyEnd_Frightful =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "GameplayTime" },
				Comparison = "<=",
				Value = 720,
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0467", Text = "{#Emph}The frightful-fast Princess Melinoë made such short work of her great foe this night, that Time itself seems to be on her side. But that cannot be possible, can it?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Heart =
	{
		FadeOutWait = 6.9,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0255", Text = "{#Emph}Whereupon the torch-bearing Melinoë ascends the mountain of the gods, she realizes that she left her heart within the Crossroads, which she calls her home; and thus decides to go and pick it up.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Goal =
	{
		FadeOutWait = 7.6,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0256", Text = "{#Emph}Night-wandering Melinoë by now has traveled very far indeed, accomplishing her goal such as she can. Strangely enough, however, her return trip truly takes no time at all.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Guardian =
	{
		FadeOutWait = 6.6,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0257", Text = "{#Emph}The Underworld's guardian Melinoë belongs not high above the surface, but below. Thus having taken care of family business for the night, she vanishes before the break of dawn.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Night =
	{
		FadeOutWait = 7.2,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0258", Text = "{#Emph}And so, under the watchful Eye of Night, unseen Melinoë gains the very top of Mount Olympus, where such revelry occurs that subsequent events this night are rather murky still.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Olympus02 =
	{
		FadeOutWait = 6.25,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "P" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0286", Text = "{#Emph}So violent is the clash that then ensues upon the summit of Olympus that I cannot even find the words to speak of it. Although I mean to find them... soon enough.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Foresight01 =
	{
		FadeOutWait = 8.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "P" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0287", Text = "{#Emph}Imagine knowing everything that shall transpire, much like the fierce Titan of Foresight can. Amongst the many questionable benefits, you would not need for me to say what happens next.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd_Palace01 =
	{
		FadeOutWait = 10.25,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "P" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0292", Text = "{#Emph}Beyond lies the Palace of Zeus, stronghold of the gods, in all its awesome glory. But, it is undergoing renovations at this time... so imagining those luxurious-yet-stately halls shall have to do for now.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- misc. variants
	Outro_EarlyEnd01b =
	{
		Header = "Outro_EarlyEnd01",
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0088", Text = "{#Emph}So numerous are the travails of dread Melinoë that one can scarce begin to fathom them; but on some evening, fathom them we shall.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd07 =
	{
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0094", Text = "{#Emph}From shadow sprang the peerless witch Melinoë, and back to shadow she returns, for now. We shall resume her tale at another time.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd10 =
	{
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0097", Text = "{#Emph}One rightly may imagine that this tale has a very thrilling end; although I am afraid for now, that we are out of Time.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd04 =
	{
		FadeOutWait = 5.4,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0091", Text = "{#Emph}What then became of sorcerous Melinoë, you ask? This I would surely tell you, if I could. Alas that, for the moment, I cannot.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd06 =
	{
		FadeOutWait = 6.5,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0093", Text = "{#Emph}Of all great feats achieved by mortals or by gods, the nightmare-bringing Princess would achieve perhaps the greatest of them all. It's just, I cannot tell you of it yet...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd08 =
	{
		FadeOutWait = 5.9,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0095", Text = "{#Emph}So incomparable is the tale of the Princess of the Underworld that, why, I cannot even find the words. Though, by the gods, eventually, I shall!", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd09 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0096", Text = "{#Emph}The sheer wrath of fire-tempered witch Melinoë is such that to describe how she confronted her remaining prey would be to sorely limit the appeal of this tale...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd12 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0099", Text = "{#Emph}With victory at hand, the oft-feared Princess of the Dead achieved her life's ambition, and lived happily thenceforth for all eternity... or so I choose to think?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd14 =
	{
		FadeOutWait = 7.8,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0101", Text = "{#Emph}Thenceforth, all of the effort and hard work put in by studious Melinoë converted to a suitable reward; a life of pleasure and of luxury, perhaps! For what is life if not completely fair?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd15 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0102", Text = "{#Emph}Surely a pleasant outcome of some sort awaits? Perhaps the Princess is invited to a regal ball, and therein meets her heart's desire, all whilst dancing to a catchy tune...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Gods =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0161", Text = "{#Emph}And after all of that, the Princess of the Dead and all the gods above the surface and below, they set aside their differences and lived from there on out contentedly.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Love =
	{
		FadeOutWait = 6.7,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0162", Text = "{#Emph}Thus young and spirited Melinoë found true love: the sport known as the discus-throw. And whilst she did not win the championship, she won over our hearts.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Fiery =
	{
		FadeOutWait = 6.5,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0164", Text = "{#Emph}With the forces of her enemy in ruin at her fiery feet, Princess Melinoë decided to return whence she came, for she could always devastate them more some other night.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Forgot =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0165", Text = "{#Emph}Only after all of that did normally-diligent Melinoë discover she forgot something at home. Forgot her keys! So she turned toward the darkness and she said...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Dream =
	{
		TextDelay = 7.0,
		FadeOutWait = 3.5,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0180", Text = "{#Emph}So lifelike was the nightmare tormenting the Princess of the Dead that she was very much surprised to learn that it was all a dream! Merely a dream, from which she shall awaken any moment now...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Dead =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0181", Text = "{#Emph}The Dark Princess had always felt a strong connection with the dead, yet never quite knew why. That is until she realized that she was dead herself, and had been, all this time...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Dance =
	{
		TextDelay = 7,
		FadeOutWait = 5.25,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0182", Text = "{#Emph}Thus having satisfied her heart's desire, the Princess felt such jubilation that she burst into a mirthful dance. And so infectious was this celebration that her friends as well as foes all soon joined in.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Peace =
	{
		TextDelay = 4,
		FadeOutWait = 4.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			NamedRequirements = { "ReachedEpilogue" },
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0184", Text = "{#Emph}And ever since that time, the peoples of the surface and the Underworld sought to live in peace and harmony, knowing that only together would they make the world a better place.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Forgotten =
	{
		FadeOutWait = 6.75,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0185", Text = "{#Emph}That was the last we ever heard of the Princess. Her tale was forgotten, it is true. Yet were it not for her great sacrifices, none of us would be here now, would we?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Reasoning =
	{
		FadeOutWait = 5.25,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0186", Text = "{#Emph}So far beyond the scope of reasoning were the events that happened next, that committing them to words would be such folly as to not be worthy even of attempt.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Ambiguity =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0187", Text = "{#Emph}The subsequent events were fraught with ambiguity; the tale's theme as obscure as its setting. Whether the Princess truly found that which she sought remains contested to this day.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Epic =
	{
		FadeOutWait = 8.5,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0230", Text = "{#Emph}Imagine now a tale which has such an epic scope, that the conclusion to the whole affair is nowhere to be found. For each great challenge that the heroine surmounts, another slightly different one awaits.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Future01 =
	{
		FadeOutWait = 7.2,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
			},
			NamedRequirementsFalse = { "ReachedEpilogue" },
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0288", Text = "{#Emph}What does the future hold? Only the Fates themselves and perhaps Prometheus the Titan of Foresight know full well. Unfortunately, all of them are rather indisposed right now.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Future02 =
	{
		FadeOutWait = 13.0,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0293", Text = "{#Emph}The future is uncertain, but one certainty is this: Time marches ever onward, often faster than one might presume, until we find ourselves wherever the Fates mean for us to be... which in the Princess of the Dead's case is right here...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Modesty =
	{
		FadeOutWait = 10.0,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0289", Text = "{#Emph}After accomplishing a truly monumental feat, the ever-modest Princess of the Dead respectfully requests for there to be no boasting or exaggerated tales of her ultimate result; merely a brief acknowledgement, like this.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Oath =
	{
		FadeOutWait = 7.2,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpentShrinePointsCache" },
				Comparison = ">=",
				Value = 10,
			},
		},
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0290", Text = "{#Emph}Again Princess Melinoë prevails in her climactic confrontation, and again, I shall say nothing of what happens next; for I am under Oath to speak no more.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_DeusExMachina =
	{
		FadeOutWait = 9.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			NamedRequirementsFalse = { "ReachedEpilogue" },
		},
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0291", Text = "{#Emph}Perhaps after this point the Three Fates suddenly appear and say, {#Prev}Well done, Melinoë! But we shall now take care of everything. {#Emph}And then they do. How happy of an outcome that would be!", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_PostTrueEnding_Loop01 =
	{
		TextDelay = 7.0,
		FadeOutWait = 7.2,
		SubtitleColor = Color.NarratorVoice,

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0500", Text = "{#Emph}So many different possibilities exist in which the Princess of the Dead prevails or fails... and this is but one more. Certainly, no two such possibilities are quite alike; nor ever have occurred before, nor ever again shall...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- end of endings
}

GameData.DamageNumberTextScales =
{
	{ Min = 0, Max = 19, Scale = 0.8 },
	{ Min = 20, Max = 49, Scale = 0.9 },
	{ Min = 50, Max = 99, Scale = 1.0 },
	{ Min = 100, Max = 399, Scale = 1.2 },
	{ Min = 400, Max = 999, Scale = 1.4 },
	{ Min = 1000, Max = 99999, Scale = 1.6 },
}

GameData.PlayerDamageNumberTextScales =
{
	{ Min = 0, Max = 3, Scale = 0.9 },
	{ Min = 4, Max = 9, Scale = 1.1 },
	{ Min = 10, Max = 14, Scale = 1.4 },
	{ Min = 15, Max = 19, Scale = 1.7 },
	{ Min = 20, Max = 25, Scale = 2.0 },
	{ Min = 26, Max = 49, Scale = 2.3 },
	{ Min = 50, Max = 99, Scale = 2.6 },
	{ Min = 100, Max = 99999, Scale = 3.0 },
}
