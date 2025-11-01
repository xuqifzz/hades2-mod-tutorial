
function RunTraitThreads(source)
	for index, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.DumbFireWeapons ~= nil then
			thread(DumbFireWeapon, source, trait.Name, trait.DumbFireWeapons)
		end
	end
end

function DumbFireWeapon(source, traitName, args)
	while UseTrait( CurrentRun.Hero, traitName ) do
		local randomStrikePointId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = RandomFloat(-1 * args.Radius, args.Radius), OffsetY = RandomFloat(-1 * args.Radius, args.Radius )})
		MapState.EquippedWeapons[args.Weapon] = true
		FireWeaponFromUnit({ Weapon = args.Weapon, AutoEquip = true, Id = source.ObjectId, DestinationId = randomStrikePointId, })
		Destroy({Id = randomStrikePointId})
		wait(RandomFloat(args.IntervalMin, args.IntervalMax))
	end
end

function CheckChillKill( args, attacker, victim, triggerArgs )
	if SessionMapState.FiredChillKill[victim.ObjectId] then
		return
	end
	
	if triggerArgs.SourceProjectile ~= args.ProjectileName and attacker == CurrentRun.Hero and HasEffectWithEffectGroup( victim, "Root" ) and victim.RootActive
		and not victim.IsDead and not victim.CannotDieFromDamage and victim.Health / victim.MaxHealth <= args.ChillDeathThreshold 
		and ( victim.Phases == nil or victim.CurrentPhase == victim.Phases ) then
		
		if args.ExecuteImmunities and args.ExecuteImmunities[victim.Name] and IsGameStateEligible( victim, args.ExecuteImmunities[victim.Name].GameStateRequirement ) then
			if not victim.ResistChillKillPresentation then
				victim.ResistChillKillPresentation = true
				BossResistChillKillPresentation( victim )
			end
			return
		end 
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
		if victim.UseBossHealthBar then
			CurrentRun.BossHealthBarRecord[victim.Name] = 0 -- Health bar won't get updated again normally
		end
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
				
				if propertyChange.DeriveValueFromMultiplier then
					if referencedPropertyValue.SourceIsMultiplier then
						local delta = referencedPropertyValue.ChangeValue - 1
						propertyChange.ChangeValue = 1 + delta * propertyChange.DeriveValueFromMultiplier
					else
						propertyChange.ChangeValue = referencedPropertyValue.ChangeValue * propertyChange.DeriveValueFromMultiplier
					end
				else
					propertyChange.ChangeValue = referencedPropertyValue.ChangeValue
				end
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
			if SessionState.AllKeepsakeUnlocked or data.GameStateRequirements == nil or IsGameStateEligible( traitData, data.GameStateRequirements ) then
				traitData.SignoffText = data.Text
				break
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
	local traitData = args.TraitData or DeepCopyTable( TraitData[traitName] )
	--DebugAssert({ Condition = traitData ~= nil, Text = "Unable to find trait data for: " .. tostring(traitName), Owner = "Alice" })
	if traitData == nil then
		return
	end

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
			rarityMultiplier = RandomFloat( rarityData.MinMultiplier, rarityData.MaxMultiplier )
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
		if not ProcessTraitDataBlacklist[key] and type( value ) == "table" and key ~= "PropertyChanges" and key ~= "ActivatedPropertyChanges" then
			local propertyRarityMultiplier = rarityMultiplier or 1
			traitData[key] = GetProcessedValue( value, { Rarity = rarity, RarityMultiplier = propertyRarityMultiplier, StackNum = stackNum, ForceMin = args.ForceMin }, key )
		end
	end

	if not IsEmpty( unit.Traits ) and traitData.RemainingUses ~= nil then
		for i, data in pairs( GetHeroTraitValues( "TraitDurationIncrease", { Unit = unit } ) ) do
			if data.ValidTraits == nil or Contains( data.ValidTraits, traitName ) then
				if traitData.RemainingUses ~= nil then
					traitData.RemainingUses = traitData.RemainingUses + data.Amount
				end
			end
		end
	end

	if traitData.PropertyChanges == nil and traitData.ActivatedPropertyChanges == nil then
		return traitData
	end

	local changes = {}
	if traitData.PropertyChanges ~= nil then
		table.insert( changes, "PropertyChanges" )
	end
	if traitData.ActivatedPropertyChanges ~= nil then
		table.insert( changes, "ActivatedPropertyChanges" )
	end

	for i, changeKey in ipairs( changes ) do
		local sortedTraitDataAtChangeKey = CollapseTableOrdered( traitData[changeKey] )
		for s, propertyChange in ipairs( sortedTraitDataAtChangeKey ) do
			if propertyChange.BaseMin ~= nil or propertyChange.BaseValue ~= nil then
				local propertyRarityMultiplier = rarityMultiplier or 1
				local newValue = GetProcessedValue( propertyChange, { Unit = unit, Rarity = rarity, RarityMultiplier = propertyRarityMultiplier, StackNum = stackNum, ForceMin = args.ForceMin }, changeKey )
				propertyChange.ChangeValue = newValue
			end
		end
	end
	return traitData
end

function GetProcessedValue( valueToRamp, args, key )
	args = args or {}
	local stackNum = args.StackNum or 0
	local rarityMultiplier = args.RarityMultiplier
	local unit = args.Unit

	if verboseLogging and type( valueToRamp ) ~= "table" then
		DebugAssert({ Condition = false, Text = "Calling GetProcessedValue on non-table value", Owner = "Gavin" })
	end
	rarityMultiplier = rarityMultiplier or 1
	if valueToRamp.CustomRarityMultiplier and args.Rarity then
		local rarityData = valueToRamp.CustomRarityMultiplier[args.Rarity]
		if rarityData then
			if rarityData.Multiplier ~= nil then
				rarityMultiplier = rarityData.Multiplier
			else
				rarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
			end
		end
	end
	if valueToRamp.MultipliedByElement then
		local elementTotal = 0
		if CurrentRun.Hero.Elements and CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement] then
			elementTotal = CurrentRun.Hero.Elements[valueToRamp.MultipliedByElement]
		end
		rarityMultiplier = rarityMultiplier * elementTotal
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
				if valueToRamp.IdenticalMultiplier and valueToRamp.IdenticalMultiplier.Value then
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

		return ProcessValue( value, valueToRamp )
	else
		local traitDataKVPs = CollapseTableAsOrderedKeyValuePairs( valueToRamp )
		for i, kvp in ipairs( traitDataKVPs ) do
			local key = kvp.Key
			local value = kvp.Value
			if not ProcessTraitDataBlacklist[key] and type( value ) == "table" then
				valueToRamp[key] = GetProcessedValue( value, args, key )
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

	for k, trait in ipairs( hero.Traits ) do
		if trait[propertyName] ~= nil then
			if args.Multiplicative then
				output = output * trait[propertyName]
			else
				output = output + (trait[propertyName] - offset)
			end
			if args.First then
				return
			end
		end
	end
	return output
end

