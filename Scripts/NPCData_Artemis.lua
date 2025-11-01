UnitSetData.NPC_Artemis =
{
	-- Artemis, Id = 561502 (Field Version Below)
	NPC_Artemis_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Artemis_Default_01",
		AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SubtitleColor = Color.ArtemisVoice,
		EmoteOffsetY = -260,
		EmoteOffsetX = -30,

		SpeakerName = "Artemis",
		LoadPackages = { "Artemis" },
		ThemeMusic = "/Music/ArtemisTheme_MC",
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		TurnInPlaceAnimation = "Artemis_Turn",

		SingingTeleportToId = 742272,
		SingingAngleTowardTargetId = 742157,
		SingingTeleportOffsetX = 20,
		SingingTeleportOffsetY = 40,
		SingingOverwriteSelf =
		{
			UseTextTalkAndSpecial = "ArtemisSingingUseTextTalkAndSpecial",
			UseTextSpecial = "ArtemisSingingUseTextSpecial",
			SpecialInteractFunctionName = "UseArtemisJoinSong",
			SpecialInteractGameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" },
				},
			},
			SpecialInteractCooldown = 0.0,
		},

		ActivateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "ChronosBossOutro01", "PrometheusFirstMeeting", "HermesFieldAboutTyphon01" }
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				-- PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1711", Text = "Together we shine, Sister.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				ObjectTypes = { "NPC_Artemis_Field_01", "NPC_Artemis_01" },
				PreLineAnim = "Artemis_Salute",
				GameStateRequirements =
				{
					{
						-- Artemis song not playing
						Path = { "AudioState", "AmbientTrackName" },
						IsNone = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
				},
				-- PreLineThreadedFunctionName = "PlayCharacterAnim",
				-- PreLineThreadedFunctionArgs = { Name = "Artemis_Salute", WaitTime = 1, AngleNPCToHero = true, },

				{ Cue = "/VO/Artemis_0130", Text = "Moonlight guide you." },
				{ Cue = "/VO/Artemis_0125", Text = "Together we shine.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_1697", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0132", Text = "Stay safe, Sister.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0137", Text = "{#Emph}Erm{#Prev}, hey?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0241", Text = "Together we shine!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_1697", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0242", Text = "Hello again.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0243", Text = "Hey.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0244", Text = "He's marked.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0245", Text = "You, too.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0246", Text = "You as well.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0247", Text = "And our aim be true.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},

			},
		},
		SingingReactionVoiceLines =
		{
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.25,
			SuccessiveChanceToPlayAll = 0.25,
			PreLineWait = 3.0,
			ObjectTypes = { "NPC_Artemis_01" },
			RecheckRequirementsPostWait = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Hero", "JoinedInArtemisSong" },
				},
			},

			{ Cue = "/VO/Artemis_0302", Text = "{#Emph}Go{#Prev}, Sister!" },
			{ Cue = "/VO/Artemis_0303", Text = "{#Emph}Sing {#Prev}it!" },
			{ Cue = "/VO/Artemis_0304", Text = "That's it!", PlayFirst = true },
			{ Cue = "/VO/Artemis_0305", Text = "Together now!" },
			{ Cue = "/VO/Artemis_0306", Text = "Melinoë!" },
			{ Cue = "/VO/Artemis_0307", Text = "There we go!" },
		},

		InteractTextLineSets =
		{
			-- story events (home)
			ArtemisHubFirstMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ChronosBossOutro01" },
					},
					{
						-- PathFalse = { "CurrentRun", "Cleared" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					--[[
					{
						FunctionName = "RequiredAlive",
						-- FunctionArgs = { Ids = { 556921 }, },
						FunctionArgs = { Units = { "NPC_Hecate_01" }, },
					},
					]]--
					NamedRequirementsFalse = { "ArtemisLeavesHubAfterTrueEnding" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisGreeting,

				{ Cue = "/VO/Artemis_0152",
					Text = "Hey Melinoë, I just wrapped a debrief here with Sister Hecate. This place has changed a {#Emph}lot {#Prev}since last I checked!" },
				{ Cue = "/VO/Melinoe_1187", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hi Artemis, welcome! We've had to scramble a bit to make ready for everything. Can I show you around? Have you said hi to Nemesis?" },
				{ Cue = "/VO/Artemis_0153",
					PreLineAnim = "Artemis_Shrug",
					PostLineThreadedFunctionName = "ArtemisExitPresentation", PostLineFunctionArgs = { AnimationState = "Artemis_Disappear", WaitTime = 3.1 },
					Text = "Oh, {#Emph}no{#Prev}, I have to go. Olympus needs me back up top, at least a little while. Maybe next time, all right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1188", Text = "I hear you. Bye for now." },
					},
				},
			},

			ArtemisHubAboutChronosBoss01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubFirstMeeting01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisHubFirstMeeting01" }, Min = 5 },
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">",
						Value = 2,
					},
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasAll = { "WorldUpgradeBathHouse", "WorldUpgradeTaverna" },
					},
					NamedRequirementsFalse = { "ArtemisLeavesHubAfterTrueEnding" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisGreeting,

				{ Cue = "/VO/Artemis_0187",
					Text = "Good, there you are! I'm late getting back but couldn't bring myself to leave before you were up and about again. How are you feeling?" },
				{ Cue = "/VO/Melinoe_3598", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Considering the Titan of Time almost sliced me in two last night with a scythe twice my size that cuts through the air itself, I could be worse. Thank you for waiting up for me." },
				{ Cue = "/VO/Artemis_0188",
					PreLineAnim = "Artemis_Shrug",
					PostLineThreadedFunctionName = "ArtemisExitPresentation", PostLineFunctionArgs = { AnimationState = "Artemis_Disappear", WaitTime = 3.1 },
					Text = "Of course! I like what you've done to this place. It's like a proper war camp now! With a taverna, hot springs... I ought to stop in more often. Shine on without me for now!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3497", Text = "Shine on yourself!" },
					},
				},
			},

			ArtemisHubSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubFirstMeeting01" },
					},
					{
						PathFalse = { "PrevRun", "SpawnRecord", "NPC_Artemis_01" },
					},
					NamedRequirementsFalse = { "ArtemisSingingBlockedByEvents" },
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSinging_FromStart,

				{ Cue = "/VO/Melinoe_4028", UsePlayerSource = true,
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, didn't mean to interrupt. I'd not expected this to be a time for song, though neither am I complaining." },
				{ Cue = "/VO/Artemis_0262",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Nor should you be! Hey, since you're here, why not lend me your voice for old time's sake? Let go your burdens for a bit. Not like they're going anywhere." },
			},
			ArtemisHubSinging02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSinging,
				{ Cue = "/VO/Artemis_0263",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					Text = "I see that look and know you must be going through a lot, Melinoë. But don't forget what we decided here." },
				{ Cue = "/VO/Melinoe_4029", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We leave our worries at the threshold to this little clearing, yes... though, don't you ever slip? Catch your mind drifting back to your concerns?" },
				{ Cue = "/VO/Artemis_0264",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "That's what the song is for! It doesn't make our troubles go away; it's so we can face them as best we can." },
			},
			ArtemisHubSinging03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSinging,
				{ Cue = "/VO/Melinoe_4030", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sister Artemis. I really have to talk to you about something of the utmost importance, right now." },
				{ Cue = "/VO/Artemis_0265",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Nice try, Sister Melinoë, but I won't break that easily. Not {#Emph}here! {#Prev}Now are you going to join in or not?" },
			},
			ArtemisHubSinging04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSinging_FromStart,
				{ Cue = "/VO/Artemis_0266",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "I've heard about the latest happenings, Sister, but we'll discuss them out there on the hunt. Not while we're here." },
			},

			ArtemisHubSingingAboutRecordKeeper01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGameStats" },
					},
					{
						SumPrevRuns = 8,
						Path = { "WorldUpgradesAdded", "WorldUpgradeGameStats" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},					
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubFirstMeeting01" },
					},
					{
						PathFalse = { "PrevRun", "SpawnRecord", "NPC_Artemis_01" },
					},
					NamedRequirementsFalse = { "ArtemisSingingBlockedByEvents" },
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSinging,

				{ Cue = "/VO/Artemis_0430",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					Text = "Who is that Shade across the river over there, with all the parchment stacks? Never looks directly at me but keeps glancing over, as though it isn't obvious." },
				{ Cue = "/VO/Melinoe_4941", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, you must mean the Record Keeper, who's probably just intrigued by your beautiful song. And likely is keeping meticulous track somewhere of each time you sing." },
				{ Cue = "/VO/Artemis_0431",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Well it's a good thing I am not self-conscious in the least." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Artemis_01",
						{ Cue = "/VO/Artemis_0432", Text = "Hey Record Keeper! This one's for you!", PostLineFunctionName = "RecordKeeperReaction" },
					},
				},
			},

			ArtemisHubSingingEndTheme01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubFirstMeeting01" },
					},
					{
						PathFalse = { "PrevRun", "SpawnRecord", "NPC_Artemis_01" },
					},
					NamedRequirementsFalse = { "ArtemisSingingBlockedByEvents" },
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingEndTheme_FromStart,

				{ Cue = "/VO/Artemis_0428",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "I'll admit it, Apollo had a lot to do with this one. But I still like it... and it reminds me of how we all got to soar together through the sky. Join me a bit?" },
			},

			-- repeatable singing
			ArtemisHubSingingRepeatable01 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0267",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "On a bit of a break, Sister. Join me for a verse or two?" },
			},
			ArtemisHubSingingRepeatable02 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0268",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Apollo gets to do the singing on Olympus, I get to do it here." },
			},
			ArtemisHubSingingRepeatable03 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0269",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "We all have our little rituals to calm our nerves." },
			},
			ArtemisHubSingingRepeatable04 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0270",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "I always liked it here, and the Shades don't seem to mind." },
			},
			ArtemisHubSingingRepeatable05 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0271",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Not concerned about a thing, nor should you be. Not here." },
			},
			ArtemisHubSingingRepeatable06 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0272",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Your body has recovered, sure. But what about your mind?" },
			},
			ArtemisHubSingingRepeatable07 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						Path = { "CurrentRun" },
						HasAny = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom_FromStart,

				{ Cue = "/VO/Artemis_0273",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "This is our song of victory; or any occasion, really. Want in?" },
			},
			ArtemisHubSingingRepeatable08 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0274",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "When things don't go our way, we sing... if only for a little bit." },
			},
			ArtemisHubSingingRepeatable09 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom_FromStart,

				{ Cue = "/VO/Artemis_0275",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Things did not go well last night, but that's all in the past." },
			},
			ArtemisHubSingingRepeatable10 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0276",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "I have to get back to the hunt here soon, though... not just yet." },
			},
			ArtemisHubSingingRepeatable11 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom_FromStart,

				{ Cue = "/VO/Artemis_0277",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Hey, I can't exactly practice like this on Olympus, you know!" },
			},
			ArtemisHubSingingRepeatable12 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0278",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Don't think too much about it, Sister, just join in a little while." },
			},
			ArtemisHubSingingRepeatable13 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom_FromStart,

				{ Cue = "/VO/Artemis_0279",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "No need to use our plain old speaking voices here, Sister." },
			},
			ArtemisHubSingingRepeatable14 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0280",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "I feel self-conscious singing on Olympus, but not here." },
			},
			ArtemisHubSingingRepeatable15 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0281",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "This song is dedicated to all the Shades out there!" },
			},
			ArtemisHubSingingRepeatable16 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0282",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Each night brings us new possibility, and I will sing to that!" },
			},
			ArtemisHubSingingRepeatable17 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						PathTrue = { "CurrentRun", "SpecialInteractRecord", "NPC_Artemis_01" },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingRandom,

				{ Cue = "/VO/Artemis_0283",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Done with singing already...? Well I'm done with chatting!" },
			},
			ArtemisHubSingingRepeatable18 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
				},
				OnQueuedFunctionName = "ArtemisMusic",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisSingingEndTheme,

				{ Cue = "/VO/Artemis_0429",
					PreLineFunctionName = "ArtemisStopSingingForNarrative",
					PostLineFunctionName = "ArtemisStartSingingPresentation",
					Text = "Apollo's not around to sing the other part, but you sure are!" },
			},

		},

		GiftTextLineSets =
		{
			ArtemisGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Melinoe_1194", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's been a pleasure to have worked more closely with you, Sister Artemis. This is hardly worth the gift of impeccable precision, though I wanted you to have it." },
				{ Cue = "/VO/Artemis_0163",
					PreLineAnim = "Artemis_Shrug",
					Text = "Doing the old traditions now, are we? Well sure, then I accept your offering, Sister Melinoë. And I've an offering for {#Emph}you{#Prev}, in kind!" },
			},
			ArtemisGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithProphecyIcon",
				FilledIcon = "FilledHeartWithProphecyIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0164",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.2, AngleNPCToHero = true, },
					Text = "You do know we have {#Emph}barrels {#Prev}of this stuff up on Olympus, right? Used to, at least. Damn near forgotten what it tastes like, come to think..." },
				{ Cue = "/VO/Melinoe_1195", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "May the good memories come flooding back! Whenever you have the time for it, of course." },
			},

			ArtemisGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0189",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.2, AngleNPCToHero = true, },
					Text = "What's all this extra generosity from you lately? It's putting me on edge. Don't you go acting like this is goodbye...!" },
				{ Cue = "/VO/Melinoe_2341", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's merely that the arrow-riddled remnants of my foes give me occasion to reflect! I tell myself never to take my dear friends for granted." },
			},

			ArtemisGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0190",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.2, AngleNPCToHero = true, },
					Text = "I can't exactly drink this on the hunt, you know! But I can squirrel it away for safekeeping. Maybe once all this is settled, we can share a bottle and get properly caught up." },
				{ Cue = "/VO/Melinoe_2342", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Or, failing that, we could always keep on teaming against vengeful spirits and the like! Although it's nice to keep the possibility in mind." },
			},

			ArtemisGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0191",
					Text = "Hey, thank you! Olympus started running a little low on this stuff. I'll be sure to lord it over the others, as long as you don't mind me exploiting your good graces." },
				{ Cue = "/VO/Melinoe_3502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't recall anything about exploiting one another's good graces in the bylaws of the Silver Sisters, so you should be fine! May you enjoy it either way." },
			},

			ArtemisGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0192",
					PreLineWait = 0.35,
					Text = "...Hard making friends with goddesses, but I have what {#Emph}I {#Prev}need. We can be on our own without feeling alone, you know? I hope you know. That's how it is for me." },
				{ Cue = "/VO/Melinoe_3503", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I do know, and feel much the same. When we're not watching one another's backs, we have Selene and Headmistress watching over us. Still, it's always good to see you face-to-face." },
				{ Cue = "/VO/Artemis_0193",
					Text = "You, too. Most of my family I can do without most of the time. You're an exception! We may not be sisters by blood, but... you'll always be Sister Melinoë to me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3504", Text = "Likewise, Sister Artemis." },
					},
				},
			},
			ArtemisGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_ArtemisUnlockHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift06", "ArtemisAboutTeamwork01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4093", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, thought I'd get you some of the good stuff. I suppose there's a real possibility it's become somewhat easier to come by here than where you call home." },
				{ Cue = "/VO/Artemis_0389",
					Text = "Hey, Ambrosia! Callisto always used to love this stuff. Maybe I'll call on her again once things cool off a bit." },
				{ Cue = "/VO/MelinoeField_4094", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your assignment must have taken you away from her... I'm sorry, I didn't even consider that till just now. She isn't angry with you, is she?" },
				{ Cue = "/VO/Artemis_0390",
					PreLineAnim = "Artemis_Shrug",
					Text = "Well when she turns into a bear it usually means she is, and she'd been doing that a lot. So it's good we're on a little break! It means I'm {#Emph}much {#Prev}less likely to get mauled." },
			},
			ArtemisGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisAboutTeamwork01", "ArtemisGift07" }
					},
				},
				{ Cue = "/VO/MelinoeField_4095", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Got something for you and perhaps Callisto here, if you decide to brave the dangers of approaching her again." },
				{ Cue = "/VO/Artemis_0391",
					Text = "{#Emph}Oh{#Prev}, thank you very much! I haven't yet decided whether to share this stuff with my Nymph friends, when I {#Emph}could {#Prev}just hoard it all for {#Emph}myself..." },
				{ Cue = "/VO/MelinoeField_4096", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wouldn't taste any better that way, so you might as well share it or at least pass it on to someone who shall. Not getting on with the Nymphs as much lately?" },
				{ Cue = "/VO/Artemis_0392",
					PreLineAnim = "Artemis_Shrug",
					Text = "They're not keen about me going off to war. It's like I'm not even the goddess of the hunt to them, which is part of the appeal, granted. But, you and I, we have a job to do." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/MelinoeField_4097", Text = "We do." },
					},
				},
			},
			ArtemisGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisAboutTeamwork01", "ArtemisGift08" }
					},
				},
				{ Cue = "/VO/MelinoeField_4098", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This one is just for you, Artemis, so don't even think about giving it to your Nymph friends. Not even Callisto, no matter how threatening her bear form may be." },
				{ Cue = "/VO/Artemis_0393",
					PreLineAnim = "Artemis_Shrug",
					Text = "OK, OK, if you insist! But, what am I supposed to do with it? I travel light, and lately haven't often stopped by home." },
				{ Cue = "/VO/MelinoeField_4099", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How about you stash it away, under a rock, or in a hollowed stump or somesuch place? And one of these nights, we can enjoy it for ourselves." },
				{ Cue = "/VO/Artemis_0394",
					PreLineAnim = "Artemis_Salute",
					Text = "Now {#Emph}that {#Prev}is a proper plan, Sister Melinoë. I'll hold you to it though, you realize. How about we wait until the Moon is new... don't want Sister Selene getting the wrong idea." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/MelinoeField_4100", Text = "{#Emph}Hahah{#Prev}, fine." },
					},
				},
			},
			-- bond forged 
			ArtemisGift10 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				CompletedHintId = "Codex_BondForgedArtemis",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisAboutTeamwork01", "ArtemisGift09" }
					},
				},
				{ Cue = "/VO/MelinoeField_4101", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					Text = "Hey, I did want to hand over one last bottle, and by {#Emph}last {#Prev}I mean until we find ourselves in different circumstances finally. But {#Emph}this {#Prev}one is for your Nymph friends, {#Emph}not {#Prev}you." },

				{ Cue = "/VO/Artemis_0395",
					Text = "{#Emph}Oh! {#Prev}Have all my tales of Callisto piqued your interest there, Melinoë? Because I'm open to sharing, and I know {#Emph}she {#Prev}is." },

				{ Cue = "/VO/MelinoeField_4102", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}No! {#Prev}I mean, that wasn't my intent, it's just... if they've been close with you, and raised your spirits, then I'm grateful for them. They must be worried about you." },

				{ Cue = "/VO/Artemis_0396",
					PreLineAnim = "Artemis_Shrug",
					Text = "I don't know {#Emph}why{#Prev}, when I constantly tell them not to. Though thank you, really. And I'll pass this on next chance I get, with your compliments. But first, promise me one thing." },

				{ Cue = "/VO/MelinoeField_4103", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I just gave you multiple Ambrosia bottles and you want a promise, too? What is it, then?" },

				{ Cue = "/VO/Artemis_0397",
					Text = "You can survive on the surface for a while, so... come join us in our woods sometime. Doesn't have to be soon, wait till all this is over. I just think you'd enjoy it." },

				{ Cue = "/VO/MelinoeField_4104", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Artemis_01", Icon = "Keepsake_Artemis" },

					Text = "...All right. When all this is over, I promise to meet your Nymph friends in your woods, and enjoy it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Artemis_Field_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Artemis_0398", Text = "I'll hold you to that." },
					},
				},
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1732", Text = "Truly? You're the best." },
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
		},

		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.15,
				Cooldowns =
				{
					{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/Artemis_0036", Text = "Finally tracked you down...", PlayFirst = true },
				{ Cue = "/VO/Artemis_0037", Text = "Got here as quickly as I could." },
				{ Cue = "/VO/Artemis_0038", Text = "I have your back, Sister!" },
				{ Cue = "/VO/Artemis_0039", Text = "Multiple targets sighted." },
				{ Cue = "/VO/Artemis_0040", Text = "This won't take long." },
				{ Cue = "/VO/Artemis_0041", Text = "Hold on, Sister!" },
				{ Cue = "/VO/Artemis_0042", Text = "They won't know what hit them." },
				{ Cue = "/VO/Artemis_0043", Text = "Let's take these wretches down." },
				{ Cue = "/VO/Artemis_0044", Text = "Oh good, some target practice then!" },
				{ Cue = "/VO/Artemis_0045", Text = "Providing covering fire!" },
				{ Cue = "/VO/Artemis_0046", Text = "There they are..." },
				{ Cue = "/VO/Artemis_0047", Text = "There you are..." },
				{ Cue = "/VO/Artemis_0048", Text = "The hunt is on..." },
				{ Cue = "/VO/Artemis_0049", Text = "Found you." },
				{ Cue = "/VO/Artemis_0409", Text = "What are you still doing here, Sister?",
					PlayOnce = true,
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.75,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1238", Text = "I know that voice...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1239", Text = "Artemis...!" },
				{ Cue = "/VO/Melinoe_1240", Text = "You wretches are in for it now." },
				{ Cue = "/VO/Melinoe_1241", Text = "Take your shot, Sister!" },
				{ Cue = "/VO/Melinoe_1242", Text = "Just watch your aim!" },
				{ Cue = "/VO/Melinoe_1243", Text = "You're just in time." },
				{ Cue = "/VO/Melinoe_1244", Text = "I'll keep them busy for you!" },
			}
		},

		PlayerInjuredReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			Cooldowns =
			{
				{ Name = "ArtemisAnyQuipSpeech", Time = 40 },
			},

			{ Cue = "/VO/Artemis_0078", Text = "Careful!" },
			{ Cue = "/VO/Artemis_0079", Text = "Watch out!" },
			{ Cue = "/VO/Artemis_0080", Text = "Get back!" },
			{ Cue = "/VO/Artemis_0081", Text = "You OK?" },
			{ Cue = "/VO/Artemis_0082", Text = "Steady, Sister!" },
			{ Cue = "/VO/Artemis_0083", Text = "Damn it!" },
			{ Cue = "/VO/Artemis_0084", Text = "Stand clear!" },
			{ Cue = "/VO/Artemis_0085", Text = "They'll pay for that!" },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Cooldowns =
			{
				{ Name = "ArtemisLastStandSpeech", Time = 40 },
			},
			TriggerCooldowns =
			{
				"ArtemisAnyQuipSpeech",
			},
			{ Cue = "/VO/Artemis_0235", Text = "No, hold on...!" },
			{ Cue = "/VO/Artemis_0236", Text = "Damn it...!" },
			{ Cue = "/VO/Artemis_0237", Text = "Melinoë...!" },
			{ Cue = "/VO/Artemis_0238", Text = "You all right?!", PlayFirst = true },
			{ Cue = "/VO/Artemis_0239", Text = "Take cover...!" },
			{ Cue = "/VO/Artemis_0240", Text = "Fall back...!" },
		},

		KillingEnemyVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.75,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				Cooldowns =
				{
					{ Name = "ArtemisAnyQuipSpeech", Time = 20 },
				},

				{ Cue = "/VO/Artemis_0050", Text = "One less." },
				{ Cue = "/VO/Artemis_0051", Text = "One down." },
				{ Cue = "/VO/Artemis_0052", Text = "Target down." },
				{ Cue = "/VO/Artemis_0053", Text = "Got one." },
				{ Cue = "/VO/Artemis_0054", Text = "Got that one." },
				{ Cue = "/VO/Artemis_0055", Text = "Got 'em." },
				{ Cue = "/VO/Artemis_0056", Text = "There." },
				{ Cue = "/VO/Artemis_0057", Text = "Easy." },
				{ Cue = "/VO/Artemis_0058", Text = "Simple." },
				{ Cue = "/VO/Artemis_0059", Text = "Next." },
				{ Cue = "/VO/Artemis_0061", Text = "{#Emph}Hah!" },
				{ Cue = "/VO/Artemis_0062", Text = "{#Emph}Hmph." },
				{ Cue = "/VO/Artemis_0063", Text = "Who else..." },
				{ Cue = "/VO/Artemis_0224", Text = "Down..." },
				{ Cue = "/VO/Artemis_0344", Text = "Shot." },
				{ Cue = "/VO/Artemis_0345", Text = "That's a hit." },
				{ Cue = "/VO/Artemis_0346", Text = "Right through." },
				{ Cue = "/VO/Artemis_0347", Text = "Next?" },
				{ Cue = "/VO/Artemis_0348", Text = "OK." },
				{ Cue = "/VO/Artemis_0349", Text = "{#Emph}Hm." },
				-- { Cue = "/VO/Artemis_0060", Text = "See that?" },
				-- { Cue = "/VO/Artemis_0223", Text = "Down." },
				-- { Cue = "/VO/Artemis_0225", Text = "It's down." },
				-- { Cue = "/VO/Artemis_0226", Text = "It's down." },
			},
			{
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.02,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns =
				{
					"ArtemisAnyQuipSpeech",
				},

				{ Cue = "/VO/Melinoe_1245", Text = "Nice shot!", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1246", Text = "How does she do that...?" },
				{ Cue = "/VO/MelinoeField_2097", Text = "Perfect." },
				{ Cue = "/VO/MelinoeField_2098", Text = "Down!" },
				{ Cue = "/VO/MelinoeField_2099", Text = "...Ouch." },
				{ Cue = "/VO/MelinoeField_2100", Text = "Good shot." },
				{ Cue = "/VO/MelinoeField_2101", Text = "Thank you...!" },
				{ Cue = "/VO/MelinoeField_2102", Text = "Got 'em." },
			}
		},

		KillStolenVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
			Cooldowns =
			{
				{ Name = "ArtemisKillStealSpeech", Time = 40 },
				{ Name = "ArtemisAnyQuipSpeech", Time = 12 }
			},

			{ Cue = "/VO/Artemis_0072", Text = "I had that one!" },
			{ Cue = "/VO/Artemis_0073", Text = "I had that..." },
			{ Cue = "/VO/Artemis_0074", Text = "Beat me to that one." },
			{ Cue = "/VO/Artemis_0075", Text = "Beat me to it...", PlayFirst = true },
			{ Cue = "/VO/Artemis_0076", Text = "That was mine." },
			{ Cue = "/VO/Artemis_0077", Text = "That was my mark." },
			{ Cue = "/VO/Artemis_0355", Text = "Check your aim." },
			{ Cue = "/VO/Artemis_0356", Text = "{#Emph}Hey...!" },
			{ Cue = "/VO/Artemis_0357", Text = "If you insist." },
			{ Cue = "/VO/Artemis_0358", Text = "Wasted shot..." },
		},

		EncounterEndVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.65,

				{ Cue = "/VO/Artemis_0086", Text = "That's all of them." },
				{ Cue = "/VO/Artemis_0087", Text = "Area secure." },
				{ Cue = "/VO/Artemis_0088", Text = "All clear." },
				{ Cue = "/VO/Artemis_0089", Text = "Short work!" },
				{ Cue = "/VO/Artemis_0090", Text = "That ought to do it!", PlayFirst = true },
				{ Cue = "/VO/Artemis_0091", Text = "Hail, Sister." },
				{ Cue = "/VO/Artemis_0092", Text = "Hail, Sister!" },
				{ Cue = "/VO/Artemis_0093", Text = "Good evening." },
				{ Cue = "/VO/Artemis_0094", Text = "Fancy running into {#Emph}you {#Prev}again!" },
				{ Cue = "/VO/Artemis_0095", Text = "So how's it going?" },
				{ Cue = "/VO/Artemis_0096", Text = "Thought I'd drop in!" },
				{ Cue = "/VO/Artemis_0097", Text = "Peace and quiet." },
				{ Cue = "/VO/Artemis_0379", Text = "Good evening." },
				{ Cue = "/VO/Artemis_0446", Text = "Hey you're not bad!" },
				{ Cue = "/VO/Artemis_0448", Text = "Save some for me next time.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "ProjectileRecord", "ArtemisSniperBolt" },
							Comparison = "<=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Artemis_0447", Text = "Barely got a shot in...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "ProjectileRecord", "ArtemisSniperBolt" },
							Comparison = "<=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Artemis_0445", Text = "Back to work, are we?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0380", Text = "Oh hi, Melinoë!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift05" },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0363", Text = "That wasn't great...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0364", Text = "That didn't go so well.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0365", Text = "Sorry about all that...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0366", Text = "Well we got through...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0098", Text = "You all right?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.6, },
						},
					},
				},
				{ Cue = "/VO/Artemis_0099", Text = "Damn, you're hurt...",
					GameStateRequirements =
					{
						{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
					},
				},
				{ Cue = "/VO/Artemis_0100", Text = "That got ugly...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.3, },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},

				{ Cue = "/VO/Melinoe_1094", Text = "Artemis!" },
				{ Cue = "/VO/Melinoe_1095", Text = "Hail, Sister." },
				{ Cue = "/VO/Melinoe_1247", Text = "Good work." },
				{ Cue = "/VO/Melinoe_1248", Text = "Appreciate the backup." },
				{ Cue = "/VO/Melinoe_1249", Text = "Sister Artemis!" },
				{ Cue = "/VO/Melinoe_1250", Text = "There you are." },
				{ Cue = "/VO/Melinoe_1251", Text = "Good evening!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1252", Text = "You're in top form!" },
			},
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				PreLineWait = 0.75,
				Queue = "Always",
				ObjectType = "NPC_Artemis_Field_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Artemis_0126", Text = "All right, I'm off." },
				{ Cue = "/VO/Artemis_0127", Text = "Farewell for now." },
				{ Cue = "/VO/Artemis_0128", Text = "Fight on, Sister." },
				{ Cue = "/VO/Artemis_0129", Text = "Go find your mark.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "Artemis_0123", "Artemis_0122" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0130", Text = "Moonlight guide you." },
				{ Cue = "/VO/Artemis_0131", Text = "Till we meet again." },
				{ Cue = "/VO/Artemis_0132", Text = "Stay safe, Sister." },
				{ Cue = "/VO/Artemis_0133", Text = "Good hunting." },
				{ Cue = "/VO/Artemis_0134", Text = "See you." },
				{ Cue = "/VO/Artemis_0135", Text = "Got to go." },
				{ Cue = "/VO/Artemis_0309", Text = "Good to see you!" },
				{ Cue = "/VO/Artemis_0310", Text = "Watch your step!" },
				{ Cue = "/VO/Artemis_0311", Text = "Steady out there." },
				{ Cue = "/VO/Artemis_0312", Text = "I was never here." },
				{ Cue = "/VO/Artemis_0313", Text = "Go unseen." },
				{ Cue = "/VO/Artemis_0308", Text = "{#Emph}Moonlight guide you home tonight!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift03" }
						},
					},
				},
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,
				PreLineWait = 0.35,

				{ Cue = "/VO/Melinoe_1253", Text = "Farewell." },
				{ Cue = "/VO/Melinoe_1254", Text = "Good hunting.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1255", Text = "Fight on." },
				{ Cue = "/VO/Melinoe_1256_C", Text = "See you." },
				{ Cue = "/VO/Melinoe_1257", Text = "Go unseen." },
				{ Cue = "/VO/Melinoe_1258", Text = "Let's do this again sometime." },
			},
		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 370006 }, Alive = false },
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
			ObjectType = "NPC_Artemis_Field_01",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			Cooldowns =
			{
				{ Name = "ArtemisAnyQuipSpeech", Time = 40 },
			},

			{ Cue = "/VO/Artemis_0105", Text = "Sister?" },
			{ Cue = "/VO/Artemis_0106", Text = "Come off it." },
			{ Cue = "/VO/Artemis_0107", Text = "No time to spar.", PlayFirst = true },
			{ Cue = "/VO/Artemis_0108", Text = "Don't take it out on me." },
			{ Cue = "/VO/Artemis_0109", Text = "Focus, Sister." },
			{ Cue = "/VO/Artemis_0110", Text = "{#Emph}<Sigh...>" },
			{ Cue = "/VO/Artemis_0359", Text = "Save it for Chronos?" },
			{ Cue = "/VO/Artemis_0360", Text = "Come on." },
			{ Cue = "/VO/Artemis_0361", Text = "Really?" },
			{ Cue = "/VO/Artemis_0362", Text = "Stop it." },
		},
	},

	-- Artemis, field version
	NPC_Artemis_Field_01 =
	{
		InheritFrom = { "NPC_Artemis_01" },
		GenusName = "NPC_Artemis_01",
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs =
		{
			SkipInteractAnim = true,
			SkipSound = true,
			PackageName = "NPC_Artemis_Field_01",
			PreserveContextArt = true,
		},
		RecheckConversationOnLootPickup = true,
		PostPickupFunctionName = "ArtemisExitPresentation",
		PostPickupFunctionArgs = { WaitTime = 3.5 },
		AnimOffsetZ = 0,
		ExcludeFromDamageDealtRecord = true,
		PreEventFunctionName = "AngleNPCToHero",

		NonHeroKillCombatText = "PartnerKill",
		TreatAsGodLootByShops = true,
		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
		Icon = "BoonSymbolArtemis",
		LightingColor = {210, 255, 97, 255},
		LootColor = {110, 255, 0, 255},
		SubtitleColor = Color.ArtemisVoice,
		UpgradeScreenOpenSound = "/SFX/ArtemisBoonArrow",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
		LootRejectionAnimation = "BoonDissipateA_Artemis",
		MenuTitle = "UpgradeChoiceMenu_Artemis",
		EchoLastRewardId = "EchoLastRewardBoon_Artemis",
		PriorityUpgrades = { },
		LoadPackages = { "NPC_Artemis_Field_01", "Artemis" },
		Traits =
		{ 
			"SupportingFireBoon", 
			"CritBonusBoon", 
			"DashOmegaBuffBoon", 
			"HighHealthCritBoon", 
			"InsideCastCritBoon",
			"OmegaCastVolleyBoon",
			"TimedCritVulnerabilityBoon",
			"FocusCritBoon",
			-- Legendary
			"SorceryCritBoon",
		},
		Consumables = { },
		RarityChances =
		{
			Rare = 0.0,
			Epic = 0.0,
		},
		
		RarityRollOrder = { "Common", "Rare", "Epic" },
		Speaker = "NPC_Artemis_01",
		Portrait = "Portrait_Artemis_Default_01",
		OverlayAnim = "ArtemisOverlay",
		Gender = "Female",
		SpawnSound = "/SFX/ArtemisBoonArrow",
		FlavorTextIds =
		{
			"ArtemisUpgrade_FlavorText01",
			"ArtemisUpgrade_FlavorText02",
			"ArtemisUpgrade_FlavorText03",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ArtemisGrantsHiddenAspect01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3403", Text = "{#Emph}I see your threefold shadow with the Phantom Queen." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ArtemisAboutAmbrosia01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4108", Text = "If we must." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					--
				},
				
				{ Cue = "/VO/Artemis_0111", Text = "For your journey." },
				{ Cue = "/VO/Artemis_0112", Text = "My blessings..." },
				{ Cue = "/VO/Artemis_0113", Text = "For you." },
				{ Cue = "/VO/Artemis_0114", Text = "Here's what I have." },
				{ Cue = "/VO/Artemis_0115", Text = "The choice is yours." },
				{ Cue = "/VO/Artemis_0116", Text = "Here." },
			},
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		--SpawnAnimation = "ThanatosTalkDismissal",
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.33,
		DefaultAIData =
		{
			TeleportStartFx = "ArtemisTeleportFx",
			TeleportEndFx = "ArtemisTeleportFx",

			TargetRequiredKillEnemy = true,
			TargetClosestToPlayer = true,
			IgnoreInvulnerable = true,
			AIWanderDistance = 200,
		},
		AIWakeDelay = 3.0,
		OutgoingCritModifiers =
		{
			{
				Chance = 1.0,
			}
		},
		AIOptions = { "AttackerAI" },
		PostCombatAI = "ArtemisPostCombat",
		PostCombatTeleportIfPastDistance = 800,

		WeaponOptions = { "ArtemisSniper", "ArtemisSniper", "ArtemisHuntersMark", "ArtemisHuntersMark",
							 "ArtemisHealDrop", "ArtemisHealDrop", "ArtemisHealDrop", "ArtemisHealDrop", },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			}
		},
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},

		ActivateRequirements =
		{
			-- None
		},

		InteractTextLineSets =
		{
			ArtemisFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Artemis_0167",
					-- Portrait = "Portrait_Artemis_Serious_01",
					-- PreLineAnim = "Artemis_Salute",
					-- PreLineAnim = "Artemis_Shrug",
					-- PreLineAnim = "Artemis_Blessing",
					-- PreLineThreadedFunctionName = "PlayCharacterAnim",
					-- PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "It's been too long, Sister. Look at you, on your great hunt! Not ideal circumstances but you've finally begun. Know that the family has your back, surprised as they are about this." },
				{ Cue = "/VO/Melinoe_1179", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No shortage lately of surprises on Olympus or below. It's good to see you, Artemis. But, I must be off. Time's against us, and all that." },
				{ Cue = "/VO/Artemis_0168",
					Text = "{#Emph}Time{#Prev}'s an old fool too busy besieging the mountain of the gods to sense the threat headed his way. Go get him." },
			},

			-- low health
			ArtemisLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				{ Cue = "/VO/Artemis_0151",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Oh, you look like {#Emph}hell{#Prev}, Sister. Don't have anything to patch you up, but I {#Emph}can {#Prev}help you kill the wretches that did this to you!" },
			},
			ArtemisLowHealth02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				{ Cue = "/VO/Artemis_0259",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "You're barely on your feet, Sister. Let's save our breath and concentrate on getting through the rest of this intact. Far as we can, at least." },
			},
			ArtemisLowHealth03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				{ Cue = "/VO/Artemis_0300",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Sorry I couldn't keep them all at bay. I try to pack a few recovery supplies, but have to travel light." },
			},
			ArtemisLowHealth04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				{ Cue = "/VO/Artemis_0301",
					Portrait = "Portrait_Artemis_Serious_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "{#Emph}Eugh{#Prev}, one of these evenings where nothing's gone right. Have to push through to the next! Or turn {#Emph}this {#Prev}one around." },
			},

			-- story events
			ArtemisAboutApollo01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = "<",
						Value = 1,
					},
				},
				{ Cue = "/VO/Artemis_0171",
					Text = "Has my little brother lived up to his shining reputation so far? At least he did his part. Soon as I told him about {#Emph}you{#Prev}, sure enough he was plenty eager to let all Olympus know." },
				{ Cue = "/VO/Melinoe_1180", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Apollo was very kind. Though, easy for me to say, I'm not his twin. What'd you tell him anyway?" },
				{ Cue = "/VO/Artemis_0172",
					PreLineAnim = "Artemis_Shrug",
					Text = "Only the truth! That I ran into the reclusive Witch of the Crossroads while scouting out our foe... and that she introduced me to a secret {#Emph}Titan killer {#Prev}she's been training up." },
				{ Cue = "/VO/Melinoe_1181", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You just didn't tell him how long ago that was. So now they really think this long-lost relative of theirs is going to find Chronos and slay him?" },
				{ Cue = "/VO/Artemis_0173",
					PreLineAnim = "Artemis_Blessing",
					Text = "Oh, they think you don't stand a chance! But they don't have a lot of options, so... they'll support you anyway, especially since you're family and all. And you know {#Emph}I {#Prev}will." },
			},
			ArtemisAboutAthena01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
					},
				},
				{ Cue = "/VO/Artemis_0424",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Wait, how did you already get Athena's blessing way out {#Emph}here? {#Prev}She's practically a world apart and has been too busy to send messages by Boon..." },
				{ Cue = "/VO/MelinoeField_4119", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have her Gorgon Amulet. Perhaps it's a bit rude of me but with it, she can drop in on whichever unfortunate foes I happen to be facing at the time." },
				{ Cue = "/VO/Artemis_0425",
					PreLineAnim = "Artemis_Shrug",
					Text = "{#Emph}Ah{#Prev}, right. She {#Emph}does {#Prev}like her dramatic entrances, and probably doesn't mind giving hints of her power here and there. Well, here's another {#Emph}hint {#Prev}for you." },
			},

			ArtemisAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "EnemyKills", "Hecate" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "H_Intro" }
					},
				},
				{ Cue = "/VO/Artemis_0159",
					Text = "You bested Sister Hecate! She told me so herself, and with dare-I-say more than a hint of pride. Though, she's intent on testing you still?" },
				{ Cue = "/VO/Melinoe_1192", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She always said I can't beat Chronos if I can't beat her. And so we spar. I think she's gone easy on me, to boost my confidence." },
				{ Cue = "/VO/Artemis_0160",
					PreLineAnim = "Artemis_Shrug",
					Text = "Well, I can plainly see she failed. Gone {#Emph}easy? {#Prev}If there's one thing the Witch of the Crossroads hasn't ever done, it's that." },
			},

			-- alt below
			ArtemisAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutSelene01_B" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0146",
					Text = "I can often depend on Sister Selene's light to guide me on my hunts. But where you're going, she can't follow, can she? Nor can I." },
				{ Cue = "/VO/Melinoe_1184", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And Headmistress Hecate is needed at the Crossroads. I alone have the authority to enter the House of Hades. If I can make it there." },
				{ Cue = "/VO/Artemis_0147",
					PreLineAnim = "Artemis_Shrug",
					Text = "Hey, what do you mean {#Emph}if? {#Prev}It's a matter of {#Emph}when{#Prev}, as far as I'm concerned. I'm thinking maybe very {#Emph}soon{#Prev}, in fact." },
			},
			ArtemisAboutSelene01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutSelene01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = "<=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0198",
					Text = "I can often depend on Sister Selene's light to guide me on my hunts. But where you're going, she can't follow easily, can she? Nor can I." },
				{ Cue = "/VO/MelinoeField_2138", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sister Selene has her ways, though I know it's difficult for her, and Headmistress is needed at the Crossroads. I alone have the authority to enter the House of Hades. But I'd have never gotten there without you all." },
				{ Cue = "/VO/Artemis_0199",
					PreLineAnim = "Artemis_Shrug",
					Text = "Could {#Emph}really {#Prev}use a proper hunting party for this one! Fortunately it's kind of our thing as Silver Sisters to not have to be in the same place at the same time." },
			},

			ArtemisAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutFates01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HermesFirstPickUp" }, Max = 9 },
					},
				},
				{ Cue = "/VO/Artemis_0148",
					Text = "Hermes finally got a hold of you, did he? Sounds like things have really taken a turn on Olympus. Glad I'm not there!" },
				{ Cue = "/VO/Melinoe_1185", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, how can you say that? It's your home. I'm going to see if I can head up there and lend a hand." },
				{ Cue = "/VO/Artemis_0149",
					PreLineAnim = "Artemis_Shrug",
					Text = "Is that even possible for you, born of the Underworld and all that? Then again, you're a {#Emph}witch! {#Prev}Must have a remedy for everything!" },
			},

			ArtemisAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatFirstMeeting", "NemesisGetFreeItemIntro01", "ArtemisGift03", "NemesisGift03", "NemesisAboutArtemis02" }, 
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirements = { "NoRecentNemesisEncounter" },
				},
				{ Cue = "/VO/MelinoeField_2141", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You haven't seen Nemesis tonight, have you? Not that she should be anywhere near here, as opposed to keeping watch over the gateways at the Crossroads." },
				{ Cue = "/VO/Artemis_0206",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "I haven't seen her, no. But I was tracking her! Those footprints are only slightly harder to spot than {#Emph}she {#Prev}is. She's not supposed to be out here, is she..." },
				{ Cue = "/VO/MelinoeField_2142", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...That she is not. She's just trying to make herself useful, I get it. And the Fates themselves know that I could probably use the help. Though, how have you two been?" },
				{ Cue = "/VO/Artemis_0207",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "We each need company, we each need solitude, the same old thing. She's frustrated, which can go a couple of ways depending on the night. Anyway, she's a big girl!" },
			},
			ArtemisAboutNemesis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift03", "ArtemisHubFirstMeeting01", "NemesisTaverna01", "NemesisBathHouse02" }, 
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisPostCombatBecomingCloser01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3371", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey Artemis, if Nemesis and I... if we were closer, would that be all right? I mean with {#Emph}you. {#Prev}Because if not, just say the word. It's probably not going anywhere anyway..." },
				{ Cue = "/VO/Artemis_0378",
					PreLineAnim = "Artemis_Shrug",
					Text = "What am I, Sister Hecate? You don't need my permission, not like Nemesis belongs to me, though I've considered trapping her. In all seriousness, good hunting with that one." },
			},
			ArtemisAboutNemesis03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift06" }, 
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "NemesisPostCombatBecomingCloser01", },
						IsAny = { "Choice_NemesisAccept" },
					},
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAny = { "NemesisCombatH" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				{ Cue = "/VO/Artemis_0417",
					Text = "So how has Nemesis been doing, she all right? Seems to finally be getting farther in her own stubborn attempts." },

				{ Cue = "/VO/MelinoeField_4116", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh she's been well, for her. We've been seeing each other more, and... it's good. As good as she can probably permit." },

				{ Cue = "/VO/Artemis_0418",
					PreLineAnim = "Artemis_Shrug",
					Text = "That's great! She did seem a little lighter on her feet, but not {#Emph}too {#Prev}light, of course. You'll have to tell me how you got through her defenses sometime." },
			},

			ArtemisAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosSecondAppearance" }, Min = 3 },
					},
					-- NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Artemis_0169",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Hey, is it really true Moros himself showed up at your Crossroads because you {#Emph}summoned {#Prev}him? As in, you {#Emph}literally invited Doom...?" },
				{ Cue = "/VO/MelinoeField_2019", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It doesn't seem the wisest course when you put it that way. Chronos once was brought low by a prophecy of the Three Fates. I felt they might be willing to intervene again." },
				{ Cue = "/VO/Artemis_0170",
					PreLineAnim = "Artemis_Shrug",
					Text = "And they did so by sending you the embodiment of misfortune and unforeseen consequences. Well if that's what the Fates have in store, you're going to need {#Emph}this." },
			},

			ArtemisAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift04", "CharonGift04" }, 
					},
				},
				{ Cue = "/VO/Artemis_0376",
					Text = "Hey, do you {#Emph}really {#Prev}understand what Charon's moaning about, or is it all an act... like how creatures sometimes make themselves look bigger, as a form of self defense?" },
				{ Cue = "/VO/MelinoeField_3370", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Artemis! {#Prev}I can't exactly parse each syllable but Charon has spent a great deal of time around souls of the dead. It's really not that different. {#Emph}You {#Prev}can communicate with {#Emph}beasts!" },
				{ Cue = "/VO/Artemis_0377",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "I guess, it's just... beasts usually don't have too much to say! Except for cats. Anyway, the boatman probably makes better conversation than some gods I know." },
			},

			ArtemisAboutZagreus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 5,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/Artemis_0298",
					PreLineWait = 0.35,
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "...I hate to even ask, but... have you picked up any trace of Zagreus, by any chance, while in your father's House?" },
				{ Cue = "/VO/MelinoeField_3369", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, it's... hard for me to say. My brother isn't there, but... I sense his presence; our connection. He's not gone." },
				{ Cue = "/VO/Artemis_0299",
					PreLineAnim = "Artemis_Shrug",
					Text = "I guess that's good enough for me, for now. Although it's much more {#Emph}cryptic {#Prev}than I'd like! Well, wherever he is... he better be all right. And not alone." },
			},

			ArtemisAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0202",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "It's really true about the Fates, that Chronos somehow got to them? Doesn't want to take any chances anymore. Did the Fates prophesize their own captivity...?" },
				{ Cue = "/VO/MelinoeField_2139", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How can you be so casual about this? If the Fates themselves couldn't stop Chronos, we won't have an easy time! We're beholden to chance ourselves." },
				{ Cue = "/VO/Artemis_0203",
					PreLineAnim = "Artemis_Shrug",
					Text = "So what if we are! You know not even {#Emph}I {#Prev}always hit my mark. What do I do if I miss? {#Emph}I take another shot. {#Prev}The greater the skill, the less is up to chance." },
			},

			ArtemisAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_3" }
					},
				},
				{ Cue = "/VO/Artemis_0157",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.2, AngleNPCToHero = true, },
					Text = "It's strange, isn't it? He's our own grandfather... Chronos, I mean. But, I feel no connection to him at all! I just want him gone." },
				{ Cue = "/VO/Melinoe_1191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Doesn't matter who he is; he's a threat. We're the Silver Sisters. We'll {#Emph}make {#Prev}him gone. For the sake of the realms." },
				{ Cue = "/VO/Artemis_0158",
					-- PreLineAnim = "Artemis_Shrug",
					Text = "Strictly business then, is it? Even still, funny how it falls on {#Emph}us {#Prev}to settle the older generation's scores." },
			},
			-- lower-priority alt below
			ArtemisAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutChronosBossL01_B" },
					},
					--[[ equivalent to the above
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				{ Cue = "/VO/Artemis_0194",
					Text = "Got all the way down to the House of Hades, so I heard. Must be nice having fated authority over the lowest reaches of the Underworld... unless you're Chronos." },
				{ Cue = "/VO/MelinoeField_2136", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He was most certainly annoyed. Wields a scythe that's twice my height, surrounds himself with feral Satyr-worshipers ready to die for him. I'm not surprised it once took both our fathers and more to bring him down." },
				{ Cue = "/VO/Artemis_0195",
					PreLineAnim = "Artemis_Shrug",
					Text = "No reason to compare yourself. They're high and mighty lords of the heavens and the Underworld, but they fought Chronos by necessity. You were trained to do {#Emph}precisely this." },
			},
			ArtemisAboutChronosBossL01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutChronosBossL01" },
					},
				},
				{ Cue = "/VO/Artemis_0194",
					Text = "Got all the way down to the House of Hades, so I heard. Must be nice having fated authority over the lowest reaches of the Underworld... unless you're Chronos." },
				{ Cue = "/VO/MelinoeField_2136", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He was most certainly annoyed. Wields a scythe that's twice my height, surrounds himself with feral Satyr-worshipers ready to die for him. I'm not surprised it once took both our fathers and more to bring him down." },
				{ Cue = "/VO/Artemis_0195",
					PreLineAnim = "Artemis_Shrug",
					Text = "No reason to compare yourself. They're high and mighty lords of the heavens and the Underworld, but they fought Chronos by necessity. You were trained to do {#Emph}precisely this." },
			},
			ArtemisAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 5,
						Path = { "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0196",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "You found Chronos... sank your fangs into his throat. Sister Hecate gave me the gist. How'd you do it...? Found some exploitable weakness, something like that?" },
				{ Cue = "/VO/MelinoeField_2137", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Mostly I just kept evading a lot. He's very powerful, but must have underestimated my ability to resist his tricks." },
				{ Cue = "/VO/Artemis_0197",
					-- PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "He won't always underestimate you, though. Must have his vulnerabilities. {#Emph}The old are seldom wise, and often weak{#Prev}, right? He's bloodied... go for the kill." },
			},
			ArtemisAboutChronosBossW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZagreusPastMeeting05" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0407",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "You're close, aren't you? To putting Chronos down for good. I know you mustn't share the details even with me, but... you'd tell me if I'm wrong." },
				{ Cue = "/VO/MelinoeField_4111", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'd tell you, yes. Now then, I hate to make our meetings brief, but I've a certain matter to resolve." },
				{ Cue = "/VO/Artemis_0408",
					PreLineAnim = "Artemis_Salute",
					Text = "Then go resolve it, by all means. Tread softly, and strike true, Sister." },
			},

			ArtemisAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						SumPrevRuns = 2,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Artemis_0405",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Seen Heracles stomping about? As much as I am normally the trusting sort, I don't quite know about that one. He's been on my bad side for a while. Quite rough with animals." },
				{ Cue = "/VO/MelinoeField_4110", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, you're goddess of the {#Emph}hunt. {#Prev}Animals must be far more afraid of you than him." },
				{ Cue = "/VO/Artemis_0406",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Now don't you even start with that, Sister. Animals {#Emph}adore {#Prev}me, except when it's their time. But Heracles goes after them whenever he needs. Just watch it with him, OK?" },
			},

			ArtemisAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0212",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "You saw we're up against Prometheus. His whole thing is how he knows what's going to take place... makes him quite an elusive one, I guess." },
				{ Cue = "/VO/MelinoeField_2449", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Titan of Foresight, fighting for the Titan of Time... perhaps merely against the gods who punished him. He may have his reasons, but he's in my way." },
				{ Cue = "/VO/Artemis_0213",
					PreLineAnim = "Artemis_Shrug",
					Text = "I know precisely what you mean. Though if he really knows the future, wouldn't he choose the winning side...? Careful with him, Sister..." },
			},
			ArtemisAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutPrometheus01" },
					},
					{
						SumPrevRuns = 6,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0290",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "One disadvantage to my being all the way out here is I'm unable to put arrows through Prometheus from such a range. Apollo says he's been a real bother." },
				{ Cue = "/VO/MelinoeField_3365",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's a problem and a threat... even unarmed, and seemingly not even at full strength, for he still bears old wounds. He has more than enough fury to make up." },
				{ Cue = "/VO/Artemis_0291",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Great, another angry Titan. Well if he's {#Emph}seething {#Prev}all the time, he's liable to make mistakes. It wouldn't be the first time." },
			},
			ArtemisAboutPrometheus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutPrometheus02" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_3366",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You don't truly believe Prometheus can see the future, do you? He probably just has heightened instincts like yours." },
				{ Cue = "/VO/Artemis_0292",
					PreLineAnim = "Artemis_Shrug",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Excuse me? {#Prev}Nobody has instincts as heightened as {#Emph}these{#Prev}, Sister! But I've never claimed to know {#Emph}precisely {#Prev}what's to come. Even if I could, I think I'd miss all the suspense." },
			},

			ArtemisAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				{ Cue = "/VO/Artemis_0293",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "We've bigger problems on Olympus than we counted on, I hear. Our worst fears realized and so on? You'd think I'd be more capable of tracking prey that's Typhon's size..." },
				{ Cue = "/VO/MelinoeField_3367", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You were tracking Chronos... me, perhaps. But if it's any consolation, finding Typhon ought to be quite easy at this point! Bringing him down... less so." },
				{ Cue = "/VO/Artemis_0294",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "I'll take your word for it. My father's much too proud to call me back to aid in our defense. Says I'm still needed here. If he wants Typhon to himself so badly, he can have him." },
			},
			ArtemisAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutTyphon01" },
					},
					{
						SumPrevRuns = 5,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				{ Cue = "/VO/Artemis_0295",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Olympus managed to take Typhon down...? I figure with {#Emph}your {#Prev}aid, probably Sister Selene's too. I guess I wasn't needed up there after all." },
				{ Cue = "/VO/MelinoeField_3368", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We drove the monster back, but I don't think we've properly discouraged him. Not yet, at least. Though I've a few ideas..." },
				{ Cue = "/VO/Artemis_0296",
					PreLineAnim = "Artemis_Shrug",
					Text = "If your ideas involve an {#Emph}arrow {#Prev}in his eye, of which I hear he has a {#Emph}lot{#Prev}, let me know... moonlight guide you home tonight." },
			},
			ArtemisAboutTyphon03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0413",
					Text = "I meant to thank you, since our woods and mountains are no longer likely to be crushed beneath a monster's foot or slithering appendages. That's been a big relief." },
				{ Cue = "/VO/MelinoeField_4114", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, anytime. I wouldn't have liked being crushed that way, either. Sounds like Lord Zeus and Queen Hera had some contingency in mind that was best avoided." },
				{ Cue = "/VO/Artemis_0414",
					PreLineAnim = "Artemis_Shrug",
					Text = "Our woods and mountains would have been in even {#Emph}worse {#Prev}shape then. Your way shook Father and Stepmother up a bit... the power to destroy immortals and all that? But it's best they respect you. That's how you get them to be nice!" },
			},

			ArtemisAboutMission01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_2131", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 0.2, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why has Olympus sent you all the way out here, anyway? I thought you'd have gone back by now. You're always welcome in the Crossroads!" },
				{ Cue = "/VO/Artemis_0297",
					Text = "Appreciate it, Sister, and I do have to report back soon enough. As for why I'm all the way out here, mostly to spy on you! Olympus likes to be informed." },
				{ Cue = "/VO/MelinoeField_2132", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain that they do. Do you ever slip up with them? By now the other gods must have their suspicions about you and Hermes." },
				{ Cue = "/VO/Artemis_0180",
					PreLineAnim = "Artemis_Shrug",
					Text = "Depends on who you're talking about I guess, but for the most part they just think we're young and flighty. But we're the best they've got." },
			},

			ArtemisAboutSilverSisters01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0181",
					Text = "When I became one of the Silver Sisters, I figured all we'd really do was stalk in shadows, make occasional reports... but this is a full-on {#Emph}worst-case scenario!" },
				{ Cue = "/VO/MelinoeField_2133", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sound excited rather than dismayed. You must have known it'd come to this eventually. Not like Headmistress would band us together just for ceremony's sake." },
				{ Cue = "/VO/Artemis_0182",
					PreLineAnim = "Artemis_Shrug",
					Text = "No, I guess you're right. Still, we've been together biding our time for so long... I got to thinking we might never get the opportunity to strike. Yet here we are!" },
			},

			ArtemisAboutFamiliars01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
				},
				{ Cue = "/VO/Artemis_0386",
					Text = "Hey you have an animal companion now! Mine would be with me too, except they won't set foot in the Underworld while they still draw breath... except these birds, which do not seem to care." },
				{ Cue = "/VO/MelinoeField_3328", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I suppose they have other excuses for Ephyra? Some companions they are, leaving you to your devices here." },
				{ Cue = "/VO/Artemis_0258",
					PreLineAnim = "Artemis_Shrug",
					Text = "{#Emph}Hah! {#Prev}They're just like us for the most part, except quieter usually. You take good care of yours for me, all right?" },
			},

			ArtemisAboutSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Artemis_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Artemis_0284",
					Text = "Good being in the Crossroads earlier. My aim is steadier, nerves calm again. I don't get any real peace at home... but it's there to be found in the woods." },
				{ Cue = "/VO/MelinoeField_3362", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No place to practice singing at home either, I expect. Is it truly that concerning if Apollo hears? He can't be {#Emph}that {#Prev}much better! And he'd probably be proud of you." },
				{ Cue = "/VO/Artemis_0285",
					PreLineAnim = "Artemis_Shrug",
					Text = "Or he'd tease me incessantly... I'd likely have to put an arrow through him and get into a heap of trouble. Not prepared to take that sort of risk, Sister." },
			},

			ArtemisAboutBoons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"HighHealthCritBoon", 
							"SupportingFireBoon", 
							"CritBonusBoon", 
							"DashOmegaBuffBoon", 
							"InsideCastCritBoon",
							"OmegaCastVolleyBoon",
							"FocusCritBoon",
							"TimedCritVulnerabilityBoon",
						},
					},
				},
				{ Cue = "/VO/Artemis_0260",
					Text = "You've tried all my latest Boons by now. Got others I've been mulling, although lately nothing seems to stick! Likely you'd rather have something tried-and-true anyway." },
				{ Cue = "/VO/MelinoeField_3329", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "From you, Sister, I'll take whatever I can get! A bit of extra precision in my strikes often makes all the difference." },
				{ Cue = "/VO/Artemis_0261",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "...I'm not just all about {#Emph}precision {#Prev}here, am I? We gods get cast as one thing and that's it. Father Zeus and his thunder, Uncle Poseidon and his water, Apollo and his... {#Emph}hair." },
			},

			ArtemisAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Melinoe_1186", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've been so far from home for so long. Don't you miss being on Olympus? If not now, then... back before the Titan's siege?" },
				{ Cue = "/VO/Artemis_0150",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "What, you mean being with my father and stepmother, my perfect twin brother, and all the rest? Just because I'm willing to aid them doesn't mean I'm willing to live with them again." },
			},
			ArtemisAboutFamily02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "AphroditeFirstPickUp", "HephaestusFirstPickUp", "HestiaFirstPickUp", "AresFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt", },
					},
				},
				{ Cue = "/VO/Artemis_0165",
					Text = "So what do you think of the family? Most of them are stuck on their mountaintop, though... you've seen what they're like." },
				{ Cue = "/VO/Melinoe_2340", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh they don't seem so bad! Especially things being as they are. But you can't stand any of them..." },
				{ Cue = "/VO/Artemis_0166",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Hey I wouldn't go {#Emph}that {#Prev}far! Though, yes, they can get under my skin. They're going to owe us {#Emph}big {#Prev}once all of this is over." },
			},

			ArtemisAboutMission02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "Cleared" },
						CountPathTrue = true,
						Comparison = "<",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" },
					},
				},
				{ Cue = "/VO/Melinoe_1189", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So when you're not aiding me in my repeated failures, what else have you been up to, Artemis? Some special quarry you're after?" },
				{ Cue = "/VO/Artemis_0154",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "There might be. Olympus has been shaking, for reasons unknown. Sister Selene asked that I look into it. Surely it's nothing, right?" },
			},

			ArtemisAboutErebus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0183",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Poor wretches, left to linger here. Could be relaxing in Elysium, or Asphodel at least. No wonder they're upset." },
				{ Cue = "/VO/MelinoeField_2134",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos claimed it was an act of magnanimity, unsealing the Underworld gates, letting the dead roam free. This can't possibly be better than when my father ruled." },
				{ Cue = "/VO/Artemis_0184",
					PreLineAnim = "Artemis_Shrug",
					Text = "Hey, at least it means I can set foot in these parts without inciting some huge territorial dispute! Setting aside the fact that we're already in the middle of one." },
			},

			ArtemisAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				{ Cue = "/VO/Artemis_0204",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Fine mess we made! Not many hiding-places here compared to Erebus. Might be the end of the line for me... I'm a huntress, not a fisher." },
				{ Cue = "/VO/MelinoeField_2140",
					Portrait = "Portrait_Mel_Proud_01",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fishing is a form of hunting, isn't it? Anyway I appreciate the backup, and understand if you're now at the limit of your range. Olympus probably expects you back." },
				{ Cue = "/VO/Artemis_0205",
					PreLineAnim = "Artemis_Shrug",
					Text = "They'll want to hear from me! About the situation, and about {#Emph}you{#Prev}, too. You know they still take me and Hermes for their spies? Although, we do tell them a lot..." },
			},

			ArtemisAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = "<=",
						Value = 5,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0174",
					Text = "You made it quite a ways up on the surface recently, Sister Selene said. Did it live up to all your hopes and dreams?" },
				{ Cue = "/VO/Melinoe_2339",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I tend to have a lot of nightmares, and it did live up to those. The dead are left to linger there. They should be safely in the Underworld!" },
				{ Cue = "/VO/Artemis_0175",
					Text = "Well, Chronos evidently has other ideas for how things should be governed. I know your main objective is below, though... thank you for any aid you can provide up top." },
			},

			ArtemisAboutSurfacePenalty01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
				},
				{ Cue = "/VO/Artemis_0185",
					Text = "So much for visiting the surface, huh? Not seen a trace of you up there! Don't feel bad. You have nice woods here, too!" },
				{ Cue = "/VO/MelinoeField_2135",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not supposed to be up there... could hardly breathe. But there might be something I can do. Hermes wouldn't have asked me to go if it wasn't important." },
				{ Cue = "/VO/Artemis_0186",
					PreLineAnim = "Artemis_Shrug",
					Text = "No, I guess not. I'd offer to escort you though Olympus wants me to stay out of sight. And I won't bother saying not to push yourself too hard..." },
			},

			-- alt below
			ArtemisAboutEphyra01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutSurfacePenalty01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutEphyra01_B" },
					},
				},
				{ Cue = "/VO/Artemis_0176",
					Emote = "PortraitEmoteSurprise",
					Text = "Look at {#Emph}you{#Prev}, Sister! Your brother once had us all convinced he was trying to fight his way to Olympus. Now none of us can believe you're trying to do it for real." },
				{ Cue = "/VO/MelinoeField_2020",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've known Hermes about as long as you, and can count the number of favors he's asked of me on one hand. Besides, I could use the change of scenery." },
				{ Cue = "/VO/Artemis_0177",
					PreLineAnim = "Artemis_Shrug",
					Text = "Then by all means! What a time, that you're on your way up to the mountain while I'm on my way down to the Underworld. At least we crossed paths!" },
			},
			ArtemisAboutEphyra01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {  "ArtemisAboutEphyra01", "ArtemisAboutSurfacePenalty01" },
					},
				},
				{ Cue = "/VO/Artemis_0176",
					Emote = "PortraitEmoteSurprise",
					Text = "Look at {#Emph}you{#Prev}, Sister! Your brother once had us all convinced he was trying to fight his way to Olympus. Now none of us can believe you're trying to do it for real." },
				{ Cue = "/VO/MelinoeField_2020_B",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes wouldn't have asked me to go if it wasn't important. Besides, I could use the change of scenery." },
				{ Cue = "/VO/Artemis_0177",
					PreLineAnim = "Artemis_Shrug",
					Text = "Then by all means! What a time, that you're on your way up to the mountain while I'm on my way down to the Underworld. At least we crossed paths!" },
			},

			ArtemisAboutPolyphemus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Polyphemus" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0250",
					Text = "That massive Cyclops Polyphemus... saw him fast asleep the other night! Then {#Emph}you {#Prev}were able to sneak up and incapacitate him, just like {#Emph}that! {#Prev}I stay far downwind of him, myself." },
				{ Cue = "/VO/MelinoeField_2145",
					Portrait = "Portrait_Mel_Proud_01",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm tempted to just smile and nod through this one, Artemis, but my dealings with the Cyclops haven't involved much stealth. Though at least I can get past him, at this point." },
				{ Cue = "/VO/Artemis_0251",
					PreLineAnim = "Artemis_Shrug",
					Text = "And how do you get through the Rift beyond the docks, you {#Emph}swim? {#Prev}You still like doing things the hard way. The {#Emph}only {#Prev}way!" },
			},

			ArtemisAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ErisGift09" },
					},
				},
				{ Cue = "/VO/Artemis_0208",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "You probably know {#Emph}Eris {#Prev}has been buzzing around Olympus recently? One good lightning bolt from Father Zeus would normally take {#Emph}care {#Prev}of that, but... he's been occupied." },
				{ Cue = "/VO/MelinoeField_2143",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "One good lightning bolt, how about one good arrow? We'd be saved a lot of trouble if Eris were to be plucked from the sky one of these nights." },
				{ Cue = "/VO/Artemis_0209",
					PreLineAnim = "Artemis_Shrug",
					Text = "I'd gladly volunteer, it's just that Father has everything {#Emph}well under control. {#Prev}Says I'm needed way out here instead. But if I do spot the wings of Strife... they're going down." },
			},

			ArtemisAboutDagger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "ClearedWithWeapons", "I" },
						HasNone = 
						{
							"WeaponDagger",
						},
					},
				},
				{ Cue = "/VO/Artemis_0155",
					Text = "Those blades of yours doing you any good? Let me know if you need any, {#Emph}erm... pointers...?" },
				{ Cue = "/VO/Melinoe_1190", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Sister Blades are almost like having you by my side in every fight. Though, you can shoot a lot farther than I can throw..." },
				{ Cue = "/VO/Artemis_0156",
					PreLineAnim = "Artemis_Shrug",
					Text = "{#Emph}Oh{#Prev}, don't be so hard on yourself, I can shoot farther than anybody! Especially Apollo. Well, just keep going for their vitals, and you'll be fine." },
			},

			ArtemisAboutArtemisAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerBlockAspect" },
					},
				},
				{ Cue = "/VO/Artemis_0210",
					Text = "Hey, I recognize those blades! Didn't want to let on before, but... now I guess you know. You best be taking care of them! " },
				{ Cue = "/VO/MelinoeField_2144", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not to worry. I am, I swear! So, {#Emph}you {#Prev}were the bearer of the Sister Blades yourself? Did you have to give them up because of me...?" },
				{ Cue = "/VO/Artemis_0211",
					PreLineAnim = "Artemis_Shrug",
					Text = "I gave them up because I did what needed to be done. Hecate so likes her little tests. Anyway I'm glad to see old Lim and Oros in good hands." },
			},

			ArtemisGrantsReward01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift05" },
					},
					{
						Path = { "GameState", "EnemyKills" },
						HasAll = { "Chronos", "Prometheus" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = 
						{
							"SpellLaserTrait",
							"SpellLeapTrait",
							"SpellSummonTrait",
							"SpellMeteorTrait",
							"SpellTransformTrait",
							"SpellMoonBeamTrait",
							"SpellPolymorphTrait"
						},
					},
				},
				{ Cue = "/VO/Artemis_0419",
					Text = "It's strange... I work so closely with Sister Selene, but I've never been any good with her Hexes. Not like {#Emph}you." },
				{ Cue = "/VO/MelinoeField_4117", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I am woefully incompetent with bow-and-arrow, not like {#Emph}you. {#Prev}It's probably Nemesis ensuring none of us have it all." },
				{ Cue = "/VO/Artemis_0420",
					PreLineAnim = "Artemis_Blessing",
					Text = "Well, you're about to get a little {#Emph}closer {#Prev}to that enviable point. Here, a little extra Moon magick for all you've done, and still intend to do. In case you need it." },
			},

			ArtemisGrantsHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "DaggerBlockAspect", "DaggerHomingThrowAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "DaggerBlockAspect5", "DaggerHomingThrowAspect5" },
					},
					NamedRequirementsFalse =
					{
						"StaffHiddenAspectRevealInProgress",
						-- "DaggerHiddenAspectRevealInProgress",
						"TorchHiddenAspectRevealInProgress",
						"AxeHiddenAspectRevealInProgress",
						"LobHiddenAspectRevealInProgress",
						"SuitHiddenAspectRevealInProgress"
					},
				},
				{ Cue = "/VO/Artemis_0252",
					Text = "We Silver Sisters, we're the keepers of the Nocturnal Arms. The blades of Lim and Oros serve Night's will at your command, but there is more to them." },
				{ Cue = "/VO/MelinoeField_3401", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're serious? I'm listening. What would you have me do?" },
				{ Cue = "/VO/Artemis_0253",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "At the Silver Pool, invoke the blades with this: {#Emph}I see your threefold shadow with the Phantom Queen. {#Prev}I think you're ready now. It should be good!" },
				{ Cue = "/VO/MelinoeField_3402", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}I see your threefold shadow with the Phantom Queen. {#Prev}A waking-phrase... thank you for the honor, Artemis. Whose Aspect is this, do you know?" },
				{ Cue = "/VO/Artemis_0385",
					PreLineAnim = "Artemis_Shrug",
					Text = "{#Emph}Oh{#Prev}, no one in particular, just another threefold goddess of shadow, like Sister Hecate but of a different age and place. I shouldn't say more, you'll see for yourself soon enough." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Dagger" },
				},
			},
			ArtemisAboutHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect" },
					},
				},
				{ Cue = "/VO/Artemis_0255_B",
					Text = "Those are the Sister Blades... then, that must be the Aspect of the Morrigan. Looks like it suits you pretty well! Maybe we Night-Moon goddesses {#Emph}are {#Prev}all alike." },
				{ Cue = "/VO/MelinoeField_3497", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean you never got to wield this Aspect yourself? How did you even learn the waking-phrase you shared?" },
				{ Cue = "/VO/Artemis_0256",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "One too many questions, Melinoë, but no. That Aspect wasn't for me. Maybe some evening you, too, will have the opportunity to pass along some secret knowledge!" },
			},
			ArtemisAboutHiddenAspect02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "DaggerTripleAspect" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift05" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0426",
					Text = "You know, I set up Zagreus with his {#Emph}own {#Prev}waking-phrase one time, for a hidden Aspect of a bow called Coronacht, which Stepmother once used. He was pretty good with it!" },
				{ Cue = "/VO/MelinoeField_4120", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh {#Emph}truly? {#Prev}And what else would you say he did better than me, Artemis? Certainly he had more charm, but could he sprint faster than me, too?" },
				{ Cue = "/VO/Artemis_0427",
					PreLineAnim = "Artemis_Shrug",
					Text = "Absolutely, {#Emph}much {#Prev}faster. {#Emph}Anyway{#Prev}, the point being, I'm pleased to have seen each of you grow strong, and done my part for the Infernal and Nocturnal Arms alike. " },
			},

			ArtemisAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "LowHealthCritKeepsake" },
					},
				},
				{ Cue = "/VO/Artemis_0200",
					Text = "Brought the White Antler with you just in case! The stag who gave it up, it was his time. And I vowed to him I'd make it quick. His Shade and I, we still commune every so often!" },
				{ Cue = "/VO/MelinoeField_2146", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, your tales have this remarkable capacity to warm the heart and yet disturb the mind. In case you ever need a calling other than the hunt." },
				{ Cue = "/VO/Artemis_0201",
					PreLineAnim = "Artemis_Shrug",
					Text = "If none of this works out, I was thinking {#Emph}songs {#Prev}and {#Emph}music-making? {#Prev}If Apollo can do it, so can {#Emph}I. {#Prev}Though we've not tired of the hunter's life just yet." },
			},
			ArtemisAboutKeepsake02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "LowHealthCritKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "LowHealthCritKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},
				{ Cue = "/VO/Artemis_0403",
					Text = "Glad the old Antler there has served you well. Keep pushing {#Emph}that {#Prev}thing and you're liable to bring the stag who gave it up back to life! Or take over for {#Emph}me {#Prev}on the hunt." },
				{ Cue = "/VO/MelinoeField_4109", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh I wouldn't want {#Emph}that... {#Prev}just to be hell-bent on repeatedly hitting my foes in their vital regions. And for some reason your White Antler helps!" },
				{ Cue = "/VO/Artemis_0404",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "{#Emph}Some reason? {#Prev}Our {#Emph}bond's {#Prev}the reason, and the Antler's the connection. Just don't get carried away. I take most shots while out of sight, but {#Emph}you {#Prev}are not as shy." },
			},

			ArtemisAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Artemis_0286",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "There's a particular {#Emph}chill {#Prev}in the air tonight. I almost broke a {#Emph}sweat! {#Prev}Though our foes were partly to blame. I think I know what's going on, Melinoë, but what is going {#Emph}on?" },
				{ Cue = "/VO/MelinoeField_3363", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Testament of Night is what. The Fear and Darkness spread... which may not seem to our immediate benefit, but the Nocturnal Arms grow stronger through it; and the realm." },
				{ Cue = "/VO/Artemis_0287",
					PreLineAnim = "Artemis_Shrug",
					Text = "Well then! {#Emph}In shadow, we serve; to shadow, we return. {#Prev}Olympus figured it was Chronos up to something. I had my doubts, but... wanted to be sure." },
			},
			ArtemisAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutShrine01" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{ Cue = "/VO/Artemis_0288",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "I had more trouble getting here than usual. The Testament of Night again? Nyx herself would surely be impressed with all you've done, spreading {#Emph}fear{#Prev}, creating {#Emph}nightmares..." },
				{ Cue = "/VO/MelinoeField_3364", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Through fear comes respect and obedience. Once we're finished, then perhaps the next would-be usurpers with designs on either of our realms are going to think twice." },
				{ Cue = "/VO/Artemis_0289",
					PreLineAnim = "Artemis_Shrug",
					Text = "That was a rather good impression of your father, Sister. Well, let's go terrify our foes some more, shall we?" },
			},

			ArtemisAboutMoon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				{ Cue = "/VO/Artemis_0162",
					Text = "A full Moon... Sister Selene's power at its peak. On nights like this, I really feel my immortality. May our combined strength be enough." },
			},
			ArtemisSendOff01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Melinoe_1193", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, Artemis. Is everything all right?" },
				{ Cue = "/VO/Artemis_0161",
					Text = "So much to talk about, so little time, Sister. I'm needed elsewhere, but I wanted to make sure to send you off." },
			},

			ArtemisAboutRetrying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasNone = { "H_Boss01", "H_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/Melinoe_1182", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've likely heard I didn't get there, Artemis. Didn't even come close." },
				{ Cue = "/VO/Artemis_0143",
					Text = "Sister, I have {#Emph}every {#Prev}faith in you, but not even {#Emph}I {#Prev}believed you were going to vanquish Chronos straightaway. Let's be a little realistic here?",
				},
			},

			ArtemisAboutProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Melinoe_1055", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Any progress yet with your investigation?" },
				{ Cue = "/VO/Artemis_0178",
					PreLineAnim = "Artemis_Shrug",
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Not near as much as I'd like. Here, let me give you a boost. Maybe you'll get somewhere even if I don't.",
				},
			},

			ArtemisAboutTimePassing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
						Comparison = "<=",
						Value = 0,
					},
					{
						SumPrevRuns = 4,
						Path = { "SpawnRecord", "NPC_Artemis_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				{ Cue = "/VO/Artemis_0248",
					Text = "Not seen each other in how many nights, Sister? {#Emph}Eugh{#Prev}, I know that's just the way it goes. You're busy, I'm busy, bunch of time goes by, and... here we are." },
				{ Cue = "/VO/MelinoeField_2450", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Doubtless we've crossed paths repeatedly, just not quite close enough. I feel like a lot's transpired since last we met like this. Where to even begin?" },
				{ Cue = "/VO/Artemis_0249",
					PreLineAnim = "Artemis_Shrug",
					Text = "Oh no need, we haven't seen each other but I've still been keeping up. Olympus knows of all your latest exploits! The ones you wouldn't mind me sharing, anyway.",
				},
			},

			ArtemisAboutTeamwork01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisHubSinging01", "ArtemisGift06" },
					},
					{
						SumPrevRuns = 5,
						Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAny = { "ArtemisCombatF", "ArtemisCombatF2", },
					},
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAny = { "ArtemisCombatG", "ArtemisCombatG2", },
					},
					{
						Path = { "GameState", "EncountersCompletedCache" },
						HasAny = { "ArtemisCombatN", "ArtemisCombatN2", },
					},
				},
				{ Cue = "/VO/Artemis_0387",
					Text = "We're quite the team, aren't we? And that's {#Emph}without {#Prev}Sisters Hecate and Selene backing us up. Shame that we all have to spread out most of the time." },
				{ Cue = "/VO/MelinoeField_4092", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We do have several realms to watch. But yes, I have to say it's been a pleasure working with you recently. Singing with you. Having your friendship." },
				{ Cue = "/VO/Artemis_0388",
					PreLineAnim = "Artemis_Shrug",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.25 },

					Text = "Now don't get sentimental on me, Sister. This is business. And though the world we live in may be looking a bit bleak, at least business is good.",
				},
			},

			ArtemisAboutAmbrosia01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift09" },
					},
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 5,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisGift09" }, Min = 3 },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0399",
					Text = "Hey, look what I unearthed from out of a certain hollowed stump! Beneath this thick layer of dirt is the Ambrosia bottle you had me stash away, and we're having it now." },

				{ Cue = "/VO/MelinoeField_4105", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, {#Emph}now? {#Prev}Why not save it for the Crossroads where, for instance, we're not spattered with the remnants of our foes?" },

				{ Cue = "/VO/Artemis_0400",
					PreLineAnim = "Artemis_Shrug",
					Text = "Speak for yourself, I use a bow, I'm {#Emph}clean! {#Prev}But yes, right now. Because if we keep waiting for the perfect time, we'll wait forever. More importantly, you achieved your task, and we barely got to celebrate!" },

				{ Cue = "/VO/MelinoeField_4106", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And the moon {#Emph}is {#Prev}new. You make persuasive points, so fine, let's have ourselves a bit. What shall we drink to?" },

				{ Cue = "/VO/Artemis_0401",

					PreLineAnim = "Artemis_Salute",

					PortraitExitAnimation = "Portrait_Artemis_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20, IsArtemisField = true },

					Text = "To the Silver Sisters... if I'm to skulk in shadow with several other goddesses, I couldn't have asked for a better pack." },

				{ Cue = "/VO/Artemis_0402",
					PreLineWait = 0.35,

					PreLineFunctionName = "TavernaEndPresentation",
					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Text = "{#Emph}Whew! {#Prev}That was good, and our work hasn't gone anywhere in the meantime. I suppose we should be getting back to it?" },
			},

			ArtemisPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0410",
					Text = "The deed is done, or should I say the {#Emph}task {#Prev}is finally complete. But, you're right back to work!" },

				{ Cue = "/VO/MelinoeField_4112", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, well... call it a habit, or an opportunity to check up on some things. And thank you, Artemis. I won't forget the flight of the Silver Sisters." },

				{ Cue = "/VO/Artemis_0411",
					PreLineAnim = "Artemis_Shrug",
					Text = "Apollo just {#Emph}had {#Prev}to come along, though I won't soon forget it either. Not felt a victory like that in ages. Wait, why {#Emph}are {#Prev}we still fighting?" },
					
				{ Cue = "/VO/MelinoeField_4113", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To destroy every last trace of the threat we faced, apparently. So I still need you around as much as ever." },

				{ Cue = "/VO/Artemis_0412",
					PreLineAnim = "Artemis_Blessing",
					Text = "You mean we get to keep {#Emph}this {#Prev}up, and I will have as much target practice as I want? Well {#Emph}OK!",
				},
			},
			ArtemisPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0415",
					Text = "Things are better than I would have thought back home. Still odd to see us dealing with the remnants of the siege, but Father Zeus has been a lot less temperamental, finally." },
				{ Cue = "/VO/MelinoeField_4115",
					Portrait = "Portrait_Mel_Proud_01",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's good to hear, and I'm glad you had the opportunity to be there yourself. So does this mean I won't be seeing you as much out here? They must want you back." },
				{ Cue = "/VO/Artemis_0416",
					PreLineAnim = "Artemis_Shrug",
					Text = "Well, between us, they still want me to keep an eye on you, powerful witch that you are. But, I do have to check in now and again, which I don't mind. They've been glad to see {#Emph}me{#Prev}, and to hear all about {#Emph}you{#Prev}, and... I can say hi to the Nymphs!" },
			},

			ArtemisPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Artemis_0421",
					Text = "Everybody on the mountain's going on about the Fates finally turning up. Father wouldn't even be in charge if not for them, so he must not have liked the thought that they were gone..." },
				{ Cue = "/VO/MelinoeField_4118",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But now the Fates have said the influence of gods shall wane to an extent. I can't imagine Lord Uncle Zeus and the rest are too pleased about {#Emph}that." },
				{ Cue = "/VO/Artemis_0422",
					PreLineAnim = "Artemis_Shrug",
					Text = "No, but as major prophecies are concerned, it's really not that bad. And besides, it sounds like this new age of theirs might not be for a while, so... we'll worry about it then!" },
			},

			ArtemisAboutSayingLittle01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArtemisGift10" }
					},
				},
				{ Cue = "/VO/Artemis_0423",
					Text = "Clean and efficient, just the way I like it, Sister. Not been too much to report on my side, and it seems like things are well on yours. Let's keep it moving then, shall we?" },
			},

			-- Repeatable
			ArtemisChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0004",
					UseEventEndSound = true,
					Text = "Take this, Sister, and go find your mark." },
			},
			ArtemisChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0005",
					UseEventEndSound = true,
					Text = "Tread ever softly and strike swift and true, Sister." },
			},
			ArtemisChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0006",
					UseEventEndSound = true,
					Text = "Happened to be in the area again, so thought I'd stop on by." },
			},
			ArtemisChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0007",
					UseEventEndSound = true,
					Text = "May Moonlight guide you to your prey, and expose his every weakness." },
			},
			ArtemisChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0008",
					UseEventEndSound = true,
					Text = "Another night, another duty for the Silver Sisters." },
			},
			ArtemisChat06 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
				},
				{ Cue = "/VO/Artemis_0009",
					UseEventEndSound = true,
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "I have to say, these woods are not my favorite..." },
			},
			ArtemisChat07 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				{ Cue = "/VO/Artemis_0010",
					UseEventEndSound = true,
					Text = "I can't venture any further below, though I can give you this." },
			},
			ArtemisChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0011",
					UseEventEndSound = true,
					Text = "The skilled huntress keeps her bag of tricks full and with her at all times." },
			},
			ArtemisChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0012",
					UseEventEndSound = true,
					Text = "Steady yourself, Sister. You have my full support and more." },
			},
			ArtemisChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0013",
					UseEventEndSound = true,
					Text = "May your aim ever be true. Not unlike mine!" },
			},
			ArtemisChat11 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0014",
					UseEventEndSound = true,
					Text = "I still think you should try a bow again sometime..." },
			},
			ArtemisChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0015",
					UseEventEndSound = true,
					Text = "We hunt alone. Although these run-ins aren't so bad!" },
			},
			ArtemisChat13 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0016",
					UseEventEndSound = true,
					Text = "Always a pleasure working with you, Sister." },
			},
			ArtemisChat14 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Artemis_0017",
					UseEventEndSound = true,
					Text = "Go cut that wretched Titan down to size for me, would you?" },
			},
			ArtemisChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0018",
					UseEventEndSound = true,
					Text = "May none dare stand between a witch and her prey." },
			},
			ArtemisChat16 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Artemis_0019",
					UseEventEndSound = true,
					Text = "Fine night for hunting Titans, don't you think?" },
			},
			ArtemisChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0020",
					UseEventEndSound = true,
					Portrait = "Portrait_Artemis_Serious_01",
					Text = "Picked up the scent of a few stragglers I'll take care of after this..." },
			},
			ArtemisChat18 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0021",
					UseEventEndSound = true,
					Text = "You'll find your mark. I know you will." },
			},
			ArtemisChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0022",
					UseEventEndSound = true,
					Text = "Yours is the most dangerous prey of all. I'm a bit envious!" },
			},
			ArtemisChat20 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0023",
					UseEventEndSound = true,
					Text = "Here's a little something to go with those witching arts of yours." },
			},
			ArtemisChat21 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0024",
					UseEventEndSound = true,
					Text = "I've got your back, Sister, so just keep moving forward." },
			},
			ArtemisChat22 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0025",
					UseEventEndSound = true,
					Text = "We're the Silver Sisters, and we never miss our mark." },
			},
			ArtemisChat23 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0026",
					UseEventEndSound = true,
					Text = "We are the Silver Sisters, and this is our time to shine." },
			},
			ArtemisChat24 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0027",
					UseEventEndSound = true,
					Text = "Got to say it's nice to get away from it all like this." },
			},
			ArtemisChat25 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord", },
						HasNone = { "/VO/Artemis_0094", },
					},
				},				
				{ Cue = "/VO/Artemis_0028",
					UseEventEndSound = true,
					Text = "Fancy running into you again, and here of all places!" },
			},
			ArtemisChat26 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0029",
					UseEventEndSound = true,
					Text = "You tracked {#Emph}me {#Prev}down this time, I'll have you know!" },
			},
			ArtemisChat27 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0030",
					UseEventEndSound = true,
					Text = "You were born to do this, Sister, and you're going to succeed." },
			},
			ArtemisChat28 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Artemis_0031",
					UseEventEndSound = true,
					Text = "Sure beats being back on that mountaintop, let me tell you." },
			},
			ArtemisChat29 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Artemis_0032",
					UseEventEndSound = true,
					Text = "The Moon is full again. May our combined might take you far." },
			},
			ArtemisChat30 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 5,
					},
				},
				{ Cue = "/VO/Artemis_0033",
					UseEventEndSound = true,
					Text = "A new moon marks a new beginning, so take heart, Sister." },
			},
			ArtemisChat31 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 4,
					},
				},
				{ Cue = "/VO/Artemis_0034",
					UseEventEndSound = true,
					Text = "The Moon's light wanes again, but your strength needn't falter." },
			},
			ArtemisChat32 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 8,
					},
				},
				{ Cue = "/VO/Artemis_0035",
					UseEventEndSound = true,
					Text = "As the light of the waxing Moon intensifies, so too does our potential, Sister." },
			},
			ArtemisChat33 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Artemis_0449",
					UseEventEndSound = true,
					Text = "Good hunting on the way up to the mountain, Sister." },
			},
			ArtemisChat34 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Artemis_0450",
					UseEventEndSound = true,
					Text = "Father better have expressed his gratitude for all you've done." },
			},
			ArtemisChat35 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				{ Cue = "/VO/Artemis_0451",
					UseEventEndSound = true,
					Text = "Good of you to deal with Typhon so that we don't have to anymore!" },
			},
			ArtemisChat36 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/Artemis_0452",
					UseEventEndSound = true,
					Text = "I'll cover your tracks, but first, here's something for the road." },
			},
			ArtemisChat37 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ProjectileRecord", "ArtemisSniperBolt" },
						Comparison = "<=",
						Value = 4,
					},
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Artemis_0448" }
					},
				},
				{ Cue = "/VO/Artemis_0453",
					UseEventEndSound = true,
					Text = "Next time leave more of them for me, would you?" },
			},
			-- 38 blank
			ArtemisChat39 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.8, },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisAboutSayingLittle01" }, Min = 9 },
					},
				},
				{ Cue = "/VO/Artemis_0467",
					UseEventEndSound = true,
					Text = "Clean and efficient, just the way I like it, Sister." },
			},
			ArtemisChat40 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisGrantsReward01" }, Min = 9 },
					},
				},
				{ Cue = "/VO/Artemis_0468",
					UseEventEndSound = true,
					Text = "Here, a little extra Moon magick for all you've done, and still intend to do." },
			},
		},
		-- GiftTextLineSets on NPC_Artemis_01

		Using = { EffectName = "OmegaDamageBuffEffect", ProjectileName = "ArtemisSupportingFire" },
	},

}

