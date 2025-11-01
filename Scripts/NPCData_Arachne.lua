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
		LoadPackages = { "Arachne", },
		SubtitleColor = Color.ArachneVoice,
		EmoteOffsetY = -50,
		EmoteOffsetX = 30,

		RequiredRoomInteraction = true,
		BlockedLootInteractionText = "NPCUseTextTalkLocked",
		GiftTrackNPCVariant = "NPC_Arachne_Home_01",

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA3",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeArachneSash2",
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
			"SpellCostume",
			"EscalatingCostume",
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
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				ObjectTypes = { "NPC_Arachne_01", "NPC_Arachne_Home_01" },
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ArachneBrooding" },
				},
				{ Cue = "/VO/Arachne_0157", Text = "Be well, won't you?" },
				{ Cue = "/VO/Arachne_0158", Text = "Take care out there." },
				{ Cue = "/VO/Arachne_0151", Text = "And to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0152", Text = "How do you do?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0153", Text = "Thank you kindly.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0154", Text = "Oh I know my way around.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0155", Text = "Wherever we may go.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709", "/VO/Melinoe_2787" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0156", Text = "Appreciate the thought.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709", "/VO/Melinoe_2785", "/VO/Melinoe_2786", "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0159", Text = "You're awfully polite.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0160", Text = "No need to be so formal here.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Arachne_0161", Text = "Oh, {#Emph}you!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/Melinoe_1700", "/VO/Melinoe_1700_2" },
						},
					},
				},
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
					-- Portrait = "Portrait_Arachne_Brooding_01",
					-- Portrait = "Portrait_Arachne_Default_01",
					-- Portrait = "Portrait_Arachne_Brooding_02",

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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0118",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Arachne_Brooding_01",
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
					Text = "My silk is everything to me! It's stronger than it looks. Keeps me safe! It can suffocate even the strongest prey. Don't you like it? Is there a certain pattern-color combination you admire?" },

				{ Cue = "/VO/Melinoe_1806", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's lovely, Arachne. Look, I wish I could stay and admire it, but..." },

				{ Cue = "/VO/Arachne_0035",
					Text = "...But you can't. I understand, I truly do. Though it {#Emph}would {#Prev}mean a lot to me if you would take some of my silk with you on your way." },
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
					Portrait = "Portrait_Arachne_Brooding_01",
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
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "G_Boss01", "G_Boss02" },
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "N_Boss01", "N_Boss02" },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1487", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're always here all by yourself. The woods are filled with spiders... don't you ever get together, something like that? Make great big webs you couldn't on your own?" },
				{ Cue = "/VO/Arachne_0368",
					PreLineWait = 0.35,
					Text = "Well I suppose we certainly could. It's just, I happen to {#Emph}hate {#Prev}spiders. Near as I can tell, all spiders do. Weaving's a solitary exercise, and besides... I much prefer {#Emph}your {#Prev}company." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutSpiders01", "ArachneGift04" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0053",
					Portrait = "Portrait_Arachne_Brooding_01",
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
			ArachneAboutRelationship03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift06", "ArachneAboutRelationship02" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0392",
					Text = "I've kept on thinking, my friend... about how I've been drawn to you. Like a fly to one of my webs... except I mean to catch {#Emph}them{#Prev}, and I don't think you've meant to do the same to me." },

				{ Cue = "/VO/MelinoeField_4398", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course I haven't meant to {#Emph}catch {#Prev}you, Arachne. It's as I said... I think we've helped keep each other company in these lonesome woods, but... is there... something more?" },

				{ Cue = "/VO/Arachne_0393",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Arachne_Default_01", WaitTime = 5.3 },

					Text = "I... I don't think so, no. Not while I'm the way I am. The girl I {#Emph}used {#Prev}to be, why... she may have been mortal, but she was a {#Emph}lot {#Prev}better than this, {#Emph}ha ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutRelationship04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift07", "ArachneAboutCurseQuest01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0394",
					Text = "Lately, when I'd long to be a girl again, my friend... I think it was in part because I liked the thought that I could be with you. You know, like in a normal way." },

				{ Cue = "/VO/MelinoeField_4399", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne, what we have is special. Even if I met the mortal girl you once were, I'd likely not have taken notice in the same way. Mortal Shades are commonplace... you're not." },

				{ Cue = "/VO/Arachne_0395",
					Text = "I do appreciate you saying that. Back when I gave Athena a piece of my mind... I knew I was giving something up. But it was just a fantasy, while {#Emph}we {#Prev}have something {#Emph}real." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			-- arachne curse subplot
			ArachneAboutGods01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusFirstPickUp", "ArachneAboutArtemis01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0069",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "So then the gods above are helping you, aren't they? Though why do I even ask, I already know. I've seen these woods light up with all their multicolored messages..." },

				{ Cue = "/VO/MelinoeField_1776", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's true. Olympus and I share a common goal, for the Titan of Time threatens us all. I should have told you, it's just... I didn't know what to say." },

				{ Cue = "/VO/Arachne_0070",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Arachne_Brooding_01",	
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
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "ArachneAboutGods01" }
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1777", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You seem distant, Arachne. Is everything all right? Is this about my aiding the Olympians?" },

				{ Cue = "/VO/Arachne_0071",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "{#Emph}Ah, hahaha... {#Prev}wait. What do you mean {#Emph}you're {#Prev}aiding the Olympians? I thought you said it was the other way around! They're helping {#Emph}you!" },

				{ Cue = "/VO/MelinoeField_1778", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Same difference, isn't it? A mutual exchange. Like a friendship! There must be reciprocity. But, I know this puts you in a terrible position, and... I would never take your support for granted." },

				{ Cue = "/VO/Arachne_0072",
					Portrait = "Portrait_Arachne_Brooding_01",
					PreLineWait = 0.2,
					Text = "Well! You may know {#Emph}all {#Prev}about the gods, more than I. But it seems you have a thing or two to learn still when it comes to {#Emph}friendship. {#Prev}Even a little old spider knows that! Now have a dress." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods02" }
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0073",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "I know you don't know what to say, my friend. But I want you to know... you don't have to say anything at all! In fact, I'd rather that you didn't right now. Be safe out there, all right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods03" }
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0074",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",

					Text = "Another evening where you're forced to do the bidding of the gods? It's not a {#Emph}partnership {#Prev}you've got with them, you know. They'll tolerate you just as long as they think you're {#Emph}inferior {#Prev}to them. Now, here. Take this and go." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutGods04" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0075",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "You know the gods did this to me, don't you? Although I shouldn't say {#Emph}the {#Prev}gods. Was truly just the one. But the others... they didn't {#Emph}care. {#Prev}They were complicit in the whole thing! It was as though {#Emph}I {#Prev}was a spider to them all along." },

				{ Cue = "/VO/MelinoeField_1779", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne... the gods could be kinder to mortals. You'll hear no argument from me on that. I've a certain point of view on it, myself. Most mortals I've met... they've all been dead." },

				{ Cue = "/VO/Arachne_0076",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Yet you abide Olympus anyhow! I understand, I do. They're family. And that's one thing we can never change... not really. Although the Titan whom you're up against... isn't he family, too? {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			-- alt below
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
						HasAny = { "ZeusAboutAthena01", "ApolloAboutAthena01", "AphroditeAboutAthena01", "HermesAboutAthena01" }
					},
					{
						PathFalse = { "GameState", "UseRecord", "NPC_Athena_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArachneAboutGods06_B" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				-- shorter variant of this line is below, 0077_B
				{ Cue = "/VO/Arachne_0077",
					Text = "So what's she truly like? {#Emph}Gray-eyed Athena. {#Prev}As wise and calculating as they say? {#Emph}Ha ha ha ha... {#Prev}to think she's supposedly the {#Emph}sensible {#Prev}one. She's just as cruel and vindictive as the rest..." },

				{ Cue = "/VO/MelinoeField_1780", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't know. I've heard from most of the Olympians by now, but not Athena. Sounds like she's got her hands full, holding back the Titan's armies gathered at the mountain's base." },

				{ Cue = "/VO/Arachne_0078",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "How very noble of her! If you meet eventually, you'll have to tell me how she is. And do feel free to let her know Arachne's still alive and well, and weaving even {#Emph}better {#Prev}than before." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutGods06_B =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Athena_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArachneAboutGods06" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0077_B",
					Text = "So what's she truly like? {#Emph}Gray-eyed Athena. {#Prev}As wise and calculating as they say? {#Emph}Ha ha ha ha... {#Prev}to think she's supposedly the {#Emph}sensible {#Prev}one." },

				{ Cue = "/VO/MelinoeField_2721", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... don't hear from her quite like most of the rest. She must really have her hands full, holding back the Titan's armies gathered at the mountain's base." },

				{ Cue = "/VO/Arachne_0078_B",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "How very noble of her! Do feel free to let her know Arachne's still alive and well, and weaving even {#Emph}better {#Prev}than before." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			-- arachne curse subplot
			ArachneAboutPride01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ArachneAboutGods06", "ArachneAboutGods06_B" }
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0079",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Should I have held back? When I was challenged by the gods themselves? To decide who was the {#Emph}greatest {#Prev}weaver of all. I was just a mortal girl. Can you imagine the pressure?" },

				{ Cue = "/VO/MelinoeField_1781", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't have held back either, in your place. When our limits are put to the test... only then can we discover who we really are." },

				{ Cue = "/VO/Arachne_0080",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",

					Text = "All I discovered was I ceased being a mortal girl anymore. You should have {#Emph}seen {#Prev}the masterpiece I made! Athena's little {#Emph}tapestry {#Prev}wasn't even close. Maybe it was worth it... my humiliation in exchange for hers..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = {
							"ArachneAboutPride01",
							"ArachneGift03",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ArachneAboutHecate02", "ArachneWithHecateInHub01" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0089",
					Text = "My friend, I truly hate to ask, but you don't suppose... knowing your craft, you don't suppose there might still be some way to turn me back into myself again, do you?" },

				{ Cue = "/VO/MelinoeField_1790", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne... I've tried everything I know. This curse of metamorphosis upon you, it's... well, it's extremely powerful. Such change is irreversible as far as I can tell. I'm sorry." },

				{ Cue = "/VO/Arachne_0090",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",

					Text = "That's quite all right. Just figured I would ask. Such curses wouldn't be much good if they could just be waved away, now, would they? {#Emph}Ha ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutCurse01", "HecateBossAboutArachne01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1791", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne, I... I wasn't entirely forthright with you before, about your curse. Theoretically, there is a way that it can be undone. But it is unlikely to work, and shall be very dangerous." },

				{ Cue = "/VO/Arachne_0091",
					Portrait = "Portrait_Arachne_Brooding_01",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}What? {#Prev}I don't care what it takes, you have to tell me, my friend, {#Emph}please!" },

				{ Cue = "/VO/MelinoeField_1792", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "First, we must discover the source of the curse; Athena is no enchantress. Someone aided her. And second... Athena herself must change her original intent. She has to want this." },

				{ Cue = "/VO/Arachne_0092",
					Portrait = "Portrait_Arachne_Brooding_01",
					Emote = "PortraitEmoteDepressed",
					Text = "But she {#Emph}despises {#Prev}me! And why would she tell anybody who provided her the curse? Oh, my friend, I almost wish you hadn't told me! Don't bother, {#Emph}ha ha ha ha. {#Prev}Hope can be such a tease..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateAboutArachne03", "ArachneAboutCurse02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1793", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Regarding your curse, Arachne... Headmistress discovered who created it. So, if you require closure on this aspect of your life... come visit at the Crossroads. But, such knowledge may be a curse all its own, so... choose carefully, please." },
				{ Cue = "/VO/Arachne_0093",
					Portrait = "Portrait_Arachne_Brooding_01",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh... why... I suppose that I'll be giving that some thought! What would I even do different, knowing something like that? Give me some time... all right, my friend?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateWithArachne01_FollowUp" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_1794", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...Are you all right, my friend?" },
				{ Cue = "/VO/Arachne_0094",
					Emote = "PortraitEmoteSurprise",
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "I... {#Emph}yes! {#Prev}Yes, I've some new dresses for you. Here! Which one do you desire?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutCurse04" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,
				
				{ Cue = "/VO/MelinoeField_1795", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne, we need to talk about what happened with Headmistress. She didn't fashion a poison expressly to ruin your life. She didn't even know you at the time." },
				{ Cue = "/VO/Arachne_0095",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "Don't you think I know all that? But what am I supposed to do, {#Emph}thank {#Prev}her? I may be very small, my friend, but I still have my pride... and you can still have your dress." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurse06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutCurse05" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArachneCurseQuest01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,
				
				{ Cue = "/VO/Arachne_0096",
					Text = "So much talk of late about my curse! Let's just go back to how things were, what do you say? All this {#Emph}tension... {#Prev}I don't need it anymore than you. You were only trying to help. And so am I." },

				{ Cue = "/VO/MelinoeField_1796", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I just want you to be well, that's all. The past has already transpired and can't be changed. But {#Emph}we {#Prev}get to decide what happens next." },

				{ Cue = "/VO/Arachne_0097",
					Text = "Perhaps we do! Either we or the Fates, I suppose. Thank you for listening to me, my friend. And you be well yourself, all right?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneCurseQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AthenaAboutArachne03" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_4390", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					-- Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Arachne, now that we know Headmistress Hecate had a hand in your curse, there is some possibility we can persuade Athena to undo it. Or rather, you could." },

				{ Cue = "/VO/Arachne_0379",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Why don't you humor me some more with this, my friend. What exactly do you have in mind? Olympus is a bit of a climb from here..." },

				{ Cue = "/VO/MelinoeField_4391", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I've a more convenient means in mind: a certain Amulet that I can use to briefly summon her. If it's all right with you, then she can join us here, and you can make your plea." },

				{ Cue = "/VO/Arachne_0380",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "What would I even say? But... {#Emph}oh{#Prev}, I'll certainly give it some thought. Next time you have that Amulet, then I {#Emph}might {#Prev}take you up on that. Thank you." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneCurseQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneCurseQuest01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_4392", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "I have Athena's Amulet, Arachne. Would you be willing to confront her now? Just, speak to how you've changed, how you wish to have your old self back! Whatever she requires." },

				{ Cue = "/VO/Arachne_0381",
					PreLineWait = 0.35,
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "I'll... I'll do what I have to do, my friend. Now, if you could bring forth the goddess of wisdom, I'd be much obliged." },

				{ Cue = "/VO/MelinoeField_4393", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 4, PowerWordPresentation = true, PowerWordWaitTime = 8.4 },

					PostLineFunctionName = "SummonAthena",
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "Very well, here goes. And whatever happens, I'll be right here. {#Emph}Heed now my voice, Lady Athena; one who has sought you is with me!" },

				{ Cue = "/VO/Athena_0249",
					PreLineWait = 1.0,
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					Text = "Hail, Melinoë. {#Emph}Ah{#Prev}, these woods. And sure enough there's the World's Most Talented Weaver herself. Still plying your trade, Arachne?" },

				{ Cue = "/VO/Arachne_0382",
					Text = "I most certainly am, Lady Athena! What else would I be doing? Even if I were still the mortal girl I once was, I imagine I'd have stuck with it. And you, how have you been?" },

				{ Cue = "/VO/Athena_0250",
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					Text = "Fully occupied. I cannot remain for long, for that reason and more, so what is it? You've grown tired of your form?" },

				{ Cue = "/VO/Arachne_0383",
					Text = "Well I do miss my old shape and size, and... I've been like this for a while, so... I thought maybe you could turn me back. I'd do anything, please." },

				{ Cue = "/VO/Athena_0251",
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					Text = "{#Emph}Anything? {#Prev}Then I've a simple-enough request: Apologize for what you did in all sincerity, and tell me what you've learned." },

				{ Cue = "/VO/Arachne_0384",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Arachne_Brooding_01", WaitTime = 9 },

					Text = "Oh, why, sure... {#Emph}um{#Prev}, I'm... I'm sorry, Lady Athena. Truly sorry. Sorry that I would... debase myself in front of you like this! In front of my own friend!" },

				{ Cue = "/VO/MelinoeField_4394", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "{#Emph}Arachne! {#Prev}Please, Lady Athena, she's upset and hasn't thought this through. I know how sorrowful she is." },

				{ Cue = "/VO/Arachne_0385",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Stay out of this, my friend. As for {#Emph}you{#Prev}, Lady Athena, you want to know what I learned?" },

				{ Cue = "/VO/Athena_0252",
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					Text = "I caution you to measure your words with care, spider. I did not travel all this way to be the object of your ridicule." },

				{ Cue = "/VO/Arachne_0386",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "...I learned, just now, that I'll {#Emph}never {#Prev}apologize to you {#Emph}in all sincerity. {#Prev}I'd sooner be a lowly spider till the end of time. And look upon my works! I can {#Emph}still {#Prev}weave better than you." },

				{ Cue = "/VO/Athena_0253",
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					PreLineWait = 0.35,
					Text = "...I suppose you think this outburst moved me in some way, and that I'll now grant your desire? No. You may appear worse off, but you clearly haven't changed at all, Arachne." },

				{ Cue = "/VO/Arachne_0387",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Neither have you. Now either go on and squash me like I know you want to, or be on your way. You're scaring the flies." },

				{ Cue = "/VO/Athena_0254",
					Speaker = "NPC_Athena_01",
					Portrait = "Portrait_Athena_Default_01",
					PreLineWait = 0.35,
					PostLineFunctionName = "UnSummonAthena",
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "Fine. I'll take my leave, and we shall never see each other again. Enjoy the feast of flies. Melinoë? This was a mistake." },

				{ Cue = "/VO/MelinoeField_4395", UsePlayerSource = true,
					PreLineWait = 1.65,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "Arachne... why did you do that? We went through so much for this one chance, and now it's gone!" },

				{ Cue = "/VO/Arachne_0388",
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "No, my friend. That was the chance I had been waiting for. I just didn't realize it till I looked Athena in the eyes again. Now, {#Emph}shoo. {#Prev}I've kept you long enough. {#Emph}Ha ha ha ha..." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachneAboutCurseQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneCurseQuestComplete01" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,
				
				{ Cue = "/VO/Arachne_0389",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Turns out, apologizing to Athena just isn't for me, my friend. However, I apologize to you. For making you go out of your way... making a scene in front of another goddess. Sorry." },

				{ Cue = "/VO/MelinoeField_4396", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...Oh, Arachne. I'd have rather you said that to Lady Athena and gotten what you desired. I doubt you'll have another opportunity." },

				{ Cue = "/VO/Arachne_0390",
					Portrait = "Portrait_Arachne_Brooding_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Arachne_Default_01", WaitTime = 7.0 },
					Text = "It's quite all right. When I saw Athena again, all battle-weary but same as ever, something in me snapped. And now I'm free! You gods have been having a time... turns out you face the consequences of your pride, same as any of us." },

				{ Cue = "/VO/MelinoeField_4397", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I suppose you're right. You really told her off! I still can scarcely believe it. Including that she spared you after all." },

				{ Cue = "/VO/Arachne_0391",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 0.25 },

					Text = "Well, you know. I always had a touch of temper on me. Feels good to let it all out once in a while, come what may! And I've been weaving like there's no tomorrow since." },

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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "F_Boss01", "F_Boss02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0055",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Saw you get into a scuffle with the great big witch. Why are you fighting? I thought you were on the same side! {#Emph}Oh{#Prev}, I can hardly keep up with everything lately." },
				{ Cue = "/VO/Melinoe_1813", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress and I aren't really fighting. Well... no, I suppose we are, except it isn't born of anger, or misunderstanding. It's just her way of making certain I'm prepared." },
				{ Cue = "/VO/Arachne_0056",
					Text = "{#Emph}Huh. {#Prev}Well look, you show her for me the next chance you get, won't you, my friend? And no pressure! But I might be watching just in case. I won't get underfoot, I promise." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ArachneAboutGods05" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArachneWithHecateInHub02" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Hecate_01" }
					},
					NamedRequirementsFalse = { "HecateMissing" },
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
						-- SumPrevRuns = 1 is the same as CurrentRun, SumPrevRuns = 2 is checking PrevRun, etc.
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
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
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "I know which one you mean, my friend, and I know she's been nosing about. As a rule, I stay away from goddesses like {#Emph}that. {#Prev}Even if they are your kin." },

				{ Cue = "/VO/MelinoeField_1491", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Goddesses like what? You make it sound as though you fear Olympus more than you fear Chronos himself." },

				{ Cue = "/VO/Arachne_0062",
					Portrait = "Portrait_Arachne_Brooding_01",
					PostLineThreadedFunctionName = "MuteSpeaker",

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
					Portrait = "Portrait_Arachne_Brooding_01",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Ah! {#Prev}No, wha-what is that? An amphibian?! Do get it out of here, my friend! {#Emph}Please {#Prev}help me get it out!" },
				{ Cue = "/VO/MelinoeField_1804", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Steady yourself, Arachne. This is Frinos! Frinos is a friend; a Familiar friend of mine, in fact. He means you no harm at all. Your stash of flies, however... that we may need to safeguard." },
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

			HecateWithArachne01_FollowUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneWithHecateInHub02" }
					},
					NamedRequirementsFalse =
					{
						"ArachneBrooding",
						-- @ ending
						"HecateMissing",
					},
				},

				{ Cue = "/VO/Arachne_0103",
					Emote = "PortraitEmoteSurprise",
					Text = "Another customer already! You just missed the great big witch. Not often that I'm honored with her presence. Next you see her out there, give her a good one for me, would you? {#Emph}Hm ha ha ha..." },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneGrantsReward01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutCurseQuest01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0120",
					Emote = "PortraitEmoteCheerful",
					Text = "All right, my friend, the time has come to unveil my latest designs; woven with care, especially for you! {#Emph}Behold! {#Prev}And more importantly, enjoy!" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutQuiet01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift04" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0366",
					Text = "It gets so quiet in these woods. The sound of my weaving, why, it's practically silent... might as well just be the rush of the leaves. So I sing a little to myself." },
				{ Cue = "/VO/MelinoeField_4389", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The woods may be quiet but they're filled with restless spirits. You're like a ray of moonlight in the middle of it all." },
				{ Cue = "/VO/Arachne_0367",
					Text = "Well that is kind of you to say. Though moonlight doesn't come in quite so many different colors as my silk, does it?" },
				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutUltimateProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZagreusPastMeeting03", "ZeusPalaceFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0432",
					Text = "Have you been getting anywhere, my friend? I know that, whatever you do, you do {#Emph}not {#Prev}give up. But I don't rightly know how close you are to what you mean to achieve." },

				{ Cue = "/VO/MelinoeField_4414", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm closer than before, but how much further I have left is difficult to say. Your silk has been of so much help!" },

				{ Cue = "/VO/Arachne_0433",
					Text = "I'm glad it has and figured that it would. Only the {#Emph}very {#Prev}best for {#Emph}you{#Prev}. And one of these nights, you'll make it {#Emph}all {#Prev}the way. And maybe with my silk, {#Emph}ha ha ha ha ha..." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachnePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0434",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "We've had some goings-on here in these woods, a lot more goings-on than usual! Lost Souls all acting strange. Did something happen I should know about?" },

				{ Cue = "/VO/MelinoeField_4415", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Arachne, it's just that my task is finally complete! Well, for the most part. King Hades and Queen Persephone are back, and they'll soon give all the Lost Souls here a place to go." },

				{ Cue = "/VO/Arachne_0435",
					Emote = "PortraitEmoteCheerful",
					Text = "My, but that {#Emph}is {#Prev}exciting! You {#Emph}did {#Prev}it, my friend! But then, it looks to me as though your fighting isn't over with..." },

				{ Cue = "/VO/MelinoeField_4416", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not yet, and possibly not for a while. So if it's all the same to you, I may keep passing by every so often. And not just for the beautiful silk dresses, but to say hello." },

				{ Cue = "/VO/Arachne_0436",
					Text = "Why, then, hello right back! And you are truly welcome here whenever you desire. I'm so happy for you!" },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachnePostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0437",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Say, if the King and Queen are back just like you said, doesn't that mean... why, doesn't it mean you should be back in their palace, too?" },

				{ Cue = "/VO/MelinoeField_4417", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I grew up near to these woods and I mean to remain here for the foreseeable future. Too much I'm not ready to give up." },

				{ Cue = "/VO/Arachne_0438",
					Text = "{#Emph}Oh{#Prev}, you big silly. You could have had it {#Emph}good. {#Prev}They would have given you the most {#Emph}beautiful {#Prev}dresses, I'm sure. Though maybe not more beautiful than these..." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachnePostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/MelinoeField_4418", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",

					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 0.5, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "You might not believe this, Arachne, but recently I met the Fates themselves! All three of them!" },

				{ Cue = "/VO/Arachne_0439",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "{#Emph}Oh {#Prev}you did, did you? And, did you happen to see what they were working on? I like to keep up with the latest happenings in the weaving world." },

				{ Cue = "/VO/MelinoeField_4419", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well if anything I got the sense that they were in between projects, and might be weaving {#Emph}less {#Prev}from here on out..." },

				{ Cue = "/VO/Arachne_0440",
					Text = "Sounds like they {#Emph}just {#Prev}couldn't keep up. But that's all right. The old always have to make way for the young and the new! And before you get too worried that I'm speaking out of turn, I don't think they'll notice little old me, {#Emph}ha ha ha ha ha." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},
			ArachnePostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachnePostEpilogue01" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0441",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "I've been wondering what else the Fates had to say to you. To think that all those different strands they weave affect our lives..." },

				{ Cue = "/VO/MelinoeField_4420", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My impression was they're going into a sort of retirement. Leaving us to make our own decisions. I don't know if it'll feel any different than before, though." },

				{ Cue = "/VO/Arachne_0442",
					Text = "I highly doubt it will. The kinds of choices that I've made... I don't know that anybody could have made them for me. Not even those three, {#Emph}ha ha ha ha ha." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			ArachneAboutSayingLittle01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift09" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneMuttering,

				{ Cue = "/VO/Arachne_0445",
					Text = "It's been so nice seeing you here. I have been weaving up a storm, so please stop by as often as you like, all right?" },

				{ Cue = "/VO/MelinoeField_4424", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't miss it. My nights aren't always pleasant, but you and your silken dresses are!" },

				{ Cue = "/VO/Arachne_0446",
					Text = "Well thank you for that, truly. Now go on, I don't want to keep you. Well I do but, you know what I mean, {#Emph}ha ha ha ha ha." },

				PrePortraitExitFunctionName = "ArachneCostumeChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.ArachneCostumeChoices,
			},

			-- Repeatable
			ArachneChat01 =
			{
				UseableOffSource = true,
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
				UnfilledIcon = "EmptyHeartWithProphecyIcon",
				FilledIcon = "FilledHeartWithProphecyIcon",
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
					Portrait = "Portrait_Mel_Proud_01",
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
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Too good for flies, perhaps. But it's especially for {#Emph}you. {#Prev}A gift of friendship, whose savor only grows the deeper the friendship is. May it warm you on a cold night such as this." },
			},
			ArachneGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_ArachneGiftHint01",
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
					Portrait = "Portrait_Mel_Empathetic_01",
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
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift04" },
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
					Portrait = "Portrait_Arachne_Brooding_01",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift04", "ArachneGift05" }
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
					Portrait = "Portrait_Arachne_Brooding_01",
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

			ArachneGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_ArachneUnlockHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift06", "ArachneAboutCurseQuest01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4400", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wanted you to have this: The Ambrosia of the gods. You have our talent, and you even have our pride. I figure, what's one more of our greatest gifts?" },

				{ Cue = "/VO/Arachne_0396",
					Emote = "PortraitEmoteSurprise",
					Text = "Ambrosia... you'll soon spoil me like this, you big silly! What am I going to do with so much? I'll be sipping away forever!" },

				{ Cue = "/VO/MelinoeField_4401", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Forever's a long time. And, ideally this is for sharing anyhow. Perhaps for the eventual grand opening of your shoppe!" },

				{ Cue = "/VO/Arachne_0397",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "Now {#Emph}there's {#Prev}an idea. Well then, I ought to store this safe and sound, and know {#Emph}just {#Prev}the way... wrapped in the finest silk." },
			},
			ArachneGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift07" },
					},
				},

				{ Cue = "/VO/MelinoeField_4402", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Here's to the success of Arachne's Garments, Dyes, and Fabrics, whenever the time comes. I find it helps always having something to look forward to, even if it's a way off." },

				{ Cue = "/VO/Arachne_0398",
					Text = "Why this is very gracious of you, my friend, and I'd embrace you if I could only reach, and you were so willing, but... I'd best appreciate you from afar." },

				{ Cue = "/VO/MelinoeField_4403", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But I'm not far; I'm here. And I want you to know, I'm glad you haven't changed. If you did... I might have lost you." },

				{ Cue = "/VO/Arachne_0399",
					Text = "You'd sooner lose me now since I {#Emph}am {#Prev}rather small! But thank you, truly. I used to think you were just saying things to pity me but now I know you're not." },
			},
			-- bond forged
			ArachneGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedArachne",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift07" },
					},
				},

				{ Cue = "/VO/Arachne_0400",
					Text = "No more Ambrosia, {#Emph}please{#Prev}, my friend. I'm running out of room! And you have given little old me more than enough." },

				{ Cue = "/VO/MelinoeField_4404", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Of course, but... perhaps the two of us could share some at some point. Even now...? Since you {#Emph}are {#Prev}running out of room. " },

				{ Cue = "/VO/Arachne_0401",
					Emote = "PortraitEmoteSurprise",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Arachne_Default_01_Exit",
					Text = "{#Emph}Oh! {#Prev}Well if you're not too busy, I would truly welcome that. Care to pop the bottle? The cap's a little tight for me..." },

				{ Cue = "/VO/Arachne_0402",
					PreLineFunctionName = "AltTavernaStartPresentation",
					Text = "...You've been so gracious with your time and with your love. Most mortals hate spiders... can't imagine most of you goddesses or gods feel any different." },

				{ Cue = "/VO/MelinoeField_4405", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's commonplace to fear what we don't understand. I'm a witch; we get that a lot. Perhaps that's why I felt connected to you from the start." },

				{ Cue = "/VO/Arachne_0403",
					Portrait = "Portrait_Arachne_Brooding_01",
					Text = "You felt connected to me because you {#Emph}stepped {#Prev}on me, my friend! Good thing you heard me screaming my head off. That was not the greatest way to meet..." },

				{ Cue = "/VO/MelinoeField_4406", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps not, but I'd say it worked out. And I've not stepped on you ever again, have I?" },

				{ Cue = "/VO/Arachne_0404",
					Text = "Well, no, you haven't, I suppose. Say, this Ambrosia, it is {#Emph}really {#Prev}something else! And a little goes a long way!" },

				{ Cue = "/VO/MelinoeField_4407", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Right? I'm glad you're enjoying it. It's always best with those you care about, and this is clearly a good batch." },

				{ Cue = "/VO/Arachne_0405",
					Text = "You really do care about me, {#Emph}huh. {#Prev}For the longest time I just wouldn't let myself believe it. But now you {#Emph}know {#Prev}I'm never turning back, and you're still you." },

				{ Cue = "/VO/MelinoeField_4408", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't know who else to be. What about you? If you could be anything or anybody else, what would you choose?" },

				{ Cue = "/VO/Arachne_0406",

					PortraitExitAnimation = "Portrait_Arachne_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20, IsArtemisField = true },

					Text = "Why, I... well I'd choose to be the greatest weaver that the world has ever known, is what. I'm choosing that right now." },

				{ Cue = "/VO/Arachne_0407",

					PreLineWait = 0.35,

					PreLineFunctionName = "TavernaEndPresentation",
					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Arachne_01", Icon = "Keepsake_Arachne", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostTavernaArgs },

					Emote = "PortraitEmoteCheerful",
					Text = "That was truly wonderful, my friend. Thank you so much, for being here with me. For everything." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4410", Text = "Of course. You're my friend, too." },
					},
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
				NamedRequirementsFalse = { "ArachneBrooding" },
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

	NPC_Arachne_Home_01 =
	{
		InheritFrom = { "NPC_Arachne_01" },
		GenusName = "NPC_Arachne_01",

		ActivateRequirements =
		{
			--
		},

		InteractTextLineSets =
		{
			ArachneHubFirstMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "F_Story01" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CharonPoints" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirementsFalse = { "ArachneBrooding" },
					--[[ didn't work...
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { "NPC_Charon_01", }, Alive = true },
					},
					]]--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ArachneHubGreeting,

				{ Cue = "/VO/Arachne_0065",
					Portrait = "Portrait_Arachne_Default_02",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh, hello there, my friend! I happened to see the Boatman sculling down the Cocytus, presumably to {#Emph}you{#Prev}, for he had all {#Emph}sorts {#Prev}of supplies. He was generous enough to offer me passage. Whether he knew it or not, {#Emph}ha ha ha ha..." },

				{ Cue = "/VO/Melinoe_3141", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Great to see you here and welcome, Arachne! I'm certain Charon doesn't mind such a courteous stowaway. Is there anything we can do to make your stay with us more comfortable?" },

				{ Cue = "/VO/Arachne_0066",
					Portrait = "Portrait_Arachne_Default_02",
					Text = "No, thank you. I don't intend to be here very long. Especially since the Boatman is my ticket home. I'll just make certain all my silk here is patched up, and then be on my way. Be well, won't you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3142", Text = "You, too..." },
					},
				},
			},

			-- partner conversations
			ArachneWithHecateInHub01 =
			{
				Partner = "NPC_Hecate_01",

				-- GameStateRequirements
				PlayOnce = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "F_Story01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneHubFirstMeeting01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArachneWithHecateInHub02" }
					},
					NamedRequirementsFalse = { "ArachneBrooding", "ClearBeforeTrueEnding", "HecateMissing" },
				},

				OnQueuedFunctionName = "SetupArachneDangling",
				OnQueuedFunctionArgs = { WebObstacle = 800720, },
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				TeleportToId = 800721,
				-- TeleportOffsetX = -100,
				-- TeleportOffsetY = 100,
				InteractDistance = 400,
				{ Cue = "/VO/Arachne_0098",
					Portrait = "Portrait_Arachne_Default_02",
					PreLineWait = 0.35,
					Text = "...{#Emph}Oh{#Prev}, don't worry. I'll be fine! I know those woods out there like the back of my, {#Emph}um... leg{#Prev}, I do suppose! I'm always grateful for your hospitality, great Titaness." },

				{ Cue = "/VO/Hecate_0545", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					PreLineAnim = "HecateHubGreet",
					PreLineAnimTarget = 556921,
					Text = "And you are welcome here and safe, Arachne. Now I must beg your pardon. The matters that unfold of late require more of my attention than I'd like..." },

				{ Cue = "/VO/Arachne_0099",
					Portrait = "Portrait_Arachne_Default_02",
					PostLineThreadedFunctionName = "ArachneExit",
					PostLineThreadedFunctionArgs = { WebObstacle = 800720, },
					Text = "I truly understand. Then I'll get out of your hair. Farewell for now!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Hecate_01",
					{ Cue = "/VO/Hecate_0546", Text = "Farewell in turn.", PreLineAnim = "HecateHubGreet" },
				},
			},

			ArachneWithHecateInHub02 =
			{
				Partner = "NPC_Hecate_01",

				-- GameStateRequirements
				PlayOnce = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneAboutCurse03" }
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneAboutCurse03" },
					},
					NamedRequirementsFalse = { "ArachneBrooding", "ClearBeforeTrueEnding", "HecateMissing" },
				},

				OnQueuedFunctionName = "SetupArachneDangling",
				OnQueuedFunctionArgs = { WebObstacle = 800720, },
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				TeleportToId = 800721,
				-- TeleportOffsetX = -100,
				-- TeleportOffsetY = 100,
				InteractDistance = 400,
				{ Cue = "/VO/Arachne_0100",
					PreLineWait = 0.35,
					Portrait = "Portrait_Arachne_Brooding_02",
					Emote = "PortraitEmoteSurprise",
					Text = "...But, this {#Emph}can't {#Prev}be.... Titaness, whatever do you mean? Because if you meant what you said, why... all those times you told me that I'm welcome here and safe... all lies, then. Is that it?" },
				{ Cue = "/VO/Hecate_0547", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PreLineAnimTarget = 556921,
					PostLineAnim = "Hecate_Hub_Explaining_End",
					PostLineAnimTarget = 556921,
					Text = "Your anger's justified. 'Twas my poison that Athena used whilst cursing you. But the curse is hers, not mine. I'd no desire that you knew {#Emph}any {#Prev}of this. Melinoë, however, swayed me against my instincts." },
				{ Cue = "/VO/Arachne_0101",
					Portrait = "Portrait_Arachne_Brooding_02",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "ArachneExit",
					PostLineThreadedFunctionArgs = { WebObstacle = 800720, },
					Text = "...I don't know what to say. So this is {#Emph}your {#Prev}fault. Athena never could have done this to me without your {#Emph}help. {#Prev}You Titans and the gods... you're all alike. Good evening!" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Hecate_01",
					{ Cue = "/VO/Hecate_0548", Text = "Arachne, be reasonable... {#Emph}ungh...", PreLineAnim = "Hecate_Hub_Scoff" },
				},
			},

			-- end of events

		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Arachne )

GlobalVoiceLines.CostumeChangedVoiceLines =
{
	PreLineFunctionName = "GenericPresentation",
	PreLineFunctionArgs = { PreWait = 0.35 },
	{
		RandomRemaining = true,
		ObjectType = "NPC_Arachne_01",
		AllowTalkOverTextLines = true,
		-- SuccessiveChanceToPlayAll = 0.75,
		-- also see additional Arachne lines below
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = GameData.ArachneUpsetEvents,
			},
		},

		{ Cue = "/VO/Arachne_0171", Text = "Certainly!" },
		{ Cue = "/VO/Arachne_0172", Text = "Of course!" },
		{ Cue = "/VO/Arachne_0173", Text = "Of course." },
		{ Cue = "/VO/Arachne_0174", Text = "Right away." },
		{ Cue = "/VO/Arachne_0175", Text = "Coming right up!" },
		{ Cue = "/VO/Arachne_0176", Text = "Oh, yes." },
		{ Cue = "/VO/Arachne_0177", Text = "I hear that!" },
		{ Cue = "/VO/Arachne_0178", Text = "Wonderful." },
		{ Cue = "/VO/Arachne_0179", Text = "You bet." },
		{ Cue = "/VO/Arachne_0180", Text = "Why, sure!" },
		{ Cue = "/VO/Arachne_0183", Text = "Oh, you look {#Emph}wonderful!" },
		{ Cue = "/VO/Arachne_0189", Text = "You truly look lovely." },
		{ Cue = "/VO/Arachne_0196", Text = "Like a warm embrace..." },
		{ Cue = "/VO/Arachne_0198", Text = "Absolutely stunning...!" },
		{ Cue = "/VO/Arachne_0181", Text = "A {#Emph}perfect {#Prev}fit!" },
		{ Cue = "/VO/Arachne_0187", Text = "Made this one just for you." },
		{ Cue = "/VO/Arachne_0188", Text = "I knew you'd pick this one!" },
		{ Cue = "/VO/Arachne_0191", Text = "Now you enjoy, all right?" },
		{ Cue = "/VO/Arachne_0192", Text = "{#Emph}Whew! {#Prev}Enjoy it while it lasts..." },
		{ Cue = "/VO/Arachne_0193", Text = "All in an evening's work!" },
		{ Cue = "/VO/Arachne_0194", Text = "Woven with care." },
		{ Cue = "/VO/Arachne_0195", Text = "It's all yours." },
		{ Cue = "/VO/Arachne_0197", Text = "May it keep you safe." },
		{ Cue = "/VO/Arachne_0200", Text = "What a sight you are." },
		{ Cue = "/VO/Arachne_0190", Text = "I hope you like it." },
		{ Cue = "/VO/Arachne_0182", Text = "There!" },
		{ Cue = "/VO/Arachne_0184", Text = "Do you like it?", PlayFirst = true },
		{ Cue = "/VO/Arachne_0185", Text = "Well, what do you think?" },
		{ Cue = "/VO/Arachne_0186", Text = "How does that feel?" },
		{ Cue = "/VO/Arachne_0199", Text = "It matches your eye.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "VitalityCostume", "EscalatingCostume" },
				},
			},
		},
	},
	{
		PreLineWait = 0.1,
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			-- do you like it?
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Arachne_0184", "/VO/Arachne_0185", "/VO/Arachne_0186" },
			},
		},

		{ Cue = "/VO/Melinoe_1731", Text = "Why this is beautiful, thank you...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1412", Text = "I think I like it...",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsNone = { "/VO/Arachne_0184", "/VO/Arachne_0185", "/VO/Arachne_0186" },
				},
			},
		},
	},
	{
		PreLineWait = 0.2,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.66,
		UsePlayerSource = true,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = GameData.ArachneUpsetEvents,
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneCurseQuestComplete01" },
			},
		},

		{ Cue = "/VO/MelinoeField_4771", Text = "It's beautiful." },
		{ Cue = "/VO/MelinoeField_4772", Text = "It's perfect." },
		{ Cue = "/VO/MelinoeField_4773", Text = "I love it." },
		{ Cue = "/VO/MelinoeField_4774", Text = "So soft..." },
		{ Cue = "/VO/MelinoeField_4775", Text = "Immaculate." },
		{ Cue = "/VO/MelinoeField_4776", Text = "Fits perfectly." },
		{ Cue = "/VO/MelinoeField_4777", Text = "It's lovely!" },
		{ Cue = "/VO/MelinoeField_4778", Text = "Thank you, Arachne.", PlayFirst = true, },
		{ Cue = "/VO/MelinoeField_4779", Text = "Thanks, Arachne." },
		{ Cue = "/VO/MelinoeField_4780", Text = "It's just right." },
		{ Cue = "/VO/MelinoeField_2378", Text = "Thanks, Arachne." },
		{ Cue = "/VO/Melinoe_0350", Text = "{#Emph}<Laugh>" },
		{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
	},
}

GlobalVoiceLines.CostumeDestroyedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "LastBrokenArmorTraitName" },
				IsAny = { "AgilityCostume", "ManaCostume", "VitalityCostume", "CastDamageCostume", "IncomeCostume", "HighArmorCostume", "SpellCostume", "EscalatingCostume",},
			},
		},
		{ Cue = "/VO/Melinoe_1916", Text = "My outfit!" },
		{ Cue = "/VO/Melinoe_1917", Text = "So much for silken armor..." },
		{ Cue = "/VO/Melinoe_1918", Text = "There goes Arachne's suit..." },
		{ Cue = "/VO/Melinoe_1919", Text = "They broke my suit...",
			PlayOnce = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
		{ Cue = "/VO/Melinoe_0579", Text = "{#Emph}Hm!" },
		{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
		{ Cue = "/VO/MelinoeField_2374", Text = "Blast..." },
		{ Cue = "/VO/MelinoeField_2375", Text = "{#Emph}Augh..." },
		{ Cue = "/VO/MelinoeField_2376", Text = "My silk...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2377", Text = "My dress..." },
		{ Cue = "/VO/MelinoeField_2379", Text = "{#Emph}Tsk..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		ObjectType = "Hecate",
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.25,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">=",
				Value = 0.35,
			},
			{
				Path = { "CurrentRun", "Hero", "LastBrokenArmorTraitName" },
				IsAny = { "AgilityCostume", "ManaCostume", "VitalityCostume", "CastDamageCostume", "IncomeCostume", "HighArmorCostume", "SpellCostume", "EscalatingCostume",},
			},
		},
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "HecateSpokeRecently", Time = 12 },
		},

		{ Cue = "/VO/HecateField_0378", Text = "Silk cannot protect you!" },
		{ Cue = "/VO/HecateField_0379", Text = "Mere silk!", Play = true, },
		{ Cue = "/VO/HecateField_0380", Text = "Arachne can blame me!" },
		{ Cue = "/VO/HecateField_0381", Text = "You didn't need that dress!" },
		{ Cue = "/VO/HecateField_0382", Text = "The spider can weave more!" },
		{ Cue = "/VO/HecateField_0383", Text = "Denied your silken dress!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpeechRecord" },
					HasAll = { "/VO/HecateField_0378", "/VO/HecateField_0379", "/VO/HecateField_0380", "/VO/HecateField_0381", "/VO/HecateField_0382", }
				},
			},
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Arachne_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "LastBrokenArmorTraitName" },
				IsAny = { "AgilityCostume", "ManaCostume", "VitalityCostume", "CastDamageCostume", "IncomeCostume", "HighArmorCostume", "SpellCostume", "EscalatingCostume",},
			},
		},
		{ Cue = "/VO/Arachne_0268", Text = "Limit one per evening, I'm afraid...", PlayFirst = true },
		{ Cue = "/VO/Arachne_0269", Text = "Hey, I'm not made of those you know!" },
		{ Cue = "/VO/Arachne_0270", Text = "Oh, now that's a shame..." },
		{ Cue = "/VO/Arachne_0271", Text = "Oh, dear..." },
		{ Cue = "/VO/Arachne_0272", Text = "Aw..." },
		{ Cue = "/VO/Arachne_0273", Text = "{#Emph}<Gasp>" },
		{ Cue = "/VO/Arachne_0274", Text = "Ooh!" },
	}
}

-- Global Arachne Lines -- Arachne
GlobalVoiceLines.ArachneGreetingLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Arachne_01",
		PreLineAnim = "Arachne_Greet",

		{ Cue = "/VO/Arachne_0133", Text = "Oh!" },
		{ Cue = "/VO/Arachne_0134", Text = "Ah, it's you!" },
		{ Cue = "/VO/Arachne_0135", Text = "Oh, welcome!" },
		{ Cue = "/VO/Arachne_0136", Text = "You've come back!" },
		{ Cue = "/VO/Arachne_0137", Text = "Do my eyes deceive?" },
		{ Cue = "/VO/Arachne_0138", Text = "My friend!" },
		{ Cue = "/VO/Arachne_0139", Text = "Is it truly you?" },
		{ Cue = "/VO/Arachne_0140", Text = "{#Emph}<Gasp>" },
		{ Cue = "/VO/Arachne_0141", Text = "A customer!" },
		{ Cue = "/VO/Arachne_0142", Text = "My finest customer!" },
		{ Cue = "/VO/Arachne_0143", Text = "Why hello there!" },
		{ Cue = "/VO/Arachne_0144", Text = "Good evening!" },
		{ Cue = "/VO/Arachne_0145", Text = "Welcome back!" },
		{ Cue = "/VO/Arachne_0146", Text = "Ah, {#Emph}haha!" },
		{ Cue = "/VO/Arachne_0147", Text = "Hello again!" },
		{ Cue = "/VO/Arachne_0148", Text = "Oh, it's been too long!" },
		{ Cue = "/VO/Arachne_0149", Text = "Got some cocoons for you!" },
		{ Cue = "/VO/Arachne_0150", Text = "Some new cocoons there!" },
		{ Cue = "/VO/Arachne_0356", Text = "Oh...!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0357", Text = "{#Emph}Huh...!" },
	},
}

GlobalVoiceLines.ArachneMutteringLines =
{
	RandomRemaining = true,
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0201", Text = "{#Emph}Dye the silk and loooad it," },
		{ Cue = "/VO/Arachne_0202", Text = "{#Emph}Spinning, spinning goes the thread," },
		{ Cue = "/VO/Arachne_0203", Text = "{#Emph}Warp and weft, warp and weft," },
		{ Cue = "/VO/Arachne_0204", Text = "{#Emph}Cut it up and fooold it." },
		{ Cue = "/VO/Arachne_0205", Text = "And again...!" },
		{ Cue = "/VO/Arachne_0201", Text = "{#Emph}Dye the silk and loooad it,", PreLineWait = 1.2 },
		{ Cue = "/VO/Arachne_0202", Text = "{#Emph}Spinning, spinning goes the thread," },
		{ Cue = "/VO/Arachne_0203", Text = "{#Emph}Warp and weft, warp and weft," },
		{ Cue = "/VO/Arachne_0204", Text = "{#Emph}Cut it up and fooold it.", BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0206", Text = "{#Emph}Silken finery, so soft, divine..." },
		{ Cue = "/VO/Arachne_0207", Text = "{#Emph}I spin my threads and catch whatever comes my way..." },
		{ Cue = "/VO/Arachne_0208", Text = "{#Emph}A pleasant memory that lingers on my mind..." },
		{ Cue = "/VO/Arachne_0209", Text = "{#Emph}From lonely dark of night until the break of day..." },
		{ Cue = "/VO/Arachne_0210", Text = "One more time..." },
		{ Cue = "/VO/Arachne_0206", Text = "{#Emph}Silken finery, so soft, divine...", PreLineWait = 1.2 },
		{ Cue = "/VO/Arachne_0207", Text = "{#Emph}I spin my threads and catch whatever comes my way..." },
		{ Cue = "/VO/Arachne_0208", Text = "{#Emph}A pleasant memory that lingers on my mind..." },
		{ Cue = "/VO/Arachne_0209", Text = "{#Emph}From lonely dark of night until the break of day...", BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0211", Text = "{#Emph}Oh, little fly, come sit and rest your wings..." },
		{ Cue = "/VO/Arachne_0212", Text = "{#Emph}You've grown so tired flying to and fro..." },
		{ Cue = "/VO/Arachne_0213", Text = "{#Emph}I'll wrap you up and sing you soon to sleep..." },
		{ Cue = "/VO/Arachne_0214", Text = "{#Emph}I'll drink of you and leave a little heap..." },
		{ Cue = "/VO/Arachne_0215", Text = "{#Emph}Ha ha ha... {#Prev}again...", PreLineWait = 1.2 },

		{ Cue = "/VO/Arachne_0211", Text = "{#Emph}Oh, little fly, come sit and rest your wings..." },
		{ Cue = "/VO/Arachne_0212", Text = "{#Emph}You've grown so tired flying to and fro..." },
		{ Cue = "/VO/Arachne_0213", Text = "{#Emph}I'll wrap you up and sing you soon to sleep..." },
		{ Cue = "/VO/Arachne_0214", Text = "{#Emph}I'll drink of you and leave a little heap...", BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},

		{ Cue = "/VO/Arachne_0447", Text = "{#Emph}Blue, and black, and burgundy," },
		{ Cue = "/VO/Arachne_0448", Text = "{#Emph}Silk of every color, see?" },
		{ Cue = "/VO/Arachne_0449", Text = "{#Emph}Delicate and spun with care," },
		{ Cue = "/VO/Arachne_0450", Text = "{#Emph}Strong as silver, thin as hair..." },
		{ Cue = "/VO/Arachne_0451", Text = "{#Emph}And, back again...!", PreLineWait = 1.5 },

		{ Cue = "/VO/Arachne_0447", Text = "{#Emph}Blue, and black, and burgundy," },
		{ Cue = "/VO/Arachne_0448", Text = "{#Emph}Silk of every color, see?" },
		{ Cue = "/VO/Arachne_0449", Text = "{#Emph}Delicate and spun with care," },
		{ Cue = "/VO/Arachne_0450", Text = "{#Emph}Strong as silver, thin as hair...", BreakIfPlayed = true  },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		{ Cue = "/VO/Arachne_0452", Text = "{#Emph}Just a spider, small and black," },
		{ Cue = "/VO/Arachne_0453", Text = "{#Emph}Eight long legs and fuzzy back," },
		{ Cue = "/VO/Arachne_0454", Text = "{#Emph}Eyes like gems and web so fine," },
		{ Cue = "/VO/Arachne_0455", Text = "{#Emph}Godlike skill but not divine..." },
		{ Cue = "/VO/Arachne_0456", Text = "{#Emph}Once more...", PreLineWait = 1.5 },

		{ Cue = "/VO/Arachne_0452", Text = "{#Emph}Just a spider, small and black," },
		{ Cue = "/VO/Arachne_0453", Text = "{#Emph}Eight long legs and fuzzy back," },
		{ Cue = "/VO/Arachne_0454", Text = "{#Emph}Eyes like gems and web so fine," },
		{ Cue = "/VO/Arachne_0455", Text = "{#Emph}Godlike skill but not divine...", BreakIfPlayed = true  },
	},
	{
		PreLineWait = 0.75,
		--Actor = "StrangerOcclusionP",
		ObjectType = "NPC_Arachne_01",
		RecheckRequirementsForSubLines = true,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "ArachneInterrupt" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		{ Cue = "/VO/Arachne_0457", Text = "{#Emph}My fangs aren't venomous, I swear." },
		{ Cue = "/VO/Arachne_0458", Text = "{#Emph}Come closer, and I'll prove it true!" },
		{ Cue = "/VO/Arachne_0459", Text = "{#Emph}I know that many wouldn't dare," },
		{ Cue = "/VO/Arachne_0460", Text = "{#Emph}But they are nothing, and you're you..." },
		{ Cue = "/VO/Arachne_0461", Text = "{#Emph}And one more...!", PreLineWait = 1.5 },

		{ Cue = "/VO/Arachne_0457", Text = "{#Emph}My fangs aren't venomous, I swear." },
		{ Cue = "/VO/Arachne_0458", Text = "{#Emph}Come closer, and I'll prove it true!" },
		{ Cue = "/VO/Arachne_0459", Text = "{#Emph}I know that many wouldn't dare," },
		{ Cue = "/VO/Arachne_0460", Text = "{#Emph}but they are nothing and you're you...", BreakIfPlayed = true  },
	},
}
GlobalVoiceLines.ArachneGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		NamedRequirementsFalse = { "ArachneBrooding" },
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0326", Text = "Good eye!" },
	{ Cue = "/VO/Arachne_0327", Text = "Finders keepers." },
	{ Cue = "/VO/Arachne_0328", Text = "{#Emph}Ooh {#Prev}what's that?", PlayFirst = true },
	{ Cue = "/VO/Arachne_0329", Text = "Found it!" },
	{ Cue = "/VO/Arachne_0357", Text = "{#Emph}Huh..." },
	{ Cue = "/VO/Arachne_0360", Text = "{#Emph}Hm..." },
}
GlobalVoiceLines.ArachnePickaxeReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		NamedRequirementsFalse = { "ArachneBrooding" },
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/Arachne_0317", Text = "Oh you got something!" },
	{ Cue = "/VO/Arachne_0318", Text = "Nice find." },
	{ Cue = "/VO/Arachne_0319", Text = "Fine work there!" },
	{ Cue = "/VO/Arachne_0320", Text = "Help yourself!" },
	{ Cue = "/VO/Arachne_0321", Text = "Help yourself." },
}
GlobalVoiceLines.ArachneExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		--[[ replaced with the requirements below
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = GameData.ArachneUpsetEvents,
		},
		]]--
		NamedRequirementsFalse = { "ArachneBrooding" },
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0322", Text = "You got one!" },
	{ Cue = "/VO/Arachne_0323", Text = "Nicely done." },
	{ Cue = "/VO/Arachne_0324", Text = "You saved them." },
	{ Cue = "/VO/Arachne_0325", Text = "You did it." },
}
GlobalVoiceLines.ArachneMineReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.25,
	SuccessiveChanceToPlayAll = 0.5,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		NamedRequirementsFalse = { "ArachneBrooding" },
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0232", Text = "Watch out!" },
	{ Cue = "/VO/Arachne_0233", Text = "Look out!" },
	{ Cue = "/VO/Arachne_0234", Text = "Careful!" },
	{ Cue = "/VO/Arachne_0235", Text = "Sorry!" },
	{ Cue = "/VO/Arachne_0236", Text = "Oops!" },
	{ Cue = "/VO/Arachne_0237", Text = "Yikes!" },
}
GlobalVoiceLines.ArachneCocoonPositiveReactionLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.66,
	ObjectType = "NPC_Arachne_01",
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsAny = { "F_Story01" },
		},
		NamedRequirementsFalse = { "ArachneBrooding" },
	},
	Cooldowns =
	{
		{ Name = "ArachneSpokeRecently", Time = 10 },
	},

	{ Cue = "/VO/Arachne_0279", Text = "That's on the house!" },
	{ Cue = "/VO/Arachne_0280", Text = "Enjoy!" },
	{ Cue = "/VO/Arachne_0281", Text = "For you!" },
	{ Cue = "/VO/Arachne_0282", Text = "Oh you found it!" },
	{ Cue = "/VO/Arachne_0283", Text = "Surprise!" },
	{ Cue = "/VO/Arachne_0284", Text = "Hope it helps!" },
	{ Cue = "/VO/Arachne_0285", Text = "All yours." },
	{ Cue = "/VO/Arachne_0286", Text = "Oh good!" },
	{ Cue = "/VO/Arachne_0287", Text = "Keep it!" },
	{ Cue = "/VO/Arachne_0288", Text = "Just for you!" },
}
GlobalVoiceLines.ArachneCocoonNegativeReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.2,
		PlayOnceFromTableThisRun = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
			{
				PathEmpty = { "MapState", "RoomRequiredObjects" },
			},
		},

		{ Cue = "/VO/Melinoe_1920", Text = "Got to make way for more." },
		{ Cue = "/VO/Melinoe_1921", Text = "She says this is OK..." },
		{ Cue = "/VO/Melinoe_1922", Text = "So many of these..." },
		{ Cue = "/VO/Melinoe_1923", Text = "No spiderlings in sight." },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "ExitHintVO",
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.2,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
			},
			{
				PathEmpty = { "MapState", "RoomRequiredObjects" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelinoeFleeCocoonSpeech", Time = 240 },
		},

		{ Cue = "/VO/Melinoe_1930", Text = "Could make a run for it...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1931", Text = "Don't have to stand and fight..." },
		{ Cue = "/VO/Melinoe_1932", Text = "The exits are right there..." },
		{ Cue = "/VO/Melinoe_1933", Text = "Perhaps I'd better go..." },
	},
	{
		ThreadName = "RoomThread",
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Arachne_01",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
			NamedRequirementsFalse = { "ArachneBrooding" },
		},
		Cooldowns =
		{
			{ Name = "ArachneSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Arachne_0216", Text = "Oh, sorry about that!" },
		{ Cue = "/VO/Arachne_0217", Text = "Oh, {#Emph}shoo! {#Prev}Get out of here!" },
		{ Cue = "/VO/Arachne_0218", Text = "Oh not another one of those." },
		{ Cue = "/VO/Arachne_0219", Text = "Oh do be careful!" },
		{ Cue = "/VO/Arachne_0220", Text = "Oh no!" },
		{ Cue = "/VO/Arachne_0221", Text = "How'd that one get in here?" },
		{ Cue = "/VO/Arachne_0222", Text = "Sorry for the mess!" },
		{ Cue = "/VO/Arachne_0223", Text = "One of those again." },
		{ Cue = "/VO/Arachne_0224", Text = "Forgot I snagged that one." },
		{ Cue = "/VO/Arachne_0225", Text = "Pop at your own risk..." },
	},
}