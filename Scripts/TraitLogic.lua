
function RunTraitThreads(source)
	for index, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.DumbFireWeapons ~= nil then
			thread(DumbFireWeapon, source, trait.Name, trait.DumbFireWeapons)
		end
	end
end

function DumbFireWeapon(source, traitName, args)
	while UseTrait( CurrentRun.Hero, traitName ) do
		local randomStrikePointId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = RandomFloat(-1 * args.Radius, args.Radius), OffsetY = RandomFloat(-1 * args.Radius, args.Radius )})
		FireWeaponFromUnit({ Weapon = args.Weapon,  AutoEquip = true, Id = source.ObjectId, DestinationId = randomStrikePointId, })
		Destroy({Id = randomSTrikePointId})
		wait(RandomFloat(args.IntervalMin, args.IntervalMax))
	end
end

function IncrementHitByShield( victim )
	if not victim.SkipModifiers and victim ~= CurrentRun.Hero then
		IncrementTableValue( CurrentRun.CurrentRoom, "ShieldThrowHits")
	end
end

function CheckChillKill( args, attacker, victim, triggerArgs )
	if SessionMapState.FiredChillKill[victim.ObjectId] then
		return
	end
	if triggerArgs.SourceProjectile ~= args.ProjectileName and attacker == CurrentRun.Hero and HasEffectWithEffectGroup( victim, "Root" ) and victim.RootActive
		and not victim.IsDead and not victim.CannotDieFromDamage and victim.Health / victim.MaxHealth <= args.ChillDeathThreshold 
		and ( victim.Phases == nil or victim.CurrentPhase == victim.Phases ) then

		SessionMapState.FiredChillKill[victim.ObjectId] = true
		PlaySound({ Name = "/SFX/DemeterEnemyFreezeShatter", Id = victim.ObjectId })
		CreateAnimation({ Name = "DemeterBossIceShatter", DestinationId = victim.ObjectId })
		CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = args.DamageMultiplier, FireFromTarget = true})
		
		if victim.IsBoss then
	      BossChillKillPresentation( victim )
		end
		if victim.DeathAnimation ~= nil and not victim.ManualDeathAnimation then
			SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
			-- @todo Notify on death animation finish
		end
		thread( Kill, victim, { ImpactAngle = 0, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId })
	end
end

function GetProcessedTraitData( args )
	local traitData = ProcessTraitData( args )
	ReplaceDerivedValues(traitData)
	return traitData
end

function ReplaceDerivedValues(traitData)
	if traitData == nil then
		return
	end
	local changes = {}
	if traitData.PropertyChanges ~= nil then
		table.insert( changes, "PropertyChanges" )
	end
	if traitData.EnemyPropertyChanges ~= nil then
		table.insert( changes, "EnemyPropertyChanges" )
	end
	if traitData.ActivatedPropertyChanges ~= nil then
		table.insert( changes, "ActivatedPropertyChanges" )
	end

	for i, changeKey in pairs(changes) do
		for s, propertyChange in pairs(traitData[changeKey]) do
			if propertyChange.DeriveValueFrom ~= nil then
				local referencedPropertyValue = nil
				if not referencedPropertyValue then
					for w, otherChangeKey in pairs ( changes ) do
						for t, otherPropertyChange in pairs(traitData[otherChangeKey]) do
							if referencedPropertyValue == nil then
								for key, value in pairs(otherPropertyChange) do
									if value == propertyChange.DeriveValueFrom then
										referencedPropertyValue = otherPropertyChange
									end
								end
							end
						end
					end
				end
				assert(referencedPropertyValue ~= nil, "UseValue " .. propertyChange.DeriveValueFrom .. " not found on trait " .. traitData.Name )
				propertyChange.ChangeValue = referencedPropertyValue.ChangeValue
				if propertyChange.ChangeType == nil then
					propertyChange.ChangeType = referencedPropertyValue.ChangeType
				end
				if propertyChange.ExcludeLinked == nil then
					propertyChange.ExcludeLinked = referencedPropertyValue.ExcludeLinked
				end
			end
		end
	end
	
	for key, value in pairs(traitData) do
		if type(value) == "table" and value.ReplaceWithKeyValue ~= nil then
			traitData[key] = traitData[value.ReplaceWithKeyValue]
		end
	end

	if traitData.SignOffData then
		for i, data in ipairs( traitData.SignOffData ) do
			if IsGameStateEligible( CurrentRun, data ) then
				traitData.SignoffText = data.Text
			end
		end
	end

	return traitData
end

function ProcessTraitData( args )
	if args == nil then
		return
	elseif ( args.TraitName == nil and args.TraitData == nil ) or args.Unit == nil then
		return
	end
	local traitName = args.TraitName
	local unit = args.Unit
	local rarity = args.Rarity
	local traitData = args.TraitData or DeepCopyTable(TraitData[traitName])
	DebugAssert({ Condition = traitData ~= nil, Text = "Unable to find trait data for: " .. tostring(traitName), Owner = "Alice" })

	local stackNum = traitData.StackNum or args.StackNum
	traitData.StackNum = stackNum
	if traitName == nil then
		traitName = args.TraitData.Name
	end
	traitData.Title = traitData.Name

	local rarityMultiplier = traitData.RarityMultiplier or args.RarityMultiplier or 1
	if rarity ~= nil and traitData.RarityLevels ~= nil and traitData.RarityLevels[rarity] ~= nil and traitData.RarityMultiplier == nil then
		local rarityData = traitData.RarityLevels[rarity]
		if rarityData.Multiplier ~= nil then
			rarityMultiplier = rarityData.Multiplier
		else
			rarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
		end
		traitData.Rarity = rarity
		traitData.RarityMultiplier = rarityMultiplier
	end

	if args.CustomMultiplier then
		rarityMultiplier = rarityMultiplier * args.CustomMultiplier
	end
	-- NOTE(Dexter) GetProcessedValue makes calls to the RNG. For determinism, we must iterate in sorted order.
	local traitDataKVPs = CollapseTableAsOrderedKeyValuePairs(traitData)
	for i, kvp in ipairs( traitDataKVPs ) do
		local key = kvp.Key
		local value = kvp.Value
		if key ~= "PropertyChanges" and key ~= "EnemyPropertyChanges" and key~= "ActivatedPropertyChanges"and key ~= "WeaponDataOverride" then
			local propertyRarityMultiplier = rarityMultiplier or 1
			if traitData[key] and type(traitData[key]) == "table" and traitData[key].CustomRarityMultiplier then
				local rarityData = traitData[key].CustomRarityMultiplier[traitData.Rarity]
				if rarityData then
					if rarityData.Multiplier ~= nil then
						propertyRarityMultiplier = rarityData.Multiplier
					else
						propertyRarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
					end
				end
			end
			traitData[key] = GetProcessedValue(value, { RarityMultiplier = propertyRarityMultiplier, StackNum = stackNum })
		end
	end

	if not IsEmpty( unit.Traits ) and traitData.RemainingUses ~= nil then
		for i, data in pairs( GetHeroTraitValues( "TraitDurationIncrease", { Unit = unit })) do
			if data.ValidTraits == nil or Contains( data.ValidTraits, traitName ) then
				if traitData.RemainingUses ~= nil then
					traitData.RemainingUses = traitData.RemainingUses + data.Amount
				end
			end
		end
	end

	if traitData.PropertyChanges == nil and traitData.EnemyPropertyChanges == nil and traitData.ActivatedPropertyChanges == nil then
		return traitData
	end

	local changes = {}
	if traitData.PropertyChanges ~= nil then
		table.insert( changes, "PropertyChanges" )
	end
	if traitData.EnemyPropertyChanges ~= nil then
		table.insert( changes, "EnemyPropertyChanges" )
	end
	if traitData.ActivatedPropertyChanges ~= nil then
		table.insert( changes, "ActivatedPropertyChanges" )
	end

	for i, changeKey in ipairs(changes) do
		local sortedTraitDataAtChangeKey = CollapseTableOrdered(traitData[changeKey])
		for s, propertyChange in ipairs(sortedTraitDataAtChangeKey) do
			if propertyChange.BaseMin ~= nil or propertyChange.BaseValue ~= nil then
				local propertyRarityMultiplier = rarityMultiplier or 1
				if propertyChange.CustomRarityMultiplier then
					local rarityData = propertyChange.CustomRarityMultiplier[traitData.Rarity]
					if rarityData then
						if rarityData.Multiplier ~= nil then
							propertyRarityMultiplier = rarityData.Multiplier
						else
							propertyRarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
						end
					end
				end
				local newValue = GetProcessedValue(propertyChange, { Unit = unit, RarityMultiplier = propertyRarityMultiplier, StackNum = stackNum  })
				propertyChange.ChangeValue = newValue
			end
		end
	end
	return traitData
end

