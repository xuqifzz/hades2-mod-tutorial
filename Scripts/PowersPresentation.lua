function ZeusCloudStartPresentation( functionArgs, triggerArgs, tempObstacleId )
	CreateAnimation({ Name = "ZeusCastWeatherFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
	AdjustColorGrading({ Name = "ZeusWeather", Duration = 1 })
end

function ZeusCloudFinishPresentation( functionArgs, tempObstacleId )
	AdjustColorGrading({ Name = "Off", Duration = 2 })
	StopAnimation({ Name = "ZeusCastWeatherFx", DestinationId = CurrentRun.Hero.ObjectId })
end

function HadesInvulnerableWarnPresentation()
	PlaySound({ Name = "/SFX/HexEndingWarning", Id = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function HadesLaserRetaliatePresentation()
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingSpell", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/Enemy Sounds/Hades/HadesLaserBlastChargeUp", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "HadesLaserThresholdBoonActivated", 1.0 )
end

function HeavyArmorInitialPresentation()
	CreateAnimation({ Name = "HephaestusArmorUp", DestinationId = CurrentRun.Hero.ObjectId })
end