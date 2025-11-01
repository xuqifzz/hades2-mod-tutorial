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
		LoadPackages = { "Dora", },

		ActiveModel = "Dora_Mesh",
		AdditionalModels = { "ScaryDora_Mesh", },

		ActivateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
			},
			{
				PathFalse = { "CurrentRun", "BlockDoraSpawn" },
			},
		},

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
							PreLineWait = 0.2,
							RandomRemaining = true,
							ChanceToPlay = 0.25,
							Cooldowns =
							{
								{ Name = "DoraAnyQuipSpeech", Time = 30 },
							},

							{ Cue = "/VO/Dora_0562", Text = "Hey, watch it!", PlayFirst = true },
							{ Cue = "/VO/Dora_0563", Text = "Personal space, Mel." },
							{ Cue = "/VO/Dora_0564", Text = "Whoa there." },
							{ Cue = "/VO/Dora_0565", Text = "Ow." },
							{ Cue = "/VO/Dora_0566", Text = "Hey, back it up." },
							{ Cue = "/VO/Dora_0567", Text = "No touching." },
							{ Cue = "/VO/Dora_0568", Text = "Back off a bit?" },
							{ Cue = "/VO/Dora_0570", Text = "Excuse {#Emph}you." },
							{ Cue = "/VO/Dora_0573", Text = "Kind of felt that." },
							{ Cue = "/VO/Dora_0571", Text = "That's a curse!" },
							{ Cue = "/VO/Dora_0572", Text = "That's a curse.",
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "SpeechRecord", "/VO/Dora_0571" }
									},
								},
							},
							{ Cue = "/VO/Dora_0574", Text = "{#Emph}You dare?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
							{ Cue = "/VO/Dora_0575", Text = "{#Emph}A curse upon you!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
						},
						ApplyEffectOnHero = "DoraSlow",
						ApplyEffectOnHeroProperties = EffectData.DoraSlow.EffectData,
						AddInteractBlock = "DoraDisappear",
					},
					Repeat = true,
					RepeatBufferDistance = 10,
					OnRepeatFunctionName = "GenericPresentation",
					OnRepeatFunctionArgs =
					{
						SetAlpha = 1.0,
						Duration = 0.5,
						RemoveInteractBlock = "DoraDisappear",
						EndFunctionName = "DoraStopDissipateFx",
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

		CosmeticsTeleportRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked" },
			{
				PathFromSource = true,
				PathFalse = { "InPartnerConversation" },
			},
			{
				PathFalse = { "SessionMapState", "DoraDidTeleportExit" },
			},
			{
				PathFromSource = true,
				PathFalse = { "ActiveNarrativeTeleportId" },
			},
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsNone = { "DoraAboutPrometheus02", "DoraAboutMemories01", "DoraListless02" }, },
			},
		},

		HauntingRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InPartnerConversation" },
			},
			{
				PathFalse = { "SessionMapState", "DoraDidTeleportExit" },
			},
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsNone = { "DoraListless01", "DoraListless02", "DoraListless03", "DoraAboutPrometheus02", "DoraAboutMemories01", "DoraWithMoros01", "DoraWithMoros02", "DoraWithMoros03", "DoraWithSkelly01" }, },
			},
		},

		ApproachVoiceLines =
		{
			GameStateRequirements =
			{
				-- needed for PlayedNothingFunctionName to fire when Dora is already talking
				{
					PathFromArgs = true,
					PathFalse = { "OriginalSource", "PlayingVoiceLine" },
				},
			},
			PlayedNothingFunctionName = "GenericPresentation",
			PlayedNothingFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			[1] = { GlobalVoiceLines = "DoraSummonedVoiceLines" },
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
			{
				PathFromSource = true,
				PathFalse = { "SpecialInteractBlockedUntilTeleport" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
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
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				ObjectType = "NPC_Dora_01",
				TriggerCooldowns = { "DoraAnyQuipSpeech" },

				{ Cue = "/VO/Dora_0202", Text = "{#Emph}You invoke me?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_2784" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0203", Text = "{#Emph}Who summons me?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_2784" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0204", Text = "{#Emph}Kneel, witch!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1885", "/VO/Melinoe_1885" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0205", Text = "{#Emph}Death to all!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0206", Text = "{#Emph}Suffer a thousand torments!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0207", Text = "{#Emph}And the sun bleach your bones!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
					},
				},
				{ Cue = "/VO/Dora_0208", Text = "{#Emph}Terror engulf us!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
						NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
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
				Threaded = true,
				FunctionName = "DoraStartHaunting",
				Args =
				{
					PreWait = 0.1,
				},
			},
		},

		TextLinesEndEvents =
		{
			{
				Threaded = true,
				FunctionName = "DoraCheckForNewItems",
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
					-- 1 = Tent; 2 = Main; 3 = Taverna; 4 = PreRun
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0004_01_B",
					-- Portrait = "Portrait_Dora_Thoughtful_01",

					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					AutoAdvance = true,
					TextOffsetY = -22,
					LangTextOffsetY =
					{
						{ Code = "de",    Value = -30 },
						{ Code = "fr",    Value = -30 },
						{ Code = "ko",    Value = -45 },
						{ Code = "pl",    Value = -30 },
					},
					VerticalJustification = "TOP",
					PostPortraitSetAnim = "DoraScary_Frighten",
					-- PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Who dares disturb my eternal rest? You trifle with powers far beyond your comprehension, witch!" },
				{ Cue = "/VO/Dora_0646",
					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Dora_Default_01",
					-- Portrait = "Portrait_Dora_Thoughtful_01",
					Append = true,
					Text = " {#Prev}That was pretty decent, right, Mel? Maybe pushing it, calling you witch like that." },
				{ Cue = "/VO/Melinoe_5191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Solid haunting all in all, Dora, and I thought the witch part worked. But, I'd better go. Something I have to do." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Dora_0005", Text = "{#Emph}Then begone!",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
					},
				},
			},

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
					--[[ cosmetics count example
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 10,
					}
					]]--
				},
				{ Cue = "/VO/Melinoe_1302", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Dora, I've a favor, if you're not too busy. My task means I no longer can oversee the renewal project around here. Would you attend to it?" },
				{ Cue = "/VO/Dora_0170",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Wait, you're asking {#Emph}me {#Prev}to watch over the total transformation of this entire encampment into some ultimate haven for Shades and outcasts?" },
				{ Cue = "/VO/Melinoe_1303", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
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

			DoraAboutCosmetics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{ Cue = "/VO/Melinoe_2021", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "The renewal project's off to a fine start! How are you managing with all the new responsibility?" },
				{ Cue = "/VO/Dora_0172",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Uh {#Prev}OK, I guess! Sometimes I think I'd rather not be doing anything... but, I get that somebody's got to do this stuff, and it's not like any of {#Emph}those {#Prev}slackers out there are gonna do it." },
				{ Cue = "/VO/Melinoe_2022", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "The other Shades have their own duties. The work needn't be onerous, it can be fulfilling! Helping others, having a sense of purpose..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Dora_0173", Text = "My {#Emph}purpose{#Prev}, Mel, is only to hang out." },
					},
				},
			},
			DoraAboutCosmetics02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutCosmetics01" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 20,
					},
				},
				{ Cue = "/VO/Dora_0310",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "I know what you're up to with all this decoration stuff you've got me doing, Mel. What, you think I'm about to find my true calling in death just by updating some old light fixtures?" },
				{ Cue = "/VO/Melinoe_3697", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "You already found your calling, as the best haunter in all the Crossroads, if not the entire world. The renewal project is simply a way to give something back to this place." },
				{ Cue = "/VO/Dora_0311",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Maybe... but I'd make a lousy haunter if my existence wasn't utterly devoid of meaning. So don't let me catch you trying to help me find some purpose... 'cause I don't want any." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 2,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3698", Text = "Perish the thought." },
					},
				},
			},
			DoraAboutCosmetics03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutCosmetics01" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Tent" },
						Comparison = ">=",
						Value = 8,
					},
				},
				TeleportToId = 566842,

				{ Cue = "/VO/Dora_0307",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Sometimes I hardly recognize this place... the tent, I mean. Just {#Emph}look {#Prev}at all this stuff! It's practically a palace now." },
				{ Cue = "/VO/Melinoe_3695", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I never thought I'd want to live in a palace. Though when you put it that way, I have second thoughts. Are all the latest decorative touches to your liking?" },
				{ Cue = "/VO/Dora_0308",
					Text = "More stuff to mess with means more haunting opportunities, so yeah! I think it's fine. It's {#Emph}you {#Prev}I'm worried about... not quite as {#Emph}neat {#Prev}and {#Emph}sparse {#Prev}in here as it used to be..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3696", Text = "We could always neaten it up again." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0309", Text = "Please no..." },
					},
				},
			},
			DoraAboutCosmetics04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift05" },
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 30,
					},
				},
				{ Cue = "/VO/Dora_0612",
					Text = "You know, back when you got me on your whole {#Emph}Renewal Project {#Prev}thing... I knew what you were up to, Mel. Nothing like a bunch of busywork to make you stop thinking about the pointlessness of your existence, right?" },
				{ Cue = "/VO/Melinoe_4681", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I never saw it as a bunch of busywork. Look at how much we've been able to accomplish here! This place is flourishing, the other Shades seem energized... you had a lot to do with that!" },
				{ Cue = "/VO/Dora_0613",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "You really think so...? What I was going to say is, at some point the busywork started to kind of grow on me. It stopped feeling pointless, even if it is." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4682", Text = "If it doesn't {#Emph}feel {#Prev}pointless, it isn't." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0614", Text = "I don't know. Maybe." },
					},
				},
			},
			DoraAboutCosmetics05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = {
							"Cosmetic_CollectableHecate",
							"Cosmetic_CollectableOdysseus",
							"Cosmetic_CollectableSkelly",
							"Cosmetic_CollectableMoros",
							"Cosmetic_CollectableNemesis",
							"Cosmetic_CollectableCharon",
							"Cosmetic_CollectableIcarus",
							"Cosmetic_CollectableArtemis",
							"Cosmetic_CollectableEris",
							"Cosmetic_CollectableDora",
							"Cosmetic_CollectableSelene",
						},
					},
				},
				{ Cue = "/VO/Dora_0649",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "You got every last one of those Chthonic Chid figures, {#Emph}huh? {#Prev}Never took you for the sort to hoard a bunch of useless stuff." },
				{ Cue = "/VO/Melinoe_5470", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "They are {#Emph}not {#Prev}useless! I {#Emph}enjoyed {#Prev}collecting them all, and have them neatly organized. And they'll likely grow even more valuable with time!" },
				{ Cue = "/VO/Dora_0650",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "What, you planning to sell 'em for {#Emph}profit? {#Prev}I don't see who's gonna take them off your hands! But... I wasn't trying to be mean. I think it's cute you got a bunch of children's toys." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5471", Text = "They're not suitable for children!" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0652", Text = "{#Emph}Mm-hmm." },
					},
				},
			},

			DoraAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					--[[
					{
						Path = { "GameState", "LastAwardTrait" },
						IsAny = { "DoorHealReserveKeepsake" },
					},
					]]--
					{
						PathTrue = { "CurrentRun", "TraitCache", "DoorHealReserveKeepsake" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Intro" }
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Dora_0305",
					Text = "Hey, how's the old Ghost Onion working out? Figured you'd make better use of something that helps keep you alive than I can at this point... also it's kind of gross." },
				{ Cue = "/VO/Melinoe_3694", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "It's been very helpful, thank you, Dora. Though your Onion means I'm staying out longer than usual most nights, while you're here on your own..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0306", Text = "I see everything is proceeding as planned..." },
					},
				},
			},

			DoraAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
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
						Value = 10,
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
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

			DoraAboutFrinos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift06" },
					},
					{
						Path = { "GameState", "SpecialInteractRecord", "FrogFamiliar" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "PrevRun", "SpecialInteractRecord", "FrogFamiliar" },
					},
				},

				{ Cue = "/VO/Dora_0303",
					Text = "You know you can tell me anything, Mel. I won't judge! Well... maybe a little more than the other small green squishy thing you bare your soul to every night, but still." },
				{ Cue = "/VO/Melinoe_3692", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I never made that particular connection between you and Frinos before. I speak to him about my setbacks and mistakes... but I'm happy to save some for you if you like!" },
				{ Cue = "/VO/Dora_0304",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Yep, just lay 'em on me! And the bigger the screw-up, the more I want to know {#Emph}every juicy detail." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3693", Text = "I appreciate your service." },
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
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, couldn't help but notice that my jar collection wasn't sorted properly. Are you trying to subtly drive me mad?" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutTent01" },
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
				{ Cue = "/VO/Dora_0160",
					Text = "You know, Mel, you can be a bit uptight sometimes. Where'd you even get that from? Even the head witch is more relaxed than you." },
				{ Cue = "/VO/Melinoe_1820", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, I was thinking... if I promise not to be so {#Emph}uptight{#Prev}, as you call it... would you promise not to move my belongings about when I'm away?" },
				{ Cue = "/VO/Dora_0162",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 4.8 },
					Text = "{#Emph}How dare you make demands of me, you insignificant fleck? Mmm{#Prev}, nope, no deal. Want to be uptight, go ahead, don't stop on my account." },
				{ Cue = "/VO/Melinoe_1823", UsePlayerSource = true,
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
						PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "DoraWithSkelly01" },
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Don't you have friends among the other Shades, Dora? You could join them for some activity out there. It's picked up a lot of late." },
				{ Cue = "/VO/Dora_0059",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 1.35 },
					Text = "{#Emph}Foolish witch! {#Prev}Haunting this tent is a full-time obsession. We lesser Shades can be a little single-minded! I guess kind of like mortals." },
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
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Dora_0044",
					Text = "How'd you get all those other Shades out there to do the busywork around here, anyway? They practically worship the ground you walk on." },
				{ Cue = "/VO/Melinoe_0433", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Headmistress took them in. I helped train and communicate with them. Many came from being trapped between the realms. Some never got a proper burial. Others died unfulfilled, or violently. They never made it to the Underworld." },
				{ Cue = "/VO/Dora_0045",
					Portrait = "Portrait_Dora_Thoughtful_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Dora_Default_01", WaitTime = 2.9 },

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
			-- mutually-exclusive alt below
			DoraAboutShades04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				TeleportToId = 589544,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "DoraAboutShades04_B", "DoraGrantsCosmeticsShop01" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						IsAny = { 1, 2, 3 },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraListless01", "DoraAboutShades03", "DoraWithMoros02", "DoraGift03" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraWithMoros02" }, Min = 3 },
					},
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},

				{ Cue = "/VO/Melinoe_2034", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora! {#Emph}Wow! {#Prev}What brings you all the way out here? The taverna's just about the last place I expected to find you." },
				{ Cue = "/VO/Dora_0196_B",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Um{#Prev}, way to make me feel incredibly self-conscious, thanks, Mel! But, yeah I'm, I'm trying to put myself out there a bit more, I guess...!" },
				{ Cue = "/VO/Melinoe_2035", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well I think that's great. Though, I know how difficult it is. I used to never be able to approach others, but I kept doing it, and... it's easier now." },
				{ Cue = "/VO/Dora_0197",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",
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
			DoraAboutShades04_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- taverna
				TeleportToId = 589544,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutShades04" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						IsAny = { 1, 2, 3 },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraListless01", "DoraAboutShades03", "DoraWithMoros02", "DoraGift03", "DoraGrantsCosmeticsShop01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraWithMoros02" }, Min = 3 },
					},
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" },
					},
				},
				OnQueuedFunctionName = "GenericPresentation",
				OnQueuedFunctionArgs =
				{
					OverwriteSourceKeys =
					{
						SpecialInteractBlockedUntilTeleport = true,
					},
				},

				{ Cue = "/VO/Melinoe_2034", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora! {#Emph}Wow! {#Prev}What brings you all the way out here? The taverna's just about the last place I expected to find you." },
				{ Cue = "/VO/Dora_0196",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Um{#Prev}, way to make me feel incredibly self-conscious, thanks, Mel! But, yeah I'm, I'm trying to put myself out there a bit more, I guess...! Now that you've saddled me with my big important task." },
				{ Cue = "/VO/Melinoe_2035", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well I think that's great. Though, I know how difficult it is. I used to never be able to approach others, but I kept doing it, and... it's easier now." },
				{ Cue = "/VO/Dora_0197",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",
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
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
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
			DoraAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Dora_0342",
					Text = "Hey, you were talking in your sleep a little bit. Not that I paid too close attention, but... where were you last night, anyway? You seem a little off." },
				{ Cue = "/VO/Melinoe_3724", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Oh, just... I was up there, on the surface. I never thought I'd see it for myself, and now I'm there night after night. It's cold, damp... overrun with the dead." },
				{ Cue = "/VO/Dora_0343",
					Text = "You're really selling me on the whole thing. If it's that bad, how come you keep on going over there? I'd just stay here if I were you... or me." },
				{ Cue = "/VO/Melinoe_3725", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "You don't understand. I have to go that way. It's part of my task. Well, not officially, but... look I won't bore you with the details. I should go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						PreLineAnim = "Dora_Shrug",
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0344", Text = "Have fun being all cold and damp." },
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
						PathTrue = { "CurrentRun", "RoomsEntered", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "H_Intro" },
					},
				},
				{ Cue = "/VO/Dora_0155",
					Text = "Hey, you're up. You were out a while. See anything good down there that time?" },
				{ Cue = "/VO/Melinoe_0437", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I fought past Erebus, down into Oceanus. It was so strange, being underneath the sea. Do you remember the sea, Dora?" },
				{ Cue = "/VO/Dora_0156",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Emote = "PortraitEmoteDepressed",
					Text = "The sea... the sea, the sea, the sea, {#Emph}that's {#Prev}the thing with all the {#Emph}water {#Prev}in it, {#Emph}right? {#Prev}Heard it's nice {#Emph}sometimes! {#Prev}Also {#Emph}kills {#Prev}a bunch of people, death by drowning, so — I've been getting mixed messages, I guess." },
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
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Dora_0295",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Oof{#Prev}, you look rough, if we're being honest, Mel. Want to talk about it, or at least tell me the juicy bits because I'm bored?" },
				{ Cue = "/VO/Melinoe_3380", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Last night I visited the Mourning Fields, and... being surrounded by that much despair... I think I must have brought some of it home." },
				{ Cue = "/VO/Dora_0296",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 1.5 },
					Text = "Well why don't I just {#Emph}scare it out of you, you wretched worm?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3381", Text = "Hey, that worked!" },
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
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
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

			DoraAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Dora_0317",
					Text = "I try {#Emph}not {#Prev}to listen to what the Shades out there are warbling about, but they make it sound like lately you've been through some pretty hairy times?" },
				{ Cue = "/VO/Melinoe_3703", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "It's hard to know exactly what they're referring to, but... I've managed to reach Mount Olympus, for one thing. Never thought I'd see it. The fighting there is very fierce..." },
				{ Cue = "/VO/Dora_0318",
					Text = "{#Emph}Olympus... {#Prev}where the other members of your family have all been hanging out! What are they fighting over now?" },
				{ Cue = "/VO/Melinoe_3704", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Their reign over the heavens and the Earth, and the continued existence of their home." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Dora_0319", Text = "Oh! That's nothing new." },
					},
				},
			},

			-- alt below
			DoraAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutOlympus01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutTyphon01_B" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Dora_0496",
					Text = "So, how's it going on Olympus recently? Or wherever you were last night. See anything good up there besides the snow? Not sure how come I know about snow..." },
				{ Cue = "/VO/Melinoe_4419", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I made it all the way to the summit, where I confronted the ancient monster called {#Emph}Typhon. {#Prev}It's said that all other monsters can be traced directly to him... but, he's by far the biggest and the worst I've ever seen." },
				{ Cue = "/VO/Dora_0497",
					Text = "Mel, {#Emph}I'm {#Prev}the one who's supposed to scare {#Emph}you{#Prev}, not the other way around. So, did you beat this guy, or what?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4421", Text = "{#Emph}Erm... {#Prev}not quite. But I intend to." },
					},
					{
						PreLineWait = 0.3,
						PreLineAnim = "Dora_Shrug",
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0499", Text = "Well let me know if I can help!" },
					},
				},
			},
			DoraAboutTyphon01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutOlympus01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutTyphon01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						Path = { "CurrentRun" },
						HasAny = { "Cleared", "BountyCleared" }
					},
				},
				{ Cue = "/VO/Dora_0496",
					Text = "So, how's it going on Olympus recently? Or wherever you were last night. See anything good up there besides the snow? Not sure how come I know about snow..." },
				{ Cue = "/VO/Melinoe_4419", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I made it all the way to the summit, where I confronted the ancient monster called {#Emph}Typhon. {#Prev}It's said that all other monsters can be traced directly to him... but, he's by far the biggest and the worst I've ever seen." },
				{ Cue = "/VO/Dora_0497",
					Text = "Mel, {#Emph}I'm {#Prev}the one who's supposed to scare {#Emph}you{#Prev}, not the other way around. So, did you beat this guy, or what?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4420", Text = "As a matter of fact, I did!" },
					},
					{
						PreLineWait = 0.3,
						PreLineAnim = "Dora_Shrug",
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0498", Text = "Well then he's not so scary after all." },
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
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "I_Boss01", "Q_Boss01", "Q_Boss02" },
					},
				},
				TeleportToId = 566842,

				{ Cue = "/VO/Dora_0035",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 5.3 },
					Text = "{#Emph}Gah! A scourge upon your bloodline for re-summoning me, witch! {#Prev}Hey, {#Emph}uh, {#Prev}everything OK, there, Mel?" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "F_Boss01", "F_Boss02" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "F_Boss01", "F_Boss02" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutChronosBossW02" }
					},
				},

				TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Melinoe_0416", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Dora, don't you pay any attention to what's been happening out there? The rise of the Titan of Time? The siege of Olympus?" },
				{ Cue = "/VO/Dora_0057",
					Text = "Nope. Can't say any of that rings a bell. Olympus, that's where the family members you {#Emph}don't {#Prev}like live, right? And the Titan of Time, I {#Emph}get {#Prev}that he's bad, but he's never done anything to me personally, as far as I know, so..." },
				{ Cue = "/VO/Melinoe_0417", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
				},

				-- TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0292",
					-- Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Whoa{#Prev}, hold on, what's going on with you? Never seen you so excited in my life. Death. Whatever. What, did you discover a new species of root vegetable or something?" },
				{ Cue = "/VO/Melinoe_3378", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Dora, I found him... Chronos... and I {#Emph}beat {#Prev}him! Withstood every trick he had, until he yielded and expired." },
				{ Cue = "/VO/Dora_0293",
					Text = "Oh, {#Emph}nice! {#Prev}So then it's {#Emph}over{#Prev}, right? Or what...?" },
				{ Cue = "/VO/Melinoe_3379", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
			DoraAboutChronosBossW02 =
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
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutChronosBossW01" }, Min = 3 },
					},
				},

				TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0340",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}You think that you achieved a victory, witch? You merely prolonged your demise. For the Titan whom you vanquished possesses but the smallest fraction of my power!" },
				{ Cue = "/VO/Melinoe_3722", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "So you heard! I'm surprised and humbled that you deigned to pay my meager accomplishments any heed, O Spirit. How did you know?" },
				{ Cue = "/VO/Dora_0341",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 3.7 },
					Text = "{#Emph}I am all-knowing! {#Prev}Also the Shades out there were going off about it. Some of them are right outside the tent, told 'em can't come in, but they're still out there I think..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3723", Text = "Thank you for keeping them at bay." },					},
				},
			},

			-- alt below
			DoraAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutOlympus01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutPrometheus01_B" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutOlympus01" }, Min = 2 },
					},
				},
				{ Cue = "/VO/Dora_0320",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "So hold on, how is it you're going after the Titan of Time way down below, but he's also attacking Olympus way up top? Is he two separate guys or just the one?" },
				{ Cue = "/VO/Melinoe_3705", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Chronos isn't attacking Olympus personally, Dora. He's just sending his legions there. He has a dangerous commander leading the assault... a different Titan called Prometheus." },
				{ Cue = "/VO/Dora_0321",
					PreLineWait = 0.5,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "A different Titan called... Prometheus...? {#Emph}Prometheus... {#Prev}huh..." },
				{ Cue = "/VO/Melinoe_3706", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Yes, the Titan of Foresight. Even you probably know the tale of his punishment for stealing from the gods." },
				{ Cue = "/VO/Dora_0322",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Emote = "PortraitEmoteDepressed",
					Text = "No, it's... I think... {#Emph}ah{#Prev}, don't worry about it. See you later Mel!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3707", Text = "You sure...?" },
					},
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0323", Text = "{#Emph}Prometheus... hrm..." },
					},
				},
			},
			-- post-true ending alt
			DoraAboutPrometheus01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutOlympus01" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutPrometheus01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutOlympus01" }, Min = 2 },
					},
				},
				{ Cue = "/VO/Dora_0320",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "So hold on, how is it you're going after the Titan of Time way down below, but he's also attacking Olympus way up top? Is he two separate guys or just the one?" },
				{ Cue = "/VO/Melinoe_5192", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Well it's not really him I'm going after anymore. But in any case, Chronos appointed someone else to lead the assault on Olympus... a different Titan called Prometheus." },
				{ Cue = "/VO/Dora_0321",
					PreLineWait = 0.5,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "A different Titan called... Prometheus...? {#Emph}Prometheus... {#Prev}huh..." },
				{ Cue = "/VO/Melinoe_3706", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Yes, the Titan of Foresight. Even you probably know the tale of his punishment for stealing from the gods." },
				{ Cue = "/VO/Dora_0322",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Emote = "PortraitEmoteDepressed",
					Text = "No, it's... I think... {#Emph}ah{#Prev}, don't worry about it. See you later Mel!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3707", Text = "You sure...?" },
					},
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0323", Text = "{#Emph}Prometheus... hrm..." },
					},
				},
			},
			DoraAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "DoraAboutPrometheus01", "DoraAboutPrometheus01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs =
				{
					WithinDistance = 800,
					VoiceLines =
					{
						PlayOnceFromTableThisRun = true,
						PreLineWait = 0.15,

						{ Cue = "/VO/Dora_0324", Text = "...Prometheus... Titan of... Foresight...? {#Emph}Tsk... yeah..." },
					},
				},
				TeleportToId = 583650,
				{ Cue = "/VO/Melinoe_3708", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey is everything all right with you, Dora? I didn't mean to upset you with talks of Titans when last we spoke." },
				{ Cue = "/VO/Dora_0325",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Ahh {#Prev}I'm good, Mel. I don't get mad much anymore really, and don't get weirded out either, it's just... something about the name {#Emph}Prometheus? {#Prev}It's like... it meant something to me...?" },
				{ Cue = "/VO/Melinoe_3709", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "But, Prometheus was imprisoned for aeons prior to this point. If you remember him... it's from a while back." },
				{ Cue = "/VO/Dora_0326",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "I'd be ancient history! But, I hardly remember yesterday, don't know how come I'd remember something from that long ago. Not that I {#Emph}do {#Prev}remember anything from then... except..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3710", Text = "...Except what?" },
					},
					{
						PreLineWait = 0.46,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0327", Text = "{#Emph}Ah{#Prev}, just a feeling... but, it isn't great." },
					},
				},
			},
			DoraAboutPrometheus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutDora01" },
					},
				},
				{ Cue = "/VO/Melinoe_3711", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Dora, I hope you don't mind, but I asked Prometheus himself about this old connection that you feel. He's cagey with his words, but does seem to remember you, in turn." },
				{ Cue = "/VO/Dora_0328",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Oh! {#Prev}Kind of weird of you to do that especially since it sounds like he's trying to kill your family up there, but thanks! What'd he say?" },
				{ Cue = "/VO/Melinoe_3712", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Well, he said... he's not to blame for mortalkind's failings and such, and that... neither are you. And asked I tell you so, on his behalf. Before attacking me per usual, of course." },
				{ Cue = "/VO/Dora_0329",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Whew, that's {#Prev}a relief! All this time, I figured if there's any two individuals responsible for all the badness mortals have to deal with, it's {#Emph}Prometheus and me! {#Prev}We're talking stomach aches, heartaches, taxation, lying, cheating... you name it." },
				{ Cue = "/VO/Melinoe_3713", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "It's utter nonsense, but... do you have any idea what he could have meant?" },
				{ Cue = "/VO/Dora_0330",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Nope! But since you're the one who's talking to him on the regular, maybe you could ask. Now that we're curious." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3714", Text = "...We'll figure this out." },
					},
				},
			},
			DoraAboutPrometheus04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutDora02" },
					},
				},
				{ Cue = "/VO/Melinoe_3715", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Prometheus refuses to elaborate about your past with him, Dora. But he believes you're going to remember soon enough. My worry is... you're better off not knowing." },
				{ Cue = "/VO/Dora_0331",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "And, what makes you say that? Besides the part where I've already told you I get a not-great feeling just from sounding out his name? {#Emph}Prometheus... eugh{#Prev}, yeah! There it is!" },
				{ Cue = "/VO/Melinoe_3716", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "He gave me the impression you forgot about him, and much more, by choice. If that's true, perhaps it's for the best. If only for the sake of your past self." },
				{ Cue = "/VO/Dora_0332",
					-- Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Forget my {#Emph}past {#Prev}self, Mel, my {#Emph}current {#Prev}self is pretty caught up now in getting to the bottom of all this! Isn't there some sort of {#Emph}witch-spell {#Prev}you could do to jog my memory, or something?" },
				{ Cue = "/VO/Melinoe_3717", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Well... now that I know of this specific connection you seem to have, it's something to work with. But, are you absolutely sure it's what you want?" },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { WaitTime = 3.3, Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeDoraMemory" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0333", Text = "Oh yeah! It's gonna be something {#Emph}good..." },
					},
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2093", Text = "I'll take your word for it..." },
					}
				},
			},
			DoraAboutMemorySpell01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeDoraMemory" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus04" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraAboutMemories01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutPrometheus04" }, Min = 2 },
					},
				},
				{ Cue = "/VO/Dora_0334",
					Text = "Any luck making some magick that'll jog my memory, or what? No pressure, I can wait, but... thought I'd ask!" },
				{ Cue = "/VO/Melinoe_3718", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Incantations involving memory and the past require great care, so it's not something we are going to rush into. And if you have any second thoughts, you tell me right away." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						PreLineAnim = "Dora_Shrug",
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0335", Text = "Don't worry so much, Mel!" },
					},
				},
			},

			DoraAboutMemories01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				TeleportToId = 566843,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeDoraMemory" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs =
				{
					WithinDistance = 500,
					VoiceLines =
					{
						UsePlayerSource = true,
						PlayOnceFromTableThisRun = true,
						PreLineWait = 0.15,

						{ Cue = "/VO/Melinoe_4830", Text = "Dora..." },
					},
				},

				{ Cue = "/VO/Dora_0577",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "...I remember everything... about why I {#Emph}forgot {#Prev}everything... {#Emph}I {#Prev}did something pretty bad, Mel." },

				{ Cue = "/VO/Melinoe_4654", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Whatever it was, you don't have to tell me, unless of course you wish to in which case I'm listening." },

				{ Cue = "/VO/Dora_0578",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "...Yeah, the thing is I just kind of ruined everything, for everyone. For everyone who's mortal anyway." },

				{ Cue = "/VO/Melinoe_4655", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What are you talking about? That couldn't possibly be true!" },

				{ Cue = "/VO/Dora_0579",
					AngleTowardHero = true,
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Well, imagine there was once this big storage jar, right? Like you'd keep pickles in, except the gods loaded it full of everything that could possibly go wrong. Hate, heartbreak, hair loss, halitosis... you name it." },

				{ Cue = "/VO/Melinoe_4656", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm not following. Why would all mortal vices and failings be placed within this particular jar? It sounds like you may be thinking of some sort of figurative representation." },

				{ Cue = "/VO/Dora_0580",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostLineThreadedFunctionName = "DoraTeleportExit",
					PostLineThreadedFunctionArgs = { HideUntilNextRun = true },
					Text = "No it was a real jar with all that stuff, and I... well, I'm still shaky on the details. Let's chat about it more some other time, I'm beat." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						TriggerCooldowns = { "DoraAnyQuipSpeech", "DoraVanishedVO" },

						{ Cue = "/VO/Melinoe_4657", Text = "Whatever you like..." },
					},
				},
			},
			DoraAboutMemories02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories01" },
					},
				},
				{ Cue = "/VO/Dora_0581",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "...That jar I mentioned, filled with all the {#Emph}bad {#Prev}stuff? {#Emph}I {#Prev}opened it. Wanted to know what was inside! And it went {#Emph}whoosh... {#Prev}I let {#Emph}just {#Prev}about everything out, into the world. Into our lives." },

				{ Cue = "/VO/Melinoe_4658", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? Why would you have done a thing like that? How did you even come across this jar?" },

				{ Cue = "/VO/Dora_0582",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "It was a wedding gift, from the Olympians. Prometheus, whom I remember now, {#Emph}interesting {#Prev}guy, he had a hunky brother and we sort of hit it off..." },

				{ Cue = "/VO/Melinoe_4659", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So the gods wanted you to have a jar full of terrible things. That seems an odd sort of present to give to... who even {#Emph}were {#Prev}you?" },

				{ Cue = "/VO/Dora_0583",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Eh{#Prev}, just some woman! But there weren't too many of us then, and I don't think the gods {#Emph}liked {#Prev}Prometheus much? So anyway the next time any mortal stubs their toe, pays taxes, gets the sweats, anything like that... it's on me." },

				{ Cue = "/VO/Melinoe_4660", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Even if what you say is true, you make it sound as though you'd no intention to do it. So it's not your fault." },

				{ Cue = "/VO/Dora_0584",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostLineThreadedFunctionName = "DoraTeleportExit",
					PostLineThreadedFunctionArgs = { HideUntilNextRun = true },
					Text = "The thing is I {#Emph}did {#Prev}do it, so it {#Emph}is {#Prev}my fault... I'm gonna go." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						TriggerCooldowns = { "DoraAnyQuipSpeech", "DoraVanishedVO" },

						{ Cue = "/VO/Melinoe_4661_B", Text = "Dora...!" },
					},
				},
			},
			DoraAboutMemories03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories02" },
					},
				},
				{ Cue = "/VO/Dora_0585",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "...So, yeah, I guess I cursed all mortalkind a while back. So what if I {#Emph}didn't mean it? {#Prev}Intent doesn't matter." },

				{ Cue = "/VO/Melinoe_4662", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Intent absolutely matters. So then you drank from the River Lethe to rid yourself of the memory of what transpired, to try and rid yourself of the guilt?" },

				{ Cue = "/VO/Dora_0586",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "...Pretty much. But you want to know the one thing I didn't let out of the jar? It was Hope. I was scrambling, and locked it in. The one thing I {#Emph}should {#Prev}have set loose, I didn't." },

				{ Cue = "/VO/Melinoe_4663", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm not so certain. We experience Hope all the time, gods and mortals alike. If you had set it loose... perhaps it would have been smothered by all the other forces, and then what?" },

				{ Cue = "/VO/Dora_0587",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Then mortals wouldn't be quite so delusional maybe? Anyway... I think I want to be alone now for a bit. Thanks for talking through it with me, Mel. And making me remember." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/Melinoe_4664", Text = "Are you going to be all right?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dora_01",
						PostLineThreadedFunctionName = "DoraTeleportExit",
						TriggerCooldowns = { "DoraAnyQuipSpeech", "DoraVanishedVO" },

						{ Cue = "/VO/Dora_0588", Text = "Yeah... probably." },
					},
				},
			},
			DoraAboutMemories04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories03" },
					},
				},
				{ Cue = "/VO/Melinoe_4665", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Dora, I just can't believe the gods set you up to curse all mortalkind... is there any possibility your memory's at fault?" },

				{ Cue = "/VO/Dora_0589",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "...I guess? But I remember pretty clearly now, even if it was a long while ago. Though the other thing is, don't all you gods go through most of this stuff yourselves? I mean, you don't die like mortals, but... you get the other bad things..." },

				{ Cue = "/VO/Melinoe_4666", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, certainly not all of it, but most. So then... perhaps this jar was merely some means of bringing mortals and gods closer together...? To reality, such as we know it." },

				{ Cue = "/VO/Dora_0590",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Sounds kind of like the Hope that I left in the jar talking, Mel. You don't think the gods were just... getting back at Prometheus, his brother, and his gorgeous wife?" },

				{ Cue = "/VO/Melinoe_4667", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps, but... what would they possibly gain from doing such a monstrous thing?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dora_01",
						PostPortraitSetAnim = "Dora_Shrug",
						TriggerCooldowns = { "DoraAnyQuipSpeech", "DoraVanishedVO" },

						{ Cue = "/VO/Dora_0591", Text = "Gods can be jerks sometimes. Like mortals, but stronger." },
					},
				},
			},
			DoraAboutMemories05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraAboutMemories04", "PrometheusAboutDora03" },
					},
				},
				{ Cue = "/VO/Dora_0592",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "You haven't told anyone about me and the {#Emph}jar{#Prev}, have you? I'd rather keep it between us. Glad I remember now, but... wouldn't want the attention from the details getting out..." },

				{ Cue = "/VO/Melinoe_4668", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've spoken only to Prometheus of it, for he had knowledge of the circumstances from before. But I won't tell another soul." },

				{ Cue = "/VO/Dora_0593",
					Text = "Good. Maybe, eventually, I'll go tell everyone myself if I really want to mess with 'em? And even if not, this {#Emph}has {#Prev}given me a {#Emph}ton {#Prev}of new material for my hauntings! It's scary stuff." },

				{ Cue = "/VO/Melinoe_4669", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Please don't make light of it, Dora. But confronting your past is better than erasing it, I think. For that, you're very brave." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						TriggerCooldowns = { "DoraAnyQuipSpeech", "DoraVanishedVO" },

						{ Cue = "/VO/Dora_0594", Text = "{#Emph}And you are very foolish! Leave me be.",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
					},
				},
			},
			DoraAboutMemoryQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories05" },
					},
				},
				{ Cue = "/VO/Dora_0620",
					Text = "Hey, wanted to tell you, thanks for bringing back all of my terrible old memories I tried desperately to erase... I'm serious! I'd rather chew on 'em than spit 'em out." },

				{ Cue = "/VO/Melinoe_4687", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "As far as I'm concerned, that was your choice more so than mine. I wanted to support you as a friend. We both knew what you would discover had potential to be painful." },

				{ Cue = "/VO/Dora_0621",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Eh{#Prev}, I don't know about {#Emph}painful. {#Prev}That's one of the good things about being a Shade! No more pain! Some rotten thoughts about the way things {#Emph}were{#Prev}, sure... maybe some of those." },

				{ Cue = "/VO/Melinoe_4688", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I do count that as pain. It's not the same as being struck full-force by Nemesis, but it can hurt more deeply, and the healing process can take longer, by a lot. Though, do you remember more than just the painful memories, at least?" },

				{ Cue = "/VO/Dora_0622",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 2.0 },

					Text = "I guess so, but the other stuff's just not as interesting, you know? Anyway it's all just history. This is me now." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.40,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4689", Text = "I'm glad." },
					},
				},
			},

			DoraAboutPackagedBounties01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				AllowPostBounty = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					NamedRequirements = { "StandardPackageBountyActive" },
				},

				TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0287",
					Text = "Hey, what happened, you look weird or something, I don't know. Weren't out too long. Took someone to the woods...?" },
				{ Cue = "/VO/Melinoe_3373", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "No, Dora, though I don't think I can sufficiently explain. You know the Pitch-Black Stone? Turns out it can... do things." },
				{ Cue = "/VO/Dora_0288",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "The purple rock can {#Emph}do things{#Prev}, you say. Know what? I don't even {#Emph}want {#Prev}to know the rest, just gonna let my imagination take over for you, thanks." },
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
						Value = 3,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "CrossroadsFamilyPortrait02" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					--[[
					{
						-- this would be impossible; checking that you used the portrait this run and last, but CheckConversations runs on map load
						SumPrevRuns = 2,
						Path = { "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 2,
					},
					]]--
				},

				-- TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0289",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "You've been staring at that picture more and more. {#Emph}Happy family! {#Prev}Well it's starting to get to me, because I think it's starting to get to {#Emph}you. {#Prev}Don't get all misty on me, Mel." },
				{ Cue = "/VO/Melinoe_3376", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 6,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" }
					},
				},
				TeleportToId = 566843,

				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
				{ Cue = "/VO/Dora_0039",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Ahh {#Prev}hey Mel, I was just... floating! Floating around, I guess. And existing! Just kind of existing a lot lately. You?" },
				{ Cue = "/VO/Melinoe_0409", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Failing. Making progress, I don't know. Speaking of, shouldn't you be practicing your haunting, Dora?" },
				{ Cue = "/VO/Dora_0040",
					Portrait = "Portrait_Dora_Thoughtful_01",
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
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAll = { "DoraAboutShades01", "DoraAboutTask01", "MorosSecondAppearance" }
							},
							{
								PathFromSource = true,
								Path = { "DefaultCategoryIndex" },
								Comparison = "==",
								Value = 1,
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "DoraAboutShades01", "DoraAboutTask01" }, Min = 2 },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						}
					},
				},
				TeleportToId = 566841,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs =
				{
					WithinDistance = 400,
					VoiceLines =
					{
						PlayOnceFromTableThisRun = true,
						PreLineWait = 0.15,

						{ Cue = "/VO/Dora_0126", Text = "Hey..." },
					},
				},

				{ Cue = "/VO/Dora_0046",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Not going to lie, Mel, sometimes I wish {#Emph}I {#Prev}had a big important task. Not that floating isn't one." },
				{ Cue = "/VO/Melinoe_0064", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You know my stance on this, Dora. You need to get out of this tent. You're very talented! I've never met a Shade that speaks like you!" },
				{ Cue = "/VO/Dora_0047",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "{#Emph}Ooh{#Prev}, I can talk, makes me {#Emph}so special. Tsch! {#Prev}I'm sure any lowly Shade could do it after being stuck here listening to {#Emph}you people {#Prev}long enough." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4272", Text = "Or you could teach them?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dora_01",
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Dora_0495", Text = "...Nah!" },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraListless01", "DoraAboutExisting01" }, Min = 3 },
					},
				},
				TeleportToId = 566843,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs =
				{
					WithinDistance = 400,
					VoiceLines =
					{
						PlayOnceFromTableThisRun = true,
						PreLineWait = 0.15,

						{ Cue = "/VO/Dora_0532", Text = "Hey Mel." },
					},
				},

				{ Cue = "/VO/Melinoe_0414", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Everything all right, Dora? Any new hauntings need evaluation or anything?" },
				{ Cue = "/VO/Dora_0050",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Dora_Default_01", WaitTime = 5.1 },

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
						HasAll = { "DoraListless02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraListless02" }, Min = 3 },
					},
				},
				TeleportToId = 566842,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs =
				{
					WithinDistance = 400,
					VoiceLines =
					{
						PlayOnceFromTableThisRun = true,
						PreLineWait = 0.15,

						-- { Cue = "/VO/Dora_0126", Text = "Hey..." },
					},
				},

				{ Cue = "/VO/Dora_0048",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Hey, if I were you I'd... well, come to think of it, I'd... I'd do a lot of things. Go for a jog! That seems nice. Having legs! Getting the heart rate going, a heart seems nice!" },
				{ Cue = "/VO/Melinoe_0066", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Stop it, Dora. I don't like it when you get like this." },
				{ Cue = "/VO/Dora_0049",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutHaunting04" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Dora_0037",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Ever think maybe we're just not cut out for this, Mel? Me with the haunting, you with the... what're you trying to do, again?" },
				{ Cue = "/VO/Melinoe_0408", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 7.9 },
					Text = "{#Emph}Find the Titan of Time. Punish him for his crimes against my family. Restore the rightful ruler of the Underworld.... {#Prev}Hey, you're cut out for haunting, Dora!" },
				{ Cue = "/VO/Dora_0038",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Aw{#Prev}, thanks! Just like I'm sure you're cut out for all that other stuff." },
			},
			DoraAboutTask02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "DoraAboutChronos01", "DoraAboutChronosBossW01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				TeleportToId = 583650,

				{ Cue = "/VO/Dora_0312",
					Text = "So what do you even do when you're out, collect more plants and stuff like that? You used to stay in all the time." },
				{ Cue = "/VO/Melinoe_3699", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Dora, I was training in secrecy all that time! While I'm out each night, mostly I have to fight my way to Chronos... past a variety of things that don't like having me around." },
				{ Cue = "/VO/Dora_0313",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Can't imagine why. And you just keep trying to do the same thing, huh. I would've given up so long ago! You should try it. Giving up." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						RequiredMinElapsedTime = 3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3700", Text = "No thank you." },
					},
				},
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
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				TeleportToId = 566841,

				{ Cue = "/VO/Melinoe_0411", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "What would you do if you had the tent all to yourself anyway, Dora? You could invite all the other Shades and absolutely trash the place, I suppose..." },
				{ Cue = "/VO/Dora_0042",
					Emote = "PortraitEmoteSurprise",
					Text = "Wh, what, you mean {#Emph}share {#Prev}it? Mel, {#Emph}not sharing {#Prev}the tent is the entire point, a proper haunting has a one-to-one ratio between the haun{#Emph}ted {#Prev}and the haun{#Emph}tee{#Prev}. Even {#Emph}I {#Prev}haven't forgotten the basics." },
				{ Cue = "/VO/Melinoe_0412", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutHaunting04", "DoraAboutHaunting05" }, Min = 3 },
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
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						{ Cue = "/VO/Melinoe_2020", Text = "Oh, come on!" },
					},
				},
			},

			DoraAboutHaunting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "H_Boss01", "H_Boss02" },
					},
				},

				{ Cue = "/VO/Dora_0314",
					Text = "What would you say is the most frightening thing you've encountered out there lately, Mel? It's important for someone in my position to keep up with the latest on this front." },
				{ Cue = "/VO/Melinoe_3701", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Well... I'd have to go with the raging infernal beast guarding the only viable way into Tartarus. Absolutely massive, countless sharp fangs, three fire-spitting maws... though he's also my family's dog." },
				{ Cue = "/VO/Dora_0315",
					Emote = "PortraitEmoteSurprise",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Ahh{#Prev}, you had me going! Well if you're telling me there's nothing scarier out there than a pet dog... it means I've got no competition! Time to rest on these laurels some more." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3702", Text = "Please make yourself comfortable." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0316", Text = "{#Emph}All that you see is my domain.",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
					},
				},
			},

			DoraAboutHaunting04 =
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
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutHaunting02", "DoraAboutHaunting05" }, Min = 3 },
					},
				},

				{ Cue = "/VO/Dora_0336",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}You, who ventured into my abode, shall suffer an eternity of torment for what you have done! Unless, of course, you are prepared to grant my dying wish..." },
				{ Cue = "/VO/Melinoe_3719", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "Forgive my insolence, Spirit, and name your price! I am prepared to do your bidding! Within reason, anyway." },
				{ Cue = "/VO/Dora_0337",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Thoughtful_01", WaitTime = 5.3 },
					Text = "{#Emph}Then swear to me that you shall do my bidding, now! Specifically... {#Prev}I haven't worked out the dying-wish part yet. Ask you to fetch my lover's bones, something like that?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3720", Text = "Just keep me posted." },
					},
				},
			},

			DoraAboutHaunting05 =
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift03", },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutHaunting02", "DoraAboutHaunting04" }, Min = 3 },
					},
				},

				{ Cue = "/VO/Dora_0338",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Stand forth, witch! Beyond these thrice-cursed grounds lies only death. Are you prepared to relinquish your own life's blood for that which you seek? Or shall you turn back?" },
				{ Cue = "/VO/Melinoe_3721", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 5.2 },

					Text = "If I turn back, it's basically a dead end, Spirit. Sounds like I face a dead end either way! I have to check with some of the others, so..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0339", Text = "{#Emph}Ah! {#Prev}Go for it, then.",
							PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
					},
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
						Value = 1,
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},

				{ Cue = "/VO/Dora_0164",
					Emote = "PortraitEmoteSurprise",
					Text = "Whoa, what gives there, Mel? Y-you look like you've seen a... {#Emph}ungh{#Prev}, I don't know, but... whatever it was it got under your skin. {#Emph}<Gasp> Oh! {#Prev}Skin seems nice!" },
				{ Cue = "/VO/Melinoe_2015", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "NightmareOccurred" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},

				{ Cue = "/VO/Dora_0166",
					Text = "Wonder if I ever used to have nightmares... so, so you can just... {#Emph}imagine {#Prev}yourself in these {#Emph}completely {#Prev}different {#Emph}horrible {#Prev}situations?" },
				{ Cue = "/VO/Melinoe_2017", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Yes. And sometimes I'm not even there, which can make them even more unsettling. Though they don't trouble me as much anymore..." },
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "NPC_Dora_01",
					{ Cue = "/VO/Dora_0167", Text = "Well... at least you've got {#Emph}me." },
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
						PathTrue = { "GameState", "TextLinesRecord", "NemesisGift02" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI", "NemesisRandomEvent", "BridgeNemesisRandomEvent" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisWithHecate02" }
					},
				},

				-- TeleportToId = 561033,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,

				{ Cue = "/VO/Dora_0053",
					Text = "Hey if you showed up just a bit sooner, you could have heard Nemesis complaining up a storm again!" },
				{ Cue = "/VO/Melinoe_1602", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisAboutMoros02", "NemesisWithMoros01", "MorosFirstMeeting" },
					},
					{
						SumPrevRuns = 3,
						Path = { "TextLinesRecord", "MorosFirstMeeting" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Dora_0176",
					Text = "So, what's the deal with the horned guy, anyway? Saw him and Nemesis chatting like they were an item, or something. It was weird." },
				{ Cue = "/VO/Melinoe_1826", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMoros01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 6,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraAboutMoros01" }, Min = 2 },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 560612 }, },
					},
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

			DoraAboutSkelly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGrantsCosmeticsShop01", "DoraWithSkelly01" }
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun"},
					},
				},
				{ Cue = "/VO/Dora_0198",
					Text = "Hey Mel! The good {#Emph}Commander {#Prev}there has offered to train me as one of his {#Emph}disciples. {#Prev}It's a big decision, so I'm kind of mulling it over..." },
				{ Cue = "/VO/Melinoe_2025", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I've learned so much from him, Dora. Headmistress taught me my craft. But Commander Schelemeus taught me... {#Emph}erm..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0199", Text = "How to beat up an old man...?" },
					},
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2026", Text = "No!" },
					},
				},
			},

			DoraAboutStatues01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGrantsCosmeticsShop01", "DoraWithSkelly01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraAboutSkelly01", "TrophyQuestComplete03", "DoraGift06" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				{ Cue = "/VO/Dora_0618",
					Text = "Hey meant to ask you, {#Emph}what {#Prev}is with those statues in the training grounds? Are those supposed to be you, {#Emph}because... {#Prev}well... they're a lot {#Emph}bigger {#Prev}than you..." },
				{ Cue = "/VO/Melinoe_4685", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "...Statues sometimes portray their subjects in an unnaturally flattering or dramatic light! But in any case, I earned the title of Night's Champion, and... those were my reward." },
				{ Cue = "/VO/Dora_0619",
					PreLineWait = 0.35,
					Text = "...I'll never look at you the same way again! I {#Emph}really {#Prev}like the one with the huge axe." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4686", Text = "Oh {#Emph}do {#Prev}you?" },
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
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2", "HeraclesCombatF", "HeraclesCombatF2", "HeraclesCombatG", "HeraclesCombatG2" },
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

			DoraAboutIcarusRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01", },
						IsAny = { "Choice_IcarusAccept" },
					},
				},
				{ Cue = "/VO/Dora_0615",
					Text = "Hey, {#Emph}uh{#Prev}, you and that guy, one with the wings, what was his name? Thought he was long {#Emph}dead{#Prev}, though when {#Emph}I {#Prev}saw him here with you, he seemed, shall we say, very much alive? How'd he do that?" },

				{ Cue = "/VO/Melinoe_4683", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "You mean Icarus, and did you... were you eavesdropping on what very clearly was a private moment between longtime acquaintances? I thought you were elsewhere!" },

				{ Cue = "/VO/Dora_0616",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Oh, no, I was just over {#Emph}there. {#Prev}Didn't want to interrupt. So did you bring him back using a necromantic ritual, or what?" },

				{ Cue = "/VO/Melinoe_4684", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's entirely my private business, thanks!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						{ Cue = "/VO/Dora_0617", Text = "Trust me you have {#Emph}nothing {#Prev}to be ashamed of." },
					},
				},
			},

			DoraPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				TeleportToId = 566843,

				{ Cue = "/VO/Dora_0606",
					Text = "Hey so what exactly {#Emph}happened {#Prev}around here? Did you complete your big important task? Because that's what I'm hearing from the other Shades." },

				{ Cue = "/VO/Melinoe_4873", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, for the most part, yes! My family is back! My mother and father are restored to the Underworld throne, and my brother's back too! But we have many details to sort out, and... the Titan Chronos is going to be assisting us with that." },

				{ Cue = "/VO/Dora_0607",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Dora_Default_01", WaitTime = 4.25 },
					Text = "The Titan you said you were going to slay this whole time... {#Emph}assisting us. {#Prev}Hate to say it, Mel, but sounds to me like you totally blew it. At least the Titan part." },

				{ Cue = "/VO/Melinoe_4874", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He's no longer himself, or rather... no longer the way he used to be. And we'll be closely watching him." },

				{ Cue = "/VO/Dora_0608",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Sure. So then... congratulations are in order, basically?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4875", Text = "Well if you like..." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0609", Text = "I do. Congratulations, Mel." },
					},
				},
			},
			DoraPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Dora_0623",
					Text = "Got a new picture there I see. That from your mom and dad? Looks newer than the other one. You're all grown up!" },

				{ Cue = "/VO/Melinoe_4876", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It was a bit of a parting gift, considering I won't be staying at the House of Hades with the rest of them. Though I'll be seeing them around, I think." },

				{ Cue = "/VO/Dora_0624",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Oof, harsh! {#Prev}How come they didn't want you living in their subterranean stronghold with {#Emph}them? {#Prev}You're their {#Emph}kid!" },

				{ Cue = "/VO/Melinoe_4877", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They did want me to stay, it's just... my home is here. They're my family, but so is this." },

				{ Cue = "/VO/Dora_0625",
					Emote = "PortraitEmoteSurprise",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "What have you lost your mind? Wait, I'm your family too, {#Emph}that's {#Prev}what you're saying?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4878", Text = "Sure, if you're up for it." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0626", Text = "{#Emph}Oh {#Prev}all right, I guess why not?" },
					},
				},
			},
			DoraPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Melinoe_4879", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey Dora, what if hypothetically there were to be the dawning of another age at some point, and the gods then truly did leave mortals more or less alone? More than before." },

				{ Cue = "/VO/Dora_0627",
					Text = "What are you making me some kind of {#Emph}offer {#Prev}here? I know you're a big deal lately but not even {#Emph}you {#Prev}have the power to pull something like {#Emph}that {#Prev}off, Mel. Why would the gods give up their gig?" },

				{ Cue = "/VO/Melinoe_4880", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Even the gods are subject to the will of the Three Fates. None of us can entirely control what shall come to pass, and there are prophecies that cannot change no matter what." },

				{ Cue = "/VO/Dora_0628",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "You really believe that stuff, even after everything you did? I mean, was there {#Emph}really {#Prev}some kind of prophecy about Chronos, and how you'd end up beating him eventually, once you realized your true potential thanks to me?" },

				{ Cue = "/VO/Melinoe_4881", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, no, because the Fates went missing throughout most of this ordeal, but... they don't tend to be mistaken." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0629", Text = "Right. I'll believe it when it happens." },
					},
				},
			},

			-- Partner Conversations
			DoraWithMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMoros02" },
					},
					NamedRequirementsFalse = { "DoraMemoryQuestActive" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
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
					PostLineThreadedFunctionName = "DoraTeleportExit",
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
				UseableOffSource = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraWithMoros01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraWithMoros01" }, Min = 3 },
					},
					NamedRequirementsFalse = { "DoraMemoryQuestActive" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
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
						PostLineFunctionName = "DoraTeleportExit",
						{ Cue = "/VO/Dora_0184", Text = "{#Emph}Ah{#Prev}, come on..." },
					},
				},
			},

			DoraWithMoros03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				Partner = "NPC_Moros_01",
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					Force = true,
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraWithMoros02", "DoraGift08", "MorosGift08" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraWithMoros02" }, Min = 3 },
					},
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				TeleportToId = 566622,
				TeleportOffsetX = 180,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 560612,
				InteractDistance = 450,
				{ Cue = "/VO/Dora_0655",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Now kneel before me, O Horned King, and know your place! Lest I reduce you and that flowing mane of yours to dust and scatter it to the four winds!" },

				{ Cue = "/VO/Moros_0697",
					Portrait = "Portrait_Moros_Pleased_01", Speaker = "NPC_Moros_01",
					PreLineWait = 0.4,
					PreLineAnim = "Moros_Perplexed_Start",
					PreLineAnimTarget = 560612,
					PostLineAnim = "Moros_Perplexed_End",
					PostLineAnimTarget = 560612,
					Text = "...Yes, that was truly excellent, Dora. Although, {#Emph}Horned King? {#Prev}That made it sound as though I was important in some way, when I think you were going for sheer dominance." },

				{ Cue = "/VO/Dora_0656",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Yeah{#Prev}, that's a good note. Just kind of popped into my head, you know? The antlers... they {#Emph}are {#Prev}striking! They real?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0698", Text = "Don't you touch them." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0657", Text = "I'm gonna." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0699", Text = "I said don't." },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Dora_01",
						{ Cue = "/VO/Dora_0658", Text = "I'm gonna!" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0700", Text = "Please?" },
					},
				},
			},


			DoraWithSkelly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				Partner = "NPC_Skelly_01",
				PreBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutCompanions01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "DoraGrantsCosmeticsShop01" }, Min = 6 },
					},
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				TeleportToId = 589864,
				-- TeleportOffsetX = 180,
				-- TeleportOffsetY = 100,
				AngleTowardTargetId = 420928,
				InteractDistance = 450,
				{ Cue = "/VO/Dora_0200",
					PostPortraitSetAnim = "Dora_Shrug",
					PreLineWait = 0.35,
					Text = "...So you basically just stand here, saying stuff, whatever pops in your head, and those {#Emph}other {#Prev}Shades, and Mel... they eat it up?" },
				{ Cue = "/VO/Skelly_0171", 
					Speaker = "NPC_Skelly_01",
					Portrait = "Portrait_Skelly_Default_01",
					PreLineAnim = "Skelly_Explaining",
					PreLineAnimTarget = 420928,
					PostLineAnimTarget = 420928,
					Text = "They {#Emph}do {#Prev}eat it up, Disciple, for it is nourishment borne of the wisdom of a vast experience, well-informing that which pops into my head! Now could you please give me a break...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Dora_01",
						PostLineFunctionName = "DoraTeleportExit",
						{ Cue = "/VO/Dora_0201", Text = "OK. I hear you. {#Emph}Commander." },
					},
					{
						PreLineWait = 0.78,
						ObjectType = "NPC_Skelly_01",
						{ Cue = "/VO/Skelly_0173", Text = "Where were we?" },
					},
				},
			},

			-- Repeatable
			DoraChat01 =
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
				{ Cue = "/VO/Dora_0006",
					Text = "I'll keep an eye on all your stuff while you're away." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat02 =
			{

				-- TeleportToId = 422254,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,

				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0007",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Good to chat, but I better get back to haunting." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat03 =
			{

				-- TeleportToId = 741488,
				-- TeleportOffsetX = 30,
				-- TeleportOffsetY = 80,
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
				{ Cue = "/VO/Dora_0008",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Got a lot of weird stuff in here, you know that?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat04 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0009",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Just haunting up the place. Don't worry about me..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat05 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0010",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.5 },
					Text = "Hey, Mel. I mean, {#Emph}Ravens shall feast on your eyes!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat06 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0011",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.0 },
					Text = "Hey, Mel. I mean, {#Emph}In seeking me you seek only your doom!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat07 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0012",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Disturb me thus and I shall torment you for three eternities!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat08 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0013",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}May your days be filled with dread, your nights with fear!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat09 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0014",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}A thousand curses on you for invoking me!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat10 =
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
				{ Cue = "/VO/Dora_0015",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Do not presume to tarry o'erlong within my tent, witch!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat11 =
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
				{ Cue = "/VO/Dora_0017",
					Text = "Do what you got to do. I'm not even here." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat12 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0018",
					Text = "Juuust floatin' around, don't mind me." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
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
				StatusAnimation = false,
			},
			DoraChat14 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0020",
					Text = "Let me know if there's somebody I can torment for you, OK?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat15 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0021",
					Text = "Hope your big task thing's been going all right!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat16 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0022",
					Text = "I'll try not to muck everything up while you're out." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat17 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0023",
					Text = "{#Emph}Uhh{#Prev}, can I get a little privacy, here, Mel?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat18 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0024",
					Text = "Sooner you get out of here, sooner I can go through all your stuff." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat19 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0025",
					Text = "{#Emph}You {#Prev}exist, {#Emph}I {#Prev}exist... could be worse, right?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat20 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0026",
					Text = "Have a good whatever time it is doing whatever it is you do!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},

			DoraChat21 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift01", },
					},
				},
				{ Cue = "/VO/Dora_0027",
					Text = "Go knock 'em dead for me, or back to life! Whatever's worse." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat22 =
			{
				SkipContextArt = true,
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
				{ Cue = "/VO/Dora_0028",
					Text = "I'm going to haunt this tent {#Emph}so bad {#Prev}once you get out of here..." },
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
				{ Cue = "/VO/Dora_0029",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Just go with the flow out there! It's what I do!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat24 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse02" },
					},
				},
				{ Cue = "/VO/Dora_0030",
					Emote = "PortraitEmoteSparkly",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "{#Emph}Damn{#Prev}, Mel! {#Emph}Wow. {#Prev}If only looks could kill, am I right?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat25 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0031",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Hope nothing horrible happens to you out there!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat26 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0032",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Mel, you've inspired me... to float right here, for the time being." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat27 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0033",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.0 },
					Text = "Hey, Mel! I mean, {#Emph}You hold no sway over me, witch!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat28 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0034",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Your incessant reappearances have come to be acceptable, witch!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat29 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ScreenViewRecord", "CosmeticsShop" }
					},
					NamedRequirements = { "CosmeticsShopUnlocked" },
				},
				{ Cue = "/VO/Dora_0630",
					Text = "Think maybe there's anything we ought to change around in terms of furnishings and all that?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat30 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0631",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Sometimes I just want to, like, {#Emph}possess {#Prev}someone, you know? Only for a little bit." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat31 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0632",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Don't mind me! Just doing my thing over here, Mel." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat32 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},

				{ Cue = "/VO/Dora_0633",
					PostPortraitSetAnim = "Dora_Shrug",
					Portrait = "Portrait_Dora_Thoughtful_01",
					Text = "Those Shades out there been saying you did good again tonight I guess?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat33 =
			{
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0634",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Want anyone around here tormented for a little while, just give me the signal." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat34 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0635",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}You deign to look upon me, witch? I shall haunt your every waking moment!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat35 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0636",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}Those who gaze into my eyes are forever doomed to suffer as I did!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat36 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0637",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					Text = "{#Emph}An eternity of suffering and insect-bites await all those who dare to cross my path." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat37 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0638",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.0 },
					Text = "Been keeping an eye on things while you're away, and {#Emph}terrifying anyone who dares approach!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat38 =
			{
				PlayFirst = true,
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
				{ Cue = "/VO/Dora_0639",
					Text = "I'll be keeping an eye on the tent for you while you're out all night, Mel." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat40 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
				},
				{ Cue = "/VO/Dora_0640",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Need anything from me, I'll be right here. Or one of the other places you go." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat41 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0641",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 2.9 },
					Text = "One of the other Shades said hi to me earlier, {#Emph}for the first and final time!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
				StatusAnimation = false,
			},
			DoraChat42 =
			{
				PlayFirst = true,
				SkipContextArt = true,
				UseableOffSource = true,
				{ Cue = "/VO/Dora_0642",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Everything's been good enough here lately, long as you can say the same." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Dora",
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
					Portrait = "Portrait_Mel_Proud_01",
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
				},
				{ Cue = "/VO/Dora_0103",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Oh, you don't need to get this kind of stuff for me! I can just take whatever stuff of yours I want when you're out!" },
				{ Cue = "/VO/Melinoe_0443", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
				},
				{ Cue = "/VO/Dora_0104",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 4.8 },
					Text = "{#Emph}Fool! I am not susceptible to mere baubles such as this! Ah{#Prev}, just kidding. {#Emph}Totally {#Prev}susceptible. Gimme!" },
				{ Cue = "/VO/Melinoe_0444", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
				},
				{ Cue = "/VO/Dora_0105",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Starting to get the feeling maybe I liked this stuff back when I had eyeballs and so on." },
				{ Cue = "/VO/Melinoe_0445", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift04", "DoraFishing01" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
						HintId = "Codex_DoraNotInTent",
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse02" },
					},
				},
				{ Cue = "/VO/Dora_0107",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Default_01", WaitTime = 5.3 },			
					Text = "{#Emph}Such pitiable offerings as this are hardly worth my notice, witch! {#Prev}No, but, seriously, thanks. Nobody ever gets me anything! Besides you, I mean. It's nice, you know?" },
				{ Cue = "/VO/Melinoe_0447", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's nice for me as well! Having you here as company means a lot, so it really is the least I could do." },
			},

			DoraGift07 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				-- LockedHintId = "Codex_DoraUnlockHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraTaverna01" },
					},
				},
				{ Cue = "/VO/Dora_0595",
					Emote = "PortraitEmoteFiredUp",
					Text = "Hey, {#Emph}cool it {#Prev}with the Nectar, would you, Mel? Ever since we tried Ambrosia, I've been cultivating a {#Emph}much {#Prev}more sophisticated palate, for a Shade. No more cheap stuff." },
				{ Cue = "/VO/Melinoe_4670", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Dora, the Nectar of the gods can hardly be considered {#Emph}cheap! {#Prev}Most mortals go through the entirety of their existence without so much as a {#Emph}taste! {#Prev}And you don't like it?" },
				{ Cue = "/VO/Dora_0596",
					Portrait = "Portrait_Dora_Thoughtful_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", Portrait = "Portrait_Dora_Spooky_01", WaitTime = 6.9 },
					Text = "You know, I {#Emph}do{#Prev}, but it's a little on the sweet side for me? Though, I appreciate you treating me like royalty... {#Emph}like a spirit of unfathomable power...!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.2,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>" },
					},
				},
			},

			DoraGift08 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_DoraUnlockHint01",
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
						HasAll = { "DoraGift07" },
					},
					{
						PathFromSource = true,
						Path = { "DefaultCategoryIndex" },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_4671", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've met many great and noble Shades, Dora, though I can confidently say that none of them are anything like {#Emph}you. {#Prev}This Ambrosia is yours; shall we open it at the taverna?" },

				{ Cue = "/VO/Dora_0597",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", Portrait = "Portrait_Dora_Thoughtful_01", WaitTime = 3.5 },
					Text = "{#Emph}I shall accept your offering this time, witch. {#Prev}But I'd rather hang onto it for now. Unless you want to have it with me here? I just don't want to go anywhere is all." },

				{ Cue = "/VO/Melinoe_4672", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh! {#Prev}Of course. Here, the aroma alone should do most of the work. To your continued hauntings!" },

				{ Cue = "/VO/Dora_0598",
					Text = "Thanks. This stuff is definitely pretty good. How come you have {#Emph}both {#Prev}Nectar and Ambrosia, anyway? It's weird. Two different godly beverages, only one's an even bigger deal." },

				{ Cue = "/VO/Melinoe_4673", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They're suitable for different occasions. It would never do to offer Ambrosia to a newer acquaintance, for example. It's reserved mainly for feasting between close friends or lovers." },
						
				{ Cue = "/VO/Dora_0599",
					PostPortraitSetAnim = "Dora_Shrug",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Dora_Thoughtful_01", WaitTime = 2.3 },
					Text = "Well that sounds just like {#Emph}us! {#Prev}But, I think I might be over this stuff too..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4674", Text = "Oh..." },
					},
				},
			},

			DoraBathHouseDecline01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_3814", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Would you be interested in visiting the springs with me, Dora? A warm soak can be good for the soul." },
				{ Cue = "/VO/Dora_0351",
					PreLineWait = 0.35,
					SkipContextArt = true,
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "Nah. Kind of busy doing nothing whatsoever at the moment, though I might be up for a soak some other time." },
			},
			DoraFishingDecline01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				SkipGiftPresentationPost = true,
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_3815", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "What would you say to a brief trip to the fishing pier with me? It's nice and quiet over there!" },
				{ Cue = "/VO/Dora_0352",
					PreLineWait = 0.35,
					SkipContextArt = true,
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "{#Emph}Eh{#Prev}, don't really want to move right now. And those fish would probably scare {#Emph}way {#Prev}too easily for a haunter of my skill." },
			},
			DoraTavernaDecline01 =
			{
				PlayOnce = true,
				SkipContextArt = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraTaverna01" },
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_3816", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Want to join me at the Taverna for a bottle of Ambrosia? I enjoyed our previous outing." },
				{ Cue = "/VO/Dora_0353",
					PreLineWait = 0.35,
					SkipContextArt = true,
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineThreadedFunctionName = "SuperGiftPointRefundPresentation",
					Text = "I enjoyed it too but it was kind of a {#Emph}lot{#Prev}, being in that crowd... still a little drained from last time, I think." },
			},

			DoraFishing01 =
			{
				PauseMusicPlayerMusic = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift03" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_0440", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "Hey, if you're not busy, up for a little visit with me to the riverside? I've got a twin lure we could use right here." },

				{ Cue = "/VO/Dora_0081",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					Text = "Don't know that I'll be doing you much good, between my inability to use a rod of fishing and my inability to keep quiet, but hey! You asked for it." },

				{ Cue = "/VO/Dora_0300",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					Text = "The River of Lamentation. Nothing but a bunch of sad stuff floating around in there. Sure you wouldn't rather leave it be?" },

				{ Cue = "/VO/Melinoe_3690", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Whatever's wallowing in there is going to stay put, unless it's finally decided it's had enough. For any such souls, we'll be doing them a favor, I think." },

				{ Cue = "/VO/Dora_0301",
					SkipContextArt = true,
					Text = "Not like we owe them, and not like they'll do us any favors back. And if all they can do now is feel sad for themselves at the bottom of a mucky river, fishing them out might not do them any good anyway." },

				{ Cue = "/VO/Melinoe_3691", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "We're not fishing them out, really. It's more like we're giving them an opportunity to escape their circumstances. It's a bit different from the mortal way of fishing in that sense." },

				{ Cue = "/VO/Dora_0302",
					SkipContextArt = true,
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Then if they don't like it any better up here, that's on them...",
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 },
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 16, IncludeFishingSFX = true }, },

				{ Cue = "/VO/Dora_0099",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "Well, that definitely was a thing that happened. Thanks!" },

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
				PauseMusicPlayerMusic = true,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0419", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
				PauseMusicPlayerMusic = true,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				{ Cue = "/VO/Melinoe_0420", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
				EndWait = 0.5,
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
					},
				},
			},

			-- bond forged
			DoraBathHouse03 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				LockedHintId = "Codex_DoraUnlockHint02",
				CompletedHintId = "Codex_BondForgedDora",
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DoraGift08", "DoraAboutMemoryQuest01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				{ Cue = "/VO/Melinoe_4675", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Forget about the Nectar and Ambrosia, what if we go to the springs again? It's quiet there. Seems more your style... and for that matter, mine." },

				{ Cue = "/VO/Dora_0600",
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostPortraitSetAnim = "Dora_Shrug",
					PostLineRemoveContextArt = true,
					Text = "I was planning to say no to whatever you had in mind just to mess with you, but the springs {#Emph}do {#Prev}sound OK. So let's go." },

				{ Cue = "/VO/Melinoe_4676", UsePlayerSource = true,
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "Aren't you angry with the gods...? For what they did to you, and all of mortalkind, apparently. So what if it was a long time ago! The more I think about it, the angrier I get..." },

				{ Cue = "/VO/Dora_0602",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "I mean, {#Emph}honestly{#Prev}, it was a pretty good prank! But, it was nasty, too. I don't know which one of you all was responsible, but don't really care. Not big on the whole anger thing." },

				{ Cue = "/VO/Melinoe_4677", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "You're too kind... more than {#Emph}my {#Prev}family at least. I don't think there's any taking back what happened, but... for what it's worth, once all this is over, I'm going to do all I can to make it so we gods act more decently with mortals from now on." },

				{ Cue = "/VO/Dora_0603",
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					Text = "Speaking on behalf of all mortals who ever lived or ever will, I think we'd mostly like it if you left us alone. Might be a lot of evils in this world, but... we have ways of figuring things out." },

				{ Cue = "/VO/Melinoe_4678", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "...Can you and I remain as friends, at least?" },

				{ Cue = "/VO/Dora_0604",
					PreLineWait = 0.35,
					Portrait = "Portrait_Dora_Bath_01",
					PortraitExitAnimation = "Portrait_Dora_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Well let me think about it for a little while and get back to you, all right?" },

				{ Cue = "/VO/Dora_0605",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Dora_01", Icon = "Keepsake_Dora", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostBathHouseArgs },

					Emote = "PortraitEmoteSparkly",
					Text = "...Done a lot of thinking, and we're good to go on that remain-as-friends thing, Mel. Though I'll keep you posted if anything comes up!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4680", Text = "Sounds good, Dora." },
					},
				},
			},

			-- taverna
			DoraTaverna01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				SkipContextArt = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGift06" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
						HintId = "Codex_DoraNotInMain",
					},
				},
				{ Cue = "/VO/Melinoe_3726", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey, now that the taverna's back, how about I treat you to a bit of the Ambrosia of the gods? You have my word it's good!" },

				{ Cue = "/VO/Dora_0345",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Dora_Default_01_Exit",
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Well, I guess I'm not in the middle of anything, and since you {#Emph}did {#Prev}give me your word... know what, I'm in." },

				{ Cue = "/VO/Dora_0346",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					Text = "...Considered a delicacy, that figures. Kind of a weird consistency, are you supposed to {#Emph}drink {#Prev}this stuff or {#Emph}eat {#Prev}it?" },

				{ Cue = "/VO/Melinoe_3727", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're mainly just supposed to savor it with friends. I agree it's a bit unusual, but then, it's intended for extraordinary circumstances." },

				{ Cue = "/VO/Dora_0347",
					SkipContextArt = true,
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "Yeah? What makes this so extraordinary? We're just... lounging around. Not in the tent, which granted isn't normal in my case, but... still." },

				{ Cue = "/VO/Melinoe_3728", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's ours to decide what's special, don't you think? Yes, we see each other night in and night out. But we have never shared a fancy bottle like this, just the two of us." },

				{ Cue = "/VO/Dora_0348",
					SkipContextArt = true,
					Text = "I guess I see your point, but... bit of a paradox or something, right? Ambrosia's meant for extraordinary events, but it's the Ambrosia itself making things... unnaturally festive." },

				{ Cue = "/VO/Melinoe_3729", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Supernaturally{#Prev}, even. My skin, it's beginning to crawl, as though... something is here with us! Oh, gods..." },

				{ Cue = "/VO/Dora_0349",
					SkipContextArt = true,
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Dora_Spooky_01",
					PostPortraitSetAnim = "DoraScary_Frighten",
					PortraitExitAnimation = "Portrait_Dora_Spooky_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "{#Emph}The gods themselves shall quake with fear, the likes of which your frail consciousness shall never comprehend!" },

				{ Cue = "/VO/Dora_0350",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,
					PostPortraitSetAnim = "Dora_Shrug",
					Text = "...All right so then Ambrosia's not that bad. I got to go unwind, but... that was fun." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3731", Text = "Do it, Dora." },
					},
				},

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
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Dora_01" }, Alive = false },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
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
			GameStateRequirements =
			{
				ChanceToPlay = 0.33,
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

GlobalVoiceLines.DoraSummonedVoiceLines =
{
	SkipAnim = true,
	GameStateRequirements =
	{
		{
			PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
		},
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "TrueEndingFinale01" }
		},
	},
	Cooldowns =
	{
		{ Name = "DoraAnyQuipSpeech", Time = 5 },
		{ Name = "DoraGreetedRecently", Time = 240 },
		{ Name = "AnyGreetingSpeech", Time = 4 },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsAny = { "DoraFirstMeeting", }, },
			},
		},
		{ Cue = "/VO/Dora_0129", Text = "{#Emph}Boo!!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsAny = {
					"DoraAboutMemories01",
					"DoraAboutMemories02",
					"DoraAboutMemories03",
					"DoraAboutMemories04"
				}, },
			},
		},
		{ Cue = "/VO/Dora_0146", Text = "{#Emph}Umm...", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0126", Text = "Hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0147", Text = "Hey, so...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0532", Text = "Hey Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsAny = { "DoraRunProgress01", "DoraAboutHaunting02", "DoraAboutHaunting04", "DoraAboutChronosBossW02" }, },
			},
		},

		{ Cue = "/VO/Dora_0133", Text = "{#Emph}Who dares?", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
		{ Cue = "/VO/Dora_0228", Text = "{#Emph}Kneel before me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
		{ Cue = "/VO/Dora_0144", Text = "{#Emph}Approach, witch!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
		{ Cue = "/VO/Dora_0226", Text = "{#Emph}You have returned.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsAny = { "DoraListless01", "DoraListless02", "DoraListless03","DoraAboutExisting01", "DoraAboutChronosBossW01" }, },
			},
		},

		{ Cue = "/VO/Dora_0125", Text = "Hey.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0126", Text = "Hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0224", Text = "Oh hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0220", Text = "How's it going?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsAny = { "DoraAboutShades04", "DoraAboutShades04_B" }, },
			},
		},
		{ Cue = "/VO/Dora_0224", Text = "Oh hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		SuccessiveChanceToPlay = 0.15,
		PlayOnceFromTableThisRun = true,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				PathFromArgs = true,
				Path = { "OriginalSource", "DefaultCategoryIndex" },
				Comparison = "~=",
				Value = 1,
			},
		},
		{ Cue = "/VO/Dora_0533", Text = "I hate it out here!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "==",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Dora_0535", Text = "Look at all this stuff...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
		{ Cue = "/VO/Dora_0537", Text = "What am I doing here...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
		{ Cue = "/VO/Dora_0539", Text = "I miss the tent.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
		{ Cue = "/VO/Dora_0541", Text = "Need something?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
		{ Cue = "/VO/Dora_0546", Text = "This place is weird.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs },
		{ Cue = "/VO/Dora_0538", Text = "Save me, Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "==",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Dora_0542", Text = "Inside I'm screaming.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "==",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Dora_0540", Text = "Gotten crowded...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "~=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/Dora_0534", Text = "Lot of Shades around...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "~=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/Dora_0536", Text = "Far as I'll go.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "~=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Dora_0543", Text = "There's the {#Emph}Commander...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Dora_0544", Text = "Don't go just yet.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Dora_0545", Text = "You {#Emph}could {#Prev}just leave...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_PreRun"},
				},
			},
		},
		{ Cue = "/VO/Dora_0547", Text = "Can I go home?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "OriginalSource", "DefaultCategoryIndex" },
					Comparison = "~=",
					Value = 2,
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.66,
		PreLineWait = 0.15,
		ObjectType = "NPC_Dora_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" }
			},
		},

		{ Cue = "/VO/Dora_0229", Text = "Took you long enough.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0230", Text = "You know how late it is?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0231", Text = "Out late again huh.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0232", Text = "Oh, finally!", PlayFirst = true, PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0489", Text = "Whoa, you're back!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0490", Text = "You were out awhile.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0491", Text = "How'd it go, OK?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0492", Text = "Oh you're up.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0530", Text = "Did you do it?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0531", Text = "Made it back.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0532", Text = "Hey Mel.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		-- SGV
		{ Cue = "/VO/Dora_0493", Text = "{#Emph}How can this be?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0494", Text = "{#Emph}What have you done?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0548", Text = "{#Emph}Raaahhh...!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0549", Text = "{#Emph}Hmhmhm, hahahaha...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.15,
		ObjectType = "NPC_Dora_01",

		{ Cue = "/VO/Dora_0125", Text = "Hey.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0126", Text = "Hey...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0127", Text = "Heya.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0569", Text = "Hey now.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0128", Text = "Boo.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0135", Text = "Well look at you!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0136", Text = "Whoa, hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0137", Text = "There you are!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0220", Text = "How's it going?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0221", Text = "Where'd you come from?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0222", Text = "So what's up?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0223", Text = "What's going on?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		{ Cue = "/VO/Dora_0224", Text = "Oh hey!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
		-- SGV
		{ Cue = "/VO/Dora_0129", Text = "{#Emph}Boo!!",
			PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
			GameStateRequirements =
			{
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "DoraFirstMeeting" }, Min = 8 },
				},
			},
		},
		{ Cue = "/VO/Dora_0130", Text = "{#Emph}OoooOooo...!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0131", Text = "{#Emph}OoooOooo!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0132", Text = "{#Emph}OoooOooo...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0133", Text = "{#Emph}Who dares?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0134", Text = "{#Emph}Hail, witch!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0145", Text = "{#Emph}Come forth!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0225", Text = "{#Emph}I rise again!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0226", Text = "{#Emph}You have returned.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0227", Text = "{#Emph}Fear me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
		{ Cue = "/VO/Dora_0228", Text = "{#Emph}Kneel before me!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		},
	}
}
GlobalVoiceLines.DoraHidingVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.15,
	SuccessiveChanceToPlay = 0.33,
	SkipAnim = true,
	Actor = "Dora",
	ObjectType = "NPC_Dora_01",
	SubtitleMinDistance = 1200,
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "DoraFirstMeeting", },
		},
		{
			PathFromArgs = true,
			Path = { "OriginalSource", "DefaultCategoryIndex" },
			Comparison = "==",
			Value = 1,
		},
		{
			PathTrue = { "GameState", "UseRecord", "NPC_Dora_01" },
		},
		{
			PathFromArgs = true,
			PathFalse = { "OriginalSource", "PlayingEndVoiceLines" },
		},
		NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
	},
	Cooldowns =
	{
		{ Name = "DoraAnyQuipSpeech", Time = 6 },
		{ Name = "DoraVanishedVO", Time = 180 },
	},
	{ Cue = "/VO/Dora_0138", Text = "See ya!" },
	{ Cue = "/VO/Dora_0139", Text = "Later!" },
	{ Cue = "/VO/Dora_0140", Text = "So long!" },
	{ Cue = "/VO/Dora_0141", Text = "'K bye." },
	{ Cue = "/VO/Dora_0233", Text = "Got to go." },
	{ Cue = "/VO/Dora_0234", Text = "Bye now." },
	{ Cue = "/VO/Dora_0235", Text = "Take it easy." },
	{ Cue = "/VO/Dora_0550", Text = "{#Emph}Eh!" },
	{ Cue = "/VO/Dora_0551", Text = "Bye." },
	{ Cue = "/VO/Dora_0552", Text = "Right." },
	{ Cue = "/VO/Dora_0553", Text = "Anyway..." },
	{ Cue = "/VO/Dora_0554", Text = "I'm out." },
	{ Cue = "/VO/Dora_0555", Text = "G'night." },
	{ Cue = "/VO/Dora_0556", Text = "See you around!" },
	{ Cue = "/VO/Dora_0557", Text = "'K later." },
	-- SGV
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0142", Text = "{#Emph}I shall returnnn!" },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0143", Text = "{#Emph}I shall return!" },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0236", Text = "{#Emph}Farewell..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0237", Text = "{#Emph}Back to the abyss..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0238", Text = "{#Emph}I gooo..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0558", Text = "{#Emph}I fade..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0559", Text = "{#Emph}I dissipate..." },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0560", Text = "{#Emph}We shall meet again...!" },
	},
	{
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		{ Cue = "/VO/Dora_0561", Text = "{#Emph}Vengeance...!" },
	},
}
GlobalVoiceLines.DoraCosmeticReactionVoiceLines =
{
	RandomRemaining = true,
	-- SuccessiveChanceToPlay = 0.75,
	ObjectType = "NPC_Dora_01",
	Queue = "Always",

	{ Cue = "/VO/Dora_0257", Text = "Pretty spiffy.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0258", Text = "Guess it's OK...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1402" },
			},
		},
	},
	{ Cue = "/VO/Dora_0259", Text = "None whatsoever.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1403" },
			},
		},
	},
	{ Cue = "/VO/Dora_0260", Text = "I'm right here, Mel.",
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1404" },
			},
		},
	},
	{ Cue = "/VO/Dora_0261", Text = "Not too shabby.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0262", Text = "There we go.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0263", Text = "All set.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0264", Text = "Boom.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },

	{ Cue = "/VO/Dora_0671", Text = "Not bad, right?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0673", Text = "It's nice.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0674", Text = "Good pick.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0675", Text = "Anything else?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0676", Text = "Yeah, but what else?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0677", Text = "Looks OK.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0678", Text = "Pretty decent.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },

	-- { Cue = "/VO/Dora_0486", Text = "{#Emph}Oh{#Prev}, I've been looking forward to this thing!", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
}
GlobalVoiceLines.DoraRedecorationReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Dora_01",
	GameStateRequirements = 
	{
	},
	Cooldowns =
	{
		{ Name = "DoraCosmeticsReactionVO", Time = 60 },
	},

	{ Cue = "/VO/Dora_0251", Text = "Whatever.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0252", Text = "It's your stuff.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0253", Text = "All right, hold on.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0278", Text = "All righty.",
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0279", Text = "OK let's bring it in.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0280", Text = "Sure, whatever.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0368", Text = "Let's change it up.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0369", Text = "No prob.",
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0370", Text = "Shades, get in there!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0371", Text = "Sure thing.",
		PreLineFunctionName = "GenericPresentation",
		PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0372", Text = "Got it, hold up.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0373", Text = "All right sure.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0374", Text = "Liked it the other way?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0375", Text = "In with the old.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0665", Text = "Let's switch it up.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0666", Text = "You Shades hear that?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0667", Text = "You got it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0668", Text = "Coming right up!", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0669", Text = "Way it used to be.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0670", Text = "That old thing?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0376", Text = "Change your mind?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsNone = { "/VO/Melinoe_3660" },
			},
		},
	},
	{ Cue = "/VO/Dora_0277", Text = "Changed your mind?", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsNone = { "/VO/Melinoe_3660" },
			},
		},
	},

	-- SGV
	{ Cue = "/VO/Dora_0254", Text = "{#Emph}Why not, indeed...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs,
		GameStateRequirements =
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Melinoe_1400" },
			},
		},
	},
	{ Cue = "/VO/Dora_0255", Text = "{#Emph}It shall be done...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0256", Text = "{#Emph}If that is your will...", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0378", Text = "{#Emph}If that is your will.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0379", Text = "{#Emph}Then very well.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0380", Text = "{#Emph}As you require.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
	{ Cue = "/VO/Dora_0381", Text = "{#Emph}A change of heart.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs },
}

GlobalVoiceLines.DoraDecorationRemovedLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Dora_01",
	GameStateRequirements = 
	{
	},
	Cooldowns =
	{
		{ Name = "DoraCosmeticsReactionVO", Time = 6 },
	},

	{ Cue = "/VO/Dora_0382", Text = "Good as gone.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0383", Text = "Could always put it back.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0384", Text = "We'll just stash it away.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0385", Text = "Clean-up crew! Hop to it.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0386", Text = "Bit of an eyesore huh.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0387", Text = "Better off without.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0388", Text = "Easy-peasy.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
	{ Cue = "/VO/Dora_0389", Text = "Yeah OK.", PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraNormalAppearArgs, },
}