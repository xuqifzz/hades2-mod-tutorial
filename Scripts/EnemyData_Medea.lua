UnitSetData.Medea =
{
	Medea =
	{
		InheritFrom = { "BaseVulnerableEnemy"},

		Groups = { "NPCs", "GroundEnemies" },

		Portrait = "Portrait_Medea_Default_01",
		AnimOffsetZ = 20,
		SpeakerName = "Medea",
		LoadPackages = { "Medea", },
		SubtitleColor = Color.MedeaVoice,
		RunHistoryKilledByName = "NPC_Medea_01",
		TurnInPlaceAnimation = "Medea_Turn",
		EmoteOffsetX = 0,
		EmoteOffsetY = -205,
		SpeechCooldownTime = 9,
		CreateAnimations =
		{
			"MedeaGroundGlow",
		},
		
		AttachedAnimationName = "MedeaGlow",
		GrannyTexture = "GR2/MedeaEM_Color",
		RepulseOnMeleeInvulnerableHit = 150,

		AIWakeDelay = 0.0,

		HideHealthBar = true,

		SpeechParams =
		{
			Radius = 1,
		},
		
		EffectBlocks = { "RavenFamiliarMark" },
		MaxHealth = 9999,
		CannotDieFromDamage = true,
		BlockCritMark = true,
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		Material = "Organic",

		DefaultAIData =
		{

		},

		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions = { "MedeaDagger", "MedeaCast", "MedeaCorpseExplode", "MedeaCast_NoTeleport"},

		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MedeaSpokeRecently", Time = 16 },
				{ Name = "MedeaHitRecentlySpeech", Time = 40 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "Medea",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathNotEmpty = { "RequiredKillEnemies" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "HoundFamiliarBark", "PolecatFamiliarMelee" },
					},
					ChanceToPlay = 0.33,
				},

				{ Cue = "/VO/Medea_0373", Text = "Best concentrate on {#Emph}him.", PlayFirst = true },
				{ Cue = "/VO/Medea_0374", Text = "I'm but a shadow!" },
				{ Cue = "/VO/Medea_0375", Text = "Not {#Emph}me{#Prev}, sorceress!" },
				{ Cue = "/VO/Medea_0376", Text = "No such fortune." },
				{ Cue = "/VO/Medea_0377", Text = "I'm immune." },
				{ Cue = "/VO/Medea_0378", Text = "What did {#Emph}I {#Prev}do?" },
				{ Cue = "/VO/Medea_0379", Text = "Hit {#Emph}him." },
				{ Cue = "/VO/Medea_0380", Text = "The Cyclops...?" },
				{ Cue = "/VO/Medea_0381", Text = "You wound me!" },
				{ Cue = "/VO/Medea_0382", Text = "Best think again." },
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.66,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.5,
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				--
			},
			Cooldowns =
			{
				{ Name = "MedeaSpokeRecently", Time = 16 },
				{ Name = "MedeaDamageSpeech", Time = 40 },
			},

			{ Cue = "/VO/Medea_0518", Text = "Purest agony...!" },
			{ Cue = "/VO/Medea_0519", Text = "Are you in pain?" },
			{ Cue = "/VO/Medea_0520", Text = "You certainly felt that..." },
			{ Cue = "/VO/Medea_0521", Text = "Your precious blood..." },
			{ Cue = "/VO/Medea_0522", Text = "A grievous injury..." },
			{ Cue = "/VO/Medea_0523", Text = "How that must hurt..." },
			{ Cue = "/VO/Medea_0524", Text = "Internalize the pain." },
			{ Cue = "/VO/Medea_0525", Text = "You're wounded, sorceress!", PlayFirst = true },
			{ Cue = "/VO/Medea_0526", Text = "A sacrifice of blood..." },
			{ Cue = "/VO/Medea_0527", Text = "Such pain..." },
			{ Cue = "/VO/Medea_0528", Text = "Terrible..." },
			{ Cue = "/VO/Medea_0529", Text = "Excruciating..." },
			{ Cue = "/VO/Medea_0530", Text = "Blood spills..." },
			{ Cue = "/VO/Medea_0531", Text = "{#Emph}<Laughter>" },
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Medea )