function GetProcessedValue( valueToRamp, args )
	args = args or {}
	local stackNum = args.StackNum or 0
	local rarityMultiplier = args.RarityMultiplier
	local unit = args.Unit

	if type( valueToRamp ) ~= "table" then
		return valueToRamp
	end

	rarityMultiplier = rarityMultiplier or 1
	
	if valueToRamp.MultipliedByElement then
		local elementTotal = 0
		if CurrentRun.Hero.Elements and CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement] then
			elementTotal = CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement]
		end
		rarityMultiplier = rarityMultiplier * elementTotal
	end

	if valueToRamp.IgnoreRarity then
		rarityMultiplier = 1
	end
	if valueToRamp.BaseMin ~= nil or valueToRamp.BaseValue ~= nil then

		local value = 0
		if valueToRamp.BaseValue ~= nil then
			value = valueToRamp.BaseValue
		else
			if args.ForceMin then
				value = valueToRamp.BaseMin
			elseif args.ForceMax then
				value = valueToRamp.BaseMax
			else
				value = RandomFloat( valueToRamp.BaseMin, valueToRamp.BaseMax )
			end
		end
		local baseValue = value

		if valueToRamp.SourceIsMultiplier then
			local delta = value - 1
			value = 1 + delta * rarityMultiplier
		elseif valueToRamp.SourceIsNegativeMultiplier then
			local delta = 1 - value * rarityMultiplier
			value = 1 + delta
		elseif valueToRamp.SourceIsDivisor then
			local delta = ( 1 - value ) / rarityMultiplier
			value = 1 - delta
		else
			value = value * rarityMultiplier
		end

		if stackNum and stackNum > 1 then
			value = 0
			if valueToRamp.SourceIsMultiplier or valueToRamp.SourceIsNegativeMultiplier or valueToRamp.SourceIsDivisor then
				value = 1
			end
			
			local fakeStackNum = stackNum - 1
			for i = 0, fakeStackNum do
				local totalMultiplier = 1
				if valueToRamp.IdenticalMultiplier then
					local diminishingMultiplier = valueToRamp.IdenticalMultiplier.DiminishingReturnsMultiplier or TraitMultiplierData.DefaultDiminishingReturnsMultiplier
					local totalDiminishingMultiplier = math.pow(diminishingMultiplier, i - 1 )
					minMultiplier = valueToRamp.MinMultiplier or TraitMultiplierData.DefaultMinMultiplier
					totalMultiplier = (1 + valueToRamp.IdenticalMultiplier.Value) * totalDiminishingMultiplier
					if totalMultiplier < minMultiplier then
						totalMultiplier = minMultiplier
					end
				end
				if valueToRamp.MultipliedByElement then
					local elementTotal = 0
					if CurrentRun.Hero.Elements and CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement] then
						elementTotal = CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement]
					end
					totalMultiplier = totalMultiplier * elementTotal
				end
				if i == 0 then
					if valueToRamp.SourceIsMultiplier then
						local delta = baseValue - 1
						value = 1 + delta * rarityMultiplier
					elseif valueToRamp.SourceIsNegativeMultiplier then
						local delta = 1 - baseValue * rarityMultiplier
						value = 1 + delta
					elseif valueToRamp.SourceIsDivisor then
						local delta = ( 1 - value ) / rarityMultiplier
						value = 1 - delta
					else
						value = baseValue * rarityMultiplier
					end
				else
					if valueToRamp.AbsoluteStackValues then
						baseValue = valueToRamp.AbsoluteStackValues[ i ] or valueToRamp.AbsoluteStackValues[ #valueToRamp.AbsoluteStackValues ]
						totalMultiplier = 1
					end
					if valueToRamp.SourceIsMultiplier then
						local delta = baseValue - 1
						local adjustedValue = delta * totalMultiplier
						value = value + adjustedValue
					elseif valueToRamp.SourceIsNegativeMultiplier then
						local delta = 1 - baseValue * totalMultiplier
						value = value + delta
					elseif valueToRamp.SourceIsDivisor then
						local delta = ( 1 - value ) / totalMultiplier
						value = value + delta
					else
						local adjustedValue = baseValue * totalMultiplier
						if valueToRamp.MinValue and adjustedValue < valueToRamp.MinValue then
							adjustedValue = valueToRamp.MinValue
						end
						value = value + adjustedValue
					end
				end
				value = ProcessValue( value, valueToRamp )
			end
		end

		if valueToRamp.MultipliedByHeroValue then
			value = value * GetTotalHeroTraitValue( valueToRamp.MultipliedByHeroValue, { IsMultiplier = true })
		end

		if valueToRamp.ReducedByMetaupgradeValue then
			local metaupgradeName = valueToRamp.ReducedByMetaupgradeValue
			value = value * ( 1 - GetNumMetaUpgrades(metaupgradeName) * ( MetaUpgradeData[metaupgradeName].ChangeValue - 1 ))
		end
		return ProcessValue( value, valueToRamp )
	else
		local traitDataKVPs = CollapseTableAsOrderedKeyValuePairs(valueToRamp)
		for i, kvp in ipairs( traitDataKVPs ) do
			local key = kvp.Key
			local value = kvp.Value
			if key ~= "ExtractValue" and key ~= "ExtractValues" then
				valueToRamp[key] = GetProcessedValue( value, args )
			end
		end
		return valueToRamp
	end
end

function ProcessValue( value, rampData )
	if rampData.AsInt then
		value = round(value)
	elseif rampData.ToNearest then
		value = math.floor( value / rampData.ToNearest ) * rampData.ToNearest
	end

	if rampData.DecimalPlaces then
		value = round(value, rampData.DecimalPlaces)
	else
		-- otherwise round to the nearest percent
		value = round(value, 2)
	end

	if rampData.MaximumValue then
		value = math.min(value, rampData.MaximumValue)
	end
	if rampData.MinimumSourceValue then
		value = math.max(value, rampData.MinimumSourceValue)
	end
	return value
end

function GetTotalHeroTraitValue(propertyName, args)
	args = args or {}
	local offset = 0
	local output = 0
	local hero = args.Hero or CurrentRun.Hero

	if args.IsMultiplier then
		offset = 1
		output = 1
	end

	for k, trait in pairs( hero.Traits ) do
		if trait[propertyName] ~= nil then
			if args.Multiplicative then
				output = output * trait[propertyName]
			else
				output = output + (trait[propertyName] - offset)
			end
		end
	end
	return output
end

function GetHeroTraitValues(propertyName, args)
	args = args or {}
	local hero = args.Unit or CurrentRun.Hero

	if CurrentRun.Hero.HeroTraitValuesCache and CurrentRun.Hero.HeroTraitValuesCache[propertyName] and not args.UnlimitedOnly then
		return CurrentRun.Hero.HeroTraitValuesCache[propertyName]
	end

	local output = {}
	for k, trait in pairs( hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil and ( not args.UnlimitedOnly or trait.RemainingUses == nil ) then
			table.insert(output, trait[propertyName])
		end
	end
	if not args.UnlimitedOnly then
		if not CurrentRun.Hero.HeroTraitValuesCache then
			CurrentRun.Hero.HeroTraitValuesCache = {}
		end
		CurrentRun.Hero.HeroTraitValuesCache[propertyName] = ShallowCopyTable( output )
	end
	return output
end

function HasHeroTraitValue( propertyName )
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil then
			return trait
		end
	end
	return nil
end

function UseHeroTraitsWithValue( propertyName, useFirst )
	local removedTraits = {}
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil then
			UseTraitData(CurrentRun.Hero, trait)
			UpdateTraitNumber( trait )
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
			end
			if useFirst and trait.RemainingUses then
				break
			end
		end
	end

	for _, trait in pairs( removedTraits ) do
		if trait.Slot == "Keepsake" then
			CurrentRun.ExpiredKeepsakes[trait.Name] = true
		else
			RemoveTraitData( CurrentRun.Hero, trait )
		end
		LogTraitUses( trait.Name )
	end
end

function AddTraitToHeroSource( source, args )
	args = args or {}
	wait( args.WaitTime or 0 )
	if args.PreAddFunctionName ~= nil then
		CallFunctionName( args.PreAddFunctionName, source, args )
	end
	wait( args.WaitTime or 0 )
	if args.AddTraitSound ~= nil then
		PlaySound({ Name = args.AddTraitSound, Id = CurrentRun.Hero.ObjectId })
	end
	AddTraitToHero( args )
end

function AddTraitToHero(args)
	local traitData = args.TraitData
	if traitData == nil then
		traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.TraitName, Rarity = args.Rarity, CustomMultiplier = args.CustomMultiplier, StackNum = args.StackNum })
	end

	GameState.LastPickedTraitName = traitData.Name

	if not args.PreProcessedForDisplay then
		ExtractValues(CurrentRun.Hero, traitData, traitData)
	end

	if traitData.Slot and CurrentRun.CurrentRoom then
		CurrentRun.CurrentRoom.AcquiredSlot = traitData.Slot
	end
	-- traits may have information that acts on weapons, so we must first equip all associated weapons to the player
	EquipReferencedWeapons( traitData )
	local newTrait = AddTraitData( CurrentRun.Hero, traitData, args )

	AddAssistWeapons( CurrentRun.Hero, traitData )
	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		AddOnDamageWeapons( CurrentRun.Hero, weaponName, traitData )
		AddOnFireWeapons( CurrentRun.Hero, weaponName, traitData )
		if traitData.UpgradeHeroWeapon ~= nil and Contains( traitData.UpgradeHeroWeapon.WeaponNames, weaponName ) then
			AddHeroWeaponUpgrade( weaponName, traitData.UpgradeHeroWeapon.UpgradeName )
		end
	end

	if traitData.EnemyPropertyChanges and not IsEmpty( ActiveEnemies ) then
		for enemyId, enemy in pairs( ActiveEnemies ) do
			ApplyEnemyTrait( CurrentRun, traitData, enemy )
		end
	end
	return newTrait
end

function GetHeroTrait( traitName )
	DebugAssert({ Condition = HeroHasTrait(traitName), Text = "Trait " .. tostring(traitName) .. " not found on call to GetHeroTrait.", Owner = "Alice" })

	if CurrentRun.Hero.TraitDictionary then
		if CurrentRun.Hero.TraitDictionary[traitName] ~= nil then
			return CurrentRun.Hero.TraitDictionary[traitName][1]
		end
	end

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Name == traitName then
			return CurrentRun.Hero.Traits[i]
		end
	end
end

function HeroHasTrait( traitName )
	if traitName == nil then
		return false
	end

	if CurrentRun.Hero.TraitDictionary then
		if CurrentRun.Hero.TraitDictionary[traitName] ~= nil then
			return true
		end
		return false
	end

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Name == traitName then
			return true
		end
	end
	return false
end

function HeroSlotFilled( slotName )
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == slotName then
			return true
		end
		if traitData.AltSlot and traitData.AltSlot == slotName then
			return true
		end
	end

	return false
end

function GetTotalTraitCount( unit )
	if unit.Traits == nil then
		return 0
	end
	local num = 0
	for k, currentTrait in pairs( unit.Traits ) do
		if not currentTrait.Hidden then
            num = num + 1
        end
	end
	return num
end

function GetTraitCount( unit, args )
	args = args or {}
	if args.TraitData then
		return args.TraitData.StackNum or 1
	end
	
	-- TODO : refactor this instead of making it fall through @alice
	DebugAssert({ Condition = ( unit == CurrentRun.Hero ), Text = "Cannot run GetTraitCount on non-hero units", Owner = "Alice" })

	local traitData = GetHeroTrait( args.Name )
	if not traitData then
		return 0
	end
	local stacks = traitData.StackNum or 1
	return stacks

end

function AreTraitsIdentical( traitA, traitB )
	if traitA == nil or traitB == nil then
		local traitAName = "nil"
		local traitBName = "nil"
		if traitA ~= nil then
			traitAName = tostring(traitA.Name)
		end
		if traitB ~= nil then
			traitBName = tostring(traitB.Name)
		end
		DebugAssert({ Condition = false, Text = "Comparing nil traits(s) " .. traitAName .. " and " .. traitBName, Owner = "Alice" })
		return false
	end

	if traitA.ForBoonInfo or traitB.ForBoonInfo then
		return false
	end
	if traitA == traitB then
		return true
	end

	if traitA.DoNotStackIcons or traitB.DoNotStackIcons then
		return traitB.Id == traitA.Id
	end
	if ( traitA.LastCurseName and traitB.LastCurseName ) or ( traitA.LastBlessingName and traitB.LastBlessingName ) then
		return traitB.Name == traitA.Name and traitB.Id == traitA.Id
	end

	if traitA.RemainingUses or traitB.RemainingUses then
		return traitB.Name == traitA.Name and traitB.Id == traitA.Id
	end
	return traitB.Name == traitA.Name
end

function GetTraitUniqueId()
	if CurrentRun then
		return TableLength(CurrentRun.Hero.Traits) .. GetRunDepth( CurrentRun ) .. tostring( _worldTime ) .. RandomFloat(0, 1)
	end
	return tostring(_worldTime)
end

function GetHeroUniqueGodCount( hero )
	if not hero then
		return 0
	end

	if hero.UniqueGodCount then
		return hero.UniqueGodCount
	end

	local godDictionary = {}
	for traitName in pairs( hero.TraitDictionary ) do
		if GetLootSourceName( traitName ) then
			godDictionary[GetLootSourceName( traitName )] = true
		end
	end
	
	hero.UniqueGodCount = TableLength( godDictionary )
	return hero.UniqueGodCount
end

function UpdateHeroTraitDictionary( )

	if IsEmpty(CurrentRun.Hero.Traits) then
		CurrentRun.Hero.TraitDictionary = {}
		CurrentRun.Hero.SlottedTraits = {}
		CurrentRun.Hero.HeroTraitValuesCache = {}
		CurrentRun.Hero.UniqueGodCount = 0
		CurrentRun.Hero.UpgradableTraitCount = 0
		CurrentRun.Hero.SacrificeTraitCount = 0
		CurrentRun.Hero.VisibleTraitCount = 0
		CurrentRun.Hero.EligiblePrevRunTraits = {}
		CurrentRun.Hero.Elements = {}
		for elementName in pairs(TraitElementData) do
			CurrentRun.Hero.Elements[elementName] = 0
		end
		CurrentRun.Hero.GodBoonRarities = {}
		for rarityName in pairs(TraitRarityData.RarityValues ) do
			CurrentRun.Hero.GodBoonRarities[rarityName] = 0
		end
		
		return
	end

	local cache = {}
	local slots = {}
	local heroTraitValuesCache = {}
	local godDictionary = {}
	local elements = {}
	local rarities = {}
	for elementName in pairs(TraitElementData) do
		elements[elementName] = 0
	end
	for rarityName in pairs(TraitRarityData.RarityValues ) do
		rarities[rarityName] = 0
	end

	local visibleTraitCount = 0
	local metaUpgradeTraitCount = 0
	local upgradeableCount = 0
	local sacrificeTraitCount = 0

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if cache[trait.Name] == nil then
			cache[trait.Name] = {}
		end
		if trait.Slot then
			slots[trait.Slot] = trait.Name
		end
		if trait.Rarity and IsGodTrait( trait.Name, { ForShop = true, ForLastRunBoon = true} ) and not trait.ExcludeFromRarityCount then
			IncrementTableValue( rarities, trait.Rarity )
		end
		if not IsEmpty(trait.Elements) then
			for i, elementName in pairs( trait.Elements ) do
				IncrementTableValue( elements, elementName )
			end
		end
		if trait.AddAllElements then
			for elementName in pairs( elements ) do
				IncrementTableValue( elements, elementName, trait.AddAllElements )
			end
		end
		if IsEmpty(cache[trait.Name]) 
			and IsGodTrait(trait.Name, { ForShop = true }) 
			and TraitData[trait.Name] 
			and trait.Rarity ~= nil 
			and not trait.BlockSacrifice
			and GetLootSourceName(trait.Name) ~= "HeraUpgrade"  then
			sacrificeTraitCount = sacrificeTraitCount + 1
		end
		table.insert( cache[trait.Name], trait )

		if CurrentRun.Hero.HeroTraitValuesCache then
			for key, value in pairs(trait) do
				if CurrentRun.Hero.HeroTraitValuesCache[key] then
					if not heroTraitValuesCache[key] then
						heroTraitValuesCache[key] = {}
					end
					table.insert(heroTraitValuesCache[key], value)
				end
			end
		end

		if not trait.Hidden then
			visibleTraitCount = visibleTraitCount + 1
		end
		
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not trait.BlockStacking and ( not trait.RequiredFalseTrait or trait.RequiredFalseTrait ~= trait.Name ) then
			upgradeableCount = upgradeableCount + 1
		end
		
		if GetLootSourceName( trait.Name ) then
			godDictionary[GetLootSourceName( trait.Name )] = true
		end
	end
	CurrentRun.Hero.HeroTraitValuesCache = heroTraitValuesCache
	CurrentRun.Hero.TraitDictionary = cache
	CurrentRun.Hero.VisibleTraitCount = visibleTraitCount
	CurrentRun.Hero.SacrificeTraitCount = sacrificeTraitCount
	CurrentRun.Hero.UniqueGodCount = TableLength( godDictionary )
	CurrentRun.Hero.UpgradableTraitCount = upgradeableCount
	CurrentRun.Hero.Elements = elements
	CurrentRun.Hero.GodBoonRarities = rarities
	CurrentRun.Hero.SlottedTraits = slots
	
	local prevRun = GameState.RunHistory[#GameState.RunHistory]
	local eligiblePrevRunTraits = {}
	
	if prevRun and prevRun.TraitRarityCache then
		for traitName, rarity in pairs( prevRun.TraitRarityCache or {} ) do
			local traitData = TraitData[traitName] 
			if not HeroHasTrait(traitName) and IsGodTrait( traitName, {ForShop = true } ) and IsTraitEligible( CurrentRun, traitData ) and ( not traitData.Slot or not HeroSlotFilled( traitData.Slot )) and not traitData.ExcludeTraitFromLastRunBoonPool then
				eligiblePrevRunTraits[traitName] = true
			end
		end
	end
	CurrentRun.Hero.EligiblePrevRunTraits = eligiblePrevRunTraits
end

function CheckActivatedTraits( unit, skipPresentation )
	if unit ~= CurrentRun.Hero then
		return
	end

	local activatedTraitNames = {}
	local deactivatedTraitNames = {}
	local upgradedTraitNames = {}
	local downgradedTraitNames = {}
	local scalingTraitIndexes = {}

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		local traitData = TraitData[trait.Name]
		if traitData ~= nil then
			if traitData.ActivationRequirements ~= nil and IsTraitActive(traitData) then
				local isEligible = IsGameStateEligible( CurrentRun, trait, traitData.ActivationRequirements )
				if isEligible and not trait.Activated then
					ProcessHeroTraitChanges( trait )
					if not trait.ActivatedPropertyChanges then
						trait.Activated = true
						unit.LastActivatedElementalTrait = trait.Name
					end
					if trait.OnActivationFunction then
						thread( CallFunctionName, trait.OnActivationFunction.Name, trait.OnActivationFunction.Args, trait )
					end
					table.insert( activatedTraitNames, trait.Name )
				elseif not isEligible and trait.Activated then
					ProcessHeroTraitChanges( trait, true )
					if not trait.ActivatedPropertyChanges then
						trait.Activated = false
					end
					table.insert( deactivatedTraitNames, trait.Name )
				end
			end
			if traitData.VisualActivationRequirements ~= nil then
				trait.Activated = trait.Activated or {}
				for i, requirements in pairs(traitData.VisualActivationRequirements) do
					local isEligible = IsGameStateEligible( CurrentRun, trait, requirements )
					if isEligible and not trait.Activated[i] then
						trait.Activated[i] = true
						table.insert( activatedTraitNames, trait.Name )
					elseif not isEligible and trait.Activated[i] then
						trait.Activated[i] = false
							DebugPrint({Text = " trait activated 2 "})
						table.insert( deactivatedTraitNames, trait.Name )
					end
				end
			end
		end
		if trait.ElementalMultipliers then
			local expectedMultiplier = 0
			for elementName in pairs(trait.ElementalMultipliers) do
				expectedMultiplier = expectedMultiplier + CurrentRun.Hero.Elements[elementName]
			end
			if expectedMultiplier ~= trait.ElementalMultiplier then
				local info = { Index = i, ExpectedMultiplier = expectedMultiplier }
				table.insert(scalingTraitIndexes, info)
			end
		end
		
	end
	for i, data in pairs( scalingTraitIndexes ) do
		local index = data.Index
		local expectedMultiplier = data.ExpectedMultiplier
		local trait = CurrentRun.Hero.Traits[index]
		local startingMultiplier = trait.ElementalMultiplier or 0
		local newtrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, StackNum = trait.StackNum, Rarity = trait.Rarity })
		RemoveTraitData(CurrentRun.Hero, trait, { SkipActivatedTraitUpdate = true })
		newtrait.ElementalMultiplier = expectedMultiplier
		newtrait.StackNum = trait.StackNum
		AddTraitData( CurrentRun.Hero, newtrait, { SkipActivatedTraitUpdate = true, SkipNewTraitHighlight = true})
		if expectedMultiplier > startingMultiplier then
			table.insert( upgradedTraitNames, trait.Name )
		elseif expectedMultiplier < startingMultiplier then
			table.insert( downgradedTraitNames, trait.Name )
		end
	end
	if not skipPresentation then
		thread( ElementalTraitUpdatedPresentation, activatedTraitNames, deactivatedTraitNames, upgradedTraitNames, downgradedTraitNames)
	end
