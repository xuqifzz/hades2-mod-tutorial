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
		Icon = "BoonSymbolHades",
		EmoteOffsetY = -280,
		EmoteOffsetX = 45,
		InvincibubbleScale = 1.2,
		RequiredRoomInteraction = true,
		TreatAsGodLootByShops = true,
		ExcludeFromLastRunBoon = true,
		IgnoreRestrictBoonChoices = true,
		IgnoreTempRarityBonus = true,
		BlockForceCommon = true,
		BlockDoubleBoon = true,
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs =
		{
			SkipInteractAnim = true,
			SkipSound = true,
			ResetUseText = true,
			PreserveContextArt = true,
		},
		RecheckConversationOnLootPickup = true,
		SpeakerName = "Hades",
		LightingColor = { 255, 0, 0, 255 },
		LootColor = { 242, 49, 46, 255 },
		UpgradeScreenOpenSound = "/SFX/Enemy Sounds/Hades/HadesSummonPresentation3",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeHadesSigil2",
		MenuTitle = "UpgradeChoiceMenu_Hades",
		PriorityUpgrades = { },
		WeaponUpgrades = { },
		-- if this gets updated, please also update ChronosBossAboutHades02 =
		Traits =
		{
			"HadesLifestealBoon",
			"HadesCastProjectileBoon",
			"HadesPreDamageBoon",
			"HadesChronosDebuffBoon",
			"HadesDashSweepBoon",
			"HadesDeathDefianceDamageBoon",
			"HadesManaUrnBoon",
			-- Legendary
			"HadesInvisibilityRetaliateBoon",
		},
		LoadPackages = { "NPC_Hades_Field_01", "Hades", },
		Consumables = { },

		RarityChances =
		{
			Common = 1,
			Legendary = 0.1,
		},
		RarityRollOrder = { "Common", "Heroic" },

		FlavorTextIds =
		{
			"HadesUpgrade_FlavorText01",
			"HadesUpgrade_FlavorText02",
			"HadesUpgrade_FlavorText03",
		},

		SetupEvents =
		{
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAnimation = "Hades_Unchained_Idle",
					ThingProperties =
					{
						GrannyModel = "HadesEnding_Mesh"
					},
					OverwriteSourceKeys =
					{
						PortraitSwapMap =
						{
							Portrait_Hades_Chained_01 = "Portrait_LordHades_01",
							Portrait_Hades_Chained_02 = "Portrait_LordHades_Averted_01",
						},
						Speaker = "NPC_LordHades_01",
					},
					EndFunctionName = "SwapAnimations",
					EndFunctionArgs =
					{
						Hades_Idle = "Hades_Unchained_Idle",
						Hades_Hello = "Hades_Unchained_Hello",
						Hades_Brooding = "Hades_Unchained_Brooding",
						Hades_Blessing = "Hades_Unchained_Blessing",
						Hades_Blessing_Short = "Hades_Unchained_Blessing_Short",
					},
				},
			}
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
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
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				Queue = "Always",
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HadesAboutAutomatons01" },
					},
				},

				{ Cue = "/VO/MelinoeField_2834", Text = "They... fight pretty well." },
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			OrRequirements =
			{
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
				},
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
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
				SuccessiveChanceToPlayAll = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_1566", Text = "Be well, Lord Father." },
				{ Cue = "/VO/MelinoeField_1567", Text = "In shadow, I serve!" },
				{ Cue = "/VO/Melinoe_5165", Text = "Hail, Lord Father!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" }
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" }, Alive = false },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5064", Text = "Be well, Mother!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" } },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5065", Text = "Thank you for being here.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" } },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5066", Text = "So glad to see you.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" } },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5067", Text = "Take care, Mother.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Persephone_01" } },
						},
					},
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.28,
					-- PreLineAnim = "Persephone_Greet_Start",
					ObjectType = "NPC_Persephone_01",

					{ Cue = "/VO/Persephone_0050", Text = "You too, my baby girl.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5064" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0051", Text = "Only because of you.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5065" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0052", Text = "Oh, Daughter...",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5066" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0053", Text = "You take care too.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5067" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0054", Text = "{#Emph}<Sigh>",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5066", "/VO/Melinoe_5067" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0055", Text = "Hello!",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0056", Text = "The old one at least.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1700" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0057", Text = "Oh, thank you.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0058", Text = "We could use it.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1704" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0059", Text = "We'll need it.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1705" },
							},
						},
					},
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.3,
					ObjectType = "NPC_Hades_Field_01",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" }
						},
					},

					{ Cue = "/VO/Hades_0253", Text = "Greetings.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
							},
						},
					},
					{ Cue = "/VO/Hades_0254", Text = "Hail, Daughter.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_5165" },
							},
						},
					},
					{ Cue = "/VO/Hades_0255", Text = "Darkness suits me best.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
							},
						},
					},
					{ Cue = "/VO/Hades_0256", Text = "Go unseen.",
						PreLineAnim = "Hades_Hello",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/MelinoeField_1567", "/VO/Melinoe_1705" },
							},
						},
					},
					{ Cue = "/VO/Hades_0127", Text = "{#Emph}Hrm.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/MelinoeField_1566", "/VO/MelinoeField_1566", "/VO/Melinoe_1709", "/VO/Melinoe_1700", "/VO/Melinoe_1704" },
							},
						},
					},
					{ Cue = "/VO/Hades_0136", Text = "To shadow, you'll return.",
						PlayFirst = true,
						PreLineAnim = "Hades_Hello",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/MelinoeField_1567" },
							},
						},
					},
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.4,
					PreLineAnim = "Hades_Hello",
					ObjectType = "NPC_Hades_Field_01",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" }
						},
					},

					{ Cue = "/VO/Hades_0127", Text = "{#Emph}Hrm.",
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
					{ Cue = "/VO/Hades_0132", Text = "Not here it won't.",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0049", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					PreLineAnim = "Hades_Brooding",
					-- PreLineAnim = "Hades_Hello",
					-- PreLineAnim = "Hades_Brooding",
					-- PreLineAnim = "Hades_Blessing",
					-- PreLineAnim = "Hades_Blessing_Short",
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
					Portrait = "Portrait_Hades_Chained_02",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Hades_Chained_02",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Hades_Chained_02",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 2.5 },

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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0034",
					Portrait = "Portrait_Hades_Chained_02",
					Text = "I know not how you withstood the Titan, if truly you confronted him. Quickly now, tell me but this: Have you been... are you well?" },
				{ Cue = "/VO/Melinoe_1063", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Am I... well? All my life I've been preparing for this moment, to bring the usurper of the House of Hades to justice. So, I'll have to get back to you, depending on how it goes." },
				{ Cue = "/VO/Hades_0035",
					PreLineWait = 0.35,
					PreLineAnim = "Hades_Brooding",
					Portrait = "Portrait_Hades_Chained_02",
					Text = "...I'm sorry... I'm sorry. Get back to me if you must. I'd grant your vengeance if I could. But this is all that I can do for now." },
			},

			HadesAboutPain01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1495", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It hurts my heart to see you like this, Father. But, it brings me peace. And strength. Helps that this chamber isn't crawling with Satyrs..." },
				{ Cue = "/VO/Hades_0053",
					Text = "Oh they have sense enough to keep their distance from me... or perhaps Cerberus. Well if seeing me in this pitiable state should spur you to your fullest wrath, then so be it." },
				{ Cue = "/VO/MelinoeField_1496", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's not quite it; I don't feel loathing or hatred. Elsewhere in Tartarus, perhaps, but not here. Not anymore. I just hope my presence doesn't cause you further pain." },
				{ Cue = "/VO/Hades_0054",
					PreLineAnim = "Hades_Brooding",
					Portrait = "Portrait_Hades_Chained_02",
					Text = "No. The only pain... is that your mother and I, your brother, this dog, that we were not... we could not be there to see you grow. Each time I see you now... it fills an absence that was there." },
			},

			HadesAboutHouse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0117",
					Text = "If you'd indulge a senseless curiosity... how fares my House? Your brother, he was more or less in charge of the decor. I highly doubt the Titan shares his taste." },
				{ Cue = "/VO/MelinoeField_1573", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "N_Opening01" },
						Comparison = ">=",
						Value = 1,
					},
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
					-- Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hades_Chained_02",
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

			HadesAboutAutomatons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSurface01" },
					},
					{
						Path = { "GameState", "EnemyKills" },
						HasAll = { "SentryBot", "AutomatonBeamer", "AutomatonEnforcer", "Talos" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HephaestusAboutAutomatons02", "PoseidonAboutAutomatons02", "AthenaAboutAutomatons01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0173",
					Text = "To think that you have seen Olympus with your own eyes... your brother never had that opportunity. And I myself... my life is here, and I've no memories of mountaintops." },
				{ Cue = "/VO/MelinoeField_2833", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It must have been a sight to behold, once. Now it's beset with the Titan's legions, and mindless Automaton defenders that want {#Emph}me {#Prev}destroyed just as much as our foes." },
				{ Cue = "/VO/Hades_0174",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "I told them never to depend on such contraptions! A proper army needs to be driven by glory, if not fear. Their Automatons feel {#Emph}nothing! {#Prev}How well can they possibly fight?" },
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

			HadesAboutPersephoneAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0177",
					PreLineAnim = "Hades_Hello",
					Text = "That skull you have in hand, is that... how did you come to possess it? It once had been entrusted to your mother's care... for her protection, and in a way, yours." },
				{ Cue = "/VO/MelinoeField_2836", UsePlayerSource = true,
					Text = "Mother's Aspect of the Argent Skull Revaal deemed me a worthy-enough bearer... but it was Headmistress Hecate who first gathered the Nocturnal Arms for my task." },
				{ Cue = "/VO/Hades_0178",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Forged by the Fates! Who so like playing us for fools. That skull did not protect the Queen as much as I would have preferred; but perhaps its work merely is not yet complete." },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
						Value = 2,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesFirstMeeting_C" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutChronosBossW01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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

			-- add alt below
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
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesAboutChronosNightmare01_B" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1568", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When Chronos took our family and the House, and you bade the Witch of the Crossroads take me... I remember it somehow, or dreamt of it. Did he... demand you tell him of the Fates?" },
				{ Cue = "/VO/Hades_0273",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hades_Chained_02",
					Text = "How could you possibly...? Perhaps the Fates themselves permitted you that bit of insight. My father sought them, but I revealed nothing. Couldn't have even if I so desired, for no one knows where those three are, save {#Emph}them." },
				{ Cue = "/VO/MelinoeField_1569", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, you never told Chronos how to find the Fates? Then how {#Emph}did {#Prev}he? Because he's captured them. Not long ago, perhaps, but nonetheless. I'm certain of it." },
				{ Cue = "/VO/Hades_0274",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteFiredUp",
					Text = "What?! No... but if this is true, well then my father's plan for conquest is much closer to fruition than I thought. If not even they could stop him... Daughter, what chance do {#Emph}you {#Prev}have...?" },
			},
			HadesAboutChronosNightmare01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ChronosNightmare01", "MorosAboutFates02" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesAboutChronosNightmare01" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1568", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When Chronos took our family and the House, and you bade the Witch of the Crossroads take me... I remember it somehow, or dreamt of it. Did he... demand you tell him of the Fates?" },

				{ Cue = "/VO/Hades_0273",
					Emote = "PortraitEmoteSurprise",
					Text = "How could you possibly...? Perhaps the Fates themselves permitted you that bit of insight. My father sought them, but I revealed nothing. Couldn't have even if I so desired, for no one knows where those three are, save {#Emph}them." },

				{ Cue = "/VO/MelinoeField_4150", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, you never told Chronos how to find the Fates? Then how {#Emph}did {#Prev}he? Because he captured them... before all this I mean. I'm certain of it." },

				{ Cue = "/VO/Hades_0276",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}What? {#Prev}Why am I only learning of this {#Emph}now? {#Prev}We'll shake the information out of him, then, and locate them immediately!" },
			},

			HadesAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSurface01" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0171",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Daughter, answer me something. How is it that the Titan's armies are well-organized enough to siege Olympus, when the Titan himself cowers here in Tartarus?" },
				{ Cue = "/VO/MelinoeField_2832", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We have another Titan to contend with there: Prometheus is leading the attack. I don't know how exactly he got free, or what he truly wants... other than vengeance on the gods." },
				{ Cue = "/VO/Hades_0172",
					PreLineAnim = "Hades_Brooding",
					Text = "Is vengeance on the gods an insufficient desire in itself? I wanted nothing to do with his sentencing... but your Lord Uncle Zeus, he... well, he would always claim that he could fashion more-creative punishments than I..." },
			},

			-- alt below
			HadesAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSurface01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutTyphon01_B" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = "<=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_3101", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Father, I'm afraid the matter on Olympus is more dire than we thought... for Chronos reawakened Typhon, who is very, {#Emph}very {#Prev}large... and dead-set on destroying the Palace of Zeus." },
				{ Cue = "/VO/Hades_0191",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "{#Emph}Pah! {#Prev}Such a predictable and reckless action on the Titan's part. Although your uncle Zeus may not be quite as spry as when he and that monster previously clashed." },
				{ Cue = "/VO/MelinoeField_3102", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "You don't seem so surprised. How did you all defeat Typhon before? I've never fought something like him." },
				{ Cue = "/VO/Hades_0192",
					PreLineAnim = "Hades_Brooding",
					Text = "Nor should you fight something like him, Daughter! Let Zeus clean up his mess. His thunderbolt proved quite effective in the past... although you'd think that an embodiment of storms and rage would be immune." },
				{ Cue = "/VO/MelinoeField_3103", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not about to abandon our family to face this threat on their own." },
				{ Cue = "/VO/Hades_0193",
					PreLineAnim = "Hades_Hello",
					Text = "Then you're in the wrong place. For if you think thwarting the Titan shall stop Typhon in turn, you're wrong. A monster such as that cannot be controlled. Go, see for yourself." },
			},
			HadesAboutTyphon01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSurface01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutTyphon01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_3101", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Father, I'm afraid the matter on Olympus is more dire than we thought... for Chronos reawakened Typhon, who is very, {#Emph}very {#Prev}large... and dead-set on destroying the Palace of Zeus." },
				{ Cue = "/VO/Hades_0191",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "{#Emph}Pah! {#Prev}Such a predictable and reckless action on the Titan's part. Although your uncle Zeus may not be quite as spry as when he and that monster previously clashed." },
				{ Cue = "/VO/MelinoeField_3930", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "You don't seem so surprised. How did you all defeat Typhon before? My methods thus far have not produced long-lasting results." },
				{ Cue = "/VO/Hades_0275",
					PreLineAnim = "Hades_Brooding",
					Text = "Your {#Emph}methods? {#Prev}Let Zeus clean up his mess. His thunderbolt proved quite effective in the past... although you'd think that an embodiment of storms and rage would be immune." },
				{ Cue = "/VO/MelinoeField_3103", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not about to abandon our family to face this threat on their own." },
				{ Cue = "/VO/Hades_0193",
					PreLineAnim = "Hades_Hello",
					Text = "Then you're in the wrong place. For if you think thwarting the Titan shall stop Typhon in turn, you're wrong. A monster such as that cannot be controlled. Go, see for yourself." },
			},

			HadesAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutTyphon01", "HadesAboutTyphon01_B" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0194",
					Text = "What news of Typhon recently, Daughter? Zeus used to boast of how he vanquished that monstrosity alone. Now I imagine more of a concerted effort is required." },
				{ Cue = "/VO/MelinoeField_3104", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Father, if you bear some grudge with Uncle Zeus, that's only to the benefit of all our enemies. Typhon yet threatens the mountaintop... he can be driven back, but never for long." },
				{ Cue = "/VO/Hades_0195",
					PreLineAnim = "Hades_Brooding",
					Text = "We buried him under a mountain once; no ordinary show of strength, for other methods failed. Well, I trust my brother has some sort of {#Emph}plan. {#Prev}He never lacked for those." },
			},
			HadesAboutTyphon03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutTyphon01", "HadesAboutTyphon01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0196",
					PreLineWait = 0.35,
					PreLineAnim = "Hades_Brooding",
					Text = "...When first we had to fend off Typhon long ago, we dared not think the Titan Lord whom we had already disposed of was responsible. Surely not even {#Emph}he {#Prev}in all his arrogance believed that such a monster would bend to his will!" },
				{ Cue = "/VO/MelinoeField_3105", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All Chronos probably expected was that the monster would immediately attack Olympus. How could he have awakened such a thing without our family even noticing?" },
				{ Cue = "/VO/Hades_0197",
					PreLineAnim = "Hades_Hello",
					Text = "With Nyx herself amongst the Titan Lord's captives, all that transpires deep within the Earth cannot be known by anyone. And now... even though both Typhon and the Titan fell to us before... we have never had to face them both at once." },
			},
			HadesAboutTyphon04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},					
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutTyphon01", "HadesAboutTyphon01_B" }
					},
					{
						SumPrevRuns = 5,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 5,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Hades_Field_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0198",
					Text = "I have not seen you in some time... perhaps you've been preoccupied with thwarting Typhon as he makes attempts to break into my brother's nigh-impenetrable mountain palace." },
				{ Cue = "/VO/MelinoeField_3106", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's a rather accurate assessment of my recent outings, yes. Typhon may appear to be invincible, but there's not a creature alive that likes repeatedly being struck in the face." },
				{ Cue = "/VO/Hades_0199",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "An age-old tactic that served well your predecessors in the greatest battles of their youth. I had a feeling that would be the case; in the end, little changes with time." },
			},

			HadesAboutChronosAllies01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutPrometheus01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0175",
					PreLineAnim = "Hades_Hello",
					Text = "Who else besides Prometheus does Chronos have under his thumb? I would know every last Titan or such ilk who deigned to turn on us." },
				{ Cue = "/VO/MelinoeField_2835", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Besides marauding hordes of Satyrs and such, the ones that come to mind include the Cyclops Polyphemus... and Nyx's daughter Eris... though she may be acting on her own." },
				{ Cue = "/VO/Hades_0176",
					PreLineAnim = "Hades_Brooding",
					Text = "Strife could never be controlled, Nyx knew only too well. As for that Cyclops... he and your Uncle Poseidon have some history that may have spurred his impulses. Well... it is not yet the longest list of enemies, at least." },
			},

			HadesAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, Hypnos is with {#Emph}us! {#Prev}Fast asleep for all this time, perhaps some sort of... defensive response, for we have found no way to wake him. Brave Schelemeus is with us as well!" },

				{ Cue = "/VO/Hades_0167",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Hypnos, asleep {#Emph}again? {#Prev}And I've no recollection of that other name... but Time has worn on me. Regardless, if the Witch yet leads the Unseen, the will of Night is not yet lost." },
			},

			HadesAboutBrothers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0108",
					PreLineAnim = "Hades_Brooding",
					Text = "What has that blasted Titan done to Cerberus, that he should storm into this place with such abandon, only to be ushered out again? Takes a small army of Satyrs to drive him back..." },
				{ Cue = "/VO/MelinoeField_1498", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos casts him out into the Mourning Fields above. Then rage and despair congeal about him, and his better senses take leave. My own path leads me through where he resides." },
				{ Cue = "/VO/Hades_0109",
					Text = "So you must face him in that sorry state. Thank you, Daughter, for taking pity on the moody beast. He has seen better, but been through worse. You were too young to form a bond before, but perhaps... it is not too late." },
			},
			HadesAboutCerberus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutTyphon01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0200",
					PreLineAnim = "Hades_Brooding",
					Text = "Cerberus has been quite agitated, and I'm realizing why. It's not just having to roam through the Mourning Fields; he probably can sense Typhon's return." },
				{ Cue = "/VO/MelinoeField_3316", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Just about every monster I've confronted probably is traceable to Typhon in some way. I doubt he had a close relationship with any of his kin; not even Cerberus." },
				{ Cue = "/VO/Hades_0201",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "I doubt that too. It seems not one of us is able to escape our fathers' influence. Yet here we all are, still." },
			},
			HadesAboutHoundFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "HoundFamiliar" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0205",
					PreLineAnim = "Hades_Hello",
					Text = "It may be best to keep your distance there, or rather for that dog. Although... the Witch of the Crossroads, she once had a hound much like that one..." },
				{ Cue = "/VO/MelinoeField_3319", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Then this must be the very same. She's called Hecuba, and I'm certain she'll be respectful both to you and Cerberus. Besides, they already met in the Fields..." },
				{ Cue = "/VO/Hades_0206",
					PreLineAnim = "Hades_Blessing_Short",
					PostLineFunctionName = "CerberusReaction",
					Text = "A creature possessed of loyalty and courage, then. A quite-uncommon combination, whether in beasts or otherwise. Be on your best behavior with her, Cerberus." },
			},

			-- alt below
			HadesAboutBouldy01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutBouldy01_B" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1577", 
					UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Where's Cerberus, Father? He's usually right here. I saw him in the Fields as before!" },
				{ Cue = "/VO/Hades_0124",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "He runs amok at my behest. Spreads the attention of the Titan's legions thin. Eventually they drive him back, but can do him no harm." },
				{ Cue = "/VO/MelinoeField_1578", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So just you and the boulder, then. Looking as though it's not been heaved up any hills in quite a while. Chronos doesn't make you do it?" },
				{ Cue = "/VO/Hades_0125",
					PreLineAnim = "Hades_Hello",
					Text = "I'd have less difficult a time than a mere Shade. Besides, these shackles cannot be unlocked, save by the Titan's command. But I'd remain here for eternity before I'd grovel at his feet." },
				{ Cue = "/VO/MelinoeField_1579", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You say this boulder was companion to a mortal king? I... sense something from it. There can be so much energy within a common stone." },
				{ Cue = "/VO/Hades_0126",
					PostLineFunctionName = "CheckConversations",
					Text = "I'll take you at your word. The boulder and I... we're not as close as was its last relationship. Though perhaps you shall coax something from it; the Witch apparently has taught you everything." },
			},
			HadesAboutBouldy01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutBouldy01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/MelinoeField_1577", 
					UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Hesitant_01",
					Text = "Where's Cerberus, Father? He's usually right here. I saw him in the Fields as before!" },
				{ Cue = "/VO/Hades_0124",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "He runs amok at my behest. Spreads the attention of the Titan's legions thin. Eventually they drive him back, but can do him no harm." },
				{ Cue = "/VO/MelinoeField_1578_B", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So just you and the boulder, then. Looking as though it's not been heaved up any hills in quite a while. You say this boulder was companion to a mortal king? I... sense something from it. There can be so much energy within a common stone." },
				{ Cue = "/VO/Hades_0126",
					PostLineFunctionName = "CheckConversations",
					Text = "I'll take you at your word. The boulder and I... we're not as close as was its last relationship. Though perhaps you shall coax something from it; the Witch apparently has taught you everything." },
			},
			HadesAboutBouldy02 =
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
						HasAny = { "HadesAboutBouldy01", "HadesAboutBouldy01_B" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Bouldy_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						SumPrevRuns = 8,
						Path = { "UseRecord", "NPC_Bouldy_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0279",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Has that boulder yet revealed anything to you? I know not why I ask, mere baseless superstition on my part... but I have seen you go to it from time to time." },
				{ Cue = "/VO/MelinoeField_4153", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You spoke gently of the prisoner once held here, as though you had forgiven him. I used to think that was impossible in Tartarus. The boulder now reminds me otherwise." },
				{ Cue = "/VO/Hades_0280",
					PreLineAnim = "Hades_Hello",
					Text = "Most of the wretches who we once held captive here had no hope of forgiveness or freedom at all, yet even they broke loose, if undeservedly. Then let the boulder stand as testament to all that has transpired, and shall come to pass." },
			},

			HadesAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.4, },
					},
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
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Hades_Brooding",
					Text = "Even now, the Boatman plies his trade? Absurd. Our entire operation was shut down! Although... I ought remember that he serves this realm, not me." },
			},
			HadesAboutMelinoe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutChronosNightmare01", "HadesAboutChronosNightmare01_B" },
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
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 8.3 },

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
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutChronosNightmare01", "HadesAboutChronosNightmare01_B" },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						HasAny = { "HadesAboutPain01", "HadesAboutZagreus01", "HadesGiftDecline01", "HadesAboutBouldy02", "HadesAboutMelinoe01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" }, Alive = false },
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
					Portrait = "Portrait_Hades_Chained_02",
					Text = "The painting, it survived?! The Witch, she must have taken it... and such a risk, for such a thing. Know that your mother's radiance... cannot be captured. No matter the artist's skill." },
			},
			HadesAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutChronosNightmare01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 2,
					},
					{
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 1,
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

			HadesAboutAres01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0202",
					Text = "I used to have a sense for all the blessings of our kin; their Boons were not permitted in this realm. That sense has dulled, for only now do I detect the influence of Ares here..." },
				{ Cue = "/VO/MelinoeField_3317",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your sense for surface blessings is intact, Father. I met Ares only after all the rest. It seems this war has taken such a turn that he's now helping put a stop to it." },
				{ Cue = "/VO/Hades_0203",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Is that what he told you...? The only reason I can think of that my nephew would endeavor to conclude a war is if it meant still-greater wars could then be waged instead. Nevertheless, if he is claiming to be on your side, he would not lie outright." },
			},
			HadesAboutAres01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutAres01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0202",
					Text = "I used to have a sense for all the blessings of our kin; their Boons were not permitted in this realm. That sense has dulled, for only now do I detect the influence of Ares here..." },
				{ Cue = "/VO/MelinoeField_3317_B",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your sense for surface blessings is intact, Father. I met Ares only after all the rest." },
				{ Cue = "/VO/Hades_0203_B",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "The only reason I can think of that my nephew would endeavor to conclude a war is if it meant still-greater wars could then be waged instead. Nevertheless, if he is claiming to be on your side, he would not lie outright." },
			},

			HadesAboutSisyphus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesGiftDecline01" }
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
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well then I'm grateful to that boulder and the king. Chronos must not have accounted for your former prisoners being fond of you." },
				{ Cue = "/VO/Hades_0123",
					PreLineAnim = "Hades_Hello",
					Text = "Oh most of them are not. Some chose to join the Titan's legions and remain here in Tartarus. Not anywhere I cast my gaze, of course." },
			},
			HadesAboutSisyphus01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesGiftDecline01", "HadesWithPersephoneGift01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0121",
					Text = "This chamber... it once held a prisoner of mine. A mortal king who had attempted to cheat Death! I forced the wretch to heave that boulder up that path forever. He forgave me anyway." },
				{ Cue = "/VO/MelinoeField_1575_B",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Forget him, Father. What purpose does it serve to dwell on some dead mortal now?" },
				{ Cue = "/VO/Hades_0122",
					PreLineAnim = "Hades_Brooding",
					Text = "You misunderstand. The prisoner, he was called Sisyphus the King. His boulder there was like a friend. He... asked his friend to keep me company. Until more company arrived, he said." },
				{ Cue = "/VO/MelinoeField_1576", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well then I'm grateful to that boulder and the king. Chronos must not have accounted for your former prisoners being fond of you." },
				{ Cue = "/VO/Hades_0123",
					PreLineAnim = "Hades_Hello",
					Text = "Oh most of them are not. Some chose to join the Titan's legions and remain here in Tartarus. Not anywhere I cast my gaze, of course." },
			},

			HadesAboutPersephoneAway01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" }, Alive = false },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Hades_0303",
					Text = "Your mother sends you her warmest regards, and regrets that she was unable to join me here this time. Certain matters at the House require {#Emph}her {#Prev}attention, if not mine." },
				{ Cue = "/VO/MelinoeField_4164",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, and please give my regards to Mother, in kind. So you get to be {#Emph}here {#Prev}while she takes care of things {#Emph}there... {#Prev}do you draw lots to determine who does what?" },
				{ Cue = "/VO/Hades_0304",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Drawing lots is how I wound up in this realm, and is not something I have done again. This is simpler, besides: Being here is how I can best ensure your continued success." },
			},

			-- Post-True Ending / -- Post-Ending
			HadesWithPersephone01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0068",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Joyful_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Apprehensive_01", -- doubtful
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01", -- eyes askance
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_01", WaitTime = 1.6 },
					Text = "Oh, Melinoë, you're back! We thought we might find you here... well, Hades did. I never would have guessed." },

				{ Cue = "/VO/Hades_0215",
					Text = "Your Mother and I had looked forward to seeing you again ever since you departed. How have you fared? Are matters in the Crossroads well in hand?" },

				{ Cue = "/VO/MelinoeField_4148",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Everything is more or less all right, Father. It's good to see you in this chamber in far better spirits than before, though... why return to such a place? I'd have thought you'd rather be just about anywhere else." },

				{ Cue = "/VO/Hades_0216",
					PreLineAnim = "Hades_Brooding",
					Text = "The House is partially in order but the rest of Tartarus yet bears the mark of my father's extravagant tastes. Whatever harm he caused our family, undoing his decor shall take longer still!" },

				{ Cue = "/VO/MelinoeField_4149", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Grandfather shall do his part. It also means I get to say hello." },

				{ Cue = "/VO/Hades_0217",
					PreLineAnim = "Hades_Hello",

					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "DeathAreaPoints", SoundName = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY", GiftWaitTime = 0 },

					Text = "Well I shall do my small part then, in the retracing of your steps. Provided I may be of service still." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.7,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_5008", Text = "Soot from the House..." },
					},
				},
			},

			HadesWithPersephone02 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/MelinoeField_4169",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How have the two of you been doing in all this? It must be quite a stressful time, having to get the House and Underworld back in order." },

				{ Cue = "/VO/Hades_0307",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Text = "Oh, it is somewhat less stressful than being imprisoned, fearing the worst for my family and dog, and watching the Underworld become unrecognizable." },

				{ Cue = "/VO/Persephone_0026",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					Text = "It's very different in my case. One moment I was a new mother, and now I'm not... for what it's worth, you were an adorable baby, Melinoë." },

				{ Cue = "/VO/MelinoeField_4170",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You could always try and have another child, I suppose? We have nowhere near the numbers on Olympus, besides." },

				{ Cue = "/VO/Hades_0308",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Augh! {#Prev}Let us not tempt the Fates with such talk, wherever they may be. You and your brother are more than sufficient." },
			},

			HadesWithPersephone03 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/MelinoeField_4154",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How fare the renovations to the House thus far? It was looking rather far along even before I departed." },

				{ Cue = "/VO/Hades_0281",
					Text = "Appearances can be deceiving, as you must already know, Daughter. The initial work is rather quick. Addressing the details takes much, much longer." },

				{ Cue = "/VO/Persephone_0014",
					Speaker = "NPC_Persephone_01",
					-- Portrait = "Portrait_Persephone_Queen_01",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					Text = "Especially if all the details must be exactly as before." },

				{ Cue = "/VO/Hades_0282",
					PreLineAnim = "Hades_Blessing_Short",
					Emote = "PortraitEmoteFiredUp",					
					Text = "And why should we settle for less? Anything that we did not want changed ought to remain as we desired it." },

				{ Cue = "/VO/MelinoeField_4155",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sounds like a big undertaking. Can I do something to assist?" },

				{ Cue = "/VO/Persephone_0015",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					-- PreLineAnim = "Persephone_Greet_Start",
					-- PostLineAnim = "Persephone_Greet_End",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_Calculating_01", WaitTime = 8.0 },

					Text = "Best leave this one to us, Melinoë. We're pleased to see you here! Your father can administer his blessings and take his mind off of everything! Isn't that right, Hades?" },

				{ Cue = "/VO/Hades_0283",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}<Grumble> {#Prev}Just make your choice and go, Daughter." },
			},

			HadesWithPersephoneAboutRenovations01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0284",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Gold, everywhere, {#Emph}pah! {#Prev}The light refracting from it constantly assaults my eyes. This reconstruction shall be interminable! We're nowhere {#Emph}close {#Prev}to finishing the House itself!" },

				{ Cue = "/VO/Persephone_0016",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "It's all right, Hades. Things were quite recently much worse, and we've weathered worse storms. Why all the urgency?" },

				{ Cue = "/VO/Hades_0285",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Hades_Brooding",
					Text = "If not for {#Emph}my {#Prev}sake, then for {#Emph}yours! {#Prev}These grounds ought to be as you always liked. But we shall tolerate my father's taste a while longer, if we must.... Apologies, Melinoë! {#Emph}Erm{#Prev}, here." },
			},

			HadesWithPersephoneAboutLegions01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/MelinoeField_4156",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's really good to see you both here. Do all the Satyrs and such leave you well alone?" },

				{ Cue = "/VO/Hades_0286",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "We're not the ones having to violate the principles of reality as we understand it, Daughter. It seems my father must permit his zealous followers to run free awhile longer to prevent any further {#Emph}misunderstandings {#Prev}between us." },

				{ Cue = "/VO/Persephone_0017",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "But to answer more directly, Melinoë, the Satyrs and such all flee from us on sight. Often with little goatlike screams!" },

				{ Cue = "/VO/Hades_0287",
					PreLineAnim = "Hades_Brooding",
					Text = "I know that you are not so fortunate. The least your mother and I can do is prepare you for the final confrontation that awaits." },
			},

			HadesWithPersephoneAboutGreeting01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "I_Boss01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0292",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "We heard that you were on your way, Daughter. So your mother ensured we each would be here in time to greet you." },

				{ Cue = "/VO/Persephone_0020",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_01", WaitTime = 2.7 },

					Text = "Way to reveal my entire plan, Hades! We just wanted to say hi, Melinoë. Since we can't exactly have you over at the House for now." },

				{ Cue = "/VO/MelinoeField_4159",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hello to each of you in turn. How has everyone been? Zagreus, and all the other Houseservants?" },

				{ Cue = "/VO/Hades_0293",
					PreLineAnim = "Hades_Brooding",
					Text = "They all are back to work; and well we ought, now that we're done exchanging pleasantries. Do rid us of my father's lingering threat, while we rid this place of his horrid styling." },
			},
			HadesWithPersephoneAboutChamber01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0069",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,

					Text = "I asked your father to prioritize the renovation of this chamber, if this is to be the place where we meet up now and again. And do you know what he said?" },

				{ Cue = "/VO/Hades_0372",
					PreLineAnim = "Hades_Brooding",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_LordHades_Averted_01",
					Text = "I merely said we ought to leave this chamber's updating for last... for I would not erase the memory of how it is. Though perhaps it shall remain this way for {#Emph}ages {#Prev}at the current rate." },
			},
			HadesWithPersephoneAboutUnseen01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0079",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,

					Text = "Our daughter, part of the Unseen... officially, Hades and I aren't even supposed to {#Emph}know {#Prev}of you... where you reside... nothing." },

				{ Cue = "/VO/Hades_0373",
					PreLineAnim = "Hades_Brooding",
					Text = "The protection of the Underworld is a responsibility we all share... but in retrospect, Nyx, in her wisdom, took certain additional precautions, yes." },

				{ Cue = "/VO/MelinoeField_4457",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't know how well-kept of a secret the Unseen are at this point. We had to emerge from the shadows once or twice in all this." },

				{ Cue = "/VO/Persephone_0080",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,

					Text = "Nyx herself would be the first to say it's useful for the Underworld to instill in others a certain kind of fear. But I feel so fortunate we know you not just from whispered tales of vengeance, but for who you are, Melinoë." },
			},

			HadesAboutNeoChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus02", "NeoChronosAboutOlympus02" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NeoChronosGift02", "ZeusPalaceAboutTyphonDeath01" },
					},
					OrRequirements =
					{
						{
							{
								SumPrevRuns = 3,
								Path = { "RoomsEntered", "I_Boss01" },
								Comparison = ">=",
								Value = 1,
							},
						},
						{
							{
								SumPrevRuns = 3,
								Path = { "RoomsEntered" },
								TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0305",
					Text = "Has Chronos... my father... has he been amenable to your requirements in all of this? No sudden or discernible changes of behavior or demeanor?" },

				{ Cue = "/VO/MelinoeField_4165",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's been himself... his newer self, that is. Rather contrite, and I daresay enthusiastic about alleviating the negative effects that still linger here and above." },

				{ Cue = "/VO/Hades_0306",
					PreLineAnim = "Hades_Hello",
					Text = "We ought remain on guard nevertheless. Although, my father never could hide his contempt. If you have rid him of that... then he truly is no longer the Titan I once knew." },
			},
			HadesAboutNeoChronos02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HadesAboutNeoChronos01", "NeoChronosAboutNewJob01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/MelinoeField_4171",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How is Grandfather faring in the Isles of the Blessed? I was pleased to learn Lord Uncle Zeus and you were even able to find him an available post there." },

				{ Cue = "/VO/Hades_0309",
					PreLineWait = 0.35,
					Text = "...My father is, surprisingly, quite competent in this newfound regard, at least thus far. The work itself is not too burdensome, although the residents of the Isles of the Blessed can be very demanding." },

				{ Cue = "/VO/MelinoeField_4172",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So Grandfather is looking after the most vaunted of Elysium, making certain that their needs are met, that sort of thing?" },

				{ Cue = "/VO/Hades_0310",
					Text = "Essentially, that is correct. He is attentive to detail, and not prone to forgetfulness. We shall be monitoring him to ensure he remains that way." },
			},

			HadesAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "NemesisTakeRoomExitRecord", "I_Story01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0386",
					Text = "Most fear to tread within this chamber, but quite recently the visage of Nyx herself charged in. Saluted in a huff and strode on past! One of Nyx's daughters?" },

				{ Cue = "/VO/MelinoeField_5028",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That sounds like Nemesis. She's wanted to get her hands on Chronos practically more than I ever did. Going after the traces of him now, the same as me. We have a thing going." },

				{ Cue = "/VO/Hades_0387",
					PreLineAnim = "Hades_Hello",
					Text = "That almost makes me feel some pity for those traces, then. To have to face Retribution or Vengeance, if not both." },
			},

			HadesWithPersephoneAboutHypnosWakeUp01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0294",
					Text = "We've you to thank for the return of Hypnos, I suppose. Although it took his return for me to realize that he was gone." },

				{ Cue = "/VO/Persephone_0021",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "But that's only because we've not been taking in as many newcomers as we once did. Isn't that right, Hades?" },

				{ Cue = "/VO/Hades_0295",
					PreLineAnim = "Hades_Brooding",
					Text = "The court has remained closed! Nevertheless, there are growing numbers of Shades awaiting their turns, and we require Hypnos to keep them orderly and informed." },

				{ Cue = "/VO/Persephone_0022",
					Speaker = "NPC_Persephone_01",
					-- Portrait = "Portrait_Persephone_Queen_01",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					Text = "He's going to have difficulty keeping all of them at bay if there's no telling when court shall reopen, though." },

				{ Cue = "/VO/Hades_0296",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Text = "{#Emph}Augh{#Prev}, we need not bore our daughter with administrative drudgery. The point was merely that this missing son of Nyx has now been located. One fewer matter to resolve." },
			},

			HadesWithPersephoneAboutZagreusFight01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0311",
					Text = "Did your mother and I hear correctly that you and your brother clashed? In the midst of Elysium for all to see...?" },

				{ Cue = "/VO/MelinoeField_4376",
					Emote = "PortraitEmoteSurprise",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, Father, it's not what you think! It was what you could call an exhibition match; a friendly challenge, nothing more. Though Zagreus did not go easy on me." },

				{ Cue = "/VO/Hades_0312",
					PreLineAnim = "Hades_Hello",
					Text = "A shrewd decision on the boy's part, then, or more likely it was yours. For all the troubles in the Underworld, this type of {#Emph}exhibition match{#Prev}, as you refer to it, may be exactly what the Shades require." },

				{ Cue = "/VO/Persephone_0027",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "{#Emph}A morale boost! {#Prev}I suppose they do enjoy this type of violent entertainment over there. Well, as long as Melinoë and Zagreus are open to it..." },

				{ Cue = "/VO/Hades_0313",
					PreLineAnim = "Hades_Hello",
					Text = "You trained with the Witch of the Crossroads, he trained with the greatest warrior that ever fought in mortal wars. Who is superior shall perhaps be subject to debate." },
			},

			HadesWithPersephoneAboutBlessings01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0024",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "You have my blessings as well, you know that, don't you, Melinoë? Unfortunately, I'm not supposed to offer you the more-tangible kind while we're cleaning up after Chronos." },

				{ Cue = "/VO/Hades_0301",
					PreLineAnim = "Hades_Hello",
					Text = "Surely my own blessings shall suffice? Our daughter has already faced and vanquished this Titan many times... there is no need to alter what has already been working well." },

				{ Cue = "/VO/MelinoeField_4163",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Simply seeing you two is enough to carry me to the end. Though I'm certain Mother's blessings would have made me even stronger. Power over life and death and such...!" },

				{ Cue = "/VO/Persephone_0025",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Well, when you put it {#Emph}that {#Prev}way... I suppose I take after my own mother more than I sometimes let on." },

				{ Cue = "/VO/Hades_0302",
					Text = "Daughter... your mother brought life to this realm where it never should have been able to take hold, and we are richer for it." },
			},
			HadesWithPersephoneAboutKeepsake01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "HadesAndPersephoneKeepsake" },
							},
						},
						{
							{
								Path = { "CurrentRun", "Hero", "TraitDictionary" },
								HasAny =
								{
									"HadesLifestealBoon",
									"HadesCastProjectileBoon",
									"HadesPreDamageBoon",
									"HadesChronosDebuffBoon",
									"HadesInvisibilityRetaliateBoon",
									"HadesDeathDefianceDamageBoon",
									"HadesManaUrnBoon",
								},
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0083",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "That little Pom we gave you. We commissioned a very small number using only the finest gemstones, and always meant for you to have one once you were of age..." },

				{ Cue = "/VO/MelinoeField_4459",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, surprise! And thank you. Not only is it beautiful, but it makes me feel more connected to the two of you." },

				{ Cue = "/VO/Persephone_0084",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Poms are said to have that effect. One could eat just a handful of their seeds and never want to leave the Underworld again!" },
			},
			HadesWithPersephoneAboutPersephoneAspect01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobImpulseAspect" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0087",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "The Skull Revaal... Nyx once offered it to me for my protection, just in case. I never would have thought it would protect me even while not in my care." },

				{ Cue = "/VO/MelinoeField_4461",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Would you like it back at this point, Mother? Perhaps my time as Revaal's bearer is drawing to a close now that you're back." },

				{ Cue = "/VO/Persephone_0088",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Well, whether the Fates already predetermined this or I'm deciding it right now, no thank you. If the Argent Skull has gotten you {#Emph}this {#Prev}far, then you two make a proper team." },
			},

			HadesWithPersephoneAboutDemeter01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "DemeterGift08", "HadesWithPersephoneGift06" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0095",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "Sometimes I wish we could spend more time together, you know? But then I recall how it was for {#Emph}me {#Prev}growing up. Just... don't forget we're here if you need anything." },

				{ Cue = "/VO/MelinoeField_4467",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "Of course I won't. How was it living with Grandmother? She seems so intense, and capable... I like her a lot." },

				{ Cue = "/VO/Persephone_0096",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "I'm glad. Your Grandmother Demeter and I, we had our difficulties now and then, but it's been better since I moved down here. My grand conclusion from it all is simply that children need their space... as hard as it is to let them go." },
			},

			HadesWithPersephonePostEpilogue01 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Hades_0288",
					Text = "We heard of the return of the Three Fates. How much you had to do with it shall be for you to know, but tell us... were they in good spirits, at the least?" },

				{ Cue = "/VO/MelinoeField_4157",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They seemed to be. Clotho, who spoke the most by far, she seemed in quite a cheery mood, now that you mention it! So much so that I have trouble imagining her otherwise..." },

				{ Cue = "/VO/Hades_0289",
					Portrait = "Portrait_LordHades_Averted_01",
					Text = "Then we are fortunate, perhaps... for they can be a temperamental bunch. Their moods may not solely dictate the nature of their weavings, but certainly must correlate." },

				{ Cue = "/VO/Persephone_0018",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "We were told that they would cease their weavings for a while. You don't believe it, do you, though, Hades...?" },

				{ Cue = "/VO/Hades_0290",
					PreLineAnim = "Hades_Hello",
					Text = "No, absolutely not. Although I welcome each of you to draw whichever conclusions you see fit." },
			},
			HadesWithPersephonePostEpilogue02 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/Persephone_0019",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "Melinoë, what do you make of this new age the Fates foretold? You know you have some mortal blood in you... perhaps it's for the best." },

				{ Cue = "/VO/MelinoeField_4158",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We did all right with the Fates seemingly leaving everything to us... so if that's the way of things moving forward, I'm open to it. Though, what happens to the Underworld, if the gods are to hold less sway?" },

				{ Cue = "/VO/Hades_0291",
					PreLineAnim = "Hades_Hello",
					Text = "We shall adapt, as we have always done. But unless this {#Emph}new age {#Prev}causes mortals to be relieved of their defining trait — that they all perish, soon enough — then I should think what we do here shall always serve a vital purpose." },
			},
			HadesWithPersephonePostEpilogue03 =
			{
				Partner = "NPC_Persephone_01",
				PlayOnce = true,
				UseableOffSource = true,
				InteractDistance = 300,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HadesWithPersephonePostEpilogue01", "HecatePostEpilogue01", "HadesWithPersephoneGift06" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesPersephoneGreeting,

				{ Cue = "/VO/MelinoeField_4464",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Do you two ever... do you have opportunity to speak with the Witch of the Crossroads... with Hecate, now and again?" },

				{ Cue = "/VO/Persephone_0091",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Given her charge, we're not really supposed to be seen sipping Ambrosia together at this point, though the same is true of you. We do hear about her but respect her privacy." },

				{ Cue = "/VO/MelinoeField_4465",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh I see, well... anyhow, I think... that it would mean a lot to her to hear from you every so often, if you don't mind? She fought so hard for your return... harder than anyone." },

				{ Cue = "/VO/Persephone_0092",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Hahah{#Prev}, well. I think we can find a way to get the occasional message through the veil, right, Hades? Hecate shall always have our gratitude. She saved our little daughter, after all." },
			},

			-- Repeatable
			HadesChat01 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0036",
					PreLineAnim = "Hades_Brooding",
					Text = "Cease with this foolishness, Daughter. There is no stopping him. He is inevitability itself." },
			},
			HadesChat02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0037",
					Text = "You risk too much by visiting me here." },
			},
			HadesChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0038",
					Text = "My son would never listen to me; I was a fool to think it a distinctive trait." },
			},
			HadesChat04 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
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
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0099",
					Text = "I am of little use like this. You need not stray from your path on my account." },
			},
			HadesChat11 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0100",
					Text = "Hold nothing back against the Titan. That you are family matters not to him." },
			},
			HadesChat12 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0104",
					Text = "We have anticipated your arrival, ever since the dog bounded in here." },
			},
			HadesChat16 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0105",
					Text = "Go, take your vengeance. Our family, we've more than enough to spare." },
			},
			-- 17 intentionally skipped
			HadesChat18 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0111",
					Text = "These shackles sap me of my force of will; but not entirely." },
			},
			HadesChat20 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0112",
					Text = "This is not how I imagined my daughter would spend the evenings of her youth..." },
			},

			-- post true ending
			HadesPostTrueEndingChat01 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0316",
					Text = "These blessings are mere trifles, but if they have been effective, so be it." },
			},
			HadesPostTrueEndingChat02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					-- Hades doesn't necessarily know
					{
						-- PathFalse = { "CurrentRun", "EnemyKills", "Zagreus" }
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0320",
					Text = "Zagreus sends his regards. The Underworld has kept him busy recently." },
			},
			HadesPostTrueEndingChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0321",
					Text = "What my father did to Tartarus is a disgrace we shall correct in time..." },
			},
			HadesPostTrueEndingChat04 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0327",
					Text = "If there is something more that we can do to facilitate your efforts, merely ask." },
			},
			HadesPostTrueEndingChat05 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0330",
					Text = "We trust that the Witch of the Crossroads and the rest are lately doing well?" },
			},
			HadesPostTrueEndingChat06 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0331",
					Text = "My father may be different now, but if any old trace of him remains, destroy it." },
			},
			HadesPostTrueEndingChat07 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0334",
					Text = "Let us ensure that nothing like what we have withstood shall ever again transpire." },
			},
			HadesPostTrueEndingChat08 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0335",
					Text = "I shall always have wrath to spare for any remnants of my father's former self." },
			},
			HadesPostTrueEndingChat09 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0318",
					Text = "Matters in the House are well in hand. We trust that all is likewise well with you." },
			},
			HadesPostTrueEndingChat10 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "N" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,
				{ Cue = "/VO/Hades_0324",
					Text = "Your work has drawn you to the surface more and more, so it is good to see you here." },
			},

			HadesWithPersephonePostTrueEndingChat01 =
			{
				Partner = "NPC_Persephone_01",
				UseableOffSource = true,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Persephone_0061",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "You must have been an adorable little girl, but you're not so bad right now." },
			},
			HadesWithPersephonePostTrueEndingChat02 =
			{
				Partner = "NPC_Persephone_01",
				UseableOffSource = true,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Persephone_0062",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "One of these days or nights we'll have to tidy up this particular chamber, Hades..." },
			},
			HadesWithPersephonePostTrueEndingChat03 =
			{
				Partner = "NPC_Persephone_01",
				UseableOffSource = true,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.HadesGreeting,

				{ Cue = "/VO/Persephone_0065",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Go show that possibility of Chronos whose side of the family is really in charge here." },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_1499", UsePlayerSource = true,
					Text = "Father, while I know this wasn't necessarily permitted, I thought if maybe it would be of any comfort at all, that I might offer you this Nectar?" },
				{ Cue = "/VO/Hades_0110",
					PreLineAnim = "Hades_Brooding",
					PostLineThreadedFunctionName = "GiftPointRefundPresentation",
					Text = "Exactly like your brother, blast... I fear I'm not in any mood or state for such a thing. Concern yourself not with my comfort, but with the target of your wrath." },
			},

			HadesWithPersephoneGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HadesGiftHint",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesWithPersephone01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01" } },
					},
				},
				{ Cue = "/VO/MelinoeField_4206", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "Mother, Father, I'm so grateful to have you back in my life. We've so much to catch up on, but all the time in the world. For now, this is just a small House-warming gift." },

				{ Cue = "/VO/Persephone_0070",
					Emote = "PortraitEmoteSurprise",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_Joyful_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_01", WaitTime = 2.5 },
					Text = "Oh {#Emph}thank {#Prev}you, this is {#Emph}perfect! {#Prev}Our supply back at the House has disappeared... perhaps Chronos had a taste for it." },

				{ Cue = "/VO/Hades_0218",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "Nectar from the highest peaks... to think we once forbade this substance here, though that was well before your time. Thank you, Daughter. And we have something here for you, in turn. A small token, but a symbol of our family as well." },
			},
			HadesWithPersephoneGift02 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift01" },
					},
				},
				{ Cue = "/VO/Persephone_0071",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					-- Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
					-- Portrait = "Portrait_Persephone_Queen_Joyful_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					Text = "Thank you, Daughter. We could certainly make use of this. Hades had a particular idea for it, in fact." },

				{ Cue = "/VO/Hades_0219",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "If you would permit it, Daughter... I would offer up such Nectar to the Shades assisting in the Underworld renovations underway. As an added token of appreciation for their toil. Is that acceptable to you?" },

				{ Cue = "/VO/MelinoeField_4377", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "Of course, Father, it's yours to do with as you please. And I can think of no finer purpose for it than to reward those Shades who have remained loyal to us through all this." },
			},
			HadesWithPersephoneGift03 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift02" },
					},
				},
				{ Cue = "/VO/Persephone_0072",
					Speaker = "NPC_Persephone_01",
					Portrait = "Portrait_Persephone_Queen_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_01", WaitTime = 2.5 },
					Text = "Such a fine bottle. We graciously accept! You know, you remind me of your brother sometimes..." },

				{ Cue = "/VO/Hades_0220",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					PreLineWait = 0.35,
					Text = "These customs that we share from those above... I ask that you not follow our traditions blindly. Such traditions may be partially responsible for the many mistakes that led us to this point." },

				{ Cue = "/VO/MelinoeField_4378", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I share your cautious feeling about this, Father, but... of the many traditions of the gods, the act of giving Nectar to those we care for seems one of the better ones, in my estimation." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.42,
						ObjectTypes = { "NPC_Hades_01", "NPC_Hades_02" },

						{ Cue = "/VO/Hades_0221", Text = "...Perhaps so." },
					},
				},
			},
			HadesWithPersephoneGift04 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift03" },
					},
				},
				{ Cue = "/VO/Hades_0222",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Text = "You ought have many others who would welcome such a gift. To have been raised in the seclusion of those Crossroads... I fear it must have been a very solitary life. More so than one would like." },

				{ Cue = "/VO/Persephone_0073",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					Speaker = "NPC_Persephone_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",
					Text = "Solitude is not always such a bad thing, but... certainly it couldn't have been easy on you." },

				{ Cue = "/VO/MelinoeField_4379", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You need have no such fear. Growing up in the Crossroads was never easy, but... I never felt alone. I always had somebody or something to confide in... I would speak sometimes even to a fountain that we have in your honor." },

				{ Cue = "/VO/Hades_0223",
					PreLineWait = 0.35,
					PreLineAnim = "Hades_Hello",
					Text = "Your words are not as persuasive to me as either one of us would like. If you had grown up in my House, you would have been showered with attention, not forced to harden your hands with toil... especially for one so young." },

				{ Cue = "/VO/MelinoeField_4380", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have never regretted what I had to do, Father. And what friendships I have, I cherish. Perhaps I could have grown up with more, but I had everything I needed. Besides my parents. And brother and dog." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectTypes = { "NPC_Persephone_01" },

						{ Cue = "/VO/Persephone_0074", Text = "And now you have us, too." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4381", Text = "Thank the Fates." },
					},
				},
			},
			HadesWithPersephoneGift05 =
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift04" },
					},
				},
				{ Cue = "/VO/MelinoeField_4382", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "I know some of the Nectar's going to our loyal Shades, but I would like for you and Mother to enjoy this one yourselves. Whenever the occasion fits, just... sometime." },

				{ Cue = "/VO/Hades_0225",
					PreLineAnim = "Hades_Blessing_Short",
					Text = "The occasion for such pleasantries... perhaps after our Underworld renovations are complete, and we have taken proper stock of our resources and the Shades, then finally we may accept a moment of reprieve." },

				{ Cue = "/VO/Persephone_0029",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					Speaker = "NPC_Persephone_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "Oh, stop it, Hades. Surely we can make good on Melinoë's request sooner than that. You know better than anyone that the toil never ends, so the moments of reprieve have to be seized when they present themselves." },

				{ Cue = "/VO/Hades_0226",
					Portrait = "Portrait_LordHades_Averted_01",
					PreLineAnim = "Hades_Brooding",
					Text = "Thus speaks the Queen. Thank you for this, Daughter. But you truly need not spare such thoughts on us. We have each other once again. I myself have want for nothing more." },
			},
			-- bond forged
			HadesWithPersephoneGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedHadesPersephone",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "TrueEnding01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift05" },
					},
				},
				{ Cue = "/VO/MelinoeField_4383", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "Now that you've had a Nectar for a small occasion of some sort, I did also want to give you this. For a more-special time, perhaps long from now, after we've practically forgotten how it was living apart, and the circumstances call for merriment." },

				{ Cue = "/VO/Persephone_0075",
					Portrait = "Portrait_Persephone_Queen_01",
					Speaker = "NPC_Persephone_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,
					Text = "This is... Ambrosia, and with such a hue as could have only come from the source... Daughter, {#Emph}thank you...!" },

				{ Cue = "/VO/Hades_0227",
					PreLineAnim = "Hades_Brooding",
					Text = "Ambrosia from the heavens themselves... I scarce remember its savor. But I never shall forget what it was like living apart. Nor should any of us long for Time to take the pain of it away. Let us remember always how we reached this point together." },

				{ Cue = "/VO/MelinoeField_4384", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When I was little, Lady Hecate said something similar... that the pain of the past shall always linger, though assert itself less frequently with age. Well then, perhaps we ought to celebrate the memory itself. An aeon from now, for all I care." },

				{ Cue = "/VO/Persephone_0076",
					Portrait = "Portrait_Persephone_Queen_Calculating_01",
					Speaker = "NPC_Persephone_01",
					PreLineAnim = "Persephone_Greet_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_Greet_End",
					PostLineAnimTarget = 731286,
					Text = "A celebration an aeon from now would leave us with plenty of time for preparation, so... why not, Hades? Ambrosia such as this ought to age nicely till then." },

				{ Cue = "/VO/MelinoeField_4385", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please let me know if I can help with any of the planning when the time comes. Or if there's anything else I can do while you're getting the House back in order." },

				{ Cue = "/VO/Persephone_0077",
					Portrait = "Portrait_Persephone_Queen_01",

					Speaker = "NPC_Persephone_01",
					PreLineAnim = "Persephone_DismissA_Start",
					PreLineAnimTarget = 731286,
					PostLineAnim = "Persephone_DismissB_End",
					PostLineAnimTarget = 731286,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Parents_01", Icon = "Keepsake_HadesAndPersephone" },

					Text = "It's we who should be asking this of you. When you were born, Hades and I thanked the Fates that we were blessed with such a child. But we had positively no idea..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4207_B", Text = "Thank you both...!" },
					},
				},

			},


		},

		GiftGivenVoiceLines =
		{
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Persephone_01",

				{ Cue = "/VO/Persephone_0028", Text = "Please, take it." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_4207", Text = "Thank you both for this." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "HadesSpokeRecently", Time = 12 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Hades_Field_01",
				PreLineAnim = "Hades_Brooding",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce" },
					},
				},

				{ Cue = "/VO/Hades_0258", Text = "I have no mood for this." },
				{ Cue = "/VO/Hades_0259", Text = "How like your brother.", PlayFirst = true },
				{ Cue = "/VO/Hades_0260", Text = "Cease this." },
				{ Cue = "/VO/Hades_0261", Text = "Daughter?" },
				{ Cue = "/VO/Hades_0046", Text = "Oh, blood and darkness..." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Hades_Field_01",
				PreLineAnim = "Hades_Brooding",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = { "FrogFamiliarLand", "CatFamiliarPounce" },
					},
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
	},

	-- @ ending
	NPC_Hades_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "NPC_Hades_Field_01",
		Portrait = "Portrait_Hades_Past_01",
		EmoteOffsetY = -280,
		EmoteOffsetX = 45,
		AnimOffsetZ = -50,
		Groups = { "NPCs" },
		SubtitleColor = Color.HadesVoice,
		SpeakerName = "Hades",
		LoadPackages = { "Hades", },
	},

	-- @ ending
	NPC_Hades_02 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "NPC_Hades_Field_01",
		Portrait = "Portrait_LordHades_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.HadesVoice,
		SpeakerName = "Hades",
		LoadPackages = { "Hades", },

		SetupEvents =
		{
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_ChronosFlashback01" },
					},
				},
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAnimation = "HadesFlashback_Story_Idle",
					ThingProperties =
					{
						GrannyModel = "Hades_Mesh",
					},
				},
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractCooldown = 14,
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusTrueEnding01" },
			},
		},
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_1566", Text = "Be well, Lord Father." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				ObjectType = "NPC_Hades_02",

				{ Cue = "/VO/Hades_0253", Text = "Greetings.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Hades_0254", Text = "Hail, Daughter.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_5165" },
						},
					},
				},
				{ Cue = "/VO/Hades_0255", Text = "Darkness suits me best.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Hades_0256", Text = "Go unseen.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1566", "/VO/MelinoeField_1567", "/VO/Melinoe_1705" },
						},
					},
				},
				{ Cue = "/VO/Hades_0257", Text = "Shadows conceal you.",
					PreLineAnim = "Hades_Unchained_Hello",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1567", "/VO/Melinoe_1703" },
						},
					},
				},

				{ Cue = "/VO/Hades_0127", Text = "{#Emph}Hrm.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1566", "/VO/MelinoeField_1566", "/VO/Melinoe_1709", "/VO/Melinoe_1700", "/VO/Melinoe_1704", },
						},
					},
				},
				{ Cue = "/VO/Hades_0136", Text = "To shadow, you'll return.",
					PlayFirst = true,
					PreLineAnim = "Hades_Unchained_Hello",
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
			HadesTrueEnding01 =
			{
				Partner = "NPC_Hecate_Story_01",
				PlayOnce = true,
				UseableOffSource = true,
				UseText = "UseListenNPC",
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				SkipContextArt = true,
				OnQueuedFunctionName = "OverwriteSelf",
				OnQueuedFunctionArgs =
				{
					AllowSpecialInteractInPartnerConversation = true,
					BlockChatting = true,
				},

				{ Cue = "/VO/Hades_0210",
					Text = "...You are as certain in this as is she, Witch of the Crossroads. It is no burden to you, then? To look after her, and... care for her, as we would have, had none of this occurred...?" },

				{ Cue = "/VO/HecateField_0326",
					Source = "NPC_Hecate_01",
					PreLineAnim = "HecateHubGreet",
					-- PreLineAnimTarget = 774458, -- Chronos
					PreLineAnimTarget = 774366, -- Hecate
					Text = "I am not her mother, my lord; no substitute for all that she has lost. Yet I once swore to you that no harm shall come to her, and that vow remains. And I shall always care for her, whether she resides with me or not." },

				{ Cue = "/VO/Hades_0211",
					PreLineAnim = "Hades_Unchained_Hello",
					-- PreLineAnim = "Hades_Unchained_Brooding",
					-- PreLineAnim = "Hades_Unchained_Blessing_Short",
					Text = "And you, Melinoë? Your mind is set? Though I am unsurprised, I nonetheless must ask, for your decision here is irreversible by laws much older than my own. To serve the Unseen..." },

				{ Cue = "/VO/MelinoeField_5065",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...is to serve in shadow. I know full well, Father, and do not make this decision lightly, but... I can't leave the Crossroads. Especially when my duty isn't yet complete, given what Chronos said about these other possibilities we face." },

				{ Cue = "/VO/Hades_0383",
					-- PreLineAnim = "Hades_Unchained_Brooding",
					Text = "This new venture of his... such a toil for you, to have been instrumental in altering time as we know it, only to be charged with keeping it that way." },

				{ Cue = "/VO/MelinoeField_5066",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh I don't mind. This matter is close to my heart. I suppose I'll either be a Time {#Emph}Keeper {#Prev}or a Time {#Emph}Killer{#Prev}, depending on if Chronos continues to be on his best behavior." },

				{ Cue = "/VO/Hades_0396",
					Text = "It is as though he lived a different life up to this point. I still find it rather difficult to accept. Your uncle Zeus shall have to judge for himself." },

				{ Cue = "/VO/MelinoeField_5067",
					UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Pleased_01",
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					Text = "Lord Uncle has our full report... we'll see what he decides. All this is going to be an adjustment, isn't it? But I'll see you again soon, and Mother, and Cerberus, and Zagreus. Our responsibilities should mean our paths cross plenty often." },

				{ Cue = "/VO/Hades_0385",
					PreLineAnim = "Hades_Unchained_Blessing_Short",
					Text = "All part of what we now shall do! Cerberus has already taken to rampaging through the Fields of his own accord, and your mother and I shall not be far. As for your brother, he always turns up." },

				{ Cue = "/VO/MelinoeField_4985",
					UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelinoeSalute",
					PreLineAnimTarget = "Hero",
					PostLineFunctionName = "DeathAreaRestoredUpdateHallwayBlocks",
					Text = "I'll be counting on it. I'm glad you're back, Father." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						ObjectType = "NPC_Hades_02",

						{ Cue = "/VO/Hades_0251", Text = "Shadows conceal you." },
					},
				},
			},

			HadesHideAndSeek01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				SkipContextArt = true,
				StatusAnimation = false,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.HadesZagreusChatting,

				{ Cue = "/VO/Zagreus_0434",
					Portrait = "Portrait_Zag_Default_02",
					Speaker = "NPC_Zagreus_Past_01",
					Text = "Well this is a rare treat. The both of you together in this lounge! What brings you here, Grandfather?" },

				{ Cue = "/VO/Chronos_1413",
					Source = "NPC_Chronos_01",
					Speaker = "NPC_Chronos_01",
					Portrait = "Portrait_Chronos_Pained_01",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					-- PreLineAnimTarget = 774458, -- Chronos
					Text = "I yet seek the girl's whereabouts, is what! I have turned over this residence in its entirety, and found nary a sign! She is already as elusive as you always were, Hades." },

				{ Cue = "/VO/Hades_0392",
					Portrait = "Portrait_Hades_Past_01",
					Speaker = "NPC_LordHades_01",
					Text = "That or your old senses have dulled. She went running over there by the Head Chef, where she yet lingers in silence. Go, before her patience wears thin." },

				{ Cue = "/VO/Zagreus_0435",
					Portrait = "Portrait_Zag_Empathetic_02",
					Speaker = "NPC_Zagreus_Past_01",
					PostLineFunctionName = "UpdateChronosFlashback",
					Text = "{#Emph}Erm... {#Prev}what Father meant to say was, {#Emph}no, we've no idea where my good son's little sister is! {#Prev}She could be anywhere! Have you tried checking the administrative chamber? Gods, I sound like Hypnos." },
				EndVoiceLines = 
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,

						{ Cue = "/VO/Chronos_1414", Text = "I do appreciate the hint." },
					},
					{
						PreLineWait = 0.25,
						ObjectTypes = { "NPC_Zagreus_Past_01", "NPC_Zagreus_01" },

						{ Cue = "/VO/Zagreus_0436", Text = "Keep up the good work!" },
					},
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,

						{ Cue = "/VO/Chronos_1415", Text = "Where are you, my girl...?" },
					},
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Melinoe_Story_01",
						Speaker = "PlayerUnit",
						SkipAnim = true,

						{ Cue = "/VO/MelinoeField_5053", Text = "{#Emph}<Laugh>" },
					},
				},
			},

		},
	},

	-- Persephone, Id = 731286 (in I_Story01)
	NPC_Persephone_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		SubtitleColor = Color.PersephoneVoice,
		Portrait = "Portrait_Persephone_Queen_01",
		LoadPackages = { "Persephone", },
		SpeakerName = "Persephone",
		Groups = { "NPCs" },
		EmoteOffsetY = -240,
		AnimOffsetX = 5,

		InvincibubbleScale = 1.1,
		
		RepulseOnMeleeInvulnerableHit = 150,

		UseTextSpecial = "PersephoneUseTextSpecial",
		SpecialInteractFunctionName = "HugPersephone",
		SpecialInteractCooldown = 12,
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PersephoneTrueEnding01" },
			},
		},
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_5064", Text = "Be well, Mother!" },
				{ Cue = "/VO/Melinoe_5065", Text = "Thank you for being here.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_5067", Text = "Take care, Mother." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.28,
					-- PreLineAnim = "Persephone_Greet_Start",
					ObjectType = "NPC_Persephone_01",

					{ Cue = "/VO/Persephone_0050", Text = "You too, my baby girl.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5064" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0051", Text = "Only because of you.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5065" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0052", Text = "Oh, Daughter...",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5066" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0053", Text = "You take care too.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5067" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0054", Text = "{#Emph}<Sigh>",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_5066", "/VO/Melinoe_5067" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0055", Text = "Hello!",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0056", Text = "The old one at least.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1700" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0057", Text = "Oh, thank you.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0058", Text = "We could use it.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1704" },
							},
						},
					},
					{ Cue = "/VO/Persephone_0059", Text = "We'll need it.",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_1705" },
							},
						},
					},
				},		
			},
		},

		InteractTextLineSets =
		{
			PersephoneTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				Partner = "NPC_Chronos_02",
				SkipContextArt = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false, -- played via script
				OnQueuedFunctionName = "OverwriteSelf",
				OnQueuedFunctionArgs =
				{
					AllowSpecialInteractInPartnerConversation = true,
					BlockChatting = true,
				},

				{ Cue = "/VO/Persephone_0010",
					PreLineThreadedFunctionName = "HugPersephone",
					PreLineThreadedFunctionArgs = { Silent = true },
					-- Portrait = "Portrait_Persephone_Queen_01",
					-- Portrait = "Portrait_Persephone_Queen_FiredUp_01",
					-- Portrait = "Portrait_Persephone_Queen_Calculating_01",
					Portrait = "Portrait_Persephone_Queen_Joyful_01",
					-- PreLineAnim = "Persephone_Greet_Start",
					-- PostLineAnim = "Persephone_Greet_End",
					-- PreLineAnim = "Persephone_DismissA_Start",
					-- PostLineAnim = "Persephone_DismissB_End",

					Text = "My beautiful daughter... I still can hardly believe it's you! It's said that children grow up in the mere blink of an eye, but... this was too fast. {#Emph}Much {#Prev}too fast..." },

				{ Cue = "/VO/MelinoeField_3887_B", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Pleased_01",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineWait = 0.35,

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 5 },

					Text = "Oh, Mother... I got here as quickly as I could, but... it took some time. Didn't it, Grandfather...?" },

				{ Cue = "/VO/Chronos_1400",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					PreLineWait = 0.5,
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnimTarget = 774458, -- Chronos
					Text = "...It did. Queen Persephone, would that I could give back all the moments and the memories which I denied you, in my fervor. Those who say Time can be so cruel... they are right." },

				{ Cue = "/VO/Persephone_0011",
					Portrait = "Portrait_Persephone_Queen_FiredUp_01",

					Text = "They also say Time heals all wounds, though I have yet to verify that claim... especially with all our Houseservants still recovering. Forgiveness in our family is hard-won, Chronos. Although it seems you've all eternity to try." },

				{ Cue = "/VO/MelinoeField_4986", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Default_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And for that matter, all eternity to locate the Three Fates. Still no sign of them at all, even with Nyx's aid?" },

				{ Cue = "/VO/Chronos_1427",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					PreLineWait = 0.35,
					Text = "None. I cast them into the abyss... had I but known precisely where, they would have known how to get back. Yet if my hypothesis about other such possibilities as I experienced is correct... we may find them." },

				{ Cue = "/VO/MelinoeField_5068", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

					Text = "This hypothesis of yours about the flow of Time... you're certain we need to keep conditions similar to how they've been to verify it?" },

				{ Cue = "/VO/Chronos_1428_B",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					PreLineWait = 0.35,
					Text = "Why, yes! That is the only way to test a theory properly. For it seems that my own understanding of the flow of Time was flawed..." },
						
				{ Cue = "/VO/MelinoeField_4987", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 2.1 },

					Text = "Something to rectify. {#Emph}Erm{#Prev}, Mother...? Thank you for your hospitality and everything. It's been wonderful to see you." },

				{ Cue = "/VO/Persephone_0012_B",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Persephone_Queen_Calculating_01", WaitTime = 5 },

					Text = "You, too! Knowing how things go, we'll see each other again before we know it. And you're dismissed as well, Chronos. You've done your part for now, however small." },

				{ Cue = "/VO/Chronos_1382",
					Source = "NPC_Chronos_02",
					Speaker = "NPC_Chronos_01",
					PreLineWait = 0.35,
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					PreLineAnimTarget = 774458, -- Chronos
					Text = "You have my gratitude, O Queen, and my pledge. At least this House is mostly to your preference again. Beyond these halls, of course, much more is to be done." },

				{ Cue = "/VO/MelinoeField_3889", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "DeathAreaRestoredUpdateHallwayBlocks",
					Text = "Yes, well... Father shall see to the ongoing Underworld renovations. Sounds as though he's done this sort of thing before. As for us, our chariot is here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Chronos_02",
						{ Cue = "/VO/Chronos_1027", Text = "That it is. I am prepared." },
					},
				},
			},

			-- partner conversations
			HadesWithPersephone01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephone02 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephone03 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutHypnosWakeUp01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutZagreusFight01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutRenovations01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutLegions01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutGreeting01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutBlessings01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutKeepsake01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutPersephoneAspect01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				SkipPreNarrativeUnequip = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutChamber01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutUnseen01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephoneAboutDemeter01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephonePostEpilogue01 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephonePostEpilogue02 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephonePostEpilogue03 =
			{
				Partner = "NPC_Hades_Field_01",
				PlayOnce = true,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},

			-- repeatable
			HadesWithPersephonePostTrueEndingChat01 =
			{
				Partner = "NPC_Hades_Field_01",
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephonePostTrueEndingChat02 =
			{
				Partner = "NPC_Hades_Field_01",
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			HadesWithPersephonePostTrueEndingChat03 =
			{
				Partner = "NPC_Hades_Field_01",
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},

		},
	},

	-- Cerberus, Id = 506405
	NPC_Cerberus_Field_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "NPC_Cerberus_01",
		Portrait = "Portrait_Cerberus_Default_01",
		LoadPackages = { "Cerberus", },
		AnimOffsetX = 50,
		AnimOffsetZ = -250,
		Groups = { "NPCs" },

		UseText = "UseCerberus",
		UseTextSpecial = "UseCerberusSpecial",
		UseTextTalkAndGift = "UseCerberusAndGift",
		UseTextTalkAndSpecial = "UseCerberusAndSpecial",
		UseTextTalkGiftAndSpecial = "UseCerberusGiftAndSpecial",
		SpecialInteractFunctionName = "AttemptPetCerberusThread",

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					UseTextSpecial = "UseCerberusSpecial_True",
					UseTextTalkAndSpecial = "UseCerberusAndSpecial_True",
					UseTextTalkGiftAndSpecial = "UseCerberusGiftAndSpecial_True",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
		},

		InteractTextLineSets =
		{
			CerberusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				UseInitialInteractSetup = true,
				StatusAnimation = false,
				-- PreEventFunctionName = "PetCerberus",
				{ Cue = "/VO/Storyteller_0501", PreLineWait = 0.3, StartSound = "/VO/CerberusSnarls", LineHistoryName = "Speaker_Homer",
					IsNarration = true,
					Text = "{#Emph}The Infernal Beast that wrought such terror in the Mourning Fields now sits there calmly and expectantly, not for the Princess of the Underworld, but someone else." },
			},
			CerberusMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				UseInitialInteractSetup = true,
				StatusAnimation = false,
				-- PreEventFunctionName = "PetCerberus",
				{ Cue = "/VO/Storyteller_0125", PreLineWait = 0.3, StartSound = "/VO/CerberusSnarls", LineHistoryName = "Speaker_Homer",
					IsNarration = true,
					Text = "{#Emph}Ferocious Cerberus yet guards his master dutifully, having discovered him within these depths." },
			},

			-- Repeatable
			CerberusChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0126", PreLineWait = 0.3, StartSound = "/VO/CerberusWhineSad", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Three-headed Cerberus permits none approach, neither him nor his master." },
			},
			CerberusChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0127", PreLineWait = 0.3, StartSound = "/VO/CerberusWhineSad", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The monstrous Hound of Hell bares countless fangs as if to say, back off." },
			},
			CerberusChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0128", PreLineWait = 0.3, StartSound = "/VO/CerberusWhineSad", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Feared watch-dog Cerberus regards the Princess with his six expectant eyes." },
			},
			CerberusChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0242", PreLineWait = 0.3, StartSound = "/VO/CerberusSnarls", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The multiheaded monster keeps his fury well in check beside the rightful Underworld King." },
			},
			CerberusChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0243", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_3", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Fierce hell-hound Cerberus has many fangs but little trust to spare." },
			},
			CerberusChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0244", PreLineWait = 0.3, StartSound = "/VO/CerberusExtraGrowl_1", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The resting hound of hell makes plain he wishes not to be disturbed." },
			},
			CerberusChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0245", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_1", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Three-headed Cerberus eyes every surface of the chamber, all at once." },
			},
			CerberusChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0246", PreLineWait = 0.3, StartSound = "/VO/CerberusSniff", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The savage watch dog looks tentatively at the Princess of the Underworld." },
			},
			CerberusChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0247", PreLineWait = 0.3, StartSound = "/VO/CerberusWhine", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Notoriously vicious Cerberus sits vigilantly by his master's side." },
			},
			CerberusChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Storyteller_0248", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The triple-headed guardian of hell does not wish to be troubled at this time." },
			},
			CerberusChat11 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0505", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The brutal hound of hell by now permits the Princess of the Dead to approach." },
			},
			CerberusChat12 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0506", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Where goes the lord and master of the dead, the infernal watchdog of the Underworld follows." },
			},
			CerberusChat13 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0507", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The one-time guardian of the gates of hell restrains his viciousness for the Princess." },
			},
			CerberusChat14 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0508", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}For unknown reasons does this savage beast decide not to devour the Princess." },
			},
			CerberusChat15 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Storyteller_0509", PreLineWait = 0.3, StartSound = "/VO/CerberusCuteGrowl_4", IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}Somehow the Princess of the Underworld has worked her magick on the hound of hell." },
			},
		},

		RepulseOnMeleeInvulnerableHit = 250,
		InvincibubbleAnim = "Invincibubble_Cerberus",
		--InvulnerableHitSound = "/VO/CerberusBarks",
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
				ChanceToPlay = 0.25,
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

		Using = { CerberusSounds =
					{
						"/VO/CerberusWhineSad",
						"/VO/CerberusBarks",
						"/VO/CerberusCuteGrowl_1",
						"/VO/CerberusCuteGrowl_3",
						"/VO/CerberusCuteGrowl_4",
						"/VO/CerberusExtraGrowl_1",
						"/VO/CerberusSnarls",
						"/VO/CerberusSniff",
						"/VO/CerberusWhine",
					},
				},
	},

	-- @ ending
	NPC_Cerberus_Story_01 =
	{
		InheritFrom = { "NPC_Neutral" },
		GenusName = "NPC_Cerberus_01",
		Portrait = "Portrait_Cerberus_Default_01",
		LoadPackages = { "Cerberus", },
		AnimOffsetX = 120,
		AnimOffsetZ = -250,
		Groups = { "NPCs" },

		UseText = "UseCerberus",
		UseTextSpecial = "UseCerberusSpecial_True",
		UseTextTalkAndGift = "UseCerberusAndGift",
		UseTextTalkAndSpecial = "UseCerberusAndSpecial_True",
		UseTextTalkGiftAndSpecial = "UseCerberusGiftAndSpecial_True",
		SpecialInteractFunctionName = "AttemptPetCerberusThread",

		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CerberusTrueEnding01" },
			},
		},

		InteractTextLineSets =
		{
			CerberusTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				UseInitialInteractSetup = true,
				-- StatusAnimation = false,
				SkipContextArt = true,

				-- PreEventFunctionName = "PetCerberus",
				{ Cue = "/VO/Storyteller_0449", PreLineWait = 0.3, StartSound = "/VO/CerberusSnarls",
					IsNarration = true, LineHistoryName = "Speaker_Homer",
					Text = "{#Emph}The notoriously fearsome triple-headed monster Cerberus rests in his favored spot, and now regards the Princess of the Dead with three expressions different than before." },

				{ Cue = "/VO/MelinoeField_3890", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "DeathAreaRestoredUpdateHallwayBlocks",
					PostLineThreadedFunctionName = "AttemptPetCerberusThread",
					PortraitExitWait = 0.35,

					Text = "Well boy, this must be the next best thing to guarding the Underworld's gates. Say, do I have your permission to give you a scratch? The way my brother demonstrated before." },
			},
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
		LoadPackages = { "Bouldy", },

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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, Alive = false },
					},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 506405 }, Alive = false },
					},
				},
				{ Cue = "/VO/BouldySilent01", SpeakerLabelOffsetY = 18,
					Text = ".   .   .   ." },
			},
		},

		OnHitFunctionName = "BouldyHitPresentation",
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ChanceToPlay = 0.75,
			ObjectType = "NPC_Hades_Field_01",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 506405 }, Alive = false },
				},
			},
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

