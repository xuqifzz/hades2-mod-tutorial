-- Global Hermes Lines
GlobalVoiceLines.HermesFirstSpawnVoiceLines =
{
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Hermes_01",

		{ Cue = "/VO/Hermes_0070", Text = "{#Emph}Whew! {#Prev}Hey M! I'm back!" },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "H" },
			},
		},
		{ Cue = "/VO/MelinoeField_2000", Text = "You are!" },
	},
}

GlobalVoiceLines.SpecialDeliverVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.42,
		Source = { LineHistoryName = "NPC_Hermes_01", SubtitleColor = Color.HermesVoice },
		Cooldowns =
		{
			{ Name = "HermesSpokeRecently", Time = 2 },
			{ Name = "HermesSpecialDeliveredRecently", Time = 10 },
		},

		{ Cue = "/VO/Hermes_0116", Text = "Special delivery!", PlayFirst = true, },
		{ Cue = "/VO/Hermes_0117", Text = "Special delivery...!" },
		{ Cue = "/VO/Hermes_0118", Text = "Coming through!" },
		{ Cue = "/VO/Hermes_0119", Text = "Here you go!" },
		{ Cue = "/VO/Hermes_0120", Text = "Hi M! Bye M!" },
		{ Cue = "/VO/Hermes_0121", Text = "Cheers M!" },
		{ Cue = "/VO/Hermes_0122", Text = "Package for you!" },
		{ Cue = "/VO/Hermes_0123", Text = "Got you this!" },
		{ Cue = "/VO/Hermes_0124", Text = "You called?" },
		{ Cue = "/VO/Hermes_0125", Text = "Package here!" },
		{ Cue = "/VO/Hermes_0126", Text = "Hermes, at your service!" },
		{ Cue = "/VO/Hermes_0127", Text = "Hey hey!" },
		{ Cue = "/VO/Hermes_0136", Text = "Cheers, M!" },
		{ Cue = "/VO/Hermes_0138", Text = "Enjoy!" },
	},
}

UnitSetData.NPC_Hermes =
{
	-- Hermes, Id = TKTK
	NPC_Hermes_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Hermes_InPerson_01",
		AnimOffsetZ = 0,
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
			{ GlobalVoiceLines = "SaluteVoiceLines" },
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