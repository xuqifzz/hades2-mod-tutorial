BiomeStateData = 
{
	DefaultBiomeStateChance = 0.10,
	NoBiomeStateChanceIncrement = 0.02,
	DefaultBiomeState = "VanillaState",
	DefaultBiomeStateRequirements = 
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
			IsAny = { "N", "F", },
		},
	},
	ForceGameStateRequirements = 
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 3,
		},
		{
			PathFalse = { "GameState", "TextLinesRecord", "ZeusFirstPickUp" },
		},
	},
	GameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "TextLinesRecord", "ZeusFirstPickUp" },
		},
	},
	BiomeStates = 
	{
		Rain = 
		{
			GameStateRequirements = 
			{
				{	
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
				{
					SumPrevRuns = 4,
					Path = { "BiomeStateChangeCount" },
					Comparison = "<=",
					Value = 0,
				},
			},
			TraitName = "WetState",
			PreGeneratePresentationFunctionName = "RainPresentation",
			DimPresentationFunctionName = "DimRainPresentation",
			UnDimPresentationFunctionName = "UnDimRainPresentation",			
			BiomeEndPresentationFunctionName = "RainEndPresentation",
			SwapSounds =
			{
				["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWetSmall",
				["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWetMedium",
			}
		},
		VanillaState = 
		{
			Skip = true,
			
			TraitName = "VanillaState",
			TraitGameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", },
				},
			},
		},
	}
}
TraitSetData.BiomeStates =
{
	BiomeState =
	{
		BiomeStateTrait = true,
		Hidden = true,
		DebugOnly = true,
	},

	VanillaState = 
	{
		InheritFrom = {"BiomeState"},
	},
	WetState = 
	{
		InheritFrom = {"BiomeState"},
		SetupFunctions =
		{
			{
				Threaded = true,
				RequiredContext = "StartRoom",
				Name = "RainPresentation",
			}
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.BiomeStates )