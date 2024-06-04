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

		for i, weaponNames in pairs(GetHeroTraitValues("OnProjectileReflectWeapons")) do
			for s, weaponName in pairs(weaponNames) do
				local targetId = triggerArgs.AttackerId or CurrentRun.Hero.ObjectId
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, AutoEquip = true })
			end
		end

	end
}

OnProjectileBlock{
	function( triggerArgs )
		local weaponName = triggerArgs.WeaponName
		local blocker = triggerArgs.Blocker
		if blocker ~= nil then
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
					thread( BlockAttackPresentation, blocker.ObjectId )
				end

				local blockRumble =
				{
					{ ScreenPreWait = 0, Fraction = 0.1, Duration = 0.2 },
				}
				thread( DoRumble, blockRumble )
			end
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
		PlayerDodgePresentation()
	end
}
OnControlPressed{ "Reload",
	function( triggerArgs )
		ManualReload( CurrentRun.Hero )
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

function ManualReload( attacker )

	if not IsInputAllowed({}) then
		return
	end

	if attacker.ActiveEffects then
		for effectName in pairs(attacker.ActiveEffects) do
			if EffectData[effectName] and EffectData[effectName].BlockReload then
				return
			end
		end
	end

	if CurrentHubRoom == nil and CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.DisableWeaponsExceptDash then
		return
	end

	for weaponName, v in pairs( attacker.Weapons ) do
		local weaponData = GetWeaponData( attacker, weaponName)
		if weaponData ~= nil and weaponData.ActiveReloadTime ~= nil then
			if attacker.Reloading then
				ReloadFailedMidReloadPresentation( attacker, weaponData )
				return
			end

			thread( MarkObjectiveComplete, "GunWeaponManualReload" )
			ReloadGun( attacker, weaponData )

			if HeroHasTrait("GunManualReloadTrait") then
				thread( MarkObjectiveComplete, "ManualReload" )
				ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, WeaponName = "ManualReloadEffectApplicator", EffectName = "ManualReloadBonus" })
			end
			return
		end
	end
end

function Heal( victim, triggerArgs )

	if victim == nil or victim.Health == nil or victim.Health == victim.MaxHealth then
		return
	end

	local prevHealth = victim.Health

	if triggerArgs.HealFraction ~= nil then
		triggerArgs.HealAmount = round(victim.MaxHealth * triggerArgs.HealFraction)
	end
	if triggerArgs.HealAmount <= 0 then
		return
	end

	if triggerArgs.HealAmount ~= nil then

		victim.Health = victim.Health + triggerArgs.HealAmount
		if victim.Health > victim.MaxHealth then
			victim.Health = victim.MaxHealth
		end
	end

	triggerArgs.ActualHealAmount = victim.Health - prevHealth

	local sourceName = triggerArgs.AttackerName or "Unknown"

	if victim == CurrentRun.Hero then
		GameState.HealthRecord[sourceName] = (GameState.HealthRecord[sourceName] or 0) + triggerArgs.HealAmount
		GameState.ActualHealthRecord[sourceName] = (GameState.ActualHealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount
		CurrentRun.HealthRecord[sourceName] = (CurrentRun.HealthRecord[sourceName] or 0) + triggerArgs.HealAmount
		CurrentRun.ActualHealthRecord[sourceName] = (CurrentRun.ActualHealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount

		if not triggerArgs.Silent then
			OnPlayerHealed( triggerArgs )
			thread( UpdateHealthUI, triggerArgs )
		end

		for i, traitData in pairs( CurrentRun.Hero.Traits ) do
			local thresholdData = traitData.LowHealthThresholdText
			if thresholdData ~= nil and thresholdData.Threshold ~= nil and CurrentRun.Hero.Health > thresholdData.Threshold and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount) <= thresholdData.Threshold then
				TraitUIDeactivateTrait( traitData )
			end
			if thresholdData ~= nil and thresholdData.ThresholdFraction ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth > thresholdData.ThresholdFraction and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount)/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction then
				TraitUIDeactivateTrait( traitData )
			end

			thresholdData = traitData.HighHealthThresholdText
			if thresholdData ~= nil and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount)/CurrentRun.Hero.MaxHealth < thresholdData.PercentThreshold then
				TraitUIActivateTrait( traitData )
			end

		end
	else
		UpdateHealthBar( victim, -1 * triggerArgs.ActualHealAmount, triggerArgs )
		if triggerArgs.ActualHealAmount > 0 and not triggerArgs.Silent then
			DisplayEnemyHealingText( victim, triggerArgs )
		end
	end

end

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
	for i, data in pairs(unit.OutgoingDamageModifiers) do
		if data.Name and data.Name == name then
			return data
		end
	end
	return nil
end
function RemoveOutgoingDamageModifier( unit, name )
	if unit == nil or IsEmpty(unit.OutgoingDamageModifiers ) then
		return
	end
	for i, data in pairs( unit.OutgoingDamageModifiers ) do
		if data.Name == name then
			unit.OutgoingDamageModifiers[i] = nil
			break
		end
	end
	unit.OutgoingDamageModifiers = CollapseTable( unit.OutgoingDamageModifiers )
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
	for i, data in pairs( unit.OutgoingCritModifiers ) do
		if data.Name == name then
			unit.OutgoingCritModifiers[i] = nil
			break
		end
	end
	unit.OutgoingCritModifiers = CollapseTable( unit.OutgoingCritModifiers )
end

function RemoveIncomingDamageModifier( unit, name )
	for i, data in pairs( unit.IncomingDamageModifiers ) do
		if data.Name == name then
			unit.IncomingDamageModifiers[i] = nil
			break
		end
	end
	unit.IncomingDamageModifiers = CollapseTable( unit.IncomingDamageModifiers )
end

function HasIncomingDamageModifier( unit, name )
	if unit == nil or unit.IncomingDamageModifiers == nil then
		return false
	end
	for i, data in pairs(unit.IncomingDamageModifiers) do
		if data.Name and data.Name == name then
			return true
		end
	end
	return false
end

function CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
	local damageAddition = 0
	
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in pairs(attacker.OutgoingDamageModifiers) do
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			
			if validWeapon and validProjectile then
				if modifierData.ExBaseDamageAddition ~= nil and IsExWeapon( triggerArgs.SourceWeapon , { Combat = true }, triggerArgs) then
					damageAddition = damageAddition + modifierData.ExBaseDamageAddition
				end
				if modifierData.NonExBaseDamageAddition ~= nil and not IsExWeapon( triggerArgs.SourceWeapon , { Combat = true }, triggerArgs) then
					damageAddition = damageAddition + modifierData.NonExBaseDamageAddition
				end
				if modifierData.ValidBaseDamageAddition ~= nil then
					damageAddition = damageAddition + modifierData.ValidBaseDamageAddition
				end
				if modifierData.ValidMapKeyBaseDamageAddition ~= nil then
					damageAddition = damageAddition + SessionMapState[modifierData.ValidMapKeyBaseDamageAddition]
				end
				if modifierData.MissingAmmoBaseDamageAddition ~= nil and triggerArgs.ProjectileVolley and SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] then
					damageAddition = damageAddition + modifierData.MissingAmmoBaseDamageAddition * ( GetMaxAmmo( triggerArgs.SourceWeapon) - SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].AmmoCount )
				end
			end
		end
	end
	if triggerArgs.SourceWeapon and WeaponData[triggerArgs.SourceWeapon] and WeaponData[triggerArgs.SourceWeapon].BaseDamageBonusMultiplier then
		damageAddition = round( damageAddition * WeaponData[triggerArgs.SourceWeapon].BaseDamageBonusMultiplier )
	end
	return damageAddition
end

function CalculateDamageAdditions( attacker, victim, weaponData, triggerArgs )
	local damageAddition = 0
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in pairs(attacker.OutgoingDamageModifiers) do

			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validActiveEffect = modifierData.ValidActiveEffects == nil or (victim.ActiveEffects and ContainsAnyKey( victim.ActiveEffects, modifierData.ValidActiveEffects))

			if validWeapon and validActiveEffect then
				if modifierData.ValidAdditiveDamageAddition then
					damageAddition = damageAddition + modifierData.ValidAdditiveDamageAddition
				end
				if modifierData.TriggerEffectAddition ~= nil and triggerArgs.EffectName ~= nil and triggerArgs.EffectName == modifierData.TriggerEffectName and triggerArgs.EffectIsTriggered then
					damageAddition = damageAddition + modifierData.TriggerEffectAddition
				end
				if modifierData.GoldMultiplier then
					damageAddition = damageAddition + ( GetResourceAmount( "Money" ) * modifierData.GoldMultiplier )
				end
				if modifierData.AdditiveUseTraitValue and attacker == CurrentRun.Hero then
					damageAddition = damageAddition + GetTotalHeroTraitValue( modifierData.AdditiveUseTraitValue )
				end
				if modifierData.HealthBufferRemoval and attacker == CurrentRun.Hero  and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 and victim.MaxHealthBuffer then
					damageAddition = damageAddition + victim.MaxHealthBuffer * modifierData.HealthBufferRemoval
				end
				-- IsEx is slightly expensive so they're all moved over here
				if modifierData.NonExHealthBufferRemoval and weaponData and WeaponData[weaponData.Name] then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )

					if modifierData.NonExHealthBufferRemoval and not isEx and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 and victim.MaxHealthBuffer then
						damageAddition = damageAddition + victim.MaxHealthBuffer * modifierData.NonExHealthBufferRemoval
					end
				end
			end
		end
	end
	return damageAddition
end

