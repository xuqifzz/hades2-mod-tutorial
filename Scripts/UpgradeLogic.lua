function ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse, skipWeaponUpdates)

	if propertyChange.LegalWeapons ~= nil then
		if not Contains( propertyChange.LegalWeapons, weaponName ) then
			return
		end
	end

	if propertyChange.LegalWeapon ~= nil then
		if propertyChange.LegalWeapon ~= weaponName then
			return
		end
	end

	if propertyChange.LegalUnits ~= nil then
		if not Contains( propertyChange.LegalUnits, unit.Name ) then
			return
		end
	end
	
	if propertyChange.TraitName ~= nil then
		if not HeroHasTrait(propertyChange.TraitName) then
			return
		end
	end
	if propertyChange.TraitNames ~= nil then
		for i, traitName in pairs(propertyChange.TraitNames) do
			if not HeroHasTrait(traitName) then
				return
			end
		end
	end
	if propertyChange.FalseTraitName ~= nil then
		if HeroHasTrait(propertyChange.FalseTraitName) then
			return
		end
	end
	if propertyChange.FalseTraitNames ~= nil then
		for _, traitName in pairs( propertyChange.FalseTraitNames ) do
			if HeroHasTrait(traitName) then
				return
			end
		end
	end

	local changeValue = propertyChange.ChangeValue
	if reverse then
		if propertyChange.ChangeType == "Multiply" then
			changeValue = 1 / changeValue
		elseif propertyChange.ChangeType == "Add" then
			changeValue = 0 - changeValue
		elseif type(changeValue) == "boolean" then
			changeValue = not changeValue
		else
			return
		end
	end

	if propertyChange.WeaponProperty ~= nil then
		local wasWeaponCharging = false
		if not skipWeaponUpdates and propertyChange.WeaponProperty == "ChargeTime" and GetWeaponChargeFraction({ Name = weaponName }) > 0 then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = unit.ObjectId, Property = "ChargeTimeRemaining", Value = changeValue, ValueChangeType = propertyChange.ChangeType, DataValue = false })
			wasWeaponCharging = true
		end
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = unit.ObjectId, Property = propertyChange.WeaponProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
		if not skipWeaponUpdates and propertyChange.WeaponProperty == "ChargeTime" and not wasWeaponCharging then
			RunWeaponMethod({ Id = unit.ObjectId, Weapon = weaponName, Method = "cancelCharge"})
		end
		
		if not skipWeaponUpdates and propertyChange.WeaponProperty == "ClipSize" then
			RunWeaponMethod({ Id = unit.ObjectId, Weapon = "WeaponBlink", Method = "forceReload" })
		end
	end
	if propertyChange.ProjectileProperty ~= nil then
		SetProjectileProperty({ WeaponName = weaponName, ProjectileName = propertyChange.ProjectileName, ExcludeProjectileName = propertyChange.ExcludeProjectileName, DestinationId = unit.ObjectId, Property = propertyChange.ProjectileProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end
	if propertyChange.EffectProperty ~= nil then
		SetEffectProperty({ WeaponName = weaponName, EffectName = propertyChange.EffectName, DestinationId = unit.ObjectId, Property = propertyChange.EffectProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons and not propertyChange.ExcludeLinked then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			--DebugPrint({ Text = "Applying linked upgrade to "..linkedWeaponName, LogOnly = true })
			if MapState.EquippedWeapons[linkedWeaponName] then
				ApplyWeaponPropertyChange( unit, linkedWeaponName, propertyChange, reverse, skipWeaponUpdates )
			end
		end
	end
end

function ApplyUnitPropertyChanges( unit, propertyChanges, applyLuaUpgrades, reverse, skipWeaponUpdates )

	if propertyChanges == nil then
		return
	end

	for k, propertyChange in ipairs( propertyChanges ) do
		ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse, skipWeaponUpdates )
	end
end

function ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse, skipWeaponUpdates )
	if propertyChange.LegalUnits ~= nil then
		if not Contains( propertyChange.LegalUnits, unit.Name ) then
			return
		end
	elseif unit.SkipModifiers then
		return
	end

	if propertyChange.TraitName ~= nil then
		if not HeroHasTrait(propertyChange.TraitName) then
			return
		end
	end

	local changeValue = propertyChange.ChangeValue
	if reverse then
		if type(changeValue) == "number" then
			if propertyChange.ChangeType == "Multiply" then
				changeValue = 1 / changeValue
			elseif propertyChange.ChangeType == "Add" then
				changeValue = 0 - changeValue
			end
		elseif type(changeValue) == "boolean" then
			changeValue = not changeValue
		else
			return
		end
	end

	if propertyChange.ThingProperty ~= nil then
		SetThingProperty({ DestinationId = unit.ObjectId, Property = propertyChange.ThingProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end
	if propertyChange.LifeProperty ~= nil then
		ApplyLifePropertyChange( unit, propertyChange, changeValue )
	end
	if propertyChange.UnitProperty ~= nil then
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = propertyChange.UnitProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end

	if applyLuaUpgrades and propertyChange.LuaProperty ~= nil and ( unit[propertyChange.LuaProperty] ~= nil or propertyChange.ChangeType == "Absolute" ) then
		local delta = nil
		if propertyChange.LuaProperty == "MaxHealth" and propertyChange.MaintainDelta and unit.Health ~= nil and unit.MaxHealth ~= nil then
			delta = changeValue
		end

		if propertyChange.LuaTable ~= nil then
			if propertyChange.ChangeType == "Absolute" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = changeValue
			elseif propertyChange.ChangeType == "Multiply" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = unit[propertyChange.LuaTable][propertyChange.LuaProperty] * changeValue
			elseif propertyChange.ChangeType == "Add" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = unit[propertyChange.LuaTable][propertyChange.LuaProperty] + changeValue
			elseif type(changeValue) == "boolean" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = not unit[propertyChange.LuaTable][propertyChange.LuaProperty]
			end
		else
			if propertyChange.ChangeType == "Absolute" then
				unit[propertyChange.LuaProperty] = changeValue
			elseif propertyChange.ChangeType == "Multiply" then
				unit[propertyChange.LuaProperty] = unit[propertyChange.LuaProperty] * changeValue
			elseif propertyChange.ChangeType == "Add" then
				unit[propertyChange.LuaProperty] = unit[propertyChange.LuaProperty] + changeValue
			elseif type(changeValue) == "boolean" then
				unit[propertyChange.LuaProperty] = not unit[propertyChange.LuaProperty]
			end
		end

		if propertyChange.LuaProperty == "MaxHealth" then
			if ( changeValue < 0 and propertyChange.ChangeType == "Add" ) or ( propertyChange.ChangeType == "Multiply" and changeValue < 1 ) then
				local currentHealth = unit.Health
				local maxHealth = unit.MaxHealth
				if currentHealth ~= nil and maxHealth ~= nil then

					if propertyChange.MaintainDelta then
						if propertyChange.ChangeType == "Add" then
							if delta < 0 then
								SacrificeHealth({SacrificeHealth = math.abs(delta), MinHealth = 1, Silent = true, DeductHealth = true})
							else
								Heal( unit, { HealAmount = delta, SourceName = "MaxLifeChange", Silent = true})
							end
							currentHealth = math.max( 1, currentHealth + delta )
						else
							currentHealth = currentHealth * changeValue
							SacrificeHealth({SacrificeHealth = math.abs(unit.Health - currentHealth), MinHealth = 1, Silent = true, DeductHealth = true})
						end
					end

					if currentHealth > maxHealth then
						unit.Health = maxHealth
					end
				end
			elseif not propertyChange.BlockHealing then
				if ( changeValue > 0 and propertyChange.ChangeType == "Add" ) then
					Heal( unit, { HealAmount = changeValue, Silent = true })
				elseif ( changeValue > 1 and propertyChange.ChangeType == "Multiply" ) then
					local currentHealth = unit.Health
					if currentHealth ~= nil then
						Heal( unit, { HealAmount = currentHealth * (changeValue - 1), Silent = true })
					end
				end
			end
		end
		if propertyChange.LuaProperty == "MaxHealth" or propertyChange.LuaProperty == "Health" then
			ValidateMaxHealth( propertyChange.BlockHealing )
			FrameState.RequestUpdateHealthUI = true
		end
		if propertyChange.LuaProperty == "MaxMana" then
			CurrentRun.Hero.Mana = CurrentRun.Hero.Mana + changeValue
			ValidateMaxMana()
			thread( UpdateManaMeterUI )
			if HasHeroTraitValue("MaxManaToMaxHealthConversion") then
				ValidateMaxHealth()
				FrameState.RequestUpdateHealthUI = true
			end
		end
	end

	if propertyChange.WeaponName ~= nil then
		if MapState.EquippedWeapons[propertyChange.WeaponName] then
			ApplyWeaponPropertyChange( unit, propertyChange.WeaponName, propertyChange, reverse, skipWeaponUpdates )
		end
	end

	if propertyChange.WeaponNames ~= nil then
		for k, weaponName in pairs( propertyChange.WeaponNames ) do
			if MapState.EquippedWeapons[weaponName] then	
				ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse, skipWeaponUpdates )
			end
		end
	end

end

function ApplyLifePropertyChange( unit, propertyChange, changeValue )
	SetLifeProperty({ DestinationId = unit.ObjectId, Property = propertyChange.LifeProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType, DataValue = propertyChange.DataValue })
end

function ApplyAllTraitWeapons( hero )
	for k, traitData in pairs( hero.Traits ) do
		if traitData.ReplacementGrannyModels ~= nil then
			for originalModel, attachmentModel in pairs(traitData.ReplacementGrannyModels) do
				SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = hero.ObjectId })
			end
		end
	end
end

function ClampSprintSpeed( hero )
	if not hero or not hero.ObjectId then
		return
	end
	local weaponName = "WeaponSprint"
	local baseSprintVelocity = GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = "SelfVelocity" })
	local currentSprintVelocity = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "SelfVelocity" })
	if currentSprintVelocity and currentSprintVelocity > baseSprintVelocity * HeroData.SpeedMultiplierCap then
		SetWeaponProperty({ 
			WeaponName = weaponName,
			DestinationId = hero.ObjectId,
			Property = "SelfVelocity",
			Value = baseSprintVelocity * HeroData.SpeedMultiplierCap,
		})	
	end
	-- For feel changes sometimes the cap is intentionally lower than the speed cap, so it has to be checked separately
	local baseSprintCap = GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = "SelfVelocityCap" })
	local currentSprintVelocityCap = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "SelfVelocityCap" })
	if currentSprintVelocityCap and currentSprintVelocityCap > baseSprintCap * HeroData.SpeedMultiplierCap then
		SetWeaponProperty({ 
			WeaponName = weaponName,
			DestinationId = hero.ObjectId,
			Property = "SelfVelocityCap",
			Value = baseSprintCap * HeroData.SpeedMultiplierCap,
		})
	end
	local baseSpeed = GetBaseDataValue({ Type = "Unit", Name = "_PlayerUnit", Property = "Speed" })
	local currentSpeed = GetUnitDataValue({ Id = hero.ObjectId, Property = "Speed" })
	if currentSpeed and currentSpeed > baseSpeed * HeroData.SpeedMultiplierCap then
		SetUnitProperty({
			DestinationId = hero.ObjectId,
			Property = "Speed",
			Value = baseSpeed * HeroData.SpeedMultiplierCap,
		})
	end
