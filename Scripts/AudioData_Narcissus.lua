-- Global Narcissus Lines
GlobalVoiceLines.NarcissusGreetingLines =
{
	Queue = "Interrupt",
	{
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				RequiredAnyQueuedTextLines = { "NarcissusGrantsReward01" },
			},
			ObjectType = "NPC_Narcissus_01",
			
			{ Cue = "/VO/Narcissus_0113", Text = "Hey..." },
		},
		{
			RandomRemaining = true,
			GameStateRequirements =
			{
				RequiredFalseQueuedTextLines =
				{
					"NarcissusAboutReflection01",
					"NarcissusAboutReflection02",
					"NarcissusAboutReflection03",
					"NarcissusAboutReflection04",
					"NarcissusAboutStillDirtyWaters01",
				},
			},
			ObjectType = "NPC_Narcissus_01",
			
			{ Cue = "/VO/Narcissus_0023", Text = "Yeah?", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0024", Text = "What?" },
			{ Cue = "/VO/Narcissus_0025", Text = "'Scuse me?", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0026", Text = "Oh, it's you." },
			{ Cue = "/VO/Narcissus_0112", Text = "Oh." },
			{ Cue = "/VO/Narcissus_0113", Text = "Hey..." },
			{ Cue = "/VO/Narcissus_0114", Text = "Hey." },
			{ Cue = "/VO/Narcissus_0115", Text = "Yeah...?" },
			{ Cue = "/VO/Narcissus_0116", Text = "You again." },
			{ Cue = "/VO/Narcissus_0117", Text = "Back huh." },
			{ Cue = "/VO/Narcissus_0121", Text = "Suitors..." },
			{ Cue = "/VO/Narcissus_0122", Text = "Suitors!" },
			{ Cue = "/VO/Narcissus_0123", Text = "Here we go again." },
			{ Cue = "/VO/Narcissus_0231", Text = "{#Emph}Ahem." },
			{ Cue = "/VO/Narcissus_0232", Text = "Rude..." },
			{ Cue = "/VO/Narcissus_0233", Text = "{#Emph}Again..." },
			{ Cue = "/VO/Narcissus_0234", Text = "Be right back." },
			{ Cue = "/VO/Narcissus_0235", Text = "Wha?" },
			{ Cue = "/VO/Narcissus_0236", Text = "{#Emph}Eh..." },
			{ Cue = "/VO/Narcissus_0118", Text = "Laurel, right?",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" },
					},
				},
			},
			{ Cue = "/VO/Narcissus_0119", Text = "Hey Laurel.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Narcissus_0118" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift02" }
					},
				},
			},
			{ Cue = "/VO/Narcissus_0120", Text = "Laurel!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Narcissus_0119" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" }
					},
				},
			},
		},
	},
	{
		UsePlayerSource = true,
		PlayOnce = true,
		PlayOnceContext = "MelNameResponseVO",

		{ Cue = "/VO/MelinoeField_1216", Text = "It's Melinoë...",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Narcissus_0118" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1217", Text = "Melinoë...",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Narcissus_0119" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1218", Text = "You can just call me Mel.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Narcissus_0120" },
				},
			},
		},
	},
}
GlobalVoiceLines.NarcissusMutteringLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.15,
		SuccessiveChanceToPlayAll = 0.66,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Narcissus_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "NarcissusInterrupt" },
			},
			NamedRequirements = { "NarcissusDirtyWater" },
		},

		{ Cue = "/VO/Narcissus_0108", Text = "{#Emph}<Sniff> {#Prev}Oh man... like... damn... I mean... what am I gonna do? It's just, like..." },
		{ Cue = "/VO/Narcissus_0109", Text = "{#Emph}Ungh... {#Prev}I just can't... like... I mean, I can't even... {#Emph}<Sniff> {#Prev}What happened to us, man? I..." },
		{ Cue = "/VO/Narcissus_0110", Text = "So... muddy... {#Emph}augh{#Prev}, can't quite... make out... an eye? A nose? {#Emph}Ungh..." },
		{ Cue = "/VO/Narcissus_0111", Text = "So, {#Emph}um... {#Prev}yeah, I guess... like... anyway... let me see here..." },
		{ Cue = "/VO/Narcissus_0207", Text = "{#Emph}<Sigh> {#Prev}It's like... I still remember how you used to look, just... I {#Emph}miss {#Prev}you, man..." },
		{ Cue = "/VO/Narcissus_0208", Text = "Maybe I should... like, {#Emph}go? {#Prev}Like, somewhere {#Emph}else? {#Prev}But I can't {#Emph}leave {#Prev}you, man...!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.15,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Narcissus_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "NarcissusInterrupt" },
			},
			NamedRequirementsFalse = { "NarcissusDirtyWater" },
		},

		{ Cue = "/VO/Narcissus_0019", Text = "Wow... {#Emph}tsk... {#Prev}I mean, come on, just... {#Emph}augh...!", PlayFirst = true },
		{ Cue = "/VO/Narcissus_0020", Text = "Just... {#Emph}yeah! {#Prev}I'm so... {#Emph}ungh{#Prev}, I mean... {#Emph}huh{#Prev}, right...?" },
		{ Cue = "/VO/Narcissus_0021", Text = "...Man... just, you are so... {#Emph}ungh! {#Prev}Know what I mean...?" },
		{ Cue = "/VO/Narcissus_0022", Text = "...{#Emph}Whew{#Prev}, like... {#Emph}yeah...! {#Prev}Just, {#Emph}totally{#Prev}, I mean... right?" },
		{ Cue = "/VO/Narcissus_0098", Text = "So like... I mean... {#Emph}yeah{#Prev}, just... {#Emph}ungh! {#Prev}You know? {#Emph}You {#Prev}know, {#Emph}huh! {#Prev}You {#Emph}know..." },
		{ Cue = "/VO/Narcissus_0099", Text = "{#Emph}Mm, {#Prev}yeah, that's... nice, yeah, definitely, {#Emph}so, {#Prev}like... {#Emph}ungh...! {#Prev}I mean, for real..." },
		{ Cue = "/VO/Narcissus_0100", Text = "Yeah, looking good, man. You... are looking {#Emph}good. {#Prev}Like you don't know! Don't even know, right?" },
		{ Cue = "/VO/Narcissus_0102", Text = "How did you get so... {#Emph}ungh{#Prev}, the hair, the lips, the eyes. Those {#Emph}eyes{#Prev}, man! Know what I mean?" },
		{ Cue = "/VO/Narcissus_0103", Text = "Love you, man. I ever tell you that? {#Emph}Haha{#Prev}, oh yeah, I did. You {#Emph}know {#Prev}I did. You know I do." },
		{ Cue = "/VO/Narcissus_0104", Text = "So, like, yeah... just, all of it, it's, {#Emph}ungh. {#Prev}It's too {#Emph}much! {#Prev}It's never enough. {#Emph}Haha{#Prev}, you know?" },
		{ Cue = "/VO/Narcissus_0105", Text = "Hey you look... you look {#Emph}great{#Prev}, man. Thought I'd mention it. Because I'm {#Emph}thinking {#Prev}it, you know?" },
		{ Cue = "/VO/Narcissus_0106", Text = "What else is going on, though, man? Got to be something on your mind, right? No...?" },
		{ Cue = "/VO/Narcissus_0107", Text = "So I was like, {#Emph}no way. {#Prev}But then I go, wait... {#Emph}what if...? {#Prev}Remember that one, man? I know you do!" },
		{ Cue = "/VO/Narcissus_0203", Text = "Hey man, tell me something, can you keep a secret? Because I can't: {#Emph}I love you. {#Prev}Yeah. You got that right..." },
		{ Cue = "/VO/Narcissus_0206", Text = "I mean, look at you, it's like, {#Emph}just... wow. {#Prev}You know? Don't even have the words..." },
		{ Cue = "/VO/Narcissus_0101", Text = "That her again? That's her. Don't worry, man, this won't take long. This won't take long at all.",
			GameStateRequirements =
			{
				RequiredFalseQueuedTextLines = GameData.NarcissusTalkToSelfEvents,
			},
		},
		{ Cue = "/VO/Narcissus_0204", Text = "{#Emph}Eh{#Prev}, probably just Laurel coming back to fawn all over you again, right man...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" },
				},
				RequiredFalseQueuedTextLines = GameData.NarcissusTalkToSelfEvents,
			},
		},
		{ Cue = "/VO/Narcissus_0205", Text = "Wonder how Echo's doing, man. Down in the Fields! It's nice and airy over there. Yeah...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
				},
			},
		},
	},
}

