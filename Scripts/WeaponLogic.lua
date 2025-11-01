function CheckWeaponRoomStartEvents()
	for weaponName in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	end
end

function IsExWeapon( weaponName, args, triggerArgs )
	if WeaponSetLookups.HeroSpellWeapons[weaponName] then
		return false
	end
	
	local baseWeaponData = WeaponData[weaponName]
	
	local projectileName = triggerArgs.SourceProjectile or triggerArgs.ProjectileName or triggerArgs.name
	if not baseWeaponData then
		return false
	end

	for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.CustomExDefinitions ) do
		if data[projectileName] ~= nil then
			return data[projectileName]
		end
	end
	if triggerArgs.IsEx then
		return true
	end
	args = args or {}
	local isEx = false
	-- Virtually every weapon has a bespoke implementation of 'ex-ness'
	if baseWeaponData.IsExWeapon then
		if triggerArgs.NumProjectiles and triggerArgs.NumProjectiles <= 0 then
			return false
		end
		return true
	elseif baseWeaponData.ManaCost then
		-- starting rule of thumb: ex weapons cost mana (before modifications)
		return true
	elseif ( args.Combat and triggerArgs and triggerArgs.Armed ) then
		-- armed cast is an ex effect
		return true
	elseif ( args.Combat and triggerArgs and triggerArgs.DisjointExCast ) then
		-- armed throw cast is an ex effect
		return true
	elseif triggerArgs.ProjectileId and SessionMapState.ExProjectileIds[triggerArgs.ProjectileId] then
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
		local numProjectiles = triggerArgs.MaxNumProjectiles or triggerArgs.NumProjectiles or 1
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
	function( triggerArgs )
		local weaponName = triggerArgs.name
		local weaponData = CurrentRun.Hero.WeaponDataOverride[weaponName] or WeaponData[weaponName]
		if weaponData.DrainManaEffect then
			if CurrentRun.Hero.Mana > 0 and ( not weaponData.DrainManaEffect.RequiredStartMana or CurrentRun.Hero.Mana >= weaponData.DrainManaEffect.RequiredStartMana ) then
				if weaponData.DrainManaEffect.EffectName then
					ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, EffectName = weaponData.DrainManaEffect.Name })
				end
				thread( DrainManaPerSecond, ShallowCopyTable( weaponData.DrainManaEffect ))
			end
		end
	
		SessionMapState.SprintActive = true
		if not SessionMapState.SprintStartEventsFired then		
			SessionMapState.SprintStartEventsFired = true
			SessionMapState.SprintStartTime = _worldTimeUnmodified
			local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon() )
			if equippedWeaponData.SprintLoopSound and not SessionMapState.SprintWeaponSoundId and not SessionMapState.WeaponsDisabled then
				SessionMapState.SprintWeaponSoundId = PlaySound({ Name = equippedWeaponData.SprintLoopSound, Id = CurrentRun.Hero.ObjectId })
			end
			for _, actionData in ipairs( GetHeroTraitValues( "OnSprintStartAction" ) ) do
				thread( CallFunctionName, actionData.FunctionName, actionData.Args )
			end
		end

		CheckSprintBoons()
	end
}

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
	wait( 0.1, "CheckAutoSprint" )
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

function EndAutoSprint( args )
	if not SessionMapState.WaitUntilAutoSprintInput then
		return
	end
	args = args or {}
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "HoldFireRequest", Value = false, ValueChangeType = "Absolute", DataValue = false })
	notifyExistingWaiters(  "SprintInput" )
	SessionMapState.EndAutoSprintThread = true
	if args.Halt then
		Halt({ Id = CurrentRun.Hero.ObjectId })
	end
	if args.EndWeapon then
		EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	end
end
function EndSprintControlDown()
	local endSprintControls = { "Attack2", "Attack3" }
	local spellTrait = nil
	for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Spell" then
			spellTrait = traitData
		end
	end
	if spellTrait and spellTrait.PreEquipWeapons[1] and GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = spellTrait.PreEquipWeapons[1], Property = "Enabled" }) then
		table.insert( endSprintControls, "Shout" )
	end
	if not ProjectileExists({ Names = {"ProjectileCast", "ProjectileCastFireball", "ProjectileCastHades", "ProjectileCastLob" }}) then
		table.insert( endSprintControls, "Attack1" )
	end
	return IsControlDown({ Names = endSprintControls })
end

function HoldSprintUntilInput()
	local endSprintControls = { "Shout", "Attack1", "Attack2", "Attack3" }
	if not IsControlDown({ Names = {"Up", "Down", "Left", "Right" }}) or SessionMapState.WaitUntilAutoSprintInput or EndSprintControlDown() or SessionMapState.SpellInProgress then
		SessionMapState.SprintActive = nil
		
		if SessionMapState.WaitUntilAutoSprintInput and not MapState.ChargedManaWeapons.WeaponSprint and HeroHasTrait("SuitMarkCritAspect") then
			local weaponName = "WeaponSprint"
			notifyExistingWaiters( "Empty"..weaponName.."Stage" )	
			notifyExistingWaiters( weaponName.."IndicatorFire" )
			thread( HandleManaChargeIndicator, { name = "WeaponSprint" } )
			thread( DoWeaponCharge, {name = "WeaponSprint"}, GetWeaponData(CurrentRun.Hero, "WeaponSprint"))
		end
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
		if SessionMapState.EndAutoSprintThread or EndSprintControlDown() or SessionMapState.SpellInProgress then
			SessionMapState.WaitUntilAutoSprintInput = nil
			break
		end
		local bufferTime = 0.05
		-- In case of a very brief drop in move input, don't instantly end sprint, wait for more motion (or end anyway if the player has acted)
		NotifyOnControlPressed({ Names = endSprintControls, NotifyOnMoveInput = true, Notify = notifyName, Timeout = bufferTime }) 
		waitUntil( notifyName )
		if _eventTimeoutRecord[notifyName] or SessionMapState.EndAutoSprintThread or EndSprintControlDown() or SessionMapState.SpellInProgress then	
			SessionMapState.WaitUntilAutoSprintInput = nil
		end
	end
	SetWeaponProperty({ WeaponName = "WeaponSprint", DestinationId = CurrentRun.Hero.ObjectId, Property = "HoldFireRequest", Value = false, ValueChangeType = "Absolute", DataValue = false })
	
	SessionMapState.LockSprintActive = nil 
	if not IsControlDown({ Name = "Rush" }) or EndSprintControlDown() then 
		EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
		Halt({ Id = CurrentRun.Hero.ObjectId })
	end
end

