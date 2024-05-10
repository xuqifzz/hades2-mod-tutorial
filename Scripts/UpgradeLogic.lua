function ApplyWeaponPropertyChanges( unit, weaponName, propertyChanges, reverse )

	if propertyChanges == nil then
		return
	end
	for k, propertyChange in ipairs( propertyChanges ) do

		local weaponPropertyName = weaponName
		if propertyChange.WeaponName ~= nil then
			weaponPropertyName = propertyChange.WeaponName
		end
		ApplyWeaponPropertyChange( unit, weaponPropertyName, propertyChange, reverse )

	end
end

function ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse )

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
	if propertyChange.FalseTraitName ~= nil then
		if HeroHasTrait(propertyChange.FalseTraitName) then
			return
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
		if propertyChange.WeaponProperty == "ChargeTime" then
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = unit.ObjectId, Property = "ChargeTimeRemaining", Value = changeValue, ValueChangeType = propertyChange.ChangeType, DataValue = false })
		end
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = unit.ObjectId, Property = propertyChange.WeaponProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
		if propertyChange.WeaponProperty == "ClipSize" then
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
			ApplyWeaponPropertyChange( unit, linkedWeaponName, propertyChange, reverse )
		end
	end
end

function ApplyUnitPropertyChanges( unit, propertyChanges, applyLuaUpgrades, reverse )

	if propertyChanges == nil then
		return
	end

	for k, propertyChange in ipairs( propertyChanges ) do
		ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse )
	end
end

function ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse )
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
			thread( UpdateHealthUI )
		end
		if propertyChange.LuaProperty == "MaxMana" then
			CurrentRun.Hero.Mana = CurrentRun.Hero.Mana + changeValue
			ValidateMaxMana()
			thread( UpdateManaMeterUI )
			if HasHeroTraitValue("MaxManaToMaxHealthConversion") then
				ValidateMaxHealth()
				thread( UpdateHealthUI )
			end
		end
	end

	if propertyChange.WeaponName ~= nil then
		ApplyWeaponPropertyChange( unit, propertyChange.WeaponName, propertyChange, reverse)
	end

	if propertyChange.WeaponNames ~= nil then
		for k, weaponName in pairs( propertyChange.WeaponNames ) do
			ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse)
		end
	end

end

function ApplyLifePropertyChange( unit, propertyChange, changeValue )
	SetLifeProperty({ DestinationId = unit.ObjectId, Property = propertyChange.LifeProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType, DataValue = propertyChange.DataValue })
end

function ApplyAllTraitWeapons( hero )
	for k, traitData in pairs( hero.Traits ) do
		AddAssistWeapons( hero, traitData )
		if traitData.ReplacementGrannyModels ~= nil then
			for originalModel, attachmentModel in pairs(traitData.ReplacementGrannyModels) do
				SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = hero.ObjectId })
			end
		end
		for weaponName, v in pairs( hero.Weapons ) do
			AddOnDamageWeapons( hero, weaponName, traitData)
			AddOnFireWeapons( hero, weaponName, traitData)		
		end
	end
end


function AddOnDamageWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnDamageWeapons == nil then
		return
	end

	if upgradeData.LegalOnDamageWeapons == nil or Contains( upgradeData.LegalOnDamageWeapons, weaponName ) then
		for k, onDamageWeapon in pairs( upgradeData.AddOnDamageWeapons ) do
			if hero.OnDamageWeapons == nil then
				hero.OnDamageWeapons = {}
			end
			if hero.OnDamageWeapons[weaponName] == nil then
				hero.OnDamageWeapons[weaponName] = {}
			end
			if not hero.OnDamageWeapons[weaponName][onDamageWeapon] then
				hero.OnDamageWeapons[weaponName][onDamageWeapon] = upgradeData.OnDamageWeaponProperties or true
			end
		end
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			AddOnDamageWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function RemoveOnDamageWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnDamageWeapons == nil or hero.OnDamageWeapons == nil then
		return
	end

	if upgradeData.LegalOnDamageWeapons == nil or Contains( upgradeData.LegalOnDamageWeapons, weaponName ) then
		for k, onDamageWeapon in pairs( upgradeData.AddOnDamageWeapons ) do
			if hero.OnDamageWeapons[weaponName] ~= nil then
				hero.OnDamageWeapons[weaponName] = {}
			end
		end
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			RemoveOnDamageWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function AddOnFireWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnFireWeapons == nil then
		return
	end

	for k, onFireWeapon in pairs( upgradeData.AddOnFireWeapons ) do
		if hero.OnFireWeapons == nil then
			hero.OnFireWeapons = {}
		end
		if hero.OnFireWeapons[weaponName] == nil then
			hero.OnFireWeapons[weaponName] = {}
		end
		if not hero.OnFireWeapons[weaponName][onFireWeapon] and Contains( upgradeData.LegalOnFireWeapons, weaponName ) then
			if upgradeData.AddOnFireWeaponArgs then
				hero.OnFireWeapons[weaponName][onFireWeapon] = DeepCopyTable( upgradeData.AddOnFireWeaponArgs )
			else
				hero.OnFireWeapons[weaponName][onFireWeapon] = true
			end
		end
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			AddOnFireWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function RemoveOnFireWeapons( hero, upgradeData )
	if upgradeData.AddOnFireWeapons == nil then
		return
	end

	if hero.OnFireWeapons == nil then
		hero.OnFireWeapons = {}
	end
	for k, weaponName in pairs( upgradeData.LegalOnFireWeapons ) do
		hero.OnFireWeapons[weaponName] = nil

		local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
		if linkedWeapons then
			for k, linkedWeaponName in pairs( linkedWeapons ) do
				hero.OnFireWeapons[linkedWeaponName] = nil
			end
		end
	end
end

function AddOnHitWeapons( hero, upgradeData )
	if upgradeData.AddOnHitWeapons == nil then
		return
	end

	if upgradeData.AddOnHitWeapons ~= nil then
		if hero.OnHitWeapons == nil then
			hero.OnHitWeapons = {}
		end
		for k, onHitWeaponName in pairs( upgradeData.AddOnHitWeapons ) do
			hero.OnHitWeapons[onHitWeaponName] = upgradeData.OnHitWeaponProperties or true
		end
	end
end

function RemoveOnHitWeapons( hero, upgradeData )
	if upgradeData.AddOnHitWeapons == nil then
		return
	end
	if upgradeData.AddOnHitWeapons ~= nil then
		if hero.OnHitWeapons == nil then
			hero.OnHitWeapons = {}
		end
		for k, onHitWeaponName in pairs( upgradeData.AddOnHitWeapons ) do
			hero.OnHitWeapons[onHitWeaponName] = nil
		end
	end
end

function AddOnDeathWeapon( unit, weaponName )
	if weaponName == nil then
		return
	end

	if unit.OnDeathWeapons == nil then
		unit.OnDeathWeapons = {}
	end
	unit.OnDeathWeapons[weaponName] = true
end

function RemoveOnDeathWeapons( unit )
	unit.OnDeathWeapons = nil
end

function ApplyMetaUpgrades( hero, applyLuaUpgrades )
	local hasBeenApplied = {}
	for upgradeName in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		if upgradeData ~= nil then
			for i = 1, GetNumMetaUpgrades(upgradeName) do
				ApplyMetaUpgrade( upgradeData, applyLuaUpgrades, hasBeenApplied[upgradeName] == nil )
				hasBeenApplied[upgradeName] = true
			end
		end
	end
end

function ReapplyWeaponSwitchMetaUpgrades()
	local hasBeenApplied = {}
	for upgradeName in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		if upgradeData ~= nil and upgradeData.ReapplyOnWeaponSwitch then
			for i = 1, GetNumMetaUpgrades(upgradeName) do
				ApplyMetaUpgrade( upgradeData, applyLuaUpgrades, hasBeenApplied[upgradeName] == nil )
				hasBeenApplied[upgradeName] = true
			end
		end
	end
end

function ApplyMetaUpgrade( upgradeData, applyLuaUpgrade, firstApplied, reverse )

	if upgradeData.OnDuplicatePropertyChanges == nil or firstApplied then
		if upgradeData.PreEquipWeapon then
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = upgradeData.PreEquipWeapon })
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.PropertyChanges, applyLuaUpgrade, reverse )
	else
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.OnDuplicatePropertyChanges, applyLuaUpgrade, reverse )
	end

	if applyLuaUpgrade and upgradeData.AddOutgoingDamageModifiers then
		if CurrentRun.Hero.OutgoingDamageModifiers == nil then
			CurrentRun.Hero.OutgoingDamageModifiers = {}
		end
		if reverse then
			for i, modifier in pairs(CurrentRun.Hero.OutgoingDamageModifiers) do
				if modifier.Name == upgradeData.Name then
					CurrentRun.Hero.OutgoingDamageModifiers[i] = nil
					break
				end
			end
		else

			local data = DeepCopyTable( upgradeData.AddOutgoingDamageModifiers )
			data.Name = upgradeData.Name
			table.insert( CurrentRun.Hero.OutgoingDamageModifiers, data )
		end
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
	DebugAssert({ Condition = iterations < 100, Text = "Unable to resolve circular dependency in trait list! Last trait processed: " .. lastTraitName, Owner = "Alice" })
