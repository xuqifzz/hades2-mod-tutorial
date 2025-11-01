UnitSetData.NPC_Selene =
{
	-- Selene (Hub version), SeleneHome
	NPC_Selene_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable", },
		GenusName = "SpellDrop",

		Portrait = "Portrait_Selene_InPerson_01",
		Groups = { "NPCs" },
		AnimOffsetZ = 0,
		InvincibubbleScale = 1,
		SpeakerName = "Selene",
		LoadPackages = { "Selene", },
		SubtitleColor = Color.SeleneVoice,

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "SpellDrop" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{ GlobalVoiceLines = "SeleneSaluteLines" },
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					AttachedAnimationName = "SeleneGlow",
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_Main" },
					},
				},
			},
		},

		InteractTextLineSets =
		{
			SeleneHome01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "GameState", "UseRecord", "SpellDrop", },
						Comparison = ">=",
						Value = 7,
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneWithHecate01" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0108",
					Text = "Ah, little star! During such phases, I remain unseen in the night sky, and can enjoy a moment's rest. So let us speak a little more, although I fear that speaking starts to drain me of my light. How fares the task?" },

				-- { Cue = "/VO/Melinoe_0005", UsePlayerSource = true,
				{ Cue = "/VO/Melinoe_0488", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Great Selene, I am honored by your presence here. The task proceeds at pace I think, although as you well know, we have much left to do. I'm grateful you've been watching over me." },

				{ Cue = "/VO/Selene_0109",
					PostLineThreadedFunctionName = "SeleneExitPresentation", PostLineFunctionArgs = { SkipAnim = true, WaitTime = 3.2 },
					Text = "And I am grateful for the opportunity. I am the Eye of Night, but you, I think, have come to be her sword. Until we see each other once again under her veil." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0489", Text = "Farewell till then." },
				},
			},

			-- partner conversations
			SeleneWithHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				Partner = "NPC_Hecate_01",
				UseText = "UseListenNPC",
				-- BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				TeleportToId = 566613,
				-- TeleportOffsetX = -100,
				-- TeleportOffsetY = 100,
				AngleTowardTargetId = 556921,
				InteractDistance = 400,

				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure", },
					},
					--[[
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "SeleneHome01" },
					},
					]]--
					{
						Path = { "GameState", "UseRecord", "SpellDrop", },
						Comparison = ">=",
						Value = 8,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "SeleneHome01" }, Min = 3 },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "HecateAboutSurfaceSurvival02" },
							},
						},
						{
							{
								PathTrue = { "GameState", "RoomsEntered", "P_Intro" }
							},
						},
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,
				OnQueuedThreadedFunctionName = "CenterInteractRange",

				{ Cue = "/VO/Selene_0106",
					Text = "It gladdens me to see you, Hecate. I have observed the stalemate upon Olympus holds, although the Titan Chronos musters forces in Ephyra still. Shall I continue monitoring them?" },

				{ Cue = "/VO/Hecate_0199", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "Yes, Selene, do. Blasted Ephyra is the closest exit out of here. Do you suppose they are prepared for a single assailant to weave through their ranks?" },

				{ Cue = "/VO/Selene_0107",
					PostLineThreadedFunctionName = "SeleneExitPresentation", PostLineFunctionArgs = { SkipAnim = true, WaitTime = 3.2 },
					Text = "The Titan's forces are somewhat in disarray. Thus no, I do not think they are sufficiently prepared for one of us. But I shall watch and make certain of it. For now I must be off. Together we shine." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Hecate_01",
					{ Cue = "/VO/Hecate_0200", Text = "Farewell. Together we shine." },
				},
			},

			-- repeatable
			SeleneHomeRepeatable01 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0323",
					Text = "I have returned to rest within this dark and safe abode. And soon, I ride again." },
			},
			SeleneHomeRepeatable02 =
			{
				UseableOffSource = true,
				PlayFirst = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0324",
					Text = "Our cycle soon is to begin again, but for the moment, I must take my rest." },
			},
			SeleneHomeRepeatable03 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0325",
					Text = "Our strength shall never reach its peak if we do not permit ourselves to rest." },
			},
			SeleneHomeRepeatable04 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0326",
					Text = "Another cycle is complete, so we reflect and make our preparations for the next." },
			},
			SeleneHomeRepeatable05 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneGreeting,

				{ Cue = "/VO/Selene_0327",
					Text = "Within these Crossroads my strength rapidly returns, and soon I shall be high aloft." },
			},

			-- @ ending
			SeleneTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				Partner = "NPC_Nyx_Story_01",
				UseText = "UseListenNPC",
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false,
				InteractDistance = 350,

				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.SeleneTrueEndingGreeting,
				OnQueuedThreadedFunctionName = "CenterInteractRange",
				
				PreEventFunctionName = "OverwriteSelf",
				PreEventFunctionArgs =
				{
					BlockChatting = true,
				},

				{ Cue = "/VO/Nyx_0032",
					Source = "NPC_Nyx_Story_01",
					PreLineFunctionName = "SetupEndSceneZoom",
					PreLineWait = 0.35,
					PreLineAnim = "Nyx_Greeting",
					PreLineAnimTarget = 774446,
					Text = "...My faithful Eye of Night, my child, thank you for ensuring that our realm remains secure, and keeping watch above it all. I never doubted that I could count on you." },

				{ Cue = "/VO/Selene_0372",
					Text = "But Mother, had our watch been more dependable, then none of this would have transpired..." },

				{ Cue = "/VO/Nyx_0122",
					Source = "NPC_Nyx_Story_01",
					Text = "Trying times shall always come about, testing our resolve. Thus we grow strong, as do the bonds we share. Even now, I sense the powerful connection between you and the Princess of the Underworld." },

				{ Cue = "/VO/MelinoeField_5170", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "It was my honor to work with Sister Selene, O Nyx. She has always been my guiding light. I'm so pleased that you could finally see each other again." },

				{ Cue = "/VO/Nyx_0123",
					Source = "NPC_Nyx_Story_01",
					Text = "A reunion you made possible, with Hecate and the Unseen. Your services shall be remembered, O Melinoë, Princess. Now go... for there are more reunions to be had." },

				{ Cue = "/VO/Selene_0373",
					PortraitExitAnimation = "Portrait_Selene_InPerson_01_Exit",
					-- PostLineRemoveContextArt = true,
					-- PostLineFunctionName = "NyxFarewellPresentation",
					Text = "Thank you, Mother, and farewell for now." },

				--[[
				{ Cue = "/VO/Nyx_0032",
					Source = "NPC_Nyx_Story_01",
					PreLineFunctionName = "SetupEndSceneZoom",
					PreLineWait = 0.35,
					PreLineAnim = "Nyx_Greeting",
					PreLineAnimTarget = 774446,
					Text = "...My faithful Eye of Night, my child, thank you for ensuring that our realm remains secure, and keeping watch above it all. I never doubted that I could count on you." },

				{ Cue = "/VO/Selene_0372",
					Text = "But Mother, had our watch been more dependable, then none of this would have transpired... I failed you, yet you praise me?" },

				{ Cue = "/VO/Nyx_0033",
					Source = "NPC_Nyx_Story_01",
					Text = "Trying times shall always come about. Now go, and whenever you ride through the dark of the sky, remember I am always there." },

				{ Cue = "/VO/Selene_0373",
					PortraitExitAnimation = "Portrait_Selene_InPerson_01_Exit",
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "NyxFarewellPresentation",
					Text = "Thank you, Mother, and farewell for now." },
					]]--

				{ Cue = "/VO/MelinoeField_5171",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PortraitExitAnimation = "Portrait_Mel_Proud_01_Exit",
					PostLineFunctionName = "EnsembleRidersEnterPresentation",
					Text = "I must say, I did not expect that we could ever draw you down this far, Sister Selene. I thought perhaps not even Headmistress could in all her experience!" },

				{ Cue = "/VO/Selene_0374",
					PreLineThreadedFunctionName = "EnsembleFamilyEnterPresentation",
					Text = "If you are ready, little star, then let us go, lest we outstay our greetings and farewells. I am honored to have seen these halls, and to return to shadow with you on this night in victory, not haste." },

				{ Cue = "/VO/HecateField_0327",
					Source = "NPC_Hecate_01",
					Text = "Come, Melinoë, for all the reasons that Selene says. We have a delivery that we must make, besides." },

				{ Cue = "/VO/MelinoeField_3903",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "{#Emph}<Sigh> {#Prev}Then let's be off. If only Artemis were here, this could have been a proper Silver Sisters reunion, couldn't it?" },
				EndVoiceLines =
				{
					{
						ObjectType = "NPC_Selene_01",
						PreLineThreadedFunctionName = "ChariotDeparturePresentation",

						{ Cue = "/VO/Selene_0377", Text = "Then let us ride into the dark above." },
						{ Cue = "/VO/Selene_0378", Text = "...And do be careful to hold on as we depart.", PreLineWait = 0.8 },
					},
					{
						PreLineWait = 0.8,
						ObjectType = "NPC_Nyx_Story_01",
						PreLineAnim = "Nyx_Greeting",

						{ Cue = "/VO/Nyx_0034", Text = "Farewell." },
					},
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Persephone_01",
						PreLineAnim = "Persephone_Greet_Start",

						{ Cue = "/VO/Persephone_0013", Text = "Farewell!!" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Zagreus_01",
						PreLineAnim = "Zagreus_Greet",

						{ Cue = "/VO/Zagreus_0088", Text = "Goodbye!" },
					},
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Hades_02",
						PreLineAnim = "Hades_Unchained_Hello",
						PostLineFunctionName = "DeathAreaRestoredToCreditsPresentation",

						{ Cue = "/VO/Hades_0214_C", Text = "Goodbye, Daughter." },
					}
				},
			},

			-- see also TrueEndingFinale01
		},

		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			CooldownTime = 7,

			-- Harrhh...!
			-- -- { Cue = "/VO/Charon_0028", Text = "TODO(BuildText) Charon_0028" },
		},
	},

	NPC_HorseAndChariot_01 =
	{
		InheritFrom = { "NPC_Neutral", },
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Selene )

