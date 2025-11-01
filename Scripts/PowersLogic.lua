-- |MELEE & RANGED WEAPONS| --

function CheckPlayerOnFirePowers( triggerArgs )
	local firedWeaponName = triggerArgs.name
	
	if CurrentRun.Hero.ManaRegenSources.IdleManaRegen then
		StopIdleManaRegenerationPresentation()
	end
	for i, functionArgs in ipairs( CurrentRun.Hero.HeroTraitValuesCache.SetupFunction ) do
		if functionArgs.Name == "IdleManaRegenSetup" then
			CurrentRun.Hero.ManaRegenSources.IdleManaRegen = nil
			if not IsMoving({ Id = CurrentRun.Hero.ObjectId }) then
				if HasThread("IdleManaRegen") then
					SetThreadWait( "IdleManaRegen", functionArgs.Args.MovePenaltyDuration )
				else
					thread( IdleManaRegen )
				end
			else		
				killTaggedThreads("IdleManaRegen")
			end
		end
	end

	if CurrentRun.Hero.OnFireWeapons == nil then
		return
	end

	local weaponFireOverrides = {}
	for i, data in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OverrideWeaponFireNames ) do
		weaponFireOverrides = MergeTables( weaponFireOverrides, data )
	end

	if weaponFireOverrides[ firedWeaponName ] == "nil" then
		return
	elseif weaponFireOverrides[ firedWeaponName ] then
		firedWeaponName = weaponFireOverrides[ firedWeaponName ]
	end

	if CurrentRun.Hero.OnFireWeapons[firedWeaponName] ~= nil then
		for weaponName, weaponData in pairs( CurrentRun.Hero.OnFireWeapons[firedWeaponName] ) do
			if type(weaponData) == "table" then
				if weaponData.UseTargetLocation and triggerArgs.TargetX and triggerArgs.TargetY then
					local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY })
					FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
					Destroy({ Id = targetId })
				else
					FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
				end
			else
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
end

function CheckOnDamagedPowers( victim, attacker, args )
	local isCrit = args.IsCrit
	local weaponName = args.SourceWeapon
	local currentRun = CurrentRun

	if args.SkipOnDamagedPowers then
		return
	end

	local victimWillBeAlive = victim.Health ~= nil and args.DamageAmount ~= nil and (( victim.HealthBuffer and victim.HealthBuffer > 0) or (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim ) )
	--DebugPrint({ Text = "victimWillBeAlive = "..tostring(victimWillBeAlive) })

	if not victim.IsPolymorphed and victimWillBeAlive then
		if attackerId == nil or attacker.TriggersOnDamageEffects then
			if victim.OnDamagedFireProjectiles ~= nil and CheckCooldown("OnDamagedFireProjectilesCooldown"..victim.ObjectId, victim.OnDamagedFireProjectilesCooldown or 0) then
				for k, projectileData in pairs( victim.OnDamagedFireProjectiles ) do
					if projectileData.Requirements == nil or IsGameStateEligible( projectileData, projectileData.Requirements) then
						projectileData.Id = victim.ObjectId
						projectileData.TargetId = GetTargetId(victim, projectileData)
						thread(ProcessFireProjecile, victim, projectileData)
					end
				end
			end
			if victim.OnDamagedWeaponInterrupt ~= nil then
				if WeaponData[victim.OnDamagedWeaponInterrupt] ~= nil and IsEnemyWeaponEligible( victim, WeaponData[victim.OnDamagedWeaponInterrupt] ) then
					if CheckCooldown("OnDamagedWeaponCooldown"..victim.ObjectId, victim.OnDamagedWeaponCooldown) then
						victim.ForcedWeaponInterrupt = victim.OnDamagedWeaponInterrupt
						if victim.PreAttackLoopingSoundId ~= nil then
							StopSound({ Id = victim.PreAttackLoopingSoundId, Duration = 0.2 })
							victim.PreAttackLoopingSoundId = nil
						end
						notifyExistingWaiters( victim.AINotifyName )
						SetThreadWait( victim.AIThreadName, 0.1 )
					end
				end
			end	
		end
	end	
	if victim ~= CurrentRun.Hero or victimWillBeAlive then 
		if victim.ActiveEffects ~= nil then
			for effectName in pairs( victim.ActiveEffects ) do
				local effectData = EffectData[effectName]
				if effectData ~= nil and effectData.OnDamagedFunctionName ~= nil and ( effectData.TriggerOnKillingBlow or victimWillBeAlive ) then
					thread( CallFunctionName, effectData.OnDamagedFunctionName, victim, args )
				end
			end
		end
	end
	if attacker ~= nil then
		local victimId = victim.ObjectId
		if not victim.SkipModifiers and weaponName and IsExWeapon( weaponName, { Combat = true } , args ) and not ProjectileHasUnitHit(args.ProjectileVolley, weaponName ) then
			ProjectileRecordUnitHit( args.ProjectileVolley, weaponName )
			if SessionMapState.ChargeStageManaSpend[weaponName] and not CanChargeSpell() then
				ChargeSpell(-SessionMapState.ChargeStageManaSpend[weaponName], { Force = true } )
			end
		end
	end

	if isCrit and attacker ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId and attacker ~= victim and victim.TriggersOnDamageEffects then
		for i, functionData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.OnEnemyCrittedFunction ) do
			CallFunctionName( functionData.Name, victim, functionData.Args )
		end
	end

	local summonShareBonus = {}
	for i, traitData in ipairs( CurrentRun.Hero.HeroTraitValuesCache.AddSummonWeaponsToTraits ) do
		summonShareBonus[traitData.Slot] = true
	end
	local weaponShareBonus = {}
	for i, traitData in pairs( CurrentRun.Hero.HeroTraitValuesCache.AddWeaponsToTraits ) do
		if traitData.WeaponName then
			weaponShareBonus[traitData.Slot] = { [traitData.WeaponName] = true }
		elseif traitData.WeaponNames then
			weaponShareBonus[traitData.Slot] = traitData.WeaponNamesLookup
		end
	end
	
	if attacker ~= nil and ( attacker == CurrentRun.Hero or Contains(MapState.SpellSummons, attacker)) and victim.TriggersOnDamageEffects then
		local weaponData = GetWeaponData( CurrentRun.Hero, args.SourceWeapon )
		if weaponData ~= nil and weaponData.OnEnemyDamagedFunction ~= nil then
			CallFunctionName( weaponData.OnEnemyDamagedFunction.FunctionName, victim, ShallowCopyTable( weaponData.OnEnemyDamagedFunction.Args ), args )
		end
		for i, traitData in ipairs( CurrentRun.Hero.Traits ) do
			if traitData.OnEnemyDamagedAction ~= nil and not traitData.OnEnemyDamagedAction.ValidEffectName then 
				local actionData = traitData.OnEnemyDamagedAction
				local validWeapons = actionData.ValidWeaponsLookup == nil or ( actionData.ValidWeaponsLookup[ args.SourceWeapon] ~= nil and args.EffectName == nil )
				local validProjectiles = actionData.ValidProjectilesLookup == nil or ( actionData.ValidProjectilesLookup[ args.SourceProjectile ] ~= nil and args.EffectName == nil )
				local validChance = actionData.Chance == nil or RandomChance(actionData.Chance * GetTotalHeroTraitValue("LuckMultiplier", {IsMultiplier = true}))
				local validTrait = actionData.RequiredTraitName == nil or HeroHasTrait(actionData.RequiredTraitName)
				if not validWeapons then
					if traitData.Slot and summonShareBonus[traitData.Slot] and Contains( MapState.SpellSummons, attacker ) then
						validWeapons = true
					end
					if traitData.Slot and weaponShareBonus[traitData.Slot] and weaponShareBonus[traitData.Slot][args.SourceWeapon] and args.EffectName == nil then
						validWeapons = true
					end
				end

				if actionData.ExcludeProjectilesLookup and actionData.ExcludeProjectilesLookup[args.SourceProjectile] then
					validProjectiles = false
				end
				local projectileHitId = args.ProjectileId
				if weaponData and weaponData.UniqueDetonationHits and args.Detonation then
					projectileHitId = args.ProjectileId .. tostring(args.Detonation)
				end
				if validWeapons and validProjectiles and actionData.FunctionName ~= nil and ( not actionData.FirstHitOnly or not ProjectileHasUnitHit( projectileHitId, actionData.FunctionName ) ) then
					ProjectileRecordUnitHit( projectileHitId, actionData.FunctionName )
					local actionArgs = ShallowCopyTable( actionData.Args ) or {}
					actionArgs.VictimWillBeAlive = victimWillBeAlive
					CallFunctionName( actionData.FunctionName, victim, actionArgs, args )
				end
				if (actionData.EffectName ~= nil or actionData.EffectNames ~= nil) and victimWillBeAlive then
					if validWeapons and validProjectiles and validChance then
						local effectNames = ShallowCopyTable( actionData.EffectNames ) or {}
						local effectArgs = ShallowCopyTable( actionData.Args ) or {}
						if actionData.EffectName then
							table.insert( effectNames, actionData.EffectName )
							table.insert( effectArgs, actionData.Args or {} )
						end
						for i, effectName in pairs( effectNames ) do
							local dataProperties = MergeTables( EffectData[effectName].EffectData, effectArgs[i] )
							ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, ImpactAngle = math.rad(args.ImpactAngle), DataProperties = dataProperties })
						end
					
					end
				end
			end
		end
	end
	local validVictim = false
	if victim == CurrentRun.Hero then
		validVictim = true
	end
	if attacker ~= CurrentRun.Hero and HeroHasTrait( "SummonRetaliateTalent" ) and Contains( MapState.SpellSummons, victim ) then
		validVictim = true
	end
	local projectileData = ProjectileData[args.SourceProjectile] or {}
	if validVictim and ( attacker ~= victim or projectileData.SelfDamage )
		and ( not args.SourceProjectile or not projectileData.BypassRetaliate ) 
		and victimWillBeAlive then
		for i, functionData in pairs( GetHeroTraitValues("OnSelfDamagedFunction") ) do 
			local validRetaliateTarget = (victim == CurrentRun.Hero) or (not functionData.NotDamagingRetaliate)
			local shouldBypass = (not functionData.NotDamagingRetaliate and projectileData.BypassDamagingRetaliate)
			if validRetaliateTarget and not shouldBypass then
				CallFunctionName( functionData.Name, attacker, functionData.FunctionArgs, args )
			end
		end
	end

	if not victim.IsDead and victimWillBeAlive and IsEmpty( victim.InvulnerableFlags ) and args.EffectName then
		local effectData = EffectData[args.EffectName]
		if effectData then
			if effectData.CreateAnimationOnDamage then
				CreateAnimation({ Name = effectData.CreateAnimationOnDamage, DestinationId = victim.ObjectId, Scale = victim.EffectVfxScale })
			end
			if effectData.ApplyEffectOnDamage then
				local effectName = effectData.ApplyEffectOnDamage
				local source = args.AttackerTable
				local sourceId = CurrentRun.Hero.ObjectId
				if source then
					sourceId = source.ObjectId
				end
				
				ApplyEffect({ 
					DestinationId = victim.ObjectId, 
					Id = sourceId, 
					EffectName = effectName,
					DataProperties = EffectData[effectName].EffectData,
				})
			end
		end
		for i, actionData in ipairs( GetHeroTraitValues( "OnEnemyDamagedAction" ) ) do
			local validEffects = actionData.AllEffectsTrigger or ( args.EffectName == actionData.ValidEffectName )
			if _G[actionData.FunctionName] ~= nil and validEffects then
				_G[actionData.FunctionName](victim, ShallowCopyTable( actionData.Args ), args)
			end
			if actionData.EffectName ~= nil or actionData.EffectNames ~= nil then
				if validEffects then
					local effectNames = ShallowCopyTable( actionData.EffectNames ) or {}
					local effectArgs = ShallowCopyTable( actionData.Args ) or {}
					if actionData.EffectName then
						table.insert( effectNames, actionData.EffectName )
						table.insert( effectArgs, actionData.Args or {} )
					end
					local impactAngle = args.ImpactAngle or 0
					for i, effectName in pairs( effectNames ) do
						local dataProperties = MergeTables( EffectData[effectName].EffectData, effectArgs[i] )
						ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, ImpactAngle = math.rad(impactAngle), DataProperties = dataProperties })
					end
					
				end
			end
		end
	end
end

function FreezeStunApply( triggerArgs )
	thread( HitByFreezeWeapon, triggerArgs.Victim )
end

function StasisStunApply( triggerArgs )
	local victim = triggerArgs.Victim

	if victim == nil or victim.IsDead then
		return
	end

	if not victim.CanBeFrozen then
		return
	end

	EndRamWeapons({ Id = victim.ObjectId })

	StasisPresentation( victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	victim.Frozen = true
	victim.Mute = true
end

function StasisStunClear( triggerArgs )
	local victim = triggerArgs.Victim	
	if victim.Frozen then
		local notifyName = "FreezeStunExpired"..victim.ObjectId
		NotifyOnEffectExpired({ Id = victim.ObjectId, Notify = notifyName, EffectName = "FreezeStun" })
		waitUntil( notifyName )
		UnfrozenPresentation( victim )
	end
	victim.Frozen = false
	victim.Mute = false
end

function OnHitStunApply( triggerArgs )
	local victim = triggerArgs.Victim

	if IsEmpty( victim.StunAnimations ) then
		return
	end

	thread( FinishTargetMarker, victim )

	if victim.StopOnHitStun then
		Stop({ Id = victim.ObjectId })
	end

	if not IsEmpty( victim.ExpireProjectileIdsOnHitStun ) then
		ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnHitStun })
	end

	if not IsEmpty( victim.ClearEffectsOnHitStun ) then
		ClearEffect({ Id = victim.ObjectId, Names = victim.ClearEffectsOnHitStun })
	end

	if not IsEmpty( victim.StopAnimationsOnHitStun ) then
		StopAnimation({ Names = victim.StopAnimationsOnHitStun, DestinationId = victim.ObjectId, PreventChain = true })
	end

	if victim.CancelWeaponComboOnHitStun then
		victim.ActiveWeaponCombo = nil
	end

	if victim.CancelChainedWeaponOnHitStun then
		victim.ChainedWeapon = nil
	end

	if not IsEmpty( victim.StopSoundsOnHitStun ) then
		StopSound({ Ids = GetAllValues( victim.StopSoundsOnHitStun ), Duration = 0.2 })
	end

	if victim.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = victim.PreAttackLoopingSoundId, Duration = 0.2 })
	end
end

function OnHitStunClear( triggerArgs )
	local victim = triggerArgs.Victim

	if victim.IsDead or not victim.Health or victim.Health <= 0 then
		return
	end

	if victim.DumbFireWeapons ~= nil then
		for k, weaponName in pairs( victim.DumbFireWeapons ) do
			if WeaponData[weaponName].RestartOnHitStunClear then
				thread( DumbFireAttack, victim, weaponName )
			end
		end
	end
end

function CheckLavaPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead then
		StartOrRefreshLavaPresentation()
	end
end

function CheckLavaSplashPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead and triggerArgs.SourceProjectile and triggerArgs.SourceProjectile == "LavaPuddleLarge" then
		StartOrRefreshLavaPresentation()
	end
end

function MedeaPoisonApply( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then
		if not CurrentRun.Hero.IsDead then
			StartPoisonPresentation(unit)
		end
	end
end

function MedeaPoisonClear( triggerArgs )
	local unit = triggerArgs.Victim
	EndPoisonPresentation()
end

function MedeaPoisonAllyBoostApply( triggerArgs )
	if not triggerArgs.Reapplied then
		SetThingProperty({ Property = "AddColor", Value = false, DestinationId = triggerArgs.Victim.ObjectId })
		SetColor({ Id = triggerArgs.Victim.ObjectId, Color = { 213, 255, 135, 255 } })
		CreateAnimation({ Name = "MedeaPoisonBuffFx", DestinationId = triggerArgs.Victim.ObjectId, Group = "FX_Standing_Add" })
		-- @ this should be in a presentation function
		PlaySound({ Name = "/SFX/Player Sounds/DionysusShieldDash", Id =  triggerArgs.Victim.ObjectId })
		thread( PlayVoiceLines, triggerArgs.Victim.PoisonBuffVoiceLines, true, triggerArgs.Victim )
	end
end

function TimeElementalHealApply( triggerArgs )
	local unit = triggerArgs.Victim
	Heal( unit, { HealAmount = triggerArgs.Amount, triggeredById = unit.ObjectId, OffsetY = -200 } )
	CreateAnimation({ Name = "Heal", DestinationId = unit.ObjectId })
	UpdateHealthBar( unit, 0, { Force = true } )
end

function MedeaPoisonAllyBoostClear( triggerArgs )
	SetColor({ Id = triggerArgs.Victim.ObjectId, Color = Color.White })
	StopAnimation({ Name = "MedeaPoisonBuffFx", DestinationId = triggerArgs.Victim.ObjectId })
end

function LavaVignetteApply( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then
		if not CurrentRun.Hero.IsDead then
			StartOrRefreshLavaPresentation()
		end
	end
end

function LavaVignetteClear( triggerArgs )
	local unit = triggerArgs.Victim
	-- No op
end

function EnlargeApply(triggerArgs)
	local victim = triggerArgs.Victim
	local effectData = EffectData[triggerArgs.EffectName]

	if victim.Enlarged or victim == CurrentRun.Hero then
		return
	end

	victim.OriginalScale = GetThingDataValue({ Id = victim.ObjectId, Property = "Scale" })
	SetScale({ Id = victim.ObjectId, Fraction = victim.OriginalScale * effectData.ScaleMultiplier, Duration = 0.5 })
	StopAnimation({ Name = "SatyrRatCatcherSpellBuffFx", DestinationId = victim.ObjectId, })
	CreateAnimation({ Name = "SatyrRatCatcherSpellBuffFx", DestinationId = victim.ObjectId, })

	victim.MaxHealth = victim.MaxHealth * effectData.HealthMultiplier
	victim.Health = victim.Health * effectData.HealthMultiplier
	victim.EnlargedHealthMultiplier = effectData.HealthMultiplier
	if victim.MaxHealthBuffer ~= nil then
		victim.MaxHealthBuffer = victim.MaxHealthBuffer * effectData.HealthMultiplier
		victim.HealthBuffer = victim.HealthBuffer * effectData.HealthMultiplier
	end

	victim.OutgoingDamageModifiers = victim.OutgoingDamageModifiers or {}
	table.insert( victim.OutgoingDamageModifiers, { Name = "EnlargeSatyrBuff", PlayerMultiplier = effectData.DamageMultiplier } )
	victim.Enlarged = true
end

function PolymorphEnlargeClear( enemy )
	enemy.Enlarged = false
	StopAnimation({ Name = "SatyrRatCatcherSpellBuffFx", DestinationId = enemy.ObjectId, })
	SetScale({ Id = enemy.ObjectId, Fraction = enemy.OriginalScale, Duration = 0 })
	RemoveOutgoingDamageModifier(enemy, "EnlargeSatyrBuff" )
	enemy.MaxHealth = round(enemy.MaxHealth / enemy.EnlargedHealthMultiplier)
	enemy.Health = round(enemy.Health / enemy.EnlargedHealthMultiplier)
	if enemy.MaxHealthBuffer ~= nil then
		enemy.MaxHealthBuffer =  round(enemy.MaxHealthBuffer / enemy.EnlargedHealthMultiplier)
		enemy.HealthBuffer =  round(enemy.HealthBuffer / enemy.EnlargedHealthMultiplier)
	end
end

function EnlargeClear(triggerArgs)
	local victim = triggerArgs.Victim
		
	if victim and victim.Enlarged then
		StopAnimation({ Name = "SatyrRatCatcherSpellBuffFx", DestinationId = victim.ObjectId, })
		SetScale({ Id = victim.ObjectId, Fraction = victim.OriginalScale, Duration = 0.5 })
	end
end

function InsideCastBuffApply( triggerArgs )
	local unit = triggerArgs.Victim
	if not triggerArgs.Reapplied and triggerArgs.Victim == CurrentRun.Hero then
		if not CurrentRun.Hero.ManaRegenSources.CastCircleRegen then
			CreateAnimation({ Name = EffectData[triggerArgs.EffectName].ManaRegenStartVfx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		end
		CurrentRun.Hero.ManaRegenSources.CastCircleRegen = { Value = 0 }
		if HasHeroTraitValue("InsideCastSpeed") then
			if SessionMapState.InsideCastSpeedPropertyChanges then
				ApplyUnitPropertyChanges( CurrentRun.Hero, SessionMapState.InsideCastSpeedPropertyChanges, true, true )
			else
				local totalSpeedChange = GetTotalHeroTraitValue("InsideCastSpeed")
				local allPropertyChanges= {}
				local speedPropertyChange = 		
				{
					WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
					ChangeValue = totalSpeedChange,
					SpeedPropertyChanges = true,
				}
				for q, weaponName in pairs(speedPropertyChange.WeaponNames) do
					
					local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
					if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
						newPropertyChanges = DeepCopyTable( WeaponData[weaponName].SpeedPropertyChanges)
					end
					for s, newPropertyChange in pairs(newPropertyChanges) do
						newPropertyChange = MergeTables( newPropertyChange, speedPropertyChange )
						newPropertyChange.WeaponNames = nil
						newPropertyChange.WeaponName = weaponName
						newPropertyChange.ChangeType = "Multiply"
						if newPropertyChange.InvertSource then
							if newPropertyChange.ChangeValue then
								newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
							end
						end
						newPropertyChange.SpeedPropertyChanges = nil
						table.insert(allPropertyChanges, newPropertyChange )
					end
				end
				SessionMapState.InsideCastSpeedPropertyChanges = allPropertyChanges
				ApplyUnitPropertyChanges( CurrentRun.Hero, SessionMapState.InsideCastSpeedPropertyChanges )	
			end
		end
	end
end

function InsideCastBuffClear( triggerArgs )
	local unit = triggerArgs.Victim
	if unit == CurrentRun.Hero then	
		if EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx then
			StopAnimation({ Name = EffectData[triggerArgs.EffectName].MetaUpgradeActiveVfx, DestinationId = unit.ObjectId })
		end
		if HasHeroTraitValue("InsideCastSpeed") and SessionMapState.InsideCastSpeedPropertyChanges then	
			ApplyUnitPropertyChanges( CurrentRun.Hero, SessionMapState.InsideCastSpeedPropertyChanges, true, true)
		end
		thread( CastCircleManaRegen )
	end
end

function ImpactSlowApply( triggerArgs )
	if not triggerArgs.Reapplied then
		thread( PlayVoiceLines, HeroVoiceLines.RootedFoesVoiceLines, true )
		thread( PlayVoiceLines, GlobalVoiceLines.SkellyRootReactionVoiceLines, true )
	end
end

function TimeSlowApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
		CallFunctionName( EffectData[triggerArgs.EffectName].OnApplyPresentationFunctionName, victim, triggerArgs.triggeredById )
		if not victim.IgnoreTimeSlowEffects then
			local oldMultiplier = victim.SpeedMultiplier or 1
			if victim.SpeedMultiplier then
				victim.SpeedMultiplier = victim.SpeedMultiplier * triggerArgs.ElapsedTimeMultiplier
			else
				victim.SpeedMultiplier = triggerArgs.ElapsedTimeMultiplier
			end
			if victim.AIThreadName then
				SetElapsedTimeMultiplier( victim.SpeedMultiplier / oldMultiplier, victim.AIThreadName)
			end
			if victim.InterruptWeaponOnFreeze then
				victim.ForcedWeaponInterrupt = true
			end
			if victim.EndAIThreadWaitOnFreezeEnd then
				SetThreadWait(victim.AIThreadName, 0.01)
			end
			if not IsEmpty( victim.ExpireProjectileIdsOnFreeze ) then
				ExpireProjectiles({ ProjectileIds = victim.ExpireProjectileIdsOnFreeze })
			end
			if victim.WeaponFireLoopingSoundId ~= nil then
				PauseSound({ Id = victim.WeaponFireLoopingSoundId, Duration = 0.2 })
			end
		end
	end
end

function TimeSlowUpdate( triggerArgs )
	local unit = triggerArgs.Victim
	if unit.SpeedMultiplier then
		if EffectData[triggerArgs.EffectName].Vfx ~= nil then
			StopAnimation({ Name = EffectData[triggerArgs.EffectName].Vfx, DestinationId = unit.ObjectId })
		end
		if EffectData[triggerArgs.EffectName].BackVfx ~= nil then
			StopAnimation({ Name = EffectData[triggerArgs.EffectName].BackVfx, DestinationId = unit.ObjectId })
		end
		if not IsEmpty ( EffectData[triggerArgs.EffectName].StopVfxes ) then
			StopAnimation({ Names = EffectData[triggerArgs.EffectName].StopVfxes, DestinationId = unit.ObjectId })
		end
		CallFunctionName( EffectData[triggerArgs.EffectName].OnStackDecreasePresentationFunctionName, unit, triggerArgs.triggeredById )
		if not unit.IgnoreTimeSlowEffects then
			local oldMultiplier = unit.SpeedMultiplier
			unit.SpeedMultiplier = unit.SpeedMultiplier * triggerArgs.ElapsedTimeMultiplier / triggerArgs.OldElapsedTimeMultiplier
		
			if unit.AIThreadName then
				SetElapsedTimeMultiplier( unit.SpeedMultiplier / oldMultiplier, unit.AIThreadName)
			end
		end
		local newElapsedTimeMultiplier = unit.SpeedMultiplier or 1.0
		if not unit.IgnoreTimeSlowEffects then
			newElapsedTimeMultiplier = newElapsedTimeMultiplier * GetGameplayElapsedTimeMultiplier( unit.ObjectId )
		end
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = newElapsedTimeMultiplier, ValueChangeType = "Absolute", DataValue = false, DestinationId = unit.ObjectId })
	end
end

function TimeSlowClear( triggerArgs )
	local unit = triggerArgs.Victim
	
	local oldMultiplier = unit.SpeedMultiplier or 1
	CallFunctionName( EffectData[triggerArgs.EffectName].OnClearPresentationFunctionName, unit, triggerArgs.triggeredById )
	
	if unit.IgnoreTimeSlowEffects then
		return
	end	
	if unit.SpeedMultiplier and not unit.IgnoreTimeSlowEffects then
		unit.SpeedMultiplier = unit.SpeedMultiplier / triggerArgs.ElapsedTimeMultiplier
	else
		unit.SpeedMultiplier = 1
	end
	if unit.AIThreadName then
		SetElapsedTimeMultiplier( unit.SpeedMultiplier / oldMultiplier, unit.AIThreadName)
	end
	local newElapsedTimeMultiplier = unit.SpeedMultiplier or 1.0
	if not unit.IgnoreTimeSlowEffects then
		newElapsedTimeMultiplier = newElapsedTimeMultiplier * GetGameplayElapsedTimeMultiplier( unit.ObjectId )
	end
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = newElapsedTimeMultiplier, ValueChangeType = "Absolute", DataValue = false, DestinationId = unit.ObjectId })

	if unit.WeaponFireLoopingSoundId ~= nil and (unit.Health or 0) > 0 then
		ResumeSound({ Id = unit.WeaponFireLoopingSoundId, Duration = 0.0 })
	end
end

function FreezeFrameApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied then
		ChillApplyPresentation( victim, victim.ObjectId )
		SetThingProperty({ Property = "AnimFreeze", Value = true, DestinationId = victim.ObjectId, DataValue = false })
	end
end

function FreezeFrameClear( triggerArgs )
	local victim = triggerArgs.Victim
	SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
	local idleGraphic = GetThingDataValue({ Id = victim.ObjectId, Property = "Graphic" })
	SetAnimation({ DestinationId = victim.ObjectId, Name = idleGraphic })
	ChillClearPresentation( victim, victim.ObjectId )
end

function ClearReserveManaInvulnerability()
	thread( VulnerableAfterDelay, 1, nil , "ManaReserveTraitInvulnerability" )
end

function ClearRoot(victim, functionArgs, triggerArgs)
	ClearEffect({ Id = victim.ObjectId, Name = functionArgs.EffectName })
end

-- |DASH WEAPONS| --
OnWeaponFired{ "RamWeapon",
	function(triggerArgs)
		for i, dashData in pairs( GetHeroTraitValues("DashProperties") ) do
			ProcessDashProperties( dashData )
			thread( PostProcessDashThread, dashData )
		end
	end
}

function ProcessDashProperties( args )
	if args == nil then
		return
	end
	if args.MoveGraphic then
		SetUnitProperty({ Property = "MoveGraphic", Value = args.MoveGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.StopGraphic then
		SetUnitProperty({ Property = "StopGraphic", Value = args.StopGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.CosmeticRotationSpeed then
		SetUnitProperty({ Property = "CosmeticRotationSpeed", Value = args.CosmeticRotationSpeed, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.ColorGrade then
		AdjustColorGrading({ Name = args.ColorGrade, Duration = args.ColorGradeStartDuration or 0 })
	end
	if args.RadialBlurStrength then
		AdjustRadialBlurStrength({ Fraction = args.RadialBlurStrength, Duration = args.RadialBlurStartDuration or 0 })
	end
	if args.RadialBlurDistance then
		AdjustRadialBlurDistance({ Fraction = args.RadialBlurDistance, Duration = args.RadialBlurStartDuration or 0 })
	end
	if args.FullscreenBloom then
		AdjustFullscreenBloom({ Name = args.FullscreenBloom, Duration = args.FullscreenBloodStartDuration or 0 })
	end
	if args.StartCue then
		PlaySound({ Name = args.StartCue, Id = CurrentRun.Hero.ObjectId, ManagerCap = 46 })
	end
	if args.AudioFilter then
		SetSoundCueValue({ Id = GetMixingId({}), Names = { args.AudioFilter }, Value = 1.0 })
	end
	if args.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = args.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam" } })
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = args.ElapsedTimeMultiplier, DataValue = false, AllProjectiles = true })
		if CurrentRun.CurrentRoom.ElapsedTimeMultiplier == nil then
			CurrentRun.CurrentRoom.ElapsedTimeMultiplier = 1
		end

		CurrentRun.CurrentRoom.ElapsedTimeMultiplier = CurrentRun.CurrentRoom.ElapsedTimeMultiplier * args.ElapsedTimeMultiplier
	end
	if args.TimeModifierFraction then
		SetThingProperty({ Property = "TimeModifierFraction", Value = args.TimeModifierFraction, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.SimulationSlowSpeed then
		AddSimSpeedChange( "Dash", { Fraction = args.SimulationSlowSpeed, LerpTime = args.SimulationSlowSpeedLerp or 0 } )
	end
end

function PostProcessDashThread( args )
	wait( args.Duration, RoomThreadName )
	PostProcessDashProperties( args )
end

function PostProcessDashProperties( args )
	if args == nil then
		return
	end
	if args.MoveGraphic then
		SetUnitProperty({ Property = "MoveGraphic", Value = "MelinoeRun", DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.StopGraphic then
		SetUnitProperty({ Property = "StopGraphic", Value = "MelinoeStop", DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.CosmeticRotationSpeed then
		SetUnitProperty({ Property = "CosmeticRotationSpeed", Value = 1340, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.ColorGrade then
		AdjustColorGrading({ Name = "Off", Duration = 0.1 })
	end
	if args.FullscreenBloom then
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })
	end
	if args.RadialBlurStrength then
		AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.1 })
	end
	if args.RadialBlurDistance then
		AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.1 })
	end
	if args.EndCue then
		PlaySound({ Name = args.EndCue, Id = CurrentRun.Hero.ObjectId, ManagerCap = 46 })
	end
	if args.AudioFilter then
		SetSoundCueValue({ Id = GetMixingId({}), Names = { args.AudioFilter }, Value = 0.0 })
	end
	if args.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/args.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam" } })
		CurrentRun.CurrentRoom.ElapsedTimeMultiplier = CurrentRun.CurrentRoom.ElapsedTimeMultiplier * 1/args.ElapsedTimeMultiplier
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = CurrentRun.CurrentRoom.ElapsedTimeMultiplier, DataValue = false, AllProjectiles = true })
	end
	if args.TimeModifierFraction then
		SetThingProperty({ Property = "TimeModifierFraction", Value = 1.0, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.SimulationSlowSpeed then
		RemoveSimSpeedChange( "Dash", { LerpTime = args.SimulationSlowSpeedRestoreLerp or 0 } )
	end
end

function FireWeaponWithinRange( args )
	if args.InitialDelay then
		waitUnmodified(args.InitialDelay)
	end

	local sourceTargetId = args.SourceId or CurrentRun.Hero.ObjectId
	local count = args.Count or 1
	local simultaneousTargets = args.Targets or 1
	local targetDelay = args.TargetDelay or 0
	local bonusChance = args.BonusChance or 0
	local damageMultiplier = args.DamageMultiplier or 1
	local yScale = args.YScale or 0.65
	local range = args.Range or 200
	local seekTarget = args.SeekTarget
	local chooseTarget = args.TargetId
	local weaponName = args.WeaponName
	local projectileName = args.ProjectileName 
	local runFunctionOnTarget = args.RunFunctionNameOnTarget
	local runFunctionArgsOnTarget = args.RunFunctionArgsOnTarget
	
	local createdObstacleId = nil
	if not weaponName and not projectileName then
		return
	end

	count = count + math.floor(bonusChance)
	if RandomChance( bonusChance ) then
		count = count + 1
	end
	for i = 1, count do
		local chosenTargets = {}
		for s = 1, simultaneousTargets do
			local nearestEnemyTarget = 0
			local targetId = SessionMapState.FireWithinRangeId
			if not targetId then
				SessionMapState.FireWithinRangeId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId })
			end
			if chooseTarget ~= nil then
				targetId = chooseTarget
			else
				if seekTarget then
					local validIds = GetClosestIds({ Id = sourceTargetId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true, Distance = range, ScaleY = yScale, MaximumCount = simultaneousTargets, PreciseCollision = true })
					for _, id in pairs(validIds) do
						if not chosenTargets[id] then
							nearestEnemyTarget = id
							chosenTargets[id] = true
							break
						end
					end
				end
				if nearestEnemyTarget == 0 then
					if args.FireWithoutTarget then
						local randomLightningTargetOffsetX = RandomFloat(-1 * range/2, range/2)
						local randomLightningTargetOffsetY = RandomFloat(-1 * range/2, range/2)
						Teleport({ Id = targetId, DestinationId = sourceTargetId, OffsetX = randomLightningTargetOffsetX, OffsetY = randomLightningTargetOffsetY })
					end
				else
					targetId = nearestEnemyTarget
				end
			end
			if targetId ~= 0 and (args.FireWithoutTarget or (ActiveEnemies[targetId] and not ActiveEnemies[targetId].IsDead)) then
				CreateProjectileFromUnit({ 
					Name = projectileName, 
					WeaponName = weaponName,
					Id = CurrentRun.Hero.ObjectId, 
					DamageMultiplier = damageMultiplier, 
					DestinationId = targetId, 
					FireFromTarget = true })
				if runFunctionOnTarget and (ActiveEnemies[targetId] and not ActiveEnemies[targetId].IsDead) then
					CallFunctionName( runFunctionOnTarget, { Id = targetId, Args = runFunctionArgsOnTarget} )
				end
			end
			waitUnmodified( args.TargetDelay )
		end
		waitUnmodified( args.Delay )
	end
end

function ApolloBlindStrike( unit, traitArgs )
	if unit and HasVulnerabilityGenusEffect( unit, traitArgs.ValidActiveEffectGenus ) and CheckCooldown( "ApolloBlindStrike", traitArgs.Cooldown ) then
		CreateProjectileFromUnit({ Name = traitArgs.ProjectileName or "ApolloPerfectDashStrike", Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier})
	end
end

function SetupCastCast( unit, args )

	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponCastProjectile", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end
function SetupAnywhereCast( unit, args )

	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponAnywhereCast", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end

function SetupLobCast( unit, args )
	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponCastLob", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end

function GetRequiredForceToEnemy( nearById, id, distanceScalar, distanceMultiplier )
	distanceScalar = distanceScalar or 0
	distanceMultiplier = distanceMultiplier or 1
	local distance = (GetDistance({ Id = nearById, DestinationId = id }) + distanceScalar ) * distanceMultiplier 
	if distance <= 0 then
		return 0
	end
	local force = RunPhysicsMethod({ Id = nearById, Method = "GetRequiredForce", Parameters = { distance } })
	return force
end

function HeraRetaliate( unit, args, triggerArgs )
	if not unit or unit.SkipModifiers or IsUntargetable({Id = unit.ObjectId}) or not CheckCooldown( "HeraRetaliate"..unit.ObjectId, args.Cooldown ) then
		return
	end
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = unit.ObjectId, DamageMultiplier = triggerArgs.DamageAmount * args.Multiplier })
	if unit and not unit .IsDead and IsEmpty( unit.InvulnerableFlags ) and not unit.SkipModifiers and unit.TriggersOnHitEffects then	
		ApplyDamageShare( unit, { EffectName = "DamageShareEffect" })	
	end
end

function ApolloRetaliate( unit, args )
	if not unit or unit.SkipModifiers or not CheckCooldown( "ApolloRetaliate"..unit.ObjectId, args.Cooldown ) then
		return
	end
	
	thread( ApolloRetaliateThread, args )
end

function ApolloRetaliateThread( args )
	for id, enemy in pairs( ShallowCopyTable( ActiveEnemies) ) do
		if enemy and (MapState.AggroedUnits[id] or RequiredKillEnemies[id] ) and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and not enemy.SkipModifiers and enemy.TriggersOnHitEffects and not IsUntargetable({Id = enemy.ObjectId}) then
			CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = args.DamageMultiplier})	
			ApplyEffect( { DestinationId = enemy.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = EffectData[args.EffectName].EffectData })
			wait(0.05)
		end
	end
