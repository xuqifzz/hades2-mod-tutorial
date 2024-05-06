RewardSets =
{
	OpeningRoomBans =
	{
		"Devotion",
		"RoomMoneyDrop",
		"MaxHealthDrop",
		"MaxManaDrop"
	},

	HubCombatRoomEasyBans =
	{
		"Devotion",
		"WeaponUpgrade",
		"HermesUpgrade",
		"HephaestusUpgrade",
	},

	SubroomEasyBans =
	{
		"MaxHealthDrop",
		"MaxManaDrop",
		"StackUpgrade",
		"RoomMoneyDrop",
		"TalentDrop",
	},

	SubroomHardBans =
	{
		"MaxManaDropSmall",
		"MaxHealthDropSmall",
		"EmptyMaxHealthSmallDrop",
		"RoomMoneyTinyDrop",

		"GiftDrop",
		"MetaCurrencyDrop",
		"MetaCardPointsCommonDrop",
		"MemPointsCommonDrop",

		"AirBoost",
		"FireBoost",
		"WaterBoost",
		"EarthBoost",

	},
}

RewardData =
{
	Shop =
	{
		
	},
	
	ClockworkGoal =
	{
		SpawnFunctionName = "SpawnClockworkGoalReward",
		SetupFunctionName = "SetupClockworkGoalReward",
		SetupFunctionArgs =
		{
			DistanceTrigger =
			{
				WithinDistance = 700,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.35,
						PreLineWait = 0.5,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
								IsAny = { "I" },
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsNone = { "I_Intro" },
							},
							{
								Path = { "CurrentRun", "RemainingClockworkGoals", },
								Comparison = ">=",
								Value = 0,
							},
							RequiredMinHealthFraction = 0.2,
						},
						Cooldowns =
						{
							{ Name = "MelinoeAnyQuipSpeech" },
						},

						{ Cue = "/VO/MelinoeField_1549", Text = "Five chambers left...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = ">=",
									Value = 5,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1550", Text = "Five chambers to go...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = ">=",
									Value = 5,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1551", Text = "Four more chambers...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 4,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1552", Text = "Four chambers to go...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 4,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1553", Text = "Three chambers left...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 3,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1554", Text = "Three chambers still to go...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 3,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1555", Text = "Just two more chambers...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1556", Text = "Two more chambers...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1545", Text = "Just a few chambers left...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "<=",
									Value = 3,
								},
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = ">=",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1546", Text = "Few more chambers still...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "<=",
									Value = 3,
								},
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = ">=",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1547", Text = "So close now...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1548", Text = "A couple chambers more...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 2,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1557", Text = "One chamber left...!",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 1,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1558", Text = "One last chamber...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 1,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1559", Text = "The House is just ahead...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 0,
								},
							},
						},
						{ Cue = "/VO/MelinoeField_1560", Text = "...And now for the Titan...",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RemainingClockworkGoals", },
									Comparison = "==",
									Value = 0,
								},
							},
						},
					},
				}
			},
		},
	},
}