end

function RecordTraitPropertyChange( traitName, propertyChange, weaponName )
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges
	local changeRecorded = false
	if not weaponName then 
		weaponName = propertyChange.WeaponName
	end
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if weaponData and weaponData.PropertyChangeSwap then
		for propertyName, data in pairs(weaponData.PropertyChangeSwap) do
			if propertyChange[propertyName] then
				if data[propertyChange.ProjectileProperty] then
					propertyChange.ProjectileProperty = data[propertyChange.ProjectileProperty]
				end
			end	
		end
	end
	propertyChange.ParentTraitName = traitName
	if propertyChange.WeaponProperty then
		weaponPropertyChanges[weaponName] = weaponPropertyChanges[weaponName] or { }
		weaponPropertyChanges[weaponName][propertyChange.WeaponProperty] = weaponPropertyChanges[weaponName][propertyChange.WeaponProperty] or {}
		table.insert( weaponPropertyChanges[weaponName][propertyChange.WeaponProperty], propertyChange )
		changeRecorded = true
	elseif propertyChange.ProjectileProperty then
		projectilePropertyChanges[weaponName] = projectilePropertyChanges[weaponName] or {}
		projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty] = projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty]or {}
		table.insert( projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty],  propertyChange )
		changeRecorded = true
	elseif propertyChange.EffectProperty then
		effectPropertyChanges[weaponName] = effectPropertyChanges[weaponName] or {}
		effectPropertyChanges[weaponName][propertyChange.EffectName] = effectPropertyChanges[weaponName][propertyChange.EffectName]or {}
		effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty] = effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty] or {}
		table.insert( effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty],  propertyChange )
		changeRecorded = true
	elseif propertyChange.WeaponProperties or propertyChange.ProjectileProperties or propertyChange.SpeedPropertyChanges then
		changeRecorded = true
	end
	if not changeRecorded then
		DebugAssert({ Condition = changeRecorded, Text = "Unable to record property change in " .. traitName .. ":" .. weaponName })
	end