-- Global Selene Lines
GlobalVoiceLines.SeleneSaluteLines =
{
	{
		PreLineWait = 0.3,
		RandomRemaining = true,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeSaluteSpeech", Time = 4 },
		},
		{ Cue = "/VO/Melinoe_1881", Text = "May your light never wane.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1711", Text = "Together we shine, Sister." },
		{ Cue = "/VO/Melinoe_1698", Text = "Salutations." },
		{ Cue = "/VO/Melinoe_1699", Text = "Salutations!" },
		{ Cue = "/VO/Melinoe_1700", Text = "Death to Chronos!" },
		{ Cue = "/VO/Melinoe_1882", Text = "Moonlight gui— {#Emph}ugh. {#Prev}Sorry. Habit.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1881" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 0.31,
		RandomRemaining = true,
		Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "SeleneSaluteSpeech", Time = 30 },
		},

		{ Cue = "/VO/Selene_0233", Text = "It never shall.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0234", Text = "{#Emph}Hmm.",
			PreLineWait = 0.05,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1882" },
				},
			},
		},
		{ Cue = "/VO/Selene_0235", Text = "Always.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0236", Text = "Salutations.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
				},
			},
		},
		{ Cue = "/VO/Selene_0237", Text = "Darkness guide you.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
				},
			},
		},
		{ Cue = "/VO/Selene_0238", Text = "Forever more.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0136", Text = "I am obliged.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0486", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1700" },
				},
			},
		},
		{ Cue = "/VO/Selene_0487", Text = "Shine on.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0488", Text = "For the Silver Sisters.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711", "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0489", Text = "My blessings in turn.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
	},
	{
		PreLineWait = 0.31,
		RandomRemaining = true,
		ObjectType = "NPC_Selene_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		Cooldowns =
		{
			{ Name = "SeleneSaluteSpeech", Time = 30 },
		},

		{ Cue = "/VO/Selene_0233", Text = "It never shall.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0234", Text = "{#Emph}Hmm.",
			PreLineWait = 0.05,
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1882" },
				},
			},
		},
		{ Cue = "/VO/Selene_0235", Text = "Always.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0236", Text = "Salutations.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
				},
			},
		},
		{ Cue = "/VO/Selene_0237", Text = "Darkness guide you.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
				},
			},
		},
		{ Cue = "/VO/Selene_0238", Text = "Forever more.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0136", Text = "I am obliged.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0486", Text = "Death to Chronos.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1700" },
				},
			},
		},
		{ Cue = "/VO/Selene_0487", Text = "Shine on.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711" },
				},
			},
		},
		{ Cue = "/VO/Selene_0488", Text = "For the Silver Sisters.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1711", "/VO/Melinoe_1881" },
				},
			},
		},
		{ Cue = "/VO/Selene_0489", Text = "My blessings in turn.",
			GameStateRequirements =
			{
				{
					Path = { "LastLinePlayed" },
					IsAny = { "/VO/Melinoe_1881" },
				},
			},
		},
	},
}