function CalculateDamageMultipliers( attacker, victim, weaponData, triggerArgs )
	local damageReductionMultipliers = 1
	local damageMultipliers = 1.0
	local lastAddedMultiplierName = ""

	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = " SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
		if triggerArgs.SourceProjectile then
			DebugPrint({Text = " SourceProjectile: " .. tostring( triggerArgs.SourceProjectile)})
		end
	end

	local addDamageMultiplier = function( data, multiplier )
		if multiplier >= 1.0 then
			if data.Multiplicative then
				damageReductionMultipliers = damageReductionMultipliers * multiplier
			else
				damageMultipliers = damageMultipliers + multiplier - 1
			end
			if ConfigOptionCache.LogCombatMultipliers then
				lastAddedMultiplierName = data.Name or "Unknown"
				DebugPrint({Text = " Additive Damage Multiplier (" .. lastAddedMultiplierName .. "):" .. multiplier })
			end
		else
			if data.Additive then
				damageMultipliers = damageMultipliers + multiplier - 1
			else
				damageReductionMultipliers = damageReductionMultipliers * multiplier
			end
			if ConfigOptionCache.LogCombatMultipliers then
				lastAddedMultiplierName = data.Name or "Unknown"
				DebugPrint({Text = " Multiplicative Damage Reduction (" .. lastAddedMultiplierName .. "):" .. multiplier })
			end
		end
	end

	if triggerArgs.ProjectileAdditiveDamageMultiplier then
		damageMultipliers = damageMultipliers + triggerArgs.ProjectileAdditiveDamageMultiplier
	end

	if victim.IncomingDamageModifiers ~= nil then
		for i, modifierData in pairs(victim.IncomingDamageModifiers) do
			if modifierData.GlobalMultiplier ~= nil then
				addDamageMultiplier( modifierData, modifierData.GlobalMultiplier)
			end
			
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			
			if validWeapon and validProjectile and ( ( attacker and attacker.DamageType ~= "Neutral" ) or modifierData.IncludeObstacleDamage or modifierData.TrapDamageTakenMultiplier ) then
				if modifierData.ValidWeaponMultiplier then
					addDamageMultiplier( modifierData, modifierData.ValidWeaponMultiplier)
				end
				if modifierData.ProjectileDeflectedMultiplier and triggerArgs.ProjectileDeflected then
					addDamageMultiplier( modifierData, modifierData.ProjectileDeflectedMultiplier)
				end

				if modifierData.BossDamageMultiplier and attacker and ( attacker.IsBoss or attacker.IsBossDamage ) then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.LowHealthDamageTakenMultiplier ~= nil and (victim.Health / victim.MaxHealth) <= modifierData.LowHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.LowHealthDamageTakenMultiplier)
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
				if  modifierData.SpellCooldownMultiplier and CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
					local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
					local data = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
					local manaSpend = GetManaSpendCost( data )
					if CurrentRun.SpellCharge < manaSpend then
						addDamageMultiplier( modifierData, modifierData.SpellCooldownMultiplier )
					end
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
				end
				if modifierData.PerHammerDamageTakenMultiplier ~= nil then
					local numWeaponUpgrades = CurrentRun.LootTypeHistory.WeaponUpgrade
					if numWeaponUpgrades and numWeaponUpgrades > 0 then
						addDamageMultiplier( modifierData, numWeaponUpgrades * modifierData.PerHammerDamageTakenMultiplier)
					end
				end
				if modifierData.NonTrapDamageTakenMultiplier ~= nil and (( attacker ~= nil and attacker.DamageType ~= "Neutral" ) or (attacker == nil and triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil and EnemyData[triggerArgs.AttackerName].DamageType ~= "Neutral" )) then
					addDamageMultiplier( modifierData, modifierData.NonTrapDamageTakenMultiplier)
				end
				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
					triggerArgs.TriggeredHitVulnerabilityMultiplier = true
				end
				if modifierData.HitArmorMultiplier and triggerArgs.HitArmor then
					addDamageMultiplier( modifierData, modifierData.HitArmorMultiplier )
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
			end
		end
	end

	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingDamageModifiers ) then
		local appliedEffectTable = {}
		for i, modifierData in pairs(attacker.OutgoingDamageModifiers) do
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
			local validEnchantment = true
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
			if validUniqueness and validWeapon and validProjectile and validEffect and validTrait and validEnchantment and validActiveEffect and validActiveEffectGenus then
				if modifierData.Name then
					appliedEffectTable[ modifierData.Name] = true
				end
				if modifierData.VengeanceMultiplier and victim and GetGenusName(victim) == GameState.CauseOfDeath and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, modifierData.VengeanceMultiplier )
					triggerArgs.TriggeredVengeanceMultiplier = true
				end
				if modifierData.UndamagedMultiplier and not CurrentRun.CurrentRoom.Encounter.PlayerTookDamage then
					addDamageMultiplier( modifierData, modifierData.UndamagedMultiplier )
				end
				if modifierData.HighHealthSourceMultiplierData and attacker.Health / attacker.MaxHealth >= modifierData.HighHealthSourceMultiplierData.Threshold then
					addDamageMultiplier( modifierData, modifierData.HighHealthSourceMultiplierData.Multiplier )
				end
				if modifierData.JumpMultiplier and triggerArgs.NumJumps and triggerArgs.SourceProjectile == modifierData.ProjectileName then
					addDamageMultiplier( modifierData, 1 + ( modifierData.JumpMultiplier ) * triggerArgs.NumJumps )
				end
				if modifierData.PerUniqueGodMultiplier and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, 1 + ( modifierData.PerUniqueGodMultiplier - 1 ) * GetHeroUniqueGodCount( attacker ))
				end
				if modifierData.BossDamageMultiplier and victim.IsBoss then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.LifetimeMultiplier and triggerArgs.LifetimeFraction then
					addDamageMultiplier( modifierData, 1 + modifierData.LifetimeMultiplier * triggerArgs.LifetimeFraction )
				end
				if modifierData.EffectThresholdDamageMultiplier and triggerArgs.MeetsEffectDamageMultiplier then
					addDamageMultiplier( modifierData, modifierData.EffectThresholdDamageMultiplier)
				end
				if modifierData.TransformedMultiplier and MapState.TransformArgs then
					addDamageMultiplier( modifierData, modifierData.TransformedMultiplier )
				end
				if modifierData.PerfectChargeMultiplier and triggerArgs.IsPerfectCharge then
					addDamageMultiplier( modifierData, modifierData.PerfectChargeMultiplier)
				end
				if modifierData.GameStateMultiplier and IsGameStateEligible( CurrentRun, modifierData, modifierData.GameStateRequirements ) then
					addDamageMultiplier( modifierData, modifierData.GameStateMultiplier)
				end
				if modifierData.MissingLastStandMultiplier and TableLength( CurrentRun.Hero.LastStands ) then
					addDamageMultiplier( modifierData, 1 + (CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands )) * modifierData.MissingLastStandMultiplier  )
				end
				if modifierData.UseTraitValue and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, GetTotalHeroTraitValue( modifierData.UseTraitValue, { IsMultiplier = modifierData.IsMultiplier }))
				end
				
				if modifierData.UseSessionMapStateValue and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, 1 + SessionMapState[modifierData.UseSessionMapStateValue] * modifierData.SessionMapStateMultiplier )
				end

				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
					triggerArgs.TriggeredHitVulnerabilityMultiplier = true
				end
				if modifierData.HitMaxHealthMultiplier and victim.Health == victim.MaxHealth and (victim.MaxHealthBuffer == nil or victim.HealthBuffer == victim.MaxHealthBuffer ) then
					addDamageMultiplier( modifierData, modifierData.HitMaxHealthMultiplier )
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

				if modifierData.RequiredEffectsMultiplier and victim and not IsEmpty(victim.ActiveEffects) then
					local hasAllEffects = true
					for _, effectName in pairs( modifierData.RequiredEffects ) do
						if not victim.ActiveEffects[ effectName ] then
							hasAllEffects = false
						end
					end
					if hasAllEffects then
						addDamageMultiplier( modifierData, modifierData.RequiredEffectsMultiplier)
					end
				end
				if modifierData.DistanceMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.DistanceMultiplier)
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceToAttackerSquared ~= nil and triggerArgs.DistanceToAttackerSquared ~= -1 and (( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceToAttackerSquared or ( modifierData.ProximityThresholdExclusionBoon and HeroHasTrait(modifierData.ProximityThresholdExclusionBoon))) then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
					triggerArgs.TriggeredProximityMultiplier = true
				end
				if modifierData.LowHealthDamageOutputMultiplier ~= nil and attacker.Health ~= nil and (attacker.Health / attacker.MaxHealth) <= modifierData.LowHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.LowHealthDamageOutputMultiplier)
				end
				if modifierData.TargetHighHealthDamageOutputMultiplier ~= nil and (victim.Health / victim.MaxHealth) < modifierData.TargetHighHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.TargetHighHealthDamageOutputMultiplier)
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
				if modifierData.SpeedDamageMultiplier then
					local baseSpeed = GetBaseDataValue({ Type = "Unit", Name = "_PlayerUnit", Property = "Speed" })
					local speedModifier = CurrentRun.CurrentRoom.SpeedModifier or 1
					local currentSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed" }) * speedModifier
					if currentSpeed > baseSpeed then
						addDamageMultiplier( modifierData, 1 + modifierData.SpeedDamageMultiplier * ( currentSpeed/baseSpeed - 1 ))
					end
				end

				if modifierData.ActiveDashWeaponMultiplier and triggerArgs.BlinkWeaponActive then
					addDamageMultiplier( modifierData, modifierData.ActiveDashWeaponMultiplier )
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
				if modifierData.ValidProjectileIdMultiplier and triggerArgs.ProjectileId and SessionState.ValidProjectileIds[triggerArgs.ProjectileId] then
					addDamageMultiplier( modifierData, modifierData.ValidProjectileIdMultiplier)
				end
				if modifierData.InvisibleVolleyMultiplier and MapState.InvisibleVolleys [triggerArgs.SourceWeapon] and MapState.InvisibleVolleys[triggerArgs.SourceWeapon][triggerArgs.ProjectileVolley] then
					addDamageMultiplier( modifierData, modifierData.InvisibleVolleyMultiplier )
				end
				if modifierData.SpellCooldownMultiplier and CurrentRun.Hero.SlottedTraits and CurrentRun.Hero.SlottedTraits.Spell then
					local trait = GetHeroTrait( CurrentRun.Hero.SlottedTraits.Spell)
					local data = GetWeaponData( CurrentRun.Hero, trait.PreEquipWeapons[1] )
					local manaSpend = GetManaSpendCost( data )
					if CurrentRun.SpellCharge < manaSpend then
						addDamageMultiplier( modifierData, modifierData.SpellCooldownMultiplier )
					end
				end
				-- IsEx is slightly expensive so they're all moved over here
				if ( modifierData.NonExHealthBufferDamageMultiplier or modifierData.NonExMultiplier or modifierData.ExCastCountMultiplier
					or modifierData.ExMultiplier or modifierData.FullManaVolleyMultiplier or modifierData.ExRunDamagedThreshold or modifierData.NonExLowManaDamageMultiplier or modifierData.LifetimeNonExMultiplier) and weaponData and WeaponData[weaponData.Name] then
					local baseWeaponData = WeaponData[weaponData.Name]
					local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
					if modifierData.ExMultiplier and isEx then
						addDamageMultiplier( modifierData, modifierData.ExMultiplier )
					elseif modifierData.NonExMultiplier and not isEx then
						addDamageMultiplier( modifierData, modifierData.NonExMultiplier )
					end
					if modifierData.ExCastCountMultiplier and isEx then
						addDamageMultiplier( modifierData, 1 + modifierData.ExCastCountMultiplier * ( MapState.ExCastCount - 1 ) )
					end
					if modifierData.ExRunDamagedThreshold and not CurrentRun.Hero.IsDead and isEx and CurrentRun.TotalDamageTaken >= modifierData.ExRunDamagedThreshold then
						addDamageMultiplier( modifierData, modifierData.ExRunDamagedMultiplier )
					end
					if modifierData.FullManaVolleyMultiplier and isEx and MapState.FullManaVolleys and MapState.FullManaVolleys [triggerArgs.SourceWeapon] and MapState.FullManaVolleys[triggerArgs.SourceWeapon][triggerArgs.ProjectileVolley] then
						addDamageMultiplier( modifierData, modifierData.FullManaVolleyMultiplier )
					end
					if modifierData.NonExLowManaDamageMultiplier  and not isEx and CurrentRun.Hero.Mana/GetHeroMaxAvailableMana() <= modifierData.LowManaThreshold then
						addDamageMultiplier( modifierData, modifierData.NonExLowManaDamageMultiplier)
					end
					if modifierData.NonExHealthBufferDamageMultiplier and not isEx and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 then
						addDamageMultiplier( modifierData, modifierData.NonExHealthBufferDamageMultiplier)
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
			for i, modifierData in pairs(weaponData.OutgoingDamageModifiers) do
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.ObstacleMultiplier and victim ~= CurrentRun.Hero and ActiveEnemies[victim.ObjectId] == nil then
					addDamageMultiplier( modifierData, modifierData.ObstacleMultiplier )
				end
				if modifierData.PlayerMultiplier and ( victim == CurrentRun.Hero or UnitSets.PlayerSummons[victim.Name] ) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier)
				end
				if modifierData.PlayerSummonMultiplier and UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.PlayerSummonMultiplier)
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
			for i, modifierData in pairs(projectileData.OutgoingDamageModifiers) do
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.PlayerMultiplier and ( victim == CurrentRun.Hero or UnitSets.PlayerSummons[victim.Name] ) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier)
				end
				if modifierData.PlayerSummonMultiplier and UnitSets.PlayerSummons[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.PlayerSummonMultiplier)
				end
				if modifierData.ObstacleMultiplier and victim ~= CurrentRun.Hero and ActiveEnemies[victim.ObjectId] == nil then
					addDamageMultiplier( modifierData, modifierData.ObstacleMultiplier )
				end
			end
		end
	end

	if ConfigOptionCache.LogCombatMultipliers and triggerArgs and triggerArgs.AttackerName and triggerArgs.DamageAmount then
		DebugPrint({Text = triggerArgs.AttackerName .. ": Base Damage : " .. triggerArgs.DamageAmount .. " Damage Bonus: " .. damageMultipliers .. ", Damage Reduction: " .. damageReductionMultipliers })
	end
	return damageMultipliers * damageReductionMultipliers
end