end
function RemoveTraitPropertyChange( traitName, propertyChange, weaponName )
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges
	local changeRecorded = false
	if not weaponName then 
		weaponName = propertyChange.WeaponName
	end
	if propertyChange.WeaponProperty then
		weaponPropertyChanges[weaponName] = weaponPropertyChanges[weaponName] or { }
		weaponPropertyChanges[weaponName][propertyChange.WeaponProperty] = weaponPropertyChanges[weaponName][propertyChange.WeaponProperty] or {}
		DeleteMatchingPropertyChange(weaponPropertyChanges[weaponName][propertyChange.WeaponProperty], traitName)
		
		changeRecorded = true
	elseif propertyChange.ProjectileProperty then
		projectilePropertyChanges[weaponName] = projectilePropertyChanges[weaponName] or {}
		projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty] = projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty]or {}
		DeleteMatchingPropertyChange(projectilePropertyChanges[weaponName][propertyChange.ProjectileProperty], traitName)
		
		changeRecorded = true
elseif propertyChange.EffectProperty and propertyChange.EffectName then
		effectPropertyChanges[weaponName] = effectPropertyChanges[weaponName] or {}
		effectPropertyChanges[weaponName][propertyChange.EffectName] = effectPropertyChanges[weaponName][propertyChange.EffectName] or {}
		effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty] = effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty] or {}
		DeleteMatchingPropertyChange(effectPropertyChanges[weaponName][propertyChange.EffectName][propertyChange.EffectProperty], traitName)
		changeRecorded = true
	elseif propertyChange.WeaponProperties or propertyChange.ProjectileProperties or propertyChange.SpeedPropertyChanges then
		changeRecorded = true
	end
	if not changeRecorded and not SessionState.PatchingTraits then
		DebugAssert({ Condition = changeRecorded, Text = "Unable to delete property change in " .. traitName .. ":" .. weaponName, Owner = "Alice" })
	end
