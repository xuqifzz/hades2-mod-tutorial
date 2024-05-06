OverwriteTableKeys( NarrativeData, {
	-- Circe
	NPC_Circe_01 =
	{
		InteractTextLinePriorities =
		{
			"CirceFirstMeeting",
			-- immediate-contextual
			-- priority story
			{
				"CirceAboutHut01",
			},
			-- priority contextual
			{
				"CirceAboutCirceAspect01",
			},
			-- lower-priority contextual
			{
				"CirceAboutMoly01",
				"CirceAboutArcana01",
				"CirceAboutSelene01",
			},
			{
				"CirceAboutMedea01",
			},
			{
				"CirceAboutScylla01",
			},
			-- lower priority story
			{
				"CirceAboutThessaly01",
				"CirceAboutCrystals01",
				"CirceAboutHecate01",
				"CirceAboutChronos01",
			},
			{
				"CirceAboutBackstory01",
				"CirceAboutOdysseus01",
			},
			-- evergreen
			{
				"CirceAboutFamily01",
				"CirceAboutMiracles01",
				"CirceAboutStudies01",
			},
		},

		GiftTextLinePriorities =
		{
			"CirceGift01",
			"CirceGift02",
			"CirceGiftTemp",
		},
	},
})