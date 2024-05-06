UnitSetData.NPC_Hermes =
{
	-- Hermes, Id = TKTK
	NPC_Hermes_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Hermes_InPerson_01",
		AnimOffsetZ = 280,
		SubtitleColor = Color.HermesVoice,
		SpeakerName = "Hermes",
		Speaker = "NPC_Hermes_01",
		ThemeMusic = "/Music/ArtemisTheme_MC",
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		-- TurnInPlaceAnimation = "Hermes_Turn",

		ActivateRequirements =
		{
		},
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				-- PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.2,
				-- RandomRemaining = true,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1884", Text = "Lord Hermes, go unseen." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				-- PreLineAnim = "Hermes_Greet",
				ObjectType = "NPC_Hermes_01",

				{ Cue = "/VO/Hermes_0128", Text = "You too!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1884" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0129", Text = "Hey hey!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0130", Text = "Hey!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0131", Text = "Fierce!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0132", Text = "Cheers!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1884" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0133", Text = "Same!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0134", Text = "Yep!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0135", Text = "Sure!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Hermes_01",
			Cooldowns =
			{
				{ Name = "HermesSpokeRecently", Time = 6 },
			},

			{ Cue = "/VO/Hermes_0146", Text = "Anytime...!" },
			{ Cue = "/VO/Hermes_0147", Text = "Hey, {#Emph}erm...?", PlayFirst = true },
			{ Cue = "/VO/Hermes_0148", Text = "Hello?" },
			{ Cue = "/VO/Hermes_0149", Text = "Come on already, M..." },
			{ Cue = "/VO/Hermes_0144", Text = "Nope!" },
			{ Cue = "/VO/Hermes_0145", Text = "{#Emph}Mm-mm." },
		},

		InteractTextLineSets =
		{
			HermesFirstPickUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				NarrativeContextArt = "DialogueBackground_Erebus",
				GameStateRequirements =
				{

				},

				{ Cue = "/VO/Hermes_0071",
					Portrait = "Portrait_Hermes_InPerson_01",
					Speaker = "HermesUpgrade",
					Text = "How's things, you good? I'm good. Mostly! And good to see your task is underway, but change of plan, though it's a lot to ask: Up for a visit to Olympus sometime soon?" },
				{ Cue = "/VO/MelinoeField_2003", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Hermes, just a moment, what do you mean {#Emph}Olympus? {#Prev}My task is to stop Chronos in the Underworld. I can hardly breathe the surface air, much less get to a mountaintop!" },
				{ Cue = "/VO/Hermes_0072",
					Portrait = "Portrait_Hermes_InPerson_01",
					Speaker = "HermesUpgrade",
					Text = "Come on, M! You have your ways! Gramps is up to something bad, more than his usual attacks, so just give it some thought. Wouldn't ask if it was nothing, right? OK, got to run, and so do you. I'll be in touch by Boon!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hermes_01",
						{ Cue = "/VO/Hermes_0073", Text = "So long for now!" },
					},
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_2004", Text = "Good-bye!" },
					},
				},

				EndFunctionName = "RemoveHermesInPerson",
				EndFunctionArgs = {},
			},
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hermes )