end

function ZeusRetaliate( unit, args )
	if not unit or unit.SkipModifiers or not CheckCooldown( "ZeusRetaliate"..unit.ObjectId, args.Cooldown ) then
		return
	end
	local strikeCount = 1
	while RandomChance( args.ConsecutiveStrikeChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) and strikeCount < args.MaxStrikes do
		strikeCount = strikeCount + 1
	end
	if strikeCount > 1 then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BoltRetaliate_CombatText", LuaKey = "TempTextData", ShadowScaleX = 1.1, LuaValue = { Amount = strikeCount }} )
	end
	CreateZeusBolt({
		ProjectileName = args.ProjectileName, 
		TargetId = unit.ObjectId, 
		DamageMultiplier = args.DamageMultiplier,
		Delay = 0.1, 
		FollowUpDelay = 0.5, 
		Count = strikeCount
		})
end

function ClearBlindEffect( victim, functionArgs, triggerArgs )
	ClearEffect({ Id = victim.ObjectId, Name = "BlindEffect"})
end

function CheckCastVolley( victim, functionArgs, triggerArgs )
	local weaponName = triggerArgs.SourceWeapon
	if IsExWeapon( weaponName, { Combat = true } , triggerArgs ) and triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and not ProjectileData[triggerArgs.SourceProjectile].IsAdditionalCastProjectile then
		local offset = CalcOffset( math.rad( GetAngle({ Id = victim.ObjectId }) ), functionArgs.SpawnDistance )
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = victim.ObjectId })
		local angle = GetAngle({ Id = victim.ObjectId }) + 180
		wait( functionArgs.Delay * (SessionState.ArtemisCastProjectiles or 0), RoomThreadName)
		CreateProjectileFromUnit({ 
			Name = functionArgs.ProjectileName,
			Id = CurrentRun.Hero.ObjectId,
			DestinationId = dropLocation,
			FireFromTarget = true,
			OffsetX = offset.X,
			OffsetY = offset.Y,
			Angle = angle,
			DamageMultiplier = functionArgs.DamageMultiplier,
			ProjectileCap = functionArgs.ProjectileCap,
		})
		PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = dropLocation, ManagerCap = 46 })
		IncrementTableValue( SessionState, "ArtemisCastProjectiles" )
		thread(DestroyOnDelay, {dropLocation}, 0.1)		
	end
end

function SetBaseChargeTimes(hero, args )
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.ObjectId then
		return
	end
	local weaponNames = args.WeaponNames
	for _, weaponName in pairs( weaponNames ) do
		local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" })
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "BaseChargeTime", Value = chargeTime, ValueChangeType = "Absolute", DataValue = false})
	end
end

function RemoveCastVolleyProjectile(triggerArgs)
	if triggerArgs.name and triggerArgs.name == "ArtemisCastVolley" then
		DecrementTableValue( SessionState, "ArtemisCastProjectiles" )
	end
end

function CheckSupportingFire( victim, functionArgs, triggerArgs )
	if ProjectileHasUnitHit( triggerArgs.ProjectileId, "SupportFire") and (triggerArgs.SourceProjectile == nil or not functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile])  then
		return
	end
	local cooldown = functionArgs.Cooldown or 0.1667
	local passesHitCheck = CheckCooldown("SupportFire", window )
	
	if triggerArgs.SourceProjectile ~= nil and functionArgs.MultihitProjectileWhitelistLookup and functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile] and functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile] then
		local conditions = functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile]
		if conditions.Window and CheckCountInWindow("SupportFire", conditions.Window, conditions.Count ) then
			passesHitCheck = true
		end
	end
	if passesHitCheck and not ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
		local angle = functionArgs.StartAngle
		if angle and functionArgs.Scatter then
			angle = angle + RandomFloat(-functionArgs.Scatter, functionArgs.Scatter)
		end
		
		ProjectileRecordUnitHit( triggerArgs.ProjectileId, "SupportFire" )
		CreateProjectileFromUnit({
				Name = functionArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationId = victim.ObjectId,
				Angle = angle + triggerArgs.ImpactAngle,
				DamageMultiplier = functionArgs.DamageMultiplier,
				FizzleOldestProjectileCount = functionArgs.FizzleOldestProjectileCount,
				ProjectileCap = functionArgs.ProjectileCap,
			})
	end
end

function SetupBloodDropDisplay()
	if not HeroHasTrait("DummyBloodDisplayBoon") then
		AddTraitToHero({ TraitName = "DummyBloodDisplayBoon" })
	end
end

function CheckBloodDropDisplay()
	
	if not HeroHasTrait("RendBloodDropBoon") and not HeroHasTrait("AresManaBoon") and not HeroHasTrait("BloodDropRevengeBoon") then
		RemoveTrait( CurrentRun.Hero, "DummyBloodDisplayBoon" )
	end
end
function CarryOverBloodDropBonus( hero, args )
	if not CurrentRun or not GetPreviousRoom(CurrentRun) then
		return
	end
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BloodDropCount > 0 then
		return
	end
	local prevRoom = GetPreviousRoom( CurrentRun )
	if not prevRoom.BloodDropCount then
		return
	end
	CreateAnimation({ Name = "AresMelBuff", DestinationId = CurrentRun.Hero.ObjectId })
	if args.Multiplier then
		CurrentRun.CurrentRoom.BloodDropCount = math.ceil( prevRoom.BloodDropCount * args.Multiplier )
	end
	if args.Cap then
		CurrentRun.CurrentRoom.BloodDropCount = math.min( CurrentRun.CurrentRoom.BloodDropCount, args.Cap )
	end
	CurrentRun.CurrentRoom.BloodDropBonus = (CurrentRun.CurrentRoom.BloodDropCount * ConsumableData.BloodDrop.SpeedBonus) * 100
	prevRoom.BloodDropCount = 0
	UpdateBloodDropSpeed()
end

function CheckAresBloodDrop( victim, functionArgs, triggerArgs )
	if RandomChance( functionArgs.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) and victim and victim.ActiveEffects and (functionArgs.RequiredEffect == nil or victim.ActiveEffects[functionArgs.RequiredEffect] )then
		thread( CreateBloodDrop, victim, functionArgs )
	end
end

function SpawnSelfBloodDrop( attacker, functionArgs, triggerArgs )
	local victim = triggerArgs.Victim
	local cooldown = functionArgs.Cooldown or 0.25
	if not victim or not victim.Health or victim.Health < 0 or victim.IsDead or not CheckCooldown( "AresAutoBlood", cooldown ) or triggerArgs.DamageAmount <= 0 then
		return
	end
	thread( CreateBloodDrop, victim, functionArgs )
end

function CheckAresManaBloodDrop( victim, functionArgs, triggerArgs )
	if RandomChance( functionArgs.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) then
		thread( CreateBloodDrop, victim, functionArgs )
	end
end

function CreateBloodDrop( unit, functionArgs )

	local bloodDropData = ConsumableData[functionArgs.Name]
	local cap = bloodDropData.SpawnCap or 10
	local numExisting = TableLength( MapState.BloodDrops )
	if numExisting >= cap then
		return
	end

	local count = 1
	if functionArgs.DoubleChance and RandomChance( functionArgs.DoubleChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ) ) then
		count = 2
	end
	
	for i = 1, count do
		-- Stripped optimized version of CreateConsumableItem( bloodDropId, functionArgs.Name, 0 )
		local bloodDrop = DeepCopyTable( bloodDropData )
		local bloodDropId = SpawnObstacle({ Name = functionArgs.Name, DestinationId = unit.ObjectId, Group = "Standing",
			TriggerOnSpawn = false, AttachedTable = bloodDrop })
		bloodDrop.ObjectId = bloodDropId
		MapState.BloodDrops[bloodDrop.ObjectId] = bloodDrop

		local dropArgs = bloodDrop.DropArgs
		local upwardForceMin = dropArgs.UpwardForceMin or 600
		local upwardForceMax = dropArgs.UpwardForceMax or 800
		local forceMin = dropArgs.ForceMin or 600
		local forceMax = dropArgs.ForceMax or 850
		local duration = dropArgs.Duration
		local expireFx = dropArgs.ExpireFx or "AresBloodDropletDissipate"
		local sound = dropArgs.Sound or "/Leftovers/Menu Sounds/CoinFlash"
		ApplyUpwardForce({ Id = bloodDropId, Speed = RandomFloat( upwardForceMin, upwardForceMax ) })
		ApplyForce({ Id = bloodDropId, Speed = RandomFloat( forceMin, forceMax ), Angle = RandomFloat( 0, 360 ), SelfApplied = true })
		if CurrentRun.Hero.HeroTraitValuesCache.MagnetizeBloodDrops[1] ~= nil then
			SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationId = bloodDropId })
		end
		if functionArgs.Sound then
			PlaySound({ Name = functionArgs.Sound, Id = id, ManagerCap = 42 })
		end
		thread( BloodDropExpire, bloodDrop, dropArgs )
		wait( 0.02 ) -- Distribute over frames
	end
end

function BloodDropExpire( bloodDrop, args )
	wait( args.Duration )
	if MapState.BloodDrops[bloodDrop.ObjectId] ~= nil then
		MapState.BloodDrops[bloodDrop.ObjectId] = nil
		CreateAnimation({ DestinationId = bloodDrop.ObjectId, Name = args.ExpireFx })
		Destroy({ Id = bloodDrop.ObjectId })
	end
end

function BloodDropUse( args, consumable )
	local count = 1 * GetTotalHeroTraitValue( "BloodDropMultiplier", { IsMultiplier = true } )
	MapState.BloodDrops[consumable.ObjectId] = nil
	CurrentRun.CurrentRoom.BloodDropCount = CurrentRun.CurrentRoom.BloodDropCount + count
	SetAnimation({ Name = "AresBloodDropletDissipate", DestinationId = consumable.ObjectId })
	thread( BloodDropUsePresentation, args, consumable )
	wait(0.15) -- Finish animation
	if CurrentRun.CurrentRoom.BloodDropCount == 0 then
		CreateAnimation({ Name = "AresMelBuff", DestinationId = CurrentRun.Hero.ObjectId })
	end
	
	ManaDelta( GetTotalHeroTraitValue( "DropManaRestore") * count )
	CurrentRun.CurrentRoom.BloodDropBonus = (CurrentRun.CurrentRoom.BloodDropCount * ConsumableData.BloodDrop.SpeedBonus) * 100
	UpdateBloodDropSpeed()
	if HeroHasTrait("BloodManaBurstBoon") and RandomChance( GetTotalHeroTraitValue("DropManaBurstChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) then
		thread( CreateManaBurst, GetHeroTrait("BloodManaBurstBoon").ManaBurstArgs, 1 + GetTotalHeroTraitValue("BurstCount"))
	end
	if HeroHasTrait("DummyBloodDisplayBoon") then
		local traitData = GetHeroTrait("DummyBloodDisplayBoon")
		UpdateTraitNumber( traitData )
	end
end

function UpdateBloodDropSpeed( functionArgs, healthChange )
	local totalSpeedChange = 1/(1 + CurrentRun.CurrentRoom.BloodDropCount * ConsumableData.BloodDrop.SpeedBonus )
	local speedChange = totalSpeedChange
	local bloodDropCap = 0.5

	if SessionMapState.LastSpeedChange then
		speedChange = totalSpeedChange/SessionMapState.LastSpeedChange
		if SessionMapState.LastSpeedChange <= bloodDropCap then
			CurrentRun.CurrentRoom.BloodDropBonus = (1/bloodDropCap * 100) - 100
			return
		end
	end
	local allPropertyChanges= {}
	local affectedWeapons = {}
	if SessionMapState.BloodDropWeaponNamesCache then
		affectedWeapons = SessionMapState.BloodDropWeaponNamesCache
	else
		for weaponName in pairs(CurrentRun.Hero.Weapons) do
			if WeaponSetLookups.HeroPrimarySecondaryWeapons[weaponName] then
				ConcatTableValues( affectedWeapons, AddLinkedWeapons({weaponName}))
			end
		end
		SessionMapState.BloodDropWeaponNamesCache = affectedWeapons
	end
	local speedPropertyChange = 		
	{
		WeaponNames = affectedWeapons,
		ChangeValue = speedChange,
		SpeedPropertyChanges = true,
	}
	for q, weaponName in pairs(speedPropertyChange.WeaponNames) do
					
		local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
		if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
			newPropertyChanges = DeepCopyTable( WeaponData[weaponName].SpeedPropertyChanges)
		end
		for s, newPropertyChange in pairs(newPropertyChanges) do
			if newPropertyChange.WeaponProperty ~= "ChargeTime" then
				newPropertyChange = MergeTables( newPropertyChange, speedPropertyChange )
				newPropertyChange.WeaponNames = nil
				newPropertyChange.WeaponName = weaponName
				newPropertyChange.ChangeType = "Multiply"
				if newPropertyChange.InvertSource then
					if newPropertyChange.ChangeValue then
						newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
					end
				end
				newPropertyChange.SpeedPropertyChanges = nil
				table.insert(allPropertyChanges, newPropertyChange )
			end
		end
	end
	allPropertyChanges = ConcatTableValues(allPropertyChanges, 
	{
		{
			UnitProperty = "Speed",
			ChangeType = "Multiply",
			ChangeValue = 1/speedChange,
		},
		{
			WeaponNames = { "WeaponSprint" },
			WeaponProperty = "SelfVelocity",
			ChangeValue = 1100 * (1 - speedChange),
			ChangeType = "Add",
			ExcludeLinked = true,
		},
		{
			WeaponNames = { "WeaponSprint" },
			WeaponProperty = "SelfVelocityCap",
			ChangeValue = 740 * (1 - speedChange),
			ChangeType = "Add",
			ExcludeLinked = true,
		},
	})
	if not SessionMapState.LastSpeedChange then
		SessionMapState.LastSpeedChange = 1
	end
	SessionMapState.LastSpeedChange = SessionMapState.LastSpeedChange * speedChange
	SetPlayerAttackSpecialChargeSpeed( "BloodDropSpeed", totalSpeedChange )
	ApplyUnitPropertyChanges( CurrentRun.Hero, allPropertyChanges )
end

function CheckAutoRevenge( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName ~= functionArgs.EffectName or triggerArgs.Reapplied then
		return
	end
	if CheckCooldown(victim.ObjectId .. "AutoRevengeCooldown", functionArgs.Cooldown * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true } )) then
		local triggerArgs = { ManuallyTriggered = true, Victim = CurrentRun.Hero, DamageAmount = 10}
		for i, functionData in pairs( GetHeroTraitValues("OnSelfDamagedFunction") ) do
			thread( CallFunctionName, functionData.Name, victim, functionData.FunctionArgs, triggerArgs )
		end	
	end
end

function RaiseKilledEnemy( enemy, args )
	if MapState.RaiseDeadCount then
		return
	end
	if enemy.UniqueRaise and not IsEmpty(MapState.SpellSummons) then
		for i, unit in pairs( MapState.SpellSummons ) do
			if unit.Name == enemy.Name then
				return
			end
		end
	end

	local enemyName = enemy.Name
	local enemyData = EnemyData[enemyName]
	if enemyData and (( not enemyData.IsBoss and not enemyData.BlockRaiseDead ) or enemyData.ForceAllowRaiseDead ) then
		IncrementTableValue(MapState, "RaiseDeadCount")
		local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = enemy.ObjectId })
		local summonArgs = ShallowCopyTable( WeaponData.WeaponSpellSummon.SummonMultipliers )
		if args.DamageMultiplier then
			summonArgs.DamageMultiplier = args.DamageMultiplier
		end
		summonArgs.SpawnPointId = tempObstacle
		local newEnemy = CreateAlliedEnemy( enemyName, summonArgs)
		DestroyOnDelay({ tempObstacle }, 0.1)
		CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId = newEnemy.ObjectId
		CurrentRun.CurrentRoom.AssistUnitName = enemyName
		RaiseDeadPresentation(newEnemy) 

		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap ~= nil then
			local activeCapWeight = newEnemy.ActiveCapWeight or 1
			CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap = math.min(ConstantsData.MaxActiveEnemyCount, CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap + activeCapWeight)
		end
	end
end

function CreateAlliedEnemy( enemyName, args )
	args = args or {}	
	local weaponDataMultipliers = 
	{ 
		MaxHealthMultiplier = args.MaxHealthMultiplier or 1, 
		SpeedMultiplier = args.SpeedMultiplier or 1,
		ScaleMultiplier = args.ScaleMultiplier or 1,
		DamageMultiplier = args.DamageMultiplier or 1,
	}
	local enemyData = EnemyData[enemyName]
	local newEnemy = DeepCopyTable( enemyData )
	if enemyData.AlliedScaleMultiplier then
		weaponDataMultipliers.ScaleMultiplier = enemyData.AlliedScaleMultiplier
	end
	newEnemy.BlocksLootInteraction = false
	newEnemy.AlwaysTraitor = true
	newEnemy.Charmed = true
	newEnemy.IgnoreCastSlow = true
	newEnemy.UseUniqueDamageColors = true
	newEnemy.DamageTextStartColor = Color.SummonDamageLight
	newEnemy.DamageTextColor = Color.SummonDamage
	newEnemy.MoneyDropOnDeath = nil
	newEnemy.RequiredKill = false
	newEnemy.BlockPostBossMetaUpgrades = true
	newEnemy.DefaultAIData.TargetClosest = true
	newEnemy.MaxHealth = newEnemy.MaxHealth * weaponDataMultipliers.MaxHealthMultiplier
	newEnemy.HealthBarOffsetY = (newEnemy.HealthBarOffsetY or -155 ) * weaponDataMultipliers.ScaleMultiplier
	newEnemy.HideHealthBar = true
	if newEnemy.SpellSummonDataOverrides ~= nil then
		OverwriteTableKeys(newEnemy, newEnemy.SpellSummonDataOverrides)
	end

	if newEnemy.SpellSummonDefaultAIDataOverrides ~= nil then
		OverwriteTableKeys(newEnemy.DefaultAIData, newEnemy.SpellSummonDefaultAIDataOverrides)
	end
	if args.TryUseRequiredSpawnPoint and newEnemy.RequiredSpawnPoint then
		local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, {SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = 900, AllowNoSpawnPoint = true })
		if not spawnPointId then
			spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, { AllowNoSpawnPoint = true })
		end
		if spawnPointId then
			args.SpawnPointId = spawnPointId
		end
	end
	newEnemy.BlocksLootInteraction = false

	local spawnOnId = newEnemy.SpellSummonSpawnOnId or args.SpawnPointId
	if newEnemy.SpellSummonSpawnOnIdPerMap ~= nil and newEnemy.SpellSummonSpawnOnIdPerMap[CurrentRun.CurrentRoom.Name] ~= nil then
		spawnOnId = newEnemy.SpellSummonSpawnOnIdPerMap[CurrentRun.CurrentRoom.Name]
	end

	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = spawnOnId, OffsetX = 0, OffsetY = 0 })
		
	thread( CreateAlliedEnemyPresentation, newEnemy )
	thread( SetupUnit, newEnemy, CurrentRun, { SkipPresentation = true } )
	SessionMapState.SpawnPointsUsed[spawnOnId] = newEnemy.ObjectId
	thread( UnoccupySpawnPointOnDistance, newEnemy, spawnOnId, 400 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = GetGameplayElapsedTimeMultiplier(), ValueChangeType = "Absolute", DataValue = false, DestinationId = newEnemy.ObjectId })
	AddOutgoingDamageModifier( newEnemy, { NonPlayerMultiplier = weaponDataMultipliers.DamageMultiplier })
	AddOutgoingDamageModifier( newEnemy, { PlayerMultiplier = 0, Multiplicative = true })
	
	newEnemy.SpeedMultiplier = ( newEnemy.SpeedMultiplier or 1 ) + (weaponDataMultipliers.SpeedMultiplier - 1)
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = newEnemy.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = newEnemy.ObjectId })
	RemoveAutoLockTarget({ Id = newEnemy.ObjectId })
	for i, data in pairs(newEnemy.OutgoingDamageModifiers) do
		if data.NonPlayerMultiplier and data.NonPlayerMultiplier == 0 then
			RemoveValueAndCollapse( newEnemy.OutgoingDamageModifiers, data )	
			break
		end
	end
	AddIncomingDamageModifier( newEnemy,
	{
		Name = "PlayerDeathDefense",
		PlayerMultiplier = 0.0,
	})
	AddIncomingDamageModifier( newEnemy,
	{
		Name = "EnemyDeathDefense",
		NonPlayerMultiplier = 0,
		Multiplicative = true
	})	
	SetLifeProperty({ DestinationId = newEnemy.ObjectId, Property = "JumpTargetEligible", Value = false })
	SetLifeProperty({ DestinationId = newEnemy.ObjectId, Property = "HomingEligible", Value = false })
	SetScale({ Id = newEnemy.ObjectId, Fraction = weaponDataMultipliers.ScaleMultiplier, Duration = 0 })
	AddEffectBlock({ Id = newEnemy.ObjectId, Name = "OnHitStun" })
	AddEffectBlock({ Id = newEnemy.ObjectId, Name = "OnHitStunHeavy" })
	AddEffectBlock({ Id = newEnemy.ObjectId, Name = "BlindEffect" })
	newEnemy.SummonHealthBarEffect = true
	ApplyEffect({ 
		Id = CurrentRun.Hero.ObjectId, 
		DestinationId = newEnemy.ObjectId, 
		EffectName = "Charm",
		DataProperties = { Duration = 3600 },
		})
	if not newEnemy.IgnoreAllyHitPresentation then
		newEnemy.OnHitEvents =
		{
			{
				FunctionName = "AllyHitPresentation",
			}
		}
	end

	return newEnemy
end

function SetupMercBaseDamageBonus( hero, args )
	SessionMapState.ShadeMercBaseDamageBonus = args.BaseDamageAddition
end

function SetupMercDamageBonus( hero, args )
	SessionMapState.ShadeMercDamageBonus = args.DamageMultiplier
end

function CleanupRaiseDeadEncounter( currentRoom )
	local assistUnit = ActiveEnemies[currentRoom.DestroyAssistUnitOnEncounterEndId]
	local expireProjectiles = {}
	local destroyDelay = 0.1
	for projectileId, enemyId in pairs( SessionMapState.ProjectileSpawnRecord ) do
		if enemyId == currentRoom.DestroyAssistUnitOnEncounterEndId then
			table.insert(expireProjectiles, projectileId )
		end
	end

	ExpireProjectiles({ ProjectileIds = expireProjectiles })
	local destroyUnits = {}
	for unitId, unit in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if unit.SpawnedById == currentRoom.DestroyAssistUnitOnEncounterEndId then
			table.insert(destroyUnits, unit)
			if unit.DestroyDelay then
				destroyDelay = math.max( destroyDelay, unit.DestroyDelay + 0.1 )
			end
		end
	end
	for _, unit in pairs( destroyUnits ) do
		thread( Kill, unit)
	end
	if assistUnit then
		thread( Kill, assistUnit )
		if assistUnit.DestroyDelay then
			destroyDelay = math.max( destroyDelay, assistUnit.DestroyDelay + 0.1 )
		end
	end
	wait(destroyDelay,  RoomThreadName)
	currentRoom.DestroyAssistUnitOnEncounterEndId = nil
	currentRoom.AssistUnitName = nil
	MapState.RaiseDeadCount = nil
end

function FizzleOldAnubisProjectiles( triggerArgs, traitArgs )
	if not IsEmpty(SessionMapState.LastAnubisProjectileIds) and TableLength(SessionMapState.LastAnubisProjectileIds) >= traitArgs.ProjectileCap then
		local oldestId = table.remove(SessionMapState.LastAnubisProjectileIds, 1)
		ExpireProjectiles({ ProjectileId = oldestId })
	end
	table.insert( SessionMapState.LastAnubisProjectileIds, triggerArgs.ProjectileId )
end

function RallyAnubisShades( victim, functionArgs, triggerArgs )
	SessionMapState.ForceShadeMercActive = true
	SessionMapState.ForceShadeMercTargetId = victim.ObjectId
	local invalidIds = ToLookup(CurrentRun.CurrentRoom.ShadeMercInactiveIds)
	local ids =  GetIdsByType({ Name = "ShadeMercAspect" })
	for _, id in ipairs( ids ) do
		if invalidIds == nil or not invalidIds[id] and ActiveEnemies[id] ~= nil then
			local enemy = ActiveEnemies[id]
			notifyExistingWaiters( "WithinDistance_"..enemy.Name.."_"..enemy.ObjectId )
		end
	end

	SessionMapState.ForceShadeMercActive = nil
	SessionMapState.ForceShadeMercTargetId = nil
end

function EndEncounterShadeDissipate( traitData, args )
	ExpireProjectiles({ Names = {"ShadeMercSpiritball", "ShadeMercAspectSpiritball"}})
	local ids =  GetIdsByType({ Name = "ShadeMercAspect" })
	local invalidIds = ToLookup(CurrentRun.CurrentRoom.ShadeMercInactiveIds)
	if not IsEmpty( ids ) then
		for _, id in ipairs( ids ) do
			if invalidIds == nil or not invalidIds[id] then
				if ActiveEnemies[id] ~= nil then
					ActiveEnemies[id].SkipCanAttack = true
				end
			end
		end
		if args.SmileChance and RandomChance( args.SmileChance ) then
			local smileGhostId = RemoveRandomValue( ids )
			thread( DelayEndShadeDissipate, smileGhostId )		
		end
		for _, id in ipairs( ids ) do
			if invalidIds == nil or not invalidIds[id] then
				if ActiveEnemies[id] ~= nil then
					CleanupEnemy( ActiveEnemies[id] )
					CreateAnimation({ Name = "GhostAspectDissipate", DestinationId = id})
					Destroy({ Id = id })
				end
			end
			waitUnmodified(0.05)
		end
	end
end

function DelayEndShadeDissipate( id )
	thread( PlayEmoteSimple, ActiveEnemies[id], { AnimationName = "StatusIconSmile", OffsetZ = 58} )
	wait(1.5)
	if not ActiveEnemies[id] then
		return
	end
	CreateAnimation({ Name = "GhostAspectDissipate", DestinationId = id})
	CleanupEnemy( ActiveEnemies[id] )
	Destroy({ Id = id })

end

function CreateShadeMerc( enemy, traitArgs )
	if not enemy or enemy.NeverLeavesShadeMerc or not RandomChance( traitArgs.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
		return
	end
	
	if TableLength(GetIdsByType({ Name = traitArgs.Name })) >= traitArgs.MaxCount then
		return
	end
	traitArgs = traitArgs or {}
	local enemyName = traitArgs.Name or "ShadeMercAspect"
	local enemyData = EnemyData[enemyName]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = enemy.ObjectId, OffsetX = 0, OffsetY = 0 })
	SessionMapState.AnubisShadeIds[newEnemy.ObjectId] = newEnemy
	thread( SetupUnit, newEnemy, CurrentRun, { SkipPresentation = true } )
	if traitArgs.AngleMin and traitArgs.AngleMax then
		SetGoalAngle({ Angle = RandomFloat(traitArgs.AngleMin, traitArgs.AngleMax), Id = newEnemy.ObjectId }) --Rough forward facing
	else
		SetGoalAngle({ Angle = 285, Id = newEnemy.ObjectId }) --Rough forward facing
	end
	thread( CreateShadeMercAspectPresentation,  newEnemy )
	return newEnemy
end

function CleanupShadeMerc( triggerArgs )
	for id, enemy in pairs( SessionMapState.AnubisShadeIds ) do
		if Contains( enemy.ProjectileIds, triggerArgs.ProjectileId ) then
			SessionMapState.AnubisShadeIds[id] = nil
				
			if RandomChance( GetTotalHeroTraitValue("LoneShadeRespawnChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true }) ) then
				if triggerArgs.TriggeredByTable and not triggerArgs.TriggeredByTable.IsDead then
					local invisibleTarget = SpawnObstacle({ Name = "InvisibleTarget", LocationX= triggerArgs.LocationX, OffsetY = triggerArgs.LocationY })
					Teleport({ Id = enemy.ObjectId, DestinationId = invisibleTarget })
					local trait = GetHeroTrait("StaffRaiseDeadAspect")
					CreateShadeMerc( enemy, trait.OnEnemyDeathFunction.FunctionArgs)
					Destroy({ Id = invisibleTarget})
				end
			end
			
			Kill(enemy)
			return
		end
	end
end

function CheckZeusProjectile( victim, functionArgs, triggerArgs )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	local window = functionArgs.WindowDuration or 0.1
	local count = functionArgs.WindowCount or 1
	if CheckCountInWindow("ZeusProjectile", window, count, { NoTrigger = true } ) then
		return
	end
	CheckCountInWindow("ZeusProjectile", window, count, { TriggerOnly = true })
	local bonusDamageMultiplier = 0
	local meetsRequirements = true
	if not triggerArgs.EffectName then
		local manaRequirements = GetHeroTraitValues("LightningManaRequirements")
		if functionArgs.ManaCost then
			if CurrentRun.Hero.Mana < functionArgs.ManaCost then
				return
			else
				ManaDelta( -functionArgs.ManaCost )
			end
		end
		for i, data in pairs(manaRequirements) do
			if data.ManaCost then
				if CurrentRun.Hero.Mana >= data.ManaCost then
					ManaDelta( -data.ManaCost )
					bonusDamageMultiplier = bonusDamageMultiplier + data.BonusMultiplier
				else
					meetsRequirements = false
				end
			end
		end
	end

	if meetsRequirements then
		if functionArgs.ProjectileName then
			local addlProperties = {}
			if HeroHasTrait("ReboundingSparkBoon") then
				addlProperties.AllowRepeatedOwnerJumpHit = true
				addlProperties.AffectsSelf = true
				--addlProperties.MultipleUnitCollisions = true
			end
			addlProperties.NumJumps = GetBaseDataValue({ Type = "Projectile", Name = functionArgs.ProjectileName, Property = "NumJumps"}) + GetTotalHeroTraitValue("ZeusSparkBonusBounces")
			CreateProjectileFromUnit({ 
				Name = functionArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = functionArgs.DamageMultiplier + bonusDamageMultiplier, 
				DestinationId = victim.ObjectId, 
				FireFromTarget = true,
				ProjectileCap = 5,
				DataProperties = addlProperties })
		end
		if functionArgs.EffectNames then
		
			for i, effectName in pairs( functionArgs.EffectNames ) do
				ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].EffectData, })
			end
		end
	end
end

function OnDemeterCastArmed( triggerArgs, functionArgs )
	SessionMapState.CastAttachTriggered = true
	if not HeroHasTrait("WeaponCastProjectileHades") and not HeroHasTrait("WeaponAnywhereCast") and not HeroHasTrait("WeaponCastProjectile") then
		return
	end
	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
	
	AttachProjectiles({ Ids = { triggerArgs.ProjectileId }, DestinationId = dropLocation })
	AttachProjectiles({ Ids = SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId], DestinationId = dropLocation })

	local speed = functionArgs.Speed
	local interval = 0.1
	local newIds = {}
	while SessionMapState.CastAttachedProjectiles[triggerArgs.ProjectileId] do
		if not IsEmpty(MapState.CastStorms) then
			for _, ids in pairs( MapState.CastStorms ) do
				for s, id in pairs (ids ) do
					if not newIds[id] then
						AttachProjectiles({ Ids = { id } , DestinationId = dropLocation })
						newIds[id] = true
					end
				end
			end
		end
		if GetDistance({ Id = dropLocation, DestinationId = CurrentRun.Hero.ObjectId }) < speed * interval then
			Move({ Id = dropLocation, DestinationId = CurrentRun.Hero.ObjectId, Duration = interval })
		else
			Move({ Id = dropLocation, DestinationId = CurrentRun.Hero.ObjectId, Speed = speed })
		end
		waitUnmodified(0.1, RoomThreadName )
	end
	Destroy({Id = dropLocation})
end

function CheckArmImput( weaponData, functionArgs, triggerArgs )
	SessionMapState.CastAttachTriggered = nil
	if not IsControlDown({ Name = "Attack1" }) then
		CheckCastDetach( weaponData, nil, { PostFire = false })
	elseif not HasWaitUntil("CastUp") then
		local notifyName = "CastUp"
		NotifyOnControlReleased({ Names = {"Attack1"}, Notify = notifyName })
		waitUntil( notifyName )
		if not SessionMapState.CastAttachTriggered then
			CheckCastDetach( weaponData, nil, { PostFire = false })
		end
	end
end

function CheckCastDetach( weaponData, args, triggerArgs )
	local projectileIds = {}
	for id, attachedIds in pairs( SessionMapState.CastAttachedProjectiles ) do
		table.insert( projectileIds, id )
		if not IsEmpty( attachedIds ) then
			projectileIds = ConcatTableValues( projectileIds, attachedIds )
		end
	end
	if not IsEmpty( MapState.CastStorms ) then
		for _, ids in pairs( MapState.CastStorms ) do
			projectileIds = ConcatTableValues( projectileIds, ids )	
		end		
	end
	if not IsEmpty( SessionMapState.CastDefense ) then
		projectileIds = ConcatTableValues( projectileIds, SessionMapState.CastDefense )	
	end
	if not triggerArgs.PostFire then
		DetachProjectiles({ Ids = projectileIds})
	end
end

function OnAresCastArmed( triggerArgs, functionArgs )

	local projectileId = triggerArgs.ProjectileId
	local dataProperties = {}
	if HeroHasTrait("SelfCastBoon") and projectileId ~= SessionMapState.FamiliarCastProjectileId then
		dataProperties.AttachToOwner = true
		dataProperties.IgnoreCancelAttachedProjectiles = true
	end
	CreateProjectileFromUnit({ 
		Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = projectileId, FireFromTarget = true, 
		DamageMultiplier = functionArgs.DamageMultiplier, DataProperties = dataProperties, })
	