end

function AddTrait( unit, traitName, rarity, args )
	local traitData = GetProcessedTraitData({ Unit = unit, TraitName = traitName, Rarity = rarity })
	if args and args.Id then
		traitData.Id = args.Id
	end
	ExtractValues( unit, traitData, traitData )
	return AddTraitData( unit, traitData, args )
end

function AddTraitData( unit, traitData, args )
	args = args or {}
	local isDuplicate = false
	local newTrait = DeepCopyTable( traitData )
	local traitName = newTrait.Name
	if unit.Traits == nil then
		unit.Traits = {}
	end
	if unit.TraitAnimationAnchors == nil then
		unit.TraitAnimationAnchors = {}
	end

	GameState.TraitsTaken[traitName] = true
	if not args.SkipQuestStatusCheck then
		thread( CheckQuestStatus )
		thread( CheckProgressAchievements )
	end

	if traitData.AddLastStand then
		AddLastStand( traitData.AddLastStand )
	end
	
	newTrait.Id = newTrait.Id or GetTraitUniqueId()
	newTrait.SourceName = args.SourceName

	table.insert( unit.Traits, newTrait )
	if args.FromLoot then
		if newTrait.HealOnAcquire then
			Heal( unit.Hero, { HealAmount = newTrait.HealOnAcquire, Name = traitName.."Acquire" } )
		end
		thread( CallFunctionName, newTrait.AcquireFunctionName, newTrait.AcquireFunctionArgs, newTrait )
	end
	if ActiveScreens.TraitTrayScreen ~= nil then
		TraitTrayScreenClose( ActiveScreens.TraitTrayScreen )
	end
	if unit == CurrentRun.Hero and not args.SkipUIUpdate then
		UpdateHeroTraitDictionary()
		local showingTrait = nil
		local rarityValue = 0
		for s, existingTrait in pairs( CurrentRun.Hero.Traits) do
			if (AreTraitsIdentical(existingTrait, newTrait) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
				showingTrait = existingTrait
				rarityValue = GetRarityValue( showingTrait.Rarity )
			end
		end
		if not newTrait.Hidden then
			MapState.PriorityTraitInfoHighlight = newTrait.Name
		end
		if showingTrait ~= nil and IsShownInHUD( showingTrait ) then
			TraitUIAdd( showingTrait, { Show = true } )
			local thresholdData = showingTrait.LowHealthThresholdText
			if thresholdData ~= nil then
				if thresholdData.Threshold and CurrentRun.Hero.Health <= thresholdData.Threshold then
					TraitUIActivateTrait( showingTrait )
				end
				if thresholdData.ThresholdFraction and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction then
					TraitUIActivateTrait( showingTrait )
				end
			end
			thresholdData = showingTrait.HighHealthThresholdText
			if thresholdData ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold then
				TraitUIActivateTrait( showingTrait )
			end
		end
		if traitData.StartingTime and not CurrentRun.Hero.IsDead then
			TraitUIActivateTrait( GetExistingUITrait(newTrait) , { CustomAnimation = "ActiveTraitCooldownNoFlash", PlaySpeed = 101 / traitData.StartingTime })
			if (IsBiomeTimerPaused() or HasTimerBlock( CurrentRun )) and newTrait.TraitActiveOverlay then
				SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 0, DestinationId = newTrait.TraitActiveOverlay, Instant = true })
			end
		end
		
		if not args.SkipNewTraitHighlight then
			thread( HUDTraitAddedPresentation, newTrait, args )
		end
	end
	AddOnHitWeapons( unit, newTrait )
	if newTrait.AddIncomingDamageModifiers then
		if unit.IncomingDamageModifiers == nil then
			unit.IncomingDamageModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddIncomingDamageModifiers )
		data.Name = newTrait.Name
		table.insert( unit.IncomingDamageModifiers, data )
	end

	if newTrait.AddOutgoingLifestealModifiers then	
		local data = DeepCopyTable( newTrait.AddOutgoingLifestealModifiers )
		data.Name = newTrait.Name
		AddOutgoingLifestealModifier( unit, data )
	end

	if newTrait.AddOutgoingDamageModifiers then
		if unit.OutgoingDamageModifiers == nil then
			unit.OutgoingDamageModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddOutgoingDamageModifiers )
		data.Name = newTrait.Name
		table.insert( unit.OutgoingDamageModifiers, data )
	end
	if newTrait.AddOutgoingCritModifiers then
		if unit.OutgoingCritModifiers == nil then
			unit.OutgoingCritModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddOutgoingCritModifiers )
		data.Name = newTrait.Name
		table.insert( unit.OutgoingCritModifiers, data )
	end

	if unit == CurrentRun.Hero then
		ProcessHeroTraitChanges( traitData )
		if not args.SkipActivatedTraitUpdate then
			CheckActivatedTraits( unit )
		end
		if traitData.MaxManaToMaxHealthConversion then
			local startingHealth = CurrentRun.Hero.MaxHealth
			ValidateMaxHealth()
			MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease" })
			UpdateHealthUI()
		end
		if traitData.ManaCostModifiers then
			UpdateWeaponMana()
		end
	else
		local isDuplicate = GetTraitCount( unit, newTrait ) > 1

		ApplyUnitPropertyChanges( unit, traitData.PropertyChanges, true )
		if GetTraitCount( unit, newTrait ) <= 1 and traitData.AnimationName ~= nil then
			unit.TraitAnimationAnchors[traitName] = SpawnObstacle({ Name = "BlankObstacle", Group = "Events", DestinationId = unit.ObjectId })
			Attach({ Id = unit.TraitAnimationAnchors[traitName], DestinationId = unit.ObjectId })
			SetAnimation({ Name = traitData.AnimationName, DestinationId = unit.TraitAnimationAnchors[traitName]})
		end

		if not isDuplicate then
			ApplyLinkedTraitPropertyChanges(unit, newTrait )
		end
	end
	
	MergeWeaponDataOverride( unit, traitData )
	

	if traitData.AddEffectMultiplier then
		if not unit.EffectMultipliers then
			unit.EffectMultipliers = {}
		end
		local effectMultiplierData = traitData.AddEffectMultiplier
		if effectMultiplierData.WeaponName then
			if unit.EffectMultipliers[effectMultiplierData.WeaponName] and unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName] then
				unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName].Multiplier = unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName].Multiplier + (effectMultiplierData.Multiplier - 1)
			else
				unit.EffectMultipliers[effectMultiplierData.WeaponName] =
				{
				[effectMultiplierData.EffectName] =
					{
					TraitName = effectMultiplierData.RequiredTraitName,
					Multiplier = effectMultiplierData.Multiplier
					}
				}
			end
		end
		if effectMultiplierData.WeaponNames then
			for i, weaponName in pairs(effectMultiplierData.WeaponNames) do
				if unit.EffectMultipliers[weaponName] and unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName] then
					unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName].Multiplier = unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName].Multiplier + (effectMultiplierData.Multiplier - 1)
				else
					unit.EffectMultipliers[weaponName] =
					{
					[effectMultiplierData.EffectName] =
						{
						TraitName = effectMultiplierData.RequiredTraitName,
						Multiplier = effectMultiplierData.Multiplier
						}
					}
				end
			end
		end
	end
	
	if not args.SkipSetup then

		local traitSetupFunctions = newTrait.SetupFunctions or {}
		if newTrait.SetupFunction then
			table.insert( traitSetupFunctions, newTrait.SetupFunction )
		end
		for i, setupFunctionData in pairs( traitSetupFunctions ) do
			if setupFunctionData.RequiredContext == args.Context then
				if ( not setupFunctionData.RunOnce or not isDuplicate ) and not setupFunctionData.SkipSetupOnAdd then
					if setupFunctionData.Threaded then
						thread( CallFunctionName, setupFunctionData.Name, unit, setupFunctionData.Args )
					else
						CallFunctionName( setupFunctionData.Name, unit, setupFunctionData.Args )
					end
				end
			end
		end
	end

	if (traitData.Duration ~= nil) then
		thread(RemoveTraitAfterDuration, unit, traitName, traitData.Duration)
	end

	return newTrait
end

function MergeWeaponDataOverride( unit, traitData )

	if not traitData.WeaponDataOverride then
		return
	end
	
	if not unit.WeaponDataOverride then
		unit.WeaponDataOverride = {}
	end
	for weaponName, weaponData in pairs( traitData.WeaponDataOverride ) do
		if unit.WeaponDataOverride[weaponName] then
			unit.WeaponDataOverride[weaponName] = DeepMergeTables( unit.WeaponDataOverride[weaponName], weaponData )
		else
			unit.WeaponDataOverride[weaponName] = DeepMergeTables( WeaponData[weaponName], weaponData )
		end
		if weaponData.OnFiredFunctionArgs then
			if weaponData.OnFiredFunctionArgs.SequencedAnimations then
				unit.WeaponDataOverride[weaponName].OnFiredFunctionArgs.SequencedAnimations  = ShallowCopyTable( weaponData.OnFiredFunctionArgs.SequencedAnimations )
			end
			if weaponData.OnFiredFunctionArgs.StartingAnimation then
				for propertyName, propertyValue in pairs( weaponData.OnFiredFunctionArgs.StartingAnimation ) do
					SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
				end
			end
		end
		if not IsEmpty(weaponData.Sounds) then
			for key, data in pairs(weaponData.Sounds) do
				unit.WeaponDataOverride[weaponName].Sounds = unit.WeaponDataOverride[weaponName].Sounds or {}
				unit.WeaponDataOverride[weaponName].Sounds[key] = weaponData.Sounds[key]
			end
		end
	end
