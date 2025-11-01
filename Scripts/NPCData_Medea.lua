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
		LoadPackages = { "Medea" },
		SubtitleColor = Color.MedeaVoice,
		TurnInPlaceAnimation = "Medea_Turn",
		PreEventFunctionName = "AngleNPCToHero",
		
		AttachedAnimationName = "MedeaGlow",

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

			"NewStatusDamage",
		},
		ActivateRequirements =
		{
			-- None
		},
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		RepulseOnMeleeInvulnerableHit = 150,

		UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA2",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeMedeaFleece2",
		MenuTitle = "MedeaCurseMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Medea",

		FlavorTextIds =
		{
			"MedeaCurseMenu_FlavorText01",
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
						PathTrue = { "CurrentRun", "TextLinesRecord", "MedeaGrantsHiddenAspect01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3500", Text = "{#Emph}I see you gather countless dead in cold and dark domains..." },
			},
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
						PathTrue = { "CurrentRun", "TextLinesRecord", "MedeaAboutConcoctionQuest01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4334", Text = "Of course. {#Emph}Harm for the Afflicted{#Prev}, is it?" },
			},
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
						PathTrue = { "CurrentRun", "TextLinesRecord", "MedeaAboutConcoctionQuestComplete01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4339", Text = "This sounds... potent." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MedeaGrantsHypnosSpell01VO",
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "MedeaGrantsHypnosSpell01" },
					},
				},

				{ Cue = "/VO/MelinoeField_3814", Text = "Thank you, Lady Medea." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MedeaGrantsHypnosSpell02VO",
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "MedeaGrantsHypnosSpell02" },
					},
				},

				{ Cue = "/VO/MelinoeField_3950", Text = "Absolutely." },
			},
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
				},
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.31,
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
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
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
					-- PreLineAnim = "Medea_Salute",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Medea_Salute", WaitTime = 0.2, AngleNPCToHero = true, },
					Text = "Hail, sorceress! Welcome to Ephyra. Suffering spreads every which way you cast your gaze, and on a night most foul. Simply appalling, no?" },
				{ Cue = "/VO/MelinoeField_0253", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Indeed, Lady Medea. Unfortunately, I can only appreciate the suffering for so long, as Olympus calls. Though, how fares your research?" },
				{ Cue = "/VO/Medea_0003",
					PreLineAnim = "Medea_Scoff",
					Text = "Oh, I've been {#Emph}dying {#Prev}to show you! The air here's {#Emph}absolutely {#Prev}poisonous. The conditions? Utterly atrocious! Observe what I have wrought..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutFoes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					PreLineAnim = "Medea_Scoff",
					Text = "Oh, yes! All the death and panic made for many vacancies. I slipped in through the shadows soon after the city fell, and remained, practicing, observing.... Great Hecate has eyes upon the surface {#Emph}everywhere..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutBlood01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
					PreLineAnim = "Medea_Scoff",
					Text = "How about I use it anyway but never mention doing so again? Fear not, I use it only toward a common outcome we desire...!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutPoisons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift02" },
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
			MedeaAboutEmptiness01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaAboutVengeance01", "MedeaGift06" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_4714", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Do you ever feel as though your curses leave you empty, Lady Medea? When I yield to darker thoughts, after the initial rush subsides, I don't often like the sensation that lingers." },

				{ Cue = "/VO/Medea_0601",
					PreLineAnim = "Medea_Casting_Start",
					PostLineAnim = "Medea_Casting_End",
					Text = "Why, to feel empty is the entire purpose of this pharmaceutical enterprise, sorceress. To feel empty is to truly be at peace. The closest we can get to mortal death." },

				{ Cue = "/VO/MelinoeField_4715", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I understand what you mean, but... I would rather feel fulfilled, or happy, or excited, not just... nothing at all. Our senses and intuitions are what drive us." },

				{ Cue = "/VO/Medea_0602",
					PreLineAnim = "Medea_Scoff",
					Text = "They drive us to get rid of them. I rid myself of feeling all the time; rancor? Curse. Hunger? Sustenance. Lust? And on and on. For each affliction, there exists a cure." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutTrust01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaGift06" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0589",
					PreLineWait = 0.35,
					Text = "...You'd mentioned that you've come to trust in me. I wanted you to know it meant a lot. No one has told me so in recent times... even Great Hecate must keep me at arm's length." },

				{ Cue = "/VO/MelinoeField_4720", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lady Medea, surely your inclination to conducting research all alone has something to do with this. You'd be welcome and safe at the Crossroads if you wish to join us there." },

				{ Cue = "/VO/Medea_0590",
					PreLineAnim = "Medea_Scoff",
					Text = "No, I do not lack for company. The mere thought of being surrounded by the living and the dead alike makes the bile in my belly rise. But I don't mind {#Emph}you {#Prev}like so many of the rest." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutReputation01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Medea_01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift03" },
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
					Text = "You've always seemed to have ways of making them understand, Lady Medea. Though, do you find you miss living among mortals?" },
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
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TraitCache" },
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

			MedeaAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0179",
					Text = "The most {#Emph}outrageous {#Prev}bit of hearsay has been wafting lately on the winds, about what ails the mountain of the gods! You've been heading that way... what's going on?" },
				{ Cue = "/VO/MelinoeField_3808", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If the hearsay concerned an ancient and enormous monstrosity looking to crush Olympus to pieces, assuming the Titan's legions don't achieve it first... it's not hearsay." },
				{ Cue = "/VO/Medea_0180",
					PreLineAnim = "Medea_Scoff",
					Text = "Oh, my. Then I know which monstrosity you mean. And you intend to challenge him and all the rest? You're entirely mad, sorceress...! But so's the world over." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0181",
					Text = "{#Emph}Ah{#Prev}, to face such cataclysmic times, and all this tragedy! Truly these are memorable nights. How fare your journeys to that cursed place the gods call home?" },
				{ Cue = "/VO/MelinoeField_3935", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eventful, in a word! Your concoctions have been broadly useful on the way. I always thought such magick focused on a single victim at a time." },
				{ Cue = "/VO/Medea_0182",
					PreLineAnim = "Medea_Scoff",
					Text = "Reach a certain point, and the world itself can be the single target of your wrath. Keep practicing, sorceress! We've no shortage of enemies on whom to ply our trade." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
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

			MedeaGrantsHypnosSpell01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaGift02", "HypnosDreamMeeting01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/MelinoeField_3813", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wanted to mention, Lord Hypnos still is slumbering in the Crossroads. I tried Dream Vapors on him to no avail. Can you think of anything more potent, perhaps?" },

				{ Cue = "/VO/Medea_0256",
					PreLineAnim = "Medea_Scoff",
					Text = "Well, I can think of how to make Dream Vapors {#Emph}more {#Prev}potent, sorceress! They practically could rouse the dead. As for that dormant son of Nyx, who knows? But little harm in trying!" },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeWakeHypnosT2" },
				},
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaGrantsHypnosSpell02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaGrantsHypnosSpell01", "HypnosWakeUp02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/MelinoeField_3948", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your stronger Dream Vapors helped me get deeper into the psyche of Lord Hypnos, but unfortunately not deep enough. He's still dozing away. Anything else I can try?" },

				{ Cue = "/VO/Medea_0257",
					PreLineAnim = "Medea_Scoff",
					Text = "Oh, there's always something. Rearrange some pieces of his mind, perhaps. Have you tried stabbing him repeatedly?" },

				{ Cue = "/VO/MelinoeField_3949", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was thinking more along the lines of his connection to his brother, the incarnate of Death. Is there some way to imbue the Dream Vapors with the essence of the dead?" },

				{ Cue = "/VO/Medea_0258",
					PreLineAnim = "Medea_Greet",
					Text = "Why certainly, the properties of Sleep and Death go hand in hand. I think I can point you in the right direction on that one! Do tell me how it goes...?" },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeWakeHypnosT3" },
				},
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutHypnos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/MelinoeField_4231", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I woke him up, Lady Medea! Lord Hypnos, I mean. Thank you for all your guidance with the Dream Vapors. The House of Hades owes you a great debt." },

				{ Cue = "/VO/Medea_0259",
					PreLineAnim = "Medea_Greet",
					Text = "Those are such tidings as I wish to hear! All I ask in return is that the Underworld gates remain ajar yet for some time. The dead and I, we still have many matters to explore..." },

				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutApollo01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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

			MedeaAboutMedeaAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobCloseAttackAspect" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0227",
					Text = "Why, if it isn't my own Aspect of the Argent Skull Revaal. It's been a while since I harnessed her unmitigated fury. Is she agreeable with you most of the time?" },
				{ Cue = "/VO/MelinoeField_3936", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, but... the Argent Skull, you speak of it — of {#Emph}her{#Prev}, as though she is a living being, not a weapon, or a tool. Even now I tend to still conflate the two with the Nocturnal Arms." },
				{ Cue = "/VO/Medea_0228",
					PreLineAnim = "Medea_Sprinkle",
					Text = "The Arms are known by many different names, and I suspect don't care which ones you choose. They lust for {#Emph}souls{#Prev}, not proper etiquette. So do indulge that one for me." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0190",
					Text = "That artifact that you bear... Revaal herself! But in the guise of whomever came forth to me in dream. So then the phrase I told you took effect... what more did you unveil?" },
				{ Cue = "/VO/MelinoeField_3937", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is the Aspect of a goddess known as Hel, who presides over some distant realm of the dead that's white with frost. How she ends up bearing Revaal, I do not know." },
				{ Cue = "/VO/Medea_0191",
					PreLineAnim = "Medea_Scoff",
					Text = "This Goddess Hel apparently has taste! Perhaps it shall be {#Emph}I {#Prev}who, on some frigid evening, first shall introduce her to the intoxicating power of the Argent Skull...! Or perhaps {#Emph}you!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaGrantsHiddenAspect01 =
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
						HasAll = { "LobCloseAttackAspect", "LobImpulseAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "LobCloseAttackAspect5", "LobImpulseAspect5" },
					},
					NamedRequirementsFalse =
					{
						"StaffHiddenAspectRevealInProgress",
						"DaggerHiddenAspectRevealInProgress",
						"TorchHiddenAspectRevealInProgress",
						"AxeHiddenAspectRevealInProgress",
						-- "LobHiddenAspectRevealInProgress",
						"SuitHiddenAspectRevealInProgress"
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0185",
					Text = "How the dead are drawn to you, sorceress; I've seen it plain! Even the Skull of Revaal must worship the ground beneath your feet! I dreamt of her quite recently, in fact..." },
				{ Cue = "/VO/MelinoeField_3498", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of all the Nocturnal Arms, Revaal's connection to the dead perhaps is the strongest. What happened in the dream?" },
				{ Cue = "/VO/Medea_0186",
					PreLineAnim = "Medea_Scoff",
					Text = "It sent a shiver down my spine. I was in the Underworld, yet not the one we know! It was so very cold... and there sat a fierce Queen; not your mother, mind you. And she intoned, {#Emph}I see you gather countless dead in cold and dark domains." },
				{ Cue = "/VO/MelinoeField_3499", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}I see you gather countless dead in cold and dark domains. {#Prev}She must have given you a waking-phrase! Did she believe you still to be the bearer of the Argent Skull? " },
				{ Cue = "/VO/Medea_0187",
					PreLineAnim = "Medea_Casting_Start",
					PostLineAnim = "Medea_Casting_End",
					Text = "I doubt that... because it's {#Emph}you {#Prev}we saw bearing the Skull, not {#Emph}I. {#Prev}My time with her for now has passed. Yours, it seems, may be only beginning..." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Lob" },
				},
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutHiddenAspectProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHiddenAspect01" },
					},
					NamedRequirements = { "LobHiddenAspectRevealInProgress" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0188",
					Text = "Concerning my dream of the skull Revaal... have you yet made attempts using the invocation I relayed?" },
				{ Cue = "/VO/MelinoeField_3946", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I haven't, Lady Medea... I'm reluctant to speak it before the Silver Pool until I'm certain what effect it may induce." },
				{ Cue = "/VO/Medea_0189",
					PreLineAnim = "Medea_Salute",
					Text = "Courage, sorceress. Experiments require willingness toward unforeseen outcomes. Remember now to say, {#Emph}I see you gather countless dead in cold and dark domains. {#Prev}It should be fine!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutPylons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/MelinoeField_3811", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What are these Pylons doing everywhere, Lady Medea? They control the barrier before the docks, that much is clear. Perhaps the Titan's legions use them to coordinate attacks." },

				{ Cue = "/VO/Medea_0231",
					PreLineAnim = "Medea_Scoff",
					Text = "They are the product of a very sick mind. Imprisoning so many Shades in the tiniest enclosures wherein all their Psyche may be drained! Can you imagine, sorceress?" },

				{ Cue = "/VO/MelinoeField_3812", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's terrible! I hadn't realized the Pylons worked that way. Though who keeps fixing them? You even have one {#Emph}here!" },
					
				{ Cue = "/VO/Medea_0232",
					PreLineAnim = "Medea_Greet",
					Text = "The hideous thing won't seem to go {#Emph}away! {#Prev}Keeps re-materializing practically each night! Though I get so caught up with all my cauldronwork, I seldom pay it any heed..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutConcoctionQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "H_Intro" },
						Comparison = ">=",
						Value = 5,
					},
					{
						SumPrevRuns = 5,
						Path = { "RoomsEntered", "H_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PolyphemusAboutAltFight01", "PolyphemusAboutAltFight01_B" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0268",
					Text = "Great Hecate informs me you have regularly crossed the Mourning Fields. There's something I would ask, as much as it pains me; for a concoction I've been dying to complete." },

				{ Cue = "/VO/MelinoeField_4332", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Certainly no harm in asking, Lady Medea. What is it that you seek, and to what end?" },

				{ Cue = "/VO/Medea_0269",
					PreLineAnim = "Medea_Bless",
					Text = "I need the vapor from the Tears spilled by sorry souls that linger in that place. If you could gather up some Tears, declaring them for me, then collect their boiled essence from your Cauldron, I'd be very much obliged." },

				{ Cue = "/VO/MelinoeField_4333", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "And which sort of concoction would be possible, once you possess these essences of sorrow?" },

				{ Cue = "/VO/Medea_0270",
					PreLineAnim = "Medea_Salute",
					Text = "One that shall be of no small benefit to you and I alike. You needn't go too far out of your way, of course." },

				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutConcoctionQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGiftTears01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0272",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 0.25 },

					Text = "Oh good, you're just in time. Those Tears you brought me were the missing touch I lacked for something that had been the subject of my studies for some time. I'm pleased to offer you a sample of it now, if you would like?" },

				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutAltFight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0581",
					PreLineAnim = "Medea_Salute",
					Text = "Fear nothing, sorceress, at least not from me here. Beyond the city gates, I shall be testing your resolve whenever you speak the Vows; but in this pharmacy as I call it, I merely test the potency of my concoctions and the like." },
				{ Cue = "/VO/MelinoeField_3809", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But you fought against me with such rancor, Lady Medea. If there is some bad blood between us, I would like to know the cause." },
				{ Cue = "/VO/Medea_0220",
					PreLineAnim = "Medea_Scoff",
					Text = "Perish the very thought! I merely wish for you to not let down your guard with {#Emph}anyone. {#Prev}And besides, there's no bad blood for those of {#Emph}our {#Prev}predilection. All blood has its uses." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutAltFight02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss02" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0221",
					Text = "The will of Night is calling to me once again... how {#Emph}sickening{#Prev}, that I'm to curse our enemies, only to stand within their ranks alongside that dread Cyclops but a little while hence!" },
				{ Cue = "/VO/MelinoeField_3810", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "These curses that you offer me may negatively impact {#Emph}him... {#Prev}but I suppose not you. Although, isn't it quite common for curses to backfire?" },
				{ Cue = "/VO/Medea_0222",
					PreLineAnim = "Medea_Scoff",
					Text = "The curses of an amateur, most certainly, but {#Emph}mine? Hmhmhmhmhmhm{#Prev}, no. Well, this shall be highly instructional at least! Until we see each other soon beyond the gates." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutAltFight03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss02" },
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
					{
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0223",
					Text = "What are the matters of dispute between that Cyclops Polyphemus and yourself, anyhow, sorceress? I get a bit of thrill seeing you fight, but would prefer to know the history." },
				{ Cue = "/VO/MelinoeField_3933", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "There is no history! The first night I tried to leave the city, he was there. He's tried to make a meal of me since. He must be working for Chronos... or was, at some point." },
				{ Cue = "/VO/Medea_0224",
					PreLineAnim = "Medea_Scoff",
					Text = "He's just a shepherd. Perhaps you met him on an empty stomach, that can make anybody irritable. But, do as you must! I'll intervene only if the Oath requires it." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaAboutAltFight04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss02" },
					},
					{
						PathTrue = { "GameState", "LastBossDifficultyRecord", "Polyphemus" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = "<",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0225",
					Text = "Decided to revoke the Vow of Rivals for the time? I do not blame you in the least. As exhilarating as it is for me, I appreciate the undivided silence here." },
				{ Cue = "/VO/MelinoeField_3934", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Polyphemus must miss your company. I'm still surprised the two of you seem to get on so well... I can't imagine what you have in common." },
				{ Cue = "/VO/Medea_0226",
					PreLineAnim = "Medea_Scoff",
					Text = "No, I don't think you can... but, he need not see me constantly. He is a shepherd thus a rather patient sort. You'll likely speak the Vow again, and we shall all {#Emph}catch up." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaLowHealth01 =
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
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearching,

				{ Cue = "/VO/Medea_0183",
					Text = "Forgive my gawking, sorceress, but you've clearly suffered on your way... might I perhaps take a quick sample of your blood?" },
				{ Cue = "/VO/MelinoeField_3947", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No thank you, Lady Medea. My night is off to a wretched enough start. As long as I can salvage it somehow." },
				{ Cue = "/VO/Medea_0184",
					PreLineAnim = "Medea_Scoff",
					Text = "Well suit yourself. And if it makes you feel any better, our enemies soon shall accrue far worse ailments." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaAboutExperiments01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaAboutConcoctionQuestComplete01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0236",
					Text = "Most practitioners of our craft would have condemned my experimentation, or turned their noses at the very least. But not you, sorceress. I laud your intestinal fortitude." },

				{ Cue = "/VO/MelinoeField_3940", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your experimentation as you call it is not for me to judge. That would make me no different than so many others who misunderstand the nature of what we do." },

				{ Cue = "/VO/Medea_0237",
					PreLineAnim = "Medea_Greet",
					Text = "I must admit I do enjoy how next to no one even dares approach us out of fear that we lash out. Perhaps not for the best, long-term, but as for now? I can experiment in peace. Though you at least are always welcome here." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaPostTrueEnding01 =
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
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0243",
					PreLineAnim = "Medea_Bless",
					Text = "Great Hecate herself was generous enough to notify me of your latest exploits, sorceress. And I wouldn't have believed a word of it had I been told by {#Emph}any {#Prev}other being save for her. So then, the Titan Lord has truly been de-fanged?" },

				{ Cue = "/VO/MelinoeField_4229", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So it seems, Lady Medea. And the monstrosity that loomed over Olympus is gone, too. Some traces of both threats remain, but we think we can handle them." },

				{ Cue = "/VO/Medea_0244",
					PreLineAnim = "Medea_Greet",
					Text = "You apparently can handle {#Emph}anything. {#Prev}My only fear is that this means we may not see each other quite as often as we have, and... shall I be forced to leave Ephyra soon? So that mortals may then rob this city of its character..." },

				{ Cue = "/VO/MelinoeField_4230", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That won't be an immediate concern. The Underworld will not go back to how it used to be for quite some time; the dead shall have to wallow for a while longer." },

				{ Cue = "/VO/Medea_0245",
					PreLineAnim = "Medea_Scoff",
					Text = "{#Emph}Oh{#Prev}, how {#Emph}utterly terrible! {#Prev}But only for the dead. As for me personally, why... {#Emph}I {#Prev}don't even know whom to {#Emph}curse!" },

				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			MedeaPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaPostTrueEnding01", "MedeaGift08" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaWitchcraft,

				{ Cue = "/VO/Medea_0599",
					Text = "Great Hecate still hasn't told me how exactly you managed to induce within the Titan Lord a reawakening of sorts. No mere curse, that... so much she has yet to teach me." },

				{ Cue = "/VO/MelinoeField_4723", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}The greatest teacher is out there{#Prev}, she always says, though, right? But, I feel the same way. For as long as I've known Headmistress, there's so much to her that I can't even begin to understand." },

				{ Cue = "/VO/Medea_0600",
					PreLineAnim = "Medea_Salute",
					Text = "We dwell in shadows; so it must be. But I take comfort knowing if ever I truly felt alone, in the crippling, pathetic way mortals refer to their abandonment... then I can always call on her, or you." },

				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},

			-- home events
			MedeaHubFirstMeeting01 =
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMarket" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_Story01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "TrueEndingFinale01" },
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
					-- PreLineAnim = "Medea_Greet",
					-- PreLineAnim = "Medea_Salute",
					-- PreLineAnim = "Medea_Bless",
					-- PreLineAnim = "Medea_Scoff",
					-- PreLineAnim = "Medea_Sprinkle",
					-- PreLineAnim = "Medea_Casting_Start",
					-- PostLineAnim = "Medea_Casting_End",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Medea_Scoff", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "So many more Shades of the dead now linger here! And the earthy aroma, quite unlike before. These Crossroads changed since last I visited!" },
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

			-- repeatable
			MedeaChat01 =
			{
				UseableOffSource = true,
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
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0025",
					Text = "I've several more unspeakable transgressions against nature here for you." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat23 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0174",
					Text = "The more hatred we harbor for our enemies, the stronger our curses shall become." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat24 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0175",
					Text = "You may have blessings from the gods above, but I can offer something they cannot." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat25 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MedeaGift04" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0176",
					Text = "Great Hecate has taught you well, but if someone so much as touches you, I'll make them suffer." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat26 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0177",
					Text = "The air is {#Emph}absolutely {#Prev}putrid this eve; I almost didn't hear you come in, sorceress!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat27 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0564",
					Text = "The dead shall long for the comfort of their graves once {#Emph}we {#Prev}are through with them." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat28 =
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
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0565",
					Text = "The Moon isn't bright, the night is cold, the dead are writhing in the Earth; I've no complaints!" },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat29 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", },
						HasAny = { "WetState" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0566",
					Text = "The pouring rain is bad for my concoctions though does provide a certain wretchedness." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat30 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 20,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0567",
					Text = "What an {#Emph}absolutely {#Prev}dreadful night! I scarce imagine how conditions for my work could be improved." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat31 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0568",
					Text = "My little pharmacy has limited supply, for I only offer the freshest of ingredients..." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
			MedeaChat32 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.MedeaResearchingRepeatable,

				{ Cue = "/VO/Medea_0569",
					Text = "Do watch your back out there lest someone give it a good stabbing, sorceress." },
				PrePortraitExitFunctionName = "MedeaCurseChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.MedeaCurseChoices,
			},
		},

		GiftTextLineSets =
		{
			MedeaGiftTears01 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				Cost =
				{
					MedeaPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMedeaTears" },
					},
				},
				{ Cue = "/VO/MelinoeField_4338", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This should be what you sought: one vial of vaporized Tears from the Mourning Fields. May you use it well." },

				{ Cue = "/VO/Medea_0271",
					Text = "{#Emph}Oh{#Prev}, this is it! To think of all the sorrow concentrated here. I shall be working with this very soon. Thank you {#Emph}so {#Prev}much!" },

				EndEvents =
				{
					{
						Threaded = true,
						FunctionName = "WitchPostSpellPresentation",
						Args =
						{
							Animation = "Medea_Bless",
						},
					},
				},
			},

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
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
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
				UnfilledIcon = "EmptyHeartWithProphecyIcon",
				FilledIcon = "FilledHeartWithProphecyIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
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
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
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
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Medea_0059",
					Text = "The gods of Olympus have not always been particularly kind. Yet you, a true-blood relative of theirs, would show me favor for little more than carrying out my oath to Great Hecate? Unnecessary, this; I've only curses in return." },
				{ Cue = "/VO/Melinoe_3302", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're so much more than your curses, Lady Medea. Perhaps the gods of Olympus and the dead never told you so, but I believe it's true." },
			},
			MedeaGift05 =
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
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Medea_0233",
					Text = "Keep sweetening this atmosphere and it may start to undermine my craft...! I cannot stand over my cauldron thinking all these pleasant thoughts. Imagine the result!" },
				{ Cue = "/VO/MelinoeField_3938", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I certainly can. You're one of the greatest practitioners of our craft I have ever known. The depth of your ability is beyond compare, and surely its breadth is boundless too." },
			},
			MedeaGift06 =
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
					{
						Path = { "GameState", "RoomsEntered", "N_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Medea_0234",
					Text = "Repeated acts of kindness tend to rouse my innermost suspicions or my wrath, but in your case... what little ulterior motive I detect seems more or less benign. And now I've more than enough Nectar for my purposes, thank you." },
				{ Cue = "/VO/MelinoeField_3939", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're most welcome. I've likewise always needed to be guarded, as our enemies abound. So when I come to trust someone, I want them to know it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						ObjectType = "NPC_Medea_01",
						{ Cue = "/VO/Medea_0235", Text = "...I do appreciate the thought." },
					},
				},
			},
			MedeaGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_MedeaUnlockHint01",
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
						HasAll = { "MedeaGift06", "MedeaAboutConcoctionQuestComplete01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3941", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For your devotion to our cause, Lady Medea! You may have all the Nectar you require, but I'd like you to have this, too. Though it may not be suitable for your concoctions." },

				{ Cue = "/VO/Medea_0238",
					PreLineAnim = "Medea_Scoff",
					Text = "You would regard me as some goddess from on high, with such a precious gift. If you but knew me better, you'd rescind the offer on the spot. This is unnecessary, sorceress; as you observed, I cannot use it anyway." },

				{ Cue = "/VO/MelinoeField_3942", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You could enjoy it...? Perhaps with me or someone else. Or simply keep it." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Medea_01",
						{ Cue = "/VO/Medea_0239", Text = "Perhaps... yes, thank you." },
					},
				},
			},
			-- bond forged
			MedeaGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_MedeaGiftHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedMedea",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MedeaGift07" },
					},
				},
				{ Cue = "/VO/MelinoeField_3943", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Since Ambrosia can be so good as to leave you desiring more, I wanted you to have this. For being quite possibly the most welcome sight in all Ephyra." },

				{ Cue = "/VO/Medea_0240",
					PreLineAnim = "Medea_Scoff",
					Text = "To have been blessed by one such as you, after having cursed so very many, however much they had it coming... I've merely done my service to Great Hecate in working with you, sorceress. You need not compensate me more." },

				{ Cue = "/VO/MelinoeField_3944", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It isn't compensation, merely a gift. Your past is your business; I know only the Lady Medea whom I've met and come to understand. She is so much the sorceress I've aspired to be... with less emphasis on cursing, but still." },

				{ Cue = "/VO/Medea_0241",
					PreLineAnim = "Medea_Greet",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Medea_01", Icon = "Keepsake_Medea" },

					Text = "You were so young when first we met... I thought as you grew older, you would harden, grow crueler, as many of us do. Yet you have proven quite resistant, and in turn... you've made me more resistant to it, too. I'm most grateful." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_3945", Text = "You're most welcome." },
					},
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

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Medea_01",
			SkipCooldownCheckIfNonePlayed = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee", "ShadeMercSpiritball" },
				},
			},
			Cooldowns =
			{
				{ Name = "MedeaSpokeRecently", Time = 10 },
			},

			{ Cue = "/VO/Medea_0092", Text = "Some other time." },
			{ Cue = "/VO/Medea_0093", Text = "Stay your hand." },
			{ Cue = "/VO/Medea_0094", Text = "We really shouldn't here." },
			{ Cue = "/VO/Medea_0097", Text = "Oh, not now.", PlayFirst = true },
			{ Cue = "/VO/Medea_0514", Text = "You cannot pierce the veil." },
			{ Cue = "/VO/Medea_0515", Text = "These are good wards." },
			{ Cue = "/VO/Medea_0516", Text = "Stay your hand!" },
			{ Cue = "/VO/Medea_0517", Text = "Now, now..." },
			{ Cue = "/VO/Medea_0378", Text = "What did {#Emph}I {#Prev}do?" },
		},
	},
}

-- Global Medea Lines
GlobalVoiceLines.MedeaGreetingLines =
{
	Queue = "Interrupt",
	{
		Queue = "Interrupt",
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Medea_0242", Text = "I salute your great achievement." },
	},
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Medea_0067", Text = "Sorceress!" },
		{ Cue = "/VO/Medea_0068", Text = "Peace, sorceress." },
		{ Cue = "/VO/Medea_0069", Text = "Oh...!" },
		{ Cue = "/VO/Medea_0070", Text = "{#Emph}Ah{#Prev}, welcome." },
		{ Cue = "/VO/Medea_0071", Text = "Good evening!" },
		{ Cue = "/VO/Medea_0072", Text = "Returned to my abode." },
		{ Cue = "/VO/Medea_0073", Text = "A visitor!" },
		{ Cue = "/VO/Medea_0074", Text = "She returns." },
		{ Cue = "/VO/Medea_0075", Text = "By the dark...!", PlayFirst = true },
		{ Cue = "/VO/Medea_0076", Text = "Come closer..." },
		{ Cue = "/VO/Medea_0077", Text = "Fear not..." },
		{ Cue = "/VO/Medea_0078", Text = "You're back." },
		{ Cue = "/VO/Medea_0534", Text = "Welcome to my pharmacy." },
		{ Cue = "/VO/Medea_0535", Text = "Well, if it isn't {#Emph}you." },
		{ Cue = "/VO/Medea_0536", Text = "Hail." },
		{ Cue = "/VO/Medea_0537", Text = "Hail, sorceress." },
		{ Cue = "/VO/Medea_0532", Text = "Not seen {#Emph}you {#Prev}in a bit!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "MedeaGift03" }
				},
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
					Path = { "RoomsEntered", "N_Story01" },
					Comparison = "<=",
					Value = 0,
				},
			},
		},
		{ Cue = "/VO/Medea_0533", Text = "It's been too long!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "MedeaGift03" }
				},
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
 					Path = { "RoomsEntered", "N_Story01" },
					Comparison = "<=",
					Value = 0,
				},
			},
		},
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		UsePlayerSource = true,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},
		{ Cue = "/VO/Melinoe_3296", Text = "Lady Medea..." },
		{ Cue = "/VO/Melinoe_3297", Text = "The Sorceress...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
					HasNone = { "/VO/Medea_0067", "/VO/Medea_0068" },
				},
			}
		},
		{ Cue = "/VO/Melinoe_3298", Text = "Greetings, Witch.", PlayFirst = true },
	},
}

