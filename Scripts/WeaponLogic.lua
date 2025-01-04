function CheckWeaponRoomStartEvents()
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	end
end

function IsExWeapon( weaponName, args, triggerArgs )
	if Contains(WeaponSets.HeroSpellWeapons, weaponName) then
		return false
	end
	
	local baseWeaponData = WeaponData[weaponName]
	
	local projectileName = triggerArgs.SourceProjectile or triggerArgs.ProjectileName
	if not baseWeaponData then
		return false
	end

	for i, data in pairs(GetHeroTraitValues("CustomExDefinitions")) do
		if data[projectileName] ~= nil then
			return data[projectileName]
		end
	end
	args = args or {}
	local isEx = false
	-- Virtually every weapon has a bespoke implementation of 'ex-ness'
	if baseWeaponData.IsExWeapon then
		return true
	elseif baseWeaponData.ManaCost then
		-- starting rule of thumb: ex weapons cost mana (before modifications)
		return true
	elseif ( args.Combat and triggerArgs and triggerArgs.Armed ) then
		-- armed cast is an ex effect
		return true
	elseif baseWeaponData.IsExWithMapStateVariable and SessionMapState[baseWeaponData.IsExWithMapStateVariable] then
		return true
	elseif projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].IsExProjectile then
		return true
	elseif projectileName and ProjectileData[projectileName] and ProjectileData[projectileName].IsNotExProjectile then
		return false
	elseif baseWeaponData.ChargeWeaponStages then
		local chargedProjectileNames = {}
		local chargedMinNumProjectiles = -1
		local numProjectiles = triggerArgs.MaxNumProjectiles or triggerArgs.NumProjectiles
		local deferRevert = false
		for i, stageData in ipairs(baseWeaponData.ChargeWeaponStages) do
			if stageData.WeaponProperties and stageData.WeaponProperties.Projectile then
				chargedProjectileNames[stageData.WeaponProperties.Projectile] = true
			end
			if stageData.ProjectileProperties and stageData.ProjectileProperties.SpawnOnDetonate then
				chargedProjectileNames[stageData.ProjectileProperties.SpawnOnDetonate] = true
			end
			if chargedMinNumProjectiles == -1 and stageData.WeaponProperties and stageData.WeaponProperties.NumProjectiles then
				chargedMinNumProjectiles = stageData.WeaponProperties.NumProjectiles
			end
			if stageData.DeferRevert then
				deferRevert = true
			end
		end
		if args.Combat then
			-- This has to handle the moment the hit occurs, not when the weapon is fired
			if triggerArgs and projectileName and chargedProjectileNames[projectileName] then
				-- ex charge changes projectile type
				isEx = true
			elseif IsEmpty(chargedProjectileNames) and triggerArgs and chargedMinNumProjectiles ~= -1 and numProjectiles > chargedMinNumProjectiles then
				-- ex charge charges projectile number (or makes it non-zero)
				isEx = true
			elseif deferRevert and ( MapState.WeaponCharge and MapState.WeaponCharge[ weaponName ] and MapState.WeaponCharge[ weaponName ] > 0 ) then
				isEx = true
			end
		end
	end
	return isEx
end

OnWeaponFired{ "WeaponSprint",
	function(triggerArgs)
		local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
		local sprintVfxValid = false
		if weaponData.DrainManaEffect then
			if CurrentRun.Hero.Mana > 0 and ( not weaponData.DrainManaEffect.RequiredStartMana or CurrentRun.Hero.Mana >= weaponData.DrainManaEffect.RequiredStartMana ) then
				if weaponData.DrainManaEffect.EffectName then
					ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, EffectName = weaponData.DrainManaEffect.Name })
				end
				thread( DrainManaPerSecond, ShallowCopyTable( weaponData.DrainManaEffect ))
				sprintVfxValid = true
			end
		else
			sprintVfxValid = true
		end


		if sprintVfxValid and weaponData.SprintVfx and CheckCooldown( "WeaponSprintVfx", weaponData.SprintVfx.Cooldown ) then
			CreateAnimation({ Name = weaponData.SprintVfx.Name, DestinationId = CurrentRun.Hero.ObjectId })
		end
		
		SprintStartEvents()
		SessionMapState.SprintActive = true
		CheckSprintBoons()
	end
}

function SprintStartEvents()
	if SessionMapState.SprintStartEventsFired then
		return
	end
	SessionMapState.SprintStartEventsFired = true
	SessionMapState.SprintStartTime = _worldTimeUnmodified
	local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon())
	if equippedWeaponData.SprintLoopSound and not SessionMapState.SprintWeaponSoundId and (not CurrentRun.Hero.IsDead or (CurrentHubRoom and CurrentHubRoom.AllowWeapons)) then
		SessionMapState.SprintWeaponSoundId = PlaySound({ Name = equippedWeaponData.SprintLoopSound, Id = CurrentRun.Hero.ObjectId })
	end
	for _, actionData in pairs(GetHeroTraitValues("OnSprintStartAction")) do
		thread( CallFunctionName, actionData.FunctionName, actionData.Args )
	end
end

function CheckAutoSprint()
	if not IsInputAllowed({}) then
		return
	end

	SessionMapState.EndAutoSprintThread = nil
	if not GameState.SprintAutoHoldDetected then
		GameState.SprintAutoHoldDetected = true
		if GetConfigOptionValue({ Name = "UseMouse" }) then
			SetConfigOption({ Name = "SprintAutoHold", Value = true })
			UpdateConfigOptionCache()
		end
	end
	if not ConfigOptionCache.SprintAutoHold then
		return
	end
	SessionMapState.SprintActive = true
	wait(0.1)
	thread( HoldSprintUntilInput )
end

function CheckAutoSprintEnd()
	if not ConfigOptionCache.SprintAutoHold then
		return
	end
	if IsControlDown({ Name = "Rush" }) then 
		if HeroData.AutoSprintBuffer and HeroData.AutoSprintBuffer > 0 then
			local notifyName = "SprintUp"
			NotifyOnControlReleased({ Names = { "Rush" }, Notify = notifyName, Timeout = HeroData.AutoSprintBuffer })
			waitUntil(notifyName)
			if not _eventTimeoutRecord[notifyName] then
				return
			end
			EndAutoSprint()
		end	
	end
end

function EndAutoSprint()
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "HoldFireRequest", Value = false, ValueChangeType = "Absolute", DataValue = false })
	notifyExistingWaiters(  "SprintInput" )
	SessionMapState.EndAutoSprintThread = true
end
function HoldSprintUntilInput()
	local endSprintControls = { "Shout", "Attack2", "Attack1", "Attack3" }
	if not IsControlDown({ Names = {"Up", "Down", "Left", "Right" }}) or SessionMapState.WaitUntilAutoSprintInput or IsControlDown({ Names = endSprintControls }) or SessionMapState.SpellInProgress then
		SessionMapState.SprintActive = nil
		return
	end
	SessionMapState.LockSprintActive = true
	local notifyName = "SprintInput"
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "HoldFireRequest", Value = true, ValueChangeType = "Absolute", DataValue = false })
	FireWeaponFromUnit({ Weapon = "WeaponSprint", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	SessionMapState.WaitUntilAutoSprintInput = true
	while SessionMapState.WaitUntilAutoSprintInput do
		NotifyOnControlPressed({ Names = endSprintControls, NotifyOnNoMoveInput = true, Notify = notifyName })
		waitUntil( notifyName )
		if SessionMapState.EndAutoSprintThread or IsControlDown({ Names = endSprintControls }) or SessionMapState.SpellInProgress then
			SessionMapState.WaitUntilAutoSprintInput = nil
			break
		end
		local bufferTime = 0.05
		-- In case of a very brief drop in move input, don't instantly end sprint, wait for more motion (or end anyway if the player has acted)
		NotifyOnControlPressed({ Names = endSprintControls, NotifyOnMoveInput = true, Notify = notifyName, Timeout = bufferTime }) 
		waitUntil( notifyName )
		if _eventTimeoutRecord[notifyName] or SessionMapState.EndAutoSprintThread or IsControlDown({ Names = endSprintControls }) or SessionMapState.SpellInProgress then	
			SessionMapState.WaitUntilAutoSprintInput = nil
		end
	end
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "HoldFireRequest", Value = false, ValueChangeType = "Absolute", DataValue = false })
	
	if not IsControlDown({ Name = "Rush" }) or IsControlDown({ Names = endSprintControls }) then 
		EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
		Halt({ Id = CurrentRun.Hero.ObjectId })
	end
	SessionMapState.LockSprintActive = nil
end


function WeaponSprintOutOfMana()				
	ClearEffect({Id = CurrentRun.Hero.ObjectId, Name = "SprintInvuln"})
end

function CheckDashManeuverEnd()
	wait( CurrentRun.Hero.DashManeuverTimeThreshold, "DashWeapon")
	if not SessionMapState.SprintActive and MapState.AttachedStormProjectileId and MapState.AttachedStormProjectileId > 0 and HeroHasTrait("HestiaSprintBoon") then
		ExpireProjectiles({ ProjectileId = MapState.AttachedStormProjectileId })
		MapState.AttachedStormProjectileId = nil
		if MapState.AttachedStormAnimation then
			StopAnimation({ Name = MapState.AttachedStormAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
	if not SessionMapState.SprintActive and IsEmpty(MapState.TransformArgs) then
		CheckSprintBoons()
		for equippedWeapon, k in pairs( CurrentRun.Hero.Weapons ) do
			local weaponData = GetWeaponData( CurrentRun.Hero, equippedWeapon )
			local dashWeapon = weaponData.DashWeapon
			
			for i, replaceWeapons in pairs( GetHeroTraitValues("ReplaceMeleeWeapon") ) do
				weaponData = WeaponData[replaceWeapons]
			end

			if dashWeapon ~= nil and type(dashWeapon) ~= "table" then
				SwapWeapon({ SwapWeaponName = weaponData.Name, Names = { dashWeapon }, DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true })
				if weaponData.PreserveDashWeaponSwapNames then
					for _, weaponName in pairs( weaponData.PreserveDashWeaponSwapNames ) do
						SwapWeapon({ Names = { weaponName }, SwapWeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, RequireCurrentControl = true, GainedControlFrom = weaponData.Name })
					end
				end
			end
		end
	end
end

function DashManeuver( duration )
	CheckSprintBoons()
	if not IsEmpty(MapState.TransformArgs) then
		return
	end
	for equippedWeapon, k in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, equippedWeapon )
		local dashWeapon = weaponData.DashWeapon
		if dashWeapon ~= nil and type(dashWeapon) ~= "table" then
			if weaponData.ExpireDashWeaponOnDash then
				ExpireProjectiles({ WeaponName = dashWeapon })
			end
			for i, replaceWeapons in pairs( GetHeroTraitValues("ReplaceMeleeWeapon") ) do
				weaponData = WeaponData[replaceWeapons]
			end
			if weaponData.EndControlSwapsOnDash then
				EndAllControlSwaps({ DestinationId = CurrentRun.Hero.ObjectId })
			end
			SwapWeapon({ Names = weaponData.DashSwaps or { weaponData.Name }, SwapWeaponName = dashWeapon, DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true, RequireNotCharging = weaponData.BlockDashSwapIfCharging })
			if weaponData.PreserveDashWeaponSwapNames then
				for _, weaponName in pairs( weaponData.PreserveDashWeaponSwapNames ) do
					SwapWeapon({ Names = { weaponName }, SwapWeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, RequireCurrentControl = true, GainedControlFrom = dashWeapon })
				end
			end
		end
	end
end

OnWeaponFired{ "WeaponBlink",
	function( triggerArgs )
		local runFunctions = {}
		for i, dashData in pairs( GetHeroTraitValues("AddRush") ) do
			local dashFunction = _G[dashData.FunctionName]
			if dashFunction ~= nil and ( not dashData.RunOnce or ( dashData.RunOnce and not runFunctions[ dashData.FunctionName ])) then
				thread( dashFunction, dashData.FunctionArgs, triggerArgs )
				runFunctions[dashData.FunctionName] = true
			end
		end
		SessionMapState.CancelSuitExBlinkForce = true
		DashManeuver()
		thread( CheckDashManeuverEnd )
		thread( CheckAutoSprint )
	end
}

OnRamWeaponComplete{ "WeaponSprint",

	function(triggerArgs) 
		local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
		if weaponData.DrainManaEffect and CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name] then
			CurrentRun.Hero.ManaDrain[weaponData.DrainManaEffect.Name]  = nil
			ClearEffect({Id = CurrentRun.Hero.ObjectId, Name = weaponData.DrainManaEffect.Name})		
		end
		if MapState.AttachedStormProjectileId and MapState.AttachedStormProjectileId > 0 then
			DetachProjectiles({ Id = MapState.AttachedStormProjectileId })
		end
		if not IsEmpty(MapState.AttachedStormProjectileIds) then
			DetachProjectiles({ Ids = MapState.AttachedStormProjectileIds })
		end
		thread( CheckDashManeuverEnd )
		notifyExistingWaiters(  "SprintInput" )
		local teleports = 0
		local requiredSprintTime = 0
		for i, data in pairs(GetHeroTraitValues("SprintTeleportAllies")) do
			teleports = teleports + data.Count
			requiredSprintTime = data.Delay
		end
		if SessionMapState.SprintStartTime and (_worldTimeUnmodified - SessionMapState.SprintStartTime) >= requiredSprintTime then
			TeleportSummonsToPlayer( teleports )
		end
		
		if SessionMapState.SprintSoundId then
			StopSound({Id = SessionMapState.SprintSoundId, Duration = 0.35 })
			SessionMapState.SprintSoundId = nil
		end
		if not ConfigOptionCache.SprintAutoHold or not SessionMapState.LockSprintActive then
			SessionMapState.SprintActive = nil
		end
		local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon())
		if SessionMapState.SprintWeaponSoundId then
			StopSound({ Id = SessionMapState.SprintWeaponSoundId, Duration = 0.2 })
			SessionMapState.SprintWeaponSoundId = nil
		end
		if equippedWeaponData.SprintEndSound and (not CurrentRun.Hero.IsDead or (CurrentHubRoom and CurrentHubRoom.AllowWeapons)) then
			PlaySound({ Name = equippedWeaponData.SprintEndSound, Id = CurrentRun.Hero.ObjectId })
		end
		if not SessionMapState.SprintActive then
			for _, actionData in pairs( GetHeroTraitValues( "OnSprintEndAction" ) ) do
				if _G[actionData.FunctionName] ~= nil then
					_G[actionData.FunctionName]( ShallowCopyTable( actionData.FunctionArgs ), triggerArgs )
				end
			end
			if HeroHasTrait("PoseidonSplashSprintBoon") then
				local traitData = GetHeroTrait("PoseidonSplashSprintBoon")
				if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
					PoseidonSprintBlastDetach(traitData.OnWeaponFiredFunctions.FunctionArgs, GetAngle({ Id = CurrentRun.Hero.ObjectId })) 
				end
			end
		end
		SessionMapState.SprintStartEventsFired = nil
		SetThreadWait( "DashWeapon", CurrentRun.Hero.DashManeuverTimeThreshold )
	end
}
function TorchPassiveCharge( weaponData, args )
	while CurrentRun.Hero.Weapons[weaponData.Name] do
		waitUntil( weaponData.Name.."Fire" )
		weaponData = GetWeaponData( CurrentRun.Hero, weaponData.Name)
		local chargeDuration = weaponData.ChargeDuration * GetLuaWeaponSpeedMultiplier( weaponData.Name )
		wait( chargeDuration , weaponData.Name.."ChargeThread")
		MapState.StaffBoltCharged = true
		MapState.StaffFireIndex = 0
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "DamageMultiplier", Value = 1})
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeScaleMultiplier", Value = 1})
	end