end

function OrderAndApplyPropertyChanges(weaponNames)
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges
	local projectilePropertyChanges = SessionState.PropertyChangeList.ProjectileChanges
	local effectPropertyChanges = SessionState.PropertyChangeList.EffectChanges
	-- apply property changes in order

	for weaponName, weaponNamePropertyChanges in pairs( weaponPropertyChanges ) do
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
	ApplyProjectilePropertyChanges( weaponNames, projectilePropertyChanges)
	for weaponName, weaponNamePropertyChanges in pairs( effectPropertyChanges ) do
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

function ApplyWeaponPropertyChanges( weaponNames, propertyName )
	local weaponPropertyChanges = SessionState.PropertyChangeList.WeaponChanges

	for weaponName, weaponNamePropertyChanges in pairs( weaponPropertyChanges ) do
		if weaponNames[ weaponName ] then
			local propertyChanges = weaponNamePropertyChanges[propertyName]
			if not IsEmpty(propertyChanges) then
				ReorderPropertyChanges( propertyChanges )
				for _, propertyChange in ipairs( propertyChanges ) do
					ApplyWeaponPropertyChange( CurrentRun.Hero, weaponName, propertyChange )
				end
			end
		end
	end
end

function ApplyProjectilePropertyChanges( weaponNames, projectilePropertyChanges )
	for weaponName, weaponNamePropertyChanges in pairs( projectilePropertyChanges ) do
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

function GetDerivedPropertyChangeValues( args )
	args = args or {}
	local valueType = args.Type
	local derivedValue = { PropertyChanges = {} , ThingPropertyChanges = {} }
	local allValues = {}
	local projectileName = args.ProjectileName
	DebugAssert({ Condition = (valueType == "Projectile"), Text = "GetDerivedPropertyChangeValue not supported for anything other than projectiles at the moment! "})
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

		AddOnHitWeapons( unit, trait )
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
			if traitData.ActivationRequirements == nil or IsGameStateEligible( CurrentRun, trait, traitData.ActivationRequirements ) then
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
			if CurrentRun.Hero.ManaRegenSources [ manaRegenName ]  then
				CurrentRun.Hero.ManaRegenSources [ manaRegenName ] = nil
			end
		end
		if trait.SetupFunctions then
			for _, traitSetupFunctionData in pairs (trait.SetupFunctions) do
				if traitSetupFunctionData.Name == "ManaRegenSetup" and traitSetupFunctionData.Args then
					local manaRegenName = traitSetupFunctionData.Args.Name 
					if CurrentRun.Hero.ManaRegenSources [ manaRegenName ]  then
						CurrentRun.Hero.ManaRegenSources [ manaRegenName ] = nil
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
		if CurrentRun.Hero.HeroTraitValuesCache and CurrentRun.Hero.HeroTraitValuesCache.Costume then
			CurrentRun.Hero.HeroTraitValuesCache.Costume = nil
		end
		if IsEmpty(MapState.TransformArgs) then
			SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
			SetupCostume( MapState.HostilePolymorph )
		end
	end

	if not trait.PropertyChanges and not trait.ActivatedPropertyChanges then
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
			local isEligible = traitData.ActivationRequirements == nil or IsGameStateEligible( CurrentRun, trait, traitData.ActivationRequirements )
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

				for i, weaponName in pairs(affectedWeapons) do
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
	
	for weaponName in pairs( referencedWeapons ) do
		local enabledStatus = GetWeaponDataValue({ WeaponName = weaponName, Id = CurrentRun.Hero.ObjectId, Property = "Enabled" })
		ResetWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName) 
		if weaponData ~= nil then
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = enabledStatus })
		end
	end
	
	OrderAndApplyPropertyChanges( referencedWeapons )
