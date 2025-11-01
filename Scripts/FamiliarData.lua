FamiliarOrderData =
{
	"CatFamiliar",
	"FrogFamiliar",
	"RavenFamiliar",
	"HoundFamiliar",
	"PolecatFamiliar",
}

FamiliarData = 
{
	BaseFamiliar = 
	{
		DebugOnly = true,
		GameStateRequirements = 
		{
			Force = true,
		},
		IgnoreInvisibility = true, -- Skip HadesInvisibility emote presentation
		IgnoreCastSummonDamage = true,

		-- AI
		DamageType = "Ally",
		IgnoreDamage = true,
		NonHeroKillCombatText = "PartnerKill",
		
		-- Equipping
		AnimOffsetZ = 150,
		EquipVoiceLines =
		{
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},

		-- Gifting
		CanReceiveGift = true,
		UnlimitedGifts =
		{
			FamiliarPoints = true,
		},

		-- Interaction
		OnUsedFunctionName = "UseFamiliar",
		UseText = "FamiliarUseText",

		-- Physical
		Groups = {},
		Material = "Organic",
	},

	-- Frinos
	FrogFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
			},
		},

		-- AI
		AIOptions = { "FrogFamiliarAI" },
		LeapDistanceMax = 850,
		LeapDistanceMaxScaleY = 0.6,
		LeapRandomOffsetMax = 250,
		LeapRandomOffsetMin = 150,
		LeapRestDistance = 750, -- don't leap if the hero is closer than this
		LeapRestDistanceNonCombat = 660,
		LeapRestDistanceScaleY = 0.6,
		LeapFastRecoveryDistance = 1100,
		LeapFastRecoveryDistanceScaleY = 0.6,
		LeapRecoveryThreadName = "FrogFamiliarLeapRecovery",
		LeapPrepareTime = 0.1,
		LeapRecoveryTime = 4.5,
		LeapRecoveryTimeFast = 0.5,
		LeapRecoveryTimeLinked = 2.0,
		LeapRecoveryTimeNonCombat = 0.15,
		LeapSpeed = 1200,

		-- Animations
		BlockAnimation = "Familiar_Frog_Block",
		IdleAnimation = "Familiar_Frog_Idle",
		HappyAnimation = "Familiar_Frog_Greet",
		LeapChargeAnimation = "Familiar_Frog_HopStart",
		LeapLandingAnimation = "Familiar_Frog_HopTouchdown",
		StartNewRunAnimation = "Familiar_Frog_GoUp",
		TurnInPlaceAngleMin = 10,
		TurnInPlaceAnimation = "Familiar_Frog_HopStart_AutoLand",

		-- Events
		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					SetAnimation = "Familiar_Frog_Victory",
					Sound = "/SFX/Familiars/FrogCroak2",
				},
			},
		},
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Frog_GoUp",
					VfxDelay = 0.35,
				},
			},
		},

		-- Equipping
		AnimOffsetZ = 140,
		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidFrinosRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2500", Text = "Come, Frinos." },
				{ Cue = "/VO/Melinoe_2501", Text = "Join me, Frinos?" },
				{ Cue = "/VO/Melinoe_3880", Text = "Let's go, Frinos." },
			},
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
		KitAngle = 235,

		-- Functions
		ActivatePresentationFunctionName = "FrogFamiliarSpawnPresentation",
		LinkBeginFunctionName = "FrogFamiliarLinkBegin",
		MoveFunctionName = "FrogFamiliarMoveToLocation",
		StopAIFunctionName = "FrogFamiliarStopAI",

		-- Gifting / Recruiting / Costuming
		DefaultCostume = "FamiliarCostume_FrogDefault",
		FamiliarShopGraphic = "FamiliarShopFrog",
		GiftFunctionName = "FamiliarRecruitPresentation",
		GiftFunctionArgs =
		{
			Text = "FrogFamiliar",
			Icon = "FamiliarIcon_Frog",

			HeroAnimation = "MelTalkExplaining01",
			HeroExitAnimation = "MelTalkExplaining01ReturnToIdle",
			SkipCameraZoom = true,

			UnlockSequenceDuration = 6.6,
			UnlockStartAnimation = "Familiar_Frog_RecruitStart",
			--UnlockEndAnimation = "Familiar_Cat_Sleep_Awaken",
			UnlockExitAnimation = "Familiar_Frog_HopStart",
		},
		RecruitVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.35,
			GameStateRequirements =
			{
				{
					Path = { "CurrentHubRoom", "Name" },
					IsAny = { "Hub_Main" },
				},
			},

			{ Cue = "/VO/Melinoe_2766", Text = "This is a very special treat, Frinos." },
			{ Cue = "/VO/Melinoe_2767", Text = "It means you'll be protected when you're with me; and you can protect me, in turn.", PreLineWait = 0.8 },
		},
		SetupEvents =
		{
			{
				FunctionName = "SetupFamiliarCostume",
				GameStateRequirements =
				{
					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
			},
			{
				-- Frinos not fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextTalkAndSpecial = "FrogFamiliarUseTextTalkAndSpecial",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "FrogFamiliarUseTextGiftAndSpecial",
					UseTextTalkGiftAndSpecial = "FrogFamiliarUseTextTalkGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
						{
							Path = { "CurrentHubRoom", "Name" },
							IsAny = { "Hub_PreRun" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
					},
					NamedRequirementsFalse = { "HasAllFrogUpgrades" },
				},
			},
			{
				-- Frinos fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					ReceiveGiftFunctionName = "GiftFamiliarCostume",
					UseTextTalkAndSpecial = "FrogFamiliarUseTextTalkAndSpecial",
					UseTextTalkAndGift = "FrogFamiliarUseTextTalkAndCostume",
					UseTextGift = "FrogFamiliarUseTextCostume",
					UseTextGiftAndSpecial = "FrogFamiliarUseTextCostumeAndSpecial",
					UseTextTalkGiftAndSpecial = "FrogFamiliarUseTextTalkCostumeAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
						},
						{
							Path = { "CurrentHubRoom", "Name" },
							IsAny = { "Hub_PreRun" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
					},
					NamedRequirements = { "HasAllFrogUpgrades" },
				},
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					SpecialInteractFunctionName = "FrogFamiliarSpecialInteractUnlockedInHub",
					SpecialInteractCooldown = 30,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun" },
					},
				},
			},
		},

		-- Harvesting
		LinkedTool = "ToolExorcismBook",

		-- Hit Reactions
		OnHitFunctionName = "FrogHitResponse",
		OnHitForce = 800,
		OnHitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.25,
				ObjectType = "Hecate",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "HecatePolymorph" },
					},
				},
				Cooldowns =
				{
					{ Name = "HecateRecentHexDodgeVO", Time = 240 },
				},
				TriggerCooldowns = { "HecateSpokeRecently" },
				{ Cue = "/VO/HecateField_0137", Text = "That blasted little toad..." },
				{ Cue = "/VO/HecateField_0138", Text = "That hex was meant for {#Emph}you!", PlayFirst = true },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.5,
				ObjectType = "Eris",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsAny = { "SniperGunWeapon" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/ErisField_0427", Text = "Blocked?!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0428", Text = "What the?!" },
				{ Cue = "/VO/ErisField_0429", Text = "{#Emph}Frog!" },
				{ Cue = "/VO/ErisField_0430", Text = "That little...!" },
			},
		},

		-- Interaction
		InteractVoiceLines =
		{
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_Main" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ErisBecomingCloser01", "IcarusBecomingCloser01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeFrinosInteractSpeech", Time = 120 },
				},
				-- first run
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosSpeechFirstRun",
					PreLineWait = 0.4,
					BreakIfPlayed = true,
					--PreLineAnim = "MelTalkBrooding01",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Cleared" }
						},
						{
							PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
						},
					},

					{ Cue = "/VO/Melinoe_2948", Text = "See what I get for staying out all night, Frinos?" },
				},
				-- post-moros meeting 1
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
						},
					},

					{ Cue = "/VO/Melinoe_3438", Text = "I just met Doom Incarnate, Frinos...! Not sure I should be excited about that." },
				},
				-- post-moros meeting 2
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosSecondAppearance" },
						},
					},

					{ Cue = "/VO/Melinoe_3439", Text = "Happen to see a tall, horned fellow passing through...?" },
				},
				-- post-moros surface meeting
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
						},
					},

					{ Cue = "/VO/Melinoe_3440", Text = "The way you can breathe out of water... so too could I breathe the surface air." },
				},
				-- post-moros becoming closer
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
							IsAny = { "Choice_MorosAccept" },
						},
					},

					{ Cue = "/VO/Melinoe_5200", Text = "Last night was like a dream... the last part anyway. I wonder if Lord Moros is around." },
				},

				-- post-flashback02
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosNightmare01" },
						},
					},

					{ Cue = "/VO/Melinoe_2836", Text = "Chronos has my family... and the Fates themselves...? Oh, Frinos..." },
				},
				-- typhon destroyed
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					{ Cue = "/VO/Melinoe_5196", Text = "He's gone, Frinos... the Father of All Monsters. Now but one major threat remains.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny = { "ZeusPalaceAboutTyphonDeath01" },
							},
						},
					},
				},
				-- hecate missing
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					{ Cue = "/VO/Melinoe_5197", Text = "I have to do this... I have to do this... I have to do this...", IgnoreMute = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_5197" },
							},
							NamedRequirements = { "HecateMissing" },
						},
					},
				},
				-- true ending
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					{ Cue = "/VO/Melinoe_5198", Text = "Don't think I forgot about you, little one. We really did it, didn't we?",
						PlayOnce = true, PlayOnceContext = "FrinosUniqueVO",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "TextLinesRecord", "TrueEndingFinale01" },
							},
						},
					},
				},
				-- epilogue
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					{ Cue = "/VO/Melinoe_5199", Text = "Not every night you meet the Fates... perhaps I'm still in a bit of shock.",
						PlayOnce = true, PlayOnceContext = "FrinosUniqueVO",
						GameStateRequirements =
						{
							NamedRequirements = { "ReachedEpilogue" },
						},
					},
				},
				-- story reset
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosUniqueVO",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "StoryResetCount" },
							Comparison = ">=",
							Value = 1,
						},
						{
							SumPrevRuns = 4,
							Path = { "SpeechRecord", "/VO/Melinoe_5754" },
							CountPathTrue = true,
							Comparison = ">=",
							Value = 1,
						},
					},

					{ Cue = "/VO/Melinoe_5776", Text = "It's strange... ever get the feeling all this has already happened before, Frinos...?" },
				},

				-- dissolution of time hint
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosUniqueVO",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "BiomesReached", "F" }
						},
						{
							Path = { "GameState", "Resources", "MixerIBoss" },
							Comparison = ">=",
							Value = 7,
						},
						{
							PathTrue = { "GameState", "Resources", "HadesSpearPoints" },
						},
						{
							PathFalse = { "GameState", "Resources", "MixerMythic" },
						},
						{
							Path = { "GameState", "WorldUpgradesRevealed" },
							HasAny = { "WorldUpgradeTimeStop" },
						},
					},

					{ Cue = "/VO/Melinoe_5771", Text = "I need one more reagent for the Dissolution of Time... but I won't find it in the Underworld." },
				},
				-- successful clears
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					-- SuccessiveChanceToPlayAll = 0.25,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" },
						},
					},

					{ Cue = "/VO/Melinoe_5193", Text = "Such a night! Chronos, vanquished, and after that... you'd not believe it anyhow.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny = { "ZagreusPastFirstMeeting" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5726", Text = "I understand where Zagreus is coming from but... he hasn't had to go through any of this.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny = { "ZagreusPastMeeting04_2" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5728", Text = "I think my brother might be coming around. Perhaps I am. There has to be a way...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny = { "ZagreusPastMeeting04_3" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5773", Text = "My task, my methods... I just hope it works... and that Headmistress will understand.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny = { "ZagreusPastMeeting05" },
							},
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAll = { "ZagreusPastMeeting04_2", "ZagreusPastMeeting04_3" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5194", Text = "We're getting somewhere, Frinos... soon all this may finally be over.",
						PlayOnce = true,
						PlayOnceContext = "FrinosUniqueVO",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
							},
							{
								Path = { "CurrentRun", "TextLinesRecord" },
								HasAny =
								{
									"ZeusPalaceMeeting02",
									"ZeusPalaceMeeting03",
									"ZeusPalaceMeeting03_A",
									"ZeusPalaceMeeting03_B",
									"ZeusPalaceMeeting04",
									"ZeusPalaceMeeting04_B",
								},
							},
						},
					},
					{ Cue = "/VO/Melinoe_5775", Text = "Typhon is destroyed, Frinos...! Soon, I can end all this...",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "CurrentRun", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
							},
						},
					},
				},
				-- additional progress
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosUniqueVO",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
						},
						{
							PathTrue = { "GameState", "Resources", "HadesSpearPoints" },
						},
						{
							PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "F" }
						},
					},

					{ Cue = "/VO/Melinoe_5772", Text = "The Underworld and Zagreus shall have to wait a bit... I've business on Olympus still." },
				},
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosUniqueVO",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
						},
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasAll = { "ZagreusPastMeeting04_2", "ZagreusPastMeeting04_3" },
						},
						{
							PathTrue = { "CurrentRun", "BiomesReached", "F" }
						},
					},

					{ Cue = "/VO/Melinoe_5774", Text = "Frinos... if we could stop Chronos without destroying him... then shouldn't we...?" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					-- SuccessiveChanceToPlayAll = 0.25,
					GameStateRequirements =
					{
						{
							-- PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						},
						{
							PathTrue = { "CurrentRun", "Cleared" },
						},
					},

					{ Cue = "/VO/Melinoe_2846", Text = "You knew I could do it, didn't you, Frinos?" },
					{ Cue = "/VO/Melinoe_2848", Text = "A satisfactory result that time, wouldn't you say?" },
					{ Cue = "/VO/Melinoe_2850", Text = "Glad to be back here with you... but, it's a new night now..." },
					{ Cue = "/VO/Melinoe_5201", Text = "That's one fewer possibility that things will run afoul for us again.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5202", Text = "Shall we go again, Frinos? Perhaps we're dealing with infinite possibilities.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2845", Text = "Can you believe it, little one? I did it... I got him...! What now...?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" }
							},
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2847", Text = "We really showed {#Emph}him{#Prev}, didn't we, Frinos?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2849", Text = "Got him again. But we're not finished yet, are we?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "I_Boss01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2931", Text = "I suppose you'd not have liked it, living in that House instead of here...",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3953", Text = "{#Emph}Mmm-wah! {#Prev}We beat the Father of All Monsters, Frinos...!",
						PreLineWait = 1.1,
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
							},
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5195", Text = "I never imagined I'd see the Palace of Zeus with my own eyes... but I'm glad I'm back.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3953" }
							},
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Story01" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3954", Text = "That ought to slow Typhon a bit... or make him even angrier.",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
							},
							{
								Path = { "CurrentRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						},
					},

				},
				-- artemis singing
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "AudioState", "AmbientTrackName" },
							IsAny = { "/Music/ArtemisSong_MC" },
						},
					},

					{ Cue = "/VO/Melinoe_4025", Text = "Haven't heard our old song in a while, have you? Well enjoy it while she's here!" },
				},
				-- post-flashback01
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
						},
					},

					{ Cue = "/VO/Melinoe_2132", Text = "All my life I've prepared, and I'm nowhere near ready, am I..." },
				},
				-- considering recruiting Frinos
				{
					PlayOnce = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "WorldUpgradesRevealed" },
							HasAny = { "WorldUpgradeFamiliarPoints" },
						},
						{
							PathFalse = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" }
						},
					},

					{ Cue = "/VO/Melinoe_3145", Text = "One of these evenings you ought to join me out there, little one. Long as I can protect you." },
				},
				-- returned with Frinos as a familiar
				{
					PlayOnce = true,
					PlayOnceContext = "FrinosJoinedAndReturnedSpeech",
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "FrogFamiliar" },
						},
					},
					{ Cue = "/VO/Melinoe_1091", Text = "We made it back here safe and sound, didn't we, Frinos?" },
				},
				-- lost in Nemesis encounter
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
							IsAny = { "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
						},
					},
					{ Cue = "/VO/Melinoe_2316", Text = "Do you think Nemesis is trying to help, or just trying to win?" },
				},
				-- lost to Erebus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_1675", Text = "I've faced Root-Stalkers before... it's like I drew a blank out there..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_1676", Text = "How could I lose to some Shadow-Spiller like that? {#Emph}Ungh{#Prev}, unacceptable..." },
				},
				-- lost to Hecate
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "F_Boss01", "F_Boss02" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Hecate" },
						},
					},
					{ Cue = "/VO/Melinoe_1887", Text = "She was on her last legs, but I just couldn't finish the job.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
								Comparison = "<=",
								Value = 0.15,
							},
						},
					},
					{ Cue = "/VO/Melinoe_0091", Text = "Frinos, how can I ever beat the Headmistress...?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "HecateBossOutro01", },
							},
						},
					},
					{ Cue = "/VO/Melinoe_0092", Text = "The Headmistress got me again, Frinos... but I won't back down." },
					{ Cue = "/VO/Melinoe_2310", Text = "Feels like three against one when I face Headmistress out there..." },
					{ Cue = "/VO/Melinoe_2311", Text = "She's taught me to be stronger than this. I'll prove it to her yet..." },
				},
				-- lost to Oceanus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_5475", Text = "I shouldn't have lost to some Sea-Serpent, though that {#Emph}was {#Prev}a big one..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_2315", Text = "Some amphibians eat rodents, don't they, Frinos...?" },
					{ Cue = "/VO/Melinoe_5476", Text = "Unfortunately, that tiny vermin back there posed a significant problem...", PlayFirst = true },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_MiniBoss03" },
						},
					},
					{ Cue = "/VO/Melinoe_4127", Text = "Let's keep my failure to defeat a school of Hellifish our little secret..." },
				},

				-- lost to Scylla
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "G_Boss01", "G_Boss02" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Scylla" },
						},
					},
					{ Cue = "/VO/Melinoe_2312", Text = "Frinos, I can't get that blasted Siren song out of my head..." },
					{ Cue = "/VO/Melinoe_2313", Text = "Sirens are amphibious... you know their weaknesses, Frinos?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_5205", Text = "At least Scylla got to put on a big show like she always wanted, right?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 2,
							},
						},
					},
				},
				-- lost in Oceanus
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G" },
						},
					},
					{ Cue = "/VO/Melinoe_2314", Text = "You might like it down in Oceanus better than I do right now..." },
				},
				-- lost to Fields minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_2765", Text = "Phantoms must be thrilled to find fresh blood, I suppose..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_2764", Text = "I don't think you and Lamia would get along too well, Frinos..." },
				},
				-- lost to Cerberus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "H_Boss01", "H_Boss02" },
						},
						--[[
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						]]--
					},

					{ Cue = "/VO/Melinoe_2762", Text = "That was my family's dog... it has to be. I have to help him...!", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2763", Text = "Cerberus can't see through his rage... he needs our help, Frinos." },
					{ Cue = "/VO/Melinoe_5206", Text = "Cerberus more than lives up to his fierce reputation, doesn't he...?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				-- lost in Fields
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "H" },
						},
					},
					{ Cue = "/VO/Melinoe_2712", Text = "Well {#Emph}that {#Prev}was a decidedly unhappy place, wasn't it...?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_2714", Text = "My spirit nearly broke back there... I couldn't hold on." },
					{ Cue = "/VO/Melinoe_2715", Text = "Such misery and sorrow in those Fields... but I have to get through." },
				},
				-- lost to Chronos
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "I_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Chronos" },
						},
					},

					{ Cue = "/VO/Melinoe_2810", Text = "Chronos underestimates me still... which means I have a real chance to vanquish him..." },
					{ Cue = "/VO/Melinoe_5207", Text = "The Titan of Time... even with all my training I just couldn't beat him..." },
					{ Cue = "/VO/Melinoe_2809", Text = "I got all the way to Chronos... the one place I can beat him. But I couldn't do it. Not yet...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "EnemyKills", "Chronos" },
							},
						}
					},
				},
				-- lost in Tartarus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
					},
					{ Cue = "/VO/Melinoe_2840", Text = "Where does Chronos find those blasted Satyrs, anyway...?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name", },
								IsNone = { "I_MiniBoss02" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2837", Text = "Almost got there, but then, almost isn't good enough, is it?" },
					{ Cue = "/VO/Melinoe_2838", Text = "What have they done to Tartarus, Frinos? It's not like how I heard...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_2839", Text = "I expected the worst down in Tartarus, and I got it all right..." },
				},

				-- lost to Polyphemus
				{
					-- RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "N_Boss01", "N_Boss02" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Polyphemus" },
						},
					},

					{ Cue = "/VO/Melinoe_0359", Text = "You ever faced a Cyclops, Frinos? No?" },
					{ Cue = "/VO/Melinoe_3831", Text = "I figured Cyclopes were very strong, but didn't need to learn firsthand like that..." },
					{ Cue = "/VO/Melinoe_5204", Text = "Lady Medea, collaborating with Polyphemus? The will of Night can be {#Emph}quite {#Prev}strange...",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
				},
				-- lost in Ephyra
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "N" },
						},
						{
							PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						},
					},
					{ Cue = "/VO/Melinoe_2841", Text = "The air up there did not sit well with me at all...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_2842", Text = "Not my finest night back there, but I had to try..." },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "N" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsNone = { "N_Opening01", "N_PreHub01", "N_Boss01", "N_Boss02" },
						},
					},
					{ Cue = "/VO/Melinoe_2843", Text = "It's possible I'm not cut out for city life, Frinos..." },
					{ Cue = "/VO/Melinoe_2844", Text = "Not much in the way of hospitality in that big city up there..." },
				},

				-- lost to Eris
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "O_Boss01", "O_Boss02" },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Eris" },
						},
					},
					{ Cue = "/VO/Melinoe_3170", Text = "How can a daughter of Nyx turn against us? And give me such a drubbing, too...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_3171", Text = "No making peace with one such as Eris, is there? Just isn't in her nature." },
				},
				-- lost to Charybdis
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "O_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_3819", Text = "Few sailors live to speak of their encounters with Charybdis, so there's that, Frinos..." },
				},
				-- lost to Captain
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "O_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_4126", Text = "Where did that sea-captain procure a weapon so much like the Rail of Adamant...?" },
				},
				-- lost in Ships
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsNone = { "O_Boss01", "O_Boss02" },
						},
					},
					{ Cue = "/VO/Melinoe_3172", Text = "I'm getting the impression that the sailor's life is not for me." },
					{ Cue = "/VO/Melinoe_3173", Text = "I used to dream of sailing on the surface seas, but not like that..." },
				},

				-- lost to Prometheus
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_Boss01", },
						},
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" },
						},
					},
					{ Cue = "/VO/Melinoe_3817", Text = "If Prometheus knows everything that's going to happen, then he must know I'm not giving up..." },
					{ Cue = "/VO/Melinoe_3818", Text = "That Titan's hatred for the gods... it's clouded his senses. He can be beaten." },
					{ Cue = "/VO/Melinoe_5203", Text = "Turns out Prometheus has more than an eagle for a friend... best keep it quiet for now.",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 3,
							},
						},
					},
				},
				-- lost to Olympus minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_MiniBoss01" },
						},
					},
					{ Cue = "/VO/Melinoe_3820", Text = "So many problems on Olympus to contend with, and Talos is against me, too...?" },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "P_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_3821", Text = "You know things are bad on Olympus when Dracons not just Harpies are beginning to roost there." },
				},
				-- lost to Typhon minibosses
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "Q_MiniBoss02" },
						},
					},
					{ Cue = "/VO/Melinoe_4124", Text = "That monster last night more than compensated for a lack of intellect..." },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "Q_MiniBoss05" },
						},
					},
					{ Cue = "/VO/Melinoe_4125", Text = "Those monstrosities made me their prey... won't let that happen again..." },
				},
				-- lost to Typhon or on the Summit
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Cleared" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "Q" },
						},
						{
							PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
						},
					},

					{ Cue = "/VO/Melinoe_3950", Text = "I've trained to slay Chronos, not the Father of All Monsters... what do I do...?", PlayFirst = true },
					{ Cue = "/VO/Melinoe_4246", Text = "Typhon is not impervious, no matter how it seems. I have to get back there..." },
					{ Cue = "/VO/Melinoe_3951", Text = "I'd best get back up to Olympus before Typhon gets his way." },
					{ Cue = "/VO/Melinoe_3952", Text = "I'll get that blasted Typhon for this, Frinos. Just you watch." },
					{ Cue = "/VO/Melinoe_3955", Text = "Typhon's going to tear that mountain to the ground, unless..." },
					{ Cue = "/VO/Melinoe_5208", Text = "The Father of All Monsters and the Titan of Time, together... how can I possibly withstand them both...?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "Q_Boss02" },
							},
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = ">=",
								Value = 4,
							},
						},
					},
				},
				-- lost on Olympus or the Summit
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P", "Q" },
						},
					},
					{ Cue = "/VO/Melinoe_3822", Text = "The mountain of the gods unfortunately wasn't as welcoming as I would have preferred..." },
					{ Cue = "/VO/Melinoe_3823", Text = "Turns out that climbing Mount Olympus can be rather treacherous, Frinos.", PlayFirst = true },
				},
				-- lost to Zagreus
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlay = 0.1,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "Name", },
							IsAny = { "C_Boss01" },
						},
					},
					{ Cue = "/VO/Melinoe_5705", Text = "Turns out my brother's handy with a spear... while I was not exactly at my best.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_5706", Text = "Zagreus got me again... this absolutely cannot stand, Frinos." },
				},
				-- lost due to Oath / Shrine
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpentShrinePointsCache", },
							Comparison = ">=",
							Value = 8,
						},
						{
							Path = { "CurrentRun" },
							HasNone = { "Cleared", "BountyCleared" }
						},
					},
					{ Cue = "/VO/Melinoe_3060", Text = "{#Emph}Ungh{#Prev}, Frinos... perhaps I ought know better than to tamper with the Oath of the Unseen." },
					{ Cue = "/VO/Melinoe_3061", Text = "I spoke the Oath, it's only fair I face the consequence, Frinos..." },
				},
				-- been a while
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							SumPrevRuns = 4,
							Path = { "SpecialInteractRecord", "FrogFamiliar" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
					{ Cue = "/VO/Melinoe_5211", Text = "It's been a while since I spoke to you like this, I know..." },
				},
				-- raining
				{
					BreakIfPlayed = true,
					PreLineWait = 0.4,
					SuccessiveChanceToPlayAll = 0.15,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "NextBiomeStateName" },
							IsAny = { "Rain" },
						},
					},

					{ Cue = "/VO/Melinoe_1886", Text = "You're liking all this rain, right, little one?" },
				},
				-- other general cases
				{
					PreLineWait = 0.4,
					BreakIfPlayed = true,
					RandomRemaining = true,
					--PreLineAnim = "MelTalkBrooding01",

					{ Cue = "/VO/Melinoe_5209", Text = "Thank you for always being here for me...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5210", Text = "How are you liking our nightly routine of late, {#Emph}hm?",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_5212", Text = "Perhaps you'd like to come along with me again one of these nights.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "FrogFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarsUnlocked" },
								HasAll = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_1091", Text = "We made it back here safe and sound, didn't we, Frinos?",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_1091" },
							},
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "FrogFamiliar" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_1162", Text = "See, Frinos? I wasn't gone for very long at all.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "RunDepthCache" },
								Comparison = "<=",
								Value = 15,
							},
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 10,
							},
						},
					},
					{ Cue = "/VO/Melinoe_0831", Text = "Damn it, Frinos. I can't do this. What if I can't do this?",
						PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 8,
							},
							{
								PathTrue = { "GameState", "RoomCountCache", "N_Opening01" },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsNone = { "H", "I", "O", "P", "Q" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_0832", Text = "What happened there, Frinos? I should be better than this.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0833", Text = "I know I could have done better than that.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0090", Text = "Blasted wretch got me, Frinos. I'll keep a healthier distance next time." ,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name", },
								IsNone = { "F_Boss01", "F_Boss02" },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsAny = { "F", "H", "I", "N" },
							},
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_0012_V3", Text = "That positively didn't go as planned, Frinos. Will you ever forgive me?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0354", Text = "I blundered into that back there, didn't I, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0355", Text = "I think I made a few mistakes back there, Frinos.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0356", Text = "I'll have to be more careful, won't I, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_0360", Text = "You don't want to know what happened there, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_1677", Text = "You know what they say, Frinos: Failure is the greatest instructor of all.", PlayFirst = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						}
					},
					{ Cue = "/VO/Melinoe_2811", Text = "You can probably imagine how that went, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_2812", Text = "Just don't go telling anybody how I blundered back there, Frinos...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_2948", Text = "See what I get for staying out all night, Frinos?",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Cleared" }
							},
							{
								Path = { "CurrentRun", "BiomesReached" },
								HasAny = { "G", "O" },
							},
						},
					},
					{ Cue = "/VO/Melinoe_3824", Text = "What do you suppose I could have done differently last night, {#Emph}hm?",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun" },
								HasNone = { "Cleared", "BountyCleared" }
							},
						},
					},
					{ Cue = "/VO/Melinoe_3441", Text = "Always here for me, aren't you..." },
					{ Cue = "/VO/Melinoe_3442", Text = "Another night, another lesson learned..." },
					{ Cue = "/VO/Melinoe_3443", Text = "You're always watching over me... you and these little Shades..." },
					{ Cue = "/VO/Melinoe_0357", Text = "Thank you for helping me return, Frinos." },
					{ Cue = "/VO/Melinoe_0358", Text = "Hey Frinos. I had better go. So you take care." },
					{ Cue = "/VO/Melinoe_3825", Text = "I'm rested enough to press on, but you relax some more, all right?" },
					{ Cue = "/VO/Melinoe_3826", Text = "Thanks for looking after things around here while I was out, Frinos.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "FrogFamiliar" },
							},
						}
					},
					{ Cue = "/VO/Melinoe_3827", Text = "I'd best get back to it, Frinos. But I wanted to say hi before I headed off again." },
				},
			},
			-- cleared Chaos Trial (can occur in PreRun)
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlayAll = 0.15,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasAny = { "BountyCleared" }
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeFrinosInteractSpeech", Time = 120 },
				},
				{ Cue = "/VO/Melinoe_3062", Text = "These Chaos Trials... we're not changing reality {#Emph}too {#Prev}much, are we, Frinos?" },
				{ Cue = "/VO/Melinoe_3063", Text = "Either Chaos has an interest in my victory, or perhaps I'm just a bit of entertainment." },
			},
			-- multi-pet lines
			{
				PreLineWait = 0.4,
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1888", Text = "{#Emph}Mmm-mwah.", PreLineWait = 1.1, PlayFirst = true },
				{ Cue = "/VO/Melinoe_1889", Text = "{#Emph}Mmm-hmhmhm.", PreLineWait = 0.8 },
				{ Cue = "/VO/Melinoe_1890", Text = "You're always here for me." },
				{ Cue = "/VO/Melinoe_1891", Text = "Don't let me get you down." },
				{ Cue = "/VO/Melinoe_1892", Text = "You stay right there, OK?" },
				{ Cue = "/VO/Melinoe_1893", Text = "Come here you little bug.", PreLineWait = 0.6 },
			},
			{
				PreLineWait = 0.65,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1888", Text = "{#Emph}Mmm-mwah.", PreLineWait = 1.0, PlayFirst = true },
				{ Cue = "/VO/Melinoe_0351", Text = "{#Emph}<Laugh>",	PreLineWait = 0.4 },
				{ Cue = "/VO/Melinoe_0352", Text = "{#Emph}Hah." },
				{ Cue = "/VO/Melinoe_0353", Text = "{#Emph}Heh." },
				{ Cue = "/VO/Melinoe_0219", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Melinoe_0220", Text = "{#Emph}Heh." },
				{ Cue = "/VO/Melinoe_0577", Text = "{#Emph}Mm!" },
			},
		},
		SpecialInteractFunctionName = "PetFamiliarFrog",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
			{
				Path = { "CurrentHubRoom", "Name" },
				IsAny = { "Hub_Main", "Hub_PreRun" },
			},
		},

		-- Map Marker
		MarkerIdleAnimation = "FrogMarkerIdle",
		MarkerJumpAnimation = "FrogMarkerJump",
		MarkerModel = "FrogMarker_Mesh",
		MarkerMoveAnimation = "FrogMarkerMove",
		
		-- Sounds
		ConfirmSound = "/SFX/Familiars/FrogCroak1",
		EffortSound = "/SFX/Familiars/FrogCroak1",
		EquipSound = "/SFX/Familiars/FrogCroak2",
		HappySound = "/SFX/Familiars/FrogCroak2",
		HarvestSound = "/SFX/Familiars/FrogCroakAngry1",
		LeapChargeSound = "/SFX/Familiars/FrogCroak2",
		LeapSound = "/SFX/Familiars/FrogLeap",
		VictorySound = "/SFX/Familiars/FrogCroakAngry2",

		-- Teleport VFX
		TeleportVfxOffsetY = -60,
		TeleportVfxScale = 1.0,

		-- Text
		AlwaysShowDefaultUseText = true,
		UseTextGift = "FamiliarUseTextGift_First",
		UseTextGiftAndSpecial = "FamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "FamiliarUseTextSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkGiftAndSpecial = "FamiliarUseTextTalkGiftAndSpecial",
		UseTextTalkAndSpecial = "FamiliarUseTextTalkAndSpecial",

		-- Traits
		TraitNames = { "HealthFamiliar", "FamiliarFrogResourceBonus", "FamiliarFrogDamage" },

		-- Usings
		Using = { Projectile = "FrogFamiliarLand" },
	},

	-- Toula
	CatFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
			},
		},

		-- AI
		ActivateDistance = 200,
		ActivateDistanceScaleY = 0.55,
		AIOptions = { "CatFamiliarAI" },
		AttackDistance = 400,
		AttackVelocity = 2000,
		MinDistanceToTeleportToHero = 550,
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 1.0,
			},
		},
		ScanMaxAttempts = 12,
		ScanWaitDuration = 0.25,
		TargetSearchDistance = 1800,
		WanderDistance = 700,
		WanderDistanceScaleY = 0.6,

		-- Attack VO
		PreAttackVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				ChanceToPlay = 0.2,
				PreLineWait = 0.15,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = GameData.CombatUniqueEncounters,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "UsedCatFamiliarRecently", Time = 400 },
				},

				{ Cue = "/VO/Melinoe_3969", Text = "Toula!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3970", Text = "Go, Toula!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3971", Text = "Toula, {#Emph}now!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3972", Text = "Up, Toula!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3973", Text = "Come on, cat!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3974", Text = "Toula.",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3975", Text = "Toula?",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_3976", Text = "{#Emph}Tktktk!" },
			},
		},

		-- Animations
		ActivateVFX = "CatFamiliarRecruitHighlight",
		FleeAnimation = "Familiar_Cat_DropIn_Exit",
		HappyAnimation = "Familiar_Cat_Greet",
		IdleAnimation = "Familiar_Cat_Idle",
		StartNewRunAnimation = "Familiar_Cat_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Cat_Meow",
		AlwaysPlayTurnInPlaceAnimation = true,

		-- Equipping
		EquipObjective = "ActivateCatFamiliar",
		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidToulaRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2502", Text = "Come, Toula." },
				{ Cue = "/VO/Melinoe_2503", Text = "With me, Toula." },
				{ Cue = "/VO/Melinoe_3882", Text = "Come on, Toula." },
			},
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},

		-- Events
		EncounterStartEvents =
		{
			{
				Threaded = true,
				FunctionName = "CatFamiliarTeleportToHeroPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "TeleportCatFamiliarOnEncounterStart" },
					},
				},
			},
		},
		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					OverwriteSourceKeys =
					{
						ReadyToAttack = false,
					},
					SetAnimation = "Familiar_Cat_Victory",
					Sound = "/SFX/Familiars/CatMeow1",
					EndFunctionName = "GenericPresentation",
					EndFunctionArgs =
					{
						PreWait = 6.0,
						OverwriteSourceKeys =
						{
							ReadyToAttack = true,
						}
					},
				},
			},
		},
		LastStandEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 0.05,
					OverwriteSourceKeys =
					{
						ReadyToAttack = false,
					},
					AngleTowardHero = true,
					SetAnimation = "Familiar_Cat_DeathDefiance",
					Sound = "/SFX/Familiars/CatMeow1",
					EndFunctionName = "GenericPresentation",
					EndFunctionArgs =
					{
						PreWait = 5.0,
						OverwriteSourceKeys =
						{
							ReadyToAttack = true,
						}
					},
				},
			},
		},
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Cat_DropIn_Exit",
					StopMovement = true,
					VfxDelay = 0.2,
					StopAnimations = { "CatFamiliarRecruitHighlight" },
				},
			},
		},
		UpgradedEvents =
		{
			{
				FunctionName = "CatFamiliarGiftedPresentation",
				Threaded = true,
			},
		},
		PostCostumeChangedEvents =
		{
			{
				FunctionName = "CatFamiliarCostumedPresentation",
				Threaded = true,
			},
		},

		-- Functions
		ActivatePresentationFunctionName = "CatFamiliarSpawnPresentation",
		MoveFunctionName = "CatFamiliarMoveToLocation",
		OnFieldsEncounterActivatedFunctionName = "CatFamiliarTeleportToHeroPresentation",
		StopAIFunctionName = "CatFamiliarStopAI",

		-- Gifting / Recruiting / Costuming
		DefaultCostume = "FamiliarCostume_CatDefault",
		FamiliarShopGraphic = "FamiliarShopCat",
		GiftFunctionName = "FamiliarRecruitPresentation",
		GiftFunctionArgs =
		{
			Text = "CatFamiliar",
			Icon = "FamiliarIcon_Cat",

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Cat_Recruit",
			UnlockEndAnimation = "Familiar_Cat_Sleep_Awaken",
			UnlockExitAnimation = "Familiar_Cat_DropIn_Exit",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "CatFamiliar" },
			},
		},
		RecruitVoiceLines =
		{
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_1915", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_1916", Text = "We do! Your name is Toula, isn't it?", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_1918", Text = "Let us protect each other from now on.", PreLineWait = 0.8  },
		},
		SetupEvents =
		{
			{
				FunctionName = "SetupFamiliarCostume",
				GameStateRequirements =
				{
					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
			},
			{
				-- Toula not fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "CatFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					NamedRequirementsFalse = { "HasAllCatUpgrades" },
				},
			},
			{
				-- Toula fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					ReceiveGiftFunctionName = "GiftFamiliarCostume",
					UseTextGift = "CatFamiliarUseTextCostume",
					UseTextTalkAndGift = "CatFamiliarUseTextTalkAndCostume",
					UseTextGiftAndSpecial = "CatFamiliarUseTextCostumeAndSpecial",
					UseTextTalkGiftAndSpecial = "CatFamiliarUseTextTalkCostumeAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					NamedRequirements = { "HasAllCatUpgrades" },
				},
			},
		},

		-- Harvesting
		LinkedTool = "ToolFishingRod",
		MinDistanceToTeleportForFishing = 550,

		-- Interaction
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},


				{ Cue = "/VO/Melinoe_0983", Text = "Are you lost, little one?", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_0985", Text = "Don't be afraid...", },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
				{ Cue = "/VO/Melinoe_1961", Text = "{#Emph}Huh..." },
				{ Cue = "/VO/Melinoe_0578", Text = "{#Emph}Hrm." },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoePettedCatSpeech", Time = 12 },
				},

				{ Cue = "/VO/Melinoe_3398", Text = "Good girl." },
				{ Cue = "/VO/Melinoe_3399", Text = "There's a good girl.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3400", Text = "Hey..." },
				{ Cue = "/VO/Melinoe_3401", Text = "What's the good word...?" },
				{ Cue = "/VO/Melinoe_3402", Text = "{#Emph}<Chuckle>" },
				{ Cue = "/VO/Melinoe_3403", Text = "{#Emph}Tk-tk-tk." },
				{ Cue = "/VO/Melinoe_3404", Text = "{#Emph}Tk-tk-tk-tk!" },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
			},
		},
		SpecialInteractCooldown = 30,
		SpecialInteractFunctionName = "CatFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "CatFamiliarReadyToRecruit" },
		},

		-- Map Marker
		MarkerIdleAnimation = "CatMarkerIdle",
		MarkerJumpAnimation = "CatMarkerJump",
		MarkerModel = "CatMarker_Mesh",
		MarkerMoveAnimation = "CatMarkerMove",

		-- Sounds
		AlertedSound = "/Leftovers/SFX/PositiveTalismanProc_1",
		ConfirmSound = "/SFX/Familiars/CatMeow1",
		EquipSound = "/SFX/Familiars/CatMeow1",
		HappySound = "/SFX/Familiars/CatPurr",

		-- Teleport VFX
		TeleportVfxOffsetY = 0,
		TeleportVfxScale = 0.8,

		-- Text
		AlwaysShowDefaultUseText = true,
		UseTextGift = "CatFamiliarUseTextGift_First",
		UseTextGiftAndSpecial = "CatFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "CatFamiliarUseTextSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "CatFamiliarUseTextTalkAndSpecial",
		UseTextTalkGiftAndSpecial = "CatFamiliarUseTextTalkGiftAndSpecial",

		-- Traits
		TraitNames = { "LastStandFamiliar", "FamiliarCatResourceBonus", "FamiliarCatAttacks" },

		-- Usings
		Using = { Projectile = "CatFamiliarPounce", GrannyModel = { "CatFamiliar_Wild_Mesh" } },
	},

	-- Raki
	RavenFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
			},
		},

		-- AI
		AIOptions = { "RavenFamiliarAI" },
		AttackDistance = 100,
		InitialWaitRange = 200,
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			}
		},
		StopAIOnRunClear = true,
		TeleportWhenStoppedThreadName = "RavenFamiliar_TeleportWhenStopped",
		TargetSearchDistance = 900,

		-- Animations
		IdleAnimation = "Familiar_Raven_Perched_Idle",
		HappyAnimation = "Familiar_Raven_Victory_Perch",
		FleeAnimation = "Familiar_Raven_Perch_End",

		-- Equipping
		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidRakiRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2504", Text = "Come, Raki." },
				{ Cue = "/VO/Melinoe_2505", Text = "Come along, Raki." },
				{ Cue = "/VO/Melinoe_3881", Text = "Onward, Raki." },
				{ Cue = "/VO/Melinoe_0847", Text = "Come, little one, let's go." },
			},
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
		KitAngle = 230,

		-- Events
		EncounterEndEvents =
		{
			{
				FunctionName = "RavenFamiliarVictoryPresentation",
				Threaded = true,
			},
		},
		LeaveEvents =
		{
			{
				FunctionName = "RavenFamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					RoomExitAnimation = "Familiar_Raven_DropIn_Exit",
					VfxDelay = 0.2,
					VfxOffsetY = -80,
					VfxScale = 1.1,
				},
			},
		},

		-- Flight
		FlightHeight = 150,
		GroundHeight = 0,
		IgnoreGravity = true,
		SkyHeight = 800,

		-- Functions
		ActivatePresentationFunctionName = "RavenFamiliarSpawnPresentation",
		LinkBeginFunctionName = "RavenFamiliarLinkBegin",
		MoveFunctionName = "RavenFamiliarMoveToLocation",
		StartNewRunFunctionName = "FamiliarRavenStartNewRunPresentation",
		StopAIFunctionName = "RavenFamiliarStopAI",
		TurnInPlaceAnimation = "Familiar_Raven_Victory_Perch",

		-- Gifting / Recruiting / Costuming
		DefaultCostume = "FamiliarCostume_RavenDefault",
		FamiliarShopGraphic = "FamiliarShopRaven",
		GiftFunctionName = "FamiliarRecruitPresentation",
		GiftFunctionArgs =
		{
			Text = "RavenFamiliar",
			Icon = "FamiliarIcon_Raven",

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Raven_Pet",
			UnlockEndAnimation = "Familiar_Raven_Victory_Perch_Fast",
			UnlockExitAnimation = "Familiar_Raven_Perch_End",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "RavenFamiliar" },
			},
		},
		RecruitVoiceLines =
		{
			PreLineWait = 0.35,

			{ Cue = "/VO/MelinoeField_1915", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_1917", Text = "We do! Raki, pleased to meet you.", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_1918", Text = "Let us protect each other from now on.", PreLineWait = 0.8 },
		},
		SetupEvents =
		{
			{
				FunctionName = "SetupFamiliarCostume",
				GameStateRequirements =
				{
					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
			},
			{
				-- Raki not fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "RavenFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
					},
					NamedRequirementsFalse = { "HasAllRavenUpgrades" },
				},
			},
			{
				-- Raki fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					ReceiveGiftFunctionName = "GiftFamiliarCostume",
					UseTextGift = "RavenFamiliarUseTextCostume",
					UseTextTalkAndGift = "RavenFamiliarUseTextTalkAndCostume",
					UseTextGiftAndSpecial = "RavenFamiliarUseTextCostumeAndSpecial",
					UseTextTalkGiftAndSpecial = "RavenFamiliarUseTextTalkCostumeAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
					},
					NamedRequirements = { "HasAllRavenUpgrades" },
				},
			},
		},

		-- Harvesting
		LinkedTool = "ToolPickaxe",
		MinDistanceToTeleportWhenMining = 550,

		-- Interaction
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Melinoe_0984", Text = "Greetings, little raven.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0986", Text = "I won't hurt you...", },
				{ Cue = "/VO/Melinoe_3864", Text = "Little raven..." },
				{ Cue = "/VO/Melinoe_3865", Text = "You're an unusual fellow." },
				{ Cue = "/VO/Melinoe_3866", Text = "You're always here..." },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoePettedBirdSpeech", Time = 12 },
				},

				{ Cue = "/VO/Melinoe_3782", Text = "You're a fine bird." },
				{ Cue = "/VO/Melinoe_3783", Text = "Hello, Raki." },
				{ Cue = "/VO/Melinoe_3784", Text = "You're all right, Raki." },
				{ Cue = "/VO/Melinoe_3785", Text = "Easy now, Raki." },
				{ Cue = "/VO/Melinoe_3786", Text = "Good bird.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3787", Text = "It's going to be all right." },
				{ Cue = "/VO/Melinoe_3867", Text = "Good evening, little raven." },
				{ Cue = "/VO/Melinoe_0984", Text = "Greetings, little raven.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3864", Text = "Little raven..." },
			},
		},
		SpecialInteractCooldown = 30,
		SpecialInteractFunctionName = "RavenFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "RavenFamiliarReadyToRecruit" },
		},

		-- Map Marker
		MarkerIdleAnimation = "RavenMarkerIdle",
		MarkerJumpAnimation = "RavenMarkerJump",
		MarkerModel = "RavenMarker_Mesh",
		MarkerMoveAnimation = "RavenMarkerMove",

		-- Sounds
		EquipSound = "/SFX/Familiars/RavenSquawk3",
		HappySound = "/SFX/Familiars/RavenGentleSquawk",
		HarvestSound = "/SFX/Familiars/RavenSquawkAngry",
		VictorySound = "/SFX/Familiars/RavenSquawk3",

		-- Teleport VFX
		TeleportVfxOffsetY = 60,
		TeleportVfxScale = 0.8,

		-- Text
		AlwaysShowDefaultUseText = true,
		UseTextGift = "RavenFamiliarUseTextGift_First",
		UseTextGiftAndSpecial = "RavenFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "RavenFamiliarUseTextSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "RavenFamiliarUseTextTalkAndSpecial",
		UseTextTalkGiftAndSpecial = "RavenFamiliarUseTextTalkGiftAndSpecial",

		-- Traits
		TraitNames = { "CritFamiliar", "FamiliarRavenResourceBonus", "FamiliarRavenAttackDuration" },

		-- Usings
		Using = { ProjectileNames = { "RavenFamiliarMelee", "RavenFamiliarMelee_Crit", }, GrannyModel = { "RavenFamiliar_Wild_Mesh" } },
	},

	-- Hecuba
	HoundFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
			},
		},

		-- AI
		AIOptions = { "HoundFamiliarAI" },
		BarkRange = 250,
		FollowRestDistance = 500,		-- distance within which to not follow the player
		FollowRestDistanceNonCombat = 400,
		FollowRestDistanceScaleY = 0.6,
		HealthDigReward = "HealDropMinor",
		HeroHealthPercentForDig = 0.51, -- if you're below this % health, the hound can dig up health
		HeroManaPercentForDig = 0.7, -- if you're below this % mana, the hound can dig up mana
		ManaDigReward = "ManaDropMinorHound",
		MaxManaDigsPerEncounter = 1,
		MoveRestTime = 0.3,
		MoveRestTimeLinked = 0.2,
		TimeBetweenDigsMax = 16.0,
		TimeBetweenDigsMin = 12.0,

		-- Animations
		IdleAnimation = "Familiar_Hound_Sit_Idle",
		HappyAnimation = "Familiar_Hound_Greet",
		FleeAnimation = "Familiar_Hound_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Hound_Turn",
		PostUpgradeUnequippedAnimation = "Familiar_Hound_StandToSit",
		StartNewRunAnimation = "Familiar_Hound_DropIn_Exit",

		-- Equipping
		AnimOffsetZ = 190,
		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidHecubaRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2497", Text = "Hecuba, would you accompany me on my task?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "HecubaFirstEquipVO" },
				{ Cue = "/VO/Melinoe_2508", Text = "Come, Hecuba." },
				{ Cue = "/VO/Melinoe_2509", Text = "Here, girl." },
				{ Cue = "/VO/Melinoe_3883", Text = "Onward, Hecuba." },
			},
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
		KitAngle = 300,

		-- Events
		EncounterEndEvents =
		{
			{
				FunctionName = "FamiliarVictoryPresentation",
				Threaded = true,
				Args =
				{
					SetAnimation = "Familiar_Hound_Greet",
					Sound = "/SFX/Familiars/DogBarkDiscovery",
				},
			},
		},
		EncounterStartEvents =
		{
			{
				FunctionName = "HoundFamiliarStartEncounter"
			},
		},
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					VfxDelay = 0.2,
					StopMovement = true,
					RoomExitAnimation = "Familiar_Hound_DropIn_Exit",
				},
			},
		},
		UpgradedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					SetAnimation = "Familiar_Hound_Greet",
					Sound = "/SFX/Familiars/DogBarkMisc2",
				},
			},
		},

		-- Functions
		ActivatePresentationFunctionName = "HoundFamiliarSpawnPresentation",
		MoveFunctionName = "HoundFamiliarMoveToLocation",
		StopAIFunctionName = "HoundFamiliarStopAI",

		-- Gifting / Recruiting / Costuming
		DefaultCostume = "FamiliarCostume_HoundDefault",
		FamiliarShopGraphic = "FamiliarShopHound",
		GiftFunctionName = "FamiliarRecruitPresentation",
		GiftFunctionArgs =
		{
			Text = "HoundFamiliar",
			Icon = "FamiliarIcon_Hound",

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Hound_Greet",
			UnlockEndAnimation = "Familiar_Hound_Dig",
			UnlockExitAnimation = "Familiar_Hound_DropIn_Exit",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "HoundFamiliar" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" },
			},
		},
		RecruitVoiceLines =
		{
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_2545", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_2546", Text = "Of course we do! Hecuba, the honor is mine.", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_2547", Text = "We shall protect each other from now on.", PreLineWait = 0.8 },
		},
		SetupEvents =
		{
			{
				FunctionName = "SetupFamiliarCostume",
				GameStateRequirements =
				{
					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
			},
			{
				-- Hecuba not fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "HoundFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
					},
					NamedRequirementsFalse = { "HasAllHoundUpgrades" },
				},
			},
			{
				-- Hecuba fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					ReceiveGiftFunctionName = "GiftFamiliarCostume",
					UseTextGift = "HoundFamiliarUseTextCostume",
					UseTextTalkAndGift = "HoundFamiliarUseTextTalkAndCostume",
					UseTextGiftAndSpecial = "HoundFamiliarUseTextCostumeAndSpecial",
					UseTextTalkGiftAndSpecial = "HoundFamiliarUseTextTalkCostumeAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
					},
					NamedRequirements = { "HasAllHoundUpgrades" },
				},
			},
		},
		PostCostumeChangedEvents =
		{
			{
				Threaded = true,
				FunctionName = "GenericPresentation",
				Args =
				{
					PreWait = 0.5,
					SetAnimation = "Familiar_Hound_StandToSit",
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsNone = { "HoundFamiliar" },
					},
				},
			},
		},

		-- Harvesting
		LinkedTool = "ToolShovel",
		MinDistanceToTeleportForShovelPoints = 650,

		-- Interaction
		InteractVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoePettedHoundSpeech", Time = 12 },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/MelinoeField_2816", Text = "Here on a scouting mission for Headmistress, girl?", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2819", Text = "We've come so far from the Crossroads, haven't we?" },
				{ Cue = "/VO/MelinoeField_2817", Text = "I've not seen Gale anywhere, have you?",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "SpecialInteractRecord", "PolecatFamiliar" }
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasNone = { "/VO/MelinoeField_3049", "/VO/MelinoeField_3050" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3330", Text = "Should check in with Headmistress about you.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_2816" }
						},
						{
							PathFalse = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" }
						},
						NamedRequirements = { "HecateFamiliarsCanBeRecruited" },
					},
				},
				{ Cue = "/VO/MelinoeField_2818", Text = "You keep an eye on Echo there, all right?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Echo_01" }, Alive = true },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
						},
					},
				},
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Melinoe_3776", Text = "Who's a good girl?" },
				{ Cue = "/VO/Melinoe_3777", Text = "You're a good girl." },
				{ Cue = "/VO/Melinoe_3778", Text = "Headmistress raised you well." },
				{ Cue = "/VO/Melinoe_3779", Text = "You're all right." },
				{ Cue = "/VO/Melinoe_3780", Text = "Good girl, Hecuba.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3781", Text = "Hail Hecuba." },
			},
		},
		SpecialInteractCooldown = 30,
		SpecialInteractFunctionName = "HoundFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "HoundFamiliarReadyToRecruit" },
		},

		-- Map Marker
		MarkerIdleAnimation = "HoundMarkerIdle",
		MarkerJumpAnimation = "HoundMarkerJump",
		MarkerModel = "HoundMarker_Mesh",
		MarkerMoveAnimation = "HoundMarkerMove",

		-- Sounds
		EquipSound = "/SFX/Familiars/DogBarkMisc1",
		FoundLootSound = "/SFX/Familiars/DogBarkDiscovery",
		HappySound = "/SFX/Familiars/DogBarkMisc2",
		SensedLootSound = "/SFX/Familiars/DogGrowlPlayful",

		-- Text
		AlwaysShowDefaultUseText = true,
		UseTextGift = "HoundFamiliarUseTextGift_First",
		UseTextGiftAndSpecial = "HoundFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "HoundFamiliarUseTextSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "HoundFamiliarUseTextTalkAndSpecial",
		UseTextTalkGiftAndSpecial = "HoundFamiliarUseTextTalkGiftAndSpecial",

		-- Teleport VFX
		TeleportVfxOffsetY = -60,
		TeleportVfxScale = 1.0,

		-- Traits
		TraitNames = { "DigFamiliar", "FamiliarHoundResourceBonus", "FamiliarHoundBarkDuration" },

		-- Usings
		Using =
		{
			Projectile = { "HoundFamiliarBark" },
			Animation =
			{
				"Familiar_Hound_Attack",
				"Familiar_Hound_Dig",
				"ShovelDirtInSprayHound",
				"ShovelDirtInSprayHound",
				"ShovelDirtOutSprayHound",
			},
		}, 
	},

	-- Gale
	PolecatFamiliar = 
	{
		InheritFrom = { "BaseFamiliar" },
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar" },
			},
		},

		-- AI
		AIOptions = { "PolecatFamiliarAI" },
		AttackDistance = 100,
		BurrowCooldown = 30,			-- how long to remain burrowed
		BurrowCooldownThreadName = "PolecatFamiliarBurrowCooldown",
		FollowRadius = 120,				-- tries to stay within this many units of the player
		FollowRestDistance = 500,		-- distance within which to not follow the player
		FollowRestDistanceScaleY = 0.6,

		-- Attack VO
		PreAttackVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.12,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.CombatUniqueEncounters,
				},
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "UsedPolecatFamiliarRecently", Time = 400 },
			},

			{ Cue = "/VO/MelinoeField_3294", Text = "{#Emph}Gale!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_3295", Text = "Thank you!" },
			{ Cue = "/VO/MelinoeField_3296", Text = "Cheers, Gale!" },
			{ Cue = "/VO/MelinoeField_3297", Text = "Gale, {#Emph}attack!" },
			{ Cue = "/VO/MelinoeField_3298", Text = "Get 'em, Gale!" },
			{ Cue = "/VO/MelinoeField_3299", Text = "Cheers!" },
		},

		-- Animations
		IdleAnimation = "Familiar_Polecat_Idle",
		HappyAnimation = "Familiar_Polecat_Greet",
		FleeAnimation = "Familiar_Polecat_DropIn_Exit",
		TurnInPlaceAnimation = "Familiar_Polecat_Victory",
		StartNewRunAnimation = "Familiar_Polecat_DropIn_Exit",

		-- Equipping
		AnimOffsetZ = 190,
		EquipVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeMiscFamiliarEquipSpeech", Time = 40 },
					{ Name = "SaidGaleRecently", Time = 20 },
				},
				{ Cue = "/VO/Melinoe_2496", Text = "Gale, may I have the honor of your company?" },
				{ Cue = "/VO/Melinoe_2506", Text = "Come, Gale." },
				{ Cue = "/VO/Melinoe_2507", Text = "Let's go, Gale.", PlayFirst = true },
			},
			{ GlobalVoiceLines = "FamiliarEquipVoiceLines" },
		},
		KitAngle = 233,

		-- Events
		EncounterEndEvents =
		{
			{
				FunctionName = "PolecatFamiliarVictoryPresentation",
				Threaded = true,
			},
		},
		EncounterStartEvents =
		{
			{
				FunctionName = "PolecatFamiliarStartEncounter",
				Threaded = true,
			},
		},
		UpgradedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Threaded = true,
				Args =
				{
					PreWait = 1.0,
					SetAnimation = "Familiar_Polecat_Greet",
					Sound = "/SFX/Familiars/PolecatAcknowledged1",
				},
			},
		},
		LeaveEvents =
		{
			{
				FunctionName = "FamiliarRoomExitPresentation",
				Threaded = true,
				Args =
				{
					VfxDelay = 0.3,
					StopMovement = true,
					RoomExitAnimation = "Familiar_Polecat_DropIn_Exit",
				},
			},
		},

		-- Functions
		ActivatePresentationFunctionName = "PolecatFamiliarSpawnPresentation",
		MoveFunctionName = "PolecatFamiliarMoveToLocation",
		StopAIFunctionName = "PolecatFamiliarStopAI",

		-- Gifting / Recruiting / Costuming
		DefaultCostume = "FamiliarCostume_PolecatDefault",
		FamiliarShopGraphic = "FamiliarShopPolecat",
		GiftFunctionName = "FamiliarRecruitPresentation",
		GiftFunctionArgs =
		{
			Text = "PolecatFamiliar",
			Icon = "FamiliarIcon_Polecat",

			UnlockSequenceDuration = 9,
			UnlockStartAnimation = "Familiar_Polecat_Victory",
			UnlockEndAnimation = "Familiar_Polecat_Attack",
			UnlockExitAnimation = "Familiar_Polecat_Burrow",
		},
		GiftGameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "SpecialInteractRecord", "PolecatFamiliar" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsFamiliars01" },
			},
		},
		RecruitVoiceLines =
		{
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},

			{ Cue = "/VO/MelinoeField_3053", Text = "If this treat is to your liking then it means we share a bond." },
			{ Cue = "/VO/MelinoeField_3054", Text = "Of course we do! Gale, the honor is mine.", PreLineWait = 0.8 },
			{ Cue = "/VO/MelinoeField_3055", Text = "Let us protect each other from now on.", PreLineWait = 0.8 },
		},
		SetupEvents =
		{
			{
				FunctionName = "SetupFamiliarCostume",
				GameStateRequirements =
				{
					{
						PathFalse = { "MapState", "CosmeticPresentationActive" },
					},
				},
			},
			{
				-- Gale not fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					GiftFunctionName = "GiftFamiliarUpgrade",
					UseTextGift = "FamiliarUseTextGift",
					UseTextGiftAndSpecial = "PolecatFamiliarUseTextGiftAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarUpgradeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar" },
					},
					NamedRequirementsFalse = { "HasAllPolecatUpgrades" },
				},
			},
			{
				-- Gale fully upgraded
				FunctionName = "OverwriteSelf",
				Args =
				{
					ReceiveGiftFunctionName = "GiftFamiliarCostume",
					UseTextGift = "PolecatFamiliarUseTextCostume",
					UseTextTalkAndGift = "PolecatFamiliarUseTextTalkAndCostume",
					UseTextGiftAndSpecial = "PolecatFamiliarUseTextCostumeAndSpecial",
					UseTextTalkGiftAndSpecial = "PolecatFamiliarUseTextTalkCostumeAndSpecial",
					GiftGameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeFamiliarCostumeSystem" },
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar" },
					},
					NamedRequirements = { "HasAllPolecatUpgrades" },
				},
			},
		},

		-- Harvesting
		LinkedTool = "ToolHarvest",
		MinDistanceToTeleportForHarvestPoints = 650,

		-- Interaction
		InteractVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoePettedHoundSpeech", Time = 12 },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				{ Cue = "/VO/MelinoeField_3051", Text = "What are you doing all the way up here?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3963", Text = "How goes it, Gale?" },
				{ Cue = "/VO/Melinoe_3964", Text = "You're looking well, Gale." },
				{ Cue = "/VO/Melinoe_3966", Text = "Feeling feisty, are we...?" },
				{ Cue = "/VO/Melinoe_3968", Text = "You're always raring to go." },
			},
			{
				PreLineWait = 0.4,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Melinoe_3963", Text = "How goes it, Gale?" },
				{ Cue = "/VO/Melinoe_3964", Text = "You're looking well, Gale." },
				{ Cue = "/VO/Melinoe_3965", Text = "Thanks for watching out for me." },
				{ Cue = "/VO/Melinoe_3966", Text = "Feeling feisty, are we...?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3967", Text = "Up for another journey?" },
				{ Cue = "/VO/Melinoe_3968", Text = "You're always raring to go." },
			},
		},
		SpecialInteractCooldown = 30,
		SpecialInteractFunctionName = "PolecatFamiliarSpecialInteractUnlockedInHub",
		SpecialInteractGameStateRequirements =
		{
			NamedRequirementsFalse = { "PolecatFamiliarReadyToRecruit" },
		},

		-- Map Marker
		MarkerIdleAnimation = "PolecatMarkerIdle",
		MarkerJumpAnimation = "PolecatMarkerJump",
		MarkerModel = "PolecatMarker_Mesh",
		MarkerMoveAnimation = "PolecatMarkerMove",

		-- Sounds
		EquipSound = "/SFX/Familiars/PolecatAcknowledged1",
		HappySound = "/SFX/Familiars/PolecatHappy3",
		ConfirmSound = "/SFX/Familiars/PolecatChitter1",
		RushSound = "/SFX/Familiars/PolecatChitter1",
		HarvestSound = "/SFX/Familiars/PolecatAcknowledged1",
		VictorySound = "/SFX/Familiars/PolecatAngry",

		-- Teleport VFX
		TeleportVfxOffsetY = 0,
		TeleportVfxScale = 0.7,

		-- Text
		AlwaysShowDefaultUseText = true,
		UseTextGift = "PolecatFamiliarUseTextGift_First",
		UseTextGiftAndSpecial = "PolecatFamiliarUseTextGiftAndSpecial_First",
		UseTextSpecial = "PolecatFamiliarUseTextSpecial",
		UseTextTalkAndGift = "FamiliarUseTextTalkAndGift",
		UseTextTalkAndSpecial = "PolecatFamiliarUseTextTalkAndSpecial",
		UseTextTalkGiftAndSpecial = "PolecatFamiliarUseTextTalkGiftAndSpecial",

		-- Traits
		TraitNames = { "DodgeFamiliar", "FamiliarPolecatResourceBonus", "FamiliarPolecatDamage" },

		-- Usings
		Using = { Projectile = "PolecatFamiliarMelee" },
	},
}