end

function CancelTorchPassiveCharge( weaponData )
	killTaggedThreads( weaponData.Name.."ChargeThread" )
end

function TorchFiredFunction( unit, weaponData, functionArgs, triggerArgs )
	notifyExistingWaiters( weaponData.Name.."Fire" )
	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )		
	MapState.StaffFireIndex = (MapState.StaffFireIndex or 0) + 1
	if weaponData.ContinuousFireDamageMultiplier then
		local damageMultiplier = weaponData.ContinuousFireDamageMultiplier[MapState.StaffFireIndex]
		local scaleMultiplier = weaponData.ContinuousFireScaleMultiplier[MapState.StaffFireIndex]
		if not damageMultiplier  then
			damageMultiplier  = weaponData.ContinuousFireDamageMultiplier[#weaponData.ContinuousFireDamageMultiplier] or 1
		end
		if not scaleMultiplier then
			scaleMultiplier = weaponData.ContinuousFireScaleMultiplier[#weaponData.ContinuousFireDamageMultiplier] or 1
		end
		SetWeaponProperty({ WeaponName = triggerArgs.name, DestinationId = CurrentRun.Hero.ObjectId, Property = "DamageMultiplier", Value = damageMultiplier })
		SetWeaponProperty({ WeaponName = triggerArgs.name, DestinationId = CurrentRun.Hero.ObjectId, Property = "ChargeScaleMultiplier", Value = scaleMultiplier})
	end
	local chargeDuration = weaponData.ChargeDuration * GetLuaWeaponSpeedMultiplier( triggerArgs.name )
	SetThreadWait( triggerArgs.name.."ChargeThread", chargeDuration )
end

function TorchChargedFiredFunction( unit, weaponData, functionArgs, triggerArgs )
	notify(triggerArgs.name.."Fire")
	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.name )
		
	SwapWeapon({ Name = triggerArgs.name, SwapWeaponName = weaponData.SwapUnchargedWeapon , ClearFireRequest = true, StompOriginalWeapon = false, GainedControlFrom = triggerArgs.name, DestinationId = CurrentRun.Hero.ObjectId, RequireCurrentControl = true })
	local chargeDuration = weaponData.ChargeDuration * GetLuaWeaponSpeedMultiplier( triggerArgs.name )
end

function WeaponBlinkFunction( triggerArgs, weaponData, args )		
	thread( StartBlinkTrailPresentation )
	thread( StartPlayerBlinkAlpha )
	MapState.LastBlinkTimeUnmodified = _worldTimeUnmodified
end

function GetLuaWeaponSpeedMultiplier( weaponName )
	local weaponSpeedMultipliers = GetHeroTraitValues( "WeaponSpeedMultiplier" )
	local speedMultiplier = 1
	for i, data in pairs(weaponSpeedMultipliers) do
		if data.WeaponNamesLookup[ weaponName ] then
			speedMultiplier = speedMultiplier * data.Value
		end
	end

	if MapState.MapSpeedMultiplier then
		speedMultiplier = speedMultiplier * MapState.MapSpeedMultiplier
	end

	if SessionMapState.WeaponSpeedMultipliers[weaponName] then
		speedMultiplier = speedMultiplier * SessionMapState.WeaponSpeedMultipliers[weaponName]
	end
	return speedMultiplier
end

function StaffBall2FiredFunction( unit, weaponData, functionArgs, triggerArgs )

	local baseWeaponData = GetWeaponData(CurrentRun.Hero, weaponData.SourceWeapon )
	local functionArgs = baseWeaponData.OnChargingFunctionArgs
	if functionArgs and functionArgs.ManaCost then
		ManaDelta( -GetManaCost( baseWeaponData, false, { ManaCostOverride = functionArgs.ManaCost}))
	end
end
function CastArmedFunction( unit, weaponData, functionArgs, triggerArgs )
	local baseWeaponData = GetWeaponData(CurrentRun.Hero, weaponData.SourceWeapon )
	CastArmedPresentation( weaponData )
end

OnWeaponChargeCanceled{ "WeaponCastArm",
	function( triggerArgs )
		if not triggerArgs.AllowFire and triggerArgs.Charge >= 1 and not triggerArgs.OnCooldown then
			SetAnimation({ Name = WeaponData.WeaponCast.UnarmedCastCompleteGraphic, DestinationId = CurrentRun.Hero.ObjectId })
			WeaponFailedNoManaPresentation ( weaponData, { Force = true } )
		end
	end
}

OnWeaponChargeCanceled{ "WeaponDagger5",
	function( triggerArgs )
		if not triggerArgs.AllowFire and triggerArgs.Charge >= 1 and not triggerArgs.PostFire then
			WeaponFailedNoManaPresentation( GetWeaponData( CurrentRun.Hero, triggerArgs.name ), { Force = true })
		end
		MapState.DaggerCharging = false
		killWaitUntilThreads("WeaponDagger5Mark")
		MapState.MarkDaggerEnemyId = nil
		if MapState.MarkedDaggerTargetId then
			Destroy({ Id = MapState.MarkedDaggerTargetId  })
		end
		if not IsEmpty(MapState.AdditionalMarkIds) then
			Destroy({ Ids = MapState.AdditionalMarkIds })
		end
		if MapState.DaggerBlockShieldActive then
			MapState.DaggerBlockShieldActive = false
			SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
			SetPlayerInterruptible("DaggerBlock")
			local traitData = GetHeroTrait("DaggerBlockAspect")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
}

OnWeaponFired{ "WeaponDagger5", 
	function( triggerArgs)
		if CurrentRun.Hero.ActiveEffects and CurrentRun.Hero.ActiveEffects.Rooted  then
			return
		end
		local args = GetWeaponData(CurrentRun.Hero, triggerArgs.name ).OnChargeFunctionArgs
		local targetId = MapState.MarkDaggerEnemyId
		local target = ActiveEnemies[targetId]
		if target ~= nil and not target.IsDead then
			local distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
			local angle = GetAngleBetween( { Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
			local offset = CalcOffset( math.rad( angle ), target.BackstabDistance or args.BackstabDistance ) 
			offset.Y = offset.Y * (target.BackstabDistanceScaleY or 1.0)
			local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y })
			if not IsLocationValid({ Id = CurrentRun.Hero.ObjectId, DestinationId = tempObstacle}) then
				Destroy({ tempObstacle })
				tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId })
			else
				angle = angle + 180
			end
			FireWeaponFromUnit({ Weapon = "WeaponDaggerBlink", Id = CurrentRun.Hero.ObjectId, DestinationId = tempObstacle , Angle = math.rad(angle) })
			DestroyOnDelay({ tempObstacle }, 0.1)
		end
		
		if HeroHasTrait("DaggerTripleAspect") then
			thread(HandleBonusStrikes, triggerArgs.name, args )
		end
		MapState.DaggerCharging = false
		killWaitUntilThreads("WeaponDagger5Mark")
		MapState.MarkDaggerEnemyId = nil
		if MapState.MarkedDaggerTargetId then
			Destroy({ Id = MapState.MarkedDaggerTargetId  })
		end
		if not IsEmpty(MapState.AdditionalMarkIds) then
			Destroy({ Ids = MapState.AdditionalMarkIds })
		end
	end
}
function MarkDaggerTarget( triggerArgs, weaponData, args )
	MapState.DaggerCharging = true
	if HeroHasTrait("DaggerTripleAspect") then
		thread( MarkAdditionalDaggerTarget, triggerArgs, weaponData, GetHeroTrait("DaggerTripleAspect").DaggerAdditionalTargetData )
	end
	while MapState.DaggerCharging do
		local targetId = GetAutoLockId({ Id = CurrentRun.Hero.ObjectId, Arc = math.rad(args.AutoLockArc), Range = args.Range })
		if targetId ~= 0 and ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
			if MapState.MarkDaggerEnemyId ~= targetId then
				MapState.MarkDaggerEnemyId = targetId
				if MapState.MarkedDaggerTargetId then
					Destroy({ Id = MapState.MarkedDaggerTargetId  })
				end
				MapState.MarkedDaggerTargetId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId })
				SetAnimation({ Name = "DaggerMarkStatus", DestinationId = MapState.MarkedDaggerTargetId })
				Attach({ Id = MapState.MarkedDaggerTargetId, DestinationId = targetId })
				local notifyName = "WeaponDagger5Mark"
				if GetConfigOptionValue({Name = "UseMouse" }) then
					waitUnmodified(0.1, RoomThreadName)
				else
					NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, Distance = args.Range, DestinationId = targetId, Notify = notifyName, Timeout = 0.1 })
					waitUntil( notifyName )
				end
			else		
				waitUnmodified(0.1, RoomThreadName)
			end
		elseif MapState.MarkedDaggerTargetId then
			Destroy({ Id = MapState.MarkedDaggerTargetId  })
			MapState.MarkDaggerEnemyId = nil
			waitUnmodified(0.1, RoomThreadName)
		else
			waitUnmodified(0.1, RoomThreadName)
		end
	end
end