function CalculateCritChance( attacker, victim, weaponData, triggerArgs )
	local critChance = 0
	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = "Crit SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
	end
	
	local addCritMultiplier = function( data, multiplier )				
		if ConfigOptionCache.LogCombatMultipliers  then
			DebugPrint({Text = " CritChance Addition: " .. multiplier })
		end
		critChance = critChance + multiplier
	end

	if attacker ~= nil and attacker.OutgoingCritModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingCritModifiers ) then
		local appliedEffectTable = {}
		for i, modifierData in pairs(attacker.OutgoingCritModifiers) do

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
					addCritMultiplier( modifierData, modifierData.Chance )
				end
				if attacker == CurrentRun.Hero then
					if modifierData.DistanceThresholdChance and triggerArgs.DistanceToAttackerSquared ~= nil and triggerArgs.DistanceToAttackerSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceToAttackerSquared then
						addCritMultiplier( modifierData, modifierData.DistanceThresholdChance )
					end
					if modifierData.LowHealthThreshold and CurrentRun.Hero.Health <= modifierData.LowHealthThreshold then
						addCritMultiplier( modifierData, modifierData.LowHealthChance )
					end
					if modifierData.TargetHighHealthPercentThreshold and victim and victim.MaxHealth and (victim.Health/victim.MaxHealth) >= modifierData.TargetHighHealthPercentThreshold and
						( victim.HealthBuffer == nil or victim.MaxHealthBuffer == nil or victim.HealthBuffer == 0 or ( victim.HealthBuffer / victim.MaxHealthBuffer >= modifierData.TargetHighHealthPercentThreshold )) then
						addCritMultiplier( modifierData, modifierData.TargetHighHealthChance )
					end
					if modifierData.ValidVolleyChance and MapState.CritVolleys and MapState.CritVolleys [triggerArgs.SourceWeapon] and MapState.CritVolleys[triggerArgs.SourceWeapon][triggerArgs.ProjectileVolley] then
						addCritMultiplier( modifierData, modifierData.ValidVolleyChance)	
					end
					if modifierData.ValidLeapVolleyChance and MapState.LeapCritVolleys and MapState.LeapCritVolleys [triggerArgs.SourceWeapon] and MapState.LeapCritVolleys[triggerArgs.SourceWeapon][triggerArgs.ProjectileVolley] then
						addCritMultiplier( modifierData, modifierData.ValidLeapVolleyChance)	
					end
					if modifierData.HeroTraitValue then
						addCritMultiplier( modifierData, GetTotalHeroTraitValue(modifierData.HeroTraitValue))	
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
					addCritMultiplier( effectData, effectData.CritVulnerability )
				end
			end
		end
	end
	if ConfigOptionCache.LogCombatMultipliers and attacker then
		DebugPrint({Text = tostring( attacker.Name ) .. ": Crit Chance : " .. critChance})
	end
	return critChance
end

function CalculateLifestealModifiers( attacker, victim, weaponData, triggerArgs )
	local lifesteal = 0
	local limitedLifestealContribution = 0
	if not attacker then
		return
	end
	if attacker.OutgoingLifestealModifiers and victim ~= nil and not victim.BlockLifeSteal then
		for i, modifierData in pairs( attacker.OutgoingLifestealModifiers ) do
			local validWeapon = modifierData.ValidWeapons == nil or ( Contains( modifierData.ValidWeapons, triggerArgs.SourceWeapon ) and triggerArgs.EffectName == nil )
			local validSelfEffect = modifierData.RequiredEffect == nil or ( attacker.ActiveEffects and attacker.ActiveEffects[modifierData.RequiredEffect])
			if validWeapon and validSelfEffect then
				local modifierLifesteal = triggerArgs.DamageAmount * modifierData.ValidMultiplier
				if modifierData.MinLifesteal and modifierLifesteal < modifierData.MinLifesteal then
					modifierLifesteal = modifierData.MinLifesteal
				elseif modifierData.MaxLifesteal and modifierLifesteal > modifierData.MaxLifesteal then
					modifierLifesteal = modifierData.MaxLifesteal
				end
				if modifierData.LimitedUse then
					if modifierLifesteal > modifierData.LimitedUse then
						modifierLifesteal = modifierData.LimitedUse
					end
					limitedLifestealContribution = limitedLifestealContribution + modifierLifesteal
				end

				lifesteal = lifesteal + modifierLifesteal
			end
		end
	end
	local expectedHeal = round(lifesteal * CalculateHealingMultiplier())
	local expectedLimitedHeal = round(limitedLifestealContribution * CalculateHealingMultiplier())
	if attacker.MaxHealth and attacker.Health and expectedLimitedHeal > 0 then
		local missingHealth = attacker.MaxHealth - attacker.Health
		if missingHealth <= (expectedHeal - expectedLimitedHeal) then
			expectedLimitedHeal = 0
		elseif missingHealth > ( expectedHeal - expectedLimitedHeal ) and missingHealth < expectedHeal then
			expectedLimitedHeal = attacker.MaxHealth - (attacker.Health + (expectedHeal - expectedLimitedHeal ))
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
	Heal( attacker, { HealAmount = expectedHeal, SourceName = "CombatLifesteal", Silent = false } )
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
		local baseDamage = triggerArgs.DamageAmount + CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
		local multipliers = CalculateDamageMultipliers( attacker, victim, sourceWeaponData, triggerArgs )
		local additive = CalculateDamageAdditions( attacker, victim, sourceWeaponData, triggerArgs )
		local critChance = CalculateCritChance( attacker, victim, sourceWeaponData, triggerArgs )
		triggerArgs.IsCrit = RandomChance( critChance )
		triggerArgs.DamageAmount = round(baseDamage * multipliers) + additive
		if triggerArgs.IsCrit then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * 3
		end
		
		local damageFloorTraitData = HasHeroTraitValue("ActivatedDamageFloor") 
		if damageFloorTraitData and attacker and attacker == CurrentRun.Hero then
			if IsGameStateEligible( CurrentRun, damageFloorTraitData.ActivationRequirements) then
				if triggerArgs.DamageAmount > 0 and triggerArgs.DamageAmount < damageFloorTraitData.ActivatedDamageFloor then
					triggerArgs.DamageAmount = damageFloorTraitData.ActivatedDamageFloor
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
			if CurrentRun.EasyModeLevel == nil then
				CurrentRun.EasyModeLevel = GameState.EasyModeLevel
			end
		end

		if triggerArgs.DamageAmount > 0 and (victim.MaxHealth or 0) > 0 then
			local source = sourceEffectData or sourceProjectileData or sourceWeaponData
			if source ~= nil then
				local damageForRecord = math.min( triggerArgs.DamageAmount, victim.Health )
				GameState.DamageDealtRecord[source.Name] = (GameState.DamageDealtRecord[source.Name] or 0) + damageForRecord
				CurrentRun.DamageDealtRecord[source.Name] = (CurrentRun.DamageDealtRecord[source.Name] or 0) + damageForRecord
				local encounter = CurrentRun.CurrentRoom.Encounter
				encounter.FirstDamageTime = encounter.FirstDamageTime or {}
				encounter.FirstDamageTime[source.Name] = encounter.FirstDamageTime[source.Name] or (_worldTime - (encounter.StartTime or 0))
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
					if victim.Weapons ~= nil then
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
			thread( GenericDamagePresentation, victim, triggerArgs )
		end
	end

	if victim == CurrentRun.Hero then

		if SessionState.BlockHeroDamage then
			return
		end

		if ConfigOptionCache.DamageTakenMultiplier ~= 1.0 then
			triggerArgs.DamageAmount = triggerArgs.DamageAmount * ConfigOptionCache.DamageTakenMultiplier
		end

		if not CurrentRun.CurrentRoom.Encounter.PlayerTookDamage and not triggerArgs.PureDamage then 
			local rank = GetNumShrineUpgrades( "FirstDamageShrineUpgrade" )
			if rank > 0 then
				--DebugPrint({ Text = "triggerArgs.DamageAmount = "..triggerArgs.DamageAmount })
				triggerArgs.DamageAmount = triggerArgs.DamageAmount * MetaUpgradeData.FirstDamageShrineUpgrade.ChangeValue
				--DebugPrint({ Text = "triggerArgs.DamageAmount = "..triggerArgs.DamageAmount })
				thread( FirstDamageShrineUpgradePresentation, victim, triggerArgs )
				triggerArgs.IsCrit = true
			end
		end
		
		if triggerArgs.DamageAmount > 1 and not triggerArgs.PureDamage then
			local damageShave = GetTotalHeroTraitValue("DamageShave")
			triggerArgs.DamageAmount = triggerArgs.DamageAmount - damageShave
			if triggerArgs.DamageAmount < 1 then
				triggerArgs.DamageAmount = 1
			end
		end
		if HasHeroTraitValue("ManaShieldData") then
			local manaShieldData = GetHeroTraitValues("ManaShieldData")[1]
			local manaCost = math.ceil(math.ceil(triggerArgs.DamageAmount * manaShieldData.DamageBlocked) * manaShieldData.ManaPerDamageBlocked)
			if manaCost > CurrentRun.Hero.Mana then
				manaCost = CurrentRun.Hero.Mana
			end
			triggerArgs.DamageAmount = triggerArgs.DamageAmount - math.ceil( manaCost / manaShieldData.ManaPerDamageBlocked )
			ManaDelta( -manaCost, { IgnoreSpend = true })
		end

		local damageCapTraitData = HasHeroTraitValue("ActivatedDamageCap") 
		if damageCapTraitData then
			if IsGameStateEligible( CurrentRun, damageCapTraitData.ActivationRequirements ) then
				if triggerArgs.DamageAmount > damageCapTraitData.ActivatedDamageCap then
					triggerArgs.DamageAmount = damageCapTraitData.ActivatedDamageCap
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
			ClearEffect({ Id = victim.ObjectId, All = true, ExcludeNames = { "BeamRotation" } })
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

	thread( CheckOnDamagedPowers, victim, attacker, triggerArgs )

	local healthProtected = ProcessHealthBuffer( victim, triggerArgs )
	if not healthProtected then
		if victim.AIEndHealthThreshold ~= nil then
			local healthThreshold = victim.MaxHealth * victim.AIEndHealthThreshold
			local remainingThresholdHealth = (victim.Health - healthThreshold) + 1
			if triggerArgs.DamageAmount > remainingThresholdHealth then
				triggerArgs.DamageAmount = remainingThresholdHealth
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
	thread( UpdateHealthBar, victim, triggerArgs.DamageAmount, triggerArgs )

	if not victim.SkipDamageText and not triggerArgs.Silent then
		local weaponData = GetWeaponData(triggerArgs.AttackerTable, triggerArgs.SourceWeapon)
		if triggerArgs.DamageAmount > 0 or weaponData == nil or not weaponData.SkipDamageTextIfNoDamage then
			thread( DisplayDamageText, victim, triggerArgs )
		end
	end

	if not victim.SkipDamagePresentation then
		if (victim.HitShields ~= nil and victim.HitShields > 0) or (victim.HealthBuffer ~= nil and victim.HealthBuffer > 0) then
			thread( ArmorDamagePresentation, victim, triggerArgs )
		else
			thread( DamagePresentation, victim, triggerArgs )
		end
		thread( SpecialHitPresentation, victim, triggerArgs )
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

	for i, data in pairs( GetHeroTraitValues( "OnDamageEnemyFunction" ) ) do
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

	if CurrentRun.CurrentRoom.ActiveEncounters ~= nil then
		for k, encounter in pairs( CurrentRun.CurrentRoom.ActiveEncounters ) do
			--local encounterData = EncounterData[encounter.Name]
			if encounter.OnDamageEnemyFunctionName ~= nil then
				CallFunctionName( encounter.OnDamageEnemyFunctionName, victim, triggerArgs )
			end
		end
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

function GetWeaponData(unit, weaponName)
	if not unit or not unit.WeaponDataOverride or not unit.WeaponDataOverride[weaponName] then
		return WeaponData[weaponName]
	else
		return unit.WeaponDataOverride[weaponName]
	end
end

function GetProjectileData(unit, projectileName)
	return ProjectileData[projectileName]
end