end

function OnZeusCast( weaponData, functionArgs, triggerArgs )
	local projectileId = triggerArgs.ProjectileId
	local tempObstacleId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY= triggerArgs.LocationY })
	
	thread( ManageZeusCloud, functionArgs, tempObstacleId, triggerArgs.ProjectileId )
end

function ManageZeusCloud( functionArgs, tempObstacleId, projectileId )
	local strikeCount = 0
	local yScale = nil
	local range = functionArgs.Range
	if projectileId then
		yScale = GetProjectileDataValue({ Id = projectileId, Property = "DamageRadiusScaleY"})
	end
	while ProjectileExists({ Id = projectileId }) do
		if projectileId then
			local projectileLocation = GetLocation({Id = projectileId, IsProjectile = true })
			if projectileLocation.X and projectileLocation.Y then
				Destroy({Id = tempObstacleId})	
				range = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
				tempObstacleId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = projectileLocation.X, LocationY= projectileLocation.Y})
			else
				-- projectile likely destroyed, clean up and early exit
				Destroy({Id = tempObstacleId})	
				return
			end
		end
		thread( CreateZeusBolt, {
		SourceId = tempObstacleId,
		Range = range, 
		SeekTarget = true,
		WeaponName = "WeaponCast",
		YScale = yScale,
		ProjectileName = functionArgs.ProjectileName, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = 0,
		Delay = 0.1, 
		Count = 1 })
		waitUnmodified( functionArgs.StrikeInterval, RoomThreadName )
		strikeCount = strikeCount + 1
	end
	Destroy({ Id = tempObstacleId})
end

function CheckZeusManaBolt( functionArgs )

	if CheckCooldown("ZeusManaBolt", functionArgs.Cooldown, true ) then
		thread(CreateZeusBolt, {
			SourceId = functionArgs.TargetId or CurrentRun.Hero.ObjectId,
			Range = functionArgs.Range, 
			SeekTarget = true, 
			ProjectileName = functionArgs.ProjectileName, 
			DamageMultiplier = functionArgs.DamageMultiplier,
			InitialDelay = 0, 
			Delay = 0.1, 
			Count = 1
		}) 
	end
end

function HestiaSprintFlames( functionArgs, triggerArgs )
	if not SessionMapState.SprintActive or not SessionMapState.SprintStartTime or ( functionArgs.StartDelay and (_worldTimeUnmodified - SessionMapState.SprintStartTime) < functionArgs.StartDelay ) then
		return
	end
	local distance = 0
	local minDistance = functionArgs.MinDistance or 100
	if not functionArgs.MinDistance or not SessionMapState.LastHestiaProjectileId or not ProjectileExists({ Id = SessionMapState.LastHestiaProjectileId }) then
		distance = minDistance + 1
	else
		distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = SessionMapState.LastHestiaProjectileId, DestinationIdsIsProjectile = true })
	end
	if CheckCooldown("Interval", functionArgs.Cooldown, true ) and distance > minDistance then
		SessionMapState.LastHestiaProjectileId = CreateProjectileFromUnit({ Name =  functionArgs.ProjectileName, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, FizzleOldestProjectileCount = functionArgs.MaxSpawns })
	end
end


function HestiaCastDefense ( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	local dataProperties = 
	{
		StartDelay = traitArgs.StartDelay,
		AttachToOwner = false
	}
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY })	
	local modifier = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "BlastRadiusModifier" })
	
	if HeroHasTrait("SelfCastBoon") and IsControlDown({ Name = "Attack1" }) and not triggerArgs.UnitIdOverride then
		dataProperties.AttachToOwner = true
		dataProperties.IgnoreCancelAttachedProjectiles = true
	end
	local projectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, DestinationId = targetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = dataProperties,  BlastRadiusModifier = modifier, FireFromTarget = true })
	local baseDuration = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileCast", Property = "FuseStart" })
	for i, traitArgs in pairs(GetHeroTraitValues("CastProjectileModifiers")) do
		SetDamageRadiusMultiplier({ Id = projectileId, Fraction = traitArgs.AreaIncrease, Duration = baseDuration })
	end
	table.insert( SessionMapState.CastDefense, projectileId )
	
	DestroyOnDelay({ targetId }, 0.1)
end

function RemoveCastDefense() 
	ExpireProjectiles({ Names = { "HestiaSprintDefense" }} )
	SessionMapState.CastDefense = {}
end

function HestiaBlockSpend( victim, functionArgs, triggerArgs )
	local attacker = triggerArgs.Attacker 
	if triggerArgs.BlockingProjectileName == functionArgs.ProjectileName then
		local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
		if attacker and not attacker.SkipModifiers and not attacker.IsDead and not IsUntargetable({Id = attacker.ObjectId}) and not IsInvulnerable({ Id = attacker.ObjectId }) and CheckCooldown( "HestiaDefense"..attacker.ObjectId, functionArgs.Cooldown ) then
			ApplyBurn( attacker, functionArgs.EffectArgs )
			TraitUIActivateTrait( GetHeroTrait("BurnSprintBoon"), { FlashOnActive = true, Duration = functionArgs.Cooldown} )
		end
		
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = targetId })
		if functionArgs.FireSound then
			PlaySound({ Name = functionArgs.FireSound, Id = targetId, ManagerCap = 46 })
		end
		Destroy({ Id = targetId })
	end
end

function ResetHestiaSprint ( args, triggerArgs )
	SessionMapState.SprintBurnInflicted = {}
end

function BankGold( functionArgs, traitData )
	local totalCurrency = GetResourceAmount("Money")
	SpendResource( "Money", totalCurrency, "DionysusBank", { NoLifetimeEffect = true, SkipQuestStatusCheck = true, SkipResourceSpendPresentation = true } )
	traitData.StoredGold = totalCurrency + functionArgs.ReturnGold
	thread( InCombatTextArgs, { PreDelay = 0.5, TargetId = CurrentRun.Hero.ObjectId, Text = "BankBoon_CombatText", Duration = 0.8, LuaKey = "TempTextData", ShadowScaleX = 1.1, LuaValue = { Amount = totalCurrency }} )
	PlaySound({ Name = "/Leftovers/Menu Sounds/MakingMoneyChaChing", Delay = 0.5 })
end

function CreditMissingGold( traitData, oldTraitData )
	local goldDifference = traitData.AcquireFunctionArgs.ReturnGold - oldTraitData.AcquireFunctionArgs.ReturnGold
	local trait = GetHeroTrait("BankBoon")
	trait.StoredGold = oldTraitData.StoredGold + goldDifference
end

function GrantRandomMaxHealth( functionArgs )
	local health = RandomInt( functionArgs.MinHealth, functionArgs.MaxHealth )
	AddMaxHealth( health, "RandomHealth", { Delay = 0.5, Silent = true})
	MaxHealthIncreaseText({ Delay = 0.5, MaxHealthGained = "UI_Mystery", SpecialText = "MaxHealthIncrease" })
	thread( UpdateHealthUI, { FalloffDelay = 0.0 } )
end

function GiveRandomConsumablesAndCredit( functionArgs, traitData )
	local creditResourceNames = traitData.OnResourceMaxMana.ResourceNames
	local totalPickup = 0
	for i, name in pairs(creditResourceNames) do
		if CurrentRun.ResourcesGained[name] then
			totalPickup = totalPickup + CurrentRun.ResourcesGained[name]
		end
	end
	thread(GiveRandomConsumables, functionArgs)
	thread(AddMaxMana, totalPickup * traitData.OnResourceMaxMana.Amount, "ResourceMaxMana", { PreDelay = functionArgs.PreTextDelay, Delay = functionArgs.Delay })
end

function CreditMissingConsumables( traitData, oldTraitData )
	local freshTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = traitData.RarityMultiplier})
	local originalTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = oldTraitData.RarityMultiplier})
	local newAmount = freshTrait.AcquireFunctionArgs.LootOptions[1].MinAmount
	local oldAmount = originalTrait.AcquireFunctionArgs.LootOptions[1].MinAmount
	local newConsumableArgs = DeepCopyTable( freshTrait.AcquireFunctionArgs )
	newConsumableArgs.LootOptions[1].MinAmount = newAmount - oldAmount
	newConsumableArgs.LootOptions[1].MaxAmount = newAmount - oldAmount
	thread( GiveRandomConsumables, newConsumableArgs )
end

function ZeusSprintZap( weaponData, functionArgs, triggerArgs )
	local manaCost = 0
	if functionArgs.CostPerStrike and functionArgs.CostPerStrike > 0 then
		manaCost = GetManaCost( weaponData, true, { ManaCostOverride = functionArgs.CostPerStrike, TraitSource = true } )
	end
	if CheckCooldown("ZeusSprintZap", functionArgs.Cooldown, true ) then
		if CurrentRun.Hero.Mana >= manaCost or LastMomentManaRestoreEligible(manaCost) then
			CreateZeusBolt({
				SourceId = functionArgs.TargetId or CurrentRun.Hero.ObjectId,
				Range = functionArgs.Range, 
				SeekTarget = true, 
				ProjectileName = functionArgs.ProjectileName, 
				DamageMultiplier = functionArgs.DamageMultiplier,
				RunFunctionNameOnTarget = functionArgs.RunFunctionNameOnTarget,
				RunFunctionArgsOnTarget = functionArgs,
				InitialDelay = 0, 
				Delay = 0.1, 
				Count = 1
			}) 
		end
	end
end

function ZeusSprintSpend( args )
	local functionArgs = args.Args or {}
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSprint" )
	local manaCost = GetManaCost( weaponData, true, { ManaCostOverride = functionArgs.CostPerStrike, TraitSource = true } )
	ManaDelta(-manaCost)
end


function PreDamageBoss( enemy, damageAmount, damageData )
	local waitTime = damageData.Delay or 3
	wait( waitTime, RoomThreadName )
	Damage( enemy, { DamageAmount = damageAmount, Silent = true, DamageSourceName = damageData.DamageSourceName or "TempDamageSource" })

	UpdateHealthBar( enemy, 0, { Force = true })
	thread( CallFunctionName, damageData.PresentationFunctionName or "PreDamagePresentation", enemy, damageAmount, damageData )
end

function CreateZeusBolt( functionArgs )
	local doubleBoltChance = GetTotalHeroTraitValue("DoubleBoltChance")
	local strikes = functionArgs.Count or 1
	if RandomChance(doubleBoltChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
		strikes = strikes + 1
	end
	FireWeaponWithinRange({
		SourceId = functionArgs.SourceId,
		Range = functionArgs.Range,
		TargetId = functionArgs.TargetId,
		SeekTarget = functionArgs.SeekTarget, 
		WeaponName = functionArgs.WeaponName,
		ProjectileName = functionArgs.ProjectileName, 
		YScale = functionArgs.YScale,
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = functionArgs.Delay, 
		FireWithoutTarget = functionArgs.FireWithoutTarget,
		RunFunctionNameOnTarget = functionArgs.RunFunctionNameOnTarget,
		RunFunctionArgsOnTarget = functionArgs.RunFunctionArgsOnTarget,
		Delay = functionArgs.FollowUpDelay or 0.1, 
		Count = strikes })
end


function PoseidonIntermittentClearCast( weaponData, functionArgs, triggerArgs )
	triggerArgs = triggerArgs or {}
	SessionMapState.PoseidonManaActive = nil
	
	local cooldown = functionArgs.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
	if HasThread("PoseidonManaInterval") then
		killTaggedThreads("PoseidonManaInterval")
		waitUnmodified(0.1)
	end
	local trait = GetHeroTrait("PoseidonManaBoon")	
	if triggerArgs.Cooldown then
		SessionMapState.NextPoseidonManaActiveTime = _worldTime + cooldown

		TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = cooldown })
	
		SessionMapState.ElapsedTimeMultiplierIgnores.PoseidonManaInterval = true
		wait( cooldown, "PoseidonManaInterval" )
	else
		SessionMapState.NextPoseidonManaActiveTime = _worldTime

		TraitUIActivateTrait( trait )
	end
	MapState.ClearCastPrimed = true
	SessionMapState.PoseidonManaActive = true
	if HeroHasTrait("SuitMarkCritAspect") then
		if MapState.WeaponCharge.WeaponSprint then
			local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponSprint" )
			thread( DoWeaponCharge, triggerArgs, weaponData )
			thread( HandleManaChargeIndicator, { name = weaponData.Name } )
		end
	end
	UpdateWeaponMana()
end

function CheckClearCastStart( weaponData, functionArgs, triggerArgs )
	if triggerArgs.Force or ( not IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) and not triggerArgs.DisjointExCast )then
		return
	end
	if MapState.ClearCastPrimed then
		MapState.ClearCastPrimed = nil
		
		local trait = GetHeroTrait("PoseidonManaBoon")
		local dataProperties = EffectData[functionArgs.EffectName].DataProperties
		dataProperties.Duration = functionArgs.Duration
		ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
		thread( PoseidonClearCastPresentation )
		TraitUIActivateTrait( trait, { CustomAnimation = "InactiveTrait" })
		
	end
end

function CheckPoseidonCastSplash ( weaponData, functionArgs, triggerArgs )
	local unitSourceId = triggerArgs.UnitIdOverride or CurrentRun.Hero.ObjectId
	local radius = 430
	if triggerArgs.ProjectileId then
		radius = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "ModifiedDamageRadius" })
	end
	local tempObstacleId = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
	
	CreateProjectileFromUnit({ 
		Name = functionArgs.ProjectileName, 
		Id = CurrentRun.Hero.ObjectId, 
		DestinationId = tempObstacleId, 
		DamageMultiplier = functionArgs.DamageMultiplier, 
		FireFromTarget = true,
		DataProperties = 
		{
			DamageRadius = radius,
		},
	})
	thread( DestroyOnDelay, {tempObstacleId}, 0.1 )
end

function PoseidonSprintSplash ( weaponData, functionArgs, triggerArgs )
	
	if CheckCooldown("PoseidonFrontSprint", functionArgs.Cooldown, true ) then
		if not SessionMapState.PoseidonSprintSpent then
			if not SessionMapState.SprintSoundId and functionArgs.SprintSound then
				SessionMapState.SprintSoundId = PlaySound({ Name = functionArgs.SprintSound, ManagerCap = 46 })
			end
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, FizzleOldestProjectileCount = functionArgs.FizzleOldestProjectileCount or 8, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier})				
		else
			if SessionMapState.SprintSoundId then
				StopSound({Id = SessionMapState.SprintSoundId, Duration = 0.25 })
				SessionMapState.SprintSoundId = nil
			end
		end
	end
end
function PoseidonSprintSpend( victim, functionArgs, triggerArgs )
	if not SessionMapState.PoseidonSprintSpent then
		SessionMapState.PoseidonSprintSpent = true
		local offset = {}
		if functionArgs.BarrelLength then
			offset = CalcOffset( math.rad( GetAngle({ Id = CurrentRun.Hero.ObjectId })), functionArgs.BarrelLength )
		end
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, HitByDetonationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, OffsetX = offset.X, OffsetY = offset.Y })				
	end
end

function CheckSlipApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" then
		local effectName = functionArgs.EffectName
		local dataProperties = EffectData[effectName].EffectData
		ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
	end
end

function ResetPoseidonSprint ( args, triggerArgs )
	SessionMapState.PoseidonSprintSpent = nil
end

function HestiaSprintSplash ( functionArgs )
	MapState.LavaProjectiles = MapState.LavaProjectiles or {}
	local projectileId = CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = functionArgs.TargetId or CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier})			
	table.insert(MapState.LavaProjectiles, projectileId)
	if functionArgs.MaxProjectileCount and TableLength(MapState.LavaProjectiles) > functionArgs.MaxProjectileCount then
		ExpireProjectiles({ ProjectileId = MapState.LavaProjectiles[1] })
		table.remove(MapState.LavaProjectiles, 1 )
	end
end

function CheckZeusManaSpawn( unit, functionArgs )
	if HasThread( functionArgs.ThreadName ) then
		return
	end
	local despawnRange = functionArgs.DespawnRange or (functionArgs.MaxRange + 500)
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		local delay = 0.1
		if CurrentRun and CurrentRun.CurrentRoom and (IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime ) or not IsEmpty(MapState.AggroedUnits)) then

			if SessionMapState.ManaDropId and GetDistance({Id = CurrentRun.Hero.ObjectId, DestinationId = SessionMapState.ManaDropId }) > despawnRange then
				Destroy({Id = SessionMapState.ManaDropId })
				SessionMapState.ManaDropId = nil
			end
			if not SessionMapState.ManaDropId then
				local spawnPoints = CurrentRun.CurrentRoom.ZeusManaSpawnPoints
				if not spawnPoints then
					spawnPoints = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", Distance = functionArgs.MaxRange, ScaleY = 0.6, MinDistance = functionArgs.MinRange, RequiredLocationUnblocked = true })
				end
				for spawnPointId in pairs(SessionMapState.OccupiedSpawnPoints) do
					RemoveValue( spawnpoints, spawnPointId )
				end
				if IsEmpty( spawnPoints ) then
					spawnPoints = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", Distance = functionArgs.MaxRange, ScaleY = 0.6, RequiredLocationUnblocked = true })
				end

				if not IsEmpty(spawnPoints) and ( not IsEmpty(RequiredKillEnemies) or not IsEmpty(MapState.AggroedUnits)) then
					local spawnPoint = GetRandomValue( spawnPoints )
					local consumableName = "ManaDropZeus"
					local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnPoint, Group = "Standing", })
					SessionMapState.ManaDropId = consumableId
					SessionMapState.OccupiedSpawnPoints[spawnPoint] = consumableId
					CreateConsumableItem( consumableId, consumableName, 0 )
					if functionArgs.Sound then
						PlaySound({ Name = functionArgs.Sound, Id = consumableId, ManagerCap = 46 })
					end
					delay = functionArgs.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
				end
			end
		end
		wait( delay, functionArgs.ThreadName )
	end
end


function ZeusManaPickup( interactableObject, functionArgs, user )
	local manaBoon = GetHeroTrait( "ZeusManaBoon" )

	UseableOff({ Id = interactableObject.ObjectId })
	AddInputBlock({ Name = "ZeusManaPickup" })
	FreezePlayerUnit("ZeusManaPickup")
	waitUnmodified( 0.05 )
	SetAnimation({ Name =  GetEquippedWeaponValue( "InteractAnimation" ) or "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = interactableObject.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.1 }, } )

	waitUnmodified( functionArgs.InputLockDuration / 2)

	CreateAnimation({ Name = "ZeusLightningIris", DestinationId = interactableObject.ObjectId }) --nopkg
	
	SetAnimation({ Name =  "ManaDropZeusOut", DestinationId = interactableObject.ObjectId })
	PlaySound({ Name = "/SFX/Player Sounds/ZeusLightningWrathImpact" })
	thread(DestroyOnDelay, { interactableObject.ObjectId }, 0.20, {Unmodified = true })

	waitUnmodified( functionArgs.InputLockDuration / 2 )
	RefillMana()
	CreateAnimation({ Name = "ManaRegenFlashFx", DestinationId = CurrentRun.Hero.ObjectId })
	UnfreezePlayerUnit("ZeusManaPickup")
	RemoveInputBlock({ Name = "ZeusManaPickup" })

	if manaBoon then
		for pointId, dropId in pairs(SessionMapState.OccupiedSpawnPoints) do
			if dropId == SessionMapState.ManaDropId then
				SessionMapState.OccupiedSpawnPoints[pointId] = nil
				break
			end
		end
		SessionMapState.ManaDropId = nil
		local args = manaBoon.SetupFunction.Args
		SetThreadWait(args.ThreadName, args.Interval )
	end
end

function RandomFogSpawn( unit, functionArgs )
	if HasThread( functionArgs.ThreadName ) then
		return
	end
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		local delay = 0.1
		if IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime ) then
			CreateProjectileFromUnit({ 
				Name = "DionysusField", 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationId = CurrentRun.Hero.ObjectId, 
				FireFromTarget = false, 
				OffsetX = RandomFloat(-functionArgs.Range, functionArgs.Range), 
				OffsetY = RandomFloat(-functionArgs.Range, functionArgs.Range) * functionArgs.ScaleY 
			})
		
			delay = functionArgs.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
		end
		wait( delay, functionArgs.ThreadName )
	end
end

function CheckDrinkSpawn( unit, functionArgs )
	if HasThread( functionArgs.ThreadName ) then
		return
	end
	local despawnRange = functionArgs.DespawnRange or (functionArgs.MaxRange + 500)
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		local delay = 0.1
		if IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime ) then

			if SessionMapState.DrinkDropId and GetDistance({Id = CurrentRun.Hero.ObjectId, DestinationId = SessionMapState.DrinkDropId }) > despawnRange then
				Destroy({Id = SessionMapState.DrinkDropId })
				SessionMapState.DrinkDropId = nil
			end
			if not SessionMapState.DrinkDropId then
				local spawnPoints = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", Distance = functionArgs.MaxRange, ScaleY = 0.6, MinDistance = functionArgs.MinRange, RequiredLocationUnblocked = true })
				for spawnPointId in pairs(SessionMapState.OccupiedSpawnPoints) do
					RemoveValue( spawnpoints, spawnPointId )
				end
				if IsEmpty( spawnPoints ) then
					spawnPoints = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints", Distance = functionArgs.MaxRange, ScaleY = 0.6, RequiredLocationUnblocked = true })
				end

				if not IsEmpty(spawnPoints) and ( not IsEmpty(RequiredKillEnemies) or not IsEmpty(MapState.AggroedUnits)) then
					local spawnPoint = GetRandomValue( spawnPoints )
					local consumableName = functionArgs.ConsumableName
					local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnPoint, Group = "Standing", })
					SessionMapState.DrinkDropId = consumableId
					SessionMapState.OccupiedSpawnPoints[spawnPoint] = consumableId
					CreateConsumableItem( consumableId, consumableName, 0 )
					if functionArgs.Sound then
						PlaySound({ Name = functionArgs.Sound, Id = consumableId, ManagerCap = 46 })
					end
					if functionArgs.Vfx then
						CreateAnimation({ Name = functionArgs.Vfx, DestinationId = consumableId })
					end
					delay = functionArgs.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
				end
			end
		end
		wait( delay, functionArgs.ThreadName )
	end
end


function DrinkPickup( interactableObject, functionArgs, user )
	local sourceBoon = GetHeroTrait( "PowerDrinkBoon" )

	UseableOff({ Id = interactableObject.ObjectId })
	-- AddInputBlock({ Name = "DrinkPickup" })
	-- FreezePlayerUnit("DrinkPickup")
	-- waitUnmodified( 0.05 )
	-- SetAnimation({ Name =  GetEquippedWeaponValue( "InteractAnimation" ) or "MelinoeInteract", DestinationId = CurrentRun.Hero.ObjectId })
	-- AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = interactableObject.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.1 }, } )

	waitUnmodified( functionArgs.InputLockDuration / 2)

	--CreateAnimation({ Name = "ZeusLightningIris", DestinationId = interactableObject.ObjectId })
	
	--SetAnimation({ Name =  "ManaDropZeusOut", DestinationId = interactableObject.ObjectId })
	--PlaySound({ Name = "/SFX/Player Sounds/ZeusLightningWrathImpact" })
	thread(DestroyOnDelay, { interactableObject.ObjectId }, 0.20, {Unmodified = true })
	CreateAnimation({ Name = "ItemConsumeFx", DestinationId = interactableObject.ObjectId })

	-- waitUnmodified( functionArgs.InputLockDuration / 2 )
	--CreateAnimation({ Name = "ManaRegenFlashFx", DestinationId = CurrentRun.Hero.ObjectId })
	-- UnfreezePlayerUnit("DrinkPickup")
	-- RemoveInputBlock({ Name = "DrinkPickup" })

	if sourceBoon then
		if not MapState.HostilePolymorph then
		SessionMapState.DrinkCritCharges = sourceBoon.DrinkCritCount
			if sourceBoon.DrinkCritVfx then
				CreateAnimation({ Name = sourceBoon.DrinkCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
		for pointId, dropId in pairs(SessionMapState.OccupiedSpawnPoints) do
			if dropId == SessionMapState.DrinkDropId then
				SessionMapState.OccupiedSpawnPoints[pointId] = nil
				break
			end
		end
		SessionMapState.DrinkDropId = nil
		local args = sourceBoon.SetupFunction.Args
		SetThreadWait(args.ThreadName, args.Interval )
	end
end

function RemoveDrinkCritVolley(triggerArgs)
	waitUnmodified(0.1)
	if triggerArgs.WeaponName and SessionMapState.DrinkCritProjectileIds and SessionMapState.DrinkCritProjectileIds[triggerArgs.WeaponName] and triggerArgs.ProjectileId then
		SessionMapState.DrinkCritProjectileIds[triggerArgs.WeaponName][triggerArgs.ProjectileId] = nil
	end
	if triggerArgs.WeaponName and SessionMapState.DrinkCritVolleys and SessionMapState.DrinkCritVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( SessionMapState.DrinkCritVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if SessionMapState.DrinkCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			SessionMapState.DrinkCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckDrinkCritCharges( weaponData, functionArgs, triggerArgs )
	if weaponData.Name == "WeaponBlink" then
		return
	end
	if weaponData.Name == "WeaponSprint" and not IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	if SessionMapState.DrinkCritCharges and SessionMapState.DrinkCritCharges >= 1 then
		if weaponData.Name == "WeaponCastArm" then
			SessionMapState.DrinkCritCharges = SessionMapState.DrinkCritCharges - 1

			if SessionMapState.DrinkCritCharges <= 0 then
				local traitData = GetHeroTrait("PowerDrinkBoon")
				if traitData.DrinkCritVfx then
					StopAnimation({ Name = traitData.DrinkCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end
		elseif triggerArgs.ProjectileVolley and triggerArgs.NumProjectiles then
			if weaponData.Name == "WeaponSuitRanged" and not HeroHasTrait("SuitComboAspect") then
				SessionMapState.DrinkCritVolleys[weaponData.Name] = SessionMapState.DrinkCritVolleys[weaponData.Name] or {}
				if not IsEmpty(SessionMapState.TargetedEnemies) then
					IncrementTableValue(SessionMapState.DrinkCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, TableLength(SessionMapState.TargetedEnemies) * 2 )
				else
					IncrementTableValue(SessionMapState.DrinkCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, 4 )
				end
			else
				SessionMapState.DrinkCritVolleys[weaponData.Name] = SessionMapState.DrinkCritVolleys[weaponData.Name] or {}
				IncrementTableValue(SessionMapState.DrinkCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
			end
			if weaponData.Name ~= "WeaponCast" then
				SessionMapState.DrinkCritCharges = SessionMapState.DrinkCritCharges - 1

				if SessionMapState.DrinkCritCharges <= 0 then
					local traitData = GetHeroTrait("PowerDrinkBoon")
					if traitData.DrinkCritVfx then
						StopAnimation({ Name = traitData.DrinkCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
					end
				end
			end
		end
	end
end

function RecordDamageSnapshot()
	SessionMapState.EncounterStartDamage = CurrentRun.TotalDamageTaken
end

function EndEncounterHeal( trait, args )
	if not SessionMapState.EncounterStartDamage then
		return
	end
	local damageTaken = CurrentRun.TotalDamageTaken - SessionMapState.EncounterStartDamage
	if damageTaken > 0 then
		Heal( CurrentRun.Hero, { HealAmount = round(damageTaken * args.EncounterHealMultiplier ) * CalculateHealingMultiplier(), Name = "EncounterHeal" } )
	end
end

function HeraSprintMana( enemy, functionArgs )
	if enemy and CheckCooldown( "HeraSprintMana", 1/functionArgs.ManaPerSecond) then
		ManaDelta(1)
	end
end

function HeraSprintSuction( functionArgs )
	if CheckCooldown( "HeraSprintSuction", functionArgs.Cooldown) then
		local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = functionArgs.Radius })
		CreateAnimation({ Name = functionArgs.PullVfx, DestinationId = CurrentRun.Hero.ObjectId, ScaleRadius = functionArgs.Radius})
		for i, id in pairs(nearestEnemyTargetIds) do
			ApplyForce({ Id = id, SelfApplied = true, Speed = GetRequiredForceToEnemy( id, CurrentRun.Hero.ObjectId, -functionArgs.DeadZoneRadius, functionArgs.DistanceMultiplier ), Angle = GetAngleBetween({ Id = id, DestinationId = CurrentRun.Hero.ObjectId }) })
			ApplyDamageShare( ActiveEnemies[id], functionArgs )
		end
	end
end

function HeraSprintLink( functionArgs )
	if not SessionMapState.SprintActive or not SessionMapState.SprintStartTime or ( functionArgs.StartDelay and (_worldTimeUnmodified - SessionMapState.SprintStartTime) < functionArgs.StartDelay ) then
		return
	end
	if CheckCooldown( "HeraSprintSuction", functionArgs.Cooldown) then
		local enemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true, Distance = functionArgs.Radius})
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
		if enemyId and ActiveEnemies[enemyId] and not ActiveEnemies[enemyId].IsDead then
			local enemy = ActiveEnemies[enemyId]
			if enemy.DamageSurrogate ~= nil then
				enemy = enemy.DamageSurrogate
			end
			local firstApplication = (enemy.ActiveEffects and not enemy.ActiveEffects[functionArgs.EffectName])
			ApplyDamageShare( enemy, functionArgs )
			if firstApplication and functionArgs.ProjectileName then
				thread( DelayFireSprintLinkProjectile, enemyId, functionArgs )
			end
		end
	end
end

function DelayFireSprintLinkProjectile( enemyId, functionArgs )
	waitUnmodified( 0.05 )
	if enemyId and ActiveEnemies[enemyId] and not ActiveEnemies[enemyId].IsDead then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemyId, DamageMultiplier = functionArgs.DamageMultiplier })
		if CheckCooldown("HeraCastPresentation", functionArgs.VfxCooldown) then
			CreateAnimationsBetween({
				Animation = "HeraRope", DestinationId = enemyId, Id = CurrentRun.Hero.ObjectId, 
				Stretch = true, UseZLocation = false})
		end
	end
end

function ApplyOmegaBuff( functionArgs )
	
	local effectName = functionArgs.EffectName 
	local dataProperties = MergeAllTables({
		EffectData[effectName].EffectData, 
		functionArgs.EffectArgs
	})
	ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
end

function ApplyRoot( victim, functionArgs, triggerArgs )
	local effectName = functionArgs.EffectName 
	local dataProperties = MergeAllTables({
		EffectData[effectName].EffectData, 
		functionArgs.EffectArgs
	})
	if HeroHasTrait("RootDurationBoon") then
		dataProperties.ExpiringTimeThreshold = dataProperties.ExpiringTimeThreshold - GetTotalHeroTraitValue("RootDurationExtension")
	end
	ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
end
function CheckBurnConsumption( victim, functionArgs, triggerArgs )
	if not victim.IsDead and triggerArgs.EffectName == functionArgs.EffectName and victim.RootActive then
		thread( CheckBurnConsumptionDelay, victim, functionArgs, triggerArgs )
	end
end

function CheckBurnConsumptionDelay( victim, functionArgs, triggerArgs )
	waitUnmodified( functionArgs.Delay, RoomThreadName )
	if not victim.IsDead and victim.ActiveEffects[functionArgs.ClearEffectName] then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = victim.ActiveEffects[functionArgs.ClearEffectName] * functionArgs.ConsumptionDamage })
		ClearEffect({ Id = victim.ObjectId, Name = functionArgs.ClearEffectName })
		if victim.RootActive then
			victim.BlockEffectWhileRootActive = functionArgs.ClearEffectName
			AddEffectBlock({ Id = victim.ObjectId, Name = functionArgs.ClearEffectName})
			if functionArgs.EffectBlockDuration then
				thread( RemoveRootActiveEffectBlock, victim, functionArgs.EffectBlockDuration, functionArgs.ClearEffectName )
			end
		end
	end
end

function RemoveRootActiveEffectBlock( victim, delay, effectName )
	wait( delay )
	if victim and victim.BlockEffectWhileRootActive then
		RemoveEffectBlock({ Id = victim.ObjectId, Name = victim.BlockEffectWhileRootActive})
		victim.BlockEffectWhileRootActive = nil
	end
end

function CheckCastBurnApply( victim, functionArgs, projectileId )
	if CheckCooldown("CastBurnApply"..victim.ObjectId..projectileId, functionArgs.Cooldown ) then
		local damageMultiplier = CalculateDamageMultipliers( CurrentRun.Hero, victim, WeaponData.WeaponCast, { SourceWeapon = "WeaponCast", ExplicitMultipliersOnly = true })
		functionArgs = ShallowCopyTable(functionArgs)
		functionArgs.NumStacks = round(functionArgs.NumStacks * damageMultiplier)
		ApplyBurn( victim, functionArgs, triggerArgs )
	end
end

function CheckBlindApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" then
		local effectName = functionArgs.EffectName
		local dataProperties = EffectData[effectName].EffectData
		ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
	end
end

function CheckAresExCurseApply( victim, functionArgs, triggerArgs )
	if not IsEmpty(SessionMapState.ExSwordRecord[victim.ObjectId]) then
		return
	end
	
	if IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		local dataProperties = {}
		local blastModifier = 1
		local count = 1
		for _, data in pairs(GetHeroTraitValues("AresSwordModifiers")) do
			if data.Fuse then
				dataProperties.FuseStart = data.Fuse
				dataProperties.Fuse = data.Fuse
			end
			if data.AoEMuliplier then
				blastModifier = blastModifier * data.AoEMuliplier
			end
			if data.AddCount then
				count = count + data.AddCount
			end
		end
		for i=1,count do
			dataProperties.StartDelay = i * 0.1
			local exSwordProjectileId = CreateProjectileFromUnit({ 
				Name = functionArgs.ProjectileName, 
				DestinationId = victim.ObjectId, 
				Id = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = functionArgs.DamageMultiplier, 
				FireFromTarget = true,
				BlastRadiusModifier = blastModifier,
				ScaleMultiplier = blastModifier,
				ProjectileCap = functionArgs.ProjectileCap or 3, 
				DataProperties = dataProperties
			})
			
			if not SessionMapState.ExSwordRecord[victim.ObjectId] then
				SessionMapState.ExSwordRecord[victim.ObjectId] = {}
			end
			SessionMapState.ExSwordRecord[victim.ObjectId][exSwordProjectileId] = true
		end		
	end
end

function RemoveAresSwordRecord( triggerArgs, functionArgs )
	if not triggerArgs.ProjectileId then
		return
	end
	for id in pairs( SessionMapState.ExSwordRecord ) do
		SessionMapState.ExSwordRecord[id][triggerArgs.ProjectileId] = nil
	end
end

function CheckAresCurseApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" and not triggerArgs.Reapplied then
		local dataProperties = {}
		local blastModifier = 1
		local count = 1
		for _, data in pairs(GetHeroTraitValues("AresSwordModifiers")) do
			if data.Fuse then
				dataProperties.FuseStart = data.Fuse
				dataProperties.Fuse = data.Fuse
			end
			if data.AoEMuliplier then
				blastModifier = blastModifier * data.AoEMuliplier
			end
			if data.AddCount then
				count = count + data.AddCount
			end
		end
		for i=1,count do
			dataProperties.StartDelay = i * 0.3
			CreateProjectileFromUnit({ 
				Name = functionArgs.ProjectileName, 
				DestinationId = victim.ObjectId, 
				Id = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = functionArgs.DamageMultiplier, 
				FireFromTarget = true,
				BlastRadiusModifier = blastModifier,
				ScaleMultiplier = blastModifier,
				ProjectileCap = 4, 
				DataProperties = dataProperties
			})			
		end
	end
end


