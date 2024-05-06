UnitSetData.NPC_Medea =
{
	-- Medea, Id = TKTK
	NPC_Medea_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Medea_Default_01",
		AnimOffsetZ = 20,
		Groups = { "NPCs" },
		SpeakerName = "Medea",
		SubtitleColor = Color.MedeaVoice,
		TurnInPlaceAnimation = "Medea_Turn",

		RequiredRoomInteraction = true,
		
		Traits = 
		{
			"HealingOnDeathCurse",
			"MoneyOnDeathCurse",
			"ManaOverTimeCurse",
			"SpawnDamageCurse",
			"ArmorPenaltyCurse",
			"SlowProjectileCurse",
			"DeathDefianceRetaliateCurse",
		},
		ActivateRequirements =
		{
			-- None
		},
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		RepulseOnMeleeInvulnerableHit = 5,

		UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/SFX/TitanBloodDropSFX",
		MenuTitle = "MedeaCurseMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Medea",

		FlavorTextIds =
		{
			"MedeaCurseMenu_FlavorText01",
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
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
				SuccessiveChanceToPlayAll = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/MelinoeField_0492", Text = "Moonlight guide you, milady.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0493", Text = "Death to Chronos, milady.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				PreLineAnim = "Medea_Salute",
				ObjectType = "NPC_Medea_01",

				{ Cue = "/VO/Medea_0098", Text = "Together we shine.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1697", "/VO/Melinoe_0025" },
						},
					},
				},
				{ Cue = "/VO/Medea_0099", Text = "A most accursed night.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Medea_0100", Text = "Darkness guide you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Medea_0101", Text = "My greetings in kind.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/MelinoeField_0492" },
						},
					},
				},
				{ Cue = "/VO/Medea_0102", Text = "He shall suffer.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700", "/VO/MelinoeField_0493" },
						},
					},
				},
				{ Cue = "/VO/Medea_0103", Text = "And you in turn.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/MelinoeField_0492" },
						},
					},
				},
				{ Cue = "/VO/Medea_0104", Text = "With Selene's grace.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Medea_0105", Text = "I have no doubt she shall.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Medea_0106", Text = "That or the scent of blood.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Medea_0107", Text = "I'm certain that it shall.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Medea_0108", Text = "By your will, sorceress." },
				{ Cue = "/VO/Medea_0109", Text = "You honor me." },
			}
		},

		InteractTextLineSets =
		{
			MedeaFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0002",
					-- PreLineAnim = "Medea_Greet",
					-- PreLineAnim = "Medea_Bless",
					-- PreLineAnim = "Medea_Scoff",
					-- PreLineAnim = "Medea_Sprinkle",
					-- PreLineAnim = "Medea_Casting_Start",
					-- PostLineAnim = "Medea_Casting_End",
					PreLineAnim = "Medea_Salute",
					Text = "Hail, sorceress! Welcome to Ephyra. Suffering spreads every which way you cast your gaze, and on a night most foul. Simply appalling, no?" },
				{ Cue = "/VO/MelinoeField_0253", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Indeed, Lady Medea. Unfortunately, I can only appreciate the suffering for so long, as Olympus calls. Though, how fares your research?" },
				{ Cue = "/VO/Medea_0003",
					Text = "Oh, I've been {#Emph}dying {#Prev}to show you! The air here's {#Emph}absolutely {#Prev}poisonous. The conditions? Utterly atrocious! Observe what I have wrought..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutFoes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0026",
					Text = "{#Emph}Ah{#Prev}, the sorceress returns. Not had your fill of this putrescent atmosphere? Or merely not succeeded yet in breaking the Titan's siege?" },
				{ Cue = "/VO/MelinoeField_0254", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not succeeded yet. Chronos can replenish his forces as quickly as Olympus can repel them. Have you found any weaknesses in their ranks?" },
				{ Cue = "/VO/Medea_0027",
					PreLineAnim = "Medea_Scoff",
					Text = "They cannot be permanently slain, are barely susceptible to my most noxious poisons, and are single-minded in their devotion to the Titan Lord. Any of those sound like weaknesses?" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutEphyra01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0326", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How long have you resided here, Lady Medea? I thought all our forces fled once the city was overrun, but you seem rather comfortable." },
				{ Cue = "/VO/Medea_0028",
					Text = "Oh, yes! All the death and panic made for many vacancies. I slipped in through the shadows soon after the city fell, and remained, practicing, observing.... Great Hecate has eyes upon the surface {#Emph}everywhere..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutBlood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0029",
					Text = "I have to thank you, sorceress! After you last rampaged throughout this city, I obtained a sample of your blood. Oh, it's very potent stuff!" },
				{ Cue = "/VO/MelinoeField_0327", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm{#Prev}, you're welcome, Lady Medea. Although, moving forward, please ask me prior to using my lifeblood as part of your experiments." },
				{ Cue = "/VO/Medea_0030",
					Text = "How about I use it anyway but never mention doing so again? Fear not, I use it only toward a common outcome we desire...!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutPoisons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0039",
					Text = "Vast is the breadth of our craft, isn't it, sorceress? For all your studies with Great Hecate, I suspect you've scarce learned anything about {#Emph}my {#Prev}areas of expertise..." },
				{ Cue = "/VO/MelinoeField_0334", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're right that my experience is no match for yours, Lady Medea. I've spent very little time with mortals... still-living ones, that is." },
				{ Cue = "/VO/Medea_0040",
					PreLineAnim = "Medea_Scoff",
					Text = "Of late, I'm spending little time with the still-living ones, myself. Most are highly susceptible to insinuation, or at least to certain types of toxins, easily administered in food or drink." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutUndead01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0330", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Shades about this place... they're trapped in the decaying bodies of their mortal selves, aren't they? Unable to travel to my father's realm." },
				{ Cue = "/VO/Medea_0033",
					PreLineAnim = "Medea_Scoff",
					Text = "I know, right? This is a {#Emph}revolution {#Prev}in the necromantic arts! These shuffling wretches, trapped on the very verge of death... I could study them for moons and moons on end!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutVengeance01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 5,
					},	
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0328", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You work so tirelessly at your craft, Lady Medea. If I may ask, where do you find the strength for your pursuits night after night?" },
				{ Cue = "/VO/Medea_0031",
					PreLineAnim = "Medea_Casting_Start",
					PostLineAnim = "Medea_Casting_End",
					Text = "It's very much straightforward, sorceress. I seek to punish all who wronged me, in proportion to the harm they caused. Though have no fear, you're not on any list of mine!" },
				{ Cue = "/VO/MelinoeField_0329", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you been wronged so often that you need more than one list of wrongdoers? What happens when you've cursed them all?" },
				{ Cue = "/VO/Medea_0032",
					PreLineAnim = "Medea_Scoff",
					Text = "My lists are based on categories of affront; from mere dislikes, to deep betrayals. As for what happens after I've achieved my work... I'll have to get back to you on that one." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutReputation01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0335", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, for all the dread and despair everywhere I turn, you've come to be a welcome sight, Lady Medea. I'm pleased to know you a bit better now." },
				{ Cue = "/VO/Medea_0041",
					PreLineAnim = "Medea_Scoff",
					Text = "Do not profess to know me, sorceress. You know my reputation, and express surprise that I do not appear as cruel as it suggests. Yet the greatest cruelties can be cleverly disguised..." },
				{ Cue = "/VO/MelinoeField_0336", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I meant no offense. I don't profess to know you well at all, only to say I look forward to our encounters. As for your reputation, I care little for what others say of those such as us." },
				{ Cue = "/VO/Medea_0042",
					Text = "Perhaps you ought care more, for we are rightly to be feared. And there are those who'd turn upon us, sullying our names, or worse. Safeguard your trust, is my advice to you." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutOptimism01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0332", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your curses have been of great help, Lady Medea. Though if only I had your optimism. You're always smiling, even in such a place as this." },
				{ Cue = "/VO/Medea_0036",
					Text = "What's not to like? No shortage here of blood for my research, and the dead are wise enough to stay afield of me. Now here, let's cast another curse and you'll be right as rot!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutWitchcraft01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0037",
					Text = "How much has changed with time. It's not as often that I see familiar faces such as yours, or hateful ones. So many fail to understand our ways." },
				{ Cue = "/VO/MelinoeField_0333", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've always seemed to have ways of making them understand, Lady Medea. Though do you find you miss living among mortals?" },
				{ Cue = "/VO/Medea_0038",
					PreLineAnim = "Medea_Scoff",
					Text = "Locating live subjects for my research used to be easier, but that exception notwithstanding, no. A few true friends are better than a thousand friendly-feigning strangers." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutSolitude01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0338", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're always on your own, Lady Medea. Are there no family members or loved ones who could be accompanying you in your... experiments?" },
				{ Cue = "/VO/Medea_0045",
					Text = "Oh they are with me, in a way; their spirits or their memories. But why suggest that solitude's in need of remedy? There can be times when one could use companionship, but such impulses can be sated, case-by-case." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutSuffering01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0339", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must know a great deal about mortals. How they live, suffer, and die. Have you found ways to ease their passing, at least?" },
				{ Cue = "/VO/Medea_0046",
					PreLineAnim = "Medea_Scoff",
					Text = "Whyever would I do a thing like that? Great Hecate herself says that the greatest teacher is out {#Emph}there. {#Prev}To suffer is to learn! I merely wish to become a good teacher, myself." },
				{ Cue = "/VO/MelinoeField_0340", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Mortal cries of anguish and despair do nothing to move you to compassion, or to mercy at least? I find them quite unnerving." },
				{ Cue = "/VO/Medea_0047",
					Text = "You learn to close your heart to all of it. No mortal has a right to live for long! Certainly there exist those whose skill is to ease suffering; I merely seek to understand its cause." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutCurses01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0342", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What gives your incantations such great potency, Lady Medea? So many curses have intangible effects, yet yours pierce like a blade..." },
				{ Cue = "/VO/Medea_0050",
					PreLineAnim = "Medea_Casting_Start",
					Text = "A well-wrought curse requires suitable reagents, and pure intention without compromise. Any hesitancy, any second-guessing undermines an ill effect." },
				{ Cue = "/VO/MelinoeField_0343", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That I understand... it's the pure intent toward misfortune that I struggle to achieve. How can one wish such ill upon another, without imagining some of it turning back one's way?" },
				{ Cue = "/VO/Medea_0051",
					PreLineAnim = "Medea_Casting_End",
					Text = "With practice, sorceress! Ill intent does threaten to reflect back upon oneself, often with greater potency. But with the blackest of intent... there's nothing to reflect at all." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "DamagedDamageBoostKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_0500", UsePlayerSource = true,
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you again for the gift, Lady Medea. This bit of fleece is extraordinary, isn't it... and very soft!" },
				{ Cue = "/VO/Medea_0060",
					Text = "You have the blackened tuft of wool I gave to you! It once shone golden as the sun. But I saw fit to modify its properties, to make it better serve sorceresses such as we..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0043",
					Text = "How fares Great Hecate amid such inauspicious nights? Scarce has she had occasion lately to illuminate this place..." },
				{ Cue = "/VO/MelinoeField_0337", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress seems well enough. I've not once seen hardship ever get to her. But then, perhaps she wears that veil of hers so as to never show even a trace of doubt." },
				{ Cue = "/VO/Medea_0044",
					PreLineAnim = "Medea_Casting_Start",
					PostLineAnim = "Medea_Casting_End",
					Text = "We all wear veils, don't we, sorceress? Great Hecate, she merely puts aside all pretenses about it. Well, good to know that she is still herself. And I remain her humble servant, here." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0034",
					Text = "I meant to warn you, by the way, to not engage with the big burly lion-maned fellow who sometimes stalks about the streets out there..." },
				{ Cue = "/VO/MelinoeField_0331", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must mean Heracles. We've already met, and I gathered that I ought to keep my distance. He says he serves the gods but... he's a threat?" },
				{ Cue = "/VO/Medea_0035",
					PreLineAnim = "Medea_Scoff",
					Text = "Oh, he's just a big downer! I cure his injuries yet still he incurs more, and not even {#Emph}I {#Prev}possess the power yet to cure his spirit. The dead have more cheer than a man like that. Now, come! I've curses to concoct." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutCirce01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Circe_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0048",
					Text = "How absurd, the very idea of family, sorceress. That we've some innate bond with those who share some of our blood! You've met my Aunt Circe; do you believe that we're at all alike?" },
				{ Cue = "/VO/MelinoeField_0341", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe seems very devoted to our craft in her own right. Just, not in the same way as you, Lady Medea. Are you so loath to think that you may have something in common?" },
				{ Cue = "/VO/Medea_0049",
					PreLineAnim = "Medea_Scoff",
					Text = "Circe was never willing to push our practice to the depths of what it can achieve. She would turn mortals into livestock; {#Emph}I {#Prev}would turn them dead. A differing approach is all, perhaps..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutApollo01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0052",
					Text = "{#Emph}Ah! {#Prev}You bear the light of Apollo himself! Well, just remember that he's not the only one who can create a decent plague around here." },
				{ Cue = "/VO/MelinoeField_0344", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Apollo certainly has a broad range of talents. So, he would sometimes cast down plagues on mortalkind? Do you know why?" },
				{ Cue = "/VO/Medea_0053",
					PreLineAnim = "Medea_Scoff",
					Text = "Why do the gods do anything at all? Simply because they can! Besides, a good plague now and then helps keep the common stock in line." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0054",
					Text = "Glorious Hera has opted to lend to you her power, if my senses don't deceive. You're family of hers, and come to her defense. Perhaps she shall be favorable to you!" },
				{ Cue = "/VO/MelinoeField_0345", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She has been thus far. I know the gods can take care of themselves, but we seem to have a mutual understanding and a shared interest at the moment." },
				{ Cue = "/VO/Medea_0055",
					PreLineAnim = "Medea_Scoff",
					Text = "How mercenary. And the proper posture with the gods, I think! You needn't second-guess my aid. Great Hecate wills it, so it shall be yours." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutFoes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0026",
					Text = "{#Emph}Ah{#Prev}, the sorceress returns. Not had your fill of this putrescent atmosphere? Or merely not succeeded yet in breaking the Titan's siege?" },
				{ Cue = "/VO/MelinoeField_0254", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not succeeded yet. Chronos can replenish his forces as quickly as Olympus can repel them. Have you found any weaknesses in their ranks?" },
				{ Cue = "/VO/Medea_0027",
					PreLineAnim = "Medea_Scoff",
					Text = "They cannot be permanently slain, are barely susceptible to my most noxious poisons, and are single-minded in their devotion to the Titan Lord. Any of those sound like weaknesses?" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			-- home events
			MedeaHubFirstMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_Story01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01" },
						Comparison = ">=",
						Value = 5,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaHubGreeting,

				{ Cue = "/VO/Medea_0065",
					Text = "So many more shades of the dead now linger here! And the earthy aroma, quite unlike before. These Crossroads changed since last I visited!" },
				{ Cue = "/VO/Melinoe_2510", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Welcome back to the abode, Lady Medea. What brings you here, and will you be staying with us for a little while?" },
				{ Cue = "/VO/Medea_0066",
					PreLineAnim = "Medea_Sprinkle",
					Text = "No, I am Great Hecate's eyes upon the surface. But the night is young, and I've business with the Broker there; a surplus of Bones to exchange. See you above and below, sorceress." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1256_B", Text = "See you." },
					},
				},
			},

			-- Repeatable
			MedeaChat01 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0004",
					Text = "Such a terrible shame were a terrible curse to befall our enemies this eve..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat02 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0005",
					Text = "Those who seek to do us wrong deserve no quarter whatsoever, sorceress." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat03 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0006",
					Text = "We cannot always bring our foes an agonizing death, yet we may strive." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat04 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0007",
					Text = "Ill fortune comes in many different forms; you need but choose." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat05 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0008",
					Text = "On lonesome nights as this, a concoction of a certain potency is certainly in order." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat06 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0009",
					Text = "You shall develop a taste for my poisons in due course, sorceress." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat07 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0010",
					Text = "Together let us curse our enemies this night, and into the beyond." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat08 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0011",
					Text = "What shall it take to bring our enemies to heel? Let us find out." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat09 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0012",
					Text = "If you seek the spread of pain and suffering, you've come to the right place." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat10 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0013",
					Text = "The best protection against curses is to put in place some curses of one's own." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat11 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0014",
					Text = "Our enemies shall come to understand the essence of fear itself." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat12 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0015",
					Text = "The very air we breathe shall be as poison to all those who stand against us." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat13 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0016",
					Text = "Our will and influence shall spread forth like a plague." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat14 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0017",
					Text = "I do suggest that you not linger here too long; ill side-effects and all." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat15 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0018",
					Text = "Unpleasantries take many different forms, and I would master them all." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat16 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0019",
					Text = "This night practically {#Emph}begs {#Prev}for a real {#Emph}atrocity {#Prev}of some sort, no?" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat17 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0020",
					Text = "Welcome back to the necropolis, and may your stay be pleasantly short-lived." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat18 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0021",
					Text = "I've an {#Emph}absolutely {#Prev}appalling idea I'm dying to attempt, if you'll indulge me?" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat19 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0022",
					Text = "Why don't we go and spread some more malaise about, no?" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat20 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0023",
					Text = "To achieve aught of value, sacrifices always must be made, sorceress." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat21 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0024",
					Text = "May blight befall our enemies... and even those we simply do not like." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat22 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0025",
					Text = "I've several more unspeakable transgressions against nature here for you." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

		},

		GiftTextLineSets =
		{
			MedeaGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
				},
				{ Cue = "/VO/Melinoe_3303", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I almost pity our enemies, knowing you shall make them rue each night they dare oppose us, Lady Medea. Please, I wanted you to have this." },
				{ Cue = "/VO/Medea_0056",
					Text = "The Nectar of the gods! Why, this shall be most useful to my work. For the strongest curses come from honeyed words! Here, let me make this worth your while." },
			},
			MedeaGift02 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
				},
				{ Cue = "/VO/Medea_0057",
					Text = "Another Nectar bottle you can spare on my behalf? Oh, this shall be a splendid complement with several much less pleasant ingredients, whose aroma this ought to disguise!" },
				{ Cue = "/VO/Melinoe_3300", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I shudder to think what concoction you have in mind, though trust you shall make use of that in service to our cause." },
			},
			MedeaGift03 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
				},
				{ Cue = "/VO/Medea_0058",
					Text = "One always could see plain your talent, sorceress; but truth be told, I thought your heart would be a liability. Perhaps, however... I was wrong in that." },
				{ Cue = "/VO/Melinoe_3301", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm thankful for your faith in me. My heart is never so assertive that it would lead me astray. Or so I tell myself, anyway..." },
			},
			MedeaGift04 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
				},
				{ Cue = "/VO/Medea_0059",
					Text = "The gods of Olympus have not always been particularly kind. Yet you, a true-blood relative of theirs, would show me favor for little more than carrying out my oath to Great Hecate? Unnecessary, this; I've only curses in return." },
				{ Cue = "/VO/Melinoe_3302", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're so much more than your curses, Lady Medea. Perhaps the gods of Olympus and the dead never told you so, but I believe it's true." },
			},

			-- placeholder
			MedeaGiftTemp =
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

			{ Cue = "/VO/Melinoe_3299", Text = "From one sorceress to another, thank you." },
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Medea_01",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			TriggerCooldowns = { Name = "MedeaSpokeRecently" },

			{ Cue = "/VO/Medea_0092", Text = "Some other time." },
			{ Cue = "/VO/Medea_0093", Text = "Stay your hand." },
			{ Cue = "/VO/Medea_0094", Text = "We really shouldn't here." },
			{ Cue = "/VO/Medea_0097", Text = "Oh, not now.", PlayFirst = true },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Medea )