end

function DeleteMatchingPropertyChange( array, traitName )local toDelete = {}
		for _, existingPropertyChange in pairs (array) do
			if existingPropertyChange.ParentTraitName == traitName then
				table.insert( toDelete, existingPropertyChange )
			end
		end
		for i, deletedChange in pairs( toDelete ) do
			RemoveValueAndCollapse(array, deletedChange )
		end
end

function GetPropertyOrderingValue( propertyNameA, propertyNameB )

	local valueA = PropertyOrderingValuesLookup[propertyNameA] or 0
	local valueB = PropertyOrderingValuesLookup[propertyNameB] or 0

	return valueA < valueB
end

function GetTraitOrderingValue( trait )
	-- The higher the value the later it is applied
	if TraitMainWeaponSlots[trait.Slot] then
		return 50
	elseif trait.CastFlatFuseModifier then
		return 42
	elseif trait.CastModifier then
		return 41
	elseif trait.Slot == "Ranged" then
		return 40
	elseif trait.ApplyAfterHammerTraits then
		return  32
	elseif trait.IsHammerTrait then
		if trait.IsPriorityHammerTrait then
			return 29
		end
		if trait.IsLastPriorityHammerTrait then
			return 31
		end
		if trait.IsPriorityHammerModifierTrait then
			return 31
		end
		return 30
	elseif trait.RelativeSprintModifier then
		return 21
	elseif trait.SpellModifier then
		return 20
	elseif trait.IsMetaUpgrade then
		return 10
	elseif trait.Slot == "Spell" then
		return 0
	end

	return -1
end

function TraitOrderingSort( itemA, itemB )
	local parentTraitA = itemA.ParentTraitName
	local parentTraitB = itemB.ParentTraitName
	
	local traitAValue = TraitData[parentTraitA].TraitOrderingValueCache or GetTraitOrderingValue( TraitData[parentTraitA] )
	local traitBValue = TraitData[parentTraitB].TraitOrderingValueCache or GetTraitOrderingValue( TraitData[parentTraitB] )
	if  traitAValue ~= traitBValue then
		return traitAValue < traitBValue
	else	
		return parentTraitA < parentTraitB
	end
end

