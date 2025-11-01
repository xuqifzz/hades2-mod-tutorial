  OnProjectileReflect{
	function( triggerArgs )
		if CheckCooldown("ParryAttackPresentation", 0.25) then
			thread( ParryAttackPresentation, triggerArgs.triggeredById )
		end

		local reflectRumble =
		{
			{ ScreenPreWait = 0, Fraction = 0.25, Duration = 0.2 },
		}
		thread( DoRumble, reflectRumble )
	end
}

OnProjectileBlock{
	function( triggerArgs )
		local weaponName = triggerArgs.WeaponName
		local blocker = triggerArgs.Blocker
		local attacker = triggerArgs.Attacker
		if blocker ~= nil then
			if blocker.ProjectileBlockFunctionName then
				CallFunctionName( blocker.ProjectileBlockFunctionName, blocker, triggerArgs )
			end
			if weaponName == nil or WeaponData[weaponName] == nil or not WeaponData[weaponName].SkipBlockPresentation then
				CallFunctionName( blocker.ProjectileBlockPresentationFunctionName, blocker, triggerArgs )
			end
		end
		if weaponName ~= nil and WeaponData[weaponName] ~= nil then
			if WeaponData[weaponName].ProjectileBlockFunctionName then
				CallFunctionName(WeaponData[weaponName].ProjectileBlockFunctionName, triggerArgs, WeaponData[weaponName].ProjectileBlockFunctionArgs)
			end
			if WeaponData[weaponName].DoProjectileBlockPresentation then
				if CheckCooldown("BlockAttackPresentation", 0.25) then
					thread( BlockAttackPresentation, weaponName, blocker.ObjectId, attacker )
				end
				local blockRumble =
				{
					{ ScreenPreWait = 0, Fraction = 0.1, Duration = 0.2 },
				}
				thread( DoRumble, blockRumble )
			end
		end
		
		if attacker and attacker.ShotsDestroyedReactionVoiceLines then
			thread( PlayVoiceLines, attacker.ShotsDestroyedReactionVoiceLines, nil, attacker, triggerArgs )
		end
		if blocker == CurrentRun.Hero then
			for i, functionData in pairs( GetHeroTraitValues( "OnBlockDamageFunction" ) ) do
				CallFunctionName( functionData.Name, blocker, functionData.Args, triggerArgs )
			end
		end
	end
}

OnDodge{
	function( triggerArgs )
		if triggerArgs.TriggeredByTable ~= CurrentRun.Hero then
			return
		end
		local runFunctions = {}
		for i, dodgeData in pairs( GetHeroTraitValues("OnDodgeFunction") ) do
			local dodgeFunction = _G[dodgeData.FunctionName]
			if dodgeFunction ~= nil and ( not dodgeData.RunOnce or ( dodgeData.RunOnce and not runFunctions[ dodgeData.FunctionName ])) then
				thread( dodgeFunction, triggerArgs.AttackerTable, dodgeData.FunctionArgs )
				runFunctions[dodgeData.FunctionName] = true
			end
		end
		if triggerArgs.Dodge then
			thread( PlayerDodgePresentation )
		else
			thread( PlayerMissPresentation )
		end
	end
}

OnWeaponTriggerRelease{
	function( triggerArgs )
	
		local attacker = triggerArgs.OwnerTable
		local weaponData = GetWeaponData( attacker, triggerArgs.name)
		if weaponData == nil then
			return
		end

		StopWeaponSounds( "TriggerRelease", weaponData.Sounds, attacker )

		CallFunctionName( weaponData.OnWeaponTriggerReleaseFunctionName, attacker, weaponData, triggerArgs )
	end
}

function AddIncomingDamageModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.IncomingDamageModifiers == nil then
		unit.IncomingDamageModifiers = {}
	end
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end
	table.insert( unit.IncomingDamageModifiers, data )
end

function RemoveIncomingDamageModifier( unit, name )
	if unit == nil then
		return
	end
	if unit.IncomingDamageModifiers == nil then
		return
	end
	for _, data in ipairs( unit.IncomingDamageModifiers ) do
		if data.Name == name then
			RemoveValueAndCollapse( unit.IncomingDamageModifiers, data )
			return
		end
	end
end

function AddOutgoingLifestealModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingLifestealModifiers == nil then
		unit.OutgoingLifestealModifiers = {}
	end

	table.insert( unit.OutgoingLifestealModifiers, data )
end

function RecordSpeedModifier( modifier, duration )
	if CurrentRun.Hero.IsDead or not duration then
		return
	end
	CurrentRun.CurrentRoom.SpeedModifier = CurrentRun.CurrentRoom.SpeedModifier or 1
	if CurrentRun.CurrentRoom.SpeedModifier < modifier then
		CurrentRun.CurrentRoom.SpeedModifier = modifier
	end
	
	duration = duration + CurrentRun.Hero.DashManeuverTimeThreshold 
	if SetThreadWait( "SpeedModifierFalloff", duration ) then
		return
	end

	wait( duration, "SpeedModifierFalloff" )
	if CurrentRun.CurrentRoom and not CurrentRun.Hero.IsDead then
		CurrentRun.CurrentRoom.SpeedModifier = 1
	end
end

function AddOutgoingDamageModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingDamageModifiers == nil then
		unit.OutgoingDamageModifiers = {}
	end
	
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end

	table.insert( unit.OutgoingDamageModifiers, data )
end

function GetOutgoingDamageModifier( unit, name )
	if unit == nil or IsEmpty(unit.OutgoingDamageModifiers ) then
		return
	end
	for i, data in ipairs( unit.OutgoingDamageModifiers ) do
		if data.Name and data.Name == name then
			return data
		end
	end
	return nil
end
function RemoveOutgoingDamageModifier( unit, name )
	if unit == nil or unit.OutgoingDamageModifiers == nil then
		return
	end
	for i, data in ipairs( unit.OutgoingDamageModifiers ) do
		if data.Name == name then
			unit.OutgoingDamageModifiers[i] = nil
			break
		end
	end
	unit.OutgoingDamageModifiers = CollapseTable( unit.OutgoingDamageModifiers )
end


function AddOutgoingDoubleDamageModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingDoubleDamageModifiers == nil then
		unit.OutgoingDoubleDamageModifiers = {}
	end
	
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end

	table.insert( unit.OutgoingDoubleDamageModifiers, data )
end

function RemoveOutgoingDoubleDamageModifier( unit, name )
	if unit == nil or unit.OutgoingDoubleDamageModifiers == nil then
		return
	end
	for i, data in ipairs( unit.OutgoingDoubleDamageModifiers ) do
		if data.Name == name then
			unit.OutgoingDoubleDamageModifiers[i] = nil
			break
		end
	end
	unit.OutgoingDoubleDamageModifiers = CollapseTable( unit.OutgoingDoubleDamageModifiers )
end

function AddOutgoingCritModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingCritModifiers == nil then
		unit.OutgoingCritModifiers = {}
	end
	
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end

	table.insert( unit.OutgoingCritModifiers, data )
end

function RemoveOutgoingCritModifier( unit, name )
	if unit == nil or unit.OutgoingCritModifiers == nil then
		return
	end
	for i, data in ipairs( unit.OutgoingCritModifiers ) do
		if data.Name == name then
			unit.OutgoingCritModifiers[i] = nil
			break
		end
	end
	unit.OutgoingCritModifiers = CollapseTable( unit.OutgoingCritModifiers )
end

function HasOutgoingCritModifierType( unit, name )
	if IsEmpty(unit.OutgoingCritModifiers) then
		return false
	end
	for i, data in ipairs( unit.OutgoingCritModifiers ) do
		if data[name] then
			return true
		end
	end
	return false
end

function RemoveIncomingDamageModifier( unit, name )
	if unit == nil or unit.IncomingDamageModifiers == nil then
		return
	end
	for i, data in ipairs( unit.IncomingDamageModifiers ) do
		if data.Name == name then
			unit.IncomingDamageModifiers[i] = nil
			break
		end
	end
	unit.IncomingDamageModifiers = CollapseTable( unit.IncomingDamageModifiers )
end

function CalculateBaseDamage( attacker, victim, triggerArgs )
	local damage = triggerArgs.DamageAmount
	
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in ipairs( attacker.OutgoingDamageModifiers ) do
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			
			if validWeapon and validProjectile then
				if modifierData.RandomizedBaseDamage then
					triggerArgs.IgnoreFutureModifiers = true
					damage = 0
					for i, data in ipairs( modifierData.RandomizedBaseDamage ) do
						if not data.Chance then
							if damage < data.Value then
								damage = data.Value
							end
						elseif RandomChance( data.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) and data.Value > damage then
							damage = data.Value
							if data.TriggerArgsKey then
								triggerArgs[data.TriggerArgsKey] = true
							end
							if data.DamagePresentationFunctionName then
								thread( CallFunctionName, data.DamagePresentationFunctionName, data )
							end
						end
					end
				end
			end
		end
	end
	return damage
end

function CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
	local damageAddition = 0
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in ipairs( attacker.OutgoingDamageModifiers ) do
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects))
			local validEffect = modifierData.ValidSelfEffect == nil or (attacker.ActiveEffects and attacker.ActiveEffects[ modifierData.ValidSelfEffect ] )
			if not validWeapon and modifierData.ConditionalBaseDamageValidWeapons then
				for i, conditionalData in ipairs(modifierData.ConditionalBaseDamageValidWeapons) do
					if conditionalData.TraitName and HeroHasTrait(conditionalData.TraitName) then
						if triggerArgs.SourceWeapon == conditionalData.WeaponName then
							validWeapon = true
							break
						end
						if conditionalData.AttackerIsSummon and attacker and Contains(MapState.SpellSummons, attacker) then
							validWeapon = true
							break
						end
					end
				end
			end
			if validWeapon and validProjectile and validActiveEffect and validEffect then
				if modifierData.ExBaseDamageAddition ~= nil and IsExWeapon( triggerArgs.SourceWeapon , { Combat = true }, triggerArgs) then
					damageAddition = damageAddition + modifierData.ExBaseDamageAddition
				end
				if modifierData.NonExBaseDamageAddition ~= nil and not IsExWeapon( triggerArgs.SourceWeapon , { Combat = true }, triggerArgs) then
					damageAddition = damageAddition + modifierData.NonExBaseDamageAddition
				end
				if modifierData.ValidBaseDamageAddition ~= nil then
					damageAddition = damageAddition + modifierData.ValidBaseDamageAddition
				end
				if modifierData.ValidMapKeyBaseDamageAddition ~= nil and SessionMapState[modifierData.ValidMapKeyBaseDamageAddition] then
					damageAddition = damageAddition + SessionMapState[modifierData.ValidMapKeyBaseDamageAddition]
				end
				if modifierData.FirstHitBaseDamageAddition and SessionMapState.LaserHitTargets and not SessionMapState.LaserHitTargets[ victim.ObjectId ] then
					damageAddition = damageAddition + modifierData.FirstHitBaseDamageAddition
					SessionMapState.LaserHitTargets[ victim.ObjectId ] = true
				end			
				if modifierData.BossBaseDamageAddition and victim.IsBoss then
					damageAddition = damageAddition + modifierData.BossBaseDamageAddition
				end	
				
				if modifierData.ValidDrinkBaseDamage and SessionMapState.DrinkCritVolleys and triggerArgs.SourceProjectileVolley and
					((SessionMapState.DrinkCritVolleys [triggerArgs.SourceWeapon] and SessionMapState.DrinkCritVolleys[triggerArgs.SourceWeapon][triggerArgs.SourceProjectileVolley]) or
					( SessionMapState.DrinkCritProjectileIds[triggerArgs.SourceWeapon] and SessionMapState.DrinkCritProjectileIds[triggerArgs.SourceWeapon][triggerArgs.ProjectileId] )) then
					damageAddition = damageAddition + modifierData.ValidDrinkBaseDamage	
					if SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId] and SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId].PowerDrink and SessionMapState.DrinkCritProjectileIds[triggerArgs.SourceWeapon] then
						SessionMapState.DrinkCritProjectileIds[triggerArgs.SourceWeapon][triggerArgs.ProjectileId] = nil
						SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId].PowerDrink = nil
					end
				end	

				if modifierData.SprintActiveBaseDamage and SessionMapState.SprintActive then
					damageAddition = damageAddition + modifierData.SprintActiveBaseDamage
				end

				if victim and modifierData.ConsecutiveBaseDamage and SessionMapState.ConsecutiveMissileHits[ victim.ObjectId ] then
					--Needs paired OnEnemyDamaged function to handle window
					damageAddition = damageAddition + math.min( modifierData.MaxConsecutiveBaseDamage, modifierData.ConsecutiveBaseDamage * SessionMapState.ConsecutiveMissileHits[ victim.ObjectId ] )
				end
				
				if modifierData.MaxChargeDamage and SessionMapState.MaxChargeStageReached[triggerArgs.SourceWeapon] then
					damageAddition = damageAddition + modifierData.MaxChargeDamage
				end
				
				if modifierData.MissingEffectDamage then
					if modifierData.MissingEffectDamage and victim.TriggersOnHitEffects and victim.ActiveEffects and not victim.ActiveEffects[modifierData.MissingEffectName] then
						local missingEffectDamage = modifierData.MissingEffectDamage
						local missingEffectDamageMultiplier = 1 + GetTotalHeroTraitValue( "MissingEffectDamageIncreasePerUniqueGod" ) * attacker.UniqueGodCount
						for i, data in ipairs( GetHeroTraitValues( "ActivatedMissingEffectDamageIncrease" ) ) do
							if HeroHasTrait(data.TraitName) and GetHeroTrait(data.TraitName).Activated then
								missingEffectDamageMultiplier = missingEffectDamageMultiplier + data.Amount
							end
						end
						damageAddition = damageAddition + missingEffectDamage * missingEffectDamageMultiplier
						if modifierData.MissingDamagePresentation then
							local presentationData = modifierData.MissingDamagePresentation
							triggerArgs.OverrideDamageTextStartColor = presentationData.TextStartColor
							triggerArgs.OverrideDamageTextColor = presentationData.TextColor
							triggerArgs.MissingEffectDamageIncrease = missingEffectDamage
							if presentationData.FunctionName then
								thread( CallFunctionName, presentationData.FunctionName, victim, triggerArgs, presentationData)
							end
						end
					end
				end

				if modifierData.DashVolleyBaseDamageAddition ~= nil and SessionMapState.DashVolleys[triggerArgs.SourceProjectileVolley] then
					damageAddition = damageAddition + modifierData.DashVolleyBaseDamageAddition
				end

				if modifierData.MissingAmmoBaseDamageAddition ~= nil and ( modifierData.LinkedWeapon == triggerArgs.SourceWeapon or (triggerArgs.ProjectileVolley and SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley])) then
					-- ProjectileVolley is the current volley of the weapon, it should be the one attached to the projectile for this instance
					if modifierData.LinkedWeapon == triggerArgs.SourceWeapon then
						if SessionMapState.PulseAmmoVolleys[triggerArgs.ProjectileVolley] then
							damageAddition = damageAddition + modifierData.MissingAmmoBaseDamageAddition * ( GetMaxAmmo( modifierData.SourceWeapon) - SessionMapState.PulseAmmoVolleys[triggerArgs.ProjectileVolley].AmmoCount)
						end
					else
						if SessionMapState.AmmoVolleys[triggerArgs.SourceProjectileVolley] then
							damageAddition = damageAddition + modifierData.MissingAmmoBaseDamageAddition * ( GetMaxAmmo( triggerArgs.SourceWeapon) - SessionMapState.AmmoVolleys[triggerArgs.SourceProjectileVolley].AmmoCount )
						end
					end
				end
			end
		end
	end
	if triggerArgs.SourceWeapon and WeaponData[triggerArgs.SourceWeapon] and WeaponData[triggerArgs.SourceWeapon].BaseDamageBonusMultiplier then
		damageAddition = round( damageAddition * GetTotalHeroTraitValue( WeaponData[triggerArgs.SourceWeapon].BaseDamageBonusMultiplier ))
	end

	return damageAddition
end

function CalculateDamageAdditions( attacker, victim, weaponData, triggerArgs )
	local damageAddition = 0
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in ipairs( attacker.OutgoingDamageModifiers ) do

			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects ))
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			
			if validWeapon and validActiveEffect and validProjectile then
				if modifierData.ValidAdditiveDamageAddition then
					damageAddition = damageAddition + modifierData.ValidAdditiveDamageAddition
				end
				if modifierData.FirstSummonHitDamageAddition and Contains(MapState.SpellSummons, attacker) and not SessionMapState.SummonFirstHitRecord[ attacker.ObjectId ] and victim ~= CurrentRun.Hero then
					damageAddition = damageAddition + modifierData.FirstSummonHitDamageAddition
					SessionMapState.SummonFirstHitRecord[ attacker.ObjectId ] = true
					if modifierData.FirstSummonHitDamagePresentation then
						local presentationData = modifierData.FirstSummonHitDamagePresentation
						if presentationData.FunctionName then
							thread( CallFunctionName, presentationData.FunctionName, victim, triggerArgs, presentationData)
						end
					end
				end	
				if modifierData.ArmorToDamageFlatConversion and attacker.HealthBuffer and attacker.HealthBuffer > 0 then
					damageAddition = damageAddition + math.floor( attacker.HealthBuffer * modifierData.ArmorToDamageFlatConversion )
				end
				if modifierData.FlatDamageToArmor and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 and victim.MaxHealthBuffer then
					damageAddition = damageAddition + modifierData.FlatDamageToArmor
				end
				-- IsEx is slightly expensive so they're all moved over here
				if  modifierData.NonExFlatDamageToArmor and weaponData and WeaponData[weaponData.Name] then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )

					if not isEx and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 and victim.MaxHealthBuffer then
						if modifierData.NonExFlatDamageToArmor  then
							damageAddition = damageAddition + modifierData.NonExFlatDamageToArmor
						end
					end
				end
			end
		end
	end
	return damageAddition
end

function addDamageMultiplier( data, multiplier )
	if multiplier >= 1.0 then
		if data.Multiplicative then
			damageReductionMultipliers = damageReductionMultipliers * multiplier
		else
			damageMultipliers = damageMultipliers + multiplier - 1
		end
		--[[
		if ConfigOptionCache.LogCombatMultipliers then
			lastAddedMultiplierName = data.Name or "Unknown"
			DebugPrint({Text = " Additive Damage Multiplier (" .. lastAddedMultiplierName .. "):" .. multiplier })
		end
		]]
	else
		if data.Additive then
			damageMultipliers = damageMultipliers + multiplier - 1
		else
			damageReductionMultipliers = damageReductionMultipliers * multiplier
		end
		--[[
		if ConfigOptionCache.LogCombatMultipliers then
			lastAddedMultiplierName = data.Name or "Unknown"
			DebugPrint({Text = " Multiplicative Damage Reduction (" .. lastAddedMultiplierName .. "):" .. multiplier })
		end
		]]
	end
end

