function UpdateWeaponMana( delta, args )
	args = args or {}
	delta = delta or 0
	if delta == 0 then
		args.ForceCheck = true
	end
	if MapState.HostilePolymorph then
		return
	end
	
	local weaponManaToCheck = {}
	local weaponReservationManaToCheck = {}
	local weaponNames = CurrentRun.Hero.AllLinkedWeaponsCache or {}
	for i, weaponName in ipairs( weaponNames ) do
		local weaponData = CurrentRun.Hero.WeaponDataOverride[weaponName] or WeaponData[weaponName]
		if weaponData == nil then
			DebugPrint({ Text = "unable to find " .. weaponName })
			return
		end
		local manaLimit = GetManaCost( weaponData, true )
		if weaponData.CostPerSecond and CurrentRun.Hero.ManaDrain[weaponData.Name] then
			manaLimit = nil
		end
		if weaponData.DrainManaEffect and CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name] then
			manaLimit = nil
		end
		if weaponData.SkipManaDisableCheck then
			manaLimit = nil
		end
		if manaLimit then
			weaponManaToCheck[weaponName] = manaLimit
		end
	end
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			local weaponName = traitData.PreEquipWeapons[1]
			local weaponData = CurrentRun.Hero.WeaponDataOverride[weaponName] or WeaponData[weaponName]
			if weaponData ~= nil then
				local manaLimit =  GetManaCost( weaponData, true )
				if weaponData.CostPerSecond and CurrentRun.Hero.ManaDrain[weaponData.Name] then
					manaLimit = nil
				end
				if weaponData.DrainManaEffect and CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name] then
					manaLimit = nil
				end
				if manaLimit then
					weaponManaToCheck[weaponName] = manaLimit
				end
				local manaReservationCost = GetManaReservationCost( weaponData ) 
				if manaReservationCost and manaReservationCost > 0 then
					weaponReservationManaToCheck[weaponName] = manaReservationCost
				end
			end
		end
	end

	for weaponName, manaLimit in pairs( weaponManaToCheck ) do
		if MapState.EquippedWeapons[weaponName] then
			if SessionState.UnlimitedMana then
				SetWeaponManaAllowedFire( weaponName )
			elseif CurrentRun.Hero.Mana >= manaLimit and ( CurrentRun.Hero.Mana - delta < manaLimit or args.ForceCheck ) then
				SetWeaponManaAllowedFire( weaponName )
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasManaFunctionName, weaponData )
				end
				SetManaIndicatorAllowed( weaponName )
			elseif CurrentRun.Hero.Mana < manaLimit and ( CurrentRun.Hero.Mana - delta >= manaLimit or args.ForceCheck ) then
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				SetManaIndicatorDisallowed( weaponName, false, manaLimit, args )
				if not LastMomentManaRestoreEligible( manaLimit ) then
					SetWeaponManaDisallowedFire( weaponName )				
					if weaponData.OnHasNoManaFunctionName then
						thread( CallFunctionName, weaponData.OnHasNoManaFunctionName, weaponData )
					end
				else
					SetWeaponManaAllowedFire( weaponName )
				end
			end
		end
	end
	for weaponName, manaLimit in pairs( weaponReservationManaToCheck ) do
		if MapState.EquippedWeapons[weaponName] then
			if SessionState.UnlimitedMana then
				SetWeaponManaAllowedFire( weaponName )
			elseif manaLimit <= GetHeroMaxAvailableMana() then
				SetWeaponManaAllowedFire( weaponName )
				SetManaIndicatorAllowed( weaponName )
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasManaFunctionName, weaponData )
				end
			elseif manaLimit > GetHeroMaxAvailableMana() then
				SetWeaponManaDisallowedFire( weaponName )
				SetManaIndicatorDisallowed( weaponName, nil, nil, args )
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasNoManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasNoManaFunctionName, weaponData )
				end
			end
		end
	end
end