function ProcessHealthBuffer( enemy, damageEventArgs )

	local sourceWeaponData = WeaponData[damageEventArgs.SourceWeapon]
	if sourceWeaponData ~= nil and sourceWeaponData.IgnoreHealthBuffer then
		return false
	end
	if damageEventArgs.IgnoreHealthBuffer then
		return false
	end

	if enemy.HitShields ~= nil and enemy.HitShields > 0 then
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
	RemoveOutline({ Id = enemy.ObjectId })
	if not enemy.WasImmuneToStunWithoutArmor then
		SetUnitProperty({ Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
	end
	ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, WeaponName = "ArmorBreakAttack", EffectName = "ArmorBreakStun" })
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
				CallFunctionName( functionName, victim )
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
					for k, unit in pairs( ActiveEnemies ) do
						if unit.PlayerInjuredReactionVoiceLines ~= nil then
							thread( PlayVoiceLines, unit.PlayerInjuredReactionVoiceLines, nil, unit )
						end
					end
				end
			end
		end
		
		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.InProgress and not triggerArgs.PureDamage then
			local hasPlayerTakenDamage = CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
			CurrentRun.CurrentRoom.Encounter.PlayerTookDamage = true

			if CurrentRun.ActiveObjectives.PerfectClear ~= nil then
				thread( MarkObjectiveFailed, "PerfectClear" )
				PerfectClearObjectiveFailedPresentation( CurrentRun )
			end

			if not hasPlayerTakenDamage and not CurrentRun.CurrentRoom.BlockClearRewards and not CurrentRun.CurrentRoom.PerfectEncounterCleared and IsCombatEncounterActive( CurrentRun ) then
				for i, traitData in pairs(CurrentRun.Hero.Traits) do
					local perfectClearDamageData = traitData.PerfectClearDamageBonus or (traitData.AddOutgoingDamageModifiers and traitData.AddOutgoingDamageModifiers.UndamagedMultiplier )				
					if perfectClearDamageData then
						PerfectClearTraitFailedPresentation( traitData )
					end
				end
			end

			if CurrentRun.CurrentRoom.Encounter.AddTraitOnFirstPlayerTookDamage ~= nil then
				AddTrait(CurrentRun.Hero, CurrentRun.CurrentRoom.Encounter.AddTraitOnFirstPlayerTookDamage)
			end
		end

		if CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress and not triggerArgs.PureDamage then
			CurrentRun.CurrentRoom.ChallengeEncounter.PlayerTookDamage = true

			if CurrentRun.ActiveObjectives.PerfectClear ~= nil then
				thread( MarkObjectiveFailed, "PerfectClear" )
				PerfectClearObjectiveFailedPresentation( CurrentRun )

				ModifyTextBox({ Id = CurrentRun.CurrentRoom.ChallengeSwitch.ValueTextAnchor , ScaleTarget = 1.0, ScaleDuration = 1.25, ColorTarget = Color.Red, ColorDuration = 1.25 })
			end

			if CurrentRun.CurrentRoom.ChallengeEncounter.AddTraitOnFirstPlayerTookDamage ~= nil then
				AddTrait(CurrentRun.Hero, CurrentRun.CurrentRoom.ChallengeEncounter.AddTraitOnFirstPlayerTookDamage)
			end
		end

		local adjustedDamageAmount = triggerArgs.DamageAmount
		CurrentRun.TotalDamageTaken = CurrentRun.TotalDamageTaken + adjustedDamageAmount 
		local attackerName = triggerArgs.AttackerName
		if attackerName ~= nil then
			local damageForRecord = adjustedDamageAmount - (triggerArgs.OverkillAmount or 0)
			CurrentRun.DamageTakenFromRecord[attackerName] = (CurrentRun.DamageTakenFromRecord[attackerName] or 0) + damageForRecord
			GameState.DamageTakenFromRecord[attackerName] = (GameState.DamageTakenFromRecord[attackerName] or 0) + damageForRecord
		end

		if attacker ~= nil and attacker.OnDealDamageFunctionName ~= nil then
			thread( CallFunctionName, attacker.OnDealDamageFunctionName, victim, attacker, triggerArgs, attacker.OnDealDamageFunctionArgs )
		end
		
		if not triggerArgs.PureDamage then
			if MapState.DaggerCharging then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponDagger5", Method = "cancelCharge"})
			end
			InterruptRegen( CurrentRun.Hero, triggerArgs )
			TriggerCooldown( "BlockPerfectDash" )
		end
	end
	local sourceSimData = sourceWeaponData
	if not sourceSimData and triggerArgs.SourceProjectile then
		sourceSimData = GetProjectileData( attacker, triggerArgs.SourceProjectile)
		if sourceSimData and sourceSimData.SourceAIWeapon then
			sourceSimData = MergeTables(sourceSimData, GetWeaponData(attacker, sourceSimData.SourceAIWeapon))
		end
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
		for i, traitData in pairs(CurrentRun.Hero.Traits) do
			local thresholdData = traitData.LowHealthThresholdText
			if thresholdData ~= nil and thresholdData.Threshold and currentHealth <= thresholdData.Threshold and (currentHealth + triggerArgs.DamageAmount )  > thresholdData.Threshold then
				lowHealthText[traitData.Name] = thresholdData.Text
				TraitUIActivateTrait(traitData)
			end
			if thresholdData ~= nil and thresholdData.ThresholdFraction and CurrentRun.Hero.Health/CurrentRun.Hero.MaxHealth <= thresholdData.ThresholdFraction and (CurrentRun.Hero.Health + triggerArgs.DamageAmount)/CurrentRun.Hero.MaxHealth > thresholdData.ThresholdFraction then
				TraitUIDeactivateTrait( traitData )
			end
		end
	end

	if not IsEmpty( lowHealthText ) and not triggerArgs.Silent then
		thread( LowHealthCombatTextPresentation, victim.ObjectId, lowHealthText )
	end

	local highHealthText = {}
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
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
		thread( UpdateHealthUI, triggerArgs )
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

	if GetNumShrineUpgrades("NoInvulnerabilityShrineUpgrade") >= 1 then
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

function SetUnitInvulnerable( unit, flag )
	flag = flag or "Generic"
	unit.InvulnerableFlags = unit.InvulnerableFlags or {}
	unit.InvulnerableFlags[flag] = true
	SetInvulnerable({ Id = unit.ObjectId })
	if unit.InvulnerableFx ~= nil then
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
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = effectName })
	wait( delay )
	SetPlayerVulnerable( invulnerabilityName )
end

function FirstHealHitSetup( unit, args )
	SessionMapState.FirstHitHeal = ShallowCopyTable( args )

end

function ActivateManaReserveInvulnerability( unit, args )
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockTraitSetup or not args then
		return
	end
	args = args or {}
	ReserveMana( args.ManaReservationCost, "ManaReserveTraitInvulnerability")
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ReserveManaInvulnerability", DataProperties = EffectData.ReserveManaInvulnerability.EffectData })
	SetPlayerInvulnerable( "ManaReserveTraitInvulnerability" )
end

function AddLastStand( args )
	local unit = args.Unit or CurrentRun.Hero
	args.Unit = nil
	local count = args.Count or 1
	if not unit.LastStands then
		unit.LastStands = {}
	end

	for i = 1, count do
		if args.IncreaseMax then
			unit.MaxLastStands = unit.MaxLastStands or 0
			unit.MaxLastStands = unit.MaxLastStands + 1
			if ScreenAnchors.LifePipIds then
				local obstacleId = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 70 + unit.MaxLastStands * 32, Y = ScreenHeight - 95})
				SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = obstacleId })
				table.insert( ScreenAnchors.LifePipIds, obstacleId )
			end
		end

		if unit.MaxLastStands and TableLength( unit.LastStands ) >= unit.MaxLastStands and not args.Silent then
			UpdateLifePips( unit )
			AtLastStandMaxPresentation( unit )
			return
		end

		if args.InsertAtEnd or ( IsMetaUpgradeActive("ExtraChanceReplenishMetaUpgrade") and args.Name ~= "ExtraChanceReplenishMetaUpgrade" ) then
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

	if not args.Silent then
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

	if not HasLastStand( victim ) then
		return false
	end

	if ActiveScreens.TraitTrayScreen ~= nil then
		thread( TraitTrayScreenClose, ActiveScreens.TraitTrayScreen )
	end
	CancelFishing()
	ToggleCombatControl( CombatControlsDefaults, false, "LastStand" )
	

	local lastStandData = nil
	if HasHeroTraitValue( "BlockDeathTimer" ) and not MapState.UsedBlockDeath then
		MapState.UsedBlockDeath = true
		lastStandData = 
		{
			HealAmount = GetTotalHeroTraitValue("BlockDeathHealth"),
			FunctionName = "SetupBlockDeathThread"
		}
	else
		lastStandData = table.remove( victim.LastStands )
	end
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
		CurrentRun.ExpiredKeepsakes[lastStandData.ExpiresKeepsake] = true
		LogTraitUses( lastStandData.ExpiresKeepsake )
	end

	CurrentRun.Hero.LastStandsUsed = (CurrentRun.Hero.LastStandsUsed or 0) + 1

	SetPlayerInvulnerable("LastStand")
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HecatePolymorphStun" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MiasmaSlow" })
	if HasHeroTraitValue("RechargeSpellOnLastStand") then
		ChargeSpell(-1000)
	end
	triggerArgs.HasLastStand = HasLastStand( victim )
	ExpireProjectiles({ ExcludeNames = ConcatTableValues( ShallowCopyTable( WeaponSets.ExpireProjectileExcludeProjectileNames), ShallowCopyTable( WeaponSets.ExpireProjectileLastStandExcludeProjectileNames )) })

	if MapState.FamiliarUnit ~= nil then
		RunEventsGeneric( MapState.FamiliarUnit.LastStandEvents, MapState.FamiliarUnit )
	end

	PlayerLastStandPresentationStart( triggerArgs )

	PlayerLastStandHeal( victim, triggerArgs, lastStandHealth, lastStandFraction )
	thread( UpdateHealthUI, triggerArgs )
	
	local manaRestoreAmount = round(victim.MaxMana * lastStandManaFraction) 
	ManaDelta( manaRestoreAmount )
	thread( PlayerLastStandManaGainText, { Amount = manaRestoreAmount, Delay = 0.5 })

	PlayerLastStandPresentationEnd()
	
	ToggleCombatControl( CombatControlsDefaults, true, "LastStand" )
	if weaponName ~= nil then
		FireWeaponFromUnit({ Weapon = weaponName, Id= victim.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true })
	end
	CallFunctionName( lastStandData.FunctionName, victim, lastStandData.FunctionArgs )
	
	for i, functionData in pairs( GetHeroTraitValues("OnLastStandFunction") ) do
		CallFunctionName( functionData.Name, functionData.FunctionArgs, triggerArgs )
	end

	wait( 1.5, RoomThreadName )


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
	PlayerLastStandHealingPresentation( args )
end

function HasLastStand( unit )
	if HasHeroTraitValue( "BlockDeathTimer" ) and not MapState.UsedBlockDeath then
		return true
	end
	return not IsEmpty( unit.LastStands )
end

function GetNumLastStands( unit )
	return TableLength( unit.LastStands )
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
		notifyExistingWaiters( enemy.AINotifyName )
		SetThreadWait( enemy.AIThreadName, 0.1 )
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

	victim.Reacting = true

	if reaction.CausesOcclusion ~= nil then
		SetThingProperty({ Property = "CausesOcclusion", Value = reaction.CausesOcclusion, DestinationId = victim.ObjectId })
	end

	if reaction.PropertyChanges ~= nil then
		ApplyUnitPropertyChanges( victim, reaction.PropertyChanges, true )
	end

	if reaction.Sound ~= nil then
		PlaySound({ Name = reaction.Sound, Id = victim.ObjectId })
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
	
	if triggerArgs.Velocity and triggerArgs.SourceVelocity ~= triggerArgs.OtherVelocity and not triggerArgs.SelfApplied then
		if reaction.InitiatedCollisionProjectile then
			CurrentRun.ProjectileRecord[reaction.InitiatedCollisionProjectile] = (CurrentRun.ProjectileRecord[reaction.InitiatedCollisionProjectile] or 0) + 1
			GameState.ProjectileRecord[reaction.InitiatedCollisionProjectile] = (GameState.ProjectileRecord[reaction.InitiatedCollisionProjectile] or 0) + 1
			CreateProjectileFromUnit({ Name = reaction.InitiatedCollisionProjectile, Id = victim.ObjectId, DestinationId = victim.ObjectId })
		end
		if reaction.Damage ~= nil and triggerArgs.CollideeTable ~= CurrentRun.Hero and triggerArgs.TriggeredByTable ~= CurrentRun.Hero then
			local damageArgs = { AttackerName = triggerArgs.AttackerName, WeaponName = "BaseCollision", Angle = triggerArgs.SourceAngle + math.pi, DamageAmount = triggerArgs.Velocity * reaction.Damage.PerVelocity, Silent = false, PureDamage = true } 
			Damage( victim, damageArgs )
			--WallHitPresentation( victim, damageArgs )
		end
	end

	if reaction.Weapon ~= nil then
		if reaction.FireFromSelf then
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = victim.ObjectId, DestinationId = victim.ObjectId })
		else
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		end
	end

	if reaction.FireProjectileData ~= nil then
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
		CallFunctionName(reaction.FunctionName, victim, triggerArgs.TriggeredByTable)
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

	if reaction.DestroySelf then
		Destroy({ Id = victim.ObjectId })
	end

