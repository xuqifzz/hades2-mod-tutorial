RoomSetData.Secrets =
{
	BaseSecret =
	{
		DebugOnly = true,

		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		EntranceAnimation = "MelinoeSpellFire",
		EntranceVfx = "SecretDoorDiveFx",
		ExitAnimation = "MelinoeSpellFire",
		ExitVfx = "SecretDoorDiveFx",
		ExitDoorOpenAnimation = "ExitDoorLinesSpecial",
		ExitDoorCloseAnimation = "ExitDoorLinesSpecial",
		SkipLastKillPresentation = true,
		UsePromptOffsetY = 120,
		LocationText = "Location_Secret",
		ResultText = "RunHistoryScreenResult_Secret",
		RichPresence = "#RichPresence_Chaos",
		BiomeName = "Secrets",
		LocationTextColor = { 20, 0, 255, 255 },
		Ambience = "/Leftovers/Ambience/MountainAmbience",
		SecretMusic = "/Music/ChaosTheme_MC",
		SkipLeavePrevRoomSFX = true,
		UsePreviousRoomSet = true,
		BlockHeroLight = true,
		ForcedRewardStore = "Secrets",
		LegalEncounters = { "Empty" },
		ZoomFraction = 0.75,
		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		SoftClamp = 0.75,
		FishingPointChance = 0.00,
		FishingPointRequirements =
		{
			RequiredMinRoomsSinceFishingPoint = 5,
		},

	},

}

AddTableKeysCheckDupes( RoomData, RoomSetData.Secrets )