function SetWeaponManaAllowedFire( weaponName )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if weaponData and weaponData.ManaChanges and not IsEmpty(weaponData.ManaChanges.Enabled) then
		for name, value in pairs(weaponData.ManaChanges.Enabled) do
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = name, Value = value })
		end
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
	else
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
	end
end

function SetWeaponManaDisallowedFire( weaponName )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if weaponData and weaponData.ManaChanges and not IsEmpty(weaponData.ManaChanges.Disabled) then
		for name, value in pairs(weaponData.ManaChanges.Disabled) do
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = name, Value = value })
		end
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
	else
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = false })
	end
end

function GetManaCost( weaponData, useRequiredMana, args )
	args = args or {}
	local weaponName = weaponData.Name
	local manaCost = 0
	local requiredMana = 0
	local isExWeapon = false
	if args.ManaCostOverride and not args.TraitSource then
		isExWeapon = true
	end
	if weaponData.ManaCost ~= nil and not WeaponSetLookups.HeroSpellWeapons[weaponName] then
		isExWeapon = true
	end

	if useRequiredMana then
		requiredMana = weaponData.RequiredMana or 0
	end

	manaCost = args.ManaCostOverride or weaponData.ManaCost or requiredMana
	local manaMultiplier = 1
	local manaModifiers = CurrentRun.Hero.HeroTraitValuesCache.ManaCostModifiers
	if manaModifiers ~= nil then
		for i, data in ipairs( manaModifiers ) do
			local validWeapon = data.WeaponNamesLookup == nil or data.WeaponNamesLookup[weaponName]
			local validEx = data.ExWeapons == nil or isExWeapon
			local validSessionMap = data.SessionMapValues == nil or weaponName ~= data.SessionMapValues.WeaponName or not SessionMapState[data.SessionMapValues.FalseValue]
			if data.InvalidWeapon and weaponName == data.InvalidWeapon.WeaponName then
				validWeapon = false
			end
			if validWeapon and validEx and validSessionMap then
				if data.ManaCostAdd then
					manaCost = manaCost + data.ManaCostAdd
				end
				if data.ManaCostAddPerCast then
					manaCost = manaCost + data.ManaCostAddPerCast * MapState.ExCastCount
				end
				if data.ManaCostMultiplier then
					manaMultiplier = manaMultiplier * data.ManaCostMultiplier	
				end
			end
		end
	end
	manaCost = manaCost * manaMultiplier

	if useRequiredMana and requiredMana > manaCost then
		return round(requiredMana)
	end
	
	return round(manaCost)
end

function GetManaReservationCost( weaponData )
	local manaCost = weaponData.ManaReservationCost or 0
	local manaMultiplier = 1
	local manaModifiers = CurrentRun.Hero.HeroTraitValuesCache.ManaCostModifiers
	if manaModifiers ~= nil then
		for i, data in ipairs( manaModifiers ) do
			local validWeapon = data.WeaponNamesLookup == nil or data.WeaponNamesLookup[weaponData.Name]
			local validEx = data.ExWeapons == nil or isExWeapon
			if validWeapon and validEx then
				if data.ManaCostAdd then
					manaCost = manaCost + data.ManaCostAdd
				end
				if data.ManaCostMultiplier then
					manaMultiplier = manaMultiplier * data.ManaCostMultiplier
				end
			end
		end
	end
	manaCost = manaCost * manaMultiplier
	return manaCost
