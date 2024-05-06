function ZeusCloudStartPresentation( functionArgs, triggerArgs, tempObstacleId )
	CreateAnimation({ Name = "ZeusCastWeatherFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
	AdjustColorGrading({ Name = "ZeusWeather", Duration = 1 })
end

function ZeusCloudFinishPresentation( functionArgs, tempObstacleId )
	AdjustColorGrading({ Name = "Off", Duration = 2 })
	StopAnimation({ Name = "ZeusCastWeatherFx", DestinationId = CurrentRun.Hero.ObjectId })
end