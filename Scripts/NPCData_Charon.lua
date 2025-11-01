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
		EmoteOffsetY = -350,
		EmoteOffsetX = 135,
		AnimOffsetZ = 0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.25,
		SpeakerName = "Charon",
		LoadPackages = { "Charon", },

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Charon_01" },
				Comparison = ">=",
				Value = 2,
			},
		},
		BoonInfoTitleText = "Codex_BoonInfo_Charon",
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
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
					Cooldowns =
					{
						{ Name = "SaidWelcomeHereRecently", Time = 180 },
					},
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "IsDead" }
						},
					},
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.5,
				ObjectType = "NPC_Charon_01",

				{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				{ Cue = "/VO/Charon_0029", Text = "{#Emph}Kohh..." },
				{ Cue = "/VO/Charon_0112", Text = "{#Emph}Krraahhhh...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Charon_0113", Text = "{#Emph}Mmmmnnnn...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1878" },
						},
					},
				},
				{ Cue = "/VO/Charon_0114", Text = "{#Emph}Ssshhh...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1235" },
						},
					},
				},
				{ Cue = "/VO/Charon_0115", Text = "{#Emph}Auugghhh...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_2275" },
						},
					},
				},
				{ Cue = "/VO/Charon_0116", Text = "{#Emph}Hrrmmm...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2273" },
						},
					},
				},
				{ Cue = "/VO/Charon_0117", Text = "{#Emph}Hrreehh...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2276" },
						},
					},
				},
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
					NamedRequirementsFalse = { "ClearBeforeTrueEnding" },
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
					-- PreLineAnim = "Charon_Fierce",
					-- PreLineAnim = "Charon_Thanking",
					-- PreLineAnim = "Charon_Greeting",
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
					{ Cue = "/VO/Melinoe_1198", Text = "I long to see that night." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift01" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CharonPoints" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Charon_0036",
					Text = "{#Emph}Haaaa{#Prev}, hrrrnnnnggghhh..." },
				{ Cue = "/VO/Melinoe_1199", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Hah! {#Prev}We'll have to see how much Chronos still loves his Gold after all this. The good thing about traitors is their loyalties can be bought..." },
			},

			CharonGrantsMailbox01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					NamedRequirements = { "MailboxUnlocked" },
				},
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
					{ Cue = "/VO/Melinoe_0842_B", Text = "Why thank you...!" },
				},
			},
			CharonAboutCharonPoints01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 10,
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "CharonPoints" },
						Comparison = ">=",
						Value = 20,
					},
					NamedRequirements = { "MailboxUnlocked" },
				},
				{ Cue = "/VO/Charon_0135",
					Text = "{#Emph}Rrnnngghh, huuaaahhh..." },
				{ Cue = "/VO/MelinoeField_4505", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 4.7 },

					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs =
					{
						Delay = 0.8,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "CharonGift06" },
							},
						},
					},

					Text = "Something about your Gold Rewards... in which I've achieved Silver status now? Oh thank you very much, my lord! I'm pleased to be a loyal customer of yours." },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift05" },
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
					Portrait = "Portrait_Mel_Proud_01",
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
			CharonAboutKeepsake02 =
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
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutKeepsake01" }
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_2837", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This Gold Purse that you handed me before... each night I find it brimming with coins... which must mean technically I'm in your debt." },
				{ Cue = "/VO/Charon_0092",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Nnnaauuugghh, hrrnnn..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2838", Text = "Whatever you say, my lord." },
				},
			},
			CharonAboutHermesKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "TimedBuffKeepsake" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Charon_0102",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Aauugggh{#Prev}, hhrrrrmm..." },
				{ Cue = "/VO/MelinoeField_3372", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Swiftness...? {#Prev}You mean the Metallic Droplet that I have, my lord. A gift from Hermes himself! No better way to reach your finest wares as soon as possible." },
				{ Cue = "/VO/Charon_0078",
					Text = "{#Emph}Rraaauuggggghhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.44,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Charon_0103", Text = "{#Emph}Hrraahhh..." },
				},
			},

			CharonAboutWellShops01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWellShops" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "WellShop" }
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Charon_0094",
					Text = "{#Emph}Rnnggghhh, ggraagghhh...?" },
				{ Cue = "/VO/MelinoeField_2839", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The reappearance of your Wells is certainly no accident, my lord. All it took was the appropriate incantation! Little by little, we shall restore the old order." },
				EndVoiceLines =
				{
					PreLineWait = 0.47,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Charon_0095", Text = "{#Emph}Hhhaaughh..." },
				},
			},
			CharonAboutSurfaceShops01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfaceShops" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "SurfaceShop" }
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_2842", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Shrines of Lord Hermes that I've seen around the surface... I noticed they take offerings of Gold as well. I take it the two of you are back in business, then?" },
				{ Cue = "/VO/Charon_0097",
					Text = "Hrrrrmmm, {#Emph}nnrrrraaauggghh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2843", Text = "Then may business be good." },
				},

			},

			CharonAboutCharonAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
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
			CharonAboutThanatosAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/Charon_0147",
					PreLineAnim = "Charon_Fierce",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Guuhhhh, raauuugggghh..." },

				{ Cue = "/VO/MelinoeField_4514", UsePlayerSource = true,
					-- PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean this scythe... you recognize it as your brother's then, my lord. Well I may not be Death Incarnate, but shall wield his blade as deftly as I'm able in his honor." },

				EndVoiceLines =
				{
					PreLineWait = 0.45,
					ObjectType = "NPC_Charon_01",
					{ Cue = "/VO/Charon_0148", Text = "{#Emph}Mmmm..." },
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
					Text = "Yes, my lord; I spoke the Oath, if that is what you mean. Thus in shadow, I serve; and to shadow I'll return, ere comes the light of Dawn." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					ObjectType = "NPC_Charon_01",
					{ Cue = "/VO/Charon_0082", Text = "{#Emph}Hrrnnngghh..." },
				},
			},
			CharonAboutShrine02 =
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
						Value = 8,
					},
				},
				{ Cue = "/VO/Charon_0104",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Hooaaaaahhh, hrrmm..." },
				{ Cue = "/VO/MelinoeField_3373", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sense the Testament of Night I think, my lord. So that your mother Nyx's influence may never fade, whether in the Underworld or beyond." },
				EndVoiceLines =
				{
					PreLineWait = 0.46,
					ObjectType = "NPC_Charon_01",
					{ Cue = "/VO/Charon_0105", Text = "{#Emph}Nrrrhhh..." },
				},
			},

			CharonAboutPackagedBounties01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
				{ Cue = "/VO/Charon_0106",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Krraaahhhh, hhrrrnn..." },
				{ Cue = "/VO/MelinoeField_3374", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sense it too, don't you? A strange feeling in the air... the influence of Chaos all around us. I'm being tested even now. Perhaps all of us are..." },
				EndVoiceLines =
				{
					PreLineWait = 0.46,
					ObjectType = "NPC_Charon_01",
					{ Cue = "/VO/Charon_0107", Text = "{#Emph}Mmmmmnn..." },
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

			CharonAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						HasAll = { "P_Shop01", "P_PreBoss01" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
				},
				{ Cue = "/VO/MelinoeField_2840", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I made it all the way up to the mountain of the gods, my lord! Though I missed you up there. Never thought I'd see a place you couldn't reach by boat." },
				{ Cue = "/VO/Charon_0096",
					Text = "{#Emph}Grrnnnggghh{#Prev}, hrreehhhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_2841", Text = "You have a very good distributor." },
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
					Portrait = "Portrait_Mel_Empathetic_01",

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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Portrait = "Portrait_Mel_Vulnerable_01",

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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "I_PreBoss01", "I_PreBoss02", },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Portrait = "Portrait_Mel_Proud_01",

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

			CharonAboutTyphon01 =
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
				},
				{ Cue = "/VO/Melinoe_4240", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I reached the summit of Olympus finally... they're fighting back against Typhon himself! Perhaps you knew already..." },
				{ Cue = "/VO/Charon_0098",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Hreeeehh, hrrmmm..." },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4241", Text = "He's quite enormous, yes." },
				},
			},
			CharonAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "Hero", "IsDead" }
							},
							{
								PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
							},
						},
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" }
							},
							{
								PathTrue = { "PrevRun", "EnemyKills", "TyphonHead" },
							},
						},
					},
				},
				{ Cue = "/VO/Charon_0099",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Hraaaauugghhh, haaaahhh...!" },
				{ Cue = "/VO/Melinoe_4242", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We vanquished Typhon, at least for the night, my lord! Hermes ensured that I was well-supplied. Plenty of Gold for you lately!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.44,
						ObjectType = "NPC_Charon_01",
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Charon_0100", Text = "{#Emph}Graauuggghh..." },
					},
				},
			},

			CharonAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
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
						IsAny = { "F" },
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
						PreLineWait = 0.42,
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
						PreLineWait = 0.43,
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
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "MorosWithCharon01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosSecondAppearance" }, Max = 8.6 },
					},
				},
				{ Cue = "/VO/Melinoe_2007", UsePlayerSource = true,

					--[[
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					]]--

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 7.5 },

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
					PreLineWait = 0.47,
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
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, my lord, I met Apollo, Grandmother, Uncle Poseidon... I've known Artemis and Hermes for so long, I'm impressed they kept my secret from the others all this time." },
				EndVoiceLines =
				{
					PreLineWait = 0.48,
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
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutOlympians01" },
					},
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
					{ Cue = "/VO/Melinoe_3262", Text = "He'll be back any evening now I'm sure." },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutHermesMission01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "CharonAboutHermesMission01" }, Min = 2 },
					},
				},
				{ Cue = "/VO/Charon_0050",
					Text = "{#Emph}Hrrrmmmmmm..." },
				{ Cue = "/VO/Melinoe_1817", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain he's all right, my lord. This is Hermes we're talking about! It's not like anyone could catch him, even if he were in peril." },
				EndVoiceLines =
				{
					PreLineWait = 0.46,
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
					Portrait = "Portrait_Mel_Hesitant_01",
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
			CharonAboutHermes04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFieldAboutTyphon01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_PreBoss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/Melinoe_4243", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've run into Lord Hermes at the summit of Olympus, making preparations against Typhon with the rest. Have you been able to cross paths with him?" },
				{ Cue = "/VO/Charon_0101",
					Text = "{#Emph}Hrrrmmm, mmrrrrngghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_4244", Text = "So, not for very long." },
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
						HasAll = { "CharonGift01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "CharonWithHecate01", "MorosWithCharon01", "MorosWithCharon02", "CharonAboutArtemisSinging01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Charon_01" }
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01", }, Alive = false },
					},
				},
				{ Cue = "/VO/Melinoe_1296", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01", }, Alive = false },
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
			CharonAboutNemesisShopping01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01", }, Alive = true },
					},
				},
				{ Cue = "/VO/MelinoeField_3375", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "I see you have another customer, my lord. First come first served, is it?" },
				{ Cue = "/VO/Charon_0108",
					Text = "{#Emph}Hrrrraauugghhh, haaahhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.42,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3376", Text = "I'll hurry it up." },
				},
			},
			CharonAboutHeraclesShopping01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Heracles_01", }, Alive = true },
					},
				},
				{ Cue = "/VO/MelinoeField_3377", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "Supplying goods to mighty Heracles! Sometimes I wonder whom else you provide for, my lord. Not that you'd say." },
				{ Cue = "/VO/Charon_0109",
					Text = "{#Emph}Nnnrrrraaauuuggghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.42,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_0423_B", Text = "Oh." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				{ Cue = "/VO/Melinoe_1294", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutFates02" },
					},
				},
				{ Cue = "/VO/Melinoe_1298", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						Value = 4,
					},
					OrRequirements =
					{
						{
							{
								SumPrevRuns = 2,
								Path = { "EncountersOccurredCache" },
								TableValuesToCount = { "ArtemisCombatN", "ArtemisCombatN2" },
								CountPathTrue = true,
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsAny = { "N" },
							},
						},
						{
							{
								SumPrevRuns = 2,
								Path = { "EncountersOccurredCache" },
								TableValuesToCount = { "ArtemisCombatF", "ArtemisCombatF2", "ArtemisCombatG", "ArtemisCombatG2" },
								CountPathTrue = true,
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsAny = { "F", "G" },
							},
						},
					},
				},
				{ Cue = "/VO/Melinoe_1818", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Proud_01",
					Text = "It's reassuring to know Artemis has been keeping track of things around here lately, my lord. She seems unusually well-supplied..." },
				{ Cue = "/VO/Charon_0056",
					Text = "{#Emph}Hhrrraaauuggghhh..." },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
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

			CharonGrantsHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "AxeArmCastAspect", "AxePerfectCriticalAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "AxeArmCastAspect5", "AxePerfectCriticalAspect5" },
					},
					NamedRequirementsFalse =
					{
						"StaffHiddenAspectRevealInProgress",
						"DaggerHiddenAspectRevealInProgress",
						"TorchHiddenAspectRevealInProgress",
						-- "AxeHiddenAspectRevealInProgress",
						"LobHiddenAspectRevealInProgress",
						"SuitHiddenAspectRevealInProgress"
					},
				},
				{ Cue = "/VO/Charon_0129",
					PreLineAnim = "Charon_Greeting",
					Text = "{#Emph}Shaaaauugghh..." },

				{ Cue = "/VO/MelinoeField_3501", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Lord Charon, are you giving this to me? The pattern on this parchmentwork... the Mark of Night, and a triple-headed lion, and the words... {#Emph}I see you hoard the shattered corpses of your foes. {#Prev}This is a waking-phrase, for Zorephet?" },

				{ Cue = "/VO/Charon_0130",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Rrrraauugghh, hrrrrn..." },

				{ Cue = "/VO/MelinoeField_3502", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "You are entrusting me with this. Well if you think I'm ready then I'll say it at the Silver Pool next opportunity I get. Thank you, my lord." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineThreadedFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Axe" },
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3806", Text = "{#Emph}I see you hoard the shattered corpses of your foes." },
					},
					{
						PreLineWait = 0.31,
						ObjectType = "NPC_Charon_01",
						{ Cue = "/VO/Charon_0130", Text = "{#Emph}Nrrrggghhh, hnnn..." },
					},
				},
			},
			CharonAboutHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
					},
				},
				{ Cue = "/VO/MelinoeField_3530", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					Text = "This is it, my lord! The hidden aspect of Nergal that I would never have revealed if not for you. Is this some warrior-god from a distant land, or time?" },
				{ Cue = "/VO/Charon_0131",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Nrrrggghhh, haaaa..." },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_3531", Text = "Then perhaps both..." },
				},

			},

			CharonAboutZagreusFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{ Cue = "/VO/MelinoeField_5037", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Charon, why didn't you say anything about those Infernal Contracts I've started to see? I wound up in an inadvertent clash with Zagreus!" },

				{ Cue = "/VO/Charon_0150",
					PreLineAnim = "Charon_Fierce",
					Text = "{#Emph}Graaahhh, hrrrmmm...?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "EnemyKills", "Zagreus" },
							},
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
								Comparison = ">",
								Value = 0,
							},
						},

						{ Cue = "/VO/MelinoeField_5038", Text = "Well, you know what I mean. And no I {#Emph}didn't {#Prev}win!" },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							OrRequirements =
							{
								{
									{
										PathTrue = { "CurrentRun", "EnemyKills", "Zagreus" },
									},
								},
								{
									{
										Path = { "GameState", "LastBossHealthBarRecord", "Zagreus" },
										Comparison = "==",
										Value = 0,
									},
								},
							},
						},

						{ Cue = "/VO/MelinoeField_5039", Text = "Well, you know what I mean. And yes, I {#Emph}won!" },
					},
				},
			},

			CharonPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Charon_0141",
					Text = "{#Emph}Nnnnn... haaaaahh, hrhrrnngghhh..." },

				{ Cue = "/VO/MelinoeField_4506", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We are victorious indeed, my lord, and thanks in no small part to all you've done. I trust that Nyx has already visited with you. But, what of all the Gold that remains?" },

				{ Cue = "/VO/Charon_0142",
					PreLineAnim = "Charon_Fierce",
					Emote = "PortraitEmoteAnger",
					Text = "{#Emph}Grrrnn, hraaauggghh..." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_4507", Text = "Then you shall have it!" },
				},
			},
			CharonPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "BiomesReached", "F" },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "N" },
							},
						},
						{
							{
								PathTrue = { "PrevRun", "BiomesReached", "N" },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "F" },
							},
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4508", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why am I unsurprised you're still here offering your wares, even with everything that's happened recently, my lord? You won't stop until the Underworld's entirely restored." },

				{ Cue = "/VO/Charon_0143",
					PreLineAnim = "Charon_Fierce",
					Emote = "PortraitEmoteAnger",
					Text = "{#Emph}Hrrraaaugggghhh!!" },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_4509", Text = "Not even then, got it!" },
				},

			},
			CharonPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Charon_0144",
					PreLineAnim = "Charon_Thanking",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Kkhhhrrnn, aaauugggghhhh...!" },

				{ Cue = "/VO/MelinoeField_4510", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...You mean your sisters the Fates... you knew they'd be all right? I never imagined I could even meet them myself. One of them, she... well, she reminded me a little bit of {#Emph}you." },

				{ Cue = "/VO/Charon_0145",
					PreLineAnim = "Charon_Fierce",
					Emote = "PortraitEmoteAnger",
					Text = "{#Emph}Guuuhhhhh..." },

				EndVoiceLines =
				{
					PreLineWait = 0.42,
					UsePlayerSource = true,
					{ Cue = "/VO/MelinoeField_4511", Text = "Well it was only a first impression..." },
				},
			},

			-- hub events / hub-only
			CharonAboutArtemisSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
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
				{ Cue = "/VO/Charon_0110",
					Text = "Mmmm, {#Emph}mmmmrrnnnn..." },
				{ Cue = "/VO/Melinoe_4184", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "You picked a fine time to make your deliveries, my lord. That's Artemis singing nearby! Although perhaps such music isn't to your taste." },
				EndVoiceLines =
				{
					PreLineWait = 0.48,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 3,
					{ Cue = "/VO/Charon_0111", Text = "{#Emph}Mmmm..." },
				},
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
					Portrait = "Portrait_Mel_Proud_01",
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
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perseverance is what got us to this point, my lord. May your resolve never waver! Whenever mine does, I take comfort knowing I have such dependable allies." },
			},
			CharonGift05 =
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
				{ Cue = "/VO/Charon_0132",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Nraaauuggh, guhhh..." },
				{ Cue = "/VO/Melinoe_5438", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You really should try it sometime, my lord! Nectar is one of the things just about everybody on Olympus can agree on, and that must mean something, right?" },
			},
			CharonGift06 =
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
				{ Cue = "/VO/Charon_0133",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Hrrnnnmm, nnrrrr..." },
				{ Cue = "/VO/Melinoe_5439", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you never would permit yourself indulgences, my lord, but... you ought to receive more than mere coin in recompense for all your service! Perhaps the Nectar's but another token gesture." },
				EndVoiceLines =
				{
					PreLineWait = 0.47,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Charon_0134", Text = "{#Emph}Ehhh..." },
				},
			},
			CharonGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_CharonUnlockHint01",
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
						HasAll = { "CharonGift06", "CharonAboutCharonPoints01" },
					},
				},
				{ Cue = "/VO/Melinoe_5440", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've heard in times past, you'd discreetly transport shipments of Ambrosia all the way into the depths of Tartarus. And knowing you, my lord, you would never sample your own wares, so here. This is a gift, not a delivery." },

				{ Cue = "/VO/Charon_0136",
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Hoohhhhh, hrrrnnnn..." },

				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_5441", Text = "May there soon come such a time..." },
				},
			},
			CharonGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedCharon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CharonGift06", "CharonAboutCharonPoints01" },
					},
				},
				{ Cue = "/VO/Melinoe_5442", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Here, my lord. If you plan to keep the other Ambrosia bottle in reserve, perhaps you could share this one with a professional associate. No need to save it for later." },

				{ Cue = "/VO/Charon_0137",
					PreLineWait = 0.35,
					PreLineAnim = "Charon_Thanking",
					Text = "{#Emph}Auuugggghh, mmmm...? Kkrrnnn..." },

				{ Cue = "/VO/Melinoe_5443", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Charon_01", Icon = "Keepsake_Charon" },

					Text = "...I've merely strived to better understand you, knowing it was never about words or gifts. You are the Boatman of the Underworld... a mighty son of Nyx... and the most dependable sort of comrade I could ever want." },

				EndVoiceLines =
				{
					PreLineWait = 0.49,
					ObjectType = "NPC_Charon_01",
					RequiredMinElapsedTime = 2,
					{ Cue = "/VO/Charon_0138", Text = "{#Emph}Nnnnhhh..." },
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

-- Global Charon Lines
GlobalVoiceLines.CharonGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "NPC_Charon_01",
	-- PreLineAnim = "Charon_Fierce",
	Cooldowns =
	{
		{ Name = "CharonSpokeRecently", Time = 12 },
	},
	GameStateRequirements =
	{
		{
			PathFalse = { "CurrentRun", "Hero", "IsDead" },
		},
	},

	{ Cue = "/VO/Charon_0118", Text = "{#Emph}Guhhh..." },
	{ Cue = "/VO/Charon_0119", Text = "{#Emph}Rrnnn..." },
	{ Cue = "/VO/Charon_0120", Text = "{#Emph}Krrhh..." },
	{ Cue = "/VO/Charon_0121", Text = "{#Emph}Ksshh..." },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Charon )