function GetHeroTraitValues( propertyName, args )
	args = args or {}
	local hero = args.Unit or CurrentRun.Hero

	if CurrentRun.Hero.HeroTraitValuesCache[propertyName] and not args.UnlimitedOnly then
		return CurrentRun.Hero.HeroTraitValuesCache[propertyName]
	end

	local output = {}
	for k, trait in ipairs( hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil and ( not args.UnlimitedOnly or trait.RemainingUses == nil ) then
			table.insert( output, trait[propertyName] )
			if args.First then 
				break
			end
		end
	end
	if not args.UnlimitedOnly then
		CurrentRun.Hero.HeroTraitValuesCache[propertyName] = ShallowCopyTable( output )
	end
	return output
end

function HasHeroTraitValue( propertyName )
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil then
			return trait
		end
	end
	return nil
end

function UseHeroTraitsWithValue( propertyName, useFirst )
	local removedTraits = {}
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
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
			if trait.ZeroBonusTrayText then
				trait.CustomTrayText = trait.ZeroBonusTrayText
			end
		else
			RemoveTraitData( CurrentRun.Hero, trait, { SkipActivatedTraitUpdate = IsEmpty( trait.Elements ) } )
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
	if traitData == nil then
		return
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

	if traitData.MoneyMultiplier then
		if not IsEmpty( MapState.RoomRequiredObjects ) then
			for id, object in pairs( MapState.RoomRequiredObjects ) do
				if object.DropMoney then
					object.DropMoney = round( object.DropMoney * traitData.MoneyMultiplier )
				end
			end
		end
		if not IsEmpty( MapState.OptionalRewards ) then
			for id, object in pairs( MapState.OptionalRewards ) do
				if object.DropMoney then
					object.DropMoney = round( object.DropMoney * traitData.MoneyMultiplier )
				end
			end
		end
	end

	return newTrait
end

function GetHeroTrait( traitName )
	--if verboseLogging then
		--DebugAssert({ Condition = (CurrentRun.Hero.TraitDictionary[traitName] ~= nil), Text = "Trait " .. tostring(traitName) .. " not found on call to GetHeroTrait.", Owner = "Alice" })
	--end
	if CurrentRun.Hero.TraitDictionary[traitName] ~= nil then
		return CurrentRun.Hero.TraitDictionary[traitName][1]
	end
	return nil
end

function HeroHasTrait( traitName )
	if traitName == nil then
		return false
	end
	if CurrentRun.Hero.TraitDictionary[traitName] ~= nil then
		return true
	end
	return false
end

function HeroSlotFilled( slotName )
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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

function UpdateHeroTraitDictionary()

	CurrentRun.Hero.AllLinkedWeaponsCache = AddLinkedWeapons( GetAllKeys( CurrentRun.Hero.Weapons ) )
	SessionMapState.TorchSpecialCacheDirty = true
	SessionMapState.TorchPrimaryCacheDirty = true
	
	if IsEmpty( CurrentRun.Hero.Traits ) then
		CurrentRun.Hero.TraitDictionary = {}
		CurrentRun.Hero.SlottedTraits = {}
		CurrentRun.Hero.HeroTraitValuesCache = {}
		for key, value in pairs( PreCacheTraitValues ) do
			CurrentRun.Hero.HeroTraitValuesCache[key] = {}
		end
		CurrentRun.Hero.FirstTraitWithPropertyCache = {}
		CurrentRun.Hero.MetGods = {}
		CurrentRun.Hero.UniqueGodCount = 0
		CurrentRun.Hero.OlympianBoonCount = 0
		CurrentRun.Hero.HammerCount = 0
		CurrentRun.Hero.UpgradableTraitCount = 0
		CurrentRun.Hero.VisibleTraitCount = 0
		CurrentRun.Hero.VisibleNonHUDTraitCount = 0
		CurrentRun.Hero.EligiblePrevRunTraits = {}
		CurrentRun.Hero.Elements = {}
		for elementName in pairs(TraitElementData) do
			CurrentRun.Hero.Elements[elementName] = 0
		end
		CurrentRun.Hero.HighestBaseElementCount = 0
		CurrentRun.Hero.GodBoonRarities = {}
		for rarityName in pairs(TraitRarityData.RarityValues ) do
			CurrentRun.Hero.GodBoonRarities[rarityName] = 0
		end
		
		return
	end

	local cache = {}
	local slots = {}
	local heroTraitValuesCache = {}
	for key, value in pairs( PreCacheTraitValues ) do
		heroTraitValuesCache[key] = {}
	end
	local godDictionary = {}
	local olympianGodDictionary = {}
	local elements = {}
	local rarities = {}
	for elementName in pairs( TraitElementData ) do
		elements[elementName] = 0
	end
	for rarityName in pairs( TraitRarityData.RarityValues ) do
		rarities[rarityName] = 0
	end
	local hammerCount = 0
	local olympianBoonCount = 0
	local visibleTraitCount = 0
	local visibleNonHUDTraitCount = 0
	local metaUpgradeTraitCount = 0
	local upgradeableCount = 0
	CurrentRun.Hero.HighestBaseElementCount = 0
	CurrentRun.Hero.AllUpgradableHammers = true
	CurrentRun.Hero.UpgradableHammerCount = 0
	CurrentRun.Hero.HammerCount = 0

	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
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
		table.insert( cache[trait.Name], trait )

		for key, value in pairs( trait ) do
			if CurrentRun.Hero.HeroTraitValuesCache[key] ~= nil or PreCacheTraitValues[key] then
				heroTraitValuesCache[key] = heroTraitValuesCache[key] or {}
				table.insert( heroTraitValuesCache[key], value )
				if CurrentRun.Hero.FirstTraitWithPropertyCache[key] == nil then
					CurrentRun.Hero.FirstTraitWithPropertyCache[key] = trait
				end
			end
		end

		if not trait.Hidden then
			visibleTraitCount = visibleTraitCount + 1
			if not IsShownInHUD( trait ) then
				visibleNonHUDTraitCount = visibleNonHUDTraitCount + 1
			end
		end
		
		
		local godSource = GetGodSourceName( trait.Name, { ForShop = true }) 
		if godSource then
			godDictionary[godSource] = true
		end

		if IsGodTrait( trait.Name, {ForShop = true, ForLastRunBoon = true}) then
			olympianBoonCount = olympianBoonCount + 1
			olympianGodDictionary[godSource] = true
		end
		
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not trait.BlockStacking and ( not trait.RequiredFalseTrait or trait.RequiredFalseTrait ~= trait.Name ) then
			upgradeableCount = upgradeableCount + 1
		end

		if trait.LuckMultiplier and trait.ExtractData and trait.ExtractData.TooltipLuck then
			SessionMapState.DisplayedLuckMultiplier = trait.ExtractData.TooltipLuck 
		end
		if trait.OlympianRechargeMultiplier and trait.ExtractData and trait.ExtractData.RechargeMultiplier then
			SessionMapState.DisplayedRechargeMultiplier = trait.ExtractData.RechargeMultiplier 
		end

		if trait.IsHammerTrait then
			if not trait.RarityLevels or not trait.RarityLevels.Legendary then
				CurrentRun.Hero.AllUpgradableHammers = nil
			elseif trait.RemainingUses == nil then
				CurrentRun.Hero.UpgradableHammerCount = CurrentRun.Hero.UpgradableHammerCount + 1
			end
			hammerCount = hammerCount + 1
		end
	end
	CurrentRun.Hero.HeroTraitValuesCache = heroTraitValuesCache
	CurrentRun.Hero.TraitDictionary = cache
	CurrentRun.Hero.VisibleTraitCount = visibleTraitCount
	CurrentRun.Hero.VisibleNonHUDTraitCount = visibleNonHUDTraitCount
	CurrentRun.Hero.UniqueGodCount = TableLength( olympianGodDictionary )
	CurrentRun.Hero.MetGods = godDictionary
	CurrentRun.Hero.UpgradableTraitCount = upgradeableCount
	CurrentRun.Hero.Elements = elements
	CurrentRun.Hero.GodBoonRarities = rarities
	CurrentRun.Hero.SlottedTraits = slots
	CurrentRun.Hero.OlympianBoonCount = olympianBoonCount
	CurrentRun.Hero.HammerCount = hammerCount
	
	for element, count in pairs( CurrentRun.Hero.Elements ) do
		if count > CurrentRun.Hero.HighestBaseElementCount and TraitElementData[element].BaseElement then
			CurrentRun.Hero.HighestBaseElementCount = count
		end
	end

	local prevRun = GameState.RunHistory[#GameState.RunHistory]
	local eligiblePrevRunTraits = {}
	
	if prevRun and prevRun.TraitRarityCache then
		for traitName, rarity in pairs( prevRun.TraitRarityCache or {} ) do
			local traitData = TraitData[traitName] 
			if not HeroHasTrait(traitName) and IsGodTrait( traitName, {ForShop = true } ) and IsTraitEligible( traitData ) and ( not traitData.Slot or not HeroSlotFilled( traitData.Slot )) and not traitData.ExcludeTraitFromLastRunBoonPool then
				eligiblePrevRunTraits[traitName] = true
			end
		end
	end
	CurrentRun.Hero.EligiblePrevRunTraits = eligiblePrevRunTraits

	if HeroHasTrait("PolymorphCurseTalent") then
		local trait = GetHeroTrait("PolymorphCurseTalent")
		if trait.SetupFunction then
			thread( CallFunctionName, trait.SetupFunction.Name, CurrentRun.Hero, trait.SetupFunction.Args )
		end
	end
end

function CheckActivatedTraits( unit, args )
	args = args or {}
	if unit ~= CurrentRun.Hero then
		return
	end

	local activatedTraitNames = {}
	local deactivatedTraitNames = {}
	local upgradedTraitNames = {}
	local downgradedTraitNames = {}
	local scalingTraitIndexes = {}

	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		local traitData = TraitData[trait.Name]
		if traitData ~= nil and ( args.OnlyCheckTraitName == nil or trait.Name == args.OnlyCheckTraitName ) then
			if traitData.ActivationRequirements ~= nil and IsTraitActive(traitData) then
				local isEligible = IsGameStateEligible( trait, traitData.ActivationRequirements )
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
					local isEligible = IsGameStateEligible( trait, requirements )
					if isEligible and not trait.Activated[i] then
						trait.Activated[i] = true
						table.insert( activatedTraitNames, trait.Name )
					elseif not isEligible and trait.Activated[i] then
						trait.Activated[i] = false
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
				local info = { Name = trait.Name, ExpectedMultiplier = expectedMultiplier }
				table.insert(scalingTraitIndexes, info)
			end
		end
		
	end
	for i, data in pairs( scalingTraitIndexes ) do
		local expectedMultiplier = data.ExpectedMultiplier
		local trait = GetHeroTrait( data.Name )
		local startingMultiplier = trait.ElementalMultiplier or 0
		local newtrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, StackNum = trait.StackNum, Rarity = trait.Rarity })
		newtrait.ElementalMultiplier = expectedMultiplier
		newtrait.StackNum = trait.StackNum
		AddTraitData( CurrentRun.Hero, newtrait, { SkipActivatedTraitUpdate = true, SkipNewTraitHighlight = true})
		RemoveTraitData(CurrentRun.Hero, trait, { SkipActivatedTraitUpdate = true })
		if expectedMultiplier > startingMultiplier then
			table.insert( upgradedTraitNames, trait.Name )
		elseif expectedMultiplier < startingMultiplier then
			table.insert( downgradedTraitNames, trait.Name )
		end
	end
	if not args.SkipPresentation and (not IsEmpty(activatedTraitNames) or not IsEmpty(deactivatedTraitNames) or not IsEmpty(upgradedTraitNames) or not IsEmpty(downgradedTraitNames) or ( args.NewTrait ~= nil and args.NewTrait.ShowElementGain ) ) then
		thread( SetupElementalTraitUpdatedPresentation, activatedTraitNames, deactivatedTraitNames, upgradedTraitNames, downgradedTraitNames )
		if args.NewTrait ~= nil and args.NewTrait.ShowElementGain then
			UIScriptsDeferred.ElementalPresentationData.Gained = args.NewTrait.Name
		end
	end