end

function DestroyOnDelay( ids, delay, args )
	args = args or {}
	wait( delay, RoomThreadName )
	if args.Fx then
		CreateAnimation({DestinationId = ids[1], Name = args.Fx})
	end
	Destroy({ Ids = ids })
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
	local offsetX = RandomFloat( reaction.SpawnOffsetXMin, reaction.SpawnOffsetXMax )
	if CoinFlip() then
		offsetX = offsetX * -1
	end
	local offsetY = RandomFloat( reaction.SpawnOffsetYMin, reaction.SpawnOffsetYMax )
	if CoinFlip() then
		offsetY = offsetY * -1
	end

	local obstacleName = reaction.SpawnObstacle or GetRandomValue( reaction.SpawnRandomObstacle )
	local obstacle = DeepCopyTable(ObstacleData[obstacleName])
	local obstacleId = SpawnObstacle({ Name = obstacleName, DestinationId = victim.ObjectId, OffsetX = offsetX, OffsetY = offsetY, ForceToValidLocation = reaction.ForceSpawnToValidLocation, SkipIfBlocked = true, Group = "Standing", })
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

	if CoinFlip() then
		FlipHorizontal({ Id = obstacleId })
	end
	if reaction.SpawnOffsetZ ~= nil then
		AdjustZLocation({ Id = obstacleId, Distance = reaction.SpawnOffsetZ })
	end
	if reaction.FallForce ~= nil then
		ApplyUpwardForce({ Id = obstacleId, Speed = -reaction.FallForce })
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

	end
}

function KillEnemy( victim, triggerArgs )
	local killer = triggerArgs.AttackerTable
	local killingWeapon = triggerArgs.SourceWeapon

	victim.IsDead = true

	local currentRoom = CurrentRun.CurrentRoom
	local challengeEncounter = currentRoom.ChallengeEncounter
	MapState.TauntTargetIds[victim.ObjectId] = nil

	if victim.SupportAIUnitId ~= nil then
		thread(Kill, ActiveEnemies[victim.SupportAIUnitId])
	end

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
		for i, functionArgs in pairs(GetHeroTraitValues("OnEnemyDeathFunction")) do
			thread( CallFunctionName, functionArgs.Name, victim, functionArgs.FunctionArgs, triggerArgs )
		end
	end

	StopStatusAnimation( victim )

	if victim.AttackWarningAnimation ~= nil then
		StopAnimation({ Name = victim.AttackWarningAnimation, DestinationId = victim.AttackWarningDestinationId })
		Destroy({ Id = victim.AttackWarningDestinationId })
	end

	if victim.SentryTetherId ~= nil then
		Destroy({ Id = victim.SentryTetherId })
	end

	thread( CheckOnDeathPowers, victim, killer, killingWeapon)
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
		local weaponData = GetWeaponData( attacker, weaponName )
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
			thread( CallFunctionName, weaponData.OutOfManaFunctionName, weaponData, weaponData.OutOfManaFunctionArgs )
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

		
		if attacker.IsDead and weaponData.NotReadyAmmoPackText ~= nil then
			if CheckCountInWindow( "AmmoNotRetrieved", 2.0, 6 ) then
				local ammoIds = GetIdsByType({ Name = weaponData.AmmoPackName })
				for k, ammoId in pairs( ammoIds ) do
					thread( InCombatTextArgs, { TargetId = ammoId, Text = weaponData.NotReadyAmmoPackText, SkipRise = true, PreDelay = 0.35, Duration = 2, OffsetY = -120, Cooldown = 3.0, ShadowScale = 0.66 } )
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
		if weaponData.OnChargeFunctionNames ~= nil or weaponData.OnChargeFunctionName ~= nil then
			local functionsToCall = ShallowCopyTable( weaponData.OnChargeFunctionNames )
			if weaponData.OnChargeFunctionName ~= nil then
				functionsToCall = {weaponData.OnChargeFunctionName} 
			end
			for i, functionName  in pairs( functionsToCall ) do
				thread( CallFunctionName, functionName, triggerArgs, weaponData, weaponData.OnChargeFunctionArgs )
			end
		end
		if triggerArgs.name == "RushWeapon" then
			for i, dashData in pairs(GetHeroTraitValues("DashChargeProperties")) do
				ProcessDashProperties( dashData )
			end
		end
		local validWeapons = ConcatTableValues( ShallowCopyTable(WeaponSets.HeroSecondaryWeapons), AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons ))
		if Contains(validWeapons, triggerArgs.name ) then
			TerminateBlinkTrail()
			RunWeaponMethod({ Id = triggerArgs.triggeredById, Weapon = "WeaponBlink", Method = "cancelCharge" })
		end

		if weaponData.RushOverride then
			for i, rushWeaponName in pairs(WeaponSets.HeroRushWeapons) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
		thread( DoWeaponChargeRumble, weaponData )
		for i, traitData in pairs( GetHeroTraitValues("OnWeaponChargeFunctions")) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName and _G[traitData.FunctionName] then
				thread( _G[traitData.FunctionName], weaponData, traitData.FunctionArgs, triggerArgs )
			end
		end
    end
}

OnWeaponChargeCanceled{
	function( triggerArgs )
		local weaponData = GetWeaponData( triggerArgs.OwnerTable, triggerArgs.name )
		if weaponData == nil then
			return
		end
		if not triggerArgs.PostFire then
			SessionMapState.FrameFlags[triggerArgs.name.."PostFireFail"] = true
		end

		thread( DoCameraMotion, weaponData.ChargeCancelCameraMotion )

		if weaponData.RushOverride then
			for i, rushWeaponName in pairs(WeaponSets.HeroRushWeapons) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end

		if weaponData.OnChargeCancelFunctionName then
			thread( CallFunctionName, weaponData.OnChargeCancelFunctionName, triggerArgs, weaponData, weaponData.OnChargeFunctionArgs )
		end
		
		for i, traitData in pairs( GetHeroTraitValues("OnWeaponChargeCanceledFunctions")) do
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

		Flash({ Id = triggerArgs.OwnerTable.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.2 })
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusBowCriticalTimingFlash", Id = triggerArgs.OwnerTable.ObjectId })

		local weaponData = WeaponData[triggerArgs.name]
		if weaponData == nil then
			return
		end

	end
}

