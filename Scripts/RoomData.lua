RoomEventData =
{
	BountyInfoBannerArgs =
	{
		ActiveBountyOverrides =
		{
			Delay = 0.45,
			Duration = 1.85,
			AnimationName = "LocationBackingIrisChaosIn",
			AnimationOutName = "LocationBackingIrisChaosOut",
		},
	},

	EntranceFunctionNamePriorities =
	{
		"RoomEntranceCrawlerMiniBoss",
		"RoomEntranceCharybdis",
		"EntranceFromAnomalyPresentation",
		"RoomEntrancePortal",
		"ShipsRoomEntrancePresentation",
	},

	ExitFunctionNamePriorities =
	{
		"LeaveRoomSecretDoorPresentation",
		"LeaveRoomHPostBossPresentation",
	},

	GlobalRoomStartEvents =
	{
		{
			FunctionName = "HandleBreakableSwap",
			Args = {},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBreakableValue1" },
				},
			},
		},
	},

	GlobalRoomInputUnblockedEvents =
	{
		{
			Threaded = true,
			FunctionName = "FamiliarSetup",
			Args =
			{
				WaitForInput = true,
				Wait = 0.5,
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EquippedFamiliar", },
				},
			},
		},
	},

	GlobalRoomPostCombatReloadInputUnblockedEvents =
	{
		{
			FunctionName = "FamiliarSetup",
			Args =
			{
				PostCombat = true,
			},
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EquippedFamiliar", },
				},
			},
		},
	},

	PauseMenuTakeOverAutoUnpause =
	{
		AutoUnpause = true,
		VoiceLines =
		{
			-- Time Cannot Be Stopped
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				SuccessiveChanceToPlayAll = 0.33,

				{ Cue = "/VO/Chronos_0563_B", Text = "{#Emph}Hahaha! {#Prev}No. {#Emph}You {#Prev}do not control the flow of Time. Not {#Emph}here.", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Chronos_0564", Text = "{#Emph}Uh-uh-uhh!" },
				{ Cue = "/VO/Chronos_0565", Text = "Time cannot be stopped." },
				{ Cue = "/VO/Chronos_0566", Text = "We have a score to settle, do we not?" },
				{ Cue = "/VO/Chronos_0567", Text = "How very rude of you to even {#Emph}try!" },
				{ Cue = "/VO/Chronos_0568", Text = "Who, exactly, do you think you {#Emph}are?" },
				{ Cue = "/VO/Chronos_0569", Text = "Time does not stop for {#Emph}you." },
				{ Cue = "/VO/Chronos_0570", Text = "Such antics you attempt with me!" },
				{ Cue = "/VO/Chronos_0571", Text = "I said {#Emph}no. {#Prev}We {#Emph}fight!" },
				{ Cue = "/VO/Chronos_0572", Text = "Cease this and {#Emph}fight!" },
				{ Cue = "/VO/Chronos_0573", Text = "Your power is formidable, but no." },
				{ Cue = "/VO/Chronos_0574", Text = "We now resume the battle already in progress." },
				{ Cue = "/VO/Chronos_0575", Text = "You only prolong your demise." },
				{ Cue = "/VO/Chronos_0576", Text = "Are you {#Emph}enjoying {#Prev}this?" },
				{ Cue = "/VO/Chronos_0577",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Chronos_0576" },
						},
					},
					Text = "{#Emph}I {#Prev}am enjoying this." },
				{ Cue = "/VO/Chronos_0562", Text = "{#Emph}Hahaha! {#Prev}No.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Chronos_0562_B" },
						},
						{
							PathFalse = { "PrevRun", "SpeechRecord", "/VO/Chronos_0562_B" },
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = {
								"/VO/Chronos_0572",
								"/VO/Chronos_0573",
								"/VO/Chronos_0573",
								"/VO/Chronos_0574",
								"/VO/Chronos_0575",
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0563", Text = "{#Emph}You {#Prev}do not control the flow of Time. Not {#Emph}here.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Chronos_0562_B" },
						},
						{
							PathFalse = { "PrevRun", "SpeechRecord", "/VO/Chronos_0562_B" },
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = {
								"/VO/Chronos_0572",
								"/VO/Chronos_0573",
								"/VO/Chronos_0573",
								"/VO/Chronos_0574",
								"/VO/Chronos_0575",
							},
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,

				{ Cue = "/VO/Chronos_0578", Text = "No.", PlayFirst = true },
				{ Cue = "/VO/Chronos_0579", Text = "{#Emph}No!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0580", Text = "No...", PlayFirst = true },
				{ Cue = "/VO/Chronos_0581", Text = "{#Emph}No...!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0582", Text = "{#Emph}Mm... {#Prev}no.", PlayFirst = true },
				{ Cue = "/VO/Chronos_0583", Text = "How about {#Emph}no." },
				{ Cue = "/VO/Chronos_0584", Text = "Absolutely not." },
				{ Cue = "/VO/Chronos_0585", Text = "{#Emph}Hellooo?" },
			},
		},
	},

	PauseMenuTakeOverAllowPause =
	{
		AutoUnpause = false,
		Cooldown = 3.0,
		VoiceLines =
		{
			Queue = "Interrupt",
			{
				-- these lines first require longer lines below to play
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.66,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll =
							{
								"/VO/Chronos_0744",
							},
						}
					},

					{ Cue = "/VO/Chronos_0746", Text = "Time Out..." },
					{ Cue = "/VO/Chronos_0747", Text = "Time Out!" },
					{ Cue = "/VO/Chronos_0748", Text = "Certainly, Time Out!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0746",
									"/VO/Chronos_0747",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0749", Text = "A Time-Out? Why not?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0746",
									"/VO/Chronos_0747",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0750", Text = "Another Time-Out?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0746",
									"/VO/Chronos_0747",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0751", Text = "{#Emph}Ah yes! {#Prev}Another Time-Out!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0746",
									"/VO/Chronos_0747",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0752", Text = "{#Emph}Another {#Prev}Time-Out?!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0751",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0753", Text = "If you so insist." },
					{ Cue = "/VO/Chronos_0754", Text = "I shall allow it once again." },
					{ Cue = "/VO/Chronos_0755", Text = "What a surprise." },
					{ Cue = "/VO/Chronos_0756", Text = "Stall all you like." },
					{ Cue = "/VO/Chronos_0757", Text = "Oh by all means!" },
					{ Cue = "/VO/Chronos_0758", Text = "{#Emph}Another {#Prev}break, {#Emph}of course!" },
					{ Cue = "/VO/Chronos_0759", Text = "Another interruption?" },
					{ Cue = "/VO/Chronos_0760", Text = "Again?" },
					{ Cue = "/VO/Chronos_0761", Text = "Again, truly?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0760",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0762", Text = "What, again?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0760",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0763", Text = "{#Emph}Eugh...",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0762",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0764", Text = "{#Emph}Urrghh...",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0762",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0765", Text = "{#Emph}Eugh{#Prev}, go on.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0762",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0766", Text = "Take your moment, then.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0765",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0767", Text = "Just let me know!" },
					{ Cue = "/VO/Chronos_0768", Text = "Go do your business." },
					{ Cue = "/VO/Chronos_0769", Text = "Then we wait." },
					{ Cue = "/VO/Chronos_0593", Text = "Fine..." },
					{ Cue = "/VO/Chronos_0770", Text = "Fine." },
					{ Cue = "/VO/Chronos_0771", Text = "{#Emph}Fine!" },
					{ Cue = "/VO/Chronos_0772", Text = "See if I care.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0771",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0773", Text = "{#Emph}Now? {#Prev}Fine.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0771",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0774", Text = "Yes, yes..." },
					{ Cue = "/VO/Chronos_0775", Text = "Appalling, really.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0771",
								},
							}
						}
					},
					{ Cue = "/VO/Chronos_0600", Text = "If it must be..." },
					{ Cue = "/VO/Chronos_0587", Text = "{#Emph}Rngh{#Prev}, oh very well." },
					{ Cue = "/VO/Chronos_0590", Text = "{#Emph}Eugh...!" },
					{ Cue = "/VO/Chronos_0591", Text = "Then let us wait..." },
					{ Cue = "/VO/Chronos_0592", Text = "{#Emph}Again...?",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0771",
								},
							}
						}
					},
				},
				{
					-- this should play first for most
					PlayOnce = true,
					BreakIfPlayed = true,
					GameStateRequirements =
					{
						-- None
					},

					{ Cue = "/VO/Chronos_0731", Text = "{#Emph}Excuse me? {#Prev}Time does not stop at your behest, it only stops at mine! {#Emph}Oh {#Prev}but by all means, go attend whatever urgent matter requires you to put our clash on hold, you {#Emph}laggard.", TextLimit = 300,
						GameStateRequirements =
						{
							-- back compat
							{
								PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
							},
						},
					},
				},
				-- these longer lines should start to repeat once the shorter ones have played
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					GameStateRequirements =
					{
						-- None
					},

					{ Cue = "/VO/Chronos_0732", Text = "{#Emph}Time {#Prev}can be put on hold by {#Emph}me{#Prev}, not {#Emph}you." },
					{ Cue = "/VO/Chronos_0733", Text = "{#Emph}I {#Prev}am in control, not {#Emph}you. {#Prev}But {#Emph}fine." },
					{ Cue = "/VO/Chronos_0734", Text = "I feel oddly obligated to comply..." },
					{ Cue = "/VO/Chronos_0735", Text = "I shall be charitable in this one regard." },
					{ Cue = "/VO/Chronos_0736", Text = "By all means, take all the {#Emph}Time {#Prev}that you require!" },
					{ Cue = "/VO/Chronos_0737", Text = "Remember that {#Emph}Time {#Prev}does not stop merely for you." },
					{ Cue = "/VO/Chronos_0738", Text = "I shall allow this, but some evening, I may not...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0734" }
							},
							{
								PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" }
							},
						},
					},
					{ Cue = "/VO/Chronos_0739", Text = "Do you require a little breathing room, perhaps?" },
					{ Cue = "/VO/Chronos_0740", Text = "Is our confrontation not sufficiently urgent for you?" },
					{ Cue = "/VO/Chronos_0741", Text = "I shall be waiting for your {#Emph}safe return." },
					{ Cue = "/VO/Chronos_0742", Text = "You need a bit of {#Emph}Time? {#Prev}Of course." },
					{ Cue = "/VO/Chronos_0743", Text = "You prolong the inevitable." },
					{ Cue = "/VO/Chronos_0745", Text = "Would you like a Time-Out?" },
					{ Cue = "/VO/Chronos_0586", Text = "Oh, {#Emph}fine. {#Prev}I shall allow it, I suppose..." },
					{ Cue = "/VO/Chronos_0589", Text = "You know what? Have it your way! {#Emph}Fine." },
					{ Cue = "/VO/Chronos_0588", Text = "I shall abide what doubtless is a necessary bathroom break.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								CountOf =
								{
									"/VO/Chronos_0732",
									"/VO/Chronos_0733",
									"/VO/Chronos_0734",
									"/VO/Chronos_0735",
									"/VO/Chronos_0736",
									"/VO/Chronos_0737",
									-- "/VO/Chronos_0738",
									"/VO/Chronos_0739",
									"/VO/Chronos_0740",
									"/VO/Chronos_0741",
									"/VO/Chronos_0742",
								},
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					{ Cue = "/VO/Chronos_0744", Text = "{#Emph}Please, Chronos, I need but a moment!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "SpeechRecord" },
								HasAll =
								{
									"/VO/Chronos_0588",
								},
							}
						}
					},
				},

				--[[

				{ Cue = "/VO/Chronos_0594_B", Text = "Again, with this foolishness...? Wait, what? Stuck! {#Emph}How?! {#Prev}Impossible...", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/Chronos_0597", Text = "{#Emph}Rnngghh..." },
				{ Cue = "/VO/Chronos_0598", Text = "{#Emph}How...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
						},
					}
				},
				{ Cue = "/VO/Chronos_0599", Text = "Such power...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
						},
					}
				},
				{ Cue = "/VO/Chronos_0600", Text = "If it must be...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
						},
					}
				},
				{ Cue = "/VO/Chronos_0586", Text = "Oh, {#Emph}fine. {#Prev}I shall allow it, I suppose..." },
				{ Cue = "/VO/Chronos_0587", Text = "{#Emph}Rngh{#Prev}, oh very well." },
				{ Cue = "/VO/Chronos_0588", Text = "I shall abide what doubtless is a necessary bathroom break." },
				{ Cue = "/VO/Chronos_0589", Text = "You know what? Have it your way! {#Emph}Fine." },
				{ Cue = "/VO/Chronos_0590", Text = "{#Emph}Eugh..." },
				{ Cue = "/VO/Chronos_0591", Text = "Then let us wait..." },
				{ Cue = "/VO/Chronos_0592", Text = "{#Emph}Again...?" },
				{ Cue = "/VO/Chronos_0593", Text = "Fine..." },
				]]--
			},
		},
	},
}