function ApplyBurn( victim, functionArgs, triggerArgs )
	functionArgs = ShallowCopyTable(functionArgs) or { EffectName = "BurnEffect", NumStacks = 1 }
	local effectName = functionArgs.EffectName 
	
	if victim and victim.BlockEffectWhileRootActive == effectName then
		return
	end

	if victim and victim.EffectBlocks and Contains(victim.EffectBlocks, effectName) then
		return
	end

	if not EffectData[effectName] then
		return
	end
	local dataProperties = MergeAllTables({
		EffectData[effectName].EffectData, 
		functionArgs.EffectArgs
	})
	if HeroHasTrait("BurnStackBoon") then
		for _, data in pairs( GetHeroTraitValues("EffectModifier")) do
			if EffectData[effectName].DisplaySuffix == data.ValidActiveEffectGenus then
				if data.IntervalMultiplier then
					dataProperties.Cooldown = dataProperties.Cooldown * data.IntervalMultiplier
				end
				if data.DurationIncrease then
					dataProperties.Duration = dataProperties.Duration + data.DurationIncrease
				end
			end
		end
	end
	if not SessionMapState.FirstBurnRecord[ victim.ObjectId ] then
		functionArgs.NumStacks = functionArgs.NumStacks + GetTotalHeroTraitValue("BonusFirstTimeBurn")
		SessionMapState.FirstBurnRecord[ victim.ObjectId ] = true
	end
	local maxStacks = EffectData[effectName].MaxStacks
	if not victim.ActiveEffects[effectName] or victim.ActiveEffects[effectName] < maxStacks then
		IncrementTableValue( victim.ActiveEffects, effectName, functionArgs.NumStacks )
		if victim.ActiveEffects[effectName] > maxStacks then
			victim.ActiveEffects[effectName] = maxStacks
		end
	end
	ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, NumStacks = functionArgs.NumStacks, DataProperties = dataProperties } )
	
end

function StartAresSprintProjectile ( weaponData, args, triggerArgs )
	if args.StartSound then
		SessionState.AresSprintSound = PlaySound({ Name = args.StartSound  })
	end
	local count = 0
	local startedSoundThread = false
	while count < args.Count do
		count = count + 1

		local dataProperties = {}
		local blastModifier = 1
		local repeats = 1
		for _, data in pairs(GetHeroTraitValues("AresSwordModifiers")) do
			if data.Fuse then
				dataProperties.FuseStart = data.Fuse
				dataProperties.Fuse = data.Fuse
			end
			if data.AoEMuliplier then
				blastModifier = blastModifier * data.AoEMuliplier
			end
			if data.AddCount then
				repeats = repeats + data.AddCount
			end
		end
		if repeats > 1 then
			dataProperties.MultiDetonate = true
			dataProperties.MaxDetonations = repeats
			dataProperties.Fuse = 0.6
		end

		CreateProjectileFromUnit({ 
			Name = args.ProjectileName, 
			DestinationId = CurrentRun.Hero.ObjectId, 
			Id = CurrentRun.Hero.ObjectId, 
			DamageMultiplier = args.DamageMultiplier, 
			FireFromTarget = true, 
			BlastRadiusModifier = blastModifier,
			ScaleMultiplier = blastModifier,
			FizzleOldestProjectileCount = args.ProjectileCap,
			DataProperties = dataProperties
		})
		if not startedSoundThread then
			startedSoundThread = true
			local fuseStart = dataProperties.FuseStart or GetBaseDataValue({ Type = "Projectile", Name = args.ProjectileName, Property = "FuseStart" })
			local fuse = dataProperties.Fuse or GetBaseDataValue({ Type = "Projectile", Name = args.ProjectileName, Property = "Fuse" })
			local preDetonateDelay = GetBaseDataValue({ Type = "Projectile", Name = args.ProjectileName, Property = "PreDetonateFxDuration" })
			thread(HandleAresSprintSound, { 
				Sound = args.DropSound, 
				StartDelay = fuseStart - preDetonateDelay, 
				Delay = fuse - preDetonateDelay, 
				Count = repeats,
				StartSoundFinishFade = args.StartSoundFinishFade
			} )
		end
		wait( args.Interval )
	end
end

function FireHadesSprintProjectile ( weaponData, functionArgs, triggerArgs )
	if ( triggerArgs and triggerArgs.Canceled ) then
		return
	end
	-- Fired from multiple places so we'll just infer the appropriate args
	CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier })				
end


function FireAphroditeSprintProjectile ( args, triggerArgs )
	if args and args.CheckSprint and ConfigOptionCache.SprintAutoHold and SessionMapState.SprintActive then
		return
	end
	if not ConfigOptionCache.SprintAutoHold and (( triggerArgs and triggerArgs.Canceled ) or ( args and args.CheckSprint and (SessionMapState.SprintActive or IsControlDown({Name = "Rush" }))) ) then
		return
	end
	-- Fired from multiple places so we'll just infer the appropriate args
	local trait = GetHeroTrait("AphroditeSprintBoon")
	local traitArgs = trait.OnWeaponFiredFunctions.FunctionArgs
	CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, FireFromTarget = true, DamageMultiplier = traitArgs.DamageMultiplier })				
end


function FireHephaestusSprintProjectile ( args, triggerArgs )
	if ( triggerArgs and triggerArgs.Canceled ) or ( args and args.CheckSprint and SessionMapState.SprintActive ) then
		return
	end
	local traitArgs = args

	local closestId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = traitArgs.Range, YScale = 0.6})
	if closestId ~= 0 and ActiveEnemies[closestId] and (ActiveEnemies[closestId].TrainingTarget or (not ActiveEnemies[closestId].IsDead and not ActiveEnemies[closestId].SkipModifiers))  then
		CheckMassiveAttack( ActiveEnemies[closestId], traitArgs, {} )
	end
end

function ApplyAphroditeVulnerability( victim, functionArgs, triggerArgs )
	local effectName = functionArgs.EffectName 	
	local dataProperties = MergeAllTables({
		EffectData[effectName].EffectData, 
		functionArgs.EffectArgs
	})
	if HeroHasTrait( "WeakPotencyBoon" ) then
		for _, data in pairs( GetHeroTraitValues("EffectModifier")) do
			if EffectData[effectName].DisplaySuffix == data.ValidActiveEffectGenus then
				dataProperties.Modifier = dataProperties.Modifier - data.AmountAddition
			end
		end
	end
	ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
end

function CheckApplyDamageShare( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" then
		ApplyDamageShare( victim, functionArgs, triggerArgs )
	end
end

function CheckCastAphroditeVulnerabilityApply( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ImpactSlow" and victim.ActivationFinished then
		local effectName = functionArgs.EffectName 	
		ApplyAphroditeVulnerability( victim, functionArgs, triggerArgs )
	end
end

function CheckRandomStatusCurse( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "WeakEffect" and not triggerArgs.Reapplied and victim.ActivationFinished then
		local eligibleEffects = { }
		for name, data in pairs( functionArgs.Effects ) do
			if not data.GameStateRequirements or IsGameStateEligible( data, data.GameStateRequirements ) then
				table.insert( eligibleEffects, name )
			end
		end
		local count = functionArgs.Count or 3
		for i=1, count do 
			local effectName = RemoveRandomValue( eligibleEffects )
			if not effectName then
				return
			end
			local applicationData = functionArgs.Effects[effectName]
			if applicationData.CustomFunction then
				local stacks = applicationData.DefaultNumStacks
				if applicationData.CopyNumStacksFromTraits then
					for _, traitName in pairs(applicationData.CopyNumStacksFromTraits ) do
							if HeroHasTrait( traitName ) then
								local traitData = GetHeroTrait( traitName )
								if traitData.OnEnemyDamagedAction and traitData.OnEnemyDamagedAction.Args then
									local args = traitData.OnEnemyDamagedAction.Args
									if args.NumStacks and stacks < args.NumStacks then
										stacks = args.NumStacks
									end
								end
							end
					end
				end

				CallFunctionName( applicationData.CustomFunction, victim, {EffectName = effectName, NumStacks = stacks } )
			else
				local dataProperties = EffectData[effectName].EffectData or EffectData[effectName].DataProperties
				if applicationData.ExtendDuration then
					dataProperties.Duration = dataProperties.Duration + GetTotalHeroTraitValue(applicationData.ExtendDuration)
				end
				if applicationData.DefaultModifier then
					dataProperties.Modifier = applicationData.DefaultModifier
				end
				if applicationData.CopyValuesFromTraits then
					for property, traitNames in pairs(applicationData.CopyValuesFromTraits ) do
						for _, traitName in pairs( traitNames ) do
							if HeroHasTrait( traitName ) then
								local traitData = GetHeroTrait( traitName )
								if traitData and traitData.OnEnemyDamagedAction and traitData.OnEnemyDamagedAction.Args then
									if not dataProperties[property] or ( dataProperties[property] and traitData.OnEnemyDamagedAction.Args[property] > dataProperties[property] ) then
										dataProperties[ property ] = traitData.OnEnemyDamagedAction.Args[property]
									end
								end
							end
						end
					end
				end
				ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
			end
		end
	end
end

function ApplyDamageShare( victim, functionArgs, triggerArgs )
	if not victim or victim.SkipModifiers or not GetThingDataValue({ Id = victim.ObjectId, Property = "StopsProjectiles" }) or IsInvulnerable({ Id = victim.ObjectId }) or IsUntargetable({ Id = victim.ObjectId }) then
		return
	end

	local effectName = functionArgs.EffectName 
	local dataProperties = MergeAllTables({
		EffectData[effectName].EffectData, 
		functionArgs.EffectArgs
	})
	dataProperties.Duration = dataProperties.Duration  + GetTotalHeroTraitValue("DamageShareDurationIncrease")
	dataProperties.Amount = dataProperties.Amount + GetTotalHeroTraitValue("DamageShareAmountIncrease")

	ApplyEffect( { DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties } )
end


function HeraCastCountBlast( weaponData, traitArgs, triggerArgs )

	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY or not triggerArgs.ProjectileId then
		return
	end
	local delay = traitArgs.Delay or 0
	waitUnmodified( delay )
	if ProjectileExists({ Id = triggerArgs.ProjectileId }) then
		local castCount = 0
		for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy and enemy.ActiveEffects and enemy.ActiveEffects.ImpactSlow then
				castCount = castCount + 1
			end
		end

		local modifier = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "BlastRadiusModifier" })
		CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, BlastRadiusModifier = modifier, ProjectileDestinationId = triggerArgs.ProjectileId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier * castCount, FireFromTarget = true })
	
	end
end

function CheckLinkDeathDamage( unit, args )
	if unit.ActiveEffectsAtDamageStart and unit.ActiveEffectsAtDamageStart [args.EffectName] then
		for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
			if enemy and 
				((enemy.ActiveEffectsAtDamageStart and enemy.ActiveEffectsAtDamageStart[args.EffectName]) 
				or ( enemy.ActiveEffects and enemy.ActiveEffects[args.EffectName])) then
				thread( DoLinkDeath, enemy, args )
			end
		end
	end
end

function DoLinkDeath( enemy, args )
	wait(args.Delay, RoomThreadName)
	if enemy and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) then
		CreateAnimation({ Name = args.Vfx, DestinationId = enemy.ObjectId })
		Damage (enemy, { EffectName = "DamageShareDeath", DamageAmount = args.DamageAmount, Silent = false, } )
	end
end
function CheckCastSummonDamage( enemy, traitArgs)
	if not ProjectileExists({ Names = { "ProjectileCast"} }) then
		return
	end
	if enemy.IsDead or enemy.IgnoreCastSummonDamage then
		return
	end
	local castId = GetFirstKey( SessionMapState.CastAttachedProjectiles )
	traitArgs = traitArgs or {}
	delay = traitArgs.Delay or 0.1
	wait( delay, RoomThreadName)
	CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier })
	if CheckCooldown("HeraCastPresentation", traitArgs.VfxCooldown) then
		local location = GetLocation({ Id = castId, IsProjectile = true})
		local ropeTargetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y}) 
		CreateAnimationsBetween({
			Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = ropeTargetId, 
			Stretch = true, UseZLocation = false})
		thread( DestroyOnDelay, { ropeTargetId } , 0.1 )
	end
end

function CheckTimedKillBuff (enemy, args )
	if not enemy.SkipModifiers then
		if SessionMapState.TimedBuff <= 0 and args.Fx then
			CreateAnimation({ Name = args.Fx, DestinationId = CurrentRun.Hero.ObjectId })
		end
		SessionMapState.TimedBuff = SessionMapState.TimedBuff + 1
		table.insert( SessionMapState.TimedBuffStartTimes, _worldTime )
		thread(ReduceKillBuff, args )	
		UIScriptsDeferred.KillBuffDirty = true
	end
end

function ReduceKillBuff( args )	
	waitUnmodified( args.Duration, RoomThreadName )
	SessionMapState.TimedBuff = SessionMapState.TimedBuff - 1
	table.remove( SessionMapState.TimedBuffStartTimes, 1 )
	UIScriptsDeferred.KillBuffDirty = true
	if SessionMapState.TimedBuff <= 0 then
		StopAnimation({ Name = args.Fx, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function RestoreLastRoomKillBuff( hero )
	local speedTrait = GetHeroTrait("TimedKillBuffBoon")
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.TimedBuffStartTimes then
		for _, time in pairs( CurrentRun.CurrentRoom.TimedBuffStartTimes ) do
			local args = ShallowCopyTable(speedTrait.OnEnemyDeathFunction.FunctionArgs)
			local duration = args.Duration
			args.Duration = duration - (_worldTime - time)
			if args.Duration > 0 then
				CheckTimedKillBuff( {}, args )
			end
		end
		CurrentRun.CurrentRoom.TimedBuffStartTimes = {}
	end
end

function CheckRootStrike( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName == "ChillEffect" and victim.RootActive and not triggerArgs.Reapplied then
		thread(RootStrikeThread, victim, functionArgs )
	end
end

function RootStrikeThread( victim, functionArgs )
	wait( functionArgs.Interval, RoomThreadName )
	while victim and victim.RootActive and not victim.IsDead and not CurrentRun.Hero.IsDead do
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		wait( functionArgs.Interval, RoomThreadName )
	end
end

function CheckBurnDeathExplosion( enemy, args )
	args = args or {}
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, DamageMultiplier = args.ProjectileDamageMultiplier, ProjectileCap = args.ProjectileCap or 8 })
end

function IntermittentHephCastStrike( weaponData, traitArgs, triggerArgs )
	local startDelay = 1
	local interval = 1
	local tempObstacleId = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
	if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
		Attach({ Id = tempObstacleId, DestinationId = triggerArgs.TargetId })
	end
	thread( FireHephCastStrike, traitArgs, tempObstacleId, triggerArgs.ProjectileId )
end

function FireHephCastStrike( traitArgs, centerId, projectileId )
	local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
	SessionMapState.ElapsedTimeMultiplierIgnores.HephCast = true
	for i=1, 3 do
		SetAnimation({ Name = "HephMassiveHitHammerCast", DestinationId = centerId })
		wait(1, "HephCast")
		SetAnimation({ Name = "HephMassiveHitFixed", DestinationId = centerId })
		if traitArgs.ProjectileName then
			if ProjectileExists({ Id = projectileId }) then
				radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
				local projectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = projectileId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = { DamageRadius = radius }, FireFromTarget = true })				
				if HeroHasTrait("HadesCastProjectileBoon") then
					AttachProjectiles({ Id = projectileId, DestinationId = centerId})
				end
			else
				CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = centerId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = { DamageRadius = radius }, FireFromTarget = true })				
			end
		end
	end
end

function CheckProjectilePull(weaponData, traitArgs, triggerArgs )
	local duration = GetProjectileDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCast", Property = "FuseStart" })
	local tempObstacleId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
	traitArgs.PullCount = duration / traitArgs.Interval
	thread( ManageProjectilePull, traitArgs, tempObstacleId, triggerArgs.ProjectileId )
end

function ManageProjectilePull( traitArgs, centerId, projectileId )
	local pullCount = 0
	while pullCount < traitArgs.PullCount and ProjectileExists({ Id = projectileId }) and projectileId do
		local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
		pullCount = pullCount + 1
		local location = GetLocation({ IsProjectile = true, Id = projectileId })
		Teleport({ Id = centerId, OffsetX = location.X, OffsetY = location.Y })
		if traitArgs.ProjectileName then
			CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = centerId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = { DamageRadius = radius } })				
		end
		local nearestEnemyTargetIds = 
			GetClosestIds({ Id = centerId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = radius, PreciseCollision = true })
		CreateAnimation({ Name = traitArgs.PullVfx, DestinationId = centerId, ScaleRadius = damageRadius })
		for i, id in pairs(nearestEnemyTargetIds) do
			if ActiveEnemies[id] and not ActiveEnemies[id].IsDead then
				ApplyForce({ Id = id, Speed = GetRequiredForceToEnemy( id, centerId, -traitArgs.DeadZoneRadius, traitArgs.DistanceMultiplier ), Angle = GetAngleBetween({ Id = id, DestinationId = centerId }) })
			end
		end
		wait( traitArgs.Interval, RoomThreadName)
	end
	Destroy({ Id = centerId })
end

function AddTraitResources( args, traitData )
	wait(args.Delay)
	for resourceName, resourceAmount in pairs( args.GiftResources ) do
		if resourceName ~= "ReportValues" then
			AddResource( resourceName, resourceAmount, args.Name )
			wait( 0.01 )
		end
	end
	if traitData.ResourceGatherHeal then
		Heal( CurrentRun.Hero, { HealFraction = traitData.ResourceGatherHeal * CalculateHealingMultiplier(), SourceName = "ResourceHeal" })
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function ApolloDelayedBlast( weaponData, traitArgs, triggerArgs )

	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY or not triggerArgs.ProjectileId then
		return
	end
	local delay = traitArgs.Delay or 0
	if HeroHasTrait("HermesCastDiscountBoon") then
		local trait = GetHeroTrait("HermesCastDiscountBoon")
		if trait.WeaponSpeedMultiplier then
			delay = delay * trait.WeaponSpeedMultiplier.Value
		end
	end
	waitUnmodified( delay )
	if ProjectileExists({ Id = triggerArgs.ProjectileId }) then
		local modifier = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "BlastRadiusModifier" })
		
		CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, BlastRadiusModifier = modifier, ProjectileDestinationId = triggerArgs.ProjectileId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true })
	end
end

function ApolloEarlyCastBlast( projectileId, traitArgs, args )
	args = args or {}
	if not args.Force and ( not projectileId or not ProjectileExists({Id = projectileId }) or SessionState.EarlyDetonationProjectileIds[projectileId] or GetProjectileProperty({ ProjectileId = projectileId, Property = "Armed" })) then
		return
	end
	local modifier = GetProjectileProperty({ ProjectileId = projectileId, Property = "BlastRadiusModifier" })
		
	CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, BlastRadiusModifier = modifier, ProjectileDestinationId = projectileId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true })
end

function ContinuousDemeterCast( weaponData, traitArgs, triggerArgs )
	local tempObstacleId = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.ProjectileX, LocationY= triggerArgs.ProjectileY })
	thread( FireDemeterCastStrike, traitArgs, tempObstacleId, triggerArgs.ProjectileId )
end

function FireDemeterCastStrike( traitArgs, centerId, projectileId )
	local radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
			
	while ProjectileExists({ Id = projectileId }) do
		if traitArgs.ProjectileName then
			if ProjectileExists({ Id = projectileId }) then
				radius = GetProjectileProperty({ ProjectileId = projectileId, Property = "ModifiedDamageRadius" })
			end
			local fxOffset = CalcOffset( RandomFloat(0, 2 * math.pi), RandomFloat(0, radius * 0.9 ))
			fxOffset.Y = fxOffset.Y * 0.5
			CreateAnimation({ Name = traitArgs.Fx, DestinationId = centerId, OffsetX = fxOffset.X, OffsetY = fxOffset.Y })
			CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = centerId, DamageMultiplier = traitArgs.DamageMultiplier, DataProperties = { DamageRadius = radius }, FireFromTarget = true })				
		end
		wait( traitArgs.Delay )
	end
	Destroy({Id = centerId })
end

function DemeterCastBlast( weaponData, traitArgs, triggerArgs )
	if not triggerArgs.ProjectileX or not triggerArgs.ProjectileY then
		return
	end
	if not MapState.CastStorms then
		MapState.CastStorms = {}
	end	
	
	local maxProjectiles = traitArgs.MaxProjectiles or 1
	if HeroHasTrait("StaffClearCastAspect") then
		maxProjectiles = maxProjectiles + 1
	end
	local createdProjectiles = {}
	local dataProperties = 
	{
		StartDelay = traitArgs.StartDelay,
		AttachToOwner = false
	}
	local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY })
	for _, projectileName in pairs( traitArgs.ProjectileNames or {} ) do
		if HeroHasTrait("SelfCastBoon") and IsControlDown({ Name = "Attack1" }) and not triggerArgs.UnitIdOverride then
			dataProperties.AttachToOwner = true
			dataProperties.IgnoreCancelAttachedProjectiles = true
		end
		local projectileId = CreateProjectileFromUnit({ Name = projectileName, DestinationId = targetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true, DataProperties = dataProperties, BlastRadiusModifier = traitArgs.BlastRadiusMultiplier })				
		
		if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
			AttachProjectiles({ Id = projectileId, DestinationId = triggerArgs.TargetId })
		end
		table.insert(createdProjectiles, projectileId)
	end
	table.insert(MapState.CastStorms, createdProjectiles )
	if TableLength( MapState.CastStorms ) > maxProjectiles then
		ExpireProjectiles({ ProjectileIds = MapState.CastStorms[1] })
		table.remove( MapState.CastStorms, 1)
	end
	Destroy({ Id = targetId })
end

function SprintShieldPresentation()
	if MapState.SprintShields > 0 and MapState.SprintShieldFx and HeroHasTrait(MapState.SprintShieldTrait) and not SessionMapState.SprintShieldPresentation then
		CreateAnimation({ Name = MapState.SprintShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
		SessionMapState.SprintShieldPresentation = true	
	end
end

function SprintShieldEndPresentation()
	if MapState.SprintShields > 0 and MapState.SprintShieldFx and HeroHasTrait(MapState.SprintShieldTrait) then
		StopAnimation({ Name = MapState.SprintShieldFx, DestinationId = CurrentRun.Hero.ObjectId })
		SessionMapState.SprintShieldPresentation = nil
	end
end

function DemeterSprintBlast ( weaponData, traitArgs, triggerArgs )
	if not MapState.SprintStorms then
		MapState.SprintStorms = {}
	end	
	local notifyName = "DemeterSprintThread"
	local detachInterval = traitArgs.DetachInterval or 0.3
	if HasThread(notifyName) then
		thread( DemeterSprintStormDetach, { Delay = detachInterval, StartTime = _worldTime })
		return
	end
	waitUnmodified( traitArgs.StartDelay, notifyName )
	local createdProjectiles = {}
	local dataProperties = 
	{
		AttachToOwner = true
	}
	if IsEmpty(MapState.AttachedStormProjectileIds) and SessionMapState.SprintActive then
		MapState.AttachedStormProjectileIds = {}
		if traitArgs.TargetId then
			for _, projectileName in pairs( traitArgs.ProjectileNames or {} ) do
				local projectileId = CreateProjectileFromUnit({ Name = projectileName, DestinationId = traitArgs.TargetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true, DataProperties = dataProperties, BlastRadiusModifier = traitArgs.BlastRadiusMultiplier })				
				table.insert(MapState.AttachedStormProjectileIds, projectileId)
			end
		else
			for _, projectileName in pairs( traitArgs.ProjectileNames or {} ) do
				local projectileId = CreateProjectileFromUnit({ Name = projectileName, DestinationId = traitArgs.TargetId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true, DataProperties = dataProperties, BlastRadiusModifier = traitArgs.BlastRadiusMultiplier })				
				table.insert(MapState.AttachedStormProjectileIds, projectileId)
			end
		end
		
		table.insert(MapState.SprintStorms, ShallowCopyTable(MapState.AttachedStormProjectileIds) )
		
		if TableLength( MapState.SprintStorms ) > traitArgs.MaxProjectiles then
			ExpireProjectiles({ ProjectileIds = MapState.SprintStorms[1] })
			table.remove( MapState.SprintStorms, 1)
		end
	end 
	thread( DemeterSprintStormDetach, { Delay = detachInterval, StartTime = _worldTime })
end


function DemeterSprintStormDetach( args )
	args = args or {}
	if args.Delay then
		if SetThreadWait( "DemeterSprintStorm", args.Delay ) then
			RefreshProjectile({ Ids = MapState.AttachedStormProjectileIds })
			return
		end
		wait( args.Delay, "DemeterSprintStorm" )
	end
	DetachProjectiles({ Ids = MapState.AttachedStormProjectileIds })
	MapState.AttachedStormProjectileIds = nil
end

function CheckDemeterStormSpawn( hero, args )

	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and HeroHasTrait("StormSpawnBoon") do
		if not IsEmpty(GetInProjectilesBlast({ Id = CurrentRun.Hero.ObjectId, DestinationNames = args.TargetProjectileNames, UseDamageRadius = true, ReturnFirst = true }))  then
			CreateProjectileFromUnit({ 
				Name = args.ProjectileName, 
				Angle = RandomInt(360), 
				Id = CurrentRun.Hero.ObjectId, 
				DestinationId = CurrentRun.Hero.ObjectId, 
				FireFromTarget = true,
				ProjectileCap = args.ProjectileCap,
			})
		end
		wait( args.SpawnInterval, RoomThreadName)
	end
end

function ChaosManaDrain( weaponData, traitArgs, triggerArgs )
	ManaDelta(-traitArgs.Cost, { IgnoreSpend = true, ManaDrain = true })
	thread( ChaosManaDrainPresentation )
end

function ChaosCurseDamage( weaponData, traitArgs, triggerArgs )
	if CurrentRun.Hero.Frozen or CurrentRun.Hero.InvulnerableFlags.BlockDeath then
		return
	end
	if traitArgs.IsEx and (not IsExWeapon( weaponData.Name , {Combat = true}, triggerArgs) and not triggerArgs.DisjointExCast) then
		return
	end
    thread( PlayVoiceLines, HeroVoiceLines.SelfDamageVoiceLines, false )
	SacrificeHealth( { SacrificeHealthMin = traitArgs.Damage, SacrificeHealthMax = traitArgs.Damage, MinHealth = 1, AttackerName = "TrialUpgrade" } )
	if CurrentRun.CurrentRoom.Encounter ~= nil then
		CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage = true
	end
end

function MultipliedSpeedDodgeSetup( hero, traitArgs, args )
	local count = CurrentRun.Hero.OlympianBoonCount or 0
	local totalSpeedChange = 1 + count * traitArgs.SpeedDodgePerBoon

	if not SessionMapState.OlympianBoonCountBoost or SessionMapState.OlympianBoonCountBoost ~= totalBoost then
		if SessionMapState.OlympianBoonCountBoost then
			ApplyUnitPropertyChanges( CurrentRun.Hero, SessionMapState.OlympianBoonCountBoostPropertyChanges, true, true )
		end
		local allPropertyChanges = 
		{			
			{
				LifeProperty = "DodgeChance",
				ChangeValue = totalSpeedChange - 1,
				ChangeType = "Add",
				DataValue = false,
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				ChangeValue = totalSpeedChange,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = totalSpeedChange,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = totalSpeedChange,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
		}
		SessionMapState.OlympianBoonCountBoostPropertyChanges = allPropertyChanges
		SessionMapState.OlympianBoonCountBoost = totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, SessionMapState.OlympianBoonCountBoostPropertyChanges )
	end
end

function SprintShieldSetup( hero, traitArgs, args )
	MapState.SprintShields = traitArgs.SprintShields
	MapState.SprintShieldTrait = traitArgs.TraitName or "SprintShieldBoon"
	MapState.SprintShieldFx = traitArgs.ActiveVfx
end


function CheckSprintPhasingCollision( args )
	if HasThread( "SprintPhasingCheck" ) then
		return
	end
	args = args or {}
	args.Cooldown = args.Cooldown or 0.5
	args.Range = args.Range or 150
	-- optimize by making version of OnUnitCollision that triggers even on phased units
	while SessionMapState.SprintActive do
		local ids = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreHomingIneligible = true, Distance = args.Range, ScaleY = args.ScaleY})
		for _, id in pairs( ids ) do
			local enemy = ActiveEnemies[id]
			if enemy and enemy.ActivationFinished and CheckCooldown( id .. "SprintFreeze", args.Cooldown ) and enemy and not enemy.IsBoss and not enemy.IgnoreSprintPhasingStasisStun then
				local effectName = args.EffectName
				if effectName then
					thread( SprintPhasingUnitPresentation, enemy )
					thread( SprintPhasingMelPresentation, CurrentRun.Hero )
					ApplyEffect({ DestinationId = id, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = EffectData[effectName].DataProperties })
				end
				if args.Interrupt then
					thread( TemporaryMuteStunImmunity, enemy, "OnSprintHitStun")
					CreateProjectileFromUnit({ Name = args.InterruptProjectile, Id = CurrentRun.Hero.ObjectId, DestinationId = id, FireFromTarget = true })
				end
			end
		end
		wait(0.1, "SprintPhasingCheck")
	end
end

function TemporaryMuteStunImmunity( enemy, effectName )
	local immuneToStunReset = GetBaseDataValue({ Type = "Unit", Name = enemy.Name, Property = "ImmuneToStun"})
	SetUnitProperty({ Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
	NotifyOnEffectExpired({ Id = enemy.ObjectId, Notify = enemy.ObjectId..effectName, EffectName = effectName })
	waitUntil(enemy.ObjectId..effectName)
	if enemy and not enemy.IsDead and (immuneToStunReset or (enemy.HealthBuffer and enemy.HealthBuffer > 0)) then
		SetUnitProperty({ Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
	end
end

function StartSprintPhasing ( args, triggerArgs )
	SetPlayerPhasing("SprintMetaupgrade")
	thread( CheckSprintPhasingCollision, args )
end

function EndSprintPhasing ( args, triggerArgs )
	if args and args.CheckSprint and ConfigOptionCache.SprintAutoHold then
		return
	end
	if not ConfigOptionCache.SprintAutoHold and (( triggerArgs and triggerArgs.Canceled ) or ( args and args.CheckSprint and SessionMapState.SprintActive )) then
		return
	end
	SetPlayerUnphasing("SprintMetaupgrade")
	killTaggedThreads("SprintPhasingCheck")
end

function EncounterStartTempArmor( unit, args )
	thread( EncounterStartTempArmorThread, unit, args )
end

function EncounterStartTempArmorThread( unit, args )
	if (CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockTraitSetup) or not args or not unit.ObjectId then
		return
	end
	args = args or {}
	local duration = args.Duration
	local sourceTrait = GetHeroTrait("EncounterStartDefenseBuffBoon")
	sourceTrait.CurrentArmor = args.Amount
	local sourceName = sourceTrait.Name
	AddHealthBuffer( args.Amount, sourceName, { Silent = true, Temporary = true} )
	SetPlayerTempArmorPresentation("EncounterStart")
	FrameState.RequestUpdateHealthUI = true
	local threadName = "EncounterInvulnerabilityFalloff"
	if HasThread(threadName) then
		SetThreadWait( threadName, duration - 1 ) 
		return
	elseif HasThread(threadName.."Final" ) then
		killTaggedThreads( threadName.."Final" )
	end
	if duration > 1 then
		wait( duration - 1, threadName )
		CheckPlayerTempArmorFalloffPresentation("EncounterStart")
		wait( 1, threadName.."Final" )
	else
		wait( duration, threadName )
	end
	sourceTrait.CurrentArmor = 0
	RemovePlayerTempArmorPresentation("EncounterStart")
	RemoveHealthBufferSource(sourceName)
end
function MassiveAttackSetup( hero, traitArgs, args )
	args = args or {}
	traitArgs = traitArgs or {}
	if traitArgs.Delay then
		SessionMapState.ElapsedTimeMultiplierIgnores[traitArgs.TraitName] = true
		wait(traitArgs.Delay, traitArgs.TraitName)
	end
	if not HeroHasTrait( traitArgs.TraitName ) then
		return
	end
	local attackTrait = GetExistingUITraitName( traitArgs.TraitName )
	if attackTrait then
		TraitUIActivateTrait( attackTrait )
	end
	local trait = GetHeroTrait( traitArgs.TraitName )
	if trait.OnEnemyDamagedAction and trait.OnEnemyDamagedAction.Args and trait.OnEnemyDamagedAction.Args.Name and args.Grouped then
		ResetCooldown( trait.OnEnemyDamagedAction.Args.Name )
	end
	if trait.OnBlinkEndAction and trait.OnBlinkEndAction.FunctionArgs and trait.OnBlinkEndAction.FunctionArgs.Name and args.Grouped then
		ResetCooldown( trait.OnBlinkEndAction.FunctionArgs.Name )
	end
	AddReadiedMassiveAttackPresentation( traitArgs.TraitName )
end

function DaggerBlockSetup( hero, args )
	ResetCooldown( "DaggerBlockShield" )
	wait(0.1)
	SessionMapState.ElapsedTimeMultiplierIgnores.DaggerBlockShield = true
	ShowDaggerUI()
end

function FireDaggerSpecial( weaponData, traitArgs, triggerArgs )
	local weaponName = "WeaponDaggerThrow"
	local projectileName = "ProjectileDaggerThrow" 
	local startAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	for i=1, traitArgs.Projectiles do
	local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId,  
		Angle = startAngle - traitArgs.Spread/2 + (i - 1) * traitArgs.Spread/(traitArgs.Projectiles - 1 ) ,DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
	end
end

function CheckMassiveAttack( victim, functionArgs, triggerArgs )
	local cooldown = functionArgs.Cooldown * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
	if CheckCooldownNoTrigger( functionArgs.Name, cooldown ) and ( not ProjectileHasUnitHit( triggerArgs.ProjectileId, "MassiveAttack") or (triggerArgs.SourceWeapon == nil or (functionArgs.MultihitProjectileWhitelistLookup and functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile]) or (functionArgs.MultihitWeaponWhitelistLookup and functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon]))) then
		local timeSinceCooldown = 100000
		if SessionState.GlobalCooldowns[functionArgs.Name] then 
			timeSinceCooldown = _worldTime - SessionState.GlobalCooldowns[functionArgs.Name] - cooldown
		end
		CheckCooldown( functionArgs.Name, cooldown ) 
		
		ProjectileRecordUnitHit( triggerArgs.ProjectileId, "MassiveAttack" )
		local attackTrait = GetExistingUITraitName( functionArgs.TraitName )
		if attackTrait then
			TraitUIActivateTrait( attackTrait, { FlashOnActive = false, Duration = cooldown })
			thread( MassiveAttackSetup, CurrentRun.Hero, { Delay = cooldown, TraitName = functionArgs.TraitName })
		end
		RemoveReadiedMassiveAttackPresentation( functionArgs.TraitName )
		local blastModifier = GetTotalHeroTraitValue( "MassiveAttackSizeModifier", { IsMultiplier = true })
		waitUnmodified( functionArgs.BlastDelay or 0 )
		if victim then
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			if HeroHasTrait("DoubleMassiveAttackBoon") and timeSinceCooldown <= GetTotalHeroTraitValue("DoubleAttackInterval") then
				waitUnmodified( 0.75 )
				CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			end
			if victim.IsDead then
				CreateAnimation({ Name = "HephMassiveHit", DestinationId = victim.ObjectId })
			end
		else
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = functionArgs.ProjectileId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			if HeroHasTrait("DoubleMassiveAttackBoon") and timeSinceCooldown <= GetTotalHeroTraitValue("DoubleAttackInterval") then
				waitUnmodified( 0.75 )
				CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Angle = triggerArgs.ImpactAngle, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = functionArgs.ProjectileId, DamageMultiplier = functionArgs.DamageMultiplier, BlastRadiusModifier = blastModifier, FireFromTarget = true })
			end
		end
	end