end
function ManaDelta( delta, args )
	args = args or {}
	if delta == 0 then
		return
	end
	if CurrentRun.Hero.Mana >= GetHeroMaxAvailableMana() and delta > 0 then
		return
	end

	if CurrentRun.Hero.Mana + delta < 0 then
		if HeraManaRestoreEligible( delta ) then
			local traitData = GetHeroTrait("HeraManaBoon")
			CallFunctionName( "CheckHeraManaRestore", traitData.LastMomentManaRechargeArgs, delta)
			delta = 0
		elseif ClearCastRestoreEligible( delta ) then
			local traitData = GetHeroTrait("PoseidonManaBoon")
			if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionName then
				CallFunctionName( traitData.OnWeaponFiredFunctions.FunctionName, nil, traitData.OnWeaponFiredFunctions.FunctionArgs, { Force = true })
			end
			thread( CheckOnManaSpendPowers, delta, args )
			return
		end
	end

	if CurrentRun.Hero.Mana <= 0 and delta < 0 then
		return
	end

	if CurrentRun.Hero.Mana < GetHeroMaxAvailableMana() and delta > 0 and not args.Silent then
		ManaRegenPresentation(delta)
	end
	local startMana = CurrentRun.Hero.Mana
	CurrentRun.Hero.Mana = math.ceil( CurrentRun.Hero.Mana + delta )
	if CurrentRun.Hero.Mana > GetHeroMaxAvailableMana() then
		CurrentRun.Hero.Mana = GetHeroMaxAvailableMana()
	end
	if CurrentRun.Hero.Mana < 0 then
		CurrentRun.Hero.Mana = 0
	elseif CurrentRun.Hero.Mana >= 0 and delta < 0 then
		if not args.IgnoreSpend or args.ManaDrain then
			thread( CheckOnManaSpendPowers, delta, args )
		end
		killTaggedThreads("ManaRegenInterval")
		thread( ManaRegen )
	elseif delta > 0 then
		local gainedMana = CurrentRun.Hero.Mana - startMana
		if gainedMana > 0 and SessionMapState.TrackManaRegen then
			IncrementTableValue( SessionMapState, "CumulativeManaRegen", gainedMana )
		end
	end
	if HeroHasTrait( "ChaosManaFocusCurse" ) and delta < 0 and not args.ReserveMana and not args.IgnoreSpend then
		ReserveMana( math.abs(delta), "ManaFocusCurse" )
		thread( ChaosManaDrainPresentation )
	end
	UpdateWeaponMana( delta )
	UpdateManaMeterUI()
end

function RefillMana()
	local missingMana = GetHeroMaxAvailableMana() - CurrentRun.Hero.Mana
	ManaDelta(missingMana)
end

function SetManaRegenUnique( args, traitData )
	if traitData and traitData.SetupFunction and traitData.SetupFunction.Args then
		traitData.SetupFunction.Args.Name = traitData.Id
	end
end

function ManaRegenSetup( hero, args )
	args = args or {}
	args.Name = args.Name or "Backcompat"
	CurrentRun.Hero.ManaRegenSources[args.Name] = { Value = args.ManaRegenPerSecond or 0 }
	thread( ManaRegen )
end

function CheckOnManaSpendPowers( delta, args )
	local appliedFunctionNames = {}
	for _, actionData in pairs( GetHeroTraitValues( "OnManaSpendAction")) do
		if actionData.EffectName ~= nil or actionData.EffectNames ~= nil then
			local effectNames = ShallowCopyTable( actionData.EffectNames ) or {}
			local effectArgs = ShallowCopyTable( actionData.Args ) or {}
			if actionData.EffectName then
				table.insert( effectNames, actionData.EffectName )
				table.insert( effectArgs, actionData.Args )
			end

			for i, effectName in pairs( effectNames ) do
				local dataProperties = MergeTables(	EffectData[effectName].EffectData, effectArgs[i])
				ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
			end
		end
		if actionData.FunctionName and not appliedFunctionNames[actionData.FunctionName] and ( not args.ManaDrain or actionData.ManaDrainTriggers ) then
			CallFunctionName( actionData.FunctionName, actionData.FunctionArgs, delta, args)
			appliedFunctionNames[actionData.FunctionName] = true
		end
	end
	if not args.ManaDrain then
		ChargeSpell( delta, args )
	end
end

