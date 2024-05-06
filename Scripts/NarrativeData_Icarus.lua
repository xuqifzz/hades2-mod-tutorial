OverwriteTableKeys( NarrativeData, {
	-- Icarus
	NPC_Icarus_01 =
	{
		InteractTextLinePriorities =
		{
			"IcarusFirstMeeting",
			-- immediate-contextual
			"IcarusAboutChronosBossW01",
			"IcarusAboutDaedalus02",
			"IcarusAboutEris01",
			{
				"IcarusAboutKeepsake01",
			},
			-- priority story
			{
				"IcarusAboutMelinoe01",
				"IcarusAboutFlying01",
				"IcarusAboutFlying02",
				"IcarusAboutReturning02",
				"IcarusAboutSurfaceCurse01",
			},
			{
				"IcarusAboutDaedalus01",
				"IcarusAboutReturning01",
				"IcarusAboutFlying03",
				"IcarusAboutOdysseus01",
			},
			-- lower-priority contextual
			{
			},
			-- lower priority story
			{
				"IcarusAboutDaedalus03",
			},
			-- evergreen
			{
			},
		},

		GiftTextLinePriorities =
		{
			"IcarusGift01",
			"IcarusGift02",
			"IcarusGift03",
			"IcarusGiftTemp",
		},
	},
})