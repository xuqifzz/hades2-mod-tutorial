OverwriteTableKeys( NarrativeData, {
	-- Medea
	NPC_Medea_01 =
	{
		InteractTextLinePriorities =
		{
			"MedeaFirstMeeting",
			"MedeaHubFirstMeeting01",

			-- immediate-contextual
			-- priority story
			{
				"MedeaAboutFoes01",
				"MedeaAboutVengeance01",
			},
			{
				"MedeaAboutEphyra01"
			},
			-- lower-priority contextual
			{
				"MedeaAboutApollo01",
				"MedeaAboutHera01",
			},
			{
				"MedeaAboutHeracles01",
				"MedeaAboutWitchcraft01",
				"MedeaAboutHecate01",
			},
			{
				"MedeaAboutKeepsake01",
			},
			-- lower priority story
			{
				"MedeaAboutCirce01",
				"MedeaAboutCurses01",
				"MedeaAboutBlood01",
				"MedeaAboutUndead01",
				"MedeaAboutReputation01",
				"MedeaAboutSuffering01",
			},
			-- evergreen
			{
				"MedeaAboutOptimism01",
				"MedeaAboutPoisons01",
				"MedeaAboutSolitude01",
			},
		},

		GiftTextLinePriorities =
		{
			"MedeaGift01",
			"MedeaGift02",
			"MedeaGift03",
			"MedeaGift04",
			"MedeaGiftTemp",
		},
	},
})