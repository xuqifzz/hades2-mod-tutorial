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
	local weaponNames = AddLinkedWeapons( GetAllKeys( CurrentRun.Hero.Weapons ))
	for i, weaponName in pairs( weaponNames ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		if not weaponData then
			DebugPrint({Text = "unable to find " .. weaponName})
			return
		end
		local manaLimit = GetManaCost( weaponData, true )
		if weaponData.CostPerSecond and CurrentRun.Hero.ManaDrain[weaponData.Name] then
			manaLimit = nil
		end
		if weaponData.DrainManaEffect and CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name] then
			manaLimit = nil
		end
		if manaLimit then
			weaponManaToCheck[weaponName] = manaLimit
		end
	end
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			local weaponName = traitData.PreEquipWeapons[1]
			local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
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

	for weaponName, manaLimit in pairs( weaponManaToCheck ) do
		if manaLimit then
			if SessionState.UnlimitedMana then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
			elseif CurrentRun.Hero.Mana >= manaLimit and ( CurrentRun.Hero.Mana - delta < manaLimit or args.ForceCheck ) then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasManaFunctionName, weaponData )
				end
				SetManaIndicatorAllowed( weaponName )
			elseif CurrentRun.Hero.Mana < manaLimit and ( CurrentRun.Hero.Mana - delta >= manaLimit or args.ForceCheck ) then
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				SetManaIndicatorDisallowed( weaponName, false, manaLimit )
				if not HeraManaRestoreEligible( manaLimit ) then
					SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = false })				
					if weaponData.OnHasNoManaFunctionName then
						thread( CallFunctionName, weaponData.OnHasNoManaFunctionName, weaponData )
					end
				end
			end
		end
	end
	for weaponName, manaLimit in pairs( weaponReservationManaToCheck ) do
		if manaLimit then
			if SessionState.UnlimitedMana then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
			elseif manaLimit <= GetHeroMaxAvailableMana() then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = true })
				SetManaIndicatorAllowed( weaponName )
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasManaFunctionName, weaponData )
				end
			elseif manaLimit > GetHeroMaxAvailableMana() then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AllowFire", Value = false })
				SetManaIndicatorDisallowed( weaponName )
				local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
				if weaponData.OnHasNoManaFunctionName then
					thread( CallFunctionName, weaponData.OnHasNoManaFunctionName, weaponData )
				end
			end
		end
	end
end


function GetManaCost( weaponData, useRequiredMana, args )
	args = args or {}
	local weaponName = weaponData.Name
	local manaCost = 0
	local requiredMana = 0
	local isExWeapon = false
	if args.ManaCostOverride then
		isExWeapon = true
	end
	if WeaponData[weaponName] and WeaponData[weaponName].ManaCost and not Contains(WeaponSets.HeroSpellWeapons, weaponName) then
		isExWeapon = true
	end

	if useRequiredMana then
		requiredMana = weaponData.RequiredMana or 0
	end

	manaCost = args.ManaCostOverride or weaponData.ManaCost or requiredMana
	local manaModifiers = GetHeroTraitValues("ManaCostModifiers")
	local manaMultiplier = 1
	for i, data in pairs(manaModifiers) do
		local validWeapon = data.WeaponNamesLookup == nil or data.WeaponNamesLookup[weaponData.Name]
		local validEx = data.ExWeapons == nil or isExWeapon
		if validWeapon and validEx then
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
	manaCost = manaCost * manaMultiplier

	if useRequiredMana and requiredMana > manaCost then
		return round(requiredMana)
	end
	
	return round(manaCost)
end

function GetManaReservationCost( weaponData )
	local manaCost = weaponData.ManaReservationCost or 0
	local manaModifiers = GetHeroTraitValues("ManaCostModifiers")
	local manaMultiplier = 1
	for i, data in pairs(manaModifiers) do
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
	manaCost = manaCost * manaMultiplier
	return manaCost
