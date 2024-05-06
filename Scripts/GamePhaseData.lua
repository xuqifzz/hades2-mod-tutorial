GamePhaseData = 
{
	StartingGamePhase = 5,
	MaxGamePhase = 8,
	OnDeathTicksMin = 1,
	OnDeathTicksMax = 1,
	GamePhaseDefaultMinTicks = 60,
	GamePhaseDefaultMaxTicks = 60,
	AdvancementGameStateRequirements =
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp", },
		},
	},
	GamePhases =				-- Custom durations for certain phases''
	{
		{
			Graphic = "MoonPhase1",
			Text = "Inventory_MoonPhase1",
			MinTicks = 40,
			MaxTicks = 40,
		},
		{
			Graphic = "MoonPhase2",
			Text = "Inventory_MoonPhase2",
		},
		{
			Graphic = "MoonPhase3",
			Text = "Inventory_MoonPhase3",
		},
		{
			Graphic = "MoonPhase4",
			Text = "Inventory_MoonPhase4",
		},
		{
			Graphic = "MoonPhase5",
			Text = "Inventory_MoonPhase5",
			MinTicks = 40,
			MaxTicks = 40,
		},
		{
			Graphic = "MoonPhase6",
			Text = "Inventory_MoonPhase6",
		},
		{
			Graphic = "MoonPhase7",
			Text = "Inventory_MoonPhase7",
		},
		{
			Graphic = "MoonPhase8",
			Text = "Inventory_MoonPhase8",
		}
	}
}