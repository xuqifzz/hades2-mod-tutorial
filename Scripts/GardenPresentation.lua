function GardenPlantSeedPresentation( plot, args, user )
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = plot.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort", Id = user.ObjectId })

	wait(0.25)

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })	
	thread( PlayVoiceLines, HeroVoiceLines.PlantingVoiceLines, true )

	wait(0.2)

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })	

	wait(0.2)

	PlaySound({ Name = "/SFX/ShovelDigShort2", Id = user.ObjectId })

	SetAnimation({ DestinationIds = args.PlantIds, Name = GardenData.JustPlantedAnimation })
	for i, plantId in ipairs( args.PlantIds ) do
		CreateTextBox({
			Id = plantId,
			Text = "GardenPlotStatus_Growing",
			Justification = "Center",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Font = "P22UndergroundSCMedium",
			FontSize = 22,
			LuaKey = "TempTextData",
			LuaValue = args.Plots[i],
			AutoSetDataProperties = false,
		})
		if plantId ~= plot.PlantId then
			CreateAnimation({ Name = "PlantHarvestFxSparkleEmitter", DestinationId = plantId, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
		end
	end

	if #args.PlantIds > 1 then
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitementShort" })
	end

	wait( 0.2 )
	
end

function CheckSeedStatus()
	for id, plot in pairs( GameState.GardenPlots ) do
		if HasSeeds() then
			SetAnimation({ DestinationId = plot.ObjectId, Name = "GardenPlotReadyToPlant" })
		end
	end
end

function GardenPlotSetupPresentation( plot, args )
	args = args or {}

	if plot.SeedName == nil then
		local hasSeeds = HasSeeds()
		if plot.TimesUsed < 1 and ( hasSeeds or not plot.PlayedRevealStatus ) then
			PlayStatusAnimation( plot, { Animation = "StatusIconWantsToTalkImportant", OffsetZ = plot.AnimOffsetZ, Scale = 0.75 } )
			plot.PlayedRevealStatus = true
		end
		if hasSeeds then
			SetAnimation({ DestinationId = plot.ObjectId, Name = "GardenPlotReadyToPlant" })
		else
			SetAnimation({ DestinationId = plot.ObjectId, Name = "GardenPlot" })
		end
		return
	end

	local seedData = GardenData.Seeds[plot.SeedName]
	if seedData == nil then
		DebugPrint({ Text = "SeedData doesn't exist: "..plot.SeedName })
		return
	end

	if not plot.ReadyForHarvest then
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
	end
	GardenPlotTimeUpdatePresentation( plot, args )
end

function GardenPlotTimeUpdateStartPresentation( args )
	local plotIds = GetAllKeys( GameState.GardenPlots )
	if not args.SkipCameraPan then
		PanCamera({ Ids = plotIds, Duration = args.PanDuration or 1.5, EaseIn = 0.05, EaseOut = 0.03, Retarget = true, FromCurrentLocation = true })
	end

	-- PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })

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

	if plot.ReadyForHarvest then
		plot.UseText = "UseGardenPlotReady"
		plot.TalkOnlyIfNoGiftOrSpecial = false
		SetAnimation({ DestinationId = plot.PlantId, Name = outcomeData.ReadyToHarvestAnimation })
		DestroyTextBox({ Id = plot.PlantId })
	else
		if plot.GrowTimeRemaining == plot.StartingGrowTime then
			-- Just planted
			plot.UseText = "UseGardenPlotNotReady"
			plot.TalkOnlyIfNoGiftOrSpecial = true
			SetAnimation({ DestinationId = plot.PlantId, Name = GardenData.JustPlantedAnimation })
		else
			-- Sprouted
			plot.UseText = "UseGardenPlotNotReady"
			plot.TalkOnlyIfNoGiftOrSpecial = true
			SetAnimation({ DestinationId = plot.PlantId, Name = outcomeData.SproutedAnimation })
		end
		ModifyTextBox({
			Id = plot.PlantId,
			Text = "GardenPlotStatus_Growing",
			LuaKey = "TempTextData",
			LuaValue = plot,
		})
	end
end

function GardenHarvestStartPresentation( source, args, user )
	
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = source.ObjectId })

	wait(0.25)

	SetAnimation({ Name = "MelinoeGatherStart", DestinationId = user.ObjectId })	

	thread( PlayVoiceLines, HeroVoiceLines.HarvestVoiceLines, true, nil, args )

	PlaySound({ Name = "/SFX/ResourceGatherSFX", Id = user.ObjectId })
	for _, id in ipairs( args.PlotIds ) do
		CreateAnimation({ Name = "PlantMatterHarvestFx", DestinationId = id, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	end
	Shake({ Id = source.ObjectId, Distance = 2, Speed = 100, Duration = 0.3 })
	wait(0.2)

	SetAnimation({ Name = "MelinoeGatherPickup", DestinationId = user.ObjectId })

	wait(0.2)

	for _, id in ipairs( args.PlotIds ) do
		CreateAnimation({ Name = "PlantHarvestFxSparkle", DestinationId = id, Group = "Combat_Menu_TraitTray_Overlay_Additive" })
	end

end

function GardenHarvestEndPresentation( source, args, user )

	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing4", Id = user.ObjectId })

end

function GardenBonusSeedPresentation( source, args, user )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Id = user.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.HarvestBonusResourceVoiceLines, true )
end
