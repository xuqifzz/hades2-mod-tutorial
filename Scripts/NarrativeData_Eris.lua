OverwriteTableKeys( NarrativeData, {
	-- Eris
	NPC_Eris_01 =
	{
		InteractTextLinePriorities =
		{
			"ErisFoughtAgainstHer01",
			"ErisFirstMeeting_B",
			"ErisFirstMeeting",

			-- immediate-contextual
			{
				"ErisFoughtAgainstHer02",
				"ErisFoughtAgainstHer03",
			},

			"ErisAboutCloseMatch01",
			"ErisAboutHeart01",
			"ErisAboutPast01",
			"ErisAboutSurface01",
			"ErisAboutSurface02",
			"ErisAboutRematches01",

			-- priority story
			"ErisAboutTask01",
			"ErisAboutPurpose01",
			"ErisAboutPast02",
			"ErisAboutLoyalty01",
			{
				"ErisAboutNyx01",
				"ErisAboutDisorder01",
				"ErisAboutWar01",
			},

			-- lower-priority contextual
			{
				"ErisAboutMoros01",
				"ErisAboutNemesis01",
				"ErisAboutHeracles01",
				"ErisAboutStrife02",
			},
			{
				"ErisAboutHecate01",
				"ErisPostGift01",
			},
			-- lower priority story
			{
				"NemesisWithEris01",
				"NemesisWithEris02",
				"MorosWithEris01",
				"MorosWithEris02",
			},
			{
				"ErisAboutWar02",
			},
			{
				"ErisAboutRumors01",
				"ErisAboutWeaponGun01",
				"ErisAboutTrash01",
				"ErisAboutTrash02",
				"ErisAboutStrife01",
			},

			-- evergreen
			{
				"ErisAboutAlley01",
				"ErisAboutSolitude01",
				"ErisAboutTruth01",
			},
		},

		GiftTextLinePriorities =
		{
			"ErisGift01",
			"ErisGift01_B",
			"ErisGift02",
			"ErisGift03",
			"ErisBathHouse01",
			"ErisGift04",
			"ErisGiftTemp",
			"ErisGiftDecline01",
			"ErisFishingDecline01",
			"ErisBathHouseDecline01",
		},

		CurseGiverPriorities =
		{
			"ErisGrantsCurse01",
			"ErisGrantsCurse06",
			"ErisGrantsCurse03",
			"ErisGrantsCurse04",
			"ErisGrantsCurse02",
			"ErisGrantsCurse05",
		},
	},

	-- Eris Boss
	Eris =
	{
		BossIntroTextLinePriorities =
		{
			"ErisBossFirstMeeting",

			-- health & immediate contextual
			"ErisBossAboutGoldenApples01",
			"ErisBossAboutConsequences01",

			-- priority story
			"ErisBossAboutObstacles01",
			"ErisBossAboutMistakes01",
			"ErisBossAboutRelaxation01",

			-- priority contextual

			-- lower priority story

			-- lower priority contextual

			-- evergreen

		},

	},
})