function CalculateDamageMultipliers( attacker, victim, weaponData, triggerArgs )
	-- @temp Making global for optimization (remove local function definition) without needing to carefully pass into 90 calls to addDamageMultiplier()
	damageReductionMultipliers = 1
	damageMultipliers = 1.0
	lastAddedMultiplierName = ""

	--[[
	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = " SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
		if triggerArgs.SourceProjectile then
			DebugPrint({Text = " SourceProjectile: " .. tostring( triggerArgs.SourceProjectile)})
		end
	end
	]]

	if victim.QueuedDamageMultipliers then
		if triggerArgs.SourceProjectile and victim.QueuedDamageMultipliers[triggerArgs.SourceProjectile] then
			addDamageMultiplier({ Name = "QueuedDamage" }, victim.QueuedDamageMultipliers[triggerArgs.SourceProjectile] )
		end
	end

	if victim.IncomingDamageModifiers ~= nil then
		for i, modifierData in ipairs( victim.IncomingDamageModifiers ) do
			if modifierData.GlobalMultiplier ~= nil then
				addDamageMultiplier( modifierData, modifierData.GlobalMultiplier)
			end
			
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			local validBuffer = not modifierData.HealthOnly or (not victim.HealthBuffer or victim.HealthBuffer <= 0)
					
			if validBuffer and validWeapon and validProjectile and ( ( attacker and attacker.DamageType ~= "Neutral" ) or modifierData.IncludeObstacleDamage or modifierData.TrapDamageTakenMultiplier ) then
				if modifierData.ValidWeaponMultiplier then
					addDamageMultiplier( modifierData, modifierData.ValidWeaponMultiplier)
				end
				if modifierData.BossDamageMultiplier and attacker and ( attacker.IsBoss or attacker.IsBossDamage ) then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.NoLastStandDamageTakenMultiplier ~= nil and not HasLastStand( victim ) then
					addDamageMultiplier( modifierData, modifierData.NoLastStandDamageTakenMultiplier)
				end
				if modifierData.TrapDamageTakenMultiplier ~= nil and (( attacker ~= nil and attacker.DamageType == "Neutral" ) or (attacker == nil and triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil and EnemyData[triggerArgs.AttackerName].DamageType == "Neutral" )) then
					addDamageMultiplier( modifierData, modifierData.TrapDamageTakenMultiplier)
				end
				if modifierData.DistanceMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.DistanceMultiplier)
				end
				if modifierData.HasSummonMultiplier and not IsEmpty(MapState.SpellSummons) then
					addDamageMultiplier( modifierData, modifierData.HasSummonMultiplier )
				end
				if modifierData.SpellUsedMultiplier and SessionMapState.SpellUsed then
					addDamageMultiplier( modifierData, modifierData.SpellUsedMultiplier )
				end
				if modifierData.MoonBeamActiveMultiplier and SessionMapState.MoonBeamActive then
					addDamageMultiplier( modifierData, modifierData.MoonBeamActiveMultiplier )
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
				end
				if modifierData.NonTrapDamageTakenMultiplier ~= nil and (( attacker ~= nil and attacker.DamageType ~= "Neutral" ) or (attacker == nil and triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil and EnemyData[triggerArgs.AttackerName].DamageType ~= "Neutral" )) then
					addDamageMultiplier( modifierData, modifierData.NonTrapDamageTakenMultiplier)
				end
				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
					triggerArgs.TriggeredHitVulnerabilityMultiplier = true
				end
				if modifierData.NonPlayerMultiplier and attacker ~= CurrentRun.Hero and attacker ~= nil and not UnitSets.PlayerSummons[attacker.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.UseTraitValue and victim == CurrentRun.Hero then
					addDamageMultiplier( modifierData, GetTotalHeroTraitValue( modifierData.UseTraitValue, { IsMultiplier = modifierData.IsMultiplier }))
				end
				if modifierData.SelfMultiplier and attacker == victim then
					addDamageMultiplier( modifierData, modifierData.SelfMultiplier)
				end
				if modifierData.PlayerMultiplier and (attacker == CurrentRun.Hero or ( attacker ~= nil and UnitSets.PlayerSummons[attacker.Name] )) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier )
				end

				
				-- IsEx is slightly expensive so they're all moved over here
				if ( modifierData.ExMultiplier or modifierData.NonExMultiplier) and weaponData and WeaponData[weaponData.Name] then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
					if modifierData.ExMultiplier and isEx then
						addDamageMultiplier( modifierData, modifierData.ExMultiplier )
					elseif modifierData.NonExMultiplier and not isEx then
						addDamageMultiplier( modifierData, modifierData.NonExMultiplier )
					end
				end
			end
		end
	end

	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingDamageModifiers ) then
		local appliedEffectTable = {}
		for i, modifierData in ipairs( attacker.OutgoingDamageModifiers ) do
			if modifierData.GlobalMultiplier ~= nil then
				addDamageMultiplier( modifierData, modifierData.GlobalMultiplier)
			end
			local validEffect = modifierData.ValidEffects == nil or ( triggerArgs.EffectName ~= nil and Contains(modifierData.ValidEffects, triggerArgs.EffectName ))
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			local validTrait = modifierData.RequiredTrait == nil or ( attacker == CurrentRun.Hero and HeroHasTrait( modifierData.RequiredTrait ) )
			local validUniqueness = modifierData.Unique == nil or not modifierData.Name or not appliedEffectTable[modifierData.Name]
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects))
			local validActiveEffectGenus = modifierData.ValidActiveEffectGenus == nil or HasVulnerabilityGenusEffect( victim, modifierData.ValidActiveEffectGenus )
			local validActivatedTrait = modifierData.RequiredActivatedTraitName == nil or (HeroHasTrait(modifierData.RequiredActivatedTraitName) and GetHeroTrait(modifierData.RequiredActivatedTraitName).Activated)
			local validEnchantment = true
			if modifierData.WeaponOrProjectileRequirement then
				validWeapon = validWeapon or validProjectile
				validProjectile = validWeapon or validProjectile
			end
			if not validWeapon and modifierData.ConditionalValidWeapon then
				local conditionData = modifierData.ConditionalValidWeapon
				if conditionData.TraitName and HeroHasTrait(conditionData.TraitName) then
					if triggerArgs.SourceWeapon == conditionData.WeaponName then
						validWeapon = true
					end
				end
			end
			if triggerArgs.ExplicitMultipliersOnly and validWeapon and not modifierData.ValidWeaponsLookup then
				validWeapon = false
			end
			if modifierData.ValidEnchantments and attacker == CurrentRun.Hero then
				validEnchantment = false
				if modifierData.ValidEnchantments.TraitDependentWeapons then
					for traitName, validWeapons in pairs( modifierData.ValidEnchantments.TraitDependentWeapons ) do
						if Contains( validWeapons, triggerArgs.SourceWeapon) and HeroHasTrait( traitName ) then
							validEnchantment = true
							break
						end
					end
				end

				if not validEnchantment and modifierData.ValidEnchantments.ValidWeapons and Contains( modifierData.ValidEnchantments.ValidWeapons, triggerArgs.SourceWeapon ) then
					validEnchantment = true
				end
			end
			if validUniqueness and validWeapon and validProjectile and validEffect and validTrait and validEnchantment and validActiveEffect and validActiveEffectGenus and validActivatedTrait then
				if modifierData.Name then
					appliedEffectTable[ modifierData.Name] = true
				end
				if modifierData.VengeanceMultiplier and victim and GetGenusName(victim) == GameState.CauseOfDeath and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, modifierData.VengeanceMultiplier )
					triggerArgs.TriggeredVengeanceMultiplier = true
				end
				if modifierData.UndamagedMultiplier and not SessionMapState.DeactivatePerfectDamageBonus then
					addDamageMultiplier( modifierData, modifierData.UndamagedMultiplier )
				end
				if modifierData.HighHealthSourceMultiplierData then
					if attacker.Health / attacker.MaxHealth >= modifierData.HighHealthSourceMultiplierData.Threshold and modifierData.HighHealthSourceMultiplierData.ThresholdMultiplier then
						local newModifier = 1 + (modifierData.HighHealthSourceMultiplierData.Multiplier - 1) * modifierData.HighHealthSourceMultiplierData.ThresholdMultiplier
						addDamageMultiplier( modifierData, newModifier )
					else
						addDamageMultiplier( modifierData, modifierData.HighHealthSourceMultiplierData.Multiplier )
					end
				end
				if modifierData.JumpMultiplier and triggerArgs.NumJumps and ( not modifierData.ProjectileName or triggerArgs.SourceProjectile == modifierData.ProjectileName) then
					addDamageMultiplier( modifierData, 1 + ( modifierData.JumpMultiplier ) * triggerArgs.NumJumps )
				end
				if modifierData.LobGunSpecialHitMultiplier then
					addDamageMultiplier( modifierData, 1 + ( modifierData.LobGunSpecialHitMultiplier ) * TableLength( SessionMapState.LobGunSpecialHits ) )
				end
				if modifierData.PerUniqueGodMultiplier and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, 1 + ( modifierData.PerUniqueGodMultiplier - 1 ) * attacker.UniqueGodCount )
				end
				if modifierData.BossDamageMultiplier and victim.IsBoss then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.ActiveRootMultiplier and victim.RootActive then
					addDamageMultiplier( modifierData, modifierData.ActiveRootMultiplier )
				end
				if modifierData.LifetimeMultiplier and triggerArgs.LifetimeFraction then
					addDamageMultiplier( modifierData, 1 + modifierData.LifetimeMultiplier * triggerArgs.LifetimeFraction )
				end
				if modifierData.TransformedMultiplier and MapState.TransformArgs then
					addDamageMultiplier( modifierData, modifierData.TransformedMultiplier )
				end
				if modifierData.PerfectChargeMultiplier and triggerArgs.IsPerfectCharge then
					addDamageMultiplier( modifierData, modifierData.PerfectChargeMultiplier)
				end
				if modifierData.GameStateMultiplier and (modifierData.GameStateRequirements == nil or IsGameStateEligible( modifierData, modifierData.GameStateRequirements ) ) then
					addDamageMultiplier( modifierData, modifierData.GameStateMultiplier)
				end
				if modifierData.SpentLastStandMultiplier and CurrentRun.Hero.LastStandsUsed then
					addDamageMultiplier( modifierData, 1 + CurrentRun.Hero.LastStandsUsed * modifierData.SpentLastStandMultiplier )
				end
				if modifierData.UseTraitValue and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, GetTotalHeroTraitValue( modifierData.UseTraitValue, { IsMultiplier = modifierData.IsMultiplier }))
				end
				if modifierData.ConsecutivePercentDamage and attacker == CurrentRun.Hero and victim and victim.ObjectId and SessionMapState.ConsecutiveMoonBeamHits[ victim.ObjectId ] then
					addDamageMultiplier( modifierData, 1 + modifierData.ConsecutivePercentDamage * SessionMapState.ConsecutiveMoonBeamHits[ victim.ObjectId ] )
				end
				
				if modifierData.UseSessionMapStateValue and SessionMapState[modifierData.UseSessionMapStateValue] then
					addDamageMultiplier( modifierData, 1 + SessionMapState[modifierData.UseSessionMapStateValue] * modifierData.SessionMapStateMultiplier )
				end

				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
					triggerArgs.TriggeredHitVulnerabilityMultiplier = true
				end
				if modifierData.MinRequiredVulnerabilityEffects and victim.VulnerabilityEffects and TableLength( victim.VulnerabilityEffects ) >= modifierData.MinRequiredVulnerabilityEffects then
					--DebugPrint({Text = " min required vulnerability " .. modifierData.PerVulnerabilityEffectAboveMinMultiplier})
					addDamageMultiplier( modifierData, modifierData.VulnerabilityMultiplier)
				end
				if modifierData.HealthBufferDamageMultiplier and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 then
					addDamageMultiplier( modifierData, modifierData.HealthBufferDamageMultiplier)
				end
				if modifierData.ValidWeaponMultiplier then
					addDamageMultiplier( modifierData, modifierData.ValidWeaponMultiplier)
				end
				if modifierData.RequiredSelfEffectsMultiplier and not IsEmpty(attacker.ActiveEffects) then
					local hasAllEffects = true
					for _, effectName in pairs( modifierData.RequiredEffects ) do
						if not attacker.ActiveEffects[ effectName ] then
							hasAllEffects = false
						end
					end
					if hasAllEffects then
						addDamageMultiplier( modifierData, modifierData.RequiredSelfEffectsMultiplier)
					end
				end

				if modifierData.SelfEffectStackMultiplier and attacker.ActiveEffects[modifierData.EffectName] then
					local stacks = attacker.ActiveEffects[modifierData.EffectName]
					if modifierData.SelfEffectMaxStacks and stacks > modifierData.SelfEffectMaxStacks then
						stacks = modifierData.SelfEffectMaxStacks
					end
					addDamageMultiplier( modifierData, 1 + modifierData.SelfEffectStackMultiplier * stacks )
				end
				if modifierData.DistanceMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.DistanceMultiplier)
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceToAttackerSquared ~= nil and triggerArgs.DistanceToAttackerSquared ~= -1 and (( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceToAttackerSquared or ( modifierData.ProximityThresholdExclusionBoon and HeroHasTrait(modifierData.ProximityThresholdExclusionBoon))) then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
					triggerArgs.TriggeredProximityMultiplier = true
				end
				if modifierData.NoLastStandDamageOutputMultiplier ~= nil and not HasLastStand( attacker ) then
					addDamageMultiplier( modifierData, modifierData.NoLastStandDamageOutputMultiplier)
				end
				if modifierData.MaxHealthMultiplier and attacker.MaxHealth ~= nil then
					addDamageMultiplier(modifierData, 1 + modifierData.MaxHealthMultiplier * attacker.MaxHealth )
				end
				if modifierData.FriendMultiplier and ( victim == attacker or ( attacker.Charmed and victim == CurrentRun.Hero ) or ( not attacker.Charmed and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] )) then
					addDamageMultiplier( modifierData, modifierData.FriendMultiplier )
				end
				if modifierData.PlayerMultiplier and victim == CurrentRun.Hero then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier )
				end
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier )
				end
				if modifierData.ObstacleMultiplier and victim ~= CurrentRun.Hero and ActiveEnemies[victim.ObjectId] == nil then
					addDamageMultiplier( modifierData, modifierData.ObstacleMultiplier )
				end
				if modifierData.SuccessiveProjectileMultiplier and triggerArgs.ProjectileIndex and triggerArgs.MaxNumProjectiles then
					addDamageMultiplier( modifierData, 1 + (triggerArgs.ProjectileIndex % triggerArgs.MaxNumProjectiles ) * modifierData.SuccessiveProjectileMultiplier )
				end

				if modifierData.ValidSuitProjectile and SessionMapState.SuitBonusProjectileId [triggerArgs.ProjectileId] then
					addDamageMultiplier( modifierData, SessionMapState.SuitBonusProjectileId [triggerArgs.ProjectileId])	
				end

				if modifierData.GroupMultiplier and victim.Groups and Contains(victim.Groups, modifierData.TargetGroup) and not IsCharmed({ Id = attacker.ObjectId }) and not attacker.AlwaysTraitor and not triggerArgs.ProjectileDeflected then
					addDamageMultiplier( modifierData, modifierData.GroupMultiplier )
				end

				if modifierData.ChargeStageMultiplier and triggerArgs.ProjectileVolley and SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] and SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] >= modifierData.RequiredChargeStage then
					addDamageMultiplier( modifierData, modifierData.ChargeStageMultiplier )
				end

				if modifierData.EmptySlotMultiplier and modifierData.EmptySlotValidData then
					local filledSlots = {}

					for i, traitData in pairs( attacker.Traits ) do
						if traitData.Slot then
							filledSlots[traitData.Slot] = true
						end
					end

					for key, weaponList in pairs( modifierData.EmptySlotValidData ) do
						if not filledSlots[key] and Contains( weaponList, triggerArgs.SourceWeapon ) then
							addDamageMultiplier( modifierData, modifierData.EmptySlotMultiplier )
						end
					end
				end
				if modifierData.ValidProjectileIdMultiplier and triggerArgs.ProjectileId and SessionState.EarlyDetonationProjectileIds[triggerArgs.ProjectileId] then
					addDamageMultiplier( modifierData, modifierData.ValidProjectileIdMultiplier)
				end
				if modifierData.SpellUsedMultiplier and SessionMapState.SpellUsed then
					addDamageMultiplier( modifierData, modifierData.SpellUsedMultiplier )
				end
				if modifierData.AloneMultiplier and victim and GetClosest({Id = victim.ObjectId, DestinationName = "EnemyTeam", Distance = modifierData.AloneDistance , IgnoreSelf = true, IgnoreHomingIneligible = true, IgnoreUntargetable = false}) == 0 then
					addDamageMultiplier( modifierData, modifierData.AloneMultiplier )
				end

				-- IsEx is slightly expensive so they're all moved over here
				if ( modifierData.NonExMultiplier or modifierData.ExMultiplier or modifierData.ExRunDamagedThreshold or modifierData.NonExLowManaDamageMultiplier or modifierData.LifetimeNonExMultiplier) and weaponData and WeaponData[weaponData.Name] then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
					if modifierData.ExMultiplier and isEx then
						addDamageMultiplier( modifierData, modifierData.ExMultiplier )
					elseif modifierData.NonExMultiplier and not isEx then
						addDamageMultiplier( modifierData, modifierData.NonExMultiplier )
					end
					if modifierData.ExRunDamagedThreshold and not CurrentRun.Hero.IsDead and isEx and CurrentRun.TotalDamageTaken >= modifierData.ExRunDamagedThreshold then
						addDamageMultiplier( modifierData, modifierData.ExRunDamagedMultiplier )
					end
					if modifierData.NonExLowManaDamageMultiplier  and not isEx and CurrentRun.Hero.Mana/GetHeroMaxAvailableMana() <= modifierData.LowManaThreshold then
						addDamageMultiplier( modifierData, modifierData.NonExLowManaDamageMultiplier)
					end
					if modifierData.LifetimeNonExMultiplier and triggerArgs.LifetimeFraction and not isEx then
						addDamageMultiplier( modifierData, 1 + modifierData.LifetimeNonExMultiplier * triggerArgs.LifetimeFraction )
					end
				end
			end
		end
	end

	if weaponData ~= nil then
		if attacker == victim and weaponData.SelfMultiplier then
			addDamageMultiplier( { Name = weaponData.Name, Multiplicative = true }, weaponData.SelfMultiplier)
		end

		if weaponData.OutgoingDamageModifiers ~= nil and not weaponData.IgnoreOutgoingDamageModifiers then
			for i, modifierData in ipairs( weaponData.OutgoingDamageModifiers ) do
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.ObstacleMultiplier and victim ~= CurrentRun.Hero and ActiveEnemies[victim.ObjectId] == nil then
					addDamageMultiplier( modifierData, modifierData.ObstacleMultiplier )
				end
				if modifierData.PlayerMultiplier and ( victim == CurrentRun.Hero or UnitSets.PlayerSummons[victim.Name] ) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier)
				end
			end
		end
	end
	local projectileData = nil
	if triggerArgs.SourceProjectile then
		projectileData = ProjectileData[triggerArgs.SourceProjectile]
	end
	if projectileData ~= nil then
		if attacker == victim and projectileData.SelfMultiplier then
			addDamageMultiplier( { Name = projectileData.Name, Multiplicative = true }, projectileData.SelfMultiplier)
		end

		if projectileData.OutgoingDamageModifiers ~= nil and not projectileData.IgnoreOutgoingDamageModifiers then
			for i, modifierData in ipairs( projectileData.OutgoingDamageModifiers ) do
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.PlayerMultiplier and ( victim == CurrentRun.Hero or UnitSets.PlayerSummons[victim.Name] ) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier)
				end
				if modifierData.ObstacleMultiplier and victim ~= CurrentRun.Hero and ActiveEnemies[victim.ObjectId] == nil then
					addDamageMultiplier( modifierData, modifierData.ObstacleMultiplier )
				end
			end
		end
	end

	--[[
	if ConfigOptionCache.LogCombatMultipliers and triggerArgs and triggerArgs.AttackerName and triggerArgs.DamageAmount then
		DebugPrint({Text = triggerArgs.AttackerName .. ": Base Damage : " .. triggerArgs.DamageAmount .. " Damage Bonus: " .. damageMultipliers .. ", Damage Reduction: " .. damageReductionMultipliers })
	end
	]]
	return damageMultipliers * damageReductionMultipliers
end

function addCritMultiplier( data, multiplier, args )
	--[[
	if ConfigOptionCache.LogCombatMultipliers  then
		DebugPrint({Text = " CritChance Addition: " .. multiplier })
	end
	]]
	args.CritChance = args.CritChance + multiplier
end

function CalculateCritChance( attacker, victim, weaponData, triggerArgs )
	triggerArgs.CritChance = 0
	--[[
	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = "Crit SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
	end
	]]

	if attacker ~= nil and attacker.OutgoingCritModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingCritModifiers ) then
		local appliedEffectTable = {}
		for i, modifierData in ipairs( attacker.OutgoingCritModifiers ) do

			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validTrait = modifierData.RequiredTrait == nil or ( attacker == CurrentRun.Hero and HeroHasTrait( modifierData.RequiredTrait ) )
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects))
			local validEx = true
			if modifierData.IsEx or modifierData.IsNotEx then
				validEx = false
				if weaponData then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
					if modifierData.IsEx and isEx then
						validEx = true
					elseif modifierData.IsNotEx and not isEx then
						validEx = true
					end
				end
			end
			if validWeapon and validTrait and validActiveEffect and validEx  and validProjectile then
				if modifierData.Chance then
					addCritMultiplier( modifierData, modifierData.Chance, triggerArgs )
				end
				if attacker == CurrentRun.Hero then

					if modifierData.PotionCastCritChance and triggerArgs.ProjectileId and SessionMapState.PotionCastIds[triggerArgs.ProjectileId] then
						addCritMultiplier( modifierData, modifierData.PotionCastCritChance, triggerArgs )
					end
					if modifierData.DistanceThresholdChance and triggerArgs.DistanceToAttackerSquared ~= nil and triggerArgs.DistanceToAttackerSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceToAttackerSquared then
						addCritMultiplier( modifierData, modifierData.DistanceThresholdChance, triggerArgs )
					end
					if modifierData.TargetHighHealthPercentThreshold and victim and victim.MaxHealth and (victim.Health/victim.MaxHealth) >= modifierData.TargetHighHealthPercentThreshold and
						( victim.HealthBuffer == nil or victim.MaxHealthBuffer == nil or victim.HealthBuffer == 0 or ( victim.HealthBuffer / victim.MaxHealthBuffer >= modifierData.TargetHighHealthPercentThreshold )) then
						addCritMultiplier( modifierData, modifierData.TargetHighHealthChance, triggerArgs )
					end
					if modifierData.ValidVolleyChance and MapState.CritVolleys and MapState.CritVolleys [triggerArgs.SourceWeapon] and MapState.CritVolleys[triggerArgs.SourceWeapon][triggerArgs.ProjectileVolley] then
						addCritMultiplier( modifierData, modifierData.ValidVolleyChance, triggerArgs )	
					end
					if modifierData.DifferentOmegaChance and SessionMapState.DifferentOmegaVolleys and triggerArgs.SourceProjectileVolley and
						((SessionMapState.DifferentOmegaVolleys [triggerArgs.SourceWeapon] and SessionMapState.DifferentOmegaVolleys[triggerArgs.SourceWeapon][triggerArgs.SourceProjectileVolley]) or 
						( SessionMapState.DifferentOmegaProjectileIds[triggerArgs.SourceWeapon] and SessionMapState.DifferentOmegaProjectileIds[triggerArgs.SourceWeapon][triggerArgs.ProjectileId] ))  then
						addCritMultiplier( modifierData, modifierData.DifferentOmegaChance, triggerArgs )	
					end
					if modifierData.ValidLeapVolleyChance and SessionMapState.LeapCritVolleys and triggerArgs.SourceProjectileVolley and
						(( SessionMapState.LeapCritVolleys [triggerArgs.SourceWeapon] and SessionMapState.LeapCritVolleys[triggerArgs.SourceWeapon][triggerArgs.SourceProjectileVolley]) or
						( SessionMapState.LeapCritProjectileIds[triggerArgs.SourceWeapon] and SessionMapState.LeapCritProjectileIds[triggerArgs.SourceWeapon][triggerArgs.ProjectileId] )) then
						addCritMultiplier( modifierData, modifierData.ValidLeapVolleyChance, triggerArgs )
						if SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId] and SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId].LeapCrit and SessionMapState.LeapCritProjectileIds[triggerArgs.SourceWeapon] then
							SessionMapState.LeapCritProjectileIds[triggerArgs.SourceWeapon][triggerArgs.ProjectileId] = nil
							SessionMapState.ClearBonusOnHitProjectileIds[triggerArgs.ProjectileId].LeapCrit = nil
						end
					end
					if modifierData.HeroTraitValue then
						addCritMultiplier( modifierData, GetTotalHeroTraitValue( modifierData.HeroTraitValue ), triggerArgs )	
					end
					if modifierData.ActiveTraitChance then
						local trait = GetHeroTrait( modifierData.TraitName )
						if trait ~= nil and IsTraitActive( trait ) then
							addCritMultiplier( modifierData, modifierData.ActiveTraitChance, triggerArgs )
						end
					end
				end
			end
		end
	end

	if victim ~= nil then
		if victim.ActiveEffects then
			for effectName in pairs (victim.ActiveEffects) do
				local effectData = EffectData[effectName]
				if effectData and effectData.CritVulnerability then
					addCritMultiplier( effectData, effectData.CritVulnerability, triggerArgs )
				end
			end
		end
	end
	--[[
	if ConfigOptionCache.LogCombatMultipliers and attacker then
		DebugPrint({ Text = tostring( attacker.Name ) .. ": Crit Chance : " .. triggerArgs.CritChance })
	end
	]]
	return triggerArgs.CritChance
end

function addDdMultiplier( data, multiplier, args )				
	--[[
	if ConfigOptionCache.LogCombatMultipliers  then
		DebugPrint({Text = " Double Damage Chance Addition: " .. multiplier })
	end
	]]
	args.DdChance = args.DdChance + multiplier
end

function CalculateDoubleDamageChance( attacker, victim, weaponData, triggerArgs )
	triggerArgs.DdChance = 0
	if not attacker or IsEmpty(attacker.OutgoingDoubleDamageModifiers) then
		return triggerArgs.DdChance
	end
	
	--[[
	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = "DoubleDamage SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
	end
	]]

	if attacker ~= nil and attacker.OutgoingDoubleDamageModifiers ~= nil then
		local appliedEffectTable = {}
		for i, modifierData in ipairs( attacker.OutgoingDoubleDamageModifiers ) do

			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validTrait = modifierData.RequiredTrait == nil or ( attacker == CurrentRun.Hero and HeroHasTrait( modifierData.RequiredTrait ) )
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects))
			local validEx = true
			if modifierData.IsEx or modifierData.IsNotEx then
				validEx = false
				if weaponData then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
					if modifierData.IsEx and isEx then
						validEx = true
					elseif modifierData.IsNotEx and not isEx then
						validEx = true
					end
				end
			end
			if validWeapon and validTrait and validActiveEffect and validEx then
			
				if modifierData.Chance then
					addDdMultiplier( modifierData, modifierData.Chance, triggerArgs )
				end
				if modifierData.IncreasingHealthThresholdCritChance then
					local missingLife = CurrentRun.Hero.MaxHealth - CurrentRun.Hero.Health
					addDdMultiplier( modifierData, modifierData.IncreasingHealthThresholdCritChance * missingLife, triggerArgs )
				end
			end
		end
	end
	--[[
	if ConfigOptionCache.LogCombatMultipliers and attacker then
		DebugPrint({Text = tostring( attacker.Name )..": DoubleDamage Chance : "..triggerArgs.DdChance })
	end
	]]
	return triggerArgs.DdChance
end

function CalculateLifestealModifiers( attacker, victim, weaponData, triggerArgs )
	local lifesteal = 0
	local unmultipliedLifeSteal = 0
	local limitedLifestealContribution = 0
	if not attacker or triggerArgs.ProjectileDeflected then
		return
	end
	if attacker.OutgoingLifestealModifiers and victim ~= nil and not victim.BlockLifeSteal then
		for i, modifierData in pairs( attacker.OutgoingLifestealModifiers ) do
			local validWeapon = modifierData.ValidWeapons == nil or ( Contains( modifierData.ValidWeapons, triggerArgs.SourceWeapon ) and triggerArgs.EffectName == nil )
			local validSelfEffect = modifierData.RequiredEffect == nil or ( attacker.ActiveEffects and attacker.ActiveEffects[modifierData.RequiredEffect])
			local validHealthThreshold = modifierData.RequiredMaxHealth == nil or attacker.Health < modifierData.RequiredMaxHealth
			
			if validWeapon and validSelfEffect and validHealthThreshold then
				local modifierLifesteal = triggerArgs.DamageAmount * modifierData.ValidMultiplier
				if modifierData.MinLifesteal and modifierLifesteal < modifierData.MinLifesteal then
					modifierLifesteal = modifierData.MinLifesteal
				elseif modifierData.MaxLifesteal and modifierLifesteal > modifierData.MaxLifesteal then
					modifierLifesteal = modifierData.MaxLifesteal
				end
				if modifierData.AddHeroTraitValue then
					modifierLifesteal = modifierLifesteal + GetTotalHeroTraitValue(modifierData.AddHeroTraitValue)
				end
				if modifierData.LimitedUse then
					if modifierLifesteal > modifierData.LimitedUse then
						modifierLifesteal = modifierData.LimitedUse
					end
					limitedLifestealContribution = limitedLifestealContribution + modifierLifesteal
				end
				if modifierData.Unmultiplied then
					unmultipliedLifeSteal = unmultipliedLifeSteal + modifierLifesteal
				end

				lifesteal = lifesteal + modifierLifesteal
			end
		end
	end
	if lifesteal <= 0 then
		return
	end
	local healingMultiplier = CalculateHealingMultiplier()
	local expectedHeal = round(lifesteal * healingMultiplier)
	if unmultipliedLifeSteal > 0 then
		expectedHeal = round((lifesteal - unmultipliedLifeSteal) * healingMultiplier + unmultipliedLifeSteal)
	end
	local expectedLimitedHeal = round(limitedLifestealContribution)
	local maxHealth = attacker.MaxHealth
	if attacker == CurrentRun.Hero then
		maxHealth = GetHeroMaxAvailableHealth()
	end
	if maxHealth and attacker.Health and expectedLimitedHeal > 0 then
		local missingHealth = maxHealth - attacker.Health
		if missingHealth <= (expectedHeal - expectedLimitedHeal) then
			expectedLimitedHeal = 0
		elseif missingHealth > ( expectedHeal - expectedLimitedHeal ) and missingHealth < expectedHeal then
			expectedLimitedHeal = maxHealth - (attacker.Health + (expectedHeal - expectedLimitedHeal ))
		end
		if expectedLimitedHeal > 0 then
			for i, modifierData in pairs( attacker.OutgoingLifestealModifiers ) do
				if modifierData.LimitedUse then
					modifierData.LimitedUse = modifierData.LimitedUse - expectedLimitedHeal
					CurrentRun.LifestealUses = modifierData.LimitedUse
					UpdateTraitNumber( GetHeroTrait("HadesLifestealBoon") )
				end
			end
		end
	end
	if attacker.Health and maxHealth and attacker.Health < maxHealth then
		Heal( attacker, { HealAmount = expectedHeal, SourceName = "CombatLifesteal", Silent = false } )
	end
end

function HasVulnerabilityGenusEffect( victim, genusName )
	if not victim.ActiveEffects then
		return false
	end
	for effectName in pairs( victim.ActiveEffects ) do
		local effectData = EffectData[effectName]
		if effectData and effectData.DisplaySuffix == genusName then
			return true
		end
	end
	return false
end

function HasEffectWithEffectGroup( victim, inheritName )
	if not victim.ActiveEffects then
		return false
	end
	for effectName in pairs( victim.ActiveEffects ) do
		local effectData = EffectData[effectName]
		if effectData and effectData.EffectGroup == inheritName then
			return true
		end
	end
	return false

end

