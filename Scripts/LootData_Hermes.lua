LootSetData.Hermes =
{
	-- Hermes
	HermesUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		-- GameStateRequirements handled in RunProgress table
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = false,
		TreatAsGodLootByShops = true,
		Weight = 10,
		Icon = "BoonSymbolHermes",

		BoonInfoIcon = "BoonInfoSymbolHermesIcon",
		DoorIcon = "BoonDropHermesPreview",
		MenuTitle = "UpgradeChoiceMenu_Title_HermesUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_HermesUpgrade",
		LootRejectedText = "Player_GodDispleased_HermesUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_HermesUpgrade",

		SpawnSound = "/SFX/HermesBoonWhoosh",
		PortraitEnterSound = "/SFX/HermesBoonWhoosh",
		UpgradeSelectedSound = "/SFX/HermesBoonChoice",

		BoughtTextLinesRequirements =
		{
			{
				PathFalse = { "CurrentRun", "HadBoughtLootConversation" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "Q_PreBoss01", },
			},
		},

		Color = { 255, 100, 0, 255 },
		LightingColor = {255, 120, 0, 255},
		LootColor = {255, 90, 0, 255},
		SubtitleColor = Color.HermesVoice,
		EmoteOffsetY = -280,
		EmoteOffsetX = 50,

		SpeakerName = "Hermes",
		Speaker = "NPC_Hermes_01",
		LoadPackages = { "Hermes", },
		Portrait = "Portrait_Hermes_Default_01",
		OverlayAnim = "HermesOverlay",
		Gender = "Male",
		FlavorTextIds =
		{
			"HermesUpgrade_FlavorText01",
			"HermesUpgrade_FlavorText02",
			"HermesUpgrade_FlavorText03",
		},

		PriorityUpgrades = { },
		WeaponUpgrades = { },
		Traits =
		{
			"HermesWeaponBoon",
			"HermesSpecialBoon",
			"HermesCastDiscountBoon",
			"SprintShieldBoon",
			"SorcerySpeedBoon",
			"DodgeChanceBoon",
			"SlowProjectileBoon",
			"MoneyMultiplierBoon",
			"TimedKillBuffBoon",
			"RestockBoon",
			"LuckyBoon",

			-- Elemental
			"ElementalUnifiedBoon",
			-- Legendary
			"TimeStopLastStandBoon",
		},
		Consumables = { },

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.2,
				-- RandomRemaining = true,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1884", Text = "Lord Hermes, go unseen." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.28,
				PreLineAnim = "Hermes_Greeting",
				ObjectType = "NPC_Hermes_01",

				{ Cue = "/VO/Hermes_0128", Text = "You too!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1884" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0129", Text = "Hey hey!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0130", Text = "Hey!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0131", Text = "Fierce!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0132", Text = "Cheers!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1884" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0133", Text = "Same!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0134", Text = "Yep!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Hermes_0135", Text = "Sure!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
			},
		},

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlay = 0.25,
			GameStateRequirements =
			{
				NamedRequirements = { "OlympianOnSpawnVoiceLinesAllowed" },
			},

			{ Cue = "/VO/Melinoe_1484", Text = "Lord Hermes...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1485", Text = "Special delivery..." },
			{ Cue = "/VO/Melinoe_0943", Text = "The messenger..." },
			-- { Cue = "/VO/MelinoeField_2001", Text = "Lord Hermes...!" },
			{ Cue = "/VO/MelinoeField_2002", Text = "Hermes...!" },
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
						PathTrue = { "CurrentRun", "TextLinesRecord", "HermesFirstPickUp" },
					},
				},
				{ Cue = "/VO/Melinoe_1161", Text = "Olympus needs me... on the surface?" },
			},
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		TextLinesEndEvents =
		{
			{
				Threaded = true,
				FunctionName = "GenericPresentation",
				Args =
				{
					VoiceLines =
					{
						RandomRemaining = true,
						PreLineWait = 0.1,
						CooldownTime = 40,
						Queue = "Interrupt",
						Cooldowns =
						{
							{ Name = "HermesSpokeRecently", Time = 10 },
						},

						{ Cue = "/VO/Hermes_0158", Text = "{#Emph}Oop!" },
						{ Cue = "/VO/Hermes_0159", Text = "OK!" },
						{ Cue = "/VO/Hermes_0160", Text = "{#Emph}Eh!" },
						{ Cue = "/VO/Hermes_0161", Text = "...and, yeah." },
						{ Cue = "/VO/Hermes_0162", Text = "{#Emph}Hup!" },
						{ Cue = "/VO/Hermes_0163", Text = "{#Emph}Erm!" },
						{ Cue = "/VO/Hermes_0164", Text = "{#Emph}Hm!" },
						{ Cue = "/VO/Hermes_0165", Text = "{#Emph}Oh!" },
					},
				},
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "ElapsedTime" },
						Comparison = "<=",
						Value = 3.35,
					},
					{
						PathFromArgs = true,
						PathTrue = { "PlayOnceLine" },
					},
				},
			}
		},

		DuoPickupTextLines =
		{
		},

		InteractTextLineSets =
		{
			-- low health
			HermesLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0049",
					
					Text = "Looks like you hit a few bumps on your way there, M! Do watch your step, though when you're moving fast, I know it can be tough!" },
			},
			HermesLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0050",
					
					Text = "It's rough out there tonight, isn't it M? Well just hang on, and maybe one of {#Emph}these {#Prev}will help you go a little farther, {#Emph}faster!" },
			},
			HermesLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0051",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Oh, no! You're hurt! What happened to you, M? Gramps must have got to you before I did! How is that even possible...?" },
			},
			HermesLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0052",
					
					Text = "That's not the safest place to travel, is it, M? So you picked up a scrape or two, so what! Now you'll pick up some speed!" },
			},

			-- run starts
			HermesRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasNone = { "G", "O" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = "<=",
						Value = 6,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0053",
					
					Text = "Hey M! Heard you were heading out again, figured I'd drop on in, and send you off! Safe travels, and all that!" },
			},
			HermesRunStart02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasNone = { "G", "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0054",
					
					Text = "Long way to go from there, right, M? Well let's see if we can't cut out a little travel time to your next destination!" },
			},
			HermesRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasNone = { "G", "O" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = "<=",
						Value = 6,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0055",
					
					Text = "Thought I'd catch you right on your way out! Travel can be a very rewarding experience, but sometimes, you just want to get to where you need to be!" },
			},
			HermesRunStart04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasNone = { "G", "O" },
					},
					{
						Path = { "CurrentRun", "BiomeDepthCache" },
						Comparison = "<=",
						Value = 6,
					},

				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0056",
					
					Text = "Another race to the finish line begins, hey, M? Well then, {#Emph}get set{#Prev}, because we'll have you there in no time flat! Provided you survive and all..." },
			},
			HermesRunStart05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0210",
					Text = "M, I would never mean to slow you down, especially as you get started for the night! So you go on and pick something, and then get {#Emph}out {#Prev}of there!" },
			},
			HermesRunStart06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0211",
					Text = "Thought you could sneak on out of there without me giving you my Boon, well you're entirely mistaken, M! And you're about to be much quicker, too!" },
			},

			HermesUnderworldStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0088",
					
					Text = "Had enough surface air for now, I get it, M. The more familiar path is often best! Either way, take this at your own pace. Don't anybody rush you! Except me." },
			},

			HermesRunStartSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "N_Boss01", "N_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0086",
					
					Text = "You showed old Gramps who's boss! {#Emph}Good going, M! {#Prev}That ought to trip him up a bit. Fine time to come on up and help us drive his forces off {#Emph}our {#Prev}turf. What do you say?" },
			},
			HermesRunStartSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "N_Boss01", "N_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0087",
					
					Text = "No surprise old Gramps is a tough customer, but sorry he got you last night. And cheers for heading up {#Emph}this {#Prev}way! {#Emph}Time {#Prev}isn't going anywhere just yet, but this mountain might!" },
			},
			HermesRunStartSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasNone = { "N_Boss01", "N_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0212",
					
					Text = "Oh great, you're headed up this way and not gone too far yet! Think you could make good time on your way here, although the choice is yours!" },
			},
			HermesRunStartSurface04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0213",
					
					Text = "I know you can't breathe in our surface air forever, M, so it's a good thing I got a hold of you right as you're starting off! We'll get you to this mountaintop in practically no time." },
			},

			-- story events
			HermesAboutReachingSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0034",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "M, I know it's not an easy trip, or even possible for you right now, heading all the way up here. But just imagine how hard it is for our family to swallow our pride and ask for aid! Things are that grim!" },
			},

			HermesAboutRouteChoice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HermesAboutSurface02", "HermesAboutSurface02B", "HermesAboutSurface03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0074",
					Text = "Time of need here, M, and we need you at the bottom of the Underworld, {#Emph}and {#Prev}the top of Olympus! Two places at once, my sympathies. The {#Emph}trick {#Prev}is to move really, really fast!" },
			},

			HermesUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0064",
					Text = "You made it pretty far down there before! Impressive work, I knew you had it in you, M! But Gramps still isn't backing down, is he? Maybe he's having second thoughts at least!" },
			},
			HermesSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0065",
					Text = "You're really helping tip the scales here! Broke through the siege and gave our relatives a minute of reprieve. Still isn't over, mind, but we can get there soon enough I think!" },
			},
			HermesSurfaceRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0214",
					Emote = "PortraitEmoteFiredUp",
					Text = "We really got him, M! Typhon, that is! I saw him tumble down the dark side of the mountain to the bottom and go {#Emph}boom! {#Prev}Then later saw him slowly get back up, and roar more angrily than ever, but hey!" },
			},

			HermesAboutOlympusSiege01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0036",
					Text = "Olympus has been under siege before! Normally, it's not too big a deal. But Gramps has something else in mind this time. Got some individuals here pretty spooked!" },
			},
			HermesAboutOlympusSiege02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "P_Shop01", "P_PreBoss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0215",
					Text = "You saw we stashed some goods for you up on our mountaintop, right M? It's just a bit out of the way for my professional associate, though we'll keep you supplied!" },
			},

			HermesAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0037",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Known Hec a while, and don't envy either one of you. She couldn't just send you off to deal with Gramps before you were ready! You must have {#Emph}hated {#Prev}having to wait. I know I do!" },
			},
			HermesAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0040",

					Text = "Hec always said you're quick to learn, you know? And sure enough, whenever I'd drop in, you'd be over a cauldron, working some new spell. Well, {#Emph}this is it! {#Prev}Your time to work some magick for our sake!" },
			},
			HermesAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosRevealFollowUp", "ChronosMeeting03", "ChronosPostBattleMeeting01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0041",
					
					Text = "What a customer, the Titan of Time! I've not met Gramps before, though I can imagine what he must be like. Used to wonder how come my pop and his brothers were so dodgy sometimes. Now I know where they got it from!" },
			},
			HermesAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesAboutChronos01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0042",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "You'd think the Titan of Time wouldn't be so stuck in the past, caught up in his idea of a {#Emph}Golden Age {#Prev}when {#Emph}he {#Prev}used to rule, and mortals hadn't a care in the world? Caring's not such a bad thing I think!" },
			},
			HermesAboutChronosPlan01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = "<",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0077",
					Text = "No way you could have already stopped Gramps by now, but going after him right when you did, you're buying us some time to put a little wrinkle in his plan. So {#Emph}cheers!" },
			},

			HermesAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" }
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0217",
					Text = "Some of the gods think Eris showed up near our mountain causing trouble again all because of you! They don't know I practically {#Emph}begged {#Prev}you to come up to our rescue over here. Think Hec gave you the order! We're really in it now..." },
			},

			HermesAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0102",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "We've got more Titan problems than we figured, M. If Gramps could get Prometheus to take his side, who only knows what else. Ruffled a lot of feathers haven't we?" },
			},
			HermesAboutPrometheusAltFight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PrometheusAboutAltFight01", "PrometheusAboutAltFight01_B" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutPrometheusAltFight01" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0269",
					Text = "Prometheus and Heracles, turns out they're close, are they? Your little spat with them was shrouded by the dark but I caught glimpses of it here and there. I need to know about these things though doesn't mean I'll tell!" },
			},

			HermesAboutTyphonReveal01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_MiniBoss03" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0207",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "You almost made it to the very top that time, and though it's not my wish to spoil the surprise, you {#Emph}ought {#Prev}to know we're dealing now with good old Typhon, Father of All Monsters! Isn't that just great...? We need you back here, M." },
			},
			HermesAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0208",
					Text = "Good news is we can now be sure what Gramps had planned for us, but bad news is, it's Typhon, and he's big. But my pop stopped him once, so how hard could it be...?" },
			},
			HermesAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0209",
					Text = "Who do you think can make it to the top of Mount Olympus first, M, you or old Typhon? You've got a longer way to go, sure, but you are definitely faster! Or about to be!" },
			},

			HermesAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesFieldAboutTyphonDeath01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusPalaceAboutTyphonDeath01" }, Max = 4 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0264",
					Emote = "PortraitEmoteSurprise",
					Text = "Typhon is gone for good?! My pop, he can't believe it still, but there has been no sign of that monstrosity up here since you last took him on! But why am {#Emph}I {#Prev}surprised? I figured if anyone could pull something like that off, it would be {#Emph}you!" },
			},

			HermesAboutMoros01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Moros_01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0084",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Hec tells me Moros, son of Nyx, is staying with you for a bit down there? I thought he always stuck with the Three Fates. There's something going on, and I don't like it, M." },
			},
			HermesAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0085",
					Text = "You found your father down there, M! Never could get close enough myself, hope he's still all right. Hope {#Emph}everyone{#Prev}'s all right! We'll get them back, keep doing everything we can." },
			},

			HermesAboutCirce01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Story01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0173",
					
					Text = "Ran into Lady Circe on your way last night, did you, M? She's quite the talent with those magick spells of hers. Liked turning mortals to all sorts of things! Bit {#Emph}mean {#Prev}if you ask me!" },
			},

			HermesAboutMission01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0078",
					Text = "Officially, I'm keeping tabs on you, you're not supposed to know, just so you know. I tell Olympus {#Emph}all {#Prev}the latest happenings, nothing too private, mind; and then I tell {#Emph}you {#Prev}more! Just keeping tabs on everyone I guess!" },
			},
			HermesAboutMission02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutFates01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0083",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "These last few nights since you got started, all I managed to confirm is Gramps got hold of someone whom he's sure gives him the upper hand. Right now he's readying the next stage of his plan to bring this mountain down! I'd better go." },
			},

			HermesAboutPersephone01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0043",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Your mum would travel back and forth between Olympus and your father's House, and {#Emph}I {#Prev}had the pleasure of accompanying her! One day, she didn't show up. I knew right then and there something was off..." },
			},
			HermesAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0044",
					
					Text = "All this reminds of the time I backed your brother when he was searching for your mum! Had a vested interest in the outcome, sure. But before I knew it, I really started to care! We'll find a way to help them, won't we, M?" },
			},
			HermesAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesGift02", "ArtemisGift02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0045",
					
					Text = "Artemis and I weren't always close, each keeping to ourselves and all. But working with you and Hec brought us closer! We were so busy sneaking around, helped knowing we didn't have to sneak around each other!" },
			},
			HermesAboutArtemis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0100",
					
					Text = "You already caught up with Artemis, good good! She and I don't always chat, running around a lot, being discreet and all. But we exchange a knowing look from time to time!" },
			},

			HermesAboutCharon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0046",
					
					Text = "You run into a certain Underworld Boatman rowing about, you tell him I said hey? We've not collaborated much as before, what with everything of late. I miss those times!" },
			},
			HermesAboutCharon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutHermes01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0047",
					Text = "So the Boatman's been all right, has he? That's good! I know that he's been looking out for Hec and the rest of you for a while now, but do look out for him in turn, would you?" },
			},

			HermesAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0063",
					
					Text = "Ran into big old Heracles, did you? My stepmum's sent him on another labor of some sort. Got the feeling that his heart's not in it anymore. But hey, he's tough! And we could use the help." },
			},			

			HermesAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutFates01", "HecateBossAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0079",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "So Gramps somehow got hold of the Three Fates! That isn't good, not sure what we can do about it, M. At least now everybody on Olympus knows, I figured it was time! Got us a bit on edge, though we do hide it pretty well!" },
			},

			HermesAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0038",
					
					Text = "At least the family knows about you now! Always wanted to say, {#Emph}Message to Olympus! Persephone and Hades had another kid! And she's all right! {#Prev}But Hec knew we had to wait, and she knows a lot! So my lips were sealed." },
			},

			HermesAboutPast01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0039",
					
					Text = "To think I used to fill my days with whisking mortal newly-deads down to your father's realm! Honestly grew to like it soon enough, so even after Gramps showed up, I kept on stopping in when I could sneak a trip!" },
			},

			HermesAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0080",
					Text = "You made it up here, M! I'll speed you on except this climate's going to be {#Emph}rough. {#Prev}You Underworld types and surface air! Must be something we can do about it, right...?" },
			},

			HermesAboutSurfaceCurse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0252",
					Text = "All right, so it's rough going on the surface for you, I get that, but don't give up on us yet, M. I know you {#Emph}never {#Prev}would, mind. Probably just searching for some magickal ingredients you need, something like that?" },
			},

			-- alt below
			HermesAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutSurface02B" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutSurface01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0081",
					Text = "Hey M! Don't know exactly what you did, or maybe Hec, but you seem much much more yourself than last I saw. That's great! Because to make it all this way, you're going to need {#Emph}every {#Prev}bit of strength. And {#Emph}speed!" },
			},
			HermesAboutSurface02B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HermesAboutSurface02", "HermesAboutSurface01" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0082",
					Text = "Hey M! You're here! That's great! Hec says you even got your Underworld blood-curse sorted so you're ready for a bit of a long-distance run. Just watch for bumps along the way, though let's speed you past them if we can!" },
			},

			HermesAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0062",
					Text = "The dead throughout Ephyra should be resting easy in your father's care, but Gramps shut it all down, flung open the Underworld's gates, and here we are. If I were dead, I'd be mad, too." },
			},

			HermesAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = "<=",
						Value = 4,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0059",
					
					Text = "You finally saw what it was like up here! Most of the others are holding out at the top of Olympus, and {#Emph}you {#Prev}are the reinforcements. So, come on back when you can, all right?" },
			},

			HermesAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0060",
					
					Text = "You're taking something of a scenic route down to your father's House! Gramps has the major regions of the Underworld locked down, so... come to think, that makes a lot of sense!" },
			},
			HermesAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0172",
					Text = "If only I could whisk you clear across the sea-rift that Poseidon carved out. But we {#Emph}mustn't {#Prev}get spotted working too closely together. And besides, you're helping us with every deck you swab! So {#Emph}cheers!" },
			},

			HermesAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0061",
					Text = "Gramps sends forces to Olympus, we can send them whence they came, no sweat. But he's got something else in store, and whatever it is, it's big. Learn anything, let Hec know right away." },
			},

			-- about other gods
			HermesAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0098",
					Text = "Heard from my pop tonight already, M? He's always been a very busy god but never tires out. Now that you've got his lightning strength, how about some lightning {#Emph}speed {#Prev}to boot?" },
			},
			HermesAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraGift04" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0221",
					Text = "You know, I think my stepmum likes you quite a bit! Not to be taken for granted! Despite her specialties, I get the feeling our Queen Hera's not too keen on kids." },
			},
			HermesAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0220",
					Text = "Uncle Poseidon's blessing done you any favors yet this eve? Likes claiming it'll make you nigh invincible, but here's a little traveler's insurance just in case!" },
			},
			HermesAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0174",
					Text = "Apollo's lighting up your life? Last thing he ever wants to do is get his hands dirty, but now, things being as they are, he doesn't have much of a choice I guess!" },
			},
			HermesAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0099",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "For all that's happened, glad you finally met Demeter, even if only by Boon. She had a funny way of showing it sometimes but {#Emph}always {#Prev}loved your mum an awful lot. She'll fight to get her back, to the bitter end." },
			},
			HermesAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0223",
					Text = "Aphrodite's blessing on you, M? Impressive work, her graces are in {#Emph}very {#Prev}high demand! Much as she likes getting involved in personal affairs, yours surely is a special case!" },
			},
			HermesAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusGift04" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0096",
					Text = "You got Hephaestus to come out of his shell! All I can get from him are work orders, {#Emph}bring me more bronze {#Prev}and such! Glad you can put the fruits of all his labor to good use!" },
			},
			HermesAboutHephaestus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesGift05", "HephaestusGift05" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0097",
					Text = "Hephaestus makes a {#Emph}mean {#Prev}set of armor, and you know what? He makes a mean pair of sandals, too. I wear mine all the time! {#Emph}Footwear{#Prev}, M! I really think it's going to catch on!" },
			},
			HermesAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0222",
					Text = "So Hestia already got you, then? She's really rather spry despite her age. And likes to play with fire, too! Still just a kid at heart... one of those wee scary ones, mind!" },
			},
			HermesAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0226",
					Text = "Met Ares did you, M? Whenever there's a bloody dust-up, tempers flaring and all that, he will do everything he can to draw it out! This must be quite a big dilemma for him, mind." },
			},
			HermesAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Athena_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0225",
					Text = "Athena's out there managing frontline defensive strategies and such. We mostly stay out of each other's way. She keeps her head in times like these, I'll give her that!" },
			},
			HermesAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Dionysus_01" },
						Comparison = ">=",
						Value = 1,
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0224",
					Text = "Some of our relatives don't like to get involved. Dionysus, he will go to every feast, but never to a fight! {#Emph}Why don't we all just get along{#Prev}, he says. Though, come to think... it's not a bad idea!" },
			},
			HermesAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0095",
					Text = "Oh good! Selene got a hold of you already, M! Quite the vantage point the Eye of Night has got! Always looking out for you and all of us. Her steeds are pretty quick as well!" },
			},

			-- legendary
			HermesLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0093",
					
					Text = "Somebody call for Premium Express delivery, hey, M? This is the {#Emph}best {#Prev}I've got, and it'll take you far and fast! You have my {#Emph}guarantee!" },
			},
			HermesLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0094",
					
					Text = "Fresh from the highest peaks of Olympus, it's the {#Emph}Premium Express! {#Prev}The finest, fastest blessings, for only the most discerning customers. That's {#Emph}you!" },
			},
			HermesLegendaryPickUp03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0167",
					
					Text = "Hey, hear that, M? Why, that's the sound of {#Emph}Premium Express delivery{#Prev}! Always bringing {#Emph}you {#Prev}only the very best. So, make the most of it?" },
			},
			HermesLegendaryPickUp04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0227",
					
					Text = "This time I've got my very best for you to choose from, M, though you should {#Emph}always {#Prev}expect quality from me! I just have even more of it than usual right now!" },
			},

			-- other reactions
			HermesAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 9,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0218",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "This is a proper spooky night, you had something to do with it, right M? My heart's racing nonstop! Whatever you've been up to in your Crossroads there, hope it works!" },
			},
			HermesAboutGameplayTimer01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0101",
					Text = "Keeping track of your best time, that's what I like to see! Take anything worth doing, then do it just as well a little faster, and a {#Emph}little {#Prev}faster, and soon, you'll be like {#Emph}me! Almost!" },
			},
			HermesAboutGameplayTimer02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutGameplayTimer01" }
					},
					{
						PathFalse = { "ConfigOptionCache", "ShowGameplayTimer" }
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0219",
					Text = "Notice you're not timing yourself anymore, and M? It breaks my heart. Not really, mind. Just find your speed, but still! Want to know how fast you are, there's only one way to find out." },
			},

			HermesAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.AllRandomPackagedBounties,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0090",
					Text = "Had a feeling that I'd find you here one of these nights, you know? Like something's in the air. I'm all keyed up, just want to get things done as {#Emph}mega{#Prev}-fast as possible!" },
			},

			HermesAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TimedBuffKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0075",
					Text = "You're moving right along there, M! Helps having that Metallic Droplet with you at all times. At least till it stops working for the night! Can't go top speed forever, but {#Emph}we try!" },
			},
			HermesAboutKeepsake02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TimedBuffKeepsake" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0228",
					Text = "What a coincidence, it's you, and you're {#Emph}already {#Prev}quick! But you can always be a little quicker! Not me, though." },
			},
			HermesAboutApolloKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceApolloBoonKeepsake" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0216",
					Text = "I know it was Apollo you expected, M, and he's quick! But I am quicker, and could beat him getting to you {#Emph}every time {#Prev}if I was a bit pettier than this! He'll be right with you soon." },
			},

			HermesAboutMomusAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffSelfHitAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0089",
					Text = "Nice snake-staff that you've got there, M, must be they're all the rage! These snakes of {#Emph}mine {#Prev}are from Apollo, helps remind me of the family, you know? Stuck together, skin not so thick, pitch hissy-fits sometimes... love 'em anyway." },
			},

			HermesAboutSurfaceShop01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfaceShops" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SurfaceShop" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0076",
					Text = "You found my special Shrines, good good! Some mortals pray to me both for safe travels and free stuff. {#Emph}Almost {#Prev}free. Small surcharge, mind! Associate has got to take his cut." },
			},
			HermesAboutFamiliars01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar", "CatFamiliar", "RavenFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0166",
					Text = "Wise move having an animal companion along! I've got a soft spot for the quiet self-sufficient types. My little tortoise Chellen always feels at home wherever we go!" },
			},

			HermesAboutUltimateProgress01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "GameState", "WorldUpgradesRevealed" },
						HasAll = { "WorldUpgradeTimeStop", "WorldUpgradeStormStop" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0249",
					Text = "Hec says you're getting closer to a breakthrough there, with Gramps and Typhon and whatnot. Don't want to rush you, M, but this is {#Emph}me! {#Prev}I just can't help myself sometimes." },
			},

			HermesPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0274",
					Emote = "PortraitEmoteFiredUp",
					Text = "I'd say I can't believe you did it, M, but that would mean I didn't think you could, but I {#Emph}did{#Prev}, so I {#Emph}won't! {#Prev}But I {#Emph}will {#Prev}say: Cheers for {#Emph}everything! {#Prev}I know we might not be completely done, but if a bit of pressure's off now, good." },
			},
			HermesPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus02", "NeoChronosAboutOlympus02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0278",
					Text = "So far I'm liking this new Gramps of ours {#Emph}much {#Prev}better than the mean old Chronos from before. You'll have to tell me sometime how you turned his world upside down to make him be this way. Hec hasn't said a thing!" },
			},
			HermesPostTrueEnding03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0283",
					Text = "Your father's back where he belongs, your mother too, I'm really glad they're safe and sound together, M. You've got to make up for lost time with them, and you'll be able to from here on out!" },
			},

			HermesAboutFatesQuest01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosPostTrueEnding02" },
					},
					{
						SumPrevRuns = 2,
						Path = { "TextLinesRecord", "MorosPostTrueEnding02" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0284",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Still have the matter of the Three Fates to be sorted out. So Gramps just sent them into exile and then entirely lost track? How are {#Emph}we {#Prev}supposed to find them if {#Emph}he {#Prev}can't...?" },
			},

			HermesPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0285",
					Emote = "PortraitEmoteFiredUp",
					Text = "You found them, M! The Fates! They told me so themselves, figured I'd spread the word, being a messenger and all, and you know what? They're {#Emph}right! {#Prev}Sounds like their time away gave them a change of heart..." },
			},
			HermesPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0286",
					Text = "The Fates supposedly are no longer deciding what'll happen from here out? Except big stuff, like new ages and such? Don't know {#Emph}how {#Prev}we're supposed to tell the difference, whether everything is planned by {#Emph}them {#Prev}or ours to decide..." },
			},
			HermesPostEpilogue03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0389",
					Text = "Some sort of new age is in store then, take it you heard all about that firsthand, M. Guess it'll be here before we know it, as things like that tend to go! We'll be ready, and even if not, we'll act fast." },
			},

			HermesAboutTime01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0295",
					Portrait = "Portrait_Hermes_Serious_01",
					Text = "Something that scares me, M, is the idea that Time may be even quicker than {#Emph}I {#Prev}am. Remember back when you were real small! Well {#Emph}bam! {#Prev}You're {#Emph}old {#Prev}now, just like {#Emph}that!" },
			},
			HermesAboutClients01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0297",
					Text = "I've got a lot of regulars, but just between us, {#Emph}this {#Prev}one is my favorite, M. You Underworld types tend not to be too fussy, and you're clear with what you want. I like that about you!" },
			},
			HermesAboutLittleToSay01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesGift08" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0290",
					Text = "I like to talk sometimes but I like going quickly {#Emph}always {#Prev}so how about we keep these little conversations nice and brief from here? For the most part!" },
			},

			-- repeatable lines
			HermesChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0003",
					
					Text = "Both got some business to attend to, so let's get you on your way!" },
			},
			HermesChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0004",
					
					Text = "Thought I'd check up on you, everything good? Then good!" },
			},
			HermesChat03 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0005",
					
					Text = "Things don't look great right now, but that can quickly change!" },
			},
			HermesChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0006",
					
					Text = "Sure, Time goes fast! But I think we'll be able to keep up!" },
			},
			HermesChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0007",
					
					Text = "Coincidentally was passing through with choice of blessings here!" },
			},
			HermesChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0008",
					
					Text = "Quick and quiet, M! You've got this, right?" },
			},
			HermesChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0009",
					
					Text = "In a bit of a rush, here, M, so let's get moving shall we?" },
			},
			HermesChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0010",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "{#Emph}Special delivery for the Princess of the Underworld!" },
			},
			HermesChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						FunctionName = "RequireUnrestrictedBoonChoices",
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0011",
					
					Text = "Hey M, you need a lift? 'Cause I've got one. Three, in fact!" },
			},
			HermesChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0012",
					
					Text = "I'm scraping by. You scraping by? Let's scrape on by, why not?" },
			},
			HermesChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0013",
					
					Text = "They say to not be hasty, but then what do they know, right?" },
			},
			HermesChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0014",
					
					Text = "Live fast or not at all, right, M? Now take your pick!" },
			},
			HermesChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0015",
					
					Text = "We'll have you on your way in no time at all!" },
			},
			HermesChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0016",
					
					Text = "Figured you were due to get there right about now!" },
			},
			HermesChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0017",
					
					Text = "Don't think too much about this now, just snap one up and go!" },
			},
			HermesChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0018",
					
					Text = "Looks like we've got another busy eve ahead of us!" },
			},
			HermesChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0019",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "{#Emph}Hurry, M, before it's too late! {#Prev}I like saying that." },
			},
			HermesChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0020",
					
					Text = "Got something here should put a real spring in your step!" },
			},
			HermesChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0021",
					
					Text = "All right, M, let's give {#Emph}you {#Prev}a little boost!" },
			},
			HermesChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0022",
					
					Text = "Oh hey! Thought I'd stop by, drop off a little something for you here!" },
			},
			HermesChat21 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0023",
					
					Text = "We're in a race against Time, and so help me, we are going to win!" },
			},
			HermesChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0024",
					
					Text = "Nice night for a little jog, wouldn't you say there, M?" },
			},
			HermesChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0025",
					
					Text = "Hey! Got one of those special deliveries for you, M!" },
			},
			HermesChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0026",
					
					Text = "Only the best and swiftest service for my valued customers!" },
			},
			HermesChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0027",
					
					Text = "You headed up this way? Maybe I'll see you later on!" },
			},
			HermesChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0028",
					
					Text = "Want to make haste, then I got just the thing!" },
			},
			HermesChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0029",
					
					Text = "Lots going on! Been running around all night!" },
			},
			HermesChat28 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0030",
					
					Text = "No calamitous attack on our family is going to slow us down!" },
			},
			HermesChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0031",
					
					Text = "Got to check up on a couple of things, but first, here!" },
			},
			HermesChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "UseRecord" },
						HasNone = { "SpellDrop", "TalentDrop" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0032",
					
					Text = "Hey hey, M! One of those heys is from Artemis." },
			},
			HermesChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" }
					},
					{
						PathFalse = { "PrevRun", "UseRecord", "NPC_Artemis_01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Hermes_0033",
					
					Text = "Hey hey, M! One of those heys is from Selene." },
			},
		},

		BoughtTextLines =
		{
			HermesLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0068",
					Text = "You know, it's gotten harder sneaking down into the Underworld of late! Good thing I happen to know an expert on the subject. And so do {#Emph}you{#Prev}, I see!" },
			},
			HermesLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0069",
					Text = "Cheers for your business, on behalf of my erstwhile professional associate there! Feels good to be working together with that one again, you tell him I said {#Emph}hrrnnggh!" },
			},
			HermesLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0170",
					Text = "The boatman always takes his toll, that's just the way it is! Though the benefits are {#Emph}more {#Prev}than worth the asking price, you got my guarantee!" },
			},
			HermesLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesGift01", "CharonGift01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0171",
					Text = "What do you guess my professional associate does with all that coin, really? He still won't say a word. Think he's just covering his tracks so Gramps can't pin him down!" },
			},
			HermesLootBought05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Hermes_0275",
					Text = "How long you think it's going to take to do away with all that Chronos Gold, another {#Emph}age {#Prev}or two? Not that you're slow, mind, more that he minted an awful lot of coins right quick!" },
			},

		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			HermesGift01 =
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
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
				},

				{ Cue = "/VO/Melinoe_0957", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I'm glad you're here, Hermes, and it's an honor to finally be working together. To our swift victory!" },
				{ Cue = "/VO/Hermes_0066",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Oh, hey! It's been a minute since I got an offering! Cheers, M, although you needn't have. But here, I've just the thing for you!" },
			},
			HermesGift02 =
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
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
				},

				{ Cue = "/VO/Melinoe_0958", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Hermes, if there's anyone out there who can help me outpace Time, it's you. Please accept this, for your swift and reliable service." },
				{ Cue = "/VO/Hermes_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Right charitable of you, really, M, it's just I {#Emph}really {#Prev}need to move along, so let's get to the blessings if you please?" },
			},
			HermesGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_2005", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "If not for all your speed and bravery, we never would have had a fighting chance against our enemy, Hermes. I don't think we'll soon be able to repay you for this, but I can try!" },
				{ Cue = "/VO/Hermes_0091",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Right cordial of you, M, though I'm not much for tips and we've got pressing matters to attend to, don't you think? Though I appreciate it, honestly." },
			},
			HermesGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "P", "Q" },
					},
				},

				{ Cue = "/VO/MelinoeField_2006", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I know you've been exceptionally busy as of late, though might I briefly interrupt our routine to give to you this little offering? It isn't much, but down here it's some of the best we've got." },
				{ Cue = "/VO/Hermes_0092",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Don't know how you can find the {#Emph}time {#Prev}these days, though I am grateful that you thought of me like this! Now straight to business, then? Got lots to {#Emph}do!" },
			},
			HermesGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_3722", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Where would we be without you, Lord Hermes? You've done so much to prepare us for the rigors we're having to endure. I know your efforts by their nature sometimes go unnoticed, but not by the Unseen." },
				{ Cue = "/VO/Hermes_0168",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "It's been a real pleasure working with you, M. One of the bright spots in all of this in fact! I keep my chin up no matter what, got to see where I'm going, right? Cheers for making it easy!" },
			},
			HermesGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_3723", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "To the swiftest of the gods, and one of my dearest, oldest comrades. Lord Hermes, you've served both Olympus and the Underworld, and you've seen it all. The rest of our family can learn so much from you. I know I could." },
				{ Cue = "/VO/Hermes_0169",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I run around a lot and all. Been to a lot of places, met a lot of different characters, but you know what? You're still the best, I really mean it, M. You're not the {#Emph}fastest{#Prev}, mind! Can't have it all. But you and me? We cut it pretty close." },
			},
			HermesGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_HermesGiftHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
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
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01", "Q_PreBoss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesGift06", "HermesFieldAboutSupport01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4212", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "Special delivery for you, Lord Hermes! You've aided me more times than I can count, and encouraged me every step of the way. I could never have come this far this quickly otherwise." },
				{ Cue = "/VO/Hermes_0256",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteSurprise",
					Text = "Hey! Ambrosia! Just what I always wanted! Not seen it very often recently, nor the feasting that tends to go with it. Though at this rate we might soon have more! {#Emph}Feasting {#Prev}that is, which ought to be in your honor." },
			},
			-- bond forged
			HermesGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedHermes",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "HermesUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						HintId = "Codex_DoesntWantGiftHint",
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "Q_PreBoss01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HermesGift07" },
					},
				},
				{ Cue = "/VO/MelinoeField_4213", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					Text = "To our esteemed Messenger, and my distinguished friend! Not only have you kept the bond between the Underworld and Olympus from fraying, you've done it swiftly and silently. You're practically a chthonic god yourself!" },

				{ Cue = "/VO/Hermes_0257",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Hermes_01", Icon = "Keepsake_Hermes" },

					Text = "That really means a lot, cheers, M. You know I like doing things fast, but the one thing I like even {#Emph}more {#Prev}is doing things well. We gods don't always have to work hard, but your father always did, and so do you. I'm glad I'm not alone." },
			},

		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_0643", Text = "Nothing like a quick exchange of gifts!" },
		},

		SwapUpgradePickedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.05,
			SuccessiveChanceToPlay = 0.33,
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "ReplacedTraitSource", },
				},
			},

		},

	},

}

OverwriteTableKeys( LootData, LootSetData.Hermes )