function ReorderPropertyChanges ( propertyChanges )
	local newList = {}
	local iterations = 0
	local lastTraitName = ""	

	table.sort( propertyChanges, TraitOrderingSort )
	local referencedTraits = {}
	for i, propertyChange in ipairs( propertyChanges ) do
		referencedTraits[propertyChange.ParentTraitName] = true
	end

	while TableLength( propertyChanges ) > #newList and iterations < 100 do
		local appliedTraitDictionary = {}
		for i, propertyChange in ipairs( propertyChanges ) do
			if propertyChange.TraitName == nil or appliedTraitDictionary[propertyChange.TraitName] or not referencedTraits[propertyChange.TraitName] or not HeroHasTrait(propertyChange.TraitName) then
				table.insert( newList, propertyChange )
				appliedTraitDictionary[propertyChange.ParentTraitName] = true
				lastTraitName = propertyChange.ParentTraitName
			else
				DebugPrint({Text = "Skipping property change on " .. propertyChange.ParentTraitName })
			end
		end
		iterations = iterations + 1
	end
	--DebugAssert({ Condition = iterations < 100, Text = "Unable to resolve circular dependency in trait list! Last trait processed: " .. lastTraitName, Owner = "Alice" })
end

function OrderAndApplyPropertyChanges(weaponNames)
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges
	-- apply property changes in order

	for weaponName, weaponNamePropertyChanges in pairs( weaponPropertyChanges ) do
		if MapState.EquippedWeapons[weaponName] then
			local orderedPropertyChanges = KeysToList(weaponNamePropertyChanges)
			table.sort( orderedPropertyChanges, GetPropertyOrderingValue )
			for i, propertyName in ipairs( orderedPropertyChanges ) do
				local propertyChanges = weaponNamePropertyChanges[propertyName]
				if not weaponNames or weaponNames[ weaponName ] then
					ReorderPropertyChanges( propertyChanges )
					for _, propertyChange in ipairs( propertyChanges ) do
						ApplyWeaponPropertyChange( CurrentRun.Hero, weaponName, propertyChange )
					end
				end
			end
		end
	end

	ApplyProjectilePropertyChanges( weaponNames, projectilePropertyChanges)
	for weaponName, weaponNamePropertyChanges in pairs( effectPropertyChanges ) do
		if MapState.EquippedWeapons[weaponName] then
			for effectName, effectNamePropertyChanges in pairs( weaponNamePropertyChanges ) do
				for effectPropertyName, propertyChanges in pairs( effectNamePropertyChanges ) do
				if not weaponNames or weaponNames[ weaponName ] then
						ReorderPropertyChanges( propertyChanges )
						for _, propertyChange in ipairs( propertyChanges ) do
							ApplyWeaponPropertyChange( CurrentRun.Hero, weaponName, propertyChange )
						end
					end
				end
			end
		end
	end
end

function ApplyProjectilePropertyChanges( weaponNames, projectilePropertyChanges )
	for weaponName, weaponNamePropertyChanges in pairs( projectilePropertyChanges ) do
		if MapState.EquippedWeapons[weaponName] then
			local orderedPropertyChanges = KeysToList(weaponNamePropertyChanges)
			table.sort( orderedPropertyChanges, GetPropertyOrderingValue )
			for i, propertyName in ipairs( orderedPropertyChanges ) do
				if not weaponNames or weaponNames[ weaponName ] then
					ReorderPropertyChanges( weaponNamePropertyChanges[propertyName] )
					for _, propertyChange in ipairs( weaponNamePropertyChanges[propertyName] ) do
						ApplyWeaponPropertyChange( CurrentRun.Hero, weaponName, propertyChange )
					end
				end
			end
		end
	end
end