end

function RemoveTraitAfterDuration(unit, traitName, duration)
	wait(duration)
	RemoveTrait(unit, traitName)
end

function RemoveWeaponTrait( traitName, args )
	args = args or {}
	if not args.Silent then
		thread(TraitSacrificedPresentation, GetExistingUITraitName( traitName ))
	end
	while HeroHasTrait( traitName ) do
		RemoveTrait( CurrentRun.Hero, traitName )
	end
end

function RemoveTrait( unit, traitName, args )
	for k, trait in pairs( unit.Traits ) do
		if trait.Name == traitName then
			RemoveTraitData( unit, trait, args )
			return
		end
	end
end

function RemoveTraitData( unit, trait, args )
	args = args or {}
	local traitName = trait.Name
	CurrentRun.Hero.LastRemovedTraitName = traitName
	RemoveValueAndCollapse( unit.Traits, trait )
	if unit == CurrentRun.Hero then
		ProcessHeroTraitChanges( trait, true )
	else
		ApplyUnitPropertyChanges( unit, trait.PropertyChanges, true, true )
	end
	if GetTraitCount( unit, trait ) <= 0 then
		Destroy({ Id = unit.TraitAnimationAnchors[traitName]})
	end
	if unit == CurrentRun.Hero and not args.SkipUIUpdate then
		UpdateHeroTraitDictionary()
		TraitUIRemove( trait )
	end
	
	if unit == CurrentRun.Hero and not args.SkipActivatedTraitUpdate then
		CheckActivatedTraits( unit )
	end
	if trait.AddOutgoingLifestealModifiers and unit.OutgoingLifestealModifiers then	
		for modifierIndex, modifier in pairs(unit.OutgoingLifestealModifiers) do
			if modifier.Name == trait.Name then
				unit.OutgoingLifestealModifiers[modifierIndex] = nil
				break
			end
		end
	end

	if trait.AddIncomingDamageModifiers and unit.IncomingDamageModifiers ~= nil then
		RemoveIncomingDamageModifier( unit, trait.Name )
	end
	if trait.AddOutgoingDamageModifiers then
		for modifierIndex, modifier in pairs(unit.OutgoingDamageModifiers) do
			if modifier.Name == trait.Name then
				unit.OutgoingDamageModifiers[modifierIndex] = nil
				break
			end
		end
	end
	if trait.AddOutgoingCritModifiers then
		for modifierIndex, modifier in pairs(unit.OutgoingCritModifiers) do
			if modifier.Name == trait.Name then
				unit.OutgoingCritModifiers[modifierIndex] = nil
				break
			end
		end
	end
	if trait.AccumulatedDodgeBonus then
		SetLifeProperty({ Property = "DodgeChance", Value = -1 * trait.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		SetUnitProperty({ Property = "Speed", Value = 1/( 1 + trait.AccumulatedDodgeBonus ), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	end
	RemoveAssistWeapons( unit, trait )
	RemoveOnHitWeapons( unit, trait )
	RemoveOnFireWeapons( unit, trait )
	for weaponName, v in pairs( unit.Weapons ) do
		RemoveOnDamageWeapons(unit, weaponName, trait )
	end
	if trait.WeaponDataOverride then
		if unit.WeaponDataOverride then
			for key, data in pairs(trait.WeaponDataOverride) do
				unit.WeaponDataOverride[key] = nil
			end

			-- reapply any other weapon data overrides
			for i, traitData in pairs( unit.Traits ) do
				MergeWeaponDataOverride( unit, traitData )
			end
		end
	end
	if trait.ReplaceMeleeWeapon then
		for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
			if unit.Weapons[weaponName] then
				AddWeaponControl({ DestinationId = unit.ObjectId, Name = weaponName })
			end
		end
	end
	if trait.OnExpire ~= nil  and not args.SkipExpire then
		local expiringActions = trait.OnExpire
		if expiringActions.Traits then
			for i, onExpireTraitName in pairs(expiringActions.Traits) do
				AddTrait(unit, onExpireTraitName, nil, { Id = trait.Id })
			end
		end
		if expiringActions.TraitData then
			thread( HeroTraitTransformPresentation, trait )
			expiringActions.TraitData.CustomTitle = trait.TraitTitle
			expiringActions.TraitData.Id = trait.Id
			AddTraitData( unit, expiringActions.TraitData )
		end
		if expiringActions.AddMetaUpgrades then
			EquipMetaUpgrades( CurrentRun.Hero, {} )
		end
		if expiringActions.SpawnShopItem then
			thread( HeroShopDeliveryPresentation, trait )
			local lootSpacing = 180
			local extantRewardCount = 0
			local targetId = CurrentRun.Hero.ObjectId 
			if not IsEmpty(MapState.RoomRequiredObjects) then
				extantRewardCount = TableLength( MapState.RoomRequiredObjects )
				targetId = GetFirstKey( MapState.RoomRequiredObjects )
			end
			if MapState.SurfaceShopItems then
				extantRewardCount = extantRewardCount + TableLength( MapState.SurfaceShopItems )
			end
			local enemyId = GetClosest({ Id = targetId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = 100 })
			if enemyId ~= 0 then
				extantRewardCount = extantRewardCount + 1
			end
			-- IsLocationBlocked won't update to locate other rewards spawned this step so using "ForceToValidLocation" will not work - @alice
			local steps = extantRewardCount
			local stepsLimit = steps + 8
			local stepAngleIncrement = 45
			local stepRadiusIncrement = 75
			local offset = CalcOffset( math.rad( steps * stepAngleIncrement ), steps * stepRadiusIncrement )
			local consumableId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y })
			while IsLocationBlocked({ Id = consumableId }) and steps < stepsLimit do
				steps = steps + 1
				local offset = CalcOffset( math.rad( steps * stepAngleIncrement ), steps * stepRadiusIncrement )
				Teleport({ Id = consumableId, DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y })		
			end
			local rewardItem = SpawnStoreItemInWorld( expiringActions.SpawnShopItem, consumableId )
			if rewardItem then
				MapState.RoomRequiredObjects[rewardItem.ObjectId] = rewardItem
			end
			thread( SurfaceShopItemPresentation, consumableId )
			thread( DestroyOnDelay, { consumableId }, 0.05 )
		end
		if expiringActions.FunctionName then
			thread( CallFunctionName, expiringActions.FunctionName, expiringActions.FunctionArgs)
		end

		-- Act on properties after properties have changed
		if expiringActions.HealAmount ~= nil then
			Heal( unit, { HealAmount = expiringActions.HealAmount, Name = traitName.."Expire" } )
			thread( UpdateHealthUI )
		end
		if expiringActions.HealFraction ~= nil then
			Heal( unit, { HealFraction = expiringActions.HealFraction, Name = traitName.."Expire" } )
			thread( UpdateHealthUI )
		end
	end
end

function UseTrait( unit, traitName )
	local removedTraits = {}
	for k, trait in pairs( unit.Traits ) do
		if trait.Name == traitName then	
			UseTraitData( unit, trait )
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
			end
		end
	end
	for _, trait in pairs( removedTraits ) do
		RemoveTraitData( unit, trait )
	end
	if not IsEmpty(removedTraits) then
		return removedTraits[1]
	end
	return nil
end

function UseTraitData( unit, trait )
	if trait.AffectChance ~= nil and RandomChance( trait.AffectChance ) then
		return trait
	elseif trait.RemainingUses ~= nil then
		trait.RemainingUses = trait.RemainingUses - 1
		return trait
	elseif trait.CurrentCooldown ~= nil then
		PutTraitOnCooldown(trait)
		return trait
	end
	return nil
end

function ReduceTraitUses( trait, args )
	args = args or {}
	if trait.Uses then
		trait.Uses = trait.Uses - 1
		LogTraitUses( trait.Name )
	elseif trait.Slot == "Keepsake" and args.Force or (( trait.Uses <= 0 or trait.RemainingUses < 0) and not trait.DoesNotAutomaticallyExpire ) then
		CurrentRun.ExpiredKeepsakes[trait.Name] = true
		LogTraitUses( trait.Name )
	end
	UpdateTraitNumber( trait )	
end

function LogTraitUses( traitName )

	IncrementTableValue(CurrentRun.TraitUses, traitName )
	IncrementTableValue(GameState.TraitUses, traitName )
	if CurrentRun.CurrentRoom.TraitUses then
		IncrementTableValue(CurrentRun.CurrentRoom.TraitUses, traitName)
	end
end

function PutTraitOnCooldown( traitData )
	DebugAssert({ Condition = traitData.CurrentCooldown ~= nil and (traitData.TimeCooldown ~= nil or traitData.RoomCooldown ~= nil), Text = "Putting on cooldown a trait (" .. traitData.Name ..") that has no cooldown data!", Owner = "Alice" })
	traitData.CurrentCooldown = 0
	TraitUIUpdateText(traitData)
	if traitData.TimeCooldown then
		thread(WaitAndReactivate, traitData )
	end
end

function WaitAndReactivate( traitData )
	wait( traitData.TimeCooldown, RoomThreadName )
	IncrementTraitCooldown( traitData, traitData.TimeCooldown)
end

function IsTraitActive( traitData )

	if traitData.Uses ~= nil and traitData.Uses <= 0 then
		return false
	end

	if traitData.CurrentCooldown == nil or ( traitData.RoomCooldown == nil and traitData.TimeCooldown == nil ) then
		return true
	end

	if traitData.RoomCooldown ~= nil then
		return traitData.CurrentCooldown >= traitData.RoomCooldown
	end

	if traitData.TimeCooldown ~= nil then
		return traitData.CurrentCooldown >= traitData.TimeCooldown
	end
	return true
end

function IncrementTraitCooldown( traitData, increment )
	increment = increment or 1
	if traitData.CurrentCooldown == nil or ( traitData.RoomCooldown == nil and traitData.TimeCooldown == nil ) then
		return
	end

	if traitData.RoomCooldown ~= nil then
		local wasActive = traitData.CurrentCooldown == traitData.RoomCooldown
		traitData.CurrentCooldown = math.min(traitData.CurrentCooldown + increment, traitData.RoomCooldown)
		local nowActive = traitData.CurrentCooldown == traitData.RoomCooldown

		if nowActive and not wasActive and traitData.ReactivateFunction ~= nil then
			_G[traitData.ReactivateFunction]()
			TraitUIUpdateText(traitData)
		end
	else
		local wasActive = traitData.CurrentCooldown == traitData.TimeCooldown
		traitData.CurrentCooldown = math.min(traitData.CurrentCooldown + increment, traitData.TimeCooldown)
		local nowActive = traitData.CurrentCooldown == traitData.TimeCooldown

		if nowActive and not wasActive and traitData.ReactivateFunction ~= nil then
			_G[traitData.ReactivateFunction]()
			TraitUIUpdateText(traitData)
		end
	end
end

function ApplyLinkedTraitPropertyChanges(unit, newTraitData )
	if not Contains( unit.Traits, newTraitData ) then
		DebugPrint({Text = "Warning! ApplyLinkedTraitPropertyChanges only works for traits have already been applied!"})
	end

	for i, traitData in pairs( unit.Traits ) do
		if traitData ~= newTraitData and traitData.PropertyChanges ~= nil then
			for s, propertyChange in pairs(traitData.PropertyChanges) do
				if propertyChange.TraitName == newTraitData.Name then
					ApplyUnitPropertyChange( unit, propertyChange, true )
				end
			end
		end
	end
end
function EquipReferencedWeapons( traitData )
	local weaponKeys = {"PreEquipWeapons", "AddOnHitWeapons", "AddOnDamageWeapons", "AddOnFireWeapons", "AmmoDropWeapons", "OnSuperWeapons", "OnProjectileReflectWeapons" }
	for i, weaponKey in pairs(weaponKeys) do
		if traitData[weaponKey] ~= nil then
			for i, weaponName in pairs(traitData[weaponKey]) do
				EquipWeapon({ Name = weaponName, DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages[weaponName] })
			end
		end
	end

	if traitData.AddAssist and traitData.AddAssist.WeaponName then
		local weaponName = traitData.AddAssist.WeaponName
		EquipWeapon({ Name = weaponName, DestinationId = CurrentRun.Hero.ObjectId })
	end

	local weaponTableKeys = { "AddOnEnemySpawnWeapon", "AddOnEffectWeapons", "OnEnemyDeathWeapon", "OnImpactWeapons" }
	for i, weaponTableKey in pairs(weaponTableKeys) do
		if traitData[weaponTableKey] ~= nil then
			EquipWeapon({ Name = traitData[weaponTableKey].Weapon, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

function ApplyTraitSetupFunctions( unit, args )
	args = args or { Grouped = true }
	local appliedFunctionNames = {}
	for i, trait in pairs( unit.Traits ) do
		local traitSetupFunctions = trait.SetupFunctions or {}
		if trait.SetupFunction then
			table.insert( traitSetupFunctions, trait.SetupFunction )
		end
		if trait.Slot == "Spell" and trait.CheckChargeFunctionName then
			table.insert( traitSetupFunctions, {Name = trait.CheckChargeFunctionName})
		end
		for i, setupFunctionData in pairs( traitSetupFunctions ) do
			if setupFunctionData.RequiredContext == args.Context then
				if not setupFunctionData.RunOnce or appliedFunctionNames[setupFunctionData.Name] == nil then
					if setupFunctionData.Threaded then
						thread( CallFunctionName, setupFunctionData.Name, unit, setupFunctionData.Args, args )
					else
						CallFunctionName( setupFunctionData.Name, unit, setupFunctionData.Args, args )
					end
					if setupFunctionData.RunOnce then
						appliedFunctionNames[setupFunctionData.Name] = true
					end
				end
			end
		end 
	end
end

function IsGodTrait( traitName, args )
	args = args or {}
	for i, god in pairs(LootData) do
		if ( god.GodLoot or ( args.ForShop and god.TreatAsGodLootByShops )) and ( not args.ForLastRunBoon or not god.ExcludeFromLastRunBoon) and not god.DebugOnly and god.TraitIndex[traitName] then
			return true
		end
	end
	for i, god in pairs(FieldLootData) do
		if god.TraitIndex[traitName] and ( god.GodLoot or ( args.ForShop and god.TreatAsGodLootByShops )) and ( not args.ForLastRunBoon or not god.ExcludeFromLastRunBoon) then
			return true
		end
	end
	return false
end

function GetLootSourceName( traitName )
	for lootName, god in pairs(LootData) do
		if ( god.GodLoot or god.TreatAsGodLootByShops ) and not god.DebugOnly and god.TraitIndex[traitName] then
			return lootName
		end
	end
	if TraitData[traitName] and TraitData[traitName].LootSource then
		return TraitData[traitName].LootSource
	end
	return nil
end

function UpgradableGodTraitCountAtLeast( num )
	local count = 0
	local traitNames = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not traitNames[trait.Name] and not trait.BlockInRunRarify and trait.Rarity ~= nil and GetUpgradedRarity(trait.Rarity) ~= nil and trait.RarityLevels[GetUpgradedRarity(trait.Rarity)] ~= nil then
			traitNames[ trait.Name ] = true
			count = count + 1
			if count >= num then
				return true
			end
		end
	end
	return false
end

function GetAllUpgradeableGodTraits( stackNum )
	stackNum = stackNum or 1
	local traitNames = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not trait.BlockStacking then
			local startingStackNum = trait.StackNum or 1
			local upgradedTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, Rarity = trait.Rarity, StackNum = startingStackNum + stackNum })
			ExtractValues( CurrentRun.Hero, upgradedTrait, upgradedTrait )
			local sameValues = true
			for key, value in pairs( upgradedTrait.ExtractData ) do
				if trait.ExtractData ~= nil and trait.ExtractData[key] ~= value then
					sameValues = false
					break
				end
			end
			if not sameValues then
				traitNames[trait.Name] = true
			end
		end
	end
	return traitNames
end

function GetEligibleTransformingTrait( traitNames )
	local output = {}
	for i, traitName in pairs(traitNames) do
		if IsTraitEligible(CurrentRun, TraitData[traitName]) then
			table.insert(output, traitName)
		end
	end
	return output
end

function SetTransformingTraitsOnLoot( lootData, upgradeChoiceData )
	DebugAssert({ Condition = not IsEmpty(upgradeChoiceData.PermanentTraits) and not IsEmpty(upgradeChoiceData.TemporaryTraits), Text = "Transforming Loot data is invalid!", Owner = "Alice" })
	local upgradeOptions = {}
	local permanentTraits = GetEligibleTransformingTrait( upgradeChoiceData.PermanentTraits )
	local temporaryTraits = GetEligibleTransformingTrait( upgradeChoiceData.TemporaryTraits )
	lootData.Rarity = {}

	while TableLength( upgradeOptions ) < GetTotalLootChoices() and not IsEmpty(permanentTraits) do
		local permanentTraitName = nil
		local temporaryTraitName = nil
		permanentTraitName = RemoveRandomValue(permanentTraits)

		if RandomChance(0.7) and TableLength(temporaryTraits) > 1 then
			temporaryTraitName = RemoveRandomValue(temporaryTraits)
		else
			temporaryTraitName = GetRandomValue(temporaryTraits)
		end

		local upgradeData = { ItemName = permanentTraitName, SecondaryItemName = temporaryTraitName, Type = "TransformingTrait" }

		if TraitData[permanentTraitName].RarityLevels and TableLength( TraitData[permanentTraitName].RarityLevels ) == 1 then
			upgradeData.Rarity = GetFirstKey( TraitData[permanentTraitName].RarityLevels )
		elseif TraitData[temporaryTraitName].UpgradePairedRarity then
			upgradeData.Rarity = "Heroic"
		elseif RandomChance( lootData.RarityChances.Epic or 0 ) then
			upgradeData.Rarity = "Epic"
		elseif RandomChance( lootData.RarityChances.Rare or 0 ) then
			upgradeData.Rarity = "Rare"
		else
			upgradeData.Rarity = "Common"
		end

		table.insert( upgradeOptions, upgradeData )
	end
	lootData.UpgradeOptions = upgradeOptions
end

function CalcNumLootChoices( isGodLoot, treatAsGodLootByShops )
	local numChoices = ScreenData.UpgradeChoice.MaxChoices - GetNumMetaUpgrades("ReducedLootChoicesShrineUpgrade")
	if (isGodLoot or treatAsGodLootByShops) and HasHeroTraitValue("RestrictBoonChoices") then
		numChoices = numChoices - 1
	end
	return numChoices
end

function GetTotalLootChoices()
	return ScreenData.UpgradeChoice.MaxChoices
end

function SetTraitsOnLoot( lootData, args )
	local upgradeName = lootData.Name
	local upgradeChoiceData = lootData
	args = args or {}

	if IsRarityForcedCommon( upgradeName ) or args.ForceCommon then
		lootData.RarityChances = {}
		lootData.ForceCommon = true
		lootData.ForceCommonWithoutCurse = IsRarityForcedCommon( upgradeName, { IgnoreCurse = true })
	else
		lootData.IgnoreTempRarityBonus = args.IgnoreTempRarityBonus
		if args.BoonRaritiesOverride then
			lootData.BoonRaritiesOverride = ShallowCopyTable( args.BoonRaritiesOverride )
		end
		lootData.RarityChances = GetRarityChances( lootData )
		if not args.IgnoreTempRarityBonus then
			lootData.RarityBoosted = true
		end
	end

	if upgradeChoiceData.TransformingTraits then
		return SetTransformingTraitsOnLoot( lootData, upgradeChoiceData )
	end

	local upgradeOptions = {}
	local chosenPriorityTraits = ShallowCopyTable( lootData.PriorityUpgrades )
	local forceSwapTrait = HasHeroTraitValue("ForceSwaps")
	if CurrentRun.CurrentRoom.ForceLootTableFirstRun and GetCompletedRuns() == 0 then
		upgradeOptions = GetPriorityTraits( CurrentRun.CurrentRoom.ForceLootTableFirstRun, lootData )
	elseif forceSwapTrait and forceSwapTrait.Uses > 0 then
		upgradeOptions = GetReplacementTraits( lootData.PriorityUpgrades )
		if not IsEmpty( upgradeOptions ) then
			lootData.UseSwapTrait = true
		end
	elseif IsGameStateEligible( CurrentRun, CurrentRun.Hero.BoonData.GameStateRequirements) and RandomChance( CurrentRun.Hero.BoonData.ReplaceChance ) and not lootData.ForceCommon then
		upgradeOptions = GetReplacementTraits( lootData.PriorityUpgrades )
	end

	if IsEmpty( upgradeOptions ) then
		upgradeOptions = GetPriorityTraits( lootData.PriorityUpgrades, lootData )
	else
		for i, upgradeOption in pairs( upgradeOptions ) do
			if IsGameStateEligible(CurrentRun, TraitData[upgradeOption.ItemName]) then
				RemoveValueAndCollapse( chosenPriorityTraits, upgradeOption.ItemName )
			end
		end
	end

	local priorityLinkedTraits = GetPriorityDependentTraits( lootData )
	if priorityLinkedTraits ~= nil then
		for i, linkedTraitData in ipairs( priorityLinkedTraits ) do
			if TableLength( upgradeOptions ) >= GetTotalLootChoices() then
				break
			end
			if RandomChance( linkedTraitData.PriorityChance ) then
				table.insert( upgradeOptions, { ItemName = linkedTraitData.TraitName, Type = "Trait" })
			end
		end
	end
	
	if args and args.ExclusionNames then
		-- Remove values that are excluded
		for _, name in pairs( args.ExclusionNames ) do
			for i, upgradeData in pairs(upgradeOptions) do
				if upgradeData.ItemName == name then
					upgradeOptions[i] = nil
				end
			end
		end
		upgradeOptions = CollapseTable( upgradeOptions )
	end
	local eligibleOptions = {}

	if TableLength( upgradeOptions ) < GetTotalLootChoices() then
		-- don't bother with this expensive calculation if we've filled up on priority traits
		eligibleOptions = GetEligibleUpgrades(upgradeOptions, lootData, upgradeChoiceData)
	end

	-- build legal rarity table
	local rarityTable = {}
	for rarityName in pairs( TraitRarityData.RarityValues ) do
		rarityTable[rarityName] = {}
	end

	for s, options in pairs({ upgradeOptions, eligibleOptions }) do
		for i, upgradeData in pairs(options) do
			local rarityLevels = nil
			if upgradeData.Type == "Trait" then
				rarityLevels = TraitData[upgradeData.ItemName].RarityLevels
			end
			if upgradeData.Type == "Consumable" then
				rarityLevels = ConsumableData[upgradeData.ItemName].RarityLevels
			end

			if rarityLevels == nil then
				rarityLevels = { Common = true }
			end

			for key, table in pairs( rarityTable ) do
				if rarityLevels[key] ~= nil then
					table[upgradeData.ItemName] = upgradeData
				end
			end
		end
	end

	if args and args.ExclusionNames then
		-- Remove values that are excluded
		for i, name in pairs( args.ExclusionNames ) do
			for key, table in pairs( rarityTable ) do
				table[name] = nil
			end
		end
		upgradeOptions = CollapseTable( upgradeOptions )
	end

	lootData.Rarity = {}
	lootData.RarityRollOrder = lootData.RarityRollOrder or TraitRarityData.BoonRarityRollOrder
	-- process priority traits. priority traits determine rarity instead of the other way around
	for i, upgradeData in ipairs(upgradeOptions) do
		if upgradeData.Rarity then
			upgradeOptions[i].Rarity = upgradeData.Rarity
		else
			upgradeOptions[i].Rarity = "Common"
			for _, rarityName in ipairs( lootData.RarityRollOrder ) do
				if rarityTable[rarityName][upgradeData.ItemName] and lootData.RarityChances and lootData.RarityChances[rarityName] and RandomChance( lootData.RarityChances[rarityName] ) then
					upgradeOptions[i].Rarity = rarityName
				end
			end
		end
		
		for rarityName in pairs( TraitRarityData.RarityValues ) do
			rarityTable[rarityName][upgradeData.ItemName] = nil
		end
	end

	-- fill rest with eligible traits
	for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
		local validRarities = {}
		
		for rarityName in pairs( TraitRarityData.RarityValues ) do
			validRarities[rarityName] = not IsEmpty(rarityTable[rarityName])
		end

		local chosenUpgrade = GetRandomValue( rarityTable.Common )
		local chosenRarity = "Common"
		
		for _, rarityName in ipairs( lootData.RarityRollOrder ) do
			
			if validRarities[rarityName] and lootData.RarityChances and lootData.RarityChances[rarityName] and RandomChance( lootData.RarityChances[rarityName]) then
				chosenRarity = rarityName
				chosenUpgrade = GetRandomValue( rarityTable[rarityName])
			end
		end

		if chosenUpgrade then
			chosenUpgrade.Rarity = chosenRarity
			table.insert(upgradeOptions, chosenUpgrade)
			
			for rarityName in pairs( TraitRarityData.RarityValues ) do
				rarityTable[rarityName][chosenUpgrade.ItemName] = nil
			end
		end
	end

	-- Fill empty spots with exchange traits
	for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
		if IsEmpty(chosenPriorityTraits) then
			break
		end
		local chosenUpgrades =  GetReplacementTraits( chosenPriorityTraits )
		if chosenUpgrades == nil or chosenUpgrades[1] == nil then
			break
		end
		local chosenUpgrade = chosenUpgrades[1]
		table.insert( upgradeOptions, chosenUpgrade )
		RemoveValueAndCollapse( chosenPriorityTraits, chosenUpgrade.ItemName )
	end

	-- Fill empty spots with any traits that failed the rarity check the first time around
	local numBans = MetaUpgradeData.BanUnpickedBoonsShrineUpgrade.ChangeValue
	if numBans <= 0 then
		for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
			local validRarities = {}
		
			for rarityName in pairs( TraitRarityData.RarityValues ) do
				validRarities[rarityName] = not IsEmpty(rarityTable[rarityName])
			end

			local chosenUpgrade = GetRandomValue( rarityTable.Common )
			local chosenRarity = "Common"
		
			for _, rarityName in ipairs( lootData.RarityRollOrder ) do
				if validRarities[rarityName] and lootData.RarityChances[rarityName] then
					chosenRarity = rarityName
					chosenUpgrade = GetRandomValue( rarityTable[rarityName])
				end
			end
		
			if chosenUpgrade then
				chosenUpgrade.Rarity = chosenRarity
				table.insert(upgradeOptions, chosenUpgrade)
				for rarityName in pairs( TraitRarityData.RarityValues ) do
					rarityTable[rarityName][chosenUpgrade.ItemName] = nil
				end
			end
		end
	end

	-- Block rerolling if we truly have no options left
	local blockReroll = IsEmpty( chosenPriorityTraits ) and ( not args or IsEmpty( args.ExclusionNames ))
	for rarity, validTraits in pairs(rarityTable ) do
		if blockReroll and not IsEmpty( validTraits ) then
			blockReroll = false
		end
	end
	lootData.BlockReroll = blockReroll
	lootData.UpgradeOptions = upgradeOptions
end

function ExtractValues( unit, topLevelTable, curTable, depth )
	depth = depth or 0
	local mergeBackValues = true
	if not curTable then
		curTable = topLevelTable
	end

	if depth == 0 then
		mergeBackValues = false
	end

	local curTableOrdered = CollapseTableAsOrderedKeyValuePairs( curTable )
	for _, kvp in ipairs( curTableOrdered ) do
		local key = kvp.Key
		local value = kvp.Value
		if type( value ) == "table" and  key ~= "ReportValues" then
			DebugAssert({ Condition = ( depth < 20 ), Text = " ExtractValues overflow detected on (" .. tostring(topLevelTable.Name) .. ") with path " .. key, Owner = "Alice" })

			ExtractValues(unit, topLevelTable, value,  depth + 1)
		end		
	end

	if mergeBackValues then
		if curTable.ReportValues then
			for key, value in pairs( curTable.ReportValues ) do
				if curTable[value] then
					topLevelTable[key] = curTable[value]
				end
			end
		end
	else			
		if topLevelTable.ExtractValues then
			-- back at the top level table, about to exit. Finish final formatting steps.
			local traitExtractedData = {}
			for key, extractData in pairs(topLevelTable.ExtractValues) do
				ExtractValue( CurrentRun.Hero, traitExtractedData, topLevelTable, extractData)
			end
			topLevelTable.ExtractData = traitExtractedData
		end
	end
end

function ExtractValue( unit, extractToTable, table, extractData)
	if extractData == nil then
		if table.ExtractValue == nil then
			return
		end
		extractData = table.ExtractValue
	end
	local value = nil

	if extractData.External then
		DebugAssert({Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
		DebugAssert({Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name.", Owner = "Alice" })
		DebugAssert({Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property.", Owner = "Alice" })
		if extractData.BaseType == "Projectile" then
			value = GetProjectileDataValue({ Id = unit.ObjectId, WeaponName = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "Effect" then
			value = GetEffectDataValue({ WeaponName = extractData.WeaponName, EffectName = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "ProjectileBase" then
			value = GetBaseDataValue({ Type = "Projectile", Name = extractData.BaseName, Property = extractData.BaseProperty })
		
			if extractData.BaseProperty == "NumJumps" and extractData.Format == "TotalTargets" then
				value = value + 1
			end
		elseif extractData.BaseType == "Weapon" then
			value = GetBaseDataValue({ Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "WeaponData" then
			if extractData.BaseProperty == "ManaPerSecond" and WeaponData[extractData.BaseName].DrainManaEffect then
				value = WeaponData[extractData.BaseName].DrainManaEffect.CostPerSecond
			elseif extractData.BaseProperty == "ChargeStageProperty" then
				value = WeaponData[extractData.BaseName].ChargeWeaponStages[extractData.ChargeStage][extractData.ChargeStageProperty]
			elseif extractData.BaseProperty == "FiredFunctionArgs" then
				value = WeaponData[extractData.BaseName].OnFiredFunctionArgs[extractData.FiredFunctionArg]
			else
				value = WeaponData[extractData.BaseName][extractData.BaseProperty]
			end
		elseif extractData.BaseType == "EffectLuaData" then
			value = EffectData[extractData.BaseName][extractData.BaseProperty]
		elseif extractData.BaseType == "EffectData" then
			if extractData.BaseProperty == "ActiveDuration" then
				value = EffectData[extractData.BaseName].EffectData.Duration - EffectData[extractData.BaseName].EffectData.ExpiringTimeThreshold
			elseif EffectData[extractData.BaseName] and EffectData[extractData.BaseName].EffectData then
				value = EffectData[extractData.BaseName].EffectData[extractData.BaseProperty]
			elseif EffectData[extractData.BaseName] and EffectData[extractData.BaseName].DataProperties then
				value = EffectData[extractData.BaseName].DataProperties[extractData.BaseProperty]
			end			
		elseif extractData.BaseType == "ConsumableData" then
			if ConsumableData[extractData.BaseName] then
				value = ConsumableData[extractData.BaseName][extractData.BaseProperty]
			end
		elseif extractData.BaseType == "HeroData" then
			value = HeroData[extractData.BaseName][extractData.BaseProperty]
		elseif extractData.BaseType == "MetaUpgradeRequirement" then
			if MetaUpgradeCardData[extractData.BaseName].AutoEquipRequirements then
				value = MetaUpgradeCardData[extractData.BaseName].AutoEquipRequirements[extractData.BaseProperty]
			else
				value = 0
			end
		else
			DebugAssert({Condition = false, Text = "Trying to find an external value on unsupported type " .. extractData.BaseType, Owner = "Alice" })
		end
		
		if AutomaticExtractProperties[extractData.ExtractAs] then
			local autoExtractData = AutomaticExtractProperties[extractData.ExtractAs]
			
			if autoExtractData.AddHeroValue then
				value = value + GetTotalHeroTraitValue( autoExtractData .AddHeroValue )
			end
			if autoExtractData.MultiplyHeroValue then
				value = value * GetTotalHeroTraitValue( autoExtractData .MultiplyHeroValue, { IsMultiplier = true } )
			end
			if autoExtractData.ReplaceWithHeroValue and GetTotalHeroTraitValue( autoExtractData.ReplaceWithHeroValue, {IsMultiplier = true }) ~= 1 then
				value = GetTotalHeroTraitValue( autoExtractData.ReplaceWithHeroValue, {IsMultiplier = true })
			end
		end
	elseif extractData.Format == "TotalDamageTaken" then
		if CurrentRun and CurrentRun.Hero.IsDead  then
			value = 0
		else
			value = CurrentRun.TotalDamageTaken or 0
		end
	elseif extractData.Format == "EasyModeMultiplier" then
		value = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	elseif extractData.Format == "TotalMetaUpgradeChangeValue" then
		local name = extractData.MetaUpgradeName
		local numUpgrades = GetNumMetaUpgrades( name )
		local upgradeData = MetaUpgradeData[name]
		value = GetTotalStatChange( upgradeData )
	elseif extractData.Format == "SlottedBoon" then
		value = "Blank"
	else
		if extractData.Key == nil then
			extractData.Key = "ChangeValue"
		end
		local keyToExtract = extractData.Key
		if table[keyToExtract] == nil then
			DebugPrint({Text = "Attempting to extract nonexistent key" .. keyToExtract .. " from " .. tostring(extractData.ExtractAs)})
			return
		end
		value = table[keyToExtract]
		if extractData.Format == "MaxHealth" then
			value = GetMaxHealthUpgradeIncrement( value )
		end
		if extractData.Format == "MaxMana" then
			value = GetMaxManaUpgradeIncrement( value )
		end
	end

	if value ~= nil then
		extractToTable[extractData.ExtractAs] = FormatExtractedValue(value, extractData)
	end
end

function FormatExtractedValue(value, extractData)
	if extractData.Format ~= nil then
		if extractData.Format == "MultiplyByBase" then
			DebugAssert({ Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name.", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property.", Owner = "Alice" })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			value = value * baseDataValue
		elseif extractData.Format == "AddToBase" then
			DebugAssert({ Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name.", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property.", Owner = "Alice" })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			value = value + baseDataValue
		elseif extractData.Format == "PercentOfBase" then
			DebugAssert({ Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name.", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property.", Owner = "Alice" })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			value = (value / baseDataValue) * 100
		elseif extractData.Format == "Percent" then
			-- eg 0.5 becomes "50"
			value = value * 100
		elseif extractData.Format == "FlatPercent" then
			-- eg  0.5 becomes "50"
			-- eg -0.5 becomes "50"
			value = math.abs(value * 100)
		elseif extractData.Format == "PercentReciprocalDelta" then
			-- eg 0.5 becomes "+100"
			value = ( 1 / value ) * 100 - 100
		elseif extractData.Format == "PercentDelta" then
			-- eg 1.3 becomes "30"
			value = (value - 1) * 100
		elseif extractData.Format == "FlatPercentDelta" then
			-- eg 1.3 becomes "30"
			value = math.abs((value - 1) * 100)
		elseif extractData.Format == "NegativePercentDelta" then
			-- eg. 0.7 becomes "-30"
			value = (1 - value) * 100
		elseif extractData.Format == "FlatHeal" then
			value = value * CalculateHealingMultiplier()
		elseif extractData.Format == "PercentHeal" then
			value = value * CalculateHealingMultiplier()
			value = value * 100
		elseif extractData.Format == "PercentPlayerHealth" or extractData.Format == "PercentPlayerHealthFountain" then
			if CurrentRun.Hero ~= nil then
				local maxLife = CurrentRun.Hero.MaxHealth
				if maxLife == nil then
					return 0
				else
					if extractData.Format == "PercentPlayerHealthFountain" then
						value = value + GetTotalHeroTraitValue( "FountainHealFractionBonus" )
						local healFractionOverride = GetTotalHeroTraitValue("FountainHealFractionOverride") 
						if healFractionOverride > 0 then
							value = healFractionOverride
						end
					end
					value = value * CalculateHealingMultiplier()
					if value > 1 then 
						value = 1 
					end
					value = maxLife * value
				end
			else
				value = value * 100 .. "%"
			end
		elseif extractData.Format == "HealingDrop" then
			local baseHealFraction = ConsumableData[extractData.ConsumableName].HealFraction
			local healingMultiplier = CalculatePositiveHealingMultiplier() + ( value - 1 )
			healingMultiplier = healingMultiplier * ( 1 - GetNumMetaUpgrades("HealingReductionShrineUpgrade") * ( MetaUpgradeData.HealingReductionShrineUpgrade.ChangeValue - 1 ) )
			if CurrentRun.Hero ~= nil then
				local maxLife = CurrentRun.Hero.MaxHealth
				if maxLife == nil then
					return 0
				else
					value = maxLife * baseHealFraction
					-- @hack More special casing that probably doesn't belong here and may not always be wanted.  Sorry back at you Alice!
					value = value * healingMultiplier
				end
			else
				value = value * 100 .. "%"
			end
		elseif extractData.Format == "CooldownBasedManaPerSecond" then
			DebugAssert({Condition = extractData.WeaponName ~= nil, Text = "Extracting a CooldownBasedManaPerSecond value without a weapon.", Owner = "Alice" })
			local fuse = GetBaseDataValue({ Type = "Weapon", Name = extractData.WeaponName, Property = "Cooldown"})
			value = value / fuse
		elseif extractData.Format == "DamageOverTime" or extractData.Format == "DamageOverTotalDuration" then
			DebugAssert({Condition = extractData.BaseProperty ~= nil or extractData.BaseValue ~= nil, Text = "Extracting a DamageOverTime value without a property.", Owner = "Alice" })
			local fuse = 1
			if extractData.BaseValue ~= nil then
				fuse = extractData.BaseValue
			elseif extractData.WeaponName ~=  nil then
				if extractData.BaseName ~= nil then
					fuse = GetEffectDataValue({ WeaponName = extractData.WeaponName, EffectName = extractData.BaseName, Property = extractData.BaseProperty })
				else
					fuse = GetBaseDataValue({ Type = "Weapon", Name = extractData.WeaponName, Property = extractData.BaseProperty })
				end
			else
				fuse = GetBaseDataValue({Type = "Projectile", Name = extractData.BaseName, Property = extractData.BaseProperty })
			end
			local multiplier = 1
			if extractData.Format == "DamageOverTotalDuration" then
				if extractData.DurationSource then
					multiplier = WeaponData[extractData.DurationSource][extractData.DurationSourceKey]
				end
			end
			value = value / fuse * multiplier
		elseif extractData.Format == "SeekDuration" then
			local deceleration = -1 * GetBaseDataValue({Type = "Projectile", Name = extractData.BaseName, Property = "AdjustRateAcceleration" })
			value = value / deceleration
		elseif extractData.Format == "ArcDuration" then
			local arcSpeed = GetBaseDataValue({Type = "Projectile", Name = extractData.BaseName, Property = "Speed" })
			value = math.abs(value) / math.rad(arcSpeed)
		elseif extractData.Format == "Rarity" then
			return 	"{$Keywords." ..GetRarityKey( value ).."}"
		elseif extractData.Format == "CardRarity" then
			return 	"MetaRank".. value
		elseif extractData.Format == "TimesOneHundred" then
			return value * 100
		elseif extractData.Format == "TimesOneHundredPercent" then
			return value * 100 * 100
		elseif extractData.Format == "SlottedBoon" then
			if CurrentRun.Hero.SlottedTraits[extractData.Slot] then
				return CurrentRun.Hero.SlottedTraits[extractData.Slot]
			else
				return "None_In_Slot"
			end
		end
	end
	if extractData.MultiplyByMissingLastStands and CurrentRun.Hero.MaxLastStands and TableLength(CurrentRun.Hero.LastStands) then
		value = value * (CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands ))
	end
	local precision = 0
	if extractData.DecimalPlaces ~= nil then
		precision = extractData.DecimalPlaces
	end
	if extractData.AbsoluteValue ~= nil then
		value = math.abs(value)
	end
	return round( value, precision )
end

function GetExtractData(newTraitData, includeExternal)
	local extractedData = {}
	if newTraitData.ExtractValues ~= nil then
		for i, extractData in pairs(newTraitData.ExtractValues) do
			if (includeExternal or not extractData.External) then
				table.insert(extractedData, extractData)
			end
		end
	end

	return extractedData
end

function SetTraitTextData( traitData, args )
	args = args or {}
	ExtractValues( CurrentRun.Hero, traitData, traitData )
	
	if args.ReplacementTraitData then
		ExtractValues( CurrentRun.Hero, args.ReplacementTraitData, args.ReplacementTraitData )
		GameState.InspectData = args.ReplacementTraitData
	end
	
	-- needs to be ordered properly @alice
	traitData.Additional = {}
	traitData.OldTotal = {}
	traitData.NewTotal = {}
	traitData.PercentIncrease = {}
	local extractedIndex = 0
	if traitData.ExtractValues then
		for i, data in pairs(traitData.ExtractValues) do
			if data.Subtractor then
				local key = data.ExtractAs
				traitData.ExtractData[key] = traitData.ExtractData[key] - traitData.ExtractData[data.Subtractor]
			end
			if data.Multiplier1 then
				local baseValue = traitData.ExtractData[data.Multiplier1] * traitData.ExtractData[data.Multiplier2]
				local key = data.ExtractAs
				
				traitData.ExtractData[key] =  FormatExtractedValue(baseValue / traitData.ExtractData[data.Key], data)
			end

			if not data.SkipAutoExtract then
				extractedIndex = extractedIndex + 1
				local key = data.ExtractAs
				traitData.NewTotal[extractedIndex] = traitData.ExtractData[key]
				if data.Format ~= nil and PercentFormatNamesLookup[data.Format] then
					if data.HideSigns then
						traitData["NewTotal"..extractedIndex] = "FlatPercentNewTotal"..extractedIndex
					else
						traitData["NewTotal"..extractedIndex] = "PercentNewTotal"..extractedIndex
					end
				else
					if data.IncludeSigns then
						traitData["NewTotal"..extractedIndex] = "DeltaNewTotal"..extractedIndex
					else
						traitData["NewTotal"..extractedIndex] = "NewTotal"..extractedIndex
					end
				end
				
				if args.ReplacementTraitData then
					traitData.NewTotal[extractedIndex] = args.ReplacementTraitData.ExtractData[key]
					traitData.OldTotal[extractedIndex] = traitData.ExtractData[key]
					if data.Format ~= nil and PercentFormatNamesLookup[data.Format] then
						if data.HideSigns then
							traitData["NewTotal"..extractedIndex] = "FlatPercentNewTotal"..extractedIndex
							traitData["OldTotal"..extractedIndex] = "FlatPercentOldTotal"..extractedIndex
						else
							traitData["NewTotal"..extractedIndex] = "PercentNewTotal"..extractedIndex
							traitData["OldTotal"..extractedIndex] = "PercentOldTotal"..extractedIndex
						end
					else
					
						if data.IncludeSigns then
							traitData["NewTotal"..extractedIndex] = "DeltaNewTotal"..extractedIndex
							traitData["OldTotal"..extractedIndex] = "DeltaOldTotal"..extractedIndex
						else
							traitData["NewTotal"..extractedIndex] = "NewTotal"..extractedIndex
							traitData["OldTotal"..extractedIndex] = "OldTotal"..extractedIndex
						end
					end

					traitData["StatDisplay"..extractedIndex] = "Increase"..extractedIndex
				else
					traitData["StatDisplay"..extractedIndex] = traitData["NewTotal"..extractedIndex]
				end
			end
		end
	else
		traitData.ExtractValues = {}
	end

	if traitData.OnExpire and traitData.OnExpire.TraitData and traitData.OnExpire.TraitData.ExtractData then
		traitData.ExtractData = traitData.ExtractData or {}
		traitData.ExtractData = MergeTables( traitData.ExtractData, traitData.OnExpire.TraitData.ExtractData )
	end
end

function AddStackToTraits( source, args )
	if not args then
		args = ShallowCopyTable(source)
		source = {}
	end

	if args.Thread then
		args.Thread = false
		thread( AddStackToTraits, source, args )
		return
	end
	wait( args.Delay )

	local numStacks = args.NumStacks or 1
	local numTraits = args.NumTraits or 1

	-- do we need to freeze the player?
	local upgradableTraits = {}
	local upgradedTraits = {}

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if args.TraitName then
			if traitData.Name == args.TraitName then
				upgradableTraits[traitData.Name] = traitData
			end
		elseif IsGodTrait(traitData.Name) and TraitData[traitData.Name] and IsGameStateEligible(CurrentRun, TraitData[traitData.Name]) and not traitData.BlockStacking then
			upgradableTraits[traitData.Name] = traitData
		end
	end

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local name = GetRandomKey( upgradableTraits )
		upgradedTraits[name] = true
		for s = 1, numStacks do
			IncreaseTraitLevel( upgradableTraits[name] )
		end
		numTraits = numTraits - 1
		upgradableTraits[name] = nil
	end

	UpdateHeroTraitDictionary()

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if upgradedTraits[traitData.Name] then
			wait(0.1)
			TraitUIUpdateText( traitData )
		end
	end
	
	thread( IncreasedTraitLevelPresentation, upgradedTraits, numStacks )
end

function IncreaseTraitLevel( traitData, stacks )
	stacks = stacks or 1
	for i, currentTraitData in pairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( traitData, currentTraitData ) then
			local newStackNum = traitData.StackNum
			if newStackNum then
				newStackNum = traitData.StackNum + stacks
			else
				newStackNum = 1 + stacks
			end
			local persistentValues = {}
			for i, key in pairs( PersistentTraitKeys ) do
				persistentValues[key] = traitData[key]
			end

			local newTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = newStackNum, RarityMultiplier = traitData.RarityMultiplier})
			newTrait.StackNum = newStackNum
			newTrait.Rarity = traitData.Rarity
			newTrait.RarityMultiplier = traitData.RarityMultiplier
			for i, key in pairs( PersistentTraitKeys ) do
				newTrait[key] = persistentValues[key]
			end

			RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true })
			AddTraitToHero({ TraitData = newTrait, SkipNewTraitHighlight = true, SkipActivatedTraitUpdate = true, SkipSetup = true })

			return newTrait
		end
	end
	
	return traitData
end
function ChaosHammerUpgrade( args )
	args = args or {}
	local hammerTraits = {}
	local addedTraits = {}
	local numTraits = args.NumTraits or 2
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if LootData.WeaponUpgrade.TraitIndex[trait.Name] then
			table.insert(hammerTraits, trait.Name )
		end
	end

	-- remove one weapon trait
	local removedTraitName = nil
	if not IsEmpty( hammerTraits ) then
		removedTraitName = RemoveRandomValue( hammerTraits )
		RemoveWeaponTrait( removedTraitName )
	end

	for i = 1, numTraits do
		local validTraitNames = {}
		for i, traitName in pairs( LootData.WeaponUpgrade.Traits ) do
			if IsTraitEligible(CurrentRun, TraitData[traitName]) and traitName ~= removedTraitName and not Contains(hammerTraits, traitName) then
				table.insert( validTraitNames, traitName )
			end
		end

		if not IsEmpty( validTraitNames ) then
			local newTraitName = RemoveRandomValue( validTraitNames )
			AddTraitToHero({ TraitName =  newTraitName })
			table.insert( hammerTraits, newTraitName )
			table.insert( addedTraits, newTraitName )
		end
	end

	InvalidateCheckpoint()
		
	thread( ChaosHammerPresentation, removedTraitName, addedTraits )
end

function UseStoreRewardRandomStack( args )
	args = args or {}
	if args.NumStacks then
		args.NumStacks = args.NumStacks + GetTotalHeroTraitValue("PomLevelBonus")
	end
	AddStackToTraits( args )
	StoreRewardRandomStackPresentation()
end

function AddOrIncreaseTrait( args )
	args = args or {}
	if HeroHasTrait( args.TraitName ) then
		AddStackToTraits({ TraitName = args.TraitName })
	else
		AddTraitToHero({ TraitName = args.TraitName })
	end
end

function UpgradeAllCommon( args, origTraitData )
	local sourceTraitData = nil
	local traitDictionary = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( origTraitData, traitData ) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		elseif not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name, { ForShop = true }) and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity == "Common" then
			table.insert(upgradableTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end
	
	while not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )

		upgradedTraits[traitData.Name] = true
		local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
		RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true })
		local persistentValues = {}
		for i, key in pairs( PersistentTraitKeys ) do
			persistentValues[key] = traitData[key]
		end

		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, StackNum = numOldTrait, TraitName = traitData.Name, Rarity = "Rare" }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true })
	end
	sourceTraitData.Rarity = "Rare"
	thread( IncreasedTraitRarityPresentation, upgradedTraits, args.PresentationDelay )
	if sourceTraitData and args.ActivatedValues then
		for name, data in pairs( args.ActivatedValues ) do
			sourceTraitData[name] = DeepCopyTable( data )
		end
	end
end

function SacrificeAllBoon( args, origTraitData )

	local traitDictionary = {}
	local validTraits = {}
	local buffTraits = {}
	local totalLevels = 0
	local sourceTraitData = nil
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( traitData, origTraitData) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		end
		if not traitDictionary[traitData.Name] 
			and IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] 
			and traitData.Rarity ~= nil 
			and not traitData.BlockSacrifice then
			if  GetLootSourceName(traitData.Name) == args.RemoveGod then
				table.insert(validTraits, traitData )
				traitDictionary[traitData.Name] = true
				totalLevels = totalLevels + args.LevelBonus
			end
			if GetLootSourceName(traitData.Name) == args.BuffGod and not traitData.BlockStacking then
				table.insert(buffTraits, traitData )
			end
		end
	end
	for traitName in pairs(traitDictionary ) do
		RemoveWeaponTrait( traitName )
	end
	for _, traitData in pairs( buffTraits ) do
		IncreaseTraitLevel( traitData, totalLevels )
	end
	sourceTraitData.TotalLevelsGained = totalLevels 
	thread( SuperSacrificePresentation, args.RemoveGod, args.BuffGod, totalLevels)
end

function UpgradeAspect( args, origTraitData )
	args = args or {}
	local currentWeaponName = GetEquippedWeapon()
	local currentWeaponData = WeaponData[currentWeaponName]

	local traitName = GameState.LastWeaponUpgradeName[currentWeaponName]
	if traitName == nil then
		traitName = ScreenData.WeaponUpgradeScreen.FreeUnlocks[currentWeaponName]
	end

	if traitName and HeroHasTrait( traitName ) then
		RemoveTrait( CurrentRun.Hero, traitName )
	end

	local numRanks = GetWeaponUpgradeLevel( traitName ) + args.UpgradeLevels
	local rarity = TraitRarityData.WeaponRarityUpgradeOrder[numRanks]
	AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = traitName, Rarity = rarity })

