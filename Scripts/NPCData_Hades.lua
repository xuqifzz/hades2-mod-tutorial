UnitSetData.NPC_Hades =
{
	-- Hades
	NPC_Hades_Field_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Hades_Chained_01",
		AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SubtitleColor = Color.HadesVoice,
		RequiredRoomInteraction = true,
		TreatAsGodLootByShops = true,
		ExcludeFromLastRunBoon = true,
		BlockForceCommon = true,
		BlockDoubleBoon = true,
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs = { SkipInteractAnim = true, SkipSound = true, PackageName = "NPC_Hades_Field_01" },
		SpeakerName = "Hades",
		LightingColor = { 242, 49, 46, 255 },
		LootColor = { 242, 49, 46, 255 },
		UpgradeScreenOpenSound = "/SFX/Enemy Sounds/Hades/HadesSummonPresentation",
		UpgradeSelectedSound = "/SFX/Enemy Sounds/Hades/Hades360Swipe",
		MenuTitle = "UpgradeChoiceMenu_Hades",
		PriorityUpgrades = { },
		WeaponUpgrades = { },
		-- if this gets updated, please also update ChronosBossAboutHades02 =
		Traits = { "HadesLifestealBoon", "HadesCastProjectileBoon", "HadesPreDamageBoon", "HadesChronosDebuffBoon", "HadesInvisibilityRetaliateBoon", "HadesDeathDefianceDamageBoon" },
		PackageName = "NPC_Hades_Field_01",
		Consumables = { },

		RarityChances =
		{
			Common = 1
		},
		RarityRollOrder = { "Common", "Heroic" },

		FlavorTextIds =
		{
			"HadesUpgrade_FlavorText01",
			"HadesUpgrade_FlavorText02",
			"HadesUpgrade_FlavorText03",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Always",
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HadesAboutChronosNightmare01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1570", Text = "We've every chance in the world..." },
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
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

				{ Cue = "/VO/MelinoeField_1566", Text = "Be well, Lord Father." },
				{ Cue = "/VO/MelinoeField_1567", Text = "In shadow, I serve!" },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				PreLineAnim = "Hades_Hello",
				ObjectType = "NPC_Hades_Field_01",

				{ Cue = "/VO/Hades_0127", Text = "{#Emph}Hrn.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1566", "/VO/MelinoeField_1566" },
						},
					},
				},
				{ Cue = "/VO/Hades_0131", Text = "Oh, Daughter...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1566", "/VO/MelinoeField_1566" },
						},
					},
				},
				{ Cue = "/VO/Hades_0128", Text = "Greetings...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Hades_0129", Text = "We tried that once.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Hades_0130", Text = "Death...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Hades_0132", Text = "Not here it won't.", Text = "Death...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Hades_0133", Text = "Here?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Hades_0134", Text = "As you say.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703", "/VO/Melinoe_1705" },
						},
					},
				},
				{ Cue = "/VO/Hades_0135", Text = "Hail...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Hades_0136", Text = "To shadow, you'll return.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1567" },
						},
					},
				},
				
			},
		},

		InteractTextLineSets =
		{
			-- not yet found Chronos
			HadesFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesFirstMeeting_B", "HadesFirstMeeting_C" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0049", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Pah! {#Prev}Another tormentor come to break me, or to try. And such a frail one, at that. Has the Titan Lord a lack for decent help?" },
				{ Cue = "/VO/Melinoe_1056", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You... are you... the master of this beast?" },
				{ Cue = "/VO/Hades_0026", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					EndSound = "/VO/CerberusBarks",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "{#Emph}The master of this beast? Ha, haha! {#Prev}Well, if I'm to be remembered, I could think of far worse ways than that. Though, this {#Emph}beast {#Prev}has yet to so much as snarl at you..." },
				{ Cue = "/VO/Melinoe_1057_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "{#Emph}<Gasp> {#Prev}Lord Hades, you're my.... Father, I'm... Melinoë. I'm your daughter." },
				{ Cue = "/VO/Hades_0027",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Hades_Hello",
					Text = "...My daughter. Melinoë? Merciful Fates...! You cannot be here. He shall find you. He'll find you, and..." },
				{ Cue = "/VO/Melinoe_1058", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I'll slay him where he stands. Where is he?" },
				{ Cue = "/VO/Hades_0028",
					PreLineAnim = "Hades_Brooding",
					Text = "He's in my blasted House! Where you were meant to be, and I. Look at me, Daughter. I could not confront him on my own. What do you expect shall happen?" },
				{ Cue = "/VO/Melinoe_1059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I expect he'll underestimate me. Father, let me free you from these bonds!" },
				{ Cue = "/VO/Hades_0029",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}No! {#Prev}No, that would bring greater ruin, nothing more. Now, get out of this place. Though let me lend to you what strength I still possess." },
			},
			-- found but not vanquished Chronos
			HadesFirstMeeting_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesFirstMeeting", "HadesFirstMeeting_C" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0049", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Pah! {#Prev}Another tormentor come to break me, or to try. And such a frail one, at that. Has the Titan Lord a lack for decent help?" },
				{ Cue = "/VO/Melinoe_1056", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You... are you... the master of this beast?" },
				{ Cue = "/VO/Hades_0026", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					EndSound = "/VO/CerberusBarks",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "{#Emph}The master of this beast? Ha, haha! {#Prev}Well, if I'm to be remembered, I could think of far worse ways than that. Though, this {#Emph}beast {#Prev}has yet to so much as snarl at you..." },
				{ Cue = "/VO/Melinoe_1057_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "{#Emph}<Gasp> {#Prev}Lord Hades, you're my.... Father, I'm... Melinoë. I'm your daughter." },
				{ Cue = "/VO/Hades_0027",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Hades_Hello",
					Text = "...My daughter. Melinoë. Merciful Fates...! You cannot be here. He shall find you. He'll find you, and..." },
				{ Cue = "/VO/MelinoeField_1689", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I'll slay him where he stands. He's in the area, is he not?" },
				{ Cue = "/VO/Hades_0028",
					PreLineAnim = "Hades_Brooding",
					Text = "He's in my blasted House! Where you were meant to be, and I. Look at me, Daughter. I could not confront him on my own. What do you expect shall happen?" },
				{ Cue = "/VO/Melinoe_1059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I expect he'll underestimate me. Father, let me free you from these bonds!" },
				{ Cue = "/VO/Hades_0029",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}No! {#Prev}No, that would bring greater ruin, nothing more. Now, get out of this place. Though let me lend to you what strength I still possess." },
			},
			-- already vanquished Chronos
			HadesFirstMeeting_C =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesFirstMeeting", "HadesFirstMeeting_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0049", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Pah! {#Prev}Another tormentor come to break me, or to try. And such a frail one, at that. Has the Titan Lord a lack for decent help?" },
				{ Cue = "/VO/Melinoe_1056", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You... are you... the master of this beast?" },
				{ Cue = "/VO/Hades_0026", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					EndSound = "/VO/CerberusBarks",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "{#Emph}The master of this beast? Ha, haha! {#Prev}Well, if I'm to be remembered, I could think of far worse ways than that. Though, this {#Emph}beast {#Prev}has yet to so much as snarl at you..." },
				{ Cue = "/VO/Melinoe_1057_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "{#Emph}<Gasp> {#Prev}Lord Hades, you're my.... Father, I'm... Melinoë. I'm your daughter." },
				{ Cue = "/VO/Hades_0027",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Hades_Hello",
					Text = "...My daughter. Melinoë. Merciful Fates...! You cannot be here. He shall find you. He'll find you, and..." },
				{ Cue = "/VO/MelinoeField_1688", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...I'll slay him where he stands. And not for the first." },
				{ Cue = "/VO/Hades_0145",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Not for the first{#Prev}, truly? Then you must know the meaninglessness of the act! Look at me, Daughter. I could do nothing against him on my own. Even though I, too, have fought him before. {#Emph}Slain {#Prev}him before!" },
				{ Cue = "/VO/MelinoeField_1690", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm sorry, Father. But I shall not be deterred, even by you. Now let me free you from these bonds!" },
				{ Cue = "/VO/Hades_0029",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}No! {#Prev}No, that would bring greater ruin, nothing more. Now, get out of this place. Though let me lend to you what strength I still possess." },
			},

			HadesMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0031",
					PreLineAnim = "Hades_Brooding",
					Text = "What are you doing here again? I told you, you {#Emph}cannot {#Prev}be here!" },
				{ Cue = "/VO/Melinoe_1061", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I told {#Emph}you {#Prev}I'd be back for you. Though my priority is Chronos. You vanquished him before. Can you reveal to me any weaknesses? Anything at all?" },
				{ Cue = "/VO/Hades_0032",
					Text = "{#Emph}I {#Prev}vanquished him with the aid of {#Emph}five other gods! {#Prev}What hope have you, alone? He has no weakness, save his arrogance. And it appears you have that weakness, too." },
				{ Cue = "/VO/Melinoe_1062", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Then it seems we are equally matched. Father, how long have you been this way? Is there aught I can do?" },
				{ Cue = "/VO/Hades_0033",
					Text = "You think I've any sense of time in such a place? And I've said already what you can do: {#Emph}Risk not your everything. {#Prev}Go now, and be unseen." },
			},
			HadesMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0034",
					Text = "I know not how you withstood the Titan, if truly you confronted him. Quickly now, tell me but this: Have you been... are you well?" },
				{ Cue = "/VO/Melinoe_1063", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Am I... well? All my life I've been preparing for this moment, to bring the usurper of the House of Hades to justice. So, I'll have to get back to you, depending on how it goes." },
				{ Cue = "/VO/Hades_0035",
					PreLineWait = 0.35,
					PreLineAnim = "Hades_Brooding",
					Text = "...I'm sorry... I'm sorry. Get back to me if you must. I'd grant your vengeance if I could. But this is all that I can do for now." },
			},

			HadesAboutPain01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					AreIdsAlive = { 506405 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1495", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It hurts my heart to see you like this, Father. But, it brings me peace. And strength. Helps that this chamber isn't crawling with Satyrs..." },
				{ Cue = "/VO/Hades_0053",
					Text = "Oh they have sense enough to keep their distance from me... or perhaps Cerberus. Well if seeing me in this pitiable state should spur you to your fullest wrath, then so be it." },
				{ Cue = "/VO/MelinoeField_1496", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's not quite it; I don't feel loathing or hatred. Elsewhere in Tartarus, perhaps, but not here. Not anymore. I just hope my presence doesn't cause you further pain." },
				{ Cue = "/VO/Hades_0054",
					PreLineAnim = "Hades_Brooding",
					Text = "No. The only pain... is that your mother and I, your brother, this dog, that we were not... we could not be there to see you grow. Each time I see you now... it fills an absence that was there." },
			},

			HadesAboutHouse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0117",
					Text = "If you'd indulge a senseless curiosity... how fares my House? Your brother, he was more or less in charge of the decor. I highly doubt the Titan shares his taste." },
				{ Cue = "/VO/MelinoeField_1573", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, unless Zagreus was enamored of gold trim and the Titan's sneering likeness everywhere, then it's probably quite different from what you recall..." },
				{ Cue = "/VO/Hades_0118",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Urgh... {#Prev}you have your mother's candor to a fault. You ought have told me everything was {#Emph}fine! {#Prev}The comfort of lies at times is all we have." },
			},

			HadesAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
					},
					-- @ update with additional requirements
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0147",
					Text = "I cannot believe that I am asking but, how fares Olympus in all this? Even trapped within this chamber, it is evident to me that the Titan's legions are at war." },
				{ Cue = "/VO/MelinoeField_1692", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The surface swarms with the dead, and the armies of Chronos are besieging the mountain. Our family is holding them back. I've been trying to break the stalemate in their favor, but all in all, it's not a pretty sight up there right now." },
				{ Cue = "/VO/Hades_0148",
					PreLineAnim = "Hades_Hello",
					Text = "{#Emph}Not a pretty sight up there... {#Prev}you mean to say you've seen all this firsthand? {#Emph}How?" },
				{ Cue = "/VO/MelinoeField_1693", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean our birthright. Would you believe I learned a means by which I could withstand the surface climate for a while? Long enough to make a difference up there... or to try." },
				{ Cue = "/VO/Hades_0149",
					PreLineAnim = "Hades_Brooding",
					Text = "Impossible... yet seemingly, all these impossibilities continue to occur. So you must vanquish the Titan, as well as come to the rescue of Olympus. How utterly absurd that you are burdened with all that...." },
			},

			HadesAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0168",
					PreLineAnim = "Hades_Brooding",
					Text = "The darkness stirs in such a way as I've not felt since very long ago. This cannot be the Titan's work. It must be that of the Witch of the Crossroads, if not you." },
				{ Cue = "/VO/MelinoeField_2009", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Father: {#Emph}In shadow, I serve; to shadow, I return. {#Prev}Thus have I sworn the Oath of the Unseen, who serve this realm, and execute the will of Night." },
				{ Cue = "/VO/Hades_0169",
					PreLineAnim = "Hades_Hello",
					Text = "I know less of the Unseen than you suppose. As it should be, lest the Titan could have learned much more. Then, may you serve the will of Night judiciously..." },
			},

			-- about characters / about other characters
			HadesAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesFirstMeeting_C", "HadesAboutChronosBossW01_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0050",
					Text = "Such a cacophony occurred, after you last visited. Exactly when I cannot say. All of the Titan's wretched servants flew into a panic. Their cries would not cease. What transpired?" },
				{ Cue = "/VO/MelinoeField_1493", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps they were concerned for their master. Or busy trying to bring him back to life. Because I slew him, finally. And it won't be the last time." },
				{ Cue = "/VO/Hades_0051",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteSurprise",
					Text = "Blood and darkness, {#Emph}hah... urgh! {#Prev}Then you accomplished... that which once took half the blasted strength of Olympus... all on your own." },
				{ Cue = "/VO/MelinoeField_1494", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not on my own at all. I had their strength, if not their support; as you've given me yours. Father, we can stop him. And for now... we can kill him." },
				{ Cue = "/VO/Hades_0052",
					PreLineAnim = "Hades_Brooding",
					Text = "He shall seek vengeance with a renewed zeal. This entire plot of his is driven by the same impulse. Then, kill him if you must. At least... his many deaths ought keep him occupied." },
			},
			HadesAboutChronosBossW01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesFirstMeeting_C" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutChronosBossW01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0050",
					Text = "Such a cacophony occurred, after you last visited. Exactly when I cannot say. All of the Titan's wretched servants flew into a panic. Their cries would not cease. What transpired?" },
				{ Cue = "/VO/MelinoeField_1691", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps they were concerned for their master. Or busy trying to bring him back to life. Because I slew him once again. And it won't be the last time." },
				{ Cue = "/VO/Hades_0146",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteSurprise",
					Text = "Blood and darkness, {#Emph}hah! Urgh... {#Prev}To have achieved such an outcome... which once required half the blasted strength of all Olympus, on your own..." },
				{ Cue = "/VO/MelinoeField_1494", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not on my own at all. I had their strength, if not their support; as you've given me yours. Father, we can stop him. And for now... we can kill him." },
				{ Cue = "/VO/Hades_0052",
					PreLineAnim = "Hades_Brooding",
					Text = "He shall seek vengeance with a renewed zeal. This entire plot of his is driven by the same impulse. Then, kill him if you must. At least... his many deaths ought keep him occupied." },
			},

			HadesAboutChronosNightmare01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosNightmare01", "MorosAboutFates02" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1568", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When Chronos took our family and the House, and you bade the Witch of the Crossroads take me... I remember it somehow, or dreamt of it. Did he... demand you tell him of the Fates?" },
				{ Cue = "/VO/Hades_0137",
					Emote = "PortraitEmoteSurprise",
					Text = "How could you possibly...? He did. Perhaps the Fates themselves permitted you that bit of insight. He did his worst to discover where they hide... though would have failed, even if I did possess the knowledge that he sought." },
				{ Cue = "/VO/MelinoeField_1569", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, you never told Chronos how to find the Fates? Then how did he? Because he's captured them. Not long ago, perhaps, but nonetheless. I'm certain of it." },
				{ Cue = "/VO/Hades_0138",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Hah! {#Prev}If this is true, well then my father's plan for conquest is much closer to fruition than I thought. I do not know how he could find the Fates. But if they can do nothing against him now... Daughter, what chance do you have...?" },
			},

			HadesAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0106",
					PreLineAnim = "Hades_Hello",
					Text = "Daughter, tell me what... became of the Witch of the Crossroads, should you know. When all seemed lost... your mother and I, we left you in her care." },
				{ Cue = "/VO/MelinoeField_1497", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And she has cared for me ever since. Prepared me. Though, we had best not speak of her in these chambers. Suffice it to say, the Unseen remain in shadow." },
				{ Cue = "/VO/Hades_0107",
					Text = "Good. She was... well as you say, we'd best say nothing more. Though if you have the opportunity, extend to her my deepest gratitude." },
			},

			HadesAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll = { "NPC_Hypnos_01", "NPC_Skelly_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0166",
					PreLineAnim = "Hades_Brooding",
					Text = "Nyx, herself... even she was powerless against the Titan. Two of Night Incarnate's own sons served in my House along with her... I suppose he has them, too." },
				{ Cue = "/VO/MelinoeField_2008", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, Hypnos is with {#Emph}us! {#Prev}Fast asleep for all this time, perhaps some sort of... defensive response, for we have found no way to wake him. Brave Schelemeus is with us as well!" },
				{ Cue = "/VO/Hades_0167",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Hypnos, asleep {#Emph}again? {#Prev}And I've no recollection of that other name... but time has worn on me, perhaps. Regardless, if the Witch yet leads the Unseen... the will of Night is not yet lost." },
			},

			HadesAboutBrothers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "UseRecord" },
						HasAll = { "ZeusUpgrade", "PoseidonUpgrade" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0164",
					PreLineAnim = "Hades_Brooding",
					Text = "My brothers each are aiding you, are they? Zeus, doubtless leading from behind the safety of his palace walls... Poseidon, blustering as though his victory is already at hand..." },
				{ Cue = "/VO/MelinoeField_2007", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Father, they're fighting to defend their home... and they're fighting for {#Emph}you! {#Prev}You're right that neither one is much inclined to show concern, but why should they? Fear spreads." },
				{ Cue = "/VO/Hades_0165",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "They sat oblivious upon their surface realm for far too long...! But do not listen to my rantings about them. Had you known your own brother, perhaps you'd better understand the impulse for such ill-conceived remarks..." },
			},

			HadesAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					AreIdsAlive = { 506405 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0108",
					PreLineAnim = "Hades_Brooding",
					Text = "What has that blasted Titan done to Cerberus, that he should storm into this place with such abandon, only to be ushered out again? Takes a small army of Satyrs to drive him back..." },
				{ Cue = "/VO/MelinoeField_1498", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos casts him out into the Mourning Fields above. Then rage and despair congeal about him, and his better senses take leave. My own path leads me through where he resides." },
				{ Cue = "/VO/Hades_0109",
					Text = "So you must face him in that sorry state. Thank you, Daughter, for taking pity on the moody beast. He has seen better, but been through worse. You were too young to form a bond before, but perhaps... it is not too late." },
			},
			HadesAboutBouldy01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01" },
					},
					AreIdsNotAlive = { 506405 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1577", 
					UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Where's Cerberus, Father? He's usually right here. I saw him in the Fields as before!" },
				{ Cue = "/VO/Hades_0124",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "He runs amok at my behest. Spreads the attention of the Titan's legions thin. Eventually they drive him back, but can do him no harm." },
				{ Cue = "/VO/MelinoeField_1578", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So just you and the boulder, then. Looking as though it's not been heaved up any hills in quite a while. Chronos doesn't make you do it?" },
				{ Cue = "/VO/Hades_0125",
					Text = "I'd have less difficult a time than a mere Shade. Besides, these shackles cannot be unlocked, save by the Titan's command. But I'd remain here for eternity before I'd grovel at his feet." },
				{ Cue = "/VO/MelinoeField_1579", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You say this boulder was companion to a mortal king? I... sense something from it. There can be so much energy within a common stone." },
				{ Cue = "/VO/Hades_0126",
					PostLineFunctionName = "CheckConversations",
					Text = "I'll take you at your word. The boulder and I... we're not as close as was its last relationship. Though perhaps you shall coax something from it; the Witch apparently has taught you everything." },

			},

			HadesAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					RequiredMaxHealthFraction = 0.65,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0113",
					PreLineWait = 0.35,
					Text = "...The scent of blood. You're injured. And you expect to face the Titan still? At least you're in the right place should you die." },
				{ Cue = "/VO/MelinoeField_1571", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I won't be dying here no matter what. As for my injuries, perhaps Lord Charon has some Life Essence in stock." },
				{ Cue = "/VO/Hades_0114",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Hades_Brooding",
					Text = "Even now the Boatman plies his trade? Absurd. Our entire operation was shut down! Although... I ought remember that he serves this realm, not me." },
			},
			HadesAboutMelinoe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutChronosNightmare01" },
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},	
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0160",
					Text = "Daughter. Tell me something of yourself, for I know not a thing. For instance... what is it that you like to do? When you are not... attempting this." },
				{ Cue = "/VO/MelinoeField_1994", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What do I like to do? Well... I ensure all of my reagents are in order, so when practicing my craft, what I need is always close at hand. And I like to... {#Emph}ungh{#Prev}, Father, this rings false..." },
				{ Cue = "/VO/Hades_0161",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Mm. {#Prev}Neither the time nor place for trivialities... perhaps, however, at some point... we may discuss such matters more. But there are scores to settle first." },
			},
			HadesAboutZagreus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutChronosNightmare01" },
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = ">=",
						Value = 1,
					},	
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0115",
					Text = "You have the Death Defiance. Runs in the family. Your brother Zagreus, he was also rather sturdy for his stature. Hard-headed, as a boy." },
				{ Cue = "/VO/MelinoeField_1572", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't speak of him as though he's gone! Chronos has him, and Mother, and the rest. But when all this is over... we'll see each other again." },
				{ Cue = "/VO/Hades_0116",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "How can you be so certain? To make such guarantees of the unknown! The Titan... my father... he shall not stop. He is the most hard-headed of us all." },
			},
			HadesAboutPersephone01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutPain01", " HadesAboutZagreus01", "HadesGiftDecline01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0119",
					Text = "Your mother was so proud when you were born. We... did not always think that we would have another child. But we decided to try again." },
				{ Cue = "/VO/MelinoeField_1574", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And you did the most important thing parents can do. You {#Emph}protected {#Prev}me. As for my mother, I know her beautiful smile. The way she's looking at me in the painting that I have." },
				{ Cue = "/VO/Hades_0120",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Hades_Hello",
					Text = "The painting, it survived?! The Witch, she must have taken it... and such a risk, for such a thing. Know that your mother's radiance... cannot be captured. No matter the artist's skill." },
			},
			HadesAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HadesAboutChronosNightmare01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1995", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You saw what happened... what Chronos did to Mother, and my brother, and the rest. Where are they? Where is he holding them?" },
				{ Cue = "/VO/Hades_0162",
					PreLineAnim = "Hades_Brooding",
					Text = "My knowledge of this is not up-to-date. He... made everybody stop, somehow. I saw them, still as stone; not petrified exactly but ensnared, in the Great Hall of the House. He must have stored them someplace else inside..." },
				{ Cue = "/VO/MelinoeField_1996", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even when I'm able to vanquish Chronos on a given night, most of the House is sealed off, and I'm unable to remain for long. How can we break them out...?" },
				{ Cue = "/VO/Hades_0163",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Perhaps if you ask the Titan very nicely, he shall comply? Daughter, I know of no way to undo his work, and have no wisdom to impart. But {#Emph}this{#Prev}, I can provide." },
			},

			HadesAboutSisyphus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0121",
					Text = "This chamber... it once held a prisoner of mine. A mortal king who had attempted to cheat Death! I forced the wretch to heave that boulder up that path forever. He forgave me anyway." },
				{ Cue = "/VO/MelinoeField_1575",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Forget him, Father. What purpose does it serve to dwell on some dead mortal now? Chronos wants you to wallow in your guilt. Don't." },
				{ Cue = "/VO/Hades_0122",
					PreLineAnim = "Hades_Brooding",
					Text = "You misunderstand. The prisoner, he was called Sisyphus the King. His boulder there was like a friend. He... asked his friend to keep me company. Until more company arrived, he said." },
				{ Cue = "/VO/MelinoeField_1576", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well then, I'm grateful to that boulder and the king. Chronos must not have accounted for your former prisoners being fond of you." },
				{ Cue = "/VO/Hades_0123",
					PreLineAnim = "Hades_Hello",
					Text = "Oh most of them are not. Some chose to join the Titan's legions and remain here in Tartarus. Not anywhere I cast my gaze, of course." },
			},

			-- Repeatable
			HadesChat01 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0036",
					PreLineAnim = "Hades_Brooding",
					Text = "Cease with this foolishness, Daughter. There is no stopping him. He is inevitability itself." },
			},
			HadesChat02 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0037",
					Text = "You risk too much by visiting me here." },
			},
			HadesChat03 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0038",
					Text = "My son would never listen to me; I was a fool to think it a distinctive trait." },
			},
			HadesChat04 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0039",
					Text = "I've little strength of late, but you shall have it nonetheless." },
			},
			HadesChat05 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0040",
					Text = "Thank you for looking after Cerberus, though look after yourself." },
			},
			HadesChat06 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0041",
					Text = "You are as willful as your brother, aren't you..." },
			},
			HadesChat07 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0096",
					Text = "Whenever you return... so does a portion of my strength." },
			},
			HadesChat08 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0097",
					Text = "Take no unnecessary risks and go unseen, Daughter." },
			},
			HadesChat09 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0098",
					Text = "You have vanquished the Titan before; you know full well what it takes." },
			},
			HadesChat10 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0099",
					Text = "I am of little use like this. You need not stray from your path on my account." },
			},
			HadesChat11 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0100",
					Text = "Hold nothing back against the Titan. That you are family matters not to him." },
			},
			HadesChat12 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0101",
					Text = "Be on your way, Daughter. I require no assistance here." },
			},
			HadesChat13 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0102",
					Text = "The Witch of the Crossroads swore no harm would come to you; ensure she keeps her word." },
			},
			HadesChat14 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					AreIdsAlive = { 506405 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0103",
					Text = "How strange to have a moment's peace with you and Cerberus, in such an age." },
			},
			HadesChat15 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					AreIdsAlive = { 506405 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0104",
					Text = "We have anticipated your arrival, ever since the dog bounded in here." },
			},
			HadesChat16 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0105",
					Text = "Go, take your vengeance. Our family, we've more than enough to spare." },
			},
			HadesChat17 =
			{
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0105",
					Text = "Go, take your vengeance. Our family, we've more than enough to spare." },
			},
			HadesChat18 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0047",
					Text = "He is no mere Titan. He is Time itself; and Time cannot be stopped..." },
			},
			HadesChat19 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0111",
					Text = "These shackles sap me of my force of will; but not entirely." },
			},
			HadesChat20 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0112",
					Text = "This is not how I imagined my daughter would spend the evenings of her youth..." },
			},
		},

		GiftTextLineSets =
		{
			HadesGiftDecline01 =
			{
				PlayOnce = true,
				Cost =
				{
					GiftPoints = 1,
				},
				SkipGiftPresentationPost = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/MelinoeField_1499", UsePlayerSource = true,
					Text = "Father, while I know this wasn't necessarily permitted, I thought if maybe it would be of any comfort at all, that I might offer you this Nectar?" },
				{ Cue = "/VO/Hades_0110",
					PreLineAnim = "Hades_Brooding",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "Exactly like your brother, blast... I fear I'm not in any mood or state for such a thing. Concern yourself not with my comfort, but with the target of your wrath." },
			},

			HadesGift01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "UnavailableHeartIcon",
				LockedHintId = "Codex_HadesGiftHint",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					-- @ Currently impossible!
					{
						Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
						Comparison = ">=",
						Value = 9999,
					},
				},
				EndWait = 1.0,
				{ Cue = "",
					Text = "" },
			},

			-- placeholder
			HadesGiftTemp =
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
					AreIdsNotAlive = { 370006 },

				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Hades_Field_01",
			PreLineAnim = "Hades_Brooding",
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
				{ Name = "HadesSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Hades_0042", Text = "Lash out, if you must.", PlayFirst = true },
			{ Cue = "/VO/Hades_0043", Text = "You need not fail as I.",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
				},
			},
			{ Cue = "/VO/Hades_0044", Text = "Leave me be." },
			{ Cue = "/VO/Hades_0045", Text = "Leave me, I said." },
			{ Cue = "/VO/Hades_0046", Text = "Oh, blood and darkness..." },
		},
	},

	-- Cerberus, Id = 506405
	NPC_Cerberus_Field_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "NPC_Cerberus_01",
		Portrait = "Portrait_Cerberus_Default_01",
		AnimOffsetZ = 325,
		Groups = { "NPCs" },

		UseText = "UseCerberus",
		UseTextSpecial = "UseCerberusSpecial",
		UseTextTalkAndGift = "UseCerberusAndGift",
		UseTextTalkAndSpecial = "UseCerberusAndSpecial",
		UseTextTalkGiftAndSpecial = "UseCerberusGiftAndSpecial",
		SpecialInteractFunctionName = "AttemptPetCerberusThread",

		InteractTextLineSets =
		{
			CerberusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				UseInitialInteractSetup = true,
				StatusAnimation = false,
				-- PreEventFunctionName = "PetCerberus",
				{ Cue = "/VO/Storyteller_0125", StartSound = "/VO/CerberusSnarls",
					IsNarration = true,
					Text = "{#Emph}Ferocious Cerberus yet guards his master dutifully, having discovered him within these depths." },
			},

			-- Repeatable
			CerberusChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0126", PreLineWait = 1.0, StartSound = "/VO/CerberusWhineSad", IsNarration = true,
					Text = "{#Emph}Three-headed Cerberus permits none approach, neither him nor his master." },
			},
			CerberusChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0127", PreLineWait = 1.0, StartSound = "/VO/CerberusWhineSad", IsNarration = true,
					Text = "{#Emph}The monstrous Hound of Hell bares countless fangs as if to say, back off." },
			},
			CerberusChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0128", PreLineWait = 1.0, StartSound = "/VO/CerberusWhineSad", IsNarration = true,
					Text = "{#Emph}Feared watch-dog Cerberus regards the Princess with his six expectant eyes." },
			},
			CerberusChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0242", PreLineWait = 1.0, StartSound = "/VO/CerberusSnarls", IsNarration = true,
					Text = "{#Emph}The multiheaded monster keeps his fury well in check beside the rightful Underworld King." },
			},
			CerberusChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0243", PreLineWait = 1.0, StartSound = "/VO/CerberusCuteGrowl_3", IsNarration = true,
					Text = "{#Emph}Fierce hell-hound Cerberus has many fangs but little trust to spare." },
			},
			CerberusChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0244", PreLineWait = 1.0, StartSound = "/VO/CerberusExtraGrowl_1", IsNarration = true,
					Text = "{#Emph}The resting hound of hell makes plain he wishes not to be disturbed." },
			},
			CerberusChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0245", PreLineWait = 1.0, StartSound = "/VO/CerberusCuteGrowl_1", IsNarration = true,
					Text = "{#Emph}Three-headed Cerberus eyes every surface of the chamber, all at once." },
			},
			CerberusChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0246", PreLineWait = 1.0, StartSound = "/VO/CerberusSniff", IsNarration = true,
					Text = "{#Emph}The savage watch dog looks tentatively at the Princess of the Underworld." },
			},
			CerberusChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0247", PreLineWait = 1.0, StartSound = "/VO/CerberusWhine", IsNarration = true,
					Text = "{#Emph}Notoriously vicious Cerberus sits vigilantly by his master's side." },
			},
			CerberusChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0248", PreLineWait = 1.0, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true,
					Text = "{#Emph}The triple-headed guardian of hell does not wish to be troubled at this time." },
			},
		},

		GiftTextLineSets =
		{
			CerberusGift01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 999,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Cerberus_Field_01" },
					},
				},
					{ Cue = "", PreLineWait = 1.0, StartSound = "/VO/CerberusSnarls",
					IsNarration = true,
					Text = "{#DialogueItalicFormat}TKTKTK" },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

		},

		RepulseOnMeleeInvulnerableHit = 250,
		InvincibubbleScale = 2,
		InvulnerableHitSound = "/VO/CerberusBarks",
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Hades_Field_01",
			PreLineAnim = "Hades_Brooding",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "UseRecord" },
					HasAll = { "NPC_Hades_Field_01" },
				},
			},
			Cooldowns =
			{
				{ Name = "HadesSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Hades_0139", Text = "That won't earn his affection." },
			{ Cue = "/VO/Hades_0140", Text = "Leave him be.", PlayFirst = true },
			{ Cue = "/VO/Hades_0141", Text = "{#Emph}Stay{#Prev}, Cerberus..." },
			{ Cue = "/VO/Hades_0142", Text = "He wishes to be left alone." },
			{ Cue = "/VO/Hades_0143", Text = "A temperamental beast." },
			{ Cue = "/VO/Hades_0144", Text = "He does not wish to play." },
		},

	},

	-- Bouldy, Id = 506340
	NPC_Bouldy_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		UseText = "NPCUseTextTalkAlt",
		AnimOffsetZ = 235,
		Portrait = "Portrait_Bouldy_Default_01",
		SubtitleColor = Color.BouldyVoice,
		BlockStatusAnimations = true,
		Groups = { "NPCs" },
		GiftText = "GiftBouldyUseText",

		InteractTextLineSets =
		{
			BouldyFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Bouldy",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutBouldy01" },
					},
					AreIdsNotAlive = { 506405 },
				},
				{ Cue = "/VO/MelinoeField_1681", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you cannot hear me, but... if you have comforted my father in his plight, thank you." },
				{ Cue = "/VO/BouldySilent01", SpeakerLabelOffsetY = 18,
					Text = ".   .   .   ." },
			},

			-- Repeatable
			BouldyChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Bouldy",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "BouldyFirstMeeting" },
					},
					AreIdsNotAlive = { 506405 },
				},
				{ Cue = "/VO/BouldySilent01", SpeakerLabelOffsetY = 18,
					Text = ".   .   .   ." },
			},
		},

		GiftTextLineSets =
		{
			BouldyGiftRepeatable01 =
			{
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					-- @ Currently impossible!
					{
						Path = { "GameState", "UseRecord", "NPC_Bouldy_01" },
						Comparison = ">=",
						Value = 9999,
					},
				},
				{ Cue = "/VO/BouldySilent01", SpeakerLabelOffsetY = 18,
					Text = ".   .   .   .",
					PostLineGlobalVoiceLines = "BlessedByBouldyVoiceLines",
					PostLineFunctionName = "AddRandomBouldyBlessing",
					PostLineFunctionArgs = PresetEventArgs.BouldyRandomBlessings },
			},
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

		},

		OnHitFunctionName = "BouldyHitPresentation",
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ChanceToPlay = 0.75,
			ObjectType = "NPC_Hades_Field_01",
			Cooldowns =
			{
				{ Name = "HadesSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Hades_0156", Text = "Leave it be.", PlayFirst = true },
			{ Cue = "/VO/Hades_0157", Text = "The boulder has seen punishment enough." },
			{ Cue = "/VO/Hades_0158", Text = "Cease this, Daughter." },
			{ Cue = "/VO/Hades_0159", Text = "Vent your frustrations elsewhere." },
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hades )