function GetDerivedPropertyChangeValues( args )
	args = args or {}
	local valueType = args.Type
	local derivedValue = { PropertyChanges = {} , ThingPropertyChanges = {} }
	local allValues = {}
	local projectileName = args.ProjectileName
	--DebugAssert({ Condition = (valueType == "Projectile"), Text = "GetDerivedPropertyChangeValue not supported for anything other than projectiles at the moment! "})
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local weaponNamePropertyChanges = projectilePropertyChanges[args.WeaponName]
	if IsEmpty(weaponNamePropertyChanges) then
		return derivedValue
	end
	local orderedPropertyChanges = KeysToList(weaponNamePropertyChanges)
	table.sort( orderedPropertyChanges, GetPropertyOrderingValue )
	for i, propertyName in ipairs( orderedPropertyChanges ) do
		ReorderPropertyChanges( weaponNamePropertyChanges[propertyName] )
		for _, propertyChange in ipairs( weaponNamePropertyChanges[propertyName] ) do
			if (not propertyChange.FalseTraitName or not HeroHasTrait(propertyChange.FalseTraitName) ) 
				and (not propertyChange.TraitName or (HeroHasTrait(propertyChange.TraitName))) then
				local propertyName = propertyChange.ProjectileProperty
				local referencesProjectileName = ( propertyChange.ProjectileName == projectileName ) or Contains(propertyChange.ProjectileNames, projectileName )
				if referencesProjectileName or ( not args.MatchProjectileName and not propertyChange.ProjectileName and not propertyChange.ProjectileNames) then
					if not allValues[propertyName] then
						allValues[propertyName] = GetBaseDataValue({ Type = valueType, Name = projectileName, Property = propertyName })
					end
					if propertyChange.ChangeType == "Add" then
						allValues[propertyName] = allValues[propertyName] + propertyChange.ChangeValue
					elseif propertyChange.ChangeType == "Multiply" then
						allValues[propertyName] = allValues[propertyName] * propertyChange.ChangeValue
					else
						allValues[propertyName] = propertyChange.ChangeValue
					end
				end
			end
		end
	end
	for name, value in pairs( allValues ) do
		if ProjectileThingPropertyNames[name] then
			derivedValue.ThingPropertyChanges[name] = value
		else
			derivedValue.PropertyChanges[name] = value
		end
	end
	return derivedValue
end

function ApplyTraitUpgrade( unit, applyLuaUpgrades )
	local appliedTraitDictionary = {}
	local traitList = DeepCopyTable( unit.Traits )
	for k, trait in pairs( traitList ) do
		EquipReferencedWeapons( trait )
		if trait.SpeakerNames ~= nil then
			LoadVoiceBank({ Names = trait.SpeakerNames })
		end
		if trait.PackageNames ~= nil then
			LoadPackages({ Names = trait.PackageNames })
		end
	end
	SessionState.PropertyChangeList = { WeaponChanges = {}, ProjectileChanges = {}, EffectChanges = {}}
	
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges


	local appliedTraits = {}
	for k, trait in pairs( traitList ) do
		local appliedPropertyChanges = {}
		if trait.PropertyChanges then 
			table.insert( appliedPropertyChanges, trait.PropertyChanges)
		end
		if trait.ActivatedPropertyChanges then
			local traitData = TraitData[trait.Name]
			if traitData.ActivationRequirements == nil or IsGameStateEligible( trait, traitData.ActivationRequirements ) then
				trait.Activated = true
				table.insert( appliedPropertyChanges, trait.ActivatedPropertyChanges )
			end
		end
		for i, propertyChanges in pairs( appliedPropertyChanges ) do
			for i, propertyChange in ipairs( propertyChanges ) do
				if propertyChange.ChangeType and TraitData[trait.Name].PropertyChanges and TraitData[trait.Name].PropertyChanges[i] and not TraitData[trait.Name].PropertyChanges[i].ChangeType and not TraitData[trait.Name].PropertyChanges[i].DeriveValueFrom then
					if appliedTraitDictionary[trait.Name] then
						propertyChange.ChangeType = "Add"
					else
						propertyChange.ChangeType = "Absolute"
					end
				end
				if not propertyChange.WeaponName and not propertyChange.WeaponNames then
					ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades )
				else
					local affectedWeapons = {}
					if propertyChange.WeaponName then
						table.insert(affectedWeapons, propertyChange.WeaponName)
					end
					if propertyChange.WeaponNames then
						affectedWeapons = ConcatTableValues( affectedWeapons, propertyChange.WeaponNames )
					end

					if not propertyChange.ExcludeLinked then
						affectedWeapons = AddLinkedWeapons( affectedWeapons )
					end

					for i, weaponName in pairs(affectedWeapons) do
						local newPropertyChange = DeepCopyTable(propertyChange)
						newPropertyChange.ExcludeLinked = true
						newPropertyChange.WeaponName = weaponName
						newPropertyChange.WeaponNames = nil
						RecordTraitPropertyChange( trait.Name, newPropertyChange )
					end
				end
			end
		end
		table.insert( appliedTraits, trait )
		appliedTraitDictionary[trait.Name] = true
	end
	OrderAndApplyPropertyChanges()
end