end

function HeroicDowngradeBoons( args, origTraitData )
	numTraits = args.NumTraits
	local traitRarity = "Common"
	local traitDictionary = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	local sourceTraitData = nil
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( origTraitData, traitData ) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		elseif not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name) and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.RarityLevels and traitData.RarityLevels.Heroic then
			table.insert(upgradableTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end

	if not sourceTraitData then
		return
	end
	sourceTraitData.DowngradeTraitNames = {}

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )


		upgradedTraits[traitData.Name] = true
		table.insert( sourceTraitData.DowngradeTraitNames, traitData.Name )
		local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
		RemoveTraitData(CurrentRun.Hero, traitData, { SkipActivatedTraitUpdate = true })
		local persistentValues = {}
		for i, key in pairs( PersistentTraitKeys ) do
			persistentValues[key] = traitData[key]
		end

		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, StackNum = numOldTrait, TraitName = traitData.Name, Rarity = "Heroic" }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true })

		numTraits = numTraits - 1
	end
	
	CurrentRun.Hero.DowngradableTraitCountCache = TableLength( sourceTraitData.DowngradeTraitNames )	
	sourceTraitData.TraitListTextString = "DecayBoonTraitList"..tostring(TableLength(sourceTraitData.DowngradeTraitNames))
	thread( HarvestBoonTraitPresentation, upgradedTraits, 2.0 )

	if CurrentRun.Hero.UpgradeableTraitCountCache then
		for i, traitData in pairs( CurrentRun.Hero.Traits ) do
			if traitData.RoomsPerUpgrade and traitData.RoomsPerUpgrade.Rarity then
				local count = 0
				for i, boonName in pairs(traitData.HarvestBoons or {}) do
					if HeroHasTrait( boonName ) then
						local targetTrait = GetHeroTrait(boonName)
						if targetTrait.Rarity ~= nil and GetUpgradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetUpgradedRarity(targetTrait.Rarity)] ~= nil then
							count = count + 1
						end
					end
				end
				CurrentRun.Hero.UpgradeableTraitCountCache = count
				if count == 0 then
					traitData.Uses = 0
					TraitUIRemove( traitData ) 
				end
			end
		end
	end
