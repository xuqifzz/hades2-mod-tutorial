UnitSetData.NPC_Arachne = 
{
	-- Arachne, Id = TKTK
	NPC_Arachne_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Arachne_Default_01",
		AnimOffsetZ = 80,
		Groups = { "NPCs" },
		SpeakerName = "Arachne",
		SubtitleColor = Color.ArachneVoice,

		RequiredRoomInteraction = true,
		BlockedLootInteractionText = "NPCUseTextTalkLocked",

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/Leftovers/Menu Sounds/RosterPickup",
		MenuTitle = "ArachneCostumeMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Arachne",

		FlavorTextIds =
		{
			"ArachneCostumeMenu_FlavorText01",
		},
		Traits = 
		{
			"AgilityCostume",
			"ManaCostume",
			"VitalityCostume",
			"HighArmorCostume",
			"CastDamageCostume",
			"IncomeCostume",
		},
		ActivateRequirements =
		{
			-- None
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				PlayOnceThisRun = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1880", Text = "Peace, Arachne.", PlayFirst = true },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Arachne_01",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.ArachneUpsetEvents,
					},
				},

				{ Cue = "/VO/Arachne_0151", Text = "And to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0152", Text = "How do you do?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0153", Text = "Thank you kindly.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0154", Text = "Oh I know my way around.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0155", Text = "Wherever we may go.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0156", Text = "Appreciate the thought.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0157", Text = "Be well, won't you?" },
				{ Cue = "/VO/Arachne_0158", Text = "Take care out there." },
				{ Cue = "/VO/Arachne_0159", Text = "You're awfully polite.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0160", Text = "No need to be so formal here.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0161", Text = "Oh, {#Emph}you!" },
				{ Cue = "/VO/Arachne_0162", Text = "Come now." },
			}
		},

		InteractTextLineSets =
		{
			ArachneFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0002",
					Emote = "PortraitEmoteSurprise",
					Text = "What are you doing here? Besides tramping all over my webs, that is! Oh, it's nothing, silly. I can always make more perfectly good silk! I can't always see you." },
				{ Cue = "/VO/Melinoe_0636", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm{#Prev}, hi, Arachne. Sorry about all this! I think we'll soon be seeing more of one another, now. My task has begun." },
				{ Cue = "/VO/Arachne_0003",
					Text = "Truly? Why then, I'll get out of your hair, you have to go. But first, you {#Emph}have {#Prev}to try on one of these. And don't worry about any wear-and-tear! I've plenty more in stock, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.33,
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0118",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh no, you're hurt, my friend! And with such a long journey still ahead. Though don't you fret! My silk will make you feel as good as new." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutSilk01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0034",
					Text = "My silk is everything to me. It's stronger than it looks. Keeps me safe! It can suffocate even the strongest prey. Don't you like it? Is there a certain... pattern-color combination you admire?" },
				{ Cue = "/VO/Melinoe_1806", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's lovely, Arachne. Look, I wish I could stay and admire it, but..." },
				{ Cue = "/VO/Arachne_0035",
					Text = "...But you can't. I understand, I truly do. Though, it would mean a lot to me if you would take some of my silk with you on your way." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutSilk02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1785", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your silk is so luxurious, and the enchantments on the thread are strong. Arachne, it's incredible, really. You know that, right?" },
				{ Cue = "/VO/Arachne_0042",
					Text = "Of course I know, my friend. While I may not be quite as strong as you, for my size, I'm something else. And I don't tire easily! As for the rest... trade secret, {#Emph}hah, ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutPay01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift02" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1786", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There must be something I can do to repay you for all your hard work. We live modestly in the Crossroads, though we're not without our sources of supplies. Whatever you need, name it." },
				{ Cue = "/VO/Arachne_0043",
					Text = "Well that's rather forward of you, my friend, and I appreciate it, truly. Whatever I need, huh. I'll have to give a little thought to that! But right now, I need for you to decide which of these dresses you like, and try it on." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutOutfits01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Melinoe_1810", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne, the outfit you wove for me was so beautiful. I'm sorry to say I got into a bit of a scrape or two... and I'm afraid it didn't survive." },
				{ Cue = "/VO/Arachne_0041",
					Text = "Oh, {#Emph}hah{#Prev}, that's quite all right, silly! It wasn't made to last. What is? It was made to be in the moment with {#Emph}you. {#Prev}Now here, I've plenty more." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutSelf01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0036",
					PreLineWait = 0.35,
					Text = "...Don't, my friend. Just, you don't need to look at me like that. You don't need to look at me at all! Look at the fineries I've made! Silk in every shape and color, see? It's beautiful, isn't it?" },
				{ Cue = "/VO/Melinoe_1807", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It is, Arachne, but... to think I could have wronged you with an inadvertent glance just now. It's just I'm concerned for your safety out here." },
				{ Cue = "/VO/Arachne_0037",
					Text = "Oh there's no need for that. You see, my form included certain benefits. I get to live a {#Emph}long{#Prev}, long time to enjoy it. Besides, just because {#Emph}you {#Prev}found me here, doesn't mean just anybody can." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutSelf02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutSelf01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0038",
					Emote = "PortraitEmoteDepressed",
					Text = "I don't remember, anymore, what it was like... having two legs. Only the two. I'm hideous, I know, but... I don't fall over myself like I once did. It's second nature now, scurrying about." },
				{ Cue = "/VO/Melinoe_1808", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't speak that way! My task would go much faster if I had legs like yours, Arachne." },
				{ Cue = "/VO/Arachne_0039",
					Text = "Save your pity for another soul, my friend. Now then! I've saved some of my {#Emph}softest {#Prev}silk for {#Emph}you." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutLair01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Melinoe_1809", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Are you sure you're all right here? I can scarce go fifty paces in these woods without having to defend myself." },
				{ Cue = "/VO/Arachne_0040",
					Text = "I'm comfortable alone. I have my little lair, I've sustenance, and I have my weaving! I no longer even need a loom and thread. I'm grateful. And, I do so appreciate you visiting! Come back again, won't you?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutTrees01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0081",
					Text = "It's mostly quiet in these woods. Lost Souls keep to themselves most of the time. So I listen to the trees... they're {#Emph}tall{#Prev}, and {#Emph}wise{#Prev}, and {#Emph}older {#Prev}than the ones where I come from..." },
				{ Cue = "/VO/MelinoeField_1782", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Growing up, I always listened to the whisper of the woods as well! In some respects, it reminds me of the spirits inhabiting this place. Their voices cannot easily be heard." },
				{ Cue = "/VO/Arachne_0082",
					Text = "But they {#Emph}can {#Prev}be heard, can't they. I'm not imagining it, when I hear them call to me and comfort me? Though there's no need to answer that! For certain things, I'd rather not be sure." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomCountCache", "G_Boss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0085",
					Text = "These woods have changed an awful lot of late. Sometimes I think of moving out of here. I understand it gets all cold and damp as you head farther down?" },
				{ Cue = "/VO/MelinoeField_1789", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There is a path I know that passes through the edge of Oceanus, where the bottom of the sea and the Underworld meet. No trees, only... strange tubes of metal... brine." },
				{ Cue = "/VO/Arachne_0086",
					Text = "Sounds like a real change of pace! Don't think I'd like it quite as much without my trees. But {#Emph}metal tubes? {#Prev}Could hang my webs on those...! Ah well... a dream's a dream, {#Emph}ha ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Boss01", },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0087",
					Text = "Where have you been lately, my friend? I'd grown so well-accustomed to you visiting these woods that, when you didn't show up for a night or two, why... I became a touch concerned is all." },
				{ Cue = "/VO/MelinoeField_1784", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm sorry that I worried you. My task requires that I head up to the surface now, as well as down below. It's a big adjustment for me there." },
				{ Cue = "/VO/Arachne_0088",
					Text = "You went {#Emph}that {#Prev}way? {#Emph}Ha ha ha ha{#Prev}, I don't so much as miss it anymore, where I came from. Well, you must know your way around. But if you need a local's point of view, you need but ask." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutWeaving01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0044",
					Text = "I loved to weave since I was very small. My father, he would make the richest dyes... reds like the setting sun, blues as deep as the sea, and {#Emph}oh{#Prev}, the {#Emph}purples! {#Prev}I wanted to make fabric worthy of such colors as those..." },
				{ Cue = "/VO/MelinoeField_1484", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And now you do. You have extraordinary talent. How long did it take to get so proficient? I've practiced my craft all my life though still fall short of my goals far too often..." },
				{ Cue = "/VO/Arachne_0045",
					Text = "You'll get to where you need to be, my friend. I see how hard you work! As for me, as a young woman, I was already quite good. But truth be told, I'm even better now that I'm like this. A blessing... and a curse, {#Emph}ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutWeaving02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutWeaving01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0046",
					Text = "All I wanted was to have a little shoppe. {#Emph}Arachne's Garments, Dyes, and Fabrics! {#Prev}Not the catchiest of names, now that I sound it out. But our reputation would have been impeccable." },
				{ Cue = "/VO/MelinoeField_1485", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know it's not what you imagined... but you've a loyal customer in me. Although, the part where you ask nothing for your services does make me feel a bit guilty, I suppose." },
				{ Cue = "/VO/Arachne_0047",
					Emote = "PortraitEmoteFiredUp",
					Text = "Don't even start with that! My weavings and my garments aren't just for show, they're practical evening-wear! {#Emph}You{#Prev}, my friend, are helping them fulfill their life's purpose, {#Emph}ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutPride01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutGods06" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0079",
					Text = "Should I have held back? When I was challenged by the gods themselves? To decide who was the {#Emph}greatest {#Prev}weaver of all. I was just a mortal girl. Can you imagine the pressure?" },
				{ Cue = "/VO/MelinoeField_1781", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't have held back either, in your place. When our limits are put to the test... only then can we discover who we really are." },
				{ Cue = "/VO/Arachne_0080",
					Text = "All I discovered was I ceased being a mortal girl anymore. You should have {#Emph}seen {#Prev}the masterpiece I made! Athena's little {#Emph}tapestry {#Prev}wasn't even close. Maybe it was worth it... my humiliation in exchange for hers..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutCocoons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Melinoe_1811", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've been so busy, Arachne. Not just all these dresses, but... all Erebus is teeming with silken cocoons. You're certain it's all right for me to break them?" },
				{ Cue = "/VO/Arachne_0048",
					Emote = "PortraitEmoteCheerful",
					Text = "Of course, you big silly! What, do you suppose they're teeming with my countless brood? By the time you see a cocoon, anything in there is either {#Emph}for {#Prev}you, or was out to {#Emph}get {#Prev}you. Now, here." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCocoons02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutCocoons01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0049",
					Text = "Now you don't truly think {#Emph}I {#Prev}weave all those cocoons you see out there myself, do you? I weave faster than anyone, though even {#Emph}I'm {#Prev}not that quick...!" },
				{ Cue = "/VO/Melinoe_1812", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That does make sense. So instead you command a massive hidden army of spiderlings, standing at the ready to do your bidding?" },
				{ Cue = "/VO/Arachne_0050",
					Text = "{#Emph}Oh {#Prev}no, most of them hang upside-down rather than stand. {#Emph}Khh, {#Prev}come now! I'm not the only spider in the woods! The others keep to themselves. But they do listen {#Emph}sometimes{#Prev}, I suppose, {#Emph}ha ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutFood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0067",
					Text = "You must be famished! Might I interest you in a little sustenance? And I do mean {#Emph}little, hahaha! {#Prev}I have a fresh batch here if you'd like to try them!" },
				{ Cue = "/VO/MelinoeField_1486", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh! No thank you, Arachne. I... have no appetite at all. And I'm not much for eating animals, even insects. Although I'm certain your flies are very delicious." },
				{ Cue = "/VO/Arachne_0068",
					Text = "They {#Emph}are! {#Prev}A touch of an acquired taste, I know. But I got used to them much faster than just about any other aspect of this life. {#Emph}Ah {#Prev}well! Your loss, I'm sure." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutSpiders01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1487", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're always here all by yourself. The woods are filled with spiders... don't you ever get together, something like that? Make great big webs you couldn't on your own?" },
				{ Cue = "/VO/Arachne_0051",
					PreLineWait = 0.35,
					Text = "...I'll let you in on a little secret, my friend... I happen to {#Emph}hate {#Prev}spiders. Near as I can tell, all spiders do. Weaving's a solitary exercise. And besides! I much prefer {#Emph}your {#Prev}company." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutSpiders02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutSpiders01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1488", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... for what it's worth, I never have disliked spiders, myself. They keep the woods free of pests. And what would this place be without their webs?" },
				{ Cue = "/VO/Arachne_0052",
					Text = "Thank you, my friend. I know you mean well when you say such things. If it makes you feel any better, I don't just hate what {#Emph}I've {#Prev}become. You gods... I hate you, too. {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutSpiders03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutSpiders01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0053",
					Text = "You know the thing about spiders, my friend, it's that... well, they're my kin. My own brood, you see. But they're {#Emph}ungrateful {#Prev}rascals to the last! They want nothing to do with me at all." },
				{ Cue = "/VO/MelinoeField_1489", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your own brood...! You were the very first. But, how did you, {#Emph}erm... {#Prev}wouldn't you have needed...?" },
				{ Cue = "/VO/Arachne_0054",
					Text = "A {#Emph}mate? {#Prev}Oh, he didn't stick around. So you see, this curse isn't just {#Emph}mine. {#Prev}It's for generations still to come. Perhaps we spiders aren't so different from you gods. {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift03", "ArachneAboutGods05" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0083",
					Text = "I never truly stopped to think how much alike we are, the two of us. Both outcasts, aren't we? You should be living in a {#Emph}palace! {#Prev}Not... talking to a {#Emph}spider {#Prev}in the middle of nowhere." },
				{ Cue = "/VO/MelinoeField_1783", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And you should be the most-renowned, most-beloved weaver in all the land! But that isn't what the Fates had in store for us. Although... it's not all bad, is it?" },
				{ Cue = "/VO/Arachne_0084",
					Text = "It isn't? It... isn't. Because if I was still up there... the envy of gods and mortals alike... I wouldn't have met {#Emph}you. {#Prev}My one true friend. {#Emph}Ha ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutRelationship02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift06" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0116",
					Text = "About last time... I know that there are others in your life, whom you care about. And that makes me glad. You should feel {#Emph}loved! {#Prev}A lot! But look at {#Emph}me... {#Prev}all I can do a lot is {#Emph}weave." },
				{ Cue = "/VO/MelinoeField_1803", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your size has nothing to do with the love you can give. But how you feel about yourself... it must affect the love you can receive. Whether you can believe it to be true." },
				{ Cue = "/VO/Arachne_0117",
					Text = "You make me feel how I used to feel. And back then...? Back when I used to be myself? You know, we mortals could be {#Emph}just {#Prev}as jealous as the gods. But knowing that you care for me even a little bit, why... it's more than enough. Here, go..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutGods01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusFirstPickUp", "ArachneAboutArtemis01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0069",
					Text = "So then the gods above are helping you, aren't they? Though why do I even ask, I already know. I've seen these woods light up with all their multicolored messages..." },
				{ Cue = "/VO/MelinoeField_1776", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's true. Olympus and I share a common goal, for the Titan of Time threatens us all. I should have told you, it's just... I didn't know what to say." },
				{ Cue = "/VO/Arachne_0070",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Hah, ha ha ha ha{#Prev}... so the Fates got me {#Emph}again. {#Prev}I may be a better weaver than all the gods combined, but those three beat me {#Emph}every time. {#Prev}Though don't worry! I won't turn my abdomen on you. Even if the gods will benefit..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods01" }
					},
				},

				{ Cue = "/VO/MelinoeField_1777", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You seem distant, Arachne. Is everything all right? Is this about my aiding the Olympians?" },
				{ Cue = "/VO/Arachne_0071",
					Text = "{#Emph}Ah, hahaha... {#Prev}wait. What do you mean {#Emph}you're {#Prev}aiding the Olympians? I thought you said it was the other way around! They're helping {#Emph}you!" },
				{ Cue = "/VO/MelinoeField_1778", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Same difference, isn't it? A mutual exchange. Like a friendship! There must be reciprocity. But, I know this puts you in a terrible position, and... I would never take your support for granted." },
				{ Cue = "/VO/Arachne_0072",
					PreLineWait = 0.2,
					Text = "Well! You may know {#Emph}all {#Prev}about the gods, more than I. But it seems you have a thing or two to learn still when it comes to {#Emph}friendship. {#Prev}Even a little old spider knows that! Now have a dress." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods02" }
					},
				},

				{ Cue = "/VO/Arachne_0073",
					Text = "I know you don't know what to say, my friend. But I want you to know... you don't have to say anything at all! In fact, I'd rather that you didn't right now. Be safe out there, all right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods03" }
					},
				},

				{ Cue = "/VO/Arachne_0074",
					Text = "Another evening where you're forced to do the bidding of the gods? It's not a {#Emph}partnership {#Prev}you've got with them, you know. They'll tolerate you just as long as they think you're {#Emph}inferior {#Prev}to them. Now, here. Take this and go." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods04" }
					},
				},

				{ Cue = "/VO/Arachne_0075",
					Text = "You know the gods did this to me, don't you? Although I shouldn't say {#Emph}the {#Prev}gods. Was truly just the one. But the others... they didn't {#Emph}care. {#Prev}They were complicit in the whole thing! It was as though {#Emph}I {#Prev}was a spider to them all along." },
				{ Cue = "/VO/MelinoeField_1779", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne... the gods could be kinder to mortals. You'll hear no argument from me on that. I've a certain point of view on it, myself. Most mortals I've met... they've all been dead." },
				{ Cue = "/VO/Arachne_0076",
					Text = "Yet you abide Olympus, anyhow. I understand, I do! They're family. And that's one thing we can never change... not really. Although the Titan whom you're up against... isn't he family, too? {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods05" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZeusAboutAthena01", "ApolloAboutAthena01", "AphroditeAboutAthena01", }
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Arachne_0077",
					Text = "So what's she truly like? {#Emph}Gray-eyed Athena. {#Prev}As wise and calculating as they say? {#Emph}Ha ha ha ha... {#Prev}to think she's supposedly the {#Emph}sensible {#Prev}one. She's just as cruel and vindictive as the rest..." },
				{ Cue = "/VO/MelinoeField_1780", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't know. I've heard from most of the Olympians by now, but not Athena. Sounds like she's got her hands full, holding back the Titan's armies gathered at the mountain's base." },
				{ Cue = "/VO/Arachne_0078",
					Text = "How very noble of her. Well, if you meet eventually, you'll have to tell me how she is. And do feel free to let her know Arachne's still alive and well, and weaving even {#Emph}better {#Prev}than before." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomCountCache", "F_Boss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0055",
					Text = "Saw you get into a scuffle with the great big witch. Why are you fighting? I thought you were on the same side! {#Emph}Oh{#Prev}, I can hardly keep up with everything lately." },
				{ Cue = "/VO/Melinoe_1813", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress and I aren't really fighting. Well... no, I suppose we are, except it isn't borne of anger, or misunderstanding. It's just her way of making certain I'm prepared." },
				{ Cue = "/VO/Arachne_0056",
					Text = "{#Emph}Huh. {#Prev}Well, look, you show her for me the next chance you get, won't you, my friend? And, no pressure! But I might be watching just in case. I won't get underfoot, I promise." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutHecate02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "F_Boss01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutGods05" }
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Hecate_01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0057",
					Text = "How fares the big witch, by the by, my friend? I often see her in these woods! And every now and then, she says hello. Makes time for little old Arachne. How {#Emph}ungodlike {#Prev}of her, {#Emph}ha ha ha ha..." },
				{ Cue = "/VO/MelinoeField_1787", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress seems as steady as can be. It's strange... her confidence in my ability is one of the greatest sources of pressure that I feel. Although, I can't exactly tell her that..." },
				{ Cue = "/VO/Arachne_0058",
					Text = "And whyever not? I'd always want to hear the honest truth from you. She's a smart one, no? Likely she knows that something's off. You ought to have a little {#Emph}chat{#Prev}, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutArtemis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1490", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, I don't suppose you happened to see a woodsy goddess stalking through? Greenish attire, wielding a bow about her height?" },
				{ Cue = "/VO/Arachne_0061",
					Text = "I know which one you mean, my friend, and I know she's been nosing about. As a rule, I stay away from goddesses like {#Emph}that. {#Prev}Even if they are your kin." },
				{ Cue = "/VO/MelinoeField_1491", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Goddesses like what? You make it sound as though you fear Olympus more than you fear Chronos himself." },
				{ Cue = "/VO/Arachne_0062",
					Text = "Oh, I {#Emph}do. {#Prev}It's not Chronos that made me this way; if anything I've grown more used to it with time. Now, go find your woodsy goddess. And be careful not to lead her here, all right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "F_PreBoss01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Charon_01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CharonGift02", "ArachneGift02" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0059",
					Text = "The other night, I saw you having conversation with the old Boatman who's been showing up more frequently of late. How's he doing, anyway?" },
				{ Cue = "/VO/MelinoeField_1788", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon takes just about everything in stride. But until he's back to ferrying the dead to their final resting-places, I don't think he'll be entirely himself." },
				{ Cue = "/VO/Arachne_0060",
					Text = "I remember when I stowed away on his little boat! He somehow spotted me amongst his cargo. Oh, I thought I was a goner! But he just kept on. Even stopped for me in Erebus, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ArmorGainKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0119",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, that's the Sash I gave to you! Isn't it so very soft? May it help keep you warm and safe, wherever your journeys may take you. Now, {#Emph}here's {#Prev}a little something to match..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0129",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Ah! {#Prev}No, wha-what is that? An amphibian?! Do get it out of here, my friend! {#Emph}Please {#Prev}help me get it out!" },
				{ Cue = "/VO/MelinoeField_1804", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Steady yourself, Arachne. This is Frinos! Frinos is a friend; a familiar friend of mine, in fact. He means you no harm at all. Your stash of flies, however... that we may need to safeguard." },
				{ Cue = "/VO/Arachne_0130",
					Text = "Oh, {#Emph}haha, ah {#Prev}that is a {#Emph}relief! {#Prev}Well, then, {#Emph}Frinos... {#Prev}if indeed you are a friend, then you are welcome here. And if you'd like a bite to eat, then you are {#Emph}more {#Prev}than welcome to that, too." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCatFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0131",
					Emote = "PortraitEmoteSurprise",
					Text = "Is that {#Emph}your {#Prev}cat, my friend? I don't much care for how it's giving me the {#Emph}eye. {#Prev}Good thing I'm way up here, {#Emph}haha! {#Prev}Though wait... can't those things {#Emph}climb?" },
				{ Cue = "/VO/MelinoeField_1805", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't worry, this is Toula, my familiar. And she'll keep her feline instincts well in check around Arachne, won't you, girl?" },
				{ Cue = "/VO/Arachne_0132",
					Text = "I used to love cats... they just don't get on with me quite like they used to. For obvious reasons, I suppose..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutMines01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "BloodMinePreFused" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "BloodMinePreFused" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0121",
					Text = "Sorry for all those silk-bombs out there, by the by! All these caustic little mud bubbles I try to wrap up and simmer down. But, if you pop them early, they go up like a moth in a flame, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGuards01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Guard" },
						Comparison = ">=",
						Value = 20,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Guard" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0122",
					Text = "Those Whispers that you see floating about... it's just what happens when a Shade gets caught up in the trees. In time, they can't tell where the branches end and they begin. They're angry, sure. But not with {#Emph}you{#Prev}, my friend." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutRadiators01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Radiator" },
						Comparison = ">=",
						Value = 20,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Radiator" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0123",
					Text = "Shades of all sorts wind up in here, you know. Those little Spindles all throughout this place... I don't know what they even were when they drew breath. All I know is that they died before their time. Well, so it goes, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutBrawlers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Brawler" },
						Comparison = ">=",
						Value = 20,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Brawler" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0124",
					Text = "I liked it better when there weren't all those Wastrels around here. I think they lost their way before they died. Now that they're all long gone... we get to see them for exactly what they are, don't we now?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutMages01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Mage" },
						Comparison = ">=",
						Value = 30,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Mage" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0125",
					Text = "How many Caskets have you had to fend aside, do you suppose? First sign of anything that breathes, and they flock to it like it's going out of style. And, always with the {#Emph}spitting! {#Prev}At least I'm much too small for them to see." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutSiegeVines01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "SiegeVine_Elite" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "CurrentRun", "EnemyKills" },
						HasAny = { "SiegeVine", "SiegeVine_Elite" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0126",
					Text = "Do watch for Thorn-Weepers out there. Thank goodness for my webs, as I can stay up high where all those nasty vines of theirs can't reach. But as for {#Emph}you{#Prev}, you're easy pickings, bare feet and all..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutFogEmitters01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "FogEmitter_Elite" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "FogEmitter_Elite" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0127",
					Text = "Not seen too many Shadow-Spillers hereabouts! Good thing, since it's been plenty dark such as it is. How so many souls manage getting themselves {#Emph}tangled up {#Prev}like that, I never want to know..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutTreants01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Treant" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Treant" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0128",
					Text = "You must have seen more than your share of Root-Stalkers by now. It's fortunate for me that they mostly like to stay put, so I can keep out of their way. But you're bigger, and you can't just slip by, huh...?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			-- Repeatable
			ArachneChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0004",
					Text = "Surely you saw some of the weavings I've been working on along the way?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0005",
					Emote = "PortraitEmoteCheerful",
					Text = "I'm so grateful that you're here! Please make yourself at home." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0006",
					Text = "I know there's not much I can do to help, but here." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat04 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0007",
					Text = "It's always so nice to see you. You do know that, don't you?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0008",
					Text = "Just watch your step out there as best you can, all right? {#Emph}Hm hm hm hm hm..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0009",
					Text = "I wove each of these with love and care for {#Emph}just {#Prev}such an evening!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0010",
					Text = "Oh, don't worry about all those webs. I was going to replace them anyhow!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat08 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0011",
					Text = "I want you looking your {#Emph}very {#Prev}best out there tonight, my friend." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat09 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0012",
					Text = "My latest fits are light as a feather, and sturdy as silver, you'll see!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat10 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0013",
					Emote = "PortraitEmoteCheerful",
					Text = "Welcome back to {#Emph}Arachne's Garments, Dyes, and Fabrics! {#Prev}How may I be of service?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0014",
					Emote = "PortraitEmoteCheerful",
					Text = "Thank you for visiting {#Emph}Arachne's Garments, Dyes, and Fabrics! {#Prev}Please come again!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat12 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0015",
					Text = "Well, if it isn't my favorite customer! What might I do for you this eve?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0016",
					Text = "I know you can't stay for long... but it's wonderful to see you here, my friend." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat14 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0017",
					Text = "I've plenty of these freshly woven garments here from which to choose!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat15 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0018",
					Text = "My silk is stronger than it looks, so may it help to keep you safe out there." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat16 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0019",
					Text = "You look absolutely stunning dressed in silk, you know that, right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0020",
					Text = "Do try one of these on for size, my friend, then I'll get out of your hair." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat18 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0021",
					Text = "I know my little lair is a bit out of your way, so thanks for visiting me here." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0022",
					Text = "You sure you wouldn't like to try a couple flies? They're fresh!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat20 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0023",
					Text = "So, do you... see anything you like? {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat21 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0024",
					Text = "Oh, do watch for some of my cocoons out there! I packed them just for you." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat22 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0025",
					Text = "You won't find higher-quality silk anywhere above the surface or below." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat23 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0026",
					Text = "Oh, I miss you already. You'll come back soon, won't you?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat24 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0027",
					Text = "Seeing you under the light of the full moon, why, it just takes my breath away." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat25 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0028",
					Text = "I thought I heard you softly moving through the trees, and now you're here!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat26 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0029",
					Text = "If only there was more that I could do for you, my friend..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat27 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0030",
					Text = "It must be very difficult for you right now, but do take heart, all right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat28 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0031",
					Text = "Promise you'll let me know if this is anything short of a perfect fit." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat29 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0032",
					Text = "They always said my silk was like a warm embrace, {#Emph}ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneChat30 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Arachne",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMutteringRepeatable,

				{ Cue = "/VO/Arachne_0033",
					Text = "I won't have you going out in anything less than the very best." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

		},

		GiftTextLineSets =
		{
			ArachneGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
				},
				{ Cue = "/VO/Melinoe_1606", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Each time I pass through Erebus, it's comforting to know I may run into you along the way. Here's something for your lovely lair." },
				{ Cue = "/VO/Arachne_0106",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh, why this is very sweet! It should attract a host of flies, I think, so thank you, very, {#Emph}very {#Prev}much! Now won't you please take this? It's only fair...!" },
			},
			ArachneGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
				},
				{ Cue = "/VO/Arachne_0107",
					Emote = "PortraitEmoteSurprise",
					Text = "Wait, is this what I think it is? Oh, {#Emph}no{#Prev}, I shouldn't, not again. Weaving silken fineries for somebody such as you truly is an honor and its own reward! Besides, this stuff is for the gods..." },
				{ Cue = "/VO/MelinoeField_1797", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The gods may often be the ones indulging in this stuff, but it's not just for them. It's for you! For those whom we regard as friends." },
			},
			ArachneGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
				},
				{ Cue = "/VO/Arachne_0108",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Oh{#Prev}, you're much too kind to me! I'm only doing what anybody would be doing in my place, but {#Emph}you? {#Prev}You're treating me like royalty! This Nectar... I tried a touch of it before. It's too good for flies... or spiders." },
				{ Cue = "/VO/MelinoeField_1798", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Too good for flies, perhaps. But it's especially for {#Emph}you. {#Prev}A gift of friendship, whose savor only grows the deeper the friendship is. May it warm you on a cold night such as this." },
			},
			ArachneGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_ArachneGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutRelationship01" }
					},
				},
				{ Cue = "/VO/Arachne_0109",
					Emote = "PortraitEmoteCheerful",
					Text = "Come now, this is all too much! If I were still myself, why, I'd be blushing from my cheeks to my toes. It's just... it's been so long since anybody got me anything, you know?" },
				{ Cue = "/VO/MelinoeField_1799", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I like getting you such things, Arachne. It makes me so unhappy, sometimes, seeing you all by yourself like this. I can never stay for long... so perhaps this Nectar can remind you of the pleasant times we share, when I'm not around." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					ObjectType = "NPC_Arachne_01",
					{ Cue = "/VO/Arachne_0110", Text = "It most certainly shall. I won't forget your kindness." },
				},
			},
			ArachneGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
				},
				{ Cue = "/VO/Arachne_0111",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Ha ha ha ha{#Prev}, I don't mean to be rude, it's just... {#Emph}imagine {#Prev}what the gods above would think, seeing their {#Emph}proudest {#Prev}tradition used to honor the {#Emph}lowliest {#Prev}of creatures in this world." },
				{ Cue = "/VO/MelinoeField_1800", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're not lowly! You're a magnificent talent. A beautiful voice. A trusted friend. I don't know anybody like you, Arachne! And I'm glad you're {#Emph}you. {#Prev}Exactly as you are. I mean it." },
				{ Cue = "/VO/Arachne_0112",
					Emote = "PortraitEmoteSurprise",
					Text = "I... why, I'm — I'm very flattered you would feel that way... it's just... it's too bad you never knew me in my prime, you know? {#Emph}Ah{#Prev}, but what am I saying, I'm just... {#Emph}ha ha ha ha..." },
			},
			ArachneGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
				},
				{ Cue = "/VO/Arachne_0113",
					Text = "I know you're doing this just to be kind, my friend, except... the heart does what it wants, and... I, well... I'm concerned I'm beginning to take it the wrong way! I like being alone, I do... but I get lonely still, from time to time." },
				{ Cue = "/VO/MelinoeField_1801", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I get lonely, too. But when I'm here, with you in your lovely little lair, I feel... oh I don't know, I... just want you to be happier! Perhaps it's as you said; the heart does what it wants." },
				{ Cue = "/VO/Arachne_0114",
					Text = "Oh, your poor heart, if all it wants is {#Emph}this! {#Prev}You're a goddess... positively sublime, you realize? You must have a dozen others falling over themselves just to win your affection!" },
				{ Cue = "/VO/MelinoeField_1802", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Even if there were. My other relationships... none of them is any substitute for the one I have with you." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					RequiredMinElapsedTime = 2,
					ObjectType = "NPC_Arachne_01",
					{ Cue = "/VO/Arachne_0115", Text = "I see... {#Emph}ha ha ha ha..." },
				},
			},

			-- placeholder
			ArachneGiftTemp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "UnavailableHeartIcon",
				HintId = "Codex_UnavailableHint",
				Cost =
				{
					MysteryResource = 1,
				},
			},

		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1915", Text = "Arachne, this is beautiful...!" },
		},

		LastStandReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Story01" },
					},
				},
				Cooldowns =
				{
					{ Name = "ArachneSpokeRecently", Time = 7 },
				},

				{ Cue = "/VO/Arachne_0250", Text = "You can do this!" },
				{ Cue = "/VO/Arachne_0251", Text = "You have this!" },
				{ Cue = "/VO/Arachne_0252", Text = "Come on, come on...!" },
				{ Cue = "/VO/Arachne_0253", Text = "Oh no...!" },
				{ Cue = "/VO/Arachne_0254", Text = "I can't look...!", PlayFirst = true },
				{ Cue = "/VO/Arachne_0255", Text = "{#Emph}<Gasp>" },
			},
		},

		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 0.7,
		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Arachne_01",
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasNone = GameData.ArachneUpsetEvents,
				},
			},
			Cooldowns =
			{
				{ Name = "ArachneSpokeRecently", Time = 7 },
			},

			{ Cue = "/VO/Arachne_0289", Text = "Hey!", PlayFirst = true },
			{ Cue = "/VO/Arachne_0290", Text = "Whoa there!" },
			{ Cue = "/VO/Arachne_0291", Text = "You want to play?" },
			{ Cue = "/VO/Arachne_0292", Text = "Missed me!" },
			{ Cue = "/VO/Arachne_0293", Text = "Can't catch me!" },
			{ Cue = "/VO/Arachne_0294", Text = "Too slow!" },
			{ Cue = "/VO/Arachne_0295", Text = "Missed again!" },
			{ Cue = "/VO/Arachne_0296", Text = "{#Emph}Haha{#Prev}, you missed!" },
			{ Cue = "/VO/Arachne_0297", Text = "Almost!" },
			{ Cue = "/VO/Arachne_0298", Text = "{#Emph}Ahh! {#Prev}Kidding. You missed." },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Arachne )