end

function RestoreRenewableHephaestusArmor( traitData, oldTraitData )
	thread( HephaestusArmor, CurrentRun.Hero, traitData.SetupFunction.Args )
end

function HephaestusArmor( hero, args )
	local sourceTrait = GetHeroTrait("ArmorBoon")
	sourceTrait.CurrentArmor = args.Amount
	AddHealthBuffer( sourceTrait.CurrentArmor, sourceTrait.Name, { Silent = true } )
	FrameState.RequestUpdateHealthUI = true
	UnreserveMana( "HephaestusArmor")
	ReserveMana( args.ManaReservationCost, "HephaestusArmor")
end

function RestoreHephaestusArmor( traitData, oldTraitData )
	local freshTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = traitData.RarityMultiplier})
	local originalTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, RarityMultiplier = oldTraitData.RarityMultiplier})
	local newArmor = freshTrait.SetupFunctions[1].Args.BaseAmount
	local oldArmor = originalTrait.SetupFunctions[1].Args.BaseAmount
	local trait = GetHeroTrait( traitData.Name )
	if not traitData.CurrentArmor then
		traitData.CurrentArmor = 0
		oldArmor = 0
	end
	trait.CurrentArmor = traitData.CurrentArmor + (newArmor - oldArmor)
	AddHealthBuffer( trait.CurrentArmor, traitData.Name, { Silent = true } )
	thread(OnPlayerArmorGain, {Amount = (newArmor - oldArmor), Delay = 1.25 } )
	FrameState.RequestUpdateHealthUI = true
end


function TraitReserveMana( hero, args )
	local name = args.Name or "Trait"
	if args.Name then
		UnreserveMana( args.Name )
	end
	ReserveMana( args.ManaReservationCost, args.Name or "Trait" )
end


function TraitUnreserveMana( args )
	UnreserveMana( args.Name )
end

function CharmCrowd( hero, args )
	while true do
		local nearbyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true, Distance = 2000 })
		local eligibleEnemies = {}
		for _, id in pairs(nearbyTargetIds) do
			if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers then
				table.insert(eligibleEnemies, ActiveEnemies[id])
			end
		end
		if not IsEmpty(eligibleEnemies) and TableLength(eligibleEnemies) >= args.Minimum then
			if not MapState.CrowdCharmedEnemy or MapState.CrowdCharmedEnemy.IsDead then
				MapState.CrowdCharmedEnemy = GetRandomValue(eligibleEnemies)
			end

			if MapState.CrowdCharmedEnemy.IsBoss or MapState.CrowdCharmedEnemy.BlockCharm then
				MapState.CrowdCharmedEnemy = nil
			else
				ApplyEffect({ 
					Id = CurrentRun.Hero.ObjectId, 
					DestinationId = MapState.CrowdCharmedEnemy.ObjectId, 
					EffectName = args.EffectName or "Charm",
					DataProperties = 
					{
						Type = "CHARM",
						Duration = 0.5,
						Active = true,
						TimeModifierFraction = 0,
					}
				})
			end
		end
		wait(0.3, RoomThreadName)
	end
end


function WeakCrowdMana( hero, args )
	thread( ManaRegen )
	while CurrentRun and CurrentRun.CurrentRoom and CurrentRun.Hero and not CurrentRun.Hero.IsDead and HeroHasTrait("AphroditeManaBoon") do
		if IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime ) or not IsEmpty(MapState.AggroedUnits) then
			local range = args.Range
			if  HeroHasTrait(args.ProximityThresholdExclusionBoon) then
				range = 3000
			end
			
			local nearbyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true, Distance = range, PreciseCollision = true })
			local eligibleEnemies = {}
			for _, id in pairs(nearbyTargetIds) do
				if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers then
					table.insert(eligibleEnemies, ActiveEnemies[id])
				end
			end
			local hasWeakNearby = false
			for _, enemy in pairs(eligibleEnemies) do
				ApplyEffect({ 
					Id = CurrentRun.Hero.ObjectId, 
					DestinationId = enemy.ObjectId, 
					EffectName = args.EffectName,
					DataProperties = EffectData[args.EffectName].EffectData, 
				})
				hasWeakNearby = true	
			end

			if hasWeakNearby then
				if not CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen and args.ActiveFx then
					CreateAnimation({ Name = args.ActiveFx, DestinationId = CurrentRun.Hero.ObjectId })
					if args.ManaRegenStartFx then
						CreateAnimation({ Name = args.ManaRegenStartFx, DestinationId = CurrentRun.Hero.ObjectId })
					end
				end
				CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen = { Value = args.ManaRegen }

			else
				if CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen and args.ActiveFx then
					StopAnimation({ Name = args.ActiveFx, DestinationId = CurrentRun.Hero.ObjectId })
				end
				CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen = nil
			end
			wait(0.3, RoomThreadName)
		else
			if CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen and args.ActiveFx then
				StopAnimation({ Name = args.ActiveFx, DestinationId = CurrentRun.Hero.ObjectId })
			end
			CurrentRun.Hero.ManaRegenSources.WeakCrowdRegen = nil
			wait(0.3, RoomThreadName)
		end
	end
end

function DaggerFinalHitIncrease ( unit, traitArgs, triggerArgs ) 
	if triggerArgs.SourceWeapon == traitArgs.RequiredWeapon then
		SessionMapState.DaggerLastHit = SessionMapState.DaggerLastHit + traitArgs.DamageIncrease
		thread( DaggerFinalHitPresentation, traitArgs.CombatText, traitArgs.DamageIncrease )		
	end
end

function StaffEXHitHeal( unit, traitArgs, triggerArgs )
	if triggerArgs.SourceWeapon == traitArgs.RequiredWeapon then
		Heal( CurrentRun.Hero, { HealAmount = traitArgs.HealAmount, SourceName = "StaffEXHit" } )
		FrameState.RequestUpdateHealthUI = true
		thread( StaffHealPresentation, traitArgs.CombatText )
	end
end

function CheckPerfectChargeRefund( weaponData, args, triggerArgs )
	args = args or {}
	if triggerArgs.IsPerfectCharge then
		local chargeStages = GetWeaponChargeStages( weaponData )
		if chargeStages and MapState.WeaponCharge[weaponData.Name] and chargeStages[MapState.WeaponCharge[ weaponData.Name ]] then
			PerfectChargeRefundPresentation( chargeStages[MapState.WeaponCharge[ weaponData.Name ]].ManaCost )
			local refund = args.ManaRefund 
			if not refund then
				refund = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[ weaponData.Name ]].ManaCost } )
			end
			SessionMapState.PendingStageManaRefund[ weaponData.Name ] = refund
		end
	end
end

function CheckSteam( victim, functionArgs, triggerArgs )
	if triggerArgs.EffectName and functionArgs.ValidEffect and triggerArgs.EffectName ~= functionArgs.ValidEffect then
		return
	end 
	if victim.ActiveEffects[functionArgs.EffectName] then
		if victim.ActiveSteamId and ProjectileExists({ Id = victim.ActiveSteamId }) then
			RefreshProjectile({ Id = victim.ActiveSteamId })
		else
			local projectileId = CreateProjectileFromUnit({ Name = "SteamBlast", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
			AttachProjectiles({ Ids = {projectileId}, DestinationId = victim.ObjectId })		
			victim.ActiveSteamId = projectileId 
		end
		ClearEffect({ Id = victim.ObjectId, Name = functionArgs.EffectName })
	end
end

function FireRallyHeal( attacker, functionArgs, triggerArgs )
	if triggerArgs.ManuallyTriggered then
		return
	end
	local rallyTraitData = GetHeroTrait("ElementalRallyBoon") 
	if rallyTraitData == nil or not IsGameStateEligible( rallyTraitData, rallyTraitData.ActivationRequirements ) then
		return
	end
	if not triggerArgs or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 or triggerArgs.PureDamage then
		return
	end
	thread( FireRallyThread, functionArgs, triggerArgs )
end

function FireRallyThread( functionArgs, triggerArgs )
	local victim = triggerArgs.Victim
	if not victim then 
		return
	end
	local threadName = "FireRally" .. victim.ObjectId
	killTaggedThreads( threadName )
	wait(0.1)
	local healAmount = round( triggerArgs.DamageAmount * functionArgs.Multiplier )
	local duration = functionArgs.Duration
	local minTickRate = 0.05
	local healPerSecond = duration/ healAmount
	local healthOverflow = 0
	local totalHeal = 0

	while totalHeal < healAmount and not victim.IsDead do
		if healPerSecond < minTickRate then
			wait( minTickRate , threadName)
			local healthRegen, fraction = math.modf( healPerSecond * minTickRate )
			healthOverflow = healthOverflow + fraction
			if healthOverflow >= 1 then
				healthOverflow = healthOverflow - 1
				healthRegen = healthRegen + 1
			end
			totalHeal = totalHeal + healthRegen
			Heal( victim, { HealAmount = healthRegen, SourceName = "FireRally", Silent = true })
		else
			wait( duration/healAmount, threadName )
			totalHeal = totalHeal + 1
			Heal( victim, { HealAmount = 1, SourceName = "FireRally" })
		end
	end
end

function CheckFireballSpawn(weaponData, functionArgs, triggerArgs )
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) or functionArgs.Force then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier})
	end
end

function CheckExProjectileSpawn(weaponData, functionArgs, triggerArgs )
	local isExIndirectCast = false
	if SessionMapState.ArmCast and weaponData.ArmedCastChargeStage then
		isExIndirectCast = true
	end
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) or isExIndirectCast then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier})
		local doubleChance = GetTotalHeroTraitValue("DoubleOlympianProjectileChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })
		if RandomChance(doubleChance) then
			wait( GetTotalHeroTraitValue("DoubleOlympianProjectileInterval" ))
			local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, Angle = angle , DamageMultiplier = functionArgs.DamageMultiplier, FireFromTarget = true, ProjectileCap = 2 })
		end
	end
end

function CheckPoseidonExProjectileOnSpawn(weaponData, functionArgs, triggerArgs )
	local isExIndirectCast = false
	if SessionMapState.ArmCast and weaponData.ArmedCastChargeStage then
		isExIndirectCast = true
	end
	local flag = "PoseidonExVolley"
	local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) or isExIndirectCast then
		if not functionArgs.Cooldown or CheckCooldown( functionArgs.ProjectileName.."Spawn".. functionArgs.Cooldown ) then
			CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, Angle = angle, DamageMultiplier = functionArgs.DamageMultiplier, FireFromTarget = true, ProjectileCap = 2 })
			local doubleChance = GetTotalHeroTraitValue("DoubleOlympianProjectileChance") * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })
			if RandomChance(doubleChance) then
				wait( GetTotalHeroTraitValue("DoubleOlympianProjectileInterval" ))
				CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, Angle = angle, DamageMultiplier = functionArgs.DamageMultiplier, FireFromTarget = true, ProjectileCap = 2 })
			end
		end
	end
end

function IcarusUpgradeBoon( functionArgs, traitData )
	local attackTrait = nil
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == functionArgs.Slot then
			attackTrait = traitData
			break
		end
	end
	if not attackTrait then
		return
	end
	traitData.SelectedTrait = attackTrait.Name
	thread( IncreaseTraitLevel, attackTrait, functionArgs.Count )
	thread( IncreasedTraitLevelPresentation, { [attackTrait.Name] = true }, functionArgs.Count, 0.5 )
end

function CheckIcarusExplosion( victim, functionArgs, triggerArgs )
	if not IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	if ProjectileHasUnitHit( triggerArgs.ProjectileId, "IcarusBlast") and (triggerArgs.SourceWeapon == nil or not functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon])  then
		return
	end
	local passesMultihitCheck = true

	if triggerArgs.SourceWeapon ~= nil and functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon] and functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon] then
		local conditions = functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon]
		if conditions.Cooldown and not CheckCooldown( "IcarusBlast", conditions.Cooldown ) then
			return
		end
		if conditions.Window and not CheckCountInWindow("IcarusBlast", conditions.Window, conditions.Count ) then
			return
		end
	end
	
	ProjectileRecordUnitHit( triggerArgs.ProjectileId, "IcarusBlast" )

	CreateProjectileFromUnit({ 
		Name = functionArgs.ProjectileName, 
		Id = CurrentRun.Hero.ObjectId,
		DestinationId = victim.ObjectId, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		FireFromTarget = true,
		DataProperties = 
		{
			ImpactVelocity = force
		}
	})
end


function IcarusHazardCast( weaponData, traitArgs, triggerArgs )
	local projectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, ProjectileDestinationId = triggerArgs.ProjectileId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, FireFromTarget = true})
	local projectileData = ProjectileData[ traitArgs.ProjectileName ]
	
	if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
		AttachProjectiles({ Id = projectileId, DestinationId = triggerArgs.TargetId })
	end
	local destinationId = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.ProjectileX, LocationY = triggerArgs.ProjectileY, Group = projectileData.ReticleGroupName or "FX_Terrain_Top" })		
	if projectileData.ReticleAnimation ~= nil then
		local damageRadius = GetBaseDataValue({ Type = "Projectile", Name = traitArgs.ProjectileName, Property = "DamageRadius" })
		local fuse = GetBaseDataValue({ Type = "Projectile", Name = traitArgs.ProjectileName, Property = "Fuse" })
		SetAnimation({ Name = projectileData.ReticleAnimation, DestinationId = destinationId, ScaleRadius = damageRadius })
		thread( DestroyOnDelay, { destinationId }, fuse )
		
		if HeroHasTrait("HadesCastProjectileBoon") and triggerArgs.TargetId then
			Attach({ Id = destinationId, DestinationId = triggerArgs.TargetId })
		end
	end
end

function IcarusSelfDamage( unit, args, triggerArgs)
	if triggerArgs.ManuallyTriggered then
		return
	end
	if triggerArgs.SourceProjectile ~= "IcarusHazardExplosion" then
		return
	end
	if not unit or not unit.Health or unit.Health < 0 then
		return
	end
	Damage( CurrentRun.Hero, { SourceProjectile = "IcarusHazardExplosion", DamageAmount = args.Damage,  Victim = CurrentRun.Hero } )
end

function IcarusArmorInvulnerability( functionArgs )
	local effectName = functionArgs.EffectName
	local dataProperties = ShallowCopyTable( EffectData[effectName].DataProperties )
	dataProperties.Duration = functionArgs.Duration
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, 
		DataProperties = dataProperties })
	RemoveTrait( CurrentRun.Hero, "BreakInvincibleArmorBoon")
end


function IcarusArmorExplosion( functionArgs )
	CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier, FireFromTarget = true})
	RemoveTrait( CurrentRun.Hero, "BreakExplosiveArmorBoon")
end

function UpgradeHammers()
	local eligibleTraits = {}
	local eligibleTraitNames = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.IsHammerTrait and trait.RarityLevels and trait.RarityLevels.Legendary and not trait.RemainingUses then
			table.insert( eligibleTraits, trait )
			eligibleTraitNames[ trait.Name ] = true
		end
	end
	if IsEmpty( eligibleTraits ) then
		return
	end
	
	local pickedTrait = GetRandomValue( eligibleTraits )
	local pickedTraitName = pickedTrait.Name
	thread( IncreasedHammerRarityPresentation, { [pickedTraitName] = true }, 1 )
	AddRarityToTraits( traitData, { ForceUpgrade = { pickedTrait }, TargetRarityName = "Legendary", Silent = true })
	if pickedTrait.ReplaceMeleeWeapon and pickedTrait.SetupFunction then
		CallFunctionName( pickedTrait.SetupFunction.Name, CurrentRun.Hero, pickedTrait.SetupFunction.Args )
	end
end

function CheckDionysusDebuff( victim, functionArgs, triggerArgs )
	if not victim then
		return
	end
	local weaponName = triggerArgs.SourceWeapon
	if IsExWeapon( weaponName, { Combat = true } , triggerArgs ) and not victim.HitByDionysusEx then
		victim.HitByDionysusEx = true
		local effectName = functionArgs.EffectName
		local dataProperties = ShallowCopyTable( EffectData[effectName].DataProperties )
		dataProperties.Amount = functionArgs.Damage
		ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, 
			DataProperties = dataProperties })
	end
end

function CheckPoseidonSplash(victim, functionArgs, triggerArgs )
	local cooldownName = "PoseidonSplash"
	if functionArgs.CooldownName then
		cooldownName = functionArgs.CooldownName
	end
	if ProjectileHasUnitHit( triggerArgs.ProjectileId, "PoseidonSplash") 
		and (triggerArgs.SourceWeapon == nil or not functionArgs.MultihitWeaponWhitelistLookup or not functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon])
		and (triggerArgs.SourceProjectile == nil or not functionArgs.MultihitProjectileWhitelistLookup or not functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile])  then
		return
	end
	local passesMultihitCheck = true
	if triggerArgs.SourceProjectile ~= nil and functionArgs.MultihitProjectileWhitelistLookup and functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile] and functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile] then
		local conditions = ShallowCopyTable(functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile])
		
		if conditions.TraitNameRequirements then
			for _, traitConditions in pairs( conditions.TraitNameRequirements ) do
				if traitConditions.TraitName and HeroHasTrait(traitConditions.TraitName) then
					conditions = ShallowCopyTable(traitConditions)
					break
				end
			end
		end
		if not conditions.Cooldown and not conditions.Window and ProjectileHasUnitHit( triggerArgs.ProjectileId, "PoseidonSplash") then
			return
		end
		if conditions.Cooldown and not CheckCooldown( "PoseidonSplash", conditions.Cooldown ) then
			return
		end
		if conditions.Window and CheckCountInWindow("PoseidonSplash", conditions.Window, conditions.Count ) then
			return
		end
	elseif triggerArgs.SourceWeapon ~= nil and functionArgs.MultihitWeaponWhitelistLookup[triggerArgs.SourceWeapon] and functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon] then
		local conditions = functionArgs.MultihitWeaponConditions[triggerArgs.SourceWeapon]
		if conditions.Cooldown and not CheckCooldown( "PoseidonSplash", conditions.Cooldown ) then
			return
		end
		if conditions.Window and CheckCountInWindow("PoseidonSplash", conditions.Window, conditions.Count ) then
			return
		end
	else
		if functionArgs.Cooldown and not CheckCooldown( "PoseidonSplash", functionArgs.Cooldown ) then
			return
		end
		if functionArgs.Window and CheckCountInWindow("PoseidonSplash", functionArgs.Window, functionArgs.Count ) then
			return
		end		
	end
	local force = 600
	local scale = 1
	if triggerArgs.AttackerWeaponData then
		if triggerArgs.AttackerWeaponData.DefaultKnockbackForce then
			force = triggerArgs.AttackerWeaponData.DefaultKnockbackForce
		end
		if triggerArgs.AttackerWeaponData.DefaultKnockbackScale then
			scale = triggerArgs.AttackerWeaponData.DefaultKnockbackScale
		end
	end
	ProjectileRecordUnitHit( triggerArgs.ProjectileId, "PoseidonSplash" )
	if triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] then
		if ProjectileData[triggerArgs.SourceProjectile].DefaultKnockbackForce then
			force = ProjectileData[triggerArgs.SourceProjectile].DefaultKnockbackForce 
		end
		if ProjectileData[triggerArgs.SourceProjectile].DefaultKnockbackScale then
			scale = ProjectileData[triggerArgs.SourceProjectile].DefaultKnockbackScale 
		end
	end
	local graphic = nil
	local count = 1
	for i, data in pairs(GetHeroTraitValues("ConeModifier")) do
		if data.ScaleIncrease then
			scale = scale * data.ScaleIncrease
		end
		if data.MaxScale and scale > data.MaxScale then
			scale = data.MaxScale
		end
		if data.DoubleWaveChance and RandomChance(data.DoubleWaveChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
			count = count + 1
			graphic = data.DoubleWaveGraphic
		end
	end

	for i=1, count do
		CreateProjectileFromUnit({ 
			Name = functionArgs.ProjectileName, 
			Id = CurrentRun.Hero.ObjectId, 
			Angle = triggerArgs.ImpactAngle, 
			DestinationId = victim.ObjectId, 
			DamageMultiplier = functionArgs.DamageMultiplier, 
			ScaleMultiplier = scale,
			SpeedMultiplier = scale,
			FireFromTarget = true,
			DataProperties = 
			{
				StartFx = graphic,
				ImpactVelocity = force,
				StartDelay = (i - 1 ) * 0.1
			},
		})
	end
end

function StartAxeSturdy( weaponData, args )
	AddIncomingDamageModifier( CurrentRun.Hero,
	{
		HealthOnly = true,
		Name = "AxeSturdy",
		ValidWeaponMultiplier = args.DamageTakenModifier,
		Temporary = true,
	})
	CreateAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end

function EndAxeSturdy()
	RemoveIncomingDamageModifier( CurrentRun.Hero, "AxeSturdy" )
	StopAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end


function CheckAxeNova( weaponOrTriggerArgs, args)
	if weaponOrTriggerArgs.name == "ProjectileAxeSpin" and HeroHasTrait("AxeFreeSpinTrait") then
		return
	end
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DamageMultiplier = args.DamageMultiplier })
end

function StartLobSturdy( weaponData, args, triggerArgs )
	if IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) then
		return
	end
	AddIncomingDamageModifier( CurrentRun.Hero,
	{
		HealthOnly = true,
		Name = "LobHammer",
		ValidWeaponMultiplier = args.DamageTakenModifier,
		Temporary = true,
	})
	CreateAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end

function EndLobSturdy()
	RemoveIncomingDamageModifier( CurrentRun.Hero, "LobHammer" )
	StopAnimation({ Name = "HyperArmorLoop", DestinationId = CurrentRun.Hero.ObjectId })
end

function PermanentSwitchWeapon( unit, args )
	for k, weaponName in ipairs( WeaponSets.HeroPrimaryWeapons ) do
		if unit.Weapons[weaponName] then
			SwapWeapon({ DestinationId = unit.ObjectId, Name = weaponName, SwapWeaponName = args, StompOriginalWeapon = true })
			return
		end
	end
end

function CheckFamiliarLink( weaponData, functionArgs, triggerArgs )
	if not MapState.FamiliarUnit then	
		return
	end
	local armCast = SessionMapState.ArmCast
	for i, data in pairs( GetHeroTraitValues( "OverrideWeaponFireNames" )) do
		for weapon, overrideName in pairs( data ) do
			if overrideName == "WeaponCast" and weaponData.Name == "WeaponCast" then
				return
			end
		end
	end

	killTaggedThreads( "WaitForFamiliarLinkEnd" )
	wait( 0.02 )
	MapState.FamiliarUnit.Linked = true
	if MapState.FamiliarUnit.LinkBeginFunctionName ~= nil then
		thread( CallFunctionName, MapState.FamiliarUnit.LinkBeginFunctionName, MapState.FamiliarUnit )
	end

	local familiarLocation = nil
	familiarLocation = GetLocation({ Id = MapState.FamiliarUnit.ObjectId })
	if not MapState.FamiliarLocationId then
		MapState.FamiliarLocationId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = familiarLocation.X, LocationY = familiarLocation.Y, Group = "Scripting" })
	end
	Attach({ Id = MapState.FamiliarLocationId, DestinationId = MapState.FamiliarUnit.ObjectId })
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = "ProjectileCast",
		WeaponName = "WeaponCast",
		Type = "Projectile",
	})
	derivedValues.PropertyChanges.AttachToOwner = false
	local projectileId = CreateProjectileFromUnit({ WeaponName = "WeaponCast", Name = "ProjectileCast", Id = CurrentRun.Hero.ObjectId, DestinationId = MapState.FamiliarLocationId, FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ExcludeFromCap = true })
	SessionMapState.FamiliarCastProjectileId = projectileId
	local baseDuration = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileCast", Property = "FuseStart" })
	for i, traitArgs in pairs(GetHeroTraitValues("CastProjectileModifiers")) do
		SetDamageRadiusMultiplier({ Id = projectileId, Fraction = traitArgs.AreaIncrease, Duration = baseDuration })
	end
	thread( StartCastSlow, projectileId, baseDuration )
	for i, traitData in pairs( GetHeroTraitValues ("OnWeaponFiredFunctions")) do
		if traitData.FunctionName ~= "CheckFamiliarLink" and traitData.FunctionName ~= nil and ( traitData.ValidWeapons == nil or Contains( traitData.ValidWeapons, "WeaponCast" ) ) then
			thread( CallFunctionName, traitData.FunctionName, weaponData, traitData.FunctionArgs, 
			-- Spoofing a weapon fired event here
			{
				ProjectileX = familiarLocation.X,
				ProjectileY = familiarLocation.Y,
				ProjectileId = projectileId,
				UnitIdOverride = MapState.FamiliarUnit.ObjectId, -- PoseidonCast specific
			})
		end
	end
	if armCast then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponCastArm", Method = "ArmProjectiles" })
	end

	local duration = GetBaseDataValue({ Type = "Projectile", Name = functionArgs.ProjectileName, Property = "Fuse" })
	thread( ShowCrystalPresentation, MapState.FamiliarUnit, { Duration = duration })
	thread( WaitForFamiliarLinkEnd, MapState.FamiliarUnit, { Duration = duration } )
	CreateProjectileFromUnit({ Name = "FamiliarLinkLaser", Id = CurrentRun.Hero.ObjectId, DestinationId = MapState.FamiliarUnit.ObjectId, DamageMultiplier = functionArgs.DamageMultiplier })
end

function CheckPotionClearCast( weaponData, functionArgs, triggerArgs )
	if not IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) and not triggerArgs.DisjointExCast then
		return
	end
	if SessionMapState.QueuedClearCast then
		SessionMapState.QueuedClearCast = nil
		RefillMana()
		local dataProperties = MergeTables(	EffectData[functionArgs.EffectName].DataProperties, functionArgs.DataProperties)
			
		thread( PotionClearCastPresentation, dataProperties.Duration)
		ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
	end
end


local clearCastManaRefundInvalidWeapons  = 
{
	WeaponStaffSwing = true,
	WeaponStaffSwing2 = true,
	WeaponStaffSwing3 = true,
	WeaponStaffDash = true,
	WeaponAxe3 = true
}
function CheckClearCastManaRefund( functionArgs, manaDelta, triggerArgs )
	if IsEmpty(MapState.ClearCastWeapons) and not ClearCastRestoreEligible(manaDelta) then
		return
	end
	if triggerArgs and clearCastManaRefundInvalidWeapons [triggerArgs.Source]
		and not ( CurrentRun.Hero.ActiveEffects.ClearCastPoseidon or CurrentRun.Hero.ActiveEffects.ClearCast ) then
		return
	end
	local manaRestored = math.abs(manaDelta)
	CreateAnimation({ Name = functionArgs.AnimationName, DestinationId = CurrentRun.Hero.ObjectId })
	thread( ManaOverTimeRefund, functionArgs.Duration, functionArgs.Interval, manaRestored, true)
end

function CheckStaffProjectilePull( victim, functionArgs, triggerArgs )
	if not victim then
		return
	end
	local radius = functionArgs.Radius
	local pullVfx = functionArgs.PullVfx
	local isEx = false
	local weaponData = GetWeaponData( CurrentRun.Hero, triggerArgs.SourceWeapon )
	if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
		radius = functionArgs.RadiusEx
		pullVfx = functionArgs.ExPullVfx
		isEx = true
	end
	if functionArgs.TraitPullVfxOverride then
		for traitName, data in pairs( functionArgs.TraitPullVfxOverride ) do
			if HeroHasTrait(traitName) then
				if isEx then
					pullVfx = data.ExPullVfx
				else
					pullVfx = data.PullVfx
				end
			end
		end
	end
	local location = GetLocation({ Id = victim.ObjectId })
	local tempObstacleId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY= location.Y})
	
	local nearestEnemyTargetIds = 
		GetClosestIds({ Id = tempObstacleId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = radius, ScaleY = functionArgs.ScaleY, PreciseCollision = true })
	CreateAnimation({ Name = pullVfx, DestinationId = tempObstacleId, ScaleRadius = damageRadius })
	local distance = GetDistance({ DestinationId = CurrentRun.Hero.ObjectId, Id = tempObstacleId })
	if distance < functionArgs.PlayerDistance or ( isEx and distance < functionArgs.PlayerDistanceEx ) then
		Teleport({ Id = tempObstacleId, DestinationId = CurrentRun.Hero.ObjectId })
	else
		local angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = tempObstacleId })
		
		if isEx then
			distance = distance - functionArgs.PlayerDistanceEx
		else
			distance = distance - functionArgs.PlayerDistance
		end
		local offset = CalcOffset( math.rad(angle), distance )
		Teleport({ Id = tempObstacleId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
	
	end
	for i, id in pairs( nearestEnemyTargetIds ) do
		if ActiveEnemies[id] ~= victim or functionArgs.VictimWillBeAlive then
			ApplyForce({ Id = id, Speed = GetRequiredForceToEnemy( id, tempObstacleId, -functionArgs.DeadZoneRadius, functionArgs.DistanceMultiplier ), Angle = GetAngleBetween({ Id = id, DestinationId = tempObstacleId }) })
		end
	end
	Destroy({ Id = tempObstacleId })
end

function CreateSecondAnubisWall(weaponData, args, triggerArgs )
	local weaponName = "WeaponStaffSwing5"
	local projectileName = "ProjectileStaffWall"
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	local offset = CalcOffset( math.rad(angle), args.Distance )
	local projectileId = CreateProjectileFromUnit({ 
		WeaponName = weaponName, 
		Name = projectileName,
		OffsetX = offset.X,
		OffsetY = offset.Y,
		Angle = angle,
		Id = CurrentRun.Hero.ObjectId, 
		DestinationId = MapState.FamiliarLocationId, 
		FireFromTarget = true, 
		DataProperties = derivedValues.PropertyChanges, 
		ThingProperties = derivedValues.ThingPropertyChanges, 
		ExcludeFromCap = true 
	})
	
end

function SetupAnubisAnimationSwaps()
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.ObjectId then
		return
	end
	local weaponNames = 
	{
		"WeaponStaffSwing", "WeaponStaffDash",
	}
	for _, weaponName in pairs( weaponNames ) do
		local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" })
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "BaseChargeTime", Value = chargeTime, ValueChangeType = "Absolute", DataValue = false})
	end
	wait(0.1)
	SwapAnimation({ Name = "StaffOrbGlowWithTrail", DestinationName = "StaffOrbGlowWithTrail_Anubis" })
	SwapAnimation({ Name = "StaffOrbGlow", DestinationName = "StaffOrbGlow_Anubis" })
end


function EndAnubisAnimationSwaps()
	wait(0.1)
	ExpireProjectiles({ Names = {"ProjectileStaffWall", "ProjectileStaffSingle"} })
	SwapAnimation({ Name = "StaffOrbGlowWithTrail", Reverse = true })
	SwapAnimation({ Name = "StaffOrbGlow", Reverse = true })
end

function CheckDaggerPenetration( victim, functionArgs, triggerArgs )
	if victim and victim.ActiveEffects and victim.ActiveEffects.ImpactSlow and triggerArgs.ProjectileId then
		ExpireProjectiles({ ProjectileId = triggerArgs.ProjectileId, BlockSpawns = true})
	end
end


function ExpireDaggersOnBlink( weaponData, functionArgs, triggerArgs )
	ExpireProjectiles({ WeaponName = "WeaponDaggerThrow", SkipExistingProjectiles = true, CancelQueuedProjectilesOnId = CurrentRun.Hero.ObjectId })
end