function CheckDashManeuverEnd()
	wait( CurrentRun.Hero.DashManeuverTimeThreshold, "DashWeapon")
	if not SessionMapState.SprintActive and MapState.AttachedStormProjectileId and MapState.AttachedStormProjectileId > 0 and HeroHasTrait("BurnSprintBoon") then
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
				SwapWeapon({ SwapWeaponName = weaponData.Name, Names = { dashWeapon }, DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true, RequireNotCharging = true })
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
		local replacedWeapon = false
		if dashWeapon ~= nil and type(dashWeapon) ~= "table" then
			if weaponData.ExpireDashWeaponOnDash then
				ExpireProjectiles({ WeaponName = dashWeapon })
			end
			for i, replaceWeapons in pairs( GetHeroTraitValues("ReplaceMeleeWeapon") ) do
				weaponData = WeaponData[replaceWeapons]
				replacedWeapon =  true
			end
			if weaponData.EndControlSwapsOnDash and not replacedWeapon then
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
		SessionMapState.CancelSuitExBlinkForce = true

		if CurrentRun and CurrentRun.Hero and CurrentRun.Hero.Weapons.WeaponTorch then
			CheckEarlyPowershot()
		end
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
		else
			--DebugPrint({ Text = tostring(ConfigOptionCache.SprintAutoHold ) .. ":" .. tostring(SessionMapState.LockSprintActive )})
		end
		local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon())
		if SessionMapState.SprintWeaponSoundId then
			StopSound({ Id = SessionMapState.SprintWeaponSoundId, Duration = 0.2 })
			SessionMapState.SprintWeaponSoundId = nil
		end
		if equippedWeaponData.SprintEndSound and not SessionMapState.WeaponsDisabled then
			PlaySound({ Name = equippedWeaponData.SprintEndSound, Id = CurrentRun.Hero.ObjectId })
		end
		if not SessionMapState.SprintActive then
			for _, actionData in pairs( GetHeroTraitValues( "OnSprintEndAction" ) ) do
				if _G[actionData.FunctionName] ~= nil then
					_G[actionData.FunctionName]( ShallowCopyTable( actionData.FunctionArgs ), triggerArgs )
				end
			end
		end
		SessionMapState.SprintStartEventsFired = nil
		SetThreadWait( "DashWeapon", CurrentRun.Hero.DashManeuverTimeThreshold )
	end
}

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

	speedMultiplier = speedMultiplier * SessionMapState.MapSpeedMultiplier

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
		if not triggerArgs.AllowFire and triggerArgs.Charge >= 1 and not triggerArgs.OnCooldown and not MapState.HostilePolymorph then
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
		
			if HeroHasTrait("DaggerTripleAspect") then
				thread(HandleBonusStrikes, triggerArgs.name, args )
			end
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
				SetAnimation({ Name = "DaggerMarkStatus", DestinationId = MapState.MarkedDaggerTargetId, Scale = ActiveEnemies[targetId].DaggerExScale })
				Attach({ Id = MapState.MarkedDaggerTargetId, DestinationId = targetId, MarkerName = ActiveEnemies[targetId].DaggerExMarker })
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
					local targetsUsed = 0
					for i, id in pairs(enemyIds) do
						if ActiveEnemies[id] and ( targetsUsed < traitArgs.AdditionalTargets or ActiveEnemies[id].ActiveEffects[traitArgs.IndicatorEffect]) then
							if not ActiveEnemies[id].ActiveEffects[traitArgs.IndicatorEffect] then
								targetsUsed = targetsUsed + 1
							end
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
	local enemyPoints = GetIdsByType({ Names = { "EnemyPoint", "SecretPoint", "EnemyPointRanged", "EnemyPointMelee", "EnemyPointSupport", "CrossroadsTrainingDummy01" }})
	local spawnPoints = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationIds = enemyPoints, Distance = 800 })
	local additionalTargetData = GetHeroTrait("DaggerTripleAspect").DaggerAdditionalTargetData

	while TableLength(MapState.AdditionalTargetIds) < additionalTargetData.AdditionalTargets and not IsEmpty(spawnPoints) do
		table.insert(MapState.AdditionalTargetIds, RemoveRandomValue(spawnPoints))	
	end
	local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId })
	local projectileName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName , Property = "Projectile" })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName ,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	derivedValues.PropertyChanges.AttachToOwner = false
		
	for i, id in pairs(MapState.AdditionalTargetIds) do
		local target = ActiveEnemies[id]
		local wait = 0.3
		if i > 2 then
			wait = 0.1
		end
		waitUnmodified(wait, RoomThreadName)
		local angle = GetAngleBetween( { Id = tempObstacle, DestinationId = id })
		local offset = { X = 0, Y = 0 }
		if target ~= nil and not target.IsDead then
			offset = CalcOffset( math.rad( angle ), target.BackstabDistance or args.BackstabDistance ) 
			offset.Y = offset.Y * (target.BackstabDistanceScaleY or 1.0)
		end
		CreateProjectileFromUnit({ 
			WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = id, FireFromTarget = true, 
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
			Angle = angle + 180, OffsetX = offset.X, OffsetY = offset.Y })

		local streakAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = id })
		SetAngle({ Id = streakAnchor, Angle = angle })
		CreateAnimation({ Name = additionalTargetData.Vfx, DestinationId = streakAnchor})
		thread( DestroyOnDelay, {streakAnchor}, 0.2 )
	end
	Destroy({ Id = tempObstacle })
end

function CheckExecute( victim, functionArgs, triggerArgs)
	local executeEffectName = functionArgs.IndicatorEffectName
	if functionArgs.ExecuteImmunities and functionArgs.ExecuteImmunities[victim.Name] and IsGameStateEligible( victim, functionArgs.ExecuteImmunities[victim.Name].GameStateRequirement ) then
		return
	end
	thread( UpdateExecuteStatus, victim)
	if not CurrentRun.Hero or not CurrentRun.Hero.ActiveEffects.ShivaAttackBoost then
		return
	end
	if victim.ActiveEffects and victim.ActiveEffects[executeEffectName] and not victim.CannotDieFromDamage
		and ( victim.Phases == nil or victim.CurrentPhase == victim.Phases ) and (not victim.HitShields or victim.HitShields <= 0 ) then
		if not victim.IsDead then 
			ExecutePresentation( victim, triggerArgs )
			if victim.DeathAnimation ~= nil and not victim.ManualDeathAnimation and not victim.IsPolymorphed then
				SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
			end
			thread( Kill, victim, { ImpactAngle = 0, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId })
			if victim.UseBossHealthBar then
				CurrentRun.BossHealthBarRecord[victim.Name] = 0 -- Health bar won't get updated again normally
			end
		end
	end
end

function CheckSuitComboAttackBuff( weaponData, functionArgs, triggerArgs )
	if not triggerArgs.ProjectileId then
		return
	end
	if weaponData.Name == "WeaponSuitRanged" then
		if IsExWeapon( weaponData.Name , { Combat = true }, triggerArgs ) then
			SessionMapState.CurrentRepeatProjectileId = triggerArgs.ProjectileId 
			SessionMapState.CurrentRepeatCount = 0
		end
		return
	end
	local stacks = CurrentRun.Hero.ActiveEffects[functionArgs.EffectName]
	if not stacks then
		return
	end
	if functionArgs.SelfEffectMaxStacks and stacks > functionArgs.SelfEffectMaxStacks then
		stacks = functionArgs.SelfEffectMaxStacks
	end
	SessionMapState.SuitBonusProjectileId[ triggerArgs.ProjectileId] = 1 + functionArgs.SelfEffectStackMultiplier * stacks 
	ClearEffect({Id = CurrentRun.Hero.ObjectId, Name = "ShivaAttackBoost"})	
end

function CheckSelfBuffBlast( triggerArgs, functionArgs )
	CheckAspectBounces( triggerArgs, functionArgs )
	local collisionProjectiles = GetInProjectilesBlast({ Id = CurrentRun.Hero.ObjectId, DestinationName = triggerArgs.name, UseDamageRadius = true, PreciseCollision = true })
	if IsEmpty(collisionProjectiles) or not Contains( collisionProjectiles, triggerArgs.ProjectileId ) then
		return
	end
	local effectName = functionArgs.EffectName
	local dataProperties = MergeTables(EffectData[effectName].DataProperties, functionArgs.DataProperties)
			
	ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
	local repeatManaCost = GetTotalHeroTraitValue("SelfBuffBlastManaCost")
	if repeatManaCost > 0 and triggerArgs.ProjectileId ~= SessionMapState.LastCreatedBlastId and not ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
	
		local cost = repeatManaCost
		if cost > CurrentRun.Hero.Mana and not LastMomentManaRestoreEligible( cost ) then
			return
		else	
			ManaDelta(-cost, { IgnoreSpend = true, ManaDrain = true })
		end

		local weaponName = "WeaponSuitRanged"
		local projectileName = "ProjectileSuitGrenade" 
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName,
			Type = "Projectile",
		})
		derivedValues.PropertyChanges.Fuse = 0
		SessionMapState.LastCreatedBlastId = CreateProjectileFromUnit({ 
			WeaponName = weaponName, 
			Name = projectileName, 
			Id = CurrentRun.Hero.ObjectId, 
			DataProperties = derivedValues.PropertyChanges, 
			ThingProperties = derivedValues.ThingPropertyChanges})
	end
end

function CheckAspectBounces( triggerArgs, functionArgs )

	if triggerArgs.ProjectileId == SessionMapState.CurrentRepeatProjectileId then
		IncrementTableValue(SessionMapState, "CurrentRepeatCount" )
		if SessionMapState.CurrentRepeatCount <= functionArgs.NumBounces then

			local weaponName = "WeaponSuitRanged"
			local projectileName = "ProjectileSuitBomb" 
			local derivedValues = GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			derivedValues.PropertyChanges.StartAtMarker = "null"
			derivedValues.PropertyChanges.MinRange = 0
		
			SessionMapState.CurrentRepeatProjectileId = CreateProjectileFromUnit({ 
				WeaponName = weaponName, 
				Name = projectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				FireFromTarget = true,
				ProjectileDestinationId = triggerArgs.ProjectileId,
				DataProperties = derivedValues.PropertyChanges, 
				ThingProperties = derivedValues.ThingPropertyChanges})
		end
	end
end
function CheckTraitExecuteStatus( enemy, traitArgs )
	thread( UpdateExecuteStatus, enemy, 0.1 )
end