function MarkAdditionalDaggerTarget( triggerArgs, weaponData, traitArgs )
	MapState.AdditionalTargetIds = {}
	MapState.AdditionalMarkIds = {}
	while MapState.DaggerCharging do
		if MapState.MarkDaggerEnemyId then
			local enemyIds = GetClosestIds({ Id = MapState.MarkDaggerEnemyId, DestinationName = "EnemyTeam", IgnoreSelf = true, StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = traitArgs.Range })
			if not IsEmpty(enemyIds) then
				-- Reset the list if any targets are now ineligible or if you have no targets
				local retarget = IsEmpty( MapState.AdditionalTargetIds )
				for _, id in pairs( MapState.AdditionalTargetIds ) do
					if not Contains( enemyIds, id ) then
						retarget = true
					end
				end
				if retarget then
					Destroy({ Ids = MapState.AdditionalMarkIds })
					MapState.AdditionalTargetIds = {}
					MapState.AdditionalMarkIds = {}
					for i=1,traitArgs.AdditionalTargets do
						if enemyIds[i] then
							local markImage = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId })
							SetAnimation({ Name = "DaggerMarkStatus", DestinationId = markImage })
							Attach({ Id = markImage, DestinationId = enemyIds[i] })
							table.insert( MapState.AdditionalTargetIds, enemyIds[i] )
							table.insert( MapState.AdditionalMarkIds, markImage )
						end
					end
				end
			end
			waitUnmodified(0.1, RoomThreadName)
		else
			Destroy({ Ids = MapState.AdditionalMarkIds })
			MapState.AdditionalTargetIds = {}
			MapState.AdditionalMarkIds = {}
			waitUnmodified(0.1, RoomThreadName)
		end
	end
	Destroy({ Ids = MapState.AdditionalMarkIds })
end

function HandleBonusStrikes( weaponName, args )
	if not IsEmpty(MapState.AdditionalTargetIds) then
		local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId })
		local additionalTargetData = GetHeroTrait("DaggerTripleAspect").DaggerAdditionalTargetData
		local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName , Property = "Projectile" })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		derivedValues.PropertyChanges.AttachToOwner = false
		for _, id in pairs(MapState.AdditionalTargetIds) do
			local target = ActiveEnemies[id]
			if target ~= nil and not target.IsDead then
				waitUnmodified(0.3, RoomThreadName)
				local angle = GetAngleBetween( { Id = tempObstacle, DestinationId = id })
				local offset = CalcOffset( math.rad( angle ), target.BackstabDistance or args.BackstabDistance ) 
				offset.Y = offset.Y * (target.BackstabDistanceScaleY or 1.0)
				
				CreateProjectileFromUnit({ 
					WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = id, FireFromTarget = true, 
					DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
					Angle = angle + 180, OffsetX = offset.X, OffsetY = offset.Y })

				local streakAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = id })
				SetAngle({ Id = streakAnchor, Angle = angle })
				CreateAnimation({ Name = additionalTargetData.Vfx, DestinationId = streakAnchor})
				thread( DestroyOnDelay, {streakAnchor}, 0.2 )
			end
		end
		Destroy({ Id = tempObstacle })
	end
end

function DoDaggerStagedCharge( triggerArgs, weaponData, args )
	thread( MarkDaggerTarget, triggerArgs, weaponData, args )
	thread( DoWeaponCharge, triggerArgs, weaponData, args )
end

function GetWeaponChargeStages( weaponData )

	local weaponName = weaponData.Name
	local chargeStages = DeepCopyTable(weaponData.ChargeWeaponStages) or {}
	local chargeStageModifiers = GetHeroTraitValues("ChargeStageModifiers")
	local appliedChanges = {}
	for i, data in pairs( chargeStageModifiers ) do
		local validWeapon = data.ValidWeaponsLookup == nil or data.ValidWeaponsLookup[weaponData.Name]
		local validTrait = data.TraitName == nil or HeroHasTrait( data.TraitName )
		if validWeapon and validTrait then
			if data.AddChargeStage then
				table.insert(chargeStages, ShallowCopyTable(data.AddChargeStage))
			end
			if data.AddProjectedChargeStages then
				local lastStage = chargeStages[#chargeStages]
				for i = 1, data.AddProjectedChargeStages.NumStages do
					local newStage = DeepCopyTable(lastStage)
					for key, projectedChange in pairs( data.AddProjectedChargeStages.ProjectedChanges ) do
						if newStage[key] then
							newStage[key] = newStage[key] + projectedChange * i
						end
						if newStage.WeaponProperties and newStage.WeaponProperties[key] then
							newStage.WeaponProperties[key] = newStage.WeaponProperties[key] + projectedChange * i
						end
					end
					table.insert( chargeStages, newStage )
				end
			end
			if data.AddWeaponProperties and not IsEmpty(chargeStages) then
				
				for i, chargeStage in pairs( chargeStages ) do
					chargeStage.WeaponProperties = chargeStage.WeaponProperties or {}
					for key, value in pairs( data.AddWeaponProperties ) do
						if IsEmpty(weaponData.BlockChargeStageModifiers) or not weaponData.BlockChargeStageModifiers[key] then
							if data.MultiplyExistingWeaponProperties and data.MultiplyExistingWeaponProperties[key] and chargeStage.WeaponProperties[key] then
								chargeStage.WeaponProperties[key] = chargeStage.WeaponProperties[key] * value 
							elseif value == "null" then
								chargeStage.WeaponProperties[key] = nil
							else
								chargeStage.WeaponProperties[key] = value 
							end
						end
					end
				end
			end
			if data.RevertProjectileProperties and not IsEmpty(chargeStages) then
				local baseProjectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Projectile" })
						
				for i, chargeStage in pairs( chargeStages ) do
					chargeStage.ProjectileProperties = chargeStage.ProjectileProperties or {}
					for key in pairs( data.RevertProjectileProperties ) do
						local baseValue = GetBaseDataValue({ Type = "Projectile", Name = baseProjectileName, Property = key })
						chargeStage.ProjectileProperties [key] = baseValue
					end
				end
			end
			if data.AddProjectileProperties and not IsEmpty(chargeStages) then
				chargeStages[1].ProjectileProperties = chargeStages[1].ProjectileProperties or {}
				for key, value in pairs( data.AddProjectileProperties) do
					if value == "null" then
						chargeStages[1].ProjectileProperties[key] = nil
					else
						chargeStages[1].ProjectileProperties[key] = value 
					end
				end
			end
			if data.AddProperty and not IsEmpty(chargeStages) and ( not data.AddProperty.RequiredWeapon or CurrentRun.Hero.Weapons[data.AddProperty.RequiredWeapon]) then
				for i, chargeStage in pairs( chargeStages ) do
					for key, value in pairs( data.AddProperty) do
						if key ~= "RequiredWeapon" then
							if value == "null" then
								chargeStage[key] = nil
							else
								chargeStage[key] = value 
							end
						end
					end
				end
			end
			if data.IncreaseNumProjectiles then	
				for i, chargeStage in pairs( chargeStages ) do
					if chargeStage.WeaponProperties then
						local value = chargeStage.WeaponProperties.NumProjectiles
						if value then
							chargeStage.WeaponProperties.NumProjectiles = chargeStage.WeaponProperties.NumProjectiles + data.IncreaseNumProjectiles.NumProjectiles
						end
					end
				end
			end
			if data.ChangeNumProjectilesToFuse and not appliedChanges.ChangeNumProjectilesToFuse then
				appliedChanges.ChangeNumProjectilesToFuse = true
				for i, chargeStage in pairs( chargeStages ) do
					if chargeStage.WeaponProperties then
						local value = chargeStage.WeaponProperties.NumProjectiles
						if value then
							chargeStage.WeaponProperties.NumProjectiles = 1
							chargeStage.ProjectileProperties = chargeStage.ProjectileProperties or {}
							chargeStage.ProjectileProperties.MaxDetonations = value
						end
					end
				end
			end
		end
	end

	for i, data in pairs( chargeStageModifiers ) do
		local validWeapon = data.ValidWeaponsLookup == nil or data.ValidWeaponsLookup[weaponData.Name]
		local validTrait = data.TraitName == nil or HeroHasTrait( data.TraitName )
		if validWeapon and validTrait then
			if data.HideStageReachedFxExceptForFinal then
				for i in pairs( chargeStages ) do
					chargeStages[i].HideStageReachedFx = true
				end
				chargeStages[#chargeStages].HideStageReachedFx = nil
			end
			if data.SkipToFinal and TableLength(chargeStages) > 1 then
				local newChargeStages = 
				{
					[1] = ShallowCopyTable(chargeStages[1]),
					[2] = ShallowCopyTable(chargeStages[#chargeStages]),
				}
				chargeStages = newChargeStages
			end
		end
	end
	local finalizedChargeStages = {}
	for i, data in ipairs( chargeStages ) do
		if not data.RequiredTraitName or HeroHasTrait( data.RequiredTraitName ) then
			table.insert(finalizedChargeStages, data )
		end
	end
	return finalizedChargeStages
end

function HasForceRelease( weaponData, stageData )
	local manaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )

	if stageData.ForceReleaseWithoutMana and manaCost > CurrentRun.Hero.Mana and not HeraManaRestoreEligible( stageData.ManaCost ) then
		return true
	end
	if stageData.ForceRelease and ( not stageData.BlockForceReleaseWithoutMana or manaCost <= CurrentRun.Hero.Mana or HeraManaRestoreEligible( stageData.ManaCost )) then
		return true
	end
	return false
end

function DoWeaponCharge( triggerArgs, weaponData, args )
	if weaponData.ArmedCastChargeStage and SessionMapState.CastArmDisabled then
		return
	end
	if CurrentRun.Hero.IsDead and CurrentHubRoom ~= nil and not CurrentHubRoom.AllowWeapons then
		return
	end
	if SessionMapState.BlockStagedCharge[weaponData.Name] then
		return
	end
	local weaponName = weaponData.Name
	local chargeStages = GetWeaponChargeStages( weaponData )
	local perfectChargeWindow = GetTotalHeroTraitValue("StagePerfectChargeWindow")

	MapState.WeaponCharge = MapState.WeaponCharge or {}
	MapState.WeaponCharge[ weaponName ] = 0
	SessionMapState.MaxChargeStageReached[ weaponName ] = false
	WeaponChargeStartPresentation( triggerArgs, weaponData, args )
	local completeObjectiveOnFire = nil

	local notifyName = "Empty"..weaponData.Name.."Stage"
	local stageReached = 0
	local maxStage = #chargeStages
	for stage = 1, maxStage do
		local stageData = chargeStages[stage]
		local startTime = _worldTime
		local manaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )
		while stageData.ManaCost and manaCost > CurrentRun.Hero.Mana and not HasForceRelease( weaponData, stageData ) and not HeraManaRestoreEligible( manaCost ) do
			SetManaIndicatorDisallowed( weaponName )
			NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = 0.25  })
			waitUntil( notifyName )
			local reachedCharge = (_worldTime - startTime) > stageData.Wait * GetLuaWeaponSpeedMultiplier( weaponName )
			if reachedCharge then
				thread( CallFunctionName, weaponData.OutOfManaFunctionName, weaponData, weaponData.OutOfManaFunctionArgs )
			end
			
			if not _eventTimeoutRecord[notifyName] then
				EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached], { OutOfMana = true, ReachedCharge = reachedCharge })
				return
			end
		end
		
		if manaCost > CurrentRun.Hero.Mana then
			SetManaIndicatorDisallowed( weaponName )
		else
			SetManaIndicatorAllowed( weaponName )
		end
		if GetWeaponChargeFraction({Name = weaponName}) <= 0 then
			EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached] )
			return
		end
		if stageData.ChannelSlowEventOnStart then
			notifyExistingWaiters( weaponData.CustomChannelSlowEvent )
		end

		WeaponChargeStageStartPresentation( triggerArgs, weaponData, args, stageData )
		local stageManaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost })
		if stageData.ExChargeAnimation and ( stageManaCost <= CurrentRun.Hero.Mana or HeraManaRestoreEligible( stageManaCost )) then
			SetAnimation({ Name = stageData.ExChargeAnimation, DestinationId = CurrentRun.Hero.ObjectId })
		end
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = stageData.Wait * GetLuaWeaponSpeedMultiplier( weaponName )  })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[notifyName] then
			EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached] )
			return
		end

		if stageData.ManaCost and stageManaCost > CurrentRun.Hero.Mana and HasForceRelease( weaponData, stageData )  and not HeraManaRestoreEligible( stageManaCost ) then
			CallFunctionName( weaponData.ChargeWeaponData.OnNoManaForceRelease, weaponName, stageData )
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "ForceControlRelease"})
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "cancelCharge"})

			NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=" })
			waitUntil( notifyName )
			local nextStageManaCost = 0
			if chargeStages[stageReached + 1] and chargeStages[stageReached + 1].ManaCost then
				nextStageManaCost = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[stageReached + 1].ManaCost } )
			end
			EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached], { OutOfMana = nextStageManaCost > CurrentRun.Hero.Mana , ReachedCharge = true } )
			return
		end
		
		if perfectChargeWindow > 0 then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "setPerfectChargeWindow", Parameters = { perfectChargeWindow }})
		end
		SessionMapState.MaxChargeStageReached[ weaponName ] = (stage == maxStage)
	
		WeaponChargeStageReachedPresentation( triggerArgs, weaponData, args, stageData, stage, maxStage )
		completeObjectiveOnFire = stageData.CompleteObjective
		
		if weaponData.ChargeWeaponData and weaponData.ChargeWeaponData.OnStageReachedFunctionName then
			ApplyWeaponChanges( CurrentRun.Hero, stageData, weaponData )
		end
		MapState.ManaChargeIndicatorCost = stageManaCost
		
		stageReached = stage
		MapState.WeaponCharge[ weaponName ] = stageReached
		if stageData.ChannelSlowEventOnEnter then
			notifyExistingWaiters( weaponData.CustomChannelSlowEvent )
		end
	end
	
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=" })
	waitUntil( notifyName )
	thread( MarkObjectiveComplete, completeObjectiveOnFire)
	EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached] )