function Damage( victim, triggerArgs )

	if victim == nil or victim.Health == nil or ( victim.IsDead and not triggerArgs.PureDamage ) or victim.IgnoreDamage then
		return
	end

	if SessionMapState.HandlingDeath then
		-- No damage can occur after the hero dies
		return
	end

	triggerArgs.triggeredById = triggerArgs.triggeredById  or victim.ObjectId

	if not triggerArgs.PureDamage then
		if triggerArgs.IsInvulnerable or (victim.InvulnerableFlags ~= nil and not IsEmpty( victim.InvulnerableFlags )) then
			if not triggerArgs.Silent then
				thread( BlockedDamageInvulnerablePresentation, victim, triggerArgs )
			end
			return
		end

		local attacker = triggerArgs.AttackerTable
		local sourceProjectileData = nil
		local sourceEffectData = nil
		local sourceWeaponData = GetWeaponData( attacker, triggerArgs.SourceWeapon )
		if triggerArgs.SourceProjectile ~= nil then
			sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
		end
		if triggerArgs.EffectName ~= nil then
			sourceEffectData = EffectData[triggerArgs.EffectName]
		end
		if not sourceProjectileData or not sourceProjectileData.IgnoreAllModifiers then
			local baseDamage = CalculateBaseDamage( attacker, victim, triggerArgs )
			if not triggerArgs.IgnoreFutureModifiers then
				baseDamage = baseDamage + CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
				if triggerArgs.MissingEffectDamageIncrease then
					triggerArgs.MissingEffectDamagePercent = triggerArgs.MissingEffectDamageIncrease/baseDamage
				end
				local multipliers = CalculateDamageMultipliers( attacker, victim, sourceWeaponData, triggerArgs )
				local additive = CalculateDamageAdditions( attacker, victim, sourceWeaponData, triggerArgs )
				local critChance = CalculateCritChance( attacker, victim, sourceWeaponData, triggerArgs )
				local ddChance = CalculateDoubleDamageChance( attacker, victim, sourceWeaponData, triggerArgs )
				local luckMultiplier = GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } )
				if attacker == CurrentRun.Hero then
					critChance = critChance * luckMultiplier 
					critChance = critChance + GetTotalHeroTraitValue("OutgoingUnmodifiedCritBonus")
				end
				triggerArgs.IsCrit = RandomChance( critChance )
				triggerArgs.IsDoubleDamage = RandomChance( ddChance * luckMultiplier )
				triggerArgs.DamageAmount = round(baseDamage * multipliers) + additive
			else
				triggerArgs.DamageAmount = baseDamage
			end
		end
		if triggerArgs.IsCrit and (not sourceEffectData or not sourceEffectData.BlockCrit ) and (not sourceProjectileData or not sourceProjectileData.BlockCrit) then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * 3
		else
			triggerArgs.IsCrit = nil
		end
		if triggerArgs.IsDoubleDamage and (not sourceEffectData or not sourceEffectData.BlockDoubleDamage ) then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * 2
		else
			triggerArgs.IsDoubleDamage = nil
		end
		
		local damageFloorTrait = CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor
		if damageFloorTrait ~= nil and attacker ~= nil and attacker == CurrentRun.Hero and (not sourceEffectData or not sourceEffectData.BlockDamageFloor ) then
			if damageFloorTrait.ActivationRequirements == nil or IsGameStateEligible( damageFloorTrait, damageFloorTrait.ActivationRequirements ) then
				if triggerArgs.DamageAmount > 0 and triggerArgs.DamageAmount < damageFloorTrait.ActivatedDamageFloor then
					triggerArgs.DamageAmount = damageFloorTrait.ActivatedDamageFloor
				end
			end
		end
		
		if victim == CurrentRun.Hero then
			for _, modifierData in ipairs(GetHeroTraitValues("DamageClamps")) do
				local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
				if validProjectile and triggerArgs.DamageAmount > modifierData.Value then
					triggerArgs.DamageAmount = modifierData.Value
				end
			end
		end
		CalculateLifestealModifiers( attacker, victim, sourceWeaponData, triggerArgs )
		if sourceProjectileData ~= nil and sourceProjectileData.ClearEffect ~= nil then
			ClearEffect({ Id = victim.ObjectId, Name = sourceProjectileData.ClearEffect })
		end

		if victim.AIEndHealthThreshold ~= nil then
			local healthThreshold = victim.MaxHealth * victim.AIEndHealthThreshold
			local remainingThresholdHealth = (victim.Health - healthThreshold) + 1
			if triggerArgs.DamageAmount > remainingThresholdHealth then
				triggerArgs.DamageAmount = remainingThresholdHealth
			end
		end

		if ConfigOptionCache.EasyMode and victim == CurrentRun.Hero then
			triggerArgs.DamageAmount = math.ceil( triggerArgs.DamageAmount * CalcEasyModeMultiplier() )
		end

		if triggerArgs.DamageAmount > 0 and (victim.MaxHealth or 0) > 0 then
			local source = sourceEffectData or sourceProjectileData or sourceWeaponData
			if triggerArgs.DamageSourceName then
				source = source or {}
				source.Name = triggerArgs.DamageSourceName
			end
			if source ~= nil then
				local damageForRecord = math.min( triggerArgs.DamageAmount, victim.Health )
				local damageDealtRecordName = nil

				if attacker ~= nil then
					if attacker.ExcludeFromDamageDealtRecord then
						-- Do not record this damage
					elseif attacker == CurrentRun.Hero or attacker == MapState.FamiliarUnit or attacker.DamageType == "Ally" or ( attacker.DamageType == "Neutral" and victim ~= CurrentRun.Hero and victim.DamageType ~= "Neutral" ) then
						damageDealtRecordName = "DamageDealtByHeroRecord"
					elseif victim ~= CurrentRun.Hero then
						if IsCharmed({ Id = attacker.ObjectId }) then
							damageDealtRecordName = "DamageDealtByCharmedEnemiesRecord"
						else
							-- Do not record other forms of enemy-to-enemy damage
						end
					else
						damageDealtRecordName = "DamageDealtByEnemiesRecord"
					end
				elseif triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil then
					if EnemyData[triggerArgs.AttackerName].DamageType == "Neutral" and victim ~= CurrentRun.Hero then
						if victim.DamageType ~= "Neutral" then
							damageDealtRecordName = "DamageDealtByHeroRecord"
						else
							-- Do not record trap damage to other traps (e.g. exploding barrels)
						end
					else
						damageDealtRecordName = "DamageDealtByEnemiesRecord"
					end
				elseif victim ~= CurrentRun.Hero then
					damageDealtRecordName = "DamageDealtByHeroRecord"
				end
				if damageDealtRecordName ~= nil then
					GameState[damageDealtRecordName][source.Name] = (GameState[damageDealtRecordName][source.Name] or 0) + damageForRecord
					CurrentRun[damageDealtRecordName][source.Name] = (CurrentRun[damageDealtRecordName][source.Name] or 0) + damageForRecord
				end
			else
				local attackerName = triggerArgs.AttackerName or "nil"
				if attacker ~= nil then
					attackerName = attacker.Name
				end
				DebugAssert({ Condition = false, Text = "Attacker " .. attackerName .. " has no source for its damage from Projectile: " .. tostring(triggerArgs.SourceProjectile), Owner = "James" })
			end
		end

		local validDamageAmount = (triggerArgs.DamageAmount > 0 or (sourceWeaponData ~= nil and sourceWeaponData.TriggersPlayerOnHitPresentation and victim == CurrentRun.Hero ) or  (sourceProjectileData ~= nil and sourceProjectileData.TriggersPlayerOnHitPresentation and victim == CurrentRun.Hero ))
		if validDamageAmount and not triggerArgs.Silent and (sourceEffectData == nil or not sourceEffectData.RapidDamageType ) and ( sourceWeaponData == nil or not sourceWeaponData.RapidDamageType ) then
			if victim.DamagedAnimation ~= nil and not victim.SkipDamageAnimation then
				local damagedAnimBlocked = false
				if victim.ActiveEffects ~= nil then
					for effectName, v in pairs( victim.ActiveEffects ) do
						local effectData = EffectData[effectName]
						if effectData ~= nil and effectData.BlockDamageAnimation then
							damagedAnimBlocked = true
							break
						end
					end
				end
				if victim == CurrentRun.Hero and not IsPlayerInterruptible() then
					damagedAnimBlocked = true
				end
				if not damagedAnimBlocked then
					local damagedAnimation = victim.DamagedAnimation
					if victim.Weapons ~= nil and not MapState.HostilePolymorph then
						for weaponName, v in pairs( victim.Weapons ) do
							local weaponData = WeaponData[weaponName]
							if weaponData ~= nil and weaponData.DamagedAnimation ~= nil then
								damagedAnimation = weaponData.DamagedAnimation
								break
							end
						end
					end
					SetAnimation({ DestinationId = victim.ObjectId, Name = damagedAnimation })
				end
			end
			GenericDamagePresentation( victim, triggerArgs )
		end
	end

	if victim == CurrentRun.Hero then

		if SessionState.BlockHeroDamage then
			return
		end

		if ConfigOptionCache.DamageTakenMultiplier ~= 1.0 then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * ConfigOptionCache.DamageTakenMultiplier
		end
		
		if triggerArgs.DamageAmount > 1 and not triggerArgs.PureDamage then
			local damageShave = GetTotalHeroTraitValue("DamageShave")
			triggerArgs.DamageAmount = triggerArgs.DamageAmount - damageShave
			if triggerArgs.DamageAmount < 1 then
				triggerArgs.DamageAmount = 1
			end
		end
		if HasHeroTraitValue("MoneyShieldData") then
			local moneyShieldData = GetHeroTraitValues("MoneyShieldData")[1]
			local moneyCost = math.ceil(triggerArgs.DamageAmount * moneyShieldData.Multiplier)
			local currentMoney = GetResourceAmount( "Money" )
			local damageBlocked = 0
			if currentMoney >= moneyCost then
				SpendResource( "Money", moneyCost, "MoneyShield", { NoLifetimeEffect = true, SkipQuestStatusCheck = true, SkipResourceSpendPresentation = true } )
				damageBlocked = triggerArgs.DamageAmount
				triggerArgs.DamageAmount = 0
				ManaDelta( GetTotalHeroTraitValue( "OnDamagedManaConversionFlat" ) )
				CurrentRun.HasMoneyShield = true
			else
				if CurrentRun.HasMoneyShield then
					CurrentRun.HasMoneyShield = nil
					thread( MoneyShieldDeactivatedPresentation )
				end
				local maxDamageBlocked = math.floor(currentMoney / moneyShieldData.Multiplier)
				SpendResource( "Money", maxDamageBlocked * moneyShieldData.Multiplier , "MoneyShield", { NoLifetimeEffect = true, SkipQuestStatusCheck = true, SkipResourceSpendPresentation = true } )
				damageBlocked = maxDamageBlocked
				triggerArgs.DamageAmount = triggerArgs.DamageAmount - maxDamageBlocked 
			end
			if damageBlocked > 0 then
				thread(MoneyShieldBlockPresentation, damageBlocked, damageBlocked * moneyShieldData.Multiplier )
			end
		end
		if HasHeroTraitValue("ManaShieldData") then
			local manaShieldData = GetHeroTraitValues("ManaShieldData")[1]
			local manaCost = math.ceil(math.ceil(triggerArgs.DamageAmount * manaShieldData.DamageBlocked) * manaShieldData.ManaPerDamageBlocked)
			if manaCost > CurrentRun.Hero.Mana then
				manaCost = CurrentRun.Hero.Mana
			end
			triggerArgs.DamageAmount = triggerArgs.DamageAmount - math.ceil( manaCost / manaShieldData.ManaPerDamageBlocked )
			ManaDelta( -manaCost, { IgnoreSpend = true, ManaDrain = true })
		end

		local damageCapTraitData = HasHeroTraitValue("ActivatedDamageCap") 
		if damageCapTraitData and not triggerArgs.IgnoreCap then
			if damageCapTraitData.ActivationRequirements == nil or IsGameStateEligible( damageCapTraitData, damageCapTraitData.ActivationRequirements ) then
				if triggerArgs.DamageAmount > damageCapTraitData.ActivatedDamageCap then
					triggerArgs.DamageAmount = damageCapTraitData.ActivatedDamageCap
				end
			end
		end
		local damageReductionTraitData = HasHeroTraitValue("ActivatedDamageReduction") 
		if damageReductionTraitData and not triggerArgs.IgnoreCap then
			if damageReductionTraitData.ActivationRequirements == nil or IsGameStateEligible( damageReductionTraitData, damageReductionTraitData.ActivationRequirements ) then
				if triggerArgs.DamageAmount >= damageReductionTraitData.ActivatedDamageReductionThreshold then
					triggerArgs.DamageAmount = triggerArgs.DamageAmount - damageReductionTraitData.ActivatedDamageReduction
				end
			end
		end
		local healthProtected = ProcessHealthBuffer( CurrentRun.Hero, triggerArgs )
		if not healthProtected then
			victim.Health = victim.Health - triggerArgs.DamageAmount
			if CurrentRun.CurrentRoom.TempHealth and CurrentRun.CurrentRoom.TempHealth > 0 then
				CurrentRun.CurrentRoom.TempHealth = math.max( 0, CurrentRun.CurrentRoom.TempHealth - triggerArgs.DamageAmount)
			end
			if triggerArgs.MinHealth ~= nil and victim.Health < triggerArgs.MinHealth then
				victim.Health = triggerArgs.MinHealth
			end
		end
		triggerArgs.HealthProtected = healthProtected
		if victim.Health <= 0 then
			triggerArgs.OverkillAmount = -victim.Health
			victim.Health = 0
			DamageHero( victim, triggerArgs )
			if not triggerArgs.IgnoreLastStand and CheckLastStand( victim, triggerArgs ) then
				return
			end
		else
			DamageHero( victim, triggerArgs )
		end
	else

		if ConfigOptionCache.DamageMultiplier ~= 1.0 then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * ConfigOptionCache.DamageMultiplier
		end
		
		DamageEnemy( victim, triggerArgs )
	end

	local cannotDieFromDamage = victim.CannotDieFromDamage
	if SessionState.BlockHeroDeath and victim == CurrentRun.Hero then
		cannotDieFromDamage = true
	elseif triggerArgs.DamageAmount <= 0 then
		cannotDieFromDamage = true -- Can never die from 0 damage
	end

	if victim.Health <= 0 and not cannotDieFromDamage then

		if victim.ActivateFuseOnDeath then
			ActivateFuse( victim )
			return
		end

		if victim.ClearChillOnDeath then
			ClearEffect({ Id = victim.ObjectId, Name = "ChillEffect" })
		end
		if victim.Phases ~= nil and victim.CurrentPhase < victim.Phases then
			SetUnitInvulnerable( victim )
			local clearArgs = { Id = victim.ObjectId, All = true, ExcludeNames = { "BeamRotation" } }
			ClearEffect( clearArgs )
			EffectPostClearAll( victim, clearArgs )
			return
		end
		if victim.SkipDeathFunction ~= nil then
			CallFunctionName(victim.SkipDeathFunction, victim, victim.SkipDeathFunctionArgs)
			return
		end
		triggerArgs.Killed = true
		triggerArgs.SkipDestroy = triggerArgs.SkipDestroy or victim.SkipDestroy
		Kill( victim, triggerArgs )
	end

end

function CalcEasyModeMultiplier( level )
	if GameState == nil then
		return 0
	end
	local easyModeMultiplier = HeroData.EasyModeDamageMultiplierBase + (HeroData.EasyModeDamageMultiplierPerDeath * math.min( HeroData.EasyModeDamageMultiplierDeathCap, level or GameState.EasyModeLevel ) )
	local multiplierCap = 1 - ConfigOptionCache.EasyModeResistanceCap
	if easyModeMultiplier < multiplierCap then
		easyModeMultiplier = multiplierCap
	end
	return easyModeMultiplier
end

function DamageEnemy( victim, triggerArgs )

	local sourceWeaponData = triggerArgs.AttackerWeaponData
	local attacker = triggerArgs.AttackerTable

	-- Used to detect death via artemis vulnerability crit even though it's cleared on a crit
	victim.ActiveEffectsAtDamageStart = {}
	if victim.ActiveEffects then
		victim.ActiveEffectsAtDamageStart = ShallowCopyTable( victim.ActiveEffects )
	end

	if triggerArgs.EffectName ~= nil then
		local effectData = EffectData[triggerArgs.EffectName] 
		if effectData ~= nil and effectData.NonPlayerDamageMultiplier ~= nil then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * effectData.NonPlayerDamageMultiplier
		end
	end

	if sourceWeaponData ~= nil then
		if sourceWeaponData.ForceCrit then
			triggerArgs.IsCrit = true
		end
	end

	if triggerArgs.DamageAmount == 0 then
		return
	end
	
	if victim.DodgeCooldown ~= nil and CheckCooldown( victim.Name.."DodgeReady", victim.DodgeCooldown ) then
		EnemyDodge(victim, triggerArgs)
		return
	end

	thread( CheckOnDamagedPowers, victim, attacker, triggerArgs )

	local healthProtected = ProcessHealthBuffer( victim, triggerArgs )
	if not healthProtected then
		if victim.AIEndHealthThreshold ~= nil then
			local healthThreshold = victim.MaxHealth * victim.AIEndHealthThreshold
			local remainingThresholdHealth = (victim.Health - healthThreshold) + 1
			if triggerArgs.DamageAmount > remainingThresholdHealth then
				triggerArgs.DamageAmount = remainingThresholdHealth
				if triggerArgs.DamageAmount <= 0 then
					return
				end
			end
		end

		victim.Health = victim.Health - triggerArgs.DamageAmount
		if triggerArgs.MinHealth ~= nil and victim.Health < triggerArgs.MinHealth then
			victim.Health = triggerArgs.MinHealth
		end
		if victim.Health < 0 then
			triggerArgs.OverkillAmount = -victim.Health
			victim.Health = 0
		end
	end

	if not victim.EarlyExit and not victim.IsDead and victim.Health > 0 and triggerArgs.DamageAmount > 0 then
		CreateHealthBar( victim )
	end
	UpdateHealthBar( victim, triggerArgs.DamageAmount, triggerArgs )

	if not victim.SkipDamageText and not triggerArgs.Silent then
		local weaponData = GetWeaponData(triggerArgs.AttackerTable, triggerArgs.SourceWeapon)
		if triggerArgs.DamageAmount > 0 or weaponData == nil or not weaponData.SkipDamageTextIfNoDamage then
			table.insert( SessionMapState.PresentationQueue, { FunctionName = "DisplayDamageText", Source = victim, Args = triggerArgs, Threaded = true } )
		end
	end

	if not victim.SkipDamagePresentation and ( attacker == CurrentRun.Hero or not victim.SkipDamagePresentationFromNonPlayerUnits ) then
		if (victim.HitShields ~= nil and victim.HitShields > 0) or (victim.HealthBuffer ~= nil and victim.HealthBuffer > 0) then
			ArmorDamagePresentation( victim, triggerArgs )
		else
			DamagePresentation( victim, triggerArgs )
		end
		SpecialHitPresentation( victim, triggerArgs )
	end

	local currentHealthFraction = victim.Health / victim.MaxHealth
	if victim.CriticalHealthVoiceLines ~= nil and currentHealthFraction < (victim.CriticalHealthVoiceLineThreshold or 1.0) then
		thread( PlayVoiceLines, victim.CriticalHealthVoiceLines, nil, victim )
	elseif victim.LowHealthVoiceLines ~= nil and currentHealthFraction < (victim.LowHealthVoiceLineThreshold or 1.0) then
		thread( PlayVoiceLines, victim.LowHealthVoiceLines, nil, victim )
	end

	if victim.AIEndHealthThreshold ~= nil then
		if currentHealthFraction <= victim.AIEndHealthThreshold and victim.Health > 0 then
			AIHealthThresholdReached(victim) 
		elseif currentHealthFraction <= victim.AIEndHealthThreshold and victim.Phases ~= nil and victim.CurrentPhase < victim.Phases then
			SetThreadWait(victim.AIThreadName, 0.01)
			Halt({ Id = victim.ObjectId })
			if victim.ExpireEffectOnThreshold then
				ClearEffect({ Id = victim.ObjectId, Name = victim.ExpireEffectOnThreshold })
			end
			if victim.ExpireProjectileIdsOnHitStun ~= nil then
				ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnHitStun })
			end
			if not IsEmpty( victim.StopAnimationsOnHitStun ) then
				StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = victim.ObjectId, PreventChain = true })
				if victim.FxTargetIdsUsed ~= nil then
					for id, v in pairs( victim.FxTargetIdsUsed ) do
						StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
					end
				end
			end
		end
		if victim.Health <= 0 then
			killWaitUntilThreads(victim.DumbFireThreadName)
			killTaggedThreads(victim.DumbFireThreadName)
		end
	end

	if CurrentRun.CurrentRoom.Encounter.GroupHealth ~= nil then
		if MapState.GroupHealthWaiters ~= nil then
			local groupHealthFraction = CurrentRun.CurrentRoom.Encounter.GroupHealth / CurrentRun.CurrentRoom.Encounter.GroupMaxHealth

			for unitId, healthThreshold in pairs(MapState.GroupHealthWaiters) do
				if groupHealthFraction <= healthThreshold then
					if ActiveEnemies[unitId] ~= nil then
						AIHealthThresholdReached(ActiveEnemies[unitId])
					end
				end
			end
		end
	end

	for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnDamageEnemyFunction ) do
		CallFunctionName( data.FunctionName, data.FunctionArgs, attacker, victim, triggerArgs )
	end

	if victim.OnDamagedFunctionName ~= nil then
		thread( CallFunctionName, victim.OnDamagedFunctionName, victim, attacker, triggerArgs )
	end

	if victim.OnDamagedFunctionNames ~= nil then
		for k, functionName in pairs( victim.OnDamagedFunctionNames ) do
			thread(CallFunctionName, functionName, victim, attacker, triggerArgs )
		end
	end
	if victim.OnDamagedEvents ~= nil then
		RunEventsGeneric( victim.OnDamagedEvents, victim, triggerArgs )
	end

	if attacker ~= nil and attacker == CurrentRun.Hero then
		victim.TimeOfLastPlayerDamage = _worldTime
	end

end

function AggroSpawns( victim, attacker, triggerArgs )
	local spawnIds = GetIds({ Name = "Spawner"..victim.ObjectId })
	for k, id in pairs( spawnIds ) do
		if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
			thread( AggroUnit, ActiveEnemies[id] )
		end
	end
end

function GetWeaponData( unit, weaponName )
	if not unit or not unit.WeaponDataOverride or not unit.WeaponDataOverride[weaponName] then
		return WeaponData[weaponName]
	else
		return unit.WeaponDataOverride[weaponName]
	end
end

function ProcessHealthBuffer( enemy, damageEventArgs )

	local sourceWeaponData = WeaponData[damageEventArgs.SourceWeapon]
	if sourceWeaponData ~= nil and sourceWeaponData.IgnoreHealthBuffer then
		return false
	end
	if damageEventArgs.IgnoreHealthBuffer then
		return false
	end

	if enemy.HitShields ~= nil and enemy.HitShields > 0 and not damageEventArgs.IgnoreHitShields then
		enemy.HitShields = enemy.HitShields - 1
		return true
	end

	if enemy.HealthTicks ~= nil and enemy.HealthTicks > 0 then
		local tickLoss = 1
		if ProjectileData[damageEventArgs.SourceProjectile] ~= nil then
			tickLoss = ProjectileData[damageEventArgs.SourceProjectile].HealthTickDamage or tickLoss
		end
		enemy.HealthTicks = enemy.HealthTicks - tickLoss

		if enemy.HealthTicks <= 0 then
			enemy.CannotDieFromDamage = false
		end
		
		HealthTickDecrementPresentation( enemy, damageEventArgs )

		return true
	end

	local damageAmount = damageEventArgs.DamageAmount
	if enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
		local healthBufferDamageMultiplier = 1

		if damageEventArgs.IsCrit then
			healthBufferDamageMultiplier = healthBufferDamageMultiplier + GetTotalHeroTraitValue( "CriticalHealthBufferMultiplier", { IsMultiplier = true }) - 1
		end
		damageAmount = damageAmount * healthBufferDamageMultiplier
		damageEventArgs.DamageAmount = damageAmount
		if (damageAmount - enemy.HealthBuffer) < 0 then
			enemy.HealthBuffer = enemy.HealthBuffer - damageAmount
		else
			local prevHealthBuffer = enemy.HealthBuffer
			local leftOverDamage = 0
			enemy.HealthBuffer = 0
			if enemy ~= CurrentRun.Hero then
				DoEnemyHealthBufferDeplete( enemy )
				thread( ArmorBreakPresentation, enemy )
			end
			damageEventArgs.DamageAmount = leftOverDamage + prevHealthBuffer
		end
		if enemy == CurrentRun.Hero then
			OnHealthBufferDamage( CurrentRun.Hero, damageAmount )
		end
		return true
	end

	return false

end

function DoEnemyHealthBuffered( enemy )
	CallFunctionName( enemy.OnHealthBufferedFunctionName, enemy )
	enemy.WasImmuneToStunWithoutArmor = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
	SetUnitProperty({ Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
end

function DoEnemyHealthBufferDeplete( enemy )
	thread(CallFunctionName, enemy.OnHealthBufferDepleteFunctionName, enemy )
	if not enemy.AlwaysTraitor then
		RemoveOutline({ Id = enemy.ObjectId })
	end
	if not enemy.WasImmuneToStunWithoutArmor then
		SetUnitProperty({ Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
	end
	ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, WeaponName = "ArmorBreakAttack", EffectName = "ArmorBreakStun" })
	if enemy.PlayStunAnimationOnHealthBufferDeplete then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.StunAnimations.Default })
	end
end

function AddOnDamagedFunction( victim, functionName )
	victim.OnDamagedFunctionNames = victim.OnDamagedFunctionNames or {}
	victim.OnDamagedFunctionNames[functionName] = true
end

function RemoveOnDamagedFunction( victim, functionName )
	victim.OnDamagedFunctionNames = victim.OnDamagedFunctionNames or {}
	victim.OnDamagedFunctionNames[functionName] = nil
end

function DamageHero( victim, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	local sourceWeaponData = GetWeaponData( attacker, triggerArgs.SourceWeapon )
	local sourceEffectData = nil
	if triggerArgs.EffectName then
		sourceEffectData = EffectData[triggerArgs.EffectName ]
	end

	thread( CheckOnDamagedPowers, victim, attacker, triggerArgs )
	CalculateManaGain( triggerArgs, sourceWeaponData )

	local currentHealth = victim.Health
	local currentHealthFraction = victim.Health / victim.MaxHealth
	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 then
		CancelFishing()
		if IsScreenOpen("Codex") then
			CloseCodexScreen()
		end
		if victim.OnDamagedFunctionNames ~= nil then
			for functionName, value in pairs( victim.OnDamagedFunctionNames ) do
				CallFunctionName( functionName, victim, triggerArgs )
			end
		end
	end

	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 and not triggerArgs.Silent then

		if sourceWeaponData == nil or not sourceWeaponData.IgnoreInvulnerabilityFrameTrigger then
			if sourceEffectData == nil or not sourceEffectData.IgnoreInvulnerabilityFrameTrigger then
				thread( CheckInvulnerabilityFrameTrigger, victim, triggerArgs )
			end
		end

		if attacker ~= nil then
			if currentHealthFraction < (attacker.PlayerInjuredVoiceLineThreshold or victim.PlayerInjuredVoiceLineThreshold or 1.0) then
				if attacker.PlayerInjuredVoiceLines ~= nil then
					thread( PlayVoiceLines, attacker.PlayerInjuredVoiceLines, nil, attacker )
				else
					for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
						if unit.PlayerInjuredReactionVoiceLines ~= nil then
							thread( PlayVoiceLines, unit.PlayerInjuredReactionVoiceLines, nil, unit )
						end
					end
				end
			end
		end
		
		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.InProgress and not triggerArgs.PureDamage then
			CurrentRun.CurrentRoom.Encounter.PlayerTookDamage = true

			if ScreenState.ActiveObjectives.PerfectClear ~= nil then
				thread( MarkObjectiveFailed, "PerfectClear" )
				PerfectClearObjectiveFailedPresentation( CurrentRun )
			end

		end

		if CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress and not triggerArgs.PureDamage then
			CurrentRun.CurrentRoom.ChallengeEncounter.PlayerTookDamage = true

			if ScreenState.ActiveObjectives.PerfectClear ~= nil then
				thread( MarkObjectiveFailed, "PerfectClear" )
				PerfectClearObjectiveFailedPresentation( CurrentRun )

				ModifyTextBox({ Id = CurrentRun.CurrentRoom.ChallengeSwitch.ValueTextAnchor, Text = "ChallengeSwitch_OnionValue", ScaleTarget = 1.0, ScaleDuration = 1.25 })
			end

		end

		local adjustedDamageAmount = triggerArgs.DamageAmount
		CurrentRun.TotalDamageTaken = CurrentRun.TotalDamageTaken + adjustedDamageAmount 
		local encounter = nil
		if MapState.EncounterOverride then
			encounter = MapState.EncounterOverride
		elseif CurrentRun and CurrentRun.CurrentRoom then
			if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.InProgress then
				encounter = CurrentRun.CurrentRoom.Encounter
			elseif CurrentRun.CurrentRoom.ChallengeEncounter and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
				encounter = CurrentRun.CurrentRoom.ChallengeEncounter
			end
		end
		if encounter then
			IncrementTableValue( encounter, "TotalDamageTaken", adjustedDamageAmount )
		end
		local attackerName = triggerArgs.AttackerName
		if attackerName ~= nil then
			if attackerName == "_PlayerUnit" then
				DebugAssert({ Condition = false, Text = "DamageHero called with AttackerName as _PlayerUnit", Owner = "James" })
			end
			local damageForRecord = adjustedDamageAmount - (triggerArgs.OverkillAmount or 0)
			CurrentRun.DamageTakenFromRecord[attackerName] = (CurrentRun.DamageTakenFromRecord[attackerName] or 0) + damageForRecord
			GameState.DamageTakenFromRecord[attackerName] = (GameState.DamageTakenFromRecord[attackerName] or 0) + damageForRecord
		end

		if attacker ~= nil and attacker.OnDealDamageFunctionName ~= nil then
			thread( CallFunctionName, attacker.OnDealDamageFunctionName, victim, attacker, triggerArgs, attacker.OnDealDamageFunctionArgs )
		end
		
		if not triggerArgs.PureDamage then
			TriggerCooldown( "BlockPerfectDash" )
		end
	elseif triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount == 0 and not triggerArgs.Silent then
		if attacker ~= nil then
			if currentHealthFraction < (attacker.PlayerHitNoDamageVoiceLinesVoiceLineThreshold or victim.PlayerHitNoDamageVoiceLinesVoiceLineThreshold or 1.0) then
				if attacker.PlayerHitNoDamageVoiceLines ~= nil then
					thread( PlayVoiceLines, attacker.PlayerHitNoDamageVoiceLines, nil, attacker )
				else
					for k, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
						if unit.PlayerHitNoDamageReactionVoiceLines ~= nil then
							thread( PlayVoiceLines, unit.PlayerHitNoDamageReactionVoiceLines, nil, unit )
						end
					end
				end
			end
		end
	end
	local sourceSimData = sourceWeaponData
	if not sourceSimData and triggerArgs.SourceProjectile then
		sourceSimData = ProjectileData[triggerArgs.SourceProjectile]
	end
	
	-- Must be last so changes can be made to triggerArgs
	if math.ceil(currentHealth) ~= math.ceil(currentHealth + triggerArgs.DamageAmount) or ( sourceSimData and sourceSimData.TriggersPlayerOnHitPresentation ) then
		triggerArgs.DamageAmount = math.ceil(currentHealth + triggerArgs.DamageAmount) - math.ceil(currentHealth)
		if not triggerArgs.Silent then
			HeroDamagePresentation( triggerArgs, sourceSimData )
		end
	end

	local lowHealthText = {}
	local healthBuffer = CurrentRun.Hero.HealthBuffer or 0
	if healthBuffer <= 0 and not triggerArgs.HealthProtected then
		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			local thresholdData = traitData.LowHealthThresholdText
			if thresholdData ~= nil and thresholdData.Threshold and currentHealth <= thresholdData.Threshold and (currentHealth + triggerArgs.DamageAmount )  > thresholdData.Threshold then
				lowHealthText[traitData.Name] = thresholdData.Text
				TraitUIActivateTrait(traitData)
			end
			if thresholdData ~= nil and thresholdData.ThresholdFraction and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction and (CurrentRun.Hero.Health + triggerArgs.DamageAmount)/CurrentRun.Hero.MaxHealth > thresholdData.ThresholdFraction then
				TraitUIDeactivateTrait( traitData )
			end
		end
		for _, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnPlayerHealthChangedFunctionName ) do
			thread( CallFunctionName, data.FunctionName, data.Args, -triggerArgs.DamageAmount )
		end
	end

	if not IsEmpty( lowHealthText ) and not triggerArgs.Silent then
		thread( LowHealthCombatTextPresentation, victim.ObjectId, lowHealthText )
	end

	local highHealthText = {}
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		local thresholdData = traitData.HighHealthThresholdText
		if thresholdData ~= nil and currentHealth/CurrentRun.Hero.MaxHealth <= thresholdData.PercentThreshold and (currentHealth + triggerArgs.DamageAmount)/ CurrentRun.Hero.MaxHealth  > thresholdData.PercentThreshold then
			highHealthText[traitData.Name] = thresholdData.Text
			TraitUIDeactivateTrait( traitData )
		end
	end

	if not IsEmpty( highHealthText ) and not triggerArgs.Silent then
		thread( HighHealthCombatTextPresentation, victim.ObjectId, highHealthText )
	end

	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 then
		InvalidateCheckpoint()
	end
	
	if not triggerArgs.Silent then
		FrameState.RequestUpdateHealthUI = true
	end