-- Global Hades Lines
GlobalVoiceLines.HadesCurseVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice },

		{ Cue = "/VO/Hades_0085", Text = "{#Emph}Curse you..." },
		{ Cue = "/VO/Hades_0088", Text = "{#Emph}You stay away from her...!" },
		{ Cue = "/VO/Hades_0091", Text = "{#Emph}There is no escape." },
		{ Cue = "/VO/Hades_0095", Text = "{#Emph}<Laughter>", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
		{ Cue = "/VO/Hades_0379", Text = "{#Emph}You are nothing, Typhon.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Hades_0376", Text = "{#Emph}Curse you, monster...!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Hades_0377", Text = "{#Emph}Blast you, monster!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Hades_0378", Text = "{#Emph}Wretched monster.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Hades_0086", Text = "{#Emph}Curse you, Father...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0087", Text = "{#Emph}Blast you, Father!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0089", Text = "{#Emph}Wretched Titan...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0090", Text = "{#Emph}Wretched excuse for a father!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0092", Text = "{#Emph}Get from my House!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0093", Text = "{#Emph}Death is your only family.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Hades_0094", Text = "{#Emph}For what you did to me!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_Boss01" },
				},
			},
		},
	},
	{
		Queue = "Interrupt",
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.33,
		ObjectType = "Chronos",
		TriggerCooldowns = { "ChronosSpokeRecently" },

		{ Cue = "/VO/Chronos_1239", Text = "{#Emph}Aah! {#Prev}You are your father's daughter!" },
		{ Cue = "/VO/Chronos_1240", Text = "{#Emph}Gah! {#Prev}Hades using {#Emph}you {#Prev}to get to {#Emph}me?" },
		{ Cue = "/VO/Chronos_1241", Text = "{#Emph}Rng! {#Prev}I shall remember that, my {#Emph}son!" },
		{ Cue = "/VO/Chronos_1242", Text = "{#Emph}Tsch! {#Prev}Was that {#Emph}you{#Prev}, my son?" },
		{ Cue = "/VO/Chronos_1243", Text = "{#Emph}Argh! {#Prev}You overstep, Hades!" },
	},
}
GlobalVoiceLines.HadesHarvestReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "NPC_Hades_Field_01",
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
			Comparison = ">=",
			Value = 2,
		},
		{
			PathTrue = { "CurrentRun", "UseRecord", "NPC_Hades_Field_01" },
		},
	},
	Cooldowns =
	{
		{ Name = "HadesSpokeRecently", Time = 8 },
	},

	{ Cue = "/VO/Hades_0152", Text = "Why pick the refuse from this place?" },
	{ Cue = "/VO/Hades_0153", Text = "There's nothing here of use." },
	{ Cue = "/VO/Hades_0183", Text = "Just go..." },
}
GlobalVoiceLines.HadesPickaxeReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	ObjectType = "NPC_Hades_Field_01",
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
			Comparison = ">=",
			Value = 2,
		},
	},
	Cooldowns =
	{
		{ Name = "HadesSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Hades_0179", Text = "Good riddance.", PlayFirst = true },
	{ Cue = "/VO/Hades_0180", Text = "Marble..." },
	{ Cue = "/VO/Hades_0181", Text = "In his own likeness..." },
	{ Cue = "/VO/Hades_0182", Text = "Oh he has more..." },
	{ Cue = "/VO/Hades_0184", Text = "{#Emph}<Chuckle>" },
}
GlobalVoiceLines.HadesExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.2,
	ObjectType = "NPC_Hades_Field_01",
	GameStateRequirements =
	{
		{
			Path = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
			Comparison = ">=",
			Value = 2,
		},
	},
	Cooldowns =
	{
		{ Name = "HadesSpokeRecently", Time = 12 },
	},

	{ Cue = "/VO/Hades_0154", Text = "I thought that one would never leave." },
	{ Cue = "/VO/Hades_0155", Text = "A Shade that has a spine." },
	{ Cue = "/VO/Hades_0185", Text = "Long had that one waited here..." },
	{ Cue = "/VO/Hades_0186", Text = "The Shades heed you at least..." },
}
GlobalVoiceLines.PersephoneGreetingVoiceLines =
{
	{
		PlayOnceFromTableThisRun = true,
		PlayOnceContext = "PersephoneGreetingVO",
		PreLineWait = 0.35,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.85,
		ObjectType = "NPC_Persephone_01",
		GameStateRequirements =
		{
			{
				--
			},
		},

		{ Cue = "/VO/Persephone_0030", Text = "Daughter!" },
		{ Cue = "/VO/Persephone_0031", Text = "Melinoë!" },
		{ Cue = "/VO/Persephone_0032", Text = "Melinoë." },
		{ Cue = "/VO/Persephone_0033", Text = "Welcome!" },
		{ Cue = "/VO/Persephone_0034", Text = "Hello!" },
		{ Cue = "/VO/Persephone_0035", Text = "Greetings." },
		{ Cue = "/VO/Persephone_0036", Text = "You're here!" },
		{ Cue = "/VO/Persephone_0037", Text = "It's you!" },
		{ Cue = "/VO/Persephone_0038", Text = "Hades, {#Emph}look!", PlayFirst = true },
		{ Cue = "/VO/Persephone_0039", Text = "Hello, Daughter!" },
	},
}
GlobalVoiceLines.HadesZagreusChattingLines =
{
	RecheckRequirementsForSubLines = true,
	GameStateRequirements = 
	{
		{
			PathFalse = { "CurrentRun", "TriggerRecord", "HadesZagreusInterrupt" },
		},
	},
	{
		ObjectTypes = { "NPC_Zagreus_Past_01", "NPC_Zagreus_01" },

		{ Cue = "/VO/Zagreus_0431", Text = "You said yourself Mother could use some rest. Why don't you join her? I can keep an eye on things." },
	},
	{
		PreLineWait = 0.4,
		ObjectType = "NPC_Hades_02",

		{ Cue = "/VO/Hades_0390", Text = "No. Nyx is with the Queen. Nor shall I leave my daughter unattended." },
	},
	{
		ObjectTypes = { "NPC_Zagreus_Past_01", "NPC_Zagreus_01" },

		{ Cue = "/VO/Zagreus_0432", Text = "{#Emph}<Scoff> Unattended? {#Prev}You act like I may not be the best influence on her!" },
	},
	{
		PreLineWait = 0.4,
		ObjectType = "NPC_Hades_02",

		{ Cue = "/VO/Hades_0391", Text = "I do not act." },
	},
}
GlobalVoiceLines.HadesZagreusGreeting =
{
	Queue = "Interrupt",
	{
		ObjectTypes = { "NPC_Zagreus_Past_01", "NPC_Zagreus_01" },
		-- PreLineAnim = "Hades_Hello",
		PreLineFunctionName = "StopHadesFlashbackSpeech",

		{ Cue = "/VO/Zagreus_0433", Text = "Oh, hello!" },
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hades )