end

function EmptyWeaponCharge( weaponData, stageReached, stageData, args )
	args = args or {}
	if stageReached >= 1 then
		if stageData.ManaCost then
			if not stageData.SkipManaSpendOnFire and ( not weaponData.CheckPostFireFail or not SessionMapState.FrameFlags[weaponData.Name.."PostFireFail"] ) then
				ManaDelta( -GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } ))
				SessionMapState.ChargeStageManaSpend[weaponData.Name] = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )
				if SessionMapState.PendingStageManaRefund[ weaponData.Name ] then
					ManaDelta( SessionMapState.PendingStageManaRefund[ weaponData.Name ] )
					SessionMapState.PendingStageManaRefund[ weaponData.Name ] = nil
				end
			end
		end
		Rumble({ RightFraction = 0.7, Duration = 0.3 })
		if weaponData.CompleteObjectivesOnStagedFire then
			thread( MarkObjectivesComplete, weaponData.CompleteObjectivesOnStagedFire )
		end
	elseif stageReached == 0 and args.OutOfMana and args.ReachedCharge then
		WeaponFailedNoManaPresentation( weaponData ) 
	end

	MapState.WeaponCharge[ weaponData.Name ] = nil
	if stageData and stageData.ForceRelease then
		if stageData and stageData.EnableEffects then
			for i, effectName in pairs( stageData.EnableEffects ) do
				SetEffectProperty({ WeaponName = weaponData.Name, EffectName = effectName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Active", Value = false })
			end
		end
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "ForceReleaseOnFire", Value = false })
	end
	if stageData and stageData.ApplyEffects then
		for i, effectName in pairs(stageData.ApplyEffects) do
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].EffectData})
		end
	end
	if weaponData.CustomChannelSlowEvent then
		killWaitUntilThreads( weaponData.CustomChannelSlowEvent)
	end
	if weaponData.ChargeWeaponData and weaponData.ChargeWeaponData.EmptyChargeFunctionName then
		local changedProjectile = false
		if MapState.WeaponDataValues and ( not stageData or not stageData.DeferRevert ) then
			for propertyName, propertyValue in pairs( MapState.WeaponDataValues[weaponData.Name] or {} ) do
				SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
				if propertyName == "Projectile" then
					changedProjectile = true
				end
			end
			MapState.WeaponDataValues[weaponData.Name] = nil
		end
		
		if MapState.ExRelativeProjectileProperties and ( not stageData or not stageData.DeferRevert ) then
			for _, propertyChange in pairs( MapState.ExRelativeProjectileProperties[weaponData.Name] or {} ) do
				ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, true, true )
			end
			MapState.ExRelativeProjectileProperties[weaponData.Name] = nil
		end
		if MapState.ProjectileDataValues and ( not stageData or not stageData.DeferRevert ) then
			for propertyName, propertyValue in pairs( MapState.ProjectileDataValues[weaponData.Name] or {} ) do
				if propertyValue == "" then
					propertyValue = "null"
				end
				if not changedProjectile then
					SetProjectileProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })		
				end
			end
			MapState.ProjectileDataValues[weaponData.Name] = nil
		end
		CallFunctionName( weaponData.ChargeWeaponData.EmptyChargeFunctionName, weaponData.Name, stageReached, stageData )
		
		if changedProjectile and stageReached > 0 then
			ApplyProjectilePropertyChanges( ToLookup({ weaponData.Name }), SessionState.PropertyChangeList.ProjectileChanges )
		end
	end

	if weaponData.ChargeWeaponData and weaponData.ChargeWeaponData.EmptyChargeAnim and not args.OutOfMana and stageReached > 0 then
		if not IsEmpty(weaponData.ChargeWeaponData.EmptyChargeAnims) and weaponData.ChargeWeaponData.EmptyChargeAnims[stageReached] then
			SetAnimation({ Name = weaponData.ChargeWeaponData.EmptyChargeAnims[stageReached], DestinationId = CurrentRun.Hero.ObjectId })
		else
			SetAnimation({ Name = weaponData.ChargeWeaponData.EmptyChargeAnim, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end


function CheckAxeSpinDisable( unit, weaponData, args, triggerArgs )
	if not triggerArgs.NumProjectiles or triggerArgs.NumProjectiles == 0 then
		ClearEffect({ Id = unit.ObjectId, Name = "IndependentAxeSpinSelfFireSlow"})
		ClearEffect({ Id = unit.ObjectId, Name = "IndependentAxeSpinAttackDisableCancellable"})
		ClearEffect({ Id = unit.ObjectId, Name = "AxeSpinSelfFireSlow"})
		ClearEffect({ Id = unit.ObjectId, Name = "AxeSpinMoveStop"})
		ClearEffect({ Id = unit.ObjectId, Name = "AxeSpinAttackDisableCancellable"})
		ClearEffect({ Id = unit.ObjectId, Name = "AxeSpinAttackDisable"})
	end
end

function AxeBlockStartCharge()
	SetPlayerUninterruptible("AxeBlockCharge")
end

function AxeBlockChargeStage( weaponName, stageData )
end

function EmptyAxeBlockCharge( weaponName, stageReached, stageData )
	if stageData then
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		MapState.QueuedAxeBlockManaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )
		if stageData.DeferSwap then
			weaponName = stageData.DeferSwap
		end
		MapState.FullManaAtFireStart[weaponName] = CurrentRun.Hero.Mana >= GetHeroMaxAvailableMana()
		SessionMapState.ChargeStageManaSpend[weaponName] = MapState.QueuedAxeBlockManaCost
	end
	SetPlayerInterruptible("AxeBlockCharge")
end

function SpendQueuedMana()
	if 	MapState.QueuedAxeBlockManaCost then
		ManaDelta( -MapState.QueuedAxeBlockManaCost)
		MapState.QueuedAxeBlockManaCost = nil
	end
end

function EndDashDisableForce( )
	SessionMapState.CancelSuitExBlinkForce = nil
end

function CheckAxeBlockThread( )
	thread( NotifyOnAxeBlock )
end

function NotifyOnAxeBlock()
	local weaponName = "WeaponAxeBlock2"
	local notifyName = "AxeBlockUp"
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	local chargeStages = GetWeaponChargeStages( weaponData )
	
	NotifyOnWeaponCharge({Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<="})
	waitUntil( notifyName )
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "ShieldFireDisableAttack" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "ShieldFireDisableMove" })
	if MapState.WeaponCharge and MapState.WeaponCharge[weaponName] and MapState.WeaponCharge[weaponName] > 0 and chargeStages[MapState.WeaponCharge[weaponName]].DeferSwap then
	
		local stageData = chargeStages[MapState.WeaponCharge[weaponName]]
		MapState.WeaponDataValues = MapState.WeaponDataValues or {}
		local stageWeaponName = stageData.DeferSwap

		if MapState.WeaponDataValues then
			for propertyName, propertyValue in pairs( MapState.WeaponDataValues[stageWeaponName] or {} ) do
				SetWeaponProperty({ WeaponName = stageWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
			
			end
			MapState.WeaponDataValues[stageWeaponName] = nil
		end

		for propertyName, propertyValue in pairs( stageData.WeaponProperties or {} ) do
			MapState.WeaponDataValues[ stageWeaponName ] = MapState.WeaponDataValues[ stageWeaponName ] or {}
			if propertyName ~= "ReportValues" then
				if not MapState.WeaponDataValues[stageWeaponName][propertyName] then
					MapState.WeaponDataValues[stageWeaponName][propertyName] = GetWeaponDataValue({ WeaponName = stageWeaponName, Id = CurrentRun.Hero.ObjectId, Property = propertyName })
				end
				SetWeaponProperty({ WeaponName = stageWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
			end
		end
		FireWeaponFromUnit({ Weapon = stageData.DeferSwap, Id = CurrentRun.Hero.ObjectId, ClearAllFireRequests = true })
	end	
end

function ApplyWeaponChanges( unit, stageData, weaponData )
	local weaponName = weaponData.Name
	if stageData.ForceRelease then
		if stageData.EnableEffects then
			for i, effectName in pairs( stageData.EnableEffects ) do
				SetEffectProperty({ WeaponName = weaponName, EffectName = effectName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Active", Value = true })
			end
		end
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "ForceControlRelease"})
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "ForceReleaseOnFire", Value = true })
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "PriorityFireRequest", Value = true})
		if stageData.FireScreenshake then	
			thread( DoWeaponScreenshake, stageData, "FireScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = stageData.ProjectileName })
		end
	end

	if stageData.SwapWeapon and stageData.SwapWeapon ~= "null" then
		SwapWeapon({ Name = weaponName, SwapWeaponName = stageData.SwapWeapon, DestinationId = CurrentRun.Hero.ObjectId })
	end
			
	MapState.WeaponDataValues = MapState.WeaponDataValues or {}
	local stageWeaponName = stageData.SwapWeapon or weaponName
	for propertyName, propertyValue in pairs( stageData.WeaponProperties or {} ) do
		MapState.WeaponDataValues[ stageWeaponName ] = MapState.WeaponDataValues[ stageWeaponName ] or {}
		if propertyName ~= "ReportValues" then
			if not MapState.WeaponDataValues[stageWeaponName][propertyName] then
				MapState.WeaponDataValues[stageWeaponName][propertyName] = GetWeaponDataValue({ WeaponName = stageWeaponName, Id = CurrentRun.Hero.ObjectId, Property = propertyName })
			end
			if not stageData.DeferApply then
				SetWeaponProperty({ WeaponName = stageWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
			end
		end
	end
	
	MapState.ExRelativeProjectileProperties = MapState.ExRelativeProjectileProperties or {}
	for propertyName, propertyChangeData in pairs( stageData.RelativeWeaponProperties or {} ) do
		MapState.ExRelativeProjectileProperties[ stageWeaponName ] = MapState.ExRelativeProjectileProperties[ stageWeaponName ] or {}
		if propertyName ~= "ReportValues" then
			if not stageData.DeferApply then
				local propertyChange = { WeaponName = stageWeaponName, DestinationId = CurrentRun.Hero.ObjectId, WeaponProperty = propertyName, ChangeValue = propertyChangeData.Value, ChangeType = propertyChangeData.ChangeType }
				table.insert( MapState.ExRelativeProjectileProperties[ stageWeaponName ], propertyChange )
				ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, true )
			end
		end
	end
			
			
	for propertyName, propertyValue in pairs( stageData.ProjectileProperties or {} ) do
		MapState.ProjectileDataValues = MapState.ProjectileDataValues or {}
		MapState.ProjectileDataValues[ stageWeaponName ] = MapState.ProjectileDataValues[ stageWeaponName ] or {}

		if propertyName ~= "ReportValues" then
			if not MapState.ProjectileDataValues[stageWeaponName][propertyName] then
				MapState.ProjectileDataValues[stageWeaponName][propertyName] = GetProjectileDataValue({ WeaponName = stageWeaponName, Id = CurrentRun.Hero.ObjectId, Property = propertyName })
			end
			if not stageData.DeferApply then
				SetProjectileProperty({ WeaponName = stageWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })		
			end
		end
	end
	CallFunctionName( weaponData.ChargeWeaponData.OnStageReachedFunctionName, weaponName, stageData )
	if MapState.WeaponDataValues[weaponName] and MapState.WeaponDataValues[weaponName].Projectile then
		local weaponNameLookup = ToLookup({ weaponName })
		ApplyProjectilePropertyChanges( weaponNameLookup, SessionState.PropertyChangeList.ProjectileChanges)
	end
end

function RevertWeaponChanges( unit, weaponData )
	local weaponName = weaponData.Name
	local hasChangedProjectile = false
	if MapState.WeaponDataValues then
		for propertyName, propertyValue in pairs( MapState.WeaponDataValues[weaponName] or {} ) do
			SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
			if propertyName == "Projectile" then
				hasChangedProjectile = true
			end
		end
		MapState.WeaponDataValues[weaponName] = nil
	end
	if MapState.ExRelativeProjectileProperties then
		for _, propertyChange in pairs( MapState.ExRelativeProjectileProperties[weaponName] or {} ) do
			ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, true, true )
		end
		MapState.ExRelativeProjectileProperties[weaponName] = nil
	end
	if MapState.ProjectileDataValues then
		for propertyName, propertyValue in pairs( MapState.ProjectileDataValues[weaponName] or {} ) do
			if propertyValue == "" then
				propertyValue = "null"
			end
			if not hasChangedProjectile then
				SetProjectileProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })		
			end
		end
		MapState.ProjectileDataValues[weaponName] = nil
	end