GlobalVoiceLines.MedeaCauldronLines =
{
	{
		PreLineWait = 1.1,
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},

		{ Cue = "/VO/Medea_0120", Text = "...bone dust...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0121", Text = "...mandrake essence...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0122", Text = "...nightshade...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0123", Text = "...nettle-thorn...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0124", Text = "...sulfurous ash...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0125", Text = "...garlic...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0126", Text = "...moly...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0127", Text = "...a bit of flesh...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0128", Text = "...a drop of blood...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0129", Text = "...beetle-wing...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0130", Text = "...maggot...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0131", Text = "...dead coral...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0132", Text = "...air-bladder...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0133", Text = "...rotting wood...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0134", Text = "...barley...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0135", Text = "...splash of oil...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0136", Text = "...pennyroyal...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0137", Text = "...marrow...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0138", Text = "...silver...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0139", Text = "...onion...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0140", Text = "...grave-soil...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0141", Text = "...snakeskin...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0142", Text = "...tear-drops...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0143", Text = "...lizard tail...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0144", Text = "...charcoal...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0145", Text = "...fingernails...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0482", Text = "...serpent fang...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0483", Text = "...mutton...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0484", Text = "...a tuft of wool...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0485", Text = "...sea-water...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0486", Text = "...one deathcap...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0487", Text = "...hemlock...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0488", Text = "...spider-silk...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0489", Text = "...moltings...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0490", Text = "...psyche...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0491", Text = "...yew flower...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0492", Text = "...the old special...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0493", Text = "...tear-salt...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0494", Text = "...vermin dung...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0495", Text = "...an eyelash...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0496", Text = "...one of his hairs...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0497", Text = "...driftwood...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0498", Text = "...just a pinch...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0501", Text = "...whatever {#Emph}this {#Prev}is...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0502", Text = "...this old thing...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0146", Text = "...one of these...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0147", Text = "...a bit of this...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0148", Text = "...just a dash...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0149", Text = "...give it a stir...",
			PreLineAnim = "Medea_Sprinkle",
		},
		{ Cue = "/VO/Medea_0150", Text = "...{#Emph}Mmm{#Prev}, let's see..." },
		{ Cue = "/VO/Medea_0151", Text = "...what else..." },
		{ Cue = "/VO/Medea_0499", Text = "...let it soak..." },
		{ Cue = "/VO/Medea_0500", Text = "...a certain thought..." },
		{ Cue = "/VO/Medea_0503", Text = "...anything more...?" },
		{ Cue = "/VO/Medea_0504", Text = "...oh, also..." },
		{ Cue = "/VO/Medea_0505", Text = "...{#Emph}and..." },
	},
}
GlobalVoiceLines.MedeaCauldronWrapUpLines =
{
	{
		PreLineWait = 0.66,
		RandomRemaining = true,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Medea_Bless",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		
		{ Cue = "/VO/Medea_0152", Text = "...and, there." },
		{ Cue = "/VO/Medea_0153", Text = "...and now we wait..." },
		{ Cue = "/VO/Medea_0154", Text = "...that should do it.", PreLineWait = 1.0 },
		{ Cue = "/VO/Medea_0155", Text = "...and, that's it...!" },
		{ Cue = "/VO/Medea_0506", Text = "...and nothing more." },
		{ Cue = "/VO/Medea_0507", Text = "...naught else." },
		{ Cue = "/VO/Medea_0508", Text = "...and it is done." },
		{ Cue = "/VO/Medea_0509", Text = "...so mote it be...!" },
	},
}
GlobalVoiceLines.MedeaIncantationLines =
{
	RandomRemaining = true,
	-- SuccessiveChanceToPlay = 0.5,
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Medea_Bless",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		TriggerCooldowns = { "MedeaIncantationSpeech" },
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0156", Text = "{#Emph}O wand'ring dead who cannot find your peace,", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0157", Text = "{#Emph}I bid you listen closely to my voice." },
		{ Cue = "/VO/Medea_0158", Text = "{#Emph}The moment at which mortal life does cease" },
		{ Cue = "/VO/Medea_0159", Text = "{#Emph}Is not for your despair, but to rejoice!" },
		{ Cue = "/VO/Medea_0160", Text = "{#Emph}For I can lead you to where you belong," },
		{ Cue = "/VO/Medea_0161", Text = "{#Emph}Beneath the earth where Death and Sleep reside," },
		{ Cue = "/VO/Medea_0162", Text = "{#Emph}I bid you merely serve me for a song," },
		{ Cue = "/VO/Medea_0163", Text = "{#Emph}Unto the will of the Unseen, confide." },
		{ Cue = "/VO/Medea_0164", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Medea_Bless",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		TriggerCooldowns = { "MedeaIncantationSpeech" },
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0165", Text = "{#Emph}To all the enemies of Hades, near and far,", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0166", Text = "{#Emph}May ravens strip you of your flesh and eyes," },
		{ Cue = "/VO/Medea_0167", Text = "{#Emph}All your extremities sent to a pickle-jar," },
		{ Cue = "/VO/Medea_0168", Text = "{#Emph}And beetles spit up from your mouths of lies." },
		{ Cue = "/VO/Medea_0169", Text = "{#Emph}Whether you dwell upon the surface or below," },
		{ Cue = "/VO/Medea_0170", Text = "{#Emph}Your every step shall be with stabbing pain." },
		{ Cue = "/VO/Medea_0171", Text = "{#Emph}No peace or mercy you shall ever know," },
		{ Cue = "/VO/Medea_0172", Text = "{#Emph}Ere you repent, and die and die again." },
		{ Cue = "/VO/Medea_0173", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Medea_Bless",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		TriggerCooldowns = { "MedeaIncantationSpeech" },
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0464", Text = "{#Emph}For those who showed me scorn, I show you this:", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0465", Text = "{#Emph}A boiling cauldron filled with toxic herbs," },
		{ Cue = "/VO/Medea_0466", Text = "{#Emph}Envenomed fangs, and thistles, and a kiss," },
		{ Cue = "/VO/Medea_0467", Text = "{#Emph}And awful expletives and gruesome verbs." },
		{ Cue = "/VO/Medea_0468", Text = "{#Emph}May all your hair fall out and your skin crawl" },
		{ Cue = "/VO/Medea_0469", Text = "{#Emph}With many painful sores and insect bites;" },
		{ Cue = "/VO/Medea_0470", Text = "{#Emph}Your favored memories I shall enthrall," },
		{ Cue = "/VO/Medea_0471", Text = "{#Emph}Your throat I'll cut, but first, complete these rites." },
		{ Cue = "/VO/Medea_0472", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
	{
		PreLineWait = 0.5,
		ObjectType = "NPC_Medea_01",
		-- SubtitleMinDistance = 1200,
		--Actor = "DadOcclusion",
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Medea_Bless",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "MedeaInterrupt" },
			},
		},
		TriggerCooldowns = { "MedeaIncantationSpeech" },
		RecheckRequirementsForSubLines = true,

		{ Cue = "/VO/Medea_0473", Text = "{#Emph}Great Hecate, I celebrate your ways,", PreLineWait = 1.6 },
		{ Cue = "/VO/Medea_0474", Text = "{#Emph}You light my passage through the dark of night," },
		{ Cue = "/VO/Medea_0475", Text = "{#Emph}I first encountered you whilst in a haze" },
		{ Cue = "/VO/Medea_0476", Text = "{#Emph}And you returned to me my will to fight." },
		{ Cue = "/VO/Medea_0477", Text = "{#Emph}I shall devote myself to what you teach," },
		{ Cue = "/VO/Medea_0478", Text = "{#Emph}Though I have my own methods I employ," },
		{ Cue = "/VO/Medea_0479", Text = "{#Emph}Your wisdom ever is beyond my reach," },
		{ Cue = "/VO/Medea_0480", Text = "{#Emph}You need but give me something to destroy." },
		{ Cue = "/VO/Medea_0481", Text = "{#Emph}...So mote it be.", PreLineWait = 1.2, BreakIfPlayed = true },
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Medea =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Medea_01",
		PreLineAnim = "Medea_Bless",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/Medea_0079", Text = "That they shall feel." },
		{ Cue = "/VO/Medea_0080", Text = "A curse upon them all." },
		{ Cue = "/VO/Medea_0081", Text = "Oh I like that one." },
		{ Cue = "/VO/Medea_0082", Text = "As you desire." },
		{ Cue = "/VO/Medea_0083", Text = "I thought you'd never ask." },
		{ Cue = "/VO/Medea_0084", Text = "So it shall be." },
		{ Cue = "/VO/Medea_0085", Text = "Most excellent...!" },
		{ Cue = "/VO/Medea_0086", Text = "It shall be my pleasure." },
		{ Cue = "/VO/Medea_0087", Text = "...There you have it." },
		{ Cue = "/VO/Medea_0090", Text = "{#Emph}Kataskion aski!" },
		{ Cue = "/VO/Medea_0091", Text = "{#Emph}Askion kataski!" },
		{ Cue = "/VO/Medea_0538", Text = "Perfect..." },
		{ Cue = "/VO/Medea_0539", Text = "A discerning choice." },
		{ Cue = "/VO/Medea_0540", Text = "If it pleases you..." },
		{ Cue = "/VO/Medea_0541", Text = "May it take you far..." },
		{ Cue = "/VO/Medea_0542", Text = "Take one of these..." },
		{ Cue = "/VO/Medea_0543", Text = "Should be no side effects..." },
		{ Cue = "/VO/Medea_0544", Text = "Pleased to oblige." },
		{ Cue = "/VO/Medea_0545", Text = "Of course!" },
		{ Cue = "/VO/Medea_0546", Text = "As above, so below." },
		{ Cue = "/VO/Medea_0547", Text = "Do enjoy..." },
		{ Cue = "/VO/Medea_0088", Text = "So mote it be.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
				},
			},
		},
		{ Cue = "/VO/Medea_0089", Text = "So mote it be...!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.15,
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/MelinoeField_0255", Text = "I'm grateful, milady." },
		{ Cue = "/VO/MelinoeField_0256", Text = "Night protect us...", PlayFirst = true },
	},
	{ GlobalVoiceLines = "ThankingCharacterVoiceLines" },
	-- { GlobalVoiceLines = "MedeaIncantationLines" },
}

GlobalVoiceLines.MedeaGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectTypes = { "NPC_Medea_01", "Medea" },
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 12 },
			{ Name = "CyclopsSpokeRecently", Time = 10 },
		},

		{ Cue = "/VO/Medea_0301", Text = "The Earth provides..." },
		{ Cue = "/VO/Medea_0302", Text = "Fresh reagents..." },
		{ Cue = "/VO/Medea_0303", Text = "I had my eye on that..." },
		{ Cue = "/VO/Medea_0304", Text = "What did you find?" },
		{ Cue = "/VO/Medea_0305", Text = "Keen eye...!" },
		{ Cue = "/VO/Medea_0306", Text = "I {#Emph}saw {#Prev}that...!" },
		{ Cue = "/VO/Medea_0307", Text = "Help yourself..." },
		{ Cue = "/VO/Medea_0308", Text = "Raw materials..." },
	},
}
GlobalVoiceLines.MedeaExorcismReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectTypes = { "NPC_Medea_01", "Medea" },
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "MedeaSpokeRecently", Time = 12 },
		},

		{ Cue = "/VO/Medea_0331", Text = "Fine bit of necromancy...", PlayFirst = true },
		{ Cue = "/VO/Medea_0332", Text = "The dead adore you." },
		{ Cue = "/VO/Medea_0333", Text = "How very fortunate..." },
		{ Cue = "/VO/Medea_0334", Text = "A willing subject..." },
		{ Cue = "/VO/Medea_0335", Text = "You are a natural..." },
		{ Cue = "/VO/Medea_0336", Text = "So many souls remain..." },
	},
}

GlobalVoiceLines.MedeaPlagueVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PlayOnceFromTableThisRun = true,
	PlayOnceContext = "MedeaCombatCastingVO",
	PreLineWait = 0.05,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "Medea",
	TriggerCooldowns = { "MedeaSpokeRecently" },

	{ Cue = "/VO/Medea_0456", Text = "May putrescence spread...!" },
	{ Cue = "/VO/Medea_0457", Text = "Hold your breath...!" },
	{ Cue = "/VO/Medea_0458", Text = "Don't even breathe..." },
	{ Cue = "/VO/Medea_0459", Text = "The Earth is diseased..." },
	{ Cue = "/VO/Medea_0460", Text = "The air is poisonous..." },
	{ Cue = "/VO/Medea_0461", Text = "{#Emph}Venom and bile..." },
	{ Cue = "/VO/Medea_0462", Text = "{#Emph}Kataskion aski!" },
	{ Cue = "/VO/Medea_0463", Text = "{#Emph}Askion kataski!" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Medea )