end

local recentHeroDamage = 0
function CheckInvulnerabilityFrameTrigger( victim, triggerArgs )
	local damage = triggerArgs.DamageAmount
	if damage == nil then
		return
	end
	if victim.Health <= 0 then
		-- Never trigger on death defiance or actual death
		return
	end

	recentHeroDamage = recentHeroDamage + damage
	local maxHealth = CurrentRun.Hero.MaxHealth
	local heroHealthThreshold = math.max( maxHealth * victim.InvulnerableFrameThreshold, victim.InvulnerableFrameMinDamage or 0 )
	--DebugPrint({ Text = "Recent Damage: "..recentHeroDamage })
	if recentHeroDamage ~= nil and recentHeroDamage >= heroHealthThreshold then
		recentHeroDamage = 0
		SetPlayerInvulnerable( "Frame" )
		thread( InvulnerabilityFramePresentationStart, victim, damage, heroHealthThreshold )
		wait( victim.InvulnerableFrameDuration )
		if not victim.IsDead then
			SetPlayerVulnerable( "Frame" )
			thread( InvulnerabilityFramePresentationEnd )
		end
		return
	end
	wait( victim.InvulnerableFrameCumulativeDamageDuration or 0.5 )
	recentHeroDamage = recentHeroDamage - damage
	if recentHeroDamage < 0 then
		recentHeroDamage = 0
	end
end

function IsOnlyInvulnerableSource( flag )
	if flag == nil then
		return false
	end

	if TableLength(CurrentRun.Hero.InvulnerableFlags) == 1 and CurrentRun.Hero.InvulnerableFlags[flag] then
		return true
	end
	return false
end

function SetCastArmDisabled( flag )
	MapState.CastArmDisable[flag] = true
	SetWeaponProperty({ WeaponName = "WeaponCastArm", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })	
end

function SetCastArmEnabled( flag )
	MapState.CastArmDisable[flag] = nil
	if IsEmpty( MapState.CastArmDisable ) then
		SetWeaponProperty({ WeaponName = "WeaponCastArm", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })	
	end
end


function SetPlayerNotStopsProjectiles( flag )
	MapState.HeroNotStopsProjectile[flag] = true
	SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = CurrentRun.Hero.ObjectId })
end

function SetPlayerStopsProjectiles( flag )
	MapState.HeroNotStopsProjectile[flag] = nil
	if IsEmpty( MapState.HeroNotStopsProjectile ) then
		SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function SetPlayerDarkside( flag )
	if IsEmpty( SessionMapState.DarkSide ) then
		if MapState.BabyPolymorph then
			SetThingProperty({ Property = "GrannyTexture", Value ="Models/Melinoe/YoungMelTransform_Color", DestinationId = CurrentRun.Hero.ObjectId })
		else
			SetThingProperty({ Property = "GrannyTexture", Value ="Models/Melinoe/MelinoeTransform_Color", DestinationId = CurrentRun.Hero.ObjectId })
		end
		local outlineData = ShallowCopyTable( CurrentRun.Hero.Outline )
		outlineData.Id = CurrentRun.Hero.ObjectId
		AddOutline( outlineData )
	end
	SessionMapState.DarkSide[flag] = true
end

function SetPlayerUnDarkside( flag )
	SessionMapState.DarkSide[flag] = nil
	if IsEmpty( SessionMapState.DarkSide ) then
		if CurrentRun.Hero.PolymorphType == nil then
			SetThingProperty({ Property = "GrannyTexture", Value = "null", DestinationId = CurrentRun.Hero.ObjectId })
			SetupCostume( MapState.HostilePolymorph )
		end
		RemoveOutline({ Id = CurrentRun.Hero.ObjectId })
	end
end

function SetPlayerInvulnerable( flag )
	CurrentRun.Hero.InvulnerableFlags[flag] = true
	SetInvulnerable({ Id = CurrentRun.Hero.ObjectId })
end

function SetPlayerVulnerable( flag )
	CurrentRun.Hero.InvulnerableFlags[flag] = nil
	if IsEmpty( CurrentRun.Hero.InvulnerableFlags ) then
		SetVulnerable({ Id = CurrentRun.Hero.ObjectId })
	end
end

function OnlySourceOfInvulnerability( flag )
	if IsEmpty( CurrentRun.Hero.InvulnerableFlags ) then
		return false
	end
	for otherFlag in pairs( CurrentRun.Hero.InvulnerableFlags ) do
		if flag ~= otherFlag then
			return false
		end
	end
	return true
end


function SetPlayerPhasing( flag )
	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.Hero.PhasingFlags[flag] = true
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
end

function SetPlayerUnphasing( flag )
	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.Hero.PhasingFlags[flag] = nil
	if IsEmpty( CurrentRun.Hero.PhasingFlags ) then
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = true })
	end
end

function AddPlayerImmuneToForce( flag )
	CurrentRun.Hero.ImmuneToForceFlags[flag] = true
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = true })
end

function RemovePlayerImmuneToForce( flag )
	CurrentRun.Hero.ImmuneToForceFlags[flag] = nil
	if IsEmpty( CurrentRun.Hero.ImmuneToForceFlags ) then
		SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = false })
	end
end


function SetPlayerUninterruptible( flag )
	CurrentRun.Hero.UninterruptibleFlags = CurrentRun.Hero.UninterruptibleFlags or {}
	CurrentRun.Hero.UninterruptibleFlags[flag] = true
	AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "HeroOnHitStun" })
	AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "OnHitStun" })
end

function SetPlayerInterruptible( flag )
	CurrentRun.Hero.UninterruptibleFlags = CurrentRun.Hero.UninterruptibleFlags or {}
	CurrentRun.Hero.UninterruptibleFlags[flag] = nil
	if IsEmpty( CurrentRun.Hero.UninterruptibleFlags ) then
		RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "HeroOnHitStun" })
		RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "OnHitStun" })
	end
end

function IsPlayerInterruptible()
	return IsEmpty(CurrentRun.Hero.UninterruptibleFlags)
end

function SetPlayerAttackSpecialChargeSpeed( flag, value )	
	SessionMapState.GlobalAttackSpecialSpeed[ flag ] = value
	UpdatePlayerAttackSpecialChargeSpeed()
end

function RemovePlayerAttackSpecialChargeSpeed( flag )
	SessionMapState.GlobalAttackSpecialSpeed[ flag ] = nil
	UpdatePlayerAttackSpecialChargeSpeed()
end

function UpdatePlayerAttackSpecialChargeSpeed()
	local speed = 1
	for _, value in pairs(SessionMapState.GlobalAttackSpecialSpeed) do
		speed = speed * value
	end
	SetThingProperty({ Property = "WeaponChargeMultiplier", Value = speed, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function SetUnitInvulnerable( unit, flag, args )
	flag = flag or "Generic"
	args = args or {}
	unit.InvulnerableFlags = unit.InvulnerableFlags or {}
	unit.InvulnerableFlags[flag] = true
	SetInvulnerable({ Id = unit.ObjectId })
	if unit.InvulnerableFx ~= nil and not args.Silent then
		CreateAnimation({ Name = unit.InvulnerableFx, DestinationId = unit.ObjectId })
	end
end

function SetUnitVulnerable( unit, flag )
	flag = flag or "Generic"
	unit.InvulnerableFlags = unit.InvulnerableFlags or {}
	unit.InvulnerableFlags[flag] = nil
	if IsEmpty( unit.InvulnerableFlags ) then
		SetVulnerable({ Id = unit.ObjectId })
		if unit.InvulnerableFx ~= nil then
			StopAnimation({ Name = unit.InvulnerableFx, DestinationId = unit.ObjectId })
		end
	end
end

function VulnerableAfterDelay( delay, effectName, invulnerabilityName )
	if effectName then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = effectName })
	end
	wait( delay )
	SetPlayerVulnerable( invulnerabilityName )
end

function FirstHealHitSetup( unit, args )
	SessionMapState.FirstHitHeal = ShallowCopyTable( args )

end

function ActivateManaReserveInvulnerability( unit, args )
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockTraitSetup or not args or not unit.ObjectId then
		return
	end
	args = args or {}
	ReserveMana( args.ManaReservationCost, "ManaReserveTraitInvulnerability")
	ApplyEffect({ DestinationId = unit.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ReserveManaInvulnerability", DataProperties = EffectData.ReserveManaInvulnerability.EffectData })
	SetPlayerInvulnerable( "ManaReserveTraitInvulnerability" )
end

function IsLastStandManaReserveEligible()
	return not CurrentRun or not CurrentRun.Hero or IsEmpty(CurrentRun.Hero.ReserveManaSources) or not CurrentRun.Hero.ReserveManaSources.AthenaLastStandRefill
end

function LastStandManaReserve( unit, args )
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockTraitSetup or not args then
		return
	end
	local hasAthenaLastStand = false
	for i, lastStand in pairs( unit.LastStands ) do
		if lastStand.Name == "Athena"  then
			hasAthenaLastStand = true
			UnreserveMana( "AthenaLastStandRefill")
			ReserveMana( args.ManaReservationCost, "AthenaLastStandRefill")
			return
		end
	end
	if not hasAthenaLastStand  then
		local numLastStands = CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands )
		local reservationCost = 0
		local startingLastStand = HasLastStand( CurrentRun.Hero )
		if numLastStands > 0 then
			-- only run once
			AddLastStand({
				Name = "Athena",
				Icon = "ExtraLifeAthena",
				ManaFraction = 0.4,
				HealFraction = 0.4,
				Silent = true,
			})
			numLastStands = numLastStands - 1
			reservationCost = reservationCost + args.ManaReservationCost
			if startingLastStand ~= HasLastStand( CurrentRun.Hero ) then
				thread( RoomStartLowHealthBonusBuffStatePresentation  )
			end

		end
		UnreserveMana( "AthenaLastStandRefill")
		ReserveMana( reservationCost, "AthenaLastStandRefill")
	end
end


function RestoreLastStandManaReserve( traitData )
	local args = traitData.SetupFunction.Args
	local reservationCost = args.ManaReservationCost
	
	local hasAthenaLastStand = false
	for i, lastStand in ipairs( CurrentRun.Hero.LastStands ) do
		if lastStand.Name == "Athena"  then
			hasAthenaLastStand = true
		end
	end
	if not hasAthenaLastStand and TableLength(CurrentRun.Hero.LastStands) == CurrentRun.Hero.MaxLastStands then
		return
	end
	UnreserveMana( "AthenaLastStandRefill")
	ReserveMana( args.ManaReservationCost, "AthenaLastStandRefill")
end

function AddLastStand( args )
	local unit = args.Unit or CurrentRun.Hero
	args.Unit = nil
	local count = args.Count or 1
	if not unit.LastStands then
		unit.LastStands = {}
	end
	if CurrentRun then
		CurrentRun.DeathDefianceDamageBoonEligible = true
	end
	local startingHasLastStand = HasLastStand( unit )
	if args.ValidityFunctionName and not CallFunctionName(args.ValidityFunctionName, args) then
		return
	end
	for i = 1, count do
		if args.IncreaseMax then
			unit.MaxLastStands = (unit.MaxLastStands or 0) + 1
			if ScreenAnchors.LifePipIds then
				CreateLifePip( unit.MaxLastStands )
			end
		end

		if unit.MaxLastStands and TableLength( unit.LastStands ) >= unit.MaxLastStands and not args.Silent then
			UpdateLifePips( unit )
			AtLastStandMaxPresentation( unit )
			return
		end

		if args.InsertAtEnd then
			table.insert( unit.LastStands, 1, args )
			if not args.Silent then
				GainLastStandPresentation(1)
			end
		else
			table.insert( unit.LastStands, args )

			if not args.Silent then
				GainLastStandPresentation()
			end
		end
	end
	
	local priorityLastStand = nil
	for i, lastStand in ipairs( CurrentRun.Hero.LastStands ) do
		if i ~= #CurrentRun.Hero.LastStands and lastStand.Priority then
			priorityLastStand = lastStand
		end
	end
	if priorityLastStand then
		RemoveValueAndCollapse( CurrentRun.Hero.LastStands, priorityLastStand )
		table.insert( CurrentRun.Hero.LastStands, priorityLastStand )
	end
	
	if not args.Silent then
		if not startingHasLastStand and unit == CurrentRun.Hero then
			thread( LowHealthBonusBuffStatePresentation )
		end
		UpdateLifePips( unit )
	end
end

function RemoveLastStand( heroUnit, name )
	local unit = heroUnit or CurrentRun.Hero
	for i, lastStandData in pairs(unit.LastStands) do
		if lastStandData.Name == name then
			table.remove(unit.LastStands, i )
			return
		end
	end
end
function CheckLastStand( victim, triggerArgs )

	if not HasLastStand( victim ) and not SessionMapState.InfiniteDeathDefiance then
		return false
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		thread( TraitTrayScreenClose, ActiveScreens.TraitTrayScreen )
	end
	CancelFishing()
	ToggleCombatControl( CombatControlsDefaults, false, "LastStand" )
	
	
	if SessionMapState.ThrowWeaponCharged then
		ApplyDeferredThrowReversions( GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" ))
	end

	local lastStandData = nil
	local blockDeathLastStand = false
	if SessionMapState.InfiniteDeathDefiance then
		lastStandData = 
		{
			ManaFraction = 0.9,
			HealFraction = 0.9,
			StartPresentationFunctionName = "InfiniteLastStandPresentationStart",
			EndPresentationFunctionName = "InfiniteLastStandPresentationEnd",
		}
		AddOutgoingDamageModifier( CurrentRun.Hero, { ValidWeaponMultiplier = 1.3, Temporary = true })
		triggerArgs.InfiniteDeathDefiance = true
	elseif HasHeroTraitValue( "BlockDeathTimer" ) and not MapState.UsedBlockDeath then
		blockDeathLastStand = true
		MapState.UsedBlockDeath = true
		CurrentRun.CurrentRoom.UsedBlockDeath = true
		lastStandData = 
		{
			Name = "BlockDeathLastStand",
			HealAmount = 1,
			FunctionName = "SetupBlockDeathThread",
			StartPresentationFunctionName = "BlockDeathLastStandPresentationStart",
			EndPresentationFunctionName = "BlockDeathLastStandPresentationEnd"
		}
	elseif not IsEmpty(victim.LastStands ) then
		lastStandData = table.remove( victim.LastStands )
	end
	lastStandData.Name = lastStandData.Name or "Default"
	local weaponName = lastStandData.WeaponName
	local lastStandManaFraction = lastStandData.ManaFraction or 0
	local lastStandHealth = lastStandData.HealAmount or 0
	local lastStandFraction = lastStandData.HealFraction or 0
	lastStandFraction = lastStandFraction + GetTotalHeroTraitValue( "LastStandHealFraction" )

	if lastStandData.RandomHeal then
		for i, data in ipairs(lastStandData.RandomHeal) do
			if data.Chance and RandomChance( data.Chance ) then
				lastStandHealth = data.HealAmount
				break
			else
				if type(data.HealFraction) == "table" then
					lastStandFraction = RandomFloat( data.HealFraction.Min, data.HealFraction.Max )
				else
					lastStandFraction = data.HealFraction
				end
			end
		end
	end

	if lastStandData.ExpiresKeepsake then
		if HeroHasTrait(lastStandData.ExpiresKeepsake) then
			local traitData = GetHeroTrait(lastStandData.ExpiresKeepsake)
			if traitData.ZeroBonusTrayText then
				traitData.CustomTrayText = traitData.ZeroBonusTrayText
			end
		end
		CurrentRun.ExpiredKeepsakes[lastStandData.ExpiresKeepsake] = true
		LogTraitUses( lastStandData.ExpiresKeepsake )
	end

	if not blockDeathLastStand then
		CurrentRun.Hero.LastStandsUsed = (CurrentRun.Hero.LastStandsUsed or 0) + 1
	end
	CurrentRun.CurrentRoom.LastStandsUsed[lastStandData.Name] = (CurrentRun.CurrentRoom.LastStandsUsed[lastStandData.Name] or 0) + 1
	triggerArgs.LastStandUsed = lastStandData

	SetPlayerInvulnerable("LastStand")
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HecatePolymorphStun" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MiasmaSlow" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
	
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })

	if HasHeroTraitValue("RechargeSpellOnLastStand") then
		ChargeSpell(-1000)
	end
	triggerArgs.HasLastStand = HasLastStand( victim )
	ExpireProjectiles({ ExcludeNames = ConcatTableValues( ShallowCopyTable( WeaponSets.ExpireProjectileExcludeProjectileNames), ShallowCopyTable( WeaponSets.ExpireProjectileLastStandExcludeProjectileNames )) })

	if MapState.FamiliarUnit ~= nil then
		RunEventsGeneric( MapState.FamiliarUnit.LastStandEvents, MapState.FamiliarUnit )
	end
	if lastStandData.StartPresentationFunctionName then
		CallFunctionName( lastStandData.StartPresentationFunctionName, triggerArgs)
	else
		PlayerLastStandPresentationStart( triggerArgs )
	end
	if blockDeathLastStand then
		Heal( victim, { HealAmount = 1, SourceName = "LastStandHealTrait", Silent = true } )
	else
		PlayerLastStandHeal( victim, triggerArgs, lastStandHealth, lastStandFraction )
	end
	FrameState.RequestUpdateHealthUI = true
	
	local manaRestoreAmount = round(victim.MaxMana * lastStandManaFraction) 
	ManaDelta( manaRestoreAmount )
	thread( PlayerLastStandManaGainText, { Amount = manaRestoreAmount, Delay = 0.5 })
	if lastStandData.EndPresentationFunctionName then
		CallFunctionName( lastStandData.EndPresentationFunctionName)
	else
		PlayerLastStandPresentationEnd()
	end
	
	ToggleCombatControl( CombatControlsDefaults, true, "LastStand" )
	if weaponName ~= nil then
		MapState.EquippedWeapons[weaponName] = true
		FireWeaponFromUnit({ Weapon = weaponName, Id = victim.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true })
	end
	CallFunctionName( lastStandData.FunctionName, victim, lastStandData.FunctionArgs )
	
	for i, functionData in pairs( GetHeroTraitValues("OnLastStandFunction") ) do
		CallFunctionName( functionData.Name, functionData.FunctionArgs, triggerArgs )
	end

	wait( 1.5, RoomThreadName )
	if not HasLastStand( CurrentRun.Hero ) and not SessionMapState.InfiniteDeathDefiance then
		thread( LowHealthBonusBuffStatePresentation )
	end
	SetPlayerUnDarkside("LastStand")
	SetPlayerVulnerable("LastStand")
	return true
end

function PlayerLastStandHeal( victim, args, lastStandHealth, lastStandFraction )
	if lastStandHealth > 0 then
		Heal( victim, { HealAmount = lastStandHealth, SourceName = "LastStandHealTrait", Silent = true } )
	elseif lastStandFraction > 0 then
		local healAmount = round( lastStandFraction * victim.MaxHealth )
		Heal( victim, { HealAmount = healAmount, SourceName = "LastStandHealTrait", Silent = true } )
	end
	if IsHealthHidden() then
		thread( PopOverheadText, {Text = "UI_Mystery_Plus", Color = Color.UpgradeGreen, SkipShadow = true, GroupName = "Combat_UI" })
	else
		PlayerLastStandHealingPresentation( args )
	end
end

function HasLastStand( unit )
	if unit.LastStands == nil then
		return false
	end
	if unit.IsDead and ( GetNumMetaUpgradeLastStands() > 0 or GameState.LastAwardTrait == "BlockDeathKeepsake") then
		return true
	end
	if CurrentRun.Hero.HeroTraitValuesCache.BlockDeathTimer and CurrentRun.Hero.HeroTraitValuesCache.BlockDeathTimer[1] ~= nil and not MapState.UsedBlockDeath then
		return true
	end
	return not IsEmpty( unit.LastStands )
end

OnCollisionReaction{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collidee ~= nil then
			DoReaction( collidee, collidee.ImpactReaction )
		end
	end
}
OnAllegianceFlip{
	function( triggerArgs )
		local enemy = triggerArgs.TriggeredByTable
		if not enemy then
			return
		end
		
		if enemy.WeaponName then
			local weaponData = WeaponData[enemy.WeaponName]
			if weaponData ~= nil and not weaponData.BlockInterrupt then
				enemy.ForcedWeaponInterrupt = enemy.WeaponName
			end
		end
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		if not IsEmpty(enemy.OutgoingDamageModifiers) then
			for i, data in pairs(enemy.OutgoingDamageModifiers) do
				if data.NonPlayerMultiplier and data.NonPlayerMultiplier == 0 and not enemy.KeepNonPlayerMultipliers then
					RemoveValueAndCollapse( enemy.OutgoingDamageModifiers, data )	
					break
				end
			end
		end
		
		UpdateHealthBar( enemy, 0, { Force = true } )
		local delay = 0.1
		if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.PreSpawning and CurrentRun.CurrentRoom.Encounter.PreSpawnSpawnOverrides and CurrentRun.CurrentRoom.Encounter.PreSpawnSpawnOverrides.WakeUpDelay then
			delay = CurrentRun.CurrentRoom.Encounter.PreSpawnSpawnOverrides.WakeUpDelay
		end
		notifyExistingWaiters( enemy.AINotifyName )
		SetThreadWait( enemy.AIThreadName, delay )
	end
}

OnObstacleCollision{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collidee and collidee.Name then
			triggerArgs.AttackerName = collidee.Name
		end
		triggerArgs.SourceVelocity = triggerArgs.Velocity
		triggerArgs.OtherVelocity = 0
		if collider ~= nil and collider.CollisionReactions ~= nil then
			for k, collisionReaction in pairs(collider.CollisionReactions) do
				if collisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collisionReaction.MinVelocity then
					DoReaction( collider, collisionReaction, triggerArgs )
				end
			end
		end
		if collidee ~= nil and collidee.CollisionReactions ~= nil then
			for k, collisionReaction in pairs(collidee.CollisionReactions) do
				if collisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collisionReaction.MinVelocity then
					if collisionReaction.RequireColliderName == nil or (collider.Name ~= nil and collisionReaction.RequireColliderName == collider.Name) then
						DoReaction( collidee, collisionReaction, triggerArgs )
					end
				end
			end
		end
	end
}

OnUnitCollision{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collidee and collidee.Name then
			triggerArgs.AttackerName = collidee.Name
		end
		if collider ~= nil and collider.CollisionReactions ~= nil then
			for k, collisionReaction in pairs(collider.CollisionReactions) do
				if collisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collisionReaction.MinVelocity then
					DoReaction( collider, collisionReaction, triggerArgs )
				end
			end
		end
		if collidee ~= nil and collidee.CollisionReactions ~= nil then
			for k, collisionReaction in pairs(collidee.CollisionReactions) do
				if collisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collisionReaction.MinVelocity then
					DoReaction( collidee, collisionReaction, triggerArgs )
				end
			end
		end
		if collider == CurrentRun.Hero or collidee == CurrentRun.Hero then
			local victim = collider
			if collider == CurrentRun.Hero then
				victim = collidee
			end
			
			for i, traitData in pairs( GetHeroTraitValues("OnContactFunctionNames")) do
				thread( CallFunctionName, traitData.Name, victim, traitData.Args, triggerArgs )
			end
		end
	end
}

OnMovementReaction{
	function( triggerArgs )
		local mover = triggerArgs.TriggeredByTable
		local observer = triggerArgs.ObserverTable
		if observer ~= nil then
			DoReaction( observer, observer.MovementReaction )
		end
	end
}

function DoReaction( victim, reaction, triggerArgs )
	triggerArgs = triggerArgs or {} 
	if victim == nil or victim.Reacting or reaction == nil then
		return
	end

	if reaction.Cooldown and not CheckCooldown( victim.ObjectId.."CollisionReaction", reaction.Cooldown ) then
		return
	end

	if reaction.RequireCollidee ~= nil and not Contains(reaction.RequireCollidee, triggerArgs.TriggeredByTable.Name) then
		return
	end

	victim.Reacting = true

	if reaction.CausesOcclusion ~= nil then
		SetThingProperty({ Property = "CausesOcclusion", Value = reaction.CausesOcclusion, DestinationId = victim.ObjectId })
	end

	if reaction.PropertyChanges ~= nil then
		ApplyUnitPropertyChanges( victim, reaction.PropertyChanges, true )
	end

	if reaction.Sound ~= nil then
		PlaySound({ Name = reaction.Sound, Id = victim.ObjectId, ManagerCap = reaction.SoundManagerCap })
	end

	if reaction.ReactionShake then
		Shake({ Id = victim.ObjectId, Speed = 400, Distance = 3, Duration = reaction.ReactionShakeDuration or 0.5 })
		Flash({ Id = victim.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = reaction.ReactionShakeFlashFraction or 0.95, Color = Color.White, Duration = reaction.ReactionShakeDuration or 0.5 })
		wait(reaction.ReactionShakeDuration or 0.5)
	end

	if reaction.DisableOnHitShake then
		victim.OnHitShakeDisabled = true
	end

	if reaction.Animation ~= nil then
		SetAnimation({ DestinationId = victim.ObjectId, Name = reaction.Animation })
		RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Animation", reaction.Animation )
	end

	if reaction.HitImpactVelocity ~= nil then
		ApplyForce({ Id = victim.ObjectId, Speed = reaction.HitImpactVelocity, Angle = triggerArgs.ImpactAngle })
	end
	
	if reaction.Weapon ~= nil then
		MapState.EquippedWeapons[reaction.Weapon] = true
		if reaction.FireFromSelf then
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = victim.ObjectId, DestinationId = victim.ObjectId })
		else
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		end
	end

	victim.NumReactionProjectiles = victim.NumReactionProjectiles or 0
	if reaction.FireProjectileData ~= nil and (reaction.FireProjectileRequiredMinVelocity == nil or triggerArgs.Velocity and triggerArgs.Velocity >= reaction.FireProjectileRequiredMinVelocity) then
		victim.NumReactionProjectiles = victim.NumReactionProjectiles + 1
		reaction.FireProjectileData.FireProjectileAngle = triggerArgs.ImpactAngle
		thread(ProcessFireProjecile, victim, reaction.FireProjectileData )
	end

	if reaction.ApplyEffects ~= nil then
		for k, effectData in pairs(reaction.ApplyEffects) do
			effectData.Id = triggerArgs.TriggeredByTable.ObjectId
			effectData.DestinationId = triggerArgs.TriggeredByTable.ObjectId
			
			ApplyEffect(effectData)
		end
	end

	if reaction.DropMoney ~= nil then
		CheckMoneyDrop(victim, reaction.DropMoney)
	end

	if reaction.FunctionName ~= nil then
		CallFunctionName(reaction.FunctionName, victim, triggerArgs.TriggeredByTable, reaction.FunctionArgs)
	end
	if reaction.ReactionEvents ~= nil then
		RunEventsGeneric( reaction.ReactionEvents, victim, triggerArgs )
	end

	if reaction.SpawnObstacle ~= nil or reaction.SpawnRandomObstacle ~= nil then
		thread( SpawnImpactReactionObstacles, victim, reaction )
	end

	if reaction.SpawnUnit ~= nil then
		local newEnemy = DeepCopyTable( EnemyData[reaction.SpawnUnit] )
		newEnemy.ObjectId = SpawnUnit({ Name = reaction.SpawnUnit, Group = "Standing", DestinationId = victim.ObjectId })
		thread(SetupUnit, newEnemy, CurrentRun )
	end

	if reaction.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[reaction.GlobalVoiceLines], true )
	end

	if reaction.SwapData ~= nil then
		local newData = ObstacleData[reaction.SwapData]
		local newObject = DeepCopyTable( newData )
		newObject.ObjectId = victim.ObjectId
		AttachLua({ Id = victim.ObjectId, Table = newObject })
		if newObject.SpawnPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
		end
		if newObject.OnSpawnFireFunctionName ~= nil then
			local fireFunction = _G[newObject.OnSpawnFireFunctionName]
			thread(fireFunction, newObject, currentRun)
		end
		RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "SwapData", reaction.SwapData )
	end

	thread( DoReactionPresentation, victim, reaction )
	victim.Reacting = false

	if reaction.KillSelf then
		Kill( victim )
	end

	if victim.KillSelfAfterNumReactionProjectiles and victim.NumReactionProjectiles >= victim.KillSelfAfterNumReactionProjectiles then
		Kill( victim )
	end

	if reaction.DestroySelf then
		Destroy({ Id = victim.ObjectId })
		if reaction.RecordDestroyed then
			RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Destroyed", true )
		end
	end