end

function AddTrait( unit, traitName, rarity, args )
	args = args or {}
	local traitData = GetProcessedTraitData({ Unit = unit, TraitName = traitName, Rarity = rarity })
	if args and args.Id then
		traitData.Id = args.Id
	end
	if args.OverwriteSlot then
		traitData.Slot = nil
		traitData.ActiveSlotOffsetIndex = nil
	end
	ExtractValues( unit, traitData, traitData )
	return AddTraitData( unit, traitData, args )
end

function AddTraitData( unit, traitData, args )
	if traitData == nil then
		return
	end
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
		thread( CallFunctionName, newTrait.AcquireFunctionName, newTrait.AcquireFunctionArgs, newTrait, args)
		RemoveStoreItemPin( newTrait.Name )
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
		if showingTrait ~= nil and IsShownInHUD( showingTrait ) and not args.SkipAddToHUD then
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
			TraitUIActivateTrait( GetExistingUITrait(newTrait) , { FlashOnActive = true, Duration = traitData.StartingTime })
			if (IsBiomeTimerPaused() or HasTimerBlock( CurrentRun )) and newTrait.TraitActiveOverlay then
				SetAnimationFrameTarget({ Name = "ActiveTraitCooldownNoFlash", Fraction = 0, DestinationId = newTrait.TraitActiveOverlay, Instant = true })
			end
		end

		if HeroHasTrait("DodgeChanceBoon") then
			local trait = GetHeroTrait("DodgeChanceBoon")
			if trait.CallSetupOnTraitAdded then
				CallFunctionName(trait.SetupFunction.Name, CurrentRun.Hero, trait.SetupFunction.Args)
			end
		end
		
		if not args.SkipNewTraitHighlight and not args.SkipAddToHUD then
			thread( HUDTraitAddedPresentation, newTrait, args )
		end
	end
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
	
	if newTrait.AddOutgoingDamageModifiersArray then
		if unit.OutgoingDamageModifiers == nil then
			unit.OutgoingDamageModifiers = {}
		end
		for i, sourceData in pairs( newTrait.AddOutgoingDamageModifiersArray ) do
			local data = DeepCopyTable( sourceData )
			data.Name = newTrait.Name..i
			table.insert( unit.OutgoingDamageModifiers, data )
		end
	end
	if newTrait.AddOutgoingCritModifiers then
		if unit.OutgoingCritModifiers == nil then
			unit.OutgoingCritModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddOutgoingCritModifiers )
		data.Name = newTrait.Name
		table.insert( unit.OutgoingCritModifiers, data )
	end
	if newTrait.AddOutgoingDoubleDamageModifiers  then
		local data = DeepCopyTable( newTrait.AddOutgoingDoubleDamageModifiers )
		data.Name = newTrait.Name
		AddOutgoingDoubleDamageModifier( unit, data )
	end

	if unit == CurrentRun.Hero then
		ProcessHeroTraitChanges( traitData )
		if not args.SkipActivatedTraitUpdate then
			CheckActivatedTraits( unit, { NewTrait = newTrait } )
		end
		if traitData.MaxManaToMaxHealthConversion then
			local startingHealth = CurrentRun.Hero.MaxHealth
			ValidateMaxHealth()
			MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease", Delay = 1.5  })
			FrameState.RequestUpdateHealthUI = true
			for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
				local thresholdData = traitData.LowHealthThresholdText
				if thresholdData ~= nil and thresholdData.Threshold ~= nil and CurrentRun.Hero.Health > thresholdData.Threshold and startingHealth <= thresholdData.Threshold then
					TraitUIDeactivateTrait( traitData )
				end
			end
		end
		if traitData.ManaCostModifiers then
			UpdateWeaponMana()
		end
		local startingMana = CurrentRun.Hero.MaxMana
		local startingHealth = CurrentRun.Hero.MaxHealth
			
		if traitData.MaxHealthMultiplier and traitData.MaxManaMultiplier then
			ValidateMaxMana()
			ValidateMaxHealth()
			thread( UpdateManaMeterUI )
			FrameState.RequestUpdateHealthUI = true
			thread( BonusHealthAndManaPresentation,  CurrentRun.Hero.MaxHealth - startingHealth, CurrentRun.Hero.MaxMana - startingMana, 1.5)
		elseif traitData.MaxHealthMultiplier then
			ValidateMaxHealth()
			MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease", Delay = 1.5  })
			FrameState.RequestUpdateHealthUI = true
		elseif traitData.MaxManaMultiplier then
			ValidateMaxMana()
			thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "MaxManaIncrease", PreDelay = 1.5, Duration = 0.7, LuaKey = "TooltipData", ShadowScale = 0.7, OffsetY = -100, LuaValue = { TooltipMana = CurrentRun.Hero.MaxMana - startingMana }})
			thread( UpdateManaMeterUI )
		end

		ClampSprintSpeed( unit )
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

	if unit == CurrentRun.Hero then
		local hasManaChanges = false
		if traitData.WeaponDataOverride then
			for weapon, changeData in pairs(traitData.WeaponDataOverride) do
				if changeData.ManaChanges then
					hasManaChanges = true	
					break
				end
			end
			if hasManaChanges then
				UpdateWeaponMana()
			end
		end
	end
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
			if setupFunctionData.RequiredContext == args.Context or setupFunctionData.RequiredContext == "StartRoom" then
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
	if traitData.WeaponDataOverrideTraitRequirement and not HeroHasTrait(traitData.WeaponDataOverrideTraitRequirement) then
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
		if not IsEmpty(weaponData.ChargeWeaponStages) then
			unit.WeaponDataOverride[weaponName].ChargeWeaponStages = DeepCopyTable(weaponData.ChargeWeaponStages)
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
	if trait == nil then
		return
	end
	args = args or {}
	local traitName = trait.Name
	CurrentRun.Hero.LastRemovedTraitName = traitName
	RemoveValueAndCollapse( unit.Traits, trait )
	if unit == CurrentRun.Hero then
		ProcessHeroTraitChanges( trait, true )
		ClampSprintSpeed( unit )
	else
		ApplyUnitPropertyChanges( unit, trait.PropertyChanges, true, true )
	end
	if not HeroHasTrait(trait.Name) then
		Destroy({ Id = unit.TraitAnimationAnchors[traitName]})
	end
	if unit == CurrentRun.Hero and not args.SkipUIUpdate then
		UpdateHeroTraitDictionary()
		TraitUIRemove( trait )
		RemoveHealthBufferSource( trait.Name )

		if trait.WeaponAmmoModification then		
			ResetAmmo( CurrentRun.Hero, GetWeaponData( CurrentRun.Hero, trait.WeaponAmmoModification.Name ))
		end
	end
	
	if unit == CurrentRun.Hero and not args.SkipActivatedTraitUpdate then

		if trait.OverrideWeaponFireNames then
			for weaponName, overriddenWeaponName in pairs( trait.OverrideWeaponFireNames ) do
				if overriddenWeaponName ~= "nil" then
					SwapWeapon({ Name = weaponName, SwapWeaponName = overriddenWeaponName, DestinationId = unit.ObjectId, StompOriginalWeapon = true })
				end
			end
		end
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

	if trait.AddIncomingDamageModifiers then
		RemoveIncomingDamageModifier( unit, trait.Name )
	end
	if trait.AddOutgoingDamageModifiers then
		RemoveOutgoingDamageModifier( unit, trait.Name )
	end
	if trait.AddOutgoingDamageModifiersArray then
		for i, sourceData in pairs( trait.AddOutgoingDamageModifiersArray ) do
			RemoveOutgoingDamageModifier( unit, trait.Name .. i)
		end
	end
	if trait.AddOutgoingCritModifiers then
		RemoveOutgoingCritModifier( unit, trait.Name )
	end
	if trait.AddOutgoingDoubleDamageModifiers then
		RemoveOutgoingDoubleDamageModifier( unit, trait.Name )
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
		if expiringActions.RemoveReservedMana then
			UnreserveMana( expiringActions.RemoveReservedMana )	
			thread( UpdateManaMeterUI )
		end
		if expiringActions.Traits then
			for i, onExpireTraitName in pairs(expiringActions.Traits) do
				AddTrait(unit, onExpireTraitName, nil, { Id = trait.Id })
			end
		end
		if expiringActions.TraitData then
			thread( HeroTraitTransformPresentation, trait )
			expiringActions.TraitData.CustomTitle = trait.TraitTitle
			expiringActions.TraitData.Id = trait.Id
			AddTraitData( unit, expiringActions.TraitData, {FromLoot = true} )
		end
		if expiringActions.AddMetaUpgrades then
			EquipMetaUpgrades( CurrentRun.Hero, {} )
			if HeroHasTrait("MetaToRunMetaUpgrade") then
				local trait = GetHeroTrait("MetaToRunMetaUpgrade")
				local metaConversionUses = CurrentRun.MetaConversionUses or 0
				trait.MetaConversionUses = trait.MetaConversionUses - metaConversionUses
			end
		end
		if expiringActions.RecheckBoons then
			if HeroHasTrait("ElementalRarityUpgradeBoon") then
				local trait = GetHeroTrait("ElementalRarityUpgradeBoon")
				if trait.Activated then
					thread( UpgradeAllCommon, trait.OnActivationFunction.Args, trait )
				end
			end
		end
		if expiringActions.SpawnShopItem then
			if not args.Silent then
				thread( HeroShopDeliveryPresentation, trait )
			end
			local spawnPointId = SelectSurfaceItemSpawnPoint()
			local rewardItem = SpawnStoreItemInWorld( expiringActions.SpawnShopItem, spawnPointId )
			if rewardItem ~= nil then
				if not rewardItem.NeverForceRequired then
					MapState.RoomRequiredObjects[rewardItem.ObjectId] = rewardItem
				end
				rewardItem.IgnorePurchase = true
				rewardItem.BlockBoughtTextLines = true
				rewardItem.IgnoreRoomRarityBonus = true
			end
			if not args.Silent then
				thread( SurfaceShopItemPresentation, spawnPointId )
			end
		end
		if expiringActions.FunctionName then
			thread( CallFunctionName, expiringActions.FunctionName, expiringActions.FunctionArgs, trait )
		end

		-- Act on properties after properties have changed
		if expiringActions.HealAmount ~= nil then
			Heal( unit, { HealAmount = expiringActions.HealAmount * CalculateHealingMultiplier(), Name = traitName.."Expire" } )
			FrameState.RequestUpdateHealthUI = true
		end
		if expiringActions.HealFraction ~= nil then
			Heal( unit, { HealFraction = expiringActions.HealFraction * CalculateHealingMultiplier(), Name = traitName.."Expire" } )
			FrameState.RequestUpdateHealthUI = true
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
	local loggedUses = false
	if trait.Uses then
		trait.Uses = trait.Uses - 1
		LogTraitUses( trait.Name )
		loggedUses = true
	end
	if trait.Slot == "Keepsake" and args.Force or (( (trait.Uses and trait.Uses <= 0) or (trait.RemainingUses and trait.RemainingUses <= 0)) and not trait.DoesNotAutomaticallyExpire ) then
		CurrentRun.ExpiredKeepsakes[trait.Name] = true
		if not loggedUses then
			LogTraitUses( trait.Name )
		end
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

	if traitData.RemainingUses ~= nil and traitData.RemainingUses <= 0 then
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
	local weaponKeys = { "PreEquipWeapons", }
	for i, weaponKey in ipairs( weaponKeys ) do
		if traitData[weaponKey] ~= nil then
			for i, weaponName in pairs( traitData[weaponKey] ) do
				EquipWeapon({ Name = weaponName, DestinationId = CurrentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages[weaponName] })
				MapState.EquippedWeapons[weaponName] = true
			end
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
						thread( CallFunctionName, setupFunctionData.Name, unit, setupFunctionData.Args, args, trait )
					else
						CallFunctionName( setupFunctionData.Name, unit, setupFunctionData.Args, args, trait )
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

