UnitSetData.NPC_Charon =
{
	-- Charon, Id = 557743 (Hub)
	NPC_Charon_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Charon_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.CharonVoice,
		AnimOffsetZ = 0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.25,
		SpeakerName = "Charon",

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CharonGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				PreLineWait = 0.3,
				PlayOnceThisRun = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 3 },
				},
				TriggerCooldowns = { "MelinoeRoomExitVoiceLines" },

				{ Cue = "/VO/Melinoe_1878", Text = "Moonlight guide you, my lord.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1235", Text = "Be safe, Lord Charon." },
				{ Cue = "/VO/Melinoe_2273", Text = "Welcome back to the Crossroads, my lord.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "IsDead" }
						},
					},
				},
				{ Cue = "/VO/Melinoe_2275", Text = "May you remain unseen out there, my lord.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "IsDead" }
						},
					},
				},
				{ Cue = "/VO/Melinoe_2276", Text = "You're always welcome here and safe, Lord Charon.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "IsDead" }
						},
					},
				},
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.5,
				ObjectType = "NPC_Charon_01",

				{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				{ Cue = "/VO/Charon_0018", Text = "{#Emph}Heeeehhhhh..." },
				{ Cue = "/VO/Charon_0017", Text = "{#Emph}Urrrnngggghhh..." },
				{ Cue = "/VO/Charon_0029", Text = "{#Emph}Kohh..." },
			},
		},

		PostActivateEvents =
		{
			{
				-- Always spawn his boat with him
				FunctionName = "ActivatePrePlacedObstacles",
				Args =
				{
					Groups = { "CharonBoat" },
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentHubRoom" },
					},
				},
			},
			{
				FunctionName = "CheckDistanceTriggerThread",
				Args = PresetEventArgs.CharonGreeting,
			},
		},

		SplitHubUseableOffSource = true,

		InteractTextLineSets =
		{
			CharonWithHecate01 =
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
						PathTrue = { "GameState", "UseRecord", "CharonPointsDrop" },
					},
					NamedRequirements = { "MailboxUnlocked" },
				},

				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				TeleportToId = 566613,
				-- TeleportOffsetX = -100,
				-- TeleportOffsetY = 100,
				AngleTowardTargetId = 556921,
				InteractDistance = 400,
				{ Cue = "/VO/Charon_0003",
					Text = "{#Emph}Mmnnnggghhhhhh..." },
				{ Cue = "/VO/Hecate_0641", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01", PreLineWait = 0.35,
					Text = "These shipments shall be very valuable to us. We remain as ever in your debt, Charon. May swift Hermes hasten your voyages across the realms, wherever he may be. And until we meet again, shadows conceal you." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2918", Text = "Thank you for the supplies, my lord...!" },
				},
			},
			MorosWithCharon01 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
				AngleTowardTargetId = 589589,
			},
			MorosWithCharon02 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
				AngleTowardTargetId = 589589,
			},

			CharonFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},

				{ Cue = "/VO/Charon_0076",
					Text = "{#Emph}Hrraauuggh, naaaauugggghh..." },
				{ Cue = "/VO/MelinoeField_1581", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm in your debt, Lord Charon. These provisions surely shall make all the difference in my task. What Gold I find is yours." },
			},

			CharonAboutGold01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Melinoe_1197", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All of this tainted Gold... you'll see that it's disposed of properly, Lord Charon?" },
				{ Cue = "/VO/Charon_0035",
					Text = "{#Emph}Kkkkhhhrrrssssshhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1198", Text = "I long to see that day." },
				},
			},
			CharonAboutGold02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Charon_0002",
					Text = "{#Emph}Sssshhhhhhh..." },
				{ Cue = "/VO/Melinoe_1196", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, Lord Charon. You'll have what Gold I may find, as I require what supplies you may spare." },
			},

			CharonAboutSmuggling01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Charon_0036",
					Text = "{#Emph}Haaaa{#Prev}, hrrrnnnnggghhh..." },
				{ Cue = "/VO/Melinoe_1199", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Hah! {#Prev}We'll have to see how much Chronos still loves his Gold after all this. The good thing about traitors is their loyalties can be bought..." },
			},

			CharonGrantsMailbox01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					NamedRequirements = { "MailboxUnlocked" },
				},
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				{ Cue = "/VO/Charon_0057",
					Text = "{#Emph}Hrrnnnaaauuggghh..." },
				{ Cue = "/VO/MelinoeField_0733", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A special offer of some sort, my lord? I've returned as much Gold as I could, but know full well it isn't easy for you to procure the goods you provide." },
				{ PostLineFunctionName = "NPCRewardDrop",
					PostLineFunctionArgs = { ResourceDropName = "CharonPointsDrop", Force = 420, UpwardForce = 420, RoomRequiredObject = true },
				},
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0842", Text = "Why thank you...!" },
				},
			},

			CharonAboutSpeaking01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Charon_01", },
					},
				},
				{ Cue = "/VO/Charon_0037",
					Text = "Mmmm, {#Emph}hrrrrmmmm{#Prev}..." },
				{ Cue = "/VO/Melinoe_1200", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a pity we've so little opportunity to speak, Lord Charon. Though I'm grateful to be seeing you more frequently of late." },
			},

			CharonAboutDanger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				{ Cue = "/VO/Charon_0038",
					Text = "Hrrrnn, {#Emph}nrraauugggghhhhrrrrhhhh..." },
				{ Cue = "/VO/Melinoe_1201", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I shall, my lord. Until then, we each have our tasks to complete." },
			},

			CharonAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BonusMoneyKeepsake" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_1584", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I bear the gift you generously gave to me. A Keepsake to bring fortune on such nights. Things are looking up already!" },
				{ Cue = "/VO/Charon_0078",
					Text = "{#Emph}Rraaauuggggghhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_1585", Text = "Well it can't hurt..." },
				},
			},

			CharonAboutCharonAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeArmCastAspect" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_1757", UsePlayerSource = true,
					-- PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Nocturnal Arms entrusted me with other Aspects of themselves, including this one that I think was yours, my lord. Did you... relinquish the Moonstone Axe, knowing I was to be its next bearer?" },
				{ Cue = "/VO/Charon_0085",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Nrrraaauuuggghh, krrrnnhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_1758", Text = "I'll bear it to the best of my ability." },
				},
			},

			CharonAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Charon_0081",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Hrrnnnaauggghh, haaauuggh..." },
				{ Cue = "/VO/MelinoeField_1589", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, my lord, I spoke the Oath, if that is what you mean. Thus in shadow, I serve; and to shadow, I'll return ere comes the light of Dawn." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Charon_0082", Text = "{#Emph}Hrrnnngghh..." },
				},
			},

			CharonAboutTravel01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "F" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Melinoe_1202", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've sailed far from your usual course, Boatman. Not solely on my account, I trust?" },
				{ Cue = "/VO/Charon_0039",
					Text = "Ssshhh, {#Emph}hrrrraaauuuggghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2274", Text = "Your generous aid is much appreciated, lord." },
				},
			},
			CharonAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Melinoe_1205", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've come to aid me even here, Lord Charon? Though I imagine not even you can travel much farther, where I'm headed..." },
				{ Cue = "/VO/Charon_0041",
					Text = "Nnnn, {#Emph}nnrrrggghhhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1206", Text = "I won't forget your generosity." },
				},
			},

			CharonAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_1926", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My Lord, is this your ship? It is remarkable, although I fear with all the hostile vessels everywhere that it may come to harm... or even you." },
				{ Cue = "/VO/Charon_0086",
					Text = "{#Emph}Grrnn, neehhhhhhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,

					{ Cue = "/VO/MelinoeField_1927", Text = "Smooth sailing all the same." },
				},
			},

			CharonAboutErebus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Melinoe_1300", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It must be so frustrating, Lord Charon. Watching the dead of Erebus wallow here with no place to go. You'll send them on their way yet." },
				{ Cue = "/VO/Charon_0045",
					Text = "Grrnngghh, {#Emph}hrraaauuuggghh...!" },
				EndVoiceLines =
				{
					PreLineWait = 0.5,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0055", Text = "Until then." },
				},
			},
			CharonAboutTartarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_PreBoss01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				{ Cue = "/VO/Melinoe_3257", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You were able to reach the House of Hades before me, my lord. Doubtless why that final stretch was clear. You must know I was unable to prevail. Just have to give it another go, won't we...?" },
				{ Cue = "/VO/Charon_0074",
					Text = "{#Emph}Hrrrnn, haaaaahhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3258", Text = "Thank you for your support." },
				},
			},
			CharonAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_3259", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We got him finally, Lord Charon! The Titan can be slain... if but to complicate his schemes a little while, till we can put a stop to him for good." },
				{ Cue = "/VO/Charon_0075",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Nrrghhh, hrrrnnn..." },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_3260", Text = "Yes. My father's throne shall be restored." },
				},
			},

			CharonAboutSelene01 =
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
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "G", "H", "I", "N", "O", "P", "Q" },
					},
				},
				{ Cue = "/VO/Charon_0054",
					Text = "{#Emph}Ssshhhaaaahhh...?" },
				{ Cue = "/VO/Melinoe_2009", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I did encounter her, my lord. And I thank the Fates Selene's light is visible in Erebus, for I know she cannot shine much farther past the edge of this realm." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Charon_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Charon_0055", Text = "{#Emph}Mrrrrnnnnggghhh..." },
					},
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2010", Text = "And you as well." },
					},
				},
			},

			CharonAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
					},
				},
				{ Cue = "/VO/Melinoe_1814", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I met one of your brothers, Lord Charon. It was Moros. He delivered to me a certain artifact, but then was gone. Do you know of the {#Emph}Fated List?" },
				{ Cue = "/VO/Charon_0046",
					Text = "{#Emph}Hhhhhoooohhhhh..." },
				{ Cue = "/VO/Melinoe_1815", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's been in my family's care before...? Though, what of Moros? Where could he have gone in all of this?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Charon_01",
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Charon_0047", Text = "{#Emph}Nnnggghhhh..." },
					},
					{
						PreLineWait = 0.2,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1816", Text = "Perhaps I can locate him again." },
					},
				},
			},
			CharonAboutMoros02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "MorosWithCharon01" }
					},
					MaxRunsSinceAnyTextLines = { TextLines = { "MorosSecondAppearance" }, Count = 8 },
				},
				{ Cue = "/VO/Melinoe_2007", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon, Moros returned! He's joined us at the Crossroads. Now we've no fewer than {#Emph}three {#Prev}mighty sons of Nyx within our ranks. Granted, one's always fast asleep..." },
				{ Cue = "/VO/Charon_0048",
					Text = "{#Emph}Huunnnnnggghhhh..." },
				{ Cue = "/VO/Melinoe_2008", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Forgive me, I must not have understood. Hypnos is of greater use this way...?" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Charon_0049", Text = "{#Emph}Hmm, hmm..." },
				},
			},

			CharonAboutOlympians01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll = { "ApolloUpgrade", "DemeterUpgrade", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" }
					},
				},
				{ Cue = "/VO/Charon_0087",
					Text = "{#Emph}Hrrmmmm, nnnrrraaauggghhh..." },
				{ Cue = "/VO/Melinoe_3263", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, my lord, I met Apollo, Grandmother, Uncle Poseidon... I've known Artemis and Hermes for so long, I'm impressed they kept my secret from the others all this time." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Charon_0088",
						Text = "{#Emph}Grrrnhhh..." },
				},
			},

			CharonAboutHermesMission01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_3261", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No sign of Hermes yet, my lord...? Forgive my impatience, I know infiltrating our enemy's ranks and discovering the details of his plans to conquer Olympus is sensitive work..." },
				{ Cue = "/VO/Charon_0089",
					Text = "{#Emph}Hrrmmmnnngggggghhhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					-- RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Melinoe_3262", Text = "Of course. He'll be back any evening now I'm sure." },
				},
			},

			CharonAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "GameState", "QuestsViewed" },
						HasAny = { "QuestMeetOlympians" },
					},
				},
				{ Cue = "/VO/Charon_0050",
					Text = "{#Emph}Hrrrmmmmmm..." },
				{ Cue = "/VO/Melinoe_1817", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain he's all right, my lord. This is Hermes we're talking about! It's not like anyone could catch him, even if he were in peril." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Charon_0051", Text = "{#Emph}Nrrgghhh..." },
				},
			},
			CharonAboutHermes02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
				},
				{ Cue = "/VO/Melinoe_2011", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I heard from Hermes at last, my lord! He didn't get into the details of what he discovered, though perhaps you know more." },
				{ Cue = "/VO/Charon_0052",
					Text = "{#Emph}Auugggghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_2012", Text = "I understand. It's not my wish to pry." },
				},
			},
			CharonAboutHermes03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutCharon01" },
					},
				},
				{ Cue = "/VO/Melinoe_1203", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes wanted me to tell you {#Emph}hey{#Prev}, my lord. A message he'd surely deliver himself if he could. Though he seems well enough." },
				{ Cue = "/VO/Charon_0040",
					Text = "{#Emph}Hhhrrrrrmmmm..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1204", Text = "Of course, my lord." },
				},
			},

			CharonAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CharonGift01", "CharonWithHecate01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Charon_01" }
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Melinoe_1296", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're not particularly close with your brothers or sisters, are you? When you chance to visit us, Nemesis all but ignores you..." },
				{ Cue = "/VO/Charon_0043",
					Text = "Nrrrmmm, {#Emph}hhaaaaahhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1297", Text = "I know, it's just..." },
				},
			},
			CharonAboutNemesis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisCombatFirstIntro", "NemesisGetFreeItemIntro01", "CharonGift02", "NemesisGift03" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_1587", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know that you've seen Nemesis about. She's supposed to be at her post, but... I think you probably can understand. Whatever it takes for the family and the realm, right?" },
				{ Cue = "/VO/Charon_0080",
					Text = "{#Emph}Rrrrauuggh, heehhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_1588", Text = "Then may she go unseen." },
				},
			},

			CharonAboutChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Charon_0080",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Kkhhhaauuugghh, heehhhh..." },
				{ Cue = "/VO/MelinoeField_1586", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You can sense it, can't you, my lord? The mark of Primordial Chaos. It seems I have another patron from the ranks of the chthonic gods." },
			},

			CharonAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_1582", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris returned to the Crossroads, my lord. Forgive me for speaking ill of one of your siblings, but... I always fear the worst when she's around. Could she be working against us?" },
				{ Cue = "/VO/Charon_0077",
					Text = "{#Emph}Mnngghghhhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_1583", Text = "If only she was more like you." },
				},
			},

			CharonAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Melinoe_1294", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your mother Nyx, my lord... I saw her lately in a nightmare or a dream. She was very beautiful... and she was unharmed, I think." },
				{ Cue = "/VO/Charon_0042",
					Text = "Mrmmm, {#Emph}nrruuunnngghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1295", Text = "We're going to find her. I swear it." },
				},
			},

			CharonAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutFates02" },
					},
				},
				{ Cue = "/VO/Melinoe_1298", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know already, don't you, my lord? About the Three Fates. That Chronos has your sisters in his thrall. Lord Moros is safe with us, at least." },
				{ Cue = "/VO/Charon_0044",
					Text = "Kkhhh, {#Emph}kkhhrrrraaauugggghhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1299", Text = "Do you truly think so...?" },
				},
			},

			CharonAboutArtemis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
				},
				{ Cue = "/VO/Melinoe_1818", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's reassuring to know Artemis has been keeping track of things around here lately, my lord. She seems unusually well-supplied, as well." },
				{ Cue = "/VO/Charon_0056",
					Text = "{#Emph}Hhrrraaauuggghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1819", Text = "Oh, I won't tell a soul." },
				},
			},

			CharonAboutArachne01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Arachne_01" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Melinoe_2013", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Do you think Arachne's going to be all right in all of this, my lord? The surface was no longer welcoming, or safe, for her. And now, I fear that Erebus is not much better off..." },
				{ Cue = "/VO/Charon_0053",
					Text = "{#Emph}Mmrrrnnnggghhh..." },
				{ Cue = "/VO/Melinoe_2014", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're right. She's twice as resourceful as just about anybody. {#Emph}Four {#Prev}times! Just... look out for her, would you?" },
			},

			-- repeatable
			CharonChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0003",
					Text = "{#Emph}Hrrrrmmmmmm..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0004",
					Text = "{#Emph}Khhhrrrrraaauugghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0005",
					Text = "{#Emph}Hhhrrsssshhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0006",
					Text = "{#Emph}Khhhssssshhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0007",
					Text = "{#Emph}Khhrrrnnnnnnggghh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0008",
					Text = "{#Emph}Nnnnngggghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0009",
					Text = "{#Emph}Mmmnnnnnnhhhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0010",
					Text = "{#Emph}Rrrrnnnngggghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0011",
					Text = "{#Emph}Hrrnnaaaauugghh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0012",
					Text = "{#Emph}Ssseeeeaaahhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat11 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonChat10", },
					},
				},
				{ Cue = "/VO/Charon_0013",
					Text = "{#Emph}Ssseeeeaaauuuggghhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0014",
					Text = "Hrrnn, {#Emph}hehhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat13 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0015",
					Text = "{#Emph}Mmmrrrrnnngghh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat14 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0016",
					Text = "{#Emph}Rrrnnnggghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0017",
					Text = "{#Emph}Muurrnnggghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat16 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0018",
					Text = "{#Emph}Hheeeehhhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0019",
					Text = "{#Emph}Gggrrrnnngggghhhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat18 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0020",
					Text = "{#Emph}Grrruuunnngghhh..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
			CharonChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Charon_0021",
					Text = "{#Emph}Hhrrrrmmmmm...?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Charon",
			},
		},

		GiftTextLineSets =
		{
			-- grants a gift
			CharonGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				HintId = "Codex_CharonGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
				},
				{ Cue = "/VO/Melinoe_1301", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Would you indulge me for a moment, Boatman? If we're to restore the old order around here, I was thinking why not start like this?" },
				{ Cue = "/VO/Charon_0024",
					PreLineAnim = "Charon_Greeting",
					Text = "{#Emph}Hhhhrrrrnnnngggghhh...?" },
			},
			CharonGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_CharonGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
				},
				{ Cue = "/VO/Charon_0023",
					PreLineAnim = "Charon_Greeting",
					Text = "{#Emph}Oooohhhhhh..." },
				{ Cue = "/VO/Melinoe_1208", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Indeed, Lord Charon. May we soon restore the old customs between our families, and bring about a new aeon of prosperity." },
			},
			CharonGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_CharonGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
				},
				{ Cue = "/VO/Charon_0090",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Auuggggghhhhhh..." },
				{ Cue = "/VO/Melinoe_3383", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you require only Gold, my lord. Nevertheless, I wanted to give you something more! I've always found your commitment to the realm and to your discipline inspiring." },
			},
			CharonGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_CharonGiftHint01",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
				},
				{ Cue = "/VO/Charon_0091",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Nrrrghhhhh, hauuuugghhhh..." },
				{ Cue = "/VO/Melinoe_3384", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perseverance is what got us to this point, my lord. May your resolve never waver! Whenever mine does, I take comfort knowing I have such dependable allies." },
			},
			-- placeholder
			CharonGift05 =
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

		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			Cooldowns =
			{
				{ Name = "CharonSpokeRecently", Time = 15 },
			},

			{ Cue = "/VO/Charon_0026", Text = "{#Emph}Nnrh...?", PlayFirst = true },
			{ Cue = "/VO/Charon_0027", Text = "{#Emph}Hrrr...", PreLineAnim = "Charon_Fierce" },
			{ Cue = "/VO/Charon_0028", Text = "{#Emph}Mmrrr...", PreLineAnim = "Charon_Fierce" },
			{ Cue = "/VO/Charon_0029", Text = "{#Emph}Kkohhh..." },
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1207", Text = "Wait, are you certain there's no charge for this?" },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Charon )