-- Global Artemis Lines
GlobalVoiceLines.ArtemisGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Artemis_Field_01",
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},		
		Cooldowns =
		{
			{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Artemis_0320", Text = "You're clear." },
		{ Cue = "/VO/Artemis_0321", Text = "Find something?" },
		{ Cue = "/VO/Artemis_0322", Text = "Keen eye." },
		{ Cue = "/VO/Artemis_0323", Text = "More reagents?" },
		{ Cue = "/VO/Artemis_0324", Text = "For the cauldron?" },
		{ Cue = "/VO/Artemis_0325", Text = "I saw it first.", PlayFirst = true },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Artemis_Field_01",
		SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},		
		Cooldowns =
		{
			{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Artemis_0314", Text = "{#Emph}Focus{#Prev}, Sister!" },
		{ Cue = "/VO/Artemis_0315", Text = "Eyes up, Sister!", PlayFirst = true },
		{ Cue = "/VO/Artemis_0316", Text = "Couldn't wait?" },
		{ Cue = "/VO/Artemis_0317", Text = "Back in the fight!" },
		{ Cue = "/VO/Artemis_0318", Text = "Now, {#Emph}really?" },
		{ Cue = "/VO/Artemis_0319", Text = "Got you covered!" },
	},
}

GlobalVoiceLines.ArtemisReRollReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.5,
	ObjectType = "NPC_Artemis_Field_01",

	{ Cue = "/VO/Artemis_0371", Text = "How about these?", PlayFirst = true },
	{ Cue = "/VO/Artemis_0372", Text = "Try these then." },
	{ Cue = "/VO/Artemis_0373", Text = "Think I can muster these." },
	{ Cue = "/VO/Artemis_0374", Text = "Well you're particular." },
	{ Cue = "/VO/Artemis_0375", Text = "More to your fancy?" },
}

GlobalVoiceLines.ArtemisSongStoppedReactionVoiceLines =
{
	PlayOnceFromTableThisRun = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.0,
	ObjectType = "NPC_Artemis_01",
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "ArtemisHubSong" },
		},
		{
			PathFromArgs = true,
			PathFalse = { "ArtemisAlreadySuppressed" },
		},
		{
			Path = { "ConfigOptionCache", "MusicVolume" },
			Comparison = ">",
			Value = 0.1,
		},
	},

	{ Cue = "/VO/Artemis_0433", Text = "Rude!" },
	{ Cue = "/VO/Artemis_0434", Text = "Fine!" },
	{ Cue = "/VO/Artemis_0435", Text = "I get it!" },
	{ Cue = "/VO/Artemis_0436", Text = "All right, all right!" },
	{ Cue = "/VO/Artemis_0437", Text = "OK, OK." },
	{ Cue = "/VO/Artemis_0438", Text = "Go for it, Music Maker!", PlayFirst = true },
}

GlobalVoiceLines.ArtemisDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },

	{ Cue = "/VO/Artemis_0101", Text = "Sister, wait, don't go!" },
	{ Cue = "/VO/Artemis_0102", Text = "Next time, we'll make them pay..." },
	{ Cue = "/VO/Artemis_0103", Text = "I'm sorry, Sister..." },
	{ Cue = "/VO/Artemis_0104", Text = "No... I swore to protect you...", PlayFirst = true },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Artemis )