function GetGodSourceName( traitName, args)
	args = args or {}
	for i, god in pairs(LootData) do
		if ( god.GodLoot or ( args.ForShop and god.TreatAsGodLootByShops )) and ( not args.ForLastRunBoon or not god.ExcludeFromLastRunBoon) and not god.DebugOnly and god.TraitIndex[traitName] then
			return god.Name
		end
	end
	for i, god in pairs(FieldLootData) do
		if god.TraitIndex[traitName] and ( god.GodLoot or ( args.ForShop and god.TreatAsGodLootByShops )) and ( not args.ForLastRunBoon or not god.ExcludeFromLastRunBoon) then
			return god.Name
		end
	end
end

function GetLootSourceName( traitName, args )
	args = args or {}
	for lootName, god in pairs(LootData) do
		if ( god.GodLoot or god.TreatAsGodLootByShops or args.ForBoonInfo ) and not god.DebugOnly and god.TraitIndex[traitName] then
			return lootName
		end
	end
	if TraitData[traitName] and TraitData[traitName].LootSource then
		return TraitData[traitName].LootSource
	end
	if args.CheckEnemyData then
		for enemyName, enemyData in pairs(EnemyData) do
			if Contains(enemyData.Traits, traitName) then
				if not args.GetPackageName then
					return enemyData.Name
				elseif enemyData.PackageName ~= nil then
					return enemyData.PackageName
				end
			end
		end
	end
	return nil
end

function UpgradableGodTraitCountAtLeast( num )
	local count = 0
	local traitNames = {}
	local slots = slots or {}
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and ( IsEmpty(slots) or not trait.Slot or slots[trait.Slot] ) and IsGodTrait(trait.Name) and not traitNames[trait.Name] and not trait.BlockInRunRarify and trait.Rarity ~= nil and GetUpgradedRarity(trait.Rarity) ~= nil and trait.RarityLevels[GetUpgradedRarity(trait.Rarity)] ~= nil then
			traitNames[ trait.Name ] = true
			count = count + 1
			if count >= num then
				return true
			end
		end
	end
	return false
end