function CheckDaggerBlockRecharge( traitData, reloadTime )
	wait(reloadTime, "DaggerBlockShield" )
	if not CurrentRun.Hero.IsDead and MapState.ChargedManaWeapons.WeaponDagger5 ~= nil and traitData and traitData.OnWeaponChargeFunctions and traitData.OnWeaponChargeFunctions.FunctionArgs then
		local functionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
		MapState.DaggerBlockShieldActive = true
		SetThingProperty({ Property = "AllowDodge", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		SetPlayerUninterruptible("DaggerBlock")
	end
end

function CheckDaggerBlock( weaponData, functionArgs )
	if not MapState.DaggerBlockShieldActive and CheckCooldownNoTrigger("DaggerBlockShield", functionArgs.Cooldown ) then
		CreateAnimation({ Name = functionArgs.Vfx, DestinationId = CurrentRun.Hero.ObjectId })
		if functionArgs.BackVfx then
			CreateAnimation({ Name = functionArgs.BackVfx, DestinationId = CurrentRun.Hero.ObjectId })
		end
		MapState.DaggerBlockShieldActive = true
		SetThingProperty({ Property = "AllowDodge", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		SetPlayerUninterruptible("DaggerBlock")
	end
end

function RemoveCritVolley(triggerArgs)
	if triggerArgs.WeaponName and MapState.CritVolleys and MapState.CritVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( MapState.CritVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if MapState.CritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			MapState.CritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckDaggerCritCharges( weaponData, functionArgs, triggerArgs )
	if MapState.DaggerCharges and MapState.DaggerCharges >= 1 then
		MapState.CritVolleys = MapState.CritVolleys or {}
		MapState.CritVolleys[weaponData.Name] = MapState.CritVolleys[weaponData.Name] or {}
		IncrementTableValue(MapState.CritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		local numProjectiles = 1
		if weaponData.Name == "WeaponDaggerThrow" then
			numProjectiles = triggerArgs.NumProjectiles or numProjectiles
		end
		MapState.DaggerCharges = MapState.DaggerCharges - numProjectiles

		for k,v in ipairs( SessionMapState.DaggerCritTicks ) do
			if k > MapState.DaggerCharges then
				RemoveArtemisDaggerTick( k )
			end
		end

		if MapState.DaggerCharges <= 0 then
			local traitData = GetHeroTrait("DaggerBlockAspect")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			thread( DaggerBlockClearedPresentation, chargeFunctionArgs )
			MapState.DaggerCharges = 0
		end
	end
end

function SetupArtemisDaggerTicks( functionArgs )
	local daggerTicks = MapState.DaggerCharges
	SessionMapState.DaggerCritTicks = SessionMapState.DaggerCritTicks or {}

	for k,v in ipairs( SessionMapState.DaggerCritTicks ) do
		Destroy({ Id = SessionMapState.DaggerCritTicks[ k ]})
	end

	for i = 1, daggerTicks do
		SessionMapState.DaggerCritTicks[i] = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
		Attach({ Id = SessionMapState.DaggerCritTicks[i], DestinationId = CurrentRun.Hero.ObjectId })
		SetAnimation({ Name = "ArtemisCritDaggerTick", DestinationId = SessionMapState.DaggerCritTicks[i] })
		wait( 0.01 )

		local centeredAngle = 90
		local angleSpread = 220
		local angleOffset = math.floor(i/2) / math.floor(daggerTicks/2) * angleSpread / 2

		angleOffset = angleOffset * ( i%2*2-1 )
		centeredAngle = centeredAngle  + angleOffset
		if daggerTicks % 2 == 0 then 
			centeredAngle = centeredAngle + ( angleSpread / daggerTicks / 2)
		end

		SetAngle({ Id = SessionMapState.DaggerCritTicks[i], Angle = centeredAngle })
	end
end

function RemoveArtemisDaggerTick( index )
	if SessionMapState.DaggerCritTicks[ index ] then 
		SetAnimation({ Name = "ArtemisCritDaggerTickOut", DestinationId = SessionMapState.DaggerCritTicks[ index ]})
		wait( 0.13333 )
		Destroy({ Id = SessionMapState.DaggerCritTicks[ index ]})
	end
end

function DropOriginMarker( weaponData, functionArgs, triggerArgs )
	if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) or triggerArgs.DisjointExCast then
		local playerLocation = GetLocation({ Id = CurrentRun.Hero.ObjectId })
		local startX = triggerArgs.ProjectileX or playerLocation.X
		local startY = triggerArgs.ProjectileY or playerLocation.Y
		local weaponName = weaponData.Name
		if weaponData.Name == "WeaponCastArm" then
			weaponName = "WeaponCast"
			if SessionMapState.LastCastProjectileId and ProjectileExists({ Id = SessionMapState.LastCastProjectileId }) then
				local position = GetLocation({Id = SessionMapState.LastCastProjectileId, IsProjectile = true })
				startX = position.X
				startY = position.Y
			end
		elseif weaponName == "WeaponStaffBall" then
			SessionMapState.OriginMarkers = SessionMapState.OriginMarkers or {}
			if SessionMapState.OriginMarkers[weaponName] then
				Destroy({ Id = SessionMapState.OriginMarkers[weaponName] })
			end
		end
		if weaponName == "WeaponStaffSwing5" then
			ExpireProjectiles({ Names = {"ProjectileSwing5Magic"}})
			startX = playerLocation.X
			startY = playerLocation.Y

			if HeroHasTrait("DoubleExManaBoon") or HeroHasTrait("StaffOneWayAttackTrait") then	
				local baseCount = 3
				if HeroHasTrait("StaffOneWayAttackTrait") then
					baseCount = baseCount * 2
				end
				if HeroHasTrait("DoubleExManaBoon") then
					baseCount = baseCount + 1
				else
					SetNextWaveTime({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Value = 0 })
				end

				SetWeaponProperty({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectileWaves", Value = baseCount })
				SetWeaponProperty({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumWavesQueued", Value = baseCount - 1, ValueChangeType = "Absolute", DataValue = false })
			end
		end
		local traitData = GetHeroTrait("StaffSelfHitAspect")
		local animationName = functionArgs.AnimationName
		if weaponName == "WeaponCast" then
			local threadName = "RepeatCastThread"
			if HasThread( threadName ) then
				killTaggedThreads( threadName )
				waitUnmodified(0.1)
				local id = SessionMapState.OriginMarkers.WeaponCast
				SessionMapState.OriginMarkers.WeaponCast = nil
				SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
				thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
			end	
		end
		if  weaponName == "WeaponStaffBall" then
			local threadName = "RepeatSpecialThread"
			if HasThread( threadName ) then
				killTaggedThreads( threadName )
				waitUnmodified(0.1)
				local id = SessionMapState.OriginMarkers.WeaponCast
				SessionMapState.OriginMarkers.WeaponCast = nil
				SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
				thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
			end
			thread(StartSpecialRepeatThread, startX, startY, GetAngle({Id = CurrentRun.Hero.ObjectId}), functionArgs, triggerArgs )
		end
		if  weaponName == "WeaponStaffSwing5" then
			local threadName = "RepeatWeaponThread"
			if HasThread( threadName ) then
				killTaggedThreads( threadName )
				waitUnmodified(0.1)
				local id = SessionMapState.OriginMarkers.WeaponStaffSwing5
				SessionMapState.OriginMarkers.WeaponStaffSwing5 = nil
				SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
				thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
			end
			
			thread(StartPrimaryRepeatThread, functionArgs, triggerArgs )
		end
		local zOffset = 90
		if HeroHasTrait("SelfCastBoon") and weaponName == "WeaponCast" then
			zOffset = 160
		end
		local originMarkerId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing", LocationX = startX, LocationY = startY, OffsetZ = zOffset })
		SetAngle({ Id = originMarkerId, Angle = GetAngle({Id = CurrentRun.Hero.ObjectId}) })
		SetAnimation({ Name = functionArgs.AnimationName, DestinationId = originMarkerId })
		SessionMapState.OriginMarkers[weaponName] = originMarkerId

		if HeroHasTrait("SelfCastBoon") and weaponName == "WeaponCast" then
			Attach({ Id = originMarkerId, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end
end

function StartSpecialRepeatThread( startX, startY, angle, functionArgs, triggerArgs )
	functionArgs = functionArgs or {}
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local threadName = "RepeatSpecialThread"
	local weaponName = "WeaponStaffBall"
	local projectileName = "ProjectileStaffBallCharged"
	local repeats = 1
	local useSecondStageCharacteristics = false
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	local traitData = GetHeroTrait("StaffSelfHitAspect")
	local animationName = "WitchGrenadeRecallSphere"
	if traitData and traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs and traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName then
		animationName = traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName
	end
	
	if HeroHasTrait("StaffSecondStageTrait") and (SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] or 0) >= 2 then
		useSecondStageCharacteristics = true
			-- TODO: extract these from a version of derive property change values on the weapon
		derivedValues.PropertyChanges.DamageRadius = 550
		derivedValues.PropertyChanges.BlastSpeed = 2500
	end		
	local logProjectileIdForMagicCrit = false
	if SessionMapState.DifferentOmegaVolleys[weaponName] and SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end	
	while repeats < functionArgs.Repeats do
		waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		if (CurrentRun.Hero.IsDead and (not CurrentHubRoom or not CurrentHubRoom.AllowEnemyAIActive)) or ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		if HeroHasTrait("StaffTripleShotTrait") then
			-- TODO: extract these from a version of derive property change values on the weapon
			local numProjectiles = 2
			local delay = 0.12
			if weaponData.RepeatFireSound then
				PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
			end
			local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
			if logProjectileIdForMagicCrit then
				SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
				SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
			end
			waitUnmodified( delay, threadName )
		end
		if (CurrentRun.Hero.IsDead and (not CurrentHubRoom or not CurrentHubRoom.AllowEnemyAIActive)) or ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local animationName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "FireFx"})
		if animationName then
			CreateAnimation({ Name = animationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		if weaponData.RepeatFireSound then
			PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
		end
		local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
		if logProjectileIdForMagicCrit then
			SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
			SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
		end
		if useSecondStageCharacteristics then
			local currentVolley = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Volley" })
			SessionMapState.ProjectileChargeStageReached[currentVolley] = 2
		end
		Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = SessionMapState.OriginMarkers[weaponName]
	SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	
	SessionMapState.OriginMarkers[weaponName] = nil
end

function StartCastRepeatThread( triggerArgs, functionArgs )
	functionArgs = functionArgs or {}
	functionArgs.CastRepeats = functionArgs.CastRepeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local startX = triggerArgs.LocationX
	local startY = triggerArgs.LocationY
	local threadName = "RepeatCastThread"
	local weaponName = "WeaponCast"
	local projectileName = "ProjectileCast"
	local repeats = 1
	if HasThread( threadName ) then
		killTaggedThreads( threadName )
		waitUnmodified(0.1)
	end
	local logProjectileIdForMagicCrit = false
	if SessionMapState.DifferentOmegaVolleys[weaponName] and SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end	
	local id = SessionMapState.OriginMarkers[weaponName]
	SessionMapState.InvalidRepeatCastIds = {}
	local traitData = GetHeroTrait("StaffSelfHitAspect")
	local animationName = "WitchGrenadeRecallSphere"
	if traitData and traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs and traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName then
		animationName = traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName
	end
	while repeats < functionArgs.CastRepeats do
		waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (CurrentRun.Hero.IsDead and (not CurrentHubRoom or not CurrentHubRoom.AllowEnemyAIActive)) or ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = projectileName,
			WeaponName = weaponName,
			Type = "Projectile",
		})
		derivedValues.ThingPropertyChanges = derivedValues.ThingPropertyChanges or {}
		derivedValues.ThingPropertyChanges.Graphic = "null"
		derivedValues.PropertyChanges.StartFx = "null"
		local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, ExcludeFromCap = true })
		if logProjectileIdForMagicCrit then
			SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
			SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
		end
		SessionMapState.InvalidRepeatCastIds[ projectileId ] = true
		ArmAndDetonateProjectiles({ Ids = { projectileId } })
		SetAnimation({ Name = traitData.OnWeaponFiredFunctions.FunctionArgs.AttackAnimationName, DestinationId = id })
		Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	SessionMapState.OriginMarkers[weaponName] = nil
	SessionMapState.WeaponCastRepeats = nil
	wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
end

function StartPrimaryRepeatThread( functionArgs, triggerArgs )
	functionArgs = ShallowCopyTable(functionArgs) or {}
	local threadName = "RepeatWeaponThread"
	local weaponName = "WeaponStaffSwing5"
	local repeats = 1
	local totalRepeats = GetWeaponDataValue({ WeaponName = weaponName, Id = CurrentRun.Hero.ObjectId, Property = "NumProjectileWaves"})
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	if HeroHasTrait("StaffOneWayAttackTrait") then
		functionArgs.Interval = functionArgs.Interval / 2
	end
	if HeroHasTrait("DoubleExManaBoon") then
		wait(0.25, threadName)
		repeats = repeats + 1
		SetNextWaveTime({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Value = 0 })
		if weaponData.RepeatFireSound then
			PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
		end
	end
	while repeats < totalRepeats do
		wait(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		wait( functionArgs.PreAttackDuration, threadName)
		repeats = repeats + 1
		SetNextWaveTime({ WeaponName = "WeaponStaffSwing5", DestinationId = CurrentRun.Hero.ObjectId, Value = 0 })

		if weaponData.RepeatFireSound then
			PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
		end
		local animationName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponStaffSwing5", Property = "FireFx"})
		if animationName then
			CreateAnimation({ Name = animationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end		
	end
	wait( 0.5, threadName) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = SessionMapState.OriginMarkers[weaponName]
	SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	
	SessionMapState.OriginMarkers[weaponName] = nil
end
function ClearOriginMarker( triggerArgs, functionArgs )
	if triggerArgs.WeaponName =="WeaponStaffSwing5" and triggerArgs.FireEndProjectile and triggerArgs.WeaponName and SessionMapState.OriginMarkers and SessionMapState.OriginMarkers[triggerArgs.WeaponName] then
		local id = SessionMapState.OriginMarkers[triggerArgs.WeaponName]
		SessionMapState.OriginMarkers[triggerArgs.WeaponName] = nil

		SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
		thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	end
	if triggerArgs.name == "ProjectileCast" and triggerArgs.Armed then
		if triggerArgs.ProjectileId and SessionMapState.InvalidRepeatCastIds[triggerArgs.ProjectileId] then
			--SessionMapState.InvalidRepeatCastIds[triggerArgs.ProjectileId] = nil
		else
			thread( StartCastRepeatThread, triggerArgs, functionArgs )
		end
	end
end

function ClearAllOriginMarkers()
	if not IsEmpty( SessionMapState.OriginMarkers ) then
		Destroy({Ids = GetAllValues( SessionMapState.OriginMarkers )})
	end
	killTaggedThreads( "RepeatSpecialThread" )
	killTaggedThreads( "RepeatWeaponThread" )
	killTaggedThreads( "RepeatCastThread" )

	ExpireProjectiles({ Names = {"ProjectileSwing5Magic"}})
end

function CheckDashVolley( weaponData, functionArgs, triggerArgs )
	if weaponData.Name == "WeaponBlink" or weaponData.Name == "WeaponLobSpecial" then
		SessionMapState.LobSpeedMultiplier = true
		local speedMultiplier = functionArgs.SpeedMultiplier
		if HeroHasTrait("LobGunAspect") then
			speedMultiplier = 1.2
		end
		SetWeaponProperty({ WeaponName = "WeaponLob", DestinationId = CurrentRun.Hero.ObjectId, Property = "SpeedMultiplier", Value = speedMultiplier, ValueChangeType = "Absolute"})
	elseif SessionMapState.LobSpeedMultiplier then
		SessionMapState.LobSpeedMultiplier = nil
		SessionMapState.DashVolleys[ triggerArgs.ProjectileVolley ] = { Count = triggerArgs.NumProjectiles }
		SetWeaponProperty({ WeaponName = weaponData.Name, DestinationId = CurrentRun.Hero.ObjectId, Property = "SpeedMultiplier", Value = 1, ValueChangeType = "Absolute"})
	end
end

function RemoveDashVolley(triggerArgs)
	wait(2)
	if SessionMapState.DashVolleys and SessionMapState.DashVolleys[triggerArgs.ProjectileVolley] then
		SessionMapState.DashVolleys[triggerArgs.ProjectileVolley].Count = SessionMapState.DashVolleys[triggerArgs.ProjectileVolley].Count - 1
		if SessionMapState.DashVolleys[triggerArgs.ProjectileVolley].Count <= 0 then
			SessionMapState.DashVolleys[triggerArgs.ProjectileVolley] = nil
		end
	end
end
function CheckWeaponAmmoFire( weaponData, functionArgs, triggerArgs )
	if SessionMapState.AmmoAtFireStart and CurrentRun.Hero.Ammo[weaponData.Name] then
		if triggerArgs.ProjectileVolley then
			SessionMapState.AmmoVolleys[ triggerArgs.ProjectileVolley ] = { AmmoCount = SessionMapState.AmmoAtFireStart, Count = triggerArgs.NumProjectiles }
		end
	end
end

function RemoveWeaponAmmoFire(triggerArgs)
	wait(2)
	if SessionMapState.AmmoVolleys and SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] then
		if SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count then
			SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count = SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count - 1
			if SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley].Count <= 0 then
				SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] = nil
			end
		else
			SessionMapState.AmmoVolleys[triggerArgs.ProjectileVolley] = nil
		end
	end
end

function SetupSuitUI()	
	wait(0.1)
	ShowSuitUI()
end

function SetupPerfectCritUI()	

	if SessionMapState.WeaponsDisabled then
		return
	end

	wait(0.1)
	if HeroHasTrait("AxePerfectCriticalAspect") then
		local trait = GetHeroTrait("AxePerfectCriticalAspect")
    	local currentCrit = round(trait.PerfectCritChance * 100, 1)
    	local maxCrit = trait.ReportedMaxCrit * 100
    	if currentCrit == maxCrit then
    		CreateAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = CurrentRun.Hero.ObjectId })
    	end
	end
	ShowAxeUI()
end

function SetupFrenzyUI()
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.ObjectId then
		return
	end

	local weaponNames = 
	{
		"WeaponAxe", "WeaponAxe2","WeaponAxe3", "WeaponAxeDash",
	}
	for _, weaponName in pairs( weaponNames ) do
		local chargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" })
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "BaseChargeTime", Value = chargeTime, ValueChangeType = "Absolute", DataValue = false})
	end
	wait(0.1)
	ShowAxeUI()
end

function HideGunUI()
	wait(0.1)
	ShowLobUI()
	HideAmmoUI()
end

function HandleGunBehavior( weaponData, functionArgs, triggerArgs )

	if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )  then
		if triggerArgs.ProjectileId and ( weaponData.Name == "WeaponLob" or weaponData.Name == "WeaponLobSpecial" ) then
			local chargeStages = GetWeaponChargeStages( weaponData )
			local manaSpend = GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[MapState.WeaponCharge[weaponData.Name]].ManaCost}) 
			ManaDelta( -manaSpend )
			if weaponData.Name == "WeaponLob" then
				EmptyWeaponCharge( weaponData, 1, chargeStages[1] )
				notifyExistingWaiters( weaponData.Name.."IndicatorFire" )
				thread( DoWeaponCharge, triggerArgs, weaponData, { Force = true } )
				thread( HandleManaChargeIndicator, { name = weaponData.Name } )
				if functionArgs.ExAttackApplyEffects then
					for i, effectName in pairs(functionArgs.ExAttackApplyEffects) do
						local dataProperties = ShallowCopyTable(EffectData[effectName].EffectData)
						ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties})
					end
				end
			ResetBulletCount( functionArgs.ClipRegenInterval )
			else
				local dataProperties = MergeTables(	EffectData[functionArgs.EffectName].DataProperties, functionArgs.EffectData )
				dataProperties.Duration = dataProperties.Duration + GetTotalHeroTraitValue("OverheatDurationIncrease")
				ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties })
			
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLobSpecial", Method = "forceReload"})
			end
		end
	else
		if weaponData.Name == "WeaponLob" and not SessionMapState.Overheat then
			IncrementTableValue(SessionMapState, "BulletCount", 1 )
			if SessionMapState.BulletCount > functionArgs.ClipSize then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.Name, Method = "forceCooldown", Parameters = { functionArgs.ClipReload * GetChangeFromBaseValue( "WeaponLob", "Cooldown") }})
				SessionMapState.BulletCount = 1
			end
			ResetBulletCount( functionArgs.ClipRegenInterval )
		end
	end
end

function ResetBulletCount( clipRegenInterval )
	if not clipRegenInterval then
		return
	end
	local bulletResetDelay = clipRegenInterval
	local threadName = "BulletReset"
	if SetThreadWait( threadName, bulletResetDelay ) then
		return
	end
	wait( bulletResetDelay, threadName )
	SessionMapState.BulletCount = 1
end

function OnGunOverheatCreated( triggerArgs )
	PlaySound({ Name = "/SFX/Player Sounds/MelSkullsOmegaAttackStart", Id = CurrentRun.Hero.ObjectId})
end

function OnGunRiftCreated( triggerArgs )
	SessionMapState.LobGunSpecialHits = {}
end

function OnGunRiftDeath( triggerArgs )
	SessionMapState.LobGunSpecialHits = {}
end

function OnGunRiftDamage( victim, args, triggerArgs )
	if not victim or not victim.ObjectId then
		return
	end
	SessionMapState.LobGunSpecialHits[ victim.ObjectId ] = true
end

function SetupMedeaAnimationSwaps()
	wait(0.1)
	SwapAnimation({ Name = "LobSkullGlow", DestinationName = "LobSkullGlow_Medea" })
	SwapAnimation({ Name = "LobSkullGlowMovement", DestinationName = "LobSkullGlowMovement_Medea" })
	SwapAnimation({ Name = "LobProjectileGhostTrail", DestinationName = "LobProjectileGhostTrail_Medea" })
end

function EndMedeaAnimationSwaps()
	wait(0.1)
	SwapAnimation({ Name = "LobSkullGlow", Reverse = true })
	SwapAnimation({ Name = "LobSkullGlowMovement", Reverse = true })
	SwapAnimation({ Name = "LobProjectileGhostTrail", Reverse = true })
end

function SetupSkullImpulseUI()	
	wait(0.1)
	ShowLobUI()
end

function ResetLobSpecialCooldown( weaponData, functionArgs )
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLobSpecial", Method = "forceReload" })
end

function CheckSpawnZeusDamage( enemy, traitArgs, triggerArgs )
	if not enemy or not enemy.ObjectId or SessionMapState.SpawnKillRecord[enemy.ObjectId] or enemy == CurrentRun.Hero or (triggerArgs and traitArgs.ExcludeProjectileName and triggerArgs.SourceProjectile == traitArgs.ExcludeProjectileName ) then
		return
	end
	if enemy.IsBoss or enemy.UseBossHealthBar or not RandomChance(traitArgs.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
		SessionMapState.SpawnKillRecord[enemy.ObjectId] = true
		return
	end
	SessionMapState.SpawnKillRecord[enemy.ObjectId] = true
	local damageAmount = traitArgs.Damage
	thread( DoZeusSpawnDamage, enemy, traitArgs, damageAmount )
end

function DoZeusSpawnDamage( enemy, traitArgs, damageAmount )
	wait(0.1, RoomThreadName )
	CreateAnimation({ Name = traitArgs.Vfx, DestinationId = enemy.ObjectId, Group = "FX_Standing_Top" })
	thread( SpawnKillPresentation, enemy )
	thread( Damage, enemy, { AttackerId = CurrentRun.Hero.ObjectId, AttackerTable = CurrentRun.Hero, SourceProjectile = "ZeusOnSpawn", DamageAmount = damageAmount, Silent = false, PureDamage = true, IgnoreHealthBuffer = true } )
end

function CheckSpawnCurseDamage( enemy, traitArgs )
	if enemy.IsBoss or enemy.UseBossHealthBar or enemy.IgnoreCurseDamage or enemy.AlwaysTraitor then
		return
	end
	local damageAmount = 0
	for _, data in ipairs(traitArgs.DamageArgs) do
		if not data.Chance or RandomChance(data.Chance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
			damageAmount = RandomInt( data.MinDamage, data.MaxDamage )
			break
		end
	end
	thread( DoCurseDamage, enemy, traitArgs, damageAmount )
end

function CheckSpawnArmorDamage( enemy, traitArgs )
	if enemy.AlwaysTraitor then
		return
	end
	local damageAmount = 0
	if enemy.HealthBuffer then
		local healthMultiplier = enemy.HealthMultiplier or 1
		healthMultiplier = healthMultiplier + (MetaUpgradeData.EnemyHealthShrineUpgrade.ChangeValue - 1)

		damageAmount = enemy.HealthBuffer * healthMultiplier * traitArgs.Multiplier
		thread( DoCurseDamage, enemy, traitArgs, damageAmount, true)
	end
end

function CurseRetaliate( functionArgs, triggerArgs )
	local enemy = triggerArgs.AttackerTable
	if not enemy or not enemy.Health then
		return 
	end
	local damageAmount = enemy.Health * functionArgs.HealthDamageMultiplier
	thread( DoCurseDamage, enemy, functionArgs, damageAmount )
end

function DoCurseDamage( enemy, traitArgs, damageAmount, ignoreHitShields)
	wait(0.1, RoomThreadName )
	if not IsInvulnerable({ Id = enemy.ObjectId }) then
		CreateAnimation({ Name = traitArgs.Vfx, DestinationId = enemy.ObjectId, Group = "FX_Standing_Top" })
		thread( Damage, enemy, { AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, SourceProjectile = "MedeaCurse", SkipAggro = true, SkipOnDamagedPowers = traitArgs.SkipOnDamagedPowers, DamageAmount = damageAmount, Silent = false, PureDamage = true, IgnoreHitShields = ignoreHitShields } )
	end
end

function CheckNewStatusDamage( victim, functionArgs, triggerArgs )
	if not CheckCooldownNoTrigger( "MedeaStatusDamage", functionArgs.Cooldown ) then
		return
	end
	local effectName = triggerArgs.EffectName
	local victim = triggerArgs.Victim
	if victim and triggerArgs.IsVulnerabilityEffect and not triggerArgs.Reapplied and EffectData[effectName] and EffectData[effectName].DisplaySuffix then
		CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		CheckCooldown( "MedeaStatusDamage", functionArgs.Cooldown )
		local trait = GetHeroTrait("NewStatusDamage")
		TraitUIActivateTrait( trait, { FlashOnActive = true, Duration = functionArgs.Cooldown })
		CreateAnimation({ Name = "MedeaPoisonDamage", DestinationId = victim.ObjectId })
	end
end

function DodgeHeal( unit, traitArgs )
	Heal( CurrentRun.Hero, { HealAmount = traitArgs.Amount * CalculateHealingMultiplier() })
end

function DiminishingDodgeSetup( unit, traitArgs )
	local trait = GetHeroTrait("DiminishingDodgeBoon")
	SetLifeProperty({ Property = "DodgeChance", Value = trait.CurrentDodgeChance, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
end

function DiminishingDodge( unit, traitArgs )
	if CheckCooldown( "DiminishingDodge", traitArgs.Cooldown ) then
		local trait = GetHeroTrait("DiminishingDodgeBoon")

		if trait.CurrentDodgeChance > trait.Decay then	
			trait.CurrentDodgeChance = trait.CurrentDodgeChance - trait.Decay
			SetLifeProperty({ Property = "DodgeChance", Value = -trait.Decay, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		else
			SetLifeProperty({ Property = "DodgeChance", Value = -trait.CurrentDodgeChance, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
			thread( DiminishingDodgeExpiredPresentation )
			RemoveTraitData( CurrentRun.Hero, trait )
		end
	end
end

function AttemptAdvanceKeepsake( arg, traitData )
	AdvanceKeepsake( true )
end

function ChaosStunSelf( attacker, traitArgs, triggerArgs)
	if triggerArgs.ManuallyTriggered or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 then
		return
	end	
	if triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].IgnoreOnHitEffects then
		return
	end
	if CheckCooldown("ChaosStun", traitArgs.Cooldown ) then
		local effectName = traitArgs.EffectName
		local dataProperties = MergeTables(	EffectData[effectName].EffectData, traitArgs.DataProperties )
		EndAutoSprint({ Halt = true })
		EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
		ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
	end
end

function StartChaosTimer( args, traitData )
	traitData.CurrentTime = traitData.StartingTime
end

function StartHermesKeepsakeTimer( args, traitData )
	traitData.CurrentTime = traitData.StartingTime
end

function RemoveArcana( args, traitData )
	UnequipMetaUpgrades( nil, CurrentRun.Hero )
end

function GiveDurationHammer( args, traitData )
	if not CurrentRun.Hero.IsDead then
		local newTrait = AddRandomHammer( args )
		if newTrait then
			thread( HammerKeepsakeAcquiredPresentation, newTrait.Name )
		end
	end
end
function AddRandomHammer( args )
	RandomSynchronize()
	local eligibleTraits = {}
	for i, traitName in ipairs( LootData.WeaponUpgrade.Traits ) do
		if IsTraitEligible( TraitData[traitName] ) and not HeroHasTrait( traitName ) then
			table.insert( eligibleTraits, traitName )
		end
	end
	if IsEmpty( eligibleTraits ) then
		return
	end
	local traitName = GetRandomArrayValue( eligibleTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	traitData.RemainingUses = args.Duration
	traitData.UsesAsEncounters = true
	traitData.OnExpire = { FunctionName = "HammerKeepsakeLostPresentation", FunctionArgs = traitName }
	AddTraitToHero({ TraitData = traitData, SkipAddToHUD = true, SkipNewTraitHighlight = true})
	UpdateHeroTraitDictionary()
	return traitData
end

function ChaosBlessingBonus( args, traitData, roomArgs )
	if not CurrentRun.Hero.IsDead then
		local newTrait = AddRandomChaosBlessing( GetRarityKey(args.BlessingRarity) )
		if not roomArgs or not roomArgs.SkipNewTraitHighlight then
			thread( ChaosKeepsakeAcquiredPresentation, newTrait.Name )
		end
	end
end

function AddRandomChaosBlessing( rarityName )
	RandomSynchronize()
	local eligibleTraits = {}
	for i, traitName in ipairs( LootData.TrialUpgrade.PermanentTraits ) do
		if IsTraitEligible( TraitData[traitName] ) and TraitData[traitName].RarityLevels and TraitData[traitName].RarityLevels[rarityName] then
			table.insert( eligibleTraits, traitName )
		end
	end

	local traitName = GetRandomArrayValue( eligibleTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = rarityName })
	traitData.CustomTitle = "ChaosCombo_ChaosKeepsakePrefix_"..traitName
	traitData.FromChaosKeepsake = true
	AddTraitToHero({ TraitData = traitData })
	return traitData
end

function GiveRandomHadesBoonAndBoostBoons( args, traitData )
	RandomSynchronize()
	if not CurrentRun.Hero.IsDead and IsFateValid() then
		if not CurrentRun.DeathDefianceDamageBoonEligible and GameState.MetaUpgradeState and GameState.MetaUpgradeState.LastStand and GameState.MetaUpgradeState.LastStand.Equipped then
			CurrentRun.DeathDefianceDamageBoonEligible = true
		end
		local eligibleTraits = {}
		for i, traitName in pairs( UnitSetData.NPC_Hades.NPC_Hades_Field_01.Traits ) do
			if IsTraitEligible( TraitData[traitName] ) then
				table.insert( eligibleTraits, traitName )
			end
		end
		local traitName = GetRandomArrayValue( eligibleTraits )
		
		local newTrait  = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
		newTrait.GrantedTrait = true
		AddTraitToHero({ TraitData = newTrait, SkipUIUpdate = true })
		UpdateHeroTraitDictionary()
		if newTrait then
			thread( HadesKeepsakeAcquiredPresentation, newTrait.Name )
		end
	end
end

function MeldBlessing( args, traitData )
	local blessingData = traitData.ChaosData
	blessingData.Hidden = true
	local newTrait = AddTraitToHero({ TraitData = blessingData })
	traitData.AttachedChaosBoonId = newTrait.Id
end

function DestroyMeldedBlessing( args, traitData )
	if traitData and traitData.AttachedChaosBoonId then
		for k, oldTrait in pairs( CurrentRun.Hero.Traits ) do
			if oldTrait.Id == traitData.AttachedChaosBoonId then
				RemoveTraitData( CurrentRun.Hero, oldTrait, args )
				return
			end
		end
	end
end

function DionysusSkipTrait( args, traitData )
	if not CurrentRun.Hero.IsDead then
		local newTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = "PersistentDionysusSkipKeepsake", Rarity = traitData.Rarity })
		newTrait.RemainingUses = args.RemainingUses
		newTrait.SkipEncounterChance = args.SkipEncounterChance
		AddTraitToHero({ TraitData = newTrait, SkipUIUpdate = true })
	end
end

function CacheCurrentLifestealUses( unit, args)
	-- This is to catch an unfortunate edge case in our caching
	if not HeroHasTrait("HadesLifestealBoon") then
		UpdateHeroTraitDictionary()
	end
	for i, modifierData in pairs( unit.OutgoingLifestealModifiers ) do
		if modifierData.LimitedUse then
			CurrentRun.LifestealUses = modifierData.LimitedUse
			local trait = GetHeroTrait("HadesLifestealBoon")
			if trait ~= nil then
				trait.RemainingUses = CurrentRun.LifestealUses
				UpdateTraitNumber( trait )
			end
			return
		end
	end
	if not CurrentRun.LifestealUses then
		local trait = GetHeroTrait("HadesLifestealBoon")
		if trait ~= nil then
			trait.RemainingUses = CurrentRun.LifestealUses
			CurrentRun.LifestealUses = trait.AddOutgoingDamageModifier.LimitedUse
			UpdateTraitNumber( trait )
		end
	end
end



function SetupHadesCast( unit, args )
	SwapWeapon({ Name = "WeaponCast", SwapWeaponName = "WeaponCastProjectileHades", DestinationId = unit.ObjectId, StompOriginalWeapon = true })
end

function AttachCastAtLocation( triggerArgs )
	if triggerArgs.LocationX and triggerArgs.LocationY then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		if triggerArgs.triggeredById and ActiveEnemies[triggerArgs.triggeredById] and not ActiveEnemies[triggerArgs.triggeredById].SkipModifiers then
			FireWeaponFromUnit({ Weapon = "WeaponCast", Id = CurrentRun.Hero.ObjectId, DestinationId = triggerArgs.triggeredById, FireFromTarget = true, Angle = fireAngle })
		else
			FireWeaponFromUnit({ Weapon = "WeaponCast", Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
		end
		Destroy({ Id = dropLocation })
	end 		
end

function HadesInvisibilitySetup( hero, args )
	ResetCooldown( "HadesRetaliate" )
	local attackTrait = GetExistingUITraitName( "HadesInvisibilityRetaliateBoon" )
	if attackTrait then
		TraitUIActivateTrait( attackTrait )
	end
end

function HadesRetaliate( unit, args, triggerArgs )
	if not CheckCooldown( "HadesRetaliate", args.Cooldown ) then
		return
	end
	if triggerArgs.Victim ~= CurrentRun.Hero then
		return
	end
	local dataProperties = DeepCopyTable( EffectData[args.EffectName].EffectData )
	dataProperties.Duration = args.Duration
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = dataProperties })
	thread( HadesInvisibility )
	
	local traitData = GetHeroTrait("HadesInvisibilityRetaliateBoon")
	local functionArgs = traitData.OnSelfDamagedFunction.FunctionArgs
	if traitData then
		TraitUIActivateTrait( traitData , { FlashOnActive = true, Duration = functionArgs.Cooldown })
	end			
end


function HadesInvisibility()
	SetPlayerNotStopsProjectiles("HadesShout")
	SetPlayerInvulnerable("HadesShout")
	SetPlayerFade({ Flag = "HadesShout", Fraction = 0.4, Duration = 0.3 })
	CurrentRun.Hero.Invisible = true
	CurrentRun.CurrentRoom.InvisTargetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "HadesDisappear_Player", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.6 })
	PlaySound({ Name = "/VO/MelinoeEmotes/EmoteDarkness", Id = CurrentRun.Hero.ObjectId, Delay = 0.25 })

	thread( InCombatText, CurrentRun.Hero.ObjectId, "Invisible_CombatText", 0.85, { SkipFlash = true, PreDelay = RandomFloat(0.1, 0.15), SkipShadow = true } )
	for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
		if not enemy.SkipModifiers and not enemy.IgnoreInvisibility then
			FinishTargetMarker( enemy )

			thread( OnInvisStartPresentation, enemy )
		end
	end

	waitUntil( "StealthBroken" )
	CreateAnimation({ Name = "HadesDisappear_Player", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.6 })

	CurrentRun.Hero.Invisible = false
	SetPlayerStopsProjectiles("HadesShout")
	SetPlayerVulnerable( "HadesShout")
	ClearPlayerFade("HadesShout")

	if CurrentRun.CurrentRoom.InvisTargetId then
		Destroy({ Id = CurrentRun.CurrentRoom.InvisTargetId })
		CurrentRun.CurrentRoom.InvisTargetId = nil
	end
end

function HadesInvisibleClear()
	notifyExistingWaiters("StealthBroken")
end


function CheckManaUrn( traitArgs, manaDelta )
	IncrementTableValue( SessionMapState, "UrnCounter", math.abs(manaDelta))
	if SessionMapState.UrnCounter >= traitArgs.ManaCost then
		if SessionMapState.ManaUrnIds ~= nil then
			for id in pairs(SessionMapState.ManaUrnIds) do
				if ActiveEnemies[id] then
					thread( Kill, ActiveEnemies[id] )
				end
			end
		end
		SessionMapState.ManaUrnIds = {}
		local count = traitArgs.Count or 6
		for i=1, count do
			thread( CreateManaUrn, traitArgs, i )
		end
		SessionMapState.UrnCounter = 0
	end
end

function CreateManaUrn( traitArgs, index )
	local enemyData = EnemyData[ traitArgs.EnemyName ]
		local maxCount = traitArgs.Count or 6
		local range = traitArgs.Range or 400
	local newEnemy = DeepCopyTable( enemyData )
	local offset = CalcOffset( math.rad( GetAngle({ Id = CurrentRun.Hero.ObjectId }) + index * 360/maxCount ), range )
	offset.Y = offset.Y * 0.6
	if not IsLocationBlocked({ Id = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y }) then
		newEnemy.ObjectId = SpawnUnit({
				Name = enemyData.Name,
				Group = "Standing",
				DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, ForceToValidLocation = true })
		thread( SetupUnit, newEnemy, CurrentRun, { SkipPresentation = true } )
		SessionMapState.ManaUrnIds[ newEnemy.ObjectId ] = true
		wait(0.1, RoomThreadName)
	end
end

function CheckUrnDetonation( enemy, args )
	local multiplier = GetTotalHeroTraitValue( "TombstoneMultiplier", {IsMultiplier = true })
	CreateProjectileFromUnit({ Name = args.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, FireFromTarget = true, DamageMultiplier = multiplier })	
end


function UpdateLastMomentManaRestoreEligibility()
	waitUnmodified(0.1) -- We need to let TraitDictionary update before HasTrait will detect this boon
	UpdateWeaponMana()
end

function LastMomentManaRestoreEligible( mana )
	return HeraManaRestoreEligible( mana ) or ClearCastRestoreEligible( mana )
end


function ClearCastRestoreEligible( mana )
	if not HeroHasTrait("PoseidonManaBoon") then
		return false
	end
	if GetHeroMaxAvailableMana() < math.abs(mana) then
		return false
	end
	return MapState.ClearCastPrimed or not IsEmpty(MapState.ClearCastWeapons)
end

function HeraManaRestoreEligible( mana )
	if not HeroHasTrait("HeraManaBoon") then
		return false
	end
	if GetHeroMaxAvailableMana() < math.abs(mana) then
		return false
	end
	
	local traitData = GetHeroTrait("HeraManaBoon")

	return GetHeroMaxAvailableMana() >= traitData.LastMomentManaRechargeArgs.Amount 
end

function CheckHeraManaRestore( args, manaCost )
	manaCost = math.abs(manaCost)
	if CurrentRun.Hero.Mana < manaCost and GetHeroMaxAvailableMana() >= args.Amount then
		ReserveMana( args.Amount, "HeraManaBoon" )
		RefillMana()
		if args.FireSound then
			PlaySound({ Id = CurrentRun.Hero.ObjectId, Name = args.FireSound, ManagerCap = 46 })
		end
		if args.FireText then
			thread( HeraManaRestorePresentation, CurrentRun.Hero.ObjectId, args.FireText )
		end
		if args.FireFx then
			CreateAnimation({ Name = args.FireFx, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
		end
	end
end

function CheckAxeCastArm( triggerArgs, args )
	local intersectionProjectiles = GetInProjectilesBlast({ ProjectileId = triggerArgs.ProjectileId, DestinationName = "ProjectileCast", UseDamageRadius = true })
	if not IsEmpty(intersectionProjectiles) then
		local projectileId = GetFirstValue(intersectionProjectiles)
		local location = GetLocation({ Id = projectileId, IsProjectile = true })
		local dropLocationId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y})
		CreateAnimation({ Name = "CharonAspectDetonateFx", DestinationId = dropLocationId  }) --nopkg
		for _, projectileId in pairs( intersectionProjectiles) do
			for _, data in pairs( GetHeroTraitValues("OnEarlyCastDetonation")) do
				thread( CallFunctionName, data.FunctionName, projectileId, data.FunctionArgs )
			end
		end
		ArmAndDetonateProjectiles({ Ids = intersectionProjectiles, BlastMultiplier = args.BlastMultiplier, Duration = 0.2, ForceDetonate = true })
		for _, projectileId in pairs( intersectionProjectiles) do	
			SessionState.EarlyDetonationProjectileIds[ projectileId ] = true
			--ExpireProjectiles({ ProjectileIds = { projectileId })
			if not IsEmpty(SessionMapState.CastAttachedProjectiles[projectileId]) then
				ExpireProjectiles({ ProjectileIds = SessionMapState.CastAttachedProjectiles[projectileId] })
			end
		end
		Destroy({ Id = dropLocationId })
	end
end

function CheckPerfectAxeCrit( victim, args, triggerArgs )
	if IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	if triggerArgs.SourceProjectile and ProjectileData[triggerArgs.SourceProjectile] and ProjectileData[triggerArgs.SourceProjectile].IsAdditionalCastProjectile then
		return
	end
	local trait = GetHeroTrait( "AxePerfectCriticalAspect")

	local prevCritChance = round(trait.PerfectCritChance * 100, 1)
	local maxCritChance = round(args.MaxCrit * 100, 1)

	trait.PerfectCritChance = math.min( args.MaxCrit,  trait.PerfectCritChance + args.Increment )

	local currCritChance = round(trait.PerfectCritChance * 100, 1)

	if prevCritChance < maxCritChance and currCritChance == maxCritChance then
		PlaySound({ Name = "/SFX/ThanatosCreepyBellStart", Id = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
	end

	UpdateAxeUI( trait )
end

function ResetPerfectAxeCrit( attacker, args, triggerArgs )
	if triggerArgs.ManuallyTriggered or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 then
		return
	end
	local trait = GetHeroTrait( "AxePerfectCriticalAspect")
	trait.PerfectCritChance = 0

	StopAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = CurrentRun.Hero.ObjectId })

	UpdateAxeUI( trait )
end

function RoomStartResetPerfectDamageBonus()
	SessionMapState.DeactivatePerfectDamageBonus = nil
end

function ResetPerfectDamageBonusBoon( attacker, args, triggerArgs )
	if triggerArgs.ManuallyTriggered or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 then
		return
	end
	
	if SetThreadWait( "PerfectDamageReset", args.Cooldown ) then
		return
	end
	thread( ThreadedPerfectDamageReset, args.Cooldown )
end

function ThreadedPerfectDamageReset( delay )
	if not SessionMapState.DeactivatePerfectDamageBonus then
		PerfectDamageBoonExpire()
	end
	SessionMapState.DeactivatePerfectDamageBonus = true
	waitUnmodified( delay, "PerfectDamageReset" )
	SessionMapState.DeactivatePerfectDamageBonus = nil
	if not CurrentRun.Hero.IsDead then
		PerfectDamageBoonRenewed()
	end
end

function ChargeSkullImpulse( victim, args, triggerArgs )
	if not triggerArgs.DamageAmount or SessionMapState.ActiveSkullImpulse then
		return
	end
	local validProjectile = false
	local validEffect = false
	local validMissingDamage = false
	local damageAmount = triggerArgs.DamageAmount
	
	if triggerArgs.SourceProjectile and not IsEmpty(args.ValidProjectiles) and args.ValidProjectilesLookup[triggerArgs.SourceProjectile] then
		validProjectile = true
	end
	if triggerArgs.EffectName and not IsEmpty(args.ValidEffectNames) and args.ValidEffectNamesLookup[triggerArgs.EffectName] then
		validEffect = true
	end
	
	if triggerArgs.MissingEffectDamagePercent then
		damageAmount = damageAmount * triggerArgs.MissingEffectDamagePercent
		validMissingDamage = true
	end
	if not validProjectile and not validEffect and not validMissingDamage then
		return
	end
	local trait = GetHeroTrait( "LobImpulseAspect")
	local prevCharge = trait.Charge
	trait.Charge = math.min(args.MaxCharge, trait.Charge + damageAmount * args.ChargePerDamage)
	if prevCharge < args.MaxCharge and  trait.Charge >= args.MaxCharge and ScreenAnchors.LobUI then	
		SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = ScreenAnchors.LobUI })
	end
	UpdateLobUI( trait )
end

function CheckSkullImpulseStart()
	if MapState.HostilePolymorph then
		return
	end
	local trait = GetHeroTrait( "LobImpulseAspect")
	if GetUnitProperty({ Id = CurrentRun.Hero.ObjectId, Property = "AllowAnyFire" }) then
		FireWeaponFromUnit({ Weapon = "WeaponSkullImpulse", Id = CurrentRun.Hero.ObjectId }) 
	end
end

function SkullImpulseTransform( weaponData, functionArgs, triggerArgs )
	if weaponData.Name == "WeaponLobSpecial" then
		if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
			waitUnmodified(0.01, RoomThreadName )
			EndBlinkWeapons({ Id = CurrentRun.Hero.ObjectId })
		end
		return
	end
	
	SessionMapState.ActiveSkullImpulse = true
	SetPlayerPhasing("SkullImpulse")
	local trait = GetHeroTrait( "LobImpulseAspect")
	local tickRate = 0.1
	local useCharge = false
	local reserve = functionArgs.BaseDuration or 0
	if trait.Charge >= trait.OnEnemyDamagedAction.Args.MinChargeToFire then
		useCharge = true
	end

	MapState.ThrowWeaponInterval = functionArgs.Interval
	if not MapState.ThrowWeaponInterval or MapState.ThrowWeaponInterval < 1 then
		-- backcompat sanity check
		MapState.ThrowWeaponInterval = 250 
	end
	local currentTime = _worldTimeUnmodified
	
	while reserve > 0 do
		reserve = reserve - (_worldTimeUnmodified  - currentTime)
		currentTime = _worldTimeUnmodified
		waitUnmodified(tickRate)
	end
	if useCharge then
		SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = ScreenAnchors.LobUI })
		while trait.Charge > 0 do
			-- Wait isn't super accurate for this
			trait.Charge = trait.Charge - (_worldTimeUnmodified  - currentTime)
			currentTime = _worldTimeUnmodified
			UpdateLobUI( trait )
			waitUnmodified(tickRate)
		end
	end
	if HeroHasTrait("LobSturdySpecialTrait") then
		EndLobSturdy()
	end
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
	trait.Charge = 0
	UpdateLobUI( trait )
