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
		EmoteOffsetY = -280,
		EmoteOffsetX = 50,
		SpeakerName = "Hecate",
		LoadPackages = { "Hecate" },
		FieldSpeakerName = "HecateField",
		TavernaTeleportId = 741484,
		SpeechParams =
		{
			Radius = 0,
		},

		ActivateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "HecateHideAndSeek01", "FatesEpilogue01" },
			},
			-- @ ending
			NamedRequirementsFalse = { "HecateMissing" },
		},

		PreBathAnimationName = "HecateHubGreet",
		PreBathOffsetY = 50,
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
				{ Cue = "/VO/Melinoe_5299", Text = "Be well, Hecate.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HecateAboutSayingLittle01" },
						},
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "HecateAboutSayingLittle01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_5164", Text = "Be well, Hecate.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "HecateFishing02" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.36,
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
							IsAny = { "/VO/Melinoe_1706", "/VO/Melinoe_5164" },
						},
					},
				},
				{ Cue = "/VO/Hecate_0867", Text = "And you.",
					PreLineAnim = "Hecate_Hub_Salute",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5299" },
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
				{ Cue = "/VO/Hecate_0192_02", Text = "{#Emph}Hear me, Shades of the dead, and listen well,",
					PlayedThreadedFunctionName = "CauldronCastingJoinInVoiceLines",
					PlayedThreadedFunctionArgs =
					{
						VoiceLines =
						{
							{ Cue = "/VO/Melinoe_2466", Text = "{#Emph}Hear me, Shades of the dead, and listen well," },
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
			-- alt below
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

				{ Cue = "/VO/Hecate_0725",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					-- PreLineAnim = "Hecate_Hub_Explaining_Start",
					-- PostLineAnim = "Hecate_Hub_Explaining_End",
					-- PreLineAnim = "Hecate_Hub_Stern_Start",
					-- PostLineAnim = "Hecate_Hub_Stern_End",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "Time forced our hand, Melinoë. Nary a soul expected you to slay our enemy last night, on a new moon, no less!" },
				{ Cue = "/VO/Melinoe_2906_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					--[[
					Portrait = "Portrait_Mel_Intense_01",
					Portrait = "Portrait_Mel_Hesitant_01",
					Portrait = "Portrait_Mel_Proud_01",
					Portrait = "Portrait_Mel_Empathetic_01",
					Portrait = "Portrait_Mel_Casual_01",
					]]--
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I lack such forgiveness for my failure, Headmistress Hecate. The Titan yet lives, and Olympus yet burns, while I'm back where I started!" },
				{ Cue = "/VO/Hecate_0726",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Yes; recovered bodily if not in spirit, and grown wiser for it. You've not failed... merely begun! This is all part of the task. {#Emph}Death to Chronos." },
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
					Text = "You needed to ensure I was prepared. And I know there is much left to prove." },
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
						PathTrue = { "CurrentRun", "BiomesReached", "H" }
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
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
					},
					{
						-- PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0529",
					Text = "Much is expected of you. The pressure that you feel; you never speak of it, and yet full well I know it's there. Your constant companion." },
				{ Cue = "/VO/Melinoe_2133", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I can hardly distinguish between pressure and faith anymore. My entire life has led to this, and all of you are counting on me. Are you truly so certain in my inevitable success, Headmistress?" },
				{ Cue = "/VO/Hecate_0530",
					Text = "Pressure and faith are intertwined, 'tis true. Ever in conflict. Should the pressure utterly prevail, out comes despair. Only then do we truly falter." },
				{ Cue = "/VO/Melinoe_2134", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
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
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Max = 6 },
					},
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
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						Value = 35,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0273",
					Text = "Have you had opportunity to glean much from the Book of Shadows yet, Melinoë? Our task shall take you far beyond these Crossroads; you've much to learn as yet." },
				{ Cue = "/VO/Melinoe_1011", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
			HecateAboutCodex02 =
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
						Value = 130,
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_5287", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The Book of Shadows... I wasn't always certain who the author was. I suspected it was you, the way it sometimes anticipated my own thoughts before they were fully formed." },

				{ Cue = "/VO/Hecate_0848",
					Text = "You weren't entirely correct, though were on to something as to why the author understood your thoughts so well. 'Tis quite an old book... do take care of it for me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5288", Text = "I swear I will." },
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
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossAboutFates01" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisAboutTraining01", "NemesisGift02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_0152", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "This task... why does it fall solely to me, Headmistress? Because, Nemesis, she..." },
				{ Cue = "/VO/Hecate_0035",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "{#Emph}She {#Prev}is a burden. Had I not sworn to Nyx that I would watch over her children, I'd have cast her out for insubordination long ago." },
				{ Cue = "/VO/Melinoe_0153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She's frustrated you haven't given her a chance. Her strength far surpasses mine and she's trained at least as hard; I've seen it!" },
				{ Cue = "/VO/Hecate_0036",
					PreLineAnim = "Hecate_Hub_Scoff",
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

			HecateAboutHypnosWakeUp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0853",
					Text = "Hypnos certainly left in a hurry. It took you longer to wake him than I initially surmised, but 'twas for the best." },

				{ Cue = "/VO/Melinoe_5292", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, you {#Emph}knew {#Prev}this would happen? Why didn't you say anything for all the times I tried to break him out of his slumber? I thought you were ignoring him." },

				{ Cue = "/VO/Hecate_0854",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Oh I was, after I saw that you had learned sufficiently. Your affinity toward dreams and the like proved necessary to the task, and Hypnos, in his way, was an accessory to that." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5293", Text = "You brought him here for me to practice on?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0855", Text = "He did require a place to stay." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "Chaos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2914", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Last night, Headmistress, I traversed a gate that led me to the depths of Chaos... where I met its host! I've heard so much from you of Nyx, yet somehow I never expected to meet her mother and father." },
				{ Cue = "/VO/Hecate_0638",
					Text = "An audience with Primordial Chaos... I'd not entirely expected that! Although given Nyx herself has not been seen since Chronos took the House of Hades, I am unsurprised. There is no fury like that of a parent bereft of their child. Does Chaos seem an ally to us, then?" },
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
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutErisFight01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0601",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Eris has returned to us, I trust you've seen? 'Twas my dearest hope that leaving all her rubbish here would soon enough inspire her to pick it up, but alas.... You stay away from her." },
				{ Cue = "/VO/Melinoe_2528", UsePlayerSource = true,
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ErisGift06" },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
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

			HecateAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0706",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "You flushed Prometheus out from his hiding-spot. Slipped from his chains somehow! Whether he's a pure idealist or merely in it for rebellion's sake, I've yet to ascertain." },
				{ Cue = "/VO/Melinoe_3895", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "His reasons for siding with Chronos seem plain enough; for one, he wants his vengeance on Lord Uncle Zeus and the rest. And for another, he's a Titan himself." },
				{ Cue = "/VO/Hecate_0707",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "{#Emph}I {#Prev}am a Titaness as well, as is Sister Selene, lest you forget! Our lineage need not dictate our loyalties or principles. Although perhaps Prometheus sees otherwise." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3896", Text = "Is it true he can see all that is to come?" },
					},
					{

						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "Hecate_Hub_Scoff",
						{ Cue = "/VO/Hecate_0708", Text = "He's merely mad, perhaps. And in more ways than one." },
					},
				},
			},

			HecateAboutPrometheusL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = ">",
						Value = 0,
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0709",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",					
					Text = "Hermes informed me that Prometheus redoubled his attacks upon Olympus, after he fended you aside. Have I not trained you how to withstand flames?" },
				{ Cue = "/VO/Melinoe_3897", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If only all he had was flames, but no, he has a vicious Eagle pet and more. What of Olympus, what has he done?" },
				{ Cue = "/VO/Hecate_0710",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "He's kept the gods on their back foot. Never fully committing his forces, avoiding fights he cannot win! Frustrating adversary, even if he shall not prevail." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3898", Text = "Why not?" },
					},
					{

						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0711", Text = "He's but one Titan 'gainst a dozen or more gods." },
					},
				},
			},
			HecateAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutMortals01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0760",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "The fire-thief Prometheus insists on barring your path toward the mountain summit still. What nonsense has he filled your head with recently?" },
				{ Cue = "/VO/Melinoe_4048", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He seems to bear a deep sense of responsibility and guilt for mortalkind. I'm concerned he aims to spread dissension in our ranks... some Shades who serve our cause must harbor sympathies." },
				{ Cue = "/VO/Hecate_0761",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "It sounds to me as though you are beginning to harbor such sympathies yourself. Do not be deceived by his lofty claims; he's sided with our enemy, and made that clear." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4049", Text = "Yes... understood." },
					},
				},
			},

			HecateAboutTyphonW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "LastBossDifficultyRecord", "TyphonHead" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0774",
					Text = "Hermes indicated you were instrumental in releasing Typhon's grip on Mount Olympus recently. I trust that your embattled relatives contributed their share to that result?" },
				{ Cue = "/VO/Melinoe_4355", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I may be just a frontline diversion in stopping the monster's attacks, but it worked. Lord Zeus at least was able to remind Typhon about the power of his lightning bolt. The others had their hands full someplace else..." },
				{ Cue = "/VO/Hecate_0775",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "The gods must be grateful for such an effective {#Emph}frontline diversion{#Prev}, and Chronos must be grateful for the brief reprieve as well. But carry on as you see fit; this was all part of the Titan's plan, and shall likewise factor into ours." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4356", Text = "My thoughts exactly." },
					},
				},

			},

			HecateAboutTyphonAltFightW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "BossTyphonHead02" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0849",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Selene indicates that you seemingly withstood the Vow of Rivals all the way to the end. She's not exactly prone to error, but such a claim I need to verify." },

				{ Cue = "/VO/Melinoe_5289", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then consider the claim verified. I almost expected some great feast or ceremony considering all it took. Though I suppose that's not the way the will of Night is done. " },

				{ Cue = "/VO/Hecate_0850",
					Text = "Nyx herself would say, {#Emph}seek to be valuable, not to be known. {#Prev}Selene and I at least know what you achieved. But if 'tis glory you desire, you were born in the wrong realm." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5290", Text = "This was glory enough." },
					},
				},

			},

			HecateAboutPalace01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Story01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusPalacePostTrueEnding01" }, Max = 8 },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0777",
					Text = "Were the heights of Olympus all that you imagined, at the Palace of Lord Zeus? If you're to overcome such hardships to reach that point, the view had best be worth the while." },
				{ Cue = "/VO/Melinoe_4726", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The palace grounds were like nothing I've ever beheld. Though everything was so vivid, I scarce could see at all. I felt as though I didn't belong there." },
				{ Cue = "/VO/Hecate_0778",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "That you do not. Well, as long as your mountain relatives showed you a bit of hospitality in the brief time you had!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4727", Text = "They did but... I'm glad I'm back." },
					},
				},

			},

			HecateAboutUltimateProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZagreusPastMeeting04" }
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
							},
							{
								SumPrevRuns = 3,
								Path = { "EnemyKills", "TyphonHead" },
								Comparison = ">=",
								Value = 1,
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
							},
							{
								SumPrevRuns = 3,
								Path = { "EnemyKills", "Chronos" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0762",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Each of the two great enemies we face, you have laid low, one after the other. Thus, we begin to take the upper hand..." },
				{ Cue = "/VO/Melinoe_4050", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I may be able to beat Chronos or Typhon in a fight, but at times I feel as though I've come no closer to stopping either of them. It's reassuring you think otherwise." },
				{ Cue = "/VO/Hecate_0763",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "I more than think; you've demonstrated that you have the strength and knowledge to complete your task. As to whether you have the patience, that we shall have to see." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4051", Text = "Patience, then..." },
					},
				},
			},
			HecateAboutUltimateProgress02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "WorldUpgradesRevealed" },
						HasAll = { "WorldUpgradeTimeStop", "WorldUpgradeStormStop" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0791",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "{#Emph}Dissolution of Time. Disintegration of Monstrosity. {#Prev}Connected incantations, negating that which has already come to pass, and violently. A terrible use of our craft..." },
				{ Cue = "/VO/Melinoe_4741", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But a necessary one. How did you discover such incantations? You practically know more of Chronos than he does himself." },
				{ Cue = "/VO/Hecate_0792",
					Text = "When I learned of what Chronos had done to you and the rest... I refused to accept it. But I studied him nevertheless. Power always contains the secrets of its own undoing." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4742", Text = "Even his and Typhon's..." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0793", Text = "Even his and Typhon's." },
					},
				},
			},

			-- alt of the next event w/ more context
			HecateAboutUltimateProgress03_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesRevealed" },
						HasAll = { "WorldUpgradeStormStop" },
					},
					{
						PathFalse = { "GameState", "LifetimeResourcesGained", "MixerMythic" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
								"HecateAboutUltimateProgress03",
								"HecateAboutChronosBossW04",
								"HecateAboutChronosBossW04_A",
								"HecateAboutChronosBossW04_B",
							},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_4733", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father's spear, Gigaros... it was there in the Prince's chambers for me to find. Zagreus must have gotten access to it in his time, as I have now. One final step, then?" },

				{ Cue = "/VO/Hecate_0788_B",
					PreLineAnim = "HecateHubGreet",
					Text = "Not quite. We have one opportunity to use it against Chronos, and shall take every precaution to ensure it shall have the intended result." },

				{ Cue = "/VO/Melinoe_5016", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Entropy is the last reagent we require for the Dissolution of Time, but... where am I supposed to find it? I've found no trace as yet... even from Typhon." },
					
				{ Cue = "/VO/Hecate_0795",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Where are you supposed to {#Emph}create {#Prev}it is the correct question to be asking. A powerful enough force must be put entirely to rest. Do you catch my meaning?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_5017", Text = "...I believe so. Back to the surface, then." },
					},
				},
			},

			HecateAboutUltimateProgress03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesRevealed" },
						HasAll = { "WorldUpgradeStormStop" },
					},
					{
						PathFalse = { "GameState", "LifetimeResourcesGained", "MixerMythic" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutUltimateProgress03_A" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_5016", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Entropy is the last reagent we require for the Dissolution of Time, but... where am I supposed to find it? I've found no trace as yet... even from Typhon." },
				{ Cue = "/VO/Hecate_0795",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Where are you supposed to {#Emph}create {#Prev}it is the correct question to be asking. A powerful enough force must be put entirely to rest. Do you catch my meaning?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_5017", Text = "...I believe so. Back to the surface, then." },
					},
				},
			},

			-- alt below
			HecateAboutTyphonFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
							-- "HecateAboutTyphonFight01",
							"HecateAboutTyphonFight01_B",
							"HecateBossAboutTyphonFight01",
							"HecateBossAboutTyphonFight01_B",
							"HecateAboutTyphonFight03",
							"HecateAboutTyphonFight03_B",
							"HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = "<=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0751",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Emote = "PortraitEmoteFiredUp",
					Text = "Has the thin air upon that mountain made you mad, Melinoë? Confronting Typhon of all creatures face to face! Hermes told me everything. Save what was going through your head." },
				{ Cue = "/VO/Melinoe_4042", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I was not about to turn my back on my family, especially not after having come so far. What should I have done, flee at the first sight of that monster? We flee only as a last resort." },
				{ Cue = "/VO/Hecate_0752",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "That we do, and you had best keep reminding yourself of it ere you confront the Father of All Monsters again. Do not take unnecessary risks, or lose sight of the task." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.44,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4047", Text = "We do as we must." },
						-- { Cue = "/VO/Melinoe_2519_A", Text = "...Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_B", Text = "Yes, Headmistress." },
					},
				},

			},
			HecateAboutTyphonFight01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
							"HecateAboutTyphonFight01",
							-- "HecateAboutTyphonFight01_B",
							"HecateBossAboutTyphonFight01",
							"HecateBossAboutTyphonFight01_B",
							"HecateAboutTyphonFight03",
							"HecateAboutTyphonFight03_B",
							"HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 2,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "Q_Boss01", "Q_Boss02" },
						Comparison = "<=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0751",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Emote = "PortraitEmoteFiredUp",
					Text = "Has the thin air upon that mountain made you mad, Melinoë? Confronting Typhon of all creatures face to face! Hermes told me everything. Save what was going through your head." },
				{ Cue = "/VO/Melinoe_4043", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He's much, much larger than any other foe I've faced, but that doesn't make him invincible. I suspected he'd have a difficult time contending with a small, quick adversary." },
				{ Cue = "/VO/Hecate_0753",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "I would commend you for the outcome were I not so utterly aghast. The Father of All Monsters may not be quite so easy to surprise ere you confront him again. Do not take unnecessary risks or lose sight of the task." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.44,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4047", Text = "We do as we must." },
						-- { Cue = "/VO/Melinoe_2519_A", Text = "...Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_B", Text = "Yes, Headmistress." },
					},
				},

			},
			-- alt below for Early Access players
			HecateAboutTyphonFight02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "Q_Intro" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceMeeting02", "HecateAboutStormStop01", "HecateAboutStormStop01_B", "HecateAboutChronosBossW04"
						},
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutTyphonFight02_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0754",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "'Tis a wonder that your mountain relatives are still able to be of benefit to you whilst having Typhon at their gates. Do they have any sort of strategy to stop him, do you know?" },
				{ Cue = "/VO/Melinoe_4044", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They're working together to drive him back, along with the Titan's legions. But if they have a greater plan to put an end to the assault, they've not yet let on." },
				{ Cue = "/VO/Hecate_0755",
					Text = "Let us assume then that they've no such plan. However, I'm beginning to think the Father of All Monsters may yet figure into ours. Collect what samples that you can from him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0042", Text = "I shall, Headmistress." },
					},
				},
			},
			-- purposeful repeat for Early Access players
			HecateAboutTyphonFight02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "Q_Intro" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusPalaceFirstMeeting", "HecateAboutTyphonFight02" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ZeusPalaceMeeting02" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutTyphonFight02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0754",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "'Tis a wonder that your mountain relatives are still able to be of benefit to you whilst having Typhon at their gates. Do they have any sort of strategy to stop him, do you know?" },
				{ Cue = "/VO/Melinoe_4044", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They're working together to drive him back, along with the Titan's legions. But if they have a greater plan to put an end to the assault, they've not yet let on." },
				{ Cue = "/VO/Hecate_0755",
					Text = "Let us assume then that they've no such plan. However, I'm beginning to think the Father of All Monsters may yet figure into ours. Collect what samples that you can from him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0042", Text = "I shall, Headmistress." },
					},
				},
			},

			-- alt below; this version is for >1 Typhon clear
			HecateAboutTyphonFight03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutTyphonFight03_B" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "Resources", "MixerQBoss" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0756",
					Text = "Your victories against Typhon... have you there anything to show for it? Any sort of specimens or samples of his flesh?" },
				{ Cue = "/VO/Melinoe_4045", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I hope you like hideous eyes, Headmistress. Is there an incantation that you have in mind requiring such filth?" },
				{ Cue = "/VO/Hecate_0757",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "Perhaps. Hold onto all of that for now. But when the time is right, we shall turn all that monstrous power back against itself. And rid this world of that fiend for good." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.44,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2519_A", Text = "...Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_B", Text = "Yes, Headmistress." },
					},
				},

			},
			-- only a single Typhon victory
			HecateAboutTyphonFight03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutTyphonFight03" },
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "==",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0756_B",
					Text = "Your victory 'gainst Typhon... have you there anything to show for it? Any sort of specimens or samples of his flesh?" },
				{ Cue = "/VO/Melinoe_4045", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I hope you like hideous eyes, Headmistress. Is there an incantation that you have in mind requiring such filth?" },
				{ Cue = "/VO/Hecate_0757",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "Perhaps. Hold onto all of that for now. But when the time is right, we shall turn all that monstrous power back against itself. And rid this world of that fiend for good." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.44,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2519_A", Text = "...Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_B", Text = "Yes, Headmistress." },
					},
				},

			},

			-- alt / variant below
			HecateAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosRevealFollowUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutChronosAnomaly01" },
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
					Text = "Headmistress, I saw him. {#Emph}Chronos! {#Prev}He was in the pathways beyond Erebus. I struck as soon as I realized who he was, but to no avail." },
				{ Cue = "/VO/Hecate_0776",
					Text = "He thinks himself clever, the arrogant wretch. So then he knows of you. What did he say?" },
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
						{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
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
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Chronos_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutChronos01", "HecateAboutFates01", "HecateBossAboutFates01" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" }
					},
					-- MinRunsSinceAnyTextLines counterpart example
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosRevealFollowUp" }, Max = 3 },
					},
					--[[
					-- for putting a minimum number of runs between events, i.e. 'over the last 3 runs including CurrentRun, the number of times ChronosRevealFollowUp occurred must be 0 for this to be true'
					CountPathTrue quantifies 'true' instances, not necessary with integer values e.g. RoomCountCache, unless comparing the totals themselves
					{
						SumPrevRuns = 3,
						Path = { "TextLinesRecord", "ChronosRevealFollowUp" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 0,
					},
					-- for putting a maximum number of runs between events, i.e. 'over the last 5 runs including CurrentRun, the number of times ChronosRevealFollowUp occurred must be at least 1 for this to be true'
					{
						SumPrevRuns = 5,
						Path = { "TextLinesRecord", "ChronosRevealFollowUp" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Melinoe_2520", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos was waiting for me again outside of Erebus. This time I recognized him right away, but I could do nothing against him..." },
				{ Cue = "/VO/Hecate_0033_B",
					Text = "Wily bastard. Arrogant to the last.... What did he say?" },
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
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = "==",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2903", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Headmistress, I found him! {#Emph}Chronos! {#Prev}Deep within Tartarus, just as you said. I did everything as practiced and as planned, except... he was too strong." },
				{ Cue = "/VO/Hecate_0591",
					Text = "Still your heart, Melinoë, you're safe. And you were able to return again, which means that all your training served you well.... So then... he realizes who you are?" },
				{ Cue = "/VO/Melinoe_2904", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
					NamedRequirementsFalse = { "HecateMissing" },
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
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
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
				InitialGiftableOffSource = true,
				UseableOffSourceRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusPastFirstMeeting" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZagreusPastMeeting03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,
				{ Cue = "/VO/Hecate_0632",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You're back...! Now tell me everything. You found your mark? What then?" },
				{ Cue = "/VO/Melinoe_2799", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I reached the edge of Tartarus and made my way into the House, just as we planned. Chronos was there, on my father's throne. We clashed. He lost. But I know he isn't gone. And I was unable to linger there for long." },
				{ Cue = "/VO/Hecate_0779",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "I trust you made each moment count. We were never going to destroy the Titan with brute force alone, but soon enough, he may yet be undone entirely. Provided you have more good tidings to report...?" },
				{ Cue = "/VO/Melinoe_4728", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The Mirror was intact... abandoned in the Prince's chambers. And the incantation worked! I found my brother in the past and spoke to him, but had so little time. I barely managed to convince him as to who I am." },
				{ Cue = "/VO/Hecate_0780",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "Then speak swiftly the next opportunity you get. And continue not to overstay, lest the task end in failure. As for the Titan... study him, as I shall study what you found." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0585", Text = "Yes, Headmistress." },
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
					{
						PathFalse = { "GameState", "ScreensViewed", "Shrine" },
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

			HecateAboutChronosBossW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutChronosBossW01" },
					},
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting02" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0781",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You brought the Titan low again, but what transpired after that? Was your bygone brother more cooperative than before?" },
				{ Cue = "/VO/Melinoe_4729", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He doesn't know where to find Chronos, though seems willing to investigate. Perhaps he'll turn something up. I still scarce believe it's truly his past self I've spoken to..." },
				{ Cue = "/VO/Hecate_0782",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Imagine how {#Emph}he {#Prev}feels. Continue to check up on him, but not a word of this to anybody else. Time flows ever forward, and we are not meant to travel opposite that stream." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4730", Text = "It shouldn't be possible..." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0783", Text = "{#Emph}We {#Prev}determine what is possible, Melinoë." },
					},
				},
			},
			HecateAboutChronosBossW03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting03" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0784",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "We heard about the Titan's latest misfortune by your hand. Is all else proceeding as intended, by your estimation?" },

				{ Cue = "/VO/Melinoe_4731", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think so. We just need to find a suitable weapon now, and then... everything that's come to pass can be undone." },

				{ Cue = "/VO/Hecate_0785",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Perhaps not {#Emph}everything{#Prev}, but plenty. You know the rest by heart and I'll not pry for further details. But should an unexpected setback come to pass, tell me at once." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4732", Text = "I shall." },
					},
				},
			},
			-- alts below (that don't grant StormStop)
			-- if you have made enough Typhon progress (ZeusPalaceMeeting02), but not earned StormStop
			HecateAboutChronosBossW04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusPastMeeting05", "ZeusPalaceMeeting02" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					-- three paths to stop the storm
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"HecateAboutStormStop01",
							"HecateAboutStormStop01_B",
							-- "HecateAboutChronosBossW04"
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							-- "HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_4733", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father's spear, Gigaros... it was there in the Prince's chambers for me to find. Zagreus must have gotten access to it in his time, as I have now. One final step, then?" },

				{ Cue = "/VO/Hecate_0786",
					PreLineAnim = "Hecate_Hub_Affirm",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "First let us put what you discovered to the test. Once the incantation I shall teach you is complete, seek out Typhon... and use the spear essence after his strength has waned." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2.5, Title = "WorldUpgradeAdded", Text = "WorldUpgradeStormStop" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4734", Text = "What shall become of Typhon once I do?" },
					},
					{
						PreLineWait = 0.52,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0787", Text = "...He'll be nothing." },
					},
				},
			},
			-- significant ZagreusPastMeeting progress, if you have found Typhon but not made much progress against him
			HecateAboutChronosBossW04_A =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusPastMeeting05" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"HecateAboutChronosBossW04",
							-- "HecateAboutChronosBossW04_A",
							"HecateAboutChronosBossW04_B",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {
							"ZeusPalaceMeeting02"
						},
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_4733", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father's spear, Gigaros... it was there in the Prince's chambers for me to find. Zagreus must have gotten access to it in his time, as I have now. One final step, then?" },

				{ Cue = "/VO/Hecate_0788_B",
					PreLineAnim = "HecateHubGreet",
					Text = "Not quite. We have one opportunity to use it against Chronos, and shall take every precaution to ensure it shall have the intended result." },

				{ Cue = "/VO/Melinoe_4735", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					-- PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "You wish for me to turn my attention to Olympus for a while, so that we can test the Temporal Spear there first?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0789", Text = "Yes. You need to prove that this shall work." },
					},
				},
			},
			-- if you have not found Typhon yet (including Early Access)
			HecateAboutChronosBossW04_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"HecateAboutChronosBossW04",
							"HecateAboutChronosBossW04_A",
							-- "HecateAboutChronosBossW04_B",
						},
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_4733", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father's spear, Gigaros... it was there in the Prince's chambers for me to find. Zagreus must have gotten access to it in his time, as I have now. One final step, then?" },

				{ Cue = "/VO/Hecate_0788",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "Not quite. We have one opportunity to use it against Chronos, and shall take every precaution to ensure it shall have the intended result. Perhaps whatever ails your Olympian relatives shall provide a suitable target." },

				{ Cue = "/VO/Melinoe_4735", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					-- PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "You wish for me to turn my attention to Olympus for a while, so that we can test the Temporal Spear there first?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0789", Text = "Yes. You need to prove that this shall work." },
					},
				},
			},

			HecateAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0796",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "The foul deed is done. Have no pity for that monster, only gratitude... for yielding his power in his absence. Now you are ready for the final phase." },

				{ Cue = "/VO/Melinoe_5018", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Before I depart... my brother asked something I didn't know how to answer. If Chronos is destroyed before all this... what exactly happens to us here and now?" },

				{ Cue = "/VO/Hecate_0797",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Let us discover the truth of it together. I am certain only that this is not goodbye. The conclusion of your task is at hand. {#Emph}Go{#Prev}, end this." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_5019", Text = "...I'll see you again soon." },
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0421",
					Text = "One more of Nyx's kin is here for us to mind. Your incantation tracked him after all! {#Emph}Doom {#Prev}typically arrives {#Emph}uninvited{#Prev}, of course." },
				{ Cue = "/VO/Melinoe_1591", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			-- lower-priority alt below
			HecateAboutHades01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutHades01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_1029", UsePlayerSource = true,
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I found him, Headmistress! My father! Chronos has him locked away in Tartarus. But, I couldn't save him... he asked I leave him be..." },
				{ Cue = "/VO/Hecate_0295",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Truly? How utterly predictable of Chronos to gloat in such a way. I regret that your reunion with Lord Hades thus transpired... though, I am gladdened you discovered him. How does he fare?" },
				{ Cue = "/VO/Melinoe_1030", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
			HecateAboutHades01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutHades01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_5474", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I ought have told you by now but I found him, Headmistress... my father. Chronos has him locked in Tartarus like a common prisoner... he asked I leave him be." },
				{ Cue = "/VO/Hecate_0295",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Truly? How utterly predictable of Chronos to gloat in such a way. I regret that your reunion with Lord Hades thus transpired... though, I am gladdened you discovered him. How does he fare?" },
				{ Cue = "/VO/Melinoe_1030", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutHecate01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHades01", "HecateAboutHades01_B" },
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
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "H_Boss01", "H_Boss02" },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He doesn't seem to know who I am. Whether because it's been too long, or there's too much on his mind. Minds? But I felt a flash of recognition. He isn't too far gone, is he...?" },
				{ Cue = "/VO/Hecate_0629",
					PreLineAnim = "HecateHubGreet",
					Text = "The nature of a beast can never change. Like us, however, they at times must fight the Daemons that torment them... a battle in which you can assist! Trust your training, and perhaps he can yet shake the spell that's overtaken him." },
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
						Path = { "GameState", "RoomsEntered", "H_Boss01" },
						Comparison = ">=",
						Value = 2,
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusAboutHecate02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0946", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, Lord Zeus requested {#Emph}prompt reports{#Prev}, his words, from you about the situation in the Underworld. He seemed a little frustrated. Asked me to let you know." },
				{ Cue = "/VO/Hecate_0262",
					Text = "And you're as dutiful as ever, aren't you? Exactly as Lord Zeus wants us to be. Think you he truly cherishes these Underworld reports?" },
				{ Cue = "/VO/Melinoe_0947", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			HecateAboutArtemisSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0747",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "The goddess of the hunt decided that the best use of her talents presently is to regale us with song! As you can hear, I managed to resist my inclination to forbid any such thing." },
				{ Cue = "/VO/Melinoe_4039", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm grateful that you did. I know Artemis sings to clear her mind and calm her nerves, but I think all the Shades about this place appreciate it, too." },
				{ Cue = "/VO/Hecate_0748",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "'Tis not how I myself prefer to face adversity, though I {#Emph}am {#Prev}open to whichever techniques work." },
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
					NamedRequirementsFalse = { "HecateMissing" },
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
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4840", Text = "{#Emph}Permeation of Witching-Wards..." },
					},
				},
			},

			HecateAboutAthena01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TraitCache", "AthenaEncounterKeepsake" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0715",
					Text = "The Shades reporting to Odysseus suggest Athena herself appeared before you here? I mean not {#Emph}here{#Prev}, but in the Underworld. Is that something I ought believe, or no?" },
				{ Cue = "/VO/Melinoe_3902", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "You ought. Athena gave her Gorgon Amulet, with which she's able to locate me far from where she normally resides. I trust I haven't inconvenienced her too much." },
				{ Cue = "/VO/Hecate_0716",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Athena cannot go wherever she may please, no matter how it seems. But now you clearly have a stronger bond with her. And she, in turn, has a means to watch you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3903", Text = "Watch {#Emph}over {#Prev}me, you mean...?" },
					},
					{

						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0717", Text = "She has her task, as you have yours." },
					},
				},
			},

			-- arachne curse subplot
			HecateAboutArachne01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ArachneAboutCurse01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3134", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Headmistress, there must be something we can do for Arachne. Her curse torments her. What use is our craft if we cannot ease a friend's suffering?" },

				{ Cue = "/VO/Hecate_0551",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Arachne's fate is not yours to undo. 'Tis a matter between her and Athena. I suggest you leave it well alone." },
					
				{ Cue = "/VO/Melinoe_3135", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
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
			HecateAboutArachne02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBossAboutArachne01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutArachne03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3136", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Can you help me discover who created Arachne's curse, if it wasn't Athena herself?" },

				{ Cue = "/VO/Hecate_0553",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Why don't you ask {#Emph}her {#Prev}rather than me? I understand her hands are full, forestalling the destruction of Olympus... though surely she shall make some time for you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
  						{ Cue = "/VO/Melinoe_3216", Text = "{#Emph}<Scoff>" },
					},
				},
			},
			HecateAboutArachne03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift03", "ArachneAboutCurse02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutArachne01", "HecateAboutArachne02", "ArachneWithHecateInHub01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0554",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Concerning your companion Arachne and her curse: Against my better judgment... I've done some searching, and have knowledge of the one who fashioned the poison." },

				{ Cue = "/VO/Melinoe_3137", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "You have? Excellent! Thank you, Headmistress! Who did you learn was responsible?" },

				{ Cue = "/VO/Hecate_0555",
					Text = "That matter is solely between me and the spider. Utmost discretion is required in such matters. If you wish to be an intermediary still, then let her know to seek me here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0585", Text = "Yes, Headmistress." },
					},
				},
			},
			HecateAboutArachne04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneWithHecateInHub02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3138", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress... {#Emph}you {#Prev}cursed my friend... poisoned her! You taught me never to be quick to judge, so help me understand..." },

				{ Cue = "/VO/Hecate_0593",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Understand, then, that my allegiance forcibly is with the gods, not with arrogant mortals. You did not know the Arachne of old; she has been humbled in her current form." },

				{ Cue = "/VO/Melinoe_3139", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Then she has learned her lesson! Please help me change her back." },

				{ Cue = "/VO/Hecate_0594",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "I told you, 'tis a matter between her and Athena! For my part, I merely can express regret... to you, as well as her. Perhaps in time Athena herself may thus be swayed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3140", Text = "But... {#Emph}<scoff>" },
					},
				},
			},
			HecateAboutArachne05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneCurseQuestComplete01", "AthenaAboutArachneQuestComplete01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0851",
					Text = "The woods have eyes and ears, thus I'm aware Arachne and Athena finally settled up their differences. To the extent they ever shall, I suppose." },

				{ Cue = "/VO/Melinoe_5291", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Arachne always had her pride, but... I think she may have found some sort of peace." },

				{ Cue = "/VO/Hecate_0852",
					PreLineAnim = "HecateHubGreet",
					Text = "Would that it were so. With time, feelings of scorn embed themselves deep in the flesh; in the heart. And they are not easily excised. But those two are stubborn enough to do it." },
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
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I'd not expected Lady Medea to be stationed in Ephyra still, Headmistress. To think even a witch of her experience was unable to prevent the city's fall." },
				{ Cue = "/VO/Hecate_0588",
					Text = "'Twas not her responsibility to try. Medea was there to blend with the locals. It seems she's even more successful at it now, with most of them deceased. I trust she aided you in her own way?" },
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
					Text = "My concern is only for her well-being, and it sounds as though she is all right for now. So long as her {#Emph}research {#Prev}does not come back to haunt her anytime soon." },
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
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift01" },
					},
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "CirceAboutOdysseusQuest01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0662",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					Text = "We have a bit of a personnel problem with our Circe the Enchantress. Her isle is poised to survey our enemy's fleet, reports of which ought go directly to Odysseus. Except they go to me." },
					
				{ Cue = "/VO/Melinoe_3466", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero", 
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

			HecateAboutIcarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 6,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift01" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_3899", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Headmistress, I saw Icarus up there, during my voyage toward Olympus. He flies free, but fights for us still... doing what he can to disrupt the Titan's legions." },
				{ Cue = "/VO/Hecate_0712",
					PreLineAnim = "HecateHubGreet",
					Text = "And...? You need not make attempts to endear him to {#Emph}me. {#Prev}My judgment of one's character need not affect your own." },
				{ Cue = "/VO/Melinoe_3900", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I just... sometimes I worry you think he abandoned us during a time of need, and wasn't a good influence on me..." },
				{ Cue = "/VO/Hecate_0713",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "You need not speculate about my thoughts. The follies of young Icarus are positively mild in comparison to most. I harbor no ill will toward him; he'd not be flying if I did." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3901", Text = "Is he still welcome here, at least?" },
					},
					{

						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0714", Text = "If that is both your wish and his..." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "GiftPresentation" },
						UseLength = true,
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "F_Boss01", "F_Boss02" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathFalse = { "CurrentRun", "Cleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0021",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "Vengeance for your family awaits you, far below. I'm certain they would be proud of what you have become. Bear them in your heart when you strike." },
				{ Cue = "/VO/Melinoe_0048", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, I'll bear them in my heart but... I have no memory of them. How could I? You're the one who's always been there for me." },
				{ Cue = "/VO/Hecate_0022",
					PreLineAnim = "Hecate_Hub_Scoff",
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
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = "<",
						Value = 60,
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
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "GameState", "WorldUpgrades" },
						CountOf = ScreenData.GhostAdmin.ItemCategories[1],
						Comparison = "<",
						Value = 60,
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
					{
						SumPrevRuns = 6,
						Path = { "UseRecord", "GhostAdmin" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0215",
					Text = "I must say, you've been putting our old cauldron to good use. I see and sense the changes in this place. Changes for all our betterment, not just your own." },
				{ Cue = "/VO/Melinoe_0652", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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

			HecateAboutAltCauldron01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_Cauldron01a" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0718",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "I remain rather partial to our old cauldron. This one that you procured with all the stars... your magick shan't just magickally improve because of it." },
				{ Cue = "/VO/Melinoe_3904", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We still retain the old cauldron, of course. Just say the word and I can change it back! As for this one, a new beginning can yield powerful results, isn't that so?" },
				{ Cue = "/VO/Hecate_0719",
					PreLineAnim = "HecateHubGreet",
					Text = "Well, if this fancy bit of metalwork inspires you to greater acts, then 'tis worth its weight! I'll not ask you to change it back. And even if I did, heed {#Emph}your {#Prev}instincts, not mine." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.43,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3905", Text = "I trust yours too." },
					},
				},
			},
			HecateAboutAltCauldron02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_Cauldron01b" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0720",
					PreLineAnim = "HecateHubGreet",
					Text = "A properly imposing cauldron, that. Perhaps more suitable for certain specialties... daemonic invocations, curses, and the like. Do you intend to further specialize?" },
				{ Cue = "/VO/Melinoe_3906", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not necessarily, Headmistress. I... still have a lot of different ideas, sometimes several on a given night. It's my dream to pursue mastery in all dimensions of our craft." },
				{ Cue = "/VO/Hecate_0721",
					Text = "Your {#Emph}dream{#Prev}, you say. We each have our leanings and yours perhaps shall manifest in time. But I do recognize the desire to avoid becoming {#Emph}limited{#Prev}, so practice as you will. Using this Python cauldron or whichever one." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3907", Text = "A cauldron for every occasion!" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0722", Text = "Ever the dreamer." },
					},
				},
			},

			HecateAboutGarden01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGardenT3" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "HubGardenPlot" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0723",
					Text = "Cultivating all those many different types of greenery. We are in the realm of the dead, lest you forget, Melinoë! Yet here you tend your garden." },
				{ Cue = "/VO/Melinoe_3908", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No better place to grow reagents above or below. But more than that, it's something small I can look forward to whenever I return. Helps keep me centered." },
				{ Cue = "/VO/Hecate_0724",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "There's no need to explain. The Earth obliges you; 'tis wise to take advantage of good fortunes such as that." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3909", Text = "I merely borrow." },
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
						PathFalse = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
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
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = "<",
						Value = 25,
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
					Text = "Indeed. We choose as wisely as we can, using what knowledge we have. So, you now clearer see into the {#Emph}cards{#Prev}, as you call them..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.55,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
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
					{
						SumPrevRuns = 9,
						Path = { "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wanted to ask you something, Headmistress. All these reagents I've been gathering, taking from the Earth. From Mother Gaia. How can I make it up to her?" },
				{ Cue = "/VO/Hecate_0287",
					Text = "Well, you can start by not wallowing in senseless guilt. Think you that Gaia would reveal her abundances to you if she believed you would not put them to good use?" },
				{ Cue = "/VO/Melinoe_1023", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
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
			-- alt below
			HecateAboutResources03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutResources03_B" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 400,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 400,
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know full well the answer, Headmistress. Your own reagents bring power to your craft, as my own do to mine. Only through the effort of their procurement do they gain their properties." },
				{ Cue = "/VO/Hecate_0290",
					Text = "Just so. At times 'tis quite the pain, admittedly. Yet what is our craft but making our intentions manifest? For which there can be no shortcuts." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_1025", Text = "No shortcuts." },
					},
				},
			},
			HecateAboutResources03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutResources03" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
						Comparison = "<=",
						Value = 400,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
						Comparison = "<=",
						Value = 400,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf = GameData.OdysseusResourceEvents,
						Comparison = ">=",
						Value = 2,
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

				{ Cue = "/VO/Hecate_0858",
					PreLineAnim = "HecateHubGreet",
					Text = "The Tactician furnishes you with some of the reagents you require. Yet why not I? So many incantations you could sooner cast." },
				{ Cue = "/VO/Melinoe_1024", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know full well the answer, Headmistress. Your own reagents bring power to your craft, as my own do to mine. Only through the effort of their procurement do they gain their properties." },
				{ Cue = "/VO/Hecate_0290",
					Text = "Just so. At time 'tis quite the pain, admittedly. Yet what is our craft but making our intentions manifest? For which there can be no shortcuts." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
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
						PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar", },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossAboutFrogFamiliar01", "HecateGrantsFamiliars01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0281",
					Text = "That indolent little amphibian whom you keep... did my eyes deceive, or did I see him hopping rather energetically toward the egress?" },
				{ Cue = "/VO/Melinoe_1019", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "You saw it true! I've compelled little Frinos to join me in my attempts out there. Surely you've taught me wards and charms enough to keep a Familiar safe?" },
				{ Cue = "/VO/Hecate_0282",
					Text = "One can but hope! And may your Familiar keep {#Emph}you {#Prev}safe, in turn. And perhaps scrounge up some more roots and such for us." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
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
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossAboutCatFamiliar01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0283",
					Text = "A cat recently strutted clear into our grove, as though my wards of shadow weren't even there! Please tell me that's a new Familiar of yours?" },
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
					{
						Path = { "GameState", "UseRecord", "CrossroadsPet01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateGrantsFamiliars01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_2523", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero", 
					Text = "How fare Hecuba and Gale lately, Headmistress? They must be ill-at-ease with all of the bustle and new faces and the like." },
				{ Cue = "/VO/Hecate_0597",
					Text = "Oh, they're fine. The hound and polecat make strange bedfellows, but are able to withstand more than their share of hardship or discomfort. Especially when you lavish them with attention!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2524_B", Text = "I'm sure to win their hearts one of these nights!" },
					},
				},
			},

			HecateAboutCosmetics01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
						Comparison = ">=",
						Value = 1000,
					},
					{
						Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
						Comparison = ">=",
						Value = 30,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0535",
					Text = "These Crossroads flourish thanks to this {#Emph}renewal project {#Prev}of yours. You saw an opportunity to get it off the ground even now?" },
				{ Cue = "/VO/Melinoe_2162", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "This is our home. It should be cared for, clean, and beautiful. I recruited Dora to assist me so that the work wouldn't have to wait forever." },
				{ Cue = "/VO/Hecate_0536",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "{#Emph}Dora? {#Prev}I've not once heard the invocation of {#Emph}her {#Prev}name and {#Emph}work {#Prev}in the same breath. To think that you persuaded {#Emph}that {#Prev}one to be of service." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2163", Text = "She's pleased to help." },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomCountCache", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_5046", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, what is that you and Odysseus are planning? He's always with his charts and diagrams." },
				{ Cue = "/VO/Hecate_0859",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Our Tactician always plans ahead, and is plotting a course from the nearest Underworld entrance all the way to Olympus, through the enemy's ranks... just in case." },
				{ Cue = "/VO/Melinoe_5047", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "In case of what...? I can't go up there, and Chronos is the opposite way. Are matters on Olympus growing worse?" },
				{ Cue = "/VO/Hecate_0860",
					Text = "We are awaiting confirmation about that. These are mere possibilities for now; {#Emph}distractions{#Prev}, even. Remain focused." },
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
						PathFalse = { "GameState", "RoomsEntered", "N_Opening01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_0586", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, if Olympus is besieged, then why am I not permitted on the surface? If I could aid the gods, then they could aid us even more!" },
				{ Cue = "/VO/Hecate_0218",
					Text = "Melinoë, however you complete the task is up to you; I have not barred you from the surface. But I caution, if you go, your strength shall fail you. Your birthright is to blame; no fault of yours." },
				{ Cue = "/VO/Melinoe_0587", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
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
			-- alt below
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutSurface03_B" }
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
			HecateAboutSurface03_B =
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutSurface03", "MorosGrantsSurfacePenaltyCure01" },
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
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2947", Text = "Only my task." },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutSurface03" },
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
						SumPrevRuns = 9,
						Path = { "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
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
						IsNone = { "O_Boss01", "O_Boss02" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" }
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "My surface-breathing incantation made a difference after all, Headmistress. I still felt the oppressive atmosphere up there, weighing down on me... but not crushing me quite like before." },
				{ Cue = "/VO/Hecate_0226",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Magick born of your resolve. I'm impressed, though not entirely surprised. May your craft thus protect you ere Olympus is secure." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0596", Text = "Indeed." },
					},
				},
			},
			HecateAboutSurfaceSurvival03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0749",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "It must be very difficult for you up there. My aim was to prepare you for the dangers of the Underworld, not those Olympus ought be able to take care of on its own." },
				{ Cue = "/VO/Melinoe_4040", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Every misstep on the surface is a harsher lesson even than below. I've become more used to it, but I'm constantly reminded I should not be able to set foot up there at all." },
				{ Cue = "/VO/Hecate_0750",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "And yet you carry on! Notice how I do not even attempt to cure you of that stubbornness; 'tis probably your family's most pervasive trait. Well, if you wish to keep making things even harder on yourself, at least you know the way." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4041", Text = "I like having options." },
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

			HecateAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Intro" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZagreusPastMeeting04" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0703",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Odysseus and I... long has one of us been certain you would find your way to Mount Olympus and direct your efforts there. The other was certain you'd do no such thing." },
				{ Cue = "/VO/Melinoe_3893", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Before you even ask, there's absolutely no way you're making me guess which one of you was which in that particular disagreement, Headmistress." },
				{ Cue = "/VO/Hecate_0704",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "I always said how you achieve the task is up to you. 'Tis not for me to guide your every step! Then was it worth it, climbing to those heights?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3894", Text = "Entirely. And I intend to go again." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0705", Text = "May your intent be true." },
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
						PathTrue = { "CurrentRun", "RoomsEntered", "G_Intro" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
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

			-- alt below
			HecateAboutChronosAnomaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateAboutChronos01", "HecateAboutChronosBossEarlyL01" },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						-- { Cue = "/VO/Melinoe_2519_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_A", Text = "Yes, Headmistress." },
						-- { Cue = "/VO/Melinoe_0585_B", Text = "Yes, Headmistress." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateAboutChronosAnomaly01" },
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

			HecateAboutTimeStop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "MixerIBoss" },
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
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponAxe", "WeaponTorch" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = { "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
						Comparison = "<=",
						Value = 3,
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
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" },
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
						IsAny = { "F_Boss01", "F_Boss02" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "F_PostBoss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HecateBossOutro01" },
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
						IsAny = { "F_Boss01", "F_Boss02" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0197",
					Text = "I thwarted you again out there. 'Tis unfair, I know. I arrive fresh as rain in anticipation of our clash, whilst you may already be battle-worn." },
				{ Cue = "/VO/Melinoe_0655", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossAboutAltFight01" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "Cleared" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0408",
					Text = "You prevailed in your attempt! But our enemy is Time itself, and 'twould seem that he is not prepared to abdicate his stolen throne as yet." },

				{ Cue = "/VO/Melinoe_5685", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "I often fought back feelings that this task would be impossible. But we're getting somewhere, aren't we?" },

				{ Cue = "/VO/Hecate_0409",
					Text = "Impossibility tends to be transient. Time would wear us down, but with patience, we can withstand him until our night arrives at last." },
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
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, have you always been so fond of beasts? It seems you would do anything for each other." },
				{ Cue = "/VO/Hecate_0029",
					Text = "Beasts... saddled with such an uncharitable name. Beasts are far more trusting than most any mortal or immortal I have met." },
				{ Cue = "/VO/Melinoe_0145", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You look unwell. Returning is difficult, I know. Tell me if you need anything." },
				{ Cue = "/VO/Melinoe_0050", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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
						HasAny = { "MorosTaverna02", "NemesisBathHouse03", "ErisTaverna02", "IcarusBathHouse01" },
					},
					{
						Path = { "PrevRun", "UseRecord" },
						HasAny = { "NPC_Moros_01", "NPC_Nemesis_01", "NPC_Eris_01", "NPC_Icarus_01" },
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
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
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

			-- unlocks
			HecateGrantsWeaponUpgradeSystem01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						-- SumPrevRuns = 1 is the same as CurrentRun, SumPrevRuns = 2 is checking PrevRun, etc.
						SumPrevRuns = 3,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf =
						{
							"WeaponStaffSwing",
							"WeaponDagger",
							"WeaponAxe",
							"WeaponTorch",
							"WeaponLob",
							-- purposely omitted
							-- "WeaponSuit",
						},
						Comparison = ">=",
						Value = 4,
					},
					-- mutually exclusive variant
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossGrantsWeaponUpgradeSystem01"},
					},
					-- backward compatibility
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0694",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "The Nocturnal Arms you bear are strong, yet burden you with terrible responsibility. One that you are only beginning to understand." },
				{ Cue = "/VO/Melinoe_3830", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}The bearer shall uphold the will of Night in service to the Underworld. {#Prev}Almost as though I'm at their command and not the other way around..." },
				{ Cue = "/VO/Hecate_0695",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "That is the correct way to look at it. And I would share with you a certain incantation that shall deepen this relationship of yours." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeWeaponUpgradeSystem" },

				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3448", Text = "{#Emph}The Aspects of Night and Darkness..." },
				},
			},
			HecateGrantsShrineUpgrade01 =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HecateBossGrantsShrineUpgrade01" }
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0794",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "One further secret of the Oath of the Unseen I shall reveal now. When you feel suitably prepared, consider this. Then perhaps we shall clash under a new set of circumstances..." },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "ShrineUpgradeGained", Text = "ShrineUpgradeGained_Subtitle01" },

				EndVoiceLines =
				{
					PreLineWait = 0.75,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4600", Text = "The secret to the Vow of Rivals..." },
				},
			},
			HecateGrantsFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					NamedRequirements = { "HecateFamiliarsCanBeRecruited" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0585",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You've consistently ensured the safety of your Familiars, not that I had any doubt. We are here to protect such creatures more so than the other way around." },
				{ Cue = "/VO/Melinoe_2511", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "Familiars are family, Headmistress. Perhaps through this ordeal, my bond with mine shall come to be as strong as the one you share with yours." },
				{ Cue = "/VO/Hecate_0586",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "Of that I have no doubt as well. I've discussed the matter with Hecuba and Gale both, and they are willing to watch over you. If you ask nicely, of course." },
				{ Cue = "/VO/Melinoe_2512", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero", 
					Text = "What, truly? But they're bound to {#Emph}you! {#Prev}Wait, who must I ask nicely, you or them?" },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { WaitTime = 1.3, Duration = 2, Title = "Toast_MoreFamiliars_Title", Text = "Toast_MoreFamiliars_Subtitle" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0587", Text = "I'd start with {#Emph}them!" },
					},
				},

			},
			HecateGrantsBadgeSeller01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
						Comparison = ">=",
						Value = 20000,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0861",
					Text = "Through your achievements, our status as the Unseen grows. So long as we do not become the subject of too many tales, other than the frightful kind." },

				{ Cue = "/VO/Melinoe_5295", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Our Shades all seem to understand the need for continued discretion. They seem quite excited Nyx is back and watching over us." },

				{ Cue = "/VO/Hecate_0862",
						PreLineAnim = "HecateHubGreet",
					Text = "They shall discover Night Incarnate is not easy to please." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeBadgeSeller" },

				EndVoiceLines =
				{
					{
						PreLineWait = 1.2,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_5567", Text = "{#Emph}Long Arm of the Unseen..." },
					},
				},
			},
			HecateAboutBadgeProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "BadgeRank" },
						Comparison = "==",
						Value = 50,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0863",
					Text = "At last we are the Unseen I, and feared across the realms. I thought 'twould surely take another age..." },

				{ Cue = "/VO/Melinoe_5296", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It wasn't a quick process but we got there, yes. For the Unseen do not relent." },

				{ Cue = "/VO/Hecate_0864",
					PreLineAnim = "HecateHubGreet",
					Text = "Apparently not. What shall you do now? Pursue some other nigh-impossible result?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5297", Text = "We'll see!" },
					},
				},
			},

			HecateAboutStormStop01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					-- three paths to stop the storm
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							-- "HecateAboutStormStop01",
							"HecateAboutStormStop01_B",
							"HecateAboutChronosBossW04"
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZagreusPastMeeting02", "ZeusPalaceMeeting02" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02", "I_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutTyphonFight03", "HecateAboutTyphonFight03_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0758",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "Chronos must believe he has the upper hand now that Olympus has the Father of All Monsters bearing down on them night after night. But he has made a grave mistake..." },

				{ Cue = "/VO/Melinoe_4046", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Typhon cannot be controlled... if he no longer had Olympus to contend with, he would probably come after Chronos next. There must be some way we can redirect his rage." },

				{ Cue = "/VO/Hecate_0759",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "If not his rage, the very nature of his being... I have always taught you that our craft is never to be used for destruction alone. But, no rule is immutable. Let us use our enemies' strengths against them, to rid us of them all." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2.5, Title = "WorldUpgradeAdded", Text = "WorldUpgradeStormStop" },

				EndVoiceLines =
				{
					{
						PreLineWait = 1.2,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4737", Text = "{#Emph}Disintegration of Monstrosity..." },
					},
				},
			},
			HecateAboutStormStop01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					-- three paths to stop the storm
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"HecateAboutStormStop01",
							-- "HecateAboutStormStop01_B",
							"HecateAboutChronosBossW04"
						},
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateAboutChronosBossW04_B" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {
							"ZeusPalaceMeeting03",
							-- "ZeusPalaceMeeting03_A",
							-- "ZeusPalaceMeeting03_B"
						}
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0758",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "Chronos must believe he has the upper hand now that Olympus has the Father of All Monsters bearing down on them night after night. But he has made a grave mistake..." },

				{ Cue = "/VO/Melinoe_4736", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, are we finally prepared? To use the Temporal Spear against Typhon... and then Chronos after that." },

				{ Cue = "/VO/Hecate_0790",
					PreLineAnim = "Hecate_Hub_Affirm",
					PostLineFunctionName = "UnblockHubExitForNarrative",
					Text = "I do believe we are at last, Melinoë. Once the incantation I shall teach you is complete, seek that monster, and then use the spear essence after his strength has waned." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2.5, Title = "WorldUpgradeAdded", Text = "WorldUpgradeStormStop" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4734", Text = "What shall become of Typhon once I do?" },
					},
					{
						PreLineWait = 0.52,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "HecateHubGreet",
						{ Cue = "/VO/Hecate_0787", Text = "...He'll be nothing." },
					},
				},

			},

			HecatePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Melinoe_4942", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How are you faring lately, Headmistress? You've been... well, more reserved than I expected since the House of Hades. You said we'd speak more later." },
				{ Cue = "/VO/Hecate_0813",
					PreLineWait = 0.35,
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "How soon {#Emph}later {#Prev}turns to {#Emph}now. {#Prev}Look, Melinoë, I ought be in a more celebratory mood, given what you finally achieved. I am, above all, very proud of you. But being back at the House awakened memories that ought remain dormant." },
				{ Cue = "/VO/Melinoe_5683", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Even though... you got to see Mother and Father again, and Nyx? They were so grateful to you, I could tell! {#Emph}I {#Prev}am so grateful to you. Things may not have gone precisely as we planned, but the result {#Emph}is {#Prev}what we sought, isn't it?" },
				{ Cue = "/VO/Hecate_0814",
					PreLineWait = 0.35,
					Text = "...You refer to Chronos. I longed to see that wretch destroyed. My heart remains poisoned by the thought. I am attempting still to draw that poison out... do give me time." },
				{ Cue = "/VO/Melinoe_4944", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I remember you once told me that destroying Chronos would not change the past, and that the pain would linger." },
				{ Cue = "/VO/Hecate_0815",
					PreLineAnim = "HecateHubGreet",
					Text = "And, I was probably correct. Yet we cannot help but reassess the turns our lives take, through our own choices and otherwise. Anyhow, are you prepared to carry on?" },
				{ Cue = "/VO/Melinoe_4945", UsePlayerSource = true,
					PreLineWait = 0.25,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Nearly so. Retracing my steps should be interesting..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0816", Text = "Of that, I have no doubt." },
					},
				},
			},
			HecatePostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecatePostTrueEnding01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutOlympus01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0818",
					Text = "So is it working out thus far? This {#Emph}change of plan{#Prev}, as our Tactician would say. Should you see even the slightest trace of the old Chronos, do notify me at once." },

				{ Cue = "/VO/Melinoe_5020", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Grandfather appeared where and when we discussed. His claims about these remnant possibilities out of Time appear to be accurate. Shall we continue?" },

				{ Cue = "/VO/Hecate_0819",
					PreLineAnim = "HecateHubGreet",
					Text = "We may as well see where it leads. Also I wished to thank you, for your concern for me before. And express my gratitude that you decided to remain with us. I was... {#Emph}angry {#Prev}with your decision at first. But no longer." },

				{ Cue = "/VO/Melinoe_5021", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "It was not a difficult decision for me, Headmistress. It would have been harder had I realized it might anger you. I've been to both the Palace of Zeus and the House of Hades... and neither has a cauldron, or soft earth beneath my feet." },

				{ Cue = "/VO/Hecate_0820",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "I understand only too well, Melinoë, and I would have chosen the same, except... I thought you'd have been the wiser. Now you are stuck here, another lost soul in the crossroads 'twixt heaven and hell..." },

				{ Cue = "/VO/Melinoe_5022", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 2.0 },

					Text = "But I'm not lost. I'm where I wish to be." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0821", Text = "Truly..." },
					},
				},
			},

			HecateBathHouseEpilogue01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" }
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				EndWait = 0.5,
				{ Cue = "/VO/Hecate_0798",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You had an audience with the Three Fates! Your incantation from so many nights ago must have taken effect. Hermes indicated they're in good spirits, but shall be continuing their leave. Well done drawing them out nevertheless." },

				{ Cue = "/VO/Melinoe_4884", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 6.3 },

					Text = "Thank you, Headmistress. I get the impression that they sought {#Emph}me {#Prev}more so than the other way around, but at least we know they're safe. They... also mentioned {#Emph}you." },

				{ Cue = "/VO/Hecate_0799",
					PreLineWait = 0.25,
					Text = "They did, did they...? In what capacity?" },

				{ Cue = "/VO/Melinoe_4885", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They said you've... well... is there someplace more private where we can discuss this, do you think?" },

				{ Cue = "/VO/Hecate_0800",
					PreLineAnim = "Hecate_Hub_Scoff",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "{#Emph}<Sigh> {#Prev}Let's to the springs. You've earned the rest, and we can sit and talk about what's on your mind... and theirs." },

				{ Cue = "/VO/Hecate_0802",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					Text = "So, what do the three weaving-sisters know of me, then, {#Emph}hm? {#Prev}You were about to say..."
				},
				{ Cue = "/VO/Melinoe_4886", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "They told me... I believe the phrase they used was, you had {#Emph}pulled some strings. {#Prev}They didn't elaborate, but suggested I ask you about it." },

				{ Cue = "/VO/Hecate_0803",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					PreLineWait = 0.35,
					Text = "...{#Emph}Pulled strings. {#Prev}I know full well what they meant. But to this point I was uncertain whether {#Emph}they {#Prev}did. Let me twist your question back; what do {#Emph}you {#Prev}suppose they implied?" },

				{ Cue = "/VO/Melinoe_4887", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.35,
					Text = "I got the sense they felt that you had altered their designs somehow. Pulling strings... changing their weavings. And not in a small way either, but... I merely guess." },

				{ Cue = "/VO/Hecate_0804",
					Portrait = "Portrait_Hec_Bath_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_01_Exit",
					PortraitExitSound = "/Leftovers/World Sounds/Unmask",

					Text = "You don't {#Emph}merely {#Prev}anything, Melinoë. Well, if those three already know my past, you ought to know it, too. And 'tis easier to explain, I suppose, if you look upon me as I am." },

				{ Cue = "/VO/Melinoe_4888", UsePlayerSource = true,
					-- revealed
					PreLineWait = 1.35,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Bath_Shock_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Shock_01_Exit",

					Text = "Headmistress, what... I... you're... you're beautiful... but what is this, I — I don't understand... some trick you're playing or some glamour, or...?" },

				{ Cue = "/VO/Hecate_0805",
					PreLineWait = 0.5,
					PreContentSound = "/Leftovers/SFX/TextReveal",
					SecretMusic = "/Music/MusicPlayer/Iris/ArtemisSongMusicPlayer",
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "No. The trick is when the veil is {#Emph}on. {#Prev}Look upon me, and do not avert your eyes. I know those eyes better than you." },

				{ Cue = "/VO/Melinoe_4889", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_Shock_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Shock_01_Exit",
					Text = "I'm... you're... how is this possible...? Who {#Emph}are {#Prev}you?" },

				{ Cue = "/VO/Hecate_0806",
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "When I was a mere babe, I washed up on the bank of the Cocytus with naught but moonlight to guide me. Selene looked out for me; informed me that the Titan Chronos took my family, and that I alone escaped. Thus I trained." },

				{ Cue = "/VO/Melinoe_4890", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_Shock_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Shock_01_Exit",
					Text = "You trained... for the task. {#Emph}Death to Chronos. {#Prev}You attempted all of that... before {#Emph}I {#Prev}did?" },

				{ Cue = "/VO/Hecate_0807",
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "{#Emph}Before {#Prev}is not entirely correct. I was a capable student, but very raw; vengeance was my headmistress. And one night, I found the wretch. Spewed every curse that I knew... and descended into the abyss of his subconscious." },

				{ Cue = "/VO/Melinoe_4891", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_Shock_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Shock_01_Exit",
					Text = "But, I had {#Emph}you {#Prev}to teach me to descend to the abyss of the subconscious... you mean to say {#Emph}you {#Prev}figured it out entirely on your own? That's impossible!" },

				{ Cue = "/VO/Hecate_0808",
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "Speaking from experience, I beg to differ. But at any rate, something did go awry. Time and nightmare fused, and I discovered I was someplace else. I sought the end of Time... but had arrived somewhere closer to the beginning." },

				{ Cue = "/VO/Melinoe_4892", UsePlayerSource = true,
					PreLineWait = 0.25,
					Portrait = "Portrait_Mel_Bath_Shock_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Shock_01_Exit",
					Text = "And then, you lived... for aeons... waiting, for the weavings of the Fates and me? For a second chance. Headmistress, I... gods..." },

				{ Cue = "/VO/Hecate_0809",
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "I dared not tamper with the Fates' designs more than was strictly needed. In this form, I ingratiated myself to your father and mother; became handmaiden to the Queen, in fact. Thus when Chronos inevitably struck... they gave their newborn daughter not to the River Styx, but to me." },

				{ Cue = "/VO/Melinoe_4893", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_Tearful_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Tearful_01_Exit",
					Text = "Then... you did everything in your power to prepare me, so that I might succeed where you failed..." },

				{ Cue = "/VO/Hecate_0810",
					PreLineWait = 0.35,
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					Text = "Correct. 'Tis as I always told you, I am not your mother, Melinoë. Neither did I have one myself. However, I had reason to be confident in your abilities.... So, there you are! How you must hate me for all this..." },

				{ Cue = "/VO/Melinoe_4894", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_Tearful_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_Tearful_01_Exit",
					Text = "No... how can you even say that still, Headmistress? I love you... and you {#Emph}are {#Prev}my mother, whether you can admit it or not. And even if... we're far too much alike." },

				{ Cue = "/VO/Hecate_0811",
					PreLineWait = 0.35,
					Portrait = "Portrait_Hec_Bath_Unveiled_01",
					PortraitExitAnimation = "Portrait_Hec_Bath_Unveiled_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "...I love you, too, of course, Melinoë, with all my heart and soul. Far more than I could ever love myself. And I am so sorry... for all that you had to endure. For the family you never had." },

				{ Cue = "/VO/Hecate_0812",
					SecretMusic = "/EmptyCue",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Hecate_01", Icon = "Keepsake_Hecate", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostBathHouseArgs },

					-- Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "...Nary a soul must know of this, I trust you understand? The Three Fates, fine; and we, and no one else. Now then... shall we pretend that none of this transpired?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4896", Text = "I'll be discreet of course... but won't pretend." },
					},
				},
			},

			HecatePostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateBathHouseEpilogue01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0840",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					-- PreLineAnim = "Hecate_Hub_Stern_Start",
					-- PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "How are you faring of late, Melinoë? You cannot hide your troubles from me forever, so I bid you reveal them at will." },

				{ Cue = "/VO/Melinoe_5040", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm just... still thinking about our conversation at the springs, that's all. I know we mustn't speak of it, but... I understand now why you acted as you did while we were at the House." },

				{ Cue = "/VO/Hecate_0841",
					PreLineAnim = "HecateHubGreet",
					Text = "Very well. Then spare me your sympathies. I am fortunate beyond compare. Most of us do not get second chances to amend our failures." },

				{ Cue = "/VO/Melinoe_5041", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've had innumerable chances. Night after night, attempting to achieve the same result." },

				{ Cue = "/VO/Hecate_0842",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "You have not once failed. Only suffered temporary setbacks on your path to victory." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5042", Text = "Then the same could be said of you." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0843", Text = "{#Emph}Heh! {#Prev}Perhaps." },
					},
				},
			},
			HecatePostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecatePostEpilogue01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "I_Boss01", "Q_Boss01", "Q_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0844",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					-- PreLineAnim = "Hecate_Hub_Explaining_Start",
					-- PostLineAnim = "Hecate_Hub_Explaining_End",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "The pressure still is getting to you, even with the task essentially complete. 'Twas my desire to see you shake that burden from your shoulders by now. Why does it remain?" },

				{ Cue = "/VO/Melinoe_5043", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress, each night I confront these remnants of old Chronos or Typhon. Such possibilities apparently are both real and innumerable, representing so many scenarios in which, for one reason or another, I failed..." },

				{ Cue = "/VO/Hecate_0845",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "Or merely have yet to succeed. I stand as living proof that you are not alone in what you aim to accomplish, Melinoë." },

				{ Cue = "/VO/Melinoe_5044", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What are you saying, that there are others like you... like me? Attempting to achieve the same result?" },

				{ Cue = "/VO/Hecate_0846",
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",
					Text = "I merely ask you to consider how the efforts you go to, the {#Emph}lengths {#Prev}you go to, may {#Emph}reverberate. {#Prev}The energy we put into this world comes back to us. Simply put, I am only here because {#Emph}you {#Prev}are." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5045", Text = "But it's the other way around..." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0847", Text = "Is it...?" },
					},
				},
			},

			HecateAboutSayingLittle01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateGreeting,

				{ Cue = "/VO/Hecate_0865",
					-- PreLineAnim = "Hecate_Hub_Affirm",
					-- PreLineAnim = "Hecate_Hub_Salute",
					-- PreLineAnim = "Hecate_Hub_Scoff",
					-- PreLineAnim = "Hecate_Hub_Explaining_Start",
					-- PostLineAnim = "Hecate_Hub_Explaining_End",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "This all has come to be a comfortable routine. Each night you return refreshed; tireless. But I, at least, ought take a bit of rest." },

				{ Cue = "/VO/Melinoe_5298", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think we have things under control lately, so please do. Will you be going anywhere?" },

				{ Cue = "/VO/Hecate_0866",
					PreLineWait = 0.25,
					Text = "Not yet. But I may be less talkative, as is my tendency." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5299", Text = "Be well, Hecate." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Hecate_01",
						{ Cue = "/VO/Hecate_0867", Text = "And you." },
					},
				},
			},

			-- partner conversations
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
				StatusAnimation = false,
				CopyDataFromPartner = true,
			},
			OdysseusWithHecate03 =
			{
				Partner = "NPC_Odysseus_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				CopyDataFromPartner = true,
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
			NemesisWithHecate02 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
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
			ArachneWithHecateInHub01 =
			{
				Partner = "NPC_Arachne_Home_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				InitialGiftableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
			},
			ArachneWithHecateInHub02 =
			{
				Partner = "NPC_Arachne_Home_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				InitialGiftableOffSource = true,
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
			},
			ErisWithHecate01 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			IcarusWithHecate01 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				CopyDataFromPartner = true,
			},
			MorosWithHecate01 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},

			NyxWithHecate01 =
			{
				Partner = "NPC_Nyx_Story_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
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
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
						},
					},
				},
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
					Text = "I leaden our enemies with the weight of my curse. So mote it be." },
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
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
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
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
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
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
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
					Portrait = "Portrait_Mel_Empathetic_01",
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
						-- PathTrue = { "GameState", "TextLinesRecord", "HecateGift01" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "HecateGift02" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "HecateGift03" },
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
						-- PathTrue = { "GameState", "TextLinesRecord", "HecateGift04" },
					},
				},
				{ Cue = "/VO/Hecate_0458",
					Text = "I've little taste for the traditions of the gods, you know. Lest you forget, I am a Titaness. More in common with our old enemy I daresay, than with the likes of Zeus and his ilk." },
				{ Cue = "/VO/Melinoe_2166", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No matter your heritage, Headmistress, you have been a sure and steady guardian of mine throughout my life. A bit of tradition helps express the gratitude I feel." },
				{ Cue = "/VO/Hecate_0459",
					Text = "Tradition is all well and good lest 'tis followed blindly; senselessly, I should say, for the blind are often very much aware. But let me not belabor your kind gesture; I am grateful, truly." },
			},
			HecateGift06 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "HecateGift05" },
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
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've often said, what we intend and what we do are not the same. I know you're not my birthmother, so what? You've cared for me; that's more than enough." },
				{ Cue = "/VO/Hecate_0542",
					Text = "I've used you, and I'm using you still. Can't you see that? I've attempted not to hide this fact from you. Yet you turn it aside." },
				{ Cue = "/VO/Melinoe_2169", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "You have raised me in accordance with the promises you made to my father. He never asked you to coddle me, did he? Surely he wanted me to fend for myself." },
				{ Cue = "/VO/Hecate_0543",
					Text = "And do you think you can? You remain under my auspices, take aid from Olympus! You're not as independent as I planned. And furthermore, I've inadvertently caused you to think I've made you better off!" },
				{ Cue = "/VO/Melinoe_2170", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
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

			HecateGift07 =
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
						PathTrue = { "GameState", "TextLinesRecord", "HecateTaverna02" },
					},
				},
				{ Cue = "/VO/Melinoe_5029", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "Why don't we head to the taverna once again? You honored {#Emph}me {#Prev}before, and I would dearly like to honor {#Emph}you." },

				{ Cue = "/VO/Hecate_0830",
					PreLineAnim = "HecateHubGreet",
					Text = "Then consider me honored. I've no desire to be worshiped thus; the Shades can leave their offerings for the hounds." },

				{ Cue = "/VO/Melinoe_5030", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress, you're the reason all of us are here. The Shades adore you, and wish to commemorate that this great task you devised is finally complete!" },

				{ Cue = "/VO/Hecate_0831",
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					Text = "We achieved what needed to be done, and we commemorated it last we attended the taverna. Now, hand over that Ambrosia, and I'll keep it for the next occasion." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5686", Text = "It's yours..." },
					},
				},
			},

			HecateGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				-- NemesisGiftHint intended as this is a 'grudging' acceptance
				HintId = "Codex_NemesisGiftHint01",
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateTaverna02" },
					},
				},
				{ Cue = "/VO/Melinoe_5032", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "You mentioned holding onto Ambrosia for the next celebratory occasion, so I wanted to donate more for when the time comes. To the next great victory of the Unseen!" },

				{ Cue = "/VO/Hecate_0832",
					PreLineAnim = "Hecate_Hub_Scoff",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, {#Emph}stop{#Prev}, Melinoë! Evidently neither of us knows what to do with themselves now, as you are so {#Emph}insistent {#Prev}on these most-unnecessary gifts! Leave me in peace." },

				{ Cue = "/VO/Melinoe_5687", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I wasn't trying to upset you.... Did you truly wish for me to stay there in the House that much? With Mother and Father... where I belong, you always said." },

				{ Cue = "/VO/Hecate_0833",
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "Purge {#Emph}that {#Prev}poisoned thought at once. I taught you a great deal in some respects but to the detriment of your experience in other walks of life." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.48,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5688", Text = "...I learn quickly." },
					},
				},
			},

			-- taverna
			HecateTaverna01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift06" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3886", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Headmistress? I've a bottle of Ambrosia here, and... thought perhaps that we could share it at the taverna, if you could step away with me a bit! I know it's an odd time..." },

				{ Cue = "/VO/Hecate_0696",
					PreLineAnim = "HecateHubGreet",
					PreLineWait = 0.35,
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "...Melinoë, I'm going to resist my impulse to tersely decline, so that I might remind myself as to whether the greatest of Olympian delicacies lives up to its reputation! Let's be off." },

				{ Cue = "/VO/Hecate_0697",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "...I had not given this taverna any real thought. Such gathering-places, where one can be unguarded... dare-I-say relaxed? A liability. We need our senses sharp." },

				{ Cue = "/VO/Melinoe_3887", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But now that you're here, you've come to realize that having such a place where we and Shades can comingle has its benefits? And that I didn't overstep when I restored it?" },

				{ Cue = "/VO/Hecate_0698",
					SkipContextArt = true,
					Text = "Yes I have, and no, you did not. The tension about these Crossroads has grown too palpable for my liking, as this much nervous energy does our cause no good. But, I digress. Discussion of our cause ought be off limits here." },

				{ Cue = "/VO/Melinoe_3888", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Ah yes, more rules! Just what this taverna needs to ease the tensions of our small band of loyalists. I think you're onto something, Headmistress!" },

				{ Cue = "/VO/Hecate_0699",
					PreLineAnim = "Hecate_Hub_Affirm",
					SkipContextArt = true,
					Text = "{#Emph}Ohh{#Prev}, I see how it is. What, a sip or two of Ambrosia and suddenly your inhibitions are all gone? A powerful effect! We ought to use it in the cauldron if not here." },

				{ Cue = "/VO/Melinoe_3889", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "...We're still talking about our cause, and our craft. Why don't you... tell me of a time when you were closer to my age, if you don't mind?" },

				{ Cue = "/VO/Hecate_0700",
					SkipContextArt = true,
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",

					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "I mind. Though perhaps as we delve deeper into this bottle, I shall not mind as much! Shall we find out? To discovering the truth!" },

				{ Cue = "/VO/Hecate_0701",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					PreLineAnim = "HecateHubGreet",
					Text = "...Ignore my sullen turn back there, Melinoë. These evenings I am more concerned about the future than the past. I trust I did not overly affect the atmosphere." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3891", Text = "Nonsense, Headmistress. We're grateful you could join us." },
					},
				},
			},
			HecateTaverna02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HecateUnlockHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HecateGift06", "HecateTaverna01", "HecatePostTrueEnding02" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_5023", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Would you care to split this bottle of Ambrosia, Headmistress? We never truly celebrated the restoration of the Underworld's King and Queen here." },

				{ Cue = "/VO/Hecate_0824",
					PreLineAnim = "Hecate_Hub_Scoff",
					PreLineWait = 0.35,
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Sipping the drink of your mountain relatives hardly seems suitable festivity, though very well. You are correct that these Shades shall be expecting {#Emph}something." },

				{ Cue = "/VO/Hecate_0825",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					PreLineAnim = "Hecate_Hub_Stern_Start",
					PostLineAnim = "Hecate_Hub_Stern_End",
					PreContentSound = "/Leftovers/SFX/ImpCrowdImpressed",
					Text = "...And so, I bid you all salute your Princess of the Underworld, who never relented against the threat of Time itself, and the Father of All Monsters, amongst many others!" },

				{ Cue = "/VO/Melinoe_5024", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreContentSound = "/SFX/ScyllaCrowdApplause2",
					Text = "Thank you, Headmistress. {#Emph}Everyone! {#Prev}I never could have done this without you... without these Crossroads, the one place I could always return to in a moment of need." },

				{ Cue = "/VO/Hecate_0826",
					SkipContextArt = true,
					PreLineAnim = "Hecate_Hub_Affirm",
					Text = "You are welcome here and safe, Melinoë. And whilst we had utmost faith in you, nevertheless what you accomplished was beyond imagining." },

				{ Cue = "/VO/Melinoe_5025", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "I did what you trained me to do. I'm grateful for your patience through all the many setbacks I had to overcome." },

				{ Cue = "/VO/Hecate_0827",
					SkipContextArt = true,
					Text = "How else could we have stood against Time itself if not through patience? I knew you would be a capable student. 'Tis the only reason I pushed you as hard as I did." },

				{ Cue = "/VO/Melinoe_5026", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "So then what happens now to the Unseen? Our Shades each have an honorary place in Elysium waiting for them..." },

				{ Cue = "/VO/Hecate_0828",
					SkipContextArt = true,
					PreLineAnim = "Hecate_Hub_Explaining_Start",
					PostLineAnim = "Hecate_Hub_Explaining_End",

					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/SFX/ScyllaCrowdApplause1", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "That may be, if they decide to leave. But, I suspect they're in no greater hurry to abandon this place than are you. There is always more we may accomplish here, and we stand to go farther together than alone." },

				{ Cue = "/VO/Hecate_0829",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					PreLineAnim = "HecateHubGreet",
					Text = "...Well, 'twas not the most formal gathering, but my sense is that it was worthwhile? All these Shades... they arrived here for lack of anyplace to go. Now, 'tis a permanent home." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_5028", Text = "Not just a place to stop... a place to stay." },
					},
				},
			},
			HecateTavernaDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_3892", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't suppose I could persuade you to come join me at the taverna for a bottle of Ambrosia, could I, Headmistress?" },
				{ Cue = "/VO/Hecate_0702",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "SuperGiftPointRefundPresentation",
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "No, I don't suppose you can, not now. I shan't darken the mood there amongst the Shades requiring respite." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2095", Text = "They're missing out I'm sure." },
					},
				},
			},

			HecateFishing01 =
			{
				PauseMusicPlayerMusic = true,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0669", UsePlayerSource = true,
					Text = "The Cocytus teems with life there by the riverbank again, Headmistress. Would you please join me for a look?" },

				{ Cue = "/VO/Hecate_0378",
					PostLineRemoveContextArt = true,
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
					Text = "Hold, lest you frighten the river denizens; only {#Emph}then {#Prev}should my time be wasted here, Melinoë! You mistook the meaning of my words. Your capacity to still your racing mind is not a detriment. 'Tis a growing strength!" },

				{ Cue = "/VO/Melinoe_3455", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I'm... surprised you see it that way. Sometimes I feel I'm losing my focus. Why else would I have brought us here?" },

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
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "The river always provides, and let no such task ever be beneath us." },
			},
			HecateFishing02 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithLuresIcon",
				FilledIcon = "FilledHeartWithLuresIcon",
				HintId = "Codex_FishingGiftHint",
				CompletedHintId = "Codex_PreBondForgedHecate",
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateGift08" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_5035", UsePlayerSource = true,
					Text = "I don't suppose you'd be willing to head to the fishing pier with me again? Good place to occupy our minds with other matters for a little while." },

				{ Cue = "/VO/Hecate_0834",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PreLineAnim = "HecateHubGreet",
					Text = "That it can be. Then very well. There is aught I wish to speak with you about, besides." },

				{ Cue = "/VO/Hecate_0835",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					PreLineWait = 0.5,
					Text = "...You truly believe I wish to rid myself of you? Either that or you sought to wound me more deeply with your words than you're able to with the Nocturnal Arms." },

				{ Cue = "/VO/Melinoe_5036", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "I'm sorry, Headmistress, it's just... at the House, I realized I didn't just want my family back... I wanted you to be happy. But I felt like you were pushing me away." },

				{ Cue = "/VO/Hecate_0836",
					SkipContextArt = true,
					PreLineAnim = "Hecate_Hub_Scoff",
					Text = "My happiness is neither your responsibility nor is it within your grasp. And 'tis I who ought apologize. For all that I put you through. Forgive me." },

				{ Cue = "/VO/Melinoe_5037", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "{#Emph}Never apologize when you are not at fault{#Prev}, you used to say. You were never easy on me, but also were never cruel. You taught me the difference, among so many things." },

				{ Cue = "/VO/Hecate_0837",
					SkipContextArt = true,
					Text = "A lack of cruelty is not the highest standard. At any rate, evidently I've taught you enough. I still shall challenge you in Erebus for sake of fitness and attunement, but in time, perhaps you shall refer to me not by title, but by name..." },

				{ Cue = "/VO/Melinoe_5038", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not as Headmistress, but as Hecate... that shall take a while. To think I used to use your name so casually when I was little. Much comes full circle with time." },

				{ Cue = "/VO/Hecate_0838",
					SkipContextArt = true,

					Text = "More than you know. Now, let us shift our focus to the river denizens getting too close a listen for their own good...",
					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Hecate_0839",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Hec_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFLegendary", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "That was a pleasant enough outing, but speak not to me of happiness again. 'Tis a foolish thing with which to be concerned; a byproduct of fulfillment, nothing more." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_5039", Text = "Of course. Thank you, Headmistress... Hecate." },
					},
				},
			},


			HecateBathHouse01 =
			{
				PauseMusicPlayerMusic = true,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0665", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
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
				PauseMusicPlayerMusic = true,
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_0667", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					Text = "Well, now at least you know the reason that your training was so rigorous! There came a point when even my vast tolerance for all your splashing finally wore thin." },
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0668", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I know it's a difficult time, Headmistress, but just in case, would you be interested in joining me for a brief while at the hot springs?" },
				{ Cue = "/VO/Hecate_0239",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "As much as I would enjoy basking in the springs, I've incantations to complete, wards to reinforce.... No, I cannot. Not now." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},
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
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_5306", UsePlayerSource = true,
					Text = "Do you suppose we could take a brief break from all this and stop by the river over at the pier?" },
				{ Cue = "/VO/Hecate_0260",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "I do wish to see firsthand whether your skill at fishing has improved, yet unfortunately I have other matters that I must attend to now." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						-- Maybe some other time.
						-- { Cue = "/VO/Melinoe_0461", Text = "Maybe some other time." },
					},
				},
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
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
						NamedRequirementsFalse = { "HecateMissing" },
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
					{ Cue = "/VO/Melinoe_1725", Text = "Headmistress is away.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1726", Text = "No sign of Headmistress." },
					{ Cue = "/VO/Melinoe_1727", Text = "Where are you, Headmistress...",
						GameStateRequirements =
						{
							{
								SumPrevRuns = 8,
								Path = { "SpeechRecord", "/VO/Melinoe_1727" },
								CountPathTrue = true,
								Comparison = "<=",
								Value = 0,
							},
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

		Using = { Sound = "/Leftovers/SFX/ImpCrowdImpressed", "/Leftovers/SFX/TextReveal", },
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
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateHiding01,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},
				EndFunctionName = "HecateHideAndSeekExit",
				EndFunctionArgs = { WaitTime = 0.5, TeleportId = 583640, AngleTowardTargetId = 560721 },
				
				{ Cue = "/VO/Melinoe_2120", UsePlayerSource = true,
					PreLineAnim = "Melinoe_Young_Excited_Start", PreLineAnimTarget = "Hero",
					PostLineAnim = "Melinoe_Young_Excited_End", PostLineAnimTarget = "Hero",
					Speaker = "PlayerUnit_Flashback",
					Emote = "PortraitEmoteFiredUp",
					Text = "Got you, Hecate!! You're dead!" },
				{ Cue = "/VO/Hecate_0516",
					PreLineAnim = "Hecate_Hub_Hide_End",
					PostLineFunctionName = "UpdateHubMainFlashback",
					PostLineFunctionArgs = { Hecate = true },
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
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HecateHiding02,
				PreEventFunctionName = "GenericPresentation",
				PreEventFunctionArgs =
				{
					KillTaggedThread = "HecateHideAndSeekHint",
				},
				EndFunctionName = "HecateHideAndSeekExit",
				EndFunctionArgs = { WaitTime = 0.5, TeleportId = 583642, AngleTowardTargetId = 783260 },
				
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
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
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

			-- @ ending
			HadesTrueEnding01 =
			{
				Partner = "NPC_Hades_02",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
			},
		}
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hecate )