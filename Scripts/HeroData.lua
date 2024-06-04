HeroData =
{
	Name = "Default",
	DefaultWeapon = "WeaponStaffSwing",
	MaxHealth = 30,
	MaxHealthMultiplier = 1,
	MaxMana = 50,
	LastStands = {},
	UnusedWeaponThreshold = 3,
	DashManeuverTimeThreshold = 0.4,
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

	AnimOffsetZ = 0,
	-- EmoteOffsetX = -80,
	-- EmoteOffsetY = -100,
	SpeechCooldownTime = 12,

	EasyModeDamageMultiplierBase = 0.8,
	EasyModeDamageMultiplierPerDeath = -0.02,
	EasyModeDamageMultiplierDeathCap = 30,

	TargetMetaRewardsRatio = 0.45,
	TargetMetaRewardsAdjustSpeed = 10.0,
	ShrinePointMetaPointBonusMultiplier = 0.02,

	SecretDoorCostBase = 10,
	SecretDoorCostDepthScalar = 0.4,

	DamagedSound = "/SFX/Enemy Sounds/Megaera/EmoteHurt",
	ChokingSound = "/SFX/Enemy Sounds/Megaera/EmoteHurt",
	FrozenSound = "/SFX/Enemy Sounds/Megaera/EmoteHurt",
	UnFrozenSound = "/SFX/Enemy Sounds/Megaera/EmoteHurt",

	PlayerInjuredVoiceLineThreshold = 0.65,

	OnDeathShakeScreenSpeed = 250,
	OnDeathShakeScreenDistance = 5,
	OnDeathShakeScreenDuration = 0.25,
	OnDeathShakeScreenAngle = 90,

	InteractAnimation = "MelinoeInteract",
	BoonInteractAnimation = "MelinoeBoonInteract",
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
		{
			FunctionName = "CheckPrevTraitsManaReserveShrineUpgrade",
			Args =
			{
				-- None
			},
			GameStateRequirements =
			{
				-- None
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
			RequiredMinCompletedRuns = 2
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
			RequiresInRun = true,
		},

		{ Cue = "/VO/Melinoe_0319", Text = "You..." },
		{ Cue = "/VO/Melinoe_0320", Text = "{#Emph}Rngh." },
		{ Cue = "/VO/Melinoe_0321", Text = "{#Emph}Tsch." },
		{ Cue = "/VO/Melinoe_0322", Text = "{#Emph}Grr!" },
		{ Cue = "/VO/Melinoe_0323", Text = "{#Emph}Pah." },
		{ Cue = "/VO/Melinoe_0324", Text = "Really." },
		{ Cue = "/VO/Melinoe_0325", Text = "{#Emph}Nrgh." },
		{ Cue = "/VO/Melinoe_0326", Text = "Truly." },
		{ Cue = "/VO/Melinoe_0327", Text = "No...!" },
		{ Cue = "/VO/Melinoe_0328", Text = "Damn you...!" ,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", },
				},
			},
		},

	},
	LightBarColor = { 0, 0, 255, 255 }
}
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
				{ Name = "MelSpellNotReadySpeech", Time = 120 },
			},

			{ Cue = "/VO/MelinoeField_2203", Text = "Can't use my Hex just yet...!" },
			{ Cue = "/VO/MelinoeField_2204", Text = "My Hex is spent for now!" },
			{ Cue = "/VO/MelinoeField_2205", Text = "My Hex isn't prepared...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2206", Text = "Just a bit longer...!" },
		},
		[2] = GlobalVoiceLines.OutOfManaVoiceLines,
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
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.15,
			ObjectType = "NPC_Odysseus_01",
			RequiredSourceValueFalse = "InPartnerConversation",
			GameStateRequirements =
			{
				RequiredFalseQueuedTextLines = GameData.OdysseusTavernaEvents,
			},

			{ Cue = "/VO/Odysseus_0328", Text = "{#Emph}Ah{#Prev}, that's a nice touch." },
			{ Cue = "/VO/Odysseus_0329", Text = "Plenty of room to grow.", PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsNone = { "/VO/Melinoe_2359", "/VO/Melinoe_2360" },
					},
				},
			},
			{ Cue = "/VO/Odysseus_0330", Text = "Our garden flourishes." },
			{ Cue = "/VO/Odysseus_0331", Text = "{#Emph}Oh{#Prev}, what have we there." },
			-- { Cue = "/VO/Odysseus_0332", Text = "How unexpected, that." },
			-- { Cue = "/VO/Odysseus_0333", Text = "Such sorcery." },
		},
	},
	HarvestVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
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
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			GameStateRequirements =
			{
				RequiredKillEnemiesNotFound = true,
			},

			{ Cue = "/VO/Melinoe_0206", Text = "Good." },
			{ Cue = "/VO/Melinoe_0207", Text = "Adequate." },
			{ Cue = "/VO/Melinoe_0208", Text = "{#Emph}Hm!" },
			{ Cue = "/VO/Melinoe_0209", Text = "There." },
			{ Cue = "/VO/Melinoe_0211", Text = "Right." },
			{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
			{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		},
		[2] = GlobalVoiceLines.HecateGatherReactionVoiceLines,
		[3] = GlobalVoiceLines.ArachneGatherReactionVoiceLines,
		[4] = GlobalVoiceLines.PolyphemusGatherReactionVoiceLines,
	},
	PickaxeUseInProgressVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.15,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				RequiredMinHealthFraction = 0.25,
			},
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
		[2] = GlobalVoiceLines.HecateGatherReactionVoiceLines,
		[3] = GlobalVoiceLines.ArachnePickaxeReactionVoiceLines,
		[4] = GlobalVoiceLines.NemesisGatherReactionVoiceLines,
		[5] = GlobalVoiceLines.PolyphemusPickaxeReactionVoiceLines,
		[6] = GlobalVoiceLines.HadesHarvestReactionVoiceLines,
		[7] = GlobalVoiceLines.ChaosHarvestReactionVoiceLines,
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
		[2] = GlobalVoiceLines.HecateGatherReactionVoiceLines,
		[3] = GlobalVoiceLines.ArachneGatherReactionVoiceLines,
		[4] = GlobalVoiceLines.NemesisGatherReactionVoiceLines,
		[5] = GlobalVoiceLines.PolyphemusShovelReactionVoiceLines,
		[6] = GlobalVoiceLines.HadesHarvestReactionVoiceLines,
		[7] = GlobalVoiceLines.ChaosHarvestReactionVoiceLines,
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
		[2] = GlobalVoiceLines.ArachneMineReactionVoiceLines,
	},
	ExorcismStartVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_1621", Text = "Be not afraid..." },
		{ Cue = "/VO/Melinoe_1622", Text = "Let me show you the way..." },
		{ Cue = "/VO/Melinoe_1623", Text = "Let me help you...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1624", Text = "Look upon me..." },
		{ Cue = "/VO/Melinoe_0333", Text = "Join me!" },
	},
	ExorcismResistedVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 1.0,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_1631", Text = "Why don't we try again.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1632", Text = "Resisted me..." },
			{ Cue = "/VO/Melinoe_1633", Text = "Didn't work..." },
			{ Cue = "/VO/Melinoe_1634", Text = "Stubborn, aren't you..." },
			{ Cue = "/VO/Melinoe_0321", Text = "{#Emph}Tsch." },
			{ Cue = "/VO/Melinoe_0325", Text = "{#Emph}Nrgh..." },
		},
		[2] = GlobalVoiceLines.NemesisScoffingVoiceLines,
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
		[2] = GlobalVoiceLines.NemesisScoffingVoiceLines,
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
		[2] = GlobalVoiceLines.ArachneExorcismReactionVoiceLines,
		[3] = GlobalVoiceLines.NarcissusExorcismReactionVoiceLines,
		[4] = GlobalVoiceLines.NemesisExorcismReactionVoiceLines,
		[5] = GlobalVoiceLines.HadesExorcismReactionVoiceLines,
		[6] = GlobalVoiceLines.SeleneExorcismReactionVoiceLines,
	},

	SheepAttackVoiceLines =
	{
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.4,
		RandomRemaining = true,
		ChanceToPlay = 0.25,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.05,
		ObjectType = "Hecate",
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 4 },
		},

		{ Cue = "/VO/HecateField_0209", Text = "If you could see yourself...!" },
		{ Cue = "/VO/HecateField_0210", Text = "Not very dignified." },
		{ Cue = "/VO/HecateField_0211", Text = "Come on, Melinoë." },
		{ Cue = "/VO/HecateField_0212", Text = "Fall back!" },
	},

	GhostTrainVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements = 
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">",
				Value = 0,
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MorosBeingPolite", Time = 2 },
		},

		{ Cue = "/VO/Melinoe_2425", Text = "Oh, hello...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2426", Text = "I'm fine, really!" },
		{ Cue = "/VO/Melinoe_2427", Text = "No need to be concerned!" },
		{ Cue = "/VO/Melinoe_2428", Text = "Begging your pardon, Shades." },
		{ Cue = "/VO/Melinoe_2429", Text = "Good evening everyone...!" },
		{ Cue = "/VO/Melinoe_2430", Text = "Thank you for waiting..." },
		{ Cue = "/VO/Melinoe_2431", Text = "Come along then...!" },
		{ Cue = "/VO/Melinoe_2432", Text = "Let's have a look around." },
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
			{ Cue = "/VO/Melinoe_2305", Text = "You're welcome here and safe." },
			{ Cue = "/VO/Melinoe_2595", Text = "You're all grown up." },
			{ Cue = "/VO/Melinoe_2596", Text = "Sprang up so fast." },
			{ Cue = "/VO/Melinoe_2597", Text = "How tall you've grown..." },
			{ Cue = "/VO/Melinoe_2598", Text = "You're a sight to behold." },
			{ Cue = "/VO/Melinoe_2599", Text = "How's the soil, good?" },
		},
		-- [2] = GlobalVoiceLines.HecateGatherReactionVoiceLines,
		-- [3] = GlobalVoiceLines.ArachneGatherReactionVoiceLines,
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
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "FrogFamiliar" },
				}
			},
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

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
			--[[
			{ Cue = "/VO/MelinoeField_2082", Text = "Some a{#Emph}fish{#Prev}tance, please?",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_2081" }
					}
				}
			},
			]]--
		},

	},
	FamiliarThankingVoiceLines=
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.35,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsNone = { "CatFamiliar" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
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
				},
			},
			{ Cue = "/VO/MelinoeField_2094", Text = "Well done, Frinos.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.35,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EquippedFamiliar" },
					IsAny = { "CatFamiliar" },
				}
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			{ Cue = "/VO/MelinoeField_2087_B", Text = "Thanks, little one." },
			{ Cue = "/VO/MelinoeField_2088_B", Text = "Why thank you." },
			{ Cue = "/VO/MelinoeField_2089_B", Text = "Well done." },
			{ Cue = "/VO/MelinoeField_2090_B", Text = "Nicely done." },
			{ Cue = "/VO/MelinoeField_2091_B", Text = "Good job!" },
			{ Cue = "/VO/MelinoeField_2092_B", Text = "Appreciate the help." },
			{ Cue = "/VO/MelinoeField_2095", Text = "Good work, Toula." },
			{ Cue = "/VO/MelinoeField_2096", Text = "Cheers, Toula." },
		},
	},

	-- Cauldron
	CauldronSpellDiscoveredVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		-- SuccessiveChanceToPlayAll = 0.33,
		Cooldowns =
		{
			{ Name = "MelCauldronOpenedSpeech", Time = 20 },
			{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
		},

		{ Cue = "/VO/Melinoe_3411", Text = "Last night I dreamt of this...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3412", Text = "I know what to do..." },
		{ Cue = "/VO/Melinoe_3413", Text = "Been meaning to try this..." },
		{ Cue = "/VO/Melinoe_3414", Text = "Epiphany...!" },
		{ Cue = "/VO/Melinoe_0512", Text = "I have an idea..." },
		{ Cue = "/VO/Melinoe_0513", Text = "I know...!" },
		{ Cue = "/VO/Melinoe_0514", Text = "This should work..." },
		{ Cue = "/VO/Melinoe_0515", Text = "What if I try {#Emph}this..." },
		{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
		{ Cue = "/VO/Melinoe_0241", Text = "Interesting..." },
		{ Cue = "/VO/Melinoe_0337", Text = "{#Emph}Hmm." },
		{ Cue = "/VO/Melinoe_1349", Text = "This should be possible..." },
		{ Cue = "/VO/Melinoe_2969", Text = "I've had these in my head for long enough...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3411" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_2970", Text = "As we improve ourselves, so does our craft...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2969" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_2971", Text = "Each night, another possibility...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2969" },
				}
			},
		},
		{ Cue = "/VO/Melinoe_2972", Text = "May my intent be true...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2969" },
				}
			},
		},
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

	-- @ need to refactor GetGiftLevel... or perhaps not
	GiftGivenVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.33,
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "Name" },
				IsNone =
					{
						"ZeusUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"ApolloUpgrade",
						"DemeterUpgrade",
						"AphroditeUpgrade",
						"HephaestusUpgrade",
						"DemeterUpgrade",
						"HestiaUpgrade",
						"TrialUpgrade",
						"NPC_Echo_01",
					},
			},
		},
		Cooldowns =
		{
			{ Name = "MelCauldronOpenedSpeech", Time = 20 },
		},

		-- { Cue = "/VO/Melinoe_2355", Text = "For you!" },
		-- { Cue = "/VO/Melinoe_2356", Text = "Surprise!" },
		-- { Cue = "/VO/Melinoe_2357", Text = "Got you something!" },
		-- { Cue = "/VO/Melinoe_2358", Text = "This is for you!" },
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
	LockedGiftRackVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0221", Text = "Locked.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0517", Text = "I'd better not..." },
		},
		[2] = GlobalVoiceLines.SkellyLockedReactionVoiceLines
	},
	LockedBountyBoardVoiceLines =
	{
		{
			Queue = "Always",
			RandomRemaining = true,
			PreLineWait = 0.55,
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_3081", Text = "Conceal us, O Night...", PlayFirst = true, },
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
	LockedShrineVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0576", Text = "{#Emph}Mmm..." },
		},
		[2] = GlobalVoiceLines.SkellyLockedReactionVoiceLines
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
				{ Name = "MelinoeAnyQuipSpeech" },
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

			{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}Khh." },
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

			{ Cue = "/VO/Melinoe_2958", Text = "The river's overflowed back there.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0386", Text = "I can't." },
			{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
			{ Cue = "/VO/Melinoe_0390", Text = "No use." },
			{ Cue = "/VO/Melinoe_0222", Text = "Can't." },
			{ Cue = "/VO/Melinoe_1854", Text = "Afraid not..." },
			{ Cue = "/VO/Melinoe_1855", Text = "Denied." },
			{ Cue = "/VO/Melinoe_1856", Text = "Denied..." },
		},
	},

	WeaponLobOutOfAmmoVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
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
		},
		{ Cue = "/VO/Melinoe_2744", Text = "Out of Shells.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2745", Text = "No Shells." },
		{ Cue = "/VO/Melinoe_2746", Text = "Need Shells." },
		{ Cue = "/VO/Melinoe_2747", Text = "Revaal's empty." },
	},

	UsedChronosRemainsVoiceLines =
	{
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
			RandomRemaining = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlayAll = 0.1,

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
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
	},
	KeepsakeExpiredVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.75,
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
		[1] =
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
		[2] =
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
		[3] = GlobalVoiceLines.InsufficientMetaCurrencyVoiceLines,
		[4] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
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
				RequiredMaxHealthFraction = 0.85,
			},
		},
		{ Cue = "/VO/MelinoeField_0965", Text = "Fresh out of blood...",
			GameStateRequirements = 
			{
				RequiredMaxHealthFraction = 0.85,
			},
		},
		{ Cue = "/VO/MelinoeField_0966", Text = "{#Emph}Ah{#Prev}, blast..." },
		{ Cue = "/VO/MelinoeField_0967", Text = "Some other time, Chaos..." },
		{ Cue = "/VO/MelinoeField_0968", Text = "I'm too scratched up...",
			GameStateRequirements = 
			{
				RequiredMaxHealthFraction = 0.85,
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
			ObjectType = "Hecate",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Boss01" },
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
			ObjectType = "Polyphemus",
			GameStateRequirements =
			{
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "N_Boss01" },
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
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				}
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

			{ Cue = "/VO/MelinoeField_0774", Text = "It wants some of my life essence before letting me in..." },
			{ Cue = "/VO/MelinoeField_0775", Text = "{#Emph}Gah{#Prev}, fine! It's only blood!", PreLineWait = 1.5, BreakIfPlayed = true },
		},
		Queue = "NeverQueue",
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
	},

	RunClearedVoiceLines =
	{
		Queue = "Always",
		[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
		[2] =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.15,
			GameStateRequirements =
			{
				-- None
			},

			{ Cue = "/VO/MelinoeField_1407", Text = "Suffer in darkness..." },
			{ Cue = "/VO/MelinoeField_1412", Text = "Fall, I said...!" },
			-- { Cue = "/VO/MelinoeField_1413", Text = "Fall, damn you." },
			-- { Cue = "/VO/MelinoeField_1414", Text = "Fall." },
			{ Cue = "/VO/MelinoeField_1415", Text = "What did I tell you?" },
			{ Cue = "/VO/MelinoeField_1416", Text = "For my father!" },
			{ Cue = "/VO/MelinoeField_1417", Text = "For my mother!" },
			{ Cue = "/VO/MelinoeField_1418", Text = "For my brother!" },
			{ Cue = "/VO/MelinoeField_1419", Text = "For Cerberus!" },
			{ Cue = "/VO/MelinoeField_1426", Text = "For the Underworld!" },
			{ Cue = "/VO/MelinoeField_1420", Text = "For Nyx!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1421", Text = "For Thanatos!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 5,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1422", Text = "For Hypnos!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
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
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1425", Text = "For what you did to this House!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 6,
					},
				}
			},
			{ Cue = "/VO/MelinoeField_1427", Text = "For Schelemeus!",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 10,
					},
				}
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
				{ Name = "MelinoeAnyQuipSpeech" },
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
		},
	},
	RerollOutcomeVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,
			GameStateRequirements =
			{
				-- None
			},

			{ Cue = "/VO/MelinoeField_0554", Text = "...OK." },
			{ Cue = "/VO/MelinoeField_0555", Text = "...There." },
			{ Cue = "/VO/MelinoeField_0557", Text = "...Good." },
			{ Cue = "/VO/MelinoeField_0559", Text = "It's done." },
			{ Cue = "/VO/MelinoeField_0561", Text = "{#Emph}Huh!" },
		},
	},

	UsedRerollPanelVoiceLines =
	{
		{
			BreakIfPlayed = true,
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
			CooldownTime = 10,

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
				IsNone = { "F_MiniBoss01", "F_MiniBoss02", "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
			},
			RequiredMinHealthFraction = 0.25,
		},
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelinoeCastSpeech", Time = 300 },
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
			SuccessiveChanceToPlay = 0.05,
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
			SuccessiveChanceToPlay = 0.05,
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
			SuccessiveChanceToPlay = 0.05,
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
			{ Cue = "/VO/MelinoeField_0705", Text = "{#Emph}Augh! {#Prev}Not.... yet!" },
			{ Cue = "/VO/MelinoeField_0706", Text = "{#Emph}Ungh! {#Prev}All right!" },
			{ Cue = "/VO/MelinoeField_0708", Text = "How about {#Emph}this...!" },
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

	BlockDeathVoiceLines =
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
			PreLineWait = 0.65,
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_2001", Text = "It's not my time just yet...!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2002", Text = "If I could just...!" },
			{ Cue = "/VO/Melinoe_2003", Text = "I can hold on, I--!" },
			{ Cue = "/VO/Melinoe_2004", Text = "It's now or never...!" },
			{ Cue = "/VO/Melinoe_2005", Text = "Forestall my doom...!" },
			{ Cue = "/VO/Melinoe_2006", Text = "My doom forestalled again...!" },
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
				RequiredMaxHealthFraction = 0.75,
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
				},
				RequiredMinHealthFraction = 0.2,
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
						Path = { "GameState", "RoomCountCache", "H_Boss01" },
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
		[2] = GlobalVoiceLines.CombatResolvedVoiceLines,
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
					IsNone = {
						"F_Boss01", "F_Reprieve01", "F_Shop01",
						"G_Boss01", "G_Reprieve01", "G_Shop01",
						"H_Boss01", "H_Reprieve01", "H_Shop01",
						"I_Boss01", "I_Reprieve01", "I_Shop01",
						"N_Boss01", "N_Reprieve01", "N_Shop01",
						"O_Boss01", "O_Reprieve01", "O_Shop01",
						"P_Boss01", "P_Reprieve01", "P_Shop01",
						"Q_Boss01", "Q_Reprieve01", "Q_Shop01",
						"F_PreBoss01", "G_PreBoss01", "N_PreBoss01",
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
				RequiredMaxHealthFraction = 0.33,
				RequiredMaxLastStands = 0,
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
					IsNone = { "G_Intro", "G_Story01", "G_Boss01" },
				},
				RequiredMinHealthFraction = 0.2,
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
					IsNone = { "G_Intro", "G_Story01", "G_Boss01" },
				},
				RequiredMinHealthFraction = 0.2,
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
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01" },
				},
				RequiredMinHealthFraction = 0.2,
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
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01" },
				},
				RequiredMinHealthFraction = 0.2,
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
				IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01" },
			},
			RequiredMinHealthFraction = 0.2,
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
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_PreBoss01", "O_Boss01" },
				},
				RequiredMinHealthFraction = 0.2,
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
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_Shop01", "O_PreBoss01", "O_Boss01" },
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
					IsNone = { "O_Intro", "O_Story01", "O_Reprieve01", "O_Shop01", "O_PreBoss01", "O_Boss01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2" },
				},
				RequiredMinHealthFraction = 0.2,
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
				RequiredMinHealthFraction = 0.15,
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
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "O_Story01" },
				},
				RequiredMinHealthFraction = 0.15,
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
				RequiredMinHealthFraction = 0.2,
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

	NextWaveVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG", "ArtemisCombatN", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "HeraclesCombatN", "DevotionTestF", "DevotionTestG", "DevotionTestN", "BossHecate01", "BossPolyphemus01", "BossScylla01", "BossInfestedCerberus01", "BossChronos01" },
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
				IsNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG" },
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

	AnomalySearchingForExitVoiceLines =
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
				PathTrue = { "GameState", "EncountersCompletedCache", "GeneratedAnomalyB"}
			},
		},
		Cooldowns =
		{
			{ Name = "AnomalyVOPlayed", Time = 4 },
		},

		{ Cue = "/VO/MelinoeField_0197", Text = "Must be a way out." },
		{ Cue = "/VO/MelinoeField_0198", Text = "Won't be staying long..." },
		{ Cue = "/VO/MelinoeField_0199", Text = "Need to get out...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0200", Text = "He can't contain me here..." },
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
		[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
		[2] =
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
					MinRunsSinceAnyTextLines = { TextLines = { "HecateBossOutro01" }, Count = 6 },
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
					Value = 5,
				},
				{
					PathFalse = { "CurrentRun", "ActiveBounty" },
				},
				{
					Path = { "GameState", "EnemyKills", "Hecate" },
					Comparison = "<=",
					Value = 6,
				},
			},

			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.25,
			SuccessiveChanceToPlay = 0.25,
			Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
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
			PreLineWait = 0.55,
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
			{ Cue = "/VO/Skelly_0385", Text = "Ain't she a beaut?", PlayFirst = true },
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
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentLootData", "HasExchange" },
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
			RequiredSwappedGodLoot = "ZeusUpgrade",
			CooldownName = "SaidZeusRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredSwappedGodLoot = "PoseidonUpgrade",
			CooldownName = "SaidPoseidonRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredSwappedGodLoot = "AphroditeUpgrade",
			CooldownName = "SaidAphroditeRecently",
			CooldownTime = 40,

			-- TKTK
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredSwappedGodLoot = "DemeterUpgrade",
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
			GameStateRequirements =
			{
				{
					--
				},
				RequiresLastUpgradeSwapped = true,
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
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlay = 0.25,
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
					IsNone = { "ArtemisCombatN", "HeraclesCombatN" },
				},
			},
			ThreadName = "RoomThread",
			Cooldowns =
			{
				{ Name = "NCombatResolvedSpeech", Time = 120 },
			},

			{ Cue = "/VO/MelinoeField_0410", Text = "Should head back out..." },
			{ Cue = "/VO/MelinoeField_0411", Text = "Think I'm finished here." },
			{ Cue = "/VO/MelinoeField_0412", Text = "Done here." },
			{ Cue = "/VO/MelinoeField_0413", Text = "Now to head back." },
			{ Cue = "/VO/Melinoe_1378", Text = "Should head to the main square.", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_1379", Text = "Shall we head back, Homer?", ChanceToPlay = 0.05 },
		},
		[2] = GlobalVoiceLines.StorytellerFightReactionVoiceLines,
	},

	UpgradePickedVoiceLines =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "TestAllThings", "N_Story01" },
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
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.5,
			PreLineWait = 0.35,
			PreLineAnim = "Artemis_Blessing",
			ObjectType = "NPC_Artemis_Field_01",
			GameStateRequirements =
			{

				{
					Path = { "CurrentLootData", "Name" },
					IsNone = { "StackUpgrade" },
				},
			},

			{ Cue = "/VO/Artemis_0117", Text = "Very well." },
			{ Cue = "/VO/Artemis_0118", Text = "There." },
			-- { Cue = "/VO/Artemis_0119", Text = "The will of the huntress." },
			{ Cue = "/VO/Artemis_0120", Text = "My blessing is yours.", PlayFirst = true },
			{ Cue = "/VO/Artemis_0121", Text = "Then it's yours." },
			{ Cue = "/VO/Artemis_0122", Text = "My mark be with you." },
			{ Cue = "/VO/Artemis_0123", Text = "My mark is yours." },
			{ Cue = "/VO/Artemis_0124", Text = "My strength is yours." },
			{ Cue = "/VO/Artemis_0125", Text = "Together we shine." },
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
			{ Cue = "/VO/MelinoeField_1599", Text = "{#Emph}Ngh! {#Prev}Lord Uncle's Titan-killing strength...!",
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
			{ Cue = "/VO/MelinoeField_0641", Text = "Her Majesty the Queen is with me now." ,
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
			{ Cue = "/VO/Melinoe_0635", Text = "May all our enemies drown.", 
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
			{ Cue = "/VO/Melinoe_0643", Text = "I've much to learn from her I think...", 
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
			{ Cue = "/VO/Melinoe_0649", Text = "Grandmother...", 
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
			{ Cue = "/VO/Melinoe_0942", Text = "My silver all grew stronger, didn't it...", 
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
			{ Cue = "/VO/Melinoe_0646", Text = "{#Emph}Whew{#Prev}, that almost burns...", 
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
			{ Cue = "/VO/Melinoe_0945", Text = "Now we make haste.",
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

		},
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.1,
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
			{ Cue = "/VO/Melinoe_1486", Text = "Can never get accustomed to this light..." },
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			{ Cue = "/VO/Melinoe_1527", Text = "Let's get them, Auntie.",
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
			SuccessiveChanceToPlay = 0.5,
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
			SuccessiveChanceToPlay = 0.5,
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
			-- { Cue = "/VO/Melinoe_1531", Text = "Keep up, Homer." },
			{ Cue = "/VO/Melinoe_1532", Text = "Time to send a message..." },
			{ Cue = "/VO/Melinoe_1533", Text = "Let's pick up the pace." },
		},
		{
			-- Hades
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
				PreLineAnim = "Hades_Blessing",
				ObjectType = "NPC_Hades_Field_01",

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
			}
		},
		-- Poms
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
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
		},		
		[15] = GlobalVoiceLines.StorytellerFightReactionVoiceLines,
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
				IsNone = { "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
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
					IsAny = { "ElementalDamageCapBoon" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0298", Text = "The rush of air...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalDodgeBoon" },
				}
			},
		},
		{ Cue = "/VO/MelinoeField_0299", Text = "The will of water...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "LastActivatedElementalTrait" },
					IsAny = { "ElementalHealthBoon" },
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
		{ Cue = "/VO/MelinoeField_0303", Text = "My elemental strength..." },
		{ Cue = "/VO/MelinoeField_0304", Text = "The elements escape..." },
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
				IsAny = { "H_Bridge01", "H_PreBoss01" },
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
					IsNone = { "GeneratedAnomalyB", "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "IcarusCombatO", "IcarusCombatO2" },
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.7,
				Cooldowns =
				{
					{ Name = "MelinoeChaosBoonTransformSpeech", Time = 120 },
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
	PerfectClearDamageBonusUpgradedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.7,
		SuccessiveChanceToPlay = 0.2,
		CooldownTime = 200,

		GameStateRequirements =
		{
			--
		},

		-- TKTK
	},
	FastClearDodgeBonusUpgradedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.7,
		SuccessiveChanceToPlay = 0.2,

		GameStateRequirements =
		{
			--
		},

		-- TKTK
	},
	KeepsakeChallengeFailedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.2,
		Cooldowns =
		{
			--
		},

		-- TKTK
	},

	BiomeTimerAboutToExpireVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
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
	BiomeTimerExpiredVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
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
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},

			{ Cue = "/VO/MelinoeField_0354", Text = "...Through... all... that...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0355", Text = "...It's... too... far...", PlayFirst = true },
		},
		{
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "NOverlookVO",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.55,
			SuccessiveChanceToPlayAll = 0.5,
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

			{ Cue = "/VO/Melinoe_1336", Text = "Have to get out of this damned city..." },
			{ Cue = "/VO/Melinoe_1337", Text = "From the docks I can find a ship to cross the rift...", PreLineWait = 0.9 },
			{ Cue = "/VO/Melinoe_1338", Text = "Should be able to reach Olympus from there.", PreLineWait = 0.9, BreakIfPlayed = true, },
			{ Cue = "/VO/MelinoeField_0356", Text = "No way around the city... have to get through...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0357", Text = "{#Emph}...Follow the River Acheron, beyond the necropolis..." },
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
			{ Cue = "/VO/MelinoeField_0360", Text = "Looks almost peaceful from afar..." },
			{ Cue = "/VO/MelinoeField_0361", Text = "Can't quite see the docks from here..." },
		},
		{
			PreLineWait = 1.55,
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
			},
			{ Cue = "/VO/MelinoeField_1739", Text = "Warships risen from the depths... all headed for Olympus.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1740", Text = "Beyond this rift, the mountain of the gods..." },
			{ Cue = "/VO/MelinoeField_1741", Text = "Just a little night sea journey... what's to fear?" },
			{ Cue = "/VO/MelinoeField_1742", Text = "Too far to swim... but all those ships out there are swift..." },
			{ Cue = "/VO/MelinoeField_2059", Text = "As soon as one ship sinks, another rises from the depths..." },
			{ Cue = "/VO/MelinoeField_2060", Text = "Such a strange and awful fleet that Chronos has..." },
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
			},

			{ Cue = "/VO/MelinoeField_0135", Text = "Beyond lies Uncle Poseidon's realm..." },
			{ Cue = "/VO/MelinoeField_0136", Text = "Countless dead ends... one way through...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0137", Text = "All that metal holds the very sea at bay..." },
			{ Cue = "/VO/MelinoeField_0138", Text = "Each chamber here leads to a deeper one..." },
			{ Cue = "/VO/MelinoeField_0139", Text = "Wonder what other terrors lurk within the sea..." },
			{ Cue = "/VO/MelinoeField_0140", Text = "The peerless work of Master Daedalus..." },
			{ Cue = "/VO/MelinoeField_0141", Text = "To think this is a safer path than through Elysium..." },
		},
		{
			PreLineWait = 1.55,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "HOverlookVO",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_Intro" },
				},
				RequiredUnitsNotAlive = { "NPC_Eris_01" },
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
			SuccessiveChanceToPlayAll = 0.1,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "PreRunOverlookVO",
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

			{ Cue = "/VO/Melinoe_0869", Text = "I'll get through all that gloom somehow." },
			{ Cue = "/VO/Melinoe_0870", Text = "Below, the path to Tartarus. Above, the way to Olympus.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor", },
					},
				}
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
		PlayOnce = true,
		PreLineWait = 1.05,
		Queue = "Interrupt",

		-- TKTK
	},
	UsedFamilyPortraitVoiceLines =
	{
		-- @ update with additional requirements
		{
			Queue = "Interrupt",
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.85,
			SuccessiveChanceToPlayAll = 0.1,
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "FamilyPortraitVO",
			TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/Melinoe_2932", Text = "This old unfinished painting... don't look away. Don't forget all that the Titan took from you.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2942", Text = "This family... lost to you since you were born. They deserve their vengeance, and so do you." },
			{ Cue = "/VO/Melinoe_3162", Text = "Chronos threatened that you'd never see your family again, the wretch. Well here they are, no closer than before.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2934", Text = "This memory of all you lost... it stokes your want for vengeance even now.",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2932" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2936", Text = "They were all so happy together, weren't they? And oblivious to the Titan's threat...",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2932" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2935", Text = "One of these nights you ought to ask Headmistress how she got this from the House.",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
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
							"SkellyAboutZagreus01"
						},
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
				},
			},
			{ Cue = "/VO/Melinoe_2937", Text = "The Titan has your family in his thrall, or worse... what has he done with them?",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2932" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2933", Text = "Father... Mother... Brother... please be safe. Please...", PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
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
				},
			},
			{ Cue = "/VO/Melinoe_2941", Text = "{#Emph}All that you lost is all that you are{#Prev}, as Headmistress would say...",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2943", Text = "You don't remember them, besides this painting and your dreams. But still you fight for them...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 5,
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

			{ Cue = "/VO/Melinoe_2944", Text = "{#Emph}<Sigh>" },
			{ Cue = "/VO/Melinoe_2945", Text = "{#Emph}<Sigh>" },
			{ Cue = "/VO/Melinoe_1607", Text = "Vengeance for my family." },
			{ Cue = "/VO/Melinoe_0347", Text = "Vengeance for my father." },
			-- { Cue = "/VO/Melinoe_0121", Text = "Hold on, everyone." },
		},
	},

	PetCerberusVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "PetCerberusSpeechPlayed", Time = 15 },
			},

			-- TKTK (Cerberus trusts no one!)
		},
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
			PreLineWait = 0.65,
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

	ChamberMoverUsedVoiceLines =
	{
		GameStateRequirements =
		{
			-- None
		},
		TriggerCooldowns = { Name = "MelinoeAnyQuipSpeech" },
		{
			RandomRemaining = true,
			PreLineWait = 0.35,

			{ Cue = "/VO/MelinoeField_1319", Text = "Central Control... just need a moment.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1321", Text = "Just a few chambers to the House..." },
			{ Cue = "/VO/MelinoeField_1322", Text = "Should be a clear path to the House." },
			{ Cue = "/VO/MelinoeField_1323", Text = "They'll know I'm here..." },
			{ Cue = "/VO/MelinoeField_1275", Text = "It worked..." },
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
			{ Name = "ZagreusStartedFishingSpeech", Time = 5 },
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
	FishHookedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		-- SuccessiveChanceToPlay = 0.85,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			-- { Name = "MelinoeFishHookedSpeech", Time = 5 },
		},

		{ Cue = "/VO/MelinoeField_1346", Text = "Got a bite!" },
		{ Cue = "/VO/MelinoeField_1347", Text = "It's a bite!" },
		{ Cue = "/VO/MelinoeField_1348", Text = "Hooked one!" },
		{ Cue = "/VO/MelinoeField_1349", Text = "On the hook!" },
		{ Cue = "/VO/MelinoeField_1350", Text = "Here we go!" },
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
					HasAny = { "HecateFishing01" },
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
					HasAny = { "OdysseusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Odysseus_0072", Text = "Where are they...", PlayFirst = true },
			{ Cue = "/VO/Odysseus_0073", Text = "Wait for it..." },
			{ Cue = "/VO/Odysseus_0074", Text = "Is that...?" },
			{ Cue = "/VO/Odysseus_0075", Text = "Steady now..." },
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
	},
	FishNotCaughtVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Hecate_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "HecateFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Hecate_0390", Text = "{#Emph}Mm, tsk-tsk-tsk." },
			{ Cue = "/VO/Hecate_0391", Text = "Alas." },
			{ Cue = "/VO/Hecate_0392", Text = "Merely a lesson learned.", PlayFirst = true },
			{ Cue = "/VO/Hecate_0393", Text = "Outmaneuvered..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
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

			{ Cue = "/VO/Dora_0095", Text = "Oof. Sorry.", PlayFirst = true },
			{ Cue = "/VO/Dora_0096", Text = "Bummer..." },
			{ Cue = "/VO/Dora_0097", Text = "Missed 'em, huh." },
			{ Cue = "/VO/Dora_0098", Text = "All that for nothing." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Odysseus_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "OdysseusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Odysseus_0080", Text = "Alas..." },
			{ Cue = "/VO/Odysseus_0081", Text = "That blasted...", PlayFirst = true },
			{ Cue = "/VO/Odysseus_0082", Text = "{#Emph}Nrgh..." },
			{ Cue = "/VO/Odysseus_0083", Text = "Ah well..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
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

			{ Cue = "/VO/Moros_0356", Text = "{#Emph}Ah... {#Prev}my regrets." },
			{ Cue = "/VO/Moros_0357", Text = "Outmaneuvered..." },
			{ Cue = "/VO/Moros_0358", Text = "They are quick..." },
			{ Cue = "/VO/Moros_0359", Text = "How inopportune...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
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

			{ Cue = "/VO/Nemesis_0194", Text = "Could've caught it." },
			{ Cue = "/VO/Nemesis_0195", Text = "Empty-handed." },
			{ Cue = "/VO/Nemesis_0196", Text = "Caught out." },
			{ Cue = "/VO/Nemesis_0197", Text = "No fair, right?", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Narcissus_01",

			{ Cue = "/VO/Narcissus_0167", Text = "Just the way it is..." },
			{ Cue = "/VO/Narcissus_0168", Text = "Just didn't like you." },
			{ Cue = "/VO/Narcissus_0169", Text = "The one that got away...", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0170", Text = "Didn't work out, huh?" },
			{ Cue = "/VO/Narcissus_0171", Text = "Stop disturbing the water!" },
			{ Cue = "/VO/Narcissus_0172", Text = "Plenty of fish... {#Emph}in the sea!" },
			{ Cue = "/VO/Narcissus_0173", Text = "{#Emph}Aw{#Prev}, too bad." },
			{ Cue = "/VO/Narcissus_0174", Text = "You have to let it go..." },
			{ Cue = "/VO/Narcissus_0175", Text = "Just wasn't meant to be." },
			{ Cue = "/VO/Narcissus_0176", Text = "You'll find the one someday." },
			{ Cue = "/VO/Narcissus_0177", Text = "I'm really sad for you." },
			{ Cue = "/VO/Narcissus_0178", Text = "Just wasn't into you." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
					IsAny = { "SpellDrop" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "G", "H", "I", },
				},
			},

			{ Cue = "/VO/Selene_0304", Text = "I saw nothing at all." },
			{ Cue = "/VO/Selene_0305", Text = "No reason for despair." },
			{ Cue = "/VO/Selene_0306", Text = "Some other night perhaps." },
			{ Cue = "/VO/Selene_0307", Text = "It was too swift..." },
			{ Cue = "/VO/Selene_0308", Text = "Eluded..." },
			{ Cue = "/VO/Selene_0309", Text = "Outmaneuvered..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 0.33,
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
		{
			RandomRemaining = true,
			ChanceToPlay = 0.33,
			PreLineWait = 0.41,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos" },
				},
			},

			{ Cue = "/VO/Chaos_0187", Text = "Your efforts were in vain." },
			{ Cue = "/VO/Chaos_0188", Text = "An acceptable loss." },
			{ Cue = "/VO/Chaos_0189", Text = "Perhaps the Fates desired this.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0190", Text = "An unsuccessful attempt." },
		}
	},
	FishNotCaughtTooLateVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
			ObjectType = "NPC_Hecate_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "HecateFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Hecate_0390", Text = "{#Emph}Mm, tsk-tsk-tsk." },
			{ Cue = "/VO/Hecate_0391", Text = "Alas." },
			{ Cue = "/VO/Hecate_0392", Text = "Merely a lesson learned.", PlayFirst = true },
			{ Cue = "/VO/Hecate_0393", Text = "Outmaneuvered..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Dora_0095", Text = "Oof. Sorry.", PlayFirst = true },
			{ Cue = "/VO/Dora_0096", Text = "Bummer..." },
			{ Cue = "/VO/Dora_0097", Text = "Missed 'em, huh?" },
			{ Cue = "/VO/Dora_0098", Text = "All that for nothing." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
			ObjectType = "NPC_Odysseus_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "OdysseusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Odysseus_0080", Text = "Alas..." },
			{ Cue = "/VO/Odysseus_0081", Text = "That blasted...", PlayFirst = true },
			{ Cue = "/VO/Odysseus_0082", Text = "{#Emph}Ngh..." },
			{ Cue = "/VO/Odysseus_0083", Text = "Ah, well..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Nemesis_0194", Text = "Could've caught it." },
			{ Cue = "/VO/Nemesis_0195", Text = "Empty-handed." },
			{ Cue = "/VO/Nemesis_0196", Text = "Caught out." },
			{ Cue = "/VO/Nemesis_0197", Text = "No fair, right?", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Moros_0356", Text = "{#Emph}Ah... {#Prev}my regrets." },
			{ Cue = "/VO/Moros_0357", Text = "Outmaneuvered..." },
			{ Cue = "/VO/Moros_0358", Text = "They are quick..." },
			{ Cue = "/VO/Moros_0359", Text = "How inopportune...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Narcissus_01",

			{ Cue = "/VO/Narcissus_0167", Text = "Just the way it is..." },
			{ Cue = "/VO/Narcissus_0168", Text = "Just didn't like you." },
			{ Cue = "/VO/Narcissus_0169", Text = "The one that got away...", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0170", Text = "Didn't work out, huh?" },
			{ Cue = "/VO/Narcissus_0171", Text = "Stop disturbing the water!" },
			{ Cue = "/VO/Narcissus_0172", Text = "Plenty of fish... {#Emph}in the sea!" },
			{ Cue = "/VO/Narcissus_0173", Text = "{#Emph}Aw{#Prev}, too bad." },
			{ Cue = "/VO/Narcissus_0174", Text = "You have to let it go..." },
			{ Cue = "/VO/Narcissus_0175", Text = "Just wasn't meant to be." },
			{ Cue = "/VO/Narcissus_0176", Text = "You'll find the one someday." },
			{ Cue = "/VO/Narcissus_0177", Text = "I'm really sad for you." },
			{ Cue = "/VO/Narcissus_0178", Text = "Just wasn't into you." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
					IsAny = { "SpellDrop" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "G", "H", "I", },
				},
			},

			{ Cue = "/VO/Selene_0304", Text = "I saw nothing at all." },
			{ Cue = "/VO/Selene_0305", Text = "No reason for despair." },
			{ Cue = "/VO/Selene_0306", Text = "Some other night perhaps." },
			{ Cue = "/VO/Selene_0307", Text = "It was too swift..." },
			{ Cue = "/VO/Selene_0308", Text = "Eluded..." },
			{ Cue = "/VO/Selene_0309", Text = "Outmaneuvered..." },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			AllowTalkOverTextLines = true,
			PreLineWait = 0.33,
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
			PreLineWait = 2,
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
		{
			RandomRemaining = true,
			ChanceToPlay = 0.33,
			PreLineWait = 0.41,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos" },
				},
			},

			{ Cue = "/VO/Chaos_0187", Text = "Your efforts were in vain." },
			{ Cue = "/VO/Chaos_0188", Text = "An acceptable loss." },
			{ Cue = "/VO/Chaos_0189", Text = "Perhaps the Fates desired this.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0190", Text = "An unsuccessful attempt." },
		}
	},
	FishNotCaughtWayTooLateVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
			ObjectType = "NPC_Hecate_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "HecateFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Hecate_0390", Text = "{#Emph}Mm, tsk-tsk-tsk." },
			{ Cue = "/VO/Hecate_0391", Text = "Alas." },
			{ Cue = "/VO/Hecate_0392", Text = "Merely a lesson learned.", PlayFirst = true },
			{ Cue = "/VO/Hecate_0393", Text = "Outmaneuvered..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Dora_0095", Text = "Oof. Sorry.", PlayFirst = true },
			{ Cue = "/VO/Dora_0096", Text = "Bummer..." },
			{ Cue = "/VO/Dora_0097", Text = "Missed 'em, huh?" },
			{ Cue = "/VO/Dora_0098", Text = "All that for nothing." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
			ObjectType = "NPC_Odysseus_01",
			AllowTalkOverTextLines = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "OdysseusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/Odysseus_0080", Text = "Alas..." },
			{ Cue = "/VO/Odysseus_0081", Text = "That blasted...", PlayFirst = true },
			{ Cue = "/VO/Odysseus_0082", Text = "{#Emph}Ngh..." },
			{ Cue = "/VO/Odysseus_0083", Text = "Ah, well..." },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Nemesis_0194", Text = "Could've caught it." },
			{ Cue = "/VO/Nemesis_0195", Text = "Empty-handed." },
			{ Cue = "/VO/Nemesis_0196", Text = "Caught out." },
			{ Cue = "/VO/Nemesis_0197", Text = "No fair, right?", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.33,
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

			{ Cue = "/VO/Moros_0356", Text = "{#Emph}Ah... {#Prev}my regrets." },
			{ Cue = "/VO/Moros_0357", Text = "Outmaneuvered..." },
			{ Cue = "/VO/Moros_0358", Text = "They are quick..." },
			{ Cue = "/VO/Moros_0359", Text = "How inopportune...", PlayFirst = true },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			ObjectType = "NPC_Narcissus_01",

			{ Cue = "/VO/Narcissus_0167", Text = "Just the way it is..." },
			{ Cue = "/VO/Narcissus_0168", Text = "Just didn't like you." },
			{ Cue = "/VO/Narcissus_0169", Text = "The one that got away...", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0170", Text = "Didn't work out, huh?" },
			{ Cue = "/VO/Narcissus_0171", Text = "Stop disturbing the water!" },
			{ Cue = "/VO/Narcissus_0172", Text = "Plenty of fish... {#Emph}in the sea!" },
			{ Cue = "/VO/Narcissus_0173", Text = "{#Emph}Aw{#Prev}, too bad." },
			{ Cue = "/VO/Narcissus_0174", Text = "You have to let it go..." },
			{ Cue = "/VO/Narcissus_0175", Text = "Just wasn't meant to be." },
			{ Cue = "/VO/Narcissus_0176", Text = "You'll find the one someday." },
			{ Cue = "/VO/Narcissus_0177", Text = "I'm really sad for you." },
			{ Cue = "/VO/Narcissus_0178", Text = "Just wasn't into you." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Reward", "Name" },
					IsAny = { "SpellDrop" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "G", "H", "I", },
				},
			},

			{ Cue = "/VO/Selene_0304", Text = "I saw nothing at all." },
			{ Cue = "/VO/Selene_0305", Text = "No reason for despair." },
			{ Cue = "/VO/Selene_0306", Text = "Some other night perhaps." },
			{ Cue = "/VO/Selene_0307", Text = "It was too swift..." },
			{ Cue = "/VO/Selene_0308", Text = "Eluded..." },
			{ Cue = "/VO/Selene_0309", Text = "Outmaneuvered..." },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "FishingInput", },
				},
			},
			Cooldowns =
			{
			},

			{ Cue = "/VO/MelinoeField_1357", Text = "Come back...!" },
			{ Cue = "/VO/MelinoeField_1358", Text = "Wait...!" },
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
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos" },
				},
			},

			{ Cue = "/VO/Chaos_0187", Text = "Your efforts were in vain." },
			{ Cue = "/VO/Chaos_0188", Text = "An acceptable loss." },
			{ Cue = "/VO/Chaos_0189", Text = "Perhaps the Fates desired this.", PlayFirst = true },
			{ Cue = "/VO/Chaos_0190", Text = "An unsuccessful attempt." },
		}
	},

	ShadeEavesdropVoiceLines =
	{
		UsePlayerSource = true,
		{
			PreLineWait = 0.3,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PlayOnceThisRun = true,
			-- RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.33,
			GameStateRequirements = 
			{
				--[[
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun" },
				},
				]]--
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

			{ Cue = "/VO/Melinoe_2321", Text = "Hold fast to hope, good Shade.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_2322", Text = "Moonlight guide you, good Shade." },
			{ Cue = "/VO/Melinoe_2324", Text = "We shall prevail; I swear it." },
			{ Cue = "/VO/Melinoe_2323", Text = "Listen well to the Commander, all right?",
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2319", Text = "We're going to find him. I swear it.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_2320", Text = "Have faith in him for me.",
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun" },
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
					PathTrue = { "CurrentRun", "ExorcismSuccesses" },
				},
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "Name" },
					IsAny = { "GhostRecruit" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeShadeInteractVoiceLines", Time = 4 },
			},

			{ Cue = "/VO/Melinoe_1713", Text = "I see you found your way from Erebus." },
			{ Cue = "/VO/Melinoe_1714", Text = "You found us after all." },
			{ Cue = "/VO/Melinoe_1715", Text = "I'm pleased to see you made it here.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1716", Text = "Welcome to your new abode." },
			{ Cue = "/VO/Melinoe_2433", Text = "I see you found your way." },
			{ Cue = "/VO/Melinoe_2434", Text = "I knew you'd make it here." },
			{ Cue = "/VO/Melinoe_2435", Text = "Welcome to your new home." },
			{ Cue = "/VO/Melinoe_2436", Text = "Hey I remember you...!" },
			{ Cue = "/VO/Melinoe_2437", Text = "You made it safe and sound." },
			{ Cue = "/VO/Melinoe_2438", Text = "Please make yourself at home." },
			-- @ update requirements
			{ Cue = "/VO/Melinoe_3557", Text = "Not quite as damp as Oceanus here, is it?",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3558", Text = "You made it from Oceanus, good...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3559", Text = "Much better off here than the Mourning Fields.",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "H" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3560", Text = "You found your way here from the Fields...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "H" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3561", Text = "I'm glad you're out of Tartarus at last.",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "I" },
					},
				},
			},
			{ Cue = "/VO/Melinoe_3562", Text = "I think you'll like it better here than Tartarus...",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "I" },
					},
				},
			},

		},
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
			-- { Cue = "/VO/Melinoe_0343", Text = "Spirits of the Crossroads, I salute thee." },
			{ Cue = "/VO/Melinoe_0342", Text = "Shades of the Crossroads, greetings." },
			{ Cue = "/VO/Melinoe_0344", Text = "Hail, Shades!" },
			{ Cue = "/VO/Melinoe_0345", Text = "Hail, O Spirits!" },
			{ Cue = "/VO/Melinoe_0346", Text = "Stay strong, my friends." },
			{ Cue = "/VO/Melinoe_0347", Text = "Vengeance for my father." },
			{ Cue = "/VO/Melinoe_0348", Text = "Welcome to the Crossroads, Shade." },
			{ Cue = "/VO/Melinoe_0349", Text = "You are welcome here and you are safe." },
			{ Cue = "/VO/Melinoe_1698", Text = "Salutations." },
			{ Cue = "/VO/Melinoe_1699", Text = "Salutations!" },
			{ Cue = "/VO/Melinoe_1700", Text = "Death to Chronos!" },
			{ Cue = "/VO/Melinoe_1701", Text = "Moonlight guide you." },
			{ Cue = "/VO/Melinoe_1702", Text = "Moonlight guide you, Shades." },
			{ Cue = "/VO/Melinoe_1703", Text = "May moonlight guide you." },
			{ Cue = "/VO/Melinoe_1704", Text = "Moonlight guide us." },
			{ Cue = "/VO/Melinoe_1705", Text = "May moonlight guide us." },
		},
	},

	-- Interaction Events
	WeaponUpgradeLockedVoiceLines =
	{
		[1] = GlobalVoiceLines.NotEnoughSuperLockKeysVoiceLines,
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

	-- Bounty Board
	BountyBoardOpenedVoiceLines =
	{
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
		-- Chaos Missions
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "ActiveBounty" },
				},
			},

			{ Cue = "/VO/MelinoeField_2040", Text = "Experiment complete?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2041", Text = "Did you see that, Chaos...?", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2042", Text = "I did as Chaos asked.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2043", Text = "Return to shadow, now...?" },
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
			-- SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.51,
			Source = { LineHistoryName = "NPC_Chaos_01", SubtitleColor = Color.ChaosVoice },
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "ActiveBounty" },
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGift02" },
				},
			},
			Cooldowns =
			{
				{ Name = "ChaosSpokeRecently", Time = 30 },
			},

			{ Cue = "/VO/Chaos_0252", Text = "After such a simple Trial, surely you would attempt another?",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyChaosIntro" },
					},
				},
			},
			{ Cue = "/VO/Chaos_0121", Text = "I have observed all that I wish for now." },
			{ Cue = "/VO/Chaos_0122", Text = "This facet of reality is clearer to me now." },
			{ Cue = "/VO/Chaos_0123", Text = "Thus you have proven that this possibility exists." },
			{ Cue = "/VO/Chaos_0124", Text = "All this was a mere possibility before." },
			{ Cue = "/VO/Chaos_0125", Text = "I am grateful, though that shall be all for now." },
			{ Cue = "/VO/Chaos_0126", Text = "This particular experiment was a success." },
			{ Cue = "/VO/Chaos_0127", Text = "A mere thought, turned into a real possibility." },
			{ Cue = "/VO/Chaos_0128", Text = "The bounds of what is possible continue to expand." },
			{ Cue = "/VO/Chaos_0129", Text = "This was a chance I trust was well worth taking." },
			{ Cue = "/VO/Chaos_0130", Text = "I was sufficiently amused by your attempt." },
			{ Cue = "/VO/Chaos_0253", Text = "May my Star Dust compensate you for your services." },
			{ Cue = "/VO/Chaos_0254", Text = "This Trial is complete; I bid you return whence you came." },
			{ Cue = "/VO/Chaos_0255", Text = "I have observed the outcome of this Trial with keen interest." },
			{ Cue = "/VO/Chaos_0256", Text = "You may go no further; that is all part of the Trial." },
			{ Cue = "/VO/Chaos_0257", Text = "I am satisfied with the results of this Trial, and bid you return." },
			{ Cue = "/VO/Chaos_0258", Text = "You have accomplished what this Trial asked of you." },
			{ Cue = "/VO/Chaos_0259", Text = "I did not necessarily expect that you would pass this Trial." },
			{ Cue = "/VO/Chaos_0260", Text = "Another Trial successfully completed, Spawn of Hades." },
			{ Cue = "/VO/Chaos_0261", Text = "You passed; but now return to shadow, Spawn of Hades." },
		},
	},
	ReceivedSupplyDropVoiceLines =
	{
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

GameOutroPriorities =
{
	"Outro_TechTest01",
	"Outro_TechTest02",
	{
		"Outro_TechTest04",
		"Outro_TechTest06",
	},
	"Outro_TechTest03",
	"Outro_TechTest05",

	"Outro_EarlyEnd01",
	"Outro_EarlyEnd_Fate",
	"Outro_EarlyEnd02",
	{
		"Outro_EarlyEnd_Strife",
		"Outro_EarlyEnd_Surface",
	},
	{
		"Outro_EarlyEnd_Olympus01",
		"Outro_EarlyEnd_Summit",
		"Outro_EarlyEnd_Heart",
		"Outro_EarlyEnd_Guardian",
	},
	{
		"Outro_EarlyEnd_Foes",
		"Outro_EarlyEnd_Precarious",
		"Outro_EarlyEnd_Unimaginable",
		"Outro_EarlyEnd_Goal",
		"Outro_EarlyEnd_Night",
	},
	{
		"Outro_EarlyEnd01b",
		"Outro_EarlyEnd03",
		"Outro_EarlyEnd01c",
		"Outro_EarlyEnd07",
		"Outro_EarlyEnd11",
	},
	{
		"Outro_EarlyEnd04",
		"Outro_EarlyEnd05",
		"Outro_EarlyEnd09",
	},
	{
		"Outro_EarlyEnd06",
		"Outro_EarlyEnd08",
		"Outro_EarlyEnd10",
		"Outro_EarlyEnd_Cliffhanger",
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
		"Outro_EarlyEnd_Forgotten",
		"Outro_EarlyEnd_Reasoning",
		"Outro_EarlyEnd_Ambiguity",
		"Outro_EarlyEnd_Mystery",
		"Outro_EarlyEnd_Horror",
		"Outro_EarlyEnd_Adversary",
		"Outro_EarlyEnd_Feud",
		"Outro_EarlyEnd_Epic",
		"Outro_EarlyEnd_Home",
		"Outro_EarlyEnd_Unpleasant",
	},
}

-- Early Access Endings (see: GameOutroPriorities)
GameOutroData =
{
	-- testing
	-- Technical Test
	Outro_TechTest01 =
	{
		PlayOnce = true,
		FadeOutWait = 27.7,
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
			{ Cue = "/VO/Storyteller_0274", Text = "Thus did Melinoë, the Underworld's vengeful daughter, delve into the outskirts of her realm, in search of her ancient, hateful foe...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0083", Text = "{#Emph}The Titan Chronos; Time itself, and Time supposedly cannot be stopped... a claim the Princess has her reasons to dispute.", PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0084", Text = "{#Emph}Hers is a tale that shall withstand Time; yet it requires Time, as well. For now, a cruelly abrupt end shall have to do...", PreLineWait = 1.0, NoTarget = true },
		},
	},
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
			{ Cue = "/VO/Storyteller_0275", Text = "Having passed a test of her ability, the witch Melinoë prepares for the true test of both her training and resolve. But since this also is a Test, no more from that is to be shared for now.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest03 =
	{
		PlayOnce = true,
		FadeOutWait = 3.75,
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
			{ Cue = "/VO/Storyteller_0276", Text = "The test of Moon-glowing Melinoë is at an end for now. But soon, much more of what awaits her shall be told.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest04 =
	{
		PlayOnce = true,
		FadeOutWait = 3.5,
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
			{
				Path = { "GameState", "EnemyKills", "Hecate" },
				Comparison = "<=",
				Value = 4,
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0277", Text = "Born in shadow, the nightmare-bringing Princess of the Underworld shall return now whence she came.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest05 =
	{
		PlayOnce = true,
		FadeOutWait = 6.0,
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
			{ Cue = "/VO/Storyteller_0278", Text = "What is life but a series of tests and trials? One of which the shadow-stepping Princess has completed, whilst another looms on the horizon. Coming soon.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_TechTest06 =
	{
		PlayOnce = true,
		FadeOutWait = 3.5,
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
			{
				Path = { "GameState", "EnemyKills", "Hecate" },
				Comparison = "<=",
				Value = 4,
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0279", Text = "The shadow-stepping Princess goes no further from this point; only Time shall dictate otherwise.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- Underworld route
	Outro_EarlyEnd01 =
	{
		FadeOutWait = 27.7,
		SubtitleColor = Color.NarratorVoice,
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
		},
		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0224", Text = "{#Emph}Thus did Melinoë, the Underworld's vengeful daughter, cross the deepest reaches of her realm to thwart her ancient, hateful foe...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0083", Text = "{#Emph}The Titan Chronos; Time itself, and Time supposedly cannot be stopped... a claim the Princess has her reasons to dispute.", PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0084", Text = "{#Emph}Hers is a tale that shall withstand Time; yet it requires Time, as well. For now, a cruelly abrupt end shall have to do...", PreLineWait = 1.0, NoTarget = true },
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

	Outro_EarlyEnd_Cliffhanger =
	{
		TextDelay = 5.5,
		FadeOutWait = 5.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0225", Text = "{#Emph}Then Titan-vanquishing Melinoë searches the former House of Hades for a key to victory. Though what she finds, or whom, cannot be easily explained; or even shown, as yet...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- @v1.0
	Outro_EarlyEnd_Mystery =
	{
		FadeOutWait = 10,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "I" },
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
	
	-- Olympus route / Surface route
	Outro_EarlyEnd_Fate =
	{
		FadeOutWait = 22.4,
		SubtitleColor = Color.NarratorVoice,
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0156", Text = "{#Emph}Thus having overcome the Fate-wrought curse confining her to the Underworld, the Princess of the Dead ventured out unto the surface-realm.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0157", Text = "{#Emph}Her aim: To reach the mountain of the gods, and there disrupt the massing forces of their crafty foe.", PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0158", Text = "{#Emph}Much more is to be told of that in due course; but let us say, for now, she ran into some difficulties here and there.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	Outro_EarlyEnd02 =
	{
		FadeOutWait = 23.7,
		SubtitleColor = Color.NarratorVoice,
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0085", Text = "{#Emph}Thus the ever-ready Princess of the Underworld gained the very heights of Mount Olympus, to confront an unspeakable horror that awaits.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
			{ Cue = "/VO/Storyteller_0086", Text = "{#Emph}So unspeakable is that horror that it cannot adequately be described, nor even shown. At least, not at this time!", PreLineWait = 0.6, NoTarget = true },
			{ Cue = "/VO/Storyteller_0087", Text = "{#Emph}All that it offers now is a deep sense of dread, and swift return from whence the Princess came.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- olympus variants
	Outro_EarlyEnd_Surface =
	{
		FadeOutWait = 6.6,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0159", Text = "{#Emph}One step closer comes the surface-seeking Princess to Olympus and the gods; yet certain other steps remain ere her tale here is to unfold in full.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Strife =
	{
		FadeOutWait = 6.8,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
			},
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0249", Text = "{#Emph}Having defeated the embodiment of Strife, the death-delivering Princess seeks a means by which to travel to the mountain of the gods. And she shall use those means, as soon as they exist.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
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
			{ Cue = "/VO/Storyteller_0250", Text = "{#Emph}The heights of Mount Olympus loom so close... and yet, the surface-scouring Princess can go no closer for the moment. Although it never hurts to try...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- @v1.0
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
				PathTrue = { "CurrentRun", "BiomesReached", "O" },
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

	-- misc. variants
	Outro_EarlyEnd01b =
	{
		Header = "Outro_EarlyEnd01",
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0088", Text = "{#Emph}So numerous are the travails of dread Melinoë that one can scarce begin to fathom them; but on some evening, fathom them we shall.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd03 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0089", Text = "{#Emph}Seek not to know what happened to the terrifying Princess of the Underworld; the time shall come when all shall be made clear.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd01c =
	{
		Header = "Outro_EarlyEnd01",
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0090", Text = "{#Emph}As saffron-veiled Melinoë long bided her time, so too must wait a little longer those desirous of the details of her glorious revenge.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd07 =
	{
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0094", Text = "{#Emph}From shadow sprang the peerless witch Melinoë, and back to shadow she returns, for now. We shall resume her tale at another time.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd10 =
	{
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0097", Text = "{#Emph}One rightly may imagine that this tale has a very thrilling end; although I am afraid for now, that we are out of Time.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd11 =
	{
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0098", Text = "{#Emph}As Time cannot be stopped, neither can the quite-relentless Princess of the Underworld; her cathartic vengeance surely is at hand...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd04 =
	{
		FadeOutWait = 5.4,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0091", Text = "{#Emph}What then became of sorcerous Melinoë, you ask? This I would surely tell you, if I could. Alas that, for the moment, I cannot.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd05 =
	{
		FadeOutWait = 5.4,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0092", Text = "{#Emph}Time, perhaps, cannot be stopped; and yet with patience, Time can be withstood. What do you say we try withstanding for a while?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd06 =
	{
		FadeOutWait = 6.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0093", Text = "{#Emph}Of all great feats achieved by mortals or by gods, the nightmare-bringing Princess would achieve perhaps the greatest of them all. It's just, I cannot tell you of it yet...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd08 =
	{
		FadeOutWait = 5.9,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0095", Text = "{#Emph}So incomparable is the tale of the Princess of the Underworld that, why, I cannot even find the words. Though, by the gods, eventually, I shall!", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd09 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0096", Text = "{#Emph}The sheer wrath of fire-tempered witch Melinoë is such that to describe how she confronted her remaining prey would be to sorely limit the appeal of this tale...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd12 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0099", Text = "{#Emph}With victory at hand, the oft-feared Princess of the Dead achieved her life's ambition, and lived happily thenceforth for all eternity... or so I choose to think?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd14 =
	{
		FadeOutWait = 7.8,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0101", Text = "{#Emph}Thenceforth, all of the effort and hard work put in by studious Melinoë converted to a suitable reward; a life of pleasure and of luxury, perhaps! For what is life if not completely fair?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd15 =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0102", Text = "{#Emph}Surely a pleasant outcome of some sort awaits? Perhaps the Princess is invited to a regal ball, and therein meets her heart's desire, all whilst dancing to a catchy tune...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Gods =
	{
		FadeOutWait = 6.1,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0161", Text = "{#Emph}And after all of that, the Princess of the Dead and all the gods above the surface and below, they set aside their differences and lived from there on out contentedly.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Love =
	{
		FadeOutWait = 6.7,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0162", Text = "{#Emph}Thus young and spirited Melinoë found true love: the sport known as the discus-throw. And whilst she did not win the championship, she won over our hearts.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Fiery =
	{
		FadeOutWait = 6.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0164", Text = "{#Emph}With the forces of her enemy in ruin at her fiery feet, Princess Melinoë decided to return whence she came, for she could always devastate them more some other night.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Forgot =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

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
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0180", Text = "{#Emph}So lifelike was the nightmare tormenting the Princess of the Dead that she was very much surprised to learn that it was all a dream! Merely a dream, from which she shall awaken any moment now...", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Dead =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

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
		GameStateRequirements =
		{
			-- None
		},

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
			-- None
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
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0185", Text = "{#Emph}That was the last we ever heard of the Princess. Her tale was forgotten, it is true. Yet were it not for her great sacrifices, none of us would be here now, would we?", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Reasoning =
	{
		FadeOutWait = 5.25,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0186", Text = "{#Emph}So far beyond the scope of reasoning were the events that happened next, that committing them to words would be such folly as to not be worthy even of attempt.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Ambiguity =
	{
		FadeOutWait = 7.0,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0187", Text = "{#Emph}The subsequent events were fraught with ambiguity; the tale's theme as obscure as its setting. Whether the Princess truly found that which she sought remains contested to this day.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
		},
	},

	Outro_EarlyEnd_Epic =
	{
		FadeOutWait = 8.5,
		SubtitleColor = Color.NarratorVoice,
		GameStateRequirements =
		{
			-- None
		},

		VoiceLines =
		{
			{ Cue = "/VO/Storyteller_0230", Text = "{#Emph}Imagine now a tale which has such an epic scope, that the conclusion to the whole affair is nowhere to be found. For each great challenge that the heroine surmounts, another slightly different one awaits.", TextLimit = 300, PreLineWait = 0.8, NoTarget = true },
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