GlobalVoiceLines.NarcissusPostGiftMutteringLines =
{
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "UseRecord", "NPC_Narcissus_01" },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		-- SuccessiveChanceToPlay = 0.5,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Narcissus_01",
		GameStateRequirements = 
		{
			NamedRequirements = { "NarcissusDirtyWater" },
		},

		{ Cue = "/VO/Narcissus_0108", Text = "{#Emph}<Sniff> {#Prev}Oh man... like... damn... I mean... what am I gonna do? It's just, like..." },
		{ Cue = "/VO/Narcissus_0109", Text = "{#Emph}Ungh... {#Prev}I just can't... like... I mean, I can't even... {#Emph}<Sniff> {#Prev}What happened to us, man? I..." },
		{ Cue = "/VO/Narcissus_0110", Text = "So... muddy... {#Emph}augh{#Prev}, can't quite... make out... an eye? A nose? {#Emph}Ungh..." },
		{ Cue = "/VO/Narcissus_0111", Text = "So, {#Emph}um... {#Prev}yeah, I guess... like... anyway... let me see here..." },
		{ Cue = "/VO/Narcissus_0207", Text = "{#Emph}<Sigh> {#Prev}It's like... I still remember how you used to look, just... I {#Emph}miss {#Prev}you, man..." },
		{ Cue = "/VO/Narcissus_0208", Text = "Maybe I should... like, {#Emph}go? {#Prev}Like, somewhere {#Emph}else? {#Prev}But I can't {#Emph}leave {#Prev}you, man...!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.5,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Narcissus_01",
		SuccessiveChanceToPlayAll = 0.66,
		GameStateRequirements = 
		{
			NamedRequirementsFalse = { "NarcissusDirtyWater" },
		},

		{ Cue = "/VO/Narcissus_0019", Text = "Wow... {#Emph}tsk... {#Prev}I mean, come on, just... {#Emph}augh...!" },
		{ Cue = "/VO/Narcissus_0020", Text = "Just... {#Emph}yeah! {#Prev}I'm so... {#Emph}ungh{#Prev}, I mean... {#Emph}huh{#Prev}, right...?" },
		{ Cue = "/VO/Narcissus_0021", Text = "...Man... just, you are so... {#Emph}ungh! {#Prev}Know what I mean...?" },
		{ Cue = "/VO/Narcissus_0022", Text = "...{#Emph}Whew{#Prev}, like... {#Emph}yeah...! {#Prev}Just, {#Emph}totally{#Prev}, I mean... right?" },
		{ Cue = "/VO/Narcissus_0098", Text = "So like... I mean... {#Emph}yeah{#Prev}, just... {#Emph}ungh! {#Prev}You know? {#Emph}You {#Prev}know, {#Emph}huh! {#Prev}You {#Emph}know..." },
		{ Cue = "/VO/Narcissus_0099", Text = "{#Emph}Mm, {#Prev}yeah, that's... nice, yeah, definitely, {#Emph}so, {#Prev}like... {#Emph}ungh...! {#Prev}I mean, for real..." },
		{ Cue = "/VO/Narcissus_0100", Text = "Yeah, looking good, man. You... are looking {#Emph}good. {#Prev}Like you don't know! Don't even know, right?" },
		{ Cue = "/VO/Narcissus_0101", Text = "That her again? That's her. Don't worry, man, this won't take long. This won't take long at all." },
		{ Cue = "/VO/Narcissus_0102", Text = "How did you get so... {#Emph}ungh{#Prev}, the hair, the lips, the eyes. Those {#Emph}eyes{#Prev}, man! Know what I mean?" },
		{ Cue = "/VO/Narcissus_0103", Text = "Love you, man. I ever tell you that? {#Emph}Haha{#Prev}, oh yeah, I did. You {#Emph}know {#Prev}I did. You know I do." },
		{ Cue = "/VO/Narcissus_0104", Text = "So, like, yeah... just, all of it, it's, {#Emph}ungh. {#Prev}It's too {#Emph}much! {#Prev}It's never enough. {#Emph}Haha{#Prev}, you know?" },
		{ Cue = "/VO/Narcissus_0105", Text = "Hey you look... you look {#Emph}great{#Prev}, man. Thought I'd mention it. Because I'm {#Emph}thinking {#Prev}it, you know?" },
		{ Cue = "/VO/Narcissus_0106", Text = "What else is going on, though, man? Got to be something on your mind, right? No...?" },
		{ Cue = "/VO/Narcissus_0107", Text = "So I was like, {#Emph}no way. {#Prev}But then I go, wait... {#Emph}what if...? {#Prev}Remember that one, man? I know you do!" },
		{ Cue = "/VO/Narcissus_0203", Text = "Hey man, tell me something, can you keep a secret? Because I can't: {#Emph}I love you. {#Prev}Yeah. You got that right..." },
		{ Cue = "/VO/Narcissus_0206", Text = "I mean, look at you, it's like, {#Emph}just... wow. {#Prev}You know? Don't even have the words..." },
		{ Cue = "/VO/Narcissus_0204", Text = "{#Emph}Eh{#Prev}, probably just Laurel coming back to fawn all over you again, right man...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" },
				},
			},
		},
		{ Cue = "/VO/Narcissus_0205", Text = "Wonder how Echo's doing, man. Down in the Fields! It's nice and airy over there. Yeah...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
				},
			},
		},
	},
}