end
function ManaDelta( delta, args )
	if delta == 0 then
		return
	end
	if CurrentRun.Hero.Mana >= GetHeroMaxAvailableMana() and delta > 0 then
		return
	end
	
	if CurrentRun.Hero.Mana + delta < 0 and HeraManaRestoreEligible( delta ) then
		local traitData = GetHeroTrait("HeraManaBoon")
		CallFunctionName( "CheckHeraManaRestore", traitData.LastMomentManaRechargeArgs, delta)
		delta = 0
	end

	if CurrentRun.Hero.Mana <= 0 and delta < 0 then
		return
	end

	args = args or {}
	if CurrentRun.Hero.Mana < GetHeroMaxAvailableMana() and delta > 0 and not args.Silent then
		ManaRegenPresentation(delta)
	end
	CurrentRun.Hero.Mana = math.ceil( CurrentRun.Hero.Mana + delta )
	if CurrentRun.Hero.Mana > GetHeroMaxAvailableMana() then
		CurrentRun.Hero.Mana = GetHeroMaxAvailableMana()
	end
	if CurrentRun.Hero.Mana < 0 then
		CurrentRun.Hero.Mana = 0
	elseif CurrentRun.Hero.Mana >= 0 and delta < 0 then
		if not args.IgnoreSpend then
			CheckOnManaSpendPowers( delta, args )
		end
		killTaggedThreads("ManaRegenInterval")
		thread( ManaRegen )
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

function ManaRegenSetup( hero, args )
	args = args or {}
	args.Name = args.Name or "Backcompat"
	CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
	CurrentRun.Hero.ManaRegenSources [ args.Name ] = { Value = args.ManaRegenPerSecond or 0 }
	thread( ManaRegen )
end

function CheckOnManaSpendPowers( delta, args )
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
		if actionData.FunctionName then
			CallFunctionName( actionData.FunctionName, actionData.FunctionArgs, delta)
		end
	end
	ChargeSpell( delta, args )
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
		if CurrentRun.Hero.ManaRegenSources then
			for key, data in pairs(CurrentRun.Hero.ManaRegenSources) do
				manaRegenPerSecond = manaRegenPerSecond + data.Value
				if data.ShowManaRegen then
					showMana = true
				end
			end	
		end
		if not IsEmpty( MapState.ChargedManaWeapons ) then
			manaRegenPerSecond = 0
		end
		local encounter = CurrentRun.CurrentRoom.Encounter
		if encounter.DelayedStart and not encounter.StartTime and not encounter.NeverDelayManaRegen then
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
end

function ReserveMana( amount, source )
	local manaModifiers = GetHeroTraitValues("ManaCostModifiers")
	local manaMultiplier = 1
	for i, data in pairs(manaModifiers) do
		if data.WeaponNamesLookup == nil or ( data.WeaponNamesLookup and data.WeaponNamesLookup[source] ) then
			if data.ManaReservationCostMultiplier then
				manaMultiplier = manaMultiplier * data.ManaReservationCostMultiplier
			end
		end
	end
	amount = amount * manaMultiplier
	CurrentRun.Hero.ReserveManaSources = CurrentRun.Hero.ReserveManaSources or {}
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
	if CurrentRun.Hero.ReserveManaSources and CurrentRun.Hero.ReserveManaSources[ source ] then
		CurrentRun.Hero.ReserveManaSources[ source ] = nil
	end
	UpdateManaMeterUI()
end

function GetHeroMaxAvailableMana()
	if IsEmpty(CurrentRun.Hero.ReserveManaSources) then
		return CurrentRun.Hero.MaxMana
	end

	local mana = CurrentRun.Hero.MaxMana
	for source, amount in pairs( CurrentRun.Hero.ReserveManaSources ) do
		mana = mana - amount
	end
	if mana < 0 then
		mana = 0
	end
	
	return mana
end

function InCastCircleManaRegenSetup( hero, args )
	thread( CastCircleManaRegen )
	thread( ManaRegen )
end

function CastCircleManaRegen()
	if SetThreadWait( "CastCircleRegen", 0.25 ) then
		return
	end
	wait(0.25, "CastCircleRegen")
	if not CurrentRun.Hero.ActiveEffects.InsideCastBuff then
		CurrentRun.Hero.ManaRegenSources.CastCircleRegen = nil	
	end
end

function MovingManaRegenSetup( hero, args )
	thread( MovingManaRegen, args )
	thread( ManaRegen )
end