end

function AxeChargeStage( weaponName, stageData )
end

function EmptyAxeCharge( weaponName,  stageReached, stageData )
	if stageData and stageData.ForceRelease then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "PriorityFireRequest", Value = false})
	end
end

function AllowAxeSpin()
	SetWeaponProperty({ WeaponName = "WeaponAxeSpin", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
end

function HasDisjointedCast()
	local weaponFireOverrides = {}
	for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
		weaponFireOverrides = MergeTables( weaponFireOverrides, data )
	end
	for weaponName, overriddenFireName in pairs( weaponFireOverrides ) do
		if overriddenFireName == "WeaponCast" then
			return true
		end
	end
	return false
end

function CheckSpinControl( unit, weaponData, triggerArgs )
	if not triggerArgs.DidFire then
		local weaponFireOverrides = {}
		for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
			weaponFireOverrides = MergeTables( weaponFireOverrides, data )
		end
		local castOverridden = "WeaponCast"
		for weaponName, overriddenFireName in pairs( weaponFireOverrides ) do
			if overriddenFireName == "WeaponCast" then
				castOverridden = weaponName
			end
		end
		AddWeaponControl({ DestinationId = unit.ObjectId, Name = castOverridden })

		for i, traitData in pairs( CurrentRun.Hero.Traits ) do
			if traitData.Slot == "Spell" and not IsEmpty(traitData.PreEquipWeapons) then		
				AddWeaponControl({ DestinationId = CurrentRun.Hero.ObjectId, Name = traitData.PreEquipWeapons[1] })
			end
		end
	end
end

function DaggerChargeStage( weaponName, stageData )
	if not HeroHasTrait("DaggerSpecialLineTrait") then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AutoLock", Value = false })
	end
end

function EmptyDaggerCharge( weaponName )
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AutoLock", Value = true })
end


function SprintChargeStage( weaponName, stageData )
	MapState.ChargedManaWeapons[weaponName] = true
	local effectName = stageData.EffectName
	if effectName then
		ApplyEffect({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
	end
	thread( NyxBuffReadyPresentation )
end

function EmptySprintCharge( weaponName, stageReached, stageData )
	if stageData and stageData.EffectName then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = stageData.EffectName })
	end
	
	thread( NyxBuffReadyEndPresentation )
end

function StartHephSprintPresentation( weaponData )
	if CurrentRun.Hero.Mana > GetManaCost( weaponData, false ) then
		CreateAnimation({ Name = "HephMassiveHitHammerSprint", DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function CastChargeStage( weaponName, stageData )
	if stageData.ForceRelease then
		SessionMapState.SuperchargeCast = true 
	else
		SessionMapState.SuperchargeCast = nil
	end
end

function EmptyCastCharge( weaponName, stageReached )
end

function IndirectCastChargeStage( weaponName, stageData )
	if stageData.SuperCharge then
		SessionMapState.SuperchargeCast = true
	else
		SessionMapState.SuperchargeCast = nil
	end
	if stageData.ManaCost then
		SessionMapState.ArmCast = true
	else
		SessionMapState.ArmCast = nil
	end
end

function EmptyIndirectCastCharge( weaponName, stageReached )
end

function StaffChargeStage( weaponName, stageData )
end

function EmptyStaffCharge( weaponName, stageReached )
end

function LobChargeStage( weaponName, stageData )
	UpdateAttackTarget({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName})
end

function EmptyLobCharge( weaponName, stageReached )
end

function ThrowChargeStage( weaponName, stageData )
	SessionMapState.ThrowWeaponCharged = true
end

function DoThrowEx( weaponName )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	
	if HasHeroTraitValue("LobExSpecialRecall") then
		local ammoIds = GetIdsByType({ Name = "LobAmmoPack" })
		SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationIds = ammoIds })
		SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = 2000, DestinationIds = ammoIds })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = "ProjectileThrowCharged",
			WeaponName = weaponName,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		for _, ammoId in pairs(ammoIds) do
			local angle = GetAngleBetween({ Id = ammoId, DestinationId = CurrentRun.Hero.ObjectId })
			local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
			AttachProjectiles({ Ids = { projectileId }, DestinationId = ammoId })
		end
	end
	AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "StasisStun"})
	while ( SessionMapState.ThrowWeaponDeferred or SessionMapState.ActiveSkullImpulse ) and not MapState.HostilePolymorph do
		local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = "ProjectileThrowCharged",
			WeaponName = weaponName,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		CreateProjectileFromUnit({ WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle + 90, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12 })
		--if not HeroHasTrait("LobOneSideTrait") then
			CreateProjectileFromUnit({ WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle - 90,DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12  })
		--end
		local lowestSimSpeed = GetLowestSimSpeed({"WeaponFire", "WeaponHit", "WeaponCancelEffect",})
		if weaponData.MinSimSpeedAdjustValue and lowestSimSpeed < weaponData.MinSimSpeedAdjustValue then
			lowestSimSpeed = weaponData.MinSimSpeedAdjustValue
		end
	
		waitUnmodified( MapState.ThrowWeaponInterval / lowestSimSpeed / GetPlayerGameplayElapsedTimeMultiplier(), RoomThreadName)
	end
	RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "StasisStun"})
	
end

function EmptyThrowCharge( weaponName, stageReached )

	SessionMapState.ThrowWeaponCharged = nil
	if stageReached > 0 and MapState.LobCharge then
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		local chargeStages = GetWeaponChargeStages( weaponData )
		local manaCost =GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[stageReached].ManaCost}) 
		ManaDelta( -manaCost)
		SessionMapState.ChargeStageManaSpend[weaponData.Name] = manaCost
			
		SessionMapState.ThrowWeaponDeferred = true
		MapState.ThrowWeaponInterval = 0.1
		if HeroHasTrait("LobImpulseAspect") then
			local traitData = GetHeroTrait("LobImpulseAspect")
			if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
				MapState.ThrowWeaponInterval = traitData.OnWeaponFiredFunctions.FunctionArgs.Interval or 0.1
			end
		end
		thread(DoThrowEx, weaponName )
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "LobWeaponInvulnerable", DataProperties = EffectData.LobWeaponInvulnerable.EffectData})
	else	
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "LobWeaponShortInvulnerable", DataProperties = EffectData.LobWeaponShortInvulnerable.EffectData})
	end
end

function ThrowAspectChargeStage( weaponName, stageData )
end

function EmptyThrowAspectCharge( weaponName, stageReached )
end

function AllowLobLock()
	AddLobWeaponLockLayer("Charge")
end

function RecordWeaponCharge( unit, weaponData, args, triggerArgs )
	MapState.LobCharge = triggerArgs.Charge
	
	for i, effectName in pairs(weaponData.ScaledFireEndEffects or {}) do
		local effectData = DeepCopyTable(EffectData[effectName].EffectData)
		effectData.Duration = 3600
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = effectData })
	end
end

OnBlinkFinished{ "WeaponBlink",
	function(triggerArgs) 
		SetWeaponProperty({ WeaponName = "WeaponSuitCharged", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponAxeSpecialSwing", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponAxeSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponTorchSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponLobSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		SetWeaponProperty({ WeaponName = "WeaponStaffBall", DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
		local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon())
		if equippedWeaponData.EndEffectsOnBlink then
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Names = equippedWeaponData.EndEffectsOnBlink })
		end
		CheckAutoSprintEnd()
		for _, actionData in pairs( GetHeroTraitValues( "OnBlinkEndAction" ) ) do
			if _G[actionData.FunctionName] ~= nil then
				_G[actionData.FunctionName]( ShallowCopyTable( actionData.FunctionArgs ), triggerArgs)
			end
		end
	end
}

OnBlinkFinished{ "WeaponLobSpecial",
	function(triggerArgs) 
		local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" )
		if MapState.LobCharge then
			for i, effectName in pairs(weaponData.ScaledFireEndEffects or {}) do
				local effectData = DeepCopyTable(EffectData[effectName].EffectData)
				if EffectData[effectName].MaxDuration then
					effectData.Duration = EffectData[effectName].MaxDuration * MapState.LobCharge
				end
				ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = effectData })
			end
			MapState.LobCharge = nil
		end

		if HeroHasTrait("LobCloseAttackAspect") and triggerArgs.Blocked then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
		end
		
		if HeroHasTrait("LobSturdySpecialTrait") then
			EndLobSturdy()
		end

		if SessionMapState.ThrowWeaponDeferred then
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "LobWeaponInvulnerable"})
			
			if HeroHasTrait("LobImpulseAspect") then
				thread(CheckSkullImpulseStart)
			end
			SessionMapState.ThrowWeaponDeferred = false
			ApplyDeferredThrowReversions( GetWeaponData( CurrentRun.Hero, "WeaponLobSpecial" ))
		end
		local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "ChargeTime" })
		local minCharge = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "MinChargeToFire" })
		waitUnmodified( chargeTime * minCharge )
		RemoveLobWeaponLockLayer("Charge")	
	end
}

OnWeaponChargeCanceled{ "WeaponLobSpecial",
	function(triggerArgs)
		if not triggerArgs.PostFire then
			RemoveLobWeaponLockLayer("Charge")	
		end
	end
}

function TriggerLockForSpecial()
	AddLobWeaponLockLayer("PrimaryCharge")
	local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "ChargeTime" })
	local minCharge = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLob", Property = "MinChargeToFire" })
	waitUnmodified(chargeTime * minCharge)
	RemoveLobWeaponLockLayer("PrimaryCharge")	
end

function ApplyDeferredThrowReversions( weaponData )
	local changedProjectile = false
	if MapState.WeaponDataValues then
		for propertyName, propertyValue in pairs( MapState.WeaponDataValues[weaponData.Name] or {} ) do
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
			if propertyName == "Projectile" then
				changedProjectile = true
			end
		end
		MapState.WeaponDataValues[weaponData.Name] = nil
	end
	if MapState.ProjectileDataValues then
		for propertyName, propertyValue in pairs( MapState.ProjectileDataValues[weaponData.Name] or {} ) do
			if propertyValue == "" then
				propertyValue = "null"
			end
			SetProjectileProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })		
		end
		MapState.ProjectileDataValues[weaponData.Name] = nil
	end
		
	if changedProjectile then
		ApplyProjectilePropertyChanges( ToLookup({ weaponData.Name }), SessionState.PropertyChangeList.ProjectileChanges )
	end
end

function TorchChargeStage( weaponName, stageData )
end

function EmptyTorchCharge( weaponName, stageReached )

	if HeroHasTrait("TorchAutofireAspect") and stageReached == 1 then
		local torchTrait = GetHeroTrait("TorchAutofireAspect")
		local fireAnimationName =  GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName , Property = "FireGraphic" })
		SetAnimation({ Name = fireAnimationName, DestinationId = CurrentRun.Hero.ObjectId })

		thread( TorchExEmpowerSetup, torchTrait.SetupFunction.Args )
	end
end

function TorchExEmpowerSetup( args )
	local threadName = "TorchExEmpower"
	if SetThreadWait( threadName, args.PrimaryExInterval ) then
		return
	end
	CreateAnimation({ Name = args.PrimaryExVfx, DestinationId = CurrentRun.Hero.ObjectId })
	SessionMapState.EmpoweredEx = true
	waitUnmodified( args.PrimaryExInterval, threadName )
	SessionMapState.EmpoweredEx = false
	StopAnimation({ Name = args.PrimaryExVfx, DestinationId = CurrentRun.Hero.ObjectId })
end


function TorchSpecialChargeStage( weaponName, stageData )
end

function TorchHasMana ( weaponData )
	if SessionMapState.TorchOutOfMana then
		SessionMapState.TorchOutOfMana = nil
		if MapState.WeaponCharge and MapState.WeaponCharge[weaponData.Name] and MapState.WeaponCharge[weaponData.Name] > 0 then
			local chargeStages = GetWeaponChargeStages( weaponData )
			ApplyWeaponChanges( CurrentRun.Hero, chargeStages[MapState.WeaponCharge[weaponData.Name]], weaponData )
		end
	end
end

function TorchOutOfMana( weaponData )
	RevertWeaponChanges( CurrentRun.Hero, weaponData )
	ApplyProjectilePropertyChanges( ToLookup({ weaponData.Name }), SessionState.PropertyChangeList.ProjectileChanges )
	SessionMapState.TorchOutOfMana = true	
end