function HasSuperchargeableBoon( source )
	local count = 0
	local traitNames = {}
	local slots = slots or {}
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and ( IsEmpty(slots) or not trait.Slot or slots[trait.Slot] ) and IsGodTrait(trait.Name) and not traitNames[trait.Name] and not trait.BlockInRunRarify and trait.Rarity ~= nil and GetUpgradedRarity(trait.Rarity) ~= nil and trait.RarityLevels[GetUpgradedRarity(trait.Rarity)] ~= nil and not trait.BlockStacking then
			traitNames[ trait.Name ] = true
			return true
		end
	end
	return false
end

function PommableSlottedTraitCountAtLeast( source, args )
	args = args or {}
	local num = args.Count or 1
	local slots = args.Slots
	local count = 0
	local traitNames = {}
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.Slot and slots[trait.Slot] then
			local startingStackNum = trait.StackNum or 1
			local upgradedTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, Rarity = trait.Rarity, StackNum = startingStackNum + 1 })
			ExtractValues( CurrentRun.Hero, upgradedTrait, upgradedTrait )
			if not trait.ExtractData then
				ExtractValues( CurrentRun.Hero, trait, trait )
			end
			local sameValues = true
			for key, value in pairs( upgradedTrait.ExtractData ) do
				if trait.ExtractData ~= nil and trait.ExtractData[key] ~= value then
					sameValues = false
					break
				end
			end
			if not sameValues then
				count = count + 1
			end
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
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not trait.BlockStacking then
			local startingStackNum = trait.StackNum or 1
			local upgradedTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, Rarity = trait.Rarity, StackNum = startingStackNum + stackNum })
			ExtractValues( CurrentRun.Hero, upgradedTrait, upgradedTrait )
			if not trait.ExtractData then
				ExtractValues( CurrentRun.Hero, trait, trait )
			end
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
		if IsTraitEligible( TraitData[traitName] ) then
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

function CalcNumLootChoices( lootData )
	local isGodLoot = lootData.GodLoot
	local treatAsGodLootByShops = lootData.TreatAsGodLootByShops
	local numChoices = ScreenData.UpgradeChoice.MaxChoices
	if (isGodLoot or treatAsGodLootByShops) and HasHeroTraitValue("RestrictBoonChoices") and not lootData.IgnoreRestrictBoonChoices then
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
		lootData.IgnoreTempRarityBonus = lootData.IgnoreTempRarityBonus or args.IgnoreTempRarityBonus
		lootData.IgnoreAllRarityBonus = lootData.IgnoreAllRarityBonus or args.IgnoreAllRarityBonus
		lootData.IgnoreRoomRarityBonus = lootData.IgnoreRoomRarityBonus or args.IgnoreRoomRarityBonus
		if args.BoonRaritiesOverride then
			lootData.BoonRaritiesOverride = ShallowCopyTable( args.BoonRaritiesOverride )
		end
		lootData.RarityChances = GetRarityChances( lootData )
		if not lootData.IgnoreTempRarityBonus then
			lootData.RarityBoosted = true
		end
	end
	if args.BlockRarities then
		for rarityName in pairs( args.BlockRarities ) do
			lootData.RarityChances[rarityName] = 0
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
	elseif IsGameStateEligible( lootData, CurrentRun.Hero.BoonData.GameStateRequirements ) and RandomChance( CurrentRun.Hero.BoonData.ReplaceChance ) and not lootData.ForceCommon then
		upgradeOptions = GetReplacementTraits( lootData.PriorityUpgrades )
	end

	if IsEmpty( upgradeOptions ) then
		upgradeOptions = GetPriorityTraits( lootData.PriorityUpgrades, lootData )
	else
		for i, upgradeOption in pairs( upgradeOptions ) do
			local traitData = TraitData[upgradeOption.ItemName]
			if traitData.GameStateRequirements == nil or IsGameStateEligible( traitData, traitData.GameStateRequirements ) then
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

	lootData.Rarity = {}
	lootData.RarityRollOrder = lootData.RarityRollOrder or TraitRarityData.BoonRarityRollOrder

	if lootData.Traits then
		for _, traitName in pairs( lootData.Traits ) do
			local traitData = TraitData[traitName]
			if ( traitData.GameStateRequirements == nil or IsGameStateEligible( traitData, traitData.GameStateRequirements )) and traitData.PriorityRequirements and IsGameStateEligible( traitData, traitData.PriorityRequirements) then
				local rarity = "Common"
				for _, rarityName in ipairs( lootData.RarityRollOrder ) do
					if traitData.RarityLevels[rarityName] and lootData.RarityChances and lootData.RarityChances[rarityName] and RandomChance( lootData.RarityChances[rarityName] ) then
						rarity = rarityName
					end
				end
				table.insert( upgradeOptions, { ItemName = traitName, Type = "Trait", Rarity = rarity })
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
	
	if curTable == nil then
		curTable = topLevelTable
	end

	local tableToIterate = curTable
	if depth == 0 then
		-- topLevelTable is being written to by reportValues which can invalidate the iteration
		tableToIterate = ShallowCopyTable( curTable )
	end

	if tableToIterate == nil then
		return
	end

	for key, value in pairs( tableToIterate ) do
		if type( value ) == "table" and key ~= "ReportValues" then
			if depth >= 20 then
				DebugAssert({ Condition = false, Text = " ExtractValues overflow detected on (" .. tostring(topLevelTable.Name) .. ") with path " .. key, Owner = "Alice" })
			end
			ExtractValues( unit, topLevelTable, value, depth + 1 )
		end		
	end

	if depth >= 1 then
		if curTable.ReportValues ~= nil then
			for key, value in pairs( curTable.ReportValues ) do
				if curTable[value] ~= nil then
					topLevelTable[key] = curTable[value]
				end
			end
		end
	else			
		if topLevelTable.ExtractValues ~= nil then
			-- back at the top level table, about to exit. Finish final formatting steps.
			local traitExtractedData = {}
			for i, extractData in ipairs( topLevelTable.ExtractValues ) do
				ExtractValue( CurrentRun.Hero, traitExtractedData, topLevelTable, extractData )
			end
			topLevelTable.ExtractData = traitExtractedData
		end
	end
end