function ManaRegen()
	local startupTime = HeroData.ManaData.ManaRegenCooldown or 0.3
	if SetThreadWait( "ManaRegenStartup", startupTime ) then
		return
	end
	
	waitUnmodified(startupTime, "ManaRegenStartup")
	
	if HasThread("ManaRegenInterval")then
		return
	end
	local manaOverflow = 0	
	while CurrentRun.Hero.Mana < CurrentRun.Hero.MaxMana do
		local showMana = false
		local manaRegenPerSecond = 0
		for key, data in pairs( CurrentRun.Hero.ManaRegenSources ) do
			manaRegenPerSecond = manaRegenPerSecond + data.Value
			if data.ShowManaRegen then
				showMana = true
			end
		end
		local chargeBlocksRegen = false
		for weaponName in pairs( MapState.ChargedManaWeapons ) do
			local data = GetWeaponData( CurrentRun.Hero, weaponName )
			if not data.AllowManaRegenUntilChargeIndicator then
				chargeBlocksRegen = true
			elseif not IsEmpty(MapState.ManaChargeIndicatorIds) then
				chargeBlocksRegen = true
			end
		end
		if chargeBlocksRegen then
			manaRegenPerSecond = 0
		end
		local encounter = CurrentRun.CurrentRoom.Encounter
		if encounter.DelayedStart and not encounter.StartTime and not encounter.NeverDelayManaRegen and not encounter.SkipEncounterStart then
			manaRegenPerSecond = 0
		end
		if manaRegenPerSecond > 0 and IsEmpty(CurrentRun.Hero.ManaDrain) then
			if (1/manaRegenPerSecond) < HeroData.ManaData.MinManaTickRate then
				waitUnmodified( HeroData.ManaData.MinManaTickRate, "ManaRegenInterval")
				local manaRegen, fraction = math.modf( manaRegenPerSecond * HeroData.ManaData.MinManaTickRate )
				manaOverflow = manaOverflow + fraction
				if manaOverflow >= 1 then
					manaOverflow = manaOverflow - 1
					manaRegen = manaRegen + 1
				end
				ManaDelta(manaRegen, { Silent = not showMana })
			else
				waitUnmodified( 1 / manaRegenPerSecond, "ManaRegenInterval" )
				ManaDelta(1, { Silent = not showMana })
			end
		else
			waitUnmodified( HeroData.ManaData.MinManaTickRate, "ManaRegenInterval")
		end
	end
	if CurrentRun.Hero.ManaRegenSources.IdleManaRegen then
		StopIdleManaRegenerationPresentation()
	end
end

function ReserveMana( amount, source )
	local manaModifiers = CurrentRun.Hero.HeroTraitValuesCache.ManaCostModifiers
	local manaMultiplier = 1
	for i, data in ipairs( manaModifiers ) do
		if data.WeaponNamesLookup == nil or ( data.WeaponNamesLookup and data.WeaponNamesLookup[source] ) then
			if data.ManaReservationCostMultiplier then
				manaMultiplier = manaMultiplier * data.ManaReservationCostMultiplier
			end
		end
	end
	amount = amount * manaMultiplier
	DebugAssert({ Condition = ( source ~= nil ), Text = "No source provided to reserve mana!", Owner = "Alice" })
	IncrementTableValue(CurrentRun.Hero.ReserveManaSources, source, amount )
	if GetHeroMaxAvailableMana() < CurrentRun.Hero.Mana then
		ManaDelta( GetHeroMaxAvailableMana() - CurrentRun.Hero.Mana , { Silent = true, IgnoreSpend = true, ReserveMana = true })
	else
		UpdateWeaponMana()
		UpdateManaMeterUI()
	end
end

function UnreserveMana( source )
	CurrentRun.Hero.ReserveManaSources[source] = nil
	UpdateManaMeterUI()
end