function EmptyTorchSpecialCharge( weaponName, stageReached )
	if HeroHasTrait("TorchAutofireAspect") and stageReached == 1 then
		local torchTrait = GetHeroTrait("TorchAutofireAspect")
		local specialData = torchTrait.SetupFunction.Args
		for _, projectileId in pairs( SessionMapState.TorchOrbitIds ) do
			SetProjectileProperty({ ProjectileId = projectileId, Property = "Range", Value = specialData.SpecialExRange})
			SetProjectileProperty({ ProjectileId = projectileId, Property = "ArcEnd", Value = specialData.SpecialExDurationMultiplier, ValueChangeType = "Multiply"})
		end
	end
end

function TorchRepeatedFire( unit, weaponData, functionArgs, triggerArgs )
	if HeroHasTrait("TorchAutofireAspect") then
		return
	end
	IncrementTableValue( MapState, "TorchFireIndex")
	IncrementTableValue( MapState, "TorchDetonations")
	if functionArgs.SequencedAnimations then
		if MapState.TorchFireIndex > #functionArgs.SequencedAnimations then
			MapState.TorchFireIndex = 1
		end
		local sequenceData = functionArgs.SequencedAnimations[ MapState.TorchFireIndex ]
		for weaponProperty, value in pairs(sequenceData) do
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = weaponProperty, Value = value })
		end
	end
	if MapState.WeaponCharge and MapState.WeaponCharge[weaponData.Name] and MapState.WeaponCharge[weaponData.Name] > 0 then
		local chargeStages = GetWeaponChargeStages( weaponData )
		local cost = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost })
		local weaponName = weaponData.Name
		if CurrentRun.Hero.Mana >= cost or HeraManaRestoreEligible(cost) then
			if CurrentRun.Hero.Mana >= cost then
				SetManaIndicatorAllowed( weaponName )
				PulseManaIndicator()
			else
				SetManaIndicatorDisallowed( weaponName, false, GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost }) )
			end
			local manaSpend = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost}) 
			ManaDelta( -manaSpend )
			SessionMapState.ChargeStageManaSpend[weaponName] = manaSpend
		else
			if weaponData.OnHasNoManaFunctionName then
				thread( CallFunctionName, weaponData.OnHasNoManaFunctionName, weaponData )
			end
			thread( CallFunctionName, weaponData.OutOfManaFunctionName, weaponData, weaponData.OutOfManaFunctionArgs )
			SetManaIndicatorDisallowed( weaponName, false, GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost }) )
			MapState.WeaponCharge[weaponName] = 0
		end
	end
end


function ResetFireSequence( unit, weaponData )
	if HeroHasTrait("TorchAutofireAspect") then
		return
	end
	if weaponData.OnFiredFunctionArgs and not IsEmpty(weaponData.OnFiredFunctionArgs.SequencedAnimations) then
		MapState.TorchFireIndex = 1	
		local initialSequence = weaponData.OnFiredFunctionArgs.SequencedAnimations[1]
		if weaponData.OnFiredFunctionArgs.StartingAnimation then
			initialSequence = weaponData.OnFiredFunctionArgs.StartingAnimation
		end
		for propertyName, propertyValue in pairs(initialSequence) do
			SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = propertyValue })
		end
	end
end

function SetThrowTeleportBuffer()
	if ProjectileExists({ Names = { "ProjectileThrow" }}) then
		MapState.BufferRush  = true
	end
end

OnWeaponFired{ "WeaponLob",
	function( triggerArgs )
		SessionMapState.AmmoAtFireStart = GetCurrentAmmo( triggerArgs.name )
		if HeroHasTrait("LobSpreadShotTrait") then
			UpdateWeaponAmmo( triggerArgs.name, -triggerArgs.NumProjectiles)
		else
			SpendAmmo( triggerArgs.name )	
		end
		thread( UpdateAmmoUI )
	end
}

function WeaponLobAmmoDrop( triggerArgs, weaponDataArgs )
	if triggerArgs.BlockSpawns or ( triggerArgs.ProjectileWave and triggerArgs.ProjectileWave > 0) or triggerArgs.BonusProjectileWave then
		return
	end
	local consumableId = SpawnObstacle({ Name = "LobAmmoPack", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Group = "Standing" })
	local consumable = CreateConsumableItem( consumableId, "LobAmmoPack" )
	local magnetismMultiplier = GetTotalHeroTraitValue("AmmoMagnetismMultiplier", { IsMultiplier = true })
	SetObstacleProperty({ Property = "Magnetism", Value = magnetismMultiplier, DestinationId = consumableId, ValueChangeType = "Multiply" })
	local ammoDropData = weaponDataArgs.DropForces
	consumable.ProjectileVolley = triggerArgs.ProjectileVolley
	if triggerArgs.HasImpact ~= nil and weaponDataArgs.CollideForces then
		ammoDropData = weaponDataArgs.CollideForces
	end
	ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.UpwardForceMin or 0, ammoDropData.UpwardForceMax or 0 ) })
	if ammoDropData.ForceMax ~= nil then
		local scatter = 0
		if ammoDropData.Scatter then
			scatter = RandomFloat( -(ammoDropData.Scatter)/2, (ammoDropData.Scatter)/2)
		end
		ApplyForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.ForceMin, ammoDropData.ForceMax ), Angle = triggerArgs.Angle + scatter, SelfApplied = true })
	end
	thread( EscalateMagnetism, consumable )
end

function CheckLobPulse ( touchdowner, functionArgs, triggerArgs )
	if touchdowner and touchdowner.Name == "LobAmmoPack" and not triggerArgs.Magnetized then
		local currentVolley = GetWeaponProperty({Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponLobPulse", Property = "Volley" }) + 1
		if HeroHasTrait("LobAmmoBoostAspect") and touchdowner.ProjectileVolley and SessionMapState.AmmoVolleys[ touchdowner.ProjectileVolley ] then
			SessionMapState.PulseAmmoVolleys[currentVolley] = { AmmoCount = SessionMapState.AmmoVolleys[ touchdowner.ProjectileVolley ].AmmoCount, Count = 1 }
		end	
		FireWeaponFromUnit({ Weapon = "WeaponLobPulse", Id = CurrentRun.Hero.ObjectId, DestinationId = touchdowner.ObjectId, FireFromTarget = true })
	end
end

function FireAmmoCollectionPulse( weaponName, args )
	if args and args.ManaCost then
		local cost = args.ManaCost
		if cost > CurrentRun.Hero.Mana and not HeraManaRestoreEligible( cost ) then
			return
		else
			ManaDelta(-cost)
		end
	end
	FireWeaponFromUnit({ Weapon = args.PulseWeaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	
end

function UpdateLobWeaponProjectileNum( triggerArgs, weaponData )
	local weaponName = weaponData.Name
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = GetCurrentAmmo(weaponName) })
end

function CheckSprintBoons( triggerArgs )
	
	local enemyIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = 250 })

	for _, dashData in pairs( GetHeroTraitValues( "OnSprintAction" ) ) do
		
		if _G[dashData.FunctionName] ~= nil then
			if dashData.RunOnce then
				_G[dashData.FunctionName]( ShallowCopyTable( dashData.Args ), triggerArgs )
			elseif not IsEmpty(enemyIds) then
				for i, id in pairs( enemyIds ) do
					if ActiveEnemies[id] then
						_G[dashData.FunctionName](ActiveEnemies[id], ShallowCopyTable( dashData.Args ), triggerArgs )
					end
				end
			end
		elseif not IsEmpty(enemyIds) then
			local effectNames = ShallowCopyTable( dashData.EffectNames ) or {}
			local effectArgs = ShallowCopyTable( dashData.Args ) or {}
			if dashData.EffectName then
				table.insert( effectNames, dashData.EffectName )
				table.insert( effectArgs, dashData.Args )
			end

			for i, effectName in pairs( effectNames ) do
				local dataProperties = MergeTables(EffectData[effectName].EffectData, effectArgs[i] )
				ApplyEffect({ DestinationIds = enemyIds, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
			end
		end
	end
end

function ShieldBlock( triggerArgs, functionArgs )
	local attacker = triggerArgs.Attacker
	local blockingWeaponName = triggerArgs.WeaponName
	if not functionArgs.MaxDistance or ( triggerArgs.DistanceSquared and triggerArgs.DistanceSquared <= ( functionArgs.MaxDistance * functionArgs.MaxDistance )) then
		ApplyEffect({ DestinationId = attacker.ObjectId, Id = attacker.ObjectId, EffectName = functionArgs.EffectName , DataProperties = EffectData[functionArgs.EffectName].EffectData })
	end
end

function FireCastAtLocation( triggerArgs )
	if triggerArgs.LocationX and triggerArgs.LocationY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		FireWeaponFromUnit({ Weapon = "WeaponCast", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		Destroy({Id = dropLocation })
	end 		
end

function FireAnywhereCastAtLocation( owner, weaponData, functionArgs, triggerArgs )
	if triggerArgs.ProjectileX and triggerArgs.ProjectileY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY  })
		FireWeaponFromUnit({ Weapon = "WeaponCast", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		local doubleBoltChance = GetTotalHeroTraitValue("DoubleBoltChance")
		if RandomChance(doubleBoltChance) then
			wait(0.3, RoomThreadName)
			local derivedValues = GetDerivedPropertyChangeValues({
				ProjectileName = "ZeusCastAnywhereBlast",
				WeaponName = "WeaponAnywhereCast",
				Type = "Projectile",
			})
			CreateProjectileFromUnit({ Name = "ZeusCastAnywhereBlast", WeaponName = "WeaponAnywhereCast", DataProperties = derivedValues.PropertyChanges ,DestinationId = dropLocation, Id = CurrentRun.Hero.ObjectId, FireFromTarget = true})
		end
		Destroy({Id = dropLocation })
	end 		
end

function TorchRingReturn( unit, weaponData, args, triggerArgs )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = args.WeaponName, Method = "RecallProjectiles" })
end

function BlockDashDisable( triggerArgs, weaponData )
	if not weaponData then
		return
	end
	AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "DashAttackQueue" })
	local notifyName = "blockDashNotify"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=" })
	waitUntil( notifyName )
	
	RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "DashAttackQueue" })
end


function MarkTorchTarget( triggerArgs, weaponData, args )
	MapState.TorchCharging = true
	args = args or {}
	local arc = nil
	if args.AutoLockArc then
		arc = math.rad(args.AutoLockArc)
	end
	local notifyName = "TorchNotCharging"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=" })
	thread( RemoveTorchTarget, notifyName )
	while MapState.TorchCharging do
		local targetId = GetAutoLockId({ Id = CurrentRun.Hero.ObjectId, Arc = arc, Range = args.Range })
		if targetId ~= 0 and ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
			if MapState.MarkEnemyId ~= targetId then
				MapState.MarkEnemyId = targetId
				if MapState.MarkedTargetId  then
					Destroy({ Id = MapState.MarkedTargetId   })
				end
			
				MapState.MarkedTargetId  = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId })
				SetAnimation({ Name = "DaggerMarkStatus", DestinationId = MapState.MarkedTargetId  })
				Attach({ Id = MapState.MarkedTargetId , DestinationId = targetId })
			end
		elseif MapState.MarkedTargetId  then
			Destroy({ Id = MapState.MarkedTargetId  })
			MapState.MarkEnemyId = nil
		end
		wait(0.1)
	end
end

function RemoveTorchTarget( notifyName )
	waitUntil( notifyName )
	MapState.TorchCharging = false
	MapState.MarkEnemyId = nil
	if MapState.MarkedTargetId then
		Destroy({ Id = MapState.MarkedTargetId  })
	end
end

function ProjectileClearUnitHit( projectileId, name )
	if not projectileId then
		return
	end
	if not SessionMapState.FirstHitRecord[projectileId] then
		SessionMapState.FirstHitRecord[projectileId] = {}
	end
	SessionMapState.FirstHitRecord[projectileId][name] = nil
end

function ProjectileRecordUnitHit( projectileId, name )
	if not projectileId then
		return
	end
	if not SessionMapState.FirstHitRecord[projectileId] then
		SessionMapState.FirstHitRecord[projectileId] = {}
	end
	SessionMapState.FirstHitRecord[projectileId][name] = true
end

function ProjectileHasUnitHit( projectileId, name )
	if not projectileId then
		return false
	end
	if not SessionMapState.FirstHitRecord[projectileId] then
		return false
	end
	return SessionMapState.FirstHitRecord[projectileId][name]
end
function SuitHaltPlayer()
	waitUnmodified(0.1, RoomThreadName)
	Halt({ Id = CurrentRun.Hero.ObjectId })
end

function ApplySprintSpeedIncrease( source, args )
	if SessionMapState.SuitSpeedIncrease then
		return
	end
	ApplyUnitPropertyChanges( CurrentRun.Hero, args.PropertyChanges )
	SessionMapState.SuitSpeedIncrease = ShallowCopyTable( args.PropertyChanges)