GlobalVoiceLines.SeleneVictoryVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 7.1,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.25,
	Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" },
		},
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneAboutAltFightQuest01" },
		},
		OrRequirements =
		{
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name", },
					IsAny = { "F_Boss02", "G_Boss02", "N_Boss02", "O_Boss02", "Q_Boss02" },
				},
			},
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name", },
					IsAny = { "P_Boss01" },
				},
			},
		},

	},

	{ Cue = "/VO/Selene_0383", Text = "Your rival has fallen.", PlayFirst = true },
	{ Cue = "/VO/Selene_0384", Text = "Another rival overcome." },
	{ Cue = "/VO/Selene_0385", Text = "Your rival was unable to prevail." },
	{ Cue = "/VO/Selene_0386", Text = "Your great rival, vanquished for the night." },
	{ Cue = "/VO/Selene_0387", Text = "I was witness to your rival's fall." },
}

GlobalVoiceLines.SeleneExorcismReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	SuccessiveChanceToPlay = 0.5,
	PreLineWait = 0.7,
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
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "G", "H", "I", },
		},
	},
	Cooldowns =
	{
		{ Name = "SeleneAnyQuipSpeech", Time = 90 },
	},

	{ Cue = "/VO/Selene_0310", Text = "A possible ally." },
	{ Cue = "/VO/Selene_0311", Text = "Another joins our ranks." },
	{ Cue = "/VO/Selene_0312", Text = "Well done." },
	{ Cue = "/VO/Selene_0313", Text = "A soul no longer lost." },
	{ Cue = "/VO/Selene_0314", Text = "Peace for the dead..." },
	{ Cue = "/VO/Selene_0315", Text = "Everlasting peace..." },
	{ Cue = "/VO/Selene_0316", Text = "To our abode..." },
	{ Cue = "/VO/Selene_0317", Text = "Freedom in death." },
}

GlobalVoiceLines.SeleneHexReadyLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	SuccessiveChanceToPlay = 0.5,
	PreLineWait = 0.7,
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
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsNone = { "G", "H", "I", },
		},
	},
	Cooldowns =
	{
		{ Name = "SeleneAnyQuipSpeech", Time = 90 },
	},

	{ Cue = "/VO/Selene_0277", Text = "Now, little star." },
	{ Cue = "/VO/Selene_0278", Text = "Now..." },
	{ Cue = "/VO/Selene_0279", Text = "Remember me..." },
	{ Cue = "/VO/Selene_0280", Text = "Your Hex..." },
	{ Cue = "/VO/Selene_0281", Text = "Prepared..." },
	{ Cue = "/VO/Selene_0282", Text = "My light..." },
	{ Cue = "/VO/Selene_0283", Text = "Ready..." },
	{ Cue = "/VO/Selene_0284", Text = "There..." },
}