TraitSetData.Familiar =
{
	FamiliarTrait = 
	{
		Icon = "Keepsake_Skelly_Tooth",
		Slot = "Familiar",
		HideInHUD = true,
		HideInRunHistory = true,
		FamiliarTrait = true,
		DebugOnly = true,
	},

	-- Frog / Frinos

	HealthFamiliar =
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Frog",
		StacksAddBeforeRemove = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 10,
				ChangeType = "Add",
				MaintainDelta = true,
				ReportValues = { ReportedHealthBonus = "ChangeValue"}
			},
		},
		CirceStatLine = "BonusLifeStatDisplay1_Circe",
		StatLines =
		{
			"BonusLifeStatDisplay1",
			"LinkedExorcismBookUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "HealthBonus"
			},
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "BonusChance",
				Format = "TotalHeroTraitValuePercent",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "FrogFamiliar_FlavorText",
	},

	FamiliarFrogResourceBonus =
	{
		Hidden = true,
		FamiliarResourceBonusChance =
		{
			BaseValue = 0.20,
			AbsoluteStackValues =
			{
				[1] = 0.10,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "ChanceBonus",
				Format = "Percent",
			},
		},
	},

	FamiliarFrogDamage =
	{
		Hidden = true,
		FamiliarDataModifiers =
		{
			AddOutgoingDamageModifiers =
			{
				{
					ValidBaseDamageAddition =
					{
						BaseValue = 0,
						AbsoluteStackValues =
						{
							[1] = 10,
						},
					},
					ReportValues = { ReportedDamage = "ValidBaseDamageAddition" },
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "DamageAmount",
			},
		},
	},

	-- Cat / Toula
	
	LastStandFamiliar = 
	{
		InheritFrom = { "FamiliarTrait" },
		EquipSound = "/SFX/Menu Sounds/KeepsakeSkellyTooth",
		Icon = "FamiliarIcon_Cat",
		FamiliarLastStandHealAmount = { BaseValue = 20, AsInt = true },
		CirceStatLine = "LastStandStatDisplay1_Circe",
		StatLines =
		{
			"LastStandStatDisplay1",
			"LinkedFishingRodUsesStatDisplay1",
		},
		ExtractValues =
		{
			{
				ExtractAs = "FamiliarDamage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "CatFamiliarPounce",
				BaseProperty = "Damage",
			},
			{
				Key = "FamiliarLastStandHealAmount",
				ExtractAs = "TooltipLastStandHealth",
			},
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "BonusChance",
				Format = "TotalHeroTraitValuePercent",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "CatFamiliar_FlavorText",
	},

	FamiliarCatResourceBonus =
	{
		Hidden = true,
		FamiliarResourceBonusChance =
		{
			BaseValue = 0.20,
			AbsoluteStackValues =
			{
				[1] = 0.10,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "ChanceBonus",
				Format = "Percent",
			},
		},
	},

	FamiliarCatAttacks =
	{
		Hidden = true,
		FamiliarCatAttackCount =
		{
			BaseValue = 4,
			AsInt = true,
			AbsoluteStackValues =
			{
				[1] = 2,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarCatAttackCount",
				ExtractAs = "AttackCount",
			},
		},
	},

	-- Raven / Raki

	CritFamiliar = 
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Raven",
		OutgoingUnmodifiedCritBonus = { BaseValue = 0.01 },
		OnEnemyCrittedFunction =
		{
			Name = "ClearRavenMark",
		},
		CirceStatLine = "BonusCritStatDisplay1_Circe",
		StatLines =
		{
			"BonusCritStatDisplay1",
			"LinkedPickaxeUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "FamiliarDamage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "RavenFamiliarMelee",
				BaseProperty = "Damage",
			},
			{
				Key = "OutgoingUnmodifiedCritBonus",
				ExtractAs = "CritBonus",
				Format = "Percent",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "RavenFamiliarMark",
				BaseProperty = "Duration",
				ExtractAs = "TooltipMarkDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "RavenFamiliarMark",
				BaseProperty = "CritVulnerability",
				ExtractAs = "CritRate",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "BonusChance",
				Format = "TotalHeroTraitValuePercent",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "RavenFamiliar_FlavorText",
	},

	FamiliarRavenResourceBonus =
	{
		Hidden = true,
		FamiliarResourceBonusChance =
		{
			BaseValue = 0.20,
			AbsoluteStackValues =
			{
				[1] = 0.10,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "ChanceBonus",
				Format = "Percent",
			},
		},
	},

	FamiliarRavenAttackDuration =
	{
		Hidden = true,
		FamiliarRavenAttackMinDuration =
		{
			BaseValue = 9.0,
			AbsoluteStackValues =
			{
				[1] = -2.0,
			},
		},
		FamiliarRavenAttackMaxDuration =
		{
			BaseValue = 10.0,
			AbsoluteStackValues =
			{
				[1] = -2.0,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarRavenAttackMinDuration",
				ExtractAs = "MinDuration",
			},
			{
				Key = "FamiliarRavenAttackMaxDuration",
				ExtractAs = "MaxDuration",
			},
		},
	},

	-- Hound / Hecuba

	DigFamiliar =
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Hound",
		StacksAddBeforeRemove = true,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 15,
				ChangeType = "Add",
				MaintainDelta = true,
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
		CirceStatLine = "BonusMaxManaStatDisplay1_Circe",
		StatLines =
		{
			"BonusMaxManaStatDisplay1",
			"LinkedShovelUsesStatDisplay1",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "HoundStun",
				BaseProperty = "Duration",
				DecimalPlaces = 3,
			},
			{
				Key = "ReportedManaBonus",
				ExtractAs = "ManaBonus"
			},
			{
				ExtractAs = "FamiliarDamage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "HoundFamiliarBark",
				BaseProperty = "Damage",
			},
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "BonusChance",
				Format = "TotalHeroTraitValuePercent",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "HoundFamiliar_FlavorText",
	},

	FamiliarHoundResourceBonus =
	{
		Hidden = true,
		FamiliarResourceBonusChance =
		{
			BaseValue = 0.20,
			AbsoluteStackValues =
			{
				[1] = 0.10,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "ChanceBonus",
				Format = "Percent",
			},
		},
	},

	FamiliarHoundBarkDuration =
	{
		Hidden = true,
		FamiliarHoundBarkMinDuration =
		{
			BaseValue = 8.0,
			AbsoluteStackValues =
			{
				[1] = -1.0,
			},
		},
		FamiliarHoundBarkMaxDuration =
		{
			BaseValue = 9.0,
			AbsoluteStackValues =
			{
				[1] = -1.0,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarHoundBarkMinDuration",
				ExtractAs = "MinDuration",
			},
			{
				Key = "FamiliarHoundBarkMaxDuration",
				ExtractAs = "MaxDuration",
			},
		},
	},

	-- Polecat / Gale

	DodgeFamiliar =
	{
		InheritFrom = { "FamiliarTrait" },
		Icon = "FamiliarIcon_Polecat",
		RemainingBlocks = 3,
		CirceBonusStacks = 2,
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.03,
				AbsoluteStackValues =
				{
					[1] = 0.01,
				},
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue" },
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				BaseValue = 1.03,
				AbsoluteStackValues =
				{
					[1] = 0.01,
				},
			},
		},
		CirceStatLine = "BonusDodgeStatDisplay1_Circe",
		StatLines =
		{
			"BonusDodgeStatDisplay1",
			"LinkedFlowerHarvestUsesStatDisplay1",
		},
		MergeTooltipExtractDataWithTrait = "FamiliarPolecatDamage",
		ExtractValues =
		{
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "DodgeChance",
				Format = "Percent",
			},
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "BonusChance",
				Format = "TotalHeroTraitValuePercent",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "PolecatFamiliar_FlavorText",
	},

	FamiliarPolecatResourceBonus =
	{
		Hidden = true,
		FamiliarResourceBonusChance =
		{
			BaseValue = 0.20,
			AbsoluteStackValues =
			{
				[1] = 0.10,
			},
		},
		ExtractValues =
		{
			{
				Key = "FamiliarResourceBonusChance",
				ExtractAs = "ChanceBonus",
				Format = "Percent",
			},
		},
	},

	FamiliarPolecatDamage =
	{
		Hidden = true,
		Icon = "FamiliarIcon_Polecat",
		FamiliarDataModifiers =
		{
			AddOutgoingDamageModifiers =
			{
				{
					ValidBaseDamageAddition =
					{
						BaseValue = 0,
						AbsoluteStackValues =
						{
							[1] = 50,
						},
					},
					ReportValues = { ReportedDamage = "ValidBaseDamageAddition" },
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "DamageAmount",
				Format = "AddToBase",
				BaseType = "Projectile",
				BaseName = "PolecatFamiliarMelee",
				BaseProperty = "Damage",
			},
		},
	},

}

OverwriteTableKeys( EnemyData, FamiliarData )
OverwriteTableKeys( TraitData, TraitSetData.Familiar )