end

OnRamWeaponComplete{ "WeaponSkullImpulse",
	function(triggerArgs) 
		SessionMapState.ActiveSkullImpulse = nil	
		SetPlayerUnphasing("SkullImpulse")
	end
}
function CheckTorchDetonation( triggerArgs, functionArgs )
	if functionArgs[triggerArgs.name] and triggerArgs.LocationX and triggerArgs.LocationY and triggerArgs.Detonated then
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = functionArgs[triggerArgs.name],
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		CreateProjectileFromUnit({ WeaponName = triggerArgs.WeaponName, Name = functionArgs[triggerArgs.name], Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
			DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges})
		Destroy({Id = dropLocation })	
	end
end

function TorchSprintRecall( weaponData, functionArgs, triggerArgs )
	if HeroHasTrait("TorchAutofireAspect") and triggerArgs.name ~= "WeaponBlink" then
		return
	end
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponTorch", Method = "RecallProjectiles" })
end

function HandleAttachRecord( weaponData, functionArgs, triggerArgs )
	if weaponData.Name == "WeaponTorch" and IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) and triggerArgs.ProjectileId then	
		if SessionMapState.CurrentExProjectile then
			ExpireProjectiles({ ProjectileIds = { SessionMapState.CurrentExProjectile }})
		end
		SessionMapState.CurrentExProjectile =  triggerArgs.ProjectileId
		ExpireProjectiles({ ProjectileIds = SessionMapState.CurrentExAttachedProjectiles})
		SessionMapState.CurrentExAttachedProjectiles = {}

		local threadName = "TorchRepeatDetonationThread"
		if HasThread( threadName ) then
			killTaggedThreads( threadName )
			waitUnmodified(0.1)
		end
		thread(StartTorchRepeatDetonationThread, functionArgs, triggerArgs )
	elseif weaponData.Name == "WeaponTorchSpecial" then
		local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
		if  SessionMapState.CurrentExProjectile then
			local weaponName = weaponData.Name
			local projectileName = triggerArgs.ProjectileName
			local isEx = IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
			local derivedValues = GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
				MatchProjectileName = true,
			})
			local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
			local baseAngle = angle
			local offset = 0		
			local cap = nil
			local fizzleOldest = nil

			local repeats = 1
			if not isEx then
				ExpireProjectiles({ ProjectileIds = SessionMapState.CurrentAttachedBaseProjectiles })
			end

			for s=1, repeats do
				for i=1, triggerArgs.NumProjectiles do
					if isEx then
						triggerArgs.NumProjectiles = 2
						angle = 360 / triggerArgs.NumProjectiles * i + offset
						cap = 4
						if HeroHasTrait("TorchExSpecialCountTrait") then
							cap = 6
						end
					else
						if triggerArgs.NumProjectiles > 1 then
							angle = i * ( 360 / triggerArgs.NumProjectiles )
						end
						cap = 3
						if HeroHasTrait("TorchExSpecialCountTrait") then
							cap = 4
						end
					end
					local projectileId = CreateProjectileFromUnit({
						WeaponName = weaponName, 
						Name = projectileName,
						Angle = angle,
						Id = CurrentRun.Hero.ObjectId, 
						ProjectileDestinationId = SessionMapState.CurrentExProjectile, 
						FireFromTarget = true, 
						AttachToTarget = true, 
						DataProperties = derivedValues.PropertyChanges, 
						ThingProperties = derivedValues.ThingPropertyChanges,
						FizzleOldestProjectileCount = cap
						})
						if not isEx  then
							table.insert(SessionMapState.CurrentAttachedBaseProjectiles, projectileId )	
						end
						table.insert(SessionMapState.CurrentExAttachedProjectiles, projectileId )
				end
				offset = offset + 45
			end
		elseif isEx then
			ExpireProjectiles({ Name = "ProjectileTorchOrbitEx" })
		end
	end
end

function StartTorchRepeatDetonationThread( functionArgs, triggerArgs, isRepeat )
	functionArgs = functionArgs or {}
	totalRepeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	local threadName = "TorchRepeatDetonationThread"
	local projectileKey = "CurrentExProjectile"
	if isRepeat then
		threadName = "SecondTorchRepeatDetonationThread"
		projectileKey = "SecondExProjectile"
	end
	
	local weaponName = "WeaponTorch"
	local projectileName = "ProjectileTorchRepeatStrike"
	local repeats = 1
	
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	if HeroHasTrait("DoubleExManaBoon") then
		totalRepeats = totalRepeats * 2
	end
	while repeats <= totalRepeats do
		if repeats == 1 then
			waitUnmodified(functionArgs.StartInterval or functionArgs.Interval, threadName )
		else
			if HeroHasTrait("DoubleExManaBoon") and repeats % 2 == 0 then
				waitUnmodified(0.2, threadName)
			else
				waitUnmodified(functionArgs.Interval, threadName )
			end
		end
		if SessionMapState[projectileKey] then
			local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, ProjectileDestinationId = SessionMapState[projectileKey], FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
			if SessionMapState.DifferentOmegaVolleys[weaponName] and SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
				SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
				SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
			end		
		else
			return
		end
		repeats = repeats + 1
	end
	ExpireProjectiles({ ProjectileIds = { SessionMapState[projectileKey] }})
end

function RemoveAttachedExProjectiles( triggerArgs )
	if triggerArgs.ProjectileId == SessionMapState.CurrentExProjectile then
		SessionMapState.CurrentExProjectile = nil
		ExpireProjectiles({ ProjectileIds = SessionMapState.CurrentExAttachedProjectiles})
		SessionMapState.CurrentExAttachedProjectiles = {}
	end
end

function GetTorchSplitProjectileCap()
	if GetProjectileCount({ Names = {"ProjectileTorchOrbit", "AphroditeBurst", "ProjectileTorchOrbitEx "}}) >= 4 then
		return 2
	end
	return 5
end

function RecordSecondStageApolloCast(victim, functionArgs, triggerArgs )
	if not SessionMapState.ValidSuperchargeCastIds[triggerArgs.ProjectileId] or ( functionArgs.RequiredTrait and not HeroHasTrait( functionArgs.RequiredTrait )) then
		return
	end
	thread( CreateZeusBolt, {
		TargetId = victim.ObjectId,
		WeaponName = "WeaponCast",
		ProjectileName = functionArgs.ProjectileName, 
		DamageMultiplier = functionArgs.DamageMultiplier,
		InitialDelay = 0,
		Delay = 0.1 })
end

function CheckArmedApolloCast( triggerArgs, functionArgs )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end

	if triggerArgs.name == functionArgs.ValidProjectileName and triggerArgs.Armed and triggerArgs.LocationX and triggerArgs.LocationY and triggerArgs.Detonated then
		if SessionMapState.InvalidRepeatCastIds[triggerArgs.ProjectileId] then
			return
		end
		local modifier = GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "BlastRadiusModifier" })
		
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = functionArgs.ProjectileName,
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = true,
		})
		local projectileId = CreateProjectileFromUnit({ Name = functionArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true,
			BlastRadiusModifier = modifier, DamageMultiplier = functionArgs.DamageMultiplier, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
		if triggerArgs.ProjectileId and SessionMapState.MarkedEnemies[triggerArgs.ProjectileId] then
			SessionMapState.MarkedEnemies[projectileId] = DeepCopyTable(SessionMapState.MarkedEnemies[triggerArgs.ProjectileId])
			SessionMapState.MarkedEnemies[triggerArgs.ProjectileId] = nil
		end
		if HeroHasTrait("ApolloExCastBoon") and HeroHasTrait("ApolloSecondStageCastBoon") and ( SessionMapState.SuperchargeCast or ( HeroHasTrait("TransformExCastTalent") and not IsEmpty(MapState.TransformArgs)))then
			SessionMapState.ValidSuperchargeCastIds[ projectileId ] = true
			SessionMapState.SuperchargeCast = nil
		end
		Destroy({Id = dropLocation })	
	end
end

function CheckApolloManaRestore( triggerArgs, functionArgs )
	if triggerArgs.name == "ProjectileCast" and CurrentRun.Hero then
		ManaDelta( functionArgs.ManaRestore )
		CreateAnimation({ Name = functionArgs.ManaRestoreFx, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function MultiplySameRoomRewards( args, trait )
	for id, data in pairs( MapState.RoomRequiredObjects ) do
		if data.Name == args.Name and data.AddMaxHealth then
			MapState.RoomRequiredObjects[id].AddMaxHealth = round( data.AddMaxHealth * trait.HealthRewardBonus )
		end
	end
end

function CheckSprintCollision( weaponData, functionArgs, triggerArgs )
	local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, StopsProjectiles = true, IgnoreHomingIneligible = true, Distance = functionArgs.Range, ScaleY = 0.6, PreciseCollision = true })		
	for _, enemyId in ipairs( nearestEnemyTargetIds ) do
		local victim = ActiveEnemies[enemyId]
		if victim ~= nil and not victim.IsDead and MapState.ChargedManaWeapons[weaponData.Name] then
			local stageData = GetWeaponChargeStages( weaponData )[1]
			killTaggedThreads(weaponData.Name.."IndicatorFire")
			killTaggedThreads("ManaChargeComplete")
			ClearManaChargeIndicator( weaponData.Name )
			MapState.ChargedManaWeapons[weaponData.Name] = nil
			ManaDelta( -GetManaCost( weaponData, false, { ManaCostOverride = stageData.ManaCost } ))
			MapState.EquippedWeapons.WeaponSprintEx = true
			FireWeaponFromUnit({ Weapon = "WeaponSprintEx", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true })
				
			thread( NyxBuffReadyEndPresentation )
			if functionArgs.ClearEffectName then
				ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = functionArgs.ClearEffectName })
			end
		end
	end
end

function SplitSelfBuff( victim, functionArgs, triggerArgs )
	local effectName = functionArgs.EffectName
	local dataProperties = ShallowCopyTable(EffectData[effectName].DataProperties)
	dataProperties.Duration = functionArgs.Duration
	ApplyEffect({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })	
end

function NyxHitBuffApply(triggerArgs )
	if ScreenAnchors.SuitUI and ScreenAnchors.SuitUIChargeAmount then
		thread( NyxBuffStartPresentation, triggerArgs.Reapplied, triggerArgs.Duration )
	end
end

function NyxHitBuffClear()
	if ScreenAnchors.SuitUI then
		thread( NyxBuffEndPresentation )
	end
end

function CheckSplitValidity( triggerArgs, functionArgs )

	if functionArgs.RequiredEffect and not CurrentRun.Hero.ActiveEffects[functionArgs.RequiredEffect] then
		return
	end
	if functionArgs.RequireArmedCast and ( not SessionMapState.LastCastProjectileId or not GetProjectileProperty({ ProjectileId = SessionMapState.LastCastProjectileId, Property = "Armed" })) then
		return
	end
	SessionMapState.ValidSplitIds[ triggerArgs.ProjectileId ] = true
end

function CheckProjectileSpawn( triggerArgs, functionArgs )
	if triggerArgs.BlockSpawns or ( not functionArgs.IgnoreAdvancedSplitValidity and (not SessionMapState.ValidSplitIds[triggerArgs.ProjectileId] or SessionMapState.InvalidSplitIds[triggerArgs.ProjectileId])) then
		SessionMapState.InvalidSplitIds[triggerArgs.ProjectileId] = nil
		return
	end
	functionArgs = functionArgs or {}
	SessionMapState.ValidSplitIds[triggerArgs.ProjectileId] = nil
	local damageMultiplier = functionArgs.DamageMultiplier or 1
	local spawnCount = functionArgs.SpawnCount or 1
	local matchProjectileName = true
	if functionArgs.MatchProjectileName ~= null then
		matchProjectileName = functionArgs.MatchProjectileName 
	end
	if triggerArgs.LocationX and triggerArgs.LocationY then
		
		local angle = triggerArgs.Angle
		local projectileName = functionArgs.ProjectileName
		local propertyChangeProjectileName = projectileName
		if not projectileName and functionArgs.ProjectileNameMap and functionArgs.ProjectileNameMap[ triggerArgs.name ] then
			projectileName =  functionArgs.ProjectileNameMap[ triggerArgs.name ]
		end
		if functionArgs.ProjectileNameMapIgnores and functionArgs.ProjectileNameMapIgnores[ triggerArgs.name ] and HeroHasTrait(functionArgs.ProjectileNameMapIgnores[ triggerArgs.name ]) then
			return
		end
		if functionArgs.UseOriginalProjectileForPropertyChanges then
			propertyChangeProjectileName = triggerArgs.name
		else
			propertyChangeProjectileName = projectileName
		end
		local offset = { X = 0, Y = 0 }
		if functionArgs.ProjectileOffsets and functionArgs.ProjectileOffsets[  triggerArgs.name  ] then
			offset = CalcOffset( math.rad(angle), functionArgs.ProjectileOffsets[  triggerArgs.name  ])
		end
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX + offset.X, LocationY = triggerArgs.LocationY + offset.Y })
		local derivedValues = GetDerivedPropertyChangeValues({
			ProjectileName = propertyChangeProjectileName,
			WeaponName = triggerArgs.WeaponName ,
			Type = "Projectile",
			MatchProjectileName = matchProjectileName,
		})
		if functionArgs.TraitDependentProperties then
			for traitName, data in pairs( functionArgs.TraitDependentProperties ) do
				if HeroHasTrait( traitName ) then
					derivedValues.PropertyChanges = MergeTables( derivedValues.PropertyChanges, data )
				end
			end
		end
		local impactIgnore = nil
		if functionArgs.IgnoreImpactId then
			impactIgnore = triggerArgs.triggeredById
		end
		local angleIncrement = 0
		if spawnCount > 1 then
			if functionArgs.SpawnArc then
				angle = angle - functionArgs.SpawnArc /2 
			end
			angleIncrement = functionArgs.SpawnArc / ( spawnCount - 1 )
		end
		if triggerArgs.ProjectileId then
			damageMultiplier = damageMultiplier * GetProjectileProperty({ ProjectileId = triggerArgs.ProjectileId, Property = "DamageMultiplier"})
		end
		local attachAnim = nil
		if functionArgs.ProjectileVfx and functionArgs.ProjectileVfx[triggerArgs.name] then
			attachAnim = functionArgs.ProjectileVfx[triggerArgs.name]
		end
		local targetIdOverride = nil
		if projectileName == "ProjectileSuitRangedGuidedSplit" and functionArgs.RetargetChance then
			if RandomChance( functionArgs.RetargetChance ) then
				targetIdOverride = SessionMapState.ExistingMissileTargetIds[ triggerArgs.ProjectileId ]
			else
				local weaponData = GetWeaponData(CurrentRun.Hero, "WeaponSuitRanged")
				targetIdOverride =  GetClosest(
					{ 
						Id = CurrentRun.Hero.ObjectId, 
						DestinationName = "EnemyTeam", 
						IgnoreInvulnerable = true, 
						IgnoreHomingIneligible = true, 
						IgnoreSelf = true, 
						ExcludeId = SessionMapState.ExistingMissileTargetIds[ triggerArgs.ProjectileId ],
						Distance = weaponData.Range,
						YScale = weaponData.SeekScaleY,
					})
			end
		end
		local fizzleOldest = nil
		if functionArgs.ProjectileCapFunctionName then
			fizzleOldest = CallFunctionName( functionArgs.ProjectileCapFunctionName )
		end
		for i = 1, spawnCount do
			CreateProjectileFromUnit({ 
				WeaponName = triggerArgs.WeaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, 
				DamageMultiplier = damageMultiplier, DataProperties = derivedValues.PropertyChanges, TargetIdOverride = targetIdOverride, ThingProperties = derivedValues.ThingPropertyChanges,
				ImpactIgnoresFromId = triggerArgs.ProjectileId, FizzleOldestProjectileCount = fizzleOldest,
				Angle = angle + (i - 1) * angleIncrement, Alpha = functionArgs.Alpha, AttachAnimation = attachAnim})
		end
		SessionMapState.ExistingMissileTargetIds[ triggerArgs.ProjectileId ] = nil
	
		Destroy({Id = dropLocation })	
	end
end

function CheckManaBurst( traitArgs, manaDelta )
	IncrementTableValue( SessionMapState, "BurstCounter", math.abs(manaDelta))
	if SessionMapState.BurstCounter >= traitArgs.ManaCost then
		local totalBursts = 1 + GetTotalHeroTraitValue("BurstCount") 	
		thread(CreateManaBurst, traitArgs, 1 + GetTotalHeroTraitValue("BurstCount")  )
		SessionMapState.BurstCounter = 0
	end
end

function QueueManaBurst( triggerArgs, traitArgs )
	thread(CreateManaBurst, traitArgs, 1 + GetTotalHeroTraitValue("BurstCount")  )
end

function CreateManaBurst( traitArgs, totalBursts )
	waitUnmodified( traitArgs.StartDelay, "ManaBurstDelay" )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	for i = 1, totalBursts do
		CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId,
			DamageMultiplier = traitArgs.DamageMultiplier, Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }) + 180 + i * 360/totalBursts, FizzleOldestProjectileCount = 6 })
	end
end

function AddTalentPoints( args, traitData)
	IncrementTableValue( CurrentRun, "NumTalentPoints", args.Count )
end
function RemoveLeapCritVolley(triggerArgs)
	waitUnmodified(0.1)
	if triggerArgs.WeaponName and SessionMapState.LeapCritProjectileIds and SessionMapState.LeapCritProjectileIds[triggerArgs.WeaponName] and triggerArgs.ProjectileId then
		SessionMapState.LeapCritProjectileIds[triggerArgs.WeaponName][triggerArgs.ProjectileId] = nil
	end
	if triggerArgs.WeaponName and SessionMapState.LeapCritVolleys and SessionMapState.LeapCritVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( SessionMapState.LeapCritVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if SessionMapState.LeapCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			SessionMapState.LeapCritVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckLeapCritCharges( weaponData, functionArgs, triggerArgs )
	if MapState.LeapCritCharges and MapState.LeapCritCharges >= 1 and triggerArgs.ProjectileVolley and triggerArgs.NumProjectiles then
	
		if weaponData.Name == "WeaponSuitRanged" and not HeroHasTrait("SuitComboAspect") then
			SessionMapState.LeapCritVolleys[weaponData.Name] = SessionMapState.LeapCritVolleys[weaponData.Name] or {}
			if not IsEmpty(SessionMapState.TargetedEnemies) then
				IncrementTableValue(SessionMapState.LeapCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, TableLength(SessionMapState.TargetedEnemies) * 2 )
			else
				IncrementTableValue(SessionMapState.LeapCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, 4 )
			end
		else
			SessionMapState.LeapCritVolleys[weaponData.Name] = SessionMapState.LeapCritVolleys[weaponData.Name] or {}
			IncrementTableValue(SessionMapState.LeapCritVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		end
		MapState.LeapCritCharges = MapState.LeapCritCharges - 1

		if MapState.LeapCritCharges <= 0 then
			local traitData = GetHeroTrait("LeapCritTalent")
			if traitData.LeapCritVfx then
				StopAnimation({ Name = traitData.LeapCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
end

function RemoveOmegaCritVolley(triggerArgs)
	waitUnmodified(0.1)
	if triggerArgs.WeaponName and SessionMapState.DifferentOmegaProjectileIds and SessionMapState.DifferentOmegaProjectileIds[triggerArgs.WeaponName] and triggerArgs.ProjectileId then
		SessionMapState.DifferentOmegaProjectileIds[triggerArgs.WeaponName][triggerArgs.ProjectileId] = nil
	end
	if triggerArgs.WeaponName and SessionMapState.DifferentOmegaVolleys and SessionMapState.DifferentOmegaVolleys[triggerArgs.WeaponName] then
		DecrementTableValue( SessionMapState.DifferentOmegaVolleys[triggerArgs.WeaponName], triggerArgs.ProjectileVolley )
		if SessionMapState.DifferentOmegaVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] <= 0 then
			SessionMapState.DifferentOmegaVolleys[triggerArgs.WeaponName][triggerArgs.ProjectileVolley] = nil
		end
	end
end

function CheckDifferentOmegaCrit( weaponData, functionArgs, triggerArgs )
	if not IsExWeapon( weaponData.Name, {Combat = true}, triggerArgs ) or triggerArgs.ManuallyTriggered then
		return
	end
	local weaponName = weaponData.Name
	if weaponName == "WeaponSprintEx" then
		weaponName = "WeaponSprint"
	end
	if SessionMapState.LastExMove and SessionMapState.LastExMove ~= weaponName then
		if weaponData.Name == "WeaponCastArm" then
			if SessionMapState.LastCastProjectileVolley then
				SessionMapState.DifferentOmegaVolleys.WeaponCast = SessionMapState.DifferentOmegaVolleys.WeaponCast or {}
				IncrementTableValue(SessionMapState.DifferentOmegaVolleys.WeaponCast, SessionMapState.LastCastProjectileVolley, 1 )
			end
		elseif weaponData.Name == "WeaponSuitRanged" and not HeroHasTrait("SuitComboAspect") then
			SessionMapState.DifferentOmegaVolleys[weaponData.Name] = SessionMapState.DifferentOmegaVolleys[weaponData.Name] or {}
			IncrementTableValue(SessionMapState.DifferentOmegaVolleys[weaponData.Name], triggerArgs.ProjectileVolley, TableLength(SessionMapState.TargetedEnemies) * 2 )
		else
			SessionMapState.DifferentOmegaVolleys[weaponData.Name] = SessionMapState.DifferentOmegaVolleys[weaponData.Name] or {}
			IncrementTableValue(SessionMapState.DifferentOmegaVolleys[weaponData.Name], triggerArgs.ProjectileVolley, triggerArgs.NumProjectiles )
		end
	end
	if weaponData.Name == "WeaponSprintEx" then
		SessionMapState.LastExMove = "WeaponSprint"
	else
		SessionMapState.LastExMove = weaponData.Name
	end
end

function TimedBuffSetup( hero, args )
	local traitData = GetHeroTrait("TimedBuffKeepsake")
	if hero.IsDead or ( traitData.CurrentTime and traitData.CurrentTime <= 0 ) then
		return
	end
	local totalSpeedChange = args.Multiplier or 1
	if totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier * totalSpeedChange
		local allPropertyChanges= {}
		if not MapState.KeepsakeSpeedPropertyChanges then
			local speedPropertyChange = 		
			{
				WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
				ChangeValue = totalSpeedChange,
				SpeedPropertyChanges = true,
			}
			for q, weaponName in pairs(speedPropertyChange.WeaponNames) do
					
				local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
				if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
					newPropertyChanges = DeepCopyTable( WeaponData[weaponName].SpeedPropertyChanges)
				end
				for s, newPropertyChange in pairs(newPropertyChanges) do
					newPropertyChange = MergeTables( newPropertyChange, speedPropertyChange )
					newPropertyChange.WeaponNames = nil
					newPropertyChange.WeaponName = weaponName
					newPropertyChange.ChangeType = "Multiply"
					if newPropertyChange.InvertSource then
						if newPropertyChange.ChangeValue then
							newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
						end
					end
					newPropertyChange.SpeedPropertyChanges = nil
					table.insert(allPropertyChanges, newPropertyChange )
				end
			end
			allPropertyChanges = ConcatTableValues(allPropertyChanges, 
			{
				{
					UnitProperty = "Speed",
					ChangeType = "Multiply",
					ChangeValue = 1/totalSpeedChange,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocity",
					ChangeValue = 1/totalSpeedChange,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
				{
					WeaponNames = { "WeaponSprint" },
					WeaponProperty = "SelfVelocityCap",
					ChangeValue = 1/totalSpeedChange,
					ChangeType = "Multiply",
					ExcludeLinked = true,
				},
			} )
			MapState.KeepsakeSpeedPropertyChanges = allPropertyChanges
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.KeepsakeSpeedPropertyChanges )
	end
end

function EndTimedBuff( traitData )
	if not traitData or not traitData.SetupFunction or not traitData.SetupFunction.Args then
		return
	end
	local totalSpeedChange = traitData.SetupFunction.Args.Multiplier or 1
	if not IsEmpty(MapState.KeepsakeSpeedPropertyChanges) and totalSpeedChange ~= 1 then
		SessionMapState.MapSpeedMultiplier = SessionMapState.MapSpeedMultiplier / totalSpeedChange
		ApplyUnitPropertyChanges( CurrentRun.Hero, MapState.KeepsakeSpeedPropertyChanges, true, true)
	end
end

function CheckLobDetonate( victim, args, triggerArgs)
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "WeaponLob", Method = "ArmProjectiles" })
end

function MarkRandomNearby( victim, args )
	ClearEffect({ Id = victim.ObjectId, Name = "ArtemisBoonHuntersMark" })
	local effectName = "ArtemisBoonHuntersMark"
	local range = args.Range or 800
	local nearbyTargetIds = GetClosestIds({ Id = victim.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true, Distance = range })
	local eligibleTargets = {}
	for _, id in pairs(nearbyTargetIds) do
		if ActiveEnemies[id] and not ActiveEnemies[id].IsDead and not ActiveEnemies[id].SkipModifiers and not IsUntargetable({ Id = id }) and not ActiveEnemies[id].BlockCritMark and not (ActiveEnemies[id].ActiveEffects and ActiveEnemies[id].ActiveEffects.RavenFamiliarMark) then
			table.insert(eligibleTargets, id )
		end
	end
	if not IsEmpty(eligibleTargets) then
		local nearbyTargetId = GetRandomValue(eligibleTargets)
		ApplyEffect({ 
			DestinationId = nearbyTargetId, 
			Id = CurrentRun.Hero.ObjectId, 
			EffectName = effectName, 
			DataProperties = EffectData[effectName].EffectData
		})
	end
end

function PeriodicMark( hero, args )
	wait( args.StartDelay or 0 , RoomThreadName )
	local effectName = "ArtemisBoonHuntersMark"
	while CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.Hero ~= nil and not CurrentRun.Hero.IsDead do
		if (IsCombatEncounterActive(CurrentRun) or (not IsEmpty(ActiveEnemies) and (not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.DelayedStart ))) then
			local eligibleTargets = {}
			for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
				if not enemy.IsDead and not enemy.SkipModifiers and not enemy.AlwaysTraitor and not IsUntargetable({ Id = id }) and not ActiveEnemies[id].BlockCritMark and not (enemy.ActiveEffects and enemy.ActiveEffects.RavenFamiliarMark) then
					table.insert(eligibleTargets, id )
				end
			end
			if not IsEmpty( eligibleTargets ) then
				local enemyId = GetRandomValue( eligibleTargets )
				ApplyEffect({ 
						DestinationId = enemyId, 
						Id = CurrentRun.Hero.ObjectId, 
						EffectName = effectName, 
						DataProperties = EffectData[effectName].EffectData
					})
				wait( args.Interval * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true }), RoomThreadName )
			else
				wait( 0.1, RoomThreadName )
			end
		else
			wait( 0.1, RoomThreadName )
		end
	end
end

function CheckManaSpear( traitArgs, manaDelta )
	IncrementTableValue( SessionMapState, "SpearCounter", math.abs(manaDelta))
	if SessionMapState.SpearCounter >= traitArgs.ManaCost then
		local totalBursts = 1 + GetTotalHeroTraitValue("BurstCount")
	FireWeaponWithinRange({
		SourceId = CurrentRun.Hero.ObjectId,
		Targets = traitArgs.TargetCount,
		TargetDelay = 0.15,
		Range = traitArgs.Range,
		SeekTarget = true,
		ProjectileName = traitArgs.ProjectileName, 
		DamageMultiplier = traitArgs.DamageMultiplier, })
		SessionMapState.SpearCounter = 0
	end
end
function CheckIndirectCastAthenaDeflect( weaponData, traitArgs, triggerArgs)
	if not HeroHasTrait("InvulnerabilityCastBoon") then
		return
	end
	if not ( HeroHasTrait("CastProjectileBoon") or HeroHasTrait("CastAnywhereBoon") or HeroHasTrait("HadesCastProjectileBoon") or HeroHasTrait("CastLobBoon")) then
		return
	end
	
	local traitData = GetHeroTrait("InvulnerabilityCastBoon")
	local args = ShallowCopyTable(traitData.OnWeaponChargeFunctions.FunctionArgs)
	args.Force = true
	AthenaDeflect( weaponData, args, triggerArgs )
