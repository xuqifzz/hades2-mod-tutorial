OverwriteTableKeys( NarrativeData, {
	-- Chronos
	NPC_Chronos_01 =
	{
		InteractTextLinePriorities =
		{
			"ChronosFirstMeeting",
			"ChronosMeeting02",
			"ChronosReveal01",
			"ChronosPostBattleMeeting01",
			"ChronosPostWinStreakMeeting01",
			"ChronosMeeting03",
			"ChronosMeeting04",
			"ChronosMeeting05",
			"ChronosPostSurfaceMeeting01",
			"ChronosPostSurfaceMeeting02",
			"ChronosPostSurfaceMeeting03",
			"ChronosPostSurfaceMeeting04",
			"ChronosMeetingAboutZeus01",
			"ChronosMeetingAboutPoseidon01",
			"ChronosMeetingAboutHestia01",
			"ChronosMeetingAboutDemeter01",
			"ChronosMeetingAboutHera01",
			"ChronosPostBattleMeeting02",
			"ChronosPostBattleMeeting03",
			"ChronosPostBattleMeeting04",
			"ChronosMeetingAboutOlympians01",
		},
	},
	NPC_Chronos_Story_01 =
	{
		InteractTextLinePriorities =
		{
			"ChronosNightmare01",
		},
	},

	-- Chronos Boss
	Chronos =
	{
		BossIntroTextLinePriorities =
		{
			"ChronosBossFirstMeeting_C",
			"ChronosBossFirstMeeting_B",
			"ChronosBossFirstMeeting",
			"ChronosBossLostAgainstHim01",
			"ChronosBossWonAgainstHim01",

			-- immediate-contextual
			{
				"ChronosBossAboutHades02",
				"ChronosBossAboutGameplayTimer02",
				"ChronosBossAboutPausing01",
			},
			-- priority story
			{
				"ChronosBossAboutHades01",
			},
			-- health
			{
			},
			-- priority contextual
			{
				"ChronosBossAboutThanatosAspect01",
			},
			-- about other gods
			{
			},
			-- lower-priority contextual
			{
				"ChronosBossAboutChaos01",
				"ChronosBossAboutHistory01",
				"ChronosBossAboutGoldenAge02",
				"ChronosBossAboutEris01",
				"ChronosBossAboutGameplayTimer01",
				"ChronosBossAboutThessaly01",
			},
			-- lower-priority story
			{
				"ChronosBossAboutCerberus01",
				"ChronosBossAboutGoldenAge01",
				"ChronosBossAboutMelinoe01",
			},
			{
				"ChronosBossAboutPolyphemus01",
				"ChronosBossAboutTime01",
				"ChronosBossAboutFates01",
				"ChronosBossAboutCharon01",
				"ChronosBossAboutClockwork01",
				"ChronosBossAboutStyx01",
			},

			-- evergreen
			{
				"ChronosBossAboutWeapons01",
				"ChronosBossAboutHouse01",
				"ChronosBossAboutSatyrs01",
				"ChronosBossAboutFuture01",
				"ChronosBossAboutWretches01",
				"ChronosBossAboutTitans01",
				"ChronosBossAboutOrigin01",
			},
		},

		BossPhaseChangeTextLinePriorities =
		{
			"ChronosR1FirstWin",
			{
				"ChronosR1Win01",
				"ChronosR1Win02",
				"ChronosR1Win03",
				"ChronosR1Win04",
			},
			{
				"ChronosR1Win05",
				"ChronosR1Win06",
			},
		},

		BossOutroTextLinePriorities =
		{
			"ChronosBossOutro01",
		},
	},
})