function MovingManaRegen( args )
	wait(0.3)
	CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
	local initialWait = 3600
	if IsMoving({ Id = CurrentRun.Hero.ObjectId }) then
		initialWait = 0.1
	end
	while true do
		wait(initialWait, "MovingManaRegen" )
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
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.SetupFunction and traitData.SetupFunction.Name == "IdleManaRegenSetup" then
			idleManaTrait = traitData
		end
	end
	if not idleManaTrait or HasThread("IdleManaRegen") then
		return
	end

	local traitArgs = idleManaTrait.SetupFunction.Args
	wait( traitArgs.MovePenaltyDuration, "IdleManaRegen" )
	CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
	CurrentRun.Hero.ManaRegenSources.IdleManaRegen = { Value = traitArgs.ManaRegenPerSecond, ShowManaRegen = true }

	if traitArgs.ManaRegenStartFx then
		CreateAnimation({ Name = traitArgs.ManaRegenStartFx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
	end
	if traitArgs.ManaRegenStartSound then
		PlaySound({ Name = traitArgs.ManaRegenStartSound, Id = CurrentRun.Hero.ObjectId })
	end
end

OnPlayerMoveStarted{
	function( args )
		CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
		CurrentRun.Hero.ManaRegenSources.IdleManaRegen = nil
		killTaggedThreads("IdleManaRegen")

		for i, traitData in pairs(CurrentRun.Hero.Traits) do
			if traitData.SetupFunction and traitData.SetupFunction.Name == "MovingManaRegenSetup" then
				SetThreadWait( "MovingManaRegen", traitData.SetupFunction.Args.MovePenaltyDuration )
			end
		end
	end
}
OnPlayerMoveStopped{
	function ( args )
		CurrentRun.Hero.ManaRegenSources = CurrentRun.Hero.ManaRegenSources or {}
		CurrentRun.Hero.ManaRegenSources.MovingManaRegen = nil
		SetThreadWait( "MovingManaRegen", 3600 )

		for i, traitData in pairs(CurrentRun.Hero.Traits) do
			if traitData.SetupFunction and traitData.SetupFunction.Name == "IdleManaRegenSetup" then
				thread( IdleManaRegen )
			end
		end
	end
}
function CheckManaRefund( weaponData, functionArgs )
	if RandomChance( functionArgs.Chance ) then
		ManaDelta( functionArgs.ManaGain )
		ManaRefundPresentation( weaponData, functionArgs )
	end
end

function CheckManaOnHit( victim, functionArgs, triggerArgs )
	local validWeapons = ConcatTableValues( ShallowCopyTable(functionArgs.ValidWeapons), AddLinkedWeapons( functionArgs.ValidWeapons))
	local passesHitCheck = functionArgs.FirstHitOnly == nil or (functionArgs.FirstHitOnly and not ProjectileHasUnitHit( triggerArgs.ProjectileId, "ManaOnHit" ))
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

	local multiplier = GetTotalHeroTraitValue( "OnDamagedManaConversion" )
	local flatAmount = GetTotalHeroTraitValue( "OnDamagedManaConversionFlat" )
	local meterAmount = damageAmount * multiplier + flatAmount
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

function GetLowestManaCost()

	local weaponManaToCheck = {}
	local weaponReservationManaToCheck = {}
	local weaponNames = AddLinkedWeapons( GetAllKeys( CurrentRun.Hero.Weapons ))
	local lowestManaCost = 8000
	for i, weaponName in pairs( weaponNames ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		if not weaponData then
			DebugPrint({Text = "unable to find " .. weaponName})
			return
		end
		local manaLimit = GetManaCost( weaponData, true )
		if weaponData.CostPerSecond and CurrentRun.Hero.ManaDrain[weaponData.Name] then
			manaLimit = nil
		end
		if weaponData.DrainManaEffect and CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name] then
			manaLimit = nil
		end
		local chargeStages = GetWeaponChargeStages( weaponData )
		if not IsEmpty(chargeStages) then
			manaLimit = chargeStages[1].ManaCost
		end
		if manaLimit and manaLimit > 0 and manaLimit < lowestManaCost then
			lowestManaCost = manaLimit
		end
	end
	return lowestManaCost
end