GlobalVoiceLines.NarcissusExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Narcissus_01",
	Cooldowns =
	{
		{ Name = "NarcissusSpokeRecently", Time = 8 },
	},

	{ Cue = "/VO/Narcissus_0179", Text = "Sounds like you found your match." },
	{ Cue = "/VO/Narcissus_0180", Text = "{#Emph}Whew{#Prev}, I owe you one." },
	{ Cue = "/VO/Narcissus_0181", Text = "Get 'em out of here." },
	{ Cue = "/VO/Narcissus_0182", Text = "Didn't like that one." },
	{ Cue = "/VO/Narcissus_0183", Text = "Buh-{#Emph}bye!" },
	{ Cue = "/VO/Narcissus_0184", Text = "Thought they'd never leave." },
	{ Cue = "/VO/Narcissus_0185", Text = "{#Emph}Finally!" },
}

GlobalVoiceLines.MiscEndVoiceLines_Narcissus =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		-- SuccessiveChanceToPlay = 0.75,
		ObjectType = "NPC_Narcissus_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "NarcissusAboutWaters01" },
			},
			NamedRequirementsFalse = { "NarcissusDirtyWater" },
		},

		{ Cue = "/VO/Narcissus_0027", Text = "Knock yourself out." },
		{ Cue = "/VO/Narcissus_0028", Text = "Now if you'll excuse me." },
		{ Cue = "/VO/Narcissus_0029", Text = "Now you may go.", PlayFirst = true },
		{ Cue = "/VO/Narcissus_0030", Text = "All yours." },
		{ Cue = "/VO/Narcissus_0031", Text = "I guess!" },
		{ Cue = "/VO/Narcissus_0032", Text = "Now leave, OK?" },
		{ Cue = "/VO/Narcissus_0124", Text = "Help yourself." },
		{ Cue = "/VO/Narcissus_0125", Text = "Regards." },
		{ Cue = "/VO/Narcissus_0126", Text = "Sure thing." },
		{ Cue = "/VO/Narcissus_0127", Text = "Anytime.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" },
				},
			},
		},
		{ Cue = "/VO/Narcissus_0128", Text = "For you." },
		{ Cue = "/VO/Narcissus_0129", Text = "Take care." },
		{ Cue = "/VO/Narcissus_0130", Text = "There." },
		{ Cue = "/VO/Narcissus_0131", Text = "Take it..." },
		{ Cue = "/VO/Narcissus_0132", Text = "All the best." },
		{ Cue = "/VO/Narcissus_0133", Text = "Warm wishes." },
		{ Cue = "/VO/Narcissus_0134", Text = "Kind regards." },
		{ Cue = "/VO/Narcissus_0135", Text = "Best wishes." },
		{ Cue = "/VO/Narcissus_0136", Text = "See you soon." },
		{ Cue = "/VO/Narcissus_0137", Text = "See you around." },
		{ Cue = "/VO/Narcissus_0138", Text = "Have a great day." },
		{ Cue = "/VO/Narcissus_0139", Text = "Have a great day. Or night?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Narcissus_0138" },
				}
			}
		},
		{ Cue = "/VO/Narcissus_0140", Text = "Thanks for coming by." },
		{ Cue = "/VO/Narcissus_0141", Text = "Hope this helps." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.15,

		{ Cue = "/VO/Melinoe_2152", Text = "Thanks...?" },
		{ Cue = "/VO/Melinoe_2153", Text = "{#Emph}Erm{#Prev}, thanks...", PlayFirst = true },
	},
	[3] = GlobalVoiceLines.ThankingCharacterVoiceLines,
}
