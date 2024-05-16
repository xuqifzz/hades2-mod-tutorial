UnitSetData.NPC_Hecate =
{
	-- Hecate, Id = 556921
	NPC_Hecate_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Hec_Default_01",
		AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SubtitleColor = Color.HecateVoice,
		SpeakerName = "Hecate",
		SpeechParams =
		{
			Radius = 0,
		},

		ActivateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
			},
		},

		PreBathAnimationName = "HecateHubGreet",
		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
			},
			{
				PathFalse = { "SessionState", "InFlashback", },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PlayOnceThisRun = true,
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1706", Text = "Be well, Headmistress.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				PreLineAnim = "HecateHubGreet",
				ObjectType = "NPC_Hecate_01",

				{ Cue = "/VO/Hecate_0061", Text = "Together we shine.",
					PreLineAnim = "Hecate_Hub_Salute",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1697", "/VO/Melinoe_0025" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0460", Text = "Together we shine.",
					PreLineAnim = "Hecate_Hub_Salute",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1697", "/VO/Melinoe_0025" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0062", Text = "Moonlight guide you.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1697", "/VO/Melinoe_0025" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0063", Text = "Death to Chronos.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0462", Text = "Salutations.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0463", Text = "Death to Chronos.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0464", Text = "Moonlight guide us all.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0465", Text = "And you as well.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0466", Text = "Shadows conceal you.",
					PreLineAnim = "Hecate_Hub_Salute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0467", Text = "All of us.",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0468", Text = "And may shadows conceal us.",
					PreLineAnim = "Hecate_Hub_Salute",
					PreLineThreadedFunctionName = "LightRangedSalute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0469", Text = "And you, Melinoë.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1706" },
						},
					},
				},
			},
		},

		GiftGameStateRequirements =
		{
			{
				PathFalse = { "SessionState", "InFlashback" },
			},
		},

		-- requirements are in SetupCauldronWitchcraftPresentation
		CauldronWitchcraftVoiceLines =
		{
			{
				TriggerCooldowns = { "CauldronWitchcraftPlayedRecently" },
				PreLineWait = 0.05,
				ObjectType = "NPC_Hecate_01",
				SubtitleMinDistance = 1200,
				--Actor = "DadOcclusion",
				ThreadName = "RoomThread",
				GameStateRequirements =
				{
   					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
				RecheckRequirementsForSubLines = true,

				{ Cue = "/VO/Hecate_0192_01", Text = "{#Emph}Upon this cauldron, by the will of Night,", PreLineWait = 0.65,
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2465", Text = "{#Emph}Upon this cauldron, by the will of Night," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_02", Text = "{#Emph}Hear me, Shades of the Dead, and listen well,",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2466", Text = "{#Emph}Hear me, Shades of the Dead, and listen well," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_03", Text = "{#Emph}Your strength is needed now to join our fight,",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2467", Text = "{#Emph}Your strength is needed now to join our fight," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_04", Text = "{#Emph}Upon Olympus and in depths of hell.", PreLineThreadedFunctionName = "CauldronPresentationRing",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2468", Text = "{#Emph}Upon Olympus and in depths of hell." },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_05", Text = "{#Emph}Within these Crossroads you are safe with us,",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2469", Text = "{#Emph}Within these Crossroads you are safe with us," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_06", Text = "{#Emph}Yet we would ask your service to our cause.",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2470", Text = "{#Emph}Yet we would ask your service to our cause." },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_07", Text = "{#Emph}Your will is yours, your choice is given thus:",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2471", Text = "{#Emph}Your will is yours, your choice is given thus:" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_08", Text = "{#Emph}Together, let us rise above our flaws.",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2472", Text = "{#Emph}Together, let us rise above our flaws." },
						},
					},
				},
				{ Cue = "/VO/Hecate_0192_09", Text = "So mote it be.", BreakIfPlayed = true, PreLineWait = 0.5, PreLineThreadedFunctionName = "CauldronPresentationBurst",
					PostLineFunctionName = "CauldronAssistCompletePresentation",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2473", Text = "So mote it be." },
						},
					},
				},
			},
			{
				TriggerCooldowns = { "CauldronWitchcraftPlayedRecently" },
				PreLineWait = 0.05,
				ObjectType = "NPC_Hecate_01",
				SubtitleMinDistance = 1200,
				--Actor = "DadOcclusion",
				ThreadName = "RoomThread",
				GameStateRequirements =
				{
					{
						PathFalse = { "ActiveScreens", "GhostAdmin" },
					},
   					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
				RecheckRequirementsForSubLines = true,

				{ Cue = "/VO/Hecate_0397", Text = "{#Emph}By light of Moon, in darkest Erebus,", PreLineWait = 0.65, 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2577", Text = "{#Emph}By light of Moon, in darkest Erebus," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0398", Text = "{#Emph}I urge ye Spirits of the Crossroads thus:", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2578", Text = "{#Emph}I urge ye Spirits of the Crossroads thus:" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0399", Text = "{#Emph}Look well upon the wards about this place,", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2579", Text = "{#Emph}Look well upon the wards about this place," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0400", Text = "{#Emph}Which keep us hidden within Night's embrace.", PreLineThreadedFunctionName = "CauldronPresentationRing", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2580", Text = "{#Emph}Which keep us hidden within Night's embrace." },
						},
					},
				},
				{ Cue = "/VO/Hecate_0401", Text = "{#Emph}Ensure that each is whole, its strength secure,", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2581", Text = "{#Emph}Ensure that each is whole, its strength secure," },
						},
					},
				},
				{ Cue = "/VO/Hecate_0402", Text = "{#Emph}As we hold out against our common foe;", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2582", Text = "{#Emph}As we hold out against our common foe;" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0403", Text = "{#Emph}To achieve victory we must endure", 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2583", Text = "{#Emph}To achieve victory we must endure" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0404", Text = "{#Emph}The ravages on us Time would bestow.", PreLineWait = 0.1, 
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2584", Text = "{#Emph}The ravages on us Time would bestow." },
						},
					},
				},
				{ Cue = "/VO/Hecate_0405", Text = "So mote it be.", PreLineWait = 0.5, PreLineThreadedFunctionName = "CauldronPresentationBurst",
					PostLineFunctionName = "CauldronAssistCompletePresentation",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2585", Text = "So mote it be." },
						},
					},
				},
			},

		},

		InteractTextLineSets =
		{
			HecateFirstMeeting =
			{
				PlayOnce = true,
				-- StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronos01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateFirstMeeting_B" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateFirstGreeting,
				
				{ Cue = "/VO/Hecate_0619",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					-- PreLineAnim = "Hecate_Hub_Explaining_Start",
					-- PostLineAnim = "Hecate_Hub_Explaining_End",
					-- PreLineAnim = "Hecate_Hub_Stern_Start",
					-- PostLineAnim = "Hecate_Hub_Stern_End",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Time forced our hand, Melinoë. Nary a soul expected you to slay our enemy last night, on a new moon, no less! But, you accomplished something of great import." },
				{ Cue = "/VO/Melinoe_2906", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I lack such forgiveness for my failure, Headmistress Hecate. The Titan yet lives, and Olympus yet burns, while I'm back where I started! What is it I accomplished?" },
				{ Cue = "/VO/Hecate_0620",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "You're here to speak of it! Recovered in body, if not in spirit. You've not failed; merely begun. Thus may you learn, grow stronger, and complete your task. {#Emph}Death to Chronos." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0014_V3", Text = "Death to Chronos." },
					},
				},
			},
			HecateFirstMeetingCont1 =
			{
				PlayOnce = true,
				StatusAnimation = false,
				BlockStatusAnimations = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasAny = { "HecateFirstMeeting", "HecateFirstMeeting_B" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0621",
					Text = "This cauldron's filthy still, alas. But there's something at our Altar you may use, and I've unsealed the Silver Pool as well." },
			},
			HecateFirstMeetingCont2 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				BlockStatusAnimations = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HecateFirstMeetingCont1" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0622",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "We shall await your safe return. May moonlight guide you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0176", Text = "Thank you, Headmistress." },
					},
				},
			},
			HecateFirstMeeting_B =
			{
				PlayOnce = true,
				-- StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronos01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateFirstMeeting" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Hecate" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateFirstGreeting,
				
				{ Cue = "/VO/Hecate_0411",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "'Twas a worthwhile first attempt, Melinoë. I trust you'd have gone farther still had I not obstructed your path. Quite unsuccessfully, I concede." },
				{ Cue = "/VO/Melinoe_1802", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You needed to ensure I was prepared, Headmistress Hecate. And I know there is much left to prove." },
				{ Cue = "/VO/Hecate_0412",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Just so. Trust well your instincts and your craft, and continue the task. {#Emph}Death to Chronos." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0014_V3", Text = "Death to Chronos." },
					},
				},
			},

			HecateAboutBackstory01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- time cannot be stopped
					-- @ intentionally removed for now; HecateAboutArtemis01 still there
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 9999,
					},
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "HecateHideAndSeek01" },
					},
					{
						Path = { "GameState", "QuestsViewed" },
						HasAny = { "QuestMeetOlympians" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0626",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Such a mess made of our best-laid plans. Leave it to swiftest Hermes to show up one evening with bad news, then scurry off! Nary a message from him since, whilst {#Emph}you {#Prev}are forced now to attempt the task we'd no intention to initiate till many moons hence..." },
				{ Cue = "/VO/Melinoe_2907", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes must still be trying to figure out what Chronos is up to... the attacks on Olympus grown so much bolder all of a sudden. We just couldn't afford to wait any longer for details, could we...?" },
				{ Cue = "/VO/Hecate_0627",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "No, Hermes was quite insistent about that. Persuaded Artemis to do her part, and now it seems your other {#Emph}mountain relatives {#Prev}are finally aware of you. They have been quick to be of benefit, at least?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2908", Text = "Most certainly." },
					},
				},
			},

			HecateAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0210",
					Text = "What troubles you, Melinoë? Your brow is furrowed not with fierceness but with doubt... the one emotion we cannot afford." },
				{ Cue = "/VO/Melinoe_0582", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Ungh{#Prev}, Headmistress, it's just... I'm struggling to muster the rage I should feel. I'm tasked with slaying a Titan I do not even know, to avenge a family I cannot remember..." },
				{ Cue = "/VO/Hecate_0211",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Your feelings never lie to you; 'tis their origins that may deceive. You feel no rage? Then {#Emph}you {#Prev}are in control. Tell me, do you question the need to complete our task?" },
				{ Cue = "/VO/Melinoe_0583", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "No, Headmistress. Treachery against the House of Hades cannot go unpunished." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0212", Text = "Just so. Center yourself on that." },
					},
				},
			},
			HecateAboutTask02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with real requirements 
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "Ending01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0019",
					Text = "How fares the task thus far, Melinoë? Our enemy yet remains indisposed with more pressing matters. The time to strike at him is now." },
				{ Cue = "/VO/Melinoe_0046", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There is much left to do, Headmistress. You must know that. How much time do I have?" },
				{ Cue = "/VO/Hecate_0020",
					Text = "Who can say? Our enemy is Time itself. Time's passage seems to bear little meaning anymore. Do not rush needlessly. The task shall only take longer that way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- I'll do my best.
						{ Cue = "/VO/Melinoe_0047", Text = "I'll do my best." },
					},
				},
			},

			HecateAboutPressure01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
					},
					{
						-- PathFalse = { "CurrentRun", "Cleared" }
					},
					-- MaxRunsSinceAnyTextLines = { TextLines = { "HecateHideAndSeek01" }, Count = 10 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0529",
					Text = "Much is expected of you. The pressure that you feel; you never speak of it, and yet full well I know it's there. Your constant companion." },
				{ Cue = "/VO/Melinoe_2133", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can hardly distinguish between pressure and faith anymore. My entire life has led to this, and all of you are counting on me. Are you truly so certain in my inevitable success, Headmistress?" },
				{ Cue = "/VO/Hecate_0530",
					Text = "Pressure and faith are intertwined, 'tis true. Ever in conflict. Should the pressure utterly prevail, out comes despair. Only then do we truly falter." },
				{ Cue = "/VO/Melinoe_2134", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You didn't answer my question. The combined might of the gods was not enough to stop Chronos before. And you know the Fates are unpredictable. My success is not a certainty..." },
				{ Cue = "/VO/Hecate_0531",
					PreLineAnim = "HecateHubGreet",
					Text = "My faith is not in outcomes, 'tis in you! And I've enough of it to last. Should you find yours lacking, I shall always spare you some of mine." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2135", Text = "...Thank you for believing in me." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0532", Text = "No need." },
					},
				},
			},

			HecateAboutQuestLog01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0623",
					Text = "At least our cauldron's finally purified, praise the Fates! Speaking of which, are you as yet considering an invocation to them? I have my doubts that they would listen, even now..." },
				{ Cue = "/VO/Melinoe_2900", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If there's any chance the Three Fates shall aid us, I'll take it. Thank you for preparing things for me. Though, I'm well short of freshly picked reagents still." },
				{ Cue = "/VO/Hecate_0416",
					Text = "{#Emph}Mm. {#Prev}I'd offer such reagents if I could but, as you venture past this glade look carefully along your path and you shall find them. Fates willing..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0585", Text = "Yes, Headmistress." },
					},
				},
			},
			HecateAboutQuestLog02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
					},
					{
						Path = { "GameState", "QuestsViewed" },
						HasNone = { "QuestRescueFates" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					RequiredMaxQuestsComplete = 6,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0419",
					Text = "The Fates indulged you after all. That is their scroll beside your tent; it followed you out of the shadows. Perhaps it can provide some answers." },
				{ Cue = "/VO/Melinoe_0968", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Would that it does. The Fated List has tasked me with ensuring certain minor prophecies are fulfilled, though says little else as yet." },
				{ Cue = "/VO/Hecate_0420",
					Text = "May it reward your efforts, at least. But do not expect the Fates to always favor you; the bane of our enemy is not necessarily our friend." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1800", Text = "We'll have to take our chances..." },
					},
				},
			},

			HecateAboutBountyBoard01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossAboutPackagedBounties01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0624",
					Text = "That Pitch-Black Stone in our training grounds... I've sensed it ever since your incantation. The subtle influence of Chaos on this realm." },
				{ Cue = "/VO/Melinoe_2796", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Our goals are intertwined. When I gaze upon the Stone, I begin to see different paths and possibilities in every facet. Some leading closer to our victory." },
				{ Cue = "/VO/Hecate_0625",
					Text = "Those paths and possibilities are real, like as not; as are the splendors that await, should you indulge our primordial benefactor. There always is uncertainty where Chaos is concerned... yet I trust that Nyx's parent is an ally, not a threat." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/Melinoe_2902", Text = "I trust so too." },
					},
				},
			},

			HecateAboutCodex01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossGrantsCodex01" },
					},
					{
						Path = { "GameState", "CodexEntriesUnlockedCache", },
						Comparison = ">=",
						Value = 15,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0273",
					Text = "Have you had opportunity to glean much from the Book of Shadows yet, Melinoë? Our task shall take you far beyond these Crossroads; you've much to learn as yet." },
				{ Cue = "/VO/Melinoe_1011", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "As I begin to have insights into my experiences, the Book reveals more. Are they {#Emph}your {#Prev}teachings within, Headmistress?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Hecate_01",

						{ Cue = "/VO/Hecate_0274", Text = "Not mine alone, though heed them anyway..." },
					},
				},
			},

			HecateAboutTorch01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
					{
						PathTrue = { "CurrentRun", "WeaponsCache", "WeaponTorch" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0642",
					Text = "I recall when I myself first grasped the Flames of Ygnium. I must have been about your age. Now you are possessed of their power." },
				{ Cue = "/VO/Melinoe_1014", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All it takes is a bit of light to cast a long shadow; isn't that so, Headmistress? I'll do my best to wield the Flames as you have taught." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",

						{ Cue = "/VO/Hecate_0643", Text = "In your {#Emph}own {#Prev}way, Melinoë." },
					},
				},
			},

			HecateAboutFates01 =
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				PlayOnce = true,
				UseableOffSource = true,
				{ Cue = "/VO/Melinoe_0970", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I dreamt of Father once again. When Chronos came for him, and you took me to safety. Except this time, I remained there longer than before." },
				{ Cue = "/VO/Hecate_0271",
					Text = "'Tis more than a dream, of course. And what else did you learn whilst you lingered thus?" },
				{ Cue = "/VO/Melinoe_2916", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I learned Chronos wanted for Father to tell him where to locate the Three Fates. Chronos hates them, or feels threatened by them. He's been searching for them all this time, hasn't he? And finally found them." },
				{ Cue = "/VO/Hecate_0640",
					Text = "Which means they may not take our side if forced to choose. I feared as much, yet didn't wish to lend the possibility my voice. Well, this certainly fits the spirit of the news swift Hermes relayed when he spurred us to act! {#Emph}Something real real bad{#Prev}, I believe were his words?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/Melinoe_2917", Text = "{#Emph}Real real bad{#Prev}, yes..." },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},

			HecateAboutNightmares01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "NightmareOccurred" },
					},
					{
						Path = { "GameState", "NightmaresOccurred" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0285",
					Text = "Your dreams have troubled you again, I see. Despite your brave attempts to conceal it." },
				{ Cue = "/VO/Melinoe_1021", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can manage them, Headmistress, it's just... it's Chronos. I now hear him even when I'm still as death." },
				{ Cue = "/VO/Hecate_0286",
					Text = "Then turn your nightmares into his. Your subconscious self is your greatest refuge. Let none there remain whom you do not permit." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- { Cue = "/VO/Melinoe_0143", Text = "Greater resolve..." },
					},
				},
			},

			HecateAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					{
						Path = { "GameState", "UseRecord", "SpellDrop" },
						Comparison = "<=",
						Value = 10,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0014",
					Text = "Sister Selene tells me that she lent you her brilliance and might. You were able to draw her down even within this place?" },
				{ Cue = "/VO/Melinoe_0043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I found a source of moonlight and invoked Selene's aid using the Words, Headmistress. I can't imagine the extent of her power." },
				{ Cue = "/VO/Hecate_0015",
					Text = "You know her power perfectly well. You simply haven't had the opportunities to wield it. You shall have them very soon, I think." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

					},
				},
			},
			HecateAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisAboutTraining01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_0152", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This task... why does it fall solely to me, Headmistress? Because, Nemesis, she..." },
				{ Cue = "/VO/Hecate_0035",
					Text = "{#Emph}She {#Prev}is a burden. Had I not sworn to Nyx that I would watch over her children, I'd have cast her out for insubordination long ago." },
				{ Cue = "/VO/Melinoe_0153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She's frustrated you haven't given her a chance. Her strength far surpasses mine, and she's trained at least as hard, I've seen it!" },
				{ Cue = "/VO/Hecate_0036",
					Text = "Why defend her thus, Melinoë? Her attitude speaks far louder than she. I shall entrust nothing of import to one such as that." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2244", Text = "{#Emph}<Scoff>" },
					},
				},
			},

			HecateAboutChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "Chaos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2914", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Last night, Headmistress, I... traversed a gate that led me to the depths of Chaos. Where I met its host! I've heard so much from you of Nyx, yet somehow I never expected to meet her mother and father... of all creation, not just her." },
				{ Cue = "/VO/Hecate_0638",
					Text = "An audience with Primordial Chaos... I'd not entirely expected that! Although given that Nyx herself has not been seen since Chronos took the House of Hades, I am unsurprised. There is no fury like that of a parent bereft of their child. Does Chaos seem an ally to us, then?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2915", Text = "I believe so." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0639", Text = "Well, thank you Nyx for that..." },
					},
				},
			},

			HecateAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutErisBossW01" },
					},
					AreIdsAlive = { 585573 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0601",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Eris has returned to us, I trust you've seen! It was my dearest hope that leaving all her rubbish here would soon enough inspire her to pick it up, but alas.... You stay away from her." },
				{ Cue = "/VO/Melinoe_2528", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I thought perhaps you'd finally relieved her of her entry privileges. I won't let Eris turn this place into a sty for pigs, even if it means having to clean up after her myself." },
				{ Cue = "/VO/Hecate_0602",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "{#Emph}Ah{#Prev}, how she'd chortle could she see now the frustration on your face. I know, ignoring things is seldom how one makes them go away, but... when it comes to Eris, I fear it's our best shot..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1948", Text = "{#Emph}Ngh." },
					},
				},
			},
			HecateAboutErisFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" }
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0645",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Sister Selene notified me it was Eris herself who barred you from gaining the heights of Olympus. She never should have got her hands on the Rail of Adamant again, that {#Emph}wretch." },
				{ Cue = "/VO/Melinoe_3445", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, is there truly nothing we can do? Your oath to Nyx means Eris can come and go here as she pleases, only to try and blast me to bits when I approach my goal?" },
				{ Cue = "/VO/Hecate_0646",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "One must carefully consider the terms of binding contracts, Melinoë. A mistake on my part you are paying for firsthand, {#Emph}heh. {#Prev}And I apologize. Do bring her hell when next you meet?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3446", Text = "Sounds good..." },
					},
				},
			},
			HecateAboutErisBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Eris" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					-- @ update with additional requirements 1.0
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_3450", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I vanquished Eris on the surface, but could go no farther from that point... I was nearly at the base of Olympus, yet my path was sealed, like it didn't even exist!" },
				{ Cue = "/VO/Hecate_0647",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Eris must find all of this delightful, certainly. That pathway wasn't sealed, 'twas a void. No incantation is required, merely patience... for the future to unfold." },
				{ Cue = "/VO/Melinoe_3451", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But Olympus needs us {#Emph}now. {#Prev}My task could ill-afford to wait, that's why we started when we did! That's what you said!" },
				{ Cue = "/VO/Hecate_0648",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Time works in curious ways, Melinoë; that much we have experienced firsthand. Fear not! The path to Olympus {#Emph}shall {#Prev}open. Mortals {#Emph}pray {#Prev}for such outcomes; {#Emph}we but wait." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3452", Text = "...We but wait." },
					},
				},

			},

			HecateAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosRevealFollowUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronosAnomaly01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_1177", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I saw him. {#Emph}Chronos! {#Prev}He was in the pathways beyond Erebus. I struck as soon as I realized who he was, but to no avail." },
				{ Cue = "/VO/Hecate_0033",
					Text = "Wily bastard. Arrogant to the last.... So then, he knows of you. What did he say?" },
				{ Cue = "/VO/Melinoe_1178", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He thanked the Fates that we had finally met, as though he'd been searching for me all this time... and told me to not make the same mistakes as my family." },
				{ Cue = "/VO/Hecate_0034",
					Text = "Eject that poisoned memory from your mind; he knows nothing of the Fates' designs. I shall reinforce all our protective sorceries, and {#Emph}you: {#Prev}Fear not your enemy; {#Emph}slay him!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0219", Text = "Hm." },
					},
				},
			},
			HecateAboutChronos02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosRevealFollowUp", "HecateAboutChronosAnomaly01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronos01" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_2520", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos was waiting for me again outside of Erebus. This time I recognized him right away, but I could do nothing against him..." },
				{ Cue = "/VO/Hecate_0033",
					Text = "Wily bastard. Arrogant to the last.... So then, he knows of you. What did he say?" },
				{ Cue = "/VO/Melinoe_1178", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He thanked the Fates that we had finally met, as though he'd been searching for me all this time... and told me to not make the same mistakes as my family." },
				{ Cue = "/VO/Hecate_0034",
					Text = "Eject that poisoned memory from your mind; he knows nothing of the Fates' designs. I shall reinforce all our protective sorceries, and {#Emph}you: {#Prev}Fear not your enemy; {#Emph}slay him!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0219", Text = "Hm." },
					},
				},
			},			

			HecateAboutChronosBossEarlyL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutChronos01", "HecateAboutChronosAnomaly01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},

				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2903", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I found him! {#Emph}Chronos! {#Prev}Deep within Tartarus, just as you said. I did everything as practiced and as planned, except... he was too strong." },
				{ Cue = "/VO/Hecate_0591",
					Text = "Still your heart, Melinoë, you're safe. And you were able to return again, which means that all your training served you well.... So then... he realizes who you are?" },
				{ Cue = "/VO/Melinoe_2904", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He does. We've lost the element of surprise now, haven't we? Damn it... how could I fail?" },
				{ Cue = "/VO/Hecate_0592",
					Text = "Nothing has changed; you're to confront him down where he resides. Where your mother and father rightly ought to be. But go with patience, not with haste. He may know something of your power now, yet not enough." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2905", Text = "...I'll get him." },
					},
				},

			},

			HecateAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					-- @ update with additional requirements
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2797", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I reached the House, Headmistress. Did everything as practiced and as planned, except... he was too strong." },
				{ Cue = "/VO/Hecate_0630",
					Text = "{#Emph}No{#Prev}, this is an {#Emph}excellent {#Prev}result! You are still here, having learned more of what it takes to reach our enemy, and what {#Emph}he {#Prev}can do to resist! Do you feel ready to continue your pursuit?" },
				{ Cue = "/VO/Melinoe_2798", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes. If I can reach him... I can take him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0631", Text = "Take him." },
					},
				},
			},
			HecateAboutChronosBossL02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3469", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Again I've failed to destroy the Titan, Headmistress. Night after night he thwarts me, expecting I'll eventually give in..." },
				{ Cue = "/VO/Hecate_0668",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "But you've no such intent, correct? You cannot stop him, and neither has he been able to stop {#Emph}you. {#Prev}You are resistant to his power and he cannot bar you from {#Emph}your realm." },
				{ Cue = "/VO/Melinoe_3470", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "You make it sound as though I've beaten him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0669", Text = "Not yet; but soon enough, I trust." },
					},
				},
			},

			HecateAboutChronosBossW01 =
			{
				PlayOnce = true,
				-- UseableOffSource = true, -- for follow-up line
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					-- @ update with additional requirements 1.0
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0632",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You're back...! Now tell me everything. You found your mark? What then?" },
				{ Cue = "/VO/Melinoe_2799", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I reached the edge of Tartarus and made my way into the House, just as we planned. Chronos was there, on my father's throne. We clashed. He lost. But I know he isn't gone. And I was unable to linger there for long." },
				{ Cue = "/VO/Hecate_0633",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Truly? And, you retrieved something from him, I see. We were never going to destroy him with brute force alone, but soon enough, he may yet be undone entirely. Until then, study him. And I shall study what you found..." },
				{ Cue = "/VO/Melinoe_2800", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "By {#Emph}study him{#Prev}, you mean find him again, and fight him... weaken him... distract him?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0634", Text = "Precisely that." },
					},
				},
			},
			HecateAboutChronosBossW01Cont1 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				BlockStatusAnimations = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasAny = { "HecateAboutChronosBossW01" },
					},
				},
				{ Cue = "/VO/Hecate_0635",
					Text = "Oh, by the way... something awaits you in the training grounds. You proved beyond a doubt that you're prepared." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0176", Text = "Thank you, Headmistress..." },
					},
				},
			},

			HecateAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = "<=",
						Value = 4,
					},
					AreIdsAlive = { 560612 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0421",
					Text = "One more of Nyx's kin is here for us to mind. Your incantation tracked him after all! {#Emph}Doom {#Prev}typically arrives {#Emph}un{#Prev}invited, of course." },
				{ Cue = "/VO/Melinoe_1591", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros is to be our guest. I know his presence must seem an ill portent, but if the Fates wanted him here, who are we to fight it?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0422", Text = "Who, indeed." },
					},
				},
			},

			HecateAboutHades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_1029", UsePlayerSource = true,
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I found him, Headmistress! My father! Chronos has him locked away in Tartarus. But, I couldn't save him... he asked I leave him be..." },
				{ Cue = "/VO/Hecate_0295",
					Text = "Truly? How utterly predictable of Chronos to gloat in such a way. I regret that your reunion with Lord Hades thus transpired... though, I am gladdened you discovered him. How does he fare?" },
				{ Cue = "/VO/Melinoe_1030", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He... {#Emph}ungh. {#Prev}I really wouldn't know. He seemed sound of mind and body, and he knew me soon enough. Gave me what blessing he could still bestow. What can we do?" },
				{ Cue = "/VO/Hecate_0296",
					Text = "If he asked you leave him be, then 'tis evidence he wishes to remain unseen. Use full discretion and be brief, should you encounter him again; and {#Emph}I {#Prev}shall see about ensuring Chronos remains ignorant of your newfound connection." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1031", Text = "...By your leave." },
					},
				},
			},
			HecateAboutHades02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutHecate01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3456", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I've a message from my father that he asked me to relay: He sends his deepest gratitude..." },
				{ Cue = "/VO/Hecate_0654",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Lord Hades told you this? {#Emph}Whyever for? {#Prev}He {#Emph}rots {#Prev}in his own prison whilst the Titan ransacks his domain! My charge was to safeguard the realm and I did not." },
				{ Cue = "/VO/Melinoe_3457", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Father spoke of when he left me in your care, when Chronos struck. He must have feared the worst. Now he knows I'm well... all thanks to you." },
				{ Cue = "/VO/Hecate_0655",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "No, Melinoë, all this is thanks to {#Emph}Chronos. {#Prev}Your father would do well to save his gratitude ere we settle certain scores. Though... speak not to him of this... undignified response. I merely was taken aback." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3458", Text = "Of course. I understand." },
					},
				},
			},

			HecateAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2909", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "At the edge of the Mourning Fields... I faced some sort of dark, infernal beast. Three monstrous canine maws, bellowing with fury and sorrow. It was my father's... my {#Emph}family's {#Prev}old dog... wasn't it?" },
				{ Cue = "/VO/Hecate_0628",
					Text = "Through Odysseus we have a few reports about a creature fitting that description, more or less, but... Cerberus was {#Emph}red {#Prev}in hue, as blood. Nevertheless, a stay within the Fields could have transformative effects. {#Emph}Tsk{#Prev}, wretched thing. Torn from its home." },
				{ Cue = "/VO/Melinoe_2910", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He doesn't seem to know who I am. Whether because it's been too long, or there's too much on his mind. Minds? But I felt a flash of recognition. He isn't too far gone, is he...?" },
				{ Cue = "/VO/Hecate_0629",
					PreLineAnim = "HecateHubGreet",
					Text = "The nature of a beast can never change. Like us, however, they at times must fight the daemons that torment them... a battle in which you can assist! Trust your training, and perhaps he can yet shake the spell that's overtaken him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2911", Text = "I'm certain that he can." },
					},
				},
			},
			HecateAboutCerberus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutCerberus01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered", "H_Boss01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0666",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "You've not escaped the Mourning Fields as yet. The beast guarding the entrance into Tartarus seems insurmountable. 'Tis the effect of the Fields themselves." },
				{ Cue = "/VO/Melinoe_3468", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What hope I have begins to drain from me as soon as I set foot in there. I know it's just a trick of the mind, but..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						-- PreLineAnim = "Hecate_Hub_Affirm",
						-- PreLineAnim = "Hecate_Hub_Scoff",
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0667", Text = "...but an effective trick it is, I know." },
					},
				},
			},

			HecateAboutZeus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHecate02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0946", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, Lord Zeus requested {#Emph}prompt reports{#Prev}, his words, from you about the situation in the Underworld. He seemed a little frustrated. Asked me to let you know." },
				{ Cue = "/VO/Hecate_0262",
					Text = "And you're as dutiful as ever, aren't you? Exactly as Lord Zeus wants us to be. Think you he truly cherishes these Underworld reports?" },
				{ Cue = "/VO/Melinoe_0947", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... hadn't considered that he might not. He seems the sort to want to know about all goings-on, especially ones dangerous to him." },
				{ Cue = "/VO/Hecate_0263",
					Text = "Correct! He grows uneasy when the silence thickens. He'll get his prompt reports; though, just remember, he already {#Emph}has {#Prev}a messenger." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0219", Text = "Hm." },
					},
				},
			},

			HecateAboutArtemis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_1592", UsePlayerSource = true,
					Text = "Headmistress, I found Artemis out there. I'd not expected her so soon, but then, she's quick. Speaking of which, what of Hermes, any word?" },
				{ Cue = "/VO/Hecate_0417",
					Text = "Alas, not yet. However, those two are resourceful and discreet... and Olympus remains none the wiser to our long-standing connection with them, if that is your concern." },
				{ Cue = "/VO/Melinoe_1593", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My concern is their safety. May Hermes soon discover what exactly Chronos is scheming and return, though I know we can ill afford to wait." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0418", Text = "No, we cannot. Hermes convinced me of that." },
					},
				},
			},

			HecateAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossAboutHermes01", "HecateBossAboutHermes02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_1173", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes is back, Headmistress. He was able to lend some of his swiftness, and... also asked that I come to the aid of Olympus. Has the hour grown so desperate up there?" },
				{ Cue = "/VO/Hecate_0423",
					Text = "He would not ask otherwise. To be sure, this complicates the task. My view, however, is that you are not yet prepared for the surface. I'll not lift the wards barring that path." },
				{ Cue = "/VO/Melinoe_1174", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And if I were to lift them myself? I've seen you do it." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeAltRunDoor" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0424", Text = "Then you'll be more prepared than you are now." },
					},
				},
			},

			HecateAboutArachne01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutHecate02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3134", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Headmistress, there must be something we can do for Arachne. Her curse torments her. What use is our craft if we cannot ease a friend's suffering?" },
				{ Cue = "/VO/Hecate_0551",
					Text = "Arachne's fate is not yours to undo. 'Tis a matter between her and Athena. I suggest you leave it well alone." },
				{ Cue = "/VO/Melinoe_3135", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "How... did you know it was between her and Athena?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0552", Text = "I do not care for your insinuations, Melinoë." },
					},
				},
			},

			HecateAboutMedea01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2513", UsePlayerSource = true,
					Text = "I'd not expected Lady Medea to be stationed in Ephyra still, Headmistress. To think even a witch of her experience was unable to prevent the city's fall." },
				{ Cue = "/VO/Hecate_0588",
					Text = "It was not her responsibility to try. Medea was there to blend with the locals. It seems she's even more successful at it now, with most of them deceased. I trust she aided you in her own way?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2514", Text = "That she did, yes." },
					},
				},
			},
			HecateAboutMedea02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift02", "MedeaGift02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0589",
					Text = "How fares Medea on the surface lately from your point of view? Having a grand old time by her account, and Sister Selene seems to think the same! Perhaps I should not be surprised." },
				{ Cue = "/VO/Melinoe_2515", UsePlayerSource = true,
					Text = "Lady Medea does seem very much at home amid all the death and decay, which fuels her research. She's always toiling at one curse or another. Is that a concern?" },
				{ Cue = "/VO/Hecate_0590",
					Text = "My concern is only for her wellbeing, and it sounds as though she is all right for now. So long as her {#Emph}research {#Prev}does not come back to haunt her anytime soon." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2516", Text = "I'll be checking up on her." },
					},
				},
			},

			HecateAboutCirce01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Circe_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3464", UsePlayerSource = true,
					Text = "I found Circe the Enchantress on my route toward Olympus; or likely, she found me. She hasn't changed a bit from what I recall. You have her keeping watch over the seas?" },
				{ Cue = "/VO/Hecate_0661",
					Text = "That I do. Selene takes to water like a cat, whilst Circe hails from the sea. Thus has it been a good arrangement for a while. I trust Circe's work retains its potency?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3465", Text = "She's been great." },
					},
				},
			},
			HecateAboutCirce02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Circe_01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Circe_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutCirce01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0662",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					Text = "We have a bit of a personnel problem with our Circe the Enchantress. Her isle is poised to survey our enemy's fleet, reports of which ought go directly to Odysseus. Except they go to me." },
				{ Cue = "/VO/Melinoe_3466", UsePlayerSource = true,
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "A gap in communication. By your leave, Headmistress, I can notify her of the proper protocol when next we meet." },
				{ Cue = "/VO/Hecate_0663",
					PreLineAnim = "Hecate_Hub_Stern_End",
					Text = "You shall not speak of this to her at all. I raise the point so you can be aware. Circe has long been a valuable asset and ally. Your visits to her isle may help keep it that way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3467", Text = "Understood." },
					},
				},
			},

			HecateAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "GameState", "RoomCountCache", "F_Boss01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0037",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "You always reminded me of your father, Melinoë, but lately you remind me of your mother... more and more. The concern for others that you sometimes show... it can be an exploitable weakness." },
				{ Cue = "/VO/Melinoe_0154", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I would never put any such concerns ahead of the task, Headmistress." },
				{ Cue = "/VO/Hecate_0038",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "See that you don't! Although my remark was not intended as admonishment; it was my honor to have known your family... even if merely from the shadows." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0155", Text = "They'll be avenged." },
					},
				},
			},
			HecateAboutFamily02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0021",
					Text = "Vengeance for your family awaits you, far below. I'm certain they would be proud of what you have become. Bear them in your heart when you strike." },
				{ Cue = "/VO/Melinoe_0048", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I'll bear them in my heart but... I have no memory of them. How could I? You're the one who's always been there for me." },
				{ Cue = "/VO/Hecate_0022",
					Text = "{#Emph}Augh{#Prev}, don't say such things; I am {#Emph}not {#Prev}your mother, Melinoë. So much she could have taught you, I cannot. Never compare us." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0049", Text = "I... OK." },
					},
				},
			},

			HecateAboutFamilyPortrait01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2935" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "CrossroadsFamilyPortrait02" },
					},
					{
						Path = { "GameState", "UseRecord", "CrossroadsFamilyPortrait02" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3459", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "The family portrait in my tent... I have been thinking on it more and more, I... never asked you where you got it from." },
				{ Cue = "/VO/Hecate_0656",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "'Twould be stranger if you did, for the answer ought be obvious to you. Though, you would know the circumstances?" },
				{ Cue = "/VO/Melinoe_3460", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Yes, Headmistress, if you please. I know it was a time you would never wish to revisit, but it's important to me." },
				{ Cue = "/VO/Hecate_0657",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Of that I have no doubt. When Chronos stormed your father's House, I fled with but three things: Hypnos, because he was there; that family portrait, which pulled at my heart; and you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3461", Text = "Only the three...?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0658", Text = "I had but an instant, and I am threefold." },
					},
				},
			},

			HecateAboutWitchcraft01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = ">=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0279",
					Text = "With all your incanting as of late, I must needs caution you to not overextend. I know you want for every chant and glamour on the tip of your tongue, but they require space, and time." },
				{ Cue = "/VO/Melinoe_1017", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Using the cauldron doesn't drain me as once it did. Though I know I mustn't be reckless." },
				{ Cue = "/VO/Hecate_0280",
					Text = "Indeed, lest your fair {#Emph}right {#Prev}hand come to match your left. Although perhaps that boy-shade Icarus would fancy you more if that were so. Been gone awhile, hasn't he?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1018", Text = "He has..." },
					},
				},
			},
			HecateAboutCauldronWitchcraft01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with real requirement
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = ">=",
						Value = 15,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0599",
					Text = "Once you're quite finished with the cauldron for the eve, I may have need of it myself... protective charms to be refreshed, wards reinforced..." },
				{ Cue = "/VO/Melinoe_2526", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "If you've a certain incantation in mind, might I be able to assist? {#Emph}The Invocation of the Dead, Concealment in Night's Embrace{#Prev}, whichever..." },
				{ Cue = "/VO/Hecate_0600",
					Text = "You've your own matters to consider now, Melinoë. Though if you're here in the vicinity whilst I'm chanting, your voice is always welcome, joined with mine." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2527", Text = "Together we shine, Headmistress." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0580", Text = "{#Emph}Hmm." },
					},
				},
			},

			HecateAboutCauldron01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0215",
					Text = "I must say, you've been putting our old cauldron to good use. I see and sense the changes in this place. Changes for all our betterment, not just your own." },
				{ Cue = "/VO/Melinoe_0652", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A proper incantation is never to be used for selfish gain. Though, if I can help bring about positive change from which I benefit, isn't that selfish, still?" },
				{ Cue = "/VO/Hecate_0216",
					Text = "Discard such doubts as that. You are not thinking solely of yourself, thus you are not thinking selfishly. I've not taught you to neglect your needs, have I?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0653", Text = "Of course not." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0217", Text = "Then, good." },
					},
				},
			},

			HecateAboutArcana01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 14,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeCardUpgradeSystem" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0425",
					Text = "Returning from the shadows restores your body, whilst meditating at your Altar emboldens your spirit. Such knowledge in the ashes of the past." },
				{ Cue = "/VO/Melinoe_0658", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm still struggling to internalize the Arcana, Headmistress. If I share the same potential as my predecessors, why don't I feel a stronger bond?" },
				{ Cue = "/VO/Hecate_0426",
					Text = "Your bond can only be as strong as your understanding. One either learns from history or else repeats mistakes. I suggest the former." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0659", Text = "...I'll keep studying." },
					},
				},
			},
			HecateAboutArcana02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
					},
					{
						Path = { "GameState", "MetaUpgradeMaxLevelCountCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0406",
					Text = "You have been fixed upon your Altar even more than usual of late. Have the Arcana shown you aught of note?" },
				{ Cue = "/VO/Melinoe_1169", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm beginning to see the cards in a new light... each depicts a significant choice made in the past. Such knowledge may help make better choices in the future." },
				{ Cue = "/VO/Hecate_0407",
					Text = "Indeed. We choose as wisely as we can, using what knowledge we have. So you now clearer see into the {#Emph}cards{#Prev}, as you call them..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0596", Text = "Indeed." },
					},
				},
			},

			HecateAboutCardUpgradeSystem01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0649",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "I was curious to see if you would consecrate the Altar of Ashes on your own. It ought to be further attuned to you as a result; the secrets of the Arcana, nearer to your grasp." },
				{ Cue = "/VO/Melinoe_3453", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Altar is a threshold through which we all pass, going to and from these Crossroads. A gateway to the past, present, and future. I know it isn't mine alone; it's ours. " },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0650", Text = "Correct, on all three counts." },
					},
				},
			},

			HecateAboutResources01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0233",
					Text = "Have you been finding anything of use out there, in your forays? No point returning empty-handed. Though you may lack the necessary tools, I suppose." },
				{ Cue = "/VO/Melinoe_0660", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Erebus still teems with hidden life. I'm finding all sorts of things we need out there. I'm very grateful for the purse! It never weighs me down." },
				{ Cue = "/VO/Hecate_0234",
					Text = "A witch cannot afford to be encumbered. The blessings and such from your relatives may be fleeting, but whatever goes into that purse isn't going anywhere. Not till you use it, of course." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						-- { Cue = "/VO/Melinoe_0659", Text = "...I'll keep studying." },
					},
				},
			},
			HecateAboutResources02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = ">=",
						Value = 30,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MixerFBoss" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGarden" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_1022", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wanted to ask you something, Headmistress. All these reagents I've been gathering, taking from the earth. From Mother Gaia. How can I make it up to her?" },
				{ Cue = "/VO/Hecate_0287",
					Text = "Well, you can start by not wallowing in senseless guilt. Think you that Gaia would reveal her abundances to you if she believed you would not put them to good use?" },
				{ Cue = "/VO/Melinoe_1023", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But you taught me never to take more than I need. Now I'm taking everything in sight." },
				{ Cue = "/VO/Hecate_0288",
					Text = "And Gaia knows you'll need all that and more. Fear not, your plunder returns whence it came through your craft. If not your garden there." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0577", Text = "Mm!" },
					},
				},
			},
			HecateAboutResources03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 300,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 300,
					},
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = ">=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0289",
					Text = "You're frustrated, Melinoë. Why can't I simply furnish you with all of the reagents you require? So many incantations you could sooner cast..." },
				{ Cue = "/VO/Melinoe_1024", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know full well the answer, Headmistress. Your own reagents bring power to your craft, as my own do to mine. Only through the effort of their procurement do they gain their properties." },
				{ Cue = "/VO/Hecate_0290",
					Text = "Just so. At time 'tis quite the pain, admittedly. Yet what is our craft but making our intentions manifest? For which there can be no shortcuts." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1025", Text = "No shortcuts." },
					},
				},
			},

			HecateAboutFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0281",
					Text = "That indolent little amphibian whom you keep... did my eyes deceive, or did I see him hopping rather energetically toward the egress?" },
				{ Cue = "/VO/Melinoe_1019", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You saw it true! I've compelled little Frinos to join me in my attempts out there. Surely you've taught me wards and charms enough to keep a familiar safe?" },
				{ Cue = "/VO/Hecate_0282",
					Text = "One can but hope! And may your familiar keep {#Emph}you {#Prev}safe, in turn. And perhaps scrounge up some more roots and such for us." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0577", Text = "Mm!" },
					},
				},
			},
			HecateAboutFamiliars02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ToulaGift01" },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0283",
					Text = "A cat recently strutted clear into our grove, as though my wards of shadow weren't even there! Please tell me that's a new familiar of yours?" },
				{ Cue = "/VO/Melinoe_1020", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "That would be Toula, Headmistress, and yes! I figured I could use a confident and independent companion such as that." },
				{ Cue = "/VO/Hecate_0284",
					Text = "As can we all. The beasts whom you entrust are welcome here. Would that all our acquaintances were such a welcome sight..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0596", Text = "Indeed." },
					},
				},
			},

			HecateAboutFamiliars03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with real requirements
					{
						Path = { "GameState", "UseRecord", "CrossroadsPet01" },
						IsAny = { "CrossroadsPet01", },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2523", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "How fare Hecuba and Gale lately, Headmistress? They must be ill-at-ease with all of the bustle and new faces and the like." },
				{ Cue = "/VO/Hecate_0597",
					Text = "Oh, they're fine. The hound and polecat make strange bedfellows, but are able to withstand more than their share of hardship or discomfort. Especially when you lavish them with attention." },
				{ Cue = "/VO/Melinoe_2524", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "I'm sure to win their hearts one of these nights! Do you ever think they miss their former selves? Or are their transformations utterly complete?" },
				{ Cue = "/VO/Hecate_0598",
					Text = "Each of them I turned at her behest. Hecuba retains her regal poise, Gale her mischief. They relish one another's company; and ours." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2525", Text = "The feeling's mutual!" },
					},
				},
			},

			HecateAboutShades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "CurrentRun", "ExorcismSuccesses" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0235",
					Text = "The Shades about this place are all abuzz in their support of you, you know. You have a gift for leaving an impression on them. And for compelling more of them to join with us." },
				{ Cue = "/VO/Melinoe_0661", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They were just people once, or other living beings. All they ever needed was something to believe in, in death as well as life. And a way out of Erebus." },
				{ Cue = "/VO/Hecate_0236",
					Text = "{#Emph}Hm{#Prev}, well. They're sworn to you, that much is clear to me. I'd purge them all if I had any doubt! Perhaps they think they'll find a cushy spot within Elysium once all is said and done." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0662", Text = "I think it's more than that." },
					},
				},
			},

			HecateAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0146", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, if I may? What is it that you and Master Odysseus are planning? He's always with his charts and diagrams." },
				{ Cue = "/VO/Hecate_0031",
					Text = "Odysseus considers our plan of attack. {#Emph}Yours{#Prev}, more specifically. He plots a course from the nearest Underworld entrance to Olympus." },
				{ Cue = "/VO/Melinoe_0147", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The {#Emph}surface...? {#Prev}I am to attack {#Emph}Olympus? {#Prev}When? How?" },
				{ Cue = "/VO/Hecate_0032",
					Text = "{#Emph}Attack, defend... {#Prev}'tis all the same. Patience, Melinoë. As you observed, we are still... working through some of the details." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0148", Text = "But... {#Emph}mm." },
					},
				},
			},
			HecateAboutSurface02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutSurface03" },
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0586", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, if Olympus is besieged, then why am I not permitted on the surface? If I could aid the gods, then they could aid us even more!" },
				{ Cue = "/VO/Hecate_0218",
					Text = "Melinoë, however you complete the task is up to you; I have not barred you from the surface. But I caution, if you go, your strength shall fail you. Your birthright is to blame; no fault of yours." },
				{ Cue = "/VO/Melinoe_0587", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Born in the Underworld and here I'll stay, thank the Fates. I don't intend to live up there, I just.... Do you know how long I'd even have?" },
				{ Cue = "/VO/Hecate_0219",
					Text = "I know your brother and father had a day at best ere they could not stand it any longer. Perhaps you're different, but don't count on it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0588", Text = "A day at best...?" },
					},
				},
			},
			HecateAboutSurface03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0220",
					Text = "You visited the surface. I can't imagine {#Emph}that {#Prev}played out particularly well. At least you made it back at all." },
				{ Cue = "/VO/Melinoe_0589", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It was draining... even at night, something about being under the stars, I... didn't know there were so many. It was more than I could take. You were right." },
				{ Cue = "/VO/Hecate_0221",
					Text = "A lesson learned, and an experience gained. The Fates themselves do not want you up there. What shall you do?" },
				{ Cue = "/VO/Melinoe_0590", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have an incantation to complete. I don't need to stay forever on the surface... I just need to hold on long enough to make it to Olympus..." },
				{ Cue = "/VO/Hecate_0222",
					Text = "{#Emph}Ah{#Prev}, then you seek to improve this aspect of yourself, without rejecting it outright. I see how that may work..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0591", Text = "It has to..." },
					},
				},
			},

			HecateAboutSurfaceSurvival01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutSurface03" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0592", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Headmistress... Olympus seems reluctant to ask outright, but I can tell my family there needs me. I cannot shake the sense that I have to help them, before I can achieve our task." },
				{ Cue = "/VO/Hecate_0223",
					Text = "You needn't shake that sense, for it may well be accurate. Are you still thinking of an incantation that may help you to survive such a journey?" },
				{ Cue = "/VO/Melinoe_0593", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am. Up there, I'll be like a fish out of water, right? Suffocating. But with a proper incantation, I was thinking maybe I could hold my breath. Until Olympus is secure." },
				{ Cue = "/VO/Hecate_0224",
					Text = "Such a spell shall not be simple. Though, if you demonstrate that you're sufficiently well traveled, then... perhaps magick such as that shall help you go farther still." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0594", Text = "I'm counting on it." },
					},
				},
			},
			HecateAboutSurfaceSurvival02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "RoomCountCache", "N_Hub" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Hub" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_Boss01" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = ">=",
						Value = 6,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0225",
					Text = "Your recent travels to the surface. How were you able to survive up there? You were away for longer than I would have expected." },
				{ Cue = "/VO/Melinoe_0595", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "My surface-breathing incantation made a difference after all, Headmistress. I still felt the oppressive atmosphere up there, weighing down on me... but not crushing me quite like before." },
				{ Cue = "/VO/Hecate_0226",
					Text = "Magick born of your resolve. I'm impressed, though not entirely surprised. May your craft thus protect you ere Olympus is secure." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0596", Text = "Indeed." },
					},
				},
			},

			HecateAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0659",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					Text = "How fares the ever-sinking fleet of ships within the Rift of Thessaly? 'Tis a wonder Chronos gathered as many followers as he has, using such shoddily built craft." },
				{ Cue = "/VO/Melinoe_3462", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The fleet shows no real sign of slowing down. Fortunately, the same sorcery that seems to be holding those ships together lets me transfer quickly from one to the next. Are all surface ships so odd-looking?" },
				{ Cue = "/VO/Hecate_0660",
					PreLineAnim = "Hecate_Hub_Stern_End",
					Text = "I certainly think not. {#Emph}These {#Prev}are merely emblematic of the Titan's false promises of a new age. They assault not just Olympus but our sensibilities as well." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3463", Text = "We'll fight them off." },
					},
				},
			},

			HecateAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomCountCache", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomCountCache", "H_Intro" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0514",
					Text = "'Tis fortunate your father's realm is vast indeed, that you may circumnavigate it at the edge of Oceanus, where our enemy is relatively weak." },
				{ Cue = "/VO/Melinoe_1027", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If we cannot pass directly through Elysium, then we shall make what way we can. Though the fiends that lurk the border of the sea care not for my presence." },
				{ Cue = "/VO/Hecate_0515",
					Text = "God-hating monsters with salt in their veins; the seas covering the world's surface just were not enough for them. The sunken chambers they occupy have not yet fallen to Chronos, at least." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- { Cue = "/VO/Melinoe_1028", Text = "Then through I'll go." },
					},
				},
			},

			HecateAboutChronosAnomaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronos01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2517", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I saw him. Chronos! First beyond Erebus, in the guise of an old man. He then attempted to ensnare me in some vision out of time... the river of flame, everything ablaze..." },
				{ Cue = "/VO/Hecate_0591",
					Text = "Still your heart, Melinoë, you're safe. And you were able to return again, which means that all your training served you well.... So then... he realizes who you are?" },
				{ Cue = "/VO/Melinoe_2518", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So he claims. I broke free from his spell like it was second-nature, but... neither could I raise a hand against him. What must I do now?" },
				{ Cue = "/VO/Hecate_0592",
					Text = "Nothing has changed; you're to confront him down where he resides. Where your mother and father rightly ought to be. But go with patience, not with haste. He may know something of your power now, yet not enough." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2519", Text = "Yes, Headmistress." },
					},
				},

			},

			HecateAboutChronosAnomaly02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2164", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The influence of Chronos is much stronger in Oceanus than here. He attempted to ensnare me in a vision of another time. A field of flame." },
				{ Cue = "/VO/Hecate_0537",
					Text = "Yet you were able to elude his grasp. An aspect of your condition we expected would come into play as you pushed closer to our foe. Continue with still-greater caution, nonetheless..." },
			},

			HecateAboutTimeStop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeTimeStop" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "H_Intro" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0636",
					Text = "Those Sands that you recovered from our enemy. They've something of his nature in each tiny grain. A key of sorts, to the Dissolution of Time. Do you concur?" },
				{ Cue = "/VO/Melinoe_2912", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I do. That very incantation sprang to mind... an expression of all you taught me of his weaknesses. A means to unravel his very being... to bring death to Chronos at last. He doesn't seem to realize it's possible... still thinks I'm just an agent of Olympus." },
				{ Cue = "/VO/Hecate_0637",
					Text = "'Tis merely evidence that our concerted efforts have not been in vain. You cross the Underworld like a tempest, whilst I remain in shadows. But, when the Titan's time at last comes to an end, I {#Emph}dearly {#Prev}wish to be there myself. To see the look on his face." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2913", Text = "We'll get him, Headmistress..." },
					},
				},
			},

			HecateAboutWeapons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update to make this not play after enough weapons unlocked
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
					{
						Path = { "GameState", "WeaponsTouched" },
						UseLength = true,
						Comparison = "<=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0229",
					Text = "The Nocturnal Arms are beginning to awaken. May we yet see an age when they can slumber once again. Have you a favored sister yet among the lot?" },
				{ Cue = "/VO/Melinoe_0656", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am grateful that the weapons of Night have accepted me. I intend to treat them equally, Headmistress." },
				{ Cue = "/VO/Hecate_0230",
					Text = "A commendable approach, but not a necessary one. The Nocturnal Arms share our purpose. They care little as to which of them you use, only that the task is completed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0657", Text = "We'll see it through." },
					},
				},
			},

			HecateAboutAspects01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { 
							"StaffClearCastAspect",
							"StaffSelfHitAspect",
							"DaggerBlockAspect",
							"DaggerHomingThrowAspect",
							"TorchDetonateAspect",
							"TorchSprintRecallAspect",
							"AxeArmCastAspect",
							"AxePerfectCriticalAspect",
							"LobCloseAttackAspect",
							"LobImpulseAspect",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0595",
					Text = "So, the Arms of Night have revealed to you some of their former selves; or future selves, perhaps. Few have earned the right to bear such weapons. Much less take advantage of their different likenesses!" },
				{ Cue = "/VO/Melinoe_2521", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The various Aspects I've discovered... some of the bearers I know well. Medea, Artemis... they're all connected to {#Emph}you{#Prev}, aren't they?" },
				{ Cue = "/VO/Hecate_0596",
					Text = "'Tis not as simple as you may presume... you bear a set of artifacts whose aim is to safeguard the Underworld. Each Aspect is of somebody who played a part in this, or shall." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_2522", Text = "It seems I'm in good company..." },
					},
				},
			},

			HecateLostAgainstHer01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Boss01", },
					},
					{
						PathFalse = { "CurrentRun", "RoomCountCache", "F_PostBoss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossOutro01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0023",
					Text = "Melinoë. I held back against you out there. And even still, you could not surpass me. Do you know why?" },
				{ Cue = "/VO/Melinoe_1032", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...I know I can grow stronger still, but... it's my lack of knowledge that betrayed me in the end. Some of your many tricks I've yet to learn." },
				{ Cue = "/VO/Hecate_0297",
					Text = "Correct! Strength; knowledge; patience. When faced with a seemingly indomitable adversary, all three are required. Or a stroke of fate..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1033", Text = "I'll count on the former." },
					},
				},
			},
			HecateLostAgainstHer02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Boss01", },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0197",
					Text = "I thwarted you again out there. 'Tis unfair, I know. I arrive fresh as rain in anticipation of our clash, whilst you may already be battle-worn." },
				{ Cue = "/VO/Melinoe_0655", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fairness is a luxury, Headmistress. Though, I do sometimes envy your ability to travel such long distances in an instant." },
				{ Cue = "/VO/Hecate_0198",
					Text = "Do not be quick to envy what you do not understand. Along your path are to be found resources and reagents we require. And if you cannot get past me, then you are unprepared for what awaits beyond." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- I understand.
						-- { Cue = "/VO/Melinoe_0053", Text = "I understand." },
					},
				},
			},
			HecateWonAgainstHer01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Hecate" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0025",
					Text = "You have gone far, Melinoë, and you bested me. Gave me quite a scrape, at that! There is much left to be done. But, you are learning." },
				{ Cue = "/VO/Melinoe_0054", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "Thank you, Headmistress. Although, I know that I could not have bested you had you held nothing back." },
				{ Cue = "/VO/Hecate_0026",
					Text = "You {#Emph}know? {#Prev}Why do you self-impose such limits on your capability? {#Emph}Alter your thoughts{#Prev}. I shall see you again out there." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0585", Text = "Yes, Headmistress." },
					},
				},
			},
			HecateUnderworldRunCleared01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0408",
					Text = "You prevailed in your attempt; but our enemy is Time itself, and 'twould seem that he is not prepared to abdicate his stolen throne as yet." },
				{ Cue = "/VO/Melinoe_2901", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "{#Emph}Prevailed{#Prev}, sure. And yet, I feel as though I've come no closer to achieving our true goal. My task, sometimes I fear... it's impossible." },
				{ Cue = "/VO/Hecate_0409",
					Text = "Impossibility tends to be transient. Time would wear us down; but with patience, we can withstand him until our night arrives at last." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1799", Text = "Patience, then..." },
					},
				},
			},

			HecateAboutBeasts01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0144", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, have you always been so fond of beasts? It seems you would do anything for each other." },
				{ Cue = "/VO/Hecate_0029",
					Text = "Beasts... saddled with such an uncharitable name. Beasts are far more trusting than most any mortal or immortal I have met." },
				{ Cue = "/VO/Melinoe_0145", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They make it seem so simple, don't they? To fully trust." },
				{ Cue = "/VO/Hecate_0030",
					Text = "One knows where she stands with beasts, whether she is loved by them or doomed to sate their hunger. Would that the gods were so dependable." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						-- I'll do my best.
						-- { Cue = "/VO/Melinoe_0047", Text = "I'll do my best." },
					},
				},
			},
			HecateAboutWellness01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},				
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0018",
					PreLineAnim = "MelTalkLookingDown01", PreLineAnimTarget = "Hero",
					Text = "You look unwell. Returning is difficult, I know. Tell me if you need anything." },
				{ Cue = "/VO/Melinoe_0050", UsePlayerSource = true,
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think I'm all right, thank you, Headmistress. How do you manage it when you are out of sorts?" },
				{ Cue = "/VO/Hecate_0005",
					Text = "Oh I've a draught for every mood, and more. Sorrow, pain, anxiety, love-sickness, dispassion, rage, fear, nausea, cowardice... all sensations one can rectify, whether with mental fortitude or, failing that, a potent drink." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0051", Text = "Perhaps some other time." },
					},
				},
			},

			HecateAboutRelationships01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisGift06", "NemesisBathHouse02", "MorosGift06", "MorosBathHouse02" },
					},
					{
						Path = { "PrevRun", "UseRecord" },
						HasAny = { "NPC_Moros_01", "NPC_Nemesis_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0664",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					Text = "You have a flush about you I could see as you approached! No need to tell me of its source, if you prefer to keep whomever it is to yourself." },
				{ Cue = "/VO/Melinoe_3472", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Whomever it is{#Prev}, Headmistress? Could it not have been the product of a balmy night, or lingering effect of my return?" },
				{ Cue = "/VO/Hecate_0665",
					PreLineAnim = "Hecate_Hub_Stern_End",
					Text = "Unlikely. Look, Melinoë, I was much like you once. I've said to you before that feelings mustn't be ignored. Heed the ones that spur you on, they're good! Confront the rest." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3473", Text = "Plenty of each..." },
					},
				},
			},

			HecateAboutCrossroads01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},				
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0644",
					Text = "Grow not attached to such a place as this; you belong within the luxury of your great father's House." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1667", Text = "As you say, Headmistress..." },
					},
				},
			},

			OdysseusWithHecate01 =
			{
				Partner = "NPC_Odysseus_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},
			OdysseusWithHecate02 =
			{
				Partner = "NPC_Odysseus_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				InitialGiftableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
			},
			CharonWithHecate01 =
			{
				Partner = "NPC_Charon_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				InitialGiftableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
			},
			NemesisWithHecate01 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
			},
			SeleneWithHecate01 =
			{
				Partner = "NPC_Selene_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
			},

			-- Repeatable
			HecateChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0002",
					Text = "May moonlight guide you on your path and blind your enemies." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0063",
					Text = "{#Emph}Death to Chronos." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0014_V3", Text = "Death to Chronos." },
					},
				},
			},
			HecateChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0042",
					Text = "...heart of wormwood, earth-apple, spider silk, wax-stone..." },
			},
			HecateChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0043",
					Text = "...mulberry, snake fang, sage blossom, scorpion-tail..." },
			},
			HecateChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0044",
					Text = "Continue your task. Our enemy is distracted." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0045",
					Text = "May you cast a tall shadow in the light of the Moon." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0046",
					Text = "I leaden your foes with the weight of my curse. So mote it be." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat08 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0047",
					Text = "You have returned to us, as has your strength. Go use it well." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat09 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0048",
					Text = "I know your task is difficult, and also know you have it in you to succeed." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat10 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0049",
					Text = "Push yourself hard, Melinoë, but do not break." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0050",
					Text = "Our enemy is distracted. Find him, and strike him down." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat12 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0051",
					Text = "You learn and grow each time that you set out. Continue on." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0156",
					Text = "Proceed at pace. No task of any consequence can be completed without effort." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat14 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0157",
					Text = "Much left to do both on the surface and below..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat15 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0158",
					Text = "We witches oft are underestimated. But I am well aware how capable you are." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat16 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0159",
					Text = "Chronos is old enough to think that he has nothing left to learn, the utter fool." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0160",
					Text = "Your power hinges on your confidence. Do not allow yourself to falter." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat18 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0161",
					Text = "Recover as you must. Returning thus is not a backward step." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hecate",
				{ Cue = "/VO/Hecate_0162",
					Text = "Do not relent, Melinoë. Our enemy most certainly shall not." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
			},
			HecateChat20 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0163",
					Text = "...moly petal, cypress leaf, mandrake root, quartz dust, garlic..." },
			},
			HecateChat21 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0164",
					Text = "...moon-water, nettle, beetle-shell, nightshade..." },
			},
			HecateChat22 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Hecate_0165",
					Text = "...willow bark, sulfur, wing of bat, onion-skin..." },
			},

		},

		GiftTextLineSets =
		{
			HecateGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
				},
				{ Cue = "/VO/Melinoe_0663", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, if it isn't inappropriate, I have a little gift. Seeing as your personal supply ran out a while back?" },
				{ Cue = "/VO/Hecate_0457",
					Text = "{#Emph}Ah{#Prev}, the hounds shall lap this stuff right up I think! I shall safeguard it for them as a treat. And why don't you hold onto {#Emph}this{#Prev}, in kind?" },
			},
			HecateGift02 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift01" },
					},
				},
				{ Cue = "/VO/Hecate_0041",
					Text = "Oh, come, Melinoë, you need not influence me with such gifts. We have a task. Let us stay focused on it, no?" },
				{ Cue = "/VO/Melinoe_0501", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You have taught me to apply myself to many things at once, Headmistress. Why can't I stay on task while paying my respects?" },
			},
			HecateGift03 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift02" },
					},
				},
				{ Cue = "/VO/Hecate_0538",
					Text = "{#Emph}Eh{#Prev}, well... I do have a bit of a taste for this stuff, I suppose. I once traveled much more often, to places where 'tis easier to procure. Perhaps you sensed in me some wistfulness about that." },
				{ Cue = "/VO/Melinoe_0500", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've learned from you, Headmistress. So, this is just a small token of my gratitude." },
			},
			HecateGift04 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift03" },
					},
				},
				{ Cue = "/VO/Hecate_0539",
					Text = "Whilst I appreciate the gesture, and the drink, 'tis entirely unneeded on your part. Have I not conditioned you to resist the temptations of unspoken contracts such as this?" },
				{ Cue = "/VO/Melinoe_0664", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know not to expect anything in return, Headmistress. The act of giving needs to be sufficiently rewarding in itself. And please believe me that it is, with you." },
			},
			HecateGift05 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift04" },
					},
				},
				{ Cue = "/VO/Hecate_0458",
					Text = "I've little taste for the traditions of the gods, you know. Lest you forget, I am a Titaness. More in common with our enemy I daresay, than with the likes of Zeus and his ilk." },
				{ Cue = "/VO/Melinoe_2166", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No matter your heritage, Headmistress, you have been a sure and steady guardian of mine throughout my life. A bit of tradition helps express the gratitude I feel." },
				{ Cue = "/VO/Hecate_0459",
					Text = "Tradition is all well and good lest 'tis followed blindly; senselessly, I should say, for the blind are often very much aware. But let me not belabor your kind gesture; I am grateful, truly." },
			},
			HecateGift06 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift05" },
					},
				},
				{ Cue = "/VO/Hecate_0540",
					Text = "I thought I said you needn't curry favor with me thus. I shall take this bottle, nonetheless; if but to penalize you for not offering it up instead to someone more deserving of your affection." },
				{ Cue = "/VO/Melinoe_2167", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can think of no one else I would rather have this than you, Headmistress. You've made me the goddess I am, and not a night goes by that I'm not grateful for it." },
				{ Cue = "/VO/Hecate_0541",
					Text = "How often must I say, I'm not your mother, Melinoë. You needn't lavish me with such unbridled praise. I raised you to destroy our common foe. You owe no gratitude to me." },
				{ Cue = "/VO/Melinoe_2168", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've often said, what we intend and what we do are not the same. I know you're not my birthmother, so what? You've cared for me; that's more than enough." },
				{ Cue = "/VO/Hecate_0542",
					Text = "I've used you, and I'm using you still. Can't you see that? I've attempted not to hide this fact from you. Yet you turn it aside." },
				{ Cue = "/VO/Melinoe_2169", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You have raised me in accordance with the promises you made to my father. He never asked you to coddle me, did he? Surely he wanted me to fend for myself." },
				{ Cue = "/VO/Hecate_0543",
					Text = "And do you think you can? You remain under my auspices, take aid from Olympus! You're not as independent as I planned. And furthermore, I've inadvertently caused you to think I've made you better off!" },
				{ Cue = "/VO/Melinoe_2170", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I believe you have. I know no other way. It fills me with sorrow, knowing you feel undeserving of the love I have for you." },
				{ Cue = "/VO/Hecate_0544",
					PreLineWait = 0.35,
					PreLineAnim = "HecateHubGreet",
					Text = "...Set your sorrow well aside for now. I'll drink your Nectar and enjoy it, if you please." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2171", Text = "I would." },
					},
				},
			},

			-- placeholder
			HecateGiftTemp =
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

			HecateFishing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				OnGiftTrack = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift03" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_0669", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					Text = "The Cocytus teems with life there by the riverbank again, Headmistress. Would you please join me for a look?" },
				{ Cue = "/VO/Hecate_0378",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					Text = "{#Emph}Ah{#Prev}, very well, why not! I suppose I could use a little walk, and we could use the fish." },

				{ Cue = "/VO/Hecate_0651",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					PreLineWait = 0.35,
					Text = "...'Twas not very long ago that you never would have permitted yourself this type of excursion. Nor had the mettle to request that I accompany you." },

				{ Cue = "/VO/Melinoe_3454", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Headmistress, you're right. I could be hunting for our enemy this very moment, and you... you've so many responsibilities, yet I'm wasting your time. This was a mistake." },

				{ Cue = "/VO/Hecate_0652",
					SkipContextArt = true,
					Text = "Hold, lest you frighten the river denizens; only {#Emph}then {#Prev}should my time be wasted here, Melinoë! You mistook the meaning of my words. Your capacity to still your racing mind is not a detriment. It is a growing strength!" },

				{ Cue = "/VO/Melinoe_3455", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I'm... surprised you see it that way. Sometimes I feel I'm losing my focus. Why else would I have brought us here? " },

				{ Cue = "/VO/Hecate_0653",
					SkipContextArt = true,
					Text = "Perhaps you reasoned that we each need occupy our minds with other matters for a little while. And we are failing at it by continuing to speak! Let us be still together and direct our focus on the waters there.",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Hecate_0396",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash" },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "The river always provides, and let no such task ever be beneath us." },
			},

			HecateBathHouse01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift02" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0665", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I was wondering if you might accompany me to the springs for a short while? If you're not overly preoccupied?" },
				{ Cue = "/VO/Hecate_0240",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}Eugh{#Prev}, well, I do believe I could use a bit of a soak. I've more knots in my back than that tree! Let's be quick about it, then." },
				{ Cue = "/VO/Hecate_0250",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "{#Emph}Ah{#Prev}, but this is all right. Thank you for replenishing these waters! One of those details I had been meaning to get to, but... alas."
				},
				{ Cue = "/VO/Melinoe_0670", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "You're very welcome, Headmistress. I appreciate your saying so, as I half-thought you would admonish me for using magick and resources on this sort of thing." },
				{ Cue = "/VO/Hecate_0251",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "Magick mostly {#Emph}is {#Prev}for self-improvement, Melinoë. Not a shortcut, mind you. And if an occasional scalding-hot soak in the springs isn't self-improvement, then my concept of it must be very flawed." },
				{ Cue = "/VO/Melinoe_0671", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I wish I could bring myself to relax. I feel like I'm wasting precious time while I'm here." },
				{ Cue = "/VO/Hecate_0252",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, GlobalVoiceLines = "HotSpringsBathVoiceLines" },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Time spent being good to oneself is never wasted... unless you overthink it overmuch! We are {#Emph}here. {#Prev}Seize the moment, ere it passes." },
				{ Cue = "/VO/Hecate_0257",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					-- Emote = "PortraitEmoteSparkly",
					Text = "A shame we cannot cook indefinitely in those springs, but... a brief dip is better than none at all." },
			},
			HecateBathHouse02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift05" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0667", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was thinking of putting these purifying salts to use, Headmistress. Call it a cleansing ritual. Would you accompany me?" },
				{ Cue = "/VO/Hecate_0241",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "A visit to the springs ought rid us of unwanted thoughts for a while. Let us be cleansed together, then." },
				{ Cue = "/VO/Hecate_0244",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "{#Emph}Mm. {#Prev}We're like two nettles boiling in a cauldron, aren't we?"
				},
				{ Cue = "/VO/Melinoe_0673", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "I remember bathing in this spring when I was very small. You would ask me never to splash your hair, and I would do it anyway. You were so tolerant of me." },
				{ Cue = "/VO/Hecate_0253",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "Well, now at least you know the reason that your training was so rigorous! There came a point where even my vast tolerance for all your splashing finally wore thin." },
				{ Cue = "/VO/Melinoe_0674", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Wait... you trained me to the height of my ability as a witch because I got your hair wet?" },
				{ Cue = "/VO/Hecate_0254",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "{#Emph}Mm{#Prev}, was either that, or transform you into a newt, or something! Come off it, Melinoë. You are entirely too serious, sometimes." },
				{ Cue = "/VO/Melinoe_3471", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "{#Emph}Heh. {#Prev}A lesson I've been unable to take to heart, Headmistress. I suppose it's been a while since we talked like this." },
				{ Cue = "/VO/Hecate_0255",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "Yes, well, that's growing up for you. And present circumstances haven't helped, either. This blasted hot-spring got all covered up with moss and had been stagnant, I don't know how long. Being here again... it takes me back." },
				{ Cue = "/VO/Melinoe_0676", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Do you think we'll be able to keep the moss from reclaiming this place again?" },
				{ Cue = "/VO/Hecate_0256",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "I'll watch the moss, you watch the splashing. Deal?" },
				{ Cue = "/VO/Hecate_0258",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					-- Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Whew! {#Prev}Much better. Sometimes I think that hot-spring could raise the dead." },
			},
			HecateBathHouseDecline01 =
			{
				PlayOnce = true,
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
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},				
				{ Cue = "/VO/Melinoe_0668", UsePlayerSource = true,
					Text = "I know it's a difficult time, Headmistress, but just in case, would you be interested in joining me for a brief while at the hot springs?" },
				{ Cue = "/VO/Hecate_0239",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "As much as I would enjoy basking in the springs, I've incantations to complete, wards to reinforce.... No, I cannot. Not now." },
			},

			HecateFishingDecline01 =
			{
				PlayOnce = true,
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
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
					{
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},
				{ Cue = "/VO/Melinoe_0395", UsePlayerSource = true,
					Text = "Care to accompany me to the riverside?" },
				{ Cue = "/VO/Hecate_0260",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "I do wish to see firsthand whether your skill at fishing has improved, yet unfortunately I have other matters that I must attend to now." },
			},

		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				-- Flashback special case handled in TreeOfLife01 in DeathLoopData
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					GameStateRequirements =
					{
						AreIdsNotAlive = { 556921 },
					},

					{ Cue = "/VO/Melinoe_1725", Text = "Headmistress is away.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1726", Text = "No sign of Headmistress." },
					{ Cue = "/VO/Melinoe_1727", Text = "Where are you, Headmistress..." },
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Hecate_01",
			CooldownTime = 7,

			-- Pathetic.
			-- { Cue = "/VO/Hades_0050", Text = "Pathetic." },
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1148", Text = "Your Silver Wheel? I can have this?" },
		},
	},
	-- Hecate, story version; id = 583639
	NPC_Hecate_Story_01 =
	{
		InheritFrom = { "NPC_Hecate_01" },
		GenusName = "NPC_Hecate_01",

		ActivateRequirements =
		{
			--
		},

		InteractTextLineSets =
		{
			HecateHideAndSeek01 =
			{
				PlayOnce = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				AngleTowardHero = true,
				UseText = "UseCatchNPC",
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateHiding01,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},
				EndFunctionName = "HecateHideAndSeekExit",
				EndFunctionArgs = { WaitTime = 0.5, TeleportId = 583640, },
				
				{ Cue = "/VO/Melinoe_2120", UsePlayerSource = true,
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Emote = "PortraitEmoteFiredUp",
					Text = "Got you, Hecate!! You're dead!" },
				{ Cue = "/VO/Hecate_0516",
					PreLineAnim = "Hecate_Hub_Hide_End",
					PostLineFunctionName = "UpdateHubMainFlashback",
					--PostLineThreadedFunctionName = "HecateHideAndSeekExit", PostLineFunctionArgs = { WaitTime = 0.5, TeleportId = 583640, },
					Text = "{#Emph}Haha{#Prev}, got me you did, Melinoë. But I daresay I can escape your clutches yet!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2121", Text = "Hey...!" }
					},
					{
						PreLineWait = 2,
						ObjectType = "NPC_Hecate_Story_01",
						{ Cue = "/VO/Hecate_0522", Text = "{#Emph}Awooo..." },
					},
					{
						PreLineWait = 1,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2112", Text = "Can't hide from me...!" },
						-- { Cue = "/VO/Melinoe_2111", Text = "I'll find you yet...!" },
					},
				},
			},
			HecateHideAndSeek02 =
			{
				PlayOnce = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				AngleTowardHero = true,
				UseText = "UseCatchNPC",
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateHiding02,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},
				EndFunctionName = "HecateHideAndSeekExit",
				EndFunctionArgs = { WaitTime = 0.5, TeleportId = 583642, },
				
				{ Cue = "/VO/Melinoe_2122", UsePlayerSource = true,
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Emote = "PortraitEmoteFiredUp",
					Text = "There you are! Got you again!" },
				{ Cue = "/VO/Hecate_0517",
					PreLineAnim = "Hecate_Hub_Hide_End",
					Emote = "PortraitEmoteFiredUp",
					--PostLineThreadedFunctionName = "HecateHideAndSeekExit", PostLineFunctionArgs = { WaitTime = 0.5, TeleportId = 583642, },
					Text = "{#Emph}Aah! {#Prev}So persistent! Give up already, Witch! For I'm a Titaness! {#Emph}You {#Prev}cannot vanquish {#Emph}me!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.8,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2123", Text = "I can, and shall!" },
					},
					{
						PreLineWait = 2,
						ObjectType = "NPC_Hecate_Story_01",

						{ Cue = "/VO/Hecate_0525", Text = "{#Emph}<Chuckle>" },
					},
				},
			},
			HecateHideAndSeek03 =
			{
				PlayOnce = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				AngleTowardHero = true,
				UseText = "UseCatchNPC",
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateHiding03,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},
				
				{ Cue = "/VO/Melinoe_2124", UsePlayerSource = true,
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Emote = "PortraitEmoteCheerful",
					SecretMusic = "/EmptyCue",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Child_02", WaitTime = 3.5 },
					Text = "{#Emph}Hahaha{#Prev}, I {#Emph}got {#Prev}you!! ...Hecate...? What's the matter?" },
				{ Cue = "/VO/Hecate_0518",
					PreLineAnim = "Hecate_Hub_Hide_End_Short",
					PreLineWait = 0.5,
					Text = "...{#Emph}Ah{#Prev}, it's merely that... {#Emph}tsk{#Prev}, I've not heard your laughter before. Reminded me of your mother! A much preferable sound to that of grief." },
				{ Cue = "/VO/Melinoe_2343", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_02",
					PreLineAnim = "Melinoe_Young_Brooding_Start", PreLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Text = "I promise not to cry again! I still get sad sometimes, but not as much..." },
				{ Cue = "/VO/Hecate_0519",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Do not make promises you cannot keep. When tears well up, let them spill forth; they're not so precious that they need be contained." },
				{ Cue = "/VO/Melinoe_2126", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_02",
					PreLineAnim = "Melinoe_Young_Brooding_End", PreLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Text = "But you never cry, Hecate! And I wish to become strong, like you! So that I might find Chronos, and destroy him for what he's done. And then you could hear my mother's laugh again!" },
				{ Cue = "/VO/Hecate_0520",
					PreLineAnim = "HecateHubGreet",
					Text = "And I shall do everything in my power to prepare you, so that you may succeed where I failed. If not for your family's sake, then for your birthright... as the Princess of the Underworld." },
				{ Cue = "/VO/Melinoe_2344", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Child_02",
					PreLineAnim = "Melinoe_Young_Pensive_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Pensive_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Text = "What do you mean you failed? You tried to beat Chronos yourself? He hurt you?" },
				{ Cue = "/VO/Hecate_0521",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					PreLineWait = 0.5,
					PostLineThreadedFunctionName = "ConcludeFlashback",
					Text = "Concern yourself with your own pain, not mine. Destroying Chronos shall not change the past, and the pain shall linger, though assert itself less frequently with age... but enough of this! On the morrow, we shall teach you to hunt greater prey." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						PreLineAnim = "Melinoe_Young_Excited_Start",
						{ Cue = "/VO/Melinoe_2128", Text = "{#Emph}<Gasp> {#Prev}Truly?" },
					},
				},
			},

		}
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hecate )