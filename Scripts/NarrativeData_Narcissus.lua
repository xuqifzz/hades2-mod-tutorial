OverwriteTableKeys( NarrativeData, {

	-- Narcissus
	NPC_Narcissus_01 =
	{
		InteractTextLinePriorities =
		{
			"NemesisWithNarcissus02_FollowUp",
			"NarcissusFirstMeeting",
			"NarcissusAboutLooks01",
			"NemesisWithNarcissus01_FollowUp",
			-- immediate-contextual
			{
				"NarcissusAboutWaters01",
				"NarcissusAboutWaters02",
				"NarcissusAboutWaters03",
				"NarcissusAboutWaters04",
				"NarcissusAboutWaters05",
				"NarcissusGrantsReward01",
			},
			{
				"NarcissusAboutStillDirtyWaters01",
				"NarcissusAboutEcho02",
				"NarcissusAboutEcho03",
				"NarcissusAboutEcho04",
			},
			-- priority story
			{
				"NarcissusAboutLooks02",
			},
			{
				"NarcissusAboutDanger01",
				"NarcissusAboutSolitude01",
				"NarcissusAboutOceanus01",
				"NarcissusAboutOceanus02",
				"NarcissusAboutReflection01",
			},
			-- priority contextual
			{
				"NarcissusAboutEcho01",
				"NarcissusAboutEcho01B",
			},
			"NarcissusAboutNemesis01",
			{
				"NarcissusAboutKeepsake01",
			},
			{
				"NarcissusAboutEcho05",
			},
			-- lower-priority contextual
			{
				"NarcissusLowHealth01",
			},
			{
				"NarcissusLowHealth02",
			},
			-- lower priority story
			{
				"NarcissusAboutBeauty01",
				"NarcissusAboutChronos01",
				"NarcissusAboutSirens01",
				"NarcissusAboutLove01",
			},
			{
				"NarcissusAboutReflection02",
				"NarcissusAboutReflection03",
			},
			-- evergreen
			{
				"NarcissusAboutReflection04",
			}
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGiftTemp",
		},
	},

	NPC_Narcissus_Field_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",
		},

		GiftTextLinePriorities =
		{
			"NarcissusGift01",
			"NarcissusGift02",
			"NarcissusGift03",
			"NarcissusGift04",
			"NarcissusGiftTemp",
		},
	},
})