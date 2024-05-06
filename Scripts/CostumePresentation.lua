function ArachneCostumeStartPresentation( screen, args )
	AddInputBlock({ Name = "ArachneCostumePresentation" })
	wait( 0.15 )
	thread( PlayVoiceLines, GlobalVoiceLines.CostumeChangedVoiceLines )
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction * 1.05, Duration = 0.25 })
	SetAnimation({ Name = "MelinoeBoonInteractPowerUp", DestinationId = CurrentRun.Hero.ObjectId, AnimationSpeed = 0.5 })
	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.7 })
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteSparklySFX" })
	CreateAnimation({ Name = "StatusIconNPCRescued", DestinationId = screen.Source.ObjectId })
end

function ArachneCostumeEndPresentation( screen, args )
	RemoveInputBlock({ Name = "ArachneCostumePresentation" })
	wait( 0.3 )
	FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 2.5 })
end

function DoorGoldCostumePresentation( money )
	waitUnmodified( SessionMapState.DoorTextCount * UIData.DoorTextCumulativeDelay, RoomThreadName )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "GoldIncrease", Duration = 0.7, LuaKey = "TooltipData", ShadowScaleX = 0.35, OffsetY = -100,  LuaValue = { Amount = money }})
end