RoomSetData.Base =
{
	BaseRoom =
	{
		DebugOnly = true,
		SecretSpawnChance = 0.2,
		SecretDoorRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone =
				{
					"F_PreBoss01", "F_Boss01", "F_Boss02",
					"G_PreBoss01", "G_Boss01", "G_Boss02",
					"H_PreBoss01", "H_Boss01", "H_Boss02",
					"I_PreBoss01", "I_PreBoss02", "I_Boss01",
					"N_PreBoss01", "N_Boss01", "N_Boss02",
					"P_PreBoss01", "P_Boss01"
				},
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "I", "O", "Q" },
			},
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},

		ChallengeSpawnChance = 0.15,
		ChallengeSpawnRequirements =
		{
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 5,
			},
			{
				FunctionName = "RequiredMinRoomsSinceEvent",
				FunctionArgs = { Event = "ChallengeSwitch", Count = 3 },
			},
		},
		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitches1" },
			},
		},
		PerfectClearSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitchesExtra1" },
			},
		},
		EliteSwitchRequirements =
		{
			NamedRequirements = { "TalentLegal", },
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitchesExtra1" },
			},
		},

		MetaRewardStandSpawnChance = 0.1,
		MetaRewardStandSpawnChanceIncreasePerChamber = 0.1,
		MetaRewardStandRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeMetaRewardStands" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "I", "Q" },
			},
			{
				PathFalse = { "CurrentRun", "LastMetaRewardStandDepth" },
			},
		},

		WellShopSpawnChance = 0.15,
		WellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWellShops" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
 				Path = { "CurrentRun", "BiomesReached" },
				HasNone = { "N" },
			},
			{
				FunctionName = "RequiredMinRoomsSinceEvent",
				FunctionArgs = { Event = "WellShop", Count = 4 },
			},
		},
		SurfaceShopSpawnChance = 0.0,
		SurfaceShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSurfaceShops" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				SumPrevRooms = 3,
				Path = { "SurfaceShop" },
				CountPathTrue = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		AnomalyDoorChance = 0.06, -- Set in each biomes XBase_Combat room data
		AnomalyDoorChanceFirstInstance = 0.33,
		AnomalyDoorRequirements =
		{
			{
				PathFalse = { "CurrentRun", "BiomesReached", "Anomaly" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "G_Shop01", "G_Story01", "G_PreBoss01", "C_Boss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsNone = { "ArtemisCombatG", "NemesisRandomEvent" },
			},
			{
				PathTrue = { "GameState", "BiomeVisits", "G" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "G" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ChronosFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" }
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosFirstMeeting" },
			},
		},

		MinDepthBeforeIntros = 3,
		LockedUseSound = "/Leftovers/World Sounds/Caravan Interior/ChestClose",
		UnlockedUseSound = "/EmptyCue",
		UsePromptOffsetX = 10,
		UsePromptOffsetY = -50,
		StopSecretMusic = true,
		IntroSequenceDuration = 0.1,

		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
	},

	BiomeStartRoom = 
	{
		DebugOnly = true,
		BiomeStartRoom = true,
	},

	------------- IRIS ----------------
	_FTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_GTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_HTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
		SoftClamp = 0.75,
	},
	_ITemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_NTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_OTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_OTemplateRoomSmall =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_OTemplateRoomMedium =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_OTemplateRoomLarge =
	{
		InheritFrom = { "_OTemplateRoom" },
		DebugOnly = true,
	},
	_PTemplateRoomExterior =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_PTemplateRoomInterior =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},
	_QTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,
		LegalEncounters = { "Empty" },
		NoReward = true,
	},

}

AddTableKeysCheckDupes( RoomData, RoomSetData.Base )
