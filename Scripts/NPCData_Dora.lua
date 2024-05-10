UnitSetData.NPC_Dora =
{
	-- Dora, Id = 566832
	NPC_Dora_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Dora_Default_01",
		AnimOffsetZ = 30,
		Groups = { "NPCs" },
		SubtitleColor = Color.DoraVoice,
		SpeakerName = "Dora",

		ActiveModel = "Dora_Mesh",

		DefaultCategoryIndex = 1,

		OnPortraitSetFunctionName = "MatchModelToPortrait",
		OnPortraitSetFunctionArgs =
		{
			TransitionVfx = "EnemyDeathFx_Dora",
		},
		PortraitData =
		{
			Portrait_Dora_Default_01 =
			{
				Model = "Dora_Mesh",
				Animation = "Dora_Idle",
			},
			Portrait_Dora_Spooky_01	=
			{
				Model = "ScaryDora_Mesh",
				Animation = "DoraScary_Idle",
			},
		},

		SpawnEvents =
		{
			{
				Threaded = true,
				FunctionName = "CheckDistanceTriggerThread",
				Args =
				{
					WithinDistance = 70,
					ScaleY = 0.6,
					NotifyName = "DoraApproach",
					PostTriggerFunctionName = "GenericPresentation",
					PostTriggerFunctionArgs =
					{
						SetAlpha = 0.0,
						Duration = 0.3,
						CreateAnimation = "DoraDissipate",
						ThreadedVoiceLines =
						{
							-- { Cue = "/VO/Dora_0036", Text = "Oh. Sure..." },
						},
						ApplyEffectOnHero = "DoraSlow",
						ApplyEffectOnHeroProperties = EffectData.DoraSlow.EffectData,
						AddInteractBlock = "DoraDisappear",
					},
					Repeat = true,
					RepeatBufferDistance = 50,
					OnRepeatFunctionName = "GenericPresentation",
					OnRepeatFunctionArgs =
					{
						SetAlpha = 1.0,
						Duration = 0.5,
						RemoveInteractBlock = "DoraDisappear",
					},
				},
			},
		},

		AnimationsForModel =
		{
			Dora_Disappear =
			{
				Dora_Mesh = "Dora_Disappear",
				ScaryDora_Mesh = "DoraScary_Disappear",
			},			
		},

		EndTextLinesThreadedFunctionName = "DoraReturnToHaunting",
		EndTextLinesFunctionArgs =
		{
			HighChanceToPlay = 0.85,
			LowChanceToPlay = 0.3,
			RandomWaitMin = 1.0,
			RandomWaitMax = 3.5,
			OutsideDistance = 500,
			OutsideAnimationsForModel =
			{
				Dora_Mesh = "Dora_Disappear",
				ScaryDora_Mesh = "DoraScary_Disappear",
			},
			OutsideGlobalVoiceLines = "DoraHidingVoiceLines",
			InsideDistance = 320,
			InsideAnimationsForModel =
			{
				Dora_Mesh = "Dora_QuickAppear",
				ScaryDora_Mesh = "DoraScary_Appear",
			},
			InsideGlobalVoiceLines = "DoraSummonedVoiceLines",
		},

		ActivateRequirements =
		{
			-- None
		},

		CosmeticsTeleportRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
		},

		PreBathAnimationName = "Dora_Shrug",
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				PlayOnceThisRun = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1885", Text = "Hail, spirit!" },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0202", Text = "{#Emph}You invoke me?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Dora_0203", Text = "{#Emph}Who summons me?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Dora_0204", Text = "{#Emph}Kneel, witch!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_1885" },
						},
					},
				},
				{ Cue = "/VO/Dora_0205", Text = "{#Emph}Death to all!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Dora_0206", Text = "{#Emph}Suffer a thousand torments!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Dora_0207", Text = "{#Emph}And the sun bleach your bones!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Dora_0208", Text = "{#Emph}Terror engulf us!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Dora_0209", Text = "Whatever works.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Dora_0210", Text = "I'm staying right here.", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Dora_0211", Text = "Come on, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2", "/VO/Melinoe_2785", "/VO/Melinoe_2786", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Dora_0212", Text = "Oh, lighten up...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
			},
		},

		PostActivateEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					UseTextTalkGiftAndSpecial = "DoraUseTextTalkGiftAndSpecial",
					UseTextTalkAndSpecial = "DoraUseTextTalkAndSpecial",
					UseTextGiftAndSpecial = "DoraUseTextGiftAndSpecial",
					UseTextSpecial = "DoraUseTextSpecial",
					SpecialInteractFunctionName = "UseCosmeticsShop",
					SpecialInteractCooldown = 0.0,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
				},
			},
			{
				FunctionName = "CheckDistanceTriggerThread",
				Args =
				{
					PreEligibilityWait = 0.1,
					GameStateRequirements =
					{
						{
							PathFalse = { "ActiveEnemies", 566832, "InPartnerConversation", },
						}
					},
					PreTriggerFunctionName = "GenericPresentation",
					PreTriggerFunctionArgs =
					{
						PreWait = 0.1,
						StopStatusAnimation = true,
					},
					PreTriggerAnimation = "Dora_Invisible",
					PostTriggerFunctionName = "TrackPlayer",
					PostTriggerFunctionArgs = { Interval = 2.0, Duration = 1.0, EaseIn = 0.0, EaseOut = 1.0, },
					--StatusAnimation = "StatusIconWantsToTalk",
					CheckTextLinesStatusAnimation = true,
					ShakeSelf = true,
					WithinDistance = 420,
					ScaleY = 0.75,
					VoiceLines =
					{
						PlayedNothingFunctionName = "GenericPresentation",
						PlayedNothingFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
						[1] = GlobalVoiceLines.DoraSummonedVoiceLines,
					},
				},
				GameStateRequirements =
				{
					-- None
				},
			},
		},

		-- RepeatableTextLinesPlayChance = 0.5,

		InteractTextLineSets =
		{
			DoraFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					-- 1 = tent; 2 = Main; = 3 = PreRun
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0004_01",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					AutoAdvance = true,
					TextOffsetY = -22,
					VerticalJustification = "TOP",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Who dares disturb my eternal rest? You trifle with powers far beyond your comprehension, witch. Speak!" },
				{ Cue = "/VO/Dora_0004_02",
					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Dora_Default_01",
					Append = true,
					Text = " {#Prev}...That was pretty decent, right, Mel? Maybe pushing it. OK if I call you {#Emph}witch {#Prev}like that?" },
				{ Cue = "/VO/Melinoe_2949", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Witch {#Prev}worked for me in context, and a solid haunting all in all, Dora. But, I'd better run. Something I have to do." },
				EndVoiceLines =
				{
					{
						RequiredMinElapsedTime = 2,
						PreLineFunctionName = "GenericPresentation",
						PreLineFunctionArgs =
						{
							Wait = 0.35,
							SetModel = "ScaryDora_Mesh",
							SetAnimation = "DoraScary_Idle",
							CreateAnimation = "EnemyDeathFx_Dora",
						},
						{ Cue = "/VO/Dora_0005", Text = "{#Emph}Then begone!" },
					},
				},
			},

			-- @ currently disabled; Dora shall haunt you forever if you tamper with this
			--[[
			DoraGrantsCosmeticsShop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopAvailable" },
				},
				{ Cue = "/VO/Melinoe_1302", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Dora, I've a favor, if you're not too busy. My task means I no longer can oversee the renewal project around here. Would you attend to it?" },
				{ Cue = "/VO/Dora_0170",
					Emote = "PortraitEmoteSurprise",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Wait, you're asking {#Emph}me {#Prev}to watch over the total transformation of this entire encampment into some ultimate haven for Shades and outcasts?" },
				{ Cue = "/VO/Melinoe_1303", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					PostLineThreadedFunctionName = "UnlockCosmeticsShop",
					Text = "I {#Emph}know {#Prev}I can count on you. I'll provide the materials, you'll be the main point of contact." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.2,
						{ Cue = "/VO/Dora_0171", Text = "{#Emph}Mmmmmm {#Prev}OK fine." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1304", Text = "Great!" },
					},
				},

			},
			]]

			DoraAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 8,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Dora_0002",
					Text = "Mel! Thought I finally had the place to myself, then next I know, you're back. Damn near scared me to life. Rough night again?" },
				{ Cue = "/VO/Melinoe_0011", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Rough night, Dora. Fear not, you'll have the tent to yourself yet! See you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0003", Text = "Yeah, you too." },
					},
				},
			},
			DoraAboutReturning02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift01", "DoraRunProgress01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566842,

				{ Cue = "/VO/Dora_0189",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "You know, it's kind of spooky how you never come in through the front flap anymore. Ever think of taking up haunting, yourself?" },
				{ Cue = "/VO/Melinoe_1827", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Oh, yes! I figure if none of this works out, the lot of us can wander the earth, striking fear into the hearts of any mortals who dare look upon us." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0190", Text = "{#Emph}<Gasp> {#Prev}Now we're talking..." },
					},
				},
			},

			DoraAboutReturning03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraAboutReturning02", "DoraGift05" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				TeleportToId = 589429,

				{ Cue = "/VO/Dora_0191",
					Text = "{#Emph}Whew! {#Prev}Thought you'd never snap out of it. You OK?" },
				{ Cue = "/VO/Melinoe_2018", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Yes, thank you, Dora. I hope I didn't cause you any concern. Have you been by my side here all this time?" },
				{ Cue = "/VO/Dora_0192",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "What, me? No. Just out for a breather." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2819", Text = "But you don't even breathe..." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0152", Text = "Cut it out...!" },
					},
				},
			},


			DoraAboutTent01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "GhostAdmin" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Melinoe_3375", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, couldn't help but notice that my jar collection wasn't sorted properly. I would never store fungus with herbs. Are you trying to subtly drive me mad?" },
				{ Cue = "/VO/Dora_0158",
					Text = "No.... Although, now that you put it that way, maybe in the future, {#Emph}yes{#Prev}. I was working on minor possessions and your mushroom bottle kind of slipped. So I put it back!" },
				{ Cue = "/VO/Melinoe_0964", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You put it {#Emph}incorrectly {#Prev}back. I... {#Emph}augh{#Prev}. Just tell me of such things next time, would you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0159", Text = "Maybe I will, maybe I won't." },
					},
				},
			},
			DoraAboutTent02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutTent01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Dora_0160",
					Text = "You know, Mel, you can be a bit uptight sometimes. Where'd you even get that from? Even the head witch is more relaxed than you." },
				{ Cue = "/VO/Melinoe_1820", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Look I'm under a lot of pressure right now, all right? Everybody's counting on me to literally {#Emph}kill Time... {#Prev}so I would like this tent to be an orderly place! Seeing as I'm having to return so often..." },
				{ Cue = "/VO/Dora_0161",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Eh{#Prev}, so what? Killing time's my specialty, don't see {#Emph}me {#Prev}gettin' all worked up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_1821", Text = "{#Emph}Ungh..." },
					},
				},
			},
			DoraAboutTent03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutTent02" },
					},
				},
				{ Cue = "/VO/Melinoe_1822", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, I was thinking... if I promise not to be so {#Emph}uptight{#Prev}, as you call it... would you promise not to move my belongings about when I'm away?" },
				{ Cue = "/VO/Dora_0162",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 4.8 },
					Text = "{#Emph}How dare you make demands of me, you insignificant fleck? Mmm{#Prev}, nope, no deal. Want to be uptight, go ahead. Don't stop on my account." },
				{ Cue = "/VO/Melinoe_1823", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You just want to keep messing with my stuff!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						{ Cue = "/VO/Dora_0163", Text = "{#Emph}Mmm{#Prev}, that's right." },
					},
				},
			},

			DoraAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "F_Boss01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Dora_0051",
					Text = "Hey, the head witch isn't busting your chops too bad, is she? What with you coming back here pretty often lately and all." },
				{ Cue = "/VO/Melinoe_0428", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I know Headmistress can be very demanding. I'm sure she hopes I would have encountered more success by now, but... she's been nothing but patient." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0052", Text = "Really? Well I hope {#Emph}that {#Prev}sticks!" },
					},
				},
			},

			DoraAboutCompanions01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "DoraAboutExisting01", "DoraListless01" },
					},
				},
				{ Cue = "/VO/Melinoe_0435", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Have you ever even spoken with Commander Schelemeus, Dora? Or Odysseus? We have these great masters on our side, who know so much of history. So much they can teach us." },
				{ Cue = "/VO/Dora_0154",
					Text = "History? That what they call it nowadays? Well, I don't have big plans to go to war with the rest of you anytime soon, though if I change my mind, I'll probably check in with those guys." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0436", Text = "They're good people!" },
					},
				},
			},

			DoraAboutShades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01", },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_0429", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Don't you have friends among the other Shades, Dora? You could join them for some activity out there. It's picked up a lot of late." },
				{ Cue = "/VO/Dora_0059",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 1.35 },
					Text = "{#Emph}Foolish witch! {#Prev}Haunting this tent is a full-time obsession. We lesser Shades can be a little single-minded. I guess kind of like mortals." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0430", Text = "Not just mortals..." },
					},
				},
			},
			DoraAboutShades02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Dora_0044",
					Text = "How'd you get all those other Shades out there to do the busywork around here, anyway? They practically worship the ground you walk on." },
				{ Cue = "/VO/Melinoe_0433", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Headmistress took them in. I helped train and communicate with them. Many came from being trapped between the realms. Some never got a proper burial. Others died unfulfilled, or violently. They never made it to the Underworld." },
				{ Cue = "/VO/Dora_0045",
					Text = "{#Emph}Oof{#Prev}... that's rough. Say, you don't think {#Emph}I {#Prev}fall into one of those categories, there, do you? I'd hate to think I didn't get a {#Emph}proper burial{#Prev}." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0434", Text = "It's not a laughing matter, Dora." },
					},
				},
			},
			DoraAboutShades03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "DoraWithMoros02" },
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0168",
					Text = "Getting crowded out there! More Shades, guy with the horns. I don't like it, Mel! Not one bit." },
				{ Cue = "/VO/Melinoe_1824", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "As we grow in numbers, we grow in strength. What's your concern with that?" },
				{ Cue = "/VO/Dora_0169",
					Text = "Don't like to share. Except this tent, I don't mind sharing it with you! Most of the time." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1825", Text = "I'm honored." },
					},
				},
			},
			-- @ note: add DoraAboutShades04_B using Dora_0196, referencing Big Important Task
			DoraAboutShades04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						IsAny = { 1, 2 },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraListless01", "DoraAboutShades03", "DoraWithMoros02", "DoraGift03" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "DoraWithMoros02" }, Count = 3 },
				},
				-- taverna
				TeleportToId = 589544,

				{ Cue = "/VO/Melinoe_2034", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora! {#Emph}Wow! {#Prev}What brings you all the way out here? The taverna's just about the last place I expected to find you." },
				{ Cue = "/VO/Dora_0196_B",
					Text = "{#Emph}Um{#Prev}, way to make me feel incredibly self-conscious, thanks, Mel! But, yeah I'm, I'm trying to put myself out there a bit more, I guess...!" },
				{ Cue = "/VO/Melinoe_2035", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well I think that's great. Though, I know how difficult it is. I used to never be able to approach others, but I kept doing it, and... it's easier now." },
				{ Cue = "/VO/Dora_0197",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Easier, but... never {#Emph}easy{#Prev}, right? {#Emph}Ehh{#Prev}, don't know why I bother... most of these Shades are pretty boring." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2036", Text = "They haven't met {#Emph}you {#Prev}yet!" },
					},
				},
			},

			DoraAboutOutside01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraWithMoros02", "DoraAboutShades04" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_2032", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "It's been nice to see you out and about a little more often lately, not just cooped up in here. How are you managing? " },
				{ Cue = "/VO/Dora_0174",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Eh{#Prev}, I'm managing. Those other Shades don't know the first thing about haunting, and it turns out they've got the dirt on {#Emph}everybody {#Prev}here... including {#Emph}you." },
				{ Cue = "/VO/Melinoe_2033", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Comforting to know the brunt of our resistance is enjoying themselves a good bit of gossip." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0175", Text = "{#Emph}Ohh {#Prev}yeah." },
					},
				},
			},

			DoraAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "N_Opening01" },
					},
				},
				{ Cue = "/VO/Melinoe_0431", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You must remember something of life on the surface, right, Dora? Anything at all? I wonder what it must have been like." },
				{ Cue = "/VO/Dora_0060",
					Text = "I {#Emph}don't {#Prev}remember, and I {#Emph}don't {#Prev}wonder! Who cares? {#Emph}This {#Prev}is the life, right here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0432", Text = "{#Emph}<Sigh>" },
					},
				},
			},
			DoraAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomCountCache", "H_Intro" },
					},
				},
				{ Cue = "/VO/Dora_0155",
					Text = "Hey, you're up. You were out a while. See anything good down there that time?" },
				{ Cue = "/VO/Melinoe_0437", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I fought past Erebus, down into Oceanus. It was so strange, being underneath the sea. Do you remember the sea, Dora?" },
				{ Cue = "/VO/Dora_0156",
					Emote = "PortraitEmoteDepressed",
					Text = "The sea... the sea, the sea, the sea, {#Emph}that's {#Prev}the thing with all the {#Emph}water {#Prev}in it, {#Emph}right? {#Prev}Heard it's nice {#Emph}sometimes! {#Prev}Also {#Emph}kills {#Prev}a bunch of people, death by drowning, so.... {#Emph}Huh{#Prev}, I've been getting mixed messages, I guess." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0438", Text = "It's a big place..." },
					},
				},
			},
			DoraAboutFields01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Intro_" },
					},
				},
				{ Cue = "/VO/Dora_0295",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Oof{#Prev}, you look rough, if we're being honest, Mel. Want to talk about it, or at least tell me the juicy bits because I'm bored?" },
				{ Cue = "/VO/Melinoe_3380", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Last night I visited the Mourning Fields, and... being surrounded by that much despair... I think I must have brought some of it home." },
				{ Cue = "/VO/Dora_0296",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 1.5 },
					Text = "Well why don't I just {#Emph}scare it out of you, you wretched worm?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3381", Text = "Hey that worked." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0297",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							Text = "I know, right?" },
					},					
				},
			},
			DoraAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
				},
				{ Cue = "/VO/Dora_0298",
					Text = "Hey where've you been? You {#Emph}smell! {#Prev}Not in a bad way necessarily, and I don't know how I {#Emph}can {#Prev}smell, or remember any smell, so... that is weird." },
				{ Cue = "/VO/Melinoe_3382", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I was up top. Must be the sea air and the salt, distinct from Oceanus down below. I sailed across the waters, toward Olympus, on a ship! " },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0299",
							Text = "Exciting! I was right here the whole time." },
					},
				},
			},
			DoraRunProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				TeleportToId = 566842,

				{ Cue = "/VO/Dora_0035",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 5.3 },
					Text = "{#Emph}Gah! A scourge upon your bloodline for re-summoning me, witch! {#Prev}Hey, {#Emph}uh, {#Prev}everything OK, there, Mel?" },
				-- { Cue = "/VO/Melinoe_0005", UsePlayerSource = true,
				{ Cue = "/VO/Melinoe_0407", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, yes Dora, it's just... I should have gone farther that time. I'll give more notes on your haunting later, all right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0036", Text = "Oh. Sure..." },
					},
				},
			},

			DoraAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "F_Boss01" },
					},
				},

				TeleportToId = 422140,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Melinoe_0416", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, don't you pay any attention to what's been happening out there? The rise of the Titan of Time? The siege of Olympus?" },
				{ Cue = "/VO/Dora_0057",
					Text = "Nope. Can't say any of that rings a bell. Olympus, that's where the family members you {#Emph}don't {#Prev}like live, right? And the Titan of Time, I get that he's bad, but he's never done anything to me personally, as far as I know, so..." },
				{ Cue = "/VO/Melinoe_0417", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This entire encampment exists to resist his efforts to overthrow the gods and rule the world?" },
				{ Cue = "/VO/Dora_0058",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Well then! Maybe I should thank him because I happen to like this encampment." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0418", Text = "Oh shush!" },
					},
				},
			},
			DoraAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "CurrentRun", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
				},

				TeleportToId = 422140,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0292",
					Text = "{#Emph}Whoa{#Prev}, hold on, what's going on with you? Never seen you so excited in my life. Death. Whatever. What, did you discover a new species of root vegetable or something?" },
				{ Cue = "/VO/Melinoe_3378", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, I found him... Chronos... and I {#Emph}beat {#Prev}him! Withstood every trick he had, until he yielded and expired." },
				{ Cue = "/VO/Dora_0293",
					Text = "Oh, {#Emph}nice! {#Prev}So then it's {#Emph}over{#Prev}, right? Or what...?" },
				{ Cue = "/VO/Melinoe_3379", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, no, he isn't {#Emph}dead... {#Prev}I mean, he isn't {#Emph}gone{#Prev}. Not yet. I have to go... all right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						PreLineAnim = "Dora_Shrug",
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0294",
							Text = "Yeah. All good." },
					},
				},
			},

			DoraAboutPackagedBounties01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},

				TeleportToId = 422140,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0287",
					Text = "Hey, what happened, you look weird or something, I don't know. Weren't out too long. Took someone to the woods...?" },
				{ Cue = "/VO/Melinoe_3373", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "No, Dora, though I don't think I can sufficiently explain. You know the Pitch-Black Stone? Turns out it can... do things." },
				{ Cue = "/VO/Dora_0288",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "The purple rock can {#Emph}do things{#Prev}, you say.... Know what? I don't even want to know the rest, just gonna let my imagination take over for you, thanks." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3374", Text = "Anytime?" },
					},
				},
			},

			DoraAboutPainting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "CrossroadsFamilyPortrait02" },
					},
					--[[
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 2,
					},
					]]--
				},

				-- TeleportToId = 422140,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0289",
					Text = "You've been staring at that picture more and more. {#Emph}Happy family! {#Prev}Well it's starting to get to me, because I think it's starting to get to {#Emph}you. {#Prev}Don't get all misty on me, Mel." },
				{ Cue = "/VO/Melinoe_3376", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Thank you, Dora. Though you needn't worry. I won't get lost in memories because there isn't much for me to remember. I just wonder what my brother and my birthparents were like." },
				{ Cue = "/VO/Dora_0290",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Uh-huh! {#Prev}Sounds awful lot like dwelling on the past to me. Nothing you could have done! Hey... you could be doing nothing right {#Emph}now." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3377", Text = "I'll give it some thought." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0291",
							Text = "Or don't!" },
					},
				},
			},

			DoraAboutExisting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 6,
					},
				},
				TeleportToId = 566843,

				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0039",
					Text = "{#Emph}Ahh {#Prev}hey Mel, I was just... floating! Floating around, I guess. And existing! Just kind of existing a lot lately. You?" },
				{ Cue = "/VO/Melinoe_0409", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Failing. Making progress, I don't know. Speaking of, shouldn't you be practicing your haunting, Dora?" },
				{ Cue = "/VO/Dora_0040",
					Text = "Oh! Yeah, no, I thought maybe I'd take a break from that. Why do now what you could do later, right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0410", Text = "For the sense of accomplishment?" },
					},
					{
						PreLineWait = 0.15,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0041", Text = "{#Emph}Pffsh!" },
					},
				},
			},
			DoraListless01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutTask01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Dora_0046",
					Text = "Not going to lie, Mel, sometimes I wish {#Emph}I {#Prev}had a big important task. Not that floating isn't one." },
				{ Cue = "/VO/Melinoe_0064", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know my stance on this, Dora. You need to get out of this tent. You're very talented! I've never met a Shade that speaks like you." },
				{ Cue = "/VO/Dora_0047",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Ooh{#Prev}, I can talk, makes me {#Emph}so special. Tsch! {#Prev}I'm sure any lowly Shade could do it after being stuck here listening to {#Emph}you people {#Prev}long enough. I was fed up with just warbling, so I learned to sound it out, I guess." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0065", Text = "I'm glad you did." },
					},
				},
			},
			DoraListless02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "DoraListless01", "DoraAboutExisting01" },
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Melinoe_0414", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Everything all right, Dora? Any new hauntings need evaluation or anything?" },
				{ Cue = "/VO/Dora_0050",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Nah! {#Prev}I — I'm — I'm fine, it's just... think I've hit a bit of a slump is all. {#Emph}Happens{#Prev}, right? I'll get over it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0415", Text = "Good." },
					},
				},
			},
			DoraListless03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraListless01", "DoraListless02" },
					},
				},
				TeleportToId = 566842,

				{ Cue = "/VO/Dora_0048",
					Text = "Hey, if I were you I'd... well, come to think of it, I'd... I'd do a lot of things. Go for a jog! That seems nice. Having legs! Getting the heart rate going, a heart seems nice!" },
				{ Cue = "/VO/Melinoe_0066", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Stop it, Dora. I don't like it when you get like this." },
				{ Cue = "/VO/Dora_0049",
					Text = "...Make something with my hands! I don't know, a cup? A bowl. I'd eat! Eating seems {#Emph}nice. {#Prev}Or even just remembering what that was like..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.65,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0067", Text = "Take care, Dora..." },
					},
				},
			},

			DoraAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Dora_0037",
					Text = "Ever think maybe we're just not cut out for this, Mel? Me with the haunting, you with the... what're you trying to do, again?" },
				{ Cue = "/VO/Melinoe_0408", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 7.9 },
					Text = "{#Emph}Find the Titan of Time. Punish him for his crimes against my family. Restore the rightful ruler of the Underworld.... {#Prev}Hey, you're cut out for haunting, Dora!" },
				{ Cue = "/VO/Dora_0038",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Aw{#Prev}, thanks! Just like I'm sure you're cut out for all that other stuff." },
			},

			DoraAboutHaunting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Melinoe_0411", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "What would you do if you had the tent all to yourself, anyway, Dora? You could invite all the other Shades and absolutely trash the place I suppose." },
				{ Cue = "/VO/Dora_0042",
					Emote = "PortraitEmoteSurprise",
					Text = "Wh, what, you mean {#Emph}share {#Prev}it? Mel, {#Emph}not sharing {#Prev}the tent is the entire point, a proper haunting has a one-to-one ratio between the haun{#Emph}ted {#Prev}and the haun{#Emph}tee{#Prev}. Even {#Emph}I {#Prev}haven't forgotten the basics." },
				{ Cue = "/VO/Melinoe_0412", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I can't imagine all you want to do is float around in here, minus the part where we get to speak." },
				{ Cue = "/VO/Dora_0043",
					Text = "Then you simply lack imagination, friend!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0413", Text = "{#Emph}Heh." },
					},
				},
			},
			DoraAboutHaunting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift01", "DoraAboutHaunting01" },
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Dora_0187",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Everlasting pain and suffering upon you, witch! You trespass on my hallowed ground. Your cries for mercy shall drown in your throat!" },
				{ Cue = "/VO/Melinoe_2019", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Please! Forgive my careless indiscretion, madam-spirit, I beg of you! I intended no offense..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0188",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
							Text = "{#Emph}Ho-hoh, wow! {#Prev}You're really into this stuff, huh?" },
					},
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2020", Text = "Oh, come on!" },					},
				},
			},

			DoraAboutNightmares01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "NightmareOccurred" },
					},
					{
						Path = { "GameState", "NightmaresOccurred" },
						Comparison = "<=",
						Value = 3,
					},
				},

				{ Cue = "/VO/Dora_0164",
					Emote = "PortraitEmoteSurprise",
					Text = "Whoa, what gives there, Mel? Y-you look like you've seen a... {#Emph}ungh{#Prev}, I don't know, but... whatever it was it got under your skin. {#Emph}<Gasp> Oh! {#Prev}Skin seems nice!" },
				{ Cue = "/VO/Melinoe_2015", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I'm all right, just a little shaken. First nightmare since all this started." },
				{ Cue = "/VO/Dora_0165",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 5.5 },
					Text = "About time, you were past due. Oh, how scary would you say it was, compared to, {#Emph}um, the terrifying visage that you see before you now?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2016", Text = "Not even close." },
					},
				},
			},
			DoraAboutNightmares02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "NightmareOccurred" },
					},
				},

				{ Cue = "/VO/Dora_0166",
					Text = "Wonder if I ever used to have nightmares... so, so you can just... imagine yourself in these completely different {#Emph}horrible {#Prev}situations?" },
				{ Cue = "/VO/Melinoe_2017", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Yes. And sometimes I'm not even there, which can make them even more unsettling. Though they don't trouble me as much anymore..." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Dora_01",
					{ Cue = "/VO/Dora_0167", Text = "Well, at least you've got me." },
				},
			},

			DoraAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutTask01", },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 2,
					},
				},

				-- TeleportToId = 561033,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,

				{ Cue = "/VO/Dora_0053",
					Text = "Hey if you showed up just a bit sooner, you could have heard Nemesis complaining up a storm again!" },
				{ Cue = "/VO/Melinoe_1602", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Best not mock Retribution Incarnate if you know what's good for you. She and Headmistress have been at each other's throats..." },
				{ Cue = "/VO/Dora_0054",
					Text = "You know I could, like, {#Emph}possess {#Prev}her for you, right? Just kind of... swoop in there, rattle around in her head a little bit, make her do some {#Emph}bad {#Prev}stuff... {#Emph}<Gasp> embarrassing {#Prev}stuff! Just for a little while, I mean. If I got caught in there..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0069", Text = "Dora, don't..." },
					},
				},
			},
			DoraAboutHypnos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0157",
					Text = "Get any sleep at least while you're zonked out back there? {#Emph}Huh{#Prev}, can't even wrap my head around what it must be like for you. Sleeping? They... they say it's like being dead, right? But I'm dead, and I'm always awake." },
				{ Cue = "/VO/Melinoe_0070", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think the only one getting good sleep of late is Hypnos, himself. Still hasn't even stirred, no matter what Headmistress has tried." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0056", Text = "Lucky him." },
					},
				},
			},

			DoraAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutMoros02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "DoraAboutMoros02" },
					},
				},
				{ Cue = "/VO/Dora_0176",
					Text = "So, what's the deal with the horned guy, anyway? Saw him and Nemesis chatting like they were an item, or something. It was weird." },
				{ Cue = "/VO/Melinoe_1826", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "They're siblings, Dora. The horned one is Lord Moros, emissary of the Three Fates. Our distinguished guest, and a valuable ally." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0177", Text = "Yeah! Looks like we really put him up in style..." },
					},
				},
			},
			DoraAboutMoros02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 4,
					},
					AreIdsAlive = { 560612 },
				},
				-- TeleportToId = 561033,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,

				{ Cue = "/VO/Dora_0178",
					Text = "Wait, so the horned guy over there... {#Emph}he's {#Prev}the one who shows up whenever some mere mortal is about to {#Emph}die {#Prev}in some horrific, unexpected way?" },
				{ Cue = "/VO/Melinoe_2029", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, yes. He ensures the will of the Three Fates is done. But don't misjudge him for it, and there's no need to be afraid of him, either." },
				{ Cue = "/VO/Dora_0179",
					Emote = "PortraitEmoteFiredUp",
					Text = "Are you kidding? I think that's awesome, I... I wonder if he saw {#Emph}me {#Prev}die! Maybe I got crushed by a boulder! Struck by lightning! {#Emph}<Gasp> {#Prev}Murdered by my own lover...! Could you introduce us?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2030", Text = "{#Emph}Erm... {#Prev}sure?" },
					},
				},
			},
			DoraAboutMoros03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraWithMoros01", "MorosGift02" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Moros_01" },
					},
				},
				{ Cue = "/VO/Dora_0185",
					Text = "Saw you chatting up Horns again! Yeah, he's a bit of a stiff, but I guess he's not so bad. Think maybe I {#Emph}met {#Prev}him before, back when I died..." },
				{ Cue = "/VO/Melinoe_2023", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Oh I doubt it. You'd remember having met someone like that. And he'd remember you as well! Though, you have been dead a while..." },
				{ Cue = "/VO/Dora_0186",
					Text = "Yeah. Maybe I was one of his first jobs. Just an innocent young woman, doomed to a cruel inevitable future she never deserved..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2024", Text = "OK, Dora." },
					},
				},
			},

			DoraAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
				},
				{ Cue = "/VO/Melinoe_2027", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Do you remember the name {#Emph}Heracles? {#Prev}The greatest half-god hero of the surface, slayer of the Nemean Lion, and so on?" },
				{ Cue = "/VO/Dora_0194",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Nah, not really. But I hear the other Shades go {#Emph}on {#Prev}and {#Emph}on {#Prev}about him every now and then. Why do you ask?" },
				{ Cue = "/VO/Melinoe_2028", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I encountered him. He's as big as they say, that much is sure. He has such a storied past, I thought maybe you'd recall one of the tales." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						{ Cue = "/VO/Dora_0195", Text = "Well, you thought wrong, my friend." },
					},
				},
			},

			-- Partner Conversations
			DoraWithMoros01 =
			{
				PlayOnce = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMoros02" },
					},
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				UseableOffSource = true,
				TeleportToId = 566622,
				TeleportOffsetX = 180,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 560612,
				InteractDistance = 450,
				{ Cue = "/VO/Dora_0180",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 1.7, Emote2 = "PortraitEmoteSparkly", Portrait2 = "Portrait_Dora_Default_01", WaitTime2 = 8.3 },
					Text = "...And so I say, {#Emph}begone accursed witch! I have occupied this grove for aeons, long before your pitiable tent came to rest upon it! {#Prev}Oh hey Mel." },
				{ Cue = "/VO/Melinoe_2031", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I see the two of you have met! Lord Moros, Dora speaks the truth as always. She's been here longer than I have, if you can believe it!" },
				{ Cue = "/VO/Moros_0184", Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					PreLineAnimTarget = 560612,
					PostLineAnimTarget = 560612,
					Text = "I can, indeed. For I know an old soul when I see one. It's a pleasure to meet you, Dora. Do let me know if I can be of service in some way." },
				{ Cue = "/VO/Dora_0181",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.55 },
					PostLineFunctionName = "DoraTeleportExit",
					Text = "{#Emph}Haha. {#Prev}Count on it, Horns! Now then, {#Emph}I bid your leave. Farewell!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0185", Text = "Farewell!" },
					},
				},
			},

			DoraWithMoros02 =
			{
				PlayOnce = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraWithMoros01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "DoraWithMoros01" }, Count = 3 },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				TeleportToId = 566622,
				TeleportOffsetX = 180,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 560612,
				InteractDistance = 450,
				{ Cue = "/VO/Dora_0182",
					Text = "...His own {#Emph}brother? Eugh, {#Prev}no way, that is twisted! Your sisters are sick!" },
				{ Cue = "/VO/Moros_0186",
					Portrait = "Portrait_Moros_Default_01", Speaker = "NPC_Moros_01",
					Text = "Well... they have many mortal lives to untangle, so to speak. The work can grow repetitive, lose its spark. So they liven things up from time to time." },
				{ Cue = "/VO/Dora_0183",
					Text = "Oh totally I, I would completely do the same if I were them. I wonder what they did to {#Emph}me.... {#Prev}Could you, like, look me up, or something...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0187", Text = "{#Emph}Heh! {#Prev}I fear I'm not at liberty to do such things." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0184", Text = "{#Emph}Ah{#Prev}, come on..." },
					},
				},
			},

			-- Repeatable
			DoraChat01 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0006",
					Text = "I'll keep an eye on all your stuff while you're away." },
			},
			DoraChat02 =
			{

				-- TeleportToId = 422254,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,

				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0007",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Good to chat, but I better get back to haunting." },
			},
			DoraChat03 =
			{

				-- TeleportToId = 422140,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0008",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Got a lot of weird stuff in here, you know that?" },
			},
			DoraChat04 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0009",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Just haunting up the place. Don't worry about me..." },
			},
			DoraChat05 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0010",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.5 },
					Text = "Hey, Mel. I mean, {#Emph}Ravens shall feast on your eyes!" },
				StatusAnimation = false,
			},
			DoraChat06 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0011",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.0 },
					Text = "Hey, Mel. I mean, {#Emph}In seeking me you seek only your doom!" },
				StatusAnimation = false,
			},
			DoraChat07 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0012",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Disturb me thus and I shall torment you for three eternities!" },
				StatusAnimation = false,
			},
			DoraChat08 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0013",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}May your days be filled with dread, your nights with fear!" },
				StatusAnimation = false,
			},
			DoraChat09 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0014",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}A thousand curses on you for invoking me!" },
				StatusAnimation = false,
			},
			DoraChat10 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0015",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Do not presume to tarry o'erlong within my tent, witch!" },
				StatusAnimation = false,
			},
			DoraChat11 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0017",
					Text = "Do what you got to do. I'm not even here." },
			},
			DoraChat12 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0018",
					Text = "Juuust floatin' around, don't mind me." },
			},
			DoraChat13 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0019",
					Text = "Feel free to stay in your own tent as long as you like." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
			},
			DoraChat14 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0020",
					Text = "Let me know if there's somebody I can torment for you, OK?" },
				StatusAnimation = false,
			},
			DoraChat15 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0021",
					Text = "Hope your big task thing's been going all right!" },
			},
			DoraChat16 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0022",
					Text = "I'll try not to muck everything up while you're out." },
			},
			DoraChat17 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0023",
					Text = "{#Emph}Uhh{#Prev}, can I get a little privacy, here, Mel?" },
				StatusAnimation = false,
			},
			DoraChat18 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0024",
					Text = "Sooner you get out of here, sooner I can go through all your stuff." },
			},
			DoraChat19 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0025",
					Text = "{#Emph}You {#Prev}exist, {#Emph}I {#Prev}exist... could be worse, right?" },
			},
			DoraChat20 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0026",
					Text = "Have a good whatever time it is doing whatever it is you do!" },
				StatusAnimation = false,
			},

			DoraChat21 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01", },
					},
				},
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0027",
					Text = "Go knock 'em dead for me, or back to life! Whatever's worse." },
			},
			DoraChat22 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01", },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				SkipContextArt = true,
				StatusAnimation = false,
				{ Cue = "/VO/Dora_0028",
					Text = "I'm going to haunt this tent {#Emph}so bad {#Prev}once you get out of here..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
			},
			DoraChat23 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01", },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0029",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Just go with the flow out there! It's what I do!" },
			},
			--[[
			DoraChat24 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "" },
				StatusAnimation = false,
			},
			]]--
			DoraChat25 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0031",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Hope nothing horrible happens to you out there!" },
			},
			DoraChat26 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0032",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Mel, you've inspired me... to float right here, for the time being." },
			},
			DoraChat27 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0033",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.0 },
					Text = "Hey, Mel! I mean, {#Emph}You hold no sway over me, witch!" },
				StatusAnimation = false,
			},
			DoraChat28 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				{ Cue = "/VO/Dora_0034",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Your incessant reappearances have come to be acceptable, witch!" },
				StatusAnimation = false,
			},

		},

		GiftTextLineSets =
		{
			DoraGift01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
				},
				{ Cue = "/VO/Melinoe_0441", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wanted you to have this, Dora. To the best haunter in all the Crossroads!" },
				{ Cue = "/VO/Dora_0102",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "See, I {#Emph}knew {#Prev}you were going to pull this gift-custom thing on me sooner or later, so I have come prepared. Catch!" },
			},
			DoraGift02 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01" },
					},
				},
				{ Cue = "/VO/Dora_0103",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Oh, you don't need to get this kind of stuff for me! I can just take whatever stuff of yours I want when you're out!" },
				{ Cue = "/VO/Melinoe_0443", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well you can't take {#Emph}this {#Prev}while I'm out! I keep it on me at all times, for just such an occasion." },
			},
			DoraGift03 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift02" },
					},
				},
				{ Cue = "/VO/Dora_0104",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 4.8 },
					Text = "{#Emph}Fool! I am not susceptible to mere baubles such as this! Ah{#Prev}, just kidding. {#Emph}Totally {#Prev}susceptible. Gimme!" },
				{ Cue = "/VO/Melinoe_0444", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "At last, I have discovered a vulnerable point in your defenses!" },
			},
			DoraGift04 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift03" },
					},
				},
				{ Cue = "/VO/Dora_0105",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Starting to get the feeling maybe I liked this stuff back when I had eyeballs and so on." },
				{ Cue = "/VO/Melinoe_0445", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Doesn't matter whether you liked it then, what matters is you like it now." },
			},
			DoraGift05 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				LockedHintId = "Codex_FishNextHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift04" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0106",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Ungh{#Prev}, on the one hand, I really don't know what I did to deserve this. But on the other hand, I really don't care! It's mine now." },
				{ Cue = "/VO/Melinoe_0446", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It most certainly is! And there's more in it for you if you keep on haunting this tent!" },
			},
			DoraGift06 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift05" },
					},
				},
				{ Cue = "/VO/Dora_0107",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 5.3 },			
					Text = "{#Emph}Such pitiable offerings as this are hardly worth my notice, witch! {#Prev}No, but, seriously, thanks. Nobody ever gets me anything! Besides you, I mean. It's nice, you know?" },
				{ Cue = "/VO/Melinoe_0447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's nice for me as well! Having you here as company means a lot, so it really is the least I could do." },
			},
			-- placeholder
			DoraGiftTemp =
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

			DoraFishing01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				UnfilledIcon = "EmptyHeartWithLuresIcon",
				FilledIcon = "FilledHeartWithLuresIcon",
				HintId = "Codex_FishingGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift03", },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				{ Cue = "/VO/Melinoe_0440", UsePlayerSource = true,
					Text = "Hey, if you're not busy, up for a little visit with me to the riverside? I've got a twin lure we could use right here." },

				{ Cue = "/VO/Dora_0081",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					Text = "Don't know that I'll be doing you much good, between my inability to use a rod of fishing and my inability to keep quiet, but hey! You asked for it." },

				{ Cue = "/VO/Dora_0084",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",

					Text = "{#Emph}Ungh{#Prev}, this is going to be {#Emph}so {#Prev}fun...",
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Dora_0099",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash" },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "Well, that definitely was a thing that happened. Thanks!" },
				EndWait = 0.5,

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0063", Text = "Bye." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0141", Text = "OK bye." },
					},
				},
			},

			DoraBathHouse01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01", },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0419", UsePlayerSource = true,
					Text = "Say Dora? Would you mind accompanying me over to the baths? I'd hate to think they aren't haunted." },
				{ Cue = "/VO/Dora_0061",
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineRemoveContextArt = true,
					Text = "Do I want to float aimlessly in some near-boiling water? Do I ever! What are we waiting for?" },
				{ Cue = "/VO/Dora_0063",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Wonder if I was ever shy about this kind of stuff..."
				},
				{ Cue = "/VO/Melinoe_0421", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "You still can sense something of the waters' warmth, can't you, Dora?" },
				{ Cue = "/VO/Dora_0071",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Well, I can see all the steam rising, which I associate with warmth, so... I guess it kind of tricks me into thinking warm thoughts." },
				{ Cue = "/VO/Melinoe_0422", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "That doesn't sound so bad. Though, you do remember what warmth was like, then? From your mortal days?" },
				{ Cue = "/VO/Dora_0072",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}Ohh{#Prev}, not really, no. I, I guess I've just heard so much about it, it's like I've experienced it myself." },
				{ Cue = "/VO/Dora_0077",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Whew! {#Prev}That was basically like floating around in your tent, though I appreciate it nonetheless!" },
			},

			DoraBathHouse02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift05", },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0577", Text = "Mm!" },
					},
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0420", UsePlayerSource = true,
					Text = "Hey I've got these bath salts here that are more than enough for me, if you're not busy at the moment...?" },
				{ Cue = "/VO/Dora_0062",
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineRemoveContextArt = true,
					Text = "Mel, you know I like doing nothing. Sitting in the bathhouse with you? Well that's got to be the next best thing so, shall we?" },

				{ Cue = "/VO/Dora_0065",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Like being cooked in a cauldron, isn't it?"
				},
				{ Cue = "/VO/Melinoe_0424", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "Don't you ever wonder how you used to be, Dora? When you were flesh and blood? I bet you were very beautiful." },
				{ Cue = "/VO/Dora_0073",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "{#Emph}Hah! Whaaat{#Prev}, seriously? Is it because of my voice or because of my curves? Nah, you're just messing with me." },
				{ Cue = "/VO/Melinoe_0425", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I am not! It's because of your confidence, I suppose. You're very self-assured! Some Shades cower before me, but you and I always got on." },
				{ Cue = "/VO/Dora_0074",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Well, some Shades are total buffoons. Anyway, it doesn't really matter to me how I used to be. If I was happy about it, I figure I'd remember." },
				{ Cue = "/VO/Melinoe_0426", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "You think you've deliberately forgotten your past?" },
				{ Cue = "/VO/Dora_0075",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Yeah. Why else would I have forgotten everything? Probably took a couple swigs from the River Lethe, and that was that! Clean slate." },
				{ Cue = "/VO/Melinoe_0427", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "The River of Forgetfulness... you think you were down in Elysium?" },
				{ Cue = "/VO/Dora_0078",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "You know, if I'm not mistaken I think I had a good time with you back there. Thanks, Mel!" },
			},

		},

		MissingDistanceTrigger =
		{
			WithinDistance = 250,
			VoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						AreIdsNotAlive = { 566832 },
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
					},

					{ Cue = "/VO/Melinoe_1154", Text = "You there, Dora...?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_3556" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_1155", Text = "Dora must be hiding for a bit." },
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.5,
			ObjectType = "NPC_Dora_01",
			Cooldowns =
			{
				{ Name = "DoraAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/Dora_0148", Text = "Hey quit it.", PlayFirst = true },
			{ Cue = "/VO/Dora_0149", Text = "{#Emph}Hah! {#Prev}No." },
			{ Cue = "/VO/Dora_0150", Text = "Kind of tickles." },
			{ Cue = "/VO/Dora_0151", Text = "Sorry, can't die." },
			{ Cue = "/VO/Dora_0152", Text = "Cut it out...!" },
			{ Cue = "/VO/Dora_0153", Text = "Seriously?" },
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_0442", Text = "For me? Thank you, Dora!" },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Dora )