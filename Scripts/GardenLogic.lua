function SetupGardenPlot( plot, args, sourceArgs )
	if GameState.GardenPlots[plot.ObjectId] ~= nil then
		GameState.GardenPlots[plot.ObjectId].StatusAnimation = nil -- Don't persist
		OverwriteTableKeys( plot, GameState.GardenPlots[plot.ObjectId] )
	end
	GameState.GardenPlots[plot.ObjectId] = plot
	if plot.SeedName ~= nil then
		plot.PlantId = SpawnObstacle({ Name = "PlantBase", DestinationId = plot.ObjectId, Group = "Standing" })
	end
	-- Back compat
	if plot.MaxStoredResources == nil then
		local seedData = GardenData.Seeds[plot.SeedName]
		if seedData ~= nil then
			local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
			if outcomeData ~= nil then
				local addResourceAmount = GetFirstValue( outcomeData.AddResources )
				plot.StoredResources = (plot.StoredGrows or 0) * addResourceAmount
				plot.MaxStoredResources = (plot.MaxStoredGrows or 0) * addResourceAmount
			end
		end
	end

	GardenPlotSetupPresentation( plot, args, sourceArgs )
end

function UseGardenPlot( plot, args, user )

	if not CheckCooldown( "UsedGardenPlot", 0.75 ) then
		return
	end

	if plot.SeedName == nil then
		-- Plant new seed
		OpenInventoryScreen( { PlantTarget = plot, DefaultCategoryIndex = 2, CategoryLocked = true, InitialSelection = GameState.GardenLastSeedPlanted, } )
		return
	end
	
	if (plot.StoredGrows or 0) >= 1 then
		-- Harvest
		AddInputBlock({ Name = "UseGardenPlot" })
		GardenHarvestStartPresentation( plot, args, user )		
		local seedData = GardenData.Seeds[plot.SeedName]
		if seedData ~= nil then
			local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
			if outcomeData ~= nil then
				for resourceName, count in pairs( outcomeData.AddResources ) do
					AddResource( resourceName, count * plot.StoredGrows, plot.Name )
				end
			end
		end
		local growsHarvested = plot.StoredGrows
		plot.StoredGrows = 0
		plot.StoredResources = 0
		GardenHarvestEndPresentation( plot, args, user )
		if seedData ~= nil and seedData.RepeatGrowTimeMin ~= nil then
			if growsHarvested == plot.MaxStoredGrows then
				-- Immediately start the next grow if was full
				plot.StartingGrowTime = RandomInt( seedData.RepeatGrowTimeMin, seedData.RepeatGrowTimeMax )
				plot.GrowTimeRemaining = plot.StartingGrowTime
			end
			GardenPlotTimeUpdatePresentation( plot, args )
		else
			Destroy({ Id = plot.PlantId })
			plot.SeedName = nil
			plot.UseText = "UseGardenPlotPlant"
			plot.TalkOnlyIfNoGiftOrSpecial = true
		end
		RemoveInputBlock({ Name = "UseGardenPlot" })
		UpdateAffordabilityStatus()
		if HasSeeds() then
			PlayStatusAnimation( plot, { Animation = "StatusIconWantsToTalkImportant", OffsetZ = plot.AnimOffsetZ } )
		end
		return
	end

	GardenPlotInProgressPresentation( plot, args, user )
end

function GardenPlantSeed( screen, button  )
	AddInputBlock({ Name = "PlantSeedInGarden" })
	local plot = screen.Args.PlantTarget
	if HasSeeds( 2 ) then
		StopStatusAnimation( plot )
	else
		-- No more seeds for any plot
		for id, plot in pairs( GameState.GardenPlots ) do
			StopStatusAnimation( plot )
		end
	end
	CloseInventoryScreen( screen, button )
	plot.SeedName = button.ResourceData.Name
	local seedData = GardenData.Seeds[plot.SeedName]
	plot.StartingGrowTime = RandomInt( seedData.GrowTimeMin, seedData.GrowTimeMax )
	plot.GrowTimeRemaining = plot.StartingGrowTime
	plot.StoredGrows = 0
	plot.StoredResources = 0
	plot.LifetimeGrows = 0

	local seedData = GardenData.Seeds[plot.SeedName]
	local weightedList = {}
	for k, option in pairs( seedData.RandomOutcomes ) do
		if IsGameStateEligible( CurrentRun, option, option.GameStateRequirements ) then
			weightedList[k] = option.Weight or 1
		end
	end
	plot.OutcomeKey = GetRandomValueFromWeightedList( weightedList )
	local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
	local resourceName = GetFirstKey( outcomeData.AddResources )
	plot.ResourceIconPath = ResourceData[resourceName].IconPath
	plot.MaxStoredGrows = seedData.MaxStoredGrows or 1
	plot.MaxStoredResources = plot.MaxStoredGrows * GetFirstValue( outcomeData.AddResources )

	GameState.GardenLastSeedPlanted = plot.SeedName

	plot.PlantId = SpawnObstacle({ Name = "PlantBase", DestinationId = plot.ObjectId, Group = "Standing" })
	SpendResource( button.ResourceData.Name, 1, "Graden" )
	GardenPlantSeedPresentation( plot, nil, CurrentRun.Hero )
	RemoveInputBlock({ Name = "PlantSeedInGarden" })
end


function GardenTimeTick( args )
	args = args or {}
	if args.UpdatePlotPresentation then
		GardenPlotTimeUpdateStartPresentation( args )
	end
	for tick = 1, (args.Ticks or 1) do
		for plotId, plot in pairs( GameState.GardenPlots ) do
			if args.PlotId == nil or plotId == args.PlotId then
				if plot.GrowTimeRemaining ~= nil and plot.GrowTimeRemaining > 0 then
					plot.GrowTimeRemaining = plot.GrowTimeRemaining - 1
					if plot.GrowTimeRemaining <= 0 then
						local seedData = GardenData.Seeds[plot.SeedName]
						if seedData ~= nil then
							if (plot.StoredGrows or 0) < (seedData.MaxStoredGrows or 1) then
								plot.StoredGrows = (plot.StoredGrows or 0) + 1
								local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
								if outcomeData ~= nil then
									plot.StoredResources = plot.StoredGrows * GetFirstValue( outcomeData.AddResources )
									plot.LifetimeGrows = (plot.LifetimeGrows or 0) + 1
									if seedData.RepeatGrowTimeMin ~= nil then
										plot.StartingGrowTime = RandomInt( seedData.RepeatGrowTimeMin, seedData.RepeatGrowTimeMax )
										plot.GrowTimeRemaining = plot.StartingGrowTime
									end
								end
							end
						end
					end
					GardenPlotTimeTickPresentation( plot, args )
					if args.UpdatePlotPresentation then
						GardenPlotTimeUpdatePresentation( plot, args )
					end
				end
			end
		end
		wait( args.TickInterval )
	end
end

function GiftGardenPlot( target, args, giftName )
	AddInputBlock({ Name = "GiftGardenPlot" })
	UseableOff({ Id = target.ObjectId })
	GardenTimeTick( { Ticks = args.Ticks, PlotId = target.ObjectId, UpdatePlotPresentation = true, PanDuration = 0.0, SkipCameraPan = true, TickInterval = 0.2, } )
	UseableOn({ Id = target.ObjectId })
	RemoveInputBlock({ Name = "GiftGardenPlot" })
end