function ExtractValue( unit, extractToTable, table, extractData )
	
	local value = nil
	if extractData.External then
		if verboseLogging then
			DebugAssert({ Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name.", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property.", Owner = "Alice" })
		end
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
		elseif extractData.BaseType == "RunResourceGained" then
			if CurrentRun and CurrentRun.ResourcesGained[extractData.BaseName] then
				value = CurrentRun.ResourcesGained[extractData.BaseName]
			else
				value = 0
			end
		elseif extractData.BaseType == "TraitData" then
			if not HeroHasTrait(extractData.BaseName) then
				value = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = extractData.BaseName })
			else
				value = GetHeroTrait(extractData.BaseName)
			end
			for i, key in ipairs(extractData.BaseProperty) do
				value = value[key]
			end
		else
			DebugAssert({ Condition = false, Text = "Trying to find an external value on unsupported type " .. extractData.BaseType, Owner = "Alice" })
		end
	elseif extractData.Format == "TotalDamageTaken" then
		if CurrentRun and CurrentRun.Hero.IsDead  then
			value = 0
		else
			value = CurrentRun.TotalDamageTaken or 0
		end
	elseif extractData.Format == "EasyModeMultiplier" then
		value = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	elseif extractData.Format == "ManaSpendCost" then
		local weaponData = WeaponData[extractData.WeaponName]
		if table and table.ForBoonInfo then
			value = weaponData.ManaSpendCost
			if weaponData.LinkedTraitManaSpendAdjustment then
				local level = GetWeaponUpgradeLevel(weaponData.LinkedTraitManaSpendAdjustment)
				local traitData = TraitData[weaponData.LinkedTraitManaSpendAdjustment]
				local multiplier = traitData.RarityLevels[GetRarityKey( level, TraitRarityData.WeaponRarityUpgradeOrder )].Multiplier
				value = value + traitData.ManaSpendCostModifiers.Add.BaseValue * multiplier
			end
		else
			value = GetManaSpendCost( weaponData )
		end
	elseif extractData.Format == "AdjustedBaseManaSpendCost" then
		local weaponData = WeaponData[extractData.WeaponName]
		local keyToExtract = extractData.Key
		if table[keyToExtract] == nil then
			DebugAssert({ Condition = false, Text = "Attempting to extract nonexistent key "..keyToExtract.." from ".. tostring(table.Name), Owner = "Alice" })
			return
		end
		value = weaponData.ManaSpendCost + table[keyToExtract]
	elseif extractData.Format == "SlottedBoon" then
		value = "Blank"
	elseif extractData.Format == "FinalBoss" then
		value = "Blank"
	elseif extractData.Format == "TotalHeroTraitValuePercent" then
		value = GetTotalHeroTraitValue( extractData.Key ) * 100
	elseif extractData.Format == "TotalHeroTraitValue" then
		value = GetTotalHeroTraitValue( extractData.Key )
	elseif extractData.Format == "ResourceAmount" then
		value = GetResourceAmount( extractData.Key )
	else
		if extractData.Key == nil then
			extractData.Key = "ChangeValue"
		end
		local keyToExtract = extractData.Key
		if table[keyToExtract] == nil then
			DebugAssert({ Condition = false, Text = "Attempting to extract nonexistent key "..keyToExtract.." from ".. tostring(table.Name), Owner = "Alice" })
			return
		end
		value = table[keyToExtract]
		if extractData.Format == "MaxHealth" then
			value = GetMaxHealthUpgradeIncrement( value )
		end
		if extractData.Format == "MaxHealthIgnoreCap" then
			value = GetMaxHealthUpgradeIncrement( value, true )
		end
		if extractData.Format == "MaxMana" then
			value = GetMaxManaUpgradeIncrement( value )
		end
	end
	
	if ( extractData.CheckAutomaticPropertyChanges or extractData.External ) and AutomaticExtractProperties[extractData.ExtractAs] then
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
		elseif extractData.Format == "MultiplyByBaseOverTime" then
			DebugAssert({ Condition = extractData.BaseType ~= nil, Text = "Extracting a MultiplyByBaseOverTime value without valid type reference (Projectile, Weapon, or WeaponEffect)", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseName ~= nil, Text = "Extracting a MultiplyByBaseOverTime value without a name.", Owner = "Alice" })
			DebugAssert({ Condition = extractData.BaseProperty ~= nil, Text = "Extracting a MultiplyByBaseOverTime value without a property.", Owner = "Alice" })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			local fuse =  GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseFuseProperty })
			
			value = (value * baseDataValue) / fuse
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
		elseif extractData.Format == "FlatHealBonusOnly" then
			if CalculateHealingMultiplier() > 1 then
				value = value * CalculateHealingMultiplier()
			end
		elseif extractData.Format == "PercentHeal" then
			value = value * CalculateHealingMultiplier()
			value = value * 100
		elseif extractData.Format == "SpeedModifiedDuration" then
			value = value * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
		elseif extractData.Format == "LuckModifiedPercent" then
			value = value * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })
			value = value * 100
			if value > 100 then
				value = 100
			end
		elseif extractData.Format == "UniqueGodPercentDelta" and CurrentRun.Hero then
			value = ( value - 1 ) * CurrentRun.Hero.UniqueGodCount * 100
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
		elseif extractData.Format == "MultipliedMoney" then
			return 	round( value * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ))
		elseif extractData.Format == "TimesOneHundred" then
			return value * 100
		elseif extractData.Format == "TimesOneHundredPercent" then
			return value * 100 * 100
		elseif extractData.Format == "MultipliedConsumableResource" then
			if ConsumableData[extractData.BaseName] then
				value = value * ConsumableData[extractData.BaseName].AddResources[extractData.ResourceName]
			end
		elseif extractData.Format == "SlottedBoon" then
			if CurrentRun.Hero.SlottedTraits[extractData.Slot] then
				return CurrentRun.Hero.SlottedTraits[extractData.Slot]
			else
				return "None_In_Slot"
			end
		elseif extractData.Format == "FinalBoss" then
			if not CurrentRun or CurrentRun.Hero.IsDead or IsEmpty(CurrentRun.BiomesReached) then
				return "CharChronos"
			elseif CurrentRun.BiomesReached.F then 
				return "CharChronos"
			elseif CurrentRun.BiomesReached.N then
				return "CharTyphon"
			else
				return "CharChronos"
			end
		elseif extractData.Format == "RemainingBiomes" then
			local clearedBiomes = CurrentRun.ClearedBiomes or 0 
			value = math.min(4 - clearedBiomes, value)
		end
	end
	if extractData.MultiplyByMissingHealth then
		value = value * (CurrentRun.Hero.MaxHealth - CurrentRun.Hero.Health)
	end
	if extractData.MultiplyByOlympianBoonCount then
		value = value * CurrentRun.Hero.OlympianBoonCount
	end
	if extractData.MultiplyByMissingLastStands and CurrentRun.Hero.MaxLastStands and TableLength( CurrentRun.Hero.LastStands ) then
		value = value * (CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands ))
	end
	if extractData.MultiplyBySpentLastStands then
		if CurrentRun.Hero.LastStandsUsed  then
			value = value * CurrentRun.Hero.LastStandsUsed
		else
			value = 0
		end
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
		SetTraitTextData( args.ReplacementTraitData )
	end
	-- needs to be ordered properly @alice
	traitData.Additional = {}
	traitData.OldTotal = {}
	traitData.NewTotal = {}
	traitData.PercentIncrease = {}
	local extractedIndex = 0
	if traitData.ExtractValues ~= nil then
		for i, data in ipairs( traitData.ExtractValues ) do
			local key = data.ExtractAs
			if data.Subtractor then
				traitData.ExtractData[key] = traitData.ExtractData[key] - traitData.ExtractData[data.Subtractor]
			end
			if data.Multiplier1 then
				local baseValue = traitData.ExtractData[data.Multiplier1] * traitData.ExtractData[data.Multiplier2]

				
				traitData.ExtractData[key] =  FormatExtractedValue(baseValue / traitData.ExtractData[data.Key], data)
			end
			if data.Negative then
				traitData.ExtractData[key] = -traitData.ExtractData[key]
			end
			if data.Format == "LuckModifiedPercent" and GetTotalHeroTraitValue("LuckMultiplier", { IsMultiplier = true }) > 1 then
				traitData.AddLuckTooltip = true
			end
			if data.Format == "SpeedModifiedDuration" and GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true }) < 1 then
				traitData.AddSpeedTooltip = true
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
	if args.TraitName then
		upgradableTraits[args.TraitName] = true
	else
		upgradableTraits = GetAllUpgradeableGodTraits( numStacks )
	end

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local name = GetRandomKey( upgradableTraits )
		upgradedTraits[name] = true
		local traitData = GetHeroTrait(name)
		if not traitData.BlockStacking then
			for s = 1, numStacks do
				IncreaseTraitLevel( traitData )
			end
		end
		numTraits = numTraits - 1
		upgradableTraits[name] = nil
	end

	UpdateHeroTraitDictionary()

	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if upgradedTraits[traitData.Name] then
			wait(0.1)
			TraitUIUpdateText( traitData )
		end
	end
	if not args.Silent then
		thread( IncreasedTraitLevelPresentation, upgradedTraits, numStacks )
	end
end

function IncreaseTraitLevel( traitData, stacks )
	stacks = stacks or 1
	for i, currentTraitData in ipairs( CurrentRun.Hero.Traits ) do
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

			if traitData.StacksAddBeforeRemove then
				-- Causes UI issues, but necessary for traits that grant increased max health per level
				AddTraitToHero({ TraitData = newTrait, SkipNewTraitHighlight = true, SkipActivatedTraitUpdate = true, SkipSetup = true })
				RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true, SkipExpire = true })
			else
				RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true, SkipExpire = true })
				AddTraitToHero({ TraitData = newTrait, SkipNewTraitHighlight = true, SkipActivatedTraitUpdate = true, SkipSetup = true })
			end
			if newTrait.OnLevelOrRarityChangeFunctionName then
				thread( CallFunctionName, newTrait.OnLevelOrRarityChangeFunctionName, newTrait, currentTraitData )
			end
			return newTrait
		end
	end
	
	return traitData
