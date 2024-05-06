function GardenPlantSeedPresentation( plot, args, user )
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = plot.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = user.ObjectId })

	wait(0.25)

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })	
	thread( PlayVoiceLines, HeroVoiceLines.PlantingVoiceLines, true )

	wait(0.2)

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })	

	wait(0.2)

	PlaySound({ Name = "/Leftovers/SFX/BallLand", Id = user.ObjectId })

	SetAnimation({ DestinationId = plot.PlantId, Name = GardenData.JustPlantedAnimation })
	CreateTextBox({
		Id = plot.PlantId,
		Text = "GardenPlotStatus_Growing",
		Justification = "Center",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		LuaKey = "TempTextData",
		LuaValue = plot,
		AutoSetDataProperties = false,
	})
	plot.UseText = "UseGardenPlotNotReady"
	plot.TalkOnlyIfNoGiftOrSpecial = true

	wait( 0.2 )
	
end

function CheckSeedStatus()
	for id, plot in pairs( GameState.GardenPlots ) do
		if HasSeeds() then
			PlayStatusAnimation( plot, { Animation = "StatusIconWantsToTalkImportant", OffsetZ = plot.AnimOffsetZ } )
		end
	end
end

function GardenPlotSetupPresentation( plot, args, sourceArgs )

	args = args or {}
	sourceArgs = sourceArgs or {}
	if plot.SeedName == nil then
		if HasSeeds() then
			PlayStatusAnimation( plot, { Animation = "StatusIconWantsToTalkImportant", OffsetZ = plot.AnimOffsetZ } )
		end
		return
	end

	local seedData = GardenData.Seeds[plot.SeedName]
	if seedData == nil then
		DebugPrint({ Text = "SeedData doesn't exist: "..plot.SeedName })
		return
	end
	CreateTextBox({
		Id = plot.PlantId,
		Text = "GardenPlotStatus_Growing",
		Justification = "Center",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Font = "P22UndergroundSCMedium",
		FontSize = 22,
		LuaKey = "TempTextData",
		LuaValue = plot,
		AutoSetDataProperties = false,
	})
	GardenPlotTimeUpdatePresentation( plot, args )
end

function HasSeeds( neededCount )
	local numSeeds = 0
	for seedName, seedData in pairs( GardenData.Seeds ) do
		numSeeds = numSeeds + (GameState.Resources[seedName] or 0)
	end
	if numSeeds >= (neededCount or 1) then
		return true
	end
	return false
end

function GardenPlotTimeUpdateStartPresentation( args )
	local plotIds = GetAllKeys( GameState.GardenPlots )
	if not args.SkipCameraPan then
		PanCamera({ Ids = plotIds, Duration = args.PanDuration or 1.5, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	end

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

	wait( args.PanDuration or 1.5 )
end

function GardenPlotTimeTickPresentation( plot, args )
	if not args.SkipSound then
		PlaySound({ Name = "/Leftovers/SFX/PyreTickUp", plot.PlantId })
	end
end

function GardenPlotTimeUpdatePresentation( plot, args )
	local outcomeData = GardenData.Seeds[plot.SeedName].RandomOutcomes[plot.OutcomeKey]
	if outcomeData == nil then
		return
	end
	
	local text = "GardenPlotStatus_Growing"
	if (plot.LifetimeGrows or 0) >= 1 then
		-- Completed at least 1 full grow cycle
		if plot.StoredGrows <= 0 then
			plot.UseText = "UseGardenPlotNotReady"
			plot.TalkOnlyIfNoGiftOrSpecial = true
			SetAnimation({ DestinationId = plot.PlantId, Name = outcomeData.FullyGrownAnimation })
		else
			plot.UseText = "UseGardenPlotReady"
			plot.TalkOnlyIfNoGiftOrSpecial = false
			SetAnimation({ DestinationId = plot.PlantId, Name = outcomeData.ReadyToHarvestAnimation })
		end
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = plot.PlantId })
		--[[
		if plot.ResourceIconPath ~= nil then
			if plot.StoredGrows < (plot.MaxStoredGrows or 1) then
				text = "GardenPlotStatus_PartialStoredGrows"
			else
				text = "GardenPlotStatus_FullStoredGrows"
			end
		end
		]]
	elseif plot.GrowTimeRemaining == plot.StartingGrowTime then
		-- Just planted
		plot.UseText = "UseGardenPlotNotReady"
		plot.TalkOnlyIfNoGiftOrSpecial = true
		SetAnimation({ DestinationId = plot.PlantId, Name = GardenData.JustPlantedAnimation })
	else
		-- Sprouted
		plot.UseText = "UseGardenPlotNotReady"
		plot.TalkOnlyIfNoGiftOrSpecial = true
		SetAnimation({ DestinationId = plot.PlantId, Name = outcomeData.SproutedAnimation })
		PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract", Id = plot.PlantId })
	end

	ModifyTextBox({
		Id = plot.PlantId,
		Text = text,
		LuaKey = "TempTextData",
		LuaValue = plot,
	})
end

function GardenPlotInProgressPresentation( source, args, user )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = source.ObjectId })
end

function GardenHarvestStartPresentation( source, args, user )
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	wait(0.25)

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })	

	thread( PlayVoiceLines, HeroVoiceLines.HarvestVoiceLines, true )

	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract", Id = user.ObjectId })
	CreateAnimation({ Name = "PlantMatterHarvestFx", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })	
	Shake({ Id = source.ObjectId, Distance = 2, Speed = 100, Duration = 0.3 })
	wait(0.2)

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })	

	wait(0.2)
	CreateAnimation({ Name = "PlantHarvestFxSparkle", DestinationId = source.ObjectId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })	

end

function GardenHarvestEndPresentation( source, args, user )

	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing4", Id = user.ObjectId })

end