function UpdateExecuteStatus( victim, delay )
	if delay then
		wait( delay, RoomThreadName )
	end
	if not victim.ActiveEffects then
		return
	end
	local trait = GetHeroTrait("SuitComboAspect")
	local functionArgs = ShallowCopyTable( trait.OnEnemyDamagedAction.Args )
	local threshold = functionArgs.Threshold + GetTotalHeroTraitValue("ExecuteThresholdIncrease")
	if not victim.IsDead and not victim.CannotDieFromDamage and ( victim.Phases == nil or victim.CurrentPhase == victim.Phases ) and IsEnemyExecutable( victim, threshold ) then
		local effectName = functionArgs.IndicatorEffectName
		if not victim.ActiveEffects[functionArgs.IndicatorEffectName] then
			ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties } )
		end
	elseif victim.ActiveEffects[functionArgs.IndicatorEffectName] then
		ClearEffect({ Id = victim.ObjectId, Name = functionArgs.IndicatorEffectName })
	end
end

function IsEnemyExecutable( victim, threshold, incomingDamage )
	incomingDamage = incomingDamage or 0
	if not victim then
		return false
	end
	if IsInvulnerable({ Id = victim.ObjectId }) or (victim.HitShields and victim.HitShields > 0 ) or ( not victim.Health and not victim.MaxHealth ) then
		return false
	end
	if (victim.Health - incomingDamage) / victim.MaxHealth <= threshold then
		return true
	else
		return false
	end
end

function EndShivaBuff()
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "ShivaAttackBoost" })
end

function ResetClipRegenTriggerLock( weaponData, functionArgs, triggerArgs )
	if functionArgs[weaponData.Name] then
		local nextWeaponName = functionArgs[weaponData.Name]
		local clipRegenTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = nextWeaponName, Property = "ClipRegenInterval" })
		if clipRegenTime > 0 then
		
			SetWeaponProperty({ WeaponName = nextWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "NextClipRegenTime", Value = clipRegenTime, DataValue = false })
			SetWeaponProperty({ WeaponName = nextWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "ClipShotsRemaining", Value = 0, DataValue = false })
		end
	end
end
function CheckFinisher( victim, functionArgs, triggerArgs )

	local isEx = IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs )
	local effectName = nil
	local requiredEffects = 
	{
		ComboAttackIndicator = true,
		ComboSpecialIndicator = true,
		ComboExIndicator = true,
	}
	if isEx then
		effectName = "ComboExIndicator"
	elseif Contains( AddLinkedWeapons({ "WeaponDagger" }), triggerArgs.SourceWeapon) then
		effectName = "ComboAttackIndicator"
	elseif Contains( AddLinkedWeapons({ "WeaponDaggerThrow" }), triggerArgs.SourceWeapon) then
		effectName = "ComboSpecialIndicator"
	end

	if not effectName then
		return
	end
	requiredEffects[effectName] = nil
	if victim.ActiveEffects then
		local hasAllEffects = true
		local effectCount = 0
		for name in pairs(requiredEffects) do
			if not victim.ActiveEffects[name] then
				hasAllEffects = false
			end
			effectCount = effectCount + 1
		end
		if hasAllEffects then
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier + GetTotalHeroTraitValue("WomboDamageBonusMultiplier")})
			ClearEffect({ Id = victim.ObjectId, Names = GetAllKeys( requiredEffects ) })
			CreateAnimation({ Name = "MorriganPip1Out", DestinationId = victim.ObjectId })
			CreateAnimation({ Name = "MorriganPip2Out", DestinationId = victim.ObjectId })
			CreateAnimation({ Name = "MorriganPip3Out", DestinationId = victim.ObjectId })
			if RandomChance(GetTotalHeroTraitValue("RepeatTripleStrikeChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
				thread(RepeatTripleStrike, functionArgs.ProjectileName, victim, functionArgs.DamageMultiplier + GetTotalHeroTraitValue("WomboDamageBonusMultiplier"), 0.6 )
			end
			if functionArgs.CompleteObjectivesOnFire then
				thread( MarkObjectivesComplete, functionArgs.CompleteObjectivesOnFire )
			end
			return
		end
	end
	if effectName then
		local dataProperties = MergeAllTables({
			EffectData[effectName].DataProperties, 
			functionArgs.EffectArgs
		})
		ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
	end
end

function RepeatTripleStrike( projectileName, victim, damageMultiplier, delay)
	waitUnmodified(delay)
	if victim and not victim.IsDead then
		CreateProjectileFromUnit({ Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = damageMultiplier})
	end
end
function GetWeaponChargeStages( weaponData )

	local weaponName = weaponData.Name
	local chargeStages = DeepCopyTable(weaponData.ChargeWeaponStages) or {}
	local chargeStageModifiers = ShallowCopyTable(GetHeroTraitValues("ChargeStageModifiers"))
	local chargeStageModifiersArray = GetHeroTraitValues("ChargeStageModifiersArray")
	for i, entries in pairs(chargeStageModifiersArray) do
		ConcatTableValues(chargeStageModifiers, entries)
	end
	local appliedChanges = {}
	for i, data in pairs( chargeStageModifiers ) do
		local validWeapon = data.ValidWeaponsLookup == nil or data.ValidWeaponsLookup[weaponData.Name]
		local validTrait = data.TraitName == nil or HeroHasTrait( data.TraitName )
		local validFalseTrait = data.FalseTraitName == nil or not HeroHasTrait( data.FalseTraitName )
		local validSessionKey = data.HasSessionMapStateValue == nil or SessionMapState[data.HasSessionMapStateValue] ~= nil
		if data.InvalidWeapon and weaponName == data.InvalidWeapon.WeaponName then
			validWeapon = false
		end

		if data.FalseTraitNames then
			for i, traitName in pairs(data.FalseTraitNames) do
				if HeroHasTrait( traitName ) then
					validTrait = false
					break
				end
			end
		end
		if data.TraitNames then
			for i, traitName in pairs(data.TraitNames) do
				if not HeroHasTrait( traitName ) then
					validTrait = false
					break
				end
			end
		end
		if validWeapon and validTrait and validFalseTrait and validSessionKey then
			
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
			if ( data.AddWeaponProperties or data.AddScaledWeaponProperties)and not IsEmpty(chargeStages) then
				for i, chargeStage in pairs( chargeStages ) do
					chargeStage.WeaponProperties = chargeStage.WeaponProperties or {}
					if not IsEmpty( data.AddWeaponProperties ) and ( not data.AddWeaponPropertiesStageRequirementMin or i >= data.AddWeaponPropertiesStageRequirementMin ) then
						for key, value in pairs( data.AddWeaponProperties ) do
							if IsEmpty(weaponData.BlockChargeStageModifiers) or not weaponData.BlockChargeStageModifiers[key] then
								if data.MultiplyExistingWeaponProperties and data.MultiplyExistingWeaponProperties[key] and chargeStage.WeaponProperties[key] then
									chargeStage.WeaponProperties[key] = chargeStage.WeaponProperties[key] * value 
								elseif value == "null" then
									chargeStage.WeaponProperties[key] = "null"
								else
									chargeStage.WeaponProperties[key] = value 
								end
							end
						end
					end
					if not IsEmpty( data.AddScaledWeaponProperties ) then
						for key, scaleData in pairs( data.AddScaledWeaponProperties ) do						
							if IsEmpty(weaponData.BlockChargeStageModifiers) or not weaponData.BlockChargeStageModifiers[key] then
								if scaleData.MultiplyExistingWeaponProperties and scaleData.MultiplyExistingWeaponProperties[key] and chargeStage.WeaponProperties[key] then
									chargeStage.WeaponProperties[key] = chargeStage.WeaponProperties[key] * (scaleData.Base + scaleData.Scale*i)
								else
									chargeStage.WeaponProperties[key] = scaleData.Base + scaleData.Scale*i
								end
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

	if stageData.ForceReleaseWithoutMana and manaCost > CurrentRun.Hero.Mana and not LastMomentManaRestoreEligible( stageData.ManaCost ) then
		return true
	end
	if stageData.ForceRelease and ( not stageData.BlockForceReleaseWithoutMana or manaCost <= CurrentRun.Hero.Mana or LastMomentManaRestoreEligible( stageData.ManaCost )) then
		return true
	end
	return false
end

function DoWeaponCharge( triggerArgs, weaponData, args )
	args = args or {}
	args = ShallowCopyTable( args )
	local notifyName = "Empty"..weaponData.Name.."Stage"
	if weaponData.ArmedCastChargeStage and not IsEmpty(MapState.CastArmDisable) then
		return
	end
	if SessionMapState.WeaponsDisabled then
		return
	end
	if SessionMapState.BlockStagedCharge[weaponData.Name] then
		return
	end
	if not args.Force then
		if HasThread( notifyName ) then
			return
		end
		if HasWaitUntil( notifyName ) then
			return
		end
	end
	local weaponName = weaponData.Name
	local chargeStages = GetWeaponChargeStages( weaponData )
	local perfectChargeWindow = GetTotalHeroTraitValue("StagePerfectChargeWindow", { FirstValue = true })
	if perfectChargeWindow > 0 and weaponData.CustomEarlyReleaseWindow then
		perfectChargeWindow = weaponData.CustomEarlyReleaseWindow 
	end
	MapState.WeaponCharge = MapState.WeaponCharge or {}
	MapState.WeaponCharge[ weaponName ] = 0
	SessionMapState.MaxChargeStageReached[ weaponName ] = false
	WeaponChargeStartPresentation( triggerArgs, weaponData, args )
	local completeObjectiveOnFire = nil
	local wasOOM = false
	local stageReached = 0
	local maxStage = #chargeStages
	for stage = 1, maxStage do
		args.ResetIndicator = false
		local stageData = chargeStages[stage]
		local startTime = _worldTime
		local manaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } )
		while stageData.ManaCost and manaCost > CurrentRun.Hero.Mana and not HasForceRelease( weaponData, stageData ) and not LastMomentManaRestoreEligible( manaCost ) do
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
			else
				args.ResetIndicator = true
				waitUnmodified( 0.03, notifyName )
			end
		end
		if weaponData.ChargeWeaponData and weaponData.ChargeWeaponData.OnChargeStartFunctionName then
			thread( CallFunctionName, weaponData.ChargeWeaponData.OnChargeStartFunctionName, weaponData, chargeStages)
		end
		if manaCost > CurrentRun.Hero.Mana then
			if LastMomentManaRestoreEligible( manaCost ) then
				thread( SetManaIndicatorCustomColor, weaponName, Color.ManaRestoreEligible, ManaIndicatorPresentation.LastMomentManaRestoreEligibleHSV )
			else
				SetManaIndicatorDisallowed( weaponName )
			end
		elseif stage == 1 then
			thread( HandleManaChargeIndicator, triggerArgs )
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

		WeaponChargeStageStartPresentation( triggerArgs, weaponData, args, stageData, stage )
		local stageManaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost })
		if ( stageManaCost <= CurrentRun.Hero.Mana or LastMomentManaRestoreEligible( stageManaCost )) then
			if stageData.ExChargeAnimation and stageData.ExChargeAnimationDelay then
				thread( HandleChargeAnimation, weaponName, stageData.ExChargeAnimation, stageData.ExChargeAnimationDelay )
			end
			if stageData.EarlyPropertySwaps then
				thread( HandleEarlySwap , weaponData, stageData.EarlyPropertySwaps )
			end
		end
		
		local timeout = stageData.Wait * GetLuaWeaponSpeedMultiplier( weaponName )

		local minChargeTime = weaponData.MinWeaponChargeTime or WeaponData.DefaultWeaponValues.MinWeaponChargeTime
		if timeout < minChargeTime then
			timeout = minChargeTime
		end
		if perfectChargeWindow > 0 and weaponData.EarlyReleasePerfectCharge then
			thread( HandleEarlyPerfectCharge, weaponData, stageData, timeout - perfectChargeWindow, perfectChargeWindow )
		end
		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = timeout })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[notifyName] and ( perfectChargeWindow <= 0 or not weaponData.EarlyReleasePerfectCharge or GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "PerfectChargeWindowRemaining" }) <= 0 ) then
			EmptyWeaponCharge( weaponData, stageReached, chargeStages[stageReached] )
			return
		end
		if stageData.ManaCost and stageManaCost > CurrentRun.Hero.Mana and HasForceRelease( weaponData, stageData ) and not LastMomentManaRestoreEligible( stageManaCost ) then
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
		local validPerfectCharge = perfectChargeWindow > 0 and (stage == 1 or stage == maxStage)
		if HeroHasTrait("SuitPowershotTrait") and stage == 1 then
			validPerfectCharge = false
		end
		if not weaponData.EarlyReleasePerfectCharge and not stageData.ManualHandlePerfectCharge and validPerfectCharge then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "setPerfectChargeWindow", Parameters = { perfectChargeWindow }})
		end
		SessionMapState.MaxChargeStageReached[ weaponName ] = (stage == maxStage)
	
		WeaponChargeStageReachedPresentation( triggerArgs, weaponData, args, stageData, stage, maxStage )
		completeObjectiveOnFire = stageData.CompleteObjective
		
		if not IsEmpty(weaponData.ChargeWeaponData) and weaponData.ChargeWeaponData.OnStageReachedFunctionName then
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