end

function DestroyOnDelay( ids, delay, args )
	args = args or {}
	if args.Unmodified then
		waitUnmodified( delay, RoomThreadName )
	else
		wait( delay, RoomThreadName )
	end
	if args.Fx then
		CreateAnimation({DestinationId = ids[1], Name = args.Fx})
	end
	Destroy({ Ids = ids })
end

function ExpireOnDelay( ids, delay, args )
	args = args or {}
	if args.Unmodified then
		waitUnmodified( delay, RoomThreadName )
	else
		wait( delay, RoomThreadName )
	end

	ExpireProjectiles({ ProjectileIds = ids })
end

function SpawnImpactReactionObstacles( victim, reaction )
	local limit = reaction.SpawnAmount or 1
	if reaction.SpawnAmountMin ~= nil and reaction.SpawnAmountMax ~= nil then
		limit = RandomInt(reaction.SpawnAmountMin, reaction.SpawnAmountMax)
	end
	for index = 1, limit, 1 do
		SpawnImpactReactionObstacle( victim, reaction )
		local waitTime = RandomFloat( reaction.SpawnTimeMin or 0.04, reaction.SpawnTimeMax or 0.08 )
		wait( waitTime )
	end
end

function SpawnImpactReactionObstacle( victim, reaction )
	local offsetX = RandomFloat( reaction.SpawnOffsetXMin or 0, reaction.SpawnOffsetXMax or 0 )
	if CoinFlip() then
		offsetX = offsetX * -1
	end
	local offsetY = RandomFloat( reaction.SpawnOffsetYMin or 0, reaction.SpawnOffsetYMax or 0 )
	if CoinFlip() then
		offsetY = offsetY * -1
	end

	local obstacleName = reaction.SpawnObstacle or GetRandomValue( reaction.SpawnRandomObstacle )
	local obstacle = DeepCopyTable(ObstacleData[obstacleName])
	local obstacleId = SpawnObstacle({ Name = obstacleName, DestinationId = victim.ObjectId, OffsetX = offsetX, OffsetY = offsetY, ForceToValidLocation = reaction.ForceSpawnToValidLocation, SkipIfBlocked = true, Group = reaction.SpawnGroup or "Standing", })
	AddToGroup({ Id = obstacleId, Name = "DestructibleGeo"})

	obstacle.ObjectId = obstacleId
	SetupObstacle(obstacle)

	local obstacleData = ObstacleData[obstacleName] or {}
	local spawnScale = reaction.SpawnScale or obstacleData.SpawnScale
	if reaction.SpawnScaleMin ~= nil and reaction.SpawnScaleMax ~= nil then
		spawnScale = RandomFloat( reaction.SpawnScaleMin, reaction.SpawnScaleMax )
	end
	if spawnScale == nil and obstacleData.SpawnScaleMin ~= nil and obstacleData.SpawnScaleMax ~= nil then
		spawnScale = RandomFloat( obstacleData.SpawnScaleMin, obstacleData.SpawnScaleMax )
	end
	if spawnScale ~= nil then
		SetScale({ Id = obstacleId, Fraction = spawnScale })
	end

	if reaction.MaintainHorizontalFlip then
		if IsHorizontallyFlipped({ Id = victim.ObjectId }) then
			FlipHorizontal({ Id = obstacleId })
		end
	elseif CoinFlip() then
		FlipHorizontal({ Id = obstacleId })
	end
	if reaction.SpawnOffsetZ ~= nil then
		AdjustZLocation({ Id = obstacleId, Distance = reaction.SpawnOffsetZ })
	end
	if reaction.FallForce ~= nil then
		ApplyUpwardForce({ Id = obstacleId, Speed = -reaction.FallForce })
	end
	if reaction.RestoreOnLoad then
		local encounter = CurrentRun.CurrentRoom.Encounter
		encounter.ObstaclesToRestore = encounter.ObstaclesToRestore or {}
		local location = GetLocation({ Id = obstacleId })
		location.X = location.X + (offsetX or 0)
		location.Y = location.Y + (offsetY or 0)
		table.insert( encounter.ObstaclesToRestore, { Name = reaction.RestoreOnLoadName or obstacleName, Location = location, GroupName = reaction.SpawnGroup, } )
	end
end
OnTouchdown{
	function( triggerArgs )

		local touchdowner = triggerArgs.TriggeredByTable

		if touchdowner.OnTouchdown ~= nil then
			if touchdowner.OnTouchdown.LeapIfBlocked and IsLocationBlocked({ Id = touchdowner.ObjectId }) then
				Leap(touchdowner, touchdowner.DefaultAIData, CurrentRun.Hero.ObjectId)
			end
			if touchdowner.OnTouchdown.KillIfBlocked and IsLocationBlocked({ Id = touchdowner.ObjectId }) then
				touchdowner.SpawnObstaclesOnDeath = nil
				Kill(touchdowner)
			end
			if touchdowner.OnTouchdown.ProjectileName ~= nil then
				CreateProjectileFromUnit({ Name = touchdowner.OnTouchdown.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = touchdowner.ObjectId, FireFromTarget = true })
			end
			if touchdowner.OnTouchdown.CrushTypes ~= nil then
				local typeIds = GetIdsByType({ Names = touchdowner.OnTouchdown.CrushTypes })
				local crushIds = GetIntersectingIds({ Id = touchdowner.ObjectId, DestinationIds = typeIds })
				Destroy({ Ids = crushIds })
			end
			if touchdowner.OnTouchdown.Animation ~= nil then
				SetAnimation({ DestinationId = touchdowner.ObjectId, Name = touchdowner.OnTouchdown.Animation })
			end
			if touchdowner.OnTouchdown.DestroyOnDelay ~= nil then
				wait( touchdowner.OnTouchdown.DestroyOnDelay, RoomThreadName )
				Destroy({ Id = touchdowner.ObjectId })
			end

		end
		if touchdowner.ResetOnTouchdown ~= nil then
			SetThingProperty({ DestinationId = touchdowner.ObjectId, Property = "ImmuneToForce", Value = touchdowner.ResetOnTouchdown })
			touchdowner.ResetOnTouchdown = nil
			StopAnimation({ Name = "PoseidonKnockupPuddle", DestinationId = touchdowner.ObjectId })
		end

		if touchdowner.OnTouchdownFunctionName ~= nil then
			CallFunctionName( touchdowner.OnTouchdownFunctionName, touchdowner, touchdowner.OnTouchdownFunctionArgs )
		end

		for _, data in pairs(GetHeroTraitValues("OnTouchdownFunction")) do
			thread(CallFunctionName, data.Name, touchdowner, data.Args, triggerArgs)
		end
	end
}

function KillEnemy( victim, triggerArgs )
	local killer = triggerArgs.AttackerTable
	local killingWeapon = triggerArgs.SourceWeapon
	if triggerArgs.IsCrit and CurrentRun.Hero.TraitDictionary.AxePerfectCriticalAspect ~= nil then
		local trait = GetHeroTrait( "AxePerfectCriticalAspect" )
		if trait.PerfectCritChance > 0 then
			CreateAnimation({ Name = "ThanatosCritFx", DestinationId = victim.ObjectId })
		end
	end

	local currentRoom = CurrentRun.CurrentRoom
	MapState.TauntTargetIds[victim.ObjectId] = nil

	if victim.StopAnimationsOnDeath ~= nil then
		StopAnimation({ DestinationId = victim.ObjectId, Names = victim.StopAnimationsOnDeath })
	end

	if victim.DestroyIdsOnDeath ~= nil then
		Destroy({ Ids = victim.DestroyIdsOnDeath })
	end

	if victim.KillEnemyEvents ~= nil then
		RunEventsGeneric( victim.KillEnemyEvents, victim, triggerArgs )
	end

	if victim.SpawnerThreadName ~= nil then
		killTaggedThreads(victim.SpawnerThreadName)
		killWaitUntilThreads(victim.SpawnerThreadName)
	end

	if victim.EndThreadNameWaitOnDeath ~= nil then
		SetThreadWait(victim.EndThreadNameWaitOnDeath, 0.01)
	end

	if victim.TraitAnimationAnchors ~= nil then
		for i, anchorId in pairs(victim.TraitAnimationAnchors) do
			Destroy({Id = anchorId})
		end
	end

	if (( not victim.SkipModifiers and not victim.IsBoss and not victim.BlockRaiseDead ) or victim.ForceAllowRaiseDead ) and killer == CurrentRun.Hero then
		CurrentRun.CurrentRoom.SummonEnemyName = victim.Name
	end
		
	if not victim.SkipModifiers and killer ~= nil and ( killer == CurrentRun.Hero or killer.TriggersOnDeathWithKillEffects ) then
		for i, functionArgs in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnEnemyDeathFunction ) do
			thread( CallFunctionName, functionArgs.Name, victim, functionArgs.FunctionArgs, triggerArgs )
		end
	end

	if victim.StatusAnimation ~= nil then
		StopStatusAnimation( victim )
	end

	if victim ~= nil and not victim.AlwaysTraitor and not victim.SkipModifiers then
		for _, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.AddEnemyOnDeathProjectile ) do
			for projectileName, value in pairs( data ) do
				CreateProjectileFromUnit({ Name = projectileName, Id = victim.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end

	if victim.Name ~= nil then
		CurrentRun.EnemyKills[victim.Name] = (CurrentRun.EnemyKills[victim.Name] or 0) + 1
		GameState.EnemyKills[victim.Name] = (GameState.EnemyKills[victim.Name] or 0) + 1
		if victim.EliteAttributes ~= nil then
			for k, attributeName in pairs( victim.EliteAttributes ) do
				GameState.EnemyEliteAttributeKills[attributeName] = (GameState.EnemyEliteAttributeKills[attributeName] or 0) + 1
			end
		end
	end

	thread( PostEnemyKillPresentation, victim, triggerArgs )

end

function WipeSpawnsOnKill( victim, args, triggerArgs )
	for k, enemyId in pairs(GetIds({ Name = "Spawner"..victim.ObjectId })) do
		if ActiveEnemies[enemyId] ~= nil then
			thread( Kill, ActiveEnemies[enemyId], { BlockRespawns = true } )
		end
	end
end

function FuseSpawns( killedUnit, args, triggerArgs )
	local fuseInterval = args.Interval or 0.3
	local spawns = killedUnit.Spawns
	if spawns ~= nil then
		for id, spawn in pairs( spawns ) do
			thread( ActivateFuse, spawn )
			wait( fuseInterval )
		end
	end
end

OnWeaponFailedToFire{
	function( triggerArgs )
		local attacker = triggerArgs.TriggeredByTable
		local weaponName = triggerArgs.name
		local weaponData = attacker.WeaponDataOverride[weaponName] or WeaponData[weaponName]
		local originalWeaponData = WeaponData[weaponName]

		if weaponData == nil then
			return
		end

		if SessionMapState.BlockWeaponFailedToFire[weaponName] then
			return
		end
		local manaCost = GetManaCost( weaponData, true )
		if manaCost > CurrentRun.Hero.Mana then
			if triggerArgs.FreshInput and not weaponData.HideOutOfManaPresentation then
				WeaponFailedNoManaPresentation( weaponData )
			end
			thread( CallFunctionName, weaponData.OutOfManaFunctionName, weaponData, weaponData.OutOfManaFunctionArgs, triggerArgs )
		end
		local manaReservationCost = GetManaReservationCost( weaponData ) 
		if manaReservationCost > GetHeroMaxAvailableMana() and triggerArgs.FreshInput then
			WeaponFailedNoManaPresentation( weaponData )
		end

		if weaponData.RecallOnFailToFire then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.RecallOnFailToFire, Method = "RecallProjectiles" })
		end

		if ( triggerArgs.FreshInput or weaponData.RepeatFailToFireFunction ) and weaponData.FailToFireFunctionName and _G[weaponData.FailToFireFunctionName ] then
			_G[weaponData.FailToFireFunctionName ]( triggerArgs )
		end

		if attacker ~= nil and attacker == CurrentRun.Hero and weaponData.NotReadyText ~= nil and triggerArgs.Controllable and triggerArgs.FreshInput then
			if weaponData.MaxAmmo ~= nil then
				if GetCurrentAmmo(weaponData.Name) <= 0 and CheckCountInWindow( "AttackNotReady", 1.0, 5 ) and CheckCooldown( "AttackNotReady", 1.0 ) then
					if attacker.IsDead then
						thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = weaponData.NoAmmoText, PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
					end
					thread( PlayVoiceLines, originalWeaponData.NoAmmoVoiceLines or HeroVoiceLines.NoAmmoVoiceLines, true )
				end
			elseif (weaponData.BlockNotReadyWhenGiftableUseTarget or not SessionMapState.ActiveGiftableUseTarget ) and CheckCountInWindow( "AttackNotReady", 1.0, 4 ) and CheckCooldown( "AttackNotReady", 1.0 ) then
				if weaponData.NotReadyText ~= nil  and ( not Contains(WeaponSets.HeroPrimaryWeapons, weaponData.Name ) and GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Enabled" })) then
					thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = weaponData.NotReadyText, PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )
				end
				if CurrentHubRoom == nil or CurrentHubRoom.ExpressiveAnimation == nil then
					thread( PlayVoiceLines, originalWeaponData.NotReadyVoiceLines or HeroVoiceLines.NotReadyVoiceLines, true )
				end
			end
		end

		
		if triggerArgs.FreshInput then
			if attacker.IsDead and weaponData.NotReadyAmmoPackText ~= nil then
				if CheckCountInWindow( "AmmoNotRetrieved", 2.0, 8 ) then
					local ammoIds = GetIdsByType({ Name = weaponData.AmmoPackName })
					for k, ammoId in pairs( ammoIds ) do
						thread( InCombatTextArgs, { TargetId = ammoId, Text = weaponData.NotReadyAmmoPackText, SkipRise = true, PreDelay = 0.35, Duration = 2, OffsetY = -120, Cooldown = 3.0, ShadowScale = 0.66 } )
					end
				end
			end
		end
		if CurrentHubRoom == nil or CurrentHubRoom.FailedToFireFunctionName == nil then
			if weaponData.NotReadySound ~= nil and CheckCooldown( "NotReadySound", 0.15 ) then
				PlaySound({ Name = weaponData.NotReadySound, Id = triggerArgs.triggeredById })
			end
			if weaponData.NoControlSound ~= nil and not triggerArgs.Controllable then
				PlaySound({ Name = weaponData.NoControlSound, Id = triggerArgs.triggeredById })
			end
		end

		if CurrentHubRoom ~= nil and CurrentHubRoom.FailedToFireFunctionName ~= nil then
			local failedToFireFunction = _G[CurrentHubRoom.FailedToFireFunctionName]
			if failedToFireFunction ~= nil then
				failedToFireFunction( weaponData, triggerArgs )
			end
		elseif triggerArgs.FreshInput then
			if GetMaxAmmo( weaponData.Name ) and GetMaxAmmo( weaponData.Name ) > 0 and GetCurrentAmmo( weaponData.Name ) == 0 and weaponData.NoAmmoFunctionName ~= nil then
				local noAmmoFunction = _G[weaponData.NoAmmoFunctionName]
				if noAmmoFunction ~= nil then
					noAmmoFunction( weaponData ) 
				end
			end
		end

	end
}

OnWeaponCharging{
    function( triggerArgs )

		local weaponData = WeaponData[triggerArgs.name]
		if triggerArgs.OwnerTable then
			weaponData = GetWeaponData( triggerArgs.OwnerTable, triggerArgs.name )
		end
		if weaponData == nil then
			return
		end
		if weaponData.OnChargeFunctionNames ~= nil then
			for i, functionName in ipairs( weaponData.OnChargeFunctionNames ) do
				thread( CallFunctionName, functionName, triggerArgs, weaponData, weaponData.OnChargeFunctionArgs )
			end
		end
		if WeaponSetLookups.HeroSecondaryWeaponsLinked[triggerArgs.name] then
			TerminateBlinkTrail()
			RunWeaponMethod({ Id = triggerArgs.triggeredById, Weapon = "WeaponBlink", Method = "cancelCharge" })
		end

		if weaponData.RushOverride then
			for i, rushWeaponName in ipairs( WeaponSets.HeroRushWeapons ) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
		if weaponData.ChargeRumbleParameters ~= nil then
			thread( DoWeaponChargeRumble, weaponData )
		end
		for i, traitData in ipairs( GetHeroTraitValues( "OnWeaponChargeFunctions" ) ) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName and _G[traitData.FunctionName] then
				thread( _G[traitData.FunctionName], weaponData, traitData.FunctionArgs, triggerArgs )
			end
		end

		if weaponData.ChargeCameraMotion ~= nil then
			thread( DoCameraMotion, weaponData.ChargeCameraMotion )
		end
		if weaponData.ChargeScreenshake ~= nil then
			DoWeaponScreenshake( weaponData, "ChargeScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = triggerArgs.SourceProjectile } )
		end
		if weaponData.ShowManaIndicator or (  WeaponData[triggerArgs.name] and WeaponData[triggerArgs.name] .ManaCost ) then
			thread( HandleManaChargeIndicator, triggerArgs )
		end
		if weaponData.Sounds ~= nil then
			DoWeaponSounds( weaponData.Sounds.ChargeSounds, triggerArgs.OwnerTable, weaponData )
		end
		StopWeaponSounds( "Charge", weaponData.Sounds, triggerArgs.OwnerTable )

    end
}

OnWeaponChargeCanceled{
	function( triggerArgs )
		local weaponData = GetWeaponData( triggerArgs.OwnerTable, triggerArgs.name )
		if weaponData == nil then
			return
		end
		if not triggerArgs.PostFire then
			FrameState[triggerArgs.name.."PostFireFail"] = true
		end

		if weaponData.ChargeCancelCameraMotion ~= nil then
			thread( DoCameraMotion, weaponData.ChargeCancelCameraMotion )
		end

		if weaponData.RushOverride then
			for i, rushWeaponName in pairs(WeaponSets.HeroRushWeapons) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end

		if weaponData.OnChargeCancelFunctionName then
			thread( CallFunctionName, weaponData.OnChargeCancelFunctionName, triggerArgs, weaponData, weaponData.OnChargeFunctionArgs )
		end
		
		for i, traitData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnWeaponChargeCanceledFunctions ) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName then
				thread( CallFunctionName, traitData.FunctionName, weaponData, traitData.FunctionArgs, triggerArgs )
			end
		end

		StopWeaponSounds( "ChargeCancel", weaponData.Sounds, triggerArgs.OwnerTable )
	end
}

OnWeaponClipEmpty{
	function( triggerArgs )
		local weaponData = GetWeaponData( triggerArgs.OwnerTable, triggerArgs.name )
		if weaponData == nil then
			return
		end
		if weaponData.OnClipEmptyFunctionName then
			thread( CallFunctionName, weaponData.OnClipEmptyFunctionName, triggerArgs.OwnerTable, weaponData, weaponData.OnClipEmptyFunctionName )
		end

	end
}

OnPerfectChargeWindowEntered{
	function( triggerArgs )
		local duration = GetTotalHeroTraitValue("StagePerfectChargeWindow")
		if duration <= 0 then
			duration = 0.2
		end
		Flash({ Id = triggerArgs.OwnerTable.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = duration })
		PlaySound({ Name = "/SFX/Player Sounds/MelDashPressPoof", Id = triggerArgs.OwnerTable.ObjectId })
	end
}


OnWeaponFired{
	function( triggerArgs )

		local weaponName = triggerArgs.name
        if triggerArgs.OwnerTable.ObjectId == CurrentRun.Hero.ObjectId then
            CheckPlayerOnFirePowers( triggerArgs )
		end

        -- chaos curse effects
		if triggerArgs.OwnerTable == CurrentRun.Hero and not CurrentRun.Hero.Frozen and not CurrentRun.Hero.InvulnerableFlags.BlockDeath then
			for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.DamageOnFireWeapons ) do
				if Contains( data.WeaponNames, triggerArgs.name ) and ( data.IsEx == nil or ( data.IsEx and IsExWeapon( triggerArgs.name, {Combat = true}, triggerArgs ))) then
					thread( PlayVoiceLines, HeroVoiceLines.SelfDamageVoiceLines, false )
					SacrificeHealth( { SacrificeHealthMin = data.Damage, SacrificeHealthMax = data.Damage, MinHealth = 1, AttackerName = "TrialUpgrade" } )
					if CurrentRun.CurrentRoom.Encounter ~= nil then
						CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage = true
					end
				end
			end
		end

		local weaponData = triggerArgs.OwnerTable.WeaponDataOverride[weaponName] or WeaponData[weaponName]
		local projectileData = nil
		if triggerArgs.ProjectileName and ProjectileData[triggerArgs.ProjectileName] then
			projectileData = ProjectileData[triggerArgs.ProjectileName]
		end
		if weaponData == nil then
			return
		end
		
		if weaponData.ShowManaIndicator and MapState.ChargedManaWeapons[triggerArgs.name] then
			MapState.ChargedManaWeapons[triggerArgs.name] = true
		end
		
		local manaLimit = GetManaCost( weaponData )
		if manaLimit > 0 then
			if triggerArgs.OwnerTable.ObjectId == CurrentRun.Hero.ObjectId and ( IsEmpty( weaponData.ManaChanges ) or manaLimit <= CurrentRun.Hero.Mana or LastMomentManaRestoreEligible( manaLimit ) ) then
				ManaDelta( -manaLimit, { Source = weaponData.Name } )
			end
			if not SessionMapState.ChargeStageManaSpend[weaponData.Name] and IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
				SessionMapState.ChargeStageManaSpend[weaponData.Name] = manaLimit
			end
		end
		
		if triggerArgs.ProjectileVolley then
			SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] = MapState.WeaponCharge[ weaponData.Name ]
			if SessionMapState.FirstHitRecord[triggerArgs.ProjectileVolley] ~= nil then
				SessionMapState.FirstHitRecord[triggerArgs.ProjectileVolley][weaponData.Name] = nil
			end			
		end

		if weaponData.ExpireProjectilesOnFire ~= nil and not IsEmpty( weaponData.ExpireProjectilesOnFire ) then
			ExpireProjectiles({ Names = weaponData.ExpireProjectilesOnFire, CancelQueuedProjectilesOnId = CurrentRun.Hero.ObjectId })
		end
		
		if weaponData.CancelWeaponOnFire ~= nil then
			if MapState.EquippedWeapons[weaponData.CancelWeaponOnFire] then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.CancelWeaponOnFire, Method = "cancelCharge" })
			end
		end

		CurrentRun.WeaponsFiredRecord[weaponData.Name] = (CurrentRun.WeaponsFiredRecord[weaponData.Name] or 0) + 1
		GameState.WeaponsFiredRecord[weaponData.Name] = (GameState.WeaponsFiredRecord[weaponData.Name] or 0) + 1

		if weaponData.RushOverride then
			for i, rushWeaponName in ipairs( WeaponSets.HeroRushWeapons ) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end
		if not weaponData.RequireProjectilesForPresentation or ( triggerArgs.NumProjectiles and triggerArgs.NumProjectiles > 0 ) then
			if weaponData.FireCameraMotion ~= nil then
				thread( DoCameraMotion, weaponData.FireCameraMotion )
			end
			if weaponData.FireScreenshake ~= nil or (projectileData ~= nil and projectileData.FireScreenshake ~= nil) then
				DoWeaponScreenshake( weaponData, "FireScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = triggerArgs.ProjectileName })
			end

			if triggerArgs.IsPerfectCharge then
				CreateAnimation({ Name = "PerfectShotShroud", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, GroupName = "Combat_UI_World_Add" })
				CreateAnimation({ Name = "PerfectShotShroud_Dark", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, GroupName = "Combat_UI_World" })
			end

			if weaponData.Sounds ~= nil then
				if weaponData.Sounds.FireSounds ~= nil then
					if triggerArgs.IsPerfectCharge then
						DoWeaponSounds( weaponData.Sounds.FireSounds.PerfectChargeSounds, triggerArgs.OwnerTable, weaponData )
					else
						DoWeaponSounds( weaponData.Sounds.FireSounds.ImperfectChargeSounds, triggerArgs.OwnerTable, weaponData )
					end
				end
				if weaponData.Sounds.LowAmmoFireSounds ~= nil and triggerArgs.Ammo < weaponData.LowAmmoSoundThreshold then
					DoWeaponSounds( weaponData.Sounds.LowAmmoFireSounds, triggerArgs.OwnerTable, weaponData )
				elseif weaponData.Sounds.MaxStageSounds ~= nil and SessionMapState.MaxChargeStageReached[weaponData.Name] then
					DoWeaponSounds( weaponData.Sounds.MaxStageSounds, triggerArgs.OwnerTable, weaponData )
				elseif weaponData.Sounds.FireStageSounds ~= nil and MapState.WeaponCharge and MapState.WeaponCharge[triggerArgs.name] and MapState.WeaponCharge[triggerArgs.name] > 0 then
					DoWeaponSounds( weaponData.Sounds.FireStageSounds, triggerArgs.OwnerTable, weaponData )
				elseif weaponData.Sounds.FireSounds ~= nil then
					DoWeaponSounds( weaponData.Sounds.FireSounds, triggerArgs.OwnerTable, weaponData )
				end
				StopWeaponSounds( "Fired", weaponData.Sounds, triggerArgs.OwnerTable )
			end

			if weaponData.FireSimSlowParameters ~= nil then
				thread( DoWeaponFireSimulationSlow, weaponData )
			end
			if projectileData ~= nil and projectileData.FireRumbleParameters ~= nil then
				thread( DoRumble, projectileData.FireRumbleParameters )
			elseif weaponData.FireRumbleParameters ~= nil then
				thread( DoRumble, weaponData.FireRumbleParameters )
			end
		end

		if not weaponData.IgnoreObjectives then
			if MapState.WeaponCharge == nil or MapState.WeaponCharge[triggerArgs.name] == nil or MapState.WeaponCharge[triggerArgs.name] == 0 then
				thread( MarkObjectiveComplete, triggerArgs.name )
				
				if weaponData.CompleteObjectivesOnNonStagedFire ~= nil then
					thread( MarkObjectivesComplete, weaponData.CompleteObjectivesOnNonStagedFire )
				end
			end
		end

		if weaponData.CompleteObjectivesOnFire ~= nil then
			thread( MarkObjectivesComplete, weaponData.CompleteObjectivesOnFire )
		end

		if weaponData.OnFiredFunctionNames ~= nil then
			for i, functionName in ipairs( weaponData.OnFiredFunctionNames ) do
				CallFunctionName( functionName, triggerArgs.OwnerTable, weaponData, weaponData.OnFiredFunctionArgs, triggerArgs )
			end
		end
		for i, weaponFiredData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnWeaponFiredFunctions ) do
			if weaponFiredData.FunctionName ~= nil and ( weaponFiredData.ValidWeaponsLookup == nil or weaponFiredData.ValidWeaponsLookup[triggerArgs.name] ) then
				thread( CallFunctionName, weaponFiredData.FunctionName, weaponData, weaponFiredData.FunctionArgs, triggerArgs )
			end
		end

	end
}

function AddPlaceholderEnemyCount()
	MapState.PlaceholderEnemyCount = (MapState.PlaceholderEnemyCount or 0) + 1
	wait( 3.0, RoomThreadName )
	MapState.PlaceholderEnemyCount = MapState.PlaceholderEnemyCount - 1
end


function GetPlayerAngle()
	local playerAngleDegrees = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	return playerAngleDegrees
end