end

function AthenaDeflect( weaponData, traitArgs, triggerArgs )
	if not traitArgs.Force and ( traitArgs.IsCast and (HeroHasTrait("CastProjectileBoon") or HeroHasTrait("CastAnywhereBoon") or HeroHasTrait("HadesCastProjectileBoon") or HeroHasTrait("CastLobBoon"))) then
		return
	end
	if traitArgs.Cooldown and not CheckCooldown("AthenaCooldown", traitArgs.Cooldown) then
		return
	end
	if traitArgs.ProjectileName then

		CreateProjectileFromUnit({
				Name = traitArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }),
				DamageMultiplier = traitArgs.DamageMultiplier,
			})
	end
	for _, name in pairs(traitArgs.EffectNames) do
		local effectName = name
		local dataProperties = EffectData[effectName].DataProperties
		dataProperties.Duration = traitArgs.Duration
		ApplyEffect( { DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = effectName, DataProperties = dataProperties })
	end
end

function AthenaInvulnerabilitySetup( hero, args )
	ResetCooldown( "AthenaInvulnerability" .. hero.ObjectId )
	local attackTrait = GetExistingUITraitName( "RetaliateInvulnerabilityBoon" )
	if attackTrait then
		TraitUIActivateTrait( attackTrait )
	end
end

function AthenaRetaliate( unit, args, triggerArgs )
	if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		return
	end
	local victim = triggerArgs.Victim
	if not victim or not victim.Health or victim.Health < 0 or victim.IsDead then
		return
	end
	
	if triggerArgs.ManuallyTriggered or (triggerArgs.DamageAmount and triggerArgs.DamageAmount <= 0 ) then
		return
	end
	local cooldownName = "AthenaInvulnerability" .. victim.ObjectId 
	local cooldown = args.Cooldown * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
	if not CheckCooldown( cooldownName, cooldown ) then
		return
	end
	local dataProperties = ShallowCopyTable( EffectData[args.EffectName].DataProperties )
	dataProperties.Duration = args.Duration
	ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = dataProperties })
	
	local traitData = GetHeroTrait("RetaliateInvulnerabilityBoon")
	if traitData then
		local functionArgs = traitData.OnSelfDamagedFunction.FunctionArgs
		TraitUIActivateTrait( traitData , { FlashOnActive = true, Duration = cooldown })
	end			
end

function CheckAthenaProjectile( weaponData, functionArgs, triggerArgs )
	local cooldown = functionArgs.Cooldown or 0.1667
	cooldown = cooldown * GetTotalHeroTraitValue("OlympianRechargeMultiplier", { IsMultiplier = true })
	if CheckCooldown("AthenaProjectile", cooldown ) then
		CreateProjectileFromUnit({
				Name = functionArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId,
				Angle = GetAngle({ Id = CurrentRun.Hero.ObjectId }),
				DamageMultiplier = functionArgs.DamageMultiplier,
				ProjectileCap = functionArgs.ProjectileCap,
			})
			
		local traitData = GetHeroTrait("AthenaProjectileBoon")
		local functionArgs = traitData.OnWeaponFiredFunctions.FunctionArgs
		if traitData then
			TraitUIActivateTrait( traitData , { FlashOnActive = true, Duration = cooldown})
		end		
	end
end

function AthenaRefillLastStands( args )
	if not CurrentRun.Hero.MaxLastStands then
		return	
	end
	args = args or {}
	local numLastStands = CurrentRun.Hero.MaxLastStands - TableLength( CurrentRun.Hero.LastStands )
	local hadLastStands = HasLastStand( CurrentRun.Hero )
	if numLastStands > 0 then
		local currentFraction = 0.4
		while numLastStands > 0 do
			AddLastStand({
				Name = "Echo",
				Icon = "ExtraLifeAthena",
				ManaFraction = currentFraction,
				HealFraction = currentFraction,
				Silent = true,
			})
			numLastStands = numLastStands - 1
		end
		
		if not hadLastStands then
			thread( LowHealthBonusBuffStatePresentation, 0.5 )
		end
		RecreateLifePips()
	end
end

function PoseidonAttackPunish( unit, functionArgs )
	if not unit or unit.PlayerTrap or unit.AlwaysTraitor then
		return
	end
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockAggro then
		return
	end

	if unit.DamageType ~= "Neutral" and GetDistance({ Id = unit.ObjectId, DestinationId = CurrentRun.Hero.ObjectId }) < functionArgs.ProximityThreshold then
		local scale = functionArgs.Scale or 1.0
		local graphic = nil
		local count = 1
		for i, data in pairs(GetHeroTraitValues("ConeModifier")) do
			if data.ScaleIncrease then
				scale = scale * data.ScaleIncrease
			end
			if data.MaxScale and scale > data.MaxScale then
				scale = data.MaxScale
			end
			if data.DoubleWaveChance and RandomChance(data.DoubleWaveChance * GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true })) then
				count = count + 1
				graphic = data.DoubleWaveGraphic
			end
		end
		local angle = GetAngleBetween({ DestinationId = unit.ObjectId, Id = CurrentRun.Hero.ObjectId })
		for i=1, count do
			local angle = GetAngleBetween({ DestinationId = unit.ObjectId, Id = CurrentRun.Hero.ObjectId })
			CreateProjectileFromUnit({ 
				Name = functionArgs.ProjectileName, 
				Id = CurrentRun.Hero.ObjectId, 
				Angle = angle, 
				DestinationId = CurrentRun.Hero.ObjectId, 
				DamageMultiplier = functionArgs.DamageMultiplier, 
				ScaleMultiplier = scale,
				FireFromTarget = true,
				DataProperties = 
				{
					StartFx = graphic,
					StartDelay = (i - 1 ) * 0.1
				},
			})
		end
		ApplyForce({ Id = unit.ObjectId, Angle = angle, Speed = functionArgs.Force })
	end
end

function ProjectileExCastPreview( triggerArgs, functionArgs )
	if SessionState.PoseidonExCastTarget[triggerArgs.ProjectileId] then
		return
	end
	local dropLocation = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
	SetThingProperty({ Property = "SortMode", Value = "Isometric", DestinationId = dropLocation })
	local playSpeed = 1
	if ( HeroHasTrait("CastProjectileBoon") or HeroHasTrait("CastAnywhereBoon") or HeroHasTrait("HadesCastProjectileBoon") or HeroHasTrait("CastLobBoon")) then
		-- 2.5 is the base duration with arm time included for the ex cast
		local fuseTime = GetProjectileDataValue({Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponCast", Property = "FuseStart"})
		if not fuseTime or fuseTime <= 0 then
			fuseTime = 2.5
		end
		playSpeed = 2.5/fuseTime
	end
	SetAnimation({ Name = functionArgs.Animation, DestinationId = dropLocation, PlaySpeed = playSpeed})
	SessionState.PoseidonExCastTarget[triggerArgs.ProjectileId] = dropLocation
	if HeroHasTrait("SelfCastBoon") and triggerArgs.ProjectileId ~= SessionMapState.FamiliarCastProjectileId then
		Attach({ Id = dropLocation, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function CheckArmedPoseidonCast( triggerArgs, functionArgs )
	if triggerArgs.name ~= functionArgs.ValidProjectileName then
		return
	end
	ClearEffect({ Ids = GetAllKeys( ActiveEnemies ), Name = "ImpactGrip" })
	if triggerArgs.Armed then
		local dropLocation = SessionState.PoseidonExCastTarget[triggerArgs.ProjectileId]
		if not dropLocation then
			dropLocation = SpawnObstacle({ Name = "BlankObstacle", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY  })
		else
			SessionState.PoseidonExCastTarget[triggerArgs.ProjectileId] = nil
		end
		SetAnimation({ Name = "PoseidonCastBallOut", DestinationId = dropLocation })
		thread( DestroyOnDelay, { dropLocation }, 0.1)
	end
	-- While it's named "ApolloCast" this actually can handle any 'spawn on armed cast expiration' projectile behavior.
	thread(CheckArmedApolloCast, triggerArgs, functionArgs )
end

function PoseidonSprintBall ( weaponData, traitArgs, triggerArgs )
	if not MapState.AttachedBallProjectileId or MapState.AttachedBallProjectileId < 0 then 
		MapState.AttachedBallProjectileId = CreateProjectileFromUnit({ Name = traitArgs.ProjectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, DamageMultiplier = traitArgs.DamageMultiplier, ScaleMultiplier = traitArgs.StartScale })				
		local location = GetLocation({ Id = CurrentRun.Hero.ObjectId })
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y })
		MapState.AttachedStormTargetId = dropLocation
		AttachProjectiles({ Ids = { MapState.AttachedBallProjectileId }, DestinationId = dropLocation })
		SetDamageRadiusMultiplier({ Id = MapState.AttachedBallProjectileId, Fraction = traitArgs.ChargeRadiusMultiplier, Duration = traitArgs.ChargeRadiusTime  })
		SetProjectileScale({ Id = MapState.AttachedBallProjectileId, Fraction = traitArgs.EndScale / traitArgs.StartScale, Duration = traitArgs.ChargeRadiusTime })
		--CreateAnimation({ Name = "PoseidonSprintBallEmitter", DestinationId = MapState.AttachedStormTargetId })
		thread( PoseidonSprintFollow, traitArgs )
	end 
	thread( PoseidonSprintBlastRefresh, { Delay = 0.3, StartTime = _worldTime, ChargeRadiusMultiplier = traitArgs.ChargeRadiusMultiplier, ChargeTime = traitArgs.ChargeRadiusTime, DamageMultiplier = traitArgs.DamageMultiplier })
end

function PoseidonSprintFollow( functionArgs )

	local speed = functionArgs.Speed
	local interval = 0.1
	local startTime = _worldTimeUnmodified
	local startDamageMultiplier = functionArgs.StartingDamageMultiplier or 0.25
	while MapState.AttachedBallProjectileId do
		local playerFacing = GetAngle({ Id = CurrentRun.Hero.ObjectId })
		local offset = CalcOffset( math.rad( playerFacing + 180 ), functionArgs.Offset )
		SetAngle({ ProjectileId = MapState.AttachedBallProjectileId, Angle = math.rad(playerFacing) })
		if GetDistance({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y }) < speed * interval then
			Move({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, Duration = interval })
		else
			Move({ Id = MapState.AttachedStormTargetId, DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, Speed = speed })
		end
		
		local damageLerp = math.min(1, (_worldTimeUnmodified - startTime)/functionArgs.ChargeRadiusTime)
		SetProjectileProperty({ ProjectileId = MapState.AttachedBallProjectileId, Property = "DamageMultiplier", Value = startDamageMultiplier + damageLerp*(functionArgs.DamageMultiplier - startDamageMultiplier) })
		if functionArgs.ChargePushbackForce and functionArgs.ChargePushbackRadius then
			local pushbackLerp = math.min(1, (_worldTimeUnmodified - startTime)/functionArgs.ChargeRadiusTime)
			local pushbackDistance =  functionArgs.ChargePushbackRadius * pushbackLerp * functionArgs.ChargeRadiusMultiplier
			local nearestEnemyTargetIds = GetClosestIds({ Id = MapState.AttachedStormTargetId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = pushbackDistance})
			for i, id in pairs(nearestEnemyTargetIds) do
				ApplyForce({ Id = id, Speed = functionArgs.ChargePushbackForce, Angle = GetAngleBetween({ Id = MapState.AttachedStormTargetId, DestinationId = id }) })
				if functionArgs.ChargePushbackFx then
					CreateAnimation({ Name = functionArgs.ChargePushbackFx, DestinationId = id })
				end
				if functionArgs.ChargePushbackSound then
					PlaySound({ Name = functionArgs.ChargePushbackSound, Id = id, ManagerCap = 46 })
				end
			end
		end
		waitUnmodified(0.1, RoomThreadName )
	end
end

function PoseidonSprintBlastRefresh( args )
	args = args or {}
	if args.Delay then
		if SetThreadWait( "PoseidonSprint", args.Delay ) then
			RefreshProjectile({ Id = MapState.AttachedBallProjectileId })
			return
		end
		wait( args.Delay, "PoseidonSprint" )
	end
end

function PoseidonSprintBlastDetach()
	local traitData = GetHeroTrait("PoseidonSplashSprintBoon")
	local functionArgs = traitData.OnWeaponFiredFunctions.FunctionArgs 
				
	local finalAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	local projectileBallId = MapState.AttachedBallProjectileId 
	local attachedTargetId = MapState.AttachedStormTargetId
	MapState.AttachedBallProjectileId = nil
	MapState.AttachedStormTargetId = nil
	local startTime = _worldTimeUnmodified
	local interval = 0.05
	local currentAngle = GetAngleBetween({ Id = attachedTargetId, DestinationId = CurrentRun.Hero.ObjectId })
	SetProjectileProperty({ ProjectileId = projectileBallId, Property = "CheckUnitImpact", Value = true})
	SetProjectileProperty({ ProjectileId = projectileBallId, Property = "CheckObstacleImpact", Value = true})
	SetProjectileProperty({ ProjectileId = projectileBallId, Property = "Range", Value = 1000})
	
	DetachProjectiles({ Ids = { projectileBallId } })
	thread( PoseidonSprintBallDetachPresentation, attachedTargetId )
	Destroy({ Id = attachedTargetId })

	local endTime = startTime + functionArgs.MaxAdjustTime
	while _worldTimeUnmodified < endTime and math.abs(CalcAngleDifference( finalAngle, currentAngle )) > 1 do
		local difference = CalcAngleDifference( finalAngle, currentAngle)
		difference = Clamp(difference, -functionArgs.AdjustRate*interval, functionArgs.AdjustRate*interval)
		currentAngle = currentAngle + difference
		SetAngle({ ProjectileId = projectileBallId, Angle = math.rad(currentAngle) })
		waitUnmodified(interval, RoomThreadName )
	end
	SetAngle({ ProjectileId = projectileBallId, Angle = math.rad(finalAngle) })
end

function SetupTorchAutofire( hero, args )
	if not CurrentRun.Hero.IsDead or (CurrentHubRoom ~= nil and CurrentHubRoom.AllowEnemyAIActive) then
		SetAnimation({ Name = "Melinoe_Torch_Supay_Idle", DestinationId = CurrentRun.Hero.ObjectId }) --nopkg
		HandleWeaponAnimSwaps()
	end
	thread( TorchPrimaryAutofire, args )
	thread( TorchSpecialAutofire, args )
end

function TorchPrimaryAutofire( args )
	if not CurrentRun.Hero.ObjectId then
		return
	end
	local weaponName = "WeaponTorch"
	local weaponData = GetWeaponData(CurrentRun.Hero, weaponName)
	local projectileName = "ProjectileTorchBall"
	local odd = true
	local count = 1
	local countMax = args.BurstCount
	local range = 1000
	local inactiveRange = 500
	local projectileCap = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ActiveProjectileCap" })
	local doubleChance = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "WeaponTorch", Property = "AdditionalProjectileWaveChance"})
	local threadName = "SupayAttackAutofire"
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	if HasThread(threadName) then
		return
	end
	SessionMapState.TorchPrimaryCacheDirty = nil
	SessionMapState.ElapsedTimeMultiplierIgnores[threadName] = true
	while CurrentRun and CurrentRun.Hero and CurrentRun.Hero.ObjectId and (not CurrentRun.Hero.IsDead or (CurrentHubRoom ~= nil and CurrentHubRoom.AllowEnemyAIActive)) do
		local nearestEnemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true, Distance = range, YScale = yScale })
		local overrideTarget = false
		local pylonId = GetFirstValue(GetIdsByType({ Name = "SoulPylon" }))
		local distanceToEnemy = range
		if nearestEnemyId > 0 then
			distanceToEnemy = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = nearestEnemyId })
		end
		-- Doesn't account for isometry
		if pylonId and pylonId > 0 then
			local distanceToPylon = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = pylonId })
			if distanceToPylon < range and distanceToPylon < distanceToEnemy then
				nearestEnemyId = pylonId
				overrideTarget = true
			end
		end
		if not pylonId and not IsEmpty( CurrentRun.CurrentRoom.HighValueBreakableIds ) then
			local closestUrnId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = CurrentRun.CurrentRoom.HighValueBreakableIds, Distance = distanceToEnemy })
			if closestUrnId > 0 then
				nearestEnemyId = closestUrnId
				overrideTarget = true
			end
		end
		if (IsInputAllowed({}) and not AreScreensActive() and (SessionMapState.EmpoweredEx or (not IsEmpty(MapState.AggroedUnits) and ( MapState.AggroedUnits[nearestEnemyId] or distanceToEnemy < inactiveRange )) or (CurrentHubRoom ~= nil and CurrentHubRoom.AllowEnemyAIActive) or (IsCombatEncounterActive(CurrentRun) or overrideTarget or (not IsEmpty(ActiveEnemies) and (not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.DelayedStart ))))) then
			local currentProjectileName = projectileName
			local currentInterval = args.PrimaryInterval
			if args.PrimaryExIntervalOverride and args.PrimaryExIntervalOverride > 0 and SessionMapState.EmpoweredEx then
				currentInterval = args.PrimaryExIntervalOverride
				if CurrentRun.Hero.ActiveEffects.InsideCastBuff and args.PrimaryCastIntervalMultiplier then
					currentInterval = currentInterval * args.PrimaryCastIntervalMultiplier
				end
			else
				if count < countMax then
					currentInterval = args.FlameStagger
				else
					count = 0

					if SessionMapState.EmpoweredEx and args.PrimaryExIntervalMultiplier then
						currentInterval = currentInterval * args.PrimaryExIntervalMultiplier
					end

					if CurrentRun.Hero.ActiveEffects.InsideCastBuff and args.PrimaryCastIntervalMultiplier then
						currentInterval = currentInterval * args.PrimaryCastIntervalMultiplier
					end

					currentInterval = math.max( currentInterval, args.FlameStagger )
				end
			end

			local baseCooldown = GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = "Cooldown" })
			if SessionState.PropertyChangeList.WeaponChanges[weaponName] and not IsEmpty(SessionState.PropertyChangeList.WeaponChanges[weaponName].Cooldown) then
				local firstEntry = SessionState.PropertyChangeList.WeaponChanges[weaponName].Cooldown[1]
				if firstEntry.ChangeType == "Absolute" then
					baseCooldown = firstEntry.ChangeValue
				end
			end
			local currentCooldown = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Cooldown" })
			currentInterval = currentInterval * currentCooldown/baseCooldown
			if SessionMapState.EmpoweredEx then
				currentProjectileName = "ProjectileTorchSupayBallEx"
				currentInterval = currentInterval * GetTotalHeroTraitValue("AutofireOmegaSpeedMultiplier", {IsMultiplier = true})
			end
			if SessionMapState.TorchPrimaryCacheDirty then
				derivedValues = GetDerivedPropertyChangeValues({
					ProjectileName = currentProjectileName,
					WeaponName = weaponName,
					Type = "Projectile",
				})
				SessionMapState.TorchPrimaryCacheDirty = nil
			end

			local marker = "WeaponHecateL_Rig:flame03_C_joint"
			if odd then
				marker = "WeaponHecateR_Rig:flame03_C_joint"
			end
			local destinationId = nil
			local overrideTargetId = nil
			local persistToTarget = true
			if ActiveEnemies[nearestEnemyId] or overrideTarget then
				destinationId = nearestEnemyId
				if overrideTarget then
					overrideTargetId = nearestEnemyId
					derivedValues.PropertyChanges.MaxAdjustRate = 0
				end
			end
			if destinationId == nil then
				persistToTarget = false
			end
			if HasMarker({ Id = CurrentRun.Hero.ObjectId, Name = marker}) and ( destinationId or SessionMapState.EmpoweredEx ) then
				derivedValues.ThingPropertyChanges.OffsetZ = 0
				local projectileArgs = { 
					WeaponName = weaponName, 
					Name = currentProjectileName, 
					Id = CurrentRun.Hero.ObjectId, 
					DestinationId = destinationId, 
					DataProperties = derivedValues.PropertyChanges, 
					ThingProperties = derivedValues.ThingPropertyChanges,
					DisableEffects = true,
					SpawnFromMarker = marker,
					MarkerPersistsAngleToTarget = persistToTarget,
					TargetIdOverride = overrideTargetId,
					FizzleOldestProjectileCount = projectileCap 
					}
				local projectileId = CreateProjectileFromUnit( projectileArgs )
				if SessionMapState.EmpoweredEx then
					LogTorchAutofireProjectile( projectileId, true )
					if HeroHasTrait("DoubleExManaBoon") then
						projectileArgs.CreateFunctionName = "LogTorchAutofireProjectile"
						thread( CreateProjectileFromUnitDelay, projectileArgs, 0.15 )
					end

					if weaponData.Sounds and weaponData.Sounds.FireStageSounds then
						DoWeaponSounds( weaponData.Sounds.FireStageSounds, CurrentRun.Hero, weaponData )
					end
				elseif RandomChance( doubleChance ) then	
					SessionMapState.DoubleStrikeProjectiles[projectileId] = true
					thread( CreateProjectileFromUnitDelay, projectileArgs, 0.15 )
				end
				
				AutofireLogProjectilesForFireEvent( weaponName, {projectileId})
				odd = not odd
				count = count + 1
				wait( currentInterval, threadName )
			else
				wait( 0.1, threadName )
			end
		else
			wait( 0.1, threadName )
		end
	end
end

function LogTorchAutofireProjectile ( projectileId, skipFireEventLog )
	local weaponName = "WeaponTorch"
	SessionMapState.ExProjectileIds[projectileId] = true
	if SessionMapState.SprintBonusEx then
		SessionMapState.SprintBonusProjectiles[ projectileId ] = true
	end
	if SessionMapState.DifferentOmegaEx then		
		SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		SessionMapState.DifferentOmegaProjectileIds[weaponName][ projectileId ] = true
	end
	if not skipFireEventLog then
		AutofireLogProjectilesForFireEvent( weaponName, {projectileId})
	end
end

function TorchSpecialAutofire( args )
	SessionMapState.TorchOrbitIds = {}
	SessionMapState.TorchExSpecialTriggers = 0
	SessionMapState.TorchExSpecial = nil
	local weaponName = "WeaponTorchSpecial"
	local projectileName = "ProjectileTorchOrbit"
	local lastSpecialCount = 0
	local threadName = "SupaySpecialAutofire"
	if HasThread(threadName) then
		return
	end
	
	SessionMapState.ElapsedTimeMultiplierIgnores[threadName] = true
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	SessionMapState.TorchSpecialCacheDirty = nil
	while CurrentRun and CurrentRun.Hero and CurrentRun.Hero.ObjectId and (not CurrentRun.Hero.IsDead or (CurrentHubRoom ~= nil and CurrentHubRoom.AllowEnemyAIActive)) do
		local currentSpecialCount = 2 + GetTotalHeroTraitValue("TorchSpecialCountIncrease")
		if (lastSpecialCount ~= currentSpecialCount) then
			lastSpecialCount = currentSpecialCount
			if not IsEmpty(SessionMapState.TorchOrbitIds ) then
				ExpireProjectiles({ ProjectileIds = SessionMapState.TorchOrbitIds })
				SessionMapState.TorchOrbitIds = {}
			end
		end
		if not IsInputAllowed({}) or not AreScreensInactiveExcluding({ "TraitTrayScreen", "Codex"}) or SessionMapState.SkyEntranceInProgress or MapState.HostilePolymorph or not IsEmpty( MapState.TransformArgs ) then
			if not IsEmpty(SessionMapState.TorchOrbitIds ) then
				ExpireProjectiles({ ProjectileIds = SessionMapState.TorchOrbitIds })
				ExpireProjectiles({ Names = { "ProjectileTorchOrbitEx" }})
				SessionMapState.TorchOrbitIds = {}
			end
			wait( 0.1, threadName ) 
		elseif IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime and not CurrentRun.CurrentRoom.Encounter.Completed ) or not IsEmpty(MapState.AggroedUnits) or (CurrentHubRoom ~= nil and CurrentHubRoom.AllowEnemyAIActive) then
			if IsEmpty(SessionMapState.TorchOrbitIds) and not SessionMapState.TorchExSpecial then
				thread( PlaySupaySpecialLoop, args.SpecialSounds )
				local count = currentSpecialCount
				local angle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
				if SessionMapState.TorchSpecialCacheDirty then
					derivedValues = GetDerivedPropertyChangeValues({
						ProjectileName = projectileName,
						WeaponName = weaponName,
						Type = "Projectile",
					})
					SessionMapState.TorchSpecialCacheDirty = nil
				end
				for i=1,count do
					local projectileId = CreateProjectileFromUnit({ 
						WeaponName = weaponName, 
						Name = projectileName, 
						Id = CurrentRun.Hero.ObjectId, 
						DestinationId = CurrentRun.Hero.ObjectId, 
						Angle = angle + 360/count * (i-1), 
						DisableEffects = true,
						DataProperties = derivedValues.PropertyChanges, 
						ThingProperties = derivedValues.ThingPropertyChanges, })
					table.insert(SessionMapState.TorchOrbitIds, projectileId )
				end
			elseif not SessionMapState.TorchExSpecial then 
				local baseSpeed = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileTorchOrbit", Property = "Speed" })
				local baseRange = GetBaseDataValue({ Type = "Projectile", Name = "ProjectileTorchOrbit", Property = "Range" })
				
				local derivedValues = GetDerivedPropertyChangeValues({
					ProjectileName = projectileName,
					WeaponName = weaponName,
					Type = "Projectile",
				})
				local speed = derivedValues.PropertyChanges.Speed or baseSpeed
				local range = derivedValues.PropertyChanges.Range or baseRange
				if SessionState.PropertyChangeList.WeaponChanges[weaponName] and not IsEmpty(SessionState.PropertyChangeList.WeaponChanges[weaponName].ChargeTime) then
					local firstEntry = SessionState.PropertyChangeList.WeaponChanges[weaponName].ChargeTime[1]
					if firstEntry.ChangeType == "Absolute" then
						baseCooldown = firstEntry.ChangeValue
					end
				end
				local baseChargeTime = GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = "ChargeTime" })
				local currentChargeTime = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" })
				RefreshProjectile({ Ids = SessionMapState.TorchOrbitIds })
				for _, id in pairs( SessionMapState.TorchOrbitIds ) do
					SetProjectileProperty({ ProjectileId = id, Property = "MaxRange", Value = 0 })
					SetProjectileProperty({ ProjectileId = id, Property = "Range", Value = range })
					SetProjectileProperty({ ProjectileId = id, Property = "Speed", Value = speed * (baseChargeTime / currentChargeTime) })
				end
			end
			wait( args.SpecialRefreshInterval, threadName )
		else
			wait( 0.1, threadName )
		end
	end
end

function AutofireLogProjectilesForFireEvent( weaponName, projectileIds, args )
	args = args or {}
	local clearOnFirstHit = args.ClearOnFirstHit
	local isEx = args.IsEx
	-- Manually done at the moment @alice
	if HeroHasTrait("LeapCritTalent") and MapState.LeapCritCharges and MapState.LeapCritCharges > 0 then
		SessionMapState.LeapCritProjectileIds[weaponName] = SessionMapState.LeapCritProjectileIds[weaponName] or {}
		for _, id in pairs( projectileIds ) do
			SessionMapState.LeapCritProjectileIds[weaponName][id] = true
			if clearOnFirstHit then
				SessionMapState.ClearBonusOnHitProjectileIds[id] = SessionMapState.ClearBonusOnHitProjectileIds[id] or {}
				SessionMapState.ClearBonusOnHitProjectileIds[id].LeapCrit = true
			end
		end
		MapState.LeapCritCharges = MapState.LeapCritCharges - 1
		if MapState.LeapCritCharges <= 0 then
			local traitData = GetHeroTrait("LeapCritTalent")
			if traitData.LeapCritVfx then
				StopAnimation({ Name = traitData.LeapCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
	if HeroHasTrait("PowerDrinkBoon") and SessionMapState.DrinkCritCharges and SessionMapState.DrinkCritCharges > 0 then
		SessionMapState.DrinkCritProjectileIds[weaponName] = SessionMapState.DrinkCritProjectileIds[weaponName] or {}
		for _, id in pairs( projectileIds ) do
			SessionMapState.DrinkCritProjectileIds[weaponName][id] = true
			if clearOnFirstHit then
				SessionMapState.ClearBonusOnHitProjectileIds[id] = SessionMapState.ClearBonusOnHitProjectileIds[id] or {}
				SessionMapState.ClearBonusOnHitProjectileIds[id].PowerDrink = true
			end
		end
		SessionMapState.DrinkCritCharges = SessionMapState.DrinkCritCharges - 1
		if SessionMapState.DrinkCritCharges <= 0 then
			local traitData = GetHeroTrait("PowerDrinkBoon")
			if traitData.DrinkCritVfx then
				StopAnimation({ Name = traitData.DrinkCritVfx, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
end

function PlaySupaySpecialLoop( args, isEx )
	if SessionMapState.SupaySoundId then
		StopSound({ Id = SessionMapState.SupaySoundId, Duration = 0.25 })
	end
	for traitName, soundData in pairs( args ) do
		if HeroHasTrait( traitName ) then
			if isEx then
				SessionMapState.SupaySoundId = PlaySound({ Name = soundData.SpecialExSound, Id = CurrentRun.Hero.ObjectId })
				return
			else
				SessionMapState.SupaySoundId = PlaySound({ Name = soundData.SpecialSound, Id = CurrentRun.Hero.ObjectId })
				return
			end
		end
	end
	if isEx then
		SessionMapState.SupaySoundId = PlaySound({ Name = args.SpecialExSound, Id = CurrentRun.Hero.ObjectId })
	else
		SessionMapState.SupaySoundId = PlaySound({ Name = args.SpecialSound, Id = CurrentRun.Hero.ObjectId })
	end
end
function UpdateProjectileLedger( triggerArgs, functionArgs )
	if triggerArgs.name == "ProjectileTorchOrbit" then
		RemoveValueAndCollapse(SessionMapState.TorchOrbitIds, triggerArgs.ProjectileId )
	elseif triggerArgs.name == "ProjectileTorchOrbitEx" then
		DecrementTableValue(SessionMapState, "TorchExSpecialTriggers" )
		if SessionMapState.TorchExSpecialTriggers <= 0 then
			SessionMapState.TorchExSpecial = nil
			if SessionMapState.SupaySoundId then
				StopSound({ Id = SessionMapState.SupaySoundId, Duration = 0.25 })
			end
		end
	elseif triggerArgs.name == "ProjectileCast" then
		SessionMapState.CastRefreshed = nil
	elseif triggerArgs.name == "ProjectileTorchBall" then
		SessionMapState.ExProjectileIds[triggerArgs.ProjectileId] = nil
	end
end

function EndAutofire()
	ExpireProjectiles({ ProjectileIds = SessionMapState.TorchOrbitIds })
	killTaggedThreads("SupayAttackAutofire")
	killTaggedThreads("SupaySpecialAutofire")
	local weaponData = GetWeaponData( CurrentRun.Hero, "WeaponTorch")
	if not IsEmpty(weaponData.SwapAnimations) then
		for fromAnim, toAnim in pairs( weaponData.SwapAnimations ) do
			if WeaponData.WeaponTorch.SwapAnimations[fromAnim] then
				SwapAnimation({ Name = fromAnim, DestinationName = WeaponData.WeaponTorch.SwapAnimations[fromAnim] })
			else
				SwapAnimation({ Name = fromAnim, Reverse = true})
			end
		end
	end
	StopAnimation({ Name = "SupayEXStart", DestinationId = CurrentRun.Hero.ObjectId, IncludeCreatedAnimations = true, PreventChain = true })
end

function CheckFrenzyCount( victim, functionArgs, triggerArgs )
	if IsEmpty( CurrentRun.Hero.ActiveEffects ) or not CurrentRun.Hero.ActiveEffects.Frenzy then
		local startingCount = MapState.FrenzyHits or 0
		IncrementTableValue( MapState, "FrenzyHits" )
		local requiredCount = 21
		local traitData = GetHeroTrait("AxeRallyAspect")
		if traitData.OnEnemyDamagedAction and traitData.OnEnemyDamagedAction.Args then
			requiredCount = traitData.OnEnemyDamagedAction.Args.RequiredCount or requiredCount
		end
		if ScreenAnchors.AxeUIChargeAmount then
			SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = ScreenAnchors.AxeUIChargeAmount, Fraction = MapState.FrenzyHits / requiredCount, Instant = true })
		end
	end

	if MapState.FrenzyHits >= functionArgs.RequiredCount then
		MapState.FrenzyHits = 0
		local dataProperties = MergeTables(	EffectData[functionArgs.EffectName].DataProperties, functionArgs.DataProperties)
		dataProperties.Duration = dataProperties.Duration + GetTotalHeroTraitValue("FrenzyDurationBonus")
		ApplyEffect( MergeTables({ DestinationId = CurrentRun.Hero.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
	end
end

function ManaRestoreDamage( hero, args )
	SessionMapState.TrackManaRegen = true
	SessionMapState.CumulativeManaRegen = 0
	args = args or {}
	args.ManaThreshold = args.ManaThreshold or 5
	args.MinRadius = args.MinRadius or 0.6
	args.MaxRadius = args.MaxRadius or 1
	args.MaxRadiusThreshold = args.MaxRadiusThreshold or 15

	while CurrentRun and CurrentRun.CurrentRoom and CurrentRun.Hero and not CurrentRun.Hero.IsDead and HeroHasTrait("ManaRestoreDamageBoon") do
		if IsCombatEncounterActive(CurrentRun) or not CurrentRun.CurrentRoom.Encounter or ( CurrentRun.CurrentRoom.Encounter.DelayedStart and CurrentRun.CurrentRoom.Encounter.StartTime and not CurrentRun.CurrentRoom.Encounter.EndTime ) or not IsEmpty(MapState.AggroedUnits) then
			if SessionMapState.CumulativeManaRegen >= args.ManaThreshold and ( not CurrentRun.CurrentRoom.Encounter or not CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
				local damaged = false
				for id, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
					if enemy and 
						((enemy.ActiveEffectsAtDamageStart and enemy.ActiveEffectsAtDamageStart[args.EffectName]) 
						or ( enemy.ActiveEffects and enemy.ActiveEffects[args.EffectName])) and not IsInvulnerable({ Id = enemy.ObjectId }) then
						damaged = true
						CreateProjectileFromUnit({ 
							Name = args.ProjectileName, 
							Id = CurrentRun.Hero.ObjectId, 
							DestinationId = enemy.ObjectId, 
							FireFromTarget = true, 
							DamageMultiplier = SessionMapState.CumulativeManaRegen * args.DamageMultiplier})
					end
				end
				if damaged then
					PlaySound({ Name = "/SFX/Player Sounds/HestiaSpecialLaunch", Id = CurrentRun.Hero.ObjectId })
				end
				SessionMapState.CumulativeManaRegen = 0
				wait( args.Interval )
			else
				wait( 0.1 )
			end
		else
			wait( 0.1 )
		end
	end
end

function CanGoldifyReward( reward )
	if reward.ResourceCosts ~= nil and HasResourceCost( reward.ResourceCosts ) then
		return false
	end
	return IsFateValid() and reward.GoldConversionEligible and GetTotalHeroTraitValue( "BoonConversionUses" ) > 0
end

function GetRewardGoldifyValue( reward )
	if HasHeroTraitValue("BlockMoney") then
		return 0
	end
	local value = reward.GoldifyValue or 100
	if reward.AddBoostedAnimation then
		value = value + 150
	end
	return round( value * GetTotalHeroTraitValue("MoneyMultiplier", { IsMultiplier = true }))
end