OnWeaponFired{
	function( triggerArgs )

        if triggerArgs.OwnerTable.ObjectId == CurrentRun.Hero.ObjectId then
            CheckPlayerOnFirePowers( triggerArgs )
		end

        -- chaos curse effects
		if triggerArgs.OwnerTable == CurrentRun.Hero and not CurrentRun.Hero.Frozen then
			for i, data in pairs(GetHeroTraitValues("DamageOnFireWeapons")) do
				if Contains( data.WeaponNames, triggerArgs.name ) and ( data.IsEx == nil or ( data.IsEx and IsExWeapon( triggerArgs.name, {Combat = true}, triggerArgs ))) then
					LoadVoiceBanks({ Name = "Chaos" })
					thread( PlayVoiceLines, HeroVoiceLines.SelfDamageVoiceLines, false )
					SacrificeHealth({SacrificeHealthMin = data.Damage, SacrificeHealthMax = data.Damage, MinHealth = 1 })
					if CurrentRun.CurrentRoom.Encounter ~= nil then
						CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage = true
					end
				end
			end
		end
		local weaponData = GetWeaponData(triggerArgs.OwnerTable, triggerArgs.name)
		local projectileData = nil
		if triggerArgs.ProjectileName and ProjectileData[triggerArgs.ProjectileName] then
			projectileData = ProjectileData[triggerArgs.ProjectileName]
		end
		if weaponData == nil then
			return
		end
		if triggerArgs.name ~= "WeaponAxeSpecialSwing" then
			MapState.FullManaAtFireStart[triggerArgs.name] = CurrentRun.Hero.Mana >= GetHeroMaxAvailableMana()
		end
		if weaponData.ShowManaIndicator and MapState.ChargedManaWeapons[triggerArgs.name] then
			MapState.ChargedManaWeapons[triggerArgs.name] = true
		end
		local manaLimit = GetManaCost( weaponData )
        if triggerArgs.OwnerTable.ObjectId == CurrentRun.Hero.ObjectId and manaLimit > 0 then
			ManaDelta(- manaLimit, {Source = weaponData.Name })
		end
		if IsExWeapon(weaponData.Name, {Combat = true}, triggerArgs ) and not SessionMapState.ChargeStageManaSpend[weaponData.Name] and manaLimit > 0 then
			SessionMapState.ChargeStageManaSpend[weaponData.Name] = manaLimit
		end
		if triggerArgs.ProjectileVolley then
			SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] = MapState.WeaponCharge[ weaponData.Name ]

			ProjectileClearUnitHit( triggerArgs.ProjectileVolley, weaponData.Name)
		end
		if not IsEmpty( weaponData.ExpireProjectilesOnFire ) then
			ExpireProjectiles({ Names = weaponData.ExpireProjectilesOnFire, CancelQueuedProjectilesOnId = CurrentRun.Hero.ObjectId  })
		end
		
		if weaponData.CancelWeaponOnFire then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.CancelWeaponOnFire, Method = "cancelCharge" })
		end

		CurrentRun.WeaponsFiredRecord[weaponData.Name] = (CurrentRun.WeaponsFiredRecord[weaponData.Name] or 0) + 1
		GameState.WeaponsFiredRecord[weaponData.Name] = (GameState.WeaponsFiredRecord[weaponData.Name] or 0) + 1

		if weaponData.RushOverride then
			for i, rushWeaponName in pairs( WeaponSets.HeroRushWeapons ) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end
		if not weaponData.RequireProjectilesForPresentation or ( triggerArgs.NumProjectiles and triggerArgs.NumProjectiles > 0 ) then
			thread( DoCameraMotion, weaponData.FireCameraMotion )
			thread( DoWeaponScreenshake, weaponData, "FireScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = triggerArgs.ProjectileName })


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
				elseif MapState.WeaponCharge and MapState.WeaponCharge[triggerArgs.name] and MapState.WeaponCharge[triggerArgs.name] > 0 then
					DoWeaponSounds( weaponData.Sounds.FireStageSounds, triggerArgs.OwnerTable, weaponData )
				elseif weaponData.Sounds.FireSounds ~= nil then
					DoWeaponSounds( weaponData.Sounds.FireSounds, triggerArgs.OwnerTable, weaponData )
				end
			end
			StopWeaponSounds( "Fired", weaponData.Sounds, triggerArgs.OwnerTable )

			thread( DoWeaponFireSimulationSlow, weaponData )
			thread( DoWeaponFireRumble, weaponData, projectileData )
			thread( DoWeaponFireRadialBlur, weaponData )
		end
		if weaponData.OnFireCrowdReaction ~= nil then
			thread( CrowdReactionPresentation, weaponData.OnFireCrowdReaction )
		end

		if MapState.WeaponCharge == nil or MapState.WeaponCharge[triggerArgs.name] == nil or MapState.WeaponCharge[triggerArgs.name] == 0 then
			thread( MarkObjectiveComplete, triggerArgs.name )
		end
		thread( MarkObjectiveComplete, weaponData.CompleteObjectiveOnFire )
		thread( MarkObjectivesComplete, weaponData.CompleteObjectivesOnFire )

		if triggerArgs.IsPerfectCharge then
			thread(MarkObjectiveComplete, "PerfectCharge")
		end

		if GetCurrentAmmo( weaponData.Name) == 0 and weaponData.OutOfAmmoFunctionName ~= nil then
			CallFunctionName( weaponData.OutOfAmmoFunctionName, triggerArgs.OwnerTable, weaponData )
		end

		if weaponData.FiredHeroVoiceLines ~= nil then
			thread( PlayVoiceLines, HeroVoiceLines[weaponData.FiredHeroVoiceLines], true )
		end

		if weaponData.OnFiredFunctionName ~= nil then
			CallFunctionName( weaponData.OnFiredFunctionName, triggerArgs.OwnerTable, weaponData, weaponData.OnFiredFunctionArgs, triggerArgs )
		end
		if weaponData.OnFiredFunctionNames then
			for i, functionName in pairs( weaponData.OnFiredFunctionNames ) do
				CallFunctionName( functionName, triggerArgs.OwnerTable, weaponData, weaponData.OnFiredFunctionArgs, triggerArgs )
			end
		end
		for i, traitData in pairs( GetHeroTraitValues("OnWeaponFiredFunctions")) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName then
				thread( CallFunctionName, traitData.FunctionName, weaponData, traitData.FunctionArgs, triggerArgs )
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
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = triggerArgs.name, Method = "ArmProjectiles" })
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
	for enemyId, enemy in pairs( ActiveEnemies ) do
		CleanupEnemy( enemy )
		if args.Destroy and enemyId ~= args.DestroyIgnoreId then
			Destroy({ Id = enemyId })
		end
	end
	ActiveEnemies = {}
	RequiredKillEnemies = {}
	ActiveGroupAIs = {}
	SurroundEnemiesAttacking = {}
	for obstacleId, obstacle in pairs( MapState.ActiveObstacles ) do
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
	killTaggedThreads( enemy.AIThreadName )
	killWaitUntilThreads( enemy.AINotifyName )
	FinishTargetMarker( enemy )
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
	if MapState.MarkDaggerEnemyId == enemy.ObjectId then
		table.insert( SessionMapState.DestroyRequests, MapState.MarkedDaggerTargetId )
	end
	if enemy.CreatedOwnTarget ~= nil then
		table.insert( SessionMapState.DestroyRequests, enemy.CreatedOwnTarget )
	end
	if enemy.ActiveEffects then
		for effectName in pairs( enemy.ActiveEffects ) do
			local effectData = EffectData[effectName]
			if  effectData ~= nil then
				if effectData.Vfx ~= nil then
					StopAnimation({ Name = effectData.Vfx, DestinationId = enemy.ObjectId })
				end
				if effectData.BackVfx ~= nil then
					StopAnimation({ Name = effectData.BackVfx, DestinationId = enemy.ObjectId })
				end
				if not IsEmpty ( effectData.StopVfxes ) then
					StopAnimation({ Names = effectData.StopVfxes, DestinationId = enemy.ObjectId })
				end
				if not IsEmpty ( effectData.StopVfxesPreventChain ) then
					StopAnimation({ Names = effectData.StopVfxesPreventChain, DestinationId = enemy.ObjectId, PreventChain = true})
				end
			end
		end
	end
	if enemy.ActiveInputBlocks ~= nil then
		for k, inputBlockName in pairs(enemy.ActiveInputBlocks) do
			RemoveInputBlock({ Name = inputBlockName })
		end
	end
	if not IsEmpty( enemy.StopAnimationsOnHitStun ) then -- since hit stun isn't applied on death
		StopAnimation({ Names = enemy.StopAnimationsOnHitStun, DestinationId = enemy.ObjectId })
	end
	if enemy.AttachedAnimationName ~= nil then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = enemy.AttachedAnimationName })
	end
	RemoveEnemyUI( enemy )
	ExpireProjectiles({ Id = enemy.ObjectId, DieWithOwner = true })
	if SurroundEnemiesAttacking[enemy.Name] ~= nil then
		SurroundEnemiesAttacking[enemy.Name][enemy.ObjectId] = nil
	end
	killWaitUntilThreads( enemy.SpawnPointThread )
	if enemy.PickupTarget ~= nil then
		if enemy.PickupTarget.PickupFailedAnimation ~= nil then
			SetAnimation({ Name = enemy.PickupTarget.PickupFailedAnimation, DestinationId = enemy.PickupTarget.ObjectId })
		end
		enemy.PickupTarget = nil
	end
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

		local victimName = victim.Name
		local victimId = victim.ObjectId

		local attacker = triggerArgs.AttackerTable
		local attackerId = triggerArgs.AttackerId
		local attackerName = triggerArgs.AttackerName
		local attackerWeaponName = triggerArgs.SourceWeapon
		triggerArgs.AttackerWeaponData = GetWeaponData(attacker, attackerWeaponName)
		local attackerWeaponData = triggerArgs.AttackerWeaponData
		
		if triggerArgs.DoubleStrikeTriggered then
			thread( DoubleStrikePresentation, victim )
		end

		local sourceProjectileData = nil
		if triggerArgs.SourceProjectile ~= nil then
			sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
		end

		SessionMapState.OnHitsThisFrame = SessionMapState.OnHitsThisFrame + 1

		if victim.FirstOnHitSound ~= nil and victim.FirstOnHitSoundPlayed == nil then
			PlaySound({ Name = victim.FirstOnHitSound, Id = victimId })
			victim.FirstOnHitSoundPlayed = true
		end

		if victim.OnHitShake and not victim.OnHitShakeDisabled then
			victim.OnHitShake.Id = victim.ObjectId
			thread( OnHitShakePresentation, victim.OnHitShake )
		end

		if CheckImpactReaction( attackerWeaponData, sourceProjectileData, victim, triggerArgs ) then
			DoReaction( victim, victim.ImpactReaction, triggerArgs )
		end
		if triggerArgs.Armed and attackerWeaponData and attackerWeaponData.OnArmedHitEffect then
			ApplyEffect(MergeTables({ DestinationId = victim.ObjectId, Id = attackerId}, attackerWeaponData.OnArmedHitEffect))
		end

		thread( CheckOnHitPowers, victim, attacker, triggerArgs )

		if triggerArgs.IsInvulnerable and not victim.SkipInvulnerableOnHitPresentation then
			HitInvulnerablePresentation( victim, attacker, triggerArgs )
		end

		if victim.OnHitVoiceLines ~= nil then
			thread( QueueOnHitVoiceLines, victim, triggerArgs )
		end
			
		if victim == CurrentRun.Hero and not triggerArgs.InvulnerableFromCoverage then
			if not ( victim == attacker and ( not attackerWeaponData or attackerWeaponData.SelfMultiplier == 0 )) then
				if HeroHasTrait("FirstHitHealBoon") and SessionMapState.FirstHitHeal then

					local baseDamage = triggerArgs.DamageAmount + CalculateBaseDamageAdditions( attacker, victim, triggerArgs )
					local multipliers = CalculateDamageMultipliers( attacker, victim, sourceWeaponData, triggerArgs )
					local additive = CalculateDamageAdditions( attacker, victim, sourceWeaponData, triggerArgs )
					local critChance = CalculateCritChance( attacker, victim, sourceWeaponData, triggerArgs )
					triggerArgs.IsCrit = RandomChance( critChance )
					triggerArgs.DamageAmount = round(baseDamage * multipliers) + additive
					if triggerArgs.IsCrit then
						triggerArgs.DamageAmount = triggerArgs.DamageAmount * 3
					end					
					local args = SessionMapState.FirstHitHeal
					Heal( CurrentRun.Hero, {HealAmount = triggerArgs.DamageAmount * args.HealPercent, SourceName = "FirstHitHealBoon" })
					if args.Vfx then
						CreateAnimation({ Name = args.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
					end
					if args.CombatText then
						thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = args.CombatText, PreDelay = 0.35, Duration = 1.25, Cooldown = 2.0 } )	
					end
					SessionMapState.FirstHitHeal = nil
					return
				end

				if HeroHasTrait( "ReserveManaHitShieldBoon" ) and not (MapState.DaggerBlockShieldActive and HeroHasTrait("DaggerBlockAspect")) then
					-- Player hit
					local tempInvulnerabilityTrait = nil
					for k, currentTrait in pairs( CurrentRun.Hero.Traits ) do
						if currentTrait.Name == "ReserveManaHitShieldBoon" and IsOnlyInvulnerableSource("ManaReserveTraitInvulnerability") and CurrentRun.Hero.ActiveEffects.ReserveManaInvulnerability then
							tempInvulnerabilityTrait = currentTrait
						end
					end

					if tempInvulnerabilityTrait ~= nil and IsTraitActive( tempInvulnerabilityTrait ) then
						triggerArgs.IsInvulnerable = true
						thread( VulnerableAfterDelay, 1, "ReserveManaInvulnerability", "ManaReserveTraitInvulnerability" )
					end
				end
			end
		else
			-- Enemy hit
			if victim.CanBeAggroed and victim.IsAggroed == false and attackerId == CurrentRun.Hero.ObjectId then
				thread( AggroUnit, victim, true )
			end
		end

		victim.Hits = (victim.Hits or 0) + 1

		if victim.OnHitFunctionName ~= nil then
			local consolidatedArgs = victim.OnHitFunctionArgs or triggerArgs
			CallFunctionName( victim.OnHitFunctionName, victim, consolidatedArgs, onHitFunctionArgs, triggerArgs )
		end

		if victim == CurrentRun.Hero 
			and triggerArgs.DamageAmount ~= nil 
			and triggerArgs.DamageAmount > 0 
			and not triggerArgs.IsInvulnerable 
			and not triggerArgs.InvulnerableFromCoverage then
			if MapState.DaggerBlockShieldActive and HeroHasTrait("DaggerBlockAspect") then
				local traitData = GetHeroTrait("DaggerBlockAspect")
				local functionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
				thread( DaggerBlockTriggeredPresentation, functionArgs )
				StopAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
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
				SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
				return
			end

			if CurrentRun.Hero.SprintActive and MapState.SprintShields > 0 then
				MapState.SprintShields = MapState.SprintShields - 1
				thread( SprintShieldTriggeredPresentation )
				if MapState.SprintShields <= 0 and MapState.SprintShieldFx then
					StopAnimation({ Name = MapState.SprintShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
				end

				return
			end

			if MapState.BossShieldTriggers > 0 then
				MapState.BossShieldTriggers = MapState.BossShieldTriggers - 1
				thread( BossShieldTriggeredPresentation )
				if MapState.BossShieldTriggers <= 0 and MapState.BossShieldFx then
					StopAnimation({ Name = MapState.BossShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
				end
				return
			end

			local hasValidChargingWeapon = false
			for weaponName in pairs( MapState.ChargedManaWeapons ) do
				if MapState.ExShieldWeapons[weaponName] then
					hasValidChargingWeapon = true
				end
			end

			if MapState.ExShieldTriggers > 0 and hasValidChargingWeapon then
				MapState.ExShieldTriggers = MapState.ExShieldTriggers - 1
				local traitData = nil
				if HeroHasTrait("ExShieldMetaUpgrade") then
					traitData = GetHeroTrait("ExShieldMetaUpgrade")
					traitData.RemainingUses = MapState.ExShieldTriggers
				end
				thread( ExShieldTriggeredPresentation )
				if MapState.ExShieldTriggers <= 0 and MapState.ExShieldFx  then
					if traitData then
						traitData.CustomTrayText = "ChanneledBlock_Expired"
					end
					StopAnimation({ Name = MapState.ExShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
				end

				return
			end

			if HeroHasTrait("MinorHitShieldBoon") then
				local trait = GetHeroTrait("MinorHitShieldBoon")
				trait.RemainingUses = trait.RemainingUses - 1
				thread( HitShieldTriggeredPresentation )
				UpdateTraitNumber(trait)
				if trait.RemainingUses <= 0 then
					if trait.SetupFunction and trait.SetupFunction.Args and trait.SetupFunction.Args.Vfx then
						StopAnimation({ Name = trait.SetupFunction.Args.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
					end
					thread( TraitSacrificedPresentation, trait )
					RemoveTraitData( CurrentRun.Hero, trait )
				end
				return
			end
		end

		if triggerArgs.EffectName == nil then
			thread( DoImpactSound, victim, triggerArgs )
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
		if CurrentRun.Hero and attacker == CurrentRun.Hero then
			for i, data in pairs( GetHeroTraitValues( "OnProjectileCreationFunction" ) ) do
				if data.Name and ( IsEmpty(data.ValidProjectilesLookup) or data.ValidProjectilesLookup[triggerArgs.name]) then
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
		local weaponData = GetWeaponData( attacker, triggerArgs.WeaponName)
		local projectileData = ProjectileData[triggerArgs.name]

		SessionMapState.ExpireOldestProjectiles[triggerArgs.ProjectileId] = nil
		SessionState.ValidProjectileIds[ triggerArgs.ProjectileId ] = nil
	
		if projectileData ~= nil then
			if projectileData.DeathScreenShake then
				ShakeScreen( projectileData.DeathScreenShake )
			end

			if projectileData.CarriesSpawns then
				SessionMapState.ProjectilesCarryingSpawns[triggerArgs.ProjectileId] = nil
				SessionMapState.ProjectileSpawnRecord[triggerArgs.ProjectileId] = nil
				notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
			end
			if projectileData.RecordLocationOnDeath then
				SessionState[projectileData.Name.."DeathArgs"] = { X = triggerArgs.LocationX, Y = triggerArgs.LocationY }
			end
			if projectileData.OnDeathFunctionName ~= nil then
				CallFunctionName( projectileData.OnDeathFunctionName, projectileData, triggerArgs )
			end
			if victim == nil and victimId == nil and projectileData.OnDeathNoVictimFunctionName ~= nil then
				CallFunctionName( projectileData.OnDeathNoVictimFunctionName, projectileData, MergeTables( triggerArgs, projectileData.OnDeathNoVictimFunctionArgs ) )
			end
		end

		if CurrentRun.Hero and attacker == CurrentRun.Hero then
			for i, data in pairs( GetHeroTraitValues( "OnProjectileDeathFunction" ) ) do
				if data.Name and ( IsEmpty(data.ValidProjectilesLookup) or data.ValidProjectilesLookup[triggerArgs.name]) then
					CallFunctionName( data.Name, triggerArgs, data.Args )
				end
			end

			if weaponData and weaponData.OnProjectileDeathFunction then
				CallFunctionName( weaponData.OnProjectileDeathFunction, triggerArgs, weaponData.OnProjectileDeathFunctionArgs )
			end
			
			SessionMapState.FirstHitRecord[triggerArgs.ProjectileId] = nil
		end
	end
}

function CheckImpactReaction( attackerWeaponData, sourceProjectileData, victim, triggerArgs )
	local victimImpactReactionData = victim.ImpactReaction

	if victimImpactReactionData == nil then
		return false
	end

	if victimImpactReactionData.RequiredSourceProjectile ~= nil and not Contains(victimImpactReactionData.RequiredSourceProjectile, triggerArgs.SourceProjectile) then
		return false
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

function DelayedKill( victim, triggerArgs, delay )
	wait( delay, RoomThreadName )
	if ActiveEnemies[victim.ObjectId] ~= nil then
		thread( Kill, victim, triggerArgs )
	end
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
	
	CallFunctionName( victim.PreDeathFunctionName , victim )

	currentRoom.Kills = currentRoom.Kills or {}
	currentRoom.Kills[victimName] = (currentRoom.Kills[victimName] or 0) + 1

	if victim.RoomRequiredObject then
		MapState.RoomRequiredObjects[victim.ObjectId] = nil
	end
	
	ClearEffect({ Id = victim.ObjectId, All = true, BlockAll = true, ResetAllegiance = not victim.AlwaysTraitor })
	if victim ~= CurrentRun.Hero then
		KillEnemy( victim, triggerArgs )
	end

	if currentRoom.ActiveEncounters ~= nil then
		for k, encounter in pairs( currentRoom.ActiveEncounters ) do
			local encounterData = EncounterData[encounter.Name] or encounter
			if encounterData.WipeEnemiesOnKill == victimName then
				DestroyRequiredKills( { BlockLoot = true, SkipIds = { victim.ObjectId } } )
			elseif encounterData.WipeEnemiesOnKillAllTypes ~= nil then
				local killAll = true
				for k, type in pairs(encounterData.CancelSpawnsOnKillAllTypes) do
					for unitId, unit in pairs(RequiredKillEnemies) do
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
	end

	if victim.EndSpawnEncounterOnDeath and victim.SpawnedEncounter ~= nil then
		killTaggedThreads(victim.SpawnedEncounter.SpawnThreadName)
		victim.SpawnedEncounter.ForceEnd = true
		RemoveValue(currentRoom.ActiveEncounters, victim.SpawnedEncounter)
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
		if victim.IsBoss and ( not victim.UseGroupHealthBar or victim.GroupHealthBarOwner ) then
			DisableAllyUnits()
		end
		if victim.OnDeathFunctionName ~= nil then
			CallFunctionName( victim.OnDeathFunctionName, victim, victim.OnDeathFunctionArgs )
		end
		if victim.OnDeathThreadedFunctionName ~= nil then
			thread( CallFunctionName, victim.OnDeathThreadedFunctionName, victim, victim.OnDeathFunctionArgs )
		end
		if victim.IsBoss and ( not victim.UseGroupHealthBar or victim.GroupHealthBarOwner ) and not victim.BlockPostBossMetaUpgrades then
			local delay = 3.5
			if GetTotalHeroTraitValue("PostBossCards") > 0 then
				AddRandomMetaUpgrades( GetTotalHeroTraitValue("PostBossCards"), { Delay = delay })
				delay = delay + 3.5
			end
			
			if HeroHasTrait("BossMetaUpgradeKeepsake") then
				local upgradeTrait = GetHeroTrait("BossMetaUpgradeKeepsake")
				if upgradeTrait.RemainingUses > 0 then
					AddRandomMetaUpgrades(1, { RarityLevel = GetTotalHeroTraitValue("PostBossCardRarity"), Delay = delay })
					UseHeroTraitsWithValue( "PostBossCardRarity" )
					upgradeTrait.CustomTrayText = "BossMetaUpgradeKeepsake_Expired"
				end
			end
		end
	end

	if victim.OnDeathFireWeapons ~= nil then
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

	if victim.SpawnUnitOnDeath ~= nil then
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
			SpawnUnitGroup(newUnit, nil, { SpawnOnIds = { victim.ObjectId } } )
		else
			newUnit.ObjectId = SpawnUnit({ Name = victim.SpawnUnitOnDeath, Group = "Standing", DestinationId = victim.ObjectId })
			thread(SetupUnit, newUnit, CurrentRun)
		end
		if victim.SpawnUnitOnDeathMatchAngle then
			SetGoalAngle({ Id = newUnit.ObjectId, Angle = GetAngle({ Id = victim.ObjectId }), CompleteAngle = true })
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
		if IsEmpty( RequiredKillEnemies ) and IsEmpty( SessionMapState.ProjectilesCarryingSpawns ) and not eggRespawning then
			notifyExistingWaiters( "AllRequiredKillEnemiesDead" )
			DebugPrint({ Text = "AllRequiredKillEnemiesDead" })
		end

		if victim.Encounter ~= nil and IsEmpty( victim.Encounter.ActiveSpawns ) and not eggRespawning then
			notifyExistingWaiters( "AllEncounterEnemiesDead"..victim.Encounter.Name )
		end


		if currentRoom.ActiveEncounters ~= nil then
			for k, encounter in pairs( currentRoom.ActiveEncounters ) do
				local encounterData = EncounterData[encounter.Name] or encounter
				if encounterData.RequiredKillFunctionName ~= nil then
					CallFunctionName( encounterData.RequiredKillFunctionName, encounter, victim, killer )
				end
			end
		end
	end
	
	KillPresentation( victim, killer, triggerArgs )
	if victim == CurrentRun.Hero then
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
		local spawnId = SpawnObstacle({ Name = spawnData.Name, Group = spawnData.GroupName or "Standing", DestinationId = victim.ObjectId, OffsetX = offsetX, OffsetY = offsetY })
		local spawn = DeepCopyTable( ObstacleData[spawnData.Name] ) or {}
		spawn.ObjectId = spawnId
		SetupObstacle( spawn )
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
		if spawnData.SyncOwnerAngle then
			SetAngle({ Id = spawnId, Angle = GetAngle({ Id = victim.ObjectId }) })
		end
		if spawnData.RestoreOnLoad then
			local encounter = CurrentRun.CurrentRoom.Encounter
			encounter.ObstaclesToRestore = encounter.ObstaclesToRestore or {}
			local location = GetLocation({ Id = spawnId })
			location.X = location.X + (offsetX or 0)
			location.Y = location.Y + (offsetY or 0)
			table.insert( encounter.ObstaclesToRestore, { Name = spawnData.Name, Location = location } )
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
	DoAttack(victim, aiData)
end

function SkellyDeath( victim, args )

	thread( CrowdReactionPresentationEventSource, victim, args )
	
	if victim.RespawnAtIdOnDeath then
		thread( RespawnVictim, victim.Name, victim.RespawnAtIdOnDeath, victim.RespawnDelay )
	end

	if victim.OnDeathVoiceLines then
		thread( PlayVoiceLines, victim.OnDeathVoiceLines, nil, victim )
	end

	if victim.UnuseableWhenDead then
		RefreshUseButton( victim.ObjectId, victim )
	end

end

function CheckSkyDeath( victim, args )
	if victim.InSky then
		ObeyGravity({ Id = victim.ObjectId })
		SetAlpha({ Id = victim.ObjectId, Fraction = 1.0 })
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
	for i, dropData in pairs(GetHeroTraitValues("DropOnKill")) do
		local checkValidLifeOnKill = ( dropData.ValidEnemies == nil and victim.DropItemsOnDeath ) or (dropData.ValidEnemies ~= nil and Contains( dropData.ValidEnemies, victim.GenusName ) or Contains( dropData.ValidEnemies, victim.Name ))
		if checkValidLifeOnKill then
			IncrementTableValue(dropChance, dropData.Name, dropData.Chance)
			if dropData.RoomCap and TableLength(GetIdsByType({ Name = dropData.Name })) > (dropData.RoomCap - 1) then
				invalidDrops[dropData.Name] = true
			end
			if dropData.DropCap then
				IncrementTableValue(dropCap, dropData.Name, dropData.DropCap)
			else
				-- arbitrarily high value if there's no cap
				IncrementTableValue(dropCap, dropData.Name, 1000)
			end
		end
	end

	for key, dropChances in pairs(dropChance) do
		while dropChances > 0 do
			local validDrop = true
			if invalidDrops[key] then
				validDrop = false
			end
			if SessionMapState.LifeOnKillRecord[key] ~= nil and SessionMapState.LifeOnKillRecord[key] >= dropCap[key] then
				validDrop = false
			end
			if RandomChance(dropChances) and validDrop then
				local id = SpawnObstacle({ Name = key, DestinationId = victim.ObjectId, Group = "Standing" })
				CreateConsumableItem( id, key, 0)
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

function DropHealth( healthObjectName, targetId, radius, angle, dropTowardHero )
	if targetId == nil then
		targetId = CurrentRun.Hero.ObjectId
	end

	local offset = CalcOffset( angle or RandomFloat( 0, 360 ), radius or 5 )
	local healDropId = SpawnObstacle({ Name = healthObjectName, DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y, Group = "Standing" })
	local consumableData = ConsumableData[healthObjectName]
	local consumable = GetRampedConsumableData( consumableData )
	consumable.ObjectId = healDropId
	consumable.Cost = 0
	AddToGroup({ Id = healDropId, Name = "ConsumableItems" })
	AttachLua({ Id = healDropId, Table = consumable })
	ApplyUpwardForce({ Id = healDropId, Speed = RandomFloat( 500, 700 ) })
	if not dropTowardHero then
		ApplyForce({ Id = healDropId, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	else
		local forceAngle = GetAngleBetween({ Id = healDropId, DestinationId = CurrentRun.Hero.ObjectId })
		ApplyForce({ Id = healDropId, Speed = 100, Angle = forceAngle, SelfApplied = true })
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = healDropId })
end

OnEffectApply{
	function( triggerArgs )

		local victim = triggerArgs.Victim
		if not victim or ( victim.IsDead and victim ~= CurrentRun.Hero ) then
			return
		end
		local effectData = EffectData[triggerArgs.EffectName]
		
		victim.ActiveEffects = victim.ActiveEffects or {}
		if not effectData or not effectData.CustomStackHandling then
			victim.ActiveEffects[triggerArgs.EffectName] = triggerArgs.Stacks
		end
		EffectApplyPresentation( victim, effectData, triggerArgs )
		
		thread( CheckStunAnimation, triggerArgs ) 
		for i, traitData in pairs( GetHeroTraitValues("AddOnEffectWeapons")) do
			if triggerArgs.EffectName == traitData.EffectName and (traitData.AffectChance == nil or RandomChance(traitData.AffectChance)) then

				local enemyIsValid = true
				if victim.TriggeredByTable.Name ~= nil then
					if traitData.IgnoreEnemies ~= nil and ( Contains(traitData.IgnoreEnemies, victim.Name) or Contains(traitData.IgnoreEnemies, triggerArgs.TriggeredByTable.GenusName)) then
						enemyIsValid = false
					end
				end

				if enemyIsValid then
					FireWeaponFromUnit({ Weapon = traitData.Weapon, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true })
				end
			end
		end
		if effectData ~= nil and effectData.OnApplyFunctionName ~= nil then
			CallFunctionName( effectData.OnApplyFunctionName, triggerArgs )
		else
			local applyFunctionName = triggerArgs.EffectName.."Apply"
			if _G[applyFunctionName] ~= nil then
				CallFunctionName( applyFunctionName, triggerArgs )
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
					for effectName in pairs(CurrentRun.Hero.ActiveEffects) do
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
		for i, data in pairs(GetHeroTraitValues("OnEffectApplyFunction")) do
			CallFunctionName( data.FunctionName, victim, data.FunctionArgs, triggerArgs )
		end
		if triggerArgs.IsVulnerabilityEffect and triggerArgs.BlockedEffect ~= triggerArgs.EffectName then
			victim.VulnerabilityEffects = victim.VulnerabilityEffects or {}
			local categoryName = triggerArgs.EffectName
			if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DisplaySuffix then
				categoryName = EffectData[triggerArgs.EffectName].DisplaySuffix
			end
			victim.VulnerabilityEffects[ categoryName ] = true
			if HeroHasTrait("EffectVulnerabilityMetaUpgrade") then
				local modifierData = GetOutgoingDamageModifier( CurrentRun.Hero, "EffectVulnerabilityMetaUpgrade" )
				if TableLength(victim.VulnerabilityEffects) >= modifierData.MinRequiredVulnerabilityEffects then
					local effectName = "VulnerabilityIndicator"
					ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties})
				end
			end
		end
	end
}

OnEffectCleared{
	function( triggerArgs )
		if not triggerArgs.Exists then
			return
		end

		local unit = triggerArgs.Victim
		if unit == nil then
			return
		end

		unit.ActiveEffects = unit.ActiveEffects or {}
		unit.ActiveEffects[triggerArgs.EffectName] = nil

		if triggerArgs.IsVulnerabilityEffect and unit.VulnerabilityEffects then
			local categoryName = triggerArgs.EffectName
			if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].DisplaySuffix then
				categoryName = EffectData[triggerArgs.EffectName].DisplaySuffix
			end
			unit.VulnerabilityEffects[ categoryName ] = nil
			if HeroHasTrait("EffectVulnerabilityMetaUpgrade") then
				local modifierData = GetOutgoingDamageModifier( CurrentRun.Hero, "EffectVulnerabilityMetaUpgrade" )
				if TableLength(unit.VulnerabilityEffects) < modifierData.MinRequiredVulnerabilityEffects then
					ClearEffect({ Id = unit.ObjectId, Name = "VulnerabilityIndicator" })
				end
			end
		end


		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].OnClearFunctionName and _G[EffectData[triggerArgs.EffectName].OnClearFunctionName ] then
			_G[EffectData[triggerArgs.EffectName].OnClearFunctionName ](triggerArgs)
		elseif _G[triggerArgs.EffectName.."Clear"] then
			_G[triggerArgs.EffectName.."Clear"](triggerArgs)
		end
		UpdateEffectStacks( unit, triggerArgs.EffectName )

		if triggerArgs.EffectType == "DAMAGE_OUTPUT" and unit.OutgoingDamageModifiers ~= nil then
			for i, data in pairs( unit.OutgoingDamageModifiers ) do
				if data.Name == triggerArgs.EffectName then
					unit.OutgoingDamageModifiers[i] = nil
					break
				end
			end
		elseif triggerArgs.EffectType == "DAMAGE_TAKEN" and unit.IncomingDamageModifiers ~= nil then
			RemoveIncomingDamageModifier( unit, triggerArgs.EffectName )
		elseif triggerArgs.EffectType == "INVULNERABLE" then
			SetUnitVulnerable( unit , triggerArgs.EffectName )
			if unit == CurrentRun.Hero and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].ShowInvincububble then
				local hasInvincibubble = false
				for effectName in pairs(CurrentRun.Hero.ActiveEffects) do
					if effectName ~= triggerArgs.EffectName and EffectData[effectName] and EffectData[effectName].ShowInvincububble then
						hasInvincibubble = true
					end
				end
				if not hasInvincibubble then
					StopAnimation({ Name = "Invincibubble_Zag_Loop", DestinationId = CurrentRun.Hero.ObjectId})
				end
			end
		end

		if EffectData[triggerArgs.EffectName] ~= nil then
			if EffectData[triggerArgs.EffectName].Vfx ~= nil then
				StopAnimation({ Name = EffectData[triggerArgs.EffectName].Vfx, DestinationId = unit.ObjectId })
			end
			if EffectData[triggerArgs.EffectName].BackVfx ~= nil then
				StopAnimation({ Name = EffectData[triggerArgs.EffectName].BackVfx, DestinationId = unit.ObjectId })
			end
			if not IsEmpty ( EffectData[triggerArgs.EffectName].StopVfxes ) then
				StopAnimation({ Names = EffectData[triggerArgs.EffectName].StopVfxes, DestinationId = unit.ObjectId })
			end
			if not IsEmpty ( EffectData[triggerArgs.EffectName].StopVfxesPreventChain ) then
				StopAnimation({ Names = EffectData[triggerArgs.EffectName].StopVfxesPreventChain, DestinationId = unit.ObjectId, PreventChain = true})
			end
		end
		for i, data in pairs(GetHeroTraitValues("OnEffectClearFunction")) do
			CallFunctionName( data.FunctionName, unit, data.FunctionArgs, triggerArgs )
		end
	end
}

OnEffectStackDecrease{
	function( triggerArgs )
		if triggerArgs.EffectName == "DamageOverTime" then
			UpdatePoisonEffectStacks(triggerArgs)
		end
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
			CheckOnImpactPowers( victim, CurrentRun.Hero, triggerArgs )
			if not triggerArgs.ImmuneToKnockUp and not triggerArgs.ImmuneToForceDataValue then
					SetThingProperty({ DestinationId = victim.ObjectId, Property = "ImmuneToForce", Value = true })
					victim.ResetOnTouchdown = triggerArgs.ImmuneToForceDataValue
					CreateAnimation({ Name = "PoseidonKnockupPuddle", DestinationId = victim.ObjectId })
			end
		end
	end
}

function GetGameplayElapsedTimeMultiplier()
	local minValue = 1
	for name, amount in pairs( SessionState.GameplaySlows ) do
		if amount < minValue then
			minValue = amount
		end
	end
	return minValue
end

function GetPlayerGameplayElapsedTimeMultiplier()
	local minValue = 1
	for name, amount in pairs( SessionState.PlayerGameplaySlows ) do
		if amount < minValue then
			minValue = amount
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
			SessionState.GameplaySlows[name] = args.ElapsedTimeMultiplier
			if args.ApplyToPlayerUnits then
				SessionState.PlayerGameplaySlows[name] = args.ElapsedTimeMultiplier
			end
		end
	end
	local currentMultiplier = GetGameplayElapsedTimeMultiplier()
	local currentPlayerMultiplier = GetPlayerGameplayElapsedTimeMultiplier()
	if currentMultiplier ~= startingMultiplier or currentPlayerMultiplier ~= startingPlayerMultiplier then
		SetElapsedTimeMultiplier( currentMultiplier/ startingMultiplier )

		if startingMultiplier == 1 and currentMultiplier < 1 and not args.SkipPresentation then
			thread( CallFunctionName, args.TimeSlowPresentationFunction or "StartTimeSlowPresentation" )
		elseif startingMultiplier < 1 and currentMultiplier == 1 and not args.SkipPresentation then
			if SessionMapState.TimeSlowSoundId then
				StopSound({ Id = SessionMapState.TimeSlowSoundId, Duration = 0.2 })
			end
			thread( CallFunctionName, args.EndTimeSlowPresentationFunction or "EndTimeSlowPresentation" )
		end
		
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = currentMultiplier, DataValue = false, ValueChangeType = "Absolute", AllProjectiles = true })
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = currentMultiplier/ startingMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam" } })
		for enemyId, enemy in pairs( ActiveEnemies ) do
			if enemy.IgnoreTimeSlowEffects then
				SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = enemy.SpeedMultiplier or 1.0, ValueChangeType = "Absolute", DataValue = false, DestinationId = enemyId })
			end
		end
		if args.ApplyToPlayerUnits then
			SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = currentPlayerMultiplier/ startingPlayerMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "HeroTeam" } })
		end

		for id, name in pairs(MapState.Reticles) do
			SetAnimationSpeedMultiplier({ DestinationId = id, PlaySpeed = currentMultiplier })
		end
	end