function ProcessHeroTraitChanges( trait, reverse )
	if trait.ManaOverTimeSource and reverse then
		if trait.SetupFunction and trait.SetupFunction.Args then
			local manaRegenName = trait.SetupFunction.Args.Name 
			if manaRegenName ~= nil then
				CurrentRun.Hero.ManaRegenSources[manaRegenName] = nil
			end
		end
		if trait.SetupFunctions then
			for _, traitSetupFunctionData in pairs (trait.SetupFunctions) do
				if traitSetupFunctionData.Name == "ManaRegenSetup" and traitSetupFunctionData.Args then
					local manaRegenName = traitSetupFunctionData.Args.Name 
					if manaRegenName ~= nil then
						CurrentRun.Hero.ManaRegenSources[manaRegenName] = nil
					end
				end
			end
		end
	end

	if trait.WeaponAmmoModification and not reverse then
		AddAmmo( trait.WeaponAmmoModification.Name, trait.WeaponAmmoModification.AddMaxAmmo )
		UpdateAmmoUI()
	end

	if trait.Costume and reverse then
		CurrentRun.Hero.HeroTraitValuesCache.Costume = nil
		if IsEmpty( MapState.TransformArgs ) then
			SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
			SetupCostume( MapState.HostilePolymorph )
		end
	end

	if not trait.PropertyChanges and not trait.ActivatedPropertyChanges and not (trait.ForceWeaponRefreshOnRemove and reverse) then
		return
	end
	SessionState.PropertyChangeList = SessionState.PropertyChangeList or { WeaponChanges = {}, ProjectileChanges = {}, EffectChanges = {}}

	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges
	local traitWeapons = {}
	local localWeapons = {}
	local appliedPropertyChanges = {}
	if trait.PropertyChanges then 
		table.insert( appliedPropertyChanges, trait.PropertyChanges )
	end
	if trait.ActivatedPropertyChanges then
		local traitData = TraitData[trait.Name]
		if traitData ~= nil then
			local isEligible = traitData.ActivationRequirements == nil or IsGameStateEligible( trait, traitData.ActivationRequirements )
			if isEligible and not trait.Activated then
				trait.Activated = true
				table.insert( appliedPropertyChanges, trait.ActivatedPropertyChanges )
			elseif not isEligible and trait.Activated then
				trait.Activated = nil
				table.insert( appliedPropertyChanges, trait.ActivatedPropertyChanges )
			end
		end
	end
	if trait.PreEquipWeapons then
		traitWeapons = ConcatTableValues( traitWeapons, trait.PreEquipWeapons )
	end
	if trait.ReferenceWeapon then
		table.insert(traitWeapons, trait.ReferenceWeapon)
	end
	for i, propertyChanges in pairs( appliedPropertyChanges ) do
		for i, propertyChange in ipairs( propertyChanges ) do
			if not reverse and propertyChange.ChangeType and TraitData[trait.Name].PropertyChanges and TraitData[trait.Name].PropertyChanges[i] and not TraitData[trait.Name].PropertyChanges[i].ChangeType and not TraitData[trait.Name].PropertyChanges[i].DeriveValueFrom then
				if HeroHasTrait( trait.Name ) then
					propertyChange.ChangeType = "Add"
				else
					propertyChange.ChangeType = "Absolute"
				end
			end

			if not propertyChange.WeaponName and not propertyChange.WeaponNames then
				ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, true, reverse )
			else
				local affectedWeapons = {}
				if propertyChange.WeaponName then
					table.insert(affectedWeapons, propertyChange.WeaponName)
				end
				if propertyChange.WeaponNames then
					affectedWeapons = ConcatTableValues( affectedWeapons, propertyChange.WeaponNames )
				end

				if not propertyChange.ExcludeLinked then
					affectedWeapons = AddLinkedWeapons( affectedWeapons )
				end

				for i, weaponName in ipairs( affectedWeapons ) do
					if MapState.EquippedWeapons[weaponName] then
						table.insert( localWeapons, weaponName )		
						local newPropertyChange = DeepCopyTable(propertyChange)
						newPropertyChange.ExcludeLinked = true
						newPropertyChange.WeaponName = weaponName
						newPropertyChange.WeaponNames = nil
						if not reverse then
							RecordTraitPropertyChange( trait.Name, newPropertyChange )
						else
							RemoveTraitPropertyChange( trait.Name, newPropertyChange, weaponName )
						end
					end
				end
			end
		end
	end

	local referencedWeapons = {}
	for _, weaponName in pairs( localWeapons ) do
		if CurrentRun.Hero.Weapons[weaponName]
			or ( WeaponData[weaponName] and WeaponData[weaponName].LinkedTraitName and HeroHasTrait( WeaponData[weaponName].LinkedTraitName ))
			or ( WeaponData[weaponName] and WeaponData[weaponName].LinkedTraitNames and CurrentRun.Hero.TraitDictionary and ContainsAnyKey( CurrentRun.Hero.TraitDictionary, WeaponData[weaponName].LinkedTraitNames ))
			or ( WeaponData[weaponName] and WeaponData[weaponName].LinkedUpgrades and CurrentRun.Hero.Weapons[WeaponData[weaponName].LinkedUpgrades]) 
			or Contains( traitWeapons, weaponName ) then
			referencedWeapons[weaponName] = true
		end
	end
	for _, weaponName in pairs( traitWeapons ) do
		if WeaponData[weaponName] and WeaponData[weaponName].IsModifiedByTraits then
			referencedWeapons[weaponName] = true
		end
	end
	if trait.ForceWeaponRefreshOnRemove and reverse then
		referencedWeapons[trait.ForceWeaponRefreshOnRemove] = true
	end
	
	if CurrentRun.Hero.ObjectId then
		for weaponName in pairs( referencedWeapons ) do
			if MapState.EquippedWeapons[weaponName] then
				local enabledStatus = GetWeaponDataValue({ WeaponName = weaponName, Id = CurrentRun.Hero.ObjectId, Property = "Enabled" })
				ResetWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName)
				if weaponData then
					SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = enabledStatus })
				end
			end
		end
	end
	
	OrderAndApplyPropertyChanges( referencedWeapons )