function HandleChargeAnimation( weaponName, animationName, delay )
	local notifyName = weaponName .. "ChargeAnimation"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = delay * GetLuaWeaponSpeedMultiplier( weaponName ) })
	waitUntil( notifyName )
	if not _eventTimeoutRecord[notifyName] then
		return
	end
	SetAnimation({ Name = animationName, DestinationId = CurrentRun.Hero.ObjectId })	
end

function HandleEarlyPerfectCharge( weaponData, stageData, delay, window )
	local stageManaCost = GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost })
	if stageData.ManaCost and stageManaCost > CurrentRun.Hero.Mana and not LastMomentManaRestoreEligible( stageManaCost ) then
		return
	end
	local weaponName = weaponData.Name
	local notifyName = "EarlyPerfectCharge"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponName, ChargeFraction = 0.0, Comparison = "<=", Timeout = delay })
	waitUntil( notifyName )
	if not _eventTimeoutRecord[notifyName] then
		return
	end
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "setPerfectChargeWindow", Parameters = { window  }})
	local newStageData = ShallowCopyTable( stageData )
	newStageData.ForceRelease = false
	ApplyWeaponChanges( CurrentRun.Hero, newStageData, weaponData )
end
function HandleEarlySwap( weaponData, swapData )
	
	if weaponData.BlockEarlySwap then
		return 
	end
	local notifyName = weaponData.Name .. "WeaponSwap"
	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = weaponData.Name, ChargeFraction = 0.0, Comparison = "<=", Timeout = swapData.Delay * GetLuaWeaponSpeedMultiplier( weaponData.Name ) })
	waitUntil( notifyName )
	if not _eventTimeoutRecord[notifyName] then
		return
	end
	ApplyWeaponChanges( CurrentRun.Hero, swapData.SwapProperties, weaponData )
	UpdateAttackTarget({ Id = CurrentRun.Hero.ObjectId,  WeaponName = weaponData.Name })
	
end

function EmptyWeaponCharge( weaponData, stageReached, stageData, args )
	args = args or {}
	if stageReached >= 1 then
		if stageData.ManaCost then
			if not stageData.SkipManaSpendOnFire and ( not weaponData.CheckPostFireFail or not FrameState[weaponData.Name.."PostFireFail"] ) then
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
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "PriorityFireRequest", Value = false})
	end
	if stageData and stageData.ApplyEffects then
		for i, effectName in pairs(stageData.ApplyEffects) do
			local dataProperties = ShallowCopyTable(EffectData[effectName].EffectData)
			if HasHeroTraitValue("ScaledStageEffects") then
				local data = GetHeroTraitValues("ScaledStageEffects", { First = true })[1]
				if data[effectName] then
					dataProperties.Duration = data[effectName].Base + stageReached * data[effectName].StageIncrement
				end
			end
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
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

function EndDashDisableForce( )
	SessionMapState.CancelSuitExBlinkForce = nil
end

function LogProjectileSuitCharged( source, args, triggerArgs )
	SessionMapState.SuitChargedAttackIds[ triggerArgs.ProjectileId ] = true
	AttachProjectiles({ Ids = { triggerArgs.ProjectileId }, DestinationId = CurrentRun.Hero.ObjectId })
end

function UnlogProjectileSuitCharged( source, args, triggerArgs )
	SessionMapState.SuitChargedAttackIds[ triggerArgs.ProjectileId ] = nil
end

function GetChangeFromBaseValue( weaponName, propertyName )
	local baseValue = GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = propertyName })
	if SessionState.PropertyChangeList.WeaponChanges[weaponName] and not IsEmpty(SessionState.PropertyChangeList.WeaponChanges[weaponName][propertyName]) then
		for i, entry in pairs(SessionState.PropertyChangeList.WeaponChanges[weaponName][propertyName]) do
			if entry.ChangeType == "Absolute" then
				baseValue = entry.ChangeValue
				break
			end
		end
	end
	local currentValue = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = propertyName })
	return currentValue / baseValue