end
function ChaosHammerUpgrade( args )
	args = args or {}
	local hammerTraits = {}
	local eligibleHammerTraits = {}
	local addedTraits = {}
	local numTraits = args.NumTraits or 2
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if LootData.WeaponUpgrade.TraitIndex[trait.Name] then
			table.insert(hammerTraits, trait.Name )
			if not trait.RemainingUses then
				table.insert(eligibleHammerTraits, trait.Name )
			end
		end
	end

	-- remove one weapon trait
	local removedTraitName = nil
	if not IsEmpty( eligibleHammerTraits ) then
		removedTraitName = RemoveRandomValue( eligibleHammerTraits )
		RemoveWeaponTrait( removedTraitName )
	end

	for i = 1, numTraits do
		local validTraitNames = {}
		for i, traitName in pairs( LootData.WeaponUpgrade.Traits ) do
			if IsTraitEligible( TraitData[traitName] ) and traitName ~= removedTraitName and not Contains(hammerTraits, traitName) then
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
		args.NumStacks = args.NumStacks
		if IsFateValid() then 
			args.NumStacks = args.NumStacks + GetTotalHeroTraitValue("FatedPomLevelBonus")
		end
	end
	thread(AddStackToTraits, args )
	InvalidateCheckpoint()
	StoreRewardRandomStackPresentation()
end

function UpgradeAllCommon( args, origTraitData )
	local sourceTraitData = nil
	local traitDictionary = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	local delay = args.PresentationDelay
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( origTraitData, traitData ) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		elseif not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name, { ForShop = true }) and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity == "Common" then
			table.insert(upgradableTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end
	
	while not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )
		if traitData.Name == "BoonDecayBoon" then
			-- Kludge to make space for BoonDecayBoon's CreditMissingStacks presentation
			delay = delay + 1.5
		end
		upgradedTraits[traitData.Name] = true
		local numOldTrait = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
		RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true, SkipExpire = true })
		local persistentValues = {}
		for i, key in pairs( PersistentTraitKeys ) do
			persistentValues[key] = traitData[key]
		end

		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, StackNum = numOldTrait, TraitName = traitData.Name, Rarity = args.RarityUpgrade or "Epic" }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		processedData = AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true, SkipSetup = true })

		if processedData.OnLevelOrRarityChangeFunctionName then
			thread( CallFunctionName, processedData.OnLevelOrRarityChangeFunctionName, processedData, traitData, 1 )
		end
	end
	sourceTraitData.Rarity = args.RarityUpgrade or "Epic"
	thread( IncreasedTraitRarityPresentation, upgradedTraits, delay )
	if sourceTraitData and args.ActivatedValues then
		for name, data in pairs( args.ActivatedValues ) do
			sourceTraitData[name] = DeepCopyTable( data )
			if CurrentRun.Hero.HeroTraitValuesCache then
				CurrentRun.Hero.HeroTraitValuesCache[name] = nil
			end
		end
	end	
	if HeroHasTrait("CommonGlobalDamageBoon") then
		local trait = GetHeroTrait("CommonGlobalDamageBoon")
		if not trait.Activated then
			CheckActivatedTraits( CurrentRun.Hero, { OnlyCheckTraitName = trait.Name } )
		end
	end
end

function GrantBoons( args, originalTraitData )
	local addedTraits = {}
	for _, boonNames in pairs( args.BoonSets ) do
		local eligibleTraits = {}
		for s, traitName in pairs( boonNames ) do
			if not HeroHasTrait( traitName ) then
				table.insert(eligibleTraits, traitName )
			end
		end
		if not IsEmpty(eligibleTraits) then
			local traitName  = GetRandomValue( eligibleTraits )
			AddTraitToHero({ TraitName = traitName, FromLoot = true, SkipActivatedTraitUpdate = true })
			addedTraits[traitName] = true
		end
	end
	thread( BoonGrantedPresentation, addedTraits, 2.0 )
	
	CheckActivatedTraits( CurrentRun.Hero, { SkipPresentation = true } )
end

function SacrificeAllBoon( args, origTraitData )

	local traitDictionary = {}
	local validTraits = {}
	local buffTraits = {}
	local totalLevels = 0
	local sourceTraitData = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if AreTraitsIdentical( traitData, origTraitData) then
			sourceTraitData = CurrentRun.Hero.Traits[i]
		end
		if not traitDictionary[traitData.Name] 
			and IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] 
			and traitData.Rarity ~= nil then
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

function DistributeLevels( args, origTraitData )
	local eligibleTraits = {}
	for _, slotName in pairs( args.Slots ) do
		if CurrentRun.Hero.SlottedTraits[slotName] then
			table.insert(eligibleTraits, CurrentRun.Hero.SlottedTraits[slotName] )
		end
	end
	local levelsToDistribute = args.LevelBonus
	eligibleTraits = FYShuffle( eligibleTraits )
	while levelsToDistribute > 0 and not IsEmpty( eligibleTraits ) do
		local condemnedTraits = {}
		for _, traitName in ipairs(eligibleTraits) do
			local trait = GetHeroTrait( traitName )
			local startingStackNum = trait.StackNum or 1
			local upgradedTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, Rarity = trait.Rarity, StackNum = startingStackNum + 1 })
			ExtractValues( CurrentRun.Hero, upgradedTrait, upgradedTrait )
			if not trait.ExtractData then
				ExtractValues( CurrentRun.Hero, trait, trait )
			end
			local sameValues = true
			for key, value in pairs( upgradedTrait.ExtractData ) do
				if trait.ExtractData ~= nil and trait.ExtractData[key] ~= value then
					sameValues = false
					break
				end
			end
			if sameValues then
				table.insert(condemnedTraits, traitName )
			else
				IncreaseTraitLevel( trait )
				levelsToDistribute = levelsToDistribute - 1
				if levelsToDistribute <= 0 then
					return
				end
			end
		end
		for _, traitName in pairs(condemnedTraits) do
			RemoveValueAndCollapse(eligibleTraits, traitName)
		end
	end
end

function UpgradeAspect( args, origTraitData )
	args = args or {}
	local currentWeaponName = GetEquippedWeapon()
	local currentWeaponData = WeaponData[currentWeaponName]

	local traitName = GameState.LastWeaponUpgradeName[currentWeaponName]
	if traitName == nil then
		traitName = ScreenData.WeaponUpgradeScreen.FreeUnlocks[currentWeaponName]
	end
	if not traitName then
		return
	end

	if traitName and HeroHasTrait( traitName ) then
		RemoveTrait( CurrentRun.Hero, traitName )
	end

	local numRanks = GetWeaponUpgradeLevel( traitName ) + args.UpgradeLevels
	local rarity = TraitRarityData.WeaponRarityUpgradeOrder[numRanks]
	AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = traitName, Rarity = rarity })
end

function HeraSuperchargeBoon ( args, origTraitData, contextArgs )
	contextArgs = contextArgs or {}
	local traitData = AddRarityToTraits( origTraitData, { NumTraits = 1, TargetRarity = 4, MaxRarity = 3, StackEligibleOnly = true, Silent = true } )
	if not traitData then
		traitData = AddRarityToTraits( origTraitData, { NumTraits = 1, TargetRarity = 4, Silent = true } )
	end
	if not traitData.BlockStacking then
		thread(AddStackToTraits, { TraitName = traitData.Name, NumStacks = args.Stacks, Silent = true })
		IncreaseTraitLevel( traitData, args.Stacks )
	end
	
	origTraitData.UpgradedTraitName = traitData.Name
	thread( HeraTraitRarityPresentation, traitData.Name, args.Stacks, contextArgs.Delay )
end

function CreditMissingStacks( traitData, oldTraitData, delay )
	if not oldTraitData.UpgradedTraitName or not HeroHasTrait( oldTraitData.UpgradedTraitName ) or TraitData[oldTraitData.UpgradedTraitName].BlockStacking then
		return
	end
	local freshTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = traitData.RarityMultiplier})
	local originalTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = oldTraitData.RarityMultiplier})
	
	local newAmount = freshTrait.AcquireFunctionArgs.Stacks
	local oldAmount = originalTrait.AcquireFunctionArgs.Stacks
	local stacksToAdd = newAmount - oldAmount
	thread( CreditMissingStacksThread, GetHeroTrait(oldTraitData.UpgradedTraitName), stacksToAdd, delay )
end

function CreditMissingStacksThread( traitData, stacksToAdd, delay  )
	wait(0.5)
	thread(AddStackToTraits, { TraitName = traitData.Name, NumStacks = stacksToAdd, Silent = true })
	IncreaseTraitLevel( traitData, stacksToAdd)
	HeraTraitRarityPresentation( traitData.Name, stacksToAdd, delay )
end