OnWeaponFired{ "WeaponCastArm",
	function( triggerArgs )
		if not HeroHasTrait("ApolloSecondStageCastBoon") or ( MapState.WeaponCharge[triggerArgs.name] and MapState.WeaponCharge[triggerArgs.name] > 0 ) then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = triggerArgs.name, Method = "ArmProjectiles" })
		end
		if MapState.EquippedWeapons.WeaponSuitRanged then
			SetWeaponProperty({ WeaponName = "WeaponSuitRanged", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		end
		
	end
}

OnProjectileArm{ "ProjectileCast",
	function( triggerArgs )
		for i, functionData in pairs(GetHeroTraitValues("OnProjectileArmFunction")) do
			CallFunctionName( functionData.FunctionName, triggerArgs, functionData.FunctionArgs )
		end
		IncrementTableValue( MapState, "ExCastCount" )
		UpdateWeaponMana()
	end
}

function CleanupEnemies( args )
	args = args or {}
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		CleanupEnemy( enemy )
		if args.Destroy and enemyId ~= args.DestroyIgnoreId then
			table.insert( SessionMapState.DestroyRequests, enemyId )
		end
	end
	ActiveEnemies = {}
	RequiredKillEnemies = {}
	ActiveGroupAIs = {}
	SurroundEnemiesAttacking = {}
	for obstacleId, obstacle in pairs( ShallowCopyTable( MapState.ActiveObstacles ) ) do
		if obstacle.AIThreadName ~= nil then
			killTaggedThreads( obstacle.AIThreadName )
		end
		if obstacle.AINotifyName ~= nil then
			killWaitUntilThreads( obstacle.AINotifyName )
		end
	end
end

function CleanupEnemy( enemy )
	killTaggedThreads( "EnemyHealthBarFalloff"..enemy.ObjectId )
	killTaggedThreads( "Activating"..enemy.ObjectId )
	killTaggedThreads(enemy.AIThreadName.."Fuse")
	killTaggedThreads( enemy.AIThreadName )
	killWaitUntilThreads( enemy.AINotifyName )
	killWaitUntilThreads(enemy.DumbFireThreadName)
	killTaggedThreads(enemy.DumbFireThreadName)
	FinishTargetMarker( enemy )
	if enemy.KillThreadNamesOnDeath ~= nil then
		for k, threadName in pairs(enemy.KillThreadNamesOnDeath) do
			killTaggedThreads(threadName)
		end
	end
	if enemy.ReloadSoundId ~= nil then
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })
	end
	if enemy.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
	end
	if enemy.WeaponFireLoopingSoundId ~= nil then
		StopSound({ Id = enemy.WeaponFireLoopingSoundId, Duration = 0.2 })
	end
	if enemy.ProjectileFuseSoundIds ~= nil then
		for soundId, v in pairs(enemy.ProjectileFuseSoundIds) do
			StopSound({ Id = soundId, Duration = 0.2 })
		end
	end
	if SessionMapState.MarkImages and SessionMapState.MarkImages[enemy.ObjectId] then
		SessionMapState.DestroyRequests = ConcatTableValues( SessionMapState.DestroyRequests, SessionMapState.MarkImages[enemy.ObjectId] )
		SessionMapState.MarkImages[enemy.ObjectId] = nil
	end
	if MapState.MarkDaggerEnemyId == enemy.ObjectId then
		table.insert( SessionMapState.DestroyRequests, MapState.MarkedDaggerTargetId )
	end
	if enemy.CreatedOwnTarget ~= nil then
		table.insert( SessionMapState.DestroyRequests, enemy.CreatedOwnTarget )
		enemy.CreatedOwnTarget = nil
	end
	if enemy.ActiveEffects then
		for effectName in pairs( enemy.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if  effectData ~= nil then
				if effectData.Vfx ~= nil then
					StopAnimation({ Name = effectData.Vfx, DestinationId = enemy.ObjectId, PreventChain = effectData.VfxPreventChainOnStop })
				end
				if effectData.BackVfx ~= nil then
					StopAnimation({ Name = effectData.BackVfx, DestinationId = enemy.ObjectId, PreventChain = effectData.VfxPreventChainOnStop })
				end
				if effectData.StopVfxes ~= nil then
					StopAnimation({ Names = effectData.StopVfxes, DestinationId = enemy.ObjectId, PreventChain = effectData.VfxPreventChainOnStop })
				end
				if effectData.StopVfxesPreventChain ~= nil then
					StopAnimation({ Names = effectData.StopVfxesPreventChain, DestinationId = enemy.ObjectId, PreventChain = true })
				end
			end
		end
	end
	if enemy.ActiveInputBlocks ~= nil then
		for k, inputBlockName in pairs( enemy.ActiveInputBlocks ) do
			RemoveInputBlock({ Name = inputBlockName })
		end
	end
	if enemy.CleanupResetColorGrading then
		AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	end
	if not IsEmpty( enemy.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = enemy.StopAnimationsOnHitStun, DestinationId = enemy.ObjectId, PreventChain = true })
		if enemy.FxTargetIdsUsed ~= nil then
			for id, v in pairs( enemy.FxTargetIdsUsed ) do
				StopAnimation({ Names = enemy.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end
	if enemy.AttachedAnimationName ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = enemy.AttachedAnimationName, IncludeCreatedAnimations = true })
	end
	if not IsEmpty( enemy.CreatedAnimations ) then
		StopAnimation({ DestinationId = enemy.ObjectId, Names = enemy.CreatedAnimations, IncludeCreatedAnimations = true })
	end
	RemoveEnemyUI( enemy )
	if not enemy.IgnoreProjectileExpireOnDeath then
		ExpireProjectiles({ Id = enemy.ObjectId, DieWithOwner = true })
	end
	if SurroundEnemiesAttacking[enemy.Name] ~= nil then
		SurroundEnemiesAttacking[enemy.Name][enemy.ObjectId] = nil
	end
	killWaitUntilThreads( enemy.SpawnPointThread )
	if enemy.CleanupAnimation ~= nil then
		SetAnimation({ Name = enemy.CleanupAnimation, DestinationId = enemy.ObjectId })
	end
end

OnHit{
	function( triggerArgs )
		
		local victim = triggerArgs.Victim
		if victim == nil then
			DebugAssert({ Condition = false, Text = "OnHit triggered with no Victim", Owner = "Gavin" })
			return
		end
		if victim.ExclusiveOnHitFunctionName ~= nil then
			CallFunctionName( victim.ExclusiveOnHitFunctionName, victim, triggerArgs, victim.ExclusiveOnHitFunctionArgs )
			return
		end

		if victim.DamageSurrogate ~= nil then
			victim = victim.DamageSurrogate
			triggerArgs.Victim = victim
			triggerArgs.IgnoreDamagedFxAtImpactLocation = true
		end

		local victimName = victim.Name
		local victimId = victim.ObjectId
		local attacker = triggerArgs.AttackerTable
		local attackerId = triggerArgs.AttackerId
		local attackerName = triggerArgs.AttackerName
		local attackerWeaponName = triggerArgs.SourceWeapon
		triggerArgs.AttackerWeaponData = GetWeaponData(attacker, attackerWeaponName)
		local attackerWeaponData = triggerArgs.AttackerWeaponData
		
		local sourceProjectileData = nil
		if triggerArgs.SourceProjectile ~= nil then
			sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
		end

		if triggerArgs.ProjectileWave and sourceProjectileData and sourceProjectileData.ExcludeSameWaveHits then
			if ProjectileHasUnitWaveHit( triggerArgs.SourceProjectile, triggerArgs.ProjectileVolley, triggerArgs.ProjectileWave, victimId ) then
				return
			else
				ProjectileRecordUnitWaveHit( triggerArgs.SourceProjectile, triggerArgs.ProjectileVolley, triggerArgs.ProjectileWave, victimId )
			end
		end

		if triggerArgs.DoubleStrikeTriggered or SessionMapState.DoubleStrikeProjectiles[triggerArgs.ProjectileId] then
			thread( DoubleStrikePresentation, victim )
			SessionMapState.DoubleStrikeProjectiles[triggerArgs.ProjectileId] = nil
		end

		--SessionMapState.OnHitsThisFrame = SessionMapState.OnHitsThisFrame + 1

		if attacker and victim.OnHitShake and not victim.OnHitShakeDisabled then
			if victim.OnHitShakeRequireAttackerGroup == nil or Contains( attacker.Groups, victim.OnHitShakeRequireAttackerGroup ) then
				victim.OnHitShake.Id = victim.ObjectId
				Shake( victim.OnHitShake )
			end
		end

		if CheckImpactReaction( attackerWeaponData, sourceProjectileData, victim, triggerArgs ) then
			DoReaction( victim, victim.ImpactReaction, triggerArgs )
		end

		if triggerArgs.IsInvulnerable and not victim.SkipInvulnerableOnHitPresentation and (not sourceProjectileData or not sourceProjectileData.IgnoreIndestructibleHitPresentation ) then
			HitInvulnerablePresentation( victim, attacker, triggerArgs )
		end

		if victim.OnHitVoiceLines ~= nil then
			thread( QueueOnHitVoiceLines, victim, triggerArgs )
		end
			
		if victim == CurrentRun.Hero and not triggerArgs.InvulnerableFromCoverage then
			if not ( victim == attacker and ( not attackerWeaponData or attackerWeaponData.SelfMultiplier == 0 )) then
				if HeroHasTrait("FirstHitHealTrait") and triggerArgs.DamageAmount > 0 and not triggerArgs.IsInvulnerable then
					
					local baseDamage = triggerArgs.DamageAmount + CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
					local multipliers = CalculateDamageMultipliers( attacker, victim, sourceWeaponData, triggerArgs )
					local additive = CalculateDamageAdditions( attacker, victim, sourceWeaponData, triggerArgs )
					local critChance = CalculateCritChance( attacker, victim, sourceWeaponData, triggerArgs )
					triggerArgs.IsCrit = RandomChance( critChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) + GetTotalHeroTraitValue("OutgoingUnmodifiedCritBonus") )
					triggerArgs.DamageAmount = round(baseDamage * multipliers) + additive
					if triggerArgs.IsCrit then
						triggerArgs.DamageAmount = triggerArgs.DamageAmount * 3
					end					
					local args = SessionMapState.FirstHitHeal
					Heal( CurrentRun.Hero, {HealAmount = triggerArgs.DamageAmount * args.HealPercent * CalculateHealingMultiplier(), SourceName = "FirstHitHealTrait" })
					if args.Vfx then
						CreateAnimation({ Name = args.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
					end
					if args.SoundName then
						PlaySound({ Name = args.SoundName, Id = CurrentRun.Hero.ObjectId })
					end
					if args.CombatText then
						thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = args.CombatText, PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )	
					end
					UseTrait( CurrentRun.Hero, "FirstHitHealTrait")
					if HeroHasTrait( "FirstHitHealTrait" ) then
						UpdateTraitNumber( GetHeroTrait("FirstHitHealTrait") )
					end
					if (MapState.DaggerBlockShieldActive and HeroHasTrait("DaggerBlockAspect")) then
						triggerArgs.InvulnerablePassthrough = true
					else
						return
					end
				end
				
				if (MapState.DaggerBlockShieldActive and HeroHasTrait("DaggerBlockAspect")) then
					triggerArgs.InvulnerablePassthrough = true
				elseif HeroHasTrait( "ReserveManaHitShieldBoon" ) then
				-- Player hit
					local tempInvulnerabilityTrait = nil
					for k, currentTrait in ipairs( CurrentRun.Hero.Traits ) do
						if currentTrait.Name == "ReserveManaHitShieldBoon" and IsOnlyInvulnerableSource("ManaReserveTraitInvulnerability") and CurrentRun.Hero.ActiveEffects.ReserveManaInvulnerability then
							tempInvulnerabilityTrait = currentTrait
						end
					end

					if tempInvulnerabilityTrait ~= nil and IsTraitActive( tempInvulnerabilityTrait ) then
						tempInvulnerabilityTrait.HasTriggered = true
						triggerArgs.IsInvulnerable = true
						thread( VulnerableAfterDelay, 1, "ReserveManaInvulnerability", "ManaReserveTraitInvulnerability" )
					end
				end
			end
		else
			-- Enemy hit
			if victim.CanBeAggroed and victim.IsAggroed == false and attackerId == CurrentRun.Hero.ObjectId and (sourceProjectileData == nil or not sourceProjectileData.SkipAggro) then
				thread( AggroUnit, victim, true )
			end
		end

		victim.Hits = (victim.Hits or 0) + 1

		if victim.OnHitFunctionName ~= nil then
			local consolidatedArgs = victim.OnHitFunctionArgs or triggerArgs
			CallFunctionName( victim.OnHitFunctionName, victim, consolidatedArgs, victim.OnHitFunctionArgs, triggerArgs )
		end
		if victim.OnHitEvents ~= nil then
			RunEventsGeneric( victim.OnHitEvents, victim, triggerArgs )
		end

		local attackCanDamageHero = true
		if victim == CurrentRun.Hero and attacker and attacker.OutgoingDamageModifiers then
			for i, data in ipairs(attacker.OutgoingDamageModifiers) do
				if data.PlayerMultiplier and data.PlayerMultiplier == 0 then
					attackCanDamageHero = false
					break
				end
			end
		end
		if victim == CurrentRun.Hero 
			and attackCanDamageHero
			and triggerArgs.SourceProjectile ~= "ProjectileZeusSpark"
			and triggerArgs.DamageAmount ~= nil 
			and triggerArgs.DamageAmount > 0 
			and ( triggerArgs.InvulnerablePassthrough or ( not triggerArgs.IsInvulnerable and ( not triggerArgs.InvulnerableFromCoverage or ( triggerArgs.InvulnerableFromCoverage and triggerArgs.SourceProjectile and GetBaseDataValue({ Type = "Projectile", Name = triggerArgs.SourceProjectile, Property = "IgnoreCoverageAngles" }) ) ) ) ) then
			if MapState.DaggerBlockShieldActive and HeroHasTrait("DaggerBlockAspect") then
				local traitData = GetHeroTrait("DaggerBlockAspect")
				local functionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
				thread( DaggerBlockTriggeredPresentation, functionArgs )
				CheckCooldown( "DaggerBlockShield", functionArgs.Cooldown)		
				SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.DaggerUI })
				UpdateDaggerUI()
				thread( DaggerBlockActivePresentation, traitData, functionArgs.Cooldown )
				thread( CheckDaggerBlockRecharge, traitData, functionArgs.Cooldown )
				if functionArgs.InvulnerableDuration then
					local effectName = functionArgs.InvulnerableEffectName
					local dataProperties = EffectData[effectName].DataProperties
					dataProperties.Duration = functionArgs.InvulnerableDuration
					ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
				end
				MapState.DaggerCharges = functionArgs.CritCount
				MapState.DaggerBlockShieldActive = false
				thread( SetupArtemisDaggerTicks, functionArgs )
				SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
				SetPlayerInterruptible("DaggerBlock")
				if functionArgs.Vfx then
					StopAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
				end
				if functionArgs.BackVfx then
					StopAnimation({ Name = functionArgs.BackVfx, DestinationId = CurrentRun.Hero.ObjectId })
				end
				AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
				thread( RemoveEffectBlockOnDelay, CurrentRun.Hero.ObjectId, 0.25, "MedeaPoison" )
				return
			end

			if SessionMapState.SprintActive and MapState.SprintShields > 0 and HeroHasTrait(MapState.SprintShieldTrait) then
				MapState.SprintShields = MapState.SprintShields - 1
				thread( SprintShieldTriggeredPresentation )
				if MapState.SprintShields <= 0 and MapState.SprintShieldFx then
					StopAnimation({ Name = MapState.SprintShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
				end
				AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
				thread( RemoveEffectBlockOnDelay, CurrentRun.Hero.ObjectId, 0.25, "MedeaPoison" )
				return
			end

			if MapState.BossShieldTriggers > 0 then
				MapState.BossShieldTriggers = MapState.BossShieldTriggers - 1
				thread( BossShieldTriggeredPresentation )
				if MapState.BossShieldTriggers <= 0 and MapState.BossShieldFx then
					StopAnimation({ Name = MapState.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId, IncludeCreatedAnimations = true })
				end
				AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
				thread( RemoveEffectBlockOnDelay, CurrentRun.Hero.ObjectId, 0.25, "MedeaPoison" )
				return
			end

			if MapState.FamiliarUnit ~= nil and MapState.FamiliarUnit.CanGuard then
				local traitData = GetHeroTrait( MapState.FamiliarUnit.TraitNames[1] )
				if traitData.RemainingBlocks > 0 then
					local isTrapDamage = ( attacker ~= nil and attacker.DamageType == "Neutral" ) or ( attacker == nil and attackerName ~= nil and EnemyData[attackerName] ~= nil and EnemyData[attackerName].DamageType == "Neutral" )
					if not isTrapDamage then
						traitData.RemainingBlocks = traitData.RemainingBlocks - 1
						thread( PolecatFamiliarGuard, MapState.FamiliarUnit, { AttackerId = triggerArgs.AttackerId, ImpactAngle = triggerArgs.ImpactAngle, RemainingBlocks = traitData.RemainingBlocks } )
						AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "MedeaPoison" })
						thread( RemoveEffectBlockOnDelay, CurrentRun.Hero.ObjectId, 0.25, "MedeaPoison" )
						return
					end
				end
			end

		end

		if triggerArgs.EffectName == nil then
			DoImpactSound( victim, triggerArgs )
		end
		if attackerWeaponData ~= nil and attackerWeaponData.OnHitFunctionNames ~= nil and not triggerArgs.IsInvulnerable then
			for k, functionName in pairs( attackerWeaponData.OnHitFunctionNames ) do
				thread( CallFunctionName, functionName, victim, victimId, triggerArgs )
			end
		end
		if sourceProjectileData ~= nil and sourceProjectileData.OnHitFunctionNames ~= nil and not triggerArgs.IsInvulnerable then
			for k, functionName in pairs( sourceProjectileData.OnHitFunctionNames ) do
				thread( CallFunctionName, functionName, victim, victimId, triggerArgs )
			end
		end

		if triggerArgs.CanHitWithoutDamage or ( triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 ) then
			Damage( victim, triggerArgs )
		end
	end
}

function QueueOnHitVoiceLines( victim, triggerArgs )

	local threadName = "OnHitVO"..victim.ObjectId
	if victim.OnHitVoiceLinesQueueDelay ~= nil and SetThreadWait( threadName, victim.OnHitVoiceLinesQueueDelay ) then
		return
	end
	wait( victim.OnHitVoiceLinesQueueDelay, threadName )

	if victim.Dead then
		return
	end

	if victim.OnHitVoiceLines ~= nil then
		PlayVoiceLines( victim.OnHitVoiceLines, true, victim, triggerArgs )
	end

end

OnProjectileCreation{
	function( triggerArgs )
		local attackerId = triggerArgs.triggeredById
		local attacker = triggerArgs.TriggeredByTable
		local projectileName = triggerArgs.name
		local projectileData = ProjectileData[projectileName]
		if projectileData ~= nil then
			if projectileData.OnCreationEvents ~= nil then
				RunEventsGeneric( projectileData.OnCreationEvents, projectileData, triggerArgs )
			end
			if projectileData.LifetimeSound ~= nil then
				MapState.ProjectileSounds[triggerArgs.ProjectileId] = PlaySound({ ProjectileId = triggerArgs.ProjectileId, Name = projectileData.LifetimeSound })
			end
		end
		if CurrentRun.Hero and attacker == CurrentRun.Hero then
			for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnProjectileCreationFunction ) do
				if data.Name and ( IsEmpty( data.ValidProjectilesLookup ) or data.ValidProjectilesLookup[triggerArgs.name] ) then
					CallFunctionName( data.Name, triggerArgs, data.Args )
				end
			end
		end
	end
}

OnProjectileDeath{
	function( triggerArgs )

		local victimId = triggerArgs.triggeredById
		local victim = triggerArgs.TriggeredByTable
		local attacker = triggerArgs.AttackerTable
		local weaponData = GetWeaponData( attacker, triggerArgs.WeaponName )
		local projectileData = ProjectileData[triggerArgs.name]

		SessionMapState.ExpireOldestProjectiles[triggerArgs.ProjectileId] = nil
		SessionState.EarlyDetonationProjectileIds[triggerArgs.ProjectileId] = nil
	
		if projectileData ~= nil then
			
			if projectileData.OnDeathEvents ~= nil then
				RunEventsGeneric( projectileData.OnDeathEvents, projectileData, triggerArgs )
			end
			if projectileData.LifetimeSound ~= nil then
				StopSound({ Id = MapState.ProjectileSounds[triggerArgs.ProjectileId], Duration = 0.2 })
				MapState.ProjectileSounds[triggerArgs.ProjectileId] = nil
			end

			if projectileData.DeathScreenShake then
				ShakeScreen( projectileData.DeathScreenShake )
			end

			if projectileData.OnDeathFunctionName ~= nil then
				CallFunctionName( projectileData.OnDeathFunctionName, projectileData, triggerArgs )
			end
			if victim == nil and victimId == nil and projectileData.OnDeathNoVictimFunctionName ~= nil then
				CallFunctionName( projectileData.OnDeathNoVictimFunctionName, projectileData, MergeTables( triggerArgs, projectileData.OnDeathNoVictimFunctionArgs ) )
			end
			if projectileData.CarriesSpawns then
				SessionMapState.ProjectilesCarryingSpawns[triggerArgs.ProjectileId] = nil
				SessionMapState.ProjectileSpawnRecord[triggerArgs.ProjectileId] = nil
				notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
				local encounter = nil
				if attacker ~= nil then
					encounter = attacker.Encounter
				end
				CheckAllRequiredKillEnemiesDead( encounter )
			end
		end
		if (CurrentRun.Hero and attacker == CurrentRun.Hero) or ( projectileData ~= nil and projectileData.CheckProjectileDeath ) then
			for i, data in pairs( GetHeroTraitValues( "OnProjectileDeathFunction" ) ) do
				if data.Name and ( IsEmpty(data.ValidProjectilesLookup) or data.ValidProjectilesLookup[triggerArgs.name]) then
					thread( CallFunctionName, data.Name, triggerArgs, data.Args )
				end
			end

			if weaponData and weaponData.OnProjectileDeathFunction then
				CallFunctionName( weaponData.OnProjectileDeathFunction, triggerArgs, weaponData.OnProjectileDeathFunctionArgs )
			end
			SessionMapState.ValidSuperchargeCastIds[triggerArgs.ProjectileId] = nil
			SessionMapState.FirstHitRecord[triggerArgs.ProjectileId] = nil
		end
	end
}

function CheckAllRequiredKillEnemiesDead( encounter )
	if IsEmpty( RequiredKillEnemies ) and IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) then
		notifyExistingWaiters( "AllRequiredKillEnemiesDead" )
		--DebugPrint({ Text = "AllRequiredKillEnemiesDead" })
	end
	if encounter ~= nil then
		local countRequirement = encounter.RequiredRemainingCountOverride or encounter.WaveRequiredRemainingCount or 0
		local activeEncounterSpawns = TableLength(encounter.ActiveSpawns)
		if activeEncounterSpawns <= countRequirement then
			notifyExistingWaiters( "RequiredEncounterEnemiesDead"..encounter.Name )
			--DebugPrint({ Text = "RequiredEncounterEnemiesDead"..encounter.Name })
		end
	end
end

function CheckImpactReaction( attackerWeaponData, sourceProjectileData, victim, triggerArgs )
	local victimImpactReactionData = victim.ImpactReaction

	if victimImpactReactionData == nil then
		return false
	end

	if victimImpactReactionData.RequiredSourceProjectile ~= nil and not Contains(victimImpactReactionData.RequiredSourceProjectile, triggerArgs.SourceProjectile) then
		return false
	end

	if victimImpactReactionData.RequireAnyProjectileNames ~= nil and triggerArgs.SourceProjectile ~= nil and not Contains(victimImpactReactionData.RequireAnyProjectileNames, triggerArgs.SourceProjectile) then
		return
	end

	if victimImpactReactionData.RequireNotProjectileNames ~= nil and triggerArgs.SourceProjectile ~= nil and Contains(victimImpactReactionData.RequireNotProjectileNames, triggerArgs.SourceProjectile) then
		return
	end

	if victimImpactReactionData.RequireAttackerName ~= nil and triggerArgs.AttackerName ~= nil and victimImpactReactionData.RequireAttackerName ~= triggerArgs.AttackerName then
		return
	end

	if victimImpactReactionData.RequireAnyAttackerName ~= nil and triggerArgs.AttackerName ~= nil and not Contains(victimImpactReactionData.RequireAnyAttackerName, triggerArgs.AttackerName) then
		return
	end
	
	attackerWeaponData = attackerWeaponData or {}
	sourceProjectileData = sourceProjectileData or {}

	victim.HitsTaken = victim.HitsTaken or 0
	local hits = attackerWeaponData.ImpactReactionHitsOverride or sourceProjectileData.ImpactReactionHitsOverride or 1
	victim.HitsTaken = victim.HitsTaken + hits

	if victimImpactReactionData.RequiredHitsForImpactReaction and victimImpactReactionData.RequiredHitsForImpactReaction > victim.HitsTaken then
		return false
	end

	return true
end