end

function ApplyWeaponChanges( unit, stageData, weaponData, args )
	args = args or {}
	
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
			DoWeaponScreenshake( stageData, "FireScreenshake", { AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = stageData.ProjectileName } )
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
	if not args.PropertyChangesOnly then
		CallFunctionName( weaponData.ChargeWeaponData.OnStageReachedFunctionName, weaponName, stageData )
	end
	if MapState.WeaponDataValues[weaponName] and MapState.WeaponDataValues[weaponName].Projectile and ( not stageData.Stage or stageData.Stage == 1 ) then
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

		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
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
	if HasHeroTraitValue( "ScaledFireEndEffects" ) then
		local data = GetHeroTraitValues("ScaledFireEndEffects", {First = true})[1]
	end
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
	if HeroHasTrait("LobGunAspect") then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "reloadInstantly" })
	end
end

function EmptyLobCharge( weaponName, stageReached, stageData)
	SetMenuOptions({ Name = "InGameUI", Properties = { Run = "ResetReticles" } })
end

function ThrowChargeStage( weaponName, stageData )
	SessionMapState.ThrowWeaponCharged = true
end

function DoThrowEx( weaponName )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if weaponData.CustomThrowEx then
		SessionMapState.BlockStagedCharge[weaponName] = true
		return
	end
	if MapState.ThrowWeaponInterval < 1 then
		-- backcompat sanity check
		MapState.ThrowWeaponInterval = 250
	end
	local wasPerfectCharge = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "PerfectChargeWindowRemaining" }) > 0 
	local lastPoint = nil
	AddEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "StasisStun"})
	while ( SessionMapState.ThrowWeaponDeferred or SessionMapState.ActiveSkullImpulse ) and not MapState.HostilePolymorph do
		local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = "ProjectileThrowCharged",
			WeaponName = weaponName,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		CreateProjectileFromUnit({ WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle + 90, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12, PerfectCharge = wasPerfectCharge })
		CreateProjectileFromUnit({ WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle - 90,DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12, PerfectCharge = wasPerfectCharge })
		if HeroHasTrait("DoubleExManaBoon") then
			local startDelay = 0.35
			thread( CreateProjectileFromUnitDelay, { WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle + 90, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12, PerfectCharge = wasPerfectCharge, FireFromCurrentHeroLocation = true }, startDelay )
			thread( CreateProjectileFromUnitDelay, { WeaponName = weaponName, Name = "ProjectileThrowCharged", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, Angle = angle - 90, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ProjectileCap = 12, PerfectCharge = wasPerfectCharge, FireFromCurrentHeroLocation = true }, startDelay )
		end
		if lastPoint then
			Destroy({Id = lastPoint })
		end
		lastPoint = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
		NotifyOutsideDistance({ Id = lastPoint, DestinationId = CurrentRun.Hero.ObjectId, Distance = MapState.ThrowWeaponInterval, Notify = "ThrowWeaponDistance", Timeout = 0.25 })
		waitUntil( "ThrowWeaponDistance" )		
	end
	if lastPoint then
		Destroy({Id = lastPoint })
	end
	RemoveEffectBlock({ Id = CurrentRun.Hero.ObjectId, Name = "StasisStun"})
	
end

function EmptyThrowCharge( weaponName, stageReached )
	SessionMapState.ThrowWeaponCharged = nil
	if stageReached > 0 then
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		if MapState.LobCharge then
			local chargeStages = GetWeaponChargeStages( weaponData )
			local manaCost =GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[stageReached].ManaCost}) 
			ManaDelta( -manaCost)
			SessionMapState.ChargeStageManaSpend[weaponData.Name] = manaCost
			
			SessionMapState.ThrowWeaponDeferred = true
			MapState.ThrowWeaponInterval = 250
			if HeroHasTrait("LobImpulseAspect") then
				local traitData = GetHeroTrait("LobImpulseAspect")
				if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
					MapState.ThrowWeaponInterval = traitData.OnWeaponFiredFunctions.FunctionArgs.Interval or 250
				end
			end
			thread(DoThrowEx, weaponName )
			ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = "LobWeaponInvulnerable", DataProperties = EffectData.LobWeaponInvulnerable.EffectData})
		else
			ApplyDeferredThrowReversions( weaponData )
		end
	elseif not MapState.HostilePolymorph then
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
	
	if weaponData.MagnetismMultiplier then	
		local ammoPacks  = GetIdsByType({ Name = "LobAmmoPack"})
		SetObstacleProperty({ Property = "Magnetism", Value = weaponData.MagnetismMultiplier, DestinationIds = ammoPacks, ValueChangeType = "Multiply" })
		SessionMapState.MagnetismMultiplier = weaponData.MagnetismMultiplier
	end

	for i, effectName in pairs(weaponData.ScaledFireEndEffects or {}) do
		local effectData = DeepCopyTable(EffectData[effectName].EffectData)
		effectData.Duration = 3600
		ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = effectData })
	end
end

BlinkControlReleaseWeapons =
{
	"WeaponSuitCharged",
	"WeaponAxeSpecialSwing",
	"WeaponAxeSpecial",
	"WeaponTorchSpecial",
	"WeaponLob",
	"WeaponLobSpecial",
	"WeaponStaffSwing5",
	"WeaponStaffBall",
},

OnBlinkFinished{ "WeaponBlink",
	function(triggerArgs) 
		for i, weaponName in ipairs( BlinkControlReleaseWeapons ) do
			if MapState.EquippedWeapons[weaponName] then
				SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "RequireControlRelease", Value = false, DataValue = false })
			end
		end
		
		SetThreadWait( "DashWeapon", CurrentRun.Hero.DashManeuverTimeThreshold )
		local equippedWeaponData = GetWeaponData( CurrentRun.Hero, GetEquippedWeapon())
		if equippedWeaponData.EndEffectsOnBlink then
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Names = equippedWeaponData.EndEffectsOnBlink })
		end
		CheckAutoSprintEnd()
		if triggerArgs.name == "WeaponBlink" then
			for _, actionData in ipairs( GetHeroTraitValues( "OnBlinkEndAction" ) ) do
				if _G[actionData.FunctionName] ~= nil then
					_G[actionData.FunctionName]( ShallowCopyTable( actionData.FunctionArgs ), triggerArgs)
				end
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
		
		if weaponData.MagnetismMultiplier and  SessionMapState.MagnetismMultiplier then
			for id, data in pairs( SessionMapState.AutoMagnetizeIds ) do
				data.MagnetismMultiplier = weaponData.MagnetismMultiplier
			end
				
			local playerMagnetism = SessionMapState.MagnetismMultiplier * GetBaseDataValue({ Type = "Obstacle", Name = "LobAmmoPack", Property = "Magnetism"})
			local ammoPacks  = GetIdsByType({ Name = "LobAmmoPack"})
			for _, ammoId in pairs( ammoPacks ) do 
				if GetDistance ({ Id = ammoId, DestinationId = CurrentRun.Hero.ObjectId }) >= playerMagnetism then 
					SetObstacleProperty({ Property = "Magnetism", Value = 1/SessionMapState.MagnetismMultiplier, DestinationId = ammoId, ValueChangeType = "Multiply" })
				end
			end
			SessionMapState.MagnetismMultiplier = nil
		end

		if HeroHasTrait("LobCloseAttackAspect") and triggerArgs.Blocked then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
		end
		
		if HeroHasTrait("LobSturdySpecialTrait") then
			EndLobSturdy()
		end
		if HeroHasTrait("LeapCritTalent") and SessionMapState.LeapCritVolleys.WeaponLobSpecial then
			local value = GetFirstKey( SessionMapState.LeapCritVolleys.WeaponLobSpecial )
			if value then
				RemoveLeapCritVolley({ WeaponName = "WeaponLobSpecial", ProjectileVolley =  value })
			end
		end
		if HeroHasTrait("PowerDrinkBoon") and SessionMapState.DrinkCritVolleys.WeaponLobSpecial then
			local value = GetFirstKey( SessionMapState.DrinkCritVolleys.WeaponLobSpecial )
			if value then
				RemoveDrinkCritVolley({ WeaponName = "WeaponLobSpecial", ProjectileVolley =  value })
			end
		end

		if SessionMapState.ThrowWeaponDeferred then
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "LobWeaponInvulnerable"})
			
			if HeroHasTrait("LobImpulseAspect") then
				thread(CheckSkullImpulseStart)
			end
			if not weaponData.ManualThrowReversion then
				SessionMapState.ThrowWeaponDeferred = nil
				ApplyDeferredThrowReversions( weaponData )
			end
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
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "SetAimlineAlpha", Parameters = { 0 }  })
	
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