function CreditAccumulatedTime( traitData, oldTraitData, delay )
	if oldTraitData.RoomsPerUpgrade and oldTraitData.RoomsPerUpgrade.Amount and oldTraitData.CurrentRoom then
		local lastRemaining = oldTraitData.RoomsPerUpgrade.Amount - oldTraitData.CurrentRoom
		if lastRemaining < traitData.RoomsPerUpgrade.Amount then
			local trait = GetHeroTrait( traitData.Name )
			trait.CurrentRoom = traitData.RoomsPerUpgrade.Amount - lastRemaining
			UpdateTraitNumber( trait )
		end
	end
end

function UpdateUpgradableTraitCount( args, traitData)
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.RoomsPerUpgrade and traitData.RoomsPerUpgrade.Rarity then
			local count = 0
			if traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
				count = count + 1
			end
			CurrentRun.Hero.UpgradableTraitCount = count
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
	for i, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.RoomsPerUpgrade then
			
			IncrementTableValue( trait, "CurrentRoom" )
			if trait.RoomsPerUpgrade.Amount and trait.CurrentRoom < trait.RoomsPerUpgrade.Amount then			
				UpdateTraitNumber( trait )
			else
				trait.CurrentRoom = 0			
				if trait.RoomsPerUpgrade.DropResources then
					if CurrentRun.CurrentRoom.SkipTimedDropResources then
						trait.CurrentRoom = trait.RoomsPerUpgrade.Amount - 1		
					else
						GiveRandomConsumables( trait.RoomsPerUpgrade.DropResources )
					end
				end
				UpdateTraitNumber( trait )
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
					thread(AddStackToTraits, { NumTraits = 1, NumStacks = trait.RoomsPerUpgrade.TraitStacks }) 
				end
				if trait.RoomsPerUpgrade.Rarity then
					AddRarityToTraits(trait, { NumTraits = 1, LowPriorityTraitName = trait.RoomsPerUpgrade.LowPriorityTraitName })
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

	if transformBlessing then
		local oldBlessing = nil
		local newBlessing = nil
		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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
		
		if LootObjects then
			for itemId, item in pairs( LootObjects ) do
				if IsAlive({ Id = itemId }) then
					if not IsRarityForcedCommon( item.Name ) then
						RandomSynchronize()
						item.RarityChances = GetRarityChances( item )
					end
					item.UpgradeOptions = nil
				end
			end
		end
	end
end

function HasRarifiableTraits( args )
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait(traitData.Name, { ForShop = true }) 
			and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity ~= nil 
			and ( ( GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil ) or ( args.TargetRarity ~= nil and traitData.RarityLevels[GetRarityKey(args.TargetRarity)] ~= nil ) )
			and ( args.MaxRarity == nil or GetRarityValue( traitData.Rarity ) <= args.MaxRarity ) then
			return true
		end
	end
end

function AddRarityToTraits( source, args )
	local args = args or {}
	local lastUpgradedTrait = nil
	local numTraits = args.NumTraits
	local upgradableTraits = {}
	local upgradedTraits = {}
	if not IsEmpty(args.ForceUpgrade) then
			upgradableTraits = ShallowCopyTable( args.ForceUpgrade )
	
		numTraits = TableLength( upgradableTraits )
	else
		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if IsGodTrait(traitData.Name, { ForShop = true }) 
				and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity ~= nil 
				and ( ( GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil ) or ( args.TargetRarity ~= nil and traitData.RarityLevels[GetRarityKey(args.TargetRarity)] ~= nil ) )
				and ( args.MaxRarity == nil or GetRarityValue( traitData.Rarity ) <= args.MaxRarity )
				and ( args.StackEligibleOnly == nil or (IsGodTrait(traitData.Name) and not traitData.BlockStacking)) then
				table.insert(upgradableTraits, traitData)
			end
		end
	end

	if args.LowPriorityTraitName and TableLength( upgradableTraits ) > 1 then
		for i, traitData in pairs( upgradableTraits ) do
			if traitData.Name == args.LowPriorityTraitName then
				RemoveValue( upgradableTraits, traitData )
				break
			end
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
		RemoveTraitData(CurrentRun.Hero, traitData, { SkipActivatedTraitUpdate = true, SkipExpire = true  })
		local targetRarity = GetUpgradedRarity(traitData.Rarity)
		if args.TargetRarity then
			targetRarity = GetRarityKey(args.TargetRarity)
		elseif args.TargetRarityName then
			targetRarity = args.TargetRarityName
		end
		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = numOldTrait, Rarity = targetRarity }) 
		for i, key in pairs( PersistentTraitKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true, SkipSetup = true })
		
		if processedData.OnLevelOrRarityChangeFunctionName then
			thread( CallFunctionName, processedData.OnLevelOrRarityChangeFunctionName, processedData, traitData )
		end
		numTraits = numTraits - 1

		lastUpgradedTrait = processedData
	end
	if not args.Silent then
		thread( IncreasedTraitRarityPresentation, upgradedTraits, args.Delay )
	end
	CheckActivatedTraits( CurrentRun.Hero, { OnlyCheckTraitName = "CommonGlobalDamageBoon" })
	
	if LootObjects then
		for itemId, item in pairs( LootObjects ) do
			if IsAlive({ Id = itemId }) and ( not ScreenAnchors.ChoiceScreen or ScreenAnchors.ChoiceScreen.Source ~= item ) then
				item.UpgradeOptions = nil
			end
		end
	end

	InvalidateCheckpoint()
	return lastUpgradedTrait
end

function AddRandomBouldyBlessing( source, args )
	local traitName = GetRandomValue(args)
	AddTraitToHero({TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = "Common"}) })
	BouldyBlessingPresentation( traitName )
end

function ValidateTraitData()
	if not verboseLogging then
		return
	end
	local allowedUnreferenced =
	{
		AirEssence = true,
		ErisCurseTrait = true,
		FallbackGold = true,
		FireEssence = true,
		EarthEssence = true,
		ElementalEssence = true,
		GodModeTrait = true,
		LimitedSwapBonusTrait = true,
		ManaOverTimeRefundTrait = true,
		MinorArmorBoon = true,
		PersistentDionysusSkipKeepsake = true,
		RestedFamiliarResourceBonus = true,
		RoomRewardMaxManaTrait = true,
		RoomRewardMaxHealthTrait = true,
		RoomRewardEmptyMaxHealthTrait = true,
		StorePendingDeliveryItem = true,
		SurfacePenalty = true,
		UnusedWeaponBonusTrait = true,
		UnusedWeaponBonusTrait2 = true,
		VanillaState = true,
		WaterEssence = true,
		WetState = true,
		DummyBloodDisplayBoon = true,
		BaseDummyWeapon  = true,
		OlympianSpellCountTalent = true,
		InfernalContractBoon = true,
	}
	for traitName, traitData in pairs( TraitData ) do
		if not traitData.DebugOnly and not allowedUnreferenced[traitName] then
			local found = false
		
			-- BoonInfo?
			if not found then
				for _, dict in pairs( ScreenData.BoonInfo.TraitDictionary ) do
					if dict[traitName] then
						found = true
						break
					end
				end
			end

			-- BaseAspect?
			if not found then
				for baseName, baseAspect in pairs( ScreenData.GameStats.WeaponBaseAspectMapping ) do
					if baseAspect == traitName then
						found = true
						break
					end
				end
			end

			-- Aspect?
			if not found then
				for _, data in pairs( ScreenData.WeaponUpgradeScreen.DisplayOrder ) do
					for _, name in ipairs( data ) do
						if name == traitName then
							found = true
							break
						end
					end
				end
			end

			-- MetaUpgrade?
			if not found then
				for _, data in pairs( MetaUpgradeCardData ) do
					if data.TraitName == traitName then
						found = true
						break
					end
				end
			end

			-- Keepsake?
			if not found then
				for _, data in pairs( GiftData ) do
					if data[1] ~= nil and data[1].Gift == traitName then
						found = true
						break
					end
				end
			end

			-- Familiar trait?
			if not found then
				for _, data in pairs( FamiliarData ) do
					if Contains( data.TraitNames, traitName ) then
						found = true
						break
					end
				end
			end

			DebugAssert({ Condition = found, Text = traitName.." is not referenced by LootData, SpellData, MetaUpgradeCardData, GiftData, or FamiliarData", Owner = "Alice" })
		end
	end
end
