function BiomeStateStartedPresentation( biomeStateData )

	wait(0.5)

	PlaySound({ Name = "/Leftovers/World Sounds/Thunder" })

	BloomRequestStart({ SourceName = "BiomeStateStartedPresentation", BloomType = "BlurryLight", Duration = 0.5 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.5 })

	wait(0.5)

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 3.0 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 3.0 })
	BloomRequestEnd({ SourceName = "BiomeStateStartedPresentation", Duration = 3.0 })

end


function RainPresentation( args )
	CreateAnimation({ Name = "BiomeStateRainFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
	AdjustColorGrading({ Name = "RainSubtle", Duration = 0.5 })
	if AudioState.RainSoundId == nil then
		AudioState.RainSoundId = PlaySound({ Name = "/Leftovers/Ambience/CrossroadsRainAmbience" })
	end
	for fromSound, toSound in pairs( BiomeStateData.BiomeStates.Rain.SwapSounds ) do
		SwapSound({ Name = fromSound, DestinationName = toSound })
	end
end

function DimRainPresentation( args )
	StopAnimation({ Name = "BiomeStateRainFx", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })
	SetSoundCueValue({ Name = "Interior", Value = 1.0, Id = AudioState.RainSoundId, Duration = 0.7 })
end

function UnDimRainPresentation( args )
	CreateAnimation({ Name = "BiomeStateRainFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
	AdjustColorGrading({ Name = "RainSubtle", Duration = 0.5 })
	SetSoundCueValue({ Name = "Interior", Value = 0.0, Id = AudioState.RainSoundId, Duration = 0.7 })
end

function RainEndPresentation()
	if AudioState.RainSoundId ~= nil then
		StopSound({ Id = AudioState.RainSoundId, Duration = 5 })
		AudioState.RainSoundId = nil
	end
end