function StartTorchCharge( weaponData, stagesData )
	local weaponName = weaponData.Name
	local perfectChargeWindow = GetTotalHeroTraitValue("StagePerfectChargeWindow", { FirstValue = true })
	if perfectChargeWindow > 0 and weaponData.CustomEarlyReleaseWindow then
		perfectChargeWindow = weaponData.CustomEarlyReleaseWindow 
	end
	if not HeroHasTrait("TorchAutofireAspect") and perfectChargeWindow > 0 then
		local timeout = stagesData[1].Wait * GetLuaWeaponSpeedMultiplier( weaponName )
		SessionMapState.NextPerfectChargeTimeStart = _worldTime + timeout - perfectChargeWindow
		SessionMapState.NextPerfectChargeTimeEnd = _worldTime + timeout
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
		for i, weaponFiredData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnWeaponFiredFunctions ) do
			if weaponFiredData.FunctionName ~= nil and ( weaponFiredData.ValidWeaponsLookup == nil or weaponFiredData.ValidWeaponsLookup[weaponName] ) then
				thread( CallFunctionName, weaponFiredData.FunctionName, GetWeaponData( CurrentRun.Hero, weaponName), weaponFiredData.FunctionArgs, 
				{
					OwnerTable = CurrentRun.Hero,
					Charge = 1,
					IsEx = true,
					ManuallyTriggered = true,
				})
			end
		end
	end
end

function TorchExEmpowerSetup( args )
	if GetTotalHeroTraitValue("AutofireOmegaSpeedMultiplier", {IsMultiplier = true}) ~= 1 then
		local speedEffectName = "SpeedBoostEffect"
		local dataProperties = ShallowCopyTable(EffectData[speedEffectName].DataProperties )
		dataProperties.Modifier = 1 / GetTotalHeroTraitValue("AutofireOmegaSpeedMultiplier", {IsMultiplier = true}) 
		dataProperties.Duration = args.PrimaryExInterval
		ApplyEffect({DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = speedEffectName, DataProperties = dataProperties })
	end

	local threadName = "TorchExEmpower"
	SessionMapState.LastExMove = "WeaponTorch"
	if SetThreadWait( threadName, args.PrimaryExInterval ) then
		return
	end
	if args.PrimaryExVfx then
		CreateAnimation({ Name = args.PrimaryExVfx, DestinationId = CurrentRun.Hero.ObjectId })
	end
	thread( TorchExEmpowerPresentationStart )
	SessionMapState.EmpoweredEx = true
	SessionMapState.TorchPrimaryCacheDirty = true
	if SessionMapState.SprintBonusCharge then
		SessionMapState.SprintBonusCharge = nil
		SessionMapState.SprintBonusEx = true
	end
	if HeroHasTrait("MagicCritMetaUpgrade") and SessionMapState.LastExMove ~= "WeaponTorch" then
		SessionMapState.DifferentOmegaEx = true
	else
		SessionMapState.DifferentOmegaEx = nil
	end
	SetThreadWait("SupayAttackAutofire", 0.05)
	waitUnmodified( args.PrimaryExInterval, threadName )
	SessionMapState.EmpoweredEx = nil
	SessionMapState.TorchPrimaryCacheDirty = true
	SessionMapState.SprintBonusEx = nil
	if args.PrimaryExVfx and CurrentRun.Hero.ObjectId ~= nil then
		local hasMarkers = HasMarker({ Id = CurrentRun.Hero.ObjectId, Name = "WeaponHecateL_Rig:flame03_C_joint"}) and HasMarker({ Id = CurrentRun.Hero.ObjectId, Name = "WeaponHecateR_Rig:flame03_C_joint"})
		StopAnimation({ Name = args.PrimaryExVfx, DestinationId = CurrentRun.Hero.ObjectId, PreventChain = not hasMarkers, IncludeCreated = not hasMarkers })
		if hasMarkers then
			thread( TorchExEmpowerPresentationEnd )
		end
	end
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
	if HeroHasTrait("TorchAutofireAspect") and stageReached == 1  then
		local trait = GetHeroTrait("TorchAutofireAspect")
		thread( PlaySupaySpecialLoop, trait.SetupFunction.Args.SpecialSounds, true)
		SessionMapState.TorchExSpecial = true
		ExpireProjectiles({ ProjectileIds = SessionMapState.TorchOrbitIds })
		local count =  2 + GetTotalHeroTraitValue("TorchSpecialCountIncrease")
		local createdProjectileIds = {}
		local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		local weaponName = "WeaponTorchSpecial"
		local projectileName = "ProjectileTorchOrbitEx"
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName,
			Type = "Projectile",
		})
		for i=1,count do
			projectileName = "ProjectileTorchOrbitEx"
			derivedValues.PropertyChanges.Fuse = 5 + GetTotalHeroTraitValue("AutofireSpecialDurationBonus")
			derivedValues.PropertyChanges.ReturnToOwnerAfterInactiveSeconds = 5 + GetTotalHeroTraitValue("AutofireSpecialDurationBonus")/2
			local projectileId = CreateProjectileFromUnit({ 
				WeaponName = weaponName, 
				Name = projectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationId = CurrentRun.Hero.ObjectId, 
				Angle = angle + 360/count * (i-1), 
				DisableEffects = true,
				DataProperties = derivedValues.PropertyChanges, 
				ThingProperties = derivedValues.ThingPropertyChanges,
				FizzleOldestProjectileCount = count,
				})
			table.insert( createdProjectileIds, projectileId )
			if SessionMapState.SprintBonusCharge then
				SessionMapState.SprintBonusProjectiles[ projectileId ] = true
			end
		end
		
		IncrementTableValue(SessionMapState, "TorchExSpecialTriggers", count )
		SessionMapState.SprintBonusCharge = nil
		for i, weaponFiredData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnWeaponFiredFunctions ) do
			if weaponFiredData.FunctionName ~= nil and ( weaponFiredData.ValidWeaponsLookup == nil or weaponFiredData.ValidWeaponsLookup[weaponName] ) then
				thread( CallFunctionName, weaponFiredData.FunctionName, GetWeaponData( CurrentRun.Hero, weaponName), weaponFiredData.FunctionArgs, 
				{
					OwnerTable = CurrentRun.Hero,
					Charge = 1,
					IsEx = true,
					ManuallyTriggered = true,
				})
			end
		end
		AutofireLogProjectilesForFireEvent( "WeaponTorchSpecial", createdProjectileIds, { ClearOnFirstHit = true, IsEx = true })
		
		if HeroHasTrait("MagicCritMetaUpgrade") and SessionMapState.LastExMove ~= weaponName then
			SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
			for _, id in pairs( createdProjectileIds ) do
				SessionMapState.DifferentOmegaProjectileIds[weaponName][id] = true
			end
		end
		SessionMapState.LastExMove = weaponName
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
		local stageData = chargeStages[MapState.WeaponCharge[weaponData.Name]]
		local cost = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost })
		local weaponName = weaponData.Name
		if CurrentRun.Hero.Mana >= cost or LastMomentManaRestoreEligible(cost) then
			if CurrentRun.Hero.Mana >= cost then
				SetManaIndicatorAllowed( weaponName )
				PulseManaIndicator()
			else
				SetManaIndicatorDisallowed( weaponName, false, GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost }) )
			end
			local manaSpend = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost}) 
			ManaDelta( -manaSpend )
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.Name, Method = "setPerfectChargeWindow", Parameters = { 0 }})
			SessionMapState.ChargeStageManaSpend[weaponName] = manaSpend

			MapState.TorchFireIndex = 1
			notifyExistingWaiters( "Empty"..weaponName.."Stage" )	
			notifyExistingWaiters( weaponName.."IndicatorFire" )
			if stageData.ResetChargeOnFire then
				thread( DoWeaponCharge, triggerArgs, weaponData )
				thread( HandleManaChargeIndicator, { name = weaponName } )
			end
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

OnControlReleased{ "Attack2",
	function( triggerArgs )
		if CurrentRun and CurrentRun.Hero and CurrentRun.Hero.Weapons.WeaponTorch then
			CheckEarlyPowershot()
		end
	end
}