end

function HarvestBoons( args, origTraitData )
	numTraits = args.NumTraits
	local traitRarity = "Common"
	local traitDictionary = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	local sourceTraitData = nil
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( origTraitData, traitData ) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		elseif not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name) and TraitData[traitData.Name] and traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil and not traitData.BlockInRunRarify then
			table.insert(upgradableTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end

	if not sourceTraitData then
		return
	end
	sourceTraitData.HarvestBoons = {}

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )

		upgradedTraits[traitData.Name] = true
		table.insert( sourceTraitData.HarvestBoons, traitData.Name )
		local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
		local persistentValues = {}
		for i, key in pairs( PersistentTraitKeys ) do
			persistentValues[key] = traitData[key]
		end
		RemoveTraitData(CurrentRun.Hero, traitData, { SkipActivatedTraitUpdate = true })

		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, StackNum = numOldTrait, TraitName = traitData.Name, Rarity = "Common" }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true })
		numTraits = numTraits - 1
	end
	CurrentRun.Hero.UpgradeableTraitCountCache = TableLength( sourceTraitData.HarvestBoons )
	sourceTraitData.TraitListTextString = "HarvestBoonTraitList"..tostring( CurrentRun.Hero.UpgradeableTraitCountCache )
	thread( HarvestBoonTraitPresentation, upgradedTraits, 2.0 )

	if CurrentRun.Hero.DowngradableTraitCountCache then
		for i, traitData in pairs( CurrentRun.Hero.Traits ) do
			if traitData.RoomsPerUpgrade and traitData.RoomsPerUpgrade.DowngradeRarity then
				local count = 0
				for i, boonName in pairs(traitData.DowngradeTraitNames) do
					if HeroHasTrait(boonName) then
						local targetTrait = GetHeroTrait(boonName)
						if targetTrait.Rarity ~= nil and GetDowngradedRarity(targetTrait.Rarity) ~= nil and targetTrait.RarityLevels[GetDowngradedRarity(targetTrait.Rarity)] ~= nil then
							count = count + 1
						end
					end
				end
				CurrentRun.Hero.DowngradableTraitCountCache = count
				if count == 0 then
					traitData.Uses = 0
					TraitUIRemove( traitData ) 
				end
			end
		end
	end
