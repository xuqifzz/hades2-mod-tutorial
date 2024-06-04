OverwriteTableKeys( EncounterData,
{
	-- Unique Encounters
	HealthRestore =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivateObjects", Args = { ObjectTypes = { "HealthFountain", "HealthFountainF", "HealthFountainG", "HealthFountainH", "HealthFountainI", "HealthFountainN", "HealthFountainO" } } },
			{ FunctionName = "SpawnRoomReward" },
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ToulaGift01", },
					},
				},
				Args =
				{
					{ FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Familiar_Cat_01" }, }
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "Familiar_Cat_01", WithinDistance = 400,
				FunctionName = "PlayEmoteSimple",
				Args =
				{
					AnimationName = "StatusIconDisgruntled",
				},
			},
			{
				TriggerObjectType = "Familiar_Cat_01", WithinDistance = 500,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "Resources", "FamiliarPoints" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "GameState", "UseRecord", "Familiar_Cat_01", },
								Comparison = ">=",
								Value = 1,
							},
							-- @ temporary so Frinos is always first
							{
								PathTrue = { "GameState", "FamiliarStatus", "FrogFamiliar", "Unlocked", },
							},
						},

						{ Cue = "/VO/Melinoe_0991", Text = "Little one, I have something for you." },
					},
					{
						BreakIfPlayed = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							--
						},
						-- { Cue = "/VO/Melinoe_0827", Text = "Something there." },
						{ Cue = "/VO/Melinoe_0825", Text = "Over there.",
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Melinoe_0825", },
								}
							},
						},
						-- { Cue = "/VO/Melinoe_0577", Text = "Mm!" },
					},					
				}
			}
		},
	},

	Shop =
	{
		InheritFrom = { "NonCombat" },
		TimerBlock = "ShopEncounter",
		TimerBlockRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "StoreDataName" },
			}
		},
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SpawnRoomReward" },
			{
				FunctionName = "CheckHeraclesShoppingEvent",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N", "O", "P" },
					},
					{
						PathFalse = { "CurrentRun", "ShoppingEvent" },
					},
					{
						PathFalse = { "PrevRun", "HeraclesShopped" },
					},
					NamedRequirements = { "NoRecentFieldNPCEncounter", },
					ChanceToPlay = 0.25, 
				},
			},
			{
				FunctionName = "CheckNemesisShoppingEvent",
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", "G", "H", "I" },
					},
					{
						PathFalse = { "CurrentRun", "ShoppingEvent" },
					},
					{
						PathFalse = { "PrevRun", "NemesisShopped" },
					},
					NamedRequirements = { "NoRecentNemesisEncounter", },
					ChanceToPlay = 0.25, 
				},
				Args =
				{
					NPCVariantData = "NemesisShopping",
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 1600,
				FunctionName = "FieldsBridgeCharonMusic",
				GameStateRequirements = 
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "H_Bridge01", "H_PreBoss01" },
					},
				},
			},
		},

		ExitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeRoomExitVoiceLines", Time = 25 },
			},
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.4,
				SuccessiveChanceToPlayAll = 0.2,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_PreBoss01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_2356", Text = "{#Emph}<Sigh> {#Prev}Here goes...", PlayFirst = true,
					GameStateRequirements =
					{
						RequiredMaxHealthFraction = 0.6,
					},
				},
				{ Cue = "/VO/MelinoeField_2357", Text = "Headmistress awaits..." },
				{ Cue = "/VO/MelinoeField_0103", Text = "Mustn't keep her waiting..." },
				{ Cue = "/VO/MelinoeField_0104", Text = "Now for the test..." },
				{ Cue = "/VO/MelinoeField_0105", Text = "She awaits..." },
				{ Cue = "/VO/MelinoeField_0106", Text = "Here goes..." },
				{ Cue = "/VO/MelinoeField_0107", Text = "The clearing isn't far..." },
				{ Cue = "/VO/MelinoeField_0108", Text = "I can do this...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2358", Text = "I can beat her.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2359", Text = "I can take her.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.5,
						},
						{
							Path = { "GameState", "EnemyKills", "Hecate" },
							Comparison = "<=",
							Value = 9,
						},
					},
				},
			},
			{
				PreLineWait = 0.25,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "DoAnomalies" },
					},
					RequiredUnitAlive = "NPC_Charon_01",
				},

				{ Cue = "/VO/Melinoe_1234", Text = "Farewell, Lord Charon." },
				{ Cue = "/VO/Melinoe_1236", Text = "Thank you for your service." },
				{ Cue = "/VO/Melinoe_1237", Text = "Until we meet again." },
				{ Cue = "/VO/Melinoe_1235", Text = "Be safe, Lord Charon.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1235", },
						},
					},
				},
			},
		},
	},

	BridgeShop =
	{
		InheritFrom = { "Shop" },

		RequireRoomReward = "Shop",
	},
})