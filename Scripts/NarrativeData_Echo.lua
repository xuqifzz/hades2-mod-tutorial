OverwriteTableKeys( NarrativeData, {
	-- Echo
	NPC_Echo_01 =
	{
		InteractTextLinePriorities =
		{
			"NarcissusWithEcho01",

			"EchoFirstMeeting",
			"EchoAboutEcho01",
			"EchoAboutHelp01",

			-- immediate contextual
			{
				"EchoAboutNarcissus02",
				"EchoAboutNarcissus03",
				"EchoAboutNarcissus04",
				"EchoAboutNarcissus07",
			},
			-- priority story
			{
				"EchoAboutChronos01",
				"EchoAboutNymphs01",
			},
			"EchoAboutNarcissus01",
			"EchoAboutNarcissus05",
			"EchoAboutNarcissus06",
			-- lower-priority contextual
			{
				"EchoAboutKeepsake01",
			},
			{
				"EchoLowHealth01",
				"EchoLowHealth02",
				"EchoAboutNemesis01",
			},
			-- lower priority story
			"EchoAboutHeart01",
			"EchoAboutCerberus01",

			-- evergreen
			{
				"EchoAboutBridge01",
				"EchoAboutCurse01",
				"EchoAboutCharon01",
			},
		},

		GiftTextLinePriorities =
		{
			"EchoGift01",
			"EchoGift02",
			"EchoGift03",
			"EchoGiftTemp",
		},		
	},
})