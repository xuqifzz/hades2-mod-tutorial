function SwitchToSpeedupPresentation( id )
	CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = id })
end

function SurfaceShopItemSameRoomPresentation( targetId )
	local newTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
	LoadVoiceBanks({ Name = "Hermes" })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = newTargetId, Scale = 0.5 })
	thread( PlayVoiceLines, GlobalVoiceLines.SpecialDeliverVoiceLines, true )
	HermesWipePresentation()
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId })
end

function SurfaceShopItemPresentation( targetId )
	local newTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
	LoadVoiceBanks({ Name = "Hermes" })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = newTargetId, Scale = 0.5 })
	thread( PlayVoiceLines, GlobalVoiceLines.SpecialDeliverVoiceLines, true )
	HermesWipePresentation()
	CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId })
end

function HermesWipePresentation()
	PlaySound({ Name = "/Leftovers/SFX/AuraThrowLarge" })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })

	thread( DoRumble, { { LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.4, LeftTriggerFrequencyFraction = 0.15, LeftTriggerTimeout = 0.3, }, } )

	--thread( PlayVoiceLines, HeroVoiceLines.AssistActivatedVoiceLines, true )

	local godImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godImage, OffsetX = -1500, OffsetY = (1080/2) })
	DrawScreenRelative({ Ids = { godImage } })
	CreateAnimation({ Name = "Portrait_Hermes_Default_01", DestinationId = godImage, Scale = 1.1 })

	local godDestination = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Combat_Menu" })
	Teleport({ Id = godDestination, OffsetX = 3000, OffsetY = (1080/2) })
	DrawScreenRelative({ Ids = { godDestination } })
	Move({ Id = godImage, DestinationId = godDestination, Duration = 0.35, TimeModifierFraction = 0 })
	
	wait(0.35)

	SetAlpha({ Id = godImage, Fraction = 0, Duration = 0.12, TimeModifierFraction = 0 })
	--Destroy({ Id = godImage })
end