function GetHeroMaxAvailableMana()
	local mana = CurrentRun.Hero.MaxMana
	if CurrentRun.Hero.ReserveManaSources ~= nil then
		for source, amount in pairs( CurrentRun.Hero.ReserveManaSources ) do
			mana = mana - amount
		end
	end
	if mana < 0 then
		mana = 0
	end	
	return math.ceil( mana )
end

function CastCircleManaRegen()
	if SetThreadWait( "CastCircleRegen", 0.25 ) then
		return
	end
	wait(0.25, "CastCircleRegen")
	if CurrentRun.Hero.ActiveEffects ~= nil and not CurrentRun.Hero.ActiveEffects.InsideCastBuff then
		CurrentRun.Hero.ManaRegenSources.CastCircleRegen = nil	
	end
end

function MovingManaRegenSetup( hero, args )
	thread( MovingManaRegen, args )
	thread( ManaRegen )
end

function MovingManaRegen( args )
	wait(0.3)
	local initialWait = 3600
	if IsMoving({ Id = CurrentRun.Hero.ObjectId }) then
		initialWait = 0.1
	end
	while true do
		wait( initialWait, "MovingManaRegen" )
		CurrentRun.Hero.ManaRegenSources.MovingManaRegen = { Value = args.ManaRegenPerSecond, ShowManaRegen = true }
		initialWait = 0.1
	end
end

function IdleManaRegenSetup( hero, args )
	thread( IdleManaRegen )
	thread( ManaRegen )
end

function IdleManaRegen( args )
	local idleManaTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.SetupFunction and traitData.SetupFunction.Name == "IdleManaRegenSetup" then
			idleManaTrait = traitData
		end
	end
	if not idleManaTrait or HasThread("IdleManaRegen") then
		return
	end

	local traitArgs = idleManaTrait.SetupFunction.Args
	wait( traitArgs.MovePenaltyDuration, "IdleManaRegen" )
	if not CurrentRun.Hero.ManaRegenSources.IdleManaRegen then
		CurrentRun.Hero.ManaRegenSources.IdleManaRegen = { Value = CurrentRun.Hero.MaxMana * traitArgs.PercentManaRegenPerSecond, ShowManaRegen = true }
		if traitArgs.ManaRegenStartSound then
			PlaySound({ Name = traitArgs.ManaRegenStartSound, Id = CurrentRun.Hero.ObjectId })
		end	
		if traitArgs.ManaRegenStartFx then
			CreateAnimation({ Name = traitArgs.ManaRegenStartFx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		end
	end
end

OnPlayerMoveStarted{
	function()
		if CurrentRun.Hero.ManaRegenSources.IdleManaRegen then
			StopIdleManaRegenerationPresentation()
		end
		CurrentRun.Hero.ManaRegenSources.IdleManaRegen = nil
		killTaggedThreads("IdleManaRegen")

		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.SetupFunction and traitData.SetupFunction.Name == "MovingManaRegenSetup" then
				SetThreadWait( "MovingManaRegen", traitData.SetupFunction.Args.MovePenaltyDuration )
			end
		end
	end
}
OnPlayerMoveStopped{
	function ()
		CurrentRun.Hero.ManaRegenSources.MovingManaRegen = nil
		SetThreadWait( "MovingManaRegen", 3600 )

		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.SetupFunction and traitData.SetupFunction.Name == "IdleManaRegenSetup" then
				thread( IdleManaRegen )
			end
		end
	end
}

function CheckManaOnHit( victim, functionArgs, triggerArgs )
	if functionArgs.IsNotEx and IsExWeapon( triggerArgs.SourceWeapon, {Combat = true}, triggerArgs ) then
		return
	end	
	local validWeapons = ConcatTableValues( ShallowCopyTable(functionArgs.ValidWeapons), AddLinkedWeapons( functionArgs.ValidWeapons))
	local passesHitCheck = functionArgs.FirstHitOnly == nil or (functionArgs.FirstHitOnly and not ProjectileHasUnitHit( triggerArgs.ProjectileId, "ManaOnHit" ))
	
	if triggerArgs.SourceProjectile ~= nil and functionArgs.MultihitProjectileWhitelistLookup and functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile] and functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile] then
		local conditions = functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile]
		passesHitCheck = true
		if conditions.Cooldown and not CheckCooldown( "PoseidonSplash", conditions.Cooldown ) then
			passesHitCheck = false
		end
	end
	if Contains( validWeapons, triggerArgs.SourceWeapon ) and passesHitCheck then
		ProjectileRecordUnitHit( triggerArgs.ProjectileId, "ManaOnHit")
		ManaDelta(functionArgs.ManaGain)
	end
