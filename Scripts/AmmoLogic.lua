function ReloadAmmo( weaponData )
	CurrentRun.Hero.Ammo[ weaponData.Name ] = GetMaxAmmo( weaponData.Name )
end

function UpdateWeaponAmmo ( weaponName, delta, args )
	args = args or {}
	IncrementTableValue( CurrentRun.Hero.Ammo, weaponName, delta )
	if CurrentRun.Hero.Ammo[weaponName] > GetMaxAmmo( weaponName ) then
		CurrentRun.Hero.Ammo[weaponName] = GetMaxAmmo( weaponName )
	end

	if GetCurrentAmmo( weaponName ) > 0 and not MapState.HostilePolymorph then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
	elseif GetCurrentAmmo( weaponName ) <= 0 then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", Color = Color.White, OriginalColor = Color.Red, ScaleTarget = 1.5, ScaleDuration = 0.2, HoldDuration = 0.05, PulseBias = 0.1, StartColorDuration = 0.25, EndColorDuration = 0.25 })
	end
	thread( UpdateAmmoUI )
end

function AddAmmo( weaponName, value )
	value = value or 1
	UpdateWeaponAmmo ( weaponName, value )
	
	for i, data in pairs( GetHeroTraitValues("OnCollectAmmoFunctionName")) do
		if data.WeaponName == weaponName then
			thread( CallFunctionName, data.FunctionName, weaponName, data.FunctionArgs )
		end
	end
end

function SpendAmmo( weaponName )
	UpdateWeaponAmmo( weaponName, -1 )
end

function GetCurrentAmmo( weaponName )
	return CurrentRun.Hero.Ammo[ weaponName ] or 0
end

function GetMaxAmmo( weaponName )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	local maxAmmo = weaponData.MaxAmmo

	for s, traitData in pairs( GetHeroTraitValues("WeaponAmmoModification")) do
		if traitData.Name == weaponName then 
			if traitData.AddMaxAmmo then
				maxAmmo = maxAmmo + traitData.AddMaxAmmo
			end
			if traitData.ReduceMaxAmmo then
				maxAmmo = maxAmmo - traitData.ReduceMaxAmmo
			end
		end
	end
	return maxAmmo
end