function Kill( victim, triggerArgs )

	if victim == nil then
		return
	end

	if victim.IsDead then
		-- Already killed
		return
	end

	if SessionMapState.HandlingDeath then
		-- No one can be killed after the hero dies, they can only be cleaned up directly
		return
	end

	triggerArgs = triggerArgs or {}

	local victimName = victim.Name
	local killer = triggerArgs.AttackerTable
	local destroyerId = triggerArgs.AttackerId
	local killingWeaponName = triggerArgs.SourceWeapon
	local currentRoom = CurrentHubRoom or CurrentRun.CurrentRoom
	
	currentRoom.Kills[victimName] = (currentRoom.Kills[victimName] or 0) + 1

	if victim.RoomRequiredObject then
		MapState.RoomRequiredObjects[victim.ObjectId] = nil
	end
	
	if victim ~= CurrentRun.Hero then
		-- Want this set when all the OnEffectCleared callbacks fire
		victim.IsDead = true
	end
	ClearEffect({ Id = victim.ObjectId, All = true, BlockAll = true, ResetAllegiance = not victim.AlwaysTraitor })
	EffectPostClearAll( victim )
	if victim ~= CurrentRun.Hero then
		KillEnemy( victim, triggerArgs )
	end

	for k, encounter in ipairs( currentRoom.ActiveEncounters ) do
		local encounterData = EncounterData[encounter.Name] or encounter
		if encounterData.WipeEnemiesOnKill == victimName then
			DestroyRequiredKills( { BlockLoot = true, SkipIds = { victim.ObjectId } } )
		elseif encounterData.WipeEnemiesOnKillAllTypes ~= nil then
			local killAll = true
			for k, type in pairs(encounterData.CancelSpawnsOnKillAllTypes) do
				for unitId, unit in pairs( ShallowCopyTable( RequiredKillEnemies ) ) do
					if unit.ObjectId ~= victim.ObjectId and unit.Name == type then
						killAll = false
						break
					end
				end
			end

			if killAll then
				DestroyRequiredKills( { BlockLoot = true, SkipIds = { victim.ObjectId } } )
			end
		end
		if encounter.SpawnThreadName ~= nil and CheckCancelSpawns( currentRoom, encounter ) then
			SetThreadWait( encounter.SpawnThreadName, 0 )
		end
		if encounter.OnKillFunctionName ~= nil then
			CallFunctionName( encounter.OnKillFunctionName, victim, triggerArgs )
		end
	end

	if victim.EndSpawnEncounterOnDeath and victim.SpawnedEncounter ~= nil then
		killTaggedThreads(victim.SpawnedEncounter.SpawnThreadName)
		victim.SpawnedEncounter.ForceEnd = true
		RemoveValueAndCollapse( currentRoom.ActiveEncounters, victim.SpawnedEncounter )
	end

	if killingWeaponName ~= nil and EnemyData[victimName] ~= nil and not victim.SkipModifiers then
		GameState.WeaponKills[killingWeaponName] = (GameState.WeaponKills[killingWeaponName] or 0) + 1
	end

	CheckOnKillWeaponUpgrades( destroyerId, victim, killingWeaponName )

	if ActiveEnemies[victim.ObjectId] ~= nil then
		if not victim.SkipRecordDestroyedState then
			RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Destroyed", true )
		end
		LastEnemyKilled = victim
		CleanupEnemy( victim )
	end
	local obstacle = MapState.ActiveObstacles[victim.ObjectId]
	if obstacle ~= nil then
		if not obstacle.SkipRecordDestroyedState then
			RecordObjectState( CurrentRun.CurrentRoom, obstacle.ObjectId, "Destroyed", true )
		end
		if obstacle.AIThreadName ~= nil then
			killTaggedThreads( obstacle.AIThreadName )
		end
		if obstacle.AINotifyName ~= nil then
			killWaitUntilThreads( obstacle.AINotifyName )
		end
	end

	if victim.OccupyingSpawnPointId ~= nil then
		UnoccupySpawnPoint( victim.OccupyingSpawnPointId )
	end

	CheckMoneyDrop( victim, victim.MoneyDropOnDeath, killer )

	if victim.ReloadSoundId ~= nil then
		StopSound({ Id = victim.ReloadSoundId, Duration = 0.2 })
	end
	if victim.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = victim.PreAttackLoopingSoundId, Duration = 0.2 })
	end

	if not triggerArgs.SkipOnDeathFunction then
		if victim.IsBoss and not victim.SkipDisableAllyUnitsOnDeath and ( not victim.UseGroupHealthBar or victim.GroupHealthBarOwner ) then
			DisableAllyUnits()
		end
		if victim.OnDeathFunctionName ~= nil then
			CallFunctionName( victim.OnDeathFunctionName, victim, victim.OnDeathFunctionArgs )
		end
		if victim.OnDeathThreadedFunctionName ~= nil then
			thread( CallFunctionName, victim.OnDeathThreadedFunctionName, victim, victim.OnDeathFunctionArgs )
		end
		if victim.IsBoss and not victim.BlockPostBossMetaUpgrades and ( not victim.UseGroupHealthBar or victim.GroupHealthBarOwner ) then
			local delay = 3.5
			local keepsakeDelay = 3.5
			if GetTotalHeroTraitValue("StoredGold") > 0 then
				local bankBoon = GetHeroTrait("BankBoon")
				local moneyDelay = 0.5
				thread( GushMoney, { Delay = moneyDelay, Amount = bankBoon.StoredGold, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "BankBoon" } )
				thread( BankPayoutPresentation, bankBoon.StoredGold, moneyDelay )
				delay = delay + moneyDelay + 0.5
				RemoveTrait( CurrentRun.Hero, "BankBoon" )
			end

			if GetTotalHeroTraitValue("PostBossCards") > 0 then
				AddRandomMetaUpgrades( GetTotalHeroTraitValue("PostBossCards"), { Delay = delay })
				delay = delay + keepsakeDelay
			end
		
			if HeroHasTrait("BossMetaUpgradeKeepsake") then
				local upgradeTrait = GetHeroTrait("BossMetaUpgradeKeepsake")
				if upgradeTrait.RemainingUses > 0 then
					AddRandomMetaUpgrades(2, { RarityLevel = GetTotalHeroTraitValue("PostBossCardRarity"), Delay = delay })
					UseHeroTraitsWithValue( "PostBossCardRarity" )
					upgradeTrait.CustomName = upgradeTrait.ZeroBonusTrayText or "BossMetaUpgradeKeepsake_Expired"
				end
			end
		end
	end

	if not triggerArgs.SkipDeathWeapons and victim.OnDeathFireWeapons ~= nil then
		for k, weaponName in pairs( victim.OnDeathFireWeapons ) do
			HandleDeathWeapon( victim, weaponName )
		end
	end

	if victim.FuseWarningAnimation then
		StopAnimation({ Name = victim.FuseWarningAnimation, DestinationId = victim.ObjectId })
	end

	if victim.SpawnObstaclesOnDeath ~= nil then
		SpawnObstaclesOnDeath( victim, triggerArgs )
	end

	if victim.SpawnUnitOnDeath ~= nil and not MapState.BlockSpawns then
		if (victim.SkipSpawnOverActiveCap ~= nil and GetActiveEnemyCount() >= victim.SkipSpawnOverActiveCap) or (victim.SpawnUnitOnDeathChance ~= nil and RandomChance(victim.SpawnUnitOnDeathChance)) then
			-- skip
		elseif victim.SkipSpawnUnitOnDeathIfLastAlive and TableLength( RequiredKillEnemies ) == 1 then
			-- skip
		else
			local newUnit = DeepCopyTable( EnemyData[victim.SpawnUnitOnDeath] )
			if ( victim.Charmed or victim.AlwaysTraitor ) then 
				newUnit.BlocksLootInteraction = false
				newUnit.AlwaysTraitor = true
				newUnit.Charmed = true
				newUnit.RequiredKill = false
			end
			if victim.SpawnedUnitDataOverrides ~= nil then
				OverwriteTableKeys(newUnit, victim.SpawnedUnitDataOverrides)
			end
			if victim.SkipActivatePresentationOnSpawns then
				newUnit.UseActivatePresentation = false
			end
			if newUnit.IsUnitGroup then
				SpawnUnitGroup(newUnit, nil, { SpawnOnIds = { victim.ObjectId } }, victim.ObjectId )
			else
				newUnit.ObjectId = SpawnUnit({ Name = victim.SpawnUnitOnDeath, Group = "Standing", DestinationId = victim.ObjectId })
				thread(SetupUnit, newUnit, CurrentRun)
			end
			if victim.SpawnUnitOnDeathMatchAngle then
				SetGoalAngle({ Id = newUnit.ObjectId, Angle = GetAngle({ Id = victim.ObjectId }), CompleteAngle = true })
			end
			if victim.SpawnUnitOnDeathSetGeometryToMarkers ~= nil then
				SetGeometry({ Id = newUnit.ObjectId, DestinationNames = victim.SpawnUnitOnDeathSetGeometryToMarkers, UseMarkerHull = true })
			end
		end
	end

	if victim.ActiveEffects ~= nil then
		for effectName, i in pairs( victim.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if effectData ~= nil and effectData.UnitDeathFunctionName ~= nil then
				CallFunctionName( effectData.UnitDeathFunctionName, victim )
			end
		end
	end

	MapState.ActiveObstacles[victim.ObjectId] = nil
	MapState.AggroedUnits[victim.ObjectId] = nil
	ActiveEnemies[victim.ObjectId] = nil
	if victim.Charmed then
		for k, unit in pairs(MapState.SpellSummons) do
			if victim == unit then
				table.remove(MapState.SpellSummons, k)
			end
		end
		for k, unit in pairs( SessionMapState.DeathSummons ) do
			if victim == unit then
				table.remove(SessionMapState.DeathSummons, k)
			end
		end
	end
	if RequiredKillEnemies[victim.ObjectId] ~= nil then
		RequiredKillEnemies[victim.ObjectId] = nil
		GameState.TotalRequiredEnemyKills = (GameState.TotalRequiredEnemyKills or 0) + 1
		if victim.Encounter ~= nil then
			victim.Encounter.ActiveSpawns[victim.ObjectId] = nil
		end
		local eggRespawning = CheckEggRespawn( victim, triggerArgs )
		notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
		notifyExistingWaiters( "RequiredEnemyKilled" )
		if not eggRespawning then
			CheckAllRequiredKillEnemiesDead( victim.Encounter )
		end

		for k, encounter in ipairs( currentRoom.ActiveEncounters ) do
			local encounterData = EncounterData[encounter.Name] or encounter
			if encounterData.RequiredKillFunctionName ~= nil then
				CallFunctionName( encounterData.RequiredKillFunctionName, encounter, victim, killer )
			end
		end
	end
	
	KillPresentation( victim, killer, triggerArgs )
	if victim == CurrentRun.Hero then
		ClipEvent({ Icon = "steam_timer", Title = GetDisplayName({ Text = "DeathMessage" }), Description = "", StartOffset = 0.0, Duration = 3.0 })
		KillHero( victim, triggerArgs )
	else
		if not triggerArgs.SkipDestroyDelay then
			wait( victim.DestroyDelay )
		end
		if not triggerArgs.SkipDestroy then
			Destroy({ Id = victim.ObjectId })
		end
	end

end

function SpawnObstaclesOnDeath( victim, triggerArgs )

	for k, spawnData in pairs( victim.SpawnObstaclesOnDeath ) do
		local offsetX = spawnData.OffsetX
		local offsetY = spawnData.OffsetY
		if spawnData.Radius ~= nil then
			offsetX = RandomFloat(-spawnData.Radius, spawnData.Radius)
			offsetY = RandomFloat(-spawnData.Radius, spawnData.Radius)
		end
		local spawn = DeepCopyTable( ObstacleData[spawnData.Name] ) or {}
		local spawnId = SpawnObstacle({ Name = spawnData.Name,
			Group = spawnData.GroupName or "Standing",
			DestinationId = victim.ObjectId,
			OffsetX = offsetX,
			OffsetY = offsetY,
			TriggerOnSpawn = false,
			AttachedTable = spawn,
		})		
		spawn.ObjectId = spawnId
		SetupObstacle( spawn, nil, { SkipAttachLua = true } )
		if spawnData.UpwardForce ~= nil and spawnData.UpwardForce > 0 then
			SetThingProperty({ Property = "OffsetZ", Value = 0, DestinationId = spawnId })
			SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = spawnId })
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = spawnId })
			ApplyUpwardForce({ Id = spawnId, Speed = spawnData.UpwardForce })
			ApplyForce({ Id = spawnId, Speed = RandomFloat( spawnData.RandomForceMin or 0, spawnData.RandomForceMax or 0 ), Angle = RandomFloat( 0, 360 ) })
		end
		if spawnData.HSV ~= nil then
			SetHSV({ Id = spawnId, HSV = spawnData.HSV })
		end
		if spawnData.Color ~= nil then
			SetColor({ Id = spawnId, Color = spawnData.Color })
		end
		if spawnData.Outline ~= nil then
			spawnData.Outline.Id = spawnId
			AddOutline( spawnData.Outline )
		end
		local angle = nil
		if spawnData.SyncOwnerAngle then
			angle = GetAngle({ Id = victim.ObjectId })
			SetAngle({ Id = spawnId, Angle = angle })
		end
		if spawnData.SyncFlip and IsHorizontallyFlipped({ Id = victim.ObjectId }) then
			FlipHorizontal({ Id = spawnId })
			RecordObjectState(CurrentRun.CurrentRoom, spawnId, "FlipHorizontal", true)
		end
		if spawnData.RestoreOnLoad then
			local encounter = CurrentRun.CurrentRoom.Encounter
			encounter.ObstaclesToRestore = encounter.ObstaclesToRestore or {}
			local location = GetLocation({ Id = spawnId })
			location.X = location.X + (offsetX or 0)
			location.Y = location.Y + (offsetY or 0)
			table.insert( encounter.ObstaclesToRestore, { Name = spawnData.RestoreOnLoadName or spawnData.Name, Location = location, Angle = angle, GroupName = spawnData.GroupName, } )
		end
	end

end

function HandleDeathWeapon(victim, weaponName)
	victim.WeaponName = weaponName
	if victim.WeaponHistory ~= nil then
		table.insert( victim.WeaponHistory, weaponName )
	end
	local aiData = GetWeaponAIData(victim)
	aiData.SkipCanAttack = true
	aiData.AIThreadName = victim.ObjectId.."OnDeathWeapon"
	victim.IgnoreSpeedMultiplier = true
	DoAttack(victim, aiData)
end

function SkellyDeath( victim, args )

	thread( CrowdReactionPresentationEventSource, victim, args )
	thread( MarkObjectiveComplete, "KillSkelly" )

	if victim.RespawnAtIdOnDeath then
		if victim.RespawnRequirements ~= nil and IsGameStateEligible( victim, victim.RespawnRequirements ) then
			thread( RespawnVictim, victim.Name, victim.RespawnAtIdOnDeath, victim.RespawnDelay, { Hits = victim.Hits, OnHitFunctionName = victim.OnHitFunctionName } )
		end
	end

	if victim.OnDeathVoiceLines then
		thread( PlayVoiceLines, victim.OnDeathVoiceLines, nil, victim )
	end

	if victim.UnuseableWhenDead then
		RefreshUseButton( victim.ObjectId, victim )
	end

end

function RespawnVictim( victimName, location, delay, args )
	args = args or {}
	local threadName = RoomThreadName
	if CurrentHubRoom == nil then
		threadName = CurrentRun.CurrentRoom.Encounter.SpawnThreadName or RoomThreadName
	end
	wait( delay or 1.0, threadName )

	local enemyData = EnemyData[victimName]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = location, OffsetX = 0, OffsetY = 0 })
	SetupUnit( newEnemy, CurrentRun, { OnSpawnVoiceLines = newEnemy.OnRespawnVoiceLines } )
	if args.DestroySpawnLocation then
		Destroy({ Id = location })
	end
	if args.Hits ~= nil then
		newEnemy.Hits = args.Hits
	end
	if args.OnHitFunctionName ~= nil then
		newEnemy.OnHitFunctionName = args.OnHitFunctionName
	end
end

function CheckOnKillWeaponUpgrades( killerId, victim, killingWeapon )

	local weaponData = WeaponData[killingWeapon]
	if weaponData == nil or victim == nil then
		return
	end

	local totalChance = 0
	local dropCap = {}
	local dropChance = {}
	local invalidDrops = {}
	for i, dropData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.DropOnKill ) do
		local checkValidLifeOnKill = ( dropData.ValidEnemies == nil and victim.DropItemsOnDeath ) or (dropData.ValidEnemies ~= nil and Contains( dropData.ValidEnemies, victim.GenusName ) or Contains( dropData.ValidEnemies, victim.Name ))
		if checkValidLifeOnKill then
			IncrementTableValue( dropChance, dropData.Name, dropData.Chance )
			if dropData.RoomCap and TableLength(GetIdsByType({ Name = dropData.Name })) > (dropData.RoomCap - 1) then
				invalidDrops[dropData.Name] = true
			end
			if dropData.DropCap then
				IncrementTableValue( dropCap, dropData.Name, dropData.DropCap )
			else
				-- arbitrarily high value if there's no cap
				IncrementTableValue( dropCap, dropData.Name, 1000 )
			end
		end
	end

	for key, dropChances in pairs( dropChance ) do
		while dropChances > 0 do
			local validDrop = true
			if invalidDrops[key] then
				validDrop = false
			end
			if SessionMapState.LifeOnKillRecord[key] ~= nil and SessionMapState.LifeOnKillRecord[key] >= dropCap[key] then
				validDrop = false
			end
			if RandomChance(dropChances * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) and validDrop then
				local id = SpawnObstacle({ Name = key, DestinationId = victim.ObjectId, Group = "Standing" })
				local reward = CreateConsumableItem( id, key, 0)
				reward.NPCDrop = true
				ApplyConsumableItemResourceMultiplier( CurrentRun, reward )
				ApplyUpwardForce({ Id = id, Speed = RandomFloat( 200, 300 ) })
				ApplyForce({ Id = id, Speed = RandomFloat( 900, 950 ), Angle = RandomFloat( 0, 360 ), SelfApplied = true })
				PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = id })

				SessionMapState.LifeOnKillRecord[key] = (SessionMapState.LifeOnKillRecord[key] or 0) + 1
			end
			dropChances = dropChances - 1
		end
	end

	if weaponData.LinkedUpgrades ~= nil then
		CheckOnKillWeaponUpgrades( killerId, victim, weaponData.LinkedUpgrades )
	end

end

function DropMinorConsumable( consumableName, targetId, radius, angle, dropTowardHero )
	if targetId == nil then
		targetId = CurrentRun.Hero.ObjectId
	end

	local offset = CalcOffset( angle or RandomFloat( 0, 360 ), radius or 5 )
	local dropId = SpawnObstacle({ Name = consumableName, DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y, Group = "Standing" })
	CreateConsumableItem( dropId, consumableName, 0 )
	ApplyUpwardForce({ Id = dropId, Speed = RandomFloat( 500, 700 ) })
	if not dropTowardHero then
		ApplyForce({ Id = dropId, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	else
		local forceAngle = GetAngleBetween({ Id = dropId, DestinationId = CurrentRun.Hero.ObjectId })
		ApplyForce({ Id = dropId, Speed = 100, Angle = forceAngle, SelfApplied = true })
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = dropId })
end

OnEffectApply{
	function( triggerArgs )
		local victim = triggerArgs.Victim
		EffectApply( victim, triggerArgs )
	end
}

function EffectApply( victim, triggerArgs )
		
	if not victim or ( victim.IsDead and victim ~= CurrentRun.Hero ) then
		return
	end
	if victim.DamageSurrogate ~= nil then
		victim = victim.DamageSurrogate
		triggerArgs.Victim = victim
	end
	local effectData = EffectData[triggerArgs.EffectName]
		
	victim.ActiveEffects = victim.ActiveEffects or {}
	if not effectData or not effectData.CustomStackHandling then
		victim.ActiveEffects[triggerArgs.EffectName] = triggerArgs.Stacks or 1
	end
	EffectApplyPresentation( victim, effectData, triggerArgs )
		
	CheckStunAnimation( triggerArgs ) 
	if effectData ~= nil and effectData.OnApplyFunctionName ~= nil then
		CallFunctionName( effectData.OnApplyFunctionName, triggerArgs, effectData.OnApplyFunctionArgs )
	else
		local applyFunctionName = triggerArgs.EffectName.."Apply"
		if _G[applyFunctionName] ~= nil then
			CallFunctionName( applyFunctionName, triggerArgs )
		end
	end
	if effectData ~= nil and victim.OnEffectApplyFunctionNames ~= nil then
		local functionName = victim.OnEffectApplyFunctionNames[effectData.Name]
		if functionName ~= nil then
			CallFunctionName( functionName, triggerArgs )
		end
	end
	if not triggerArgs.Reapplied then
		local unit = victim
		if triggerArgs.EffectType == "DAMAGE_OUTPUT" then
			local modifier = triggerArgs.Modifier
			AddOutgoingDamageModifier( unit,
			{
				Name = triggerArgs.EffectName,
				GlobalMultiplier = modifier,
				Temporary = true,
			})
		elseif triggerArgs.EffectType == "DAMAGE_TAKEN" then
			AddIncomingDamageModifier( unit,
			{
				Name = triggerArgs.EffectName,
				GlobalMultiplier = triggerArgs.Modifier,
				Temporary = true,
			})
		elseif triggerArgs.EffectType == "SPEED" and victim == CurrentRun.Hero then
			RecordSpeedModifier( triggerArgs.Modifier, triggerArgs.Duration )
		elseif triggerArgs.EffectType == "INVULNERABLE" then
			if victim ~= CurrentRun.Hero then
				SetUnitInvulnerable( victim , triggerArgs.EffectName )
			elseif EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].ShowInvincububble then
				local hasInvincibubble = false
				for effectName in pairs( CurrentRun.Hero.ActiveEffects ) do
					if effectName ~= triggerArgs.EffectName and EffectData[effectName] and EffectData[effectName].ShowInvincububble then
						hasInvincibubble = true
					end
				end
				if not hasInvincibubble then
					CreateAnimation({ Name = "Invincibubble_Zag_Loop", DestinationId = CurrentRun.Hero.ObjectId})
				end
			end
		end
	end
	if not triggerArgs.Reapplied or ( EffectData[triggerArgs.EffectName] and ( EffectData[triggerArgs.EffectName].UpdateStacksOnReapply or EffectData[triggerArgs.EffectName].ShowDuration)) then
		UpdateEffectStacks( victim, triggerArgs.EffectName )
	end
	for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnEffectApplyFunction ) do
		CallFunctionName( data.FunctionName, victim, data.FunctionArgs, triggerArgs )
	end
	if triggerArgs.IsVulnerabilityEffect and triggerArgs.BlockedEffect ~= triggerArgs.EffectName then
		victim.VulnerabilityEffects = victim.VulnerabilityEffects or {}
		local categoryName = triggerArgs.EffectName
		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DisplaySuffix then
			categoryName = EffectData[triggerArgs.EffectName].DisplaySuffix
		end
		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].SharedVulnerabilityCategory then
			categoryName = EffectData[triggerArgs.EffectName].SharedVulnerabilityCategory
		end
		victim.VulnerabilityEffects[ categoryName ] = true
		if HeroHasTrait("EffectVulnerabilityMetaUpgrade") then
			local modifierData = GetOutgoingDamageModifier( CurrentRun.Hero, "EffectVulnerabilityMetaUpgrade" )
			if modifierData ~= nil and TableLength(victim.VulnerabilityEffects) >= modifierData.MinRequiredVulnerabilityEffects then
				local effectName = "VulnerabilityIndicator"
				EffectApply( victim, { EffectName = effectName } )
			end
		end
	end
end

OnEffectCleared{
	function( triggerArgs )
		local unit = triggerArgs.Victim
		EffectClear( unit, triggerArgs )
	end
}

function EffectPostClearAll( unit, args )
	-- Need to also clear any effects no longer tracked by the engine
	if unit.ActiveEffects ~= nil then
		args = args or {}
		local effectName = "VulnerabilityIndicator"
		if unit.ActiveEffects[effectName] ~= nil then
			if args.ExcludeNames == nil or not Contains( args.ExcludeNames, effectName ) then
				EffectClear( unit, { Victim = unit, EffectName = effectName, Exists = true } )
			end
		end
		--[[
		for effectName, numStacks in pairs( ShallowCopyTable( unit.ActiveEffects ) ) do
			DebugPrint({ Text = "Extra clear for "..effectName })
			if args.ExcludeNames == nil or not Contains( args.ExcludeNames, effectName ) then
				EffectClear( unit, { Victim = unit, EffectName = effectName, Exists = true } )
			end
		end]]
	end
end

function EffectClear( unit, triggerArgs )
	if not triggerArgs.Exists then
		return
	end
	if unit == nil then
		return
	end

	local effectData = EffectData[triggerArgs.EffectName]

	unit.ActiveEffects = unit.ActiveEffects or {}
	unit.ActiveEffects[triggerArgs.EffectName] = nil
	if triggerArgs.IsVulnerabilityEffect and unit.VulnerabilityEffects then
		local categoryName = triggerArgs.EffectName
		if effectData ~= nil then
			if effectData.DisplaySuffix  then
				categoryName = effectData.DisplaySuffix
			end
			if effectData.SharedVulnerabilityCategory  then
				categoryName = effectData.SharedVulnerabilityCategory
			end
		end
		local hasSharedCategory = false
		for effectName in pairs( unit.ActiveEffects ) do
			local activeEffectData = EffectData[effectName]
			if activeEffectData ~= nil and ( effectName == categoryName 
				or activeEffectData.DisplaySuffix == categoryName
				or activeEffectData.SharedVulnerabilityCategory == categoryName ) then
				hasSharedCategory = true
			end
		end
		if not hasSharedCategory then
			unit.VulnerabilityEffects[categoryName] = nil
		end
		if not unit.IsDead and HeroHasTrait( "EffectVulnerabilityMetaUpgrade" ) then -- If unit is dead ClearEffect was already called with All = true
			local modifierData = GetOutgoingDamageModifier( CurrentRun.Hero, "EffectVulnerabilityMetaUpgrade" )
			if modifierData ~= nil and TableLength( unit.VulnerabilityEffects ) < modifierData.MinRequiredVulnerabilityEffects then
				EffectClear( unit, { Victim = unit, EffectName = "VulnerabilityIndicator", Exists = true } )
			end
		end
	end

	if effectData ~= nil and effectData.OnClearFunctionName ~= nil then
		CallFunctionName( effectData.OnClearFunctionName, triggerArgs, effectData.OnClearFunctionArgs )
	elseif _G[triggerArgs.EffectName.."Clear"] then
		_G[triggerArgs.EffectName.."Clear"](triggerArgs)
	end
	if effectData ~= nil and unit.OnEffectClearFunctionNames ~= nil then
		local functionName = unit.OnEffectClearFunctionNames[effectData.Name]
		if functionName ~= nil then
			CallFunctionName( functionName, triggerArgs )
		end
	end
	UpdateEffectStacks( unit, triggerArgs.EffectName )

	if triggerArgs.EffectType == "DAMAGE_OUTPUT" and unit.OutgoingDamageModifiers ~= nil then
		RemoveOutgoingDamageModifier( unit, triggerArgs.EffectName )
	elseif triggerArgs.EffectType == "DAMAGE_TAKEN" and unit.IncomingDamageModifiers ~= nil then
		RemoveIncomingDamageModifier( unit, triggerArgs.EffectName )
	elseif triggerArgs.EffectType == "INVULNERABLE" then
		SetUnitVulnerable( unit , triggerArgs.EffectName )
		if unit == CurrentRun.Hero and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].ShowInvincububble then
			local hasInvincibubble = false
			for effectName in pairs( CurrentRun.Hero.ActiveEffects ) do
				if effectName ~= triggerArgs.EffectName and EffectData[effectName] and EffectData[effectName].ShowInvincububble then
					hasInvincibubble = true
				end
			end
			if not hasInvincibubble then
				StopAnimation({ Name = "Invincibubble_Zag_Loop", DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end

	if effectData ~= nil then
		local animsToStop = {}
		local animsToStopAndPreventChain = {}
		if effectData.Vfx ~= nil then
			table.insert( animsToStop, effectData.Vfx )
		end
		if effectData.BackVfx ~= nil then
			table.insert( animsToStop, effectData.BackVfx )
		end
		if effectData.StopVfxes ~= nil then
			ConcatTableValues( animsToStop, effectData.StopVfxes )
		end
		if effectData.StopVfxesPreventChain ~= nil then
			ConcatTableValues( animsToStopAndPreventChain, effectData.StopVfxesPreventChain )
		end
		if effectData.StopVfxesPreventChainOnCancel ~= nil and triggerArgs.Canceled then
			ConcatTableValues( animsToStopAndPreventChain, effectData.StopVfxesPreventChainOnCancel )
		end
		if not IsEmpty( animsToStop ) then
			StopAnimation({ Names = animsToStop, DestinationId = unit.ObjectId, PreventChain = effectData.VfxPreventChainOnStop })
		end
		if not IsEmpty( animsToStopAndPreventChain ) then
			StopAnimation({ Names = animsToStopAndPreventChain, DestinationId = unit.ObjectId, PreventChain = true })
		end
	end
	for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnEffectClearFunction ) do
		CallFunctionName( data.FunctionName, unit, data.FunctionArgs, triggerArgs )
	end
end

OnEffectStackDecrease{
	function( triggerArgs )
		local effectData = EffectData[triggerArgs.EffectName]
		if effectData and effectData.OnEffectStackDecreaseFunctionName then
			CallFunctionName( effectData.OnEffectStackDecreaseFunctionName, triggerArgs)
		end
	end
}

OnEffectDelayedKnockbackForce{
	function( triggerArgs )
		local victim = triggerArgs.Victim
		if victim.ObjectId ~= CurrentRun.Hero.ObjectId then
			if not triggerArgs.ImmuneToKnockUp and not triggerArgs.ImmuneToForceDataValue and triggerArgs.ImpactVelocity > 0 then
				SetThingProperty({ DestinationId = victim.ObjectId, Property = "ImmuneToForce", Value = true })
				victim.ResetOnTouchdown = triggerArgs.ImmuneToForceDataValue
				CreateAnimation({ Name = "PoseidonKnockupPuddle", DestinationId = victim.ObjectId })
			end
		end
	end
}

function GetGameplayElapsedTimeMultiplier( id )
	local minValue = 1
	for name, data in pairs( SessionState.GameplaySlows ) do
		if ( not id or data.IgnoreId ~= id ) and data.Amount < minValue then
			minValue = data.Amount
		end
	end
	return minValue
end

function GetPlayerGameplayElapsedTimeMultiplier()
	local minValue = 1
	for name, data in pairs( SessionState.PlayerGameplaySlows ) do
		if data.Amount < minValue then
			minValue = data.Amount
		end
	end
	return minValue
end

function ClearGameplayElapsedTimeMultipliers()
	GameplaySetElapsedTimeMultiplier({ ClearAll = true })
end

function GameplaySetElapsedTimeMultiplier( args )
	args = args or {}

	local name = args.Name or "Generic"
	local startingMultiplier = GetGameplayElapsedTimeMultiplier()
	local startingPlayerMultiplier = GetPlayerGameplayElapsedTimeMultiplier()
	if args.ElapsedTimeMultiplier and args.ElapsedTimeMultiplier < 0.1 and not args.Force then
		args.ElapsedTimeMultiplier = 0.1
	end
	
	if args.ClearAll then
		SessionState.GameplaySlows = {}	
		SessionState.PlayerGameplaySlows = {}	
	else
		if args.Reverse then
			SessionState.GameplaySlows[name] = nil
			if args.ApplyToPlayerUnits then
				SessionState.PlayerGameplaySlows[name] = nil
			end
		else
			local ignoreId = nil
			if args.Ignore and args.Ignore.ObjectId then
				ignoreId = args.Ignore.ObjectId
			end
			SessionState.GameplaySlows[name] = { Amount = args.ElapsedTimeMultiplier, IgnoreId = ignoreId }
			if args.ApplyToPlayerUnits then
				SessionState.PlayerGameplaySlows[name] = { Amount = args.ElapsedTimeMultiplier }
			end
		end
	end
	local currentMultiplier = GetGameplayElapsedTimeMultiplier()
	local currentPlayerMultiplier = GetPlayerGameplayElapsedTimeMultiplier()

	if args.Ignore ~= nil and not args.Ignore.IgnoreTimeSlowEffects then -- Already permanently added, do not modify
		if args.Reverse then
			SessionMapState.ElapsedTimeMultiplierIgnores[args.Ignore.AIThreadName] = nil
		else
			SessionMapState.ElapsedTimeMultiplierIgnores[args.Ignore.AIThreadName] = true
		end
	end
	SetElapsedTimeMultiplier( currentMultiplier/ startingMultiplier, nil )

	if startingMultiplier == 1 and currentMultiplier < 1 and not args.SkipPresentation then
		thread( CallFunctionName, args.TimeSlowPresentationFunction or "StartTimeSlowPresentation" )
	elseif startingMultiplier < 1 and currentMultiplier == 1 and not args.SkipPresentation then
		if SessionMapState.TimeSlowSoundId then
			StopSound({ Id = SessionMapState.TimeSlowSoundId, Duration = 0.2 })
		end
		local endTimeSlowPresentationName = args.EndTimeSlowPresentationFunction or "EndTimeSlowPresentation"
		if endTimeSlowPresentationName ~= "EndTimeSlowPresentation" and ScreenAnchors.TimeStopVignette then
			Destroy({ Id = ScreenAnchors.TimeStopVignette })
			ScreenAnchors.TimeStopVignette = nil
		end
		thread( CallFunctionName, endTimeSlowPresentationName )
	end
		
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = currentMultiplier, DataValue = false, ValueChangeType = "Absolute", AllProjectiles = true })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = currentMultiplier/ startingMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam", "RoomWeapon" } })

	local elapsedTimePropertyTable = { Property = "ElapsedTimeMultiplier", Value = 0.0, ValueChangeType = "Absolute", DataValue = false, DestinationId = 1 }
	for enemyId, enemy in pairs( ActiveEnemies ) do
		if not enemy.IgnoreElapsedTimeMultiplier then
			local newElapsedTimeMultiplier = enemy.SpeedMultiplier or 1.0
			if not enemy.IgnoreTimeSlowEffects and enemy ~= args.Ignore then
				newElapsedTimeMultiplier = newElapsedTimeMultiplier * GetGameplayElapsedTimeMultiplier( enemyId )
			end
			elapsedTimePropertyTable.Value = newElapsedTimeMultiplier
			elapsedTimePropertyTable.DestinationId = enemyId
			SetThingProperty(elapsedTimePropertyTable)
		end
	end
	if args.ApplyToPlayerUnits then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = GetPlayerGameplayElapsedTimeMultiplier(), ValueChangeType = "Absolute", DataValue = false, DestinationNames = { "HeroTeam" } })
	end

	SetAnimationSpeedMultiplier({ DestinationIds = GetAllKeys( MapState.Reticles ), PlaySpeed = currentMultiplier })