end


function ApplyEnemyTraits( currentRun, enemy )
	for k, trait in pairs( currentRun.Hero.Traits ) do
		ApplyEnemyTrait( currentRun, trait, enemy )
	end
end

function ApplyEnemyTrait( currentRun, trait, enemy )
	if trait ~= nil then
		if trait.EnemyPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( enemy, trait.EnemyPropertyChanges, true )
		end
		if trait.EnemySetupFunctionName ~= nil then
			CallFunctionName( trait.EnemySetupFunctionName, trait, enemy, trait.EnemySetupFunctionArgs )
		end
		
		if trait.EnemyIncomingDamageModifiers and not enemy.SkipModifiers then
			local modifierData = DeepCopyTable( trait.EnemyIncomingDamageModifiers )
			modifierData.Name = trait.Name
			AddIncomingDamageModifier( enemy, modifierData )
		end
	end
end

function ApplyMetaModifierHeroUpgrades( hero, applyLuaUpgrades )
	for k, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.HeroPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( hero, upgradeData.HeroPropertyChanges, applyLuaUpgrades )
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

	if not currentRun.CurrentRoom.NoAutoEquip and not HasMeleeWeapon( currentRun ) then
		local defaultWeaponName = currentRun.Hero.DefaultWeapon
		currentRun.Hero.Weapons[defaultWeaponName] = true
		currentRun.Hero.Weapons[WeaponData[defaultWeaponName].SecondaryWeapon] = true
		GameState.WeaponsUnlocked[defaultWeaponName] = true
		GameState.WeaponsTouched[defaultWeaponName] = true
	end

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
		local linkedWeaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if linkedWeaponNames ~= nil then
			for k, linkedWeaponName in ipairs( linkedWeaponNames ) do
				EquipWeapon({ DestinationId = currentRun.Hero.ObjectId, Name = linkedWeaponName })
			end
		end
	end	
	HandleWeaponAnimSwaps()
end

function HandleWeaponAnimSwaps()
	if CurrentHubRoom ~= nil and not CurrentHubRoom.AllowWeapons then
		return
	end
	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = WeaponData[weaponName]
		if weaponData ~= nil and weaponData.SwapAnimations ~= nil then
			for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
				SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
			end
		end
	end
end

function EquipDumbFireWeapons( newEnemy, upgradeData )
	if upgradeData == nil then
		return
	end

	if upgradeData.AddDumbFireWeapons == nil or type(upgradeData.AddDumbFireWeapons) ~= "table" then
		return
	end

	for weaponType, weaponName in pairs( upgradeData.AddDumbFireWeapons ) do
		newEnemy.DumbFireWeapons = newEnemy.DumbFireWeapons or {}
		EquipWeapon({ Name = weaponName, DestinationId = newEnemy.ObjectId })
		table.insert( newEnemy.DumbFireWeapons, weaponName )
	end
end

function IsBonusUnusedWeapon( weaponName )
	if GameState.WorldUpgrades.WorldUpgradeUnusedWeaponBonus and weaponName == CurrentRun.BonusUnusedWeaponName then
		return true
	end
	return false
end

function GetRandomUnequippedWeapon()
	local unusedWeapons = {}
	local hasWeaponEquipped = HasMeleeWeapon( CurrentRun )
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if ( not hasWeaponEquipped and weaponName ~= CurrentRun.Hero.DefaultWeapon) or (hasWeaponEquipped and CurrentRun.Hero.Weapons[weaponName] == nil and IsWeaponEligible(CurrentRun, WeaponData[weaponName])) then
			table.insert(unusedWeapons, weaponName)
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

function GetNumLockedWeapons()
	local numLocked = 0
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if not IsWeaponUnlocked( weaponName ) then
			numLocked = numLocked + 1
		end
	end
	return numLocked
end

function AddEnemyUpgrade( upgradeName )
	table.insert( CurrentRun.EnemyUpgrades, upgradeName )
	local upgradeData = EnemyUpgradeData[upgradeName]
	if upgradeData.HeroPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.HeroPropertyChanges, true )
	end
end

function RemoveEnemyUpgrade( upgradeName )
	RemoveValue( CurrentRun.EnemyUpgrades, upgradeName )
	local upgradeData = EnemyUpgradeData[upgradeName]
	if upgradeData.HeroPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.HeroPropertyChanges, true, true )
	end
end