function CheckEarlyPowershot()
	local weaponName = "WeaponTorch"
	if not SessionMapState.NextPerfectChargeTimeStart or not SessionMapState.NextPerfectChargeTimeEnd then
		return
	end
	if _worldTime > SessionMapState.NextPerfectChargeTimeStart and _worldTime <= SessionMapState.NextPerfectChargeTimeEnd then
		local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
		if IsEmpty( MapState.WeaponDataValues ) then
			ApplyWeaponChanges( CurrentRun.Hero, weaponData.ChargeWeaponStages[1], weaponData, { PropertyChangesOnly = true })
		end
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "forceCooldown", Parameters = { 0 }})
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "setPerfectChargeWindow", Parameters = { 0.01 }})
		 SessionMapState.NextPerfectChargeTimeStart = nil
		 SessionMapState.NextPerfectChargeTimeEnd = nil
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

OnWeaponFired{ "WeaponLob",
	function( triggerArgs )
		if HasHeroTraitValue("UnlimitedAmmo") then
			return
		end
		SessionMapState.AmmoAtFireStart = GetCurrentAmmo( triggerArgs.name )
		if HeroHasTrait("LobSpreadShotTrait") then
			UpdateWeaponAmmo( triggerArgs.name, -triggerArgs.NumProjectiles)
			IncrementTableValue( SessionMapState, "LobAmmoInFlight", triggerArgs.NumProjectiles )
		else
			IncrementTableValue( SessionMapState, "LobAmmoInFlight" )
			SpendAmmo( triggerArgs.name )	
		end
		thread( UpdateAmmoUI )
		if triggerArgs.ProjectileId and ( not HasHeroTraitValue("SkipAutoLobMagnetism") or IsExWeapon( triggerArgs.name, {Combat = true},  triggerArgs) ) then
			SessionMapState.AutoMagnetizeIds[ triggerArgs.ProjectileId ] = { MagnetismMultiplier = 1 }
		end
	end
}

function WeaponLobAmmoDrop( triggerArgs, weaponDataArgs )
	if not SessionMapState.LobAmmoInFlight or SessionMapState.LobAmmoInFlight <= 0 then
		return
	end
	-- Stripped optimized version of CreateConsumableItem( consumableId, "LobAmmoPack" )
	local consumableData = ConsumableData.LobAmmoPack
	local consumable = DeepCopyTable( consumableData )
	local consumableId = SpawnObstacle({ Name = "LobAmmoPack", --nopkg
		LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Group = "Standing",
		TriggerOnSpawn = false, AttachedTable = consumable })	
	consumable.ObjectId = consumableId
	AddToGroup({Id = consumableId, Name = "UsedFishingPoint" })	-- A little silly but we want to be able to collect ammo while fishing
	local ammoDropData = weaponDataArgs.DropForces
	DecrementTableValue( SessionMapState, "LobAmmoInFlight" )
	if HeroHasTrait("LobAmmoMagnetismTrait") then
		SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = GetTotalHeroTraitValue("MagnetismSpeedMultiplier"), ValueChangeType = "Multiply", DestinationId = consumableId })
	end
	consumable.ProjectileVolley = triggerArgs.ProjectileVolley
	if triggerArgs.HasImpact ~= nil and weaponDataArgs.CollideForces then
		ammoDropData = weaponDataArgs.CollideForces
	end
	if weaponDataArgs.Cooldown then
		UseableOff({ Id = consumableId })
		thread( UseableOnDelay, { consumableId }, weaponDataArgs.Cooldown )
	end
	local magnetismMultiplier = GetTotalHeroTraitValue("AmmoMagnetismMultiplier", { IsMultiplier = true } )
	if not triggerArgs.Armed then
		if SessionMapState.MagnetismMultiplier then
			magnetismMultiplier = SessionMapState.MagnetismMultiplier * magnetismMultiplier
		elseif SessionMapState.AutoMagnetizeIds[ triggerArgs.ProjectileId ] then
			local playerMagnetism = GetBaseDataValue({ Type = "Obstacle", Name = "LobAmmoPack", Property = "Magnetism"})
			if GetDistance ({ Id = consumableId, DestinationId = CurrentRun.Hero.ObjectId }) <= SessionMapState.AutoMagnetizeIds[ triggerArgs.ProjectileId ].MagnetismMultiplier * magnetismMultiplier * playerMagnetism then 
				magnetismMultiplier = SessionMapState.AutoMagnetizeIds[ triggerArgs.ProjectileId ].MagnetismMultiplier * magnetismMultiplier
			end
		end
	end
	SetObstacleProperty({ Property = "Magnetism", Value = magnetismMultiplier, DestinationId = consumableId, ValueChangeType = "Multiply" })
	ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.UpwardForceMin or 0, ammoDropData.UpwardForceMax or 0 ) })
	if ammoDropData.ForceMax ~= nil then
		local scatter = 0
		if ammoDropData.Scatter then
			scatter = RandomFloat( -(ammoDropData.Scatter)/2, (ammoDropData.Scatter)/2)
		end
		ApplyForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.ForceMin, ammoDropData.ForceMax ), Angle = triggerArgs.Angle + scatter, SelfApplied = true })
	end
	thread( EscalateMagnetism, consumable )
	SessionMapState.AutoMagnetizeIds[ triggerArgs.ProjectileId ] = nil
end

function CheckLobPulse( touchdowner, functionArgs, triggerArgs )
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
		if cost > CurrentRun.Hero.Mana and not LastMomentManaRestoreEligible( cost ) then
			return
		else	
			ManaDelta(-cost, { IgnoreSpend = true, ManaDrain = true })
		end
	end
	FireWeaponFromUnit({ Weapon = args.PulseWeaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	
end

function UpdateLobWeaponProjectileNum( triggerArgs, weaponData )
	local weaponName = weaponData.Name
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = GetCurrentAmmo(weaponName) })
end

function CheckSprintBoons( triggerArgs )
	local enemyIds = nil

	for _, dashData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnSprintAction ) do
		
		if dashData.FunctionName ~= nil then
			if dashData.RunOnce then
				CallFunctionName( dashData.FunctionName, ShallowCopyTable( dashData.Args ), triggerArgs )
			else
				if enemyIds == nil then
					enemyIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = 250 })
				end
				for i, id in pairs( enemyIds ) do
					if ActiveEnemies[id] then
						CallFunctionName( dashData.FunctionName, ActiveEnemies[id], ShallowCopyTable( dashData.Args ), triggerArgs )
					end
				end
			end
		else
			if enemyIds == nil then
				enemyIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, PreciseCollision = true, Distance = 250 })
			
			end
			if not IsEmpty( enemyIds ) then
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
end

function ShieldBlock( triggerArgs, functionArgs )
	local attacker = triggerArgs.Attacker
	local blockingWeaponName = triggerArgs.WeaponName
	if not functionArgs.MaxDistance or ( triggerArgs.DistanceSquared and triggerArgs.DistanceSquared <= ( functionArgs.MaxDistance * functionArgs.MaxDistance )) then

		if triggerArgs.BlockedProjectileName ~= nil then
			local blockedProjectileData = ProjectileData[triggerArgs.BlockedProjectileName]
			if blockedProjectileData ~= nil and not blockedProjectileData.StunOnBlocked then
				return
			end
		end

		ApplyEffect({ DestinationId = attacker.ObjectId, Id = attacker.ObjectId, EffectName = functionArgs.EffectName , DataProperties = EffectData[functionArgs.EffectName].EffectData })
	end
end

function FireCastAtLocation( triggerArgs )
	if triggerArgs.LocationX and triggerArgs.LocationY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		FireWeaponFromUnit({ Weapon = "WeaponCast", Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		Destroy({Id = dropLocation })
	end 		
end

function FireAnywhereCastAtLocation( owner, weaponData, functionArgs, triggerArgs )
	if triggerArgs.ProjectileX and triggerArgs.ProjectileY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY  })
		FireWeaponFromUnit({ Weapon = "WeaponCast", Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		local doubleBoltChance = GetTotalHeroTraitValue("DoubleBoltChance")
		if RandomChance(doubleBoltChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
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

function ClearSuitMarkers()
	for _, marks in pairs( SessionMapState.MarkImages ) do
		Destroy({ Ids = marks })
	end
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
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle, 
			PerfectCharge = triggerArgs.PerfectCharge})
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
	if stageReached >= 1 and not FrameState[weaponName.."PostFireFail"] then
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
		local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId}) 
		for id in pairs(SessionMapState.SuitChargedAttackIds) do
			SetAngle({ ProjectileId = id, Angle = math.rad(angle) })
		end
		if not SessionMapState.CancelSuitExBlinkForce and not HeroHasTrait("SuitComboAspect") then
			ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = stageData.Force, Angle = angle + 180, SelfApplied = true})
		else
			SessionMapState.CancelSuitExBlinkForce = nil
		end
		if not HeroHasTrait("SuitComboAspect") or HeroHasTrait("SuitAttackRangeTrait") then
			DetachProjectiles({ Ids = GetAllKeys(SessionMapState.SuitChargedAttackIds), DestinationId = CurrentRun.Hero.ObjectId })
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