end

function RemoveMissileMark( victim, args, triggerArgs )
	if not IsEmpty(SessionMapState.QueuedEnemies) then
		for enemyId, queuedProjectiles in pairs(SessionMapState.QueuedEnemies) do
			if queuedProjectiles[ triggerArgs.ProjectileId ] then
				queuedProjectiles[ triggerArgs.ProjectileId ] = nil
				if not IsEmpty(SessionMapState.MarkImages[enemyId]) then
					local id = table.remove(SessionMapState.MarkImages[enemyId])
					Destroy({ Id = id })
				end
			end
		end
	end
end

function WeaponSuitAmmoTransform( triggerArgs, weaponDataArgs )
	if triggerArgs.ProjectileId and not HeroHasTrait("SuitMarkCritAspect") then
		SessionMapState.ExistingMissileTargetIds[ triggerArgs.ProjectileId ] = nil
	end
	if triggerArgs.BlockSpawns then
		return
	end
	if not IsEmpty(SessionMapState.QueuedEnemies) then
		for enemyId, queuedProjectiles in pairs(SessionMapState.QueuedEnemies) do
			if queuedProjectiles[ triggerArgs.ProjectileId ] then
				queuedProjectiles[ triggerArgs.ProjectileId ] = nil
				if not IsEmpty(SessionMapState.MarkImages[enemyId]) then
					local id = table.remove(SessionMapState.MarkImages[enemyId])
					Destroy({ Id = id })
				end
			end
		end
	end
	if triggerArgs.HasImpact or not weaponDataArgs[triggerArgs.name] then
		return
	end
	local projectileData = weaponDataArgs[triggerArgs.name]
	local projectileName = projectileData.Name
	local dataProjectileName = projectileData.UseProjectileName or projectileName
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = triggerArgs.WeaponName ,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	local enemyId = nil
	if projectileData.UseMarks and not IsEmpty(SessionMapState.TargetedEnemies) and not SessionState.FreeSeekProjectileIds[triggerArgs.ProjectileId] then
		enemyId = table.remove(SessionMapState.TargetedEnemies)
		if enemyId then
			SessionMapState.QueuedEnemies[enemyId] = SessionMapState.QueuedEnemies[enemyId] or {}
		end
	end
	if projectileData.PrioritizeDifferent then
		local eligibleTargets = {}
		local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSuitRanged" )
		enemyId = GetClosest(
			{ 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationName = "EnemyTeam", 
				IgnoreInvulnerable = true, 
				IgnoreHomingIneligible = true, 
				IgnoreSelf = true, 
				ExcludeId = SessionMapState.ExistingMissileTargetId,
				Distance = weaponData.Range,
				YScale = weaponData.SeekScaleY,
				Arc = weaponData.UnguidedSeekAngle,
				Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }),
			})
		if enemyId == 0 then
			enemyId = SessionMapState.ExistingMissileTargetId
		end
		SessionMapState.ExistingMissileTargetId = enemyId
	end
	if weaponDataArgs.ProjectileProperties then
		for key, value in pairs(weaponDataArgs.ProjectileProperties) do
			derivedValues.PropertyChanges[key] = value
		end
	end
	if SessionState.FreeSeekProjectileIds[triggerArgs.ProjectileId] then
		derivedValues.PropertyChanges.ManuallySetTarget = false
	end
	local count = projectileData.Count or 1
	local baseAngle = triggerArgs.Angle
	if projectileData.StartAngleOffset then
		baseAngle = baseAngle + projectileData.StartAngleOffset
	end
	local latestProjectileId = nil
	for i=1,count do
		local angle = baseAngle
		if projectileData.StartAngleOffset then
			angle = baseAngle + ( i - 1 ) * projectileData.AngleOffset
		end
		latestProjectileId = CreateProjectileFromUnit({ WeaponName = triggerArgs.WeaponName, Name = projectileName, 
			ProjectileDestinationId = triggerArgs.ProjectileId, TargetIdOverride = enemyId, Id = CurrentRun.Hero.ObjectId, FireFromTarget = true, 
			AdjustZLocation = true, UseStartingZLocation = triggerArgs.LocationZ, Duration = 0.5, EaseOut = 1,
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
		if SessionMapState.ValidSplitIds[triggerArgs.ProjectileId] then
			SessionMapState.ValidSplitIds[latestProjectileId] = true
		end
		if SessionMapState.InvalidSplitIds[triggerArgs.ProjectileId] then
			SessionMapState.InvalidSplitIds[latestProjectileId] = true
		end
		if projectileData.PrioritizeDifferent then
			SessionMapState.ExistingMissileTargetIds[ latestProjectileId ] = enemyId
		end
	end
	
	SessionState.FreeSeekProjectileIds[triggerArgs.ProjectileId] = nil
	SessionMapState.ValidSplitIds[triggerArgs.ProjectileId] = nil
	SessionMapState.InvalidSplitIds[triggerArgs.ProjectileId] = nil
	if enemyId and latestProjectileId and projectileData.UseMarks and not IsEmpty(SessionMapState.QueuedEnemies) then
		SessionMapState.QueuedEnemies[enemyId] = SessionMapState.QueuedEnemies[enemyId] or {}
		SessionMapState.QueuedEnemies[enemyId][ latestProjectileId ] = true
	end
	Destroy({Id = dropLocation })
end

function RevertSuitChanges( weaponData, traitArgs, triggerargs )
		RevertWeaponChanges( CurrentRun.Hero, weaponData )
end

function EmptySuitAttackCharge( weaponName, stageReached, stageData )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if stageReached >= 1 and not SessionMapState.FrameFlags[weaponName.."PostFireFail"] then
		thread( DoSuitExAttackBlock, weaponData, weaponData.FireBlockLingerDuration )
		SessionMapState.ElapsedTimeMultiplierIgnores.SuitExAttack = true
		if weaponData.ScaledHitSimSlowParameters then
			SessionMapState.HitSimSlowOverride[ weaponName ] = {}
			for i, data in pairs( weaponData.ScaledHitSimSlowParameters ) do
				local screenPreWait = data.ScreenPreWait
				if data.ScreenPreWaitPerStage then
					screenPreWait = screenPreWait + data.ScreenPreWaitPerStage * stageReached
				end
				local simSlowParameter = { ScreenPreWait = screenPreWait, Fraction = data.Fraction, LerpTime = data.LerpTime }
				table.insert(SessionMapState.HitSimSlowOverride[ weaponName ], simSlowParameter)
			end
		end
		local delay = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "StartDelay"})
		wait( delay )
		if not SessionMapState.CancelSuitExBlinkForce then
			ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = stageData.Force, Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId}) + 180, SelfApplied = true})
		else
			SessionMapState.CancelSuitExBlinkForce = nil
		end
		SessionMapState.ElapsedTimeMultiplierIgnores.SuitExAttack = nil
	end
end

function SuitAttackChargeStage( weaponName, stageData)
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	thread( DoSuitExAttackBlock, weaponData, weaponData.BlockLingerDuration )
end

function DoSuitExAttackBlock( weaponData, duration )
	if not SessionMapState.SuitBlockGraphic then
		SessionMapState.SuitBlockGraphic = true
		CreateAnimation({ Name = weaponData.BlockGraphic, DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 70 })
	end
	local dataProperties = ShallowCopyTable( EffectData.ExAttackSuitShield.DataProperties )
	dataProperties.Duration = duration
	ApplyEffect({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ExAttackSuitShield", DataProperties = dataProperties })
	local dataProperties = ShallowCopyTable( EffectData.ExAttackSuitDefense.DataProperties )
	dataProperties.Duration = duration
	ApplyEffect({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "ExAttackSuitDefense", DataProperties = dataProperties })
end

function EndSuitExAttackBlock()
end

function CheckSuitEnemiesInRange( triggerArgs, weaponData )
	local eligibleTargets = {}
	local nearbyTargetIds = GetClosestIds(
		{ 
			Id = CurrentRun.Hero.ObjectId, 
			DestinationName = "EnemyTeam", 
			IgnoreInvulnerable = true, 
			IgnoreHomingIneligible = true, 
			IgnoreSelf = true, 
			Distance = weaponData.Range,
			Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }),
			Arc = weaponData.SeekAngle,
		})
	for _, id in pairs(nearbyTargetIds) do
		if ActiveEnemies[id] 
			and (( ActiveEnemies[id].TrainingTarget ) or (not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers)) 
			and IsWithinDistance({Id = id, DestinationId = CurrentRun.Hero.ObjectId, Distance = weaponData.Range, ScaleY = weaponData.SeekScaleY}) then
			table.insert(eligibleTargets, id )
		end
	end
	if IsEmpty(eligibleTargets) then
		SessionMapState.ManaIndicatorCustomColor = weaponData.NoTargetColor
	end
end

function SuitChargeStage( weaponName, stageData )
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AutoLock", Value = false })
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	SessionMapState.SuitSeeking = true
	thread(SuitSeekThread, weaponData, stageData )
end

function CreateSuitAimlines( weaponData )
	local scaleXMid = GetBaseDataValue({ Type = "Animation", Name = weaponData.SeekGuideMid, Property = "ScaleLength" })
	local scaleArcMid = GetBaseDataValue({ Type = "Animation", Name = weaponData.SeekGuideMid, Property = "ScaleWidth" })
	CreateAnimation({ Name = weaponData.SeekGuideMid, DestinationId = CurrentRun.Hero.ObjectId, Angle = 0 , ScaleX = weaponData.Range / scaleXMid, ScaleY = weaponData.SeekAngle/scaleArcMid})
end

function SuitSeekThread( weaponData, stageData )
	if HasThread( weaponData.ThreadName ) then
		killTaggedThreads( weaponData.ThreadName )
	end
	for _, marks in pairs( SessionMapState.MarkImages ) do
		Destroy({ Ids = marks })
	end
	if weaponData.SeekEffect then
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = weaponData.SeekEffect, DataProperties = EffectData[weaponData.SeekEffect].DataProperties })
	end
	ExpireProjectiles({ Name = "ProjectileSuitRangedChargedUnguided", BlockSpawns = true })
	SessionMapState.TargetedEnemies = {}
	SessionMapState.QueuedEnemies = {}

	SessionMapState.MarkImages = {}
	SessionMapState.SuitCost = 0
	SessionMapState.ValidSuitRangedTargets = nil
	CreateSuitAimlines( weaponData )
	while SessionMapState.SuitSeeking and ( CurrentRun.Hero.Mana >= SessionMapState.SuitCost or HeraManaRestoreEligible( SessionMapState.SuitCost )) do
		local nearbyTargetIds = GetClosestIds(
			{ 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationName = "EnemyTeam", 
				IgnoreInvulnerable = true, 
				IgnoreHomingIneligible = true, 
				IgnoreSelf = true, 
				Distance = weaponData.Range,
				Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }),
				Arc = weaponData.SeekAngle,
			})
		local eligibleTargets = {}
		local eligibleUnmarkedTargets = {}
		for _, id in pairs(nearbyTargetIds) do
			if ActiveEnemies[id] 
				and (( ActiveEnemies[id].TrainingTarget ) or (not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers)) 
				and IsWithinDistance({Id = id, DestinationId = CurrentRun.Hero.ObjectId, Distance = weaponData.Range, ScaleY = weaponData.SeekScaleY}) then
				table.insert(eligibleTargets, id )
				if not Contains( SessionMapState.TargetedEnemies, id ) then
					table.insert(eligibleUnmarkedTargets, id )
				end
			end
		end
		local outOfRangeTargets = {}
		for _, id in pairs(SessionMapState.TargetedEnemies) do
			if not Contains(eligibleTargets, id ) then
				table.insert(outOfRangeTargets, id)
			end
		end
		if not IsEmpty(outOfRangeTargets) then
			local outOfRangeId = GetRandomValue(outOfRangeTargets)
			RemoveValueAndCollapse( SessionMapState.TargetedEnemies, outOfRangeId )
			if not IsEmpty(SessionMapState.MarkImages[outOfRangeId]) and TableLength(SessionMapState.MarkImages[outOfRangeId]) >= 1 then
				local markId = table.remove( SessionMapState.MarkImages[outOfRangeId] )
				Destroy({ Id = markId })
			end
		end
		if not IsEmpty(eligibleTargets) then
			local weaponName = weaponData.Name
			local nearbyTargetId = GetRandomValue(eligibleTargets)
			if not IsEmpty(eligibleUnmarkedTargets) then
				nearbyTargetId = GetRandomValue(eligibleUnmarkedTargets)
			end
			if TableLength(SessionMapState.TargetedEnemies) < weaponData.MaxTargets then

				local nextCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost + ( weaponData.stageManaCost * (TableLength(SessionMapState.TargetedEnemies)) ) } )
				if CurrentRun.Hero.Mana < nextCost and not HeraManaRestoreEligible( nextCost ) then		
					SetManaIndicatorDisallowed( weaponName, false, SessionMapState.SuitCost )
				else
					local markStatus = SpawnObstacle({ Name = "BlankObstacle", DestinationId = nearbyTargetId, Group = "Combat_UI_World_Add" })
					SetAnimation({ Name = "SuitMarkStatusIn", DestinationId = markStatus })
					Attach({ Id = markStatus, DestinationId = nearbyTargetId })

					SessionMapState.MarkImages[nearbyTargetId] = SessionMapState.MarkImages[nearbyTargetId] or {}
					table.insert(SessionMapState.MarkImages[nearbyTargetId], markStatus )
					table.insert(SessionMapState.TargetedEnemies, nearbyTargetId )
					SessionMapState.SuitCost = nextCost
					SessionMapState.ValidSuitRangedTargets = true
					if MapState.ManaChargeIndicatorIds then
						ModifyTextBox({ Id = MapState.ManaChargeIndicatorIds.BackingId, Text = SessionMapState.SuitCost })
						if weaponData.ManaIndicatorUsesStageProgression and MapState.ManaChargeIndicatorIds.BackingId then
							SetAnimationFrameTarget({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId, Fraction = TableLength(SessionMapState.TargetedEnemies) / weaponData.MaxTargets, Instant = true })
							SetAnimation({ Name = ManaIndicatorPresentation.Hold.Fill, DestinationId = MapState.ManaChargeIndicatorIds.BackingId , PlaySpeed = 0, Scale = 1.0, OffsetY = -50 })		
						end
					end
					if TableLength(SessionMapState.TargetedEnemies) == weaponData.MaxTargets then
						thread(SuitMaxMissilesLockedPresentation, weaponData )
						SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = true, DataValue = false })
					elseif  GetWeaponProperty({ WeaponName = weaponData.Name, Id = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", DataValue = false}) then
						SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxChargeStageCache", Value = false, DataValue = false })
					end
				end
			end
		end
		if IsEmpty(SessionMapState.TargetedEnemies) then
			if not SessionMapState.ManaIndicatorCustomColor and not IsEmpty( MapState.ManaChargeIndicatorIds ) then
				thread(NoSuitSpecialTargetPresentation, weaponData )
				thread(NoSuitSpecialTargetCombatText)
				SessionMapState.SuitCost = 0
			end
		else
			killTaggedThreads("NoSuitTarget")
			SessionMapState.ManaIndicatorCustomColor = nil			
			SetManaIndicatorAllowed( weaponData.Name, { IgnoreOutOfManaHintCache = true } )
		end
		waitUnmodified( weaponData.SeekInterval * GetTotalHeroTraitValue("SeekIntervalMultiplier", {IsMultiplier = true}), RoomThreadName )
	end
	SessionMapState.ManaIndicatorCustomColor = nil
	SessionMapState.ValidSuitRangedTargets = nil
	
	if weaponData.SeekEffect then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = weaponData.SeekEffect })
	end