end

function FizzleOldSpawn( unit )
	thread( ActivateFuse, unit )
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
	if enemy.PostFuseWeapon ~= nil then
		FireWeaponFromUnit({ Weapon = enemy.PostFuseWeapon, Id = enemy.ObjectId, DestinationId = enemy.ObjectId, AutoEquip = true })
	end
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
		end
	end
	UnequipWeapon({ DestinationId = heroId, Names = toUnequip, UnloadPackages = false })

	if newWeaponEquipped then
		ReapplyWeaponSwitchMetaUpgrades()

		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTraitAddGems" )
		if IsBonusUnusedWeapon( weaponData.Name ) then
			if GameState.WorldUpgrades.UnusedWeaponBonusAddGems then
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTraitAddGems" })
			else
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTrait" })
			end
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

function OnShadeMercActivate()
	for i, data in pairs( GetHeroTraitValues( "OnShadeMercActivate" )) do
		if data.Health then
			Heal( CurrentRun.Hero, {HealAmount = round( data.Health * CalculateHealingMultiplier()), SourceName = "Shade Merc MetaUpgrade "})
		end
		if data.Mana then
			ManaDelta( data.Mana )
		end
	end
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
	SetAnimation({ Name="WheatClusterC_Burnt", DestinationId=grassObject.ObjectId, Group = "Standing" })
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
	
	UnitInvulnerableHitPresentation( blocker, args )

	if blocker.DefenseReady then
		if blocker.WeaponName then
			local weaponData = WeaponData[blocker.WeaponName]
			if weaponData ~= nil and not weaponData.BlockInterrupt then
				blocker.ForcedWeaponInterrupt = blocker.DefenseWeapon

				if blocker.PreAttackLoopingSoundId ~= nil then
					StopSound({ Id = blocker.PreAttackLoopingSoundId, Duration = 0.2 })
					blocker.PreAttackLoopingSoundId = nil
				end
				notifyExistingWaiters( blocker.AINotifyName )
				SetThreadWait( blocker.AIThreadName, 0.1 )
			end
		end
	end

	if blocker.InvulnerableHitImpactVelocity ~= nil then
		ApplyForce({ Id = blocker.ObjectId, Speed = blocker.InvulnerableHitImpactVelocity, Angle = args.ImpactAngle })
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
	if not encounter or not encounter.ActiveEnemyCap or (encounter ~= nil and GetActiveEnemyCount(encounter) + newSpawnActiveCapWeight > encounter.ActiveEnemyCap) then
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
		end
	end
	for _, enemy in pairs( MapState.SpellSummons ) do
		if not enemy.IsDead then
			killTaggedThreads( enemy.AIThreadName )
			killWaitUntilThreads( enemy.AINotifyName )
			local aiData = GetWeaponAIData(enemy)
			if aiData.IdleAnimation ~= nil then
				SetAnimation({ Name = enemy.DefaultAIData.IdleAnimation, DestinationId = enemy.ObjectId })
			end
		end
	end
end

function AIHealthThresholdReached( victim )
	local threshold = victim.AIEndHealthThreshold or victim.AIEndGroupHealthThreshold
	if threshold ~= nil and threshold > 0 and not victim.SkipTransitionInvulnerability then
		SetUnitInvulnerable( victim )
		victim.ReachedAIStageEnd = true
	end
	SetThreadWait(victim.AIThreadName, 0.01)
	notifyExistingWaiters(victim.AINotifyName)
	killTaggedThreads(victim.SpawnerThreadName)
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