end

function CheckChamberTraits()
	RandomSynchronize( GetRunDepth( CurrentRun ))
	local textDelay = 0
	local totalAddedMana = 0
	local totalAddedHealth = 0
	local rarityTraits = {}
	local transformBlessing = false
	local transformBlessingRarity = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.RoomsPerUpgrade then
		
			IncrementTableValue( trait, "CurrentRoom" )
			if trait.RoomsPerUpgrade.Amount and trait.CurrentRoom < trait.RoomsPerUpgrade.Amount then			
				UpdateTraitNumber( trait )
			else
				trait.CurrentRoom = 0			
				UpdateTraitNumber( trait )
				if trait.RoomsPerUpgrade.DropResources then
					GiveRandomConsumables( trait.RoomsPerUpgrade.DropResources )
				end
				if trait.RoomsPerUpgrade.MaxMana then
					local addedMana = round(trait.RoomsPerUpgrade.MaxMana)
					AddMaxMana( addedMana, trait.Name, { Thread = true, Delay = textDelay, Silent = true})
					totalAddedMana = totalAddedMana + addedMana
				end
				if trait.RoomsPerUpgrade.MaxHealth then
					local addedHealth = round(trait.RoomsPerUpgrade.MaxHealth)
					AddMaxHealth( addedHealth, trait.Name, { Thread = true, Delay = textDelay, Silent = true })
					totalAddedHealth = totalAddedHealth + addedHealth
				end
				if trait.RoomsPerUpgrade.TraitStacks then
					AddStackToTraits({ NumTraits = 1, NumStacks = trait.RoomsPerUpgrade.TraitStacks }) 
				end
				if  IsTraitActive(trait) and (( trait.RoomsPerUpgrade.Rarity and trait.HarvestBoons ) or ( trait.RoomsPerUpgrade.DowngradeRarity and trait.DowngradeTraitNames )) then
					table.insert( rarityTraits, trait )
				end
				if trait.RoomsPerUpgrade.TransformBlessing then
					transformBlessing = true
					transformBlessingRarity = trait.AcquireFunctionArgs.BlessingRarity
				end
			end
		end
	end

	if totalAddedHealth > 0  and totalAddedMana > 0 then
		thread(BonusHealthAndManaPresentation, totalAddedHealth, totalAddedMana )
	elseif totalAddedMana > 0 then
		thread(BonusManaPresentation, totalAddedMana )
	end

	if not IsEmpty(rarityTraits) then
		UpgradeHarvestBoon( rarityTraits )
	end

	if transformBlessing then
		local oldBlessing = nil
		local newBlessing = nil
		for i, traitData in pairs(CurrentRun.Hero.Traits) do
			if traitData.FromChaosKeepsake then
				oldBlessing = traitData
				break
			end
		end
		if oldBlessing then
			RemoveTraitData(CurrentRun.Hero, oldBlessing)
			newBlessing = AddRandomChaosBlessing( GetRarityKey(transformBlessingRarity ))
		end

		if oldBlessing and newBlessing then
			thread( ChaosTransformationPresentation, oldBlessing.CustomTitle, newBlessing.CustomTitle )
		end
	end