end


function ApplyEnemyTraits( currentRun, enemy )
	for k, trait in ipairs( CurrentRun.Hero.Traits ) do
		if trait.EnemySetupFunctionName ~= nil then
			CallFunctionName( trait.EnemySetupFunctionName, trait, enemy, trait.EnemySetupFunctionArgs )
		end
	end
end

function HasMeleeWeapon( currentRun )

	for k, meleeWeaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if currentRun.Hero.Weapons[meleeWeaponName] then
			return true
		end
	end
	return false

end

function GatherAndEquipWeapons( currentRun )

	local weaponNames = ShallowCopyTable( GameData.WeaponEquipOrder )
	local remainingWeaponNames = GetAllKeys( currentRun.Hero.Weapons )
	table.sort( remainingWeaponNames )
	for k, weaponName in ipairs( remainingWeaponNames ) do
		if not Contains( weaponNames, weaponName ) then
			table.insert( weaponNames, weaponName )
		end
	end
	for k, weaponName in ipairs( weaponNames ) do
		--DebugPrint({ Text = "Equipping = "..weaponName })
		EquipWeapon({ Name = weaponName, DestinationId = currentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages[weaponName] })
		MapState.EquippedWeapons[weaponName] = true
		local linkedWeaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if linkedWeaponNames ~= nil then
			for k, linkedWeaponName in ipairs( linkedWeaponNames ) do
				EquipWeapon({ DestinationId = currentRun.Hero.ObjectId, Name = linkedWeaponName })
				MapState.EquippedWeapons[linkedWeaponName] = true
			end
		end
	end	

end

function HandleWeaponAnimSwaps()
	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		if weaponData ~= nil and weaponData.SwapAnimations ~= nil then
			for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
				SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
			end
		end
	end
end

function IsBonusUnusedWeapon( weaponName )
	if GameState.WorldUpgrades.WorldUpgradeUnusedWeaponBonus and weaponName == CurrentRun.BonusUnusedWeaponName then
		return true
	end
	return false
end

function GetRandomUnequippedWeapon( prevRun )
	local unusedWeapons = {}
	local hasWeaponEquipped = HasMeleeWeapon( CurrentRun )
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if prevRun ~= nil and weaponName ~= prevRun.BonusUnusedWeaponName then
			if ( not hasWeaponEquipped and weaponName ~= CurrentRun.Hero.DefaultWeapon) or (hasWeaponEquipped and CurrentRun.Hero.Weapons[weaponName] == nil and IsWeaponEligible(CurrentRun, WeaponData[weaponName])) then
				table.insert(unusedWeapons, weaponName)
			end
		end
	end
	return GetRandomValue(unusedWeapons)
end

function IsWeaponUntouched( weaponName )
	return GameState.WeaponsTouched[weaponName] == nil
end

function IsWeaponUnlocked( weaponName )
	return GameState.WeaponsUnlocked[weaponName]
end
