function SetupCostume( skipCostume )
	for itemName, item in pairs( CostumeData ) do
		if GameState.WorldUpgrades[itemName] then
			if item.GrannyModel ~= nil then
				--SetThingProperty({ Property = "GrannyModel", Value = item.GrannyModel, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if item.GrannyTexture ~= nil then
				SetThingProperty({ Property = "GrannyTexture", Value = item.GrannyTexture, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
	local costumes = GetHeroTraitValues("Costume");
	if costumes[1] ~= nil and not skipCostume then
		SetThingProperty({ Property = "GrannyTexture", Value = costumes[1], DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function CheckDoorArmorTrait( currentRun )
	
	if not currentRun.Hero.HealthBuffer or currentRun.Hero.HealthBuffer <= 0 then
		return
	end
	local hasText = false
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.DoorArmor then
			trait.CurrentArmor = trait.CurrentArmor + trait.DoorArmor
			thread(OnPlayerArmorGain, {Amount = trait.DoorArmor, Delay = SessionMapState.DoorTextCount * UIData.DoorTextCumulativeDelay})
			hasText = true
		end
	end
	if hasText then
		IncrementTableValue( SessionMapState, "DoorTextCount" )
	end

end

function CheckDoorGoldTrait()
	if HeroHasTrait( "IncomeCostume" ) and not HasHeroTraitValue("BlockMoney") then
		local trait = GetHeroTrait("IncomeCostume")
		local money = round( trait.DoorCash * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ))
		AddResource( "Money", money, trait.Name )
		thread( DoorGoldCostumePresentation, money )
		IncrementTableValue( SessionMapState, "DoorTextCount" )
	end
end

function AddHealthBuffer( amount, source, args )
	args = args or {}
	MapState.HealthBufferSources = MapState.HealthBufferSources or {}
	MapState.HealthBufferSources[ source ] = amount
	local totalHealthBuffer = 0
	for armorSource, value in pairs( MapState.HealthBufferSources ) do
		totalHealthBuffer = totalHealthBuffer + value 
	end
	if args.Temporary then
		MapState.TemporaryHealthBufferSources[ source ] = true
	end
	CurrentRun.Hero.HealthBuffer = totalHealthBuffer
	thread(OnPlayerArmorGain, {Amount = amount, Silent = args.Silent, Delay = args.Delay} )
end

function RemoveHealthBufferSource( source )
	MapState.HealthBufferSources = MapState.HealthBufferSources or {}
	MapState.HealthBufferSources[ source ] = nil
	local totalHealthBuffer = 0
	for armorSource, value in pairs( MapState.HealthBufferSources ) do
		totalHealthBuffer = totalHealthBuffer + value 
	end
	MapState.TemporaryHealthBufferSources[ source ] = nil
	CurrentRun.Hero.HealthBuffer = totalHealthBuffer
	FrameState.RequestUpdateHealthUI = true
end

function RemoveHealthBufferOnDelay( traitName, delay )
	if HasThread(traitName) then
		SetThreadWait( traitName, delay - 1 ) 
		return
	elseif HasThread(traitName.."Final" ) then
		killTaggedThreads( traitName )
	end
	if delay > 1 then
		wait( delay - 1, traitName )
		CheckPlayerTempArmorFalloffPresentation(traitName)
		wait( 1, traitName.."Final")	
	else
		wait( delay, traitName )
	end
	if HeroHasTrait(traitName) then
		local trait = GetHeroTrait(traitName)
		trait.CurrentArmor = 0
	end
	RemoveHealthBufferSource( traitName )
	RemovePlayerTempArmorPresentation( traitName )
end

function HealthBufferTraitSort( itemA, itemB )
	local slotA = nil
	local slotB = nil
	if itemA.IsRenewableArmor then
		slotA  = "Temporary"
	elseif itemA.SetupFunction then
		slotA = itemA.SetupFunction.Args.Source
	elseif itemA.SetupFunctions then
		for i, setupFunction in pairs(itemA.SetupFunctions) do
			if setupFunction.Name == "CostumeArmor" or setupFunction.Name == "HephaestusArmor" then
				slotA = setupFunction.Args.Source
			end
		end
	end
	if itemB.IsRenewableArmor then
		slotB = "Temporary"
	elseif itemB.SetupFunction then
		slotB = itemB.SetupFunction.Args.Source
	elseif itemB.SetupFunctions then
		for i, setupFunction in pairs(itemB.SetupFunctions) do
			if setupFunction.Name == "CostumeArmor" or setupFunction.Name == "HephaestusArmor" then
				slotB = setupFunction.Args.Source
			end
		end
	end
	
	if not slotB and slotA then
		return true
	elseif not slotA and slotB then
		return false
	elseif not slotA and not slotB then
		return itemA.Name < itemB.Name
	end
	local indexA = GetKey( { "Temporary", "Renewable", "Tradeoff", "Essence", "Keepsake", "Robe", "Icarus" }, slotA )
	local indexB = GetKey( { "Temporary", "Renewable", "Tradeoff", "Essence", "Keepsake", "Robe", "Icarus" }, slotB )
	if indexA and not indexB then
		return false
	end
	if indexB and not indexA then
		return true
	end
	if indexA ~= indexB then
		return indexA < indexB
	end

	return itemA.Name < itemB.Name
end

function OnHealthBufferDamage( hero, damageTaken )
	local sourceTraits = {}
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.CostumeTrait and (traitData.CurrentArmor or 0) > 0 and MapState.HealthBufferSources[traitData.Name] then
			table.insert(sourceTraits, traitData)
		end
	end
	if IsEmpty ( sourceTraits ) then
		return
	end
	table.sort( sourceTraits, HealthBufferTraitSort )
	local armorBroken = false
	local topSourceTrait = sourceTraits[1]
	local removedTraits = {}
	while not IsEmpty(sourceTraits) and damageTaken > 0 do
		topSourceTrait = sourceTraits[1]
		if topSourceTrait.CurrentArmor > damageTaken then
			topSourceTrait.CurrentArmor = topSourceTrait.CurrentArmor - damageTaken
			damageTaken = 0
		else
			damageTaken = damageTaken - topSourceTrait.CurrentArmor
			topSourceTrait.CurrentArmor = 0
		end
		if MapState.HealthBufferSources[ topSourceTrait.Name ] then
			MapState.HealthBufferSources[ topSourceTrait.Name ] = topSourceTrait.CurrentArmor
		end
		if topSourceTrait.CurrentArmor <= 0 then
			RemoveValueAndCollapse( sourceTraits, topSourceTrait )
			armorBroken = true
			if not topSourceTrait.Invincible and not HeroHasTrait("InvulnerableArmor") then
				table.insert( removedTraits, topSourceTrait )
			else
				topSourceTrait.CurrentArmor = 0
				if MapState.HealthBufferSources[ topSourceTrait.Name ] then
					MapState.HealthBufferSources[ topSourceTrait.Name ] = 0
				end
			end
		end
	end
	for _, traitData in pairs( removedTraits ) do
		RemoveTraitData( CurrentRun.Hero, traitData )
	end
	if armorBroken and CurrentRun.Hero.HealthBuffer == 0 then
		
		if IsEmpty(SessionMapState.TempArmorPresentation) then
			StopAnimation({ Name = HeroData.TempArmorVfx, DestinationId = CurrentRun.Hero.ObjectId })
		end
		for i, functionData in pairs( GetHeroTraitValues("OnArmorBreakFunction") ) do
			CallFunctionName( functionData.Name, functionData.Args)
		end
		if topSourceTrait then
			CurrentRun.Hero.LastBrokenArmorTraitName = topSourceTrait.Name
		end
		thread( PlayerArmorBreakPresentation )
	end
end

function CostumeArmor( hero, args, roomArgs )
	roomArgs = roomArgs or {}
	local sourceTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.CostumeTrait and traitData.SetupFunction and traitData.SetupFunction.Args and traitData.SetupFunction.Args.Source == args.Source then
			sourceTrait = traitData
			break
		end
		if traitData.CostumeTrait and traitData.SetupFunctions then
			for i, setupFunctionData in pairs( traitData.SetupFunctions ) do
				if setupFunctionData.Name == "CostumeArmor" and setupFunctionData.Args and setupFunctionData.Args.Source == args.Source then
					sourceTrait = traitData
					break
				end
			end
		end
		
	end
	if not sourceTrait then
		return
	end
	if not sourceTrait.CurrentArmor then
		sourceTrait.CurrentArmor = args.BaseAmount
	end
	AddHealthBuffer( sourceTrait.CurrentArmor, sourceTrait.Name, { Silent = roomArgs.Grouped or args.Silent, Delay = args.Delay  })
	FrameState.RequestUpdateHealthUI = true
end