end

function UpgradeHarvestBoon( traitDatas )
	local upgradableTraitNames = {}
	local downgradeableTraitNames = {}
	local upgradableTraits = {}
	local downgradableTraits = {}
	local allUpgradableTraitNames = {}
	local allDowngradeableTraitNames = {}
	local refreshTraits = {}

	local targettedTraits = {}

	for _, traitData in pairs(traitDatas) do
		if traitData.RoomsPerUpgrade then
			if traitData.RoomsPerUpgrade.Rarity then
				for i, boonName in pairs(traitData.HarvestBoons) do
					if downgradeableTraitNames[boonName] then
						downgradeableTraitNames[boonName] = nil
					else
						upgradableTraitNames[boonName] = true
					end
				end
			elseif traitData.RoomsPerUpgrade.DowngradeRarity then
				for i, boonName in pairs(traitData.DowngradeTraitNames) do
					if upgradableTraitNames[boonName] then
						upgradableTraitNames[boonName] = nil
					else
						downgradeableTraitNames[boonName] = true
					end
				end
			end
		end
	end

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if  TraitData[traitData.Name] and traitData.Rarity ~= nil then
			if downgradeableTraitNames[traitData.Name] and GetDowngradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetDowngradedRarity(traitData.Rarity)] ~= nil then
				table.insert(downgradableTraits, traitData )
			end
			if upgradableTraitNames[traitData.Name] and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
				table.insert(upgradableTraits, traitData )
			end
		end

		if traitData.RoomsPerUpgrade then
			if traitData.RoomsPerUpgrade.Rarity then
				for i, boonName in pairs(traitData.HarvestBoons) do
					allUpgradableTraitNames[boonName] = true
				end
				table.insert(refreshTraits, traitData)
			elseif traitData.RoomsPerUpgrade.DowngradeRarity then
				for i, boonName in pairs(traitData.DowngradeTraitNames) do	
					allDowngradeableTraitNames[boonName] = true
				end
				table.insert(refreshTraits, traitData)
			end
		end
	end

	for index, targettedTraits in ipairs({downgradableTraits, upgradableTraits}) do
		if not IsEmpty( targettedTraits ) then		
			upgradedTraits = {}
			 while not IsEmpty( targettedTraits ) do
				local traitData = RemoveRandomValue( targettedTraits )
				local persistentValues = {}
				for i, key in pairs( PersistentTraitKeys ) do
					persistentValues[key] = traitData[key]
				end
				upgradedTraits[GetTraitTooltipTitle(traitData)] = true
				local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
				
				RemoveTraitData(CurrentRun.Hero, traitData, { SkipActivatedTraitUpdate = true })
				local processedData = nil
				if index == 1 then
					processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = numOldTrait, Rarity = GetDowngradedRarity(traitData.Rarity) }) 
				else
					processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = numOldTrait, Rarity = GetUpgradedRarity(traitData.Rarity) }) 
				end
				for i, key in pairs( PersistentTraitKeys ) do
					processedData[key] = persistentValues[key]
				end
				AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true })
			end

			if index == 1 then
				thread( ReducedTraitRarityPresentation, upgradedTraits, 2.0 )
			else
				thread( IncreasedTraitRarityPresentation, upgradedTraits, 2.0 )
			end
		end
	end
	
	local allDowngradableTraits = {}
	local allUpgradableTraits = {}
	
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if  TraitData[traitData.Name] and traitData.Rarity ~= nil then
			if allDowngradeableTraitNames[traitData.Name] and GetDowngradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetDowngradedRarity(traitData.Rarity)] ~= nil then
				table.insert(allDowngradableTraits, traitData )
			end
			if allUpgradableTraitNames[traitData.Name] and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
				table.insert(allUpgradableTraits, traitData )
			end
		end
	end
	CurrentRun.Hero.DowngradableTraitCountCache = TableLength(allDowngradableTraits)
	CurrentRun.Hero.UpgradeableTraitCountCache = TableLength(allUpgradableTraits)

	for _, traitData in pairs(refreshTraits) do
		if traitData.RoomsPerUpgrade then
			if traitData.RoomsPerUpgrade.DowngradeRarity and CurrentRun.Hero.DowngradableTraitCountCache == 0 then
				traitData.Uses = 0
				TraitUIRemove( traitData ) 
			end
			if traitData.RoomsPerUpgrade.Rarity and CurrentRun.Hero.UpgradeableTraitCountCache == 0 then
				traitData.Uses = 0
				TraitUIRemove( traitData ) 
			end
		end
	end

	for itemId, item in pairs( LootObjects ) do
		item.UpgradeOptions = nil
	end
end

function HasRarifiableTraits( args )
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity ~= nil 
			and ( ( GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil ) or ( args.TargetRarity ~= nil and traitData.RarityLevels[GetRarityKey(args.TargetRarity)] ~= nil ) )
			and ( args.MaxRarity == nil or GetRarityValue( traitData.Rarity ) <= args.MaxRarity ) then
			return true
		end
	end
end

function AddRarityToTraits( source, args )
	local numTraits = args.NumTraits
	local upgradableTraits = {}
	local upgradedTraits = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity ~= nil 
			and ( ( GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil ) or ( args.TargetRarity ~= nil and traitData.RarityLevels[GetRarityKey(args.TargetRarity)] ~= nil ) )
			and ( args.MaxRarity == nil or GetRarityValue( traitData.Rarity ) <= args.MaxRarity ) then
			table.insert(upgradableTraits, traitData )
		end
	end

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )
		local persistentValues = {}
		for i, key in pairs( PersistentTraitKeys ) do
			persistentValues[key] = traitData[key]
		end

		upgradedTraits[GetTraitTooltipTitle(traitData)] = true
		
		local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
		RemoveTraitData(CurrentRun.Hero, traitData, { SkipActivatedTraitUpdate = true })
		local targetRarity = GetUpgradedRarity(traitData.Rarity)
		if args.TargetRarity then
			targetRarity = GetRarityKey(args.TargetRarity)
		end
		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = numOldTrait, Rarity = targetRarity }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true })
		numTraits = numTraits - 1
	end

	thread( IncreasedTraitRarityPresentation, upgradedTraits )
end

function AddRandomBouldyBlessing( source, args )
	local traitName = GetRandomValue(args)
	AddTraitToHero({TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = "Common"}) })
	BouldyBlessingPresentation( traitName )
end

function GetNumUniqueWeaponUpgradesTaken( )
	local weaponUpgradesTaken = 0
	for traitName, hasBeenTaken in pairs(GameState.TraitsTaken) do
		if Contains(LootData.WeaponUpgrade.Traits, traitName) then
			weaponUpgradesTaken = weaponUpgradesTaken + 1
		end
	end
	return weaponUpgradesTaken
end

function GetRandomSacrificeTraitData()
	local sacrificeTrait = nil
	local traitDictionary = {}
	local validTraits = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if not traitDictionary[traitData.Name] 
			and IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] 
			and traitData.Rarity ~= nil 
			and not traitData.BlockSacrifice then
			table.insert(validTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end
	if not IsEmpty( validTraits ) then
		sacrificeTrait = RemoveRandomValue( validTraits )
	end
	return sacrificeTrait
end

function SacrificeBoon( args, sourceTraitData )
	args = args or {}
	local sacrificeTrait = nil
	if sourceTraitData.SacrificedTraitName then
		sacrificeTrait = GetHeroTrait( sourceTraitData.SacrificedTraitName )
	else
		sacrificeTrait = GetRandomSacrificeTraitData()
	end

	if sacrificeTrait then
		RemoveWeaponTrait( sacrificeTrait.Name )
		thread( HestiaSacrificePresentation, sacrificeTrait.Name )
	end
	for _, traitData in pairs(CurrentRun.Hero.Traits) do
		if AreTraitsIdentical(traitData, sourceTraitData) then
			if not sacrificeTrait or not sacrificeTrait.Name then
				traitData.SacrificedTraitName = "NothingEquipped"
			else
				traitData.SacrificedTraitName = sacrificeTrait.Name
			end
		end
	end
end