end

function ActivateFuse( enemy )
	if enemy.FuseActivated then
		return
	end
	CleanupEnemy( enemy )
	enemy.FuseActivated = true
	enemy.CannotDieFromDamage = true
	ActivateFusePresentation( enemy )
	wait( enemy.FuseDuration )
	PostActivatFusePresentation( enemy )
	Kill( enemy, { SkipDestroy = enemy.PostFuseRevive or enemy.SkipDeathDestroy } )
	wait( enemy.FuseDormantDuration, RoomThreadName )
	if enemy.PostFuseRevive then
		PostFuseRevivePresentation( enemy )
		enemy.FuseActivated = false
		enemy.IsDead = false
	end
end

function ActivateLuciferFuse( enemy )
	if enemy.FuseActivated or enemy.IsDead then
		return
	end
	enemy.FuseActivated = true
	ActivateFusePresentation( enemy )
	local delay = 0
	CurrentRun.CurrentRoom.FusedBombs = CurrentRun.CurrentRoom.FusedBombs  or {}
	while CurrentRun.CurrentRoom.FusedBombs[_worldTime + enemy.FuseDuration + delay ] and delay < 2 do
		delay = delay + 0.1
	end
	local key = _worldTime + enemy.FuseDuration + delay
	CurrentRun.CurrentRoom.FusedBombs[_worldTime + enemy.FuseDuration + delay] = enemy
	wait( enemy.FuseDuration + delay, RoomThreadName )
	PostActivatFusePresentation( enemy )
	Kill( enemy, { SkipDestroy = false } )
	CurrentRun.CurrentRoom.FusedBombs[key] = nil
end

function CheckDashOverride( source )
	if source.RushMaxRangeOverride ~= nil then
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "BlinkMaxRange", Value = source.RushMaxRangeOverride, ValueChangeType = "Absolute" })
	else
		--DebugPrint({ Text = "Setting Default Rush Weapon" })
		SetWeaponProperty({ WeaponName = "WeaponBlink", DestinationId = CurrentRun.Hero.ObjectId, Property = "BlinkMaxRange", Value = CurrentRun.Hero.RushWeaponMaxRange, ValueChangeType = "Absolute" })
	end
end

function EquipPlayerWeapon( weaponData, args )

	if weaponData == nil then
		return
	end

	args = args or {}
	GameState.PrimaryWeaponName = weaponData.Name
	if not GameState.WeaponsUnlocked[weaponData.Name] then
		GameState.WeaponsUnlocked[weaponData.Name] = true
		CurrentRun.WeaponsUnlocked[weaponData.Name] = true
	end
	GameState.WeaponsTouched[weaponData.Name] = true
	thread( CheckQuestStatus )

	local heroId = CurrentRun.Hero.ObjectId
	local newWeaponEquipped = false
	if not CurrentRun.Hero.Weapons[weaponData.Name] then
		newWeaponEquipped = true
	end
	CurrentRun.Hero.Weapons[weaponData.Name] = true
	if weaponData.SecondaryWeapon then
		CurrentRun.Hero.Weapons[weaponData.SecondaryWeapon] = true
	end

	local toEquip = {}
	table.insert( toEquip, weaponData.Name )
	ConcatTableValues( toEquip, WeaponSets.HeroWeaponSets[weaponData.Name] )	
	EquipWeapon({ DestinationId = heroId, Names = toEquip, LoadPackages = args.LoadPackages })
	OverwriteTableKeys( MapState.EquippedWeapons, ToLookup(toEquip) )

	if MapState.WeaponSpawns ~= nil then
		for spawnId, spawn in pairs( MapState.WeaponSpawns ) do
			Kill( spawn )
		end
		MapState.WeaponSpawns = nil
	end

	local toUnequip = {}
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if weaponName ~= weaponData.Name then
			CurrentRun.Hero.Weapons[weaponName] = nil
			local unequipWeaponData = WeaponData[weaponName]
			if unequipWeaponData.SecondaryWeapon ~= nil then
				CurrentRun.Hero.Weapons[unequipWeaponData.SecondaryWeapon] = nil
			end
			table.insert( toUnequip, weaponName )			
			ConcatTableValues( toUnequip, WeaponSets.HeroWeaponSets[weaponName] )
			if unequipWeaponData.DummyTraitName ~= nil then
				RemoveTrait( CurrentRun.Hero, unequipWeaponData.DummyTraitName )
			end
			if unequipWeaponData.UnequipFunctionName then
				thread( CallFunctionName, unequipWeaponData.UnequipFunctionName )
			end
		end
	end
	UnequipWeapon({ DestinationId = heroId, Names = toUnequip, UnloadPackages = false })
	RemoveTableValues( MapState.EquippedWeapons, toUnequip )

	if newWeaponEquipped then
		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait2" )
		if IsBonusUnusedWeapon( weaponData.Name ) then
			if GameState.WorldUpgrades.WorldUpgradeUnusedWeaponBonusT2 then
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTrait2", SkipNewTraitHighlight = args.SkipPresentation, TraitAddedPresentationDelay = 0.2 })
			else
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTrait", SkipNewTraitHighlight = args.SkipPresentation, TraitAddedPresentationDelay = 0.2 })
			end
			args.BonusUnusedWeapon = true
		end
	end

	if not args.SkipAnimSwap then
		HandleWeaponAnimSwaps()
	end
	
	if weaponData.MaxAmmo then
		ReloadAmmo( weaponData )
	end
	if weaponData.OnFiredFunctionArgs and not IsEmpty(weaponData.OnFiredFunctionArgs.SequencedAnimations) then
		local initialSequence = weaponData.OnFiredFunctionArgs.SequencedAnimations[1]
		if weaponData.OnFiredFunctionArgs.StartingAnimation then
			initialSequence = weaponData.OnFiredFunctionArgs.StartingAnimation
		end
		for propertyName, propertyValue in pairs(initialSequence) do
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
		end
	end
	RefillMana()
	if not args.SkipPresentation then
		thread( EquipPlayerWeaponPresentation, weaponData, args )
	end

end

function SelfDestruct( owner )
	thread( Kill, owner )
end

function HitByFreezeWeapon( victim )

	if victim == nil or victim.IsDead then
		return
	end

	if not victim.CanBeFrozen then
		return
	end

	victim.FreeEscapeAttempts = 0
	FrozenPresentation( victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	if not IsEmpty( victim.ExpireProjectileIdsOnFreeze ) then
		ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnFreeze })
	end
	victim.Frozen = true
	victim.Mute = true
	wait(0.02)

	thread( FreezeEscape, victim )
	if victim.Frozen then
		local notifyName = "FreezeStunExpired"..victim.ObjectId
		NotifyOnEffectExpired({ Id = victim.ObjectId, Notify = notifyName, EffectName = "FreezeStun" })
		waitUntil( notifyName )
	end
	UnfrozenPresentation( victim )
	victim.Frozen = false
	victim.Mute = false

end

function FreezeEscape( victim )

	while victim.Frozen do

		local didEscapeAttempt = false
		if victim == CurrentRun.Hero then
			local notifyName = "FreezeEscape"
			NotifyOnControlPressed({ Names = { "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock" }, Notify = notifyName, Timeout = 1.0 })
			waitUntil( notifyName )
			if not _eventTimeoutRecord[notifyName] then
				didEscapeAttempt = true
				victim.FreeEscapeAttempts = victim.FreeEscapeAttempts + 1
			end
		else
			-- Simulate enemies trying to break free every on an interval
			local freezeBreakDuration = victim.FreezeBreakDuration or 0.5
			wait( freezeBreakDuration, RoomThreadName )
			didEscapeAttempt = true
		end

		if didEscapeAttempt then
			ModifyEffect({ Id = victim.ObjectId, Names = { "FreezeStun" }, AddTime = -(victim.FreezeTimeReductionPerInput or 0.5) })
			FreezeEscapeInputPresentation( victim )
		end
		wait( 0.02, RoomThreadName )
	end

end

function ScaleToHealthPercentage(source, args)
	if source.MaxHealth == nil then
		DebugPrint({ Text = source.Name.." - ScaleToHealthPercentage has no health" })
		return
	end
	if source.DefaultScale == nil then
		DebugPrint({ Text = source.Name.." - ScaleToHealthPercentage has no DefaultScale" })
		return
	end

	local healthPercent = source.Health / source.MaxHealth 
	local targetScale = source.DefaultScale * healthPercent
	targetScale = math.max(targetScale, 0.4)

	SetScale({ Id = source.ObjectId, Fraction = targetScale })
	SetDamageRadiusMultiplier({ Ids = source.DamageRadiusIdsByHealthPercent, Fraction = healthPercent, Duration = 0.3 })
end

function StartWeaponSlowMotion( triggerArgs, weaponData, args )
	if args == nil then
		return
	end

	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Name = weaponData.Name, Force = args.Force })
	thread( EndWeaponSlowMotion, weaponData, args )
end

function EndWeaponSlowMotion( weaponData, args )
	local notifyName = "WeaponFired"
	if args == nil then
		return
	end
	if args.Duration then
		if args.EndWarnNum then
			local totalDuration = args.Duration
			waitUnmodified( args.Duration - args.EndWarnNum, "WeaponTimeSlow" )
			for i=1, args.EndWarnNum do
				CallFunctionName( args.EndWarnPresentationFunction )
				waitUnmodified( 1, "WeaponTimeSlow" )
			end
		else
			waitUnmodified( args.Duration, "WeaponTimeSlow" )
		end
	else
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=" })
		waitUntil( notifyName )	
	end
	CallFunctionName( args.EndSlowMotionFunctionName, args )
	GameplaySetElapsedTimeMultiplier({ ElapsedTimeMultiplier = args.Modifier, Reverse = true, Name = weaponData.Name })
end

function SpreadBrushFire(grassObject)
	if grassObject.OnFire then
		return
	end

	grassObject.OnFire = true
	SetAnimation({ Name="WheatClusterC_Burnt", DestinationId = grassObject.ObjectId })
	SetAnimation({ Name="Blank", DestinationId=grassObject.ObjectId })
	wait(RandomFloat(1.0, 3.0))
	local neighborIds = GetClosestIds({ Id = grassObject.ObjectId, DestinationIds = GetIdsByType({ Name = "H_TallGrass" }), Distance = 75 })
	for k, id in pairs(neighborIds) do
		local neighbor = MapState.ActiveObstacles[id]
		if neighbor ~= nil and not neighbor.OnFire then
			thread(Kill, MapState.ActiveObstacles[id])
		end
	end
	wait(RandomFloat(1.5, 3.0))
end

function SlingshotRepulse( collidee, collider )
	if collider.ObjectId ~= CurrentRun.Hero.ObjectId then
		--return
	end
	--local mapCenterPointId = RoomData[CurrentRun.CurrentRoom.Name].SlingshotRepulseTowardId
	--local distanceToCenter = GetDistance({ Id = collidee.ObjectId, DestinationId = mapCenterPointId }) - 100
	--local heroDistanceToCenter = GetDistance({ DestinationId = CurrentRun.Hero.ObjectId, Id = collidee.ObjectId })
	--local distanceBeyond = heroDistanceToCenter - distanceToCenter
	--if distanceBeyond > 0 then
		--DebugPrint({ Text = "distanceBeyond = "..distanceBeyond })
		--local angle = GetAngleBetween({ Id = collidee.ObjectId, DestinationId = mapCenterPointId })
		local angle = GetAngle({ Id = collidee.ObjectId })
		local speed = 540 * 1.4
		local maxSpeed = speed * 1.4
		ApplyForce({ Id = collider.ObjectId, Angle = angle, Speed = speed, MaxSpeed = maxSpeed, LoseFootingTime = 0.2, SelfApplied = true, })
		--DebugPrint({ Text = "force = "..speed })
		thread( GhostWallCollidePresentation, collidee, collider )
	--end
end

function CheckUnitInvulnerableHit(blocker, args)
	if blocker.IsDead or not args.IsInvulnerable then
		return
	end

	if blocker.InvulnerableHitImpactVelocity ~= nil then
		ApplyForce({ Id = blocker.ObjectId, Speed = blocker.InvulnerableHitImpactVelocity, Angle = args.ImpactAngle })
	end

	if blocker.InvulnerableHitSound ~= nil then
		PlaySound({ Id = blocker.ObjectId, Name = blocker.InvulnerableHitSound })
	end
end

function AddEnemyHitShield( unit )
	if not unit or unit.IsDead or not ActiveEnemies[unit.ObjectId] then
		return
	end
	
	local startHitShields = unit.HitShields or 0
	unit.HitShields = unit.HitShields or 0
	unit.HitShields = unit.HitShields + 1

	local maxHitShields = unit.MaxHitShields or 10
	if unit.HitShields >= maxHitShields then
		unit.HitShields = maxHitShields
	end

	if startHitShields < unit.HitShields then
		CreateAnimation({ Name = "EnemyHitShieldAddedFx", DestinationId = unit.ObjectId })
	end

	CreateHealthBar( unit )
	UpdateHealthBar(unit, 0, { Force = true })
end

function SpawnObstacleOnProjectileDeath(projectileData, triggerArgs)
	local newObstacle = DeepCopyTable(ObstacleData[projectileData.SpawnObstaclesOnDeath])
	newObstacle.ObjectId = SpawnObstacle({ Name = projectileData.SpawnObstaclesOnDeath, LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Group = "Standing" })
	SetupObstacle(newObstacle)
end

function ProjectileSpawnUnitOnDeath( projectileData, triggerArgs )
	if SessionMapState.HandlingDeath or ( triggerArgs and triggerArgs.BlockSpawns ) then
		return
	end

	local newSpawnData = EnemyData[projectileData.SpawnName]
	if newSpawnData == nil then
		DebugAssert({ Condition = false, Text = "Projectile trying to spawn non-existant enemy." })
		return
	end

	-- if new spawn would send you over Active Cap, skip it
	local newSpawnActiveCapWeight = newSpawnData.ActiveCapWeight or 1

	local encounter = CurrentRun.CurrentRoom.Encounter
	if encounter ~= nil and encounter.ActiveEnemyCap ~= nil and GetActiveEnemyCount(encounter) + newSpawnActiveCapWeight > encounter.ActiveEnemyCap then
		return
	end

	local spawnPointId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Group = "Scripting" })
	if IsLocationBlocked({ Id = spawnPointId }) then
		Destroy({ Id = spawnPointId })
		return
	end
	local newUnit = DeepCopyTable(newSpawnData)
	if triggerArgs.AttackerTable and ( triggerArgs.AttackerTable.Charmed or triggerArgs.AttackerTable.AlwaysTraitor ) then 
		newUnit.BlocksLootInteraction = false
		newUnit.AlwaysTraitor = true
		newUnit.Charmed = true
		newUnit.RequiredKill = false
	end
	newUnit.ObjectId = SpawnUnit({ Name = projectileData.SpawnName, DestinationId = spawnPointId, Group = "Standing" })

	if projectileData.SpawnBounceOffVictim and triggerArgs.TriggeredByTable ~= nil then
		ApplyUpwardForce({ Id = newUnit.ObjectId, Speed = projectileData.SpawnBounceOffVictimUpwardVelocity or 2200, SelfApplied = true })
		ApplyForce({ Id = newUnit.ObjectId, Speed = projectileData.SpawnBounceOffVictimVelocity or 650, Angle = triggerArgs.Angle + 180, SelfApplied = true })
	end

	if projectileData.SpawnsSkipActivatePresentation then
		newUnit.UseActivatePresentation = false
	end
	
	SetupUnit( newUnit )

	Destroy({ Id = spawnPointId })
end

function UnitDeathCheckRoomExitsReady( )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		thread(UnlockRoomExits, CurrentRun, CurrentRun.CurrentRoom )
	end
end

function DisableAllyUnits()
	if CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId then
		local assistUnit = ActiveEnemies[CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId]
		if assistUnit ~= nil then
			killTaggedThreads( assistUnit.AIThreadName )
			killWaitUntilThreads( assistUnit.AINotifyName )
			local aiData = GetWeaponAIData(assistUnit)
			local idleAnimation = aiData.IdleAnimation or GetThingDataValue({ Id = assistUnit.ObjectId, Property = "Graphic" })
			if idleAnimation ~= nil then
				SetAnimation({ Name = idleAnimation, DestinationId = assistUnit.ObjectId })
			end
		end
	end
	for _, enemy in pairs( MapState.SpellSummons ) do
		if not enemy.IsDead then
			killTaggedThreads( enemy.AIThreadName )
			killWaitUntilThreads( enemy.AINotifyName )
			local aiData = GetWeaponAIData(enemy)
			local idleAnimation = aiData.IdleAnimation or GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" })
			if idleAnimation ~= nil then
				SetAnimation({ Name = idleAnimation, DestinationId = enemy.ObjectId })
			end
		end
	end
	if SessionMapState.ManaUrnIds ~= nil then
		for id in pairs(SessionMapState.ManaUrnIds) do
			if ActiveEnemies[id] then
				thread( Kill, ActiveEnemies[id], { SkipOnDeathFunction = true })
			end
		end
	end
end

function AIHealthThresholdReached( victim )
	local threshold = victim.AIEndHealthThreshold or victim.AIEndGroupHealthThreshold or 0
	if threshold > 0 or (victim.Phases ~= nil and victim.CurrentPhase < victim.Phases) then
		if not victim.SkipTransitionInvulnerability then
			SetUnitInvulnerable( victim )
		end
		victim.ReachedAIStageEnd = true
	end
	SetThreadWait(victim.AIThreadName, 0.01)
	notifyExistingWaiters(victim.AINotifyName)
	killTaggedThreads(victim.SpawnerThreadName)
	Halt({ Id = victim.ObjectId })
	if victim.ExpireEffectOnThreshold then
		ClearEffect({ Id = victim.ObjectId, Name = victim.ExpireEffectOnThreshold })
	end
	if victim.ExpireProjectileIdsOnHitStun ~= nil then
		ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnHitStun })
	end
	if not IsEmpty( victim.StopAnimationsOnHitStun ) then
		StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = victim.ObjectId, PreventChain = true })
		if victim.FxTargetIdsUsed ~= nil then
			for id, v in pairs( victim.FxTargetIdsUsed ) do
				StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = id, PreventChain = true })
			end
		end
	end
end
function EnemyDodge( victim, triggerArgs )
	local timeSlow = 0.001

	victim.ForcedWeaponInterrupt = true

	if victim.SpeedMultiplier then
		victim.SpeedMultiplier = victim.SpeedMultiplier * timeSlow
	else
		victim.SpeedMultiplier = timeSlow
	end
	if victim.AIThreadName then
		SetElapsedTimeMultiplier( victim.SpeedMultiplier, victim.AIThreadName)
	end

	EnemyDodgePresentation(victim, triggerArgs)

	wait(victim.DodgeDuration)
	EnemyDodgeEnd( victim, triggerArgs )
end

function EnemyDodgeEnd( victim, triggerArgs )
	local timeSlow = 0.001
		
	if victim.SpeedMultiplier then
		victim.SpeedMultiplier = victim.SpeedMultiplier / timeSlow
	else
		victim.SpeedMultiplier = 1
	end
	if victim.AIThreadName then
		SetElapsedTimeMultiplier( victim.SpeedMultiplier / timeSlow, victim.AIThreadName)
	end
end

function CheckBurningHitReaction( victim, victimId, triggerArgs )

	if victim == nil or victim.IsDead then
		return
	end
	
	if victim.BurningHitReactionWeapon ~= nil and victim.WeaponName ~= victim.BurningHitReactionWeapon then
		victim.ForcedNextWeapon = victim.BurningHitReactionWeapon
	end
end

function CheckOnArmedHitEffect( victim, victimId, triggerArgs )
	if triggerArgs.Armed then
		ApplyEffect( MergeTables( { DestinationId = victim.ObjectId, Id = triggerArgs.AttackerId }, triggerArgs.AttackerWeaponData.OnArmedHitEffect ) )
	end
end

function DelayedApplyForce(args)
	wait(args.DelayDuration)
	ApplyForce(args)
end

function BlockDumbFireWeapons(unit, triggerArgs)
	unit.BlockDumbFireBlacklist = unit.BlockDumbFireBlacklist or {}

	if unit.BlockDumbFireBlacklist[triggerArgs.BlockedProjectileName] and ( not unit.BlockDumbFireBlacklist[triggerArgs.BlockedProjectileName].RequiredTraitName or HeroHasTrait(unit.BlockDumbFireBlacklist[triggerArgs.BlockedProjectileName].RequiredTraitName)) then
		return
	end
	
	if not CheckCooldown( "ProjectileBlockDumbFireWeapons"..unit.ObjectId, unit.BlockDumbFireWeaponsCooldown or 0.5 ) then
		return
	end

	for k, weaponName in pairs( unit.ProjectileBlockDumbFireWeapons ) do
		thread( DumbFireAttack, unit, weaponName )
	end
end

function HandleStoredProjectileDeath(projectileData, triggerArgs)
	local victim = triggerArgs.TriggeredByTable
	local attacker = triggerArgs.AttackerTable
	if not attacker then
		return
	end
	local storedAmmo = {}
	storedAmmo.Id = _worldTime
	storedAmmo.AttackerId = attacker.ObjectId
	storedAmmo.LocationX = triggerArgs.LocationX
	storedAmmo.LocationY = triggerArgs.LocationY
	local offset = CalcOffset( math.rad(triggerArgs.Angle), projectileData.AmmoDropDistance or 50 )
	storedAmmo.LocationX = storedAmmo.LocationX + offset.X
	storedAmmo.LocationY = storedAmmo.LocationY + offset.Y
	storedAmmo.Angle = triggerArgs.Angle

	if victim ~= nil and victim.ObjectId == CurrentRun.Hero.ObjectId then -- Hit Hero

		if victim.IsDead then
			return
		end

		if victim.StoredAmmo == nil then
			victim.StoredAmmo = {}
		end
		if IsEmpty(victim.StoredAmmo) then
			AddIncomingDamageModifier(victim, { Name = "StoredAmmoVulnerability", NonPlayerMultiplier = projectileData.StoredAmmoVulnerabilityMultiplier or 1.25, })
			CastEmbeddedPresentationStart()
		end
		table.insert( victim.StoredAmmo, storedAmmo )

		local offsetX = 575
		local offsetY = -75
		ScreenAnchors.StoredAmmo =  ScreenAnchors.StoredAmmo or {}
		offsetX = offsetX - ( #ScreenAnchors.StoredAmmo * 22 )
		local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
		SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = { Data = storedAmmo, Id = screenId } })

		table.insert( ScreenAnchors.StoredAmmo, screenId )
		SetAnimation({ Name = "AmmoEmbeddedInEnemyIcon", DestinationId = screenId })

		thread( DropStoredAmmoHero, projectileData, storedAmmo.Id )
		return
	else -- Miss
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = storedAmmo.LocationX, LocationY = storedAmmo.LocationY })
		CreateProjectileFromUnit({ Name = projectileData.AmmoDropProjectile, Id = attacker.ObjectId, DestinationId = dropLocation, FireFromTarget = true })
		Destroy({Id = dropLocation })
	end
end

function DropStoredAmmoHero( projectileData, id )
	local hero = CurrentRun.Hero
	local ammoDelay = projectileData.AmmoDropDelay or 12

	wait( ammoDelay, "DropStoredAmmoHero" )

	if IsEmpty(hero.StoredAmmo) then
		return
	end
	local ammoData = hero.StoredAmmo[1]
	if id ~= nil then
		ammoData = nil
		for i, ammo in pairs(hero.StoredAmmo) do
			if ammo.Id == id then
				ammoData = ammo
			end
		end
	end
	if not ammoData then
		return
	end

	--CreateAnimation({ Name = "ExitWoundsFx", DestinationId = CurrentRun.Hero.ObjectId })
	ammoData.ForceMin = ammoData.ForceMin or 75
	ammoData.ForceMax = ammoData.ForceMax or 200
	ammoData.UpwardForceMin = ammoData.UpwardForceMin or 500
	ammoData.UpwardForceMax = ammoData.UpwardForceMax or 700
	ammoData.Angle = nil
	ammoData.LocationX = nil
	ammoData.LocationY = nil
	if projectileData.AmmoDropProjectile then
		CreateProjectileFromUnit({ Name = projectileData.AmmoDropProjectile, Id = ammoData.AttackerId, DestinationId = hero.ObjectId, FireFromTarget = true })
	end
	local ammoAnchors = ScreenAnchors.StoredAmmo
	if ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil then
		Destroy({ Id = ammoAnchors[#ammoAnchors] })
		ammoAnchors[#ammoAnchors] = nil
	end
	if #ammoAnchors == 0 then
		RemoveIncomingDamageModifier(hero, "StoredAmmoVulnerability")
		CastEmbeddedPresentationEnd()
	end

	RemoveValueAndCollapse( hero.StoredAmmo, ammoData )
end

function AmmoPackPickupTrigger(ammoPack, args)
	local zagId = GetClosestUnitOfType({ Id = ammoPack.ObjectId, DestinationName = "Zagreus" })
	local zag = ActiveEnemies[zagId]

	local notifyName = ammoPack.ObjectId.."PickupTrigger"
	NotifyWithinDistance({ Id = zagId, DestinationId = ammoPack.ObjectId, Distance = args.WithinDistance, Timeout = args.Timeout or 10.0, Notify = notifyName })
	waitUntil(notifyName)

	if zag ~= nil then
		AmmoPackPickup(ammoPack, zag, args)
	end
end