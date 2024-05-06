CostumeData =
{
	Costume_Default =
	{
		GrannyModel = "Melinoe_Mesh",
		GrannyTexture = "",
		ActiveGrannyAttachment = "",
		Removable = true,
		RotateOnly = true,
		Icon = "Shop_BedroomDecor",
		RemoveCosmetics =
		{
			"Costume_ColorAlternative",
		},

		PreRevealVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Queue = "Always",

				{ Cue = "/VO/Melinoe_1407", Text = "Let's try this on for size." },
			},
		},

		--[[
		RevealReactionVoiceLines =
		{
			{
				Queue = "Always",
				RandomRemaining = true,
				PreLineWait = 1.0,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1409", Text = "It's certainly a change..." },
				{ Cue = "/VO/Melinoe_1410", Text = "How do I look?" },
				{ Cue = "/VO/Melinoe_1411", Text = "Seems like a decent fit..." },
				{ Cue = "/VO/Melinoe_1412", Text = "I think I like it..." },
			},
		},
		]]--
		RemoveGlobalVoiceLines = "CostumeReAddedVoiceLines",
		ReEquipGlobalVoiceLines = "CostumeReAddedVoiceLines",
	},

	Costume_ColorAlternative =
	{
		GrannyModel = "Melinoe_ColorAlternative",
		GrannyTexture = "Models/Melinoe/Melinoe_ColorAlternative",
		ActiveGrannyAttachment = "",
		Removable = true,
		RotateOnly = true,
		Icon = "Shop_BedroomDecor",
		Cost =
		{
			CostumePoints = 1,
		},
		RemoveCosmetics =
		{
			"Costume_Default",
		},

		PreRevealVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				-- SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Queue = "Always",

				{ Cue = "/VO/Melinoe_1408", Text = "You know what, sure." },
			},
		},

		RemoveGlobalVoiceLines = "CostumeReAddedVoiceLines",
		ReEquipGlobalVoiceLines = "CostumeReAddedVoiceLines",
	},	
}