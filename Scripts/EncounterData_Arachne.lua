OverwriteTableKeys( EncounterData,
{
	ArachneCombatG =
	{
		InheritFrom = { "BaseArachneCombat" },

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SetupArachneCombatEncounter", Args = { CocoonCountMin = 8, CocoonCountMax = 14,
					CocoonOptions = { "ArachneCocoon_G", "ArachneCocoon_G", "ArachneCocoon_G",
						  "ArachneCocoonMedium_G", "ArachneCocoonMedium_G",
						  "ArachneCocoonLarge_G", }, } }
		},
	},

	ArachneCombatN =
	{
		InheritFrom = { "BaseArachneCombat" },
	},
})