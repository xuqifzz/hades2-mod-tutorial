function BiomeStateStartedPresentation( biomeStateData )

	wait(0.5)

	PlaySound({ Name = "/Leftovers/World Sounds/Thunder" })

	local preFountainBloom = GetBloomSettingName({ })
	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.5 })

	wait(0.5)

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 3.0 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 3.0 })
	AdjustFullscreenBloom({ Name = preFountainBloom, Duration = 3.0 })

end

function BloodMoonBiomeStartPresentation()
	wait(1.0)
	AdjustColorGrading({ Name = "BloodMoon", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "BloodMoonBloom", Duration = 0.5 })
	wait( 1.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 4.0 })
	AdjustColorGrading({ Name = "Off", Duration = 4.0 })
end

function GoldStateStartPresentation()
	wait(1.0)
	AdjustColorGrading({ Name = "Gold", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "GoldBloom", Duration = 0.5 })
	wait( 1.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 4.0 })
	AdjustColorGrading({ Name = "Off", Duration = 4.0 })
end

function MeteorStateStartPresentation()
	wait(1.0)
	AdjustColorGrading({ Name = "MeteorCinders", Duration = 0.5 })
	wait( 1.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 4.0 })
	AdjustColorGrading({ Name = "Off", Duration = 10.0 })
end

function MoonDustStartPresentation()
	wait(1.0)
	AdjustColorGrading({ Name = "MoonDust", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "MoonDustBloom", Duration = 0.5 })
	wait( 1.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 4.0 })
	AdjustColorGrading({ Name = "Off", Duration = 10.0 })
end

function BloodMoonPresentation( args ) 
	DebugPrint({Text = "Per-room blood moon presentation" })
	CreateAnimation({ Name = "BiomeStateBloodMoonFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
end

function MoonDustPresentation( args ) 
	DebugPrint({Text = "Per-room moon dust presentation" })
	CreateAnimation({ Name = "BiomeStateMoonDustFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
end

function MeteorStatePresentation( args ) 
	DebugPrint({Text = "Per-room meteor presentation" })
	CreateAnimation({ Name = "BiomeStateMeteorCindersFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
end

function RainPresentation( args )
	CreateAnimation({ Name = "BiomeStateRainFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
	AdjustColorGrading({ Name = "RainSubtle", Duration = 0.5 })
	wait(0.1)
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

function GoldStatePresentation( args )
	DebugPrint({Text = "Per-room gold presentation" })
	CreateAnimation({ Name = "BiomeStateGoldFx", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
end

function ShadeMercStatePresentation( args )
	DebugPrint({Text = "Per-room ghost merc presentation" })
	Activate({ Ids = GetInactiveIdsByType({ Name = "ShadeMercFlag" }) }) 
end