end

function CalculateManaGain( triggerArgs, weaponData )
	local damageAmount = triggerArgs.DamageAmount
	if triggerArgs.PureDamage or damageAmount <= 0 then
		return 0
	end

	local meterAmount = GetTotalHeroTraitValue( "OnDamagedManaConversionFlat" )
	ManaDelta( meterAmount )
end

function IsOutOfMana()
	return CurrentRun.Hero.Mana <= 0
end

function DrainManaPerSecond( args )
	CurrentRun.Hero.ManaDrain = CurrentRun.Hero.ManaDrain or {}
	if CurrentRun.Hero.ManaDrain[args.Name] then
		return
	end
	CurrentRun.Hero.ManaDrain[args.Name] = true
	
	local audioId = nil
	if args.SoundCue then
		audioId = PlaySound({ Name = args.SoundCue })
	end
	local totalManaDrained = 0
	killTaggedThreads("ManaRegenInterval")
	while CurrentRun.Hero.ManaDrain[args.Name] do
		ManaDelta(-1, { IgnoreSpend = true })
		totalManaDrained = totalManaDrained - 1
		if IsOutOfMana() then
			if args.OutOfManaFunctionName and _G[args.OutOfManaFunctionName] then
				_G[args.OutOfManaFunctionName]()
			end
			CurrentRun.Hero.ManaDrain[args.Name] = nil
			if IsEmpty(CurrentRun.Hero.ManaDrain) then
				thread( ManaRegen )
			end
			if audioId then
				StopSound({ Id = audioId, Duration = args.StopSoundOnFinishFade or 0.2 })
			end
			CheckOnManaSpendPowers( totalManaDrained )
			return
		else
			if args.Cooldown then
				if CheckCooldown( args.FunctionName, args.Cooldown, true) then
					thread( CallFunctionName, args.FunctionName, args.FunctionArgs )
				end
			end
			waitUnmodified(1 / args.CostPerSecond, RoomThreadName)
		end
	end
	
	if audioId then
		StopSound({ Id = audioId, Duration = args.StopSoundOnFinishFade or 0.2 })
	end
	if IsEmpty(CurrentRun.Hero.ManaDrain) then
		thread( ManaRegen )
	end
	CheckOnManaSpendPowers( totalManaDrained )
end

function UseManaFountain( usee, args )
	local fountain = usee
	if CheckCooldown(fountain.CooldownNamePrefix..fountain.ObjectId, fountain.CooldownDuration) then
		SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.OnCooldownAnimation })
		StopAnimation({ DestinationId = fountain.ObjectId, Name = "ManaFountainSmokeBase" })
		StopAnimation({ DestinationId = fountain.ObjectId, Name = "ManaFountainGlow" })
		UseableOff({ Id = fountain.ObjectId })
		OnManaRestored( args )
		ManaFountainUsedPresentation( usee, args )
		ManaDelta( GetHeroMaxAvailableMana() * fountain.ManaFraction )
		ManaFountainReady( fountain )
	end
end

function ManaFountainReady(fountain)
	wait( fountain.CooldownDuration, RoomThreadName )
	SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.IdleAnimation })
	UseableOn({ Id = fountain.ObjectId })
end