end

function SuitBaseMissileAttack( weaponData, projectileName )
	if MapState.HostilePolymorph 
		or (CurrentRun.Hero.IsDead and CurrentHubRoom == nil )
		or (CurrentRun.Hero.IsDead and CurrentHubRoom ~= nil and not CurrentHubRoom.AllowWeapons ) then
		return
	end
	SessionMapState.ExistingMissileTargetId = nil
	local weaponName = weaponData.Name
	local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
	local firstMarker = "WeaponSuitB_Rig:backpackJetTop_00_R_JNT"
	local secondMarker = "WeaponSuitB_Rig:backpackJetTop_00_L_JNT"
	if CoinFlip() then
		firstMarker = "WeaponSuitB_Rig:backpackJetTop_00_L_JNT"
		secondMarker = "WeaponSuitB_Rig:backpackJetTop_00_R_JNT"
	end
	CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
		DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
		SpawnFromMarker = firstMarker })
	derivedValues.PropertyChanges.StartDelay = 0.1
	CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
		DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
		SpawnFromMarker = secondMarker })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "forceCooldown", Parameters = { weaponData.BaseCooldown }  })
end

function ClearEnemySeekStatus( enemy )
	if SessionMapState.MarkImages and SessionMapState.MarkImages[ enemy.ObjectId ] then
		Destroy({Ids = SessionMapState.MarkImages[ enemy.ObjectId ] })
		SessionMapState.MarkImages[ enemy.ObjectId ] = nil
	end
	if SessionMapState.QueuedEnemies then
		SessionMapState.QueuedEnemies[ enemy.ObjectId ] = nil
	end
	if not IsEmpty( SessionMapState.TargetedEnemies ) then
		local condemnedIndexes = {}
		for i, id in pairs( SessionMapState.TargetedEnemies ) do
			if id == enemy.ObjectId then
				table.insert(condemnedIndexes, i)
			end
		end
		for _, index in pairs(condemnedIndexes) do
			SessionMapState.TargetedEnemies[index] = nil
		end
		SessionMapState.TargetedEnemies = CollapseTable(SessionMapState.TargetedEnemies)
	end
end

function EmptySuitCharge( weaponName, stageReached )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Projectile" })
	
	StopAnimation({ Name = weaponData.SeekGuideMid, DestinationId = CurrentRun.Hero.ObjectId })
	SessionMapState.ManaIndicatorCustomColor = nil
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AutoLock", Value = true })
	if  CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	if stageReached < 1 then
		thread( SuitBaseMissileAttack, weaponData, projectileName )
		return
	end
	if SessionMapState.SuitCost then
		ManaDelta(-SessionMapState.SuitCost)
		SessionMapState.SuitCost = nil
	end
	
	SessionMapState.SuitSeeking = false
	local missileCount = TableLength( SessionMapState.TargetedEnemies  )
	local missileTargets = {}
	local cooldown = weaponData.BaseCooldown
	local splitValid = false
	if HeroHasTrait("SuitMarkCritAspect") then
		local trait = GetHeroTrait( "SuitMarkCritAspect")
		local requiredEffectName = trait.OnProjectileCreationFunction.Args.RequiredEffect
		if requiredEffectName == nil or CurrentRun.Hero.ActiveEffects[requiredEffectName] then
			splitValid = true
		end
	end
	if missileCount <= 0 then
		thread( SuitBaseMissileAttack, weaponData, projectileName )
	else
		cooldown = weaponData.BaseExCooldown
		if weaponData.BaseCooldownAddition == 0 then
			cooldown = cooldown * GetTotalHeroTraitValue("MissileCooldownMultiplier", { IsMultiplier = true })
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "forceCooldown", Parameters = { cooldown }  })
		else
			cooldown = cooldown + weaponData.BaseCooldownAddition * missileCount
			local adjustedCooldown = cooldown * GetTotalHeroTraitValue("MissileCooldownMultiplier", { IsMultiplier = true })
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "forceCooldown", Parameters = { adjustedCooldown }  })
		end
		for i=1, missileCount do
			if  CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
				break
			end
			local offset = CalcOffset( math.rad( 360 / missileCount * i ), 100 )
			local invisibleTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
			table.insert(missileTargets, invisibleTarget)
			local projectileName = weaponData.ChargedProjectileName
			local derivedValues = GetDerivedPropertyChangeValues({
					ProjectileName = projectileName,
					WeaponName = weaponName ,
					Type = "Projectile",
					MatchProjectileName = true,
				})
			derivedValues.PropertyChanges.Fuse = (weaponData.BaseFuse + (weaponData.BaseFuseAddition * (i - 1))) * GetTotalHeroTraitValue("MissileStartupMultiplier", { IsMultiplier = true })
			derivedValues.PropertyChanges.LaunchDistanceFraction = RandomInt( 1, 5 )
			local projectile = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
				DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges  })
			if splitValid then
				SessionMapState.ValidSplitIds[projectile] = true
			end
			if HeroHasTrait("DoubleExManaBoon") then
				local doubledMissile = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
					DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges  })
				SessionState.FreeSeekProjectileIds[doubledMissile] = true
			end
			waitUnmodified(weaponData.FireInterval, weaponData.ThreadName)
		end
	end
	DestroyOnDelay(missileTargets, 0.5 )
end


function CheckSuitChargedDisable( unit, weaponData, args, triggerArgs )
	if not triggerArgs.NumProjectiles or triggerArgs.NumProjectiles == 0 then
		ClearEffect({ Id = unit.ObjectId, Name = "SuitChargeDisable"})
		ClearEffect({ Id = unit.ObjectId, Name = "SuitChargeDisableCancellable"})
		ClearEffect({ Id = unit.ObjectId, Name = "SuitChargeDisableRotation"})
		ClearEffect({ Id = unit.ObjectId, Name = "SuitChargeGrip"})
	end
	if triggerArgs.ProjectileId then
		SessionMapState.SuitExProjectileId = triggerArgs.ProjectileId
	end
end

function SuitAutoMissile( hero, args )
	while CurrentRun and CurrentRun.CurrentRoom and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		local delay = 0.1
		local closestIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreSelf = true, StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = args.Range })
		if not IsEmpty(closestIds) then	
			local projectileName = args.ProjectileName
			local weaponName = "WeaponSuitRanged"

			local derivedValues = GetDerivedPropertyChangeValues({
					ProjectileName = projectileName,
					WeaponName = weaponName ,
					Type = "Projectile",
					MatchProjectileName = true,
				})
			local projectile = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
				Angle =  GetAngle({Id = CurrentRun.Hero.ObjectId}) ,DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges  })
			
			delay = args.Interval
		end
		wait( delay, RoomThreadName )
	end
end

function BlockLaunchMissile( blocker, args, triggerArgs )
	if not blocker or not blocker.ObjectId then
		return
	end
	if triggerArgs.WeaponName == "WeaponSuitCharged" and not CheckCountInWindow( "SuitRetaliate", args.Window, args.Count + 1) and CheckCooldown("SuitRetaliate"..blocker.ObjectId, args.PerEnemyCooldown ) then
		local projectileName = args.ProjectileName
		local weaponName = "WeaponSuitRanged"
		local projectileCount = args.ProjectileCount or 5
		local derivedValues = GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName ,
				Type = "Projectile",
				MatchProjectileName = true,
			})
		for i=1, projectileCount do
			local projectile = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
				DestinationId = blocker.ObjectId, Angle =  GetAngle({Id = CurrentRun.Hero.ObjectId}) + RandomFloat(-100, 100), DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges  })
		end
	end
end

function CheckMissileOnHit(unit, args, triggerArgs)
	if not args.Chance or not RandomChance(args.Chance) then
		return
	end
	local projectileName = args.ProjectileName
	local weaponName = "WeaponSuitRanged"
	local projectileCount = args.ProjectileCount or 1
	local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
	for i=1, projectileCount do
		local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
			DestinationId = unit.ObjectId, Angle =  GetAngle({Id = CurrentRun.Hero.ObjectId}) + RandomFloat(-100, 100), DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges  })
		SessionMapState.InvalidSplitIds[projectileId] = true
	end

end

function CheckConsecutiveDamage( victim, args, triggerArgs )
	if not victim or not victim.ObjectId then
		return
	end
	IncrementTableValue (SessionMapState.ConsecutiveMissileHits, victim.ObjectId )
	thread( ResetConsecutiveHits, victim, args )
end

function ResetConsecutiveHits( victim, args )
	local threadName = "ConsecutiveHits"..victim.ObjectId
	if SetThreadWait( threadName, args.Window ) then
		return
	end
	wait( args.Window, threadName )
	SessionMapState.ConsecutiveMissileHits[ victim.ObjectId ] = nil
end

function ClearVolleyHitRecord( weaponName )
	if not weaponName then
		return
	end
	SessionMapState.VolleyHitRecord[weaponName] = {}
end

function VolleyRecordUnitHit( weaponName, volleyId, name )
	if not volleyId or not weaponName then
		return
	end 
	if not SessionMapState.VolleyHitRecord[weaponName] then
		SessionMapState.VolleyHitRecord[weaponName] = {}
	end 
	if not SessionMapState.VolleyHitRecord[weaponName][volleyId] then
		SessionMapState.VolleyHitRecord[weaponName][volleyId] = {}
	end
	SessionMapState.VolleyHitRecord[weaponName][volleyId][name] = true
end

function VolleyHasUnitHit( weaponName, volleyId, name )
	if not volleyId or not weaponName then
		return false
	end
	if not SessionMapState.VolleyHitRecord[weaponName] then
		return false
	end
	if not SessionMapState.VolleyHitRecord[weaponName][volleyId] then
		return false
	end
	return SessionMapState.VolleyHitRecord[weaponName][volleyId][name]
end