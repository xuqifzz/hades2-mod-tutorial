function SetupGardenPlot( plot, args )
	if GameState.GardenPlots[plot.ObjectId] ~= nil then
		GameState.GardenPlots[plot.ObjectId].StatusAnimation = nil -- Don't persist
		OverwriteTableKeys( plot, GameState.GardenPlots[plot.ObjectId] )
	end
	GameState.GardenPlots[plot.ObjectId] = plot
	if plot.SeedName ~= nil then
		plot.PlantId = SpawnObstacle({ Name = "PlantBase", DestinationId = plot.ObjectId, Group = "Standing" })
	end
	plot.TimesUsed = plot.TimesUsed or 0

	GardenPlotSetupPresentation( plot, args )
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
	
	if plot.ReadyForHarvest then
		-- Harvest
		AddInputBlock({ Name = "UseGardenPlot" })
		local plotIdsToHarvest = { plot.ObjectId }
		if GameState.WorldUpgrades.WorldUpgradeGardenHarvestAll then
			for id, gardenPlot in pairs( GameState.GardenPlots ) do
				if id ~= plot.ObjectId and gardenPlot.ReadyForHarvest then
					table.insert( plotIdsToHarvest, id )
				end
			end
		end
		for i, harvestPlotId in ipairs( plotIdsToHarvest ) do
			local harvestPlot = GameState.GardenPlots[harvestPlotId]
			local seedData = GardenData.Seeds[harvestPlot.SeedName]
			if seedData ~= nil then
				local outcomeData = seedData.RandomOutcomes[harvestPlot.OutcomeKey]
				if outcomeData ~= nil then
					if i == 1 then
						GardenHarvestStartPresentation( harvestPlot, { PlotIds = plotIdsToHarvest, PlantName = GetFirstKey( outcomeData.AddResources ) }, user )
					end
					for resourceName, count in pairs( outcomeData.AddResources ) do
						AddResource( resourceName, count, harvestPlot.Name, { PresentationDelay = 0.5 * (i - 1) } )
					end
					RandomSynchronize( GetIndex( GardenData.PlotOrder, harvestPlotId ) )
					if GameState.WorldUpgrades.WorldUpgradeHarvestUpgrade and RandomChance( WorldUpgradeData.WorldUpgradeHarvestUpgrade.SeedChance ) then
						local bonusSeedName = outcomeData.BonusSeedName or harvestPlot.SeedName
						thread( GardenGiveBonusSeed, harvestPlot, { SeedName = bonusSeedName, PresentationDelay = 0.5 * (i - 1) + 0.3 }, user )
					end
					harvestPlot.ReadyForHarvest = false
					Destroy({ Id = harvestPlot.PlantId })
					harvestPlot.SeedName = nil
					harvestPlot.UseText = "UseGardenPlotPlant"
					harvestPlot.TalkOnlyIfNoGiftOrSpecial = true
					if HasSeeds() then
						SetAnimation({ DestinationId = harvestPlot.ObjectId, Name = "GardenPlotReadyToPlant" })
					end
				end
			end
		end
		GardenHarvestEndPresentation( nil, nil, user )
		RemoveInputBlock({ Name = "UseGardenPlot" })
		UpdateAffordabilityStatus()
		return
	end

end

function GardenPlantSeed( screen, button, args  )

	args = args or {}
	AddInputBlock({ Name = "PlantSeedInGarden" })

	local seedName = button.ResourceData.Name
	local seedData = GardenData.Seeds[seedName]
	local spentSeeds = 0

	local plots = {}
	local plantIds = {}
	if args.MultiPlant then
		for id, plot in pairs( GameState.GardenPlots ) do
			if plot ~= screen.Args.PlantTarget and plot.SeedName == nil then
				table.insert( plots, plot )
			end
		end
		table.sort( plots, GardenSortPlots )
	end
	table.insert( plots, 1, screen.Args.PlantTarget )
	for i, plot in ipairs( plots ) do
		if HasResource( seedName, spentSeeds + 1 ) then
			plot.SeedName = seedName
			plot.StartingGrowTime = RandomInt( seedData.GrowTimeMin, seedData.GrowTimeMax )
			plot.GrowTimeRemaining = plot.StartingGrowTime
			plot.TimesUsed = plot.TimesUsed + 1
			plot.UseText = "UseGardenPlotNotReady"
			plot.TalkOnlyIfNoGiftOrSpecial = true
			plot.PlantId = SpawnObstacle({ Name = "PlantBase", DestinationId = plot.ObjectId, Group = "Standing" })
			table.insert( plantIds, plot.PlantId )

			local weightedList = {}
			for k, option in pairs( seedData.RandomOutcomes ) do
				if option.GameStateRequirements == nil or IsGameStateEligible( option, option.GameStateRequirements ) then
					weightedList[k] = option.Weight or 1
				end
			end
			plot.OutcomeKey = GetRandomValueFromWeightedList( weightedList )
			local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
			local resourceName = GetFirstKey( outcomeData.AddResources )
			plot.ResourceIconPath = ResourceData[resourceName].IconPath

			StopStatusAnimation( plot )
			SetAnimation({ DestinationId = plot.ObjectId, Name = "GardenPlot" })
			spentSeeds = spentSeeds + 1
		end
	end

	CloseInventoryScreen( screen, button )
	SpendResource( seedName, spentSeeds, "Garden" )
	GameState.GardenLastSeedPlanted = seedName

	if not HasSeeds() then
		-- No more seeds for any plot
		for id, plot in pairs( GameState.GardenPlots ) do
			if plot.SeedName == nil then
				StopStatusAnimation( plot )
				SetAnimation({ DestinationId = plot.ObjectId, Name = "GardenPlot" })
			end
		end
	end

	GardenPlantSeedPresentation( screen.Args.PlantTarget, { PlantIds = plantIds, Plots = plots }, CurrentRun.Hero )
	RemoveInputBlock({ Name = "PlantSeedInGarden" })
end

function GardenSortPlots( plotA, plotB )
	return GetIndex( GardenData.PlotOrder, plotA.ObjectId ) < GetIndex( GardenData.PlotOrder, plotB.ObjectId )
end

function GardenMultiPlantSeed( screen, button )
	if screen.SelectedItem == nil then
		return
	end
	if screen.SelectedItem.PinContextualAction ~= "Menu_MultiPlant" then
		return
	end
	GameState.Flags.HasMultiPlanted = true
	GardenPlantSeed( screen, screen.SelectedItem, { MultiPlant = true } )
end

function GardenGiveBonusSeed( source, args, user )
	GardenBonusSeedPresentation( source, args, user )
	AddResource( args.SeedName, 1, source.Name, { Text = "GainBonusResource", HoldOffsetY = -370, PresentationDelay = args.PresentationDelay, FlyDuration = 0.8 } )
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
						plot.ReadyForHarvest = true
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