function CheckSuitEnemiesInRange( triggerArgs, weaponData )
	if weaponData.DisableSeek then
		return
	end
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
		SessionMapState.ManaIndicatorCustomHSV = weaponData.NoTargetHSV
	end
end

function SuitChargeStage( weaponName, stageData )
	SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "AutoLock", Value = false })
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	if weaponData.DisableSeek then
		return
	end
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
	while SessionMapState.SuitSeeking and ( CurrentRun.Hero.Mana >= SessionMapState.SuitCost or LastMomentManaRestoreEligible( SessionMapState.SuitCost )) do
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
				ScaleY = weaponData.SeekScaleY,
				AngleCheckUsesScaleY = true,
				PreciseCollision = true
			})
		local eligibleTargets = {}
		local eligibleUnmarkedTargets = {}
		for _, id in pairs(nearbyTargetIds) do
			if ActiveEnemies[id] 
				and (( ActiveEnemies[id].TrainingTarget ) or (not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers))  then
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
				if CurrentRun.Hero.Mana < nextCost and not LastMomentManaRestoreEligible( nextCost ) then		
					SetManaIndicatorDisallowed( weaponName, false, SessionMapState.SuitCost )
				else
					local markStatus = SpawnObstacle({ Name = "BlankObstacle", DestinationId = nearbyTargetId, Group = "Combat_UI_World_Add" })
					SetAnimation({ Name = "SuitMarkStatusIn", DestinationId = markStatus })
					local targetEnemy = ActiveEnemies[nearbyTargetId]
					local markerName = nil
					if targetEnemy ~= nil then
						markerName = targetEnemy.SuitMarkStatusMarkerName
					end
					Attach({ Id = markStatus, DestinationId = nearbyTargetId, MarkerName = markerName })

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
							MapState.ShowManaChargeIndicator = true
						end
					end
					if TableLength(SessionMapState.TargetedEnemies) == weaponData.MaxTargets then
					
						local perfectChargeWindow = GetTotalHeroTraitValue("StagePerfectChargeWindow", { FirstValue = true })
						if perfectChargeWindow > 0 then
							RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.Name, Method = "setPerfectChargeWindow", Parameters = { perfectChargeWindow }})
						end
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
			SessionMapState.ManaIndicatorCustomHSV = nil			
			SetManaIndicatorAllowed( weaponData.Name )
		end
		waitUnmodified( weaponData.SeekInterval * GetTotalHeroTraitValue("SeekIntervalMultiplier", {IsMultiplier = true}), RoomThreadName )
	end
	SessionMapState.ManaIndicatorCustomColor = nil
	SessionMapState.ManaIndicatorCustomHSV = nil
	SessionMapState.ValidSuitRangedTargets = nil
	
	if weaponData.SeekEffect then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = weaponData.SeekEffect })
	end
end

function SuitBaseMissileAttack( weaponData, projectileName )
	if MapState.HostilePolymorph
		or FrameState.SpellFired
		or SessionMapState.WeaponsDisabled
		or ( CurrentRun.Hero.IsDead and ( CurrentHubRoom == nil or not CurrentHubRoom.AllowEnemyAIActive )) then
		return
	end

	if weaponData.SkipFunctionFire then
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
	if weaponData.ForceMarker then
		firstMarker = weaponData.ForceMarker
		secondMarker = weaponData.ForceMarker
	end
	CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
		DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
		SpawnFromMarker = firstMarker })
	if not weaponData.ForceSingleProjectile then
		derivedValues.PropertyChanges.StartDelay = 0.1
		CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
			DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
			SpawnFromMarker = secondMarker })
	end
	PlaySound({ Name = "/SFX/Player Sounds/MelinoeSuitSpecialPreLaunch", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteAttackingBombLob", Id = CurrentRun.Hero.ObjectId })
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
	
	if weaponData.DisableSeek then
		SetMenuOptions({ Name = "InGameUI", Properties = { Run = "ResetReticles" } })
		if stageReached < 1 then
			thread( SuitBaseMissileAttack, weaponData, projectileName )
		end
		return
	end
	StopAnimation({ Name = weaponData.SeekGuideMid, DestinationId = CurrentRun.Hero.ObjectId })
	SessionMapState.ManaIndicatorCustomColor = nil
	SessionMapState.ManaIndicatorCustomHSV = nil
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
		local perfectCharge = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "PerfectChargeWindowRemaining" }) > 0 
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
				DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, PerfectCharge = perfectCharge  })
			
			if splitValid then
				SessionMapState.ValidSplitIds[projectile] = true
			end
			if HeroHasTrait("DoubleExManaBoon") and i <=2 then
				-- invisible nerf: only spawn 2 doubled missiles with exceptional talent
				local doubledMissile = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, 
					DestinationId = invisibleTarget, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, PerfectCharge = perfectCharge  })
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

function BlockSelfBuff( blocker, args, triggerArgs )
	if not blocker or not blocker.ObjectId then
		return
	end
	if triggerArgs.WeaponName == "WeaponSuitCharged" then
		local trait = GetHeroTrait("SuitComboAspect")
		local functionArgs = trait.OnProjectileDeathFunction.Args
		local effectName = functionArgs.EffectName
		local dataProperties = MergeTables(EffectData[effectName].DataProperties, functionArgs.DataProperties)
		ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
		
		if CurrentRun.Hero.ActiveEffects[effectName] >= trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks then
			SessionMapState.ShivaMaxStackPresentation = true
			SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.SuitUI })
		end
		IncrementTableValue( CurrentRun.Hero.ActiveEffects, effectName, args.Stacks - 1 )
		UpdateSuitUI()
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
			SessionMapState.InvalidSplitIds[projectile] = true
		end
	end
end

function CheckMissileOnHit(unit, args, triggerArgs)
	if not args.Chance or not RandomChance(args.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
		return
	end
	if GetProjectileCount({ Names = {"ProjectileSuitRangedUnguided", "ProjectileSuitRangedGuided", "ProjectileSuitRangedChargedUnguided", "ProjectileSuitRangedCharged", "ProjectileSuitRangedChargedSplit", "ProjectileSuitRangedGuidedSplit"} }) > 6 then
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

function ProjectileRecordUnitWaveHit( projectileName, volleyNum, waveNum, unitId )
	if not waveNum or not projectileName then
		return false
	end
	if not SessionMapState.WaveHitRecord[projectileName] then
		SessionMapState.WaveHitRecord[projectileName] = {}
	end 
	if not SessionMapState.WaveHitRecord[projectileName][volleyNum] then
		-- auto-clear record on volley change
		SessionMapState.WaveHitRecord[projectileName] = {}
		SessionMapState.WaveHitRecord[projectileName][volleyNum] = {}
	end 
	if not SessionMapState.WaveHitRecord[projectileName][volleyNum][waveNum] then
		SessionMapState.WaveHitRecord[projectileName][volleyNum][waveNum] = {}
	end
	SessionMapState.WaveHitRecord[projectileName][volleyNum][waveNum][unitId] = true
end

function ProjectileHasUnitWaveHit( projectileName, volleyNum, waveNum, unitId )
	if not waveNum or not projectileName then
		return false
	end
	if not SessionMapState.WaveHitRecord[projectileName] then
		return false
	end
	if not SessionMapState.WaveHitRecord[projectileName][volleyNum] then
		return false
	end
	if not SessionMapState.WaveHitRecord[projectileName][volleyNum][waveNum] then
		return false
	end
	return SessionMapState.WaveHitRecord[projectileName][volleyNum][waveNum][unitId]
end

function ApolloExSetup( hero, args )
	SessionMapState.ElapsedTimeMultiplierIgnores.DelayedProjectile = true
end

function CreateProjectileFromUnitDelay( args, delay )
	
	local fireFromId = nil
	if args.FireFromCurrentHeroLocation then
		fireFromId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId })
		args.FireFromId = fireFromId
	end
	wait( delay, "DelayedProjectile" )
	if not CurrentRun.Hero.IsDead then
		local projectileId = CreateProjectileFromUnit( args )
		if args.CreateFunctionName then
			CallFunctionName( args.CreateFunctionName, projectileId )
		end
	end
	if fireFromId then
		Destroy({Id = fireFromId})
	end
end