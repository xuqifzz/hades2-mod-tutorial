function SetupCostume( skipCostume )
	for itemName, item in pairs( CostumeData ) do
		if GameState.WorldUpgrades[itemName] then
			if item.GrannyModel ~= nil then
				--SetThingProperty({ Property = "GrannyModel", Value = item.GrannyModel, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if item.GrannyTexture ~= nil then
				SetThingProperty({ Property = "GrannyTexture", Value = item.GrannyTexture, DestinationId = CurrentRun.Hero.ObjectId })
			end 
			if item.ActiveGrannyAttachment ~= nil then
				SetThingProperty({ Property = "ActiveGrannyAttachment", Value = item.ActiveGrannyAttachment, DestinationId = CurrentRun.Hero.ObjectId })
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
	for i, trait in pairs(currentRun.Hero.Traits) do
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
	CurrentRun.Hero.HealthBuffer = totalHealthBuffer
	thread(OnPlayerArmorGain, {Amount = amount, Silent = args.Silent, Delay = args.Delay} )
end

function HealthBufferTraitSort( itemA, itemB )
	local slotA = nil
	local slotB = nil
	if itemA.SetupFunction then
		slotA = itemA.SetupFunction.Args.Source
	elseif itemA.SetupFunctions then
		for i, setupFunction in pairs(itemA.SetupFunctions) do
			if setupFunction.Name == "CostumeArmor" or setupFunction.Name == "HephaestusArmor" then
				slotA = setupFunction.Args.Source
			end
		end
	end
	if itemB.SetupFunction then
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
	local indexA = GetKey( { "Renewable", "Tradeoff", "Essence", "Keepsake", "Robe" }, slotA )
	local indexB = GetKey( { "Renewable", "Tradeoff", "Essence", "Keepsake", "Robe" }, slotB )

	if indexA ~= indexB then
		return indexA < indexB
	end

	return itemA.Name < itemB.Name
end

function OnHealthBufferDamage( hero, damageTaken )
	local sourceTraits = {}
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.CostumeTrait and (traitData.CurrentArmor or 0) > 0 then
			table.insert(sourceTraits, traitData)
		end
	end
	if IsEmpty ( sourceTraits ) then
		return
	end
	table.sort( sourceTraits, HealthBufferTraitSort )
	local armorBroken = false
	while not IsEmpty(sourceTraits) and damageTaken > 0 do
		local topSourceTrait = sourceTraits[1]
		topSourceTrait.CurrentArmor = topSourceTrait.CurrentArmor - damageTaken
		if MapState.HealthBufferSources[ topSourceTrait.Name ] then
			MapState.HealthBufferSources[ topSourceTrait.Name ] = topSourceTrait.CurrentArmor
		end
		if topSourceTrait.CurrentArmor <= 0 then
			RemoveValueAndCollapse( sourceTraits, topSourceTrait )
			damageTaken = math.abs(topSourceTrait.CurrentArmor)
			armorBroken = true
			if not topSourceTrait.Invincible and not HeroHasTrait("InvulnerableArmor") then
				RemoveTraitData( CurrentRun.Hero, topSourceTrait)
			else
				topSourceTrait.CurrentArmor = 0
				if MapState.HealthBufferSources[ topSourceTrait.Name ] then
					MapState.HealthBufferSources[ topSourceTrait.Name ] = 0
				end
			end
		else
			damageTaken = 0
		end
	end

	if armorBroken and CurrentRun.Hero.HealthBuffer == 0 then
		for i, functionData in pairs( GetHeroTraitValues("OnArmorBreakFunction") ) do
			CallFunctionName( functionData.Name, functionData.Args)
		end
		thread( PlayerArmorBreakPresentation )
	end
end

function CostumeArmor( hero, args, roomArgs )
	roomArgs = roomArgs or {}
	local sourceTrait = nil
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
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
	AddHealthBuffer( sourceTrait.CurrentArmor, sourceTrait.Name, { Silent = roomArgs.Grouped, Delay = args.Delay  })
	thread( UpdateHealthUI )
end